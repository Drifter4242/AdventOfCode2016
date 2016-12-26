lines = File.readlines("day7input.txt");
#lines = File.readlines("day7input_test.txt");

count = 0
for line in lines
	found = 0
	bracket = 0
	bfound = 0
	puts(line)
	for i in 0..(line.length - 4)
		if line[i] == "["
			bracket = 1
		end
		if line[i] == "]"
			bracket = 0
		end
		if (line[i] == line[i+3] and
			line[i+1] == line[i+2] and
		   	line[i] != line[i+1])
			if bracket == 0
				found = 1
			else
				bfound = 1
			end
		end
	end

	if found == 1 and bfound == 0
		count += 1
	end
end
puts(count)
