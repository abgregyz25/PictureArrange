String folderStr = "";  // <== enter absolute path of selected folder
File folder = new File(folderStr);
String[] AllFiles = folder.list();
String[] PicFiles = new String [0];
int PicCount = 0;
String pathname = "";
float sqrtPF = 0;
float remainderSqrtPF = 0;
int floorSqrtPF = 0;
float sqOfSqrtPF = 0;
int picX = 0;
int winX = 0;
int picY = 0;
int winY = 0;
int stateNbr = 0;              //verify sqaure root path
PImage[] FamilyFavThNa;

void setup() {
  fullScreen();
 // size(600,400);  
   onLoad();
}

void draw(){ 
    
  }

void mousePressed() {
  exit(); 
}


void onLoad(){
    // Create list of pics in PicFiles
     for (int i = 0; i < AllFiles.length; i++) {
       pathname = AllFiles[i];       
       String[] jpeg = match(pathname, ".jpg");
       String[] bmp = match(pathname, ".bmp");
       String[] tif = match(pathname, ".tif");
      if (jpeg != null || bmp != null || tif != null)
      {
        PicFiles = append(PicFiles,pathname);
      }
      PicCount = PicFiles.length;    
    }
    
   //work out the sqaureroot of the picture count
    sqrtPF = sqrt(PicFiles.length);
   //round down to the nearest integer
    floorSqrtPF = floor(sqrtPF);
   //take the rounded down squareroot value and sqaure it.
   //Will need this to figure out the difference for whether we need an extra column or row
    sqOfSqrtPF = sq(floor(sqrtPF));
   //work out how many spots available for the right side and bottom
    remainderSqrtPF = PicFiles.length - sqOfSqrtPF;
    
    //add another column if need be
    if (remainderSqrtPF > 0 && remainderSqrtPF <= floorSqrtPF){
      picX = floorSqrtPF + 1;
      winX = picX * 100;
      picY = floorSqrtPF;
      winY = picY * 100;
      stateNbr = 1;
    
    //add another column and row if need be
    } else if (remainderSqrtPF > floorSqrtPF) {
        picX = floorSqrtPF + 1;
        winX = picX * 100;
        picY = floorSqrtPF + 1;
        winY = picY * 100;
        stateNbr = 2;
        
    //else just leave it as a square
    } else {
        picX = floorSqrtPF;
        winX = picX * 100;
        picY = floorSqrtPF;
        winY = picY * 100;
        stateNbr = 3;
    }
  FamilyFavThNa = new PImage[PicCount];
  rectMode(CENTER);
  rect(width/2,height/2,winX + 10,winY + 10);
  //println("State Number: " + stateNbr);
  //println("window width: " + winX);
  //println("window height: " + winY);
  //println("How many outside square?: " + remainderSqrtPF);
  //println("All files in folder count: " + AllFiles.length);
  //println("Pictures in folder count: " + PicCount);
 // exit(); 
  float imgPosX = (width/2) - (winX/2) + 50;
  float imgPosY = (height/2) - (winY/2) + 50;
  imageMode(CENTER);
  for(int i = 0; i < PicFiles.length ; i++){
    
    FamilyFavThNa[i] = loadImage(folderStr  + PicFiles[i]);
    if (FamilyFavThNa[i].width >FamilyFavThNa[i].height){
      FamilyFavThNa[i].resize(94,0);
    } else {
      FamilyFavThNa[i].resize(0,94);
    }
   // float mapX = map(FamilyFavThNa[i].width, 0, FamilyFavThNa[i].width, 0, (FamilyFavThNa[i].width / FamilyFavThNa[i].height)* 94);
   // float mapY = map(FamilyFavThNa[i].height, 0, FamilyFavThNa[i].height, 0, 94);
    image(FamilyFavThNa[i], imgPosX, imgPosY);
    stroke(153);
    noFill();
    rect( imgPosX, imgPosY, 100, 100);
    imgPosX += 100;
    if (imgPosX > (width/2) + (winY/2)){
      imgPosX = (width/2) - (winX/2) + 50;
      imgPosY += 100;
    }
  }
}
