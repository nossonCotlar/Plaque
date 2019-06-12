// Nosson Cotlar
// Copyright 2019

final color backColor = color(200);
Theme theme;
boolean stop = false;

void setup() {
  fullScreen();
  frameRate(60);
  rectMode(CORNER);
  noStroke();

  fill(0);

  thread("init");
}

void draw() {
  //background(200);

  if (theme != null){
    background(backColor);
     theme.update();
  }
  else {
    if (!stop) {
      background(backColor);
      textAlign(CENTER);
      textSize(50);
      text("Updating Information, Please Wait...", width / 2, height / 2);
      textAlign(LEFT);
      stop = true;
    }
  }

  updateCheck();


  println(mouseX, ' ', mouseY);
}


void keyPressed() {
  if (key == 'p') saveFrame("save.png"); 
  if (key == 'r') {
    theme = null;
    thread("init");
  }
}

void init() {
  theme = new Theme("/resources/theme/theme.png");
  background(backColor);
}

void updateCheck() {
  if (hour() == 0 && minute() == 0 && second() == 0) {
    theme = null;
    thread("init");
  }
}
