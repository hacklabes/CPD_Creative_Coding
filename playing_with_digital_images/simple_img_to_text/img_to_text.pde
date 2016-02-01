PImage inputImg;

void setup() {
  size(640, 480);
  inputImg = loadImage("IMG_20160125_184824.jpg");
  inputImg.resize(width,height);
}

void draw() {
  set(0, 0, inputImg);
}

void keyPressed() {
  if(key == 's') {
    saveFile();
  }
}

void saveFile() {

  String[] txt = new String[inputImg.pixels.length];
  
  inputImg.loadPixels();
  for( int i = 0; i < inputImg.pixels.length; i++){
      color pixelColor = inputImg.pixels[i];

      float r = red(pixelColor); //extract red from the 
      float g = green(pixelColor); //extract red from the color
      float b = blue(pixelColor); //extract red from the color
      
      String colorstr = String.format("%.0f, %.0f, %.0f",r,g,b);
      txt[i] = colorstr;
  }
  
  // Writes the strings to a file, each on a separate line
  saveStrings("image.txt", txt);
  exit();
}