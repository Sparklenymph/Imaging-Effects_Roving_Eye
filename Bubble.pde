class Bubble{
  
  float x;
  float y;
  
  Bubble(){
    x = width/2;
    y = height;
  }
  void ascend(){
  y --;
  }
  
  void display(){
    stroke(0);
    fill(127);
    ellipse(x,y,64,64);
    imageMode(CENTER);
   // eye.width;
    image(eye,x,y);
  }
  
  //void top ()
  //{
  //  if (y < diameter/2){
  //    y = diameter/2;
  //  }
  //}
}