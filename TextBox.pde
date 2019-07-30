public class TextBox extends Element{
  String[] lines;
  float textSize, offset;
  
  
 TextBox(String path, int x, int y, float sizeX, float sizeY, int textSize){
   super(x, y, sizeX, sizeY);
   this.textSize = textSize;
   offset = 5;
   this.lines = loadStrings(path);
 }
 
 
 void update(){
   show();
 }
 
 void show(){
   fill(textColor2);
   textSize(textSize);
   textAlign(CENTER, CENTER);
   for(int i = 0; i < lines.length; i++){
     
    text(lines[i], x, y + (i * (textSize + offset))); 
   }
 }
 
}
