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

# Uncomment a feed source
#sed -i 's/^#\(.*helloworld\)/\1/' feeds.conf.default

# Add a feed source
echo 'src-git istore https://github.com/linkease/istore.git' >>feeds.conf.default

echo "✅ custom feed added"

clone_package() {
    local repo=$1
    local dir=$2
    
    if [ -d "$dir" ]; then
        echo "⚠️ Package $dir already exists, removing old version and re-cloning..."
        rm -rf "$dir" || {
            echo "❌ Failed to remove old version $dir!"
            exit 1
        }
    fi
    
GIT_CLONE_OUTPUT=$(git clone --depth 1 "$repo" "$dir" 2>&1)
CLONE_EXIT_CODE=$?
if [ $CLONE_EXIT_CODE -eq 0 ]; then
    echo -e "✅ Successfully cloned package: $repo to $dir!"
else
    echo -e "❌ Failed to clone package: $repo to $dir!"
    echo -e "❌ Error message: $GIT_CLONE_OUTPUT"
    exit 1
fi
}

#clone_package "https://github.com/gdy666/luci-app-lucky.git" "package/luci-app-lucky"

echo "✅ diy-part1.sh execution completed"
