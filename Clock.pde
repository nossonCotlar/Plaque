class Clock{
  int s, m, h;
  float x, y, sizeX, sizeY;
  String time;
  int textSize = 37;
  color textFill;
  
 Clock(float x, float y, float sizeX, float sizeY){
   this.x = x;
   this.y = y;
   this.sizeX = sizeX;
   this.sizeY = sizeY;
   textFill = color(193, 139, 0);
  
   s = second();
   m = minute();
   h = hour();
 }
 
 void update(){
   s = second();
   m = minute();
   h = hour();
   
   time = h + ":";
   if(m < 10) time += '0';
   time += m + ":";
   if(s < 10) time += '0';
   time += s;
   
   show();
 }
 
 void show(){
   //showBox();
   fill(textFill);
   textSize(textSize);
   textAlign(CENTER, CENTER);
   text(time, x, y);
   textAlign(LEFT);
   
 }
 
 void showBox(){
   fill(backColor);
   rect(x, y, sizeX, sizeY);
 }
 
}
