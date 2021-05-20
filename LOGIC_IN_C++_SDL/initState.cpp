#include<bits/stdc++.h>
#include "pacman.h";
#include "Random.h";
using namespace std;


void initState() {
    // TODO: implement initState
    int maze = Random(0,4);
    barriers = gameBarriers[ (widget.mazeDifficulty-1)*5+ maze];

  }
int main(){
   
    initState();

    return 0;
}
