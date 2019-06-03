Scroller s;

void setup() {
  fullScreen();
  rectMode(CORNER);
  noStroke();
  
  
  s = new Scroller("/resources/test.txt", 0, 100, 100, 700, 700, 35, 2);
}

void draw() {
  background(255);
 

  s.update();
  

  
}
