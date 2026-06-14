class Raven {

  Death death;
  PVector position;
  PVector trackPos;
  PVector velocity;
  Boolean dead = false;
  float hitbox = 30;
  boolean dying;
  boolean flying = true;
  float birdSpeed;

  Raven(PVector position, PVector trackPos, float birdSpeed) {

    this.position = position;
    this.trackPos = trackPos;
    this.birdSpeed = birdSpeed;
  }

  void update(Ball b, Wizard w) {

    if ((flying && isHit(b.location, b.radius)) || (flying && checkEagleHits(w))) {
      dying = true;
      flying = false;

      death = new Death(position);
    }

    if (flying) {
      velocity = PVector.sub(trackPos, position);
      velocity.normalize();
      velocity.mult(birdSpeed);
      position.add(velocity);
    }

    if (death != null) {
      death.update();

      if (death.isFinished()) {
        dead = true;
      }
    }
  }


  void display() {


    if (dying && death != null) {
      death.display();
    }

    if (flying) {
      fill(#363636);
      pushMatrix();
      translate(position.x, position.y);

      //body
      ellipse(0, 0, 50, 30);
      ellipse(-25, -10, 20, 20);

      //beak
      triangle(-25, -15, -25, -5, -50, -10);

      //eye
      fill(#FAFAFA); //white
      ellipse(-27, -10, 7, 7);
      fill(#363636);
      ellipse(-28, -10, 4, 4);
      triangle(-33, -10, -20, -15, -25, -20);

      //tail
      triangle(15, -12, 10, 5, 40, 5);

      // wings


      triangle(-25, 0, 10, 0, 30, 50*sin(millis()*0.01));

      popMatrix();
    }
  }
  
  Boolean checkEagleHits(Wizard w) {
    for (Eagle e : w.flock.flock) {
      if (isHit(e.position, e.size)) {
        return true;
      }
    }
    return false;
  }

  Boolean isHit (PVector killObject, float objectSize) {
    return(PVector.dist(position, killObject) < hitbox + objectSize);
  }
}
