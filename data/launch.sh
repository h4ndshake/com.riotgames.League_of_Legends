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

declare -ra WINE_PACKAGES=(winxp corefonts d3dx9)
declare -ra WINE_SETTINGS=('csmt=on' 'fontsmooth=rgb' 'glsl=disabled' 'grabfullscreen=y' 'mwo=enabled')

set_wine_settings() {
  echo "Installing wine requirements..."
  winetricks --unattended "${WINE_PACKAGES[@]}"

  echo "Setting wine settings..."
  winetricks --unattended "${WINE_SETTINGS[@]}"

  echo "Configuring DLL Overrides"
  "${WINE}" reg add 'HKEY_CURRENT_USER\Software\Wine\DllOverrides' /v api-ms-win-core-console-l1-1-0.dll /d native,builtin /f
  "${WINE}" reg add 'HKEY_CURRENT_USER\Software\Wine\DllOverrides' /v api-ms-win-core-datetime-l1-1-0.dll /d native,builtin /f
  "${WINE}" reg add 'HKEY_CURRENT_USER\Software\Wine\DllOverrides' /v api-ms-win-core-debug-l1-1-0.dll /d native,builtin /f
  "${WINE}" reg add 'HKEY_CURRENT_USER\Software\Wine\DllOverrides' /v api-ms-win-core-errorhandling-l1-1-0.dll /d native,builtin /f
  "${WINE}" reg add 'HKEY_CURRENT_USER\Software\Wine\DllOverrides' /v api-ms-win-core-file-l1-1-0.dll /d native,builtin /f
  "${WINE}" reg add 'HKEY_CURRENT_USER\Software\Wine\DllOverrides' /v api-ms-win-core-file-l1-2-0.dll /d native,builtin /f
  "${WINE}" reg add 'HKEY_CURRENT_USER\Software\Wine\DllOverrides' /v api-ms-win-core-file-l2-1-0.dll /d native,builtin /f
  "${WINE}" reg add 'HKEY_CURRENT_USER\Software\Wine\DllOverrides' /v api-ms-win-core-handle-l1-1-0.dll /d native,builtin /f
  "${WINE}" reg add 'HKEY_CURRENT_USER\Software\Wine\DllOverrides' /v api-ms-win-core-heap-l1-1-0.dll /d native,builtin /f
  "${WINE}" reg add 'HKEY_CURRENT_USER\Software\Wine\DllOverrides' /v api-ms-win-core-interlocked-l1-1-0.dll /d native,builtin /f
  "${WINE}" reg add 'HKEY_CURRENT_USER\Software\Wine\DllOverrides' /v api-ms-win-core-libraryloader-l1-1-0.dll /d native,builtin /f
  "${WINE}" reg add 'HKEY_CURRENT_USER\Software\Wine\DllOverrides' /v api-ms-win-core-localization-l1-2-0.dll /d native,builtin /f
  "${WINE}" reg add 'HKEY_CURRENT_USER\Software\Wine\DllOverrides' /v api-ms-win-core-memory-l1-1-0.dll /d native,builtin /f
  "${WINE}" reg add 'HKEY_CURRENT_USER\Software\Wine\DllOverrides' /v api-ms-win-core-namedpipe-l1-1-0.dll /d native,builtin /f
  "${WINE}" reg add 'HKEY_CURRENT_USER\Software\Wine\DllOverrides' /v api-ms-win-core-processenvironment-l1-1-0.dll /d native,builtin /f
  "${WINE}" reg add 'HKEY_CURRENT_USER\Software\Wine\DllOverrides' /v api-ms-win-core-processthreads-l1-1-0.dll /d native,builtin /f
  "${WINE}" reg add 'HKEY_CURRENT_USER\Software\Wine\DllOverrides' /v api-ms-win-core-processthreads-l1-1-1.dll /d native,builtin /f
  "${WINE}" reg add 'HKEY_CURRENT_USER\Software\Wine\DllOverrides' /v api-ms-win-core-profile-l1-1-0.dll /d native,builtin /f
  "${WINE}" reg add 'HKEY_CURRENT_USER\Software\Wine\DllOverrides' /v api-ms-win-core-rtlsupport-l1-1-0.dll /d native,builtin /f
  "${WINE}" reg add 'HKEY_CURRENT_USER\Software\Wine\DllOverrides' /v api-ms-win-core-string-l1-1-0.dll /d native,builtin /f
  "${WINE}" reg add 'HKEY_CURRENT_USER\Software\Wine\DllOverrides' /v api-ms-win-core-synch-l1-1-0.dll /d native,builtin /f
  "${WINE}" reg add 'HKEY_CURRENT_USER\Software\Wine\DllOverrides' /v api-ms-win-core-synch-l1-2-0.dll /d native,builtin /f
  "${WINE}" reg add 'HKEY_CURRENT_USER\Software\Wine\DllOverrides' /v api-ms-win-core-sysinfo-l1-1-0.dll /d native,builtin /f
  "${WINE}" reg add 'HKEY_CURRENT_USER\Software\Wine\DllOverrides' /v api-ms-win-core-timezone-l1-1-0.dll /d native,builtin /f
  "${WINE}" reg add 'HKEY_CURRENT_USER\Software\Wine\DllOverrides' /v api-ms-win-core-util-l1-1-0.dll /d native,builtin /f
  "${WINE}" reg add 'HKEY_CURRENT_USER\Software\Wine\DllOverrides' /v api-ms-win-crt-conio-l1-1-0.dll /d native,builtin /f
  "${WINE}" reg add 'HKEY_CURRENT_USER\Software\Wine\DllOverrides' /v api-ms-win-crt-convert-l1-1-0.dll /d native,builtin /f
  "${WINE}" reg add 'HKEY_CURRENT_USER\Software\Wine\DllOverrides' /v api-ms-win-crt-environment-l1-1-0.dll /d native,builtin /f
  "${WINE}" reg add 'HKEY_CURRENT_USER\Software\Wine\DllOverrides' /v api-ms-win-crt-filesystem-l1-1-0.dll /d native,builtin /f
  "${WINE}" reg add 'HKEY_CURRENT_USER\Software\Wine\DllOverrides' /v api-ms-win-crt-heap-l1-1-0.dll /d native,builtin /f
  "${WINE}" reg add 'HKEY_CURRENT_USER\Software\Wine\DllOverrides' /v api-ms-win-crt-locale-l1-1-0.dll /d native,builtin /f
  "${WINE}" reg add 'HKEY_CURRENT_USER\Software\Wine\DllOverrides' /v api-ms-win-crt-math-l1-1-0.dll /d native,builtin /f
  "${WINE}" reg add 'HKEY_CURRENT_USER\Software\Wine\DllOverrides' /v api-ms-win-crt-multibyte-l1-1-0.dll /d native,builtin /f
  "${WINE}" reg add 'HKEY_CURRENT_USER\Software\Wine\DllOverrides' /v api-ms-win-crt-private-l1-1-0.dll /d native,builtin /f
  "${WINE}" reg add 'HKEY_CURRENT_USER\Software\Wine\DllOverrides' /v api-ms-win-crt-process-l1-1-0.dll /d native,builtin /f
  "${WINE}" reg add 'HKEY_CURRENT_USER\Software\Wine\DllOverrides' /v api-ms-win-crt-runtime-l1-1-0.dll /d native,builtin /f
  "${WINE}" reg add 'HKEY_CURRENT_USER\Software\Wine\DllOverrides' /v api-ms-win-crt-stdio-l1-1-0.dll /d native,builtin /f
  "${WINE}" reg add 'HKEY_CURRENT_USER\Software\Wine\DllOverrides' /v api-ms-win-crt-string-l1-1-0.dll /d native,builtin /f
  "${WINE}" reg add 'HKEY_CURRENT_USER\Software\Wine\DllOverrides' /v api-ms-win-crt-time-l1-1-0.dll /d native,builtin /f
  "${WINE}" reg add 'HKEY_CURRENT_USER\Software\Wine\DllOverrides' /v api-ms-win-crt-utility-l1-1-0.dll /d native,builtin /f
  "${WINE}" reg add 'HKEY_CURRENT_USER\Software\Wine\DllOverrides' /v concrt140.dll /d native,builtin /f
  "${WINE}" reg add 'HKEY_CURRENT_USER\Software\Wine\DllOverrides' /v d3dcompiler_47.dll /d native,builtin /f
  "${WINE}" reg add 'HKEY_CURRENT_USER\Software\Wine\DllOverrides' /v msvcp140.dll /d native,builtin /f
  "${WINE}" reg add 'HKEY_CURRENT_USER\Software\Wine\DllOverrides' /v ucrtbase.dll /d native,builtin /f
  "${WINE}" reg add 'HKEY_CURRENT_USER\Software\Wine\DllOverrides' /v vcruntime140.dll /d native,builtin
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
}

# Main function
startup() {
  if ! [ -f "${LEAGUE_CLIENT}" ]; then
    echo "League of Legends isn't installed."
    first_run
  fi

  echo "Starting League of Legends..."
  "${WINE}" "${LEAGUE_CLIENT}"
}

startup
