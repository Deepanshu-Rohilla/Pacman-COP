
void resetGame() {
	// audioInGame.loop('pacman_beginning.wav');
	setState = [&a]() {
		playerPosition = numberInRow * 14 + 1;
		for(int i=0;i<widget.numberOfGhosts;i++){
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
	};
}

map<string,int> dir = {{"left",0},
					{"right",1},
					{"up",2},
					{"down",3}};

auto generateCell(int index) {
	if (mouthClosed && index == playerPosition) {
		return Padding();
	} else if (index == playerPosition) {
		switch (playerDirection) {
			case dir["left"]:
			return Transform.rotate(
				angle: pi,
				child: Movables(playerImage),
			);
			break;
			case dir["right"]:
			return Movables(playerImage);
			break;
			case dir["up"]:
			return Transform.rotate(
				angle: 3 * pi / 2,
				child: Movables(playerImage),
			);
			break;
			case dir["down"]:
			return Transform.rotate(
				angle: pi / 2,
				child: Movables(playerImage),
			);
			break;
			default:
			return Movables(playerImage);
		}
	} else if (index == positionOfMovables[0]) {
		return Movables(imagePath[0]);
	} else if (index == positionOfMovables[1] && widget.numberOfGhosts>1) {
		return Movables(imagePath[1]);
	} else if (index == positionOfMovables[2] && widget.numberOfGhosts>2) {
		return Movables(imagePath[2]);
	} else if (barriers.contains(index)) {
		return MazeCell();
	} else if (preGame || foodAvailable.contains(index)) {
		return Path();
	} else {
		return Path();
	}
}
