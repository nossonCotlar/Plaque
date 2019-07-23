void keyPressed() {
  if (key == 'p') saveFrame("save.png"); 
  if (key == 'r') {
    
    freeStuffUp();
    thread("init");
  }
}

void init() {
  theme = new Theme("/resources/theme/theme.png");
  stop = false;
}

void updateCheck() {
  if (hour() == 0 && minute() == 0 && second() == 0) {
    freeStuffUp();
    thread("init");
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

void updateInfoDisplay() {
  background(backColor);
  fill(0);
  textAlign(CENTER);
  textSize(50);
  text("Updating Information, Please Wait...", width / 2, height / 2);
  textAlign(LEFT);
}
