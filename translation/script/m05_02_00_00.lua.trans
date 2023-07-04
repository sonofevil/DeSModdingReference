
--血沼効果の発生周期パラメータ --EN:-- Blood swamp effect occurrence cycle parameter
BloodCycle_low		= 1.00;	--血沼効果の周期(最長) --EN:--Blood swamp effect cycle (longest)
BloodCycle_High		= 1.01;	--血沼効果の周期(最短) --EN:--blood swamp effect cycle (shortest)

IsInBloodArea		= false;--血沼に入っているか？ --EN:--Are you in the blood swamp?



--------------------------------------------------------------------------------------
--マップ読み込み時に読まれる初期化処理■ --EN:--Initialization process read when reading the map ■
--------------------------------------------------------------------------------------
function Initialize_m05_02_00_00(proxy)
	print("Initialize_m05_02_00_00 begin");
-----------------------------------------------------------------------------------------
--ボス関連 --EN:--Boss related
-----------------------------------------------------------------------------------------
--■5888■エリアボス死亡■ --EN:-- ■ 5888 ■ Area Boss Death ■
	proxy:AddFieldInsFilter( 824 );
	if proxy:IsCompleteEvent( 5888 ) ==false then
		proxy:OnCharacterDead(5888, 824, "OnEvent_5888", once);
	else
		proxy:SetEventFlag( 7299 , 1 ); --石柱のアクションIDをON --EN:--Turn on the action ID of the stone pillar
	end

--■5889■中ボス死亡監視■ --EN:-- ■ 5889 ■ Middle Boss Death Watch ■
	if proxy:IsCompleteEvent( 5889 ) == false then
		--会話からの呼び出しではなくなった --EN:-- no longer calls from conversations
		--proxy:LuaCall(5889, 0, "OnEvent_5889", once);
		proxy:OnCharacterDead(5889, 824, "OnEvent_5889", once);
	end

--■1031■ボス部屋に入る■ --EN:-- ■ 1031 ■ Enter the boss room ■
	
	--中ボスが生きているときだけイベント登録 --EN:-- Event registration only when the mid-boss is alive
	if proxy:IsCompleteEvent( 5889 ) == false then
	
		--ソロのときは一度目にボス部屋に入る用のイベントを毎回登録させたいので、対応するフラグをOFFにする。 --EN:-- When soloing, we want to register the event for entering the boss room for the first time every time, so turn off the corresponding flag.
		SingleReset(proxy, 1031);
	
		--▽同期アニメ再生用の開始ハンドラ(旋回→歩き) --EN:--▽ Start handler for synchronous animation playback (turning → walking)
		proxy:LuaCall( 1032, 1, "OnEvent_1032_1", everytime );
		
		--▽2回目以降にボス部屋に入るためのイベント配信用 --EN:--▽For event delivery to enter the boss room after the second time
		proxy:LuaCall( 1032 , 5 , "OnEvent_1031_GO_TO_IN" , everytime );
		
		--▽フラグセット(同期用) --EN:--▽flag set (for synchronization)
		proxy:LuaCall( 1032 , 6 , "OnEvent_1031_flag_set" , everytime );
		
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

	end

	
--■1033■ボス戦闘開始■	 --EN:-- ■ 1033 ■ Boss battle begins ■
	if proxy:IsCompleteEvent( 5889 ) == false then
		proxy:OnRegionJustIn( 1033 , 10000 , 2885 , "OnEvent_1033" , once );
	end	

--■1030■エリアボスポリ劇再生■ --EN:-- ■ 1030 ■ Area Bospoli play playback ■
	if proxy:IsCompleteEvent( 1030 ) == false then
	
		proxy:OnRegionJustIn( 1030 , 10000 , 2897 , "OnEvent_1030" , once );
	
		--ポリ劇開始フェード後に呼ばれるハンドラ --EN:--Handler called after polyplay start fade
		proxy:LuaCall(1030,REMO_START,"OnEvent_1030_RemoStart",once);
		--ポリ劇終了後に呼ばれるハンドラ --EN:--Handler called after the polyplay ends
		proxy:LuaCall(1030,REMO_FINISH,"OnEvent_1030_RemoFinish",once);

	end

--■ボス関連の初期化処理 --EN:--■ Boss-related initialization processing
	if proxy:IsCompleteEvent( 5889 ) ==true then
		--▽ボス死んでいるとき --EN:--▽When the boss is dead
		
		--ボスいなくなる --EN:--boss disappears
		InvalidBackRead( proxy , 824 );
		
		--魔法壁消える --EN:--Magic wall disappears
		proxy:SetColiEnable( 1997 , false );
		proxy:SetDrawEnable( 1997 , false );
		--魔法壁のSFX OFF --EN:--Magic Wall SFX OFF
		proxy:InvalidSfx( 1989 , false );

		--ホストプレイヤーのみアイテム入手イベントに使用 --EN:--Used for item acquisition event only for host players
		local possible_chr_type = ATTR_HOST + ATTR_LIVE + ATTR_GREY;
		
		--宝死体(ソウル?)有効化 --EN:--Treasure corpse (soul?) activation
		proxy:SetDrawEnable( 1980 , true );
		proxy:SetColiEnable( 1980 , true );
		proxy:TreasureDispModeChange2( 1980 , true ,KANAME_SFX);--光らせる --EN:-- let it shine
		--ソウルに刺さった剣有効化 --EN:--Activation of the sword stuck in the soul
		proxy:SetDrawEnable( 1977 , true );
		proxy:SetColiEnable( 1977 , true );
		--proxy:TreasureDispModeChange2( 1977 , true ,KANAME_SFX);--光らせる --EN:-- let it shine
		
		--▼(ソウル)アイテム取得用イベント監視追加▼ --EN:--▼ (Soul) Added event monitoring for item acquisition▼
		if proxy:IsCompleteEvent( 5893 ) == false then
			--SFX有効化 --EN:--SFX enable
			proxy:ValidSfx( 2401 );--要石のオーラ --EN:--Keystone Aura
			proxy:ValidSfx( 2402 );--光の粒子 --EN:--Particles of light
			
			proxy:OnDistanceActionAttribute( 5893 , 10000 , 1980 , "OnEvent_5893" , WarpGimmickDist_A , 10010180 , 0 , 180 , possible_chr_type, once );
		else
			--SFXが消える --EN:--SFX disappear
			proxy:InvalidSfx( 2401 , false );--要石のオーラ --EN:--Keystone Aura
			--proxy:InvalidSfx( 2402 , false );--光の粒子 --EN:--Particles of light
			--▼要石でワープ用の監視を追加▼ --EN:--▼ Added surveillance for warp with keystone ▼
			SingleReset(proxy,5895);
			proxy:OnDistanceActionAttribute( 5895 , 10000 , 1980 , "OnEvent_5895" , WarpGimmickDist_A , HELPID_GO_TO_SEKITYUU , 0 , 180 , ATTR_NOSESSION , everytime );
		end
		--------------------------------------
	else
		--▽ボスが生きている --EN:--▽Boss is alive
		proxy:EnableLogic( 824 , false );--ロジックOFFで待機 --EN:--Wait with logic OFF
		
		--宝死体(ソウル?) --EN:--Treasure Corpse (Soul?)
		proxy:SetDrawEnable( 1980 , false );
		proxy:SetColiEnable( 1980 , false );
		--ソウルに刺さった剣無効化 --EN:--Nullify the sword stuck in the soul
		proxy:SetDrawEnable( 1977 , false );
		proxy:SetColiEnable( 1977 , false );		
		
		--SFXが消える --EN:--SFX disappear
		proxy:InvalidSfx( 2401 , false );--要石のオーラ --EN:--Keystone Aura
		proxy:InvalidSfx( 2402 , false );--光の粒子 --EN:--Particles of light
		
		--光の壁Sfxを有効化 --EN:--Enable Light Wall Sfx
		proxy:ValidSfx( 1989 );
	end
	
-----------------------------------------------------------------------------------------
--ギミック関連 --EN:--Gimmick related
-----------------------------------------------------------------------------------------
--■1040■はしご１　降りる■ --EN:-- ■ 1040 ■ Get off the ladder 1 ■
	--▼PCがイベントエリア(2410)の中に居て、反応角度(LadderAngle_A)でアクションボタンを押したとき▼-- --EN:--▼When the PC is in the event area (2410) and presses the action button with the reaction angle (LadderAngle_A)▼--
	proxy:OnActionEventRegion( 1040, 2410, "OnEvent_1040", LadderAngle_A, HELPID_DOWN, everytime );
--■1041■はしご１　昇る■ --EN:-- ■ 1041 ■ Ladder 1 Climb ■
	--▼PCがイベントエリア(2411)の中に居て、反応角度(LadderAngle_A)でアクションボタンを押したとき▼-- --EN:--▼When the PC is in the event area (2411) and presses the action button with the reaction angle (LadderAngle_A)▼--
	proxy:OnActionEventRegion( 1041, 2411, "OnEvent_1041", LadderAngle_A, HELPID_UP, everytime );
	
	
--■1042■はしご２　降りる■ --EN:-- ■ 1042 ■ descend ladder 2 ■
	--▼PCがイベントエリア(2412)の中に居て、反応角度(LadderAngle_A)でアクションボタンを押したとき▼-- --EN:--▼When the PC is in the event area (2412) and presses the action button with the reaction angle (LadderAngle_A)▼--
	proxy:OnActionEventRegion( 1042, 2412, "OnEvent_1042", LadderAngle_A, HELPID_DOWN, everytime );
--■1043■はしご２　昇る■ --EN:-- ■ 1043 ■ Ladder 2 Climb ■
	--▼PCがイベントエリア(2413)の中に居て、反応角度(LadderAngle_A)でアクションボタンを押したとき▼-- --EN:--▼When the PC is in the event area (2413) and presses the action button with the reaction angle (LadderAngle_A)▼--
	proxy:OnActionEventRegion( 1043, 2413, "OnEvent_1043", LadderAngle_A, HELPID_UP, everytime );


	
--[[発動条件不明のためコメントアウト --EN:--[[Commented out because the activation conditions are unknown

--■1050■エリアボスが浄化されるポリ劇再生■ --EN:--■ 1050 ■ Poly drama replay where the area boss is purified ■
	if proxy:IsCompleteEvent( 1050 ) == false then
	
	--	proxy:OnRegionJustIn( 1050 , 10000 , 2000 , "OnEvent_1050" , once );
	
		--ポリ劇開始フェード後に呼ばれるハンドラ --EN:--Handler called after polyplay start fade
		proxy:LuaCall(1050,REMO_START,"OnEvent_1050_RemoStart",once);
		--ポリ劇終了後に呼ばれるハンドラ --EN:--Handler called after the polyplay ends
		proxy:LuaCall(1050,REMO_FINISH,"OnEvent_1050_RemoFinish",once);

	end
]]


--■??■徘徊デーモンの登場■ハンドラ登録 --EN:--■??■Appearance of wandering daemon■Handler registration
	proxy:NotNetMessage_begin();
		--プレイヤーがソロで死亡した時にキックされます。 --EN:--Kicked when a player dies solo.
		proxy:LuaCall( 4000, 100, "PlayerDeath_m05_02_00_00", everytime );
		--プレイヤーが復活した時にキックされます。 --EN:--Kicked when the player is revived.
		proxy:LuaCall( 4032, 100, "PlayerRevive_m05_02_00_00", everytime );
	proxy:NotNetMessage_end();

	--落下死体領域監視追加 --EN:-- Added Falling Corpse Area Monitoring
	if proxy:IsCompleteEvent( 1060 ) == false then
		proxy:OnRegionJustIn( 1060, 10000, 2450, "OnEvent_1060", once );
		proxy:ChangeModel( 1440, 1 );
	else
		proxy:SetColiEnable( 1440, false );
		proxy:SetDrawEnable( 1440, false );
	end
	
	if proxy:IsCompleteEvent( 1080 ) == false then
		proxy:OnRegionJustIn( 1080, 10000, 2451, "OnEvent_1080", once );
		proxy:ChangeModel( 1450, 1 );
	else
		proxy:SetColiEnable( 1450, false );
		proxy:SetDrawEnable( 1450, false );
	end
	
	if proxy:IsCompleteEvent( 1081 ) == false then
		proxy:OnRegionJustIn( 1081, 10000, 2451, "OnEvent_1081", once );
		proxy:ChangeModel( 1451, 1 );
	else
		proxy:SetColiEnable( 1451, false );
		proxy:SetDrawEnable( 1451, false );
	end
	
	if proxy:IsCompleteEvent( 1082 ) == false then
		proxy:OnRegionJustIn( 1082, 10000, 2452, "OnEvent_1082", once );
		proxy:ChangeModel( 1452, 1 );
	else
		proxy:SetColiEnable( 1452, false );
		proxy:SetDrawEnable( 1452, false );
	end
	
	if proxy:IsCompleteEvent( 1083 ) == false then
		proxy:OnRegionJustIn( 1083, 10000, 2452, "OnEvent_1083", once );
		proxy:ChangeModel( 1453, 1 );
	else
		proxy:SetColiEnable( 1453, false );
		proxy:SetDrawEnable( 1453, false );
	end
	
	--■1090■毒沼 --EN:-- ■ 1090 ■ Poison Swamp
	proxy:SetEventFlag( 1090, false );
	proxy:NotNetMessage_begin();
		proxy:OnRegistFunc( 1090, "Condition_1090", "dummy", 2, once );
	proxy:NotNetMessage_end();

	proxy:LuaCall( 1069, 2, "OnEvent_1061_1069_call", everytime );


	--ジェネレータOn --EN:--Generator On
	if proxy:IsCompleteEvent( 5889 ) == false then
		proxy:EnableGeneratorSystem(2420,true);
		proxy:EnableGeneratorSystem(2421,true);
		proxy:EnableGeneratorSystem(2422,true);
		proxy:EnableGeneratorSystem(2423,true);
		proxy:EnableGeneratorSystem(2424,true);
		proxy:EnableGeneratorSystem(2425,true);
		proxy:EnableGeneratorSystem(2426,true);
		proxy:EnableGeneratorSystem(2427,true);
		proxy:EnableGeneratorSystem(2428,true);
		proxy:EnableGeneratorSystem(2429,true);
		proxy:EnableGeneratorSystem(2430,true);
		proxy:EnableGeneratorSystem(2431,true);
	end
	
--■1120～1129■リーブラの子供達のターゲット強制変更■ --EN:--■ 1120-1129 ■ Forced change of targets for Libra's children ■
	RegistLibraJr_Target(proxy);
	
	
--■8087■不浄へ来たフラグを立てる■ --EN:-- ■ 8087 ■ Raise a flag that came to unclean ■
	proxy:SetEventFlag( 8087, true );

-----------------------------------------------------------------------------------------
--NPC関連 --EN:--NPC related
-----------------------------------------------------------------------------------------
	----------------------------------------------------------------------
	--リーブラ関連 --EN:-- Libra related
	----------------------------------------------------------------------
	--m05_02_00_00_eventboss.luaに記載 --EN:--listed in m05_02_00_00_eventboss.lua
	----------------------------------------------------------------------
	--ガル・ゴールドラン関連 --EN:--Gal Gold Run related
	----------------------------------------------------------------------
	--m05_02_00_00_eventboss.lua記載 --EN:--m05_02_00_00_eventboss.lua description

--~ --■15500■乱入アイテム取得監視■ハンドラはグローバルに定義 --EN:-- ■ 15500 ■ Intrusion item acquisition monitoring ■ Handlers are defined globally
--~ 	if proxy:IsCompleteEvent( 15500 ) == false then
--~ 		proxy:AddCorpseEvent( 15500 , 460 );--ガルゴールドラン --EN:-- Gargold Run
--~ 	end

-----------------------------------------------------------------------------------------	
--■999999■フレーム遅れの初期化処理イベントを発行■ --EN:-- ■ 999999 ■ Generate a frame delay initialization processing event ■
-----------------------------------------------------------------------------------------
	proxy:NotNetMessage_begin();
		--▼0秒後▼-- --EN:--▼After 0 seconds▼--
		proxy:OnKeyTime2( 999995, "Second_Initialize_m05_02_00_00", 0.0, 0, 0, once );	
	proxy:NotNetMessage_end();	
	
	print("Initialize_m05_02_00_00 end");
end


--------------------------------------------------------------------------------------
--Initializeから呼ばれる、1フレーム遅れの初期化処理■999999 --EN:--Initialization with a delay of 1 frame, called from Initialize ■999999
--------------------------------------------------------------------------------------
--■999999■一部、Initでは処理できないので、残しておく --EN:-- ■ 999999 ■ Some parts cannot be processed by Init, so leave them
function Second_Initialize_m05_02_00_00(proxy, param)
	print("Second_Initialize_m05_02_00_00 begin");

--------------------------------▽▽▽QWCイベント関連▽▽▽-------------------------------- --EN:--▽▽▽QWC event related ▽▽▽--------------------------------
--------------------------------△△△QWCイベント関連△△△-------------------------------- --EN:--△△△QWC event related△△△--------------------------------

	print("Second_Initialize_m05_02_00_00 end");
end





function OnEvent_1060(proxy,param)
	print("OnEvent_1060 begin");
	--■1061～1069■落下死体2～10 --EN:--■1061～1069 ■Falling corpses 2～10
	if proxy:IsLivePlayer() == true or proxy:IsGreyGhost() == true then
		local IsAdd = false;
		for index = 1, 9, 1 do
			local evid = 1061 + index - 1;
			if proxy:IsCompleteEvent(evid) == false then
				proxy:ChangeModel( 1441 + index - 1, 1 );
				if IsAdd == false then
					local wait = proxy:GetRandom( M52_Corpse_FallWait_Low * 1000, M52_Corpse_FallWait_High * 1000 ) / 1000;
					proxy:OnKeyTime2( evid, "OnEvent_1061_1069", wait, 0, index, once );
					IsAdd = true;
				end
			else
				proxy:SetColiEnable( 1441 + index - 1, false );
				proxy:SetDrawEnable( 1441 + index - 1, false );
			end
		end
	end
	
	proxy:ChangeModel( 1440, 0 );
	proxy:SetEventFlag( param:GetParam1(), true );
	print("OnEvent_1060 end");
end

function OnEvent_1061_1069(proxy,param)
	print("OnEvent_1061_1069 begin");

	proxy:LuaCallStartPlus( 1069, 2, param:GetParam3() );
	
	--最後まで実行されたら --EN:--when it runs to the end
	if param:GetParam1() == 1069 then
		return;
	end
	
	local wait = proxy:GetRandom(M52_Corpse_FallWait_Low * 1000, M52_Corpse_FallWait_High * 1000 ) / 1000;
	proxy:OnKeyTime2( param:GetParam1() + 1, "OnEvent_1061_1069", wait, 0, param:GetParam3() + 1, once );
	
	print("OnEvent_1061_1069 end");
end

function OnEvent_1061_1069_call(proxy,param)
	print("OnEvent_1061_1069_call begin");
	
	--オブジェをハボックに戻して落下させる --EN:--Return the object to Havoc and let it fall
	proxy:ChangeModel( 1441 + param:GetParam3() - 1, 0 );
	
	--オブジェをハボックに戻す --EN:-- Return the object to Havoc
	proxy:SetEventFlag( 1061 + param:GetParam3() - 1, true );
	
	print("OnEvent_1061_1069_call end");
end



function OnEvent_1080(proxy,param)
	print("OnEvent_1080 begin");
	proxy:ChangeModel( 1440, 0 );
	proxy:SetEventFlag( param:GetParam1(), true );
	print("OnEvent_1080 end");
end
function OnEvent_1081(proxy,param)
	print("OnEvent_1081 begin");
	proxy:ChangeModel( 1441, 0 );
	proxy:SetEventFlag( param:GetParam1(), true );
	print("OnEvent_1081 end");
end
function OnEvent_1082(proxy,param)
	print("OnEvent_1082 begin");
	proxy:ChangeModel( 1442, 0 );
	proxy:SetEventFlag( param:GetParam1(), true );
	print("OnEvent_1082 end");
end
function OnEvent_1083(proxy,param)
	print("OnEvent_1083 begin");
	proxy:ChangeModel( 1443, 0 );
	proxy:SetEventFlag( param:GetParam1(), true );
	print("OnEvent_1083 end");
end



--------------------------------------------------------------------------------------
--■5888■エリアボス死亡■ --EN:-- ■ 5888 ■ Area Boss Death ■
--------------------------------------------------------------------------------------
--■5888■エリアボス死亡■ --EN:-- ■ 5888 ■ Area Boss Death ■
function OnEvent_5888(proxy, param)
	print("OnEvent_5888 begin");

	proxy:SetEventFlag( 5888, 1 );
	
	proxy:SetEventFlag( 7299, 1 );--石柱のアクションフラグON --EN:--Stone pillar action flag ON
	
	print("OnEvent_5888 end");
end


--------------------------------------------------------------------------------------
--徘徊デーモンの登場■?? --EN:-- Appearance of the Wandering Demon ??
--------------------------------------------------------------------------------------

--▼グローバルの死亡監視から呼ばれる(ソロ) --EN:--▼ Called from global death watch (solo)
function PlayerDeath_m05_02_00_00(proxy, param)
	print("PlayerDeath_m05_02_00_00");
	
--	LuaFunc_VisibleTheWanderingDemon(proxy, param, demon_id_list_m05_02_00_00);
--	proxy:SetEventFlag( 20 , 1 );--フラグは仮、指定があれば変える。 --EN:The -- flag is tentative, and will be changed if specified.
	
	print("PlayerDeath_m05_02_00_00");
end

--▼グローバルの血文字復活から呼ばれる(ソロ) --EN:--▼Called from global blood letter revival (solo)
function PlayerRevive_m05_02_00_00(proxy,param)
	print("PlayerRevive_m05_02_00_00");
	
--	LuaFunc_InvisibleTheWanderingDemon(proxy, param, demon_id_list_m05_02_00_00);
--	proxy:SetEventFlag( 20 , 0 );--フラグは仮、指定があれば変える。 --EN:The -- flag is tentative, and will be changed if specified.
	
	print("PlayerRevive_m05_02_00_00");
end
--------------------------------------------------------------------------------------
--■1030■エリアボスポリ劇再生■ --EN:-- ■ 1030 ■ Area Bospoli play playback ■
--------------------------------------------------------------------------------------

function OnEvent_1030(proxy , param)
	print("OnEvent_1030 begin");

	--▼エリアボスポリ劇再生 --EN:--▼Area Bospoli play
	proxy:RequestRemo(50200,REMO_FLAG,1030,1);
	proxy:SetEventFlag( 1030, true );
	
	print("OnEvent_1030 end");
end


--■ポリ劇再生開始(フェード終了) --EN:--■ Start of polyplay playback (end of fade)
function OnEvent_1030_RemoStart(proxy,param)
	print("OnEvent_1030_RemoStart begin");
	print("OnEvent_1030_RemoStart end");
end


--■ポリ劇再生終了(フェード終了) --EN:-- End of polyplay playback (end of fade)
function OnEvent_1030_RemoFinish(proxy , param)
	print("OnEvent_1030_RemoFinish begin");
	print("OnEvent_1030_RemoFinish end");
end




--------------------------------------------------------------------------------------
--■1050■エリアボスが浄化されるポリ劇再生■ --EN:--■ 1050 ■ Poly drama replay where the area boss is purified ■
--------------------------------------------------------------------------------------

function OnEvent_1050(proxy , param)
	print("OnEvent_1050 begin");

	--▼エリアボスが浄化されるポリ劇再生 --EN:--▼Polyplay where the area boss is purified
	proxy:RequestRemo(50201,REMO_FLAG,1050,1);
	proxy:SetEventFlag( 1050, true );
	
	print("OnEvent_1050 end");
end


--■ポリ劇再生開始(フェード終了) --EN:--■ Start of polyplay playback (end of fade)
function OnEvent_1050_RemoStart(proxy,param)
	print("OnEvent_1050_RemoStart begin");	
	print("OnEvent_1050_RemoStart end");
end


--■ポリ劇再生終了(フェード終了) --EN:-- End of polyplay playback (end of fade)
function OnEvent_1050_RemoFinish(proxy , param)
	print("OnEvent_1050_RemoFinish begin");
	print("OnEvent_1050_RemoFinish end");
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
		proxy:LuaCallStart( 1032 , 6 );--フラグセット(同期用) --EN:--flag set (for synchronization)
		local eneidlist = {	824,651,530,531,532,533,534,535,536,537,538,
							545,546,551,552,558,559,563,564,565,572,573,
							574,575,576,581,582,583,584,585,586,587,588,
							589,590,591,592,593,594,595,596,597,598,599};
		local num = table.getn(eneidlist);
		for index = 1, num , 1 do
			Lua_MultiDoping(proxy,eneidlist[index] );--マルチプレイドーピング --EN:-- Multiplayer Doping
		end
	end

	--プレイヤーが扉の中に完全にはいったタイミングで、ボスの思考をリセット --EN:--Reset the boss' thoughts when the player is completely inside the door
	--場所が悪いとプレイヤーを見つけれないため(攻撃してこない) --EN:--Because you can't find the player if the location is bad (they won't attack)
	if proxy:IsLivePlayer() == true or proxy:IsGreyGhost() == true then
		proxy:ResetThink( 824 );
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



--------------------------------------------------------------------------------------
--ボスが動き出す(戦闘開始)■1033 --EN:--Boss begins to move (battle begins) 1033
--------------------------------------------------------------------------------------

function OnEvent_1033(proxy, param)
	print("OnEvent_1033 begin");
	
	--ボス戦用BGM再生開始 --EN:--Start playing BGM for boss battle
	proxy:PlayPointSE( 2400, SOUND_TYPE_M, 50200000, 2 );
	
	proxy:EnableLogic( 824, true );
	
	--読み込みタイミングのとき毎回追加されてほしいのでフラグたてない --EN:-- I want it to be added every time at the time of reading, so I don't set a flag
	
	--ボスゲージ表示 --EN:-- Boss gauge display
	proxy:SetBossGauge(824, 0, 6040);
	
	LuaFunc_ForceOmission(proxy,460);
	LuaFunc_ForceOmission(proxy,651);
	LuaFunc_ForceOmission(proxy,824);
	print("OnEvent_1033 end");
end

--------------------------------------------------------------------------------------
--■5889■中ボス死亡時■ --EN:-- ■ 5889 ■ When the middle boss dies ■
--------------------------------------------------------------------------------------
--■5889■中ボス死亡時■ --EN:-- ■ 5889 ■ When the middle boss dies ■
function OnEvent_5889(proxy, param)
	print("OnEvent_5889 begin");

	--リーブラの子供ジェネレータOFF --EN:-- Libra's Child Generator OFF
	proxy:EnableGeneratorSystem(2420,false);
	proxy:EnableGeneratorSystem(2421,false);
	proxy:EnableGeneratorSystem(2422,false);
	proxy:EnableGeneratorSystem(2423,false);
	proxy:EnableGeneratorSystem(2424,false);
	proxy:EnableGeneratorSystem(2425,false);
	proxy:EnableGeneratorSystem(2426,false);
	proxy:EnableGeneratorSystem(2427,false);
	proxy:EnableGeneratorSystem(2428,false);
	proxy:EnableGeneratorSystem(2429,false);
	proxy:EnableGeneratorSystem(2430,false);
	proxy:EnableGeneratorSystem(2431,false);
	--ジェネレータ関連のフラグ(必要ないけど、立てないとバグ報告されちゃうので) --EN:-- Generator-related flags (not necessary, but bugs will be reported if you don't set them)
	proxy:SetEventFlag( 1050, true );
	proxy:SetEventFlag( 1051, true );
	
	proxy:NotNetMessage_begin();
		--▼5889_1▼1秒経過▼ --EN:--▼5889_1▼1 second passed▼
		proxy:OnKeyTime2( 5889, "OnEvent_5889_1", 1, 0, 0, once);
		--▼5892▼2秒経過▼ --EN:--▼5892▼2 seconds passed▼
		proxy:OnKeyTime2( 5892, "OnEvent_5892", 2.0, 0, 2, once);
		--マルチ解散監視 --EN:--Multi-Dismissal Monitoring
		proxy:OnRegistFunc( 5889 , "Check_5889_PT","OnEvent_5889_PT",0,once);
	proxy:NotNetMessage_end();
	
	proxy:SetEventFlag( 5889, 1 );
	
	--ガルの状態を見て処理 --EN:--Look at Garu's state and process
	if proxy:IsCompleteEvent( GAL_STATE_LIVE ) == true then
		--やる気を無くす --EN:--disengage
		proxy:ResetThink( 651 );
		proxy:EnableLogic( 651 , false );
		--proxy:SetSpStayAndDamageAnimId( 651,8821,-1);
		proxy:SetEventCommand( 651 , 900 );
		--再度敵対 --EN:-- Hostile again
		proxy:NotNetMessage_begin();
			proxy:OnSimpleDamage( 1117 , 651 , 10000 , "OnEvent_1117",once);
		proxy:NotNetMessage_end();
	end	
	
	--新ブロッククリア処理へ --EN:--To new block clear processing
	proxy:CustomLuaCallStart( 4050, 824);
	--トカゲリセット --EN:-- lizard reset
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
	if proxy:IsLivePlayer() == true or proxy:IsGreyGhost() == true then	
		proxy:SetEventFlag(	8013, 1 );--クリアフラグON --EN:--Clear flag ON
	end
	
	print("OnEvent_5889 end");
end

--▲5889_1▲中ボス死亡後1秒▲ --EN:--▲5889_1▲1 second after death of mid-boss▲
function OnEvent_5889_1(proxy, param)
	print("OnEvent_5889_1 begin");
	
	--ボスを倒した数を更新(数によってフラグを立てる) --EN:--update number of bosses killed (flag by number)
	GetBossFlagCount( proxy, param );
	
	--▼トロフィー取得判定▼ --EN:--▼Trophy Acquisition Judgment▼
	Lua_RequestUnlockTrophy(proxy, 9);--トロフィの状況を判定し、取得 --EN:--Determine and retrieve trophy status
	
--アイテム入手関連------- --EN:--Item Acquisition Related-------
	
	--ホストプレイヤーのみアイテム入手イベントに使用 --EN:--Used for item acquisition event only for host players
	local possible_chr_type = ATTR_HOST + ATTR_LIVE + ATTR_GREY;

	--宝死体(ソウル?)有効化 --EN:--Treasure corpse (soul?) activation
	proxy:SetDrawEnable( 1980 , true );
	proxy:SetColiEnable( 1980 , true );
	--ソウルに刺さった剣有効化 --EN:--Activation of the sword stuck in the soul
	proxy:SetDrawEnable( 1977 , true );
	proxy:SetColiEnable( 1977 , true );
	
	--▼(ソウル)アイテム取得用イベント監視追加▼ --EN:--▼ (Soul) Added event monitoring for item acquisition▼
	if proxy:IsCompleteEvent( 5893 ) == false then
		--SFX有効化 --EN:--SFX enable
		proxy:ValidSfx( 2401 );--要石のオーラ --EN:--Keystone Aura
		proxy:ValidSfx( 2402 );--光の粒子 --EN:--Particles of light
		--ソウルと刺さっている剣を輝かせる --EN:--Glowing Soul and Stabbing Sword
		proxy:TreasureDispModeChange2( 1980 , true ,KANAME_SFX);--光らせる --EN:-- let it shine
		--proxy:TreasureDispModeChange2( 1977 , true ,KANAME_SFX);--光らせる --EN:-- let it shine
		proxy:OnDistanceActionAttribute( 5893 , 10000 , 1980 , "OnEvent_5893" , WarpGimmickDist_A , 10010180 , 0 , 180 , possible_chr_type, once );
	end

	--中ボス部屋前の移動処理イベントを削除 --EN:--Delete the movement processing event in front of the mid-boss room
	proxy:DeleteEvent( 1031 );--一人目が入るとき用 --EN:--For when the first person enters
	proxy:DeleteEvent( 1032 );--二人目以降が入るとき用 --EN:--For when the second and subsequent people enter
	proxy:DeleteEvent( 1033 );--ボス戦闘開始用 --EN:--For boss battle start
		
	print("OnEvent_5889_1 end");
end

--▼5892▼2秒経過▼-------------- --EN:--▼5892▼2 seconds passed▼-------------
function OnEvent_5892(proxy,param)
	print("OnEvent_5892 begin");
	
	--ボス戦用のBGM停止 --EN:--BGM stop for boss battles
	proxy:StopPointSE( 2 );
	
	proxy:SetEventFlag( 5892, true );
	print("OnEvent_5892 end");
end

--マルチ解散監視 --EN:--Multi-Dismissal Monitoring
function Check_5889_PT(proxy)
	if proxy:IsInParty() == false then
		return true;
	end
	return false;
end

--マルチじゃない --EN:--not multiplayer
function OnEvent_5889_PT(proxy,param)
	print("OnEvent_5889_PT begin");
	--中ボス部屋の前後の魔法壁が消える(全プレイヤー) --EN:--The magic walls before and after the mid-boss room disappear (all players)
	proxy:SetColiEnable( 1997 , false );
	proxy:SetDrawEnable( 1997 , false );
	
	--中ボス部屋魔法壁のSFX削除 --EN:--Remove the SFX of the mid-boss room magic wall
	proxy:InvalidSfx( 1989 , true );
	print("OnEvent_5889_PT end");
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


--------------------------------------------------------------------------------------
--■5893■ソウルアイテム入手■ --EN:-- ■ 5893 ■ soul item acquisition ■
--------------------------------------------------------------------------------------
function OnEvent_5893(proxy,param)
	print("OnEvent_5893 begin");
	
	--プレイヤーの同期アニメーション(true:パーティープレイヤーがアニメーションした) --EN:--Player synchronous animation (true: party player animated)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_PICK ) == true then--新しいアニメ  --EN:-- new anime
		print("OnEvent_5893 end");
		return true;
	end
	
	proxy:NotNetMessage_begin();
		--0.0秒後にアイテム取得イベントを発行 --EN:-- Issue an item acquisition event after 0.0 seconds
		proxy:OnKeyTime2( 5893, "OnEvent_5893_1", 0.0, 0, 0, once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_5893 end");
end

--■5893_1■アイテム取得■ --EN:-- ■ 5893_1 ■ item acquisition ■
function OnEvent_5893_1(proxy, param)
	print("OnEvent_5893_1 begin");

	--アイテム取得関数 --EN:--Item acquisition function
	proxy:GetRateItem(10452);--パラメータ10452参照 --EN:-- See parameter 10452
	proxy:GetRateItem(10478);--パラメータ10478参照 --EN:--see parameter 10478
	proxy:GetRateItem(10479);--パラメータ10479参照 --EN:--see parameter 10479
	proxy:GetRateItem(10480);--パラメータ10480参照 --EN:--see parameter 10480
	proxy:GetRateItem(10481);--パラメータ10481参照 --EN:-- See parameter 10481
	
	--アイテムを取得済み --EN:--item already acquired
	proxy:SetEventFlag( 5893, 1 );
	
	--宝シェーダーOFF --EN:--Treasure Shader OFF
	--proxy:TreasureDispModeChange( 1980 , false );--光らせるのをやめる --EN:-- stop glowing
	
	--SFXが消える --EN:--SFX disappear
	proxy:InvalidSfx( 2401 , true );--要石のオーラ --EN:--Keystone Aura
	--proxy:InvalidSfx( 2402 , true );--光の粒子	 --EN:--Particles of light
	
	if proxy:IsCompleteEvent( 8035 ) == false then
		proxy:NotNetMessage_begin();
			--瞬間で表示するとメニューが先に出るので待つ --EN:--If you display it instantly, the menu will appear first, so wait
			proxy:OnKeyTime2( 8035 , "OnEvent_8035_wait",0.5 , 0 , 1, once);			
		proxy:NotNetMessage_end();
	else
		--▼要石でワープ用の監視を追加▼ --EN:--▼ Added surveillance for warp with keystone ▼
		proxy:OnDistanceActionAttribute( 5895 , 10000 , 1980 , "OnEvent_5895" , WarpGimmickDist_A , HELPID_GO_TO_SEKITYUU , 0 , 180 , ATTR_NOSESSION , everytime );
	end	
	print("OnEvent_5893_1 end");
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
		OnEvent_8050(proxy,param);
		proxy:SetEventFlag( 8035 , true );
	proxy:NotNetMessage_end();
	--▼要石でワープ用の監視を追加▼	 --EN:--▼ Added surveillance for warp with keystone ▼
	proxy:OnDistanceActionAttribute( 5895 , 10000 , 1980 , "OnEvent_5895" , WarpGimmickDist_A , HELPID_GO_TO_SEKITYUU , 0 , 180 , ATTR_NOSESSION , everytime );
	print("OnEvent_8035 end");
end



--------------------------------------------------------------------------------------
--石柱にワープ■5895 --EN:-- Warp to stone pillar 5895
--------------------------------------------------------------------------------------
--■5895石柱にワープ■ --EN:--■Warp to 5895 stone pillar■
function OnEvent_5895(proxy,param)
	print("OnEvent_5895 begin");
	
	if proxy:IsCompleteEvent( 5895 ) == true then
		return;
	end
	
	proxy:RepeatMessage_begin();
		--▼5895_1▼選択メニューの監視▼ --EN:--▼5895_1▼Monitor selection menu▼
		proxy:OnSelectMenu(5895, "OnEvent_5895_0", 10010710, 0, 2, 1980, 2, once);
	proxy:RepeatMessage_end();
	
	print("OnEvent_5895 end");
end

--▲5895_0▲選択メニューの監視▲ --EN:--▲5895_0▲Monitor selection menu▲
function OnEvent_5895_0(proxy,param)	
	print("OnEvent_5895_0 begin");
	
	if proxy:IsSession() == false then
		
		proxy:PlayAnimation(10000,8283);
		proxy:NoAnimeTurnCharactor( 10000 , 1980 ,TURNSKIP_ANGLE);
		
		proxy:NotNetMessage_begin();
			proxy:OnChrAnimEnd(5895, 10000, 8283, "OnEvent_5895_1", once );
		proxy:NotNetMessage_end();
		
		proxy:SetEventFlag(5895,true);
	else
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010720, 0, 6, 1983, GEN_DIALOG_DIST, once );
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
	end
	
	print("OnEvent_5895_0 end");
end

--▲5895_1▲選択メニューの監視▲ --EN:--▲5895_1▲Monitor selection menu▲
function OnEvent_5895_1(proxy,param)	
	print("OnEvent_5895_1 begin");
	
	proxy:SetEventFlag(5895,false);
	
	proxy:PlayAnimation( 10000, 8284 );

	proxy:SetEventFlag(5895,true);
	
	OnEvent_5895_2(proxy, param);
	
	print("OnEvent_5895_1 end");
end

--▲5895_2▲選択メニューの監視▲ --EN:--▲5895_2▲Monitor selection menu▲
function OnEvent_5895_2(proxy,param)
	print("OnEvent_5895_2 begin");
	
	--石柱へ戻ってきた判定のフラグを立てる --EN:--Flag the judgment of returning to the stone pillar
	proxy:SetEventFlag(8083, true);
	
	proxy:SetEventFlag(5895,false);
	--完全回復要求 --EN:-- full recovery request
	proxy:RequestFullRecover();
	proxy:WarpNextStage( 1, 0, 0, 0, 1009 );
	
	print("OnEvent_5895_2 end");
end





--------------------------------------------------------------------------------------
--ハシゴ --EN:--ladder
--------------------------------------------------------------------------------------
function OnEvent_1040(proxy,param)
	print("OnEvent_1040 begin");
	if param:IsNetMessage() == true then
		print("IsNetMessage true");
		print("OnEvent_1040 end");
		return;
	end

	--はしご降りに必要な前処理-- --EN:--Pretreatment required for descending the ladder--
	proxy:BeginAction(10000,2,2,2);				--ホバー移動モードに移行 --EN:--Transition to hover movement mode
	proxy:HoverMoveValDmy(10000,1430,192,LadderTime_A);--移動位置(192)に0.5秒でホバー移動 --EN:--Hover to move position (192) in 0.5 seconds
	proxy:SetEventCommand(10000,1);				--イベントコマンドID(1)"ハシゴ上から掴"むを送る --EN:-- Send event command ID (1) "Grab from the top of the ladder"
	proxy:SetKeepCommandIndex(10000, 0, 1, 3.0 );
	proxy:DisableMove(10000, true);					--キャラクタを移動、旋回不能に --EN:--Move the character, make it impossible to turn
	
	proxy:NotNetMessage_begin();
		--0.5秒(ホバー移動終了)後にはしご降りスタートイベントを発行 --EN:-- Issue a ladder descend start event after 0.5 seconds (end of hover movement)
		proxy:OnKeyTime2(1040,"OnEvent_1040_1",LadderTime_A,0,0,once);
		--はしご降り専用の関数を3秒間発行(カメラの周り込みなどの処理) --EN:--Issue a function dedicated to descending the ladder for 3 seconds (processing such as surrounding the camera)
		proxy:OnKeyTime2(1040,"LadderDown",3.0,1,1,once);
	proxy:NotNetMessage_end();
	
	print("OnEvent_1040 end");
end

function OnEvent_1040_1(proxy,param)
	print("OnEvent_1040_1 begin");
	if proxy:GetEventMode(10000) == 0 then
		print("Local Player GetEventMode 0");
		print("OnEvent_1040_1 end");
		return;
	end

	--ハシゴアクションモードに移行-- --EN:--Transition to ladder action mode--
	--nMax  : はしごの段数 - 補正値(補正値はおおよそ3) --EN:--nMax : number of ladder steps - correction value (correction value is approximately 3)
	--nStart: 降りるとき→(nMax + 1) 昇るとき→(-1) --EN:--nStart: When going down→(nMax + 1) When going up→(-1)
	--nMax   = 段数(14) - 補正値(3) = 11 --EN:--nMax = number of stages (14) - correction value (3) = 11
	--nStart = nMax(11) + 降りるとき(1) = 12 --EN:--nStart = nMax(11) + when getting off(1) = 12
	proxy:BeginAction(10000,1,7,6);
	
	--キャラクタを移動、旋回可能に-- --EN:--Character can be moved and turned--
	proxy:DisableMove(10000,0);
	
	print("OnEvent_1040_1 end");
end

function OnEvent_1041(proxy,param)
	print("OnEvent_1041 begin");
	if param:IsNetMessage() == true then
		print("IsNetMessage true");
		print("OnEvent_543 end");
		return;
	end

	--はしご降りに必要な前処理-- --EN:--Pretreatment required for descending the ladder--
	proxy:BeginAction(10000,2,-1,1);			--ホバー移動モードに移行 --EN:--Transition to hover movement mode
	proxy:HoverMoveValDmy(10000,1430,191,LadderTime_A);--移動位置(191)に0.5秒でホバー移動 --EN:--Hover to move position (191) in 0.5 seconds
	proxy:SetEventCommand(10000,0);				--イベントコマンドID(0)"ハシゴ下から掴"むを送る --EN:-- Send event command ID (0) "grab from under the ladder"
	proxy:SetKeepCommandIndex(10000, 0, 1, 3.0 );
	proxy:DisableMove(10000,1);					--キャラクタを移動、旋回不能に --EN:--Move the character, make it impossible to turn
	
	proxy:NotNetMessage_begin();
		--0.5秒(ホバー移動終了)後にはしご降りスタートイベントを発行 --EN:-- Issue a ladder descend start event after 0.5 seconds (end of hover movement)
		proxy:OnKeyTime2(1041,"OnEvent_1041_1",LadderTime_A,0,0,once);
		--はしご降り専用の関数を3秒間発行(カメラの周り込みなどの処理) --EN:--Issue a function dedicated to descending the ladder for 3 seconds (processing such as surrounding the camera)
		proxy:OnKeyTime2(1041,"LadderDown",3.0,1,1,once);
	proxy:NotNetMessage_end();
	print("OnEvent_1041 end");
end

function OnEvent_1041_1(proxy,param)
	print("OnEvent_1041_1 begin");
	if proxy:GetEventMode(10000) == 0 then
		print("Local Player GetEventMode 0");
		print("OnEvent_1041_1 end");
		return;
	end

	--ハシゴアクションモードに移行-- --EN:--Transition to ladder action mode--
	--nMax  : はしごの段数 - 補正値(補正値はおおよそ3) --EN:--nMax : number of ladder steps - correction value (correction value is approximately 3)
	--nStart: 降りるとき→(nMax + 1) 昇るとき→(-1) --EN:--nStart: When going down→(nMax + 1) When going up→(-1)
	--nMax   = 段数(14) - 補正値(3) = 11 --EN:--nMax = number of stages (14) - correction value (3) = 11
	--nStart = 昇るとき(-1) = -1 --EN:--nStart = when rising (-1) = -1
	proxy:BeginAction(10000,1,-1,6);
	
	--キャラクタを移動、旋回可能に-- --EN:--Character can be moved and turned--
	proxy:DisableMove(10000,0);
	
	print("OnEvent_1041_1 end");
end




function OnEvent_1042(proxy,param)
	print("OnEvent_1042 begin");
	if param:IsNetMessage() == true then
		print("IsNetMessage true");
		print("OnEvent_1042 end");
		return;
	end

	--はしご降りに必要な前処理-- --EN:--Pretreatment required for descending the ladder--
	proxy:BeginAction(10000,2,2,2);				--ホバー移動モードに移行 --EN:--Transition to hover movement mode
	proxy:HoverMoveValDmy(10000,1431,192,LadderTime_A);--移動位置(192)に0.5秒でホバー移動 --EN:--Hover to move position (192) in 0.5 seconds
	proxy:SetEventCommand(10000,1);				--イベントコマンドID(1)"ハシゴ上から掴"むを送る --EN:-- Send event command ID (1) "Grab from the top of the ladder"
	proxy:SetKeepCommandIndex(10000, 0, 1, 3.0 );
	proxy:DisableMove(10000, true);					--キャラクタを移動、旋回不能に --EN:--Move the character, make it impossible to turn
	
	proxy:NotNetMessage_begin();
		--0.5秒(ホバー移動終了)後にはしご降りスタートイベントを発行 --EN:-- Issue a ladder descend start event after 0.5 seconds (end of hover movement)
		proxy:OnKeyTime2(1042,"OnEvent_1042_1",LadderTime_A,0,0,once);
		--はしご降り専用の関数を3秒間発行(カメラの周り込みなどの処理) --EN:--Issue a function dedicated to descending the ladder for 3 seconds (processing such as surrounding the camera)
		proxy:OnKeyTime2(1042,"LadderDown",3.0,1,1,once);
	proxy:NotNetMessage_end();
	
	print("OnEvent_1042 end");
end

function OnEvent_1042_1(proxy,param)
	print("OnEvent_1042_1 begin");
	if proxy:GetEventMode(10000) == 0 then
		print("Local Player GetEventMode 0");
		print("OnEvent_1042_1 end");
		return;
	end

	--ハシゴアクションモードに移行-- --EN:--Transition to ladder action mode--
	--nMax  : はしごの段数 - 補正値(補正値はおおよそ3) --EN:--nMax : number of ladder steps - correction value (correction value is approximately 3)
	--nStart: 降りるとき→(nMax + 1) 昇るとき→(-1) --EN:--nStart: When going down→(nMax + 1) When going up→(-1)
	--nMax   = 段数(14) - 補正値(3) = 11 --EN:--nMax = number of stages (14) - correction value (3) = 11
	--nStart = nMax(11) + 降りるとき(1) = 12 --EN:--nStart = nMax(11) + when getting off(1) = 12
	proxy:BeginAction(10000,1,11,10);
	
	--キャラクタを移動、旋回可能に-- --EN:--Character can be moved and turned--
	proxy:DisableMove(10000,0);
	
	print("OnEvent_1042_1 end");
end

function OnEvent_1043(proxy,param)
	print("OnEvent_1043 begin");
	if param:IsNetMessage() == true then
		print("IsNetMessage true");
		print("OnEvent_1043 end");
		return;
	end

	--はしご降りに必要な前処理-- --EN:--Pretreatment required for descending the ladder--
	proxy:BeginAction(10000,2,-1,1);			--ホバー移動モードに移行 --EN:--Transition to hover movement mode
	proxy:HoverMoveValDmy(10000,1431,191,LadderTime_A);--移動位置(191)に0.5秒でホバー移動 --EN:--Hover to move position (191) in 0.5 seconds
	proxy:SetEventCommand(10000,0);				--イベントコマンドID(0)"ハシゴ下から掴"むを送る --EN:-- Send event command ID (0) "grab from under the ladder"
	proxy:SetKeepCommandIndex(10000, 0, 1, 3.0 );
	proxy:DisableMove(10000,1);					--キャラクタを移動、旋回不能に --EN:--Move the character, make it impossible to turn
	
	proxy:NotNetMessage_begin();
		--0.5秒(ホバー移動終了)後にはしご降りスタートイベントを発行 --EN:-- Issue a ladder descend start event after 0.5 seconds (end of hover movement)
		proxy:OnKeyTime2(1043,"OnEvent_1043_1",LadderTime_A,0,0,once);
		--はしご降り専用の関数を3秒間発行(カメラの周り込みなどの処理) --EN:--Issue a function dedicated to descending the ladder for 3 seconds (processing such as surrounding the camera)
		proxy:OnKeyTime2(1043,"LadderDown",3.0,1,1,once);
	proxy:NotNetMessage_end();
	print("OnEvent_1043 end");
end

function OnEvent_1043_1(proxy,param)
	print("OnEvent_1043_1 begin");
	if proxy:GetEventMode(10000) == 0 then
		print("Local Player GetEventMode 0");
		print("OnEvent_1043_1 end");
		return;
	end

	--ハシゴアクションモードに移行-- --EN:--Transition to ladder action mode--
	--nMax  : はしごの段数 - 補正値(補正値はおおよそ3) --EN:--nMax : number of ladder steps - correction value (correction value is approximately 3)
	--nStart: 降りるとき→(nMax + 1) 昇るとき→(-1) --EN:--nStart: When going down→(nMax + 1) When going up→(-1)
	--nMax   = 段数(14) - 補正値(3) = 11 --EN:--nMax = number of stages (14) - correction value (3) = 11
	--nStart = 昇るとき(-1) = -1 --EN:--nStart = when rising (-1) = -1
	proxy:BeginAction(10000,1,-1,10);
	
	--キャラクタを移動、旋回可能に-- --EN:--Character can be moved and turned--
	proxy:DisableMove(10000,0);
	
	print("OnEvent_1043_1 end");
end


--------------------------------------------------------------------------------------
--■1090■毒沼■ --EN:-- ■ 1090 ■ Poison Swamp ■
--------------------------------------------------------------------------------------
--■1090■毒沼■ --EN:-- ■ 1090 ■ Poison Swamp ■
function Condition_1090(proxy,param)
	--床ダメージ用ポイントの各イベントID --EN:--Each event ID for floor damage points
	--2460,2461,2462
	local floorTbl = {2460,2461,2462};
	local tblnum = table.getn( floorTbl );
	IsInBloodArea = false;--とりあえず入ってない事に --EN:--For the time being, it's not included
	local ACID = 1090;
	
	
	for index = 1, tblnum, 1 do
		if proxy:IsRegionIn( 10000, floorTbl[index] ) == true then
			IsInBloodArea = true;
		end
	end
	
	
	--入った瞬間 --EN:--The moment you enter
	if proxy:IsCompleteEvent( ACID ) == false and
		IsInBloodArea == true then
		print("PoizonFloorDam JustIn", tblnum);
		proxy:SetEventSpecialEffect(10000, 10090);
		proxy:SetEventFlag( ACID, IsInBloodArea );
		proxy:NotNetMessage_begin();
			proxy:OnKeyTime2( 1091, "OnEvent_1091", 0.0, 0, 1, once );
		proxy:NotNetMessage_end();
	end
	
	--抜け出た瞬間 --EN:--The moment you escape
	if  proxy:IsCompleteEvent( ACID ) == true and
		IsInBloodArea == false then
		print("PoizonFloorDam JustOut", tblnum);
		proxy:EraseEventSpecialEffect(10000, 10090);
		proxy:SetEventFlag( ACID, IsInBloodArea );
		proxy:DeleteEvent(1091);
	end

	
	--絶対に結果を成立させないよ --EN:--I will never let the result come true
	return false;
end

function dummy(proxy,param)
end

function OnEvent_1091(proxy,param)
	print("OnEvent_1091 begin");
	local set_param = proxy:DivideRest( param:GetParam3() + 1, 2 );
	local reload = Lua_GetReloadTime(proxy,BloodCycle_low,BloodCycle_High);
	
	--継続的に入っている時のみ次の効果を設定できる --EN:--You can set the next effect only when you are in it continuously
	if IsInBloodArea == true then
		proxy:NotNetMessage_begin();
			proxy:OnKeyTime2( 1091, "OnEvent_1091", reload, 0, set_param, once );
		proxy:NotNetMessage_end();
	else
		--念の為重い歩き解除 --EN:--Release heavy walking just in case
		proxy:EraseEventSpecialEffect(10000, 10090);
	end
	
	proxy:SetEventSpecialEffect(10000, 10290);
	print("OnEvent_1091 end");
end



--■1120■リーブラの子供達のターゲット強制変更■ --EN:-- ■ 1120 ■ Forced change of targets for Libra's children ■
--誰が誰を狙っていたかを再現すると大変なことになるので、 --EN:--Reproducing who was targeting whom would be a big deal, so
--それぞれの世界でざっくりイベントを発動させることにします。(横山さんと相談済み) --EN:--I will roughly activate events in each world. (Consulted with Mr. Yokoyama)
function RegistLibraJr_Target(proxy)
	local evid_list = {  360,  361,  362,  363,  372,  373,  374,  375,  377,  391};
	local event_num = table.getn(evid_list);
	for index = 1, event_num, 1 do
		local evid = evid_list[index];
		proxy:NotNetMessage_begin();
			proxy:OnRegionJustIn( 1120, evid, 2470, "OnEvent_1120", once );
		proxy:NotNetMessage_end();
		
		--腐敗人にリーブラを狙わせる --EN:--Let the corrupt people target Libra
		proxy:SetEventTarget( evid_list[index], 824 );
	end
end



LibraJr_HideDistance		= 12.0;
function OnEvent_1120(proxy,param) 
	print("OnEvent_1120 begin");
	local evid = param:GetParam2();
	for JrId = 530, 599, 1 do
		if	proxy:IsDistance( JrId, evid, LibraJr_HideDistance ) == true then
			print( JrId.." Target to "..evid );
			proxy:ForceChangeTarget( JrId, evid);
		end
	end
	print("OnEvent_1120 end");
end




