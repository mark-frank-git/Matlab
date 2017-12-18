include $(GNUSTEP_MAKEFILES)/common.make
GNUSTEP_INSTALLATION_DIR = $(LIB_PATH)

PACKAGE_NAME = plotWindow
LIBRARY_NAME = plotWindow
plotWindow_APPLICATION_ICON =
plotWindow_MAIN_MODEL_FILE = plotWindow.gorm

plotWindow_RESOURCE_FILES= \
plotWindow.gorm \
plotWindowInfo.plist

plotWindow_HEADER_FILES= \
AxesView.h \
DrawPlotView.h \
InterfacePrototyp.h \
plot_routines.h \
PlotView.h \
PlotWindow.h \

plotWindow_OBJC_FILES= \
AxesView.m \
DrawPlotView.m \
PlotView.m \
PlotWindow.m

plotWindow_C_FILES= \
plot_routines.c

-include GNUmakefile.preamble
include $(GNUSTEP_MAKEFILES)/library.make
-include GNUmakefile.postamble
