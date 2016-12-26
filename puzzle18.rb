require 'digest'

#s="..^^."
#rows=3
#s=".^^.^.^^^^"
#rows=10
s="^.....^.^^^^^.^..^^.^.......^^..^^^..^^^^..^.^^.^.^....^^...^^.^^.^...^^.^^^^..^^.....^.^...^.^.^^.^"
rows=40

count = 0
for x in 0..(s.length-1)
	if s[x] == "."
		count += 1
	end
end

puts(s)

for i in 2..rows

	t=""
	for x in 0..(s.length-1)
		if x==0
			a="."
		else
			a=s[x-1]
		end
		b=s[x]
		if x==s.length-1
			c="."
		else
			c=s[x+1]
		end
		d="."
		if a=="^" and c=="."
			d="^"
		elsif a=="." and c=="^"
			d="^"
		end
		t+=d
	end

	puts(t);
	s=t
	for x in 0..(s.length-1)
		if s[x] == "."
			count += 1
		end
	end
end
puts(count)

