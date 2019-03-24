local Panel = {}

function Panel:Init()
    self.Main = vgui.Create("DFrame", Panel)
    self.Main:SetSize(300,500)
    self.Main:Center()
    self.Main:MakePopup()

    self.List = vgui.Create("DListView", self.Main)
    self.List:Dock(FILL)
    self.List:SetMultiSelect(false)
    self.List:AddColumn("Index")
    self.List:AddColumn("Owner")
    self.List:AddColumn("Channel")
    self.List:AddColumn("Users")
    self.List:AddColumn("Locked")

    timer.Simple(0.1, function()
        for index, channel in pairs(cfc_voice.Channels) do
            self.List:AddLine(tostring(index), channel.OwnerName, channel.Name, tostring(table.Count(channel.Users)), tostring(channel.IsProtected))
        end
    end)

    function self.List:DoDoubleClick(lineID, line)
        -- TODO: Open channel view
    end
end

vgui.Register("cfc_voice_main_derma", Panel)

net.Receive("okiHereYouGo", function(len)
    local tbl = net.ReadTable()

    cfc_voice.Channels = tbl
end)