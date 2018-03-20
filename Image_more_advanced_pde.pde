PImage eye;

Bubble b;

void setup(){
  size(600,600);
  eye = loadImage("Eye_solo.png");
  b = new Bubble();
}

void draw(){
  background(255);
  imageMode(CENTER);
  image(eye,300,300,600,600);
  b.ascend();
  b.display();
  //b.top();
}