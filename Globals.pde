import http.requests.*;
import java.util.Date;

final color backColor = color(200);
final color textColor1 = color(193, 139, 0); //light yellow / gold
final color textColor2 = color(23, 42, 80); //very dark blue
final String version = "beta.1.1";

Theme theme;
Zmanim zmanim;

boolean secondChanged;
int prevSecond;
boolean updateAvailable;
boolean license;
JSONObject config;
PFont font, font2, font3;
String parsha;
String errMsg;
Date today;
