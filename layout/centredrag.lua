----------------------------------------------------------
--
--  Centredrag
--
--      Note: for now, this is a modified copy of
--      centerwork for awesome-vain, found at
--      https://github.com/vain/awesome-vain
--
----------------------------------------------------------


-- Grab environment.
local tonumber = tonumber
local beautiful = beautiful
local awful = awful
local math = math

module("dim.layout.centredrag")

name = "centredrag"

function arrange(p)

    -- Screen.
    local wa = p.workarea
    local cls = p.clients

    -- Width of main column?
    --local t = awful.tag.selected(p.screen)
    --local mwfact = awful.tag.getmwfact(t)
    
    if #cls == 1
    then
        local g = {}
        g.height = wa.height
        g.width = wa.width
        g.x = wa.x
        g.y = wa.y
        
        cls[1]:geometry(g)
    elseif #cls == 2
    then
        local g = {}
        g.height = wa.height
        g.width = 3*wa.width/4
        g.x = wa.x
        g.y = wa.y
        
        cls[1]:geometry(g)

        local h = {}
        h.height = wa.height
        h.width = wa.width/4
        h.x = wa.x + g.width
        h.y = wa.y

        cls[2]:geometry(h)
    elseif #cls > 2
    then
        local g = {}
        g.height = wa.height
        g.width = wa.width/2
        g.x = wa.x + wa.width/4
        g.y = wa.y
        
        cls[1]:geometry(g)
        
        local Lheight = wa.height / (math.floor((#cls - 1)/2))
        local Rheight = wa.height / (math.floor(#cls/2))

        for i=2, #cls
        do
            local c = cls[i]
            local g = {}
            
            if i%2 == 0
            then
                g.height = Rheight
                g.width = wa.width/4
                g.x = wa.x + 3*wa.width/4
                g.y = wa.y + (i-2)*Rheight/2
            elseif i%2 == 1
            then
                g.height = Lheight
                g.width = wa.width/4
                g.x = wa.x
                g.y = wa.y + (i-3)*Lheight/2
            end

            c:geometry(g)
        end
        
    end
     
    

--[[    if #cls > 0
    then
        -- Main column, fixed width and height.
        local c = cls[#cls]
        local g = {}
        local mainwid = math.floor(wa.width * mwfact)
        local slavewid = wa.width - mainwid
        local slaveLwid = math.floor(slavewid / 2)
        local slaveRwid = slavewid - slaveLwid
        local slaveThei = math.floor(wa.height / 2)
        local slaveBhei = wa.height - slaveThei

        g.height = wa.height - 2 * useless_gap
        g.width = mainwid
        g.x = wa.x + slaveLwid
        g.y = wa.y + useless_gap

        c:geometry(g)

        -- Auxiliary windows.
        if #cls > 1
        then
            local at = 0
            for i = (#cls - 1),1,-1
            do
                -- It's all fixed. If there are more than 5 clients,
                -- those additional clients will float. This is
                -- intentional.
                if at == 4
                then
                    break
                end

                c = cls[i]
                g = {}

                if at == top_left
                then
                    -- top left
                    g.x = wa.x + useless_gap
                    g.y = wa.y + useless_gap
                    g.width = slaveLwid - 2 * useless_gap
                    g.height = slaveThei - useless_gap
                elseif at == top_right
                then
                    -- top right
                    g.x = wa.x + slaveLwid + mainwid + useless_gap
                    g.y = wa.y + useless_gap
                    g.width = slaveRwid - 2 * useless_gap
                    g.height = slaveThei - useless_gap
                elseif at == bottom_left
                then
                    -- bottom left
                    g.x = wa.x + useless_gap
                    g.y = wa.y + slaveThei + useless_gap
                    g.width = slaveLwid - 2 * useless_gap
                    g.height = slaveBhei - 2 * useless_gap
                elseif at == bottom_right
                then
                    -- bottom right
                    g.x = wa.x + slaveLwid + mainwid + useless_gap
                    g.y = wa.y + slaveThei + useless_gap
                    g.width = slaveRwid - 2 * useless_gap
                    g.height = slaveBhei - 2 * useless_gap
                end

                c:geometry(g)

                at = at + 1
            end

            -- Set remaining clients to floating.
            for i = (#cls - 1 - 4),1,-1
            do
                c = cls[i]
                awful.client.floating.set(c, true)
            end
        end
    end
    --]]
end
