public class Enemy extends Animation{
  float leftBoundary, rightBoundary;
  public Enemy(PImage img, float scale, float leftboundary, float rightboundary){
    super(img, scale);
    moveRight = new PImage[2];
    moveRight[0] = loadImage("data/enemyRight1.png"); 
    moveRight[1] = loadImage("data/enemyRight2.png"); 
    moveLeft = new PImage[2];
    moveLeft[0] = loadImage("data/enemyLeft1.png"); 
    moveLeft[1] = loadImage("data/enemyLeft2.png"); 
    currentImages = moveRight;
    direction = RIGHT_FACING;
    leftBoundary = leftboundary;
    rightBoundary = rightboundary;
    change_x = 2;
  }
  void update(){
    super.update1();
    if(getLeft() <= leftBoundary){
     setLeft(leftBoundary);
     change_x = change_x * (-1);
    }
     else if(getRight() >= rightBoundary){
     setRight(rightBoundary);
     change_x = change_x * (-1);
    }
  }
  @Override
  public void updateAnimation(){
    frame++;
    if(frame % 30 == 0){
    selectDirection();
    selectCurrentImages();
    selectNextImage();
    }
  }
}
