class GameScreen :: StatefulWidget {
	int numberOfGhosts;
	int movementSpeed;
	int numberOfPlayers;
	int playerNumber;
	int mazeDiffculty;
	GameScreen(this.numberOfGhosts, this.movementSpeed, this.numberOfPlayers, this.playerNumber,this.mazeDiffculty);
public:
	GameScreen();
	~GameScreen();
	override _GameScreenState createState() => _GameScreenState();
};

class _GameScreenState :: State<GameScreen> {
	static int numberInRow = 11;
	int numberOfSquares = numberInRow * 16;
	int playerPosition = numberInRow * 14 + 1;
	String playerDirection = "right";
	String playerImage = "lib/images/pacman.png";
	List<int> positionOfMovables = [ numberInRow * 2 - 2, numberInRow * 9 - 1, numberInRow * 11 - 2];
	List<String> directionOfMovement = ["left", "left", "down"];
	List<String> imagePath = ["lib/images/red.png", "lib/images/yellow.png", "lib/images/cyan.png"];

	// Index 0 : Pacman (Player)
	// Index 1 : Blinky (Red)
	// Index 2 : Clyde (Yellow)
	// Index 3 : Inky (Green/Cyan)
	List<int> foodAvailable;
	bool preGame = true;
	bool mouthClosed = false;
	auto controller;
	int score = 0;
	bool paused = false;
	List<int> barriers;

	void initState() {
		// TODO: implement initState
		auto rand = Random();
		int maze = rand.nextInt(4);
		barriers = gameBarriers[ (widget.mazeDiffculty-1)*5+ maze];
	}

}

  void getFood(){
    for (int i = 0; i < numberOfSquares; i++)
      if (!barriers.contains(i)) {
        foodAvailable.add(i);
      }
  }