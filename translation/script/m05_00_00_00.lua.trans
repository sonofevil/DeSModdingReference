
--乞食(女)の状態変化フラグ --EN:--Beggar (female) state change flag
KOJIKI_FEMALE_SHOP_SELL01  	 = 16230;--販売中(不浄1) --EN:--Available (Unclean 1)
KOJIKI_FEMALE_SHOP_HOSTILE01 = 16231;--敵対(不浄1) --EN:--Hostility (Unclean 1)
KOJIKI_FEMALE_SHOP_DEAD	   	 = 16232;--死亡 --EN:--death
KOJIKI_FEMALE_SHOP_SELL02  	 = 16233;--販売中(不浄2) --EN:--Available (Unclean 2)
KOJIKI_FEMALE_SHOP_HOSTILE02 = 16234;--敵対(不浄2) --EN:-- Hostility (Unclean 2)

--乞食(女)の状態変化フラグリスト --EN:--Beggar (female) state change flag list
Kojiki_Shop_Flag_list = {
	KOJIKI_FEMALE_SHOP_SELL01,
	KOJIKI_FEMALE_SHOP_HOSTILE01,
	KOJIKI_FEMALE_SHOP_DEAD,
	KOJIKI_FEMALE_SHOP_SELL02,
	KOJIKI_FEMALE_SHOP_HOSTILE02,
}

--敵対するためのダメージ量 --EN:--Damage amount to hostile
KojikiShop_TotalDamage = 50;

--------------------------------------------------------------------------------------
--マップ読み込み時に読まれる初期化処理■ --EN:--Initialization process read when reading the map ■
--------------------------------------------------------------------------------------
function Initialize_m05_00_00_00(proxy)
	print("Initialize_m05_00_00_00 begin");
	
	proxy:LuaCall( 99999 , 0 , "OnEvent_4000_Hp_1",everytime);
-----------------------------------------------------------------------------------------
--ボス関連 --EN:--Boss related
-----------------------------------------------------------------------------------------
--■160■ボス部屋に入る■ --EN:-- ■ 160 ■ Enter the boss room ■
	
	--中ボスが生きているときだけイベント登録 --EN:-- Event registration only when the mid-boss is alive
	if proxy:IsCompleteEvent( 5650 ) == false then
	
		--ソロのときは一度目にボス部屋に入る用のイベントを毎回登録させたいので、対応するフラグをOFFにする。 --EN:-- When soloing, we want to register the event for entering the boss room for the first time every time, so turn off the corresponding flag.
		SingleReset(proxy, 160);
	
		--▽同期アニメ再生用の開始ハンドラ(旋回→歩き) --EN:--▽ Start handler for synchronous animation playback (turning → walking)
		proxy:LuaCall( 161, 1, "OnEvent_161_1", everytime );
		--▽2回目以降にボス部屋に入るためのイベント配信用 --EN:--▽For event delivery to enter the boss room after the second time
		proxy:LuaCall( 161 , 5 , "OnEvent_160_GO_TO_IN" , everytime );
		--▽フラグセット(同期用) --EN:--▽flag set (for synchronization)
		proxy:LuaCall( 161 , 6 , "OnEvent_160_flag_set" , everytime );
		
		--誰かがボス前扉をまだ通過していない --EN:--Someone hasn't passed through the boss front door yet
		if proxy:IsCompleteEvent( 160 ) == false then
		
			--(セッション中に)ボス前の魔法壁を最初に通れるのは生存の人だけ --EN:--(During the session) Only survivors can pass through the magic wall in front of the boss first
			local possible_chr_type = ATTR_HOST + ATTR_LIVE + ATTR_GREY;
			
			proxy:NotNetMessage_begin();
				--▼160▼中に入るためのイベントを追加▼ --EN:--▼160▼ Added an event to enter ▼
				proxy:OnPlayerActionInRegionAttribute( 160, 2895, "OnEvent_160", HELPID_GO_TO_IN, possible_chr_type, everytime );
			proxy:NotNetMessage_end();
			
		else --グレイゴーストできたときようにいると思われる。 --EN:--Gray ghost seems to be like that when it's done.
			proxy:NotNetMessage_begin();
				--▼161▼中に入るためのイベントを追加▼--ハンドラは上と同じ --EN:--▼161▼Add an event to enter inside▼--The handler is the same as above
				proxy:OnPlayerActionInRegion( 161, 2895, "OnEvent_160", HELPID_GO_TO_IN, everytime );
			proxy:NotNetMessage_end();
		end
	end


--■162■中ボスポリ劇演出■	 --EN:-- ■ 162 ■ Middle Bospoli drama production ■
	--ボス生きている --EN:--boss alive
	if proxy:IsCompleteEvent( 5650 ) == false then
		if proxy:IsCompleteEvent( 162 ) ==false then
			proxy:OnRegionJustIn( 162, LOCAL_PLAYER, 2899, "OnEvent_162", once );
			proxy:NotNetMessage_begin();
				--ポリ劇開始に呼ばれるハンドラ --EN:--handler called at polyplay start
				proxy:LuaCall(162, REMO_START, "OnEvent_162_RemoStart", once);
				--ポリ劇終了後に呼ばれるハンドラ(トリガー起こした人用) --EN:--Handler called after the end of the polyplay (for the person who caused the trigger)
				proxy:LuaCall(162, REMO_FINISH, "OnEvent_162_RemoFinish", once);
			proxy:NotNetMessage_end();
		end
	end


--■163■ボス戦闘開始■ --EN:--■ 163 ■ Boss battle begins ■
	if proxy:IsCompleteEvent( 5650 ) == false then
		--ローカルプレイ時はボスが死んでいない限り毎回登録 --EN:--When playing locally, register every time unless the boss is dead
		if	proxy:IsClient() == false then
			proxy:SetEventFlag( 163, false );
		end
		if proxy:IsCompleteEvent( 163 ) == false then
			proxy:OnRegionJustIn( 163 , LOCAL_PLAYER , 2887 , "OnEvent_163" , once );
		else
			proxy:PlayPointSE( 2120, SOUND_TYPE_M, 50000000, 0 );--領域のIDのみ未定 --EN:-- Only the area ID is undecided
		end	
	end

--■5650■ボスが死んだら■ --EN:--■5650■When the boss dies■
	proxy:AddFieldInsFilter( 808 );
	if proxy:IsCompleteEvent( 5650 ) ==false then
		proxy:OnCharacterDead(5650,808,"OnEvent_5650",once);
	else
		proxy:InvalidSfx( 1987, false );
		proxy:InvalidSfx( 1991, false );
	end

	--■ボス関連の初期化処理 --EN:--■ Boss-related initialization processing
	if proxy:IsCompleteEvent( 5650 ) ==true then
		
		--▽ボス死んでいるとき --EN:--▽When the boss is dead
		--ボスいなくなる --EN:--boss disappears
		InvalidBackRead( proxy , 808 );
		
		--魔法壁消える --EN:--Magic wall disappears
		proxy:SetColiEnable( 1999 , false );
		proxy:SetColiEnable( 1995 , false );
	
		proxy:SetDrawEnable( 1999 , false );
		proxy:SetDrawEnable( 1995 , false );	

		--ボス壁Sfx --EN:--Boss Wall Sfx
		proxy:InvalidSfx( 1987, false );
		proxy:InvalidSfx( 1991, false );
		
		--崩れる壁の破壊再現(次のブロックへの道がひらく) --EN:--Destruction reproduction of the collapsing wall (opens the way to the next block)
		proxy:ReconstructBreak( 2060 , 1 );
		
		--ホストプレイヤーのみアイテム入手イベントに使用 --EN:--Used for item acquisition event only for host players
		local possible_chr_type = ATTR_HOST + ATTR_LIVE + ATTR_GREY;

		--宝死体(ソウル?)有効化 --EN:--Treasure corpse (soul?) activation
		proxy:SetDrawEnable( 1982, true );
		proxy:SetColiEnable( 1982, true );
		proxy:TreasureDispModeChange2( 1982, true ,KANAME_SFX);--光らせる --EN:-- let it shine
		--ソウルにささった剣 --EN:--Sword in Soul
		proxy:SetDrawEnable( 1975, true );
		proxy:SetColiEnable( 1975, true );
		--proxy:TreasureDispModeChange2( 1975, true ,KANAME_SFX);--光らせる --EN:-- let it shine
		
		--▼(ソウル)アイテム取得用イベント監視追加▼ --EN:--▼ (Soul) Added event monitoring for item acquisition▼
		if proxy:IsCompleteEvent( 5653 ) == false then
			--SFX有効化 --EN:--SFX enable
			proxy:ValidSfx( 2150 );--要石のオーラ --EN:--Keystone Aura
			proxy:ValidSfx( 2151 );--光の粒子 --EN:--Particles of light
			
			proxy:TreasureDispModeChange2( 1982 , true ,KANAME_SFX);--光らせる --EN:-- let it shine
			proxy:OnDistanceActionAttribute( 5653 , LOCAL_PLAYER , 1982 , "OnEvent_5653" , WarpGimmickDist_A , 10010180 , 0 , 180 , possible_chr_type, once );
		else
			--SFX無効化 --EN:--Disable SFX
			proxy:InvalidSfx( 2150, false );--要石のオーラ --EN:--Keystone Aura
			--proxy:InvalidSfx( 2151, false );--光の粒子 --EN:--Particles of light
			
			--▼要石でワープ用の監視を追加▼ --EN:--▼ Added surveillance for warp with keystone ▼
			SingleReset(proxy,5654);
			proxy:OnDistanceActionAttribute( 5654 , LOCAL_PLAYER , 1982 , "OnEvent_5654" , WarpGimmickDist_A , HELPID_GO_TO_SEKITYUU , 0 , 180 , ATTR_NOSESSION , everytime );
		end
		
	else
		--▽ボス生きているとき --EN:--▽ When the boss is alive
		
		--ボスポリ劇未発動時 --EN:--When the Bospoli play is not activated
		if proxy:IsCompleteEvent(162) == false then
			--InvalidCharactor( proxy , 808 );
			--ValidCharactor( proxy , 808 );
			proxy:SetDrawEnable( 808, false );
			proxy:EnableLogic( 808, false );
		end
		
		--PT組んでない時は初期化します --EN:--Initialize when PT is not assembled
		if proxy:IsClient() == false  then
			
			SingleReset(proxy,6274);
			SingleReset(proxy,6275);
		end
		
		proxy:EnableLogic( 808 , false );--ロジックOFFで待機 --EN:--Wait with logic OFF
		
		--初期効果は必ず付与 --EN:--Initial effect is always given
		proxy:SetEventSpecialEffect( 811,5000);	
		--2段階目付与 --EN:-- 2nd stage granted
		if proxy:IsCompleteEvent(6274) == true then
			proxy:SetEventSpecialEffect( 811, 5001);
		end
		--3段階目付与 --EN:--Give the 3rd stage
		if proxy:IsCompleteEvent(6274) == true then
			proxy:SetEventSpecialEffect( 811, 5002);
		end
		
		--宝(ソウル)初期化 --EN:-- Treasure (soul) initialization
		proxy:SetDrawEnable( 1982 , false );
		proxy:SetColiEnable( 1982 , false );
		--ソウルに刺さった剣初期化 --EN:--Initialization of the sword stuck in the soul
		proxy:SetDrawEnable( 1975 , false );
		proxy:SetColiEnable( 1975 , false );
		
		--SFX初期化 --EN:--SFX initialization
		proxy:InvalidSfx( 2150 , false );--要石のオーラ --EN:--Keystone Aura
		proxy:InvalidSfx( 2151 , false );--光の粒子 --EN:--Particles of light
		
		--魔法壁ON --EN:--Magic Wall ON
		proxy:SetColiEnable( 1999 , true );
		proxy:SetColiEnable( 1995 , true );
		
		proxy:SetDrawEnable( 1999 , true );
		proxy:SetDrawEnable( 1995 , true );
		
		--光の壁Sfxを有効化 --EN:--Enable Light Wall Sfx
		proxy:ValidSfx( 1987 );
		proxy:ValidSfx( 1991 );
	end	

-----------------------------------------------------------------------------------------
--ギミック関連 --EN:--Gimmick related
-----------------------------------------------------------------------------------------
--■0■ハシゴA降り■PCがイベントエリア(2000)の中に居て、アクションボタンを押したとき-- --EN:-- ■ 0 ■ Ladder A down ■ When the PC is in the event area (2000) and presses the action button --
	proxy:OnActionEventRegion(0, 2000, "OnEvent_0", LadderAngle_A, HELPID_DOWN, everytime);
--■1■ハシゴA昇り■PCがイベントエリア(2001)の中に居て、アクションボタンを押したとき-- --EN:-- ■ 1 ■ Climbing Ladder A ■ When the PC is in the event area (2001) and presses the action button --
	proxy:OnActionEventRegion(1, 2001, "OnEvent_1", LadderAngle_A, HELPID_UP,   everytime);

--■10■ハシゴB降り■PCがイベントエリア(2004)の中に居て、アクションボタンを押したとき-- --EN:-- ■ 10 ■ Get off ladder B ■ When the PC is in the event area (2004) and presses the action button --
	proxy:OnActionEventRegion(10, 2004, "OnEvent_10", LadderAngle_A, HELPID_DOWN, everytime);
--■11■ハシゴB昇り■PCがイベントエリア(2005)の中に居て、アクションボタンを押したとき-- --EN:-- ■ 11 ■ Climbing ladder B ■ When the PC is in the event area (2005) and presses the action button --
	proxy:OnActionEventRegion(11, 2005, "OnEvent_11", LadderAngle_A, HELPID_UP,   everytime);

--■20■ハシゴC降り■PCがイベントエリア(2030)の中に居て、アクションボタンを押したとき-- --EN:-- ■ 20 ■ Get off the ladder C ■ When the PC is in the event area (2030) and presses the action button --
	proxy:OnActionEventRegion(20, 2030, "OnEvent_20", LadderAngle_A, HELPID_DOWN, everytime);
--■21■ハシゴC昇り■PCがイベントエリア(2031)の中に居て、アクションボタンを押したとき-- --EN:-- ■ 21 ■ Climbing Ladder C ■ When the PC is in the event area (2031) and presses the action button --
	proxy:OnActionEventRegion(21, 2031, "OnEvent_21", LadderAngle_A, HELPID_UP,   everytime);

--■23■イスタレル■ --EN:-- ■ 23 ■ Istarel ■
	if proxy:IsCompleteEvent( 23 ) == false then
		--ホスト、生存、グレイのみ調べることができる --EN:--Only hosts, survivors, and grays can be examined
		local possible_chr_type = ATTR_HOST + ATTR_LIVE + ATTR_GREY;
		
		proxy:OnDistanceActionAttribute( 23 , LOCAL_PLAYER , 1002 , "OnEvent_23" , ItemBoxDist_A , 10010145 , 0 , ItemBoxAngle_A ,possible_chr_type, everytime ); 
		proxy:LuaCall( 23,1,"OnEvent_23_2",once);
		proxy:LuaCall( 23,2,"OnEvent_23_3",once);
		proxy:TreasureDispModeChange2( 1002, true ,KEN_SFX);
	else
		proxy:SetDrawEnable( 1002 , false );--ひとまず描画だけOFF --EN:--Only drawing is turned off for the time being
		proxy:SetColiEnable( 1002 , false );
	end	
	--proxy:SetRarity( 1002, 10419 );
	
	

--■30■跳ね橋A■PCがOBJ(1000)に対して反応角度(30)、角度オフセット(180)、距離(150)でアクションボタンを押す-- --EN:--■ 30 ■ Drawbridge A ■ PC presses the action button with reaction angle (30), angle offset (180), distance (150) against OBJ (1000) --
	if proxy:IsCompleteEvent( 30 ) ==false then
		proxy:OnDistanceActionPlus( 30, LOCAL_PLAYER, 1000, "OnEvent_30", DrawBridgeDist_A, HELPID_START, 180, DrawBridgeAngle_A, -1.5, -1.0, 1.4, once);
	else
		proxy:EndAnimation( 1000, 1 );
	end
	
--■40■跳ね橋B■PCがOBJ(1001)に対して反応角度(30)、角度オフセット(180)、距離(150)でアクションボタンを押す-- --EN:-- ■ 40 ■ Drawbridge B ■ PC presses the action button with reaction angle (30), angle offset (180), distance (150) against OBJ (1001) --
	if proxy:IsCompleteEvent( 40 ) ==false then
		proxy:OnDistanceActionPlus( 40, LOCAL_PLAYER, 1001, "OnEvent_40", DrawBridgeDist_A, HELPID_START, 180, DrawBridgeAngle_A, 0.3, -2.5, 1.9, once);
	else
		proxy:EndAnimation( 1001, 1 );
	end
	
--■50■床抜けA■PCがイベントエリア(1020)に入った時-- --EN:-- ■ 50 ■ Floor pass A ■ When PC enters the event area (1020) --
	if proxy:IsCompleteEvent( 50 ) ==false then
		proxy:OnRegionJustIn(50,LOCAL_PLAYER,1020, "OnEvent_50",once);
	else
		proxy:ReconstructBreak( 1020 , 1 );
	end
	
--■60■床抜けB■PCがイベントエリア(1021)に入った時-- --EN:-- ■ 60 ■ Floor pass B ■ When PC enters the event area (1021) --
	if proxy:IsCompleteEvent( 60 ) ==false then
		proxy:OnRegionJustIn(60,LOCAL_PLAYER,1021, "OnEvent_60",once);
	else
		proxy:ReconstructBreak( 1021 , 1 );
	end



	
--■70■揺れるつり橋A■PCがイベントエリア(2050)に入ったら --EN:-- ■ 70 ■ Swinging Suspension Bridge A ■ When the PC enters the event area (2050)
	proxy:OnRegionIn(70,LOCAL_PLAYER,2050,"OnEvent_70",everytime);	
	
--■80■揺れるつり橋B■PCがイベントエリア(2051)に入ったら --EN:--■80■ Swinging Suspension Bridge B ■When PC enters event area (2051)
	proxy:OnRegionIn(80,LOCAL_PLAYER,2051,"OnEvent_80",everytime);	

--■90■揺れるつり橋C■PCがイベントエリア(2052)に入ったら --EN:-- ■ 90 ■ Swinging Suspension Bridge C ■ When the PC enters the event area (2052)
	proxy:OnRegionIn(90,LOCAL_PLAYER,2052,"OnEvent_90",everytime);	

--■100■揺れるつり橋D■PCがイベントエリア(2053)に入ったら --EN:-- ■ 100 ■ Swinging Suspension Bridge D ■ When the PC enters the event area (2053)
	proxy:OnRegionIn(100,LOCAL_PLAYER,2053,"OnEvent_100",everytime);


--■130-131■ふわふわ足場■ --EN:-- 130-131 Fluffy Scaffolding
	proxy:RepeatMessage_begin();
		proxy:OnRegionIn( 130,LOCAL_PLAYER,2040,"OnEvent_130_1", once );
	proxy:RepeatMessage_end();
--■131■ふわふわ足場(領域内移動)■PCがイベントエリア(2041)に入ったら --EN:-- ■ 131 ■ Fluffy scaffolding (move within the area) ■ When the PC enters the event area (2041)
	proxy:OnRegionIn(131,LOCAL_PLAYER,2041,"OnEvent_131",everytime);
--■132■ふわふわ足場(領域内移動)■PCがイベントエリア(2042)に入ったら --EN:-- ■ 132 ■ Fluffy scaffolding (move within the area) ■ When the PC enters the event area (2042)
	proxy:OnRegionIn(132,LOCAL_PLAYER,2042,"OnEvent_132",everytime);
--■133■ふわふわ足場(領域内移動)■PCがイベントエリア(2043)に入ったら --EN:-- ■ 133 ■ Fluffy scaffolding (move within the area) ■ When the PC enters the event area (2043)
	proxy:OnRegionIn(133,LOCAL_PLAYER,2043,"OnEvent_133",everytime);

	

--■110■カラスが飛び立つ --EN:-- ■ 110 ■ Crow takes flight
	if proxy:IsCompleteEvent( 110 ) == false then
		proxy:OnRegistFunc(110,"Check_110","OnEvent_110",1,once);
	end
	--OnRegistFuncの場合最初のハンドラに自由に条件を定義してそこでtrueを返した時に結果のハンドラが呼ばれます。eginAction --EN:In the case of --OnRegistFunc, you can freely define a condition in the first handler, and the resulting handler will be called when true is returned there. eginAction
	--ハンドラのあとの1は識別子です。ここを変化する事で同イベントIDでも異なる監視として登録できます。 --EN:The 1 after the --handler is an identifier. By changing this, even the same event ID can be registered as different monitors.

--■280■石柱にワープ■ --EN:-- ■ 280 ■ Warp to the stone pillar ■
	SingleReset(proxy,280);
	proxy:TreasureDispModeChange2( 1983 , true ,KANAME_SFX);
	proxy:OnDistanceAction( 280, LOCAL_PLAYER, 1983, "OnEvent_280", WarpGimmickDist_A, HELPID_GO_TO_SEKITYUU, 0, 180, everytime );
	
--■281■最初の要石の光が消える■ --EN:-- ■ 281 ■ The light of the first keystone disappears ■
	proxy:OnSessionJustIn( 281 , "OnEvent_281" , everytime );
	
--■282■最初の要石の光が復活する■ --EN:-- ■ 282 ■ The light of the first keystone is revived ■
	proxy:OnSessionJustOut( 282 , "OnEvent_282" , everytime );
	
	
--■140■死んだふり腐敗人■ --EN:-- ■ 140 ■ Pretending to be dead rot ■
	if proxy:IsCompleteEvent( 140 ) == false then
		--proxy:OnPlayerDistanceInTarget( 140, LOCAL_PLAYER, 13056, "OnEvent_140", 1.5, once );
		proxy:OnRegionJustIn( 140, LOCAL_PLAYER, 2109, "OnEvent_140", once );
	end
		
--■141■死んだふり腐敗人■ --EN:--■ 141 ■ Pretending to be dead rot ■
	if proxy:IsCompleteEvent( 141 ) == false then
		--proxy:OnPlayerDistanceInTarget( 141, LOCAL_PLAYER, 13057, "OnEvent_141", 1.5, once );--宝 --EN:--Treasure
		proxy:OnRegionJustIn( 141, LOCAL_PLAYER, 2110, "OnEvent_141", once );--つり橋	  --EN:--suspension bridge
		proxy:OnRegionJustIn( 141, LOCAL_PLAYER, 2100, "OnEvent_141", once );--つり橋	  --EN:--suspension bridge
	end
	
--■142■死んだふり腐敗人■ --EN:--■ 142 ■ Pretending to be dead and corrupt ■
	if proxy:IsCompleteEvent( 142 ) == false then
		--proxy:OnPlayerDistanceInTarget( 142, LOCAL_PLAYER, 13058, "OnEvent_142", 1.5, once );--宝 --EN:--Treasure
		proxy:OnRegionJustIn( 142, LOCAL_PLAYER, 2111, "OnEvent_142", once );--つり橋	  --EN:--suspension bridge
	end
	
--■143■死んだふり腐敗人■ --EN:--■ 143 ■ Pretending to be dead and corrupt ■
	if proxy:IsCompleteEvent( 143 ) == false then
		--proxy:OnPlayerDistanceInTarget( 143, LOCAL_PLAYER, 13059, "OnEvent_143", 1.5, once );--宝 --EN:--Treasure
		proxy:OnRegionJustIn( 143, LOCAL_PLAYER, 2112, "OnEvent_143", once );--つり橋	  --EN:--suspension bridge
		proxy:OnRegionJustIn( 143, LOCAL_PLAYER, 2104, "OnEvent_143", once );--跳ね橋 --EN:-- Drawbridge
	end
	
--■144■死んだふり腐敗人■ --EN:--■ 144 ■ Pretending to be dead rot ■
	if proxy:IsCompleteEvent( 144 ) == false then
		proxy:OnRegionJustIn( 144, LOCAL_PLAYER, 2101, "OnEvent_144", once );--つり橋 --EN:--suspension bridge
	end
	
--■145■死んだふり腐敗人■ --EN:-- ■ 145 ■ Pretending to be dead rot ■
	if proxy:IsCompleteEvent( 145 ) == false then
		proxy:OnRegionJustIn( 145, LOCAL_PLAYER, 2102, "OnEvent_145", once );--つり橋 --EN:--suspension bridge
		proxy:OnRegionJustIn( 145, LOCAL_PLAYER, 2103, "OnEvent_145", once );--つり橋 --EN:--suspension bridge
	end
	
--■146■死んだふり腐敗人■ --EN:--■ 146 ■ Pretending to be dead rot ■
	if proxy:IsCompleteEvent( 146 ) == false then
		proxy:OnRegionJustIn( 146, LOCAL_PLAYER, 2040, "OnEvent_146", once );--ふわふわ足場 --EN:--Fluffy Scaffolding
	end
	
--■147■死んだふり腐敗人■ --EN:--■ 147 ■ Pretending to be dead rot ■
	if proxy:IsCompleteEvent( 147 ) == false then
		proxy:OnRegionJustIn( 147, LOCAL_PLAYER, 2105, "OnEvent_147", once );--領域 --EN:--region
		proxy:OnRegionJustIn( 147, LOCAL_PLAYER, 2106, "OnEvent_147", once );--領域 --EN:--region
	end
	
--■148■死んだふり腐敗人■ --EN:-- ■ 148 ■ Pretending to be dead and corrupt ■
	if proxy:IsCompleteEvent( 148 ) == false then
		proxy:OnRegionJustIn( 148, LOCAL_PLAYER, 2107, "OnEvent_148", once );--領域 --EN:--region
	end
	
--■149■死んだふり腐敗人■ --EN:--■ 149 ■ Pretending to be dead and corrupt ■
	if proxy:IsCompleteEvent( 149 ) == false then
		proxy:OnRegionJustIn( 149, LOCAL_PLAYER, 2108, "OnEvent_149", once );--領域 --EN:--region
	end
	
	
--■150■小石が振ってくる■ --EN:-- ■ 150 ■ pebbles shake ■
	if proxy:IsCompleteEvent( 150 ) == false then
		proxy:OnRegionJustIn( 150, LOCAL_PLAYER, 2080, "OnEvent_150", once );
	end	
--■151■小石が振ってくる■ --EN:-- ■ 151 ■ pebbles shake ■
	if proxy:IsCompleteEvent( 151 ) == false then
		proxy:OnRegionJustIn( 151, LOCAL_PLAYER, 2081, "OnEvent_151", once );
	end	

--■200～256■腐敗人転落死■ --EN:--■ 200～256 ■ Corruption Fall Death ■
	local fall_chrId_list = {300, 301, 302, 303, 304, 305, 306, 307, 308, 309,
							 310, 311, 312, 313, 314, 315, 316, 317, 318, 319,
							 320, 321, 322, 323, 324, 325, 326, 327, 328, 329,
							 330, 333, 334, 335, 336, 338,
							 500, 501, 502, 503, 504, 505, 506, 507, 508, 509,
							 510, 511, 512, 513, 514, 515, 516};
	local fall_chrNum = table.getn(fall_chrId_list);
	for index = 1, fall_chrNum, 1 do
		proxy:OnRegionJustIn( 200 + index - 1, fall_chrId_list[index], 2141, "fall_countup", once );
		proxy:OnRegionJustIn( 200 + index - 1, fall_chrId_list[index], 2142, "fall_countup", once );
		--proxy:OnRegistFunc( 200 + index - 1, "fall_Condition", "fall_result",fall_chrId_list[index], once );
	end


--■??■徘徊デーモンの登場■ハンドラ登録 --EN:--■??■Appearance of wandering daemon■Handler registration
	proxy:NotNetMessage_begin();
		--プレイヤーがソロで死亡した時にキックされます。 --EN:--Kicked when a player dies solo.
		proxy:LuaCall( 4000, 100, "PlayerDeath_m05_00_00_00", everytime );
		--プレイヤーが復活した時にキックされます。 --EN:--Kicked when the player is revived.
		proxy:LuaCall( 4032, 100, "PlayerRevive_m05_00_00_00", everytime );
	proxy:NotNetMessage_end();	

--■22■はしご出現■QWCイベント --EN:-- ■ 22 ■ ladder appearance ■ QWC event
	SingleReset(proxy,22);	
	if 	proxy:IsSuccessQWC(50150) == false and
		proxy:IsCompleteEvent(24) == false then
		proxy:SetEventFlag( 22, true );--QWC未成立		 --EN:--QWC not established
	end
	
	if proxy:IsCompleteEvent(24) == false then
		if proxy:IsClient() == false then
			proxy:NotNetMessage_begin();
				proxy:OnRegionJustIn( 24 , 10000 , 2170 , "OnEvent_24",once);
			proxy:NotNetMessage_end();
		end
	end
	
	if proxy:IsCompleteEvent( 22 ) == false then
		print("[成立]QWCはしご"); --EN:print("[Confirmed] QWC ladder");
	else
		print("[未成立]QWCはしご"); --EN:print("[unestablished] QWC ladder");
		--はしご上り下りイベントを削除し、はしごの当たり・描画を消去 --EN:--Remove ladder up/down event, erase ladder hit/drawing
		proxy:DeleteEvent(20);
		proxy:DeleteEvent(21);
		proxy:SetColiEnable( 1062, false );
		proxy:SetDrawEnable( 1062, false );
	end

--[[
--■床抜けのオブジェの破壊同期 --EN:-- ■ Destruction synchronization of objects in the floor
	
	--床抜けA --EN:--Floor gap A
	if proxy:IsCompleteEvent( 50 ) ==true then
		proxy:ReconstructBreak( 1020 , 1 );
	end
	
	--床抜けB --EN:--Floor gap B
	if proxy:IsCompleteEvent( 60 ) ==true then
		proxy:ReconstructBreak( 1021 , 1 );
	end
]]
	
	
--■140■死んだふり腐敗人■ --EN:-- ■ 140 ■ Pretending to be dead rot ■
	if proxy:IsCompleteEvent(140) == false then
		--フラグが立ってない場合はひとまず死んだフリ --EN:--If the flag is not set, pretend to be dead for the time being
		proxy:EnableLogic( 500, false );
		proxy:SetColiEnable( 500, false );
		proxy:EnableHide( 500, true );
	else
		--特殊待機解除 --EN:--Cancel special standby
		proxy:SetSpStayAndDamageAnimId( 500 ,-1,-1);
	end
	
--■141■死んだふり腐敗人■ --EN:--■ 141 ■ Pretending to be dead rot ■
	if proxy:IsCompleteEvent(141) == false then
		--フラグが立ってない場合はひとまず死んだフリ --EN:--If the flag is not set, pretend to be dead for the time being
		proxy:EnableLogic( 501, false );
		proxy:EnableLogic( 502, false );
		proxy:SetColiEnable( 501, false );
		proxy:SetColiEnable( 502, false );
		proxy:EnableHide( 501, true );
		proxy:EnableHide( 502, true );
	else
		--特殊待機解除 --EN:--Cancel special standby
		proxy:SetSpStayAndDamageAnimId( 501 ,-1,-1);		
		proxy:SetSpStayAndDamageAnimId( 502 ,-1,-1);
	end

--■142■死んだふり腐敗人■ --EN:--■ 142 ■ Pretending to be dead and corrupt ■
	if proxy:IsCompleteEvent(142) == false then
		--フラグが立ってない場合はひとまず死んだフリ --EN:--If the flag is not set, pretend to be dead for the time being
		proxy:EnableLogic( 503, false );
		proxy:SetColiEnable( 503, false );
		proxy:EnableHide( 503, true );
	else
		--特殊待機解除 --EN:--Cancel special standby
		proxy:SetSpStayAndDamageAnimId( 503 ,-1,-1);
	end
	
--■143■死んだふり腐敗人■ --EN:--■ 143 ■ Pretending to be dead and corrupt ■
	if proxy:IsCompleteEvent(143) == false then
		--フラグが立ってない場合はひとまず死んだフリ --EN:--If the flag is not set, pretend to be dead for the time being
		proxy:EnableLogic( 504, false );
		proxy:EnableLogic( 505, false );
		proxy:SetColiEnable( 504, false );
		proxy:SetColiEnable( 505, false );
		proxy:EnableHide( 504, true );
		proxy:EnableHide( 505, true );
	else
		proxy:SetSpStayAndDamageAnimId( 504 ,-1,-1);
		proxy:SetSpStayAndDamageAnimId( 505 ,-1,-1);
	end

--■144■死んだふり腐敗人■ --EN:--■ 144 ■ Pretending to be dead rot ■
	if proxy:IsCompleteEvent(144) == false then
		--フラグが立ってない場合はひとまず死んだフリ --EN:--If the flag is not set, pretend to be dead for the time being
		proxy:EnableLogic( 506, false );
		proxy:SetColiEnable( 506, false );
		proxy:EnableHide( 506, true );
	else
		proxy:SetSpStayAndDamageAnimId( 506 ,-1,-1);
	end
	
--■145■死んだふり腐敗人■ --EN:-- ■ 145 ■ Pretending to be dead rot ■
	if proxy:IsCompleteEvent(145) == false then
		--フラグが立ってない場合はひとまず死んだフリ --EN:--If the flag is not set, pretend to be dead for the time being
		proxy:EnableLogic( 507, false );
		proxy:EnableLogic( 508, false );
		proxy:SetColiEnable( 507, false );
		proxy:SetColiEnable( 508, false );
		proxy:EnableHide( 507, true );
		proxy:EnableHide( 508, true );
	else
		proxy:SetSpStayAndDamageAnimId( 507 ,-1,-1);
		proxy:SetSpStayAndDamageAnimId( 508 ,-1,-1);
	end
	
--■146■死んだふり腐敗人■ --EN:--■ 146 ■ Pretending to be dead rot ■
	if proxy:IsCompleteEvent(146) == false then
		--フラグが立ってない場合はひとまず死んだフリ --EN:--If the flag is not set, pretend to be dead for the time being
		proxy:EnableLogic( 509, false );
		proxy:EnableLogic( 510, false );
		proxy:SetColiEnable( 509, false );
		proxy:SetColiEnable( 510, false );
		proxy:EnableHide( 509, true );
		proxy:EnableHide( 510, true );
	else
		proxy:SetSpStayAndDamageAnimId( 509 ,-1,-1);
		proxy:SetSpStayAndDamageAnimId( 510 ,-1,-1);
	end
	
--■147■死んだふり腐敗人■ --EN:--■ 147 ■ Pretending to be dead rot ■
	if proxy:IsCompleteEvent(147) == false then
		--フラグが立ってない場合はひとまず死んだフリ --EN:--If the flag is not set, pretend to be dead for the time being
		proxy:EnableLogic( 511, false );
		proxy:EnableLogic( 512, false );
		proxy:SetColiEnable( 511, false );
		proxy:SetColiEnable( 512, false );
		proxy:EnableHide( 511, true );
		proxy:EnableHide( 512, true );
	else
		proxy:SetSpStayAndDamageAnimId( 511 ,-1,-1);
		proxy:SetSpStayAndDamageAnimId( 512 ,-1,-1);
	end
	
--■148■死んだふり腐敗人■ --EN:-- ■ 148 ■ Pretending to be dead and corrupt ■
	if proxy:IsCompleteEvent(148) == false then
		--フラグが立ってない場合はひとまず死んだフリ --EN:--If the flag is not set, pretend to be dead for the time being
		proxy:EnableLogic( 513, false );
		proxy:EnableLogic( 514, false );
		proxy:EnableLogic( 515, false );
		proxy:SetColiEnable( 513, false );
		proxy:SetColiEnable( 514, false );
		proxy:SetColiEnable( 515, false );
		proxy:EnableHide( 513, true );
		proxy:EnableHide( 514, true );
		proxy:EnableHide( 515, true );
	else
		proxy:SetSpStayAndDamageAnimId( 513 ,-1,-1);
		proxy:SetSpStayAndDamageAnimId( 514 ,-1,-1);
		proxy:SetSpStayAndDamageAnimId( 515 ,-1,-1);
	end

--■149■死んだふり腐敗人■ --EN:--■ 149 ■ Pretending to be dead and corrupt ■
	if proxy:IsCompleteEvent(149) == false then
		--フラグが立ってない場合はひとまず死んだフリ --EN:--If the flag is not set, pretend to be dead for the time being
		proxy:EnableLogic( 516, false );
		proxy:SetColiEnable( 516, false );
		proxy:EnableHide( 516, true );
	else
		proxy:SetSpStayAndDamageAnimId( 516 ,-1,-1);
	end	
	
	

--■150■小石が振ってくる■ --EN:-- ■ 150 ■ pebbles shake ■
	if proxy:IsCompleteEvent(150) == true then
		proxy:ReconstructBreak( 1070 , 1 );
		proxy:ReconstructBreak( 1071 , 1 );
		proxy:ReconstructBreak( 1072 , 1 );
		proxy:ReconstructBreak( 1073 , 1 );
		proxy:ReconstructBreak( 1074 , 1 );
		proxy:ReconstructBreak( 1075 , 1 );
	end
	
	
--[[
	--■徘徊デーモン用 (フラグは仮、指定があれば変える) --EN:--■For wandering daemon (flag is tentative, change if specified)
	if proxy:IsCompleteEvent( 20 ) == true then
		LuaFunc_VisibleTheWanderingDemon  (proxy, param, demon_id_list_m05_00_00_00);
	else
		LuaFunc_InvisibleTheWanderingDemon(proxy, param, demon_id_list_m05_00_00_00);
	end
	proxy:SetEventSimpleTalk( 100, LOCAL_PLAYER, 500, 2.0, 10010200, 0.0, 45.0, 0.0, 0.0, 0.0, ATTR_ALL, true, everytime );
	proxy:AddEventSimpleTalk( 100, 16000 );
	proxy:AddEventSimpleTalkTimer( 100, 16001, 1.5 );
	proxy:AddEventSimpleTalkTimer( 100, 16002, 3.0 );
	proxy:AddEventSimpleTalk( 100, 16003 );
	proxy:AddEventSimpleTalk( 100, 16010 );
]]	
	
	--■180■光の壁■ --EN:-- ■ 180 ■ wall of light ■
	if proxy:IsCompleteEvent( 180 ) == false then
		proxy:OnDistanceActionAttribute( 180, LOCAL_PLAYER, 1080, "OnEvent_180", 1.5, 10010403, 180.0, 90.0, ATTR_HOST + ATTR_LIVE + ATTR_GREY, everytime );
		--proxy:SetObjSfx( 1080, 200, 85990, true );
	end
	
	--■181■光の壁■ --EN:-- 181 Wall of light
	if proxy:IsCompleteEvent( 181 ) == false then
		proxy:OnDistanceActionAttribute( 181, LOCAL_PLAYER, 1081, "OnEvent_181", 1.5, 10010403, 180.0, 90.0, ATTR_HOST + ATTR_LIVE + ATTR_GREY, everytime );
		--proxy:SetObjSfx( 1081, 200, 85991, true );
	end
	
	--■180,181■光の壁再現■ --EN:-- ■ 180, 181 ■ light wall reproduction ■
	if proxy:IsCompleteEvent( 180 ) == false or
	   proxy:IsCompleteEvent( 181 ) == false then
		proxy:LuaCall( 180, 1, "OnEvent_180_181_delete", once );
	else
		proxy:SetDrawEnable( 1080, false );--描画OFF --EN:--Drawing OFF
		proxy:SetColiEnable( 1080, false );--当たりOFF --EN:--Hit OFF
		
		proxy:SetDrawEnable( 1081, false );--描画OFF --EN:--Drawing OFF
		proxy:SetColiEnable( 1081, false );--当たりOFF --EN:--Hit OFF
		
		--ただの再現なので自然な表現の必要が無い為、RootErase指定ではない --EN:--Since it is just a reproduction, there is no need for natural expression, so it is not RootErase specification
		proxy:InvalidSfx( 2125, false );
		proxy:InvalidSfx( 2126, false );
	end

	--■190■板落ち■ --EN:-- ■ 190 ■ board omission ■
	if proxy:IsCompleteEvent( 190 ) == false then
		proxy:OnRegionJustIn( 190, LOCAL_PLAYER, 2085, "OnEvent_190", once );
	else
		proxy:ReconstructBreak( 2085, 1 );
	end

--■167■ボス戦カメラ対応■ --EN:-- ■ 167 ■ Boss battle camera support ■
	--ボスが生きているなら登録 --EN:--Register if the boss is alive
	if proxy:IsCompleteEvent(5650) == false then
		proxy:NotNetMessage_begin();
			proxy:OnRegionIn( 167 , LOCAL_PLAYER , 2887 ,"OnEvent_167" , everytime );
		proxy:NotNetMessage_end();
	end
	
--■8087■不浄に来たフラグを立てる■ --EN:-- ■ 8087 ■ Raise a flag that came to unclean ■
	proxy:SetEventFlag( 8087, true );
	
--[[---------------------------------------------------------------------------------------
--NPC関連 --EN:--NPC related
-----------------------------------------------------------------------------------------	
	--フラグを見てNPC状態を初期化 --EN:--Initialize the NPC state by looking at the flag
	SetFirstNpcStateFlag( proxy, param, kojiki_m50_flag_list, KOJIKI_M50_STATE_SEELING );
	
	--死亡していないとき --EN:--when not dead
	if proxy:IsCompleteEvent(KOJIKI_M50_STATE_DEAD) == false then
		--■270■乞食(男)敵対■ --EN:-- ■ 270 ■ beggar (male) hostility ■
		if proxy:IsCompleteEvent( 270 ) == false then
			proxy:OnCharacterTotalDamage( 270, 650, LOCAL_PLAYER, TOTALDAMAGE_KOJIKI_M50, "OnEvent_270", once );
		end
		--■271■乞食(男)死亡■ --EN:-- ■ 271 ■ beggar (male) died ■
		if proxy:IsCompleteEvent( 271 ) == false then
			proxy:OnCharacterDead( 271, 650, "OnEvent_271", once );
		end
	else
		print("乞食(男)死亡"); --EN:print("Beggar (man) died");
		--死んでいるので無効化 --EN:--disabled because it's dead
		proxy:ForceUpdateNextFrame(650);
		InvalidCharactor( proxy, 650 );
	end
]]

	--乞食(女)のショップNPC --EN:--Beggar (female) shop NPC
	if proxy:IsClient() == false then
	--■340■乞食(女)のショップNPCチェックポイント(要石)■ --EN:--■ 340 ■ Beggar (female) shop NPC checkpoint (keystone) ■
		proxy:OnRegionJustIn(272 , LOCAL_PLAYER , 2160 ,"OnEvent_272" , everytime);
	--■340■乞食(女)のショップNPCチェックポイント(蛭デーモン)■ --EN:--■ 340 ■ Beggar (female) shop NPC checkpoint (leech demon) ■
		proxy:OnRegionJustIn(273 , LOCAL_PLAYER , 2161 ,"OnEvent_273" , everytime);
	--■340■乞食(女)のショップNPCチェックポイント(蝿デーモン)■ --EN:--■ 340 ■ Beggar (female) shop NPC checkpoint (fly demon) ■
		proxy:OnRegionJustIn(275 , LOCAL_PLAYER , 2370 ,"OnEvent_275" , everytime);
	end
	
	--■635■チェックポイントの監視■ --EN:-- ■ 635 ■ Checkpoint monitoring ■
	proxy:LuaCall( 812 , 1 , "OnEvent_812",everytime);

	--乞食(女)の初期化用 --EN:--For beggar (female) initialization
	OnEvent_812(proxy, param);

--------------------------------▽▽▽QWCイベント関連▽▽▽-------------------------------- --EN:--▽▽▽QWC event related ▽▽▽--------------------------------

--■292■QWCソウルモンスター■ --EN:--■292■QWC Soul Monster■
	if proxy:IsSuccessQWC(50100) == false then--成立していないならば --EN:--If not established
		print("ブラックゴースト無効化"); --EN:print("Disable Black Ghost");
		--431を無効化 --EN:disable --431
		InvalidBackRead(proxy, 431);
		--432を無効化 --EN:disable --432
		InvalidBackRead(proxy, 432);
		--433を無効化 --EN:disable --433
		InvalidBackRead(proxy, 433);
		
		proxy:SetEventFlag(292, true);
	end
	
--トカゲ逃亡イベント --EN:-- Lizard Escape Event
	RegistTokage(proxy,310,461,15);
	RegistTokage(proxy,830,462,16);
	RegistTokage(proxy,1140,463,17);
	
	--[[
00      520     9000    9600　　320  --EN:00 520 9000 9600 320
0000    521     9000    9600　　321  --EN:0000 521 9000 9600 321
01      523     9000    9600　　322  --EN:01 523 9000 9600 322
02      524     9000    9600　　323  --EN:02 524 9000 9600 323
03      525     9000    9600　　324  --EN:03 525 9000 9600 324
04      526     9000    9600　　325  --EN:04 526 9000 9600 325
	]]
	
	local actidlist = {320,321,322,323,324,325};
	local daniidlist= {520,521,522,523,524,525};
	local num = table.getn( actidlist );

	for index = 1 ,num , 1 do
		--■actidlist■血ダニダメージ■ --EN:-- ■ actidlist ■ blood mite damage ■
		SingleReset(proxy,actidlist[index]);
		if proxy:IsCompleteEvent( actidlist[index] ) == false then
			--proxy:EnableLogic( daniidlist[index], false );
			proxy:OnSimpleDamage( actidlist[index] , daniidlist[index] , 10000 , "OnEvent_"..actidlist[index],once);
		else
			--proxy:SetSpStayAndDamageAnimId( daniidlist[index] ,-1,-1);
		end
	end
	
	
	
--------------------------------△△△QWCイベント関連△△△-------------------------------- --EN:--△△△QWC event related△△△--------------------------------
	
	--■999999■フレーム遅れの初期化処理イベントを発行■ --EN:-- ■ 999999 ■ Generate a frame delay initialization processing event ■
	proxy:NotNetMessage_begin();
		--▼0秒後▼-- --EN:--▼After 0 seconds▼--
		proxy:OnKeyTime2( 999991, "Second_Initialize_m05_00_00_00", 0.0, 0, 0, once );	
	proxy:NotNetMessage_end();	
	
	--■1フレーム遅れの初期化処理イベントを発行■ --EN:--■ Issue an initialization processing event with a delay of 1 frame ■
--~ 	proxy:NotNetMessage_begin();
--~ 		--▼1秒間▼--初期位置が若干浮いている場合、初期状態が待機モーションにならない可能性があるため、1秒間送り続ける --EN:--▼1 second▼--If the initial position is slightly floating, the initial state may not be a standby motion, so keep sending for 1 second
--~ 		proxy:OnKeyTime2( 999990, "Third_Initialize_m05_00_00_00", 1.0, 1, 1, once );
--~ 	proxy:NotNetMessage_end();
	
	if proxy:IsDbgReLoad() == true then
		proxy:OnKeyTime2( 4021,"OnEvent_DbgReLoad",1.0,0,0,once);
	end	
	print("Initialize_m05_00_00_00 end");
end

--リロードデバッグ --EN:--reload debug
function OnEvent_DbgReLoad(proxy,param)
	--完全回復要求 --EN:-- full recovery request
	proxy:RequestFullRecover();
	--石柱の不浄要石へ --EN:--To the impure keystone of the stone pillar
	proxy:WarpNextStage( 1, 0, 0, 0, 1009 );
end

function OnEvent_4000_Hp_1(proxy,param)
	print("OnEvent_4000_Hp_1 begin");
	proxy:SetDeadMode2(808 , true );
	proxy:SetDeadMode2(809 , true );
	proxy:SetDeadMode2(824 , true );
	print("OnEvent_4000_Hp_1 end");
end


--------------------------------------------------------------------------------------
--Initializeから呼ばれる、1フレーム遅れの初期化処理■999999 --EN:--Initialization with a delay of 1 frame, called from Initialize ■999999
--------------------------------------------------------------------------------------
--■999999■一部、Initでは処理できないので、残しておく --EN:-- ■ 999999 ■ Some parts cannot be processed by Init, so leave them
function Second_Initialize_m05_00_00_00(proxy, param)
	print("Second_Initialize_m05_00_00_00 begin");
	
--------------------------------▽▽▽QWCイベント関連▽▽▽-------------------------------- --EN:--▽▽▽QWC event related ▽▽▽--------------------------------
-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
--------------------------------△△△QWCイベント関連△△△-------------------------------- --EN:--△△△QWC event related△△△--------------------------------

--■198,199■腐敗人死体有効化■ --EN:--■ 198,199 ■ Rotten corpses enabled ■
	local fall_chrId_list = {300, 301, 302, 303, 304, 305, 306, 307, 308, 309,
							 310, 311, 312, 313, 314, 315, 316, 317, 318, 319,
							 320, 321, 322, 323, 324, 325, 326, 327, 328, 329,
							 330, 331, 332, 333, 334, 335, 336, 337, 338, 339,
							 500, 501, 502, 503, 504, 505, 506, 507, 508, 509,
							 510, 511, 512, 513, 514, 515, 516};
	local fall_chrNum = table.getn(fall_chrId_list);
	
	proxy:SetEventFlag( 198, false );
	proxy:SetEventFlag( 199, false );
	proxy:OnNetRegion( 198, 2140 );
	--proxy:OnRegistFunc( 199, "corpse_Condition", "corpse_Result", fall_chrNum, everytime );
	--proxy:OnRegionJustIn( 199, LOCAL_PLAYER, 2140, "corpse_ReginIn", everytime );
	
	proxy:OnRegionJustIn( 199, LOCAL_PLAYER, 2140, "corpseCheck", everytime );
	proxy:LuaCall( 199, 2, "corpseUpdate", everytime );
	local fall_count = 0;
	for index = 1, fall_chrNum, 1 do
		if proxy:IsCompleteEvent( 200 + index - 1 ) == true then
			fall_count = fall_count + 1;
		end
	end
	for index = 1, 10, 1 do
		if fall_count >= index then
			proxy:SetDrawEnable( 10270 + index - 1, true );
			proxy:SetColiEnable( 10270 + index - 1, true );
			proxy:EnableObjTreasure( 10270 + index - 1, true );
		else
			print("宝死体無効化",10270 + index - 1); --EN:print("Disable Treasure Corpse",10270 + index - 1);
			proxy:SetDrawEnable( 10270 + index - 1, false );
			proxy:SetColiEnable( 10270 + index - 1, false );
			proxy:EnableObjTreasure( 10270 + index - 1, false );
		end
	end
	
	

	print("Second_Initialize_m05_00_00_00 end");
end


--■1フレーム遅れの初期化処理■ --EN:--■ 1 frame delay initialization processing ■
function Third_Initialize_m05_00_00_00(proxy, param)
	print("Third_Initialize_m05_00_00_00 begin");
	--死んだふり腐敗人にコマンドを送る --EN:--Send commands to dead rotters
	if proxy:IsCompleteEvent(140) == false then
		--proxy:SetEventCommand( 500, 200);
	end
	if proxy:IsCompleteEvent(141) == false then
		--proxy:SetEventCommand( 501, 200);
		--proxy:SetEventCommand( 502, 200);
	end
	if proxy:IsCompleteEvent(142) == false then
		--proxy:SetEventCommand( 503, 200);
	end
	if proxy:IsCompleteEvent(143) == false then
		--proxy:SetEventCommand( 504, 200);
		--proxy:SetEventCommand( 505, 200);
	end
	if proxy:IsCompleteEvent(144) == false then
		--proxy:SetEventCommand( 506, 200);
	end
	if proxy:IsCompleteEvent(145) == false then
		--proxy:SetEventCommand( 507, 200);
		--proxy:SetEventCommand( 508, 200);
	end
	if proxy:IsCompleteEvent(146) == false then
		--proxy:SetEventCommand( 509, 200);
		--proxy:SetEventCommand( 510, 200);
	end
	if proxy:IsCompleteEvent(147) == false then
		--proxy:SetEventCommand( 511, 200);
		--proxy:SetEventCommand( 512, 200);
	end
	if proxy:IsCompleteEvent(148) == false then
		--proxy:SetEventCommand( 513, 200);
		--proxy:SetEventCommand( 514, 200);
		--proxy:SetEventCommand( 515, 200);
	end
	if proxy:IsCompleteEvent(149) == false then
		--proxy:SetEventCommand( 516, 200);
	end
	

--■初期化のみなのでID無し■血ダニ満服■ --EN:-- ■ No ID because it is only initialization ■ Blood mite full ■
--~ 	proxy:SetEventCommand( 520, 350);
--~ 	proxy:SetEventCommand( 521, 350);
--~ 	proxy:SetEventCommand( 522, 350);
--~ 	proxy:SetEventCommand( 523, 350);
--~ 	proxy:SetEventCommand( 524, 350);
--~ 	proxy:SetEventCommand( 525, 350);
--~ 	proxy:SetEventCommand( 526, 350);

	
	print("Third_Initialize_m05_00_00_00 end");
end


--------------------------------------------------------------------------------------
--ハシゴA降り■0 --EN:--Ladder A down 0
--------------------------------------------------------------------------------------
--■0■ハシゴA降りスタート■ --EN:-- ■ 0 ■ Ladder A descending start ■
function OnEvent_0(proxy, param)
	print("OnEvent_0 begin");
	
	if param:IsNetMessage() == true then
		print("IsNetMessage true");
		print("OnEvent_0 end");
		return;
	end

	--はしご降りに必要な前処理-- --EN:--Pretreatment required for descending the ladder--
	proxy:BeginAction(LOCAL_PLAYER,2,2,2);				--ホバー移動モードに移行 --EN:--Transition to hover movement mode
	--proxy:HoverMoveVal(LOCAL_PLAYER,2002,LadderTime_A);--移動位置(2002)に0.5秒でホバー移動 --EN:--Hover move to moving position (2002) in 0.5 seconds
	proxy:HoverMoveValDmy(LOCAL_PLAYER,1060,192,LadderTime_A);--移動位置(2003)に0.5秒でホバー移動 --EN:--Hover in 0.5 seconds to move position (2003)
	proxy:SetEventCommand(LOCAL_PLAYER,1);				--イベントコマンドID(1)"ハシゴ上から掴"むを送る --EN:-- Send event command ID (1) "Grab from the top of the ladder"
	proxy:SetKeepCommandIndex(LOCAL_PLAYER, 0, 1, 3.0 );
	proxy:DisableMove(LOCAL_PLAYER,1);					--キャラクタを移動、旋回不能に --EN:--Move the character, make it impossible to turn
	
	proxy:NotNetMessage_begin();
		--0.5秒(ホバー移動終了)後にはしご降りスタートイベントを発行 --EN:-- Issue a ladder descend start event after 0.5 seconds (end of hover movement)
		proxy:OnKeyTime2(0,"OnEvent_0_1",LadderTime_A,0,0,once);
		--はしご降り専用の関数を3秒間発行(カメラの周り込みなどの処理) --EN:--Issue a function dedicated to descending the ladder for 3 seconds (processing such as surrounding the camera)
		proxy:OnKeyTime2(0,"LadderDown",3,1,1,once);
	proxy:NotNetMessage_end();

	print("OnEvent_0 end");
end

--■0_1■ハシゴA降りスタート:ホバー移動終了■ --EN:-- 0_1 ■ Start descending from ladder A: End of hover movement ■
function OnEvent_0_1(proxy, param)
	print("OnEvent_0_1 begin");
	
	if proxy:GetEventMode(LOCAL_PLAYER) == 0 then
		print("Local Player GetEventMode 0");
		print("OnEvent_0_1 end");
		return;
	end

	--ハシゴアクションモードに移行-- --EN:--Transition to ladder action mode--
	--nMax  : はしごの段数 - 補正値(補正値はおおよそ3) --EN:--nMax : number of ladder steps - correction value (correction value is approximately 3)
	--nStart: 降りるとき→(nMax + 1) 昇るとき→(-1) --EN:--nStart: When going down→(nMax + 1) When going up→(-1)
	proxy:BeginAction(LOCAL_PLAYER,1,5,4);
	
	--キャラクタを移動、旋回可能に-- --EN:--Character can be moved and turned--
	proxy:DisableMove(LOCAL_PLAYER,0);
	
	print("OnEvent_0_1 end");
end


--------------------------------------------------------------------------------------
--ハシゴA昇り■1 --EN:--Ladder A climbing 1
--------------------------------------------------------------------------------------
--■1■ハシゴA昇りスタート■ --EN:--■ 1 ■ Ladder A climbing start ■
function OnEvent_1(proxy, param)
	print("OnEvent_1 begin");
	
	if param:IsNetMessage() == true then
		print("IsNetMessage true");
		print("OnEvent_1 end");
		return;
	end
	
	--はしご昇りに必要な前処理-- --EN:--Pretreatment required for climbing a ladder--
	proxy:BeginAction(LOCAL_PLAYER,2,-1,1);			--ホバー移動モードに移行 --EN:--Transition to hover movement mode
	--proxy:HoverMoveVal(LOCAL_PLAYER,2003,LadderTime_A);--移動位置(2003)に0.5秒でホバー移動 --EN:--Hover in 0.5 seconds to move position (2003)
	proxy:HoverMoveValDmy(LOCAL_PLAYER,1060,191,LadderTime_A);--移動位置(2003)に0.5秒でホバー移動 --EN:--Hover in 0.5 seconds to move position (2003)
	proxy:SetEventCommand(LOCAL_PLAYER,0);				--イベントコマンドID(0)"ハシゴ下から掴"むを送る --EN:-- Send event command ID (0) "grab from under the ladder"
	proxy:SetKeepCommandIndex(LOCAL_PLAYER, 0, 1, 3.0 );
	proxy:DisableMove(LOCAL_PLAYER,1);					--キャラクタを移動、旋回不能に --EN:--Move the character, make it impossible to turn
	
	proxy:NotNetMessage_begin();
		--0.5秒(ホバー移動終了)後にはしご昇りスタートイベントを発行 --EN:-- Issue a ladder climb start event after 0.5 seconds (end of hover movement)
		proxy:OnKeyTime2(1,"OnEvent_1_1",LadderTime_A,0,0,once);
		--はしご昇り用の関数を1秒間発行(イベントメニューの中断処理?) --EN:--Issuing a function for climbing a ladder for 1 second (interruption processing of the event menu?)
		proxy:OnKeyTime2(1,"EventMenuBrake",1,1,1,once);
	proxy:NotNetMessage_end();
	
	print("OnEvent_1 end");
end

--■1_1■ハシゴA昇りスタート:ホバー移動終了■ --EN:--■ 1_1 ■ Start climbing ladder A: End hover movement ■
function OnEvent_1_1(proxy, param)
	print("OnEvent_1_1 begin");
	
	if proxy:GetEventMode(LOCAL_PLAYER) == 0 then
		print("Local Player GetEventMode 0");
		print("OnEvent_1_1 end");
		return;
	end

	--ハシゴアクションモードに移行-- --EN:--Transition to ladder action mode--
	--nMax  : はしごの段数 - 補正値(補正値はおおよそ3) --EN:--nMax : number of ladder steps - correction value (correction value is approximately 3)
	--nStart: 降りるとき→(nMax + 1) 昇るとき→(-1) --EN:--nStart: When going down→(nMax + 1) When going up→(-1)
	proxy:BeginAction(LOCAL_PLAYER,1,-1,4);
	
	--キャラクタを移動、旋回可能に-- --EN:--Character can be moved and turned--
	proxy:DisableMove(LOCAL_PLAYER,0);
	
	print("OnEvent_1_1 end");
end


--------------------------------------------------------------------------------------
--ハシゴB降り■10 --EN:--Ladder B down 10
--------------------------------------------------------------------------------------
--■10■ハシゴB降りスタート■ --EN:-- ■ 10 ■ Ladder B descent start ■
function OnEvent_10(proxy, param)
	print("OnEvent_10 begin");
	
	if param:IsNetMessage() == true then
		print("IsNetMessage true");
		print("OnEvent_10 end");
		return;
	end

	--はしご降りに必要な前処理-- --EN:--Pretreatment required for descending the ladder--
	proxy:BeginAction(LOCAL_PLAYER,2,2,2);				--ホバー移動モードに移行 --EN:--Transition to hover movement mode
	--proxy:HoverMoveVal(LOCAL_PLAYER,2006,LadderTime_A);--移動位置(2006)に0.5秒でホバー移動 --EN:--Hover in 0.5 seconds to move position (2006)
	proxy:HoverMoveValDmy(LOCAL_PLAYER,1061,192,LadderTime_A);--移動位置(2003)に0.5秒でホバー移動 --EN:--Hover in 0.5 seconds to move position (2003)
	--proxy:HoverMoveVal(LOCAL_PLAYER,1060,192,LadderTime_A);--移動位置(2003)に0.5秒でホバー移動 --EN:--Hover in 0.5 seconds to move position (2003)
	proxy:SetEventCommand(LOCAL_PLAYER,1);				--イベントコマンドID(1)"ハシゴ上から掴"むを送る --EN:-- Send event command ID (1) "Grab from the top of the ladder"
	proxy:SetKeepCommandIndex(LOCAL_PLAYER, 0, 1, 3.0 );--垂直：0、　斜め：4 --EN:--Vertical: 0, Diagonal: 4
	proxy:DisableMove(LOCAL_PLAYER,1);					--キャラクタを移動、旋回不能に --EN:--Move the character, make it impossible to turn
	
	proxy:NotNetMessage_begin();
		--0.5秒(ホバー移動終了)後にはしご降りスタートイベントを発行 --EN:-- Issue a ladder descend start event after 0.5 seconds (end of hover movement)
		proxy:OnKeyTime2(10,"OnEvent_10_1",LadderTime_A,0,0,once);
		--はしご降り専用の関数を3秒間発行(カメラの周り込みなどの処理) --EN:--Issue a function dedicated to descending the ladder for 3 seconds (processing such as surrounding the camera)
		proxy:OnKeyTime2(10,"LadderDown",3,1,1,once);
	proxy:NotNetMessage_end();

	print("OnEvent_10 end");
end

--■10_1■ハシゴB降りスタート:ホバー移動終了■ --EN:--■ 10_1 ■ Start descending from ladder B: End of hover movement ■
function OnEvent_10_1(proxy, param)
	print("OnEvent_10_1 begin");
	
	if proxy:GetEventMode(LOCAL_PLAYER) == 0 then
		print("Local Player GetEventMode 0");
		print("OnEvent_10_1 end");
		return;
	end

	--ハシゴアクションモードに移行-- --EN:--Transition to ladder action mode--
	--nMax  : はしごの段数 - 補正値(補正値はおおよそ3) --EN:--nMax : number of ladder steps - correction value (correction value is approximately 3)
	--nStart: 降りるとき→(nMax + 1) 昇るとき→(-1) --EN:--nStart: When going down→(nMax + 1) When going up→(-1)
	proxy:BeginAction(LOCAL_PLAYER,1,11,10);
	
	--キャラクタを移動、旋回可能に-- --EN:--Character can be moved and turned--
	proxy:DisableMove(LOCAL_PLAYER,0);
	
	print("OnEvent_10_1 end");
end


--------------------------------------------------------------------------------------
--ハシゴB昇り■11 --EN:--Ladder B up 11
--------------------------------------------------------------------------------------
--■11■ハシゴB昇りスタート■ --EN:-- ■ 11 ■ Ladder B climbing start ■
function OnEvent_11(proxy, param)
	print("OnEvent_11 begin");
	
	if param:IsNetMessage() == true then
		print("IsNetMessage true");
		print("OnEvent_11 end");
		return;
	end
	
	--はしご昇りに必要な前処理-- --EN:--Pretreatment required for climbing a ladder--
	proxy:BeginAction(LOCAL_PLAYER,2,-1,1);			--ホバー移動モードに移行 --EN:--Transition to hover movement mode
	--proxy:HoverMoveVal(LOCAL_PLAYER,2007,LadderTime_A);--移動位置(2007)に0.5秒でホバー移動 --EN:--Hover in 0.5 seconds to move position (2007)
	proxy:HoverMoveValDmy(LOCAL_PLAYER,1061,191,LadderTime_A);--移動位置(2003)に0.5秒でホバー移動 --EN:--Hover in 0.5 seconds to move position (2003)
	proxy:SetEventCommand(LOCAL_PLAYER,0);				--イベントコマンドID(0)"ハシゴ下から掴"むを送る --EN:-- Send event command ID (0) "grab from under the ladder"
	proxy:SetKeepCommandIndex(LOCAL_PLAYER, 0, 1, 3.0 );
	proxy:DisableMove(LOCAL_PLAYER,1);					--キャラクタを移動、旋回不能に --EN:--Move the character, make it impossible to turn
	
	proxy:NotNetMessage_begin();
		--0.5秒(ホバー移動終了)後にはしご昇りスタートイベントを発行 --EN:-- Issue a ladder climb start event after 0.5 seconds (end of hover movement)
		proxy:OnKeyTime2(11,"OnEvent_11_1",LadderTime_A,0,0,once);
		--はしご昇り用の関数を1秒間発行(イベントメニューの中断処理?) --EN:--Issuing a function for climbing a ladder for 1 second (interruption processing of the event menu?)
		proxy:OnKeyTime2(11,"EventMenuBrake",1,1,1,once);
	proxy:NotNetMessage_end();
	
	print("OnEvent_11 end");
end

--■11_1■ハシゴA昇りスタート:ホバー移動終了■ --EN:--■ 11_1 ■ Start climbing ladder A: End hover movement ■
function OnEvent_11_1(proxy, param)
	print("OnEvent_11_1 begin");
	
	if proxy:GetEventMode(LOCAL_PLAYER) == 0 then
		print("Local Player GetEventMode 0");
		print("OnEvent_11_1 end");
		return;
	end

	--ハシゴアクションモードに移行-- --EN:--Transition to ladder action mode--
	--nMax  : はしごの段数 - 補正値(補正値はおおよそ3) --EN:--nMax : number of ladder steps - correction value (correction value is approximately 3)
	--nStart: 降りるとき→(nMax + 1) 昇るとき→(-1) --EN:--nStart: When going down→(nMax + 1) When going up→(-1)
	proxy:BeginAction(LOCAL_PLAYER,1,-1,10);
	
	--キャラクタを移動、旋回可能に-- --EN:--Character can be moved and turned--
	proxy:DisableMove(LOCAL_PLAYER,0);
	
	print("OnEvent_11_1 end");
end


--------------------------------------------------------------------------------------
--ハシゴC降り■20 --EN:--Ladder C down 20
--------------------------------------------------------------------------------------
--■20■ハシゴC降りスタート■ --EN:-- ■ 20 ■ Ladder C down start ■
function OnEvent_20(proxy, param)
	print("OnEvent_20 begin");
	
	if param:IsNetMessage() == true then
		print("IsNetMessage true");
		print("OnEvent_20 end");
		return;
	end

	--はしご降りに必要な前処理-- --EN:--Pretreatment required for descending the ladder--
	proxy:BeginAction(LOCAL_PLAYER,2,2,2);				--ホバー移動モードに移行 --EN:--Transition to hover movement mode
	--proxy:HoverMoveVal(LOCAL_PLAYER,2032,LadderTime_A);--移動位置(2032)に0.5秒でホバー移動 --EN:--Hover to move position (2032) in 0.5 seconds
	proxy:HoverMoveValDmy(LOCAL_PLAYER,1062,192,LadderTime_A);--移動位置(2003)に0.5秒でホバー移動 --EN:--Hover in 0.5 seconds to move position (2003)
	proxy:SetEventCommand(LOCAL_PLAYER,1);				--イベントコマンドID(1)"ハシゴ上から掴"むを送る --EN:-- Send event command ID (1) "Grab from the top of the ladder"
	proxy:SetKeepCommandIndex(LOCAL_PLAYER, 0, 1, 3.0 );
	proxy:DisableMove(LOCAL_PLAYER,1);					--キャラクタを移動、旋回不能に --EN:--Move the character, make it impossible to turn
	
	proxy:NotNetMessage_begin();
		--0.5秒(ホバー移動終了)後にはしご降りスタートイベントを発行 --EN:-- Issue a ladder descend start event after 0.5 seconds (end of hover movement)
		proxy:OnKeyTime2(20,"OnEvent_20_1",LadderTime_A,0,0,once);
		--はしご降り専用の関数を3秒間発行(カメラの周り込みなどの処理) --EN:--Issue a function dedicated to descending the ladder for 3 seconds (processing such as surrounding the camera)
		proxy:OnKeyTime2(20,"LadderDown",3,1,1,once);
	proxy:NotNetMessage_end();

	print("OnEvent_20 end");
end

--■20_1■ハシゴB降りスタート:ホバー移動終了■ --EN:--■20_1■Start descending from ladder B: End of hover movement■
function OnEvent_20_1(proxy, param)
	print("OnEvent_20_1 begin");
	
	if proxy:GetEventMode(LOCAL_PLAYER) == 0 then
		print("Local Player GetEventMode 0");
		print("OnEvent_20_1 end");
		return;
	end

	--ハシゴアクションモードに移行-- --EN:--Transition to ladder action mode--
	--nMax  : はしごの段数 - 補正値(補正値はおおよそ3) --EN:--nMax : number of ladder steps - correction value (correction value is approximately 3)
	--nStart: 降りるとき→(nMax + 1) 昇るとき→(-1) --EN:--nStart: When going down→(nMax + 1) When going up→(-1)
	proxy:BeginAction(LOCAL_PLAYER,1,11,10);
	
	--キャラクタを移動、旋回可能に-- --EN:--Character can be moved and turned--
	proxy:DisableMove(LOCAL_PLAYER,0);
	
	print("OnEvent_20_1 end");
end


--------------------------------------------------------------------------------------
--ハシゴC昇り■21 --EN:--Ladder C up 21
--------------------------------------------------------------------------------------
--■21■ハシゴC昇りスタート■ --EN:-- ■ 21 ■ Ladder C climbing start ■
function OnEvent_21(proxy, param)
	print("OnEvent_21 begin");
	
	if param:IsNetMessage() == true then
		print("IsNetMessage true");
		print("OnEvent_21 end");
		return;
	end
	
	--はしご昇りに必要な前処理-- --EN:--Pretreatment required for climbing a ladder--
	proxy:BeginAction(LOCAL_PLAYER,2,-1,1);			--ホバー移動モードに移行 --EN:--Transition to hover movement mode
	--proxy:HoverMoveVal(LOCAL_PLAYER,2033,LadderTime_A);--移動位置(2033)に0.5秒でホバー移動 --EN:--Hover to move position (2033) in 0.5 seconds
	proxy:HoverMoveValDmy(LOCAL_PLAYER,1062,191,LadderTime_A);--移動位置(2003)に0.5秒でホバー移動 --EN:--Hover in 0.5 seconds to move position (2003)
	proxy:SetEventCommand(LOCAL_PLAYER,0);				--イベントコマンドID(0)"ハシゴ下から掴"むを送る --EN:-- Send event command ID (0) "grab from under the ladder"
	proxy:SetKeepCommandIndex(LOCAL_PLAYER, 0, 1, 3.0 );
	proxy:DisableMove(LOCAL_PLAYER,1);					--キャラクタを移動、旋回不能に --EN:--Move the character, make it impossible to turn
	
	proxy:NotNetMessage_begin();
		--0.5秒(ホバー移動終了)後にはしご昇りスタートイベントを発行 --EN:-- Issue a ladder climb start event after 0.5 seconds (end of hover movement)
		proxy:OnKeyTime2(21,"OnEvent_21_1",LadderTime_A,0,0,once);
		--はしご昇り用の関数を1秒間発行(イベントメニューの中断処理?) --EN:--Issuing a function for climbing a ladder for 1 second (interruption processing of the event menu?)
		proxy:OnKeyTime2(21,"EventMenuBrake",1,1,1,once);
	proxy:NotNetMessage_end();
	
	print("OnEvent_21 end");
end

--■21_1■ハシゴC昇りスタート:ホバー移動終了■ --EN:--■ 21_1 ■ Ladder C climb start: Hover movement finished ■
function OnEvent_21_1(proxy, param)
	print("OnEvent_21_1 begin");
	
	if proxy:GetEventMode(LOCAL_PLAYER) == 0 then
		print("Local Player GetEventMode 0");
		print("OnEvent_21_1 end");
		return;
	end

	--ハシゴアクションモードに移行-- --EN:--Transition to ladder action mode--
	--nMax  : はしごの段数 - 補正値(補正値はおおよそ3) --EN:--nMax : number of ladder steps - correction value (correction value is approximately 3)
	--nStart: 降りるとき→(nMax + 1) 昇るとき→(-1) --EN:--nStart: When going down→(nMax + 1) When going up→(-1)
	proxy:BeginAction(LOCAL_PLAYER,1,-1,10);
	
	--キャラクタを移動、旋回可能に-- --EN:--Character can be moved and turned--
	proxy:DisableMove(LOCAL_PLAYER,0);
	
	print("OnEvent_21_1 end");
end


--------------------------------------------------------------------------------------
--イスタレル■23 --EN:--Istarel 23
--------------------------------------------------------------------------------------
function OnEvent_23(proxy,param)
	if param:IsNetMessage() == false then	
	print("OnEvent_23 begin");
	proxy:NotNetMessage_begin();
	proxy:RepeatMessage_begin();
		--アニメ --EN:--animation
		proxy:PlayAnimation( 10000 , 8290);
		proxy:PlayAnimation( 1002 , 1);	
		proxy:OnKeyTime2( 23 , "OnEvent_23_0",0.01,0,0,once);
	proxy:RepeatMessage_end();
	proxy:NotNetMessage_end();
	
	print("OnEvent_23 end");
	end
end

function OnEvent_23_0(proxy,param)
	print("OnEvent_23_0 begin");
	--if proxy:IsPlayerStay(10000) == true then
	if proxy:IsEventAnim( 10000 , 8290 ) == true then		
		proxy:LuaCallStart( 23, 2);			
	else
		proxy:ForcePlayAnimation( 1002 , 0);	
	end
	print("OnEvent_23_0 end");
end

--■23_1■アイテム取得■ --EN:-- ■ 23_1 ■ item acquisition ■
function OnEvent_23_1(proxy,param)
	print("OnEvent_23_1 begin");
	--アイテム取得関数--パラメータ10419参照 --EN:--item retrieval function--see parameter 10419
	proxy:GetRateItem(10419);	
	
	--アイテムを取得済み --EN:--item already acquired
	proxy:SetEventFlag( 23, true );
	
	--OBJを消すためのイベント配信 --EN:--Event distribution for erasing OBJ
	proxy:LuaCallStart( 23, 1);

	print("OnEvent_23_1 end");
end

--■23_2■剣OBJ非表示用■ --EN:--■23_2■For hiding the sword OBJ■
function OnEvent_23_2(proxy,param)
	print("OnEvent_23_2 begin");
	--オブジェが消える --EN:--The object disappears
	proxy:SetDrawEnable( 1002 , false );--ひとまず描画だけOFF --EN:--Only drawing is turned off for the time being
	proxy:SetColiEnable( 1002 , false );--当たりはあるのは不明(現状ではないようなので消さない) --EN:--I don't know if there is a hit (I don't delete it because it doesn't seem to be the current situation)
	
	proxy:DeleteEvent( 23 );
	print("OnEvent_23_2 end");
end

--アニメの同期監視 --EN:--Synchronous monitoring of anime
function OnEvent_23_3(proxy,param)
	print("OnEvent_23_3 begin");
	proxy:TreasureDispModeChange2( 1002, false ,KEN_SFX);
	--プレイヤーの同期アニメーション(true:パーティープレイヤーがアニメーションした) --EN:--Player synchronous animation (true: party player animated)
	if Luafunc_PlaySynchroAnimation( proxy, param, 8290 ) == true then--新しいアニメ  --EN:-- new anime
		proxy:PlayAnimation( 1002 , 1);	
		print("OnEvent_23_3 end");
		return true;
	end		
	
	--剣にワープ --EN:--Warp to sword
	proxy:WarpDmy( LOCAL_PLAYER , 1002 , 191 );
	proxy:NotNetMessage_begin();
		proxy:OnChrAnimEnd( 23 , LOCAL_PLAYER , 8290 , "OnEvent_23_1", once);
	proxy:NotNetMessage_end();	
	print("OnEvent_23_3 end");	
end

--------------------------------------------------------------------------------------
--跳ね橋A■30 --EN:-- Drawbridge A 30
--------------------------------------------------------------------------------------
--■30■跳ね橋■ --EN:-- ■ 30 ■ Drawbridge ■
function OnEvent_30(proxy, param)
	print("OnEvent_30 begin");
	
	if proxy:IsCompleteEvent(30) == true then
		print("ID 30 IsCompleteEvent true"); 
		print("OnEvent_30 end");
		return;
	end

	proxy:PlayAnimation(1000,1);--跳ね橋の作動アニメーション --EN:-- Drawbridge activation animation
	proxy:SetEventFlag( 30, 1 );--跳ね橋は作動済み --EN:-- drawbridge activated
	
	--プレイヤーの同期アニメーション(true:パーティープレイヤーがアニメーションした) --EN:--Player synchronous animation (true: party player animated)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_KICK ) == true then
		print("OnEvent_30_1 end");
		return;
	end
	
	proxy:WarpDmy( LOCAL_PLAYER , 1000 , 191 );
	
	print("OnEvent_30 end");
end


--------------------------------------------------------------------------------------
--跳ね橋B■40 --EN:-- Drawbridge B 40
--------------------------------------------------------------------------------------
--■40■跳ね橋■ --EN:-- ■ 40 ■ Drawbridge ■
function OnEvent_40(proxy, param)
	print("OnEvent_40 begin");
		
	if proxy:IsCompleteEvent(40) == true then
		print("ID 40 IsCompleteEvent true"); 
		print("OnEvent_40 end");
		return;
	end

	proxy:PlayAnimation(1001,1);--跳ね橋の作動アニメーション --EN:-- Drawbridge activation animation
	proxy:SetEventFlag( 40, 1 );--跳ね橋は作動済み --EN:-- drawbridge activated
	
	--プレイヤーの同期アニメーション(true:パーティープレイヤーがアニメーションした) --EN:--Player synchronous animation (true: party player animated)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_KICK ) == true then
		print("OnEvent_40 end");
		return;
	end
	
	proxy:WarpDmy( LOCAL_PLAYER , 1001 , 191 );
	
	print("OnEvent_40 end");
end


--------------------------------------------------------------------------------------
--床抜けA■50 --EN:--Floor gap A 50
--------------------------------------------------------------------------------------
--■50■床抜けA:登録■ --EN:-- ■ 50 ■ Floor gap A: Registration ■
function OnEvent_50(proxy, param)
	print("OnEvent_50 begin");
	
	if proxy:IsDestroyed(1020) == true then
		print("ID 1020 IsDestroyed true");
		print("OnEvent_50 end");
		return;
	end
	
	proxy:NotNetMessage_begin();
		--効果音再生 --EN:--Play sound effect
		proxy:PlayObjectSE(1020,500000);
		--0.5秒後に床抜け発動イベントを発行 --EN:--Issue a floor drop trigger event after 0.5 seconds
		proxy:OnKeyTime2(50,"OnEvent_50_1", 0.5,0,0,once);
	proxy:NotNetMessage_end();
	
	print("OnEvent_50 end");
end

--■50_1■床抜けA:発動■ --EN:-- ■ 50_1 ■ Floor gap A: Activate ■
function OnEvent_50_1(proxy, param)
	print("OnEvent_50_1 begin");
	
	proxy:ChangeModel(1020, 1);		--モデル差し替え --EN:--Model replacement
	proxy:SetBrokenPiece(1020);
	
	proxy:PlayObjectSE(1020,500100);--効果音再生 --EN:--Play sound effect
	proxy:SetEventFlag( 50, 1 );	--床抜け発動済み --EN:--Floor exit activated
	
	print("OnEvent_50_1 end");
end

--------------------------------------------------------------------------------------
--床抜けB■60 --EN:--Floor gap B 60
--------------------------------------------------------------------------------------
--■60■床抜けB:登録■ --EN:-- ■ 60 ■ Floor gap B: Registration ■
function OnEvent_60(proxy, param)
	print("OnEvent_60 begin");
	
	if proxy:IsDestroyed(1021) == true then
		print("ID 1021 IsDestroyed true");
		print("OnEvent_60 end");
		return;
	end
	
	proxy:NotNetMessage_begin();
		--効果音再生 --EN:--Play sound effect
		proxy:PlayObjectSE(1021,500000);
		--0.5秒後に床抜け発動イベントを発行 --EN:--Issue a floor drop trigger event after 0.5 seconds
		proxy:OnKeyTime2(60,"OnEvent_60_1", 0.5,0,0,once);
	proxy:NotNetMessage_end();
	
	print("OnEvent_60 end");
end

--■60_1■床抜けB:発動■ --EN:-- ■ 60_1 ■ Floor gap B: Activate ■
function OnEvent_60_1(proxy, param)
	print("OnEvent_60_1 begin");
	
	proxy:ChangeModel(1021, 1);		--モデル差し替え --EN:--Model replacement
	proxy:SetBrokenPiece(1021);
	
	proxy:PlayObjectSE(1021,500100);--効果音再生 --EN:--Play sound effect
	proxy:SetEventFlag( 60, 1 );	--床抜け発動済み --EN:--Floor exit activated
	
	print("OnEvent_60_1 end");
end


--------------------------------------------------------------------------------------
--ボス部屋の中に入る■160 --EN:--Enter the boss room 160
--------------------------------------------------------------------------------------

--■イベントがループなので、全部リピートにする↓ --EN:--■ Since the event is a loop, repeat all ↓

--■160■中ボス部屋への扉が開く■ --EN:-- ■ 160 ■ The door to the mid-boss room opens ■
function OnEvent_160(proxy,param)
	print("OnEvent_160 begin");

	if proxy:IsCompleteEvent( SYSTEM_ID_IGNORE ) == true then
		print("OnEvent_160 end");
		return;
	end
	
	--クライアントへ、ボス部屋阻止失敗を通知 --EN:--Notify client of failure to block boss room
	if proxy:IsClient() == false then
		proxy:LuaCallStart( 4068 , 1 );	
	end
	
	proxy:LuaCallStart( 161 , 1 );--旋回アニメの同期再生 --EN:-- Synchronous playback of turning animation
	--proxy:SetEventFlag( SYSTEM_ID_IGNORE , true );--多重発動防止用フラグON --EN:--Multiple activation prevention flag ON
	--多重起動システムIDをタイムアウトを設定してONにする --EN:--Turn on multiple activation system ID by setting timeout
	proxy:SetSystemIgnore( SYSTEM_ID_IGNORE , IGNORE_TIME );
	
	--プロファイルセーブ要求 --EN:--profile save request
	proxy:SaveRequest_Profile();
	
	print("OnEvent_160 end");
end


--旋回アニメの同期再生(IDが別) --EN:-- Synchronized playback of turning animation (ID is different)
function OnEvent_161_1(proxy,param)
	print("OnEvent_161_1 begin");

	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		if param:IsNetMessage() == true then
			--旋回アニメ再生を行い、その終了時にOnEvent_161_2を発行する --EN:--Play the turning animation and issue OnEvent_161_2 at the end
			proxy:TurnCharactor( 10001 + param:GetPlayID(), 2891 );
		else
			proxy:LockSession();--ルームをロックします！ --EN:--lock the room!
			--旋回アニメ再生を行い、その終了時にOnEvent_161_2を発行する --EN:--Play the turning animation and issue OnEvent_161_2 at the end
			proxy:OnTurnCharactorEnd( 161, LOCAL_PLAYER, 2891, "OnEvent_161_2", once );
		end
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	
	print("OnEvent_161_1 end");
end

--旋回アニメの同期再生終了後 --EN:--After synchronous playback of turning animation ends
function OnEvent_161_2(proxy,param)
	print("OnEvent_161_2 begin");
	
	--同期用歩きアニメ再生 --EN:--Play walking animation for synchronization
	proxy:LuaCallStart( 4012, 1 );
	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		proxy:OnChrAnimEnd( 161, LOCAL_PLAYER, ANIMEID_WALK, "OnEvent_161_3", once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();

	print("OnEvent_161_2 end");
end

--歩きアニメの同期再生終了後 --EN:--After the synchronized playback of the walking animation ends
function OnEvent_161_3(proxy,param)
	print("OnEvent_161_3 begin");

	--最初の人がボス部屋の中に入り終わっていたら、既に配信されているはずなので、もうおくらないハンドラ --EN:--If the first person has already entered the boss room, it should have already been delivered, so no more handlers
	if proxy:IsCompleteEvent( 160 ) == false then
		proxy:LuaCallStart( 161 , 5 );--2回目以降にボス部屋に入るためのイベント配信用 --EN:--For event delivery to enter the boss room after the second time
		proxy:LuaCallStart( 4045 , 1 );	--クライアントへ、ボス部屋に入れるようになったことを通知 --EN:--Notify clients that they can now enter the boss room
		proxy:LuaCallStart( 161 , 6 );--フラグセット(同期用) --EN:--flag set (for synchronization)
		Lua_MultiDoping(proxy,808);--マルチプレイドーピング --EN:-- Multiplayer Doping
	end

	--プレイヤーが扉の中に完全にはいったタイミングで、ボスの思考をリセット --EN:--Reset the boss' thoughts when the player is completely inside the door
	--場所が悪いとプレイヤーを見つけれないため(攻撃してこない) --EN:--Because you can't find the player if the location is bad (they won't attack)
	if proxy:IsLivePlayer() == true or proxy:IsGreyGhost() == true then
		proxy:ResetThink( 808 );
	end	
	
	proxy:SetEventFlag( SYSTEM_ID_IGNORE, false );

	print("OnEvent_161_3 end");
end


--■160 2回目以降にボス部屋に入るためのイベント配信用 --EN:--■ 160 For event delivery to enter the boss room after the second time
function OnEvent_160_GO_TO_IN(proxy, param)
	print("OnEvent_160_GO_TO_IN begin");
		
	proxy:NotNetMessage_begin();
		--▼161▼扉が開いているときに中に入るためのイベントを追加▼--ハンドラは OnEvent_160 --EN:--▼161▼Add an event to enter when the door is open▼--The handler is OnEvent_160
		proxy:OnPlayerActionInRegion( 161, 2895, "OnEvent_160", HELPID_GO_TO_IN, everytime );--
	proxy:NotNetMessage_end();	
	
	print("OnEvent_160_GO_TO_IN end");
end


--■160 フラグセット(同期用) --EN:-- 160 flag set (for synchronization)
function OnEvent_160_flag_set(proxy, param)
	print("OnEvent_160_flag_set begin");
		
	proxy:SetEventFlag( 160 , 1 );
	proxy:DeleteEvent( 160 );

	print("OnEvent_160_flag_set end");
end


--------------------------------------------------------------------------------------
--中ボスポリ劇再生■162 --EN:--Middle Bospoli Drama Play ■ 162
--------------------------------------------------------------------------------------
--■162■中ボス主張演出■ --EN:-- ■ 162 ■ Mid-boss insistence production ■
function OnEvent_162(proxy, param)
	print("OnEvent_162 begin");
	--中ボス登場ポリ劇 --EN:--Poly drama with mid-boss appearance
	proxy:RequestRemo(50000,REMO_FLAG,162,1);
	proxy:SetEventFlag( 162 , 1 );	
	print("OnEvent_162 end");
end

function OnEvent_162_RemoStart(proxy,param)
	print("OnEvent_162_RemoStart begin");
	--特に無し --EN:--nothing especially
	print("OnEvent_162_RemoStart end");
end

function OnEvent_162_RemoFinish(proxy,param)
	print("OnEvent_162_RemoFinish begin");
	--特に無し --EN:--nothing especially
	print("OnEvent_162_RemoFinish end");
end


--------------------------------------------------------------------------------------
--ボスが動き出す(戦闘開始)■163 --EN:--Boss begins to move (battle starts) 163
--------------------------------------------------------------------------------------

function OnEvent_163(proxy, param)
	print("OnEvent_163 begin");
	
	--ボス戦用BGM再生開始 --EN:--Start playing BGM for boss battle
	proxy:PlayPointSE( 2120, SOUND_TYPE_M, 50000000, 0 );--領域のIDのみ未定 --EN:-- Only the area ID is undecided
	
	proxy:SetDrawEnable( 808, true );
	
	--ボスロジックON --EN:--Boss logic ON
	proxy:EnableLogic( 808 , true );
	
	proxy:SetEventFlag( 163, true );
	
	--読み込みタイミングのとき毎回追加されてほしいのでフラグたてない --EN:-- I want it to be added every time at the time of reading, so I don't set a flag
	
	--ボスゲージ表示 --EN:-- Boss gauge display
	proxy:SetBossGauge(808 , 0, 5090);
	
	print("OnEvent_163 end");
end


--------------------------------------------------------------------------------------
--■5650■ボス死亡■ --EN:-- ■ 5650 ■ Boss death ■
--------------------------------------------------------------------------------------
--■5650■ボス死亡■ --EN:-- ■ 5650 ■ Boss death ■
function OnEvent_5650(proxy,param)
	print("OnEvent_5650 begin");
	
	proxy:NotNetMessage_begin();
		--1秒後にアイテム取得イベントを発行-- --EN:--Issue an item acquisition event after 1 second--
		proxy:OnKeyTime2(5650,"OnEvent_5650_1", 1.0,0,0,once);
		--2秒後に崩れる壁発動イベントを発行-- --EN:-- Issue a wall trigger event that collapses after 2 seconds --
		proxy:OnKeyTime2(5652,"OnEvent_5652", 2.0,0,0,once);
		
		--マルチ解散監視 --EN:--Multi-Dismissal Monitoring
		proxy:OnRegistFunc( 5650,"Check_5650_PT","OnEvent_5650_PT",0,once);
	proxy:NotNetMessage_end();

	proxy:SetEventFlag( 5650, true );--フラグを立てる。 --EN:--Flag.
	
	--蛭沼のダメージ床監視削除 --EN:--Damage floor monitoring in Hirumuma removed
	proxy:DeleteEvent(5730);
	
	--既に蛭沼に入っている人はここで解除 --EN:--If you are already in Hirumuma, cancel here
	proxy:EraseEventSpecialEffect(LOCAL_PLAYER, 10060);
	
	--ブロッククリア処理へ --EN:-- to block clear processing
	proxy:CustomLuaCallStart( 4050, 808 );
	--トカゲリセット --EN:-- lizard reset
	ResetTokage(proxy);
	
	print("OnEvent_5650 end");
end

--▲5650_1▲1秒後▲ --EN:--▲5650_1▲After 1 second▲
function OnEvent_5650_1(proxy, param)
	print("OnEvent_5650_1 begin");
	
	--ボスを倒した数を更新(数によってフラグを立てる) --EN:--update number of bosses killed (flag by number)
	GetBossFlagCount( proxy, param );
		
	--▼トロフィー取得判定▼ --EN:--▼Trophy Acquisition Judgment▼
	Lua_RequestUnlockTrophy(proxy, 34);
		
	--乞食(女)の初期化用 --EN:--For beggar (female) initialization
	OnEvent_812(proxy, param);

	--ホストプレイヤーのみアイテム入手イベントに使用 --EN:--Used for item acquisition event only for host players
	local possible_chr_type = ATTR_HOST + ATTR_LIVE + ATTR_GREY;
	
	--宝死体(ソウル?)有効化 --EN:--Treasure corpse (soul?) activation
	proxy:SetDrawEnable( 1982 , true );
	proxy:SetColiEnable( 1982 , true );
	--ソウルに刺さった剣有効化 --EN:--Activation of the sword stuck in the soul
	proxy:SetDrawEnable( 1975 , true );
	proxy:SetColiEnable( 1975 , true );
		
	--▼(ソウル)アイテム取得用イベント監視追加▼ --EN:--▼ (Soul) Added event monitoring for item acquisition▼
	if proxy:IsCompleteEvent( 5653 ) == false then
		--SFX 有効化 --EN:--SFX enable
		proxy:ValidSfx( 2150 );--要石のオーラ --EN:--Keystone Aura
		proxy:ValidSfx( 2151 );--光の粒子 --EN:--Particles of light
		proxy:TreasureDispModeChange2( 1982, true ,KANAME_SFX);--光らせる --EN:-- let it shine
		--proxy:TreasureDispModeChange2( 1975, true ,KANAME_SFX);--光らせる --EN:-- let it shine
		proxy:OnDistanceActionAttribute( 5653 , LOCAL_PLAYER , 1982 , "OnEvent_5653" , WarpGimmickDist_A , 10010180 , 0 , 180 , possible_chr_type, once );
	end		
		
	print("OnEvent_5650_1 end");
end

--▲5652▲2秒後▲ --EN:--▲5652▲After 2 seconds▲
function OnEvent_5652(proxy, param)
	print("OnEvent_5652 begin");
	
	--ボス戦用のBGM停止 --EN:--BGM stop for boss battles
	proxy:StopPointSE( 0 );

	proxy:SetEventFlag( 5652, true );

	print("OnEvent_5652 end");
end

--マルチ解散監視 --EN:--Multi-Dismissal Monitoring
function Check_5650_PT(proxy)
	if proxy:IsInParty() == false then
		return true;
	end
	return false;	
end

function OnEvent_5650_PT(proxy,param)
	print("OnEvent_5650_PT begin");
	--中ボス部屋の前後の魔法壁が消える(全プレイヤー) --EN:--The magic walls before and after the mid-boss room disappear (all players)
	proxy:SetColiEnable( 1999 , false );
	proxy:SetColiEnable( 1995 , false );
	
	proxy:SetDrawEnable( 1999 , false );
	proxy:SetDrawEnable( 1995 , false );	

	--光の壁Sfxを消す --EN:--Turn off the wall of light Sfx
	proxy:InvalidSfx( 1987, true );
	proxy:InvalidSfx( 1991, true );

	
	--中ボス部屋前の移動処理イベントを削除 --EN:--Delete the movement processing event in front of the mid-boss room
	proxy:DeleteEvent( 160 );--一人目が入るとき用 --EN:--For when the first person enters
	proxy:DeleteEvent( 161 );--二人目以降が入るとき用 --EN:--For when the second and subsequent people enter
	print("OnEvent_5650_PT end");
end
--------------------------------------------------------------------------------------
--■5653■ソウル入手■ --EN:-- ■ 5653 ■ Get Soul ■
--------------------------------------------------------------------------------------
function OnEvent_5653(proxy, param)
	print("OnEvent_5653 begin");
	
	--プレイヤーの同期アニメーション(true:パーティープレイヤーがアニメーションした) --EN:--Player synchronous animation (true: party player animated)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_PICK ) == true then--新しいアニメ  --EN:-- new anime
		print("OnEvent_5653 end");
		return true;
	end
	
	proxy:NotNetMessage_begin();
		--0.0秒後にアイテム取得イベントを発行 --EN:-- Issue an item acquisition event after 0.0 seconds
		proxy:OnKeyTime2( 5653, "OnEvent_5653_1", 0.0, 0, 0, once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_5653 end");
end


--■5653_1■アイテム取得■ --EN:-- ■ 5653_1 ■ item acquisition ■
function OnEvent_5653_1(proxy, param)
	print("OnEvent_5653_1 begin");

	--アイテム取得関数--パラメータ10232参照 --EN:--item retrieval function--see parameter 10232
	proxy:GetRateItem(10450);
	proxy:GetRateItem(10470);
	proxy:GetRateItem(10471);
	proxy:GetRateItem(10472);
	proxy:GetRateItem(10473);
	
	--アイテムを取得済み --EN:--item already acquired
	proxy:SetEventFlag( 5653, 1 );

	--宝箱シェーダーOFF --EN:--Treasure chest shader OFF
	--proxy:TreasureDispModeChange( 1982 , false );

	--SFXが消える --EN:--SFX disappear
	proxy:InvalidSfx( 2150 , true );--要石のオーラ --EN:--Keystone Aura
	--proxy:InvalidSfx( 2151 , true );--光の粒子 --EN:--Particles of light
		
	--▼要石でワープ用の監視を追加▼ --EN:--▼ Added surveillance for warp with keystone ▼
	proxy:OnDistanceActionAttribute( 5654 , LOCAL_PLAYER , 1982 , "OnEvent_5654" , WarpGimmickDist_A , HELPID_GO_TO_SEKITYUU , 0 , 180 , ATTR_NOSESSION , everytime );

	print("OnEvent_5653_1 end");
end

--------------------------------------------------------------------------------------
--揺れるつり橋A■70 --EN:--Swaying suspension bridge A 70
--------------------------------------------------------------------------------------
--■70■つり橋A揺れ発動■ --EN:-- ■ 70 ■ Suspension bridge A swaying ■
function OnEvent_70(proxy,param)	
	if proxy:IsPlayerStay(LOCAL_PLAYER) == false then		
--		print("Player Is Move");		
		--つり橋が揺れるアニメーション再生 --EN:--Animation playback of swinging suspension bridge
		proxy:PlayAnimation(1034,1);				
	end
end


--------------------------------------------------------------------------------------
--揺れるつり橋B■80 --EN:--Swaying Suspension Bridge B 80
--------------------------------------------------------------------------------------
--■80■つり橋B揺れ発動■ --EN:-- ■ 80 ■ Suspension bridge B shaking triggered ■
function OnEvent_80(proxy,param)	
	if proxy:IsPlayerStay(LOCAL_PLAYER) == false then			
--		print("Player Is Move");		
		--つり橋が揺れるアニメーション再生 --EN:--Animation playback of swinging suspension bridge
		proxy:PlayAnimation(1035,1);		
	end	
end


--------------------------------------------------------------------------------------
--揺れるつり橋C■90 --EN:--Swaying suspension bridge C 90
--------------------------------------------------------------------------------------
--■90■つり橋C揺れ発動■ --EN:-- ■ 90 ■ Suspension bridge C shaking triggered ■
function OnEvent_90(proxy,param)	
	if proxy:IsPlayerStay(LOCAL_PLAYER) == false then	
--		print("Player Is Move");	
		--つり橋が揺れるアニメーション再生 --EN:--Animation playback of swinging suspension bridge
		proxy:PlayAnimation(1036,1);			
	end	
end


--------------------------------------------------------------------------------------
--揺れるつり橋D■100 --EN:--Swaying suspension bridge D 100
--------------------------------------------------------------------------------------
--■100■つり橋D揺れ発動■ --EN:-- ■ 100 ■ Suspension bridge D swinging ■
function OnEvent_100(proxy,param)	
	if proxy:IsPlayerStay(LOCAL_PLAYER) == false then		
--		print("Player Is Move");		
		--つり橋が揺れるアニメーション再生 --EN:--Animation playback of swinging suspension bridge
		proxy:PlayAnimation(1037,1);			
	end
end

--------------------------------------------------------------------------------------
--ふわふわ足場■130 --EN:-- Fluffy scaffold ■ 130
--------------------------------------------------------------------------------------

--■130■上の領域侵入■ --EN:-- ■ 130 ■ upper area invasion ■
function OnEvent_130_1(proxy,param)	
	print("OnEvent_130_1 begin");
	
	--下側の領域進入イベントを発行 --EN:-- Issue lower area entry event
	proxy:RepeatMessage_begin();
		proxy:OnRegionIn( 131,LOCAL_PLAYER,2041,"OnEvent_130_2", once );
	proxy:RepeatMessage_end();

	print("OnEvent_130_1 end");
end

--■130■下の領域侵入■ --EN:-- ■ 130 ■ lower area invasion ■
function OnEvent_130_2(proxy,param)	
	print("OnEvent_130_2 begin");
	
	--上側の領域進入イベントを発行 --EN:-- Issue upper area entry event
	proxy:RepeatMessage_begin();
		proxy:OnRegionIn( 130,LOCAL_PLAYER,2040,"OnEvent_130_1", once );
	proxy:RepeatMessage_end();
	
	proxy:PlayAnimation( 1040 , 1 );--ふわふわアニメ再生 --EN:--Play fluffy animation
	
	print("OnEvent_130_2 end");
end

--■131■ふわふわアニメ(領域内移動)■ --EN:-- ■ 131 ■ Fluffy animation (move within area) ■
function OnEvent_131(proxy,param)
	if proxy:IsPlayerStay(LOCAL_PLAYER) == false then	
		--ふわふわアニメ再生 --EN:--Play fluffy animation
		proxy:PlayAnimation(1040,1);			
	end	
end

--■132■ふわふわアニメ(領域内移動)■ --EN:-- ■ 132 ■ Fluffy animation (move within area) ■
function OnEvent_132(proxy,param)
	if proxy:IsPlayerStay(LOCAL_PLAYER) == false then	
		--ふわふわアニメ再生 --EN:--Play fluffy animation
		proxy:PlayAnimation(1050,1);			
	end	
end
--■133■ふわふわアニメ(領域内移動)■ --EN:-- ■ 133 ■ Fluffy animation (moving within area) ■
function OnEvent_133(proxy,param)
	if proxy:IsPlayerStay(LOCAL_PLAYER) == false then	
		--ふわふわアニメ再生 --EN:--Play fluffy animation
		proxy:PlayAnimation(1051,1);			
	end	
end

--------------------------------------------------------------------------------------
--からす飛び立つ■110 --EN:-- Crow takes off ■ 110
--------------------------------------------------------------------------------------
function Check_110(proxy)	
	--ココは毎フレーム監視されるのでprintを入れるのはお勧めしません。テストの時だけにしてください。 --EN:--This is monitored every frame, so it is not recommended to include print. Use it only for testing.
	if proxy:CheckChrHit_Obj(LOCAL_PLAYER,1039) == true then
		--条件が成立した瞬間なので、ココにはprintを入れておくことをお勧めします --EN:--This is the moment when the condition is met, so it is recommended to put a print here
		print("Check_110 true");
		return true
	end
	return false;
end

function OnEvent_110(proxy,param)
	print("OnEvent_110 begin");
	local animId = {10,10,10,11,11,11,12,12,12};
	local objId = {1041,1042,1043,1044,1045,1046,1047,1048,1049};
	for index = 1, 9, 1 do
		proxy:PlayAnimation( objId[index], animId[index] );
	end
	
	proxy:SetEventFlag( 110 , 1 );
	
	print("OnEvent_110 end");
end


--------------------------------------------------------------------------------------
--■280■石柱にワープ■ --EN:-- ■ 280 ■ Warp to the stone pillar ■
--------------------------------------------------------------------------------------

--■280■石柱にワープ■ --EN:-- ■ 280 ■ Warp to the stone pillar ■
function OnEvent_280(proxy,param)	

	if proxy:IsCompleteEvent( 280 ) == true then
		return;
	end
	
	if param:IsNetMessage() == true then
		return;
	end
	
	
	print("OnEvent_280 begin");
	
	--セッション中ならば、要石のワープ無効 --EN:--Disable keystone warp if in session
	if proxy:IsSession() == false then--セッション中ではない --EN:--not in session
		proxy:RepeatMessage_begin();
			--▼659_1▼選択メニューの監視▼ --EN:--▼659_1▼Select menu monitoring▼
			proxy:OnSelectMenu(280, "OnEvent_280_0", 10010710, 0, 2, 1983, 2, once);			
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

	print("OnEvent_280 end");
end

--▲280_0▲選択メニューの監視▲ --EN:--▲280_0▲Monitor selection menu▲
function OnEvent_280_0(proxy, param)
	print("OnEvent_280_0 begin");
	
	if proxy:IsSession() == false then
		
		proxy:PlayAnimation( LOCAL_PLAYER , 8283 );--要石に触れるアニメを再生 --EN:--Play the animation that touches the keystone
		proxy:NoAnimeTurnCharactor( 10000 , 1983 ,TURNSKIP_ANGLE);
		
		proxy:NotNetMessage_begin();
			--▼要石に触れるアニメ再生終了▼ --EN:--▼Animation touching the keystone ends▼
			proxy:OnChrAnimEnd( 280 , LOCAL_PLAYER , 8283 , "OnEvent_280_1" , once );
		proxy:NotNetMessage_end();
		
		proxy:SetEventFlag( 280 , 1 );
	else
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010720, 0, 6, 1983, GEN_DIALOG_DIST, once );
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
	end
	
	print("OnEvent_280_0 end");
end

--▲280_1▲選択メニューの監視▲ --EN:--▲280_1▲Monitor selection menu▲
function OnEvent_280_1(proxy, param)
	print("OnEvent_280_1 begin");
	
	proxy:SetEventFlag( 280 , 0 );
	
	proxy:PlayAnimation( LOCAL_PLAYER , 8284 );--自世界に帰るアニメを再生 --EN:--Play animation to return to your own world

	proxy:SetEventFlag( 280 , 1 );
	
	OnEvent_280_2(proxy,param);
	
	print("OnEvent_280_1 end");
end

--▲要石に触れるアニメ再生終了▲ --EN:--▲End of playing the animation touching the keystone▲
function OnEvent_280_2(proxy,param)	
	print("OnEvent_280_2 begin");
	
	--石柱へ戻ってきた判定のフラグを立てる --EN:--Flag the judgment of returning to the stone pillar
	proxy:SetEventFlag(8083, true);

	proxy:SetEventFlag( 280 , 0 );
	--完全回復要求 --EN:-- full recovery request
	proxy:RequestFullRecover();
	proxy:WarpNextStage( 1, 0, 0, 0, 1009 );
	
	print("OnEvent_280_2 end");
end


--------------------------------------------------------------------------------------
--■5654■石柱にワープ■ --EN:-- ■ 5654 ■ Warp to the stone pillar ■
--------------------------------------------------------------------------------------
function OnEvent_5654(proxy,param)	
	print("OnEvent_5654 begin");
	
	if proxy:IsCompleteEvent( 5654 ) == true then
		return;
	end
	
	proxy:RepeatMessage_begin();
		--▼_1▼選択メニューの監視▼ --EN:--▼_1▼Select menu monitoring▼
		proxy:OnSelectMenu(5654, "OnEvent_5654_1", 10010710, 0, 2, 1982, 2, once);			
	proxy:RepeatMessage_end();
	
	print("OnEvent_5654 end");
end

--▲5654_1▲選択メニューの監視▲ --EN:--▲5654_1▲Monitor selection menu▲
function OnEvent_5654_1(proxy,param)	
	print("OnEvent_5654_1 begin");

	if proxy:IsSession() == false then
		
		proxy:PlayAnimation(LOCAL_PLAYER,8283);
		proxy:NoAnimeTurnCharactor( 10000 , 1982 ,TURNSKIP_ANGLE);
		
		proxy:NotNetMessage_begin();
			--▲要石に触れるアニメ再生終了したら▲ --EN:--▲Once you finish playing the animation touching the keystone▲
			proxy:OnChrAnimEnd( 5654 , LOCAL_PLAYER , 8283 , "OnEvent_5654_2",once);
		proxy:NotNetMessage_end();
		
		proxy:SetEventFlag(5654,true);
	else
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010720, 0, 6, 1983, GEN_DIALOG_DIST, once );
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
	end
	
	print("OnEvent_5654_1 end");
end

--▲5654_2▲要石に触れるアニメ再生終了▲ --EN:--▲5654_2▲Ends playing the animation touching the keystone▲
function OnEvent_5654_2(proxy,param)	
	print("OnEvent_5654_2 begin");
	
	proxy:SetEventFlag(5654,false);
	
	proxy:PlayAnimation(LOCAL_PLAYER,8284);
	
	proxy:SetEventFlag(5654,true);
	--ワープ処理開始 --EN:--Start warp processing
	OnEvent_5654_3(proxy,param);
	
	print("OnEvent_5654_2 end");
end

--▲自世界に帰るアニメ再生終了▲ --EN:--▲Returning to your own world, end of animation ▲
function OnEvent_5654_3(proxy,param)	
	print("OnEvent_5654_3 begin");
	
	--石柱へ戻ってきた判定のフラグを立てる --EN:--Flag the judgment of returning to the stone pillar
	proxy:SetEventFlag(8083, true);

	proxy:SetEventFlag(5654,false);
	--完全回復要求 --EN:-- full recovery request
	proxy:RequestFullRecover();
	proxy:WarpNextStage( 1, 0, 0, 0, 1009 );
	
	print("OnEvent_5654_3 end");
end

--------------------------------------------------------------------------------------
--死んだフリ腐敗人■140 --EN:-- Pretending to be dead rot ■ 140
--------------------------------------------------------------------------------------
--■140■死んだフリ腐敗人■ --EN:--■ 140■ Pretending to be dead rot ■
function OnEvent_140(proxy,param)
	print("OnEvent_140 begin");
	
	if proxy:IsAlive( 500 ) == true then
	
		--起き上がりアニメ再生 --EN:--Get up animation playback
		--proxy:SetEventCommand( 500, 201 );
		proxy:PlayAnimation( 500 , 9920);		
		proxy:SetSpStayAndDamageAnimId( 500 ,-1,-1);
		--当たりを有効に設定 --EN:--set hits to valid
		proxy:SetColiEnable(500, true);	
		--ロジックを再開 --EN:--resume logic
		proxy:EnableLogic( 500, true );
		--索敵をOn（ロック可能にする） --EN:--Search enemies on (make it lockable)
		proxy:EnableHide( 500, false );
		
	end
	
	--フラグをセット --EN:-- set the flag
	proxy:SetEventFlag( 140, 1 );

	print("OnEvent_140 end");
end

--------------------------------------------------------------------------------------
--死んだフリ腐敗人■141 --EN:-- Pretending to be dead rot 141
--------------------------------------------------------------------------------------
--■141■死んだフリ腐敗人■ --EN:--■ 141 ■ Corrupt person pretending to be dead ■
function OnEvent_141(proxy,param)
	print("OnEvent_141 begin");
	
	if proxy:IsAlive( 501 ) == true then
		--距離による更新タイミングの問題で、EzStateに命令が届かない場合があるので1フレーム強制更新 --EN:--Due to the update timing problem due to the distance, the command may not reach EzState, so 1 frame forced update
		proxy:ForceUpdateNextFrame( 501 );
		--起き上がりアニメ再生 --EN:--Get up animation playback
		--proxy:SetEventCommand( 501, 201 );
		proxy:PlayAnimation( 501,9920 );
		proxy:SetSpStayAndDamageAnimId( 501 ,-1,-1);
		--当たりを有効に設定 --EN:--set hits to valid
		proxy:SetColiEnable(501, true);
		--ロジックを再開 --EN:--resume logic
		proxy:EnableLogic( 501, true );
		--索敵をOn（ロック可能にする） --EN:--Search enemies on (make it lockable)
		proxy:EnableHide( 501, false );
		
		
	end
	
	if proxy:IsAlive( 502 ) == true then
	
		--距離による更新タイミングの問題で、EzStateに命令が届かない場合があるので1フレーム強制更新 --EN:--Due to the update timing problem due to the distance, the command may not reach EzState, so 1 frame forced update
		proxy:ForceUpdateNextFrame( 502 );
		--起き上がりアニメ再生 --EN:--Get up animation playback
		--proxy:SetEventCommand( 502, 202 );--9800
		proxy:PlayAnimation( 502 , 9800 );
		proxy:SetSpStayAndDamageAnimId( 502 ,-1,-1);
		--当たりを有効に設定 --EN:--set hits to valid
		proxy:SetColiEnable(502, true);
		--ロジックを再開 --EN:--resume logic
		proxy:EnableLogic( 502, true );
		--索敵をOn（ロック可能にする） --EN:--Search enemies on (make it lockable)
		proxy:EnableHide( 502, false );		
	end
	
	--フラグをセット --EN:-- set the flag
	proxy:SetEventFlag( 141, 1 );

	--このイベントへの反応領域が2つあり、(登録IDは同じ) --EN:--There are two response areas for this event, (with the same registration ID)
	--片方が反応すると、もう片方は反応しないようにする。 --EN:--If one responds, the other should not respond.
	--パーティープレイヤーの監視も含め ここで削除。 --EN:--Including monitoring party players Removed here.
	proxy:DeleteEvent( 141 );
	
	print("OnEvent_141 end");
end

--------------------------------------------------------------------------------------
--死んだフリ腐敗人■142 --EN:-- Pretending to be dead rot 142
--------------------------------------------------------------------------------------
--■142■死んだフリ腐敗人■ --EN:--■ 142 ■ Corrupt person pretending to be dead ■
function OnEvent_142(proxy,param)	
	print("OnEvent_142 begin");
	
	if proxy:IsAlive( 503 ) == true then
	
		--距離による更新タイミングの問題で、EzStateに命令が届かない場合があるので1フレーム強制更新 --EN:--Due to the update timing problem due to the distance, the command may not reach EzState, so 1 frame forced update
		proxy:ForceUpdateNextFrame( 503 );
		--起き上がりアニメ再生 --EN:--Get up animation playback
		--proxy:SetEventCommand( 503, 201 );
		proxy:PlayAnimation( 503 ,9920 );
		proxy:SetSpStayAndDamageAnimId( 503 ,-1,-1);
		--当たりを有効に設定 --EN:--set hits to valid
		proxy:SetColiEnable(503, true);	
		--ロジックを再開 --EN:--resume logic
		proxy:EnableLogic( 503, true );
		--索敵をOn（ロック可能にする） --EN:--Search enemies on (make it lockable)
		proxy:EnableHide( 503, false );
	end
	
	--フラグをセット --EN:-- set the flag
	proxy:SetEventFlag( 142, 1 );
	
	print("OnEvent_142 end");
end

--------------------------------------------------------------------------------------
--死んだフリ腐敗人■143 --EN:-- Pretending to be dead rot 143
--------------------------------------------------------------------------------------
--■143■死んだフリ腐敗人■ --EN:--■ 143 ■ Corrupt person pretending to be dead ■
function OnEvent_143(proxy,param)
	print("OnEvent_143 begin");
	
	if proxy:IsAlive( 504 ) == true then
	
		--距離による更新タイミングの問題で、EzStateに命令が届かない場合があるので1フレーム強制更新 --EN:--Due to the update timing problem due to the distance, the command may not reach EzState, so 1 frame forced update
		proxy:ForceUpdateNextFrame( 504 );
		--起き上がりアニメ再生 --EN:--Get up animation playback
		--proxy:SetEventCommand( 504, 201 );
		proxy:PlayAnimation( 504 , 9920 );
		proxy:SetSpStayAndDamageAnimId( 504 ,-1,-1);	
		--当たりを有効に設定 --EN:--set hits to valid
		proxy:SetColiEnable(504, true);
		--ロジックを再開 --EN:--resume logic
		proxy:EnableLogic( 504, true );
		--索敵をOn（ロック可能にする） --EN:--Search enemies on (make it lockable)
		proxy:EnableHide( 504, false );		
	end
	
	if proxy:IsAlive( 505 ) == true then
		
		--距離による更新タイミングの問題で、EzStateに命令が届かない場合があるので1フレーム強制更新 --EN:--Due to the update timing problem due to the distance, the command may not reach EzState, so 1 frame forced update
		proxy:ForceUpdateNextFrame( 505 );
		--起き上がりアニメ再生 --EN:--Get up animation playback
		--proxy:SetEventCommand( 505, 202 );--9800
		proxy:PlayAnimation( 505 , 9800 );
		proxy:SetSpStayAndDamageAnimId( 505 ,-1,-1);
		--当たりを有効に設定 --EN:--set hits to valid
		proxy:SetColiEnable(505, true);
		--ロジックを再開 --EN:--resume logic
		proxy:EnableLogic( 505, true );
		--索敵をOn（ロック可能にする） --EN:--Search enemies on (make it lockable)
		proxy:EnableHide( 505, false );
	end
	
	--フラグをセット --EN:-- set the flag
	proxy:SetEventFlag( 143, 1 );
	
	--このイベントへの反応領域が2つあり、(登録IDは同じ) --EN:--There are two response areas for this event, (with the same registration ID)
	--片方が反応すると、もう片方は反応しないようにする。 --EN:--If one responds, the other should not respond.
	--パーティープレイヤーの監視も含め ここで削除。 --EN:--Including monitoring party players Removed here.
	proxy:DeleteEvent( 143 );
	
	print("OnEvent_143 end");
end


--------------------------------------------------------------------------------------
--死んだフリ腐敗人■144 --EN:-- Pretending to be dead rot 144
--------------------------------------------------------------------------------------
--■144■死んだフリ腐敗人■ --EN:--■ 144 ■ Corrupt person pretending to be dead ■
function OnEvent_144(proxy,param)
	print("OnEvent_144 begin");
	
	if proxy:IsAlive( 506 ) == true then
	
		--距離による更新タイミングの問題で、EzStateに命令が届かない場合があるので1フレーム強制更新 --EN:--Due to the update timing problem due to the distance, the command may not reach EzState, so 1 frame forced update
		proxy:ForceUpdateNextFrame( 506 );
		--起き上がりアニメ再生 --EN:--Get up animation playback
		--proxy:SetEventCommand( 506, 201 );
		proxy:PlayAnimation( 506 , 9920 );
		proxy:SetSpStayAndDamageAnimId( 506 ,-1,-1);
		--当たりを有効に設定 --EN:--set hits to valid
		proxy:SetColiEnable(506, true);
		--ロジックを再開 --EN:--resume logic
		proxy:EnableLogic( 506, true );
		--索敵をOn（ロック可能にする） --EN:--Search enemies on (make it lockable)
		proxy:EnableHide( 506, false );
	end
	
	--フラグをセット --EN:-- set the flag
	proxy:SetEventFlag( 144, 1 );

	print("OnEvent_144 end");
end


--------------------------------------------------------------------------------------
--死んだフリ腐敗人■145 --EN:-- Pretending to be dead rot 145
--------------------------------------------------------------------------------------
--■145■死んだフリ腐敗人■ --EN:--■ 145 ■ Pretending to be dead rot ■
function OnEvent_145(proxy,param)
	print("OnEvent_145 begin");
	
	if proxy:IsAlive( 507 ) == true then
	
		--距離による更新タイミングの問題で、EzStateに命令が届かない場合があるので1フレーム強制更新 --EN:--Due to the update timing problem due to the distance, the command may not reach EzState, so 1 frame forced update
		proxy:ForceUpdateNextFrame( 507 );
		--起き上がりアニメ再生 --EN:--Get up animation playback
		--proxy:SetEventCommand( 507, 201 );
		proxy:PlayAnimation( 507 , 9920 );
		proxy:SetSpStayAndDamageAnimId( 507 ,-1,-1);		
		--当たりを有効に設定 --EN:--set hits to valid
		proxy:SetColiEnable(507, true);
		--ロジックを再開 --EN:--resume logic
		proxy:EnableLogic( 507, true );
		--索敵をOn（ロック可能にする） --EN:--Search enemies on (make it lockable)
		proxy:EnableHide( 507, false );
	end
	
	if proxy:IsAlive( 508 ) == true then
		
		--距離による更新タイミングの問題で、EzStateに命令が届かない場合があるので1フレーム強制更新 --EN:--Due to the update timing problem due to the distance, the command may not reach EzState, so 1 frame forced update
		proxy:ForceUpdateNextFrame( 508 );
		--起き上がりアニメ再生 --EN:--Get up animation playback
		--proxy:SetEventCommand( 508, 202 );--9800
		proxy:PlayAnimation( 508 , 9800 );
		proxy:SetSpStayAndDamageAnimId( 508 ,-1,-1);
		--当たりを有効に設定 --EN:--set hits to valid
		proxy:SetColiEnable(508, true);
		--ロジックを再開 --EN:--resume logic
		proxy:EnableLogic( 508, true );
		--索敵をOn（ロック可能にする） --EN:--Search enemies on (make it lockable)
		proxy:EnableHide( 508, false );
	end
	
	--フラグをセット --EN:-- set the flag
	proxy:SetEventFlag( 145, 1 );
	
	--このイベントへの反応領域が2つあり、(登録IDは同じ) --EN:--There are two response areas for this event, (with the same registration ID)
	--片方が反応すると、もう片方は反応しないようにする。 --EN:--If one responds, the other should not respond.
	--パーティープレイヤーの監視も含め ここで削除。 --EN:--Including monitoring party players Removed here.
	proxy:DeleteEvent( 145 );

	print("OnEvent_145 end");
end


--------------------------------------------------------------------------------------
--死んだフリ腐敗人■146 --EN:-- Pretending to be dead rot 146
--------------------------------------------------------------------------------------
--■146■死んだフリ腐敗人■ --EN:--■ 146 ■ Corrupt person pretending to be dead ■
function OnEvent_146(proxy,param)
	print("OnEvent_146 begin");
	
	if proxy:IsAlive( 509 ) == true then	
		--距離による更新タイミングの問題で、EzStateに命令が届かない場合があるので1フレーム強制更新 --EN:--Due to the update timing problem due to the distance, the command may not reach EzState, so 1 frame forced update
		proxy:ForceUpdateNextFrame( 509 );
		--起き上がりアニメ再生 --EN:--Get up animation playback
		--proxy:SetEventCommand( 509, 203 );--7000
		proxy:PlayAnimation( 509 , 7000 );
		proxy:SetSpStayAndDamageAnimId( 509 ,-1,-1);
		--当たりを有効に設定 --EN:--set hits to valid
		proxy:SetColiEnable(509, true);
		--ロジックを再開 --EN:--resume logic
		proxy:EnableLogic( 509, true );
		--索敵をOn（ロック可能にする） --EN:--Search enemies on (make it lockable)
		proxy:EnableHide( 509, false );
	end
	
	if proxy:IsAlive( 510 ) == true then
		
		--距離による更新タイミングの問題で、EzStateに命令が届かない場合があるので1フレーム強制更新 --EN:--Due to the update timing problem due to the distance, the command may not reach EzState, so 1 frame forced update
		proxy:ForceUpdateNextFrame( 510 );
		--起き上がりアニメ再生 --EN:--Get up animation playback
		--proxy:SetEventCommand( 510, 203 );--7000
		proxy:PlayAnimation( 510 , 7000 );
		proxy:SetSpStayAndDamageAnimId( 510 ,-1,-1);
		--当たりを有効に設定 --EN:--set hits to valid
		proxy:SetColiEnable(510, true);
		--ロジックを再開 --EN:--resume logic
		proxy:EnableLogic( 510, true );
		--索敵をOn（ロック可能にする） --EN:--Search enemies on (make it lockable)
		proxy:EnableHide( 510, false );
	end
	
	--フラグをセット --EN:-- set the flag
	proxy:SetEventFlag( 146, 1 );

	print("OnEvent_146 end");
end


--------------------------------------------------------------------------------------
--死んだフリ腐敗人■147 --EN:-- Pretending to be dead rot 147
--------------------------------------------------------------------------------------
--■147■死んだフリ腐敗人■ --EN:--■ 147 ■ Pretending to be dead rot ■
function OnEvent_147(proxy,param)
	print("OnEvent_147 begin");
	
	if proxy:IsAlive( 511 ) == true then
	
		--距離による更新タイミングの問題で、EzStateに命令が届かない場合があるので1フレーム強制更新 --EN:--Due to the update timing problem due to the distance, the command may not reach EzState, so 1 frame forced update
		proxy:ForceUpdateNextFrame( 511 );
		--起き上がりアニメ再生 --EN:--Get up animation playback
		--proxy:SetEventCommand( 511, 201 );
		proxy:PlayAnimation( 511 , 9920 );
		proxy:SetSpStayAndDamageAnimId( 511 ,-1,-1);
		--当たりを有効に設定 --EN:--set hits to valid
		proxy:SetColiEnable(511, true);
		--ロジックを再開 --EN:--resume logic
		proxy:EnableLogic( 511, true );
		--索敵をOn（ロック可能にする） --EN:--Search enemies on (make it lockable)
		proxy:EnableHide( 511, false );
	end
	
	if proxy:IsAlive( 512 ) == true then
		
		--距離による更新タイミングの問題で、EzStateに命令が届かない場合があるので1フレーム強制更新 --EN:--Due to the update timing problem due to the distance, the command may not reach EzState, so 1 frame forced update
		proxy:ForceUpdateNextFrame( 512 );
		--起き上がりアニメ再生 --EN:--Get up animation playback
		--proxy:SetEventCommand( 512, 202 );--9800
		proxy:PlayAnimation( 512 , 9800 );
		proxy:SetSpStayAndDamageAnimId( 512 ,-1,-1);
		--当たりを有効に設定 --EN:--set hits to valid
		proxy:SetColiEnable(512, true);
		--ロジックを再開 --EN:--resume logic
		proxy:EnableLogic( 512, true );
		--索敵をOn（ロック可能にする） --EN:--Search enemies on (make it lockable)
		proxy:EnableHide( 512, false );
	end
	
	--フラグをセット --EN:-- set the flag
	proxy:SetEventFlag( 147, 1 );
	
	--このイベントへの反応領域が2つあり、(登録IDは同じ) --EN:--There are two response areas for this event, (with the same registration ID)
	--片方が反応すると、もう片方は反応しないようにする。 --EN:--If one responds, the other should not respond.
	--パーティープレイヤーの監視も含め ここで削除。 --EN:--Including monitoring party players Removed here.
	proxy:DeleteEvent( 147 );

	print("OnEvent_147 end");
end


--------------------------------------------------------------------------------------
--死んだフリ腐敗人■148 --EN:-- Pretending to be dead rot 148
--------------------------------------------------------------------------------------
--■148■死んだフリ腐敗人■ --EN:--■ 148 ■ Pretending to be dead rot ■
function OnEvent_148(proxy,param)
	print("OnEvent_148 begin");
	
	if proxy:IsAlive( 513 ) == true then
	
		--距離による更新タイミングの問題で、EzStateに命令が届かない場合があるので1フレーム強制更新 --EN:--Due to the update timing problem due to the distance, the command may not reach EzState, so 1 frame forced update
		proxy:ForceUpdateNextFrame( 513 );
		--起き上がりアニメ再生 --EN:--Get up animation playback
		--proxy:SetEventCommand( 513, 203 );--7000
		proxy:PlayAnimation( 513 , 7000 );
		proxy:SetSpStayAndDamageAnimId( 513 ,-1,-1);		
		--当たりを有効に設定 --EN:--set hits to valid
		proxy:SetColiEnable(513, true);
		--ロジックを再開 --EN:--resume logic
		proxy:EnableLogic( 513, true );
		--索敵をOn（ロック可能にする） --EN:--Search enemies on (make it lockable)
		proxy:EnableHide( 513, false );
	
	end
	
	if proxy:IsAlive( 514 ) == true then
		
		--距離による更新タイミングの問題で、EzStateに命令が届かない場合があるので1フレーム強制更新 --EN:--Due to the update timing problem due to the distance, the command may not reach EzState, so 1 frame forced update
		proxy:ForceUpdateNextFrame( 514 );
		--起き上がりアニメ再生 --EN:--Get up animation playback
		--proxy:SetEventCommand( 514, 202 );--9800
		proxy:PlayAnimation( 514 , 9800 );
		proxy:SetSpStayAndDamageAnimId( 514 ,-1,-1);
		--当たりを有効に設定 --EN:--set hits to valid
		proxy:SetColiEnable(514, true);
		--ロジックを再開 --EN:--resume logic
		proxy:EnableLogic( 514, true );
		--索敵をOn（ロック可能にする） --EN:--Search enemies on (make it lockable)
		proxy:EnableHide( 514, false );
		
	end
	
	if proxy:IsAlive( 515 ) == true then
		
		--距離による更新タイミングの問題で、EzStateに命令が届かない場合があるので1フレーム強制更新 --EN:--Due to the update timing problem due to the distance, the command may not reach EzState, so 1 frame forced update
		proxy:ForceUpdateNextFrame( 515 );
		--起き上がりアニメ再生 --EN:--Get up animation playback
		--proxy:SetEventCommand( 515, 201 );
		proxy:PlayAnimation( 515 , 9920 );
		proxy:SetSpStayAndDamageAnimId( 515 ,-1,-1);
		--当たりを有効に設定 --EN:--set hits to valid
		proxy:SetColiEnable(515, true);
		--ロジックを再開 --EN:--resume logic
		proxy:EnableLogic( 515, true );
		--索敵をOn（ロック可能にする） --EN:--Search enemies on (make it lockable)
		proxy:EnableHide( 515, false );
		
	end
	
	--フラグをセット --EN:-- set the flag
	proxy:SetEventFlag( 148, 1 );

	print("OnEvent_148 end");
end


--------------------------------------------------------------------------------------
--死んだフリ腐敗人■149 --EN:-- Pretending to be dead rot 149
--------------------------------------------------------------------------------------
--■149■死んだフリ腐敗人■ --EN:--■ 149 ■ Corrupt person pretending to be dead ■
function OnEvent_149(proxy,param)
	print("OnEvent_149 begin");
	
	if proxy:IsAlive( 516 ) == true then
	
		--距離による更新タイミングの問題で、EzStateに命令が届かない場合があるので1フレーム強制更新 --EN:--Due to the update timing problem due to the distance, the command may not reach EzState, so 1 frame forced update
		proxy:ForceUpdateNextFrame( 516 );
		--起き上がりアニメ再生 --EN:--Get up animation playback
		--proxy:SetEventCommand( 516, 202 );--9800
		proxy:PlayAnimation( 516 , 9800 );
		proxy:SetSpStayAndDamageAnimId( 516 ,-1,-1);
		--当たりを有効に設定 --EN:--set hits to valid
		proxy:SetColiEnable(516, true);
		--ロジックを再開 --EN:--resume logic
		proxy:EnableLogic( 516, true );
		--索敵をOn（ロック可能にする） --EN:--Search enemies on (make it lockable)
		proxy:EnableHide( 516, false );
	
	end
	
	--フラグをセット --EN:-- set the flag
	proxy:SetEventFlag( 149, 1 );

	print("OnEvent_149 end");
end


--------------------------------------------------------------------------------------
--小石が振ってくる■150 --EN:--A pebble shakes ■ 150
--------------------------------------------------------------------------------------
--■150■小石が振ってくる■ --EN:-- ■ 150 ■ pebbles shake ■
function OnEvent_150(proxy,param)
	print("OnEvent_150 begin");
	--モデルを差し替えて落とす --EN:--Replace and drop the model
	proxy:ChangeModel(1070,1);
	proxy:ChangeModel(1071,1);
	proxy:ChangeModel(1072,1);
	proxy:ChangeModel(1073,1);
	proxy:ChangeModel(1074,1);
	proxy:ChangeModel(1075,1);
	
	proxy:PlayTypeSE( 1070, SOUND_TYPE_O, 513005140 );
	
	--1秒後でずらして、開始直後に付近のマップパーツに当たるのを防ぐ --EN:--Staggered after 1 second to prevent hitting nearby map parts right after start
	proxy:OnKeyTime2( 150, "OnEvent_150_1", 1.0, 0, 1, once );

	print("OnEvent_150 end");
end

function OnEvent_150_1(proxy,param)
	print("OnEvent_150_1 begin");
	
	--落下岩ダメージ球 --EN:--Falling rock damage sphere
	local paramid = 10040; --落下岩ダメージ --EN:-- Falling rock damage
	local rad    = 0.5;--半径(あとで、正式な値になるはず･･･今は適当) --EN:--radius (should be a formal value later... suitable for now)
	local time   = 5; --ひとまずアニメ再生終了でダメージ球消すので、アニメより長い時間を指定しておく --EN:--For the time being, the damage ball will be erased when the animation ends, so specify a longer time than the animation.
	--▼150_hit▼石1があたったとき▼ --EN:--▼150_hit▼When stone 1 hits▼
	--proxy:OnObjectDamageHit_NoCall( 150, 1070, 1, paramid, EV_HIT_ALL ,  rad, time,  once );
	proxy:OnObjectDamageHit( 150, 1070, 1, paramid, EV_HIT_ALL, rad, time, "OnEvent_150_1070hit", once );
	--▼150_hit▼石2があたったとき▼ --EN:--▼150_hit▼When stone 2 hits▼
	--proxy:OnObjectDamageHit_NoCall( 150, 1071, 1, paramid, EV_HIT_ALL ,  rad, time,  once );
	proxy:OnObjectDamageHit( 150, 1071, 1, paramid, EV_HIT_ALL, rad, time, "OnEvent_150_1071hit", once );
	--▼150_hit▼石3があたったとき▼ --EN:--▼150_hit▼When stone 3 hits▼
	--proxy:OnObjectDamageHit_NoCall( 150, 1072, 1, paramid, EV_HIT_ALL ,  rad, time,  once );	
	proxy:OnObjectDamageHit( 150, 1072, 1, paramid, EV_HIT_ALL, rad, time, "OnEvent_150_1072hit", once );
	--▼150_hit▼石4があたったとき▼ --EN:--▼150_hit▼When stone 4 hits▼
	proxy:OnObjectDamageHit_NoCall( 150, 1073, 1, paramid, EV_HIT_ALL ,  rad, time,  once );
	--▼150_hit▼石5があたったとき▼ --EN:--▼150_hit▼When stone 5 hits▼
	proxy:OnObjectDamageHit_NoCall( 150, 1074, 1, paramid, EV_HIT_ALL ,  rad, time,  once );
	--▼150_hit▼石6があたったとき▼ --EN:--▼150_hit▼When stone 6 hits▼
	proxy:OnObjectDamageHit_NoCall( 150, 1075, 1, paramid, EV_HIT_ALL ,  rad, time,  once );
	
	proxy:OnKeyTime2( 150, "OnEvent_150_bloken", time, 0, 2, once );
	
	print("OnEvent_150_1 end");
end

function OnEvent_150_1070hit(proxy,param)
	print("OnEvent_150_1070hit begin");

	--マトリクス移動、モデル差し替え<2>、初速度、物理インスタンス消し --EN:-- Matrix movement, model replacement <2>, initial velocity, physical instance deletion
	SecondStageBreak(proxy, 1070, 2 );
	
	print("OnEvent_150_1070hit end");
end


function OnEvent_150_1071hit(proxy,param)
	print("OnEvent_150_1071hit begin");
	
	--マトリクス移動、モデル差し替え<2>、初速度、物理インスタンス消し --EN:-- Matrix movement, model replacement <2>, initial velocity, physical instance deletion
	SecondStageBreak(proxy, 1071, 2 );
	
	print("OnEvent_150_1071hit end");
end


function OnEvent_150_1072hit(proxy,param)
	print("OnEvent_150_1072hit begin");
	
	--マトリクス移動、モデル差し替え<2>、初速度、物理インスタンス消し --EN:-- Matrix movement, model replacement <2>, initial velocity, physical instance deletion
	SecondStageBreak(proxy, 1072, 2 );
	
	print("OnEvent_150_1072hit end");
end

function OnEvent_150_bloken(proxy,param)
	print("OnEvent_150_bloken begin");
	
	proxy:SetBrokenPiece(1070);
	proxy:SetBrokenPiece(1071);
	proxy:SetBrokenPiece(1072);
	proxy:SetBrokenPiece(1073);
	proxy:SetBrokenPiece(1074);
	proxy:SetBrokenPiece(1075);
	
	--フラグをセット --EN:-- set the flag
	proxy:SetEventFlag( 150, true );
	
	print("OnEvent_150_bloken end");
end

--------------------------------------------------------------------------------------
--小石が振ってくる■151 --EN:-- Pebbles are shaking ■ 151
--------------------------------------------------------------------------------------
--■151■小石が振ってくる■ --EN:-- ■ 151 ■ pebbles shake ■
function OnEvent_151(proxy,param)
	print("OnEvent_151 begin");
	--モデルを差し替えて落とす --EN:--Replace and drop the model
	proxy:ChangeModel(1064,1);
	proxy:ChangeModel(1065,1);
	proxy:ChangeModel(1066,1);
	proxy:ChangeModel(1067,1);
	proxy:ChangeModel(1068,1);
	proxy:ChangeModel(1069,1);
	
	proxy:PlayTypeSE( 1064, SOUND_TYPE_O, 513005140 );
	
	--1秒後でずらして、開始直後に付近のマップパーツに当たるのを防ぐ --EN:--Staggered after 1 second to prevent hitting nearby map parts right after start
	proxy:OnKeyTime2( 151, "OnEvent_151_1", 1.0, 0, 1, once );
	print("OnEvent_151 end");
end

function OnEvent_151_1(proxy,param)
	print("OnEvent_151_1 begin");
	
	--落下岩ダメージ球 --EN:--Falling rock damage sphere
	local paramid = 10040; --落下岩ダメージ --EN:-- Falling rock damage
	local rad    = 0.5;--半径(あとで、正式な値になるはず･･･今は適当) --EN:--radius (should be a formal value later... suitable for now)
	local time   = 5; --ひとまずアニメ再生終了でダメージ球消すので、アニメより長い時間を指定しておく --EN:--For the time being, the damage ball will be erased when the animation ends, so specify a longer time than the animation.
	--▼151_hit▼石1があたったとき▼ --EN:--▼151_hit▼When stone 1 hits▼
	proxy:OnObjectDamageHit( 151, 1064, 1, paramid, EV_HIT_ALL, rad, time, "OnEvent_151_1064hit", once );
	--▼151_hit▼石2があたったとき▼ --EN:--▼151_hit▼When stone 2 hits▼
	proxy:OnObjectDamageHit( 151, 1065, 1, paramid, EV_HIT_ALL, rad, time, "OnEvent_151_1065hit", once );
	--▼151_hit▼石3があたったとき▼ --EN:--▼151_hit▼When stone 3 hits▼
	proxy:OnObjectDamageHit( 151, 1066, 1, paramid, EV_HIT_ALL, rad, time, "OnEvent_151_1066hit", once );
	--▼151_hit▼石4があたったとき▼ --EN:--▼151_hit▼When stone 4 hits▼
	proxy:OnObjectDamageHit_NoCall( 151, 1067, 1, paramid, EV_HIT_ALL ,  rad, time,  once );
	--▼151_hit▼石5があたったとき▼ --EN:--▼151_hit▼When stone 5 hits▼
	proxy:OnObjectDamageHit_NoCall( 151, 1068, 1, paramid, EV_HIT_ALL ,  rad, time,  once );
	--▼151_hit▼石6があたったとき▼ --EN:--▼151_hit▼When stone 6 hits▼
	proxy:OnObjectDamageHit_NoCall( 151, 1069, 1, paramid, EV_HIT_ALL ,  rad, time,  once );
	
	proxy:OnKeyTime2( 151, "OnEvent_151_bloken", time, 0, 2, once );
	
	print("OnEvent_151_1 end");
end

function OnEvent_151_1064hit(proxy,param)
	print("OnEvent_151_1064hit begin");
	
	--マトリクス移動、モデル差し替え<2>、初速度、物理インスタンス消し --EN:-- Matrix movement, model replacement <2>, initial velocity, physical instance deletion
	SecondStageBreak(proxy, 1064, 2 );
	
	print("OnEvent_151_1064hit end");
end

function OnEvent_151_1065hit(proxy,param)
	print("OnEvent_151_1065hit begin");
	
	--マトリクス移動、モデル差し替え<2>、初速度、物理インスタンス消し --EN:-- Matrix movement, model replacement <2>, initial velocity, physical instance deletion
	SecondStageBreak(proxy, 1065, 2 );
	
	print("OnEvent_151_1065hit end");
end

function OnEvent_151_1066hit(proxy,param)
	print("OnEvent_151_1066hit begin");
	
	--マトリクス移動、モデル差し替え<2>、初速度、物理インスタンス消し --EN:-- Matrix movement, model replacement <2>, initial velocity, physical instance deletion
	SecondStageBreak(proxy, 1066, 2 );
	
	print("OnEvent_151_1066hit end");
end

function OnEvent_151_bloken(proxy,param)
	print("OnEvent_151_bloken begin");
	
	proxy:SetBrokenPiece(1064);
	proxy:SetBrokenPiece(1065);
	proxy:SetBrokenPiece(1066);
	proxy:SetBrokenPiece(1067);
	proxy:SetBrokenPiece(1068);
	proxy:SetBrokenPiece(1069);
	
	--フラグをセット --EN:-- set the flag
	proxy:SetEventFlag( 151, true );
	
	print("OnEvent_151_bloken end");
end

--------------------------------------------------------------------------------------
--光の壁■180 --EN:--Wall of light 180
--------------------------------------------------------------------------------------
--■180■光の壁■ --EN:-- ■ 180 ■ wall of light ■
function OnEvent_180(proxy,param)
	print("OnEvent_180 begin");
	

	--多重発動防止 --EN:--Multiple activation prevention
	if proxy:IsCompleteEvent( 180 ) == true then
		print("OnEvent_180 end");
		return;
	end
	
	--２つの光の壁が同期しなければいけないので２つとも消す	 --EN:--The two walls of light must be synchronized, so both are turned off.
	--proxy:DeleteObjSfxDmyPlyID( 1081, 200 );--Sfxを消去 --EN:--Clear Sfx
	--proxy:DeleteObjSfxDmyPlyID( 1080, 200 );--Sfxを消去	 --EN:--Clear Sfx
	
	--プレイヤーの同期アニメーション(true:パーティープレイヤーがアニメーションした) --EN:--Player synchronous animation (true: party player animated)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_WALK ) == true then
		proxy:SetEventFlag( 180 , 1 );
		proxy:SetEventFlag( 181 , 1 );
		print("OnEvent_180 end");
		return;
	end
	
	--ダミポリへワープ --EN:--Warp to Damipoli
	proxy:WarpDmy( LOCAL_PLAYER, 1080, 191 );
	
	proxy:NotNetMessage_begin();
		--▼180_1▼歩きアニメ終了▼ --EN:--▼180_1▼End of walking animation▼
		--proxy:OnChrAnimEnd( 180, LOCAL_PLAYER, ANIMEID_WALK, "OnEvent_180_1" , once );
		proxy:LuaCallStart( 180, 1 );
	proxy:NotNetMessage_end();
	
	proxy:SetEventFlag( 180, 1 );
	proxy:SetEventFlag( 181, 1 );
	
	--プロファイルセーブ要求 --EN:--profile save request
	proxy:SaveRequest_Profile();
	
	print("OnEvent_180 end");
end

function OnEvent_180_1(proxy,param)
	print("OnEvent_180_1 begin");
	
	proxy:LuaCallStart( 180, 1 );
	
	print("OnEvent_180_1 end");
end

--配信用アタリ,描画OFF --EN:--Atari for distribution, drawing OFF
function OnEvent_180_181_delete(proxy,param)
	print("OnEvent_180_delete begin");
	
	proxy:DeleteEvent( 180 );
	proxy:DeleteEvent( 181 );
	
	proxy:InvalidSfx( 2125, true );
	proxy:InvalidSfx( 2126, true );
	
	proxy:SetDrawEnable( 1080, false );--描画OFF --EN:--Drawing OFF
	proxy:SetColiEnable( 1080, false );--当たりOFF --EN:--Hit OFF
	proxy:SetObjDeactivate( 1080 , true );--デアクティブ --EN:--deactivate
	
	proxy:SetDrawEnable( 1081, false );--描画OFF --EN:--Drawing OFF
	proxy:SetColiEnable( 1081, false );--当たりOFF --EN:--Hit OFF
	proxy:SetObjDeactivate( 1081 , true );--デアクティブ --EN:--deactivate
	
	
	print("OnEvent_180_delete end");
end

--------------------------------------------------------------------------------------
--光の壁■181 --EN:--Wall of light 181
--------------------------------------------------------------------------------------
--■181■光の壁■ --EN:-- 181 Wall of light
function OnEvent_181(proxy,param)
	print("OnEvent_181 begin");
	

	--多重発動防止 --EN:--Multiple activation prevention
	if proxy:IsCompleteEvent( 181 ) == true then
		print("OnEvent_181 end");
		return;
	end
	
	--２つの光の壁が同期しなければいけないので２つとも消す	 --EN:--The two walls of light must be synchronized, so both are turned off.
	--proxy:DeleteObjSfxDmyPlyID( 1081, 200 );--Sfxを消去 --EN:--Clear Sfx
	--proxy:DeleteObjSfxDmyPlyID( 1080, 200 );--Sfxを消去 --EN:--Clear Sfx
	
	--プレイヤーの同期アニメーション(true:パーティープレイヤーがアニメーションした) --EN:--Player synchronous animation (true: party player animated)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_WALK ) == true then
		proxy:SetEventFlag( 180 , 1 );
		proxy:SetEventFlag( 181 , 1 );
		print("OnEvent_181 end");
		return;
	end
	
	--ダミポリへワープ --EN:--Warp to Damipoli
	proxy:WarpDmy( LOCAL_PLAYER, 1081, 191 );	
	
	proxy:NotNetMessage_begin();
		--▼180_1▼歩きアニメ終了▼ --EN:--▼180_1▼End of walking animation▼
		--proxy:OnChrAnimEnd( 180, LOCAL_PLAYER, ANIMEID_WALK, "OnEvent_181_1" , once );
		proxy:LuaCallStart( 180, 1 );
	proxy:NotNetMessage_end();
	
	proxy:SetEventFlag( 180, 1 );
	proxy:SetEventFlag( 181, 1 );
	
	--プロファイルセーブ要求 --EN:--profile save request
	proxy:SaveRequest_Profile();
	
	print("OnEvent_181 end");
end

function OnEvent_181_1(proxy,param)
	print("OnEvent_181_1 begin");
	
	proxy:LuaCallStart( 180, 1 );
	
	print("OnEvent_181_1 end");
end


--------------------------------------------------------------------------------------
--板落ち■190 --EN:--Ita omission ■ 190
--------------------------------------------------------------------------------------
--■190■板落ち■ --EN:-- ■ 190 ■ board omission ■
function OnEvent_190(proxy,param)
	print("OnEvent_190 begin");
	
	proxy:ChangeModel( 1090, 1 );
	proxy:SetBrokenPiece(1090);

	--効果音再生 --EN:--Play sound effect
	proxy:PlayTypeSE( 1090, SOUND_TYPE_O, 512000000);
	
	proxy:SetEventFlag( 190, true );
	
	
	print("OnEvent_190 end");
end


--------------------------------------------------------------------------------------
--■198,199■腐敗人死体有効化■ --EN:--■ 198,199 ■ Rotten corpses enabled ■
--------------------------------------------------------------------------------------
--■198,199■腐敗人死体有効化■ --EN:--■ 198,199 ■ Rotten corpses enabled ■
--[[
function corpse_Condition(proxy,param)
	local IsIn 		= proxy:IsCompleteEvent( 198 );
	local IsInOld 	= proxy:IsCompleteEvent( 199 );
	
	--前のフレームと今のフレームで違いがある場合、今のフレームを設定 --EN:--If there is a difference between the previous frame and the current frame, set the current frame
	if IsIn ~= IsInOld then
		proxy:SetEventFlag( 199, IsIn );
	end
	
	--前のフレームで誰もいなくて、今フレームで誰かが入っている時 --EN:--when there was no one in the previous frame and someone is in the current frame
	if	IsIn == true and IsInOld == false then
		return true;
	end
	
	return false;
end

function corpse_Result(proxy,param)
	local count = 0;
	for index = 1, param:GetParam2(), 1 do
		if proxy:IsCompleteEvent( 200 + index - 1 ) == true then
			count = count + 1;
		end
	end
	
	for index = 1, count, 1 do
		proxy:SetDrawEnable( 10270 + index - 1, true );
		proxy:SetColiEnable( 10270 + index - 1, true );
		proxy:EnableObjTreasure( 10270 + index - 1, true );
	end
end
function corpse_ReginIn(proxy,param)
	local region_list = {2141, 2142};
	local region_num = table.getn(region_list);
	local fall_chrId_list = {300, 301, 302, 303, 304, 305, 306, 307, 308, 309,
							 310, 311, 312, 313, 314, 315, 316, 317, 318, 319,
							 320, 321, 322, 323, 324, 325, 326, 327, 328, 329,
							 330, 331, 332, 333, 334, 335, 336, 337, 338, 339,
							 340, 500, 501, 502, 503, 504, 505, 506, 507, 508,
							 509, 510, 511, 512, 513, 514, 515, 516};
	local fall_chrNum = table.getn(fall_chrId_list);
	local count = 0;
	print("corpse_ReginIn begin");
	for chr_index = 1, fall_chrNum, 1 do
		for region_index = 1, region_num, 1 do
			if	proxy:IsRegionIn( fall_chrNum[chr_index], region_list[region_index] ) == true then
				count = count + 1;
			end
		end
	end
	
	for index = 1, count, 1 do
		if	index > 10 then
			return;
		end
		proxy:SetDrawEnable( 10270 + index - 1, true );
		proxy:SetColiEnable( 10270 + index - 1, true );
		proxy:EnableObjTreasure( 10270 + index - 1, true );
	end
end
]]

function corpseCheck(proxy,param)
	print("corpseCheck begin");
	--ホストのみがキックする --EN:--only the host kicks
	if proxy:IsClient() == true then
		print("corpseCheck return end");
		return;
	end
	proxy:LuaCallStart( 199, 2 );
	print("corpseCheck end");
end

function corpseUpdate(proxy,param)
	print("corpseUpdate begin");
	local fall_counter = 0;
	
	for actId = 200, 256, 1 do
		if	proxy:IsCompleteEvent( actId ) == true then
			fall_counter = fall_counter + 1;
		end
	end
	for index = 1, 10, 1 do
		if fall_counter > index + 1 then
			print("宝死体有効化",10270 + index - 1); --EN:print("Activate Treasure Corpse",10270 + index - 1);
			proxy:SetDrawEnable( 10270 + index - 1, true );
			proxy:SetColiEnable( 10270 + index - 1, true );
			proxy:EnableObjTreasure( 10270 + index - 1, true );
		end
	end
	print("corpseUpdate end");
end
--------------------------------------------------------------------------------------
--■200～256■腐敗人転落死■ --EN:--■ 200～256 ■ Corruption Fall Death ■
--------------------------------------------------------------------------------------
--■200～256■腐敗人転落死■ --EN:--■ 200～256 ■ Corruption Fall Death ■
--[[
function fall_Condition(proxy,param)
	local region_list = {2141, 2142};
	local region_num = table.getn(region_list);
	for index = 1, region_num, 1 do
		if proxy:IsRegionIn( param:GetParam2(), region_list[index] ) == true then
			--領域の中に入っているので成立 --EN:-- Established because it is in the area
			return true;
		end
	end
	return false;
end

function fall_result(proxy,param)
	--フラグを立てておく --EN:-- flag
	proxy:SetEventFlag( param:GetParam1(), true );
end
]]
function fall_countup(proxy,param)
	--同アクションID、別領域で対に登録されているので、もう片方を削除 --EN:--Since the same action ID is registered in a pair in another area, delete the other one
	proxy:DeleteEvent(param:GetParam1());
	--フラグを立てておく --EN:-- flag
	proxy:SetEventFlag( param:GetParam1(), true );
end

--[[
function OnEvent_270(proxy,param)
	print("OnEvent_270 begin");
	SetNpcStateFlag( proxy, param, kojiki_m50_flag_list, KOJIKI_M50_STATE_ANGRY );
	proxy:SetEventFlag( 270, true );
	print("OnEvent_270 end");
end

function OnEvent_271(proxy,param)
	print("OnEvent_271 begin");
	SetNpcStateFlag( proxy, param, kojiki_m50_flag_list, KOJIKI_M50_STATE_DEAD );
	proxy:SetEventFlag( 271, true );
	
	--死亡したので敵対監視を消す --EN:--Turn off Hostile Observation because you died
	proxy:DeleteEvent( 270 );
	print("OnEvent_271 end");
end
]]

--------------------------------------------------------------------------------------
--■167■ボスカメラ切り替えイベント■ --EN:-- ■ 167 ■ Boss camera switching event ■
--------------------------------------------------------------------------------------
function OnEvent_167(proxy,param)
	--print("OnEvent_167 begin");
	--ボスが死んでいない　かつ　ボスとの戦闘を開始している --EN:-- Boss is not dead and has started a battle with the boss
	if proxy:IsCompleteEvent( 808 ) == false and proxy:IsCompleteEvent( 163 ) == true then
		--ボス戦　非ロックカメラ --EN:-- Boss battle unlocked camera
		proxy:SetCamModeParamTargetId(5011);
		--ボス戦　ロックカメラ --EN:--Boss battle rock camera
		proxy:SetCamModeParamTargetIdForBossLock(5010);
	end
	--print("OnEvent_167 end");
end

--------------------------------------------------------------------------------------
--■281■最初の要石の光が消える■ --EN:-- ■ 281 ■ The light of the first keystone disappears ■
--------------------------------------------------------------------------------------

function OnEvent_281(proxy, param)
	print("OnEvent_281 begin");
	
	proxy:TreasureDispModeChange2( 1983 , false ,KANAME_SFX);
	
	print("OnEvent_281 end");
end


--------------------------------------------------------------------------------------
--■282■最初の要石の光が復活する■ --EN:-- ■ 282 ■ The light of the first keystone is revived ■
--------------------------------------------------------------------------------------

function OnEvent_282(proxy, param)
	print("OnEvent_282 begin");
	
	proxy:TreasureDispModeChange2( 1983 , true ,KANAME_SFX);
	
	print("OnEvent_282 end");
end

--------------------------------------------------------------------------------------
--徘徊デーモンの登場■?? --EN:-- Appearance of the Wandering Demon ??
--------------------------------------------------------------------------------------

--▼グローバルの死亡監視から呼ばれる(ソロ) --EN:--▼ Called from global death watch (solo)
function PlayerDeath_m05_00_00_00(proxy, param)
	print("PlayerDeath_m05_00_00_00");
	
--	LuaFunc_VisibleTheWanderingDemon(proxy, param, demon_id_list_m05_00_00_00);
--	proxy:SetEventFlag( 20 , 1 );--フラグは仮、指定があれば変える。 --EN:The -- flag is tentative, and will be changed if specified.
	
	print("PlayerDeath_m05_00_00_00");
end

--▼グローバルの血文字復活から呼ばれる(ソロ) --EN:--▼Called from global blood letter revival (solo)
function PlayerRevive_m05_00_00_00(proxy,param)
	print("PlayerRevive_m05_00_00_00");
	
--	LuaFunc_InvisibleTheWanderingDemon(proxy, param, demon_id_list_m05_00_00_00);
--	proxy:SetEventFlag( 20 , 0 );--フラグは仮、指定があれば変える。 --EN:The -- flag is tentative, and will be changed if specified.
	
	print("PlayerRevive_m05_00_00_00");
end

------------------------------
--乞食(女)ショップの状態変化-- --EN:--Changes in Beggar (Woman) Shop--
------------------------------
--▼乞食(女)が不浄1で敵対する▼-- --EN:--▼ Beggar (female) is hostile with uncleanness 1 ▼--
function OnEvent_270(proxy, param)
	print("OnEvent_270 begin");

	--ロジックOn --EN:--Logic On
	proxy:EnableLogic( 650, true );
	
	--乞食(女)の状態を敵対(不浄1)にする --EN:--Make beggar (female) hostile (unclean 1)
	SetNpcStateFlag(proxy, param, Kojiki_Shop_Flag_list, KOJIKI_FEMALE_SHOP_HOSTILE01 );
	--乞食(女)のチームタイプを変更する --EN:--Change beggar (female) team type
	proxy:SetTeamType( 650, TEAM_TYPE_AngryFriend );

	--フラグを立てる --EN:-- flag
	proxy:SetEventFlag( 270, true );
	
	print("OnEvent_270 end");
end
--▲-------------------------▲-- --EN:--▲----------▲--


--▼乞食(女)が死亡する(不浄1)▼-- --EN:--▼ A beggar (female) dies (unclean 1) ▼--
function OnEvent_271(proxy, param)
	print("OnEvent_271 begin");

	--乞食(女)の状態を「死亡」に変える --EN:-- Change the state of the beggar (female) to "dead"
	SetNpcStateFlag( proxy, param, Kojiki_Shop_Flag_list, KOJIKI_FEMALE_SHOP_DEAD );
	
	--フラグを立てる --EN:-- flag
	proxy:SetEventFlag( 271, true );
	
	--敵に削られて敵対を通り越して死亡もありえるので、ここでも削除 --EN:--Because it is possible to die by being scraped by the enemy and passing through the hostility, it is also deleted here
	--死んだら敵対にはならないので削除 --EN:--Deleted because it won't be hostile if you die
	proxy:DeleteEvent( 270 );
	proxy:DeleteEvent( 810 );

	print("OnEvent_271 end");
end
--▲-------------------------▲-- --EN:--▲----------▲--


function OnEvent_272(proxy, param) proxy:LuaCallStart(812, 1); end
function OnEvent_273(proxy, param) proxy:LuaCallStart(812, 1); end
function OnEvent_275(proxy, param) proxy:LuaCallStart(812, 1); end

function OnEvent_812(proxy, param)
	print("OnEvent_812 begin");
	print("JustInCheckPoint");
	
	local KojikiShop01_id = 650;
	local KojikiShop02_id = 677;
	
	local KojikiShopBlock1_acid_list = {274,270,271};
	local KojikiShopBlock2_acid_list = {810,811};
	
	--一旦2体とも消える --EN:--both disappear once
	InvalidCharactor(proxy,KojikiShop01_id);
	InvalidCharactor(proxy,KojikiShop02_id);
	
	if proxy:IsClient() == false then
		proxy:RequestForceUpdateNetwork( KojikiShop01_id);
		proxy:RequestForceUpdateNetwork( KojikiShop02_id);
	end
	
	--ブロックの監視を削除 --EN:--remove block watcher
	DeleteConditionList(proxy,KojikiShopBlock1_acid_list);
	DeleteConditionList(proxy,KojikiShopBlock2_acid_list);
	
	
	--取りあえず初期状態を設定 --EN:-- Set the initial state for now
	SetFirstNpcStateFlag( proxy, param, Kojiki_Shop_Flag_list, KOJIKI_FEMALE_SHOP_SELL01 );
	
	
	--乞食(女)が不浄2に移動する --EN:--Beggar (female) moves to Impure 2
	if proxy:IsCompleteEvent( KOJIKI_FEMALE_SHOP_SELL01 ) == true then
		print("KojikiShop NowState KOJIKI_FEMALE_SHOP_SELL01");
		SetKojikiShopState01(proxy, param);
		KojikiRegistConditionBlock01(proxy,param);

	--乞食(女)が不浄1で敵対 --EN:--Beggar (female) is hostile with Unclean 1
	elseif proxy:IsCompleteEvent( KOJIKI_FEMALE_SHOP_HOSTILE01 ) == true then
		print("KojikiShop NowState KOJIKI_FEMALE_SHOP_HOSTILE01");
		SetKojikiShopState02(proxy, param);
		KojikiRegistConditionBlock01(proxy,param);

	--乞食(女)が死亡した --EN:--The beggar (woman) died
	elseif proxy:IsCompleteEvent( KOJIKI_FEMALE_SHOP_DEAD ) == true then
		print("KojikiShop NowState KOJIKI_FEMALE_SHOP_DEAD");
		SetKojikiShopState03(proxy, param);
		KojikiRegistConditionBlock01(proxy,param);

	--乞食(女)が不浄2で販売中 --EN:--Beggar (Woman) is on sale at Unclean 2
	elseif proxy:IsCompleteEvent( KOJIKI_FEMALE_SHOP_SELL02 ) == true then
		print("KojikiShop NowState KOJIKI_FEMALE_SHOP_SELL02");
		SetKojikiShopState04(proxy, param);
		KojikiRegistConditionBlock02(proxy,param);

	--乞食(女)が不浄2で敵対している --EN:--Beggar (female) is hostile in Unclean 2
	elseif proxy:IsCompleteEvent( KOJIKI_FEMALE_SHOP_HOSTILE02 ) == true then
		print("KojikiShop NowState KOJIKI_FEMALE_HOSTILE02");
		SetKojikiShopState05(proxy, param);
		KojikiRegistConditionBlock02(proxy,param);

	end

	print("OnEvent_812 end");
end


--▼乞食(女)が販売している(不浄1)▼----------------------------------------- --EN:--▼ Sold by a beggar (female) (unclean 1) ▼--------------------------------- --------
function SetKojikiShopState01( proxy, param )
	--蛭デーモンが生きている --EN:--The leech demon is alive
	if proxy:IsCompleteEvent( 5650 ) == false then
		ValidCharactor(proxy,650);--不浄1にいる乞食(女)を有効化 --EN:--Enable Beggar (female) in Impure 1
	
	--蛭デーモンが死んでいる --EN:-- the leech daemon is dead
	else
		print("KojikiShop NowState KOJIKI_FEMALE_SHOP_SELL01 > Chenge to KOJIKI_FEMALE_SHOP_SELL02");
		InvalidBackRead(proxy,650);--不浄1にいる乞食(女)を無効化 --EN:--Nullify the beggar (female) in Unclean 1
		ValidCharactor(proxy,677);--不浄2にいる乞食(女)を有効化 --EN:--Enable beggar (female) in Impure 2
		
		--ロジックOFFにする --EN:--Turn off the logic
		--proxy:EnableLogic( 677, false );
		
		--乞食(女)の状態を「販売(不浄2)」に変える --EN:-- Change the state of the beggar (woman) to "sale (unclean 2)"
		SetNpcStateFlag( proxy, param, Kojiki_Shop_Flag_list, KOJIKI_FEMALE_SHOP_SELL02 );
	end
end
--▲-----------------------------▲----------------------------------------- --EN:--▲-----------------------------▲----------------- --------------------


--▼乞食(女)が敵対している(不浄1)▼------------------------- --EN:--▼The beggar (woman) is hostile (unclean 1)▼--------------
function SetKojikiShopState02( proxy, param )
	ValidCharactor(proxy,650);--不浄1にいる乞食(女)を有効化 --EN:--Enable Beggar (female) in Impure 1
	InvalidBackRead(proxy,677);--不浄2にいる乞食(女)を無効化 --EN:--Nullify beggar (female) in Impure 2
	--乞食(女)のチームタイプを変更する --EN:--Change beggar (female) team type
	proxy:SetTeamType( 650, TEAM_TYPE_AngryFriend );
end
--▲-----------------------------▲------------------------- --EN:--▲-----------------------------▲----------------- --------


--▼乞食(女)が死亡した(不浄1)▼------------------------------------- --EN:--▼ A beggar (female) died (unclean 1) ▼----------------------------------- --
function SetKojikiShopState03( proxy, param )
	InvalidBackRead(proxy,650);--不浄1にいる乞食(女)を無効化 --EN:--Nullify the beggar (female) in Unclean 1
	InvalidBackRead(proxy,677);--不浄2にいる乞食(女)を無効化 --EN:--Nullify beggar (female) in Impure 2
end
--▲-------------------------▲------------------------------------- --EN:--▲------------------------▲--------------------- ----------------


--▼乞食(女)が販売している(不浄2)▼----------------------------------------- --EN:--▼ Sold by a beggar (female) (unclean 2) ▼--------------------------------- --------
function SetKojikiShopState04( proxy, param )
	InvalidBackRead(proxy,650);--不浄1にいる乞食(女)を無効化 --EN:--Nullify the beggar (female) in Unclean 1
	ValidCharactor(proxy,677);--不浄2にいる乞食(女)を有効化 --EN:--Enable beggar (female) in Impure 2
end
--▲-------------------------▲------------------------------------- --EN:--▲------------------------▲--------------------- ----------------


--▼乞食(女)が敵対している(不浄2)▼------------------------- --EN:--▼The beggar (woman) is hostile (unclean 2)▼--------------
function SetKojikiShopState05( proxy, param )
	InvalidBackRead(proxy,650);--不浄1にいる乞食(女)を無効化 --EN:--Nullify the beggar (female) in Unclean 1
	ValidCharactor(proxy,677);--不浄2にいる乞食(女)を有効化 --EN:--Enable beggar (female) in Impure 2
	--乞食(女)のチームタイプを変更する --EN:--Change beggar (female) team type
	proxy:SetTeamType( 677, TEAM_TYPE_AngryFriend );
end
--▲-----------------------------▲------------------------- --EN:--▲-----------------------------▲----------------- --------


--▼乞食(女)の状態遷移(不浄1)▼-------------------------------------------------------------------------------------- --EN:--▼ State transition of beggar (female) (unclean 1) ▼---------------------------------- -------------------------------------------------- -
function KojikiRegistConditionBlock01(proxy, param)
	--乞食(女)が死んでいない --EN:--The beggar (woman) is not dead
	if proxy:IsCompleteEvent( KOJIKI_FEMALE_SHOP_DEAD ) == false then
		--乞食(女)が不浄1,2のいずれでも敵対していない場合 --EN:--If the beggar (woman) is not hostile to either uncleanness 1 or 2
		if proxy:IsCompleteEvent( KOJIKI_FEMALE_SHOP_HOSTILE01 ) == false
		   and proxy:IsCompleteEvent( KOJIKI_FEMALE_SHOP_HOSTILE02 ) == false then
			--ホストからのダメージ監視 --EN:--Damage monitoring from host
			--m05_00
			--proxy:OnCharacterTotalDamage( 270, 650, LOCAL_PLAYER, KojikiShop_TotalDamage, "OnEvent_270", once );
			proxy:OnCharacterTotalRateDamage( 270, 650, LOCAL_PLAYER, NPC_ANGRY_Rate, "OnEvent_270", once );
			--m05_01
			--proxy:OnCharacterTotalDamage( 810, 677, LOCAL_PLAYER, KojikiShop_TotalDamage, "OnEvent_810", once );
			proxy:OnCharacterTotalRateDamage( 810, 677, LOCAL_PLAYER, NPC_ANGRY_Rate, "OnEvent_810", once );
		end
		proxy:OnCharacterDead( 271, 650, "OnEvent_271", once );
	end
end
--▲------------------▲-------------------------------------------------------------------------------------- --EN:--▲------------------▲---------------------------- -------------------------------------------------- --------


--▼乞食(女)の状態遷移(不浄2)▼------------------------------------------------------------------------------- --EN:--▼ State transition of beggar (female) (unclean 2) ▼---------------------------------- --------------------------------------------
function KojikiRegistConditionBlock02(proxy, param)
	--乞食(女)が死んでいない --EN:--The beggar (woman) is not dead
	if proxy:IsCompleteEvent( KOJIKI_FEMALE_SHOP_DEAD ) == false then
		--乞食(女)が不浄1,2のいずれでも敵対していない場合 --EN:--If the beggar (woman) is not hostile to either uncleanness 1 or 2
		if proxy:IsCompleteEvent( KOJIKI_FEMALE_SHOP_HOSTILE01 ) == false
		   and proxy:IsCompleteEvent( KOJIKI_FEMALE_SHOP_HOSTILE02 ) == false then
			--ホストからのダメージ監視 --EN:--Damage monitoring from host
			--m05_00
			--proxy:OnCharacterTotalDamage( 270, 650, LOCAL_PLAYER, KojikiShop_TotalDamage, "OnEvent_270", once );
			proxy:OnCharacterTotalRateDamage( 270, 650, LOCAL_PLAYER, NPC_ANGRY_Rate, "OnEvent_270", once );
			--m05_01
			--proxy:OnCharacterTotalDamage( 810, 677, LOCAL_PLAYER, KojikiShop_TotalDamage, "OnEvent_810", once );
			proxy:OnCharacterTotalRateDamage( 810, 677, LOCAL_PLAYER, NPC_ANGRY_Rate, "OnEvent_810", once );
		end
		proxy:OnCharacterDead( 811, 677, "OnEvent_811", once );
	end
end
--▲------------------▲-------------------------------------------------------------------------------------- --EN:--▲------------------▲---------------------------- -------------------------------------------------- --------


-----------------------------------------------------------------------------
--■■結晶トカゲイベント --EN:-- ■ ■ Crystal lizard event
-----------------------------------------------------------------------------
--ボス撃破時のトカゲリセット用 --EN:--For lizard reset when defeating boss
function ResetTokage(proxy)
	print("ResetTokage");
	--proxy:SetEventFlag(310,false);
	--proxy:SetEventFlag(830,false);
	--proxy:SetEventFlag(1140,false);			
	AddEventCounter(proxy,15);
	AddEventCounter(proxy,16);
	AddEventCounter(proxy,17);
end

-----------------------------------------------------------------------------
--■310■結晶トカゲイベント1 --EN:-- ■ 310 ■ Crystal Lizard Event 1
-----------------------------------------------------------------------------
function OnEvent_310(proxy,param)
	print("OnEvent_310 begin");
	proxy:SetEventFlag( 310, true);
	proxy:DeleteEvent( 310 );
	print("OnEvent_310 end");
end

-----------------------------------------------------------------------------
--■830■結晶トカゲイベント2 --EN:-- ■ 830 ■ Crystal Lizard Event 2
-----------------------------------------------------------------------------
function OnEvent_830(proxy,param)
	print("OnEvent_830 begin");
	proxy:SetEventFlag( 830, true);
	proxy:DeleteEvent( 830 );
	print("OnEvent_830 end");
end

-----------------------------------------------------------------------------
--■1140■結晶トカゲイベント3 --EN:-- ■ 1140 ■ Crystal Lizard Event 3
-----------------------------------------------------------------------------
function OnEvent_1140(proxy,param)
	print("OnEvent_1140 begin");
	proxy:SetEventFlag( 1140, true);
	proxy:DeleteEvent( 1140 );
	print("OnEvent_1140 end");
end


-----------------------------------------------------------------------------
--■24■QWCハシゴの先に進んだ --EN:--■24■Goed beyond the QWC ladder
-----------------------------------------------------------------------------
function OnEvent_24(proxy,param)
	print("OnEvent_24 begin");
	proxy:SetEventFlag( 24,true );
	print("OnEvent_24 end");
end


--血ダニダメージ --EN:--blood mite damage
function OnEvent_320(proxy,param)
	print("OnEvent_320 begin");
	proxy:EnableLogic( 520, true );
	proxy:SetEventFlag( 320 , true );
	print("OnEvent_320 end");
end

--血ダニダメージ --EN:--blood mite damage
function OnEvent_321(proxy,param)
	print("OnEvent_321 begin");
	proxy:EnableLogic( 521, true );
	proxy:SetEventFlag( 321 , true );
	print("OnEvent_321 end");
end

--血ダニダメージ --EN:--blood mite damage
function OnEvent_322(proxy,param)
	print("OnEvent_322 begin");
	proxy:EnableLogic( 522, true );
	proxy:SetEventFlag( 322 , true );
	print("OnEvent_322 end");
end

--血ダニダメージ --EN:--blood mite damage
function OnEvent_323(proxy,param)
	print("OnEvent_323 begin");
	proxy:EnableLogic( 523, true );
	proxy:SetEventFlag( 323 , true );
	print("OnEvent_323 end");
end

--血ダニダメージ --EN:--blood mite damage
function OnEvent_324(proxy,param)
	print("OnEvent_324 begin");
	proxy:EnableLogic( 524, true );
	proxy:SetEventFlag( 324 , true );
	print("OnEvent_324 end");
end

--血ダニダメージ --EN:--blood mite damage
function OnEvent_325(proxy,param)
	print("OnEvent_325 begin");
	proxy:EnableLogic( 525, true );
	proxy:SetEventFlag( 325 , true );
	print("OnEvent_325 end");
end

