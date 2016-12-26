lines = File.readlines("day10input.txt");
#lines = File.readlines("day10input_test.txt");

bothas = Array.new(2000) {[]}
botgives = Array.new(1000) {Array.new(2) {-1}}

for line in lines
	if line =~ /bot (\d*) gives low to (.*) (\d*) and high to (.*) (\d*)/
		low = $3.to_i
		high = $5.to_i
		if $2 != "bot"
			low += 1000
		end
		if $4 != "bot"
			high += 1000
		end
		botgives[$1.to_i][0] = low
		botgives[$1.to_i][1] = high
	elsif line =~ /value (\d*) goes to bot (\d*)/
		bothas[$2.to_i].push($1.to_i)
	end
end

while(true)
	actions=0
	for i in 0..999
		if bothas[i].length == 2 and
			botgives[i][0] != -1 and
			bothas[botgives[i][0]].length < 2 and
			bothas[botgives[i][1]].length < 2
			
			low = bothas[i][0]
			high = bothas[i][1]
			bothas[i] = []
			if low > high
				t=low
				low=high
				high=t
			end

			glow = botgives[i][0]
			ghigh = botgives[i][1]

			if low == 17 and high == 61
				puts(i)
			end

			bothas[glow].push(low)
			bothas[ghigh].push(high)
			actions+= 1

		end
	end

	if actions == 0
		break
	end
end

