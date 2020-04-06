class PaddleParticle {
  float x, y;
  color c;
  float gravity = 0.95;
  float xVel;
  float yVel;
  float size;
  
  PaddleParticle (float x, float y, color c) {
    this.x = x;
    this.y = y;
    
    int dir = int(random(0, 2));
    yVel = -random(1, 5);
    xVel = random(3, 15);
    if (dir == 0) {
      xVel *= -1;
    }   
    
    this.c = c;
    size = random(10, 21);
  }
  
  void update () {
    x += xVel;
    y += yVel;
    
    if (yVel == 0) {
      yVel = 0.1;
    } else {
      yVel = yVel * gravity;
    }
  }
  
  void display() {
    noStroke();
    fill(c);
    circle(x, y, size);
  }
  
}
