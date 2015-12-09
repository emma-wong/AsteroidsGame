//your variable declarations here
SpaceShip ship;
Stars[] star;
boolean leftPressed = false;
boolean rightPressed = false;
boolean upPressed = false;
boolean downPressed = false;
boolean spacePressed = false;
boolean gameOver = false;
ArrayList <Bullet> bullet;
ArrayList <Asteroid> asteroid;
double dist;
double far;
int numBullets;
int gameScore;

public void setup() 
{
  //your code here
  numBullets = 0;
  gameScore = 0;
  size(500,500);
  background(0);
  ship = new SpaceShip();
  star = new Stars[100];
  bullet = new ArrayList <Bullet>();  
  for (int i = 0; i < star.length; i++) {
    star[i] = new Stars();
  }
  asteroid = new ArrayList <Asteroid>();
  for (int k = 0; k < 10; k++) {
    asteroid.add(new Asteroid());
  }
}

public void draw() 
{
  //your code here
  background(0);
  fill(255);
  textSize(14);
  text("Score: " + gameScore, 410, 25);
  for(int m = 0; m < asteroid.size(); m++) {
  asteroid.get(m).move();
  asteroid.get(m).show();
  dist = dist(asteroid.get(m).getX(), asteroid.get(m).getY(), ship.getX(), ship.getY());
 if(dist < 27)
 {
 asteroid.remove(m);
 asteroid.add(new Asteroid());
 gameOver = true;
 }
  }
  for(int i = 0; i < star.length; i++)
  {
    star[i].show();
  }
  ship.move();
  ship.show();
  for(int j = 0; j < bullet.size(); j++)
  {
    bullet.get(j).move();
    bullet.get(j).show();
  }

for(int m = 0; m < asteroid.size(); m++)
  {
    for(int n = 0; n < bullet.size(); n++)
    {
      far = dist(asteroid.get(m).getX(), asteroid.get(m).getY(), bullet.get(n).getX(), bullet.get(n).getY());
      if(far < 19)
        {
          asteroid.remove(m);
          bullet.remove(n);
          asteroid.add(new Asteroid());
          gameScore++;
        }
    }
  }

  if (leftPressed == true) {
    ship.rotate(-5);
  }
  if (rightPressed == true) {
    ship.rotate(5);
  }
  if (upPressed == true) {
    ship.accelerate(0.1);
  }
  if(downPressed == true) {
    ship.accelerate(-0.1);
  }
  if (spacePressed == true) {
    bullet.add(new Bullet(ship)); 
    numBullets++;  
  }
  if (gameOver == true) {
   fill(0, 0, 255, 50); 
   rect(0, 0, 500, 500);
   fill(255);
   textSize(35);
   text("Game Over!", 160, 150);
   textSize(25);
   text("Press 'r' to restart.", 145, 200);
    for(int i = 0; i < bullet.size(); i++) {
    bullet.remove(i); }
   ship.setDirectionX(0);
   ship.setDirectionY(0);
  }
  if (gameOver == false) {

  }
}

public void keyPressed()
{
  if (keyCode == UP) {
    upPressed = true;
  }
  if (keyCode == DOWN) {
    downPressed = true;
  }
  if (keyCode == LEFT) {
    leftPressed = true;
  }
  if (keyCode == RIGHT) {
    rightPressed = true;
  }
  if (key == 'b') {
    ship.setDirectionX(0);
    ship.setDirectionY(0);
    ship.setPointDirection((int)(Math.random()*360));
    ship.setX((int)(Math.random()*500));
    ship.setY((int)(Math.random()*500)); 
  } 
  if (key == ' ') {
    spacePressed = true;
  }
  if (key == 'g') {
    gameOver = true;
  }
  if (key == 'r') {
    gameScore = 0;
    gameOver = false; 
    for(int i = 0; i < bullet.size(); i++) {
    bullet.remove(i);
  }
    ship.setX(250);
    ship.setY(250);
  }
}

public void keyReleased()
{
  if(keyCode == UP) {
    upPressed = false;
  }
  if(keyCode == DOWN) {
    downPressed = false;
  }
  if(keyCode == LEFT) {
    leftPressed = false;
  }
  if(keyCode == RIGHT) {
    rightPressed = false;
  }
  if (key == ' ') {
    spacePressed = false;
  }
}

class SpaceShip extends Floater
{   
  //your code here
  public SpaceShip()
  {
    corners = 3;
    int [] xC = {-12, -12, 12};
    int [] yC = {8, -8, 0};
    xCorners = xC;
    yCorners = yC;
    myColor = color(132, 138, 140);
    stroke(0, 255, 0);
    setX(250);
    setY(250);
    setDirectionX(0);
    setDirectionY(0);
    setPointDirection(0);
  } 
  public void setX(int x) {myCenterX = x;}
  public int getX() {return (int)myCenterX;}
  public void setY(int y) {myCenterY = y;}
  public int getY() {return (int)myCenterY;}
  public void setDirectionX(double x) {myDirectionX = x;}
  public double getDirectionX() {return myDirectionX;}
  public void setDirectionY(double y) {myDirectionY = y;}
  public double getDirectionY() {return myDirectionY;}
  public void setPointDirection(int degrees) {myPointDirection = degrees;}
  public double getPointDirection() {return myPointDirection;} 
}

class Bullet extends Floater
{
private int bulletColor;
private double dRadians;
public Bullet(SpaceShip ship) {
    myCenterX = ship.getX();
    myCenterY = ship.getY();
    myPointDirection = ship.getPointDirection();
    dRadians = myPointDirection*(Math.PI/180);
    myDirectionX = 5*Math.cos(dRadians) + ship.getDirectionX();
    myDirectionY = 5*Math.sin(dRadians) + ship.getDirectionY();
    myColor = color(0,255,255);
}
  public void setX(int x) {myCenterX = x;}
  public int getX() {return (int)myCenterX;}
  public void setY(int y) {myCenterY = y;}
  public int getY() {return (int)myCenterY;}
  public void setDirectionX(double x) {myDirectionX = x;}
  public double getDirectionX() {return myDirectionX;}
  public void setDirectionY(double y) {myDirectionY = y;}
  public double getDirectionY() {return myDirectionY;}
  public void setPointDirection(int degrees) {myPointDirection = degrees;}
  public double getPointDirection() {return myPointDirection;}
  public void show()
  {
    noStroke();
    fill(255, 0, 0, 100);
    ellipse((int)myCenterX, (int)myCenterY, 5, 5);
  }
}

class Asteroid extends Floater
{
  private int rotationSpeed;
  public Asteroid() {
    corners = 6;
    int [] xC = {28, 24, -4, -26, -24, 0};
    int [] yC = {0, 22, 28, 22, -12, -18};
    xCorners = xC;
    yCorners = yC;
    myColor = 200;
    myCenterX = (int)(Math.random()*500);
    myCenterY = (int)(Math.random()*500);
    myDirectionX = (int)(Math.random()*4-2);
    myDirectionY = (int)(Math.random()*4-2);
    myPointDirection = (int)(Math.random()*361);
    if(Math.random()<.5)
    {
      rotationSpeed = (int)(Math.random()*2-3);
    }
    else
    {
      rotationSpeed = (int)(Math.random()*2+1);
    }
  }
  public void setX(int x) {myCenterX = x;}
  public int getX() {return (int)myCenterX;}
  public void setY(int y) {myCenterY = y;}
  public int getY() {return (int)myCenterY;}
  public void setDirectionX(double x) {myDirectionX = x;}
  public double getDirectionX() {return myDirectionX;}
  public void setDirectionY(double y) {myDirectionY = y;}
  public double getDirectionY() {return myDirectionY;}
  public void setPointDirection(int degrees) {myPointDirection = degrees;}
  public double getPointDirection() {return myPointDirection;}
  public void move() {
    rotate(rotationSpeed);
    myCenterX += myDirectionX;    
    myCenterY += myDirectionY;       
    if(myCenterX >width)
    {     
      myCenterX = 0;    
    }    
    else if (myCenterX<0)
    {     
      myCenterX = width;    
    }    
    if(myCenterY >height)
    {    
      myCenterY = 0;    
    }   
    else if (myCenterY < 0)
    {     
      myCenterY = height;    
    }
  }
}

abstract class Floater //Do NOT modify the Floater class! Make changes in the SpaceShip class 
{   
  protected int corners;  //the number of corners, a triangular floater has 3   
  protected int[] xCorners;   
  protected int[] yCorners;   
  protected int myColor;  
  protected double myCenterX, myCenterY; //holds center coordinates   
  protected double myDirectionX, myDirectionY; //holds x and y coordinates of the vector for direction of travel   
  protected double myPointDirection; //holds current direction the ship is pointing in degrees    
  abstract public void setX(int x);  
  abstract public int getX();   
  abstract public void setY(int y);   
  abstract public int getY();   
  abstract public void setDirectionX(double x);   
  abstract public double getDirectionX();   
  abstract public void setDirectionY(double y);   
  abstract public double getDirectionY();   
  abstract public void setPointDirection(int degrees);   
  abstract public double getPointDirection(); 

  //Accelerates the floater in the direction it is pointing (myPointDirection)   
  public void accelerate (double dAmount)   
  {          
    //convert the current direction the floater is pointing to radians    
    double dRadians =myPointDirection*(Math.PI/180);     
    //change coordinates of direction of travel    
    myDirectionX += ((dAmount) * Math.cos(dRadians));    
    myDirectionY += ((dAmount) * Math.sin(dRadians));       
  }   
  public void rotate (int nDegreesOfRotation)   
  {     
    //rotates the floater by a given number of degrees    
    myPointDirection+=nDegreesOfRotation;   
  }   
  public void move ()   //move the floater in the current direction of travel
  {      
    //change the x and y coordinates by myDirectionX and myDirectionY       
    myCenterX += myDirectionX;    
    myCenterY += myDirectionY;     

    //wrap around screen    
    if(myCenterX >width)
    {     
      myCenterX = 0;    
    }    
    else if (myCenterX<0)
    {     
      myCenterX = width;    
    }    
    if(myCenterY >height)
    {    
      myCenterY = 0;    
    }   
    else if (myCenterY < 0)
    {     
      myCenterY = height;    
    }   
  }   
  public void show ()  //Draws the floater at the current position  
  {             
    fill(myColor);   
    stroke(myColor);    
    //convert degrees to radians for sin and cos         
    double dRadians = myPointDirection*(Math.PI/180);                 
    int xRotatedTranslated, yRotatedTranslated; 
    beginShape();         
    for(int nI = 0; nI < corners; nI++)    
    {     
      //rotate and translate the coordinates of the floater using current direction 
      xRotatedTranslated = (int)((xCorners[nI]* Math.cos(dRadians)) - (yCorners[nI] * Math.sin(dRadians))+myCenterX);     
      yRotatedTranslated = (int)((xCorners[nI]* Math.sin(dRadians)) + (yCorners[nI] * Math.cos(dRadians))+myCenterY);      
      vertex(xRotatedTranslated,yRotatedTranslated);    
    }   
    endShape(CLOSE);  
  }   
} 

class Stars
{
  private int starX;
  private int starY;
  private int starSize;

  public Stars()
  {
    starX = (int)(Math.random()*500);
    starY = (int)(Math.random()*500);
    starSize = (int)(Math.random()*4);
  }
  
  public void show()
  {
    noStroke();
    fill(255);
    ellipse(starX, starY, starSize, starSize);
  }
}

// to-do
//game over
//making asteroids disappear
//start game