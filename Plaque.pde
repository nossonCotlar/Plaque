// Nosson Cotlar
// Copyright 2019

final color backColor = color(200);
final color textColor1 = color(193, 139, 0); //light yellow / gold
final color textColor2 = color(23, 42, 80); //very dark blue
Theme theme;
PFont font;
boolean stop = false;

void setup() {
  fullScreen();
  frameRate(60);
  rectMode(CORNER);
  noStroke();
  font = createFont("Uniform Condensed Medium.ttf", 45);
  if (font != null) textFont(font);

  thread("init");
}

void draw() {
  //background(200);

  if (theme != null) {
    //background(backColor);
    theme.update();
  } else {
    if (!stop) {
      background(backColor);
      fill(0);
      textAlign(CENTER);
      textSize(50);
      text("Updating Information, Please Wait...", width / 2, height / 2);
      textAlign(LEFT);
      stop = true;
    }
  }

  updateCheck();


  println(mouseX, ' ', mouseY);
  //println(frameRate);
}


void keyPressed() {
  if (key == 'p') saveFrame("save.png"); 
  if (key == 'r') {
    frameCount = -1;
    freeStuffUp();
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
