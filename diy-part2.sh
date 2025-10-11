#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#

# Modify default IP
echo "ℹ️ Default LAN IP: $DEFAULT_LAN"
echo "ℹ️ Input LAN IP: $LAN_IP"
sed -i "s|$DEFAULT_LAN|$LAN_IP|g" "$CONFIG_LAN_FILE"

if grep -q "$LAN_IP" "$CONFIG_LAN_FILE"; then
    echo "✅ Replacement successful"
else
    echo "❌ Replacement failed! $LAN_IP not found in $CONFIG_LAN_FILE"
    exit 1
fi

# Modify default theme
echo "ℹ️ Input theme: $DEFAULT_THEME"
sed -i "s|luci-theme-bootstrap|$DEFAULT_THEME|g" "$CONFIG_THEME_FILE"

if grep -q "$DEFAULT_THEME" "$CONFIG_THEME_FILE"; then
    echo "✅ Replacement successful"
else
    echo "❌ Replacement failed! $DEFAULT_THEME not found in $CONFIG_THEME_FILE"
    exit 1
fi

# Modify hostname
#sed -i 's/OpenWrt/P3TERX-Router/g' package/base-files/files/bin/config_generate
echo "ℹ️ Default host name: $DEFAULT_HOSTNAME"
echo "ℹ️ Input host name: $HOSTNAME"
sed -i "s|$DEFAULT_HOSTNAME|$HOSTNAME|g" "$CONFIG_THEME_FILE"

if grep -q "$HOSTNAME" "$DEFAULT_HOSTNAME"; then
    echo "✅ Replacement successful"
else
    echo "❌ Replacement failed! $HOSTNAME not found in $DEFAULT_HOSTNAME"
    exit 1
fi

# update_name(){  
#     local old_name=$1  
#     local new_name=$2  
#     if grep -r "$old_name" . > /dev/null; then  
#         echo -e "✅ 找到 $old_name，开始替换为 $new_name"  
#         grep -rl "$old_name" . | xargs -r sed -i "s?$old_name?$new_name?g"  
#     else  
#         echo -e "ℹ️ 未找到 $old_name，跳过替换"  
#     fi  
# }
# update_name "终端" "TTYD"
# update_name "TTYD 终端" "TTYD"
# update_name "网络存储" "NAS"
# update_name "实时流量监测" "流量监测"
# update_name "KMS 服务器" "KMS"
# update_name "USB 打印服务器" "打印服务"
# update_name "Web 管理" "Web管理"
# #update_name "管理权" "账号管理"
# update_name "带宽监控" "监控"

echo "✅ diy-part2.sh execution completed"
