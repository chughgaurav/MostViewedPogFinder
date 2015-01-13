function storeCountInListNo(rec,listNo)
 
local myVal2 = ""

if(rec.pogIdHitMap == nil)
  then
  myVal2 = "------------pogIdHitMap is nil---------------------"
  if not aerospike:exists(rec) then
    rec.pogIdHitMap = map()
    aerospike:create(rec)
    myVal2 = myVal2.."------------rec & pogIdHitMap created---------------------"
  else
    rec.pogIdHitMap = map()
    aerospike:update(rec)
    myVal2 = myVal2.."------------pogIdHitMap created---------------------"
  end
  --return myVal2
end

local pogIdHitMap = rec.pogIdHitMap


if(rec["pogMapT"..listNo] == nil)
  then
  rec["pogMapT"..listNo] = map()
  aerospike:create(rec)

end

if(rec.pogMapTBase == nil)
  then
    if(map.size(pogIdHitMap)>=1) then
      --initialising base copy of pogHits
      rec.pogMapTBase = map()
      aerospike:update(rec)
      --aerospike:create(rec)
      rec.pogMapTBase = map.clone(pogIdHitMap)
      myVal2 = myVal2.."................pogIdHitMap >= 1.............................."
    end
else
  local currentHits = map.clone(pogIdHitMap)
  local pogMapTn = map()
  local pogMapTBase = rec.pogMapTBase

  for key in map.keys(currentHits) do
    if(pogMapTBase[key] ~= nil) then
        pogMapTn[key] = currentHits[key]-pogMapTBase[key]
        myVal2 = myVal2.."-------------------Not NIL-----------"
    else
        pogMapTn[key] = currentHits[key]
        myVal2 = myVal2.. "-------------------IS NIL-----------"
    end
    myVal2 =  myVal2.."----------------after copy-----------------Yes"
  end
  rec["pogMapT"..listNo] = pogMapTn
end
aerospike:update(rec)

myVal2 =  myVal2.."----------------after copy-----------------Yes"

---------------------update   baseCopy = currentCopy
  aerospike:update(rec)

  return myVal2
  --return list.size(messages)
end
