
import toxi.geom.*;
import processing.video.*;
Movie myMovie;



//int rows= 8;
//int cols=20;
//int actionRadius=200;

//ArrayList tileCollection= new ArrayList();
color c[]= new color[cols*rows];
float r[]= new float[cols*rows];
//byte byteBuffer[]= new byte[cols*rows];

//Called every time a new frame is available to read
void movieEvent(Movie m) {
  m.read();
}


void ScreenSaverSetUp() {

 // size(800, 320);
  myMovie = new Movie(this, "WavesPropagation.mov");
  myMovie.loop();
 
  
}
void ScreenSaverloop() {

image(myMovie, 0, 112, 640, 256);
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
    byteBuffer[j]=byte(int((r[j]/255)*90));
    
  }

}

