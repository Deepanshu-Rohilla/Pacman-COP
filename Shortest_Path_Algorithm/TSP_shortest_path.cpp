#include<bits/stdc++.h>
using namespace std;
#define MAX 0x7fffffff
int dist[1001][1001];
int N,M;
int stones_num,barriers_num;
int visited[1001][1001];
int dx []={-1,0,1,0};
int dy [] ={0,1,0,-1};
vector<map<pair<int,int>,list<int>>>shortest_path;
vector<list<int>>shortest_path_final;
map<vector<int>,int>shortest_path_sum;
map<vector<int>,int>shortest_path_sum_temp;
vector<vector<int>>distances;
vector<int>final_path_city;
int minimum_path_distance=100000000;


// `N` is the total number of total nodes on the graph or cities on the map
#define N1 7
 
// Sentinel value for representing `INFINITY`
#define INF INT_MAX
 
// State Space Tree nodes
struct Node
{
    // stores edges of the state-space tree
    // help in tracing the path when the answer is found
    vector<pair<int, int>> path;
 
    // stores the reduced matrix
    int reducedMatrix[N1][N1];
 
    // stores the lower bound
    int cost;
 
    // stores the current city number
    int vertex;
 
    // stores the total number of cities visited so far
    int level;
};
 
// Function to allocate a new node `(i, j)` corresponds to visiting city `j`
// from city `i`
Node* newNode(int parentMatrix[N1][N1], vector<pair<int, int>> const &path,
            int level, int i, int j)
{
    Node* node = new Node;
 
    // stores ancestors edges of the state-space tree
    node->path = path;
    // skip for the root node
    if (level != 0)
    {
        // add a current edge to the path
        node->path.push_back(make_pair(i, j));
    }
 
    // copy data from the parent node to the current node
    memcpy(node->reducedMatrix, parentMatrix,
        sizeof node->reducedMatrix);
 
    // Change all entries of row `i` and column `j` to `INFINITY`
    // skip for the root node
    for (int k = 0; level != 0 && k < N1; k++)
    {
        // set outgoing edges for the city `i` to `INFINITY`
        node->reducedMatrix[i][k] = INF;
 
        // set incoming edges to city `j` to `INFINITY`
        node->reducedMatrix[k][j] = INF;
    }
 
    // Set `(j, 0)` to `INFINITY`
    // here start node is 0
    node->reducedMatrix[j][0] = INF;
 
    // set number of cities visited so far
    node->level = level;
 
    // assign current city number
    node->vertex = j;
 
    // return node
    return node;
}
 
// Function to reduce each row so that there must be at least one zero in each row
int rowReduction(int reducedMatrix[N1][N1], int row[N1])
{
    // initialize row array to `INFINITY`
    fill_n(row, N1, INF);
 
    // `row[i]` contains minimum in row `i`
    for (int i = 0; i < N1; i++)
    {
        for (int j = 0; j < N1; j++)
        {
            if (reducedMatrix[i][j] < row[i]) {
                row[i] = reducedMatrix[i][j];
            }
        }
    }
 
    // reduce the minimum value from each element in each row
    for (int i = 0; i < N1; i++)
    {
        for (int j = 0; j < N1; j++)
        {
            if (reducedMatrix[i][j] != INF && row[i] != INF) {
                reducedMatrix[i][j] -= row[i];
            }
        }
    }
}
 
// Function to reduce each column so that there must be at least one zero
// in each column
int columnReduction(int reducedMatrix[N1][N1], int col[N1])
{
    // initialize all elements of array `col` with `INFINITY`
    fill_n(col, N1, INF);
 
    // `col[j]` contains minimum in col `j`
    for (int i = 0; i < N1; i++)
    {
        for (int j = 0; j < N1; j++)
        {
            if (reducedMatrix[i][j] < col[j]) {
                col[j] = reducedMatrix[i][j];
            }
        }
    }
 
    // reduce the minimum value from each element in each column
    for (int i = 0; i < N1; i++)
    {
        for (int j = 0; j < N1; j++)
        {
            if (reducedMatrix[i][j] != INF && col[j] != INF) {
                reducedMatrix[i][j] -= col[j];
            }
        }
    }
}
 
// Function to get the lower bound on the path starting at the current minimum node
int calculateCost(int reducedMatrix[N1][N1])
{
    // initialize cost to 0
    int cost = 0;
 
    // Row Reduction
    int row[N1];
    rowReduction(reducedMatrix, row);
 
    // Column Reduction
    int col[N1];
    columnReduction(reducedMatrix, col);
 
    // the total expected cost is the sum of all reductions
    for (int i = 0; i < N1; i++)
    {
        cost += (row[i] != INT_MAX) ? row[i] : 0,
            cost += (col[i] != INT_MAX) ? col[i] : 0;
    }
 
    return cost;
}
 
// Function to print list of cities visited following least cost
void printPath(vector<pair<int, int>> const &list)
{
    for (int i = 0; i < list.size()-1; i++) {
        final_path_city.push_back(list[i].first);
       // cout << list[i].first + 1 << " —> " << list[i].second + 1 << endl;
    }
    final_path_city.push_back(list[list.size()-1].first);
    final_path_city.push_back(list[list.size()-1].second);
}
 
// Comparison object to be used to order the heap
struct comp
{
    bool operator()(const Node* lhs, const Node* rhs) const {
        return lhs->cost > rhs->cost;
    }
};
 
// Function to solve the traveling salesman problem using Branch and Bound
int solve(int costMatrix[N1][N1])
{
    // Create a priority queue to store live nodes of the search tree
    priority_queue<Node*, vector<Node*>, comp> pq;
 
    vector<pair<int, int>> v;
 
    // create a root node and calculate its cost.
    // The TSP starts from the first city, i.e., node 0
    Node* root = newNode(costMatrix, v, 0, -1, 0);
 
    // get the lower bound of the path starting at node 0
    root->cost = calculateCost(root->reducedMatrix);
 
    // Add root to the list of live nodes
    pq.push(root);
 
    // Finds a live node with the least cost, adds its children to the list of
    // live nodes, and finally deletes it from the list
    while (!pq.empty())
    {
        // Find a live node with the least estimated cost
        Node* min = pq.top();
 
        // The found node is deleted from the list of live nodes
        pq.pop();
 
        // `i` stores the current city number
        int i = min->vertex;
 
        // if all cities are visited
        if (min->level == N1- 1)
        {
            // return to starting city
            min->path.push_back(make_pair(i, 0));
 
            // print list of cities visited
            printPath(min->path);
 
            // return optimal cost
            return min->cost;
        }
 
        // do for each child of min
        // `(i, j)` forms an edge in a space tree
        for (int j = 0; j < N1; j++)
        {
            if (min->reducedMatrix[i][j] != INF)
            {
                // create a child node and calculate its cost
                Node* child = newNode(min->reducedMatrix, min->path,
                    min->level + 1, i, j);
 
                /* Cost of the child =
                    cost of the parent node +
                    cost of the edge(i, j) +
                    lower bound of the path starting at node j
                */
 
                child->cost = min->cost + min->reducedMatrix[i][j]
                            + calculateCost(child->reducedMatrix);
 
                // Add a child to the list of live nodes
                pq.push(child);
            }
        }
 
        // free node as we have already stored edges `(i, j)` in vector.
        // So no need for a parent node while printing the solution.
        delete min;
    }
}


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

  int src;
  int dest;
  cin>>N>>M;
  cin>>barriers_num>>stones_num;
  cin>>src>>dest;
  vector<int>barriers;
  vector<int>stones;
  for(int i=0;i<barriers_num;i++){
      int x;
      cin>>x;
      barriers.push_back(x);
  }
  for(int i=0;i<stones_num;i++){
      int y;
      cin>>y;
      stones.push_back(y);
  }
 int costMatrix[N1][N1];

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
for(int i=0;i<stones.size();i++){
    ver_pos.push_back(stones[i]);
}
vector<pair<int,int>>src_dest;
for(int i=0;i<ver_pos.size();i++){
    for(int j=0;j<ver_pos.size();j++){
        if(i!=j){
            src_dest.push_back({ver_pos[i],ver_pos[j]});
             BFS(ver_pos[i],ver_pos[i]/M,ver_pos[i]%M,ver_pos[j],maze);
        }
    }
}


for(int i=0;i<N1;i++){
    for (int j=0;j<N1;j++){
        if(i==j){
           costMatrix[i][j]=INF;
        }else{
            int idx=Search(ver_pos[i],ver_pos[j]);
            costMatrix[i][j]=shortest_path[idx][{ver_pos[i],ver_pos[j]}].size()-1;
           // cout<<distances[i][j]<<"\n";
        }
    }
    
}

solve(costMatrix);

for(int i=0;i<final_path_city.size();i++){
     if(i!=(final_path_city.size()-1)){
         int idx=Search(ver_pos[final_path_city[i]],ver_pos[final_path_city[i+1]]);
         auto it=shortest_path[idx][{ver_pos[final_path_city[i]],ver_pos[final_path_city[i+1]]}].begin();
         while(it!=shortest_path[idx][{ver_pos[final_path_city[i]],ver_pos[final_path_city[i+1]]}].end()){
             cout<<*it<<",";
             it++;
         }
     }
}
cout<<"\n";

    return 0;
}
