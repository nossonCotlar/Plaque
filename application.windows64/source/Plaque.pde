// Nosson Cotlar
// Copyright 2019

Theme theme;
//PFont font;


void setup() {
  fullScreen();
  frameRate(60);
  rectMode(CORNER);
  noStroke();
  //font = loadFont("font.vlw");
  //textFont(font);
  
  theme = new Theme("/resources/theme/theme1.png");
  
}

void draw() {
  background(255);
  theme.update();
  

  
  
  println(mouseX , ' ' , mouseY);
  
}


void keyPressed(){
 if(key == 'p') saveFrame(); 
}
