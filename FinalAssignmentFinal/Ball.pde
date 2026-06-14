
class Ball {
  
  //Code structure provided
  PVector location;
  PVector velocity;
  PVector acceleration;
  PVector gravity = new PVector(0, 0.2); // Gravity on the ball
  PVector startPos;

  float friction = 0.99;
  int radius = 10;

  ArrayList<Particle> particles;

  //catapult  
  PVector dragPosition; // Position of ball after it is dragged
  boolean dragging = false; // Check for dragging
  boolean pressed = false; // Check for pressing
  boolean isShot = false;
  int maxLifespan = 255;
  
  
  
  // Constructor
  Ball(PVector location) {
    this.location = location.copy(); //Copy feature: creating a new Pvector with the same values/coordinats+direction
    this.startPos = location.copy();
    this.velocity = new PVector();
    this.acceleration = new PVector();

    particles = new ArrayList<Particle>();
    
    this.dragPosition = location.copy();
  }

  // Update ball position + physics
  void update() {
    if (isShot) {
      if (isOutOfScreen()) {
        reset(startPos);
      }
      acceleration.add(gravity); //Adding gravity to accel
      velocity.add(acceleration); //Updating velocity
      velocity.mult(friction); //Adding friction
      location.add(velocity); //Adding velocity


      if (location.y > height-radius) {
        location.y = height-radius;
        velocity.y *= -0.95; //Slow down when ground hit
      }
      acceleration.mult(0); //resetting the acceleration to 0
    }

    updateParticle();
  }


  void display() {
    
    displayAim();
    displayParticle();

    fill(255, 0, 0); // color ball
    noStroke();
    ellipse(location.x, location.y, radius * 2, radius * 2); 
  }



  //Checking if ball reached the canvas borders
  boolean isOutOfScreen() {
    return (location.x < -100 || location.x > width+100);
  }

  // Reset the ball to a given location
  void reset(PVector location) {
    this.location.set(location);
    this.velocity.set(0, 0);
    this.acceleration.set(0, 0);
    isShot = false;
  }
  //Set ball location

  void setlocation(PVector location) {
    this.location.set(location);
  }

  //Set ball velocity
  void setVelocity(PVector velocity) {
    this.velocity.set(velocity);
  }


  void updateParticle() {
    //update particles
    for (int i = particles.size()-1; i >= 0; i--) {
      Particle p = particles.get(i);
      p.update();
      if (p.isDead()) particles.remove(i);
    }
  }

  void displayParticle() {
    addParticle(location);
    for (int i = 0; i < particles.size(); i++) {
      Particle p = particles.get(i);
      p.display();
    }
  }

  void addParticle(PVector location) {
    particles.add(new Particle(location.copy(), new PVector(random(-1.5, 1.5), random(-2, 0)), 255, random(4,10), #FFB803));
  }

  void displayAim() {

    stroke(#FFCF31);
    strokeWeight(4);

    // Catapult band
    if (dragging) {
      line(startPos.x, startPos.y, dragPosition.x, dragPosition.y);      
    } 
  }

  void mousePressedEvent(PVector mouse) {
    
    if (PVector.dist(mouse, location) < radius && !isShot) {
      pressed = true;
      dragPosition.set(mouse); 
    }
  }

  void mouseReleasedEvent() {
    if (dragging) {
      
      PVector force = PVector.sub(startPos, dragPosition).mult(0.3);
      setVelocity(force);
      isShot = true;
      dragging = false;
      pressed = false;
    
    }
  }

  void mouseDraggedEvent(PVector mouse) {
    if (pressed) {
      dragging = true;
      dragPosition.set(mouse);
      setlocation(mouse);
    }
  }
}
