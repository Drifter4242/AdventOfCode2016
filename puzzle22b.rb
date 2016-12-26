lines = File.readlines("day22input.txt");
#lines = File.readlines("day22input_test.txt");

#s="decab"
s="fbgdceah"
#not efdgachb

nodes = []
viable = 0

ar = Array.new(30) {Array.new(35)}

for line in lines
	if line =~/.dev.grid.node-x(\d+)-y(\d+)\s+(\d+)T\s+(\d+)T\s+(\d+)T/
		node = {}
		node["x"] = $1.to_i
		node["y"] = $2.to_i
		node["size"] = $3.to_i
		node["used"] = $4.to_i
		node["g"] = 0
		#node["avail"] = $5.to_i
		nodes.push(node)
		ar[node["x"]][node["y"]] = node
	end
end

ar[29][0]["g"] = 1

#for i in 0..(nodes.size()-1)
#	for j in 0..(nodes.size()-1)
#		a=nodes[i]
#		b=nodes[j]
#		if a["used"] != 0 and
#			i!=j and
#			a["used"] <= b["avail"]
#			viable+=1
#		end
#	end
#end

#for y in 0..34
#	for x in 0..29
#		printf("%03d,%03d ", ar[x][y]["used"], ar[x][y]["size"])
#	end
#	printf("\n");
#end

def findg(nodes)
	for node in nodes
		if node["g"] == 1
			return node
		end
	end
end

def findzero(nodes)
	for node in nodes
		if node["used"] == 0
			return node
		end
	end
end

def get(ar, node,x,y)
	x = node["x"]+x
	y = node["y"]+y
	if x >= 0 and x <= 29 and y >= 0 and y <= 34
		return ar[x][y]
	end
	printf("Out of range %i %i\n",x,y);
	exit(0);
end

$moves = 0
def move(src, dst)
	if dst["used"] == 0 and dst["size"] >= src["used"]
		dst["used"] = src["used"]
		src["used"] = 0
		r=dst["g"]
		dst["g"] = src["g"]
		src["g"] = r
		$moves +=1
		return false
	end
	printf("Failed to move\n")
	puts(src)
	puts(dst)
	return true
end

def movedir(ar, nodes, x,y)
	node = findzero(nodes)
	src = get(ar,node,x,y)
	return move(src,node)
end


puts(findg(nodes))
puts(findzero(nodes))
while (findzero(nodes)["y"] != 0)
	if (movedir(ar, nodes, 0,-1))
		if (movedir(ar,nodes,-1,0))
			puts(findzero(nodes))
			exit(1)
		end
	end
	puts(findzero(nodes))
end

while true
	g = findg(nodes)["x"]
	while (findzero(nodes)["x"] != g)
		if (movedir(ar, nodes, 1,0))
			puts(findzero(nodes))
			exit(1)
		end
		puts(findzero(nodes))
	end
	if g == 1
		break
	end
	if movedir(ar, nodes, 0, 1)
		exit(1)
	end
	while (findzero(nodes)["x"] != g-2)
		if (movedir(ar, nodes, -1,0))
			exit(1)
		end
	end
	if movedir(ar, nodes, 0, -1)
		exit(1)
	end
end
		
puts(findzero(nodes))
puts(findg(nodes))
#puts(viable)
puts($moves)

