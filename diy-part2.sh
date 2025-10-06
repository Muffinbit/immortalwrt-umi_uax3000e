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

# 修改插件名字
update_name(){  
    local old_name=$1  
    local new_name=$2  
    if grep -r "$old_name" . > /dev/null; then  
        echo -e "✅ 找到 $old_name，开始替换为 $new_name"  
        grep -rl "$old_name" . | xargs -r sed -i "s?$old_name?$new_name?g"  
    else  
        echo -e "ℹ️ 未找到 $old_name，跳过替换"  
    fi  
}
# 替换插件名字
update_name "终端" "TTYD"
update_name "TTYD 终端" "TTYD"
update_name "网络存储" "NAS"
update_name "实时流量监测" "流量监测"
update_name "KMS 服务器" "KMS"
update_name "USB 打印服务器" "打印服务"
update_name "Web 管理" "Web管理"
# update_name "管理权" "账号管理"
update_name "带宽监控" "监控"

# 验证配置文件是否存在
if [ -f ".config" ]; then
    echo "✅ .config文件配置行数: $(wc -l .config | awk '{print $1}')"
else
    echo "ℹ️ 未找到.config文件" >&2
    exit 1
fi

# 显示最终配置文件信息
echo "✅ diy-part2.sh 执行完成"
