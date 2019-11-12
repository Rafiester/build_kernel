#!/usr/bin/env bash
#
# Copyright (C) 2019 @alanndz (Telegram and Github)
# Copyright (C) 2019 HANA-CI Build Project (@nicklas373)
# SPDX-License-Identifier: GPL-3.0-or-later

# Unified aliases
#
# 0 = Mido || 1 = Lavender
#
CODENAME="0";

if [ "$CODENAME" == "1" ];
	then
		# Only clone kernel source earlier for lavender
		git clone --depth=1 -b toyama  https://github.com/Nicklas373/kernel_xiaomi_lavender .
fi

# Clone compiler script & execute it
wget --output-document=.circle-clang.sh https://raw.githubusercontent.com/Nicklas373/Semaphore-CI/semaphore-setup/circle-clang.sh
chmod +x .circle-clang.sh
bash ./.circle-clang.sh

