
--DRAGON_EVENTDAMAGE = 100;--ダメージリアクションするHP --EN:-- HP for damage reaction
DRAGON_EVENTDAMAGE = 64.52;--ダメージリアクションするHP --EN:-- HP for damage reaction
DRAGON_DAMAGE_RATE = 1.0;--ダメージ控除率 --EN:--Damage Reduction Rate
DRAGON_NODAMAGE = 10000000;--無敵箇所のHP --EN:--Invincible HP

OBJ_ATTACK1 = 0;
OBJ_ATTACK2 = 0;
OBJ_ATTACK3 = 0;
OBJ_ATTACK4 = 0;
OBJ_ATTACK5 = 0;
OBJ_ATTACK6 = 0;
OBJ_ATTACK7 = 0;
OBJ_ATTACK8 = 0;
OBJ_ATTACK9 = 0;
OBJ_ATTACK10= 0;

ObjAttack_list1 = {1130,1131,1132,1133,1134};
ObjAttack_list2 = {1135,1136,1137,1138,1139};
ObjAttack_list3 = {1140,1141,1142,1143,1144};
ObjAttack_list4 = {1145,1146,1147,1148,1149};
ObjAttack_list5 = {1150,1151,1152,1153,1154};
ObjAttack_list6 = {1155,1156,1157,1158,1159};
ObjAttack_list7 = {1160,1161,1162,1163,1164};
ObjAttack_list8 = {1165,1166,1167,1168,1169};
ObjAttack_list9 = {1170,1171,1172,1173,1174};
ObjAttack_list10= {1175,1176,1177,1178,1179};


--------------------------------------------------------------------------------------
--イベント初期化■ボス固有のイベントを登録する際に使用してください --EN:--Event Initialization ■Use this when registering boss-specific events.
--------------------------------------------------------------------------------------
function EventBoss_Initialize_m06_02_00_00(proxy)
	print("EventBoss_Initialize_m06_02_00_00 begin");
	if proxy:IsCompleteEvent( 6400 ) == false then
		proxy:LuaCall( 1090,2,"OnEvent_1090",everytime);
		--初回攻撃判定フラグ　1072 --EN:-- First attack judgment flag 1072
		--2回戦攻撃判定フラグ 1082 --EN:--Second round attack judgment flag 1082
		--最終攻撃判定フラグ 1091 --EN:--Final attack judgment flag 1091
		--■1101■フラグ同期用■ --EN:-- ■ 1101 ■ For flag synchronization ■
		proxy:LuaCall( 1101, 1 ,"OnEvent_1101_1",everytime );
		proxy:LuaCall( 1101, 2 ,"OnEvent_1101_2",everytime );
		proxy:LuaCall( 1101, 3 ,"OnEvent_1101_3",everytime );
		if proxy:IsClient() == false then		
			proxy:RequestForceUpdateNetwork( 825 );
		end
		proxy:OnKeyTime2(1101,"BossInit_m06_02_00_00_Second_Initialize",0,0,0,once);
				
		Lua_RegistAttackEvent( proxy, ObjAttack_list1[1] , 1450 );		
		Lua_RegistAttackEvent( proxy, ObjAttack_list2[1] , 1451 );	
		Lua_RegistAttackEvent( proxy, ObjAttack_list3[1] , 1452 );
		Lua_RegistAttackEvent( proxy, ObjAttack_list4[1] , 1453 );
		Lua_RegistAttackEvent( proxy, ObjAttack_list5[1] , 1454 );
		Lua_RegistAttackEvent( proxy, ObjAttack_list6[1] , 1455 );
		Lua_RegistAttackEvent( proxy, ObjAttack_list7[1] , 1456 );
		
	else
		proxy:ReconstructBreak( 1450 , 1 );
		proxy:ReconstructBreak( 1451 , 1 );
		proxy:ReconstructBreak( 1452 , 1 );
		proxy:ReconstructBreak( 1453 , 1 );
		proxy:ReconstructBreak( 1454 , 1 );
		proxy:ReconstructBreak( 1455 , 1 );
		proxy:ReconstructBreak( 1456 , 1 );
		--proxy:ReconstructBreak( 1457 , 1 );
		--proxy:ReconstructBreak( 1458 , 1 );
		--proxy:ReconstructBreak( 1459 , 1 );
	end
	
	
	--OBJ_ATTACK8 = Lua_RegistAttackEvent( proxy, ObjAttack_list8 , 1457 );
	--OBJ_ATTACK9 = Lua_RegistAttackEvent( proxy, ObjAttack_list9 , 1458 );
	--OBJ_ATTACK10= Lua_RegistAttackEvent( proxy, ObjAttack_list10, 1459 );

	--[[
	SingleReset( proxy , 1130 );--1回 --EN:--Once
	SingleReset( proxy , 1131 );--2回 --EN:--Twice
	SingleReset( proxy , 1132 );--3回 --EN:--3 times
	SingleReset( proxy , 1133 );--4回(破壊)	 --EN:--4 times (Destruction)
	SingleReset( proxy , 1134 );--破壊	 --EN:--destruction
	--1回も当ててない --EN:--Didn't guess even once
	if proxy:IsCompleteEvent(1130) == false then
		proxy:LuaCall( 1130 , 0 , "OnEvent_1130_0",once);
	else
		OBJ_ATTACK1 = 1;
	end	
	--2回目当ててない --EN:--I didn't aim for the second time
	if proxy:IsCompleteEvent(1131) == false then
		proxy:LuaCall( 1130 , 1 , "OnEvent_1130_1",once);
	else
		OBJ_ATTACK1 = 2;
	end	
	--3回目当ててない --EN:--I'm not looking for the 3rd time
	if proxy:IsCompleteEvent(1132) == false then
		proxy:LuaCall( 1130 , 2 , "OnEvent_1130_2",once);
	else
		OBJ_ATTACK1 = 3;
	end	
	--4回目当ててない --EN:-- 4th time not looking
	if proxy:IsCompleteEvent(1133) == false then
		proxy:LuaCall( 1130 , 3 , "OnEvent_1130_3",once);
	end	
	if OBJ_ATTACK1 >=1 then
		proxy:EndAnimation(1450 , OBJ_ATTACK1 );
	end	
	--OBJがまだ破壊されていない --EN:--OBJ not yet destroyed
	if proxy:IsCompleteEvent(1134) == false then
		proxy:OnObjectDestroy( 1134 , 1450 , "OnEvent_1134_destroy",once);
		--攻撃を当てた！ --EN:--You hit!
		proxy:OnSimpleDamage( 1134 , 1450 , 10000 , "OnEvent_1134",everytime );	
	else
		proxy:ReconstructBreak( 1450 , 1 );
	end
	]]
	print("EventBoss_Initialize_m06_02_00_00 end");
end

--ボスの2段階目初期化 --EN:-- Boss 2nd stage initialization
function BossInit_m06_02_00_00_Second_Initialize(proxy,param)
	print("BossInit_m06_02_00_00_Second_Initialize begin");
	--proxy:DisableDamage( 825, true);--ダメージ入らない --EN:--No damage
	proxy:SetSuperArmor( 825, true);--スーパーアーマー --EN:--Super Armor
	if proxy:CreateEventBody( 1104,825,"OnEvent_1104",DRAGON_EVENTDAMAGE,DRAGON_DAMAGE_RATE,everytime) == true then		
		proxy:AddEventParts(1104,825,"Ragdoll_Jaw_Tip01");		
		proxy:AddEventParts_Ignore(1104,825,"Ragdoll_Neck");
		proxy:AddEventParts_Ignore(1104,825,"Ragdoll_Neck1");
		proxy:AddEventParts_Ignore(1104,825,"Ragdoll_Neck2");
		proxy:SetEventBodyMaterialSeAndSfx( 1104 , 74 , 74 );
		proxy:SetDisableDamage( 1104 , true );--部位ダメージ無効 --EN:--partial damage disabled
		print("Create EventBody by DragonDemonHead");
	else
		print("Faild EventBody by DragonDemonHead");
	end
	
	if proxy:CreateEventBody( 1105,825,"OnEvent_1105",DRAGON_NODAMAGE,0.001,everytime) == true then
	
		proxy:AddEventParts_Ignore(1105,825,"Ragdoll_Pelvis");		
		proxy:AddEventParts_Ignore(1105,825,"Ragdoll_Spine");
		proxy:AddEventParts_Ignore(1105,825,"Ragdoll_Spine1");
		proxy:AddEventParts_Ignore(1105,825,"Ragdoll_Spine2");				
		proxy:AddEventParts_Ignore(1105,825,"Ragdoll_L_Clavicle");		
		proxy:AddEventParts_Ignore(1105,825,"Ragdoll_L_UpperArm");
		proxy:AddEventParts_Ignore(1105,825,"Ragdoll_L_Forearm");
		proxy:AddEventParts_Ignore(1105,825,"Ragdoll_L_Hand");
		proxy:AddEventParts_Ignore(1105,825,"Ragdoll_L_Finger05");
		proxy:AddEventParts_Ignore(1105,825,"Ragdoll_L_Finger3");
		proxy:AddEventParts_Ignore(1105,825,"Ragdoll_L_Finger01");		
		proxy:AddEventParts_Ignore(1105,825,"Ragdoll_L_Finger31");
		proxy:AddEventParts_Ignore(1105,825,"Ragdoll_L_Finger06");
		proxy:AddEventParts_Ignore(1105,825,"Ragdoll_L_Finger02");		
		proxy:AddEventParts_Ignore(1105,825,"Ragdoll_L_Finger32");
		proxy:AddEventParts_Ignore(1105,825,"Ragdoll_L_Finger07");		
		proxy:AddEventParts_Ignore(1105,825,"Ragdoll_L_Finger04");		
		proxy:AddEventParts_Ignore(1105,825,"Ragdoll_R_Clavicle");
		proxy:AddEventParts_Ignore(1105,825,"Ragdoll_R_UpperArm");
		proxy:AddEventParts_Ignore(1105,825,"Ragdoll_R_Forearm");
		proxy:AddEventParts_Ignore(1105,825,"Ragdoll_R_Hand");
		proxy:AddEventParts_Ignore(1105,825,"Ragdoll_R_Finger01");		
		proxy:AddEventParts_Ignore(1105,825,"Ragdoll_R_Finger3");
		proxy:AddEventParts_Ignore(1105,825,"Ragdoll_R_Finger31");
		proxy:AddEventParts_Ignore(1105,825,"Ragdoll_R_Finger32");	
		proxy:AddEventParts_Ignore( 1105,825,"Ragdoll_Head");
		proxy:AddEventParts_Ignore( 1105,825,"Ragdoll_R_Finger02");
		proxy:AddEventParts_Ignore( 1105,825,"Ragdoll_R_Finger04");			
	
		print("Create EventBody by DragonDemonBody");
	else
		print("Faild EventBody by DragonDemonBody");
	end	
	print("BossInit_m06_02_00_00_Second_Initialize end");
end

function StandBy_DragonDemon(proxy,param)
	print("StandBy_DragonDemon begin");
	proxy:SetEventBodyMaxHp(1104,DRAGON_EVENTDAMAGE);		
	print("StandBy_DragonDemon end");
end

--------------------------------------------------------------------------------------
--ボス用の初期化処理が必要なときに使用：固有情報の作成等 --EN:--Used when initialization processing for the boss is required: creation of unique information, etc.
--------------------------------------------------------------------------------------
function BossInit_DragonDemon(proxy,param)	
	print("BossInit_DragonDemon begin");
	proxy:NotNetMessage_begin();
	proxy:RepeatMessage_begin();
	--■1070,1071,1072■ボス待機　【縫いつけ前】■ --EN:--■ 1070, 1071, 1072 ■ Boss standby [Before sewing] ■
		if proxy:IsCompleteEvent( 1070 ) == false then
			proxy:Warp( 825, 2460);--位置あわせ --EN:--Alignment
			if proxy:IsGreyGhost() == true or proxy:IsLivePlayer() == true then
				--proxy:OnChrAnimEnd( 1070, 825, 9010, "OnEvent_1070", once );
				--proxy:OnKeyTime2( 1070,"OnEvent_1070",DRAGON_CHECK_TIME,0,0,once);
				--proxy:ForcePlayAnimation( 825, 9010 );				
				proxy:LuaCallStartPlus( 1090, 2, 410 );--待機立ち見て無いを同期 --EN:--Synchronize no waiting
			else
				--取り合えず初回のアニメ同期は保留 --EN:--For the time being, the first animation synchronization is put on hold
			end			
		end
	proxy:RepeatMessage_end();
	proxy:NotNetMessage_end();
	
	--初回攻撃判定フラグ　1072 --EN:-- First attack judgment flag 1072
	--2回戦攻撃判定フラグ 1082 --EN:--Second round attack judgment flag 1082
	--最終攻撃判定フラグ 1091 --EN:--Final attack judgment flag 1091
	--■1100■ボス攻撃判定用監視■ --EN:-- ■ 1100 ■ Monitoring for boss attack determination ■
	proxy:OnRegistFunc( 1100 , "Check_1100","OnEvent_1100",1,once);
	
	local eveidlist 	= {1210,1211,1212,1213,1214,1215,1216,1217,1218,1219,1220,1221,1222,1223,1224,1225,1226};
	local regionlist 	= {2434,2433,2432,2431,2435,2436,2430,2427,2426,2425,2424,2423,2422,2421,2420,2428,2429};
	local num = table.getn( regionlist );
	
	for index = 1, num , 1 do
		SingleReset( proxy, eveidlist[ index] );
		proxy:OnNetRegion( eveidlist[ index ] , regionlist[ index ] );
	end
	
	
	print("BossInit_DragonDemon end");
end


--ボス片手縫い付け待機へ変更 --EN:--Changed to Boss one-hand sewing standby
function ChangeWait_1(proxy,param)
	proxy:DeleteEvent( 1070 );
	proxy:DeleteEvent( 1071 );
	proxy:RepeatMessage_begin();
		proxy:OnChrAnimEnd( 1080, 825, 10, "OnEvent_1080", once );
	proxy:RepeatMessage_end();
	--proxy:ForcePlayAnimation( 825, 10 );
	proxy:SetEventCommand( 825,430);
	proxy:Warp( 825, 2461);--位置あわせ --EN:--Alignment
end


--ボス両手縫い付け待機へ変更 --EN:--Changed to Boss both hands sewing standby
function ChangeWait_2(proxy,param)
	proxy:DeleteEvent( 1080 );
	proxy:DeleteEvent( 1081 );
	--proxy:ForcePlayAnimation( 825, 20 );
	--proxy:LuaCallStartPlus( 1101, 3, 1 );--1091フラグON同期 --EN:--1091 Flag ON Synchronization
	proxy:SetEventCommand( 825, 440);
	--proxy:DisableDamage( 825, false);--ダメージ入る --EN:--damage
	proxy:SetDisableDamage( 1104 , false );--部位ダメージ有効 --EN:--partial damage enabled
	proxy:Warp( 825, 2462);--位置あわせ --EN:--Alignment
end



--------------------------------------------------------------------------------------
--■1070,1071,1072■ボス待機　【縫いつけ前】■ --EN:--■ 1070, 1071, 1072 ■ Boss standby [Before sewing] ■
--------------------------------------------------------------------------------------
--■1070,1071,1072■ボス待機　【縫いつけ前】■ --EN:--■ 1070, 1071, 1072 ■ Boss standby [Before sewing] ■
function OnEvent_1070(proxy,param)
	print("OnEvent_1070 begin");
	proxy:NotNetMessage_begin();
	proxy:RepeatMessage_begin();
		proxy:OnChrAnimEnd( 1071, 825, 9011, "OnEvent_1071", once );
	proxy:RepeatMessage_end();
	proxy:NotNetMessage_end();
	--proxy:LuaCallStartPlus( 1090, 2, 9011 );
	proxy:LuaCallStartPlus( 1101, 1, 0);--1072OFF同期 --EN:--1072OFF Synchronization
	print("OnEvent_1070 end");
end

function OnEvent_1071(proxy,param)
	print("OnEvent_1071 begin");
	proxy:NotNetMessage_begin();
	proxy:RepeatMessage_begin();
		proxy:OnChrAnimEnd( 1070, 825, 9010, "OnEvent_1070", once );
	proxy:RepeatMessage_end();
	proxy:NotNetMessage_end();
	--proxy:LuaCallStartPlus( 1090, 2, 9010 );
	proxy:LuaCallStartPlus( 1101, 1, 1 );--1072ON同期 --EN:--1072ON Synchronization
	print("OnEvent_1071 end");
end




--------------------------------------------------------------------------------------
--■1080,1081,1082■ボス待機　【片手縫いつけ】■ --EN:--■ 1080, 1081, 1082 ■ Boss standby [one hand sewing] ■
--------------------------------------------------------------------------------------
--■1080,1081,1082■ボス待機　【片手縫いつけ】■ --EN:--■ 1080, 1081, 1082 ■ Boss standby [one hand sewing] ■
function OnEvent_1080(proxy,param)
	print("OnEvent_1080 begin");
	proxy:NotNetMessage_begin();
	proxy:RepeatMessage_begin();
		proxy:OnChrAnimEnd( 1081, 825,   9012, "OnEvent_1081", once );
	proxy:RepeatMessage_end();
	proxy:NotNetMessage_end();
	--proxy:LuaCallStartPlus( 1090, 2, 9012 );
	proxy:LuaCallStartPlus( 1101, 2, 1 );--1082ON同期 --EN:--1082 ON Synchronization
	print("OnEvent_1080 end");
end

function OnEvent_1081(proxy,param)
	print("OnEvent_1081 begin");
	proxy:NotNetMessage_begin();
	proxy:RepeatMessage_begin();
		proxy:OnChrAnimEnd( 1080, 825, 10, "OnEvent_1080", once );
	proxy:RepeatMessage_end();
	proxy:NotNetMessage_end();
	--proxy:LuaCallStartPlus( 1090, 2, 10 );
	proxy:LuaCallStartPlus( 1101, 2, 0 );--1082OFF同期 --EN:--1082OFF Synchronization
	print("OnEvent_1081 end");
end


--------------------------------------------------------------------------------------
--■1090■ボスアニメ同期用 --EN:-- ■ 1090 ■ For boss animation synchronization
--------------------------------------------------------------------------------------
function OnEvent_1090(proxy,param)
	print("OnEvent_1090 begin");
	---proxy:PlayAnimation( 825, param:GetParam3() );
	---EzState命令へ変更 --EN:--Changed to EzState instruction
	proxy:SetEventCommand( 825, param:GetParam3() );
	print("OnEvent_1090 end");
end


--------------------------------------------------------------------------------------
--■1100■ボス攻撃領域監視 --EN:-- ■ 1100 ■ boss attack area monitoring
--------------------------------------------------------------------------------------
function Check_1100(proxy,param)
	if proxy:IsAlive(825) == true then
		--見ているか見ていないかはEzStateで遷移できるはず --EN:--You should be able to transition with EzState whether you are watching or not
		--if proxy:IsCompleteEvent(1072) == true then
			if DragonDemon_Stage_1(proxy,param) == true then
				return false;
			end
		--end
		--if proxy:IsCompleteEvent(1082) == true then
			if DragonDemon_Stage_2(proxy,param) == true then
				return false;
			end
		--end
		--if proxy:IsCompleteEvent(1091) == true then
			if DragonDemon_Stage_3(proxy,param) == true then
				return false;
			end
		--end
		--どこにも該当しなかったのでスルー --EN:--I didn't fit anywhere, so I passed through
		proxy:SendEventRequest( 825 , 0 , AI_EVENT_NONE );		
		return false;
	else		--
		return true;
	end
end

--初期段階の攻撃判定 --EN:--Initial attack detection
function DragonDemon_Stage_1(proxy,param)
	--print("DragonDemon_Stage_1 test");
	--ターゲットしているキャラクタのイベントIDを取得 --EN:-- Get the event ID of the targeted character
	--local targetID = proxy:GetTargetChrID(825);	
	--proxy:IsRegionIn( targetID, ???? ) == true
	--if targetID ~= -1 then
		
		--パンチ4攻撃判定 --EN:--Punch 4 attack judgment
		--2426、2427 --EN:2426, 2427
		if 	proxy:IsCompleteEvent( 1218 ) == true or
			proxy:IsCompleteEvent( 1217 ) == true then
			proxy:SendEventRequest( 825 , 0 , AI_EVENT_PUNCH4 );
			--EzStateにも居る事を通知 --EN:--Notify that you are also in EzState
			proxy:SetEventCommandIndex( 825 , 450 , 1 );
			return true;
		end
		
		--パンチ3攻撃判定		 --EN:--Punch 3 attack judgment
		if 	proxy:IsCompleteEvent( 1220 ) == true or
			proxy:IsCompleteEvent( 1219 ) == true then
			proxy:SendEventRequest( 825 , 0 , AI_EVENT_PUNCH3 );
			--EzStateにも居る事を通知 --EN:--Notify that you are also in EzState
			proxy:SetEventCommandIndex( 825 , 450 , 1 );
			return true;
		end
		
		--パンチ2攻撃判定		 --EN:--Punch 2 attack judgment
		if 	proxy:IsCompleteEvent( 1224 ) == true or
			proxy:IsCompleteEvent( 1223 ) == true or
			proxy:IsCompleteEvent( 1222 ) == true or
			proxy:IsCompleteEvent( 1221 ) == true then
			proxy:SendEventRequest( 825 , 0 , AI_EVENT_PUNCH2 );
			--EzStateにも居る事を通知 --EN:--Notify that you are also in EzState
			proxy:SetEventCommandIndex( 825 , 450 , 1 );
			return true;
		end		
		
		--パンチ1攻撃判定 --EN:--Punch 1 attack judgment
		if  proxy:IsCompleteEvent( 1225 ) == true or
			proxy:IsCompleteEvent( 1226 ) == true then			
			proxy:SendEventRequest( 825 , 0 , AI_EVENT_PUNCH1 );
			--EzStateにも居る事を通知 --EN:--Notify that you are also in EzState
			proxy:SetEventCommandIndex( 825 , 450 , 1 );
			return true;
		end	
	--end		
	return false;	
end

--第2段階の攻撃判定 --EN:-- 2nd stage attack detection
function DragonDemon_Stage_2(proxy,param)
	--print("DragonDemon_Stage_2 test");
	--local targetID = proxy:GetTargetChrID(825);	
	--proxy:IsRegionIn( targetID, ???? ) == true
	--if targetID ~= -1 then				
		
		--ブレス4攻撃判定 --EN:--Breath 4 Attack Judgment
		--2434
		if 	proxy:IsCompleteEvent( 1210 ) == true then
			--EzStateにも居る事を通知 --EN:--Notify that you are also in EzState
			proxy:SetEventCommandIndex( 825 , 450 , 1 );
			proxy:SendEventRequest( 825 , 0 , AI_EVENT_BREATH4 );
			return true;
		end
		
		--ブレス3攻撃判定 --EN:--Breath 3 Attack Judgment
		--2433
		if 	proxy:IsCompleteEvent( 1211 ) == true then
			--EzStateにも居る事を通知 --EN:--Notify that you are also in EzState
			proxy:SetEventCommandIndex( 825 , 450 , 1 );
			proxy:SendEventRequest( 825 , 0 , AI_EVENT_BREATH3 );
			return true;
		end
		
		--ブレス2攻撃判定 --EN:--Breath 2 Attack Judgment
		--2431、2432 --EN:2431, 2432
		if 	proxy:IsCompleteEvent( 1213 ) == true or
			proxy:IsCompleteEvent( 1212 ) == true then
			--EzStateにも居る事を通知 --EN:--Notify that you are also in EzState
			proxy:SetEventCommandIndex( 825 , 450 , 1 );
			proxy:SendEventRequest( 825 , 0 , AI_EVENT_BREATH2 );
			return true;
		end
		
		--ブレス1攻撃判定 --EN:--Breath 1 Attack Judgment
		--2430、2435、2436 --EN:2430, 2435, 2436
		if 	proxy:IsCompleteEvent( 1216 ) == true or
			proxy:IsCompleteEvent( 1224 ) == true or
			proxy:IsCompleteEvent( 1215 ) == true then
			--EzStateにも居る事を通知 --EN:--Notify that you are also in EzState
			proxy:SetEventCommandIndex( 825 , 450 , 1 );
			proxy:SendEventRequest( 825 , 0 , AI_EVENT_BREATH1 );
			return true;
		end
		
	--end
	
	return false;	
end

--最終段階の攻撃判定 --EN:--Final attack detection
function DragonDemon_Stage_3(proxy,param)
	--print("DragonDemon_Stage_3 test");
	--print("DragonDemon_Stage_2 test");
	local targetID = proxy:GetTargetChrID(825);	
	--proxy:IsRegionIn( targetID, ???? ) == true
	if targetID ~= -1 then
		--噛み付き攻撃判定 --EN:--Bite attack detection
		--2450
		if 	proxy:IsRegionIn( targetID, 2450 ) == true then
			proxy:SendEventRequest( 825 , 0 , AI_EVENT_BITEATTACK );
			return true;
		end
	end
	return false;
end


--ボス死んだ --EN:--boss dead
function OnEvent_1100(proxy,param)
	print("OnEvent_1100 begin");
	print("DragonDemon Dead");
	print("OnEvent_1100 end");
end


--初回攻撃判定フラグ　同期用	 --EN:--First attack judgment flag Synchronization
function OnEvent_1101_1(proxy,param)
	print("OnEvent_1101_1 flag set");
	if param:GetParam3() == 1 then
		proxy:SetEventFlag( 1072 ,true );
	else
		proxy:SetEventFlag( 1072 ,false );
		proxy:SendEventRequest( 825 , 0 , AI_EVENT_NONE );
	end
	proxy:SetEventFlag( 1082 ,false);
	proxy:SetEventFlag( 1091 ,false);
end

--2回戦攻撃判定用 --EN:--For 2nd round attack judgment
function OnEvent_1101_2(proxy,param)
	print("OnEvent_1101_2 flag set");
	if param:GetParam3() == 1 then
		proxy:SetEventFlag( 1082 ,true );
	else
		proxy:SetEventFlag( 1082 ,false );
		proxy:SendEventRequest( 825 , 0 , AI_EVENT_NONE );
	end
	proxy:SetEventFlag( 1072 ,false);
	proxy:SetEventFlag( 1091 ,false);
end

--最終段階同期用 --EN:--For final stage synchronization
function OnEvent_1101_3(proxy,param)
	print("OnEvent_1101_3 flag set");
	if param:GetParam3() == 1 then
		proxy:SetEventFlag( 1091 ,true );
	else
		proxy:SetEventFlag( 1091 ,false );
		proxy:SendEventRequest( 825 , 0 , AI_EVENT_NONE );
	end
	proxy:SetEventFlag( 1082 ,false);
	proxy:SetEventFlag( 1072 ,false);
end



--------------------------------------------------------------------------------------
--■1104■ボスリアクション --EN:-- ■ 1104 ■ boss reaction
--------------------------------------------------------------------------------------
function OnEvent_1104(proxy,param)
	print("OnEvent_1104 begin");
	if proxy:IsAlive( 825 ) == true then
		proxy:PlayAnimation( 825,2000);
		proxy:CheckEventBody(1104);
	end
	print("OnEvent_1104 end");
end

--------------------------------------------------------------------------------------
--■1105■ボスノーダメージ部位 --EN:-- ■ 1105 ■ boss snow damage part
--------------------------------------------------------------------------------------
function OnEvent_1105(proxy,param)
	print("OnEvent_1105 begin");	
	proxy:CheckEventBody(1105);
	print("OnEvent_1105 end");
end


--[[
------OBJ破壊イベント量産用 --EN:--For OBJ destruction event mass production
function Lua_RegistAttackEvent( proxy, list , objId )
	
	local index = 0;
	local num = table.getn( list );	
	local count = 0;
	for index=1 , num , 1 do
		if proxy:IsCompleteEvent( 1070 ) == false then
			SingleReset( proxy , list[index] );
			proxy:RestorePiece( objId );
		end
		if index < num then
			local par = index -1;
			if proxy:IsCompleteEvent( list[index] ) == false then
				proxy:LuaCall( list[1] , par , "OnEvent_"..list[1].."_"..par,once);
			else
				count = index;
			end
		else
			--OBJがまだ破壊されていない --EN:--OBJ not yet destroyed
			if proxy:IsCompleteEvent(list[index]) == false then
				proxy:OnObjectDestroy( list[index] , objId , "OnEvent_"..list[index].."_destroy",once);
				--攻撃を当てた！ --EN:--You hit!
				proxy:OnSimpleDamage( list[index] , objId , 10000 , "OnEvent_"..list[index],everytime );
			else
				proxy:ReconstructBreak( objId , 1 );
			end
		end		
	end
	if count >=1 then
		if count < (num-2) then
			proxy:EndAnimation( objId , count );
		else
			proxy:ReconstructBreak( objId, 1);
		end
	end	
	return count;
end


-----ダメージ監視用 --EN:--For damage monitoring
function Lua_RegistDamage(proxy,maxId,minId,objId,Attack,maxAttack)
	print("OnEvent_",maxId," begin");
	print("ATTACK ",Attack);
	if Attack < maxAttack then
		if proxy:IsEventAnim( objId , Attack+1 ) == false then
			--アニメ配信 --EN:--Animation distribution
			proxy:CustomLuaCallStartPlus( SYNCHROANIM , objId ,Attack+1 );
			proxy:NotNetMessage_begin();
			proxy:RepeatMessage_begin();
				--発動者が責任をもってアニメを監視 --EN:--Invoker responsibly monitors anime
				proxy:OnObjAnimEnd( maxId , objId , Attack+1 , "OnEvent_"..maxId.."_1",once);
			proxy:RepeatMessage_end();
			proxy:NotNetMessage_end();
		end
	else
		proxy:LuaCallStart( minId , Attack );		
	end
	print("OnEvent_",maxId," end");
end

--カウントアップ配信 --EN:-- Count-up delivery
function Lua_ObjAttack(proxy,eventId,count)
	print("OnEvent_",eventId,"_",count," begin");
	proxy:SetEventFlag( eventId+count+1 , true );
	print("OnEvent_",eventId,"_",count," end");
	return count+1;
end

--破壊配信 --EN:--destroy delivery
function Lua_ObjBrake(proxy,eventId,setflag,objId,count,soundId)
	print("OnEvent_",eventId,"_3 begin");
	proxy:ChangeModel( objId , 1 );
	proxy:SetBrokenPiece( objId );
	proxy:PlayTypeSE( objId, SOUND_TYPE_O, soundId );
	proxy:SetEventFlag( setflag , true );
	print("OnEvent_",eventId,"_3 end");
	return count;
end

--後始末 --EN:--Cleaning up
function Lua_after(proxy,maxId,minId)
	print("OnEvent_",maxId,"_destroy beign");
	proxy:DeleteEvent( minId );
	proxy:DeleteEvent( maxId );
	proxy:SetEventFlag( maxId , true );
	print("OnEvent_",maxId,"_destroy end");
end

--------------------------------------------------------------------------------------
--■1130～1134■OBJ段階破壊ダメージ当たった --EN:-- ■ 1130-1134 ■ OBJ stage destruction damage hit
--------------------------------------------------------------------------------------
function OnEvent_1134(proxy,param)
	if proxy:IsCompleteEvent( 1134 ) == false then
		Lua_RegistDamage(proxy,1134,1130,1450,OBJ_ATTACK1,3);
	end
	--[[
	print("OnEvent_1134 begin");
	print("OBJ_ATTACK1 ",OBJ_ATTACK1);
	if OBJ_ATTACK1 < 3 then
		if proxy:IsEventAnim( 1450 , OBJ_ATTACK1+1 ) == false then
			--アニメ配信 --EN:--Animation distribution
			proxy:CustomLuaCallStartPlus( SYNCHROANIM , 1450 ,OBJ_ATTACK1+1 );
			proxy:NotNetMessage_begin();
			proxy:RepeatMessage_begin();
				--発動者が責任をもってアニメを監視 --EN:--Invoker responsibly monitors anime
				proxy:OnCharacterAnimEnd( 1134 , 1450 , OBJ_ATTACK1+1 , "OnEvent_1134_1",once);
			proxy:RepeatMessage_end();
			proxy:NotNetMessage_end();		
		end
	else
		proxy:LuaCallStart( 1130 , OBJ_ATTACK1 );		
	end
	print("OnEvent_1134 end");	
	]]
end

--ダメージアニメ監視 --EN:--damage animation monitoring
function OnEvent_1134_1(proxy,param)
	print("OnEvent_1134_1 begin");
	proxy:LuaCallStart( 1130 , OBJ_ATTACK1 );
	print("OnEvent_1134_1 end");	
end

--OBJのアニメ終了の同期配信 --EN:-- Synchronous delivery of OBJ animation ending
function OnEvent_1130_0(proxy,param) OBJ_ATTACK1 = Lua_ObjAttack(proxy,1130,0); end
function OnEvent_1130_1(proxy,param) OBJ_ATTACK1 = Lua_ObjAttack(proxy,1130,1); end
function OnEvent_1130_2(proxy,param) OBJ_ATTACK1 = Lua_ObjAttack(proxy,1130,2); end
--破壊イベント配信 --EN:--Distribution of destruction events
function OnEvent_1130_3(proxy,param) OBJ_ATTACK1 = Lua_ObjBrake(proxy,1130,1133,1450,4,646000000); end
--後始末 --EN:--Cleaning up
function OnEvent_1134_destroy(proxy,param) Lua_after(proxy,1134,1130); end


--------------------------------------------------------------------------------------
--■1135～1139■OBJ段階破壊ダメージ当たった --EN:-- ■ 1135-1139 ■ OBJ stage destruction damage hit
--------------------------------------------------------------------------------------
function OnEvent_1139(proxy,param)
	if proxy:IsCompleteEvent( 1139 ) == false then
		Lua_RegistDamage(proxy,1139,1135,1451,OBJ_ATTACK2,3);
	end
end

--ダメージアニメ監視 --EN:--damage animation monitoring
function OnEvent_1139_1(proxy,param)
	print("OnEvent_1139_1 begin");
	proxy:LuaCallStart( 1135 , OBJ_ATTACK2 );
	print("OnEvent_1139_1 end");	
end

--OBJのアニメ終了の同期配信 --EN:-- Synchronous delivery of OBJ animation ending
function OnEvent_1135_0(proxy,param) OBJ_ATTACK2 = Lua_ObjAttack(proxy,1135,0); end
function OnEvent_1135_1(proxy,param) OBJ_ATTACK2 = Lua_ObjAttack(proxy,1135,1); end
function OnEvent_1135_2(proxy,param) OBJ_ATTACK2 = Lua_ObjAttack(proxy,1135,2); end
--破壊イベント配信 --EN:--Distribution of destruction events
function OnEvent_1135_3(proxy,param) OBJ_ATTACK2 = Lua_ObjBrake(proxy,1135,1138,1451,4,646100000); end	
--後始末 --EN:--Cleaning up
function OnEvent_1139_destroy(proxy,param) Lua_after(proxy,1139,1135); end

--------------------------------------------------------------------------------------
--■1140～1144■OBJ段階破壊ダメージ当たった --EN:-- ■ 1140-1144 ■ OBJ stage destruction damage hit
--------------------------------------------------------------------------------------
function OnEvent_1144(proxy,param)
	if proxy:IsCompleteEvent( 1144 ) == false then
		Lua_RegistDamage(proxy,1144,1140,1452,OBJ_ATTACK3,3);
	end
end

--ダメージアニメ監視 --EN:--damage animation monitoring
function OnEvent_1144_1(proxy,param)
	print("OnEvent_1144_1 begin");
	proxy:LuaCallStart( 1140 , OBJ_ATTACK3 );
	print("OnEvent_1144_1 end");	
end

--OBJのアニメ終了の同期配信 --EN:-- Synchronous delivery of OBJ animation ending
function OnEvent_1140_0(proxy,param) OBJ_ATTACK3 = Lua_ObjAttack(proxy,1140,0); end
function OnEvent_1140_1(proxy,param) OBJ_ATTACK3 = Lua_ObjAttack(proxy,1140,1); end
function OnEvent_1140_2(proxy,param) OBJ_ATTACK3 = Lua_ObjAttack(proxy,1140,2); end
--破壊イベント配信 --EN:--Distribution of destruction events
function OnEvent_1140_3(proxy,param) OBJ_ATTACK3 = Lua_ObjBrake(proxy,1140,1143,1452,4,646100000); end
--後始末 --EN:--Cleaning up
function OnEvent_1144_destroy(proxy,param) Lua_after(proxy,1144,1140); end


--------------------------------------------------------------------------------------
--■1145～1149■OBJ段階破壊ダメージ当たった --EN:-- ■ 1145-1149 ■ OBJ stage destruction damage hit
--------------------------------------------------------------------------------------
function OnEvent_1149(proxy,param)
	if proxy:IsCompleteEvent( 1149 ) == false then
		Lua_RegistDamage(proxy,1149,1145,1453,OBJ_ATTACK4,3);	
	end
end

--ダメージアニメ監視 --EN:--damage animation monitoring
function OnEvent_1149_1(proxy,param)
	print("OnEvent_1149_1 begin");
	proxy:LuaCallStart( 1145 , OBJ_ATTACK4 );
	print("OnEvent_1149_1 end");	
end

--OBJのアニメ終了の同期配信 --EN:-- Synchronous delivery of OBJ animation ending
function OnEvent_1145_0(proxy,param) OBJ_ATTACK4 = Lua_ObjAttack(proxy,1145,0); end
function OnEvent_1145_1(proxy,param) OBJ_ATTACK4 = Lua_ObjAttack(proxy,1145,1); end
function OnEvent_1145_2(proxy,param) OBJ_ATTACK4 = Lua_ObjAttack(proxy,1145,2); end
--破壊イベント配信 --EN:--Distribution of destruction events
function OnEvent_1145_3(proxy,param) OBJ_ATTACK4 = Lua_ObjBrake(proxy,1145,1148,1453,4,646200000); end	
--後始末 --EN:--Cleaning up
function OnEvent_1149_destroy(proxy,param) Lua_after(proxy,1149,1145); end


--------------------------------------------------------------------------------------
--■1150～1154■OBJ段階破壊ダメージ当たった --EN:-- ■ 1150-1154 ■ OBJ stage destruction damage hit
--------------------------------------------------------------------------------------
function OnEvent_1154(proxy,param)
	if proxy:IsCompleteEvent( 1154 ) == false then
		Lua_RegistDamage(proxy,1154,1150,1454,OBJ_ATTACK5,3);
	end
end

--ダメージアニメ監視 --EN:--damage animation monitoring
function OnEvent_1154_1(proxy,param)
	print("OnEvent_1154_1 begin");
	proxy:LuaCallStart( 1150 , OBJ_ATTACK5 );
	print("OnEvent_1154_1 end");	
end

--OBJのアニメ終了の同期配信 --EN:-- Synchronous delivery of OBJ animation ending
function OnEvent_1150_0(proxy,param) OBJ_ATTACK5 = Lua_ObjAttack(proxy,1150,0); end
function OnEvent_1150_1(proxy,param) OBJ_ATTACK5 = Lua_ObjAttack(proxy,1150,1); end
function OnEvent_1150_2(proxy,param) OBJ_ATTACK5 = Lua_ObjAttack(proxy,1150,2); end
--破壊イベント配信 --EN:--Distribution of destruction events
function OnEvent_1150_3(proxy,param) OBJ_ATTACK5 = Lua_ObjBrake(proxy,1150,1153,1454,4,646200000); end
--後始末 --EN:--Cleaning up
function OnEvent_1154_destroy(proxy,param) Lua_after(proxy,1154,1150); end


--------------------------------------------------------------------------------------
--■1155～1159■OBJ段階破壊ダメージ当たった --EN:-- ■ 1155-1159 ■ OBJ stage destruction damage hit
--------------------------------------------------------------------------------------
function OnEvent_1159(proxy,param)
	if proxy:IsCompleteEvent( 1159 ) == false then		
		Lua_RegistDamage(proxy,1159,1155,1455,OBJ_ATTACK6,3);	
	end
end

--ダメージアニメ監視 --EN:--damage animation monitoring
function OnEvent_1159_1(proxy,param)
	print("OnEvent_1159_1 begin");
	proxy:LuaCallStart( 1155 , OBJ_ATTACK6 );
	print("OnEvent_1159_1 end");	
end

--OBJのアニメ終了の同期配信 --EN:-- Synchronous delivery of OBJ animation ending
function OnEvent_1155_0(proxy,param) OBJ_ATTACK6 = Lua_ObjAttack(proxy,1155,0); end
function OnEvent_1155_1(proxy,param) OBJ_ATTACK6 = Lua_ObjAttack(proxy,1155,1); end
function OnEvent_1155_2(proxy,param) OBJ_ATTACK6 = Lua_ObjAttack(proxy,1155,2); end
--破壊イベント配信 --EN:--Distribution of destruction events
function OnEvent_1155_3(proxy,param) OBJ_ATTACK6 = Lua_ObjBrake(proxy,1155,1158,1455,4,646200000); end	
--後始末 --EN:--Cleaning up
function OnEvent_1159_destroy(proxy,param) Lua_after(proxy,1159,1155); end


--------------------------------------------------------------------------------------
--■1160～1164■OBJ段階破壊ダメージ当たった --EN:-- ■ 1160-1164 ■ OBJ stage destruction damage hit
--------------------------------------------------------------------------------------
function OnEvent_1164(proxy,param)
	if proxy:IsCompleteEvent( 1164 ) == false then
		Lua_RegistDamage(proxy,1164,1160,1456,OBJ_ATTACK7,3);
	end
end

--ダメージアニメ監視 --EN:--damage animation monitoring
function OnEvent_1164_1(proxy,param)
	print("OnEvent_1164_1 begin");
	proxy:LuaCallStart( 1160 , OBJ_ATTACK7 );
	print("OnEvent_1164_1 end");	
end

--OBJのアニメ終了の同期配信 --EN:-- Synchronous delivery of OBJ animation ending
function OnEvent_1160_0(proxy,param) OBJ_ATTACK7 = Lua_ObjAttack(proxy,1160,0); end
function OnEvent_1160_1(proxy,param) OBJ_ATTACK7 = Lua_ObjAttack(proxy,1160,1); end
function OnEvent_1160_2(proxy,param) OBJ_ATTACK7 = Lua_ObjAttack(proxy,1160,2); end
--破壊イベント配信 --EN:--Distribution of destruction events
function OnEvent_1160_3(proxy,param) OBJ_ATTACK7 = Lua_ObjBrake(proxy,1160,1163,1456,4,646000000); end
--後始末 --EN:--Cleaning up
function OnEvent_1164_destroy(proxy,param) Lua_after(proxy,1164,1160); end


--------------------------------------------------------------------------------------
--■1165～1169■OBJ段階破壊ダメージ当たった --EN:-- ■ 1165-1169 ■ OBJ stage destruction damage hit
--------------------------------------------------------------------------------------
function OnEvent_1169(proxy,param)
	if proxy:IsCompleteEvent( 1169 ) == false then
		Lua_RegistDamage(proxy,1169,1165,1457,OBJ_ATTACK8,3);	
	end
end

--ダメージアニメ監視 --EN:--damage animation monitoring
function OnEvent_1169_1(proxy,param)
	print("OnEvent_1169_1 begin");
	proxy:LuaCallStart( 1165 , OBJ_ATTACK8 );
	print("OnEvent_1169_1 end");	
end

--OBJのアニメ終了の同期配信 --EN:-- Synchronous delivery of OBJ animation ending
function OnEvent_1165_0(proxy,param) OBJ_ATTACK8 = Lua_ObjAttack(proxy,1165,0); end
function OnEvent_1165_1(proxy,param) OBJ_ATTACK8 = Lua_ObjAttack(proxy,1165,1); end
function OnEvent_1165_2(proxy,param) OBJ_ATTACK8 = Lua_ObjAttack(proxy,1165,2); end
--破壊イベント配信 --EN:--Distribution of destruction events
function OnEvent_1165_3(proxy,param) OBJ_ATTACK8 = Lua_ObjBrake(proxy,1165,1168,1457,4); end	
--後始末 --EN:--Cleaning up
function OnEvent_1169_destroy(proxy,param) Lua_after(proxy,1169,1165); end


--------------------------------------------------------------------------------------
--■1170～1174■OBJ段階破壊ダメージ当たった --EN:-- ■ 1170-1174 ■ OBJ stage destruction damage hit
--------------------------------------------------------------------------------------
function OnEvent_1174(proxy,param)
	if proxy:IsCompleteEvent( 1174 ) == false then
		Lua_RegistDamage(proxy,1174,1170,1458,OBJ_ATTACK9,3);
	end
end

--ダメージアニメ監視 --EN:--damage animation monitoring
function OnEvent_1174_1(proxy,param)
	print("OnEvent_1174_1 begin");
	proxy:LuaCallStart( 1170 , OBJ_ATTACK9 );
	print("OnEvent_1174_1 end");	
end

--OBJのアニメ終了の同期配信 --EN:-- Synchronous delivery of OBJ animation ending
function OnEvent_1170_0(proxy,param) OBJ_ATTACK9 = Lua_ObjAttack(proxy,1170,0); end
function OnEvent_1170_1(proxy,param) OBJ_ATTACK9 = Lua_ObjAttack(proxy,1170,1); end
function OnEvent_1170_2(proxy,param) OBJ_ATTACK9 = Lua_ObjAttack(proxy,1170,2); end
--破壊イベント配信 --EN:--Distribution of destruction events
function OnEvent_1170_3(proxy,param) OBJ_ATTACK9 = Lua_ObjBrake(proxy,1170,1173,1458,4); end
--後始末 --EN:--Cleaning up
function OnEvent_1174_destroy(proxy,param) Lua_after(proxy,1174,1170); end


--------------------------------------------------------------------------------------
--■1175～1179■OBJ段階破壊ダメージ当たった --EN:-- ■ 1175-1179 ■ OBJ stage destruction damage hit
--------------------------------------------------------------------------------------
function OnEvent_1179(proxy,param)
	if proxy:IsCompleteEvent( 1179 ) == false then
		Lua_RegistDamage(proxy,1179,1175,1459,OBJ_ATTACK10,3);	
	end
end

--ダメージアニメ監視 --EN:--damage animation monitoring
function OnEvent_1179_1(proxy,param)
	print("OnEvent_1179_1 begin");
	proxy:LuaCallStart( 1175 , OBJ_ATTACK10 );
	print("OnEvent_1179_1 end");	
end

--OBJのアニメ終了の同期配信 --EN:-- Synchronous delivery of OBJ animation ending
function OnEvent_1175_0(proxy,param) OBJ_ATTACK10= Lua_ObjAttack(proxy,1175,0); end
function OnEvent_1175_1(proxy,param) OBJ_ATTACK10= Lua_ObjAttack(proxy,1175,1); end
function OnEvent_1175_2(proxy,param) OBJ_ATTACK10= Lua_ObjAttack(proxy,1175,2); end
--破壊イベント配信 --EN:--Distribution of destruction events
function OnEvent_1175_3(proxy,param) OBJ_ATTACK10= Lua_ObjBrake(proxy,1175,1178,1459,4); end	
--後始末 --EN:--Cleaning up
function OnEvent_1179_destroy(proxy,param) Lua_after(proxy,1179,1175); end
]]

OBJ_STATE_0 = -1;--デフォルト --EN:--Default
OBJ_STATE_1 = 1;--1段目 --EN:-- 1st row
OBJ_STATE_2 = 2;--2段目 --EN:--Second row
OBJ_STATE_3 = 3;--3段目 --EN:--3rd row
OBJ_BREAK	= 4;--破壊 --EN:--destruction

NOW_OBJSTATE1	= OBJ_STATE_0;	--現在の状態 --EN:--Current state
NOW_OBJSTATE2	= OBJ_STATE_0;	--現在の状態 --EN:--Current state
NOW_OBJSTATE3	= OBJ_STATE_0;	--現在の状態 --EN:--Current state
NOW_OBJSTATE4	= OBJ_STATE_0;	--現在の状態 --EN:--Current state
NOW_OBJSTATE5	= OBJ_STATE_0;	--現在の状態 --EN:--Current state
NOW_OBJSTATE6	= OBJ_STATE_0;	--現在の状態 --EN:--Current state
NOW_OBJSTATE7	= OBJ_STATE_0;	--現在の状態 --EN:--Current state
NOW_OBJSTATE8	= OBJ_STATE_0;	--現在の状態 --EN:--Current state
NOW_OBJSTATE9	= OBJ_STATE_0;	--現在の状態 --EN:--Current state
NOW_OBJSTATE10	= OBJ_STATE_0;	--現在の状態 --EN:--Current state



function Lua_RegistAttackEvent( proxy, eventId , objId )
	SingleReset(proxy,eventId);
	if proxy:IsCompleteEvent(eventId) == false then
		--OBJが攻撃を受けたイベント --EN:--Event when OBJ was attacked
		proxy:OnSimpleDamage( eventId, objId, 10000 , "OnEvent_"..eventId,everytime);
		proxy:OnSimpleDamage( eventId, objId, 825   , "OnEvent_"..eventId,everytime);
		--OBJがアニメをするイベント --EN:--Event where OBJ does animation
		proxy:CustomLuaCall( eventId , "OnEvent_"..eventId.."_1",everytime);
	else
		proxy:ReconstructBreak(objId,1);
	end
end

--OBJがダメージを受けた時の処理 --EN:--Process when OBJ receives damage
function ObjDam(proxy,param,eventId,objId,nowState)
	print("Dam");
	--HPを取得 --EN:--Get HP
	local Hp = proxy:GetObjHp(objId);	

	local State = OBJ_STATE_0;	
	--OBJの残HPで状態を決める --EN:--Determine the state with the remaining HP of OBJ
	if Hp <= 70 then State = OBJ_STATE_0; end
	if Hp <= 60 then State = OBJ_STATE_1; end
	if Hp <= 50 then State = OBJ_STATE_1; end
	if Hp <= 40 then State = OBJ_STATE_2; end
	if Hp <= 30 then State = OBJ_STATE_2; end
	if Hp <= 20 then State = OBJ_STATE_3; end
	if Hp <= 10 then State = OBJ_STATE_3; end
	if Hp <= 0 then State = OBJ_BREAK; end
	
	--今より状態値が増えた --EN:--More status values than now
	if nowState < State then
		print("Hp :",Hp," State :",State);
		--変わったかもしれないので現HPと状態を配信? param2=objId,param3=State; --EN:--Delivery the current HP and state because it may have changed? param2=objId,param3=State;
		proxy:CustomLuaCallStartPlus( eventId , objId , State );
	end
end

--Objのアニメ --EN:--Obj Animation
function ObjAni(proxy,param,nowState,soundId)	
	local eventId = param:GetParam1();
	local objId = param:GetParam2();
	local State = param:GetParam3();
	print("OnEvent_",eventId,"_1 begin");	
	--Obj個別で覚えている状態より値が大きくなった --EN:--The value became larger than the state remembered individually for Obj
	if nowState < State then
		print("Change State :",State);
		--状態が破壊では無い --EN:--state is not broken
		nowState = State;	--状態更新		 --EN:--status update
		if State ~= OBJ_BREAK then			
			print("Anime ",State);
			if proxy:IsDestroyed( objId ) == false then
				proxy:PlayAnimation( objId, State );--OBJ個別のアニメ				 --EN:--OBJ individual animation
			end
		else
			print("Break");
			--proxy:ChangeModel( objId , 1 );--OBJ個別の破壊	 --EN:--OBJ individual destruction
			--SetFirstSpeedPlus( objId , 2, 3.5  ,6 , 1);
			--proxy:SetBrokenPiece( objId );
			proxy:PlayTypeSE( objId, SOUND_TYPE_O, soundId );
			proxy:DeleteEvent(eventId);--イベントの破棄 --EN:--discard event
			proxy:SetEventFlag(eventId,true);
		end
	end	
	print("OnEvent_",eventId,"_1 end");
	return nowState;
end


--OBJ個別のダメージイベント --EN:--OBJ individual damage event
function OnEvent_1130( proxy,param ) ObjDam(proxy,param,param:GetParam1(),param:GetParam2(),NOW_OBJSTATE1); end
--OBJ個別の状態遷移監視？ --EN:-- OBJ individual state transition monitoring?
function OnEvent_1130_1(proxy,param) NOW_OBJSTATE1 = ObjAni(proxy,param,NOW_OBJSTATE1,646000000); end

--OBJ個別のダメージイベント --EN:--OBJ individual damage event
function OnEvent_1135( proxy,param ) ObjDam(proxy,param,param:GetParam1(),param:GetParam2(),NOW_OBJSTATE2); end
--OBJ個別の状態遷移監視？ --EN:-- OBJ individual state transition monitoring?
function OnEvent_1135_1(proxy,param) NOW_OBJSTATE2 = ObjAni(proxy,param,NOW_OBJSTATE2,646100000); end

--OBJ個別のダメージイベント --EN:--OBJ individual damage event
function OnEvent_1140( proxy,param ) ObjDam(proxy,param,param:GetParam1(),param:GetParam2(),NOW_OBJSTATE3); end
--OBJ個別の状態遷移監視？ --EN:-- OBJ individual state transition monitoring?
function OnEvent_1140_1(proxy,param) NOW_OBJSTATE3 = ObjAni(proxy,param,NOW_OBJSTATE3,646100000); end

--OBJ個別のダメージイベント --EN:--OBJ individual damage event
function OnEvent_1145( proxy,param ) ObjDam(proxy,param,param:GetParam1(),param:GetParam2(),NOW_OBJSTATE4); end
--OBJ個別の状態遷移監視？ --EN:-- OBJ individual state transition monitoring?
function OnEvent_1145_1(proxy,param) NOW_OBJSTATE4 = ObjAni(proxy,param,NOW_OBJSTATE4,646200000); end

--OBJ個別のダメージイベント --EN:--OBJ individual damage event
function OnEvent_1150( proxy,param ) ObjDam(proxy,param,param:GetParam1(),param:GetParam2(),NOW_OBJSTATE5); end
--OBJ個別の状態遷移監視？ --EN:-- OBJ individual state transition monitoring?
function OnEvent_1150_1(proxy,param) NOW_OBJSTATE5 = ObjAni(proxy,param,NOW_OBJSTATE5,646200000); end

--OBJ個別のダメージイベント --EN:--OBJ individual damage event
function OnEvent_1155( proxy,param ) ObjDam(proxy,param,param:GetParam1(),param:GetParam2(),NOW_OBJSTATE6); end
--OBJ個別の状態遷移監視？ --EN:-- OBJ individual state transition monitoring?
function OnEvent_1155_1(proxy,param) NOW_OBJSTATE6 = ObjAni(proxy,param,NOW_OBJSTATE6,646200000); end

--OBJ個別のダメージイベント --EN:--OBJ individual damage event
function OnEvent_1160( proxy,param ) ObjDam(proxy,param,param:GetParam1(),param:GetParam2(),NOW_OBJSTATE7); end
--OBJ個別の状態遷移監視？ --EN:-- OBJ individual state transition monitoring?
function OnEvent_1160_1(proxy,param) NOW_OBJSTATE7 = ObjAni(proxy,param,NOW_OBJSTATE7,646000000); end

--OBJ個別のダメージイベント --EN:--OBJ individual damage event
function OnEvent_1165( proxy,param ) ObjDam(proxy,param,param:GetParam1(),param:GetParam2(),NOW_OBJSTATE8); end
--OBJ個別の状態遷移監視？ --EN:-- OBJ individual state transition monitoring?
function OnEvent_1165_1(proxy,param) NOW_OBJSTATE8 = ObjAni(proxy,param,NOW_OBJSTATE8); end

--OBJ個別のダメージイベント --EN:--OBJ individual damage event
function OnEvent_1170( proxy,param ) ObjDam(proxy,param,param:GetParam1(),param:GetParam2(),NOW_OBJSTATE9); end
--OBJ個別の状態遷移監視？ --EN:-- OBJ individual state transition monitoring?
function OnEvent_1170_1(proxy,param) NOW_OBJSTATE9 = ObjAni(proxy,param,NOW_OBJSTATE9); end

--OBJ個別のダメージイベント --EN:--OBJ individual damage event
function OnEvent_1175( proxy,param ) ObjDam(proxy,param,param:GetParam1(),param:GetParam2(),NOW_OBJSTATE10); end
--OBJ個別の状態遷移監視？ --EN:-- OBJ individual state transition monitoring?
function OnEvent_1175_1(proxy,param) NOW_OBJSTATE10 = ObjAni(proxy,param,NOW_OBJSTATE10); end
