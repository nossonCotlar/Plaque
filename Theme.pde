class Theme {
  PImage bg;
  Scroller scroll1, scroll2, scroll3;
  //textBox text;
  SlideShow slide;
  SideScroller sideScroll;

  Theme(String path) {
    bg = loadImage(path);
    fit();
    
    saveZmanim();

    slide = new SlideShow("/resources/pics/", 650, 100, 750, 430, 3);
    scroll3 = new Scroller("/resources/times.txt", 630, 550, 1000, 300, 30, .7);
    scroll1 = new Scroller("/resources/scroll2.txt", 45, 80, 340, 730, 25, 2);
    scroll2 = new Scroller("/resources/scroll1.txt", 1600, 75, 300, 730, 25, 1);
    sideScroll = new SideScroller("/resources/sideTest.txt", 20, 990, width - 20, 65, 25, 3);
  }

  void update() {
    background(200);

    scroll3.update();
    scroll1.update();
    scroll2.update();
    sideScroll.update();
    slide.update();

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
}
