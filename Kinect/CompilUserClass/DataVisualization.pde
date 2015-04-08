

void tileSetUp() {

  lC=swidth/cols;
  lL=sheight/rows;
  l=min(lC, lL);
  marginCo=(swidth%(l*cols))/2;
  marginHB=(sheight%(l*rows))/2;

  rectMode(RADIUS);


  //tile position definition 
  for (int i=0; i<rows; i++) {
    for (int j=0; j<cols; j++) {
      Vec3D myVec = new Vec3D(j*(l)+l/2+marginCo, i*l+l/2+marginHB, 0);
      tileCollection.add(myVec);
    }
  }
}



void tileLoop() {

  fill(255, 20, 147);
  stroke(255);
  for (int j=0; j<rows*cols; j++) {
    float mindist=10000000;  
    Vec3D myv=(Vec3D) tileCollection.get(j);


    for (int i = 0; i < pointCollection.size (); i++) {  


      PVector mypos=pointCollection.get(i);
      Vec3D laface0= new Vec3D(mypos.x, mypos.y, 0);
      float dist= laface0.distanceTo(myv);
      if (dist<mindist) {
        mindist=dist; //keeping closest face to process
      }
    }
    //if(j+6>15){byteBuffer[j+6]=0;}
    //else{
    fill(255);
    textAlign(CENTER);
    text(j, myv.x, myv.y);
    fill(255, 20, 147);
    
    
    if (mindist<actionRadius) { // acting only on the tiles in the actionRadius.

      //  byteBuffer[j+6]=byte(int((1-(mindist/actionRadius))*90));

      rect(myv.x, myv.y, l/2, mindist*(l/2)/actionRadius);

      //  print (int(1/mindist*actionRadius/90),"    ");
    } else { //doing nothing if out of actionRadius


      rect(myv.x, myv.y, l/2, l/2);
      fill(255);


      //   byteBuffer[j+6]=byte(0);
    }
  }
}
//  myClient.write(byteBuffer);


