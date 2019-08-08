public class Scroller extends Element { //<>//
  private float cx, cy, oy;
  private float scrollSpeed;

  private String[] text;
  private float textSize, offset;
  private boolean small, stop, center;


  Scroller(String s, float x, float y, float sizeX, float sizeY, float textSize, float speed, boolean center) {

    super(x, y, sizeX, sizeY);
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

  private void scrollDown() {
    cy -= scrollSpeed;
    if (cy + (text.length * (textSize + offset)) < y ) { //once the last line is above the starting y coordinate
      cy = y + sizeY; //reset it
    }
  }

  private void showSmall() {
    textSize(textSize);
    fill(textColor1);
    for (int i = 0; i < text.length; i++) {
      text(text[i], cx, cy + i * (textSize + offset));
    }
  }

  private void show() {

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

  public void update() {
    //if (!stop) showBox();
    if (!small) scrollDown();

    show();
  }

  private void generateFromFile(String s) { //this takes a file which isn't necessarily spaced to fit the text box size, and attempts to size it properly
    String[] input = loadStrings(s);
    
    if(input == null){
     text = new String[2]; 
     text[0] = "Could not load file from path: ";
     text[1] = s;
     return;
    }
    
    println(int(input[0].charAt(0)));
    
    for(int i = 0; i < input.length; i++){ //fix unrecognized quotes
      input[i] = input[i].replace(char(19), '\"'); //get rid of curly starting quotes
      input[i] = input[i].replace(char(20), '\"'); //get rid of curly ending quotes
      input[i] = input[i].replace(char(17), '\''); //get rid of curly single quote 
      input[i] = input[i].replace(char(18), '\''); //get rid of other curly single quote
      input[i] = input[i].replace(char(22), '-'); //get rid of other curly single quote
    }
    
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
  
  void destroy(){
   text = null; 
  }
  
}
