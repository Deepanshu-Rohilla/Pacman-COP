#include<bits/stdc++.h>
using namespace std;
bool visited[11][26];
int maze[11][26];
int dx={0,0,-1,1};
int dy={1,-1,0,0};
int x=5;
int y=13;
bool check(int idx){
    if((x+dx[idx]>=0 && x+dx[idx]<= 10) && (y+dy[idx]>=0 && y1+dy[idx]<= 26)){
        return true;
    }
    false;

}
int Random(int lower, int upper){

    int num = (rand() % (upper - lower + 1)) + lower;
    return num;
        
}


int main(){


  int cnt=0;

  for(int i=0;i<11;i++){
      for(int j=0;j<26;j++){
          maze[i][j]=-1;
          visited[i][j]=false;
      }
  }
  int cnt=0;

  while(cnt!=80){
    int idx=Random(0,3);
    if(check(idx)){
     x=x+dx[idx];
     y=y+dy[idx];
     maze[x][y]=0;
     cnt++;
    }
  }

    return 0;
}