public class StaticPic extends Element {
  PImage pic;
  StaticPic(float x, float y, float sizeX, float sizeY) throws RuntimeException{
    super(x, y, sizeX, sizeY);
    File file = listFiles("/resources/static")[0]; //get file array from directory
    if(file == null) throw new RuntimeException("No images found in \"static\" folder\n Place images in the folder or \n select a different Graphic Setting in config.json");
    try{
      pic = loadImage(file.getPath());
      pic.resize(int(sizeX), 0);
    if (pic.height > sizeY) pic.resize(0, int(sizeY));
    } catch (Exception e){
      throw new RuntimeException("Error reading file in \"static\" folder\n Please ensure that all files in the folder are \n valid image files");
    }
    
  }

  public void update() {
    if (!secondChanged) return;
    imageMode(CENTER);
    image(pic, x, y);
    imageMode(CORNER);
  }

  public void destroy() {
    pic = null;
  }
}
