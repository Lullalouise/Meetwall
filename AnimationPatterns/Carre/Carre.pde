

import java.awt.Rectangle;
import toxi.geom.*;


Rectangle[] faces;

int rows= 8;
int cols=19;
int radius=50;

ArrayList tileCollection= new ArrayList();
ArrayList distCollection= new ArrayList();
color c[]= new color[cols*rows];
float r[]= new float[cols*rows];
Vec3D ref= new Vec3D(60,60,0);
Vec3D ref2= new Vec3D(190,80,0);
Vec3D ref3= new Vec3D(320,60,0);





void setup() {

   
  size(380, 160);


  float maxDist=0;
  ellipseMode(RADIUS);
  rectMode(RADIUS);
  filter(GRAY);


  //tile position definition 
  for (int i=0; i<cols; i++) {
    for (int j=0; j<rows; j++) {
      Vec3D myVec = new Vec3D(width/(cols*2)+i*width/cols, height/(rows*2)+j*height/rows, 0);
      tileCollection.add(myVec);
      float dist=myVec.distanceTo(ref);
        float dist2=myVec.distanceTo(ref2);
        float dist3=myVec.distanceTo(ref3);
        float dist4=min(dist2,dist3,dist);
         distCollection.add(dist4);
    }
  }

 

  for (int j=0; j< (rows)*(cols); j++) {
    Vec3D myv=(Vec3D) tileCollection.get(j);
   float dist=(Float) distCollection.get(j); 
 
 if (dist>radius){
  r[j]=255;
 }
 else{
    r[j] = dist*255/radius;
   }
  }
background(255);
  for (int j=0; j< (rows)*(cols); j++) {
Vec3D myv=(Vec3D) tileCollection.get(j); 
    fill(0);
    stroke(255);
    strokeWeight(1);
    rect(myv.x, myv.y,width*0.5/cols,(r[j]/255)*0.5*height/rows);
  }
    save("nice.jpg");
}




void draw() {
}

