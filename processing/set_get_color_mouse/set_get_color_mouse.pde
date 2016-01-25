PShape sprite1; //memory space for sprite1
PShape sprite2; //memory space for sprite1

float posX;
float posY;
void setup() {
  size(480, 360); //size window
  sprite1 = loadShape("costume1.svg"); //file to load inside the sketchpath
  sprite2 = loadShape("costume2.svg"); //file to load inside the sketchpath
 
  posX = 0;
  posY = 0;
}

void draw() {
  background(255, 255, 255); //White
  shape(sprite1, posX, posY);
  
  color c = get(mouseX, mouseY); //get the color where the mouse is
  
  stroke(c);
  strokeWeight(50);
  line(0,height/2, width, height/2);
}