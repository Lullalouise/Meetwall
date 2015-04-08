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

ArrayList tileCollection= new ArrayList();
ArrayList<PVector> pointCollection= new ArrayList();

boolean userDetected=false;

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
}

void draw()
{
  background(0, 0, 0);
  // update the cam
  context.update();

  // draw depthImageMap
  // image(context.depthImage(),0,0);
  image(context.userImage(), 0, 0);


  // draw the skeleton if it's available
  int[] userList = context.getUsers();
if (userList.length>0){
  userDetected=true;
  for (int i=0; i<userList.length; i++)
  {
    if (context.isTrackingSkeleton(userList[i]))
    {

      KiUser myKiUser = new KiUser(userList[i]);
      // draw skeleton
     // myKiUser.KidrawSkeleton();


      stroke(255, 0, 0);
      noFill();
      // get position of head (more smooth)
      myKiUser.KiGetPosition(membres[0], 2, 0); 
      // get position of hands (less smooth)
      myKiUser.KiGetPosition(membres[1], 5, 1); 
      myKiUser.KiGetPosition(membres[2], 5, 2); 

      for (int j=0; j<3; j++) {
        pointCollection.add(myKiUser.position2d[j]);
      }
    }
  }
}
else{
  userDetected=false;
}
println(userDetected);
  tileLoop();
  pointCollection.clear();
}

