public class StaticPic extends Element {
  PImage pic;
 StaticPic(float x, float y, float sizeX, float sizeY){
  super(x, y, sizeX, sizeY);
  File[] files = listFiles("/resources/static"); //get file array from directory
  pic = loadImage(files[0].getPath());
  pic.resize(int(sizeX), 0);
  if(pic.height > sizeY) pic.resize(0, int(sizeY));
  
 }
 
 public void update(){
  image(pic, x, y);
 }
 
 public void destroy(){
  pic = null; 
 }
 
}
