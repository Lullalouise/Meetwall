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
import processing.video.*;
import processing.net.*;


SimpleOpenNI  context;


Client c;

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
boolean reset=false;
boolean kinect=true;

int swidth=640;
int sheight=480;

int lC;
int lL;
int l;
int marginCo;
int marginHB;

int rows=3;
int cols=4;


int actionRadius=200;

//byte[] byteBuffer=  new byte[cols*rows];
byte[] byteBuffer=  new byte[cols*rows];

float[] tileHeight=  new float[cols*rows];

void setup()
{
  size(640, 480);
    c = new Client(this,"192.168.2.1",9999);
  
  // myServer = new Server(this, 9999); 
//myClient = new Client(this, "192.168.2.1", 9999); 

  context = new SimpleOpenNI(this);

  KiSetup();
  ScreenSaverSetUp();

  tileSetUp();
}

void draw()
{
  background(0, 0, 0);
  //ScreenSaverloop();
  // update the cam

if (kinect){
  context.update();
  // draw depthImageMap
  // image(context.depthImage(),0,0);





  // draw the skeleton if it's available
  int[] userList = context.getUsers();

  if (userList.length==0) {
    if (userDetected) {

      userDetected=false;
      reset();
      println("reset for screensaver");
    } else { 
      ScreenSaverloop();
     // tileLoop();
     // println("screensaverloop");
    }
  } else {
    if (!userDetected)
    {
      reset();
      println("reset for userDetected");
      userDetected=true;
    } else {
     // println("kloop");
      kiLoop(userList);

     
    }
  }}
  else{
  ScreenSaverloop();  
  }
 tileLoop(); 
 pointCollection.clear(); 
 
    if(!c.active()){
        println("CLIENT GOT DISCONNECTED");
        c = new Client(this,"192.168.2.1", 9999);
    } 
    
       c.write(byteBuffer);
// myClient.write(byteBuffer);
 //myClient = new Client(this, "192.168.2.1", 9999); 

}




