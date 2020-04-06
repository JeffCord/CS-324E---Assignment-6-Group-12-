class PaddleBall {
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
  PaddleParticle part1;

  PaddleBall (float x, float y) {
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
    noStroke();
    fill(255, 0, 0);
    ellipse(mouseX, mouseY, 60, 80);
    rectMode(CENTER);
    rect(mouseX, mouseY + 35, 16, 30);
    ellipse(mouseX, mouseY + 55, 25, 45);
    
    strokeWeight(5);
    stroke(255);
    line(xpos, ypos, mouseX, mouseY);
    line(xpos + 20, ypos, mouseX, mouseY);
    line(xpos - 20, ypos, mouseX, mouseY);

    pushMatrix();
    translate(xpos, ypos);
    rotate(angle);
    image(ball, 0, 0);
    popMatrix();
    float angleChange = yVel * 0.05;
    angle += angleChange;
    float dist = dist(mouseX, mouseY, xpos, ypos);
    if (dist >= 50) {
      println("peak", dist);
    }
  }
}
