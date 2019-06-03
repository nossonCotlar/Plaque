class Scroller { //<>//
  PFont font;
  float x, y, sizeX, sizeY;
  float cx, cy;
  float scrollSpeed;
  StringList lines;
  color textFill;
  float textSize, offset;


  Scroller(String s, int x, int y, int sizeX, int sizeY, int textSize, int speed) {
    lines = new StringList();
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
    generateFromFile(s);
      
  }

  void scrollDown() {
    cy -= scrollSpeed;
    if (cy + (lines.size() * (textSize + offset)) < y) { //once the last line is above the starting y coordinate
      cy = y + sizeY; //reset it
    }
  }
  


  void show() {
    textSize(textSize);
    fill(textFill);
    int i = int((y - cy) / (textSize + offset)) + 2; //cut off extra lines that are past the threshold that we don't need to print
    if (i < 0) i = 0; //dont do that ^ if it's negative, for obvious array reasons
    for (; i < lines.size() && cy + (i - 2) * (textSize + offset) < y + sizeY - textSize; i++) {
      text(lines.get(i), cx, cy + (i * (textSize + offset)));
    }
  }

  void showBox() {
    fill(200);
    rect(x - offset * 2, y, sizeX, sizeY + textSize * 2, 10);
  }

  void update() {
    showBox();
    scrollDown();
    show();
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
    }
    lines.append(temp);
  }
}
