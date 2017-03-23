--[[Missile Interceptor Client by: Andrew2070]]--
--[[Warning: 5% chance of interception failure]]--
--[[Don't touch the code unless you know what you're doin]]--
--[[Annotations below describe what each section does]]--


--[[Initialization]]--
shell.run("clear")
shell.run("id")
missilesilo = peripheral.wrap("back")
rednet.open("top")
local armed = true
local masterID
--local pack = textutils.serialise(siloData)
 
--[[Contingencies]]--
 
if peripheral.call("back", "getMissile") ~= "{}"
then currentmissile = "No Missile"
  elseif peripheral.call("back", "getMissile") = "anti-ballistic missile"
  then
   local  currentmissile = tostring(missilesilo.getMissile())
    end
 
--//Basically provides a contingency that when no missile is detected, it returns "No Missile"
--//Prevents crashing due to nil values returned by empty missile silo.
 
 
--[[Data Storage + Table]]--
local  target = tostring(missilesilo.getTarget())
 
local siloData = {
["Msg"] = "ABM",
["ID"] = os.getComputerID(),
["Missile"] = currentmissile,
["Target"] = target
}
 
--[[Main Program + Rednet Setup]]--
while true do
 print("Waiting for Threat Message From Defense Server...")
 local id, msg2 = rednet.receive(masterID)
 
  if (msg2 == "ABM1") then
    print("  master=", id)
    masterID = id;
    print(siloData[1])
    rednet.send(masterID, siloData)
 
--//Top: If a message "ABM1" is received then log the id of the sender and send that ID the data.
--//Bottom: If the message is not "ABM1" and is a "table" from the id of the original sender then prepare for launch.
 
            elseif type(msg2) == "table" and id == masterID then
              if type(msg2.x) == "number" and type(msg2.y) == "number" and type(msg2.z) == "number" then
              print("  launching CounterMeasures At x=" .. msg2.x .. ", y=" .. msg2.y .. ", z=" .. msg2.z)
              icbm.setTarget(msg2.x, msg2.y, msg2.z)
 
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
