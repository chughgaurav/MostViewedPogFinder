function storePogIdInQueue(rec,pogId)
  if not aerospike:exists(rec) then
    rec.pogIdHitStream = list()
    rec.pogIdHitMap = map()
    aerospike:create(rec)
  end


  if(rec.pogIdHitStream == nil)
    then
    if aerospike:exists(rec) then
      rec.pogIdHitStream = list()
      aerospike:update(rec)
      return "pogIdHitStream is nil"
    end
  end

  if(rec.pogIdHitMap == nil)
    then
    if aerospike:exists(rec) then
      rec.pogIdHitMap = map()
      aerospike:update(rec)
      return "pogIdHitMap is nil"
    end
  end


 info("gaurav")
 debug("-----------------------------------pogId- ",pogId)
 info("-----------------------------------",rec.pogIdHitStream)

  if rec[pogId] ~= nil then
    rec[pogId] = rec[pogId]+1
  end


  local pogIdHitStream = rec.pogIdHitStream
  local pogIdHitMap = rec.pogIdHitMap

  --pogIdHitMap = map { a = 1, b = 2, c = 3 }

  --initialise & add pogId entry to list / map
  if rec[pogId] == nil then
    rec[pogId] = 1
    pogIdHitMap[pogId] = 1

    --list.append(pogIdHitStream, pogId)

    --rec.pogIdHitStream = pogIdHitStream
    rec.pogIdHitMap = pogIdHitMap
  end

  aerospike:update(rec)


  --return list.size(pogIdHitStream)
end
