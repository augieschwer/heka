--[[

Parses the Nagios log file

--]]

local template = read_config("template")

local msg =
{
	Timestamp   = nil,
	Hostname    = nil,
	Payload     = nil,
	Pid         = nil,
	Severity    = nil,
	Fields      = nil
}

function process_message ()
	local log = read_message("Payload")
	inject_message(msg)
	return 0
end

