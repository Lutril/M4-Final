          class Particle {
  
  PVector pos, vel, grav;
  PVector acceleration;
  int lifespan;
  float size;
  color Color;

  Particle(PVector position, PVector velocity, int lifespan, float size , color Color) {
    pos = position.copy();
    this.vel = velocity.copy();
    grav = new PVector(0, 0.02);
    this.lifespan = lifespan;
    this.Color = Color;
    this.size = size;
  }

  void update() {
   vel.add(grav);
    pos.add(vel);
    lifespan -= 4;
  }

  void display() {
    noStroke();
    fill(Color, lifespan);
    circle(pos.x, pos.y, size);
  }

  boolean isDead() {
    return lifespan <= 0;
  }
}
