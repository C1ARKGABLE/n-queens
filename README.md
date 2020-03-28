# n-queens in Julia
This is a simple solution to the [n-Queens](https://en.wikipedia.org/wiki/N_queens) problem in [Julia](https://en.wikipedia.org/wiki/Julia_(programming_language)).

### What is the n-Queens problem?

Given an n by n chessboard and n Queens, that can attack vertically, horizontally, and diagonally. How can these Queens be placed on the board such that no Queens are threatened. 

Here is a solution to the n-Queens problem where n = 4.

&nbsp;|&nbsp;|Q|&nbsp;|
-|-|-|-
Q|&nbsp;|&nbsp;|&nbsp;
&nbsp;|&nbsp;|&nbsp;|Q
&nbsp;|Q|&nbsp;|&nbsp;


### Why n-Queens problem?
For a class assignment, I are working with simple search algorithms. This is an implementation of a [Hill Climbing Search](https://en.wikipedia.org/wiki/Hill_climbing). After learning how Hill Climbing Search works, I've be asked to implement it in a coding language of my choice.

### What is Hill Climbing Search?
Hill Climbing Search is a simple search algorithm that finds local minima or maxima in a problem. Here I use the Hill Climbing Search algorithm to evaluate the best move of the n-Queens problem. The score of a tile is the amount of threatening Queens present for that tile. The tile with the lowest score is picked as the placement point for a Queen. The Queen is moved and the search restarts. When a local minima is reached (e.g. the score of the previous run is the same as the current score), the board and Queens locations are shuffled randomly.

### Why Julia?
Honestly, I could have picked [any programming language](https://en.wikipedia.org/wiki/List_of_programming_languages) (Like, all the way down to [assembly](https://en.wikipedia.org/wiki/Assembly_language)... It'd be fast 🖥💨). I was curious to learn Julia, as it has been on my radar for a while as a efficient addition to [Python](https://en.wikipedia.org/wiki/Python_(programming_language)), my native language. So, why not Julia?

#### Breakdowns: