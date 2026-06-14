Wizard Anthony;
color hatColor;
Ball ball;
RavenHorde ravenhorde;
Landscape landscape;
PVector wizardPos = new PVector(200, 880);

void setup() {
  fullScreen();
  hatColor = color(#ad2bfb);
  Anthony = new Wizard(wizardPos.x, wizardPos.y, 50, hatColor, 10);
  ball = new Ball(wizardPos); //Starting position of the ball
  ravenhorde = new RavenHorde(wizardPos);
  landscape = new Landscape();
}

void draw() {
  background(255);
  landscape.update();
  landscape.display();
  Anthony.run();
  ball.update();
  ball.display();
  ravenhorde.update(ball, Anthony);
  ravenhorde.display();
}
