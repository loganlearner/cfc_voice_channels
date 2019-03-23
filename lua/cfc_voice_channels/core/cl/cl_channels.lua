local function fetchChannels()
    net.Start("gimmeChannelsPls")
    net.SendToServer()
end

concommand.Add("cfc_open_voice_channels", function(ply, cmd, args)
    fetchChannels()
    vgui.Create("cfc_voice_main_derma")
end)

concommand.Add("cfc_create_voice_channel", function(ply, cmd, args)
    if #args == 2 and isstring(args[1]) and isstring(args[2]) then
        local channelName = args[1]
        local channelPassword = args[2]

        net.Start("iWannaMakeAChannel")
            net.WriteString(channelName)
            net.WriteString(channelPassword)
        net.SendToServer()
    end
end)

concommand.Add("cfc_voice_disconnect", function(ply, cmd, args)

end)

concommand.Add("cfc_voice_connect", function(ply, cmd, args)

end)