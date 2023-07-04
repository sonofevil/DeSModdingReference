function Initialize_m99_99_98_04(proxy)
	print("Initialize_m99_99_98_04 begin");
	
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 0, "OnEvent_000_2", 0.1, 0, 0, once);
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_begin();
		proxy:OnCharacterHpRate(2000,825,"OnEvent_2000",0.1,once);
	proxy:RepeatMessage_end();
	
	--ôÙöKÇÃèIóπÇäƒéã --EN:--watch for end of roar
	proxy:OnCheckEzStateMessage(2005,825,"OnEvent_2005",200);
	print("Initialize_m99_99_98_04 end");
end

--èâä˙âªä÷êî --EN:--initialization function
function OnEvent_000_2(proxy,param)
	BossInit_KingOfShield(proxy,param);
end


function OnEvent_2000(proxy,param)
	print("OnEvent_2000 begin");
	local nowAI_event = proxy:GetEventRequest(825,0);
	if nowAI_event == AI_EVENT_None then--í èÌÇ»ÇÁì{ÇÈ --EN:--usually angry
		proxy:SendEventRequest(825,0,AI_EVENT_FlameMan_Angry);
	elseif nowAI_event == AI_EVENT_FlameMan_Angry then--ì{Ç¡ÇƒÇÈÇ»ÇÁé„ÇÈ --EN:--If you're angry, you're weak
		proxy:SendEventRequest(825,0,AI_EVENT_FlameMan_Weaker);
		proxy:SendEventRequest(825,1,AI_EVENT_None);
	elseif nowAI_event == AI_EVENT_FlameMan_Weaker then--é„Ç¡ÇƒÇÈÇ»ÇÁí èÌÇ… --EN:--If you're weak, go to normal
		proxy:SendEventRequest(825,0,AI_EVENT_None);
		proxy:SendEventRequest(825,1,AI_EVENT_None);
	end
	
	proxy:DeleteEvent(2002);
	proxy:OnKeyTime2(2000,"OnEvent_2000_1",0.0,0,0,once);
	proxy:RepeatMessage_begin();
		proxy:OnCharacterHpRate(2001,825,"OnEvent_2001",0.1,once);
	proxy:RepeatMessage_end();
	print("OnEvent_2000 end");
end

function OnEvent_2001(proxy,param)
	print("OnEvent_2001 begin");
	local nowAI_event = proxy:GetEventRequest(825,0);
	if nowAI_event == AI_EVENT_None then--í èÌÇ»ÇÁì{ÇÈ --EN:--usually angry
		proxy:SendEventRequest(825,0,AI_EVENT_FlameMan_Angry);
	elseif nowAI_event == AI_EVENT_FlameMan_Angry then--ì{Ç¡ÇƒÇÈÇ»ÇÁé„ÇÈ --EN:--If you're angry, you're weak
		proxy:SendEventRequest(825,0,AI_EVENT_FlameMan_Weaker);
		proxy:SendEventRequest(825,1,AI_EVENT_None);
	elseif nowAI_event == AI_EVENT_FlameMan_Weaker then--é„Ç¡ÇƒÇÈÇ»ÇÁí èÌÇ… --EN:--If you're weak, go to normal
		proxy:SendEventRequest(825,0,AI_EVENT_None);
		proxy:SendEventRequest(825,1,AI_EVENT_None);
	end
	proxy:DeleteEvent(2002);
	proxy:OnKeyTime2(2000,"OnEvent_2000_1",0.0,0,0,once);
	proxy:RepeatMessage_begin();
		proxy:OnCharacterHpRate(2000,825,"OnEvent_2000",0.1,once);
	proxy:RepeatMessage_end();
	print("OnEvent_2001 end");
end

function OnEvent_2000_1(proxy,param)
	local nowAI_event = proxy:GetEventRequest(825,0);
	if nowAI_event == AI_EVENT_FlameMan_Angry then
		proxy:OnKeyTime2(2002,"OnEvent_2002",40,0,0,once);
	elseif nowAI_event == AI_EVENT_FlameMan_Weaker then
		proxy:OnKeyTime2(2002,"OnEvent_2002_1",30,0,1,once);
	end	
end


function OnEvent_2002(proxy,param)
	local nowAI_event = proxy:GetEventRequest(825,0);
	if nowAI_event == AI_EVENT_FlameMan_Angry then
		print("OnEvent_2002 begin");
		proxy:SendEventRequest(825,0,AI_EVENT_FlameMan_Weaker);
		proxy:SendEventRequest(825,1,AI_EVENT_None);
		proxy:OnKeyTime2(2002,"OnEvent_2002_1",30,0,1,once);
		print("OnEvent_2002 end");
	end
end

function OnEvent_2002_1(proxy,param)
	local nowAI_event = proxy:GetEventRequest(825,0);
	if nowAI_event == AI_EVENT_FlameMan_Weaker then
		print("OnEvent_2002_1 begin");
		proxy:SendEventRequest(825,0,AI_EVENT_None);
		proxy:SendEventRequest(825,1,AI_EVENT_None);
		print("OnEvent_2002_1 end");
	end
end



function OnEvent_2005(proxy,param)
	print("OnEvvent_2005 begin");
	proxy:SendEventRequest(825,1,AI_EVENT_FlameMan_Roar);--AIÇ…Ç‡ôÙöKÇ™èIÇÌÇ¡ÇΩéñÇí ím --EN:-- Notify the AI that the roar is over
	print("OnEvvent_2005 end");
end

