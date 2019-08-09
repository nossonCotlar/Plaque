class AnalogClock extends Element{

  private float rad;
  private int hr, mn, sc;
  private float scAng, mnAng, hrAng;
  private float scStroke, mnStroke, hrStroke;
  private int lastSecond;



  AnalogClock(float x, float y, float rad) {
    super(x, y, 0, 0);
    this.rad = rad;
    //setAngles();
    setStrokeWeights();
    lastSecond = second();
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
    strokeWeight(scStroke);
    stroke(200);
    pushMatrix();
    translate(x, y);
    rotate(scAng);
    line(0, 0, 0, -rad + rad / 7);
    popMatrix();

    //minute hand
    strokeWeight(mnStroke);
    stroke(100);
    pushMatrix();
    translate(x, y);
    rotate(mnAng);
    line(0, 0, 0, -rad + rad / 4);
    popMatrix();

    //hour hand
    strokeWeight(hrStroke);
    stroke(textColor2);
    pushMatrix();
    translate(x, y);
    rotate(hrAng);
    line(0, 0, 0, -rad + rad / 2);
    popMatrix();
    
    

    popStyle();
  }

  void setAngles() {
    if(second() == lastSecond) return; //makes sure we don't call thsi between seconds unnecessarily
    lastSecond = second();
    
    hr = hour();
    mn = minute();
    sc = second();
    //println(sc);
    scAng = map(sc, 0, 60, 0, TWO_PI);
    mnAng = map(mn, 0, 60, 0, TWO_PI) + map(sc, 0, 60, 0, TWO_PI / 60);
    hrAng = map(hr % 12, 0, 12, 0, TWO_PI) + map(mn, 0, 60, 0, TWO_PI / 12);
  }
  
  private void setStrokeWeights(){
    scStroke = height / 360;
    mnStroke = height / 270;
    hrStroke = height / 216;
  }
  
  
  void destroy(){
    //outline = null;
  }
  
  
}
