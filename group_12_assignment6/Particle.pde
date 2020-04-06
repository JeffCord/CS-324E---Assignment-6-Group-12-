class Particle {
  PVector location;
  PVector velocity;
  PVector acceleration;
  boolean firework;
  float lifespan = 255; //alpha value
  float c;//color

  Particle(float x, float y, float c, boolean firework) {
    location =  new PVector(x, y);
    this.c = c;
    this.firework = firework;

    if (firework) {
      velocity = new PVector(0, random(-12, -8));
    } else {
      velocity = PVector.random2D(); //point to random directions
      velocity.mult(random(1, 15)); //exposure range
    }

    acceleration = new PVector(0, 0);
    //lifespan = 255.0;
  }

  void applyForce(PVector force) {
    acceleration.add(force);
  }

  void update() {
    if (!firework) {
      velocity.mult(0.8);//slows down every frame (exposure particles)
      lifespan -= 5;
    }

    velocity.add(acceleration);
    location.add(velocity);

    acceleration.mult(0); //clear
  }

  void display() {
    if (!firework) {
      strokeWeight(2);
      stroke(c, 255, 255, lifespan);
    } else {
      strokeWeight(4);
      stroke(c, 255, 255);
    }

    point(location.x, location.y);
  }
}
