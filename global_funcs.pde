void keyPressed() {
  if (key == 'p') saveFrame("/ScreenShots/save.png"); 
  if (key == 'r') {
    reset();
  }
}

void init() {
  today = new Date();
  theme = new Theme();
  stop = false;
  
  delay(4000);
  System.gc();
}

void updateCheck() {
  if (hour() == config.getInt("updateTime") && minute() == 0 && second() == 0) {
    reset();
  }
  if(minute() % 5 == 0 && second() == 0) System.gc();
}

void versionCheck(){
 GetRequest get = new GetRequest(config.getString("url") + "/version");
 get.send();
 
 if(get.getContent() == null){
   offline = true;
  return;
 }
 offline = false;
 if(get.getContent().contains(version)) return;
 updateAvailable = true;
}

void displayUpdateAvailable(){
 if(updateAvailable){
  textAlign(LEFT, CENTER);
  fill(0);
  textSize(20);
  text("Update is available, please download update", 30, 30);
  
 }
}

void freeStuffUp() {
  theme.destroy();
  theme = null;
  System.gc();
  //delay(10000);
}

void initFont() {
  //PFont font;
  font = createFont("font1.ttf", 45);
  font2 = createFont("font2.otf", 45);
  font3 = createFont("font3.otf", 45);
  
  if (font != null) textFont(font);
}

void reset(){
 freeStuffUp();
 delay(2000);
 thread("init");
}

void generalMessage(String s){
  background(backColor);
  fill(0);
  textAlign(CENTER);
  textSize(height / 15);
  text(s, width / 2, height / 2);
  textAlign(LEFT);
}

void updateInfoDisplay() {
  generalMessage("Updating Information, Please Wait...");
  
}

void displayOffline(){
  generalMessage("Cannot Connect to Servers. Please check connection");
  noLoop();
}

public String getPathToParshaContent(){
  return config.getString("url") + "/parsha/" + parsha + "/" + (today.getDay() + 1);
}

public void setParsha(String url) {
  String text = getTextFromRSS(url);

  parsha = getParsha(text);
}

public void initParsha() {
    try {
      setParsha("https://www.chabad.org/tools/rss/parsha_rss.xml");
    } 
    catch(Exception e) {
      parsha = "Not Found :(";
    }
  }
