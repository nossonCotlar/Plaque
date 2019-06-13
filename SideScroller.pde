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
    bw = 50;
    textFill = color(193, 139, 0);
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

    //showBox();
    float push = 0, pushAmount;
    fill(textFill);
    textSize(textSize);
    textAlign(LEFT);

    for (int j = 0; j < 4; j++) { //run several times so we have some overlap

      for (int i = 0; i < lines.length; i++) {
        text(lines[i], cx + push, cy); 
        pushAmount = textWidth(lines[i]) + bw;
        push += pushAmount;
        circle(cx + push - bw / 2, cy - textSize / 2 + 5, textSize / 2);
      }

      if (cx + push <= ox) { //if the current drawing location is where the original was, we can perform a seamless reset
        push = 0;
        for (int i = 0; i < lines.length; i++) {
          text(lines[i], cx + push, cy); 
          pushAmount = textWidth(lines[i]) + bw;
          push += pushAmount;
          circle(cx + push - bw / 2, cy - textSize / 2 + 5, textSize / 2);
        }
        cx = ox; //reset the current writing position
        push = 0;
      }
    }
  }

  void showBox() {
    fill(backColor);
    rect(x - offset * 2, y, sizeX, sizeY + offset * 2, 10);
  }
}
