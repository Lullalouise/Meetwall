
void KiGetPosition(int userId, int limb, PVector position, PVector position2d, int smooth){

PVector NewPosition2d = new PVector();
// to get the 3d joint data
//println (SimpleOpenNI.SKEL_HEAD,SimpleOpenNI.SKEL_RIGHT_HAND,SimpleOpenNI.SKEL_LEFT_HAND);

context.getJointPositionSkeleton(userId, limb, position);
context.convertRealWorldToProjective(position, NewPosition2d);

float dist=PVector.dist(NewPosition2d, position2d);


//Smoothing movement
   if (dist<smooth && position2d.mag()==0) {
        position2d = NewPosition2d;
        
   
      } else {
        NewPosition2d.sub(position2d);
     
       if (dist<400){
         
        NewPosition2d.setMag(smooth);}
        
        
        position2d.add(NewPosition2d);
   
      }
     
      
  ellipse(position2d.x, position2d.y, 50, 50);      
}

// draw the skeleton with the selected joints
void KidrawSkeleton(int userId)
{


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

