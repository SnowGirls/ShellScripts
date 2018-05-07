#!/bin/bash

# ./file.sh
# . ./file.sh


usbmuxd_client_path=~/Workspaces/Softwares/iOSReverse/usbmuxd-1.0.8/python-client
cd $usbmuxd_client_path

#./tcprelay.py -t 22:2222 &
#ssh_port_job_index=`jobs | grep "tcprelay.py -t 22:2222" | awk -F '+' '{print $1}' | sed 's/\[\(.*\)\]/\1/'`
#fg $ssh_port_job_index

#osascript -e 'tell application "Terminal" to activate' -e 'tell application "System Events" to tell process "Terminal" to keystroke "t" using command down' -e 'tell application "Terminal" to do script "echo hello" in selected tab of the front window'
#do shell script "cd ${usbmuxd_client_path}" in selected tab of the front window


#python ./tcprelay.py -t 22:2222
osascript -e 'tell application "Terminal" to activate' -e 'tell application "System Events" to tell process "Terminal" to keystroke "t" using command down'
osascript -e 'tell app "Terminal"
   do script "cd ~/Workspaces/Softwares/iOSReverse/usbmuxd-1.0.8/python-client && ./tcprelay.py -t 22:2222" in selected tab of the front window 
end tell'

#ssh root@localhost -p 2222
osascript -e 'tell application "Terminal" to activate' -e 'tell application "System Events" to tell process "Terminal" to keystroke "t" using command down'
osascript -e 'tell app "Terminal"
   do script "cd ~/Workspaces/Softwares/iOSReverse/usbmuxd-1.0.8/python-client && ssh root@localhost -p 2222" in selected tab of the front window 
end tell'



#python ./tcprelay.py -t 4321:1234
osascript -e 'tell application "Terminal" to activate' -e 'tell application "System Events" to tell process "Terminal" to keystroke "n" using command down'
osascript -e 'tell app "Terminal"
   do script "cd ~/Workspaces/Softwares/iOSReverse/usbmuxd-1.0.8/python-client && ./tcprelay.py -t 4321:1234" in selected tab of the front window 
end tell'

#ssh root@localhost -p 2222
osascript -e 'tell application "Terminal" to activate' -e 'tell application "System Events" to tell process "Terminal" to keystroke "t" using command down'
osascript -e 'tell app "Terminal"
   do script "cd ~/Workspaces/Softwares/iOSReverse/usbmuxd-1.0.8/python-client && ssh root@localhost -p 2222" in selected tab of the front window 
end tell'

