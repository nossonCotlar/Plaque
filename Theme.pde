public class Theme {
  private Element[] elements;
  private PImage bg, behind;
  private Zmanim zmanim;

  Theme() {
    bg = loadImage("/resources/theme/" + config.getString("theme") + "/theme.png");
    behind = loadImage("/resources/theme/" + config.getString("theme") + "/behind.png");
    fit();

    zmanim = new Zmanim("/resources/RESTapi/creds.json");

    saveZmanim(readURLFromFile("/resources/data/url.txt"), "/resources/texts/times.txt");
    saveDailyQuote("https://www.chabad.org/tools/rss/dailyquote_rss.xml", "/resources/texts/quote.txt");

    initElements();

    //printArray(loadStrings(getPathToParshaContent()));

    System.gc();
  }


  public void initElements() {
    elements = new Element[] {
      //new SlideShow("/resources/pics/", 727, 672, 453, 260, 3), 
      new Clock(width / 2, 166, 180, 71, true), 
      new AnalogClock(width / 2, 250, 120), 
      new Scroller("/resources/texts/bottomRight.txt", 1360, 645, 400, 230, config.getInt("bottomRightPanelTextSize"), .7, true), 
      //new Scroller("/resources/texts/middle.txt", 738, 433, 430, 250, 30, .7, true), 
      new Scroller("/resources/texts/topRight.txt", 1360, 390, 400, 230, config.getInt("topRightPanelTextSize"), .7, true), 
      new Scroller(getPathToParshaContent(), 172, 405, 390, 460, config.getInt("leftPanelTextSize"), config.getInt("leftPanelScrollSpeed"), false), 
      new TextBox("/resources/texts/bottom.txt", width / 2, 1020, 0, 0, 25) };

    switch(config.getString("graphicSetting")) {
    case "NONE":
      elements = (Element[])append(elements, new Scroller("/resources/texts/middle.txt", 738, 433, 430, 250, config.getInt("middlePanelTextSize"), .7, true));
      break;
    case "PICS_AND_STATIC":

      elements = (Element[])append(elements, new SlideShow("/resources/pics/", 727, 672, 453, 260, 3));
      elements = (Element[])append(elements, new StaticPic(801, 380, 315, 260));
      break;
    case "PICS":
      elements = (Element[])append(elements, new Scroller("/resources/texts/middle.txt", 738, 433, 430, 250, config.getInt("middlePanelTextSize"), .7, true));
      elements = (Element[])append(elements, new SlideShow("/resources/pics/", 727, 672, 453, 260, 3));
      break;
    default:
      println("failed");
      break;
    }
  }

  public void update() {
    //background(200);
    showBehind();
    show();
    for (int i = 0; i < elements.length; i++) elements[i].update();
  }

  private void show() {
    image(bg, 0, 0);
  }

  private void showBehind() {
    image(behind, 0, 0);
  }

  private void fit() {
    if (bg.width != width || bg.height != height) {
      bg.resize(width, height);
    }
  }


  public void destroy() {

    for (Element e : elements) e.destroy();

    g.removeCache(bg);
    g.removeCache(behind);
  }
}
