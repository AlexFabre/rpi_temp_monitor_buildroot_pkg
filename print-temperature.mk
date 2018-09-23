################################################################################
#
# print-temperature
#
################################################################################

PRINT_TEMPERATURE_VERSION     = origin/master
PRINT_TEMPERATURE_SITE        = git://github.com/AlexFabre/rpi_temp_monitor
PRINT_TEMPERATURE_SITE_METHOD = git
PRINT_TEMPERATURE_INSTALL_TARGET = YES
PRINT_TEMPERATURE_DEPENDENCIES = rgb-led-matrix

define PRINT_TEMPERATURE_BUILD_CMDS
	$(MAKE) CC=$(TARGET_CC) CXX=$(TARGET_CXX) AR=$(TARGET_AR) -C $(@D) all
endef

define PRINT_TEMPERATURE_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/rpi_monitor_temp $(TARGET_DIR)/usr/bin
endef

define PRINT_TEMPERATURE_INSTALL_INIT_SYSTEMD
	$(INSTALL) -D -m 0755 package/print-temperature/print_temp.service \
		$(TARGET_DIR)/usr/lib/systemd/system/print_temp.service
	ln -sf $(TARGET_DIR)/usr/lib/systemd/system/print_temp.service \
		$(TARGET_DIR)/etc/systemd/system/multi-user.target.wants
endef

$(eval $(generic-package))