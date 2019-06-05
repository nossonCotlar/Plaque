import http.requests.*;


String getTextFromRSS(String url) {
  return extractXMLFromString(getRSS(url));
}

String readURLFromFile(String file) {
  String[] l = new String[1];

  l = loadStrings(file);
  return l[0];
}

String getRSS(String url) { //gets the XML content of a given URL and returns a string with its contents
  String[] l = new String[1];
  GetRequest get = new GetRequest(url);
  get.send();

  l[0] = get.getContent();

  return l[0];
}

String extractXMLFromString(String s) { //takes a string which is formatted in XML and returns plaintext content
  XML x = parseXML(s);
  return x.getContent();
}

void makeFile(String src, String dest) {
  String[] t = new String[1];
  t[0] = src;
  saveStrings(dest, t);
}

void saveDailyQuote(String url, String path) {
  String text = getTextFromRSS(url);

  String t = getDailyQuote(text);

  makeFile(t, path);
}

String getDailyQuote(String s) {
  String r = new String();
  String t = s;
  int start, end;
  String[] headings = 
    {
    "Daily Quote: " 

  };

  for (int i = 0; i < headings.length; i++) {
    start = t.indexOf(headings[i]);
    if (start != -1) {
      t = t.substring(start);
      end = t.indexOf(" EST");
      r += t.substring(0, end - 25) + '\n';
    }
  }


  return r;
}

void saveZmanim(String url, String path) {
  String text = getTextFromRSS(url);

  String t = getZmanim(text);

  makeFile(t, path);
}

String getZmanim(String s) {
  String r = new String();
  String t = s;
  int start, end;
  String[] headings = 
    {
    //"Dawn (Alot Hashachar) - ", 
    // "Earliest Tallit and Tefillin (Misheyakir) - ", 
    "Sunrise (Hanetz Hachamah) - ", 
    "Latest Shema - ", 
    // "Latest Shacharit - ", 
    // "Midday (Chatzot Hayom) - ", 
    // "Earliest Mincha (Mincha Gedolah) - ", 
    // "Plag Hamincha (“Half of Mincha”) - ", 
    "Sunset (Shkiah) - ", 
    "Nightfall (Tzeit Hakochavim) - ", 
    // "Midnight (Chatzot HaLailah) - "
  };

  for (int i = 0; i < headings.length; i++) {
    start = t.indexOf(headings[i]);
    if (start != -1) {
      t = t.substring(start);
      end = t.indexOf("--");
      r += t.substring(0, end) + '\n';
    }
  }


  return r;
}
