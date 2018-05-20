#!/bin/bash

export WINEPREFIX="${XDG_DATA_HOME}/wineprefix"

export MESA_GLTHREAD=true
export __GL_THREADED_OPTIMIZATIONS=1

export __PBA_CB_HEAP=64
export __PBA_GEO_HEAP=256

WINE="/usr/bin/wine"

LOL_INSTALLER_NAME="LeagueClientInstallerNA.exe"
LOL_SETUP="${XDG_CACHE_HOME}/${LOL_INSTALLER_NAME}"
LOL_DOWNLOAD_URL="https://riotgamespatcher-a.akamaihd.net/releases/live/installer/deploy/League%20of%20Legends%20installer%20NA.exe"
LEAGUE_CLIENT="${WINEPREFIX}/drive_c/Riot Games/League of Legends/LeagueClient.exe"
DLLOVERRIDES="/app/dlloverrides.reg"

VERSION_NUM="0.1.0"
VERSION_FILE="${WINEPREFIX}/.lolversion"

declare -ra WINE_PACKAGES=(winxp corefonts d3dx9)
declare -ra WINE_SETTINGS=('csmt=on' 'fontsmooth=rgb' 'glsl=disabled' 'grabfullscreen=y' 'mwo=enabled')

set_wine_settings() {
  echo "Installing wine requirements..."
  winetricks --unattended "${WINE_PACKAGES[@]}"

  echo "Setting wine settings..."
  winetricks --unattended "${WINE_SETTINGS[@]}"

  echo "Configuring DLL Overrides"
  "${WINE}" regedit /S "${DLLOVERRIDES}"
}

# Run only if LoL isn't installed
first_run() {
  wineboot

  set_wine_settings

  if [ ! -f "${LOL_SETUP}" ]; then
    echo "Downloading League of Legends installer..."
    curl --progress-bar --output "${LOL_SETUP}" "${LOL_DOWNLOAD_URL}"
  fi

  echo "Running League of Legends installer..."
  "${WINE}" "${LOL_SETUP}"

  echo "${VERSION_NUM}" > "${VERSION_FILE}"
}

is_updated() {
  if [ -f "${VERSION_FILE}" ]; then
    last_version="$(cat "${VERSION_FILE}")"
  else
    last_version="0"
  fi

  echo "${VERSION_NUM}" > "${VERSION_FILE}"

  if [[ "${VERSION_NUM}" == "${last_version}" ]]; then
    return 0
  else
    return 1
  fi
}

# Main function
startup() {
  if ! [ -f "${LEAGUE_CLIENT}" ]; then
    echo "League of Legends isn't installed."
    first_run
  else
    if ! is_updated; then
      echo "Not up to date, re-run wine settings."
      set_wine_settings
    fi
  fi

  echo "Starting League of Legends..."
  "${WINE}" "${LEAGUE_CLIENT}"
}

startup
