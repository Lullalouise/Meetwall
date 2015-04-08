/* OpenProcessing Tweak of *@*http://www.openprocessing.org/sketch/34481*@* */
/* !do not delete the line above, required for linking your tweak if you upload again */
/*
  Tetris
 Author: Karl Hiner
 Controls:
 LEFT/RIGHT/DOWN to move
 UP - flip
 SPACE - hard drop (drop immediately)
 */



final int WHITE = color(255);
final int CYAN = color(0, 255, 255);
final int ORANGE = color(255, 165, 0);
final int YELLOW = color(255, 255, 0);
final int PURPLE = color(160, 32, 240);
final int BLUE = color(0, 0, 255);
final int RED = color(255, 0, 0);
final int GREEN = color(0, 255, 0);


Grid board, preview;
Tetromino curr;
Shape next;
Shape[] shapes = new Shape[7];
int timer = 1;
int currTime = 0;
int score = 0;
int lines = 0;
int level = 1;
final int SPEED_DECREASE = 2;
boolean game_over = false;

void setup() {
  size(160, 380);
  textSize(25);


  shapes[0] = new Shape(4, new int[] {
    8, 9, 10, 11
  }
  , WHITE);  // I
  shapes[1] = new Shape(3, new int[] {
    0, 3, 4, 5
  }
  , WHITE);  // J
  shapes[2] = new Shape(3, new int[] {
    2, 3, 4, 5
  }
  , WHITE);  // L
  shapes[3] = new Shape(2, new int[] {
    0, 1, 2, 3
  }
  , WHITE);  // O
  shapes[4] = new Shape(4, new int[] {
    5, 6, 8, 9
  }
  , WHITE);  // S
  shapes[5] = new Shape(3, new int[] {
    1, 3, 4, 5,
  }
  , WHITE);  // T
  shapes[6] = new Shape(4, new int[] {
    4, 5, 9, 10
  }
  , WHITE);  // Z
  board = new Grid(0, 0, 160, 380, 19, 8);
  // preview = new Grid(355, 20, 116, 58, 2, 4);
  next = shapes[(int)random(7)];
  loadNext();
}

void draw() {
  background(0);
  frameRate(2);

  if (game_over) {
    text("GAME OVER\nSCORE: " + score, width/2 - 70, height/2 - 50);
    // controlP5.draw(); // show the play again button
    return;
  }
  currTime++;
  if (currTime >= timer && board.animateCount == -1)
    curr.stepDown();
  // preview.draw();
  board.draw();
  if (curr != null)
    curr.draw();
  // next.preview();
  fill(255);
  //  text("LEVEL\n" + level, width - 150, 120);
  //  text("LINES\n" + lines, width - 150, 200);
  //  text("SCORE\n" + score, width - 150, 280);
  saveFrame("a-######.png");
}

void loadNext() {
  curr = new Tetromino(next);
  next = shapes[(int)random(7)];
  currTime = 0;
}

void keyPressed() {
  if (curr == null || game_over)
    return;
  switch(keyCode) {
  case LEFT : 
    curr.left(); 
    break;
  case RIGHT : 
    curr.right(); 
    break;
  case UP : 
    curr.rotate(); 
    break;
  case DOWN : 
    curr.down(); 
    break;
  case ' ' : 
    curr.hardDown(); 
    break;
  }
}

void play(int value) {
  board.clear();
  loadNext();
}

