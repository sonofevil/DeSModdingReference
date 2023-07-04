
--------------------------------------------------------------------------------------
--スクリプト初期化■10末締め対応用	※古いのは下にコメントアウトしてます,ここは本イベントに切り替わるときに消去 --EN:-- Script initialization ■ For end of 10 correspondence ※ The old one is commented out below, this is deleted when switching to this event
--------------------------------------------------------------------------------------
function Initialize_m03_01_00_99(proxy)
	print("Initialize_m03_01_00_99 begin");

--■0■敵と戦っているNPC■PCがイベントエリア(2900)に入ったら --EN:-- ■ 0 ■ When an NPC ■ PC fighting an enemy enters the event area (2900)
	proxy:OnRegionJustIn(0,10000,2900,"OnEvent_0",once);

--■80■NPCから助けを求められる(ボイスSE)■ --EN:--■80■NPC asks for help (Voice SE)■
	proxy:NotNetMessage_begin();
		proxy:OnRegionJustIn(80,10000,2901,"OnEvent_80",once);
	proxy:NotNetMessage_end();

--■100■NPCから助けを求められる■ --EN:-- ■ 100 ■ Ask for help from NPC ■
	proxy:NotNetMessage_begin();
		proxy:OnPlayerDistanceInTarget(100,10000,900,"OnEvent_100",4,once);
	proxy:NotNetMessage_end();
	
--■110■NPC会話イベント■※ValueBuffer	20080使用 --EN:-- ■ 110 ■ NPC conversation event ■ * Uses ValueBuffer 20080
	proxy:NotNetMessage_begin();
		OnTalk(proxy,110,900,TalkDist_N,TalkAngle_N,20080,HELPID_TALK_WAR,"OnEvent_110","OnEvent_110_1","OnEvent_110_2",everytime);
--■111■NPC会話再登録用■ --EN:--■111■For NPC conversation re-registration■
		proxy:LuaCall(111,1,"OnEvent_111_1",everytime);
		proxy:LuaCall(10001,1,"OnEvent_10001_1",everytime);
		
	proxy:NotNetMessage_end();

--■120■PCがNPCを殺した■ --EN:-- ■ 120 ■ PC killed NPC ■
	proxy:NotNetMessage_begin();
		proxy:OnSimpleDamage(120,900,10000,"OnEvent_120",everytime);
	proxy:NotNetMessage_end();

--■120_1■フラグ設定変更■ --EN:-- ■ 120_1 ■ Flag setting change ■
	proxy:LuaCall(120,1,"OnEvent_120_1",everytime);

--■121■NPCに対するリミットカウント始動■PCがイベントエリア(2901)に入ったら --EN:-- ■ 121 ■ Start limit count for NPC ■ When PC enters event area (2901)
	--proxy:OnRegionJustIn(121,10000,2901,"OnEvent_121",once);
	--■121_1■NPC死亡用■ --EN:--■121_1■For NPC death■
	proxy:NotNetMessage_begin();
		proxy:OnCharacterDead(121,900,"OnEvent_121_2",once);
	proxy:NotNetMessage_end();

--■160■ステージクリア:システムメッセージ■ --EN:-- ■ 160 ■ Stage Clear: System Message ■
	proxy:LuaCall(160,1,"ClientStageClear",once);	

--■14290■NPCからアイテムを貰う■ --EN:-- ■ 14290 ■ Receive items from NPC ■


proxy:NotNetMessage_begin();
--■12790■宝死体A調べる■ --EN:--■ 12790 ■ Examining Treasure Corpse A ■
	proxy:OnDistanceAction(12790,10000,1900,"OnEvent_12790",ItemBoxDist_A,HELPID_CHECK_GLOWING_CORPS,0,ItemBoxAngle_A,once);
	
--■12791■宝死体B調べる■ --EN:--■ 12791 ■ Investigate Treasure Corpse B ■
	proxy:OnDistanceAction(12791,10000,1901,"OnEvent_12791",ItemBoxDist_A,HELPID_CHECK_GLOWING_CORPS,0,ItemBoxAngle_A,once);
proxy:NotNetMessage_end();
	
	
--~ --■3492■終了NPCとの会話■※ValueBuffer 20081使用 --EN:--■3492■Conversation with end NPC■※ValueBuffer 20081 used
--~ 	proxy:NotNetMessage_begin();--非配信 --EN:--non-delivery
--~ 		OnTalk(proxy,3492,901,TalkDist_N,TalkAngle_N,20081,10000001,"OnEvent_3492","OnEvent_3492_1","OnEvent_3492_2",everytime);
--~ 	proxy:NotNetMessage_end();

	proxy:NotNetMessage_begin();
--■5113■騎士死亡監視 --EN:-- ■ 5113 ■ Knight Death Watch
		proxy:OnCharacterDead(5113,920,"OnEvent_5113",everytime);

--■150■僧侶と会話初めて:騎士生きてる:宝無し■※ValueBuffer 20090使用	 --EN:--■150■Conversation with a priest for the first time: A knight is alive: No treasure■※Uses ValueBuffer 20090
		OnTalk(proxy,150,901,TalkDist_N,TalkAngle_N,20090,HELPID_TALK_CLE,"OnEvent_150","OnEvent_150_1","OnEvent_150_2",everytime);
		
--■180■騎士咆哮！ --EN:--■180■Knight's Roar!
		proxy:OnRegionJustIn(180,10000,2902,"OnEvent_180",once);
	proxy:NotNetMessage_end();

--■999999■初期化タイミング■0秒後 --EN:-- ■ 999999 ■ Initialization timing ■ 0 seconds later
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 999900, "Second_Initialize_m03_01_00_99", 0.3, 0, 0, once );
	proxy:NotNetMessage_end();
	
	--■190～201■キャラクタ更新監視■ --EN:-- ■ 190-201 ■ Character update monitoring ■
	proxy:NotNetMessage_begin();
		--■190-191■キャラクタ更新監視■ --EN:-- ■ 190-191 ■ Character update monitoring ■
		OnUpDate(proxy,190,191,2910,"OnEvent_3500","OnEvent_3501");
		--■192-193■キャラクタ更新監視■ --EN:-- ■ 192-193 ■ Character update monitoring ■
		OnUpDate(proxy,192,193,2911,"OnEvent_3502","OnEvent_3503");
		--■194-195■キャラクタ更新監視■ --EN:-- ■ 194-195 ■ Character update monitoring ■
		OnUpDate(proxy,194,195,2912,"OnEvent_3504","OnEvent_3505");
		--■196-197■キャラクタ更新監視■ --EN:-- ■ 196-197 ■ Character update monitoring ■
		OnUpDate(proxy,196,197,2913,"OnEvent_3506","OnEvent_3507");
		--■198-199■キャラクタ更新監視■ --EN:-- ■ 198-199 ■ Character update monitoring ■
		OnUpDate(proxy,198,199,2914,"OnEvent_3508","OnEvent_3509");
		--■200-201■キャラクタ更新監視■ --EN:-- ■ 200-201 ■ Character update monitoring ■
		OnUpDate(proxy,200,201,2915,"OnEvent_3510","OnEvent_3511");
	proxy:NotNetMessage_end();

	proxy:NotNetMessage_begin();
	--■10■NPCが腐敗人を監視■ --EN:--■ 10 ■ NPC monitors corrupt people ■
		proxy:OnPlayerDistanceInTarget(10,902,900,"OnEvent_10_1",5.0,everytime);
		proxy:OnPlayerDistanceOut(10,902,900,"OnEvent_10_2",5.0,everytime);
	
	--■11■NPCが腐敗人を監視■ --EN:--■ 11 ■ NPC monitors corrupt people ■
		proxy:OnPlayerDistanceInTarget(11,903,900,"OnEvent_11_1",5.0,everytime);
		proxy:OnPlayerDistanceOut(11,903,900,"OnEvent_11_2",5.0,everytime);
		
	--■12■NPCが腐敗人を監視■ --EN:--■ 12 ■ NPC monitors corrupt people ■
		proxy:OnPlayerDistanceInTarget(12,904,900,"OnEvent_12_1",5.0,everytime);
		proxy:OnPlayerDistanceOut(12,904,900,"OnEvent_12_2",5.0,everytime);
	
	--■13■NPCが腐敗人を監視■ --EN:--■ 13 ■ NPC monitors corrupt people ■
		proxy:OnPlayerDistanceInTarget(13,905,900,"OnEvent_13_1",5.0,everytime);
		proxy:OnPlayerDistanceOut(13,905,900,"OnEvent_13_2",5.0,everytime);

	--■14■NPCが腐敗人を監視■ --EN:--■ 14 ■ NPC monitors corrupt people ■
		proxy:OnPlayerDistanceInTarget(14,906,900,"OnEvent_14_1",5.0,everytime);
		proxy:OnPlayerDistanceOut(14,906,900,"OnEvent_14_2",5.0,everytime);
		
	--■15■NPCが腐敗人を監視■ --EN:--■ 15 ■ NPC monitors corrupt people ■
		proxy:OnPlayerDistanceInTarget(15,911,900,"OnEvent_15_1",5.0,everytime);
		proxy:OnPlayerDistanceOut(15,911,900,"OnEvent_15_2",5.0,everytime);
		
--■10■NPCが腐敗人を監視■ --EN:--■ 10 ■ NPC monitors corrupt people ■
--■10■NPCが腐敗人を監視■ --EN:--■ 10 ■ NPC monitors corrupt people ■
--■10■NPCが腐敗人を監視■ --EN:--■ 10 ■ NPC monitors corrupt people ■
--■10■NPCが腐敗人を監視■ --EN:--■ 10 ■ NPC monitors corrupt people ■
--■10■NPCが腐敗人を監視■ --EN:--■ 10 ■ NPC monitors corrupt people ■
--■10■NPCが腐敗人を監視■ --EN:--■ 10 ■ NPC monitors corrupt people ■
--■10■NPCが腐敗人を監視■ --EN:--■ 10 ■ NPC monitors corrupt people ■
--■10■NPCが腐敗人を監視■ --EN:--■ 10 ■ NPC monitors corrupt people ■
--■10■NPCが腐敗人を監視■ --EN:--■ 10 ■ NPC monitors corrupt people ■
--■10■NPCが腐敗人を監視■ --EN:--■ 10 ■ NPC monitors corrupt people ■
--■10■NPCが腐敗人を監視■ --EN:--■ 10 ■ NPC monitors corrupt people ■
--■10■NPCが腐敗人を監視■ --EN:--■ 10 ■ NPC monitors corrupt people ■
	
--■10■腐敗人が死んだ■ --EN:-- ■ 10 ■ Corruption died ■
		proxy:OnCharacterDead(10,902,"OnEvent_10", everytime);

--■11■腐敗人が死んだ■	 --EN:-- ■ 11 ■ Corruption died ■
		proxy:OnCharacterDead(11,903,"OnEvent_11", everytime);
		
--■12■腐敗人が死んだ■ --EN:-- ■ 12 ■ Corruption died ■
		proxy:OnCharacterDead(12,904,"OnEvent_12", everytime);
		
--■13■腐敗人が死んだ■	 --EN:-- ■ 13 ■ Corruption died ■
		proxy:OnCharacterDead(13,905,"OnEvent_13", everytime);
		
--■14■腐敗人が死んだ■	 --EN:-- ■ 14 ■ Corruption died ■
		proxy:OnCharacterDead(14,906,"OnEvent_14", everytime);
		
--■15■腐敗人が死んだ■	 --EN:-- ■ 15 ■ Corruption died ■
		proxy:OnCharacterDead(15,911,"OnEvent_15", everytime);
		
--■15906■腐敗人が死んだ■ --EN:--■ 15906 ■ Corruption died ■
		--proxy:OnCharacterDead(15906,909,"OnEvent_15906", everytime);
	
--■15907■腐敗人が死んだ■ --EN:--■ 15907 ■ Corruption died ■
		--proxy:OnCharacterDead(15907,910,"OnEvent_15907", everytime);
		
--■15908■腐敗人が死んだ■	 --EN:--■15908■Corruption died■
		--proxy:OnCharacterDead(15908,913,"OnEvent_15908", everytime);

--■15909■腐敗人が死んだ■	 --EN:--■ 15909 ■ Corruption died ■
		--proxy:OnCharacterDead(15909,914,"OnEvent_15909", everytime);

--■15910■腐敗人が死んだ■	 --EN:--■15910■Corruption died■
		--proxy:OnCharacterDead(15910,915,"OnEvent_15910", everytime);
		
--■15911■腐敗人が死んだ■ --EN:--■ 15911 ■ Corruption died ■
		--proxy:OnCharacterDead(15911,916,"OnEvent_15911", everytime);
		
--■15912■腐敗人が死んだ■ --EN:--■ 15912 ■ Corruption died ■
		--proxy:OnCharacterDead(15912,917,"OnEvent_15912", everytime);
		
--■15929■腐敗人が死んだ■ --EN:--■ 15929 ■ Corruption died ■
		--proxy:OnCharacterDead(15929,911,"OnEvent_15929", everytime);
		
--■15930■腐敗人が死んだ■ --EN:--■15930■Corruption died■
		--proxy:OnCharacterDead(15930,912,"OnEvent_15930", everytime);
	proxy:NotNetMessage_end();

	
	proxy:NotNetMessage_begin();
		proxy:OnRegistFunc( 12345 , "Check" , "OnEvent_12345" , 1 , everytime );
	proxy:NotNetMessage_end();
	
	
--■??■徘徊デーモンの登場■ハンドラ登録 --EN:--■??■Appearance of wandering daemon■Handler registration
	proxy:NotNetMessage_begin();
		--プレイヤーがソロで死亡した時にキックされます。 --EN:--Kicked when a player dies solo.
		proxy:LuaCall( 4000, 100, "PlayerDeath_m03_01_00_99", everytime );
		--プレイヤーが復活した時にキックされます。 --EN:--Kicked when the player is revived.
		proxy:LuaCall( 4032, 100, "PlayerRevive_m03_01_00_99", everytime );
	proxy:NotNetMessage_end();
	
	
	print("Initialize_m03_01_00_99 end");
end


--------------------------------------------------------------------------------------
--マルチになった時にホストじゃ無かったら■無し --EN:--If you are not a host when you become multi, no
--------------------------------------------------------------------------------------
function ConnectPartyEvent(proxy)
	print("ConnectPartyEvent begin");
	
	--いらないイベントをチェックします --EN:--Check unwanted events
	--proxy:DeleteEvent(120);
	proxy:DeleteEvent(3412);
	proxy:DeleteEvent(121);	
	proxy:DeleteEvent(110);--会話イベントを一旦削除 --EN:-- Delete the conversation event once
	
	proxy:DeleteEvent(10);
	proxy:DeleteEvent(11);
	proxy:DeleteEvent(12);
	proxy:DeleteEvent(13);
	proxy:DeleteEvent(14);
	proxy:DeleteEvent(15);	
--[[	
	--キャラを一度復活させます --EN:-- Revive the character once
	proxy:SetAlive(900,1.0);
	proxy:SetAlive(901,1.0);
	proxy:SetAlive(902,1.0);
	proxy:SetAlive(903,1.0);
	proxy:SetAlive(904,1.0);
	proxy:SetAlive(905,1.0);
	proxy:SetAlive(906,1.0);
	proxy:SetAlive(907,1.0);
	proxy:SetAlive(908,1.0);
	proxy:SetAlive(909,1.0);
	proxy:SetAlive(910,1.0);
	proxy:SetAlive(911,1.0);
	proxy:SetAlive(912,1.0);
	proxy:SetAlive(913,1.0);
	proxy:SetAlive(914,1.0);
	proxy:SetAlive(915,1.0);
	proxy:SetAlive(916,1.0);
	proxy:SetAlive(917,1.0);
	proxy:SetAlive(918,1.0);
	proxy:SetAlive(919,1.0);
	proxy:SetAlive(920,1.0);
	proxy:SetAlive(930,1.0);
]]	
	--1フレーム後に再度登録しなおす --EN:--Register again after 1 frame
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2(111,"OnEvent_111",0.5,0,0,once);
		proxy:OnKeyTime2(10001,"OnEvent_10001",0.0,0,0,once);
	proxy:NotNetMessage_end();
	print("ConnectPartyEvent end");
end


--------------------------------------------------------------------------------------
--マップの初期化■999999 --EN:--Initialization of map ■999999
--------------------------------------------------------------------------------------
function Second_Initialize_m03_01_00_99(proxy, param )
	print("Second_Initialize_m03_01_00_99 begin");
	--この判定はゴースト召還用 --EN:--This judgment is for ghost summoning
	if proxy:IsCompleteEvent( 0 ) ==false then
		--NPCのロジックを切る --EN:--Turn off NPC logic
		proxy:EnableLogic( 900, false );
		--腐敗人のロジックを切る --EN:--Cut the logic of corrupt people
		proxy:EnableLogic( 902, false );
		--腐敗人のロジックを切る --EN:--Cut the logic of corrupt people
		proxy:EnableLogic( 903, false );
		--腐敗人のロジックを切る --EN:--Cut the logic of corrupt people
		proxy:EnableLogic( 904, false );
	end
	
	--終了NPCの停止,終了NPCの無敵化 --EN:--End NPC stop, end NPC invincibility
	proxy:EnableLogic(901,false);
	--proxy:SetDeadMode(900,true);
	proxy:SetDeadMode(901,true);
	
	
	--王の盾の停止 --EN:--King's Shield Suspension
	proxy:EnableLogic(930,false);
	--キャラクタ更新をしないに設定 --EN:-- Set to not update character
	for ChrID= 900,930,1 do
		SetDisable(proxy,ChrID,true);
	end
	--宝死体を光らせる --EN:-- make the treasure corpse glow
	if proxy:IsCompleteEvent(12790) ==false then
		proxy:TreasureDispModeChange(1900, true );
	end
	if proxy:IsCompleteEvent(12791) ==false then
		proxy:TreasureDispModeChange(1901, true );
	end
	
	
--[[
	--■徘徊デーモン用 (フラグは仮、指定があれば変える) --EN:--■For wandering daemon (flag is tentative, change if specified)
	if proxy:IsCompleteEvent( 20 ) == true then
		LuaFunc_VisibleTheWanderingDemon  (proxy, param, demon_id_list_m03_01_00_99);
	else
		LuaFunc_InvisibleTheWanderingDemon(proxy, param, demon_id_list_m03_01_00_99);
	end
]]
	
	
	print("Second_Initialize_m03_01_00_99 end");
end


--------------------------------------------------------------------------------------
--敵とNPCが戦いだす■0 --EN:--Enemies and NPCs start fighting 0
--------------------------------------------------------------------------------------
function OnEvent_0(proxy,param)
	print("OnEvent_0 begin");
	proxy:SetEventFlag(0,1);
	--NPCロジックON --EN:--NPC logic ON
	proxy:EnableLogic(900,true);	
	--腐敗人ロジックON --EN:--Corrupt logic ON
	proxy:EnableLogic(902,true);
	--腐敗人ロジックON --EN:--Corrupt logic ON
	proxy:EnableLogic(903,true);
	--腐敗人ロジックON --EN:--Corrupt logic ON
	proxy:EnableLogic(904,true);	
	print("OnEvent_0 end");	
end


--------------------------------------------------------------------------------------
--NPCから助けを求められる(ボイスSE)■80 --EN:-- NPC asks for help (Voice SE) 80
--------------------------------------------------------------------------------------
function OnEvent_80(proxy,param)
	print("OnEvent_80 begin");
	--ボイスSE再生 --EN:--Voice SE playback
	proxy:PlayTypeSE(900,7,705000003);
	print("OnEvent_80 end");	
end


--------------------------------------------------------------------------------------
--NPCから助けを求められる■100	 --EN:-- NPC asks for help ■ 100
--------------------------------------------------------------------------------------
function OnEvent_100(proxy,param)
	if proxy:IsCompleteEvent(100) == true then
		return;
	end
	
	print("OnEvent_100 begin");
	proxy:SetEventFlag(100,true);
	print("OnEvent_100 ebd");
end

--------------------------------------------------------------------------------------
--NPCとの会話■110	※ValueBuffer	20080使用 --EN:--Conversation with NPC ■ 110 *ValueBuffer 20080 used
--------------------------------------------------------------------------------------
--■アクションボタン判定■ --EN:-- ■ Action button judgment ■
function OnEvent_110(proxy,param)
	if proxy:IsCompleteEvent(110) == false then
		return;
	end
	print("OnEvent_110 begin");
	
	local FlagValue =  proxy:IsCompleteEventValue(20080);	
	if proxy:IsCompleteEvent(3407) == false then
		if FlagValue == 0 then
			proxy:SetEventFlag(20080,1);
			proxy:TurnCharactor( 900, 10000 );
		end
		if FlagValue == 1 then proxy:SetEventFlag(20080,2); end		
		if FlagValue == 2 then
			proxy:AddInventoryItem(1,TYPE_GOODS,10);
			proxy:GetItem(1,TYPE_GOODS);
			proxy:SetEventFlag(3407,true);
			proxy:SetEventFlag(20080,0);
		end
	else
		--ループ会話 --EN:--loop conversation
		if FlagValue == 0 then
			proxy:SetEventFlag(20080,1);
			proxy:TurnCharactor( 900, 10000 );
		end
		if FlagValue == 1 then proxy:SetEventFlag(20080,2); end
		if FlagValue == 2 then proxy:SetEventFlag(20080,0); end
	end
	
	print("OnEvent_110 end");
end

--■可聴領域判定■ --EN:-- ■ Hearable area judgment ■
function OnEvent_110_1(proxy,param)
	
	if proxy:IsCompleteEvent(110) == false then
		return;
	end
	
	local FlagValue =  proxy:IsCompleteEventValue(20080);	
	if proxy:IsCompleteEvent(3407) == false then
		Luafunc_Talk(proxy,FlagValue,1,900,90000060,true);
		Luafunc_Talk(proxy,FlagValue,2,900,90000061,false);
	else
		Luafunc_Talk(proxy,FlagValue,1,900,90000062,true);
		Luafunc_Talk(proxy,FlagValue,2,900,90000063,false);
	end	
end

--■範囲外判定■ --EN:-- ■ Out of range judgment ■
function OnEvent_110_2(proxy,param)
	if proxy:IsCompleteEvent(110) == false then
		return;
	end	
	print("OnEvent_110_2 begin");
	local FlagValue = proxy:IsCompleteEventValue(20080);
	if FlagValue >= 1 then
		proxy:SetEventFlag(20080,0);
	end
	print("OnEvent_110_2 end");
end


--------------------------------------------------------------------------------------
--NPC会話の再登録■111 --EN:--Re-register NPC conversation ■111
--------------------------------------------------------------------------------------
--1フレーム遅らせる為の処理 --EN:-- Processing to delay 1 frame
function OnEvent_111(proxy,param)
	if param:IsNetMessage() == true then
		return;
	end
	proxy:LuaCallStart(111,1);
end

--予め登録された会話追加関数 --EN:-- Pre-registered conversation addition function
function OnEvent_111_1(proxy,param)
	print("AddEvent begin");
	proxy:NotNetMessage_begin();
	
		--■110■NPC会話イベント■※ValueBuffer	20080使用 --EN:-- ■ 110 ■ NPC conversation event ■ * Uses ValueBuffer 20080
		OnTalk(proxy,110,900,TalkDist_N,TalkAngle_N,20080,HELPID_TALK_WAR,"OnEvent_110","OnEvent_110_1","OnEvent_110_2",everytime);	
		--■120■PCがNPCを殺した■	 --EN:-- ■ 120 ■ PC killed NPC ■
		--proxy:OnSimpleDamage(120,900,10000,"OnEvent_120",everytime);
		--■121_1■NPC死亡用■	 --EN:--■121_1■For NPC death■
		proxy:OnCharacterDead(121,900,"OnEvent_121_2",once);
		
		
	--■10■NPCが腐敗人を監視■ --EN:--■ 10 ■ NPC monitors corrupt people ■
		proxy:OnPlayerDistanceInTarget(10,902,900,"OnEvent_10_1",5.0,everytime);
		proxy:OnPlayerDistanceOut(10,902,900,"OnEvent_10_2",5.0,everytime);
	
	--■11■NPCが腐敗人を監視■ --EN:--■ 11 ■ NPC monitors corrupt people ■
		proxy:OnPlayerDistanceInTarget(11,903,900,"OnEvent_11_1",5.0,everytime);
		proxy:OnPlayerDistanceOut(11,903,900,"OnEvent_11_2",5.0,everytime);
		
	--■12■NPCが腐敗人を監視■ --EN:--■ 12 ■ NPC monitors corrupt people ■
		proxy:OnPlayerDistanceInTarget(12,904,900,"OnEvent_12_1",5.0,everytime);
		proxy:OnPlayerDistanceOut(12,904,900,"OnEvent_12_2",5.0,everytime);
	
	--■13■NPCが腐敗人を監視■ --EN:--■ 13 ■ NPC monitors corrupt people ■
		proxy:OnPlayerDistanceInTarget(13,905,900,"OnEvent_13_1",5.0,everytime);
		proxy:OnPlayerDistanceOut(13,905,900,"OnEvent_13_2",5.0,everytime);

	--■14■NPCが腐敗人を監視■ --EN:--■ 14 ■ NPC monitors corrupt people ■
		proxy:OnPlayerDistanceInTarget(14,906,900,"OnEvent_14_1",5.0,everytime);
		proxy:OnPlayerDistanceOut(14,906,900,"OnEvent_14_2",5.0,everytime);
		
	--■15■NPCが腐敗人を監視■ --EN:--■ 15 ■ NPC monitors corrupt people ■
		proxy:OnPlayerDistanceInTarget(15,911,900,"OnEvent_15_1",5.0,everytime);
		proxy:OnPlayerDistanceOut(15,911,900,"OnEvent_15_2",5.0,everytime);
		
--■10■NPCが腐敗人を監視■ --EN:--■ 10 ■ NPC monitors corrupt people ■
--■10■NPCが腐敗人を監視■ --EN:--■ 10 ■ NPC monitors corrupt people ■
--■10■NPCが腐敗人を監視■ --EN:--■ 10 ■ NPC monitors corrupt people ■
--■10■NPCが腐敗人を監視■ --EN:--■ 10 ■ NPC monitors corrupt people ■
--■10■NPCが腐敗人を監視■ --EN:--■ 10 ■ NPC monitors corrupt people ■
--■10■NPCが腐敗人を監視■ --EN:--■ 10 ■ NPC monitors corrupt people ■
--■10■NPCが腐敗人を監視■ --EN:--■ 10 ■ NPC monitors corrupt people ■
--■10■NPCが腐敗人を監視■ --EN:--■ 10 ■ NPC monitors corrupt people ■
--■10■NPCが腐敗人を監視■ --EN:--■ 10 ■ NPC monitors corrupt people ■
--■10■NPCが腐敗人を監視■ --EN:--■ 10 ■ NPC monitors corrupt people ■
--■10■NPCが腐敗人を監視■ --EN:--■ 10 ■ NPC monitors corrupt people ■
--■10■NPCが腐敗人を監視■ --EN:--■ 10 ■ NPC monitors corrupt people ■
	
	--■10■腐敗人が死んだ■ --EN:-- ■ 10 ■ Corruption died ■
		proxy:OnCharacterDead(10,902,"OnEvent_10", everytime);

	--■11■腐敗人が死んだ■	 --EN:-- ■ 11 ■ Corruption died ■
		proxy:OnCharacterDead(11,903,"OnEvent_11", everytime);
		
	--■12■腐敗人が死んだ■ --EN:-- ■ 12 ■ Corruption died ■
		proxy:OnCharacterDead(12,904,"OnEvent_12", everytime);
		
	--■13■腐敗人が死んだ■	 --EN:-- ■ 13 ■ Corruption died ■
		proxy:OnCharacterDead(13,905,"OnEvent_13", everytime);
		
	--■14■腐敗人が死んだ■	 --EN:-- ■ 14 ■ Corruption died ■
		proxy:OnCharacterDead(14,906,"OnEvent_14", everytime);
		
	--■15■腐敗人が死んだ■	 --EN:-- ■ 15 ■ Corruption died ■
		proxy:OnCharacterDead(15,911,"OnEvent_15", everytime);
		
	--■15906■腐敗人が死んだ■ --EN:--■ 15906 ■ Corruption died ■
		--proxy:OnCharacterDead(15906,909,"OnEvent_15906", everytime);
	
	--■15907■腐敗人が死んだ■ --EN:--■ 15907 ■ Corruption died ■
		--proxy:OnCharacterDead(15907,910,"OnEvent_15907", everytime);
		
	--■15908■腐敗人が死んだ■	 --EN:--■15908■Corruption died■
		--proxy:OnCharacterDead(15908,913,"OnEvent_15908", everytime);

	--■15909■腐敗人が死んだ■	 --EN:--■ 15909 ■ Corruption died ■
		--proxy:OnCharacterDead(15909,914,"OnEvent_15909", everytime);

	--■15910■腐敗人が死んだ■	 --EN:--■15910■Corruption died■
		--proxy:OnCharacterDead(15910,915,"OnEvent_15910", everytime);
		
	--■15911■腐敗人が死んだ■ --EN:--■ 15911 ■ Corruption died ■
		--proxy:OnCharacterDead(15911,916,"OnEvent_15911", everytime);
		
	--■15912■腐敗人が死んだ■ --EN:--■ 15912 ■ Corruption died ■
		--proxy:OnCharacterDead(15912,917,"OnEvent_15912", everytime);
		
	--■15929■腐敗人が死んだ■ --EN:--■ 15929 ■ Corruption died ■
		--proxy:OnCharacterDead(15929,911,"OnEvent_15929", everytime);
		
	--■15930■腐敗人が死んだ■ --EN:--■15930■Corruption died■
		--proxy:OnCharacterDead(15930,912,"OnEvent_15930", everytime);
	
	proxy:NotNetMessage_end();
	print("AddEvent end");	
end

--1フレーム遅らせる為の処理 --EN:-- Processing to delay 1 frame
function OnEvent_10001(proxy,param)
	if param:IsNetMessage() == true then
		return;
	end	
	proxy:LuaCallStart(10001,1);
end

--予め登録された初期化 --EN:--pre-registered initialization
function OnEvent_10001_1(proxy,param)
	print("flag off begin");
	proxy:SetEventFlag(10,false);
	proxy:SetEventFlag(11,false);
	proxy:SetEventFlag(12,false);
	proxy:SetEventFlag(13,false);
	proxy:SetEventFlag(14,false);
	proxy:SetEventFlag(15,false);
	
	proxy:SetEventFlag(10000,false);
	
	proxy:SetEventFlag(5113,false);
	proxy:SetEventFlag(110,false);	
	proxy:SetEventFlag(3407,false);	
	proxy:SetEventFlag(20080,99);
	print("flag off end");
end

--------------------------------------------------------------------------------------
--NPCがPCに殺されてしまった■120 --EN:--NPC was killed by PC ■120
--------------------------------------------------------------------------------------
function OnEvent_120(proxy,param)	
	if proxy:IsCompleteEvent(120) == true then
		return;
	end
	print("OnEvent_120 begin");	
	proxy:LuaCallStart(120,1);
	print("OnEvent_120 end");
end


--PT配信用のフラグイベント --EN:--flag event for PT delivery
function OnEvent_120_1(proxy,param)
	print("OnEvent_120_1 begin");
	--NPCが死んだ --EN:--NPC died
	if proxy:IsAlive(900) == false then
		--フラグON --EN:--Flag ON
		proxy:SetEventFlag(120,true);
	end
	print("OnEvent_120_1 end");
end


--------------------------------------------------------------------------------------
--NPCが殺されてしまった■3412 --EN:--NPC has been killed ■3412
--------------------------------------------------------------------------------------
function OnEvent_3412(proxy,param)
	print("OnEvent_3412 begin");
	if proxy:IsCompleteEvent(3412) == true then
		return;
	end
	
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2(3412,"OnEvent_3412_1",2,0,0,once);
	proxy:NotNetMessage_end();
	proxy:SetEventFlag(3412,true);
	print("OnEvent_3412 end");
end

function OnEvent_3412_1(proxy,param)
	print("OnEvent_3412_1 begin");
	proxy:SetEventFlag(3412,0);	
	print("OnEvent_3412_1 end");	
end


--------------------------------------------------------------------------------------
--NPCのリミッターを始動する■121 --EN:--Start NPC's limiter ■121
--------------------------------------------------------------------------------------
function OnEvent_121(proxy,param)
--~ 	print("OnEvent_121 begin");
--~ 	if param:IsNetMessage() == true then
--~ 		return;
--~ 	end	
--~ 	proxy:NotNetMessage_begin();
--~ 		proxy:OnKeyTime2(121,"OnEvent_121_1",NPCTIMER,0,0,once);
--~ 	proxy:NotNetMessage_end();
--~ 	print("OnEvent_121 end");
end

--■121_1■カウンタ終了後の処理■ --EN:-- ■ 121_1 ■ Processing after the end of the counter ■
function OnEvent_121_1(proxy,param)
--~ 	print("OnEvent_121_1 begin");
--~ 	--予め登録しておいた死亡処理を呼ぶ --EN:--Call pre-registered death processing
--~ 	proxy:LuaCallStart(121,1);
--~ 	print("OnEvent_121_1 end");
end

--■121_2■NPC死亡アニメ再生■ --EN:--■121_2■NPC Death Animation Replay■
function OnEvent_121_2(proxy,param)
	if proxy:IsCompleteEvent(121) == true then
		return;
	end

	print("OnEvent_121_2 begin");
	proxy:SetEventFlag(121,true);
	
	proxy:NotNetMessage_begin();				
			proxy:OnDistanceAction(3412,10000,900,"OnEvent_3412",ItemBoxDist_A,10000007,0,ItemBoxAngle_A,everytime);	
		proxy:DeleteEvent(110);--会話イベント				 --EN:--Conversation Event
		proxy:DeleteEvent(100);--NPCから助けを求められる --EN:--NPC asks for help
	proxy:NotNetMessage_end();
	print("OnEvent_121_2 end");
end


--------------------------------------------------------------------------------------
--ホストOrシングルステージクリアイベント■160 --EN:-- Host or single stage clear event ■ 160
--------------------------------------------------------------------------------------
--■160■クリア条件達成■ --EN:-- ■ 160 ■ Clear conditions achieved ■
function HostStageClear(proxy,param)
	print("HostStageClear begin");
	proxy:LuaCallStart(160,1);
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2(160,"StageClear",5.0,0,1,once);
	proxy:NotNetMessage_end();
	print("HostStageClear end");
end

--■160_1■システムメッセージ■ --EN:-- ■ 160_1 ■ System message ■
function HostStageClear_1(proxy,param)
	print("HostStageClear_1 begin");
	print("HostStageClear_1 end");
end

--■160_2■システムメッセージ■ --EN:-- ■ 160_2 ■ System message ■
function HostStageClear_2(proxy,param)
	print("HostStageClear_2 begin");
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2(160,"StageClear",3.0,0,3,once);
	proxy:NotNetMessage_end();
	print("HostStageClear_2 end");
end

--■160_1■タイトルに戻る■ --EN:-- ■ 160_1 ■ Return to title ■
function StageClear(proxy,param)
	print("StageClear begin");
	proxy:ReturnMapSelect();
	print("StageClear end");
end


--------------------------------------------------------------------------------------
--クライアントステージクリアイベント■160 --EN:--Client Stage Clear Event ■160
--------------------------------------------------------------------------------------
--■160■クリア配信■ --EN:-- ■ 160 ■ clear delivery ■
function ClientStageClear(proxy,param)
	if proxy:IsInParty() == false then
		return;
	end
	if proxy:IsHost() == true then
		return;
	end
	
	print("ClientStageClear begin");
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2(160,"ClientStageClear_1",2.0,0,4,once);
	proxy:NotNetMessage_end();
	print("ClientStageClear end");	
end

function ClientStageClear_1(proxy,param)
	print("ClientStageClear_1 begin");
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2(160,"StageClear",3.0,0,5,once);
	proxy:NotNetMessage_end();
	print("ClientStageClear_1 end");
end

--------------------------------------------------------------------------------------
--宝死体Aを調べる■12790 --EN:-- Examine Treasure Corpse A ■ 12790
--------------------------------------------------------------------------------------
--■12790■範囲内でACTボタンを押した■ --EN:--■ 12790■ pressed the ACT button ■
function OnEvent_12790(proxy,param)
	print("OnEvent_12790 begin");

	--同期アニメーション用のイベント --EN:--event for synchronous animation
	proxy:LuaCallStart( 4010 , 1 );
	
	proxy:NotNetMessage_begin();
		--▼12790▼***条件追加***宝死体Aアイテム取得▼ --EN:--▼12790▼***Condition added***Treasure corpse A item acquisition▼
		proxy:OnKeyTime2( 12790, "OnEvent_12790_1", 0.0, 0, 0, once );		
	proxy:NotNetMessage_end();
	
	print("OnEvent_12790 end");
end

--■12790_1■漁るアニメ終了■ --EN:--■12790_1■Fishing animation ends■
function OnEvent_12790_1(proxy,param)
	print("OnEvent_12790_1 begin");
	--そんなグッズ取得 --EN:--Obtain such goods
	proxy:AddInventoryItem(1,TYPE_GOODS,10);
	proxy:GetItem(1,TYPE_GOODS);
	proxy:TreasureDispModeChange(1900, false );
	proxy:SetEventFlag(12790,true);
	print("OnEvent_12790_1 end");
end


--------------------------------------------------------------------------------------
--宝死体Bを調べる■12791 --EN:-- Examine Treasure Corpse B ■ 12791
--------------------------------------------------------------------------------------
--■12791■範囲内でACTボタンを押した■ --EN:--■ 12791 ■ ACT button pressed within range ■
function OnEvent_12791(proxy,param)
	print("OnEvent_12791 begin");
	
	--同期アニメーション用のイベント --EN:--event for synchronous animation
	proxy:LuaCallStart( 4010 , 1 );
	
	proxy:NotNetMessage_begin();
		--▼12791▼***条件追加***宝死体Aアイテム取得▼ --EN:--▼12791▼***Condition added***Treasure corpse A item acquisition▼
		proxy:OnKeyTime2( 12791, "OnEvent_12791_1", 0.0, 0, 0, once );		
	proxy:NotNetMessage_end();

	print("OnEvent_12791 end");
end

--■12791_1■漁るアニメ終了■ --EN:--■12791_1■Fishing animation ends■
function OnEvent_12791_1(proxy,param)
	print("OnEvent_12791_1 begin");
--~ 	proxy:AddInventoryItem(1,TYPE_GOODS,10);
--~ 	proxy:GetItem(1,TYPE_GOODS);
	proxy:SetEventFlag(12791,true);
	
	--会話イベント削除 --EN:--Delete conversation event
--~ 	proxy:DeleteEvent(150);
--~ 	proxy:DeleteEvent(14297);
--~ 	proxy:DeleteEvent(14298);
--~ 	proxy:DeleteEvent(14299);
--~ 	proxy:DeleteEvent(14293);	
	
	proxy:TreasureDispModeChange(1901, false );
	print("OnEvent_12791_1 end");
end


--------------------------------------------------------------------------------------
--キャラクタ更新監視■3500 --EN:-- Character update monitor 3500
--------------------------------------------------------------------------------------
function OnEvent_3500(proxy,param)
	--print("OnEvent_3500 begin");	
	SetDisable(proxy,900,false);	
	SetDisable(proxy,902,false);	
	SetDisable(proxy,903,false);	
	SetDisable(proxy,904,false);	
	SetDisable(proxy,908,false);	
	SetDisable(proxy,909,false);	
	SetDisable(proxy,910,false);
	--print("OnEvent_3500 end");
end

function OnEvent_3501(proxy,param)
	print("OnEvent_3501 begin");
	SetDisable(proxy,900,true);	
	SetDisable(proxy,902,true);	
	SetDisable(proxy,903,true);	
	SetDisable(proxy,904,true);	
	SetDisable(proxy,908,true);	
	SetDisable(proxy,909,true);	
	SetDisable(proxy,910,true);
	--print("OnEvent_3501 end");
end

--------------------------------------------------------------------------------------
--キャラクタ更新監視■3502 --EN:-- Character update monitor 3502
--------------------------------------------------------------------------------------
function OnEvent_3502(proxy,param)
	--print("OnEvent_3502 begin");
	SetDisable(proxy,908,false);	
	SetDisable(proxy,909,false);	
	SetDisable(proxy,910,false);	
	SetDisable(proxy,911,false);	
	SetDisable(proxy,912,false);	
	SetDisable(proxy,913,false);	
	SetDisable(proxy,914,false);	
	SetDisable(proxy,915,false);	
	SetDisable(proxy,916,false);
	--SetDisable(proxy,917,false);
	SetDisable(proxy,920,false);
	--print("OnEvent_3502 end");
end
function OnEvent_3503(proxy,param)
	print("OnEvent_3503 begin");
	SetDisable(proxy,908,true);	
	SetDisable(proxy,909,true);	
	SetDisable(proxy,910,true);	
	SetDisable(proxy,911,true);	
	SetDisable(proxy,912,true);	
	SetDisable(proxy,913,true);	
	SetDisable(proxy,914,true);	
	SetDisable(proxy,915,true);	
	SetDisable(proxy,916,true);
	--SetDisable(proxy,917,true);
	SetDisable(proxy,920,true);
	--print("OnEvent_3503 end");
end

--------------------------------------------------------------------------------------
--キャラクタ更新監視■3504 --EN:-- Character update monitor 3504
--------------------------------------------------------------------------------------
function OnEvent_3504(proxy,param)
	--print("OnEvent_3504 begin");
	SetDisable(proxy,905,false);	
	SetDisable(proxy,906,false);	
	SetDisable(proxy,907,false);		
	SetDisable(proxy,911,false);	
	SetDisable(proxy,912,false);	
	SetDisable(proxy,913,false);	
	SetDisable(proxy,914,false);	
	SetDisable(proxy,915,false);	
	SetDisable(proxy,916,false);	
	SetDisable(proxy,917,false);
	SetDisable(proxy,920,false);	
	SetDisable(proxy,930,false);
	--print("OnEvent_3504 end");
end

function OnEvent_3505(proxy,param)
	print("OnEvent_3505 begin");	
	SetDisable(proxy,905,true);	
	SetDisable(proxy,906,true);	
	SetDisable(proxy,907,true);	
	SetDisable(proxy,911,true);	
	SetDisable(proxy,912,true);	
	SetDisable(proxy,913,true);	
	SetDisable(proxy,914,true);	
	SetDisable(proxy,915,true);	
	SetDisable(proxy,916,true);	
	SetDisable(proxy,917,true);	
	SetDisable(proxy,920,true);	
	SetDisable(proxy,930,true);
	--print("OnEvent_3505 end");
end

--------------------------------------------------------------------------------------
--キャラクタ更新監視■3506 --EN:-- Character update monitor 3506
--------------------------------------------------------------------------------------
function OnEvent_3506(proxy,param)
	--print("OnEvent_3506 begin");
	SetDisable(proxy,911,false);	
	SetDisable(proxy,912,false);	
	SetDisable(proxy,913,false);	
	SetDisable(proxy,914,false);	
	SetDisable(proxy,915,false);	
	SetDisable(proxy,916,false);	
	SetDisable(proxy,905,false);	
	SetDisable(proxy,917,false);	
	SetDisable(proxy,906,false);	
	SetDisable(proxy,907,false);	
	SetDisable(proxy,920,false);	
	SetDisable(proxy,930,false);
	--print("OnEvent_3506 end");
end

function OnEvent_3507(proxy,param)
	print("OnEvent_3507 begin");
	SetDisable(proxy,911,true);	
	SetDisable(proxy,912,true);	
	SetDisable(proxy,913,true);	
	SetDisable(proxy,914,true);	
	SetDisable(proxy,915,true);	
	SetDisable(proxy,916,true);	
	SetDisable(proxy,905,true);	
	SetDisable(proxy,917,true);	
	SetDisable(proxy,906,true);	
	SetDisable(proxy,907,true);	
	SetDisable(proxy,920,true);	
	SetDisable(proxy,930,true);
	--print("OnEvent_3507 end");
end
--------------------------------------------------------------------------------------
--キャラクタ更新監視■3508 --EN:-- Character update monitor 3508
--------------------------------------------------------------------------------------
function OnEvent_3508(proxy,param)
	--print("OnEvent_3508 begin");
	SetDisable(proxy,900,false);	
	SetDisable(proxy,902,false);	
	SetDisable(proxy,903,false);	
	SetDisable(proxy,904,false);	
	SetDisable(proxy,905,false);	
	SetDisable(proxy,906,false);	
	SetDisable(proxy,907,false);	
	SetDisable(proxy,917,false);
	--print("OnEvent_3508 end");
end

function OnEvent_3509(proxy,param)
	print("OnEvent_3509 begin");
	SetDisable(proxy,900,true);
	SetDisable(proxy,902,true);
	SetDisable(proxy,903,true);
	SetDisable(proxy,904,true);
	SetDisable(proxy,905,true);
	SetDisable(proxy,906,true);
	SetDisable(proxy,907,true);
	SetDisable(proxy,917,true);
	--print("OnEvent_3509 end");
end

--------------------------------------------------------------------------------------
--キャラクタ更新監視■3510 --EN:-- Character update monitor 3510
--------------------------------------------------------------------------------------
function OnEvent_3510(proxy,param)
	--print("OnEvent_3510 begin");	
	SetDisable(proxy,901,false);
	SetDisable(proxy,920,false);
	SetDisable(proxy,930,false);
	--print("OnEvent_3510 end");
end

function OnEvent_3511(proxy,param)
	print("OnEvent_3511 begin");
	SetDisable(proxy,901,true);
	SetDisable(proxy,920,true);
	SetDisable(proxy,930,true);
	--print("OnEvent_3511 end");
end


--------------------------------------------------------------------------------------
--腐敗人殺した■10		※ValueBuffer	20082使用 --EN:--Destroyed and killed ■ 10 ※ValueBuffer 20082 used
--------------------------------------------------------------------------------------
function OnEvent_10(proxy,param)

	if Luafunc_DeadEne(proxy,param,10,20082,0) == false then
		return;
	end	

	--他の腐敗人のフラグをチェック、かつNPCが生きているなら --EN:--check other rotten flags, and if the NPC is alive
	if proxy:IsCompleteEvent(10) == true and
	proxy:IsCompleteEvent(11) == true and
	proxy:IsCompleteEvent(12) == true and
	proxy:IsAlive(900) == true then
		proxy:DeleteEvent(100);--NPCから助けを求められる --EN:--NPC asks for help
		print("NPC Help Me EventDelete");
	end
--[[	
	if proxy:IsAlive( 902 )==false and proxy:IsAlive( 903 )==false and proxy:IsAlive( 904 )==false then
		proxy:SetEventFlag(110,true);--会話ON --EN:--Conversation ON
		proxy:SetEventFlag(20080,0);
		proxy:EnableLogic(900, false);--NPC思考停止 --EN:--NPC thought stop
	end
]]	
	print("OnEvent_10 end 1");
end


--------------------------------------------------------------------------------------
--腐敗人殺した■11		※ValueBuffer	20082使用 --EN:--I killed a corrupt person ■11 ※Use ValueBuffer 20082
--------------------------------------------------------------------------------------
function OnEvent_11(proxy,param)

	if Luafunc_DeadEne(proxy,param,11,20082,0) == false then
		return;
	end
	
	--他の腐敗人のフラグをチェック、かつNPCが生きているなら --EN:--check other rotten flags, and if the NPC is alive
	if proxy:IsCompleteEvent(10) == true and
	proxy:IsCompleteEvent(11) == true and
	proxy:IsCompleteEvent(12) == true and
	proxy:IsAlive(900) == true then
		proxy:DeleteEvent(100);--NPCから助けを求められる --EN:--NPC asks for help
		print("NPC Help Me EventDelete");
	end	
--[[	
	if proxy:IsAlive( 902 )==false and proxy:IsAlive( 903 )==false and proxy:IsAlive( 904 )==false then
		proxy:SetEventFlag(110,true);--会話ON --EN:--Conversation ON
		proxy:SetEventFlag(20080,0);
		proxy:EnableLogic(900, false);--NPC思考停止 --EN:--NPC thought stop
	end
]]	
	print("OnEvent_11 end 2");
end


--------------------------------------------------------------------------------------
--腐敗人殺した■12		※ValueBuffer	20082使用 --EN:--I killed a corrupt person ■12 ※Use ValueBuffer 20082
--------------------------------------------------------------------------------------
function OnEvent_12(proxy,param)

	if Luafunc_DeadEne(proxy,param,12,20082,0) == false then
		return;
	end
	
	--他の腐敗人のフラグをチェック、かつNPCが生きているなら --EN:--check other rotten flags, and if the NPC is alive
	if proxy:IsCompleteEvent(10) == true and
	proxy:IsCompleteEvent(11) == true and
	proxy:IsCompleteEvent(12) == true and
	proxy:IsAlive(900) == true then
		proxy:DeleteEvent(100);		--NPCから助けを求められる --EN:--NPC asks for help
		print("NPC Help Me EventDelete");
	end	
--[[	
	if proxy:IsAlive( 902 )==false and proxy:IsAlive( 903 )==false and proxy:IsAlive( 904 )==false then
		proxy:SetEventFlag(110,true);--会話ON --EN:--Conversation ON
		proxy:SetEventFlag(20080,0);
		proxy:EnableLogic(900, false);--NPC思考停止 --EN:--NPC thought stop
	end
]]	
	print("OnEvent_12 end 3");
end


--------------------------------------------------------------------------------------
--腐敗人殺した■13		※ValueBuffer	20082使用 --EN:--I killed a corrupt person ■13 ※ValueBuffer 20082 used
--------------------------------------------------------------------------------------
function OnEvent_13(proxy,param)
	Luafunc_DeadEne(proxy,param,13,20082,0);
end


--------------------------------------------------------------------------------------
--腐敗人殺した■14		※ValueBuffer	20082使用 --EN:--I killed a corrupt person ■14 ※Use ValueBuffer 20082
--------------------------------------------------------------------------------------
function OnEvent_14(proxy,param)
	Luafunc_DeadEne(proxy,param,14,20082,0);
end


--------------------------------------------------------------------------------------
--腐敗人殺した■15		※ValueBuffer	20082使用 --EN:--I killed a corrupt person ■15 ※Use ValueBuffer 20082
--------------------------------------------------------------------------------------
function OnEvent_15(proxy,param)
	Luafunc_DeadEne(proxy,param,15,20082,0);
end


--------------------------------------------------------------------------------------
--腐敗人殺した■15906		※ValueBuffer	20082使用 --EN:--Destroyed murder ■ 15906 ※ValueBuffer 20082 used
--------------------------------------------------------------------------------------
function OnEvent_15906(proxy,param)
	Luafunc_DeadEne(proxy,param,15906,20082,0);
end


--------------------------------------------------------------------------------------
--腐敗人殺した■15907		※ValueBuffer	20082使用 --EN:--Destroyed murder ■ 15907 ※ValueBuffer 20082 used
--------------------------------------------------------------------------------------
function OnEvent_15907(proxy,param)
	Luafunc_DeadEne(proxy,param,15907,20082,0);
end


--------------------------------------------------------------------------------------
--腐敗人殺した■15908		※ValueBuffer	20082使用 --EN:--Destroyed murder ■ 15908 ※ ValueBuffer 20082 used
--------------------------------------------------------------------------------------
function OnEvent_15908(proxy,param)
	Luafunc_DeadEne(proxy,param,15908,20082,0);
end


--------------------------------------------------------------------------------------
--腐敗人殺した■15909		※ValueBuffer	20082使用 --EN:--Destroyed murder ■ 15909 ※ValueBuffer 20082 used
--------------------------------------------------------------------------------------
function OnEvent_15909(proxy,param)
	Luafunc_DeadEne(proxy,param,15909,20082,0);
end


--------------------------------------------------------------------------------------
--腐敗人殺した■15910		※ValueBuffer	20082使用 --EN:--Destroyed murder ■ 15910 *ValueBuffer 20082 used
--------------------------------------------------------------------------------------
function OnEvent_15910(proxy,param)
	Luafunc_DeadEne(proxy,param,15910,20082,0);
end


--------------------------------------------------------------------------------------
--腐敗人殺した■15911		※ValueBuffer	20082使用 --EN:--Destroyed murder ■ 15911 *ValueBuffer 20082 used
--------------------------------------------------------------------------------------
function OnEvent_15911(proxy,param)
	Luafunc_DeadEne(proxy,param,15911,20082,0);
end


--------------------------------------------------------------------------------------
--腐敗人殺した■15912		※ValueBuffer	20082使用 --EN:--Destroyed and killed ■ 15912 ※ValueBuffer 20082 used
--------------------------------------------------------------------------------------
function OnEvent_15912(proxy,param)
	Luafunc_DeadEne(proxy,param,15912,20082,0);
end


--------------------------------------------------------------------------------------
--腐敗人殺した■15929		※ValueBuffer	20082使用 --EN:--Destroyed and killed ■ 15929 ※ValueBuffer 20082 used
--------------------------------------------------------------------------------------
function OnEvent_15929(proxy,param)
	Luafunc_DeadEne(proxy,param,15929,20082,0);
end


--------------------------------------------------------------------------------------
--腐敗人殺した■15930		※ValueBuffer	20082使用 --EN:--Destroyed and killed ■ 15930 ※ValueBuffer 20082 used
--------------------------------------------------------------------------------------
function OnEvent_15930(proxy,param)
	Luafunc_DeadEne(proxy,param,15930,20082,0);
end


--------------------------------------------------------------------------------------
--NPCの腐敗人に対する監視■ --EN:--Monitoring NPC Corrupts■
--------------------------------------------------------------------------------------
function OnEvent_10_1(proxy,param)
	Luafunc_searchEne_in(proxy,param,10,902);
end

function OnEvent_10_2(proxy,param)
	Luafunc_searchEne_out(proxy,param,10,902);
end

--------------------------------------------------------------------------------------
--NPCの腐敗人に対する監視■ --EN:--Monitoring NPC Corrupts■
--------------------------------------------------------------------------------------
function OnEvent_11_1(proxy,param)
	Luafunc_searchEne_in(proxy,param,11,903);
end

function OnEvent_11_2(proxy,param)
	Luafunc_searchEne_out(proxy,param,11,903);
end

--------------------------------------------------------------------------------------
--NPCの腐敗人に対する監視■ --EN:--Monitoring NPC Corrupts■
--------------------------------------------------------------------------------------
function OnEvent_12_1(proxy,param)
	Luafunc_searchEne_in(proxy,param,12,904);
end

function OnEvent_12_2(proxy,param)
	Luafunc_searchEne_out(proxy,param,12,904);
end

--------------------------------------------------------------------------------------
--NPCの腐敗人に対する監視■ --EN:--Monitoring NPC Corrupts■
--------------------------------------------------------------------------------------
function OnEvent_13_1(proxy,param)
	Luafunc_searchEne_in(proxy,param,13,905);
end

function OnEvent_13_2(proxy,param)
	Luafunc_searchEne_out(proxy,param,13,905);
end

--------------------------------------------------------------------------------------
--NPCの腐敗人に対する監視■ --EN:--Monitoring NPC Corrupts■
--------------------------------------------------------------------------------------
function OnEvent_14_1(proxy,param)
	Luafunc_searchEne_in(proxy,param,14,906);
end

function OnEvent_14_2(proxy,param)
	Luafunc_searchEne_out(proxy,param,14,906);
end

--------------------------------------------------------------------------------------
--NPCの腐敗人に対する監視■ --EN:--Monitoring NPC Corrupts■
--------------------------------------------------------------------------------------
function OnEvent_15_1(proxy,param)
	Luafunc_searchEne_in(proxy,param,15,911);
end

function OnEvent_15_2(proxy,param)	
	Luafunc_searchEne_out(proxy,param,15,911);
end

--------------------------------------------------------------------------------------
--騎士の死亡■5113 --EN:--Knight's death ■5113
--------------------------------------------------------------------------------------
function OnEvent_5113(proxy,param)
	if proxy:IsCompleteEvent(5113) == true then
		return;
	end
	print("OnEvent_5113 begin");	
	--騎士死んだフラグON --EN:--Knight dead flag ON
	proxy:SetEventFlag(5113,true);	
	--アイテムを取っている --EN:-- Picking up items
	if proxy:IsCompleteEvent(12791) == true then
		
	--アイテムを取ってない --EN:--I didn't pick up the item
	else		
		--会話がループするのでフラグをOFF --EN:--Conversation loops, so turn off the flag
		proxy:SetEventFlag(10000,false);
	end
	
	print("OnEvent_5113 end");
end


--------------------------------------------------------------------------------------
--僧侶の会話■OnEvent_150  ※ValueBuffer 20090使用 --EN:--Monk's Conversation OnEvent_150 *Uses ValueBuffer 20090
--------------------------------------------------------------------------------------
--■アクションボタン判定■ --EN:-- ■ Action button judgment ■
function OnEvent_150(proxy,param)	
	print("OnEvent_150 begin");
	local FlagValue = proxy:IsCompleteEventValue(20090);
	--僧侶と話したフラグON							 --EN:-- Flag ON when talking with a monk
	--既にこの会話を聞いてない --EN:--I haven't heard this conversation yet
	if proxy:IsCompleteEvent(14295) == false then
		--騎士を殺して無い --EN:--I didn't kill the knight
		if proxy:IsCompleteEvent(5113) == false then
			--アイテムを取ってない --EN:--I didn't pick up the item
			if proxy:IsCompleteEvent(12791) == false then
			
				if FlagValue == 0 then proxy:SetEventFlag(20090,1);	end
				if FlagValue == 1 then proxy:SetEventFlag(20090,2);	end
				if FlagValue == 2 then proxy:SetEventFlag(20090,3);	end
				if FlagValue == 3 then 
					proxy:SetEventFlag(20090,0);
					proxy:SetEventFlag(14295,true);				
				end
			--アイテムを取っている --EN:-- Picking up items
			else
				if FlagValue == 0 then proxy:SetEventFlag(20090,1);	end
				if FlagValue == 1 then proxy:SetEventFlag(20090,2);	end
				if FlagValue == 2 then proxy:SetEventFlag(20090,3);	end
				if FlagValue == 3 then proxy:SetEventFlag(20090,4);	end
				if FlagValue == 4 then 	
					Luafunc_StageClear(proxy,param,150);					
				end	
			end
		--騎士を殺してる --EN:--Killing a knight
		else
			--アイテムを取ってない --EN:--I didn't pick up the item
			if proxy:IsCompleteEvent(12791) == false then
				if proxy:IsCompleteEvent(10000) == false then
					if FlagValue == 0 then proxy:SetEventFlag(20090,1);	end
					if FlagValue == 1 then proxy:SetEventFlag(20090,2);	end
					if FlagValue == 2 then proxy:SetEventFlag(20090,3);	end
					if FlagValue == 3 then
						proxy:SetEventFlag(20090,0);
						proxy:SetEventFlag(10000,true);
						proxy:SetEventFlag(14295,true);				
					end
				else
					if FlagValue == 0 then proxy:SetEventFlag(20090,1);	end
					if FlagValue == 1 then proxy:SetEventFlag(20090,2);	end
					if FlagValue == 2 then
						proxy:SetEventFlag(20090,0);
						proxy:SetEventFlag(14295,true);				
					end
				end
			--アイテムを取っている --EN:-- Picking up items
			else
				if FlagValue == 0 then proxy:SetEventFlag(20090,1);	end
				if FlagValue == 1 then proxy:SetEventFlag(20090,2);	end
				if FlagValue == 2 then proxy:SetEventFlag(20090,3);	end
				if FlagValue == 3 then proxy:SetEventFlag(20090,4);	end
				if FlagValue == 4 then					
					Luafunc_StageClear(proxy,param,150);	
					proxy:SetEventFlag(20090,0);
				end
			end
		end
	--会話を聞いている --EN:--listening to a conversation
	else
		--騎士を殺してない --EN:--I didn't kill the knight
		if proxy:IsCompleteEvent(5113) == false then
			--アイテムを取ってない --EN:--I didn't pick up the item
			if proxy:IsCompleteEvent(12791) == false then
				if FlagValue == 0 then proxy:SetEventFlag(20090,1);	end
				if FlagValue == 1 then proxy:SetEventFlag(20090,2);	end	
				if FlagValue == 2 then proxy:SetEventFlag(20090,0);	end	
			--アイテムを取っている --EN:-- Picking up items
			else
				if FlagValue == 0 then proxy:SetEventFlag(20090,1);	end
				if FlagValue == 1 then proxy:SetEventFlag(20090,2);	end
				if FlagValue == 2 then proxy:SetEventFlag(20090,3);	end
				if FlagValue == 3 then proxy:SetEventFlag(20090,4);	end
				if FlagValue == 4 then					
					Luafunc_StageClear(proxy,param,150);
					proxy:SetEventFlag(20090,0);
				end
			end
		--騎士を殺している --EN:--killing the knight
		else
			--アイテムを取ってない --EN:--I didn't pick up the item
			if proxy:IsCompleteEvent(12791) == false then
				if proxy:IsCompleteEvent(10000) == false then
					if FlagValue == 0 then proxy:SetEventFlag(20090,1);	end
					if FlagValue == 1 then proxy:SetEventFlag(20090,2);	end
					if FlagValue == 2 then proxy:SetEventFlag(20090,3);	end
					if FlagValue == 3 then
						proxy:SetEventFlag(20090,0);
						proxy:SetEventFlag(10000,true);
					end
				else
					if FlagValue == 0 then proxy:SetEventFlag(20090,1);	end
					if FlagValue == 1 then proxy:SetEventFlag(20090,2);	end
					if FlagValue == 2 then proxy:SetEventFlag(20090,0);	end
				end			
			--アイテムを取っている --EN:-- Picking up items
			else
				if FlagValue == 0 then proxy:SetEventFlag(20090,1);	end
				if FlagValue == 1 then proxy:SetEventFlag(20090,2);	end
				if FlagValue == 2 then proxy:SetEventFlag(20090,3);	end
				if FlagValue == 3 then proxy:SetEventFlag(20090,4);	end
				if FlagValue == 4 then					
					Luafunc_StageClear(proxy,param,150);
					proxy:SetEventFlag(20090,0);
				end
			end
		end
	end
	print("OnEvent_150 end");
end

--■可聴判定■ --EN:-- ■ audible judgment ■
function OnEvent_150_1(proxy,param)
	--print("OnEvent_150_1 begin");
	local FlagValue = proxy:IsCompleteEventValue(20090);
	
	--会話を聞いていない --EN:--not listening to the conversation
	if proxy:IsCompleteEvent(14295) == false then
		--騎士を殺して無い --EN:--I didn't kill the knight
		if proxy:IsCompleteEvent(5113) == false then
			--アイテムを取ってない --EN:--I didn't pick up the item
			if proxy:IsCompleteEvent(12791) == false then
				Luafunc_Talk(proxy,FlagValue,1,901,90000300,true);
				Luafunc_Talk(proxy,FlagValue,2,901,90000301,true);
				Luafunc_Talk(proxy,FlagValue,3,901,90000302,false);
			--アイテムを取っている --EN:-- Picking up items
			else
				Luafunc_Talk(proxy,FlagValue,1,901,90000303,true);
				Luafunc_Talk(proxy,FlagValue,2,901,90000307,true);
				Luafunc_Talk(proxy,FlagValue,3,901,90000305,true);
				Luafunc_Talk(proxy,FlagValue,4,901,90000306,false);
			end
		--騎士を殺してる --EN:--Killing a knight
		else
			--アイテムを取ってない --EN:--I didn't pick up the item
			if proxy:IsCompleteEvent(12791) == false then
				if proxy:IsCompleteEvent(10000) == false then
					Luafunc_Talk(proxy,FlagValue,1,901,90000308,true);
					Luafunc_Talk(proxy,FlagValue,2,901,90000310,true);
					Luafunc_Talk(proxy,FlagValue,3,901,90000302,false);
				else
					Luafunc_Talk(proxy,FlagValue,1,901,90000310,true);
					Luafunc_Talk(proxy,FlagValue,2,901,90000302,false);
				end
			--アイテムを取っている --EN:-- Picking up items
			else
				Luafunc_Talk(proxy,FlagValue,1,901,90000309,true);
				Luafunc_Talk(proxy,FlagValue,2,901,90000307,true);
				Luafunc_Talk(proxy,FlagValue,3,901,90000305,true);
				Luafunc_Talk(proxy,FlagValue,4,901,90000306,false);		
			end
		end
	--会話を聞いている --EN:--listening to a conversation
	else
		--騎士を殺してない --EN:--I didn't kill the knight
		if proxy:IsCompleteEvent(5113) == false then
			--アイテムを取ってない --EN:--I didn't pick up the item
			if proxy:IsCompleteEvent(12791) == false then
				Luafunc_Talk(proxy,FlagValue,1,901,90000301,true);
				Luafunc_Talk(proxy,FlagValue,2,901,90000302,false);					
			--アイテムを取っている --EN:-- Picking up items
			else
				Luafunc_Talk(proxy,FlagValue,1,901,90000303,true);
				Luafunc_Talk(proxy,FlagValue,2,901,90000304,true);
				Luafunc_Talk(proxy,FlagValue,3,901,90000305,true);
				Luafunc_Talk(proxy,FlagValue,4,901,90000306,false);
			end
		--騎士を殺している --EN:--killing the knight
		else
			--アイテムを取ってない --EN:--I didn't pick up the item
			if proxy:IsCompleteEvent(12791) == false then				
				if proxy:IsCompleteEvent(10000) == false then
					Luafunc_Talk(proxy,FlagValue,1,901,90000308,true);
					Luafunc_Talk(proxy,FlagValue,2,901,90000310,true);
					Luafunc_Talk(proxy,FlagValue,3,901,90000302,false);
				else
					Luafunc_Talk(proxy,FlagValue,1,901,90000310,true);
					Luafunc_Talk(proxy,FlagValue,2,901,90000302,false);
				end;
				
			--アイテムを取っている --EN:-- Picking up items
			else
				Luafunc_Talk(proxy,FlagValue,1,901,90000303,true);
				Luafunc_Talk(proxy,FlagValue,2,901,90000304,true);
				Luafunc_Talk(proxy,FlagValue,3,901,90000305,true);
				Luafunc_Talk(proxy,FlagValue,4,901,90000306,false);		
			end
		end
	end
	--print("OnEvent_150_1 end");
end

--■距離外判定■ --EN:-- ■ Out-of-distance judgment ■
function OnEvent_150_2(proxy,param)
	print("OnEvent_150_2 begin");
	--離れたらページを戻す --EN:--Return the page when you leave
	local FlagValue = proxy:IsCompleteEventValue(20090);
	if FlagValue >= 1 then
		proxy:SetEventFlag(20090,0);
	end
	
	print("OnEvent_150_2 end");
end



--------------------------------------------------------------------------------------
--騎士咆哮■ --EN:--Knight's Roar■
--------------------------------------------------------------------------------------
function OnEvent_180(proxy,param)
	if proxy:IsCompleteEvent(180) == true then
		return;
	end	
	if proxy:IsPlayerStay(920) == false then
		proxy:SetEventFlag(180,true);
		return;
	end
	
	if proxy:IsAlive(920) == false then
		proxy:SetEventFlag(180,true);
		return;
	end
	print("OnEvent_180 begin");
	proxy:PlayAnimation(920,9010);
	print("騎士咆哮！"); --EN:print("Knight's Roar!");
	proxy:SetEventFlag(180,true);
	print("OnEvent_180 end");
end


--------------------------------------------------------------------------------------
--テンプレ■ --EN:--Template ■
--------------------------------------------------------------------------------------
--~ function OnEvent_12790(proxy,param)
--~ 	print("OnEvent_12790 begin");
--~ 	print("OnEvent_12790 end");
--~ end

--■Lua定義関数■敵の死亡の監視■ --EN:--■ Lua definition function ■ Monitoring enemy deaths ■
function Luafunc_DeadEne(proxy,param,nEventID,ValueBuffer,nTargetID)
	print("OnEvent_" ,nEventID," begin");
	
	--既に終了しているイベント --EN:--events that have already ended
	if proxy:IsCompleteEvent(nEventID) == true then
		print("OnEvent_" ,nEventID," end");
		proxy:DeleteEvent( nEventID );
		return false;
	end
	
	--このイベントを終了 --EN:--End this event
	proxy:SetEventFlag(nEventID,true);
	print("OnEvent_" ,nEventID," end");
	return true;
end

--■Lua定義関数■敵の監視■(敵が範囲内に入ったとき) --EN:-- ■ Lua definition function ■ Enemy monitoring ■ (When an enemy enters the range)
function Luafunc_searchEne_in(proxy,param,nEventID,nTargetID)

--[[
	print("OnEvent_" ,nEventID," begin");
	
	--対象が死んでいたら処理しない --EN:--Do not process if the target is dead
	if proxy:IsAlive(nTargetID) == false then
		print("OnEvent_" ,nEventID," end");
		return;
	end
	
	--対象イベントが終了していたら処理しない --EN:--Do not process if the target event has ended
	if proxy:IsCompleteEvent(nEventID) == true then
		print("OnEvent_" ,nEventID," end");
		return;
	end

	proxy:SetEventFlag(110,false);	--会話OFF --EN:--Conversation OFF
	proxy:SetEventFlag(20080,99);	--会話用の値をセット --EN:--Set value for conversation
	proxy:EnableLogic(900, true);	--NPC思考ON --EN:--NPC thinking ON
	
	print("OnEvent_" ,nEventID," end");
]]

end

--■Lua定義関数■敵の監視■(敵が範囲内に入ったあとでたとき) --EN:-- ■ Lua definition function ■ Enemy monitoring ■ (when the enemy leaves after entering the range)
function Luafunc_searchEne_out(proxy,param,nEventID,nTargetID)

--[[
	print("OnEvent_" ,nEventID," begin");
	
	--対象の敵3匹が死んでいたとき会話ON & NPC思考OFF --EN:--Conversation ON & NPC thinking OFF when 3 target enemies are dead
	--(この処理では局所的すぎる。NPCからみて、敵が範囲内にいないときに切り替えるべき) --EN:--(This process is too local. From the NPC's point of view, it should be switched when the enemy is not within range)
	--(3匹のいずれかが生きているときに、違う敵をつれてくると、) --EN:--(When one of the three is alive, if you bring a different enemy,
	--(一瞬会話がONになり、アクション名が表示されてしまう) --EN:--(Conversation is turned on for a moment and the action name is displayed)
	
	if proxy:IsAlive( 902 )==false and proxy:IsAlive( 903 )==false and proxy:IsAlive( 904 )==false then
		proxy:SetEventFlag(110,true);--会話ON --EN:--Conversation ON
		proxy:SetEventFlag(20080,0);
		proxy:EnableLogic(900, false);--NPC思考停止 --EN:--NPC thought stop
	end

	print("OnEvent_" ,nEventID," end");
]]

end


--■Lua定義関数■マップクリア■ --EN:-- ■ Lua definition function ■ Map clear ■
function Luafunc_StageClear(proxy,param,nEventID)
	proxy:DeleteEvent(nEventID);
	--PTを組んでいるか？ --EN:--Do you have a PT?
	if proxy:IsInParty() == true then
		--ホストだったら --EN:--If you're the host
		if proxy:IsHost() == true then
			proxy:NotNetMessage_begin();
				proxy:OnKeyTime2(3000,"HostStageClear",2.0,0,0,once);				
			proxy:NotNetMessage_end();
		else
			return;
		end
	else		
		proxy:OnKeyTime2(3000,"HostStageClear",2.0,0,0,once);
	end	
end


--■Lua定義関数■10末会話用■ --EN:-- ■ Lua definition function ■ For conversation at the end of 10 ■
function Luafunc_Talk(proxy,nVal,nVal2,nTargetID,TalkID,bPage)
	if nVal == nVal2 then
		proxy:StartTalk(TalkID,bPage);
		proxy:PlayAnimation(nTargetID,6500);
	end
end





function Check(proxy,param)
	--レジストは毎フレーム通るから確認取れたらコメントアウトしてって言ったと思うんだけど？ --EN:--Since the registration goes through every frame, I think I told you to comment it out after confirming it, right?
	--print("Check");
	
	check_npc_id = 900;
	
	if proxy:IsCompleteEvent( 121 ) == true then --NPCの死亡監視イベントが終わってたら --EN:--When the NPC death watch event is over
		print("npc(id:900) is dead");
		print("return false and delete event 12345");
		proxy:DeleteEvent( 12345 );
		return false;
	end
	
	check_distance = 5.0;
	
	check_enemy_id_list       = { 902 , 903 , 904 , 905 , 906 , 911 };
	check_enemy_event_id_list = { 10 , 11 , 12 , 13 , 14 , 15 };
	num = table.getn( check_enemy_id_list );
	
	for i=1, num, 1 do
	
		now_check_enemy_id       = check_enemy_id_list[i];
		now_check_enemy_event_id = check_enemy_event_id_list[i];
		
		if proxy:IsCompleteEvent( now_check_enemy_event_id ) == false then
			
			--print( "now check enemy(id:"..now_check_enemy_id..")" );
			
			if proxy:IsDistance( check_npc_id , now_check_enemy_id , check_distance ) == true then

				--print( "found enemy(id:"..now_check_enemy_id..")" );
				--print( "return true" );
				return true;
			
			end
		end
	end


	if proxy:IsCompleteEventValue( 20080 ) == 99 then

		proxy:SendEventRequest( 900 , 0,AI_EVENT_None );--何もしないようにお願いする。 --EN:--I ask you not to do anything.
		proxy:EnableLogic( 900 , false );--考えるのをやめる。 --EN:-- Stop thinking.
		
		proxy:SetEventFlag(110 , true);--会話を有効にする --EN:--Enable Conversation
		proxy:SetEventFlag(20080,0);--会話用の値をセット(テキストの表示用) --EN:--Set values for conversation (for displaying text)

	end

	--ここも --EN:--Here also
	--print( "return false" );
	return false;
end



function OnEvent_12345(proxy,param)
	--print("OnEvent_12345 begin");

	proxy:EnableLogic( 900 , true );
	proxy:SetEventFlag(110,false);
	proxy:SetEventFlag(20080,99);	--会話用の値をセット --EN:--Set value for conversation
		
	--print("OnEvent_12345 end");
end



--------------------------------------------------------------------------------------
--徘徊デーモンの登場■?? --EN:-- Appearance of the Wandering Demon ??
--------------------------------------------------------------------------------------

--▼グローバルの死亡監視から呼ばれる(ソロ) --EN:--▼ Called from global death watch (solo)
function PlayerDeath_m03_01_00_99(proxy, param)
	print("PlayerDeath_m03_01_00_99");
	
--	LuaFunc_VisibleTheWanderingDemon(proxy, param, demon_id_list_m03_01_00_99);
--	proxy:SetEventFlag( 20 , 1 );--フラグは仮、指定があれば変える。 --EN:The -- flag is tentative, and will be changed if specified.
	
	print("PlayerDeath_m03_01_00_99");
end

--▼グローバルの血文字復活から呼ばれる(ソロ) --EN:--▼Called from global blood letter revival (solo)
function PlayerRevive_m03_01_00_99(proxy,param)
	print("PlayerRevive_m03_01_00_99");
	
--	LuaFunc_InvisibleTheWanderingDemon(proxy, param, demon_id_list_m03_01_00_99);
--	proxy:SetEventFlag( 20 , 0 );--フラグは仮、指定があれば変える。 --EN:The -- flag is tentative, and will be changed if specified.
	
	print("PlayerRevive_m03_01_00_99");
end



