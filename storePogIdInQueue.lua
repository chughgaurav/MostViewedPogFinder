function storePogIdInQueue(rec,pogId)
if not aerospike:exists(rec) then
  rec.pogIdHitStream = list()
  aerospike:create(rec)
end

if rec[pogId] ~= nil then
  rec[pogId] = rec[pogId]+1
end

local pogIdHitStream = rec.pogIdHitStream

  --update val to bin
if rec[pogId] == nil then
  rec[pogId] = 1

  --store message
  list.append(pogIdHitStream, pogId)
  rec.pogIdHitStream = pogIdHitStream
end


  aerospike:update(rec)

  return list.size(pogIdHitStream)
end
