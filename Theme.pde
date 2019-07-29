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
    //saveDailyQuote("https://www.chabad.org/tools/rss/dailyquote_rss.xml", "/resources/texts/quote.txt");

    initElements();
    
    //printArray(loadStrings(getPathToParshaContent()));

    System.gc();
  }

  public void initElements() {
    elements = new Element[] {
      new SlideShow("/resources/pics/", 727, 672, 453, 260, 3), 
      new Clock(width / 2, 166, 180, 71, true), 
      new AnalogClock(width / 2, 250, 120), 
      new Scroller("/resources/texts/shulTimes.txt", 1360, 645, 400, 230, 20, .7, true), 
      new Scroller("/resources/texts/donors.txt", 738, 433, 430, 250, 30, .7, true), 
      new Scroller("/resources/texts/times.txt", 1360, 390, 400, 230, 20, .7, true), 
      new Scroller(getPathToParshaContent(), 172, 405, 390, 460, 17, .5, false), 
      new SideScroller("/resources/texts/sideTest.txt", 0, 995, width, 65, 25, 2) };
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
