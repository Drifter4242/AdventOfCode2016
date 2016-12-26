lines = File.readlines("day20input.txt");
#lines = File.readlines("day20input_test.txt");

s="11101000110010100"
len=272
#s="10000"
#len=20

low=[]
high=[]

for line in lines
	if line =~ /(\d*)-(\d*)/
		low.push($1.to_i)
		high.push($2.to_i)
	end
end

ip=0
while(true)
	found = 0
	for i in 0..(low.size() - 1)
		if ip >= low[i] and ip <= high[i]
			found = 1
			ip = high[i]+1
			break
		end
	end
	if found == 0
		break
	end
end

puts(ip)

