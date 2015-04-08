import processing.net.*; 
Client myClient; 
float c;

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


  a =0;
  b =0;



  //tile position definition 

  b=0;
  for (int i=0; i<16; i++) {
    byteBuffer[i]=b;
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

  for (int j=0; j<rows; j++) {
    for (int i=0; i<cols; i++) {

      if (j*cols+i+6<6) {
        byteBuffer[j*cols+i+6]=a;
      } else {

        if (j % 2==0) { 

          byteBuffer[j*cols+i+6]=byte(int(i*90/(cols-1)));
        } else {
          byteBuffer[j*cols+i+6]=byte(int((1-(float(i))/(cols-1))*90));
        }
      }
  }
  }



  myClient = new Client(this, "192.168.1.14", 9999); 
  myClient.write(byteBuffer);
}

