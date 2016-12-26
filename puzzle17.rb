require 'digest'

#s="ihgpwlah"
s="pslxynzg"

paths = []
paths.push({"p"=>"","x"=>0,"y"=>0})

dirs ={}
dirs[0] = {"x"=>0,"y"=>-1,"d"=>"U"}
dirs[1] = {"x"=>0,"y"=>1,"d"=>"D"}
dirs[2] = {"x"=>-1,"y"=>0,"d"=>"L"}
dirs[3] = {"x"=>1,"y"=>0,"d"=>"R"}

mx=3
my=3
while(true)
	newpaths = []
	for path in paths
		i=path["p"]
		output = Digest::MD5.hexdigest "#{s}#{i}"

		for d in 0..3
			if "bcdef".include? output[d] 
				x=dirs[d]["x"] + path["x"]
				y=dirs[d]["y"] + path["y"]
				if x==mx and y==my
					puts(i+dirs[d]["d"])
					exit(0)
				end
				if x>=0 and y>=0 and
					x<=mx and y<=my
					newpath={}
					newpath["p"]=i+dirs[d]["d"]
					newpath["x"]=x
					newpath["y"]=y
					newpaths.push(newpath)
				end
			end
		end
	end

	if newpaths.size == 0
		break
	end
	paths=newpaths
end
