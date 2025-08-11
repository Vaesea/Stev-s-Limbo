local figure8Active = false
local arrowOffsets = {}
local time = 0
local bpmMult = 1

-- Customize these:
local sizeX = 150         -- Width of figure-8
local sizeY = 80         -- Height of figure-8
local rotAmount = 90     -- Max rotation (degrees)
local speed = 2          -- Time speed multiplier

function onCreatePost()
    -- Save ACTUAL strumLineNotes positions manually
    for i = 0, 7 do
        local x = getPropertyFromGroup("strumLineNotes", i, "x")
        local y = getPropertyFromGroup("strumLineNotes", i, "y")
        arrowOffsets[i] = {x = x, y = y}
    end
end

function onEvent(name, value1, value2)
    if name == "ArrowFigure8" then
        if value1 == "on" then
            figure8Active = true
            bpmMult = tonumber(value2) or 1
        elseif value1 == "off" then
            figure8Active = false
            -- Restore all arrows to their original saved positions
            for i = 0, 7 do
                if arrowOffsets[i] then
                    setPropertyFromGroup("strumLineNotes", i, "x", arrowOffsets[i].x)
                    setPropertyFromGroup("strumLineNotes", i, "y", arrowOffsets[i].y)
                    setPropertyFromGroup("strumLineNotes", i, "angle", 0)
                    -- Removed scale reset lines
                end
            end
        end
    end
end

function onUpdatePost(elapsed)
    if not figure8Active then return end

    time = time + elapsed * bpmMult * (curBpm / 60)

    for i = 0, 7 do
        local offset = (i % 4) * (math.pi / 2) -- offset for 1/4 beat shift
        local t = time + offset

        local x = math.sin(t) * sizeX
        local y = math.sin(t) * math.cos(t) * sizeY
        local angle = math.sin(t) * rotAmount

        local base = arrowOffsets[i]
        if base then
            setPropertyFromGroup("strumLineNotes", i, "x", base.x + x)
            setPropertyFromGroup("strumLineNotes", i, "y", base.y + y)
            setPropertyFromGroup("strumLineNotes", i, "angle", angle)
        end
    end
end
