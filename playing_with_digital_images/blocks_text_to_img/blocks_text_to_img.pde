PImage memoryImg;

int cellSize = 10;
int wStep;
int hStep;

void setup() {
  size(640, 480);
  memoryImg = createImage(width, height, RGB);

  wStep = width/cellSize;
  hStep = height/cellSize;

  String lines[] = loadStrings("image.txt");
  memoryImg.loadPixels();
  int textIndex = 0;

  for (int nX = 0; nX < cellSize; nX+=1) {
    for (int nY = 0; nY < cellSize; nY+=1) {

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
  set(0, 0, memoryImg);
}

void draw() {
}