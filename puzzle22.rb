lines = File.readlines("day22input.txt");
#lines = File.readlines("day22input_test.txt");

#s="decab"
s="fbgdceah"
#not efdgachb

nodes = []
viable = 0

a = Array.new(30) {Array.new(35)}

for line in lines
	if line =~/.dev.grid.node-x(\d+)-y(\d+)\s+(\d+)T\s+(\d+)T\s+(\d+)T/
		node = {}
		node["x"] = $1.to_i
		node["y"] = $2.to_i
		node["size"] = $3.to_i
		node["used"] = $4.to_i
		node["avail"] = $5.to_i
		nodes.push(node)
		a[node["x"]][node["y"]] = node
	end
end

for i in 0..(nodes.size()-1)
	for j in 0..(nodes.size()-1)
		a=nodes[i]
		b=nodes[j]
		if a["used"] != 0 and
			i!=j and
			a["used"] <= b["avail"]
			viable+=1
		end
	end

end

puts(viable)

