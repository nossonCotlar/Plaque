import http.requests.*;

final color backColor = color(200);
final color textColor1 = color(193, 139, 0); //light yellow / gold
final color textColor2 = color(23, 42, 80); //very dark blue
final String version = "alpha.1.5";

Theme theme;

boolean secondChanged;
int prevSecond;
boolean updateAvailable;
boolean license;
JSONObject config;
JSONObject auth;
PFont font, font2, font3;
String parsha;
Date today;
