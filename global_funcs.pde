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

boolean initFont() throws RuntimeException {
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
    prevSecond = second();
    return;
  }

  if (secondChanged) secondChanged = false;
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

public String getPathToParshaContent() {
  return config.getString("url") + "/parsha/" + parsha + "/" + (today.getDay() + 1);
}

public void setParsha(String url) throws RuntimeException {
  String text = getTextFromRSS(url);
  try {
    parsha = getParsha(text);
  } 
  catch (RuntimeException e) {
    throw new RuntimeException("Error parsing Parsha Information\n Please contact ShulScreen Support");
  }
}

public void initParsha() {
  setParsha("https://www.chabad.org/tools/rss/parsha_rss.xml");
}

void initJsons() throws RuntimeException {
  try {
    config = loadJSONObject("config.json");
  } 
  catch (RuntimeException e) {
    throw new RuntimeException("Error loading configuration file\n Check \"config.json\"");
  }
}

void startingInits() {
  try {
    initJsons();
    initFont();
    init();
  } 
  catch (RuntimeException e) {
    generalMessage(e.getMessage());
  }
}
