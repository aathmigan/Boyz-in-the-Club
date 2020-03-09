class Enemy {
  PVector enemyPos = new PVector(random(windowSize*1.1, windowSize*1.4), random(windowSize*1.1, windowSize*1.4));  
  private PVector velocity = new PVector(0, -1); 
  private boolean enemyhitBomb = false; 
  private float distancePlayerEnemy = 0; 
  private float reactionSpeed = random(0.02, 0.05);
  private float lastTimeEnemy = 0; 
  Man EnemyHuman = new Man(); 
  private float speedEnemy = random(6, 8); 
  void render() {
    if (time - lastTimeEnemy >= everyTime) {
      if (speedEnemy >= 10) {
        speedEnemy = 10;
      } else {
        speedEnemy += 0.4;
      }
      if (reactionSpeed >= 1) {
        reactionSpeed = 1;
      } else {
        reactionSpeed += random(0.005, 0.01);
      }
      lastTimeEnemy = time;
    }
    PVector target = new PVector(-posMouse.x, -posMouse.y); 
    target.sub(enemyPos);  
    target.normalize();
    velocity.normalize();
    velocity.y = lerp( velocity.y, target.y, reactionSpeed);
    velocity.x = lerp( velocity.x, target.x, reactionSpeed);
    float angle = abs(target.heading()-velocity.heading());
    velocity.normalize();
    velocity.mult(map(angle, 0, 180, speedEnemy, 1));
    enemyPos.add(velocity); 
    pushMatrix();
    if (bombExist == true && (trackBomb.x + 50 > enemyPos.x && trackBomb.x - 50 < enemyPos.x) && (trackBomb.y + 50 > enemyPos.y && trackBomb.y - 50 < enemyPos.y)) {
      enemyhitBomb = true;
    } else {
      enemyhitBomb = false;
    }
    distancePlayerEnemy = (sqrt((abs(posMouse.x+enemyPos.x)*abs(posMouse.x+enemyPos.x))+(abs(posMouse.y+enemyPos.y)*abs(posMouse.y+enemyPos.y))));
    if (distancePlayerEnemy > windowBig*2) {
      enemyPos = new PVector((-(posMouse.x)-width*random(1.3, 1.8)), (-(posMouse.y)-height*random(1.3, 1.8)));
    }
    translate(enemyPos.x, enemyPos.y);
    if (enemyhitBomb == true) {
      if (speedEnemy >= 9) {
        speedEnemy = 8;
      }
      if (speedEnemy >= 7 && speedEnemy < 9) {
        speedEnemy = 7;
      }
      if (reactionSpeed >= 0.5) {
        reactionSpeed = 0.1;
      }
      if (reactionSpeed <= 0.5) {
        reactionSpeed = 0.01;
      }
    }
    if ((posMouse.x + enemyPos.x) < (windowSize/18) && (posMouse.x + enemyPos.x) > -(windowSize/18) && (posMouse.y + enemyPos.y) < (windowSize/18) && (posMouse.y + enemyPos.y) > -(windowSize/18)) {
      dead = true;
    }
    rotate(velocity.heading());
    if (abs(velocity.x) > 6 || abs(velocity.y) > 6) {
      playerBody = true;
    } else {
      playerBody = false;
    }
    if (abs(velocity.x) > 3 || abs(velocity.y) > 3) {
      playerHead = true;
    } else {
      playerHead = false;
    }
    EnemyHuman.render();
    if (dead == true) {
      activeState = "GameOver";
    }
    popMatrix();
  }
}
