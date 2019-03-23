function cfc_voice:FetchChannels()
    net.Start("gimmeChannelsPls")
    net.SendToServer()
end

concommand.Add("cfc_open_voice_channels", function()
    cfc_voice:FetchChannels()
    vgui.Create("cfc_voice_main_derma")
end)

concommand.Add("cfc_create_voice_channel", function(ply, cmd, args)

end)

concommand.Add("cfc_voice_disconnect", function()

end)

concommand.Add("cfc_voice_connect", function(ply, cmd, args)

end)