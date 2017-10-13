// using state variables
// one mode has static obstacles the other will have obstacles moving vertically and horizintally


// Graham Kelly
// State variable assignment
// September 25th, 2017
// Computer science 30, WMCI
// For the extra for experts portion of the assignment I chose to explore arrays

//variable setup
float diam = 20;
float speed = (7);
float xPosition = 100;
color randomColour;
float obstacleYA;
float obstacleYB;
float obstacleYC;
float obstacleYD;
float obstacleYE;
float obstacleYF;
float obstacleYG;
float obstacleYH;
float obstacleYI;
int level = 0;
float obstacleDiam;
float state = 0;
float obstacleSpeed;
int numberOfObstacles = 10;
//float randomObsY = random(75, (height - 100));
int[] obsY = new int[(numberOfObstacles)];
int[] obsX = new int[(numberOfObstacles)];
boolean obstacleUpOrDown;



void setup() { // sets the size of the screen
  size(1500, 800);
  background(0);

}


void draw() { 

  if (state == 0) { // choose between moving and static obstacles
    cursor(HAND);
    homeScreen();
  }

  if (state == 1) { 
    noCursor();
    checkForNewLevel();
    drawBall();
    drawObstacle();
  }

  if (state == 2) {
    noCursor();
    checkForNewLevel();
    drawBall();

    drawObstacle();
    moveObstacles();
  }

  if (state == 3) {
    noCursor();
    retryScreen();
  }
}

void homeScreen() { // the first screen you see
  background(0); 
  fill(255, 0, 0); 
  rect(0, 0, width/2, height);
  fill(0, 0, 255);
  rect(width/2, 0, width/2, height);
  textSize(32);
  fill(255);
  text("Click this side to play with moving obstacles", 10, 30, (width/3), height);
  text("Click this side to play with static obstacles", ((width/2) + 10), 30, (width/3), height);


  
  
  if (mousePressed == true) {

    if (mouseX < (width/2)) {
      state = 2;
    }
    if (mouseX > (width/2)) {
      state = 1;
    }
  }
}

void retryScreen() { // this screen is shown after contact is made with an obstacle
  background(0);
  textSize(32);
  text("Press any key to play again", 10, 30);  
  text("You made it to level" + " " + (level) + "!", 10, 70); 
  if (keyPressed == true) {
    level = 0;
    state = 0;
  }
}
void checkForNewLevel() {
  if (xPosition >= (width - 100)) {
    xPosition = 100; // moves ball to left side of screen whne it reaches the right side
    if (speed < 20) { 
      speed = (speed + 1); // adds 0.5 to ball speed every after every level
    }

    randomColour = color(random(255), random(255), random(255)); // chooses a random colour at the start of every level
    obstacleSpeed = random(-5, 5 );
   
    if (level % 2 == 0 ){
    numberOfObstacles ++ ;  
    }
    
    obstacleDiam = random(40, 100); // chooses diameter of obstacles at the start of every level
    
    chooseNewObsatcleLocations();
    level = level + 1;
    
  }
}



void drawBall() { //draws the ball used in the game  
  background(randomColour);  

  drawCourt();

  float yPosition = constrain(mouseY, 100, (height - 100)); //constrains the y position of the ball 100 pixels away from the top and bottom of the screen

  xPosition = (xPosition + speed); // moves ball from left to right at by a distance of the variable "speed"
  contactDetect();


  fill(randomColour);
  ellipse(xPosition, yPosition, diam, diam); // draws the ball
}


void drawCourt() { // draws the screen used for the game
  fill(255);
  rect(100, 100, (width - 200), (height - 200));
  textSize(32);
  text(level, 10, 30);
}

void chooseNewObsatcleLocations() {
  for (int i=0; i<obsY.length; i++) {
    obsY[i] = int(random(100, (height - 100)));
  }
  for (int i=0; i<obsX.length; i++) {
    obsX[i] = int(random (width/4, (width - 100)));
  }
  
  
}

void drawObstacle() { //draws the obstacles

  fill(randomColour);


  noStroke();
  for (int i = 0; i < obsY.length; i++) {
    rect(obsX[i], obsY[i], obstacleDiam, obstacleDiam);
  }
}




void moveObstacles() {
  
  for (int i = 0; i < obsY.length; i++) {
    if (i % 2 == 0){ 
      obsY[i] = obsY[i] + int(obstacleSpeed);
    }
    if (i % 5 == 0 ){
      obsX[i] = obsX[i] + int(obstacleSpeed);
    }
    else {
      obsY[i] = obsY[i] - int(obstacleSpeed);
    }
  }
  
}

void contactDetect() { // detects any contact between the ball and obstacles and ends the game if contact occurs
  for (int i = 0; i < obsY.length; i++) {

    float yPosition = constrain(mouseY, 100, (height - 100));
    if ((yPosition >= obsY[i]) && (yPosition <= (obsY[i] + obstacleDiam)) 
      && (xPosition >= (obsX[i]) && (xPosition <= (obsX[i]) + obstacleDiam))){


      state = 3; //resets the game
      xPosition = 100;
      obstacleDiam = 0;   
      speed = 7;
   
    }
    }
  }