import processing.video.*;

PImage output;
int numCols = 10;
int numRows = 15;
Capture camera;

void setup() {
 size(1280, 720); 
 String[] cameras = Capture.list();
 camera = new Capture(this, cameras[8]);
 camera.start();
}

void draw() {
 if (camera.available()) {
   camera.read();
   output = createImage(camera.width, camera.height, RGB);
   camera.loadPixels();
   output.loadPixels();
   for (int y = 0; y<720; y++) {
     for (int x = 0; x<1280; x++) {
       if (floor(x/(80))%2==0 && floor(y/(80))%2==0) {
         output.pixels[1280*y+x] = thresh(camera.pixels[1280*y+x], 1);
       }
       else if (floor(x/(80))%2==1 && floor(y/(80))%2==1) {
         output.pixels[1280*y+x] = thresh(camera.pixels[1280*y+x], 0);
       }
       else {
         output.pixels[1280*y+x] = thresh(camera.pixels[1280*y+x], 2);
       }
     }
   }
   image(output, 0, 0);
 }
}

color thresh(color pixel, int choice) {
 float r = pixel >> 16 & 0xFF;
 float g = pixel >> 8 & 0xFF;
 float b = pixel & 0xFF;
 switch (choice) {
  case 0:
    if (r < 120) {
      return color(0,0,0); 
    }
    else {
      return color(r, 0, 0);
    }
  case 1:
    if (g < 120) {
     return color(0,0,0); 
    }
    else {
     return color(0,g,0); 
    }
  case 2:
    if (b < 120) {
     return color(0,0,0); 
    }
    else {
     return color(0,0,b); 
    }
 }
 return color(0,0,0);
}