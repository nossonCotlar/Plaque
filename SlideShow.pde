 //<>//
class SlideShow {

  PImage[] pics;
  int amount, current;
  double counter, check;
  float x, y, sizeX, sizeY, speed, offset;

  SlideShow(String path, int x, int y, int sizeX, int sizeY, int speed) {
    current = 0;
    counter = 0;
    check = 0;
    offset = 10;
    this.x = x;
    this.y = y;
    this.sizeX = sizeX;
    this.sizeY = sizeY;
    this.speed = speed;

    loadImages(path);
    resizeImages();
  }

  void update() {
    change();
    show();
  }

  void show() {
    fill(200);
    showBox();
    
    image(pics[current], x, y);
    
  }
  
  void showBox(){
   rect(x - offset, y - offset, sizeX + offset * 2, sizeY + offset * 2, 10); 
  }

  void change() {
    counter = frameCount;
    if (counter - check >= speed * frameRate) {
      check = counter;
      current++;
    }
    if (current >= amount) current = 0;
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
      if (pics[i].height > sizeY){
      pics[i].resize(0, int(sizeY));
      }
    }
  }
}
