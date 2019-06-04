class Theme {
  PImage bg;
  Scroller scroll1, scroll2;
  TextBox text;
  SlideShow slide;
  SideScroller sideScroll;

  Theme(String path) {
    bg = loadImage(path);
    fit();

    slide = new SlideShow("/resources/pics/", 650, 100, 750, 430, 3);
    text = new TextBox("/resources/textTest.txt", 45, 130, 340, 730, 30);
    scroll1 = new Scroller("/resources/scrollTest.txt", 630, 550, 720, 300, 25, 1);
    scroll2 = new Scroller("/resources/scrollTest.txt", 1600, 100, 300, 730, 30, 1);
    sideScroll = new SideScroller("/resources/sideTest.txt", 20, 990, width - 20, 65, 25, 3);
  }

  void update() {
    background(200);

    text.update();
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
