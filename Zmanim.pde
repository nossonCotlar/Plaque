class Zmanim {
  private String APIURL, APIUSER, APIKEY, LOCATIONID, METHOD, JSONPATH;
  

  Zmanim(String path) {
    loadCreds(path);
    saveStringToJSON(JSONPATH, getPostContent());
  }
  Zmanim() {
    loadCreds("/resources/RESTapi/creds.json");
    saveStringToJSON(JSONPATH, getPostContent());
  }


  private void loadCreds(String path) {
    JSONObject creds = loadJSONObject(path);
    APIURL = creds.getString("APIURL");
    APIUSER = creds.getString("APIUSER");
    APIKEY = creds.getString("APIKEY");
    LOCATIONID = creds.getString("LOCATIONID");
    METHOD = creds.getString("METHOD");
    JSONPATH = creds.getString("JSONPATH");
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
}
