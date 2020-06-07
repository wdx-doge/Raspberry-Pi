# Raspberry-Pi
Raspberry Pi：OverLayFS+Shell+Python GPIO，Build a Linux player（允许意外断电 允许意外断电 Allow unexpected power failure）

Step1 准备工作：
    购买树莓派4B硬件（主板，风扇，HDMI，Type-c电源，读卡器，亚克力外壳，风扇，微动开关，杜邦线，T8000），下载树莓派官方镜像，利用USB Image Tool烧录TF卡，组装好树莓派。

Step2 基础配置：
    配置：配置/boot/config.txt，打开HDMI热插拔，强制打开HDMI，进入系统后，配置打开SSH，打开GPIO，关闭开机密码，安装vlc播放器，安装xdotool（模拟键鼠操作）。下载片源，生成循环播放列表，完成相关操作后，记录需要开机自启的键鼠动作（按键，鼠标操作，后续开机自启全部利用xdotool模拟实现操作），此后开机全部自动播放，按下按钮切换下一个视频。

 Step3 编写脚本：overlayRoot.sh引用自Github，其他自主编写 。

     编写video.service，设置开机自启。
内容：
[Unit]           
Description=video
After=lightdm.service systemd-logind.service
[Service]       
Type=idle
ExecStart=/bin/bash /home/pi/start.sh
[Install]       
WantedBy=multi-user.target
执行：
      cp video.service /lib/systemd/system/
      systemctl enable video.service
     编写开机自启动执行的脚本start.sh，完成开机后鼠标移动，键盘点击，监听GPIO按键时间
     strat.sh调用的Python脚本
内容：
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
     python调用的next.sh脚本
内容：
 #/bin/bash
cd `dirname $0`
export XAUTHORITY=/home/pi/.Xauthority
export DISPLAY=:0.0 #拉取图形界面环境变量
xdotool key n  #GPIO按钮按下，对应VLC快捷键N，下一曲。
    执行overlayRoot.sh将系统TF卡挂载点变成只写，后续读取操作暂时保持在内存，断电后消失。
执行
     chmod +x /sbin/overlayRoot.sh
     /sbin/overlayRoot.sh
     echo "init=/sbin/overlayRoot.sh" >> /boot/cmdline.txt
     vim /etc/fstab 修改各个分区为只读。
安装按钮，胶水一封，哦吼，有了.
