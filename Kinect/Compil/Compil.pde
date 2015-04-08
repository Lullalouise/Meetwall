/* --------------------------------------------------------------------------
 * SimpleOpenNI User Test
 * --------------------------------------------------------------------------
 * Processing Wrapper for the OpenNI/Kinect 2 library
 * http://code.google.com/p/simple-openni
 * --------------------------------------------------------------------------
 * prog:  Max Rheiner / Interaction Design / Zhdk / http://iad.zhdk.ch/
 * date:  12/12/2012 (m/d/y)
 * ----------------------------------------------------------------------------
 */
import toxi.geom.*;
import SimpleOpenNI.*;

SimpleOpenNI  context;
color[] userClr = new color[] { 
  color(255, 0, 0), 
  color(0, 255, 0), 
  color(0, 0, 255), 
  color(255, 255, 0), 
  color(255, 0, 255), 
  color(0, 255, 255)
};

int[] membres = { 
  0, 7, 6
};

PVector[] membresPos =new PVector[3];
PVector[] hands =new PVector[2];
PVector[] membresPos2d =new PVector[3];

ArrayList tileCollection= new ArrayList();

int swidth=640;
int sheight=480;

int lC;
int lL;
int l;
int marginCo;
int marginHB;

int rows=8;
int cols=20;

int actionRadius=200;

void setup()


{

  for (int i=0; i<3; i++) {
    membresPos[i]=new PVector(0, 0, 0);
    membresPos2d[i] = new PVector(0, 0, 0);
  }


  size(640, 480);

  context = new SimpleOpenNI(this);

  tileSetUp();


  if (context.isInit() == false)
  {
    println("Can't init SimpleOpenNI, maybe the camera is not connected!"); 
    exit();
    return;
  }

  context.setMirror(true);

  // enable depthMap generation 
  context.enableDepth();

  // enable skeleton generation for all joints
  context.enableUser();





  stroke(0, 0, 255);
  strokeWeight(3);
  smooth();
}

void draw()
{
  background(0, 0, 0);
  // update the cam
  context.update();

  // draw depthImageMap
  // image(context.depthImage(),0,0);
  // image(context.userImage(), 0, 0);


  // draw the skeleton if it's available
  int[] userList = context.getUsers();
  for (int i=0; i<userList.length; i++)
  {
    if (context.isTrackingSkeleton(userList[i]))
    {
      // draw skeleton
      // KidrawSkeleton(userList[i]);
      // get position of head (more smooth)
      KiGetPosition(userList[i], membres[0], membresPos[0], membresPos2d[0], 2);
      // getposition of Hands 
      for (int j=1; j<3; j++) {
        stroke(255, 0, 0);
        KiGetPosition(userList[i], membres[j], membresPos[j], membresPos2d[j], 5);
      }
    }
  }

  tileLoop();
}

