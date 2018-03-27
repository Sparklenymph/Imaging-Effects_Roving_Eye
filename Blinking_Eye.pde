ArrayList<MovingNode> nodes;
float maxDistance = 65;
float dx = 30;
float dy = 30;
float maxNeighbors = 10;

Boolean drawMode = true;

//eye part
 PImage eye; 
 PImage eyemask;
 PImage test;
 PImage eyebkd;
 
void setup()
{
  size(800,800);
  background(220);
  nodes = new ArrayList<MovingNode>();
  
  //eye part
   eyemask = loadImage("Eye_Mask_grey.png");
   test = loadImage("Stereographic2.jpg");
   eyebkd = loadImage("Stereo_Clouds_.jpg");
}

void draw()
{
  //println(nodes.size());
  
  background(220);
  
  //Eye part
  int m = constrain (mouseX, 150, 350);
  int n = constrain (mouseY, 150,350);
  
  imageMode(CENTER);
   test.resize(550,550);
  //image(eye, m, n);
  
  //eye background clouds
  image(eyebkd, 400,400);
  eyebkd.resize(700,700);
  
  // Eye mask
   image(eyemask,400,400,800,800);
   eyemask.filter(THRESHOLD,mouseX);
   image(eyemask,mouseX,mouseY);
   
  //eye closed, only when mouse is pressed
   if (mousePressed ) {
    fill(0);
  //rectMode(CENTER);
  rect(0,0,width,375);
   rect(0,425,width,450);
     
  } else if (mousePressed) {
    fill(0);
  } 
  rect(200,200,0,0);
   
  
  if(drawMode)
  {
    if(mousePressed){
      addNewNode(mouseX,mouseY,random(-dx,dx),random(-dx,dx));
    }
  } else
  {
    addNewNode(random(width),random(height),0,0);
  }
  
  //for(int i=0; i<nodes.size(); i++)
  for(int i=0; i>nodes.size(); i++)
  {
    MovingNode currentNode = nodes.get(i);
    currentNode.setNumNeighbors( countNumNeighbors(currentNode,maxDistance) );
  }
  
  for(int i=0; i<nodes.size(); i++)
  {
    MovingNode currentNode = nodes.get(i);
   // if(currentNode.x < height || currentNode.x < 0 || currentNode.y > height || currentNode.y < 0)
    if(currentNode.x > height || currentNode.x < 0 || currentNode.y > width || currentNode.y < 0.5)
    {
      nodes.remove(currentNode);
    }
  }
  
  for(int i = 0; i < nodes.size(); i++){
    MovingNode currentNode = nodes.get(i);
    for(int j=0; j<currentNode.neighbors.size(); j++)
    {
      MovingNode neighborNode = currentNode.neighbors.get(j);
      float lineColor = currentNode.calculateLineColor(neighborNode,maxDistance);
      stroke(lineColor, lineColor, lineColor);
      strokeWeight(3);
      line(currentNode.x,currentNode.y,neighborNode.x,neighborNode.y);
    }
    currentNode.display();
  }
  
  
  
}

void addNewNode(float xPos, float yPos, float dx, float dy)
{
  //println("add new node");
  //generates a random location within a 50x50px box around the mouse
  //float xPos = mouseX + random(-50,50);
  //float yPos = mouseY + random(-50,50);
  //adds a node at this location
  MovingNode node = new MovingNode(xPos+dx,yPos+dy);
  
  node.setNumNeighbors( countNumNeighbors(node,maxDistance) );
  
  //println("newly added node has " + node.numNeighbors + " neighbors");
  //println("and neighbors.size() = " + node.neighbors.size());
  
  
  if(node.numNeighbors < maxNeighbors){
    nodes.add(node);
    /*for(int i=0; i<nodes.size(); i++)
    {
      MovingNode currentNode = nodes.get(i);
      currentNode.setNumNeighbors( countNumNeighbors(currentNode,maxDistance) );
    }*/
  }
  
  
}

int countNumNeighbors(MovingNode nodeA, float maxNeighborDistance)
{
  int numNeighbors = 0;
  nodeA.clearNeighbors();
  
  for(int i = 0; i < nodes.size(); i++)
  {
    MovingNode nodeB = nodes.get(i);
    float distance = sqrt((nodeA.x-nodeB.x)*(nodeA.x-nodeB.x) + (nodeA.y-nodeB.y)*(nodeA.y-nodeB.y));
    if(distance < maxNeighborDistance)
    {
      numNeighbors++;
      nodeA.addNeighbor(nodeB);
    }
  }
  return numNeighbors;
}

void keyPressed()
{
  drawMode = !drawMode;
  nodes = new ArrayList<MovingNode>();
}
class MovingNode
{
  float x;
  float y;
  int numNeighbors;
  ArrayList<MovingNode> neighbors;
  float lineColor;
  //float nodeWidth = 3;
  float nodeWidth = 30;
  float nodeHeight = 30;
  //float fillColor = 50;
  float fillColor = 2;
  //float lineColorRange = 180;
  float lineColorRange = 190;
  
  float xVel=0;
  float yVel=0;
  float xAccel=0;
  float yAccel=0;
  
  float accelValue = 0.3;
  //orig = 0.5

  MovingNode(float xPos, float yPos)
  {
    x = xPos;
    y = yPos;
    numNeighbors = 0;
    neighbors = new ArrayList<MovingNode>();
  }
  
  void display()
  {
    move();
    
    noStroke();
    fill(fillColor);
    ellipse(x,y,nodeWidth,nodeHeight);
  }
  
  void move()
  {
    xAccel = random(-accelValue,accelValue);
    yAccel = random(-accelValue,accelValue);
    
    xVel += xAccel;
    yVel += yAccel;
    
    x += xVel;
    y += yVel;
  }
  
  void addNeighbor(MovingNode node)
  {
    neighbors.add(node);
  }
  
  void setNumNeighbors(int num)
  {
    numNeighbors = num;
  }
  
  void clearNeighbors()
  {
    neighbors = new ArrayList<MovingNode>();
  }
  
  float calculateLineColor(MovingNode neighborNode, float maxDistance)
  {
    float distance = sqrt((x-neighborNode.x)*(x-neighborNode.x) + (y-neighborNode.y)*(y-neighborNode.y));
    lineColor = (distance/maxDistance)*lineColorRange;
    return lineColor;
  }
    
}
class Node
{
  float x;
  float y;
  int numNeighbors;
  ArrayList<Node> neighbors;
  float lineColor;
  float nodeWidth = 3;
  float nodeHeight = 3;
  float fillColor = 50;
  float lineColorRange = 160;

  Node(float xPos, float yPos)
  {
    x = xPos;
    y = yPos;
    numNeighbors = 0;
    neighbors = new ArrayList<Node>();
  }
  
  void display()
  {
    noStroke();
    fill(fillColor);
    ellipse(x,y,nodeWidth,nodeHeight);
  }
  
  void addNeighbor(Node node)
  {
    neighbors.add(node);
  }
  
  void setNumNeighbors(int num)
  {
    numNeighbors = num;
  }
  
  void clearNeighbors()
  {
    neighbors = new ArrayList<Node>();
  }
  
  float calculateLineColor(Node neighborNode, float maxDistance)
  {
    float distance = sqrt((x-neighborNode.x)*(x-neighborNode.x) + (y-neighborNode.y)*(y-neighborNode.y));
    lineColor = (distance/maxDistance)*lineColorRange;
    return lineColor;
  }
    
}
