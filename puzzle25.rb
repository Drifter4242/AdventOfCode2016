#lines = File.readlines("day25input.txt");
lines = File.readlines("day25input_test.txt");

pg = 0
reg = Array.new(4) {0}
rt = {"a"=>0,"b"=>1,"c"=>2,"d"=>3}
rs = ["a","b","c","d"]
reg[0] = 7
reg[0] = 0
reg[0] = 192
if ARGV[0] != nil
	reg[0] = ARGV[0].to_i
end
input = reg[0]
count = 0

# The asm runs the formula d=a+282*9
# It then divides by 2 and takes the remainder (subtracted from 2)
# Which is effectively binary in reverse:
# So for a = 0 d=282*9=2538=(binary)100111101010
# In reverse this is 010101111001 which is repeated
#
# The closest desired output is 101010101010=(decimal)2730
# And 2730-2538=192
# So set a to 192

while(true)
	if (pg > lines.size())
		break
	end
#	for i in 0..reg.size-1
#		print(rs[i] + "," + reg[i].to_s + " ")
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
	elsif line =~ /exit/
		puts("EXIT")
		exit()
	elsif line =~ /out (.+)/
		if rt.has_key?($1)
			printf("%i,",reg[rt[$1]])
		else
			printf("%i,",$1.to_i)
		end
		count+=1
		if count == 100
			puts("Count Reached")
			puts(input)
			exit()
		end
		pg+=1

	#	for i in 0..reg.size-1
	#		print(rs[i] + "," + reg[i].to_s + " ")
	#	end
	#	puts("pg," + pg.to_s + "   " + lines[pg])

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
#	if count > 20
#		break
#	end
end
puts("EOF")
puts(reg[0])

