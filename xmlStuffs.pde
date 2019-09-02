
public String getTextFromRSS(String url) {
  String t = extractXMLFromString(getRSS(url));
  if (t == null) {
    return null;
  };
  return t;
}

public String readURLFromFile(String file) {
  return loadStrings(file)[0];
}

public String getRSS(String url) throws RuntimeException{ //gets the XML content of a given URL and returns a string with its contents
  String[] l = new String[1];
  GetRequest get = new GetRequest(url);
  get.send();

  if (get.getContent() == null) {
    throw new RuntimeException("Couldn't reach Content servers\n Please Contact ShulScreen Support");
  }

  l[0] = get.getContent();

  return l[0];
}

public String extractXMLFromString(String s) { //takes a string which is formatted in XML and returns plaintext content
  if (s == null) return null;
  XML x = parseXML(s);
  return x.getContent();
}

public void makeFile(String src, String dest) {
  String[] t = new String[1];
  t[0] = src;
  saveStrings(dest, t);
}

public void saveDailyQuote(String url, String path) {
  String text = getTextFromRSS(url);
  String t;

  if (text == null) t = "Not Found :(";
  else t  = getDailyQuote(text);
  makeFile(t, path);
}

public void saveParsha(String url, String path) {
  String text = getTextFromRSS(url);

  String t = getParsha(text);

  makeFile(t, path);
}

public String getParsha(String s) {
  String parsha = new String();
  String t = s;
  int start = t.indexOf("Parsha - ") + 9;
  int end = t.indexOf("http://") - 1;
  parsha = t.substring(start, end);

  return parsha;
}

public String getDailyQuote(String s) {
  String r = new String();
  String t = s;
  int start, end;
  String[] headings = 
    {
    "Daily Quote: " 

  };

  for (int i = 0; i < headings.length; i++) {
    start = t.indexOf(headings[i]) + headings[i].length();
    if (start != -1) {
      t = t.substring(start);
      end = t.indexOf(" EST");
      r += t.substring(0, end - 25) + '\n';
    }
  }


  return r;
}
