
import java.lang.Math;

PImage img;
int img_width = 512 , img_height= 512, bloc_size = 12;
float HOG[] = new float[144];
float intervalle = (float)(Math.PI/8.0);
int get1D (int x, int y) {
  return x+y*img_width;
}
 
void setup(){
  

  img = loadImage("fruits.jpg");
  size(1080, 512);
  img.loadPixels();
  img.resize(img_width, img_height);
  img.filter(GRAY);
}



void draw(){
  
  background(204);
  image(img, 0, 0);
  

  if(mouseX < img_width && mouseY < img_height){
    noFill();
    stroke(255,0,0);
    strokeWeight(1);
    rect(mouseX - bloc_size/2, mouseY - bloc_size/2, bloc_size, bloc_size);
  }
  

  int Hist[] = new int[8];
  for(int i = 0; i< HOG.length; i++){
      Hist[ (int)Math.floor(HOG[i] / intervalle)    ] += 1;
      print("Histo " +  Hist[ (int)Math.floor(HOG[i] / intervalle)    ] + '\n' );
      
    }
    
    strokeWeight(1);
    stroke(52, 140, 235);
    fill(255,0,0);
    for(int i=0; i< Hist.length; i++) {
    rect(width*0.4+i*50 + 150, height*0.9,50, -2*Hist[i]);
    }
 
}

void mouseMoved() {
  int c = 0;
  if( (mouseX > 0 && mouseX < img_width) && (mouseY >0 && mouseY < img_height)){
    for(int x = mouseX - bloc_size/2; x < mouseX + bloc_size/2; x++){
        for(int y = mouseY - bloc_size/2; y < mouseY + bloc_size/2; y++){
         
          if( (x > 0 && x < img_width) && (y >0 && y+1 < img_height)){
              float Gx = brightness(img.pixels[get1D(x+1,y)]) - brightness(img.pixels[get1D(x-1,y)]);
              float Gy = brightness(img.pixels[get1D(x,y-1)]) - brightness(img.pixels[get1D(x,y+1)]);
            
              
              if(Gx != 0){
                HOG[c] = atan(Gy/Gx) + (float)Math.PI/2;
              }
              else{
                HOG[c] = (float)Math.PI/2;
              }
              print("HOGAR " + HOG[c] + '\n');
              c++;
        }
          
      }
    }
    
 
    /*for(int i = 0; i< HOG.length; i++){
      Hist[  floor(HOG[i] / intervalle)    ] += 1;
      if (i<8){
      print("Histo" + Hist[i] + '\n' );
      }
    }*/
    
  }


}

/*void keyPressed()
{
  float Hist[] = new float[8];
  for(int i = 0; i< HOG.length; i++){
      Hist[  floor(HOG[i] / intervalle)    ] += 1;
      if (i<8){
      print("Histo" + Hist[i] + '\n' );
      }
    }
    
    strokeWeight(1);
    stroke(52, 140, 235);
    for(int i=0; i< Hist.length; i++) {
    rect(width*0.4+i*50 + 200, height*0.9,50, -2*Hist[i]);
    }
  
}*/
