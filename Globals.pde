import http.requests.*;

final color backColor = color(200);
final color textColor1 = color(193, 139, 0); //light yellow / gold
final color textColor2 = color(23, 42, 80); //very dark blue
final String version = "alpha.1.3";

Theme theme;

boolean stop = false;
boolean updateAvailable;
boolean license;
boolean offline;
JSONObject config;
String parsha;
Date today;
