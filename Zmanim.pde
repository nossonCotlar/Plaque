class Zmanim {
  private JSONObject file;
  private String APIURL, APIUSER, APIKEY, LOCATIONID, METHOD, JSONPATH;
  private String sunset, midday, dawn;
  

  Zmanim(String path) {
    loadCreds(path);
    saveStringToJSON(JSONPATH, getPostContent());
    file = loadJSONObject(JSONPATH);
    initTimes();
    printZmanim();
    
  }
 
public void exportToText(String path){
  
}

  private void loadCreds(String path) {
    JSONObject creds = loadJSONObject(path);
    APIURL = creds.getString("APIURL");
    APIUSER = creds.getString("APIUSER");
    APIKEY = creds.getString("APIKEY");
    LOCATIONID = creds.getString("LOCATIONID");
    METHOD = creds.getString("METHOD");
    JSONPATH = creds.getString("JSONPATH");
    println(APIURL);
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
  
  private void initTimes(){ //<>//
    String temp; //<>//
    JSONObject zman = file.getJSONObject("Zman");
    
    temp = zman.getString("Dawn72");
    dawn = temp.substring(temp.indexOf('T') + 1, temp.indexOf('Z'));
    
    temp = zman.getString("Midday");
    midday = temp.substring(temp.indexOf('T') + 1, temp.indexOf('Z'));
    
    temp = zman.getString("SunsetDefault");
    sunset = temp.substring(temp.indexOf('T') + 1, temp.indexOf('Z'));
   
  }
  
  private void printZmanim(){
   println("Dawn - " + dawn);
   println("Midday - " + midday);
   println("Sunset - " + sunset);
  }
  
}
