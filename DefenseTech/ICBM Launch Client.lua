--Silo Launch PC, [working] [By Andrew2060]
 
--[[Settings]]--
peripheral.find("modem", rednet.open)
local icbmSide = "back"
local armed = true
--set armed to false to disarm silo.
 
--[[Init]]--
local masterID
 
--[[Functions]]--
local function clear()
 term.clear()
  term.setCursorPos(1, 1)
   end

--[[Main program]]--
clear()
while true do
  print("Waiting for Launch Confirmation Message")
  id, msg, distance = rednet.receive(masterID)
 
  if (msg == "ping silo") then
    print("  master=", id)
    masterID = id;
    rednet.send(masterID, "pong")
  elseif type(msg) == "table" and id == masterID then
    if type(msg.x) == "number" and type(msg.y) == "number" and type(msg.z) == "number" then
      print("  launch to x=" .. msg.x .. ", y=" .. msg.y .. ", z=" .. msg.z)
      icbm.setTarget(msg.x, msg.y, msg.z)
      if (armed) then
        peripheral.call("back", "launch")
      end
    else
      print("  invalid table command")
    end
  else
    print("  Invalid messsage '", msg, "' From '", id, "', distance=", distance)
  end
end
