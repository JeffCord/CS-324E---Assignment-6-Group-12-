Bird bird_1 = new Bird(250,250,100);
PImage bird;
ArrayList<Firework> firework;
PVector gravity;


void setup() {
  size(800,800);
  background(250);
  bird = loadImage("bird.png");
  gravity = new PVector(0, 0.1);
  firework = new ArrayList<Firework>(); //empty

}

void draw() {
  background(0);
  bird_1.display();
  bird_1.isOver();
  bird_1.isClicked();
  
  if (bird_1.clicked == true && (bird_1.location.y != height - (bird_1.radius/2))) {
    bird_1.fall();
  }
  
  if (bird_1.location.y == height - (bird_1.radius/2)) {
    bird_1.slowDown();
  }  
  
  if (random(1) < 0.04) {
    firework.add(new Firework());
  }
  for (int i = firework.size()-1; i >= 0; i--) {
    Firework f = firework.get(i);
    f.update();
    f.display();
  }
}
