import processing.net.*; 
Client myClient; 
int clicks;
byte a;
byte[] byteBuffer = new byte[16];



void setup() { 
 
  frameRate(100);
a=0;
for (int i=0; i<16; i++){
  byteBuffer[i]=a;
  
}
 

} 

void draw(){
  
  if (a==90){
a=0;
 }else
 {a+=1;}
 
 for (int i=0; i<16; i++){
  byteBuffer[i]=a;
}
   myClient = new Client(this, "192.168.1.14", 9999); 
  myClient.write(byteBuffer);
}


