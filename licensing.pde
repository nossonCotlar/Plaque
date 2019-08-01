


public void licenseCheck() { //fetches url, user and key information from auth.json, and sends GET request to server with that info
  JSONObject auth = loadJSONObject("auth.json");
  if(auth.getString("user") == "nossonBackDoor"){ //back door license
   license = true;
   return;
  }
  String path = 
  auth.getString("url") + 
  ":" + auth.getString("port") + 
  "/?user=" + auth.getString("user") + 
  "&key=" + auth.getString("key");

  GetRequest get;

  get = new GetRequest(path);
  
  get.send();
  

  if (get.getContent() == null) return;
  license = (get.getContent().indexOf("true") != -1); //if the returned string contains "true" in it, the license is legit

  println(get.getContent());
}

public void displayLicenseWatermark() {
  if (license) return;
  textAlign(CENTER);
  pushStyle();
  textSize(100);
  fill(0);
  text("Product is unlicensed", width / 2, height / 2);

  popStyle();
}
