CXX_MODULE = qml
TARGET = deepinwebengineplugin
TARGETPATH = DeepinWebEngine
IMPORT_VERSION = 1.5

QT += deepinwebengine qml quick
QT_PRIVATE += deepinwebengine-private

INCLUDEPATH += $$QTWEBENGINE_ROOT/src/core $$QTWEBENGINE_ROOT/src/core/api $$QTWEBENGINE_ROOT/src/webengine $$QTWEBENGINE_ROOT/src/webengine/api $$QTWEBENGINE_ROOT/include/DeepinWebEngine

SOURCES = plugin.cpp

load(qml_plugin)
