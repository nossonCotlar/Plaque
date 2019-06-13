class AnalogClock{
 
  float rad, x, y;
  color fill;
  
  int hr, mn, sc;
float scAng, mnAng, hrAng;


  
  AnalogClock(float x, float y, float rad){
    this.x = x;
    this.y = y;
    this.rad = rad;
    setAngles();
    
    fill = color(193, 139, 0);
  }
  
  void update(){
   setAngles();
   show();
  }
  
  void show(){
    pushStyle();
    
    strokeWeight(5);
    noFill();
    stroke(fill);
  circle(x, y, rad * 2);
  
  
  stroke(0);
  pushMatrix();
  translate(x, y);
  rotate(scAng);
  line(0, 0, 0, -rad);
  popMatrix();
  
  stroke(100);
  pushMatrix();
  translate(x, y);
  rotate(mnAng);
  line(0, 0, 0, -rad + rad / 4);
  popMatrix();
  
  stroke(200);
  pushMatrix();
  translate(x, y);
  rotate(hrAng);
  line(0, 0, 0, -rad + rad / 2);
  popMatrix();
  
  popStyle();
  }
  
  void setAngles(){
   hr = hour();
  mn = minute();
  sc = second();
  //println(sc);
  scAng = map(sc, 0, 60, 0, TWO_PI);
  mnAng = map(mn, 0, 60, 0, TWO_PI) + map(sc, 0, 60, 0, TWO_PI / 60);
  hrAng = map(hr % 12, 0, 12, 0, TWO_PI) + map(mn, 0, 60, 0, TWO_PI / 60); 
  }
  
}
