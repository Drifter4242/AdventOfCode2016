lines = File.readlines("day8input.txt");
#lines = File.readlines("day8input_test.txt");

mx = 50
my = 6
#mx = 7
#my = 3
a = Array.new(mx) { Array.new(my) }

def show(a, mx, my)
$count = 0
for y in 0..(my -1)
	for x in 0..(mx -1)
		if a[x][y] == 1
			$count += 1
			print("*")
		else
			print(".")
		end
	end
	print("\n");	
end
end

$count = 0
for line in lines
	if line =~ /rect (\d*)x(\d*)/
		for x in 0..($1.to_i - 1)
			for y in 0..($2.to_i - 1)
				a[x][y] = 1
			end
		end
	elsif line =~ /rotate row y=(\d*) by (\d*)/
		dst = Array.new(mx)
		sx = $2.to_i
		sy = $1.to_i
		for x in 0..mx-1
			src = (x-sx)%mx
			dst[x] = a[src][sy]
		end
		for x in 0..mx-1
			a[x][sy] = dst[x]
		end
	elsif line =~ /rotate column x=(\d*) by (\d*)/
		dst = Array.new(my)
		sx = $1.to_i
		sy = $2.to_i
		for y in 0..my-1
			src = (y-sy)%my
			dst[y] = a[sx][src]
		end
		for y in 0..my-1
			a[sx][y] = dst[y]
		end
	end
	show(a,mx,my)
end

puts($count)
