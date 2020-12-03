# dayz-sa-mod-manager
DayZ SA Mod manager

Description:

The file, start.bat will read modlist.txt and use steamcmd to download and setup the mods. Modwatch runs in parallel in the background, checking to see if any mods in the modlist have updated recently. If so, it issues a reboot to Windows. start.bat will update the mods every time it starts. This also copies over the keys for the mods. Some additional setup for the mods may be required (see individual mods readme files). 

Requirements:
1. steamcmd
2. DayZ Server 
3. Python 2.x/3.x

How to use:

1. use pip to install the following modules:
  - pip install beaitifulsoup
  - pip install pyquery
  - pip install datetime ( possibly bundled with python? )
2. Edit the paths in start.bat to match your server and steamcmd location/dayz server location (ignore BE[battleeye] stuff)
3. Add start.bat and modwatch.pi shortcuts to your startup folder
4. go to each mods page on steam and see if there is any configuration needed  
4. After setting up expansion mod, copy the types.xml and events.xml files into SERVERROOT/mpmissions/Expansion.ChernarusPlus/db/ 
