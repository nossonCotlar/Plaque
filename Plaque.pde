// Nosson Cotlar
// Copyright 2019



Scroller scroller;
SideScroller side;
TextBox text1;
TextBox text2;
SlideShow slide;

Theme theme;

void setup() {
  fullScreen();
  rectMode(CORNER);
  noStroke();
  
  theme = new Theme("/resources/theme/theme.png");
}

void draw() {
  background(255);

theme.update();

  println(mouseX , ' ' , mouseY);
  
}


void keyPressed(){
 if(key == 'p') saveFrame(); 
}
