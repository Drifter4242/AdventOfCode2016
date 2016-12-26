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
	n = []
	for i in 0..(m.size-1)
		if m[i]["p"] == 0
			#skip
		elsif i+1 == m.size
			m[i]["p"] += m[0]["p"]
			m[0]["p"] = 0 
		else
			m[i]["p"] += m[i+1]["p"]
			m[i+1]["p"] = 0 
		end

	end
	for i in 0..(m.size-1)
		if m[i]["p"] != 0
			n.push(m[i])
		end
	end
	m = n
	puts(m.size())
end

puts(m[0]["i"])

