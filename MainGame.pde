// Design 
import ddf.minim.*;
Minim minim;
AudioPlayer player;
float timeSound = 8; 
float lasttimeSound = 9.7; 
boolean muteGame = false; 
PFont font;
PVector enemyPos = new PVector(random(200, 300), random(200, 300)); 
String activeState = "Menu";
PFont MainFont;
boolean playerBody = false; 
boolean playerHead = false; 
int everyTime = 20; 
// Rotation
float angle = 0;
float targetAngle = 0;
float easing = 1f;
// Game, Controls
float windowSize = 0; 
float windowBig = 0; 
float focusSize = 1; 
PVector controlMovement = new PVector(0, 0); 
float speed = 5.5; 
float lastTimeColor = 0;
// Player
float distancePlayer = 0; 
FocusOut FocusOut = new FocusOut();
Controls Controls = new Controls();
Player MainPlayer = new Player(); 
boolean bombExist = false; 
boolean startTriggerCircle = false; 
float aCircle = 0.2;
float Score = 0; 
float currentScore = 0; 
// Enemy 
boolean dead = false;
Enemy MainEnemy = new Enemy(); 
ArrayList<Enemy> enemies = new ArrayList<Enemy>();
int CountEnemies = 1; 
// Positioning
PVector posMouseGrid = new PVector(0, 0); 
PVector posMouse = new PVector(0, 0); 
PVector posBomb = new PVector(0, 0); 
PVector trackBomb = new PVector(0, 0); 
// Check Input 
boolean mouseClicked = false; 
float bombTime = 10; 
float time = 0; 
float lastTime = 0; 
float gameoverTime = 0;
// Messages
String pauseMsg = "c = continue, q = quit"; 
String menuMsg = "p = play, m = Mute, q = quit";
String gameDisplay = "";
String gameDisplaybelow = "P = Pause";
String gameoverMsg = "";
String credits = "Boyz in the Club\n\n© Aathmigan Jegatheeswaran, 2020\n\nwww.aathmigan.com";
String storyMsg = "Escape from the creepy boys in the club.\n\nC = Continue";
String instructionsMsg = "Use Mouse to move\nPress left mouse button to place a drink\n\nC = Continue";

void setup() {
  minim = new Minim(this);
  player = minim.loadFile("bg_sound.mp3");
  font = createFont("font.ttf", 32);
  textFont(font, 16);
  fullScreen(FX2D); 
  if (width >= height) {
    windowSize = height;
  } else {
    windowSize = width;
  }
  if (height > width) {
    windowBig = height;
  } else {
    windowBig = width;
  }
  for (int i = 0; i < 10; i++) {
    enemies.add(new Enemy());
  }
}

void draw() {
  timeSound += 0.01;
  timeSound += 0.01;
  if (muteGame == false) {
    if (timeSound < 10) {
      lasttimeSound = timeSound; 
      if ( player.isPlaying() )
      {
      } else {
        player.play();
      }
    }
  } else {
    player.pause();
  }

  if (timeSound-lasttimeSound >65) {
    {
      if ( player.isPlaying() )
      {
      } else {
        player.play();
      }
      lasttimeSound = timeSound;
      player.rewind();
      player.play();
    }
  }
  if (activeState.equals("Menu")) {
    runMenu();
  }
  if (activeState.equals("Instructions")) {
    runInstructions();
  }
  if (activeState.equals("MainGame")) {
    runMainGame();
  }
  if (activeState.equals("Pause")) {
    runPause();
  }
  if (activeState.equals("GameOver")) {
    runGameOver();
  }
  if (activeState.equals("Quit")) {
    runQuit();
  }
  if (activeState.equals("Story")) {
    runStory();
  }
}

void runPause() {
  background(255);
  fill(0); 
  pauseMsg = pauseMsg.toUpperCase();
  textAlign(CENTER, CENTER);
  text(pauseMsg, width/2, height/2);
}

void runMenu() {
  background(255);
  fill(0); 
  menuMsg = menuMsg.toUpperCase();
  textAlign(CENTER, CENTER);
  text(menuMsg, width/2, height/2);
}

void runInstructions() {
  background(255);
  fill(0); 
  instructionsMsg = instructionsMsg.toUpperCase();
  textAlign(CENTER, CENTER);
  text(instructionsMsg, width/2, height/2);
}

void runStory() {
  background(255);
  fill(0); 
  storyMsg = storyMsg.toUpperCase();
  textAlign(CENTER, CENTER);
  text(storyMsg, width/2, height/2);
}


void runQuit() {
  gameoverTime += 0.1; 
  background(255);
  fill(0); 
  credits = credits.toUpperCase();
  text(credits, width/2, height/2);  
  if (gameoverTime > 10) {
    exit();
  }
}

void runGameOver() {
  background(255);
  fill(0); 
  gameoverMsg = "Game Over\n\nScore: "+Score+"\n\nq = quit";
  gameoverMsg = gameoverMsg.toUpperCase();
  textAlign(CENTER, CENTER);
  text(gameoverMsg, width/2, height/2);
}

void runMainGame() {
  Score = round(time); 
  time += 0.1; 
  if (bombTime > 10) {
    bombExist = false;
  }
  bombTime += 0.01;
  if (time - lastTime >= everyTime) {
    if (speed >= 6.5) {
      speed = 6.5;
    } else {
      if (speed < 6) {
        speed += 0.3;
      } else {
        speed += 0.05;
      }
    }
    currentScore = Score; 
    CountEnemies += 1;
    lastTime = time;
  }
  if (CountEnemies > 10) {
    CountEnemies = 10;
  }
  distancePlayer = (sqrt((abs(width/2-mouseX)*abs(width/2-mouseX))+(abs(height/2-mouseY)*abs(height/2-mouseY))));
  if (time - lastTimeColor >= 5) {
    background(0); 
    if (time - lastTimeColor >= 6) {
      lastTimeColor = time;
    }
  } else {
    background(255);
  }
  fill(0); 
  textAlign(LEFT);
  gameDisplay = "Score: "+round(Score);
  gameDisplay = gameDisplay.toUpperCase();
  text(gameDisplay, 50, 50);
  textAlign(RIGHT);
  gameDisplaybelow = gameDisplaybelow.toUpperCase();
  text(gameDisplaybelow, width - 50, height - 50);
  angle = atan2( mouseY - height/2, mouseX - width/2 );
  float dir = (angle - targetAngle) / TWO_PI;
  dir -= round(dir);
  dir *= TWO_PI;
  targetAngle += dir * easing;
  Controls.render();
  FocusOut.render();
  for (float y = -1*height*0.5; y < height*1.5; y += (windowSize/15)*focusSize) {
    for (float x = -1*width*0.5; x < width*1.5; x += (windowSize/15)*focusSize) {
      rectMode(CENTER); 
      if (abs(posMouseGrid.x) > (windowSize/15)*focusSize) {
        posMouseGrid.x = 0;
      }
      if (abs(posMouseGrid.y) > (windowSize/15)*focusSize) {
        posMouseGrid.y = 0;
      }
      stroke(0); 
      strokeWeight(windowSize/800);
      line(((windowSize/15)*focusSize)+x+posMouseGrid.x, y+posMouseGrid.y, x+posMouseGrid.x, y+posMouseGrid.y); 
      line(x+posMouseGrid.x, ((windowSize/15)*focusSize)+y+posMouseGrid.y, x+posMouseGrid.x, y+posMouseGrid.y);
    }
  } 
  noFill();
  noStroke();
  MainPlayer.render();
  pushMatrix();
  translate(posMouse.x+(width/2), posMouse.y+(height/2));
  for (int i = 0; i < CountEnemies; i++) {
    enemies.get(i).render();
  }
  popMatrix();
}
void mouseClicked() {
  if (mouseButton == LEFT) {
    if (activeState.equals("MainGame")) {
      if (10 < bombTime) {
        bombTime = 0; 
        mouseClicked = true;
        posBomb = new PVector(0, 0); 
        trackBomb.x = (-1)*posMouse.x; 
        trackBomb.y = (-1)*posMouse.y;
        bombExist = true;
        startTriggerCircle = true; 
        aCircle = 0.2;
      } else {
        mouseClicked = true;
      }
    }
  }
}
void keyPressed() {
  if (key == 'm' || key == 'M') {
    if (muteGame == true) {
      muteGame = false;
      timeSound = 8;
    } else {
      muteGame = true;
    }
  }
  if (activeState.equals("GameOver")) {
    if (key == 'q' || key == 'Q') {
      activeState = "Quit";
    }
  }
  if (activeState.equals("MainGame")) {
    if (key == 'p' || key == 'P') {
      activeState = "Pause";
    }
  }
  if (activeState.equals("Pause")) {
    if (key == 'c' || key == 'C') {
      activeState = "MainGame";
    }
    if (key == 'q' || key == 'Q') {
      activeState = "Quit";
    }
  }
  if (activeState.equals("Instructions")) {
    if (key == 'c' || key == 'C') {
      activeState = "MainGame";
    }
  }
  if (activeState.equals("Menu")) {
    if (key == 'p' || key == 'P') {
      activeState = "Story";
    }
    if (key == 'q' || key == 'Q') {
      activeState = "Quit";
    }
  }
  if (activeState.equals("Story")) {
    if (key == 'c' || key == 'C') {
      activeState = "Instructions";
    }
  }
}
