#/bin/bash
cd `dirname $0`  #进入脚本目录
export XAUTHORITY=/home/pi/.Xauthority
export DISPLAY=:0.0  #拉取图形界面环境变量
sleep 10 #等待系统图形界面启动完成
xdotool mousemove 400 400 click 1 #挪动鼠标，点击
while(true)
do
sleep 2
xdotool mousemove 71 34 #挪动鼠标，点击
sleep 1
xlocal=`xdotool getmouselocation|awk -F '[ :]' '{print$2}'` #检查鼠标是否挪动到位
if [ $xlocal -eq 71 ];then
	break;
fi
done
sleep 1
xdotool click 1
xdotool click 1 click 1 #点击播放按钮
python ./start.py   #开始监听GPIO按键事件
