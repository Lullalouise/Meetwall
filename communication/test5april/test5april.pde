import processing.net.*;
byte[] buffer=new byte[160];
byte b;
int a=0;
Client c;
void setup(){
  c = new Client(this,"192.168.1.14", 9999);
}
 
void draw(){
  frameRate(10);
  b =byte(a);


  for (int i=0; i<160; i++){
  buffer[i]=b; 
}
    if(!c.active()){
       println("CLIENT GOT DISCONNECTED"+ a);
        c = new Client(this,"192.168.1.14", 9999);
    }  
    
     c.write(buffer);
     
  a+=20;
  
  if (a>90){
   a=0; 
  }
}
