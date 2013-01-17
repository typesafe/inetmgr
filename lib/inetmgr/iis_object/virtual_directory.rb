module Inetmgr
  class VirtualDirectory < IisObject

	prop :path, "path"
	prop :physical_path, :physicalPath
end
end