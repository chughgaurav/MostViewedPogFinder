function querySystem(rec)

	local debugMsg = "-----------------"
	local pogIdHitMap = rec.pogIdHitMap
	local hitsAvgMap = map()
	local pogMapsTn = map()

	local highestHit = map()

	if(pogIdHitMap == nil) then
		debugMsg = debugMsg.."no hits found"
	else
		pogIdHitMap = map.clone(pogIdHitMap)

		--local pogMapT1, pogMapT2, pogMapT3, pogMapT4, pogMapT5 = map()

		for i=1,5 do
			local pogMap = rec["pogMapT"..i]
			if(pogMap ~= nil) then
				pogMapsTn["pogMapT"..i] = pogMap
			end
		end
		local map9 = pogMapsTn["pogMapT1"]

		for key in map.keys(pogIdHitMap) do
			hitsAvgMap[key] = pogMapsTn["pogMapT1"][key] + pogMapsTn["pogMapT2"][key] + pogMapsTn["pogMapT3"][key] + pogMapsTn["pogMapT4"][key] + pogMapsTn["pogMapT5"][key]
			hitsAvgMap[key] = string.format("%1.1f",hitsAvgMap[key] / 5)
			debugMsg = debugMsg.." "..hitsAvgMap[key]
		end
	end


	for key,value in map.pairs(hitsAvgMap) do
		if(map.size(highestHit) < 1) then
			highestHit["key"] = key
			highestHit["value"] = hitsAvgMap[key]
		else
			if(highestHit["value"] < hitsAvgMap[key]) then
				highestHit["key"] = key
				highestHit["value"] = hitsAvgMap[key]
			end
		end
		debugMsg = debugMsg.." "..key.."- "..value
	end

	function spairs(t, order)
	    -- collect the keys
	    local keys = {}
	    for k in pairs(t) do keys[#keys+1] = k end

	    -- if order function given, sort by it by passing the table and keys a, b,
	    -- otherwise just sort the keys 
	    if order then
	        table.sort(keys, function(a,b) return order(t, a, b) end)
	    else
	        table.sort(keys)
	    end

	    -- return the iterator function
	    local i = 0
	    return function()
	        i = i + 1
	        if keys[i] then
	            return keys[i], t[keys[i]]
	        end
	    end
	end

	local hitsAvgTb = {}
	for key,value in map.pairs(hitsAvgMap) do
		hitsAvgTb[key] = value
	end

	debugMsg = debugMsg.."-------------sorted--------------"

	for k,v in spairs(hitsAvgTb, function(t,a,b) return t[b] < t[a] end) do
		debugMsg = debugMsg..k.."  "..v.."   "
	end


	debugMsg = debugMsg.." highestHit key-"..highestHit["key"].." value - "..highestHit["value"]

	return debugMsg
end