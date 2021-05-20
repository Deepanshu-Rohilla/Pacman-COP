
#include<bits/std++.h>
using namespace std;

int Random(int lower, int upper){

    int num = (rand() % (upper - lower + 1)) + lower;
    return num;
        
}

