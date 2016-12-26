#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <vector>

using namespace std;

enum DIR {
	UP,
	RIGHT,
	DOWN,
	LEFT,
	END
};

struct Move {
	DIR d;
};

struct State {
	int x, y, rot;
};

struct Position {
	int x, y;
};

Position dir[] = {
	{ 0, 1 },
	{ 1, 0 },
	{ 0, -1 },
	{ -1, 0 },
};

const char* dirsz[] = {
	"U",
	"R",
	"D",
	"L",
	"***\n"
};

char buttons[5][5] = {
	{'0','0','D','0','0'},
	{'0','A','B','C','0'},
	{'5','6','7','8','9'},
	{'0','2','3','4','0'},
	{'0','0','1','0','0'},
};

void print_moves(vector<Move>& moves)
{
	printf("Moves:\n");
	for(std::vector<Move>::iterator it = moves.begin();
		it != moves.end();
		++it)
	{
		printf("%s", dirsz[it->d]);
	}	
	printf("\n");
}

vector<Move> read_moves(const char* pFilename)
{
	FILE* pFile = fopen(pFilename, "rb");

	if (pFile == NULL)
	{
		printf("Failed to open %s\n", pFilename);
		exit(1);
	}

	int c;
	vector<Move> moves;
	Move m;
	while(true)
	{
		c = fgetc(pFile);
		if (feof(pFile))
		{
			break;
		}

		if (c=='R')
		{
			m.d = RIGHT;
			moves.push_back(m);
		}
		else if (c=='L')
		{		
			m.d = LEFT;
			moves.push_back(m);
		}
		else if (c=='U')
		{
			m.d = UP;
			moves.push_back(m);
		}
		else if (c=='D')
		{
			m.d = DOWN;
			moves.push_back(m);
		}
		else if (c=='\n')
		{
			m.d = END;
			moves.push_back(m);
		}
	}

	return moves;
}

void print_state(State& s)
{
	//printf("State x %i, y %i button %c\n", s.x, s.y, buttons[s.y][s.x]);
	printf("%c", buttons[s.y][s.x]);
}

void print_states(vector<State>& states)
{
	for(int i = 0; i < states.size(); i++)
	{
		print_state(states[i]);
	}
}

vector<State> play_moves(vector<Move>& moves, State& s)
{
	vector<State> states;
	for(std::vector<Move>::iterator it = moves.begin();
		it != moves.end();
		++it)
	{
		if (it->d == END)
		{	
			states.push_back(s);
			continue;
		}
		int x = s.x;
		int y = s.y;
		x += dir[it->d].x;
		y += dir[it->d].y;
		if (x < 0)
		{
			x = 0;
		}
		if (x > 4)
		{
			x = 4;
		}
		if (y < 0)
		{
			y = 0;
		}
		if (y > 4)
		{
			y = 4;
		}
		if (buttons[y][x] =='0')
		{
			x=s.x;
			y=s.y;
		}
		s.x=x;
		s.y=y;
		//print_state(s);
	}
	return states;
}

int main()
{
	vector<Move> moves = read_moves("day2input.txt");
	//vector<Move> moves = read_moves("day2input_test.txt");
	print_moves(moves);
	State s;
	s.x = 0;
	s.y = 2;
	s.rot = 0;

	vector<State> states = play_moves(moves, s);

	print_states(states);
/*
	for(int i = 0; i < states.size(); i++)
	{
		for(int j = 0; j < i; j++)
		{
			if (states[i].x == states[j].x &&
				states[i].y == states[j].y)
			{
				//printf("i %i j %i\n", i , j);
				//printf("x %i y %i\n", states[i].x, states[i].y);
				printf("Answer : %i\n", abs(states[i].x) + abs(states[i].y));
				exit(0);
			}
		}
	}
*/
	//print_state(states[statesi.size() - 1]);

	return 0;
}


