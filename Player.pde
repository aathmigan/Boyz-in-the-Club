class Player {
  PImage img3;
  private int bombColorChange = 100; 
  private boolean colorUp = true; 
  private float size = 0; 
  private boolean triggerCircle = false;
  Woman MainHuman = new Woman(); 
  void render() {
    img3 = loadImage("drink.png");
    pushMatrix();
    translate(width/2, height/2);
    rotate(targetAngle);
    if (controlMovement.x >= speed || controlMovement.y >= speed) {
      playerBody = true;
    } else {
      playerBody = false;
    }
    if (controlMovement.x > 2 || controlMovement.y > 1) {
      playerHead = true;
    } else {
      playerHead = false;
    }
    MainHuman.render();
    stroke(#FF0000); 
    popMatrix();
    if (bombExist == true && (trackBomb.x + 50 > (-1)*posMouse.x && trackBomb.x - 50 < (-1)*posMouse.x) && (trackBomb.y + 50 > (-1)*posMouse.y && trackBomb.y - 50 < (-1)*posMouse.y)) {
      speed -= 0.005;
    }
    if (mouseClicked == true && bombExist == true) {
      noStroke();
      if (bombColorChange > 254 || colorUp == false) {
        bombColorChange -= 5; 
        colorUp = false;
      }
      if (bombColorChange < 100 || colorUp == true) {
        bombColorChange += 5;  
        colorUp = true;
      }
      fill(255);
      strokeWeight(windowSize/800); 
      stroke(0); 
      if (aCircle > 0.9 || triggerCircle == true) {
        aCircle -= 0.01; 
        triggerCircle = true; 
        startTriggerCircle = false;
      }
      if ((aCircle < 0.6 || triggerCircle == false) && startTriggerCircle == false) {
        aCircle += 0.01; 
        triggerCircle = false;
        startTriggerCircle = false;
      }
      if (aCircle < 0.3 || startTriggerCircle == true) {
        aCircle += 0.03; 
        startTriggerCircle = true;
      }
      size = sin(aCircle)*130;
      imageMode(CENTER);
      image(img3, width/2+posBomb.x, height/2+posBomb.y, size*focusSize*2, size*focusSize*2);
    }
  }
}
