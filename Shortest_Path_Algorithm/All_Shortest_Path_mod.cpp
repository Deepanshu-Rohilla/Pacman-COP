#include<bits/stdc++.h>
using namespace std;
int dist[1001][1001];
int N,M;
int visited[1001][1001];
int dx []={-1,0,1,0};
int dy [] ={0,1,0,-1};
vector<map<pair<int,int>,list<int>>>shortest_path;
vector<list<int>>shortest_path_final;
map<vector<int>,int>shortest_path_sum;
map<vector<int>,int>shortest_path_sum_temp;
int minimum_path_distance=100000000;


int Search(int x,int y){
    for(int i=0;i<shortest_path.size();i++){
        map<pair<int,int>,list<int>>m;
        m=shortest_path[i];
        auto it=m.begin();
        if((it->first).first==x && (it->first).second==y){
          //  cout<<x<<" "<<y<<"\n";
            return i;
        }
    }
}

void list_append(list<int>&list1,list<int>&final_path){


  auto it=list1.begin();
  while(it!=list1.end()){
       final_path.push_back(*it);
       it++;
  }

}


void possible_permutation(vector<int>&stones,int n,int src, int dest){

    int sum=0;
        for(int i=0;i<stones.size();i++){
            int idx;

             if(i==0){
                idx= Search(src, stones[i]);
                // cout<<idx<<"\n";
               sum+=shortest_path[idx][{src,stones[i]}].size()-1;
               // cout<<shortest_path[idx][{src,stones[i]}].size()<<" ";

             }
             else if(i==stones.size()-1){
                idx= Search(stones[i-1],stones[i]);
                //cout<<idx<<"\n";
                sum+=shortest_path[idx][{stones[i-1],stones[i]}].size()-1;
                //cout<<shortest_path[idx][{stones[i-1],stones[i]}].size()<<" ";
                idx= Search(stones[i],dest);
                // cout<<idx<<"\n";
                sum+=shortest_path[idx][{stones[i],dest}].size()-1;
                //cout<<shortest_path[idx][{stones[i],dest}].size()<<" ";
             }else{
                idx= Search(stones[i-1],stones[i]);
                sum+=shortest_path[idx][{stones[i-1],stones[i]}].size()-1;
                //cout<<shortest_path[idx][{stones[i-1],stones[i]}].size()<<" ";
             }
             //cout<<sum<<"\n";
        }
       // cout<<"\n";
        shortest_path_sum_temp[stones]=sum;
        if(minimum_path_distance>sum){
            minimum_path_distance=sum;
        }

}
// Generating permutation using Heap Algorithm
void heapPermutation(vector<int>&stones, int size, int n,int src,int dest){
	// if size becomes 1 then prints the obtained
	// permutation
	if (size == 1) {
		possible_permutation(stones, n,src,dest);
		return;
	}

	for (int i = 0; i < size; i++) {
		heapPermutation(stones, size - 1, n,src,dest);

		// if size is odd, swap 0th i.e (first) and
		// (size-1)th i.e (last) element
		if (size % 2 == 1)
			swap(stones[0], stones[size - 1]);

		// If size is even, swap ith and
		// (size-1)th i.e (last) element
		else
			swap(stones[i], stones[size - 1]);
	}
}

void Find_Smallest_Path_from_src_dest(vector<int>&stones,int src,int dest){
    // cout<<src<<" "<<dest<<"\n";
    sort(stones.begin(),stones.end());

    heapPermutation(stones, stones.size(), stones.size(),src,dest);

    // do{
    //     int sum=0;
    //     for(int i=0;i<stones.size();i++){
    //         int idx;

    //          if(i==0){
    //             idx= Search(src, stones[i]);
    //             // cout<<idx<<"\n";
    //            sum+=shortest_path[idx][{src,stones[i]}].size()-1;
    //            // cout<<shortest_path[idx][{src,stones[i]}].size()<<" ";

    //          }
    //          else if(i==stones.size()-1){
    //             idx= Search(stones[i-1],stones[i]);
    //             //cout<<idx<<"\n";
    //             sum+=shortest_path[idx][{stones[i-1],stones[i]}].size()-1;
    //             //cout<<shortest_path[idx][{stones[i-1],stones[i]}].size()<<" ";
    //             idx= Search(stones[i],dest);
    //             // cout<<idx<<"\n";
    //             sum+=shortest_path[idx][{stones[i],dest}].size()-1;
    //             //cout<<shortest_path[idx][{stones[i],dest}].size()<<" ";
    //          }else{
    //             idx= Search(stones[i-1],stones[i]);
    //             sum+=shortest_path[idx][{stones[i-1],stones[i]}].size()-1;
    //             //cout<<shortest_path[idx][{stones[i-1],stones[i]}].size()<<" ";
    //          }
    //          //cout<<sum<<"\n";
    //     }
    //    // cout<<"\n";
    //     shortest_path_sum_temp[stones]=sum;
    //     if(minimum_path_distance>sum){
    //         minimum_path_distance=sum;
    //     }

    // }while(next_permutation(stones.begin(),stones.end()));

    
    
    auto it=shortest_path_sum_temp.begin();
    //cout<<minimum_path_distance<<"\n";
   int j=0;
 while(it!=shortest_path_sum_temp.end()){
          
    if((it->second)==minimum_path_distance){
        shortest_path_sum[it->first]=minimum_path_distance;
       }

       it++;
   }

}
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

int main(){

 cin>>N>>M;

  vector<int>barriers = {3,5,8};
  vector<int>stones = {4,7};
  int src=0;
  int dest=100;
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

Find_Smallest_Path_from_src_dest(stones,src,dest);

auto it_=shortest_path_sum.begin();

while(it_!=shortest_path_sum.end()){

        list<int>list_final_path;

      for(int j=0;j<(it_->first).size();j++){
            int idx;
          if(j==0){
            idx= Search(src, (it_->first)[j]);
            map<pair<int,int>,list<int>>m1;
            m1=shortest_path[idx];
            auto it=m1.begin();
            list_append((shortest_path[idx][{src, (it_->first)[j]}]),list_final_path);
          }else if(j==((it_->first).size()-1)){
               idx= Search( (it_->first)[j-1],(it_->first)[j]);
                map<pair<int,int>,list<int>>m1;
                m1=shortest_path[idx];
               auto it=m1.begin();
               list_append((shortest_path[idx][{(it_->first)[j-1],(it_->first)[j]}]),list_final_path);
                idx= Search((it_->first)[j],dest);
                map<pair<int,int>,list<int>>m2;
                m2=shortest_path[idx];
               auto it1=m2.begin();
               list_append((shortest_path[idx][{(it_->first)[j],dest}]),list_final_path);
          }else{
                idx= Search( (it_->first)[j-1],(it_->first)[j]);
                map<pair<int,int>,list<int>>m1;
                m1=shortest_path[idx];
                auto it=m1.begin();
                list_append((shortest_path[idx][{(it_->first)[j-1],(it_->first)[j]}]),list_final_path);
          }
      }
      shortest_path_final.push_back(list_final_path);
      it_++;
  }

 for(int i=0;i<shortest_path_final.size();i++){
     auto it=shortest_path_final[i].begin();
     while(it!=shortest_path_final[i].end()){
         cout<<*it<<" ";
         it++;
     }
     cout<<"\n";
 }

    return 0;
}