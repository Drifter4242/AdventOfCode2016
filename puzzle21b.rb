lines = File.readlines("day21input.txt");
#lines = File.readlines("day21input_test.txt");

#s="decab"
s="fbgdceah"
#not efdgachb

for q in (lines.size()-1).downto(0)
	line = lines[q]
	if line =~ /swap position (\d*) with position (\d*)/
		x=$1.to_i
		y=$2.to_i
		t=s[x]
		s[x] = s[y]
		s[y] = t
	elsif line =~ /swap letter (.) with letter (.)/
		x=s.index($1)
		y=s.index($2)
		t=s[x]
		s[x] = s[y]
		s[y] = t
	elsif line =~ /rotate (.*) (\d*) step/
		x=$2.to_i
		for x in 0..x-1
			if $1 == "right"
				s1 = s[0,1]
				s2 = s[1,s.length-1]
				s = s2 + s1
			else
				s1 = s[0,s.length-1]
				s2 = s[s.length-1,1]
				s = s2 + s1
			end
		end
	elsif line =~ /rotate based on position of letter (.)/
		x=s.index($1)
		map = []
		map[1]=1
		map[3]=2
		map[5]=3
		map[7]=4
		map[2]=6
		map[4]=7
		map[6]=8
		map[0]=9

		x=map[x]

		for x in 0..x-1
			s1 = s[0,1]
			s2 = s[1,s.length-1]
			s = s2 + s1
		end
	
	elsif line =~ /reverse positions (.) through (.)/
		x=$1.to_i
		y=$2.to_i
		s1 = s[0,x]
	 	s2 = s[x,y-x+1]
		s3 = s[y+1,s.length - y+1]
		s2.reverse!
		s = s1 + s2 + s3
	elsif line =~ /move position (\d*) to position (\d*)/
		y=$1.to_i
		x=$2.to_i
		s1 = s[0,x]
		s2 = s[x,1]
		s3 = s[x+1,s.length - x+1]
		s = s1 + s3
		s1 = s[0,y]
		s3 = s[y,s.length - y]
		s = s1 + s2 + s3
	end
	puts(s)
end
puts(s)
