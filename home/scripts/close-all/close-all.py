import json
import subprocess

windows = json.loads(
    subprocess.run(
        ["niri", "msg", "--json", "windows"], capture_output=True, text=True
    ).stdout
)

for window in windows:
    subprocess.run(
        ["niri", "msg", "action", "close-window", "--id", str(window["id"])],
    ).stdout
