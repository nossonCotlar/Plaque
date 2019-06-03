class Scroller{
 PFont font;
 float x, y, sizeX, sizeY;
 float cx, cy;
 float scrollSpeed;
 String[] lines;
 color textFill;
 float textSize, offset;
 
 
 Scroller(String s){
  x = 0;
  y = 200;
  sizeX = 500;
  sizeY = 500;
  cx = sizeX;
  cy = sizeY;
  scrollSpeed = 5;
  lines = loadStrings(s);
  textFill = color(0);
  textSize = 40;
  offset = 5;
 }
 
 void scrollDown(int c){
   cy -= scrollSpeed;
   if((cy - y) + (lines.length * (textSize + offset)) < y + sizeY){
     cy = sizeY;
   }
   
 }
 
 void show(){
   textSize(textSize);
   fill(textFill);
   int i = int((y - cy) / (textSize + offset)) + 1; //cut off extra lines that are past the threshold that we don't need to print
   if(i < 0) i = 0; //dont do that ^ if it's negative, for obvious array reasons
   for(; i < lines.length; i++){
     text(lines[i], cx, cy + (i * (textSize + offset))); 
   }
  
 }
 
}
