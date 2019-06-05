import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import http.requests.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class Plaque extends PApplet {

// Nosson Cotlar
// Copyright 2019

Theme theme;
//PFont font;


public void setup() {
  
  frameRate(60);
  rectMode(CORNER);
  noStroke();
  //font = loadFont("font.vlw");
  //textFont(font);
  
  theme = new Theme("/resources/theme/theme1.png");
  
}

public void draw() {
  background(255);
  theme.update();
  

  
  
  println(mouseX , ' ' , mouseY);
  
}


public void keyPressed(){
 if(key == 'p') saveFrame(); 
}
class Clock{
  int s, m, h;
  float x, y;
  String time;
  
  
 Clock(float x, float y){
   this.x = x;
   this.y = y;
   s = second();
   m = minute();
   h = hour();
 }
 
 public void update(){
   s = second();
   m = minute();
   h = hour();
   
   time = h + ":";
   if(m < 10) time += '0';
   time += m + ":";
   if(s < 10) time += '0';
   time += s;
   
   show();
 }
 
 public void show(){
   fill(0);
   textSize(37);
   text(time, x, y);
   
 }
 
}
class Scroller { //<>//
  PFont font;
  float x, y, sizeX, sizeY;
  float cx, cy, oy;
  float scrollSpeed;
  StringList lines;
  int textFill;
  float textSize, offset;


  Scroller(String s, int x, int y, int sizeX, int sizeY, int textSize, float speed) {
    lines = new StringList();
    this.x = x;
    this.y = y;
    this.sizeX = sizeX;
    this.sizeY = sizeY;
    cx = x;
    cy = y + sizeY;
    oy = cy;
    this.textSize = textSize;
    offset = 5;
    this.scrollSpeed = speed;
    textFill = color(0);
    generateFromFile(s);
  }

  public void scrollDown() {
    cy -= scrollSpeed;
    if (cy + (lines.size() * (textSize + offset)) < y ) { //once the last line is above the starting y coordinate
      cy = y + sizeY; //reset it
    }
  }



  public void show() {
    textSize(textSize);
    fill(textFill);
    int i = 0;
    for (; i < lines.size() /* && cy + (i - 2) * (textSize + offset) < y + sizeY - textSize*/; i++) {
      text(lines.get(i), cx, cy + (i * (textSize + offset)));
      //text(lines.get(i), cx, cy  + (i * (textSize + offset)) + (lines.size() * (textSize + offset)));
      text(lines.get(i), cx, cy  + (i * (textSize + offset)) - (lines.size() * (textSize + offset)));
      if (cy  + (i * (textSize + offset)) + (lines.size() * (textSize + offset)) <= oy) {
        cy = oy;
      }
    }
  }

  public void showBox() {
    fill(200);
    rect(x - offset * 2, y, sizeX, sizeY + textSize * 2, 10);
  }

  public void showBlockers() {
    fill(200);
    rect(0, 0, width, y);
    rect(0, y + sizeY + textSize * 2, width, height - y + sizeY + textSize * 2);
  }

  public void update() {
    showBox();
    scrollDown();
    show();
    showBlockers();
  }

  public void generateFromFile(String s) { //this takes a file which isn't necessarily spaced to fit the text box size, and attempts to size it properly
    String[] input = loadStrings(s);
    String temp = input[0];
    int spaceIdx = 0;
    int charPerLine = PApplet.parseInt(sizeX / (textSize ) * 2); //determines appropriate number of characters per lines based on textbox size

    for (int i = 0; i < input.length; i++) { //loops through lines of original input
      temp = input[i];
      while (temp.length() > charPerLine) { //while the current line's length is too large
        while (spaceIdx < charPerLine) { 
          int t = temp.indexOf(' ', spaceIdx + 1); //locate the nearest space in the text
          if (t == -1) break; //if nothing was found, the line doesnt contain any spaces, so we cant cut it
          if (t < charPerLine) { //if the space occurs before the maximum character number, we save the index location
            spaceIdx = t;
          } else break; //if it was past the maximum, we use the last space location
        }
        if (spaceIdx == 0) {
          lines.append(temp);
          break;
        }
        lines.append(temp.substring(0, spaceIdx)); //add a new element to the lines list, ending at the space location
        temp = temp.substring(spaceIdx + 1); //assign the temp string to a cut version of itself, starting after the space
        spaceIdx = 0; //reset space location to the beginning
      }
      lines.append(temp);
    }
    //lines.append(temp);
  }
}
class SideScroller {

  float x, y, sizeX, sizeY;
  float cx, cy, ox;
  float scrollSpeed;
  String[] lines;
  int textFill;
  float textSize, offset;
  float bw;
  int cutoff = 0;

  SideScroller(String s, int x, int y, int sizeX, int sizeY, int textSize, int speed) {
    this.x = x;
    this.y = y;
    this.sizeX = sizeX;
    this.sizeY = sizeY;
    cx = x;
    ox = cx;
    cy = y + sizeY - 10;
    this.textSize = textSize;
    offset = 5;
    this.scrollSpeed = speed;
    bw = 30;
    textFill = color(0);
    lines = loadStrings(s);
  }

  public void update() {
    scroll();
    show();
  }

  public void scroll() {
    cx -= scrollSpeed;
  }

  public void show() {

    showBox();
    float push = 0, pushAmount;
    fill(0);
    textSize(textSize);



    for (int j = 0; j < 3; j++) { //run twice so we have some overlap

      for (int i = 0; i < lines.length; i++) {
        text(lines[i], cx + push, cy); 
        pushAmount = lines[i].length() * textSize / 2 + bw;
        push += pushAmount;
        circle(cx + push - bw, cy - textSize / 2 + 5, textSize / 2);
      }
      if(cx + push <= ox){ //if the current drawing location is where the original was, we can perform a seamless reset
       for (int i = 0; i < lines.length; i++) {
        text(lines[i], cx + push, cy); 
        pushAmount = lines[i].length() * textSize / 2 + bw;
        push += pushAmount;
        circle(cx + push - bw, cy - textSize / 2 + 5, textSize / 2);
      }
        cx = ox; //reset the current writing position
        push = 0;
      }
    }



    fill(255);
    rect(0, y, x - offset * 2, sizeY + offset * 2);
    rect(x - offset * 2 + sizeX, y, 900, 400);
  }

  public void showBox() {
    fill(200);
    rect(x - offset * 2, y, sizeX, sizeY + offset * 2, 10);
  }
}

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

  public void update() {
    change();
    show();
  }

  public void show() {
    fill(200);
    showBox();
    
    image(pics[current], x, y);
    
  }
  
  public void showBox(){
   rect(x - offset, y - offset, sizeX + offset * 2, sizeY + offset * 2, 10); 
  }

  public void change() {
    counter = frameCount;
    if (counter - check >= speed * frameRate) {
      check = counter;
      current++;
    }
    if (current >= amount) current = 0;
  }

  public void loadImages(String path) {
    File[] files = listFiles(path); //get file array from directory
    amount = files.length;
    pics = new PImage[amount]; //create PImage array sized accordingly

    for (int i = 0; i < amount; i++) {
      pics[i] = loadImage(files[i].getPath());
    }
  }

  public void resizeImages() {
    for (int i = 0; i < amount; i++) {
      pics[i].resize(PApplet.parseInt(sizeX), 0);
      if (pics[i].height > sizeY){
      pics[i].resize(0, PApplet.parseInt(sizeY));
      }
    }
  }
}
class TextBox{
  float x, y, sizeX, sizeY;
  String[] lines;
  float textSize, offset;
  
  
 TextBox(String s, int x, int y, float sizeX, float sizeY, int textSize){
   this.x = x;
   this.y = y;
   this.sizeX = sizeX;
   this.sizeY = sizeY;
   this.textSize = textSize;
   offset = 5;
   this.lines = loadStrings(s);
 }
 
 
 public void update(){
   show();
 }
 
 public void show(){
   showBox();
   fill(0);
   textSize(textSize);
   for(int i = 0; i < lines.length; i++){
     
    text(lines[i], x, y + (i * (textSize + offset)) + textSize + offset); 
   }
 }
 
 public void showBox(){
   fill(200);
   rect(x - offset * 2, y, sizeX + offset * 4, sizeY + offset * 2 , 10);
 }
 
}
class Theme {
  PImage bg;
  Scroller scroll1, scroll2, scroll3;
  //textBox text;
  SlideShow slide;
  SideScroller sideScroll;
  Clock clock;

  Theme(String path) {
    bg = loadImage(path);
    fit();

    saveZmanim();

    clock = new Clock(890, 930);

    slide = new SlideShow("/resources/pics/", 650, 100, 750, 430, 3);
    scroll3 = new Scroller("/resources/times.txt", 630, 550, 1000, 300, 30, .7f);
    scroll1 = new Scroller("/resources/scroll2.txt", 45, 80, 340, 730, 25, 2);
    scroll2 = new Scroller("/resources/scroll1.txt", 1600, 75, 300, 730, 25, 1);
    sideScroll = new SideScroller("/resources/sideTest.txt", 20, 990, width - 20, 65, 25, 3);
  }

  public void update() {
    background(200);

    
    scroll3.update();
    scroll1.update();
    scroll2.update();
    sideScroll.update();
    slide.update();
    clock.update();

    show();
  }

  public void show() {
    image(bg, 0, 0);
  }

  public void fit() {
    if (bg.width != width || bg.height != height) {
      bg.resize(width, height);
    }
  }
}



public String getTextFromRSS(String url) {
  return extractXMLFromString(getRSS(url));
}


public String getRSS(String url) { //gets the XML content of a given URL and returns a string with its contents
  String[] l = new String[1];
  GetRequest get = new GetRequest(url);
  get.send();

  l[0] = get.getContent();

  return l[0];
}

public String extractXMLFromString(String s) { //takes a string which is formatted in XML and returns plaintext content
  XML x = parseXML(s);
  return x.getContent();
}

public void makeFile(String src, String dest) {
  String[] t = new String[1];
  t[0] = src;
  saveStrings(dest, t);
}

public void saveZmanim() {
  String text = getTextFromRSS("http://www.chabad.org/tools/rss/zmanim.xml?locationId=247&locationType=1&bDef=0&before=40");

  String t = getZmanim(text);

  makeFile(t, "/resources/times.txt");
}

public String getZmanim(String s) {
  String r = new String();
  String t = s;
  int start, end;
  String[] headings = 
    {
    "Dawn (Alot Hashachar) - ", 
    "Earliest Tallit and Tefillin (Misheyakir) - ", 
    "Sunrise (Hanetz Hachamah) - ", 
    "Latest Shema - ", 
    "Latest Shacharit - ", 
    "Midday (Chatzot Hayom) - ", 
    "Earliest Mincha (Mincha Gedolah) - ", 
    "Plag Hamincha (“Half of Mincha”) - ", 
    "Sunset (Shkiah) - ", 
    "Nightfall (Tzeit Hakochavim) - ", 
    "Midnight (Chatzot HaLailah) - "
  };

  for (int i = 0; i < headings.length; i++) {
    start = t.indexOf(headings[i]);
    if (start != -1) {
      t = t.substring(start);
      end = t.indexOf("--");
      r += t.substring(0, end) + '\n';
    }
  }

  
  return r;
}
  public void settings() {  fullScreen(); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Plaque" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
