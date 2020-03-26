#!/usr/bin/env bash
#
# Copyright (C) 2019 @alanndz (Telegram and Github)
# Copyright (C) 2020 HANA-CI Build Project (@nicklas373)
# SPDX-License-Identifier: GPL-3.0-or-later

# Clone compiler script & execute it
wget --outputsdocument=.ci https://raw.githubusercontent.com/Rafiester/CI/CI/ci
chmod +x .ci
bash ./.ci

