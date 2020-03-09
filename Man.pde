class Man {
  void render() {
    imageMode(CORNER);
    PImage img1;
    img1 = loadImage("player_m.png");
    rotate(radians(90));
    image(img1, -25, -50, (154/3.5)*focusSize, (400/3.5)*focusSize);
  }
}
