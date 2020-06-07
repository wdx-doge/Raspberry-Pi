# -*- coding: utf-8 -*-
import RPi.GPIO as GPIO #调入GPIO库
import time #调入时间库
import os
GPIO.setmode(GPIO.BCM)
GPIO.setup(17,GPIO.IN) #将17脚设置为输入
GPIO.setup(17,GPIO.IN,pull_up_down=GPIO.PUD_UP)
#将17脚设置成有上拉模式，此处使用软件上拉 ，也可以硬件实现上拉电阻。
GPIO.setup(27,GPIO.OUT) #将17脚设置为输出
while True: #循环执行
    inputValue = GPIO.input(17) #读取键值
    if(inputValue==0):
      os.popen("./next.sh")
      #读取键值按下执行netx.sh脚本
      time.sleep(2)
      #睡眠2秒，防止按键抖动造成执行多次的问题
      os.close("./next.sh")
    time.sleep(0.1) 
