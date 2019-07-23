class Zmanim { //<>// //<>//

  private JSONObject file;
  private String APIURL, APIUSER, APIKEY, LOCATIONID, METHOD, JSONPATH;
  private Zman[] zmanim;

  Zmanim(String path) {
    loadCreds(path);
    saveStringToJSON(JSONPATH, getPostContent());
    file = loadJSONObject(JSONPATH);
    initZmanim();
    printZmanim();

    exportToText("/resources/RESTapi/times.txt");
  }

  public void exportToText(String path) {
    String[] temp = new String[zmanim.length];

    for (int i = 0; i < zmanim.length; i++) {
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
    return post.getContent();
  }

  public void saveStringToJSON(String path, String s) {
    JSONObject json = parseJSONObject(s);
    saveJSONObject(json, path);
  }

  private void initZmanim() {
    JSONObject zmanObj = file.getJSONObject("Zman");
    zmanim = new Zman[]{
      new Zman("Dawn", zmanObj.getString("Dawn72")), 
      new Zman("Midday", zmanObj.getString("Midday")), 
      new Zman("Sunset", zmanObj.getString("SunsetDefault")), 
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
    this.timeString = time.substring(time.indexOf('T') + 1, time.indexOf('Z'));
    initTimeValues(time);
  }
  
  void initTimeValues(String time){
    this.time = new int[3];
    this.time[0] = parseInt(time.substring(0, time.indexOf(':')));
    time = time.substring(time.indexOf(':') + 1);
    this.time[1] = parseInt(time.substring(0, time.indexOf(':')));
    time = time.substring(time.indexOf(':') + 1);
    this.time[2] = parseInt(time.substring(0));
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
