void keyPressed() {
  if (key == 'r') {
    Anthony.recall();
  } else if (key == 'c') {
    Anthony.noteDownXY1(mouseX, mouseY);
  } else if (key == 'b') {
    ball.reset(wizardPos);
  }
  if (Anthony.dead && (key == 'q' || key == 'Q')) {
    resetGame();
  }
}

  void keyReleased() {
    if (key == 'c') {
      Anthony.noteDownXY2(mouseX, mouseY);
      Anthony.birdnado();
    }
  }

  void mouseMoved() {
    Anthony.noteDownXY2(mouseX, mouseY);
  }

  void mousePressed() {
    ball.mousePressedEvent(new PVector(mouseX, mouseY));
  }

  void mouseDragged() {
    ball.mouseDraggedEvent(new PVector(mouseX, mouseY));
  }
  void mouseReleased() {
    ball.mouseReleasedEvent();
  }


  void resetGame() {
    Anthony.dead = false;
    
    ball.reset(wizardPos);
    ravenhorde.ravenhorde.clear();
    ravenhorde.birdSpeed = 4;
    ravenhorde.interval = 3000;
    ravenhorde.score = 0;
  }
