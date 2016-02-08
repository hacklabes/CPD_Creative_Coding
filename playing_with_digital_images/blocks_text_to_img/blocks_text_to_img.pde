import drop.*;
import java.util.*; 

SDrop drop;

int state = 0;

PImage memoryImg;

int cellSize = 10;
int wStep;
int hStep;
String lines[];

void setup() {
  size(320, 240);

  drop = new SDrop(this);
  memoryImg = createImage(width, height, RGB);

  wStep = width/cellSize;
  hStep = height/cellSize;
}

void draw() {
  background(0);
  if (state == 0) {
    textSize(15);
    fill(255);
    text("Drag and Drop your text (txt) file image", 20, 20);
  } else if (state == 1) {

    memoryImg.loadPixels();
    int textIndex = 0;
    for (int nX = 0; nX < cellSize; nX+=1) {
      for (int nY = 0; nY < cellSize; nY+=1) {
        if (textIndex < lines.length) {
          if (lines[textIndex].contains("Block")) {
            textIndex++;
          }
        }
        for (int x = nX * wStep; x < wStep*(nX+1); x ++) {
          for (int y = nY * hStep; y < hStep*(nY+1); y++) {
            int index = y * width + x;

            if (textIndex < lines.length) {

              if (lines[textIndex].split(",").length >= 3) {
                float r = float(lines[textIndex].split(",")[0]);
                float g = float(lines[textIndex].split(",")[1]);
                float b = float  (lines[textIndex].split(",")[2]);
                memoryImg.pixels[index]= color(r, g, b);
              }
            }
            textIndex++;
          }
        }
      }
    }

    memoryImg.updatePixels();
    state = 2;
    set(0, 0, memoryImg);
    Date d = new Date(); 
    String fName = "image-"+ d.getTime() + ".png";

    memoryImg.save(savePath(fName));
  } else if (state == 2) {
    set(0, 0, memoryImg);
    
    
  }
}

void dropEvent(DropEvent theDropEvent) {
  println(theDropEvent);
  println("isFile()\t"+theDropEvent.isFile());
  println("isImage()\t"+theDropEvent.isImage());
  println("isURL()\t"+theDropEvent.isURL());

  // if the dropped object is an image, then 
  // load the image into our PImage.
  if (theDropEvent.isFile()) {
    lines = loadStrings(theDropEvent.filePath());
    println("### loading text ...");
    state = 1;
  }
}