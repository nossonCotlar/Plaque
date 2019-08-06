class Zmanim { //<>// //<>//

  private JSONObject file;
  private String APIURL, APIUSER, APIKEY, LOCATIONID, METHOD, JSONPATH;
  private Zman[] zmanim;

  Zmanim(String path) {
    loadCreds(path);
    saveStringToJSON(JSONPATH, getPostContent());
    file = loadJSONObject(JSONPATH);
    initZmanim();
    //printZmanim();
  }

  public void exportToText(String path) {
    if(zmanim == null) {
    saveStrings(path, new String[] {"Not Found :("});
    return;
    }
    String[] temp = new String[zmanim.length];

    for (int i = 0; i < zmanim.length; i++) {
      if(zmanim[i].getTimeString() == "missing"){
        temp[i] = "";
        continue;
      }
      temp[i] = zmanim[i].getName() + " - " + zmanim[i].getTimeString();
    }

    saveStrings(path, temp);
  }

  private void loadCreds(String path) {
    JSONObject creds = loadJSONObject(path);
    APIURL = creds.getString("APIURL");
    APIUSER = creds.getString("APIUSER");
    APIKEY = creds.getString("APIKEY");
    LOCATIONID = creds.getString("LOCATIONID");
    METHOD = creds.getString("METHOD");
    JSONPATH = creds.getString("JSONPATH");
    //println(APIURL);
  }

  private String getPostContent() {
    PostRequest post = new PostRequest(APIURL + "/" + METHOD);
    post.addData("coding", "JS");
    post.addData("language", "en");
    post.addData("locationid", LOCATIONID);
    post.addData("key", APIKEY);
    post.addData("user", APIUSER);
    post.send();
    if(post.getContent() == null) return null;
    return post.getContent();
  }

  public void saveStringToJSON(String path, String s) {
    if(s == null){
     JSONObject t = parseJSONObject("{}"); 
     saveJSONObject(t, path);
     return;
    }
    JSONObject json = parseJSONObject(s);
    saveJSONObject(json, path);
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
