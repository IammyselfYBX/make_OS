#!/bin/sh
bximage -hd -mode="flat" -size=10 -q hd10M.img

# bximage的参数
# -fd 创建软盘
# -hd 创建硬盘
# -mode 创建硬盘的类型，有 flat sparse growing
# -size 指创建多大的硬盘，以 MB 为单位。
# -q 以静默模式创建，创建过程中不会和用户交互。