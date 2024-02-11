KERNEL_SRC = $(shell pwd)/../linux
BUILD_DIR := $(shell pwd)
DTC_DIR = /usr/bin
VERBOSE = 1

OBJS    = i-sabre-codec.o i-sabre-k2m.o

obj-m := $(OBJS)

all:
	make -C $(KERNEL_SRC) M=$(BUILD_DIR) KBUILD_VERBOSE=$(VERBOSE) modules

clean:
	make -C $(KERNEL_SRC) SUBDIRS=$(BUILD_DIR) clean
	rm -f i-sabre-k2m-overlay.dtb
	rm -f i-sabre-k2m.dtbo

dtbs:
	$(DTC_DIR)/dtc -@ -I dts -O dtb -o i-sabre-k2m-overlay.dtb i-sabre-k2m-overlay.dts
	$(DTC_DIR)/dtc -@ -H epapr -I dts -O dtb -o i-sabre-k2m.dtbo i-sabre-k2m-overlay.dts

modules_install:
	cp i-sabre-codec.ko /lib/modules/$(shell uname -r)/kernel/sound/soc/codecs/
	cp i-sabre-k2m.ko /lib/modules/$(shell uname -r)/kernel/sound/soc/bcm/
	depmod -a

modules_remove:
	rm /lib/modules/$(shell uname -r)/kernel/sound/soc/codecs/i-sabre-codec.ko
	rm /lib/modules/$(shell uname -r)/kernel/sound/soc/bcm/i-sabre-k2m.ko
	depmod -a

install:
	modprobe i-sabre-codec
	modprobe i-sabre-k2m

remove:
	modprobe -r i-sabre-k2m
	modprobe -r i-sabre-codec

# Kernel 4.1.y
install_dtb:
	cp i-sabre-k2m-overlay.dtb /boot/overlays/

# Kernel 6.6.y
install_dtbo:
	cp i-sabre-k2m.dtbo /boot/overlays/

remove_dtb:
	rm -f /boot/overlays/i-sabre-k2m-overlay.dtb
	rm -f /boot/overlays/i-sabre-k2m.dtbo
