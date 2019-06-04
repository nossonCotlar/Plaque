// Nosson Cotlar
// Copyright 2019



Scroller scroller;
SideScroller side;
TextBox text1;
TextBox text2;
SlideShow slide;

void setup() {
  fullScreen();
  rectMode(CORNER);
  noStroke();


  scroller = new Scroller("/resources/scrollTest.txt", 1050, 50, 800, 750, 35, 1);
  text1 = new TextBox("/resources/textTest.txt", 100, 50, 650, 350, 45);
  text2 = new TextBox("/resources/textTest2.txt", 100, 500, 500, 300, 45);
  side = new SideScroller("/resources/sideTest.txt", 100, 900, width - 200, 65, 45, 3);
  
  slide = new SlideShow("/resources/pics/", 100, 450, 650, 400, 3);
}

void draw() {
  background(255);



  text1.update();
  //text2.update();
  scroller.update();
  side.update();
  
  slide.update();
  
}


void keyPressed(){
 if(key == 'p') saveFrame(); 
}
