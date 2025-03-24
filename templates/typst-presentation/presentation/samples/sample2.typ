#import "@preview/touying:0.5.3": *
#import "@preview/curryst:0.3.0" as curryst: rule

#import "theme.typ": *

#show: university-theme.with(
  config-colors(
    primary: primary-color,
    secondary: secondary-color,
    tertiary: tertiary-color,
    neutral-darkest: text-color
  ),
  config-info(
    title: [Modern Type Theory],
    subtitle: [An introduction to modern dependent type theory],
    author: [BSc. Ridan Vandenbergh],
    date: datetime.today(),
    institution: [KU Leuven],
  ),
)

#set heading(numbering: "1.")

#title-slide()
#counter(heading).update(5)

= Standard types

== Dependent product type

#definition("Π-types")[
  The *dependent function type*, also known as _dependent products_ or Π-types, contain functions whose codomain type may vary based on the terms of its domain.

  Π-types are formed as follows:

  #inf-rules(
    rule($Γ⊢Π(A,B) type$, $Γ⊢A type$, $Γ.A ⊢ B type$)
  )
]

#inf-rules(
  inset: 0%,
  rule($Γ⊢λ(b):Π(A,B)$, $Γ⊢A type$, $Γ.A ⊢ b:B$),
  rule($Γ⊢f" "a:B[id . a]$, $Γ⊢a:A$, $Γ.A⊢B type$, $Γ⊢f:Π(A,B)$)
)