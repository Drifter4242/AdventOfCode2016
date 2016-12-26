lines = File.readlines("day12input.txt");
#lines = File.readlines("day12input_test.txt");

pg = 0
reg = Array.new(4) {0}
rt = {"a"=>0,"b"=>1,"c"=>2,"d"=>3}
reg[2]=1
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
		if rt.has_key?($1)
			reg[rt[$2]] = reg[rt[$1]]
		else
			reg[rt[$2]] = $1.to_i
		end
		pg+=1
	elsif line =~ /inc (.+)/
		reg[rt[$1]] += 1
		pg+=1
	elsif line =~ /dec (.+)/
		reg[rt[$1]] -= 1
		pg+=1
	elsif line =~ /jnz (.+) (.+)/
		i=0
		if rt.has_key?($1)
			i=reg[rt[$1]]
		else
			i=$1.to_i
		end
		if i != 0
			pg += $2.to_i
		else
			pg += 1
		end
	else
		break
	end
	count +=1
#	if count > 20
#		break
#	end
end

puts(reg[0])

