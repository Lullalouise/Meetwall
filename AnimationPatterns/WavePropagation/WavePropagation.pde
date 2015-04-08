
import java.util.*;

int rows= 7;
int cols=12;
float tW=50;//tile width
float tH=50;//tile height

ArrayList distCollection;

void setup() {

  distCollection=new ArrayList();

  int sWidth=int(tW*cols + tW);
  int sHeight=int(tH*rows+tW);
  size(sWidth, sHeight);
  background(255);
  smooth();
  PVector  V0 = new PVector(sWidth/2, sHeight/2);

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
  float maxDist=Collections.max(distCollection);
 
  for (int x = 0; x < width; x++) {
    // Loop through every pixel row
    for (int y = 0; y < height; y++) {
      // Use the formula to find the 1D location
      int loc = x + y * width;
      PVector V = new PVector(x, y);
      float dist=PVector.dist(V, V0);
      float re1=dist*(PI/2)/150;
      float re=sin(re1);
      
      pixels[loc] = color(abs(re*255));
      print (re*255,"*");
    }
  }
   updatePixels();
}
/*void draw() {
   loadPixels(); 
    for (int i = 0; i < pixels.length; i++) {
  
 
  float r = red  (pixels[i]);
  if (r==255){
  };
  
  pixels[i] = color(r+1,r+1,r+1);
    }
         updatePixels();
}*/
