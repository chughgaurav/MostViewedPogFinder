function storeCountInListNo(rec,listNo)

    --if not aerospike:exists(rec) then
        if(listNo==1) then
            rec.listT1 = list()
            aerospike:create(rec)
                local  listT1 = rec.listT1
                --store message
                  list.append(listT1, "pogId" )
                  rec.listT1 = listT1
        elseif(listNo==2) then
            rec.listT2 = list()
        end
        
    --end

  aerospike:update(rec)
  --return list.size(messages)
end