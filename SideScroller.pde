class SideScroller {

  float x, y, sizeX, sizeY;
  float cx, cy;
  float scrollSpeed;
  String[] lines;
  color textFill;
  float textSize, offset;

  SideScroller(String s, int x, int y, int sizeX, int sizeY, int textSize, int speed) {
    this.x = x;
    this.y = y;
    this.sizeX = sizeX;
    this.sizeY = sizeY;
    cx = x;
    cy = y + sizeY;
    this.textSize = textSize;
    offset = 5;
    this.scrollSpeed = speed;
    textFill = color(0);
    lines = loadStrings(s);
  }
  
  void update(){
    scroll();
    show();
  }
  
  void scroll(){
   cx -= scrollSpeed; 
  }
  
  void show(){
    
    showBox();
    int push = 0;
    fill(0);
    for(int i = 0; i < lines.length; i++){
     text(lines[i], cx + push, cy); 
     
     push += lines[i].length() * textSize / 2 ;
     circle(cx + push - lines[i].length() * textSize / 2, cy - textSize / 2 + 10, 10);
    }
    
  }
  
  void showBox(){
    fill(200);
    rect(x - offset * 2, y, sizeX, sizeY + offset * 2, 10);
  }
  
  
}
