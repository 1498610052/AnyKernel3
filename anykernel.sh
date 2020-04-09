# AnyKernel3 Ramdisk Mod Script
# osm0sis @ xda-developers

## AnyKernel setup
# begin properties
properties() { '
kernel.string=SticKernel 小米MIX 2S内核 27稳定版
kernel.a=
kernel.b=
kernel.c=
do.devicecheck=1
do.modules=0
do.cleanup=1
do.cleanuponabort=0
device.name1=polaris

'; } # end properties

# shell variables
block=/dev/block/bootdevice/by-name/boot;
is_slot_device=0;
ramdisk_compression=auto;

## AnyKernel methods (DO NOT CHANGE)
# import patching functions/variables - see for reference
. tools/ak3-core.sh;
ui_print "SticKernel 内核信息:";
ui_print "Linux 内核版本:4.9.218-Stic-r27-gf941f937";
ui_print "内核构建者:builder@ota-sq183-server";
ui_print "编译时间:#1 Wed Apr 8 15:50:11 CST 2020";
ui_print "内核编译器:clang version 11.0 (SticCompiler-12.9.0)";
mount -o rw,remount /vendor
#mount -o rw,remount /system
cp -rf /tmp/anykernel/patch/msm_irqbalance.conf /vendor/etc/msm_irqbalance.conf;
cp -rf /tmp/anykernel/patch/WCNSS_qcom_cfg.ini /vendor/etc/wifi/WCNSS_qcom_cfg.ini;
#cp -rf /tmp/anykernel/patch/polaris/polaris.xml /system/etc/device_features/polaris.xml;
set_perm 0 0 0644 /vendor/etc/msm_irqbalance.conf;
set_perm 0 0 0644 /vendor/etc/wifi/WCNSS_qcom_cfg.ini;
#set_perm 0 0 0644 /system/etc/device_features/polaris.xml;
mount -o ro,remount /vendor
#mount -o ro,remount /system
#删除WiFi日志
rm -rf /data/vendor/wlan_logs
#开机第一屏logo
dd if=logo.img of=/dev/block/bootdevice/by-name/logo
ui_print "正在清理磁盘碎片,请耐心等待...";
fstrim /data;
fstrim /cache;
fstrim /system;
fstrim /system_root;
fstrim /persist;
fstrim /cust;
fstrim /vendor;
sleep 3;

## AnyKernel file attributes
# set permissions/ownership for included ramdisk files
set_perm_recursive 0 0 755 755 $ramdisk/*;

## AnyKernel install
dump_boot;
# begin ramdisk changes
if [ -d $ramdisk/.backup ]; then
  patch_cmdline "skip_override" "skip_override";
else
  patch_cmdline "skip_override" "";
fi;

ui_print " ";
ui_print "SticKernel已成功安装到您的手机!";
ui_print "欢迎关注作者酷安@Amktiao";
ui_print " "
ui_print "※※※ 内核温馨提示 ※※※";
ui_print "1.刷完内核需要再在刷一遍Magisk 20.x来保留Root权限";
ui_print "2.如遇到卡第一屏无法启动的问题,长按电源键重启手机即可";
ui_print "3.可以搬运,但不要将内核进行售卖,一经发现,后果自负";
ui_print "4.开机之后不要操作手机,请等待10秒应用脚本后方可使用手机";

# end ramdisk changes
write_boot;

sleep 5;