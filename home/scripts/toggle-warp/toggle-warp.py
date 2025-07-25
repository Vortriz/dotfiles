import asyncio
import json
import subprocess

from desktop_notifier import DesktopNotifier


async def main(status) -> None:
    notifier = DesktopNotifier(app_name="Cloudflare Warp", app_icon=None)

    if status == "Connected":
        subprocess.run(["warp-cli", "disconnect"])
        await notifier.send(title="Daemon", message="Disconnecting...")
    else:
        subprocess.run(["warp-cli", "connect"])
        await notifier.send(title="Daemon", message="Connecting...")


status = json.loads(
    subprocess.run(["warp-cli", "-j", "status"], capture_output=True, text=True).stdout
)["status"]

asyncio.run(main(status))
