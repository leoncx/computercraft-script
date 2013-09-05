os.loadAPI("APIs/daemon")

modemPos = "top"
glassPos = "left"
secretWifiId = 42
username = "leoncx"
startXpos = 2
startYpox = 10

wifi = peripheral.wrap(modemPos)
glass = peripheral.wrap(glassPos)
textClock = glass.addText(startXpos, startYpox, "", 0xFFFFFF)

function secret(action)
  wifi.transmit(secretWifiId, secretWifiId, action)
end

function commands()
  while true do
    e, a, b, c = os.pullEvent()
    if (e == "chat_command" and b == username and a == "secretopen") then
      secret("open")
    elseif (e == "chat_command" and b == username and a == "secretclose") then
      secret("close")
    end
  end
end

daemon.add("commands", commands)

while true do
  -- Clock
  local timeStr = textutils.formatTime(os.time(), true)
  textClock.setText(timeStr)
  sleep(0.3)
end