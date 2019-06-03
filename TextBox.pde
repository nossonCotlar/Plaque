class TextBox{
  float x, y, sizeX, sizeY;
  String[] lines;
  float textSize, offset;
  
  
 TextBox(String s, int x, int y, float sizeX, float sizeY, int textSize){
   this.x = x;
   this.y = y;
   this.sizeX = sizeX;
   this.sizeY = sizeY;
   this.textSize = textSize;
   offset = 5;
   this.lines = loadStrings(s);
 }
 
 
 void update(){
   show();
 }
 
 void show(){
   showBox();
   fill(0);
   textSize(textSize);
   for(int i = 0; i < lines.length; i++){
     
    text(lines[i], x, y + (i * (textSize + offset)) + textSize + offset); 
   }
 }
 
 void showBox(){
   fill(200);
   rect(x - offset * 2, y, x + sizeX, sizeY + offset * 2 , 10);
 }
 
}
