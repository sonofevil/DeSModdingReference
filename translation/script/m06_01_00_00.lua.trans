
------------------------------------------------
--結晶トカゲ出現条件のQWC値の最大、最小値の定数 --EN:--Constants for the maximum and minimum QWC values for crystal lizard appearance conditions
------------------------------------------------
--62_300
QWC01_MIN = 200;	--最小値 --EN:--minimum value
QWC01_MAX = 300;	--最大値 --EN:--Maximum value
--62_301
QWC02_MIN = 000;	--最小値 --EN:--minimum value
QWC02_MAX = 100;	--最大値 --EN:--Maximum value
--62_302
QWC03_MIN = 100;	--最小値 --EN:--minimum value
QWC03_MAX = 200;	--最大値 --EN:--Maximum value


------------------------------------------------
--ハーフハンド出現条件のQWC値の最大、最小値の定数 --EN:--Maximum and minimum QWC value constants for half-hand appearance conditions
------------------------------------------------
--62_202
HALF_QWC01 = 0;
HALF_QWC02 = 0;

--■ハーフハンドの状態一覧 --EN:--■ Half hand status list

HALF_STATE_WAIT_KOUDOU     = 16160;--坑道で待つ --EN:--wait in the tunnel
HALF_STATE_WAIT_SEKITYU    = 16161;--石柱で待つ --EN:--Waiting at the stone pillar
HALF_STATE_HOSTILE_KOUDOU  = 16162;--敵対(坑道) --EN:-- Hostility (Tunnel)
HALF_STATE_HOSTILE_SEKITYU = 16163;--敵対(石柱) --EN:-- Hostility (Stone Pillar)
HALF_STATE_DEAD            = 16164;--死亡 --EN:--death
HALF_STATE_GO_TO_SEKITYU   = 16165;--石柱へ行きたい --EN:--I want to go to the stone pillar

half_flag_list = {

	HALF_STATE_WAIT_KOUDOU     ,
	HALF_STATE_WAIT_SEKITYU    ,
	HALF_STATE_HOSTILE_KOUDOU  ,
	HALF_STATE_HOSTILE_SEKITYU ,
	HALF_STATE_DEAD            ,
	HALF_STATE_GO_TO_SEKITYU
};

--蓄積ダメージ --EN:--Accumulated damage
HALF_TOTALDAMAGE = 50;

--■バッチ（ウィス）の状態一覧 --EN:-- ■Batch (Whis) status list

--[[

	event_define.luaに記述 --EN:Described in event_define.lua

	]]

--岩ミミズ反応距離 --EN:--Rock worm reaction distance
PROTROCKWORM_DIST = 5.0;
ROCKWORM1_DIST = 4.0;
ROCKWORM2_DIST = 4.0;
ROCKWORM3_DIST = 4.0;
ROCKWORM4_DIST = 4.0;
ROCKWORM5_DIST = 4.0;
ROCKWORM6_DIST = 4.0;
ROCKWORM7_DIST = 4.0;

--岩ミミズダメージ倍率 --EN:--Rock worm damage multiplier
ROCKWORM_DAMAGE_RATE = 9;

--ウィスプ爆発距離 --EN:--Wisp Explosion Distance
WISP1_DIST = 2.0;
WISP2_DIST = 2.0;
WISP3_DIST = 2.0;
WISP4_DIST = 1.5;
WISP5_DIST = 1.0;

--[[ショップ乞食２ --EN:--[[Shop beggar 2
SHOP02_NORMAL  = 16450;--販売中 --EN:--Sale
SHOP02_HOSTILE = 16451;--敵対 --EN:--hostile
SHOP02_DEAD	   = 16452;--死亡 --EN:--death

SHOP02_Flag_list = {
	SHOP02_NORMAL,
	SHOP02_HOSTILE,
	SHOP02_DEAD
}

SHOP02_TOTALDAMAGE = 50;
]]


FIREDOM_COUNT2 = 0;
FIREDOM_COUNT3 = 0;

FIREDOM_TIME2 = 0.2;
FIREDOM_TIME3 = 0.2;

IS_FIREAREA2 = false;
IS_FIREAREA3 = false;

OFFSET2 = -2;
OFFSET3 = -2;

--------------------------------------------------------------------------------------
--マップ読み込み時に読まれる初期化処理■ --EN:--Initialization process read when reading the map ■
--------------------------------------------------------------------------------------
function Initialize_m06_01_00_00(proxy)
	print("Initialize m06_01_00_00 begin");
-----------------------------------------------------------------------------------------
--ボス関連 --EN:--Boss related
-----------------------------------------------------------------------------------------
--■520■ボス部屋に入る■ --EN:-- ■ 520 ■ Enter the boss room ■
	--中ボスが生きているときだけイベント登録 --EN:-- Event registration only when the mid-boss is alive
	if proxy:IsCompleteEvent( 6272 ) == false then
	
		--ソロのときは一度目にボス部屋に入る用のイベントを毎回登録させたいので、対応するフラグをOFFにする。 --EN:-- When soloing, we want to register the event for entering the boss room for the first time every time, so turn off the corresponding flag.
		SingleReset(proxy, 520);
	
		--▽同期アニメ再生用の開始ハンドラ(旋回→歩き) --EN:--▽ Start handler for synchronous animation playback (turning → walking)
		proxy:LuaCall( 521, 1, "OnEvent_521_1", everytime );
		--▽2回目以降にボス部屋に入るためのイベント配信用 --EN:--▽For event delivery to enter the boss room after the second time
		proxy:LuaCall( 521 , 5 , "OnEvent_520_GO_TO_IN" , everytime );
		--▽フラグセット(同期用) --EN:--▽flag set (for synchronization)
		proxy:LuaCall( 521 , 6 , "OnEvent_520_flag_set" , everytime );
		
		--誰かがボス前扉をまだ通過していない --EN:--Someone hasn't passed through the boss front door yet
		if proxy:IsCompleteEvent( 520 ) == false then
			
			--(セッション中に)ボス前の魔法壁を最初に通れるのは生存の人だけ --EN:--(During the session) Only survivors can pass through the magic wall in front of the boss first
			local possible_chr_type = ATTR_HOST + ATTR_LIVE + ATTR_GREY;
			
			proxy:NotNetMessage_begin();
				--▼520▼扉が開いているときに中に入るためのイベントを追加▼ --EN:--▼520▼Add an event to enter when the door is open▼
				proxy:OnPlayerActionInRegionAttribute( 520, 2894, "OnEvent_520", HELPID_GO_TO_IN, possible_chr_type, everytime );
			proxy:NotNetMessage_end();
			
		else --グレイゴーストできたときようにいると思われる。 --EN:--Gray ghost seems to be like that when it's done.
			
			proxy:NotNetMessage_begin();
				--▼521▼扉が開いているときに中に入るためのイベントを追加▼ --EN:--▼521▼Add an event to enter when the door is open▼
				proxy:OnPlayerActionInRegion( 521, 2894, "OnEvent_520", HELPID_GO_TO_IN, everytime );--ハンドラは上と同じ --EN:--handler is the same as above
			proxy:NotNetMessage_end();
		end
	end


--■522■中ボス出現演出(二匹目)■ --EN:-- ■ 522 ■ Mid-Boss Appearance (Second) ■
	--ボス生きている --EN:--boss alive
	if proxy:IsCompleteEvent( 6272 ) == false then
		--ポリ劇終わってない --EN:--The police drama is not over
		if proxy:IsCompleteEvent(522) == false then
			proxy:OnRegionIn(522,10000,2898,"OnEvent_522",once);
			proxy:NotNetMessage_begin();
				--ポリ劇開始に呼ばれるハンドラ --EN:--handler called at polyplay start
				proxy:LuaCall(522, REMO_START, "OnEvent_522_RemoStart", once);
				--ポリ劇終了後に呼ばれるハンドラ(トリガー起こした人用) --EN:--Handler called after the end of the polyplay (for the person who caused the trigger)
				proxy:LuaCall(522, REMO_FINISH, "OnEvent_522_RemoFinish", once);
			proxy:NotNetMessage_end();
			proxy:SetColiEnable( 1281, false );
			proxy:SetDrawEnable( 1281, false );
		else
			proxy:SetColiEnable( 1280, false );
			proxy:SetDrawEnable( 1280, false );
			proxy:SetEventFlag( 524 , true );
		end
	end
	
--■523■ボス戦闘開始■	 --EN:-- ■ 523 ■ Boss battle begins ■
	if proxy:IsCompleteEvent( 6272 ) == false then
		--シングルロード時初期化 --EN:--Initialization at single load
		SingleReset( proxy , 523 );
		proxy:OnRegionIn( 523 , 10000 , 2886 , "OnEvent_523" , everytime );
	end
	
--■6272■中ボス死亡で扉が開く■ --EN:-- ■ 6272 ■ The door opens when the mid-boss dies ■
	proxy:AddFieldInsFilter( 811 );
	if proxy:IsCompleteEvent( 6272 ) == false then
		proxy:OnCharacterDead( 6272 , 811 , "OnEvent_6272" , once );
	end

--■ボス関連の初期化処理(二匹目) --EN:--■ Boss-related initialization processing (second animal)
	if proxy:IsCompleteEvent( 6272 ) ==true then
		
		--▽ボス死んでいるとき --EN:--▽When the boss is dead
		--ボスいなくなる --EN:--boss disappears
		InvalidBackRead( proxy , 811 );
		
		--魔法壁消える --EN:--Magic wall disappears
		proxy:SetColiEnable( 1998 , false );
		proxy:SetColiEnable( 1994 , false );
	
		proxy:SetDrawEnable( 1998 , false );
		proxy:SetDrawEnable( 1994 , false );
		
		--SFX OFF
		proxy:InvalidSfx( 1986 , false );
		proxy:InvalidSfx( 1990 , false );
		
		--ホストプレイヤーのみアイテム入手イベントに使用 --EN:--Used for item acquisition event only for host players
		local possible_chr_type = ATTR_HOST + ATTR_LIVE + ATTR_GREY;

		--宝死体(ソウル?)有効化 --EN:--Treasure corpse (soul?) activation
		proxy:SetDrawEnable( 1981 , true );
		proxy:SetColiEnable( 1981 , true );
		proxy:TreasureDispModeChange2( 1981 , true ,KANAME_SFX);--光らせる --EN:-- let it shine
		--ソウルに刺さった剣有効化 --EN:--Activation of the sword stuck in the soul
		proxy:SetDrawEnable( 1976 , true );
		proxy:SetColiEnable( 1976 , true );
		--proxy:TreasureDispModeChange2( 1976 , true ,KANAME_SFX);--光らせる --EN:-- let it shine
		
		--▼(ソウル)アイテム取得用イベント監視追加▼ --EN:--▼ (Soul) Added event monitoring for item acquisition▼
		if proxy:IsCompleteEvent( 6283 ) == false then
			--SFX ON
			proxy:ValidSfx( 2250 );--光の粒子 --EN:--Particles of light
			proxy:ValidSfx( 2251 );--要石のオーラ			 --EN:--Keystone Aura
			proxy:OnDistanceActionAttribute( 6283 , 10000 , 1981 , "OnEvent_6283" , WarpGimmickDist_A , 10010180 , 0 , 180 , possible_chr_type, once );
		else
			--SFXが消える --EN:--SFX disappear
			proxy:InvalidSfx( 2250 , false );--光の粒子 --EN:--Particles of light
			--proxy:InvalidSfx( 2251 , false );--要石のオーラ --EN:--Keystone Aura
			--▼要石でワープ用の監視を追加▼ --EN:--▼ Added surveillance for warp with keystone ▼
			SingleReset(proxy,6284);
			proxy:OnDistanceActionAttribute( 6284 , 10000 , 1981 , "OnEvent_6284" , WarpGimmickDist_A , HELPID_GO_TO_SEKITYUU , 0 , 180 , ATTR_NOSESSION , everytime );
		end
		
	else
		--▽ボス生きているとき --EN:--▽ When the boss is alive
	
		
		if proxy:IsCompleteEvent(522) == false then
			--proxy:SetDrawEnable( 811, false );
			InvalidCharactor( proxy,811 );
		end
		
		--ロジックOFFで待機 --EN:--Wait with logic OFF
		proxy:EnableLogic( 811 , false );
		
		--PT組んでない時は初期化します --EN:--Initialize when PT is not assembled
		SingleReset(proxy,6274);
		SingleReset(proxy,6275);			
		
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
		
		--宝(ソウル?) --EN:--Treasure (Soul?)
		proxy:SetDrawEnable( 1981 , false );
		proxy:SetColiEnable( 1981 , false );
		--ソウルに刺さった剣無効化 --EN:--Nullify the sword stuck in the soul
		proxy:SetDrawEnable( 1976 , false );
		proxy:SetColiEnable( 1976 , false );
	
		--SFXが消える --EN:--SFX disappear
		proxy:InvalidSfx( 2250 , false );--光の粒子 --EN:--Particles of light
		proxy:InvalidSfx( 2251 , false );--要石のオーラ --EN:--Keystone Aura

	end	
	
-----------------------------------------------------------------------------------------
--ギミック関連 --EN:--Gimmick related
-----------------------------------------------------------------------------------------
--■573■ハンドル回してフロア移動する■ --EN:-- ■ 573 ■ Rotate the handle to move to the floor ■
	proxy:SetIsAnimPauseOnRemoPlayForEvent(1243,true);
	proxy:OnPlayerActionInRegionAngle(573,2223,"OnEvent_573",60,HELPID_TURN_HANDLE,everytime);
	--フラグ同期用 --EN:--for flag synchronization
	proxy:LuaCall(573,1,"OnEvent_573_flag",everytime);
	--574がON＝エレベーターは下 --EN:--574 is ON = Elevator is down
	--PT時576,578に関してはとりあえず同期にまかせる --EN:--Regarding PT time 576, 578, leave it to synchronization for the time being
	if proxy:IsCompleteEvent(574) == true then
		proxy:EndAnimation(1243,1);
		if proxy:IsClient() == false then		
			proxy:SetEventFlag(576,false);
			proxy:SetEventFlag(578,true);
		end
	else
		if proxy:IsClient() == false then
			proxy:SetEventFlag(576,true);
			proxy:SetEventFlag(578,false);			
		end
	end

--■575■エレベーターを呼ぶハンドル■ --EN:-- ■ 575 ■ Handle to call the elevator ■
	proxy:OnDistanceAction(575,10000,1244,"OnEvent_575",1.5,HELPID_TURN_HANDLE,270,60,everytime);
--■577■エレベーターを呼ぶハンドル■ --EN:-- ■ 577 ■ Handle to call the elevator ■
	proxy:OnDistanceAction(577,10000,1245,"OnEvent_577",1.5,HELPID_TURN_HANDLE,270,60,everytime);

--■579■ダメージ床に入った■	 --EN:-- ■ 579 ■ Entered the damaged floor ■
	proxy:OnRegionJustIn(579,10000,2224,"OnEvent_579",everytime);
	
--■580■ダメージ床から出た■	 --EN:-- ■ 580 ■ Got out of the damaged floor ■
	proxy:OnRegionJustOut(580,10000,2224,"OnEvent_580",everytime);		

-- ボス部屋床にしっかりとしたアタリが無いため 一旦コメントアウト(動作確認済みです) --EN:-- Commented out once because there is no solid hit on the floor of the boss room (operation confirmed)
-- 復活（2008/10/24 北崎） --EN:-- Revival (2008/10/24 Kitazaki)

--■583■ボス部屋ダメージ床に入った■	 --EN:-- ■ 583 ■ Entered the boss room damage floor ■
	proxy:OnRegionJustIn(583,10000,2225,"OnEvent_583",everytime);

--■584■ボス部屋ダメージ床から出た■	 --EN:-- ■ 584 ■ Boss room damage Got out of the floor ■
	proxy:OnRegionJustOut(584,10000,2225,"OnEvent_584",everytime);		


--■585■はしご1降りる■ --EN:-- ■ 585 ■ Get off the ladder 1 ■
	proxy:OnActionEventRegion(585, 2226, "OnEvent_585", LadderAngle_A, HELPID_DOWN, everytime);
--■586■はしご1昇る■ --EN:-- ■ 586 ■ ladder 1 climb ■
	proxy:OnActionEventRegion(586, 2227, "OnEvent_586", LadderAngle_A, HELPID_UP,   everytime);

--■587■はしご2降りる■ --EN:-- ■ 587 ■ descend ladder 2 ■
	proxy:OnActionEventRegion(587, 2228, "OnEvent_587", LadderAngle_A, HELPID_DOWN, everytime);
--■588■はしご2昇る■ --EN:-- ■ 588 ■ Ladder 2 Climbs ■
	proxy:OnActionEventRegion(588, 2229, "OnEvent_588", LadderAngle_A, HELPID_UP,   everytime);

--■589■はしご3降りる■ --EN:-- ■ 589 ■ descend ladder 3 ■
	proxy:OnActionEventRegion(589, 2230, "OnEvent_589", LadderAngle_A, HELPID_DOWN, everytime);
--■590■はしご3昇る■ --EN:-- ■ 590 ■ Climb ladder 3 ■
	proxy:OnActionEventRegion(590, 2231, "OnEvent_590", LadderAngle_A, HELPID_UP,   everytime);

--■591■はしご4降りる■ --EN:-- ■ 591 ■ descend ladder 4 ■
	proxy:OnActionEventRegion(591, 2232, "OnEvent_591", LadderAngle_A, HELPID_DOWN, everytime);
--■592■はしご4昇る■ --EN:-- ■ 592 ■ Climb ladder 4 ■
	proxy:OnActionEventRegion(592, 2233, "OnEvent_592", LadderAngle_A, HELPID_UP,   everytime);


--■570■光の壁■ --EN:-- ■ 570 ■ Wall of light ■
--[[
	if proxy:IsCompleteEvent( 570 ) == false then
		proxy:OnDistanceActionAttribute( 570, 10000, 1240, "OnEvent_570", 1.5 , HELPID_GO_TO_IN , 180.0, 90.0 , ATTR_HOST + ATTR_LIVE + ATTR_GREY,everytime);				
		proxy:LuaCall(570,1,"OnEvent_570_delete_wall",once);
	else
		proxy:SetDrawEnable( 1240, false );--描画OFF --EN:--Drawing OFF
		proxy:SetColiEnable( 1240, false );--当たりOFF --EN:--Hit OFF
		--ただの再現なので自然な表現の必要が無い為、RootErase指定ではない --EN:--Since it is just a reproduction, there is no need for natural expression, so it is not RootErase specification
		proxy:InvalidSfx( 2220, false );		
	end]]
	
--■571■光の壁■ --EN:-- ■ 571 ■ Wall of Light ■
	if proxy:IsCompleteEvent( 571 ) == false then
		proxy:OnDistanceActionAttribute( 571, 10000, 1241, "OnEvent_571", 1.5 , HELPID_GO_TO_IN , 180.0, 90.0 , ATTR_HOST + ATTR_LIVE + ATTR_GREY,everytime);				
		proxy:LuaCall(571,1,"OnEvent_571_delete_wall",once);
	else
		proxy:SetDrawEnable( 1241, false );--描画OFF --EN:--Drawing OFF
		proxy:SetColiEnable( 1241, false );--当たりOFF --EN:--Hit OFF
		--ただの再現なので自然な表現の必要が無い為、RootErase指定ではない --EN:--Since it is just a reproduction, there is no need for natural expression, so it is not RootErase specification
		proxy:InvalidSfx( 2221, false );		
	end

--■572■光の壁■ --EN:-- ■ 572 ■ Wall of light ■
	if proxy:IsCompleteEvent( 572 ) == false then
		proxy:OnDistanceActionAttribute( 572, 10000, 1242, "OnEvent_572", 1.5 , HELPID_GO_TO_IN , 180.0, 90.0 , ATTR_HOST + ATTR_LIVE + ATTR_GREY,everytime);				
		proxy:LuaCall(572,1,"OnEvent_572_delete_wall",once);
	else
		proxy:SetDrawEnable( 1242, false );--描画OFF --EN:--Drawing OFF
		proxy:SetColiEnable( 1242, false );--当たりOFF --EN:--Hit OFF
		--ただの再現なので自然な表現の必要が無い為、RootErase指定ではない --EN:--Since it is just a reproduction, there is no need for natural expression, so it is not RootErase specification
		proxy:InvalidSfx( 2222, false );
		
		--571の光の壁も同時に消える(ショートカットしたため) --EN:-- 571's light wall also disappears at the same time (due to shortcut)
		proxy:SetDrawEnable( 1241, false );--描画OFF --EN:--Drawing OFF
		proxy:SetColiEnable( 1241, false );--当たりOFF --EN:--Hit OFF
		--ただの再現なので自然な表現の必要が無い為、RootErase指定ではない --EN:--Since it is just a reproduction, there is no need for natural expression, so it is not RootErase specification
		proxy:InvalidSfx( 2221, false );
	end

--■565■光の壁ショートカット■ --EN:-- ■ 565 ■ Light wall shortcut ■
	proxy:OnRegionJustIn( 565 , 10000 , 2210 , "OnEvent_565",once);
	
--■566■光の壁ショートカット■ --EN:-- ■ 566 ■ Light wall shortcut ■
	proxy:OnRegionJustIn( 566 , 10000 , 2211 , "OnEvent_566",once);
	
--■594■トカゲイベント移動■ --EN:-- ■ 594 ■ lizard event movement ■
	SingleReset( proxy , 594 );
	if proxy:IsCompleteEvent( 594 ) == false then
	
		proxy:EnableLogic( 321 , false );--トカゲAロジックOFF --EN:-- Lizard A logic OFF
		proxy:EnableLogic( 322 , false );--トカゲBロジックOFF --EN:-- Lizard B logic OFF
		
		--▼領域監視(トカゲイベント移動、発動のトリガー)▼ --EN:--▼ Area surveillance (lizard event movement, activation trigger) ▼
		proxy:OnRegionJustIn( 594 , 10000 , 2234 , "OnEvent_594" , once );
		
		--▼ダメージ監視(トカゲイベント移動、発動のトリガー)▼		 --EN:--▼Damage monitoring (lizard event movement, activation trigger)▼
		proxy:OnSimpleDamage( 595 , 321 , 10000 , "OnEvent_594" , once );--トカゲA		 --EN:-- Lizard A
		proxy:OnSimpleDamage( 595 , 322 , 10000 , "OnEvent_594" , once );--トカゲB --EN:-- Lizard B
		
	else		
		--proxy:Warp( 321 , 2237 );--対応する領域にワープ --EN:--Warp to corresponding area
		--proxy:ChangeInitPosAng( 321 , 2237 );--初期位置を変更 --EN:--Change initial position
		--proxy:Warp( 322 , 2237 );--対応する領域にワープ --EN:--Warp to corresponding area
		--proxy:ChangeInitPosAng( 322 , 2237 );--初期位置を変更 --EN:--Change initial position
		InvalidCharactor( proxy , 321 );--無効化 --EN:--Invalidation
		InvalidCharactor( proxy , 322 );--無効化		 --EN:--Invalidation
	end	
	

--[[イベントIDが振られてないので、今は放置--(作りかけだから無闇にコメントアウトはずさないように！) --EN:--[[Since the event ID is not assigned, leave it for now--(Because it is under construction, please do not unreasonably comment out!)
--■572■結晶トカゲ出現■QWCイベント --EN:-- ■ 572 ■ Crystal lizard appearance ■ QWC event
	if proxy:IsClient() == false then
		--62_300
		if proxy:GetQWC(0) >= QWC01_MIN and proxy:GetQWC(0) <= QWC01_MAX then
			proxy:SetEventFlag( 1234567, 1 );
		--62_301
		elseif proxy:GetQWC(1) >= QWC02_MIN and proxy:GetQWC(1) <= QWC02_MAX then
			proxy:SetEventFlag( 1234568, 1 );
		--62_302
		elseif proxy:GetQWC(2) >= QWC03_MIN and proxy:GetQWC(2) <= QWC02_MAX then
			proxy:SetEventFlag( 1234569, 1 );
		end
	end

	--62_300	
	if proxy:IsCompleteEvent(1234567) == true then
		local eneID;
		for eneID = 331, 335, 1 do
			proxy:SetDrawEnable( eneID, true );
			proxy:SetColiEnable( eneID, true );
			--proxy:EnableLogic( eneID, true );
		end
	--62_301
	elseif proxy:IsCompleteEvent(1234568) == true then
		local eneID;
		for eneID = 336, 337, 1 do
			proxy:SetDrawEnable( eneID, true );
			proxy:SetColiEnable( eneID, true );
			--proxy:EnableLogic( eneID, true );
		end
	--62_302
	elseif proxy:IsCompleteEvent(1234569) == true then
		local eneID;
		for eneID = 338, 342, 1 do
			proxy:SetDrawEnable( eneID, true );
			proxy:SetColiEnable( eneID, true );
			--proxy:EnableLogic( eneID, true );
		end
	end
]]
	
--■646■クマムシ倒した■ --EN:-- ■ 646 ■ tardigrade defeated ■
	if proxy:IsCompleteEvent( 646 ) == false then
		proxy:OnCharacterDead( 646, 323 , "OnEvent_646",once);
	else
		InvalidCharactor(proxy,323);--クマムシ無効化 --EN:--Disable tardigrade
		proxy:SetEventFlag( 607,true);
	end
	
--■607■クマムシトラップ■ --EN:-- ■ 607 ■ Water bear trap ■
	--クマムシまだ飛んでない --EN:--water bears haven't flown yet
	if proxy:IsCompleteEvent(607) == false then
		proxy:EnableLogic(323,false);
		--proxy:SetDeadMode(323,true);
		--proxy:OnRegionJustIn(607,10000,2258,"OnEvent_607",once);--下のOnEvent641などの中で監視を追加している	 --EN:--Adding monitoring in OnEvent641 etc. below
		--クマムシ到着 --EN:--Arrival of tardigrades
	else
		--print("すでにトラップは作動済み"); --EN:--print("Trap already activated");
		--InvalidCharactor(proxy,323);--クマムシ無効化 --EN:--Disable tardigrade
		proxy:EnableLogic(323,false);		
	end
	


--■525■ボス戦カメラ対応■ --EN:-- ■ 525 ■ Boss battle camera support ■
	--ボスが生きているなら登録 --EN:--Register if the boss is alive
	if proxy:IsCompleteEvent(6272) == false then
		proxy:NotNetMessage_begin();
			proxy:OnRegionIn( 525 , 10000 , 2886 ,"OnEvent_525" , everytime );
		proxy:NotNetMessage_end();
	end
	
--■8088■坑道に来たフラグを立てる■ --EN:--■ 8088 ■ Raise a flag for coming to the tunnel ■
	proxy:SetEventFlag(8088, true);
	
--■??■徘徊デーモンの登場■ハンドラ登録 --EN:--■??■Appearance of wandering daemon■Handler registration
	proxy:NotNetMessage_begin();
		--プレイヤーがソロで死亡した時にキックされます。 --EN:--Kicked when a player dies solo.
		proxy:LuaCall( 4000, 100, "PlayerDeath_m06_01_00_00", everytime );
		--プレイヤーが復活した時にキックされます。 --EN:--Kicked when the player is revived.
		proxy:LuaCall( 4032, 100, "PlayerRevive_m06_01_00_00", everytime );
	proxy:NotNetMessage_end();
	

-----------------------------------------------------------------------------------------
--NPC関連 --EN:--NPC related
-----------------------------------------------------------------------------------------
--------------------------------▽▽▽QWCイベント関連▽▽▽-------------------------------- --EN:--▽▽▽QWC event related ▽▽▽--------------------------------
--■680■QWCソウルモンスター■ --EN:-- ■ 680 ■ QWC Soul Monster ■
	if proxy:IsSuccessQWC(60100) == false then--成立していないならば --EN:--If not established
		print("ブラックゴースト無効化"); --EN:print("Disable Black Ghost");
		--350を無効化 --EN:disable --350
		InvalidCharactor(proxy, 360);
		--351を無効化 --EN:disable --351
		InvalidCharactor(proxy, 361);
		--352を無効化 --EN:disable --352
		InvalidCharactor(proxy, 362);
		
		proxy:SetEventFlag(680, true);
	end

--▼ハーフハンド関連▼----------------------------- --EN:--▼Related to half hand▼-----------------------------

--■644■QWCハーフハンド出現■ --EN:-- ■ 644 ■ QWC half hand appearance ■
	if proxy:IsSuccessQWC(60130) == false then	--QWCが成立していなければ --EN:--If QWC is not established
		print("QWCハーフハンド　未成立"); --EN:print("QWC half hand incomplete");
		--ハーフハンドを無効化 --EN:--disable half hand
		InvalidBackRead(proxy, 661);
		
		proxy:SetEventFlag(644, true);
	else
		print("QWCハーフハンド　成立"); --EN:print("QWC half hand established");
	end
	
--■15632■ハーフハンドの死体を調べた■ --EN:--■ 15632 ■ Examined half-handed corpse ■
	if proxy:IsCompleteEvent( 15632 ) == false then
		proxy:AddCorpseEvent( 15632 , 661 );
		proxy:NotNetMessage_begin();
			proxy:LuaCall( 15632 ,0 , "OnEvent_15632",once );
 		proxy:NotNetMessage_end();
	end


--■15604■ハーフハンド黒の死体を調べてない■ --EN:--■15604■Didn't examine half-hand black corpse■
	if proxy:IsCompleteEvent( 15604 ) == false then
		proxy:AddCorpseEvent( 15604 , 345 );
		proxy:NotNetMessage_begin();
			proxy:LuaCall( 15604 , 0 , "OnEvent_15604",once);
		proxy:NotNetMessage_end();
	end

--■675■QWCハーフハンド・ブラックゴースト死亡監視■ --EN:-- ■ 675 ■ QWC Half Hand Black Ghost Death Watch ■
	if proxy:IsCompleteEvent(675) == false then	--まだハーフハンドが死亡してないなら --EN:--if halfhand hasn't died yet
	   --ハーフハンド・ラックゴーストの死亡監視追加 --EN:-- Added death watch for half-handed and rack ghosts
		proxy:OnCharacterDead( 675, 345, "OnEvent_675", once );
	end
--■876■QWCハーフハンド・ブラックゴースト出現■ --EN:--■876■QWC half-hand black ghost appears■
	if proxy:IsCompleteEvent(675) == true or	--ハーフハンド・ブラックゴーストが死亡している　か  --EN:--Is Half-Hand Black Ghost dead?
	   proxy:IsSuccessQWC(60120) == false then	--QWCが成立していなければ --EN:--If QWC is not established
		print("QWCハーフハンド・ブラックゴースト　未成立"); --EN:print("QWC half hand black ghost unestablished");
		if 	proxy:IsCompleteEvent( 675 ) == true and 
			proxy:IsCompleteEvent( 15604 ) == false then
			--宝死体を再現 --EN:--Reproduce treasure corpse
			proxy:OpeningDeadPlus( 345 , true ,false ,false );			
		else
			--ハーフハンド・ブラックゴーストを無効化 --EN:--Disable Half Hand Black Ghost
			InvalidBackRead(proxy, 345);
		end		
		proxy:SetEventFlag(876, true);
	else
		print("QWCハーフハンド・ブラックゴースト　成立"); --EN:print("QWC half hand black ghost established");
	end
--------------------------------△△△QWCイベント関連△△△--------------------------------	 --EN:--△△△QWC event related△△△--------------------------------


--■603■ハーフハンド敵対■ --EN:-- ■ 603 ■ Half-handed hostility ■
	if proxy:IsCompleteEvent( 603 ) == false then
		--proxy:OnCharacterTotalDamage( 603, 661, 10000, HALF_TOTALDAMAGE, "OnEvent_603", once );
		proxy:OnCharacterTotalRateDamage( 603, 661, LOCAL_PLAYER, NPC_ANGRY_Rate, "OnEvent_603", once );
	end

--■604■ハーフハンド死亡■ --EN:-- ■ 604 ■ half hand death ■
	if proxy:IsCompleteEvent( 604 ) == false then
		proxy:OnCharacterDead( 604 , 661 , "OnEvent_604" , once );
	end

--■643■ハーフハンドからアイテム貰う■ --EN:-- ■ 643 ■ Receive items from Half Hand ■
	if proxy:IsCompleteEvent( 643 ) == false then
		proxy:NotNetMessage_begin();			
			proxy:LuaCall( 643 , 0,"OnEvent_643",once);
		proxy:NotNetMessage_end();
	end

--■ハーフハンド関連初期化 --EN:--■ Half-hand related initialization
	--PCのQWC値が一定値ならばハーフハンドの初期状態をセット --EN:--If the QWC value of the PC is a constant value, set the initial state of half hand
	--[[if proxy:GetQWC(0) == HALF_QWC01 and proxy:GetQWC(1) == HALF_QWC02 then
		--初期状態をセット(状態が未設定の場合、指定した状態をセットする)		 --EN:--Set the initial state (if the state is not set, set the specified state)
	end]]
	--初期化 --EN:--Initialization
	SetFirstNpcStateFlag( proxy , param , half_flag_list , HALF_STATE_WAIT_KOUDOU );
	print("ハーフハンドの初期化に成功！！"); --EN:print("Successfully initialized half hand!!");
		
	local now_state = GetNpcStateFlag( proxy , param , half_flag_list );

	--坑道で待つ --EN:--wait in the tunnel
	if now_state == HALF_STATE_WAIT_KOUDOU then	
		--proxy:EnableLogic( 661 , false );--ロジックOFF --EN:--Logic OFF
	
	--敵対(坑道) --EN:-- Hostility (Tunnel)
	elseif now_state == HALF_STATE_HOSTILE_KOUDOU then	
		--敵対設定 --EN:--Adversarial setting
		proxy:SetTeamType( 661, TEAM_TYPE_AngryFriend);
	
	--死亡 --EN:--death
	elseif now_state == HALF_STATE_DEAD then			
		if 	proxy:IsCompleteEvent( 15632 ) == false then
			--死体を再現する --EN:--reproduce the corpse
			proxy:OpeningDeadPlus( 661 , true ,false ,false );
		else
			print("ハーフハンド無効化"); --EN:print("halfhand disabled");
			--ハーフハンドを無効化 --EN:--disable half hand
			InvalidBackRead( proxy , 661 );--ハーフハンド無効化 --EN:--Half hand disabled
		end	
	--その他 --EN:--others
	else
		InvalidBackRead( proxy , 661 );--ハーフハンド無効化(このマップにいない) --EN:--Halfhand disabled (not on this map)
	end	
--▲ハーフハンド関連▲----------------------------- --EN:--▲Related to half hand▲-----------------------------


--▼バッチ関連▼------------------------------------ --EN:--▼ Batch-related ▼------------------------------------

--■616■バッチ敵対■ --EN:-- ■ 616 ■ batch hostility ■
	if proxy:IsCompleteEvent(616) == false then
		--proxy:OnCharacterTotalDamage( 616, 662, 10000, TOTALDAMAGE_BATTI,"OnEvent_616",once);
		proxy:OnCharacterTotalRateDamage( 616, 662, LOCAL_PLAYER, NPC_ANGRY_Rate, "OnEvent_616", once );		
	end
	
--■617■バッチ死亡■ --EN:--■617■Batch Death■
	if proxy:IsCompleteEvent(617) == false then
		proxy:OnCharacterDead(617,662,"OnEvent_617",once);
	end	

--■660■バッチアイテム受け渡し■ --EN:-- ■ 660 ■ Batch item delivery ■
	if proxy:IsCompleteEvent(660) == false then
		proxy:NotNetMessage_begin();
			proxy:LuaCall(660,0,"OnEvent_660",once);
		proxy:NotNetMessage_end();
	end	

--■612■バッチ宝のところへ移動■ --EN:--■612■Move to Batch Treasure■
	--バッチが宝の所へ向かう処理が行われていない --EN:--Batch is not being processed to go to the treasure
	if proxy:IsCompleteEvent(612) == false then
		proxy:EnableLogic(662,false);
	else
		--すでに移動してしまったか、バッチの状態が死亡や敵対などならば --EN:--if you have already moved or the batch status is dead, hostile, etc.
		--print("★★移動イベントは無効です★★"); --EN:--print("Movement events are disabled★★");
		InvalidBackRead(proxy,662);
	end

--■615■特殊宝箱■ --EN:-- ■ 615 ■ special treasure box ■
	if proxy:IsCompleteEvent(615) == false then
		local possible_chr_type = ATTR_HOST + ATTR_LIVE + ATTR_GREY;
		proxy:OnDistanceActionAttribute( 615 , 10000 , 1250 , "OnEvent_615" , ItemBoxDist_A , HELPID_CHECK_GLOWING_CORPS , 0 , ItemBoxAngle_A , possible_chr_type, once );		
		proxy:LuaCall(615,0,"OnEvent_615_2",once);
		--proxy:SetRarity(1250,10600);
		if proxy:IsClient() == false then
			proxy:TreasureDispModeChange2( 1250 , true ,99010);
		end
	else--すでに発動していたら --EN:--If already activated
		--print("★★すでに宝は無いよ★★") --EN:--print("There is no treasure already")
		proxy:LuaCall(615,0,"OnEvent_615_3",once);--バッチの状態を「残念」に変更 --EN:-- Change batch status to "Unfortunate"
	end

--■バッチ状態管理設定 --EN:--■ Batch status management settings
	--初期状態をセット(状態が未設定の場合、指定した状態をセットする) --EN:--Set the initial state (if the state is not set, set the specified state)
	SetFirstNpcStateFlag( proxy , param , batti_flag_list , BATTI_NOT_STAY );--BATTI_PUSHING--BATTI_NOT_STAY
	
	--現在の状態を取得 --EN:--get current state
	local now_state = GetNpcStateFlag( proxy , param , batti_flag_list );
	
	--残念 --EN:--disappointing
	if		now_state == BATTI_VEXING_M6 	then
		
	--宝は頂いた --EN:--Treasure received
	elseif	now_state == BATTI_TREASURE_M6 then
		--宝を渡したい為の初期化 --EN:--Initialization for wanting to give treasure
		--SetNpcStateFlag(proxy,param,batti_flag_list,BATTI_RESERVE_M1);--出撃準備中に --EN:--During sortie preparation
		--InvalidBackRead(proxy,662);--バッチはすでに石柱に行ったのでいない --EN:--Bach has already gone to the stone pillar, so no
		proxy:Warp( 323 , 2239 );--クマムシ着地地点へ --EN:--To the tardigrade landing site
		proxy:Warp( 662 , 2241 );--パッチ到着点へ --EN:--to patch destination
		proxy:EnableLogic(662,true);
		proxy:SetSpStayAndDamageAnimId(662,-1,-1);
	--アイテムを渡した --EN:--I handed over the item
	elseif now_state == BATTI_PRESENT then
		proxy:Warp( 323 , 2239 );--クマムシ着地地点へ --EN:--To the tardigrade landing site
		proxy:Warp( 662 , 2241 );--パッチ到着点へ --EN:--to patch destination
		proxy:EnableLogic(662,true);
		proxy:SetSpStayAndDamageAnimId(662,-1,-1);
		
	--クマムシ撃破 --EN:--Defeat Water Bear
	elseif now_state == BATTI_DESTORYKUMA then
		--SetNpcStateFlag(proxy,param,batti_flag_list,BATTI_RESERVE_M1);--出撃準備中に --EN:--During sortie preparation
		proxy:EnableLogic(662,true);
		proxy:SetSpStayAndDamageAnimId(662,-1,-1);
		--InvalidBackRead(proxy,662);--バッチはすでに石柱に行ったのでいない --EN:--Bach has already gone to the stone pillar, so no
	--敵対 --EN:--hostile
	elseif	now_state == BATTI_ANGRY_M6  then--坑道以外で敵対の場合、ここには居ないはずなので、判定は１つ --EN:--In the case of hostility outside of the tunnel, you shouldn't be here, so one decision is made.
		--print("if--■641■（バッチが敵対(砦、坑道、石柱)していた場合）■判定") --EN:-- ■ 641 ■ (If the batch is hostile (fort, tunnel, stone pillar)) ■ Judgment")
		
		proxy:OnRegionJustIn(641,10000,2260,"OnEvent_641",everytime);--バッチ移動は無効化して、クマムシトラップの監視を追加 --EN:--disabled batch movement and added monitoring for tardigrade traps
		
		proxy:EnableLogic(662,true);--ロジックをON --EN:--Logic ON
		proxy:SetTeamType(662, TEAM_TYPE_AngryFriend);--チームタイプ変更 --EN:--Change team type
		SetNpcStateFlag(proxy,param,batti_flag_list,BATTI_ANGRY_M6);--敵対状態に --EN:-- in hostile state
		
	--出撃準備--まだどこにもいない--罠にはめたい --EN:--Prepare to sortie--I'm not anywhere yet--I want to trap you
	elseif	now_state == BATTI_RESERVE_M1	or
			now_state == BATTI_NOT_STAY		or
			now_state == BATTI_TRAP_M6		then
		if proxy:IsCompleteEvent( 615 ) == false then
			--print("if--■642■（バッチが準備中の場合)■判定") --EN:-- ■ 642 ■ (If the batch is in preparation) ■ Judgment")
			proxy:SetEventFlag(642, false);--念のためにリセット --EN:--Reset just in case
			--SingleReset( proxy,642);
			--準備中だった場合のクマムシ処理 --EN:--Water bear treatment when preparing
			--SingleReset( proxy, 607 );
			proxy:OnRegionJustIn(642,10000,2260,"OnEvent_642",everytime);--条件を満たしたら「罠に嵌めたい」に変更して監視追加 --EN:--If the conditions are met, change to "I want to be trapped" and add monitoring
			
			proxy:OnRegionJustOut( 662,662,2257,"OnEvent_616",once);--罠にはめたい時だけ敵対追加 --EN:-- Add hostility only when you want to trap
			
			if proxy:IsCompleteEvent(645) == false then	
				--ホストだけが腕ふりの監視 --EN:--Only the host monitors arm movements
				if proxy:IsClient() == false then
					proxy:NotNetMessage_begin();
						proxy:OnRegionIn( 645,10000,2259 , "OnEvent_645",once);
					proxy:NotNetMessage_end();
				end
				proxy:LuaCall( 645 , 1 , "OnEvent_645_1",once);
			else
				proxy:SetSpStayAndDamageAnimId(662,-1,-1);
			end
		else
			InvalidCharactor( proxy , 662 );
			InvalidCharactor( proxy , 323 );
		end
	--死亡 --EN:--death
	elseif	now_state == BATTI_DEAD then
		--print("if--■641■バッチが死亡だった場合■判定") --EN:-- ■ 641 ■ If Batch is dead ■ Judgment")
		--無効化 --EN:--Invalidation
		InvalidBackRead(proxy,662);--バッチは死んでいる --EN:--batch is dead
		--死亡していた場合のクマムシ処理 --EN:--Treatment of dead tardigrades
		proxy:OnRegionJustIn(641,10000,2260,"OnEvent_641",everytime);--バッチは無効化して、クマムシトラップの監視を追加 --EN:--Batch disabled and added monitoring for tardigrade traps
		
	--古砦の状態 --EN:-- Old fort condition
	elseif	now_state == BATTI_COME		or
			now_state == BATTI_PUSHING	then
		--print("if--■640■(バッチが来てほしいか突き落としたいか、まだどこにもいない場合)■判定"); --EN:--■ 640 ■ (If you want the batch to come or you want to drop it, if it is not there yet) ■ Judgment");
		--無効化 --EN:--Invalidation
		InvalidBackRead(proxy,662);--バッチ --EN:--batch
		InvalidCharactor(proxy,323);--クマムシ無効化 --EN:--Disable tardigrade
		--古砦にいる場合とまだ居ない場合のクマムシ処理 --EN:--Treatment of tardigrades when they are in the old fort and when they are not yet
		proxy:OnRegionJustIn(640,10000,2260,"OnEvent_640",everytime);--トラップも移動イベントも無効 --EN:--Traps and movement events are disabled
		
	--それ以外 --EN:--other than that
	else 
		--print("if--■640■バッチが上記以外だった場合■判定") --EN:-- ■ 640 ■ If the batch is other than the above ■ Judgment ")
		--どれにも当てはまらない時の処理 --EN:--Processing when none of the above applies
		proxy:OnRegionJustIn(640,10000,2260,"OnEvent_640",everytime);--トラップ[]移動イベント --EN:--trap[] move event
		InvalidBackRead(proxy,662);--どれにも当てはまらないという事は、ここには居ない為 --EN:--If it doesn't apply to any of them, it's because I'm not here
		InvalidCharactor(proxy,323);--クマムシ無効化 --EN:--Disable tardigrade
	end
--▲バッチ関連▲------------------------------------------ --EN:--▲ Batch related ▲------------------------------------------


--▼乞食ショップ関連▼------------------------------------ --EN:--▼ related to beggar shop ▼-----------------------------------
	--m06_01_00_00にて、まとめて記述 --EN:-- Described collectively in m06_01_00_00
--▲乞食ショップ関連▲------------------------------------------ --EN:--▲ Beggar shop related ▲------------------------------------------

	--トロッコ破壊 --EN:-- Minor Destruction
	SingleReset( proxy,696 );
	if proxy:IsCompleteEvent( 696 ) == false then
		proxy:RestorePiece( 1290 );
		--proxy:OnObjectDestroy( 696 , 1290 , "OnEvent_696", once );
		proxy:OnSimpleDamage( 696, 1290, 400 , "OnEvent_696",once);
	else
		--破壊再現は保留 --EN:--destruction reproduction pending
		--proxy:ReconstructBreak( 1290 , 1 );
	end
	
	--トロッコトラップ	 --EN:--Trolley Trap
	SingleReset( proxy,690 );
	SingleReset( proxy,900 );
	--SingleReset( proxy,901 );
	if proxy:IsCompleteEvent( 690 ) == false then
		proxy:OnRegionIn( 690 , 10000 , 2271 , "OnEvent_690" , once);
	else
		if proxy:IsDestroyed( 1290 ) == false then
			--トロッコのアニメ終了フレームに設定 --EN:-- Set to the ending frame of the truck animation
			proxy:EndAnimation( 1290 , 1 );	
		end
	end
	
	--ウィルオウィスプ発動 --EN:--Will O'Wisp activated
	SingleReset( proxy,691 );
	if proxy:IsCompleteEvent( 691 ) == false then
		--proxy:OnPlayerDistanceInTarget( 691 , 10000 , 1290 , "OnEvent_691", 3.0 , once);
		proxy:OnNetDistanceIn(691,1290,4.0,"OnEvent_691");
		proxy:SetObjSfx( 1290 , 1 , 96001 , true );
	else
		--何か再現が必要なら --EN:-- if you need to reproduce something
	end	
	
	
	--トロッコ破壊 --EN:-- Minor Destruction
	SingleReset( proxy,697 );
	if proxy:IsCompleteEvent( 697 ) == false then
		proxy:RestorePiece( 1291 );
		--proxy:OnObjectDestroy( 697 , 1291 , "OnEvent_697", once );
		proxy:OnSimpleDamage( 697, 1291, 400 , "OnEvent_697",once);
	else
		--破壊再現は保留 --EN:--destruction reproduction pending
		--proxy:ReconstructBreak( 1291 , 1 );
	end

	--トロッコトラップ --EN:--Trolley Trap
	SingleReset( proxy,692 );
	SingleReset( proxy,902 );	
	--SingleReset( proxy,903 );
	if proxy:IsCompleteEvent( 692 ) == false then
		proxy:OnRegionIn( 692 , 10000 , 2272 , "OnEvent_692" , once);
	else
		if proxy:IsDestroyed( 1291 ) == false then
			--トロッコのアニメ終了フレームに設定 --EN:-- Set to the ending frame of the truck animation
			proxy:EndAnimation( 1291 , 1 );		
		end
	end
	
	--ウィルオウィスプ発動 --EN:--Will O'Wisp activated
	SingleReset( proxy,693 );
	if proxy:IsCompleteEvent( 693 ) == false then
		--proxy:OnPlayerDistanceInTarget( 693 , 10000 , 1291 , "OnEvent_693", 3.0 , once);
		proxy:OnNetDistanceIn(693,1291,4.0,"OnEvent_693");
		proxy:SetObjSfx( 1291 , 1 , 96001 , true );
	else
		--何か再現が必要なら --EN:-- if you need to reproduce something
	end	
	
	
	--トロッコ破壊 --EN:-- Minor Destruction
	SingleReset( proxy,698 );
	if proxy:IsCompleteEvent( 698 ) == false then
		proxy:RestorePiece( 1292 );
		--proxy:OnObjectDestroy( 698 , 1292 , "OnEvent_698", once );
		proxy:OnSimpleDamage( 698, 1292, 400 , "OnEvent_698",once);
	else
		--破壊再現は保留 --EN:--destruction reproduction pending
		--proxy:ReconstructBreak( 1292 , 1 );
	end
	
	--トロッコトラップ --EN:--Trolley Trap
	SingleReset( proxy,694 );
	SingleReset( proxy,904 );
	--SingleReset( proxy,905 );
	if proxy:IsCompleteEvent( 694 ) == false then
		proxy:OnRegionIn( 694 , 10000 , 2273 , "OnEvent_694" , once);
	else
		if proxy:IsDestroyed( 1292 ) == false then
			--トロッコのアニメ終了フレームに設定 --EN:-- Set to the ending frame of the truck animation
			proxy:EndAnimation( 1292 , 1 );
		end
	end
	
	--ウィルオウィスプ発動 --EN:--Will O'Wisp activated
	SingleReset( proxy,695 );
	if proxy:IsCompleteEvent( 695 ) == false then
		--proxy:OnPlayerDistanceInTarget( 695 , 10000 , 1292 , "OnEvent_695", 3.0 , once);
		proxy:OnNetDistanceIn(695,1292,4.0,"OnEvent_695");
		proxy:SetObjSfx( 1292 , 1 , 96001 , true );
	else
		--何か再現が必要なら --EN:-- if you need to reproduce something
	end	

	--■710■宝死体トラップ1■ --EN:-- ■ 710 ■ treasure corpse trap 1 ■
	if proxy:IsCompleteEvent( 700 ) == false then
		proxy:AddTreasureEvent( 700 , 10782 );
		proxy:NotNetMessage_begin();
			proxy:LuaCall( 700 , 0 , "OnEvent_700",once);
		proxy:NotNetMessage_end();
		--配信用 --EN:--For delivery
		proxy:LuaCall( 700 , 10 , "OnEvent_700_1",once);
		if proxy:IsAlive( 330 ) == true then
			proxy:PlayLoopAnimation( 330 , 9000);
			proxy:EnableLogic( 330 , false );
			InvalidCharactor( proxy , 330 );
		end
	else
	end
	
	--■711■宝死体トラップ2■ --EN:-- ■ 711 ■ treasure corpse trap 2 ■
	if proxy:IsCompleteEvent( 701 ) == false then
		proxy:AddTreasureEvent( 701 , 10786 );
		proxy:NotNetMessage_begin();
			proxy:LuaCall( 701 , 0 , "OnEvent_701",once);
		proxy:NotNetMessage_end();
		--配信用 --EN:--For delivery
		proxy:LuaCall( 701 , 10 , "OnEvent_701_1",once);
		if proxy:IsAlive( 415 ) == true then
			proxy:PlayLoopAnimation( 415 , 9000);
			proxy:EnableLogic( 415 , false );
			InvalidCharactor( proxy , 415 );
		end
	else
	end
	
	--■720■トカゲポイント移動2■ --EN:-- ■ 720 ■ Lizard point movement 2 ■
	if proxy:IsCompleteEvent( 786 ) == false then
		SingleReset( proxy , 720 );
		SingleReset( proxy , 723 );
		if proxy:IsCompleteEvent( 720 ) == false then
			proxy:EnableLogic( 416 ,false );
			
			--▼領域監視(トカゲイベント移動、発動のトリガー)▼ --EN:--▼ Area surveillance (lizard event movement, activation trigger) ▼
			proxy:OnRegionJustIn( 720 , 10000 , 2262 , "OnEvent_720" , once );		
			--▼ダメージ監視(トカゲイベント移動、発動のトリガー)▼ --EN:--▼Damage monitoring (lizard event movement, activation trigger)▼
			proxy:OnSimpleDamage( 721 , 416 , 10000 , "OnEvent_720" , once );--トカゲA --EN:-- Lizard A
		else
			--proxy:Warp( 416 , 2265 );--対応する領域にワープ --EN:--Warp to corresponding area
			--proxy:ChangeInitPosAng( 416 , 2265 );--初期位置を変更		 --EN:--Change initial position
			InvalidCharactor( proxy , 416 );--無効化 --EN:--Invalidation
		end
	end
	
	--■725■トカゲポイント移動3■ --EN:-- ■ 725 ■ Lizard point movement 3 ■
	if proxy:IsCompleteEvent( 788 ) == false then
		SingleReset( proxy, 725 );
		if proxy:IsCompleteEvent( 725 ) == false then
			proxy:EnableLogic(417,false );
			
			--▼領域監視(トカゲイベント移動、発動のトリガー)▼ --EN:--▼ Area surveillance (lizard event movement, activation trigger) ▼
			proxy:OnRegionJustIn( 725 , 10000 , 2266 , "OnEvent_725" , once );		
			--▼ダメージ監視(トカゲイベント移動、発動のトリガー)▼ --EN:--▼Damage monitoring (lizard event movement, activation trigger)▼
			proxy:OnSimpleDamage( 726 , 417 , 10000 , "OnEvent_725" , once );--トカゲA --EN:-- Lizard A
		else
			--proxy:Warp( 417 , 2268 );--対応する領域にワープ --EN:--Warp to corresponding area
			--proxy:ChangeInitPosAng( 417 , 2268 );--初期位置を変更			 --EN:--Change initial position
			InvalidCharactor( proxy , 417 );--無効化 --EN:--Invalidation
		end
	end
	

	
	--■730～734■天然ウィルオウィスプ爆発■ --EN:--■730～734■Natural Will-O-Wisp Explosion■
	
	local WISP_list = {WISP1_DIST,WISP2_DIST,WISP3_DIST,WISP4_DIST,WISP5_DIST};
	
	local index = 0;
	local actionId = 730;
	local num = table.getn(WISP_list);
	local targetId = 1300;
	
	for index=1 , num , 1 do
		SingleReset( proxy,actionId);
		if proxy:IsCompleteEvent( actionId ) == false then
			print("天然ウィルオウィスプ 追加",targetId); --EN:print("Add Natural Willow Wisp",targetId);
			proxy:OnPlayerDistanceInTarget( actionId, 10000 , targetId,"OnEvent_"..actionId,WISP_list[index],once);
			proxy:SetObjSfx( targetId, 1 ,96001 , true );
		end
		actionId = actionId+1;
		targetId = targetId+1;
	end
	
	--■702■獄吏が追ってくる■ --EN:-- ■ 702 ■ prison guards are chasing ■
	SingleReset(proxy,702);
	--[[
	if proxy:IsCompleteEvent( 702 ) == false then
		proxy:OnRegionIn( 702 , 10000 , 2276 , "OnEvent_702",once);
	end	
	]]
	
--■800■蛮族１■ --EN:-- ■ 800 ■ Barbarian 1 ■
	if proxy:IsCompleteEvent( 800 ) == false then
		proxy:OnCharacterDead( 800 , 500 , "OnEvent_800",once);
	else
		InvalidCharactor( proxy, 500 );
	end
	
--■802■蛮族２■ --EN:-- ■ 802 ■ Barbarian 2 ■
	if proxy:IsCompleteEvent( 802 ) == false then
		proxy:OnCharacterDead( 802 , 501 , "OnEvent_802",once);
	else
		InvalidCharactor( proxy, 501 );
	end


--岩ミミズ弱点部位登録 --EN:--Registration of rock earthworm weak points
	local actidlist = {810,811,812,813,814,815,816,817,818,819,820,821,822,823,824};
	local eneidlist = {300,324,325,326,327,328,329,330,331,332,333,334,335,336,415};
	
	local num = table.getn( actidlist );
	for index=1 , num , 1 do
		RegistRockWorm( proxy, actidlist[index] , eneidlist[index] );
	end
	


--■15500■乱入アイテム取得監視■ハンドラはグローバルに定義 --EN:-- ■ 15500 ■ Intrusion item acquisition monitoring ■ Handlers are defined globally
	if proxy:IsCompleteEvent( 15500 ) == false then
--~ 		proxy:AddCorpseEvent( 15500 , 345 );--ハーフハンド・ブラック --EN:--Halfhand Black
		proxy:AddCorpseEvent( 15500 , 500 );--通常・ブラック --EN:--Normal/Black
		proxy:AddCorpseEvent( 15500 , 501 );--通常・ブラック --EN:--Normal/Black
	end


	--■999999■フレーム遅れの初期化処理イベントを発行■ --EN:-- ■ 999999 ■ Generate a frame delay initialization processing event ■
	proxy:NotNetMessage_begin();
		--▼0秒後▼-- --EN:--▼After 0 seconds▼--
		proxy:OnKeyTime2( 999991, "Second_Initialize_m06_01_00_00", 0.1, 0, 0, once );	
	proxy:NotNetMessage_end();	
	
	print("Initialize_m06_01_00_00 end");
end


--------------------------------------------------------------------------------------
--Initializeから呼ばれる、1フレーム遅れの初期化処理■999999 --EN:--Initialization with a delay of 1 frame, called from Initialize ■999999
--------------------------------------------------------------------------------------
--■999999■一部、Initでは処理できないので、残しておく --EN:-- ■ 999999 ■ Some parts cannot be processed by Init, so leave them
function Second_Initialize_m06_01_00_00(proxy, param)
	print("Second_Initialize_m06_01_00_00 begin");

--------------------------------▽▽▽QWCイベント関連▽▽▽-------------------------------- --EN:--▽▽▽QWC event related ▽▽▽--------------------------------
--------------------------------△△△QWCイベント関連△△△-------------------------------- --EN:--△△△QWC event related△△△--------------------------------

--■540■岩ミミズ登場■ --EN:-- ■ 540 ■ rock worm appears ■
	SingleReset(proxy,540);
	if proxy:IsCompleteEvent(540) ==false then
		if proxy:IsAlive( 300 ) == true then
			proxy:OnPlayerDistanceAngleInTarget( 540, 10000, 300, "OnEvent_540", PROTROCKWORM_DIST, 180.0, once );		
			proxy:EnableLogic( 300, false );
			proxy:PlayLoopAnimation( 300, 9000 );
			InvalidCharactor(proxy, 300);
		end
	end


	--■620～626■岩ミミズ出現■ --EN:-- ■ 620～626 ■ rock worms appear ■
	--反応距離 --EN:--reaction distance
	local worm_list = {
		ROCKWORM1_DIST,
		ROCKWORM2_DIST,
		ROCKWORM3_DIST,
		ROCKWORM4_DIST,
		ROCKWORM5_DIST,
		ROCKWORM6_DIST
		--[[,
		ROCKWORM7_DIST]]
	};
	local index = 0;
	local num = table.getn(worm_list);
	local eventID = 620;
	local targetID = 324;

	for index=1 , num, 1 do	
		SingleReset(proxy,eventID);
		if proxy:IsCompleteEvent(eventID) == false then
			if proxy:IsAlive( targetID ) == true then
				print("AddWormEvent eve:",eventID," target:",targetID);
				proxy:OnPlayerDistanceInTarget( eventID , 10000, targetID, "OnEvent_"..eventID, worm_list[index] , once);
				proxy:EnableLogic( targetID, false );
				proxy:PlayLoopAnimation( targetID, 9000 );
				InvalidCharactor(proxy, targetID);
			end
		end
		eventID = eventID + 1;
		targetID = targetID +1;		
	end
	
	--■541～547■岩石ミミズ登場■ --EN:--■541～547■Rock earthworms appear■
	
	local index = 0;	
	local eventID = 541;	
	local targetID = 331;
	local num = 6

	for index=1 , num, 1 do	
		SingleReset(proxy,eventID);
		if proxy:IsCompleteEvent(eventID) == false then
			if proxy:IsAlive( targetID ) == true then
				print("AddWormEvent eve:",eventID," target:",targetID);
				proxy:OnPlayerDistanceInTarget( eventID , 10000, targetID, "OnEvent_"..eventID, 5.0 , once);
				proxy:EnableLogic( targetID, false );
				proxy:PlayLoopAnimation( targetID, 9000 );
				InvalidCharactor(proxy, targetID);
			end
		end
		eventID = eventID + 1;
		targetID = targetID +1;		
	end
	print("Second_Initialize_m06_01_00_00 end");
end

--------------------------------------------------------------------------------------
--■6284■石柱にワープ■ --EN:-- ■ 6284 ■ Warp to the stone pillar ■
--------------------------------------------------------------------------------------
function OnEvent_6284(proxy,param)	
	print("OnEvent_6284 begin");
	
	if proxy:IsCompleteEvent( 6284 ) == true then
		return;
	end
	
	proxy:RepeatMessage_begin();
		--▼_1▼選択メニューの監視▼ --EN:--▼_1▼Select menu monitoring▼
		proxy:OnSelectMenu(6284, "OnEvent_6284_1", 10010710, 0, 2, 1981, 2, once);			
	proxy:RepeatMessage_end();
	
	print("OnEvent_6284 end");
end

--▲6284_1▲選択メニューの監視▲ --EN:--▲6284_1▲Monitor selection menu▲
function OnEvent_6284_1(proxy,param)	
	print("OnEvent_6284_1 begin");
	
	if proxy:IsSession() == false then
		proxy:PlayAnimation(10000,8283);
		proxy:NoAnimeTurnCharactor( 10000 , 1981 ,TURNSKIP_ANGLE);
		
		proxy:NotNetMessage_begin();
			proxy:OnChrAnimEnd( 6284 , 10000 , 8283 , "OnEvent_6284_2",once);
		proxy:NotNetMessage_end();
		
		proxy:SetEventFlag(6284,true);
	else
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010720, 0, 6, 1983, GEN_DIALOG_DIST, once );
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
	end
	
	print("OnEvent_6284_1 end");
end

--▲6284_2▲選択メニューの監視▲ --EN:--▲6284_2▲Monitor selection menu▲
function OnEvent_6284_2(proxy,param)	
	print("OnEvent_6284_2 begin");
	
	proxy:SetEventFlag(6284,false);
	
	proxy:PlayAnimation(10000,8284);
	
	proxy:SetEventFlag(6284,true);
	
	OnEvent_512(proxy, param);
	
	print("OnEvent_6284_2 end");
end

--------------------------------------------------------------------------------------
--■512■石柱にワープ■ --EN:-- ■ 512 ■ Warp to the stone pillar ■
--------------------------------------------------------------------------------------
--■512■石柱にワープ■ --EN:-- ■ 512 ■ Warp to the stone pillar ■
function OnEvent_512(proxy,param)	
	print("OnEvent_512 begin");
	
	--石柱へ戻ってきた判定のフラグを立てる --EN:--Flag the judgment of returning to the stone pillar
	proxy:SetEventFlag(8083, true);
	
	proxy:SetEventFlag(6284,false);
	--完全回復要求 --EN:-- full recovery request
	proxy:RequestFullRecover();
	proxy:WarpNextStage( 1, 0, 0, 0, 1010 );
	
	print("OnEvent_512 end");
end

--------------------------------------------------------------------------------------
--■522■ボス初動ポリ劇■ --EN:-- ■ 522 ■ Boss initial action poly play ■
--------------------------------------------------------------------------------------
--■522■ボス初動ポリ劇■ --EN:-- ■ 522 ■ Boss initial action poly play ■
function OnEvent_522(proxy, param)
	print("OnEvent_522 begin");
	proxy:RequestRemo(60100,REMO_FLAG,522,1);
	proxy:SetEventFlag(522,true);
	print("OnEvent_522 end");
end

function OnEvent_522_RemoStart(proxy,param)
	print("OnEvent_522_RemoStart begin");	
	print("OnEvent_522_RemoStart end");
end

function OnEvent_522_RemoFinish(proxy,param)
	print("OnEvent_522_RemoFinish begin");	
	ValidCharactor( proxy, 811 );
	
	proxy:SetColiEnable( 1280, false );
	proxy:SetDrawEnable( 1280, false );
	
	proxy:SetColiEnable( 1281, true );
	proxy:SetDrawEnable( 1281, true );
	
	--ポリ劇終了した事を通知するフラグON --EN:--Flag ON to notify that the police play has ended
	proxy:SetEventFlag( 524 , true );
	print("OnEvent_522_RemoFinish end");
end


--------------------------------------------------------------------------------------
--■540■岩ミミズ■ --EN:-- ■ 540 ■ rock earthworm ■
--------------------------------------------------------------------------------------
function OnEvent_540(proxy,param)
print("OnEvent_540 begin");
	ValidCharactor( proxy, 300 );
	proxy:StopLoopAnimation( 300 );
	proxy:ForcePlayAnimation( 300, 9010 );
	proxy:EnableLogic( 300, true );	
	proxy:SetEventFlag( 540 , true );		
print("OnEvent_540 end");
end


--------------------------------------------------------------------------------------
--ボス部屋の中に入る(二匹目)■520 --EN:--Enter the boss room (second one) 520
--------------------------------------------------------------------------------------

--■イベントがループなので、全部リピートにする↓ --EN:--■ Since the event is a loop, repeat all ↓

--■520■中ボス部屋への扉が開く■ --EN:-- ■ 520 ■ The door to the mid-boss room opens ■
function OnEvent_520(proxy,param)
	print("OnEvent_520 begin");
	
	if proxy:IsCompleteEvent( SYSTEM_ID_IGNORE ) == true then
		print("OnEvent_520 end");
		return;
	end
	
	--クライアントへ、ボス部屋阻止失敗を通知 --EN:--Notify client of failure to block boss room
	if proxy:IsClient() == false then
		proxy:LuaCallStart( 4068 , 1 );	
	end
	
	proxy:LuaCallStart( 521, 1 );--旋回アニメの同期再生 --EN:-- Synchronous playback of turning animation
	--proxy:SetEventFlag( SYSTEM_ID_IGNORE, true );
	--多重起動システムIDをタイムアウトを設定してONにする --EN:--Turn on multiple activation system ID by setting timeout
	proxy:SetSystemIgnore( SYSTEM_ID_IGNORE , IGNORE_TIME );
	
	--プロファイルセーブ要求 --EN:--profile save request
	proxy:SaveRequest_Profile();
	
	print("OnEvent_520 end");
end


--旋回アニメの同期再生(IDが別) --EN:-- Synchronized playback of turning animation (ID is different)
function OnEvent_521_1(proxy,param)
	print("OnEvent_521_1 begin");
	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		if param:IsNetMessage() == true then
			--旋回アニメ再生を行い、その終了時にOnEvent_521_2を発行する --EN:--Play the turning animation and issue OnEvent_521_2 at the end
			proxy:TurnCharactor( 10001 + param:GetPlayID(), 2890 );
		else
			proxy:LockSession();--ルームをロックします！ --EN:--lock the room!
			--旋回アニメ再生を行い、その終了時にOnEvent_521_2を発行する --EN:--Play the turning animation and issue OnEvent_521_2 at the end
			proxy:OnTurnCharactorEnd( 521, 10000, 2890, "OnEvent_521_2", once );
		end
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
		
	print("OnEvent_521_1 end");
end

--旋回アニメの同期再生終了後 --EN:--After synchronous playback of turning animation ends
function OnEvent_521_2(proxy,param)
	print("OnEvent_521_2 begin");
	
	--同期用歩きアニメ再生 --EN:--Play walking animation for synchronization
	proxy:LuaCallStart( 4012, 1 );
	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		proxy:OnChrAnimEnd( 521, 10000, ANIMEID_WALK, "OnEvent_521_3", once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
		
	print("OnEvent_521_2 end");
end

--歩きアニメの同期再生終了後 --EN:--After the synchronized playback of the walking animation ends
function OnEvent_521_3(proxy,param)
	print("OnEvent_521_3 begin");

	--最初の人がボス部屋の中に入り終わっていたら、既に配信されているはずなので、もうおくらないハンドラ --EN:--If the first person has already entered the boss room, it should have already been delivered, so no more handlers
	if proxy:IsCompleteEvent( 520 ) == false then
		proxy:LuaCallStart( 521 , 5 );--2回目以降にボス部屋に入るためのイベント配信用 --EN:--For event delivery to enter the boss room after the second time
		proxy:LuaCallStart( 4045 , 1 );	--クライアントへ、ボス部屋に入れるようになったことを通知 --EN:--Notify clients that they can now enter the boss room
		proxy:LuaCallStart( 521 , 6 );--フラグセット(同期用) --EN:--flag set (for synchronization)
		Lua_MultiDoping(proxy,811);--マルチプレイドーピング --EN:-- Multiplayer Doping
	end

	--プレイヤーが扉の中に完全にはいったタイミングで、ボスの思考をリセット --EN:--Reset the boss' thoughts when the player is completely inside the door
	--場所が悪いとプレイヤーを見つけれないため(攻撃してこない) --EN:--Because you can't find the player if the location is bad (they won't attack)
	if proxy:IsLivePlayer() == true or proxy:IsGreyGhost() == true then
		proxy:ResetThink( 811 );
	end
		
	proxy:SetEventFlag( SYSTEM_ID_IGNORE, false );
	
	print("OnEvent_521_3 end");
end


--■520 2回目以降にボス部屋に入るためのイベント配信用 --EN:--■ 520 For event delivery to enter the boss room after the second time
function OnEvent_520_GO_TO_IN(proxy, param)
	print("OnEvent_520_GO_TO_IN begin");
	
	proxy:NotNetMessage_begin();
		--▼521▼扉が開いているときに中に入るためのイベントを追加▼--ハンドラは OnEvent_520 --EN:--▼521▼Add an event to enter when the door is open▼--The handler is OnEvent_520
		proxy:OnPlayerActionInRegion( 521, 2894, "OnEvent_520", HELPID_GO_TO_IN, everytime );--
	proxy:NotNetMessage_end();	
	
	print("OnEvent_520_GO_TO_IN end");
end


--■520 フラグセット(同期用) --EN:-- 520 flag set (for synchronization)
function OnEvent_520_flag_set(proxy, param)
	print("OnEvent_520_flag_set begin");
		
	proxy:SetEventFlag( 520 , 1 );
	proxy:DeleteEvent( 520 );

	print("OnEvent_520_flag_set end");
end



--------------------------------------------------------------------------------------
--ボスが動き出す(戦闘開始 二匹目)■523 --EN:--Boss starts to move (Battle starts 2nd one) 523
--------------------------------------------------------------------------------------

function OnEvent_523(proxy, param)
	if proxy:IsCompleteEvent( 524 ) == false then
		return;
	end
	print("OnEvent_523 begin");
	
	--ボス戦用BGM再生開始	 --EN:--Start playing BGM for boss battle
	proxy:PlayPointSE( 2244, SOUND_TYPE_M, 60100000, 1 );
	
	--ボスロジックON --EN:--Boss logic ON
	proxy:EnableLogic( 811 , true );
	
	--フラグON --EN:--Flag ON
	proxy:SetEventFlag( 523 ,true );
	
	--ボスゲージ表示 --EN:-- Boss gauge display
	proxy:SetBossGauge(811, 0, 4050);	
	
	--監視の削除 --EN:--remove watch
	proxy:DeleteEvent( 523 );
	
	print("OnEvent_523 end");
end


--------------------------------------------------------------------------------------
--■6272■中ボス死亡(二匹目)■ --EN:-- ■ 6272 ■ Mid-boss died (2nd one) ■
--------------------------------------------------------------------------------------
--■6272■中ボス死亡■ --EN:-- ■ 6272 ■ Mid-boss death ■
function OnEvent_6272(proxy,param)	
	print("OnEvent_6272 begin");

	proxy:NotNetMessage_begin();
		--▼6272_1▼1秒後▼ --EN:--▼6272_1▼After 1 second▼
		proxy:OnKeyTime2( 6272 , "OnEvent_6272_1" , 1.0 , 0 , 1 , once );
		--▼6272_2▼2秒後▼ --EN:--▼6272_2▼After 2 seconds▼
		proxy:OnKeyTime2( 4992 , "OnEvent_6272_2" , 2.0 , 0 , 1 , once );
		--マルチ解散監視 --EN:--Multi-Dismissal Monitoring
		proxy:OnRegistFunc( 6272, "Check_6272_PT","OnEvent_6272_PT",0,once);
	proxy:NotNetMessage_end();
	
	proxy:SetEventFlag( 6272 , 1 );
	
	--炎怪人後始末 --EN:--Fire monster aftermath
	FireMan_Dead(proxy,param);

	--新ブロッククリア処理へ --EN:--To new block clear processing
	proxy:CustomLuaCallStart( 4050, 811);
	--トカゲリセット --EN:-- lizard reset
	ResetTokage(proxy);
	
	print("OnEvent_6272 end");
end

--▲6272_1▲1秒後▲ --EN:--▲6272_1▲After 1 second▲
function OnEvent_6272_1(proxy,param)
	print("OnEvent_6272_1 begin");
	
	--ボスを倒した数を更新(数によってフラグを立てる) --EN:--update number of bosses killed (flag by number)
	GetBossFlagCount( proxy, param );
	
	--▼トロフィー取得判定▼ --EN:--▼Trophy Acquisition Judgment▼
	Lua_RequestUnlockTrophy(proxy, 37);--トロフィ条件を判定し、取得 --EN:--Determine and acquire trophy conditions
	
	--ホストプレイヤーのみアイテム入手イベントに使用 --EN:--Used for item acquisition event only for host players
	local possible_chr_type = ATTR_HOST + ATTR_LIVE + ATTR_GREY;

	--宝死体(ソウル?)有効化 --EN:--Treasure corpse (soul?) activation
	proxy:SetDrawEnable( 1981 , true );
	proxy:SetColiEnable( 1981 , true );
	--ソウルに刺さった剣有効化 --EN:--Activation of the sword stuck in the soul
	proxy:SetDrawEnable( 1976 , true );
	proxy:SetColiEnable( 1976 , true );
	
	--▼(ソウル)アイテム取得用イベント監視追加▼ --EN:--▼ (Soul) Added event monitoring for item acquisition▼
	if proxy:IsCompleteEvent( 6283 ) == false then
		--SFX ON
		proxy:ValidSfx( 2250 );--光の粒子 --EN:--Particles of light
		proxy:ValidSfx( 2251 );--要石のオーラ --EN:--Keystone Aura
		proxy:TreasureDispModeChange2( 1981 , true ,KANAME_SFX);--光らせる --EN:-- let it shine
		--proxy:TreasureDispModeChange2( 1976 , true ,KANAME_SFX);--光らせる --EN:-- let it shine
		proxy:OnDistanceActionAttribute( 6283 , 10000 , 1981 , "OnEvent_6283" , WarpGimmickDist_A , 10010180 , 0 , 180 , possible_chr_type, once );
	end
	
	--中ボス部屋前の移動処理イベントを削除 --EN:--Delete the movement processing event in front of the mid-boss room
	proxy:DeleteEvent( 520 );--一人目が入るとき用 --EN:--For when the first person enters
	proxy:DeleteEvent( 521 );--二人目以降が入るとき用 --EN:--For when the second and subsequent people enter
	proxy:DeleteEvent( 522 );--ボス前ポリ劇用 --EN:--For boss front poly drama
	proxy:DeleteEvent( 523 );--ボス戦闘開始用 --EN:--For boss battle start

	print("OnEvent_6272_1 end");
end

--▲6272_2▲2秒後▲ --EN:--▲6272_2▲After 2 seconds▲
function OnEvent_6272_2(proxy,param)
	print("OnEvent_6272_2 begin");
	
	--ボス戦用のBGM停止	 --EN:--BGM stop for boss battles
	proxy:StopPointSE( 1 );	

	print("OnEvent_6272_2 end");
end

--マルチ解散監視 --EN:--Multi-Dismissal Monitoring
function Check_6272_PT(proxy)
	if proxy:IsInParty() == false then
		return true;
	end
	return false;
end

--マルチじゃない --EN:--not multiplayer
function OnEvent_6272_PT(proxy,param)
	print("OnEvent_6272_PT begin");
	
	--中ボス部屋の前後の魔法壁が消える(全プレイヤー) --EN:--The magic walls before and after the mid-boss room disappear (all players)
	proxy:SetColiEnable( 1998 , false );
	proxy:SetColiEnable( 1994 , false );
	
	proxy:SetDrawEnable( 1998 , false );
	proxy:SetDrawEnable( 1994 , false );
	
	--SFX OFF
	proxy:InvalidSfx( 1986 , true );
	proxy:InvalidSfx( 1990 , true );
	
	print("OnEvent_6272_PT end");
end

--------------------------------------------------------------------------------------
--■6283■ソウル入手■ --EN:-- ■ 6283 ■ Get Soul ■
--------------------------------------------------------------------------------------
function OnEvent_6283(proxy, param)
	print("OnEvent_6283 begin");
	
	--プレイヤーの同期アニメーション(true:パーティープレイヤーがアニメーションした) --EN:--Player synchronous animation (true: party player animated)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_PICK ) == true then--新しいアニメ  --EN:-- new anime
		print("OnEvent_6283 end");
		return true;
	end
	
	proxy:NotNetMessage_begin();
		--0.0秒後にアイテム取得イベントを発行 --EN:-- Issue an item acquisition event after 0.0 seconds
		proxy:OnKeyTime2( 6283, "OnEvent_6283_1", 0.0, 0, 0, once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_6283 end");
end


--■6283_1■アイテム取得■ --EN:-- ■ 6283_1 ■ item acquisition ■
function OnEvent_6283_1(proxy, param)
	print("OnEvent_6283_1 begin");

	--アイテム取得関数--パラメータ10631参照 --EN:--item retrieval function--see parameter 10631
	proxy:GetRateItem(10631);	
	--アイテム取得関数--パラメータ10674参照 --EN:--item retrieval function--see parameter 10674
	proxy:GetRateItem(10674);	
	--アイテム取得関数--パラメータ10675参照 --EN:--item retrieval function--see parameter 10675
	proxy:GetRateItem(10675);	
	--アイテム取得関数--パラメータ10676参照 --EN:--item retrieval function--see parameter 10676
	proxy:GetRateItem(10676);	
	--アイテム取得関数--パラメータ10677参照 --EN:--item retrieval function--see parameter 10677
	proxy:GetRateItem(10677);	
	
	--アイテムを取得済み --EN:--item already acquired
	proxy:SetEventFlag( 6283, 1 );
	
	--宝箱シェーダーは消えません --EN:--Treasure chest shader does not disappear
	--proxy:TreasureDispModeChange( 1981 , false );

	--SFXが消える --EN:--SFX disappear
	proxy:InvalidSfx( 2250 , true );--光の粒子 --EN:--Particles of light
	--proxy:InvalidSfx( 2251 , true );--要石のオーラ --EN:--Keystone Aura
	
	--▼要石でワープ用の監視を追加▼ --EN:--▼ Added surveillance for warp with keystone ▼
	proxy:OnDistanceActionAttribute( 6284 , 10000 , 1981 , "OnEvent_6284" , WarpGimmickDist_A , HELPID_GO_TO_SEKITYUU , 0 , 180 , ATTR_NOSESSION , everytime );

	print("OnEvent_6283_1 end");
end

--------------------------------------------------------------------------------------
--徘徊デーモンの登場■?? --EN:-- Appearance of the Wandering Demon ??
--------------------------------------------------------------------------------------

--▼グローバルの死亡監視から呼ばれる(ソロ) --EN:--▼ Called from global death watch (solo)
function PlayerDeath_m06_01_00_00(proxy, param)
	print("PlayerDeath_m06_01_00_00");
	
--	LuaFunc_VisibleTheWanderingDemon(proxy, param, demon_id_list_m06_01_00_00);
--	proxy:SetEventFlag( 20 , 1 );--フラグは仮、指定があれば変える。 --EN:The -- flag is tentative, and will be changed if specified.
	
	print("PlayerDeath_m06_01_00_00");
end

--▼グローバルの血文字復活から呼ばれる(ソロ) --EN:--▼Called from global blood letter revival (solo)
function PlayerRevive_m06_01_00_00(proxy,param)
	print("PlayerRevive_m06_01_00_00");
	
--	LuaFunc_InvisibleTheWanderingDemon(proxy, param, demon_id_list_m06_01_00_00);
--	proxy:SetEventFlag( 20 , 0 );--フラグは仮、指定があれば変える。 --EN:The -- flag is tentative, and will be changed if specified.
	
	print("PlayerRevive_m06_01_00_00");
end



--[[
--------------------------------------------------------------------------------------
--ボス部屋の中に入る(一匹目)■111 --EN:--Enter the boss room (first one) 111
--------------------------------------------------------------------------------------

--■イベントがループなので、全部リピートにする↓ --EN:--■ Since the event is a loop, repeat all ↓

--■111■中ボス部屋への扉が開く■ --EN:-- ■ 111 ■ The door to the mid-boss room opens ■
function OnEvent_111(proxy,param)
	print("OnEvent_111 begin");
	
	if proxy:IsCompleteEvent( SYSTEM_ID_IGNORE ) == true then
		print("OnEvent_111 end");
		return;
	end
	
	proxy:LuaCallStart( 112, 1 );--旋回アニメの同期再生 --EN:-- Synchronous playback of turning animation
	proxy:SetEventFlag( SYSTEM_ID_IGNORE, true );
	
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
		proxy:LuaCallStart( 111 , 5 );--2回目以降にボス部屋に入るためのイベント配信用 --EN:--For event delivery to enter the boss room after the second time
		proxy:LuaCallStart( 4045 , 1 );	--クライアントへ、ボス部屋に入れるようになったことを通知 --EN:--Notify clients that they can now enter the boss room
	end

	--プレイヤーが扉の中に完全にはいったタイミングで、ボスの思考をリセット --EN:--Reset the boss' thoughts when the player is completely inside the door
	--場所が悪いとプレイヤーを見つけれないため(攻撃してこない) --EN:--Because you can't find the player if the location is bad (they won't attack)
	if proxy:IsLivePlayer() == true or proxy:IsGreyGhost() == true then
		proxy:ResetThink( 810 );
	end
	
	proxy:LuaCallStart( 111 , 6 );--フラグセット(同期用) --EN:--flag set (for synchronization)
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

	print("OnEvent_111_flag_set end");
end
]]



--------------------------------------------------------------------------------------
--■570■ホストPCのみが通れる光の霧■ --EN:-- ■ 570 ■ A fog of light that only the host PC can pass through ■
--------------------------------------------------------------------------------------
--■570_delete_wall■魔法壁削除同期用■ --EN:--■570_delete_wall■For synchronized magic wall deletion■
function OnEvent_570_delete_wall(proxy , param)
	print("OnEvent_570_delete_wall begin");
	
	proxy:SetDrawEnable( 1240 , false );--魔法壁描画OFF --EN:--Magic Wall Drawing OFF
	proxy:SetColiEnable( 1240 , false );--魔法壁当たりOFF	 --EN:--Magic wall hit OFF
	proxy:DeleteEvent( 570 );--全プレイヤー分の監視消えるはず。 --EN:--Surveillance for all players should disappear.
	
	print("OnEvent_570_delete_wall end");
end

--■570■イベント発動用■ --EN:-- ■ 570 ■ For event activation ■
function OnEvent_570(proxy , param)
	print("OnEvent_570 begin");

	--多重発動防止 --EN:--Multiple activation prevention
	if proxy:IsCompleteEvent( 570 ) == true then
		print("OnEvent_570 end");
		return;
	end
	
	proxy:InvalidSfx( 2220, true );
	
	--プレイヤーの同期アニメーション(true:パーティープレイヤーがアニメーションした) --EN:--Player synchronous animation (true: party player animated)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_WALK ) == true then
		proxy:SetEventFlag( 570 , 1 );
		print("OnEvent_570 end");
		return;
	end
	
	--ダミポリへワープ --EN:--Warp to Damipoli
	proxy:WarpDmy( 10000 , 1240 , 191 );
	
	proxy:NotNetMessage_begin();
		--▼240_1▼歩きアニメ終了▼ --EN:--▼240_1▼End of walking animation▼
		proxy:OnChrAnimEnd( 570 , 10000 , ANIMEID_WALK , "OnEvent_570_1" , once );
	proxy:NotNetMessage_end();
	
	proxy:SetEventFlag( 570 , 1 );
	
	print("OnEvent_570 end");
end

--▲570_1▲歩きアニメ終了▲ --EN:--▲570_1▲End of walking animation▲
function OnEvent_570_1(proxy , param)
	print("OnEvent_570_1 begin");
	
	proxy:LuaCallStart( 570 , 1 );--光の霧削除同期 --EN:--light fog removal sync
	
	print("OnEvent_570_1 end");
end




--------------------------------------------------------------------------------------
--■571■ホストPCのみが通れる光の霧■ --EN:-- ■ 571 ■ A fog of light that only the host PC can pass through ■
--------------------------------------------------------------------------------------
--■571_delete_wall■魔法壁削除同期用■ --EN:--■571_delete_wall■For synchronized magic wall deletion■
function OnEvent_571_delete_wall(proxy , param)
	print("OnEvent_571_delete_wall begin");
	
	proxy:InvalidSfx( 2221, true );
	proxy:SetDrawEnable( 1241 , false );--魔法壁描画OFF --EN:--Magic Wall Drawing OFF
	proxy:SetColiEnable( 1241 , false );--魔法壁当たりOFF	 --EN:--Magic wall hit OFF
	proxy:SetObjDeactivate( 1241 , true );--デアクティブ --EN:--deactivate
	proxy:DeleteEvent( 571 );--全プレイヤー分の監視消えるはず。 --EN:--Surveillance for all players should disappear.
	
	print("OnEvent_571_delete_wall end");
end

--■571■イベント発動用■ --EN:-- ■ 571 ■ For event activation ■
function OnEvent_571(proxy , param)
	print("OnEvent_571 begin");

	--多重発動防止 --EN:--Multiple activation prevention
	if proxy:IsCompleteEvent( 571 ) == true then
		print("OnEvent_571 end");
		return;
	end
	
	proxy:InvalidSfx( 2221, true );
	
	--プレイヤーの同期アニメーション(true:パーティープレイヤーがアニメーションした) --EN:--Player synchronous animation (true: party player animated)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_WALK ) == true then
		proxy:SetEventFlag( 571 , 1 );
		print("OnEvent_571 end");
		return;
	end
		
	--ダミポリへワープ --EN:--Warp to Damipoli
	proxy:WarpDmy( 10000 , 1241 , 191 );
	
	proxy:NotNetMessage_begin();
		--▼240_1▼歩きアニメ終了▼ --EN:--▼240_1▼End of walking animation▼
		--proxy:OnChrAnimEnd( 571 , 10000 , ANIMEID_WALK , "OnEvent_571_1" , once );
		proxy:LuaCallStart( 571 , 1 );--光の霧削除同期 --EN:--light fog removal sync
	proxy:NotNetMessage_end();
	
	proxy:SetEventFlag( 571 , 1 );
	
	--プロファイルセーブ要求 --EN:--profile save request
	proxy:SaveRequest_Profile();
	
	print("OnEvent_571 end");
end

--▲571_1▲歩きアニメ終了▲ --EN:--▲571_1▲End of walking animation▲
function OnEvent_571_1(proxy , param)
	print("OnEvent_571_1 begin");
	
	proxy:LuaCallStart( 571 , 1 );--光の霧削除同期 --EN:--light fog removal sync
	
	print("OnEvent_571_1 end");
end


--ショートカット --EN:--Shortcut
function OnEvent_565(proxy,param)
	if proxy:IsClient() == false then
		print("OnEvent_565 begin");
		proxy:SetEventFlag(565,true);
		if proxy:IsCompleteEvent(571) == false then
			proxy:SetEventFlag( 571,true);
			proxy:LuaCallStart( 571 , 1 );--光の霧削除同期		 --EN:--light fog removal sync
		end
		print("OnEvent_565 end");
	end
end



--------------------------------------------------------------------------------------
--■572■ホストPCのみが通れる光の霧■ --EN:-- ■ 572 ■ A fog of light that only the host PC can pass through ■
--------------------------------------------------------------------------------------
--■572_delete_wall■魔法壁削除同期用■ --EN:--■572_delete_wall■For synchronization of magic wall deletion■
function OnEvent_572_delete_wall(proxy , param)
	print("OnEvent_572_delete_wall begin");
	
	proxy:InvalidSfx( 2222, true );
	proxy:SetDrawEnable( 1242 , false );--魔法壁描画OFF --EN:--Magic Wall Drawing OFF
	proxy:SetColiEnable( 1242 , false );--魔法壁当たりOFF	 --EN:--Magic wall hit OFF
	proxy:SetObjDeactivate( 1242 , true );--デアクティブ --EN:--deactivate
	proxy:DeleteEvent( 572 );--全プレイヤー分の監視消えるはず。 --EN:--Surveillance for all players should disappear.

	print("OnEvent_572_delete_wall end");
end

--■572■イベント発動用■ --EN:-- ■ 572 ■ For event activation ■
function OnEvent_572(proxy , param)
	print("OnEvent_572 begin");

	--多重発動防止 --EN:--Multiple activation prevention
	if proxy:IsCompleteEvent( 572 ) == true then
		print("OnEvent_572 end");
		return;
	end
	
	proxy:InvalidSfx( 2222, true );
	proxy:InvalidSfx( 2221, true );--ショートカットしたためこの魔法壁も消す。 --EN:--Because of the shortcut, this magic wall is also erased.
	proxy:InvalidSfx( 2220, true );--ショートカットしたためこの魔法壁も消す。 --EN:--Because of the shortcut, this magic wall is also erased.
	
	--プレイヤーの同期アニメーション(true:パーティープレイヤーがアニメーションした) --EN:--Player synchronous animation (true: party player animated)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_WALK ) == true then
		proxy:SetEventFlag( 572 , 1 );
		proxy:SetEventFlag( 571 , 1 );
		--proxy:SetEventFlag( 570 , 1 );--ショートカット用に振られたIDのフラグをたてておく。 --EN:-- Set the flag for the ID assigned for the shortcut.
		print("OnEvent_572 end");
		return;
	end
	
	--ダミポリへワープ --EN:--Warp to Damipoli
	proxy:WarpDmy( 10000 , 1242 , 191 );
	
	proxy:NotNetMessage_begin();
		--▼240_1▼歩きアニメ終了▼ --EN:--▼240_1▼End of walking animation▼
		--proxy:OnChrAnimEnd( 572 , 10000 , ANIMEID_WALK , "OnEvent_572_1" , once );
		proxy:LuaCallStart( 572 , 1 );--光の霧削除同期 --EN:--light fog removal sync
		proxy:LuaCallStart( 571 , 1 );--ショートカットしたので、この魔法壁も消す --EN:--Since I made a shortcut, I also erase this magic wall
	proxy:NotNetMessage_end();
	
	proxy:SetEventFlag( 572 , 1 );
	proxy:SetEventFlag( 571 , 1 );
	--proxy:SetEventFlag( 570 , 1 );--ショートカット用に振られたIDのフラグをたてておく。 --EN:-- Set the flag for the ID assigned for the shortcut.
	
	--プロファイルセーブ要求 --EN:--profile save request
	proxy:SaveRequest_Profile();
	
	print("OnEvent_572 end");
end

--▲572_1▲歩きアニメ終了▲ --EN:--▲572_1▲End of walking animation▲
function OnEvent_572_1(proxy , param)
	print("OnEvent_572_1 begin");
	
	proxy:LuaCallStart( 572 , 1 );--光の霧削除同期 --EN:--light fog removal sync
	proxy:LuaCallStart( 571 , 1 );--ショートカットしたので、この魔法壁も消す --EN:--Since I made a shortcut, I also erase this magic wall
	--proxy:LuaCallStart( 570 , 1 );--ショートカットしたので、この魔法壁も消す --EN:--Since I made a shortcut, I also erase this magic wall
	
	print("OnEvent_572_1 end");
end

--ショートカット --EN:--Shortcut
function OnEvent_566(proxy,param)
	if proxy:IsClient() == false then
		print("OnEvent_566 begin");
		proxy:SetEventFlag(566,true);
		if proxy:IsCompleteEvent(571) == false then
			proxy:SetEventFlag( 571,true);
			proxy:LuaCallStart( 571 , 1 );--光の霧削除同期		 --EN:--light fog removal sync
		end
		if proxy:IsCompleteEvent(572) == false then
			proxy:SetEventFlag( 572 ,true);
			proxy:LuaCallStart( 572 , 1 );--光の霧削除同期 --EN:--light fog removal sync
		end
		print("OnEvent_566 end");
	end
end


--------------------------------------------------------------------------------------
--■573■ハンドル回してフロア移動■ --EN:-- ■ 573 ■ Rotate the handle to move to the floor ■
--------------------------------------------------------------------------------------
function OnEvent_573(proxy,param)
	--両方ONならアニメ中	 --EN:-- If both are ON, animation is in progress
	if proxy:IsCompleteEvent(576) == true and proxy:IsCompleteEvent(578) == true then
		--発動者だけインフォ --EN:--Invoker only info
		if param:IsNetMessage() == false then
			--扉が開かない場合のメッセージを表示 --EN:-- Display a message when the door does not open
			--proxy:InfomationMenu( INFOMENU_TYPE_SIMPLE, 0, MSG_CATEGORY_EVENT, 10010170, 1);
			--proxy:ShowGenDialog(10010170,1,1,true);
			proxy:RepeatMessage_begin();
			proxy:NotNetMessage_begin();
				--proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010170, 0, 6, 1244, GEN_DIALOG_DIST, once );
				proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010170, 0, 6, -1, GEN_DIALOG_DIST, once );				
			proxy:NotNetMessage_end();
			proxy:RepeatMessage_end();
		end
		return;
	end
	
	print("OnEvent_573 begin");
	if proxy:IsCompleteEvent(574) == false then
		proxy:PlayAnimation(1243,1);
	else
		proxy:PlayAnimation(1243,2);
	end
	--両方ON＞アニメ中 --EN:--Both ON > during animation
	proxy:SetEventFlag(576,true);
	proxy:SetEventFlag(578,true);	
	
	proxy:NotNetMessage_begin();
		proxy:RepeatMessage_begin();
			if proxy:IsCompleteEvent(574) == false then
				proxy:OnObjAnimEnd(573,1243,1,"OnEvent_573_1",once);
				proxy:SetEventFlag( 574 , true );
			else
				proxy:OnObjAnimEnd(573,1243,2,"OnEvent_573_1",once);
				proxy:SetEventFlag( 574 , false );
			end
		proxy:RepeatMessage_end();
	proxy:NotNetMessage_end();	
	
	if Luafunc_PlaySynchroAnimation(proxy,param,ANIMEID_TURN_HANDLE) == true then		
		return;
	end
	
	proxy:WarpDmy(10000,1243,191);	
	print("OnEvent_573 end");
	
end

--上下アニメ共通終了 --EN:--Common end of top and bottom animation
function OnEvent_573_1(proxy,param)
	if proxy:IsClient() == false then
		print("OnEvent_573_1 begin");
		proxy:LuaCallStart(573,1);
		print("OnEvent_573_1 end");
	end
end

--フラグ同期 --EN:--flag sync
function OnEvent_573_flag(proxy,param)
	print("OnEvent_573_flag begin");	
	if proxy:IsCompleteEvent(574) == false then
		--proxy:SetEventFlag(574,false);	--上についた --EN:-- got on
		proxy:SetEventFlag(578,false);	--下レバー有効 --EN:--Lower lever enabled
	else
		--proxy:SetEventFlag(574,true);	--下についた --EN:-- got down
		proxy:SetEventFlag(576,false);	--上レバー有効 --EN:--Upper lever enabled
	end
	print("OnEvent_573_flag end");
end


--------------------------------------------------------------------------------------
--■575■上にエレベーター呼び戻し■ --EN:-- ■ 575 ■ Call back the elevator to the top ■
--------------------------------------------------------------------------------------
function OnEvent_575(proxy,param)
	print("OnEvent_575 begin");
	--既に上orアニメ中 --EN:-- Already up or in animation
	if proxy:IsCompleteEvent(576) == true then
		--発動者だけインフォ --EN:--Invoker only info
		if param:IsNetMessage() == false then
			--扉が開かない場合のメッセージを表示 --EN:-- Display a message when the door does not open
			--proxy:InfomationMenu( INFOMENU_TYPE_SIMPLE, 0, MSG_CATEGORY_EVENT, 10010170, 1);
			--proxy:ShowGenDialog(10010170,1,1,true);
			proxy:RepeatMessage_begin();
			proxy:NotNetMessage_begin();
				proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010170, 0, 6, 1244, GEN_DIALOG_DIST, once );
			proxy:NotNetMessage_end();
			proxy:RepeatMessage_end();
		end		
		print("flag 576 On");
		print("OnEvent_575 end");
		return;
	end	
	
	proxy:PlayAnimation(1244,1);
	if proxy:IsCompleteEvent(574) == false then
		proxy:PlayAnimation(1243,1);
	else
		proxy:PlayAnimation(1243,2);
	end
	--両方ON＞アニメ中 --EN:--Both ON > during animation
	proxy:SetEventFlag(576,true);
	proxy:SetEventFlag(578,true);
	
	proxy:NotNetMessage_begin();
		proxy:RepeatMessage_begin();
			if proxy:IsCompleteEvent(574) == false then
				proxy:OnObjAnimEnd(573,1243,1,"OnEvent_573_1",once);
				proxy:SetEventFlag( 574 , true );
			else
				proxy:OnObjAnimEnd(573,1243,2,"OnEvent_573_1",once);
				proxy:SetEventFlag( 574 , false );
			end
		proxy:RepeatMessage_end();
	proxy:NotNetMessage_end();
	
	if Luafunc_PlaySynchroAnimation(proxy,param,ANIMEID_TURN_HANDLE) == true then		
		return;
	end	
	
	proxy:WarpDmy(10000,1244,191);		
	print("OnEvent_575 end");
end


--------------------------------------------------------------------------------------
--■577■下にエレベーター呼び戻し■ --EN:-- ■ 577 ■ Call back the elevator down ■
--------------------------------------------------------------------------------------
function OnEvent_577(proxy,param)
	print("OnEvent_577 begin");
	--既に下 --EN:--already below
	if proxy:IsCompleteEvent(578) == true then
		--発動者だけインフォ --EN:--Invoker only info
		if param:IsNetMessage() == false then
			--扉が開かない場合のメッセージを表示 --EN:-- Display a message when the door does not open
			--proxy:InfomationMenu( INFOMENU_TYPE_SIMPLE, 0, MSG_CATEGORY_EVENT, 10010170, 1);
			--proxy:ShowGenDialog(10010170,1,1,true);
			proxy:RepeatMessage_begin();
			proxy:NotNetMessage_begin();
				proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010170, 0, 6, 1245, GEN_DIALOG_DIST, once );
			proxy:NotNetMessage_end();
			proxy:RepeatMessage_end();
		end		
		print("flag 576 On");
		print("OnEvent_577 end");
		return;
	end
	
	proxy:PlayAnimation(1245,1);
	if proxy:IsCompleteEvent(574) == false then
		proxy:PlayAnimation(1243,1);
	else
		proxy:PlayAnimation(1243,2);
	end
	--両方ON＞アニメ中 --EN:--Both ON > during animation
	proxy:SetEventFlag(576,true);
	proxy:SetEventFlag(578,true);
	
	proxy:NotNetMessage_begin();
		proxy:RepeatMessage_begin();
			if proxy:IsCompleteEvent(574) == false then
				proxy:OnObjAnimEnd(573,1243,1,"OnEvent_573_1",once);
				proxy:SetEventFlag( 574 , true );
			else
				proxy:OnObjAnimEnd(573,1243,2,"OnEvent_573_1",once);
				proxy:SetEventFlag( 574 , false );
			end
		proxy:RepeatMessage_end();
	proxy:NotNetMessage_end();
	
	if Luafunc_PlaySynchroAnimation(proxy,param,ANIMEID_TURN_HANDLE) == true then		
		return;
	end	
	
	proxy:WarpDmy(10000,1245,191);		
	
	print("OnEvent_577 end");
end


--------------------------------------------------------------------------------------
--■579■床ダメージON■ --EN:-- ■ 579 ■ Floor damage ON ■
--------------------------------------------------------------------------------------
function OnEvent_579(proxy,param)	
	print("OnEvent_579 begin");
	if param:IsNetMessage() == true then
		return;
	end
	--proxy:SetEventSpecialEffect(10000,10250);
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 4069 , "OnEvent_FireDamage2_1",0.0,0,FIREDOM_COUNT2,once);
		FIREDOM_COUNT2 = FIREDOM_COUNT2 +1;
		if FIREDOM_COUNT2 > 10000 then
			FIREDOM_COUNT2 = 0;
		end
	proxy:NotNetMessage_end();
	IS_FIREAREA2 = true;
	print("OnEvent_579 end");
end

--------------------------------------------------------------------------------------
--■580■床ダメージOFF■ --EN:-- ■ 580 ■ floor damage off ■
--------------------------------------------------------------------------------------
function OnEvent_580(proxy,param)
	print("OnEvent_580 begin");
	if param:IsNetMessage() == true then
		return;
	end
	--proxy:EraseEventSpecialEffect(10000,10250);
	proxy:DeleteEvent( 4069 );
	IS_FIREAREA2 = false;
	print("OnEvent_580 end");
end

function OnEvent_FireDamage2_1(proxy,param)
	if IS_FIREAREA2 == true then
		proxy:NotNetMessage_begin();
			proxy:OnKeyTime2( 4069 , "OnEvent_FireDamage2_2",FIREDOM_TIME2,0,FIREDOM_COUNT2,once);
		proxy:NotNetMessage_end();
		if proxy:GetFloorMaterial( 10000 ) == 27 then
			proxy:CreateDamage_NoCollision(10330,400,10000,0,OFFSET2,0);
		end
		FIREDOM_COUNT2 = FIREDOM_COUNT2 +1;
		if FIREDOM_COUNT2 > 10000 then
			FIREDOM_COUNT2 = 0;
		end
	end
end

function OnEvent_FireDamage2_2(proxy,param)
	if IS_FIREAREA2 == true then
		proxy:NotNetMessage_begin();
			proxy:OnKeyTime2( 4069 , "OnEvent_FireDamage2_1",FIREDOM_TIME2,0,FIREDOM_COUNT2,once);
		proxy:NotNetMessage_end();
		if proxy:GetFloorMaterial( 10000 ) == 27 then
			proxy:CreateDamage_NoCollision(10330,400,10000,0,OFFSET2,0);
		end
		FIREDOM_COUNT2 = FIREDOM_COUNT2 +1;
		if FIREDOM_COUNT2 > 10000 then
			FIREDOM_COUNT2 = 0;
		end
	end
end


--------------------------------------------------------------------------------------
--■583■ボス部屋の床ダメージON■ --EN:-- ■ 583 ■ Boss room floor damage ON ■
--------------------------------------------------------------------------------------
function OnEvent_583(proxy,param)	
	print("OnEvent_583 begin");
	if param:IsNetMessage() == true then
		return;
	end
	--proxy:SetEventSpecialEffect(10000,10240);
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 4069 , "OnEvent_FireDamage3_1",0.0,0,FIREDOM_COUNT3,once);
		FIREDOM_COUNT3 = FIREDOM_COUNT3 +1;
		if FIREDOM_COUNT3 > 10000 then
			FIREDOM_COUNT3 = 0;
		end
	proxy:NotNetMessage_end();
	IS_FIREAREA3 = true;
	print("OnEvent_583 end");
end


--------------------------------------------------------------------------------------
--■584■ボス部屋の床ダメージOFF■ --EN:-- ■ 584 ■ Boss room floor damage off ■
--------------------------------------------------------------------------------------
function OnEvent_584(proxy,param)
	print("OnEvent_584 begin");
	if param:IsNetMessage() == true then
		return;
	end
	--proxy:EraseEventSpecialEffect(10000,10240);
	proxy:DeleteEvent( 4069 );
	IS_FIREAREA3 = false;
	print("OnEvent_584 end");
end

function OnEvent_FireDamage3_1(proxy,param)
	if IS_FIREAREA3 == true then
		proxy:NotNetMessage_begin();
			proxy:OnKeyTime2( 4069 , "OnEvent_FireDamage3_2",FIREDOM_TIME3,0,FIREDOM_COUNT3,once);
		proxy:NotNetMessage_end();
		if proxy:GetFloorMaterial( 10000 ) == 27 then
			proxy:CreateDamage_NoCollision(10340,400,10000,0,OFFSET3,0);
		end
		FIREDOM_COUNT3 = FIREDOM_COUNT3 +1;
		if FIREDOM_COUNT3 > 10000 then
			FIREDOM_COUNT3 = 0;
		end
	end
end

function OnEvent_FireDamage3_2(proxy,param)
	if IS_FIREAREA3 == true then
		proxy:NotNetMessage_begin();
			proxy:OnKeyTime2( 4069 , "OnEvent_FireDamage3_1",FIREDOM_TIME3,0,FIREDOM_COUNT3,once);
		proxy:NotNetMessage_end();
		if proxy:GetFloorMaterial( 10000 ) == 27 then
			proxy:CreateDamage_NoCollision(10340,400,10000,0,OFFSET3,0);
		end
		FIREDOM_COUNT3 = FIREDOM_COUNT3 +1;
		if FIREDOM_COUNT3 > 10000 then
			FIREDOM_COUNT3 = 0;
		end
	end
end


--------------------------------------------------------------------------------------
--垂直ハシゴ1降り■585 --EN:-- Vertical ladder 1 descend ■ 585
--------------------------------------------------------------------------------------
--■585■ハシゴ1降りスタート■ --EN:-- ■ 585 ■ Ladder 1 down start ■
function OnEvent_585(proxy, param)
	print("OnEvent_585 begin");
	
	if param:IsNetMessage() == true then
		print("IsNetMessage true");
		print("OnEvent_585 end");
		return;
	end

	--はしご降りに必要な前処理-- --EN:--Pretreatment required for descending the ladder--
	proxy:BeginAction(10000,2,2,2);				--ホバー移動モードに移行 --EN:--Transition to hover movement mode
	proxy:HoverMoveValDmy(10000,1246,192,LadderTime_A);--移動位置(2003)に0.5秒でホバー移動 --EN:--Hover in 0.5 seconds to move position (2003)
	proxy:SetEventCommand(10000,1);				--イベントコマンドID(1)"ハシゴ上から掴"むを送る --EN:-- Send event command ID (1) "Grab from the top of the ladder"
	proxy:SetKeepCommandIndex(10000, 0, 1, 3.0 );--nCommandID を 垂直のとき0 斜めのとき4 --EN:--nCommandID 0 for vertical 4 for diagonal
	proxy:DisableMove(10000,1);					--キャラクタを移動、旋回不能に --EN:--Move the character, make it impossible to turn
	
	proxy:NotNetMessage_begin();
		--0.5秒(ホバー移動終了)後にはしご降りスタートイベントを発行 --EN:-- Issue a ladder descend start event after 0.5 seconds (end of hover movement)
		proxy:OnKeyTime2(585,"OnEvent_585_1",LadderTime_A,0,0,once);
		--はしご降り専用の関数を3秒間発行(カメラの周り込みなどの処理) --EN:--Issue a function dedicated to descending the ladder for 3 seconds (processing such as surrounding the camera)
		proxy:OnKeyTime2(585,"LadderDown",3,1,1,once);
	proxy:NotNetMessage_end();

	print("OnEvent_585 end");
end

--■585_1■ハシゴA降りスタート:ホバー移動終了■ --EN:--■ 585_1 ■ Start descending from ladder A: End of hover movement ■
function OnEvent_585_1(proxy, param)
	print("OnEvent_585_1 begin");
	
	if proxy:GetEventMode(10000) == 0 then
		print("Local Player GetEventMode 0");
		print("OnEvent_585_1 end");
		return;
	end

	--ハシゴアクションモードに移行-- --EN:--Transition to ladder action mode--
	--nMax  : はしごの段数 - 補正値(補正値はおおよそ3) --EN:--nMax : number of ladder steps - correction value (correction value is approximately 3)
	--nStart: 降りるとき→(nMax + 1) 昇るとき→(-1) --EN:--nStart: When going down→(nMax + 1) When going up→(-1)
	proxy:BeginAction(10000,1,7,6);
	
	--キャラクタを移動、旋回可能に-- --EN:--Character can be moved and turned--
	proxy:DisableMove(10000,0);
	
	print("OnEvent_585_1 end");
end


--------------------------------------------------------------------------------------
--垂直ハシゴ1昇り■586 --EN:--Vertical ladder 1 climb 586
--------------------------------------------------------------------------------------
--■586■ハシゴ1昇りスタート■ --EN:-- ■ 586 ■ Ladder 1 climbing start ■
function OnEvent_586(proxy, param)
	print("OnEvent_586 begin");
	
	if param:IsNetMessage() == true then
		print("IsNetMessage true");
		print("OnEvent_586 end");
		return;
	end
	
	--はしご昇りに必要な前処理-- --EN:--Pretreatment required for climbing a ladder--
	proxy:BeginAction(10000,2,-1,1);			--ホバー移動モードに移行 --EN:--Transition to hover movement mode
	proxy:HoverMoveValDmy(10000,1246,191,LadderTime_A);--移動位置(2003)に0.5秒でホバー移動 --EN:--Hover in 0.5 seconds to move position (2003)
	proxy:SetEventCommand(10000,0);				--イベントコマンドID(0)"ハシゴ下から掴"むを送る --EN:-- Send event command ID (0) "grab from under the ladder"
	proxy:SetKeepCommandIndex(10000, 0, 1, 3.0 );--nCommandID を 垂直のとき0 斜めのとき4 --EN:--nCommandID 0 for vertical 4 for diagonal
	proxy:DisableMove(10000,1);					--キャラクタを移動、旋回不能に --EN:--Move the character, make it impossible to turn
	
	proxy:NotNetMessage_begin();
		--0.5秒(ホバー移動終了)後にはしご昇りスタートイベントを発行 --EN:-- Issue a ladder climb start event after 0.5 seconds (end of hover movement)
		proxy:OnKeyTime2(586,"OnEvent_586_1",LadderTime_A,0,0,once);
		--はしご昇り用の関数を1秒間発行(イベントメニューの中断処理?) --EN:--Issuing a function for climbing a ladder for 1 second (interruption processing of the event menu?)
		proxy:OnKeyTime2(586,"EventMenuBrake",1,1,1,once);
	proxy:NotNetMessage_end();
	
	print("OnEvent_586 end");
end

--■586_1■ハシゴ1昇りスタート:ホバー移動終了■ --EN:--■ 586_1 ■ Ladder 1 climbing start: hover movement end ■
function OnEvent_586_1(proxy, param)
	print("OnEvent_586_1 begin");
	
	if proxy:GetEventMode(10000) == 0 then
		print("Local Player GetEventMode 0");
		print("OnEvent_586_1 end");
		return;
	end

	--ハシゴアクションモードに移行-- --EN:--Transition to ladder action mode--
	--nMax  : はしごの段数 - 補正値(補正値はおおよそ3) --EN:--nMax : number of ladder steps - correction value (correction value is approximately 3)
	--nStart: 降りるとき→(nMax + 1) 昇るとき→(-1) --EN:--nStart: When going down→(nMax + 1) When going up→(-1)
	proxy:BeginAction(10000,1,-1,6);
	
	--キャラクタを移動、旋回可能に-- --EN:--Character can be moved and turned--
	proxy:DisableMove(10000,0);
	
	print("OnEvent_586_1 end");
end



--------------------------------------------------------------------------------------
--垂直ハシゴ2降り■587 --EN:-- Descend 2 vertical ladders 587
--------------------------------------------------------------------------------------
--■587■ハシゴ2降りスタート■ --EN:-- ■ 587 ■ Ladder 2 descent start ■
function OnEvent_587(proxy, param)
	print("OnEvent_587 begin");
	
	if param:IsNetMessage() == true then
		print("IsNetMessage true");
		print("OnEvent_587 end");
		return;
	end

	--はしご降りに必要な前処理-- --EN:--Pretreatment required for descending the ladder--
	proxy:BeginAction(10000,2,2,2);				--ホバー移動モードに移行 --EN:--Transition to hover movement mode
	proxy:HoverMoveValDmy(10000,1247,192,LadderTime_A);--移動位置(2003)に0.5秒でホバー移動 --EN:--Hover in 0.5 seconds to move position (2003)
	proxy:SetEventCommand(10000,1);				--イベントコマンドID(1)"ハシゴ上から掴"むを送る --EN:-- Send event command ID (1) "Grab from the top of the ladder"
	proxy:SetKeepCommandIndex(10000, 0, 1, 3.0 );--nCommandID を 垂直のとき0 斜めのとき4 --EN:--nCommandID 0 for vertical 4 for diagonal
	proxy:DisableMove(10000,1);					--キャラクタを移動、旋回不能に --EN:--Move the character, make it impossible to turn
	
	proxy:NotNetMessage_begin();
		--0.5秒(ホバー移動終了)後にはしご降りスタートイベントを発行 --EN:-- Issue a ladder descend start event after 0.5 seconds (end of hover movement)
		proxy:OnKeyTime2(587,"OnEvent_587_1",LadderTime_A,0,0,once);
		--はしご降り専用の関数を3秒間発行(カメラの周り込みなどの処理) --EN:--Issue a function dedicated to descending the ladder for 3 seconds (processing such as surrounding the camera)
		proxy:OnKeyTime2(587,"LadderDown",3,1,1,once);
	proxy:NotNetMessage_end();

	print("OnEvent_587 end");
end

--■587_1■ハシゴA降りスタート:ホバー移動終了■ --EN:--■ 587_1 ■ Start descending from ladder A: End of hover movement ■
function OnEvent_587_1(proxy, param)
	print("OnEvent_587_1 begin");
	
	if proxy:GetEventMode(10000) == 0 then
		print("Local Player GetEventMode 0");
		print("OnEvent_587_1 end");
		return;
	end

	--ハシゴアクションモードに移行-- --EN:--Transition to ladder action mode--
	--nMax  : はしごの段数 - 補正値(補正値はおおよそ3) --EN:--nMax : number of ladder steps - correction value (correction value is approximately 3)
	--nStart: 降りるとき→(nMax + 1) 昇るとき→(-1) --EN:--nStart: When going down→(nMax + 1) When going up→(-1)
	proxy:BeginAction(10000,1,7,6);
	
	--キャラクタを移動、旋回可能に-- --EN:--Character can be moved and turned--
	proxy:DisableMove(10000,0);
	
	print("OnEvent_587_1 end");
end


--------------------------------------------------------------------------------------
--垂直ハシゴ2昇り■588 --EN:--Vertical ladder 2 up ■588
--------------------------------------------------------------------------------------
--■588■ハシゴ2昇りスタート■ --EN:-- ■ 588 ■ Ladder 2 climbing start ■
function OnEvent_588(proxy, param)
	print("OnEvent_588 begin");
	
	if param:IsNetMessage() == true then
		print("IsNetMessage true");
		print("OnEvent_588 end");
		return;
	end
	
	--はしご昇りに必要な前処理-- --EN:--Pretreatment required for climbing a ladder--
	proxy:BeginAction(10000,2,-1,1);			--ホバー移動モードに移行 --EN:--Transition to hover movement mode
	--proxy:HoverMoveVal(10000,2003,LadderTime_A);--移動位置(2003)に0.5秒でホバー移動 --EN:--Hover in 0.5 seconds to move position (2003)
	proxy:HoverMoveValDmy(10000,1247,191,LadderTime_A);--移動位置(2003)に0.5秒でホバー移動 --EN:--Hover in 0.5 seconds to move position (2003)
	proxy:SetEventCommand(10000,0);				--イベントコマンドID(0)"ハシゴ下から掴"むを送る --EN:-- Send event command ID (0) "grab from under the ladder"
	proxy:SetKeepCommandIndex(10000, 0, 1, 3.0 );--nCommandID を 垂直のとき0 斜めのとき4 --EN:--nCommandID 0 for vertical 4 for diagonal
	proxy:DisableMove(10000,1);					--キャラクタを移動、旋回不能に --EN:--Move the character, make it impossible to turn
	
	proxy:NotNetMessage_begin();
		--0.5秒(ホバー移動終了)後にはしご昇りスタートイベントを発行 --EN:-- Issue a ladder climb start event after 0.5 seconds (end of hover movement)
		proxy:OnKeyTime2(588,"OnEvent_588_1",LadderTime_A,0,0,once);
		--はしご昇り用の関数を1秒間発行(イベントメニューの中断処理?) --EN:--Issuing a function for climbing a ladder for 1 second (interruption processing of the event menu?)
		proxy:OnKeyTime2(588,"EventMenuBrake",1,1,1,once);
	proxy:NotNetMessage_end();
	
	print("OnEvent_588 end");
end

--■588_1■ハシゴ2昇りスタート:ホバー移動終了■ --EN:--■ 588_1 ■ Ladder 2 climbing start: Hover movement end ■
function OnEvent_588_1(proxy, param)
	print("OnEvent_588_1 begin");
	
	if proxy:GetEventMode(10000) == 0 then
		print("Local Player GetEventMode 0");
		print("OnEvent_588_1 end");
		return;
	end

	--ハシゴアクションモードに移行-- --EN:--Transition to ladder action mode--
	--nMax  : はしごの段数 - 補正値(補正値はおおよそ3) --EN:--nMax : number of ladder steps - correction value (correction value is approximately 3)
	--nStart: 降りるとき→(nMax + 1) 昇るとき→(-1) --EN:--nStart: When going down→(nMax + 1) When going up→(-1)
	proxy:BeginAction(10000,1,-1,6);
	
	--キャラクタを移動、旋回可能に-- --EN:--Character can be moved and turned--
	proxy:DisableMove(10000,0);
	
	print("OnEvent_588_1 end");
end



--------------------------------------------------------------------------------------
--垂直ハシゴ3降り■589 --EN:--Go down the vertical ladder 3 589
--------------------------------------------------------------------------------------
--■589■ハシゴ3降りスタート■ --EN:-- ■ 589 ■ Ladder 3 descending start ■
function OnEvent_589(proxy, param)
	print("OnEvent_589 begin");
	
	if param:IsNetMessage() == true then
		print("IsNetMessage true");
		print("OnEvent_589 end");
		return;
	end

	--はしご降りに必要な前処理-- --EN:--Pretreatment required for descending the ladder--
	proxy:BeginAction(10000,2,2,2);				--ホバー移動モードに移行 --EN:--Transition to hover movement mode
	proxy:HoverMoveValDmy(10000,1248,192,LadderTime_A);--移動位置(2003)に0.5秒でホバー移動 --EN:--Hover in 0.5 seconds to move position (2003)
	proxy:SetEventCommand(10000,1);				--イベントコマンドID(1)"ハシゴ上から掴"むを送る --EN:-- Send event command ID (1) "Grab from the top of the ladder"
	proxy:SetKeepCommandIndex(10000, 0, 1, 3.0 );--nCommandID を 垂直のとき0 斜めのとき4 --EN:--nCommandID 0 for vertical 4 for diagonal
	proxy:DisableMove(10000,1);					--キャラクタを移動、旋回不能に --EN:--Move the character, make it impossible to turn
	
	proxy:NotNetMessage_begin();
		--0.5秒(ホバー移動終了)後にはしご降りスタートイベントを発行 --EN:-- Issue a ladder descend start event after 0.5 seconds (end of hover movement)
		proxy:OnKeyTime2(589,"OnEvent_589_1",LadderTime_A,0,0,once);
		--はしご降り専用の関数を3秒間発行(カメラの周り込みなどの処理) --EN:--Issue a function dedicated to descending the ladder for 3 seconds (processing such as surrounding the camera)
		proxy:OnKeyTime2(589,"LadderDown",3,1,1,once);
	proxy:NotNetMessage_end();

	print("OnEvent_589 end");
end

--■589_1■ハシゴA降りスタート:ホバー移動終了■ --EN:--■ 589_1 ■ Start descending from ladder A: End of hover movement ■
function OnEvent_589_1(proxy, param)
	print("OnEvent_589_1 begin");
	
	if proxy:GetEventMode(10000) == 0 then
		print("Local Player GetEventMode 0");
		print("OnEvent_589_1 end");
		return;
	end

	--ハシゴアクションモードに移行-- --EN:--Transition to ladder action mode--
	--nMax  : はしごの段数 - 補正値(補正値はおおよそ3) --EN:--nMax : number of ladder steps - correction value (correction value is approximately 3)
	--nStart: 降りるとき→(nMax + 1) 昇るとき→(-1) --EN:--nStart: When going down→(nMax + 1) When going up→(-1)
	proxy:BeginAction(10000,1,7,6);
	
	--キャラクタを移動、旋回可能に-- --EN:--Character can be moved and turned--
	proxy:DisableMove(10000,0);
	
	print("OnEvent_589_1 end");
end


--------------------------------------------------------------------------------------
--垂直ハシゴ3昇り■590 --EN:--Vertical ladder 3 up ■590
--------------------------------------------------------------------------------------
--■590■ハシゴ3昇りスタート■ --EN:-- ■ 590 ■ Ladder 3 climbing start ■
function OnEvent_590(proxy, param)
	print("OnEvent_590 begin");
	
	if param:IsNetMessage() == true then
		print("IsNetMessage true");
		print("OnEvent_590 end");
		return;
	end
	
	--はしご昇りに必要な前処理-- --EN:--Pretreatment required for climbing a ladder--
	proxy:BeginAction(10000,2,-1,1);			--ホバー移動モードに移行 --EN:--Transition to hover movement mode
	--proxy:HoverMoveVal(10000,2003,LadderTime_A);--移動位置(2003)に0.5秒でホバー移動 --EN:--Hover in 0.5 seconds to move position (2003)
	proxy:HoverMoveValDmy(10000,1248,191,LadderTime_A);--移動位置(2003)に0.5秒でホバー移動 --EN:--Hover in 0.5 seconds to move position (2003)
	proxy:SetEventCommand(10000,0);				--イベントコマンドID(0)"ハシゴ下から掴"むを送る --EN:-- Send event command ID (0) "grab from under the ladder"
	proxy:SetKeepCommandIndex(10000, 0, 1, 3.0 );--nCommandID を 垂直のとき0 斜めのとき4 --EN:--nCommandID 0 for vertical 4 for diagonal
	proxy:DisableMove(10000,1);					--キャラクタを移動、旋回不能に --EN:--Move the character, make it impossible to turn
	
	proxy:NotNetMessage_begin();
		--0.5秒(ホバー移動終了)後にはしご昇りスタートイベントを発行 --EN:-- Issue a ladder climb start event after 0.5 seconds (end of hover movement)
		proxy:OnKeyTime2(590,"OnEvent_590_1",LadderTime_A,0,0,once);
		--はしご昇り用の関数を1秒間発行(イベントメニューの中断処理?) --EN:--Issuing a function for climbing a ladder for 1 second (interruption processing of the event menu?)
		proxy:OnKeyTime2(590,"EventMenuBrake",1,1,1,once);
	proxy:NotNetMessage_end();
	
	print("OnEvent_590 end");
end

--■590_1■ハシゴ3昇りスタート:ホバー移動終了■ --EN:--■590_1■ Start climbing ladder 3: End of hover movement ■
function OnEvent_590_1(proxy, param)
	print("OnEvent_590_1 begin");
	
	if proxy:GetEventMode(10000) == 0 then
		print("Local Player GetEventMode 0");
		print("OnEvent_590_1 end");
		return;
	end

	--ハシゴアクションモードに移行-- --EN:--Transition to ladder action mode--
	--nMax  : はしごの段数 - 補正値(補正値はおおよそ3) --EN:--nMax : number of ladder steps - correction value (correction value is approximately 3)
	--nStart: 降りるとき→(nMax + 1) 昇るとき→(-1) --EN:--nStart: When going down→(nMax + 1) When going up→(-1)
	proxy:BeginAction(10000,1,-1,6);
	
	--キャラクタを移動、旋回可能に-- --EN:--Character can be moved and turned--
	proxy:DisableMove(10000,0);
	
	print("OnEvent_590_1 end");
end



--------------------------------------------------------------------------------------
--ハシゴ4降り■591 --EN:--Ladder 4 down 591
--------------------------------------------------------------------------------------
--■591■ハシゴ4降りスタート■ --EN:-- ■ 591 ■ Ladder 4 down start ■
function OnEvent_591(proxy, param)
	print("OnEvent_591 begin");
	
	if param:IsNetMessage() == true then
		print("IsNetMessage true");
		print("OnEvent_591 end");
		return;
	end

	--はしご降りに必要な前処理-- --EN:--Pretreatment required for descending the ladder--
	proxy:BeginAction(10000,2,2,2);				--ホバー移動モードに移行 --EN:--Transition to hover movement mode
	proxy:HoverMoveValDmy(10000,1249,192,LadderTime_A);--移動位置(2003)に0.5秒でホバー移動 --EN:--Hover in 0.5 seconds to move position (2003)
	proxy:SetEventCommand(10000,1);				--イベントコマンドID(1)"ハシゴ上から掴"むを送る --EN:-- Send event command ID (1) "Grab from the top of the ladder"
	proxy:SetKeepCommandIndex(10000, 0, 1, 3.0 );--nCommandID を 垂直のとき0 斜めのとき4 --EN:--nCommandID 0 for vertical 4 for diagonal
	proxy:DisableMove(10000,1);					--キャラクタを移動、旋回不能に --EN:--Move the character, make it impossible to turn
	
	proxy:NotNetMessage_begin();
		--0.5秒(ホバー移動終了)後にはしご降りスタートイベントを発行 --EN:-- Issue a ladder descend start event after 0.5 seconds (end of hover movement)
		proxy:OnKeyTime2(591,"OnEvent_591_1",LadderTime_A,0,0,once);
		--はしご降り専用の関数を3秒間発行(カメラの周り込みなどの処理) --EN:--Issue a function dedicated to descending the ladder for 3 seconds (processing such as surrounding the camera)
		proxy:OnKeyTime2(591,"LadderDown",3,1,1,once);
	proxy:NotNetMessage_end();

	print("OnEvent_591 end");
end

--■591_1■ハシゴA降りスタート:ホバー移動終了■ --EN:--■ 591_1 ■ Start descending from ladder A: End of hover movement ■
function OnEvent_591_1(proxy, param)
	print("OnEvent_591_1 begin");
	
	if proxy:GetEventMode(10000) == 0 then
		print("Local Player GetEventMode 0");
		print("OnEvent_591_1 end");
		return;
	end

	--ハシゴアクションモードに移行-- --EN:--Transition to ladder action mode--
	--nMax  : はしごの段数 - 補正値(補正値はおおよそ3) --EN:--nMax : number of ladder steps - correction value (correction value is approximately 3)
	--nStart: 降りるとき→(nMax + 1) 昇るとき→(-1) --EN:--nStart: When going down→(nMax + 1) When going up→(-1)
	proxy:BeginAction(10000,1,17,16);
	
	--キャラクタを移動、旋回可能に-- --EN:--Character can be moved and turned--
	proxy:DisableMove(10000,0);
	
	print("OnEvent_591_1 end");
end


--------------------------------------------------------------------------------------
--ハシゴ4昇り■592 --EN:--Ladder 4 climbing 592
--------------------------------------------------------------------------------------
--■592■ハシゴ4昇りスタート■ --EN:-- ■ 592 ■ Ladder 4 climbing start ■
function OnEvent_592(proxy, param)
	print("OnEvent_592 begin");
	
	if param:IsNetMessage() == true then
		print("IsNetMessage true");
		print("OnEvent_592 end");
		return;
	end
	
	--はしご昇りに必要な前処理-- --EN:--Pretreatment required for climbing a ladder--
	proxy:BeginAction(10000,2,-1,1);			--ホバー移動モードに移行 --EN:--Transition to hover movement mode
	proxy:HoverMoveValDmy(10000,1249,191,LadderTime_A);--移動位置(2003)に0.5秒でホバー移動 --EN:--Hover in 0.5 seconds to move position (2003)
	proxy:SetEventCommand(10000,0);				--イベントコマンドID(0)"ハシゴ下から掴"むを送る --EN:-- Send event command ID (0) "grab from under the ladder"
	proxy:SetKeepCommandIndex(10000, 0, 1, 3.0 );--nCommandID を 垂直のとき0 斜めのとき4 --EN:--nCommandID 0 for vertical 4 for diagonal
	proxy:DisableMove(10000,1);					--キャラクタを移動、旋回不能に --EN:--Move the character, make it impossible to turn
	
	proxy:NotNetMessage_begin();
		--0.5秒(ホバー移動終了)後にはしご昇りスタートイベントを発行 --EN:-- Issue a ladder climb start event after 0.5 seconds (end of hover movement)
		proxy:OnKeyTime2(592,"OnEvent_592_1",LadderTime_A,0,0,once);
		--はしご昇り用の関数を1秒間発行(イベントメニューの中断処理?) --EN:--Issuing a function for climbing a ladder for 1 second (interruption processing of the event menu?)
		proxy:OnKeyTime2(592,"EventMenuBrake",1,1,1,once);
	proxy:NotNetMessage_end();
	
	print("OnEvent_592 end");
end

--■592_1■ハシゴ4昇りスタート:ホバー移動終了■ --EN:--■592_1■ Start climbing ladder 4: End of hover movement ■
function OnEvent_592_1(proxy, param)
	print("OnEvent_592_1 begin");
	
	if proxy:GetEventMode(10000) == 0 then
		print("Local Player GetEventMode 0");
		print("OnEvent_592_1 end");
		return;
	end

	--ハシゴアクションモードに移行-- --EN:--Transition to ladder action mode--
	--nMax  : はしごの段数 - 補正値(補正値はおおよそ3) --EN:--nMax : number of ladder steps - correction value (correction value is approximately 3)
	--nStart: 降りるとき→(nMax + 1) 昇るとき→(-1) --EN:--nStart: When going down→(nMax + 1) When going up→(-1)
	proxy:BeginAction(10000,1,-1,16);
	
	--キャラクタを移動、旋回可能に-- --EN:--Character can be moved and turned--
	proxy:DisableMove(10000,0);
	
	print("OnEvent_592_1 end");
end



--------------------------------------------------------------------------------------
--トカゲイベント移動■594 --EN:-- lizard event movement ■ 594
--------------------------------------------------------------------------------------

--■594■トカゲイベント移動■ --EN:-- ■ 594 ■ lizard event movement ■
function OnEvent_594(proxy, param)
	print("OnEvent_594 begin");

	--AIの領域移動をさせるためロジックをONにしておく --EN:--Turn on the logic to move the AI area
	
	proxy:EnableLogic( 321 , true );
	proxy:EnableLogic( 322 , true );
	
	proxy:NotNetMessage_begin();
		--▼594▼トカゲイベント移動(イベント開始のタイミングをずらす)▼ --EN:--▼594▼Lizard Event Move (Stagger event start timing)▼
		proxy:OnKeyTime2( 594 , "OnEvent_594_1" , 0.0 , 0 , 2 , once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_594 end");
end


--▲594▲トカゲイベント移動(イベント開始のタイミングをずらす)▲ --EN:-- ▲ 594 ▲ Lizard event movement (shift the timing of the event start) ▲
function OnEvent_594_1(proxy, param)
	print("OnEvent_594_1 begin");	
	if proxy:IsCompleteEvent( 782 ) == false then
		proxy:ResetThink( 321 );	
		proxy:SendEventRequest( 321 , 0, 0 );
		--▼596▼トカゲA : 領域(2237)への到着監視▼ --EN:--▼596▼Lizard A : Arrival monitoring to area (2237)▼
		proxy:OnRegionJustIn( 596 , 321 , 2237 , "OnEvent_596" , once );
	end	
	
	if proxy:IsCompleteEvent( 784 ) == false then
		proxy:ResetThink( 322 );
		proxy:SendEventRequest( 322 , 0 , 0);
		--▼598▼トカゲB : 領域(2237)への到着監視▼ --EN:--▼598▼Lizard B: Arrival monitoring to area (2237)▼
		proxy:OnRegionJustIn( 598 , 322 , 2237 , "OnEvent_598" , once );
	end	
	--イベントフラグセット	 --EN:--event flag set
	proxy:SetEventFlag( 594 , 1 );--領域用 --EN:--for area
	proxy:SetEventFlag( 595 , 1 );--ダメージ監視用 --EN:--For damage monitoring

	--監視削除	 --EN:--Delete monitor
	proxy:DeleteEvent( 594 );--領域用 --EN:--for area
	proxy:DeleteEvent( 595 );--ダメージ監視用 --EN:--For damage monitoring
	
	print("OnEvent_594_1 end");
end


-----トカゲA--------------------------------------------------------------- --EN:--Lizard A---------------------------------------------- -----------------

--▲596▲トカゲA : 領域(2235)への到着監視▲ --EN:--▲596▲Lizard A: Arrival monitor to area (2235)▲
function OnEvent_596(proxy, param)
	print("OnEvent_596 begin");
	
	proxy:SetEventFlag( 600 , 1 );--領域(2237)に到着済み --EN:-- Arrived in region (2237)
	proxy:ChangeInitPosAng( 321 , 2237 );--初期位置の領域を(2237に)更新する --EN:--Update the initial position area (to 2237)
	
	proxy:EnableLogic( 321 , true );--ロジックON --EN:--Logic ON
	proxy:PlayAnimation( 321 , 3301 );--トカゲ消えるアニメ --EN:-- Lizard Disappearing Anime
	proxy:SendEventRequest( 321 , 0, -1 );

	print("OnEvent_596 end");
end

-----トカゲB--------------------------------------------------------------- --EN:--Lizard B---------------------------------------------- -----------------

--▲598▲トカゲB : 領域(2235)への到着監視▲ --EN:--▲598▲ Lizard B: Arrival monitor to area (2235)▲
function OnEvent_598(proxy, param)
	print("OnEvent_598 begin");
	
	proxy:SetEventFlag( 601 , 1 );--領域(2237)に到着済み --EN:-- Arrived in region (2237)
	proxy:ChangeInitPosAng( 322 , 2237 );--初期位置の領域を(2237に)更新する --EN:--Update the initial position area (to 2237)
	
	proxy:EnableLogic( 322 , true );--ロジックON --EN:--Logic ON
	proxy:PlayAnimation( 322 , 3301 );--トカゲ消えるアニメ --EN:-- Lizard Disappearing Anime
	proxy:SendEventRequest( 322 , 0, -1 );

	print("OnEvent_598 end");
end


--[[------------------------------------------------------------------------------------
--ハーフハンド状態管理■602 --EN:--Half hand status management ■602
--------------------------------------------------------------------------------------

--■602■ハーフハンド状態管理■ --EN:-- ■ 602 ■ Half hand status management ■
function OnEvent_602(proxy, param)
	print("OnEvent_602 begin");

	--現在の状態取得 --EN:-- Get current status
	local now_state = GetNpcStateFlag( proxy , param , half_flag_list );
	
	--「坑道でまつ」でない場合は処理抜け --EN:-- If it is not "Matsui in the tunnel", skip processing
	if now_state ~= HALF_STATE_WAIT_KOUDOU then
		print("OnEvent_602 end");
		return;
	end
	
	--ハーフハンドの状態フラグを「石柱に行きたい」にする --EN:-- Set the half hand status flag to "I want to go to the stone pillar"
	SetNpcStateFlag(proxy, param, half_flag_list, HALF_STATE_GO_TO_SEKITYU );
	proxy:SetEventFlag( 602 , 1 );--リピートでない指定なのでフラグを立てておく。 --EN:--Set a flag because it is a non-repeat specification.
	
	print("OnEvent_602 end");
end
]]

--------------------------------------------------------------------------------------
--ハーフハンド敵対■603 --EN:-- Half-hand hostility ■ 603
--------------------------------------------------------------------------------------

--■603■ハーフハンド敵対■ --EN:-- ■ 603 ■ Half-handed hostility ■
function OnEvent_603(proxy, param)
	print("OnEvent_603 begin");

	proxy:EnableLogic( 661 , true );--[[ロジックON ロジック切り替え?]] --EN:--[[Logic ON logic switch?]]
	
	--ハーフハンドの状態フラグを「敵対(坑道)」にする --EN:-- Set half hand status flag to "hostile (pit)"
	SetNpcStateFlag(proxy, param, half_flag_list, HALF_STATE_HOSTILE_KOUDOU );
	--敵対設定 --EN:--Adversarial setting
	proxy:SetTeamType( 661, TEAM_TYPE_AngryFriend);
	proxy:SetEventFlag( 603 , 1 );
	
	print("OnEvent_603 end");
end


--------------------------------------------------------------------------------------
--ハーフハンド状態管理■604 --EN:--Half hand status management■604
--------------------------------------------------------------------------------------

--■604■ハーフハンド死亡■ --EN:-- ■ 604 ■ half hand death ■
function OnEvent_604(proxy, param)
	print("OnEvent_604 begin");

	--ハーフハンドの状態フラグを「死亡」にする --EN:-- Set half hand status flag to "dead"
	SetNpcStateFlag(proxy, param, half_flag_list, HALF_STATE_DEAD );
	proxy:SetEventFlag( 604 , 1 );
	
	print("OnEvent_604 end");
end

--ハーフハンド・ブラックゴーストが死亡したかどうかのフラグセット --EN:--Flag set whether Halfhand Black Ghost is dead
function OnEvent_675(proxy, param)
	print("OnEvent_675 begin");
	--死亡したフラグを立てる --EN:--Flag dead
	proxy:SetEventFlag( 675, true );
		
	print("OnEvent_675 end");
end

--ハーフハンド・ブラックの死体を調べてない --EN:--Didn't examine Halfhand Black's corpse
function OnEvent_15604(proxy,param)
	print("OnEvent_15604 begin");
	proxy:SetEventFlag( 15604 , true );
	print("OnEvent_15604 end");
end

--ハーフハンドの死体を調べてない --EN:--Didn't examine Halfhand's corpse
function OnEvent_15632(proxy,param)
	print("OnEvent_15632 begin");
	proxy:SetEventFlag( 15632 , true );
	print("OnEvent_15632 end");
end

--ハーフハンドからアイテム取得 --EN:-- Get item from half hand
function OnEvent_643(proxy,param)
	print("OnEvent_643 begin");
	
	proxy:SetEventFlag( 643,true );
	
	proxy:GetRateItem( 16640 );--アイテム抽選パラメータ16640参照 --EN:--See Item Lottery Parameter 16640
	--proxy:GetRateItem( 16641 );--アイテム抽選パラメータ16641参照 --EN:-- See item raffle parameter 16641
	print("OnEvent_643 end");
end

--------------------------------------------------------------------------------------
--クマムシとらっぷ■607 --EN:--Water bear trap 607
--------------------------------------------------------------------------------------
function OnEvent_607(proxy,param)
	print("OnEvent_607 begin");
	proxy:LuaCallStart( 607 , 0 );
	print("OnEvent_607 end");
end

function OnEvent_607_0(proxy,param)
	print("OnEvent_607_0 begin");		
	print("I Can Flay!!!!");
	proxy:PlayAnimation( 323,9200);
	
	proxy:NotNetMessage_begin();
		--飛び降りアニメが終わったらパッチ用の領域監視追加 --EN:--Add area monitoring for patch after jumping animation is over
		proxy:OnChrAnimEnd(607, 323, 9200, "OnEvent_607_1", once);
		if proxy:IsCompleteEvent(642) == true then	--パッチもイベントが起こせる状態ならば --EN:--If the patch is also in a state where events can occur
			proxy:OnRegionJustIn(609,10000,2258,"OnEvent_609",once);--パッチが移動したりするイベントの監視追加	 --EN:--Add monitoring of events such as patch movement
		end
	proxy:NotNetMessage_end();

	proxy:SetEventFlag( 607 ,true );
	print("OnEvent_607_0 end");
end

function OnEvent_607_1(proxy,param)
	print("OnEvent_607_1 begin");
	
	--クマムシの特殊待機アニメを解除する --EN:--Release the special standby animation of the water bear
	proxy:SetSpStayAndDamageAnimId(323,-1,-1);--特殊待機アニメの無効化	 --EN:--Disable special standby animation
	
	print("OnEvent_607_1 end");
end

--クマムシ殺害 --EN:--Killing water bears
function OnEvent_646(proxy,param)
	print("OnEvent_646 begin");
	--罠にはめたい時だけ　クマムシ倒したに移行できる	 --EN:-- Only when you want to trap it, you can transition to defeating the tardigrade
	if 	proxy:IsCompleteEvent( BATTI_TRAP_M6 ) == true then	
		SetNpcStateFlag( proxy, param, batti_flag_list, BATTI_DESTORYKUMA );--バッチの状態を「クマムシ殺した」に変更する。 --EN:--Change the status of the batch to "killed tardigrades".
		proxy:SetEventFlag( 646,true );
	end	
	proxy:DeleteEvent( 609 );
	--領域から出るようの敵対イベントを削除 --EN:--removed hostile events like exiting the territory
	proxy:DeleteEvent( 662 );
	--proxy:SetEventFlag( 609,true);
	print("OnEvent_646 end");
end

--------------------------------------------------------------------------------------
--岩ミミズ登場■620 --EN:--Rock earthworm appears ■620
--------------------------------------------------------------------------------------
function OnEvent_620(proxy,param)
	print("OnEvent_620 begin");
	ValidCharactor( proxy, 324 );
	proxy:StopLoopAnimation( 324 );
	proxy:ForcePlayAnimation( 324, 9010 );
	proxy:EnableLogic( 324, true );	
	proxy:SetEventFlag( 620 , true );
	print("OnEvent_620 end");
end

--------------------------------------------------------------------------------------
--岩ミミズ登場■621 --EN:--Rock earthworm appears ■621
--------------------------------------------------------------------------------------
function OnEvent_621(proxy,param)
	print("OnEvent_621 begin");
	ValidCharactor( proxy, 325 );
	proxy:StopLoopAnimation( 325 );
	proxy:ForcePlayAnimation( 325, 9010 );
	proxy:EnableLogic( 325, true );	
	proxy:SetEventFlag( 621 , true );
	print("OnEvent_621 end");
end

--------------------------------------------------------------------------------------
--岩ミミズ登場■622 --EN:--Rock earthworm appears ■622
--------------------------------------------------------------------------------------
function OnEvent_622(proxy,param)
	print("OnEvent_622 begin");
	ValidCharactor( proxy, 326 );
	proxy:StopLoopAnimation( 326 );
	proxy:ForcePlayAnimation( 326, 9010 );
	proxy:EnableLogic( 326, true );	
	proxy:SetEventFlag( 622 , true );
	print("OnEvent_622 end");
end

--------------------------------------------------------------------------------------
--岩ミミズ登場■623 --EN:--Rock worm appears ■623
--------------------------------------------------------------------------------------
function OnEvent_623(proxy,param)
	print("OnEvent_623 begin");
	ValidCharactor( proxy, 327 );
	proxy:StopLoopAnimation( 327 );
	proxy:ForcePlayAnimation( 327, 9010 );
	proxy:EnableLogic( 327, true );	
	proxy:SetEventFlag( 623 , true );
	print("OnEvent_623 end");
end

--------------------------------------------------------------------------------------
--岩ミミズ登場■624 --EN:--Rock worm appears ■624
--------------------------------------------------------------------------------------
function OnEvent_624(proxy,param)
	print("OnEvent_624 begin");
	ValidCharactor( proxy, 328 );
	proxy:StopLoopAnimation( 328 );
	proxy:ForcePlayAnimation( 328, 9010 );
	proxy:EnableLogic( 328, true );	
	proxy:SetEventFlag( 624 , true );
	print("OnEvent_624 end");
end

--------------------------------------------------------------------------------------
--岩ミミズ登場■625 --EN:--Rock worm appears ■625
--------------------------------------------------------------------------------------
function OnEvent_625(proxy,param)
	print("OnEvent_625 begin");
	ValidCharactor( proxy, 329 );
	proxy:StopLoopAnimation( 329 );
	proxy:ForcePlayAnimation( 329, 9010 );
	proxy:EnableLogic( 329, true );	
	proxy:SetEventFlag( 625 , true );
	print("OnEvent_625 end");
end

--[[
--------------------------------------------------------------------------------------
--岩ミミズ登場■626 --EN:--Rock earthworm appears ■626
--------------------------------------------------------------------------------------
function OnEvent_626(proxy,param)
	print("OnEvent_626 begin");
	ValidCharactor( proxy, 330 );
	proxy:StopLoopAnimation( 330 );
	proxy:ForcePlayAnimation( 330, 9010 );
	proxy:EnableLogic( 330, true );	
	proxy:SetEventFlag( 626 , true );
	print("OnEvent_626 end");
end
]]

--------------------------------------------------------------------------------------
--バッチ移動イベント1■609 --EN:-- batch move event 1 609
--------------------------------------------------------------------------------------
function OnEvent_609(proxy,param)	
	--罠にはめたい時だけ走っていく --EN:--I run only when I want to be caught in a trap
	if proxy:IsCompleteEvent( BATTI_TRAP_M6 ) == true then
		print("OnEvent_609 begin");
		proxy:ResetThink(662);
		--AIへ命令を送る --EN:--Send command to AI
		proxy:SendEventRequest(662, 0, 1);
		
		--割り込み禁止でポイント移動 --EN:--Move point with no interrupts
		proxy:EnableLogic(662,true);
		--proxy:DisableInterupt(662,true);
		MoveRegion(proxy, 662, 2240,-1,0.0,false);
		proxy:LuaCallStart(612,0);

		proxy:SetEventFlag( 609,true);
		print("OnEvent_609 end");
	end	
end

--[[
--------------------------------------------------------------------------------------
--バッチ移動イベント2■610 --EN:-- batch move event 2 610
--------------------------------------------------------------------------------------
--登録&移動用 --EN:--for registration & transfer
function OnEvent_610(proxy,param)
	print("OnEvent_610 begin");	
	proxy:OnRegionIn(610,662,2240,"OnEvent_610_1",once);--バッチが2240に到着したら --EN:--Once the batch arrives at 2240
	print("OnEvent_610 end");
end

--到着 --EN:--arrival
function OnEvent_610_1(proxy,param)
	print("OnEvent_610_1 begin");
	--割り込み禁止でポイント移動 --EN:--Move point with no interrupts
	proxy:DisableInterupt(662,true);
	MoveRegion(proxy,662, 2241, -1, 0.0, false);
	proxy:LuaCallStart(611,0);
	print("OnEvent_610_1 end");
end


--------------------------------------------------------------------------------------
--バッチ移動イベント3■611 --EN:-- batch move event 3 611
--------------------------------------------------------------------------------------
--登録&移動用 --EN:--for registration & transfer
function OnEvent_611(proxy,param)
	print("OnEvent_611 begin");	
	proxy:OnRegionIn(611,662,2241,"OnEvent_611_1",once);--バッチが2241に到着したら --EN:--Once the batch arrives at 2241
	print("OnEvent_611 end");
end

--到着 --EN:--arrival
function OnEvent_611_1(proxy,param)
	print("OnEvent_611_1 begin");
	--割り込み禁止でポイント移動 --EN:--Move point with no interrupts
	proxy:DisableInterupt(662,true);
	MoveRegion(proxy,662, 2242, -1, 0.0, false);
	proxy:LuaCallStart(612,0);
	print("OnEvent_611_1 end");
end
]]

--------------------------------------------------------------------------------------
--バッチ到着監視■612 --EN:--Batch arrival monitoring 612
--------------------------------------------------------------------------------------
function OnEvent_612(proxy,param)
	print("OnEvent_612 begin");
	--proxy:OnRegionIn(611,662,2242,"OnEvent_612_1",once);--バッチが2242に到着したら --EN:--Once the batch arrives at 2242
	proxy:ResetThink(662);
	proxy:SendEventRequest(662, 0, 1);
	MoveRegion(proxy, 662, 2242,-1,0.0,false);
	proxy:OnRegionIn(611,662,2242,"OnEvent_612_1",once);--バッチが2241に到着したら --EN:--Once the batch arrives at 2241
	--領域から出るようの敵対イベントを削除 --EN:--removed hostile events like exiting the territory
	proxy:DeleteEvent( 662 );
	print("OnEvent_612 end");
end

--到着 --EN:--arrival
function OnEvent_612_1(proxy,param)
	print("OnEvent_612_1 begin");
	--AIへ命令を送る --EN:--Send command to AI
	proxy:SendEventRequest(662, 0, -1);
	proxy:ResetThink(662);
	proxy:ChangeInitPosAng( 662,2242);
	proxy:EnableLogic(662,true);
	--まだ宝が残っているなら --EN:--If there is still treasure left
	if proxy:IsCompleteEvent(615) == false then
		
		if proxy:IsCompleteEvent(646) == false then
			--バッチアイテム取得アニメ --EN:-- Batch item acquisition animation
			proxy:PlayAnimation(662,ANIMEID_PICK);
			--アイテム表現同期 --EN:--Item representation synchronization
			proxy:LuaCallStart(615,0);
			--アイテム取得イベント削除 --EN:--Delete item acquisition event
			proxy:DeleteEvent(615);
			proxy:SetEventFlag(615,true);
			SetNpcStateFlag( proxy, param, batti_flag_list, BATTI_TREASURE_M6 );--バッチの状態を「宝はいただいた」に変更する。 --EN:-- Change the status of the batch to "I got the treasure".
		
			proxy:SetEventFlag(15487,true);--バッチイベント用アイテム取得パラメーターON --EN:--Item acquisition parameter for batch event ON
		end
	end
	
	print("OnEvent_612_1 end");
end


--PCがアイテムとった■615-------------------------------------------------------------------- --EN:--PC got item■615----------------------------------------- ---------------------------
function OnEvent_615(proxy,param)
	print("OnEvent_615 begin");
	
	--プレイヤーの同期アニメーション(true:パーティープレイヤーがアニメーションした) --EN:--Player synchronous animation (true: party player animated)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_PICK ) == true then--新しいアニメ  --EN:-- new anime
		print("OnEvent_615 end");
		return true;
	end

	proxy:NotNetMessage_begin();
		--0.0秒後にアイテム取得イベントを発行 --EN:-- Issue an item acquisition event after 0.0 seconds
		proxy:OnKeyTime2( 615, "OnEvent_615_1", 0.0, 0, 0, once );
	proxy:NotNetMessage_end();	
	
	print("OnEvent_615 end");
end

--■615_1■アイテム取得■ --EN:-- ■ 615_1 ■ item acquisition ■
function OnEvent_615_1(proxy, param)
	print("OnEvent_615_1 begin");

	--現在の状態を取得 --EN:--get current state
	local now_state = GetNpcStateFlag( proxy , param , batti_flag_list );
	
	--アイテム取得関数--パラメータ10600参照 --EN:--item retrieval function--see parameter 10600
	proxy:GetRateItem(10600);	
	
	--宝表現無効呼び出し --EN:-- treasure expression invalid call
	proxy:LuaCallStart(615,0);
	
	--アイテムを取得済み --EN:--item already acquired
	proxy:SetEventFlag(615,true);
	
--パッチ宝取得失敗■614 --EN:--Failed to acquire patch treasure ■614
	--罠にはめたい--宝は頂いた の時のみ、残念に状態を変化させる --EN:--I want to trap it--Unfortunately, the state changes only when you receive the treasure
	if now_state == BATTI_TRAP_M6 or now_state == BATTI_TREASURE_M6 then
		--print("バッチは宝の取得に失敗した"); --EN:--print("Batch failed to get treasure");
		SetNpcStateFlag(proxy,param,batti_flag_list,BATTI_VEXING_M6);--バッチの状態を「残念(坑道)」に変更 --EN:-- Change batch status to "Unfortunate (pit)"
	end
	print("OnEvent_615_1 end");
end
-------------------------------------------------------------------------------------------

--■615_2■宝OFF■ --EN:--■615_2 ■Treasure OFF■
function OnEvent_615_2(proxy,param)
	print("OnEvent_615_2 begin");
	proxy:TreasureDispModeChange2(1250,false,99010);
	print("OnEvent_615_2 end");
end

--■615_3■バッチ状態変化■ --EN:-- ■ 615_3 ■ batch status change ■
function OnEvent_615_3(proxy,param)
	print("OnEvent_615_3 begin");

	--現在の状態を取得 --EN:--get current state
	local now_state = GetNpcStateFlag( proxy , param , batti_flag_list );

	--もし、バッチの状態が「罠にはめたい」ならば… --EN:--If the status of the batch is "I want to be trapped"...
	if now_state == BATTI_TRAP_M6 then
		--print("バッチの状態が「残念」に変化する"); --EN:--print("Batch status changes to 'Unfortunate'");
		SetNpcStateFlag(proxy,param,batti_flag_list,BATTI_VEXING_M6);--バッチの状態を「残念(坑道)」に変更 --EN:-- Change batch status to "Unfortunate (pit)"
	end
	print("OnEvent_615_3 end");
end

--------------------------------------------------------------------------------------
--クマムシトラップのバッチ状態OnEvent --EN:--Water bear trap batch status OnEvent
--------------------------------------------------------------------------------------
--■640■ --EN:--■640■
function OnEvent_640(proxy, param)
	print("OnEvent_640 begin");
	--クマムシが飛んでなくて、アイテムが取られていない --EN:--The tardigrade is not flying and the item is not taken
	if proxy:IsCompleteEvent(607) == false and proxy:IsCompleteEvent(615) == false then
		--proxy:SetEventFlag( 640, true );
		
		--[*バッチ関連*] --EN:--[*batch related*]
		--proxy:SetEventFlag( 612, true );--アイテムへ駆けて行く処理を無効 --EN:--Disable run-to-item processing
		
		--[*クマムシ関連*] --EN:--[*Water bear related*]
		
		--proxy:SetEventFlag( 607, true );--すでに飛んでしまった事にして、トラップを無効化する --EN:--Pretend that it has already flown and disable the trap
	end
	print("OnEvent_640 end");
end
--■641■ --EN:--■641■
function OnEvent_641(proxy, param)
	print("OnEvent_641 begin");
	--クマムシが飛んでなくて、アイテムが取られていない。 --EN:--No tardigrades flying and no items taken.
	if proxy:IsCompleteEvent(607) == false and proxy:IsCompleteEvent(615) == false then
		proxy:SetEventFlag( 641, true );
		
		--[*バッチ関連*] --EN:--[*batch related*]
		--アイテムへ駆けて行く処理を無効 --EN:--Disable run-to-item processing
		proxy:SetEventFlag( 612, true );
		
		--[*クマムシ関連*] --EN:--[*Water bear related*]
		proxy:Warp( 323, 2261 );--クマムシの移動（ワープ） --EN:--Moving tardigrades (warp)
		--ジャンプする領域への監視を開始 --EN:--Start monitoring to jump area
		if proxy:IsClient() == false then
			proxy:NotNetMessage_begin();
				proxy:OnRegionJustIn(607,10000,2258,"OnEvent_607",once);
			proxy:NotNetMessage_end();
		end
		proxy:LuaCall( 604 , 0 , "OnEvent_607_0",once);
	end
	
	print("OnEvent_641 end");
end

--■642■ --EN:--■642■
function OnEvent_642(proxy, param)
	print("OnEvent_642 begin");
	if proxy:IsCompleteEvent( 642 ) == false then
		--クマムシが飛んでなくて、アイテムが取られていない。 --EN:--No tardigrades flying and no items taken.
		if proxy:IsCompleteEvent(615) == false then
			proxy:SetEventFlag( 642, true );
			
			--[*バッチ関連*] --EN:--[*batch related*]
			proxy:EnableLogic( 662 , true );--バッチのロジックON --EN:-- Batch logic ON
			--状態を「罠にはめたい」（16246）にする --EN:--Set the state to "I want to be trapped" (16246)
			SetNpcStateFlag(proxy, param, batti_flag_list, BATTI_TRAP_M6 );
			--移動１登録 --EN:-- Move 1 registration
			--クマムシがジャンプしたら*proxy:OnRegionJustIn(609,10000,2258,"OnEvent_609",once);		 --EN:--When the tardigrade jumps *proxy:OnRegionJustIn(609,10000,2258,"OnEvent_609",once);
			--移動２登録 --EN:-- Move 2 Registration
			proxy:LuaCall(610,0,"OnEvent_610",once);
			--移動３登録 --EN:-- Move 3 Registration
			proxy:LuaCall(611,0,"OnEvent_611",once);
			--到着監視登録 --EN:--Arrival monitoring registration
			proxy:LuaCall(612,0,"OnEvent_612",once);
			
			if proxy:IsCompleteEvent(607) == false then
				--[*クマムシ関連*] --EN:--[*Water bear related*]
				proxy:Warp( 323, 2261 );--クマムシの移動（ワープ） --EN:--Moving tardigrades (warp)
				--ジャンプする領域への監視を開始 --EN:--Start monitoring to jump area
				proxy:NotNetMessage_begin();
					if proxy:IsClient() == false then
						proxy:OnRegionJustIn(607,10000,2258,"OnEvent_607",once);
					end
				proxy:NotNetMessage_end();
				proxy:LuaCall( 607 , 0 , "OnEvent_607_0",once);
			else
				OnEvent_609(proxy,param);
				proxy:Warp( 323 , 2239 );
			end
		else
			--無効化(もし条件が満たされなかった時に表示しないため) --EN:--disabled (because it doesn't display if the condition is not met)
			--print("クマムシかアイテムかがすでに無効です"); --EN:--print("Either tardigrade or item is already invalid");
			--InvalidBackRead(proxy,662);--バッチ --EN:--batch
		end
	end
	print("OnEvent_642 end");
end

--------------------------------------------------------------------------------------
--バッチが敵対する■616 --EN:-- Batch is hostile ■ 616
--------------------------------------------------------------------------------------
--敵対 --EN:--hostile
function OnEvent_616(proxy,param)
	print("OnEvent_616 begin");	
	proxy:EnableLogic(662,true);
	proxy:SetTeamType(662, TEAM_TYPE_AngryFriend);--チームタイプ変更 --EN:--Change team type
	SetNpcStateFlag(proxy,param,batti_flag_list,BATTI_ANGRY_M6);--敵対状態に --EN:-- in hostile state
	
	--アイテムへかけて行くイベントの消去 --EN:--Erase the event that goes to the item
	proxy:DeleteEvent( 609 );
	
	proxy:SetEventFlag(616,true);
	proxy:SetEventFlag(662,true);
	print("OnEvent_616 end");
end

--------------------------------------------------------------------------------------
--パッチが死亡■617 --EN:--Patch died ■617
--------------------------------------------------------------------------------------
--死亡 --EN:--death
function OnEvent_617(proxy,param)
	print("OnEvent_617 begin");
	proxy:SetEventFlag(617,true);
	SetNpcStateFlag(proxy,param,batti_flag_list,BATTI_DEAD);--死亡状態に		 --EN:-- in dead state
	print("OnEvent_617 end");
end


--------------------------------------------------------------------------------------
--パッチからアイテムもらう■660 --EN:-- Receive items from patches ■ 660
--------------------------------------------------------------------------------------
function OnEvent_660(proxy,param)
	print("OnEvent_660 begin");
	proxy:GetRateItem(10625);
	proxy:SetEventFlag( 660, true );
	
	proxy:SetEventFlag(15487,false);--バッチイベント用アイテム取得パラメーターOFF --EN:--Batch event item acquisition parameter OFF
	
	SetNpcStateFlag(proxy,param,batti_flag_list,BATTI_PRESENT);--アイテムあげた状態に --EN:--In the state where the item is given
	
	print("OnEvent_660 end");
end


--------------------------------------------------------------------------------------
--監視領域にホストが入った■645 --EN:--The host entered the monitoring area 645
--------------------------------------------------------------------------------------
function OnEvent_645(proxy,param)
	print("OnEvent_645 begin");
	proxy:LuaCallStart( 645 , 1 );
	print("OnEvent_645 end");
end


--------------------------------------------------------------------------------------
--配信用■660 --EN:--For delivery■660
--------------------------------------------------------------------------------------
function OnEvent_645_1(proxy,param)
	print("OnEvent_645_1 begin");
	proxy:SetSpStayAndDamageAnimId( 662 , -1,-1);
	proxy:SetEventFlag( 645 , true ); 
	print("OnEvent_645_1 end");
end


--------------------------------------------------------------------------------------
--乞食状態管理■650 --EN:--Beggar state management ■650
--------------------------------------------------------------------------------------
function OnEvent_650(proxy,param)
	print("OnEvent_650 begin");
		
	SetNpcStateFlag(proxy,param,SHOP_Flag_list,SHOP_NORMAL_2);
	proxy:SetEventFlag(650,true);

	print("OnEvent_650 end");
end

function OnEvent_650_1(proxy, param)
	print("OnEvent_650_1 begin");
	
	proxy:EnableLogic( 663 , true );
	proxy:EnableLogic( 676 , true );
	
	SetNpcStateFlag(proxy,param,SHOP_Flag_list,SHOP_HOSTILE_2);
	proxy:SetTeamType( 663, TEAM_TYPE_AngryFriend );
	proxy:SetTeamType( 676, TEAM_TYPE_AngryFriend );
	proxy:SetEventFlag(650,true);
	proxy:SetEventFlag(160,true);

	print("OnEvent_650_1 end");
end

--------------------------------------------------------------------------------------
--乞食状態管理■651 --EN:--Beggar state management ■651
--------------------------------------------------------------------------------------

--■161■乞食死亡■ --EN:-- ■ 161 ■ beggar death ■
function OnEvent_651(proxy, param)
	print("OnEvent_651 begin");

	--乞食の状態フラグを「死亡」にする --EN:--Set the beggar's status flag to "dead"
	SetNpcStateFlag(proxy, param, SHOP_Flag_list, SHOP_DEAD );
	proxy:SetEventFlag( 651 , 1 );
	proxy:SetEventFlag( 161 , 1 );
	
	print("OnEvent_651 end");
end

--------------------------------------------------------------------------------------
--■525■ボスカメラ切り替えイベント■ --EN:-- ■ 525 ■ Boss camera switching event ■
--------------------------------------------------------------------------------------
function OnEvent_525(proxy,param)
	--print("OnEvent_525 begin");
	--ボスが死んでいない　かつ　ボスとの戦闘を開始している --EN:-- Boss is not dead and has started a battle with the boss
	if proxy:IsCompleteEvent( 6272 ) == false and proxy:IsCompleteEvent( 523 ) == true then
		--ボス戦　非ロックカメラ --EN:-- Boss battle unlocked camera
		proxy:SetCamModeParamTargetId(6021);
		--ボス戦　ロックカメラ --EN:--Boss battle rock camera
		proxy:SetCamModeParamTargetIdForBossLock(6020);
	end
	--print("OnEvent_525 end");
end


--------------------------------------------------------------------------------------
--■690■トロッコトラップ1■ --EN:-- ■ 690 ■ truck trap 1 ■
--------------------------------------------------------------------------------------
function OnEvent_690(proxy,param)
	print("OnEvent_690 begin");
	
	proxy:NotNetMessage_begin();
		proxy:PlayAnimation( 1290 , 1);
		proxy:OnCharacterAnimEnd( 690 , 1290 , 1 ,"OnEvent_690_1",once);
	proxy:NotNetMessage_end();	
	--トロッコからダメージ --EN:--damage from minecarts
	local paramid = 10140;
	local rad     = 0.5;
	local time    = 40;	
	proxy:NotNetMessage_begin();		
		proxy:OnObjectDamageHit_NoCall( 690, 1290, 2, paramid, EV_HIT_CHR , rad, time, everytime );
	proxy:NotNetMessage_end();	
	
	proxy:SetEventFlag( 690 , true );	
	print("OnEvent_690 end");
end

--トロッコのアニメ停止 --EN:-- stop animation of trolley
function OnEvent_690_1(proxy,param)
	proxy:DeleteEvent(690);
	proxy:SetEventFlag( 900 , true );
end


--------------------------------------------------------------------------------------
--■691■ウィルオウィスプ爆発1■ --EN:-- ■ 691 ■ Will O'Wisp Explosion 1 ■
--------------------------------------------------------------------------------------
function OnEvent_691(proxy,param)
	print("OnEvent_691 begin");
	proxy:DeleteObjSfxEventID( 1290 );
	proxy:SetObjSfx( 1290 , 1 , 96002 , false );
	proxy:SetEventFlag( 691 ,true );	
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 691 , "OnEvent_691_1",1.2,0,0,once);
	proxy:NotNetMessage_end();	
	print("OnEvent_691 end");
end

function OnEvent_691_1(proxy,param)
	print("OnEvent_691_1 begin");
	proxy:DeleteObjSfxEventID( 1290 );
	--proxy:CastPointSpell_Horming( 400 , 1290 , 10160 , 0,0,0, 1290);
	proxy:CastTargetSpell(400,1290,1,1290,10161);
	proxy:AddRumble(121, 1290, -1,1.0, 25.0);
	print("OnEvent_691_1 end");
end

--------------------------------------------------------------------------------------
--■696■トロッコ破壊１■ --EN:-- ■ 696 ■ Minor Destruction 1 ■
--------------------------------------------------------------------------------------
function OnEvent_696(proxy,param)
	print("OnEvent_696 begin");
	proxy:SetEventFlag( 696 , true );
	proxy:ObjRootMtxMoveDmyPoly( 1290 , 1 );	
	proxy:ChangeModel( 1290 , 1 );
	proxy:SetFirstSpeedPlus( 1290 , 2, 3.5  ,6 , 1);
	proxy:SetBrokenPiece( 1290 );
	proxy:PlayTypeSE( 1290 , SOUND_TYPE_O , 620100000 );
	print("OnEvent_696 end");
end
--------------------------------------------------------------------------------------
--■692■トロッコトラップ2■ --EN:-- ■ 692 ■ truck trap 2 ■
--------------------------------------------------------------------------------------
function OnEvent_692(proxy,param)
	print("OnEvent_692 begin");
	
	proxy:NotNetMessage_begin();
		proxy:PlayAnimation( 1291 , 1);
		proxy:OnCharacterAnimEnd( 692 , 1291 , 1 ,"OnEvent_692_1",once);
	proxy:NotNetMessage_end();	
	--トロッコからダメージ --EN:--damage from minecarts
	local paramid = 10140;
	local rad     = 0.5;
	local time    = 40;	
	proxy:NotNetMessage_begin();		
		proxy:OnObjectDamageHit_NoCall( 692, 1291, 2, paramid, EV_HIT_CHR , rad, time, everytime );
	proxy:NotNetMessage_end();	
	
	proxy:SetEventFlag( 692 , true );	
	print("OnEvent_692 end");
end

--トロッコのアニメ停止 --EN:-- stop animation of trolley
function OnEvent_692_1(proxy,param)
	proxy:DeleteEvent(692);
	proxy:SetEventFlag( 902 , true );
end


--------------------------------------------------------------------------------------
--■693■ウィルオウィスプ爆発2■ --EN:-- ■ 693 ■ Will O'Wisp Explosion 2 ■
--------------------------------------------------------------------------------------
function OnEvent_693(proxy,param)
	print("OnEvent_693 begin");
	proxy:DeleteObjSfxEventID( 1291 );	
	proxy:SetObjSfx( 1291 , 1 , 96002 , false );
	
	proxy:SetEventFlag( 693 ,true );	
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 693 , "OnEvent_693_1",1.2,0,0,once);
	proxy:NotNetMessage_end();
	print("OnEvent_693 end");
end

function OnEvent_693_1(proxy,param)
	print("OnEvent_693_1 begin");
	proxy:DeleteObjSfxEventID( 1291 );
	--proxy:CastPointSpell_Horming( 400 , 1291 , 10160 , 0,0,0, 1291);
	proxy:CastTargetSpell(400,1291,1,1291,10161);
	proxy:AddRumble(121, 1291, -1,1.0, 25.0);
	print("OnEvent_693_1 end");
end

--------------------------------------------------------------------------------------
--■697■トロッコ破壊２■ --EN:-- ■ 697 ■ Minor Destruction 2 ■
--------------------------------------------------------------------------------------
function OnEvent_697(proxy,param)
	print("OnEvent_697 begin");
	proxy:SetEventFlag( 697 , true );
	proxy:ObjRootMtxMoveDmyPoly( 1291 , 1 );	
	proxy:ChangeModel( 1291 , 1 );
	proxy:SetFirstSpeedPlus( 1291 , 2, 3.5  ,6 , 1);
	proxy:SetBrokenPiece( 1291 );
	proxy:PlayTypeSE( 1291 , SOUND_TYPE_O , 620300000 );
	print("OnEvent_697 end");
end

--------------------------------------------------------------------------------------
--■694■トロッコトラップ3■ --EN:-- ■ 694 ■ truck trap 3 ■
--------------------------------------------------------------------------------------
function OnEvent_694(proxy,param)
	print("OnEvent_694 begin");
	
	proxy:NotNetMessage_begin();
		proxy:PlayAnimation( 1292 , 1);
		proxy:OnCharacterAnimEnd( 694 , 1292 , 1 ,"OnEvent_694_1",once);
	proxy:NotNetMessage_end();	
	--トロッコからダメージ --EN:--damage from minecarts
	local paramid = 10140;
	local rad     = 0.5;
	local time    = 40;	
	proxy:NotNetMessage_begin();		
		proxy:OnObjectDamageHit_NoCall( 694, 1292, 2, paramid, EV_HIT_CHR , rad, time, everytime );
	proxy:NotNetMessage_end();
		
	proxy:SetEventFlag( 694 , true );	
	print("OnEvent_694 end");
end

--トロッコのアニメ停止 --EN:-- stop animation of trolley
function OnEvent_694_1(proxy,param)
	proxy:DeleteEvent(694);
	proxy:SetEventFlag( 904 ,true );
end


--------------------------------------------------------------------------------------
--■695■ウィルオウィスプ爆発3■ --EN:-- ■ 695 ■ Will O'Wisp Explosion 3 ■
--------------------------------------------------------------------------------------
function OnEvent_695(proxy,param)
	print("OnEvent_695 begin");
	proxy:DeleteObjSfxEventID( 1292 );	
	proxy:SetObjSfx( 1292 , 1 , 96002 , false );
	proxy:SetEventFlag( 695 ,true );
	
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 695 , "OnEvent_695_1",1.2,0,0,once);
	proxy:NotNetMessage_end();	
	print("OnEvent_695 end");
end

function OnEvent_695_1(proxy,param)
	print("OnEvent_695_1 begin");
	proxy:DeleteObjSfxEventID( 1292 );
	--proxy:CastPointSpell_Horming( 400 , 1292 , 10160 , 0,0,0 , 1292);
	proxy:CastTargetSpell(400,1292,1,1292,10161);
	proxy:AddRumble(121, 1292, -1,1.0, 25.0);
	print("OnEvent_695_1 end");
end

--------------------------------------------------------------------------------------
--■698■トロッコ破壊３■ --EN:-- ■ 698 ■ Minor Destruction 3 ■
--------------------------------------------------------------------------------------
function OnEvent_698(proxy,param)
	print("OnEvent_698 begin");
	proxy:SetEventFlag( 698 , true );
	proxy:ObjRootMtxMoveDmyPoly( 1292 , 1 );	
	proxy:ChangeModel( 1292 , 1 );
	proxy:SetFirstSpeedPlus( 1292 , 2, 3.5  ,6 , 1);
	proxy:SetBrokenPiece( 1292 );
	proxy:PlayTypeSE( 1292 , SOUND_TYPE_O , 620400000 );
	print("OnEvent_698 end");
end


--------------------------------------------------------------------------------------
--■700■宝死体トラップ1■ --EN:-- ■ 700 ■ treasure corpse trap 1 ■
--------------------------------------------------------------------------------------
function OnEvent_700(proxy,param)
	if proxy:IsCompleteEvent( 700 ) == false then
		proxy:LuaCallStart( 700 , 10 );		
	end
end

--配信用 --EN:--For delivery
function OnEvent_700_1(proxy,param)
	print("OnEvent_700_1 begin");
	
	ValidCharactor( proxy, 330 );
	proxy:PlayAnimation( 330, 9010 );
	proxy:EnableLogic( 330, true );	
	proxy:SetEventFlag( 700 , true );
	
	print("OnEvent_700_1 end");
end


--------------------------------------------------------------------------------------
--■701■宝死体トラップ2■ --EN:-- ■ 701 ■ Treasure Corpse Trap 2 ■
--------------------------------------------------------------------------------------
function OnEvent_701(proxy,param)
	if proxy:IsCompleteEvent( 701 ) == false then
		proxy:LuaCallStart( 701 , 10 );		
	end
end

--配信用 --EN:--For delivery
function OnEvent_701_1(proxy,param)
	print("OnEvent_701_1 begin");
	
	ValidCharactor( proxy, 415 );
	proxy:PlayAnimation( 415, 9010 );
	proxy:EnableLogic( 415, true );	
	proxy:SetEventFlag( 701 , true );
	
	print("OnEvent_701_1 end");
end


--------------------------------------------------------------------------------------
--■720■トカゲ移動２■ --EN:-- ■ 720 ■ lizard movement 2 ■
--------------------------------------------------------------------------------------
function OnEvent_720(proxy,param)
	if proxy:IsCompleteEvent( 720 ) == false then
		print("OnEvent_720 begin");
		proxy:NotNetMessage_begin();
			proxy:OnKeyTime2( 720 , "OnEvent_720_1",0,0,0,once);
		proxy:NotNetMessage_end();
		
		print("OnEvent_720 end");
	end
end

--配信用 --EN:--For delivery
function OnEvent_720_1(proxy,param)
	print("OnEvent_720_1 begin");	
	
	proxy:EnableLogic( 416 , true );
	proxy:ResetThink( 416 );
	proxy:SendEventRequest( 416 , 0 , 0);
	LuaFunc_ForceOmission(proxy,416);
	proxy:SetAlwayEnableBackread_forEvent( 416 , true );	
	--▼598▼トカゲB : 領域(2265)への到着監視▼ --EN:--▼598▼Lizard B: Arrival monitoring to area (2265)▼
	proxy:OnRegionJustIn( 723 , 416 , 2265 , "OnEvent_723" , once );	
	--イベントフラグセット	 --EN:--event flag set
	proxy:SetEventFlag( 720 , 1 );--領域用 --EN:--for area
	proxy:SetEventFlag( 721 , 1 );--ダメージ監視用 --EN:--For damage monitoring
	
	proxy:DeleteEvent(720);
	proxy:DeleteEvent(721);	
	print("OnEvent_720_1 end");	
end

--領域に到着 --EN:--arrive in territory
function OnEvent_723(proxy,param)
	print("OnEvent_723 begin");
	proxy:SetEventFlag( 723 , 1 );--領域(2265)に到着済み --EN:-- Arrived in area (2265)
	proxy:ChangeInitPosAng( 416 , 2265 );--初期位置の領域を(2265に)更新する	 --EN:--Update the initial position area (to 2265)
	proxy:EnableLogic( 416 , true );--ロジックON --EN:--Logic ON
	proxy:PlayAnimation( 416 , 3301 );--トカゲ消えるアニメ --EN:-- Lizard Disappearing Anime
	proxy:SendEventRequest( 416 , 0, -1 );
	print("OnEvent_723 end");
end


--------------------------------------------------------------------------------------
--■725■トカゲ移動３■ --EN:-- ■ 725 ■ lizard movement 3 ■
--------------------------------------------------------------------------------------
function OnEvent_725(proxy,param)
	if proxy:IsCompleteEvent( 725 ) == false then
		print("OnEvent_725 begin");
		proxy:NotNetMessage_begin();
			proxy:OnKeyTime2( 725 , "OnEvent_725_1",0,0,0,once);
		proxy:NotNetMessage_end();
		
		print("OnEvent_725 end");
	end
end

--配信用 --EN:--For delivery
function OnEvent_725_1(proxy,param)
	print("OnEvent_725_1 begin");	
	
	proxy:EnableLogic( 417 , true );
	proxy:ResetThink( 417 );
	proxy:SendEventRequest( 417 , 0 , 0);
	--▼727▼領域(2268)への到着監視▼ --EN:--▼727▼Arrival monitoring for area (2268)▼
	proxy:OnRegionJustIn( 727 , 417 , 2268 , "OnEvent_727" , once );	
	--イベントフラグセット	 --EN:--event flag set
	proxy:SetEventFlag( 725 , 1 );--領域用 --EN:--for area
	proxy:SetEventFlag( 726 , 1 );--ダメージ監視用 --EN:--For damage monitoring
	
	proxy:DeleteEvent(725);
	proxy:DeleteEvent(726);	
	print("OnEvent_725_1 end");	
end

--領域に到着 --EN:--arrive in territory
function OnEvent_727(proxy,param)
	print("OnEvent_727 begin");
	proxy:SetEventFlag( 727 , 1 );--領域(2268)に到着済み --EN:-- Arrived in area (2268)
	proxy:ChangeInitPosAng( 417 , 2268 );--初期位置の領域を(2237に)更新する	 --EN:--Update the initial position area (to 2237)
	proxy:EnableLogic( 417 , true );--ロジックON --EN:--Logic ON
	proxy:PlayAnimation( 417 , 3301 );--トカゲ消えるアニメ --EN:-- Lizard Disappearing Anime
	proxy:SendEventRequest( 417 , 0, -1 );
	print("OnEvent_727 end");
end


--------------------------------------------------------------------------------------
--■541～546■岩石ミミズ飛び出し■ --EN:-- ■ 541～546 ■ rock earthworm popping out ■
--------------------------------------------------------------------------------------
function Func_RockWorm(proxy,actionId,targetId)
	print("OnEvent_",actionId," begin");
	ValidCharactor( proxy, targetId );
	proxy:StopLoopAnimation( targetId );
	proxy:ForcePlayAnimation(targetId, 9010 );
	proxy:EnableLogic( targetId, true );	
	proxy:SetEventFlag( actionId , true );	
	
	print("OnEvent_",actionId," end");
end

function OnEvent_541(proxy,param) Func_RockWorm(proxy,541,331); end
function OnEvent_542(proxy,param) Func_RockWorm(proxy,542,332); end
function OnEvent_543(proxy,param) Func_RockWorm(proxy,543,333); end
function OnEvent_544(proxy,param) Func_RockWorm(proxy,544,334); end
function OnEvent_545(proxy,param) Func_RockWorm(proxy,545,335); end
function OnEvent_546(proxy,param) Func_RockWorm(proxy,546,336); end


--------------------------------------------------------------------------------------
--■730～734■ウィルオウィスプ爆発■ --EN:-- ■ 730～734 ■ Will O'Wisp Explosion ■
--------------------------------------------------------------------------------------
function Func_WispBomb(proxy,actionId,ownerId,targetId)
	print("OnEvent_",actionId," begin");	
	proxy:DeleteObjSfxEventID( targetId );
	proxy:CastPointSpell_Horming( ownerId,targetId, 10160 , 0,0,0, targetId);
	proxy:SetEventFlag(actionId,true);
	
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( actionId, "WispRumble",1.2,0,targetId,once);
	proxy:NotNetMessage_end();
	
	print("OnEvent_",actionId," end");
end

function OnEvent_730(proxy,param) Func_WispBomb(proxy,730,400,1300); end
function OnEvent_731(proxy,param) Func_WispBomb(proxy,731,400,1301); end
function OnEvent_732(proxy,param) Func_WispBomb(proxy,732,400,1302); end
function OnEvent_733(proxy,param) Func_WispBomb(proxy,733,400,1303); end
function OnEvent_734(proxy,param) Func_WispBomb(proxy,734,400,1304); end

function WispRumble(proxy,param)
	print("WispRumble begin");
	proxy:AddRumble(121, param:GetParam3(), -1,1.0, 25.0);
	print("WispRumble end");
end
--------------------------------------------------------------------------------------
--■702■獄吏追ってくる■ --EN:-- ■ 702 ■ Jailer chasing ■
--------------------------------------------------------------------------------------
--[[
function OnEvent_702(proxy,param)
	print("OnEvent_702 begin");--獄吏イベント割り込み --EN:--Prisoner event interrupt
	if proxy:IsCompleteEvent(702) == false then
		MoveRegion(proxy, 410, 2276, 20 ,0.0,false);
		proxy:SetEventFlag( 702,true );
	end
	print("OnEvent_702 end");
end
]]

--------------------------------------------------------------------------------------
--■800■蛮族１■ --EN:-- ■ 800 ■ Barbarian 1 ■
--------------------------------------------------------------------------------------
function OnEvent_800(proxy,param)
	print("OnEvent_800 begin");
	proxy:SetEventFlag( 800 , true );
	print("OnEvent_800 end");
end

--------------------------------------------------------------------------------------
--■802■蛮族２■ --EN:-- ■ 802 ■ Barbarian 2 ■
--------------------------------------------------------------------------------------
function OnEvent_802(proxy,param)
	print("OnEvent_802 begin");
	proxy:SetEventFlag( 802 , true );
	print("OnEvent_802 end");
end


--------------------------------------------------------------------------------------
--■■岩ミミズ弱点部位登録用■ --EN:--■■For registering weak points of rock earthworms■
--------------------------------------------------------------------------------------
function RegistRockWorm( proxy, eventId , eneId )
	if proxy:CreateEventBody( eventId,eneId,"dummy",1000000,ROCKWORM_DAMAGE_RATE,once) == true then
	print("Create EventBody by RockWorm :",eneId);
		proxy:AddEventParts(eventId,eneId,"Ragdoll_Head01");
		proxy:AddEventParts(eventId,eneId,"Ragdoll_Body09");
	else
		print("Faild EventBody by RockWorm :",eneId);
	end
end

--岩ミミズ弱点部位からイベントが呼ばれた場合 --EN:--When an event is called from the rock worm's weak point
function dummy(proxy,param)
	print("dummy begin");
	proxy:WARN("EventBody　WARN"); --EN:proxy:WARN("EventBody　WARN");
	print("dummy end");
end

