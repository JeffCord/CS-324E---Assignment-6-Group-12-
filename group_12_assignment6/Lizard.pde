class Lizard {
  float x, y, xVel, yVel, ogXVel, ogYVel;
  int lifeSpan; // how many days a lizard can be alive without eating a bug
  int day; // increases by 1 every frame
  float size;
  float sizeWhenDead = 10;
  boolean alive = true;

  float lifeBoost = 60;

  float detectRange;
  float speedBoost = 1.05;
  float speedDec = 0.95;
  boolean changedSpeed = false; // allows only one speed change per frame

  PImage livePic;
  PImage deadPic;
  PImage victoryPic;

  Lizard(float x, float y) {
    this.x = x;
    this.y = y;

    int xDir = int(random(0, 2));
    if (xDir == 0) {
      xVel = -4;
    } else {
      xVel = 4;
    }

    int yDir = int(random(0, 2));
    if (yDir == 0) {
      yVel = -4;
    } else {
      yVel = 4;
    }    

    ogXVel = xVel;
    ogYVel = yVel;
    lifeSpan = int(random(5, 11)) * 60; // range b/w [5, 10] seconds
    size = (10 * lifeSpan / 60) + sizeWhenDead;
    detectRange = (size / 2) + 180;
    livePic = loadImage("lizard.png");
    deadPic = loadImage("lizard_dead.png");
    victoryPic = loadImage("lizard_won.png");
  }

  void update(Bug [] bugs) {
    imageMode(CENTER);
    if (survivors != 0) {
      if (day >= lifeSpan) {
        alive = false;
      }
      if (alive) {


        if (survivors > 0) {
          // check for collision with bugs
          for (int i = 0; i < num_of_bugs; i++) {
            // eat a bug and boost lifespan/size if collision is detected 
            if (bugs[i].alive) {
              if (hitPrey(bugs[i])) {
                lifeSpan += lifeBoost;
                bugs[i].alive = false;
                survivors--;
              }
            }

            // if you did not eat the current bug this frame,
            // boost lizard speed if you are at least near it
            if (bugs[i].alive && !changedSpeed) {
              if (!bugs[i].detected) {
                if (nearPrey(bugs[i])) {
                  bugs[i].detected = true;
                }
              } else {
                bugs[i].detected = false;
              }
            }
          }
          changedSpeed = false;
        }

        bounce();
        livePic.resize(int(size), int(size)); 
        image(livePic, x, y);

        // every five days, the lizard will shrink a bit
        if (survivors > 0) {
          day += 1;
          if (day % 5 == 0) {
            size = (10 * (lifeSpan - day) / 60) + sizeWhenDead;
          }
        }

        x += xVel;
        y += yVel;
      } else {
        deadPic.resize(int(size), int(size));
        image(deadPic, x, y);
      }
    } else {
      victoryPic.resize(int(size), int(size));
      image(victoryPic, x, y);
    }
  }

  // detects collision with a live bug
  boolean hitPrey (Bug bug) {
    if (dist(x, y, bug.x, bug.y) <= (size / 2) + (bug.size / 2)) {
      if (!changedSpeed) {
        xVel = ogXVel;
        yVel = ogYVel;
      }
      return true;
    }
    return false;
  }

  // detects if a live bug is near the lizard
  boolean nearPrey (Bug bug) {
    float separation = dist(x, y, bug.x, bug.y);
    if (separation <= detectRange) {
      if (separation < bug.distFromPredator) {
        xVel *= speedBoost;
        yVel *= speedBoost;
      } else if (separation > bug.distFromPredator) {
        xVel *= speedDec;
        yVel *= speedDec;
      }
      bug.distFromPredator = separation;
      changedSpeed = true;
      return true;
    }
    return false;
  }

  void bounce() {
    // bounces the bug off the edges of the screen
    if (x + (size / 2) >= width || x - (size / 2) <= 0) {
      xVel *= -1;
    }
    if (y + (size / 2) >= height || y - (size / 2) <= 0) {
      yVel *= -1;
    }
  }
}
