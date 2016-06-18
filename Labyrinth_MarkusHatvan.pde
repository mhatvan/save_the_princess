/*
 
 monster killen einen funktioniert nicht korrekt
 
 */

int page = 1;
PImage mainchar;
PImage treasure;
PImage princess;
PImage monster;
PImage winscreen;

int xmainchar = 30;
int ymainchar = 25;

int movement = 5;

int xtreasure = 525;
int ytreasure = 25; 

int xprincess = 1225;
int yprincess = 535;

int xmonster1 = 225;
int ymonster1 = 25;

int xmonster2 = 825;
int ymonster2 = 625;

int counter = 0;
int counter2 = 0;
int counter3 = 0;

import ddf.minim.*; 

Minim minim;
AudioPlayer player;
AudioSample teleporter;
AudioSnippet chest;
AudioSnippet applause;


void setup()

{
  size(1300, 710);

  //BILDER
  mainchar = loadImage("medieval-knight-costume-1.png");  // loadImage immer in setup, resize etc. in die draw
  mainchar.resize(50, 50);
  treasure = loadImage("treasure.png");
  treasure.resize(50, 50);
  princess = loadImage("herz-koenigin-damen-kostuem-rot-schwarz-weiss-57-245027.png");
  princess.resize(50, 50);
  monster = loadImage("monster-zilla.png");
  monster.resize(50, 50);
  winscreen = loadImage("winscreen.jpg");


  //SOUND

  minim = new Minim (this);

  // Audiodatei in das Object 'player' laden
  player = minim.loadFile ("Dialogue of Rising - Feel The Wind.mp3");
  // Audiodatei abspielen
  player.loop ();

  teleporter = minim.loadSample("fusion-shot.mp3");
  chest = minim.loadSnippet("coins-in-hand-4.mp3");
  applause = minim.loadSnippet("applause-5.mp3");

  // Relative Abspielposition im Stück ermitteln
  float playPos = player.position ();
  float playLen = player.length ();
  float xpos = (playPos / playLen) * width;
}

void draw()

{
  //AUSSENWAND
  strokeWeight(10);
  stroke(0);
  fill(215);  
  rect(5, 5, width-10, height-10);

  //LABYRINTHWAENDE

  line(100, 10, 100, 610); //1y

  line(200, 110, 200, 210); //2y
  line(200, 310, 200, 510); //2y
  line(200, 610, 200, 710); //2y
  line(200, 610, 300, 610); //2x

  line(300, 10, 300, 110); //3y
  line(300, 210, 300, 610); //3y

  line(400, 210, 400, 510); //4y
  line(400, 610, 400, 710); //4y
  line(400, 210, 500, 210); //4x

  line(500, 10, 500, 310); //5y
  line(500, 410, 500, 710); //5y

  line(600, 410, 700, 410); //6x
  line(600, 210, 700, 210); //6x

  line(700, 310, 800, 310); //7x
  line(700, 110, 800, 110); //7x
  line(700, 510, 700, 710); //7x

  line(800, 110, 800, 710); // 8y

  line(900, 10, 900, 310); //9y
  line(900, 410, 900, 710); //9y

  line(1000, 10, 1000, 610); //10y

  line(1100, 110, 1100, 610); //11y
  line(1100, 110, 1200, 110); //11x

  line(1200, 110, 1200, 610); //12y

  //TELEPORTER FLASHING

  fill(random(0, 255), random(0, 255), random(0, 255));
  stroke(255);
  rect(125, 390, 50, 50);

  fill(random(0, 255), random(0, 255), random(0, 255));
  rect(425, 240, 50, 50);

  fill(random(0, 255), random(0, 255), random(0, 255));
  rect(425, 630, 50, 50);

  fill(random(0, 255), random(0, 255), random(0, 255));
  rect(725, 630, 50, 50);

  //MOVEMENT RITTER
  if (keyPressed && key == CODED) {
    if (keyPressed == true & keyCode == LEFT)
    {
      xmainchar -= movement;
    }
    if (keyPressed == true & keyCode == RIGHT)
    {
      xmainchar += movement;
    }
    if (keyPressed == true & keyCode == UP)
    {
      ymainchar -= movement;
    }
    if (keyPressed == true & keyCode == DOWN)
    {
      ymainchar += movement;
    }
  }

  //SECRET DOOR

  switch(counter)
  { 
  case 0:
    stroke(0);
    line(600, 10, 600, 610); //6y
    break;
  case 1:
    stroke(0);
    line(600, 10, 600, 250);
    line(600, 370, 600, 610);
    break;
  }

  //BILDER

  image(mainchar, xmainchar, ymainchar);
  image(treasure, xtreasure, ytreasure);
  image(princess, xprincess, yprincess);
  image(monster, xmonster1, ymonster1);
  image(monster, xmonster2, ymonster2);

  noCursor();

  //TELEPORTER

  if (xmainchar >= 100 && xmainchar <= 170 && ymainchar >= 340 && ymainchar <= 440)
  {
    xmainchar = 30;
    ymainchar = 30;
    teleporter.trigger();
  }

  if (xmainchar >= 400 && xmainchar <= 470 && ymainchar >= 190 && ymainchar <= 270)
  {
    xmainchar = 730;
    ymainchar = 230;
   teleporter.trigger();
  }

  if (xmainchar >= 400 && xmainchar <= 470 && ymainchar >= 580 && ymainchar <= 660)
  {
    xmainchar = 530;
    ymainchar = 150;
    teleporter.trigger();
  }

  if (xmainchar >= 700 && xmainchar <= 770 && ymainchar >= 580 && ymainchar <= 660)
  {
    xmainchar = 930;
    ymainchar = 630;
    teleporter.trigger();
  }

  //FALLE

  if (xmainchar >= 1130 && xmainchar <= 1200 && ymainchar >= 580 && ymainchar <= 660)
  {
    xmainchar = 430;
    ymainchar = 330;
    println("not so easy!");
  }

  //SCHATZTRUHE -> GEHEIMGANG GEHT AUF

  if (xmainchar >= 500 && xmainchar <= 560 && ymainchar >= 1 && ymainchar <= 60)
  {
    counter= 1;
    treasure.resize(1, 1);
    chest.play();
    println("secret door opened!");
  }

  //PRINZESSIN GERETTET

  if (page == 1)
  {
    if (xmainchar >= 1200 && xmainchar <= 1250 && ymainchar >= 500 && ymainchar <= 570)
    {
      page = 2;
    }
  }

  //WIN SCREEN

  if (page == 2)
  {
    image(winscreen, 0, 0);
    applause.play();
  }

  //MOVEMENT MONSTER1 

  switch(counter2)
  { 
  case 0:
    ymonster1 += movement;
    break;
  case 1:
    ymonster1 -= movement;
    break;
  }  

  if (ymonster1 < 25) 
  {
    counter2 = 0;
  }

  if (ymonster1 >= 550) 
  {
    counter2 = 1;
  }

  //MOVEMENT MONSTER2

  switch(counter3)
  { 
  case 0:
    ymonster2 -= movement;
    break;
  case 1:
    ymonster2 += movement;
    break;
  }  

  if (ymonster2 >= 650)
  {
    counter3 = 0;
  }

  if (ymonster2 < 25) 
  {
    counter3 = 1;
  }

  //WALL DETECTION

  color leftwall = get(int (xmainchar), int (ymainchar)); 
  if (leftwall == color(#000000)) 
  {
    xmainchar+=15;
  }

  color rightwall = get(int (xmainchar+40), int (ymainchar)); 
  if (rightwall == color(#000000)) 
  {
    xmainchar-=15;
  }

  color upwall = get(int (xmainchar), int (ymainchar-5)); 
  if (upwall == color(#000000)) 
  {
    ymainchar+=15;
  }

  color downwall = get(int (xmainchar), int (ymainchar+50)); 
  if (downwall == color(#000000)) 
  {
    ymainchar-=15;
  }

  //MONSTER KILLEN EINEN

  color monster = #59a600; 
  get(int (xmonster1+width), int (ymonster1+height));
  get(int (xmainchar+width), int (ymainchar+height));
  if (xmonster1 == xmainchar)
    if (ymonster1 == ymainchar)
    {
      xmainchar = 30;
      ymainchar = 25;
    }

  get(int (xmonster2+width), int (ymonster2+height));
  get(int (xmainchar+width), int (ymainchar+height));
  if (xmonster2  == xmainchar)
    if (ymonster2  == ymainchar)
    {
      xmainchar = 530;
      ymainchar = 335;
    }

  //AUSGABE MOUSEPOSITION

  //println("x: " + mouseX + " y: " + mouseY);
}