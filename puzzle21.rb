lines = File.readlines("day21input.txt");
#lines = File.readlines("day21input_test.txt");

#s="abcde"
s="abcdefgh"

ins=[]


for line in lines
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
			if $1 == "left"
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
		if x>=4
			x+=1
		end
		x+=1
		for x in 0..x-1
			s1 = s[0,s.length-1]
			s2 = s[s.length-1,1]
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
		x=$1.to_i
		y=$2.to_i
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
