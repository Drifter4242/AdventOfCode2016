lines = File.readlines("day6input.txt");
#lines = File.readlines("day6input_test.txt");

for i in 0..(lines[0].length-1)
	chars = Array.new(256) {0}
	for line in lines
		chars[line[i].ord] += 1
	end

	count = 0
	c = 0
	for j in 0..255
		if chars[j] > count
			count = chars[j]
			c = j
		end	
	end

	print(c.chr);
end
