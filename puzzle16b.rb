#lines = File.readlines("day15input.txt");
#lines = File.readlines("day15input_test.txt");

s="11101000110010100"
len=35651584
#s="10000"
#len=20


while s.length < len
	b = s.reverse
	for i in 0..(b.size - 1)
		if b[i] == "0"
			b[i] = "1"
		else
			b[i] = "0"
		end
	end

	s=s + "0" + b
	puts(s.length)
end

s=s[0..(len-1)]
puts(s.length)


while s.length % 2 == 0
	b = ""
	i = 0
	while i < s.length
		if s[i] == s[i+1]
			b += "1"
		else
			b += "0"
		end
		i+=2
	end
	s = b
	puts(s.length)
end

puts(s)
