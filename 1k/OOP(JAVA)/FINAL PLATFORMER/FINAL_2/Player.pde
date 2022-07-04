public class Player extends Animation{
  boolean onPlatform, inPlace;
  PImage[] currentImages;
  PImage[] jumpLeft;
  PImage[] jumpRight;
  PImage[] standLeft;
  PImage[] standRight;
  int lives;
  public Player(PImage img, float scale){
    super(img, scale);
    direction = RIGHT_FACING;
    onPlatform = true;
    inPlace = true;
    standLeft = new PImage[1];
    standLeft[0] = loadImage("data/idleLeft.png");
    standRight = new PImage[1];
    standRight[0] = loadImage("data/idleRight.png");
    jumpRight = new PImage[1];
    jumpRight[0] = loadImage("data/jumpRight.png");
    jumpLeft = new PImage[1];
    jumpLeft[0] = loadImage("data/jumpLeft.png");
    moveRight = new PImage[8];
    moveRight[0] = loadImage("data/runRight.png");
    moveRight[1] = loadImage("data/runRight1.png");
    moveRight[2] = loadImage("data/runRight2.png");
    moveRight[3] = loadImage("data/runRight3.png");
    moveRight[4] = loadImage("data/runRight4.png");
    moveRight[5] = loadImage("data/runRight5.png");
    moveRight[6] = loadImage("data/runRight6.png");
    moveRight[7] = loadImage("data/runRight7.png");
    moveLeft = new PImage[8];
    moveLeft[0] = loadImage("data/runLeft.png");
    moveLeft[1] = loadImage("data/runLeft1.png");
    moveLeft[2] = loadImage("data/runLeft2.png");
    moveLeft[3] = loadImage("data/runLeft3.png");
    moveLeft[4] = loadImage("data/runLeft4.png");
    moveLeft[5] = loadImage("data/runLeft5.png");
    moveLeft[6] = loadImage("data/runLeft6.png");
    moveLeft[7] = loadImage("data/runLeft7.png");
    currentImages = standRight;
    lives = realLives;
  }
  
  @Override
  public void updateAnimation(){
    onPlatform = isOnPlatform(this, platforms);
    inPlace = change_x == 0 && change_y == 0;
    super.updateAnimation();
    }
    
  @Override
  public void selectDirection(){
    if(change_x > 0){
    direction = RIGHT_FACING;
    }
    else if(change_x < 0){
    direction = LEFT_FACING;
    }
  }
  @Override
  public void selectCurrentImages(){
    if(direction == RIGHT_FACING){
      if(inPlace){
        currentImages = standRight;
      }
    else if(!onPlatform){
      currentImages = jumpRight;
    }
    else{
      currentImages = moveRight;
    }
    }
    else if(direction == LEFT_FACING){
      if(inPlace){
        currentImages = standLeft;
      }
    else if(!onPlatform){
      currentImages = jumpLeft;
    }
    else{
      currentImages = moveLeft;
    }
  }
}
  @Override
  public void selectNextImage(){
    i++;
    if(i >= currentImages.length){
      i=0;
    }
    image = currentImages[i];
  }
}
