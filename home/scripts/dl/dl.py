import os
import sys
import shutil
import subprocess
from time import sleep

import aria2p
import requests
from bs4 import BeautifulSoup

downloads_dir = "/mnt/HOUSE/downloads"
secret = ""
# with open(f"{downloads_dir}/secret", "r") as f:
#     secret = f.read().strip()


def progress(dl):
    try:
        while True:
            sleep(1)
            print(
                f"Progress: {dl.completed_length_string()}/{dl.total_length_string()} ({dl.progress_string()}), Speed: {dl.download_speed_string()}, ETA: {dl.eta_string()}            ",
                end="\r",
                flush=True,
            )
            dl.update()
            if dl.is_complete:
                break
    except KeyboardInterrupt:
        print("\nStopping download...")
        dl.pause()
        to_del = (
            True
            if input("Do you want to delete the incomplete file as well? (y/n): ")
            == "y"
            else False
        )

        dl.remove(force=True, files=to_del)
        sys.exit(1)

    return


def download(url, downloads_dir):
    downloads_base_path = f"{downloads_dir}/.tmp"

    categories = {
        "apks": ["apk"],
        "compressed": ["zip", "rar", "7z", "tar", "gz"],
        "media": ["mp4", "mkv", "avi", "flv", "mov"],
        "music": ["mp3", "flac", "wav", "ogg"],
    }

    dl = aria2.add(url)[0]

    progress(dl)

    filename = dl.name
    ext = filename.split(".")[-1]

    for category, exts in categories.items():
        if ext in exts:
            shutil.move(
                f"{downloads_base_path}/{filename}",
                f"{downloads_dir}/{category}/{filename}",
            )
            break
    else:
        print("\033[96mSort the file!\033[0m")
        sleep(2)
        subprocess.run(["superfile", downloads_base_path])

    print(f"\nDownloaded:\n\033[1m{filename}\033[0m")


def download_torrent_from_libgen(page_url, downloads_dir):
    libgen_base_url = "https://libgen.st"
    downloads_base_path = f"{downloads_dir}/.tmp"

    md5 = page_url.split("?md5=")[-1].lower()
    temp_dir = f"{downloads_base_path}/temp"

    soup = BeautifulSoup(requests.get(page_url).text, "html.parser")

    # Locate the <td> whose .string contains "Title:" using list comprehension over all <td> tags
    title_td = next(
        td for td in soup.select("td") if td.string and "Title:" in td.string
    )
    title = title_td.find_next("b").string.strip()

    # Locate the <td> whose .string contains "Author(s):"
    authors_td = next(
        td for td in soup.select("td") if td.string and "Author(s):" in td.string
    )
    authors = authors_td.find_next("b").string.strip()

    # Find the Torrent per 1000 files link
    torrent_link = (
        libgen_base_url
        + soup.find(
            "a",
            href=lambda href: href
            and "repository_torrent" in href
            and ".torrent" in href,
        )["href"][2:]
    )

    result = subprocess.run(
        f"curl -o torrent.torrent {torrent_link} && aria2c --show-files torrent.torrent",
        capture_output=True,
        text=True,
        shell=True,
    )

    for line in result.stdout.splitlines():
        if md5 in line:
            file_index = line.split("|")[0]
            break
    else:
        print("File with the specified md5 not found")

    dl = aria2.add(
        "./torrent.torrent",
        options={
            "seed-time": "0",
            "select-file": f"{file_index}",
            "dir": temp_dir,
        },
    )[0]

    progress(dl)

    torrent_dir = f"{temp_dir}/{dl.name}"
    filename = f"{authors} - {title}.pdf"

    shutil.move(f"{torrent_dir}/{md5}", f"{downloads_base_path}/{filename}")
    shutil.rmtree(temp_dir)
    os.remove("./torrent.torrent")

    print(f"\nDownloaded:\n\033[1m{filename}\033[0m")

    return


aria2 = aria2p.API(aria2p.Client(host="http://localhost", port=6800, secret=secret))

if len(sys.argv) != 2:
    print("Usage: dl <URL>")
    sys.exit(1)

url = sys.argv[1]

os.makedirs(f"{downloads_dir}/.tmp", exist_ok=True)

if "libgen" in url:
    download_torrent_from_libgen(url, downloads_dir)
else:
    download(url, downloads_dir)
