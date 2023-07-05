
--------------------------------------------------------------------------------------
--マップ読み込み時に読まれる初期化処理■ --EN:--Initialization process read when reading the map ■
--------------------------------------------------------------------------------------
function Initialize_m06_02_00_00(proxy)
	print("Initialize_m06_02_00_00 begin");
-----------------------------------------------------------------------------------------
--ボス関連 --EN:--Boss related
-----------------------------------------------------------------------------------------
--■1050■ボス部屋に入る■ --EN:-- ■ 1050 ■ Enter the boss room ■
	
	--中ボスが生きているときだけイベント登録 --EN:-- Event registration only when the mid-boss is alive
	if proxy:IsCompleteEvent( 6400 ) == false then
	
		--ソロのときは一度目にボス部屋に入る用のイベントを毎回登録させたいので、対応するフラグをOFFにする。 --EN:-- When soloing, we want to register the event for entering the boss room for the first time every time, so turn off the corresponding flag.
		SingleReset(proxy, 1050);
		
		--▽同期アニメ再生用の開始ハンドラ(旋回→歩き) --EN:--▽ Start handler for synchronous animation playback (turning → walking)
		proxy:LuaCall( 1051, 1, "OnEvent_1051_1", everytime );
		--▽2回目以降にボス部屋に入るためのイベント配信用 --EN:--▽For event delivery to enter the boss room after the second time
		proxy:LuaCall( 1051 , 5 , "OnEvent_1050_GO_TO_IN" , everytime );
		--▽フラグセット(同期用) --EN:--▽flag set (for synchronization)
		proxy:LuaCall( 1051 , 6 , "OnEvent_1050_flag_set" , everytime );

		--誰かがボス前扉をまだ通過していない --EN:--Someone hasn't passed through the boss front door yet
		if proxy:IsCompleteEvent( 1050 ) == false then
		
			--(セッション中に)ボス前の魔法壁を最初に通れるのは生存の人だけ --EN:--(During the session) Only survivors can pass through the magic wall in front of the boss first
			local possible_chr_type = ATTR_HOST + ATTR_LIVE + ATTR_GREY;
			
			proxy:NotNetMessage_begin();
				--▼1050▼中に入るためのイベントを追加▼ --EN:--▼1050▼Add an event to enter▼
				proxy:OnPlayerActionInRegionAttribute( 1050, 2893, "OnEvent_1050", HELPID_GO_TO_IN, possible_chr_type, everytime );
			proxy:NotNetMessage_end();
			
		else --グレイゴーストできたときようにいると思われる。 --EN:--Gray ghost seems to be like that when it's done.
		
			proxy:NotNetMessage_begin();
				--▼1051▼中に入るためのイベントを追加▼--ハンドラは上と同じ --EN:--▼1051▼Add an event to enter inside▼--The handler is the same as above
				proxy:OnPlayerActionInRegion( 1051, 2893, "OnEvent_1050", HELPID_GO_TO_IN, everytime );
			proxy:NotNetMessage_end();
		
		end
	end
	

--■1052■ボス戦闘開始■ --EN:-- ■ 1052 ■ Boss battle begins ■
	if proxy:IsCompleteEvent( 6400 ) == false then
		proxy:OnRegionJustIn( 1052 , 10000 , 2885 , "OnEvent_1052" , once );		
		proxy:OnRegionJustIn( 1053 , 10000 , 2883 , "OnEvent_1053" , once );
	end
	

--■6400■エリアボス死亡■ --EN:-- ■ 6400 ■ Area Boss Death ■
	proxy:AddFieldInsFilter( 825 );
	if proxy:IsCompleteEvent( 6400 ) ==false then
		proxy:OnCharacterDead(6400, 825, "OnEvent_6400", once);
	end

	--■ボス関連の初期化処理 --EN:--■ Boss-related initialization processing
	if proxy:IsCompleteEvent( 6400 ) ==true then
		
		--▽ボス死んでいるとき --EN:--▽When the boss is dead
		--ボスいなくなる --EN:--boss disappears
		InvalidBackRead( proxy , 825 );
		
		--魔法壁消える(このマップは魔法壁一つ) --EN:--Magic wall disappears (this map has one magic wall)
		proxy:SetColiEnable( 1993 , false );
		proxy:SetDrawEnable( 1993 , false );	

		--魔法壁のSFX OFF --EN:--Magic Wall SFX OFF
		proxy:InvalidSfx( 1985 , true );
		
	else
	    --▽ボス生きているとき --EN:--▽ When the boss is alive
		if proxy:IsClient() == false  then
			proxy:EnableLogic( 825 , false );--ロジックOFFで待機 --EN:--Wait with logic OFF
		end		
	end	
	
	
	--■6403,6404■ソウル入手、要石でワープ■ --EN:-- ■ 6403, 6404 ■ Get soul, warp with keystone ■
	if proxy:IsCompleteEvent( 6400 ) ==true then--ボスが死んでいるとき --EN:--when the boss is dead
		
		--▼(ソウル)アイテム取得用イベント監視追加▼ --EN:--▼ (Soul) Added event monitoring for item acquisition▼
		if proxy:IsCompleteEvent( 6403 ) == false then
			--SFX ON
			proxy:ValidSfx( 2400 );--光の粒子 --EN:--Particles of light
			proxy:ValidSfx( 2401 );--要石のオーラ --EN:--Keystone Aura
			proxy:TreasureDispModeChange2( 1980 , true ,KANAME_SFX);--光らせる --EN:-- let it shine
			proxy:OnDistanceActionAttribute( 6403 , 10000 , 1980 , "OnEvent_6403" , WarpGimmickDist_A , 10010180 , 0 , 180 , ATTR_HOST + ATTR_LIVE + ATTR_GREY, once );

			--ソウル有効化 --EN:--Soul activation
			proxy:SetDrawEnable( 1980 , true );
			proxy:SetColiEnable( 1980 , true );
			--ソウル2有効化 --EN:--Activate Soul 2
			proxy:SetDrawEnable( 1977 , true );
			proxy:SetColiEnable( 1977 , true );

		else
			--SFXが消える --EN:--SFX disappear
			SingleReset(proxy,6404);
			proxy:InvalidSfx( 2400 , false );--光の粒子 --EN:--Particles of light
			--proxy:InvalidSfx( 2401 , false );--要石のオーラ --EN:--Keystone Aura
			proxy:TreasureDispModeChange2( 1980 , true ,KANAME_SFX);--光らせる --EN:-- let it shine
			--▼要石でワープ用の監視を追加▼ --EN:--▼ Added surveillance for warp with keystone ▼
			proxy:OnDistanceActionAttribute( 6404 , 10000 , 1980 , "OnEvent_6404" , WarpGimmickDist_A , HELPID_GO_TO_SEKITYUU , 0 , 180 , ATTR_NOSESSION , everytime );
		end

	else
		--ソウル無効化 --EN:--Soul Invalidation
		proxy:SetDrawEnable( 1980 , false );
		proxy:SetColiEnable( 1980 , false );
		--ソウル2無効化 --EN:--Soul 2 disabled
		proxy:SetDrawEnable( 1977 , false );
		proxy:SetColiEnable( 1977 , false );
		--SFXが消える --EN:--SFX disappear
		proxy:InvalidSfx( 2400 , false );--光の粒子 --EN:--Particles of light
		proxy:InvalidSfx( 2401 , false );--要石のオーラ --EN:--Keystone Aura
	end

	--ボスがその場で立ってくれるように、重力Off --EN:-- Gravity off so that the boss can stand on the spot
	proxy:SetDisableGravity( 825, true );

-----------------------------------------------------------------------------------------
--ギミック関連 --EN:--Gimmick related
-----------------------------------------------------------------------------------------
	--縫い付け槍をとりあえず削除 --EN:--Remove the sewn spear for the time being
	proxy:SetDrawEnable(1400 ,false);
	proxy:SetColiEnable(1400 ,false);
	proxy:SetDrawEnable(1401 ,false);
	proxy:SetColiEnable(1401 ,false);
	proxy:SetDrawEnable(1402 ,false);
	proxy:SetColiEnable(1402 ,false);
	

--■1060■光の剣発射機①起動■ --EN:-- ■ 1060 ■ Light sword launcher ■
	if proxy:IsCompleteEvent( 6400 ) == false then
		SingleReset(proxy,1060);
		SingleReset(proxy,1062);
	end
	if proxy:IsCompleteEvent( 1060 ) == false then
		--proxy:LuaCall(1060, 1, "OnEvent_1060", once);
		proxy:OnPlayerActionInRegionAngle( 1060 , 2410 , "OnEvent_1060", 90 , HELPID_START , once);
		proxy:OnPlayerActionInRegionAngle( 1062 , 2412 , "OnEvent_1062", 90 , HELPID_START , once); 
	end
	
--■6410■ボス片方縫いつけポリ劇■ --EN:-- ■ 6410 ■ Boss side stitched poly play ■
	if proxy:IsCompleteEvent( 6400 ) == false then
		SingleReset(proxy,6410);
	end
	if proxy:IsCompleteEvent( 6410 ) == false then--ポリ劇がまだ再生されていなければ --EN:--if the polyplay hasn't played yet
		--ポリ劇配信用 --EN:--For poly drama distribution
		proxy:LuaCall(6410, 20 ,"OnEvent_6410_1",once);
		proxy:NotNetMessage_begin();
			--ポリ劇開始に呼ばれるハンドラ --EN:--handler called at polyplay start
			proxy:LuaCall(6410, REMO_START, "OnEvent_6410_RemoStart", once);
			--ポリ劇終了後に呼ばれるハンドラ(トリガー起こした人用) --EN:--Handler called after the end of the polyplay (for the person who caused the trigger)
			proxy:LuaCall(6410, REMO_FINISH, "OnEvent_6410_RemoFinish", once);
		proxy:NotNetMessage_end();
		
		--破壊後台座の削除 --EN:--Delete pedestal after destruction
		proxy:SetDrawEnable(1440 ,false);
		proxy:SetColiEnable(1440 ,false);
		
	else--すでにポリ劇が終了していたら --EN:--If the police drama has already ended
		OnEvent_6412(proxy, param);--光の剣発射機モデル差し替え --EN:--Light sword launcher model replacement
		OnEvent_6413(proxy, param);--壁モデル差し替え --EN:--Wall model replacement
		--バリスタSFX削除 --EN:--Remove barista SFX
		proxy:InvalidSfx(2470, false);
	end

--■1061■光の剣発射機②起動■ --EN:-- ■ 1061 ■ Light sword launcher ■
	if proxy:IsCompleteEvent( 6400 ) == false then
		SingleReset( proxy,1061 );
		SingleReset( proxy,1063 );
	end
	if proxy:IsCompleteEvent( 1061 ) == false then
		--proxy:LuaCall(1061, 1, "OnEvent_1061", once);
		proxy:OnPlayerActionInRegionAngle( 1061 , 2411 , "OnEvent_1061" , 90, HELPID_START , once );
		proxy:OnPlayerActionInRegionAngle( 1063 , 2413 , "OnEvent_1063" , 90, HELPID_START , once );
	end

--■6411■ボス両方つい付けポリ劇■ --EN:-- ■ 6411 ■ Boss both unintentional police play ■
	if proxy:IsCompleteEvent( 6400 ) == false then
		SingleReset( proxy,6411 );
	end
	if proxy:IsCompleteEvent( 6411 ) == false then--ポリ劇が流れていないならば --EN:--If the police drama is not playing
		proxy:LuaCall(6411,20,"OnEvent_6411_1",once);
		proxy:NotNetMessage_begin();
			--ポリ劇開始に呼ばれるハンドラ --EN:--handler called at polyplay start
			proxy:LuaCall(6411, REMO_START, "OnEvent_6411_RemoStart", once);
			--ポリ劇終了後に呼ばれるハンドラ(トリガー起こした人用) --EN:--Handler called after the end of the polyplay (for the person who caused the trigger)
			proxy:LuaCall(6411, REMO_FINISH, "OnEvent_6411_RemoFinish", once);
		proxy:NotNetMessage_end();
		--OBJ1432無効 --EN:--OBJ1432 disabled
		proxy:SetDrawEnable( 1432 ,false);
		proxy:SetColiEnable( 1432 ,false);	
	else--ポリ劇がながれていたら --EN:--If the police drama was flowing
		--OBJ1432有効（はじめから有効） --EN:--OBJ1432 enabled (enabled from the beginning)
		--OBJ1431無効 --EN:--OBJ1431 disabled
		--バリスタSFX削除 --EN:--Remove barista SFX
		proxy:InvalidSfx(2471, false);
		proxy:SetDrawEnable( 1431 ,false);
		proxy:SetColiEnable( 1431 ,false);	

		--縫いつけ槍有効化 --EN:--Sew spear enabled
		proxy:SetDrawEnable(1401 ,true);
		proxy:SetColiEnable(1401 ,true);
		proxy:SetDrawEnable(1402 ,true);
		proxy:SetColiEnable(1402 ,true);
	end

--■6412■光の剣発射機モデル差し替え■ --EN:-- ■ 6412 ■ Light sword launcher model replacement ■
	--(OnEvent_6410 から連動) --EN:--(linked from OnEvent_6410)

--■6413■壁モデル差し替え■ --EN:-- ■ 6413 ■ Wall model replacement ■
	--(OnEvent_6410 から連動) --EN:--(linked from OnEvent_6410)

--■8088■坑道に来たフラグを立てる■ --EN:--■ 8088 ■ Raise a flag for coming to the tunnel ■
	proxy:SetEventFlag( 8088, true );

--------------------------------▽▽▽QWCイベント関連▽▽▽-------------------------------- --EN:--▽▽▽QWC event related ▽▽▽--------------------------------
	
--■1110■グラムを表示させる■ --EN:-- ■ 1110 ■ display the gram ■
	SingleReset(proxy,1110);
	if 	proxy:IsSuccessQWC( 60140 ) == false and
		proxy:IsCompleteEvent(1114) == false then	
		proxy:SetEventFlag( 1110, true );
	end
	
	--QWCか既に通過が成立しているので非表示 --EN:--Not displayed because QWC or passage has already been established
	if proxy:IsCompleteEvent( 1110 ) == false then
		proxy:SetDrawEnable( 1433, false );
		proxy:SetColiEnable( 1433, false );
	end

--■1114■グラムに近づけた■ --EN:-- ■ Close to 1114 ■ grams ■
	if proxy:IsCompleteEvent(1114) == false then
		if proxy:IsClient() == false then
			proxy:NotNetMessage_begin();
				proxy:OnRegionJustIn( 1114 , 10000 , 2480 , "OnEvent_1114",once);
			proxy:NotNetMessage_end();
		end
	end
		
--■1111■ＰＣがグラムを引き抜く■ --EN:--■1111■PC pulls Gram■
	if proxy:IsCompleteEvent( 1111 ) == false then
		--ホスト、生存、グレイのみ調べることができる --EN:--Only hosts, survivors, and grays can be examined
		local possible_chr_type = ATTR_HOST + ATTR_LIVE + ATTR_GREY;
		
		proxy:OnDistanceActionAttribute( 1111 , 10000 , 1434 , "OnEvent_1111" , ItemBoxDist_A , 10010125 , 0 , ItemBoxAngle_A ,possible_chr_type, everytime ); 
		proxy:LuaCall( 1111,1,"OnEvent_1111_2",once);
		proxy:LuaCall( 1111,2,"OnEvent_1111_3",once);
		proxy:TreasureDispModeChange2( 1434, true ,KEN_SFX);
	else
		proxy:SetDrawEnable( 1434 , false );--ひとまず描画だけOFF --EN:--Only drawing is turned off for the time being
		proxy:SetColiEnable( 1434 , false );
	end
	
	--proxy:SetRarity( 1434, 10626 );

--------------------------------△△△QWCイベント関連△△△-------------------------------- --EN:--△△△QWC event related△△△--------------------------------
--■??■徘徊デーモンの登場■ハンドラ登録 --EN:--■??■Appearance of wandering daemon■Handler registration
	proxy:NotNetMessage_begin();
		--プレイヤーがソロで死亡した時にキックされます。 --EN:--Kicked when a player dies solo.
		proxy:LuaCall( 4000, 100, "PlayerDeath_m06_02_00_00", everytime );
		--プレイヤーが復活した時にキックされます。 --EN:--Kicked when the player is revived.
		proxy:LuaCall( 4032, 100, "PlayerRevive_m06_02_00_00", everytime );
	proxy:NotNetMessage_end();
	
	--■1120■ウィルオウィスプ■ --EN:-- ■ 1120 ■ Will O Wisp ■
	SingleReset( proxy , 1120 );
	if proxy:IsCompleteEvent( 1120 ) == false then
		proxy:OnPlayerDistanceInTarget( 1120 , 10000 , 1441 , "OnEvent_1120",2.0,once);
		proxy:SetObjSfx( 1441 , 1 , 96001 , true );
	end
	
	--■1121■ウィルオウィスプ■ --EN:-- ■ 1121 ■ Will O Wisp ■
	SingleReset( proxy , 1121 );
	if proxy:IsCompleteEvent( 1121 ) == false then
		proxy:OnPlayerDistanceInTarget( 1121 , 10000 , 1442 , "OnEvent_1121",2.0, once);
		proxy:SetObjSfx( 1442 ,1 , 96001 , true );
	end
	
	
	--■999999■フレーム遅れの初期化処理イベントを発行■ --EN:-- ■ 999999 ■ Generate a frame delay initialization processing event ■
	proxy:NotNetMessage_begin();
		--▼0秒後▼-- --EN:--▼After 0 seconds▼--
		proxy:OnKeyTime2( 999992, "Second_Initialize_m06_02_00_00", 0.3, 0, 0, once );	
	proxy:NotNetMessage_end();	
	
	print("Initialize_m06_02_00_00 end");
end

--------------------------------------------------------------------------------------
--Initializeから呼ばれる、1フレーム遅れの初期化処理■999999 --EN:--Initialization with a delay of 1 frame, called from Initialize ■999999
--------------------------------------------------------------------------------------
--■999999■一部、Initでは処理できないので、残しておく --EN:-- ■ 999999 ■ Some parts cannot be processed by Init, so leave them
function Second_Initialize_m06_02_00_00(proxy, param)
	print("Second_Initialize_m06_02_00_00 begin");

--------------------------------▽▽▽QWCイベント関連▽▽▽-------------------------------- --EN:--▽▽▽QWC event related ▽▽▽--------------------------------
--------------------------------△△△QWCイベント関連△△△------------------------------- --EN:--△△△QWC event related△△△----------------------------------

	print("Second_Initialize_m06_02_00_00 end");
end

--------------------------------------------------------------------------------------
--マルチになった時にホストじゃ無かったら■無し --EN:--If you are not a host when you become multi, no
--------------------------------------------------------------------------------------
function ConnectPartyEvent(proxy)
	print("ConnectPartyEvent begin");
	print("ConnectPartyEvent end");
end




--------------------------------------------------------------------------------------
--■6400■エリアボス死亡■ --EN:-- ■ 6400 ■ Area Boss Death ■
--------------------------------------------------------------------------------------
--■6400■エリアボス死亡■ --EN:-- ■ 6400 ■ Area Boss Death ■
function OnEvent_6400(proxy, param)
	print("OnEvent_6400 begin");
		
	proxy:NotNetMessage_begin();
		--▼6401▼クライアントPCワープ演出▼ --EN:--▼6401▼Client PC warp effect▼
		proxy:OnKeyTime2( 6401, "OnEvent_6401", 0, 0, 0, once);
		--▼6400_1▼1秒経過▼ --EN:--▼6400_1▼1 second passed▼
		proxy:OnKeyTime2( 6400, "OnEvent_6400_1", 1, 0, 1, once);
		--▼6402▼2秒経過▼ --EN:--▼6402▼2 seconds passed▼
		proxy:OnKeyTime2( 6402, "OnEvent_6402", 2, 0, 2, once);
		--マルチ解散監視 --EN:--Multi-Dismissal Monitoring
		proxy:OnRegistFunc( 6400 ,"Check_6400_PT","OnEvent_6400_PT",0,once);
	proxy:NotNetMessage_end();
	
	proxy:SetEventFlag( 6400, 1 );
	
	--ブロッククリア処理へ --EN:-- to block clear processing
	proxy:CustomLuaCallStart( 4050, 825 );	
	--トカゲリセット --EN:-- lizard reset
	ResetTokage(proxy);
	
	--[[
	--王城3開放インフォメーション --EN:--Castle 3 opening information
	if proxy:IsClient() == false then
		if proxy:IsCompleteEvent( 8050 ) == false then
			proxy:NotNetMessage_begin();
				print("Call to OnEent_8050");
				proxy:OnKeyTime2( 8050 , "OnEvent_8050",5.0,0,0,once);
				proxy:SetEventFlag( 8050 , true );
			proxy:NotNetMessage_end();		
		end	
	end
	]]
		
	print("OnEvent_6400 end");
end

--▲6400_1▲中ボス死亡後1秒▲ --EN:--▲6400_1▲1 second after death of mid-boss▲
function OnEvent_6400_1(proxy, param)
	print("OnEvent_6400_1 begin");
	
	--ボスを倒した数を更新(数によってフラグを立てる) --EN:--update number of bosses killed (flag by number)
	GetBossFlagCount( proxy, param );
	
	--▼トロフィー取得判定▼ --EN:--▼Trophy Acquisition Judgment▼
	Lua_RequestUnlockTrophy(proxy, 10);--トロフィ状況を判定し、トロフィ取得 --EN:-- Determine the trophy situation and acquire the trophy
	
	--▼(ソウル)アイテム取得用イベント監視追加▼ --EN:--▼ (Soul) Added event monitoring for item acquisition▼
	if proxy:IsCompleteEvent( 6403 ) == false then
	
		--ソウル有効化 --EN:--Soul activation
		proxy:SetDrawEnable( 1980 , true );
		proxy:SetColiEnable( 1980 , true );
		--ソウル2有効化 --EN:--Activate Soul 2
		proxy:SetDrawEnable( 1977 , true );
		proxy:SetColiEnable( 1977 , true );
		
		--SFX ON
		proxy:ValidSfx( 2400 );--光の粒子 --EN:--Particles of light
		proxy:ValidSfx( 2401 );--要石のオーラ --EN:--Keystone Aura
		
		proxy:TreasureDispModeChange2( 1980 , true ,KANAME_SFX);--光らせる --EN:-- let it shine
		proxy:OnDistanceActionAttribute( 6403 , 10000 , 1980 , "OnEvent_6403" , WarpGimmickDist_A , 10010180 , 0 , 180 , ATTR_HOST + ATTR_LIVE + ATTR_GREY, once );
	else
		--ソウル無効化(取ったら消えるので･･･) --EN:--Soul nullification (because it disappears when you take it...)
		proxy:SetDrawEnable( 1980 , false );
		proxy:SetColiEnable( 1980 , false );
	end

	--坑道クリアフラグON --EN:-- Mine Clear Flag ON
	if proxy:IsLivePlayer() == true or proxy:IsGreyGhost() == true then
		proxy:SetEventFlag( 8014 , 1 );
	end	
	
	print("OnEvent_6400_1 end");
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
--■6401■クライアントPCワープ演出■ --EN:-- ■ 6401 ■ Client PC warp effect ■
--------------------------------------------------------------------------------------

--■6401■クライアントPCワープ演出■ --EN:-- ■ 6401 ■ Client PC warp effect ■
function OnEvent_6401(proxy, param)
	print("OnEvent_6401 begin");

	if proxy:IsClient() == true then
		proxy:PlayAnimation( 10000 , 8284 );--ワープアニメを再生 --EN:-- Play warp animation
	end

	proxy:SetEventFlag( 6401 , 1 );
	
	print("OnEvent_6401 end");
end


--------------------------------------------------------------------------------------
--■6402■シングル：光の壁、BGM消去■ --EN:-- ■ 6402 ■ Single: Wall of Light, BGM Elimination ■
--------------------------------------------------------------------------------------

--■6402■シングル：光の壁、BGM消去■ --EN:-- ■ 6402 ■ Single: Wall of Light, BGM Elimination ■
function OnEvent_6402(proxy, param)
	print("OnEvent_6402 begin");

	--ボス戦用のBGM停止 --EN:--BGM stop for boss battles
	proxy:StopPointSE( 2 );

	proxy:SetEventFlag( 6402 , 1 );
	
	print("OnEvent_6402 end");
end

--マルチ解散監視 --EN:--Multi-Dismissal Monitoring
function Check_6400_PT(proxy)
	if proxy:IsInParty() == false then
		return true;
	end
	return false;
end

--マルチじゃない --EN:--not multiplayer
function OnEvent_6400_PT(proxy,param)
	print("OnEvent_6400_PT begin");
	--中ボス部屋の前後の魔法壁が消える(全プレイヤー) --EN:--The magic walls before and after the mid-boss room disappear (all players)
	proxy:SetColiEnable( 1993 , false );
	proxy:SetDrawEnable( 1993 , false );	
	
	--中ボス部屋魔法壁のSFX削除 --EN:--Remove the SFX of the mid-boss room magic wall
	proxy:InvalidSfx( 1985 , true );

	--中ボス部屋前の移動処理イベントを削除 --EN:--Delete the movement processing event in front of the mid-boss room
	proxy:DeleteEvent( 1050 );--一人目が入るとき用 --EN:--For when the first person enters
	proxy:DeleteEvent( 1051 );--二人目以降が入るとき用 --EN:--For when the second and subsequent people enter
	proxy:DeleteEvent( 1030 );--ポリ劇再生用 --EN:--For polyplay play
	proxy:DeleteEvent( 1052 );--ボス戦闘開始用	 --EN:--For boss battle start
	print("OnEvent_6400_PT end");
end




--------------------------------------------------------------------------------------
--■6403■ソウル入手■ --EN:-- ■ 6403 ■ Get Soul ■
--------------------------------------------------------------------------------------

function OnEvent_6403(proxy, param)
	print("OnEvent_6403 begin");
	
	--プレイヤーの同期アニメーション(true:パーティープレイヤーがアニメーションした) --EN:--Player synchronous animation (true: party player animated)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_PICK ) == true then--新しいアニメ  --EN:-- new anime
		print("OnEvent_6403 end");
		return true;
	end
	
	proxy:NotNetMessage_begin();
		--0.0秒後にアイテム取得イベントを発行 --EN:-- Issue an item acquisition event after 0.0 seconds
		proxy:OnKeyTime2( 6403, "OnEvent_6403_1", 0.0, 0, 0, once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_6403 end");
end


--■6403_1■アイテム取得■ --EN:-- ■ 6403_1 ■ item acquisition ■
function OnEvent_6403_1(proxy, param)
	print("OnEvent_6403_1 begin");

	--アイテム取得関数--パラメータ10632参照 --EN:--item retrieval function--see parameter 10632
	proxy:GetRateItem(10632);	
	--アイテム取得関数--パラメータ10678参照 --EN:--item retrieval function--see parameter 10678
	proxy:GetRateItem(10678);	
	--アイテム取得関数--パラメータ10679参照 --EN:--item retrieval function--see parameter 10679
	proxy:GetRateItem(10679);	
	--アイテム取得関数--パラメータ10680参照 --EN:--item retrieval function--see parameter 10680
	proxy:GetRateItem(10680);	
	--アイテム取得関数--パラメータ10681参照 --EN:--item retrieval function--see parameter 10681
	proxy:GetRateItem(10681);	
	
	--アイテムを取得済み --EN:--item already acquired
	proxy:SetEventFlag( 6403, 1 );
	
	--SFXが消える --EN:--SFX disappear
	proxy:InvalidSfx( 2400 , true );--光の粒子 --EN:--Particles of light
	--proxy:InvalidSfx( 2401 , true );--要石のオーラ --EN:--Keystone Aura
	
	if proxy:IsCompleteEvent( 8035 ) == false then
		proxy:NotNetMessage_begin();
			--瞬間で表示するとメニューが先に出るので待つ --EN:--If you display it instantly, the menu will appear first, so wait
			proxy:OnKeyTime2( 8035 , "OnEvent_8035_wait",0.5 , 0 , 1, once);			
		proxy:NotNetMessage_end();
	else
		--▼要石でワープ用の監視を追加▼ --EN:--▼ Added surveillance for warp with keystone ▼
		proxy:OnDistanceActionAttribute( 6404 , 10000 , 1980 , "OnEvent_6404" , WarpGimmickDist_A , HELPID_GO_TO_SEKITYUU , 0 , 180 , ATTR_NOSESSION , everytime );
	end	

	print("OnEvent_6403_1 end");
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
	proxy:OnDistanceActionAttribute( 6404 , 10000 , 1980 , "OnEvent_6404" , WarpGimmickDist_A , HELPID_GO_TO_SEKITYUU , 0 , 180 , ATTR_NOSESSION , everytime );
	print("OnEvent_8035 end");
end



--------------------------------------------------------------------------------------
--石柱にワープ(ボス倒した後用)■6404 --EN:-- Warp to the stone pillar (for after defeating the boss) 6404
--------------------------------------------------------------------------------------
--■6404■石柱にワープ■ --EN:-- ■ 6404 ■ Warp to the stone pillar ■
function OnEvent_6404(proxy,param)	

	if proxy:IsCompleteEvent( 6404 ) == true then
		return;
	end	

	print("OnEvent_6404 begin");
	
	proxy:RepeatMessage_begin();
		--▼6404_1▼選択メニューの監視▼ --EN:--▼6404_1▼Monitor selection menu▼
		proxy:OnSelectMenu(6404, "OnEvent_6404_0", 10010710, 0, 2, 1980, 2, once);			
	proxy:RepeatMessage_end();
	
	print("OnEvent_6404 end");
end

--▲6404_0▲選択メニューの監視▲ --EN:--▲6404_0▲Monitor selection menu▲
function OnEvent_6404_0(proxy, param)
	print("OnEvent_6404_0 begin");
	
	if proxy:IsSession() == false then
		
		proxy:PlayAnimation( 10000 , 8283 );--要石に触れるアニメを再生 --EN:--Play the animation that touches the keystone
		proxy:NoAnimeTurnCharactor( 10000 , 1980 ,TURNSKIP_ANGLE);
		
		proxy:NotNetMessage_begin();
			--▼要石に触れるアニメ再生終了▼ --EN:--▼Animation touching the keystone ends▼
			proxy:OnChrAnimEnd( 6404 , 10000 , 8283 , "OnEvent_6404_1" , once );
		proxy:NotNetMessage_end();
		
		proxy:SetEventFlag( 6404 , 1 );
	else
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010720, 0, 6, 1983, GEN_DIALOG_DIST, once );
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
	end
	
	print("OnEvent_6404_0 end");
end

--▲6404_1▲選択メニューの監視▲ --EN:--▲6404_1▲Monitor selection menu▲
function OnEvent_6404_1(proxy, param)
	print("OnEvent_6404_1 begin");
	
	proxy:SetEventFlag( 6404 , 0 );
	
	proxy:PlayAnimation( 10000 , 8284 );--要石に触れるアニメを再生 --EN:--Play the animation that touches the keystone
	
	proxy:SetEventFlag( 6404 , 1 );
	
	OnEvent_6404_2(proxy,param);
	
	print("OnEvent_6404_1 end");
end

--▲6404_2▲要石に触れるアニメ再生終了▲ --EN:--▲6404_2▲Ends playing the animation touching the keystone▲
function OnEvent_6404_2(proxy,param)	
	print("OnEvent_6404_2 begin");
	
	--石柱へ戻ってきた判定のフラグを立てる --EN:--Flag the judgment of returning to the stone pillar
	proxy:SetEventFlag(8083, true);
	
	proxy:SetEventFlag( 6404 , 0 );	
	--完全回復要求 --EN:-- full recovery request
	proxy:RequestFullRecover();
	proxy:WarpNextStage( 1, 0, 0, 0, 1010 );
	
	print("OnEvent_6404_2 end");
end



--------------------------------------------------------------------------------------
--徘徊デーモンの登場■?? --EN:-- Appearance of the Wandering Demon ??
--------------------------------------------------------------------------------------

--▼グローバルの死亡監視から呼ばれる(ソロ) --EN:--▼ Called from global death watch (solo)
function PlayerDeath_m06_02_00_00(proxy, param)
	print("PlayerDeath_m06_02_00_00");
	print("PlayerDeath_m06_02_00_00");
end

--▼グローバルの血文字復活から呼ばれる(ソロ) --EN:--▼Called from global blood letter revival (solo)
function PlayerRevive_m06_02_00_00(proxy,param)
	print("PlayerRevive_m06_02_00_00");
	print("PlayerRevive_m06_02_00_00");
end



--------------------------------------------------------------------------------------
--ボス部屋の中に入る■1050 --EN:--Enter the boss room 1050
--------------------------------------------------------------------------------------

--■イベントがループなので、全部リピートにする↓ --EN:--■ Since the event is a loop, repeat all ↓

--■1050■中ボス部屋への扉が開く■ --EN:-- ■ 1050 ■ The door to the mid-boss room opens ■
function OnEvent_1050(proxy,param)
	print("OnEvent_1050 begin");

	if proxy:IsCompleteEvent( SYSTEM_ID_IGNORE ) == true then
		print("OnEvent_1050 end");
		return;
	end
	
	--クライアントへ、ボス部屋阻止失敗を通知 --EN:--Notify client of failure to block boss room
	if proxy:IsClient() == false then
		proxy:LuaCallStart( 4068 , 1 );	
	end
	
	proxy:LuaCallStart( 1051 , 1 );--旋回アニメの同期再生 --EN:-- Synchronous playback of turning animation
	--proxy:SetEventFlag( SYSTEM_ID_IGNORE, true );
	--多重起動システムIDをタイムアウトを設定してONにする --EN:--Turn on multiple activation system ID by setting timeout
	proxy:SetSystemIgnore( SYSTEM_ID_IGNORE , IGNORE_TIME );
	
	--プロファイルセーブ要求 --EN:--profile save request
	proxy:SaveRequest_Profile();
	
	print("OnEvent_1050 end");
end


--旋回アニメの同期再生(IDが別) --EN:-- Synchronized playback of turning animation (ID is different)
function OnEvent_1051_1(proxy,param)
	print("OnEvent_1051_1 begin");
	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		if param:IsNetMessage() == true then
			--旋回アニメ再生を行い、その終了時にOnEvent_1051_2を発行する --EN:--Play the turning animation and issue OnEvent_1051_2 at the end
			proxy:TurnCharactor( 10001 + param:GetPlayID(), 2889 );
		else
			proxy:LockSession();--ルームをロックします！ --EN:--lock the room!
			--旋回アニメ再生を行い、その終了時にOnEvent_1051_2を発行する --EN:--Play the turning animation and issue OnEvent_1051_2 at the end
			proxy:OnTurnCharactorEnd( 1051, 10000, 2889, "OnEvent_1051_2", once );
		end
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	
	print("OnEvent_1051_1 end");
end

--旋回アニメの同期再生終了後 --EN:--After synchronous playback of turning animation ends
function OnEvent_1051_2(proxy,param)
	print("OnEvent_1051_2 begin");
	
	--同期用歩きアニメ再生 --EN:--Play walking animation for synchronization
	proxy:LuaCallStart( 4012, 1 );
	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		proxy:OnChrAnimEnd( 1051, 10000, ANIMEID_WALK, "OnEvent_1051_3", once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	
	print("OnEvent_1051_2 end");
end

--歩きアニメの同期再生終了後 --EN:--After the synchronized playback of the walking animation ends
function OnEvent_1051_3(proxy,param)
	print("OnEvent_1051_3 begin");

	--最初の人がボス部屋の中に入り終わっていたら、既に配信されているはずなので、もうおくらないハンドラ --EN:--If the first person has already entered the boss room, it should have already been delivered, so no more handlers
	if proxy:IsCompleteEvent( 1050 ) == false then
		proxy:LuaCallStart( 1051 , 5 );--2回目以降にボス部屋に入るためのイベント配信用 --EN:--For event delivery to enter the boss room after the second time
		proxy:LuaCallStart( 4045 , 1 );	--クライアントへ、ボス部屋に入れるようになったことを通知 --EN:--Notify clients that they can now enter the boss room
		proxy:LuaCallStart( 1051 , 6 );--フラグセット(同期用) --EN:--flag set (for synchronization)
		Lua_MultiDoping(proxy,825);--マルチプレイドーピング --EN:-- Multiplayer Doping
	end

	--プレイヤーが扉の中に完全にはいったタイミングで、ボスの思考をリセット --EN:--Reset the boss' thoughts when the player is completely inside the door
	--場所が悪いとプレイヤーを見つけれないため(攻撃してこない) --EN:--Because you can't find the player if the location is bad (they won't attack)
	if proxy:IsLivePlayer() == true or proxy:IsGreyGhost() == true then
		proxy:ResetThink( 825 );
	end
		
	proxy:SetEventFlag( SYSTEM_ID_IGNORE, false );
	
	print("OnEvent_1051_3 end");
end


--■1050 2回目以降にボス部屋に入るためのイベント配信用 --EN:--■ 1050 For event delivery to enter the boss room after the second time
function OnEvent_1050_GO_TO_IN(proxy, param)
	print("OnEvent_1050_GO_TO_IN begin");

	proxy:NotNetMessage_begin();
		--▼1051▼扉が開いているときに中に入るためのイベントを追加▼--ハンドラは OnEvent_1050 --EN:--▼1051▼Add an event to enter when the door is open▼--The handler is OnEvent_1050
		proxy:OnPlayerActionInRegion( 1051, 2893, "OnEvent_1050", HELPID_GO_TO_IN, everytime );--
		
		proxy:OnKeyTime2( 1051 , "StandBy_DragonDemon",0.5,0,0,once);
	proxy:NotNetMessage_end();	
	
	print("OnEvent_1050_GO_TO_IN end");
end


--■1050 フラグセット(同期用) --EN:-- 1050 flag set (for synchronization)
function OnEvent_1050_flag_set(proxy, param)
	print("OnEvent_1050_flag_set begin");
		
	proxy:SetEventFlag( 1050 , 1 );
	proxy:DeleteEvent( 1050 );

	print("OnEvent_1050_flag_set end");
end



--------------------------------------------------------------------------------------
--ボスが動き出す(戦闘開始)■1052 --EN:--Boss begins to move (battle starts) 1052
--------------------------------------------------------------------------------------
function OnEvent_1052(proxy, param)
	print("OnEvent_1052 begin");	
	
	--ボスロジックON --EN:--Boss logic ON
	proxy:EnableLogic( 825 , true );
	
	--読み込みタイミングのとき毎回追加されてほしいのでフラグたてない --EN:-- I want it to be added every time at the time of reading, so I don't set a flag

	--ボス関連のイベント登録 --EN:--Boss-related event registration
	BossInit_DragonDemon(proxy, param);	
	
	print("OnEvent_1052 end");
end

--HPゲージ、BGM対応 --EN:--HP gauge, BGM compatible
function OnEvent_1053(proxy,param)
	print("OnEvent_1053 begin");
	--ボス戦用BGM再生開始 --EN:--Start playing BGM for boss battle
	proxy:PlayPointSE( 2402, SOUND_TYPE_M, 60200000, 2 );
	--ボスゲージ表示 --EN:-- Boss gauge display
	proxy:SetBossGauge(825, 0, 6050);	
	print("OnEvent_1053 begin");
end


--------------------------------------------------------------------------------------
--■1060■光の剣発射機①起動■ --EN:-- ■ 1060 ■ Light sword launcher ■
--------------------------------------------------------------------------------------
--■1060■光の剣発射機①起動■ --EN:-- ■ 1060 ■ Light sword launcher ■
function OnEvent_1060(proxy, param)
	print("OnEvent_1060 begin");
	
	proxy:SetEventFlag( 1060 , true );
	proxy:SetEventFlag( 1062 , true );
	proxy:DeleteEvent( 1060 );
	proxy:DeleteEvent( 1062 );
	
	--プレイヤーの同期アニメーション(true:パーティープレイヤーがアニメーションした) --EN:--Player synchronous animation (true: party player animated)
	if Luafunc_PlaySynchroAnimation( proxy, param, 8130 ) == true then
		print("OnEvent_1060 end");		
		return;
	end

	proxy:NotNetMessage_begin();
		--▼6410▼ボス片方縫いつけポリ劇へ▼ --EN:--▼6410▼Boss sewn on one side to poly play▼
		proxy:OnChrAnimEnd( 6410 , 10000 , 8130 , "OnEvent_6410" , once );
	proxy:NotNetMessage_end();
	
	proxy:WarpDmy( 10000 ,1430 , 191 );	

	print("OnEvent_1060 end");
end


--------------------------------------------------------------------------------------
--■1062■光の剣発射機①起動■ --EN:-- ■ 1062 ■ Light sword launcher ■
--------------------------------------------------------------------------------------
--■1062■光の剣発射機①起動■ --EN:-- ■ 1062 ■ Light sword launcher ■
function OnEvent_1062(proxy, param)
	print("OnEvent_1062 begin");
	
	proxy:SetEventFlag( 1060 , true );
	proxy:SetEventFlag( 1062 , true );
	proxy:DeleteEvent( 1060 );
	proxy:DeleteEvent( 1062 );
	
	
	--プレイヤーの同期アニメーション(true:パーティープレイヤーがアニメーションした) --EN:--Player synchronous animation (true: party player animated)
	if Luafunc_PlaySynchroAnimation( proxy, param, 8130 ) == true then
		print("OnEvent_1062 end");		
		return;
	end

	proxy:NotNetMessage_begin();
		--▼6410▼ボス片方縫いつけポリ劇へ▼ --EN:--▼6410▼Boss sewn on one side to poly play▼
		proxy:OnChrAnimEnd( 6410 , 10000 , 8130 , "OnEvent_6410" , once );
	proxy:NotNetMessage_end();	

	proxy:WarpDmy( 10000 ,1430 , 192 );	

	print("OnEvent_1062 end");
end


--------------------------------------------------------------------------------------
--■6410■ボス片方縫いつけポリ劇■ --EN:-- ■ 6410 ■ Boss side stitched poly play ■
--------------------------------------------------------------------------------------

--▲6410▲ボス片方縫いつけポリ劇▲ --EN:-- ▲ 6410 ▲ Boss side sewn poly play ▲
function OnEvent_6410(proxy, param)
	print("OnEvent_6410 begin");	
	--ポリ劇配信 --EN:--Poly drama delivery
	proxy:LuaCallStart(6410,20);	
	print("OnEvent_6410 end");
end

--ポリ劇再生 --EN:--Poly play
function OnEvent_6410_1(proxy,param)
	print("OnEvent_6410_1 begin");
	proxy:StopPointSE( 2 );
	proxy:RequestRemo(60200,REMO_FLAG,6410,1);
	proxy:SetEventFlag(6410,true);
	print("OnEvent_6410_1 end");
end

--ポリ劇開始フェード --EN:--poly play start fade
function OnEvent_6410_RemoStart(proxy,param)
	print("OnEvent_6410_RemoStart begin");
	--バリスタSFX削除	 --EN:--Remove barista SFX
	proxy:InvalidSfx(2470, false);
	print("OnEvent_6410_RemoStart end");
end

--ポリ劇終了フェード --EN:--Poly play end fade
function OnEvent_6410_RemoFinish(proxy,param)
	print("OnEvent_6410_RemoFinish begin");
	--ボス戦用BGM再生開始 --EN:--Start playing BGM for boss battle
	proxy:PlayPointSE( 2402, SOUND_TYPE_M, 60299999, 2 );

	OnEvent_6412(proxy, param);--光の剣発射機モデル差し替え --EN:--Light sword launcher model replacement
	OnEvent_6413(proxy, param);--壁モデル差し替え --EN:--Wall model replacement
	
	--縫いつけ槍有効化 --EN:--Sew spear enabled
	proxy:SetDrawEnable(1400 ,true);
	proxy:SetColiEnable(1400 ,true);
	
	--待機切り替え --EN:-- standby switch
	ChangeWait_1(proxy,param);
	proxy:SetHp( 825 , 0.55);
	
	
	print("OnEvent_6410_RemoFinish end");
end


--------------------------------------------------------------------------------------
--■1061■光の剣発射機②起動■ --EN:-- ■ 1061 ■ Light sword launcher ■
--------------------------------------------------------------------------------------
--■1061■光の剣発射機②起動■ --EN:-- ■ 1061 ■ Light sword launcher ■
function OnEvent_1061(proxy, param)
	print("OnEvent_1061 begin");
	
	proxy:SetEventFlag( 1061 , true );
	proxy:SetEventFlag( 1063 , true );
	
	proxy:DeleteEvent( 1061 );
	proxy:DeleteEvent( 1063 );
	
	--プレイヤーの同期アニメーション(true:パーティープレイヤーがアニメーションした) --EN:--Player synchronous animation (true: party player animated)
	if Luafunc_PlaySynchroAnimation( proxy, param, 8130 ) == true then
		print("OnEvent_1061 end");		
		return;
	end

	proxy:NotNetMessage_begin();
		--▼6411▼ボス両方縫いつけポリ劇へ▼ --EN:-- ▼ 6411 ▼ Boss both sewn to the poly play ▼
		proxy:OnChrAnimEnd( 6411 , 10000 , 8130 , "OnEvent_6411" , once );
	proxy:NotNetMessage_end();
	
	proxy:WarpDmy( 10000 , 1431 , 191 );
	
	print("OnEvent_1061 end");
end


--■1063■光の剣発射機②起動■ --EN:-- ■ 1063 ■ Light sword launcher ■
function OnEvent_1063(proxy, param)
	print("OnEvent_1063 begin");
	
	proxy:SetEventFlag( 1061 , true );
	proxy:SetEventFlag( 1063 , true );
	
	proxy:DeleteEvent( 1061 );
	proxy:DeleteEvent( 1063 );
	
	--プレイヤーの同期アニメーション(true:パーティープレイヤーがアニメーションした) --EN:--Player synchronous animation (true: party player animated)
	if Luafunc_PlaySynchroAnimation( proxy, param, 8130 ) == true then
		print("OnEvent_1063 end");		
		return;
	end

	proxy:NotNetMessage_begin();
		--▼6411▼ボス両方縫いつけポリ劇へ▼ --EN:-- ▼ 6411 ▼ Boss both sewn to the poly play ▼
		proxy:OnChrAnimEnd( 6411 , 10000 , 8130 , "OnEvent_6411" , once );
	proxy:NotNetMessage_end();
	
	proxy:WarpDmy( 10000 , 1431 , 192 );
	
	print("OnEvent_1063 end");
end


--------------------------------------------------------------------------------------
--■6411■ボス両方つい付けポリ劇■ --EN:-- ■ 6411 ■ Boss both unintentional police play ■
--------------------------------------------------------------------------------------

--▲6411▲ボス両方つい付けポリ劇▲ --EN:-- ▲ 6411 ▲ Boss both unwitting polyplay ▲
function OnEvent_6411(proxy, param)
	print("OnEvent_6411 begin");
	--ポリ劇の配信 --EN:--Distribution of poly drama
	proxy:LuaCallStart(6411,20);
	print("OnEvent_6411 end");
end

--ポリ劇再生 --EN:--Poly play
function OnEvent_6411_1(proxy,param)
	print("OnEvent_6411_1 begin");
	proxy:StopPointSE( 2 );
	proxy:RequestRemo(60201,REMO_FLAG,6411,1);
	proxy:SetEventFlag(6411,true);
	print("OnEvent_6411_1 end");
end

--ポリ劇開始のフェード時 --EN:--At the time of the poly-play start fade
function OnEvent_6411_RemoStart(proxy,param)
	print("OnEvent_6411_RemoStart begin");	
	--バリスタSFX削除 --EN:--Remove barista SFX
	proxy:InvalidSfx(2471, false);
	
	--片手縫い付け槍無効化 --EN:--Disable one-handed sewn spear
	proxy:SetDrawEnable(1400 ,false);
	proxy:SetColiEnable(1400 ,false);
	print("OnEvent_6411_RemoStart end");
end

--ポリ劇終了のフェード時 --EN:--Fade at the end of the polyplay
function OnEvent_6411_RemoFinish(proxy,param)
	print("OnEvent_6411_RemoFinish begin");
	--ボス戦用BGM再生開始 --EN:--Start playing BGM for boss battle
	proxy:PlayPointSE( 2402, SOUND_TYPE_M, 60299999, 2 );
	--OBJ1432有効 --EN:--OBJ1432 enabled
	proxy:SetDrawEnable( 1432 ,true);
	proxy:SetColiEnable( 1432 ,true);
	
	--OBJ1431無効 --EN:--OBJ1431 disabled
	proxy:SetDrawEnable( 1431 ,false);
	proxy:SetColiEnable( 1431 ,false);	
	
	--縫いつけ槍有効化 --EN:--Sew spear enabled
	proxy:SetDrawEnable(1401 ,true);
	proxy:SetColiEnable(1401 ,true);
	proxy:SetDrawEnable(1402 ,true);
	proxy:SetColiEnable(1402 ,true);
	
	proxy:SetHp( 825 , 0.1);
	--待機切り替え --EN:-- standby switch
	ChangeWait_2(proxy,param);
	print("OnEvent_6411_RemoFinish end");
end



--------------------------------------------------------------------------------------
--■6412■光の剣発射機モデル差し替え■ --EN:-- ■ 6412 ■ Light sword launcher model replacement ■
--------------------------------------------------------------------------------------

--■6412■光の剣発射機モデル差し替え■ --EN:-- ■ 6412 ■ Light sword launcher model replacement ■
function OnEvent_6412(proxy, param)
	print("OnEvent_6412 begin");
	
	proxy:SetDrawEnable( 1430 , false );
	proxy:SetColiEnable( 1430 , false );
	
	proxy:SetDrawEnable( 1440 , true );
	proxy:SetColiEnable( 1440 , true );
	
	proxy:SetEventFlag( 6412 , 1 );

	print("OnEvent_6412 end");
end



--------------------------------------------------------------------------------------
--■6413■壁モデル差し替え■ --EN:-- ■ 6413 ■ Wall model replacement ■
--------------------------------------------------------------------------------------

--■6413■壁モデル差し替え■ --EN:-- ■ 6413 ■ Wall model replacement ■
function OnEvent_6413(proxy, param)
	print("OnEvent_6413 begin");
	
	proxy:SetDrawEnable( 1445 , false );
	proxy:SetColiEnable( 1445 , false );
	
	proxy:SetEventFlag( 6413 , 1 );

	print("OnEvent_6413 end");
end


--------------------------------------------------------------------------------------
--■1111■ＰＣが竜骨砕きを入手■ --EN:-- ■ 1111 ■ PC obtains keel crusher ■
--------------------------------------------------------------------------------------
function OnEvent_1111(proxy, param)
	if param:IsNetMessage() == false then
	print("OnEvent_1111 begin");
	proxy:NotNetMessage_begin();
	proxy:RepeatMessage_begin();
		proxy:PlayAnimation( 10000,8290);
		proxy:PlayAnimation( 1434 , 1);		
		proxy:OnKeyTime2( 1111 , "OnEvent_1111_0",0.01,0,0,once);
	proxy:RepeatMessage_end();
	proxy:NotNetMessage_end();	
	print("OnEvent_1111 end");
	end
end

function OnEvent_1111_0(proxy,param)
	print("OnEvent_1111_0 begin");
	if proxy:IsEventAnim( 10000 , 8290 ) == true then
		proxy:LuaCallStart( 1111 , 2 );
	else
		proxy:ForcePlayAnimation( 1434 , 0);	
	end
	print("OnEvent_1111_0 end");
end

function OnEvent_1111_1(proxy, param)
	print("OnEvent_1111_1 begin");
	--アイテム取得関数--パラメータ10104参照 --EN:--item retrieval function--see parameter 10104
	proxy:GetRateItem(10626);	
	
	--アイテムを取得済み --EN:--item already acquired
	proxy:SetEventFlag( 1111, true );
	
	--OBJを消すためのイベント配信 --EN:--Event distribution for erasing OBJ
	proxy:LuaCallStart( 1111, 1);

	print("OnEvent_1111_1 end");
end

--■1111_2■剣OBJ非表示用■ --EN:-- ■ 1111_2 ■ For hiding the sword OBJ ■
function OnEvent_1111_2(proxy,param)
	print("OnEvent_1111_2 begin");
	--オブジェが消える --EN:--The object disappears
	proxy:SetDrawEnable( 1434, false );--ひとまず描画だけOFF --EN:--Only drawing is turned off for the time being
	proxy:SetColiEnable( 1434, false );--当たりはあるのは不明(現状ではないようなので消さない) --EN:--I don't know if there is a hit (I don't delete it because it doesn't seem to be the current situation)
		
	proxy:DeleteEvent( 1111 );
	print("OnEvent_1111_2 end");
end

--アニメ監視同期 --EN:--Anime watch sync
function OnEvent_1111_3(proxy,param)
	print("OnEvent_1111_3 begin");
	
	proxy:TreasureDispModeChange2( 1434, false ,KEN_SFX);
	--プレイヤーの同期アニメーション(true:パーティープレイヤーがアニメーションした) --EN:--Player synchronous animation (true: party player animated)
	if Luafunc_PlaySynchroAnimation( proxy, param, 8290 ) == true then--新しいアニメ  --EN:-- new anime
		proxy:PlayAnimation( 1434 , 1);	
		print("OnEvent_5 end");
		return true;
	end
	
	proxy:WarpDmy( 10000 , 1434 , 191 );--ダミー位置へワ－プ	 --EN:--Warp to dummy position
	--アニメが終わったら監視追加 --EN:--Add monitoring when the animation ends
	proxy:NotNetMessage_begin();
		proxy:OnChrAnimEnd( 1111 , 10000 , 8290 , "OnEvent_1111_1", once);
	proxy:NotNetMessage_end();
	
	print("OnEvent_1111_3 end");
end


--------------------------------------------------------------------------------------
--■1120■ウィルオウィスプ爆発■ --EN:-- ■ 1120 ■ Will O'Wisp Explosion ■
--------------------------------------------------------------------------------------
function OnEvent_1120( proxy , param )
	print("OnEvent_1120 begin");
	proxy:DeleteObjSfxEventID( 1441 );
	proxy:CastPointSpell_Horming( 400,1441, 10160 , 0,0,0,1441);
	proxy:SetEventFlag( 1120 ,true);
	print("OnEvent_1120 end");
end


--------------------------------------------------------------------------------------
--■1121■ウィルオウィスプ爆発■ --EN:-- ■ 1121 ■ Will O'Wisp Explosion ■
--------------------------------------------------------------------------------------
function OnEvent_1121( proxy ,param)
	print("OnEvent_1121 beign");
	proxy:DeleteObjSfxEventID( 1442 );
	proxy:CastPointSpell_Horming( 400,1442, 10160 , 0,0,0,1442);
	proxy:SetEventFlag(1121,true);
	print("OnEvent_1121 end");
end


--------------------------------------------------------------------------------------
--■1114■グラムに近づいた■ --EN:-- ■ 1114 ■ Approached grams ■
--------------------------------------------------------------------------------------
function OnEvent_1114(proxy,param)
	print("OnEvent_1114 begin");
	proxy:SetEventFlag( 1114 , true );
	print("OnEvent_1114 end");
end
