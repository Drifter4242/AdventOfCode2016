#lines = File.readlines("day12input.txt");
#lines = File.readlines("day12input_test.txt");

s=1350
rx=31
ry=39

#s=10
#rx=7
#ry=4

walls = Array.new(1002) { Array.new(1002) {-1} }

for y in 0..1000
	for x in 0..1000
		t = (x*x + 3*x + 2*x*y + y + y*y + s)
		bits = 0
		while t != 0
			if t % 2 == 1
				bits += 1
				t -= 1
			end
			t = t / 2
		end
		#puts("%i %i %i\n",x,y,bits)
		if bits % 2 == 1
			walls[x][y] = -2
		end
	end
end

#for y in 0..10
#	for x in 0..10
#		printf("%i,",walls[x][y])
#	end
#	printf("\n");
#end

step=0
count = 1
while(step<100)

walls[1][1] = 0
for x in 0..1000
	for y in 0..1000
		if walls[x][y] == -1
			if	walls[x-1][y] == step or
				walls[x][y-1] == step or
				walls[x+1][y] == step or
				walls[x][y+1] == step
				walls[x][y] = step+1
				
				count += 1
			end
		end
	end
	printf("\r%i\r", step);
end
step += 1
if step == 50
	puts(count)
	exit(0)
end
end


#for y in 0..10
#	for x in 0..10
#		printf("%i,",walls[x][y])
#	end
#	printf("\n");
#end
