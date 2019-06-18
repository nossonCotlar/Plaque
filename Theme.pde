class Theme {
  Element[] elements;
  PImage bg, behind;
  /*
  Scroller quote, shulTimes, times, donors;
  //SlideShow slide;
  SideScroller sideScroll;
  Clock clock;
  AnalogClock analog;
  */

  Theme(String path) {
    bg = loadImage(path);
    behind = loadImage("/resources/theme/behind.png");
    fit();
    
    saveZmanim(readURLFromFile("/resources/data/url.txt"), "/resources/texts/times.txt");
    saveDailyQuote("https://www.chabad.org/tools/rss/dailyquote_rss.xml", "/resources/texts/quote.txt");

    elements = new Element[] {
      new Clock(width / 2, 166, 180, 71, true), 
      new AnalogClock(width / 2, 250, 120), 
      new Scroller("/resources/texts/shulTimes.txt", 1360, 645, 400, 230, 20, .7, true), 
      new Scroller("/resources/texts/donors.txt", 738, 433, 430, 250, 30, .7, true), 
      new SideScroller("/resources/texts/sideTest.txt", 0, 995, width, 65, 25, 3), 
      new Scroller("/resources/texts/times.txt", 1360, 390, 400, 230, 20, .7, true), 
      new Scroller("/resources/texts/quote.txt", 172, 390, 390, 500, 25, 2, true)
    };
    /*
    initZmanim();
     //initSlideShow();
     initDaily();
     clock = new Clock(width / 2, 166, 180, 71, true);
     analog = new AnalogClock(width / 2, 250, 120);
     shulTimes = new Scroller("/resources/texts/shulTimes.txt", 1360, 645, 400, 230, 20, .7, true);
     donors = new Scroller("/resources/texts/donors.txt", 738, 433, 430, 250, 30, .7, true);
     sideScroll = new SideScroller("/resources/texts/sideTest.txt", 0, 995, width, 65, 25, 3);
     */
    //background(backColor);
    stop = false;
  }

  void update() {
    //background(200);

    showBehind();
    elements[2].update();
    elements[5].update();
    elements[6].update();
    //slide.update();
    elements[3].update();
    show();
    elements[0].update();
    elements[1].update();
    elements[4].update();
  }

  void show() {
    image(bg, 0, 0);
  }

  void showBehind() {
    image(behind, 119, 232);
    image(behind, 711, 232);
    image(behind, 1310, 232);
  }

  void fit() {
    if (bg.width != width || bg.height != height) {
      bg.resize(width, height);
    }
  }




  void initZmanim() {
    saveZmanim(readURLFromFile("/resources/data/url.txt"), "/resources/texts/times.txt");
    //times = new Scroller("/resources/texts/times.txt", 1360, 390, 400, 230, 20, .7, true);
  }

  void initSlideShow() {
    //slide = new SlideShow("/resources/pics/", 727, 680, 455, 250, 3);
  }

  void initDaily() {
    saveDailyQuote("https://www.chabad.org/tools/rss/dailyquote_rss.xml", "/resources/texts/quote.txt");
    //quote = new Scroller("/resources/texts/quote.txt", 172, 390, 390, 500, 25, 2, true);
  }

  void destroy() {

   

    g.removeCache(bg);
    g.removeCache(behind);

    
  }
}
