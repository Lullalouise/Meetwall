import msafluid.*;

final float FLUID_WIDTH = 19;
final float FLUID_HEIGHT = 8;
float invWidth, invHeight;    // inverse of screen dimensions
float aspectRatio, aspectRatio2;

MSAFluidSolver2D fluidSolver;
PImage imgFluid;

boolean drawFluid = true;
boolean renderUsingVA = true;

class Fluid {
  Fluid() {
    invWidth = 1.0f / 960;
    invHeight = 1.0f / 384;
    aspectRatio = width * invHeight;
    aspectRatio2 = aspectRatio * aspectRatio;
    // create fluid and set options
    fluidSolver = new MSAFluidSolver2D((int)(FLUID_WIDTH), 
      (int)(FLUID_HEIGHT));
    fluidSolver.enableRGB(true).setFadeSpeed(0.01).setDeltaT(0.5).setVisc(0.001);

    // create image to hold fluid picture
    imgFluid = createImage(fluidSolver.getWidth(), 
      fluidSolver.getHeight(), RGB);
    initTUIO();
  }

void userMoved(float X, float Y, float oldX, float oldY) {
    float normX = X * invWidth;
    float normY = Y * invHeight;
    float velX = (X - oldX) * invWidth;
    float velY = (Y - oldY) * invHeight;
    addForce(normX, normY, velX, velY);
}

void updateCells() {
    updateTUIO();
    fluidSolver.update();
    if(drawFluid) {
        for(int i = 0; i < fluidSolver.getNumCells(); i++) {
            int d = 2;
            //imgFluid.pixels[i] = color(fluidSolver.r[i] * d, fluidSolver.g[i] * d, fluidSolver.b[i] * d);
            imgFluid.pixels[i] = color(RGBToGrayScale(fluidSolver.r[i] * d, fluidSolver.g[i] * d, fluidSolver.b[i] * d)); }  
        imgFluid.updatePixels();//  fastblur(imgFluid, 2);
        image(imgFluid, 0, 0, width, height);
    } 
}

byte convertToTileAngle(int grayscale) {
  return byte(int((90 * grayscale) / 256.));
}

float converToTileHeight(int grayscale) {
  return (l * grayscale) / (256. * 2.0);
}
// add force and dye to fluid, and create particles
void addForce(float x, float y, float dx, float dy) {
    float speed = dx * dx  + dy * dy * aspectRatio2;    // balance the x and y components of speed with the screen aspect ratio

    if(speed > 0) {
        if(x<0) x = 0; 
        else if(x>1) x = 1;
        if(y<0) y = 0; 
        else if(y>1) y = 1;

        float colorMult = 5;
        float velocityMult = 30.0f;

        int index = fluidSolver.getIndexForNormalizedPosition(x, y);

        color drawColor;

        colorMode(HSB, 360, 1, 1);
        float hue = ((x + y) * 180 + frameCount) % 360;
        drawColor = color(hue, 1, 1);
        colorMode(RGB, 1);  

        fluidSolver.rOld[index]  += red(drawColor) * colorMult;
        fluidSolver.gOld[index]  += green(drawColor) * colorMult;
        fluidSolver.bOld[index]  += blue(drawColor) * colorMult;
        fluidSolver.uOld[index] += dx * velocityMult;
        fluidSolver.vOld[index] += dy * velocityMult;
    }
}

float RGBToGrayScale(float R, float G, float B) {
  float gamma = 1.0;
  float res = .2126 * pow(R, gamma) + .7152 * pow(G, gamma) + .0722 * pow(B, gamma);
  return res;
}
};


