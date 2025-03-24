#let current-heading(level: auto, outlined: true) = {
  let here = here()
  query(heading.where(outlined: outlined).before(inclusive: false, here))
    .at(-1, default: none)
}

#let headings-context(target: heading.where(outlined: true)) = {
  let current-heading = current-heading()
  
  let headings = query(target)
  let path = ()
  let level = 0
  let current-heading-idx = none

  let result = ()

  for hd in headings {
    let diff = hd.level - level
    if diff > 0 {
      for _ in range(diff) {
        path.push(1)
      }
    } else {
      for _ in range(-diff) {
        let _ = path.pop()
      }
      path.at(-1) = path.at(-1) + 1
    }

    result.push((
      path: path,
      heading: hd
    ))

    if current-heading != none and hd.location() == current-heading.location() { // matching on location, otherwise this will be `true` for an identical heading at another location
      current-heading-idx = result.len() - 1
    }
    
    level = hd.level
  }

  return (
    current-heading: current-heading,
    current-heading-idx: current-heading-idx,
    headings: result
  )
}

/// Create an outline that allows you to filter entries and style them based on context.
/// 
/// `filter` is a boolean function that accepts a single argument `hd` which is a dict of:
///   - `here-path`: array = the unique 'path' for the most recently defined heading at the current location in the document.
///   - `here-level`: integer = `here-path.len()`, the depth of the aforementioned heading.
///   - `level`: integer = the depth of the being filtered heading
///   - `path`: array = the path, as previously described, of the being filtered heading
///   - `relation`: dict of booleans describing how this heading relates to the 'here' heading
///     - `same` = this heading IS the 'here' heading
///     - `parent` = this heading is a direct parent of the 'here' heading
///     - `child` = this heading is a direct child of the 'here' heading
///     - `sibling` = this heading is at the same level of, and shares the parent of the 'here' heading
///     - `unrelated` = `true` if none of the other relations are `true`.
///   - loc: location = `heading.location()`
///   - heading: element = the actual heading element `hd` was created from
/// 
/// `transform` is a function taking two arguments `hd` and `it`, used to define a custom show-rule for `outline.entry`:
///   - `hd` is a heading dict with the same structure as in `filter`
///   - `it` is the `outline.entry` element being shown
#let custom-outline(
  filter: hd => true,
  transform: (_, it) => it,
  target: heading.where(outlined: true),
  ..args
) = context {
  let cx = headings-context(target: target)
  let idx = cx.at("current-heading-idx", default: none)
  let scope-path = if idx != none {
    cx.headings.at(idx).path
  }

  let headings = cx.headings.map(hd => {
    let level = hd.path.len()

    let relation = if scope-path != none {
      let path-len = calc.min(level, scope-path.len())
      let common-path = hd.path.slice(0, path-len) == scope-path.slice(0, path-len)

      let same = hd.path == scope-path
      let parent = not same and common-path and level < scope-path.len()
      let child = not same and common-path and level > scope-path.len()
      let sibling = not same and level == scope-path.len() and hd.path.slice(0, path-len - 1) == scope-path.slice(0, path-len - 1)

      (
        same: same,
        parent: parent,
        child: child,
        sibling: sibling,
        unrelated: not same and not parent and not child and not sibling,
      )
    }
    
    (
      here-path: scope-path,
      here-level: if scope-path != none { scope-path.len() },
      level: level,
      path: hd.path,
      relation: relation,
      loc: hd.heading.location(),
      heading: hd.heading
    )
  }).filter(filter)

  if headings == () {
    let nonsense-target = selector(<P>).and(<NP>)
    outline(target: nonsense-target, ..args)
    return
  }

  let find-heading(location) = {
    for x in headings { // forgive me :(
      if x.loc == location {
        return x
      }
    }
  }

  show outline.entry: it => {
    let hd = find-heading(it.element.location())
    transform(hd, it)
  }

  let selection = selector(headings.at(0).loc)
  for idx in range(1, headings.len()) {
    selection = selection.or(headings.at(idx).loc)
  }

  outline(target: selection, ..args)
}