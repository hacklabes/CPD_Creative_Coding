import drop.*;

SDrop drop;

PImage img;

PGraphics backImg;
int state = 0;

int indX = 0;
int indY = 0;

int w = 640;
int h = 480;


void setup() {
  size(640, 544);
  drop = new SDrop(this);
  stroke(255);
}


void draw() {
  background(255);
  if (state  == 0) {
  
    textSize(25);
    fill(0);
    text("Drop an image\nand move the mouse to control the speed\nwatch the image being formed pixel by pixel", 20, 20);
  
  } else if (state == 1) {
    img.loadPixels();
    
    backImg.beginDraw();
    for(int i =0; i <  mouseX; i++){
      int index = indY*w + indX;
      pushMatrix();
      translate(0, height-100);
      for (int j = 0; j < 10; j++) {
       color pix  = img.pixels[(index+j)%img.pixels.length];
       fill(pix);
       rect(j*width/10, 0, width/10, 100);
       String colorstr = String.format("R:%.0f\nG:%.0f\nB:%.0f", red(pix), green(pix), blue(pix));

       textSize(15);
       textLeading(15);
       textAlign(LEFT, TOP);
       fill(255);
       text(colorstr, j*width/10, 50);
      }
      popMatrix();

      backImg.stroke(img.pixels[index]);
      backImg.point(indX, indY);
      backImg.noFill();
      
      indX = (indX+1)%w;
      if (indX == 0) {
        indY = (indY+1)%h;
        if (indY == 0) {
          backImg.background(255);
        }
      }
    }
    backImg.endDraw();
    set(0,0,backImg);
    stroke(255, 0, 0);
    ellipse(indX, indY, 10, 10);
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
    img = loadImage(theDropEvent.filePath());
    img.resize(w, h);
    backImg = createGraphics(w, h);
    backImg.beginDraw();
    backImg.background(255);
    backImg.endDraw();
    state = 1;
    indX = 0;
    indY = 0;
  }
}