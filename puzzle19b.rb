require 'digest'

#s=5
s=3014387

m=[]

for i in 1..s
	elf = {}
	elf["p"] = 1
	elf["i"] = i
	m.push(elf)
end

while m.size > 1
	i=0
	while i<m.size()
		k = m[i]["i"]
		if m[i]["p"] == 0
			#skip
		elsif m.size % 2 == 0
			d = (m.size / 2) + i
			d = d % m.size
		else
			d = ((m.size+1) / 2) + i - 1
			d = d % m.size
		end

		m[i]["p"] += m[d]["p"]
		m[d]["p"] = 0 
		m.delete_at(d)
		if d>i
			i+=1
		end
		if m.size() % 1000 == 0
		printf("\r%i \r", m.size())
		end
	end
end

puts("")
puts(m[0]["i"])

