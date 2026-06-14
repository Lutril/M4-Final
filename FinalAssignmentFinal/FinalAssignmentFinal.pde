/*
Anthony, Aerial Arsonist
 
 By Samuel Hawryluk and Jelle Brinkman
 
 A simple game where you're a wizard controllinga flock of birds and a fireball
 
 Take down ravens to up your score, try to make it as high as possible
 
 Goodluck
 
 
 -----
 DISCLAIMER
 ----
 
 Some of the parts of the code have been based on existing sources:
 
 Eagle - Originated from Shiffman's version, has been significantly modified;
 The main unchanged parts are the logic of seperate, align, cohesion.
 Other than new functions have been added and rest is modified.
 
 
 
 */



Wizard Anthony;                      //Globals
color hatColor;
Ball ball;
RavenHorde ravenhorde;
Landscape landscapeFar;
Landscape landscapeMiddle;
Landscape landscapeClose;
Landscape water;
PVector wizardPos;
float textSizer;

void setup() {
  fullScreen();                        //creating objects
  hatColor = color(#ad2bfb);
  wizardPos = new PVector(width*1/6, height*3/4);

  ball = new Ball(wizardPos); //Starting position of the ball
  ravenhorde = new RavenHorde(wizardPos);
  Anthony = new Wizard(wizardPos.x, wizardPos.y, 50, hatColor, 10, ravenhorde);
  landscapeFar = new Landscape(200, 0.005, 0.5, height/4, color(#ADC9D1));
  landscapeMiddle = new Landscape(170, 0.01, 2, height/2.5, color(#869893));
  landscapeClose = new Landscape(140, 0.01, 3.5, height/1.5, color(#5C7961));
  water = new Landscape(50, 0.01, 3.5, height-100, color(#1F91FF));
  textSizer = (width+height/2) / 40;
}

void draw() {                            //all the real time running

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
    ravenhorde.update(ball, Anthony);
    ravenhorde.display();
    displayText();
  }
}

void displayGameOverScreen() {                   //couple functions for the end screen and score

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
  textAlign(CORNER,CORNER);
  textSizer = (width+height/2) / 40;
  fill(#FF3B3B); // Red
  textSize(textSizer*2);
  text("Score: " + ravenhorde.score, textSizer, textSizer*2);
  fill(#050505); // Red
  textSize(textSizer);
  text("Press B to reset fireball", textSizer, textSizer*4);
  text("Press R to recall/release", textSizer, textSizer*5);
  text("Press and hold C to cast Birdnado", textSizer, textSizer*6);
}
