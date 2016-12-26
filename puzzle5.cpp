#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <vector>
#include <algorithm>

using namespace std;

enum DIR {
	UP,
	RIGHT,
	DOWN,
	LEFT,
	END
};

struct Move {
	char name[256];
	int id;
	char checksum[6];
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
	L",
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
	printf("%s %i %s\n", m.name, m.id, m.checksum);
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
	int state = 0;
	int i = 0;
	int c;
	while(true)
	{	
		c = fgetc(pFile);
		if (feof(pFile))
		{
			break;
		}

		if (state == 0)
		{
			if (strchr("abcdefghijklmnopqrstuvwxyz-", c) != NULL)
			{
				//printf("HERE %i, %c\n", __LINE__, (char)c);
				m.name[i] = c;
				i++;
			}
			if (strchr("0123456789", c) != NULL)
			{
				//printf("HERE %i, %c\n", __LINE__, (char)c);
				m.name[i] = 0;
				i = 0;
				state = 1;
				m.id = 0;
			}
		}

		if (state == 1)
		{
			if (c == '[')
			{
				//printf("HERE %i, %c\n", __LINE__, (char)c);
				state = 2;
			}
			else
			{
				//printf("HERE %i, %c\n", __LINE__, (char)c);
				m.id = m.id * 10 + (c - '0');
			}
		}

		if (state == 2)
		{
			if (c == '[')
			{
				// Ignore
			}
			else if (c == ']')
			{
				//printf("HERE %i, %c\n", __LINE__, (char)c);
				state = 0;
				m.checksum[i] = 0;
				moves.push_back(m);
				i = 0;
			}
			else
			{
				//printf("HERE %i, %c\n", __LINE__, c);
				m.checksum[i] = c;
				i++;
			}
		}


		//fscanf (pFile, " %i %i %i ", &m.x, &m2.x, &m3.x);

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

struct Check {
	int i;
	int count;
};

bool sortfunction (Check i,Check j) {
       return (i.count>j.count);
}

vector<State> play_moves(vector<Move>& moves, State& s)
{
	printf("Play Moves:\n");
	int valid = 0;
	int sum_id = 0;
	vector<State> states;
	for(std::vector<Move>::iterator it = moves.begin();
		it != moves.end();
		++it)
	{
		vector<Check> checks;
		checks.clear();
		for(int i = 0; i < 256; i++)
		{
			Check check;
			check.i = i;
			check.count = 0;
			checks.push_back(check);
		}

		for(int j =0; it->name[j] != 0; j++)
		{
			checks[it->name[j]].count++;
		}
		
		checks['-'].count = 0;

		vector<Check> unsorted_checks = checks;

		sort(checks.begin(), checks.end(), sortfunction);
		
		int found;
	       	found = 1;
		for(int j = 0; it->checksum[j] != 0; j++)
		{
			//printf("%i %i\n", unsorted_checks[it->checksum[j]].count, checks[j].count);
			if (unsorted_checks[it->checksum[j]].count != checks[j].count)
			{
				found = 0;
			}
		}

		//printf("Found %i\n", found);
		if (found == 1)
		{
			valid++;
			sum_id += it->id;

			for(int j = 0; it->name[j] != 0; j++)
			{
				if (it->name[j] == '-')
				{
					it->name[j] = ' ';
				}
				else
				{
					int i = it->name[j];
					i = ((i -'a') + it->id) % ('z' - 'a' + 1);
					it->name[j] = i + 'a';
				}
			}

			if (strstr(it->name, "north"))
			{
				printf("Answer %i\n", it->id);
			}

		}


		//for(int i = 0; i < checks.size(); i++)
		//{
		//	printf("%c %i\n", (char)checks[i].i, checks[i].count);
		//}
	}

	return states;
}

int main()
{
	vector<Move> moves = read_moves("day4input.txt");
	//vector<Move> moves = read_moves("day4input_test.txt");
	print_moves(moves);
	State s;
	play_moves(moves, s);
//	int valid = 0;

//	for(int i = 0; i < moves.size(); i++)
//	{
		//print_move(moves[i]);
/*		if (moves[i].x + moves[i].y <= moves[i].z)
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
*/
//	}
//	printf("Valid %i\n", valid);

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


