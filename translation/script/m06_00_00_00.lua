
EVENT_TIME01 = 13.0;

SMITH_WORKING = 16090;--仕事中（通常） --EN:--At work (normal)
SMITH_ANGRY   = 16091;--敵対 --EN:--hostile
SMITH_DEAD    = 16092;--死亡 --EN:--death

SMITH_Flag_list ={
	SMITH_WORKING,
	SMITH_ANGRY,
	SMITH_DEAD,	
}

TOTALDAMAGE_SMITH = 30;--合計ダメージ --EN:--total damage

SHOP_NORMAL_1  = 16410;--坑道１で販売中 --EN:--Sold at Tunnel 1
SHOP_HOSTILE_1 = 16411;--坑道１で敵対 --EN:-- Hostile in Tunnel 1
SHOP_DEAD	 = 16412;--死亡 --EN:--death
SHOP_NORMAL_2 = 16413;--坑道２で販売中 --EN:--Sold at Tunnel 2
SHOP_HOSTILE_2 = 16411;--坑道２で敵対 --EN:-- Hostile in Tunnel 2

SHOP_Flag_list = {
	SHOP_NORMAL_1,
	SHOP_HOSTILE_1,
	SHOP_DEAD,
	SHOP_NORMAL_2,
	SHOP_HOSTILE_2,
}

SHOP_TOTALDAMAGE = 50;

FIREDOM_COUNT = 0;

FIREDOM_TIME = 0.1;
IS_FIREAREA = false;

OFFSET = -2;

--距離判定で使われる敵達 --EN:--Enemies used for distance judgment
DISTENELIST = {210,211,212,213,217,219,351,352};
IWAKOUFU_DIST = 1.4;



--------------------------------------------------------------------------------------
--マップ読み込み時に読まれる初期化処理■ --EN:--Initialization process read when reading the map ■
--------------------------------------------------------------------------------------
function Initialize_m06_00_00_00(proxy)
	print("Initialize_m06_00_00_00 begin");
	
	proxy:LuaCall( 99999 , 0 , "OnEvent_4000_Hp_1",everytime);
	
-----------------------------------------------------------------------------------------
--ボス関連 --EN:--Boss related
-----------------------------------------------------------------------------------------
--■111■ボス部屋に入る■ --EN:-- ■ 111 ■ Enter the boss room ■
	
	--中ボスが生きているときだけイベント登録 --EN:-- Event registration only when the mid-boss is alive
	if proxy:IsCompleteEvent( 6174 ) == false then	
	
		--ソロのときは一度目にボス部屋に入る用のイベントを毎回登録させたいので、対応するフラグをOFFにする。 --EN:-- When soloing, we want to register the event for entering the boss room for the first time every time, so turn off the corresponding flag.
		SingleReset(proxy, 111);
		SingleReset(proxy, 113);
		
		--▽同期アニメ再生用の開始ハンドラ(旋回→歩き) --EN:--▽ Start handler for synchronous animation playback (turning → walking)
		proxy:LuaCall( 112, 1, "OnEvent_112_1", everytime );
		--▽2回目以降にボス部屋に入るためのイベント配信用 --EN:--▽For event delivery to enter the boss room after the second time
		proxy:LuaCall( 112 , 5 , "OnEvent_111_GO_TO_IN" , everytime );
		--▽フラグセット(同期用) --EN:--▽flag set (for synchronization)
		proxy:LuaCall( 112 , 6 , "OnEvent_111_flag_set" , everytime );		
		--誰かがボス前扉をまだ通過していない --EN:--Someone hasn't passed through the boss front door yet
		if proxy:IsCompleteEvent( 111 ) == false then		
			--(セッション中に)ボス前の魔法壁を最初に通れるのは生存の人だけ --EN:--(During the session) Only survivors can pass through the magic wall in front of the boss first
			local possible_chr_type = ATTR_HOST + ATTR_LIVE + ATTR_GREY;			
			proxy:NotNetMessage_begin();
				--▼111▼扉が開いているときに中に入るためのイベントを追加▼ --EN:--▼111▼ Added an event to enter when the door is open▼
				proxy:OnPlayerActionInRegionAttribute( 111, 2895, "OnEvent_111", HELPID_GO_TO_IN, possible_chr_type, everytime );
			proxy:NotNetMessage_end();		
		else --グレイゴーストできたときようにいると思われる。		 --EN:--Gray ghost seems to be like that when it's done.
			proxy:NotNetMessage_begin();
				--▼112▼扉が開いているときに中に入るためのイベントを追加▼ --EN:--▼112▼ Added an event to enter when the door is open▼
				proxy:OnPlayerActionInRegion( 112, 2895, "OnEvent_111", HELPID_GO_TO_IN, everytime );--ハンドラは上と同じ --EN:--handler is the same as above
			proxy:NotNetMessage_end();		
		end
		proxy:SetColiEnableArray(3001,false);--通常無効 --EN:--usually disabled
		proxy:SetColiEnableArray(3002,false);--通常無効 --EN:--usually disabled
		proxy:SetColiEnableArray(3005,false);--通常無効 --EN:--usually disabled
		proxy:SetColiEnableArray(3006,false);--通常無効 --EN:--usually disabled
		proxy:SetColiEnableArray(3009,false);--通常無効 --EN:--usually disabled
		proxy:SetColiEnableArray(3010,false);--通常無効		 --EN:--usually disabled
		proxy:SetColiEnableArray(3003,true);--ボス用有効 --EN:--Valid for Boss
		proxy:SetColiEnableArray(3004,true);--ボス用有効 --EN:--Valid for Boss
		proxy:SetColiEnableArray(3007,true);--ボス用有効 --EN:--Valid for Boss
		proxy:SetColiEnableArray(3008,true);--ボス用有効 --EN:--Valid for Boss
		proxy:SetColiEnableArray(3011,true);--ボス用有効 --EN:--Valid for Boss
		proxy:SetColiEnableArray(3012,true);--ボス用有効 --EN:--Valid for Boss
	else
		proxy:SetColiEnableArray(3001,true);--通常有効 --EN:--usually valid
		proxy:SetColiEnableArray(3002,true);--通常有効 --EN:--usually valid
		proxy:SetColiEnableArray(3005,true);--通常有効 --EN:--usually valid
		proxy:SetColiEnableArray(3006,true);--通常有効 --EN:--usually valid
		proxy:SetColiEnableArray(3009,true);--通常有効 --EN:--usually valid
		proxy:SetColiEnableArray(3010,true);--通常有効		 --EN:--usually valid
		proxy:SetColiEnableArray(3003,false);--ボス用無効 --EN:--disabled for boss
		proxy:SetColiEnableArray(3004,false);--ボス用無効 --EN:--disabled for boss
		proxy:SetColiEnableArray(3007,false);--ボス用無効 --EN:--disabled for boss
		proxy:SetColiEnableArray(3008,false);--ボス用無効 --EN:--disabled for boss
		proxy:SetColiEnableArray(3011,false);--ボス用無効 --EN:--disabled for boss
		proxy:SetColiEnableArray(3012,false);--ボス用無効		 --EN:--disabled for boss
	end

	
--■113■ボス戦闘開始■	 --EN:-- ■ 113 ■ Boss battle begins ■
	if proxy:IsCompleteEvent( 6174 ) == false then
		--シングルロード時初期化 --EN:--Initialization at single load
		SingleReset( proxy , 113 );
		proxy:OnRegionJustIn( 113 , 10000 , 2887 , "OnEvent_113" , once );
	end

--■6174■中ボス死亡■ --EN:-- ■ 6174 ■ Mid-boss death ■
	proxy:AddFieldInsFilter( 810 );
	if proxy:IsCompleteEvent( 6174 ) == false then
		proxy:OnCharacterDead( 6174 , 810 , "OnEvent_6174" , once );	
	end

--■ボス関連の初期化処理 --EN:--■ Boss-related initialization processing
	if proxy:IsCompleteEvent( 6174 ) ==true then
		
		--▽ボス死んでいるとき --EN:--▽When the boss is dead
		--ボスいなくなる --EN:--boss disappears
		InvalidBackRead( proxy , 810 );
		
		proxy:SetEventFlag( 6175, 1 );
		
		--魔法壁消える --EN:--Magic wall disappears
		proxy:SetColiEnable( 1999 , false );
		proxy:SetColiEnable( 1995 , false );
	
		proxy:SetDrawEnable( 1999 , false );
		proxy:SetDrawEnable( 1995 , false );

		--魔法壁の SFX OFF --EN:--Magic Wall SFX OFF
		proxy:InvalidSfx( 1987 , false );
		proxy:InvalidSfx( 1991 , false );

		--ホストプレイヤーのみアイテム入手イベントに使用 --EN:--Used for item acquisition event only for host players
		local possible_chr_type = ATTR_HOST + ATTR_LIVE + ATTR_GREY;

		--宝死体(ソウル?)有効化 --EN:--Treasure corpse (soul?) activation
		proxy:SetDrawEnable( 1982 , true );
		proxy:SetColiEnable( 1982 , true );
		--宝死体(ソウル?)2有効化 --EN:--Treasure corpse (soul?) 2 enabled
		proxy:SetDrawEnable( 1975 , true );
		proxy:SetColiEnable( 1975 , true );
		
		proxy:TreasureDispModeChange2( 1982 , true ,KANAME_SFX);--光らせる --EN:-- let it shine
		--▼(ソウル)アイテム取得用イベント監視追加▼ --EN:--▼ (Soul) Added event monitoring for item acquisition▼
		if proxy:IsCompleteEvent( 6193 ) == false then
			--SFXON
			proxy:ValidSfx( 2131 );--光の粒子 --EN:--Particles of light
			proxy:ValidSfx( 2132 );--要石のオーラ --EN:--Keystone Aura
			proxy:TreasureDispModeChange2( 1982 , true ,KANAME_SFX);--光らせる --EN:-- let it shine
			proxy:OnDistanceActionAttribute( 6193 , 10000 , 1982 , "OnEvent_6193" , WarpGimmickDist_A , 10010180 , 0 , 180 , possible_chr_type, once );
		else
			--SFXが消える --EN:--SFX disappear
			proxy:InvalidSfx( 2131 , false );--光の粒子 --EN:--Particles of light
			--proxy:InvalidSfx( 2132 , false );--要石のオーラ --EN:--Keystone Aura
			--▼要石でワープ用の監視を追加▼ --EN:--▼ Added surveillance for warp with keystone ▼
			SingleReset(proxy,6194);
			proxy:OnDistanceActionAttribute( 6194 , 10000 , 1982 , "OnEvent_6194" , WarpGimmickDist_A , HELPID_GO_TO_SEKITYUU , 0 , 180 , ATTR_NOSESSION , everytime );
		end
		
	else
		--▽ボス生きているとき --EN:--▽ When the boss is alive
		
		proxy:EnableLogic( 810 , false );--ロジックOFFで待機 --EN:--Wait with logic OFF
		
		--宝(ソウル?) --EN:--Treasure (Soul?)
		proxy:SetDrawEnable( 1982 , false );
		proxy:SetColiEnable( 1982 , false );
		--宝(ソウル?)2 --EN:--Treasure (Soul?) 2
		proxy:SetDrawEnable( 1975 , false );
		proxy:SetColiEnable( 1975 , false );
		
		--SFXが消える --EN:--SFX disappear
		proxy:InvalidSfx( 2131 , false );--光の粒子 --EN:--Particles of light
		proxy:InvalidSfx( 2132 , false );--要石のオーラ --EN:--Keystone Aura
	end	

-----------------------------------------------------------------------------------------
--ギミック関連 --EN:--Gimmick related
-----------------------------------------------------------------------------------------
--■0■レバーで扉を開放する■ --EN:-- ■ 0 ■ Open the door with the lever ■
	if proxy:IsCompleteEvent(0) ==false then
	
		--扉開く配信用 --EN:--For door-open delivery
		proxy:LuaCall(0,1,"OnEvent_0_3_Net",once);				
		--ポリ劇配信用 --EN:--For poly drama distribution
		proxy:LuaCall(0,2,"OnEvent_0_4_Net",once);

		proxy:NotNetMessage_begin();
			--ポリ劇開始フェード後に呼ばれるハンドラ --EN:--Handler called after polyplay start fade
			proxy:LuaCall(0,REMO_START,"OnEvent_0_RemoStart",once);
			--ポリ劇終了後に呼ばれるハンドラ --EN:--Handler called after the polyplay ends
			proxy:LuaCall(0,REMO_FINISH,"OnEvent_0_RemoFinish",once);
		proxy:NotNetMessage_end();

		proxy:OnDistanceActionPlus( 0, 10000, 1000, "OnEvent_0", LeverDist_A, HELPID_PULL_LEVER, -90.0, LeverAngle_A, 1.8, 0.0, -0.6, once );
	else
		proxy:EndAnimation( 1000, 1);--レバーアニメ --EN:--lever animation
		proxy:EndAnimation( 1001, 1);--扉アニメ --EN:--door animation
		proxy:PlayAnimation( 1010 , 1 );--歯車が動くアニメ再生 --EN:--Play animation with moving gears
		proxy:PlayPointSE( 2014, SOUND_TYPE_O, 606150, 7 );--トロッコSE再生 --EN:--Trolley SE playback
	end
	
--■10■ハンドルAを回して歯車を動かす■ --EN:--■10■Turn the handle A to move the gear■
	proxy:SetIsAnimPauseOnRemoPlayForEvent(1003,true);
	if proxy:IsCompleteEvent(10) == false 		--まだハンドルを回していない　かつ --EN:-- haven't turned the handle yet and
	and proxy:IsCompleteEvent(13) == false then	--もう片方のハンドルでゴンドラが回っていない　ならば --EN:--If the gondola is not turning with the other handle
		--▼PCがOBJ(1002)に対して反応角度(30)、角度オフセット(-90)、距離(150)でアクションボタンを押す▼-- --EN:--▼PC pushes action button with response angle (30), angle offset (-90), distance (150) against OBJ (1002)▼--
		proxy:OnDistanceAction( 10, 10000, 1002, "OnEvent_10", HandleDist_A, HELPID_TURN_HANDLE, -90.0, HandleAngle_A, once );
	else
		proxy:EndAnimation( 1002, 1);--ハンドルアニメ --EN:--handle animation
	end
--■12■ハンドルA_2を回して歯車を動かす■ --EN:--■12■Turn the handle A_2 to move the gear■
	if proxy:IsCompleteEvent(12) == false 		--まだハンドルを回していない　かつ --EN:-- haven't turned the handle yet and
	and proxy:IsCompleteEvent(11) == false then	--もう片方のハンドルでゴンドラが回っていない　ならば --EN:--If the gondola is not turning with the other handle
		--▼PCがOBJ(1026)に対して反応角度(30)、角度オフセット(-90)、距離(150)でアクションボタンを押す▼-- --EN:--▼PC presses action button with response angle (30), angle offset (-90), distance (150) for OBJ (1026)▼--
		proxy:OnDistanceAction( 12, 10000, 1026, "OnEvent_12", HandleDist_A, HELPID_TURN_HANDLE, -90.0, HandleAngle_A, once );
	else
		proxy:EndAnimation( 1026, 1);--ハンドルアニメ --EN:--handle animation
	end
--■11,13■ハンドルが回った後の初期化■ --EN:-- ■ 11, 13 ■ Initialization after the steering wheel turns ■
	if proxy:IsCompleteEvent(11) == true 		--Aのせいでゴンドラが回っている　か --EN:--Is the gondola spinning because of A?
	or proxy:IsCompleteEvent(13) == true then	--A_2のせいでゴンドラが回っている　ならば --EN:--If the gondola is spinning because of A_2
		--すでにゴンドラが動いているので、初期化 --EN:--Because the gondola is already moving, initialize
		print("すでにゴンドラは作動済み！"); --EN:print("The gondola is already working!");
		proxy:PlayAnimation( 1003, 1 );	--歯車アニメ再生 --EN:--Gear animation playback
		--proxy:EndAnimation( 1003, 1);--歯車アニメ --EN:--gear animation
		if proxy:IsClient() == false then
			proxy:NotNetMessage_begin();
				proxy:OnObjAnimEndPlus(24 , 1003 , 1 , "OnEvent_24",once );
			proxy:NotNetMessage_end();
		end
		proxy:PlayPointSE( 2011, SOUND_TYPE_O, 606130, 4 );--ゴンドラSE再生 --EN:-- Gondola SE playback
	end
	--同期のアニメ配信 --EN:-- Synchronous animation distribution
	proxy:LuaCall( 24 , 0 , "OnEvent_24_call",everytime);	
	
		
--■20■ハンドルBを回して歯車を動かす■ --EN:--■20■Turn the handle B to move the gear■
	if proxy:IsCompleteEvent(20) ==false then
		
		--ポリ劇配信用 --EN:--For poly drama distribution
		proxy:LuaCall(22,0,"OnEvent_22",once);
		proxy:NotNetMessage_begin();
			--ポリ劇開始フェード後に呼ばれるハンドラ --EN:--Handler called after polyplay start fade
			proxy:LuaCall(20,REMO_START,"OnEvent_20_RemoStart",once);
			--ポリ劇終了後に呼ばれるハンドラ --EN:--Handler called after the polyplay ends
			proxy:LuaCall(20,REMO_FINISH,"OnEvent_20_RemoFinish",once);	
		proxy:NotNetMessage_end();
		proxy:OnDistanceAction( 20, 10000, 1004, "OnEvent_20", HandleDist_B, HELPID_TURN_HANDLE, -90.0, HandleAngle_B, once );
		proxy:OnRegionJustIn(128,10000,2026,"OnEvent_128",everytime);
		proxy:OnRegionJustOut(133,10000,2026,"OnEvent_133",everytime);

		local enemylist = {	200,201,202,203,204,205,206,207,208,209,
							210,211,212,213,214,215,216,217,218,219,
							220,221,222,
							350,351,352,
							396};
		local num = table.getn( enemylist );
		for index = 1 , num , 1 do
			proxy:OnRegionJustIn(50,enemylist[index],2026,"OnEvent_50",everytime);--param2でキャラを判定 --EN:Judge the character with --param2
			proxy:OnRegionJustOut(51,enemylist[index],2026,"OnEvent_51",everytime);--param2でキャラを判定 --EN:Judge the character with --param2
		end
		--proxy:PlayAnimation( 1005, 0 );--歯車アニメをループ再生 --EN:-- Loop gear animation
		proxy:PlayLoopAnimation( 1009, 2 );--水車(?)アニメをループ再生	 --EN:--Loop playback of water wheel(?) animation
	else
		proxy:EndAnimation( 1005 , 1 );--歯車アニメ再生 --EN:--Gear animation playback
		proxy:EndAnimation( 1004, 1);--ハンドルアニメ終了 --EN:--end handle animation
		proxy:SetDrawEnable( 1030, false );
		proxy:SetColiEnable( 1008, false );--透明オブジェの当たりを消す		 --EN:--Erase hits of transparent objects
	end

	--OBJ差し替え同期用 --EN:--For OBJ replacement synchronization
	if proxy:IsCompleteEvent(146) == false then
		--冷却岩床OFF --EN:--Cooling bed OFF
		proxy:SetColiEnable(1032,false);
		proxy:SetDrawEnable(1032,false);		
	else
		--マグマ床OFF --EN:--Magma floor OFF
		proxy:SetColiEnable(1031,false);
		proxy:SetDrawEnable(1031,false);
		proxy:SetColiEnableArray( 1033 , false );
		proxy:InvalidSfx( 2015 , false );
		proxy:InvalidSfx( 2046 ,false );
	end
	
	--SFX切り替え --EN:--SFX switching
	if proxy:IsCompleteEvent(147) == false then
		proxy:InvalidSfx(2043,false);		
	end
	
	--SFX切り替え --EN:--SFX switching
	if proxy:IsCompleteEvent(148) == false then
		proxy:InvalidSfx(2044,false);
	end
	
	--SE再生 --EN:-- SE playback
	if proxy:IsCompleteEvent(149) == false then
		proxy:PlayPointSE( 2045, SOUND_TYPE_A, 601000, 5 );
	else
		proxy:StopPointSE( 5 );
	end
	
--■60■ハシゴA降り■PCがイベントエリア(2005)の中に居て、アクションボタンを押したとき-- --EN:-- ■ 60 ■ Get off ladder A ■ When the PC is in the event area (2005) and presses the action button --
	--proxy:OnActionEventRegion(60, 2005, "OnEvent_60", LadderAngle_A, HELPID_DOWN, everytime);
--■61■ハシゴA昇り■PCがイベントエリア(2004)の中に居て、アクションボタンを押したとき-- --EN:-- ■ 61 ■ Climbing Ladder A ■ When the PC is in the event area (2004) and presses the action button --
	--proxy:OnActionEventRegion(61, 2004, "OnEvent_61", LadderAngle_A, HELPID_UP  , everytime);

--[[使用しなくなったのでコメントアウト(復活するかもしれない) --EN:--[[Commented out because it is no longer used (may come back)

--■70■レバーで下のハンドルを回せるようにする■ (現状はレバーのみ?) --EN:--■70■ Make it possible to turn the lower handle with the lever■ (currently only the lever?)
	if proxy:IsCompleteEvent( 70 ) ==false then
	--▼PCがイベントエリア(1015)の中に距離(1.5m)有効角(30度幅)でアクションボタンを押した --EN:--▼The PC presses the action button within the event area (1015) at a distance (1.5m) and an effective angle (30 degrees width).
		proxy:OnDistanceAction( 70, 10000, 1015, "OnEvent_70", LeverDist_A, HELPID_PULL_LEVER, 0, LeverAngle_A, once);
	else
	   proxy:EndAnimation( 1015, 1 );--レバーが動くアニメ --EN:--Animation of moving lever
	end
]]

--■6176■次ブロックへの移動ポリ劇(イベント70から連動)■ --EN:-- ■ 6176 ■ Moving police play to the next block (linked from event 70) ■
	--イベント70内で発行される --EN:--issued within event 70
	
--■80■ハンドルで歯車を回して擬似エレベーターにする■ --EN:--■80■Turn the gear with the handle to create a pseudo elevator■
	proxy:SetIsAnimPauseOnRemoPlayForEvent(1019,true);
	if proxy:IsCompleteEvent(80) ==false then
	--▼PCがOBJ(1016)に対して反応角度(30)、角度オフセット(-90)、距離(150)でアクションボタンを押す▼-- --EN:--▼PC presses action button with reaction angle (30), angle offset (-90), distance (150) against OBJ (1016)▼--
		proxy:OnDistanceAction( 80, 10000, 1016, "OnEvent_80", HandleDist_A, HELPID_TURN_HANDLE, -90.0, HandleAngle_A, once );
		proxy:LuaCall( 80 , 1 , "OnEvent_80_2",once);
	else
		proxy:EndAnimation( 1016, 1);--ハンドルアニメ --EN:--handle animation
		--proxy:EndAnimation( 1019, 1);--歯車アニメ --EN:--gear animation
		proxy:PlayAnimation( 1019, 1 );	--歯車アニメ再生 --EN:--Gear animation playback
		if proxy:IsClient() == false then
			proxy:NotNetMessage_begin();
				proxy:OnObjAnimEndPlus(14 , 1019 , 1 , "OnEvent_14",once );
			proxy:NotNetMessage_end();
		end		
		proxy:PlayPointSE( 2012, SOUND_TYPE_O, 606130, 6 );
	end	
	--同期のアニメ配信	 --EN:-- Synchronous animation distribution
	proxy:LuaCall( 14, 0 , "OnEvent_14_call",everytime);
	
--[[使用しなくなったのでコメントアウト(復活するかもしれない) --EN:--[[Commented out because it is no longer used (may come back)

--■90■鍛冶屋上の扉(レバーで扉を開放する)■ --EN:-- ■ 90 ■ Blacksmith rooftop door (open the door with the lever) ■
	if proxy:IsCompleteEvent(90) ==false then
	--▼PCがOBJ(1000)に対して反応角度(30)、角度オフセット(-90)、距離(150)でアクションボタンを押す▼-- --EN:--▼PC presses action button with reaction angle (30), angle offset (-90), distance (150) against OBJ (1000)▼--
		proxy:OnDistanceActionPlus( 90, 10000, 1022, "OnEvent_90", LeverDist_A, HELPID_PULL_LEVER, 0.0, LeverAngle_A, 0.0, 0.0, 0.0, once );
	else
		proxy:EndAnimation( 1022, 1);--レバーアニメ --EN:--lever animation
		proxy:EndAnimation( 1021, 1);--扉アニメ --EN:--door animation
	end	
]]
	
--■150■石柱にワープ■ --EN:-- ■ 150 ■ Warp to the stone pillar ■
	SingleReset(proxy,150);
	proxy:TreasureDispModeChange2( 1983 , true ,KANAME_SFX);
	proxy:OnDistanceAction( 150, 10000, 1983, "OnEvent_150", WarpGimmickDist_A, HELPID_GO_TO_SEKITYUU, 0, 180, everytime );
	
--■151■最初の要石の光が消える■ --EN:--■151■The first keystone's light disappears■
		proxy:OnSessionJustIn( 151 , "OnEvent_151" , everytime );
		
--■152■最初の要石の光が復活する■ --EN:-- ■ 152 ■ The light of the first keystone is restored ■
		proxy:OnSessionJustOut( 152 , "OnEvent_152" , everytime );
	
--■??■徘徊デーモンの登場■ハンドラ登録 --EN:--■??■Appearance of wandering daemon■Handler registration
	proxy:NotNetMessage_begin();
		--プレイヤーがソロで死亡した時にキックされます。 --EN:--Kicked when a player dies solo.
		proxy:LuaCall( 4000, 100, "PlayerDeath_m06_00_00_00", everytime );
		--プレイヤーが復活した時にキックされます。 --EN:--Kicked when the player is revived.
		proxy:LuaCall( 4032, 100, "PlayerRevive_m06_00_00_00", everytime );
	proxy:NotNetMessage_end();
	
	
--■70■ハンドル回してフロア移動する■ --EN:-- ■ 70 ■ Rotate the handle to move to the floor ■
	proxy:SetIsAnimPauseOnRemoPlayForEvent(1023,true);
	proxy:OnPlayerActionInRegionAngle(70,2025,"OnEvent_70",30,HELPID_TURN_HANDLE,everytime);
	--フラグ同期用 --EN:--for flag synchronization
	proxy:LuaCall(70,1,"OnEvent_70_flag",everytime);
	--72がON＝エレベーターは下 --EN:--72 is ON = Elevator is down
	--PT時130,132に関してはとりあえず同期にまかせる --EN:--Regarding PT time 130 and 132, leave it to synchronization for the time being
	if proxy:IsCompleteEvent(72) == true then
		proxy:EndAnimation(1023,1);
		if proxy:IsClient() == false then		
			proxy:SetEventFlag(130,false);
			proxy:SetEventFlag(132,true);		
		end
	else
		if proxy:IsClient() == false then
			proxy:SetEventFlag(130,true);
			proxy:SetEventFlag(132,false);		
		end
	end
	
--■129■エレベーターを呼ぶハンドル■ --EN:-- ■ 129 ■ Handle to call the elevator ■
	proxy:OnDistanceAction(129,10000,1024,"OnEvent_129",1.5,HELPID_TURN_HANDLE,270,30,everytime);
--■131■エレベーターを呼ぶハンドル■ --EN:-- ■ 131 ■ Handle to call the elevator ■
	proxy:OnDistanceAction(131,10000,1025,"OnEvent_131",1.5,HELPID_TURN_HANDLE,270,30,everytime);
	
--[[Second_Initializeは廃止されたのでコメントアウト --EN:--[[Second_Initialize is deprecated and commented out
	--■初期化タイミング■ --EN:-- ■ Initialization timing ■
	proxy:NotNetMessage_begin();
		--▼0秒後▼-- --EN:--▼After 0 seconds▼--
		proxy:OnKeyTime2( 999990, "Second_Initialize_m06_00_00_00", 0.0, 0, 0, once );
	proxy:NotNetMessage_end();
	
	print("Initialize_m06_00_00_00 end");
end
--Second_Initializeは、廃止 --EN:--Second_Initialize is obsolete
--function Second_Initialize_m06_00_00_00(proxy, param )]]

--■124■徘徊ゴースト目撃■ --EN:-- ■ 124 ■ Wandering Ghost Sighting ■
	--レバーイベント終わってない	 --EN:--The lever event is not over
	if proxy:IsCompleteEvent(127) == false then
		proxy:NotNetMessage_begin();
			--非同期なイベントの為、フラグは各自OFFにしてもらう --EN:--Because it is an asynchronous event, have each flag turned off
			proxy:SetEventFlag(124,false);
			--InvalidCharactor(proxy,664);						
			proxy:OnRegionIn(124,10000,2022,"OnEvent_124",everytime);
			proxy:NotNetMessage_begin();
				proxy:OnKeyTime2(124,"OnEvent_124_Init",2,0,20,once);
			proxy:NotNetMessage_end();
		proxy:NotNetMessage_end();
	else
		InvalidCharactor(proxy,664);
		proxy:SetIgnoreHit(664,true);
		proxy:SetDisableGravity(664,true);
	end

--■121■光の霧１■ --EN:-- ■ 121 ■ fog of light 1 ■
	if proxy:IsCompleteEvent( 121 ) == false then
		proxy:OnDistanceActionAttribute( 121, 10000, 1111, "OnEvent_121", 1.5 , HELPID_GO_TO_IN , 180.0, 90.0 , ATTR_HOST + ATTR_LIVE + ATTR_GREY,everytime);				
		proxy:LuaCall(121,1,"OnEvent_121_delete_wall",once);
	else
		proxy:SetDrawEnable( 1111, false );--描画OFF --EN:--Drawing OFF
		proxy:SetColiEnable( 1111, false );--当たりOFF --EN:--Hit OFF
		--ただの再現なので自然な表現の必要が無い為、RootErase指定ではない --EN:--Since it is just a reproduction, there is no need for natural expression, so it is not RootErase specification
		proxy:InvalidSfx( 2040, false );		
	end
	
--■122■光の霧２■ --EN:-- ■ 122 ■ fog of light 2 ■
	if proxy:IsCompleteEvent( 122 ) == false then
		proxy:OnDistanceActionAttribute( 122, 10000, 1112, "OnEvent_122", 1.5 , HELPID_GO_TO_IN , 180.0, 90.0 , ATTR_HOST + ATTR_LIVE + ATTR_GREY,everytime);				
		proxy:LuaCall(122,1,"OnEvent_122_delete_wall",once);
	else
		proxy:SetDrawEnable( 1112, false );--描画OFF --EN:--Drawing OFF
		proxy:SetColiEnable( 1112, false );--当たりOFF --EN:--Hit OFF
		--ただの再現なので自然な表現の必要が無い為、RootErase指定ではない --EN:--Since it is just a reproduction, there is no need for natural expression, so it is not RootErase specification
		proxy:InvalidSfx( 2041, false );
	end

--■123■光の霧３■ --EN:-- ■ 123 ■ fog of light 3 ■
	if proxy:IsCompleteEvent( 123 ) == false then
		proxy:OnDistanceActionAttribute( 123, 10000, 1113, "OnEvent_123", 1.5 , HELPID_GO_TO_IN , 180.0, 90.0 , ATTR_HOST + ATTR_LIVE + ATTR_GREY,everytime);				
		proxy:LuaCall(123,1,"OnEvent_123_delete_wall",once);
	else
		proxy:SetDrawEnable( 1113, false );--描画OFF --EN:--Drawing OFF
		proxy:SetColiEnable( 1113, false );--当たりOFF --EN:--Hit OFF
		--ただの再現なので自然な表現の必要が無い為、RootErase指定ではない --EN:--Since it is just a reproduction, there is no need for natural expression, so it is not RootErase specification
		proxy:InvalidSfx( 2042, false );
	end
	
--■114■ボス戦カメラ対応■ --EN:-- ■ 114 ■ Boss battle camera support ■
	--ボスが生きているなら登録 --EN:--Register if the boss is alive
	if proxy:IsCompleteEvent(6174) == false then
		proxy:NotNetMessage_begin();
			proxy:OnRegionIn( 114 , 10000 , 2887 ,"OnEvent_114" , everytime );
		proxy:NotNetMessage_end();
	end
	
	--炎上テスト --EN:--flame test
--~ 	COUNT=0;
--~ 	proxy:OnKeyTime2( 8000 , "test",0.1,0,COUNT,once);
	
--■8088■坑道へ来たフラグを立てる■ --EN:--■ 8088 ■ Raise a flag for coming to the tunnel ■
	proxy:SetEventFlag( 8088, true );

-----------------------------------------------------------------------------------------
--NPC関連 --EN:--NPC related
-----------------------------------------------------------------------------------------
--[[
	proxy:NotNetMessage_begin();
--■30■NPC(ヒント)と会話を行う■--※ValueBuffer　20086使用 --EN:--■30■Conversation with NPC (hint)■--*Use ValueBuffer 20086
	--▼PCがキャラクタ()と会話 --EN:--▼ PC talks with character ()
		OnTalk(proxy,30,600,TalkDist_N,TalkAngle_N,20086,HELPID_TALK,"OnEvent_30","OnEvent_30_1","OnEvent_30_2",everytime);
	--▼キャラクタ(600)のHPが(0)パーセント以下になった時▼-- --EN:--▼When the HP of the character (600) drops below (0)%▼--
		proxy:OnCharacterHP( 30, 600, "OnEvent_30_4", 0.0, once );
	--▼キャラクタ(600)が死に、死亡アニメーションも再生し終わった時▼-- --EN:--▼When the character (600) dies and the death animation has finished playing▼--
		proxy:OnCharacterDead( 30, 600, "OnEvent_30_5", once );
	
--■40■NPC(刀鍛冶)と会話を行う■--※ValueBuffer	20087使用 --EN:--■40■Conversation with NPC (Swordsmith)■--*ValueBuffer 20087 used
	--▼PCがキャラクタ(651)	と会話 --EN:--▼ PC talks to character (651)
		OnTalk(proxy,40,651,TalkDist_N,TalkAngle_N,20087,HELPID_TALK_SWO,"OnEvent_40","OnEvent_40_1","OnEvent_40_2",everytime);
	--▼キャラクタ(651)のHPが(0)パーセント以下になった時▼-- --EN:--▼When the HP of the character (651) drops below (0)%▼--
		proxy:OnCharacterHP( 40, 651, "OnEvent_40_4", 0.0, once );
	--▼キャラクタ(651)が死に、死亡アニメーションも再生し終わった時▼-- --EN:--▼When the character (651) dies and the death animation has finished playing▼--
		proxy:OnCharacterDead( 40, 651, "OnEvent_40_5", once );
	proxy:NotNetMessage_end();
	
	--NPC(ヒント)の処理が終わっていたら --EN:--If the processing of the NPC (hint) is over
	if proxy:IsCompleteEvent( 30 ) ==true then
		proxy:PlayAnimation( 600, 2210 );	--ループアニメーション再生 --EN:--Loop animation playback
		proxy:EnableLogic(600,false);			--(腐敗人で代用してるため?)ロジックOFF --EN:--(Because it's replaced by a corrupt person?) Logic OFF
		proxy:SetColiEnable( 600, false );		--当たりを消して --EN:--Erase hits
		proxy:LoadChrPos( 600, 0 );				--座標を変える。 --EN:--Change the coordinates.
	end
	--NPC(刀鍛冶)の処理が終わっていたら --EN:--If the NPC (swordsmith) has finished processing
	if proxy:IsCompleteEvent( 40 ) ==true then
		proxy:PlayAnimation( 651, 2210 );	--ループアニメーション再生 --EN:--Loop animation playback
		proxy:EnableLogic(651,false);			--(腐敗人で代用してるため?)ロジックOFF --EN:--(Because it's replaced by a corrupt person?) Logic OFF
		proxy:SetColiEnable( 651, false );		--当たりを消して --EN:--Erase hits
		proxy:LoadChrPos( 651, 1 );				--座標を変える。 --EN:--Change the coordinates.
	end
	
	--(腐敗人で代用してるため?)読み込んだ時点でロジックOFF --EN:--(Because it is substituted by a corrupt person?) Logic OFF at the time of reading
	--proxy:EnableLogic(600,false);	--NPC(ヒント)こっちはいらない(?) --EN:--NPC (hint) I don't need this (?)
	proxy:EnableLogic(651,false);	--NPC(刀鍛冶)			 --EN:--NPC (swordsmith)
]]
	
--■鍛冶屋NPC関連の初期化■ --EN:--■Blacksmith NPC-related initialization■
	--フラグを見てNPC状態を初期化 --EN:--Initialize the NPC state by looking at the flag
	SetFirstNpcStateFlag( proxy, param, SMITH_Flag_list, SMITH_WORKING )

	--死亡していないとき --EN:--when not dead
	if proxy:IsCompleteEvent( SMITH_DEAD ) == false then
		proxy:NotNetMessage_begin();
			--赤熱のデモンズソウルを渡すイベント登録 --EN:-- Event registration to hand over red-hot Demon's Soul
			proxy:LuaCall(180,0,"OnEvent_180",once);
		proxy:NotNetMessage_end();
		
		if proxy:IsCompleteEvent( SMITH_ANGRY ) == false then--敵対していないとき --EN:--When not hostile
			--■142■【鍛冶屋NPC】NPCが敵になってない■ --EN:--■142■[Blacksmith NPC]NPC is not an enemy■
			if proxy:IsCompleteEvent( 142 ) == false then
				proxy:OnCharacterTotalRateDamage( 142, 660, LOCAL_PLAYER, NPC_ANGRY_Rate, "OnEvent_142", once );--敵対監視追加 --EN:--Added hostile monitoring
			end			
		else--敵対している --EN:-- hostile
			proxy:EnableLogic(660, true);
			proxy:SetTeamType( 660, TEAM_TYPE_AngryFriend );
			--SetNpcStateFlag(proxy,param,SMITH_Flag_list,SMITH_ANGRY);
		end
		--■143■【鍛冶屋NPC】NPCが死んだ■ --EN:--■143■ [Blacksmith NPC] NPC died■
		if proxy:IsCompleteEvent( 143 ) == false then
			proxy:OnCharacterDead( 143, 660, "OnEvent_143", once );		
		end
	else
		print("鍛冶屋NPC死亡"); --EN:print("Blacksmith NPC died");
		--死んでいるので無効化		 --EN:--disabled because it's dead
		proxy:ForceUpdateNextFrame(660);
		InvalidBackRead(proxy, 660 );		
	end		

--[[■163■乞食NPC死亡状態の初期化■ --EN:--[[ ■ 163 ■ Reset beggar NPC death status ■
	if proxy:IsCompleteEvent( 163 ) == false then
		proxy:NotNetMessage_begin();
			proxy:LuaCall( 163 , 0 , "OnEvent_163" , once );
		proxy:NotNetMessage_end();
	end
]]	


--■乞食NPC関連の初期化■ --EN:--■Beggar NPC-related initialization■
	--乞食が敵対している --EN:-- beggars are hostile
	if proxy:IsCompleteEvent( 160 ) == true and proxy:IsCompleteEvent( 161 ) == false then
		proxy:EnableLogic( 663 , true );
		SetNpcStateFlag(proxy,param,SHOP_Flag_list,SHOP_HOSTILE_1);
		proxy:SetTeamType( 663, TEAM_TYPE_AngryFriend );
		proxy:SetEventFlag( 162, true );
	end

	--乞食が死亡しているので消える --EN:--disappears because the beggar is dead
	if proxy:IsCompleteEvent( 161 ) == true then
		proxy:EnableLogic( 663 , false );
		InvalidBackRead(proxy, 663);
		SetNpcStateFlag(proxy,param,SHOP_Flag_list,SHOP_DEAD);
		proxy:SetEventFlag( 163, true );
	end
	
	--ホストorシングル --EN:--Host or Single
	if proxy:IsClient() == false then
		proxy:NotNetMessage_begin();
			--■162■スタート地点のチェックポイント■ --EN:-- ■ 162 ■ Checkpoint at the starting point ■
			proxy:OnRegionJustIn( 162 , 10000 , 2140 , "OnEvent_162",everytime);
			--■163■大蜘蛛の部屋のチェックポイント■ --EN:--■163■Checkpoint in the room of the giant spider■
			proxy:OnRegionJustIn( 163 , 10000 , 2141 , "OnEvent_163",everytime);
			--■165■ドラゴンデーモンの部屋のチェックポイント■ --EN:--■165■Dragon Demon Room Checkpoint■
			proxy:OnRegionJustIn( 165 , 10000 , 2270 , "OnEvent_165",everytime);
		proxy:NotNetMessage_end();
	end
	--■164■チェックポイント配信用■ --EN:--■164■For checkpoint delivery■
	proxy:LuaCall( 164 , 1 , "OnEvent_164" , everytime);


	--古砦囚人状態変化詰め合わせ --EN:--Old Fort Prisoner Status Change Assortment
	OnEvent_164(proxy,param);
	
--------------------------------▽▽▽QWCイベント関連▽▽▽-------------------------------- --EN:--▽▽▽QWC event related ▽▽▽--------------------------------
--■170■QWC鉱石の精霊出現■ --EN:-- ■ 170 ■ Spirit of QWC ore appears ■
	if proxy:IsCompleteEvent(171) == true or	--まだ鉱石の精霊が死亡している　か --EN:--Is the spirit of the ore still dead?
	   proxy:IsSuccessQWC(60110) == false then	--QWCが成立していなければ --EN:--If QWC is not established
		print("QWC鉱石の精霊　未成立"); --EN:print("QWC Ore Spirit Incomplete");
		--鉱石の精霊を無効化 --EN:--Nullify Ore Spirit
		InvalidBackRead(proxy, 346);
		
		proxy:SetEventFlag(170, true);
	else
		print("QWC鉱石の精霊　成立"); --EN:print("QWC ore spirit established");
	end

--■171■QWC鉱石の精霊死亡監視■ --EN:--■171■QWC ore spirit death watch■
	if proxy:IsCompleteEvent(171) == false then	--まだ鉱石の精霊が死亡してないなら --EN:--If the ore spirit hasn't died yet
	   --鉱石の精霊の死亡監視追加 --EN:-- Added death watch for Ore Spirit
		proxy:OnCharacterDead( 171, 346, "OnEvent_171", once );
		if proxy:IsClient() == false and proxy:IsCompleteEvent(8020) == false then
			proxy:NotNetMessage_begin();
				proxy:AddCorpseEvent( 8020 , 346 );
				proxy:LuaCall( 8020 , 0 , "OnEvent_8020",once);
			proxy:NotNetMessage_end();
		end
	end


--■176■QWCソウルモンスター■ --EN:--■176■QWC Soul Monster■
	if proxy:IsSuccessQWC(60100) == false then--成立していないならば --EN:--If not established
		print("ブラックゴースト無効化"); --EN:print("Disable Black Ghost");
		--350を無効化 --EN:disable --350
		InvalidCharactor(proxy, 350);
		--351を無効化 --EN:disable --351
		InvalidCharactor(proxy, 351);
		--352を無効化 --EN:disable --352
		InvalidCharactor(proxy, 352);
		--353を無効化 --EN:disable --353
		InvalidCharactor(proxy, 353);
		
		proxy:SetEventFlag(176, true);
	end
--------------------------------△△△QWCイベント関連△△△--------------------------------	 --EN:--△△△QWC event related△△△--------------------------------

--■190～？？？■マグマヤモリ落下イベント■ --EN:--■ 190~? ? ? ■ Magma gecko fall event ■
	local yamori_Idlist = {370,373,374,375,376,380,381,382,383,384,385};
	local region_Idlist = {2150,2151,2151,2151,2151,2152,2152,2152,2152,2153,2153};
	local action_Idlist = {190,193,194,195,196,200,201,202,203,204,205};
	local num = table.getn( yamori_Idlist );
	
	for index=1 , num , 1 do
		--ソロ時はリピート --EN:--Repeat when soloing
		SingleReset( proxy, action_Idlist[index] );
		if proxy:IsCompleteEvent( action_Idlist[index] ) == false then
			print("Regist YamoriEvent id:",yamori_Idlist[index] );
			--[[
			OnEvent_190、OnEvent_191、OnEvent_192			 --EN:OnEvent_190, OnEvent_191, OnEvent_192
			]]
			proxy:OnRegionIn( action_Idlist[index],10000,region_Idlist[index],"OnEvent_"..action_Idlist[index],once);
			proxy:OnSimpleDamage( action_Idlist[index],yamori_Idlist[index],10000,"OnEvent_"..action_Idlist[index].."_Dam",once);
		else
			print("Complete YamoriEvent id:",yamori_Idlist[index] );
			proxy:SetSpStayAndDamageAnimId( yamori_Idlist[index] , -1,-1);
		end
	end
	
	--■210■ウロコ鉱夫の岩落とし■ --EN:-- ■ 210 ■ Scale Miner's Rock Remover ■
	SingleReset( proxy,210 );
	if proxy:IsCompleteEvent( 210 ) == false then
		--領域監視 --EN:--Region monitoring
		proxy:OnRegionIn( 210 , 10000 , 2155 , "OnEvent_210" , once );		
	else
		--落石イベント終了状態で再現 --EN:--Reproduced in the end state of the rockfall event
		proxy:ReconstructBreak( 1125 , 1);
		proxy:ReconstructBreak( 1126 , 1);
		--proxy:ReconstructBreak( 1127 , 1);
	end
	
	--■185,186■犬が飛び出してくる■ --EN:-- ■ 185, 186 ■ The dog jumps out ■
	if proxy:IsCompleteEvent(185) == false then
		proxy:OnRegionIn( 185 , 10000 , 2154 , "OnEvent_185",once);	
		proxy:OnObjectDestroy( 186 , 1120 , "OnEvent_186",once);
		proxy:EnableLogic( 390 , false );
		proxy:EnableLogic( 392 , false );
		proxy:EnableLogic( 393 , false );
	else
		--OBJを既に壊した状態にする --EN:--Make OBJ already broken
		proxy:ReconstructBreak( 1120 ,1);
	end	
	
	--■187■崩れる橋■ --EN:-- ■ 187 ■ Collapsed bridge ■
	if proxy:IsCompleteEvent( 187 ) == false then
		proxy:OnRegionIn( 187,10000,2156,"OnEvent_187",once);		
	else
		proxy:ReconstructBreak( 1121 , 1);
	end
	
	--■189■崩れる橋２■ --EN:-- ■ 189 ■ Collapsed bridge 2 ■
	SingleReset( proxy, 189 );
	if proxy:IsCompleteEvent( 189 ) == false then
		proxy:OnRegionIn( 189,10000,2169,"OnEvent_189",once);
	else
		proxy:EndAnimation( 1123 , 1);
	end
	
	
	--[[
	--■188■吊るされた死体■ --EN:--■ 188■ Suspended corpse■
	if proxy:IsCompleteEvent( 188 ) == false then
		proxy:OnObjectDestroy( 188 , 1122 , "OnEvent_188",once);
		--宝無効化はSecondInit --EN:--Treasure invalidation is SecondInit
	end
	]]
	
	--■220～225■タル爆弾■ --EN:-- ■ 220～225 ■ barrel bomb ■
	local action_Idlist = 	{220	,221	,222	,223	,224	,225	,226	,227	,228	,229	,233	,234	,235	,236	,237	,238	,239	,240	,
							 241	,242	,243	,244	,245	,246	,247	,248	,250	,251	,252	,253};
	local taru_Idlist = 	{1130	,1131	,1132	,1133	,1134	,1135	,1136	,1137	,1138	,1139	,1140	,1141	,1142	,1143	,1144	,1145	,1146	,1147	,
							 1148	,1149	,1150	,1151	,1152	,1153	,1154	,1155	,1156	,1157	,1158	,1159};
	local num = table.getn( action_Idlist );
	
	--InvalidCharactor( proxy , 400 );
	--無重力、当たらない、描画されない、常に読み込む、常に更新する --EN:-- Zero Gravity, Never Hit, Never Draw, Always Load, Always Update
	CreateBulletOwner( proxy ,400 );
	CreateBulletOwner( proxy ,410 );
	
	for index =1 , num , 1 do		
		SingleReset( proxy, action_Idlist[index] );		
		if proxy:IsCompleteEvent( action_Idlist[index] ) == false then
			proxy:OnFireDamage( action_Idlist[index] , taru_Idlist[index]  , -1 , "OnEvent_"..action_Idlist[index] , once);
			--proxy:OnObjectDestroy( action_Idlist[index] , taru_Idlist[index] , "OnEvent_"..action_Idlist[index] , once );
		else
			proxy:ReconstructBreak( taru_Idlist[index] , 1);
		end
	end
	
	--■230■うろこ鉱夫攻撃■ --EN:-- ■ 230 ■ Scale miner attack ■
	SingleReset( proxy , 230 );
	if proxy:IsCompleteEvent( 230 ) == false then
		proxy:EnableLogic( 394 , false );
		proxy:OnRegionIn( 230 , 10000 , 2157 , "OnEvent_230",once);
	end
	
	--■231■うろこ鉱夫攻撃■ --EN:-- ■ 231 ■ Scale miner attack ■
	SingleReset( proxy , 231 );
	if proxy:IsCompleteEvent( 231 ) == false then
		proxy:EnableLogic( 395 , false );
		proxy:OnRegionIn( 231 , 10000 , 2158 , "OnEvent_231",once);
	end
	
	--■232■うろこ鉱夫攻撃■ --EN:-- ■ 232 ■ Scale miner attack ■
	SingleReset( proxy , 232 );
	if proxy:IsCompleteEvent( 232 ) == false then
		proxy:EnableLogic( 396 , false );
		proxy:OnRegionIn( 232 , 10000 , 2159 , "OnEvent_232",once);
	end
	
	--■249■獄吏が魔法を撃ってくる■ --EN:-- ■ 249 ■ Prisoner shoots magic ■
	SingleReset( proxy, 249 );
	if proxy:IsCompleteEvent( 249 ) == false then
		proxy:OnRegionIn( 249 , 10000 , 2170, "OnEvent_249",once );
	end
	
	RegistTokage(proxy,260,240,18);
	RegistTokage(proxy,262,241,19);
	RegistTokage(proxy,750,242,20);
	RegistTokage(proxy,752,243,21);
	RegistTokage(proxy,754,244,22);
	RegistTokage(proxy,756,245,23);
	RegistTokage(proxy,758,246,24);
	RegistTokage(proxy,760,247,25);
	RegistTokage(proxy,762,248,26);
	RegistTokage(proxy,764,249,27);
	RegistTokage(proxy,766,250,28);
	RegistTokage(proxy,768,251,29);
	RegistTokage(proxy,770,252,30);
	RegistTokage(proxy,772,253,31);
	RegistTokage(proxy,774,254,32);
	RegistTokage(proxy,776,255,33);
	RegistTokage(proxy,778,256,34);
	RegistTokage(proxy,780,257,35);
	RegistTokage(proxy,782,321,36);
	RegistTokage(proxy,784,322,37);
	RegistTokage(proxy,786,416,38);
	RegistTokage(proxy,788,417,39);
	RegistTokage(proxy,1200,258,40);
	RegistTokage(proxy,1202,259,41);
	
	
	local eneIdlist 	= {201	,431	,432	,433	,434	,204	,436	,437	};
	local deadIdlist 	= {280	,282	,284	,286	,288	,290	,292	,294	};
	local initidlist	= {281	,283	,285	,287	,289	,291	,293	,295	};
	local corpseIdlist	= {15700,15701	,15702	,15703	,15704	,15705	,15706	,15707	};
	local num = table.getn(eneIdlist);
	for index=1,num, 1 do
		Regist_FukuroKoufu(proxy,eneIdlist[ index ],deadIdlist[ index ],corpseIdlist[ index ],initidlist[ index ]);
	end
	
	
	--DISTENELIST = {210,211,212,213,217,219,351,352};グローバル定義 --EN:--DISTENELIST={210,211,212,213,217,219,351,352}; global definition
	--IWAKOUFU_DIST = 1.4;							;グローバル定義 --EN:--IWAKOUFU_DIST=1.4; ;global definition
	local actlist = {300,301,302,303,304,305,306,307};
	local num = table.getn( DISTENELIST );
	proxy:NotNetMessage_begin();
	for index = 1, num , 1 do
		proxy:OnPlayerDistanceOut( actlist[index] , 216 , DISTENELIST[index] , "OnEvent_"..actlist[index].."_Out" , IWAKOUFU_DIST , everytime );
		proxy:OnDistanceJustIn( actlist[index] , 216 , DISTENELIST[index] , "OnEvent_"..actlist[index].."_In", IWAKOUFU_DIST , everytime );		
		proxy:OnCharacterDead( actlist[index] , DISTENELIST[index] , "OnEvent_"..actlist[index].."_Dead" , once );
	end
	proxy:NotNetMessage_end();
	
	--DISTENELIST = {210,211,212,213,217,219,351,352};グローバル定義 --EN:--DISTENELIST={210,211,212,213,217,219,351,352}; global definition
	--IWAKOUFU_DIST = 1.4;							;グローバル定義 --EN:--IWAKOUFU_DIST=1.4; ;global definition
	local actlist = {308,309,310,311,312,313,314,315};
	local num = table.getn( DISTENELIST );
	proxy:NotNetMessage_begin();
	for index = 1, num , 1 do
		proxy:OnPlayerDistanceOut( actlist[index] , 218 , DISTENELIST[index] , "OnEvent_"..actlist[index].."_Out" , IWAKOUFU_DIST , everytime );
		proxy:OnDistanceJustIn( actlist[index] , 218 , DISTENELIST[index] , "OnEvent_"..actlist[index].."_In", IWAKOUFU_DIST , everytime );		
		proxy:OnCharacterDead( actlist[index] , DISTENELIST[index] , "OnEvent_"..actlist[index].."_Dead" , once );
	end
	proxy:NotNetMessage_end();
	
	
	--■999999■フレーム遅れの初期化処理イベントを発行■ --EN:-- ■ 999999 ■ Generate a frame delay initialization processing event ■
	proxy:NotNetMessage_begin();
		--▼0秒後▼-- --EN:--▼After 0 seconds▼--
		proxy:OnKeyTime2( 999990, "Second_Initialize_m06_00_00_00", 0.2, 0, 0, once );	
	proxy:NotNetMessage_end();	
	
	if proxy:IsDbgReLoad() == true then
		proxy:OnKeyTime2( 4021,"OnEvent_DbgReLoad",1.0,0,0,once);
	end
	print("Initialize_m06_00_00_00 end");
end

--リロードデバッグ --EN:--reload debug
function OnEvent_DbgReLoad(proxy,param)
	--完全回復要求 --EN:-- full recovery request
	proxy:RequestFullRecover();
	--石柱の坑道要石へ --EN:--To the stone pillar tunnel keystone
	proxy:WarpNextStage( 1, 0, 0, 0, 1010 );
end

function OnEvent_4000_Hp_1(proxy,param)
	print("OnEvent_4000_Hp_1 begin");
	proxy:SetDeadMode2(810 , true );
	proxy:SetDeadMode2(811 , true );
	proxy:SetDeadMode2(825 , true );
	print("OnEvent_4000_Hp_1 end");
end

--------------------------------------------------------------------------------------
--Initializeから呼ばれる、1フレーム遅れの初期化処理■999999 --EN:--Initialization with a delay of 1 frame, called from Initialize ■999999
--------------------------------------------------------------------------------------
--■999999■一部、Initでは処理できないので、残しておく --EN:-- ■ 999999 ■ Some parts cannot be processed by Init, so leave them
function Second_Initialize_m06_00_00_00(proxy, param)
	print("Second_Initialize_m06_00_00_00 begin");	
--------------------------------▽▽▽QWCイベント関連▽▽▽-------------------------------- --EN:--▽▽▽QWC event related ▽▽▽--------------------------------
--------------------------------△△△QWCイベント関連△△△-------------------------------- --EN:--△△△QWC event related△△△--------------------------------
	
	proxy:NotNetMessage_begin();
		--ホストクライアント関係なく登録される必要と判定される必要がある為 --EN:--Because it needs to be judged as necessary to be registered regardless of the host client
		proxy:SetEventFlag( 270 , false );
		
		--■270■もや領域に入った■ --EN:-- ■ 270 ■ entered the haze area ■
		proxy:OnRegionJustIn( 270 , 10000 , 2300 , "OnEvent_270" , everytime);
		proxy:OnRegionJustIn( 270 , 10000 , 2301 , "OnEvent_270" , everytime);
		proxy:OnRegionJustIn( 270 , 10000 , 2302 , "OnEvent_270" , everytime);
		--■271■もや領域からでた■ --EN:-- ■ 271 ■ came out of the haze area ■
		proxy:OnRegionJustOut( 271 , 10000 , 2300 , "OnEvent_271" , everytime );
		proxy:OnRegionJustOut( 271 , 10000 , 2301 , "OnEvent_271" , everytime );
		proxy:OnRegionJustOut( 271 , 10000 , 2302 , "OnEvent_271" , everytime );
		
	proxy:NotNetMessage_end();
	print("Second_Initialize_m06_00_00_00 end");
end

--------------------------------------------------------------------------------------
--マルチになった時にホストじゃ無かったら(アサート対策、基本ここに処理は書かない)■ --EN:--If it is not the host when it becomes multi (assertion countermeasures, basically do not write processing here) ■
--------------------------------------------------------------------------------------
function ConnectPartyEvent(proxy)
	print("ConnectPartyEvent begin");
	print("ConnectPartyEvent end");
end


--------------------------------------------------------------------------------------
--レバーで扉を開放する■0 --EN:--Open the door with the lever 0
--------------------------------------------------------------------------------------
--■0■レバーで扉を開放する■ --EN:-- ■ 0 ■ Open the door with the lever ■
function OnEvent_0(proxy, param)
	print("OnEvent_0 begin")
	
	proxy:PlayAnimation( 1000, 1 );	--レバーアニメ再生 --EN:--Play lever animation
	
	--プレイヤーの同期アニメーション(true:パーティープレイヤーがアニメーションした) --EN:--Player synchronous animation (true: party player animated)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_PULL_LEVER ) == true then 
		proxy:SetEventFlag( 0 , 1 );
		--徘徊イベント停止用 --EN:--For stopping loitering events
		proxy:SetEventFlag( 127,true);
		return;
	end
	
	proxy:NotNetMessage_begin();
		--▼0_2▼***条件追加***レバーアニメ終了▼ --EN:--▼0_2▼***Condition added***Lever animation ends▼
		proxy:OnCharacterAnimEnd( 0, 1000, 1, "OnEvent_0_2", once );
	proxy:NotNetMessage_end();

	proxy:WarpDmy( 10000 , 1000 , 191 );
	proxy:SetEventFlag( 0 , 1 );
	--徘徊イベント停止用 --EN:--For stopping loitering events
	proxy:SetEventFlag( 127,true);
		
	print("OnEvent_0 end")
end

--▲0_2▲レバーアニメ終了▲ --EN:--▲0_2▲Lever animation ends▲
function OnEvent_0_2(proxy, param)
	print("OnEvent_0_2 begin")
	
	proxy:SetEventFlag( 0 , 0 );
	
	proxy:NotNetMessage_begin();
		--▼0_4▼扉が開くポリ劇再生▼ --EN:--▼0_4▼Poly drama playback that opens the door▼
		proxy:OnKeyTime2( 0, "OnEvent_0_4", 0.0, 0, 3, once );--[[0秒後に変更しました]] --EN:--[[Changed after 0 seconds]]
		--▼0_3▼***条件追加***0.5秒後に扉が開く▼ --EN:--▼0_3▼***Condition added***Door opens after 0.5 seconds▼
		proxy:OnKeyTime2( 0, "OnEvent_0_3", 0.5, 0, 2, once );
	proxy:NotNetMessage_end();
	
	proxy:SetEventFlag( 0 , 1 );
	
	print("OnEvent_0_2 end")
end

--▲0_3▲0.5秒後に扉が開く▲ --EN:--▲0_3▲The door opens after 0.5 seconds▲
function OnEvent_0_3(proxy, param)
	print("OnEvent_0_3 begin");
	proxy:LuaCallStart(0,1);	
	print("OnEvent_0_3 end");
end

--ネット配信用 --EN:--For internet distribution
function OnEvent_0_3_Net(proxy,param)
	print("OnEvent_0_3_Net begin");
	--トロッコSE再生 --EN:--Trolley SE playback
	proxy:PlayPointSE( 2014, SOUND_TYPE_O, 606150, 7 );	
	proxy:PlayAnimation( 1010, 1 ); --歯車が動くアニメ再生 --EN:--Play animation with moving gears
	print("OnEvent_0_3_Net end");
end

--▲0_4▲扉が開くポリ劇再生▲ --EN:-- ▲ 0_4 ▲ Poly play that opens the door ▲
function OnEvent_0_4(proxy, param)
	print("OnEvent_0_4 begin");
	proxy:LuaCallStart(0,2);	
	print("OnEvent_0_4 end");
end

--ネット配信用 --EN:--For internet distribution
function OnEvent_0_4_Net(proxy,param)
	print("OnEvent_0_4_Net begin");
	--▼扉が開くポリ劇再生 --EN:--▼ Poly play that opens the door
	if param:IsNetMessage() == true then
		--配信者のIDでポリ劇再生 --EN:-- Polyplay play with broadcaster's ID
		proxy:RequestRemoPlus(60000,REMO_FLAG,0,1,param:GetPlayID() + 10001);
	else
		--自分自身でポリ劇再生 --EN:-- Play polyplay by yourself
		proxy:RequestRemo(60000,REMO_FLAG,0,1);
	end
	
	--proxy:SetEventFlag( 0 , 1 );
	proxy:SetEventFlag( 2, 1 );
	print("OnEvent_0_4_Net end");
end


--■ポリ劇再生開始(フェード終了) --EN:--■ Start of polyplay playback (end of fade)
function OnEvent_0_RemoStart(proxy,param)
	print("OnEvent_0_RemoStart begin");
	print("OnEvent_0_RemoStart end");
end


--■ポリ劇再生終了(フェード終了) --EN:-- End of polyplay playback (end of fade)
function OnEvent_0_RemoFinish(proxy , param)
	print("OnEvent_0_RemoFinish begin");
	
	proxy:EndAnimation( 1001, 1 );	--扉が開くアニメ再生終了 --EN:-- End of the animation where the door opens
	
	proxy:SetEventFlag( 1, 1 );
	
	print("OnEvent_0_RemoFinish end");
end


--------------------------------------------------------------------------------------
--ハンドルAを回して歯車を動かす■10 --EN:--Turn the handle A to move the gear ■10
--------------------------------------------------------------------------------------
--■10■ハンドルAを回して歯車を動かす■ --EN:--■10■Turn the handle A to move the gear■
function OnEvent_10(proxy, param)
	print("OnEvent_10 begin") 
	
	proxy:PlayAnimation( 1002, 1 );--ハンドルアニメ再生 --EN:--Handle animation playback
	
	proxy:NotNetMessage_begin();
		--▼10_2▼***条件追加***ハンドルアニメ終了▼ --EN:--▼10_2▼***Condition added***Handle animation ends▼
		proxy:OnCharacterAnimEnd( 10, 1002, 1, "OnEvent_10_2", once );
	proxy:NotNetMessage_end();
	
	--プレイヤーの同期アニメーション(true:パーティープレイヤーがアニメーションした) --EN:--Player synchronous animation (true: party player animated)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_TURN_HANDLE ) == true then 
		return;
	end
--[[	
	proxy:NotNetMessage_begin();
		--▼10_1▼***条件追加***プレイヤーアニメ終了▼ --EN:--▼10_1▼***Condition added***Player animation ends▼
		proxy:OnChrAnimEnd( 10, 10000, ANIMEID_TURN_HANDLE, "OnEvent_10_1", once );
	proxy:NotNetMessage_end();
]]	
--	proxy:Warp( 10000 , 2001 );		--プレイヤーを所定位置にワープ --EN:--Warp player in place
	proxy:WarpDmy( 10000 , 1002 , 191 );
	
--	proxy:DisableMove( 10000, 1 );	--プレイヤーを操作不能に --EN:--Incapacitate player
	
	print("OnEvent_10 end")
end
--[[
--▲10_1▲プレイヤアニメ終了▲ --EN:--▲10_1▲End of player animation▲
function OnEvent_10_1(proxy, param)
	print("OnEvent_10_1 begin")
	
	proxy:DisableMove( 10000, 0 );	--プレイヤーを操作可能に --EN:--Make player controllable
	
	print("OnEvent_10_1 end")
end
]]
--▲10_2▲ハンドルアニメ終了▲ --EN:--▲10_2▲Handle animation ends▲
function OnEvent_10_2(proxy, param)
	print("OnEvent_10_2 begin")
	
	proxy:SetEventFlag( 10, 1 );	--フラグを立てる --EN:-- flag
	
	--もう片方のハンドルイベントを発動させない --EN:--Do not fire the other handle event
	proxy:DeleteEvent( 12 );--もうひとつのハンドルを回すイベントの削除 --EN:--Remove another handle turning event

	proxy:NotNetMessage_begin();
		--▼10_3▼***条件追加***0.5秒後▼ --EN:--▼10_3▼***Condition added***After 0.5 seconds▼
		proxy:OnKeyTime2( 11, "OnEvent_11", 0.5, 0, 2, once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_10_2 end")
end

--▲10_3▲0.5秒後▲ --EN:--▲10_3▲After 0.5 seconds▲
function OnEvent_11(proxy, param)
	print("OnEvent_11 begin")

	--proxy:PlayAnimation( 1003, 1 );	--歯車アニメ再生 --EN:--Gear animation playback
	if proxy:IsClient() == false then
		OnEvent_24(proxy,param);
	end
	proxy:SetEventFlag( 11, 1 );	--フラグを立てる --EN:-- flag
	
	proxy:PlayPointSE( 2011, SOUND_TYPE_O, 606130, 4 );
	--proxy:StopPointSE( 0 );
	print("OnEvent_11 end")
end

--------------------------------------------------------------------------------------
--ハンドルA_2を回して歯車を動かす■12 --EN:--Turn the handle A_2 to move the gear ■12
--------------------------------------------------------------------------------------
--■12■ハンドルAを回して歯車を動かす■ --EN:--■12■Turn the handle A to move the gear■
function OnEvent_12(proxy, param)
	print("OnEvent_12 begin") 
	
	proxy:PlayAnimation( 1026, 1 );--ハンドルアニメ再生 --EN:--Handle animation playback
	
	proxy:NotNetMessage_begin();
		--▼10_2▼***条件追加***ハンドルアニメ終了▼ --EN:--▼10_2▼***Condition added***Handle animation ends▼
		proxy:OnCharacterAnimEnd( 12, 1026, 1, "OnEvent_12_2", once );
	proxy:NotNetMessage_end();
	
	--プレイヤーの同期アニメーション(true:パーティープレイヤーがアニメーションした) --EN:--Player synchronous animation (true: party player animated)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_TURN_HANDLE ) == true then 
		return;
	end

	proxy:WarpDmy( 10000 , 1026 , 191 );
	
	print("OnEvent_12 end")
end

--▲12_2▲ハンドルアニメ終了▲ --EN:--▲12_2▲Handle animation ends▲
function OnEvent_12_2(proxy, param)
	print("OnEvent_12_2 begin")
	
	proxy:SetEventFlag( 12, 1 );	--フラグを立てる --EN:-- flag
	
	--もう片方のハンドルイベントを発動させない --EN:--Do not fire the other handle event
	proxy:DeleteEvent( 10 );--もうひとつのハンドルを回すイベントの削除 --EN:--Remove another handle turning event

	proxy:NotNetMessage_begin();
		--▼10_3▼***条件追加***0.5秒後▼ --EN:--▼10_3▼***Condition added***After 0.5 seconds▼
		proxy:OnKeyTime2( 13, "OnEvent_13", 0.5, 0, 2, once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_12_2 end")
end

--▲13▲0.5秒後▲ --EN:--▲13▲After 0.5 seconds▲
function OnEvent_13(proxy, param)
	print("OnEvent_13 begin")

	--proxy:PlayAnimation( 1003, 1 );	--歯車アニメ再生 --EN:--Gear animation playback
	if proxy:IsClient() == false then
		OnEvent_24(proxy,param);
	end
	proxy:SetEventFlag( 13, 1 );	--フラグを立てる --EN:-- flag
	
	proxy:PlayPointSE( 2011, SOUND_TYPE_O, 606130, 4 );
	print("OnEvent_13 end")
end

--ホストのみのアニメ監視 --EN:--Host-only anime monitoring
function OnEvent_24(proxy,param)
	proxy:LuaCallStart( 24 ,0 );
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 24 , "OnEvent_24_wait",1.0 ,0 ,0 , once);
	proxy:NotNetMessage_end();
end

--時間差 --EN:--Time lag
function OnEvent_24_wait(proxy,param)
	proxy:NotNetMessage_begin();
		proxy:OnObjAnimEndPlus(24 , 1003 , 1 , "OnEvent_24",once );
	proxy:NotNetMessage_end();
end

--アニメ配信 --EN:--Animation distribution
function OnEvent_24_call(proxy,param)
	proxy:ForcePlayAnimation( 1003, 1 );	--歯車アニメ再生 --EN:--Gear animation playback
end

--------------------------------------------------------------------------------------
--ハンドルBを回して歯車を動かす■20 --EN:--Turn the handle B to move the gear ■20
--------------------------------------------------------------------------------------
--■20■ハンドルBを回して歯車を動かす■ --EN:--■20■Turn the handle B to move the gear■
function OnEvent_20(proxy, param)
	print("OnEvent_20 begin")
	
	proxy:PlayAnimation( 1004, 1 );--ハンドルアニメ再生 --EN:--Handle animation playback
	--proxy:PlayPointSE( 2012, SOUND_TYPE_O, 606130, 0 );
	proxy:SetEventFlag( 20 , 1 );
	
	--プレイヤーの同期アニメーション(true:パーティープレイヤーがアニメーションした) --EN:--Player synchronous animation (true: party player animated)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_TURN_HANDLE ) == true then 
		return;
	end
	
	proxy:NotNetMessage_begin();
		--▼20_2▼***条件追加***ハンドルアニメ終了▼ --EN:--▼20_2▼***Condition added***Handle animation ends▼
		proxy:OnCharacterAnimEnd( 21, 1004, 1, "OnEvent_21", once );
	proxy:NotNetMessage_end();

	proxy:WarpDmy( 10000 , 1004 , 191 );
	
	print("OnEvent_20 end")
end


--▲21▲ハンドルアニメ終了▲ --EN:--▲21▲Handle animation ends▲
function OnEvent_21(proxy, param)
	print("OnEvent_21 begin")
	proxy:SetEventFlag( 21 , 1 );
	
	proxy:NotNetMessage_begin();
		--▼21_1▼***条件追加***ハンドルアニメ終了から0.5秒後▼ --EN:--▼21_1▼***Condition added***0.5 seconds after the end of the handle animation▼
		proxy:OnKeyTime2( 21, "OnEvent_21_1", 0.0, 0, 2, once );--[[0秒後に変更しました]] --EN:--[[Changed after 0 seconds]]
	proxy:NotNetMessage_end();
	
	print("OnEvent_21 end")
end

--▲21_1▲ハンドルアニメ終了から0.5秒後▲ --EN:--▲21_1▲0.5 seconds after the handle animation ends▲
function OnEvent_21_1(proxy,param)
	print("OnEvent_21_1 begin");
	proxy:LuaCallStart( 22 , 0);
	print("OnEvent_21_1 end");
end


--▲22▲▲ --EN:--▲22▲▲
function OnEvent_22(proxy, param)
	print("OnEvent_22 begin");
	
	proxy:PlayAnimation( 1005 , 1 );--歯車アニメ再生 --EN:--Gear animation playback
	proxy:SetEventFlag(146,true);--OBJ差し替え --EN:--OBJ replacement
	proxy:SetEventFlag(147,true);--SFX切り替え --EN:--SFX switching
	proxy:SetEventFlag(148,true);--SFX切り替え --EN:--SFX switching
	proxy:SetEventFlag(149,true);--SE停止 --EN:--SE stop

	--▼水位が下がるポリ劇再生 --EN:--▼Poly drama playback where the water level drops
	proxy:RequestRemo(60001,REMO_FLAG,20,1);
	
--[[	
	proxy:PlayAnimation( 1005, 1 );	--歯車アニメ再生 --EN:--Gear animation playback
	proxy:PlayAnimation( 1009, 1 ); --水車(?)アニメ再生 --EN:--Water wheel(?) animation playback
	
	
	proxy:NotNetMessage_begin();
		--▼20_4▼***条件追加***歯車・水車アニメ再生から1秒後▼ --EN:--▼20_4▼***Condition added***One second after the gear/waterwheel animation playback▼
		proxy:OnKeyTime2( 20, "OnEvent_20_4", 1.0, 0, 3, once );
		--▼20_5▼***条件追加***歯車アニメ再生終了▼ --EN:--▼20_5▼***Condition added***Gear animation playback finished▼
		proxy:OnCharacterAnimEnd( 20, 1005, 1, "OnEvent_20_5", once );
		--▼20_6▼***条件追加***水車(?)アニメ再生終了▼ --EN:--▼20_6▼***Conditions added***Water wheel(?) animation playback finished▼
		proxy:OnCharacterAnimEnd( 20, 1009, 1, "OnEvent_20_6", once );
	proxy:NotNetMessage_end();
	
]]
	
	print("OnEvent_22 end");
end


--■ポリ劇再生開始(フェード終了) --EN:--■ Start of polyplay playback (end of fade)
function OnEvent_20_RemoStart(proxy,param)
	print("OnEvent_20_RemoStart begin");
	
	proxy:SetDrawEnable( 1030, false );--水面オブジェ描画消す --EN:--Erase drawing of water surface object
	proxy:StopLoopAnimation( 1009 );
	proxy:PlayAnimation( 1009 , 0 );--水車が止まってるアニメ再生 --EN:--Play animation of stopped waterwheel
	proxy:DeleteEvent(128);--ダメージ床ONイベント削除 --EN:--Damage floor ON event deleted
	proxy:DeleteEvent(133);--ダメージ床OFFイベント削除 --EN:--Damage floor OFF event deleted
	proxy:DeleteEvent(50);--敵ダメージ床ONイベント削除 --EN:-- Enemy damage floor ON event deleted
	proxy:DeleteEvent(51);--敵ダメージ床OFFイベント削除 --EN:-- Enemy damage floor OFF event deleted
	--proxy:EraseEventSpecialEffect(10000,10050);	
	proxy:DeleteEvent( 4069 );
	IS_FIREAREA = false;	
	proxy:InvalidSfx( 2015 , false );
	
	print("OnEvent_20_RemoStart end");
end


--■ポリ劇再生終了(フェード終了) --EN:-- End of polyplay playback (end of fade)
function OnEvent_20_RemoFinish(proxy , param)
	print("OnEvent_20_RemoFinish begin");
	
	--function OnEvent_23(proxy, param)
	proxy:SetColiEnable( 1008, false );	--透明オブジェの当たりを消す(水面の) --EN:--Eliminate the impact of transparent objects (on the surface of the water)
	
	proxy:SetEventFlag(23, true);--ここに書いてあるので、仕様にあわせる為にフラグセット --EN:-- Since it is written here, flag set to match the specification
	--end
	proxy:SetColiEnable(1031,false);
	proxy:SetDrawEnable(1031,false);
	proxy:SetColiEnable(1032,true);
	proxy:SetDrawEnable(1032,true);	
	proxy:StopPointSE( 5 );--SE停止 --EN:--SE stop
	
	proxy:ValidSfx(2043);
	proxy:ValidSfx(2044);
	
	--マグマ演出SFX廃止 --EN:--Abolition of magma production SFX
	proxy:InvalidSfx( 2046 ,true );
	
	--マグマヒットエフェクト用 --EN:--For magma hit effects
	proxy:SetColiEnableArray( 1033 , false );	

	proxy:SetEventFlag( 22 , 1 );

	print("OnEvent_20_RemoFinish end");
end


--[[
--▲20_4▲歯車・水車アニメ再生から1秒後▲ --EN:--▲20_4▲One second after the gear/waterwheel animation plays▲
function OnEvent_20_4(proxy, param)
	print("OnEvent_20_4 begin");
	
	print("ハンドルBを回して歯車を動かす"); --EN:print("Turn the handle B to move the gear");
	print("水位が下がる ポリ劇再生"); --EN:print("The water level drops Polyplay play");
	
--	proxy:MoveMapParts(1030,0,-5,0);	--水位下げる --EN:--Lower the water level
	proxy:SetDrawEnable( 1030, false );
	
	proxy:NotNetMessage_begin();
		--▼20_7▼***条件追加***水位が下がってから0秒後▼ --EN:--▼20_7▼***Condition added***0 seconds after the water level drops▼
		proxy:OnKeyTime2( 20, "OnEvent_20_7", 0.0, 0, 4, once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_20_4 end");
end

--▲20_5▲歯車アニメ再生終了▲ --EN:--▲20_5▲End of gear animation playback▲
function OnEvent_20_5(proxy, param)
	print("OnEvent_20_5 begin");
	
	proxy:PlayAnimation( 1005 , 2 );--以降、2番のアニメをループ再生(歯車) --EN:--After that, loop playback of animation No. 2 (gear)
	
	print("OnEvent_20_5 end");
end

--▲20_6▲水車(?)アニメ再生終了▲ --EN:--▲20_6▲Water wheel (?) Animation playback finished▲
function OnEvent_20_6(proxy, param)
	print("OnEvent_20_6 begin");

	proxy:PlayAnimation( 1009 , 2 );--以降、2番のアニメをループ再生(水車) --EN:--After that, loop playback of animation No. 2 (water wheel)
	
	print("OnEvent_20_6 end");
end

--▲20_7▲水位が下がってから0秒後▲ --EN:--▲20_7▲0 seconds after the water level drops▲
function OnEvent_20_7(proxy, param)
	print("OnEvent_20_7 begin");

	proxy:SetColiEnable( 1008, false );	--透明オブジェの当たりを消す --EN:--Erase hits of transparent objects
	proxy:SetEventFlag( 20, true );		--フラグを立てる --EN:-- flag
	
	print("OnEvent_20_7 end");
end
]]


--------------------------------------------------------------------------------------
--ボス部屋の中に入る■111 --EN:--Enter the boss room 111
--------------------------------------------------------------------------------------

--■イベントがループなので、全部リピートにする↓ --EN:--■ Since the event is a loop, repeat all ↓

--■111■中ボス部屋への扉が開く■ --EN:-- ■ 111 ■ The door to the mid-boss room opens ■
function OnEvent_111(proxy,param)
	print("OnEvent_111 begin");
	
	if proxy:IsCompleteEvent( SYSTEM_ID_IGNORE ) == true then
		print("OnEvent_111 end");
		return;
	end
	
	--クライアントへ、ボス部屋阻止失敗を通知 --EN:--Notify client of failure to block boss room
	if proxy:IsClient() == false then
		proxy:LuaCallStart( 4068 , 1 );	
	end
	
	--プロファイルセーブ要求 --EN:--profile save request
	proxy:SaveRequest_Profile();
	
	proxy:LuaCallStart( 112, 1 );--旋回アニメの同期再生 --EN:-- Synchronous playback of turning animation
	--proxy:SetEventFlag( SYSTEM_ID_IGNORE, true );
	--多重起動システムIDをタイムアウトを設定してONにする --EN:--Turn on multiple activation system ID by setting timeout
	proxy:SetSystemIgnore( SYSTEM_ID_IGNORE , IGNORE_TIME );
			
	print("OnEvent_111 end");
end


--旋回アニメの同期再生(IDが別) --EN:-- Synchronized playback of turning animation (ID is different)
function OnEvent_112_1(proxy,param)
	print("OnEvent_112_1 begin");

	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		if param:IsNetMessage() == true then
			--旋回アニメ再生を行い、その終了時にOnEvent_112_2を発行する --EN:--Play the turning animation and issue OnEvent_112_2 at the end
			proxy:TurnCharactor( 10001 + param:GetPlayID(), 2891 );
		else
			proxy:LockSession();--ルームをロックします！ --EN:--lock the room!
			--旋回アニメ再生を行い、その終了時にOnEvent_112_2を発行する --EN:--Play the turning animation and issue OnEvent_112_2 at the end
			proxy:OnTurnCharactorEnd( 112, 10000, 2891, "OnEvent_112_2", once );
		end
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	
	print("OnEvent_112_1 end");
end

--旋回アニメの同期再生終了後 --EN:--After synchronous playback of turning animation ends
function OnEvent_112_2(proxy,param)
	print("OnEvent_112_2 begin");

	--同期用歩きアニメ再生 --EN:--Play walking animation for synchronization
	proxy:LuaCallStart( 4012, 1 );

	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		proxy:OnChrAnimEnd( 112, 10000, ANIMEID_WALK, "OnEvent_112_3", once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	
	print("OnEvent_112_2 end");
end

--歩きアニメの同期再生終了後 --EN:--After the synchronized playback of the walking animation ends
function OnEvent_112_3(proxy,param)
	print("OnEvent_112_3 begin");
	
	--最初の人がボス部屋の中に入り終わっていたら、既に配信されているはずなので、もうおくらないハンドラ --EN:--If the first person has already entered the boss room, it should have already been delivered, so no more handlers
	if proxy:IsCompleteEvent( 111 ) == false then
		proxy:LuaCallStart( 112 , 5 );--2回目以降にボス部屋に入るためのイベント配信用 --EN:--For event delivery to enter the boss room after the second time
		proxy:LuaCallStart( 4045 , 1 );	--クライアントへ、ボス部屋に入れるようになったことを通知 --EN:--Notify clients that they can now enter the boss room
		proxy:LuaCallStart( 112 , 6 );--フラグセット(同期用) --EN:--flag set (for synchronization)
		Lua_MultiDoping(proxy,810);--マルチプレイドーピング --EN:-- Multiplayer Doping
	end

	--プレイヤーが扉の中に完全にはいったタイミングで、ボスの思考をリセット --EN:--Reset the boss' thoughts when the player is completely inside the door
	--場所が悪いとプレイヤーを見つけれないため(攻撃してこない) --EN:--Because you can't find the player if the location is bad (they won't attack)
	if proxy:IsLivePlayer() == true or proxy:IsGreyGhost() == true then
		proxy:ResetThink( 810 );
	end	
	
	proxy:SetEventFlag( SYSTEM_ID_IGNORE, false );
	
	print("OnEvent_112_3 end");
end


--■111 2回目以降にボス部屋に入るためのイベント配信用 --EN:-- 111 For event delivery to enter the boss room after the second time
function OnEvent_111_GO_TO_IN(proxy, param)
	print("OnEvent_111_GO_TO_IN begin");
	
	proxy:NotNetMessage_begin();
		--▼112▼扉が開いているときに中に入るためのイベントを追加▼--ハンドラは OnEvent_111 --EN:--▼112▼Add an event to enter when the door is open▼--The handler is OnEvent_111
		proxy:OnPlayerActionInRegion( 112, 2895, "OnEvent_111", HELPID_GO_TO_IN, everytime );--
	proxy:NotNetMessage_end();	

	print("OnEvent_111_GO_TO_IN end");
end


--■111 フラグセット(同期用) --EN:-- 111 Flag set (for synchronization)
function OnEvent_111_flag_set(proxy, param)
	print("OnEvent_111_flag_set begin");
		
	proxy:SetEventFlag( 111 , 1 );
	proxy:DeleteEvent( 111 );

	print("OnEvent_111_flag_set end");
end



--------------------------------------------------------------------------------------
--ボスが動き出す(戦闘開始)■113 --EN:--Boss begins to move (battle starts) 113
--------------------------------------------------------------------------------------

function OnEvent_113(proxy, param)
	print("OnEvent_113 begin");
	
	--ボス戦用BGM再生開始 --EN:--Start playing BGM for boss battle
	--[[ID未定]] --EN:--[[ID undecided]]
	proxy:PlayPointSE( 2050, SOUND_TYPE_M, 60000000, 0 );
	
	--ボスロジックON --EN:--Boss logic ON
	proxy:EnableLogic( 810 , true );
	
	--ボスイベントスタート --EN:--Boss event start
	BossEventStart_Spider(proxy,param);

	--フラグON --EN:--Flag ON
	proxy:SetEventFlag( 113 ,true );
	
	--ボスゲージ表示 --EN:-- Boss gauge display
	proxy:SetBossGauge(810, 0, 5100);
		
	print("OnEvent_113 end");
end



--[[
--------------------------------------------------------------------------------------
--ハシゴA降り■60 --EN:--Ladder A down 60
--------------------------------------------------------------------------------------
--■60■ハシゴA降りスタート■ --EN:-- ■ 60 ■ Ladder A descent start ■
function OnEvent_60(proxy, param)
	print("OnEvent_60 begin");

	if param:IsNetMessage() == true then
		print("IsNetMessage true");
		print("OnEvent_60 end");
		return;
	end

	--はしご降りに必要な前処理-- --EN:--Pretreatment required for descending the ladder--
	proxy:BeginAction(10000,2,2,2);				--ホバー移動モードに移行 --EN:--Transition to hover movement mode
	proxy:HoverMoveVal(10000,2007,LadderTime_A);--移動位置(2007)に0.5秒でホバー移動 --EN:--Hover in 0.5 seconds to move position (2007)
	proxy:SetEventCommand(10000,1);				--イベントコマンドID(1)"ハシゴ上から掴"むを送る --EN:-- Send event command ID (1) "Grab from the top of the ladder"
	proxy:SetKeepCommandIndex(10000, 0, 1, 3.0 );
	proxy:DisableMove(10000,1);					--キャラクタを移動、旋回不能に --EN:--Move the character, make it impossible to turn
	
	proxy:NotNetMessage_begin();
		--0.5秒(ホバー移動終了)後にはしご降りスタートイベントを発行 --EN:-- Issue a ladder descend start event after 0.5 seconds (end of hover movement)
		proxy:OnKeyTime2(60,"OnEvent_60_1",LadderTime_A,0,0,once);
		--はしご降り専用の関数を3秒間発行(カメラの周り込みなどの処理) --EN:--Issue a function dedicated to descending the ladder for 3 seconds (processing such as surrounding the camera)
		proxy:OnKeyTime2(60,"LadderDown",3,1,1,once);
	proxy:NotNetMessage_end();

	print("OnEvent_60 end");
end

--■60_1■ハシゴA降りスタート:ホバー移動終了■ --EN:--■ 60_1 ■ Start descending from ladder A: End of hover movement ■
function OnEvent_60_1(proxy, param)
	print("OnEvent_60_1 begin");

	if proxy:GetEventMode(10000) == 0 then
		print("Local Player GetEventMode 0");
		print("OnEvent_60_1 end");
		return;
	end

	--ハシゴアクションモードに移行-- --EN:--Transition to ladder action mode--
	--nMax  : はしごの段数 - 補正値(補正値はおおよそ3) --EN:--nMax : number of ladder steps - correction value (correction value is approximately 3)
	--nStart: 降りるとき→(nMax + 1) 昇るとき→(-1) --EN:--nStart: When going down→(nMax + 1) When going up→(-1)
	proxy:BeginAction(10000,1,19,18);
	
	--キャラクタを移動、旋回可能に-- --EN:--Character can be moved and turned--
	proxy:DisableMove(10000,0);

	print("OnEvent_60_1 end");
end


--------------------------------------------------------------------------------------
--ハシゴA昇り■61 --EN:--Ladder A climbing 61
--------------------------------------------------------------------------------------
--■61■ハシゴA昇りスタート■ --EN:-- ■ 61 ■ Ladder A climbing start ■
function OnEvent_61(proxy, param)
	print("OnEvent_61 begin");
	
	if param:IsNetMessage() == true then
		print("IsNetMessage true");
		print("OnEvent_61 end");
		return;
	end
	
	--はしご昇りに必要な前処理-- --EN:--Pretreatment required for climbing a ladder--
	proxy:BeginAction(10000,2,-1,1);			--ホバー移動モードに移行 --EN:--Transition to hover movement mode
	proxy:HoverMoveVal(10000,2006,LadderTime_A);--移動位置(2006)に0.5秒でホバー移動 --EN:--Hover in 0.5 seconds to move position (2006)
	proxy:SetEventCommand(10000,0);				--イベントコマンドID(0)"ハシゴ下から掴"むを送る --EN:-- Send event command ID (0) "grab from under the ladder"
	proxy:SetKeepCommandIndex(10000, 0, 1, 3.0 );
	proxy:DisableMove(10000,1);					--キャラクタを移動、旋回不能に --EN:--Move the character, make it impossible to turn
	
	proxy:NotNetMessage_begin();
		--0.5秒(ホバー移動終了)後にはしご昇りスタートイベントを発行 --EN:-- Issue a ladder climb start event after 0.5 seconds (end of hover movement)
		proxy:OnKeyTime2(61,"OnEvent_61_1",LadderTime_A,0,0,once);
		--はしご昇り用の関数を1秒間発行(イベントメニューの中断処理?) --EN:--Issuing a function for climbing a ladder for 1 second (interruption processing of the event menu?)
		proxy:OnKeyTime2(61,"EventMenuBrake",1,1,1,once);
	proxy:NotNetMessage_end();
	
	print("OnEvent_61 end");
end

--■61_1■ハシゴA昇りスタート:ホバー移動終了■ --EN:--■ 61_1 ■ Ladder A climbing start: Hover movement finished ■
function OnEvent_61_1(proxy, param)
	print("OnEvent_61_1 begin");
	
	if proxy:GetEventMode(10000) == 0 then
		print("Local Player GetEventMode 0");
		print("OnEvent_61_1 end");
		return;
	end

	--ハシゴアクションモードに移行-- --EN:--Transition to ladder action mode--
	--nMax  : はしごの段数 - 補正値(補正値はおおよそ3) --EN:--nMax : number of ladder steps - correction value (correction value is approximately 3)
	--nStart: 降りるとき→(nMax + 1) 昇るとき→(-1) --EN:--nStart: When going down→(nMax + 1) When going up→(-1)
	proxy:BeginAction(10000,1,-1,18);
	
	--キャラクタを移動、旋回可能に-- --EN:--Character can be moved and turned--
	proxy:DisableMove(10000,0);
	
	print("OnEvent_61_1 end");
end
]]
--------------------------------------------------------------------------------------
--次ブロックへの移動ポリ劇(イベント70から発行される)■6176 --EN:--Moving poly play to the next block (issued from event 70) 6176
--------------------------------------------------------------------------------------
--■6176■次ブロックへの移動ポリ劇■ --EN:-- ■ 6176 ■ Move poly play to the next block ■
--別IDで分けてあるのは、ポリ劇のイベントのみをラスボスリセットにするため(?) --EN:--The reason why they are separated by different IDs is that only the events of the polyplay will be the last boss reset (?)
function OnEvent_6176(proxy, param)
	print("OnEvent_6176 begin");

	--ポリ劇再生 --EN:--Poly play
	--次ブロックへいけるようになる --EN:--be able to go to the next block
	
	proxy:SetEventFlag( 6176 , 1 );
	
	print("OnEvent_6176 end");
end


--------------------------------------------------------------------------------------
--ハンドルで歯車を回して擬似エレベーターにする■80 --EN:-- Turn the gear with the handle to make it a pseudo elevator 80
--------------------------------------------------------------------------------------
--■80■ハンドルで歯車を回して擬似エレベーターにする■ --EN:--■80■Turn the gear with the handle to create a pseudo elevator■
function OnEvent_80(proxy, param)
	print("OnEvent_80 begin")
	
	proxy:PlayAnimation( 1016, 1 );--ハンドルアニメ再生 --EN:--Handle animation playback
	
	--OBJ監視は全員が終了を見る --EN:--OBJ monitoring everyone sees the end
	proxy:NotNetMessage_begin();
		--▼80_2▼***条件追加***ハンドルアニメ終了▼ --EN:--▼80_2▼***Conditions added***End handle animation▼
		proxy:OnObjAnimEnd( 80, 1016, 1, "OnEvent_80_1", once );
	proxy:NotNetMessage_end();
	
	--プレイヤーの同期アニメーション(true:パーティープレイヤーがアニメーションした) --EN:--Player synchronous animation (true: party player animated)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_TURN_HANDLE ) == true then 
		return;
	end
	
	proxy:WarpDmy( 10000 , 1016 , 191 );	
	print("OnEvent_80 end")
end

--▲80_2▲ハンドルアニメ終了▲ --EN:--▲80_2▲Handle animation ends▲
function OnEvent_80_1(proxy, param)
	if proxy:IsCompleteEvent( 80 ) == false then
		print("OnEvent_80_1 begin")	
		proxy:LuaCallStart(80,1);	
		print("OnEvent_80_1 end")
	end
end

--▲80_2▲ハンドルアニメ終了の同期▲ --EN:--▲80_2▲Synchronization of handle animation ending▲
function OnEvent_80_2(proxy, param)
	print("OnEvent_80_2 begin")
	
	proxy:SetEventFlag( 80, 1 );	--フラグを立てる --EN:-- flag

	proxy:NotNetMessage_begin();
		--▼80_3▼***条件追加***0.0秒後▼ --EN:--▼80_3▼***Condition added***After 0.0 seconds▼
		proxy:OnKeyTime2( 81, "OnEvent_81", 0.0, 0, 2, once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_80_2 end")
end

--▲81▲0.5秒後▲ --EN:--▲81▲After 0.5 seconds▲
function OnEvent_81(proxy, param)
	print("OnEvent_81 begin")

	--proxy:PlayAnimation( 1019, 1 );	--歯車アニメ再生 --EN:--Gear animation playback
	proxy:SetEventFlag( 81, 1 );	--フラグを立てる --EN:-- flag
	--クライアントのみイベントを監視する --EN:--Watch client-only events
	if proxy:IsClient() == false then
		OnEvent_14(proxy,param);
	end
	proxy:PlayPointSE( 2012, SOUND_TYPE_O, 606130, 6 );
	--proxy:StopPointSE( 1 );
	print("OnEvent_81 end")
end

--ホストの歯車アニメ監視 --EN:--host gear animation monitoring
function OnEvent_14(proxy,param)
	--歯車アニメの再生 --EN:--Play gear animation
	proxy:LuaCallStart( 14 , 0 );
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 14, "OnEvent_14_wait",1.0,0,0,once);
	proxy:NotNetMessage_end();
end

--ホストのアニメ監視秒数待ち --EN:--Wait for host anime monitoring seconds
function OnEvent_14_wait(proxy,param)
	proxy:NotNetMessage_begin();
		proxy:OnObjAnimEndPlus(14 , 1019 , 1 , "OnEvent_14",once );
	proxy:NotNetMessage_end();
end

--同期用ハンドラ --EN:--handler for synchronization
function OnEvent_14_call(proxy,param)
	--print("OnEvent_14_call");
	proxy:ForcePlayAnimation( 1019 , 1 );
end


--[[
--------------------------------------------------------------------------------------
--鍛冶屋上の扉(レバーで扉を開放する)■90 --EN:-- Blacksmith roof door (open the door with the lever) 90
--------------------------------------------------------------------------------------
--■90■レバーで扉を開放する■ --EN:-- ■ 90 ■ Open the door with the lever ■
function OnEvent_90(proxy, param)
	print("OnEvent_90 begin")
	
	proxy:PlayAnimation( 1022, 1 );	--レバーアニメ再生 --EN:--Play lever animation
	
	proxy:NotNetMessage_begin();
		--▼90_2▼***条件追加***レバーアニメ終了▼ --EN:--▼90_2▼***Condition added***Lever animation ends▼
		proxy:OnCharacterAnimEnd( 90, 1022, 1, "OnEvent_90_2", once );
	proxy:NotNetMessage_end();
	
	--プレイヤーの同期アニメーション(true:パーティープレイヤーがアニメーションした) --EN:--Player synchronous animation (true: party player animated)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_PULL_LEVER ) == true then 
		return;
	end
--[[	
	proxy:NotNetMessage_begin();
		--▼90_1▼***条件追加***プレイヤーアニメ終了▼ --EN:--▼90_1▼***Conditions added***End of player animation▼
		proxy:OnChrAnimEnd( 90, 10000, ANIMEID_PULL_LEVER, "OnEvent_90_1", once );
	proxy:NotNetMessage_end();
]]		
--	proxy:Warp( 10000 , 2013 );		--プレイヤーを所定位置にワープ --EN:--Warp player in place
	proxy:WarpDmy( 10000 , 1022 , 191 );
	
--	proxy:DisableMove( 10000, 1 );	--プレイヤーを操作不能に --EN:--Incapacitate player
		
	print("OnEvent_90 end")
end
--[[
--▲90_1▲プレイヤーアニメ終了▲ --EN:--▲90_1▲End of player animation▲
function OnEvent_90_1(proxy, param)
	print("OnEvent_90_1 begin")
		
	proxy:DisableMove( 10000, 0 );	--プレイヤーを操作可能に --EN:--Make player controllable
	
	print("OnEvent_90_1 end")
end
]]
--▲90_2▲レバーアニメ終了▲ --EN:--▲90_2▲Lever animation ends▲
function OnEvent_90_2(proxy, param)
	print("OnEvent_90_2 begin")
	
	proxy:SetEventFlag( 90, 1 );	--フラグを立てる --EN:-- flag

	proxy:NotNetMessage_begin();
		--▼90_3▼***条件追加***0.5秒後に扉が開く▼ --EN:--▼90_3▼***Condition added***Door opens after 0.5 seconds▼
		proxy:OnKeyTime2( 91, "OnEvent_91", 0.5, 0, 1, once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_90_2 end")
end

--▲91▲0.5秒後に扉が開く▲ --EN:--▲91▲The door will open after 0.5 seconds▲
function OnEvent_91(proxy, param)
	print("OnEvent_91 begin");
	
	proxy:PlayAnimation( 1021, 1 );	--扉が開くアニメ再生 --EN:--Play an animation where the door opens
	proxy:SetEventFlag( 91, 1 );	--フラグを立てる --EN:-- flag
	
	print("OnEvent_91 end");
end
]]


--------------------------------------------------------------------------------------
--石柱にワープ■150 --EN:-- Warp to the stone pillar ■ 150
--------------------------------------------------------------------------------------

--■150■石柱にワープ■ --EN:-- ■ 150 ■ Warp to the stone pillar ■
function OnEvent_150(proxy,param)	

	if proxy:IsCompleteEvent( 150 ) == true then
		return;
	end
	
	if param:IsNetMessage() == true then
		return;
	end
	
	
	print("OnEvent_150 begin");
	
	--セッション中ならば、要石のワープ無効 --EN:--Disable keystone warp if in session
	if proxy:IsSession() == false then--セッション中ではない --EN:--not in session
		proxy:RepeatMessage_begin();
			--▼150_1▼選択メニューの監視▼ --EN:--▼150_1▼Monitor selection menu▼
			proxy:OnSelectMenu(150, "OnEvent_150_0", 10010710, 0, 2, 1983, 2, once);			
		proxy:RepeatMessage_end();
	else--セッション中 --EN:--in session
		--エラー表示「セッション中は楔の神殿には戻れません」 --EN:--Error display "You cannot return to the Temple of the Wedge during a session"
		--proxy:InfomationMenu( INFOMENU_TYPE_SIMPLE, 0, MSG_CATEGORY_EVENT, 10010720, 1);
		--proxy:ShowGenDialog(10010720,1,1,true);
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010720, 0, 6, 1983, GEN_DIALOG_DIST, once );
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
	end

	print("OnEvent_150 end");
end

--▲150_0▲選択メニューの監視▲ --EN:--▲150_0▲Monitor selection menu▲
function OnEvent_150_0(proxy, param)
	print("OnEvent_150_0 begin");	
	
	if proxy:IsSession() == false then
		proxy:PlayAnimation( 10000 , 8283 );--要石に触れるアニメを再生 --EN:--Play the animation that touches the keystone
		proxy:NoAnimeTurnCharactor( 10000 , 1983 ,TURNSKIP_ANGLE);
		
		proxy:NotNetMessage_begin();
			--▼要石に触れるアニメ再生終了▼ --EN:--▼Animation touching the keystone ends▼
			proxy:OnChrAnimEnd( 150 , 10000 , 8283 , "OnEvent_150_1" , once );
		proxy:NotNetMessage_end();

		proxy:SetEventFlag( 150 , 1 );
	else
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010720, 0, 6, 1983, GEN_DIALOG_DIST, once );
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
	end
	
	print("OnEvent_150_0 end");
end

--▲150_1▲選択メニューの監視▲ --EN:--▲150_1▲Monitor selection menu▲
function OnEvent_150_1(proxy, param)
	print("OnEvent_150_1 begin");
	
	proxy:SetEventFlag( 150 , 0 );
	
	proxy:PlayAnimation( 10000 , 8284 );--要石に触れるアニメを再生 --EN:--Play the animation that touches the keystone

	proxy:SetEventFlag( 150 , 1 );
	
	OnEvent_150_2(proxy, param);
	
	print("OnEvent_150_1 end");
end

--▲150_2▲要石に触れるアニメ再生終了▲ --EN:--▲150_2▲Ends playing the animation touching the keystone▲
function OnEvent_150_2(proxy,param)	
	print("OnEvent_150_2 begin");
	
	--石柱へ戻ってきた判定のフラグを立てる --EN:--Flag the judgment of returning to the stone pillar
	proxy:SetEventFlag(8083, true);

	proxy:SetEventFlag( 150 , 0 );
	--完全回復要求 --EN:-- full recovery request
	proxy:RequestFullRecover();
	proxy:WarpNextStage( 1, 0, 0, 0, 1010 );
	
	print("OnEvent_150_2 end");
end


--------------------------------------------------------------------------------------
--■151■最初の要石の光が消える■ --EN:--■151■The first keystone's light disappears■
--------------------------------------------------------------------------------------

function OnEvent_151(proxy, param)
	print("OnEvent_151 begin");
	
	proxy:TreasureDispModeChange2( 1983 , false ,KANAME_SFX);
	
	print("OnEvent_151 end");
end


--------------------------------------------------------------------------------------
--■152■最初の要石の光が復活する■ --EN:-- ■ 152 ■ The light of the first keystone is restored ■
--------------------------------------------------------------------------------------

function OnEvent_152(proxy, param)
	print("OnEvent_152 begin");
	
	proxy:TreasureDispModeChange2( 1983 , true ,KANAME_SFX);
	
	print("OnEvent_152 end");
end



--------------------------------------------------------------------------------------
--中ボス死亡■6174 --EN:-- Mid-boss died ■ 6174
--------------------------------------------------------------------------------------
--■6174■中ボス死亡■ --EN:-- ■ 6174 ■ Mid-boss death ■
function OnEvent_6174(proxy,param)
	print("OnEvent_6174 begin");

	proxy:NotNetMessage_begin();
		--▼6174_1▼0秒後▼ --EN:--▼6174_1▼After 0 seconds▼
		proxy:OnKeyTime2( 6174 , "OnEvent_6174_1" , 0 , 0 , 1 , once );
		--マルチ解散監視 --EN:--Multi-Dismissal Monitoring
		proxy:OnRegistFunc( 6174,"Check_6174_PT","OnEvent_6174_PT",0,once);
	proxy:NotNetMessage_end();

	proxy:SetEventFlag( 6174, 1 );
	
	--ボスが死亡で蜘蛛の巣イベントが無効化される --EN:--The spider web event is disabled when the boss dies
	--proxy:DeleteEvent( 211 );
	--proxy:DeleteEvent( 212 );
	--proxy:DeleteEvent( 213 );
	--ここまで --EN:--to this point
	
	print("OnEvent_6174 end");
end

function OnEvent_6174_1(proxy,param)
	print("OnEvent_6174_1 begin");

	--ボスを倒した数を更新(数によってフラグを立てる) --EN:--update number of bosses killed (flag by number)
	GetBossFlagCount( proxy, param );
	
	--▼トロフィー取得判定▼ --EN:--▼Trophy Acquisition Judgment▼
	Lua_RequestUnlockTrophy(proxy, 36);--トロフィの取得状況を判定し、取得する --EN:-- Determine the acquisition status of trophies and acquire them
	
--アイテム入手関連------- --EN:--Item Acquisition Related-------
	
	--ホストプレイヤーのみアイテム入手イベントに使用 --EN:--Used for item acquisition event only for host players
	local possible_chr_type = ATTR_HOST + ATTR_LIVE + ATTR_GREY;

	--宝死体(ソウル?)有効化 --EN:--Treasure corpse (soul?) activation
	proxy:SetDrawEnable( 1982 , true );
	proxy:SetColiEnable( 1982 , true );
	--宝死体(ソウル?)有効化 --EN:--Treasure corpse (soul?) activation
	proxy:SetDrawEnable( 1975 , true );
	proxy:SetColiEnable( 1975 , true );
	
	--▼(ソウル)アイテム取得用イベント監視追加▼ --EN:--▼ (Soul) Added event monitoring for item acquisition▼
	if proxy:IsCompleteEvent( 6193 ) == false then
		--SFXON
		proxy:ValidSfx( 2131 );--光の粒子 --EN:--Particles of light
		proxy:ValidSfx( 2132 );--要石のオーラ --EN:--Keystone Aura
		proxy:TreasureDispModeChange2( 1982 , true ,KANAME_SFX);--光らせる --EN:-- let it shine
		proxy:OnDistanceActionAttribute( 6193 , 10000 , 1982 , "OnEvent_6193" , WarpGimmickDist_A , 10010180 , 0 , 180 , possible_chr_type, once );
	end
	
	--ボス戦用のBGM停止 --EN:--BGM stop for boss battles
	--[[再生させていないので･･･]] --EN:--[[I'm not playing it...]]
	proxy:StopPointSE( 0 );
	
------------------------	
	--中ボス部屋魔法壁のSFX削除 --EN:--Remove the SFX of the mid-boss room magic wall
	--光の壁Sfxを消す --EN:--Turn off the wall of light Sfx
	--proxy:DeleteObjSfxEventID( 1999 );
	--proxy:DeleteObjSfxEventID( 1995 );	
	
	--新ブロッククリア処理へ --EN:--To new block clear processing
	proxy:CustomLuaCallStart( 4050, 810);
	--トカゲリセット --EN:-- lizard reset
	ResetTokage(proxy);
	
	print("OnEvent_6174_1 end");
end

--マルチ解散監視 --EN:--Multi-Dismissal Monitoring
function Check_6174_PT(proxy)
	if proxy:IsInParty() == false then
		return true;
	end
	return false;
end

--マルチじゃない --EN:--not multiplayer
function OnEvent_6174_PT(proxy,param)
	print("OnEvent_6174_PT begin");
	
	proxy:SetDrawEnable(1995,false);
	proxy:SetColiEnable(1995,false);
	
	proxy:SetDrawEnable(1999,false);
	proxy:SetColiEnable(1999,false);	
	
	proxy:InvalidSfx( 1987, true );
	proxy:InvalidSfx( 1991, true );
	
	--中ボス部屋前の移動処理イベントを削除 --EN:--Delete the movement processing event in front of the mid-boss room
	proxy:DeleteEvent( 111 );--一人目が入るとき用 --EN:--For when the first person enters
	proxy:DeleteEvent( 112 );--二人目以降が入るとき用 --EN:--For when the second and subsequent people enter
	proxy:DeleteEvent( 113 );--ボス戦闘開始用 --EN:--For boss battle start
	
	--ボス部屋用のアタリ無効化対応 --EN:--Atari disablement support for boss room
	proxy:SetColiEnableArray(3001,true);--通常有効 --EN:--usually valid
	proxy:SetColiEnableArray(3002,true);--通常有効 --EN:--usually valid
	proxy:SetColiEnableArray(3005,true);--通常有効 --EN:--usually valid
	proxy:SetColiEnableArray(3006,true);--通常有効 --EN:--usually valid
	proxy:SetColiEnableArray(3009,true);--通常有効 --EN:--usually valid
	proxy:SetColiEnableArray(3010,true);--通常有効		 --EN:--usually valid
	proxy:SetColiEnableArray(3003,false);--ボス用無効 --EN:--disabled for boss
	proxy:SetColiEnableArray(3004,false);--ボス用無効 --EN:--disabled for boss
	proxy:SetColiEnableArray(3007,false);--ボス用無効 --EN:--disabled for boss
	proxy:SetColiEnableArray(3008,false);--ボス用無効 --EN:--disabled for boss
	proxy:SetColiEnableArray(3011,false);--ボス用無効 --EN:--disabled for boss
	proxy:SetColiEnableArray(3012,false);--ボス用無効 --EN:--disabled for boss
	
	print("OnEvent_6174_PT end");
end

--------------------------------------------------------------------------------------
--■6194■石柱にワープ■ --EN:-- ■ 6194 ■ Warp to the stone pillar ■
--------------------------------------------------------------------------------------
function OnEvent_6194(proxy,param)	
	print("OnEvent_6194 begin");
	
	if proxy:IsCompleteEvent( 6194 ) == true then
		return;
	end
	
	proxy:RepeatMessage_begin();
		--▼70_1▼選択メニューの監視▼ --EN:--▼70_1▼Select menu monitoring▼
		proxy:OnSelectMenu(6194, "OnEvent_6194_1", 10010710, 0, 2, 1982, 2, once);			
	proxy:RepeatMessage_end();
	
	print("OnEvent_6194 end");
end

--▲6194_1▲選択メニューの監視▲ --EN:--▲6194_1▲Monitor selection menu▲
function OnEvent_6194_1(proxy,param)	
	print("OnEvent_6194_1 begin");	
	
	if proxy:IsSession() == false then
		proxy:PlayAnimation(10000,8283);
		proxy:NoAnimeTurnCharactor( 10000 , 1982 ,TURNSKIP_ANGLE);

		proxy:NotNetMessage_begin();
			proxy:OnChrAnimEnd( 6194 , 10000 , 8283 , "OnEvent_6194_2",once);
		proxy:NotNetMessage_end();
		
		proxy:SetEventFlag(6194,true);
	else
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010720, 0, 6, 1983, GEN_DIALOG_DIST, once );
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
	end
	
	print("OnEvent_6194_1 end");
end

--▲6194_2▲選択メニューの監視▲ --EN:--▲6194_2▲Monitor selection menu▲
function OnEvent_6194_2(proxy,param)	
	print("OnEvent_6194_2 begin");
	
	proxy:SetEventFlag(6194,false);
	
	proxy:PlayAnimation(10000,8284);

	proxy:SetEventFlag(6194,true);

	OnEvent_6194_3(proxy, param);
	
	print("OnEvent_6194_2 end");
end

--■6194_3■石柱にワープ■ --EN:--■ 6194_3 ■ Warp to the stone pillar ■
function OnEvent_6194_3(proxy,param)	
	print("OnEvent_6194_3 begin");

	--石柱へ戻ってきた判定のフラグを立てる --EN:--Flag the judgment of returning to the stone pillar
	proxy:SetEventFlag(8083, true);
	
	proxy:SetEventFlag(6194,false);
	--完全回復要求 --EN:-- full recovery request
	proxy:RequestFullRecover();
	--古砦要石に戻る --EN:--Return to Old Fort Keystone
	proxy:WarpNextStage( 1, 0, 0, 0, 1010);	
	print("OnEvent_6194_3 end");
end

--------------------------------------------------------------------------------------
--■6193■ソウル入手■ --EN:-- ■ 6193 ■ Get Seoul ■
--------------------------------------------------------------------------------------
function OnEvent_6193(proxy, param)
	print("OnEvent_6193 begin");
	
	--プレイヤーの同期アニメーション(true:パーティープレイヤーがアニメーションした) --EN:--Player synchronous animation (true: party player animated)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_PICK ) == true then--新しいアニメ  --EN:-- new anime
		print("OnEvent_6193 end");
		return true;
	end
	
	proxy:NotNetMessage_begin();
		--0.0秒後にアイテム取得イベントを発行 --EN:-- Issue an item acquisition event after 0.0 seconds
		proxy:OnKeyTime2( 6193, "OnEvent_6193_1", 0.0, 0, 0, once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_6193 end");
end


--■6193_1■アイテム取得■ --EN:-- ■ 6193_1 ■ item acquisition ■
function OnEvent_6193_1(proxy, param)
	print("OnEvent_6193_1 begin");

	--アイテム取得関数--パラメータ10630参照 --EN:--get item function--see parameter 10630
	proxy:GetRateItem(10630);
	--アイテム取得関数--パラメータ10670参照 --EN:--get item function--see parameter 10670
	proxy:GetRateItem(10670);
	--アイテム取得関数--パラメータ10671参照 --EN:--get item function--see parameter 10671
	proxy:GetRateItem(10671);
	--アイテム取得関数--パラメータ10672参照 --EN:--item retrieval function--see parameter 10672
	proxy:GetRateItem(10672);
	--アイテム取得関数--パラメータ10673参照 --EN:--item retrieval function--see parameter 10673
	proxy:GetRateItem(10673);
	
	--アイテムを取得済み --EN:--item already acquired
	proxy:SetEventFlag( 6193, 1 );
	
	--宝シェーダーOFF --EN:--Treasure Shader OFF
	--proxy:TreasureDispModeChange( 1982 , false );

	--SFXが消える --EN:--SFX disappear
	proxy:InvalidSfx( 2131 , true );--光の粒子 --EN:--Particles of light
	--proxy:InvalidSfx( 2132 , true );--要石のオーラ --EN:--Keystone Aura
	
	--▼要石でワープ用の監視を追加▼ --EN:--▼ Added surveillance for warp with keystone ▼
	proxy:OnDistanceActionAttribute( 6194 , 10000 , 1982 , "OnEvent_6194" , WarpGimmickDist_A , HELPID_GO_TO_SEKITYUU , 0 , 180 , ATTR_NOSESSION , everytime );

	print("OnEvent_6193_1 end");
end

--------------------------------------------------------------------------------------
--徘徊デーモンの登場■?? --EN:-- Appearance of the Wandering Demon ??
--------------------------------------------------------------------------------------

--▼グローバルの死亡監視から呼ばれる(ソロ) --EN:--▼ Called from global death watch (solo)
function PlayerDeath_m06_00_00_00(proxy, param)
	print("PlayerDeath_m06_00_00_00");
	
--	LuaFunc_VisibleTheWanderingDemon(proxy, param, demon_id_list_m06_00_00_00);
--	proxy:SetEventFlag( 20 , 1 );--フラグは仮、指定があれば変える。 --EN:The -- flag is tentative, and will be changed if specified.
	
	print("PlayerDeath_m06_00_00_00");
end

--▼グローバルの血文字復活から呼ばれる(ソロ) --EN:--▼Called from global blood letter revival (solo)
function PlayerRevive_m06_00_00_00(proxy,param)
	print("PlayerRevive_m06_00_00_00");
	
--	LuaFunc_InvisibleTheWanderingDemon(proxy, param, demon_id_list_m06_00_00_00);
--	proxy:SetEventFlag( 20 , 0 );--フラグは仮、指定があれば変える。 --EN:The -- flag is tentative, and will be changed if specified.
	
	print("PlayerRevive_m06_00_00_00");
end




--------------------------------------------------------------------------------------
--徘徊ゴースト目撃イベント■124 --EN:--Wandering Ghost Sighting Event 124
--------------------------------------------------------------------------------------
--初期化 --EN:--Initialization
function OnEvent_124_Init(proxy,param)
	print("OnEvent_124_Init begin");
	proxy:SetIgnoreHit(664,true);
	proxy:SetDisableGravity(664,true);
	proxy:EnableLogic( 664, false );
	proxy:SetDrawEnable( 664, false );
	--proxy:EnableInvincible( 664 , true );
	--proxy:EnableHide( 664, true );--索敵されない --EN:-- not searched
	print("OnEvent_124_Init end");
end

--領域に入っている間のイベント --EN:-- events while entering the region
function OnEvent_124(proxy,param)
	--目撃イベントのフラグ,レバーイベントのフラグの両方がOFFなら発生 --EN:--Occurs if both the sighting event flag and the lever event flag are OFF
	if proxy:IsCompleteEvent(124) == false and proxy:IsCompleteEvent(127) == false then
		--print("OnEvent_124 begin");						
		proxy:NotNetMessage_begin();
			proxy:SetDrawEnable( 664, true );
			proxy:OnWanderFade(124,664,2.0,2.0,8.0,10.0,once);
			--次回発生用のウェイト+ランダムする？ --EN:--Wait for next occurrence + random?
			proxy:OnKeyTime2(125,"OnEvent_124_NextWait",EVENT_TIME01,0,1,once);
			--とりあえず即アニメは味気ないので・・・若干遅らせてみる --EN:-- For the time being, immediate animation is boring, so I'll try to delay it a bit
			proxy:OnKeyTime2(125,"OnEvent_124_1",2,0,2,once);
			--描画だけON			 --EN:-- only drawing ON
			--proxy:SetDrawEnable( 664, true );			
			--連続発生しないようにフラグON			 --EN:--Flag ON to prevent continuous occurrence
			proxy:SetEventFlag(124,true);
		proxy:NotNetMessage_end();
		--print("OnEvent_124 end");
	end
end

--数秒経過のイベント --EN:--Event after a few seconds
function OnEvent_124_1(proxy,param)
	--print("OnEvent_124_1 begin");
	
	proxy:WarpDmy( 664 , 1000 , 191 );
	--レバーアニメ再生 --EN:--Play lever animation
	proxy:PlayAnimation(664,8000);
	proxy:NotNetMessage_begin();
		proxy:RepeatMessage_begin();
			proxy:OnChrAnimEnd(125,664,8000,"OnEvent_125",once);
		proxy:RepeatMessage_end();
	proxy:NotNetMessage_end();
	--print("OnEvent_124_1 end");
end

--アニメ終了のイベント --EN:--Anime end event
function OnEvent_125(proxy,param)
	--print("OnEvent_125 begin");
	--proxy:SetDrawEnable( 664, false);			
	--print("OnEvent_125 end");
end

--ウェイト秒数経過のイベント --EN:--Event after wait seconds passed
function OnEvent_124_NextWait(proxy,param)
	--print("OnEvent_124_NextWait begin");
	--チェック用のイベントをOFFにする --EN:--Turn off event for check
	proxy:DeleteEvent(125);
	proxy:SetEventFlag(124,false);
	--print("OnEvent_124_NextWait end");
end


--------------------------------------------------------------------------------------
--■121■ホストPCのみが通れる光の霧■ --EN:-- ■ 121 ■ A fog of light that only the host PC can pass through ■
--------------------------------------------------------------------------------------
--■121_delete_wall■魔法壁削除同期用■ --EN:--■121_delete_wall■For synchronized magic wall deletion■
function OnEvent_121_delete_wall(proxy , param)
	print("OnEvent_121_delete_wall begin");
	
	proxy:SetDrawEnable( 1111 , false );--魔法壁描画OFF --EN:--Magic Wall Drawing OFF
	proxy:SetColiEnable( 1111 , false );--魔法壁当たりOFF	 --EN:--Magic wall hit OFF
	proxy:SetObjDeactivate( 1111 , true );--デアクティブ --EN:--deactivate
	proxy:DeleteEvent( 121 );--全プレイヤー分の監視消えるはず。 --EN:--Surveillance for all players should disappear.
	proxy:InvalidSfx( 2040, true );
	
	print("OnEvent_121_delete_wall end");
end

--■121■イベント発動用■ --EN:-- ■ 121 ■ For event activation ■
function OnEvent_121(proxy , param)
	print("OnEvent_121 begin");

	--多重発動防止 --EN:--Multiple activation prevention
	if proxy:IsCompleteEvent( 121 ) == true then
		print("OnEvent_121 end");
		return;
	end
	
	--プレイヤーの同期アニメーション(true:パーティープレイヤーがアニメーションした) --EN:--Player synchronous animation (true: party player animated)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_WALK ) == true then
		proxy:SetEventFlag( 121 , 1 );
		print("OnEvent_121 end");
		return;
	end
	
	--ダミポリへワープ --EN:--Warp to Damipoli
	proxy:WarpDmy( 10000 , 1111 , 191 );
	
	proxy:NotNetMessage_begin();
		--▼240_1▼歩きアニメ終了▼ --EN:--▼240_1▼End of walking animation▼
		--proxy:OnChrAnimEnd( 121 , 10000 , ANIMEID_WALK , "OnEvent_121_1" , once );
		proxy:LuaCallStart( 121 , 1 );--光の霧削除同期 --EN:--light fog removal sync
	proxy:NotNetMessage_end();
	
	proxy:SetEventFlag( 121 , 1 );
	
	--プロファイルセーブ要求 --EN:--profile save request
	proxy:SaveRequest_Profile();
	
	print("OnEvent_121 end");
end

--▲121_1▲歩きアニメ終了▲ --EN:--▲121_1▲End of walking animation▲
function OnEvent_121_1(proxy , param)
	print("OnEvent_121_1 begin");
	
	proxy:LuaCallStart( 121 , 1 );--光の霧削除同期 --EN:--light fog removal sync
	
	print("OnEvent_121_1 end");
end


--------------------------------------------------------------------------------------
--■122■ホストPCのみが通れる光の霧■ --EN:-- ■ 122 ■ A fog of light that only the host PC can pass through ■
--------------------------------------------------------------------------------------
--■122_delete_wall■魔法壁削除同期用■ --EN:--■122_delete_wall■For synchronized magic wall deletion■
function OnEvent_122_delete_wall(proxy , param)
	print("OnEvent_122_delete_wall begin");
	
	proxy:SetDrawEnable( 1112 , false );--魔法壁描画OFF --EN:--Magic Wall Drawing OFF
	proxy:SetColiEnable( 1112 , false );--魔法壁当たりOFF	 --EN:--Magic wall hit OFF
	proxy:SetObjDeactivate( 1112 , true );--デアクティブ --EN:--deactivate
	proxy:DeleteEvent( 122 );--全プレイヤー分の監視消えるはず。 --EN:--Surveillance for all players should disappear.
	proxy:InvalidSfx( 2041, true );
	
	print("OnEvent_122_delete_wall end");
end

--■122■イベント発動用■ --EN:-- ■ 122 ■ For event activation ■
function OnEvent_122(proxy , param)
	print("OnEvent_122 begin");

	--多重発動防止 --EN:--Multiple activation prevention
	if proxy:IsCompleteEvent( 122 ) == true then
		print("OnEvent_122 end");
		return;
	end
	
	--プレイヤーの同期アニメーション(true:パーティープレイヤーがアニメーションした) --EN:--Player synchronous animation (true: party player animated)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_WALK ) == true then
		proxy:SetEventFlag( 122 , 1 );
		print("OnEvent_122 end");
		return;
	end
	
	--ダミポリへワープ --EN:--Warp to Damipoli
	proxy:WarpDmy( 10000 , 1112 , 191 );
	
	proxy:NotNetMessage_begin();
		--▼240_1▼歩きアニメ終了▼ --EN:--▼240_1▼End of walking animation▼
		--proxy:OnChrAnimEnd( 122 , 10000 , ANIMEID_WALK , "OnEvent_122_1" , once );
		proxy:LuaCallStart( 122 , 1 );--光の霧削除同期 --EN:--light fog removal sync
	proxy:NotNetMessage_end();
	
	proxy:SetEventFlag( 122 , 1 );
	
	--プロファイルセーブ要求 --EN:--profile save request
	proxy:SaveRequest_Profile();
	
	print("OnEvent_122 end");
end

--▲122_1▲歩きアニメ終了▲ --EN:--▲122_1▲End of walking animation▲
function OnEvent_122_1(proxy , param)
	print("OnEvent_122_1 begin");
	
	proxy:LuaCallStart( 122 , 1 );--光の霧削除同期 --EN:--light fog removal sync
	
	print("OnEvent_122_1 end");
end


--------------------------------------------------------------------------------------
--■123■ホストPCのみが通れる光の霧■ --EN:-- ■ 123 ■ A fog of light that only the host PC can pass through ■
--------------------------------------------------------------------------------------
--■123_delete_wall■魔法壁削除同期用■ --EN:--■123_delete_wall■For synchronized magic wall deletion■
function OnEvent_123_delete_wall(proxy , param)
	print("OnEvent_123_delete_wall begin");
	
	proxy:SetDrawEnable( 1113 , false );--魔法壁描画OFF --EN:--Magic Wall Drawing OFF
	proxy:SetColiEnable( 1113 , false );--魔法壁当たりOFF	 --EN:--Magic wall hit OFF
	proxy:SetObjDeactivate( 1113 , true );--デアクティブ --EN:--deactivate
	proxy:DeleteEvent( 123 );--全プレイヤー分の監視消えるはず。 --EN:--Surveillance for all players should disappear.
	proxy:InvalidSfx( 2042, true );
	
	print("OnEvent_123_delete_wall end");
end

--■123■イベント発動用■ --EN:-- ■ 123 ■ For event activation ■
function OnEvent_123(proxy , param)
	print("OnEvent_123 begin");

	--多重発動防止 --EN:--Multiple activation prevention
	if proxy:IsCompleteEvent( 123 ) == true then
		print("OnEvent_123 end");
		return;
	end
	
	--プレイヤーの同期アニメーション(true:パーティープレイヤーがアニメーションした) --EN:--Player synchronous animation (true: party player animated)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_WALK ) == true then
		proxy:SetEventFlag( 123 , 1 );
		print("OnEvent_123 end");
		return;
	end
	
	--ダミポリへワープ --EN:--Warp to Damipoli
	proxy:WarpDmy( 10000 , 1113 , 191 );
	
	proxy:NotNetMessage_begin();
		--▼240_1▼歩きアニメ終了▼ --EN:--▼240_1▼End of walking animation▼
		--proxy:OnChrAnimEnd( 123 , 10000 , ANIMEID_WALK , "OnEvent_123_1" , once );
		proxy:LuaCallStart( 123 , 1 );--光の霧削除同期 --EN:--light fog removal sync
	proxy:NotNetMessage_end();
	
	proxy:SetEventFlag( 123 , 1 );
	
	--プロファイルセーブ要求 --EN:--profile save request
	proxy:SaveRequest_Profile();
	
	print("OnEvent_123 end");
end

--▲123_1▲歩きアニメ終了▲ --EN:--▲123_1▲End of walking animation▲
function OnEvent_123_1(proxy , param)
	print("OnEvent_123_1 begin");
	
	proxy:LuaCallStart( 123 , 1 );--光の霧削除同期 --EN:--light fog removal sync
	
	print("OnEvent_123_1 end");
end


--------------------------------------------------------------------------------------
--■70■ハンドル回してフロア移動■ --EN:-- ■ 70 ■ Rotate the handle to move to the floor ■
--------------------------------------------------------------------------------------
function OnEvent_70(proxy,param)
	--両方ONならアニメ中	 --EN:-- If both are ON, animation is in progress
	if proxy:IsCompleteEvent(130) == true and proxy:IsCompleteEvent(132) == true then
		--発動者だけインフォ --EN:--Invoker only info
		if param:IsNetMessage() == false then
			--扉が開かない場合のメッセージを表示 --EN:-- Display a message when the door does not open
			--proxy:InfomationMenu( INFOMENU_TYPE_SIMPLE, 0, MSG_CATEGORY_EVENT, 10010170, 1);
			--proxy:ShowGenDialog(10010170,1,1,true);
			proxy:RepeatMessage_begin();
			proxy:NotNetMessage_begin();
				proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010170, 0, 6, -1, GEN_DIALOG_DIST, once );
			proxy:NotNetMessage_end();
			proxy:RepeatMessage_end();
		end		
		return;
	end
	
	print("OnEvent_70 begin");
	if proxy:IsCompleteEvent(72) == false then
		proxy:PlayAnimation(1023,1);		
	else
		proxy:PlayAnimation(1023,2);		
	end
	--両方ON＞アニメ中 --EN:--Both ON > during animation
	proxy:SetEventFlag(130,true);
	proxy:SetEventFlag(132,true);
	
	proxy:NotNetMessage_begin();
		proxy:RepeatMessage_begin();
			if proxy:IsCompleteEvent(72) == false then				
				proxy:OnObjAnimEnd(70,1023,1,"OnEvent_70_1",once);
				proxy:SetEventFlag( 72 , true );
			else			
				proxy:OnObjAnimEnd(70,1023,2,"OnEvent_70_1",once);
				proxy:SetEventFlag( 72 , false );
			end
		proxy:RepeatMessage_end();
	proxy:NotNetMessage_end();
	
	if Luafunc_PlaySynchroAnimation(proxy,param,ANIMEID_TURN_HANDLE) == true then		
		return;
	end
	proxy:WarpDmy(10000,1023,191);	
	print("OnEvent_70 end");
	
end

--上下アニメ共通終了 --EN:--Common end of top and bottom animation
function OnEvent_70_1(proxy,param)
	--フラグ配信はホストのみ行う --EN:--Flag delivery only to host
	if proxy:IsClient() == false then
		print("OnEvent_70_1 begin");
		proxy:LuaCallStart(70,1);
		print("OnEvent_70_1 end");
	end
end

--フラグ同期 --EN:--flag sync
function OnEvent_70_flag(proxy,param)
	print("OnEvent_70_flag begin");
	if proxy:IsCompleteEvent(72) == false then
		--proxy:SetEventFlag(72,false);	--上についた --EN:-- got on
		proxy:SetEventFlag(132,false);	--下レバー有効 --EN:--Lower lever enabled
	else
		--proxy:SetEventFlag(72,true);	--下についた --EN:-- got down
		proxy:SetEventFlag(130,false);	--上レバー有効 --EN:--Upper lever enabled
	end
	print("OnEvent_70_flag end");
end


--------------------------------------------------------------------------------------
--■129■上にエレベーター呼び戻し■ --EN:-- ■ 129 ■ Call back the elevator to the top ■
--------------------------------------------------------------------------------------
function OnEvent_129(proxy,param)
	print("OnEvent_129 begin");
	--既に上orアニメ中 --EN:-- Already up or in animation
	if proxy:IsCompleteEvent(130) == true then
		--発動者だけインフォ --EN:--Invoker only info
		if param:IsNetMessage() == false then
			--扉が開かない場合のメッセージを表示 --EN:-- Display a message when the door does not open
			--proxy:InfomationMenu( INFOMENU_TYPE_SIMPLE, 0, MSG_CATEGORY_EVENT, 10010170, 1);
			--proxy:ShowGenDialog(10010170,1,1,true);
			proxy:RepeatMessage_begin();
			proxy:NotNetMessage_begin();
				proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010170, 0, 6, 1024, GEN_DIALOG_DIST, once );
			proxy:NotNetMessage_end();
			proxy:RepeatMessage_end();
		end		
		print("flag 130 On");
		print("OnEvent_129 end");
		return;
	end	
	
	proxy:PlayAnimation(1024,1);
	if proxy:IsCompleteEvent(72) == false then
		proxy:PlayAnimation(1023,1);
	else
		proxy:PlayAnimation(1023,2);
	end
	--両方ON＞アニメ中 --EN:--Both ON > during animation
	proxy:SetEventFlag(130,true);
	proxy:SetEventFlag(132,true);
	
	proxy:NotNetMessage_begin();
		proxy:RepeatMessage_begin();
			if proxy:IsCompleteEvent(72) == false then
				proxy:OnObjAnimEnd(70,1023,1,"OnEvent_70_1",once);
				proxy:SetEventFlag( 72, true );
			else
				proxy:OnObjAnimEnd(70,1023,2,"OnEvent_70_1",once);
				proxy:SetEventFlag( 72, false );
			end
		proxy:RepeatMessage_end();
	proxy:NotNetMessage_end();
	
	if Luafunc_PlaySynchroAnimation(proxy,param,ANIMEID_TURN_HANDLE) == true then		
		return;
	end	
	proxy:WarpDmy(10000,1024,191);		
	print("OnEvent_129 end");
end


--------------------------------------------------------------------------------------
--■131■下にエレベーター呼び戻し■ --EN:-- ■ 131 ■ Call the elevator down ■
--------------------------------------------------------------------------------------
function OnEvent_131(proxy,param)
	print("OnEvent_131 begin");
	--既に下 --EN:--already below
	if proxy:IsCompleteEvent(132) == true then
		--発動者だけインフォ --EN:--Invoker only info
		if param:IsNetMessage() == false then
			--扉が開かない場合のメッセージを表示 --EN:-- Display a message when the door does not open
			--proxy:InfomationMenu( INFOMENU_TYPE_SIMPLE, 0, MSG_CATEGORY_EVENT, 10010170, 1);
			--proxy:ShowGenDialog(10010170,1,1,true);
			proxy:RepeatMessage_begin();
			proxy:NotNetMessage_begin();
				proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010170, 0, 6, 1025, GEN_DIALOG_DIST, once );
			proxy:NotNetMessage_end();
			proxy:RepeatMessage_end();
		end		
		print("flag 130 On");
		print("OnEvent_131 end");
		return;
	end
	
	proxy:PlayAnimation(1025,1);
	if proxy:IsCompleteEvent(72) == false then
		proxy:PlayAnimation(1023,1);
	else
		proxy:PlayAnimation(1023,2);
	end
	--両方ON＞アニメ中 --EN:--Both ON > during animation
	proxy:SetEventFlag(130,true);
	proxy:SetEventFlag(132,true);	
	
	proxy:NotNetMessage_begin();
		proxy:RepeatMessage_begin();
			if proxy:IsCompleteEvent(72) == false then
				proxy:OnObjAnimEnd(70,1023,1,"OnEvent_70_1",once);
				proxy:SetEventFlag( 72 , true );
			else
				proxy:OnObjAnimEnd(70,1023,2,"OnEvent_70_1",once);
				proxy:SetEventFlag( 72 , false );
			end
		proxy:RepeatMessage_end();
	proxy:NotNetMessage_end();
	
	if Luafunc_PlaySynchroAnimation(proxy,param,ANIMEID_TURN_HANDLE) == true then		
		return;
	end	
	
	proxy:WarpDmy(10000,1025,191);		
	
	print("OnEvent_131 end");
end


--------------------------------------------------------------------------------------
--■128■床ダメージON■ --EN:-- ■ 128 ■ floor damage ON ■
--------------------------------------------------------------------------------------
function OnEvent_128(proxy,param)	
	print("OnEvent_128 begin");
	if param:IsNetMessage() == true then
		return;
	end
	--proxy:SetEventSpecialEffect(10000,10050);
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 4069 , "OnEvent_FireDamage1",0.0,0,FIREDOM_COUNT,once);
		FIREDOM_COUNT = FIREDOM_COUNT +1;
		if FIREDOM_COUNT > 10000 then
			FIREDOM_COUNT = 0;
		end
	proxy:NotNetMessage_end();
	IS_FIREAREA = true;
	print("OnEvent_128 end");
end

--------------------------------------------------------------------------------------
--■50■敵床ダメージON■ --EN:-- ■ 50 ■ Enemy Floor Damage ON ■
--------------------------------------------------------------------------------------
function OnEvent_50(proxy,param)	
	print("RegionIn Enemy :",param:GetParam2() );
	proxy:SetEventSpecialEffect(param:GetParam2(),10050);	
end

--------------------------------------------------------------------------------------
--■133■床ダメージOFF■ --EN:-- ■ 133 ■ floor damage OFF ■
--------------------------------------------------------------------------------------
function OnEvent_133(proxy,param)
	print("OnEvent_133 begin");
	if param:IsNetMessage() == true then
		return;
	end
	--proxy:EraseEventSpecialEffect(10000,10050);
	IS_FIREAREA = false;
	proxy:DeleteEvent( 4069 );
	print("OnEvent_133 end");
end

function OnEvent_FireDamage1(proxy,param)
	if IS_FIREAREA == true then
		proxy:NotNetMessage_begin();
			proxy:OnKeyTime2( 4069 , "OnEvent_FireDamage2",FIREDOM_TIME,0,FIREDOM_COUNT,once);
		proxy:NotNetMessage_end();
		proxy:CreateDamage_NoCollision(10320,400,10000,0,OFFSET,0);
		FIREDOM_COUNT = FIREDOM_COUNT +1;
		if FIREDOM_COUNT > 10000 then
			FIREDOM_COUNT = 0;
		end
	end
end

function OnEvent_FireDamage2(proxy,param)
	if IS_FIREAREA == true then
		proxy:NotNetMessage_begin();
			proxy:OnKeyTime2( 4069 , "OnEvent_FireDamage1",FIREDOM_TIME,0,FIREDOM_COUNT,once);
		proxy:NotNetMessage_end();
		proxy:CreateDamage_NoCollision(10320,400,10000,0,OFFSET,0);
		FIREDOM_COUNT = FIREDOM_COUNT +1;
		if FIREDOM_COUNT > 10000 then
			FIREDOM_COUNT = 0;
		end
	end
end

--------------------------------------------------------------------------------------
--■51■敵床ダメージOFF■ --EN:-- ■ 51 ■ Enemy Floor Damage OFF ■
--------------------------------------------------------------------------------------
function OnEvent_51(proxy,param)	
	print("RegionOut Enemy :",param:GetParam2() );
	proxy:EraseEventSpecialEffect(param:GetParam2(),10050);	
end

--------------------------------------------------------------------------------------
--■142■鍛冶屋敵対■ --EN:-- ■ 142 ■ blacksmith hostility ■
--------------------------------------------------------------------------------------
function OnEvent_142(proxy,param)
	print("OnEvent_142 begin");
	proxy:SetEventFlag(142,true);
	--敵対処理 --EN:--Adversarial handling
	proxy:EnableLogic(660, true);
	SetNpcStateFlag(proxy,param,SMITH_Flag_list,SMITH_ANGRY);
	proxy:SetTeamType( 660, TEAM_TYPE_AngryFriend );
	print("OnEvent_142 end");
end


--------------------------------------------------------------------------------------
--■143■鍛冶屋死亡■ --EN:-- ■ 143 ■ blacksmith death ■
--------------------------------------------------------------------------------------
function OnEvent_143(proxy,param)
	print("OnEvent_143 begin");
	proxy:SetEventFlag(143,true);
	SetNpcStateFlag(proxy,param,SMITH_Flag_list,SMITH_DEAD);
	print("OnEvent_143 end");
end

--------------------------------------------------------------------------------------
--■114■ボスカメラ切り替えイベント■ --EN:-- ■ 114 ■ Boss camera switching event ■
--------------------------------------------------------------------------------------
function OnEvent_114(proxy,param)
	--print("OnEvent_114 begin");
	--ボスが死んでいない　かつ　ボスとの戦闘を開始している --EN:-- Boss is not dead and has started a battle with the boss
	if proxy:IsCompleteEvent( 6174 ) == false and proxy:IsCompleteEvent( 113 ) == true then
		--ボス戦　非ロックカメラ --EN:-- Boss battle unlocked camera
		proxy:SetCamModeParamTargetId(6011);
		--ボス戦　ロックカメラ --EN:--Boss battle rock camera
		proxy:SetCamModeParamTargetIdForBossLock(6010);
	end
	--print("OnEvent_114 end");
end

------------------------------
--鉱石の精霊死亡監視-- --EN:--Ore Spirit Death Watch--
------------------------------
function OnEvent_171(proxy, param)
	print("OnEvent_171 begin");
	--死亡したフラグを立てる --EN:--Flag dead
	proxy:SetEventFlag( 171, true );
		
	print("OnEvent_171 end");
end

--------------------------------------------------------------------------------------
--乞食状態管理■160 --EN:--Beggar state management ■160
--------------------------------------------------------------------------------------
function OnEvent_160(proxy,param)
	print("OnEvent_160 begin");
		
	SetNpcStateFlag(proxy,param,SHOP_Flag_list,SHOP_NORMAL_1);
	proxy:SetEventFlag(160,true);

	print("OnEvent_160 end");
end

function OnEvent_160_1(proxy, param)
	print("OnEvent_160_1 begin");

	proxy:EnableLogic( 663 , true );
	proxy:EnableLogic( 676 , true );
	
	SetNpcStateFlag(proxy,param,SHOP_Flag_list,SHOP_HOSTILE_1);
	proxy:SetTeamType( 663, TEAM_TYPE_AngryFriend );
	proxy:SetTeamType( 676, TEAM_TYPE_AngryFriend );
	proxy:SetEventFlag(160,true);
	proxy:SetEventFlag(650,true);
	
	print("OnEvent_160_1 end");
end

--------------------------------------------------------------------------------------
--乞食状態管理■161 --EN:--Beggar state management ■161
--------------------------------------------------------------------------------------

--■161■乞食死亡■ --EN:-- ■ 161 ■ beggar death ■
function OnEvent_161(proxy, param)
	print("OnEvent_161 begin");

	--乞食の状態フラグを「死亡」にする --EN:--Set the beggar's status flag to "dead"
	SetNpcStateFlag(proxy, param, SHOP_Flag_list, SHOP_DEAD );
	proxy:SetEventFlag( 161 , 1 );
	proxy:SetEventFlag( 651 , 1 );
	
	print("OnEvent_161 end");
end

--チェックポイントに入ったときに呼ばれるハンドラ --EN:--Handler called when a checkpoint is entered

--■162■スタート地点のチェックポイント■ --EN:-- ■ 162 ■ Checkpoint at the starting point ■
function OnEvent_162(proxy,param)
	proxy:LuaCallStart( 164 , 1 ); 
end
--■163■大蜘蛛の部屋のチェックポイント■ --EN:--■163■Checkpoint in the room of the giant spider■
function OnEvent_163(proxy,param)
	proxy:LuaCallStart( 164 , 1 );
end
--■165■ドラゴンデーモンの部屋のチェックポイント■ --EN:--■165■Dragon Demon Room Checkpoint■
function OnEvent_165(proxy,param)
	proxy:LuaCallStart( 164 , 1 );
end

--配信用 --EN:--For delivery
function OnEvent_164(proxy,param)
print("OnEvent_164 begin");
	print("JustInCheckPoint");
	
	local SHOP_1_ID = 663;--坑道１のNPCのID --EN:-- ID of NPC in Tunnel 1
	local SHOP_2_ID = 676;--坑道２のNPCのID --EN:-- ID of NPC in Tunnel 2
	
	local SHOPBlock1_acid_list = {160,161};--160＞敵対　--161＞死亡 --EN:--160 > Hostile --161 > Death
	local SHOPBlock2_acid_list = {650,651};--650＞敵対　--651＞死亡 --EN:--650 > Hostile --651 > Death
	
	--一旦2体とも消える --EN:--both disappear once
	InvalidCharactor(proxy,SHOP_1_ID);
	InvalidCharactor(proxy,SHOP_2_ID);
	
	--ブロックの監視を削除 --EN:--remove block watcher
	DeleteConditionList(proxy,SHOPBlock1_acid_list);	
	DeleteConditionList(proxy,SHOPBlock2_acid_list);
	
	--取りあえず初期状態を設定 --EN:-- Set the initial state for now
	SetFirstNpcStateFlag( proxy, param, SHOP_Flag_list, SHOP_NORMAL_1 );

	--坑道１で販売中 --EN:--Sold at Tunnel 1
	if proxy:IsCompleteEvent( SHOP_NORMAL_1 ) == true then
		print("SHOP NowState SHOP_NORMAL_1");
		SetSHOPState1(proxy,param);
		RegistConditionBlock1(proxy,param);
		
	--坑道１で敵対 --EN:-- Hostile in Tunnel 1
	elseif proxy:IsCompleteEvent( SHOP_HOSTILE_1 ) == true then
		print("SHOP NowState SHOP_HOSTILE_1");
		SetSHOPState2(proxy,param);
		RegistConditionBlock1(proxy,param);
		
	--坑道(1＆2)で死亡 --EN:--died in mine shaft (1 & 2)
	elseif proxy:IsCompleteEvent( SHOP_DEAD ) == true then
		print("SHOP NowState SHOP_DEAD");
		SetSHOPState3(proxy,param);
		
	--坑道２で販売中	 --EN:--Sold at Tunnel 2
	elseif proxy:IsCompleteEvent( SHOP_NORMAL_2 ) == true then
		print("SHOP NowState SHOP_NORMAL_2");
		SetSHOPState4(proxy,param);
		RegistConditionBlock2(proxy,param);
		
	--坑道２で敵対 --EN:-- Hostile in Tunnel 2
	elseif proxy:IsCompleteEvent( SHOP_HOSTILE_2 ) == true then
		print("SHOP NowState SHOP_HOSTILE_2");
		SetSHOPState5(proxy,param);
		RegistConditionBlock2(proxy,param);
		
	else--上記以外の謎の状態 --EN:-- Mysterious state other than the above
		print("SHOP NowState UnKnown");	
	end
	print("OnEvent_164 end");
end

--------------------------------------------------------------------------------------
--坑道１で販売中■16410 --EN:--Sold at Tunnel 1 ■16410
--------------------------------------------------------------------------------------
function SetSHOPState1(proxy,param)

	--大蜘蛛が死んでいない --EN:--The giant spider isn't dead
	if proxy:IsCompleteEvent( 6174 ) == false then
		ValidCharactor(proxy,663);--坑道１にいる乞食ショップを有効化 --EN:-- Activate the Beggar Shop in Mine 1
		ValidCharactor(proxy,676);--坑道2にいる乞食ショップを有効化		 --EN:--Enable beggar shop in Mine 2
	--大蜘蛛が死んでいる --EN:--The giant spider is dead
	else
		print("SHOP NowState SHOP_NORMAL_1 > Chenge to SHOP_NORMAL_2");
		ValidCharactor(proxy,663);--坑道１にいる乞食ショップを無効化 --EN:--Disable the Beggar Shop in Mine 1
		ValidCharactor(proxy,676);--坑道2にいる乞食ショップを有効化 --EN:--Enable beggar shop in Mine 2
		--状態を古砦２にいるに変更 --EN:--Change status to Old Fort 2
		SetNpcStateFlag( proxy, param, SHOP_Flag_list, SHOP_NORMAL_2 );
		
		--状態を移動させた為、もう一度更新 --EN:--Updated again because the state was moved
		proxy:OnKeyTime2( SYSTEM_CHECK_POINT, "OnEvent_164", 0.0, 0, 2, once );
	end
end

--------------------------------------------------------------------------------------
--坑道１で敵対■16411 --EN:-- Hostile in Tunnel 1 16411
--------------------------------------------------------------------------------------
function SetSHOPState2(proxy,param)
	ValidCharactor(proxy,663);--坑道１にいる乞食ショップを有効化 --EN:-- Activate the Beggar Shop in Mine 1
	ValidCharactor(proxy,676);--坑道2にいる乞食ショップを有効化 --EN:--Enable beggar shop in Mine 2

	proxy:SetTeamType( 663, TEAM_TYPE_AngryFriend );--チームタイプ変更 --EN:--Change team type
	proxy:SetTeamType( 676, TEAM_TYPE_AngryFriend );--チームタイプ変更 --EN:--Change team type
end

--------------------------------------------------------------------------------------
--坑道(1＆2)で死亡■16412 --EN:--Died in tunnels (1 & 2) 16412
--------------------------------------------------------------------------------------
function SetSHOPState3(proxy,param)
	InvalidBackRead(proxy,663);--坑道１にいる乞食ショップを無効化 --EN:--Disable the Beggar Shop in Mine 1
	InvalidBackRead(proxy,676);--坑道2にいる乞食ショップを無効化 --EN:--Disable the Beggar Shop in Mine 2
end

--------------------------------------------------------------------------------------
--坑道２で販売中■16413 --EN:--Sold at Tunnel 2 ■16413
--------------------------------------------------------------------------------------
function SetSHOPState4(proxy,param)	
	ValidCharactor(proxy,663);--坑道１にいる乞食ショップを有効化 --EN:-- Activate the Beggar Shop in Mine 1
	ValidCharactor(proxy,676);--坑道2にいる乞食ショップを有効化 --EN:--Enable beggar shop in Mine 2
end

--------------------------------------------------------------------------------------
--坑道２で敵対■16414 --EN:-- Hostile in Tunnel 2 16414
--------------------------------------------------------------------------------------
function SetSHOPState5(proxy,param)
	ValidCharactor(proxy,663);--坑道１にいる乞食ショップを有効化 --EN:-- Activate the Beggar Shop in Mine 1
	ValidCharactor(proxy,676);--坑道2にいる乞食ショップを有効化 --EN:--Enable beggar shop in Mine 2

	proxy:SetTeamType( 676, TEAM_TYPE_AngryFriend );--チームタイプ変更 --EN:--Change team type
	proxy:SetTeamType( 663, TEAM_TYPE_AngryFriend );--チームタイプ変更 --EN:--Change team type
end


--------------------------------------------------------------------------------------
--囚人古砦1監視■ --EN:--Convict Old Fort 1 Surveillance■
--------------------------------------------------------------------------------------
function RegistConditionBlock1(proxy,param)	
	--囚人が死んでいない --EN:-- Prisoner not dead
	if proxy:IsCompleteEvent( SHOP_DEAD ) == false then
		--古砦１、２で敵対になっていない --EN:--Not hostile in Old Fort 1 and 2
		if proxy:IsCompleteEvent( SHOP_HOSTILE_1 ) == false 
		and proxy:IsCompleteEvent( SHOP_HOSTILE_2 ) == false then			
			--ホストからのダメージ監視 --EN:--Damage monitoring from host
			--■160■乞食NPCが敵になる■ --EN:--■ 160 ■ Beggar NPC becomes an enemy ■
			--proxy:OnCharacterTotalDamage( 160, 663, 10000, SHOP_TOTALDAMAGE, "OnEvent_160_1", once );	
			proxy:OnCharacterTotalRateDamage( 160, 663, LOCAL_PLAYER, NPC_ANGRY_Rate, "OnEvent_160_1", once );
			--■650■乞食NPCが敵になる■ --EN:-- ■ 650 ■ beggar NPC becomes an enemy ■
			--proxy:OnCharacterTotalDamage( 650, 676, 10000, SHOP_TOTALDAMAGE, "OnEvent_650_1", once );
			proxy:OnCharacterTotalRateDamage( 160, 676, LOCAL_PLAYER, NPC_ANGRY_Rate, "OnEvent_650_1", once );			
		end
		--■161■乞食NPC死亡■ --EN:-- ■ 161 ■ beggar NPC death ■
		proxy:OnCharacterDead( 161 , 663 , "OnEvent_161" , once );			
		proxy:OnCharacterDead( 161 , 676 , "OnEvent_651" , once );			
	end
end

--------------------------------------------------------------------------------------
--囚人古砦2監視■ --EN:--Convict Old Fort 2 Surveillance■
--------------------------------------------------------------------------------------
function RegistConditionBlock2(proxy,param)
	--囚人が死んでいない --EN:-- Prisoner not dead
	if proxy:IsCompleteEvent( SHOP_DEAD ) == false then
		--古砦１、２で敵対になっていない --EN:--Not hostile in Old Fort 1 and 2
		if proxy:IsCompleteEvent( SHOP_HOSTILE_1 ) == false
		and proxy:IsCompleteEvent( SHOP_HOSTILE_2 ) == false then
			--ホストからのダメージ監視 --EN:--Damage monitoring from host
			--■160■乞食NPCが敵になる■ --EN:--■ 160 ■ Beggar NPC becomes an enemy ■
			--proxy:OnCharacterTotalDamage( 160, 663, 10000, SHOP_TOTALDAMAGE, "OnEvent_160_1", once );		
			proxy:OnCharacterTotalRateDamage( 650, 663, LOCAL_PLAYER, NPC_ANGRY_Rate, "OnEvent_160_1", once );
			--■650■乞食NPCが敵になる■ --EN:-- ■ 650 ■ beggar NPC becomes an enemy ■
			--proxy:OnCharacterTotalDamage( 650, 676, 10000, SHOP_TOTALDAMAGE, "OnEvent_650_1", once );
			proxy:OnCharacterTotalRateDamage( 650, 676, LOCAL_PLAYER, NPC_ANGRY_Rate, "OnEvent_650_1", once );
		end
			--■651■乞食NPC死亡■ --EN:-- ■ 651 ■ beggar NPC death ■
			proxy:OnCharacterDead( 161 , 663 , "OnEvent_161" , once );			
			proxy:OnCharacterDead( 651 , 676 , "OnEvent_651" , once );		
	end
end


--------------------------------------------------------------------------------------
--坑道鍛冶屋にアイテムを渡す■ --EN:--Give the item to the blacksmith
--------------------------------------------------------------------------------------
function OnEvent_180(proxy,param)
	print("OnEvent_180 begin");
	
	if	proxy:IsCompleteEvent(180) == true then
		print("OnEvent_354 既に会話イベントが終了しています。"); --EN:print("OnEvent_354 The conversation event has already ended.");
	end
	if proxy:RemoveInventoryEquip(TYPE_GOODS, 28) == true then
		print("OnEvent_354 RemoveInventoryEquip Succsess");
	else
		print("OnEvent_354 RemoveInventoryEquip Failed");
	end
	--proxy:GetRateItem( 10700 );
	proxy:SetEventFlag( 180, true );
	
	print("OnEvent_180 end");
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
--■190～■マグマヤモリ落下イベント■ --EN:-- ■ 190 ~ ■ Magma gecko fall event ■
--------------------------------------------------------------------------------------
function YAMORI_FALL_DOWN( proxy, actionId, targetId,aniId)
	if proxy:IsCompleteEvent( actionId ) == false then
		print("OnEvent_",actionId," begin");
		proxy:PlayAnimation( targetId , aniId );
		proxy:SetSpStayAndDamageAnimId( targetId ,-1,-1);
		proxy:SetEventFlag( actionId,true );	
		print("OnEvent_",actionId," end");
	end
end

function YAMORI_WAIT(proxy , acrionId ,wait)
	if proxy:IsCompleteEvent( actionId ) == false then
		proxy:NotNetMessage_begin();
			proxy:OnKeyTime2(acrionId,"OnEvent_"..acrionId.."_1",wait,0,0,once);
		proxy:NotNetMessage_end();
	end
end

function OnEvent_190(proxy,param) YAMORI_FALL_DOWN( proxy, 190, 370, 7010) end
function OnEvent_190_Dam(proxy,param) proxy:SetEventFlag( 190 , true ); end

--function OnEvent_191(proxy,param) YAMORI_WAIT(proxy,191,0.6) end
function OnEvent_191(proxy,param) YAMORI_FALL_DOWN( proxy, 191, 371, 7010) end
function OnEvent_191_Dam(proxy,param) proxy:SetEventFlag( 191 , true ); end

--function OnEvent_192(proxy,param) YAMORI_WAIT(proxy,192,0.4) end
function OnEvent_192(proxy,param) YAMORI_FALL_DOWN( proxy, 192, 372, 7010) end
function OnEvent_192_Dam(proxy,param) proxy:SetEventFlag( 192 , true ); end

--function OnEvent_193(proxy,param) YAMORI_WAIT(proxy,193,0.5) end
function OnEvent_193(proxy,param) YAMORI_FALL_DOWN( proxy, 193, 373, 2013) end
function OnEvent_193_Dam(proxy,param) proxy:SetEventFlag( 193 , true ); end

function OnEvent_194(proxy,param) YAMORI_FALL_DOWN( proxy, 194, 374, 2013) end
function OnEvent_194_Dam(proxy,param) proxy:SetEventFlag( 194 , true ); end

--function OnEvent_195(proxy,param) YAMORI_WAIT(proxy,195,0.5) end
function OnEvent_195(proxy,param) YAMORI_FALL_DOWN( proxy, 195, 375, 2013) end
function OnEvent_195_Dam(proxy,param) proxy:SetEventFlag( 195 , true ); end

--function OnEvent_196(proxy,param) YAMORI_WAIT(proxy,196,0.4) end
function OnEvent_196(proxy,param) YAMORI_FALL_DOWN( proxy, 196, 376, 2013) end
function OnEvent_196_Dam(proxy,param) proxy:SetEventFlag( 196 , true ); end

function OnEvent_200(proxy,param) YAMORI_FALL_DOWN( proxy, 200, 380, 2013) end
function OnEvent_200_Dam(proxy,param) proxy:SetEventFlag( 200 , true ); end

--function OnEvent_201(proxy,param) YAMORI_WAIT(proxy,201,0.5) end
function OnEvent_201(proxy,param) YAMORI_FALL_DOWN( proxy, 201, 381, 2013) end
function OnEvent_201_Dam(proxy,param) proxy:SetEventFlag( 201 , true ); end

--function OnEvent_202(proxy,param) YAMORI_WAIT(proxy,202,0.7) end
function OnEvent_202(proxy,param) YAMORI_FALL_DOWN( proxy, 202, 382, 2013) end
function OnEvent_202_Dam(proxy,param) proxy:SetEventFlag( 202 , true ); end

--function OnEvent_203(proxy,param) YAMORI_WAIT(proxy,203,0.4) end
function OnEvent_203(proxy,param) YAMORI_FALL_DOWN( proxy, 203, 383, 2013) end
function OnEvent_203_Dam(proxy,param) proxy:SetEventFlag( 203 , true ); end

function OnEvent_204(proxy,param) YAMORI_FALL_DOWN( proxy, 204, 384, 2013) end
function OnEvent_204_Dam(proxy,param) proxy:SetEventFlag( 204 , true ); end

--function OnEvent_205(proxy,param) YAMORI_WAIT(proxy,205,0.7) end
function OnEvent_205(proxy,param) YAMORI_FALL_DOWN( proxy, 205, 385, 2013) end
function OnEvent_205_Dam(proxy,param) proxy:SetEventFlag( 205 , true ); end


--------------------------------------------------------------------------------------
--■210■ウロコ鉱夫落石■ --EN:-- ■ 210 ■ scale miner falling rock ■
--------------------------------------------------------------------------------------
function OnEvent_210(proxy,param)
	if proxy:IsAlive( 391 ) == true then
		print("OnEvent_210 begin");
		--ウロコ鉱夫の岩落としアニメ --EN:--scale miner's rock drop animation
		proxy:PlayAnimation( 391 , 7000 );		
		--MoveRegion(proxy, 391, 2171, 2 ,-1,false);
		proxy:Warp( 391 , 2171 );
		
		--岩を破壊モデルに差し替え --EN:--Replace rocks with destruction models
		proxy:ChangeModel( 1125 , 1 );
		--proxy:ChangeModel( 1126 , 1 );
		--proxy:ChangeModel( 1127 , 1 );
		
		proxy:PlayTypeSE( 1125, SOUND_TYPE_O, 513005140 );
		--proxy:PlayTypeSE( 1126, SOUND_TYPE_O, 513005140 );
		--proxy:PlayTypeSE( 1127, SOUND_TYPE_O, 513005140 );
		
		--1秒後でずらして、開始直後に付近のマップパーツに当たるのを防ぐ --EN:--Staggered after 1 second to prevent hitting nearby map parts right after start
		proxy:NotNetMessage_begin();
			proxy:OnKeyTime2( 210, "OnEvent_210_1", 3.0, 0, 1, once );	
		proxy:NotNetMessage_end();
		
		print("OnEvent_210 end");
	end		
end

function OnEvent_210_1(proxy,param)
	print("OnEvent_210_1 begin");
	--落下岩ダメージ球 --EN:--Falling rock damage sphere
	local paramid = 10120; --落下岩ダメージ --EN:-- Falling rock damage
	local rad    = 1.7;--半径(あとで、正式な値になるはず･･･今は適当) --EN:--radius (should be a formal value later... suitable for now)
	local time   = 2; --ひとまずアニメ再生終了でダメージ球消すので、アニメより長い時間を指定しておく --EN:--For the time being, the damage ball will be erased when the animation ends, so specify a longer time than the animation.
	--▼1125_hit▼石1があたったとき▼	 --EN:--▼1125_hit▼When stone 1 hits▼
	proxy:NotNetMessage_begin();
		proxy:OnObjectDamageHit( 210, 1125, 1, paramid, EV_HIT_ALL, rad, time, "OnEvent_210_1125hit", once );
		--▼1126_hit▼石1があたったとき▼	 --EN:--▼1126_hit▼When stone 1 hits▼
		--proxy:OnObjectDamageHit( 210, 1126, 1, paramid, EV_HIT_ALL, rad, time, "OnEvent_210_1126hit", once );
	
		proxy:OnKeyTime2( 210, "OnEvent_210_bloken", time, 0, 2, once );
		
		proxy:OnKeyTime2( 210, "OnEvent_210_Run", 4.0 ,1,0,once );
	proxy:NotNetMessage_end();	
	print("OnEvent_210_1 end");
end

--岩1125が何かに当たった --EN:--Rock 1125 hit something
function OnEvent_210_1125hit(proxy,param)
	print("OnEvent_210_1125hit begin");	
	--マトリクス移動、モデル差し替え<2>、初速度、物理インスタンス消し --EN:-- Matrix movement, model replacement <2>, initial velocity, physical instance deletion
	SecondStageBreak(proxy, 1125, 2 );	
	proxy:PlayTypeSE( 1125 , SOUND_TYPE_O , 619000000 );
	print("OnEvent_210_1125hit end");
end

function OnEvent_210_Run(proxy,param)
	proxy:PlayAnimation( 391 , 500 );
end
--[[
--岩1126が何かに当たった --EN:--Rock 1126 hit something
function OnEvent_210_1126hit(proxy,param)
	print("OnEvent_210_1126hit begin");	
	--マトリクス移動、モデル差し替え<2>、初速度、物理インスタンス消し --EN:-- Matrix movement, model replacement <2>, initial velocity, physical instance deletion
	SecondStageBreak(proxy, 1126, 2 );	
	print("OnEvent_210_1126hit end");
end
]]

--[[
--岩1127が何かに当たった --EN:--Rock 1127 hit something
function OnEvent_210_1127hit(proxy,param)
	print("OnEvent_210_1127hit begin");	
	--マトリクス移動、モデル差し替え<2>、初速度、物理インスタンス消し --EN:-- Matrix movement, model replacement <2>, initial velocity, physical instance deletion
	SecondStageBreak(proxy, 1127, 2 );	
	print("OnEvent_210_1127hit end");
end
]]

--一定時間が立ったのでリジッドを抜く --EN:--Remove the rigid after a certain amount of time has passed
function OnEvent_210_bloken(proxy,param)
	print("OnEvent_210_bloken begin");	
	proxy:SetBrokenPiece(1125);
	--proxy:SetBrokenPiece(1126);
	--proxy:SetBrokenPiece(1127);		
	--フラグをセット --EN:-- set the flag
	proxy:SetEventFlag( 210 , true );	
	print("OnEvent_210_bloken end");
end


--------------------------------------------------------------------------------------
--■185■犬飛び出しイベント■ --EN:-- ■ 185 ■ dog pop-out event ■
--------------------------------------------------------------------------------------
--イベント領域に入った --EN:-- entered the event area
function OnEvent_185(proxy,param)
	if proxy:IsCompleteEvent( 185 ) == false then
		print("OnEvent_185 begin");
		--OBJをイベント破壊 --EN:--Event destroy OBJ
		proxy:ChangeModel( 1120 ,1 );
		proxy:SetFirstSpeedPlus( 1120 , 2, 3.5  ,6 , 1);
		proxy:SetBrokenPiece( 1120 );
		proxy:PlayTypeSE( 1120 , SOUND_TYPE_O , 624400000 );
		
		--飛び出しアニメ --EN:--Pop-out animation
		proxy:PlayAnimation( 390 , 3302 );
		proxy:EnableLogic( 390 , true );
		proxy:EnableLogic( 392 , true );
		proxy:EnableLogic( 393 , true );
		proxy:SetEventFlag( 185 ,true );
		print("OnEvent_185 end");
	end
end

--イベント発動前にOBJが破壊された --EN:-- OBJ was destroyed before the event triggered
function OnEvent_186(proxy,param)
	if proxy:IsCompleteEvent( 185 ) == false then
		print("OnEvent_186 begin");
		proxy:EnableLogic( 390 , true );
		proxy:EnableLogic( 392 , true );
		proxy:EnableLogic( 393 , true );
		proxy:SetEventFlag( 185 ,true );		
		print("OnEvent_186 end");
	end
end


--------------------------------------------------------------------------------------
--■187■橋が崩れる■ --EN:-- ■ 187 ■ The bridge collapses ■
--------------------------------------------------------------------------------------
function OnEvent_187(proxy,param)
	if proxy:IsDestroyed( 1121 ) == false then
		print("OnEvent_187 begin");		
		proxy:ChangeModel( 1121 , 1 );
		proxy:SetBrokenPiece( 1121 );
		proxy:PlayTypeSE( 1121 , SOUND_TYPE_O , 618000000 );
		print("OnEvent_187 end");		
	end
	proxy:SetEventFlag( 187 , true );
end

--------------------------------------------------------------------------------------
--■189■橋が崩れる2■ --EN:-- ■ 189 ■ The bridge collapses 2 ■
--------------------------------------------------------------------------------------
function OnEvent_189(proxy,param)
	print("OnEvent_189 begin");
	proxy:SetEventFlag( 189 , true );
	proxy:PlayAnimation( 1123, 1);	
	--proxy:PlayTypeSE( 1123 , SOUND_TYPE_O , 618000000 );
	print("OnEvent_189 end");
end

--[[
--------------------------------------------------------------------------------------
--■188■吊るされた宝死体■ --EN:--■ 188 ■ Hanging Treasure Corpse ■
--------------------------------------------------------------------------------------
function OnEvent_188(proxy,param)
	print("OnEvent_188 begin");
	
	if param:IsNetMessage() == true then
		--受信者は釣っているOBJを破壊しておく --EN:--Recipient destroys the OBJ they are fishing for
		proxy:ChangeModel( 1122 , 1);
	end
	
	proxy:PlayAnimation( 10286 , 30 );--死体の落下アニメを終了 --EN:--End the falling corpse animation
	
	proxy:NotNetMessage_begin();
		proxy:OnCharacterAnimEnd( 1122 , 10286 , 30 , "OnEvent_188_1",once);
	proxy:NotNetMessage_end();
	
	proxy:SetEventFlag( 188 , true );
	
	print("OnEvent_188 end");
end

--死体のアニメ終了 --EN:--End of corpse animation
function OnEvent_188_1(proxy,param)
	print("OnEvent_188_1 begin");
	
	proxy:EnableObjTreasure( 10286 , true );
	
	print("OnEvent_188_1 end");
end
]]

--------------------------------------------------------------------------------------
--■220～225■爆発タル■ --EN:-- ■ 220～225 ■ Explosive barrel ■
--------------------------------------------------------------------------------------
function TaruBakuhatu(proxy, actionId, ObjId)
	print("OnEvent_",actionId," begin");
	proxy:CastPointSpell( 400 , ObjId , 10130 , 0,0,0);
	proxy:SetEventFlag( actionId, true );
	print("OnEvent_",actionId," end");
end

function OnEvent_220( proxy,param) TaruBakuhatu(proxy,220,1130) end
function OnEvent_221( proxy,param) TaruBakuhatu(proxy,221,1131) end
function OnEvent_222( proxy,param) TaruBakuhatu(proxy,222,1132) end
function OnEvent_223( proxy,param) TaruBakuhatu(proxy,223,1133) end
function OnEvent_224( proxy,param) TaruBakuhatu(proxy,224,1134) end
function OnEvent_225( proxy,param) TaruBakuhatu(proxy,225,1135) end
function OnEvent_226( proxy,param) TaruBakuhatu(proxy,226,1136) end
function OnEvent_227( proxy,param) TaruBakuhatu(proxy,227,1137) end
function OnEvent_228( proxy,param) TaruBakuhatu(proxy,228,1138) end
function OnEvent_229( proxy,param) TaruBakuhatu(proxy,229,1139) end

function OnEvent_233( proxy,param) TaruBakuhatu(proxy,233,1140) end
function OnEvent_234( proxy,param) TaruBakuhatu(proxy,234,1141) end
function OnEvent_235( proxy,param) TaruBakuhatu(proxy,235,1142) end
function OnEvent_236( proxy,param) TaruBakuhatu(proxy,236,1143) end
function OnEvent_237( proxy,param) TaruBakuhatu(proxy,237,1144) end
function OnEvent_238( proxy,param) TaruBakuhatu(proxy,238,1145) end
function OnEvent_239( proxy,param) TaruBakuhatu(proxy,239,1146) end
function OnEvent_240( proxy,param) TaruBakuhatu(proxy,240,1147) end
function OnEvent_241( proxy,param) TaruBakuhatu(proxy,241,1148) end
function OnEvent_242( proxy,param) TaruBakuhatu(proxy,242,1149) end
function OnEvent_243( proxy,param) TaruBakuhatu(proxy,243,1150) end
function OnEvent_244( proxy,param) TaruBakuhatu(proxy,244,1151) end
function OnEvent_245( proxy,param) TaruBakuhatu(proxy,245,1152) end
function OnEvent_246( proxy,param) TaruBakuhatu(proxy,246,1153) end
function OnEvent_247( proxy,param) TaruBakuhatu(proxy,247,1154) end
function OnEvent_248( proxy,param) TaruBakuhatu(proxy,248,1155) end

function OnEvent_250( proxy,param) TaruBakuhatu(proxy,250,1156) end
function OnEvent_251( proxy,param) TaruBakuhatu(proxy,251,1157) end
function OnEvent_252( proxy,param) TaruBakuhatu(proxy,252,1158) end
function OnEvent_253( proxy,param) TaruBakuhatu(proxy,253,1159) end


--------------------------------------------------------------------------------------
--■230■うろこ鉱夫攻撃1■ --EN:-- ■ 230 ■ scale miner attack 1 ■
--------------------------------------------------------------------------------------
function OnEvent_230(proxy,param)
	print("OnEvent_230 begin");	
	proxy:PlayAnimation( 394 , 3000 );
	proxy:EnableLogic( 394 , true );
	proxy:SetEventFlag( 230 , true );
	print("OnEvent_230 end");
end

--------------------------------------------------------------------------------------
--■231■うろこ鉱夫攻撃2■ --EN:-- ■ 231 ■ scale miner attack 2 ■
--------------------------------------------------------------------------------------
function OnEvent_231(proxy,param)
	print("OnEvent_231 begin");
	proxy:PlayAnimation( 395 , 3000 );
	proxy:EnableLogic( 395 , true );
	proxy:SetEventFlag( 231 , true );
	print("OnEvent_231 end");
end

--------------------------------------------------------------------------------------
--■232■うろこ鉱夫攻撃3■ --EN:-- ■ 232 ■ scale miner attack 3 ■
--------------------------------------------------------------------------------------
function OnEvent_232(proxy,param)
	print("OnEvent_232 begin");
	proxy:PlayAnimation( 396 , 3000 );
	proxy:EnableLogic( 396 , true );
	proxy:SetEventFlag( 232 , true );
	print("OnEvent_232 end");
end


--------------------------------------------------------------------------------------
--■249■獄吏が魔法撃つぜ■ --EN:-- ■ 249 ■ Prisoners shoot magic ■
--------------------------------------------------------------------------------------
function OnEvent_249(proxy,param)
	print("OnEvent_249 begin");
	proxy:PlayAnimation(397,3304);
	proxy:SetEventFlag(249,true);
	print("OnEvent_249 end");
end



-----------------------------------------------------------------------------
--■■結晶トカゲイベント --EN:-- ■ ■ Crystal lizard event
-----------------------------------------------------------------------------
--ボス撃破時のトカゲリセット用 --EN:--For lizard reset when defeating boss
function ResetTokage(proxy)
	print("ResetTokage");
--~ 	proxy:SetEventFlag(260,false);	
--~ 	proxy:SetEventFlag(262,false);
--~ 	proxy:SetEventFlag(750,false);
--~ 	proxy:SetEventFlag(752,false);
--~ 	proxy:SetEventFlag(754,false);
--~ 	proxy:SetEventFlag(756,false);
--~ 	proxy:SetEventFlag(758,false);
--~ 	proxy:SetEventFlag(760,false);
--~ 	proxy:SetEventFlag(762,false);
--~ 	proxy:SetEventFlag(764,false);
--~ 	proxy:SetEventFlag(766,false);	
--~ 	proxy:SetEventFlag(768,false);
--~ 	proxy:SetEventFlag(770,false);
--~ 	proxy:SetEventFlag(772,false);	
--~ 	proxy:SetEventFlag(774,false);
--~ 	proxy:SetEventFlag(776,false);
--~ 	proxy:SetEventFlag(778,false);
--~ 	proxy:SetEventFlag(780,false);
--~ 	proxy:SetEventFlag(782,false);
--~ 	proxy:SetEventFlag(784,false);
--~ 	proxy:SetEventFlag(786,false);
--~ 	proxy:SetEventFlag(788,false);
--~ 	proxy:SetEventFlag(1200,false);
--~ 	proxy:SetEventFlag(1202,false);	
	AddEventCounter(proxy,18);
	AddEventCounter(proxy,19);
	AddEventCounter(proxy,20);
	AddEventCounter(proxy,21);
	AddEventCounter(proxy,22);
	AddEventCounter(proxy,23);
	AddEventCounter(proxy,24);
	AddEventCounter(proxy,25);
	AddEventCounter(proxy,26);
	AddEventCounter(proxy,27);
	AddEventCounter(proxy,28);
	AddEventCounter(proxy,29);
	AddEventCounter(proxy,30);
	AddEventCounter(proxy,31);
	AddEventCounter(proxy,32);
	AddEventCounter(proxy,33);
	AddEventCounter(proxy,34);
	AddEventCounter(proxy,35);
	AddEventCounter(proxy,36);
	AddEventCounter(proxy,37);
	AddEventCounter(proxy,38);
	AddEventCounter(proxy,39);
	AddEventCounter(proxy,40);
	AddEventCounter(proxy,41);
end

function TokageEvent(proxy,eventId)
	print("OnEvent_",eventId," begin");
	proxy:SetEventFlag( eventId, true);
	proxy:DeleteEvent( eventId );
	print("OnEvent_",eventId," end");
end

-----------------------------------------------------------------------------
--■260■結晶トカゲイベント1 --EN:-- ■ 260 ■ Crystal Lizard Event 1
-----------------------------------------------------------------------------
function OnEvent_260(proxy,param) TokageEvent(proxy,260); end
function OnEvent_262(proxy,param) TokageEvent(proxy,262); end
function OnEvent_750(proxy,param) TokageEvent(proxy,750); end
function OnEvent_752(proxy,param) TokageEvent(proxy,752); end
function OnEvent_754(proxy,param) TokageEvent(proxy,754); end
function OnEvent_756(proxy,param) TokageEvent(proxy,756); end
function OnEvent_758(proxy,param) TokageEvent(proxy,758); end
function OnEvent_760(proxy,param) TokageEvent(proxy,760); end
function OnEvent_762(proxy,param) TokageEvent(proxy,762); end
function OnEvent_764(proxy,param) TokageEvent(proxy,764); end
function OnEvent_766(proxy,param) TokageEvent(proxy,766); end
function OnEvent_768(proxy,param) TokageEvent(proxy,768); end
function OnEvent_770(proxy,param) TokageEvent(proxy,770); end
function OnEvent_772(proxy,param) TokageEvent(proxy,772); end
function OnEvent_774(proxy,param) TokageEvent(proxy,774); end
function OnEvent_776(proxy,param) TokageEvent(proxy,776); end
function OnEvent_778(proxy,param) TokageEvent(proxy,778); end
function OnEvent_780(proxy,param) TokageEvent(proxy,780); end
function OnEvent_782(proxy,param) TokageEvent(proxy,782); end
function OnEvent_784(proxy,param) TokageEvent(proxy,784); end
function OnEvent_786(proxy,param)
	--このトカゲだけ落下距離が長すぎて死ねない時があるので --EN:--Only this lizard sometimes falls too long to die
	proxy:SetAlwayEnableBackread_forEvent( 416 , false );	
	LuaFunc_NormalOmission(proxy,416);
	TokageEvent(proxy,786); 
end
function OnEvent_788(proxy,param) TokageEvent(proxy,788); end
function OnEvent_1200(proxy,param) TokageEvent(proxy,1200); end
function OnEvent_1202(proxy,param) TokageEvent(proxy,1202); end



-----------------------------------------------------------------------------
--■270■もやSFX領域に入った --EN:--■270■has entered the SFX area
-----------------------------------------------------------------------------
function OnEvent_270(proxy,param)
	if proxy:IsCompleteEvent( 270 ) == false then	
		print("OnEvent_270 begin");
		proxy:CreateCamSfx( 96000 , 0 );
		proxy:SetEventFlag( 270 , true );
		print("OnEvent_270 end");
	end
end


-----------------------------------------------------------------------------
--■271■もやSFX領域から出た --EN:-- ■ 271 ■ Moya came out of the SFX area
-----------------------------------------------------------------------------
function OnEvent_271(proxy,param)
	--2300,2301,2302どこにも入っていない --EN:--2300,2301,2302 not in anywhere
	if 	proxy:IsRegionIn( 10000, 2300 ) == false and
		proxy:IsRegionIn( 10000, 2301 ) == false and
		proxy:IsRegionIn( 10000, 2302 ) == false then	
		print("OnEvent_271 begin");
		proxy:SetEventFlag( 270, false );
		proxy:DeleteCamSfx( 0 );
		print("OnEvent_271 end");
	end
end


--袋ウロコ鉱夫関連の監視登録と再現 --EN:--Surveillance registration and reproduction related to bag scale miners
function Regist_FukuroKoufu(proxy,eneId,deadId,corpseId,initId)
--■corpseId■死体を調べてない■ --EN:-- ■ corpseId ■ corpse not examined ■
	if proxy:IsCompleteEvent( corpseId ) == false then
		proxy:AddCorpseEvent( corpseId , eneId );
		proxy:NotNetMessage_begin();
			proxy:LuaCall( corpseId , 0 , "OnEvent_Corpse",once);
		proxy:NotNetMessage_end();
	end
	
--■deadId■死亡監視■ --EN:--■deadId■death watch■
	if proxy:IsCompleteEvent(deadId) == false then	--死亡してないなら --EN:--if not dead
	   --死亡監視追加 --EN:--Add death watch
		proxy:OnCharacterDead( deadId, eneId, "OnEvent_KoufuDead", once );
	end
--■再現■ --EN:-- ■ Reproduction ■
	if proxy:IsCompleteEvent(deadId) == true then	--死んでいる				 --EN:--dead
		if	proxy:IsCompleteEvent( corpseId ) == false then--アイテム拾ってない --EN:--I didn't pick up the item
			--宝死体を再現 --EN:--Reproduce treasure corpse
			proxy:OpeningDeadPlus( eneId , true ,false ,false );			
		else
			--無効化 --EN:--Invalidation
			InvalidBackRead(proxy, eneId);
		end
		proxy:SetEventFlag( initId , true );
	end
end

--袋ウロコ鉱夫を調べた時のイベント --EN:--Event when examining bag scale miner
function OnEvent_Corpse(proxy,param)
	local eventId = param:GetParam1();
	print("OnEvent_Corpse ",eventId," begin");
	proxy:SetEventFlag( eventId , true );
	print("OnEvent_Corpse ",eventId," end");
end

--袋ウロコ鉱夫が死んだ時のイベント --EN:--Event when Bag Scale Miner dies
function OnEvent_KoufuDead(proxy,param)
	local eventId = param:GetParam1();
	print("OnEvent_KoufuDead ",eventId," begin");
	proxy:SetEventFlag( eventId , true );
	print("OnEvent_KoufuDead ",eventId," end");
end


--敵Aに対してenelistのキャラが距離内に入っているかのチェック --EN:--Check if the enelist character is within distance from enemy A
function LuaFuncDistCheck(proxy,eneId)
	local ret = false;
	local num = table.getn( DISTENELIST );
	if proxy:IsAlive( eneId ) == true then
		for index = 1, num , 1 do				
			if proxy:IsAlive( DISTENELIST[index] ) == true  and proxy:IsDistance( eneId , DISTENELIST[index] , IWAKOUFU_DIST ) == true then
				ret = true;
				break;
			end
		end
	end
	
	--誰か生きている奴が入っていれば命令ID10を送る --EN:--Send command ID 10 if there is someone alive
	if ret == true then
		proxy:SendEventRequest( eneId , 0 , 10 );
	else
		proxy:SendEventRequest( eneId , 0 , -1 );
	end
end

--local actlist = {300,301,302,303,304,305,306,307};
--local actlist = {308,309,310,311,312,313,314,315};
--DISTENELIST--グローバル定義 --EN:--global definition

function OnEvent_300_In(proxy,param) LuaFuncDistCheck(proxy,216); end
function OnEvent_300_Out(proxy,param) LuaFuncDistCheck(proxy,216); end
function OnEvent_300_Dead(proxy,param) LuaFuncDistCheck(proxy,216); proxy:DeleteEvent( param:GetParam1() ); end

function OnEvent_301_In(proxy,param) LuaFuncDistCheck(proxy,216); end
function OnEvent_301_Out(proxy,param) LuaFuncDistCheck(proxy,216); end
function OnEvent_301_Dead(proxy,param) LuaFuncDistCheck(proxy,216); proxy:DeleteEvent( param:GetParam1() ); end

function OnEvent_302_In(proxy,param) LuaFuncDistCheck(proxy,216); end
function OnEvent_302_Out(proxy,param) LuaFuncDistCheck(proxy,216); end
function OnEvent_302_Dead(proxy,param) LuaFuncDistCheck(proxy,216); proxy:DeleteEvent( param:GetParam1() ); end

function OnEvent_303_In(proxy,param) LuaFuncDistCheck(proxy,216); end
function OnEvent_303_Out(proxy,param) LuaFuncDistCheck(proxy,216); end
function OnEvent_303_Dead(proxy,param) LuaFuncDistCheck(proxy,216); proxy:DeleteEvent( param:GetParam1() ); end

function OnEvent_304_In(proxy,param) LuaFuncDistCheck(proxy,216); end
function OnEvent_304_Out(proxy,param) LuaFuncDistCheck(proxy,216); end
function OnEvent_304_Dead(proxy,param) LuaFuncDistCheck(proxy,216); proxy:DeleteEvent( param:GetParam1() ); end

function OnEvent_305_In(proxy,param) LuaFuncDistCheck(proxy,216); end
function OnEvent_305_Out(proxy,param) LuaFuncDistCheck(proxy,216); end
function OnEvent_305_Dead(proxy,param) LuaFuncDistCheck(proxy,216); proxy:DeleteEvent( param:GetParam1() ); end

function OnEvent_306_In(proxy,param) LuaFuncDistCheck(proxy,216); end
function OnEvent_306_Out(proxy,param) LuaFuncDistCheck(proxy,216); end
function OnEvent_306_Dead(proxy,param) LuaFuncDistCheck(proxy,216); proxy:DeleteEvent( param:GetParam1() ); end

function OnEvent_307_In(proxy,param) LuaFuncDistCheck(proxy,216); end
function OnEvent_307_Out(proxy,param) LuaFuncDistCheck(proxy,216); end
function OnEvent_307_Dead(proxy,param) LuaFuncDistCheck(proxy,216); proxy:DeleteEvent( param:GetParam1() ); end



function OnEvent_308_In(proxy,param) LuaFuncDistCheck(proxy,218); end
function OnEvent_308_Out(proxy,param) LuaFuncDistCheck(proxy,218); end
function OnEvent_308_Dead(proxy,param) LuaFuncDistCheck(proxy,218); proxy:DeleteEvent( param:GetParam1() ); end

function OnEvent_309_In(proxy,param) LuaFuncDistCheck(proxy,218); end
function OnEvent_309_Out(proxy,param) LuaFuncDistCheck(proxy,218); end
function OnEvent_309_Dead(proxy,param) LuaFuncDistCheck(proxy,218); proxy:DeleteEvent( param:GetParam1() ); end

function OnEvent_310_In(proxy,param) LuaFuncDistCheck(proxy,218); end
function OnEvent_310_Out(proxy,param) LuaFuncDistCheck(proxy,218); end
function OnEvent_310_Dead(proxy,param) LuaFuncDistCheck(proxy,218); proxy:DeleteEvent( param:GetParam1() ); end

function OnEvent_311_In(proxy,param) LuaFuncDistCheck(proxy,218); end
function OnEvent_311_Out(proxy,param) LuaFuncDistCheck(proxy,218); end
function OnEvent_311_Dead(proxy,param) LuaFuncDistCheck(proxy,218); proxy:DeleteEvent( param:GetParam1() ); end

function OnEvent_312_In(proxy,param) LuaFuncDistCheck(proxy,218); end
function OnEvent_312_Out(proxy,param) LuaFuncDistCheck(proxy,218); end
function OnEvent_312_Dead(proxy,param) LuaFuncDistCheck(proxy,218); proxy:DeleteEvent( param:GetParam1() ); end

function OnEvent_313_In(proxy,param) LuaFuncDistCheck(proxy,218); end
function OnEvent_313_Out(proxy,param) LuaFuncDistCheck(proxy,218); end
function OnEvent_313_Dead(proxy,param) LuaFuncDistCheck(proxy,218); proxy:DeleteEvent( param:GetParam1() ); end

function OnEvent_314_In(proxy,param) LuaFuncDistCheck(proxy,218); end
function OnEvent_314_Out(proxy,param) LuaFuncDistCheck(proxy,218); end
function OnEvent_314_Dead(proxy,param) LuaFuncDistCheck(proxy,218); proxy:DeleteEvent( param:GetParam1() ); end

function OnEvent_315_In(proxy,param) LuaFuncDistCheck(proxy,218); end
function OnEvent_315_Out(proxy,param) LuaFuncDistCheck(proxy,218); end
function OnEvent_315_Dead(proxy,param) LuaFuncDistCheck(proxy,218); proxy:DeleteEvent( param:GetParam1() ); end


--~ function test(proxy,param)
--~ 	proxy:OnKeyTime2( 8000 , "test2",0.5,0,COUNT,once);
--~ 	COUNT = COUNT +1;
--~ 	proxy:CreateDamage_NoCollision(10320,400,10000,0,-0.5,0);
--~ end

--~ function test2(proxy,param)
--~ 	proxy:OnKeyTime2( 8000 , "test",0.5,0,COUNT,once);
--~ 	COUNT = COUNT +1;
--~ 	proxy:CreateDamage_NoCollision(10320,400,10000,0,-0.5,0);
--~ end
