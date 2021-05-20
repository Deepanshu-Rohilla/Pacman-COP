#include<bits/stdc++.h>
using namespace std;
int dist[1001][1001];
int N,M;
int visited[1001][1001];
int dx []={-1,0,1,0};
int dy [] ={0,1,0,-1};
vector<map<pair<int,int>,list<int>>>shortest_path;

bool isValid(int row,int column){

  if(row<0 || row >= N|| column < 0 || column >= M) return false;

   
  if(visited[row][column]==1) return false;

   
  return true;
}
void BFS(int src, int srcX, int srcY,int dest,vector<vector<int>>&maze){

    queue<pair<int,int>>q;
    int pred[N][M];
    for(int i=0;i<N;i++){
        for(int j=0;j<M;j++){
            visited[i][j]=0;
            dist[i][j]=INT_MAX;
            pred[i][j]=-1;
        }
    }

    visited[srcX][srcY]=1;
    q.push({srcX,srcY});
    dist[srcX][srcY]=0;
   // visited[srcX][srcY]=1;

    while(!q.empty()){
        int currX=q.front().first;
        int currY=q.front().second;
        q.pop();
        for(int i=0;i<4;i++){
            if(isValid(currX+dx[i],currY+dy[i]) && maze[currX+dx[i]][currY+dy[i]]!=-1){
                int newX= currX+dx[i];
                int newY =currY+dy[i];
                
                pred[newX][newY]=currX*M+currY;
                dist[newX][newY]=dist[currX][currY]+1;
                visited[newX][newY]=1;
                q.push({newX,newY});
                if(newX*M+newY==dest) break;
            }
        }
    }
  list<int>path;
  int crawl=dest;
  path.push_back(crawl);
  while (pred[crawl/M][crawl%M]!=-1){
      path.push_back(pred[crawl/M][crawl%M]);
      crawl=pred[crawl/M][crawl%M];
  }

  list<int>final_path;
  auto it=path.end();
  it--;
  while(it!=path.begin()){
      final_path.push_back(*it);
      it--;
  }
  final_path.push_back(*it);

 map<pair<int,int>,list<int>>path_map;
 path_map[{src,dest}]=final_path;
 shortest_path.push_back(path_map);
}


// void printShortestDistance(vector<int> adj[], int s,int dest, int v){
//     // predecessor[i] array stores predecessor of
//     // i and distance array stores distance of i
//     // from s
//     int pred[v], dist[v];
 
//     if (BFS(adj, s, dest, v, pred, dist) == false) {
//         cout << "Given source and destination"
//              << " are not connected";
//         return;
//     }
 
//     // vector path stores the shortest path
//     vector<int> path;
//     int crawl = dest;
//     path.push_back(crawl);
//     while (pred[crawl] != -1) {
//         path.push_back(pred[crawl]);
//         crawl = pred[crawl];
//     }
 
//     // distance from source is in distance array
//     cout << "Shortest path length is : "
//          << dist[dest];
 
//     // printing path from source to destination
//     cout << "\nPath is::\n";
//     for (int i = path.size() - 1; i >= 0; i--)
//         cout << path[i] << " ";
// }


int main(){

 cin>>N>>M;

  vector<int>barriers = {3,5,8};
  vector<int>stones = {4,7};
  int src=0;
  int dest=1;
  vector<vector<int>>maze;
  for(int i=0;i<N;i++){
      vector<int>v;
      for(int j=0;j<M;j++){
         v.push_back(0);
      }
      maze.push_back(v);
  }

  for(int i=0;i<barriers.size();i++){
      maze[barriers[i]/M][barriers[i]%M]=-1;
  }

vector<int>ver_pos;
ver_pos.push_back(src);
ver_pos.push_back(dest);
for(int i=0;i<stones.size();i++){
    ver_pos.push_back(stones[i]);
}
vector<pair<int,int>>src_dest;
//cout<<ver_pos.size()<<"\n";
for(int i=0;i<ver_pos.size();i++){
    for(int j=0;j<ver_pos.size();j++){
        if(i!=j){
            src_dest.push_back({ver_pos[i],ver_pos[j]});
           // cout<<ver_pos[i]<<" "<<ver_pos[j]<<"\n";
             BFS(ver_pos[i],ver_pos[i]/M,ver_pos[i]%M,ver_pos[j],maze);
        }
    }
}

//cout<<shortest_path.size()<<"\n";
 for(int i=0;i<shortest_path.size();i++){
     map<pair<int,int>,list<int>>m;
     m=shortest_path[i];
     auto it1=m.begin();
     auto it=m[{src_dest[i].first,src_dest[i].second}].begin();
    // cout<<(it->first).first<<" "<<(it->first).second<<": ";
     while(it!=(it1->second).end()){
         cout<<*it<<" ";
         it++;
     }
     cout<<"\n";
 }


    return 0;
}