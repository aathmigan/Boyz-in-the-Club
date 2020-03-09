class Woman {
  void render() {
    imageMode(CORNER);
    PImage img;
    img = loadImage("player_f.png");
    rotate(radians(90));
    image(img, -25, -50, (186/3.5)*focusSize, (400/3.5)*focusSize);
  }
}
