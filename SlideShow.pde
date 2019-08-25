 //<>//
public class SlideShow extends Element {

  private PImage[] test;
  private File[] files;
  private int currentPic;
  private int currentSecond, lastSecond;
  private int amount, current;
  private int speed;

  SlideShow(String path, float x, float y, float sizeX, float sizeY, int speed) throws RuntimeException {
    super(x, y, sizeX, sizeY); 
    current = 0;
    currentSecond = byte(second());
    lastSecond = currentSecond;
    this.speed = speed;

    test = new PImage[2];
    files = listFiles(path);
    amount = files.length;
    if(amount == 0) throw new RuntimeException("No images found in \"pics\" folder\n Place images in the folder or \n select a different Graphic Setting in config.json");
    currentPic = 0;
    current = 0;

  }

  public void update() {
    
    
    if(secondChanged) show();
    change();
    resizeOnce();
  }

  private void show() {
    //showBox();
    if (test[currentPic] == null) return;
    if (test[currentPic].width == 0 || test[currentPic].width > sizeX) return;
    
    imageMode(CENTER);

    image(test[currentPic], x, y);
    
    imageMode(CORNER);
  }

  private void change() throws RuntimeException{
    currentSecond = second();
    if (currentSecond / speed != lastSecond) {
      lastSecond = currentSecond / speed;
      g.removeCache(test[currentPic]);
      current++;
      currentPic++;
      if (currentPic >= 2) currentPic = 0;
      if (current >= amount) current = 0;
      
      try{
      test[currentPic] = requestImage(files[current].getPath());
      } catch (RuntimeException e){
       throw new RuntimeException("Error reading file in \"pics\" folder\n Please ensure that all files in the folder are \n valid image files"); 
      }
      //show(); //we call show only when the picture changes to mak sure we don't draw when it's necessary
    }
  }

  private void resizeOnce() {
    if (test[currentPic].width > sizeX) {
      test[currentPic].resize(int(sizeX), 0);
      if (test[currentPic].height > sizeY) test[currentPic].resize(0, int(sizeY));
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
