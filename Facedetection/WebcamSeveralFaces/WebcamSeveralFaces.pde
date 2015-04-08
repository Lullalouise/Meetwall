import processing.video.*;
import gab.opencv.*;
import java.awt.Rectangle;
import toxi.geom.*;

OpenCV opencv;
Rectangle[] faces;
Capture cam;
int rows= 12;
int cols=8;
int actionRadius=200;
ArrayList tileCollection= new ArrayList();




void setup() {

  size(640, 480);

  //webcam initialization
  cam = new Capture(this, 640, 480);
  cam.start();    


  //tile position definition 
  for (int i=0; i<rows; i++) {
    for (int j=0; j<cols; j++) {
      Vec3D myVec = new Vec3D(i*(50)+45, j*50+65, 0);
      tileCollection.add(myVec);
    }
  }
}



void draw() {
  float maxDist=0;
  rectMode(RADIUS);

  //transform webcam input into PImage (able to be processed with openCv)
  cam.read();
  PImage img = cam;


  //opencv initialization
  opencv = new OpenCV(this, img);
  size(opencv.width, opencv.height);

  //face detection
  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);  
  faces = opencv.detect();



  //data visualisation
  image(img, 0, 0);
  //background(0);
  noFill();
  stroke(0, 255, 0);
  strokeWeight(1);


  fill(255, 20, 147);
  stroke(255);
  for (int j=0; j<rows*cols; j++) {
    float mindist=10000000;  
    Vec3D myv=(Vec3D) tileCollection.get(j);


    for (int i = 0; i < faces.length; i++) {  

      if (faces[i].height>70) { // Depth test equivalent
      
        Vec3D laface0= new Vec3D(faces[i].x+faces[i].width/2, faces[i].y+faces[i].height/3, 0);
        float dist= laface0.distanceTo(myv);
        if (dist<mindist) {
          mindist=dist; //keeping closest face to process
        }
      }
    }


    if (mindist<actionRadius) { // acting only on the tiles in the actionRadius.
      
      rect(myv.x, myv.y, 25, mindist*25/actionRadius);
      
    } else { //doing nothing if out of actionRadius
      
      rect(myv.x, myv.y, 25, 25);
      
    }
  }
}
