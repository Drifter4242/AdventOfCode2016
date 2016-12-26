lines = File.readlines("day9input.txt");
#lines = File.readlines("day9input_test.txt");

input = lines.join("")
def decomp(input)
output = 0
while(true)
	if input =~ /(.*?)\((\d*)x(\d*)\)(.*)/
#		puts $1
#		puts $2
#		puts $3
#		puts $4
		output += $1.length

		inner = $4[0..($2.to_i - 1)]

		res = decomp(inner)

		output += res * $3.to_i 
		input = $4[($2.to_i)..-1]
	else
		output += input.length
		break
	end
end
return output
end
output = decomp(input)
puts(output)
#puts(output.length)
