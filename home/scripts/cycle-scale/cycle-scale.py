import json
import asyncio
import subprocess

from desktop_notifier import DesktopNotifier


async def main() -> None:
    notifier = DesktopNotifier(app_name="Niri", app_icon=None)

    subprocess.run(
        [
            "niri",
            "msg",
            "output",
            current_display,
            "scale",
            str(set_scale),
        ]
    )
    await notifier.send(title="Display", message=f"Changed scale to {set_scale}")


scales = (1.0, 1.5)

fo = json.loads(
    subprocess.run(
        ["niri", "msg", "--json", "focused-output"], capture_output=True, text=True
    ).stdout
)

current_scale = fo["logical"]["scale"]
set_scale = scales[(scales.index(current_scale) + 1) % len(scales)]

current_display = fo["name"]


asyncio.run(main())
