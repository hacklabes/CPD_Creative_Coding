PImage memoryImg;

void setup() {
  size(640, 480);
  memoryImg = createImage(width, height, RGB);
  String lines[] = loadStrings("image.txt");
  memoryImg.loadPixels();
  for (int i = 0; i < memoryImg.pixels.length; i++) {
    if (lines[i].split(",").length >= 3) {
      float r = float(lines[i].split(",")[0]);
      float g = float(lines[i].split(",")[1]);
      float b = float  (lines[i].split(",")[2]);
      memoryImg.pixels[i]= color(r, g, b);
    }
  }
  memoryImg.updatePixels();
  set(0, 0, memoryImg);
}

void draw() {
}