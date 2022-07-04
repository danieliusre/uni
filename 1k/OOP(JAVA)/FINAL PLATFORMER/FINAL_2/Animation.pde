public class Animation extends Sprite{
  PImage[] currentImages;
  PImage[] standIdle;
  PImage[] moveRight;
  PImage[] moveLeft;
  int direction;
  int frame;
  int i; //index for arrays
  public Animation(PImage img, float scale){
    super(img, scale);
    direction = NEUTRAL_FACING;
    i=0;
    frame = 0;
  }
  public void updateAnimation(){
    frame++;
    if(frame % 5 == 0){
    selectDirection();
    selectCurrentImages();
    selectNextImage();
    }
  }
  public void selectDirection(){
    if(change_x > 0){
    direction = RIGHT_FACING;
    }
    else if(change_x < 0){
    direction = LEFT_FACING;
    }
    else
    direction = NEUTRAL_FACING;
  }
  public void selectCurrentImages(){
    if(direction == RIGHT_FACING){
     currentImages = moveRight;
    }
    else if(direction == LEFT_FACING){
     currentImages = moveLeft;
    }
    else
     currentImages = standIdle;
    }
  public void selectNextImage(){
    i++;
    if(i >= currentImages.length){
      i=0;
    }
    image = currentImages[i];
  }
}
