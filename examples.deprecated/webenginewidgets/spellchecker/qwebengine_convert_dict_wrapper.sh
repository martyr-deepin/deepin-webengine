#!/bin/sh
QT_WEBENGINE_ICU_DATA_DIR=/home/liulang/dev/deepin/deepin-webengine/src/tools/qwebengine_convert_dict/../../../src/core/Release
export QT_WEBENGINE_ICU_DATA_DIR
LD_LIBRARY_PATH=/usr/lib/x86_64-linux-gnu${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}
export LD_LIBRARY_PATH
QT_PLUGIN_PATH=/usr/lib/x86_64-linux-gnu/qt5/plugins${QT_PLUGIN_PATH:+:$QT_PLUGIN_PATH}
export QT_PLUGIN_PATH
exec /home/liulang/dev/deepin/deepin-webengine/bin/qwebengine_convert_dict "$@"
