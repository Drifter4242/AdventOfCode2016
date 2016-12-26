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
num=0
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
		nextip = -1
		for i in 0..(low.size()-1)
			if ip < low[i] and (nextip == -1 or nextip >= low[i])
				nextip = low[i]
			end
		end
		
		if nextip == -1
			puts(ip)
			if ip <= 4294967295
				num += (4294967295 - ip + 1)
			end
			break
		end
		num += (nextip - ip)
		printf("%i %i %i\n", ip, nextip, num);
		ip = nextip
	end
end

puts(num)

