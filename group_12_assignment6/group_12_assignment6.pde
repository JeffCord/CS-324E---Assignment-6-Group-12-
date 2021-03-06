Bird bird_1 = new Bird(random(0,width), 250, 1);
PImage bird;
ArrayList<Firework> firework;
PVector gravity;
PaddleBall pb1;
Bug [] bugs;
int num_of_bugs = 10;
Lizard [] lizards;
int num_of_lizards = 5;
int survivors = num_of_bugs;
int ballX;
int ballY;


void setup() {
  frameRate = 10;
  size(800, 800);
  background(250);
  colorMode(HSB); // this might affect something, be aware
  saveFrame();


  bird = loadImage("bird.png");
  gravity = new PVector(0, 0.1);
  firework = new ArrayList<Firework>(); //empty
  pb1 = new PaddleBall(width/2, height/2);
  bugs = new Bug [num_of_bugs];
  lizards = new Lizard[num_of_lizards];
  for (int i = 0; i < num_of_bugs; i++) {
    bugs[i] = new Bug(random(50, width - 50), random(50, height - 50));
    if (i < num_of_lizards) {
      lizards[i] = new Lizard(random(61, width - 61), random(61, height - 61));
    }
  }
}

void draw() {
  background(0);
  colorMode(RGB);
  for (int i = 0; i < num_of_bugs; i++) {
    bugs[i].update();
  }

  for (int i = 0; i < num_of_lizards; i++) {
    lizards[i].update(bugs);
  }

  // update the paddleball
  pb1.update();
  
  // bird actions
  push();
  bird_1.display();
  pop();
  
  if (bird_1.radius < 100 && bird_1.clicked == false) {
    bird_1.appear();
  }

  if (dist(bird_1.location.x, bird_1.location.y, pb1.xpos, pb1.ypos) <= 90) {
    bird_1.fall();
    bird_1.clicked = true;
  }

  if (bird_1.clicked == true && (bird_1.location.y != height - (bird_1.radius/2))) {
    bird_1.fall();
  }

  if (bird_1.location.y == height - (bird_1.radius/2)) {
    bird_1.slowDown();
  }  
  
  if (abs(bird_1.velocity.x) < .05 && bird_1.clicked == true) {
    bird_1.disappear();
  }
  
  if (bird_1.radius < 1) {
   bird_1 = new Bird(random(0,width), 250, 1);
  }
  
  // firework actions
  colorMode(HSB);
  if (random(1) < 0.04) {
    firework.add(new Firework());
  }
  for (int i = firework.size()-1; i >= 0; i--) {
    Firework f = firework.get(i);
    f.update();
    f.display();
  }
}
