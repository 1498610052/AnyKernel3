## AnyKernel setup
# begin properties
properties() { '
kernel.string=Fiee-Kernel 
do.devicecheck=1
do.modules=0
do.systemless=1
do.cleanup=1
do.cleanuponabort=0
device.name1=
device.name2=
supported.versions=
'; } # end properties

# shell variables
block=/dev/block/bootdevice/by-name/boot;
is_slot_device=0;
ramdisk_compression=auto;

## AnyKernel methods (DO NOT CHANGE)
# import patching functions/variables - see for reference
. tools/ak3-core.sh;

## AnyKernel file attributes
# set permissions/ownership for included ramdisk files
chmod -R 750 $ramdisk/*;
chown -R root:root $ramdisk/*;

## AnyKernel install
dump_boot;
# begin ramdisk changes

if [ ! -d .backup ]; then
  $bin/magiskpolicy --load sepolicy --save sepolicy \
  "allow init proc file { open write }" \
  "allow init rootfs file execute_no_trans" \
  "allow init sysfs file { open write }" \
  "allow init sysfs_devices_system_cpu file write" \
  "allow init sysfs_graphics file { open write }" \
  "allow init default_prop property_service { set }" \
  ;
fi

grep "import /init.qcom.rc" init.rc >/dev/null || sed -i '1,/.*import.*/s/.*import.*/import \/init.qcom.rc\n&/' init.rc
# end ramdisk changes

write_boot;

if [ -z $(cat /system/vendor/etc/fstab.qcom | grep 'fileencryption=ice') ]; then
  mv -f $home/system/vendor/etc/fstab.qcom.noice $home/system/vendor/etc/fstab.qcom;
else
  rm -f $home/system/vendor/etc/fstab.qcom.noice;
fi
chmod -R 644 $home/system/;

mount -o rw,remount -t auto /system;
cp -rf $home/system/* /system/;
#rm -f /system/vendor/bin/init.qcom.post_boot.sh;
chmod 755 /system/app/*
chmod 755 /system/vendor/etc/perf;
chmod 755 /system/vendor/etc/wifi;
chmod 644 /system/vendor/etc/perf/*;
chmod 644 /system/vendor/etc/wifi/*;
chown root:shell /system/vendor/etc/perf;
chown root:shell /system/vendor/etc/wifi;
chown root:root /system/vendor/etc/perf/*;
chown root:root /system/vendor/etc/wifi/*;
mount -o ro,remount -t auto /system;

## end install
