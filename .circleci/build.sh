#!/usr/bin/env bash
#
# Copyright (C) 2019 @alanndz (Telegram and Github)
# Copyright (C) 2019 HANA-CI Build Project (@nicklas373)
# SPDX-License-Identifier: GPL-3.0-or-later

# Declare Device ID's
#
# Device Name
# 1 = Lavender || 0 = Mido
#
DEVICE_NAME="1"

if [ "$DEVICE_NAME" == "0" ];
	then
		wget --output-document=.circle-clang-mido.sh https://raw.githubusercontent.com/Nicklas373/Semaphore-CI/semaphore-setup/circle-clang-mido.sh
		chmod +x .circle-clang-mido.sh
		bash ./.circle-clang-mido.sh
elif [ "$DEVICE_NAME" == "1" ];
	then
		git clone --depth=1 -b yukina  https://github.com/Nicklas373/kernel_xiaomi_lavender .
		wget --output-document=.circle-clang-lavender.sh https://raw.githubusercontent.com/Nicklas373/Semaphore-CI/semaphore-setup/circle-clang-lavender.sh
		chmod +x .circle-clang-lavender.sh
		bash ./.circle-clang-lavender.sh
fi
