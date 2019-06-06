 //<>//
class SlideShow {

  PImage[] pics;
  int amount, current;
  double counter, check;
  float x, y, sizeX, sizeY, speed, offset;
  boolean stop;

  SlideShow(String path, int x, int y, int sizeX, int sizeY, int speed) throws Exception {
    current = 0;
    counter = 0;
    check = 0;
    offset = 10;
    stop = false;
    this.x = x;
    this.y = y;
    this.sizeX = sizeX;
    this.sizeY = sizeY;
    this.speed = speed;

    loadImages(path);
    if (amount == 0) throw new Exception("no images in folder");
    resizeImages();
  }

  void update() {
    change();
  }

  void show() {
    showBox();
    image(pics[current], x + (sizeX - pics[current].width) / 2, y);
  }

  void showBox() {
    fill(backColor);
    rect(x - offset, y - offset, sizeX + offset * 2, sizeY + offset * 2, 10);
  }

  void change() {
    counter = frameCount;
    if (counter - check >= speed * frameRate) {
      check = counter;
      current++;
      if (current >= amount) current = 0;
      show(); //we call show only when the picture changes to mak sure we don't draw when it's necessary
    }
  }

  void loadImages(String path) {
    File[] files = listFiles(path); //get file array from directory
    amount = files.length;
    pics = new PImage[amount]; //create PImage array sized accordingly

    for (int i = 0; i < amount; i++) {
      pics[i] = loadImage(files[i].getPath());
    }
  }

  void resizeImages() {
    for (int i = 0; i < amount; i++) {
      pics[i].resize(int(sizeX), 0);
      if (pics[i].height > sizeY) {
        pics[i].resize(0, int(sizeY));
      }
    }
  }
}
