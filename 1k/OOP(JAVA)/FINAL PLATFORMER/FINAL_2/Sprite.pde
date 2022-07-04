public class Sprite{
  PImage image;
  float center_x, center_y;
  float change_x, change_y;
  float w, h;
  float player_rightSide, player_leftSide, player_top, player_bottom;
  
  public Sprite(String filename, float scale, float x, float y){
    image = loadImage(filename);
    w = image.width * scale;
    h = image.height * scale;
    center_x=x;
    center_y=y;
    change_x=0;
    change_y=0;
  }
  public Sprite(String filename, float scale){
    this(filename, scale, 0, 0);
  }
  public Sprite(PImage img, float scale){
   image = img;
   w = image.width * scale;
   h = image.height * scale;
   center_x = 0;
   center_y = 0;
   change_x = 0;
   change_y = 0;
  }
  public void display(){
    image(image, center_x, center_y, w, h);
  }
  public void update1(){
   center_x+=change_x;
   center_y+=change_y;
  }
//sides:
  public float getRight(){
    return center_x + w/2;
  }
  public void setRight(float player_rightSide){
      center_x = player_rightSide - w/2;
    }
  public float getLeft(){
    return center_x - w/2;
  }
  public void setLeft(float player_leftSide){
     center_x = player_leftSide + w/2;
    }
  public float getTop(){
        return center_y - h/2;
  }
  public void setTop(float player_top){
     center_y = player_top + h/2;
    }
  public float getBottom(){
        return center_y + h/2;
  }
  public void setBottom(float player_bottom){
      center_y = player_bottom - h/2;
    }
    
}
