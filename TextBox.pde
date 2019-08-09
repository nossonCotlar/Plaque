public class TextBox extends Element{
  String[] lines;
  float textSize, offset;
  color textCol;
  boolean center;
  
  
 TextBox(String path, float x, float y, float sizeX, float sizeY, float textSize, boolean center, boolean blue){
   super(x, y, sizeX, sizeY);
   this.textSize = textSize;
   offset = 5;
   this.lines = loadStrings(path);
   textCol = (blue)? textColor2 : textColor1;
   this.center = center;
 }
 
 
 void update(){
   show();
 }
 
 void show(){
   fill(textCol);
   textSize(textSize);
   if(center) textAlign(CENTER, CENTER);
   else textAlign(LEFT);
   for(int i = 0; i < lines.length; i++){
     
    text(lines[i], x, y + (i * (textSize + offset))); 
   }
 }
 
}
