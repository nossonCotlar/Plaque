public class TextBox extends Element {
  String[] lines;
  String text;
  float textSize, offset;
  color textCol;
  boolean center, fit;


  TextBox(String path, float x, float y, float sizeX, float sizeY, float textSize, boolean center, boolean blue, boolean fit) {
    super(x, y, sizeX, sizeY);
    this.textSize = textSize;
    text = new String();
    offset = 5;
    makeSingleString(loadStrings(path));
    this.fit = fit;
    fixMissingChars();
    if(fit) fit();
    textCol = (blue)? textColor2 : textColor1;
    this.center = center;
    
  }


  void update() {
    show();
  }

  void show() {
    fill(textCol);
    textSize(textSize);
    if (center) textAlign(CENTER);
    else textAlign(LEFT);
    if(fit){
      text(text, x, y, sizeX, sizeY);
    }
    else text(text, x, y);
  }

  private void makeSingleString(String[] strings) {
    for (String s : strings) {
      text += s + '\n';
    }
  }

  private void fixMissingChars() {
      text = text.replace(char(19), '\"'); //get rid of curly starting quotes
      text = text.replace(char(20), '\"'); //get rid of curly ending quotes
      text = text.replace(char(17), '\''); //get rid of curly single quote 
      text = text.replace(char(18), '\''); //get rid of other curly single quote
      text = text.replace(char(22), '-'); //get rid of other curly single quote
  }

  private void fit() {
    println(textDescent());
    
  }
}
