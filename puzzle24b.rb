lines = File.readlines("day24input.txt");
#lines = File.readlines("day24input_test.txt");
lines.each{ |line| line.chomp! } #Remove newlines

count = 0

m = Array.new(lines[0].length) { Array.new(lines.size()) {-1} }


def find(lines, c)
	c=c.to_s
	for x in 0..lines[0].length-1
		for y in 0..lines.size-1
			if lines[y][x] == c
				return x,y
			end
		end
	end
	return false
end

while find(lines, count) != false
	count+=1
end

def findstep(lines,s,e)
	m = Array.new(lines[0].length) { Array.new(lines.size()) {-1} }

	step=0
	sx,sy=find(lines,s)
	m[sx][sy]=step
	found = 1
	while(found==1)
		found = 0
		lstep = step
		step +=1
		for x in 0..lines[0].length-1
			for y in 0..lines.size-1
				if lines[y][x] != "#" and m[x][y] == -1
					if m[x+1][y] == lstep or
						m[x-1][y] == lstep or
						m[x][y-1] == lstep or
						m[x][y+1] == lstep
						if lines[y][x] == e.to_s
							return step
						else
							found = 1
							m[x][y]=step
						end
					end
				end
			end
		end

	end

	puts("Not found")
	for y in 0..lines.size-1
		for x in 0..lines[0].length-1
			printf("%i ", m[x][y]);
		end
		printf("\n")
	end
	exit(1)

end


d = Array.new(count) { Array.new(count) {0} }
for s in 0..count-1
	for e in 0..count-1
		if s==e
			next
		end
		d[s][e] = findstep(lines,s,e)
	end
end


for s in 0..count-1
	for e in 0..count-1
		printf("%i ",d[s][e])
	end
	printf("\n")
end

paths = []
paths.push( { "p"=>[0], "d"=>0} )


while(true)
	#puts("Paths")
	#puts(paths)
	printf("%i, %i   \r",paths.size, paths[0]["d"])
	found = 0
	for i in 0..count-1
		if paths[0]["p"].include? i
			found+=1
		end
	end
	if found == count
		break
	end
	for i in 0..count-1
		p = paths[0]["p"]
		if p.include? i
			next
		end
		nd = paths[0]["d"] + d[p[-1]][i]
		p = p.clone
		p.push(i)
		paths.push( { "p"=>p, "d"=>nd } )
	end
	paths.delete_at(0)
	paths.sort! { |x,y| (x["d"] + d[x["p"][-1]][0]) - (y["d"] + d[y["p"][-1]][0])}

end
puts("Path     ")
puts(paths[0]["p"])
puts("Answer")
puts(paths[0]["d"]+ d[paths[0]["p"][-1]][0])


