--[Skynet Nuclear Defense Program by Andrew2060]--
--[To be used with this http://pastebin.com/exm7HRhr]--

--[At line 14 and 15, replace User/Pass with what you want]--
 
 
--[[Settings]]--
local waitDelay = 2
 
--[[Init]]--
local silos = {}
peripheral.find("modem", rednet.open)


--[[Functions]]--
local accounts = {
  ["User1"] = "password1", --Replace User1 with your Username, and password1 with your password
  ["User2"] = "password2"
     
}
 
local function clear()
  term.clear()
  term.setCursorPos(1, 1)
end
 
term.setBackgroundColor(colors.blue)
clear()
 

local function red()
term.setBackgroundColor(colors.red)
print("                                                   ")
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
 
local curSilo = 1
local function launch(count, x, y, z)
  local msg = {x = x, y = y, z = z}
    print("Launching @ " .. x .. ", " .. y .. ", " .. z)
      for i = 1, count do
        sleep(1)
        rednet.send(silos[curSilo], msg)
          curSilo = (curSilo == #silos) and 1 or (curSilo + 1)
            sleep(5)
      end
end
 
local function printSilos()
  clear()
    print("==========================")
    print("     [Detected  Silos]    ")
    for k, v in ipairs(silos) do
    print("      silo #" .. k .. " id = "..v)
  end
    print("==========================")
    term.setBackgroundColor(colors.red)
    print("                          ")
    print("                          ")
    term.setBackgroundColor(colors.blue)
end
 
--[[Main program]]--
local valid
  print("=========================")
  print("  Skynet Systems Active  ")
  print("=========================")
 
  term.setBackgroundColor(colors.blue)
  print("=========================")
  print("  Enter Credentials...   ")
  print("=========================")
  write("Username: ")
  local input_user = read()
  write("Password: ")
  local input_pass = read("*")
 
  for valid_user, valid_pass in pairs(accounts) do
  if (input_user == valid_user and input_pass == valid_pass) then valid = true end
  end
 
  if valid then
  term.clear()
  print("Welcome General " ..input_user)
 
findSilos()
 while true do
  printSilos()
red()
  print("  [Launch Verification]   ")
red()
  print(" Enter Verification Code: ")
red()
  write("Code:  ")
  input  = read()
  term.setBackgroundColor(colors.blue)
  if input == "exit" then
   break
    elseif input == "949-854-3444" then
     while true do
     sleep(1)
red()
      print(" Confirm launch? [Yes/No] ")
red()
      write("           >")
        input2 = read()
       if input == "No" then
      os.reboot()
   elseif input2 == "Yes" then
term.clear()
term.setCursorPos(1,1)
 local count, x, y, z
  while not (type(count) == "number" and type(x) == "number" and type(y) == "number" and type(z) == "number") do
      red()
      print("    [Target Selection]    ")
      red()
      write(" Missile Count: ")
      count = tonumber(read())
      print("Coordinates:")
      write("X: ")
      x = tonumber(read())
      write("Y: ")
      y = tonumber(read())
      write("Z: ")
      z = tonumber(read())
      red()
      end
     
term.clear()
term.setCursorPos(1,1)
     
      red()
      print("Target selection complete")
      red()
      print(" Launching in T-Minus 10  ")
      sleep(1)
      print("   9 Seconds to Launch    ")
      sleep(1)
      print("   8 Seconds to Launch    ")
      sleep(1)
      print("   7 Seconds to Launch    ")
      sleep(1)
      print("   6 Seconds to Launch    ")
      sleep(1)
      print("   5 Seconds to Launch    ")
      sleep(1)
      print("   4 Seconds to Launch    ")
      sleep(1)
      print("   3 Seconds to Launch    ")
      sleep(1)
      print("   2 Seconds to Launch    ")
      sleep(1)
      print("   1 Seconds to Launch    ")
      sleep(1)
      red()
      print("  Do you wish to Abort [Y/N]?   ")
      red()
      write("         >")
local abort = read()
if abort == "Yes" then
os.reboot()
elseif abort == "No" then
    launch(count, x, y, z)
    sleep(12)
    os.reboot()
  end
  os.reboot()
end
end
end
end
else print("Access Denied")
print("Rebooting System")
os.reboot()
