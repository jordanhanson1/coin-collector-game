import processing.sound.*;
import java.util.*;
import java.io.*;
import java.lang.Math;
import javafx.util.Pair;


//global variables
Sound s;
boolean wait;
boolean init;
boolean lose;
boolean win;
int turns;
int score;
boolean gameOver;
boolean menu;
boolean start;
boolean loadingStart;
boolean easy;
boolean hard;
PImage back;
PImage gameBack;
PImage userManuel;
Board board;
SoundFile backSound;
SoundFile chaching;
boolean oneChecked;
boolean userMan;



//draw coin based on the color and if checked draw a rectangle around it
public void drawCoin(int x, int y, int c, boolean checked){
  
  //draw a rect if checked 
  if (checked==true){
    rectMode(CENTER);
    fill(#D8D6D6);
    rect(x,y,60,60);
    rectMode(CORNER);
  }
  
  
  //red color
  if (c==0){
    fill(#FC0505);
  }
  
  //blue
  if (c==1){
    fill(#0C05FC);
  }
  
  //yellow
  if (c==2){
    fill(#FCF229);
  }
  
  //white
  if (c==3){
    fill(255);
  }
  
  //green
  if (c==4){
    fill(#00FFEC);
  }
  
  //aqua
  if (c==5){
    fill(#10FF00);
  }
  
  //pink
  if (c==6){
    fill(#FF00EF);
  }
  

  
  //draw the coin based on x and y location of obj
    ellipse(x,y,50,50);
    
    if (c==90){
    rectMode(CENTER);
    
    fill(#FAAC03);
    
    rect(x,y,60,60);
    rectMode(CORNER);
  }
}

//draws the menu with buttons for quit, easy, hard, and how to play
void drawMenu(){
  
  //background image 
   background(back);
   fill(0);
  
    //based on mouse location change color
  if (mouseX>70&&mouseX<450+75 && mouseY<100+50+70 && mouseY>50+70)
     fill(#FFF703);

  //draw rectangle for backgound of easy mode button
  rect(75,50+70,450,100);
  fill(0);

  //based on mouse location change color
  if (mouseX>70 && mouseX<450+75 && mouseY<100+200+70 && mouseY>200+70)
      fill(#FFF703);

  //draw rect for hard mode button
  rect(75,200+70,450,100);
  fill(0);

  //based on mouse location change color
  if (mouseX>70 && mouseX<450+75 && mouseY<100+350+70 && mouseY>350+70)
    fill(#FFF703);

  //draw rect for quit button
  rect(75,350+70,450,100);
  
  fill(0);
  if (mouseX>70+90 && mouseX<250+75+90 && mouseY<350+70+350-20 && mouseY>350+200-20)
    fill(#FFF703);

  //draw rect for quit button
  rect(75+90,350+200-20,250,70);


  //text for title
  fill(#FA0810);
  textSize(35);
  text("    Welcome to Coin Collector",40,70);
  
  //text for each mode 
  fill(255);
  textSize(30);
  text("Easy Mode",220,50+70+60);
  text("Hard Mode",220,200+70+60);
  text("Quit",260,350+70+60);
  text("How to play",260-55,350+200+50-20);
}


//easy mode draw background and board
void easyMode(){
  
  //background
  background(gameBack);
  
  //check matching
  board.checkMatching();
  
  //replace matching coins
  board.update();
  
  //draw board
  board.drawBoard();
  
  //draw the score and turn variable
  textSize(50);
  fill(255);
  text("Score: ",190,45);
  text(score,310+40,47);
  text("Turns Left: ",120,95);
  text(10-turns,310+75,97);
}




//setup function initilizes everything
void setup(){
  s = new Sound(this);
  
  //boolean variables initialized
  wait =false;
userMan=false;
menu=true;
start=false;
loadingStart=false;
easy=false;
hard=false;
  win=false;
  lose=false;
  oneChecked=false;
  
  //init to true for initiliazing board
  init=true;
  
  //set sounds
  backSound=new SoundFile(this,"background.wav");
  chaching=new SoundFile(this, "chaChing.wav");
  
  //set score to 0 and initiliaze window and board
  score=0;
  size(600,600);
  board= new Board();
  
  //set images background ones
  back=loadImage("arcade.jpg");
  gameBack=loadImage("gameBack.jpg");
  userManuel = loadImage("Instructions.png");
  turns=0;
}

//draws the how to play menu
void drawUserMan(){
  background(userManuel);
  fill(#FA0808);
  text("click here to go back to menu",80,40);
  
}

//draw gameover menu with a button to go back to menu
void drawGameOver(int WoL){
  
  //same background as game
  background(gameBack);
  fill(0);
  rect(162,160,300,80);
  
  
  //retry button highlight
  if (mouseX>160 && mouseX<162+290 && mouseY<80+300 && mouseY>300)
    fill(#FFF703);
  rect(162,300,290,80);
  if (WoL==0){
    textSize(50);
    fill(255);
    text("You Win!!!",190,220);
  }
  
  if (WoL==1){
    textSize(50);
    fill(255);
    text("You Lose",205,220);
  }
  
  textSize(50);
   fill(255);
  text("Menu",230,357);
  
  
  textSize(50);
  fill(255);
  text("Score: ",190,45);
  text(score,310+40,47);
  text("Turns Left: ",120,95);
  text(10-turns,310+75,97);
}


//main draw method calls alll the different functions
void draw(){
  s.volume(0.2);

  //play the background song and re play when done
  if (backSound.isPlaying()!=true)
    backSound.play();
  smooth();
  
  if (userMan==true){
    drawUserMan();}
  if (hard==true && (win==false && lose==false)){
    if (init == true){
      board.hardMode();}
    easyMode();
  }
  //if player presses easy mode button then start the game on easy
  if (easy==true && (win==false && lose==false)){
    easyMode();
  }
  
  if (win==true){
   drawGameOver(0);
 }
 else if (lose==true){
    drawGameOver(1);
 }
  
  
  //draw the menu if at begging
  if (menu==true){
    drawMenu();
    loadingStart=false;
}
  
}

//input button for mouse clicks
void mousePressed(){
  
  
  //retry button for game over
  if ((mouseX>160 && mouseX<162+290 && mouseY<80+300 && mouseY>300) && (win==true || lose==true)){
    easy=false;
    hard=false;
    menu=true;
    lose=false;
    win=false;
    score=0;
    turns=0;
    draw();
    loadingStart=true;
  }
  
  
  //easy mode press but havent done it yet
  if ((easy==true || hard==true) && (lose==false && win==false)){
    board.clickLocation(mouseX, mouseY);
    board.checkMatching();
    board.update();
    if (score>=50){
      win=true;
    }
    else if (10-turns<=0){
      lose=true;
    }
    draw();
  
  }
  
  
  //menu buttons
  if (mouseX>70 && mouseX<450+75 && mouseY<100+50+70 && mouseY>50+70 && menu==true){
    menu=false;
    easy=true;
    turns=0;
    score=0;
    board= new Board();
    init=true;
  }
  if (mouseX>70 && mouseX<450+75 && mouseY<100+200+70 && mouseY>200+70 && menu==true&&loadingStart==false){
    menu=false;
    hard=true;
    init=true;
    board.checkMatching();
  }
  if (mouseX>70 && mouseX<450+75 && mouseY<100+350+70 && mouseY>350+70 && menu==true){
    exit();
  }
  
  if (mouseX>70+90 && mouseX<250+75+90 && mouseY<350+70+350-20 && mouseY>350+200-20 && menu==true){
    userMan=true;
    menu=false;
    draw();
  }
  if (userMan==true && mouseY<height/2){
    menu=true;
    userMan=false;
  }
  




}
