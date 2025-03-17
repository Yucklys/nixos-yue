import os
from urllib.request import urlopen

config.load_autoconfig()

# Download theme if it doesn't exist
if not os.path.exists(config.configdir / "theme.py"):
    theme = "https://raw.githubusercontent.com/Linuus/nord-qutebrowser/master/nord-qutebrowser.py"
    with urlopen(theme) as themehtml:
        with open(config.configdir / "theme.py", "a") as file:
            file.writelines(themehtml.read().decode("utf-8"))

# Load theme
if os.path.exists(config.configdir / "theme.py"):
    config.source("theme.py")
