
import toxi.geom.*;
import processing.video.*;
Movie myMovie0,myMovie1,myMovie2;

//int rows= 8;
//int cols=20;
//int actionRadius=200;

//ArrayList tileCollection= new ArrayList();
color c[]= new color[cols*rows];
float r[]= new float[cols*rows];


//Called every time a new frame is available to read
void movieEvent(Movie m) {
  m.read();
}


void ScreenSaverSetUp() {
 // size(800, 320);
  myMovie0 = new Movie(this, "0.mov");
  myMovie1 = new Movie(this, "1.mov");
  myMovie2 = new Movie(this, "2.mov");
  myMovie0.loop();
  myMovie1.loop();
  myMovie2.loop();
}

void ScreenSaverloop() {
  
  switch(screensaver) {
  case 0:
    image(myMovie0, 0, 112, 640, 256);
    break;
  case 1:
    image(myMovie1, 0, 112, 640, 256);
    break;
  case 2:
    image(myMovie2, 0, 112, 640, 256);
    break;}

  //image(myMovie, 0, 112, 640, 256);
  for (int j=0; j< (rows)*(cols); j++) {
      Vec3D myv=(Vec3D) tileCollection.get(j); 
      c[j]=get(int(myv.x), int(myv.y));
      r[j] = 255-red(c[j]);
  }

    for (int j=0; j< (rows)*(cols); j++) {
  Vec3D myv=(Vec3D) tileCollection.get(j); 
      fill(255);
      noStroke();
      tileHeight[j]=(r[j]/255)*l/2;
      byteBuffer[j]=byte(int((1-(r[j]/255))*90));

    }
  //println(byteBuffer);
}

