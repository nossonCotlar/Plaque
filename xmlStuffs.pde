import http.requests.*;

void makeXml(String url, String dest){
  String[] l = new String[1];
  GetRequest get = new GetRequest(url);
  get.send();
  
  l[0] = get.getContent();
  
  saveStrings(dest, l);
  
}
