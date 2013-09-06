stairsState = 0
wifiCommandId = 42
wifiEngineId = 43
wifiPos = "left"
redstonePos = "bottom"

wifi= peripheral.wrap(wifiEnginePos)
wifi.open(wifiCommandId)

function open()
  if stairsState == 1 then
    return
  end
  local engine = peripheral.wrap(enginePos)
  engine.move(0, false, true)
  wifi.transmit(wifiEngineId, wifiEngineId, "open")
  sleep(1)
  redstone.setOutput(redstonePos, true)
  stairsState = 1
end

function close()
  if stairsState == 0 then
    return
  end
  redstone.setOutput(redstonePos, false)
  sleep(1)
  wifi.transmit(wifiEngineId, wifiEngineId, "close")
  while false == peripheral.isPresent(enginePos) do
    sleep(0.5)
  end
  local engine = peripheral.wrap(enginePos)
  engine.move(1, false, true)
  stairsState = 0
end

while true do
  computerId, message, dist = os.pullEvent("rednet_message")
  if message == "open" then
    open()
  elseif message == "close" then
    close()
  end
end
