#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part1.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)
#

# 添加feed源函数
add_feed() {
    local name=$1
    local url=$2
    # 检查feeds.conf.default中是否已包含该源
    if ! grep -q "src-git $name $url" feeds.conf.default; then
        echo "添加feed源：$name，地址：$url"
        echo "src-git $name $url" >> feeds.conf.default
    else
        echo "ℹ️ feed源 $name 已存在，跳过添加"
    fi
}

# 添加istore和nas_luci源
add_feed "istore" "https://github.com/linkease/istore.git;main"

# 克隆第三方包函数
clone_package() {
    local repo=$1
    local dir=$2
    
    # 如果目录已存在，先删除（强制覆盖）
    if [ -d "$dir" ]; then
        echo "⚠️ 包 $dir 已存在，删除旧版本并重新克隆..."
        rm -rf "$dir" || {
            echo "❌ 删除旧版本 $dir 失败！"
            exit 1
        }
    fi
    
    # 执行克隆（无论之前是否存在目录）
GIT_CLONE_OUTPUT=$(git clone --depth 1 "$repo" "$dir" 2>&1)
CLONE_EXIT_CODE=$?
if [ $CLONE_EXIT_CODE -eq 0 ]; then
    echo -e "✅ 克隆包：$repo 到 $dir 成功！"
else
    echo -e "❌ 克隆包：$repo 到 $dir 失败！"
    echo -e "❌ 错误信息：$GIT_CLONE_OUTPUT"
    exit 1
fi
}

# 克隆所需第三方包
clone_package "https://github.com/gdy666/luci-app-lucky.git" "package/luci-app-lucky"

echo "✅ diy-part1.sh 执行完成"
