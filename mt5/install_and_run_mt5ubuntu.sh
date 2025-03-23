#!/bin/bash
winecfg -v=win10
wineboot -i
/usr/bin/wine64 /root/.wine/drive_c/Program\ Files/MetaTrader\ 5\ Exness/exness5setup.exe /auto
