class Landscape {           //mountain range in the background

  float xoff = 0.0;

  float mountainHeightRange;
  float mountainHeight;
  float mountainSpeed;
  float mountainWidth;
  color mountainColor;

  Landscape(float mountainHeightRange, float mountainSpeed, float mountainWidth, float mountainHeight, color mountainColor) {
    this.mountainHeightRange = mountainHeightRange;
    this.mountainSpeed = mountainSpeed;
    this.mountainWidth = mountainWidth;
    this.mountainHeight = mountainHeight;
    this.mountainColor = mountainColor;
  }


  void update() {
    xoff += mountainSpeed;
  }

  void display() {
    beginShape();
    fill(mountainColor);
    noStroke();

    float xOffset = xoff;

    for (float x = 0; x < width; x += mountainWidth) {

      float y = map(noise(xOffset), 0, 1, mountainHeight - mountainHeightRange, mountainHeight + mountainHeightRange);

      vertex(x, y);
      xOffset += mountainSpeed;
    }

    vertex(width, height);
    vertex(0, height);

    endShape(CLOSE);
  }
}
