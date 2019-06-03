Scroller scroller;
TextBox text1, text2;

void setup() {
  fullScreen();
  rectMode(CORNER);
  noStroke();
  
  
  scroller = new Scroller("/resources/scrollTest.txt", 0, 850, 50, 600, 800, 35, 2);
  text1 = new TextBox("/resources/textTest.txt", 100, 50, 500, 350, 45);
  text2 = new TextBox("/resources/textTest2.txt", 100, 500, 500, 1, 45);
  
}

void draw() {
  background(255);
 

  scroller.update();
  text1.update();
  text2.update();

  
}
