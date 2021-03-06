#!/bin/bash

# Christian Orellana
# Install Plist and Bash script for Default English Login Window

### FUNCTIONS

RemoveLoginandStartHook() {

	launchctl unload -w /Library/LaunchDaemons/edu.pratt.it.chris.setEnglishLang.plist

}

removePlist() {

	rm /Library/LaunchDaemons/edu.pratt.it.chris.setEnglishLang.plist

}

removeBash() {

	rm /Library/Scripts/Pratt/pratt_it_chris_setEnglishLang.sh

}

createBashScript() {

	mkdir /Library/Scripts/Pratt
	touch /Library/Scripts/Pratt/pratt_it_chris_setEnglishLang.sh

	cat << 'EOF' >> /Library/Scripts/Pratt/pratt_it_chris_setEnglishLang.sh
#!/bin/bash

# Christian Orellana
# Set English Language at Start Up

# Simple languagesetup command:
# https://support.apple.com/en-us/HT202036

# This script will run when the computer starts up. Since a user change in langauge only takes full affect after a restart, this will run when the computer runs, resetting the login window back to English.
/usr/sbin/languagesetup -langspec English

# Login window is now in English. User account will still be in set language.

exit 0
EOF

	chown root:wheel /Library/Scripts/Pratt/pratt_it_chris_setEnglishLang.sh
	chmod 644 /Library/Scripts/Pratt/pratt_it_chris_setEnglishLang.sh
	chmod +x /Library/Scripts/Pratt/pratt_it_chris_setEnglishLang.sh

}

createPlist() {

	touch /Library/LaunchDaemons/edu.pratt.it.chris.setEnglishLang.plist

	cat << 'EOF' >> /Library/LaunchDaemons/edu.pratt.it.chris.setEnglishLang.plist
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
	<dict>
		<key>Label</key>
		<string>edu.pratt.it.chris.setEnglishLang</string>
		<key>Program</key>
		<string>/Library/Scripts/Pratt/pratt_it_chris_setEnglishLang.sh</string>
		<key>RunAtLoad</key>
		<true/>
	</dict>
</plist>
EOF

	chown root:wheel /Library/LaunchDaemons/edu.pratt.it.chris.setEnglishLang.plist
	chmod 644 /Library/LaunchDaemons/edu.pratt.it.chris.setEnglishLang.plist

}

InstallLoginHookandStartUpHook() {

	# Start Up / boot up hook
	launchctl load -w /Library/LaunchDaemons/edu.pratt.it.chris.setEnglishLang.plist

	# Log out Hook
	defaults write com.apple.loginwindow LogoutHook /Library/Scripts/Pratt/pratt_it_chris_setEnglishLang.sh
	# defaults write com.apple.loginwindow LoginHook /Library/Scripts/Pratt/pratt_it_chris_unityLicensefix.sh

}

## RUN 

RemoveLoginandStartHook
removePlist
removeBash
createBashScript
createPlist
InstallLoginHookandStartUpHook

exit 0
