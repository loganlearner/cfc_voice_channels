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

    self.List:AddLine("1", "#yeetus", "5", "true") -- TODO: actual list of channels =^)

    function self.List:DoDoubleClick(lineID, line)
        -- TODO: Open channel view
    end
end

vgui.Register("cfc_voice_main_derma", Panel)

net.Receive("okiHereYouGo", function(len)
    local tbl = net.ReadTable()

    cfc_voice.Channels = tbl
end)