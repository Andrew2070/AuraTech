--[[Missile Launch Client by: Andrew2070]]--
--[[Don't touch the code unless you know what you're doing]]--
--[[Annotations below describe what each section does]]--


--[[Initialization]]--
shell.run("clear")
shell.run("id")
missilesilo = peripheral.wrap("back")
rednet.open("top")
local armed = true
local masterID
 
--[[Contingencies]]--
 
if peripheral.call("back", "getMissile") ~= "nil"
then currentmissile = tostring(missilesilo.getMissile())
  else
    currentmissile = "Empty"
    end
 
--//Basically provides a contingency that when no missile is detected, it returns "No Missile"
--//Prevents crashing due to nil values returned by empty missile silo.
 
 
--[[Data Storage + Table]]--
local target = tostring(missilesilo.getTarget())
local xc, yc, zc = missilesilo.getTarget()
 
local siloData = {
["Msg"] = "pong",
["ID"] = os.getComputerID(),
["Missile"] = currentmissile,
["Armed"] = armed,
["TarX"] = xc,
["TarY"] = yc,
["TarZ"] = zc
}

--[[Main Program + Rednet Setup]]--
while true do
 print("Waiting for Threat Message From Defense Server...")
 local id, msg2 = rednet.receive(masterID)
 
  if (msg2 == "ping") then
    print("  master=", id)
    masterID = id;
    print(siloData[1])
    rednet.send(masterID, siloData)
    print("Data has successfully been sent to: "..masterID)
 
--//Top: If a message "ping" is received then log the id of the sender and send that ID the data.
--//Bottom: If the message is not "ping" and is a "table" from the id of the original sender then prepare for launch.
 
            elseif type(msg2) == "table" and id == masterID then
              if type(msg2.x) == "number" and type(msg2.y) == "number" and type(msg2.z) == "number" then
              print("  Launching missiles  At X:" .. msg2.x .. ", Y:" .. msg2.y .. ", Z:" .. msg2.z)
              missilesilo.setTarget(msg2.x, msg2.y, msg2.z)
 
                if (armed) then
                peripheral.call("back","launch")
              end
 
          else
      print("  Invalid Table Command")
    end
  else
 print("  Invalid Message:",msg," from: ",id)
end
end
