class RavenHorde {

  float interval = 3000;
  float lastInterval;
  ArrayList<Raven> ravenhorde;
  PVector trackpos;
  float birdSpeed = 1;

  RavenHorde(PVector trackpos) {
    this.trackpos = trackpos;
    ravenhorde = new ArrayList<Raven>();
    lastInterval = millis() + interval;
  }


  void update(Ball b, Wizard w) {

    if (lastInterval < millis()) {

      addRaven();

      lastInterval = millis() + interval;

      if (interval>300) {
        interval -=100;
        birdSpeed += 0.0005;
      }
    }

    updateRaven(b, w);
  }

  void display() {
    displayRaven();
  }



  void updateRaven(Ball b, Wizard w) {
    //update particles
    for (int i = ravenhorde.size()-1; i >= 0; i--) {
      Raven p = ravenhorde.get(i);
      p.update(b, w);

      if (p.dead) {
        ravenhorde.remove(i);
      }
    }
  }



  void displayRaven() {
    for (int i = 0; i < ravenhorde.size(); i++) {
      Raven p = ravenhorde.get(i);
      p.display();
    }
  }

  void addRaven() {
    PVector newSpawn;
    float x = random(200, width+200);
    float y = random(-100, height);
    if (x < width && y > 0) {
      y = random(-100,-50);
    }
    newSpawn = new PVector(x,y);
    ravenhorde.add(new Raven(newSpawn, trackpos, birdSpeed));
  }
}
