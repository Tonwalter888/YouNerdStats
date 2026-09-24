# YouNerdStats
A simple tweak to enable stats for nerds in the YouTube app faster and quicker.

Please also uses/injects with [YTVideoOverlay](https://github.com/PoomSmart/YTVideoOverlay) if you want to use this tweak.

## Building
1. Install [Theos with roothide](https://github.com/roothide/Developer#update-jailbreak-appstweaks-for-roothide).
2. Clone [YouTubeHeader](https://github.com/PoomSmart/YouTubeHeader) into ``$THEOS/include``.
3. Clone [YTVideoOverlay](https://github.com/PoomSmart/YTVideoOverlay) outside the tweak folder.
4. Clone this repo, cd into it and run
- ``make clean package DEBUG=0 FINALPACKAGE=1`` For rootful jailbroken iOS (iOS <15 - checkra1n, Cydia)
- ``make clean package DEBUG=0 FINALPACKAGE=1 THEOS_PACKAGE_SCHEME=rootless`` For rootless jailbroken iOS (iOS 15+ - palera1n, Sileo, Zebra, Dolpamine, bakera1n, TrollStore)
- ``make clean package DEBUG=0 FINALPACKAGE=1 THEOS_PACKAGE_SCHEME=roothide`` For roothide jailbroken iOS (iOS 15 - Dolpamine, Bootstrap)