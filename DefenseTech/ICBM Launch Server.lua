--[[ICBM Launch Server]]--
--[[Program By: Andrew2070]]--
 
size = {term.getSize()}
 
users = {"Andrew2070"}
passwords = {"3765"}
 
local silos = {}
local curSilo = 1
local hostName = "Andrew2060_Silo_System"
local protocolName = "Andrew2060_Silo"
rednet.host(protocolName, hostName)
--[[Functions]]--
 
rednet.open("top")
local waitDelay = 2
 
local function red()
term.setBackgroundColor(colors.red)
print("                                                          ")
term.setBackgroundColor(colors.blue)
end
 
local function findSilos()
    rednet.broadcast("ping silo")
 
  local timerID = os.startTimer(waitDelay)
 
  while true do
    event, id, msg, distance = os.pullEvent()
   
    if event == "rednet_message" and msg == "pong" then
      table.insert(silos, id)
      timerID = os.startTimer(waitDelay)
    elseif event == "timer" and id == timerID then
       return
    end
  end
end
 
local function listenForSilos()
  while true do
        local message = {rednet.recive()}
        if message[3] == protocolName then
          --# message is expected protocol, continue
          silo[#silo+1] = message[2]
        end
  end
end
 
local function printSiloInfo()
  if silo[1] then
        textutils.pagedTabulate({"ID", "Type", "Armed"}, unpack(silo))
  else print("No connected slaves") end
end
 
local function fire(ID)
  if silo[ID][3] then
        rednet.send(silo[ID][1],"fire", protocolName )
  else print("Silo not armed, can't fire while not armed") end
end
 
local function arm(ID)
  silo[ID][3] = "true"
  rednet.send(silo[ID][1],"arm", protocolName )
end
 
local function disarm(ID)
  silo[ID][3] = "false"
  rednet.send(silo[ID][1],"disarm", protocolName )
end
 
parallel.waitForAny(listenForSilos, main)
 
local function launch(count, x, y, z)
  local msg = {x = x, y = y, z = z}
    print("launching Missiles At " .. x .. ", " .. y .. ", " .. z)
      for i = 1, count do
        rednet.send(silos[curSilo], msg)
          curSilo = (curSilo == #silos) and 1 or (curSilo + 1)
            sleep(5)
      end
end
 
local function printSilos()
  term.clear()
  term.setCursorPos(1,1)
    print("              [Detected silos]       ")
    for k, v in ipairs(silos) do
    print("              silo #" .. k .. " id = "..v)
  end
end
 
function drawBoxPos(x,y,x1,y1)
  cy = y
  term.setCursorPos(x,y)
  for i = 1,(y1-y)+1 do
    for i = 1,(x1-x) do
      term.write(" ")
    end
    cy = cy+1
    term.setCursorPos(x,cy)
  end
end
 
function reset()
  term.setBackgroundColor(colors.lightGray)
  term.setCursorPos(2,12)
  for i = 1,size[1]-4 do
    term.write(" ")
  end
  term.setTextColor(colors.gray)
  term.setBackgroundColor(colors.gray)
  drawBoxPos(9,8,size[1]-1,8)
  term.setBackgroundColor(colors.lightGray)
  term.setCursorPos(3,8)
  print("USER:")
  term.setBackgroundColor(colors.gray)
  drawBoxPos(9,10,size[1]-1,10)
  term.setBackgroundColor(colors.lightGray)
  term.setCursorPos(3,10)
  print("PASS:")
end
 
function loginScreen()
  term.setBackgroundColor(colors.white)
  term.clear()
  term.setBackgroundColor(colors.lightGray)
  drawBoxPos(2,2,size[1],size[2]-1)
  term.setCursorPos(1,size[2]-7)
  term.setBackgroundColor(colors.gray)
  drawBoxPos(((size[1]/2)-10)-1,2,((size[1]/2)+13)-1,4)
  term.setBackgroundColor(colors.red)
  drawBoxPos((size[1]/2)-10,1,(size[1]/2)+13,3)
  term.setTextColor(colors.gray)
  str = "Skynet Mainframe"
  term.setCursorPos((size[1]/2)-(#str/2) +1,2)
  term.write(str)
  term.setBackgroundColor(colors.lightGray)
  str = "Enter Authentication Credentials"
  term.setCursorPos((size[1]/2)-(#str/2) +1,6)
  term.write(str)
  term.setBackgroundColor(colors.gray)
  drawBoxPos(9,8,size[1]-1,8)
  term.setBackgroundColor(colors.lightGray)
  term.setCursorPos(3,8)
  print("USER:")
  term.setBackgroundColor(colors.gray)
  drawBoxPos(9,10,size[1]-1,10)
  term.setBackgroundColor(colors.lightGray)
  term.setCursorPos(3,10)
  print("PASS:")
  term.setBackgroundColor(colors.red)
  drawBoxPos(((size[1]/2)-9)-1,13,((size[1]/2)+13)-1,15)
  term.setTextColor(colors.gray)
  str = "Login to Skynet!"
  term.setCursorPos((size[1]/2)-(#str/2) +1,14)
  term.write(str)
  term.setBackgroundColor(colors.lightGray)
  str = "(c) 2016 Skynet - Build. Innovate. Conquer"
  term.setCursorPos((size[1]/2)-(#str/2) +1,size[2]-2)
  term.write(str)
  while true do
    evnt = {os.pullEvent()}
    if evnt[1] == "mouse_click" then
      if evnt[3] > 8 and evnt[3] < size[1]-1 and evnt[4] == 8 then
        term.setBackgroundColor(colors.gray)
        term.setTextColor(colors.lightGray)
        term.setCursorPos(9,8)
        username = read()
      elseif evnt[3] > 8 and evnt[3] < size[1]-1 and evnt[4] == 10 then
        term.setBackgroundColor(colors.gray)
        term.setTextColor(colors.lightGray)
        term.setCursorPos(9,10)
        password = read("*")
      elseif evnt[3] > ((size[1]/2)-9)-2 and evnt[3] < ((size[1]/2)+13)-2 and evnt[4] > 12 and evnt[4] < 16 then
        if username ~= nil and password ~= nil then
          loggedin = false
          for i = 1,#users do
            if username == users[i] then
              if password == passwords[i] then
                term.setTextColor(colors.lime)
                term.setBackgroundColor(colors.lightGray)
                str = "Access Granted. Welcome back, "..username
                term.setCursorPos((size[1]/2)-(#str/2) +1,12)
                term.write(str)
                loggedin = true
                sleep(3)
              end
            end
          end
          if loggedin then
term.setBackgroundColor(colors.blue)
term.clear()
findSilos()
term.setCursorPos(1,1)
term.setBackgroundColor(colors.blue)
term.clear()
  printSilos()
red()
write("Enter Launch Verification Code: ")
  input  = read()
red()
  term.setBackgroundColor(colors.blue)
  if input == "exit" then
   break
    elseif input == "949-854-3444" then
     while true do
     sleep(1)
red()
       write("Launch Confirmation [Yes/No]: ")
        input2 = read()
       if input2 == "No" then
      os.reboot()
   elseif input2 == "Yes" then
 local count, x, y, z
  while not (type(count) == "number" and type(x) == "number" and type(y) == "number" and type(z) == "number") do
red()
print("      [Target Selection]       ")
red()
term.setBackgroundColor(colors.blue)
 write(" Missile Count: ")
      count = tonumber(read())
      print("Arming Warheads..")
      arm(silos[curSilo])
      print("Coordinates:")
      write("X: ")
      x = tonumber(read())
      write("Y: ")
      y = tonumber(read())
      write("Z: ")
      z = tonumber(read())
sleep(1)
Print("Target Selection Complete:")
 red()
term.setBackgroundColor(colors.blue)
   print("Launching at: "..x..","..y..","..z)
   print("Launching Missiles -T Minus 10 Seconds.")
   sleep(1)
red()
   
sleep(1)
write("  Abort [Yes/No]: ")
local abort = read()
if abort == "Yes" then
 
disarm(silos[curSilo])
 
 
write("Warheads Disarmed Successfully")
sleep(1)
write("Session Expired, renewing login:")
sleep(2)
os.reboot()
elseif abort == "No" then
    end
    launch(count, x, y, z)
    sleep(10)
    os.reboot()
end
          elseif loggedin == false then
            term.setTextColor(colors.red)
            term.setBackgroundColor(colors.lightGray)
            str = "Username or Password incorrect."
            term.setCursorPos((size[1]/2)-(#str/2) +1,12)
            term.write(str)
            sleep(2)
            reset()
          end
          end
        elseif username == nil or password == nil then
          reset()
          term.setTextColor(colors.red)
          term.setBackgroundColor(colors.lightGray)
          str = "Username or Password not recognized."
          term.setCursorPos((size[1]/2)-(#str/2) +1,12)
          term.write(str)
          sleep(2)
          reset()
        end
      end
    end
  end
end
end
end
 
loginScreen()
term.setBackgroundColor(colors.black)
term.clear()
term.setCursorPos(1,1)
