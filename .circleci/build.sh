#!/usr/bin/env bash
#
# Copyright (C) 2019 @alanndz (Telegram and Github)
# Copyright (C) 2019 HANA-CI Build Project (@nicklas373)
# SPDX-License-Identifier: GPL-3.0-or-later

# Cloning Kernel Repository
# Only enable this if want to compile lavender
git clone --depth=1 -b toyama  https://github.com/Nicklas373/kernel_xiaomi_lavender .

# Clone compiler script & execute it
wget --output-document=.circle-unified.sh https://raw.githubusercontent.com/Nicklas373/Semaphore-CI/semaphore-setup/circle-unified.sh
chmod +x .circle-unified.sh
bash ./.circle-unified.sh

