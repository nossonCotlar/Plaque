class Scroller { //<>// //<>//
  PFont font;
  float x, y, sizeX, sizeY;
  float cx, cy, oy;
  float scrollSpeed;
  StringList lines;
  color textFill;
  float textSize, offset;
  boolean small;


  Scroller(String s, int x, int y, int sizeX, int sizeY, int textSize, float speed) {
    lines = new StringList();
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
    textFill = color(0);
    generateFromFile(s);
    small = (lines.size() * (textSize + offset) < sizeY); //set as small if number of lines can fit in frame
    if(small) cy = y + (sizeY - lines.size() * (textSize + offset)) / 2 + offset; //center the text in the middle of the fame
  }

  void scrollDown() {
    cy -= scrollSpeed;
    if (cy + (lines.size() * (textSize + offset)) < y ) { //once the last line is above the starting y coordinate
      cy = y + sizeY; //reset it
    }
  }

  void showSmall() {
    textSize(textSize);
    fill(textFill);
    for (int i = 0; i < lines.size(); i++) {
      text(lines.get(i), x, cy + i * (textSize + offset));
    }
  }

  void show() {
    if (small) {
      showSmall(); //we dont need to scroll if the text segment is small
      return;
    }
    textSize(textSize);
    fill(textFill);
    int i = 0;
    for (; i < lines.size() /* && cy + (i - 2) * (textSize + offset) < y + sizeY - textSize*/; i++) {
      text(lines.get(i), cx, cy + (i * (textSize + offset)));
      //text(lines.get(i), cx, cy  + (i * (textSize + offset)) + (lines.size() * (textSize + offset)));
      text(lines.get(i), cx, cy  + (i * (textSize + offset)) - (lines.size() * (textSize + offset)));
      if (cy  + (i * (textSize + offset)) + (lines.size() * (textSize + offset)) <= oy) {
        cy = oy;
      }
    }
  }

  void showBox() {
    fill(200);
    rect(x - offset * 2, y, sizeX, sizeY + textSize * 2, 10);
  }

  void showBlockers() {
    fill(200);
    rect(0, 0, width, y);
    rect(0, y + sizeY + textSize * 2, width, height - y + sizeY + textSize * 2);
  }

  void update() {
    showBox();
    if (!small) scrollDown();
      
    show();
    //showBlockers();
  }

  void generateFromFile(String s) { //this takes a file which isn't necessarily spaced to fit the text box size, and attempts to size it properly
    String[] input = loadStrings(s);
    String temp = input[0];
    int spaceIdx = 0;
    int charPerLine = int(sizeX / (textSize ) * 2); //determines appropriate number of characters per lines based on textbox size

    for (int i = 0; i < input.length; i++) { //loops through lines of original input
      temp = input[i];
      while (temp.length() > charPerLine) { //while the current line's length is too large
        while (spaceIdx < charPerLine) { 
          int t = temp.indexOf(' ', spaceIdx + 1); //locate the nearest space in the text
          if (t == -1) break; //if nothing was found, the line doesnt contain any spaces, so we cant cut it
          if (t < charPerLine) { //if the space occurs before the maximum character number, we save the index location
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
  }
}
