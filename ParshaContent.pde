public String getPathToParshaContent(){
  return config.getString("url") + "/parsha/" + parsha + "/" + (today.getDay() + 1);
}
