import java.util.Date;

class Clock extends Element{
  private int s, m, h;
  private String time;
  private float textSize = 37 * float(width) / 1920;
  private String dayOfWeek;
  private String parsha;
  private String date;
  private String hebrew;
  private boolean full;

  Clock(float x, float y, float sizeX, float sizeY, boolean full) {
    super(x, y, sizeX, sizeY);
    this.full = full;

    if (full) {
      setWeekDay();
      initParsha();
      initDate();
      initHebrew();
    }

    s = second();
    m = minute();
    h = hour();
    
    println(getPathToParshaContent());
  }

  public void update() {
    s = second();
    m = minute();
    h = hour();

    if (h % 12 == 0) time = "12:";
    else time = h % 12 + ":";
    if (m < 10) time += '0';
    time += m + ":";
    if (s < 10) time += '0';
    time += s;

    show();
  }

  private void show() {
    //showBox();
    fill(textColor2);
    textSize(textSize);
    textAlign(LEFT, CENTER);
    text(time, x - width / 8.34783, y);
    
    textAlign(RIGHT, CENTER);
    text(date, x + width / 8.34783, y);
    if (!full) {
      textAlign(LEFT);
      return;
    }
    textAlign(CENTER, CENTER);
    fill(textColor1);
    textSize(textSize);
    text(dayOfWeek + ' ' + hebrew, x - width / 3 + width / 48, y);
    text(parsha, x + width / 3 - width / 48, y);
    textAlign(LEFT);
  }

  private void setWeekDay() {
    String[] weekDays = {
      "Sunday", 
      "Monday", 
      "Tuesday", 
      "Wednesday", 
      "Thursday", 
      "Friday", 
      "Shabbos"};

    dayOfWeek = weekDays[today.getDay()];
  }

  private void initParsha() {
    try {
      saveParsha("https://www.chabad.org/tools/rss/parsha_rss.xml", "/resources/texts/parsha.txt");
      String[] temp = loadStrings("/resources/texts/parsha.txt");
      parsha = temp[0];
    } 
    catch(Exception e) {
      parsha = "Not Found :(";
    }
  }

  private void initDate() {
    /*
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
    }; */

    date = month() + "/" + day() + "/" + year() % 1000;
  }

  private void initHebrew() {
    String[] temp = loadStrings("/resources/texts/quote.txt");
    hebrew = temp[0].substring(0, temp[0].indexOf(" - "));
  }

  void destroy() {
    time = null;
    dayOfWeek = null;
    parsha = null;
    date = null;
    hebrew = null;
  }
}
