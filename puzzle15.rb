lines = File.readlines("day15input.txt");
#lines = File.readlines("day15input_test.txt");

info = []

for line in lines
	if line =~ /Disc .* has (\d*) positions; at time=(\d*), it is at position (\d*)\./
		d = {}
		d["max"] = $1.to_i
		d["time"] = $2.to_i
		d["pos"] = $3.to_i
		info.push(d)
	end
end

c = 0
while true

	t=c
	bounce=0
	for d in info
		t+=1
		if ((d["pos"] - d["time"] + t + d["max"]) % d["max"]) != 0
			bounce = 1
			break
		end
	end
	if bounce==0
		puts(c)
		break
	end
	c+=1
end

