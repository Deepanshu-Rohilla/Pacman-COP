import 'dart:collection';
class Pair{
  // field
  int firstNum;
  int secondNum;
  Pair(int first, int second){
    this.firstNum = first;
    this.secondNum = second;
  }

  int first(){
    return this.firstNum;
  }
  int second(){
    return this.secondNum;
  }
}

int row = 1001;
int col = 1001;
int N=26;
int M = 11;
var dist = List.generate(row, (i) => List(col), growable: false);
var visited = List.generate(row, (i) => List(col), growable: false);
List<int> dx = [-1,0,1,0];
List<int> dy = [0,1,0,-1];
List<HashMap<Pair, List<int>>> shortest_path;
List<List<int>> shortest_path_final;
HashMap<List<int>, int> shortest_path_sum;
HashMap<List<int>, int> shortest_path_sum_temp;
int minimum_path_distance=100000000;



int search(int x,int y){
  for(int i=0;i<shortest_path.length;i++){
    HashMap<Pair, List<int>> m;
    m= shortest_path[i];
    Iterable<Pair> it = m.keys;
    if(it.first.firstNum==x && it.first.secondNum==y){
      return i;
    }
  }
  return -1;
}

void list_append(List<int> list1, List<int> final_path){
  int it =0;
  while(it!=list1.length){
    final_path.add(list1[it]);
    it++;
  }

}


void Find_Smallest_Path_from_src_dest(List<int> stones,int src,int dest){
  stones.sort();
// cout<<src<<" "<<dest<<"\n";
do{
  int sum=0;
  for(int i=0;i<stones.length;i++){
    int idx;

    if(i==0){
      idx= search(src, stones[i]);
      sum+=shortest_path[idx][{src,stones[i]}].length-1;
    }
    else if(i==stones.length-1){
      idx= search(stones[i-1],stones[i]);
      sum+=shortest_path[idx][{stones[i-1],stones[i]}].length-1;
      idx= search(stones[i],dest);
      sum+=shortest_path[idx][{stones[i],dest}].length-1;
    }
    else{
      idx= search(stones[i-1],stones[i]);
      sum+=shortest_path[idx][{stones[i-1],stones[i]}].length-1;
    }
  }
  shortest_path_sum_temp[stones]=sum;
  if(minimum_path_distance>sum){
  minimum_path_distance=sum;
  }

}
while(next_permutation(stones.begin(),stones.end()));
//  HashMap<List<int>, int> shortest_path_sum_temp;

//  while(it!=shortest_path_sum_temp.end()){
//
//  if((it->second)==minimum_path_distance){
//  shortest_path_sum[it->first]=minimum_path_distance;
//  }
//
//  it++;
//  }

}

bool isValid(int row,int column){

  if(row<0 || row >= N|| column < 0 || column >= M) return false;

  if(visited[row][column]==1) return false;

  return true;
}


void BFS(int src, int srcX, int srcY,int dest, List<List<int>> maze){
  Queue<Pair> q;
  var pred = List.generate(row, (i) => List(col), growable: false);
  for(int i=0;i<N;i++){
    for(int j=0;j<M;j++){
      visited[i][j]=0;
      dist[i][j]=double.maxFinite.toInt();
      pred[i][j]=-1;
    }
  }

  visited[srcX][srcY]=1;
  q.add(Pair(srcX,srcY));
  dist[srcX][srcY]=0;

  while(q.isNotEmpty){
    int currX=q.first.firstNum;
    int currY=q.first.secondNum;
    q.removeLast();
    for(int i=0;i<4;i++){
      if(isValid(currX+dx[i],currY+dy[i]) && maze[currX+dx[i]][currY+dy[i]]!=-1){
      int newX= currX+dx[i];
      int newY =currY+dy[i];

      pred[newX][newY]=currX*M+currY;
      dist[newX][newY]=dist[currX][currY]+1;
      visited[newX][newY]=1;
      q.add(Pair(newX,newY));
      if(newX*M+newY==dest) break;
      }
    }
  }
  List<int> path;
  int crawl=dest;
  path.add(crawl);

  while (pred[crawl~/M][crawl%M]!=-1){
    path.add(pred[crawl~/M][crawl%M]);
    crawl=pred[crawl~/M][crawl%M];
  }

  List<int>final_path;

  int it = path.length-2;

  while(it!=0){
    final_path.add(path[it]);
    it--;
  }
  final_path.add(path[it]);
  HashMap<Pair, List<int>> path_map;

  path_map.update(Pair(src,dest), (value) => final_path);
  shortest_path.add(path_map);
}


int main(){

  List<int> barriers = [3,5,8];
  List<int> stones = [4,7];
  int src=0;
  int dest=100;
  List<List<int>> maze;

  for(int i=0;i<N;i++){
    List<int> v;
    for(int j=0;j<M;j++){
      v.add(0);
    }
    maze.add(v);
  }

  for(int i=0;i<barriers.length;i++){
    maze[barriers[i]~/M][barriers[i]%M]=-1;
  }

  List<int> ver_pos;
  ver_pos.add(src);
  ver_pos.add(dest);
  for(int i=0;i<stones.length;i++){
    ver_pos.add(stones[i]);
  }

  List<Pair> src_dest;

  for(int i=0;i<ver_pos.length;i++){
    for(int j=0;j<ver_pos.length;j++){
      if(i!=j){
        src_dest.add(Pair(ver_pos[i],ver_pos[j]));
        // cout<<ver_pos[i]<<" "<<ver_pos[j]<<"\n";
        BFS(ver_pos[i],ver_pos[i]~/M,ver_pos[i]%M,ver_pos[j],maze);
      }
    }
  }

  Find_Smallest_Path_from_src_dest(stones,src,dest);
//  return -1;
//  HashMap<List<int>, int> shortest_path_sum;
  Iterable<List<int>> it0 = shortest_path_sum.keys;
  for(int i=0;i<shortest_path_sum.length;i++){
    List<int> list_final_path;
    for(int j=0;j<it0.first.length;j++){
      int idx;
      if(j==0){
        idx= search(src, it0.first[j]);
        HashMap<Pair,List<int>>m1;
        m1=shortest_path[idx];
        list_append((shortest_path[idx][{src, it0.first[j]}]),list_final_path);
      }else if(j==(it0.first.length-1)){
        idx= search( it0.first[j-1],it0.first[j]);
        HashMap<Pair,List<int>>m1;
        m1=shortest_path[idx];
        list_append((shortest_path[idx][{it0.first[j-1],it0.first[j]}]),list_final_path);
        idx= search(it0.first[j],dest);
        HashMap<Pair,List<int>>m2;
        m2=shortest_path[idx];
        list_append((shortest_path[idx][{it0.first[j],dest}]),list_final_path);
      }else{
        idx= search( it0.first[j-1],it0.first[j]);
        HashMap<Pair,List<int>>m1;
        m1=shortest_path[idx];
        list_append((shortest_path[idx][{it0.first[j-1],it0.first[j]}]),list_final_path);
      }
    }

  }


  for(int i=0;i<shortest_path_sum.length;i++){
    List<int>list_final_path;
    shortest_path_final.add(list_final_path);
  }

  for(int i=0;i<shortest_path_final.length;i++){
    for(int j=0;j<shortest_path_final[i].length;j++){
      print(shortest_path_final[i][j]);
    }
  }

  return 0;
}