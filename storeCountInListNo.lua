function storeCountInListNo(rec,listNo)
 
local myVal2 = ""

local pogIdHitMap = rec.pogIdHitMap

for value in map.keys(pogIdHitMap) do
   myVal2 = myVal2..value.." "
end

myVal2 = myVal2.."..eof"

for value in map.values(pogIdHitMap) do
   myVal2 = myVal2..value.." "
end

myVal2 = myVal2.."..eof"

  

if(rec.listT1 == nil)
  then
  rec.listT1 = list()
  aerospike:create(rec)
  --aerospike:update(rec)
end

myVal2 ="----------------------->  "

if(rec.listT1 == nil)
  then
  rec.listT1 = list()
  aerospike:create(rec)
  --aerospike:update(rec)
end

if(rec.pogMapT0 == nil)
  then
  rec.pogMapT0 = map()
  aerospike:create(rec)
  --aerospike:update(rec)
  local pogMapT0 = map.clone(pogIdHitMap)
end

        if(listNo==1) then
            --rec.listT1 = list()
            --aerospike:create(rec)
                local  listT1 = rec.listT1
                  for value in map.keys(pogIdHitMap) do 
                      list.append(listT1,value)
                  end
                  rec.listT1 = listT1
        else
            rec.listT2 = list()
          	local  listT2 = rec.listT2
            --store message
            list.append(listT2, "pogId" )
            rec.listT2 = listT2
        end
        
    --end

  aerospike:update(rec)

  return myVal2
  --return list.size(messages)
end
