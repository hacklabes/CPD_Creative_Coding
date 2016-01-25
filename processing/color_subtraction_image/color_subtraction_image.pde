import processing.video.*;

PImage colorImg;
PImage copyColorImg;

void setup() {
  size(1280, 480); 
  colorImg = loadImage("colorful.jpg");
  
  copyColorImg = createImage(colorImg.width, colorImg.height, ARGB);
}

void draw() {
  colorImg.loadPixels();
  copyColorImg.loadPixels();
  
  for (int i = 0; i < colorImg.pixels.length; i++) { 
    color pixelColor = colorImg.pixels[i];

    float r = red(pixelColor); //extract red from the 
    float g = green(pixelColor); //extract red from the color
    float b = blue(pixelColor); //extract red from the color

    //if(r > 100 && g > 150 && b > 100){
    //   r = 255;
    //   g = 255;
    //   b = 255;
    //}
    if (g > 100) { ///if the channel r is bigger than 100 make all black
      r = 255; 
      b = 255;
      g = 255;
    }

    copyColorImg.pixels[i] = color(r, g, b);
  }
  copyColorImg.updatePixels(); // Notify that the pixels[] array has changed


  image(copyColorImg, 0, 0);
  image(colorImg, 640,0);
}

void mouseMoved() {
 color backColor = get(mouseX, mouseY);
 println(red(backColor), green(backColor), blue(backColor));
}