local Panel = {}

function Panel:Init()
    self.Main = self:GetParent()
    self.MainPanel = vgui.Create("DPanel", self.Main)
    self.MainPanel:Dock(FILL)
    self.MainPanel:SetBackgroundColor(Color(255, 255, 255, 0))

    self.List = vgui.Create("DListView", self.MainPanel)
    self.List:Dock(FILL)
    self.List:SetMultiSelect(false)
    self.List:SetSortable(false)

    --TODO: Sizing for columns
    self.List:AddColumn("")
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
        cfc_voice.selectedChannel = cfc_voice.Channels[lineID]
        vgui.Create("channel_view", self:GetParent())
        self:Remove()
    end

    function self.List:OnRowRightClick(lineID, line)
        -- TODO: right click stuff...
        --  - Admin stuff
        --  - User quick connecting.
        print("Right clicked!") -- debug
    end
end

vgui.Register("channel_list", Panel)

net.Receive("okiHereYouGo", function(len)
    local tbl = net.ReadTable()

    cfc_voice.Channels = tbl
end)