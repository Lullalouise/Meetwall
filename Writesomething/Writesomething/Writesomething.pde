int lC;
int lL;

import toxi.geom.*;


int l;
int marginCo;
int marginHB;
int rows=8;
int cols=100;
int swidth=cols*20;
int sheight=rows*20;
int[] colorR= new int[rows*cols];

boolean seeLines=false;

ArrayList tileCollection= new ArrayList();
void setup() {
  size(swidth, sheight);
  lC=swidth/cols;
  lL=sheight/rows;
  l=min(lC, lL);
  marginCo=(swidth%(l*cols))/2;
  println(l);
  marginHB=(sheight%(l*rows))/2;
  //  println(marginHB);
  rectMode(RADIUS);

  //tile position definition 
  for (int j=0; j<cols; j++) {
    for (int i=0; i<rows; i++) {
      Vec3D myVec = new Vec3D(j*(l)+l/2+marginCo, i*l+l/2+marginHB, 0);
      tileCollection.add(myVec);
    }
  }

  for (int j=0; j<rows*cols; j++) {
    noStroke();
    colorR[j] =255;
    fill(colorR[j]);
    Vec3D myv=(Vec3D) tileCollection.get(j);

    rect(myv.x, myv.y, l/2, l/2);
  }
}
void draw() {

  if (keyPressed) {
    if (key == 'l') {
      stroke(0);
    }
    if (key == 's') {
      saveFrame("screen.jpg");
    }
    if (key == 'r') {
      for (int j=0; j<rows*cols; j++) {
        colorR[j] =255;
      }
    }
  } else {
    noStroke();
  }


  for (int j=0; j<rows*cols; j++) {
    int mx=mouseX;
    int my=mouseY;
    Vec3D myv=(Vec3D) tileCollection.get(j);

    if ((mx-myv.x)<l/2 && (myv.x-mx)<l/2 && (my-myv.y)<l/2 && (myv.y-my)<l/2) {

      if (mousePressed &&  (mouseButton == LEFT)) {
        colorR[j] =0;
        fill(colorR[j]);
        rect(myv.x, myv.y, l/2, l/2);
      } 
     else if (mousePressed &&  (mouseButton == RIGHT))
      {
        colorR[j] =255;
        fill(colorR[j]);
        rect(myv.x, myv.y, l/2, l/2);
      } 
      else {
        fill(0);
        rect(myv.x, myv.y, l/2, l/2);
      }
    } else { 
      fill(colorR[j]);
      rect(myv.x, myv.y, l/2, l/2);
    }
  }
}

