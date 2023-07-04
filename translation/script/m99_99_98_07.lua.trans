function Initialize_m99_99_98_07(proxy)
	print("Initialize_m99_99_98_07 begin");
	
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 0, "OnEvent_000_2", 0.1, 0, 0, once);
	proxy:NotNetMessage_end();
	
	proxy:OnRegionJustIn( 1000,10000, 1000,"OnEvent_1000",everytime);
	proxy:OnRegionJustOut( 1001 , 10000, 1000, "OnEvent_1001", everytime);
	
	print("Initialize_m99_99_98_07 end");
end

--èâä˙âªä÷êî --EN:--initialization function
function OnEvent_000_2(proxy,param)
	proxy:SetInsideBattleArea(100,0);
	proxy:SetInsideBattleArea(101,0);
	proxy:SetInsideBattleArea(102,0);
end


function OnEvent_1000(proxy,param)
	print("OnEvent_1000 begin");
	proxy:SetInsideBattleArea(100,1);
	proxy:SetInsideBattleArea(101,1);
	proxy:SetInsideBattleArea(102,1);
	print("OnEvent_1000 end");
end

function OnEvent_1001(proxy,param)
	print("OnEvent_1001 begin");
	proxy:SetInsideBattleArea(100,0);
	proxy:SetInsideBattleArea(101,0);
	proxy:SetInsideBattleArea(102,0);
	print("OnEvent_1001 end");
end
