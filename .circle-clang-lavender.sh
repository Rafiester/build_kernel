#!bin/bash
#
# Copyright 2019, Najahiiii <najahiii@outlook.co.id>
# Copyright 2019, Dicky Herlambang "Nicklas373" <herlambangdicky5@gmail.com>
# Copyright 2016-2019, HANA-CI Build Project
# Copyright 2019, alanndz <alanmahmud0@gmail.com>
#
# Clarity Kernel Builder Script || For Circle CI
#
# This software is licensed under the terms of the GNU General Public
# License version 2, as published by the Free Software Foundation, and
# may be copied, distributed, and modified under those terms.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#

# Let's make some option here
#
# Kernel Relase
# 0 = BETA || 1 = Stable
KERNEL_BRANCH_RELEASE="1"

# Cloning AnyKernel Repository
git clone https://github.com/Nicklas373/AnyKernel3 -b lavender

# Create Temporary Folder
mkdir TEMP

# Kernel Enviroment
export ARCH=arm64
export LD_LIBRARY_PATH="/root/clang/bin/../lib:$PATH"
export KBUILD_BUILD_USER=Yukina
export KBUILD_BUILD_HOST=Circle-CI

# Kernel aliases
IMAGE="$(pwd)/out/arch/arm64/boot/Image.gz-dtb"
KERNEL="$(pwd)"
KERNEL_TEMP="$(pwd)/TEMP"
CODENAME="lavender"
BRANCH="lavender"
KERNEL_CODE="Lavender"
KERNEL_REV="r8"
TELEGRAM_DEVICE="Xiaomi Redmi Note 7"
KERNEL_NAME="Clarity"
KERNEL_SUFFIX="Kernel"
KERNEL_TYPE="EAS"
KERNEL_STATS="signed"
KERNEL_DATE="$(date +%Y%m%d-%H%M)"
if [ "$KERNEL_BRANCH_RELEASE" == "1" ];
	then
		KERNEL_RELEASE="Stable"
elif [ "$KERNEL_BRANCH_RELEASE" == "0" ];
	then
		KERNEL_RELEASE="BETA"
fi

# Telegram aliases
TELEGRAM_BOT_ID="882513869:AAGu8crueJQlsvLWH119zugCGpIxEYwEHj0"
if [ "$KERNEL_BRANCH_RELEASE" == "1" ];
	then
		TELEGRAM_GROUP_ID="-1001336252759"
elif [ "$KERNEL_BRANCH_RELEASE" == "0" ];
	then
		TELEGRAM_GROUP_ID="-1001251953845"
fi
TELEGRAM_FILENAME="${KERNEL_NAME}-${KERNEL_SUFFIX}-${KERNEL_CODE}-${KERNEL_REV}-${KERNEL_TYPE}-${KERNEL_STATS}-${KERNEL_DATE}.zip"
export TELEGRAM_SUCCESS="CAADBQADhQcAAhIzkhBQ0UsCTcSAWxYE"
export TELEGRAM_FAIL="CAADBQADfgcAAhIzkhBSDI8P9doS7BYE"

# Import telegram bot environment
function bot_env() {
TELEGRAM_KERNEL_VER=$(cat ${KERNEL}/out/.config | grep Linux/arm64 | cut -d " " -f3)
TELEGRAM_UTS_VER=$(cat ${KERNEL}/out/include/generated/compile.h | grep UTS_VERSION | cut -d '"' -f2)
TELEGRAM_COMPILER_NAME=$(cat ${KERNEL}/out/include/generated/compile.h | grep LINUX_COMPILE_BY | cut -d '"' -f2)
TELEGRAM_COMPILER_HOST=$(cat ${KERNEL}/out/include/generated/compile.h | grep LINUX_COMPILE_HOST | cut -d '"' -f2)
TELEGRAM_TOOLCHAIN_VER=$(cat ${KERNEL}/out/include/generated/compile.h | grep LINUX_COMPILER | cut -d '"' -f2)
}

# Telegram Bot Service || Compiling Notification
function bot_template() {
curl -s -X POST https://api.telegram.org/bot${TELEGRAM_BOT_ID}/sendMessage -d chat_id=${TELEGRAM_GROUP_ID} -d "parse_mode=HTML" -d text="$(
            for POST in "${@}"; do
                echo "${POST}"
            done
          )"
}

# Telegram bot message || first notification
function bot_first_compile() {
bot_template  "<b>|| Circle-CI Build Bot ||</b>" \
              "" \
              "<b>Clarity Kernel build Start!</b>" \
              "" \
	      "<b>Build Status :</b><code> ${KERNEL_RELEASE} </code>" \
	      "" \
              "<b>Device :</b><code> ${TELEGRAM_DEVICE}</code>" \
              "" \
              "<b>Latest commit :</b><code> $(git --no-pager log --pretty=format:'"%h - %s (%an)"' -1)</code>"
}

# Telegram bot message || complete compile notification
function bot_complete_compile() {
bot_env
bot_template  "<b>|| Circle-CI Build Bot ||</b>" \
    "" \
    "<b>New Clarity Kernel Build Is Available!</b>" \
    "" \
    "<b>Build Status :</b><code> ${KERNEL_RELEASE} </code>" \
    "" \
    "<b>Device :</b><code> ${TELEGRAM_DEVICE}</code>" \
    "" \
    "<b>Filename :</b><code> ${TELEGRAM_FILENAME}</code>" \
    "" \
    "<b>Kernel Version:</b><code> Linux ${TELEGRAM_KERNEL_VER}</code>" \
    "" \
    "<b>Kernel Host:</b><code> ${TELEGRAM_COMPILER_NAME}@${TELEGRAM_COMPILER_HOST}</code>" \
    "" \
    "<b>Kernel Toolchain :</b><code> ${TELEGRAM_TOOLCHAIN_VER}</code>" \
    "" \
    "<b>UTS Version :</b><code> ${TELEGRAM_UTS_VER}</code>" \
    "" \
    "<b>Latest commit :</b><code> $(git --no-pager log --pretty=format:'"%h - %s (%an)"' -1)</code>" \
    "" \
    "<b>Compile Time :</b><code> $(($DIFF / 60)) minute(s) and $(($DIFF % 60)) second(s)</code>" \
    "" \
    "<b>                         HANA-CI Build Project | 2016-2019                            </b>"
}

# Telegram bot message || success notification
function bot_build_success() {
bot_template  "<b>|| Circle-CI Build Bot ||</b>" \
              "" \
              "<b>Clarity Kernel build Success!</b>"
}

# Telegram sticker message
function sendStick() {
	curl -s -X POST https://api.telegram.org/bot$TELEGRAM_BOT_ID/sendSticker -d sticker="${1}" -d chat_id=$TELEGRAM_GROUP_ID &>/dev/null
}

# Telegram bot message || failed notification
function bot_build_failed() {
bot_template "<b>|| Circle-CI Build Bot ||</b>" \
              "" \
              "<b>Clarity Kernel build Failed!</b>" \
              "" \
              "<b>Compile Time :</b><code> $(($DIFF / 60)) minute(s) and $(($DIFF % 60)) second(s)</code>"
}

# Compile Begin
function compile() {
	bot_first_compile
        START=$(date +"%s")
        make -s lavender_defconfig O=out
        PATH="/root/clang/bin:${PATH}" \
        make -s -j$(nproc --all) O=out \
                        CC=clang \
			CLANG_TRIPLE=aarch64-linux-gnu- \
		        CROSS_COMPILE=aarch64-linux-gnu- \
			CROSS_COMPILE_ARM32=arm-linux-gnueabi-
	if ! [ -a $IMAGE ]; then
                echo "kernel not found"
                END=$(date +"%s")
                DIFF=$(($END - $START))
                bot_build_failed
		sendStick "${TELEGRAM_FAIL}"
                exit 1
        fi
        END=$(date +"%s")
        DIFF=$(($END - $START))
	bot_build_success
	sendStick "${TELEGRAM_SUCCESS}"
        cp ${IMAGE} AnyKernel3/Image.gz-dtb
	anykernel
	kernel_upload
}

# AnyKernel
function anykernel() {
        cd AnyKernel3
        make -j4
        mv Clarity-Kernel-${KERNEL_CODE}-signed.zip  ${KERNEL_TEMP}/${KERNEL_NAME}-${KERNEL_SUFFIX}-${KERNEL_CODE}-${KERNEL_REV}-${KERNEL_TYPE}-${KERNEL_STATS}-${KERNEL_DATE}.zip
}

# Upload Kernel
function kernel_upload(){
	cd ${KERNEL}
	bot_complete_compile
        curl -F chat_id=${TELEGRAM_GROUP_ID} -F document="@${KERNEL_TEMP}/${KERNEL_NAME}-${KERNEL_SUFFIX}-${KERNEL_CODE}-${KERNEL_REV}-${KERNEL_TYPE}-${KERNEL_STATS}-${KERNEL_DATE}.zip"  https://api.telegram.org/bot${TELEGRAM_BOT_ID}/sendDocument
}

# Running
compile

