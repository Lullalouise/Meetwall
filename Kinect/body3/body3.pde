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
PVector com = new PVector();                                   
PVector com2d = new PVector();  

PVector Lhand = new PVector();
PVector Lhand2d = new PVector(0, 0, 0);

PVector Rhand = new PVector();
PVector Rhand2d = new PVector(0, 0, 0);

PVector Head = new PVector();
PVector Head2d = new PVector(0, 0, 0);

void setup()
{
  size(640, 480);

  context = new SimpleOpenNI(this);
 
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

  background(200, 0, 0);

  stroke(0, 0, 255);
  strokeWeight(3);
  smooth();
}

void draw()
{
  // update the cam
  context.update();

  // draw depthImageMap
 // image(context.depthImage(),0,0);
  image(context.userImage(),0, 0);





  // draw the skeleton if it's available
  int[] userList = context.getUsers();
  for (int i=0; i<userList.length; i++)
  {
    if (context.isTrackingSkeleton(userList[i]))
    {
      PVector NewLhand2d = new PVector();
      PVector NewRhand2d = new PVector();
      PVector NewHead2d = new PVector();

      stroke(255, 0, 0);
      drawSkeleton(userList[i]);
      fill(0);

      context.convertRealWorldToProjective(Head, NewHead2d);
      context.convertRealWorldToProjective(Rhand, NewRhand2d);
      context.convertRealWorldToProjective(Lhand, NewLhand2d);

      float dist=PVector.dist(NewHead2d, Head2d);

      if (dist<1 && Head2d.mag()==0) {
        Head2d = NewHead2d;
      } else {
        NewHead2d.sub(Head2d);
        Head2d.add(NewHead2d);
      }

      dist=PVector.dist(NewRhand2d, Rhand2d);

      if (dist<1 && Rhand2d.mag()==0) {
        Rhand2d = NewRhand2d;
      } else {
        NewRhand2d.sub(Rhand2d);
        Rhand2d.add(NewRhand2d);
      }  

      dist=PVector.dist(NewLhand2d, Lhand2d);

      if (dist<1 && Lhand2d.mag()==0) {
        Lhand2d = NewLhand2d;
      } else {
        NewLhand2d.sub(Lhand2d);
        Lhand2d.add(NewLhand2d);
      }     




      ellipse(Lhand2d.x, Lhand2d.y, 50, 50);
      ellipse(Rhand2d.x, Rhand2d.y, 50, 50);
      ellipse(Head2d.x, Head2d.y, 50, 50);
    }      


  }
}

// draw the skeleton with the selected joints
void drawSkeleton(int userId)
{
  // to get the 3d joint data


  context.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_HEAD, Head);
  context.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_RIGHT_HAND, Rhand);
  context.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_LEFT_HAND, Lhand);


  //  println(jointPos);



  context.drawLimb(userId, SimpleOpenNI.SKEL_HEAD, SimpleOpenNI.SKEL_NECK);

  context.drawLimb(userId, SimpleOpenNI.SKEL_NECK, SimpleOpenNI.SKEL_LEFT_SHOULDER);
  context.drawLimb(userId, SimpleOpenNI.SKEL_LEFT_SHOULDER, SimpleOpenNI.SKEL_LEFT_ELBOW);
  context.drawLimb(userId, SimpleOpenNI.SKEL_LEFT_ELBOW, SimpleOpenNI.SKEL_LEFT_HAND);

   context.drawLimb(userId, SimpleOpenNI.SKEL_NECK, SimpleOpenNI.SKEL_RIGHT_SHOULDER);
   context.drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_SHOULDER, SimpleOpenNI.SKEL_RIGHT_ELBOW);
   context.drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_ELBOW, SimpleOpenNI.SKEL_RIGHT_HAND);


}

// -----------------------------------------------------------------
// SimpleOpenNI events

void onNewUser(SimpleOpenNI curContext, int userId)
{
  println("onNewUser - userId: " + userId);
  println("\tstart tracking skeleton");

  curContext.startTrackingSkeleton(userId);
}

void onLostUser(SimpleOpenNI curContext, int userId)
{
  println("onLostUser - userId: " + userId);
}

void onVisibleUser(SimpleOpenNI curContext, int userId)
{
  //println("onVisibleUser - userId: " + userId);
}



