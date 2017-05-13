shell.run("clear")
shell.run("id")
missilesilo = peripheral.wrap("back")
rednet.open("top")
local armed = true
local masterID
local pack = textutils.serialise(siloData)
local icbm = peripheral.wrap("back")



if missilesilo.getMissile() ~= "{}" then currentmissile = "None" 
 
    else
  
    local  currentmissile = tostring(missilesilo.getMissile())
 end
 
     local  armed = tostring(missilesilo.canLaunch())
 
       local targets = tostring(missilesilo.getTarget())

print(currentmissile)

local siloData = {
["Msg"] = "ABM",
["ID"] = os.getComputerID(),
["Missile"] = currentmissile,
["Target"] = targets,
["Armed"] = armed
}


while true do
  print("Waiting for Threat Message From Defense Server...")
 local id, msg = rednet.receive(masterID)
 
  if (msg == "ABM1") then
    print("  master=", id)
    masterID = id;
    print(siloData[1])
    rednet.send(masterID, siloData)


            elseif type(msg) == "table" and id == masterID then
              if type(msg.x) == "number" and type(msg.y) == "number" and type(msg.z) == "number" then
              print("  launching CounterMeasures At x=" .. msg.x .. ", y=" .. msg.y .. ", z=" .. msg.z)
              icbm.setTarget(msg.x, msg.y, msg.z)
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
