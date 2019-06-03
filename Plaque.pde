Scroller s;

void setup() {
  fullScreen();
  rectMode(CENTER);
  noStroke();
  
  
  s = new Scroller("/resources/test.txt");
}

void draw() {
  background(255);
  s.scrollDown();
  s.show();
  square(s.x, s.y, s.textSize);

  
}
