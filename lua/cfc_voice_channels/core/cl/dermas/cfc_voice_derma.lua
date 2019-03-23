local Panel = {}

local function addChannels(parent, passwordProtected, name, ownerName, id)

end

function Panel:Init()
    self.Main = vgui.Create("DFrame", Panel)
    self.Main:SetSize(100,200)
    self.Main:MakePopup()

    self.List = vgui.Create("DListView", Panel)\
    self.List:Dock(FILL)
    self.List:SetMultiSelect(false)
    self.List:AddColumn("#")
    self.List:AddColumn("Channel")
    self.List:AddColumn("Users")
    self.List:AddColumn("Locked")

    for index, channel in pairs(cfc_voice.Channels) do
        self.AddLine(tostring(index), "#"..channel.Name, tostring(table.Count(channel.Users)), tostring(channel.IsProtected))
    end

    function self.List:DoDoubleClick(lineID, line)
        -- TODO: Open channel view
    end
end

vgui.Register("cfc_voice_main_derma", Panel)

net.Receive("okiHereYouGo", function(len)
    local tbl = net.ReadTable()

    cfc_voice.Channels = tbl
end)