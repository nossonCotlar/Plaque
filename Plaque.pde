// Nosson Cotlar - Rood Systems
// Copyright 2019

void setup() {
  fullScreen();
  frameRate(60); 
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
    displayLicenseWatermark();
    updateCheck();
  } else {
    if (!stop) {
      updateInfoDisplay();
      stop = true;
    }
  }
  //println(mouseX + ' ' + mouseY);
}
