import java.util.Date;

class Clock{
  int s, m, h;
  float x, y, sizeX, sizeY;
  String time;
  int textSize = 37;
  color textFill;
  String dayOfWeek;
  String parsha;
  
 Clock(float x, float y, float sizeX, float sizeY){
   this.x = x;
   this.y = y;
   this.sizeX = sizeX;
   this.sizeY = sizeY;
   textFill = color(193, 139, 0);
   
   
   setWeekDay();
   initParsha();
  
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
   text(dayOfWeek, x - width / 3 + 40, y);
   text(parsha, x + width / 3 - 40, y);
   textAlign(LEFT);
   
 }
 
 void showBox(){
   fill(backColor);
   rect(x, y, sizeX, sizeY);
 }
 
 void setWeekDay(){
   String[] weekDays = {
     "Sunday",
     "Monday", 
     "Tuesday", 
     "Wednesday", 
     "Thursday", 
     "Friday", 
     "Shabbos"};
     
   dayOfWeek = weekDays[new Date().getDay()];
   
 }
 
   void initParsha() {
    try {
      saveParsha("https://www.chabad.org/tools/rss/parsha_rss.xml", "/resources/parsha.txt");
      String[] temp = loadStrings("/resources/parsha.txt");
      parsha = temp[0];
    } 
    catch(Exception e) {
      parsha = "Not Found :(";
    }
  }
 
}
