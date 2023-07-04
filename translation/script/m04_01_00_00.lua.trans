
--鎖の虜囚を斬って死亡するまでの間 --EN:--Between slashing prisoners in chains and dying
REMO_WAIT = 3.0;

--[[------------------------------------------------------------------------------------
--マップ読み込み時に読まれる初期化処理■ --EN:--Initialization process read when reading the map ■
--------------------------------------------------------------------------------------]]
function Initialize_m04_01_00_00(proxy)
	print("Initialize_m04_01_00_00 begin");
	
--■523■ボス部屋に入る■ --EN:-- ■ 523 ■ Enter the boss room ■
	--中ボスが生きているときだけイベント登録 --EN:-- Event registration only when the mid-boss is alive
	if proxy:IsCompleteEvent( 5251 ) == false then
		--ソロのときは一度目にボス部屋に入る用のイベントを毎回登録させたいので、対応するフラグをOFFにする。 --EN:-- When soloing, we want to register the event for entering the boss room for the first time every time, so turn off the corresponding flag.
		SingleReset(proxy, 523);
		--▽同期アニメ再生用の開始ハンドラ(旋回→歩き) --EN:--▽ Start handler for synchronous animation playback (turning → walking)
		proxy:LuaCall( 524, 1, "OnEvent_524_1", everytime );
		--▽2回目以降にボス部屋に入るためのイベント配信用 --EN:--▽For event delivery to enter the boss room after the second time
		proxy:LuaCall( 524 , 5 , "OnEvent_523_GO_TO_IN" , everytime );
		--▽フラグセット(同期用) --EN:--▽flag set (for synchronization)
		proxy:LuaCall( 524 , 6 , "OnEvent_523_flag_set" , everytime );
		--誰かがボス前扉をまだ通過していない --EN:--Someone hasn't passed through the boss front door yet
		if proxy:IsCompleteEvent( 523 ) == false then		
			--(セッション中に)ボス前の魔法壁を最初に通れるのは生存の人だけ --EN:--(During the session) Only survivors can pass through the magic wall in front of the boss first
			local possible_chr_type = ATTR_HOST + ATTR_LIVE + ATTR_GREY;
			proxy:NotNetMessage_begin();
				--▼523▼中に入るためのイベントを追加▼ --EN:--▼523▼ Added an event to enter ▼
				proxy:OnPlayerActionInRegionAttribute( 523, 2894, "OnEvent_523", HELPID_GO_TO_IN, possible_chr_type, everytime );
			proxy:NotNetMessage_end();
		else --グレイゴーストできたときようにいると思われる。 --EN:--Gray ghost seems to be like that when it's done.
			proxy:NotNetMessage_begin();
				--▼524▼中に入るためのイベントを追加▼--ハンドラは上と同じ --EN:--▼524▼Add an event to enter inside▼--The handler is the same as above
				proxy:OnPlayerActionInRegion( 524, 2894, "OnEvent_523", HELPID_GO_TO_IN, everytime );
			proxy:NotNetMessage_end();
		end
	else
		InvalidCharactor( proxy, 807 );
		InvalidCharactor( proxy, 817 );
	end
	
--■525■ボス戦闘開始■ --EN:-- ■ 525 ■ Boss battle begins ■
	if proxy:IsCompleteEvent( 5251 ) == false then
		proxy:OnRegionJustIn( 525 , 10000 , 2886 , "OnEvent_525" , once );
	end
	
--■5251■崩れる壁■ボスが死んだら-- --EN:-- ■ 5251 ■ The crumbling wall ■ When the boss dies --
	proxy:AddFieldInsFilter( 807 );
	proxy:AddFieldInsFilter( 817 );
	if	proxy:IsCompleteEvent( 5251 ) == false then
		SingleReset(proxy, 5250 );
		SingleReset(proxy, 5253 );
		if	proxy:IsCompleteEvent( 5250 ) == false or
			proxy:IsCompleteEvent( 5253 ) == false then
			proxy:OnCharacterDead(5250,807,"OnEvent_5251",once);
			--proxy:OnCharacterDead(5251,817,"OnEvent_5251",once);
			proxy:OnCharacterDead(5253,817,"OnEvent_5251",once);
		end
	else
		proxy:InvalidSfx( 1986, false );
		proxy:InvalidSfx( 1990, false );
	end
	
	--[[■512■石柱にワープ■ --EN:--[[ ■ 512 ■ Warp to the stone pillar ■
	proxy:OnDistanceActionAttribute( 512, 10000, 1982, "OnEvent_512", WarpGimmickDist_A, HELPID_GO_TO_SEKITYUU, 0, 180, ATTR_NOSESSION, everytime );
	]]

--■??■徘徊デーモンの登場■ハンドラ登録 --EN:--■??■Appearance of wandering daemon■Handler registration
	proxy:NotNetMessage_begin();
		--プレイヤーがソロで死亡した時にキックされます。 --EN:--Kicked when a player dies solo.
		proxy:LuaCall( 4000, 100, "PlayerDeath_m04_01_00_00", everytime );
		--プレイヤーが復活した時にキックされます。 --EN:--Kicked when the player is revived.
		proxy:LuaCall( 4032, 100, "PlayerRevive_m04_01_00_00", everytime );
	proxy:NotNetMessage_end();


	
--■542■キメラ玉落下、破裂ポリ劇■ --EN:-- ■ 542 ■ Chimera ball falling, explosion poly drama ■
	proxy:SetColiEnable( 1201, false );
	proxy:SetDrawEnable( 1201, false );
	if proxy:IsCompleteEvent( 542 ) == false then
--> イベントID　2245 --EN:--> Event ID 2245
--> 　200～203 --EN:--> 200-203
--> 
--> イベントID　2246 --EN:--> Event ID 2246
--> 　210～213 --EN:--> 210-213
	--■540■キメラ玉の鎖解放１ポリ劇■ --EN:--■ 540 ■ Chimera ball chain release 1 poly play ■
		if proxy:IsCompleteEvent( 540 ) == false then
			TurnTarget2( proxy, 200, 2245, -1 );
			TurnTarget2( proxy, 201, 2245, -1 );
			TurnTarget2( proxy, 202, 2245, -1 );
			TurnTarget2( proxy, 203, 2245, -1 );
			proxy:OnRegistFunc( 540, "Condition_540", "OnEvent_540", 2, once );
			
			proxy:LuaCall(540,1,"OnEvent_540_2",once);
			--ポリ劇開始フェード後に呼ばれるハンドラ --EN:--Handler called after polyplay start fade
			proxy:LuaCall(540,REMO_START,"OnEvent_540_RemoStart",once);
			--ポリ劇終了後に呼ばれるハンドラ --EN:--Handler called after the polyplay ends
			proxy:LuaCall(540,REMO_FINISH,"OnEvent_540_RemoFinish",once);
		else
			proxy:SetDrawEnable( 1280, false );
			proxy:SetColiEnable( 1280, false );
			proxy:SetDrawEnable( 1281, true );
			proxy:SetColiEnable( 1281, true );
			
			InvalidCharactor( proxy, 200 );
			InvalidCharactor( proxy, 201 );
			InvalidCharactor( proxy, 202 );
			InvalidCharactor( proxy, 203 );			
			
			--緑色の炎Sfx消し --EN:-- Green flame Sfx extinguished
			proxy:InvalidSfx( 1285, false );
			--ポイントライトの無効化 --EN:--disable point light
			proxy:InvalidPointLight( 1298 );
		end
		
	--■541■キメラ玉の鎖解放２ポリ劇■ --EN:-- ■ 541 ■ Chimera ball chain release 2 poly play ■
		if proxy:IsCompleteEvent( 541 ) == false then
			TurnTarget2( proxy, 210, 2246, -1 );
			TurnTarget2( proxy, 211, 2246, -1 );
			TurnTarget2( proxy, 212, 2246, -1 );
			TurnTarget2( proxy, 213, 2246, -1 );
			proxy:OnRegistFunc( 541, "Condition_541", "OnEvent_541", 2, once );
			
			proxy:LuaCall(541,1,"OnEvent_541_2",once);
			--ポリ劇開始フェード後に呼ばれるハンドラ --EN:--Handler called after polyplay start fade
			proxy:LuaCall(541,REMO_START,"OnEvent_541_RemoStart",once);
			--ポリ劇終了後に呼ばれるハンドラ --EN:--Handler called after the polyplay ends
			proxy:LuaCall(541,REMO_FINISH,"OnEvent_541_RemoFinish",once);
		else
			proxy:SetDrawEnable( 1282, false );
			proxy:SetColiEnable( 1282, false );
			proxy:SetDrawEnable( 1283, true );
			proxy:SetColiEnable( 1283, true );
			
			InvalidCharactor( proxy, 210 );
			InvalidCharactor( proxy, 211 );
			InvalidCharactor( proxy, 212 );
			InvalidCharactor( proxy, 213 );				
			
			--緑色の炎Sfx消し --EN:-- Green flame Sfx extinguished
			proxy:InvalidSfx( 1286, false );
			--ポイントライト削除	 --EN:--Delete point light
			proxy:InvalidPointLight( 1298 );	
		end
		--proxy:OnRegistFunc( 542, "Condition_542", "OnEvent_542", 2, once );		
		--ポリ劇開始フェード後に呼ばれるハンドラ --EN:--Handler called after polyplay start fade
		proxy:LuaCall(542,REMO_START,"OnEvent_542_RemoStart",once);
		--ポリ劇終了後に呼ばれるハンドラ --EN:--Handler called after the polyplay ends
		proxy:LuaCall(542,REMO_FINISH,"OnEvent_542_RemoFinish",once);
		
		--柱オブジェ壊れていない状態(1290:壊れていない、1291:壊れている) --EN:--Pillar object not broken (1290: not broken, 1291: broken)
		proxy:SetDrawEnable( 1291 , false );
		proxy:SetColiEnable( 1291 , false );
		
		--柱オブジェ壊れている状態(1292:壊れていない、1293:壊れている) --EN:--Pillar object broken state (1292: not broken, 1293: broken)
		proxy:SetDrawEnable( 1293 , false );--マップパーツなので表示だけ消す --EN:-- Since it is a map part, only the display is erased

		--柱オブジェ壊れている状態(1315:壊れていない、1316:壊れている) --EN:--Pillar object broken state (1315: not broken, 1316: broken)
		proxy:SetColiEnable( 1316 , false );--ヒットパーツなので当たりだけ消す --EN:-- Since it is a hit part, only the hit is erased
		
		--ムカデ無効化 --EN:--Disable Centipede
		InvalidCharactor( proxy, 230 );
		InvalidCharactor( proxy, 231 );
		InvalidCharactor( proxy, 232 );
		InvalidCharactor( proxy, 233 );
		InvalidCharactor( proxy, 234 );
		InvalidCharactor( proxy, 235 );
		InvalidCharactor( proxy, 236 );
		InvalidCharactor( proxy, 237 );
		proxy:PlayPointSE( 2290, SOUND_TYPE_A, 400009, 4 );
	else
		proxy:SetDrawEnable(1200, false);
		proxy:SetColiEnable(1200, false);
		
		--柱オブジェ壊れている状態(1290:壊れていない、1291:壊れている) --EN:--Broken pillar object (1290: not broken, 1291: broken)
		proxy:SetDrawEnable( 1290 , false );
		proxy:SetColiEnable( 1290 , false );
		
		--柱オブジェ壊れている状態(1292:壊れていない、1293:壊れている) --EN:--Pillar object broken state (1292: not broken, 1293: broken)
		proxy:SetDrawEnable( 1292 , false );--マップパーツなので表示だけ消す --EN:-- Since it is a map part, only the display is erased
		
		--柱オブジェ壊れている状態(1315:壊れていない、1316:壊れている) --EN:--Pillar object broken state (1315: not broken, 1316: broken)
		proxy:SetColiEnable( 1315 , false );--ヒットパーツなので当たりだけ消す --EN:-- Since it is a hit part, only the hit is erased
		--緑色の炎Sfx消し --EN:-- Green flame Sfx extinguished
		proxy:InvalidSfx( 1285, false );
		proxy:InvalidSfx( 1286, false );
		proxy:InvalidSfx( 1287, false );
		
		InvalidCharactor( proxy, 200 );
		InvalidCharactor( proxy, 201 );
		InvalidCharactor( proxy, 202 );
		InvalidCharactor( proxy, 203 );
		
		InvalidCharactor( proxy, 210 );
		InvalidCharactor( proxy, 211 );
		InvalidCharactor( proxy, 212 );
		InvalidCharactor( proxy, 213 );	
			
		--ポイントライト削除 --EN:--Delete point light
		proxy:InvalidPointLight( 1297 );
		proxy:InvalidPointLight( 1298 );
		proxy:InvalidPointLight( 1299 );
	end
	
--■ユルト関連初期化■ --EN:--■ Yurt-related initialization ■
	SetFirstNpcStateFlag( proxy, param, yuruto_flag_list, YURUTO_STATE_LIFT );
	
--■15630■ユルトの死体を調べた■ --EN:--■ 15630 ■ Examine Yurt's corpse ■
	if proxy:IsCompleteEvent( 15630 ) == false then
		proxy:AddCorpseEvent( 15630 , 644 );
		proxy:NotNetMessage_begin();
			proxy:LuaCall( 15630 ,0 , "OnEvent_15630",once );
 		proxy:NotNetMessage_end();
	end	

	--エレベータ内か、牢城敵対状態の時 --EN:--In an elevator or when hostile to a prison
	if	proxy:IsCompleteEvent( YURUTO_STATE_LIFT ) 		== true or--ユルトがエレベーターに捕まっている　か --EN:--Is Yurt caught in the elevator?
		proxy:IsCompleteEvent( YURUTO_STATE_ANGRY_M4 )	== true or--ユルトが敵対している　ならば --EN:--If the yurt is hostile
		proxy:IsCompleteEvent( YURUTO_STANDBY_M1 ) == true then		--ユルトが石柱に行く前なら --EN:--before the yurt went to the pillar
		--■563■ユルト(死亡) --EN:-- ■ 563 ■ Yurt (Death)
		if proxy:IsCompleteEvent( 563 ) == false then
			proxy:OnCharacterDead( 563, 644, "OnEvent_563", once );--死亡監視追加 --EN:--Add death watch
		end
		
		if proxy:IsCompleteEvent( YURUTO_STATE_ANGRY_M4 ) == false then--敵対していないならば --EN:--if not hostile
			if proxy:IsCompleteEvent( YURUTO_STANDBY_M1 ) == false then
				proxy:EnableLogic( 644, false );
			else
				--初期位置を変更 --EN:--Change initial position
				proxy:Warp( 644 , 2255 );
			end
			
			--■560■ユルトを助ける(会話から呼び出し) --EN:-- ■ 560 ■ Help Yurt (call from conversation)
			if	proxy:IsCompleteEvent(560) == false then
				proxy:LuaCall( 560, 0, "OnEvent_560", everytime );
				--ユルト完全無敵 --EN:-- Yurt completely invincible
				proxy:EnableInvincible( 644, true );			
			end
			--[[
			--■561■会話でエレベータ移動 --EN:-- ■ 561 ■ Elevator movement with conversation
			if proxy:IsCompleteEvent( 561 ) == false then
				proxy:LuaCall( 561, 0, "OnEvent_561",   everytime );
				proxy:LuaCall( 561, 2, "OnEvent_561_call", everytime );
			end]]
			
			--■562■ユルト(敵対：牢城) --EN:-- ■ 562 ■ Yurt (Hostile: Prison Castle)
			if proxy:IsCompleteEvent( 562 ) == false then
				--proxy:OnCharacterTotalDamage( 562, 644, 10000, TOTALDAMAGE_YURUTO_M40, "OnEvent_562", once );
				proxy:OnCharacterTotalRateDamage( 562, 644, LOCAL_PLAYER, NPC_ANGRY_Rate, "OnEvent_562", once );
			end
			
			--ホストが更新権限を管理 --EN:--Host manages update permissions
			if	proxy:IsClient() == false then
				proxy:RequestForceUpdateNetwork(644);
			end
			proxy:OnRegionJustIn( 568, 644, 1269, "OnEvent_568", everytime );
			proxy:OnRegionJustIn( 568, 644, 1271, "OnEvent_568", everytime );
			proxy:OnRegionJustIn( 569, 644, 1268, "OnEvent_569", everytime );
			proxy:OnRegionJustIn( 569, 644, 1270, "OnEvent_569", everytime );
			
		else--敵対していたら --EN:--If you were hostile
			proxy:EnableLogic(644, true);
			--SetNpcStateFlag( proxy, param, yuruto_flag_list, YURUTO_STATE_ANGRY_M4 );
			proxy:SetTeamType( 644, TEAM_TYPE_AngryFriend );
		end
	else--死んでいるか、ここにいない場合 --EN:--if dead or not here
		if	proxy:IsCompleteEvent( 563 ) == true and
			proxy:IsCompleteEvent( 15630 ) == false then
			proxy:Warp( 644 , 2255 );
			
			proxy:NotNetMessage_begin();
				proxy:OnKeyTime2( 15630 , "OnEvent_15630_OpeningDead",0.1,0,15630,once);
			proxy:NotNetMessage_end();			
		else
			InvalidBackRead( proxy, 644 );
		end
	end
	
	--ユルトとの会話で扉が既に開いている場合の再現 --EN:--Reproduction when the door is already open in the conversation with Yurt
	--[[
	if	proxy:IsCompleteEvent( 560 ) == true then
		proxy:EndAnimation( 1254, 7 );
	end
]]
	proxy:RepeatMessage_begin();
	--■550■篭エレベータ1■ --EN:-- ■ 550 ■ basket elevator 1 ■
		proxy:SetIsAnimPauseOnRemoPlayForEvent(1250,true);
		proxy:SetIsAnimPauseOnRemoPlayForEvent(1251,true);
		proxy:OnRegionJustIn( 550, 10000, 1260, "OnEvent_550_1", everytime );
		proxy:OnRegionJustIn( 550, 10000, 1263, "OnEvent_550_1", everytime );		
		proxy:OnRegionJustIn( 550, 10000, 1261, "OnEvent_550_2", everytime );
		proxy:OnRegionJustIn( 550, 10000, 1262, "OnEvent_550_2", everytime );
		proxy:CustomLuaCall( 550 ,"OnEvent_550_flags",everytime ); 
		
		proxy:NotNetMessage_begin();
			proxy:OnRegionJustIn( 544 , 10000, 2280 ,"OnEvent_544_In",everytime);
			proxy:OnRegionJustOut( 544, 10000, 2280 ,"OnEvent_544_Out",everytime);
			proxy:OnRegionJustIn( 545 , 10000, 2281 ,"OnEvent_545_In",everytime);
			proxy:OnRegionJustOut( 545, 10000, 2281 ,"OnEvent_545_Out",everytime);
		proxy:NotNetMessage_end();
		
		--アニメ中のフラグはホストに任せる		 --EN:--Leave the flags in the animation to the host
		SingleReset( proxy,556 );		
		
		--上下セットのフラグでアニメ再生 --EN:--Animation playback with top and bottom set flags
		if proxy:IsCompleteEvent( 551 ) == false then
			proxy:EndAnimation( 1250, 2 );
			proxy:EndAnimation( 1251, 1 );
		else
			proxy:EndAnimation( 1250, 1 );
			proxy:EndAnimation( 1251, 2 );
		end		
		
		
	--■552■篭エレベータ2■ --EN:-- ■ 552 ■ basket elevator 2 ■
		proxy:SetIsAnimPauseOnRemoPlayForEvent(1252,true);
		proxy:SetIsAnimPauseOnRemoPlayForEvent(1253,true);
		proxy:OnRegionJustIn( 552, 10000, 1264, "OnEvent_552_1", everytime );
		proxy:OnRegionJustIn( 552, 10000, 1267, "OnEvent_552_1", everytime );
		proxy:OnRegionJustIn( 552, 10000, 1265, "OnEvent_552_2", everytime );
		proxy:OnRegionJustIn( 552, 10000, 1266, "OnEvent_552_2", everytime );
		proxy:CustomLuaCall( 552,"OnEvent_552_flags",everytime );
		
		proxy:NotNetMessage_begin();
			proxy:OnRegionJustIn(546,10000,2282,"OnEvent_546_In",everytime);
			proxy:OnRegionJustOut(546,10000,2282,"OnEvent_546_Out",everytime);
			proxy:OnRegionJustIn(547,10000,2283,"OnEvent_547_In",everytime);
			proxy:OnRegionJustOut(547,10000,2283,"OnEvent_547_Out",everytime);
		proxy:NotNetMessage_end();
		
		--アニメ中のフラグは同期に任せる --EN:--Leave flags during animation to synchronization
		SingleReset( proxy , 557 );	
		
		if	proxy:IsCompleteEvent( 553 ) == false then
			proxy:EndAnimation( 1252, 2 );
			proxy:EndAnimation( 1253, 1 );
		else
			proxy:EndAnimation( 1252, 1 );
			proxy:EndAnimation( 1253, 2 );
		end		
		
	--■554■篭エレベータ3■ --EN:-- ■ 554 ■ basket elevator 3 ■
		proxy:SetIsAnimPauseOnRemoPlayForEvent(1254,true);
		proxy:SetIsAnimPauseOnRemoPlayForEvent(1255,true);
		proxy:OnRegionJustIn( 554, 10000, 1268, "OnEvent_554_1", everytime );
		proxy:OnRegionJustIn( 554, 10000, 1271, "OnEvent_554_1", everytime );
		proxy:OnRegionJustIn( 554, 10000, 1269, "OnEvent_554_2", everytime );
		proxy:OnRegionJustIn( 554, 10000, 1270, "OnEvent_554_2", everytime );
		proxy:CustomLuaCall( 554,"OnEvent_554_flags",everytime);
		
		proxy:NotNetMessage_begin();
			proxy:OnRegionJustIn( 548,10000,2284,"OnEvent_548_In",everytime );
			proxy:OnRegionJustOut(548,10000,2284,"OnEvent_548_Out",everytime);
			proxy:OnRegionJustIn( 549,10000,2285,"OnEvent_549_In",everytime );
			proxy:OnRegionJustOut(549,10000,2285,"OnEvent_549_Out",everytime); 
		proxy:NotNetMessage_end();
		--アニメ中のフラグは同期に任せる --EN:--Leave flags during animation to synchronization
		SingleReset( proxy, 558 );
		
		--ユルトのエレベータイベントが終っていない場合はデフォルトの状態とする --EN:--default state if yurt elevator event is not finished
		if	proxy:IsCompleteEvent( 560 ) == false then
			proxy:EndAnimation( 1255, 5 );
		else			
			--ヒットパーツを消す --EN:--Erase hit parts
			proxy:SetColiEnable( 1310, false );
			if	proxy:IsCompleteEvent( 555 ) == false then
				proxy:EndAnimation( 1254, 2 );
				proxy:EndAnimation( 1255, 1 );
			else
				proxy:EndAnimation( 1254, 1 );
				proxy:EndAnimation( 1255, 2 );
			end
		end
		
	proxy:RepeatMessage_end();
	
	

--[[
	--■徘徊デーモン用 (フラグは仮、指定があれば変える) --EN:--■For wandering daemon (flag is tentative, change if specified)
	if proxy:IsCompleteEvent( 20 ) == true then
		LuaFunc_VisibleTheWanderingDemon  (proxy, param, demon_id_list_m04_01_00_00);
	else
		LuaFunc_InvisibleTheWanderingDemon(proxy, param, demon_id_list_m04_01_00_00);
	end
]]
	
	--■ボス関連の初期化処理 --EN:--■ Boss-related initialization processing
	if proxy:IsCompleteEvent( 5251 ) ==true then
		
		--▽ボス死んでいるとき --EN:--▽When the boss is dead
		--双子ボスいなくなる --EN:--Twin boss disappears
		InvalidBackRead( proxy , 807 );
		InvalidBackRead( proxy , 817 );
		
		--魔法壁消える --EN:--Magic wall disappears
		proxy:SetColiEnable( 1998 , false );
		proxy:SetColiEnable( 1994 , false );
	
		proxy:SetDrawEnable( 1998 , false );
		proxy:SetDrawEnable( 1994 , false );

		--魔法壁の SFX OFF --EN:--Magic Wall SFX OFF
		proxy:InvalidSfx( 1986 , false );
		proxy:InvalidSfx( 1990 , false );

		--ホストプレイヤーのみアイテム入手イベントに使用 --EN:--Used for item acquisition event only for host players
		local possible_chr_type = ATTR_HOST + ATTR_LIVE + ATTR_GREY;

		--宝死体(ソウル?)有効化 --EN:--Treasure corpse (soul?) activation
		proxy:SetDrawEnable( 1981 , true );
		proxy:SetColiEnable( 1981 , true );
		--宝死体(ソウル?)2有効化 --EN:--Treasure corpse (soul?) 2 enabled
		proxy:SetDrawEnable( 1976 , true );
		proxy:SetColiEnable( 1976 , true );
		
		--▼(ソウル)アイテム取得用イベント監視追加▼ --EN:--▼ (Soul) Added event monitoring for item acquisition▼
		if proxy:IsCompleteEvent( 5261 ) == false then
			proxy:ValidSfx( 2231 );--SFX 有効化 --EN:--SFX enable
			proxy:ValidSfx( 2230 );--SFX 有効化 --EN:--SFX enable
			proxy:TreasureDispModeChange2( 1981 , true ,KANAME_SFX);--光らせる --EN:-- let it shine
			proxy:OnDistanceActionAttribute( 5261 , 10000 , 1981 , "OnEvent_5261" , WarpGimmickDist_A , 10010180 , 0 , 180 , possible_chr_type, once );
		else
			--▼要石でワープ用の監視を追加▼ --EN:--▼ Added surveillance for warp with keystone ▼
			SingleReset(proxy,5262);
			--proxy:InvalidSfx( 2231, false );--SFX 無効化 --EN:--Disable SFX
			proxy:InvalidSfx( 2230, false );--SFX 無効化 --EN:--Disable SFX
			proxy:TreasureDispModeChange2( 1981 , true ,KANAME_SFX);--光らせる --EN:-- let it shine
			proxy:OnDistanceActionAttribute( 5262 , 10000 , 1981 , "OnEvent_5262" , WarpGimmickDist_A , HELPID_GO_TO_SEKITYUU , 0 , 180 , ATTR_NOSESSION , everytime );
		end
		
	else
		--▽ボス生きているとき		 --EN:--▽ When the boss is alive
		proxy:EnableLogic( 807 , false );--ロジックOFFで待機 --EN:--Wait with logic OFF
		proxy:EnableLogic( 817 , false );--ロジックOFFで待機		 --EN:--Wait with logic OFF
		
		--宝(ソウル?) --EN:--Treasure (Soul?)
		proxy:SetDrawEnable( 1981 , false );
		proxy:SetColiEnable( 1981 , false );
		--宝(ソウル?)2 --EN:--Treasure (Soul?) 2
		proxy:SetDrawEnable( 1976 , false );
		proxy:SetColiEnable( 1976 , false );

		--SFX 無効化 --EN:--Disable SFX
		proxy:InvalidSfx( 2231 , false );--ソウル用 --EN:--For Seoul
		proxy:InvalidSfx( 2230 , false );--ボスアイテム用		 --EN:--For boss items
	end	
	
	--■535■光の壁■ --EN:-- ■ 535 ■ Wall of Light ■
	if proxy:IsCompleteEvent( 535 ) == false then
		proxy:OnDistanceActionAttribute( 535, 10000, 1300, "OnEvent_535", 1.5, 10010403, 180.0, 90.0, ATTR_HOST + ATTR_LIVE + ATTR_GREY, everytime );
		proxy:LuaCall( 535, 2, "OnEvent_535_delete", once );
	else
		proxy:SetDrawEnable( 1300, false );
		proxy:SetColiEnable( 1300, false );
		proxy:InvalidSfx( 2200, false );
	end
	
	--■536■光の壁■ --EN:-- ■ 536 ■ Wall of Light ■
	if proxy:IsCompleteEvent( 536 ) == false then
		proxy:OnDistanceActionAttribute( 536, 10000, 1301, "OnEvent_536", 1.5, 10010403, 180.0, 90.0, ATTR_HOST + ATTR_LIVE + ATTR_GREY, everytime );
		proxy:LuaCall( 536, 2, "OnEvent_536_delete", once );
	else
		proxy:SetDrawEnable( 1301, false );
		proxy:SetColiEnable( 1301, false );
		proxy:InvalidSfx( 2201, false );
	end
	
	
	
	
--■540■キメラ玉の鎖解放１ポリ劇■ --EN:--■ 540 ■ Chimera ball chain release 1 poly play ■
--■541■キメラ玉の鎖解放２ポリ劇■ --EN:-- ■ 541 ■ Chimera ball chain release 2 poly play ■
	local flag540 = proxy:IsCompleteEvent( 540 );
	local flag541 = proxy:IsCompleteEvent( 541 );
	
	--1本も切れていない --EN:--not even one broken
	if flag540 == false and flag541 == false then
		local set_flag_list ={1,0,1,0,1};
		chainInitFunc(proxy,set_flag_list);
	end
	
	--1本目だけ切れている --EN:--Only the first one is broken
	if flag540 == true and flag541 == false then
		local set_flag_list ={0,1,1,0,1};
		chainInitFunc(proxy,set_flag_list);
	end
	
	--2本目だけ切れている --EN:--Only the second one is broken
	if flag540 == false and flag541 == true then
		local set_flag_list ={1,0,0,1,1};
		chainInitFunc(proxy,set_flag_list);
	end
	
	--両方切れている --EN:--both cut
	if flag540 == true and flag541 == true then
		local set_flag_list ={0,0,0,0,0};
		chainInitFunc(proxy,set_flag_list);
	end
	
--■542■キメラ玉落下、破裂ポリ劇■ --EN:-- ■ 542 ■ Chimera ball falling, explosion poly drama ■
	if proxy:IsCompleteEvent( 542 ) == false then
		
		proxy:SetDrawEnable(1201, false);
		proxy:SetColiEnable(1201, false);
		
		--柱オブジェ壊れていない状態(1290:壊れていない、1291:壊れている) --EN:--Pillar object not broken (1290: not broken, 1291: broken)
		proxy:SetDrawEnable( 1291 , false );
		proxy:SetColiEnable( 1291 , false );
		
		--柱オブジェ壊れている状態(1292:壊れていない、1293:壊れている) --EN:--Pillar object broken state (1292: not broken, 1293: broken)
		proxy:SetDrawEnable( 1293 , false );--マップパーツなので表示だけ消す --EN:-- Since it is a map part, only the display is erased

	else
		proxy:SetDrawEnable(1200, false);
		proxy:SetColiEnable(1200, false);
		
		--柱オブジェ壊れている状態(1290:壊れていない、1291:壊れている) --EN:--Broken pillar object (1290: not broken, 1291: broken)
		proxy:SetDrawEnable( 1290 , false );
		proxy:SetColiEnable( 1290 , false );
		
		--柱オブジェ壊れている状態(1292:壊れていない、1293:壊れている) --EN:--Pillar object broken state (1292: not broken, 1293: broken)
		proxy:SetDrawEnable( 1292 , false );--マップパーツなので表示だけ消す --EN:-- Since it is a map part, only the display is erased
	end
	
	--■550■篭エレベータ1■ --EN:-- ■ 550 ■ basket elevator 1 ■
	if proxy:IsCompleteEvent( 551 ) == false then
		--proxy:EndAnimation( 1250, 0 );
	else
		--proxy:EndAnimation( 1251, 0 );
	end
	
	--■600■鉄の板 --EN:-- ■ 600 ■ Iron plate
	SingleReset( proxy, 600 );
	if 	proxy:IsSuccessQWC( 40150 ) == false and
		proxy:IsCompleteEvent(601) == false then
		proxy:SetEventFlag( 600, true );
	end
	
	if proxy:IsCompleteEvent( 600 ) == true then
		print("鉄の板を無効化しました"); --EN:print("Disabled Iron Plate");
		proxy:SetColiEnable( 1210, false );
		proxy:SetDrawEnable( 1210, false );
	end
	
	--■601■鉄の板の先に通過■ --EN:-- ■ 601 ■ Pass beyond the iron plate ■
	if proxy:IsCompleteEvent( 601 ) == false then
		if proxy:IsClient() == false then
			proxy:NotNetMessage_begin();
				proxy:OnRegionJustIn( 601 , 10000 , 2270 ,"OnEvent_601",once);
			proxy:NotNetMessage_end();
		end
	end
	
	
	--■8086■牢城に来たフラグを立てる■ --EN:-- ■ 8086 ■ Raise a flag for coming to the prison ■
		proxy:SetEventFlag(8086, true);
	
--------------------------------▽▽▽QWCイベント関連▽▽▽-------------------------------- --EN:--▽▽▽QWC event related ▽▽▽--------------------------------
--■620■QWCソウルモンスター出現１■ --EN:--■620■QWC Soul Monster Appearance 1■
	if	proxy:IsSuccessQWC(40100) == true then
		print("m04_01 QWCソウルモンスター出現　成立"); --EN:print("m04_01 QWC Soul Monster Appearance Established");
		ValidCharactor( proxy, 221 );
		ValidCharactor( proxy, 222 );
		ValidCharactor( proxy, 223 );
	else
		print("m04_01 QWCソウルモンスター出現　未成立"); --EN:print("m04_01 QWC Soul Monster Appearance Unestablished");
		InvalidCharactor( proxy, 221 );
		InvalidCharactor( proxy, 222 );
		InvalidCharactor( proxy, 223 );
	end

--■鉱石の精霊■------------------------------------------------------------------ --EN:--■Ore Spirit■------------------------------------------- -----------------------
	--■610■鉱石の精霊がいない■ --EN:-- ■ 610 ■ There is no ore spirit ■
	if proxy:IsCompleteEvent( 611 ) == true
	   or proxy:IsSuccessQWC( 40110 ) == false then
		InvalidCharactor( proxy, 220 );
		print("QWC未成立、もしくは死んでいるので鉱石の精霊を無効化します"); --EN:print("QWC has not been established or is dead, so the spirit of the ore will be disabled");
	end
	--■611■鉱石の精霊の死亡監視■ --EN:-- ■ 611 ■ Ore Spirit Death Watch ■
	if proxy:IsCompleteEvent( 611 ) == false then
		proxy:OnCharacterDead( 611, 220, "OnEvent_611", once );
		if proxy:IsClient() == false and proxy:IsCompleteEvent(8020) == false then
			proxy:NotNetMessage_begin();
				proxy:AddCorpseEvent( 8020 , 220 );
				proxy:LuaCall( 8020 , 0 , "OnEvent_8020",once);
			proxy:NotNetMessage_end();
		end
	end
----------------------------------------------------------------------------------
--------------------------------△△△QWCイベント関連△△△-------------------------------- --EN:--△△△QWC event related△△△--------------------------------

	--ムカデここから --EN:--centipede from here
	MukadeRegist(proxy);
	--[[
	if	proxy:IsCompleteEvent( 640 ) == false then
		proxy:OnCharacterTotalRateDamage( 640, 230, -1, 0.5, "OnEvent_640", once );
		proxy:OnCheckEzStateMessage( 640, 230, "OnEvent_640_1", 500 );
		InvalidCharactor( proxy, 240 );
	end
	
	if	proxy:IsCompleteEvent( 640 ) == false then
		proxy:OnCharacterTotalRateDamage( 640, 230, -1, 0.5, "OnEvent_640", once );
		proxy:OnCheckEzStateMessage( 640, 230, "OnEvent_640_1", 500 );
		InvalidCharactor( proxy, 240 );
	end
	
	if	proxy:IsCompleteEvent( 645 ) == false then
		proxy:OnCharacterTotalRateDamage( 640, 235, -1, 0.5, "OnEvent_645", once );
		proxy:OnCheckEzStateMessage( 645, 235, "OnEvent_645_1", 500 );
		InvalidCharactor( proxy, 245 );
	end
	]]
	--ムカデここまで --EN:-- Centipede so far
	
	
	--■580,581,582,583■昇降版制御 --EN:-- ■ 580, 581, 582, 583 ■ Lifting plate control
	--ホストの制御用監視登録 --EN:--Monitor registration for host control
	SingleReset( proxy, 581 );
	SingleReset( proxy, 583 );
	proxy:SetIsAnimPauseOnRemoPlayForEvent(1330,true);
	if	proxy:IsClient() == false then
		proxy:PlayAnimation( 1330, 1 );
		proxy:OnCharacterAnimEndPlus(580, 1330, 1, "OnEvent_580_1", once );
	--クライアントの状態あわせ --EN:--Adjust client status
	else
		if	proxy:IsCompleteEvent(581) == false then
			proxy:EndAnimation(1330, 1 );
		else
			proxy:EndAnimation(1330, 2 );
		end
	end
	--アニメ＆フラグ同期用 --EN:--For animation & flag synchronization
	proxy:LuaCall( 580, 1, "OnEvent_580_1_call", everytime );
	proxy:LuaCall( 580, 2, "OnEvent_580_2_call", everytime );
	
	
	proxy:SetIsAnimPauseOnRemoPlayForEvent(1331,true);
	if	proxy:IsClient() == false then
		proxy:PlayAnimation( 1331, 1 );
		proxy:OnCharacterAnimEndPlus(582, 1331, 1, "OnEvent_582_1", once );
	--クライアントの状態あわせ --EN:--Adjust client status
	else
		if	proxy:IsCompleteEvent(583) == false then
			proxy:EndAnimation(1331, 1 );
		else
			proxy:EndAnimation(1331, 2 );
		end
	end
	--アニメ＆フラグ同期用 --EN:--For animation & flag synchronization
	proxy:LuaCall( 582, 1, "OnEvent_582_1_call", everytime );
	proxy:LuaCall( 582, 2, "OnEvent_582_2_call", everytime );
	
--■590■ガーゴイル特殊待機1■ --EN:-- ■ 590 ■ Gargoyle special standby 1 ■
	SingleReset(proxy,590);
	if proxy:IsCompleteEvent( 590 ) == false then
		proxy:OnRegionJustIn( 590 , 10000 , 2210 , "OnEvent_590", once);
		--特殊待機なのでダメージの監視は必要ない --EN:--Since it is a special standby, there is no need to monitor damage.
	else
		proxy:SetSpStayAndDamageAnimId( 413 ,-1,-1 );
	end
--■591■ガーゴイル特殊待機2■ --EN:-- ■ 591 ■ Gargoyle special standby 2 ■
	SingleReset(proxy,591);
	if proxy:IsCompleteEvent( 591 ) == false then
		proxy:OnRegionJustIn( 591 , 10000 , 2211 , "OnEvent_591", once);
		--特殊待機なのでダメージの監視は必要ない --EN:--Since it is a special standby, there is no need to monitor damage.
	else
		proxy:SetSpStayAndDamageAnimId( 411 , -1, -1);
	end
--■592■ガーゴイル特殊待機3■ --EN:-- ■ 592 ■ Gargoyle special standby 3 ■
	SingleReset(proxy,592);
	if proxy:IsCompleteEvent( 592 ) == false then
		proxy:OnRegionJustIn( 592 , 10000 , 2212 , "OnEvent_592", once );
		--特殊待機なのでダメージの監視は必要ない --EN:--Since it is a special standby, there is no need to monitor damage.
	else
		proxy:SetSpStayAndDamageAnimId( 412 , -1, -1);
	end
	
	
	
	--
--■700■要石の光が消える■ --EN:-- ■ 700 ■ Keystone's light disappears ■
	proxy:OnSessionJustIn( 700 , "OnEvent_700_1" , everytime );
		
--■700■要石の光が復活する■ --EN:-- ■ 700 ■ The keystone's light is revived ■
	proxy:OnSessionJustOut( 700 , "OnEvent_700_2" , everytime );

--[[
--■597■もやSFX領域に進入■ --EN:-- ■ 597 ■ Entering the Moya SFX area ■
	proxy:OnRegionJustIn( 597 , 10000 , 2220 , "OnEvent_597",everytime);
	
--■598■もやSFX領域からでた■ --EN:--■ 598■ came out of the haze SFX area■
	proxy:OnRegionJustOut( 598 , 10000 , 2220 , "OnEvent_598",everytime);
]]
	--■999999■フレーム遅れの初期化処理イベントを発行■ --EN:-- ■ 999999 ■ Generate a frame delay initialization processing event ■
	proxy:NotNetMessage_begin();
		--▼0.2秒後▼-- --EN:--▼After 0.2 seconds▼--
		proxy:OnKeyTime2( 999991, "Second_Initialize_m04_01_00_00", 0.2, 0, 0, once );	
	proxy:NotNetMessage_end();	
	
	print("Initialize_m04_01_00_00 end");
end


--------------------------------------------------------------------------------------
--Initializeから呼ばれる、1フレーム遅れの初期化処理■999999 --EN:--Initialization with a delay of 1 frame, called from Initialize ■999999
--------------------------------------------------------------------------------------
--■999999■一部、Initでは処理できないので、残しておく --EN:-- ■ 999999 ■ Some parts cannot be processed by Init, so leave them
function Second_Initialize_m04_01_00_00(proxy, param)
	print("Second_Initialize_m04_01_00_00 begin");

--------------------------------▽▽▽QWCイベント関連▽▽▽-------------------------------- --EN:--▽▽▽QWC event related ▽▽▽--------------------------------
--------------------------------△△△QWCイベント関連△△△-------------------------------- --EN:--△△△QWC event related△△△--------------------------------

--イベントのタイミングを意図的にずらす --EN:--Intentionally staggering the timing of events
	proxy:NotNetMessage_begin();
	--■597■もやSFX領域に進入■ --EN:-- ■ 597 ■ Entering the Moya SFX area ■
		proxy:OnRegionJustIn( 597 , 10000 , 2220 , "OnEvent_597",everytime);
		
	--■598■もやSFX領域からでた■ --EN:--■ 598■ came out of the haze SFX area■
		proxy:OnRegionJustOut( 598 , 10000 , 2220 , "OnEvent_598",everytime);	
	proxy:NotNetMessage_end();
	print("Second_Initialize_m04_01_00_00 end");
end


function chainInitFunc(proxy,set_flag_list)
	local evid_list = {1280, 1281, 1282, 1283, 1284};
	local list_num = table.getn(set_flag_list);
	for index = 1, list_num, 1 do
		proxy:SetDrawEnable( evid_list[index], set_flag_list[index] );
		proxy:SetColiEnable( evid_list[index], set_flag_list[index] );
	end
end


--イベントID1982がなくてTeachManでエラーをはきだすのでコメントアウト --EN:--Comment out because there is no event ID 1982 and TeachMan throws an error
--[[------------------------------------------------------------------------------------
--■512■石柱にワープ■ --EN:-- ■ 512 ■ Warp to the stone pillar ■
--------------------------------------------------------------------------------------
--■512■石柱にワープ■ --EN:-- ■ 512 ■ Warp to the stone pillar ■
function OnEvent_512(proxy,param)	
	print("OnEvent_512 begin");
	
	--完全回復要求 --EN:-- full recovery request
	proxy:RequestFullRecover();
	proxy:WarpNextStage( 1, 0, 0, 0, 1008 );
	
	print("OnEvent_512 end");
end
]]

--[[------------------------------------------------------------------------------------
--徘徊デーモンの登場■?? --EN:-- Appearance of the Wandering Demon ??
--------------------------------------------------------------------------------------]]

--▼グローバルの死亡監視から呼ばれる(ソロ) --EN:--▼ Called from global death watch (solo)
function PlayerDeath_m04_01_00_00(proxy, param)
	print("PlayerDeath_m04_01_00_00");
	
--	LuaFunc_VisibleTheWanderingDemon(proxy, param, demon_id_list_m04_01_00_00);
--	proxy:SetEventFlag( 20 , 1 );--フラグは仮、指定があれば変える。 --EN:The -- flag is tentative, and will be changed if specified.
	
	print("PlayerDeath_m04_01_00_00");
end

--▼グローバルの血文字復活から呼ばれる(ソロ) --EN:--▼Called from global blood letter revival (solo)
function PlayerRevive_m04_01_00_00(proxy,param)
	print("PlayerRevive_m04_01_00_00");
	
--	LuaFunc_InvisibleTheWanderingDemon(proxy, param, demon_id_list_m04_01_00_00);
--	proxy:SetEventFlag( 20 , 0 );--フラグは仮、指定があれば変える。 --EN:The -- flag is tentative, and will be changed if specified.
	
	print("PlayerRevive_m04_01_00_00");
end



















--[[------------------------------------------------------------------------------------
--ボス部屋の中に入る■523 --EN:--Enter the boss room ■523
--------------------------------------------------------------------------------------]]
--■イベントがループなので、全部リピートにする↓ --EN:--■ Since the event is a loop, repeat all ↓

--■523■中ボス部屋への扉が開く■ --EN:-- ■ 523 ■ The door to the mid-boss room opens ■
function OnEvent_523(proxy,param)
	print("OnEvent_523 begin");

	if proxy:IsCompleteEvent( SYSTEM_ID_IGNORE ) == true then
		print("OnEvent_523 end");
		return;
	end	
	
	--クライアントへ、ボス部屋阻止失敗を通知 --EN:--Notify client of failure to block boss room
	if proxy:IsClient() == false then
		proxy:LuaCallStart( 4068 , 1 );	
	end
	
	proxy:LuaCallStart( 524 , 1 );--旋回アニメの同期再生 --EN:-- Synchronous playback of turning animation
	--proxy:SetEventFlag( SYSTEM_ID_IGNORE , true );--多重発動防止用フラグON --EN:--Multiple activation prevention flag ON
	--多重起動システムIDをタイムアウトを設定してONにする --EN:--Turn on multiple activation system ID by setting timeout
	proxy:SetSystemIgnore( SYSTEM_ID_IGNORE , IGNORE_TIME );
	
	--プロファイルセーブ要求 --EN:--profile save request
	proxy:SaveRequest_Profile();
	
	print("OnEvent_523 end");
end


--旋回アニメの同期再生(IDが別) --EN:-- Synchronized playback of turning animation (ID is different)
function OnEvent_524_1(proxy,param)
	print("OnEvent_524_1 begin");

	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		if param:IsNetMessage() == true then
			--旋回アニメ再生を行い、その終了時にOnEvent_524_2を発行する --EN:--Play the turning animation and issue OnEvent_524_2 at the end
			proxy:TurnCharactor( 10001 + param:GetPlayID(), 2890 );
		else
			proxy:LockSession();--ルームをロックします！ --EN:--lock the room!
			--旋回アニメ再生を行い、その終了時にOnEvent_524_2を発行する --EN:--Play the turning animation and issue OnEvent_524_2 at the end
			proxy:OnTurnCharactorEnd( 524, 10000, 2890, "OnEvent_524_2", once );
		end
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	
	print("OnEvent_524_1 end");
end

--旋回アニメの同期再生終了後 --EN:--After synchronous playback of turning animation ends
function OnEvent_524_2(proxy,param)
	print("OnEvent_524_2 begin");
	
	--同期用歩きアニメ再生 --EN:--Play walking animation for synchronization
	proxy:LuaCallStart( 4012, 1 );
	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		proxy:OnChrAnimEnd( 524, 10000, ANIMEID_WALK, "OnEvent_524_3", once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();

	print("OnEvent_524_2 end");
end

--歩きアニメの同期再生終了後 --EN:--After the synchronized playback of the walking animation ends
function OnEvent_524_3(proxy,param)
	print("OnEvent_524_3 begin");

	--最初の人がボス部屋の中に入り終わっていたら、既に配信されているはずなので、もうおくらないハンドラ --EN:--If the first person has already entered the boss room, it should have already been delivered, so no more handlers
	if proxy:IsCompleteEvent( 523 ) == false then
		proxy:LuaCallStart( 524 , 5 );--2回目以降にボス部屋に入るためのイベント配信用 --EN:--For event delivery to enter the boss room after the second time
		proxy:LuaCallStart( 4045 , 1 );	--クライアントへ、ボス部屋に入れるようになったことを通知 --EN:--Notify clients that they can now enter the boss room
		proxy:LuaCallStart( 524 , 6 );--フラグセット(同期用) --EN:--flag set (for synchronization)
		Lua_MultiDoping(proxy,807);--マルチプレイドーピング --EN:-- Multiplayer Doping
		Lua_MultiDoping(proxy,817);--マルチプレイドーピング --EN:-- Multiplayer Doping
	end
	
	proxy:SetEventFlag( SYSTEM_ID_IGNORE, false );

	print("OnEvent_524_3 end");
end


--■523 2回目以降にボス部屋に入るためのイベント配信用 --EN:-- 523 For event delivery to enter the boss room after the second time
function OnEvent_523_GO_TO_IN(proxy, param)
	print("OnEvent_523_GO_TO_IN begin");
		
	proxy:NotNetMessage_begin();
		--▼524▼扉が開いているときに中に入るためのイベントを追加▼--ハンドラは OnEvent_523 --EN:--▼524▼Add an event to enter when the door is open▼--The handler is OnEvent_523
		proxy:OnPlayerActionInRegion( 524, 2894, "OnEvent_523", HELPID_GO_TO_IN, everytime );--
		
		proxy:OnKeyTime2( 524,"StandBy_Kimera",0.5,0,0,once);
	proxy:NotNetMessage_end();	
	
	print("OnEvent_523_GO_TO_IN end");
end


--■523 フラグセット(同期用) --EN:-- 523 flag set (for synchronization)
function OnEvent_523_flag_set(proxy, param)
	print("OnEvent_523_flag_set begin");
		
	proxy:SetEventFlag( 523 , 1 );
	proxy:DeleteEvent( 523 );

	print("OnEvent_523_flag_set end");
end

--[[------------------------------------------------------------------------------------
--■525■ボス戦闘開始■ --EN:-- ■ 525 ■ Boss battle begins ■
--------------------------------------------------------------------------------------]]
--■525■ボス戦闘開始■ --EN:-- ■ 525 ■ Boss battle begins ■
function OnEvent_525(proxy,param)
	print("OnEvent_525 begin");
	
	--ボス戦用BGM再生開始 --EN:--Start playing BGM for boss battle
	proxy:PlayPointSE( 2240, SOUND_TYPE_M, 40100000, 1 );
	
	--ボスロジックON --EN:--Boss logic ON
	proxy:EnableLogic( 807 , true );
	proxy:EnableLogic( 817 , true );
	
	--プレイヤーが扉の中に完全にはいったタイミングで、ボスの思考をリセット --EN:--Reset the boss' thoughts when the player is completely inside the door
	--場所が悪いとプレイヤーを見つけれないため(攻撃してこない) --EN:--Because you can't find the player if the location is bad (they won't attack)
	proxy:ResetThink( 807 );
	proxy:ResetThink( 817 );
	
	m04_01_BossInit(proxy,param);
	
	--ボスゲージセット --EN:--Boss gauge set
	proxy:SetBossGauge(807,0,3040);
	
	print("OnEvent_525 end");
end




--[[------------------------------------------------------------------------------------
--■5251■ボス死亡■ --EN:-- ■ 5251 ■ Boss death ■
--------------------------------------------------------------------------------------]]
--■5251■ボス死亡■ --EN:-- ■ 5251 ■ Boss death ■
function OnEvent_5251(proxy,param)
	print("OnEvent_5251 begin");
	
	local acid = param:GetParam1();
	proxy:SetEventFlag( acid, true );
	
	--2体のうち、片方でも生きていればやり直し --EN:--If even one of the two is alive, start over
	if	proxy:IsCompleteEvent( 5250 ) == false or
		proxy:IsCompleteEvent( 5253 ) == false then
		print("OnEvent_5251 return end");
		return;
	end
	
	
	proxy:NotNetMessage_begin();
		--1秒後に崩れる壁発動イベントを発行-- --EN:-- Issue a wall trigger event that collapses after 1 second --
		proxy:OnKeyTime2(5251,"OnEvent_5251_1", 1,0,0,once);
		--マルチ解散監視 --EN:--Multi-Dismissal Monitoring
		proxy:OnRegistFunc( 5251 , "Check_5251_PT","OnEvent_5251_PT",0,once);
	proxy:NotNetMessage_end();	

	proxy:StopPointSE( 1 );
	
	--ブロッククリア処理へ --EN:-- to block clear processing
	proxy:CustomLuaCallStart( 4050, 807 );
	--トカゲイベントリセット --EN:-- lizard event reset
	ResetTokage(proxy);
	
	m04_01_BossDead(proxy,param);
	
	print("OnEvent_5251 end");
end


function OnEvent_5251_1(proxy, param)
	print("OnEvent_5251_1 begin");
	
	proxy:SetEventFlag( 5251, true );
	
	--ボスを倒した数を更新(数によってフラグを立てる) --EN:--update number of bosses killed (flag by number)
	GetBossFlagCount( proxy, param );
	
	--ボス戦用のBGM停止 --EN:--BGM stop for boss battles
	--proxy:StopPointSE( 0 );

--アイテム入手関連------- --EN:--Item Acquisition Related-------
	
	--ホストプレイヤーのみアイテム入手イベントに使用 --EN:--Used for item acquisition event only for host players
	local possible_chr_type = ATTR_HOST + ATTR_LIVE + ATTR_GREY;

	--宝死体(ソウル?)有効化 --EN:--Treasure corpse (soul?) activation
	proxy:SetDrawEnable( 1981 , true );
	proxy:SetColiEnable( 1981 , true );
	--宝死体(ソウル?)2有効化 --EN:--Treasure corpse (soul?) 2 enabled
	proxy:SetDrawEnable( 1976 , true );
	proxy:SetColiEnable( 1976 , true );
	
	--▼(ソウル)アイテム取得用イベント監視追加▼ --EN:--▼ (Soul) Added event monitoring for item acquisition▼
	if proxy:IsCompleteEvent( 5261 ) == false then
		proxy:ValidSfx( 2231 );--SFX 有効化 --EN:--SFX enable
		proxy:ValidSfx( 2230 );--SFX 有効化 --EN:--SFX enable
		proxy:TreasureDispModeChange2( 1981 , true ,KANAME_SFX);--光らせる --EN:-- let it shine
		proxy:OnDistanceActionAttribute( 5261 , 10000 , 1981 , "OnEvent_5261" , WarpGimmickDist_A , 10010180 , 0 , 180 , possible_chr_type, once );
	end
	
------------------------	
	--▼トロフィー取得判定▼ --EN:--▼Trophy Acquisition Judgment▼
	Lua_RequestUnlockTrophy(proxy, 33);	

	print("OnEvent_5251_1 end");
end

--マルチ解散監視 --EN:--Multi-Dismissal Monitoring
function Check_5251_PT(proxy)
	if proxy:IsInParty() == false then
		return true;
	end
	return false;
end

--マルチじゃない --EN:--not multiplayer
function OnEvent_5251_PT(proxy,param)
	print("OnEvent_5251_PT beign");
	
	--魔法壁消える --EN:--Magic wall disappears
	proxy:SetColiEnable( 1998 , false );
	proxy:SetColiEnable( 1994 , false );

	proxy:SetDrawEnable( 1998 , false );
	proxy:SetDrawEnable( 1994 , false );

	--光の壁Sfxを消す --EN:--Turn off the wall of light Sfx
	proxy:InvalidSfx( 1986, true );
	proxy:InvalidSfx( 1990, true );
	
	--中ボス部屋前の移動処理イベントを削除 --EN:--Delete the movement processing event in front of the mid-boss room
	proxy:DeleteEvent( 523 );--一人目が入るとき用 --EN:--For when the first person enters
	proxy:DeleteEvent( 524 );--二人目以降が入るとき用 --EN:--For when the second and subsequent people enter
	print("OnEvent_5251_PT end");
end
--------------------------------------------------------------------------------------
--■5262■石柱にワープ■ --EN:-- ■ 5262 ■ Warp to the stone pillar ■
--------------------------------------------------------------------------------------
function OnEvent_5262(proxy,param)	
	print("OnEvent_5262 begin");
	
	proxy:RepeatMessage_begin();
		--▼70_1▼選択メニューの監視▼ --EN:--▼70_1▼Select menu monitoring▼
		proxy:OnSelectMenu(5262, "OnEvent_5262_1", 10010710, 0, 2, 1981, 2, once);			
	proxy:RepeatMessage_end();
	
	print("OnEvent_5262 end");
end

--▲5262_1▲選択メニューの監視▲ --EN:--▲5262_1▲Monitor selection menu▲
function OnEvent_5262_1(proxy,param)	
	print("OnEvent_5262_1 begin");
	
	if proxy:IsSession() == false then
		
		if param:IsNetMessage() == true then
			proxy:PlayAnimation(10001+param:GetPlayID(),8283);
			print("OnEvent_5262_1 end");
			return;
		end
			
		proxy:PlayAnimation(10000,8283);
		proxy:NoAnimeTurnCharactor( 10000 , 1981 ,TURNSKIP_ANGLE);
		proxy:NotNetMessage_begin();
		proxy:RepeatMessage_begin();
			proxy:OnChrAnimEnd( 5262 , 10000 , 8283 , "OnEvent_5262_2",once);
		proxy:RepeatMessage_end();
		proxy:NotNetMessage_end();
		
		proxy:SetEventFlag(5262,true);
		
	else
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010720, 0, 6, 1983, GEN_DIALOG_DIST, once );
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
	end
	
	print("OnEvent_5262_1 end");
end

--■5262_2■石柱にワープ■ --EN:--■ 5262_2 ■ Warp to the stone pillar ■
function OnEvent_5262_2(proxy,param)	
	print("OnEvent_5262_2 begin");
	
	proxy:PlayAnimation( 10000 , 8284 );--自世界に帰るアニメを再生 --EN:--Play animation to return to your own world
	--石柱へ戻ってきた判定のフラグを立てる --EN:--Flag the judgment of returning to the stone pillar
	proxy:SetEventFlag(8083, true);
	
	--完全回復要求 --EN:-- full recovery request
	proxy:RequestFullRecover();
	--古砦要石に戻る --EN:--Return to Old Fort Keystone
	proxy:WarpNextStage( 1, 0, 0, 0, 1008);	
	
	print("OnEvent_5262_2 end");
end

--------------------------------------------------------------------------------------
--■5261■ソウル入手■ --EN:-- ■ 5261 ■ Get Soul ■
--------------------------------------------------------------------------------------
function OnEvent_5261(proxy, param)
	print("OnEvent_5261 begin");
	
	--プレイヤーの同期アニメーション(true:パーティープレイヤーがアニメーションした) --EN:--Player synchronous animation (true: party player animated)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_PICK ) == true then--新しいアニメ  --EN:-- new anime
		print("OnEvent_5261 end");
		return true;
	end
	
	proxy:NotNetMessage_begin();
		--0.0秒後にアイテム取得イベントを発行 --EN:-- Issue an item acquisition event after 0.0 seconds
		proxy:OnKeyTime2( 5261, "OnEvent_5261_1", 0.0, 0, 0, once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_5261 end");
end


--■5261_1■アイテム取得■ --EN:-- ■ 5261_1 ■ item acquisition ■
function OnEvent_5261_1(proxy, param)
	print("OnEvent_5261_1 begin");

	--アイテム取得関数--パラメータ10551参照 --EN:--item retrieval function--see parameter 10551
	proxy:GetRateItem(10551);	
	--アイテム取得関数--パラメータ10574参照 --EN:--item retrieval function--see parameter 10574
	proxy:GetRateItem(10574);	
	--アイテム取得関数--パラメータ10575参照 --EN:--item retrieval function--see parameter 10575
	proxy:GetRateItem(10575);	
	--アイテム取得関数--パラメータ10576参照 --EN:--item retrieval function--see parameter 10576
	proxy:GetRateItem(10576);	
	--アイテム取得関数--パラメータ10577参照 --EN:--item retrieval function--see parameter 10577
	proxy:GetRateItem(10577);	
	
	--アイテムを取得済み --EN:--item already acquired
	proxy:SetEventFlag( 5261, 1 );
	
	--SFXが消える --EN:--SFX disappear
	--proxy:InvalidSfx( 2231 , true );
	proxy:InvalidSfx( 2230 , true );
		
	--▼要石でワープ用の監視を追加▼ --EN:--▼ Added surveillance for warp with keystone ▼
	proxy:OnDistanceActionAttribute( 5262 , 10000 , 1981 , "OnEvent_5262" , WarpGimmickDist_A , HELPID_GO_TO_SEKITYUU , 0 , 180 , ATTR_NOSESSION , everytime );

	print("OnEvent_5261_1 end");
end

--[[------------------------------------------------------------------------------------
--■535■光の壁■ --EN:-- ■ 535 ■ Wall of Light ■
--------------------------------------------------------------------------------------]]
--■535■光の壁■ --EN:-- ■ 535 ■ Wall of Light ■
function OnEvent_535(proxy,param)
	print("OnEvent_535 begin");
	
	--プレイヤーの同期アニメーション(true:パーティープレイヤーがアニメーションした) --EN:--Player synchronous animation (true: party player animated)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_WALK ) == true then
		proxy:SetEventFlag( 535 , true );
		return;
	end
	--ダミポリへワープ --EN:--Warp to Damipoli
	proxy:WarpDmy( 10000, 1300, 191 );
	
	proxy:NotNetMessage_begin();
		--▼535_1▼歩きアニメ終了▼ --EN:--▼535_1▼End of walking animation▼
		--proxy:OnChrAnimEnd( 535, 10000, ANIMEID_WALK, "OnEvent_535_1" , once );
		proxy:LuaCallStart( 535, 2 );
	proxy:NotNetMessage_end();
	proxy:SetEventFlag( 535 , true );
	
	--プロファイルセーブ要求 --EN:--profile save request
	proxy:SaveRequest_Profile();
	
	print("OnEvent_535 end");
end

function OnEvent_535_1(proxy,param)
	print("OnEvent_535_1 begin");
	
	proxy:LuaCallStart( 535, 2 );
	
	print("OnEvent_535_1 end");
end

function OnEvent_535_delete(proxy,param)
	print("OnEvent_535_delete begin");
	
	proxy:SetDrawEnable( 1300, false );--描画OFF --EN:--Drawing OFF
	proxy:SetColiEnable( 1300, false );--当たりOFF	 --EN:--Hit OFF
	proxy:SetObjDeactivate( 1300 , true );--デアクティブ	 --EN:--deactivate
	proxy:InvalidSfx( 2200, true );
	proxy:DeleteEvent( 535 );
	
	print("OnEvent_535_delete end");
end



--[[------------------------------------------------------------------------------------
--■536■光の壁■ --EN:-- ■ 536 ■ Wall of Light ■
--------------------------------------------------------------------------------------]]
--■536■光の壁■ --EN:-- ■ 536 ■ Wall of Light ■
function OnEvent_536(proxy,param)
	print("OnEvent_536 begin");
	
	--プレイヤーの同期アニメーション(true:パーティープレイヤーがアニメーションした) --EN:--Player synchronous animation (true: party player animated)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_WALK ) == true then
		proxy:SetEventFlag( 536 , true );
		return;
	end
	--ダミポリへワープ --EN:--Warp to Damipoli
	proxy:WarpDmy( 10000, 1301, 191 );
	
	proxy:NotNetMessage_begin();
		--▼536_1▼歩きアニメ終了▼ --EN:--▼536_1▼End of walking animation▼
		--proxy:OnChrAnimEnd( 536, 10000, ANIMEID_WALK, "OnEvent_536_1" , once );
		proxy:LuaCallStart( 536, 2 );
	proxy:NotNetMessage_end();
	proxy:SetEventFlag( 536 , true );
	
	--プロファイルセーブ要求 --EN:--profile save request
	proxy:SaveRequest_Profile();
	
	print("OnEvent_536 end");
end

function OnEvent_536_1(proxy,param)
	print("OnEvent_536_1 begin");
	
	proxy:LuaCallStart( 536, 2 );
	
	print("OnEvent_536_1 end");
end

function OnEvent_536_delete(proxy,param)
	print("OnEvent_536_delete begin");
	
	proxy:SetDrawEnable( 1301, false );--描画OFF --EN:--Drawing OFF
	proxy:SetColiEnable( 1301, false );--当たりOFF --EN:--Hit OFF
	proxy:SetObjDeactivate( 1301 , true );--デアクティブ --EN:--deactivate
	proxy:InvalidSfx( 2201, true );
	proxy:DeleteEvent( 536 );
	
	print("OnEvent_536_delete end");
end




--[[------------------------------------------------------------------------------------
--■540■キメラ玉の鎖解放１ポリ劇■ --EN:--■ 540 ■ Chimera ball chain release 1 poly play ■
--------------------------------------------------------------------------------------]]
--■540■キメラ玉の鎖解放１ポリ劇■ --EN:--■ 540 ■ Chimera ball chain release 1 poly play ■
function Condition_540(proxy,param)
	local target_list 	= {200, 201, 202, 203};
	local targetNum		= table.getn( target_list );
	local isAlive		= false;
	
	for i = 1, targetNum, 1 do
		if proxy:IsAlive( target_list[i] ) == true then
			isAlive = true;
		end
	end
	
	if isAlive == false then
		return true;
	end
	return false;
end

function OnEvent_540(proxy,param)
	if proxy:IsClient() == false then
		print("OnEvent_540 begin");
		proxy:NotNetMessage_begin();
			proxy:OnKeyTime2( 540 , "OnEvent_540_1",REMO_WAIT,0,0,once);
		proxy:NotNetMessage_end();
		print("OnEvent_540 end");
	end
end

function OnEvent_540_1(proxy,param)
	print("OnEvent_540_1 begin");
	proxy:LuaCallStart( 540,1 );	
	print("OnEvent_540_1 end");
end

function OnEvent_540_2(proxy,param)
	print("OnEvent_540_2 begin");
	if	proxy:IsCompleteEvent( 541 ) == false then
		proxy:RequestRemo(40101, REMO_FLAG, 540, 1 );
	else
		OnEvent_542(proxy,param);
	end	
	proxy:SetEventFlag( 540, true );
	print("OnEvent_540_2 end");
end

--■ポリ劇再生開始(フェード終了) --EN:--■ Start of polyplay playback (end of fade)
function OnEvent_540_RemoStart(proxy,param)
print("OnEvent_540_RemoStart begin");
	--緑色の炎Sfx消し --EN:-- Green flame Sfx extinguished
	proxy:InvalidSfx( 1285, false );
print("OnEvent_540_RemoStart end");
end


--■ポリ劇再生終了(フェード終了) --EN:-- End of polyplay playback (end of fade)
function OnEvent_540_RemoFinish(proxy,param)
print("OnEvent_540_RemoFinish begin");
	proxy:SetDrawEnable( 1280, false );
	proxy:SetColiEnable( 1280, false );
	proxy:SetDrawEnable( 1281, true );
	proxy:SetColiEnable( 1281, true );	
	--ポイントライト削除 --EN:--Delete point light
	proxy:InvalidPointLight( 1298 );
print("OnEvent_540_RemoFinish end");
end


--[[------------------------------------------------------------------------------------
--■541■キメラ玉の鎖解放２ポリ劇■ --EN:-- ■ 541 ■ Chimera ball chain release 2 poly play ■
--------------------------------------------------------------------------------------]]
--■541■キメラ玉の鎖解放２ポリ劇■ --EN:-- ■ 541 ■ Chimera ball chain release 2 poly play ■
function Condition_541(proxy,param)
	local target_list 	= {210, 211, 212, 213};
	local targetNum		= table.getn( target_list );
	local isAlive		= false;
	
	for i = 1, targetNum, 1 do
		if proxy:IsAlive( target_list[i] ) == true then
			isAlive = true;
		end
	end
	
	if isAlive == false then
		return true;
	end
	return false;
end

function OnEvent_541(proxy,param)
	if proxy:IsClient() == false then
		print("OnEvent_541 begin");
		proxy:NotNetMessage_begin();
			proxy:OnKeyTime2( 541 , "OnEvent_541_1",REMO_WAIT,0,0,once);
		proxy:NotNetMessage_end();
		print("OnEvent_541 end");
	end
end

function OnEvent_541_1(proxy,param)
	print("OnEvent_541_1 begin");
	proxy:LuaCallStart( 541 , 1 );
	print("OnEvent_541_1 end");
end

function OnEvent_541_2(proxy,param)
	print("OnEvent_541_2 begin");
	if	proxy:IsCompleteEvent( 540 ) == false then
		proxy:RequestRemo(40101, REMO_FLAG, 541, 1 );
	else
		OnEvent_542(proxy,param);
	end
	proxy:SetEventFlag( 541, true );
	print("OnEvent_541_2 end");
end

--■ポリ劇再生開始(フェード終了) --EN:--■ Start of polyplay playback (end of fade)
function OnEvent_541_RemoStart(proxy,param)
print("OnEvent_541_RemoStart begin");
	--緑色の炎Sfx消し --EN:-- Green flame Sfx extinguished
	proxy:InvalidSfx( 1286, false );
	proxy:InvalidSfx( 1285, false );
print("OnEvent_541_RemoStart end");
end

--■ポリ劇再生終了(フェード終了) --EN:-- End of polyplay playback (end of fade)
function OnEvent_541_RemoFinish(proxy,param)
print("OnEvent_541_RemoFinish begin");
	proxy:SetDrawEnable( 1282, false );
	proxy:SetColiEnable( 1282, false );
	proxy:SetDrawEnable( 1283, true );
	proxy:SetColiEnable( 1283, true );
	
	--こっちはもう片方の --EN:--this is the other
	proxy:ValidSfx( 1285 );
	
	--ポイントライト削除 --EN:--Delete point light
	proxy:InvalidPointLight( 1298 );
print("OnEvent_541_RemoFinish end");
end


--[[------------------------------------------------------------------------------------
--■542■キメラ玉落下、破裂ポリ劇■ --EN:-- ■ 542 ■ Chimera ball falling, explosion poly drama ■
--------------------------------------------------------------------------------------]]
--■542■キメラ玉落下、破裂ポリ劇■ --EN:-- ■ 542 ■ Chimera ball falling, explosion poly drama ■
function OnEvent_542(proxy,param)
	print("OnEvent_542 begin");
	
	proxy:RequestRemo(40100, REMO_FLAG, 542, 1 );
	proxy:SetEventFlag( 542, true );

	--鎖を全て無効化 --EN:--disable all chains
	local set_flag_list = {0,0,0,0,0};
	chainInitFunc(proxy,set_flag_list);
	
	print("OnEvent_542 end");
end


--■ポリ劇再生開始(フェード終了) --EN:--■ Start of polyplay playback (end of fade)
function OnEvent_542_RemoStart(proxy,param)
print("OnEvent_542_RemoStart begin");
	proxy:SetDrawEnable(1201, true);
	proxy:SetColiEnable(1201, true);
	
	--緑色の炎Sfx消し --EN:-- Green flame Sfx extinguished
	proxy:InvalidSfx( 1285, false );
	proxy:InvalidSfx( 1286, false );
	proxy:InvalidSfx( 1287, false );
print("OnEvent_542_RemoStart end");
end

--■ポリ劇再生終了(フェード終了) --EN:-- End of polyplay playback (end of fade)
function OnEvent_542_RemoFinish(proxy,param)
print("OnEvent_542_RemoFinish begin");
	--落下前のキメラ球を消して、落下後を表示 --EN:--Erase the chimera ball before falling and display after falling
	proxy:SetDrawEnable(1200, false);
	proxy:SetColiEnable(1200, false);
	
	--柱オブジェを壊れた状態にする --EN:--Make the pillar object broken
	proxy:SetDrawEnable( 1290 , false );--破壊前を無効化 --EN:--disable before destruction
	proxy:SetColiEnable( 1290 , false );

	proxy:SetDrawEnable( 1291 , true );	--破壊後を有効化 --EN:--enable post-destroy
	proxy:SetColiEnable( 1291 , true );
	
	--マップパーツなので表示だけ切り替え --EN:--Since it is a map part, only the display is switched
	proxy:SetDrawEnable( 1292 , false );--破壊前を無効化 --EN:--disable before destruction
	proxy:SetDrawEnable( 1293 , true );--破壊後を有効化 --EN:--enable post-destroy
	
	--柱オブジェ壊れている状態(1315:壊れていない、1316:壊れている) --EN:--Pillar object broken state (1315: not broken, 1316: broken)
	proxy:SetColiEnable( 1315 , false );--破壊前を無効化 --EN:--disable before destruction
	proxy:SetColiEnable( 1316 , true );--破壊後を有効化 --EN:--enable post-destroy
	
	
	--ムカデ無効化 --EN:--Disable Centipede
	ValidCharactor( proxy, 230 );
	ValidCharactor( proxy, 231 );
	ValidCharactor( proxy, 232 );
	ValidCharactor( proxy, 233 );
	ValidCharactor( proxy, 234 );
	ValidCharactor( proxy, 235 );
	ValidCharactor( proxy, 236 );
	ValidCharactor( proxy, 237 );
	
	proxy:SetColiEnable( 1201, false );
	proxy:SetDrawEnable( 1201, false );
	
	proxy:StopPointSE( 4 );
	
	--ポイントライト削除 --EN:--Delete point light
	proxy:InvalidPointLight( 1297 );
	proxy:InvalidPointLight( 1298 );
	proxy:InvalidPointLight( 1299 );
print("OnEvent_542_RemoFinish end");
end

--[[------------------------------------------------------------------------------------
--■550■篭エレベータ1■ --EN:-- ■ 550 ■ basket elevator 1 ■
--------------------------------------------------------------------------------------]]
--■550■篭エレベータ1■ --EN:-- ■ 550 ■ basket elevator 1 ■
function OnEvent_550_1(proxy,param)
	print("OnEvent_550_1 begin");
	
	--アニメ再生中なら終了 --EN:--End if animation is playing
	if proxy:IsCompleteEvent(556) == true then
		return;
	end
	
	--下にあるなら終了？ --EN:--End if below?
	if proxy:IsCompleteEvent(551) == true then
		return;
	end
	
	proxy:SetEventFlag( 556, true );
	--上セットか下セットかは最終で決める --EN:--The upper set or the lower set is decided at the end
	proxy:SetEventFlag( 551, true );
	
	lift_PlayAnimation(proxy, 1250, 1251, 1 );
	
	proxy:NotNetMessage_begin();
	proxy:RepeatMessage_begin();
		proxy:OnObjAnimEnd( 550, 1250, 1, "OnEvent_550_animEnd", once );
	proxy:RepeatMessage_end();
	proxy:NotNetMessage_end();
	print("OnEvent_550_1 end");
end

function OnEvent_550_2(proxy,param)
	print("OnEvent_550_2 begin");
	
	--アニメ再生中なら終了 --EN:--End if animation is playing
	if proxy:IsCompleteEvent(556) == true then
		return;
	end
	
	--上にあるなら終了？ --EN:--End if above?
	if proxy:IsCompleteEvent(551) == false then
		return;
	end

	proxy:SetEventFlag( 556, true );
	--上セットか下セットかは最終で決める --EN:--The upper set or the lower set is decided at the end
	proxy:SetEventFlag( 551, false );
	
	lift_PlayAnimation(proxy, 1250, 1251, 2 );
	
	proxy:NotNetMessage_begin();
	proxy:RepeatMessage_begin();
		proxy:OnObjAnimEnd( 550, 1250, 2, "OnEvent_550_animEnd", once );
	proxy:RepeatMessage_end();
	proxy:NotNetMessage_end();
	print("OnEvent_550_2 end");
end

--アニメ終了監視 --EN:--Anime ending monitoring
function OnEvent_550_animEnd(proxy,param)
	if proxy:IsClient() == false then
		print("OnEvent_550_animEnd begin");
		if proxy:IsCompleteEvent( 551 ) == true then
			proxy:CustomLuaCallStart( 550, 1 );
		else
			proxy:CustomLuaCallStart( 550, 0 );
		end
		print("OnEvent_550_animEnd end");
	end
end

--フラグ同期 --EN:--flag sync
function OnEvent_550_flags(proxy,param)
	print("OnEvent_550_flags begin");
	proxy:SetEventFlag( 556, false );	
--~ 	if param:GetParam2() == 1 then
--~ 		proxy:SetEventFlag( 551, false );
--~ 	else
--~ 		proxy:SetEventFlag( 551, true );
--~ 	end	
	print("OnEvent_550_flags end");
end

function OnEvent_544_In(proxy,param) proxy:SetColiEnable( 10000 , false ); end
function OnEvent_544_Out(proxy,param) proxy:SetColiEnable( 10000 , true ); end
function OnEvent_545_In(proxy,param) proxy:SetColiEnable( 10000 , false ); end
function OnEvent_545_Out(proxy,param) proxy:SetColiEnable( 10000 , true ); end


--[[------------------------------------------------------------------------------------
--■552■篭エレベータ2■ --EN:-- ■ 552 ■ basket elevator 2 ■
--------------------------------------------------------------------------------------]]
--■552■篭エレベータ2■ --EN:-- ■ 552 ■ basket elevator 2 ■
function OnEvent_552_1(proxy,param)
	print("OnEvent_552_1 begin");
	
	--アニメ再生中なら終了 --EN:--End if animation is playing
	if proxy:IsCompleteEvent(557) == true then
		return;
	end
	
	--下なら終了 --EN:--End if below
	if proxy:IsCompleteEvent(553) == true then
		return;
	end
	
	proxy:SetEventFlag( 557, true );
	--上セットか下セットかは最終で決める --EN:--The upper set or the lower set is decided at the end
	proxy:SetEventFlag( 553, true );
	
	lift_PlayAnimation(proxy, 1252, 1253, 1 );
--[[	
	--本人以外はオブジェのアニメ再生のみ --EN:-- Only the animation of the object is played except for the person himself
	if param:IsNetMessage() == true then
		return;
	end
]]	
	proxy:NotNetMessage_begin();
	proxy:RepeatMessage_begin();
		proxy:OnObjAnimEnd( 552, 1252, 1, "OnEvent_552_animEnd", once );
	proxy:RepeatMessage_end();
	proxy:NotNetMessage_end();
	print("OnEvent_552_1 end");
end
function OnEvent_552_2(proxy,param)
	print("OnEvent_552_2 begin");
	
	--アニメ再生中なら終了 --EN:--End if animation is playing
	if proxy:IsCompleteEvent(557) == true then
		return;
	end
	--上なら終了 --EN:--End if above
	if proxy:IsCompleteEvent(553) == false then
		return;
	end
	
	proxy:SetEventFlag( 557, true );
	--上セットか下セットは最終で決める --EN:--Upper set or lower set is decided at the end
	proxy:SetEventFlag( 553, false );
	
	lift_PlayAnimation(proxy, 1252, 1253, 2 );
--[[	
	--本人以外はオブジェのアニメ再生のみ --EN:-- Only the animation of the object is played except for the person himself
	if param:IsNetMessage() == true then
		return;
	end
]]
	proxy:NotNetMessage_begin();
	proxy:RepeatMessage_begin();
		proxy:OnObjAnimEnd( 552, 1252, 2, "OnEvent_552_animEnd", once );
	proxy:RepeatMessage_end();
	proxy:NotNetMessage_end();
	print("OnEvent_552_2 end");
end

function OnEvent_552_animEnd(proxy,param)
	if proxy:IsClient() == false then
		print("OnEvent_552_animEnd begin");
		
		if proxy:IsCompleteEvent( 553 ) == true then
			proxy:CustomLuaCallStart( 552, 1 );
		else
			proxy:CustomLuaCallStart( 552, 0 );		
		end

		print("OnEvent_552_animEnd end");
	end
end

--フラグの同期 --EN:--flag synchronization
function OnEvent_552_flags(proxy,param)
	print("OnEvent_552_flags begin");
	proxy:SetEventFlag( 557, false );
	
--~ 	if param:GetParam2() == 1 then
--~ 		proxy:SetEventFlag( 553, false );
--~ 	else
--~ 		proxy:SetEventFlag( 553, true );
--~ 	end
	
	print("OnEvent_552_flags end");
end

function OnEvent_546_In(proxy,param) proxy:SetColiEnable( 10000 , false ); end
function OnEvent_546_Out(proxy,param) proxy:SetColiEnable( 10000 , true ); end
function OnEvent_547_In(proxy,param) proxy:SetColiEnable( 10000 , false ); end
function OnEvent_547_Out(proxy,param) proxy:SetColiEnable( 10000 , true ); end

--[[------------------------------------------------------------------------------------
--■554■篭エレベータ1■ --EN:-- ■ 554 ■ basket elevator 1 ■
--------------------------------------------------------------------------------------]]
--■554■篭エレベータ1■ --EN:-- ■ 554 ■ basket elevator 1 ■
function OnEvent_554_1(proxy,param)
	print("OnEvent_554_1 begin");	
	
	--アニメ再生中なら終了 --EN:--End if animation is playing
	if proxy:IsCompleteEvent(558) == true then
		return;
	end
	
	if proxy:IsCompleteEvent(555) == true then
		return;
	end
	
	proxy:SetEventFlag( 558, true );
	--上セットか下セットかは後で決める --EN:--I will decide later whether it is the upper set or the lower set
	proxy:SetEventFlag( 555, true );
	
	lift_PlayAnimation(proxy, 1254, 1255, 1 );
--[[	
	--本人以外はオブジェのアニメ再生のみ --EN:-- Only the animation of the object is played except for the person himself
	if param:IsNetMessage() == true then
		return;
	end
]]	
	proxy:NotNetMessage_begin();
	proxy:RepeatMessage_begin();
		proxy:OnObjAnimEnd( 554, 1254, 1, "OnEvent_554_animEnd", once );
	proxy:RepeatMessage_end();
	proxy:NotNetMessage_end();
	print("OnEvent_554_1 end");
end

function OnEvent_554_2(proxy,param)
	print("OnEvent_554_2 begin");
	
	--アニメ再生中なら終了 --EN:--End if animation is playing
	if proxy:IsCompleteEvent(558) == true then
		return;
	end
	
	if proxy:IsCompleteEvent(555) == false then
		return;
	end
	
	proxy:SetEventFlag( 558, true );
	--上セットか下セットかは後で決める --EN:--I will decide later whether it is the upper set or the lower set
	proxy:SetEventFlag( 555, false );
	
	lift_PlayAnimation(proxy, 1254, 1255, 2 );
--[[	
	--本人以外はオブジェのアニメ再生のみ --EN:-- Only the animation of the object is played except for the person himself
	if param:IsNetMessage() == true then
		return;
	end
]]	
	proxy:NotNetMessage_begin();
	proxy:RepeatMessage_begin();
		proxy:OnObjAnimEnd( 554, 1254, 2, "OnEvent_554_animEnd", once );
	proxy:RepeatMessage_end();
	proxy:NotNetMessage_end();
	print("OnEvent_554_2 end");
end

function OnEvent_554_animEnd(proxy,param)
	if proxy:IsClient() == false then
		print("OnEvent_554_animEnd begin");		
		
		if proxy:IsCompleteEvent( 555 ) == true then
			proxy:CustomLuaCallStart( 554, 1);
		else
			proxy:CustomLuaCallStart( 554, 0);
		end
		print("OnEvent_554_animEnd end");
	end
end

--フラグ同期 --EN:--flag sync
function OnEvent_554_flags(proxy,param)
	print("OnEvent_554_flags begin");
	proxy:SetEventFlag( 558, false );
--~ 	if param:GetParam2() == 1 then
--~ 		proxy:SetEventFlag( 555, false );
--~ 	else
--~ 		proxy:SetEventFlag( 555, true );
--~ 	end
	print("OnEvent_554_flags end");
end


function OnEvent_548_In(proxy,param) proxy:SetColiEnable( 10000 , false ); end
function OnEvent_548_Out(proxy,param) proxy:SetColiEnable( 10000 , true ); end
function OnEvent_549_In(proxy,param) proxy:SetColiEnable( 10000 , false ); end
function OnEvent_549_Out(proxy,param) proxy:SetColiEnable( 10000 , true ); end

--[[------------------------------------------------------------------------------------
--■篭エレベータ用処理まとめ■ --EN:--■Summary of process for basket elevator■
--------------------------------------------------------------------------------------]]
--[[------------------------------------------------------------------------------------
--■篭エレベータのアニメをセットで指定■ --EN:--Specify the animation of the basket elevator as a set■
--------------------------------------------------------------------------------------]]
function lift_PlayAnimation(proxy,obj1, obj2, set_anime )
	--obj1昇り、obj2下り --EN:--obj1 up, obj2 down
	if set_anime == 1 then
		proxy:PlayAnimation( obj1, 1 );
		proxy:PlayAnimation( obj2, 2 );
	end
	
	--obj1下り、obj2昇り --EN:--obj1 down, obj2 up
	if set_anime == 2 then
		proxy:PlayAnimation( obj1, 2 );
		proxy:PlayAnimation( obj2, 1 );
	end
end





--[[------------------------------------------------------------------------------------
--■560■ユルトを助ける(会話から呼び出し) --EN:-- ■ 560 ■ Help Yurt (call from conversation)
--------------------------------------------------------------------------------------]]
--■560■ユルトを助ける(会話から呼び出し) --EN:-- ■ 560 ■ Help Yurt (call from conversation)
function OnEvent_560(proxy,param)
	if proxy:IsLand( 10000 ) == true then
		print("OnEvent_560 begin");
		
		--ユルトのロジックをONにする --EN:--Turn on yurt logic
		proxy:EnableLogic( 644, true );
		
		--エレベータ開くアニメ --EN:--Elevator opening animation
		proxy:PlayAnimation( 1254, 7);
		
		--ヒットパーツを消す --EN:--Erase hit parts
		proxy:SetColiEnable( 1310, false );

		--ユルト完全無敵解除 --EN:--Unlock Yurt Complete Invincibility
		proxy:EnableInvincible( 644, false );
		
		--フラグをセット --EN:-- set the flag
		proxy:SetEventFlag( 560, true );
		
		--ユルトの状態を「石柱に行く前」に設定 --EN:-- Set yurt state to "Before going to stone pillar"
		SetNpcStateFlag( proxy, param, yuruto_flag_list, YURUTO_STANDBY_M1 );
		
		--ボス撃破数を記憶 --EN:-- Memorize the number of bosses defeated
		GetBossFlagCount(proxy,param);
		proxy:SetBossCount( boss_flagCount );
		
		--プレイヤが開けるアニメ再生 --EN:--Player-openable animation playback
		if	Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_OPEN ) == true then
			return;
		end
		
		proxy:WarpDmy( LOCAL_PLAYER, 1254, 191 );
		
		proxy:SetEventFlag( 602 , true );
		
		print("OnEvent_560 end");
	end
end

--[[------------------------------------------------------------------------------------
--■561■会話でエレベータ移動 --EN:-- ■ 561 ■ Elevator movement with conversation
--------------------------------------------------------------------------------------]]
--■561■会話でエレベータ移動 --EN:-- ■ 561 ■ Elevator movement with conversation
function OnEvent_561(proxy,param)
	print("OnEvent_561 begin");
	
	if	proxy:IsCompleteEvent( 561 ) == true or
		proxy:IsCompleteEvent( 562 ) == true then
		return;
	end
	
	--NPCでアニメ開始を全員に配信 --EN:--Distribute animation start to everyone with NPC
	proxy:LuaCallStart( 561, 2 );
	
	--ヒットパーツを消す --EN:--Erase hit parts
	proxy:SetColiEnable( 1310, false );
	
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 561, "OnEvent_561_1", 12.0, 0, 2, once );
	proxy:NotNetMessage_end();
	
	proxy:SetEventFlag( 561, true );
	print("OnEvent_561 end");
end

function OnEvent_561_1(proxy,param)
	print("OnEvent_561_1 begin");
	
	SetNpcStateFlag( proxy, param, yuruto_flag_list, YURUTO_STANDBY_M1 );
	
	
	InvalidCharactor( proxy, 644 );
	
	--重力OFF --EN:--Gravity off
	proxy:SetDisableGravity( 644, true );
	
	print("OnEvent_561_1 end");
end

function OnEvent_561_call(proxy,param)
	print("OnEvent_561_call begin");
	--アニメ再生中なら終了 --EN:--End if animation is playing
	if proxy:IsCompleteEvent(558) == true then
		return;
	end
	
	if proxy:IsCompleteEvent(555) == true then
		return;
	end
	
	proxy:SetEventFlag( 558, true );
	proxy:SetEventFlag( 555, true );
	
	proxy:PlayAnimation( 1254, 3 );
	proxy:PlayAnimation( 1255, 4 );
	
	--本人以外はオブジェのアニメ再生のみ --EN:-- Only the animation of the object is played except for the person himself
	if param:IsNetMessage() == true then
		return;
	end
	
	proxy:NotNetMessage_begin();
	proxy:RepeatMessage_begin();
		proxy:OnCharacterAnimEnd( 554, 1254, 1, "OnEvent_554_animEnd", once );
	proxy:RepeatMessage_end();
	proxy:NotNetMessage_end();
	
	print("OnEvent_561_call end");
end


--[[------------------------------------------------------------------------------------
--■562■ユルト(敵対：牢城) --EN:-- ■ 562 ■ Yurt (Hostile: Prison Castle)
--------------------------------------------------------------------------------------]]
--■562■ユルト(敵対：牢城) --EN:-- ■ 562 ■ Yurt (Hostile: Prison Castle)
function OnEvent_562(proxy,param)
	print("OnEvent_562 begin");
	proxy:EnableLogic(644, true);
	SetNpcStateFlag( proxy, param, yuruto_flag_list, YURUTO_STATE_ANGRY_M4 );
	proxy:SetTeamType( 644, TEAM_TYPE_AngryFriend );
	
	proxy:SetEventFlag( 562, true );
	print("OnEvent_562 end");
end

--[[------------------------------------------------------------------------------------
--■563■ユルト(死亡) --EN:-- ■ 563 ■ Yurt (Death)
--------------------------------------------------------------------------------------]]
--■563■ユルト(死亡) --EN:-- ■ 563 ■ Yurt (Death)
function OnEvent_563(proxy,param)
	print("OnEvent_563 begin");
	SetNpcStateFlag( proxy, param, yuruto_flag_list, YURUTO_STATE_DEAD );
	
	--NPCでアニメ開始を全員に配信 --EN:--Distribute animation start to everyone with NPC
	--proxy:LuaCallStart( 561, 2 );
	--ヒットパーツを消す --EN:--Erase hit parts
	proxy:SetColiEnable( 1310, false );
	
	--proxy:DeleteEvent( 561 );
	--proxy:DeleteEvent( 562 );
	proxy:SetEventFlag( 563, true );
	print("OnEvent_563 end");
end

--ユルトの死体を調べた --EN:--examined Yurt's corpse
function OnEvent_15630(proxy,param)
	print("OnEvent_15630 begin");
	proxy:SetEventFlag( 15630 , true );
	print("OnEvent_15630 end");
end

--ユルト特性死体再現 --EN:--Yurt characteristic corpse reproduction
function OnEvent_15630_OpeningDead(proxy,param)
	print("OnEvent_15630_OpeningDead begin");
		--死体を再現する --EN:--reproduce the corpse
		proxy:OpeningDeadPlus( 644 , true ,false ,false );
	print("OnEvent_15630_OpeningDead end");
end

--------------------------------------------------------------------------------------
--【鉱石の精霊】死亡■611 --EN:--[Spirit of Ore] Death ■611
--------------------------------------------------------------------------------------
--【鉱石の精霊】死亡■611 --EN:--[Spirit of Ore] Death ■611
function OnEvent_611(proxy,param)
	print("OnEvent_611 begin");
	
	--フラグON --EN:--Flag ON
	proxy:SetEventFlag( 611, true );
	
	print("OnEvent_611 end");
end


--------------------------------------------------------------------------------------
--■8020■鉱石の精霊からアイテム取得■ --EN:-- ■ 8020 ■ Acquiring items from the ore spirit ■
--------------------------------------------------------------------------------------
function OnEvent_8020(proxy,param)
	print("OnEvent_8020 begin");
	proxy:SetEventFlag( 8020 , true );
	print("OnEvent_8020 end");
end





--------------------------------------------------------------------------------------
--■640～659■ムカデ切断■ --EN:-- ■ 640～659 ■ centipede cutting ■
--------------------------------------------------------------------------------------
local BIT_1 =   1;
local BIT_2 =   2;
local BIT_3 =   4;
local BIT_4 =   8;
local BIT_5 =  16;
local BIT_6 =  32;
local BIT_7 =  64;
local BIT_8 = 128;

function MukadeRegist(proxy)
	--OnEvent_640,OnEvent_641,OnEvent_642,OnEvent_643,OnEvent_644,OnEvent_645,OnEvent_646,OnEvent_647,OnEvent_648,OnEvent_649,
	--OnEvent_650,OnEvent_651,OnEvent_652,OnEvent_653,OnEvent_654,OnEvent_655,OnEvent_656,OnEvent_657,OnEvent_658,OnEvent_659
	--OnEvent_660,OnEvent_661,OnEvent_662
	local Mukade_acid_list 		= {  640,  641,  642,  643,  644,  645,  646,  647,  648,  649,  650,  651,  652,  653,  654,  655,  656,  657,  658,  659,  660,  661,  662};
	local Mukade_main_evid_list = {  230,  231,  232,  233,  234,  235,  236,  237,  250,  251,  252,  253,  254,  255,  256,  257,  258,  259,  260,  261,  221,  222,  223};
	local Mukade_sub_evid_list 	= {  240,  241,  242,  243,  244,  245,  246,  247,  270,  271,  272,  273,  274,  275,  276,  277,  278,  279,  280,  281,  224,  225,  226};
	local Mukade_event_num = table.getn(Mukade_acid_list);
	for index = 1, Mukade_event_num, 1 do
		local acid		= Mukade_acid_list[index];
		local main_evid = Mukade_main_evid_list[index];
		local sub_evid	= Mukade_sub_evid_list[index];
		SingleReset( proxy, acid );
		if	proxy:IsCompleteEvent( acid ) == false then
			proxy:OnCharacterTotalRateDamage( acid, main_evid,  -1, 0.5, "OnEvent_"..acid, once );
			proxy:OnCheckEzStateMessage( acid, main_evid, "OnEvent_"..acid.."_1", 500 );
			InvalidCharactor( proxy, sub_evid );
		end
	end
end


function OnEvent_640(proxy,param)	MukadeFunc_CutRequest( proxy, param, param:GetParam1(), 230);		end
function OnEvent_640_1(proxy,param)	MukadeFunc_CutAction(  proxy, param, param:GetParam1(), 230, 240);	end
function OnEvent_641(proxy,param)	MukadeFunc_CutRequest( proxy, param, param:GetParam1(), 231);		end
function OnEvent_641_1(proxy,param)	MukadeFunc_CutAction(  proxy, param, param:GetParam1(), 231, 241);	end
function OnEvent_642(proxy,param)	MukadeFunc_CutRequest( proxy, param, param:GetParam1(), 232);		end
function OnEvent_642_1(proxy,param)	MukadeFunc_CutAction(  proxy, param, param:GetParam1(), 232, 242);	end
function OnEvent_643(proxy,param)	MukadeFunc_CutRequest( proxy, param, param:GetParam1(), 233);		end
function OnEvent_643_1(proxy,param)	MukadeFunc_CutAction(  proxy, param, param:GetParam1(), 233, 243);	end
function OnEvent_644(proxy,param)	MukadeFunc_CutRequest( proxy, param, param:GetParam1(), 234);		end
function OnEvent_644_1(proxy,param)	MukadeFunc_CutAction(  proxy, param, param:GetParam1(), 234, 244);	end
function OnEvent_645(proxy,param)	MukadeFunc_CutRequest( proxy, param, param:GetParam1(), 235);		end
function OnEvent_645_1(proxy,param)	MukadeFunc_CutAction(  proxy, param, param:GetParam1(), 235, 245);	end
function OnEvent_646(proxy,param)	MukadeFunc_CutRequest( proxy, param, param:GetParam1(), 236);		end
function OnEvent_646_1(proxy,param)	MukadeFunc_CutAction(  proxy, param, param:GetParam1(), 236, 246);	end
function OnEvent_647(proxy,param)	MukadeFunc_CutRequest( proxy, param, param:GetParam1(), 237);		end
function OnEvent_647_1(proxy,param)	MukadeFunc_CutAction(  proxy, param, param:GetParam1(), 237, 247);	end
function OnEvent_648(proxy,param)	MukadeFunc_CutRequest( proxy, param, param:GetParam1(), 250);		end
function OnEvent_648_1(proxy,param)	MukadeFunc_CutAction(  proxy, param, param:GetParam1(), 250, 270);	end
function OnEvent_649(proxy,param)	MukadeFunc_CutRequest( proxy, param, param:GetParam1(), 251);		end
function OnEvent_649_1(proxy,param)	MukadeFunc_CutAction(  proxy, param, param:GetParam1(), 251, 271);	end


function OnEvent_650(proxy,param)	MukadeFunc_CutRequest( proxy, param, param:GetParam1(), 252);		end
function OnEvent_650_1(proxy,param)	MukadeFunc_CutAction(  proxy, param, param:GetParam1(), 252, 272);	end
function OnEvent_651(proxy,param)	MukadeFunc_CutRequest( proxy, param, param:GetParam1(), 253);		end
function OnEvent_651_1(proxy,param)	MukadeFunc_CutAction(  proxy, param, param:GetParam1(), 253, 273);	end
function OnEvent_652(proxy,param)	MukadeFunc_CutRequest( proxy, param, param:GetParam1(), 254);		end
function OnEvent_652_1(proxy,param)	MukadeFunc_CutAction(  proxy, param, param:GetParam1(), 254, 274);	end
function OnEvent_653(proxy,param)	MukadeFunc_CutRequest( proxy, param, param:GetParam1(), 255);		end
function OnEvent_653_1(proxy,param)	MukadeFunc_CutAction(  proxy, param, param:GetParam1(), 255, 275);	end
function OnEvent_654(proxy,param)	MukadeFunc_CutRequest( proxy, param, param:GetParam1(), 256);		end
function OnEvent_654_1(proxy,param)	MukadeFunc_CutAction(  proxy, param, param:GetParam1(), 256, 276);	end
function OnEvent_655(proxy,param)	MukadeFunc_CutRequest( proxy, param, param:GetParam1(), 257);		end
function OnEvent_655_1(proxy,param)	MukadeFunc_CutAction(  proxy, param, param:GetParam1(), 257, 277);	end
function OnEvent_656(proxy,param)	MukadeFunc_CutRequest( proxy, param, param:GetParam1(), 258);		end
function OnEvent_656_1(proxy,param)	MukadeFunc_CutAction(  proxy, param, param:GetParam1(), 258, 278);	end
function OnEvent_657(proxy,param)	MukadeFunc_CutRequest( proxy, param, param:GetParam1(), 259);		end
function OnEvent_657_1(proxy,param)	MukadeFunc_CutAction(  proxy, param, param:GetParam1(), 259, 279);	end
function OnEvent_658(proxy,param)	MukadeFunc_CutRequest( proxy, param, param:GetParam1(), 260);		end
function OnEvent_658_1(proxy,param)	MukadeFunc_CutAction(  proxy, param, param:GetParam1(), 260, 280);	end
function OnEvent_659(proxy,param)	MukadeFunc_CutRequest( proxy, param, param:GetParam1(), 261);		end
function OnEvent_659_1(proxy,param)	MukadeFunc_CutAction(  proxy, param, param:GetParam1(), 261, 281);	end

function OnEvent_660(proxy,param)	MukadeFunc_CutRequest( proxy, param, param:GetParam1(), 221);		end
function OnEvent_660_1(proxy,param)	MukadeFunc_CutAction(  proxy, param, param:GetParam1(), 221, 224);	end
function OnEvent_661(proxy,param)	MukadeFunc_CutRequest( proxy, param, param:GetParam1(), 222);		end
function OnEvent_661_1(proxy,param)	MukadeFunc_CutAction(  proxy, param, param:GetParam1(), 222, 225);	end
function OnEvent_662(proxy,param)	MukadeFunc_CutRequest( proxy, param, param:GetParam1(), 223);		end
function OnEvent_662_1(proxy,param)	MukadeFunc_CutAction(  proxy, param, param:GetParam1(), 223, 226);	end


function MukadeFunc_CutRequest(proxy,param,acid,main_evid)
	print("OnEvent_"..acid.." begin");
	proxy:SetEventCommand( main_evid, 600 );
	print("OnEvent_"..acid.." end");
end

function MukadeFunc_CutAction(proxy,param,acid,main_evid,sub_evid)
	if	proxy:IsCompleteEvent( acid ) == true then
		return;
	end
	print("OnEvent_"..acid.."_1 begin");
	proxy:SetEventFlag( acid, true );
	proxy:SetDispMask( main_evid, BIT_1 + BIT_3 + BIT_5 + BIT_7 );
	proxy:SetDispMask(  sub_evid, BIT_2 + BIT_4 + BIT_6 + BIT_8 );
	proxy:SetHitMask( main_evid, BIT_2 );
	proxy:SetHitMask(  sub_evid, BIT_1 );
	
	proxy:SendEventRequest( main_evid,0,1);
	ValidCharactor( proxy, sub_evid );
	proxy:CharactorCopyPosAng( main_evid, sub_evid );
	proxy:OpeningDead( sub_evid, false );
	
	print("OnEvent_"..acid.."_1 end");
end






--■700■要石の光が消える■ --EN:-- ■ 700 ■ Keystone's light disappears ■
function OnEvent_700_1(proxy,param)
	print("OnEvent_700_1 begin");
	proxy:TreasureDispModeChange2( 1982 , false ,KANAME_SFX);
	proxy:InvalidSfx( 2231 , true );--要石のオーラ --EN:--Keystone Aura
	print("OnEvent_700_1 end");
end

--■700■要石の光が復活する■ --EN:-- ■ 700 ■ The keystone's light is revived ■
function OnEvent_700_2(proxy,param)
	print("OnEvent_700_2 begin");
	proxy:TreasureDispModeChange2( 1982 , true ,KANAME_SFX);
	proxy:ValidSfx( 2231 );--要石のオーラ --EN:--Keystone Aura
	print("OnEvent_700_2 end");
end



--■580,581,582,583■昇降版制御 --EN:-- ■ 580, 581, 582, 583 ■ Lifting plate control

function OnEvent_580_1(proxy,param)
	--print("OnEvent_580_1 begin");
	proxy:LuaCallStart( 580, 2 );
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2(580,"OnEvent_580_1_time",1.0,0,5,once);
	proxy:NotNetMessage_end();
	--print("OnEvent_580_1 end");
end

--時間差 --EN:--Time lag
function OnEvent_580_1_time(proxy,param)
	proxy:NotNetMessage_begin();
		proxy:OnCharacterAnimEndPlus(580, 1330, 2, "OnEvent_580_2", once );
	proxy:NotNetMessage_end();
end

function OnEvent_580_2(proxy,param)
	--print("OnEvent_580_2 begin");
	proxy:LuaCallStart( 580, 1 );
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2(580,"OnEvent_580_2_time",1.0,0,5,once);		
	proxy:NotNetMessage_end();
	--print("OnEvent_580_2 end");
end

--時間差 --EN:--Time lag
function OnEvent_580_2_time(proxy,param)
	proxy:NotNetMessage_begin();
		proxy:OnCharacterAnimEndPlus(580, 1330, 1, "OnEvent_580_1", once );
	proxy:NotNetMessage_end();
end



function OnEvent_580_1_call(proxy,param)
	--print("OnEvent_580_1_call ");
	proxy:PlayAnimation( 1330, 1 );
	proxy:SetEventFlag( 581, true );
	--print("OnEvent_580_1_call end");
end

function OnEvent_580_2_call(proxy,param)
	--print("OnEvent_580_2_call ");
	proxy:PlayAnimation( 1330, 2 );
	proxy:SetEventFlag( 581, false );
	--print("OnEvent_580_2_call end");
end



function OnEvent_582_1(proxy,param)
	--print("OnEvent_582_1 begin");
	proxy:LuaCallStart( 582, 2 );
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 582 , "OnEvent_582_1_time",1.0,0,2,once );		
	proxy:NotNetMessage_end();
	--print("OnEvent_582_1 end");
end

--時間差 --EN:--Time lag
function OnEvent_582_1_time(proxy,param)
	proxy:NotNetMessage_begin();
	proxy:OnCharacterAnimEndPlus(582, 1331, 2, "OnEvent_582_2", once );
	proxy:NotNetMessage_end();
end


function OnEvent_582_2(proxy,param)
	--print("OnEvent_582_2 begin");
	proxy:LuaCallStart( 582, 1 );
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 582 , "OnEvent_582_2_time",1.0,0,6,once );		
	proxy:NotNetMessage_end();
	--print("OnEvent_582_2 end");
end

--時間差 --EN:--Time lag
function OnEvent_582_2_time(proxy,param)
	proxy:NotNetMessage_begin();
		proxy:OnCharacterAnimEndPlus(582, 1331, 1, "OnEvent_582_1", once );
	proxy:NotNetMessage_end();
end


function OnEvent_582_1_call(proxy,param)
	--print("OnEvent_582_1_call ");
	proxy:PlayAnimation( 1331, 1 );
	proxy:SetEventFlag( 583, true );
	--print("OnEvent_582_1_call end");
end

function OnEvent_582_2_call(proxy,param)
	--print("OnEvent_582_2_call ");
	proxy:PlayAnimation( 1331, 2 );
	proxy:SetEventFlag( 583, false );
	--print("OnEvent_582_2_call end");
end


function OnEvent_568(proxy,param)
	print("OnEvent_568 begin");
	proxy:ResetThink( 644 );
	--移動タイプを往復に変更 --EN:--Movement type changed to round trip
	proxy:SetEventMovePointType( 644, POINT_MOVE_TYPE_Randum );
	--移動ポイントを変更 --EN:--Change movement point
	local point_list = {2250, 2251, 2252, 2253};
	local point_num = table.getn( point_list );
	for index = 1, point_num, 1 do
		--移動ポイントを設定 --EN:--set movement point
		proxy:AddCustomRoutePoint(644, point_list[index]);
	end
	print("OnEvent_568 end");
end

function OnEvent_569(proxy,param)
	print("OnEvent_569 begin");
	proxy:ResetThink( 644 );
	proxy:SetDefaultRoutePoint( 644 );
	print("OnEvent_569 end");
end


--------------------------------------------------------------------------------------
--■590■ガーゴイル1動き出す■ --EN:-- ■ 590 ■ Gargoyle 1 begins to move ■
--------------------------------------------------------------------------------------
function OnEvent_590(proxy,param)
	print("OnEvent_590 begin");
	proxy:PlayAnimation( 413, 9010 );
	proxy:SetSpStayAndDamageAnimId( 413 , -1,-1);
	proxy:ResetThink( 413 );
	proxy:SetEventFlag( 590 , true );
	print("OnEvent_590 end");
end


--------------------------------------------------------------------------------------
--■591■ガーゴイル2動き出す■ --EN:-- ■ 591 ■ Gargoyle 2 begins to move ■
--------------------------------------------------------------------------------------
function OnEvent_591(proxy,param)
	print("OnEvent_591 begin");
	proxy:PlayAnimation( 411, 9010 );
	proxy:SetSpStayAndDamageAnimId( 411 , -1,-1);
	proxy:ResetThink( 411 );
	proxy:SetEventFlag( 591 , true );
	print("OnEvent_591 end");
end


--------------------------------------------------------------------------------------
--■592■ガーゴイル3動き出す■ --EN:-- ■ 592 ■ Gargoyle 3 begins to move ■
--------------------------------------------------------------------------------------
function OnEvent_592(proxy,param)
	print("OnEvent_592 begin");
	proxy:PlayAnimation( 412, 9010 );
	proxy:SetSpStayAndDamageAnimId( 412 , -1,-1);
	proxy:ResetThink( 412 );
	proxy:SetEventFlag( 592 , true );
	print("OnEvent_592 end");
end


--------------------------------------------------------------------------------------
--■601■鉄の板の先に進んだ■ --EN:-- ■ 601 ■ advanced beyond the iron plate ■
--------------------------------------------------------------------------------------
function OnEvent_601(proxy,param)
	print("OnEvent_601 begin");
	proxy:SetEventFlag( 601 , true );
	print("OnEvent_601 end");
end


--------------------------------------------------------------------------------------
--■597■もやSFX領域に入った■ --EN:--■ 597 ■ entered the haze SFX area ■
--------------------------------------------------------------------------------------
function OnEvent_597(proxy,param)
	print("OnEvent_597 begin");
	--カメラSFXを表示 --EN:--Show camera SFX
	proxy:CreateCamSfx( 94200 , 0 );
	print("OnEvent_597 end");
end


--------------------------------------------------------------------------------------
--■601■もやSFX領域からでた■ --EN:--■ 601■ came out of the haze SFX area■
--------------------------------------------------------------------------------------
function OnEvent_598(proxy,param)
	print("OnEvent_598 begin");
	--カメラSFXを削除 --EN:--removed camera SFX
	proxy:DeleteCamSfx( 0 );
	print("OnEvent_598 end");
end
