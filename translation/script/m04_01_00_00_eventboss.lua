--KimeraTale_Hp		= 300;
KimeraTale_Hp		= 193.55;

KimeraCallPartner_HpRate	= 0.15;--相棒を呼ぶHP条件。1で100%  0.5で50% --EN:-- HP condition to call buddy. 1 at 100% 0.5 at 50%
KimeraCallPartner_Timer		= 100.0;--相棒を呼ぶまでの秒数 --EN:--Seconds to call buddy

--------------------------------------------------------------------------------------
--イベント初期化■ボス固有のイベントを登録する際に使用してください --EN:--Event Initialization ■Use this when registering boss-specific events.
--------------------------------------------------------------------------------------
function EventBoss_Initialize_m04_01_00_00(proxy)
	print("EventBoss_Initialize_m04_01_00_00 begin");
	--クライアントで無いなら　シングル　or　ホスト --EN:-- Single or host if not a client
	proxy:AddFieldInsFilter(807);
	proxy:AddFieldInsFilter(817);
	if	proxy:IsClient() == false then
		proxy:RequestForceUpdateNetwork(817);
		proxy:RequestForceUpdateNetwork(807);
	end
	if proxy:IsCompleteEvent( 5251 ) == false then
		SingleReset( proxy , 5308 );
		SingleReset( proxy , 5310 );
		SingleReset(proxy,5254);
		if proxy:CreateEventBody( 5308, 807, "Tale_break_5308", KimeraTale_Hp, 1.0, once ) == true then
			proxy:AddEventParts(5308, 807, "Ragdoll_Tale02");
			proxy:AddEventParts(5308, 807, "Ragdoll_Tale03");
			proxy:AddEventParts(5308, 807, "Ragdoll_Tale04");
			proxy:AddEventParts(5308, 807, "Ragdoll_Tale05");
			proxy:AddEventParts(5308, 807, "Ragdoll_Snake Neck01");
			proxy:AddEventParts(5308, 807, "Ragdoll_Snake Head01");
			print("BossInit_Kimera CreateEventBody is Success");
			InvalidCharactor( proxy, 290 );
		else
			print("BossInit_Kimera CreateEventBody is Failed");
		end
		proxy:OnCheckEzStateMessage( 5310, 807, "OnEvent_5310", 500 );
		
		SingleReset( proxy , 5039 );
		SingleReset( proxy , 5311 );
		if proxy:CreateEventBody( 5309, 817, "Tale_break_5309", KimeraTale_Hp, 1.0, once ) == true then
			proxy:AddEventParts(5309, 817, "Ragdoll_Tale02");
			proxy:AddEventParts(5309, 817, "Ragdoll_Tale03");
			proxy:AddEventParts(5309, 817, "Ragdoll_Tale04");
			proxy:AddEventParts(5309, 817, "Ragdoll_Tale05");
			proxy:AddEventParts(5309, 817, "Ragdoll_Snake Neck01");
			proxy:AddEventParts(5309, 817, "Ragdoll_Snake Head01");
			print("BossInit_Kimera CreateEventBody is Success");
			InvalidCharactor( proxy, 291 );
		else
			print("BossInit_Kimera CreateEventBody is Failed");
		end
		proxy:OnCheckEzStateMessage( 5311, 817, "OnEvent_5311", 500 );
		
		--しっぽ用のキメラが余計なことをしないようにロジックOFF、完全無敵を入れておく --EN:--Set the logic OFF and complete invincibility so that the chimera for the tail does not do unnecessary things
		proxy:EnableLogic( 290, false );
		proxy:EnableLogic( 291, false );
		proxy:EnableInvincible( 290, true );
		proxy:EnableInvincible( 291, true );
		
		proxy:OnRegistFunc( 5312, "Condition_5312", "dummy", 2, everytime );
	else
		InvalidBackRead(proxy,290);
		InvalidBackRead(proxy,291);
	end
		
	print("EventBoss_Initialize_m04_01_00_00 end");
end

--------------------------------------------------------------------------------------
--ボス用の初期化処理が必要なときに使用：固有情報の作成等 --EN:--Used when initialization processing for the boss is required: creation of unique information, etc.
--------------------------------------------------------------------------------------
function m04_01_BossInit(proxy,param)
	print("m04_01_BossInit begin");
--ボスイベントアクションID領域(5308～5357) --EN:--Boss event action ID area (5308~5357)
--ボス2体の807,817イベントID --EN:--807,817 event IDs for 2 bosses
--ボス死亡のアクションID5251 --EN:-- Boss death action ID 5251
--EzState EzState→Event　悲鳴開始(300), 割り込みで悲鳴終了(301) --EN:--EzState EzState → Event Screaming start (300), Screaming end with interrupt (301)
--		  Event→EzState　悲鳴終了させる(500) --EN:-- Event → EzState End scream (500)
--AI_EVENT_KIMERA_NO_CRY
--AI_EVENT_None
	--悲鳴開始 --EN:-- start screaming
--[[
	proxy:NotNetMessage_begin();
	
	--悲鳴終了 --EN:-- end scream
	proxy:OnCheckEzStateMessage( 5310, 807, "OnEvent_5310", 301 );
	proxy:OnCheckEzStateMessage( 5311, 817, "OnEvent_5311", 301 );
	proxy:NotNetMessage_end();
]]	

	proxy:NotNetMessage_begin();
		proxy:OnCheckEzStateMessage( 5313, 807, "OnEvent_5313", 301 );
		proxy:OnCheckEzStateMessage( 5314, 817, "OnEvent_5314", 301 );
	proxy:NotNetMessage_end();
	
	if	proxy:IsCompleteEvent( 5251 ) == false then		
		if	proxy:IsCompleteEvent( 5254 ) == false then
			proxy:OnCharacterHP(5254, 807, "OnEvent_5254", KimeraCallPartner_HpRate, once );
			proxy:OnKeyTime2(5254, "OnEvent_5254", KimeraCallPartner_Timer, 0, 2, once );
			InvalidCharactor( proxy, 817 );
		end
	end
	--proxy:OnRegistFunc( 5312, "Condition_5312", "dummy", 2, everytime );
	print("m04_01_BossInit end");
end

function StandBy_Kimera(proxy,param)
	print("StandBy_Kimera begin");
	proxy:SetEventBodyMaxHp(5309,KimeraTale_Hp);	
	proxy:SetEventBodyMaxHp(5308,KimeraTale_Hp);	
	print("StandBy_Kimera end");
end

function m04_01_BossDead(proxy,param)
	print("m04_01_BossDead begin");
	proxy:DeleteEvent( 5312 );
	--[[
	--必要ないハンドラを全消去 --EN:--Delete all unnecessary handlers
	local delete_list = {5308, 5309, 5310, 5311, 5312, 5320, 5321};
	local delete_num  = table.getn( delete_list );
	for index = 1, delete_num, 1 do
		proxy:DeleteEvent( delete_list[index] );
	end
	]]
	print("m04_01_BossDead end");
end

--[[
------------------------------------------------------------------------------------------------------------
--悲鳴開始EzState --EN:--scream start EzState
function OnEvent_5308(proxy,param)
	print("OnEvent_5308 begin");
	proxy:SetEventSpecialEffect( 817, 5013 );
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 5320, "OnEvent_5320", 60.0, 0, 2, once );
	proxy:NotNetMessage_end();
	proxy:SetEventFlag(5308, true);
	print("OnEvent_5308 end");
end

function OnEvent_5309(proxy,param)
	print("OnEvent_5309 begin");
	proxy:SetEventSpecialEffect( 807, 5013 );
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 5321, "OnEvent_5321", 60.0, 0, 2, once );
	proxy:NotNetMessage_end();
	proxy:SetEventFlag(5309, true);
	print("OnEvent_5309 end");
end




------------------------------------------------------------------------------------------------------------
--割り込みEzState --EN:--Interrupt EzState
function OnEvent_5310(proxy,param)
	print("OnEvent_5310 begin");
	proxy:EraseEventSpecialEffect( 817, 5013 );
	proxy:SetEventFlag(5308, false);
	print("OnEvent_5310 end");
end

function OnEvent_5311(proxy,param)
	print("OnEvent_5311 begin");
	proxy:EraseEventSpecialEffect( 807, 5013 );
	proxy:SetEventFlag(5309, false);
	print("OnEvent_5311 end");
end





------------------------------------------------------------------------------------------------------------
--悲鳴状態によってロジックに値を投げて、相方に悲鳴を上げさせないようにする --EN:-- Throw a value into the logic depending on the scream state to prevent the other party from screaming
function Condition_5312(proxy,param)
	if	proxy:IsCompleteEvent( 5308 ) == true then
		proxy:SendEventRequest(817,0,AI_EVENT_KIMERA_NO_CRY);
	else
		proxy:SendEventRequest(817,0,AI_EVENT_None);
	end
	
	if	proxy:IsCompleteEvent( 5309 ) == true then
		proxy:SendEventRequest(807,0,AI_EVENT_KIMERA_NO_CRY);
	else
		proxy:SendEventRequest(807,0,AI_EVENT_None);
	end
	return false;
end



------------------------------------------------------------------------------------------------------------
--秒数経過によりEventからEzStateに悲鳴終了を投げる --EN:--Throw a scream end from Event to EzState after the number of seconds has passed
function OnEvent_5320(proxy,param)
	print("OnEvent_5320 begin");
	proxy:EraseEventSpecialEffect( 817, 5013 );
	
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 5330, "KimeraEzStateSet", 3.0, 1, 807, once );
		proxy:OnKeyTime2( 5331, "HimeiControlWait", 3.0, 0, 5308, once );
	proxy:NotNetMessage_end();
	proxy:SetEventFlag(5308, false);
	print("OnEvent_5320 end");
end

function OnEvent_5321(proxy,param)
	print("OnEvent_5321 begin");
	proxy:EraseEventSpecialEffect( 807, 5013 );
	
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 5330, "KimeraEzStateSet", 3.0, 1, 817, once );
		proxy:OnKeyTime2( 5331, "HimeiControlWait", 3.0, 0, 5309, once );
	proxy:NotNetMessage_end();
	proxy:SetEventFlag(5309, false);
	print("OnEvent_5321 end");
end

function KimeraEzStateSet(proxy,param)
	proxy:SetEventCommand( param:GetParam3(), 500 );
end

--相方の悲鳴抑止フラグを切る --EN:--Turn off the scream suppression flag of the other party
function HimeiControlWait(proxy,param)
	print("HimeiControlWait begin");
	proxy:SetEventFlag( param:GetParam3(), false );
	print("HimeiControlWait end");
end
]]

local BIT_1 =   1;
local BIT_2 =   2;
local BIT_3 =   4;
local BIT_4 =   8;
local BIT_5 =  16;
local BIT_6 =  32;
local BIT_7 =  64;
local BIT_8 = 128;

function Tale_break_5308(proxy,param)
	print("Tale_break_5308 begin");
	proxy:OnRegistFunc( 5315, "Condition_5315", "dummy", 2, once );
	proxy:SetEventFlag( 5308, true );
	print("Tale_break_5308 end");
end



function Condition_5315(proxy,param)
	if	proxy:IsCompleteEvent( 5308 ) == true then
		proxy:SetEventCommand( 807, 600 );
	end
	return false;
end


function OnEvent_5310(proxy,param)
	local acid		= param:GetParam1();
	local main_evid	= 807;
	local sub_evid	= 290;
	if	proxy:IsCompleteEvent( acid ) == true then
		return;
	end
	print("OnEvent_"..acid.." begin");
	proxy:DeleteEvent( 5315 );
	proxy:SetEventFlag( acid, true );
	proxy:SetDispMask( main_evid, BIT_1 + BIT_3 + BIT_5 + BIT_7 );
	proxy:SetDispMask(  sub_evid, BIT_2 + BIT_4 + BIT_6 + BIT_8 );
	proxy:SetHitMask( main_evid, BIT_2 );
	proxy:SetHitMask(  sub_evid, BIT_1 );
	
	ValidCharactor( proxy, sub_evid );
	proxy:CharactorCopyPosAng( main_evid, sub_evid );
	--proxy:OpeningDead( sub_evid, false );
	proxy:PlayLoopAnimation( sub_evid, 9710 );--通常の死亡待機だとボスなのでアルファで消えてしまうため、特殊死亡待機へ --EN:--If it's a normal death wait, it's a boss, so it disappears in alpha, so it's a special death wait
	proxy:EnableHide( sub_evid,true );--隠れます --EN:-- hide
	
--ロックダミポリ無効 --EN:--lock dummy policy disabled
	proxy:SetLockActPntInvalidateMask( main_evid, 221, true );
	--proxy:SetLockActPntInvalidateMask( sub_evid, 201, false );
	
	print("OnEvent_"..acid.." end");
end




function Tale_break_5309(proxy,param)
	print("Tale_break_5309 begin");
	proxy:OnRegistFunc( 5316, "Condition_5316", "dummy", 2, once );
	proxy:SetEventFlag( 5309, true );
	print("Tale_break_5309 end");
end

function Condition_5316(proxy,param)
	if	proxy:IsCompleteEvent( 5309 ) == true then
		proxy:SetEventCommand( 817, 600 );
	end
	return false;
end


function OnEvent_5311(proxy,param)
	local acid		= param:GetParam1();
	local main_evid	= 817;
	local sub_evid	= 291;
	if	proxy:IsCompleteEvent( acid ) == true then
		return;
	end
	print("OnEvent_"..acid.." begin");
	proxy:DeleteEvent( 5316 );
	proxy:SetEventFlag( acid, true );
	proxy:SetDispMask( main_evid, BIT_1 + BIT_3 + BIT_5 + BIT_7 );
	proxy:SetDispMask(  sub_evid, BIT_2 + BIT_4 + BIT_6 + BIT_8 );
	proxy:SetHitMask( main_evid, BIT_2 );
	proxy:SetHitMask(  sub_evid, BIT_1 );
	
	ValidCharactor( proxy, sub_evid );
	proxy:CharactorCopyPosAng( main_evid, sub_evid );
	--proxy:OpeningDead( sub_evid, false );
	proxy:PlayLoopAnimation( sub_evid, 9710 );--通常の死亡待機だとボスなのでアルファで消えてしまうため、特殊死亡待機へ --EN:--If it's a normal death wait, it's a boss, so it disappears in alpha, so it's a special death wait
	proxy:EnableHide( sub_evid,true );--隠れます --EN:-- hide
	
--ロックダミポリ無効 --EN:--lock dummy policy disabled
	proxy:SetLockActPntInvalidateMask( main_evid, 221, true );
	--proxy:SetLockActPntInvalidateMask( sub_evid, 201, false );
	
	print("OnEvent_"..acid.." end");
end



function OnEvent_5254(proxy,param)
	if proxy:IsCompleteEvent( 5254 ) == false then
		print("OnEvent_5254 begin");
		ValidCharactor( proxy, 817 );
		proxy:SetEventFlag( 5254, true );
		proxy:SetBossGauge(817,1,3040);
		proxy:PlayTypeSE( 817, SOUND_TYPE_C, 304077777 );
		print("OnEvent_5254 end");
	end
end


--しっぽが切れていることを送り続ける --EN:-- keep sending that the tail is cut off
function Condition_5312(proxy,param)
	--print("Condition_5312 begin");
	if	proxy:IsCompleteEvent( 5310 ) == true then
		proxy:SendEventRequest( 807, 0, AI_EVENT_KIMERA_TALE_CUT );
	end
	if	proxy:IsCompleteEvent( 5311 ) == true then
		proxy:SendEventRequest( 817, 0, AI_EVENT_KIMERA_TALE_CUT );
	end
	return false;
	--print("Condition_5312 end");
end

function OnEvent_5313(proxy,param)
	print("OnEvent_5313 begin");
	proxy:SetEventSpecialEffect_2( 807, 5013 );
	print("OnEvent_5313 end");
end

function OnEvent_5314(proxy,param)
	print("OnEvent_5314 begin");
	proxy:SetEventSpecialEffect_2( 817, 5013 );
	print("OnEvent_5314 end");
end

