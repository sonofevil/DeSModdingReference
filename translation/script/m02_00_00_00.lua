
FIREDAM_WAIT = 2.0;

--■ドランの状態一覧 --EN:--■ Doran's status list
DORAN_STATE_GUARD 		= 16280;--霊廟を護る --EN:--Protect the Mausoleum
DORAN_STATE_ALLOWED		= 16281;--許してくれた --EN:--forgive me
DORAN_STATE_NOT_ALLOWED	= 16282;--もう許さない --EN:--I will not forgive you anymore
DORAN_STATE_DEAD		= 16283;--死亡 --EN:--death

doran_flag_list = {
	DORAN_STATE_GUARD 		,
	DORAN_STATE_ALLOWED 	,
	DORAN_STATE_NOT_ALLOWED ,
	DORAN_STATE_DEAD 
};

--奴隷兵士ショップの状態一覧 --EN:--Slave soldier shop status list
DOREISOL_SHOP_SELL01	= 16083;	--移動したい(王城1) --EN:--I want to move (Castle 1)
DOREISOL_SHOP_HOSTILE01 = 16084;	--敵対(王城1) --EN:-- Hostility (Castle 1)
DOREISOL_SHOP_DEAD		= 16082;	--死亡 --EN:--death
DOREISOL_SHOP_SELL02	= 16080;	--移動したい(王城2) --EN:--I want to move (Castle 2)
DOREISOL_SHOP_HOSTILE02 = 16081;	--敵対(王城2) --EN:-- Hostility (Castle 2)
DOREISOL_SHOP_SELL03	= 16085;	--移動したい(王城3) --EN:--I want to move (Castle 3)
DOREISOL_SHOP_HOSTILE03 = 16086;	--敵対(王城3) --EN:-- Hostility (Castle 3)

DOREISOL_SHOP_Flag_list = {
	DOREISOL_SHOP_SELL01,
	DOREISOL_SHOP_HOSTILE01,
	DOREISOL_SHOP_DEAD,
	DOREISOL_SHOP_SELL02,
	DOREISOL_SHOP_HOSTILE02,
	DOREISOL_SHOP_SELL03,
	DOREISOL_SHOP_HOSTILE03
}

--奴隷兵士のショップが敵対するためのダメージ値 --EN:--Damage value for slave soldiers shop hostile
DoreiShop_TotalDamage = 100;


--------------------------------------------------------------------------------------
--マップ読み込み時に読まれる初期化処理■ --EN:--Initialization process read when reading the map ■
--------------------------------------------------------------------------------------
function Initialize_m02_00_00_00(proxy)
	print("Initialize_m02_00_00_00 begin");
	
	proxy:LuaCall( 99999 , 0 , "OnEvent_4000_Hp_1",everytime);
--■0■城門開放レバー■--PCがイベントエリア(1000)の中に距離(1.5m)有効角(30度幅)でアクションボタンを押した --EN:-- ■ 0 ■ castle gate opening lever ■ -- PC pressed the action button at a distance (1.5m) effective angle (30 degrees width) in the event area (1000)
		
	--ボスがいきているときだけ監視追加 --EN:--Added monitoring only when the boss is alive
	if proxy:IsCompleteEvent( 4096 ) == false then	
		if proxy:IsCompleteEvent( 0 ) ==false then
			proxy:OnDistanceAction( 0, LOCAL_PLAYER, 1000, "OnEvent_0", LeverDist_A, HELPID_PULL_LEVER, 0, LeverAngle_A, once);
			proxy:LuaCall(0,1,"OnEvent_0_4",once);
			proxy:NotNetMessage_begin();
				proxy:LuaCall(0,REMO_START,"OnEvent_0_RemoStart",once);
				proxy:LuaCall(0,REMO_FINISH,"OnEvent_0_RemoFinish",once);
			proxy:NotNetMessage_end();
			proxy:SetDrawEnable( 1008 , false );
			proxy:SetColiEnable( 1008 , false );
		else
			proxy:EndAnimation( 1000, 1 );--レバーアニメを終了 --EN:--End lever animation
			proxy:EndAnimation( 1001, 1 );--正門が開くアニメを終了 --EN:--End the animation of the main gate opening
			proxy:EndAnimation( 1140, 1 );--ギアが動くアニメを終了 --EN:--Finish animation with moving gears
		end
	else
		proxy:EndAnimation( 1000, 1 );--レバーアニメを終了 --EN:--End lever animation
		proxy:EndAnimation( 1001, 1 );--正門が開くアニメを終了 --EN:--End the animation of the main gate opening
		proxy:EndAnimation( 1140, 1 );--ギアが動くアニメを終了 --EN:--Finish animation with moving gears
	end
	
--■4096■城内部への扉開放■中ボス死亡時-- --EN:-- ■ 4096 ■ Opening the door to the inside of the castle ■ When the middle boss dies --
	proxy:AddFieldInsFilter( 800 );
	if proxy:IsCompleteEvent( 4096 ) ==false then		
		proxy:OnCharacterDead(4096, 800, "OnEvent_4096", once);
	else
		proxy:EndAnimation( 1002, 1 );
	end
	

--■10■レバー操作で城門塔右の扉開放■--PCがイベントエリア(1005)の中に距離(1.5m)有効角(30度幅)でアクションボタンを押した --EN:--■10■Open the door on the right side of the castle gate tower with the lever operation■--The PC pressed the action button within the event area (1005) at a distance (1.5m) and an effective angle (30 degrees width).
	if proxy:IsCompleteEvent( 10 ) ==false then
		--扉開く配信用 --EN:--For door-open delivery
		--アクション監視追加 --EN:--Add action monitor
		proxy:OnDistanceAction( 10, LOCAL_PLAYER, 1005, "OnEvent_10", LeverDist_A, HELPID_PULL_LEVER, 0, LeverAngle_A, once);
		
	else
		proxy:EndAnimation( 1003, 1 );--扉アニメを終了 --EN:--End door animation
		proxy:EndAnimation( 1005, 1 );--レバーアニメを終了 --EN:--End lever animation
	end

--■110■ボス部屋に入る■ --EN:-- ■ 110 ■ Enter the boss room ■
	
	--中ボスが生きているときだけイベント登録 --EN:-- Event registration only when the mid-boss is alive
	if proxy:IsCompleteEvent( 4096 ) == false then
	
		--ソロのときは一度目にボス部屋に入る用のイベントを毎回登録させたいので、対応するフラグをOFFにする。 --EN:-- When soloing, we want to register the event for entering the boss room for the first time every time, so turn off the corresponding flag.
		SingleReset(proxy, 110);
	
		--▽同期アニメ再生用の開始ハンドラ(旋回→歩き) --EN:--▽ Start handler for synchronous animation playback (turning → walking)
		proxy:LuaCall( 111, 1, "OnEvent_111_1", everytime );
		
		--▽2回目以降にボス部屋に入るためのイベント配信用 --EN:--▽For event delivery to enter the boss room after the second time
		proxy:LuaCall( 111 , 5 , "OnEvent_110_GO_TO_IN" , everytime );
		
		--▽フラグセット(同期用) --EN:--▽flag set (for synchronization)
		proxy:LuaCall( 111 , 6 , "OnEvent_110_flag_set" , everytime );
		
		--誰かがボス前扉をまだ通過していない --EN:--Someone hasn't passed through the boss front door yet
		if proxy:IsCompleteEvent( 110 ) == false then
		
			--(セッション中に)ボス前の魔法壁を最初に通れるのは生存の人だけ --EN:--(During the session) Only survivors can pass through the magic wall in front of the boss first
			local possible_chr_type = ATTR_HOST + ATTR_LIVE + ATTR_GREY;
			
			proxy:NotNetMessage_begin();
				--▼110▼扉が開いているときに中に入るためのイベントを追加▼ --EN:--▼110▼ Added an event to enter when the door is open▼
				proxy:OnPlayerActionInRegionAttribute( 110, 2895, "OnEvent_110", HELPID_GO_TO_IN, possible_chr_type, everytime );
			proxy:NotNetMessage_end();
		
		else --グレイゴーストできたときようにいると思われる。 --EN:--Gray ghost seems to be like that when it's done.
		
			proxy:NotNetMessage_begin();
				--▼111▼扉が開いているときに中に入るためのイベントを追加▼ --EN:--▼111▼ Added an event to enter when the door is open▼
				proxy:OnPlayerActionInRegion( 111, 2895, "OnEvent_110", HELPID_GO_TO_IN, everytime );--ハンドラは上と同じ --EN:--handler is the same as above
			proxy:NotNetMessage_end();
		
		end

		--取り合えずファランクス部屋のみ対応 --EN:--For now, only phalanx rooms are supported
		--ボス用アタリ切り替え --EN:-- Switch Atari for Boss
		print("ボス部屋アタリボス用"); --EN:print("For Boss Room Atari Boss");
		proxy:SetColiEnableArray(3010,false);--通常無効		 --EN:--usually disabled
		proxy:SetColiEnableArray(3002,true);--ボス用有効 --EN:--Valid for Boss
		proxy:SetColiEnableArray(3001,true);--ボス用有効		 --EN:--Valid for Boss
		
	else
		--取り合えずファランクス部屋のみ対応 --EN:--For now, only phalanx rooms are supported
		--ボス用アタリ切り替え --EN:-- Switch Atari for Boss
		print("ボス部屋アタリ通常"); --EN:print("Boss Room Atari Normal");
		proxy:SetColiEnableArray(3010,true);--通常有効		 --EN:--usually valid
		proxy:SetColiEnableArray(3002,false);--ボス用無効 --EN:--disabled for boss
		proxy:SetColiEnableArray(3001,false);--ボス用無効 --EN:--disabled for boss
	end

	
--■114■ボス戦闘開始■	 --EN:-- ■ 114 ■ Boss battle begins ■
	if proxy:IsCompleteEvent( 4096 ) == false then
		proxy:OnRegionJustIn( 114 , LOCAL_PLAYER , 2887 , "OnEvent_114" , once );
		proxy:LuaCall( 114 , 10 , "OnEvent_114_1",everytime);
	end	
	
	--[[
	proxy:NotNetMessage_begin();
		proxy:OnRegionJustIn( 450, LOCAL_PLAYER , 2887 , "OnEvent_450_In",everytime );
		proxy:OnRegionJustOut( 450 , LOCAL_PLAYER , 2887 , "OnEvent_450_Out",everytime );
	proxy:NotNetMessage_end();
	]]
	
--■50■レバー対応扉（左）■PCがイベントエリア(1006)距離(1.5m)反応角(180度幅)でアクションボタンを押した --EN:-- ■ 50 ■ Lever compatible door (left) ■ PC pressed the action button in the event area (1006) distance (1.5m) reaction angle (180 degree width)
	if proxy:IsCompleteEvent( 50 ) ==false then
		--アクション監視追加 --EN:--Add action monitor
		proxy:OnDistanceAction( 50, LOCAL_PLAYER, 1006, "OnEvent_50", LeverDist_A, HELPID_PULL_LEVER, 0, LeverAngle_A ,once);
	else
		proxy:EndAnimation( 1004, 1 );--扉アニメを終了 --EN:--End door animation
		proxy:EndAnimation( 1006, 1 );--レバーアニメを終了 --EN:--End lever animation
	end

--■70■石柱にワープ■ --EN:-- ■ 70 ■ Warp to the stone pillar ■
	SingleReset(proxy,70);
	proxy:TreasureDispModeChange2( 1983 , true ,KANAME_SFX);
	proxy:OnDistanceAction( 70 , LOCAL_PLAYER , 1983 , "OnEvent_70" , WarpGimmickDist_A , HELPID_GO_TO_SEKITYUU , 0 , 180, everytime );


--カラスイベントをリピートさせるためにSingleReset() --EN:--SingleReset() to repeat the crow event
	local actionId_list = { 350 , 351 ,353 , 354,355,356,357,358,359,360,361,362,363,364,365,366,367,368,369,370,371,372,373,374,375};	
	local num = table.getn( actionId_list );
	for IndexID = 1, num , 1 do
		SingleReset(proxy, actionId_list[ IndexID ]);
	end

--カラスがＰＣが近づくと飛び立つ --EN:--A crow takes off when a PC approaches
	for KarasuID = 1, num, 1 do
		if proxy:IsCompleteEvent( actionId_list[ KarasuID ] ) == false then
			proxy:OnPlayerDistanceInTarget( actionId_list[ KarasuID ], LOCAL_PLAYER, 740 + actionId_list[KarasuID], "OnEvent_"..actionId_list[KarasuID], 5, once );
		else
			proxy:SetDrawEnable(740 + actionId_list[KarasuID], false);
			proxy:SetColiEnable(740 + actionId_list[KarasuID], false);		
		end
	end

--■90■薄板壁を壊して敵が飛び出してくる■ --EN:-- ■ 90 ■ Destroy the thin wall and the enemy will jump out ■
	
	--[[2008.06.28/toyohide とりあえず --EN:--[[2008.06.28/toyohide
	if proxy:IsCompleteEvent( 90 ) == false then
		proxy:OnRegionJustIn( 90, LOCAL_PLAYER, 2040, "OnEvent_90" , once );
	else
		proxy:EndAnimation( 1120 , 1 );
	end
	]]
	proxy:EndAnimation( 1120 , 1 );
	
--■91■薄板壁を壊して敵が飛び出してくる2■ --EN:--■ 91 ■ Destroy the thin wall and the enemy will jump out 2 ■
	if proxy:IsCompleteEvent( 91 ) == false then
		proxy:SetSuperArmor( 215 , true );
		proxy:SetSuperArmor( 216 , true );
		proxy:OnRegionJustIn( 91, LOCAL_PLAYER, 2041, "OnEvent_91" , once );
	else
		proxy:EndAnimation( 1121 , 1 );
		proxy:EndAnimation( 1122 , 1 );
	end


	
--■180■一般兵士が降りてくる■ --EN:-- ■ 180 ■ Common soldiers descend ■
	if proxy:IsCompleteEvent( 180 ) == false then
		proxy:SetSuperArmor( 211 , true );
		proxy:SetSuperArmor( 206 , true );
		proxy:OnRegionJustIn( 180 , LOCAL_PLAYER , 2100 , "OnEvent_180" , once );--領域用 --EN:--for area
		proxy:OnSimpleDamage( 182 , 211 , LOCAL_PLAYER , "OnEvent_180_00" , once );--攻撃受けた用(ID:211) 別ID --EN:--For being attacked (ID: 211) Another ID
		proxy:OnSimpleDamage( 183 , 206 , LOCAL_PLAYER , "OnEvent_180_01" , once );--攻撃受けた用(ID:206) 別ID --EN:--For being attacked (ID: 206) Another ID
	else

	end
	
	
--■200■処刑場への扉■ --EN:-- ■ 200 ■ Door to execution ground ■
	SingleReset(proxy,200);
	if proxy:IsClient() == false then
		if	proxy:IsSuccessQWC(20600) == true or 
			proxy:IsSuccessQWC(20300) == true or 
			proxy:IsCompleteEvent(201) == true then
			proxy:SetEventFlag( 200, true );	
		end
	end
	
	if proxy:IsCompleteEvent( 200 ) == false then
		--[[
		proxy:NotNetMessage_begin();
			proxy:OnDistanceAction( 200, LOCAL_PLAYER, 1040, "OnEvent_200", DoorDist_A, HELPID_OPEN, 180, DoorAngle_A, everytime ); 
		proxy:NotNetMessage_end();	
		proxy:LuaCall( 200, 1, "OnEvent_200_1", once );--アニメーション同期用 --EN:--For animation synchronization
		]]
	else
		proxy:EndAnimation( 1040, 1 );
	end
	
--■201■処刑場の扉を超えた■ --EN:-- ■ 201 ■ Beyond the door of the execution ground ■
	if proxy:IsCompleteEvent( 201 ) == false then
		if proxy:IsClient() == false then
			proxy:NotNetMessage_begin();
				proxy:OnRegionIn( 201 , 10000 , 2020 , "OnEvent_201",once);
			proxy:NotNetMessage_end();
		end
	else
	
	end
	
--■210■霊廟への扉■ --EN:--■210■The door to the mausoleum■
	--[[
	if proxy:IsCompleteEvent( 210 ) == false then
		
		proxy:NotNetMessage_begin();
			proxy:OnDistanceAction( 210, LOCAL_PLAYER, 1045, "OnEvent_210", DoorDist_A, HELPID_OPEN, 0, DoorAngle_A, everytime ); 
		proxy:NotNetMessage_end();
		
		proxy:LuaCall( 210, 1, "OnEvent_210_1", once );--アニメーション同期用 --EN:--For animation synchronization
	else
		proxy:EndAnimation( 1045, 1 );
	end
	]]

--■211■霊廟への扉2■ --EN:-- ■ 211 ■ Door to Mausoleum 2 ■
	if proxy:IsCompleteEvent( 211 ) == false then
		
		proxy:NotNetMessage_begin();
			proxy:OnDistanceAction( 211, LOCAL_PLAYER, 1047, "OnEvent_211", DoorDist_A, HELPID_OPEN, 180, DoorAngle_A, everytime ); 
		proxy:NotNetMessage_end();
		
		proxy:LuaCall( 211, 1, "OnEvent_211_1", once );--アニメーション同期用 --EN:--For animation synchronization
	else
		proxy:EndAnimation( 1047, 1 );
	end

--■5■霊廟の祭壇■ --EN:-- ■ 5 ■ Mausoleum Altar ■
	if proxy:IsCompleteEvent( 5 ) == false then
		--ドランが既に許している --EN:-- Doran has already forgiven
		if proxy:IsCompleteEvent( 330 ) == true then
	
			--調べるイベント自体は同期します、調べれる人はホストorシングルプレイヤーです --EN:--The event itself to be examined is synchronized, the person who can be examined is the host or single player
			--proxy:NotNetMessage_begin();
				--ホスト、生存、グレイのみ調べることができる --EN:--Only hosts, survivors, and grays can be examined
				local possible_chr_type = ATTR_HOST + ATTR_LIVE + ATTR_GREY;
				--HELPIDがデモンブランド専用になった --EN:--HELPID is now exclusive to the Demon brand
				proxy:OnDistanceActionAttribute( 5 , LOCAL_PLAYER , 1192 , "OnEvent_5" , ItemBoxDist_A , 10010130 , 0 , ItemBoxAngle_A ,possible_chr_type, everytime ); 
				proxy:LuaCall( 5,1,"OnEvent_5_2",once);
				proxy:LuaCall( 5,2,"OnEvent_5_3",once);
				proxy:TreasureDispModeChange2( 1192, true ,KEN_SFX);
				--proxy:SetRarity( 1192, 10104 );
			--proxy:NotNetMessage_end();
		end
	else
		proxy:SetDrawEnable( 1192 , false );--ひとまず描画だけOFF --EN:--Only drawing is turned off for the time being
		proxy:SetColiEnable( 1192 , false );
		
		proxy:InvalidSfx( 1192, false );
	end	
	--proxy:TreasureDispModeChange( 1192, true );
	--proxy:SetRarity( 1192, 10104 );
	
--■35■QWCによる飛竜の無効化 --EN:--■35■Disabling flying dragons with QWC
	SingleReset(proxy,35);
	if	proxy:IsSuccessQWC(20400 ) == true then
		proxy:SetEventFlag( 35, true );
	end
	if	proxy:IsCompleteEvent( 35 ) == false then
		--■232■領域監視■指定領域にプレイヤーがひとりでもいる場合フラグON/誰もいない場合フラグOFF --EN:-- ■ 232 ■ Area monitoring ■ Flag ON when there is even one player in the specified area / Flag OFF when there is no player
			proxy:OnNetRegion( 222, 2039 );
			proxy:OnNetRegion( 223, 2131 );
			proxy:OnNetRegion( 224, 2132 );
			proxy:OnNetRegion( 225, 2133 );
	else
		--飛竜無効化 --EN:--Nullify Wyvern
		--InvalidCharactor(proxy, 300);
		--InvalidCharactor(proxy, 301);
	end
	
	
	
	--☆☆☆☆☆☆☆☆☆☆飛竜のネットワーク位置非同期設定☆☆☆☆☆☆☆☆☆☆ --EN:--☆☆☆☆☆☆☆☆☆☆ Hiryu network location asynchronous setting ☆☆☆☆☆☆☆☆☆☆
	proxy:SetNoNetSync(300,true);
	proxy:SetNoNetSync(501,true);
	proxy:SetNoNetSync(301,true);
	proxy:SetNoNetSync(110,true);
	--☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆	 --EN:--☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆
--■236■飛竜の眷属の表示切替 --EN:-- ■ 236 ■ Display switching of Hiryu's relatives
	--proxy:OnRegionJustIn( 236, LOCAL_PLAYER, 2190, "HiryuKenzokuCheck", everytime );
	--proxy:OnRegionJustIn( 236, LOCAL_PLAYER, 2191, "HiryuKenzokuCheck", everytime );
	--[[
	アサート回避の為、初回登録にダミー登録 --EN:Dummy registration for the first registration to avoid assertion
	]]
	proxy:LuaCall( 199, 1, "dummy", everytime );
	proxy:LuaCall( 221, 1, "dummy", everytime );
	proxy:LuaCall( 221, 2, "dummy", everytime );
	proxy:LuaCall( 190, 1, "dummy", everytime );
	proxy:LuaCall( 190, 2, "dummy", everytime );
	proxy:LuaCall( 191, 1, "dummy", everytime );
	proxy:LuaCall( 191, 2, "dummy", everytime );
	proxy:LuaCall( 230, 1, "dummy", everytime );
	proxy:LuaCall( 230, 2, "dummy", everytime );
	proxy:LuaCall( 231, 1, "dummy", everytime );
	proxy:LuaCall( 231, 2, "dummy", everytime );
	proxy:LuaCall( 232, 1, "dummy", everytime );
	proxy:LuaCall( 232, 2, "dummy", everytime );
	proxy:LuaCall( 800 , 1 , "dummy"   , everytime );--待機 --EN:--stand-by
	proxy:LuaCall( 800 , 2 , "dummy" , everytime );--待機2 --EN:--Wait 2
	proxy:LuaCall( 800 , 3 , "dummy" , everytime );--死亡待機 --EN:--wait for death
	proxy:LuaCall( 801 , 1 , "dummy" , everytime );--ブレスA --EN:--Breath A
	proxy:LuaCall( 802 , 1 , "dummy" , everytime );--ブレスB --EN:--Breath B
	proxy:LuaCall( 803 , 1 , "dummy" , everytime );--ブレスC --EN:--Breath C
	proxy:LuaCall( 804 , 1 , "dummy" , everytime );--ヘロヘロ --EN:--hero hero
	proxy:LuaCall( 806 , 1 , "dummy" , everytime );--死亡		 --EN:--death
--■807■飛竜の眷属の表示切替 --EN:-- ■ 807 ■ Display switching of Hiryu's relatives
	--proxy:OnRegionJustIn( 807, LOCAL_PLAYER, 2390, "HiryuKenzokuCheck", everytime );
	--proxy:OnRegionJustIn( 807, LOCAL_PLAYER, 2391, "HiryuKenzokuCheck", everytime );
	proxy:NotNetMessage_begin();
	--	proxy:LuaCall( 236, 2, "HiryuKenzokuCheck", once );
	proxy:CustomLuaCall( 4060, "HiryuKenzokuCheck", everytime );
	proxy:NotNetMessage_end();
	--一先ず、王城１からという設定にしておく --EN:--First of all, let's set it to start from the castle 1
	--理由としては王城１からならチェックポイントを経由せずに飛竜に会うことが起こりにくい為です。 --EN:--The reason is that it's unlikely that you'll meet a wyvern without going through a checkpoint from Castle 1.
	--正式な対応は、ブロック移動した時に呼び出すハンドラを用意して、 --EN:--The official response is to prepare a handler to be called when the block is moved,
	--チェックポイントを無視した簡易バックリード的な作りが良いと思います。 --EN:--I think it's good to create a simple back-read that ignores checkpoints.
	--ブロックごとに読み込みを切り替えるのは、 --EN:-- To switch reading for each block,
	--飛竜が常にバックリード＆強制更新の為、関係ない場所でイベントが動くのを防ぐのが主な理由です。 --EN:--The main reason is to prevent events from moving in unrelated places because Hiryu always backreads and forces updates.
	--proxy:LuaCallStartPlus( 236, 2, 2190 );

--■258■奴隷兵士がレンドル王子を狙うのをやめる --EN:-- ■ 258 ■ Stop slave soldiers from aiming at Prince Lendl
	--(状態判定部分で監視追加) --EN:--(monitoring added in the state judgment part)
	

--■391～409■樽爆発(小)■ --EN:-- ■ 391～409 ■ barrel explosion (small) ■
--■421～430■樽爆発(大)■ --EN:-- 421～430 ■ Barrel Explosion (Large) ■
	TaruRegist( proxy,param);
--■6■兵士が火炎瓶を投げる■ --EN:--■ 6 ■ Soldiers throw Molotov cocktails ■
	ThrowFirePotRegist_b1(proxy);
	
--■251～256■奴隷兵士の死亡監視(レンドル王子周り) --EN:--■ 251-256 ■ Death Watch for Slave Soldiers (around Prince Lendl)
	DoreiRegist_block1(proxy);
	
	

--■280■吊るされた死体1が落下する■ --EN:-- ■ 280 ■ Hanging corpse 1 falls ■
	if proxy:IsCompleteEvent( 280 ) == false then
		proxy:OnObjectDestroy( 280 , 1172 , "OnEvent_280" , once );--吊るしている紐の破壊監視 --EN:--Breakage monitoring of hanging cords
	else
		proxy:EndAnimation( 10240 , 1000 );--死体のほうのアニメを終了 --EN:--Finish the corpse animation
	end

	
--■281■吊るされた死体2が落下する■ --EN:--■281■The hanging corpse 2 falls■
	if proxy:IsCompleteEvent( 281 ) == false then
		proxy:OnObjectDestroy( 281 , 1174 , "OnEvent_281" , once );--吊るしている紐の破壊監視 --EN:--Breakage monitoring of hanging cords
	else
		proxy:EndAnimation( 10241 , 1000 );--死体のほうのアニメを終了 --EN:--Finish the corpse animation
	end

	
--
--■285■砲弾ゴロゴロ■ --EN:-- ■ 285 ■ cannonball rumbling ■
	SingleReset( proxy, 285 );
	if proxy:IsCompleteEvent( 285 ) == false then
		proxy:OnObjectDestroy( 285 , 1190 , "OnEvent_285" , once );--箱の破壊監視	 --EN:-- Box destruction monitoring
	else
		proxy:EndAnimation( 1191 , 1 );--ゴロゴロアニメ再生終了 --EN:--Rumbling animation playback ends
	end
	
--■310～319■ソウルモンスター出現■ --EN:-- ■ 310-319 ■ Soul Monster Appears ■
	RegistSoulMonster_block1(proxy);
	

--■320■はしご1降りる■ --EN:-- ■ 320 ■ Get off the ladder 1 ■
	proxy:OnActionEventRegion(320, 2026, "OnEvent_320", LadderAngle_A, HELPID_DOWN, everytime);
		
--■321■はしご1昇る■ --EN:-- ■ 321 ■ ladder 1 climb ■
	proxy:OnActionEventRegion(321, 2027, "OnEvent_321", LadderAngle_A, HELPID_UP,   everytime);
	
	
--■2■飛竜が飛んでくるポリ劇を再生する■ --EN:--■ 2 ■ Replay a poly-drama in which flying dragons fly ■
	if proxy:IsCompleteEvent( 2 ) == false then
	
		--proxy:OnRegionJustIn( 2 , LOCAL_PLAYER , 2000 , "OnEvent_2" , once );
	
		proxy:NotNetMessage_begin();
			--ポリ劇開始フェード後に呼ばれるハンドラ --EN:--Handler called after polyplay start fade
			proxy:LuaCall(2,REMO_START,"OnEvent_2_RemoStart",once);
			--ポリ劇終了後に呼ばれるハンドラ --EN:--Handler called after the polyplay ends
			proxy:LuaCall(2,REMO_FINISH,"OnEvent_2_RemoFinish",once);
		proxy:NotNetMessage_end();
		OnEvent_2(proxy,param);
	end

--■30■最初の要石の光が消える■ --EN:--■30■The light on the first keystone disappears■
		proxy:OnSessionJustIn( 30 , "OnEvent_30" , everytime );
		
--■31■最初の要石の光が復活する■ --EN:-- ■ 31 ■ The light of the first keystone is restored ■
		proxy:OnSessionJustOut( 31 , "OnEvent_31" , everytime );


	
--■??■徘徊デーモンの登場■ハンドラ登録 --EN:--■??■Appearance of wandering daemon■Handler registration
	proxy:NotNetMessage_begin();
		--プレイヤーがソロで死亡した時にキックされます。 --EN:--Kicked when a player dies solo.
		proxy:LuaCall( 4000, 100, "PlayerDeath_m02_00_00_00", everytime );
		--プレイヤーが復活した時にキックされます。 --EN:--Kicked when the player is revived.
		proxy:LuaCall( 4032, 100, "PlayerRevive_m02_00_00_00", everytime );
	proxy:NotNetMessage_end();
	
	

--チェックポイント用の監視 --EN:--monitoring for checkpoints
	local check_point_list	= {2190, 2191, 2390, 2590, 2790, 2791};
	local check_point_num	= table.getn(check_point_list);
	for index = 1, check_point_num, 1 do
		proxy:OnRegionJustIn( SYSTEM_CHECK_POINT, LOCAL_PLAYER, check_point_list[index], "CheckPointIn_AttrCheck", everytime );
	end
	--最初に1回チェックしておく --EN:--Check once first
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( SYSTEM_CHECK_POINT, "InitializeNpc", 0.0, 0, 2, once );
		proxy:OnKeyTime2( SYSTEM_CHECK_POINT, "HiryuOsaCheck",0.0, 0, 3, once );
	proxy:NotNetMessage_end();

	--チェックポイント配信用 --EN:--For checkpoint delivery
	proxy:LuaCall( SYSTEM_CHECK_POINT, 2, "CheckPointIn", everytime );
	
	if proxy:IsClient() == false then
		if proxy:IsCompleteEvent( 85 ) == false then
			proxy:NotNetMessage_begin();
			proxy:OnRegionJustIn( 85 , LOCAL_PLAYER , 2002 , "OnEvent_85" , once );
			proxy:NotNetMessage_end();
		end
	end
	
	--レンドル王子の更新権限はホストが管理 --EN:--Prince Lendl's update authority is managed by the host
	if	proxy:IsClient() == false then
		proxy:RequestForceUpdateNetwork( 620 );
		proxy:RequestForceUpdateNetwork( 621 );
		proxy:RequestForceUpdateNetwork( 624 );
		proxy:RequestForceUpdateNetwork( 626 );
	end

	
	--■0■城門開放レバー■がおわっているとき --EN:-- ■ 0 ■ When the castle gate opening lever ■ is over
	if proxy:IsCompleteEvent( 0 ) == true then

		proxy:DeleteEvent( 230 );--飛竜飛んでくるイベント監視削除 --EN:--Deletion of flying dragon event monitoring
		
		--魔法壁見えている --EN:--I can see the magic wall
		proxy:SetColiEnable( 1999 , true );
		proxy:SetColiEnable( 1995 , true );
	
		proxy:SetDrawEnable( 1999 , true );
		proxy:SetDrawEnable( 1995 , true );
		
		--魔法壁のSFX ON --EN:--Magical Wall SFX ON
		proxy:ValidSfx( 1987 );
		proxy:ValidSfx( 1991 );
	else
	
		--魔法壁消えている --EN:--Magic wall is gone
		proxy:SetColiEnable( 1999 , false );
		proxy:SetColiEnable( 1995 , false );
	
		proxy:SetDrawEnable( 1999 , false );
		proxy:SetDrawEnable( 1995 , false );
		
		--魔法壁のSFX OFF --EN:--Magic Wall SFX OFF
		proxy:InvalidSfx( 1987 , false );
		proxy:InvalidSfx( 1991 , false );
	end
	
	
--■ボス関連の初期化処理 --EN:--■ Boss-related initialization processing
	if proxy:IsCompleteEvent( 4096 ) ==true then
		
		--▽ボス死んでいるとき --EN:--▽When the boss is dead
		--ファランクス死亡 --EN:--Phalanx dead
		--m02_00_00_00_eventboss のInitにて記述 --EN:-- Described in Init of m02_00_00_00_eventboss
		
		--魔法壁消える --EN:--Magic wall disappears
		proxy:SetColiEnable( 1999 , false );
		proxy:SetColiEnable( 1995 , false );
	
		proxy:SetDrawEnable( 1999 , false );
		proxy:SetDrawEnable( 1995 , false );
		
		--魔法壁のSFX OFF --EN:--Magic Wall SFX OFF
		proxy:InvalidSfx( 1987 , false );
		proxy:InvalidSfx( 1991 , false );
		

	else
		--▽ボス生きているとき	 --EN:--▽ When the boss is alive
		
			--ファランクス用の初期化処理 --EN:--Initialization process for Phalanx
			--m02_00_00_00_eventboss のInitにて記述 --EN:-- Described in Init of m02_00_00_00_eventboss
		
		--[[光の壁を表示しなければならないが、■0■城門開放レバー■でやっている]] --EN:--[[I need to display a wall of light, but I'm doing it with ■0■ gate opening lever■]]
	end		
	
	
	--■4103,4105■ソウル入手、要石でワープ■ --EN:-- ■ 4103, 4105 ■ Get soul, warp with keystone ■
	if proxy:IsCompleteEvent( 4096 ) ==true then--ボスが死んでいるとき --EN:--when the boss is dead
		
		proxy:TreasureDispModeChange2( 1982 , true ,KANAME_SFX);--光らせる --EN:-- let it shine
		--▼(ソウル)アイテム取得用イベント監視追加▼ --EN:--▼ (Soul) Added event monitoring for item acquisition▼
		if proxy:IsCompleteEvent( 4103 ) == false then
			--SFX有効化 --EN:--SFX enable
			proxy:ValidSfx( 1080 );--光の粒子 --EN:--Particles of light
			proxy:ValidSfx( 1081 );--要石のオーラ			 --EN:--Keystone Aura
			proxy:OnDistanceActionAttribute( 4103 , LOCAL_PLAYER , 1982 , "OnEvent_4103" , WarpGimmickDist_A , 10010180 , 0 , 180 , ATTR_HOST + ATTR_LIVE + ATTR_GREY, once );

			--ソウル有効化 --EN:--Soul activation
			proxy:SetDrawEnable( 1982 , true );
			proxy:SetColiEnable( 1982 , true );
			--ソウル2有効化 --EN:--Activate Soul 2
			proxy:SetDrawEnable( 1975 , true );
			proxy:SetColiEnable( 1975 , true );

		else
			--SFX OFF
			proxy:InvalidSfx( 1080, false );--光の粒子 --EN:--Particles of light
			--proxy:InvalidSfx( 1081, false );--要石のオーラ --EN:--Keystone Aura
			--▼要石でワープ用の監視を追加▼ --EN:--▼ Added surveillance for warp with keystone ▼
			SingleReset(proxy,4105);
			proxy:OnDistanceActionAttribute( 4105 , LOCAL_PLAYER , 1982 , "OnEvent_4105" , WarpGimmickDist_A , HELPID_GO_TO_SEKITYUU , 0 , 180 , ATTR_NOSESSION , everytime );
		end

	else
		--ボスが生きている --EN:--the boss is alive
		--ソウル無効化 --EN:--Soul Invalidation
		proxy:SetDrawEnable( 1982 , false );
		proxy:SetColiEnable( 1982 , false );
		--ソウル2無効化 --EN:--Soul 2 disabled
		proxy:SetDrawEnable( 1975 , false );
		proxy:SetColiEnable( 1975 , false );
		
		--SFX OFF
		proxy:InvalidSfx( 1080, false );--光の粒子 --EN:--Particles of light
		proxy:InvalidSfx( 1081, false );--要石のオーラ --EN:--Keystone Aura
	end

--[[--削除との事なので、コメントアウト --EN:--Comment out because it is about deleting
--■90■薄板壁を壊して敵が飛び出してくる■キャラ制御 --EN:-- ■ 90 ■ Destroy the thin wall and the enemy will jump out ■ Character control
	
	if proxy:IsCompleteEvent( 90 ) == false then
		proxy:EnableLogic( 202 , 0 );--ロジックきってるけど、敵が攻撃してくる? --EN:--The logic is good, but is the enemy attacking?
		proxy:SetDrawEnable( 202 , false );
		proxy:SetColiEnable( 202 , false );
	else
		proxy:EnableLogic( 202 , 1 );
		proxy:SetDrawEnable( 202 , true );
		proxy:SetColiEnable( 202 , true );
	end]]
	
	--■91■薄板壁を壊して敵が飛び出してくる2■キャラ制御 --EN:-- ■ 91 ■ Destroy the thin wall and enemies will pop out 2 ■ Character control
	if proxy:IsCompleteEvent( 91 ) == false then
		proxy:EnableLogic( 215 , 0 );
		proxy:SetDrawEnable( 215 , false );
		proxy:SetColiEnable( 215 , false );
		
		proxy:EnableLogic( 216 , 0 );
		proxy:SetDrawEnable( 216 , false );
		proxy:SetColiEnable( 216 , false );
	else
		proxy:EnableLogic( 215 , 1 );
		proxy:SetDrawEnable( 215 , true );
		proxy:SetColiEnable( 215 , true );
		
		proxy:EnableLogic( 216 , 1 );
		proxy:SetDrawEnable( 216 , true );
		proxy:SetColiEnable( 216 , true );
	end
	
	
	--■160■奴隷兵士が落ちてくる■ロジック制御 --EN:-- ■ 160 ■ Slave soldiers fall ■ Logic control
	if proxy:IsCompleteEvent( 160 ) == false then
		proxy:EnableLogic( 220 , false );
		proxy:SetDrawEnable( 220 , false );
		proxy:SetColiEnable( 220 , false );--場所が変わっていたので、あたりも消した。 --EN:--The location has changed, so I erased the area.
	--	proxy:Warp( 220 , 2110 );--塔(?)のほうにワープ --EN:--Warp to the tower (?)
	else
		proxy:EnableLogic( 220 , 1 );
	end
	
	
	--■180■一般兵士が降りてくる■ロジック制御	 --EN:-- ■ 180 ■ Regular soldiers descend ■ Logic control
	if proxy:IsCompleteEvent( 180 ) == false then
		
		proxy:Warp( 211 , 2170 );
		proxy:Warp( 206 , 2171 );
		
		proxy:ForceUpdateNextFrame( 211 );
		proxy:ForceUpdateNextFrame( 206 );
		
		proxy:EnableLogic( 211 , 0 );
		proxy:EnableLogic( 206 , 0 );
	else
		proxy:EnableLogic( 211 , 1 );
		proxy:EnableLogic( 206 , 1 );
	end
	
--[[	
	--■181■一般兵士が降りてくる2■ロジック制御 --EN:-- ■ 181 ■ 2 ■ Logic control where general soldiers descend
	if proxy:IsCompleteEvent( 181 ) == false then
		proxy:EnableLogic( 221 , 0 );
	else
		proxy:EnableLogic( 221 , 1 );
	end
]]	


	--■中ボス死亡で扉が開く(死んでいたら、描画と当たりを消す) --EN:--■ The door opens when the mid-boss dies (if it dies, the drawing and hits are erased)
	if proxy:IsCompleteEvent( 4096 ) == true then
		proxy:SetColiEnable( 1999 , false );
		proxy:SetColiEnable( 1995 , false );
	
		proxy:SetDrawEnable( 1999 , false );
		proxy:SetDrawEnable( 1995 , false );	
	end
	

--[[
	--■徘徊デーモン用 (フラグは仮、指定があれば変える) --EN:--■For wandering daemon (flag is tentative, change if specified)
	if proxy:IsCompleteEvent( 20 ) == true then
		LuaFunc_VisibleTheWanderingDemon  (proxy, param, demon_id_list_m02_00_00_00);
	else
		LuaFunc_InvisibleTheWanderingDemon(proxy, param, demon_id_list_m02_00_00_00);
	end
]]

--[[
	--■220■飛竜(長)が寝ている■ --EN:-- ■ 220 ■ Wyvern (Long) is sleeping ■
	proxy:EnableLogic( 300 , false );--飛竜(長)ロジックOFF --EN:--Hiryu (Long) Logic OFF
	proxy:PlayLoopAnimation( 300 , 7000 );--警戒しているアニメループ再生 --EN:-- Alert animation loop playback
	
	if proxy:IsCompleteEvent( 220 ) == true then

		--領域監視を追加しなおす --EN:--re-add region monitor
		proxy:SetEventFlag( 220 , 0 );
		proxy:OnRegionIn( 220 , LOCAL_PLAYER , 2130 , "OnEvent_220" , everytime );
		proxy:SetEventFlag( 220 , 1 );
	
	else
		proxy:PlayLoopAnimation( 300 , 7000 );--寝ているアニメループ再生 --EN:--Sleeping animation loop playback
	end
]]
	
	
	--光の霧を通過できるキャラタイプ(このタイプの人だけアクションボタンが反応する) --EN:--Character type that can pass through the fog of light (only this type of person reacts to the action button)
	local possible_chr_type = ATTR_HOST + ATTR_LIVE + ATTR_GREY;
	
	--■240■ホストPCのみが通れる光の霧■ --EN:--■240■Light fog that only the host PC can pass■
	if proxy:IsCompleteEvent( 240 ) == true then--ホストが通過済み --EN:--Host passed
		proxy:SetDrawEnable( 1055 , false );
		proxy:SetColiEnable( 1055 , false );
		proxy:InvalidSfx(2075, false);
	else
		--▼240▼魔法壁削除同期用▼ --EN:--▼240▼For synchronizing magic wall deletion▼
		proxy:LuaCall( 240 , 1 , "OnEvent_240_delete_wall" , once );
		--▼240▼壁の中に入るイベント発動用▼ --EN:--▼240▼For triggering the event to enter the wall▼
		proxy:OnDistanceActionAttribute( 240 , LOCAL_PLAYER , 1055 , "OnEvent_240" , 1.5 , HELPID_GO_TO_IN , 180 , DoorAngle_A , possible_chr_type, everytime );
	end
	
	
	--■241■ホストPCのみが通れる光の霧■ --EN:-- ■ 241 ■ A fog of light that only the host PC can pass through ■
	if proxy:IsCompleteEvent( 241 ) == true then--ホストが通過済み --EN:--Host passed
		proxy:SetDrawEnable( 1056 , false );
		proxy:SetColiEnable( 1056 , false );
		proxy:InvalidSfx(2076, false);
	else
		--▼241▼魔法壁削除同期用▼ --EN:--▼241▼For Synchronizing Magic Wall Deletion▼
		proxy:LuaCall( 241 , 1 , "OnEvent_241_delete_wall" , once );
		
		--▼241▼壁の中に入るイベント発動用▼ --EN:-- ▼ 241 ▼ For triggering the event to enter the wall ▼
		proxy:OnDistanceActionAttribute( 241 , LOCAL_PLAYER , 1056 , "OnEvent_241" , 1.5 , HELPID_GO_TO_IN , 180 , DoorAngle_A , possible_chr_type, everytime );
	end
	
	
	--■242■ホストPCのみが通れる光の霧■ --EN:-- ■ 242 ■ A fog of light that only the host PC can pass through ■
	if proxy:IsCompleteEvent( 242 ) == true then--ホストが通過済み --EN:--Host passed
		proxy:SetDrawEnable( 1057 , false );
		proxy:SetColiEnable( 1057 , false );
		proxy:InvalidSfx(2077, false);
	else		
		--▼242▼魔法壁削除同期用▼ --EN:--▼242▼For synchronizing magic wall deletion▼
		proxy:LuaCall( 242 , 1 , "OnEvent_242_delete_wall" , once );
		
		--▼242▼壁の中に入るイベント発動用▼ --EN:--▼242▼For triggering an event to enter the wall▼
		proxy:OnDistanceActionAttribute( 242 , LOCAL_PLAYER , 1057 , "OnEvent_242" , 1.5 , HELPID_GO_TO_IN , 180 , DoorAngle_A , possible_chr_type, everytime );
	end

	


	
	--■285■砲弾ゴロゴロ■ --EN:-- ■ 285 ■ cannonball rumbling ■
	if proxy:IsCompleteEvent( 285 ) == true then
		proxy:ReconstructBreak( 1190 , 1 );--箱オブジェの破壊再現 --EN:-- Destroyed box object
	end
	
	
	
	

--■飛竜(長)イベント関連初期化 --EN:-- ■ Wyvern (Long) event-related initialization

	--初期化 --EN:--Initialization
	proxy:SetDisableGravity( 300 , true );--重力OFF --EN:--Gravity off
	proxy:EnableLogic( 300 , false );--思考OFF --EN:--Thinking OFF
	proxy:SetSuperArmor( 300 , true );--ダメージモーションさせない --EN:--No damage motion
	proxy:SetDeadMode(300, true);--飛竜は死なない設定(死にそうになったら撤退する) --EN:--Set so that flying dragons don't die (withdraw if they're about to die)
	
	
	--初期状態をセット(状態が未設定の場合、指定した状態をセットする) --EN:--Set the initial state (if the state is not set, set the specified state)
	SetFirstNpcStateFlag( proxy , param , tyo_flag_list , TYO_STATE_WARNING_AISLE );
	
	--現在の状態取得 --EN:-- Get current status
	local now_tyo_state = GetNpcStateFlag( proxy , param , tyo_flag_list );
	
	--飛竜の長が、王の間(王城4)からこっそり退去する --EN:--The Chief of the Wyvern secretly leaves the King's Room (Castle 4)
	if now_tyo_state == TYO_STATE_WARNING_KING_ROOM or 
	   now_tyo_state == TYO_STATE_WARNING_GATE      then
	   
		--飛竜(長)の状態を「警戒(通路)」にセット --EN:-- Set the status of Hiryu (Long) to "Warning (Passage)"
		SetNpcStateFlag( proxy , param , tyo_flag_list , TYO_STATE_WARNING_AISLE );
	end
	
	--現在の状態取得(状態が変わった可能性があるので) --EN:-- get the current state (because the state may have changed)
	local now_tyo_state = GetNpcStateFlag( proxy , param , tyo_flag_list );
	
	--警戒(通路) --EN:--Warning (passageway)
	if now_tyo_state == TYO_STATE_WARNING_AISLE then
		
		proxy:EnableLogic( 300 , false );
		proxy:PlayLoopAnimation( 300 , 7000 );
		
	--死亡 --EN:--death
	elseif now_tyo_state == TYO_STATE_DEAD then
		InvalidCharactor( proxy , 300 );--いないことに･･･ --EN:--Unfortunately...
		
		--飛竜(長)関連イベント削除 --EN:--Deletion of Wyvern (Long) related events
		proxy:DeleteEvent( 220 );--巣で寝ている --EN:--sleeping in a nest
	end

	if	proxy:IsCompleteEvent( KENZOKU_2_STATE_DEAD ) == true or
	    proxy:IsCompleteEvent( KENZOKU_STATE_DEAD ) == true then
		proxy:OpeningDead( 301, false );
	end
	
--[[	
	--現在の状態取得 --EN:-- Get current status
	local now_kenzoku_state = GetNpcStateFlag( proxy , param , kenzoku_flag_list );
	
	--状態ごとに必要な初期化があるなら･･･ --EN:--if there is any initialization required for each state...
	
	if now_kenzoku_state == KENZOKU_STATE_WARNING or 
       now_kenzoku_state == KENZOKU_STATE_WARNING_AND_LEVER then
		
		--巣にいる --EN:--in the nest
		proxy:EnableLogic( 301 , false );
		proxy:PlayLoopAnimation( 301 , 0 );
		
	elseif now_kenzoku_state == KENZOKU_STATE_PROTECT_CASTLE then
	
		--城壁護ってる --EN:--Protecting the ramparts
		--プレイヤーがいなくなったら、勝手に巣帰るのでそのままで良いと思われる。 --EN:--When the player is gone, it will return to the nest without permission, so it seems to be fine as it is.
		
	elseif now_kenzoku_state == KENZOKU_STATE_DEAD    or 
		   now_kenzoku_state == KENZOKU_2_STATE_DEAD then
		   
		InvalidCharactor( proxy , 301 );--いないことに･･･ --EN:--Unfortunately...
		
		--飛竜(眷属)関連イベント削除 --EN:--Deletion of Wyvern (Family) related events
		proxy:DeleteEvent( 221 );--巣で警戒している --EN:--Watching in the Nest
		proxy:DeleteEvent( 230 );--城壁に飛んでくる --EN:--flying to the ramparts
		
	end
]]
	
--■15610■ドランの死体を調べた■ --EN:--■ 15610 ■ Examined Doran's corpse ■
	if proxy:IsCompleteEvent( 15610 ) == false then
		proxy:AddCorpseEvent( 15610 , 697 );
		proxy:NotNetMessage_begin();
			proxy:LuaCall( 15610 ,0 , "OnEvent_15610",once );
 		proxy:NotNetMessage_end();
	end
--■【NPC:ドラン】イベント関連初期化 --EN:--■ [NPC: Doran] Event-related initialization
	SetFirstNpcStateFlag( proxy , param , doran_flag_list , DORAN_STATE_GUARD );
	--ドランが生きているか --EN:--Is Doran alive?
	if proxy:IsCompleteEvent( DORAN_STATE_DEAD ) == false then
		--ドランが戦闘態勢を取っている --EN:-- Doran is ready for battle
		if proxy:IsCompleteEvent(DORAN_STATE_GUARD) == true then
			proxy:OnCharacterHP( 330, 697, "OnEvent_330", 0.8, once );	--ドランのＨＰが80％をきったら --EN:--When Doran's HP drops below 80%
			proxy:OnCharacterHP( 331, 697, "OnEvent_331", 0.6, once );	--ドランのＨＰが60％をきったら --EN:--When Doran's HP drops below 60%
			if proxy:IsCompleteEvent( 329 ) == false then
				proxy:EnableLogic( 697, false );			
				proxy:OnSimpleDamage( 329 , 697 , 10000 , "OnEvent_329" , once );
				proxy:LuaCall( 329 , 0 , "OnEvent_329",once );
			end
			--王子を最後まで助けた --EN:--Saved the prince to the end
			if proxy:IsCompleteEvent( 11790 ) == true then
				print("ドラン手加減"); --EN:print("Take it easy");
				proxy:SendEventRequest( 697 ,0, 1);
				proxy:SetEventSpecialEffect_2( 697 , 5042 );
			end
			
		--ドランがPCを許している --EN:-- Doran forgives PC
		elseif proxy:IsCompleteEvent(DORAN_STATE_ALLOWED) == true then
			proxy:SetTeamType( 697, TEAM_TYPE_Friend );
			proxy:OnCharacterHP( 331, 697, "OnEvent_331", 0.6, once );
		elseif proxy:IsCompleteEvent(DORAN_STATE_NOT_ALLOWED) == true then
		end
		proxy:OnCharacterDead( 332, 697, "OnEvent_332", once );
	--ドランが死んでいたら --EN:--If Doran were dead
	else
		if proxy:IsCompleteEvent( 15610 ) == true then
			InvalidBackRead( proxy, 697 );
		else
			--死体を再現する --EN:--reproduce the corpse
			proxy:OpeningDeadPlus( 697 , true ,false ,false );
		end
	end



	--■280■吊るされている宝死体■ --EN:--■280■The hanging treasure corpse■
	if proxy:IsCompleteEvent( 280 ) == true then
		proxy:ReconstructBreak( 1172 , 1 );--紐の破壊再現(タイミングの問題により･･･) --EN:--Reproduction of string destruction (due to timing issues...)
	else
		--死体の待機アニメ(吊るされている状態) --EN:--Standby animation of the corpse (hanging state)
		proxy:PlayAnimation( 10240 , 1001 );

		--宝システム無効化 --EN:--Disable Treasure System
		proxy:EnableObjTreasure( 10240 , false );
	end
	
	--■281■吊るされている宝死体■ --EN:--■ 281 ■ Treasure corpse hanging ■
	if proxy:IsCompleteEvent( 281 ) == true then
		proxy:ReconstructBreak( 1174 , 1 );--紐の破壊再現 --EN:--Reproduction of string destruction
	else
		--死体の待機アニメ(吊るされている状態) --EN:--Standby animation of the corpse (hanging state)
		proxy:PlayAnimation( 10241 , 1001 );

		--宝システム無効化 --EN:--Disable Treasure System
		proxy:EnableObjTreasure( 10241 , false );
	end	
	
--■61■ミラルダが死亡している場合の初期化処理■ --EN:-- ■ 61 ■ Initialization process when Miralda is dead ■
	SingleReset( proxy, 61 );
	if proxy:IsCompleteEvent( 60 ) == true or
		proxy:IsSuccessQWC(20500) == false then
		proxy:SetEventFlag( 61 , true );
	end
	
--■15605■ミラルダ死体調べた■ --EN:-- 15605 ■ Miralda's corpse examined ■
	if proxy:IsCompleteEvent( 15605 ) == false then 
		proxy:AddCorpseEvent( 15605 , 628 );
		proxy:NotNetMessage_begin();
			proxy:LuaCall( 15605 , 0 , "OnEvent_15605",once);
		proxy:NotNetMessage_end();
	end
	
	if proxy:IsCompleteEvent( 61 ) == true then
		if proxy:IsCompleteEvent( 60 ) == true and proxy:IsCompleteEvent( 15605 ) == false then
			proxy:OpeningDeadPlus( 628 , true ,false ,false );			
		else
			InvalidBackRead( proxy, 628 );
			print("ミラルダのInvalidBackReadが成功しました"); --EN:print("Miralda's InvalidBackRead was successful");
		end
	else
		--■86■領域に入ったらフラグON■ --EN:-- ■ 86 ■ Flag ON when entering area ■
		if proxy:IsCompleteEvent( 86 ) == false then
			proxy:OnRegionJustIn( 86 , 10000 , 2003 , "OnEvent_86",once);
		end
	end
	
	--[[
	--ホストは必ず登録する為、ふらぐおふ --EN:--Because the host must be registered,
	if	proxy:IsClient() == false then
		SingleReset( proxy, 62 );
	end
	]]
	
--■15635■ミラルダ・ブラックの死体を調べた■ --EN:--■ 15635 ■ Examined Miralda Black's corpse ■
	if proxy:IsCompleteEvent( 15635 ) == false then
		proxy:AddCorpseEvent( 15635 , 231 );
		proxy:NotNetMessage_begin();
			proxy:LuaCall( 15635 ,0 , "OnEvent_15635",once );
 		proxy:NotNetMessage_end();
	end	
	
	--■ミラルダ・ブラックの出現判定■ --EN:--■ Appearance judgment of Miralda Black ■
	if	proxy:IsCompleteEvent(62) == true or
		proxy:IsSuccessQWC(20300) == false then
		
		if 	proxy:IsCompleteEvent( 62 ) == true and
			proxy:IsCompleteEvent( 15635 ) == false then
			--死体を再現する --EN:--reproduce the corpse
			proxy:OpeningDeadPlus( 231 , true ,false ,false );
		else
			InvalidBackRead( proxy, 231 );
		end
	else
		proxy:OnCharacterDead( 62, 231, "OnEvent_62", once );
		proxy:SetTeamType( 698, TEAM_TYPE_AngryFriend );
	end
	
	
--■60■ミラルダが死亡■ --EN:-- ■ 60 ■ Miralda died ■
	if proxy:IsCompleteEvent( 60 ) == false then
		proxy:OnCharacterDead( 60, 628, "OnEvent_60", once );
	end
	
--■86■領域に入ったらフラグON■ --EN:-- ■ 86 ■ Flag ON when entering area ■
	if proxy:IsCompleteEvent( 86 ) == false then
		proxy:OnRegionJustIn( 86 , 10000 , 2003 , "OnEvent_86",once);
	end

--■8084■吊るされている宝死体■ --EN:--■8084■The hanging treasure corpse■
	proxy:SetEventFlag(8084, true)
--[[	
	--奴隷兵士のショップNPC --EN:-- Slave soldier's shop NPC
	if proxy:IsClient() == false then
		--クライアントが登録しないイベントなので、配信するとクライアント側でアサートが出る為、非配信設定に変更 --EN:--This is an event that the client does not register, so if it is delivered, an assert will be issued on the client side, so change to non-delivery setting
		proxy:NotNetMessage_begin();
	--■340■奴隷兵士のショップNPCチェックポイント(扉前)■ --EN:--■340■Slave soldier's shop NPC checkpoint (in front of the door)■
		proxy:OnRegionJustIn(343 , LOCAL_PLAYER , 2120 ,"OnEvent_343" , everytime);
	--■340■奴隷兵士のショップNPCチェックポイント(扉前)■ --EN:--■340■Slave soldier's shop NPC checkpoint (in front of the door)■
		proxy:OnRegionJustIn(344 , LOCAL_PLAYER , 2191 ,"OnEvent_344" , everytime);
	--■340■奴隷兵士のショップNPCチェックポイント(扉前)■ --EN:--■340■Slave soldier's shop NPC checkpoint (in front of the door)■
		proxy:OnRegionJustIn(345 , LOCAL_PLAYER , 2390 ,"OnEvent_345" , everytime);
	--■340■奴隷兵士のショップNPCチェックポイント(扉前)■ --EN:--■340■Slave soldier's shop NPC checkpoint (in front of the door)■
		proxy:OnRegionJustIn(780 , LOCAL_PLAYER , 2790 ,"OnEvent_780" , everytime);
		proxy:NotNetMessage_end();
	end
	
	--■635■チェックポイントの監視■ --EN:-- ■ 635 ■ Checkpoint monitoring ■
	proxy:LuaCall( 781 , 1 , "OnEvent_781",everytime);

	--奴隷兵士の初期化用 --EN:--For initializing slave soldiers
	OnEvent_781(proxy, param);
]]	
	
--■7■敵が砲弾ごろごろ■ --EN:-- ■ 7 ■ Enemy's cannonball ■
	RegistEvent_7(proxy);
	

--[[--削除との事なので、コメントアウト --EN:--Comment out because it is about deleting
--■10700,10701■吊るされている人が話しかけてくる■ --EN:-- ■ 10700, 10701 ■ The person hanging speaks to you ■
	if proxy:IsCompleteEvent( 10700 ) == false then
		proxy:OnRegionIn( 10700 , LOCAL_PLAYER , 2051 , "OnEvent_10700" , everytime );
		--死体から会話(助けて) --EN:--Conversation from the corpse (help me)
		proxy:RegistSimpleTalk( 10700 , 10241 , 16000, TALK_ATTR_ALL );
		
		--死体から会話(感謝) --EN:--Conversation from the corpse (thank you)
		proxy:RegistSimpleTalk( 10701, 10241, 16010, TALK_ATTR_ALL );
	end]]
	

--■15500■乱入アイテム取得監視■ハンドラはグローバルに定義 --EN:-- ■ 15500 ■ Intrusion item acquisition monitoring ■ Handlers are defined globally
--~     if proxy:IsCompleteEvent( 15500 ) == false then
--~         proxy:AddCorpseEvent( 15500 , 231 );--ミラルダ・ブラック		 --EN:--Miralda Black
--~     end
	
	
--■100■かがり火ダメージ■ --EN:-- ■ 100 ■ bonfire damage ■
	local objIdlist = {1180,1181,1182,1183,1185,1186};
	local num = table.getn( objIdlist );
	local sec = FIREDAM_WAIT;
	for index=1 , num ,1 do
		proxy:NotNetMessage_begin();	
			proxy:OnObjectDamageHit_NoCallPlus( 100, objIdlist[index],1,10300,EV_HIT_CHR,0.5,-1,2.0,everytime);
			--proxy:OnKeyTime2( 100, "OnEvent_100_"..objIdlist[index],sec,0,objIdlist[index],once);		
		proxy:NotNetMessage_end();
		--proxy:OnDistanceJustIn(100,10000,objIdlist[index],"OnEvent_100_"..objIdlist[index],0.5,everytime);		
		sec = sec + 0.1;
	end
	
	
	--■8■一般兵士が火炎瓶投げる■ --EN:-- ■ 8 ■ Ordinary soldiers throw Molotov cocktails ■
	SingleReset( proxy, 8 );
	if proxy:IsCompleteEvent( 8 ) == false then
		proxy:OnRegionJustIn( 8, 10000 , 2007 , "OnEvent_8" , once);
		proxy:OnSimpleDamage( 8, 247 , 10000 , "OnEvent_8" , once);
		
		proxy:OnRegionJustIn( 9, 10000 , 2008 , "OnEvent_9" , once);
		
		proxy:EnableLogic( 247, false );
	end
	
	
	--結晶トカゲ逃亡イベント --EN:--Crystal Lizard Escape Event
	RegistTokage(proxy,120,250,0);	
	
	--■999999■フレーム遅れの初期化処理イベントを発行■ --EN:-- ■ 999999 ■ Generate a frame delay initialization processing event ■
	proxy:NotNetMessage_begin();
		--▼0秒後▼-- --EN:--▼After 0 seconds▼--
		proxy:OnKeyTime2( 999990, "Second_Initialize_m02_00_00_00", 0.3, 0, 0, once );	
	proxy:NotNetMessage_end();
	
	proxy:LuaCall(4081, 2, "hiryuu_test_1", everytime );
	proxy:LuaCall(4081, 3, "hiryuu_test_2", everytime );
	
	if proxy:IsDbgReLoad() == true then
		proxy:OnKeyTime2( 4021,"OnEvent_DbgReLoad",1.0,0,0,once);
	end
	print("Initialize_m02_00_00_00 end");
end

--リロードデバッグ --EN:--reload debug
function OnEvent_DbgReLoad(proxy,param)
	--石柱の王城要石へ --EN:--To the keystone of the royal castle of the stone pillars
	--完全回復要求 --EN:-- full recovery request
	proxy:RequestFullRecover();
	proxy:WarpNextStage( 1, 0, 0, 0, 1006 );	
end


function hiryuu_test_1(proxy,param)
	print("hiryuu_test_1 begin");
	proxy:PlayAnimation( 300, 7018 );
	print("hiryuu_test_1 end");
end

function hiryuu_test_2(proxy,param)
	print("hiryuu_test_2 begin");
	proxy:PlayAnimation( 301, 7011 );
	print("hiryuu_test_2 end");
end


--------------------------------------------------------------------------------------
--マルチになった時にホストじゃ無かったら■無し --EN:--If you are not a host when you become multi, no
--------------------------------------------------------------------------------------
function ConnectPartyEvent(proxy)
	print("ConnectPartyEvent begin");
	print("ConnectPartyEvent end");
end

function OnEvent_4000_Hp_1(proxy,param)
	print("OnEvent_4000_Hp_1 begin");
	proxy:SetDeadMode2(800 , true );
	proxy:SetDeadMode2(801 , true );
	proxy:SetDeadMode2(802 , true );
	proxy:SetDeadMode2(821 , true );	
	print("OnEvent_4000_Hp_1 end");
end

--------------------------------------------------------------------------------------
--Initializeから呼ばれる、1フレーム遅れの初期化処理■999999 --EN:--Initialization with a delay of 1 frame, called from Initialize ■999999
--------------------------------------------------------------------------------------
--■999999■一部、Initでは処理できないので、残しておく --EN:-- ■ 999999 ■ Some parts cannot be processed by Init, so leave them
function Second_Initialize_m02_00_00_00(proxy, param)
	print("Second_Initialize_m02_00_00_00 begin");

	--■280■吊るされている宝死体■ --EN:--■280■The hanging treasure corpse■
	if proxy:IsCompleteEvent( 280 ) == true then
		proxy:ReconstructBreak( 1172 , 1 );--紐の破壊再現(タイミングの問題により･･･) --EN:--Reproduction of string destruction (due to timing issues...)
	else
		--死体の待機アニメ(吊るされている状態) --EN:--Standby animation of the corpse (hanging state)
		proxy:PlayAnimation( 10240 , 1001 );

		--宝システム無効化 --EN:--Disable Treasure System
		proxy:EnableObjTreasure( 10240 , false );
	end
	
	--■281■吊るされている宝死体■ --EN:--■ 281 ■ Treasure corpse hanging ■
	if proxy:IsCompleteEvent( 281 ) == true then
		proxy:ReconstructBreak( 1174 , 1 );--紐の破壊再現 --EN:--Reproduction of string destruction
	else
		--死体の待機アニメ(吊るされている状態) --EN:--Standby animation of the corpse (hanging state)
		proxy:PlayAnimation( 10241 , 1001 );

		--宝システム無効化 --EN:--Disable Treasure System
		proxy:EnableObjTreasure( 10241 , false );
	end
--------------------------------▽▽▽QWCイベント関連▽▽▽-------------------------------- --EN:--▽▽▽QWC event related ▽▽▽--------------------------------
--------------------------------△△△QWCイベント関連△△△-------------------------------- --EN:--△△△QWC event related△△△--------------------------------
	
	print("Second_Initialize_m02_00_00_00 end");
end

-----------------------------------------------------------------------------------------------------------------------------------------------
--■391～409■樽爆発(小)■ --EN:-- ■ 391～409 ■ barrel explosion (small) ■
--■421～430■樽爆発(大)■ --EN:-- 421～430 ■ Barrel Explosion (Large) ■
-----------------------------------------------------------------------------------------------------------------------------------------------
function TaruRegist(proxy,param)
	print("TaruRegist begin");
	local Owner = 235;
	--弾丸オーナー利用 --EN:--Bullet owner use
	CreateBulletOwner(proxy,Owner);	
	
	local small_acId_list	= {  391,  392,  393,  394,  395,  396,  397,  398,  399,  400,  401,  402,  403,  404,  405,  406,  407,  408,  409};
	local small_objId_list	= { 1141, 1142, 1143, 1144, 1145, 1146, 1147, 1148, 1149, 1150, 1151, 1152, 1153, 1154, 1155, 1156, 1157, 1158, 1159};
	local small_event_num = table.getn( small_acId_list );
	for index = 1, small_event_num, 1 do
		local acid = small_acId_list[index];
		local evid = small_objId_list[index];
		SingleReset(proxy,acid);
		if	proxy:IsCompleteEvent( acid ) == false then
			--proxy:OnFireDamage( acid, evid, -1, "OnEvent_"..acid, once );
			proxy:OnFireDamage( acid, evid, -1, "OnEvent_"..acid, once );
		else
			proxy:ReconstructBreak( evid, 1 );
		end
	end
	
	
	
	local big_acId_list		= {  421,  422,  423,  424,  425,  426,  427,  428,  429,  430};
	local big_objId_list	= { 1021, 1022, 1023, 1024, 1025, 1026, 1027, 1028, 1029, 1030};
	local big_event_num = table.getn( big_acId_list );
	for index = 1, big_event_num, 1 do
		local acid = big_acId_list[index];
		local evid = big_objId_list[index];
		SingleReset(proxy,acid);
		if	proxy:IsCompleteEvent( acid ) == false then
			proxy:OnFireDamage( acid, evid, -1, "OnEvent_"..acid, once );
		else
			proxy:ReconstructBreak( evid, 1 );
		end
	end
	print("TaruRegist end");
end

-----------------------------------------------------------------------------------------------------------------------------------------------
--■391～409■樽爆発(小)■ --EN:-- ■ 391～409 ■ barrel explosion (small) ■
-----------------------------------------------------------------------------------------------------------------------------------------------
function OnEvent_391(proxy,param) TaruFunc(proxy,param,param:GetParam1(), 235, param:GetParam2(), 10190 , 0,0,0); end
function OnEvent_392(proxy,param) TaruFunc(proxy,param,param:GetParam1(), 235, param:GetParam2(), 10190 , 0,0,0); end
function OnEvent_393(proxy,param) TaruFunc(proxy,param,param:GetParam1(), 235, param:GetParam2(), 10190 , 0,0,0); end
function OnEvent_394(proxy,param) TaruFunc(proxy,param,param:GetParam1(), 235, param:GetParam2(), 10190 , 0,0,0); end
function OnEvent_395(proxy,param) TaruFunc(proxy,param,param:GetParam1(), 235, param:GetParam2(), 10190 , 0,0,0); end
function OnEvent_396(proxy,param) TaruFunc(proxy,param,param:GetParam1(), 235, param:GetParam2(), 10190 , 0,0,0); end
function OnEvent_397(proxy,param) TaruFunc(proxy,param,param:GetParam1(), 235, param:GetParam2(), 10190 , 0,0,0); end
function OnEvent_398(proxy,param) TaruFunc(proxy,param,param:GetParam1(), 235, param:GetParam2(), 10190 , 0,0,0); end
function OnEvent_399(proxy,param) TaruFunc(proxy,param,param:GetParam1(), 235, param:GetParam2(), 10190 , 0,0,0); end
function OnEvent_400(proxy,param) TaruFunc(proxy,param,param:GetParam1(), 235, param:GetParam2(), 10190 , 0,0,0); end
function OnEvent_401(proxy,param) TaruFunc(proxy,param,param:GetParam1(), 235, param:GetParam2(), 10190 , 0,0,0); end
function OnEvent_402(proxy,param) TaruFunc(proxy,param,param:GetParam1(), 235, param:GetParam2(), 10190 , 0,0,0); end
function OnEvent_403(proxy,param) TaruFunc(proxy,param,param:GetParam1(), 235, param:GetParam2(), 10190 , 0,0,0); end
function OnEvent_404(proxy,param) TaruFunc(proxy,param,param:GetParam1(), 235, param:GetParam2(), 10190 , 0,0,0); end
function OnEvent_405(proxy,param) TaruFunc(proxy,param,param:GetParam1(), 235, param:GetParam2(), 10190 , 0,0,0); end
function OnEvent_406(proxy,param) TaruFunc(proxy,param,param:GetParam1(), 235, param:GetParam2(), 10190 , 0,0,0); end
function OnEvent_407(proxy,param) TaruFunc(proxy,param,param:GetParam1(), 235, param:GetParam2(), 10190 , 0,0,0); end
function OnEvent_408(proxy,param) TaruFunc(proxy,param,param:GetParam1(), 235, param:GetParam2(), 10190 , 0,0,0); end
function OnEvent_409(proxy,param) TaruFunc(proxy,param,param:GetParam1(), 235, param:GetParam2(), 10190 , 0,0,0); end

-----------------------------------------------------------------------------------------------------------------------------------------------
--■421～430■樽爆発(大)■ --EN:-- 421～430 ■ Barrel Explosion (Large) ■
-----------------------------------------------------------------------------------------------------------------------------------------------
function OnEvent_421(proxy,param) TaruFunc(proxy,param,param:GetParam1(), 235, param:GetParam2(), 10200 , 0,0,0); end
function OnEvent_422(proxy,param) TaruFunc(proxy,param,param:GetParam1(), 235, param:GetParam2(), 10200 , 0,0,0); end
function OnEvent_423(proxy,param) TaruFunc(proxy,param,param:GetParam1(), 235, param:GetParam2(), 10200 , 0,0,0); end
function OnEvent_424(proxy,param) TaruFunc(proxy,param,param:GetParam1(), 235, param:GetParam2(), 10200 , 0,0,0); end
function OnEvent_425(proxy,param) TaruFunc(proxy,param,param:GetParam1(), 235, param:GetParam2(), 10200 , 0,0,0); end
function OnEvent_426(proxy,param) TaruFunc(proxy,param,param:GetParam1(), 235, param:GetParam2(), 10200 , 0,0,0); end
function OnEvent_427(proxy,param) TaruFunc(proxy,param,param:GetParam1(), 235, param:GetParam2(), 10200 , 0,0,0); end
function OnEvent_428(proxy,param) TaruFunc(proxy,param,param:GetParam1(), 235, param:GetParam2(), 10200 , 0,0,0); end
function OnEvent_429(proxy,param) TaruFunc(proxy,param,param:GetParam1(), 235, param:GetParam2(), 10200 , 0,0,0); end
function OnEvent_430(proxy,param) TaruFunc(proxy,param,param:GetParam1(), 235, param:GetParam2(), 10200 , 0,0,0); end

--樽爆発まとめ --EN:--Barrel Explosion Summary
function TaruFunc(proxy,param,acId,Owner,objId,behaviorId,angX,angY,angZ)
	print("OnEvent_"..acId.." begin");
	proxy:CastPointSpell( Owner, objId, behaviorId, angX, angY, angZ );
	proxy:SetEventFlag( acId, true );
	print("OnEvent_"..acId.." end");
end




--------------------------------------------------------------------------------------
--城門開放レバー■0 --EN:--Castle gate opening lever 0
--------------------------------------------------------------------------------------
--■0■城門開放レバー■ --EN:-- ■ 0 ■ castle gate opening lever ■
function OnEvent_0(proxy, param)
	if param:IsNetMessage() == true then
		return;
	end
	print("OnEvent_0 begin");

	proxy:NotNetMessage_begin();
		--▼***条件追加***0秒後▼ --EN:--▼***Condition added***After 0 seconds▼
		proxy:OnKeyTime2( 0, "OnEvent_0_3", 0.0, 0, 1, once);
	proxy:NotNetMessage_end();
	

	print("OnEvent_0 end");
end

--▲0_3▲PCがレバーイベントを起こしてから0秒後▲ --EN:--▲0_3▲0 seconds after the PC causes a lever event▲
function OnEvent_0_3(proxy, param)
	print("OnEvent_0_3 begin");
	
	proxy:LuaCallStart(0,1);
	
	--フラグを立てる(指示書に合わせるため) --EN:--Flag (to meet directives)
	proxy:SetEventFlag( 1 , 1 );
	
	print("OnEvent_0_3 end");
end

function OnEvent_0_4(proxy,param)
	print("OnEvent_0_4 begin");
	
	if param:IsNetMessage() == true then
		--発動者出演ポリ劇 --EN:--Poly drama with caster
		proxy:RequestRemoPlus(20001,REMO_FLAG,0,1, param:GetPlayID()+10001);
	else
		--ポリ劇再生 --EN:--Poly play
		proxy:RequestRemoPlus(20001,REMO_FLAG,0,1,LOCAL_PLAYER);--正門が開くポリ劇 --EN:--The front gate opens the police drama
	end
	
	proxy:SetEventFlag( 0 , 1 );
	
	print("OnEvent_0_4 end");
end

--ポリ劇フェードアウト後 --EN:--After polyplay fade-out
function OnEvent_0_RemoStart(proxy,param)
	print("OnEvent_0_RemoStart begin");
	--空 --EN:--Sky
	print("OnEvent_0_RemoStart end");
end

--ポリ劇再生後 --EN:--After polyplay
function OnEvent_0_RemoFinish(proxy,param)
	print("OnEvent_0_RemoFinish begin");
	
	--魔法壁が表示される --EN:--Magic wall is displayed
	proxy:SetColiEnable( 1999 , true );
	proxy:SetColiEnable( 1995 , true );

	proxy:SetDrawEnable( 1999 , true );
	proxy:SetDrawEnable( 1995 , true );
	
	--魔法壁のSFX ON --EN:--Magical Wall SFX ON
	proxy:ValidSfx( 1987 );
	proxy:ValidSfx( 1991 );
	
	--飛竜関連が飛んでくる(帰る)イベント監視削除 --EN:--Deletion of flying dragon related (returning) event monitoring
	--proxy:DeleteEvent( 230 );--飛んでくる --EN:--flying
	
	proxy:EndAnimation( 1000, 1 );--レバーアニメを再生 --EN:--Play lever animation
	proxy:EndAnimation( 1001, 1 );--正門開放アニメを再生 --EN:--Play front gate opening animation
	proxy:EndAnimation( 1140, 1 );--ギアが動くアニメ再生 --EN:--Animation playback with moving gears
	
	--槍OBJを有効化 --EN:--Enable Spear OBJ
	proxy:SetDrawEnable( 1008 , true );
	proxy:SetColiEnable( 1008 , true );
	
	print("OnEvent_0_RemoFinish end");
end

--------------------------------------------------------------------------------------
--城内部扉開放4096 --EN:--Castle door open 4096
--------------------------------------------------------------------------------------
--■4096■中ボス死亡時■ --EN:-- ■ 4096 ■ When the middle boss dies ■
function OnEvent_4096(proxy, param)
	print("OnEvent_4096 begin");
	
	--ファランクス用死亡処理 --EN:--Death treatment for Phalanx
	PhalanxDead(proxy,param);
	
	proxy:NotNetMessage_begin();
		--▼4100▼クライアントPCワープ演出▼ --EN:--▼4100▼Client PC warp effect▼
		proxy:OnKeyTime2( 4100, "OnEvent_4100", 0, 0, 0, once);
		--▼4096_1▼1秒経過▼ --EN:--▼4096_1▼1 second passed▼
		proxy:OnKeyTime2( 4096, "OnEvent_4096_1", 1, 0, 1, once);
		--▼4102▼2秒経過▼ --EN:--▼4102▼2 seconds passed▼
		proxy:OnKeyTime2( 4102, "OnEvent_4102", 2, 0, 2, once);
		
		--マルチ時のPTエリア移動回避 --EN:--Avoiding PT area movement during multiplayer
		proxy:OnRegistFunc( 4096 , "Check_4096_PT","OnEvent_4096_PT",0,once);
	proxy:NotNetMessage_end();

	
	proxy:SetEventFlag( 4096, 1 );
	
	--レンドル王子が探索だったら一定距離以上離れた時点で次の状態に遷移 --EN:--If Prince Lendl is searching, transition to the next state when it is more than a certain distance away
	if	proxy:IsClient() == false then
		if	proxy:IsCompleteEvent( RENDOL_STATE_SEARCH_1 ) == true then
			if	proxy:IsDistance( LOCAL_PLAYER, 624, 20 ) == false then
				proxy:OnKeyTime2( SYSTEM_CHECK_POINT, "OnEvent_301", 0.0, 0, 2, once );
			else
				proxy:OnPlayerDistanceOut( 301, LOCAL_PLAYER, 624, "OnEvent_301", 20, once );
			end
		end
	end
	
	--新ブロッククリア処理へ --EN:--To new block clear processing
	proxy:CustomLuaCallStart( 4050, 800);
	--結晶トカゲイベントリセット --EN:--Crystal lizard event reset
	ResetTokage(proxy);
	
	--[[
	if proxy:IsClient() == false then
		proxy:NotNetMessage_begin();
			proxy:OnKeyTime2( 4096 , "OnEvent_4096_2",5.0,0,0,once);
		proxy:NotNetMessage_end();
	end
	]]
	print("OnEvent_4096 end");
end

--▲4096_1▲城内部扉開放:中ボス死亡後1秒▲ --EN:--▲4096_1▲Open the door inside the castle: 1 second after the middle boss dies▲
function OnEvent_4096_1(proxy, param)
	print("OnEvent_4096_1 begin");
	
	--ボスを倒した数を更新(数によってフラグを立てる) --EN:--update number of bosses killed (flag by number)
	GetBossFlagCount( proxy, param );
	
	--▼トロフィー取得判定▼ --EN:--▼Trophy Acquisition Judgment▼
	Lua_RequestUnlockTrophy(proxy, 27);
	
	--奴隷兵士の状態遷移チェック --EN:--Slave soldier state transition check
	OnEvent_781(proxy,param)
	
	--▼(ソウル)アイテム取得用イベント監視追加▼ --EN:--▼ (Soul) Added event monitoring for item acquisition▼
	if proxy:IsCompleteEvent( 4103 ) == false then
	
		--ソウル有効化 --EN:--Soul activation
		proxy:SetDrawEnable( 1982 , true );
		proxy:SetColiEnable( 1982 , true );
		--ソウル2有効化 --EN:--Activate Soul 2
		proxy:SetDrawEnable( 1975 , true );
		proxy:SetColiEnable( 1975 , true );
	
		--SFX有効化 --EN:--SFX enable
		proxy:ValidSfx( 1080 );--光の粒子 --EN:--Particles of light
		proxy:ValidSfx( 1081 );--要石のオーラ --EN:--Keystone Aura
		
		proxy:TreasureDispModeChange2( 1982 , true ,KANAME_SFX);--光らせる --EN:-- let it shine
		proxy:OnDistanceActionAttribute( 4103 , LOCAL_PLAYER , 1982 , "OnEvent_4103" , WarpGimmickDist_A , 10010180 , 0 , 180 , ATTR_HOST + ATTR_LIVE + ATTR_GREY, once );
	else
		--ソウル無効化(取ったら消えるので･･･) --EN:--Soul nullification (because it disappears when you take it...)
		proxy:SetDrawEnable( 1982 , false );
		proxy:SetColiEnable( 1982 , false );
	end

	--取り合えずファランクス部屋のみ対応 --EN:--For now, only phalanx rooms are supported
	print("ボス部屋アタリ通常"); --EN:print("Boss Room Atari Normal");
	--一時的に全OFF --EN:--Temporarily all OFF
	proxy:SetColiEnableArray(3010,true);--通常有効		 --EN:--usually valid
	proxy:SetColiEnableArray(3002,false);--ボス用無効 --EN:--disabled for boss
	proxy:SetColiEnableArray(3001,false);--ボス用無効 --EN:--disabled for boss
		
	print("OnEvent_4096_1 end");
end

--[[
--エリア解放の表示 --EN:--Display area release
function OnEvent_4096_2(proxy,param)
	print("OnEvent_4096_2 begin");
	--インフォ表示 --EN:--Info display
	--システムメッセージ --EN:--system message
	proxy:InfomationMenu( INFOMENU_TYPE_LIST, -1, 0, -1, 1 );
	proxy:AddInfomationBuffer( 10010740 );
	proxy:PlayTypeSE( LOCAL_PLAYER ,SOUND_TYPE_M ,777777777 );
	print("OnEvent_4096_2 end");
end
]]

--------------------------------------------------------------------------------------
--■4100■クライアントPCワープ演出■ --EN:-- ■ 4100 ■ Client PC warp effect ■
--------------------------------------------------------------------------------------

--■4100■クライアントPCワープ演出■ --EN:-- ■ 4100 ■ Client PC warp effect ■
function OnEvent_4100(proxy, param)
	print("OnEvent_4100 begin");

	if proxy:IsClient() == true then
		proxy:PlayAnimation( LOCAL_PLAYER , 8284 );--ワープアニメを再生 --EN:-- Play warp animation
	end

	proxy:SetEventFlag( 4100 , 1 );
	
	print("OnEvent_4100 end");
end


--------------------------------------------------------------------------------------
--■4102■シングル：光の壁、BGM消去■ --EN:-- ■ 4102 ■ Single: Wall of Light, BGM Elimination ■
--------------------------------------------------------------------------------------

--■4102■シングル：光の壁、BGM消去■ --EN:-- ■ 4102 ■ Single: Wall of Light, BGM Elimination ■
function OnEvent_4102(proxy, param)
	print("OnEvent_4102 begin");
		
	--ボス戦用のBGM停止 --EN:--BGM stop for boss battles
	proxy:StopPointSE( 0 );
		
	proxy:SetEventFlag( 4102 , 1 );
	
	print("OnEvent_4102 end");
end

--PTを組んでいるかの監視 --EN:--Monitoring whether you are forming a PT
function Check_4096_PT(proxy)
	if proxy:IsInParty() == false then
		return true;
	end
	return false;
end

--PTじゃないなら --EN:--If it's not PT
function OnEvent_4096_PT(proxy,param)
	print("OnEvent_4096_PT begin");
	--中ボス部屋の前後の魔法壁が消える(全プレイヤー) --EN:--The magic walls before and after the mid-boss room disappear (all players)
	proxy:SetColiEnable( 1999 , false );
	proxy:SetColiEnable( 1995 , false );
	--proxy:SetObjDeactivate( 1999 , true );--デアクティブ --EN:--deactivate
	--proxy:SetObjDeactivate( 1995 , true );--デアクティブ --EN:--deactivate
	
	proxy:SetDrawEnable( 1999 , false );
	proxy:SetDrawEnable( 1995 , false );
	
	--中ボス部屋魔法壁のSFX削除 --EN:--Remove the SFX of the mid-boss room magic wall
	proxy:InvalidSfx( 1987 , true );
	proxy:InvalidSfx( 1991 , true );
	
	--中ボス部屋前の移動処理イベントを削除 --EN:--Delete the movement processing event in front of the mid-boss room
	proxy:DeleteEvent( 110 );--一人目が入るとき用 --EN:--For when the first person enters
	proxy:DeleteEvent( 111 );--二人目以降が入るとき用 --EN:--For when the second and subsequent people enter
	proxy:DeleteEvent( 114 );--ボス戦闘開始用 --EN:--For boss battle start
	print("OnEvent_4096_PT end");
end


--------------------------------------------------------------------------------------
--城門塔右の扉開放■10 --EN:--Open the door on the right of the castle gate tower 10
--------------------------------------------------------------------------------------
--■10■レバー対応扉（右）の開放■ActionButton判定 --EN:-- ■ 10 ■ Opening the door (right) corresponding to the lever ■ ActionButton judgment
function OnEvent_10(proxy, param)
	print("OnEvent_10 begin");
	
	proxy:PlayAnimation(1005, 1);--レバーアニメ再生 --EN:--Play lever animation
	
	--プレイヤーの同期アニメーション(true:パーティープレイヤーがアニメーションした) --EN:--Player synchronous animation (true: party player animated)
	Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_PULL_LEVER );

	proxy:NotNetMessage_begin();
		--▼10_2▼***条件追加***レバーアニメ終了▼ --EN:--▼10_2▼***Condition added***Lever animation ends▼
		proxy:OnObjAnimEnd( 10, 1005, 1, "OnEvent_10_2", once);
	proxy:NotNetMessage_end();
	
	if	param:IsNetMessage() == false then
		proxy:WarpDmy( LOCAL_PLAYER , 1005 , 191 );
	end
	
	proxy:SetEventFlag( 10 , true );

	print("OnEvent_10 end");
end


--▲10_2▲レバーアニメの終了▲ --EN:--▲10_2▲End of lever animation▲
function OnEvent_10_2(proxy, param)
	print("OnEvent_10_2 begin");
	
	proxy:NotNetMessage_begin();
		--▼10_3▼***条件追加***1秒経過▼ --EN:--▼10_3▼***Condition added***1 second elapsed▼
		proxy:OnKeyTime2( 10, "OnEvent_10_3", 1.0, 0, 1, once);
	proxy:NotNetMessage_end();
	
	print("OnEvent_10_2 end");
end

--▲10_3▲レバーアニメ終了から1秒経過▲ --EN:--▲10_3▲One second has passed since the end of the lever animation▲
function OnEvent_10_3(proxy, param)
	print("OnEvent_10_3 begin");
	
	proxy:PlayAnimation(1003, 1);--扉アニメ再生 --EN:--Play door animation
	
	--フラグを立てる(指示書に合わせるため) --EN:--Flag (to meet directives)
	proxy:SetEventFlag( 11, true );
	print("OnEvent_10_3 end");
end
	


--------------------------------------------------------------------------------------
--レバー対応扉(左)■50 --EN:--Lever compatible door (left) ■50
--------------------------------------------------------------------------------------
--■50■レバー対応扉（左）■ --EN:-- ■ 50 ■ Lever compatible door (left) ■
function OnEvent_50(proxy, param)
	print("OnEvent_50 begin");
	
	proxy:PlayAnimation(1006, 1);--レバーアニメ再生 --EN:--Play lever animation
	
	--プレイヤーの同期アニメーション(true:パーティープレイヤーがアニメーションした) --EN:--Player synchronous animation (true: party player animated)
	Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_PULL_LEVER );

	proxy:NotNetMessage_begin();
		--▼50_2▼***条件追加***レバーアニメ終了▼ --EN:--▼50_2▼***Condition added***Lever animation ends▼
		proxy:OnObjAnimEnd( 50, 1006, 1, "OnEvent_50_2", once );
	proxy:NotNetMessage_end();
	
--	proxy:Warp(LOCAL_PLAYER, 2016);		--プレイヤーを所定位置にワープ --EN:--Warp player in place
	--発動者のみワープ --EN:-- Warp only for caster
	if	param:IsNetMessage() == false then
		proxy:WarpDmy( LOCAL_PLAYER , 1006 , 191 );
	end
	proxy:SetEventFlag( 50 , true );
--	proxy:DisableMove(LOCAL_PLAYER, true); --プレイヤーを操作不能に --EN:--Incapacitate player

	print("OnEvent_50 end");
end


--▲50_2▲レバーアニメ終了▲ --EN:--▲50_2▲Lever animation ends▲
function OnEvent_50_2(proxy, param)
	print("OnEvent_50_2 begin");
	
	proxy:NotNetMessage_begin();
		--▼50_3▼***条件追加***1秒経過▼ --EN:--▼50_3▼***Condition added***1 second elapsed▼
		proxy:OnKeyTime2( 50, "OnEvent_50_3", 1.0, 0, 1, once);
	proxy:NotNetMessage_end();

	print("OnEvent_50_2 end");
end


--▲50_3▲レバーアニメ終了から1秒後▲ --EN:--▲50_3▲1 second after lever animation ends▲
function OnEvent_50_3(proxy, param)
	print("OnEvent_50_3 begin");
	
	proxy:PlayAnimation( 1004, 1 );--扉アニメ再生 --EN:--Play door animation
	
	--フラグを立てる(指示書に合わせるため) --EN:--Flag (to meet directives)
	proxy:SetEventFlag( 51 , true );
	
	print("OnEvent_50_3 end");
end


--グローバルにおく？ --EN:-- put in global?
--------------------------------------------------------------------------------------
--□扉用の関数□  m04 のとはちょっとちがう。引数が一個多い。（player_anime_id) --EN:--□Function for door□ It's a little different from m04. One argument too many. (player_anime_id)
--------------------------------------------------------------------------------------

--▽これを呼ぶ▽ --EN:--▽Call this▽
function EventNormalDoor(proxy, param, event_id, door_id, door_anime_id, player_anime_id)
	print("OnEvent_"..event_id.." begin");
	
	proxy:PlayAnimation( door_id , door_anime_id );--扉のアニメーション --EN:-- door animation

	--プレイヤーの同期アニメーション(true:パーティープレイヤーがアニメーションした) --EN:--Player synchronous animation (true: party player animated)
	if Luafunc_PlaySynchroAnimation( proxy, param, player_anime_id ) == true then
		proxy:SetEventFlag( event_id , 1 );--開閉扉A(手前から開ける)への操作を無効にする。 --EN:--Disable the operation to open/close door A (open from the front).
		return;
	end

--	proxy:DisableMove(LOCAL_PLAYER,1);	 --キャラクタを移動、旋回不能に --EN:--Move the character, make it impossible to turn
	proxy:SetEventFlag( event_id , 1 );--開閉扉A(手前から開ける)への操作を無効にする。 --EN:--Disable the operation to open/close door A (open from the front).

	print("OnEvent_"..event_id.." end");
end



--------------------------------------------------------------------------------------
--石柱にワープ■70 --EN:-- Warp to stone pillar ■70
--------------------------------------------------------------------------------------
--■70■石柱にワープ■ --EN:-- ■ 70 ■ Warp to the stone pillar ■
function OnEvent_70(proxy,param)	

	if proxy:IsCompleteEvent( 70 ) == true then
		return;
	end
	
	if param:IsNetMessage() == true then
		return;
	end
	
	
	print("OnEvent_70 begin");
	
	--セッション中ならば、要石のワープ無効 --EN:--Disable keystone warp if in session
	if proxy:IsSession() == false then--セッション中ではない --EN:--not in session
		proxy:RepeatMessage_begin();
		--▼70_1▼選択メニューの監視▼ --EN:--▼70_1▼Select menu monitoring▼
			proxy:OnSelectMenu(70, "OnEvent_70_0", 10010710, 0, 2, 1983, 2, once);			
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

	print("OnEvent_70 end");
end

--▲70_0▲選択メニューの監視▲ --EN:--▲70_0▲Monitor selection menu▲
function OnEvent_70_0(proxy, param)
	print("OnEvent_70_0 begin");	
	
	if proxy:IsSession() == false then
		proxy:PlayAnimation( LOCAL_PLAYER , 8283 );--要石に触れるアニメを再生 --EN:--Play the animation that touches the keystone
		proxy:NoAnimeTurnCharactor( 10000 , 1983 ,TURNSKIP_ANGLE);
		
		proxy:NotNetMessage_begin();
			--▼要石に触れるアニメ再生終了▼ --EN:--▼Animation touching the keystone ends▼
			proxy:OnChrAnimEnd( 70 , LOCAL_PLAYER , 8283 , "OnEvent_70_1" , once );
		proxy:NotNetMessage_end();

		proxy:SetEventFlag( 70 , true );
	else
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010720, 0, 6, 1983, GEN_DIALOG_DIST, once );
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
	end
	
	print("OnEvent_70_0 end");
end

--▲70_1▲要石に触れるアニメ再生終了▲ --EN:--▲70_1▲End of playing the animation touching the keystone▲
function OnEvent_70_1(proxy, param)
	print("OnEvent_70_1 begin");
	
	proxy:SetEventFlag( 70 , false );
	
	proxy:PlayAnimation( LOCAL_PLAYER , 8284 );--自世界に帰るアニメを再生 --EN:--Play animation to return to your own world
	
	--[[
	proxy:NotNetMessage_begin();
		--▼自世界に帰るアニメ再生終了▼ --EN:--▼End of animation playback to return to your own world▼
		proxy:OnChrAnimEnd( 70 , LOCAL_PLAYER , 8284 , "OnEvent_70_2" , once );
	proxy:NotNetMessage_end();
	]]

	proxy:SetEventFlag( 70 , true );
	OnEvent_70_2(proxy,param);
	
	print("OnEvent_70_0 end");
end

--▲自世界に帰るアニメ再生終了▲ --EN:--▲Returning to your own world, end of animation ▲
function OnEvent_70_2(proxy,param)	
	print("OnEvent_70_2 begin");

	--石柱へ戻ってきた判定のフラグを立てる --EN:--Flag the judgment of returning to the stone pillar
	proxy:SetEventFlag(8083, true);
	
	proxy:SetEventFlag( 70 , false );
	
	--完全回復要求 --EN:-- full recovery request
	proxy:RequestFullRecover();
	proxy:WarpNextStage( 1, 0, 0, 0, 1006 );
	
	print("OnEvent_70_2 end");
end


--------------------------------------------------------------------------------------
--石柱にワープ(ボス倒した後用)■4105 --EN:-- Warp to the stone pillar (for after defeating the boss) 4105
--------------------------------------------------------------------------------------
--■4105■石柱にワープ■ --EN:-- ■ 4105 ■ Warp to the stone pillar ■
function OnEvent_4105(proxy,param)	

	if proxy:IsCompleteEvent( 4105 ) == true then
		return;
	end	

	print("OnEvent_4105 begin");
	
	proxy:RepeatMessage_begin();
		--▼4105_1▼選択メニューの監視▼ --EN:--▼4105_1▼Monitor selection menu▼
		proxy:OnSelectMenu(4105, "OnEvent_4105_0", 10010710, 0, 2, 1982, 2, once);			
	proxy:RepeatMessage_end();
	
	print("OnEvent_4105 end");
end

--▲4105_0▲選択メニューの監視▲ --EN:--▲4105_0▲Monitor selection menu▲
function OnEvent_4105_0(proxy, param)
	print("OnEvent_4105_0 begin");	
	
	if proxy:IsSession() == false then
		proxy:PlayAnimation( LOCAL_PLAYER , 8283 );--要石に触れるアニメを再生 --EN:--Play the animation that touches the keystone
		proxy:NoAnimeTurnCharactor( 10000 , 1982 ,TURNSKIP_ANGLE);
		
		
		proxy:NotNetMessage_begin();
			--▼要石に触れるアニメ再生終了▼ --EN:--▼Animation touching the keystone ends▼
			proxy:OnChrAnimEnd( 4105 , LOCAL_PLAYER , 8283 , "OnEvent_4105_1" , once );
		proxy:NotNetMessage_end();
		
		proxy:SetEventFlag( 4105 , 1 );
	else
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010720, 0, 6, 1983, GEN_DIALOG_DIST, once );
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
	end
	
	print("OnEvent_4105_0 end");
end

--▲4105_1▲自世界に帰るアニメ再生終了▲ --EN:--▲4105_1▲Return to own world animation ends▲
function OnEvent_4105_1(proxy,param)	
	print("OnEvent_4105_1 begin");
	
	proxy:PlayAnimation( 10000 , 8284 );--自世界に帰るアニメを再生 --EN:--Play animation to return to your own world
	--石柱へ戻ってきた判定のフラグを立てる --EN:--Flag the judgment of returning to the stone pillar
	proxy:SetEventFlag(8083, true);
	
	proxy:SetEventFlag( 4105 , 0 );	
	--完全回復要求 --EN:-- full recovery request
	proxy:RequestFullRecover();
	proxy:WarpNextStage( 1, 0, 0, 0, 1006 );
	
	print("OnEvent_4105_1 end");
end


--------------------------------------------------------------------------------------
--■350■ＰＣが近づくとカラスが飛び立つ■ --EN:-- ■ 350 ■ When the PC approaches, the crow flies away ■
--------------------------------------------------------------------------------------
function FryAwayKarasu(proxy,param, KarasuEventID, karasuID, KarasuAnimID)	
	print("FryAwayKarasu_"..karasuID.." begin");
	
	proxy:PlayAnimation( karasuID , KarasuAnimID );
	
	proxy:NotNetMessage_begin();
		--▼カラスアニメ再生終了▼ --EN:--▼End of crow animation▼
		proxy:OnObjAnimEnd( KarasuEventID , karasuID , KarasuAnimID , "OnEvent_"..KarasuEventID.."_1" , once );	
	proxy:NotNetMessage_end();

	proxy:SetEventFlag( KarasuEventID , true );

	print("FryAwayKarasu_"..karasuID.." end");
end

-----------------------------------------
--カラスアニメ再生終了したので消していく --EN:--Since the crow animation has finished playing, I will delete it.
-----------------------------------------
function OnEvent_350_1(proxy,param)	proxy:SetDrawEnable( 1090 , false ); print("KarasuFryAway ID=1090"); end
function OnEvent_351_1(proxy,param)	proxy:SetDrawEnable( 1091 , false ); print("KarasuFryAway ID=1091"); end
--function OnEvent_352_1(proxy,param)	proxy:SetDrawEnable( 1092 , false ); print("KarasuFryAway ID=1092"); end
function OnEvent_353_1(proxy,param)	proxy:SetDrawEnable( 1093 , false ); print("KarasuFryAway ID=1093"); end
function OnEvent_354_1(proxy,param)	proxy:SetDrawEnable( 1094 , false ); print("KarasuFryAway ID=1094"); end
function OnEvent_355_1(proxy,param)	proxy:SetDrawEnable( 1095 , false ); print("KarasuFryAway ID=1095"); end
function OnEvent_356_1(proxy,param)	proxy:SetDrawEnable( 1096 , false ); print("KarasuFryAway ID=1096"); end
function OnEvent_357_1(proxy,param)	proxy:SetDrawEnable( 1097 , false ); print("KarasuFryAway ID=1097"); end
function OnEvent_358_1(proxy,param)	proxy:SetDrawEnable( 1098 , false ); print("KarasuFryAway ID=1098"); end
function OnEvent_359_1(proxy,param)	proxy:SetDrawEnable( 1099 , false ); print("KarasuFryAway ID=1099"); end
function OnEvent_360_1(proxy,param)	proxy:SetDrawEnable( 1100 , false ); print("KarasuFryAway ID=1100"); end
function OnEvent_361_1(proxy,param)	proxy:SetDrawEnable( 1101 , false ); print("KarasuFryAway ID=1101"); end
function OnEvent_362_1(proxy,param)	proxy:SetDrawEnable( 1102 , false ); print("KarasuFryAway ID=1102"); end
function OnEvent_363_1(proxy,param)	proxy:SetDrawEnable( 1103 , false ); print("KarasuFryAway ID=1103"); end
function OnEvent_364_1(proxy,param)	proxy:SetDrawEnable( 1104 , false ); print("KarasuFryAway ID=1104"); end
function OnEvent_365_1(proxy,param)	proxy:SetDrawEnable( 1105 , false ); print("KarasuFryAway ID=1105"); end
function OnEvent_366_1(proxy,param)	proxy:SetDrawEnable( 1106 , false ); print("KarasuFryAway ID=1106"); end
function OnEvent_367_1(proxy,param)	proxy:SetDrawEnable( 1107 , false ); print("KarasuFryAway ID=1107"); end
function OnEvent_368_1(proxy,param)	proxy:SetDrawEnable( 1108 , false ); print("KarasuFryAway ID=1108"); end
function OnEvent_369_1(proxy,param)	proxy:SetDrawEnable( 1109 , false ); print("KarasuFryAway ID=1109"); end
function OnEvent_370_1(proxy,param)	proxy:SetDrawEnable( 1110 , false ); print("KarasuFryAway ID=1110"); end
function OnEvent_371_1(proxy,param)	proxy:SetDrawEnable( 1111 , false ); print("KarasuFryAway ID=1111"); end
function OnEvent_372_1(proxy,param)	proxy:SetDrawEnable( 1112 , false ); print("KarasuFryAway ID=1112"); end
function OnEvent_373_1(proxy,param)	proxy:SetDrawEnable( 1113 , false ); print("KarasuFryAway ID=1113"); end
function OnEvent_374_1(proxy,param)	proxy:SetDrawEnable( 1114 , false ); print("KarasuFryAway ID=1114"); end
function OnEvent_375_1(proxy,param)	proxy:SetDrawEnable( 1115 , false ); print("KarasuFryAway ID=1115"); end
	
---------------------------------
--カラスが飛び立つ関数を呼び出す --EN:--Call the function where the crow flies away
---------------------------------
function OnEvent_350(proxy, param) FryAwayKarasu(proxy, param, 350, 1090, 11); end
function OnEvent_351(proxy, param) FryAwayKarasu(proxy, param, 351, 1091, 10); end
--function OnEvent_352(proxy, param) FryAwayKarasu(proxy, param, 352, 1092, 12); end
function OnEvent_353(proxy, param) FryAwayKarasu(proxy, param, 353, 1093, 12); end
function OnEvent_354(proxy, param) FryAwayKarasu(proxy, param, 354, 1094, 12); end
function OnEvent_355(proxy, param) FryAwayKarasu(proxy, param, 355, 1095, 12); end
function OnEvent_356(proxy, param) FryAwayKarasu(proxy, param, 356, 1096, 12); end
function OnEvent_357(proxy, param) FryAwayKarasu(proxy, param, 357, 1097, 12); end
function OnEvent_358(proxy, param) FryAwayKarasu(proxy, param, 358, 1098, 12); end
function OnEvent_359(proxy, param) FryAwayKarasu(proxy, param, 359, 1099, 12); end
function OnEvent_360(proxy, param) FryAwayKarasu(proxy, param, 360, 1100, 12); end
function OnEvent_361(proxy, param) FryAwayKarasu(proxy, param, 361, 1101, 12); end
function OnEvent_362(proxy, param) FryAwayKarasu(proxy, param, 362, 1102, 12); end
function OnEvent_363(proxy, param) FryAwayKarasu(proxy, param, 363, 1103, 12); end
function OnEvent_364(proxy, param) FryAwayKarasu(proxy, param, 364, 1104, 12); end
function OnEvent_365(proxy, param) FryAwayKarasu(proxy, param, 365, 1105, 12); end
function OnEvent_366(proxy, param) FryAwayKarasu(proxy, param, 366, 1106, 12); end
function OnEvent_367(proxy, param) FryAwayKarasu(proxy, param, 367, 1107, 12); end
function OnEvent_368(proxy, param) FryAwayKarasu(proxy, param, 368, 1108, 12); end
function OnEvent_369(proxy, param) FryAwayKarasu(proxy, param, 369, 1109, 12); end
function OnEvent_370(proxy, param) FryAwayKarasu(proxy, param, 370, 1110, 12); end
function OnEvent_371(proxy, param) FryAwayKarasu(proxy, param, 371, 1111, 12); end
function OnEvent_372(proxy, param) FryAwayKarasu(proxy, param, 372, 1112, 12); end
function OnEvent_373(proxy, param) FryAwayKarasu(proxy, param, 373, 1113, 12); end
function OnEvent_374(proxy, param) FryAwayKarasu(proxy, param, 374, 1114, 12); end
function OnEvent_375(proxy, param) FryAwayKarasu(proxy, param, 375, 1115, 12); end

--[[
--------------------------------------------------------------------------------------
--薄板壁を壊して敵が飛び出してくる■90 --EN:--Break the thin wall and the enemy will pop out 90
--------------------------------------------------------------------------------------
--■90■薄板壁を壊して敵が飛び出してくる■ --EN:-- ■ 90 ■ Destroy the thin wall and the enemy will jump out ■
function OnEvent_90(proxy,param)	
	print("OnEvent_90 begin");
	
	proxy:SetDrawEnable( 202 , true );	
	proxy:SetColiEnable( 202 , true );

	proxy:PlayAnimation( 1120 , 1 );--扉アニメ再生 --EN:--Play door animation
	
	proxy:NotNetMessage_begin();
		--▼90_1▼攻撃アニメの再生時間を調整▼ --EN:--▼90_1▼Adjusted attack animation playback time▼
		proxy:OnKeyTime2( 90 , "OnEvent_90_1" , ( 72.0 / 30.0 ) , 0 , 3 , once );
	proxy:NotNetMessage_end();

	proxy:SetEventFlag( 90 , 1 );
	
	print("OnEvent_90 end");
end


--▲90_1▲攻撃アニメの再生時間を調整▲ --EN:--▲90_1▲Adjusted attack animation playback time▲
function OnEvent_90_1(proxy,param)	
	print("OnEvent_90_1 begin");	
	
	proxy:PlayAnimation( 202 , 7010 );--攻撃アニメ再生 --EN:--play attack animation

	proxy:SetEventFlag( 90 , 0 );
	
	proxy:NotNetMessage_begin();
		--▼90_2▼攻撃アニメ終了後▼ --EN:--▼90_2▼After the attack animation ends▼
		proxy:OnChrAnimEnd( 90 , 202, 7010, "OnEvent_90_2" , once );
	proxy:NotNetMessage_end();
	
	proxy:SetEventFlag( 90 , 1 );
	
	print("OnEvent_90_1 end");
end


--▲90_2▲攻撃アニメ終了後▲ --EN:--▲90_2▲After the attack animation finished▲
function OnEvent_90_2(proxy,param)	
	print("OnEvent_90_2 begin");	
	
	proxy:PlayLoopAnimation( 202 , 500 );--走りアニメ再生 --EN:--Run animation playback
	
	proxy:SetEventFlag( 90 , 0 );
	
	proxy:NotNetMessage_begin();
		--▼90_3▼走りアニメを数秒間再生後▼ --EN:--▼90_3▼After playing the running animation for a few seconds▼
		proxy:OnKeyTime2( 90 , "OnEvent_90_3" , 1.0 , 0, 1, once );
	proxy:NotNetMessage_end();
	
	proxy:SetEventFlag( 90 , 1 );
	
	print("OnEvent_90_2 end");
end

--▲90_3▲走りアニメ終了後▲ --EN:--▲90_3▲After running animation▲
function OnEvent_90_3(proxy,param)	
	print("OnEvent_90_3 begin");	
	
	proxy:StopLoopAnimation( 202 );
	proxy:EnableLogic( 202 , true );
	
	print("OnEvent_90_3 end");
end
]]

--------------------------------------------------------------------------------------
--薄板壁を壊して敵が飛び出してくる2■91 --EN:--Break the thin plate wall and the enemy will jump out 2■91
--------------------------------------------------------------------------------------
--■91■薄板壁を壊して敵が飛び出してくる2■ --EN:--■ 91 ■ Destroy the thin wall and the enemy will jump out 2 ■
function OnEvent_91(proxy,param)	
	print("OnEvent_91 begin");
	
	proxy:SetDrawEnable( 215 , true );
	proxy:SetDrawEnable( 216 , true );
	
	proxy:SetColiEnable( 216 , true );
	proxy:SetColiEnable( 215 , true );
	
	proxy:PlayAnimation( 1121 , 1 );--扉アニメ再生 --EN:--Play door animation
	proxy:PlayAnimation( 1122 , 1 );--扉アニメ再生 --EN:--Play door animation
	
	proxy:NotNetMessage_begin();
		--▼91_1▼攻撃アニメの再生時間を調整▼ --EN:--▼91_1▼Adjusted attack animation playback time▼
		proxy:OnKeyTime2( 91 , "OnEvent_91_1_215" , ( 72.0 / 30.0 ) , 0 , 3 , once );
		proxy:OnKeyTime2( 91 , "OnEvent_91_1_216" , ( 72.0 / 30.0 ) , 0 , 4 , once );
	proxy:NotNetMessage_end();

	print("OnEvent_91 end");
end

--▲91_1_215▲攻撃アニメの再生時間を調整▲ --EN:--▲91_1_215▲Adjusted attack animation playback time▲
function OnEvent_91_1_215(proxy,param)	
	print("OnEvent_91_1_215 begin");		
	proxy:PlayAnimation( 215 , 7010 );
	proxy:SetEventFlag( 91 , 0 );
	proxy:NotNetMessage_begin();
		--▼91_2▼攻撃アニメ終了後▼ --EN:--▼91_2▼After the attack animation ends▼
		proxy:OnChrAnimEnd( 91 , 215, 7010, "OnEvent_91_2_215" , once );
		--proxy:OnKeyTime2(91,"OnEvent_91_2_215",2.0,0,0,once);
	proxy:NotNetMessage_end();
	proxy:SetEventFlag( 91 , 1 );
	print("OnEvent_91_1_215 end");
end

--▲91_1_216▲攻撃アニメの再生時間を調整▲ --EN:--▲91_1_216▲Adjusted attack animation playback time▲
function OnEvent_91_1_216(proxy,param)	
	print("OnEvent_91_1_216 begin");		
	proxy:PlayAnimation( 216 , 7010 );	
	proxy:SetEventFlag( 91 , 0 );	
	proxy:NotNetMessage_begin();
		--▼91_2▼攻撃アニメ終了後▼ --EN:--▼91_2▼After the attack animation ends▼
		proxy:OnChrAnimEnd( 91 , 216, 7010, "OnEvent_91_2_216" , once );		
	proxy:NotNetMessage_end();	
	proxy:SetEventFlag( 91 , 1 );	
	print("OnEvent_91_1_216 end");
end

--▲91_2_215▲攻撃アニメ終了後▲ --EN:--▲91_2_215▲After the attack animation finished▲
function OnEvent_91_2_215(proxy,param)	
	print("OnEvent_91_2_215 begin");		
	proxy:PlayLoopAnimation( 215 , 500 );--走りアニメ再生	 --EN:--Run animation playback
	proxy:SetEventFlag( 91 , 0 );	
	proxy:NotNetMessage_begin();
		--▼91_3▼走りアニメを数秒間再生後▼ --EN:--▼91_3▼After playing the running animation for a few seconds▼
		proxy:OnKeyTime2( 91 , "OnEvent_91_3_215" , 1.0 , 0, 1, once );
	proxy:NotNetMessage_end();	
	proxy:SetEventFlag( 91 , 1 );	
	print("OnEvent_91_2_215 end");
end

--▲91_2_216▲攻撃アニメ終了後▲ --EN:--▲91_2_216▲After the attack animation finished▲
function OnEvent_91_2_216(proxy,param)	
	print("OnEvent_91_2_216 begin");			
	proxy:PlayLoopAnimation( 216 , 500 );	
	proxy:SetEventFlag( 91 , 0 );	
	proxy:NotNetMessage_begin();
		--▼91_3▼走りアニメを数秒間再生後▼ --EN:--▼91_3▼After playing the running animation for a few seconds▼
		proxy:OnKeyTime2( 91 , "OnEvent_91_3_216" , 1.0 , 0, 10, once );
	proxy:NotNetMessage_end();	
	proxy:SetEventFlag( 91 , 1 );	
	print("OnEvent_91_2_216 end");
end

--▲91_3_215▲走りアニメ終了後▲ --EN:--▲91_3_215▲After running animation▲
function OnEvent_91_3_215(proxy,param)	
	print("OnEvent_91_3_215 begin");	
	
	proxy:StopLoopAnimation( 215 );	
	proxy:SetSuperArmor( 215 , false );	
	proxy:EnableLogic( 215 , true );	
	
	print("OnEvent_91_3_215 end");
end

--▲91_3_216▲走りアニメ終了後▲ --EN:--▲91_3_216▲After running animation▲
function OnEvent_91_3_216(proxy,param)	
	print("OnEvent_91_3_216 begin");	
	
	proxy:StopLoopAnimation( 216 );	
	proxy:SetSuperArmor( 216 , false );	
	proxy:EnableLogic( 216 , true );	
	
	print("OnEvent_91_3_216 end");
end


--------------------------------------------------------------------------------------
--一般兵士が落ちてくる■180 --EN:-- General soldiers fall ■ 180
--------------------------------------------------------------------------------------
--■180_00■攻撃を受けたときのノックバック分歩かせ用(ID:211)■ --EN:--■180_00■For knockback when attacked (ID: 211)■
function OnEvent_180_00(proxy,param)
	print("OnEvent_180_00 begin");
	
	proxy:PlayAnimation( 211 , 500 ) --移動アニメ再生 --EN:--Play moving animation
	
	proxy:NotNetMessage_begin();
		--▼180▼移動アニメの再生終了→敵が落ちてくるへ▼ --EN:--▼180▼End of movement animation→Go to enemies falling▼
		proxy:OnChrAnimEnd( 180 , 211 , 500 , "OnEvent_180" , once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_180_00 end");
end


--■180_01■攻撃を受けたときのノックバック分歩かせ用(ID:206)■ --EN:--■180_01■For knocking back when attacked (ID: 206)■
function OnEvent_180_01(proxy,param)
	print("OnEvent_180_01 begin");
	
	proxy:PlayAnimation( 206 , 500 ) --移動アニメ再生 --EN:--Play moving animation
	
	proxy:NotNetMessage_begin();
		--▼180▼移動アニメの再生終了→敵が落ちてくるへ▼ --EN:--▼180▼End of movement animation→Go to enemies falling▼
		proxy:OnChrAnimEnd( 180 , 206 , 500 , "OnEvent_180" , once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_180_01 end");
end




--■180■一般兵士が落ちてくる■ --EN:-- ■ 180 ■ Common soldiers fall ■
function OnEvent_180(proxy,param)
	print("OnEvent_180 begin");

	--多重発動防止 --EN:--Multiple activation prevention
	if proxy:IsCompleteEvent( 180 ) == true then
		print("OnEvent_180 end");
		return;
	end
	
	proxy:NotNetMessage_begin();
		--▼一人目が落ちてくる▼ --EN:--▼The first one falls down▼
		proxy:OnKeyTime2( 180 , "OnEvent_180_211" , 0.0 , 0 , 1 , once );
		--▼二人目が落ちてくる▼ --EN:--▼The second person falls down▼
		proxy:OnKeyTime2( 180 , "OnEvent_180_206" , 1.0 , 0 , 2 , once );
	proxy:NotNetMessage_end();
	
	proxy:SetEventFlag( 180 , 1 );
	
	print("OnEvent_180 end");
end




--■180_211■一般兵士が落ちてくる(一人目)■ID211 --EN:-- ■ 180_211 ■ General soldier falls (first person) ■ ID 211
function OnEvent_180_211(proxy,param)
	print("OnEvent_180_211 begin");

	proxy:SetColiEnable( 211 , false );
	proxy:DisableMapHit( 211, true );
	proxy:SetDisableGravity( 211 , true );
	
	proxy:PlayAnimation( 211 , 7000 );

	proxy:SetEventFlag( 180 , 0 );
	proxy:NotNetMessage_begin();
		--▼180_1▼飛び降りアニメ再生終了▼ --EN:--▼180_1▼End of jumping animation▼
		proxy:OnKeyTime2( 180 , "OnEvent_180_211_1" , ( 23.0 / 30.0 ) , 0 , 3 , once );
	proxy:NotNetMessage_end();
	proxy:SetEventFlag( 180 , 1 );
	
	print("OnEvent_180_211 end");
end

--▲180_211_1▲飛び降りアニメ再生終了(一人目)▲ID211 --EN:--▲180_211_1▲End of jump animation playback (first person)▲ID211
function OnEvent_180_211_1(proxy,param)
	print("OnEvent_180_211_1 begin");
	
	proxy:DisableMapHit( 211, false );	
	proxy:SetDisableGravity( 211 , false );
	
	proxy:EnableLogic( 211 , true );
	proxy:SetColiEnable( 211 , true );	
	
	proxy:SetSuperArmor( 211 , false );
	
	proxy:DeleteEvent( 182 );--ダメージ監視消す --EN:--Turn off damage monitoring
	
	print("OnEvent_180_211_1 end");
end




--■180_206■一般兵士が落ちてくる(二人目)■ID206 --EN:-- ■ 180_206 ■ General soldier falls (second person) ■ ID206
function OnEvent_180_206(proxy,param)
	print("OnEvent_180_206 begin");

	proxy:SetColiEnable( 206 , false );
	proxy:DisableMapHit( 206, true );
	proxy:SetDisableGravity( 206 , true );
	
	proxy:PlayAnimation( 206 , 7000 );

	proxy:SetEventFlag( 180 , 0 );
	proxy:NotNetMessage_begin();
		--▼180_1▼飛び降りアニメ再生終了▼ --EN:--▼180_1▼End of jumping animation▼
		proxy:OnKeyTime2( 180 , "OnEvent_180_206_1" , ( 23.0 / 30.0 ) , 0 , 4 , once );
	proxy:NotNetMessage_end();
	proxy:SetEventFlag( 180 , 1 );
	
	--フラグを立てる(指示書に合わせるため) --EN:--Flag (to meet directives)
	proxy:SetEventFlag( 181 , 1 );
	
	print("OnEvent_180_206 end");
end

--▲180_206_1▲飛び降りアニメ再生終了(二人目)▲ID206 --EN:--▲180_206_1▲End of jump animation playback (second person)▲ID206
function OnEvent_180_206_1(proxy,param)
	print("OnEvent_180_206_1 begin");
	
	proxy:DisableMapHit( 206, false );	
	proxy:SetDisableGravity( 206 , false );
	
	proxy:EnableLogic( 206 , true );
	proxy:SetColiEnable( 206 , true );	
	proxy:SetSuperArmor( 206 , false );
	
	proxy:DeleteEvent( 183 );--ダメージ監視消す --EN:--Turn off damage monitoring
	proxy:DeleteEvent( 180 );--領域監視も消す --EN:-- Also turn off area monitoring
	
	print("OnEvent_180_206_1 end");
end


--------------------------------------------------------------------------------------
--徘徊デーモンの登場■?? --EN:-- Appearance of the Wandering Demon ??
--------------------------------------------------------------------------------------

--▼グローバルの死亡監視から呼ばれる(ソロ) --EN:--▼ Called from global death watch (solo)
function PlayerDeath_m02_00_00_00(proxy, param)
	print("PlayerDeath_m02_00_00_00");
	
--	LuaFunc_VisibleTheWanderingDemon(proxy, param, demon_id_list_m02_00_00_00);
--	proxy:SetEventFlag( 20 , 1 );--フラグは仮、指定があれば変える。 --EN:The -- flag is tentative, and will be changed if specified.
	
	print("PlayerDeath_m02_00_00_00");
end

--▼グローバルの血文字復活から呼ばれる(ソロ) --EN:--▼Called from global blood letter revival (solo)
function PlayerRevive_m02_00_00_00(proxy,param)
	print("PlayerRevive_m02_00_00_00");
	
--	LuaFunc_InvisibleTheWanderingDemon(proxy, param, demon_id_list_m02_00_00_00);
--	proxy:SetEventFlag( 20 , 0 );--フラグは仮、指定があれば変える。 --EN:The -- flag is tentative, and will be changed if specified.
	
	print("PlayerRevive_m02_00_00_00");
end






--------------------------------------------------------------------------------------
--ボス部屋の中に入る■110 --EN:--Enter the boss room 110
--------------------------------------------------------------------------------------

--■イベントがループなので、全部リピートにする↓ --EN:--■ Since the event is a loop, repeat all ↓

--■110■中ボス部屋への扉が開く■ --EN:-- ■ 110 ■ The door to the mid-boss room opens ■
function OnEvent_110(proxy,param)
	print("OnEvent_110 begin");
	
	if proxy:IsCompleteEvent( SYSTEM_ID_IGNORE ) == true then
		print("OnEvent_110 end");
		return;
	end
	--クライアントへ、ボス部屋阻止失敗を通知 --EN:--Notify client of failure to block boss room
	if proxy:IsClient() == false then
		proxy:LuaCallStart( 4068 , 1 );	
	end
	
	--自分自身がファランクスを準備 --EN:--prepare the phalanx yourself
	if param:IsNetMessage() == false then
		PhalanxStandBy(proxy,param);
	end
	
	proxy:LuaCallStart( 111, 1 );--旋回アニメの同期再生 --EN:-- Synchronous playback of turning animation
	--proxy:SetEventFlag( SYSTEM_ID_IGNORE, true );
	--多重起動システムIDをタイムアウトを設定してONにする --EN:--Turn on multiple activation system ID by setting timeout
	proxy:SetSystemIgnore( SYSTEM_ID_IGNORE , IGNORE_TIME );
	
	--プロファイルセーブ要求 --EN:--profile save request
	proxy:SaveRequest_Profile();
	
	print("OnEvent_110 end");
end


--旋回アニメの同期再生(IDが別) --EN:-- Synchronized playback of turning animation (ID is different)
function OnEvent_111_1(proxy,param)
	print("OnEvent_111_1 begin");

	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		if param:IsNetMessage() == true then
			--旋回アニメ再生を行い、その終了時にOnEvent_111_2を発行する --EN:--Play the turning animation and issue OnEvent_111_2 at the end
			proxy:TurnCharactor( 10001 + param:GetPlayID(), 2891 );
		else
			proxy:LockSession();--ルームをロックします！ --EN:--lock the room!
			--旋回アニメ再生を行い、その終了時にOnEvent_111_2を発行する --EN:--Play the turning animation and issue OnEvent_111_2 at the end
			proxy:OnTurnCharactorEnd( 111, LOCAL_PLAYER, 2891, "OnEvent_111_2", once );
		end
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	
	print("OnEvent_111_1 end");
end

--旋回アニメの同期再生終了後 --EN:--After synchronous playback of turning animation ends
function OnEvent_111_2(proxy,param)
	print("OnEvent_111_2 begin");

	--同期用歩きアニメ再生 --EN:--Play walking animation for synchronization
	proxy:LuaCallStart( 4012, 1 );
	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		proxy:OnChrAnimEnd( 111, LOCAL_PLAYER, ANIMEID_WALK, "OnEvent_111_3", once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	
	print("OnEvent_111_2 end");
end

--歩きアニメの同期再生終了後 --EN:--After the synchronized playback of the walking animation ends
function OnEvent_111_3(proxy,param)
	print("OnEvent_111_3 begin");

	--最初の人がボス部屋の中に入り終わっていたら、既に配信されているはずなので、もうおくらないハンドラ --EN:--If the first person has already entered the boss room, it should have already been delivered, so no more handlers
	if proxy:IsCompleteEvent( 110 ) == false then
		proxy:LuaCallStart( 111 , 5 );--2回目以降にボス部屋に入るためのイベント配信用 --EN:--For event delivery to enter the boss room after the second time
		proxy:LuaCallStart( 4045 , 1 );	--クライアントへ、ボス部屋に入れるようになったことを通知 --EN:--Notify clients that they can now enter the boss room
		proxy:LuaCallStart( 111 , 6 );--フラグセット(同期用) --EN:--flag set (for synchronization)
		local eneidlist = {800,
		860,861,862,863,864,865,866,867,868,869,
		870,871,872,873,874,875,876,877,878,879,
		880,881,882,883,884,885,886,887,888,889,
		890,891,892,893,894,895,896,897};
		
		local num = table.getn(eneidlist);
		for index = 1, num , 1 do
			Lua_MultiDoping(proxy,eneidlist[index]);--マルチプレイドーピング --EN:-- Multiplayer Doping
		end		
	end

	--プレイヤーが扉の中に完全にはいったタイミングで、ボスの思考をリセット --EN:--Reset the boss' thoughts when the player is completely inside the door
	--場所が悪いとプレイヤーを見つけれないため(攻撃してこない) --EN:--Because you can't find the player if the location is bad (they won't attack)
	if proxy:IsClient() == false then
		proxy:ResetThink( 800 );
	end	
	
	proxy:SetEventFlag( SYSTEM_ID_IGNORE, false );

	print("OnEvent_111_3 end");
end


--■110 2回目以降にボス部屋に入るためのイベント配信用 --EN:--■ 110 For event delivery to enter the boss room after the second time
function OnEvent_110_GO_TO_IN(proxy, param)
	print("OnEvent_110_GO_TO_IN begin");

	proxy:NotNetMessage_begin();
		--▼111▼扉が開いているときに中に入るためのイベントを追加▼--ハンドラは OnEvent_110 --EN:--▼111▼Add an event to enter when the door is open▼--The handler is OnEvent_110
		proxy:OnPlayerActionInRegion( 111, 2895, "OnEvent_110", HELPID_GO_TO_IN, everytime );--
	proxy:NotNetMessage_end();	

	print("OnEvent_110_GO_TO_IN end");
end


--■110 フラグセット(同期用) --EN:-- 110 Flag set (for synchronization)
function OnEvent_110_flag_set(proxy, param)
	print("OnEvent_110_flag_set begin");
		
	proxy:SetEventFlag( 110 , 1 );
	proxy:DeleteEvent( 110 ); 

	print("OnEvent_110_flag_set end");
end



--------------------------------------------------------------------------------------
--ボスが動き出す(戦闘開始)■114 --EN:--Boss begins to move (battle begins) 114
--------------------------------------------------------------------------------------

function OnEvent_114(proxy, param)
	print("OnEvent_114 begin");
	
	--ボス戦用BGM再生開始 --EN:--Start playing BGM for boss battle
	proxy:PlayPointSE( 2160, SOUND_TYPE_M, 20000000, 0 );
	
	--ファランクスの動作開始 --EN:-- Phalanx starts working
	PhalanxEventStart(proxy,param); 
	
	--読み込みタイミングのとき毎回追加されてほしいのでフラグたてない --EN:-- I want it to be added every time at the time of reading, so I don't set a flag
	
	--ボスゲージをセット --EN:--Set boss gauge
	proxy:SetBossGauge(800,0,5001);	
	
	--強制更新を配信 --EN:--Distribute force update
	proxy:LuaCallStart( 114 , 10 );
	print("OnEvent_114 end");
end

--ボス部屋に入ったPCの為に強制更新を配信 --EN:--Distribute a forced update for the PC that entered the boss room
function OnEvent_114_1(proxy,param)
	print("OnEvent_114_1 begin");
	if param:IsNetMessage() == true then
		--LuaFunc_ForceOmission(proxy,10001+param:GetPlayID());
		proxy:SetAlwaysDrawForEvent(10001+param:GetPlayID(),true);
	else
		--LuaFunc_ForceOmission(proxy,10000);
	end
	print("OnEvent_114_1 end");
end


--------------------------------------------------------------------------------------
--■200■処刑場への扉■ --EN:-- ■ 200 ■ Door to execution ground ■
--------------------------------------------------------------------------------------
--[[
--■200_1■処刑場への扉■LuaCall定義 --EN:-- ■ 200_1 ■ Door to execution ground ■ LuaCall definition
function OnEvent_200_1(proxy, param)
	print("OnEvent_200_1 begin");

	proxy:PlayAnimation( 1040, 1 );--扉が開くアニメーション --EN:-- Door opening animation
	
	--プレイヤーの同期アニメーション(true:パーティープレイヤーがアニメーションした) --EN:--Player synchronous animation (true: party player animated)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_OPEN ) == true then
		proxy:SetEventFlag( 200, 1 );
		proxy:DeleteEvent( 200 );--パーティープレイヤーの監視削除 --EN:--Remove Party Player Observation
		print("OnEvent_200_1 end");
		return;
	end

	proxy:WarpDmy( LOCAL_PLAYER , 1040 , 191 );
	proxy:SetEventFlag( 200, 1 );
	proxy:DeleteEvent( 200 );--自分の監視削除 --EN:--Delete own monitor

	print("OnEvent_200_1 end");
end


--■200■処刑場への扉■ --EN:-- ■ 200 ■ Door to execution ground ■
function OnEvent_200(proxy, param)
	print("OnEvent_200 begin");

	--多重発動防止 --EN:--Multiple activation prevention
	if proxy:IsCompleteEvent( 200 ) == true then
		print("OnEvent_200 end");
		return;
	end
	
	--QWC条件は満たしているか？ --EN:--Do you meet the QWC conditions?
	if	proxy:IsCompleteEvent( 201 ) == true then
		proxy:LuaCallStart( 200 , 1 );--アニメーションの同期再生(全体に配信)	 --EN:-- Synchronous animation playback (distributed to all)

	--必要アイテムを所持していない --EN:--I don't have the required items
	else
		--扉が開かない場合のメッセージを表示 --EN:-- Display a message when the door does not open
		--proxy:InfomationMenu( INFOMENU_TYPE_SIMPLE, 0, MSG_CATEGORY_EVENT, 10010160, 1);
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010160, 0, 6, 1040, GEN_DIALOG_DIST, once );
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
		--proxy:ShowGenDialog(10010160,1,1,true);
	end

	print("OnEvent_200 end");
end
]]


--------------------------------------------------------------------------------------
--■210■霊廟への扉■ --EN:--■210■The door to the mausoleum■
--------------------------------------------------------------------------------------

--■210_1■霊廟への扉■LuaCall定義 --EN:-- ■ 210_1 ■ Door to the mausoleum ■ LuaCall definition
function OnEvent_210_1(proxy, param)
	print("OnEvent_210_1 begin");

	proxy:PlayAnimation( 1045, 1 );--扉が開くアニメーション --EN:-- Door opening animation
	
	--プレイヤーの同期アニメーション(true:パーティープレイヤーがアニメーションした) --EN:--Player synchronous animation (true: party player animated)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_OPEN ) == true then
		proxy:SetEventFlag( 210 , 1 );
		proxy:DeleteEvent( 210 );
		print("OnEvent_210_1 end");
		return;
	end

	proxy:WarpDmy( LOCAL_PLAYER , 1045 , 191 );
	proxy:SetEventFlag( 210, 1 );

	print("OnEvent_210_1 end");
end


--■210■霊廟への扉■ --EN:--■210■The door to the mausoleum■
function OnEvent_210(proxy, param)
	print("OnEvent_210 begin");
	
	--多重発動防止 --EN:--Multiple activation prevention
	if proxy:IsCompleteEvent( 210 ) == true then
		print("OnEvent_210 end");
		return;
	end
	
	--必要アイテムの指定 --EN:--Specify required items
	local KEY_ITEM_TYPE = TYPE_GOODS;
	local KEY_ITEM_ID   = 35;--霊廟の鍵 --EN:--Mausoleum Key
	
	--必要アイテムを所持している(インベントリーにアイテムとして所持している) --EN:--You have the necessary items (have them as items in your inventory)
	if proxy:IsInventoryEquip( KEY_ITEM_TYPE , KEY_ITEM_ID ) == true then
	
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			--▼210_3▼選択メニューの監視▼ --EN:--▼210_3▼Monitor selection menu▼
			--proxy:OnSelectMenu(210, "OnEvent_210_3", 10010829, 0, 1, 1045, 2, once);
			proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010829, 0, 6, 1045, GEN_DIALOG_DIST, once );
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
		OnEvent_210_3(proxy,param);

	--必要アイテムを所持していない --EN:--I don't have the required items
	else
		--扉が開かない場合のメッセージを表示 --EN:-- Display a message when the door does not open
		--proxy:InfomationMenu( INFOMENU_TYPE_SIMPLE, 0, MSG_CATEGORY_EVENT, 10010160, 1);
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010160, 0, 6, 1045, GEN_DIALOG_DIST, once );
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
		--proxy:ShowGenDialog(10010160,1,1,true);
	end

	print("OnEvent_210 end");
end


--▲210_3▲選択メニューの監視▲(YESを選択したとき) --EN:--▲210_3▲Monitor selection menu▲(When YES is selected)
function OnEvent_210_3(proxy,param)
	print("OnEvent_210_3 begin");
	proxy:LuaCallStart( 210 , 1 );--アニメーションの同期再生(全体に配信)	 --EN:-- Synchronous animation playback (distributed to all)
	proxy:DeleteEvent( 210 );	
	print("OnEvent_210_3 end");
end
	

--------------------------------------------------------------------------------------
--■211■霊廟への扉■ --EN:--■211■The door to the mausoleum■
--------------------------------------------------------------------------------------

--■211_1■霊廟への扉■LuaCall定義 --EN:-- ■ 211_1 ■ Door to the mausoleum ■ LuaCall definition
function OnEvent_211_1(proxy, param)
	print("OnEvent_211_1 begin");

	proxy:PlayAnimation( 1047, 1 );--扉が開くアニメーション --EN:-- Door opening animation
	
	--プレイヤーの同期アニメーション(true:パーティープレイヤーがアニメーションした) --EN:--Player synchronous animation (true: party player animated)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_OPEN ) == true then
		proxy:SetEventFlag( 211, 1 );		
		proxy:DeleteEvent( 211 );
		print("OnEvent_211_1 end");
		return;
	end

	proxy:WarpDmy( LOCAL_PLAYER , 1047 , 191 );
	proxy:SetEventFlag( 211, 1 );

	print("OnEvent_211_1 end");
end


--■211■霊廟への扉2■ --EN:-- ■ 211 ■ Door to Mausoleum 2 ■
function OnEvent_211(proxy, param)
	print("OnEvent_211 begin");

	--多重発動防止 --EN:--Multiple activation prevention
	if proxy:IsCompleteEvent( 211 ) == true then
		print("OnEvent_211 end");
		return;
	end
	
	--必要アイテムの指定 --EN:--Specify required items
	local KEY_ITEM_TYPE = TYPE_GOODS;
	local KEY_ITEM_ID   = 35;--霊廟の鍵 --EN:--Mausoleum Key
	
	--必要アイテムを所持している(インベントリーにアイテムとして所持している) --EN:--You have the necessary items (have them as items in your inventory)
	if proxy:IsInventoryEquip( KEY_ITEM_TYPE , KEY_ITEM_ID ) == true then
	
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			--▼211_3▼選択メニューの監視▼ --EN:--▼211_3▼Monitor selection menu▼
			--proxy:OnSelectMenu(211, "OnEvent_211_3", 10010829, 0, 2, 1047, 2, once);
			proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010829, 0, 6, 1047, GEN_DIALOG_DIST, once );
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
		OnEvent_211_3(proxy,param);

	--必要アイテムを所持していない --EN:--I don't have the required items
	else
		--扉が開かない場合のメッセージを表示 --EN:-- Display a message when the door does not open
		--proxy:InfomationMenu( INFOMENU_TYPE_SIMPLE, 0, MSG_CATEGORY_EVENT, 10010160, 1);
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010160, 0, 6, 1047, GEN_DIALOG_DIST, once );
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
		--proxy:ShowGenDialog(10010160,1,1,true);
	end

	print("OnEvent_211 end");
end


--▲211_3▲選択メニューの監視▲(YESを選択したとき) --EN:--▲211_3▲Monitor selection menu▲(When YES is selected)
function OnEvent_211_3(proxy,param)
	print("OnEvent_211_3 begin");
	proxy:LuaCallStart( 211 , 1 );--アニメーションの同期再生(全体に配信)	 --EN:-- Synchronous animation playback (distributed to all)
	proxy:DeleteEvent( 211 );
	print("OnEvent_211_3 end");
end


--------------------------------------------------------------------------------------
--■5■霊廟の祭壇■ --EN:-- ■ 5 ■ Mausoleum Altar ■
--------------------------------------------------------------------------------------

function OnEvent_5(proxy, param)
	if param:IsNetMessage() == false then
	print("OnEvent_5 begin");
	proxy:NotNetMessage_begin();
	proxy:RepeatMessage_begin();
		proxy:PlayAnimation( 10000 , 8290);		
		proxy:PlayAnimation( 1192 , 1);	
		proxy:OnKeyTime2( 5 , "OnEvent_5_0",0.01,0,0,once);
	proxy:RepeatMessage_end();
	proxy:NotNetMessage_end();	
	print("OnEvent_5 end");
	end
end

function OnEvent_5_0(proxy,param)
	print("OnEvent_5_0 begin");
	--if proxy:IsPlayerStay(10000) == true then
	if proxy:IsEventAnim( 10000 , 8290 ) == true then
		proxy:LuaCallStart( 5 , 2 );
	else
		proxy:ForcePlayAnimation( 1192 , 0);	
	end
	print("OnEvent_5_0 end");
end

--■5_1■アイテム取得■ --EN:-- ■ 5_1 ■ item acquisition ■
function OnEvent_5_1(proxy, param)
	print("OnEvent_5_1 begin");

	--アイテム取得関数--パラメータ10104参照 --EN:--item retrieval function--see parameter 10104
	proxy:GetRateItem(10104);	
	
	--アイテムを取得済み --EN:--item already acquired
	proxy:SetEventFlag( 5, 1 );
	
	--OBJを消すためのイベント配信 --EN:--Event distribution for erasing OBJ
	proxy:LuaCallStart( 5, 1);
	
	print("OnEvent_5_1 end");
end

--■5_2■剣OBJ非表示用■ --EN:--■5_2■For hiding the sword OBJ■
function OnEvent_5_2(proxy,param)
	print("OnEvent_5_2 begin");
	--オブジェが消える --EN:--The object disappears
	proxy:SetDrawEnable( 1192 , false );--ひとまず描画だけOFF --EN:--Only drawing is turned off for the time being
	proxy:SetColiEnable( 1192 , false );--当たりはあるのは不明(現状ではないようなので消さない)	 --EN:--I don't know if there is a hit (I don't delete it because it doesn't seem to be the current situation)
	
	--イベント消える --EN:--event disappears
	proxy:DeleteEvent( 5 );
	print("OnEvent_5_2 end");
end

--アニメ再生の同期＆監視 --EN:--Animation playback synchronization & monitoring
function OnEvent_5_3(proxy,param)
	print("OnEvent_5_3 begin");
	
	proxy:TreasureDispModeChange2( 1192, false ,KEN_SFX);
	--プレイヤーの同期アニメーション(true:パーティープレイヤーがアニメーションした) --EN:--Player synchronous animation (true: party player animated)
	if Luafunc_PlaySynchroAnimation( proxy, param, 8290 ) == true then--新しいアニメ  --EN:-- new anime
		proxy:PlayAnimation( 1192 , 1);	
		print("OnEvent_5 end");
		return true;
	end
	
	--剣にワープ --EN:--Warp to sword
	proxy:WarpDmy( LOCAL_PLAYER , 1192 , 191 );		
	
	proxy:NotNetMessage_begin();
		proxy:OnChrAnimEnd( 5 , LOCAL_PLAYER , 8290 , "OnEvent_5_1", once);
	proxy:NotNetMessage_end();
	
	print("OnEvent_5_3 end");
end



--------------------------------------------------------------------------------------
--■220■飛竜(長)が寝ている■ --EN:-- ■ 220 ■ Wyvern (Long) is sleeping ■
--------------------------------------------------------------------------------------

TYOU_STATE_WAIT = 0;
TYOU_STATE_ATACK = 1;
TYOU_STATE_ATACK_DILAY = 2;

tyou_state_in_home = TYOU_STATE_WAIT;

function OnEvent_220(proxy, param)
--	print("OnEvent_220 begin");

	--待機状態(攻撃可能) --EN:-- Standby state (attack possible)
	if tyou_state_in_home == TYOU_STATE_WAIT then
			
		tyou_state_in_home = TYOU_STATE_ATACK;--攻撃状態へ --EN:-- to attack state
		
		proxy:StopLoopAnimation( 300 );--待機アニメとめる --EN:--stop animation
		proxy:PlayAnimation( 300 , 3001 );--攻撃アニメ再生開始 --EN:--Start playing attack animation
		proxy:SetEventFlag( 220 , 0 );
		proxy:NotNetMessage_begin();
			--▼220▼攻撃アニメの終了▼ --EN:--▼220▼End of attack animation▼
			proxy:OnChrAnimEnd( 220 , 300 , 3001 , "OnEvent_220_atack_end" , once );
		proxy:NotNetMessage_end();
		proxy:SetEventFlag( 220 , 1 );
	
	--攻撃中 --EN:--Attacking
	elseif tyou_state_in_home == TYOU_STATE_ATACK then
			
	--再攻撃待ち --EN:--Waiting for re-attack
	elseif tyou_state_in_home == TYOU_STATE_ATACK_DILAY then
	
	end
	
--	print("OnEvent_220 end");
end

--▲220▲攻撃アニメの終了▲ --EN:--▲220▲End of attack animation▲
function OnEvent_220_atack_end(proxy ,param)
	print("OnEvent_220_atack_end begin");
	
	--攻撃終わったので、再攻撃待ち状態へ --EN:--Since the attack is over, go to the state of waiting for another attack
	tyou_state_in_home = TYOU_STATE_ATACK_DILAY;
	
	proxy:SetEventFlag( 220 , 0 );
	proxy:NotNetMessage_begin();
		--▼220_dilay_end▼再攻撃待機▼ --EN:--▼220_delay_end▼Waiting for re-attack▼
		local dilay_time = 3.0;--3秒 --EN:--3 seconds
		proxy:OnKeyTime2( 220 , "OnEvent_220_atack_dilay_end" , dilay_time , 0 , 1 , once );
	proxy:NotNetMessage_end();
	proxy:SetEventFlag( 220 , 1 );
	
	proxy:PlayLoopAnimation( 300, 7000 );--待機アニメループ再生 --EN:--Standby animation loop playback
	
	print("OnEvent_220_atack_end end");
end


--▲220▲攻撃アニメの終了▲ --EN:--▲220▲End of attack animation▲
function OnEvent_220_atack_dilay_end(proxy ,param)
	print("OnEvent_220_atack_dilay_end begin");
	
	--攻撃まち状態おわったので、再攻撃可能→待機状態へ --EN:--The attack waiting state is over, so you can attack again → Go to standby state
	tyou_state_in_home = TYOU_STATE_WAIT;
		
	print("OnEvent_220_atack_dilay_end end");
end



--------------------------------------------------------------------------------------
--■221■飛竜(眷属)が警戒している■ --EN:--■ 221 ■ Wyvern (kin) is wary ■
--------------------------------------------------------------------------------------

KENZOKU_STATE_WAIT = 0;--待機状態 --EN:--wait state
KENZOKU_STATE_ATACK = 1;--攻撃状態(範囲内にいるとき) --EN:--attack state (when in range)
KENZOKU_STATE_ATACK_DILAY = 2;--攻撃のあとの待機は 攻撃待ち状態 --EN:--Standby after an attack is attack waiting state

kenzoku_state_in_home = KENZOKU_STATE_WAIT;--最初はとりあえず待機 --EN:--Wait for now
--これも同期するとしたら、フラグ3個つかって初期化時に再現? --EN:--If this is also synchronized, can it be reproduced at initialization using three flags?

--待機→攻撃になるときに、3秒だと、アニメの途中から再生になるので、1回分後 --EN:--When waiting → attacking, if it is 3 seconds, it will start playing from the middle of the animation, so after 1 time
--とかのほうが良いかもしれない? --EN:-- might be better?
kenzoku_play_anime_id = 0;
function OnEvent_199(proxy,param)
	print("OnEvent_199 begin");

	--巣にいる状態時に諦めに切り替え --EN:--Switch to give up when in the nest
	if	proxy:IsCompleteEvent( KENZOKU_STATE_WARNING ) == true and
		proxy:IsCompleteEvent( 0 ) == true then
		SetNpcStateFlag( proxy , param , kenzoku_flag_list , KENZOKU_STATE_WARNING_AND_LEVER );
	end
	
	--巣を警戒中　or　巣を警戒中(レバー阻止あきらめ)　の場合で撤退フラグON --EN:--Withdrawal flag ON when the nest is on guard or when the nest is on guard (give up to block the lever)
	if	   (proxy:IsCompleteEvent( KENZOKU_STATE_WARNING ) == true   or
			proxy:IsCompleteEvent( KENZOKU_STATE_WARNING_AND_LEVER ) == true ) and
			proxy:IsCompleteEvent( 234 ) == true then
		print("OnEvent_199 -> OnEvent_234_1");
		--→OnEvent_234_1 --EN:--→OnEvent_234_1
		proxy:LuaCallStart( 234, 2 );
	
	--■230■イベント条件 --EN:-- ■ 230 ■ Event conditions
	elseif	proxy:IsCompleteEvent( KENZOKU_STATE_WARNING ) == true and
			proxy:IsCompleteEvent( 222 ) == true then
		print("OnEvent_199 -> OnEvent_230_1");
		--→OnEvent_230_1 --EN:--→OnEvent_230_1
		proxy:LuaCallStart( 230, 1 );
	--■221■イベント条件 --EN:-- ■ 221 ■ Event conditions
	elseif	(proxy:IsCompleteEvent( KENZOKU_STATE_WARNING_AND_LEVER ) == true or
		 proxy:IsCompleteEvent( KENZOKU_STATE_WARNING ) == true ) and
		proxy:IsCompleteEvent( 222 ) == false and
		proxy:IsCompleteEvent( 223 ) == true then
		print("OnEvent_199 -> OnEvent_221_1");
		--→OnEvent_221_1 --EN:--→OnEvent_221_1
		proxy:LuaCallStart( 221, 1 );
		
	--■190■イベント条件 --EN:-- ■ 190 ■ Event conditions
	elseif (proxy:IsCompleteEvent( KENZOKU_STATE_WARNING_AND_LEVER ) == true or
			proxy:IsCompleteEvent( KENZOKU_STATE_WARNING ) == true ) and
			proxy:IsCompleteEvent( 222 ) == false and
			proxy:IsCompleteEvent( 223 ) == false and
			proxy:IsCompleteEvent( 224 ) == true then
		print("OnEvent_199 -> OnEvent_190_1");
		--→OnEvent_190_1 --EN:--→OnEvent_190_1
		proxy:LuaCallStart( 190, 1 );
		
	--■191■イベント条件 --EN:-- ■ 191 ■ Event conditions
	elseif (proxy:IsCompleteEvent( KENZOKU_STATE_WARNING_AND_LEVER ) == true or
			proxy:IsCompleteEvent( KENZOKU_STATE_WARNING ) == true ) and
			proxy:IsCompleteEvent( 222 ) == false and
			proxy:IsCompleteEvent( 223 ) == false and
			proxy:IsCompleteEvent( 224 ) == false and
			proxy:IsCompleteEvent( 225 ) == true then
		print("OnEvent_199 -> OnEvent_191_1");
		--→OnEvent_191_1 --EN:--→OnEvent_191_1
		proxy:LuaCallStart( 191, 1 );
		
		
	--巣から城壁へ飛んでくる流れ --EN:--The flow that flies from the nest to the walls
	--■231■イベント条件 --EN:-- ■ 231 ■ Event conditions
	elseif	proxy:IsCompleteEvent( KENZOKU_STATE_PROTECT_CASTLE ) == true and
			proxy:IsCompleteEvent( 222 ) == true and
			proxy:IsCompleteEvent( 0 )   == false and
			proxy:IsCompleteEvent( 234 ) == false then
		if	kenzoku_play_anime_id == 7001 or
			kenzoku_play_anime_id == 7002 or
			kenzoku_play_anime_id == 7005 then
			print("OnEvent_199 -> OnEvent_231_1");
			--→OnEvent_231_1 --EN:--→OnEvent_231_1
			proxy:LuaCallStart( 231, 1 );
		elseif	kenzoku_play_anime_id == 7004 then
			print("OnEvent_199 -> OnEvent_231_2");
			--→OnEvent_231_2 --EN:--→OnEvent_231_2
			proxy:LuaCallStart( 231, 2 );
		else
			print("OnEvent_199 -> 231 Failed");
			print("animId = ", kenzoku_play_anime_id);
		end
		
	--ブレスループから撤退への流れ --EN:--Flow from breath loop to withdrawal
	--■232■イベント条件 --EN:-- ■ 232 ■ Event conditions
	--■233■イベント条件 --EN:-- ■ 233 ■ Event conditions
	--領域に誰もいない or レバーが引かれた or 自分が死にそう --EN:--There is no one in the area or the lever is pulled or you are about to die
	elseif	(proxy:IsCompleteEvent( KENZOKU_STATE_PROTECT_CASTLE ) == true and
			 proxy:IsCompleteEvent( 222 ) == false ) or
			(proxy:IsCompleteEvent( KENZOKU_STATE_PROTECT_CASTLE ) == true and
			proxy:IsCompleteEvent( 0 ) == true ) or
			(proxy:IsCompleteEvent( KENZOKU_STATE_PROTECT_CASTLE ) == true and
			proxy:IsCompleteEvent( 234 ) == true ) then
			
		--通常の巣に戻るか --EN:--return to normal nest
		if	proxy:IsCompleteEvent( 0 ) == true then
			SetNpcStateFlag( proxy , param , kenzoku_flag_list , KENZOKU_STATE_WARNING_AND_LEVER );
		else
			SetNpcStateFlag( proxy , param , kenzoku_flag_list , KENZOKU_STATE_WARNING );
		end
		
		if	kenzoku_play_anime_id == 7002 or
			kenzoku_play_anime_id == 7004 or
			kenzoku_play_anime_id == 7005 then
			print("OnEvent_199 -> OnEvent_232_1");
			--→OnEvent_232_1 --EN:--→OnEvent_232_1
			proxy:LuaCallStart( 232, 1 );
		elseif	kenzoku_play_anime_id == 7003 then
			print("OnEvent_199 -> OnEvent_232_2");
			--→OnEvent_232_2 --EN:--→OnEvent_232_2
			proxy:LuaCallStart( 232, 2 );
		else
			print("OnEvent_199 -> 232 Failed");
			print("animId = ", kenzoku_play_anime_id);
		end
		
	--■199■デフォルト待機アニメループ --EN:-- ■ 199 ■ Default standby animation loop
	else
			print("OnEvent_199 -> OnEvent_199_default");
		--→OnEvent_199_default --EN:--→OnEvent_199_default
		proxy:LuaCallStart( 199, 1 );
	end
	print("OnEvent_199 end");
end


--飛竜アニメ終了の節に必ず通るイベント --EN:-- An event that must pass at the end of the flying dragon animation
function OnEvent_199_anim_end(proxy,param)
	print("OnEvent_199_anim_end begin");
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 199, "OnEvent_199", 0.0, 0, 2, once );
	proxy:NotNetMessage_end();
	print("OnEvent_199_anim_end end");
end


function OnEvent_199_default(proxy,param)
	print("OnEvent_199_default begin");
	
	kenzoku_play_anime_id = 0;
	proxy:ForcePlayAnimation( 301, 0 );
	
	if	param:IsNetMessage() == true then
		print("OnEvent_199_default return end");
		return;
	end
	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		proxy:OnChrAnimEnd( 199, 301, 0, "OnEvent_199_anim_end", once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	
	print("OnEvent_199_default end");
end


--------------------------------------------------------------------------------------
--■221■飛竜(眷属)が暴れる１→待ち１～３秒■ --EN:-- ■ 221 ■ Wyvern (kin) rampages 1 → Wait 1-3 seconds ■
--------------------------------------------------------------------------------------
function OnEvent_221_1(proxy, param)
	print("OnEvent_221_1 begin");

	kenzoku_play_anime_id = 3001;
	proxy:ForcePlayAnimationStayCancel( 301, 3001 );
	
	if	param:IsNetMessage() == true then
		print("OnEvent_221_1 return end");
		return;
	end
	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		--▼221▼攻撃アニメの終了▼ --EN:--▼221▼End of attack animation▼
		proxy:OnChrAnimEnd( 221 , 301 , 3001 , "OnEvent_221_1_1" , once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	print("OnEvent_221_1 end");
end

function OnEvent_221_1_1(proxy,param)
	--→OnEvent_221_2 --EN:--→OnEvent_221_2
	proxy:LuaCallStart( 221, 2 );
end


--▲221▲攻撃アニメの終了▲ --EN:--▲221▲End of attack animation▲
function OnEvent_221_2(proxy ,param)
	print("OnEvent_221_2 begin");
	
	kenzoku_play_anime_id = 0;
	proxy:ForcePlayLoopAnimation( 301, 0 );--待機アニメループ再生 --EN:--Standby animation loop playback
	
	if	param:IsNetMessage() == true then
		print("OnEvent_221_2 return end");
		return;
	end
	
	proxy:NotNetMessage_begin();
		--▼221_dilay_end▼再攻撃待機▼ --EN:--▼221_delay_end▼Waiting for re-attack▼
		local dilay_time = proxy:GetRandom( 10, 30 ) / 10;--1秒～3秒 --EN:--1s~3s
		proxy:OnKeyTime2( 221 , "OnEvent_199_anim_end" , dilay_time , 0 , 1 , once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_221_2 end");
end

--------------------------------------------------------------------------------------
--■190■飛竜(眷属)が暴れる２→待ち１～３秒■ --EN:-- ■ 190 ■ Wyvern (kin) rampages 2 → Wait 1-3 seconds ■
--------------------------------------------------------------------------------------
function OnEvent_190_1(proxy,param)
	print("OnEvent_190_1 begin");
	kenzoku_play_anime_id = 3003;
	proxy:ForcePlayAnimation( 301, 3003 );
	
	if	param:IsNetMessage() == true then
		print("OnEvent_190_1 return end");
		return;
	end
	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		--▼221▼攻撃アニメの終了▼ --EN:--▼221▼End of attack animation▼
		proxy:OnChrAnimEnd( 221 , 301 , 3003 , "OnEvent_190_1_1" , once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	print("OnEvent_190_1 end");
end

function OnEvent_190_1_1(proxy,param)
	print("OnEvent_190_1_1 begin");
	--→OnEvent_190_2 --EN:--→OnEvent_190_2
	proxy:LuaCallStart( 190, 2 );
	print("OnEvent_190_1_1 end");
end


function OnEvent_190_2(proxy,param)
	print("OnEvent_190_2 begin");
	
	kenzoku_play_anime_id = 0;
	proxy:ForcePlayLoopAnimation( 301, 0 );--待機アニメループ再生 --EN:--Standby animation loop playback
	
	if	param:IsNetMessage() == true then
		print("OnEvent_190_2 return end");
		return;
	end
	
	proxy:NotNetMessage_begin();
		local dilay_time = proxy:GetRandom( 10, 30 ) / 10;--1秒～3秒 --EN:--1s~3s
		proxy:OnKeyTime2( 190 , "OnEvent_199_anim_end" , dilay_time , 0 , 1 , once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_190_2 end")
end



--------------------------------------------------------------------------------------
--■191■飛竜(眷属)が暴れる３→待ち１～３秒■ --EN:-- ■ 191 ■ Wyvern (kin) rampages 3 → Wait 1-3 seconds ■
--------------------------------------------------------------------------------------
function OnEvent_191_1(proxy,param)
	print("OnEvent_191_1 begin");
	kenzoku_play_anime_id = 3002;
	proxy:ForcePlayAnimation( 301, 3002 );
	
	if	param:IsNetMessage() == true then
		print("OnEvent_191_1 return end");
		return;
	end
	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		--▼221▼攻撃アニメの終了▼ --EN:--▼221▼End of attack animation▼
		proxy:OnChrAnimEnd( 221 , 301 , 3002 , "OnEvent_191_1_1" , once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	print("OnEvent_191_1 end");
end

function OnEvent_191_1_1(proxy,param)
	print("OnEvent_191_1_1 begin");
	--→OnEvent_191_2 --EN:--→OnEvent_191_2
	proxy:LuaCallStart( 191, 2 );
	print("OnEvent_191_1_1 end");
end

function OnEvent_191_2(proxy,param)
	print("OnEvent_191_2 begin");
	
	kenzoku_play_anime_id = 0;
	proxy:ForcePlayLoopAnimation( 301, 0 );--待機アニメループ再生 --EN:--Standby animation loop playback
	
	if	param:IsNetMessage() == true then
		print("OnEvent_191_2 return end");
		return;
	end
	
	proxy:NotNetMessage_begin();
		local dilay_time = proxy:GetRandom( 10, 30 ) / 10;--1秒～3秒 --EN:--1s~3s
		proxy:OnKeyTime2( 191 , "OnEvent_199_anim_end" , dilay_time , 0 , 1 , once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_191_2 end")
end


--------------------------------------------------------------------------------------
--■230■飛竜(眷属)が飛んでくる→ブレス吐く■ --EN:--■ 230 ■ Wyvern (Family) comes flying → Breath ■
--------------------------------------------------------------------------------------

function OnEvent_230_1(proxy, param)
	print("OnEvent_230_1 begin");

	--位置・角度を合わせるためにワープ --EN:--Warp to match position/angle
	proxy:Warp(301,2030);

	--飛竜(眷属)が飛立つアニメ --EN:--An animation in which a flying dragon (kin) flies away
	kenzoku_play_anime_id = 7000;
	proxy:ForcePlayAnimationStayCancel( 301 , 7000 );
	
	--飛竜(眷属)の状態を城壁護るにセット --EN:-- Set Hiryu (Family) state to Protect Wall
	SetNpcStateFlag( proxy , param , kenzoku_flag_list , KENZOKU_STATE_PROTECT_CASTLE );
	
	if	param:IsNetMessage() == true then
		print("OnEvent_230_1 return end");
		return;
	end
	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		--▼230_1▼飛竜(眷属)が飛立つアニメ再生終了▼ --EN:--▼230_1▼Finished playing the animation of flying dragons (kin)▼
		proxy:OnChrAnimEnd( 230 , 301, 7000, "OnEvent_230_1_1" , once);
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	
	print("OnEvent_230_1 end");
end

function OnEvent_230_1_1(proxy,param)
	print("OnEvent_230_1_1 begin");
	--→OnEvent_230_2 --EN:--→OnEvent_230_2
	proxy:LuaCallStart( 230, 2 );
	print("OnEvent_230_1_1 end");
end


--▲230_2▲飛竜(眷属)が飛立つアニメ再生終了▲ --EN:--▲230_2▲End of the animation where the wyvern (kin) takes flight▲
function OnEvent_230_2(proxy , param )
	print("OnEvent_230_2 begin");
	
	--位置・角度を合わせるためにワープ --EN:--Warp to match position/angle
	proxy:Warp(301,2031);
	
    --飛竜(眷属)が飛んでくるアニメ --EN:--An animation in which flying dragons (kin) fly
	kenzoku_play_anime_id = 7002;
	proxy:ForcePlayAnimationStayCancel( 301 , 7002 );

	if	param:IsNetMessage() == true then
		print("OnEvent_230_2 return end");
		return;
	end
	
	proxy:NotNetMessage_begin();
		--▼231▼飛竜(眷属)が飛んでくるアニメ再生終了▼ --EN:--▼231▼The animation of flying dragons (kin) ends▼
		proxy:OnChrAnimEnd( 230 , 301 , 7002 , "OnEvent_199_anim_end" , once );
	proxy:NotNetMessage_end();
	

	print("OnEvent_230_2 end");
end


--------------------------------------------------------------------------------------
--■231■飛竜(眷属)がブレス吐く1→ブレス吐く2ループ■ --EN:--■ 231 ■ Wyvern (kin) breathes out 1 → breathes out 2 loops ■
--------------------------------------------------------------------------------------
--▲231▲飛竜(眷属)が飛んでくるアニメ再生終了▲ --EN:--▲231▲Finished playing the animation of the flying dragon (kin)▲
function OnEvent_231_1(proxy , param )
	print("OnEvent_231_1 begin");
	
	--位置・角度を合わせるためにワープ --EN:--Warp to match position/angle
	proxy:Warp(301,2032);

	--飛びながらブレス攻撃アニメ1 --EN:--Breath attack animation while flying 1
	kenzoku_play_anime_id = 7004;
	proxy:ForcePlayAnimationStayCancel( 301 , 7004 );
	
	if	param:IsNetMessage() == true then
		print("OnEvent_231_1 return end");
		return;
	end
	
	proxy:NotNetMessage_begin();
		--▼231_1▼飛びながらブレス攻撃アニメ1終了▼ --EN:--▼231_1▼Flying breath attack animation 1 ends▼
		proxy:OnChrAnimEnd( 231 , 301 , 7004 , "OnEvent_231_1_1" , once );
	proxy:NotNetMessage_end();


	print("OnEvent_231_1 end");
end


function OnEvent_231_1_1(proxy,param)
	print("OnEvent_231_1_1 begin");
	--→OnEvent_231_2 --EN:--→OnEvent_231_2
	proxy:LuaCallStart( 231, 2 );
	print("OnEvent_231_1_1 end");
end


--▲231_1▲飛びながらブレス攻撃アニメ1終了▲ --EN:--▲231_1▲Flying breath attack animation 1 ends▲
function OnEvent_231_2(proxy , param )
	print("OnEvent_231_2 begin");

	--位置・角度を合わせるためにワープ --EN:--Warp to match position/angle
	proxy:Warp(301,2032);
	
	--飛びながらブレス攻撃アニメ2 --EN:--Breath attack animation 2 while flying
	kenzoku_play_anime_id = 7005;
	proxy:ForcePlayAnimationStayCancel( 301 , 7005 );

	
	if	param:IsNetMessage() == true then
		print("OnEvent_231_2 return end");
		return;
	end
	
	proxy:NotNetMessage_begin();
		--▼231_2▼飛びながらブレス攻撃アニメ2終了▼ --EN:--▼231_2▼Flying breath attack animation 2 ends▼
		proxy:OnChrAnimEnd( 231 , 301 , 7005 , "OnEvent_199_anim_end" , once );
	proxy:NotNetMessage_end();

	print("OnEvent_231_2 end");
end



--------------------------------------------------------------------------------------
--■232■飛竜(眷属)が帰っていく■ --EN:-- ■ 232 ■ Wyvern (Family) is returning ■
--------------------------------------------------------------------------------------

function OnEvent_232_1(proxy, param)
	print("OnEvent_232_1 begin");

	--位置・角度を合わせるためにワープ --EN:--Warp to match position/angle
	proxy:Warp(301,2034);
	
	--飛びながらブレス攻撃アニメ2 --EN:--Breath attack animation 2 while flying
	kenzoku_play_anime_id = 7003;
	proxy:ForcePlayAnimationStayCancel( 301 , 7003 );

	if	param:IsNetMessage() == true then
		print("OnEvent_232_1 return end");
		return;
	end
	
	proxy:NotNetMessage_begin();
		--▼232_1▼飛竜(眷属)が去っていくアニメ終了▼ --EN:--▼232_1▼End of the animation where Hiryu (kin) leaves▼
		proxy:OnChrAnimEnd( 232 , 301 , 7003 , "OnEvent_232_1_1" , once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_232_1 end");
end

function OnEvent_232_1_1(proxy,param)
	print("OnEvent_232_1_1 begin");
	--→OnEvent_232_2 --EN:--→OnEvent_232_2
	proxy:LuaCallStart( 232, 2 );
	print("OnEvent_232_1_1 end");
end

--▲232_1▲飛竜(眷属)が去っていくアニメ終了▲ --EN:--▲232_1▲The end of the animation where the flying dragon (kin) leaves▲
function OnEvent_232_2(proxy, param)
	print("OnEvent_232_2 begin");

	--位置・角度を合わせるためにワープ --EN:--Warp to match position/angle
	proxy:Warp(301,2035);
	
	--飛びながらブレス攻撃アニメ2 --EN:--Breath attack animation 2 while flying
	kenzoku_play_anime_id = 7001;
	proxy:ForcePlayAnimation( 301 , 7001 );

	if	param:IsNetMessage() == true then
		print("OnEvent_232_2 return end");
		return;
	end
	
	proxy:NotNetMessage_begin();
		--▼232_2▼飛竜(眷属)が寝床に戻るアニメ終了▼ --EN:--▼232_2▼Hiryu returns to bed animation ends▼
		proxy:OnChrAnimEnd( 232 , 301 , 7001 , "OnEvent_232_3" , once );
		--proxy:OnChrAnimEnd( 232 , 301 , 7001 , "OnEvent_199_anim_end" , once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_232_2 end");
end

function OnEvent_232_3(proxy,param)
	print("OnEvent_232_3 begin");
	
	--位置・角度を合わせるためにワープ --EN:--Warp to match position/angle
	proxy:Warp( 301,2036);
	OnEvent_199_anim_end(proxy,param);
	
	print("OnEvent_232_3 end");
end

--------------------------------------------------------------------------------------
--■234■飛竜(眷属)の死亡監視■ --EN:-- ■ 234 ■ Wyvern (kin) death watch ■
--------------------------------------------------------------------------------------

function OnEvent_234(proxy , param)
	print( "OnEvent_234 begin" );
	
	--撤退したフラグを立てる --EN:--Flag withdrawn
	proxy:SetEventFlag( 234, true );
	
--[[	
	--飛竜(眷属)の状態を死亡にする --EN:--Change the status of the wyvern (kin) to death
	--SetNpcStateFlag( proxy , param , kenzoku_flag_list , KENZOKU_STATE_DEAD );
	
	--飛竜(眷属)関連イベント削除 --EN:--Deletion of Wyvern (Family) related events
	proxy:DeleteEvent( 221 );--巣で警戒している --EN:--Watching in the Nest
	proxy:DeleteEvent( 230 );--城壁に飛んでくる --EN:--flying to the ramparts
	
	proxy:OnKeyTime2( 234, "OnEvent_234_1", 0.0, 0, 2, once );

	--ホストのみアイテム入手 --EN:--Only the host can obtain items
	if	proxy:IsClient() == false then
		proxy:GetRateItem( 10118 );--アイテム入手 --EN:-- Get items
	end
]]	
	print( "OnEvent_234 end" );
end

--LuaCallParam(234,2)
function OnEvent_234_1(proxy,param)
	print("OnEvent_234_1 begin");
	
	--位置・角度を合わせるためにワープ --EN:--Warp to match position/angle
	proxy:Warp(301,2030);
	
	--飛びながらブレス攻撃アニメ2 --EN:--Breath attack animation 2 while flying
	kenzoku_play_anime_id = 7011;
	proxy:ForcePlayAnimation( 301 , 7011 );

	--ここは全員登録する --EN:--Register all here
	proxy:NotNetMessage_begin();
		--▼232_1▼飛竜(眷属)が去っていくアニメ終了▼ --EN:--▼232_1▼End of the animation where Hiryu (kin) leaves▼
		proxy:OnChrAnimEnd( 199 , 301 , 7011 , "OnEvent_234_1_1" , once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_234_1 end");
end

--撤退アニメ終了で無効化 --EN:--Disabled at the end of withdrawal animation
function OnEvent_234_1_1(proxy,param)
	print("OnEvent_234_1_1 begin");
	SetNpcStateFlag(proxy, param, kenzoku_flag_list, KENZOKU_STATE_ESCAPE );
	InvalidCharactor( proxy, 301 );
	print("OnEvent_234_1_1 end");
end



--[[
function OnEvent_234_1(proxy,param)
	print("OnEvent_234_1 begin");
	
	--proxy:OnRegistFunc(234, "Condition_234_anim_wait", "OnEvent_234_2", 2, once);
	--キャラなので、ここでのアニメIDに意味は無く、ただ尺を取る為に使用 --EN:--Since it's a character, the anime ID here has no meaning, it's just used to get the length
	if	proxy:IsEventAnim( 301, 10 ) == true then
		proxy:OnChrAnimEnd( 234, 301, 10, "OnEvent_234_2", once );
	else
		OnEvent_234_2(proxy,param);
	end
	
	print("OnEvent_234_1 end");
end


function Condition_234_anim_wait(proxy,param)
	if	proxy:IsEventAnim(301, 7011) == false then
		return false;
	end
	return true;
end


function OnEvent_234_2(proxy,param)
	print("OnEvent_234_2 begin");
	proxy:ForcePlayAnimation( 301, 7011 );
	proxy:Warp(301, 2030);
	
	proxy:OnChrAnimEnd( 234, 301, 7011, "OnEvent_234_3", once );
	proxy:SetEventFlag( 234 , 1 );
	print("OnEvent_234_2 end");
end

--飛竜の眷属　撤退アニメ終了後、無効化 --EN:-- Hiryu's relatives Disabled after the withdrawal animation ends
function OnEvent_234_3(proxy,param)
	print("OnEvent_234_3 begin");
	InvalidCharactor(proxy, 301);
	print("OnEvent_234_3 end");
end
]]
--------------------------------------------------------------------------------------
--■235■飛竜(長)の死亡監視■ --EN:-- ■ 235 ■ Wyvern (Lord) death watch ■
--------------------------------------------------------------------------------------

function OnEvent_235(proxy , param)
	print( "OnEvent_235 begin" );

	--飛竜の長は撤退するだけで、死んだわけではない --EN:--The chief of the wyvern just withdrew, he didn't die
	--SetNpcStateFlag( proxy , param , tyo_flag_list , TYO_STATE_DEAD );
	
	--飛竜(長)関連イベント削除 --EN:--Deletion of Wyvern (Long) related events
	proxy:DeleteEvent( 220 );--巣で寝ている --EN:--sleeping in a nest
	
	proxy:OnKeyTime2( 235, "OnEvent_235_1", 0.0, 0, 2, once );

	print( "OnEvent_235 end" );
end

function OnEvent_235_1(proxy,param)
	print( "OnEvent_235_1 begin" );
	
	--proxy:OnRegistFunc(235, "Condition_235_anim_wait", "OnEvent_235_2", 2, once);
	--キャラなので、ここでのアニメIDに意味は無く、ただ尺を取る為に使用 --EN:--Since it's a character, the anime ID here has no meaning, it's just used to get the length
	if	proxy:IsEventAnim( 300, 10 ) == true then
		proxy:OnChrAnimEnd( 235, 300, 10, "OnEvent_235_2", once );
	else
		OnEvent_235_2(proxy,param);
	end
	
	print( "OnEvent_235_1 end" );
end

function Condition_235_anim_wait(proxy,param)
	if	proxy:IsEventAnim(300, 7018) == false then
		return false;
	end
	return true;
end


function OnEvent_235_2(proxy,param)
	print("OnEvent_235_2 begin");
	proxy:ForcePlayAnimation( 300, 7018 );
	proxy:NotNetMessage_begin();
		--飛竜の長、撤退アニメ(7018)再生 --EN:--The leader of the flying dragon, retreat animation (7018) playback
		proxy:OnChrAnimEnd(235, 300, 7018, "OnEvent_235_3", once);
	proxy:NotNetMessage_end();
	
	print("OnEvent_235_2 end");
end

--撤退アニメ終了後 --EN:--After the withdrawal animation ends
function OnEvent_235_3(proxy,param)
	print("OnEvent_235_3 begin");
	SetNpcStateFlag(proxy, param, tyo1_flag_list, TYO_STATE_ESCAPE );
	InvalidCharactor(proxy, 300 );	
	print("OnEvent_235_3 end");
end



--------------------------------------------------------------------------------------
--■240■ホストPCのみが通れる光の霧■ --EN:--■240■Light fog that only the host PC can pass■
--------------------------------------------------------------------------------------

--■240_delete_wall■魔法壁削除同期用■ --EN:--■240_delete_wall■For synchronization of magic wall deletion■
function OnEvent_240_delete_wall(proxy , param)
	print("OnEvent_240_delete_wall begin");
	
	proxy:SetDrawEnable( 1055 , false );--魔法壁描画OFF --EN:--Magic Wall Drawing OFF
	proxy:SetColiEnable( 1055 , false );--魔法壁当たりOFF --EN:--Magic wall hit OFF
	proxy:SetObjDeactivate( 1055 , true );--デアクティブ --EN:--deactivate
	proxy:InvalidSfx( 2075 , true );--SFX OFF
	proxy:DeleteEvent( 240 );--全プレイヤー分の監視消えるはず。 --EN:--Surveillance for all players should disappear.
	
	print("OnEvent_240_delete_wall end");
end


--■240■イベント発動用■ --EN:-- ■ 240 ■ For event activation ■
function OnEvent_240(proxy , param)
	print("OnEvent_240 begin");

	--多重発動防止 --EN:--Multiple activation prevention
	if proxy:IsCompleteEvent( 240 ) == true then
		print("OnEvent_240 end");
		return;
	end
	
	--プレイヤーの同期アニメーション(true:パーティープレイヤーがアニメーションした) --EN:--Player synchronous animation (true: party player animated)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_WALK ) == true then
		proxy:SetEventFlag( 240 , 1 );
		print("OnEvent_240 end");
		return;
	end
	
	--ダミポリへワープ --EN:--Warp to Damipoli
	proxy:WarpDmy( LOCAL_PLAYER , 1055 , 191 );
	
	proxy:NotNetMessage_begin();
		--▼240_1▼歩きアニメ終了▼ --EN:--▼240_1▼End of walking animation▼
		--proxy:OnChrAnimEnd( 240 , LOCAL_PLAYER , ANIMEID_WALK , "OnEvent_240_1" , once );
		proxy:LuaCallStart( 240 , 1 );--光の霧削除同期 --EN:--light fog removal sync
	proxy:NotNetMessage_end();
	
	proxy:SetEventFlag( 240 , 1 );
	
	--プロファイルセーブ要求 --EN:--profile save request
	proxy:SaveRequest_Profile();
	
	print("OnEvent_240 end");
end


--▲240_1▲歩きアニメ終了▲ --EN:--▲240_1▲End of walking animation▲
function OnEvent_240_1(proxy , param)
	print("OnEvent_240_1 begin");
	
	--proxy:LuaCallStart( 240 , 1 );--光の霧削除同期 --EN:--light fog removal sync
	
	print("OnEvent_240_1 end");
end





--------------------------------------------------------------------------------------
--■241■ホストPCのみが通れる光の霧■ --EN:-- ■ 241 ■ A fog of light that only the host PC can pass through ■
--------------------------------------------------------------------------------------

--■241_delete_wall■魔法壁削除同期用■ --EN:--■241_delete_wall■For synchronized magic wall deletion■
function OnEvent_241_delete_wall(proxy , param)
	print("OnEvent_241_delete_wall begin");
	
	proxy:SetDrawEnable( 1056 , false );--描画OFF --EN:--Drawing OFF
	proxy:SetColiEnable( 1056 , false );--当たりOFF --EN:--Hit OFF
	proxy:SetObjDeactivate( 1056 , true );--デアクティブ --EN:--deactivate
	proxy:DeleteEvent( 241 );
	proxy:InvalidSfx( 2076 , true );--SFX OFF
	
	print("OnEvent_241_delete_wall end");
end


--■241■イベント発動用■ --EN:-- ■ 241 ■ For event activation ■
function OnEvent_241(proxy , param)
	print("OnEvent_241 begin");

	--多重発動防止 --EN:--Multiple activation prevention
	if proxy:IsCompleteEvent( 241 ) == true then
		print("OnEvent_241 end");
		return;
	end	
	
	--プレイヤーの同期アニメーション(true:パーティープレイヤーがアニメーションした) --EN:--Player synchronous animation (true: party player animated)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_WALK ) == true then
		proxy:SetEventFlag( 241 , 1 );
		print("OnEvent_241 end");
		return;
	end
	
	--ダミポリへワープ --EN:--Warp to Damipoli
	proxy:WarpDmy( LOCAL_PLAYER , 1056 , 191 );
	
	proxy:NotNetMessage_begin();
		--▼241_1▼歩きアニメ終了▼ --EN:--▼241_1▼End of walking animation▼
		--proxy:OnChrAnimEnd( 241 , LOCAL_PLAYER , ANIMEID_WALK , "OnEvent_241_1" , once );
		proxy:LuaCallStart( 241 , 1 );--光の霧削除同期 --EN:--light fog removal sync
	proxy:NotNetMessage_end();
	
	proxy:SetEventFlag( 241 , 1 );
	
	--プロファイルセーブ要求 --EN:--profile save request
	proxy:SaveRequest_Profile();
	print("OnEvent_241 end");
end


--▲241_1▲歩きアニメ終了▲ --EN:--▲241_1▲End of walking animation▲
function OnEvent_241_1(proxy , param)
	print("OnEvent_241_1 begin");
	
	proxy:LuaCallStart( 241 , 1 );--光の霧削除同期 --EN:--light fog removal sync
	
	print("OnEvent_241_1 end");
end


--------------------------------------------------------------------------------------
--■242■ホストPCのみが通れる光の霧■ --EN:-- ■ 242 ■ A fog of light that only the host PC can pass through ■
--------------------------------------------------------------------------------------

--■242_delete_wall■魔法壁削除同期用■ --EN:--■242_delete_wall■For synchronized magic wall deletion■
function OnEvent_242_delete_wall(proxy , param)
	print("OnEvent_242_delete_wall begin");
	
	proxy:SetDrawEnable( 1057 , false );--描画OFF --EN:--Drawing OFF
	proxy:SetColiEnable( 1057 , false );--当たりOFF --EN:--Hit OFF
	proxy:SetObjDeactivate( 1057 , true );--デアクティブ --EN:--deactivate
	proxy:DeleteEvent( 242 );
	proxy:InvalidSfx( 2077 , true );--SFX OFF
	
	print("OnEvent_242_delete_wall end");
end


--■242■イベント発動用■ --EN:-- ■ 242 ■ For event activation ■
function OnEvent_242(proxy , param)
	print("OnEvent_242 begin");

	--多重発動防止 --EN:--Multiple activation prevention
	if proxy:IsCompleteEvent( 242 ) == true then
		print("OnEvent_242 end");
		return;
	end	
	
	--プレイヤーの同期アニメーション(true:パーティープレイヤーがアニメーションした) --EN:--Player synchronous animation (true: party player animated)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_WALK ) == true then
		proxy:SetEventFlag( 242 , 1 );
		print("OnEvent_242 end");
		return;
	end
	
	--ダミポリへワープ --EN:--Warp to Damipoli
	proxy:WarpDmy( LOCAL_PLAYER , 1057 , 191 );
	
	proxy:NotNetMessage_begin();
		--▼242_1▼歩きアニメ終了▼ --EN:--▼242_1▼End of walking animation▼
		--proxy:OnChrAnimEnd( 242 , LOCAL_PLAYER , ANIMEID_WALK , "OnEvent_242_1" , once );
		proxy:LuaCallStart( 242 , 1 );--光の霧削除同期 --EN:--light fog removal sync
	proxy:NotNetMessage_end();
	
	proxy:SetEventFlag( 242 , 1 );
	
	--プロファイルセーブ要求 --EN:--profile save request
	proxy:SaveRequest_Profile();
	
	print("OnEvent_242 end");
end


--▲242_1▲歩きアニメ終了▲ --EN:--▲242_1▲End of walking animation▲
function OnEvent_242_1(proxy , param)
	print("OnEvent_242_1 begin");
	
	proxy:LuaCallStart( 242 , 1 );--光の霧削除同期 --EN:--light fog removal sync
	
	print("OnEvent_242_1 end");
end


--[[

--------------------------------------------------------------------------------------
--■251■奴隷兵士の死亡監視■ --EN:--■251■Death Watch for Slave Soldiers■
--------------------------------------------------------------------------------------

function OnEvent_251(proxy , param)
	print("OnEvent_251 begin");
	
	proxy:SetEventFlag( 251 , 1 );
	
	print("OnEvent_251 end");
end

--------------------------------------------------------------------------------------
--■252■奴隷兵士の死亡監視■ --EN:--■252■Death Watch for Slave Soldiers■
--------------------------------------------------------------------------------------

function OnEvent_252(proxy , param)
	print("OnEvent_252 begin");
	
	proxy:SetEventFlag( 252 , 1 );
	
	print("OnEvent_252 end");
end

--------------------------------------------------------------------------------------
--■253■奴隷兵士の死亡監視■ --EN:--■253■Death Watch for Slave Soldiers■
--------------------------------------------------------------------------------------

function OnEvent_253(proxy , param)
	print("OnEvent_253 begin");
	
	proxy:SetEventFlag( 253 , 1 );
	
	print("OnEvent_253 end");
end


--------------------------------------------------------------------------------------
--■254■奴隷兵士の死亡監視■ --EN:--■254■Death Watch for Slave Soldiers■
--------------------------------------------------------------------------------------

function OnEvent_254(proxy , param)
	print("OnEvent_254 begin");
	
	proxy:SetEventFlag( 254 , 1 );
	
	print("OnEvent_254 end");
end


--------------------------------------------------------------------------------------
--■255■奴隷兵士の死亡監視■ --EN:--■255■Death Watch for Slave Soldiers■
--------------------------------------------------------------------------------------

function OnEvent_255(proxy , param)
	print("OnEvent_255 begin");
	
	proxy:SetEventFlag( 255 , 1 );
	
	print("OnEvent_255 end");
end


--------------------------------------------------------------------------------------
--■256■奴隷兵士の死亡監視■ --EN:--■256■Death Watch for Slave Soldiers■
--------------------------------------------------------------------------------------

function OnEvent_256(proxy , param)
	print("OnEvent_256 begin");
	
	proxy:SetEventFlag( 256 , 1 );
	
	print("OnEvent_256 end");
end
]]
--------------------------------------------------------------------------------------
--■295■レンドル王子が敵になる■ --EN:-- ■ 295 ■ Prince Lendl becomes an enemy ■
--------------------------------------------------------------------------------------
function OnEvent_295(proxy,param)
	--敵対に状態遷移 --EN:--State transition to hostility
	SetNpcStateFlag( proxy, param, rendol_flag_list, RENDOL_STATE_HOSTILE_1 );
	proxy:EnableLogic( 624 , true );
	proxy:SetTeamType( 624, TEAM_TYPE_AngryFriend );
	proxy:EraseEventSpecialEffect_2( 624 , 5062 );
	proxy:SetEventFlag( 295 , true );
end


--------------------------------------------------------------------------------------
--■300■レンドル王子の死亡監視■ --EN:-- ■ 300 ■ Death Watch for Prince Lendl ■
--------------------------------------------------------------------------------------

function OnEvent_300(proxy , param)
	print("OnEvent_300 begin");
	
	SetNpcStateFlag( proxy, param, rendol_flag_list, RENDOL_STATE_DEAD );
	RendolCheck(proxy,param);
	--死亡でRendolCheckする場合、その瞬間に消えてしまうので、 --EN:--If you perform RendolCheck on death, it will disappear at that moment, so
	--距離を見て再度有効にするか決める --EN:--Look at the distance and decide whether to re-enable
	if	proxy:IsDistance( LOCAL_PLAYER, 624, 20 ) == true then
		ValidCharactor( proxy, 624 );
	end
	
	proxy:SetEventFlag( 300 , 1 );
	
	print("OnEvent_300 end");
end


--------------------------------------------------------------------------------------
--■260■王子の監視■ --EN:-- ■ 260 ■ Prince's Watch ■
--------------------------------------------------------------------------------------
function DoreiRegist_block1(proxy)
	local acid_list = { 251, 252, 253, 254, 255, 256};
	local evid_list = { 310, 311, 312, 313, 314, 315};
	local event_num = table.getn(acid_list);
	for index = 1, event_num, 1 do
		local acid = acid_list[index];
		local evid = evid_list[index];
		if	proxy:IsCompleteEvent( acid ) == false then
			proxy:OnCharacterDead( acid , evid , "OnEvent_260" , once );
		else
			proxy:OpeningDead( evid, false );
		end
	end
end



function OnEvent_260(proxy,param)
	print("OnEvent_260 begin");

	proxy:SetEventFlag( param:GetParam1(), true );
	
	if 	proxy:IsCompleteEvent(251) == false or
		proxy:IsCompleteEvent(252) == false or
		proxy:IsCompleteEvent(253) == false or
		proxy:IsCompleteEvent(254) == false or
		proxy:IsCompleteEvent(255) == false or
		proxy:IsCompleteEvent(256) == false then
		print("OnEvent_260 is No Success");
		print("OnEvent_260 end");
		return;
	end

	--王城1で感謝に 状態遷移を試みる --EN:--Attempt to make a state transition thanks to the royal castle 1
	if proxy:IsCompleteEvent(RENDOL_STATE_HELP_FOR_DOREI_HEISI) == true then	--状態が「奴隷兵士から助けて」 ならば --EN:--If the status is "Save from Slave Soldiers"
		SetNpcStateFlag( proxy, param, rendol_flag_list, RENDOL_STATE_THANKS_1 );
		RendolCheck(proxy,param);
	else--助けて以外ならば（敵対と死亡？） --EN:--Other than help (hostility and death?)
		print("王子は死んでいるか、怒っています"); --EN:print("Prince is dead or angry");
	end
--[[
		proxy:EnableLogic(624,true);--王子ロジックON --EN:--Oji logic ON
		proxy:ChangeInitPosAng( 624 , 2150 );--王子の帰還場所を変更 --EN:-- Changed Prince's return location
		
		proxy:NotNetMessage_begin();
			--▼アイテム取得用の監視を追加▼ --EN:--▼ Added monitoring for item acquisition ▼
			proxy:LuaCall(10501,0,"OnEvent_10501",once);
		proxy:NotNetMessage_end();
]]
	proxy:SetEventFlag( 260 , 1 );
	
	print("OnEvent_260 end");	
end


--------------------------------------------------------------------------------------
--■10501■王子から感謝のアイテム■ --EN:-- ■ 10501 ■ Thank you items from the prince ■
--------------------------------------------------------------------------------------
function OnEvent_10501(proxy,param)
	print("OnEvent_10501 begin");	
	proxy:NotNetMessage_begin();
	
		--アニメ再生がトリガーになるかも？その場合監視を追加してコール --EN:--Maybe animation playback will be the trigger? In that case add monitoring and call
		--今回はただのLua関数で呼ぶ --EN:--This time, call it with a simple Lua function
		OnEvent_10501_1(proxy,param);
--[[
		--移動タイプを往復に変更 --EN:--Movement type changed to round trip
		proxy:SetEventMovePointType( 624, POINT_MOVE_TYPE_RoundTrip );
	
		--移動ポイントを設定 --EN:--set movement point
		proxy:AddCustomRoutePoint(624, 2010);
		proxy:AddCustomRoutePoint(624, 2011);
		proxy:AddCustomRoutePoint(624, 2012);
		proxy:AddCustomRoutePoint(624, 2013);
		proxy:AddCustomRoutePoint(624, 2012);
		proxy:AddCustomRoutePoint(624, 2011);
		proxy:AddCustomRoutePoint(624, 2014);
		proxy:AddCustomRoutePoint(624, 2015);
]]	
	proxy:NotNetMessage_end();
	print("OnEvent_10501 end");
end

--
function OnEvent_10501_1(proxy,param)
	
	print("OnEvent_10501_1 begin");
	OnEvent_260_1(proxy,param);
	
	if param:IsNetMessage() == false then
		--アイテム取得関数--パラメータ10101参照 --EN:--item retrieval function--see parameter 10101
		proxy:GetRateItem(10193);
	end	
	--アイテムを取得済み --EN:--item already acquired
	proxy:SetEventFlag( 10501, 1 );
	
	--王城1で探索に 状態遷移を試みる	 --EN:-- Attempt a state transition for exploration in Royal Castle 1
	SetNpcStateFlag( proxy, param, rendol_flag_list, RENDOL_STATE_SEARCH_1 );
	RendolCheck(proxy,param);
--[[	
		proxy:EnableLogic( 624 , true );--レンドル王子、探索状態で歩き出す --EN:--Prince Lendl starts walking in exploration mode
		proxy:ResetThink( 624 );
		
		proxy:NotNetMessage_begin();
			--▼レンドル王子が次のブロックへ移動用の距離監視▼ --EN:--▼Prince Lendl watches the distance for moving to the next block▼
		--proxy:OnRegistFunc( 301 , "Check_OnEvent_301" , "OnEvent_301" , 1 , once );
		proxy:NotNetMessage_end();
]]	
	print("OnEvent_10501_1 end")
end

--[[
--------------------------------------------------------------------------------------
--■301■レンドル王子が次のブロックに移動■ --EN:-- ■ 301 ■ Prince Lendl moves to the next block ■
--------------------------------------------------------------------------------------

function Check_OnEvent_301( proxy , param )

	--生存プレイヤー(グレイ)のみ判定 --EN:-- Only surviving players (gray) are judged
	if proxy:IsLivePlayer() == false and
	   proxy:IsGreyGhost()  == false then
		return false;
	end
	
	--ボス(ファランクス)生きてたら判定しない --EN:-- Boss (Phalanx) is not judged if alive
	if proxy:IsCompleteEvent( 4096 ) == false then
		return false;
	end
	
	--距離判定 --EN:--distance judgment
	if proxy:IsDistance( LOCAL_PLAYER , 624 , 20 ) == true then
		return false;
	else
		print("レンドル王子、次ブロックへ移動"); --EN:print("Prince Lendl, move to next block");
		return true;
	end
	
	return false;
end
]]

function OnEvent_301( proxy , param )
	print("OnEvent_301 begin");
	
	--王城2で「隠れているので助けて」に 状態遷移 --EN:-- State transition to "Help me because I'm hiding" in Royal Castle 2
	SetNpcStateFlag( proxy, param, rendol_flag_list, RENDOL_STATE_HELP_HIDING_ME );
	RendolCheck(proxy,param);
	
	proxy:SetEventFlag( 301 , 1 );--イベント終了 --EN:--End of event
	
	print("OnEvent_301 end");
end




--------------------------------------------------------------------------------------
--■280■吊るされた死体1が落下する■ --EN:-- ■ 280 ■ Hanging corpse 1 falls ■
--------------------------------------------------------------------------------------

function OnEvent_280( proxy , param )
	print("OnEvent_280 begin");

	--オブジェ破壊を同期させる(配信で受け取った人は、オブジェ破壊を再現する) --EN:-- Synchronize object destruction (those who receive it in the distribution reproduce the object destruction)
	if param:IsNetMessage() == true then	
		proxy:ReconstructBreak( 1172 , 1 );
	end
	
	proxy:PlayAnimation( 10240 , 1000 );--死体のアニメを終了 --EN:--Finish corpse animation
	
	proxy:NotNetMessage_begin();
		--▼280_1▼破壊アニメ再生終了▼ --EN:--▼280_1▼End of destruction animation▼
		proxy:OnObjAnimEnd( 280 , 10240 , 1000 , "OnEvent_280_1" , once );
	proxy:NotNetMessage_end();
	
	--オブジェ破壊は個人でそれぞれ判定されるのでLuaCallにしなくても大丈夫(ﾀﾌﾞﾝ) --EN:-- Object destruction is determined individually, so you don't have to use LuaCall (Tabun)
	proxy:SetEventFlag( 280 , true );
	
	print("OnEvent_280 end");
end

--▲280_1▲破壊アニメ再生終了▲ --EN:--▲280_1▲End of destruction animation ▲
function OnEvent_280_1( proxy , param )
	print("OnEvent_280_1 begin");
	
	if proxy:IsClient() == false then
		--宝システム有効化 --EN:--Treasure system enabled
		proxy:EnableObjTreasure( 10240 , true );
	end
	
	print("OnEvent_280_1 end");
end


--------------------------------------------------------------------------------------
--■281■吊るされた死体2が落下する■ --EN:--■281■The hanging corpse 2 falls■
--------------------------------------------------------------------------------------

function OnEvent_281( proxy , param )
	print("OnEvent_281 begin");

	--オブジェ破壊を同期させる(配信で受け取った人は、オブジェ破壊を再現する) --EN:-- Synchronize object destruction (those who receive it in the distribution reproduce the object destruction)
	if param:IsNetMessage() == true then	
		proxy:ReconstructBreak( 1174 , 1 );
	end
	
	proxy:PlayAnimation( 10241 , 1000 );--死体のアニメを終了 --EN:--Finish corpse animation
	
	proxy:NotNetMessage_begin();
		--▼281_1▼破壊アニメ再生終了▼ --EN:--▼281_1▼End of destruction animation▼
		proxy:OnObjAnimEnd( 281 , 10241 , 1000 , "OnEvent_281_1" , once );
	proxy:NotNetMessage_end();
	
	--オブジェ破壊は個人でそれぞれ判定されるのでLuaCallにしなくても大丈夫(ﾀﾌﾞﾝ) --EN:-- Object destruction is determined individually, so you don't have to use LuaCall (Tabun)
	proxy:SetEventFlag( 281 , true );
	
	print("OnEvent_281 end");
end

--▲281_1▲破壊アニメ再生終了▲ --EN:--▲281_1▲End of destruction animation ▲
function OnEvent_281_1( proxy , param )
	print("OnEvent_281_1 begin");

	--宝システム有効化 --EN:--Treasure system enabled
	proxy:EnableObjTreasure( 10241 , true );
	
	print("OnEvent_281_1 end");
end


--------------------------------------------------------------------------------------
--■285■砲弾ゴロゴロ■ --EN:-- ■ 285 ■ cannonball rumbling ■
--------------------------------------------------------------------------------------

function OnEvent_285( proxy , param )
	print("OnEvent_285 begin");

	--オブジェ破壊を同期させる(配信で受け取った人は、オブジェ破壊を再現する) --EN:-- Synchronize object destruction (those who receive it in the distribution reproduce the object destruction)
	if param:IsNetMessage() == true then	
		proxy:ReconstructBreak( 1190 , 1 );
	end
	
	--砲弾ゴロゴロアニメ再生 --EN:--Cannonball rumbling animation playback
	proxy:PlayAnimation( 1191 , 1 );
	
	--砲弾からダメージ球 --EN:--Damage spheres from shells
	local paramid = 10000; --無属性ダメージ --EN:--Non-attribute damage
	local rad    = 0.5;--半径(あとで、正式な値になるはず･･･今は適当) --EN:--radius (should be a formal value later... suitable for now)
	--local time   = 20; --ひとまずアニメ再生終了でダメージ球消すので、アニメより長い時間を指定しておく --EN:--For the time being, the damage ball will be erased when the animation ends, so specify a longer time than the animation.
	local time   = 120; --ひとまずアニメ再生終了でダメージ球消すので、アニメより長い時間を指定しておく --EN:--For the time being, the damage ball will be erased when the animation ends, so specify a longer time than the animation.
	local requestTime = 1.0;--ダメージ球再作成間隔 --EN:--damage sphere regeneration interval
	
	--▼285_hit▼砲弾1があたったとき▼ --EN:--▼285_hit▼When shell 1 hits▼
	proxy:OnObjectDamageHit_NoCallPlus( 285, 1191, 1, paramid, EV_HIT_CHR ,  rad, time, requestTime, everytime );
	--▼285_hit▼砲弾2があたったとき▼ --EN:--▼285_hit▼When shell 2 hits▼
	proxy:OnObjectDamageHit_NoCallPlus( 285, 1191, 2, paramid, EV_HIT_CHR ,  rad, time, requestTime,  everytime );
	--▼285_hit▼砲弾3があたったとき▼ --EN:--▼285_hit▼When shell 3 hits▼
	proxy:OnObjectDamageHit_NoCallPlus( 285, 1191, 3, paramid, EV_HIT_CHR ,  rad, time, requestTime,  everytime );	
	--▼285_hit▼砲弾4があたったとき▼ --EN:--▼285_hit▼When shell 4 hits▼
	proxy:OnObjectDamageHit_NoCallPlus( 285, 1191, 4, paramid, EV_HIT_CHR ,  rad, time, requestTime,  everytime );
	--▼285_hit▼砲弾5があたったとき▼ --EN:--▼285_hit▼When shell 5 hits▼
	proxy:OnObjectDamageHit_NoCallPlus( 285, 1191, 5, paramid, EV_HIT_CHR ,  rad, time, requestTime,  everytime );
	proxy:SetObjEventCollisionFill( 1191, true );

	--アニメ再生が終わったら、ダメージ球消すなどする? --EN:--When the animation finishes playing, do you want to erase the damage ball?
	proxy:NotNetMessage_begin();
		--▼285_anime_end▼砲弾ゴロゴロアニメ終了▼ --EN:--▼285_anime_end▼Cannonball rumbling animation ends▼
		proxy:OnObjAnimEnd( 285 , 1191 , 1 , "OnEvent_285_anime_end" , once );
	proxy:NotNetMessage_end();
	
	proxy:SetEventFlag( 285 , true );

	print("OnEvent_285 end");
end
	

--▲285_anime_end▲砲弾ゴロゴロアニメ終了▲ --EN:--▲285_anime_end▲Cannonball rumbling animation ends▲
function OnEvent_285_anime_end( proxy , param )
	print("OnEvent_285_anime_end begin");

	proxy:DeleteEvent( 285 );--ダメージ球など削除 --EN:-- Deleted damage balls etc.

	print("OnEvent_285_anime_end end");
end
	

--------------------------------------------------------------------------------------
--■310～319■ソウルモンスター出現■ --EN:-- ■ 310-319 ■ Soul Monster Appears ■
--------------------------------------------------------------------------------------
--ソウルモンスターイベント登録 --EN:--Soul Monster Event Registration
function RegistSoulMonster_block1(proxy)
	local acid_list = {   310,   311,   312,   313,   314,   315,   316,   317,   318,   319};
	local evid_list = {   320,   321,   322,   323,   324,   325,   326,   327,   328,   329};
	local qwc_list  = { 20100, 20100,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1};
	local event_num = table.getn(acid_list);
	for index = 1, event_num, 1 do
		acid = acid_list[index];
		evid = evid_list[index];
		qwc_id = qwc_list[index];
		SingleReset( proxy,acid );
		if	(qwc_id ~= -1 and proxy:IsSuccessQWC(qwc_id) == true) or (qwc_id == -1) then
			if	proxy:IsCompleteEvent( acid ) == false then
				proxy:OnPlayerDistanceInTarget( acid, LOCAL_PLAYER, evid, "OnEvent_"..acid, 10.0, once );
				InvalidCharactor( proxy, evid );
			else
				proxy:EnableLogic( evid, true );
			end
		else
			InvalidCharactor( proxy, evid );
		end
	end
	
	SingleReset( proxy , 310);
	if proxy:IsCompleteEvent( 310 ) == false then
		if proxy:IsSuccessQWC(20100) == true then--QWCが成立したら --EN:--If QWC is established
			proxy:OnPlayerDistanceInTarget( 310 , LOCAL_PLAYER , 320 , "OnEvent_310" , 10.0 , once );
		end
	else 
		proxy:EnableLogic( 320 , true );--ロジックON --EN:--Logic ON
	end
	
end


function OnEvent_310(proxy,param ) SoulMonsterFunc_block1(proxy,param,param:GetParam1(),param:GetParam2()); end
function OnEvent_311(proxy,param ) SoulMonsterFunc_block1(proxy,param,param:GetParam1(),param:GetParam2()); end
function OnEvent_312(proxy,param ) SoulMonsterFunc_block1(proxy,param,param:GetParam1(),param:GetParam2()); end
function OnEvent_313(proxy,param ) SoulMonsterFunc_block1(proxy,param,param:GetParam1(),param:GetParam2()); end
function OnEvent_314(proxy,param ) SoulMonsterFunc_block1(proxy,param,param:GetParam1(),param:GetParam2()); end
function OnEvent_315(proxy,param ) SoulMonsterFunc_block1(proxy,param,param:GetParam1(),param:GetParam2()); end
function OnEvent_316(proxy,param ) SoulMonsterFunc_block1(proxy,param,param:GetParam1(),param:GetParam2()); end
function OnEvent_317(proxy,param ) SoulMonsterFunc_block1(proxy,param,param:GetParam1(),param:GetParam2()); end
function OnEvent_318(proxy,param ) SoulMonsterFunc_block1(proxy,param,param:GetParam1(),param:GetParam2()); end
function OnEvent_319(proxy,param ) SoulMonsterFunc_block1(proxy,param,param:GetParam1(),param:GetParam2()); end

function SoulMonsterFunc_block1(proxy,param,acid,evid)
	print("OnEvent_"..acid.." begin")
	if	proxy:IsAlive(evid) == false then
		print("OnEvent_"..acid.." return end")
	end
	
	ValidCharactor( proxy , evid );--キャラクタ有効化 --EN:--Character enable
	proxy:PlayAnimation( evid , 6100 );--ソウル体出現アニメ再生(今は待機アニメになっている) --EN:--Soul appearance animation playback (currently standby animation)
	proxy:SetEventFlag( acid , true );
	
	print("OnEvent_"..acid.." end")
end







--------------------------------------------------------------------------------------
--ハシゴ1降り■320 --EN:--Ladder 1 descend ■ 320
--------------------------------------------------------------------------------------
--■320■ハシゴ1降りスタート■ --EN:-- ■ 320 ■ Ladder 1 down start ■
function OnEvent_320(proxy, param)
	print("OnEvent_320 begin");
	
	if param:IsNetMessage() == true then
		print("IsNetMessage true");
		print("OnEvent_320 end");
		return;
	end

	--はしご降りに必要な前処理-- --EN:--Pretreatment required for descending the ladder--
	proxy:BeginAction(LOCAL_PLAYER,2,2,2);				--ホバー移動モードに移行 --EN:--Transition to hover movement mode
	--proxy:HoverMoveVal(LOCAL_PLAYER,2002,LadderTime_A);--移動位置(2002)に0.5秒でホバー移動 --EN:--Hover move to moving position (2002) in 0.5 seconds
	proxy:HoverMoveValDmy(LOCAL_PLAYER,1060,192,LadderTime_A);--移動位置(2003)に0.5秒でホバー移動 --EN:--Hover in 0.5 seconds to move position (2003)
	proxy:SetEventCommand(LOCAL_PLAYER,1);				--イベントコマンドID(1)"ハシゴ上から掴"むを送る --EN:-- Send event command ID (1) "Grab from the top of the ladder"
	proxy:SetKeepCommandIndex(LOCAL_PLAYER, 0, 1, 3.0 );--nCommandID を 垂直のとき0 斜めのとき4 --EN:--nCommandID 0 for vertical 4 for diagonal
	proxy:DisableMove(LOCAL_PLAYER,1);					--キャラクタを移動、旋回不能に --EN:--Move the character, make it impossible to turn
	
	proxy:NotNetMessage_begin();
		--0.5秒(ホバー移動終了)後にはしご降りスタートイベントを発行 --EN:-- Issue a ladder descend start event after 0.5 seconds (end of hover movement)
		proxy:OnKeyTime2(320,"OnEvent_320_1",LadderTime_A,0,0,once);
		--はしご降り専用の関数を3秒間発行(カメラの周り込みなどの処理) --EN:--Issue a function dedicated to descending the ladder for 3 seconds (processing such as surrounding the camera)
		proxy:OnKeyTime2(320,"LadderDown",3,1,1,once);
	proxy:NotNetMessage_end();

	print("OnEvent_320 end");
end

--■320_1■ハシゴA降りスタート:ホバー移動終了■ --EN:--■ 320_1 ■ Start descending from ladder A: End of hover movement ■
function OnEvent_320_1(proxy, param)
	print("OnEvent_320_1 begin");
	
	if proxy:GetEventMode(LOCAL_PLAYER) == 0 then
		print("Local Player GetEventMode 0");
		print("OnEvent_320_1 end");
		return;
	end

	--ハシゴアクションモードに移行-- --EN:--Transition to ladder action mode--
	--nMax  : はしごの段数 - 補正値(補正値はおおよそ3) --EN:--nMax : number of ladder steps - correction value (correction value is approximately 3)
	--nStart: 降りるとき→(nMax + 1) 昇るとき→(-1) --EN:--nStart: When going down→(nMax + 1) When going up→(-1)
	proxy:BeginAction(LOCAL_PLAYER,1,50,49);
	
	--キャラクタを移動、旋回可能に-- --EN:--Character can be moved and turned--
	proxy:DisableMove(LOCAL_PLAYER,0);
	
	print("OnEvent_320_1 end");
end


--------------------------------------------------------------------------------------
--ハシゴ1昇り■321 --EN:--Ladder 1 up 321
--------------------------------------------------------------------------------------
--■321■ハシゴ1昇りスタート■ --EN:-- ■ 321 ■ Ladder 1 climbing start ■
function OnEvent_321(proxy, param)
	print("OnEvent_321 begin");
	
	if param:IsNetMessage() == true then
		print("IsNetMessage true");
		print("OnEvent_321 end");
		return;
	end
	
	--はしご昇りに必要な前処理-- --EN:--Pretreatment required for climbing a ladder--
	proxy:BeginAction(LOCAL_PLAYER,2,-1,1);			--ホバー移動モードに移行 --EN:--Transition to hover movement mode
	--proxy:HoverMoveVal(LOCAL_PLAYER,2003,LadderTime_A);--移動位置(2003)に0.5秒でホバー移動 --EN:--Hover in 0.5 seconds to move position (2003)
	proxy:HoverMoveValDmy(LOCAL_PLAYER,1060,191,LadderTime_A);--移動位置(2003)に0.5秒でホバー移動 --EN:--Hover in 0.5 seconds to move position (2003)
	proxy:SetEventCommand(LOCAL_PLAYER,0);				--イベントコマンドID(0)"ハシゴ下から掴"むを送る --EN:-- Send event command ID (0) "grab from under the ladder"
	proxy:SetKeepCommandIndex(LOCAL_PLAYER, 0, 1, 3.0 );--nCommandID を 垂直のとき0 斜めのとき4 --EN:--nCommandID 0 for vertical 4 for diagonal
	proxy:DisableMove(LOCAL_PLAYER,1);					--キャラクタを移動、旋回不能に --EN:--Move the character, make it impossible to turn
	
	proxy:NotNetMessage_begin();
		--0.5秒(ホバー移動終了)後にはしご昇りスタートイベントを発行 --EN:-- Issue a ladder climb start event after 0.5 seconds (end of hover movement)
		proxy:OnKeyTime2(321,"OnEvent_321_1",LadderTime_A,0,0,once);
		--はしご昇り用の関数を1秒間発行(イベントメニューの中断処理?) --EN:--Issuing a function for climbing a ladder for 1 second (interruption processing of the event menu?)
		proxy:OnKeyTime2(321,"EventMenuBrake",1,1,1,once);
	proxy:NotNetMessage_end();
	
	print("OnEvent_321 end");
end

--■321_1■ハシゴ1昇りスタート:ホバー移動終了■ --EN:--■ 321_1 ■ Ladder 1 climbing start: Hover movement finished ■
function OnEvent_321_1(proxy, param)
	print("OnEvent_321_1 begin");
	
	if proxy:GetEventMode(LOCAL_PLAYER) == 0 then
		print("Local Player GetEventMode 0");
		print("OnEvent_321_1 end");
		return;
	end

	--ハシゴアクションモードに移行-- --EN:--Transition to ladder action mode--
	--nMax  : はしごの段数 - 補正値(補正値はおおよそ3) --EN:--nMax : number of ladder steps - correction value (correction value is approximately 3)
	--nStart: 降りるとき→(nMax + 1) 昇るとき→(-1) --EN:--nStart: When going down→(nMax + 1) When going up→(-1)
	proxy:BeginAction(LOCAL_PLAYER,1,-1,49);
	
	--キャラクタを移動、旋回可能に-- --EN:--Character can be moved and turned--
	proxy:DisableMove(LOCAL_PLAYER,0);
	
	print("OnEvent_321_1 end");
end


--------------------------------------------------------------------------------------
--■2■飛竜が飛んでくるポリ劇を再生する■ --EN:--■ 2 ■ Replay a poly-drama in which flying dragons fly ■
--------------------------------------------------------------------------------------

function OnEvent_2(proxy , param)
	print("OnEvent_2 begin");

	--▼飛竜が飛んでくるポリ劇再生 --EN:--▼ Play a poly-drama in which flying dragons fly
	proxy:RequestRemo(20000,REMO_FLAG,2,1);
	proxy:SetEventFlag( 2, true );

	print("OnEvent_2 end");
end


--■ポリ劇再生開始(フェード終了) --EN:--■ Start of polyplay playback (end of fade)
function OnEvent_2_RemoStart(proxy,param)
	print("OnEvent_2_RemoStart begin");
	
	--SEが残るらしいので-1再生 --EN:--Since SE seems to remain, -1 playback
	--proxy:ForcePlayAnimation( 1110 ,-1);
	--proxy:ForcePlayAnimation( 1111 ,-1);
	--proxy:ForcePlayAnimation( 1112 ,-1);
	--カラスが残ってしまうようなので消す。 --EN:--It seems that crows will remain, so delete them.
	--proxy:SetDrawEnable( 1110 , false );
	--proxy:SetDrawEnable( 1111 , false );
	--proxy:SetDrawEnable( 1112 , false );
	
	print("OnEvent_2_RemoStart end");
end


--■ポリ劇再生終了(フェード終了) --EN:-- End of polyplay playback (end of fade)
function OnEvent_2_RemoFinish(proxy , param)
	print("OnEvent_2_RemoFinish begin");
	print("OnEvent_2_RemoFinish end");
end

--------------------------------------------------------------------------------------
--■258■奴隷兵士がレンドル王子を狙うのをやめる監視追加(ロジック切り替え)■ --EN:--■ 258 ■ Added monitoring to stop slave soldiers from targeting Prince Lendl (switch logic) ■
--------------------------------------------------------------------------------------

--■領域入ったとき(奴隷兵士 通常ロジックにする) --EN:-- ■ When entering the area (slave soldiers normal logic)
function OnEvent_258(proxy,param)
	print("OnEvent_258 begin");

	--レンドル王子の状態取得 --EN:-- Get Prince Lendl's status
	local now_state = GetRendolState( proxy, param );
	
	--状態が「奴隷兵士から助けて」じゃない　 --EN:--The status is not ``Save from slave soldiers''
	--状態が「王城１敵対」じゃない --EN:--The status is not "Castle 1 hostile"
	--状態が「王城１死亡」じゃないときは 処理しない(監視削除) --EN:--Do not process if the state is not "Old castle 1 dead" (delete monitoring)
	if 	now_state ~= RENDOL_STATE_HELP_FOR_DOREI_HEISI and
		now_state ~= RENDOL_STATE_HOSTILE_1 and
		now_state ~= RENDOL_STATE_DEAD then
		proxy:DeleteEvent( 258 );--ロジック切り替え監視削除 --EN:--Delete logic switching monitor
		proxy:DeleteEvent( 245 );--奴隷兵士のダメージ監視削除 --EN:-- Removed slave soldier damage monitoring
		print("OnEvent_258 end");
		return;
	end
		
	--奴隷兵士通常ロジックに切り替え(レンドル王子と睨み合うのをやめる) --EN:--Slave soldier Switch to normal logic (stop staring at Prince Lendl)
	local dorei_heisi_id_list = {310,311,312,313,314,315};
	local dorei_heisi_num = table.getn( dorei_heisi_id_list );
	
	for i=1 , dorei_heisi_num , 1 do
		proxy:ForceUpdateNextFrame( dorei_heisi_id_list[i] );--次のフレームは強制更新 --EN:--Force update next frame
		proxy:SendEventRequest    ( dorei_heisi_id_list[i] , 0 , AI_EVENT_None);
		--proxy:SetEventTarget   ( dorei_heisi_id_list[i] , -1);--強制ターゲットクリア --EN:--force target clear
	end
	
	proxy:DeleteEvent( 245 );--奴隷兵士のダメージ監視を一旦削除 --EN:-- Removed damage monitoring for slave soldiers
	
	proxy:SetEventFlag( 258 , 1 );--王子を狙うのをやめた --EN:-- Stopped aiming at the prince

	print("OnEvent_258 end");
end

--■領域を出たとき(奴隷兵士 威嚇ロジックにする) --EN:-- ■ When leaving the area (slave soldier intimidation logic)
function OnEvent_258_out(proxy,param)
	print("OnEvent_258_out begin");

	--領域に入ったフラグがOFFだったら処理しない(恐らくないと思われるけれど･･･) --EN:--If the flag that entered the area is OFF, it will not be processed (probably not, but...)
	if proxy:IsCompleteEvent( 258 ) == false then
		print("OnEvent_258_out end");
		return;
	end
	
	--レンドル王子の状態取得 --EN:-- Get Prince Lendl's status
	local now_state = GetRendolState( proxy, param );
	
	--状態が「奴隷兵士から助けて」じゃないときは 処理しない(監視削除) --EN:--Do not process if the status is not "Save from slave soldiers" (monitor deleted)
	if now_state ~= RENDOL_STATE_HELP_FOR_DOREI_HEISI then
		proxy:DeleteEvent( 258 );--ロジック切り替え監視削除 --EN:--Delete logic switching monitor
		proxy:DeleteEvent( 245 );--奴隷兵士のダメージ監視削除 --EN:-- Removed slave soldier damage monitoring
		print("OnEvent_258_out end");
		return;
	end
	
	--奴隷兵士威嚇ロジックに切り替え(レンドル王子と睨み合う) --EN:--Switch to slave soldier intimidation logic (glaring at Prince Lendl)
	local dorei_heisi_id_list = {310,311,312,313,314,315};
	local dorei_heisi_num = table.getn( dorei_heisi_id_list );
	local rendol_id = 624;
		
	for i=1, dorei_heisi_num, 1 do		
		proxy:SendEventRequest( dorei_heisi_id_list[i] , 0 , AI_EVENT_DOREI_IKAKU);
		proxy:SetEventTarget( dorei_heisi_id_list[i] , rendol_id);--強制ターゲット設定 --EN:--force target setting
		
		--▼奴隷兵士たちのダメージ監視▼ --EN:--▼Damage monitoring of slave soldiers▼
		proxy:OnSimpleDamage( 245 , dorei_heisi_id_list[i], LOCAL_PLAYER, "OnEvent_258", once );--ダメージ監視 --EN:--Damage monitoring
	end
	
	proxy:SetEventFlag( 258 , 0 );--王子を狙うのを再開 --EN:-- Resume aiming for the prince
	
	print("OnEvent_258_out end");
end

--■259■レンドル王子が領域侵入で仕方なく戦う■ --EN:-- ■ 259 ■ Prince Lendl fights reluctantly to invade the territory ■
function OnEvent_259(proxy,param)
	print("OnEvent_259 begin");
	proxy:EnableLogic( 624, true );
	print("OnEvent_259 end");
end


--------------------------------------------------------------------------------------
--■4103■ソウル入手■ --EN:-- ■ 4103 ■ Get Soul ■
--------------------------------------------------------------------------------------

function OnEvent_4103(proxy, param)
	print("OnEvent_4103 begin");
	
	--プレイヤーの同期アニメーション(true:パーティープレイヤーがアニメーションした) --EN:--Player synchronous animation (true: party player animated)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_PICK ) == true then--新しいアニメ  --EN:-- new anime
		print("OnEvent_4103 end");
		return true;
	end
	
	proxy:NotNetMessage_begin();
		--0.0秒後にアイテム取得イベントを発行 --EN:-- Issue an item acquisition event after 0.0 seconds
		proxy:OnKeyTime2( 4103, "OnEvent_4103_1", 0.0, 0, 0, once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_4103 end");
end


--■4103_1■アイテム取得■ --EN:-- ■ 4103_1 ■ item acquisition ■
function OnEvent_4103_1(proxy, param)
	print("OnEvent_4103_1 begin");

	--アイテム取得関数--パラメータ10101参照 --EN:--item retrieval function--see parameter 10101
	proxy:GetRateItem(10110);
	proxy:GetRateItem(10170);
	proxy:GetRateItem(10171);
	proxy:GetRateItem(10172);
	proxy:GetRateItem(10173);
	
	--アイテムを取得済み --EN:--item already acquired
	proxy:SetEventFlag( 4103, 1 );
	
	--宝箱シェーダーは消えません --EN:--Treasure chest shader does not disappear
	--proxy:TreasureDispModeChange( 1982 , false );

	--SFXが消える --EN:--SFX disappear
	proxy:InvalidSfx( 1080 , true );--光の粒子 --EN:--Particles of light
	--proxy:InvalidSfx( 1081 , true );--要石のオーラ --EN:--Keystone Aura
	
	--▼要石でワープ用の監視を追加▼ --EN:--▼ Added surveillance for warp with keystone ▼
	proxy:OnDistanceActionAttribute( 4105 , LOCAL_PLAYER , 1982 , "OnEvent_4105" , WarpGimmickDist_A , HELPID_GO_TO_SEKITYUU , 0 , 180 , ATTR_NOSESSION , everytime );

	print("OnEvent_4103_1 end");
end

--------------------------------------------------------------------------------------
--■30■最初の要石の光が消える■ --EN:--■30■The light on the first keystone disappears■
--------------------------------------------------------------------------------------

function OnEvent_30(proxy, param)
	print("OnEvent_30 begin");
	
	proxy:TreasureDispModeChange2( 1983 , false ,KANAME_SFX);
	
	print("OnEvent_30 end");
end


--------------------------------------------------------------------------------------
--■31■最初の要石の光が復活する■ --EN:-- ■ 31 ■ The light of the first keystone is restored ■
--------------------------------------------------------------------------------------

function OnEvent_31(proxy, param)
	print("OnEvent_31 begin");
	
	proxy:TreasureDispModeChange2( 1983 , true ,KANAME_SFX);
	
	print("OnEvent_31 end");
end

--【ドラン】戦闘開始 --EN:--[Doran] Combat begins
function OnEvent_329(proxy,param)
	proxy:EnableLogic( 697 , true );
	proxy:SetEventFlag( 329 , true );
end

--【ドラン】許してくれた --EN:-- [Doran] Forgive me
function OnEvent_330(proxy,param)
	print("OnEvent_330 begin");
	if proxy:IsAlive( 697 ) == true then
		proxy:SetTeamType( 697, TEAM_TYPE_Friend );
		SetNpcStateFlag( proxy , param , doran_flag_list , DORAN_STATE_ALLOWED );
		proxy:ResetThink(697);
	
		proxy:ClearTarget(nWho);
	end
	
	--ホスト、生存、グレイのみ調べることができる --EN:--Only hosts, survivors, and grays can be examined
	local possible_chr_type = ATTR_HOST + ATTR_LIVE + ATTR_GREY;
	--HELPIDがデモンブランド専用になった --EN:--HELPID is now exclusive to the Demon brand
	proxy:OnDistanceActionAttribute( 5 , LOCAL_PLAYER , 1192 , "OnEvent_5" , ItemBoxDist_A , 10010130 , 0 , ItemBoxAngle_A ,possible_chr_type, everytime ); 
	proxy:LuaCall( 5,1,"OnEvent_5_2",once);	
	proxy:LuaCall( 5,2,"OnEvent_5_3",once);
	proxy:TreasureDispModeChange2( 1192, true ,KEN_SFX);
	--proxy:SetRarity( 1192, 10104 );
				
	proxy:SetEventFlag( 330, true );
	print("OnEvent_330 end");
end

--【ドラン】許さない --EN:--[Doran] I won't forgive you
function OnEvent_331(proxy,param)
	if proxy:IsAlive( 697 ) == true then
		print("OnEvent_331 begin");
		proxy:SetTeamTypeDefault( 697 );
		SetNpcStateFlag( proxy , param , doran_flag_list , DORAN_STATE_NOT_ALLOWED );
		print("ドラン手加減やめる"); --EN:print("Don't take it easy");
		proxy:SendEventRequest( 697 ,0, -1);
		proxy:EraseEventSpecialEffect_2( 697 , 5042 );
		proxy:SetEventFlag( 331, true );
		print("OnEvent_331 end");
	end
end

--【ドラン】死亡 --EN:--[Doran] Death
function OnEvent_332(proxy,param)
	print("OnEvent_332 begin");
	SetNpcStateFlag( proxy , param , doran_flag_list , DORAN_STATE_DEAD );
	proxy:SetEventFlag( 332, true );

	--▼トロフィー取得判定▼ --EN:--▼Trophy Acquisition Judgment▼
	Lua_RequestUnlockTrophy(proxy, 11);

	print("OnEvent_332 end");
end

--【ドラン】死体を調べた --EN:-- [Doran] Examine the corpse
function OnEvent_15610(proxy,param)
	print("OnEvent_15610 begin");
	proxy:SetEventFlag( 15610 , true );
	print("OnEvent_15610 end");
end



function CheckPointIn_AttrCheck(proxy,param)
	print("CheckPointIn_AttrCheck begin");
	--ホストのみチェックポイント判定を行う --EN:--Perform checkpoint judgment only for the host
	if	proxy:IsClient() == false then
		--→CheckPointIn --EN:--→CheckPointIn
		--パラメータとして領域のイベントIDを渡しておく --EN:-- Pass the area event ID as a parameter
		proxy:LuaCallStartPlus( SYSTEM_CHECK_POINT, 2, param:GetParam2() );
	end
	print("CheckPointIn_AttrCheck end");
end

--チェックポイント通過 --EN:--Checkpoint pass
function CheckPointIn(proxy,param)
	print("CheckPointIn begin");
	RendolCheck(proxy,param);
	BiyoCheck(proxy,param);
	--HiryuOsaCheck(proxy,param);
	OnEvent_781(proxy,param);--奴隷兵士ショップ --EN:--Slave Soldier Shop
	print("CheckPointIn end");
end

function InitializeNpc(proxy,param)
	RendolCheck2(proxy,param,false);
	BiyoCheck2(proxy,param,false);
	--HiryuOsaCheck(proxy,param);
	OnEvent_781(proxy,param);--奴隷兵士ショップ --EN:--Slave Soldier Shop
end

--[[削除との事なので、コメントアウト --EN:--[[Deleting, so comment out
--------------------------------------------------------------------------------------
--■10700■吊るされている人が話しかけてくる■ --EN:--■10700■The person who is hanging speaks to you■
--------------------------------------------------------------------------------------
function OnEvent_10700(proxy,param)
--	print("OnEvent_10700 begin");

	--死体を落とすイベントが終わっている --EN:--The corpse drop event is over
	if proxy:IsCompleteEvent( 281 ) == true then
		
		if proxy:IsCompleteEvent( 10701 ) == false then
			--断末魔(感謝) --EN:-- Deathrattle (Gratitude)
			proxy:CloseTalk(10700);
			proxy:TalkNextPage( 10701 );
			proxy:SetEventFlag( 10701 , 1 );
		else
			proxy:DeleteEvent( 10700 );
			return;
		end
		
	--まだ吊るされている --EN:--still hanging
	else
		if proxy:IsCompleteEvent( 10700 ) == false then
			--話しかけてくる --EN:--talks to me
			proxy:TalkNextPage( 10700 );	
			proxy:SetEventFlag( 10700 , 1 );
		end
	end

--	print("OnEvent_10700 end");
end]]


--[[-----------------------------------------------------------------------------------------------------------------------------------------
	レンドル王子関連　ここから --EN:Related to Prince Lendl From here
-----------------------------------------------------------------------------------------------------------------------------------------]]
function RendolCheck(proxy,param)
	RendolCheck2(proxy,param,true);
end

function RendolCheck2(proxy,param,flag)
	print("RendolCheck begin");
	local rendol_id_1 = 624;--王城１のレンドル王子 --EN:--Prince Lendl of Royal Castle 1
	local rendol_id_2 = 620;--王城２のレンドル王子 --EN:--Prince Lendl of Royal Castle 2
	local rendol_id_3 = 621;--王城３のレンドル王子 --EN:--Prince Lendl of Royal Castle 3
	local rendol_id_4 = 626;--王城４のレンドル王子 --EN:--Prince Lendl of Royal Castle 4
	
	local rendol_block1_acid_list = {   245,   258,   259,   301,   260,   300,   295, 10501};
	local rendol_block2_acid_list = { 10800,   723,   724,   643};
	local rendol_block3_acid_list = {  1310,  1311,  1312,  1313,  1314,  1315,  1316,  1316,  1317,  1318,  1349, 1350,  1351,  1352,  1360,  1361,  1362, 11501};
	local rendol_block4_acid_list = { 11790,  1700,  1702};
	
	--一旦全員消しておく --EN:-- Erase all of them for now
	InvalidCharactor(proxy,rendol_id_1);
	InvalidCharactor(proxy,rendol_id_2);
	InvalidCharactor(proxy,rendol_id_3);
	InvalidCharactor(proxy,rendol_id_4);
	--InvalidCharactor(proxy, 102);
	--InvalidCharactor(proxy, 103);
	

	
	--監視を一旦全削除 --EN:--Delete all monitors once
	DeleteConditionList(proxy,rendol_block1_acid_list);
	DeleteConditionList(proxy,rendol_block2_acid_list);
	DeleteConditionList(proxy,rendol_block3_acid_list);
	DeleteConditionList(proxy,rendol_block4_acid_list);
	
	SetFirstNpcStateFlag( proxy, param, rendol_flag_list, RENDOL_STATE_HELP_FOR_DOREI_HEISI );
	
	----------------------------------------------------------------------------------------------------------------
	--王子が奴隷兵士から助けて状態--16000 --EN:--Prince Saved from Slave Soldiers State--16000
	if	proxy:IsCompleteEvent(RENDOL_STATE_HELP_FOR_DOREI_HEISI) == true then
		print("rendol state RENDOL_STATE_HELP_FOR_DOREI_HEISI");
		SetRendolState_01(proxy, param, rendol_id_1 );
		RendolRegistCondition_block1(proxy,param,rendol_id_1);
		
	----------------------------------------------------------------------------------------------------------------
	--王子が感謝（王城１）状態--16001 --EN:--Prince thanks (Castle 1) state--16001
	elseif	proxy:IsCompleteEvent(RENDOL_STATE_THANKS_1) == true then
		print("rendol state RENDOL_STATE_THANKS_1");
		if flag == true then
			SetRendolState_02(proxy, param, rendol_id_1 );
		else
			SetRendolState_02Init(proxy, param, rendol_id_1 );
		end
		RendolRegistCondition_block1(proxy,param,rendol_id_1);
		
	----------------------------------------------------------------------------------------------------------------
	--王子が探索（王城１）状態--16002 --EN:--Prince exploring (Castle 1) state--16002
	elseif	proxy:IsCompleteEvent(RENDOL_STATE_SEARCH_1) == true then
		print("rendol state RENDOL_STATE_SEARCH_1");
		if flag == true then
			SetRendolState_03(proxy, param, rendol_id_1 );
		else
			SetRendolState_03Init(proxy, param, rendol_id_1 );
		end
		RendolRegistCondition_block1(proxy,param,rendol_id_1);
		
	----------------------------------------------------------------------------------------------------------------
	--王子が敵対（王城１）状態--16003 --EN:--Prince hostile (Royal Castle 1) state--16003
	elseif	proxy:IsCompleteEvent(RENDOL_STATE_HOSTILE_1) == true then
		print("rendol state RENDOL_STATE_HOSTILE_1");
		if flag == true then
			SetRendolState_04(proxy, param, rendol_id_1 );
		else
			SetRendolState_04Init(proxy, param, rendol_id_1 );
		end
		RendolRegistCondition_block1(proxy,param,rendol_id_1);
		
	----------------------------------------------------------------------------------------------------------------
	--王子が死んでいる状態--16004 --EN:--Prince dead--16004
	elseif	proxy:IsCompleteEvent(RENDOL_STATE_DEAD) == true then
		print("rendol state RENDOL_STATE_DEAD");
		--ここでは追加も設定もしない --EN:--Do not add or set here
		
	----------------------------------------------------------------------------------------------------------------
	--王子が隠れているので助けて状態--16005 --EN:--The prince is hiding, so please help me--16005
	elseif	proxy:IsCompleteEvent(RENDOL_STATE_HELP_HIDING_ME) == true then
		print("rendol state RENDOL_STATE_HELP_HIDING_ME");
		SetRendolState_05(proxy, param, rendol_id_2 );
		RendolRegistCondition_block2(proxy,param,rendol_id_2);
		
	----------------------------------------------------------------------------------------------------------------
	--王子が感謝（王城２）状態--16006 --EN:--Prince thanks (Castle 2) state--16006
	elseif	proxy:IsCompleteEvent(RENDOL_STATE_THANKS_2) == true then
		print("rendol state RENDOL_STATE_THANKS_2");
		SetRendolState_06(proxy, param, rendol_id_2 );
		RendolRegistCondition_block2(proxy,param,rendol_id_2);
		
	----------------------------------------------------------------------------------------------------------------
	--王子が探索（王城２）状態--16007 --EN:--Prince Exploring (Castle 2) State--16007
	elseif	proxy:IsCompleteEvent(RENDOL_STATE_SEARCH_2) == true then
		print("rendol state RENDOL_STATE_SEARCH_2");
		SetRendolState_07(proxy, param, rendol_id_2 );
		RendolRegistCondition_block2(proxy,param,rendol_id_2);
		
	----------------------------------------------------------------------------------------------------------------
	--王子が敵対（王城２）状態--16008 --EN:--Prince hostile (Royal Castle 2) state--16008
	elseif	proxy:IsCompleteEvent(RENDOL_STATE_HOSTILE_2) == true then
		print("rendol state RENDOL_STATE_HOSTILE_2");
		SetRendolState_08(proxy, param, rendol_id_2 );
		RendolRegistCondition_block2(proxy,param,rendol_id_2);
		
	----------------------------------------------------------------------------------------------------------------
	--王子が見えない場所にこっそり状態--16009 --EN:--Stealth in a place where the prince can't be seen--16009
	elseif	proxy:IsCompleteEvent(RENDOL_STATE_LOCATION_INVISIBLE) == true then
		print("rendol state RENDOL_STATE_LOCATION_INVISIBLE");
		SetRendolState_09(proxy, param, rendol_id_3 );
		RendolRegistCondition_block3(proxy,param,rendol_id_3);
		
	----------------------------------------------------------------------------------------------------------------
	--王子が門を開けて欲しい状態--16010 --EN:--The state where the prince wants the gate to be opened--16010
	elseif	proxy:IsCompleteEvent(RENDOL_STATE_WANT_TO_OPEN_THE_GATE) == true then
		print("rendol state RENDOL_STATE_WANT_TO_OPEN_THE_GATE");
		SetRendolState_10(proxy, param, rendol_id_3 );
		RendolRegistCondition_block3(proxy,param,rendol_id_3);
		
	----------------------------------------------------------------------------------------------------------------
	--王子が袋小路で怯え状態--16011 --EN:--Prince frightened in a dead end--16011
	elseif	proxy:IsCompleteEvent(RENDOL_STATE_SCARED) == true then
		print("rendol state RENDOL_STATE_SCARED");
		SetRendolState_11(proxy, param, rendol_id_3 );
		RendolRegistCondition_block3(proxy,param,rendol_id_3);
		
	----------------------------------------------------------------------------------------------------------------
	--王子が感謝（王城３）状態--16012 --EN:--Prince thanks (Castle 3) state--16012
	elseif	proxy:IsCompleteEvent(RENDOL_STATE_THANKS_3) == true then
		print("rendol state RENDOL_STATE_THANKS_3");
		SetRendolState_12(proxy, param, rendol_id_3 );
		RendolRegistCondition_block3(proxy,param,rendol_id_3);
		
	----------------------------------------------------------------------------------------------------------------
	--王子が探索（王城３）状態--16013 --EN:--Prince exploring (Castle 3) state--16013
	elseif	proxy:IsCompleteEvent(RENDOL_STATE_SEARCH_3) == true then
		print("rendol state RENDOL_STATE_SEARCH_3");
		SetRendolState_13(proxy, param, rendol_id_3 );
		RendolRegistCondition_block3(proxy,param,rendol_id_3);
		
	----------------------------------------------------------------------------------------------------------------
	--王子が敵対（王城３）城門の前状態--16014 --EN:--The prince is hostile (Castle 3) Before the castle gate--16014
	elseif	proxy:IsCompleteEvent(RENDOL_STATE_HOSTILE_3_FRONT_GATE) == true then
		print("rendol state RENDOL_STATE_HOSTILE_3_FRONT_GATE");
		SetRendolState_14(proxy, param, rendol_id_3 );
		RendolRegistCondition_block3(proxy,param,rendol_id_3);
		
	----------------------------------------------------------------------------------------------------------------
	--王子が敵対（王城３）城門の後ろ状態--16015 --EN:--Prince is hostile (Castle 3) Behind the castle gate--16015
	elseif	proxy:IsCompleteEvent(RENDOL_STATE_HOSTILE_3_BACK_GATE) == true then
		print("rendol state RENDOL_STATE_HOSTILE_3_BACK_GATE");
		SetRendolState_15(proxy, param, rendol_id_3 );
		RendolRegistCondition_block3(proxy,param,rendol_id_3);
		
	----------------------------------------------------------------------------------------------------------------
	--王子がエレベータ前状態--16016 --EN:--Prince before elevator--16016
	elseif	proxy:IsCompleteEvent(RENDOL_STATE_LIFT_FRONT) == true then
		print("rendol state RENDOL_STATE_LIFT_FRONT");
		SetRendolState_16(proxy, param, rendol_id_4 );
		RendolRegistCondition_block4(proxy,param,rendol_id_4);
		
	----------------------------------------------------------------------------------------------------------------
	--王子が敵対（王城４）状態--16017 --EN:--Prince hostile (Royal Castle 4) state--16017
	elseif	proxy:IsCompleteEvent(RENDOL_STATE_HOSTILE_4_LIFT_FRONT) == true then
		print("rendol state RENDOL_STATE_HOSTILE_4_LIFT_FRONT");
		SetRendolState_17(proxy, param, rendol_id_4 );
		RendolRegistCondition_block4(proxy,param,rendol_id_4);
		
	----------------------------------------------------------------------------------------------------------------
	--王子が敵対（石柱）状態--16018 --EN:--Prince is hostile (stone pillar) state--16018
	elseif	proxy:IsCompleteEvent(RENDOL_STATE_HOSTILE_STONE_PILLAR) == true then
		print("rendol state RENDOL_STATE_HOSTILE_STONE_PILLAR");
		SetRendolState_18(proxy, param, rendol_id_4 );
		RendolRegistCondition_block4(proxy,param,rendol_id_4);
	end
	print("RendolCheck end");
end


--[[11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
---------------------------------------▽▽▽王城１レンドル王子▽▽▽------------------------------ --EN:--▽▽▽Royal Castle 1 Prince Lendor▽▽▽-------------------------------
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111]]
function RendolRegistCondition_block1(proxy,param,chrId)
	print("RendolRegistCondition_block1 begin");
	
	if	proxy:IsCompleteEvent(RENDOL_STATE_DEAD) == false then
		if	proxy:IsCompleteEvent(RENDOL_STATE_HOSTILE_1) == false then
			--■295■レンドル王子が敵になる■ --EN:-- ■ 295 ■ Prince Lendl becomes an enemy ■
			if proxy:IsCompleteEvent( 295 ) == false then
				--レンドル王子(624)がPC(LOCAL_PLAYER)から100ダメージを受けた --EN:--Prince Lendl (624) received 100 damage from PC (LOCAL_PLAYER)
				--proxy:OnCharacterTotalDamage( 295, chrId, LOCAL_PLAYER, 100, "OnEvent_295", once );
				proxy:OnCharacterTotalRateDamage( 295, chrId, LOCAL_PLAYER, NPC_ANGRY_Rate, "OnEvent_295", once );
			end
		end
		--■300■レンドル王子の死亡■ --EN:-- ■ 300 ■ Death of Prince Lendl ■
		if proxy:IsCompleteEvent( 300 ) == false then
			proxy:OnCharacterDead( 300 , chrId , "OnEvent_300" , once );
		end
		
		
		--■260■レンドル王子を囲んでいる奴隷兵士を全部倒した■ --EN:-- ■ 260 ■ Defeated all the slave soldiers surrounding Prince Lendl ■
		if proxy:IsCompleteEvent( 260 ) == true then
			proxy:DeleteEvent( 258 );--王子から奴隷兵士助けるイベント削除 --EN:--Delete the event that helps the slave soldier from the prince
		end
	end

	
	print("RendolRegistCondition_block1 end");
end


-------------------------------------------------------------------------------------------------
--王子が奴隷兵士から助けて状態--16000 --EN:--Prince Saved from Slave Soldiers State--16000
function SetRendolState_01(proxy,param,chrId)
	print("SetRendolState_01 begin");
	local enemy_list = {310, 311, 312, 313, 314, 315};
	local enemy_num = table.getn( enemy_list );
	for index = 1, enemy_num, 1 do
		--奴隷が生きていたら威嚇にして、レンドル王子をターゲットに設定 --EN:--Intimidate if the slave is alive and set Prince Lendl as the target
		if	proxy:IsAlive(enemy_list[index]) == true then
			--proxy:ChangeThink( enemy_list[index], AI_EVENT_DOREI_IKAKU);
			proxy:SendEventRequest( enemy_list[index], 0, AI_EVENT_DOREI_IKAKU );
			proxy:SetEventTarget( enemy_list[index] , chrId );--強制ターゲット設定 --EN:--force target setting
			--▼奴隷兵士たちのダメージ監視▼ --EN:--▼Damage monitoring of slave soldiers▼
			proxy:OnSimpleDamage( 245 , enemy_list[index] , LOCAL_PLAYER , "OnEvent_258" , once );--ダメージ監視			 --EN:--Damage monitoring
		end
	end
	--▼レンドル王子が領域侵入で仕方なく戦う▼ --EN:--▼Prince Lendl reluctantly fights for territory invasion▼
	proxy:OnRegionJustIn( 259, chrId, 2151, "OnEvent_259", once );
	
	proxy:EnableLogic( chrId , false );--レンドル王子ロジックOFF --EN:--Lendl Oji Logic OFF
	--王子有効化 --EN:--Prince enabled
	ValidCharactor( proxy, chrId );
	
	--▼奴隷兵士がレンドル王子を狙うのをやめる監視追加(ロジック切り替え)▼	 --EN:--▼ Added monitoring to stop slave soldiers from aiming at Prince Lendl (logic switch) ▼
	proxy:SetEventFlag( 258 , 0 );--毎回追加されてほしいので･･･。 --EN:--Because I want it to be added every time...
	proxy:OnRegionJustIn ( 258 , LOCAL_PLAYER , 2151 , "OnEvent_258"     , everytime );--領域入ったとき通常へ		 --EN:-- to normal when entering the area
	proxy:OnRegionJustIn ( 258 , chrId , 2151 , "OnEvent_258"     , everytime );--レンドル領域入ったとき通常へ		 --EN:-- to normal when entering the Lendl region
	proxy:OnRegionJustOut( 258 , LOCAL_PLAYER , 2151 , "OnEvent_258_out" , everytime );--領域でたとき威嚇へ --EN:-- to intimidation when in the realm
	
	print("SetRendolState_01 end");
end


-------------------------------------------------------------------------------------------------
--王子が感謝（王城１）状態--16001 --EN:--Prince thanks (Castle 1) state--16001
function SetRendolState_02(proxy,param,chrId)
	print("SetRendolState_02 begin");
	
	--王子有効化 --EN:--Prince enabled
	ValidCharactor( proxy, chrId );
	
	proxy:EnableLogic(chrId,true);--王子ロジックON --EN:--Oji logic ON
	proxy:ChangeInitPosAng( chrId , 2150 );--王子の帰還場所を変更 --EN:-- Changed Prince's return location
	proxy:ResetThink( chrId );
	proxy:ForceUpdateNextFrame( chrId );
	proxy:SendEventRequest( chrId, 0, 10 );
	
	--■10501■アイテム取得(会話で呼び出し)■ --EN:-- ■ 10501 ■ Get item (call in conversation) ■
	--proxy:NotNetMessage_begin();
		proxy:LuaCall(10501,0,"OnEvent_10501",once);--アイテム取得用ハンドラ追加 --EN:--Add item handler
	--proxy:NotNetMessage_end();
	
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 10502, "OnEvent_260_1", 5, 0, 2, once );
	proxy:NotNetMessage_end();
	
	
	print("SetRendolState_02 end");
end

function SetRendolState_02Init(proxy, param, chrId )
	print("SetRendolState_02Init begin");
	--王子有効化 --EN:--Prince enabled
	ValidCharactor( proxy, chrId );
	
	proxy:EnableLogic(chrId,true);--王子ロジックON --EN:--Oji logic ON
	proxy:ChangeInitPosAng( chrId , 2150 );--王子の帰還場所を変更 --EN:-- Changed Prince's return location
	proxy:Warp( chrId , 2150 );
	proxy:ResetThink( chrId );
	proxy:ForceUpdateNextFrame( chrId );
	--proxy:SendEventRequest( chrId, 0, 10 );	
	--■10501■アイテム取得(会話で呼び出し)■ --EN:-- ■ 10501 ■ Get item (call in conversation) ■
	--proxy:NotNetMessage_begin();
		proxy:LuaCall(10501,0,"OnEvent_10501",once);--アイテム取得用ハンドラ追加 --EN:--Add item handler
	--proxy:NotNetMessage_end();
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 10502, "OnEvent_260_1", 2, 0, 2, once );
	proxy:NotNetMessage_end();
	print("SetRendolState_02Init end");
end

function OnEvent_260_1(proxy,param)
	print("OnEvent_260_1 begin");
	proxy:SendEventRequest( 624, 0, AI_EVENT_None );
	print("OnEvent_260_1 end");
end

-------------------------------------------------------------------------------------------------
--王子が探索（王城１）状態--16002 --EN:--Prince exploring (Castle 1) state--16002
function SetRendolState_03(proxy,param,chrId)
	print("SetRendolState_03 begin");
	
	--王子有効化 --EN:--Prince enabled
	ValidCharactor( proxy, chrId );
	proxy:ChangeInitPosAng( chrId , 2150 );--王子の帰還場所を変更 --EN:-- Changed Prince's return location
	
	--移動タイプを往復に変更 --EN:--Movement type changed to round trip
	
	proxy:SetEventMovePointType( chrId, POINT_MOVE_TYPE_RoundTrip );
	proxy:ForceUpdateNextFrame( chrId );
	proxy:ClearTarget(chrId);
	proxy:ResetThink( chrId );
	
	--移動ポイントを変更 --EN:--Change movement point
	local point_list = {2010, 2011, 2012, 2013, 2012, 2011, 2014, 2015};
	local point_num = table.getn( point_list );
	for index = 1, point_num, 1 do
		--移動ポイントを設定 --EN:--set movement point
		proxy:AddCustomRoutePoint(chrId, point_list[index]);
	end
	
	--レンドル王子が探索だったら一定距離以上離れた時点で次の状態に遷移 --EN:--If Prince Lendl is searching, transition to the next state when it is more than a certain distance away
	if	proxy:IsClient() == false then
		if	proxy:IsCompleteEvent( 4096 ) == true then
			if	proxy:IsDistance( LOCAL_PLAYER, chrId, 20 ) == false then
				--フレームをずらして安全性の確保 --EN:--Stabilize the frame to ensure safety
				proxy:NotNetMessage_begin();
					proxy:OnKeyTime2( 301, "OnEvent_301", 0.0, 0, 2, once );
				proxy:NotNetMessage_end();
			else
				proxy:NotNetMessage_begin();
					proxy:OnPlayerDistanceOut( 301, LOCAL_PLAYER, chrId "OnEvent_301", 20, once );
				proxy:NotNetMessage_end();
			end
		end
	end

	print("SetRendolState_03 end");
end

function SetRendolState_03Init(proxy, param, chrId )
	print("SetRendolState_03Init begin");
	--王子有効化 --EN:--Prince enabled
	ValidCharactor( proxy, chrId );
	proxy:Warp( chrId, 2150);
	proxy:ChangeInitPosAng( chrId , 2150 );--王子の帰還場所を変更 --EN:-- Changed Prince's return location
	
	--移動タイプを往復に変更 --EN:--Movement type changed to round trip
	
	proxy:SetEventMovePointType( chrId, POINT_MOVE_TYPE_RoundTrip );
	proxy:ForceUpdateNextFrame( chrId );
	proxy:ClearTarget(chrId);
	proxy:ResetThink( chrId );
	
	--移動ポイントを変更 --EN:--Change movement point
	local point_list = {2010, 2011, 2012, 2013, 2012, 2011, 2014, 2015};
	local point_num = table.getn( point_list );
	for index = 1, point_num, 1 do
		--移動ポイントを設定 --EN:--set movement point
		proxy:AddCustomRoutePoint(chrId, point_list[index]);
	end
	
	--レンドル王子が探索だったら一定距離以上離れた時点で次の状態に遷移 --EN:--If Prince Lendl is searching, transition to the next state when it is more than a certain distance away
	if	proxy:IsClient() == false then
		if	proxy:IsCompleteEvent( 4096 ) == true then
			if	proxy:IsDistance( LOCAL_PLAYER, chrId, 20 ) == false then
				--フレームをずらして安全性の確保 --EN:--Stabilize the frame to ensure safety
				proxy:NotNetMessage_begin();
					proxy:OnKeyTime2( 301, "OnEvent_301", 0.0, 0, 2, once );
				proxy:NotNetMessage_end();
			else
				proxy:NotNetMessage_begin();
					proxy:OnPlayerDistanceOut( 301, LOCAL_PLAYER, chrId "OnEvent_301", 20, once );
				proxy:NotNetMessage_end();
			end
		end
	end
	print("SetRendolState_03Init end");
end

-------------------------------------------------------------------------------------------------
--王子が敵対（王城１）状態--16003 --EN:--Prince hostile (Royal Castle 1) state--16003
function SetRendolState_04(proxy,param,chrId)
	print("SetRendolState_04 begin");
	
	proxy:SendEventRequest( 624, 0, AI_EVENT_None );
	--移動タイプを往復に変更 --EN:--Movement type changed to round trip
	proxy:SetEventMovePointType( chrId, POINT_MOVE_TYPE_RoundTrip );
	proxy:ChangeInitPosAng( chrId , 2150 );--王子の帰還場所を変更 --EN:-- Changed Prince's return location
	
	--移動ポイントを変更 --EN:--Change movement point
	local point_list = {2010, 2011, 2012, 2013, 2012, 2011, 2014, 2015};
	local point_num = table.getn( point_list );
	for index = 1, point_num, 1 do
		--移動ポイントを設定 --EN:--set movement point
		proxy:AddCustomRoutePoint(chrId, point_list[index]);
	end
	
	proxy:SetTeamType( chrId, TEAM_TYPE_AngryFriend );
	proxy:EraseEventSpecialEffect_2( chrId , 5062 );
	--王子有効化 --EN:--Prince enabled
	ValidCharactor( proxy, chrId );
	
	print("SetRendolState_04 end");
end

function SetRendolState_04Init(proxy,param,chrId)
	print("SetRendolState_04Init begin");
	--移動タイプを往復に変更 --EN:--Movement type changed to round trip
	proxy:SendEventRequest( 624, 0, AI_EVENT_None );
	proxy:SetEventMovePointType( chrId, POINT_MOVE_TYPE_RoundTrip );
	proxy:ChangeInitPosAng( chrId , 2150 );--王子の帰還場所を変更 --EN:-- Changed Prince's return location
	proxy:Warp( chrId,2150);
	
	--移動ポイントを変更 --EN:--Change movement point
	local point_list = {2010, 2011, 2012, 2013, 2012, 2011, 2014, 2015};
	local point_num = table.getn( point_list );
	for index = 1, point_num, 1 do
		--移動ポイントを設定 --EN:--set movement point
		proxy:AddCustomRoutePoint(chrId, point_list[index]);
	end
	
	proxy:SetTeamType( chrId, TEAM_TYPE_AngryFriend );
	proxy:EraseEventSpecialEffect_2( chrId , 5062 );
	--王子有効化 --EN:--Prince enabled
	ValidCharactor( proxy, chrId );
	print("SetRendolState_04Init end");
end


--[[11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
---------------------------------------△△△王城１レンドル王子△△△------------------------------ --EN:--△△△ Royal Castle 1 Prince Lendor △△△------------------------------------------
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111]]




--[[22222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222
---------------------------------------▽▽▽王城２レンドル王子▽▽▽------------------------------ --EN:--▽▽▽Royal Castle 2 Prince Lendor▽▽▽-------------------------------
22222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222]]
function RendolRegistCondition_block2(proxy,param,chrId)
	print("RendolRegistCondition_block2 begin");
	if	proxy:IsCompleteEvent(RENDOL_STATE_DEAD) == false then
		if	proxy:IsCompleteEvent(RENDOL_STATE_HOSTILE_2) == false then
		--■723■王子が敵対する■ --EN:-- ■ 723 ■ The prince is hostile ■
			if proxy:IsCompleteEvent( 723 ) == false then
				--proxy:OnCharacterTotalDamage( 723, 620, LOCAL_PLAYER, 100, "OnEvent_723", once );
				proxy:OnCharacterTotalRateDamage( 723, 620, LOCAL_PLAYER, NPC_ANGRY_Rate, "OnEvent_723", once );
			end
		end
	--■720■レンドルが感謝する■ --EN:-- ■ 720 ■ Lendl appreciates ■
		--(初期化のタイミングで、監視を追加) --EN:--(A monitor is added at the timing of initialization)

	--■10800■王子が探索を開始する■(会話システムから呼び出し) --EN:-- ■ 10800 ■ The prince starts searching ■ (call from the conversation system)
		--(王子が感謝状態になったときに、監視を追加) --EN:--(Added monitoring when the prince is in gratitude state)



	--■724■王子が死ぬ■ --EN:-- ■ 724 ■ Prince dies ■
		if proxy:IsCompleteEvent( 724 ) == false then
			proxy:OnCharacterDead( 724 , 620 , "OnEvent_724" , once );
		end	
	end
	print("RendolRegistCondition_block2 end");
end

-------------------------------------------------------------------------------------------------
--王子が隠れているので助けて状態--16005 --EN:--The prince is hiding, so please help me--16005
function SetRendolState_05(proxy,param,chrId)
	print("SetRendolState_05 begin");
	--proxy:EnableLogic( chrId , false );--レンドル王子ロジックOFF(アイテム渡し待ち?) --EN:--Rendor Oji logic OFF (Waiting for item delivery?)
	--proxy:SetEventCommand( chrId , 40 );--EzStateに制御番号(怯える)を渡す。 --EN:-- Pass the control number (fear) to EzState.
	
--■643■レンドル王子呼びかけ範囲取得■	 --EN:--■643■Prince Lendl calling range acquisition■
	--proxy:SetEventFlag( 643 , 0 );--毎回追加されてほしいので･･･ --EN:--Because I want it to be added every time...
	SingleReset(proxy,643);
	proxy:NotNetMessage_begin();
		if proxy:IsClient() == false then
			proxy:OnRegionJustIn( 643 , LOCAL_PLAYER , 2340 , "OnEvent_643" , everytime );
			proxy:OnRegionJustOut( 643, LOCAL_PLAYER , 2340 , "OnEvent_643_out" , everytime );
		end
	proxy:NotNetMessage_end();
	
	--王子有効化 --EN:--Prince enabled
	ValidCharactor( proxy, chrId );	
	
	--■652■レンドル追っかけ兵士Aの有効化■ --EN:--■ 652 ■ Activation of Rendor Chasing Soldier A ■
	if proxy:IsCompleteEvent( 652 ) == false then		
		ValidCharactor( proxy,102);
	end
	
	--■654■レンドル追っかけ兵士Bの有効化■ --EN:--■ 654 ■ Activation of Rendor Chasing Soldier B ■
	if proxy:IsCompleteEvent( 654 ) == false then
		ValidCharactor( proxy,103);
	end

	--■655■レンドル追っかけ兵士Cの有効化■ --EN:--■ 655 ■ Activation of Rendor Chasing Soldier C ■
	if proxy:IsCompleteEvent( 655 ) == false then
		ValidCharactor( proxy,104);
	end

	--■656■レンドル追っかけ兵士Dの有効化■ --EN:-- ■ 656 ■ Activation of Rendor Chasing Soldier D ■
	if proxy:IsCompleteEvent( 656 ) == false then		
		ValidCharactor( proxy,105);		
	end

	--■657■レンドル追っかけ兵士Eの有効化■ --EN:--■ 657 ■ Activation of Rendor Chasing Soldier E ■
	if proxy:IsCompleteEvent( 657 ) == false then
		ValidCharactor( proxy,106);
	end

	--■658■レンドル追っかけ兵士Fの有効化■ --EN:--■ 658 ■ Activation of Rendor Chasing Soldier F ■
	if proxy:IsCompleteEvent( 658 ) == false then
		ValidCharactor( proxy,107);
	end
	--[[
	ValidCharactor( proxy, 102 );
	ValidCharactor( proxy, 103 );
	]]
	print("SetRendolState_05 end");
end

-------------------------------------------------------------------------------------------------
--王子が感謝（王城２）状態--16006 --EN:--Prince thanks (Castle 2) state--16006
function SetRendolState_06(proxy,param,chrId)
	print("SetRendolState_06 begin");
	--proxy:EnableLogic( chrId , false );--レンドル王子ロジックOFF(アイテム渡し待ち?) --EN:--Rendor Oji logic OFF (Waiting for item delivery?)
	proxy:SetSpStayAndDamageAnimId( chrId,-1,-1);
	
	if proxy:IsCompleteEvent( 10800 ) == false then
		proxy:NotNetMessage_begin();
			proxy:LuaCall( 10800 , 0 , "OnEvent_10800" , once );--会話システムから呼ぶ場合にはparam=0 --EN:--param=0 when calling from the conversation system
		proxy:NotNetMessage_end();
	end
	
	--王子有効化 --EN:--Prince enabled
	ValidCharactor( proxy, chrId );
	
	--[[
	--その場で消えられない様に距離でチェックをかけておく --EN:--Check the distance so that it doesn't disappear on the spot
	if	proxy:IsDistance(LOCAL_PLAYER, 102, 20) == true then
		ValidCharactor( proxy, 102 );
	end
	if	proxy:IsDistance(LOCAL_PLAYER, 103, 20) == true then
		ValidCharactor( proxy, 103 );
	end
	]]
	print("SetRendolState_06 end");
end
-------------------------------------------------------------------------------------------------
--王子が探索（王城２）状態--16007 --EN:--Prince Exploring (Castle 2) State--16007
function SetRendolState_07(proxy,param,chrId)
	print("SetRendolState_07 begin");
	-----------------レンドル王子状態スキップチェック----------------------- --EN:--Lendl Prince State Skip Check-----------------------
	--王の盾が死んでる --EN:--The king's shield is dead
	if	proxy:IsCompleteEvent(4224) == true then
		--既に王の盾が死んでいたので王城３の状態へ --EN:--Since the King's Shield was already dead, go to Castle 3
		if	proxy:IsCompleteEvent( 1041 ) == false then
			print("SetRendolState_07 レンドル王子　王の盾が死んでいたので、王城３の状態へ移行"); --EN:print("SetRendolState_07 Prince Rendol. The King's Shield is dead, so move to Castle 3 state");
			SetNpcStateFlag( proxy, param, rendol_flag_list, RENDOL_STATE_LOCATION_INVISIBLE );
			proxy:OnKeyTime2( SYSTEM_CHECK_POINT, "RendolCheck", 0.0, 0, 2, once );
			
		--既に王城３のレバー扉が開いていたので王城４の状態へ --EN:--Since the lever door of the castle 3 was already open, go to the state of the castle 4
		else
			print("SetRendolState_07 レンドル王子　王城３レバー扉が開いているので、王城４の状態へ移行"); --EN:print("SetRendolState_07 Prince Rendol, since the castle 3 lever door is open, shift to the state of royal castle 4");
			SetNpcStateFlag( proxy, param, rendol_flag_list, RENDOL_STATE_LIFT_FRONT );
			proxy:OnKeyTime2( SYSTEM_CHECK_POINT, "RendolCheck", 0.0, 0, 2, once );
		end
	end
	
	--王子有効化 --EN:--Prince enabled
	ValidCharactor( proxy, chrId );
	proxy:SetSpStayAndDamageAnimId( chrId,-1,-1);
	--移動タイプを往復に変更 --EN:--Movement type changed to round trip
	proxy:SetEventMovePointType( chrId, POINT_MOVE_TYPE_RoundTrip );
	
	--移動ポイントを変更 --EN:--Change movement point
	local point_list = {2220, 2221, 2222, 2223};
	local point_num = table.getn( point_list );
	for index = 1, point_num, 1 do
		--移動ポイントを設定 --EN:--set movement point
		proxy:AddCustomRoutePoint(chrId, point_list[index]);
	end
	
	--[[
	--その場で消えられない様に距離でチェックをかけておく --EN:--Check the distance so that it doesn't disappear on the spot
	if	proxy:IsDistance(LOCAL_PLAYER, 102, 20) == true then
		ValidCharactor( proxy, 102 );
	end
	if	proxy:IsDistance(LOCAL_PLAYER, 103, 20) == true then
		ValidCharactor( proxy, 103 );
	end
	]]
	print("SetRendolState_07 end");
end

-------------------------------------------------------------------------------------------------
--王子が敵対（王城２）状態--16008 --EN:--Prince hostile (Royal Castle 2) state--16008
function SetRendolState_08(proxy,param,chrId)
	print("SetRendolState_08 begin");
	
	print("レンドル王子が敵になりました"); --EN:print("Prince Lendl has become an enemy");
	proxy:EnableLogic( chrId , true );--[[レンドル王子ロジックON(ロジック切り替え?)]] --EN:--[[Prince Lendl logic ON (logic switching?)]]
	--proxy:SetEventCommand( chrId , 41 );--EzStateに制御番号(怯え終了)を渡す。 --EN:-- Pass the control number (terrified end) to EzState.
	proxy:SetTeamType( chrId, TEAM_TYPE_AngryFriend );
	proxy:EraseEventSpecialEffect_2( chrId , 5062 );
	--王子有効化 --EN:--Prince enabled
	ValidCharactor( proxy, chrId );
	--[[
	--その場で消えられない様に距離でチェックをかけておく --EN:--Check the distance so that it doesn't disappear on the spot
	if	proxy:IsDistance(LOCAL_PLAYER, 102, 40) == true then
		ValidCharactor( proxy, 102 );
	end
	if	proxy:IsDistance(LOCAL_PLAYER, 103, 40) == true then
		ValidCharactor( proxy, 103 );
	end
	]]
	print("SetRendolState_08 end");
end


--[[22222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222
---------------------------------------△△△王城２レンドル王子△△△------------------------------ --EN:--△△△ Royal Castle 2 Prince Lendor△△△------------------------------
22222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222]]


--[[33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
---------------------------------------▽▽▽王城３レンドル王子▽▽▽------------------------------ --EN:--▽▽▽Royal Castle 3 Prince Lendor▽▽▽------------------------------
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333]]
function RendolRegistCondition_block3(proxy,param,chrId)
	print("RendolRegistCondition_block3 begin");
	if	proxy:IsCompleteEvent(RENDOL_STATE_DEAD) == false then
		if	proxy:IsCompleteEvent(RENDOL_STATE_HOSTILE_3_FRONT_GATE) == false and
			proxy:IsCompleteEvent(RENDOL_STATE_HOSTILE_3_BACK_GATE) == false then
		--■1316■王子が敵対する(城門前)■ --EN:-- ■ 1316 ■ The prince is hostile (in front of the castle gate) ■
			if proxy:IsCompleteEvent( 1316 ) == false then
				--proxy:OnCharacterTotalDamage( 1316 , 621 , LOCAL_PLAYER , 100 , "OnEvent_1316" , once );
				proxy:OnCharacterTotalRateDamage( 1316, 621, LOCAL_PLAYER, NPC_ANGRY_Rate, "OnEvent_1316", once );
			end
		
		--■1317■王子が敵対する(城門後ろ)■ --EN:-- ■ 1317 ■ The prince is hostile (behind the castle gate) ■
			if proxy:IsCompleteEvent( 1317 ) == false then
				--proxy:OnCharacterTotalDamage( 1317 , 621 , LOCAL_PLAYER , 100 , "OnEvent_1317" , once );
				proxy:OnCharacterTotalRateDamage( 1317, 621, LOCAL_PLAYER, NPC_ANGRY_Rate, "OnEvent_1317", once );
			end
		end


	--■11501■王子が探索を開始する■(会話システムから呼び出し) --EN:-- ■ 11501 ■ The prince starts searching ■ (call from the conversation system)
		if proxy:IsCompleteEvent( 11501 ) == false then
			proxy:NotNetMessage_begin();
				proxy:LuaCall( 11501 , 0 , "OnEvent_11501" , once );
			proxy:NotNetMessage_end();
		end

		
	--■1318■王子が死亡する■ --EN:-- ■ 1318 ■ Prince dies ■
		if proxy:IsCompleteEvent( 1318 ) == false then
			proxy:OnCharacterDead( 1318, 621, "OnEvent_1318", once );
		end
		
	--■1338■王子会話用領域判定■ --EN:-- ■ 1338 ■ Area judgment for prince conversation ■
		SingleReset( proxy,1338 );
		if proxy:IsCompleteEvent( 1338 ) == false then
			proxy:NotNetMessage_begin();
				proxy:OnRegionJustIn( 1338, 621 , 2416 , "OnEvent_1338_in",everytime);
				proxy:OnRegionJustOut( 1338 , 621 , 2416 , "OnEvent_1338_out",everytime);
			proxy:NotNetMessage_end();
		end
		
	end
	print("RendolRegistCondition_block3 end");
end


-------------------------------------------------------------------------------------------------
--王子が見えない場所にこっそり状態--16009 --EN:--Stealth in a place where the prince can't be seen--16009
function SetRendolState_09(proxy,param,chrId)
	print("SetRendolState_09 begin");
--■1310■王子が門の前に移動する■ --EN:--■1310■The prince moves in front of the gate■
	--必ず追加する --EN:--must add
	proxy:SetEventFlag( 1310, false );
	proxy:OnRegionJustIn( 1310 , LOCAL_PLAYER , 2550 , "OnEvent_1310" , once );
--■1312■王子が袋小路に到着したあとに怯えさせる■ --EN:-- ■ 1312 ■ frighten the prince after arriving at the dead end ■
	if proxy:IsCompleteEvent( 1312 ) == false then
		proxy:OnRegionJustIn( 1312 , chrId , 2553 , "OnEvent_1312" , once );
	end
--■1349■王子が門の前まで到着したけど、門は閉まっていた --EN:--■1349■The prince arrived in front of the gate, but the gate was closed.
	if	proxy:IsCompleteEvent( 1349 ) == false then
		proxy:OnRegionJustIn( 1349, chrId, 2415, "OnEvent_1349", once );
	end
	--王子有効化 --EN:--Prince enabled
	ValidCharactor( proxy, chrId );
	print("SetRendolState_09 end");
end

-------------------------------------------------------------------------------------------------
--王子が門を開けて欲しい状態--16010 --EN:--The state where the prince wants the gate to be opened--16010
function SetRendolState_10(proxy,param,chrId)
	print("SetRendolState_10 begin");
	--proxy:DisableInterupt( chrId, true );--割り込みを遮断(敵に攻撃されても戦闘ロジックにしないため) --EN:--Block interruptions (because it does not turn into battle logic even if attacked by the enemy)

	proxy:ChangeInitPosAng( chrId , 2552 );--巣を門の前の領域にする --EN:--Make the nest the area in front of the gate
	proxy:EnableLogic( chrId , true );--ロジックON --EN:--Logic ON
	proxy:SendEventRequest( chrId, 0, AI_EVENT_None );
	proxy:ResetThink( chrId );
	if	proxy:IsDistance( LOCAL_PLAYER, chrId, 20 ) == false then
		proxy:Warp( chrId , 2552 );--初期位置にワープ --EN:--Warp to initial position
	end
	proxy:NotNetMessage_begin();
		----▼王子を追う敵が出現する1▼ --EN:--▼ An enemy chasing the prince appears 1 ▼
		--proxy:OnKeyTime2( 1350 , "OnEvent_1350" , 2.0 , 0 , 1 , once );
		
		--■1312■王子が袋小路に到着したあとに怯えさせる■ --EN:-- ■ 1312 ■ frighten the prince after arriving at the dead end ■
		if proxy:IsCompleteEvent( 1312 ) == false then
			proxy:OnRegionJustIn( 1312 , 621 , 2553 , "OnEvent_1312" , once );
		end
	proxy:NotNetMessage_end();
	
	--王子有効化 --EN:--Prince enabled
	ValidCharactor( proxy, chrId );
	print("SetRendolState_10 end");
end

-------------------------------------------------------------------------------------------------
--王子が袋小路で怯え状態--16011 --EN:--Prince frightened in a dead end--16011
function SetRendolState_11(proxy,param,chrId)
	print("SetRendolState_11 begin");
	proxy:ChangeInitPosAng( chrId , 2553 );--巣を袋小路の領域にする --EN:--Make the nest a cul-de-sac area
	if	proxy:IsDistance( LOCAL_PLAYER, chrId, 20 ) == false then
		proxy:ForceUpdateNextFrame( chrId );
		proxy:Warp( chrId , 2553 );--初期位置にワープ --EN:--Warp to initial position
		print("レンドルワープ　2553"); --EN:print("Lendl Warp 2553");
	end
	--proxy:EnableLogic( chrId , false );--ロジックOFF --EN:--Logic OFF
	--proxy:SetEventCommand( chrId, 40 );--怯える --EN:--Fear
	proxy:SetSpStayAndDamageAnimId(chrId,7600,9600);
	
	proxy:NotNetMessage_begin();
		proxy:NotNetMessage_begin();
			--▼王子を追う敵の巣を変える1▼ --EN:--▼ Change the nest of the enemy chasing the prince 1▼
			proxy:OnKeyTime2( 1360 , "OnEvent_1360" ,  5.0 , 0 , 1 , once );		
			--▼王子を追う敵の巣を変える2▼ --EN:--▼Change the nest of the enemy chasing the prince 2▼
			proxy:OnKeyTime2( 1361 , "OnEvent_1361" ,  8.0 , 0 , 1 , once );		
			--▼王子を追う敵の巣を変える3▼ --EN:--▼ Change the nest of the enemy chasing the prince 3 ▼
			proxy:OnKeyTime2( 1362 , "OnEvent_1362" , 11.0 , 0 , 1 , once );
		proxy:NotNetMessage_end();
		--■1312■王子が袋小路に到着したあとに怯えさせる■ --EN:-- ■ 1312 ■ frighten the prince after arriving at the dead end ■
		if proxy:IsCompleteEvent( 1312 ) == false then
			proxy:OnRegionJustIn( 1312 , chrId , 2553 , "OnEvent_1312" , once );
		end
	proxy:NotNetMessage_end();
	
	--王子有効化 --EN:--Prince enabled
	ValidCharactor( proxy, chrId );
	print("SetRendolState_11 end");
end

-------------------------------------------------------------------------------------------------
--王子が感謝（王城３）状態--16012 --EN:--Prince thanks (Castle 3) state--16012
function SetRendolState_12(proxy,param,chrId)
	print("SetRendolState_12 begin");
	proxy:ChangeInitPosAng( chrId , 2555 );--巣を袋小路の領域にする --EN:--Make the nest a cul-de-sac area
	
	if	proxy:IsDistance( LOCAL_PLAYER, chrId, 20 ) == false then
		proxy:Warp( chrId , 2555 );--初期位置にワープ --EN:--Warp to initial position
	end
	--proxy:EnableLogic( chrId, false );--ロジックOFF --EN:--Logic OFF
	
	proxy:DisableInterupt( chrId, false );--割り込みを有効 --EN:--enable interrupts
	--proxy:SetEventCommand( chrId , 41 );--EzStateに制御番号を送る(怯え終了) --EN:--Send control number to EzState (finish frightened)
	proxy:SetSpStayAndDamageAnimId(chrId,-1,-1);
	
	--王子有効化 --EN:--Prince enabled
	ValidCharactor( proxy, chrId );
	print("SetRendolState_12 end");
end

-------------------------------------------------------------------------------------------------
--王子が探索（王城３）状態--16013 --EN:--Prince exploring (Castle 3) state--16013
function SetRendolState_13(proxy,param,chrId)
	print("SetRendolState_13 begin");
	
	--王子有効化 --EN:--Prince enabled
	ValidCharactor( proxy, chrId );
	
	proxy:EnableLogic( chrId , true );--レンドル王子、探索状態で歩き出す --EN:--Prince Lendl starts walking in exploration mode
	proxy:ResetThink( chrId );
	proxy:ChangeInitPosAng( chrId , 2555 );--巣を袋小路の領域にする --EN:--Make the nest a cul-de-sac area
	proxy:ForceUpdateNextFrame( chrId );
	proxy:ClearTarget(chrId);
	proxy:SendEventRequest( chrId, 0, AI_EVENT_None );
	proxy:SetSpStayAndDamageAnimId(chrId,-1,-1);
	
	
	if	proxy:IsDistance( LOCAL_PLAYER, chrId, 20 ) == false then
		proxy:Warp( chrId , 2555 );--初期位置にワープ --EN:--Warp to initial position
	end
	
	--移動タイプを往復に変更 --EN:--Movement type changed to round trip
	proxy:SetEventMovePointType( chrId, POINT_MOVE_TYPE_RoundTrip );
	
	--移動ポイントを変更 --EN:--Change movement point
	local point_list = {2410, 2411, 2412, 2413, 2414};
	local point_num = table.getn( point_list );
	for index = 1, point_num, 1 do
		--移動ポイントを設定 --EN:--set movement point
		proxy:AddCustomRoutePoint(chrId, point_list[index]);
	end
	
	
	print("SetRendolState_13 end");
end

-------------------------------------------------------------------------------------------------
--王子が敵対（王城３）城門の前状態--16014 --EN:--The prince is hostile (Castle 3) Before the castle gate--16014
function SetRendolState_14(proxy,param,chrId)
	print("SetRendolState_14 begin");
	proxy:ChangeInitPosAng( chrId , 2552 );--巣を袋小路の領域にする --EN:--Make the nest a cul-de-sac area
	if	proxy:IsDistance( LOCAL_PLAYER, chrId, 60 ) == false then
		proxy:Warp( chrId , 2552 );--初期位置にワープ --EN:--Warp to initial position
	end
	proxy:SetTeamType( chrId, TEAM_TYPE_AngryFriend );
	proxy:EraseEventSpecialEffect_2( chrId , 5063 );
	proxy:EnableLogic( chrId , true );--ロジックON --EN:--Logic ON
	proxy:SendEventRequest( chrId , 0 , AI_EVENT_None );--ロジックを切り替えてたのをやめる。 --EN:--Stop switching logic.
	proxy:SetSpStayAndDamageAnimId(chrId,-1,-1);
	proxy:ResetThink( chrId );
	
	--王子有効化 --EN:--Prince enabled
	ValidCharactor( proxy, chrId );
	print("SetRendolState_14 end");
end

-------------------------------------------------------------------------------------------------
--王子が敵対（王城３）城門の後ろ状態--16015 --EN:--Prince is hostile (Castle 3) Behind the castle gate--16015
function SetRendolState_15(proxy,param,chrId)
	print("SetRendolState_15 begin");
	proxy:ChangeInitPosAng( chrId , 2555 );--巣を袋小路の領域にする --EN:--Make the nest a cul-de-sac area
	if	proxy:IsDistance( LOCAL_PLAYER, chrId, 60 ) == false then
		proxy:Warp( chrId , 2555 );--初期位置にワープ --EN:--Warp to initial position
	end
	proxy:SetTeamType( chrId, TEAM_TYPE_AngryFriend );
	proxy:EraseEventSpecialEffect_2( chrId , 5063 );
	proxy:SetSpStayAndDamageAnimId(621,-1,-1);
	proxy:EnableLogic( chrId , true );--ロジックON --EN:--Logic ON
	proxy:SendEventRequest( chrId , 0 , AI_EVENT_None );--ロジックを切り替えてたのをやめる。 --EN:--Stop switching logic.
	proxy:ResetThink( chrId );
	
	--王子有効化 --EN:--Prince enabled
	ValidCharactor( proxy, chrId );
	print("SetRendolState_15 end");
end

--[[33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
---------------------------------------△△△王城３レンドル王子△△△------------------------------ --EN:--△△△ Royal Castle 3 Prince Lendor △△△------------------------------------------
3333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333]]



--[[44444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444
---------------------------------------▽▽▽王城４レンドル王子▽▽▽------------------------------ --EN:--▽▽▽Royal Castle 4 Prince Lendor▽▽▽------------------------------
44444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444]]
function RendolRegistCondition_block4(proxy,param,chrId)
	print("RendolRegistCondition_block4 begin");
	
	if	proxy:IsCompleteEvent(RENDOL_STATE_DEAD) == false then
	--王城４でのレンドル王子の敵対監視はなくなりました。 --EN:--Prince Lendl's hostile oversight in Royal Castle 4 is gone.
--~ 		if	proxy:IsCompleteEvent(RENDOL_STATE_HOSTILE_4_LIFT_FRONT) == false then
--~ 			--レンドル王子敵対監視 --EN:--Prince Lendl Hostile Watch
--~ 			--proxy:OnCharacterTotalDamage( 1702, 626, LOCAL_PLAYER, 100, "OnEvent_1702", once );
--~ 			--proxy:OnCharacterTotalRateDamage( 1702, 626, LOCAL_PLAYER, NPC_ANGRY_Rate, "OnEvent_1702", once );
--~ 		end
		proxy:OnCharacterDead( 1700, 626, "OnEvent_1700", once );
		
		--会話呼び出しハンドラ --EN:--conversation call handler
		if	proxy:IsCompleteEvent(11790) == false then			
			proxy:LuaCall( 11790, 0, "OnEvent_11790", everytime );
		end
	end
	print("RendolRegistCondition_block4 end");
end

-------------------------------------------------------------------------------------------------
--王子がエレベータ前状態--16016 --EN:--Prince before elevator--16016
function SetRendolState_16(proxy,param,chrId)
	print("SetRendolState_16 begin");
	proxy:SetHp( chrId, 0.001);
	
	--王子有効化 --EN:--Prince enabled
	ValidCharactor( proxy, chrId );
	print("SetRendolState_16 end");
end
-------------------------------------------------------------------------------------------------
--王子が敵対（王城４）状態--16017 --EN:--Prince hostile (Royal Castle 4) state--16017
function SetRendolState_17(proxy,param,chrId)
	print("SetRendolState_17 begin");
	
	proxy:SetTeamType( chrId, TEAM_TYPE_AngryFriend );
	
	--王子有効化 --EN:--Prince enabled
	ValidCharactor( proxy, chrId );
	print("SetRendolState_17 end");
end
-------------------------------------------------------------------------------------------------
--王子が敵対（石柱）状態--16018 --EN:--Prince is hostile (stone pillar) state--16018
function SetRendolState_18(proxy,param,chrId)
	print("SetRendolState_16 begin");
	print("SetRendolState_18 end");
end

--[[44444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444
---------------------------------------△△△王城４レンドル王子△△△------------------------------ --EN:--△△△Royal Castle 4 Prince Lendor△△△------------------------------
44444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444]]


--[[-----------------------------------------------------------------------------------------------------------------------------------------
	レンドル王子関連　ここまで --EN:Related to Prince Lendl So far
-----------------------------------------------------------------------------------------------------------------------------------------]]





--[[-----------------------------------------------------------------------------------------------------------------------------------------
	ビヨルングルム関連　ここから --EN:Related to Bjrn Grum From here
-----------------------------------------------------------------------------------------------------------------------------------------]]
function BiyoCheck(proxy,param)
	BiyoCheck2(proxy,param,true);
end

function BiyoCheck2(proxy,param,flag)
	print("BiyoCheck begin");
	
	local biyo_id_2 = 622;--王城２のビヨルングルム --EN:--Bjrn Grum of the Royal Castle 2
	local biyo_id_3 = 627;--王城３のビヨルングルム --EN:--Bjrn Grum of the Royal Castle 3
	local biyo_id_4 = 698;--王城４のビヨルングルム --EN:--Bjrn Grum of the Royal Castle 4
	
	local biyo_block2_acid_list = { 525, 526, 521, 522, 527 , 530};
	local biyo_block3_acid_list = { 1432, 1433, 1460};
	local biyo_block4_acid_list = { 1711, 1712, 1717};
	
	--王城2のビヨのデフォルトを味方に変更 --EN:--Changed the default of Beyo in Ojo 2 to be an ally
	proxy:SetTeamType( biyo_id_2 , TEAM_TYPE_Friend );	
	
	--一旦全員消しておく --EN:-- Erase all of them for now
	InvalidCharactor(proxy,biyo_id_2);
	InvalidCharactor(proxy,biyo_id_3);
	InvalidCharactor(proxy,biyo_id_4);
	
	--監視を一旦全削除 --EN:--Delete all monitors once
	DeleteConditionList(proxy,biyo_block2_acid_list);
	DeleteConditionList(proxy,biyo_block3_acid_list);
	DeleteConditionList(proxy,biyo_block4_acid_list);
	
	
	
	SetFirstNpcStateFlag( proxy, param, biyo_flag_list, BIYO_STATE_CAPTIVE );
	
	----------------------------------------------------------------------------------------------------------------
	--ビヨルングルムが牢屋に囚われ状態--16060 --EN:--Bjrngurm in prison--16060
	if	proxy:IsCompleteEvent(BIYO_STATE_CAPTIVE) == true then
		print("biyo state BIYO_STATE_CAPTIVE");
		SetBiyoState_01(proxy, param, biyo_id_2 );
		BiyoRegistCondition_block2(proxy,param,biyo_id_2);
		
	----------------------------------------------------------------------------------------------------------------
	--ビヨルングルムが解放してくれて感謝状態--16061 --EN:--Grateful state for Bjrn Grum's release--16061
	elseif	proxy:IsCompleteEvent(BIYO_STATE_THANKS) == true then
		print("biyo state BIYO_STATE_THANKS");
		SetBiyoState_02(proxy, param, biyo_id_2 );
		BiyoRegistCondition_block2(proxy,param,biyo_id_2);
		
	----------------------------------------------------------------------------------------------------------------
	--ビヨルングルムが牢屋で寝ている状態--16062 --EN:--Bjrngurm sleeping in prison--16062
	elseif	proxy:IsCompleteEvent(BIYO_STATE_SLEEPING_IN_PRISON) == true then
		print("biyo state BIYO_STATE_SLEEPING_IN_PRISON");
		if flag == true then 
			SetBiyoState_03(proxy, param, biyo_id_2 );
		else
			SetBiyoState_03Init(proxy , param , biyo_id_2 );
		end
		BiyoRegistCondition_block2(proxy,param,biyo_id_2);		
		
	----------------------------------------------------------------------------------------------------------------
	--ビヨルングルムが敵対(牢内)状態--16063 --EN:--Bjrn Grum is hostile (in prison)--16063
	elseif	proxy:IsCompleteEvent(BIYO_STATE_HOSTILE_IN_PRISON) == true then
		print("biyo state BIYO_STATE_HOSTILE_IN_PRISON");
		SetBiyoState_04(proxy, param, biyo_id_2 );
		BiyoRegistCondition_block2(proxy,param,biyo_id_2);
		
	----------------------------------------------------------------------------------------------------------------
	--ビヨルングルムが死んでいる状態--16064 --EN:--Bjrn Grum is dead--16064
	elseif	proxy:IsCompleteEvent(BIYO_STATE_DEAD) == true then
		print("biyo state BIYO_STATE_DEAD");
		--ここでは追加も設定もしない --EN:--Do not add or set here
		
	----------------------------------------------------------------------------------------------------------------
	--ビヨルングルムが獄吏を倒したい状態--16065 --EN:--Bjrn Grum wants to defeat the jailer--16065
	elseif	proxy:IsCompleteEvent(BIYO_STATE_TARGET_ENEMY) == true then
		print("biyo state BIYO_STATE_TARGET_ENEMY");
		SetBiyoState_05(proxy, param, biyo_id_2 );
		BiyoRegistCondition_block2(proxy,param,biyo_id_2);
		
	----------------------------------------------------------------------------------------------------------------
	--ビヨルングルムが逆襲が終わって満足して寝る状態--16066 --EN:--Bjrn Grum is sleeping satisfied after the counterattack is over--16066
	elseif	proxy:IsCompleteEvent(BIYO_STATE_END_OF_STRIKES_BACK) == true then
		print("biyo state BIYO_STATE_END_OF_STRIKES_BACK");
		if flag == true then
			SetBiyoState_06(proxy, param, biyo_id_2 );
		else
			SetBiyoState_06Init(proxy, param, biyo_id_2 );		
		end
		BiyoRegistCondition_block2(proxy,param,biyo_id_2);
		
	----------------------------------------------------------------------------------------------------------------
	--ビヨルングルムが敵対(城壁)状態--16067 --EN:--Bjrngurm is hostile (wall)--16067
	elseif	proxy:IsCompleteEvent(BIYO_STATE_HOSTILE_IN_RAMPART) == true then
		print("biyo state BIYO_STATE_HOSTILE_IN_RAMPART");
		SetBiyoState_07(proxy, param, biyo_id_2 );
		BiyoRegistCondition_block2(proxy,param,biyo_id_2);
		
	----------------------------------------------------------------------------------------------------------------
	--ビヨルングルムが王城3を探索状態--16068 --EN:--Bjrn Grum exploring Royal Castle 3--16068
	elseif	proxy:IsCompleteEvent(BIYO_STATE_SEARCH_3) == true then
		print("biyo state BIYO_STATE_SEARCH_3");
		SetBiyoState_08(proxy, param, biyo_id_3 );
		BiyoRegistCondition_block3(proxy,param,biyo_id_3);
		
	----------------------------------------------------------------------------------------------------------------
	--ビヨルングルムが王の剣を倒して満足状態--16069 --EN:--Bjrngurm defeats the King's Sword and is satisfied--16069
	elseif	proxy:IsCompleteEvent(BIYO_STATE_KING_OF_SWORD_KILL) == true then
		print("biyo state BIYO_STATE_KING_OF_SWORD_KILL");
		if flag == true then
			SetBiyoState_09(proxy, param, biyo_id_3 );
		else
			SetBiyoState_09Init(proxy, param, biyo_id_3 );
		end
		BiyoRegistCondition_block3(proxy,param,biyo_id_3);
		
	----------------------------------------------------------------------------------------------------------------
	--ビヨルングルムが敵対(王の剣の部屋)状態--16070 --EN:--Bjrngurm is hostile (King's Sword Room)--16070
	elseif	proxy:IsCompleteEvent(BIYO_STATE_HOSTILE_IN_KING_ROOM) == true then
		print("biyo state BIYO_STATE_HOSTILE_IN_KING_ROOM");
		SetBiyoState_10(proxy, param, biyo_id_3 );
		BiyoRegistCondition_block3(proxy,param,biyo_id_3);
		
	----------------------------------------------------------------------------------------------------------------
	--ビヨルングルムが王の剣の部屋で寝る状態--16071 --EN:--Bjrngurm sleeping in the King's Sword Room--16071
	elseif	proxy:IsCompleteEvent(BIYO_STATE_KING_ROOM_DOWN) == true then
		print("biyo state BIYO_STATE_KING_ROOM_DOWN");
		SetBiyoState_11(proxy, param, biyo_id_3 );
		BiyoRegistCondition_block3(proxy,param,biyo_id_3);
		
	----------------------------------------------------------------------------------------------------------------
	--ビヨルングルムが飛竜の長と戦う状態--16072 --EN:--Bjrngurm fighting against the wyvern chief--16072
	elseif	proxy:IsCompleteEvent(BIYO_STATE_BATTLE_FLY_DRAGON) == true then
		print("biyo state BIYO_STATE_BATTLE_FLY_DRAGON");
		SetBiyoState_12(proxy, param, biyo_id_4 );
		BiyoRegistCondition_block4(proxy,param,biyo_id_4);
		
	----------------------------------------------------------------------------------------------------------------
	--ビヨルングルムが石柱に戻りたい状態--16073 --EN:--Bjrngurm wants to return to the stone pillar--16073
	elseif	proxy:IsCompleteEvent(BIYO_STATE_RETURN_TO_STONE_PILLAR) == true then
		print("biyo state BIYO_STATE_RETURN_TO_STONE_PILLAR");
		SetBiyoState_13(proxy, param, biyo_id_4 );
		BiyoRegistCondition_block4(proxy,param,biyo_id_4);
		
	----------------------------------------------------------------------------------------------------------------
	--ビヨルングルムが石柱にいる状態--16074 --EN:--Bjrn Grum in stone pillar--16074
	elseif	proxy:IsCompleteEvent(BIYO_STATE_WAIT_M1) == true then
		print("biyo state BIYO_STATE_WAIT_M1");
		
	----------------------------------------------------------------------------------------------------------------
	--ビヨルングルムが敵対(石柱)状態--16075 --EN:--Bjrn Grum is hostile (stone pillar) state--16075
	elseif	proxy:IsCompleteEvent(BIYO_STATE_HOSTILE_IN_STONE_PILLAR) == true then
		print("biyo state BIYO_STATE_HOSTILE_IN_STONE_PILLAR");
		
	----------------------------------------------------------------------------------------------------------------
	--ビヨルングルムが敵対(ゲート前)状態--16076 --EN:--Bjrn Grum is hostile (before the gate)--16076
	elseif	proxy:IsCompleteEvent(BIYO_STATE_HOSTILE_IN_GATE_FRONT) == true then
		print("biyo state BIYO_STATE_HOSTILE_IN_GATE_FRONT");
		SetBiyoState_16(proxy, param, biyo_id_4 );
		BiyoRegistCondition_block4(proxy,param,biyo_id_4);
		
	----------------------------------------------------------------------------------------------------------------
	--ビヨルングルムがもういない状態--16077 --EN:--Bjorn Grum is no more--16077
	elseif	proxy:IsCompleteEvent(BIYO_STATE_EXIT) == true then
		print("biyo state BIYO_STATE_EXIT");
	end
	
	print("BiyoCheck end");
end

--[[44444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444
---------------------------------------▽▽▽王城２ビヨルングルム▽▽▽------------------------------ --EN:--▽▽▽Castle 2 Bjrn Grum ▽▽▽------------------------------
44444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444]]

function BiyoRegistCondition_block2(proxy,param,chrId)
	print("BiyoRegistCondition_block2 begin");
	if	proxy:IsCompleteEvent( BIYO_STATE_DEAD ) == false then
		if	proxy:IsCompleteEvent(BIYO_STATE_HOSTILE_IN_PRISON ) == false and
			proxy:IsCompleteEvent(BIYO_STATE_HOSTILE_IN_RAMPART) == false then
			
			--■525■ビヨが牢内で敵になる■ --EN:-- ■ 525 ■ Biyo becomes an enemy in prison ■
			if proxy:IsCompleteEvent( 525 ) == false then
				--proxy:OnCharacterTotalDamage( 525 , 622 , LOCAL_PLAYER , 100 , "OnEvent_525" , once );
				proxy:OnCharacterTotalRateDamage( 525, 622, LOCAL_PLAYER, NPC_ANGRY_Rate, "OnEvent_525", once );
			end
			
			--■526■ビヨが城壁で敵になる■ --EN:-- ■ 526 ■ Biyo becomes an enemy at the castle wall ■
			if proxy:IsCompleteEvent( 526 ) == false then
				--proxy:OnCharacterTotalDamage( 526 , 622 , LOCAL_PLAYER , 100 , "OnEvent_526" , once );
				proxy:OnCharacterTotalRateDamage( 526, 622, LOCAL_PLAYER, NPC_ANGRY_Rate, "OnEvent_526", once );
			end
		end

		--■521■ビヨが獄吏を倒しに行く■(会話システムから呼び出し) --EN:--■521■Biyo goes to defeat the jailer■(call from conversation system)
		if proxy:IsCompleteEvent( 521 ) == false then
				proxy:LuaCall( 521 , 0 , "OnEvent_521" , once );--会話システムから呼び出す場合はparam=0を指定 --EN:--Specify param=0 when calling from the conversation system
		end
		--■522■ビヨが牢屋内で寝る■(会話システムから呼び出し) --EN:--■522■Byo sleeps in prison■ (call from conversation system)
		if proxy:IsCompleteEvent( 522 ) == false then
				proxy:LuaCall( 522 , 0 , "OnEvent_522" , once );--会話システムから呼び出す場合はparam=0を指定 --EN:--Specify param=0 when calling from the conversation system
		end

		--■527■ビヨ死亡■ --EN:-- ■ 527 ■ Biyo died ■
		if proxy:IsCompleteEvent( 527 ) == false then
			proxy:OnCharacterDead(527,622,"OnEvent_527",once);
		end
		
		--■530■ビヨが逆襲に満足して寝る■(会話システムから呼び出し) --EN:--■530■Biyo is satisfied with the counterattack and goes to bed■(call from conversation system)
		proxy:LuaCall( 530, 0, "OnEvent_530", everytime );--会話システムから呼び出す場合はparam=0を指定 --EN:--Specify param=0 when calling from the conversation system
	end
	print("BiyoRegistCondition_block2 end");
end


----------------------------------------------------------------------------------------------------------------
--ビヨルングルムが牢屋に囚われ状態--16060 --EN:--Bjrngurm in prison--16060
function SetBiyoState_01(proxy,param,chrId)
	print("SetBiyoState_01 begin");
	ValidCharactor( proxy, chrId );
	print("SetBiyoState_01 end");
end

----------------------------------------------------------------------------------------------------------------
--ビヨルングルムが解放してくれて感謝状態--16061 --EN:--Grateful state for Bjrn Grum's release--16061
function SetBiyoState_02(proxy,param,chrId)
	print("SetBiyoState_02 begin");
	ValidCharactor( proxy, chrId );
	proxy:SetTeamType( chrId , TEAM_TYPE_BattleFriend );
	print("SetBiyoState_02 end");
end

----------------------------------------------------------------------------------------------------------------
--ビヨルングルムが牢屋で寝ている状態--16062 --EN:--Bjrngurm sleeping in prison--16062
function SetBiyoState_03(proxy,param,chrId)
	print("SetBiyoState_03 begin");
	--王の剣が既に死んでいる --EN:--King's sword is already dead
	if	proxy:IsCompleteEvent(4360) == true then
		print("SetBiyoState_03 王の剣が死んでいるので飛び級"); --EN:print("SetBiyoState_03 The king's sword is dead, so skip");
		--飛竜の長の状態が死んでいるとき --EN:--When the state of the wyvern chief is dead
		if	proxy:IsCompleteEvent(TYO_STATE_DEAD) == true then
			print("SetBiyoState_03 飛竜の長が死んでいるので、もういない状態へ"); --EN:print("SetBiyoState_03 Since the chief of the wyvern is dead");
			SetNpcStateFlag( proxy, param, biyo_flag_list, BIYO_STATE_EXIT );
			proxy:SetEventFlag( 529, true);
		else
			print("SetBiyoState_03 飛竜の長が生きているので、飛竜の長と戦う状態へ"); --EN:print("SetBiyoState_03 Since the chief of the wyvern is alive, enter the state to fight with the chief of the wyvern");
			SetNpcStateFlag( proxy, param, biyo_flag_list, BIYO_STATE_BATTLE_FLY_DRAGON );
		end
	else
		--ビヨの状態を「王城3を探索」にする --EN:--Set Biyo's status to "Exploring the Royal Castle 3"
		SetNpcStateFlag( proxy, param, biyo_flag_list, BIYO_STATE_SEARCH_3 );
		--状態を変えたので再チェック --EN:-- Check again because the state has changed
		proxy:NotNetMessage_begin();
			proxy:OnKeyTime2( SYSTEM_CHECK_POINT, "BiyoCheck", 0.0, 0, 2, once );
		proxy:NotNetMessage_begin();
	end
	print("SetBiyoState_03 end");
end

-------------------------------------------------------------------------------------------------
--ビヨルングルムが牢屋で寝ている状態初期化チェック--16062 --EN:--Initialization check that Bjrn Grum is sleeping in prison--16062
function SetBiyoState_03Init(proxy,param,chrId)
	print("SetBiyoState_03Init begin");
	ValidCharactor( proxy, chrId );--有効に --EN:--enable
	print("SetBiyoState_03Init end");
end

-------------------------------------------------------------------------------------------------
--ビヨルングルムが敵対(牢内)状態--16063 --EN:--Bjrn Grum is hostile (in prison)--16063
function SetBiyoState_04(proxy,param,chrId)
	print("SetBiyoState_04 begin");
	ValidCharactor( proxy, chrId );
	proxy:EraseEventSpecialEffect_2(chrId,5064);
	proxy:SetTeamType( chrId, TEAM_TYPE_AngryFriend );
	print("SetBiyoState_04 end");
end

----------------------------------------------------------------------------------------------------------------
--ビヨルングルムが獄吏を倒したい状態--16065 --EN:--Bjrn Grum wants to defeat the jailer--16065
function SetBiyoState_05(proxy,param,chrId)
	print("SetBiyoState_05 begin");
	ValidCharactor( proxy, chrId );
	proxy:SetTeamType( chrIs , TEAM_TYPE_BattleFriend );	
	print("SetBiyoState_05 end");
end

----------------------------------------------------------------------------------------------------------------
--ビヨルングルムが逆襲が終わって満足して寝る状態--16066 --EN:--Bjrn Grum is sleeping satisfied after the counterattack is over--16066
function SetBiyoState_06(proxy,param,chrId)
	print("SetBiyoState_06 begin");
	--王の剣が既に死んでいる --EN:--King's sword is already dead
	if	proxy:IsCompleteEvent(4360) == true then
		print("SetBiyoState_06 王の剣が死んでいるので飛び級"); --EN:print("SetBiyoState_06 The king's sword is dead, so skip");
		--飛竜の長の状態が死んでいるとき --EN:--When the state of the wyvern chief is dead
		if	proxy:IsCompleteEvent(TYO_STATE_DEAD) == true then
			print("SetBiyoState_06 飛竜の長が死んでいるので、もういない状態へ"); --EN:print("SetBiyoState_06 Since the chief of the wyvern is dead");
			SetNpcStateFlag( proxy, param, biyo_flag_list, BIYO_STATE_EXIT );
			proxy:SetEventFlag( 529, true);
		else
			print("SetBiyoState_06 飛竜の長が生きているので、飛竜の長と戦う状態へ"); --EN:print("SetBiyoState_06 Since the chief of the wyvern is alive, enter the state to fight with the chief of the wyvern");
			SetNpcStateFlag( proxy, param, biyo_flag_list, BIYO_STATE_BATTLE_FLY_DRAGON );
		end
	else
		--ビヨの状態を「王城3を探索」にする --EN:--Set Biyo's status to "Exploring the Royal Castle 3"
		SetNpcStateFlag( proxy, param, biyo_flag_list, BIYO_STATE_SEARCH_3 );
		--状態を変えたので再チェック --EN:-- Check again because the state has changed
		proxy:NotNetMessage_begin();
			proxy:OnKeyTime2( SYSTEM_CHECK_POINT, "BiyoCheck", 0.0, 0, 2, once );
		proxy:NotNetMessage_begin();
	end
	print("SetBiyoState_06 end");
end

----------------------------------------------------------------------------------------------------------------
--ビヨルングルムが逆襲が終わって満足して寝る状態用の初期化--16066 --EN:--Initialization for the state where Bjrngurm is satisfied with the counterattack and goes to sleep--16066
function SetBiyoState_06Init(proxy,param,chrId)
	print("SetBiyoState_06Init beign");
	ValidCharactor( proxy, chrId );--有効に --EN:--enable
	print("SetBiyoState_06Init end");
end

----------------------------------------------------------------------------------------------------------------
--ビヨルングルムが敵対(城壁)状態--16067 --EN:--Bjrngurm is hostile (wall)--16067
function SetBiyoState_07(proxy,param,chrId)
	print("SetBiyoState_07 begin");
	proxy:SetTeamType( chrId, TEAM_TYPE_AngryFriend );
	proxy:EraseEventSpecialEffect_2(chrId,5064);
	ValidCharactor( proxy, chrId );
	print("SetBiyoState_07 end");
end



--[[44444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444
---------------------------------------△△△王城２ビヨルングルム△△△------------------------------ --EN:--△△△Royal Castle 2 Bjrn Grum△△△-------------------------------
44444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444]]


--[[44444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444
---------------------------------------▽▽▽王城３ビヨルングルム▽▽▽------------------------------ --EN:--▽▽▽Castle 3 Bjrn Gurm▽▽▽------------------------------
44444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444]]
function BiyoRegistCondition_block3(proxy,param,chrId)
	print("BiyoRegistCondition_block3 begin");
	if	proxy:IsCompleteEvent( BIYO_STATE_DEAD ) == false then
		proxy:OnCharacterDead( 1433, 627, "OnEvent_1433", once );
		if proxy:IsCompleteEvent(BIYO_STATE_HOSTILE_IN_KING_ROOM) == false then
			--proxy:OnCharacterTotalDamage( 1432, 627, LOCAL_PLAYER, 100, "OnEvent_1432", once );
			proxy:OnCharacterTotalRateDamage( 1432, 627, LOCAL_PLAYER, NPC_ANGRY_Rate, "OnEvent_1432", once );
			if proxy:IsCompleteEvent(1470) == false then
				proxy:OnRegionJustIn( 1470 , LOCAL_PLAYER , 2581 , "OnEvent_1470",once );
			end
		end
		--■1460■ビヨが獄吏を倒しに行く■(会話システムから呼び出し) --EN:--■1460■Biyo goes to defeat the jailer■(call from conversation system)
		proxy:NotNetMessage_begin();
			proxy:LuaCall( 1460 , 0 , "OnEvent_1460" , everytime );--会話システムから呼び出す場合はparam=0を指定 --EN:--Specify param=0 when calling from the conversation system
		proxy:NotNetMessage_end();
	end
	print("BiyoRegistCondition_block3 end");
end

----------------------------------------------------------------------------------------------------------------
--ビヨルングルムが王城3を探索状態--16068 --EN:--Bjrn Grum exploring Royal Castle 3--16068
function SetBiyoState_08(proxy,param,chrId)
	print("SetBiyoState_08 begin");
	proxy:EnableLogic( chrId,false );	
	ValidCharactor( proxy, chrId );	
	print("SetBiyoState_08 end");
end

----------------------------------------------------------------------------------------------------------------
--ビヨルングルムが王の剣を倒して満足状態--16069 --EN:--Bjrngurm defeats the King's Sword and is satisfied--16069
function SetBiyoState_09(proxy,param,chrId)
	print("SetBiyoState_09 begin");
	ValidCharactor( proxy, chrId );
	--ValidCharactor( proxy, 627 );	
--~ 	if	proxy:IsDistance( chrId, LOCAL_PLAYER, 20 ) == false then
--~ 		proxy:Warp( chrId, 2580 );
--~ 	end
	
	print("SetBiyoState_09 Param3 = ",param:GetParam3() );
	--ポイントが違う場合は特に何もしない --EN:--If the points are different, do nothing
	if	param:GetParam3() == 2590 then
		print("SetBiyoState_09 Param return end");
		return;
	end

	--飛竜の長が死んでいるか？ --EN:--Is the wyvern chief dead?
	if	proxy:IsCompleteEvent(TYO_STATE_DEAD) == true then
		print("SetBiyoState_09 飛竜の長が死んでいるので、もういない状態へ"); --EN:print("SetBiyoState_09 The wyvern chief is dead, so it's no longer there");
		SetNpcStateFlag( proxy, param, biyo_flag_list, BIYO_STATE_EXIT );
		proxy:SetEventFlag( 1462, true );
		proxy:OnKeyTime2( SYSTEM_CHECK_POINT, "BiyoCheck", 0.0, 0, 2, once );
	else
		print("SetBiyoState_09 飛竜の長が生きているので、飛竜の長と戦う状態へ"); --EN:print("SetBiyoState_09 Since the chief of the wyvern is alive, enter the state to fight with the chief of the wyvern");
		SetNpcStateFlag( proxy, param, biyo_flag_list, BIYO_STATE_BATTLE_FLY_DRAGON );
		proxy:OnKeyTime2( SYSTEM_CHECK_POINT, "BiyoCheck", 0.0, 0, 2, once );
	end
	
	print("SetBiyoState_09 end");
end

----------------------------------------------------------------------------------------------------------------
--ビヨルングルムが王の剣を倒して満足状態用の初期化--16069 --EN:--Bjrn Grum defeated King's Sword and initialized for satisfaction--16069
function SetBiyoState_09Init(proxy,param,chrId)
	print("SetBiyoState_09Init begin");
	ValidCharactor( proxy, chrId );
	print("SetBiyoState_09Init end");
end

----------------------------------------------------------------------------------------------------------------
--ビヨルングルムが敵対(王の剣の部屋)状態--16070 --EN:--Bjrngurm is hostile (King's Sword Room)--16070
function SetBiyoState_10(proxy,param,chrId)
	print("SetBiyoState_10 begin");
	ValidCharactor( proxy, chrId );
	--proxy:Warp( chrId, 2580 );
	proxy:SetTeamType( chrId, TEAM_TYPE_AngryFriend );
	proxy:EraseEventSpecialEffect_2(chrId,5064);
	print("SetBiyoState_10 end");
end

----------------------------------------------------------------------------------------------------------------
--ビヨルングルムが王の剣の部屋で寝る状態--16071 --EN:--Bjrngurm sleeping in the King's Sword Room--16071
function SetBiyoState_11(proxy,param,chrId)
	print("SetBiyoState_11 begin");
	print("SetBiyoState_11 end");
end

--[[44444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444
---------------------------------------△△△王城３ビヨルングルム△△△------------------------------ --EN:--△△△Royal Castle 3Bjorn Grum△△△------------------------------
44444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444]]


--[[44444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444
---------------------------------------▽▽▽王城４ビヨルングルム▽▽▽------------------------------ --EN:--▽▽▽Royal Castle 4Bjrn Gurm▽▽▽------------------------------
44444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444]]
function BiyoRegistCondition_block4(proxy,param,chrId)
	print("BiyoRegistCondition_block4 begin");
	if	proxy:IsCompleteEvent( BIYO_STATE_HOSTILE_IN_GATE_FRONT) == false then
		--proxy:OnCharacterTotalDamage( 1711, chrId, LOCAL_PLAYER, 100, "OnEvent_1711", once );
		proxy:OnCharacterTotalRateDamage( 1711, chrId, LOCAL_PLAYER, NPC_ANGRY_Rate, "OnEvent_1711", once );
	end
	
	--■1717■ビヨが寝る■(会話システムから呼び出し) --EN:-- ■ 1717 ■ Biyo sleeps ■ (call from the conversation system)
	proxy:LuaCall( 1717, 0, "OnEvent_1717", everytime );--会話システムから呼び出す場合はparam=0を指定 --EN:--Specify param=0 when calling from the conversation system
	
	--■1790■飛竜の情報をビヨルングルムに教える --EN:--■1790■Tell Bjrngrum information about the flying dragon
	proxy:OnRegistFunc( 1790, "Condition_1790", "dummy", 2, once );

	proxy:OnCharacterDead( 1712, chrId, "OnEvent_1712", once );

	print("BiyoRegistCondition_block4 end");
end

----------------------------------------------------------------------------------------------------------------
--ビヨルングルムが飛竜の長と戦う状態--16072 --EN:--Bjrngurm fighting against the wyvern chief--16072
function SetBiyoState_12(proxy,param,chrId)
	print("SetBiyoState_12 begin");
	if	proxy:IsCompleteEvent( TYO_STATE_DEAD ) == true then
		SetNpcStateFlag(proxy, param, biyo_flag_list, BIYO_STATE_EXIT);
		proxy:SetEventFlag( 1716, true );
		proxy:OnKeyTime2(SYSTEM_CHECK_POINT, "BiyoCheck", 0.0, 0, 2, once);
	end
	ValidCharactor( proxy, chrId );
	print("SetBiyoState_12 end");
end

----------------------------------------------------------------------------------------------------------------
--ビヨルングルムが石柱に戻りたい状態--16073 --EN:--Bjrngurm wants to return to the stone pillar--16073
function SetBiyoState_13(proxy,param,chrId)
	print("SetBiyoState_13 begin");
	ValidCharactor( proxy, chrId );
	print("SetBiyoState_13 end");
end


----------------------------------------------------------------------------------------------------------------
--ビヨルングルムが敵対(ゲート前)状態--16076 --EN:--Bjrn Grum is hostile (before the gate)--16076
function SetBiyoState_16(proxy,param,chrId)
	print("SetBiyoState_16 begin");
	ValidCharactor( proxy, chrId );
	proxy:SetTeamType( chrId, TEAM_TYPE_AngryFriend );
	proxy:EraseEventSpecialEffect_2(chrId,5064);
	print("SetBiyoState_16 end");
end
--[[44444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444
---------------------------------------△△△王城４ビヨルングルム△△△------------------------------ --EN:--△△△Royal Castle 4Bjorn Grum△△△-------------------------------
44444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444]]


--[[-----------------------------------------------------------------------------------------------
---------------------------------------▽▽▽石柱ビヨルングルム▽▽▽------------------------------ --EN:--▽▽▽Stone Pillar Bjrn Gurm▽▽▽------------------------------
-----------------------------------------------------------------------------------------------]]

----------------------------------------------------------------------------------------------------------------
--ビヨルングルムが石柱にいる状態--16074 --EN:--Bjrn Grum in stone pillar--16074
function SetBiyoState_14(proxy,param,chrId)
	print("SetBiyoState_14 begin");
	print("SetBiyoState_14 end");
end

----------------------------------------------------------------------------------------------------------------
--ビヨルングルムが敵対(石柱)状態--16075 --EN:--Bjrn Grum is hostile (stone pillar) state--16075
function SetBiyoState_15(proxy,param,chrId)
	print("SetBiyoState_15 begin");
	print("SetBiyoState_15 end");
end

--[[-----------------------------------------------------------------------------------------------
---------------------------------------△△△石柱ビヨルングルム△△△------------------------------ --EN:--△△△ Stone Pillar Bjrn Grum △△△------------------------------------------
-----------------------------------------------------------------------------------------------]]


--[[-----------------------------------------------------------------------------------------------------------------------------------------
	ビヨルングルム関連　ここまで --EN:Bjrn Grum Related So far
-----------------------------------------------------------------------------------------------------------------------------------------]]


--[[-----------------------------------------------------------------------------------------------------------------------------------------
	飛竜の眷属関連　ここから --EN:Hiryu's relatives start here
-----------------------------------------------------------------------------------------------------------------------------------------]]

--■236■飛竜の眷属の表示切替 --EN:-- ■ 236 ■ Display switching of Hiryu's relatives
--■807■飛竜の眷属の表示切替 --EN:-- ■ 807 ■ Display switching of Hiryu's relatives
function HiryuKenzokuCheck(proxy,param)
	print("HiryuKenzokuCheck begin");
--■飛竜(眷属)イベント関連初期化 --EN:-- ■ Wyvern (kin) event-related initialization

	--初期状態をセット(状態が未設定の場合、指定した状態をセットする) --EN:--Set the initial state (if the state is not set, set the specified state)
	SetFirstNpcStateFlag( proxy , param , kenzoku_flag_list , KENZOKU_STATE_WARNING );
	
	--local regionId	   = param:GetParam3();--領域のイベントID --EN:--Region Event ID
	local block_id		= param:GetParam2();
	local kenzoku_id_1 = 301;--王城１の飛流の眷属 --EN:--Flying family of Royal Castle 1
	local kenzoku_id_2 = 110;--王城２の飛流の眷属 --EN:--Flying family of royal castle 2
	
	local kenzoku_block1_acid_list = { 190, 191, 199, 221, 230, 231, 232, 233, 234};
	local kenzoku_block2_acid_list = { 805, 800, 801, 802, 803, 804, 806};
	
	proxy:AddFieldInsFilter(kenzoku_id_1);
	proxy:AddFieldInsFilter(kenzoku_id_2);
	
	--一旦全員消しておく --EN:-- Erase all of them for now
	InvalidCharactor(proxy,kenzoku_id_1);
	InvalidCharactor(proxy,kenzoku_id_2);
	
	--監視を一旦全削除 --EN:--Delete all monitors once
	DeleteConditionList(proxy,kenzoku_block1_acid_list);
	DeleteConditionList(proxy,kenzoku_block2_acid_list);
	
	--常時バックリードOFF --EN:--Always back read OFF
	proxy:SetAlwayEnableBackread_forEvent( kenzoku_id_1, false );
	proxy:SetAlwayEnableBackread_forEvent( kenzoku_id_2, false );
	
	--強制更新解除 --EN:--Cancel forced update
	LuaFunc_NormalOmission( proxy, kenzoku_id_1 );
	LuaFunc_NormalOmission( proxy, kenzoku_id_2 );
	
	--飛竜の眷属が生きている --EN:--Hiryu's relatives are alive
	if	proxy:IsCompleteEvent(KENZOKU_2_STATE_DEAD) 			== false and
		proxy:IsCompleteEvent(KENZOKU_STATE_DEAD) 				== false then
		
		--王城１用のチェックポイントか？ --EN:--Is it a checkpoint for Royal Castle 1?
		if	block_id == 0 then
			
			--■35■QWCによる飛竜の無効化 --EN:--■35■Disabling flying dragons with QWC
			if	proxy:IsCompleteEvent(35) == false then
				--撤退では無い --EN:--not withdrawal
				if proxy:IsCompleteEvent( KENZOKU_STATE_ESCAPE ) == false then
					--初期化 --EN:--Initialization
					proxy:SetDisableGravity( kenzoku_id_1 , true );--重力OFF --EN:--Gravity off
					proxy:EnableLogic( kenzoku_id_1 , false );--思考OFF --EN:--Thinking OFF
					proxy:SetSuperArmor( kenzoku_id_1 , true );--ダメージモーションさせない --EN:--No damage motion
					proxy:SetDeadMode( kenzoku_id_1, true);--飛竜は死なない設定(死にそうになったら撤退する) --EN:--Set so that flying dragons don't die (withdraw if they're about to die)
					proxy:SetAlwayEnableBackread_forEvent( kenzoku_id_1, true );
					LuaFunc_ForceOmission(proxy, kenzoku_id_1 );
					proxy:ForcePlayLoopAnimation( kenzoku_id_1 , 0 );--警戒しているアニメループ再生 --EN:-- Alert animation loop playback
					if proxy:IsClient() == false then
						proxy:RequestForceUpdateNetwork(kenzoku_id_1);
					end
					ValidCharactor( proxy, kenzoku_id_1 );
					
					--王城１飛竜管理用アクションID:199(イベントで自由に使えるアクションID) --EN:--Ojo 1 Flying Dragon Management Action ID: 199 (action ID that can be used freely in the event)
					SingleReset( proxy, 199 );
					if	proxy:IsClient() == false then
						--レバーが惹かれていたら阻止諦め、そうでなければ通常の巣にいる状態へ --EN:--If the lever is attracted, give up blocking, otherwise go to the state of being in a normal nest
						if	proxy:IsCompleteEvent( 0 ) == true then
							SetNpcStateFlag( proxy, param, kenzoku_flag_list, KENZOKU_STATE_WARNING_AND_LEVER );
						else
							SetNpcStateFlag( proxy, param, kenzoku_flag_list, KENZOKU_STATE_WARNING );
						end
						
					end
					
					--■234■飛竜(眷属)の撤退監視(25%以下で撤退)■ --EN:--■ 234 ■ Wyvern withdrawal monitoring (withdrawal at 25% or less) ■
					SingleReset( proxy, 234 );
					proxy:NotNetMessage_begin();
						proxy:OnCharacterHP( 234 , kenzoku_id_1 , "OnEvent_234" , 0.25 , once );
						proxy:LuaCall( 234, 2, "OnEvent_234_1", everytime );
					proxy:NotNetMessage_end();
					
					if	proxy:IsCompleteEvent( 234 ) == false then					
						if	proxy:IsClient() == false then
							proxy:NotNetMessage_begin();
							proxy:OnKeyTime2( 199, "OnEvent_199", 0.0, 0, 2, once );
							proxy:NotNetMessage_end();
						end
						
						proxy:LuaCall( 199, 1, "OnEvent_199_default", everytime );
						proxy:LuaCall( 221, 1, "OnEvent_221_1", everytime );
						proxy:LuaCall( 221, 2, "OnEvent_221_2", everytime );
						proxy:LuaCall( 190, 1, "OnEvent_190_1", everytime );
						proxy:LuaCall( 190, 2, "OnEvent_190_2", everytime );
						proxy:LuaCall( 191, 1, "OnEvent_191_1", everytime );
						proxy:LuaCall( 191, 2, "OnEvent_191_2", everytime );
						proxy:LuaCall( 230, 1, "OnEvent_230_1", everytime );
						proxy:LuaCall( 230, 2, "OnEvent_230_2", everytime );
						proxy:LuaCall( 231, 1, "OnEvent_231_1", everytime );
						proxy:LuaCall( 231, 2, "OnEvent_231_2", everytime );
						proxy:LuaCall( 232, 1, "OnEvent_232_1", everytime );
						proxy:LuaCall( 232, 2, "OnEvent_232_2", everytime );
					end
				end
			end
		--王城２用のチェックポイントか？ --EN:--A checkpoint for Ojo 2?
		elseif	block_id == 1 then
		--elseif	regionId == 2390 or regionId == 2391 then
			proxy:SetAlwayEnableBackread_forEvent( kenzoku_id_2, true );
			LuaFunc_ForceOmission(proxy, kenzoku_id_2 );
			--飛竜のアニメ再生のトリガー(最初からずっととんでいる) --EN:--Hiryu's animation playback trigger (always jumping from the beginning)
			if proxy:IsClient() == false then
				--ホストの飛竜アニメループ開始 --EN:-- Host Hiryu anime loop start
				proxy:NotNetMessage_begin();
					proxy:OnKeyTime2( 800 , "OnEvent_800" , 0.0 , 0 , 1 , once );
				proxy:NotNetMessage_end();
				--更新権限はホストが管理 --EN:--Update permissions are managed by the host
				--ここではホストが権限を持つと、ネットワークの座標同期の問題でクライアント側での見た目が悪くなる為、 --EN:-- Here, if the host has authority, it will look bad on the client side due to network coordinate synchronization problems, so
				--権限を固定しません。 --EN:--Do not lock permissions.
				--proxy:RequestForceUpdateNetwork(kenzoku_id_2);
			end
			
			--■800■飛竜の眷属２が元気に飛び回る■	 --EN:-- ■ 800 ■ Wyvern's kin 2 fly around energetically ■
			--■801■飛竜の眷属２が領域Aをブレス攻撃■	 --EN:-- ■ 801 ■ Wyvern's kin 2 breath attack on area A ■
			--■802■飛竜の眷属２が領域Bをブレス攻撃■ --EN:-- ■ 802 ■ Wyvern's kin 2 breath attack on area B ■
			--■803■飛竜の眷属２が領域Cをブレス攻撃■	 --EN:-- ■ 803 ■ Wyvern's kin 2 breath attack on area C ■
			--■804■飛竜の眷属２がヘロヘロになりながら飛び回る■ --EN:--■804■Flying dragon kin 2 flies around while becoming herohero■
			--■805■飛竜の眷属２がヘロヘロになる■ --EN:-- ■ 805 ■ Hiryu's kin 2 becomes hero hero ■
			--■806■飛竜の眷属２が死ぬ■(実際には死に待ち状態) --EN:-- ■ 806 ■ Hiryu's kin 2 dies ■ (actually waiting to die)
			
			--▼飛竜アニメの同期再生用▼ --EN:--▼For synchronous playback of flying dragon animation▼
			proxy:LuaCall( 800 , 1 , "OnEvent_800_syncro_anime"   , everytime );--待機 --EN:--stand-by
			proxy:LuaCall( 800 , 2 , "OnEvent_800_2_syncro_anime" , everytime );--待機2 --EN:--Wait 2
			proxy:LuaCall( 800 , 3 , "OnEvent_800_3_syncro_anime" , everytime );--死亡待機 --EN:--wait for death
			proxy:LuaCall( 801 , 1 , "OnEvent_801_syncro_anime" , everytime );--ブレスA --EN:--Breath A
			proxy:LuaCall( 802 , 1 , "OnEvent_802_syncro_anime" , everytime );--ブレスB --EN:--Breath B
			proxy:LuaCall( 803 , 1 , "OnEvent_803_syncro_anime" , everytime );--ブレスC --EN:--Breath C
			proxy:LuaCall( 804 , 1 , "OnEvent_804_syncro_anime" , everytime );--ヘロヘロ --EN:--hero hero
			proxy:LuaCall( 806 , 1 , "OnEvent_806_syncro_anime" , everytime );--死亡		 --EN:--death
			--[[
			if proxy:IsCompleteEvent( 805 ) == false then
				proxy:OnCharacterHP( 805 , kenzoku_id_2 , "OnEvent_805" , 0.5 , once );
			end
			]]
			if proxy:IsCompleteEvent( 806 ) == false then
				proxy:OnCharacterHP( 806 , kenzoku_id_2 , "OnEvent_806" , 0.01 , once );
			end

			
			proxy:EnableLogic( kenzoku_id_2, false );
			ValidCharactor( proxy, kenzoku_id_2 );
		end
	end
	
	print("HiryuKenzokuCheck end");
	
	--王城１の長の描画を制限します --EN:--Limit the drawing of the head of the castle 1
	print("HiryuOsa DrawCheck　begin"); --EN:print("HiryuOsa DrawCheck begin");
	if block_id == 0 then
		if	proxy:IsCompleteEvent(35) == false then
			if 	proxy:IsCompleteEvent( TYO_STATE_DEAD ) == false and	--死んでない --EN:--not dead
				proxy:IsCompleteEvent( TYO_STATE_ESCAPE ) == false then		--撤退してない --EN:--not withdrawn
				--有効 --EN:--valid
				ValidCharactor(proxy,300);
				print("広場長有効中です"); --EN:print("Square length is active");
			else
				print("広場長　死亡なので無効中です"); --EN:print("Square manager: disabled because he is dead");
				InvalidCharactor(proxy,300);
			end
		else
			print("広場長　QWCで無効中です"); --EN:print("Square length: disabled in QWC");
			InvalidCharactor(proxy,300);
		end
	else
		--無効 --EN:--invalid
		InvalidCharactor(proxy,300);
		print("広場長ブロック外無効中です") --EN:print("Invalid outside square length block")
	end
	print("HiryuOsa DrawCheck　end"); --EN:print("HiryuOsa DrawCheck end");
end




--[[-----------------------------------------------------------------------------------------------------------------------------------------
	飛竜の眷属関連　ここまで --EN:So far related to Hiryuu's relatives
-----------------------------------------------------------------------------------------------------------------------------------------]]


--[[-----------------------------------------------------------------------------------------------------------------------------------------
	飛竜の長関連　ここから --EN:Hiryu no Naga-related From here
-----------------------------------------------------------------------------------------------------------------------------------------]]


function HiryuOsaCheck(proxy,param)
	print("HiryuOsaCheck begin");
	
	--初期状態をセット(状態が未設定の場合、指定した状態をセットする) --EN:--Set the initial state (if the state is not set, set the specified state)
	SetFirstNpcStateFlag( proxy , param , tyo_flag_list , TYO_STATE_WARNING_AISLE );
	SetFirstNpcStateFlag( proxy , param , tyo1_flag_list , TYO_STATE_SLEEPING );
	
	proxy:DeleteEvent(220);
	proxy:DeleteEvent(235);
	proxy:DeleteEvent(1770);

	--InvalidCharactor(proxy,300);
	InvalidCharactor(proxy,501);
	if	proxy:IsCompleteEvent(TYO_STATE_DEAD)	== true then
		print("HiryuOsaCheck state check end");
		return;
	end
	
	--常時バックリードOFF --EN:--Always back read OFF
	proxy:SetAlwayEnableBackread_forEvent( 300, false );
	proxy:SetAlwayEnableBackread_forEvent( 501, false );
	
	--強制更新解除 --EN:--Cancel forced update
	LuaFunc_NormalOmission( proxy, 300 );
	LuaFunc_NormalOmission( proxy, 501 );
	
		
	--王城１の飛竜の長 --EN:--Chief of Wyvern of Royal Castle 1
	--QWC判定チェック --EN:--QWC Judgment Check
	if	proxy:IsCompleteEvent(35) == false then
		if proxy:IsCompleteEvent(TYO_STATE_ESCAPE) == false then--撤退してない --EN:--not withdrawn
			if 	proxy:IsCompleteEvent( TYO_STATE_DEAD ) == false then
				--ValidCharactor(proxy, 300 );
				proxy:SetAlwayEnableBackread_forEvent( 300, true );
				LuaFunc_ForceOmission(proxy, 300 );
				--王城１の飛竜の長 --EN:--Chief of Wyvern of Royal Castle 1
				proxy:PlayLoopAnimation(300,7000);
				proxy:EnableLogic(300, false);
				proxy:Warp( 300, 2055 );
				--■220■飛竜(長)が寝ている■ --EN:-- ■ 220 ■ Wyvern (Long) is sleeping ■
				SingleReset(proxy, 220);
				proxy:OnRegionIn( 220 , LOCAL_PLAYER , 2130 , "OnEvent_220" , everytime );
						
				--■235■飛竜(長)の死亡監視■ --EN:-- ■ 235 ■ Wyvern (Lord) death watch ■
				proxy:NotNetMessage_begin();
					--proxy:OnCharacterDead( 235 , 300 , "OnEvent_235" , once );
					proxy:OnCharacterHP( 235 , 300 , "OnEvent_235" , 0.01 , once );
				proxy:NotNetMessage_end();
			end
		end
	end
	

	--王城４の飛竜の長 --EN:--Chief of Wyvern of Royal Castle 4
	if 	proxy:IsCompleteEvent( 4480 ) ==false and --ボスが生きているとき --EN:-- when the boss is alive
		proxy:IsCompleteEvent( TYO_STATE_DEAD ) == false then --長が死んでない時 --EN:--when the chief is not dead
		ValidCharactor(proxy, 501 );
		
		--DeleteEventで消されてしまうので退去 --EN:--Remove because it will be deleted by DeleteEvent
		if proxy:IsCompleteEvent( 1560 ) == false then--登場ポリ劇見ていなかったら --EN:--If you haven't seen the appearance police drama
		
			InvalidCharactor( proxy , 501 );--飛竜いない --EN:--There is no Hiryu
			
			--演出用(?)のOBJを無効化(描画･当たりOFF)しておく --EN:--Invalidate (draw/hit OFF) OBJ for production (?)
			proxy:SetDrawEnable( 1720 , false );
			proxy:SetColiEnable( 1720 , false );
			
			proxy:SetDrawEnable( 1721 , false );
			proxy:SetColiEnable( 1721 , false );
			
			proxy:SetDrawEnable( 1710 , false );
			proxy:SetColiEnable( 1710 , false );
			
			proxy:SetDrawEnable( 1711 , false );
			proxy:SetColiEnable( 1711 , false );
		else
		
			--▼飛竜が再生するアニメの判定用トリガー(生存orグレイのみ)▼ --EN:--▼Trigger for judging animation played by Hiryu (survival or gray only)▼
			if proxy:IsClient() == false then
				proxy:NotNetMessage_begin();
					proxy:OnKeyTime2( 1590 , "OnEvent_1590" , 0.0 , 0 , 1 , once );
				proxy:NotNetMessage_end();
			end
			
			--演出用(?)のOBJを有効化/無効化する --EN:--Enable/disable OBJ for staging (?)
			proxy:SetDrawEnable( 1720 , true );
			proxy:SetColiEnable( 1720 , true );
			
			proxy:SetDrawEnable( 1721 , true );
			proxy:SetColiEnable( 1721 , true );
			
			proxy:SetDrawEnable( 1700 , false );
			proxy:SetColiEnable( 1700 , false );
			
			proxy:SetDrawEnable( 1701 , false );
			proxy:SetColiEnable( 1701 , false );
		end
		--初期化 --EN:--Initialization
		proxy:SetDisableGravity( 501 , true );--重力OFF --EN:--Gravity off
		proxy:EnableLogic( 501 , false );--思考OFF --EN:--Thinking OFF
		proxy:SetSuperArmor( 501 , true );--ダメージモーションさせない --EN:--No damage motion
		proxy:SetDeadMode(501, true);--飛竜は死なない設定(死にそうになったら撤退する) --EN:--Set so that flying dragons don't die (withdraw if they're about to die)
		proxy:SetAlwayEnableBackread_forEvent( 501, true );
		LuaFunc_ForceOmission(proxy, 501 );
		
		--■1770■飛竜の長が仮死状態■ --EN:--■ 1770 ■ Wyvern chief is in suspended animation ■
		if	proxy:IsCompleteEvent( 1770 ) == false then
			proxy:OnCharacterHP( 1770 , 501 , "OnEvent_1770" , 0.01 , once );
		end
		
	end
	print("HiryuOsaCheck end");
end

--[[-----------------------------------------------------------------------------------------------------------------------------------------
	飛竜の長関連　ここまで --EN:So far related to Hiryu no Naga
-----------------------------------------------------------------------------------------------------------------------------------------]]




--■60■ミラルダ死亡処理■ --EN:-- ■ 60 ■ Miralda death processing ■
function OnEvent_60(proxy, param)
	print("OnEvent_60 begin");
	print("ミラルダは死亡しました。"); --EN:print("Miralda is dead.");
	proxy:SetEventFlag( 60, true );
	print("OnEvent_60 end");
end

--■62■ブラックミラルダ死亡■ --EN:-- ■ 62 ■ Black Miralda death ■
function OnEvent_62(proxy,param)
	print("OnEvent_62 begin");
	proxy:SetEventFlag(62, true);
	print("OnEvent_62 end");
end

--■15635■ミラルダ黒の死体をしらべた■ --EN:--■ 15635 ■ Miralda Black's corpse examined ■
function OnEvent_15635(proxy,param)
	print("OnEvent_15635 begin");
	proxy:SetEventFlag( 15635 , true );
	print("OnEvent_15635 end");
end

--■86■ミラルダ会話用フラグON■ --EN:--■86■Miralda Conversation Flag ON■
function OnEvent_86(proxy,param)
	print("OnEvent_86 begin");
	proxy:SetEventFlag( 86,true );
	print("OnEvent_86 end");
end

--■15605■ミラルダの死体調べた■ --EN:--■ 15605 ■ Examined Miralda's corpse ■
function OnEvent_15605(proxy,param)
	print("OnEvent_15605 begin");
	proxy:SetEventFlag( 15605 , true );
	print("OnEvent_15605 end");
end

------------------------------
--奴隷兵士ショップの状態変化-- --EN:--Slave Soldier Shop Status Change--
------------------------------
--▼奴隷兵士が王城1で敵対する▼-- --EN:--▼Slave soldiers are hostile in the royal castle 1▼--
function OnEvent_341(proxy, param)
	print("OnEvent_341 begin");

	--ロジックOn --EN:--Logic On
	proxy:EnableLogic( 691, true );
	
	--奴隷兵士の状態を敵対(王城1)にする --EN:--Change slave soldier status to hostile (royal castle 1)
	SetNpcStateFlag(proxy, param, DOREISOL_SHOP_Flag_list, DOREISOL_SHOP_HOSTILE01);
	--奴隷兵士のチームタイプを変更する --EN:--Change slave soldier team type
	proxy:SetTeamType( 691, TEAM_TYPE_AngryFriend );

	--フラグを立てる --EN:-- flag
	proxy:SetEventFlag( 341, true );
	
	print("OnEvent_341 end");
end
--▲-------------------------▲-- --EN:--▲----------▲--


--▼奴隷兵士が死亡する(王城1)▼-- --EN:--▼ A slave soldier dies (Castle 1) ▼--
function OnEvent_342(proxy, param)
	print("OnEvent_342 begin");

	--奴隷兵士の状態を「死亡」に変える --EN:-- Change slave soldier status to "dead"
	SetNpcStateFlag( proxy, param, DOREISOL_SHOP_Flag_list, DOREISOL_SHOP_DEAD );
	
	--フラグを立てる --EN:-- flag
	proxy:SetEventFlag( 342, true );
	
	--敵に削られて敵対を通り越して死亡もありえるので、ここでも削除 --EN:--Because it is possible to die by being scraped by the enemy and passing through the hostility, it is also deleted here
	--死んだら敵対にはならないので削除 --EN:--Deleted because it won't be hostile if you die
	proxy:DeleteEvent( 341 );
	proxy:DeleteEvent( 760 );
	proxy:DeleteEvent( 1441 );

	print("OnEvent_342 end");
end

--▲-------------------------▲-- --EN:--▲----------▲--


--[[▼奴隷兵士が死亡する(王城3)▼-- --EN:--[[▼Slave soldiers die (Castle 3)▼--
function OnEvent_1441(proxy, param)
	print("OnEvent_1441 begin");

	--奴隷兵士の状態を「死亡」に変える --EN:-- Change slave soldier status to "dead"
	SetNpcStateFlag( proxy, param, DOREISOL_SHOP_Flag_list, DOREISOL_SHOP_DEAD );
	
	--フラグを立てる --EN:-- flag
	proxy:SetEventFlag( 1441, true );
	
	--敵に削られて敵対を通り越して死亡もありえるので、ここでも削除 --EN:--Because it is possible to die by being scraped by the enemy and passing through the hostility, it is also deleted here
	--死んだら敵対にはならないので削除 --EN:--Deleted because it won't be hostile if you die
	proxy:DeleteEvent( 341 );
	proxy:DeleteEvent( 760 );
	proxy:DeleteEvent( 1441 );

	print("OnEvent_1441 end");
end

--▲-------------------------▲--]] --EN:--▲----------▲--]]

--[[
function OnEvent_343(proxy, param) proxy:LuaCallStart(781, 1); end
function OnEvent_344(proxy, param) proxy:LuaCallStart(781, 1); end
function OnEvent_345(proxy, param) proxy:LuaCallStart(781, 1); end
function OnEvent_780(proxy, param) proxy:LuaCallStart(781, 1); end
]]


function OnEvent_781(proxy, param)
	print("OnEvent_781 begin");
	print("JustInCheckPoint");
	
	local DoreiShop01_id = 691;
	local DoreiShop02_id = 623;
	local DoreiShop03_id = 679;
	
	local DoreiShopBlock1_acid_list = {340,341,342};
	local DoreiShopBlock2_acid_list = {760,761,762};
	local DoreiShopBlock3_acid_list = {1440,1441};
	
	--一旦3体とも消える --EN:--All three disappear once
	InvalidCharactor(proxy,DoreiShop01_id);
	InvalidCharactor(proxy,DoreiShop02_id);
	InvalidCharactor(proxy,DoreiShop03_id);
	
	if proxy:IsClient() == false then
		proxy:RequestForceUpdateNetwork( DoreiShop01_id);
		proxy:RequestForceUpdateNetwork( DoreiShop02_id);
		proxy:RequestForceUpdateNetwork( DoreiShop03_id);
	end
	
	--ブロックの監視を削除 --EN:--remove block watcher
	DeleteConditionList(proxy,DoreiShopBlock1_acid_list);
	DeleteConditionList(proxy,DoreiShopBlock2_acid_list);
	DeleteConditionList(proxy,DoreiShopBlock3_acid_list);
	
	
	--取りあえず初期状態を設定 --EN:-- Set the initial state for now
	SetFirstNpcStateFlag( proxy, param, DOREISOL_SHOP_Flag_list, DOREISOL_SHOP_SELL01 );
	
	
	--奴隷兵士が王城2に移動する --EN:--Slave soldiers move to Royal Castle 2
	if proxy:IsCompleteEvent( DOREISOL_SHOP_SELL01 ) == true then
		print("DoreiShop NowState DOREISOL_SHOP_SELL01");
		SetDoreiShopState01(proxy, param);
		RegistConditionBlock01(proxy,param);

	--奴隷兵士が王城1で敵対 --EN:--Slave Soldiers Hostile in Royal Castle 1
	elseif proxy:IsCompleteEvent( DOREISOL_SHOP_HOSTILE01 ) == true then
		print("DoreiShop NowState DOREISOL_SHOP_HOSTILE01");
		SetDoreiShopState02(proxy, param);
		RegistConditionBlock01(proxy,param);

	--奴隷兵士が死亡した --EN:--A slave soldier died
	elseif proxy:IsCompleteEvent( DOREISOL_SHOP_DEAD ) == true then
		print("DoreiShop NowState DOREISOL_SHOP_DEAD");
		SetDoreiShopState03(proxy, param);
		RegistConditionBlock01(proxy,param);

	--奴隷兵士が王城3に移動する --EN:--Slave soldiers move to Royal Castle 3
	elseif proxy:IsCompleteEvent( DOREISOL_SHOP_SELL02 ) == true then
		print("DoreiShop NowState DOREISOL_SHOP_SELL02");
		SetDoreiShopState04(proxy, param);
		RegistConditionBlock02(proxy,param);

	--奴隷兵士が王城2で敵対している --EN:--Slave soldiers are hostile in the royal castle 2
	elseif proxy:IsCompleteEvent( DOREISOL_SHOP_HOSTILE02 ) == true then
		print("DoreiShop NowState DOREISOL_SHOP_HOSTILE02");
		SetDoreiShopState05(proxy, param);
		RegistConditionBlock02(proxy,param);

	--奴隷兵士が販売している --EN:--sold by slave soldiers
	elseif proxy:IsCompleteEvent( DOREISOL_SHOP_SELL03 ) == true then
		print("DoreiShop NowState DOREISOL_SHOP_SELL03");
		SetDoreiShopState06(proxy, param);
		RegistConditionBlock03(proxy,param);

	--奴隷兵士が王城3で敵対している --EN:--Slave soldiers are hostile in the royal castle 3
	elseif proxy:IsCompleteEvent( DOREISOL_SHOP_HOSTILE03 ) == true then
		print("DoreiShop NowState DOREISOL_SHOP_HOSTILE03");
		SetDoreiShopState07(proxy, param);
		RegistConditionBlock03(proxy,param);
	end

	print("OnEvent_781 end");
end

--▼奴隷兵士が販売している(王城1)▼----------------------------------------- --EN:--▼ Sold by Slave Soldiers (Castle 1) ▼----------------------------------- ------
function SetDoreiShopState01( proxy, param )
	--ファランクスが生きている --EN:--the phalanx is alive
	if proxy:IsCompleteEvent( 4096 ) == false then
		ValidCharactor(proxy,691);--王城1にいる奴隷兵士を有効化 --EN:--Enable Slave Soldiers in Castle 1
	
	--ファランクスが死んでいる --EN:--the phalanx is dead
	else
		print("DoreiShop NowState DOREISOL_SHOP_SELL01 > Chenge to DOREISOL_SHOP_SELL02");
		InvalidBackRead(proxy,691);--王城1にいる奴隷兵士を無効化 --EN:--Nullify slave soldiers in Royal Castle 1
		ValidCharactor(proxy,623);--王城2にいる奴隷兵士を有効化 --EN:--Enable Slave Soldiers in Royal Castle 2
		
		--ロジックOFFにする --EN:--Turn off the logic
		proxy:EnableLogic( 623, false );
		
		--奴隷兵士の状態を「販売(王城2)」に変える --EN:-- Change the status of slave soldiers to "Sale (Castle 2)"
		SetNpcStateFlag( proxy, param, DOREISOL_SHOP_Flag_list, DOREISOL_SHOP_SELL02 );
	end
end
--▲-----------------------------▲----------------------------------------- --EN:--▲-----------------------------▲----------------- --------------------


--▼奴隷兵士が敵対している(王城1)▼------------------------- --EN:--▼The slave soldiers are hostile (Castle 1)▼----------------------------
function SetDoreiShopState02( proxy, param )
	ValidCharactor(proxy,691);--王城1にいる奴隷兵士を有効化 --EN:--Enable Slave Soldiers in Castle 1
	--奴隷兵士のチームタイプを変更する --EN:--Change slave soldier team type
	proxy:SetTeamType( 691, TEAM_TYPE_AngryFriend );
end
--▲-----------------------------▲------------------------- --EN:--▲-----------------------------▲----------------- --------


--▼奴隷兵士が死亡した(王城1)▼------------------------------------- --EN:--▼ A slave soldier died (Castle 1) ▼-------------------------------------
function SetDoreiShopState03( proxy, param )
	InvalidBackRead(proxy,691);--王城1にいる奴隷兵士を無効化 --EN:--Nullify slave soldiers in Royal Castle 1
	InvalidBackRead(proxy,623);--王城2にいる奴隷兵士を無効化 --EN:--Disable slave soldiers in Royal Castle 2
	InvalidBackRead(proxy,679);--王城3にいる奴隷兵士を無効化 --EN:--Nullify slave soldiers in Royal Castle 3
end
--▲-------------------------▲------------------------------------- --EN:--▲------------------------▲--------------------- ----------------


--▼奴隷兵士が販売している(王城2)▼----------------------------------------- --EN:--▼ Sold by Slave Soldiers (Castle 2) ▼---------------------------------- ------
function SetDoreiShopState04( proxy, param )
	--王の盾が生きている or エリアボスを撃破してきていない or 王都の門が開いて無い --EN:--The king's shield is alive or the area boss has not been defeated or the capital gate is not open
	if 	proxy:IsCompleteEvent( 4224 ) == false or
		proxy:IsCompleteEvent( 8035 ) == false or
		proxy:IsCompleteEvent( 571) == false then
		ValidCharactor(proxy,623);--王城2にいる奴隷兵士を有効化 --EN:--Enable Slave Soldiers in Royal Castle 2
		InvalidBackRead(proxy,691);--王城1にいる奴隷兵士を無効化 --EN:--Nullify slave soldiers in Royal Castle 1
	else
		print("DoreiShop NowState DOREISOL_SHOP_SELL02 > Chenge to DOREISOL_SHOP_SELL03");
		InvalidBackRead(proxy,691);--王城1にいる奴隷兵士を無効化 --EN:--Nullify slave soldiers in Royal Castle 1
		InvalidBackRead(proxy,623);--王城2にいる奴隷兵士を無効化 --EN:--Disable slave soldiers in Royal Castle 2
		ValidCharactor(proxy,679);--王城3にいる奴隷兵士を有効化 --EN:--Enable Slave Soldiers in Castle 3
		
		--ロジックOFFにする --EN:--Turn off the logic
		proxy:EnableLogic( 679, false );
		
		--奴隷兵士の状態を「販売(王城3)」に変える --EN:-- Change slave soldier status to "Sale (Castle 3)"
		SetNpcStateFlag( proxy, param, DOREISOL_SHOP_Flag_list, DOREISOL_SHOP_SELL03 );
	end
end
--▲-----------------------------▲----------------------------------------- --EN:--▲-----------------------------▲----------------- --------------------


--▼奴隷兵士が敵対している(王城2)▼------------------------- --EN:--▼The slave soldiers are hostile (Castle 2)▼------------------------
function SetDoreiShopState05( proxy, param )
	ValidCharactor(proxy,623);--王城2にいる奴隷兵士を有効化 --EN:--Enable Slave Soldiers in Royal Castle 2
	InvalidBackRead(proxy,691);--王城1にいる奴隷兵士を無効化 --EN:--Nullify slave soldiers in Royal Castle 1
	--奴隷兵士のチームタイプを変更する --EN:--Change slave soldier team type
	proxy:SetTeamType( 623, TEAM_TYPE_AngryFriend );
end
--▲-----------------------------▲------------------------- --EN:--▲-----------------------------▲----------------- --------


--▼奴隷兵士が販売している(王城3)▼------------------------- --EN:--▼ Sold by Slave Soldiers (Castle 3) ▼-------------------------
function SetDoreiShopState06( proxy, param )
	ValidCharactor(proxy,679);--王城3にいる奴隷兵士を有効化 --EN:--Enable Slave Soldiers in Castle 3
	InvalidBackRead(proxy,691);--王城1にいる奴隷兵士を無効化 --EN:--Nullify slave soldiers in Royal Castle 1
	InvalidBackRead(proxy,623);--王城2にいる奴隷兵士を無効化 --EN:--Disable slave soldiers in Royal Castle 2
end
--▲-----------------------------▲------------------------- --EN:--▲-----------------------------▲----------------- --------


--▼奴隷兵士が敵対している(王城3)▼------------------------- --EN:--▼The slave soldiers are hostile (Castle 3)▼----------------------------
function SetDoreiShopState07( proxy, param )
	ValidCharactor(proxy,679);--王城3にいる奴隷兵士を有効化 --EN:--Enable Slave Soldiers in Castle 3
	InvalidBackRead(proxy,691);--王城1にいる奴隷兵士を無効化 --EN:--Nullify slave soldiers in Royal Castle 1
	InvalidBackRead(proxy,623);--王城2にいる奴隷兵士を無効化 --EN:--Disable slave soldiers in Royal Castle 2
	--奴隷兵士のチームタイプを変更する --EN:--Change slave soldier team type
	proxy:SetTeamType( 679, TEAM_TYPE_AngryFriend );
end
--▲-----------------------------▲------------------------- --EN:--▲-----------------------------▲----------------- --------


--▼奴隷兵士の状態遷移(王城1)▼-------------------------------------------------------------------------------------- --EN:--▼ State Transition of Slave Soldiers (Castle 1) ▼------------------------------------- -------------------------------------------------
function RegistConditionBlock01(proxy, param)
	--奴隷兵士が死んでいない --EN:--slave soldiers not dead
	if proxy:IsCompleteEvent( DOREISOL_SHOP_DEAD ) == false then
		--奴隷兵士が王城1,2,3のいずれでも敵対していない場合 --EN:--If slave soldiers are not hostile in any of castles 1, 2, or 3
		if proxy:IsCompleteEvent( DOREISOL_SHOP_HOSTILE01 ) == false
		   and proxy:IsCompleteEvent( DOREISOL_SHOP_HOSTILE02 ) == false
		   and proxy:IsCompleteEvent( DOREISOL_SHOP_HOSTILE03 ) == false then
			--ホストからのダメージ監視 --EN:--Damage monitoring from host
			--m02_00
			--proxy:OnCharacterTotalDamage( 341, 691, LOCAL_PLAYER, DoreiShop_TotalDamage, "OnEvent_341", once );
			proxy:OnCharacterTotalRateDamage( 341, 691, LOCAL_PLAYER, NPC_ANGRY_Rate, "OnEvent_341", once );
			--m02_01
			--proxy:OnCharacterTotalDamage( 760, 623, LOCAL_PLAYER, DoreiShop_TotalDamage, "OnEvent_760", once );
			proxy:OnCharacterTotalRateDamage( 760, 623, LOCAL_PLAYER, NPC_ANGRY_Rate, "OnEvent_760", once );
			--m02_02
			--proxy:OnCharacterTotalDamage( 1440, 679, LOCAL_PLAYER, DoreiShop_TotalDamage, "OnEvent_1440", once );
			proxy:OnCharacterTotalRateDamage( 1440, 679, LOCAL_PLAYER, NPC_ANGRY_Rate, "OnEvent_1440", once );
		end
		proxy:OnCharacterDead( 342, 691, "OnEvent_342", once );
	end
end
--▲------------------▲-------------------------------------------------------------------------------------- --EN:--▲------------------▲---------------------------- -------------------------------------------------- --------


--▼奴隷兵士の状態遷移(王城2)▼------------------------------------------------------------------------------- --EN:--▼ State Transition of Slave Soldiers (Castle 2) ▼------------------------------------- ------------------------------------------
function RegistConditionBlock02(proxy, param)
	--奴隷兵士が死んでいない --EN:--slave soldiers not dead
	if proxy:IsCompleteEvent( DOREISOL_SHOP_DEAD ) == false then
		--奴隷兵士が王城1,2,3のいずれでも敵対していない場合 --EN:--If slave soldiers are not hostile in any of castles 1, 2, or 3
		if proxy:IsCompleteEvent( DOREISOL_SHOP_HOSTILE01 ) == false
		   and proxy:IsCompleteEvent( DOREISOL_SHOP_HOSTILE02 ) == false
		   and proxy:IsCompleteEvent( DOREISOL_SHOP_HOSTILE03 ) == false then
			--ホストからのダメージ監視 --EN:--Damage monitoring from host
			--m02_00
			--proxy:OnCharacterTotalDamage( 341, 691, LOCAL_PLAYER, DoreiShop_TotalDamage, "OnEvent_341", once );
			proxy:OnCharacterTotalRateDamage( 341, 691, LOCAL_PLAYER, NPC_ANGRY_Rate, "OnEvent_341", once );
			--m02_01
			--proxy:OnCharacterTotalDamage( 760, 623, LOCAL_PLAYER, DoreiShop_TotalDamage, "OnEvent_760", once );
			proxy:OnCharacterTotalRateDamage( 760, 623, LOCAL_PLAYER, NPC_ANGRY_Rate, "OnEvent_760", once );
			--m02_02
			--proxy:OnCharacterTotalDamage( 1440, 679, LOCAL_PLAYER, DoreiShop_TotalDamage, "OnEvent_1440", once );
			proxy:OnCharacterTotalRateDamage( 1440, 679, LOCAL_PLAYER, NPC_ANGRY_Rate, "OnEvent_1440", once );
		end
		proxy:OnCharacterDead( 761, 623, "OnEvent_761", once );
	end
end
--▲------------------▲-------------------------------------------------------------------------------------- --EN:--▲------------------▲---------------------------- -------------------------------------------------- --------


--▼奴隷兵士の状態遷移(王城3)▼------------------------------------------------------------------------------- --EN:--▼ State Transition of Slave Soldiers (Castle 3) ▼------------------------------------- ------------------------------------------
function RegistConditionBlock03(proxy, param)
	--奴隷兵士が死んでいない --EN:--slave soldiers not dead
	if proxy:IsCompleteEvent( DOREISOL_SHOP_DEAD ) == false then
		--奴隷兵士が王城1,2,3のいずれでも敵対していない場合 --EN:--If slave soldiers are not hostile in any of castles 1, 2, or 3
		if proxy:IsCompleteEvent( DOREISOL_SHOP_HOSTILE01 ) == false
		   and proxy:IsCompleteEvent( DOREISOL_SHOP_HOSTILE02 ) == false
		   and proxy:IsCompleteEvent( DOREISOL_SHOP_HOSTILE03 ) == false then
			--ホストからのダメージ監視 --EN:--Damage monitoring from host
			--m02_00
			--proxy:OnCharacterTotalDamage( 341, 691, LOCAL_PLAYER, DoreiShop_TotalDamage, "OnEvent_341", once );
			proxy:OnCharacterTotalRateDamage( 341, 679, LOCAL_PLAYER, NPC_ANGRY_Rate, "OnEvent_341", once );
			--m02_01
			--proxy:OnCharacterTotalDamage( 760, 623, LOCAL_PLAYER, DoreiShop_TotalDamage, "OnEvent_760", once );
			proxy:OnCharacterTotalRateDamage( 760, 623, LOCAL_PLAYER, NPC_ANGRY_Rate, "OnEvent_760", once );
			--m02_02
			--proxy:OnCharacterTotalDamage( 1440, 679, LOCAL_PLAYER, DoreiShop_TotalDamage, "OnEvent_1440", once );
			proxy:OnCharacterTotalRateDamage( 1440, 679, LOCAL_PLAYER, NPC_ANGRY_Rate, "OnEvent_1440", once );
		end
		proxy:OnCharacterDead( 1441, 679, "OnEvent_1441", once );
	end
end
--▲------------------▲-------------------------------------------------------------------------------------- --EN:--▲------------------▲---------------------------- -------------------------------------------------- --------

--------------------------------------------------------------------------------------
--■85■王子会話用フラグ制御■ --EN:--■85■Prince Conversation Flag Control■
--------------------------------------------------------------------------------------
function OnEvent_85(proxy,param)
	print("OnEvent_85 begin");
	proxy:SetEventFlag( 85 ,true );
	print("OnEvent_85 end");
end


--------------------------------------------------------------------------------------------------------------------------------------------------------------------
--■7■敵が砲弾ごろごろ■ --EN:-- ■ 7 ■ Enemy's cannonball ■
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function RegistEvent_7(proxy)
	--SingleReset( proxy, 7 );
	if	proxy:IsCompleteEvent( 7 ) == false then
		proxy:OnRegionJustIn( 7, LOCAL_PLAYER, 2006, "OnEvent_7", once );
		proxy:OnSimpleDamage( 7, 246, LOCAL_PLAYER, "OnEvent_7", once );
		proxy:EnableLogic( 246, false );
	else
		proxy:EndAnimation( 1010, 1 );
		proxy:ReconstructBreak( 1011 , 1 );
		proxy:ReconstructBreak( 1012 , 1 );
	end
end

function OnEvent_7(proxy,param)
	print("OnEvent_7 begin");
	proxy:DeleteEvent( 7 );
	proxy:PlayAnimation( 1010, 1 );
	proxy:SetObjEventCollisionFill( 1010, true );
	
	proxy:PlayAnimation( 470 , 3002 );--兵士が蹴る --EN:--Soldier kicks
	proxy:EnableLogic( 246, true );
	
	proxy:SetEventFlag( 7, true );
	
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 7, "OnEvent_7_1", 0.5, 0, 2, once );
	proxy:NotNetMessage_end();
	print("OnEvent_7 end");
end

function OnEvent_7_1(proxy,param)
	print("OnEvent_7_1 begin");
	proxy:OnObjectDamageHit_NoCallPlus( 7, 1010, 1, 10210, EV_HIT_CHR, 1.0, 5.0,1.0, everytime );
	
	print("OnEvent_7_1 end");
end


--------------------------------------------------------------------------------------------------------------------------------------------------------------------
--■6■兵士が火炎瓶を投げる■ --EN:--■ 6 ■ Soldiers throw Molotov cocktails ■
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ThrowFirePotRegist_b1(proxy)
	SingleReset(proxy, 6 );
	if	proxy:IsCompleteEvent( 6 ) == false then
		proxy:OnRegionJustIn( 6, LOCAL_PLAYER, 2005, "OnEvent_6", once );
		proxy:OnRegionJustIn( 6, LOCAL_PLAYER, 2004, "OnEvent_6", once );
		proxy:OnSimpleDamage( 6, 245, LOCAL_PLAYER, "OnEvent_6", once );
		proxy:EnableLogic( 245, false );
	end
end

function OnEvent_6(proxy,param)
	print("OnEvent_6 begin");
	proxy:DeleteEvent( 6 );
	proxy:SetEventFlag( 6, true );
	proxy:PlayAnimation( 245, 6060 );
	if param:GetParam2() == 245 then
		--第2パラが兵士の時は殴られてます --EN:--When the second para is a soldier, it is beaten
		proxy:EnableLogic( 245, true );
	else
		proxy:NotNetMessage_begin();
			proxy:OnKeyTime2( 6,"OnEvent_6_1",4,0,0,once);
		proxy:NotNetMessage_end();
	end
	print("OnEvent_6 end");
end

function OnEvent_6_1(proxy,param)
	print("OnEvent_6_1 begin");
	proxy:EnableLogic( 245 , true );
	print("OnEvent_6_1 end");
end

--[[
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
--■100■篝火に突っ込んだ■ --EN:-- ■ 100 ■ plunged into the bonfire ■
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ObjDamage(proxy,objid)
	--print(objid);
	if proxy:IsReady_Obj(objid) == true then
		proxy:OnObjectDamageHit_NoCall( 100, objid,1,10300,EV_HIT_CHR,0.5,FIREDAM_WAIT,everytime);
	end
	proxy:NotNetMessage_begin();	
		proxy:OnKeyTime2( 100 , "OnEvent_100_"..objid.."_1",FIREDAM_WAIT,0,objid+10000,once);	
	proxy:NotNetMessage_end();
end

function ObjDamage_1(proxy,objid)
	if proxy:IsReady_Obj(objid) == true then
		proxy:OnObjectDamageHit_NoCall( 100, objid,1,10300,EV_HIT_CHR,0.5,FIREDAM_WAIT,everytime);
	end
	proxy:NotNetMessage_begin();	
		proxy:OnKeyTime2( 100 , "OnEvent_100_"..objid,FIREDAM_WAIT,0,objid,once);	
	proxy:NotNetMessage_end();
end

function OnEvent_100_1180(proxy,param) ObjDamage(proxy,1180); end
function OnEvent_100_1180_1(proxy,param) ObjDamage_1(proxy,1180); end
function OnEvent_100_1181(proxy,param) ObjDamage(proxy,1181); end
function OnEvent_100_1181_1(proxy,param) ObjDamage_1(proxy,1181); end
function OnEvent_100_1182(proxy,param) ObjDamage(proxy,1182); end
function OnEvent_100_1182_1(proxy,param) ObjDamage_1(proxy,1182); end
function OnEvent_100_1183(proxy,param) ObjDamage(proxy,1183); end
function OnEvent_100_1183_1(proxy,param) ObjDamage_1(proxy,1183); end
function OnEvent_100_1185(proxy,param) ObjDamage(proxy,1185); end
function OnEvent_100_1185_1(proxy,param) ObjDamage_1(proxy,1185); end
function OnEvent_100_1186(proxy,param) ObjDamage(proxy,1186); end
function OnEvent_100_1186_1(proxy,param) ObjDamage_1(proxy,1186); end
]]

-----------------------------------------------------------------------------
--■■結晶トカゲイベント --EN:-- ■ ■ Crystal lizard event
-----------------------------------------------------------------------------
--ボス撃破時のトカゲリセット用 --EN:--For lizard reset when defeating boss
function ResetTokage(proxy)
	print("ResetTokage");
	--proxy:SetEventFlag(120,false);
	--proxy:SetEventFlag(590,false);
	--proxy:SetEventFlag(592,false);
	--proxy:SetEventFlag(1090,false);
	--proxy:SetEventFlag(1680,false);	
	--proxy:SetEventFlag(1682,false);	
	--proxy:SetEventFlag(1684,false);
	AddEventCounter(proxy,0);
	AddEventCounter(proxy,1);
	AddEventCounter(proxy,2);
	AddEventCounter(proxy,3);
	AddEventCounter(proxy,4);
	AddEventCounter(proxy,5);
	AddEventCounter(proxy,6);
end

-----------------------------------------------------------------------------
--■120■結晶トカゲイベント1 --EN:-- ■ 120 ■ Crystal Lizard Event 1
-----------------------------------------------------------------------------
function OnEvent_120(proxy,param)
	print("OnEvent_120 begin");
	proxy:SetEventFlag( 120, true);
	proxy:DeleteEvent( 120 );
	print("OnEvent_120 end");
end


-----------------------------------------------------------------------------
--■201■処刑場の扉を超えた --EN:-- ■ 201 ■ Beyond the door of the execution ground
-----------------------------------------------------------------------------
function OnEvent_201(proxy,param)
	print("OnEvent_201 begin");
	proxy:SetEventFlag(201,true);
	print("OnEvent_201 end");
end


function OnEvent_450_In(proxy,param)
	print("OnEvent_450_In begin");
	proxy:SetDrawEnable( 300,false );
	proxy:SetDrawEnable( 301,false );
	print("OnEvent_450_In end");
end

function OnEvent_450_Out(proxy,param)
	print("OnEvent_450_Out begin");
	proxy:SetDrawEnable( 300,true );
	proxy:SetDrawEnable( 301,true );
	print("OnEvent_450_Out end");
end


-----------------------------------------------------------------------------
--■8■一般兵士火炎瓶投げる --EN:-- ■ 8 ■ General soldier Throw Molotov cocktail
-----------------------------------------------------------------------------
function OnEvent_8(proxy,param)
	if proxy:IsCompleteEvent( 8 ) == false then
		print("OnEvent_8 begin");
		proxy:SetEventFlag( 8 , true );
		proxy:EnableLogic( 247 , true );
		proxy:PlayAnimation( 247 , 6060 );
		print("OnEvent_8 end");
	end	
end

--後ろからPCが来た --EN:--PC came from behind
function OnEvent_9(proxy,param)
	proxy:DeleteEvent( 8 );
	proxy:EnableLogic( 247 , true );
	proxy:ResetThink( 247 );
end
