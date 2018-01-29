%modules = ( # path to module name map
    "DeepinWebEngine" => "$basedir/src/webengine",
    "DeepinWebEngineWidgets" => "$basedir/src/webenginewidgets",
    "DeepinWebEngineCore" => "$basedir/src/core",
);
%moduleheaders = ( # restrict the module headers to those found in relative path
    "DeepinWebEngine" => "api",
    "DeepinWebEngineWidgets" => "api",
    "DeepinWebEngineCore" => "api",
);
%classnames = (
);
