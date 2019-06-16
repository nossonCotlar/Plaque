import java.util.Date;

class Clock{
  int s, m, h;
  float x, y, sizeX, sizeY;
  String time;
  int textSize = 37;
  String dayOfWeek;
  String parsha;
  String date;
  String hebrew;
  
 Clock(float x, float y, float sizeX, float sizeY){
   this.x = x;
   this.y = y;
   this.sizeX = sizeX;
   this.sizeY = sizeY;
   
   setWeekDay();
   initParsha();
   //initDate();
   initHebrew();
  
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
   fill(textColor1);
   textSize(textSize);
   textAlign(CENTER, CENTER);
   text(time, x, y);
   text(dayOfWeek + ' ' + hebrew, x - width / 3 + 40, y);
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
  
  void initDate(){
    String[] months = {
      "January", 
      "February", 
      "March", 
      "April", 
      "May", 
      "June", 
      "July", 
      "August", 
      "September", 
      "October", 
      "November", 
      "December", 
    };
    
    date = months[month() - 1] + " " + day() + ", " + year();
  }
  
  void initHebrew(){
   String[] temp = loadStrings("/resources/quote.txt");
   hebrew = temp[0].substring(0, temp[0].indexOf(" - "));
  }
 
}
