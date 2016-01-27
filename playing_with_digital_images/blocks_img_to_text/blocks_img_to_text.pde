PImage inputImg;

int cellSize = 10;
int wStep;
int hStep;


void setup() {
  size(640, 480);
  inputImg = loadImage("jdN38Zg.jpg");
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
  PrintWriter textOutput = createWriter("image.txt"); 

  
  inputImg.loadPixels();

  for (int nX = 0; nX < cellSize; nX+=1) {
    for (int nY = 0; nY < cellSize; nY+=1) {
      String msg = String.format("---------------------------- Block X: %d Block Y:%d ----------------------------", nX, nY);
      textOutput.println(msg);
      for (int x = nX * wStep; x < wStep*(nX+1); x ++) {
        for (int y = nY * hStep; y < hStep*(nY+1); y++) {
          int index = y * width + x;

          color pixelColor = inputImg.pixels[index];

          float r = red(pixelColor); //extract red from the 
          float g = green(pixelColor); //extract red from the color
          float b = blue(pixelColor); //extract red from the color
          String colorstr = String.format("%.0f, %.0f, %.0f", r, g, b);

          textOutput.println(colorstr);
        }
      }
    }
  }
  textOutput.flush();
  textOutput.close();
  exit();
}