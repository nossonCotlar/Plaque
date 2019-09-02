public class Theme {
  private Element[] elements;
  private PImage bg, behind;
  private String mainTitle, middleTitle, leftTitle, rightTitle;

  Theme() throws RuntimeException {
    try {
      bg = loadImage("/resources/theme/" + config.getString("theme") + "/theme.png");
      behind = loadImage("/resources/theme/" + config.getString("theme") + "/behind.png");
      fit();
      leftTitle = config.getString("leftPanelTitle");
      rightTitle = config.getString("rightPanelTitle");
      mainTitle = config.getString("mainTitle");
      middleTitle = config.getString("middleTitle");



      saveDailyQuote("https://www.chabad.org/tools/rss/dailyquote_rss.xml", "/resources/texts/quote.txt"); //this saves quote just to get the Hebrew date info :) 
      zmanim = new Zmanim();


      initElements();
    } 
    catch (RuntimeException e) {
      throw e;
    }

    System.gc();
    loop();
  }


  public void initElements() throws RuntimeException {
    elements = new Element[] {
      new Clock(width / 2, height / 6.5060, width / 6, height / 15.2112676, true), 
      new AnalogClock(width / 2, width / 7.68, height / 9), 
      // middle / donors:
      new TextBox("/resources/texts/middle.txt", width / 2, height / 2.37, width / 4.465116, height / 4.32, config.getInt("middlePanelTextSize") * width / 1920, true, false, false), 
      // halachic times: 
      new TextBox("/resources/RESTapi/times.txt", width / 1.41176, height / 2.9, width / 4.8, height / 4.69565, config.getInt("topRightPanelTextSize") * width / 1920, false, false, false), 
      // torah content: 
      new TextBox("/resources/texts/left.txt", width / 11.36094, height / 3.148688, width / 4.72906, height / 1.85, config.getFloat("leftPanelTextSize") * width / 1920, false, false, true), 
      // annoucements: 
      new TextBox("/resources/texts/bottomRight.txt", width / 1.41176, height / 1.87000, width / 4.8, height / 9.3913, config.getInt("bottomRightPanelTextSize") * width / 1920, false, false, false), 
      // memorial:
      new TextBox("/resources/texts/bottom.txt", width / 2, height / 1.05882, 0, 0, 25 * width / 1920, true, true, false) 
    };

    switch(config.getString("graphicSetting")) {
    case "NONE":
      break;
    case "PICS_AND_STATIC":
      elements = (Element[])append(elements, new SlideShow("/resources/pics/", width / 2, height / 1.35, width / 4.02439, height / 4.444444, config.getInt("slideShowSpeed")));
      elements = (Element[])append(elements, new StaticPic(width / 1.231558, height / 1.28724, width / 4.8, height / 6.35294));
      break;
    case "PICS":
      elements = (Element[])append(elements, new SlideShow("/resources/pics/", width / 2, height / 1.35, width / 4.02439, height / 4.444444, config.getInt("slideShowSpeed")));
      break;
    default:
      throw new RuntimeException("Unsupported Graphic Setting selected; check config.json");
    }
  }

  public void update() {
    if (secondChanged) {
      //background(200);
      showBehind();
      show();
      showTitles();
    }
    try {
      for (int i = 0; i < elements.length; i++) elements[i].update();
    } 
    catch (RuntimeException e) {
      generalMessage(e.getMessage());
    }
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

  private void showTitles() {
    textFont(font2);
    fill(textColor2);
    textSize(height / 18);
    textAlign(CENTER, CENTER);
    text(leftTitle, width / 5.4, height / 3.76306);
    text(rightTitle, width / 1.225, height / 3.76306);

    textFont(font3);
    textSize(height / 18);
    text(mainTitle, width / 2, height / 15.5);
    textSize(height / 28);
    text(middleTitle, width / 2, height / 2.7);


    textFont(font);
  }


  public void destroy() {

    for (Element e : elements) e.destroy();

    g.removeCache(bg);
    g.removeCache(behind);
  }
}
