lines = File.readlines("day9input.txt");
#lines = File.readlines("day9input_test.txt");

input = lines.join("")
output = ""
while(true)
	if input =~ /(.*?)\((\d*)x(\d*)\)(.*)/
#		puts $1
#		puts $2
#		puts $3
#		puts $4
		output += $1

		output += $4[0..($2.to_i - 1)] * $3.to_i 
		input = $4[($2.to_i)..-1]
	else
		output += input
		break
	end
end
puts(output)
puts(output.length)
