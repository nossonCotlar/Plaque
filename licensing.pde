public void licenseCheck(){
 String url, user, licenseKey;
 JSONObject credentials = loadJSONObject("auth.json");
 user = credentials.getString("user");
 licenseKey = credentials.getString("key");
 url = credentials.getString("url");
 
 String full = url + "/?user=" + user + "&key=" + licenseKey;
 
 GetRequest licenseGet = new GetRequest(full);
 licenseGet.send();
 if(licenseGet.getContent() == null) return;
 if(licenseGet.getContent().indexOf("true") != -1) license = true; //if the returned string contains "true" in it, the license is legit
 else license = false;
 
 println(license);
 
}

public void displayLicenseWatermark(){
  if(license) return;
  textAlign(CENTER);
  pushStyle();
  textSize(100);
  fill(0);
  text("Product is unlicensed", width / 2, height / 2);
  
  popStyle();
  
}
