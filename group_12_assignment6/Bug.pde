// a bug creature that will interact with a predator (lizard) via a rules based system
class Bug {
  float x, y, xVel, yVel;
  int pathSize = 60;
  int step = 0;
  boolean alive = true;
  PImage pic;
  float size = 40;

  Bug (float x, float y) {
    pic = loadImage("bug.png");
    this.x = x;
    this.y = y;
    xVel = random(-5, 5);
    yVel = random(-5, 5);
  }

  void update () {
    if (alive) {
      // change direction every certain amount of frames
      if (step >= pathSize) {
        step = 0;
        xVel = random(-5, 5);
        yVel = random(-5, 5);
      }
      
      // bounces the bug off the edges of the screen
      if (x + (size / 2) >= width || x - (size / 2) <= 0) {
        xVel *= -1;
      }
      if (y + (size / 2) >= height || y - (size / 2) <= 0) {
        yVel *= -1;
      }
      
      image(pic, x, y);
      x += xVel;
      y += yVel;
      step ++;
    }
  }

}
