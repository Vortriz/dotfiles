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
            "mode",
            f"{set_width}x{set_height}@{set_refresh_rate}",
        ]
    )
    await notifier.send(
        title="Display", message=f"Changed refresh rate to {set_refresh_rate:.0f}Hz"
    )


fo = json.loads(
    subprocess.run(
        ["niri", "msg", "--json", "focused-output"], capture_output=True, text=True
    ).stdout
)

modes = fo["modes"]
current_mode = fo["current_mode"]

set_mode = (current_mode + 1) % len(modes)
set_width = modes[set_mode]["width"]
set_height = modes[set_mode]["height"]
set_refresh_rate = modes[set_mode]["refresh_rate"] / 1000

current_display = fo["name"]


asyncio.run(main())
