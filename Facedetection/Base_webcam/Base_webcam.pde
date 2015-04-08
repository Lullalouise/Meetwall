import gab.opencv.*;
import java.awt.Rectangle;
import processing.video.*;

Capture cam;

OpenCV opencv;
Rectangle[] faces;

void setup() {
size(640, 480);

  String[] cameras = Capture.list();
  
  if (cameras.length == 0) {
    println("There are no cameras available for capture.");
    exit();
  } else {
    println("Available cameras:");
    for (int i = 0; i < cameras.length; i++) {
      println(cameras[i]);
    }
    
    // The camera can be initialized directly using an 
    // element from the array returned by list():
    cam = new Capture(this, cameras[0]);
    cam.start();     
  }   
}

void draw() {
  if (cam.available() == true) {
    cam.read();
  }
  image(cam, 0, 0);
  
  
  opencv = new OpenCV(this, "test.jpg");
  size(opencv.width, opencv.height);

  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);  
  faces = opencv.detect();
  image(opencv.getInput(), 0, 0);

  noFill();
  stroke(0, 255, 0);
  strokeWeight(3);
  for (int i = 0; i < faces.length; i++) {
    if (faces[i].height>200){
    rect(faces[i].x, faces[i].y, faces[i].width, faces[i].height);
    }
  }
}
