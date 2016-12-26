lines = File.readlines("day23input.txt");
#lines = File.readlines("day23input_test.txt");

pg = 0
reg = Array.new(4) {0}
rt = {"a"=>0,"b"=>1,"c"=>2,"d"=>3}
reg[0] = 7
count = 0

while(true)
	if (pg > lines.size())
		break
	end
#	for i in 0..reg.size-1
#		print(i.to_s + "," + reg[i].to_s + " ")
#	end
#	puts("pg," + pg.to_s + "   " + lines[pg])

	line = lines[pg]

	if line =~ /cpy (.+) (.+)/
		if rt.has_key?($2)
			if rt.has_key?($1)
				reg[rt[$2]] = reg[rt[$1]]
			else
				reg[rt[$2]] = $1.to_i
			end
		end
		pg+=1
	elsif line =~ /inc (.+)/
		if rt.has_key?($1)
			reg[rt[$1]] += 1
		end
		pg+=1
	elsif line =~ /dec (.+)/
		if rt.has_key?($1)
			reg[rt[$1]] -= 1
		end
		pg+=1
	elsif line =~ /jnz (.+) (.+)/
		i=0
		if rt.has_key?($1)
			i=reg[rt[$1]]
		else
			i=$1.to_i
		end
		if i != 0
			if rt.has_key?($2)
				pg += reg[rt[$2]]
			else
				pg += $2.to_i
			end
		else
			pg += 1
		end
	elsif line =~ /tgl (.*)/
		if rt.has_key?($1)
			i = pg + reg[rt[$1]]
		else
			i = pg + $1.to_i
		end
		pg+=1
		if i>=0 and i<lines.size()
			tline = lines[i]
			if tline =~ /inc(.*)/
				lines[i] = "dec" + $1
			elsif tline =~ /^\S+(\s+\S+\s*)$/
				lines[i] = "inc" + $1
			elsif tline =~ /^jnz(\s+\S+\s+\S+\s*)$/
				lines[i] = "cpy" + $1
			elsif tline =~ /^\S+(\s+\S+\s+\S+\s*)$/
				lines[i] = "jnz" + $1
			end
		end
		#puts(lines)
		#puts(reg)

	else
		break
	end
	count +=1
#	if count > 20
#		break
#	end
end

puts(reg[0])

