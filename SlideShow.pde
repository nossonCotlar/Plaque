 //<>//
class SlideShow extends Element{

  PImage[] pics;
  int amount, current;
  double counter, check;
  float x, y, sizeX, sizeY, speed, offset;
  boolean stop;

  SlideShow(String path, int x, int y, int sizeX, int sizeY, int speed){
    super(x, y, sizeX, sizeY);
    current = 0;
    counter = 0;
    check = 0;
    offset = 10;
    stop = false;
    this.speed = speed;

    loadImages(path);
    resizeImages();
  }

  void update() {
    change();
    show();
  }

  void show() {
    //showBox();
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
      //show(); //we call show only when the picture changes to mak sure we don't draw when it's necessary
    }
  }

  void loadImages(String path) {
    File[] files = listFiles(path); //get file array from directory
    amount = files.length;
    if(amount == 0){
      amount = 1;
     pics = new PImage[1];
     pics[0] = loadImage("/resources/data/nothing/nothing.jpg");
     return;
    }
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
  
  void destroy(){
    for(int i = 0; i < pics.length; i++){
     g.removeCache(pics[i]); 
    }
   pics = null; 
  }
}
