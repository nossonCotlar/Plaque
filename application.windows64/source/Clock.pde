class Clock{
  int s, m, h;
  float x, y;
  String time;
  
  
 Clock(float x, float y){
   this.x = x;
   this.y = y;
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
   fill(0);
   textSize(37);
   text(time, x, y);
   
 }
 
}
