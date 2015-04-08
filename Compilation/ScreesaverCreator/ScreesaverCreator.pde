
import toxi.geom.*;
import processing.video.*;
Movie myMovie;



int rows= 8;
int cols=20;
int actionRadius=200;

ArrayList tileCollection= new ArrayList();
color c[]= new color[cols*rows];
float r[]= new float[cols*rows];

void setup() {
  size(800, 320);
  myMovie = new Movie(this, "WavesPropagation.mov");
  myMovie.loop();
  rectMode(RADIUS);
  
    //tile position definition 
  for (int i=0; i<cols; i++) {
    for (int j=0; j<rows; j++) {
      Vec3D myVec = new Vec3D(width/(cols*2)+i*width/cols, height/(rows*2)+j*height/rows, 0);
      tileCollection.add(myVec);
    }
  }
}

void draw() {
 // tint(255, 20);
  image(myMovie, 0, 0);
  
  for (int j=0; j< (rows)*(cols); j++) {
    Vec3D myv=(Vec3D) tileCollection.get(j); 
    c[j]=get(int(myv.x), int(myv.y));
    r[j] = 255-red(c[j]);
  //  println(r[j]);
  }

//background(245,245,240);
  for (int j=0; j< (rows)*(cols); j++) {
Vec3D myv=(Vec3D) tileCollection.get(j); 
    fill(255);
    noStroke();
    rect(myv.x, myv.y, width/cols, (r[j]/255)*height/cols);
  }

}
  
  
  


//Called every time a new frame is available to read
void movieEvent(Movie m) {
  m.read();
}
 
 
 /*
 
 
  for (int j=0; j< (rows)*(cols); j++) {
    Vec3D myv=(Vec3D) tileCollection.get(j); 
    c[j]=get(int(myv.x), int(myv.y));
    r[j] = 255-red(c[j]);
    println(r[j]);
  }
   filter(GRAY);
    for (int j=0; j< (rows)*(cols); j++) {
    Vec3D myv=(Vec3D) tileCollection.get(j); 
    c2[j]=get(int(myv.x), int(myv.y));
    r[j] = 255-red(c2[j]);
    println(r[j]);
  }
background(245,245,240);
  for (int j=0; j< (rows)*(cols); j++) {
Vec3D myv=(Vec3D) tileCollection.get(j); 
    fill(c[j]);
    noStroke();
    ellipse(myv.x, myv.y, (r[j]/255)*width*0.7/cols, (r[j]/255)*width*0.7/cols);
  }
  save("nice.jpg");
}
*/
