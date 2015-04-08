import processing.net.*; 
Client myClient; 
float c;

boolean diminue=true;
int a;
byte b;
byte d;
byte[] byteBuffer = new byte[16];
byte[][] byteBuffer2 = new byte[3][3];

ArrayList<Byte> byteCollection= new ArrayList();


int rows=3;
int cols=3;


void setup() { 
  frameRate(3);
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



  for (int j=0; j<rows; j++) {
    for (int i=0; i<cols; i++) {




      if (j*cols+i+6<6) {
        byteBuffer[j*cols+i+6]=0;
      } else {

        if (j % 2==0) { 



          byteBuffer[j*cols+i+6]=byte(abs(int(i*90/(cols-1)+a)));
        } else {


          byteBuffer[j*cols+i+6]=byte(abs(int((1-(float(i))/(cols-1))*90+a)));
          
         println(abs(int((1-(float(i))/(cols-1))*180+a)));
        }
      }
    }
  }

//println(a);

  if (diminue) {
    a-=180/(cols-1);
  } else { 
   
   a+=180/(cols-1);
  }
  
    if (a==-180) {
    diminue=false;
  }
  if (a==0) {
    diminue=true;
  }
  myClient = new Client(this, "192.168.1.14", 9999); 
  myClient.write(byteBuffer);
}

