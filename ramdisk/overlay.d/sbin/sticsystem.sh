#!/system/bin/sh
#扩容电池修改区域,官方电池请不要进行任何修改操作!
#charge_full对应充满容量,charge_full_design对应电池设计容量
#例如您的电池是3600mah,那你输入的数值应该是电池容量*1000,也就是3600000.
#使用前记得把下面3行代码前的"#"号删除掉,否则无法生效!
#echo '3500000' > /sys/class/power_supply/bms/charge_full
#echo '3500000' > /sys/class/power_supply/bms/charge_full_design
#echo '3400' > /sys/module/stickernel/parameters/battery_full