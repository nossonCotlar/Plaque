 //<>//
public class SlideShow extends Element {

  private PImage[] pics;
  private String[] paths;
  private int amount, current;
  private double counter, check;
  private float speed, offset;
  private boolean stop;

  SlideShow(String path, int x, int y, int sizeX, int sizeY, int speed) {
    super(x, y, sizeX, sizeY);
    current = 0;
    counter = 0;
    check = 0;
    offset = 10;
    stop = false;
    this.speed = speed;

    loadImages(path);

    //resizeImages();
  }

  public void update() {
    change();
    show();
  }

  private void show() {
    //showBox();
    if (pics[current] == null) return;
    image(pics[current], x + (sizeX - pics[current].width) / 2, y);
  }

  private void change() {
    counter = frameCount;
    if (counter - check >= speed * frameRate) {
      check = counter;
      current++;
      if (current >= amount) current = 0;
      //show(); //we call show only when the picture changes to mak sure we don't draw when it's necessary
    }
  }

  private void loadImages(String path) {
    File[] files = listFiles(path); //get file array from directory
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
    for (int i = 0; i < pics.length; i++) {
      g.removeCache(pics[i]);
      pics[i] = null;
    }
    pics = null;
  }
}
