#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <vector>

using namespace std;

struct Move {
	int rot;
	int length;
};

void print_moves(vector<Move>& moves)
{
	printf("Moves:\n");
	for(std::vector<Move>::iterator it = moves.begin();
		it != moves.end();
		++it)
	{
		if (it->rot == 1)
		{
			printf("R");
		}
		else
		{
			printf("L");
		}
		printf("%i ", it->length);
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
	m.length = 0;
	while(true)
	{
		c = fgetc(pFile);
		if (feof(pFile))
		{
			break;
		}

		if (c=='R')
		{
			m.rot = 1;
		}
		else if (c=='L')
		{
			m.rot = -1;
		}
		else if (strchr("0123456789", c) != NULL)
		{
			m.length = (m.length * 10) + (c - (int)'0');
		}
		else if (c==',')
		{
			moves.push_back(m);
			m.length = 0;
		}
	}
	moves.push_back(m);

	return moves;
}

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

void print_state(State& s)
{
	printf("State x %i, y %i rot %i\n", s.x, s.y, s.rot);
}

vector<State> play_moves(vector<Move>& moves, State& s)
{
	vector<State> states;
	states.push_back(s);
	for(std::vector<Move>::iterator it = moves.begin();
		it != moves.end();
		++it)
	{
		s.rot = (s.rot + it->rot + 4) % 4;
		for(int i = 0; i < it->length;i++)
		{
			s.x += dir[s.rot].x;
			s.y += dir[s.rot].y;
			states.push_back(s);
			//print_state(s);
		}
	}
	return states;
}

int main()
{
	vector<Move> moves = read_moves("day1input.txt");
	print_moves(moves);

	State s;
	s.x = 0;
	s.y = 0;
	s.rot = 0;

	vector<State> states = play_moves(moves, s);

	//print_state(s);

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

	//print_state(states[statesi.size() - 1]);

	return 0;
}


