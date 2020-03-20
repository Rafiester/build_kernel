#!/usr/bin/env bash
#
# Copyright (C) 2019 @alanndz (Telegram and Github)
# Copyright (C) 2020 HANA-CI Build Project (@nicklas373)
# SPDX-License-Identifier: GPL-3.0-or-later

# Cloning Kernel Repository
# Only enable this if want to compile lavender
git clone --depth=1 -b fusion-eas-rama-test https://Nicklas373:$git_token@github.com/Nicklas373/kernel_xiaomi_lavender-4.4 .
# git clone --depth=1 -b 03000 https://Nicklas373:$git_token@github.com/Yasir-siddiqui/4.14 .

# Clone compiler script & execute it
wget --output-document=.ci https://raw.githubusercontent.com/Nicklas373/CI/CI/ci
chmod +x .ci
bash ./.ci

