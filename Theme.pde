public class Theme {
  private Element[] elements;
  private PImage bg, behind;
  private String leftTitle, rightTitle;
  private Zmanim zmanim;

  Theme() {
    bg = loadImage("/resources/theme/" + config.getString("theme") + "/theme.png");
    behind = loadImage("/resources/theme/" + config.getString("theme") + "/behind.png");
    fit();
    leftTitle = config.getString("leftPanelTitle");
    rightTitle = config.getString("rightPanelTitle");


    saveDailyQuote("https://www.chabad.org/tools/rss/dailyquote_rss.xml", "/resources/texts/quote.txt");
    initParsha();
    zmanim = new Zmanim("/resources/RESTapi/creds.json");
    zmanim.exportToText("/resources/RESTapi/times.txt");

    //saveZmanim(readURLFromFile("/resources/data/url.txt"), "/resources/texts/times.txt");

    pullParshaContent();

    initElements();

    //printArray(loadStrings(getPathToParshaContent()));

    System.gc();
  }


  public void initElements() {
    elements = new Element[] {
      //new SlideShow("/resources/pics/", 727, 672, 453, 260, 3), 
      new Clock(width / 2, height / 6.5060, width / 6, height / 15.2112676, true), 
      new AnalogClock(width / 2, width / 7.68, height / 9), 
      new TextBox("/resources/texts/middle.txt", width / 2, height / 2.37, width / 4.465116, height / 4.32, config.getInt("middlePanelTextSize") * width / 1920, true, false), 
      //new Scroller("/resources/texts/middle.txt", 738, 433, 430, 250, 30, .7, true), 
      new TextBox("/resources/RESTapi/times.txt", width / 1.41176, height / 2.9, width / 4.8, height / 4.69565, config.getInt("topRightPanelTextSize") * width / 1920, false, false), 
      new Scroller("/resources/texts/left.txt", width / 11.1, height / 2.667, width / 4.923, height / 2.3478, config.getInt("leftPanelTextSize") * width / 1920, config.getInt("leftPanelScrollSpeed"), false),
      //new Scroller("/resources/texts/bottomRight.txt", width / 1.41176, height / 1.8848, width / 4.8, height / 4.69565, config.getInt("bottomRightPanelTextSize") * width / 1920, .7, false), 

      new TextBox("/resources/texts/bottom.txt", width / 2, height / 1.05882, 0, 0, 25 * width / 1920, true, true) };

    switch(config.getString("graphicSetting")) {
    case "NONE":
      elements = (Element[]) append(elements, new TextBox("/resources/texts/bottomRight.txt", width / 1.41176, height / 1.87000, width / 4.8, height / 9.3913, config.getInt("bottomRightPanelTextSize") * width / 1920, false, false));
     
      break;
    case "PICS_AND_STATIC":
      elements = (Element[]) append(elements, new TextBox("/resources/texts/bottomRight.txt", width / 1.41176, height / 1.87000, width / 4.8, height / 9.3913, config.getInt("bottomRightPanelTextSize") * width / 1920, false, false));

      elements = (Element[])append(elements, new SlideShow("/resources/pics/", width / 2.64099, height / 1.60714, width / 4.23841, height / 4.15385, config.getInt("slideShowSpeed")));
      elements = (Element[])append(elements, new StaticPic(width / 1.41176, height / 1.463414, width / 4.8, height / 6.35294));
      break;
    case "PICS":
      //elements = (Element[])append(elements, new Scroller("/resources/texts/middle.txt", width / 2.6016, height / 2.4942, width / 4.465116, height / 4.32, config.getFloat("middlePanelTextSize") * width / 1920, .7, true));
      elements = (Element[]) append(elements, new TextBox("/resources/texts/bottomRight.txt", width / 1.41176, height / 1.87000, width / 4.8, height / 9.3913, config.getInt("bottomRightPanelTextSize") * width / 1920, false, false));
      elements = (Element[])append(elements, new SlideShow("/resources/pics/", width / 2.64099, height / 1.60714, width / 4.23841, height / 4.15385, config.getInt("slideShowSpeed")));
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
    showTitles();
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
    if (behind.width != width || behind.height != height) {
      behind.resize(width, height);
    }
  }
  
  private void showTitles(){
    textFont(font2);
    fill(textColor2);
    textSize(height / 18);
    textAlign(CENTER, CENTER);
    text(leftTitle, width / 5.4, height / 3.76306);
    text(rightTitle, width / 1.225, height / 3.76306);
    textFont(font);
  }


  public void destroy() {

    for (Element e : elements) e.destroy();

    g.removeCache(bg);
    g.removeCache(behind);
  }
}
