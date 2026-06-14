class Death {                //death animation of ravens || particle system for death

  Particle[] particles;
  PVector[] positions;
  int numDots = 50;
  float[] dotSizes;
  float maxSize = 3;
  float stddevSize = 2;
  PVector startPos;
  float explosionRad = 30;

  Death(PVector startPos) {
    this.startPos = startPos;
    positions = new PVector[numDots];
    dotSizes = new float[numDots];
    particles = new Particle[numDots];

    for (int i = 0; i < numDots; i++) {
      positions[i] = new PVector();
      positions[i].x = startPos.x + (randomGaussian() * explosionRad);
      positions[i].y = startPos.y + (randomGaussian() * explosionRad);

      float distance = dist(positions[i].x, positions[i].y, width/2, height/2);
      float size = map(distance, 0, explosionRad, 0.5, maxSize);
      
      dotSizes[i] = randomGaussian() * stddevSize + size;   

      PVector velocity = PVector.sub(positions[i], startPos).mult(0.05);

      particles[i] = new Particle(startPos, velocity, 255, dotSizes[i], #5A5A5A);
    }
  }

  void update() {
    for (int i = 0; i < numDots; i++) {
      if (particles[i] != null) {
        particles[i].update();
      }
    }
  }

  void display() {
    for (int i = 0; i < numDots; i++) {
      if (particles[i] != null) {
        particles[i].display();
      }
    }
  }

  boolean isFinished() {
    for (int i = 0; i < numDots; i++) {
      if (particles[i] != null && !particles[i].isDead()) {
        return false;
      }
    }
    return true;
  }
}
