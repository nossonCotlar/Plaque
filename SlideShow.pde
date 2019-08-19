 //<>//
public class SlideShow extends Element {

  private PImage[] pics;
  private PImage[] test;
  private File[] files;
  private int currentPic;
  private int currentSecond, lastSecond;
  private int amount, current;
  private int speed;
  //private boolean stop;

  SlideShow(String path, float x, float y, float sizeX, float sizeY, int speed) {
    super(x, y, sizeX, sizeY);
    current = 0;
    currentSecond = byte(second());
    lastSecond = currentSecond;
    stop = false;
    this.speed = speed;

    test = new PImage[2];
    files = listFiles(path);
    amount = files.length;
    currentPic = 0;
    current = 0;



    //loadImages(path);
  }

  public void update() {
    change();
    resizeOnce();
    show();
  }

  private void show() {
    //showBox();
    if (test[currentPic] == null) return;
    if (test[currentPic].width == 0) return;


    image(test[currentPic], x + (sizeX - test[currentPic].width) / 2, y);
  }

  private void change() {
    currentSecond = second();
    if (currentSecond / speed != lastSecond) {
      lastSecond = currentSecond / speed;
      current++;
      currentPic++;
      if (currentPic >= 2) currentPic = 0;
      if (current >= amount) current = 0;
      test[currentPic] = requestImage(files[current].getPath());
      //show(); //we call show only when the picture changes to mak sure we don't draw when it's necessary
    }
  }

  private void resizeOnce() {
    if (test[currentPic].width > sizeX) {
      test[currentPic].resize(int(sizeX), 0);
      if (test[currentPic].height > sizeY) test[currentPic].resize(0, int(sizeY));
    }
  }

  private void loadImages(String path) {
    files = listFiles(path); //get file array from directory
    amount = files.length;
    if (amount == 0) {
      amount = 1;
      pics = new PImage[1];
      pics[0] = loadImage("/resources/data/nothing/nothing.jpg");
      pics[0].resize(int(sizeX), 0);
      return;
    }
    pics = new PImage[amount]; //create PImage array sized accordingly

    for (int i = 0; i < amount; i++) {
      pics[i] = loadImage(files[i].getPath()); //load images

      pics[i].resize(int(sizeX), 0); //then resize
      if (pics[i].height > sizeY) {
        pics[i].resize(0, int(sizeY));
      }
    }
  }

  public void destroy() {
    for (int i = 0; i < test.length; i++) {
      g.removeCache(test[i]);
      test[i] = null;
    }
    test = null;
  }
}
