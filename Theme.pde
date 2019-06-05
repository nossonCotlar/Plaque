class Theme {
  PImage bg;
  Scroller scroll1, scroll2, times;
  //textBox text;
  SlideShow slide;
  SideScroller sideScroll;
  Clock clock;

  Theme(String path) {
    bg = loadImage(path);
    fit();

    clock = new Clock(890, 930);


    initZmanim();
    initSlideShow();
    scroll1 = new Scroller("/resources/scroll2.txt", 45, 80, 340, 730, 25, 2);
    scroll2 = new Scroller("/resources/scroll1.txt", 1600, 75, 300, 730, 25, 1);
    sideScroll = new SideScroller("/resources/sideTest.txt", 20, 990, width - 20, 65, 25, 3);
  }

  void update() {
    background(200);


    times.update();
    scroll1.update();
    scroll2.update();
    sideScroll.update();
    slide.update();
    clock.update();

    show();
  }

  void show() {
    image(bg, 0, 0);
  }

  void fit() {
    if (bg.width != width || bg.height != height) {
      bg.resize(width, height);
    }
  }

  String readURLFromFile(String file) {
    String[] l = new String[1];

    l = loadStrings(file);
    return l[0];
  }


  void initZmanim() {
    try {
      saveZmanim(readURLFromFile("/resources/data/url.txt"), "/resources/times.txt");
      times = new Scroller("/resources/times.txt", 630, 550, 1000, 300, 30, .7);
    } 
    catch(Exception e) {
      times = new Scroller("/resources/data/error.txt", 630, 550, 1000, 300, 30, .7);
    }
  }
  void initSlideShow() {
    try {
      slide = new SlideShow("/resources/pics/", 650, 100, 750, 430, 3);
    } 
    catch(Exception e) {
      try {
        slide = new SlideShow("/resources/data/nothing/", 650, 100, 750, 430, 3);
      } 
      catch(Exception f) {
        println("nothing here, sorry");
      }
    }
  }
}
