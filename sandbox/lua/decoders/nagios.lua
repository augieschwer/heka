--[[

Parses the Nagios log file

Here's the grammar I have so far that's tested with http://lpeg.trink.com/

Input: "[1398461360] SERVICE ALERT: example.com"
Result: "1398461360" , "example.com"

local l = require 'lpeg'
l.locale(l)

local nilvalue        = l.P"-"
local printusascii    = l.R"!~"

local unix_date = l.digit^1
local hostname = nilvalue + printusascii^-255

grammar = "[" * l.C( unix_date ) * "] SERVICE ALERT: " * l.C( hostname )

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

