class Theme {
  PImage bg, behind;
  Scroller scroll1, shulTimes, times;
  SlideShow slide;
  SideScroller sideScroll;
  Clock clock;

  Theme(String path) {
    bg = loadImage(path);
    behind = loadImage("/resources/theme/behind.png");
    fit();

    clock = new Clock(width / 2, 166, 180, 71);


    initZmanim();
    initSlideShow();
    initHayom();
    shulTimes = new Scroller("/resources/shulTimes.txt", 1360, 645, 400, 230, 20, .7, true);
    sideScroll = new SideScroller("/resources/sideTest.txt", 0, 995, width, 65, 25, 3);
    background(backColor);
  }

  void update() {
    //background(200);

    showBehind();
    shulTimes.update();
    times.update();
    scroll1.update();
    slide.update();
    show();
    sideScroll.update();
    clock.update();
    
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
    try {
      saveZmanim(readURLFromFile("/resources/data/url.txt"), "/resources/times.txt");
      times = new Scroller("/resources/times.txt", 1360, 390, 400, 230, 20, .7, true);
    } 
    catch(Exception e) {
      times = new Scroller("/resources/data/error.txt", 1360, 390, 400, 230, 20, .7, true);
    }
  }

  void initSlideShow() {
    try {
      slide = new SlideShow("/resources/pics/", 711, 344, 495, 300, 3);
    } 
    catch(Exception e) {
      try {
        slide = new SlideShow("/resources/data/nothing/", 711, 344, 495, 300, 3);
      } 
      catch(Exception f) {
        println("nothing here, sorry");
      }
    }
  }

  void initHayom() {
    try {
      saveDailyQuote("https://www.chabad.org/tools/rss/dailyquote_rss.xml", "/resources/quote.txt");
      scroll1 = new Scroller("/resources/quote.txt", 172, 390, 390, 500, 25, 2, false);
    } 
    catch(Exception e) {
      scroll1 = new Scroller("/resources/data/error.txt", 172, 390, 390, 500, 25, 2, false);
    }
  }
  

}
