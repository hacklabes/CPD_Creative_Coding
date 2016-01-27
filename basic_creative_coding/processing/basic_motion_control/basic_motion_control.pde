PShape sprite1; //memory space for sprite1
PShape sprite2; //memory space for sprite1

float posX;
float posY;
void setup() {
  size(500, 500);
  sprite1 = loadShape("costume1.svg"); //file to load inside the sketchpath
  sprite2 = loadShape("costume2.svg"); //file to load inside the sketchpath
 
  posX = 0;
  posY = 0;
}

void draw() {

  background(255, 255, 255); //White
  shape(sprite1, 0, 0);
}