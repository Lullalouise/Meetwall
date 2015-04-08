import processing.video.*;
import gab.opencv.*;
import java.awt.Rectangle;
import toxi.geom.*;
import processing.net.*; 

//Communication
Client myClient; 
int clicks;
byte a;
byte[] byteBuffer = new byte[16];

//Face Track
OpenCV opencv;
Rectangle[] faces;
Capture cam;
int rows=3;
int cols=3;
int actionRadius=200;
ArrayList tileCollection= new ArrayList();
int lC;
int lL;
int l;
int marginCo;
int marginHB;



void setup() {

  size(640, 480);

  //webcam initialization
  cam = new Capture(this, 640, 480);
  cam.start();    





lC=width/cols;
lL=height/rows;
l=min(lC,lL);
marginCo=(width%(l*cols))/2;
marginHB=(height%(l*rows))/2;


  //tile position definition 
  for (int i=0; i<rows; i++) {
    for (int j=0; j<cols; j++) {
      Vec3D myVec = new Vec3D(j*(l)+l/2+marginCo, i*l+l/2+marginHB, 0);
      tileCollection.add(myVec);
    }
  }
  
  
    //tile orientation by default
   a = 0;
  for(int i=0; i<16; i++){
   byteBuffer[i]=a; 
  }

  // Say hello
//  myClient.write(byteBuffer);
}



void draw() {
     frameRate(50);

   
   myClient = new Client(this, "192.168.1.14", 9999); 
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
 

// //image(img, 0, 0);
 
  //background(0);
  noFill();
  //stroke(0, 255, 0);
 // strokeWeight(1);


 // fill(255, 20, 147);
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
    
    
if(j+6>15){byteBuffer[j+6]=0;}
else{

    if (mindist<actionRadius) { // acting only on the tiles in the actionRadius.
      
      byteBuffer[j+6]=byte(int((1-(mindist/actionRadius))*100));
      
  //    rect(myv.x, myv.y, l/2, mindist*25/actionRadius);
  //     fill(255);
  //     text(j+6, myv.x, myv.y);
     //  print (int(1/mindist*actionRadius/90),"    ");
      
    } else { //doing nothing if out of actionRadius
      
       // fill(255, 20, 147);
  //    rect(myv.x, myv.y, l/2, l/2);
       fill(255);
   //   text(j+6, myv.x, myv.y);
      
      byteBuffer[j+6]=byte(0);
    }
  }}
  myClient.write(byteBuffer);
}
  

   
 

