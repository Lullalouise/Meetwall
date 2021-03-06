

void tileSetUp() {

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
}



void tileLoop() {

  fill(255, 20, 147);
  stroke(255);
  for (int j=0; j<rows*cols; j++) {
    float mindist=10000000;  
    Vec3D myv=(Vec3D) tileCollection.get(j);


    if (userDetected) {
      for (int i = 0; i < pointCollection.size (); i++) {  
        PVector mypos=pointCollection.get(i);
        Vec3D laface0= new Vec3D(mypos.x, mypos.y, 0);
        float dist= laface0.distanceTo(myv);
        if (dist<mindist) {
          mindist=dist; //keeping closest face to process
        }
      }



      
      if (mindist<actionRadius) { // acting only on the tiles in the actionRadius.

        byteBuffer[j]=byte(int((1-(mindist/actionRadius))*90));
        tileHeight[j]=mindist*(l/2)/actionRadius;


        //  print (int(1/mindist*actionRadius/90),"    ");
      } else { //doing nothing if out of actionRadius
        tileHeight[j]=l/2;

      byteBuffer[j]=byte(0);
      }
    //  print(byteBuffer+"*");
    }
    
    
    
    
    
    
 fill(255, 20, 147);
 rect(myv.x, myv.y, l/2, tileHeight[j]);
       fill(255);
      textAlign(CENTER);
      text(j, myv.x, myv.y);

  }
}
//  myClient.write(byteBuffer);

