#include<bits/stdc++.h>
#include "pacman.h";
#include "get_food.h";
using namespace std;


int numberInRow = 11;
int numberOfSquares = numberInRow * 16;
int playerPosition = numberInRow  + 1;
String playerDirection = 'right';
unordered_map<string,int>dir={{"left",0},{"right",1},{"up",2},{"down",3}};
//mazeDifficulty ={1,2,3};

vector<int> positionOfMovables = { numberInRow * 2 - 2, numberInRow * 9 - 1, numberInRow * 11 - 2};
vector<string> directionOfMovement = {'left', 'left', 'down'}; // intialize at staring of game after that it is modified for ghosts
vector<int> foodAvailable;
//numberofGhosts={1,2,3}

bool preGame = true;
bool mouthClosed = false;
bool win =false;
int score = 0;
bool paused = false;



void resetGame(){
    for (int i = 0; i < numberOfSquares; i++)
      if (!contains(i)) {
        foodAvailable.push_back(i);
      }
  }


 void resetGame() {
//    audioInGame.loop('pacman_beginning.wav');
   
      playerPosition = numberInRow + 1;
      for(int i=0;i<numberOfGhosts;i++){
        if(i==0){
          positionOfMovables[0] = numberInRow * 2 - 2;
        }
        else if(i==1){
          positionOfMovables[1] = numberInRow * 9 - 1;
        }
        else{
          positionOfMovables[2] = numberInRow * 11 - 2;
        }
      }
      paused = false;
      preGame = false;
      mouthClosed = false;
      playerDirection = "right";
      foodAvailable.clear();
      getFood();
      score = 0;
  

  }


// As this require some Screen interacation 
int main(){
    resetGame();
    return 0;
}