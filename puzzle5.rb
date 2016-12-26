require 'digest'

#s = "abc";
s = "ojvtpuvg";
i = 1;
#i = 3231929;
pw = "";
while true do
	output = Digest::MD5.hexdigest "#{s}#{i}"
	#puts(i);
	if output.start_with?("00000")
		pw = pw + output[5];
		puts(pw);
		if pw.length == 8
			exit(1)
		end
	end
	i = i + 1
end
