function querySystem(rec)

	local debugMsg = "-----------------"
	local pogIdHitMap = rec.pogIdHitMap
	local hitsAvgMap = map()
	local pogMapsTn = map()

	local highestHit = {}

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
			if(highestHit[1] == nil) then
				highestHit[1] = hitsAvgMap[key]
			else
				if(highestHit[1] < hitsAvgMap[key]) then
					highestHit[1] = hitsAvgMap[key]
				end
			end
			
			--hitsAvgMap[key] = pogMapsTn["pogMapT1"][key]
			debugMsg = debugMsg.." "..hitsAvgMap[key]
		end
	end

	
	--local map9 = table.sort.sort(hitsAvgMap)

	for key,value in map.pairs(hitsAvgMap) do
		debugMsg = debugMsg.." "..key.."- "..value
	end

	for key,value in pairs(highestHit) do
		debugMsg = debugMsg.." highestHit key-"..key.." value - "..value
	end

	return debugMsg
end