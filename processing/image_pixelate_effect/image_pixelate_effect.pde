import processing.video.*;

int cellSize = 10;
int cols, rows;

Capture video;


void setup() {
  size(640, 480);
  frameRate(30);
  cols = width / cellSize;
  rows = height / cellSize;

  video = new Capture(this, width, height);
  video.start();  
  background(0);
}


void draw() { 
  if (video.available()) {
    video.read();
    video.loadPixels();
  
    for (int i = 0; i < cols; i++) {
      // Begin loop for rows
      for (int j = 0; j < rows; j++) {
      
        int x = i*cellSize;
        int y = j*cellSize;
        int loc = (video.width - x - 1) + y*video.width; // Reversing x to mirror the image
      
        float r = red(video.pixels[loc]);
        float g = green(video.pixels[loc]);
        float b = blue(video.pixels[loc]);
        color c = color(r, g, b);
      
        noStroke();
        fill(c);
        rect(x, y, cellSize, cellSize);

      }
    }
  }
}