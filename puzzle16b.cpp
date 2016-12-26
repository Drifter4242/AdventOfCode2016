#include <stdio.h>
#include <stdlib.h>
#include <string>


using namespace std;

int main()
{


	string s="11101000110010100";
	int len=35651584;
	//string s="10000";
	//int len=20;


	while (s.length() < len)
	{
		string b="";
		for(int i=s.length()-1;i>=0;i--)
		{	
			if (s.at(i) == '0')
			{
				b += "1";
			}
			else
			{
				b += "0";
			}
		}

		s=s + "0" + b;
		printf("%i\n", s.length());
		//printf("%s\n", s.c_str());
	}

	s.resize(len);

	while (s.length() % 2 == 0)
	{
		string b = "";
		int i = 0;
		while (i < s.length())
		{
			if (s.at(i) == s.at(i+1))
				b += "1";
			else
				b += "0";
			
			i+=2;
		}
		s = b;
		printf("%i\n", s.length());
		//printf("%s\n", s.c_str());
	}

	printf("%s\n", s.c_str());
	return 0;
}
