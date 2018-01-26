TEMPLATE = subdirs

process.depends = core
webenginewidgets.depends = core

core.depends = buildtools

SUBDIRS += buildtools \
           core \
           process \
           webenginewidgets

use?(spellchecker):!use?(native_spellchecker):!cross_compile {
    SUBDIRS += qwebengine_convert_dict
    qwebengine_convert_dict.subdir = tools/qwebengine_convert_dict
    qwebengine_convert_dict.depends = core
}
