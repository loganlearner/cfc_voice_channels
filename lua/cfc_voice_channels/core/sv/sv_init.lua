util.AddNetworkString("gimmeChannelsPls")
util.AddNetworkString("okiHereYouGo")
util.AddNetworkString("iWannaMakeAChannel")
util.AddNetworkString("iWannaJoinPls")
util.AddNetworkString("iLeaveNow")

cfc_voice.Channels = {}

-- sv
include("cfc_voice_channels/core/sv/sv_channel_control.lua")
include("cfc_voice_channels/core/sv/sv_player.lua")

--cl
AddCSLuaFile("cfc_voice_channels/core/cl/cl_init.lua")
AddCSLuaFile("cfc_voice_channels/core/cl/cl_channels.lua")
AddCSLuaFile("cfc_voice_channels/core/cl/dermas/cfc_voice_derma.lua")
AddCSLuaFile("cfc_voice_channels/core/cl/dermas/password_derma.lua")
AddCSLuaFile("cfc_voice_channels/core/cl/dermas/Mini/channel_list.lua")
AddCSLuaFile("cfc_voice_channels/core/cl/dermas/Mini/channel_view.lua")

function cfc_voice:InitializeVoiceChannels()
    MsgN("Initializing cfcVoiceChannels")
end

hook.Add("Initialize", "initialize_cfc_voice_channels", cfc_voice:InitializeVoiceChannels())