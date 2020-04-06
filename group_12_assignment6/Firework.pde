class Firework {
  Particle firework = new Particle(random(width), height, true);
  Particle explosureP; 
  
  //disappear when reach the new location
  boolean exploded = false;

  ArrayList<Particle> explosureParticle;
  //Particle explosureParticle[];

  Firework() {
    exploded = false;
    //explosureParticle = null; //empty
    explosureParticle = new ArrayList<Particle>(); //empty
  }

  void update() {
    if (!exploded) {
      firework.applyForce(gravity);
      firework.update();

      if (firework.velocity.y >= 0) {
        exploded = true;

        explode();
      }
    }
    for (int i = 0; i < explosureParticle.size(); i++) {
      Particle p = explosureParticle.get(i);
      p.applyForce(gravity);
      p.update();
    }
  }

  void display() {
    if (!exploded) {
      firework.display();
    }

    for (int i = 0; i < explosureParticle.size(); i++) {
      Particle p = explosureParticle.get(i);
      p.display();
    }
  }

  void explode() {
    for (int i = 0; i < 100; i++) {
      explosureP = new Particle(firework.location.x, firework.location.y, false);//explosure starting point
      explosureParticle.add(explosureP);
    }
  }
}
