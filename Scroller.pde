class Scroller { //<>// //<>//
  PFont font;
  float x, y, sizeX, sizeY;
  float cx, cy, oy;
  float scrollSpeed;

  String[] text;
  float textSize, offset;
  boolean small;
  boolean stop;
  boolean center;


  Scroller(String s, int x, int y, int sizeX, int sizeY, int textSize, float speed, boolean center) {

    this.x = x;
    this.y = y;
    this.sizeX = sizeX;
    this.sizeY = sizeY;
    cx = x;
    cy = y + sizeY;
    oy = cy;
    this.textSize = textSize;
    offset = 5;
    this.scrollSpeed = speed;
    generateFromFile(s);
    stop = false;
    small = (text.length * (textSize + offset) < sizeY); //set as small if number of lines can fit in frame
    if (small) cy = y + (sizeY - text.length * (textSize + offset)) / 2 + offset; //center the text in the middle of the fame
    this.center = center;
    if(center) cx = x + sizeX / 2;
  }

  void scrollDown() {
    cy -= scrollSpeed;
    if (cy + (text.length * (textSize + offset)) < y ) { //once the last line is above the starting y coordinate
      cy = y + sizeY; //reset it
    }
  }

  void showSmall() {
    textSize(textSize);
    fill(textColor1);
    for (int i = 0; i < text.length; i++) {
      text(text[i], cx, cy + i * (textSize + offset));
    }
  }

  void show() {

    textSize(textSize);
    
    fill(textColor1);
    if (center) textAlign(CENTER);
    else textAlign(LEFT);
    if (small) {

      if (!stop) { //makes sure we don't draw text unecessarily

        showSmall(); //we dont need to scroll if the text segment is small
        //stop = true;
      }

      return;
    }


    for (int i = 0; i < text.length; i++) {
      float ty = cy + (i * (textSize + offset));
      if (ty < y + sizeY + textSize * 3 && ty > y - textSize * 3)
        text(text[i], cx, ty);
      ty = cy  + (i * (textSize + offset)) - (text.length * (textSize + offset));
      if (ty < y + sizeY + textSize * 3 && ty > y - textSize * 3)
        text(text[i], cx, ty);
      if (cy  + (i * (textSize + offset)) + (text.length * (textSize + offset)) <= oy) {
        cy = oy;
      }
    }
    
  }

  void showBox() {
    fill(backColor);
    rect(x - textSize * 2, y - textSize * 2, sizeX + textSize * 2, sizeY + textSize * 2, 10);
  }

  void showBlockers() {
    fill(backColor);
    rect(0, 0, width, y);
    rect(0, y + sizeY + textSize * 2, width, height - y + sizeY + textSize * 2);
  }

  void update() {
    //if (!stop) showBox();
    if (!small) scrollDown();

    show();
    //showBlockers();
  }

  void generateFromFile(String s) { //this takes a file which isn't necessarily spaced to fit the text box size, and attempts to size it properly
    String[] input = loadStrings(s);
    String temp = input[0];
    StringList lines = new StringList();
    int spaceIdx = 0;

    textSize(textSize);

    for (int i = 0; i < input.length; i++) { //loops through lines of original input
      temp = input[i];

      while (textWidth(temp) > sizeX) { //while the current line's length is too large
        while (textWidth(temp.substring(0, spaceIdx)) < sizeX) { 
          int t = temp.indexOf(' ', spaceIdx + 1); //locate the nearest space in the text
          if (t == -1) break; //if nothing was found, the line doesnt contain any spaces, so we cant cut it
          if (textWidth(temp.substring(0, t)) < sizeX) { //if the space occurs before the maximum character number, we save the index location
            spaceIdx = t;
          } else break; //if it was past the maximum, we use the last space location
        }
        if (spaceIdx == 0) {
          lines.append(temp);
          break;
        }
        lines.append(temp.substring(0, spaceIdx)); //add a new element to the lines list, ending at the space location
        temp = temp.substring(spaceIdx + 1); //assign the temp string to a cut version of itself, starting after the space
        spaceIdx = 0; //reset space location to the beginning
      }
      lines.append(temp);
    }
    //lines.append(temp);

    text = new String[lines.size()];
    for (int i = 0; i < text.length; i++) {
      text[i] = lines.get(i);
    }
  }
}
