cfc_voice = cfc_voice or {}

if SERVER then
    AddCSLuaFile()

    include( "cfc_voice_channels/core/sv/sv_init.lua" )
end

if CLIENT then
    include( "cfc_voice_channels/core/cl/cl_init.lua" )
end