class Eagle {
  PVector position;
  PVector velocity;
  PVector acceleration;
  float maxSpeed = 12;
  float maxForce = 0.12;
  float size;
  color c = color(#b3b3b3);

  boolean grouped = false;
  PVector flockCenter;

  boolean avoiding = false;
  PVector wallCenter;

  boolean circling = false;
  PVector circleCenter;
  float circleRadius;

  Eagle(PVector position, PVector velocity, PVector acceleration, float size) {
    this.position = position;
    this.velocity = velocity;
    this.acceleration = acceleration;
    this.size = size;
  }

  void run(ArrayList<Eagle> eagles) {
    flock(eagles);
    update();
    borders();
    render();
  }

  void render() {
    float theta = velocity.heading2D() + radians(90);
    //stroke(#0F0F0F);
    //strokeWeight(1);
    fill(#DEDEDE);
    pushMatrix();
    translate(position.x, position.y);
    if (theta > -HALF_PI && theta < HALF_PI) {
      rotate(theta + PI/2);
      scale(1, -1);
    } else {
      rotate(theta + PI/2);
    }

    //body
    ellipse(0, 0, 50, 30);
    ellipse(-25, -10, 20, 20);

    //beak
    triangle(-25, -15, -25, -5, -50, -10);

    //eye
    fill(#0F0F0F); //white
    ellipse(-27, -10, 7, 7);
    fill(#DEDEDE);
    ellipse(-28, -10, 4, 4);
    //triangle(-33, -10, -20, -15, -25, -20);

    //tail
    triangle(15, -12, 10, 5, 40, 5);

    // wings


    triangle(-25, 0, 10, 0, 30, 50*sin(millis()*0.01));

    popMatrix();
    noStroke();
  }

  void update() {
    velocity.add(acceleration);
    velocity.limit(maxSpeed);
    position.add(velocity);
    acceleration.mult(0);
  }

  void applyForce(PVector force) {
    // We could add mass here if we want A = F / M
    acceleration.add(force);
  }


  void flock(ArrayList<Eagle> eagles) {
    PVector sep = separate(eagles);   // Separation
    PVector ali = align(eagles);      // Alignment
    PVector coh = cohesion(eagles);   // Cohesion
    // Arbitrarily weight these forces
    if (grouped) {
      PVector group = seek(flockCenter);
      group.mult(2.6);
      sep.mult(1.7);
      ali.mult(1.2);
      coh.mult(1.8);
      applyForce(group);
    } else if (circling) {
      PVector enc = encircle();
      enc.mult(3);
      applyForce(enc);
      sep.mult(2);
      ali.mult(1);
      coh.mult(1);
    } else if (!grouped) {
      sep.mult(1.7);
      ali.mult(1.3);
      coh.mult(1.4);
    }
    if (avoiding) {
      PVector avoid = seek(wallCenter).mult(-1);
      avoid.mult(1.2);
      applyForce(avoid);
    }
    // Add the force vectors to acceleration
    applyForce(sep);
    applyForce(ali);
    applyForce(coh);
  }

  PVector seek(PVector target) {
    PVector desired = PVector.sub(target, position);  // A vector pointing from the position to the target
    // Normalize desired and scale to maximum speed
    desired.normalize();
    desired.mult(maxSpeed);
    // Steering = Desired minus Velocity
    PVector steer = PVector.sub(desired, velocity);
    steer.limit(maxForce);  // Limit to maximum steering force
    return steer;
  }

  // Wraparound
  void borders() {
    if (position.x < size) {
      position.x = size;
      velocity.x *= -1;
    } else if (position.x > width - size) {
      position.x = width - size;
      velocity.x *= -1;
    }

    if (position.y < size) {
      position.y = size;
      velocity.y *= -1;
    } else if (position.y > height - size) {
      position.y = height - size;
      velocity.y *= -1;
    }
  }

  // Separation
  // Method checks for nearby boids and steers away
  PVector separate (ArrayList<Eagle> eagles) {
    float desiredseparation = 60.0f;
    PVector steer = new PVector(0, 0, 0);
    int count = 0;
    // For every boid in the system, check if it's too close
    for (Eagle other : eagles) {
      float d = PVector.dist(position, other.position);
      // If the distance is greater than 0 and less than an arbitrary amount (0 when you are yourself)
      if ((d > 0) && (d < desiredseparation)) {
        // Calculate vector pointing away from neighbor
        PVector diff = PVector.sub(position, other.position);
        diff.normalize();
        diff.div(d);        // Weight by distance
        steer.add(diff);
        count++;            // Keep track of how many
      }
    }


    // Average -- divide by how many
    if (count > 0) {
      steer.div((float)count);
    }

    // As long as the vector is greater than 0
    if (steer.mag() > 0) {
      // Implement Reynolds: Steering = Desired - Velocity
      steer.normalize();
      steer.mult(maxSpeed);
      steer.sub(velocity);
      steer.limit(maxForce);
    }
    return steer;
  }

  // Alignment
  // For every nearby boid in the system, calculate the average velocity
  PVector align (ArrayList<Eagle> eagles) {
    float neighbordist = 50;
    PVector sum = new PVector(0, 0);
    int count = 0;
    for (Eagle other : eagles) {
      float d = PVector.dist(position, other.position);
      if ((d > 0) && (d < neighbordist)) {
        sum.add(other.velocity);
        count++;
      }
    }
    if (count > 0) {
      sum.div((float)count);
      sum.normalize();
      sum.mult(maxSpeed);
      PVector steer = PVector.sub(sum, velocity);
      steer.limit(maxForce);
      return steer;
    } else {
      return new PVector(0, 0);
    }
  }

  // Cohesion
  // For the average position (i.e. center) of all nearby boids, calculate steering vector towards that position
  PVector cohesion (ArrayList<Eagle> eagles) {
    float neighbordist = 50;
    PVector sum = new PVector(0, 0);   // Start with empty vector to accumulate all positions
    int count = 0;
    for (Eagle other : eagles) {
      float d = PVector.dist(position, other.position);
      if ((d > 0) && (d < neighbordist)) {
        sum.add(other.position); // Add position
        count++;
      }
    }
    if (count > 0) {
      sum.div(count);
      return seek(sum);  // Steer towards the position
    } else {
      return new PVector(0, 0);
    }
  }

  PVector encircle() {
    PVector steer = new PVector(circleCenter.x -position.x, circleCenter.y - position.y);
    PVector tangent = new PVector(-steer.y, steer.x);
    steer.mult(0.8);
    steer.add(tangent);
    steer.normalize();
    steer.mult(maxSpeed);
    steer.sub(velocity);
    steer.limit(maxForce);
    return steer;
  }

  void toggleGroup() {
    grouped = !grouped;
    circling = false;
  }

  void toggleAvoid() {
    avoiding = !avoiding;
  }

  void toggleCircle() {
    circling = !circling;
  }
}
