lines = File.readlines("day7input.txt");
#lines = File.readlines("day7input_test2.txt");

count = 0
for line in lines
	found = []
	bracket = 0
	bfound = []
	puts(line)
	for i in 0..(line.length - 4)
		if line[i] == "["
			bracket = 1
		end
		if line[i] == "]"
			bracket = 0
		end
		if (line[i] == line[i+2] and
		   	line[i] != line[i+1])
			if bracket == 0
				found.push(line[i..i+2])
			else
				bfound.push(line[i..i+2])
			end
		end
	end

	ssl = 0
	for a in found
		for b in bfound
			if a[0] == b[1] and a[1] == b[0]
				ssl = 1
			end
		end
	end


	if ssl == 1
		count += 1
	end
end
puts(count)
