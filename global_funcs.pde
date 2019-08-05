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
  PFont font;
  font = createFont("font1.ttf", 45);
  
  if (font != null) textFont(font);
}

void reset(){
 freeStuffUp();
 delay(2000);
 thread("init");
}

void updateInfoDisplay() {
  background(backColor);
  fill(0);
  textAlign(CENTER);
  textSize(50);
  text("Updating Information, Please Wait...", width / 2, height / 2);
  textAlign(LEFT);
}

void displayOffline(){
   background(backColor);
  fill(0);
  textAlign(CENTER, CENTER);
  textSize(30);
  text("Cannot Connect to Servers. Please check connection", width / 2, height / 2);
  noLoop();
}
