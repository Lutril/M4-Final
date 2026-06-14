class Wizard {
  
  EagleFlock flock;
  RavenHorde horde;
  float x, y;
  float size;
  color c;
  float birdnadoX1, birdnadoX2, birdnadoY1, birdnadoY2, birdnadoRadius;
  boolean casting = false;
  color birdnadoColor = color(#358ae9);
  float hitBox = 50;
  boolean dead = false;


  Wizard(float x, float y, float size, color c, int startingsize, RavenHorde horde) {
    this.x = x;
    this.y = y;
    this.size = size;
    this.c = c;
    flock = new EagleFlock(x, y, startingsize, size/2);
    this.horde = horde;
  }

  void run() {
    flock.run();
    isHit();
    display();
  }

  void display() {
    pushMatrix();
    translate(x, y);
    fill(255);
    circle(0, 0, size);
    fill(c);
    triangle(-size, -size/3, size, -size/3, 0, -size*1.5);
    popMatrix();

    if (casting) {
      birdnadoDisplay();
    }
  }

  void birdnadoDisplay() {
    pushMatrix();
    translate(birdnadoX1, birdnadoY1);
    noFill();
    stroke(birdnadoColor);
    circle(0, 0, birdnadoRadius);
    popMatrix();
    stroke(0);
  }

  void recall() {
    PVector pos = new PVector(x, y-(size*3));
    flock.groupUp(pos);
    pos = new PVector(x, y);
    flock.flyAway(pos);
  }

  void birdnado() {
    PVector pos = new PVector(birdnadoX1, birdnadoY1);
    flock.encircle(pos, birdnadoRadius);
    resetBirdnado();
    casting = false;
  }

  void noteDownXY1(float x, float y) {
    if (!casting) {
      birdnadoX1 = x;
      birdnadoY1 = y;
      casting = true;
    }
  }

  void noteDownXY2(float x, float y) {
    birdnadoX2 = x;
    birdnadoY2 = y;
    birdnadoRadius = dist(birdnadoX1, birdnadoY1, birdnadoX2, birdnadoY2);
    ;
  }

  void resetBirdnado() {
    birdnadoX1 = 0;
    birdnadoY1 = 0;
    birdnadoX2 = 0;
    birdnadoY2 = 0;
    birdnadoRadius = 0;
  }

  boolean isHit() {
    
    for (int i = 0; i < horde.ravenhorde.size(); i++) {     
      Raven r = horde.ravenhorde.get(i);
      
      PVector position = new PVector(x, y);
      
      if (PVector.dist(position, r.position) < hitBox + r.hitbox) {
        dead = true;
        return true; 
      }
    }
    return false;
  }
}
