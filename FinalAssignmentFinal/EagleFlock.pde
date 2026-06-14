class EagleFlock {                //eagle system
  ArrayList<Eagle> flock = new ArrayList<Eagle>();
  float startingSpread = 50;
  int lastTimeEagleAdded= 0;
  int timeToAddEagle = 5000;
  float x, y, size;


  EagleFlock(float x, float y, int startingCount, float size) {
    this.x = x;
    this.y = y;
    this.size = size;
    for (int i=0; i<startingCount; i++) {
      addEagle(x, y, size);
    }
  }

  void run() {
    for (Eagle e : flock) {
      e.run(flock);
    }
    updateTime();
  }

  void groupUp(PVector pos) {            //enable grouping at target location
    for (Eagle e : flock) {
      e.toggleGroup();
      if (e.grouped) {
        e.flockCenter = pos;
      }
    }
  }

  void flyAway(PVector pos) {             //enable avoiding target location
    for (Eagle e : flock) {
      e.toggleAvoid();
      if (e.avoiding) {
        e.wallCenter = pos;
      }
    }
  }
  
  void encircle(PVector pos, float radius) {         //encircle in certain radius
    for (Eagle e : flock) {
      e.toggleCircle();
      if (e.circling) {
        e.circleCenter = pos;
        e.circleRadius = radius;
      }
    }
  }

  void addEagle(float x, float y, float size) {
    PVector pos = new PVector(x + random(-startingSpread, startingSpread), y+ random(-startingSpread, startingSpread));
    PVector vel = new PVector(random(-1, 1), random(-1, 1));
    PVector acc = new PVector(0, 0);
    flock.add(new Eagle(pos, vel, acc, size));
  }
  
  void updateTime() {              //add eagles every X milliseconds
    if (millis() - lastTimeEagleAdded >= timeToAddEagle) {
      addEagle(x,y,size);
      lastTimeEagleAdded = millis();
    }
  }
}
