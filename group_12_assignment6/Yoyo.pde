class Yoyo {
  PImage ball;
  float xpos, ypos;
  float gravity = 0.5;
  float mass = 5;
  float xVel = mass;
  float yVel = gravity;
  float friction = 0.95;
  float rigidity = 0.15;
  float w = 20;
  float h = 80;
  float angle = 0;

  Yoyo (float x, float y) {
    ball = loadImage("pokeball.png");
    ball.resize(80, 80);
    this.xpos = x;
    this.ypos = y;
  }

  void update() {
    float currentX = mouseX;
    float currentY = mouseY;
    float xForce = (currentX - xpos) * rigidity; // determines how much xpos changes to calc. force
    float xAccel = xForce / mass; // use x change to determine x acceleration
    xVel = friction * (xVel + xAccel); // determines how much x pos should change based on friction coeff
    xpos = xpos + xVel; // changes x position
    
    float yForce = (currentY - ypos) * rigidity;
    yForce = yForce + gravity;
    float yAccel = yForce / mass;
    yVel = friction * (yVel + yAccel);
    ypos = ypos + yVel;
    display();
  }

  void display() {
    strokeWeight(5);
    stroke(175, 175, 0);
    line(xpos, ypos, mouseX, mouseY);
    fill(255, 0, 0);
    pushMatrix();
    translate(xpos, ypos);
    rotate(angle);
    image(ball, 0, 0);
    popMatrix();
    float angleChange = yVel * 0.05;
    angle += angleChange;
  }
}
