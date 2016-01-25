import processing.video.*;

Capture video;

void setup() {
  size(640, 480); 
  
  video = new Capture(this, width, height);
  video.start();  
}

void draw() {
  if (video.available()) {
    video.read(); // Read a new video frame
    video.loadPixels(); // Make the pixels of video available
   
    for (int i = 0; i < video.pixels.length; i++) { 
      color pixelColor = video.pixels[i];

      float r = red(pixelColor); //extract red from the 
      float g = green(pixelColor); //extract red from the color
      float b = blue(pixelColor); //extract red from the color
      
      //if(r > 100 && g > 150 && b > 100){
      //   r = 255;
      //   g = 255;
      //   b = 255;
      //}
      if(r > 200){ ///if the channel r is bigger than 100 make all black
       r = 255; 
       b = 255;
       g = 255;
      }
      
      video.pixels[i] = color(r, g, b);

    }
    video.updatePixels(); // Notify that the pixels[] array has changed

  }
  
  image(video,0,0);
}

void mouseMoved(){
 color backColor = get(mouseX,mouseY);
 
 println(red(backColor),green(backColor),blue(backColor)); 
}