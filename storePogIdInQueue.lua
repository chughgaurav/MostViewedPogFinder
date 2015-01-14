function storePogIdInQueue(rec,pogId)

  local debugMsg = "-----------------"

  if not aerospike:exists(rec) then
    rec.pogIdHitStream = list()
    rec.pogIdHitMap = map()
    aerospike:create(rec)
    debugMsg = "\n"..debugMsg.."rec didn't exist"
  end


  if(rec.pogIdHitStream == nil)
    then
    if aerospike:exists(rec) then
      rec.pogIdHitStream = list()
      aerospike:update(rec)
      debugMsg = "\n"..debugMsg.."pogIdHitStream was null"
    end
  end

  if(rec.pogIdHitMap == nil)
    then
    if aerospike:exists(rec) then
      rec.pogIdHitMap = map()
      aerospike:update(rec)
      debugMsg = "\n"..debugMsg.."pogIdHitMap was nil"
    end
  end


 info("gaurav")
 debug("-----------------------------------pogId- ",pogId)
 info("-----------------------------------",rec.pogIdHitStream)

local pogIdHitMap = rec.pogIdHitMap

  if pogIdHitMap[pogId] ~= nil then
    --rec[pogId] = rec[pogId]+1
    pogIdHitMap[pogId] = pogIdHitMap[pogId]+1

    rec.pogIdHitMap = pogIdHitMap
    debugMsg = "\n"..debugMsg.."pogIdHitMap["..pogId.."] +1"
  end


  local pogIdHitStream = rec.pogIdHitStream

  --initialise & add pogId entry to list / map
  if pogIdHitMap[pogId] == nil then
    pogIdHitMap[pogId] = 1

    --rec[pogId] = 1
    --list.append(pogIdHitStream, pogId)
    --rec.pogIdHitStream = pogIdHitStream

    rec.pogIdHitMap = pogIdHitMap
    debugMsg = "\n"..debugMsg.."pogIdHitMap["..pogId.."] =1"
  end

  aerospike:update(rec)


  return debugMsg
end
