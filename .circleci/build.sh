#!/usr/bin/env bash
#
# Copyright (C) 2019 @alanndz (Telegram and Github)
# Copyright (C) 2019 HANA-CI Build Project (@nicklas373)
# SPDX-License-Identifier: GPL-3.0-or-later

git clone --depth=1 -b dev/yukina-q-eas https://github.com/Nicklas373/kernel_xiaomi_lavender .

wget --output-document=.circle-clang-lavender.sh https://raw.githubusercontent.com/Nicklas373/Semaphore-CI/semaphore-setup/circle-clang-lavender.sh

chmod +x .circle-clang-lavender.sh
bash ./.circle-clang-lavender.sh
