--[[Skynet Nuclear ABM Defense Program by Andrew2060]]--
--[[This Tracks Missiles from a Radar and displays them]]--


 --[[Place The Coordinates of This Computer Here:]]--
    local x2 = 2194
    local y2 = 57
    local z2 = 1221
 
--[[Radar Target Handler Display]]--        
term.setBackgroundColor(colors.blue)
term.clear()

print("===================================================")
print("         SKYNET AERIAL DEFENSE SYSTEMS             ")
print("===================================================")
print("===================================================")
print("        ENHANCED RADAR HANDLING ENABLED            ")
print("===================================================")
while true do
maptab = peripheral.call("back","getEntities")
        maptxt = textutils.serialize(maptab)
        if maptxt ~= "{}" then
                allDat = 0
                for num in pairs(maptab) do
                        allDat = allDat+1
                end
                targets = allDat/3
                for i=0,targets-1 do

                   --Do not Touch, these create the Distance of the Missiles--
                      local x1 = math.floor(tonumber(maptab["x_"..i])/1)
                      local y1 = math.floor(tonumber(maptab["y_"..i])/1)
                      local z1 = math.floor(tonumber(maptab["z_"..i])/1)
                      local d = math.sqrt((x2-x1)^2 + (y2-y1)^2 + (z2-z1)^2)
 
                          print("Incoming Missile #"..i.." Distance:"..d)
 
 
sleep(0)
end
sleep(0)
end
sleep(0)
end
