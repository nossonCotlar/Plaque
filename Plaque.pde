// Nosson Cotlar
// Copyright 2019

Theme theme;

void setup() {
  fullScreen();
  frameRate(60);
  rectMode(CORNER);
  noStroke();
  textSize(50);
  fill(0);
 
  thread("init");
  
  
}

void draw() {
  background(200);
  
  if(theme != null)
  theme.update();
  else
  text("Please Wait...", width / 2 - 200, height / 2);
  
  updateCheck();
  
  
  println(mouseX , ' ' , mouseY);
  
}


void keyPressed(){
 if(key == 'p') saveFrame(); 
 if(key == 'r') {
   theme = null;
   thread("init");
 }
}

 void init(){
  theme = new Theme("/resources/theme/theme1.png");
}

void updateCheck(){
 if (hour() == 0 && minute() == 0 && second() == 0){
  thread("init");
 }
}
