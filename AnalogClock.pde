class AnalogClock extends Element{

  private float rad;
  private int hr, mn, sc;
  private float scAng, mnAng, hrAng;



  AnalogClock(float x, float y, float rad) {
    super(x, y, 0, 0);
    this.rad = rad;
    setAngles();
  }

  void update() {
    setAngles();
    show();
  }

  void show() {
    pushStyle();
    
    //draw the circe graphic
    //image(outline, x - wid, y - hi);

    //second hand
    strokeWeight(3);
    stroke(200);
    pushMatrix();
    translate(x, y);
    rotate(scAng);
    line(0, 0, 0, -rad + 16);
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
    //outline = null;
  }
  
  
}
