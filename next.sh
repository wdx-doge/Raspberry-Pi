 #/bin/bash
cd `dirname $0`
export XAUTHORITY=/home/pi/.Xauthority
export DISPLAY=:0.0 #拉取图形界面环境变量
xdotool key n  #GPIO按钮按下，对应VLC快捷键N，下一曲。
