class Bird {
  
  float x, y, radius, damp, friction, angle;
  int rad;
  boolean over,clicked, fall;
  PVector location;
  PVector velocity;
  PVector gravity;
  
  Bird(float x, float y, float radius) {
    this.x = x;
    this.y = y;
    this.radius = radius;
    this.velocity = velocity;
    this.location = location;
    this.gravity = gravity;
    this.over = over;
    this.clicked = clicked;
    location = new PVector(x,y);
    velocity = new PVector(2,0);
    gravity = new PVector(0,.2);
    damp = .6;
    fall = false;
    rad = 0;
    friction = .96;
    angle = 0;
  }
  
  void display() {
  
    if ((location.x > width-(radius/2)) || (location.x < (radius/2))) {
     velocity.x = velocity.x * -1;
    }
    location.add(velocity);
    if (clicked == false) {
      noStroke();
      fill(0,0,0,1);
      circle(location.x,location.y,radius);
      imageMode(CENTER);
      image(bird,location.x,location.y,radius,radius);
    }
    if (clicked == true && abs(velocity.x) > 1.1) {
     angle += .1;
     translate(location.x,location.y);
     noStroke();
     fill(0,0,0,1);
     circle(0,0,radius);
     imageMode(CENTER);
     rotate(angle);
     image(bird,0,0,radius,radius); 
    }
    if (clicked == true && abs(velocity.x) < 1.1) {
     translate(location.x,location.y);
     noStroke();
     fill(0,0,0,1);
     circle(0,0,radius);
     imageMode(CENTER);
     rotate(angle);
     image(bird,0,0,radius,radius); 
    }


   
  }
  
  void isOver() {
    if (dist(mouseX,mouseY,location.x,location.y) <= (radius/2)) {
      over = true;
  } else {
      over = false;
  }
  }
 
  void isClicked() {
    if (over == true && mousePressed ) {
     clicked = true;
    }
  }
  
  void fall() {
    if (fall == false) {
      fall = true;
    }
    velocity.add(gravity);
    if (location.y > height-(radius/2)) {
     velocity.y = velocity.y * - damp;
     location.y = height- (radius/2); 
    if (abs(velocity.y) < 1.6) {
      velocity.y  = 0;
    }
    }    
  }
  
  void slowDown() {
   velocity.x = velocity.x * friction;   
  }
  
  void disappear() {
   radius -= 5; 
  }
  
  void appear(){
    radius += 2;
  }
}
