PImage inputImg;

int cellSize = 10;
int wStep;
int hStep;

String fName = "IMG_20160125_184824.jpg";
void setup() {
  size(320, 240);
  inputImg = loadImage(fName);
  inputImg.resize(width, height);

  wStep = width/cellSize;
  hStep = height/cellSize;
}

void draw() {
  set(0, 0, inputImg);
}

void keyPressed() {
  if (key == 's') {
    saveFile();
  }
}

void saveFile() {
  PrintWriter textOutput = createWriter("output.html"); 
  String header[] = loadStrings("header.html");


  for (int i =0; i < header.length; i++) {
    header[i] = header[i].replaceAll("WIDTH", str(width));
    header[i] = header[i].replaceAll("HEIGHT", str(height));
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


  textOutput.println("<div id=\"pixelslist\" style=\"font-family: Verdana;font-size: 5px; color: white\">");

  inputImg.loadPixels();

  for (int nX = 0; nX < cellSize; nX+=1) {
    for (int nY = 0; nY < cellSize; nY+=1) {
      String tag = String.format("<div id=\"block%d%d\">", nX, nY);
      String msg = String.format("---------------------------- Block X: %d Block Y:%d ----------------------------", nX, nY);
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