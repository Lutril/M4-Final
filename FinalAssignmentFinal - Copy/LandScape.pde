
class Landscape {

  float xoff = 0.0;

  float mountainHeightRange = 200;
  float mountainSpeed = 0.001;
  float mountainWidth = 0.5;
  

  void update() {
    xoff += mountainSpeed;
  }

  void display() {
    beginShape();
    fill(#8C9AA0);
    noStroke();

    float xOffset = xoff;

    for (float x = 0; x < width; x += mountainWidth) {

      float y = map(noise(xOffset), 0, 1, height/3 - mountainHeightRange, height/2 + mountainHeightRange);

      vertex(x, y);
      xOffset += mountainSpeed;
    }

    vertex(width, height);
    vertex(0, height);

    endShape(CLOSE);
  }
}
