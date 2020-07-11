INSTALL_TARGET_PROCESSES = SpringBoard
$(TWEAK_NAME)_FRAMEWORKS = AudioToolbox
include $(THEOS)/makefiles/common.mk

TWEAK_NAME = Ahoy

Ahoy_FILES = Tweak.x
Ahoy_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk
