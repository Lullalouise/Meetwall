import processing.net.*; 
Client myClient; 
int clicks;
byte a;
byte b;
byte[] byteBuffer = new byte[16];
byte[][] byteBuffer2 = new byte[3][3];

ArrayList<Byte> byteCollection= new ArrayList();


int rows=3;
int cols=3;


void setup() { 
  frameRate(1);
  size(480, 480);

  
  a = 0;
  b =90;
  //tile position definition 
  for (int j=0; j<rows; j++) {
    for (int i=0; i<cols; i++) {
      if (j % 2==0) { 

        byteBuffer[j*cols+i+6]=a;
      } else {
     byteBuffer[j*cols+i+6]=b;
      }
    }
  }
  
  
for (int j=0; j<rows; j++) {
  for (int i=0; i<cols; i++){
   byteBuffer[j*cols+i+6]=a;
    
  }
  
}
  
  for (int j=0; j<rows*cols; j++) {
     if(j+6>15){byteBuffer[j+6]=0;}
     else{
    byteBuffer[j+6]= byteCollection.get(j);
     }
    }
  
  
   for (int j=0; j<rows*cols; j++) {
     if(j+6>15){byteBuffer[j+6]=0;}
     else{
    byteBuffer[j+6]= byteCollection.get(j);
     }
    }
  

  //tile orientation by default
myClient = new Client(this, "192.168.1.14", 9999); 
  myClient.write(byteBuffer);


} 

void draw() {

  if (a==90) {
    a=0;
  } else
  {
    a+=90;
  }

  if (b==90) {
    b=0;
  } else {
    b+=90;
  }
  


 
  myClient = new Client(this, "192.168.1.14", 9999); 
  myClient.write(byteBuffer);
}

