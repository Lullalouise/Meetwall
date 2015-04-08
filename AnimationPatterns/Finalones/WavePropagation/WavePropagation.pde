
import java.util.*;

int rows= 8;
int cols=20;
int a=0;
float radiusMax=400;
float tW=50;//tile width
float tH=50;//tile height

ArrayList<Float> distCollection=new ArrayList <Float>();

void setup() {


  int sWidth=800;
  int sHeight=320;
  
  size(sWidth, sHeight);
  background(255);
  smooth();
  PVector  V0 = new PVector(sWidth/2, sHeight/2);

  // Before we deal with pixels
  loadPixels();  
  // Loop through every pixel column
  for (int y = 0; y < height; y++) {
    // Loop through every pixel row
    for (int x = 0; x < width; x++) {
      PVector V = new PVector(x, y);
      float dist=PVector.dist(V, V0);
      distCollection.add(dist);

    }
  }
 // print(distCollection());
  updatePixels();


  
  

 
}
void draw() {
  

  if (a > -400) {
   
  
    loadPixels(); 
  for (int i = 0; i < distCollection.size(); i++) {
    float re0=distCollection.get(i)+a;
    
    float re1 = map(re0, 0, radiusMax, 0, PI);
    float re2=sin(re1);
    float re3=map(re2,0, 1, 0, 255);
    
 
      pixels[i] = color(abs(re3));

  }
    a -=2; 
  updatePixels();}
 
  else {
    noLoop();
  }

  saveFrame("anim-######.tif");
}


