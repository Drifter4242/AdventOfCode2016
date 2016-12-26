require 'digest'

class String
  def numeric?
    Float(self) != nil rescue false
  end
end

#s = "abc";
s = "ojvtpuvg";
i = 1;
#i = 3231929;
pw = "________";
while true do
	output = Digest::MD5.hexdigest "#{s}#{i}"
	#puts(i);
	if output.start_with?("00000")
		if (output[5].numeric? and
			output[5].to_i < 8 and
		   	pw[output[5].to_i] == '_')
			pw[output[5].to_i] = output[6];
			#puts(output)
		end
		print(pw + "\r");
		if !pw.include?("_")
			exit(1)
		end
	end
	i = i + 1
end
