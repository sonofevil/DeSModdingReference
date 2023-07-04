LeechDemonObjBreak_wait_1 = 0.0;
LeechDemonObjBreak_wait_2 = 1.5;
LeechDemonObjBreak_wait_3 = 3.0;
LeechDemonObjBreak_wait_4 = 4.5;

LeechDemonAttachWait	= 1.0;


break_count				= 0;
prevEventId 			= 0;
--------------------------------------------------------------------------------------
--イベント初期化■ボス固有のイベントを登録する際に使用してください --EN:--Event Initialization ■Use this when registering boss-specific events.
--------------------------------------------------------------------------------------
function EventBoss_Initialize_m05_00_00_00(proxy)
	print("EventBoss_Initialize_m05_00_00_00 begin");
	
	if proxy:IsCompleteEvent( 5650 ) == false then --生きていたら --EN:--If you were alive
		--ボス初期化 --EN:--boss initialization
		BossInit_LeechDemon(proxy,param);
	end
	
	--クライアントで無いなら　シングル　or　ホスト --EN:-- Single or host if not a client
	if	proxy:IsClient() == false then
		proxy:RequestForceUpdateNetwork(808);
	end
	
	--■5730～5759■--蛭デーモンイベント　アクションID使用領域 --EN:-- ■ 5730 to 5759 ■ -- Leech daemon event Action ID usage area
	--ダメージ床監視 --EN:--damage floor monitoring
	proxy:SetEventFlag( 5731 , false );		
	if proxy:IsCompleteEvent( 5650 ) == false then --生きていたら		 --EN:--If you were alive
		proxy:OnRegistFunc( 5730, "ConditionFloorDam", "ResultFloorDam", 2, everytime );
	end
	
	--蛭の回復動作フラグをOFF --EN:-- Turn off Leech's recovery action flag
	SingleReset( proxy , 5750 );
	
print("EventBoss_Initialize_m05_00_00_00 end");
end

--------------------------------------------------------------------------------------
--ボス用の初期化処理が必要なときに使用：固有情報の作成等 --EN:--Used when initialization processing for the boss is required: creation of unique information, etc.
--------------------------------------------------------------------------------------
function BossInit_LeechDemon(proxy,param)
	local EVID_LeachDemon = 808;
	
	local acid_list = {5733, 5734, 5735, 5736, 5737, 5738, 5739, 5740 };
	local obj_listA = {1130, 1131, 1132, 1133};
	local obj_listB = {1150, 1151, 1152, 1153};
	local obj_listC = {1154, 1155, 1156, 1157};
	local obj_listD = {1158, 1159, 1160, 1161};
	local obj_listE = {1162, 1163, 1164, 1165};
	local obj_listF = {1166, 1167, 1168, 1169};
	local obj_listG = {1170, 1171, 1172, 1173};
	local obj_listH = {1174, 1175, 1176, 1177};
	local obj_listI = {1178, 1179, 1180, 1181};
	local obj_listlist =  { obj_listA, obj_listB, obj_listC, obj_listD, obj_listE,
							obj_listF, obj_listG, obj_listH, obj_listI };
	local acid_num = table.getn(acid_list);
	
	ObjRestorePiece_list(proxy,param,obj_listlist[1]);
	for index = 1, acid_num, 1 do
		ObjRestorePiece_list(proxy,param,obj_listlist[index+1]);
	end
	
	for index = 1, acid_num, 1 do
		SingleReset( proxy, acid_list[index] );
		if	proxy:IsCompleteEvent( acid_list[index] ) == false then
			ObjInvalid_list(proxy,param,obj_listlist[index+1]);
		else
			ObjInvalid_list(proxy,param,obj_listlist[index]);
		end
	end

	
	proxy:CreateLeechDemon(EVID_LeachDemon);
	
	proxy:RepeatMessage_begin();
		proxy:OnObjectDestroy( 5733, 1130, "CoreObj_Break", once );
		proxy:OnObjectDestroy( 5733, 1131, "CoreObj_Break", once );
		proxy:OnObjectDestroy( 5733, 1132, "CoreObj_Break", once );
		proxy:OnObjectDestroy( 5733, 1133, "CoreObj_Break", once );
		prevEventId = 5733;
	proxy:RepeatMessage_end();
	
	--■5753■蛭デーモンの特殊効果行動開始監視■ --EN:--■ 5753■ Special effect action start monitoring of the leech demon ■
	proxy:OnCheckEzStateMessage( 5753, EVID_LeachDemon, "SpEffect", 401 );
	--■5752■蛭デーモンの特殊効果行動終了監視■ --EN:--■5752■Monitoring the end of special effects of the leech demon■
	proxy:OnCheckEzStateMessage( 5752, EVID_LeachDemon, "RegeneratePossible", 400 );
	
	
	--EzStateへ復活不可を送り続ける --EN:--Keep sending unrecoverable messages to EzState
	proxy:OnRegistFunc( 5751, "RevivePrevent", "dummy", 2, everytime );
	
	
	proxy:OnCharacterDead( 5732 , 808 , "Core_break",once);
	--[[2008.07.28 toyohide コアへのダメージ監視方法変更]] --EN:--[[2008.07.28 Toyohide core damage monitoring method changed]]
	--[[
	if proxy:CreateEventBody( 5732, EVID_LeachDemon, "dummy", 100000000, 1.0, once ) == true then
		proxy:AddEventParts(5732, EVID_LeachDemon, "Ragdoll_c5090_coregard01");
		proxy:AddEventParts(5732, EVID_LeachDemon, "Ragdoll_c5090_coregard02");
		proxy:AddEventParts(5732, EVID_LeachDemon, "Ragdoll_c5090_coregard03");
		proxy:AddEventParts(5732, EVID_LeachDemon, "Ragdoll_c5090_core01");
		proxy:AddEventParts(5732, EVID_LeachDemon, "Ragdoll_c5090_coregard04");
		proxy:SetDisableDamage(5732,true);
		print("BossInit_LeechDemon CreateEventBody is Success");
	else
		print("BossInit_LeechDemon CreateEventBody is Failed");
	end
	
	
	if proxy:CreateEventBodyPlus( 5741, EVID_LeachDemon, "dummy", 10000000, 0.0, 0.0, once ) == true then
		print("BossInit_LeechDemon CreateEventBody is Success");
		proxy:AddEventParts(5741, EVID_LeachDemon, "Ragdoll_c5090_u_body01");
		proxy:AddEventParts(5741, EVID_LeachDemon, "Ragdoll_c5090_c_body01");
		proxy:AddEventParts(5741, EVID_LeachDemon, "Ragdoll_c5090_top_c_body01");
		proxy:AddEventParts(5741, EVID_LeachDemon, "Ragdoll_c5090_top_l_body01");
		proxy:AddEventParts(5741, EVID_LeachDemon, "Ragdoll_c5090_top_r_body01");
		proxy:AddEventParts(5741, EVID_LeachDemon, "Ragdoll_c5090_top_l_body02");
		proxy:AddEventParts(5741, EVID_LeachDemon, "Ragdoll_c5090_top_r_body02");
		proxy:AddEventParts(5741, EVID_LeachDemon, "Ragdoll_c5090_L_upperarm01");
		proxy:AddEventParts(5741, EVID_LeachDemon, "Ragdoll_c5090_R_upperarm01");
		proxy:AddEventParts(5741, EVID_LeachDemon, "Ragdoll_c5090_L_elbow01");
		proxy:AddEventParts(5741, EVID_LeachDemon, "Ragdoll_c5090_R_elbow01");
		proxy:AddEventParts(5741, EVID_LeachDemon, "Ragdoll_c5090_L_hand01");
		proxy:AddEventParts(5741, EVID_LeachDemon, "Ragdoll_c5090_R_hand01");		
	else
		print("BossInit_LeechDemon CreateEventBody is Failed");
	end
	]]
	
	proxy:PlayLoopAnimation(1130,0);
	proxy:PlayLoopAnimation(1131,0);
	proxy:PlayLoopAnimation(1132,0);
	proxy:PlayLoopAnimation(1133,0);
end

--------------------------------------------------------------------------------------
--5730■床ダメージ --EN:--5730 ■ floor damage
--------------------------------------------------------------------------------------
--トリガー判定で5731使用 --EN:--Use 5731 in trigger judgment
function ConditionFloorDam(proxy,param)
	--床ダメージ用ポイントの各イベントID --EN:--Each event ID for floor damage points
	--2130,2131,2132
	local floorTbl = {2130, 2131, 2132};
	local tblnum = table.getn( floorTbl );
	local IsIn = false;
	
	for index = 1, tblnum, 1 do
		if proxy:IsRegionIn( 10000, floorTbl[index] ) == true then
			IsIn = true;
		end
	end
	
	--入った瞬間 --EN:--The moment you enter
	if proxy:IsCompleteEvent( 5731 ) == false and
	   IsIn == true then
	   print("DamageFloor JustIn");
	   proxy:SetEventSpecialEffect(10000, 10060);
	   proxy:EraseEventSpecialEffect(10000, 10260);
	end
	
	--抜け出た瞬間 --EN:--The moment you escape
	if proxy:IsCompleteEvent( 5731 ) == true and
	   IsIn == false then
	   print("DamageFloor JustOut");
	   proxy:EraseEventSpecialEffect(10000, 10060);
	   proxy:SetEventSpecialEffect(10000, 10260);
	end
	
	proxy:SetEventFlag( 5731, IsIn );
	
	--絶対に結果を成立させないよ --EN:--I will never let the result come true
	return false;
end

function ResultFloorDam(proxy,param)
end


--------------------------------------------------------------------------------------
--5732■蛭デーモン部位ダメージ(コア破壊)発動 --EN:--5732 Activate leech demon part damage (core destruction)
--------------------------------------------------------------------------------------
function Core_break(proxy,param)
	print("Core_break begin");
	
	local EVID_LeachDemon = 808;
	--[[
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 5732, "Core_break_1", 0.0, 0, 1, once );
		--proxy:OnKeyTime2( 5732, "Core_break_ObjBroken", 5.0, 0, 2, once );
	proxy:NotNetMessage_end();
	]]
	--proxy:CheckEventBody( 5732 );
	
	--無敵解除 --EN:-- Release invincibility
	--proxy:SetDeadMode( EVID_LeachDemon, false );
	--proxy:EnableInvincible( EVID_LeachDemon, false );
	proxy:SetDisableDamage(5732,false);
	--proxy:SetHp(808, 0.0);
	
	print("break_count = ", break_count);
	local start_id_table = {1130, 1150, 1154, 1158, 1162, 1166, 1170, 1174, 1178};
	local startObjId = start_id_table[break_count+1];
	
	proxy:OnKeyTime2(5732, "CoreObj_Break_shift", LeechDemonObjBreak_wait_1, 0, startObjId + 0, once );
	proxy:OnKeyTime2(5732, "CoreObj_Break_shift", LeechDemonObjBreak_wait_2, 0, startObjId + 1, once );
	proxy:OnKeyTime2(5732, "CoreObj_Break_shift", LeechDemonObjBreak_wait_3, 0, startObjId + 2, once );
	proxy:OnKeyTime2(5732, "CoreObj_Break_shift", LeechDemonObjBreak_wait_4, 0, startObjId + 3, once );

	print("Core_break end");
end

function CoreObj_Break_shift(proxy,param)
	print("CoreObj_Break_shift begin");
	local objId = param:GetParam3();
	if	proxy:IsDestroyed( objId ) == false then
		proxy:ChangeModel( objId, 1 );
		--初速度を設定（主にばらけさせる為） --EN:--Set the initial speed (mainly for dispersion)
		proxy:SetFirstSpeed( objId );
		proxy:SetBrokenPiece( objId );
	end
	print("CoreObj_Break_shift end");
end

--[[
function Core_break_1(proxy,param)
	print("Core_break_1 begin");
	
	--「コア破壊＝死」なので、強制死亡 --EN:-- "Core destruction = death", so forced death
	proxy:ForceDead( 808 );
	
	print("Core_break_1 end");
end
]]

--[[
function Core_break_ObjBroken(proxy,param)
	print("Core_break_ObjBroken begin");
	
	for ObjID = 1130, 1133, 1 do
	end
	
	print("Core_break_ObjBroken end");
end
]]


--蛭デーモン腹のOBJが破壊された --EN:--The leech demon belly OBJ was destroyed
function CoreObj_Break(proxy,param)
	print("CoreObj_Break begin");
	if	proxy:IsCompleteEvent( param:GetParam1() ) == false then
		if	break_count < 6 then
			proxy:SetEventFlag( param:GetParam1(), true );
			proxy:OnKeyTime2( 5750, "ObjChangeWait", LeechDemonAttachWait, 0, 2, once );
		end
		--proxy:EnableInvincible( 808, false );
		proxy:SetDisableDamage(5732,false);
	end
	
	print("CoreObj_Break end");
end

--OBJ交換可能を送り続ける為のフラグON --EN:--Flag ON to keep sending OBJ exchangeable
function ObjChangeWait(proxy,param)
	print("ObjChangeWait begin");
	proxy:SetEventFlag(5750, true);
	print("ObjChangeWait end");
end

--蛭デーモンのAIに今の状態を伝える為の監視 --EN:--monitoring to inform the AI of the leech demon about the current state
function RevivePrevent(proxy,param)
	--5750が成立していると壊れている通知を行う --EN:--do broken notification when 5750 holds
	if	proxy:IsCompleteEvent( 5750 ) == true then
		proxy:SendEventRequest(808,0,AI_EVENT_LEECH_REGENERATE);
	else
		proxy:SendEventRequest(808,0,AI_EVENT_None);
	end
	--絶対に成立しない --EN:-- will never work
	return false;
end

--蛭デーモンが蛭回復行動を始めた --EN:--The leech demon started leech recovery action
function SpEffect(proxy,param)
	print("SpEffect begin");
	local hpRate = proxy:GetHpRate(808);
	local spId = 5050;
	print("HpRate = ",hpRate);
	if hpRate <= 0.70 then spId = 5051; end
	if hpRate <= 0.40 then spId = 5052; end	
	proxy:SetEventSpecialEffect_2( 808 , spId );			
	print("SpEffect end");
end

--OBJの差し替え行動 --EN:--OBJ replacement behavior
function RegeneratePossible(proxy,param)
	if proxy:IsAlive( 808 ) == true then
		print("RegeneratePossible begin");
		if	break_count < 6 then
			print("RegeneratePossible SetNextObj");
			if	break_count >= 2 then
				break_count = 0;
			end
			--実質的にPG内部でアタッチしているOBJを変更させる --EN:-- Practically change the attached OBJ inside the PG
			proxy:Attach_LeechDemon();		
	
			--交換OBJの前計算 --EN:--Pre-computation of exchange OBJ
			local NowObj1 = 1150 + (break_count * 4);
			local NowObj2 = 1151 + (break_count * 4);
			local NowObj3 = 1152 + (break_count * 4);
			local NowObj4 = 1153 + (break_count * 4);
			
			--破壊済みOBJを破壊前の状態に変更 --EN:--Change the destroyed OBJ to the state before destruction
			proxy:RestorePiece( NowObj1 );
			proxy:RestorePiece( NowObj2 );
			proxy:RestorePiece( NowObj3 );
			proxy:RestorePiece( NowObj4 );
			
			--現在のアクションIDを計算 --EN:--calculate the current action id
			local NowEveId = 5734+break_count;
			--登録する前にフラグをOFFにする --EN:--Turn off the flag before registering
			proxy:SetEventFlag( NowEveId , false );
			
			--破壊を監視 --EN:--watch for destruction
			proxy:RepeatMessage_begin();
				proxy:OnObjectDestroy( NowEveId, NowObj1, "CoreObj_Break", once );
				proxy:OnObjectDestroy( NowEveId, NowObj2, "CoreObj_Break", once );
				proxy:OnObjectDestroy( NowEveId, NowObj3, "CoreObj_Break", once );
				proxy:OnObjectDestroy( NowEveId, NowObj4, "CoreObj_Break", once );
			proxy:RepeatMessage_end();
			--前のイベントを削除 --EN:--delete previous event
			proxy:DeleteEvent( prevEventId );
			--現在のを記憶 --EN:-- remember current
			prevEventId = NowEveId;
			
			--[[--破壊をずらす処理 --EN:--Processing to shift destruction
			proxy:NotNetMessage_begin();
				proxy:OnKeyTime2( 5734,"RegeneratePossible_1",0.1,0,10,once);
			proxy:NotNetMessage_end();
			]]
			
			--非表示になって隠れている場合があるので表示する --EN:-- Show because it may be hidden and hidden
			proxy:SetDrawEnable(NowObj1, true);
			proxy:SetDrawEnable(NowObj2, true);
			proxy:SetDrawEnable(NowObj3, true);
			proxy:SetDrawEnable(NowObj4, true);
			
			--アタリを消して隠れている場合があるので戻す --EN:--Erase the Atari and put it back because it may be hidden
			proxy:SetColiEnable(NowObj1, true);
			proxy:SetColiEnable(NowObj2, true);
			proxy:SetColiEnable(NowObj3, true);
			proxy:SetColiEnable(NowObj4, true);		
			
			--待機アニメを行ってなかったので --EN:--Because I didn't do the standby animation
			proxy:PlayLoopAnimation( NowObj1, 0 );
			proxy:PlayLoopAnimation( NowObj2, 0 );
			proxy:PlayLoopAnimation( NowObj3, 0 );
			proxy:PlayLoopAnimation( NowObj4, 0 );
			
			--proxy:EnableInvincible( 808, true );
			--現在ではいらないけどとりあえずイベント部位無敵化 --EN:--I don't need it now, but for the time being, make event parts invincible
			proxy:SetDisableDamage(5732,true);
			
			--破壊OBJのカウントの管理 --EN:--Managing the count of destroyed OBJs
			break_count = break_count + 1;
			--local Next = break_count*4+1150;
			--proxy:WARN("break_count = "..break_count.." NextObj = "..Next);
			proxy:SetEventFlag(5750, false);--ここで復活不可の設定に変更 --EN:-- Change the setting here so that recovery is not possible
		end
		print("RegeneratePossible end");
	else
		proxy:WARN("RegeneratePossible error");
	end
end

--[[
function RegeneratePossible_1(proxy,param)
	print("RegeneratePossible_1 begin");
	proxy:RepeatMessage_begin();
		proxy:OnObjectDestroy( 5734 + break_count, 1150 + ( break_count * 4 ), "CoreObj_Break", once );
		proxy:OnObjectDestroy( 5734 + break_count, 1151 + ( break_count * 4 ), "CoreObj_Break", once );
		proxy:OnObjectDestroy( 5734 + break_count, 1152 + ( break_count * 4 ), "CoreObj_Break", once );
		proxy:OnObjectDestroy( 5734 + break_count, 1153 + ( break_count * 4 ), "CoreObj_Break", once );
	proxy:RepeatMessage_end();
end
]]


function ObjRestorePiece_list(proxy,param,obj_list)
	local obj_num = table.getn(obj_list);
	for index = 1, obj_num, 1 do
		local objId = obj_list[index];
		proxy:RestorePiece(objId);
	end
end


function ObjInvalid_list(proxy,param,obj_list)
	local obj_num = table.getn(obj_list);
	for index = 1, obj_num, 1 do
		local objId = obj_list[index];
		proxy:SetColiEnable( objId, false );
		proxy:SetDrawEnable( objId, false );
	end
end

