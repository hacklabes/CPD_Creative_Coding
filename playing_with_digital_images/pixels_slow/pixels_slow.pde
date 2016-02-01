import drop.*;

SDrop drop;

PImage img;
PGraphics backImg;
int state = 0;

int indX = 0;
int indY = 0;

void setup() {
  size(640, 480);
  frameRate(220);
  drop = new SDrop(this);
}


void draw() {
  background(255);
  if (state  == 0) {
    textSize(25);
    fill(0);
    text("Drop an image", 20, 20);
  } else if (state == 1) {
    //img.loadPixels();
    backImg.beginDraw();
    for (int i = 0; i < 100; i ++) {
      int index = indY*width + indX;
      backImg.stroke(0);
      backImg.point(indX, indY);

      indX = (indX+1)%width;
      if (indX == 0) {
        indY = (indY+1)%height;
      }
    }
    backImg.endDraw();
    image(backImg, 0, 0);
  }
}

void dropEvent(DropEvent theDropEvent) {
  println("");
  println("isFile()\t"+theDropEvent.isFile());
  println("isImage()\t"+theDropEvent.isImage());
  println("isURL()\t"+theDropEvent.isURL());

  // if the dropped object is an image, then 
  // load the image into our PImage.
  if (theDropEvent.isImage()) {
    println("### loading image ...");
    img = theDropEvent.loadImage();
    backImg = createGraphics(img.width, img.height);
    //backImg = createImage(img.width, img.height, ARGB);
    backImg.beginDraw();
    backImg.background(255);
    backImg.endDraw();
    state = 1;
  }
}