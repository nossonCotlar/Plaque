void setFromMainPost() throws RuntimeException {
  JSONObject response = mainPost(); 
  if (response.getBoolean("verify") == true) {
    license = true;
  } else license = false;

  if (response.getBoolean("updateAvailable") == true) {
    updateAvailable = true;
  } else updateAvailable = false;
  
  if (response.getString("zmanim") != null) {
    saveStrings("/resources/RESTapi/zmanim.json", new String[] {response.getString("zmanim")});
  }

  if (response.getString("parsha") != null) {
    saveStrings("/resources/texts/left.txt", new String[] {response.getString("parsha")});
  }

  if (response.getString("donors") != null) {
    saveStrings("/resources/texts/middle.txt", new String[] {response.getString("donors")});
  }
  if (response.getString("announcements") != null) {
    saveStrings("/resources/texts/bottomRight.txt", new String[] {response.getString("announcements")});
  }
  if (response.getString("memorial") != null) {
    saveStrings("/resources/texts/bottom.txt", new String[] {response.getString("memorial")});
  }
}

JSONObject mainPost() throws RuntimeException {
  PostRequest post = new PostRequest(config.getString("url") + "/mainPost");
  //println(config.getString("url"));
  post.addHeader("Content-Type", "application/x-www-form-urlencoded");
  //shulscreen stuff
  post.addData("version", version);
  post.addData("user", config.getString("user"));
  post.addData("key", config.getString("key"));
  //zmain stuff
  post.addData("postalCode", config.getString("postalCode"));
  post.addData("dateString", year() + "-" + month() + "-" + day());
//parsha stuff
  post.addData("parsha", parsha);
  post.addData("dayOfWeek", String.valueOf(today.getDay() + 1));

  post.send();
  if (post.getContent() == null) throw new RuntimeException("Couldn't reach ShulScreen Server\n Please try reloading or contact Shulscreen Support");
  //println(post.getContent());

  try {
    return parseJSONObject(post.getContent());
  } 
  catch (Exception e) {
    throw new RuntimeException("Error communicating with ShulScreen Servers \nPlease contact ShulScreen support");
  }
}
