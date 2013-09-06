stairsState = 0
enginePos = "right"
wifiPos = "left"
wifiId = 43
dirOpen = 4
dirClose = 5

wifi = peripheral.wrap(wifiPos)
wifi.open(wifiId)

function open()
  if stairsState == 0 then
    return
  end
  while false == peripheral.isPresent(enginePos) do
    sleep(0.5)
  end
  local engine = peripheral.wrap(enginePos)
  engine.move(dirOpen, false, true)
  stairsState = 1
end

function close()
  if stairsState == 1 then
    return
  end
  local engine = peripheral.wrap(enginePos)
  engine.move(dirClose, false, true)
  stairsState = 0
end

while true do
  local side, freqId, fredReplyId, message, dist = os.pullEvent("modem_message")
  if message == "open" then
    open()
  elseif message == "close" then
    close()
  end
end
