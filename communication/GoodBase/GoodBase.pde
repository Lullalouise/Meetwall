import processing.net.*; 
Client myClient; 
int clicks;
int a;
byte b;
byte[] byteBuffer = new byte[160];



void setup() { 
  
    myClient = new Client(this, "192.168.2.1", 9999); 
  a=180;
b=byte(a);
for (int i=0; i<16; i++){
  byteBuffer[i]=b;
  
}
}
 
 void draw(){
a+=1;
b=byte(a);
for (int i=0; i<16; i++){
  byteBuffer[i]=b;
 
}


  myClient.write(byteBuffer);
  myClient = new Client(this, "192.168.1.14", 9999); 
} 

