#!/system/bin/sh
# 电池容量更改为默认仓库值
chmod 0755 /sys/class/power_supply/bms/charge_full
chmod 0755 /sys/class/power_supply/bms/charge_full_design
chmod 0755 /dev/stune/background/schedtune.boost
chmod 0755 /dev/stune/foreground/schedtune.boost
chmod 0755 /dev/stune/top-app/schedtune.boost
chmod 0755 /dev/stune/top-app/schedtune.boost
chmod 0755 /dev/stune/top-app/schedtune.boost
chmod 0755 /dev/stune/foreground/schedtune.boost
chmod 0755 /sys/devices/system/cpu/cpu0/cpufreq/schedutil/up_rate_limit_us
chmod 0755 /sys/devices/system/cpu/cpu4/cpufreq/schedutil/up_rate_limit_us
chmod 0755 /sys/devices/system/cpu/cpu0/cpufreq/schedutil/down_rate_limit_us
chmod 0755 /sys/devices/system/cpu/cpu4/cpufreq/schedutil/down_rate_limit_us
chmod 0755 /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
chmod 0755 /sys/devices/system/cpu/cpu4/cpufreq/scaling_max_freq
# 设置sdm845大核默认最高频率
echo '2649600' > /sys/devices/system/cpu/cpu4/cpufreq/scaling_max_freq
# 设置充电最高电流(危险)
#echo '4000000' > /sys/class/power_supply/battery/constant_charge_current_max