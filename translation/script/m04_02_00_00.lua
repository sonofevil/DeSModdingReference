--こんなイベント・・・嘘だと言ってよバーニィィィィ! --EN:--This kind of event... tell me it's a lie, Bernie!


--強制召喚成功時は、これを参照してファンネル発動する --EN:--When forced summoning is successful, refer to this and activate the funnel
ForceSummonBlack_PlayerNo				= -1;

ForceSummonTimeOut						= 100;
--ForceSummonTimeOut						= 10;


--------------------------------------------------------------------------------------
--マップ読み込み時に読まれる初期化処理■ --EN:--Initialization process read when reading the map ■
--------------------------------------------------------------------------------------
function Initialize_m04_02_00_00(proxy)
	print("Initialize_m04_02_00_00 begin");	

--■1065■ブラックNPC同期出現用のLuaCall登録 --EN:-- ■ 1065 ■ LuaCall registration for black NPC synchronous appearance
	proxy:LuaCall( 1065, 2, "SynchroValid_1065", everytime );
	proxy:LuaCall( 1065, 3, "SynchroValid_NoAnim_1065", everytime );
	proxy:LuaCall( 1065, 4, "SynchroInvalid_1065", everytime );
	proxy:LuaCall( 1065, 5, "SynchroInvalid_1065_ForBlack",everytime );--黒翁が召喚された時の念の為 --EN:--Just in case Kuroo was summoned
	proxy:LuaCall( 1065, 4271, "SynchroWarp_1065", everytime );
	proxy:LuaCall( 1065, 2420, "SynchroWarp_1065", everytime );
	proxy:LuaCall( 1065, 2421, "SynchroWarp_1065", everytime );
	proxy:LuaCall( 1065, 2422, "SynchroWarp_1065", everytime );
	
	--強制召喚ブラックゴーストが強制召喚された --EN:-- Forced Summon Black Ghost was forced summoned
	proxy:LuaCall( 4041, 4, "Check_Summon",			everytime );

	proxy:LuaCall( 4041, 1, "Check_AfterSummon",		everytime );
	proxy:LuaCall( 4041, 2, "Check_AfterSummon",		everytime );
	proxy:LuaCall( 4041, 3, "Check_AfterSummon",		everytime );

--■??■徘徊デーモンの登場■ハンドラ登録 --EN:--■??■Appearance of wandering daemon■Handler registration
	proxy:NotNetMessage_begin();
		--プレイヤーがソロで死亡した時にキックされます。 --EN:--Kicked when a player dies solo.
		proxy:LuaCall( 4000, 100, "PlayerDeath_m04_02_00_00", everytime );
		--プレイヤーが復活した時にキックされます。 --EN:--Kicked when the player is revived.
		proxy:LuaCall( 4032, 100, "PlayerRevive_m04_02_00_00", everytime );
	proxy:NotNetMessage_end();
	
	proxy:AddFieldInsFilter( 828 );
	if proxy:IsCompleteEvent( 5380 ) ==false then
		proxy:OnCharacterDead(5380,828,"OnEvent_5380",once);
		--proxy:NotNetMessage_begin();
			--proxy:OnCharacterHP(5383,10000,"OnEvent_5383",0.0,once);
			--proxy:OnCharacterHP(5383,828,"OnEvent_5383_Npc",0.0,once);
		--proxy:NotNetMessage_end();
		proxy:LuaCall( 5380, 2, "OnEvent_5380", once );
		proxy:LuaCall( 5380, 3, "OnEvent_5380_Sfx",once);
	else
		proxy:InvalidSfx( 1989, false );
	end
	
	proxy:OnRegistFunc( 1080, "Condition_1080", "dummy", 2, everytime );
	
	
--[[
	--■徘徊デーモン用 (フラグは仮、指定があれば変える) --EN:--■For wandering daemon (flag is tentative, change if specified)
	if proxy:IsCompleteEvent( 20 ) == true then
		LuaFunc_VisibleTheWanderingDemon  (proxy, param, demon_id_list_m04_02_00_00);
	else
		LuaFunc_InvisibleTheWanderingDemon(proxy, param, demon_id_list_m04_02_00_00);
	end
]]
--■ボス関連の初期化処理 --EN:--■ Boss-related initialization processing
	if proxy:IsCompleteEvent( 5380 ) ==true then
		--魔法壁消える --EN:--Magic wall disappears
		proxy:SetColiEnable( 1997 , false );
		proxy:SetDrawEnable( 1997 , false );
		--魔法壁のSFX OFF --EN:--Magic Wall SFX OFF
		proxy:InvalidSfx( 1989 , false );
		
------アイテム入手関連------------------ --EN:--Item Acquisition Related-------------------
	
		--ホストプレイヤーのみアイテム入手イベントに使用 --EN:--Used for item acquisition event only for host players
		local possible_chr_type = ATTR_HOST + ATTR_LIVE + ATTR_GREY;

		--黄色いボス壁消し --EN:--Yellow boss wall eraser
		proxy:InvalidSfx( 2440, false );
		
		--宝死体(ソウル?)有効化 --EN:--Treasure corpse (soul?) activation
		proxy:SetDrawEnable( 1980 , true );
		proxy:SetColiEnable( 1980 , true );
		--宝死体(ソウル?)有効化 --EN:--Treasure corpse (soul?) activation
		proxy:SetDrawEnable( 1977 , true );
		proxy:SetColiEnable( 1977 , true );
		
		--▼(ソウル)アイテム取得用イベント監視追加▼ --EN:--▼ (Soul) Added event monitoring for item acquisition▼
		if proxy:IsCompleteEvent( 5381 ) == false then
			proxy:ValidSfx( 2400 );--SFX 有効化 --EN:--SFX enable
			proxy:ValidSfx( 2401 );--SFX 有効化 --EN:--SFX enable
			proxy:TreasureDispModeChange2( 1980 , true ,KANAME_SFX);--光らせる --EN:-- let it shine
			proxy:OnDistanceActionAttribute( 5381 , 10000 , 1980 , "OnEvent_5381" , WarpGimmickDist_A , 10010180 , 0 , 180 , possible_chr_type, once );
		else
			--▼要石でワープ用の監視を追加▼ --EN:--▼ Added surveillance for warp with keystone ▼
			SingleReset(proxy,5382);
			--SFX 無効化 --EN:--Disable SFX
			proxy:InvalidSfx( 2400 , false );--ソウル用 --EN:--For Seoul
			--proxy:InvalidSfx( 2401 , false );--ボスアイテム用 --EN:--For boss items
			proxy:TreasureDispModeChange2( 1980 , true ,KANAME_SFX);--光らせる --EN:-- let it shine
			proxy:OnDistanceActionAttribute( 5382 , 10000 , 1980 , "OnEvent_5382" , WarpGimmickDist_A , HELPID_GO_TO_SEKITYUU , 0 , 180 , ATTR_NOSESSION , everytime );
		end
		
--------------------------------------
		InvalidBackRead( proxy, 828 );
		--InvalidCharactor( proxy, 829 );

	else
		if	proxy:IsClient() == false then
			proxy:SetEventFlag( 1030, false );
			proxy:SetEventFlag( 1033, false );--ボスBGM、HP、ファンネル --EN:--Boss BGM, HP, Funnel
			proxy:SetEventFlag( 1090, false );
			proxy:SetEventFlag( 1100, false );
			
			proxy:SetEventFlag( 1081, false );
			proxy:RequestForceUpdateNetwork(828);
			proxy:OnRegionJustIn( 5456, LOCAL_PLAYER, 2430, "OnEvent_5456", once );
		end
		
		--変身ポリ劇前 --EN:--Before transformation poly drama
		if proxy:IsCompleteEvent( 1030 ) == false then
			--白いボス壁消し --EN:--White boss wall eraser
			proxy:InvalidSfx( 1989, false );
		else
		--変身ポリ劇後 --EN:--After transformation police play
			--黄色いボス壁消し --EN:--Yellow boss wall eraser
			proxy:InvalidSfx( 2440, false );
		end
		
		if	proxy:IsCompleteEvent( 1081 ) == false then
			InvalidCharactor( proxy, 828 );
		end
		
------アイテム入手関連------------------ --EN:--Item Acquisition Related-------------------
		--宝死体(ソウル?) --EN:--Treasure Corpse (Soul?)
		proxy:SetDrawEnable( 1980 , false );
		proxy:SetColiEnable( 1980 , false );
		--宝死体(ソウル?)2 --EN:--Treasure Corpse (Soul?) 2
		proxy:SetDrawEnable( 1977 , false );
		proxy:SetColiEnable( 1977 , false );
	
		--SFX 無効化 --EN:--Disable SFX
		proxy:InvalidSfx( 2400 , false );--ソウル用 --EN:--For Seoul
		proxy:InvalidSfx( 2401 , false );--ボスアイテム用 --EN:--For boss items
----------------------------------------
	end
	
	--■5454■ボス部屋イベント登録配信用 --EN:-- ■ 5454 ■ For boss room event registration distribution
	proxy:LuaCall( 5454, 2, "DoorRegist", everytime );
	
	--■5455■強制召喚、及び関連ハンドラ登録 --EN:-- ■ 5455 ■ Forced summons and related handler registration
	proxy:LuaCall( 5455, 2, "ForceSummonStart", everytime );
	--強制召喚ブラックゴーストがキック・退出・死亡以外でいなくなった --EN:-- Forced Summon Black Ghost disappeared without kicking, exiting, or dying
	proxy:LuaCall( 4043, 4, "Check_LeavePlayer",	everytime );
	--無責任に退出 --EN:--Exit irresponsibly
	proxy:LuaCall( 4043, 5, "Check_LeavePlayer2", 	everytime );
	
	--強制召喚ブラックゴーストが退出した --EN:-- Forced Summon Black Ghost left
	proxy:LuaCall( 4046, 3, "Check_Leave", 			everytime );
	
	--■5457■強制召喚されたキャラが、ボス戦途中から参加したキャラに対して自分がボスだと教える --EN:-- ■ 5457 ■ A character who is forcibly summoned tells a character who participates in the middle of the boss battle that he is the boss.
	proxy:LuaCall( 5457, 3, "ForceSummonInfo", everytime );
	
	--■5458■浮遊するソウルの矢、同期発射用(ホストがキックして管理します) --EN:-- ■ 5458 ■ Floating soul arrows, for synchronous firing (host kicks and manages)
	proxy:CustomLuaCall( 5458, "FloatingSoulArrow", everytime );
		
	--■5459■ホストからSoulLvを貰って特殊効果を付けます■ --EN:--■5459■Get SoulLv from the host and add special effects■
	proxy:CustomLuaCall( 5459,"ForceSummon_Balance", everytime );
	
	proxy:NotNetMessage_begin();
		proxy:LuaCall( 5500,0,"ForceSummon_IsIn",everytime );
	proxy:NotNetMessage_end();
	
--■1030■翁変身ポリ劇■	 --EN:-- ■ 1030 ■ Okina transformation poly drama ■
	SingleReset( proxy, 1031 );
	proxy:EnableInvincible( 823, true );--上のやつは絶対に死なないようにしておく --EN:--Make sure the guy above doesn't die
	if proxy:IsCompleteEvent( 1030 ) == false then
		--proxy:OnRegistFunc( 1030, "Condition_1030", "OnEvent_1030", 2, once);
		proxy:LuaCall( 1030, 2, "OnEvent_1030", everytime );
		--ポリ劇開始フェード後に呼ばれるハンドラ --EN:--Handler called after polyplay start fade
		proxy:LuaCall( 1030, REMO_START, "OnEvent_1030_RemoStart",once);
		--ポリ劇終了後に呼ばれるハンドラ --EN:--Handler called after the polyplay ends
		proxy:LuaCall( 1030, REMO_FINISH, "OnEvent_1030_RemoFinish",once);
		
		InvalidCharactor( proxy, 828 );
		--InvalidCharactor( proxy, 829 );
	else
		if	proxy:IsCompleteEvent( 5380 ) == false then			
			DoorRegist(proxy,param);
		end
		InvalidCharactor( proxy, 823 );
	end

--■1033■ボスBGM■ --EN:--■1033■Boss BGM■
	if proxy:IsCompleteEvent( 5380 ) == false then
		if proxy:IsCompleteEvent( 1033 ) == false then
			if proxy:IsClient() == false then
				proxy:NotNetMessage_begin();
					proxy:OnRegionJustIn( 1033 , 10000 , 2410 , "OnEvent_1033",onve);
				proxy:NotNetMessage_end();
			end
			--ホストが強制召還プレイヤーに向けて特殊効果を配信 --EN:--The host delivers special effects to forced summon players
			proxy:CustomLuaCall( 1033 , "OnEvent_1033_0",once );
			proxy:LuaCall( 1033 , 100 ,"OnEvent_1033_2",once );
			proxy:LuaCall( 1033 , 0 , "OnEvent_1033_1",once);
		end
	end
	
--■1051■ポリ劇登場キャラ無効化■ --EN:-- ■ 1051 ■ Disabling characters appearing in police dramas ■
	InvalidCharactor( proxy, 320 );
	proxy:SetEventFlag( 1051 , true );	
	
	
--■8086■牢城に来たフラグを立てる■ --EN:-- ■ 8086 ■ Raise a flag for coming to the prison ■
	proxy:SetEventFlag( 8086, true );
	
	--■999999■フレーム遅れの初期化処理イベントを発行■ --EN:-- ■ 999999 ■ Generate a frame delay initialization processing event ■
	proxy:NotNetMessage_begin();
		--▼0秒後▼-- --EN:--▼After 0 seconds▼--
		proxy:OnKeyTime2( 999992, "Second_Initialize_m04_02_00_00", 0.0, 0, 0, once );	
	proxy:NotNetMessage_end();	
	
	print("Initialize_m04_02_00_00 end");
end


--------------------------------------------------------------------------------------
--Initializeから呼ばれる、1フレーム遅れの初期化処理■999999 --EN:--Initialization with a delay of 1 frame, called from Initialize ■999999
--------------------------------------------------------------------------------------
--■999999■一部、Initでは処理できないので、残しておく --EN:-- ■ 999999 ■ Some parts cannot be processed by Init, so leave them
function Second_Initialize_m04_02_00_00(proxy, param)
	print("Second_Initialize_m04_02_00_00 begin");

--------------------------------▽▽▽QWCイベント関連▽▽▽-------------------------------- --EN:--▽▽▽QWC event related ▽▽▽--------------------------------
--------------------------------△△△QWCイベント関連△△△-------------------------------- --EN:--△△△QWC event related△△△--------------------------------

	print("Second_Initialize_m04_02_00_00 end");
end



--------------------------------------------------------------------------------------
--徘徊デーモンの登場■?? --EN:-- Appearance of the Wandering Demon ??
--------------------------------------------------------------------------------------

--▼グローバルの死亡監視から呼ばれる(ソロ) --EN:--▼ Called from global death watch (solo)
function PlayerDeath_m04_02_00_00(proxy, param)
	print("PlayerDeath_m04_02_00_00");
	
--	LuaFunc_VisibleTheWanderingDemon(proxy, param, demon_id_list_m04_02_00_00);
--	proxy:SetEventFlag( 20 , 1 );--フラグは仮、指定があれば変える。 --EN:The -- flag is tentative, and will be changed if specified.
	
	print("PlayerDeath_m04_02_00_00");
end

--▼グローバルの血文字復活から呼ばれる(ソロ) --EN:--▼Called from global blood letter revival (solo)
function PlayerRevive_m04_02_00_00(proxy,param)
	print("PlayerRevive_m04_02_00_00");
	
--	LuaFunc_InvisibleTheWanderingDemon(proxy, param, demon_id_list_m04_02_00_00);
--	proxy:SetEventFlag( 20 , 0 );--フラグは仮、指定があれば変える。 --EN:The -- flag is tentative, and will be changed if specified.
	
	print("PlayerRevive_m04_02_00_00");
end




--------------------------------------------------------------------------------------
--ボス部屋の中に入る■1031 --EN:--Enter the boss room 1031
--------------------------------------------------------------------------------------

--■イベントがループなので、全部リピートにする↓ --EN:--■ Since the event is a loop, repeat all ↓

--■1031■中ボス部屋への扉が開く■ --EN:-- ■ 1031 ■ The door to the mid-boss room opens ■
function OnEvent_1031(proxy,param)
	print("OnEvent_1031 begin");
	
	if proxy:IsCompleteEvent( SYSTEM_ID_IGNORE ) == true then
		print("OnEvent_1031 end");
		return;
	end
	
	--クライアントへ、ボス部屋阻止失敗を通知 --EN:--Notify client of failure to block boss room
	if proxy:IsClient() == false then
		proxy:LuaCallStart( 4068 , 1 );	
	end
	
	proxy:LuaCallStart( 1032, 1 );--旋回アニメの同期再生 --EN:-- Synchronous playback of turning animation
	--proxy:SetEventFlag( SYSTEM_ID_IGNORE, true );
	--多重起動システムIDをタイムアウトを設定してONにする --EN:--Turn on multiple activation system ID by setting timeout
	proxy:SetSystemIgnore( SYSTEM_ID_IGNORE , IGNORE_TIME );
	
	--プロファイルセーブ要求 --EN:--profile save request
	proxy:SaveRequest_Profile();
	
	print("OnEvent_1031 end");
end


--旋回アニメの同期再生(IDが別) --EN:-- Synchronized playback of turning animation (ID is different)
function OnEvent_1032_1(proxy,param)
	print("OnEvent_1032_1 begin");

	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		if param:IsNetMessage() == true then
			--旋回アニメ再生を行い、その終了時にOnEvent_1032_2を発行する --EN:--Play the turning animation and issue OnEvent_1032_2 at the end
			proxy:TurnCharactor( 10001 + param:GetPlayID(), 2889 );
		else
			proxy:LockSession();--ルームをロックします！ --EN:--lock the room!
			--旋回アニメ再生を行い、その終了時にOnEvent_1032_2を発行する --EN:--Play the turning animation and issue OnEvent_1032_2 at the end
			proxy:OnTurnCharactorEnd( 1032, 10000, 2889, "OnEvent_1032_2", once );
		end
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	
	print("OnEvent_1032_1 end");
end

--旋回アニメの同期再生終了後 --EN:--After synchronous playback of turning animation ends
function OnEvent_1032_2(proxy,param)
	print("OnEvent_1032_2 begin");

	--同期用歩きアニメ再生 --EN:--Play walking animation for synchronization
	proxy:LuaCallStart( 4012, 1 );
	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		proxy:OnChrAnimEnd( 1032, 10000, ANIMEID_WALK, "OnEvent_1032_3", once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	
	print("OnEvent_1032_2 end");
end

--歩きアニメの同期再生終了後 --EN:--After the synchronized playback of the walking animation ends
function OnEvent_1032_3(proxy,param)
	print("OnEvent_1032_3 begin");

	--最初の人がボス部屋の中に入り終わっていたら、既に配信されているはずなので、もうおくらないハンドラ --EN:--If the first person has already entered the boss room, it should have already been delivered, so no more handlers
	if proxy:IsCompleteEvent( 1031 ) == false then
		proxy:LuaCallStart( 1032 , 5 );--2回目以降にボス部屋に入るためのイベント配信用 --EN:--For event delivery to enter the boss room after the second time
		proxy:LuaCallStart( 4045 , 1 );	--クライアントへ、ボス部屋に入れるようになったことを通知 --EN:--Notify clients that they can now enter the boss room
		--ドーピング同期 --EN:--doping synchronization
		proxy:LuaCallStart( 1032 , 7 );					
		proxy:LuaCallStart( 1032 , 6 );--フラグセット(同期用) --EN:--flag set (for synchronization)
		--代替NPCには既に設定しておく --EN:-- Already set for alternative NPC
		Lua_MultiDoping(proxy,828);--マルチプレイドーピング --EN:-- Multiplayer Doping
	end

	--プレイヤーが扉の中に完全にはいったタイミングで、ボスの思考をリセット --EN:--Reset the boss' thoughts when the player is completely inside the door
	--場所が悪いとプレイヤーを見つけれないため(攻撃してこない) --EN:--Because you can't find the player if the location is bad (they won't attack)
	if proxy:IsClient() == false then
		proxy:ResetThink( 800 );
	end
	
	proxy:SetEventFlag( SYSTEM_ID_IGNORE, false );

	print("OnEvent_1032_3 end");
end


--■1031 2回目以降にボス部屋に入るためのイベント配信用 --EN:-- 1031 For event delivery to enter the boss room after the second time
function OnEvent_1031_GO_TO_IN(proxy, param)
	print("OnEvent_1031_GO_TO_IN begin");

	proxy:NotNetMessage_begin();
		--▼1032▼扉が開いているときに中に入るためのイベントを追加▼--ハンドラは OnEvent_1031 --EN:--▼1032▼Add an event to enter inside when the door is open▼--The handler is OnEvent_1031
		proxy:OnPlayerActionInRegion( 1032, 2893, "OnEvent_1031", HELPID_GO_TO_IN, everytime );--
	proxy:NotNetMessage_end();	

	print("OnEvent_1031_GO_TO_IN end");
end


--■1031 フラグセット(同期用) --EN:-- 1031 Flag set (for synchronization)
function OnEvent_1031_flag_set(proxy, param)
	print("OnEvent_1031_flag_set begin");
		
	proxy:SetEventFlag( 1031 , 1 );
	proxy:DeleteEvent( 1031 );

	print("OnEvent_1031_flag_set end");
end

--■1031■強制召還用ドーピング同期■ --EN:-- ■ 1031 ■ doping sync for forced summons ■
function OnEvent_1031_Doping(proxy,param)
	print("OnEvent_1031_Doping begin");
	if proxy:GetLocalPlayerId() == ForceSummonBlack_PlayerNo then		
		Lua_MultiDopingm04_02(proxy,10001 + ForceSummonBlack_PlayerNo);		
	end
	print("OnEvent_1031_Doping end");
end

--歩きアニメ再生後だと、床に足が着かずにプレイ領域IDが変わらない状態で --EN:-- After playing the walking animation, the play area ID does not change because the foot does not touch the floor.
--強制召喚してしまい、強制召喚されるブラックがボス部屋以外の --EN:--Forcibly summoned, Black who is forcibly summoned is outside the boss room
--ミニブロックの頭から出てくることになるので、タイミングをずらします。 --EN:--Since it will come out from the head of the mini block, the timing is shifted.
function OnEvent_1032_4(proxy,param)
	print("OnEvent_1032_4 begin");
	proxy:SummonBlackRequest(4271);
	print("OnEvent_1032_4 end");
end



function ForceSummon_IsIn(proxy,param)
	print("ForceSummon_IsIn begin");
	proxy:EraseEventSpecialEffect_2( 10000 , 4006 );
	proxy:SetEventSpecialEffect_2( 10000 , 4006 );
	proxy:LuaCallStartPlus( 1065, 5, 828 );--SynchroInvalid_1065_ForBlack	
	print("ForceSummon_IsIn end");
end

----------------------------------------------------------------------------------------------------------------
--■ボスポリ劇 --EN:-- Bospoli play
----------------------------------------------------------------------------------------------------------------
function OnEvent_1030(proxy,param)	
	if proxy:IsCompleteEvent( 1030 ) == true then
		return;
	end
	print("OnEvent_1030 begin");
	
	proxy:RequestRemo(40201, REMO_FLAG, 1030, 1 );
	proxy:SetEventFlag( 1030, true );
	
	print("OnEvent_1030 end");
end


--■ポリ劇再生開始(フェード終了) --EN:--■ Start of polyplay playback (end of fade)
function OnEvent_1030_RemoStart(proxy,param)
	print("OnEvent_1030_RemoStart begin");
	proxy:InvalidSfx( 2441, false );--ポリ劇に邪魔なSfxを消す --EN:--Erase Sfx that interferes with the polyplay
	proxy:InvalidSfx( 2440, false );--黄色壁を消す --EN:--Erase the yellow wall
	print("OnEvent_1030_RemoStart end");
end

--■ポリ劇再生終了(フェード終了) --EN:-- End of polyplay playback (end of fade)
function OnEvent_1030_RemoFinish(proxy,param)
	print("OnEvent_1030_RemoFinish begin");
	proxy:ValidSfx( 2441 );--ポリ劇に都合が悪かっただけなのでSfxを戻す --EN:--Sfx is returned because it was just inconvenient for the polyplay
	proxy:ValidSfx( 1989 );--白壁を有効にする --EN:--Enable white wall
	
--[[
	InvalidCharactor( proxy, 823 );
	ValidCharactor( proxy, 828 );
	proxy:Warp( 828, 2420 );
	ValidCharactor( proxy, 829 );
]]
	--ボス部屋イベント追加 --EN:--Boss room event added
	if proxy:IsClient() == false then
		proxy:LuaCallStart( 5454, 2 );
	end
	
	--if proxy:GetLocalPlayerId() == ForceSummonBlack_PlayerNo then
	if	proxy:GetTempSummonParam() > 0 then
		print("私が強制ブラックプレイヤーです"); --EN:print("I am a forced black player");
		proxy:EraseEventSpecialEffect_2( 10000 , 4006 );
		proxy:SetEventSpecialEffect_2( 10000 , 4006 );
		proxy:LuaCallStartPlus( 1065, 5, 828 );--SynchroInvalid_1065_ForBlack
	end
	
	--proxy:PlayPointSE( 2410, SOUND_TYPE_M, 40200000, 2 );
	proxy:LuaCallStartPlus( 1065, 4, 823 );--SynchroInvalid_1065
	--proxy:LuaCallStartPlus( 1065, 3, 828 );--SynchroValid_NoAnim_1065
	--proxy:LuaCallStartPlus( 1065, 2420, 828 );--SynchroWarp_1065
	--proxy:LuaCallStartPlus( 1065, 3, 829 );--SynchroValid_NoAnim_1065
	
	print("OnEvent_1030_RemoFinish end");
end





function OnEvent_5383(proxy,param)
	if proxy:GetLocalPlayerId() == ForceSummonBlack_PlayerNo then
		print("OnEvent_5383 begin");
		proxy:NotNetMessage_begin();
			proxy:OnKeyTime2( 5383 , "OnEvent_5383_wait",1.0,0,0,once);
		proxy:NotNetMessage_end();		
		print("OnEvent_5383 end");
	end
end

function OnEvent_5383_Npc(proxy,param)
	print("OnEvent_5383_Npc begin");
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 5383 , "OnEvent_5383_wait",0.5,0,0,once);
	proxy:NotNetMessage_end();
	print("OnEvent_5383_Npc begin");
end

function OnEvent_5383_wait(proxy,param)
	print("OnEvent_5383_wait begin");
	--proxy:LuaCallStart( 5380, 3 );
	print("OnEvent_5383_wait end");
end

--[[------------------------------------------------------------------------------------
--■5380■ボス死亡■ --EN:-- ■ 5380 ■ Boss death ■
--------------------------------------------------------------------------------------]]
--■5380■ボス死亡■ --EN:-- ■ 5380 ■ Boss death ■
function OnEvent_5380(proxy,param)
	print("OnEvent_5380 begin");
		
	if proxy:IsClient() == false and proxy:IsCompleteEvent(5383) == false then
		proxy:LuaCallStart( 5380, 3 );
	end

	proxy:NotNetMessage_begin();
		--1秒後に崩れる壁発動イベントを発行-- --EN:-- Issue a wall trigger event that collapses after 1 second --
		proxy:OnKeyTime2(5380,"OnEvent_5380_1", 1,0,0,once);
		--マルチ解散監視 --EN:--Multi-Dismissal Monitoring
		proxy:OnRegistFunc( 5380 , "Check_5380_PT","OnEvent_5380_PT",0,once);
	proxy:NotNetMessage_end();

	--ファンネル終了 --EN:--Funnel end
	proxy:DeleteEvent( 5458 );
	
	proxy:SetEventFlag( 5380, true );
	
	--ボス戦用のBGM停止 --EN:--BGM stop for boss battles
	proxy:StopPointSE( 2 );
	--ブロッククリア処理へ --EN:-- to block clear processing
	proxy:CustomLuaCallStart( 4050, 828 );
	
	--トカゲイベントリセット --EN:-- lizard event reset
	ResetTokage(proxy);
	
	--[[
	--王城3開放インフォメーション --EN:--Castle 3 opening information
	if proxy:IsClient() == false then
		if proxy:IsCompleteEvent( 8050 ) == false then
			proxy:NotNetMessage_begin();
				proxy:OnKeyTime2( 8050 , "OnEvent_8050",5.0,0,0,once);
				proxy:SetEventFlag( 8050 , true );
			proxy:NotNetMessage_end();
		end
	end
	]]
	
	--ホスト自キャラ　or　シングル --EN:--Host's own character or single
	if proxy:IsClient() == false then	
		proxy:SetEventFlag(	8012, 1 );--クリアフラグON --EN:--Clear flag ON
	end
	
	print("OnEvent_5380 end");
end

--PC黒殺害SFX --EN:--PC black killing SFX
function OnEvent_5380_Sfx(proxy,param)
	print("OnEvent_5380_Sfx begin");
	local BossId = -1;
	if	ForceSummonBlack_PlayerNo == -1 then
		BossId = 828;
	else
		BossId = 10001 + ForceSummonBlack_PlayerNo;
	end	
	print("BossId :",BossId);
	--proxy:CreateSfx_DummyPoly( BossId, 50 , 16034 );
	proxy:CreateSfx_DummyPoly( BossId, 91 , 16034 );
	proxy:SetEventFlag( 5383 , true );
	print("OnEvent_5380_Sfx end");
end

function OnEvent_5380_1(proxy,param)
	print("OnEvent_5380_1 begin");

	--ボスを倒した数を更新(数によってフラグを立てる) --EN:--update number of bosses killed (flag by number)
	GetBossFlagCount( proxy, param );

--アイテム入手関連------- --EN:--Item Acquisition Related-------
	
	--ホストプレイヤーのみアイテム入手イベントに使用 --EN:--Used for item acquisition event only for host players
	local possible_chr_type = ATTR_HOST + ATTR_LIVE + ATTR_GREY;

	--宝死体(ソウル?)有効化 --EN:--Treasure corpse (soul?) activation
	proxy:SetDrawEnable( 1980 , true );
	proxy:SetColiEnable( 1980 , true );
	--宝死体(ソウル?)2有効化 --EN:--Treasure corpse (soul?) 2 enabled
	proxy:SetDrawEnable( 1977 , true );
	proxy:SetColiEnable( 1977 , true );
	
	--▼(ソウル)アイテム取得用イベント監視追加▼ --EN:--▼ (Soul) Added event monitoring for item acquisition▼
	if proxy:IsCompleteEvent( 5381 ) == false then
		proxy:ValidSfx( 2400 );--SFX 有効化 --EN:--SFX enable
		proxy:ValidSfx( 2401 );--SFX 有効化 --EN:--SFX enable
		proxy:TreasureDispModeChange2( 1980, true ,KANAME_SFX);--光らせる --EN:-- let it shine
		proxy:OnDistanceActionAttribute( 5381 , 10000 , 1980, "OnEvent_5381" , WarpGimmickDist_A , 10010180 , 0 , 180 , possible_chr_type, once );
	end
------------------------]]
	
	--▼トロフィー取得判定▼ --EN:--▼Trophy Acquisition Judgment▼
	Lua_RequestUnlockTrophy(proxy, 8);	
	
	print("OnEvent_5380_1 end");
end

--王城３解放の表示 --EN:--View Liberation of Royal Castle 3
function OnEvent_8050(proxy,param)
	print("OnEvent_8050 begin");
	--インフォ表示 --EN:--Info display
	--システムメッセージ --EN:--system message
	--[[
	proxy:InfomationMenu( INFOMENU_TYPE_LIST, -1, 0, -1, 1 );
	proxy:AddInfomationBuffer( 10010750 );	
	]]
	proxy:RequestOpenBriefingMsgPlus(10010750,true);
	proxy:PlayTypeSE( 10000 ,SOUND_TYPE_M ,777777777 );
	print("OnEvent_8050 end");
end


--マルチ解散監視 --EN:--Multi-Dismissal Monitoring
function Check_5380_PT(proxy)
	if proxy:IsInParty() == false then
		return true;
	end
	return false;
end

--マルチじゃない --EN:--not multiplayer
function OnEvent_5380_PT(proxy,param)
	print("OnEvent_5380_PT begin");
	
	proxy:InvalidSfx( 1989, true );
	
	--中ボス部屋の魔法壁が消える(全プレイヤー)	 --EN:--The magic wall in the mid-boss room disappears (all players)
	proxy:SetColiEnable( 1997 , false );	
	proxy:SetDrawEnable( 1997 , false );
	
	--中ボス部屋前の移動処理イベントを削除 --EN:--Delete the movement processing event in front of the mid-boss room
	proxy:DeleteEvent( 1031 );--一人目が入るとき用 --EN:--For when the first person enters
	proxy:DeleteEvent( 1032 );--二人目以降が入るとき用 --EN:--For when the second and subsequent people enter
	print("OnEvent_5380_PT end");
end

--------------------------------------------------------------------------------------
--■5381■ソウル入手■ --EN:-- ■ 5381 ■ Get Soul ■
--------------------------------------------------------------------------------------
--■5381■ソウル入手■ --EN:-- ■ 5381 ■ Get Soul ■
function OnEvent_5381(proxy,param)
	print("OnEvent_5381 begin");
	--プレイヤーの同期アニメーション(true:パーティープレイヤーがアニメーションした) --EN:--Player synchronous animation (true: party player animated)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_PICK ) == true then--新しいアニメ  --EN:-- new anime
		print("OnEvent_5381 end");
		return true;
	end
	
	proxy:NotNetMessage_begin();
		--0.0秒後にアイテム取得イベントを発行 --EN:-- Issue an item acquisition event after 0.0 seconds
		proxy:OnKeyTime2( 5381, "OnEvent_5381_1", 0.0, 0, 0, once );
	proxy:NotNetMessage_end();
	print("OnEvent_5381 end");
end



--■5381_1■アイテム取得■ --EN:-- ■ 5381_1 ■ item acquisition ■
function OnEvent_5381_1(proxy, param)
	print("OnEvent_5381_1 begin");

	--アイテム取得関数--パラメータ10552参照 --EN:--item retrieval function--see parameter 10552
	proxy:GetRateItem(10552);
	--アイテム取得関数--パラメータ10578参照 --EN:--item retrieval function--see parameter 10578
	proxy:GetRateItem(10578);
	--アイテム取得関数--パラメータ10579参照 --EN:--item retrieval function--see parameter 10579
	proxy:GetRateItem(10579);
	--アイテム取得関数--パラメータ10580参照 --EN:--item retrieval function--see parameter 10580
	proxy:GetRateItem(10580);
	--アイテム取得関数--パラメータ10581参照 --EN:--item retrieval function--see parameter 10581
	proxy:GetRateItem(10581);
	
	--アイテムを取得済み --EN:--item already acquired
	proxy:SetEventFlag( 5381, 1 );
	
	--SFXが消える --EN:--SFX disappear
	proxy:InvalidSfx( 2400 , true );

	if proxy:IsCompleteEvent( 8035 ) == false then
		proxy:NotNetMessage_begin();
			--瞬間で表示するとメニューが先に出るので待つ --EN:--If you display it instantly, the menu will appear first, so wait
			proxy:OnKeyTime2( 8035 , "OnEvent_8035_wait",0.5 , 0 , 1, once);			
		proxy:NotNetMessage_end();
	else
		--▼要石でワープ用の監視を追加▼ --EN:--▼ Added surveillance for warp with keystone ▼
		proxy:OnDistanceActionAttribute( 5382 , 10000 , 1980 , "OnEvent_5382" , WarpGimmickDist_A , HELPID_GO_TO_SEKITYUU , 0 , 180 , ATTR_NOSESSION , everytime );
	end	
	
	print("OnEvent_5381_1 end");
end

--[[
]]
--アイテム取得後のウェイト --EN:--Wait after getting item
function OnEvent_8035_wait(proxy,param)
	print("OnEvent_8035_wait begin");
	proxy:NotNetMessage_begin();
		--インフォメニューが消えるのを待ちたい --EN:--I want to wait for the info menu to disappear
		proxy:OnRegistFunc( 8035 , "Check_8035" , "OnEvent_8035" , 1 , ocne);
	proxy:NotNetMessage_end();
	print("OnEvent_8035_wait end");
end	

--インフォ待ち --EN:--Waiting for info
function Check_8035(proxy)
	if proxy:IsShowMenu_InfoMenu() == true then
		return false;
	end
	return true;
end

--開放インフォ表示 --EN:--Open info display
function OnEvent_8035(proxy,param)
	print("OnEvent_8035 begin");
	proxy:NotNetMessage_begin();		
		OnEvent_8050(proxy,param)
		proxy:SetEventFlag( 8035 , true );
	proxy:NotNetMessage_end();
	--▼要石でワープ用の監視を追加▼	 --EN:--▼ Added surveillance for warp with keystone ▼
	proxy:OnDistanceActionAttribute( 5382 , 10000 , 1980 , "OnEvent_5382" , WarpGimmickDist_A , HELPID_GO_TO_SEKITYUU , 0 , 180 , ATTR_NOSESSION , everytime );
	print("OnEvent_8035 end");
end


--------------------------------------------------------------------------------------
--■5382■石柱にワープ■ --EN:-- ■ 5382 ■ Warp to the stone pillar ■
--------------------------------------------------------------------------------------
function OnEvent_5382(proxy,param)
	print("OnEvent_5382 begin");
	
	proxy:RepeatMessage_begin();
		--▼70_1▼選択メニューの監視▼ --EN:--▼70_1▼Select menu monitoring▼
		proxy:OnSelectMenu(5382, "OnEvent_5382_1", 10010710, 0, 2, 1980, 2, once);
	proxy:RepeatMessage_end();
	
	print("OnEvent_5382 end");
end

--▲5382_1▲選択メニューの監視▲ --EN:--▲5382_1▲Monitor selection menu▲
function OnEvent_5382_1(proxy,param)	
	print("OnEvent_5382_1 begin");
	
	if proxy:IsSession() == false then
		
		if param:IsNetMessage() == true then
			proxy:PlayAnimation(10001+param:GetPlayID(),8283);
			print("OnEvent_5382_1 end");
			return;
		end
			
		proxy:PlayAnimation(10000,8283);
		proxy:NoAnimeTurnCharactor( 10000 , 1980 ,TURNSKIP_ANGLE);
		
		proxy:NotNetMessage_begin();
		proxy:RepeatMessage_begin();
			proxy:OnChrAnimEnd( 5382 , 10000 , 8283 , "OnEvent_5382_2",once);
		proxy:RepeatMessage_end();
		proxy:NotNetMessage_end();
		
		proxy:SetEventFlag(5382,true);
	else
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010720, 0, 6, 1983, GEN_DIALOG_DIST, once );
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
	end
	
	print("OnEvent_5382_1 end");
end

--■5382_2■石柱にワープ■ --EN:--■ 5382_2 ■ Warp to the stone pillar ■
function OnEvent_5382_2(proxy,param)	
	print("OnEvent_5382_2 begin");

	proxy:PlayAnimation( 10000 , 8284 );--自世界に帰るアニメを再生 --EN:--Play animation to return to your own world
	
	--石柱へ戻ってきた判定のフラグを立てる --EN:--Flag the judgment of returning to the stone pillar
	proxy:SetEventFlag(8083, true);
	
	--完全回復要求 --EN:-- full recovery request
	proxy:RequestFullRecover();
	--古砦要石に戻る --EN:--Return to Old Fort Keystone
	proxy:WarpNextStage( 1, 0, 0, 0, 1008);	
	print("OnEvent_5382_2 end");
end

------------------------------------------------------------------------------

function Condition_1080(proxy,param)
	if	proxy:GetBlockId() == 2 then
		if	proxy:GetPartyRestrictNum() ~= 3 then
			proxy:SetPartyRestrictNum(3);
			print("Condition_1080 set RestrictNum 3");
		end
	else
		if	proxy:GetPartyRestrictNum() ~= 4 then
			proxy:SetPartyRestrictNum(4);
			print("Condition_1080 set RestrictNum 4");
		end
	end
	return false;
end


function OnEvent_1090(proxy,param)
	print("OnEvent_1090 begin");
	proxy:NotNetMessage_begin();
		if	proxy:IsOnline() == true then
			proxy:LuaCallStartPlus( 1065, 4271, 828 );
		else
			proxy:LuaCallStartPlus( 1065, 4271, 828 );
		end
		proxy:LuaCallStartPlus( 1065, 2, 828 );--SynchroValid_1065
		proxy:SetEventFlag( 1081, true );--NPCが召喚されたチェック --EN:--Check if NPC is summoned
		proxy:SetEventFlag( 1090, true );
		
		--タイムアウトしたので、ポリ劇の流れへ --EN:--It's timed out, so let's go to the flow of the police play
		--ポリ劇再生 --EN:--Poly play
		proxy:LuaCallStart( 1030, 2 );
	proxy:NotNetMessage_end();
	print("OnEvent_1090 end");
end

function OnEvent_1081(proxy,param)
	print("OnEvent_1081 begin");
	proxy:SetEventFlag( 1100, true );
	print("OnEvent_1081 end");
end


--ボス部屋に入ってから、ホストで強制召喚の度に呼ばれる --EN:--After entering the boss room, called every time the host summons
function Check_Summon(proxy,param)
	print("Check_Summon begin");

	--強制召喚されたプレイヤのIDを覚えておく --EN:-- Remember the ID of the forced summoned player
	ForceSummonBlack_PlayerNo = param:GetPlayID();
	
	--配信元が強制召喚ブラックなので、ここでホストと区分け --EN:--Since the distribution source is forced summoning black, it is separated from the host here
	if	proxy:IsClient() == false then
		if	proxy:IsCompleteEvent( 1090 ) == false then
			proxy:DeleteEvent( 1090 );
			proxy:SetEventFlag( 1090, true );			
			--ポリ劇再生 --EN:--Poly play
			--proxy:LuaCallStart( 1030, 2 );
		end
	end
	
	if proxy:GetLocalPlayerId() == ForceSummonBlack_PlayerNo then
		print("私が強制ブラックプレイヤーです"); --EN:print("I am a forced black player");
		IsForceSummon = true;
		--proxy:EraseEventSpecialEffect_2( 10000 , 4005 );
		--proxy:SetEventSpecialEffect_2( 10000 , 4006 );
		--proxy:LuaCallStartPlus( 1065, 5, 828 );--SynchroInvalid_1065_ForBlack
	else		
		if proxy:IsClient() == false then
			print("私はホストプレイヤーです SoulLv:",proxy:GetLocalPlayerSoulLv()); --EN:print("I am the host player SoulLv:",proxy:GetLocalPlayerSoulLv());
			proxy:CustomLuaCallStart( 5459 , proxy:GetLocalPlayerSoulLv() );
			--ネットワークのロック --EN:--network lock
			--proxy:LockSession();
		end
	end
	
	--ボスゲージ表示 --EN:-- Boss gauge display
	--proxy:SetBossGauge( 10001 + param:GetPlayID() , 0 ,6030 );
	
	print("Check_Summon end");
end

--ホストからソウルLvをもらって特殊効果を付ける --EN:--Receive soul Lv from the host and add special effects
function ForceSummon_Balance(proxy,param)
	--処理するのは強制召還ゴーストだけでOKな筈なので・・・ --EN:--Since it should be OK to process only forced summon ghosts...
	if proxy:GetLocalPlayerId() == ForceSummonBlack_PlayerNo then
		print("ForceSummon_Balance begin");
		local hostSoulLv = param:GetParam2();
		local forceSoulLv = proxy:GetLocalPlayerSoulLv();
		--どちらもソウルLvが0じゃないなら --EN:--If neither Soul Lv is 0
		if hostSoulLv > 0 or forceSoulLv > 0 then
			print("hostSoulLv :",hostSoulLv,"forceSoulLv :",forceSoulLv);
			local LvRate = forceSoulLv - hostSoulLv;
			if LvRate <= 5 and LvRate >= 1 then
				print("Lv差 +5～+1"); --EN:print("Lv difference +5+1");
				proxy:SetEventSpecialEffect_2( 10000 , 5045 );
			elseif LvRate <= 0 and LvRate >= -5 then
			--レベル＋0～－5　　　　　5046 --EN:--Level +0 to -5 5046
				print("Lv差 +0～-5"); --EN:print("Level difference +0 to -5");
				proxy:SetEventSpecialEffect_2( 10000 , 5046 );
			elseif LvRate <= -6 and LvRate >= -10 then
			--レベル－6～－10　　　　5047 --EN:--Level -6 to -10 5047
				print("Lv差 -6～-10"); --EN:print("Level difference -6 to -10");
				proxy:SetEventSpecialEffect_2( 10000 , 5047 );
			elseif LvRate <= -11 then
			--レベル－11～　　　　　　 5048 --EN:--Level -11~ 5048
				print("Lv差 -11～"); --EN:print("Lv difference -11");
				proxy:SetEventSpecialEffect_2( 10000 , 5048 );
			else
				proxy:WARN("Lvマッチングが正常ではない可能性があります！"); --EN:proxy:WARN("Lv matching may not be normal!");
			end
		end		
		print("ForceSummon_Balance end");
	end
end


--ボス部屋に入ってから、ホストでブラックゴースト死亡の度に呼ばれる --EN:--After entering the boss room, called every time the black ghost dies in the host
function Check_BlackDead(proxy,param)
	print("Check_BlackDead begin");
	--ボス死亡イベント発行 --EN:-- Issue boss death event
	proxy:LuaCallStart( 5380, 2 );	
	print("Check_BlackDead end");
end

--ボス部屋に入ってから、ホストでブラックゴースト回線落ちの度に呼ばれる --EN:--After entering the boss room, called every time the black ghost line is lost at the host
function Check_LeavePlayer(proxy,param)
	print("Check_LeavePlayer begin");
	--強制召喚ブラックが既にいなければ --EN:--If there is no forced summon Black already
	if	ForceSummonBlack_PlayerNo < 0 then
		print("Check_LeavePlayer return end")
		return;
	end
	if proxy:IsBlackGhost() == true then
		print("Check_LeavePlayer return end")
		return;
	end
	--退出した人と強制召還ブラックのPlayerNoが一致した --EN:--The player number of the person who left and the forced summon black match
	if param:GetParam3() == ForceSummonBlack_PlayerNo then
		print("switch_npc Success!");
		switch_npc(proxy,param);
	else
		print("switch_npc Failed!");
	end
	print("Check_LeavePlayer end");
end

--ボス部屋に入ってから無責任退出した人が居るたびに呼ばれる --EN:--Called every time someone left the boss room irresponsibly
function Check_LeavePlayer2(proxy,param)
	print("Check_LeavePlayer2 begin");
	--強制召喚ブラックが既にいなければ --EN:--If there is no forced summon Black already
	if	ForceSummonBlack_PlayerNo < 0 then
		print("Check_LeavePlayer2 return end")
		return;
	end
	
	if proxy:IsBlackGhost() == true then
		print("Check_LeavePlayer return end")
		return;
	end
	
	--退出した人と強制召還ブラックのPlayerNoが一致した --EN:--The player number of the person who left and the forced summon black match
	if param:GetParam3() == ForceSummonBlack_PlayerNo then
		print("switch_npc Success!");
		switch_npc(proxy,param);
	else
		print("switch_npc Failed!");
	end
	print("Check_LeavePlayer2 end");
end

--ボス部屋に入ってから、ホストでブラックゴースト退出の度に呼ばれる --EN:--After entering the boss room, called every time the black ghost leaves the host
function Check_Leave(proxy,param)
	print("Check_Leave begin");
	--強制召喚ブラックが既にいなければ --EN:--If there is no forced summon Black already
	if	ForceSummonBlack_PlayerNo < 0 then
		print("Check_Leave return end")
		return;
	end
	
	if proxy:IsBlackGhost() == true then
		print("Check_LeavePlayer return end")
		return;
	end
	
	switch_npc(proxy,param);
	print("Check_Leave end");
end

--PCが抜けていった時に、代わりにNPCを出現させる処理 --EN:--Processing to make NPC appear instead when PC leaves
function switch_npc(proxy,param)
	--まだボスを倒してないので！ --EN:--Because I haven't beaten the boss yet!
	if proxy:IsCompleteEvent( 5380 ) ==false then
	
		local npc_dead_list	 = {1100};--追加するNPCブラックの死亡監視アクションIDリスト --EN:--Additional NPC Black death watch action ID list
		local npc_black_list = {1081};--出現しているNPCブラックのチェックリスト --EN:--Spawning NPC Black checklist
		local npc_evid_list  = { 828};--出現するNPCのイベントIDリスト --EN:--Event ID list of appearing NPCs
	
		proxy:LuaCallStartPlus( 1065, 2420, 828 );
		proxy:LuaCallStartPlus( 1065, 2, 828 );--SynchroValid_1065
	
		--強制召喚ブラックがいなくなるので初期化 --EN:--Initialize because forced summon black disappears
		ForceSummonBlack_PlayerNo = -1;
		
		proxy:SetBossGauge( 828 , 0 ,6030 );
		
		--ネットワークのロック --EN:--network lock
		--proxy:LockSession();
	
		print("switch_npc index = ", index);
	end
end





function SynchroValid_1065( proxy,param)
	print("SynchroValid_1065 begin");
	local chrId = param:GetParam3();
	print( "Valid to ", chrId );
	
	--(2008.08.17 17:13 hk-itoyuta)
	--無駄な登録を増やしたくなかったので一先ずここで切り替え --EN:--I didn't want to increase unnecessary registrations, so I switched here for the time being
	--処理が増えそうなら1つLuaCallを切って、そこでまとめる --EN:--If the amount of processing seems to increase, cut off one LuaCall and put it together there
	--if	chrId == 828 then
		--ボスゲージを消しておく --EN:--Clear the boss gauge
		--proxy:ClearBossGauge();
		
		--ボスゲージ表示 --EN:-- Boss gauge display
		--proxy:SetBossGauge( chrId , 0 ,6030 );
	--end
	if proxy:IsBlackGhost() == false then
		ValidCharactor( proxy , chrId );--キャラクタ有効化	 --EN:--Character enable
		proxy:PlayAnimation( chrId, 6100 );
	end
	print("SynchroValid_1065 end");
end

function SynchroValid_NoAnim_1065( proxy,param)
	print("SynchroValid_NoAnim_1065 begin");
	print( "Valid to ",param:GetParam3() );
	if proxy:IsBlackGhost() == false then
		ValidCharactor( proxy , param:GetParam3() );--キャラクタ有効化	 --EN:--Character enable
	end
	print("SynchroValid_NoAnim_1065 end");
end

function SynchroInvalid_1065( proxy,param)
	print("SynchroInvalid_1065 begin");
	print( "Invalid to ",param:GetParam3() );
	InvalidCharactor( proxy , param:GetParam3() );--キャラクタ無効化	 --EN:--disable character
	print("SynchroInvalid_1065 end");
end

function SynchroInvalid_1065_ForBlack( proxy,param )
	print("SynchroInvalid_1065_ForBlack begin");
	print( "Invalid to ",param:GetParam3() );
	InvalidCharactor( proxy , param:GetParam3() );--キャラクタ無効化 --EN:--disable character
	--強制召喚されたプレイヤのIDを覚えておく --EN:-- Remember the ID of the forced summoned player
	ForceSummonBlack_PlayerNo = param:GetPlayID();
	print("SynchroInvalid_1065_ForBlack end");
end

function SynchroWarp_1065(proxy,param)
	print("SynchroWarp_1065  Chr is <",param:GetParam3(),">   Warp to <", param:GetParam2(),">");
	proxy:Warp( param:GetParam3(), param:GetParam2() );
end

--ボス部屋イベント登録 --EN:--Boss room event registration
--Call(5454, 2)
function DoorRegist(proxy,param)
	print("DoorRegist begin");
		--ソロのときは一度目にボス部屋に入る用のイベントを毎回登録させたいので、対応するフラグをOFFにする。 --EN:-- When soloing, we want to register the event for entering the boss room for the first time every time, so turn off the corresponding flag.
		SingleReset(proxy, 1031);
	
		--▽同期アニメ再生用の開始ハンドラ(旋回→歩き) --EN:--▽ Start handler for synchronous animation playback (turning → walking)
		proxy:LuaCall( 1032, 1, "OnEvent_1032_1", everytime );
		
		--▽2回目以降にボス部屋に入るためのイベント配信用 --EN:--▽For event delivery to enter the boss room after the second time
		proxy:LuaCall( 1032 , 5 , "OnEvent_1031_GO_TO_IN" , everytime );
		
		--▽フラグセット(同期用) --EN:--▽flag set (for synchronization)
		proxy:LuaCall( 1032 , 6 , "OnEvent_1031_flag_set" , everytime );
		
		--▽強制召還ドーピング用 --EN:--▽ For forced summon doping
		proxy:LuaCall( 1032 , 7 , "OnEvent_1031_Doping" , everytime );
		
		--誰かがボス前扉をまだ通過していない --EN:--Someone hasn't passed through the boss front door yet
		if proxy:IsCompleteEvent( 1031 ) == false then
		
			--(セッション中に)ボス前の魔法壁を最初に通れるのは生存の人だけ --EN:--(During the session) Only survivors can pass through the magic wall in front of the boss first
			local possible_chr_type = ATTR_HOST + ATTR_LIVE + ATTR_GREY;
			
			proxy:NotNetMessage_begin();
				--▼1031▼扉が開いているときに中に入るためのイベントを追加▼ --EN:--▼1031▼Add an event to enter when the door is open▼
				proxy:OnPlayerActionInRegionAttribute( 1031, 2893, "OnEvent_1031", HELPID_GO_TO_IN, possible_chr_type, everytime );
			proxy:NotNetMessage_end();
		
		else --グレイゴーストできたときようにいると思われる。 --EN:--Gray ghost seems to be like that when it's done.
		
			proxy:NotNetMessage_begin();
				--▼1032▼扉が開いているときに中に入るためのイベントを追加▼ --EN:--▼1032▼Add an event to enter when the door is open▼
				proxy:OnPlayerActionInRegion( 1032, 2893, "OnEvent_1031", HELPID_GO_TO_IN, everytime );--ハンドラは上と同じ --EN:--handler is the same as above
			proxy:NotNetMessage_end();
		
		end
	print("DoorRegist end");
end


--強制召喚、及び関連ハンドラ登録 --EN:-- Forced summons and related handler registration
--Call(5455, 2)
function ForceSummonStart(proxy,param)
	print("ForceSummonStart begin");
		if	proxy:IsClient() == false then
			proxy:NotNetMessage_begin();
				--途中からオンラインになったことも考えて、ハンドラだけは登録しておく --EN:--Register only the handler, considering that it went online in the middle
				--強制召喚ブラックゴーストが死んだ --EN:-- Forced Summon Black Ghost died
				proxy:LuaCall( 4042, 5, "Check_BlackDead",		everytime );		
				
				
				if	proxy:IsOnline() == true then
					proxy:OnKeyTime2( 1032, "OnEvent_1032_4", 2.0, 0, 4, once );
					proxy:OnKeyTime2( 1090, "OnEvent_1090", ForceSummonTimeOut, 0, 2, once );
				else
					proxy:OnKeyTime2( 1090, "OnEvent_1090",   0.0, 0, 2, once );
					--ポリ劇再生 --EN:--Poly play
					proxy:LuaCallStart( 1030, 2 );
				end
			proxy:NotNetMessage_end();
		end
	print("ForceSummonStart end");
end


function OnEvent_5456(proxy,param)
	print("OnEvent_5456 begin");
	--この時点でクライアントなら　シングル --EN:--At this point, if the client is single
	if	proxy:IsClient() == false then
		--キャラタイプが生存orグレイなら強制召還をスタート --EN:--If the character type is survival or gray, start forced summoning
		if proxy:IsGreyGhost() == true or proxy:IsLivePlayer() == true then
			proxy:LuaCallStart( 5455, 2 );
		end
	end
	print("OnEvent_5456 end");
end

------------------------------------------------------------------------------------------------------------------
--■5457■強制召喚されたキャラが、ボス戦途中から参加したキャラに対して自分がボスだと教える --EN:-- ■ 5457 ■ A character who is forcibly summoned tells a character who participates in the middle of the boss battle that he is the boss.
------------------------------------------------------------------------------------------------------------------
--LuaCallParam(5457,3,通知する対象のplayerNo) --EN:--LuaCallParam(5457,3,playerNo to notify)
function ForceSummonInfo(proxy,param)
	print("ForceSummonInfo begin");
	--自分宛のメッセージか？ --EN:--Is this a message for you?
	if	param:GetParam3() == proxy:GetLocalPlayerId() then
		--ボスゲージ表示 --EN:-- Boss gauge display
		--proxy:SetBossGauge( 10001 + param:GetPlayID() , 0 ,6030 );
	end
	print("ForceSummonInfo end");
end


--LuaCallParam(4041,1or2or3)
function Check_AfterSummon(proxy,param)
	print("Check_AfterSummon begin");
	--強制召喚されたブラックか？ --EN:--Is it black who was summoned forcibly?
	if	proxy:GetTempSummonParam() > 0 then
		proxy:LuaCallStartPlus( 5457, 3, param:GetPlayID() );
	end
	print("Check_AfterSummon end");
end


function startFloatSoulArrow(proxy,param)
	print("startFloatSoulArrow begin");
	
	local set_param = proxy:DivideRest( param:GetParam3() + 1, 2 );
	proxy:NotNetMessage_begin();
		--■5458■浮遊するソウルの矢発射をキックする■ --EN:-- ■ 5458 ■ Kick the floating soul arrow ■
		proxy:OnKeyTime2( 5458, "startFloatSoulArrow", GetReloadTime(proxy), 0, set_param, once );
	proxy:NotNetMessage_end();
	
	--浮遊するソウルの矢発射 --EN:--Fire arrows of floating souls
	--local cast_target = proxy:GetHostPlayerNo();
	--local cast_target = proxy:GetPlayerId_Random();
	
	--ボスを調べる --EN:--examine the boss
	local BossId = -1;
	if	ForceSummonBlack_PlayerNo == -1 then
		BossId = 828;
	else
		BossId = 10001 + ForceSummonBlack_PlayerNo;
	end	

	--強制召喚プレイヤの情報があれば	 --EN:--If there is information about the forced summon player
	local cast_target = proxy:GetEnemyPlayerId_Random(CHR_TYPE_BlackGhost);
	print("targetPlayerNo = ",cast_target);	
	proxy:CustomLuaCallStartPlus( 5458, BossId, 10001+cast_target );
	
	print("startFloatSoulArrow end");
end


--LuaCallparam(5458,Owner,target)
function FloatingSoulArrow(proxy,param)
	print("FloatingSoulArrow begin");
	local Owner		= param:GetParam2();
	local target	= param:GetParam3();
	local cast_magicId = -1;
	local hpRate = proxy:GetHpRate(Owner);
	print("HpRate = ",hpRate);
	if hpRate <= 0.75 then cast_magicId = 5203; end
	if hpRate <= 0.60 then cast_magicId = 5202; end
	if hpRate <= 0.45 then cast_magicId = 5201; end
	if hpRate <= 0.30 then cast_magicId = 5200; end
	if hpRate > 0.0 and cast_magicId ~= -1 then
		--proxy:CastTargetSpellPlus( Owner, Owner, -1, target, cast_magicId,1011 );
		proxy:CastTargetSpellPlus( Owner, Owner, 38, target, cast_magicId,1011 );
	end
	print("FloatingSoulArrow end");
end


FloatingSoulArrow_Reload_Low	=  7.0;
FloatingSoulArrow_Reload_High	= 11.0;
--[[------------------------------------------------------------------------------------
--■リロード時間取得ハンドラ■ --EN:-- ■ Reload time acquisition handler ■
--定数で指定してある最大値・最小値間でランダムの小数を計算し返す。 --EN:--Calculate and return a random decimal between the maximum and minimum values specified by the constant.
--------------------------------------------------------------------------------------]]
--■リロード時間取得ハンドラ --EN:-- ■ Reload time acquisition handler
function GetReloadTime(proxy)
	--ランダムの小数を取得する為、1000でかけたり割ったりしてます。 --EN:--In order to get a random decimal, we multiply and divide by 1000.
	local Low  = FloatingSoulArrow_Reload_Low * 1000;
	local High = FloatingSoulArrow_Reload_High * 1000;
	local rand = proxy:GetRandom( Low, High ) / 1000;
	print("Reload", rand);
	return rand;
end


------------------------------------------------------------------------------------------------------------------
--■1033■ボスBGM再生 --EN:-- ■ 1033 ■ Boss BGM playback
------------------------------------------------------------------------------------------------------------------
function OnEvent_1033(proxy,param)
	print("OnEvent_1033 begin");
	if proxy:IsClient() == false then
		proxy:CustomLuaCallStart( 1033 , ForceSummonBlack_PlayerNo ); 
	end	
	print("OnEvent_1033 end");
end

function OnEvent_1033_0(proxy,param)
	print("OnEvent_1033_0 begin");	
	if proxy:IsBlackGhost() == true then
		proxy:LuaCallStart( 1033 , 100 );
		proxy:EraseEventSpecialEffect_2( 10000 , 4006 );
		proxy:SetEventSpecialEffect_2( 10000 , 4006 );		
	end
	proxy:LuaCallStart( 1033 , 0);
	print("OnEvent_1033_0 end");
end

function OnEvent_1033_2(proxy,param)
	print("OnEvent_1033_2 begin");
	local player = param:GetPlayID();
	print("player = ",player);	
	--まだ覚えれてなくて、-1以外の値が来たら記憶 --EN:--If you haven't remembered yet and you get a value other than -1, remember it
	ForceSummonBlack_PlayerNo = player;	
	if ForceSummonBlack_PlayerNo ~= -1 then
		print("特殊効果を設定!　ForceSummonBlack_PlayerNo = ",ForceSummonBlack_PlayerNo); --EN:print("Set special effects! ForceSummonBlack_PlayerNo = ",ForceSummonBlack_PlayerNo);
		--特殊効果を設定		 --EN:--Set special effects
		--proxy:EraseEventSpecialEffect_2( 10000 , 4005 );
		--proxy:SetEventSpecialEffect_2( ForceSummonBlack_PlayerNo+10001 , 4006 );	
	end	
	print("OnEvent_1033_2 end");
end

function OnEvent_1033_1(proxy,param)
	if proxy:IsCompleteEvent( 1033 ) == false then	
		print("OnEvent_1033_1 begin");
		--BGM再生 --EN:--BGM playback
		proxy:PlayPointSE( 2410, SOUND_TYPE_M, 40200000, 2 );
		--■5458■浮遊するソウルの矢発射をキックする■ --EN:-- ■ 5458 ■ Kick the floating soul arrow ■
		if	proxy:IsClient() == false then
			proxy:NotNetMessage_begin();
				proxy:OnKeyTime2( 5458, "startFloatSoulArrow", 2.0, 0, 2, once );
			proxy:NotNetMessage_end();
		end
		
		if	ForceSummonBlack_PlayerNo == -1 then		
			--ボスゲージ表示 --EN:-- Boss gauge display
			proxy:SetBossGauge( 828 , 0 ,6030 );			
		else
			proxy:SetBossGauge( 10001 + ForceSummonBlack_PlayerNo , 0 ,6030 );
		end
		
		print("OnEvent_1033_1 end");
	end
end
