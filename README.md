# EonLash

EonLash is a World of Warcraft addon that scans your characters stats and armory to be displayed on a remote website.

https://github.com/acidtib/EonLash/assets/1427640/fef87feb-9fcb-40bb-8493-5c4b3e2a6f1b


## Main Features

### Self Scan
The `/eon` command will scan your character and display a window where you can press CTRL/C to copy the information. The information is BASE64 encoded for easier transfer.

The `/eon clear` command will scan your character and display a window where you can press CTRL/C to copy the information. The information is in Plain TEXT.

### Population Scan
The `/eon scan` command will turn on passive scan, any player you mouseover will be saved.

The `/eon scan.stop` command will turn off passive scan.

Information from passive scan will be saved to `EonLash.lua` located at
```
C:\Program Files (x86)\World of Warcraft\_classic_era_\WTF\Account\xxxxxxx#x\SavedVariables
```