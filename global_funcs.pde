void keyPressed() {
  if (key == 'p') saveFrame("/ScreenShots/save.png"); 
  if (key == 'r') {
    reset();
  }
}

void init() throws RuntimeException {
  try {
    today = new Date();

    initParsha();
    setFromMainPost();

    theme = new Theme();

    //delay(4000);
    System.gc();
  } 
  catch (RuntimeException e) {
    throw e;
  }
}

void updateCheck() {
  if (secondChanged) {
    if (hour() == config.getInt("updateTime") && minute() == 0 && second() == 0) {
      reset();
    }
  }
}

void displayUpdateAvailable() {
  if (!secondChanged) return;
  if (updateAvailable) {
    textAlign(LEFT, CENTER);
    fill(0);
    textSize(height / 47);
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
  try{ init(); } catch(Exception e) {errMsg = e.getMessage();}
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
    //thread("init");
  } 
  catch (RuntimeException e) {
    errMsg = e.getMessage();
    //generalMessage(e.getMessage());
    println(e.getMessage());
  }
}

void waiting(){
  background(backColor);
  fill(0);
  textSize(height / 15);
  textAlign(CENTER, CENTER);
  text("ShulScreen is fetching your information\nThanks for waiting", width / 2, height / 2);
}

void err(){
  if(errMsg != null){
    background(backColor);
   generalMessage(errMsg); 
  }
}
