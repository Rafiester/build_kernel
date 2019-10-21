#!/usr/bin/env bash
#
# Copyright (C) 2019 @alanndz (Telegram and Github)
# Copyright (C) 2019 HANA-CI Build Project (@nicklas373)
# SPDX-License-Identifier: GPL-3.0-or-later

# I'll declare this alias in the other script
#
# export RELEASE_STATUS=0
# export USECLANG=1
# export USECACHE=0
# export CODENAME="Quantum"
# export KERNEL_VERSION="1.00"
# export TYPE_KERNEL="EAS"

# Well, let ci only download standalone bash file
#
# git clone --depth=1 -b eas-q https://github.com/zxc070/kernel_xiaomi_lavender .

wget --output-document=.circle-clang-mido.sh https://raw.githubusercontent.com/Nicklas373/Semaphore-CI/semaphore-setup/circle-clang-mido.sh

chmod +x .circle-clang-mido.sh
bash ./.circle-clang-mido.sh
