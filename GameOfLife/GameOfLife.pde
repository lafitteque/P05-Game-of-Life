// This is the implementation of the Game of Life
// The grid represents cells (black cells are alive, white cells are not)
//
// The Game of Life follows simple rules: (we call neighbour a cell which is alive)
// 1) if a cell has 2 neighbours : the cell is unchanged
// 2) if a cell has 3 neighbours : the cell becomes alive
// 3) Else : the cell becomes white (dead)

// Screen parameters
int screenWidth = 1000;

// Grid parameters
int gridWidth = 50;
int cellWidth;
int[][] grid;
int[][] nextGrid;

// to know if the the simulation is running
int activation = 0;

void setup(){
  frameRate(60);
  size(1000,1000);
  background(100,100,100);
  
  Init();
  drawGrid(grid);
}

void Init(){ 
  grid = new int[gridWidth][gridWidth];
  nextGrid = new int[gridWidth][gridWidth];
  cellWidth = (int) ((float)screenWidth/gridWidth);
  activation = 0;
  
  for (int i=0; i<gridWidth;i++){
    for (int j =0; j<gridWidth;j++){
      grid[i][j] = 1; // 1 stands for white cells
    }
  }

}

void draw(){
  if (activation == 1){
    frameRate(5);
    iterate();
  }
  background(40,40,40);
  drawGrid(grid);
}
  
void mouseClicked() {
  // Click a cell to invert its colour
  int i = (int) ((float)mouseX/cellWidth);
  int j = (int) ((float)mouseY/cellWidth);
  grid[i][j] = 1 - grid[i][j];
  
}


void keyPressed(){
  // Press ALT to clear
  // Press any other key (except escape) to run the simulation)
  
  if (key == CODED) {
    if (keyCode == ALT) {
      Init(); 
    }
    else{
      activation = 1;
    }
  }
  else{
    activation = 1;
  }
}

void drawGrid(int[][] grid){
  // Draw each cell depending on its value (0 : black  ;  1 : white)
  for (int i=0; i<gridWidth;i++){
    for (int j =0; j<gridWidth;j++){
      push();
      stroke(0);
      fill(grid[i][j]*255);
      rect(cellWidth*i,cellWidth*j,cellWidth*0.95,cellWidth*0.95);
      pop();      
    }
  }
}

void iterate(){
  
  nextGrid = copy_array(grid);
  
  // We look at each cell
  for (int i=0; i<gridWidth;i++){
    for (int j =0; j<gridWidth;j++){
      
      // And count the neighbours (cells with a value of 0
      int neighboursNumber = 0;
      for (int di = -1 ; di<=1 ; di++){
        for (int dj = -1 ; dj<=1 ; dj++){
          
          boolean outOfBounds = (di +i==gridWidth || dj +j==gridWidth || di+i==-1 || dj +j==-1);
          
          if(!outOfBounds && (dj !=0 || di !=0) ){
            if(grid[i+di][j+dj] == 0){ // we need to count all the neighbours before changing the values, that's why we need grid and nextGrid
              neighboursNumber++;
            }
          }
          
        }
      }
      
      // Rules of the Game Of Life
      if(neighboursNumber ==3){
        nextGrid[i][j] = 0;
      }
      else if(neighboursNumber != 2){
        nextGrid[i][j] = 1; 
      }
      // if neighboursNumber = 2 then the cell is unchange
      
    }
  }
  // We save the previous grid in memory
  grid = copy_array(nextGrid);
  
}

int[][] copy_array(int[][] matrix){
  int [][] myInt = new int[matrix.length][];
  for(int i = 0; i < matrix.length; i++)
    {
    int[] aMatrix = matrix[i];
    int   aLength = aMatrix.length;
    myInt[i] = new int[aLength];
    System.arraycopy(aMatrix, 0, myInt[i], 0, aLength);
  }
  return myInt;
}
