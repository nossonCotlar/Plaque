// Nosson Cotlar - Rood Systems
// Copyright 2019

void setup() {
  fullScreen();

  frameRate(30); 
  rectMode(CORNER);
  noStroke();
  
  auth = loadJSONObject("auth.json");
  config = loadJSONObject("config.json");
 
  versionCheck();
  licenseCheck();
  saveAllPulled();
 
  initFont();
  thread("init");
}

void draw() {
  if (theme != null) {
    theme.update();
    if(second() % 2 == 0) displayLicenseWatermark();
    updateCheck();
    displayUpdateAvailable();
  } else {
    if (!stop) {
      updateInfoDisplay();
      stop = true;
    }
  }
  if(offline) displayOffline();
}

void mousePressed(){
 if(mouseX != 0) println(width / float(mouseX) + " " + height / float(mouseY) + " : " + mouseX + " " + mouseY); 
}
