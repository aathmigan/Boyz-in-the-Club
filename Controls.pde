class Controls {  
  void render() {
    if (mouseY < height/2-10) {
      controlMovement.y = map(mouseY, height/4, height/2, speed, 0);
      if (controlMovement.y > speed) {
        controlMovement.y = speed;
      }
      posMouseGrid.y += controlMovement.y;
      posMouse.y += controlMovement.y;
      posBomb.y += controlMovement.y;
    }
    if (mouseX < width/2-10) {
      controlMovement.x = map(mouseX, width/4, width/2, speed, 0);
      if (controlMovement.x > speed) {
        controlMovement.x = speed;
      }
      posMouseGrid.x += controlMovement.x;
      posMouse.x += controlMovement.x;
      posBomb.x += controlMovement.x;
    }
    if (mouseY > height/2+10) {
      controlMovement.y = map(mouseY, height/2, height*0.75, 0, speed);
      if (controlMovement.y > speed) {
        controlMovement.y = speed;
      }
      posMouseGrid.y -= controlMovement.y;
      posMouse.y -= controlMovement.y;
      posBomb.y -= controlMovement.y;
      
    }
    if (mouseX > width/2+10) {
      controlMovement.x = map(mouseX, width/2, width*0.75, 0, speed);
      if (controlMovement.x > speed) {
        controlMovement.x = speed;
      }
      posMouseGrid.x -= controlMovement.x;
      posMouse.x -= controlMovement.x;
      posBomb.x -= controlMovement.x;
    }
  }
}
