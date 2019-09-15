class Zmanim { //<>// //<>//

  private JSONObject file;
  private Zman[] zmanim;

  Zmanim() throws RuntimeException {
    file = loadJSONObject("/resources/RESTapi/zmanim.json");
    errCatch();
    initZmanim();
    try{
    exportToText("/resources/RESTapi/times.txt");
    } catch (Exception e){
     throw new RuntimeException("Error reading zmanim content"); 
    }
    //printZmanim();
  }

  private void exportToText(String path) {
    if(zmanim == null) {
    saveStrings(path, new String[] {"Not Found :("});
    return;
    }
    String[] temp = new String[zmanim.length];

    for (int i = 0; i < zmanim.length; i++) {
      if(zmanim[i].getTimeString() == "missing"){
        temp = shorten(temp);
        continue;
      }
      temp[i] = zmanim[i].getName() + " - " + zmanim[i].getTimeString();
    }
    
   JSONObject timeObj = file.getJSONObject("Time");
   if(timeObj.getBoolean("IsRoshChodesh") == true){
    temp = append(temp, "Rosh Chodesh"); 
   }

    saveStrings(path, temp);
  }

  private void initZmanim() {
    if(file.getJSONObject("Zman") == null) return;
    JSONObject zmanObj = file.getJSONObject("Zman");
    zmanim = new Zman[]{
      new Zman("Earliest Shema", zmanObj.getString("Dawn72")), 
      new Zman("Latest Shema", zmanObj.getString("ShemaGra")),
      new Zman("Sunset", zmanObj.getString("SunsetDefault")), 
      new Zman("Candle Lighting", zmanObj.getString("Candles")),
      
    };
  }

  private void printZmanim() {
    for (Zman z : zmanim) {
      println(z.getName() + " - " + z.getTimeString());
    }
  }
  
  private void errCatch(){
    String err; 
    try{
    err = file.getString("ErrMsg");
    } catch(Exception E){
      err = null;
    }
    if(err != null){
     throw new RuntimeException("Error with Zmanim: " +  file.getString("ErrMsg"));
    }
  }
}


class Zman {
  private String name, timeString;
  private int[] time; //hour, minute, second
  

  Zman(String name, String time) {
    this.name = name;
    if(time.charAt(0) != '0'){
    initTimeValues(time);
    setTimeString();
    }
    else timeString = "missing";
    
  }
  
  void initTimeValues(String time){
    this.time = new int[3];
    time = time.substring(time.indexOf('T') + 1, time.indexOf('Z'));
    this.time[0] = parseInt(time.substring(0, time.indexOf(':')));
    time = time.substring(time.indexOf(':') + 1);
    this.time[1] = parseInt(time.substring(0, time.indexOf(':')));
    time = time.substring(time.indexOf(':') + 1);
    this.time[2] = parseInt(time.substring(0));
  }
  
  private void setTimeString(){
    char ampm;
    if(this.time[0] >= 12) ampm = 'p';
    else ampm = 'a';
    if(this.time[0] % 12 == 0) this.time[0] = 12;
    this.timeString = "" + this.time[0] % 12 + ":";
    if(this.time[1] < 10) this.timeString += "0";
    this.timeString += this.time[1];
    this.timeString += " " + ampm + "m";
  }
  
  public String getName() {
    return this.name;
  }
  public int[] getTime() {
    return this.time;
  }
  public String getTimeString() {
    return this.timeString;
  }
}
