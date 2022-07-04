public class Diamond extends Animation{
  public Diamond(PImage img, float scale){
    super(img, scale);
    standIdle = new PImage[4];
    standIdle[0] = loadImage("blue_diamond.png");
    standIdle[1] = loadImage("green_diamond.png");
    standIdle[2] = loadImage("red_diamond.png");
    standIdle[3] = loadImage("yellow_diamond.png");
    currentImages = standIdle;
  }
  @Override
  public void updateAnimation(){
    frame++;
    if(frame % 40 == 0){
    selectDirection();
    selectCurrentImages();
    selectNextImage();
    }
  }
}
