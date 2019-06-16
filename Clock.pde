import java.util.Date;

class Clock {
  private int s, m, h;
  private float x, y, sizeX, sizeY;
  private String time;
  private int textSize = 37;
  private String dayOfWeek;
  private String parsha;
  private String date;
  private String hebrew;
  private boolean full;

  Clock(float x, float y, float sizeX, float sizeY, boolean full) {
    this.x = x;
    this.y = y;
    this.sizeX = sizeX;
    this.sizeY = sizeY;
    this.full = full;

    if (full) {
      setWeekDay();
      initParsha();
      //initDate();
      initHebrew();
    }

    s = second();
    m = minute();
    h = hour();
  }

  public void update() {
    s = second();
    m = minute();
    h = hour();

    time = h + ":";
    if (m < 10) time += '0';
    time += m + ":";
    if (s < 10) time += '0';
    time += s;

    show();
  }

  private void show() {
    //showBox();
    fill(textColor2);
    textSize(textSize * 1.5);
    textAlign(CENTER, CENTER);
    text(time, x, y);
    if (!full) {
      textAlign(LEFT);
      return;
    }
    fill(textColor1);
    textSize(textSize);
    text(dayOfWeek + ' ' + hebrew, x - width / 3 + 40, y);
    text(parsha, x + width / 3 - 40, y);
    textAlign(LEFT);
  }

  private void showBox() {
    fill(backColor);
    rect(x, y, sizeX, sizeY);
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

    dayOfWeek = weekDays[new Date().getDay()];
  }

  private void initParsha() {
    try {
      saveParsha("https://www.chabad.org/tools/rss/parsha_rss.xml", "/resources/parsha.txt");
      String[] temp = loadStrings("/resources/parsha.txt");
      parsha = temp[0];
    } 
    catch(Exception e) {
      parsha = "Not Found :(";
    }
  }

  private void initDate() {
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

  private void initHebrew() {
    String[] temp = loadStrings("/resources/quote.txt");
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
