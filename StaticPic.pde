public class StaticPic extends Element {
  PImage pic;
 StaticPic(float x, float y, float sizeX, float sizeY){
  super(x, y, sizeX, sizeY);
  File file = listFiles("/resources/static")[0]; //get file array from directory
  pic = loadImage(file.getPath());
  pic.resize(int(sizeX), 0);
  if(pic.height > sizeY) pic.resize(0, int(sizeY));
  
 }
 
 public void update(){
  image(pic, x + (sizeX - pic.width) / 2, y);
 }
 
 public void destroy(){
  pic = null; 
 }
 
}
