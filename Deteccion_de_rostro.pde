import gab.opencv.*;
import java.awt.Rectangle;
import processing.video.*;
OpenCV opencv;
Rectangle[] faces;
Capture cam;
PImage mask;
void setup() {
  mask=loadImage("mask.png");
  size(640, 480);
  String[] cameras = Capture.list();
 
  if (cameras.length == 0) {
    println("There are no cameras available for capture.");
    exit();
    }else {
    println("Available cameras:");
    for (int i = 0; i < cameras.length; i++) {
      println(cameras[i]);
    }
   }
  
  

  cam = new Capture(this, width,height);
  opencv = new OpenCV(this, (PImage)cam);
  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);  
  faces = opencv.detect();
  cam.start();
  frameRate(27);
  
}

void draw() {
  if (!cam.available())return;
  else cam.read();
  image(cam, 0, 0);
  fill(255);
  text("frameRate "+frameRate, 50, 50);
  noFill();
  if(frameCount%3==0){
     opencv.loadImage(cam);
     faces= opencv.detect();
     stroke(0, 255, 0);
     strokeWeight(3);
   }
   for (int i = 0; i < faces.length; i++) {
      image(mask,faces[i].x, faces[i].y, faces[i].width, faces[i].height);
   }
}
