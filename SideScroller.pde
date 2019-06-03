class SideScroller {

  float x, y, sizeX, sizeY;
  float cx, cy, ox;
  float scrollSpeed;
  String[] lines;
  color textFill;
  float textSize, offset;
  float bw;
  int cutoff = 0;

  SideScroller(String s, int x, int y, int sizeX, int sizeY, int textSize, int speed) {
    this.x = x;
    this.y = y;
    this.sizeX = sizeX;
    this.sizeY = sizeY;
    cx = x;
    ox = cx;
    cy = y + sizeY - 10;
    this.textSize = textSize;
    offset = 5;
    this.scrollSpeed = speed;
    bw = 30;
    textFill = color(0);
    lines = loadStrings(s);
  }

  void update() {
    scroll();
    show();
  }

  void scroll() {
    cx -= scrollSpeed;
  }

  void show() {

    showBox();
    float push = 0, pushAmount;
    fill(0);
    textSize(textSize);



    for (int j = 0; j < 2; j++) { //run twice so we have some overlap

      for (int i = 0; i < lines.length; i++) {
        text(lines[i], cx + push, cy); 
        pushAmount = lines[i].length() * textSize / 2 + bw;
        push += pushAmount;
        circle(cx + push - bw, cy - textSize / 2 + 10, 20);
      }
      if(cx + push == ox){ //if the current drawing location is where the original was, we can perform a seamless reset
       for (int i = 0; i < lines.length; i++) {
        text(lines[i], cx + push, cy); 
        pushAmount = lines[i].length() * textSize / 2 + bw;
        push += pushAmount;
        circle(cx + push - bw, cy - textSize / 2 + 10, 20);
      }
        cx = ox; //reset the current writing position
        push = 0;
      }
    }



    fill(255);
    rect(0, y, x - offset * 2, sizeY + offset * 2);
    rect(x - offset * 2 + sizeX, y, 900, 400);
  }

  void showBox() {
    fill(200);
    rect(x - offset * 2, y, sizeX, sizeY + offset * 2, 10);
  }
}
