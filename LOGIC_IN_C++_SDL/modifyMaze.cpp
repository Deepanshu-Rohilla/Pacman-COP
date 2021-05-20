
#include <bits/stdc++.h>
#include "pacman.h";
#include "Random.h";
using namespace std;

int numberInRow = 11;
int numberOfSquares = numberInRow * 16;
int playerPosition = numberInRow  + 1;
string playerDirection = 'right';
int maze;
unordered_map<string,int>dir={{"left",0},{"right",1},{"up",2},{"down",3}};
//mazeDifficulty ={1,2,3};
list<int>barriers;
list<int>add;

bool contains(int key){
    auto it=barriers.begin();
    while (it!=barriers.end){

        if(*it==key){
            return true;
        }
        it++;
    }
    return false;
}

void modifyMaze(int index){
    if(contains(index)){
      return;
    }
    if(add.contains(index)){
      add.remove(index);
    }
    else{
      add.push_back(index);
    }

  }

int main(){


    modifyMaze(index);
}