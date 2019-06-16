class AnalogClock {

  private float rad, x, y;

  private int hr, mn, sc;
  private float scAng, mnAng, hrAng;
  private PImage outline;
  private int hi, wid;



  AnalogClock(float x, float y, float rad) {
    this.x = x;
    this.y = y;
    this.rad = rad;
    setAngles();
    outline = loadImage("/resources/clock/clockOutline.png");
    outline.resize(int(rad * 2), 0);
    hi = outline.height / 2;
    wid = outline.width / 2;
  }

  void update() {
    setAngles();
    show();
  }

  void show() {
    pushStyle();

    image(outline, x - wid, y - hi);

    /* 
     
     noFill();
     stroke(textColor1);
     circle(x, y, rad * 2);
     */

    //second hand
    strokeWeight(3);
    stroke(200);
    pushMatrix();
    translate(x, y);
    rotate(scAng);
    line(0, 0, 0, -rad + 10);
    popMatrix();

    //minute hand
    strokeWeight(4);
    stroke(100);
    pushMatrix();
    translate(x, y);
    rotate(mnAng);
    line(0, 0, 0, -rad + rad / 4);
    popMatrix();

    //hour hand
    strokeWeight(5);
    stroke(textColor2);
    pushMatrix();
    translate(x, y);
    rotate(hrAng);
    line(0, 0, 0, -rad + rad / 2);
    popMatrix();

    popStyle();
  }

  void setAngles() {
    hr = hour();
    mn = minute();
    sc = second();
    //println(sc);
    scAng = map(sc, 0, 60, 0, TWO_PI);
    mnAng = map(mn, 0, 60, 0, TWO_PI) + map(sc, 0, 60, 0, TWO_PI / 60);
    hrAng = map(hr % 12, 0, 12, 0, TWO_PI) + map(mn, 0, 60, 0, TWO_PI / 12);
  }
  
  void destroy(){
    outline = null;
  }
  
  
}
