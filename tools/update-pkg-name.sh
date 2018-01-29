#!/bin/bash

# Update namespace from Qt5 to deepin.

set -x

QT_INSTALL_PREFIX=$PWD/debian/tmp/usr
ARCH_LIB=/x86_64-linux-gnu
QT_INSTALL_LIBS=${QT_INSTALL_PREFIX}/lib${ARCH_LIB}
QT_INSTALL_HEADERS=${QT_INSTALL_PREFIX}/include${ARCH_LIB}/qt5
QT_INSTALL_ARCHDATA=${QT_INSTALL_LIBS}/qt5
QT_INSTALL_DATA=${QT_INSTALL_PREFIX}/share/qt5

DEEPIN_INSTALL_ARCHDATA=${QT_INSTALL_LIBS}/deepin-webengine
DEEPIN_INSTALL_HEADERS=${QT_INSTALL_PREFIX}/include${ARCH_LIB}/deepin-webengine
DEEPIN_INSTALL_DATA=${QT_INSTALL_PREFIX}/share/deepin-webengine
DEEPIN_INSTALL_LIBEXEC=${DEEPIN_INSTALL_ARCHDATA}/libexec

# Move dynamic libraries
updateLibs() {
  cd ${QT_INSTALL_LIBS}
  cp -f libQt5WebEngineCore.so.5.6.1 libDeepinWebEngineCore.so.5.6.1 && \
  ln -sf libDeepinWebEngineCore.so.5.6.1 libDeepinWebEngineCore.so.5.6 && \
  ln -sf libDeepinWebEngineCore.so.5.6 libDeepinWebEngineCore.so.5 && \
  ln -sf libDeepinWebEngineCore.so.5 libDeepinWebEngineCore.so && \
  cp -f libQt5WebEngineWidgets.so.5.6.1 libDeepinWebEngineWidgets.so.5.6.1 && \
  ln -sf libDeepinWebEngineWidgets.so.5.6.1 libDeepinWebEngineWidgets.so.5.6 && \
  ln -sf libDeepinWebEngineWidgets.so.5.6 libDeepinWebEngineWidgets.so.5 && \
  ln -sf libDeepinWebEngineWidgets.so.5 libDeepinWebEngineWidgets.so
}

# Move bin.
updateBins() {
  mkdir -pv ${DEEPIN_INSTALL_ARCHDATA} && \
  rm -rf ${DEEPIN_INSTALL_ARCHDATA}/bin && \
  cp -rf ${QT_INSTALL_ARCHDATA}/bin ${DEEPIN_INSTALL_ARCHDATA}
}

# Move libexec.
updateLibexec() {
  mkdir -pv ${DEEPIN_INSTALL_ARCHDATA} && \
  rm -rf ${DEEPIN_INSTALL_ARCHDATA}/libexec && \
  cp -rf ${QT_INSTALL_ARCHDATA}/libexec ${DEEPIN_INSTALL_ARCHDATA}
}

# Move resources and translations
updateResources() {
  mkdir -pv ${DEEPIN_INSTALL_DATA} && \
  rm -rf ${DEEPIN_INSTALL_DATA}/resources && \
  cp -rf ${QT_INSTALL_DATA}/resources ${DEEPIN_INSTALL_DATA} && \
  rm -rf ${DEEPIN_INSTALL_DATA}/translations && \
  cp -rf ${QT_INSTALL_DATA}/translations ${DEEPIN_INSTALL_DATA}
}

# Move headers
updateHeaders() {
  mkdir -pv ${DEEPIN_INSTALL_HEADERS} && \
  rm -rf ${DEEPIN_INSTALL_HEADERS}/* && \
  cp -rf ${QT_INSTALL_HEADERS}/* ${DEEPIN_INSTALL_HEADERS}
}

# Update pkgconfig
updatePkgConfig() {
  cp -rf ${QT_INSTALL_LIBS}/pkgconfig/Qt5WebEngineCore.pc \
    ${QT_INSTALL_LIBS}/pkgconfig/DeepinWebEngineCore.pc && \
  cp -rf ${QT_INSTALL_LIBS}/pkgconfig/Qt5WebEngineWidgets.pc \
    ${QT_INSTALL_LIBS}/pkgconfig/DeepinWebEngineWidgets.pc && \
  sed -i 's/Qt5WebEngine/DeepinWebEngine/g' ${QT_INSTALL_LIBS}/pkgconfig/*pc
}

# Update cmake
updateCmake() {
  rm -rf ${QT_INSTALL_LIBS}/cmake/DeepinWebEngineCore && \
  cp -rf ${QT_INSTALL_LIBS}/cmake/Qt5WebEngineCore \
    ${QT_INSTALL_LIBS}/cmake/DeepinWebEngineCore && \
  rm -rf ${QT_INSTALL_LIBS}/cmake/DeepinWebEngineWidgets && \
  cp -rf ${QT_INSTALL_LIBS}/cmake/Qt5WebEngineWidgets \
    ${QT_INSTALL_LIBS}/cmake/DeepinWebEngineWidgets && \
  find ${QT_INSTALL_LIBS}/cmake -type f | \
    xargs sed -i -e 's/libQt5WebEngine/libDeepinWebEngine/g' \
    -e "s:${ARCH_LIB}/qt5:${ARCH_LIB}/deepin-webengine:g" \
    -e "s:cmake/Qt5:cmake/Deepin:g"
}

main() {
  updateLibs && \
  updateBins && \
  updateLibexec && \
  updateResources && \
  updateHeaders && \
  updatePkgConfig && \
  updateCmake
}

main
