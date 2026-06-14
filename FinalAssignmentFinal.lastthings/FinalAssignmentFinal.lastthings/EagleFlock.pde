class EagleFlock {
  ArrayList<Eagle> flock = new ArrayList<Eagle>();
  float startingSpread = 50;

  EagleFlock(float x, float y, int startingCount, float size) {
    for (int i=0; i<startingCount; i++) {
      PVector pos = new PVector(x + random(-startingSpread, startingSpread), y+ random(-startingSpread, startingSpread));
      PVector vel = new PVector(random(-1, 1), random(-1, 1));
      PVector acc = new PVector(0, 0);
      flock.add(new Eagle(pos, vel, acc, size));
    }
  }

  void run() {
    for (Eagle e : flock) {
      e.run(flock);
    }
  }

  void groupUp(PVector pos) {
    for (Eagle e : flock) {
      e.toggleGroup();
      if (e.grouped) {
        e.flockCenter = pos;
      }
    }
  }

  void flyAway(PVector pos) {
    for (Eagle e : flock) {
      e.toggleAvoid();
      if (e.avoiding) {
        e.wallCenter = pos;
      }
    }
  }
  
  void encircle(PVector pos, float radius) {
    for (Eagle e : flock) {
      e.toggleCircle();
      if (e.circling) {
        e.circleCenter = pos;
        e.circleRadius = radius;
      }
    }
    
  }
}
