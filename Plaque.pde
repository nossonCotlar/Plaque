Scroller s;

void setup() {
  fullScreen();
  rectMode(CORNER);
  noStroke();
  
  
  s = new Scroller("/resources/test.txt");
}

void draw() {
  background(255);
  fill(100);
  square(s.x, s.y, (s.textSize + s.offset) * 22);
  s.scrollDown();
  s.show();
  

  
}
