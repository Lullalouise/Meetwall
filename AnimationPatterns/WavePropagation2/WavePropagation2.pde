
import java.util.*;

int rows= 7;
int cols=12;
float tW=50;//tile width
float tH=50;//tile height

ArrayList<Float> distCollection=new ArrayList <Float>();

void setup() {



 // int sWidth=int(tW*cols + tW);
//  int sHeight=int(tH*rows+tW);
  
  int sWidth=800;
  int sHeight=800;
  
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
 // print(distCollection());
  updatePixels();

 
}
void draw() {
  
  
  
  loadPixels(); 
  for (int i = 0; i < distCollection.size(); i++) {
    float re0=distCollection.get(i);
     float re1= distCollection.get(i)*(PI/2)/50;
      float re=sin(re1);
      pixels[i] = color(abs(re*200));
      //print ( distCollection.get(i),"*");
     
      re0 -=3;
      distCollection.set(i, re0);
   
  }
  
  
  updatePixels();
 
  
  
   
  /*  for (int i = 0; i < pixels.length; i++) {
  
 
  float r = red  (pixels[i]);
  if (r==255){
  };
  
  pixels[i] = color(r+1,r+1,r+1);
    }
         updatePixels();*/
}
