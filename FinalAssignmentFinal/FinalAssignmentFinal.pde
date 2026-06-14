Wizard Anthony;
color hatColor;
Ball ball;
RavenHorde ravenhorde;
Landscape landscapeFar;
Landscape landscapeMiddle;
Landscape landscapeClose;
Landscape water;
PVector wizardPos = new PVector(200, 880);

void setup() {
  fullScreen();
  hatColor = color(#ad2bfb);

  ball = new Ball(wizardPos); //Starting position of the ball
  ravenhorde = new RavenHorde(wizardPos);
  Anthony = new Wizard(wizardPos.x, wizardPos.y, 50, hatColor, 50, ravenhorde);
  landscapeFar = new Landscape(200, 0.005, 0.5, height/4, color(#ADC9D1));
  landscapeMiddle = new Landscape(170, 0.01, 2, height/2.5, color(#869893));
  landscapeClose = new Landscape(140, 0.01, 3.5, height/1.5, color(#5C7961));
  water = new Landscape(50, 0.01, 3.5, height-100, color(#1F91FF));
}

void draw() {

  background(#7CE1FF);

  if (Anthony.dead) {
    displayGameOverScreen();
  } else {

    landscapeFar.update();
    landscapeFar.display();
    landscapeMiddle.update();
    landscapeMiddle.display();
    landscapeClose.update();
    landscapeClose.display();
    water.update();
    water.display();

    Anthony.run();
    ball.update();
    ball.display();
    ravenhorde.update(ball);
    ravenhorde.display();
    displayText();
  }
}

void displayGameOverScreen() {

  fill(0, 0, 0, 150);
  rect(0, 0, width, height);


  textAlign(CENTER, CENTER);
  fill(#FF3B3B); // Red
  textSize(64);
  text("GAME OVER", width / 2, height / 2 - 50);

  // Instructie om te herstarten
  fill(255); // Wit
  textSize(24);
  text("Press 'Q' to restart", width / 2, height / 2 + 30);
  text("Score: " + ravenhorde.score, width / 2, height / 2 + 80);
}

void displayText() {

  fill(#FF3B3B); // Red
  textSize(64);
  text("Score: " + ravenhorde.score, 100, 70);
  fill(#050505); // Red
  textSize(32);
  text("Press B to reset fireball", 150, 120);
  text("Press R to reset recall", 150, 160);
  text("Press and hold C to cast Birdnado", 150, 200);
}
