class Clock{
  int s, m, h;
  float x, y, sizeX, sizeY;
  String time;
  int textSize = 37;
  
 Clock(float x, float y, float sizeX, float sizeY){
   this.x = x;
   this.y = y;
   this.sizeX = sizeX;
   this.sizeY = sizeY;
  
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
   showBox();
   fill(0);
   textSize(textSize);
   text(time, x + textSize / 4, y + textSize * 1.5);
   
 }
 
 void showBox(){
   fill(200);
   rect(x, y, sizeX, sizeY);
 }
 
}
