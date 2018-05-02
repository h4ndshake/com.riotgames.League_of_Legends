#!/bin/bash

export WINEPREFIX="$XDG_DATA_HOME/wineprefix"
export WINEDLLOVERRIDES="api-ms-win-core-console-l1-1-0.dll=n,b;api-ms-win-core-datetime-l1-1-0.dll=n,b;api-ms-win-core-debug-l1-1-0.dll=n,b;api-ms-win-core-errorhandling-l1-1-0.dll=n,b;api-ms-win-core-file-l1-1-0.dll=n,b;api-ms-win-core-file-l1-2-0.dll=n,b;api-ms-win-core-file-l2-1-0.dll=n,b;api-ms-win-core-handle-l1-1-0.dll=n,b;api-ms-win-core-heap-l1-1-0.dll=n,b;api-ms-win-core-interlocked-l1-1-0.dll=n,b;api-ms-win-core-libraryloader-l1-1-0.dll=n,b;api-ms-win-core-localization-l1-2-0.dll=n,b;api-ms-win-core-memory-l1-1-0.dll=n,b;api-ms-win-core-namedpipe-l1-1-0.dll=n,b;api-ms-win-core-processenvironment-l1-1-0.dll=n,b;api-ms-win-core-processthreads-l1-1-0.dll=n,b;api-ms-win-core-processthreads-l1-1-1.dll=n,b;api-ms-win-core-profile-l1-1-0.dll=n,b;api-ms-win-core-rtlsupport-l1-1-0.dll=n,b;api-ms-win-core-string-l1-1-0.dll=n,b;api-ms-win-core-synch-l1-1-0.dll=n,b;api-ms-win-core-synch-l1-2-0.dll=n,b;api-ms-win-core-sysinfo-l1-1-0.dll=n,b;api-ms-win-core-timezone-l1-1-0.dll=n,b;api-ms-win-core-util-l1-1-0.dll=n,b;api-ms-win-crt-conio-l1-1-0.dll=n,b;api-ms-win-crt-convert-l1-1-0.dll=n,b;api-ms-win-crt-environment-l1-1-0.dll=n,b;api-ms-win-crt-filesystem-l1-1-0.dll=n,b;api-ms-win-crt-heap-l1-1-0.dll=n,b;api-ms-win-crt-locale-l1-1-0.dll=n,b;api-ms-win-crt-math-l1-1-0.dll=n,b;api-ms-win-crt-multibyte-l1-1-0.dll=n,b;api-ms-win-crt-private-l1-1-0.dll=n,b;api-ms-win-crt-process-l1-1-0.dll=n,b;api-ms-win-crt-runtime-l1-1-0.dll=n,b;api-ms-win-crt-stdio-l1-1-0.dll=n,b;api-ms-win-crt-string-l1-1-0.dll=n,b;api-ms-win-crt-time-l1-1-0.dll=n,b;api-ms-win-crt-utility-l1-1-0.dll=n,b;concrt140.dll=n,b;d3dcompiler_47.dll=n,b;msvcp140.dll=n,b;ucrtbase.dll=n,b;vcruntime140.dll=n,b"

export MESA_GLTHREAD=true
export __GL_THREADED_OPTIMIZATIONS=1

export __PBA_CB_HEAP=64
export __PBA_GEO_HEAP=256

WINE="/app/bin/wine"

LOL_INSTALLER_NAME="LeagueClient_SE.exe"
LOL_SETUP="${WINEPREFIX}/${LOL_INSTALLER_NAME}"
LOL_DOWNLOAD_URL="https://transfer.sh/i4gRe/LeagueClient_SE.exe"
LEAGUE_CLIENT="${WINEPREFIX}/drive_c/Riot Games/League of Legends/LeagueClient.exe"

VERSION_NUM="0.1.0"
VERSION_FILE="${WINEPREFIX}/.lolversion"

declare -ra WINE_PACKAGES=(corefonts d3dx9 winxp)
declare -ra WINE_SETTINGS=('csmt=on' 'fontsmooth=rgb' 'glsl=disabled' 'grabfullscreen=y' 'mwo=enabled')

echo "League of Legends Unofficial Flatpak"
echo "Version: ${VERSION_NUM}"
echo "Thanks to: GloriousEggroll, johnramsden"

set_wine_settings(){
  echo "Installing wine requirements..."
  winetricks --unattended "${WINE_PACKAGES[@]}"

  echo "Setting wine settings..."
  winetricks --unattended "${WINE_SETTINGS[@]}"
}

# Run only if LoL isn't installed
first_run(){
  set_wine_settings

  echo "${VERSION_NUM}" > "${VERSION_FILE}"

  if [ ! -f "${LOL_SETUP}" ]; then
    echo "Downloading League of Legends installer..."
    wget --output-document="${LOL_SETUP}" "${LOL_DOWNLOAD_URL}"
  fi
  
  echo "Running League of Legends installer..."
  "${WINE}" "${LOL_SETUP}"
}

is_updated(){
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
startup(){
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
