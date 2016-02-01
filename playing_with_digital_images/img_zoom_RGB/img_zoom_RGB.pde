import drop.*;

SDrop drop;


PImage inputImg;
PImage zoom;
int state = 0;


void setup() {
  size(640, 480);
  zoom = createImage(3, 3, RGB);
  drop = new SDrop(this);

}

void draw() {
  background(255);

  if (state  == 0) {

    textSize(25);
    fill(0);
    text("Drag and Drop an image\nand move the mouse to explore the pixels", 20, 20);
  } else if (state == 1) {

    set(0, 0, inputImg);


    zoom.copy(inputImg, mouseX, mouseY, 5, 5, 0, 0, 5, 5);
    zoom.loadPixels();
    pushMatrix();
    noStroke();
    translate(mouseX, mouseY);  
    for (int x = 0; x < zoom.width; x++) {
      for (int y = 0; y < zoom.height; y++) {
        int ind = y * zoom.height + x;
        color colorPix = zoom.pixels[ind];

        float r = red(colorPix); 
        float g = green(colorPix); 
        float b = blue(colorPix);

        fill(colorPix);
        rect(x*70, y*70, 70, 70);
        String colorstr = String.format("R:%.0f\nG:%.0f\nB:%.0f", r, g, b);
        //println(colorstr);
        textSize(15);
        textLeading(15);
        textAlign(LEFT, TOP);

        fill(255);
        text(colorstr, x*70, y*70);
      }
    }
    popMatrix();
  }
}



void dropEvent(DropEvent theDropEvent) {
  println(theDropEvent);
  println("isFile()\t"+theDropEvent.isFile());
  println("isImage()\t"+theDropEvent.isImage());
  println("isURL()\t"+theDropEvent.isURL());

  // if the dropped object is an image, then 
  // load the image into our PImage.
  if (theDropEvent.isImage()) {
    println("### loading image ...");
    inputImg = loadImage(theDropEvent.filePath());
    inputImg.resize(width, height);
    state = 1;
  }
}