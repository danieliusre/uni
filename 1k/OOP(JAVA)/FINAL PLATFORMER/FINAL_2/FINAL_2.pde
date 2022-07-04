//---------------- MAP EDIT VARIABLES ----------------------
final static int Y_GRID = 40, X_GRID = 12, MARGIN = 25;
final static int DIM = 39, GAP = 5, LEN = 44;
final static Square[][] boxes = new Square[X_GRID][Y_GRID];
final static String[][] result = new String[X_GRID][Y_GRID];

public Table table;
PrintWriter output;
//---------------- PLATFORMER VARIABLES ---------------------
final static float moveSpeed = 6.0;
final static float spriteSize = 50;
final static float spriteScale = 100.0/128;
final static float gravity = 0.4;
final static float jumpSpeed = moveSpeed * 2;

final static int NEUTRAL_FACING = 0;
final static int RIGHT_FACING = 1;
final static int LEFT_FACING = 2;

final static float WIDTH = spriteSize * 10;
final static float HEIGHT = spriteSize * 7;
final static float GROUND = HEIGHT - spriteSize;

final static float RIGHT_MARGIN = 0;
final static float LEFT_MARGIN = 100;
final static float VERTICAL_MARGIN = 100;
//--------------- PRE-GAME VARIABLES -----------------------
public boolean wantsToMakeMap = false;
public boolean gameHasNotStarted = true;
public boolean afterSetup = false;
public boolean wantsToStart = false;
public boolean isEnemyIn = false;
//---------------- GLOBAL VARIABLES ------------------------
Player p; //player
PImage ground, brick, crate, metal, diamond, enemySprite, player, doorimg;
float size_x, size_y;
ArrayList<Sprite> platforms;
ArrayList<Sprite> diamonds;
ArrayList<Sprite> enemies;
Sprite door;
public boolean isMidAir;
public boolean gameLost;
public boolean isGameOver;
int realLives = 3;
boolean isLevelOver;
Enemy enemy;
float view_x; 
float view_y;
int mapindex = 0;
//------------------------ SETUP -----------------------------
void setup(){
   size(1800,800);
   imageMode(CENTER);
   background(0);
   if(!wantsToStart){
//------------------ MAP EDIT SETUP ------------------------------
    for (int row=0; row!=X_GRID; ++row){
        for (int col=0; col!=Y_GRID; ++col){
            boxes[row][col] = new Square(col*LEN + MARGIN, row*LEN + MARGIN, DIM, DIM);
            result[row][col] = "0,";
      }
    }
        output = createWriter("data/map0.csv");
   }
//------------------- FOR PLATFORMER -----------------------------
  player = loadImage("data/idleRight.png");
  p = new Player(player, 0.25);
  
  p.center_x = 100;
  p.center_y = 475;
  
  p.change_x=0;
  p.change_y=0;
  
  platforms = new ArrayList<Sprite>();
  diamonds = new ArrayList<Sprite>();
  
  ground = loadImage("data/ground.png");
  brick = loadImage("data/greybrick.png");
  crate = loadImage("data/crate.png");
  metal = loadImage("data/metal.png");
  diamond = loadImage("data/green_diamond.png");
  doorimg = loadImage("data/door.png");
  enemySprite = loadImage("data/enemyRight1.png");
  createMap("map"+mapindex+".csv");
  isMidAir = false;
  gameLost = false;
  isLevelOver = false;
  view_x = 0; 
  view_y = 0;
}
void draw(){
   if(!wantsToMakeMap && gameHasNotStarted && !wantsToStart){
   fill(255, 0, 0);
   textSize(50);
   text("GAMENAME", width/2 - 150, height - 450);
   fill(255);
   textSize(32);
   text("Press 1 to play pre-made maps\n   Press x to make your own\n", width/2 -250, height/2);
   }
   else if(wantsToMakeMap && !gameHasNotStarted && !wantsToStart){
    fill(255);
    textSize(50);
    mapindex=0;
    text("Press q to start the game!", width/2 - 300, height - 100);
       for (int row=0; row!=X_GRID; ++row){
          for (int col=0; col!=Y_GRID; ++col){
              boxes[row][col].display();
   }
  }
 }
  
  else if(wantsToStart){
   background(100);
   scroll();
  
  for(Sprite s: platforms)
   s.display();
  for(Sprite d: diamonds){
   d.display();
  }
  door.display();
  p.display();
  enemy.display();
  textDisplay();
  
  removeCollision(p, platforms);
  
  if(diamonds.size() != 0)
  collidedDiamonds(p, diamonds);
  

  
  if(!gameLost && !isLevelOver){
     for(Sprite d: diamonds){
   ((Animation)d).updateAnimation();
    }
    p.updateAnimation();
    enemy.update();
    enemy.updateAnimation();
  }
  
  checkDeath();
  if(diamonds.size() == 0)
  checkDoor();
  
  if(isLevelOver){
    if(mapindex != 5){
    fill(0, 0, 100);
    textSize(32);
    text("Level "+mapindex+" complete! Press x to go to the next level", view_x + width/2 - 350, view_y + height/2);
  }
   else{
     fill(255, 0, 0);
     textSize(50);
     text("THANKS FOR PLAYING", view_x + width/2 - 250 , view_y + height/2);
     textSize(30);
     text("Press x to restart the game", view_x + width/2 - 200 , view_y + height/2 + 50);
     
   }
  }
  checkLives(); 
  }
}
void mousePressed() {
  if(wantsToMakeMap){
  for (int row=0; row!=X_GRID; ++row){
    for (int col=0; col!=Y_GRID; ++col){
    if ( boxes[row][col].click() ) {
      println( col + "," + row + " : " + boxes[row][col].toggle() );
      redraw();
      if(result[row][col] == "0,")
      result[row][col] = "1,";
      else if(result[row][col] == "1,")
      result[row][col] = "2,";
      else if(result[row][col] == "2,")
      result[row][col] = "3,";
      else 
      result[row][col] = "0,";
      return;
    }
    }
  }
}
}
 
final class Square {
  final short x, y, w, h;
  int state = 4;
  static final int state1 = 1;
  static final int state2 = 2;
  static final int state3 = 3;
  static final int state0 = 4;
  /*
  boolean state;
  boolean state0;
  boolean state1;
  boolean state2;
  boolean state3;
  */
 
  final static color COLOR_ON1 = #332929, COLOR_ON2 = #45454f, COLOR_ON3 = #705004, COLOR_OFF = #407090;
 
  Square(int xx, int yy, int ww, int hh) {
    x = (short) xx;
    y = (short) yy;
    w = (short) ww;
    h = (short) hh;
  }
 
  int toggle() {
    if(state == state0)
    state = state1;
    else if(state == state1)
    state = state2;
    else if(state == state2)
    state = state3;
    else if(state == state3)
    state = state0;
    return state;
  }
 
  boolean click() {
    return mouseX > x & mouseX < x+w & mouseY > y & mouseY < y+h;
  }
 
  void display() {
    if(state==state0)
    fill(COLOR_OFF);
    else if(state==state1)
    fill(COLOR_ON1);
    else if(state==state2)
    fill(COLOR_ON2);
    else if(state==state3)
    fill(COLOR_ON3); 
    rect(x, y, w, h);
  }
}
  public void makeFile(){
    for (int row=0; row!=X_GRID; ++row){
      
          for (int col=0; col!=Y_GRID; ++col){
            
            if(col == Y_GRID - 1){
                if(result[row][col] == "0,")
                output.print("0");
                else
                output.print("4");
            }
            else
            output.print(result[row][col]);
            
            if(col == Y_GRID - 4 && row == X_GRID - 2)
            output.print("7,");
            if(col == Y_GRID - 15 && row == X_GRID - 2)
            output.print("6,");
    }
    if(row != X_GRID - 1 )
    output.println();
  }
  output.close();
  return;
  }
  void textDisplay(){
  fill(0, 0, 100);
  textSize(26);
  text("Lives: " + realLives, view_x + 50, view_y + 75);
  fill(255, 0, 0);
  textSize(26);
  text("Level: " + mapindex + "/5", view_x + width - 150, view_y+50);
}
//--------------------------------------- MOVEMENT ----------------------------
void keyPressed(){
   if(key == 'q' && wantsToMakeMap){
     makeFile();
     mapindex = 0;
     wantsToStart = true;
     setup();
  }
  else if(key == '1' && gameHasNotStarted){
     wantsToMakeMap = false;
     mapindex = 1;
     wantsToStart = true;
     gameHasNotStarted = false;
     setup();
  }
  else if(key == 'x' && gameHasNotStarted){
     background(100);
     wantsToMakeMap = true;
     gameHasNotStarted = false;
  }
  else if(keyCode == RIGHT){
    if(!isLevelOver && !gameLost)
     p.change_x = moveSpeed; 
  }
  else if(keyCode == LEFT){
    if(!isLevelOver && !gameLost)
     p.change_x = -moveSpeed; 
  }
  else if(key == ' ' && isOnPlatform(p, platforms)){
     isMidAir = true;
    if(!isLevelOver && !gameLost)
     p.change_y = -jumpSpeed;
  }
  else if(key == ' ' && isMidAir){
     p.change_y = -jumpSpeed;
     isMidAir = false;
  } 
  else if(key == 'r'){
     p.center_x = 150;
     p.center_y = 500;
  }
  else if(mapindex == 5 && key == 'x'){
     freshStart();
  }   
  else if(isLevelOver && key == 'x'){
     checkNextLevel();
  }    
  else if(gameLost && key == 'x'){
     freshStart();
  }    
}
void keyReleased(){ 
  if(keyCode == RIGHT){
     p.change_x = 0; 
  }
  else if(keyCode == LEFT){
     p.change_x = 0; 
  }
}
//------------------------------------------- MAP -------------------
void createMap(String filename){
  String[] lines = loadStrings(filename);
  for(int row = 0; row < lines.length; row++){
    String[] values = split(lines[row], ",");
    for(int collumn = 0; collumn < values.length; collumn++){
      if(values[collumn].equals("1")){
        Sprite s = new Sprite(ground, spriteScale);
        s.center_x = spriteSize/2 + collumn * spriteSize;
        s.center_y = spriteSize/2 + row * spriteSize;
        platforms.add(s);
      }
      else if(values[collumn].equals("2")){
        Sprite s = new Sprite(brick, spriteScale);
        s.center_x = spriteSize/2 + collumn * spriteSize;
        s.center_y = spriteSize/2 + row * spriteSize;
        platforms.add(s);
      }
      else if(values[collumn].equals("3")){
        Sprite s = new Sprite(crate, spriteScale);
        s.center_x = spriteSize/2 + collumn * spriteSize;
        s.center_y = spriteSize/2 + row * spriteSize;
        platforms.add(s);
      }
      else if(values[collumn].equals("4")){
        Sprite s = new Sprite(metal, spriteScale);
        s.center_x = spriteSize/2 + collumn * spriteSize;
        s.center_y = spriteSize/2 + row * spriteSize;
        platforms.add(s);
      }
      else if(values[collumn].equals("5")){
        Diamond d = new Diamond(diamond, spriteScale);
        d.center_x = spriteSize/2 + collumn * spriteSize;
        d.center_y = spriteSize/2 + row * spriteSize;
        diamonds.add(d);
      }
      else if(values[collumn].equals("6")){
        float leftboundary = collumn * spriteSize;
        float rightboundary = leftboundary + 5 * spriteSize;
        enemy = new Enemy(enemySprite, 0.8, leftboundary, rightboundary);
        enemy.center_x = spriteSize/2 + collumn * spriteSize;
        enemy.center_y = spriteSize/2 + row * spriteSize;
        isEnemyIn = true;
      }
      else if(values[collumn].equals("7")){
        door = new Sprite(doorimg, 1.5);
        door.center_x = spriteSize/2 + collumn * spriteSize;
        door.center_y = spriteSize/2 + row * spriteSize - 20;
      }
    }
  }
}
//-------------------------------------- IS COLLISION == true? -----------------
  public boolean checkCollision(Sprite s1, Sprite s2){
    boolean noOverlapX = s1.getRight() <= s2.getLeft() || s1.getLeft() >= s2.getRight();
    boolean noOverlapY = s1.getBottom() <= s2.getTop() || s1.getTop() >= s2.getBottom();
    if(noOverlapX || noOverlapY){
     return false; 
    }
    else{
     return true; 
    }
  }
  public ArrayList<Sprite> checkCollisionList(Sprite s, ArrayList<Sprite> list){
   ArrayList<Sprite> collision_list = new ArrayList<Sprite>();
   for(Sprite p: list){
    if(checkCollision(s, p))
     collision_list.add(p);
    }
    return collision_list;
   }
//-------------------------------------- IF COLLISION == true ------------------
public void removeCollision(Sprite p, ArrayList<Sprite> list){
  //gravity
  p.change_y += gravity;
  p.center_x += p.change_x;
  
    //collision in X?
  ArrayList<Sprite> list_of_collisions = checkCollisionList(p, platforms);
    if(list_of_collisions.size() != 0 ){
  Sprite collided = list_of_collisions.get(0);
  if(p.change_x < 0){
   p.setLeft(collided.getRight());
  }
  else if(p.change_x > 0){
   p.setRight(collided.getLeft());
  }
   p.change_x=0;
  }
  
  //collision in Y?
  p.center_y += p.change_y;
  list_of_collisions = checkCollisionList(p, platforms);
  //println(list_of_collisions.size());
  if(list_of_collisions.size() != 0 ){
    Sprite collided = list_of_collisions.get(0);
   if(p.change_y > 0){ //if falling down
   p.setBottom(collided.getTop());
  }
  else if(p.change_y < 0){
   p.setTop(collided.getBottom());
  }
   p.change_y = 0;
  }
}
//---------------- DIAMOND -------------------
public void collidedDiamonds(Player p, ArrayList<Sprite> list){
  ArrayList<Sprite> list_of_collisions_diamond = checkCollisionList(p, diamonds);
  if(list_of_collisions_diamond.size() != 0){
   Sprite collided = list_of_collisions_diamond.get(0); 
   diamonds.remove(collided);
  }
}
 //-------------------------------- IF ON PLATFORM == true ----------------------------
  boolean isOnPlatform(Sprite p, ArrayList<Sprite> platforms){
    p.center_y += 10;
    ArrayList<Sprite> list_of_collisions = checkCollisionList(p, platforms);
    p.center_y -=10;
    if(list_of_collisions.size() != 0 ){
      return true;
  }
    else
      return false;
}
//----------------------------------- SCROLL -----------------------------------
void scroll(){
 float screen_rightboundary = view_x + width - RIGHT_MARGIN;
 if(p.getRight() > screen_rightboundary){
  view_x += p.getRight() - screen_rightboundary; 
 }
 float screen_leftboundary = view_x + LEFT_MARGIN;
 if(p.getRight() < screen_rightboundary){
  view_x -= screen_leftboundary - p.getLeft(); 
 }
 float screen_bottomboundary = view_y + height - VERTICAL_MARGIN;
 if(p.getBottom() > screen_bottomboundary){
  view_y += p.getBottom() - screen_bottomboundary; 
 }
 float screen_topboundary = view_y + VERTICAL_MARGIN;
 if(p.getTop() < screen_topboundary){
  view_y -= screen_topboundary - p.getTop(); 
 }
 translate(-view_x, -view_y);
}
void checkDeath(){
 boolean collideEnemy = checkCollision(p, enemy);
 boolean fallOff = p.getBottom() > 1000;
 if(collideEnemy == true || fallOff == true){
   realLives--;
   p.center_x = 150;
   p.center_y = 475;
 }
}
void checkDoor(){
 if(checkCollision(p, door)){
  isLevelOver = true; 
 }
}
void checkNextLevel(){
     mapindex++;
     if(mapindex<5)
     isLevelOver = false;
     setup();
}
void checkLives(){
   if(realLives == 0){
     fill(0, 0, 100);
     textSize(50);
     gameLost = true;
     text("YOU LOST!\n", view_x + width/2 - 150 , view_y + height/2);
     fill(0, 0, 100);
     textSize(30);
     text("Press x to restart the game", view_x + width/2 - 200 , view_y + height/2 + 50);
   }
}
void freshStart(){
    mapindex = 1;
    realLives = 3;
    setup();
}
