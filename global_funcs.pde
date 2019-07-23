void keyPressed() {
  if (key == 'p') saveFrame("/ScreenShots/save.png"); 
  if (key == 'r') {
    reset();
  }
}


void init() {
  theme = new Theme("/resources/theme/theme.png");
  stop = false;
}

void updateCheck() {
  if (hour() == 0 && minute() == 0 && second() == 0) {
    reset();
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
  font = createFont("Uniform Condensed Medium.ttf", 45);
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
