#!/usr/bin/env bash
#
# Copyright (C) 2019 @alanndz (Telegram and Github)
# Copyright (C) 2019 HANA-CI Build Project (@nicklas373)
# SPDX-License-Identifier: GPL-3.0-or-later

git clone --depth=1 -b dev/shizuka https://github.com/Nicklas373/kernel_xiaomi_msm8953-3.18-2 .

wget --output-document=.circle-clang-mido.sh https://raw.githubusercontent.com/Nicklas373/Semaphore-CI/semaphore-setup/circle-clang-mido.sh

chmod +x .circle-clang-mido.sh
bash ./.circle-clang-mido.sh
