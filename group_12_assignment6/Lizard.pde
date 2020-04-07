class Lizard {
  float x, y, xVel, yVel;
  int lifeSpan; // how many days a lizard can be alive without eating a bug
  int day; // increases by 1 every frame
  float size;
  boolean alive = true;
  boolean eating = false;

  Lizard(float x, float y) {
    this.x = x;
    this.y = y;
    xVel = random(-4, 4);
    yVel = random(-4, 4);
    lifeSpan = int(random(5, 11)) * 60;
    size = lifeSpan * 0.1;
  }

  void update() {
    if (alive) {
      if (day >= lifeSpan) {
        alive = false;
      }

      // bounces the bug off the edges of the screen
      if (x + (size / 2) >= width || x - (size / 2) <= 0) {
        xVel *= -1;
      }
      if (y + (size / 2) >= height || y - (size / 2) <= 0) {
        yVel *= -1;
      }

      noStroke();
      fill(0, 255, 125);
      circle(x, y, size);
      size = size - 0.05;
      x += xVel;
      y += yVel;
      day += 1;
    } else {
      fill(255);
      circle(x, y, size);
    }
  }

  // detects collision with a bug
  boolean hitPrey () {
    return true;
  }
}
