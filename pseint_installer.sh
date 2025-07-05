#!/usr/bin/env bash

###--------------------------------------
# Pseint Installer
###--------------------------------------

#-----------------------------------------------------
# Variables
#-----------------------------------------------------
# Only set colors, if tput available and TERM is recognized
if [[ $(command -v tput) && $(tput setaf 1 2>/dev/null) ]]; then
  RED=$(tput setaf 1)
  GREEN=$(tput setaf 2)
  RESET=$(tput sgr0)
fi
INSTALL_DIR="${HOME}/.pseint"   # default installation directory
URL="http://prdownloads.sourceforge.net/pseint/pseint-l64-20250314.tgz?download"

showLogo() {
  echo "${GREEN}                                     "
  echo "${GREEN}                     .__        __    "
  echo "${GREEN}______  ______ ____  |__| _____/  |_  "
  echo "${GREEN}\____ \/  ___// __ \ |  |/    \   __\ "
  echo "${GREEN}|  |_> >___ \ \ ___/ |  |   |  \  |   "
  echo "${GREEN}|   __/____  > \___> |__|___|  /__|   "
  echo "${GREEN}|__|       \/     \/        \/       "
  echo "Linux PSEINT Installer"
  echo "${RESET}"
}

DownloadFile(){
wget --quiet --show-progress --progress=bar:force:noscroll --directory-prefix="${INSTALL_DIR}" "$URL" || {
    echo "${RED}Error: Failed to download $URL${RESET}"
    exit 1
  }
}

UnTar() {
  tar -xzf "${INSTALL_DIR}/$(basename "$URL")" -C "${INSTALL_DIR}"|| {
    echo "${RED}Error: Failed to extract the downloaded file${RESET}"
    exit 1
  }
}

Icon() {
  local icon_path="${INSTALL_DIR}/pseint/imgs/icon128.png"
  if [[ -f "$icon_path" ]]; then
    echo "${GREEN}Icon found at: $icon_path${RESET}"
  else
    echo "${RED}Icon not found.${RESET}"
  fi
}

MenuDesktopEntry() {
  local desktop_entry="${HOME}/.local/share/applications/pseint.desktop"
  echo "[Desktop Entry]" > "$desktop_entry"
  echo "Name=Pseint" >> "$desktop_entry"
  echo "Comment=Programador de pseudocódigo" >> "$desktop_entry"
  echo "Exec=${INSTALL_DIR}/pseint/pseint" >> "$desktop_entry"
  echo "Icon=${INSTALL_DIR}/pseint/imgs/icon128.png" >> "$desktop_entry"
  echo "Terminal=false" >> "$desktop_entry"
  echo "Type=Application" >> "$desktop_entry"
  echo "Categories=Development;" >> "$desktop_entry"
}

showLogo
DownloadFile
UnTar
Icon
MenuDesktopEntry