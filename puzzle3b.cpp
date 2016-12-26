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
	int x, y, z;
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

void print_move(Move& m)
{
	printf("%i %i %i\n", m.x, m.y, m.z);
}

void print_moves(vector<Move>& moves)
{
	printf("Moves:\n");
	for(std::vector<Move>::iterator it = moves.begin();
		it != moves.end();
		++it)
	{
		print_move(*it);
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

	vector<Move> moves;
	Move m;
	Move m2;
	Move m3;
	while(true)
	{
		if (feof(pFile))
		{
			break;
		}

		fscanf (pFile, " %i %i %i ", &m.x, &m2.x, &m3.x);
		fscanf (pFile, " %i %i %i ", &m.y, &m2.y, &m3.y);
		fscanf (pFile, " %i %i %i ", &m.z, &m2.z, &m3.z);
		moves.push_back(m);
		moves.push_back(m2);
		moves.push_back(m3);

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
/*
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
*/
		//print_state(s);
	}
	return states;
}

int main()
{
	vector<Move> moves = read_moves("day3input.txt");
	//vector<Move> moves = read_moves("day2input_test.txt");
	print_moves(moves);
	
	int valid = 0;

	for(int i = 0; i < moves.size(); i++)
	{
		//print_move(moves[i]);
		if (moves[i].x + moves[i].y <= moves[i].z)
		{
			//printf("HERE %i\n", __LINE__);
			continue;
		}
		if (moves[i].x + moves[i].z <= moves[i].y)
		{
			//printf("HERE %i\n", __LINE__);
			continue;
		}
		if (moves[i].z + moves[i].y <= moves[i].x)
		{
			//printf("HERE %i\n", __LINE__);
			continue;
		}
		valid++;
	}
	printf("Valid %i\n", valid);

//	State s;
//	s.x = 0;
//	s.y = 2;
//	s.rot = 0;

//	vector<State> states = play_moves(moves, s);

//	print_states(states);
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


