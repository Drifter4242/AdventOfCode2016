require 'digest'

#s="abc"
s="yjdafjpo"

i = 1
c = 0
while true do
	output = Digest::MD5.hexdigest "#{s}#{i}"
	for p in 1..2016
		output = Digest::MD5.hexdigest output
	end
	#puts(i);
	
	found = 0
	for j in 0..(output.size()-1-2)
		if output[j] == output[j+1] and
			output[j] == output[j+2]

			for x in (i+1)..(1000+i)
				out = Digest::MD5.hexdigest "#{s}#{x}"
				for p in 1..2016
					out = Digest::MD5.hexdigest out
				end
				for k in 0..(output.size()-5)
					if output[j] == out[k] and
						out[k] == out[k+1] and
						out[k] == out[k+2] and
						out[k] == out[k+3] and
						out[k] == out[k+4]
						found = 1
						break
					end
				end
			end
			# only consider first triplet
			break
		end
	end
	printf("\r%i,%i\r",c,i)
	if found == 1
		puts(i);
		c += 1
		if c == 64
			puts(i)
			exit(0)
		end
	end
	i = i + 1
end
