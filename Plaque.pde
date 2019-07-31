// Nosson Cotlar - Rood Systems
// Copyright 2019

void setup() {
  fullScreen();
  frameRate(30); 
  rectMode(CORNER);
  noStroke();
  
  config = loadJSONObject("config.json");
  licenseCheck();
  initFont();
  thread("init");
}

void draw() {
  if (theme != null) {
    theme.update();
    if(second() % 2 == 0) displayLicenseWatermark();
    updateCheck();
  } else {
    if (!stop) {
      updateInfoDisplay();
      stop = true;
    }
  }
  //println(mouseX + " " + mouseY);
}
