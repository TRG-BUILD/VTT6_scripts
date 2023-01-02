""" Test url to links for downloads """
import requests

LINK_FILE: str = "win_variables.bat"

if __name__ == "__main__":
    with open(LINK_FILE, "r") as fp:
        for line in fp.readlines():
            line = line.replace("\n", "")
            seg_line = line.split(" ")

            if not seg_line[0] == "set":
                continue

            seg_set = seg_line[1].split("=")
            if not seg_set[0].endswith("_url"):
                continue

            url = seg_set[1]
            with requests.get(url, stream=True) as r:
                print(r.status_code, url)

                if not r.status_code == 200:
                    print(f"{url} is not found")
