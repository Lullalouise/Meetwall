PImage img;
int x=0;
void setup() {
  background(255);
   size (380,160);
  img = loadImage("GameOver.jpg");
}

void draw() {
 frameRate(10);
  background(255);
 image(img, x, 0);
 x-=20;
 saveFrame("z-######.png");
}
