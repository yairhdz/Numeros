--
-- system.utility
-- conjunto de funciones para el menejo de los archivos
--

local json  = require "json"
local lfs   = require "lfs"

 
-- La tabla que contendra todos los metodos
utility={}

local function utility.fileExists(fileName, base)
  assert(fileName, "fileName is missing")
  local base = base or system.ResourceDirectory
  local filePath = system.pathForFile( fileName, base )
  local exists = false
 
  if (filePath) then -- file may exist. won't know until you open it
    local fileHandle = io.open( filePath, "r" )
    if (fileHandle) then -- nil if no file found
      exists = true
      io.close(fileHandle)
    end
  end
 
  return(exists)
end

return utility