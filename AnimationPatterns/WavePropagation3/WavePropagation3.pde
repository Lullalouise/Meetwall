
import java.util.*;
import toxi.geom.*;

int rows= 12;
int cols=8;
int actionRadius=200;
ArrayList tileCollection= new ArrayList();
ArrayList<Float> distCollection=new ArrayList <Float>();

void setup() {


  rectMode(RADIUS);
  // int sWidth=int(tW*cols + tW);
  //  int sHeight=int(tH*rows+tW);

  size(640, 480);
  background(255);
  smooth();
  Vec3D  V0 = new Vec3D(45, 65, 0);

  //tile position definition 
  for (int i=0; i<rows; i++) {
    for (int j=0; j<cols; j++) {
      Vec3D myVec = new Vec3D(i*(50)+45, j*50+65, 0);
      tileCollection.add(myVec);
      float dist=myVec.distanceTo(V0);
      distCollection.add(dist);
    }
  }

  /*
  // Before we deal with pixels
   loadPixels();  
   // Loop through every pixel column
   for (int x = 0; x < width; x++) {
   // Loop through every pixel row
   for (int y = 0; y < height; y++) {
   PVector V = new PVector(x, y);
   float dist=PVector.dist(V, V0);
   distCollection.add(dist);
   
   }
   }
   // print(distCollection());
   updatePixels();
   
   */
}
void draw() {
  frameRate(1);

background(0);
  /* loadPixels(); 
   for (int i = 0; i < distCollection.size(); i++) {
   float re0=distCollection.get(i);
   float re1= distCollection.get(i)*(PI/2)/50;
   float re=sin(re1);
   pixels[i] = color(abs(re*200));
   //print ( distCollection.get(i),"*");
   
   re0 -=3;
   distCollection.set(i, re0);*/


  for (int j=0; j<rows*cols; j++) {

    Vec3D myv=(Vec3D) tileCollection.get(j);
    float re0=distCollection.get(j);
    float re1= distCollection.get(j)*(PI/2)/100;
    float re=sin(re1);
    //fill(0);
    rect(myv.x, myv.y, 25, abs(re*25));
    re0 +=2;
    distCollection.set(j, re0);
  }


  // }


  //updatePixels();
}
