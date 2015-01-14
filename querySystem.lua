function querySystem(rec)

	local debugMsg = "-----------------"
	local pogIdHitMap = rec.pogIdHitMap
	local hitsAvgMap = map()
	local pogMapsTn = map()

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
			--hitsAvgMap[key] = pogMapsTn["pogMapT1"][key] + pogMapsTn["pogMapT2"][key] + pogMapsTn["pogMapT3"][key] + pogMapsTn["pogMapT4"][key] + pogMapsTn["pogMapT5"][key]
			
			hitsAvgMap[key] = pogMapsTn["pogMapT1"][key]
			debugMsg = debugMsg.." "..hitsAvgMap[key]
		end
	end

	local map9 = pogMapsTn["pogMapT1"]

	for key in map.keys(map9) do
		--debugMsg = debugMsg.." "..key
	end

	return debugMsg
end