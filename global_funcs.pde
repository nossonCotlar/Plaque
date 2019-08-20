void keyPressed() {
  if (key == 'p') saveFrame("/ScreenShots/save.png"); 
  if (key == 'r') {
    reset();
  }
}

void init() throws RuntimeException {
  try {
    versionCheck();
    licenseCheck();
    saveAllPulled();

    today = new Date();
    theme = new Theme();

    //delay(4000);
    System.gc();
  } 
  catch (RuntimeException e) {
    throw e;
  }
}

void updateCheck() {
  if (hour() == config.getInt("updateTime") && minute() == 0 && second() == 0) {
    reset();
  }
  if (minute() % 5 == 0 && second() == 0) System.gc();
}

void versionCheck() throws RuntimeException {
  GetRequest get = new GetRequest(config.getString("url") + "/version");
  
  get.send();

  if (get.getContent() == null) {
    throw new RuntimeException("Couldn't reach ShulScreen Server\n Please try reloading or contact Shulscreen Support");
  }
  if (get.getContent().contains(version)) return;
  updateAvailable = true;
}

void displayUpdateAvailable() {
  if (updateAvailable) {
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

boolean initFont() throws RuntimeException{
  try {
    font = createFont("font1.ttf", 45);
    font2 = createFont("font2.otf", 45);
    font3 = createFont("font3.otf", 45);
    textFont(font3);
    textFont(font2);
    textFont(font);
  } 
  catch (RuntimeException e) {
    throw new RuntimeException("There's an issue with one of the fonts\n Please check the \"data\" folder");
  }
  return true;
}

void reset() {
  freeStuffUp();
  delay(2000);
  init();
}

void detectSecondChanged() {
  if (prevSecond != second()) {
    secondChanged = true;
    return;
  }
  prevSecond = second();
  if (!secondChanged) secondChanged = true;
}

void generalMessage(String s) {
  background(backColor);
  fill(0);
  textFont(createFont("Calibri", 45));
  textAlign(CENTER, CENTER);
  textSize(height / 15);
  text(s, width / 2, height / 2);
  textAlign(LEFT);
  noLoop();
}

void updateInfoDisplay() {
  generalMessage("Updating Information, Please Wait...");
}

void displayOffline() {
  generalMessage("Cannot Connect to Servers. Please check connection");
  noLoop();
}

public String getPathToParshaContent() {
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
