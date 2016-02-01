import drop.*;
import java.util.*; 

SDrop drop;

int state = 0;

PImage inputImg;

int cellSize = 10;
int wStep;
int hStep;

void setup() {
  size(320, 240);

  drop = new SDrop(this);

  wStep = width/cellSize;
  hStep = height/cellSize;
}

void draw() {

  if (state  == 0) {
    background(255);
    textSize(15);
    fill(0);
    text("Drag and Drop an image", 20, 20);
  } else if (state == 1) {

    set(0, 0, inputImg);
    saveHTML();
  }
}

void saveHTML() {
  Date d = new Date(); 
  println(d.getTime()); 

  String fName = "image-"+ d.getTime();
  inputImg.save(savePath(fName + ".png"));
  PrintWriter textOutput = createWriter(fName+".html"); 
  String header[] = loadStrings("data/header.html");


  for (int i =0; i < header.length; i++) {
    header[i] = header[i].replaceAll("WIDTH", str(width));
    header[i] = header[i].replaceAll("HEIGHT", str(height));
    header[i] = header[i].replaceAll("FNAME", (fName + ".png"));

    textOutput.println(header[i]);
  }

  for (int nY = 0; nY < cellSize; nY+=1) {
    textOutput.println("<tr>");
    for (int nX = 0; nX < cellSize; nX+=1) {
      textOutput.println("<td>");

      String tag = String.format("<a href=\"#block%d%d\">block %d %d</a>", nX, nY, nX, nY);
      textOutput.println(tag);
      textOutput.println("</td>");
    }
    textOutput.println("</tr>");
  }
  textOutput.println("</table>");
  textOutput.println("</div>");


  textOutput.println("<div id=\"pixelslist\" style=\"font-family: Verdana; font-size: 10px; color:white\">");

  inputImg.loadPixels();

  for (int nX = 0; nX < cellSize; nX+=1) {
    for (int nY = 0; nY < cellSize; nY+=1) {
      String tag = String.format("<div id=\"block%d%d\">", nX, nY);
      String msg = String.format("---------------------------- Block X: %d Block Y: %d ----------------------------", nX, nY);
      textOutput.println(tag);
      textOutput.println("<hr>");
      textOutput.println(msg);
      for (int x = nX * wStep; x < wStep*(nX+1); x ++) {
        for (int y = nY * hStep; y < hStep*(nY+1); y++) {
          int index = y * width + x;

          color pixelColor = inputImg.pixels[index];

          int r = int(red(pixelColor)); //extract red from the 
          int g = int(green(pixelColor)); //extract red from the color
          int b = int(blue(pixelColor)); //extract red from the color
          String colorstr = String.format("<div>%d, %d, %d</div>", r, g, b, r, g, b);

          textOutput.println(colorstr);
        }
      }
      textOutput.println("</div>");
    }
  }
  textOutput.println("</div>");
  textOutput.println("</body>");

  textOutput.flush();
  textOutput.close();
  exit();
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