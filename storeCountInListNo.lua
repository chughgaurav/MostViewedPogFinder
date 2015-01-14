function storeCountInListNo(rec,listNo)

--[=====[ 
Documentation:
  if(!baseCopy)
    create baseCopy & initialise
  else (after t1)
    update currentCopy
    copyTn = currentCopy - baseCopy
    baseCopy = currentCopy
--]=====]
 
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
    myVal2 = "------------pogMapTBase is nil---------------------"
    --initialising base copy of pogHits
    rec.pogMapTBase = map()
    aerospike:update(rec)
    if(map.size(pogIdHitMap)>=1) then
      --aerospike:create(rec)
      rec.pogMapTBase = map.clone(pogIdHitMap)
      rec["pogMapT"..listNo] = map.clone(pogIdHitMap)
      myVal2 = myVal2.."................pogIdHitMap >= 1.............................."
    end
else
    --rec.pogMapTBase is not nil
    local currentHits = map.clone(pogIdHitMap)
    local pogMapTn = map()
    --pogMapTBase has hits state from last call of this lua file
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
    rec.pogMapTBase = currentHits
end

myVal2 =  myVal2.."----------------after copy-----------------Yes2"


aerospike:update(rec)

return myVal2
end