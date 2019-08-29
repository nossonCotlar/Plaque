String pullContent() throws RuntimeException {
  GetRequest get = new GetRequest(config.getString("url") + "/textPull/" + config.getString("user") + "/" + config.getString("key"));
  get.send();

  if (get.getContent() == null) throw new RuntimeException("Couldn't reach ShulScreen Server\n Please try reloading or contact Shulscreen Support");
  return get.getContent();
}

JSONObject[] pullAllContentObjects() {
  JSONObject[] jsonArray = new JSONObject[0];
  while (true) {
    JSONObject t = parseJSONObject(pullContent());
    if (t.getBoolean("available") == false) break;
    jsonArray = (JSONObject[])append(jsonArray, t);
  }
  return jsonArray;
}

void printAllPulled() {
  JSONObject[] all = pullAllContentObjects();
  for (JSONObject t : all) {
    println(t.getString("text"));
  }
}

void saveAllPulled() {
  JSONObject[] all = pullAllContentObjects();
  if(all == null) return;
  for (JSONObject t : all) {
    switch(t.getString("selection")){
     case "donors":
     saveStrings("/resources/texts/middle.txt", new String[] {t.getString("text")});
     break;
     case "memorial":
     saveStrings("/resources/texts/bottom.txt", new String[] {t.getString("text")});
     break;
     case "annoucements":
     saveStrings("/resources/texts/bottomRight.txt", new String[] {t.getString("text")});
     break;
     default:
     
     break;
    }
  }
}

void pullParshaContent() throws RuntimeException {
 GetRequest get = new GetRequest(getPathToParshaContent());
 get.send();
 
 if(get.getContent() == null) throw new RuntimeException("Couldn't reach ShulScreen Server\n Please try reloading or contact Shulscreen Support");;
 saveStrings("/resources/texts/left.txt", new String[] {get.getContent()});
 
}
