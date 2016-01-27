import processing.video.*;

Capture cam;
PImage memoryImg;

void setup() {
  size(1280, 480);
  cam = new Capture(this, 640, 480);
  cam.start();
  memoryImg = createImage(cam.width, cam.height, RGB);
}

void draw() {
  if (cam.available() == true) {
    cam.read();
  }
  set(0, 0, cam);
  set(640, 0, memoryImg);
}

void keyPressed() {
  if (key ==' ') {
    cam.loadPixels();
    memoryImg.loadPixels();
    arrayCopy(cam.pixels, memoryImg.pixels);
    memoryImg.updatePixels();
  }
   else if(key == 's') {
    saveFile();
  }
}

void saveFile() {

  String txt = "";
  memoryImg.loadPixels();
  for( int i = 0; i < memoryImg.pixels.length; i++){
      color pixelColor = memoryImg.pixels[i];

      float r = red(pixelColor); //extract red from the 
      float g = green(pixelColor); //extract red from the color
      float b = blue(pixelColor); //extract red from the color
      
      String colorstr = String.format("%.0f, %.0f, %.0f",r,g,b);
      txt.concat(colorstr).concat("/n");    
  }
  
  // Writes the strings to a file, each on a separate line
  saveStrings("image.txt", txt);
}