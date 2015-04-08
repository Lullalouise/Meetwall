import SimpleOpenNI.*;
 
SimpleOpenNI  context;
 
void setup()
{
  // instantiate a new context
  context = new SimpleOpenNI(this);
 
  // enable depth image generation 
  context.enableDepth();
 
  // create a window the size of the depth information
  size(context.depthWidth(), context.depthHeight()); 
}
 
void draw()
{
  // update the camera
  context.update();
 
  // draw depth image
  image(context.depthImage(),0,0); 
}
