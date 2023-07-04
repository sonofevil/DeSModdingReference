
--飛竜の長の攻撃待ち時間(0に設定すると0で割ったあまりを取る処理がおかしくなって数値が壊れるので、必ず0.01以上をtopに入れてやってください。) --EN:--Waifu's attack wait time (If you set it to 0, the process of taking the remainder after dividing by 0 will be strange and the number will be corrupted, so be sure to put 0.01 or more in top.)
HiryuOsa_AttackDelay_under	= 0.00;--飛竜の長の攻撃の待ち時間の下限 --EN:--Lower limit of attack waiting time for wyvern chief
HiryuOsa_AttackDelay_top	= 0.01;--飛竜の長の攻撃の待ち時間の上限 --EN:--Upper limit of waiting time for attack of wyvern chief

HiryuOsa_b4_evid			= 501;--王城4の飛竜の長のイベントID --EN:--Oujou 4 Wyvern Chief Event ID

ElevatorTimer = 10.0;
--------------------------------------------------------------------------------------
--マップ読み込み時に読まれる初期化処理■ --EN:--Initialization process read when reading the map ■
--------------------------------------------------------------------------------------
function Initialize_m02_03_00_00(proxy)
	print("Initialize_m02_03_00_00 begin");
	
--■1560■飛竜の長、出現■ --EN:-- ■ 1560 ■ Wyvern leader appears ■
	if proxy:IsCompleteEvent( 1560 ) == false then
		proxy:OnRegionJustIn( 1560 , LOCAL_PLAYER , 2600 , "OnEvent_1560" , everytime );
		
		proxy:NotNetMessage_begin();
			--ポリ劇開始フェード後に呼ばれるハンドラ --EN:--Handler called after polyplay start fade
			proxy:LuaCall(1560,REMO_START,"OnEvent_1560_RemoStart",once);
			--ポリ劇終了後に呼ばれるハンドラ --EN:--Handler called after the polyplay ends
			proxy:LuaCall(1560,REMO_FINISH,"OnEvent_1560_RemoFinish",once);
			proxy:Warp(  HiryuOsa_b4_evid , 2700 );
		proxy:NotNetMessage_end();
	else
		--演出用(?)のOBJを有効化/無効化する --EN:--Enable/disable OBJ for staging (?)
		proxy:SetDrawEnable( 1720 , true );
		proxy:SetColiEnable( 1720 , true );		
		proxy:SetDrawEnable( 1721 , true );
		proxy:SetColiEnable( 1721 , true );		
		proxy:SetDrawEnable( 1710 , false );
		proxy:SetColiEnable( 1710 , false );		
		proxy:SetDrawEnable( 1711 , false );
		proxy:SetColiEnable( 1711 , false );		
		proxy:SetDrawEnable( 1700 , false );
		proxy:SetColiEnable( 1700 , false );		
		proxy:SetDrawEnable( 1701 , false );
		proxy:SetColiEnable( 1701 , false );
	end


--■1570■ボス部屋に入る■			 --EN:-- ■ 1570 ■ Enter the boss room ■
	--BossRoomIn( proxy, 4480, 1570, 1571, 2892 );--[[グローバルのがコメントアウトされていた]] --EN:--[[globals were commented out]]

	--中ボスが生きているときだけイベント登録 --EN:-- Event registration only when the mid-boss is alive
	if proxy:IsCompleteEvent( 4480 ) == false then
	
		--ソロのときは一度目にボス部屋に入る用のイベントを毎回登録させたいので、対応するフラグをOFFにする。 --EN:-- When soloing, we want to register the event for entering the boss room for the first time every time, so turn off the corresponding flag.
		SingleReset(proxy, 1570);		
	
		--▽同期アニメ再生用の開始ハンドラ(旋回→歩き) --EN:--▽ Start handler for synchronous animation playback (turning → walking)
		proxy:LuaCall( 1571, 1, "OnEvent_1571_1", everytime );
		--▽2回目以降にボス部屋に入るためのイベント配信用 --EN:--▽For event delivery to enter the boss room after the second time
		proxy:LuaCall( 1571 , 5 , "OnEvent_1570_GO_TO_IN" , everytime );
		--▽フラグセット(同期用) --EN:--▽flag set (for synchronization)
		proxy:LuaCall( 1571 , 6 , "OnEvent_1570_flag_set" , everytime );
		
		--誰かがボス前扉をまだ通過していない --EN:--Someone hasn't passed through the boss front door yet
		if proxy:IsCompleteEvent( 1570 ) == false then
		
			--(セッション中に)ボス前の魔法壁を最初に通れるのは生存の人だけ --EN:--(During the session) Only survivors can pass through the magic wall in front of the boss first
			local possible_chr_type = ATTR_HOST + ATTR_LIVE + ATTR_GREY;
			
			proxy:NotNetMessage_begin();
				--▼1570▼扉が開いているときに中に入るためのイベントを追加▼ --EN:--▼1570▼Add an event to enter when the door is open▼
				proxy:OnPlayerActionInRegionAttribute( 1570, 2892, "OnEvent_1570", HELPID_GO_TO_IN, possible_chr_type, everytime );
			proxy:NotNetMessage_end();
		
		else --グレイゴーストできたときようにいると思われる。 --EN:--Gray ghost seems to be like that when it's done.
		
			proxy:NotNetMessage_begin();
				--▼1571▼扉が開いているときに中に入るためのイベントを追加▼ --EN:--▼1571▼Add an event to enter when the door is open▼
				proxy:OnPlayerActionInRegion( 1571, 2892, "OnEvent_1570", HELPID_GO_TO_IN, everytime );--ハンドラは上と同じ --EN:--handler is the same as above
			proxy:NotNetMessage_end();
		
		end
	end
	

--■1540■ボスのポリ劇再生■ --EN:--■ 1540 ■ Boss's polyplay play ■

	if proxy:IsCompleteEvent( 1540 ) == false and proxy:IsCompleteEvent( 1545 ) == false then 
	
		--▼ボス前のポリ劇再生用監視追加 --EN:--▼ Added surveillance for polyplay playback in front of the boss
		proxy:OnRegionJustIn( 1540 , LOCAL_PLAYER , 2896 , "OnEvent_1540" , once );
		
		proxy:NotNetMessage_begin();
--[[
		--■飛竜の長が生きていた場合■ --EN:--■ If the chief of the wyvern is still alive ■
			--ポリ劇開始に呼ばれるハンドラ --EN:--handler called at polyplay start
			proxy:LuaCall(1540, REMO_START, "OnEvent_1540_RemoStart", once);
			--ポリ劇終了後に呼ばれるハンドラ(トリガー起こした人用) --EN:--Handler called after the end of the polyplay (for the person who caused the trigger)
			proxy:LuaCall(1540, REMO_FINISH, "OnEvent_1540_RemoFinish", once);
]]

		--■飛竜の長が死んでいた場合■ --EN:-- If the wyvern leader is dead ■
			--ポリ劇開始に呼ばれるハンドラ --EN:--handler called at polyplay start
			proxy:LuaCall(1545, REMO_START, "OnEvent_1545_RemoStart", once);
			--ポリ劇終了後に呼ばれるハンドラ(トリガー起こした人用) --EN:--Handler called after the end of the polyplay (for the person who caused the trigger)
			proxy:LuaCall(1545, REMO_FINISH, "OnEvent_1545_RemoFinish", once);
		proxy:NotNetMessage_end();
	else
		proxy:SetEventFlag( 4490 , true );
	end


--■1572■ボスが動きだす■	 --EN:-- ■ 1572 ■ Boss begins to move ■
	if proxy:IsCompleteEvent( 4480 ) == false then
		proxy:OnRegionJustIn( 1572 , LOCAL_PLAYER , 2884 , "OnEvent_1572" , everytime );
	end
	

--■4480■ボス死亡■	 --EN:-- ■ 4480 ■ Boss death ■
	proxy:AddFieldInsFilter( 821 );
	if proxy:IsCompleteEvent( 4480 ) ==false then
		proxy:NotNetMessage_begin();
			proxy:OnCharacterDead(4480, 821, "OnEvent_4480", once);
		proxy:NotNetMessage_end();
	end

------------- ▼飛竜系▼ ----------------------------------------------- --EN:-- ▼ Wyvern type ▼ -------------------------------------------- ----

--■1620■領域監視■ --EN:-- ■ 1620 ■ area monitoring ■
	proxy:OnNetRegion(1620 , 2610);	
--■1621■領域監視■ --EN:-- ■ 1621 ■ area monitoring ■
	proxy:OnNetRegion(1621 , 2620);	
--■1622■領域監視■ --EN:-- ■ 1622 ■ area monitoring ■
	proxy:OnNetRegion(1622 , 2630);	
--■1623■領域監視■ --EN:-- ■ 1623 ■ area monitoring ■
	proxy:OnNetRegion(1623 , 2640);
--■1624■領域監視■ --EN:-- ■ 1624 ■ area monitoring ■
	proxy:OnNetRegion(1624 , 2641);
--■1625■領域監視■ --EN:-- ■ 1625 ■ area monitoring ■
	proxy:OnNetRegion(1625 , 2642);
--■1626■領域監視■ --EN:-- ■ 1626 ■ area monitoring ■
	proxy:OnNetRegion(1626 , 2643);
--■1651■領域監視■ --EN:-- ■ 1651 ■ area monitoring ■
	proxy:OnNetRegion(1651 , 2710);
	
--■1590■飛竜の長が警戒している■ --EN:--■1590■The chief of the wyvern is on guard■
	--Second_Initializeで追加(状態フラグをセットした後) --EN:Added with --Second_Initialize (after setting state flags)
	
--■1591■飛竜の長が領域Aをブレス攻撃をする■ --EN:--■ 1591 ■ Wyvern chief performs a breath attack on area A ■
--■1592■飛竜の長が領域Bをブレス攻撃をする■ --EN:--■ 1592 ■ Wyvern leader performs a breath attack on area B ■
--■1593■飛竜の長が領域Cをブレス攻撃をする■ --EN:--■ 1593 ■ Wyvern chief performs a breath attack on area C ■
--■1594■飛竜の長が広場に対してブレス攻撃をする■ --EN:--■1594■The chief of the wyvern performs a breath attack on the square■
--■1599■飛竜の長がゲート前で警戒している■ --EN:--■1599■The chief of the wyvern is on guard in front of the gate■


--■1597■飛竜の長がゲート前に飛んでいく■ --EN:--■1597■The chief of the wyvern flies in front of the gate■
--■1598■飛竜の長が通路前に飛んでいく■ --EN:--■1598■The chief of the wyvern flies in front of the passage■

--■1600■飛竜の長が王の間に飛んでいく（通路前から）■ --EN:--■1600■The chief of the wyvern flies between the kings (from the front of the passageway)■
--■1601■飛竜の長が王の間に飛んでいく（ゲート前から）■ --EN:--■1601■The chief of the wyvern flies between the kings (from in front of the gate)■
--■1602■飛竜の長が王の間を警戒している■ --EN:--■1602■The Chief of the Wyvern is guarding the King's Chamber■
--■1603■飛竜の長が王の間にブレス攻撃をする■ --EN:--■1603■The chief of the flying dragon performs a breath attack between the kings■
--■1604■飛竜の長が、王の間から撤退する■ --EN:--■1604■The chief of the wyvern withdraws from the king's room■
	
	if	proxy:IsCompleteEvent( TYO_STATE_DEAD ) == false then
	--■1670■飛竜の長のHpが75％以下■ --EN:-- ■ 1670 ■ Wyvern leader's HP is 75% or less ■
		SingleReset( proxy, 1670 );
		if	proxy:IsCompleteEvent( 1670 ) == false then
			proxy:OnCharacterHP( 1670, HiryuOsa_b4_evid, "OnEvent_1670", 0.75, once );
		end
		
	--■1671■飛竜の長のHpが50％以下■ --EN:-- ■ 1671 ■ Wyvern leader's HP is less than 50% ■
		SingleReset( proxy, 1671 );
		if	proxy:IsCompleteEvent( 1671 ) == false then
			proxy:OnCharacterHP( 1671, HiryuOsa_b4_evid, "OnEvent_1671", 0.50, once );
		end
			
		--▼飛竜アニメの同期再生用▼ --EN:--▼For synchronous playback of flying dragon animation▼
		proxy:LuaCall( 1590 , 1 , "OnEvent_1590"   				, everytime );--アニメ管理 --EN:--animation management
		proxy:LuaCall( 1590 , 2 , "OnEvent_1590_syncroInvalid"	, everytime );--同期無効化 --EN:--disable synchronization
		
		proxy:LuaCall( 1590 , 3 , "OnEvent_1590_3"				, everytime );--通路待機 --EN:--Aisle waiting
		
		proxy:LuaCall( 1590 ,10 , "Osa_ForceSynchroAnime" 			, everytime );--同期アニメ用 --EN:--For synchronous animation
		
		proxy:LuaCall( 1591 , 1 , "OnEvent_1591_1"				, everytime );--ブレスA --EN:--Breath A
		proxy:LuaCall( 1591 , 2 , "OnEvent_1591_2"				, everytime );--ブレスA --EN:--Breath A
		proxy:LuaCall( 1592 , 1 , "OnEvent_1592_1"				, everytime );--ブレスB --EN:--Breath B
		proxy:LuaCall( 1592 , 2 , "OnEvent_1592_2"				, everytime );--ブレスB --EN:--Breath B
		proxy:LuaCall( 1593 , 1 , "OnEvent_1593_1"				, everytime );--ブレスC --EN:--Breath C
		proxy:LuaCall( 1593 , 2 , "OnEvent_1593_2"				, everytime );--ブレスC --EN:--Breath C
		
		proxy:LuaCall( 1594 , 1 , "OnEvent_1594_1"				, everytime );--広場ブレスA --EN:--Square Breath A
		proxy:LuaCall( 1594 , 2 , "OnEvent_1594_2"				, everytime );--広場ブレスA --EN:--Square Breath A
		proxy:LuaCall( 1660 , 1 , "OnEvent_1660_1"				, everytime );--広場ブレスB --EN:--Square Breath B
		proxy:LuaCall( 1660 , 2 , "OnEvent_1660_2"				, everytime );--広場ブレスB --EN:--Square Breath B
		proxy:LuaCall( 1661 , 1 , "OnEvent_1661_1"				, everytime );--広場ブレスC --EN:--Square Breath C
		proxy:LuaCall( 1661 , 2 , "OnEvent_1661_2"				, everytime );--広場ブレスC --EN:--Square Breath C
		
		proxy:LuaCall( 1662 , 1 , "OnEvent_1662_1"				, everytime );--広場待機 --EN:--Plaza waiting
		
		proxy:LuaCall( 1596 , 1 , "OnEvent_1596_1"				, everytime );--ゲート死亡 --EN:--Gate death
		proxy:LuaCall( 1597 , 1 , "OnEvent_1597_1"				, everytime );--ゲートへ移動 --EN:--Move to Gate
		proxy:LuaCall( 1598 , 1 , "OnEvent_1598_1"				, everytime );--通路へ移動 --EN:--Move to passage
		
		proxy:LuaCall( 1595 , 1 , "OnEvent_1595_1"				, everytime );--通路で死亡 --EN:--died in hallway
	end
	
	
	

----------- ▲飛竜系▲ --------------------------------------------------------- --EN:-- ▲ Wyvern type ▲ -------------------------------------------- --------------


--■1635■エレベータが昇る■ --EN:-- ■ 1635 ■ elevator rises ■
--■1636■エレベータが降りる■ --EN:-- ■ 1636 ■ Elevator gets off ■
--(Second_Initializeで監視追加) --EN:--(monitoring added in Second_Initialize)



--■4500■クライアントPCワープ演出■ --EN:-- ■ 4500 ■ Client PC warp effect ■
	--(ボス死亡:OnEvent_4480 から連動) --EN:--(Boss death: linked from OnEvent_4480)

--■4502■シングル：光の壁、BGM消去■ --EN:-- ■ 4502 ■ Single: Wall of Light, BGM Elimination ■
	--(ボス死亡:OnEvent_4480 から連動) --EN:--(Boss death: linked from OnEvent_4480)

--■4503■ソウル入手■ --EN:-- ■ 4503 ■ Get Soul ■
	--(ボス死亡:OnEvent_4480 から連動) --EN:--(Boss death: linked from OnEvent_4480)

--■4504■ボスアイテム入手処理■ --EN:-- ■ 4504 ■ Boss Item Acquisition ■
	--(ボス死亡:OnEvent_4480 から連動) --EN:--(Boss death: linked from OnEvent_4480)

--■4505■石柱にワープ■ --EN:-- ■ 4505 ■ Warp to the stone pillar ■
	--(ソウル入手:OnEvent_4503 から連動) --EN:-- (Obtained from Soul: Linked from OnEvent_4503)



--■??■徘徊デーモンの登場■ハンドラ登録 --EN:--■??■Appearance of wandering daemon■Handler registration
	proxy:NotNetMessage_begin();
		--プレイヤーがソロで死亡した時にキックされます。 --EN:--Kicked when a player dies solo.
		proxy:LuaCall( 4000, 100, "PlayerDeath_m02_03_00_00", everytime );
		--プレイヤーが復活した時にキックされます。 --EN:--Kicked when the player is revived.
		proxy:LuaCall( 4032, 100, "PlayerRevive_m02_03_00_00", everytime );
	proxy:NotNetMessage_end();
	


--■1635,1636■エレベータ関連初期化■ --EN:-- ■ 1635, 1636 ■ Elevator-related initialization ■
--エレベータギミック：アクションID内訳 --EN:-- Elevator Gimmick: Action ID Breakdown
--1630		エレベータの上下状態管理(false:下	true:上) --EN:--1630 Elevator vertical state management (false: down true: up)
--1631		エレベータのアニメ中判定用 --EN:--1631 For judging elevator animation
--1635		エレベータの発動領域監視 --EN:--1635 Elevator activation area monitoring
--1636		エレベータが上にあるときに誰もエレベータ内にいなくなった時、下に降ろす判定用 --EN:--1636 For judging to lower the elevator when no one is in the elevator when it is up
	proxy:SetIsAnimPauseOnRemoPlayForEvent(1620,true);
	proxy:OnNetRegion( 1636, 2651 );
	--ホストの場合は必ず初期状態を下に(もし、ボス戦で敗れて上にあるままだと進行不能な為) --EN:--If you are the host, be sure to put the initial state on the bottom (because if you lose the boss battle and stay on the top, you can't progress)
	if	proxy:IsClient() == false then
		proxy:SetEventFlag( 1630, false );
		proxy:SetEventFlag( 1631, false );
		proxy:PlayLoopAnimation( 1620 , 0 );
	--クライアントの場合は上下の状態を見て合わせる --EN:--In the case of a client, match by looking at the top and bottom states
	else
		--エレベータ上下の状態をホストの世界にあわせる --EN:--Adjust the state of the elevator up and down to the host world
		if	proxy:IsCompleteEvent( 1630 ) == true then
			proxy:EndAnimation( 1620, 1 );
		else
			proxy:EndAnimation( 1620, 0 );
		end
	end
	
	proxy:OnPlayerActionInRegion( 1635 , 2650 , "OnEvent_1635" , HELPID_START , everytime );--昇る用 --EN:--For climbing
	--[[
	proxy:NotNetMessage_begin();
		proxy:OnRegionJustOut( 1635, LOCAL_PLAYER, 2651, "OnEvent_1635_Out", everytime );
	proxy:NotNetMessage_end();
	]]
	proxy:LuaCall(1635, 2, "OnEvent_1635_flag", everytime);--上下フラグ同期 --EN:--Upper and lower flag synchronization
	proxy:LuaCall(1635, 3, "OnEvent_1635", everytime );--動作同期 --EN:-- Operation synchronization
	proxy:LuaCall(1635, 4, "OnEvent_1635_animeflag",everytime);--アニメ中同期 --EN:-- Synchronization during animation
	
	proxy:LuaCall(1635, 5, "OnEvent_1635_UpAnime",everytime);
	proxy:LuaCall(1635, 6, "OnEvent_1635_DownAnime",everytime);
	


	--proxy:SetEventFlag( 1630 , true ); --エレベータが下にあるフラグON --EN:--Elevator down flag ON
	--proxy:SetEventFlag( 1631 , false );--エレベータが上にあるフラグOFF --EN:--Elevator up flag OFF

	--proxy:OnDistanceActionPlus( 1635 , LOCAL_PLAYER, 1620, "OnEvent_1635" , 1, HELPID_START , 0, 100, 0.0, 0.0, 0.0, everytime );--昇る用 --EN:--For climbing
--	proxy:OnPlayerActionInRegion( 1636 , 2651 , "OnEvent_1636" , HELPID_START , everytime );--降りる用 --EN:--for getting off

	
--■1780■敵が落ちてくる■ --EN:-- ■ 1780 ■ enemies fall ■
	if	proxy:IsCompleteEvent( 1780 ) == false then
		proxy:OnRegionJustIn( 1780, LOCAL_PLAYER, 2656, "OnEvent_1780", once );
		proxy:OnSimpleDamage( 1780, 512, -1, "OnEvent_1780", once );
		proxy:EnableLogic( 512, false );
		proxy:Warp( 512, 2655 );
	end
	
--■ボス関連の初期化処理 --EN:--■ Boss-related initialization processing
	if proxy:IsCompleteEvent( 4480 ) ==true then
		
		--▽ボス死んでいるとき --EN:--▽When the boss is dead
		--ボスいなくなる --EN:--boss disappears
		InvalidBackRead( proxy , 821 );
		
		--魔法壁消える(このマップは魔法壁一つ) --EN:--Magic wall disappears (this map has one magic wall)
		proxy:SetColiEnable( 1996 , false );
		proxy:SetDrawEnable( 1996 , false );	

		--魔法壁のSFX OFF --EN:--Magic Wall SFX OFF
		proxy:InvalidSfx( 1988 , true );
		
	else
	    --▽ボス生きているとき		 --EN:--▽ When the boss is alive
		proxy:EnableLogic( 821 , false );--ロジックOFFで待機		 --EN:--Wait with logic OFF
	end		

	--レンドル王の死んだ後、要石でボイス再生 --EN:-- After the death of King Lendor, the voice is played on the keystone
	proxy:RegistSimpleTalk( 4510 , 1979 , 28000, TALK_ATTR_ALL );

--■4503,4505■ソウル入手、要石でワープ■ --EN:-- ■ 4503, 4505 ■ Get soul, warp with keystone ■
	if proxy:IsCompleteEvent( 4480 ) ==true then--ボスが死んでいるとき --EN:--when the boss is dead
		
		proxy:TreasureDispModeChange2( 1979 , true ,KANAME_SFX);--光らせる --EN:-- let it shine
		--▼(ソウル)アイテム取得用イベント監視追加▼ --EN:--▼ (Soul) Added event monitoring for item acquisition▼
		if proxy:IsCompleteEvent( 4503 ) == false then
			proxy:ValidSfx( 1640 );--SFX 有効化 --EN:--SFX enable
			proxy:ValidSfx( 1641 );--光の粒子			 --EN:--Particles of light
			proxy:OnDistanceActionAttribute( 4503 , LOCAL_PLAYER , 1979 , "OnEvent_4503" , WarpGimmickDist_A , 10010180 , 0 , 180 , ATTR_HOST + ATTR_LIVE + ATTR_GREY, once );

			--ソウル有効化 --EN:--Soul activation
			proxy:SetDrawEnable( 1979 , true );
			proxy:SetColiEnable( 1979 , true );
			--ソウル2有効化 --EN:--Activate Soul 2
			proxy:SetDrawEnable( 1978 , true );
			proxy:SetColiEnable( 1978 , true );

		else
			--▼要石でワープ用の監視を追加▼ --EN:--▼ Added surveillance for warp with keystone ▼
			proxy:InvalidSfx( 1640, false );--SFX 無効化 --EN:--Disable SFX
			--proxy:InvalidSfx( 1641, false );--光の粒子 --EN:--Particles of light
			SingleReset( proxy , 4505);
			proxy:OnDistanceActionAttribute( 4505 , LOCAL_PLAYER , 1979 , "OnEvent_4505" , WarpGimmickDist_A , HELPID_GO_TO_SEKITYUU , 0 , 180 , ATTR_NOSESSION , everytime );
		end

	else
		--ソウル無効化 --EN:--Soul Invalidation
		proxy:SetDrawEnable( 1979 , false );
		proxy:SetColiEnable( 1979 , false );
		--ソウル2無効化 --EN:--Soul 2 disabled
		proxy:SetDrawEnable( 1978 , false );
		proxy:SetColiEnable( 1978 , false );
		--SFX 無効化 --EN:--Disable SFX
		proxy:InvalidSfx( 1640 , false );
		proxy:InvalidSfx( 1641 , false );
	end
	
	


--■飛竜(長)イベント関連初期化 --EN:-- ■ Wyvern (Long) event-related initialization
	if	proxy:IsClient() == false then
		proxy:RequestForceUpdateNetwork(HiryuOsa_b4_evid);
	end
	

--■8084■王城に来たフラグを立てる■ --EN:-- ■ 8084 ■ Raise a flag for coming to the royal castle ■
	proxy:SetEventFlag(8084, true);
	
	--■1706■一定領域進入で王子が死ぬ■ --EN:-- ■ 1706 ■ The prince dies when entering a certain area ■
	RegistEvent_1706(proxy);
	
	--■1640■レンドル王子・ブラック死亡■ --EN:-- ■ 1640 ■ Prince Lendl Black died ■
	RegistEvent_1640(proxy);
	
	--結晶トカゲイベント --EN:--Crystal Lizard Event
	RegistTokage(proxy,1680,257,4);
	RegistTokage(proxy,1682,258,5);
	RegistTokage(proxy,1684,259,6);	
	
--■1690■三銃士1が死んだ■ --EN:-- ■ 1690 ■ Three Musketeers 1 died ■
	if proxy:IsCompleteEvent( 1690 ) == false then
		proxy:OnCharacterDead( 1690 , 530 , "OnEvent_1690",once);
	else
		InvalidBackRead( proxy,530 );
	end
--■1691■三銃士2が死んだ■ --EN:-- ■ 1691 ■ Three Musketeers 2 died ■
	if proxy:IsCompleteEvent( 1691 ) == false then
		proxy:OnCharacterDead( 1691 , 531 , "OnEvent_1691",once);
	else
		InvalidBackRead( proxy, 531 );
	end
--■1692■三銃士3が死んだ■ --EN:-- ■ 1692 ■ The Three Musketeers 3 died ■
	if proxy:IsCompleteEvent( 1692 ) == false then
		proxy:OnCharacterDead( 1692 , 532 , "OnEvent_1692",once);
	else
		InvalidBackRead( proxy, 532 );
	end


--------------------------------▽▽▽QWCイベント関連▽▽▽-------------------------------- --EN:--▽▽▽QWC event related ▽▽▽--------------------------------
--------------------------------△△△QWCイベント関連△△△-------------------------------- --EN:--△△△QWC event related△△△--------------------------------
	--■999999■フレーム遅れの初期化処理イベントを発行■ --EN:-- ■ 999999 ■ Generate a frame delay initialization processing event ■
	proxy:NotNetMessage_begin();
		--▼0秒後▼-- --EN:--▼After 0 seconds▼--
		proxy:OnKeyTime2( 999993, "Second_Initialize_m02_03_00_00", 0.0, 0, 0, once );
	proxy:NotNetMessage_end();	


	--■15500■乱入アイテム取得監視■ハンドラはグローバルに定義 --EN:-- ■ 15500 ■ Intrusion item acquisition monitoring ■ Handlers are defined globally
	--if proxy:IsCompleteEvent( 15500 ) == false then
	--	proxy:AddCorpseEvent( 15500 , 530 );--三銃士A --EN:--Three Musketeers A
	--	proxy:AddCorpseEvent( 15500 , 531 );--三銃士B --EN:--Three Musketeers B
	--	proxy:AddCorpseEvent( 15500 , 532 );--三銃士C --EN:--Three Musketeers C
	--end
	
	print("Initialize_m02_03_00_00 end");
end

function Second_Initialize_m02_03_00_00(proxy,param)
	print("Second_Initialize_m02_03_00_00 begin");
--------------------------------▽▽▽QWCイベント関連▽▽▽-------------------------------- --EN:--▽▽▽QWC event related ▽▽▽--------------------------------
--------------------------------△△△QWCイベント関連△△△-------------------------------- --EN:--△△△QWC event related△△△--------------------------------
	print("Second_Initialize_m02_03_00_00 end");
end

--------------------------------------------------------------------------------------
--マルチになった時にホストじゃ無かったら■無し --EN:--If you are not a host when you become multi, no
--------------------------------------------------------------------------------------
function ConnectPartyEvent(proxy)
	print("ConnectPartyEvent begin");
	print("ConnectPartyEvent end");
end


--------------------------------------------------------------------------------------
--徘徊デーモンの登場■?? --EN:-- Appearance of the Wandering Demon ??
--------------------------------------------------------------------------------------

--▼グローバルの死亡監視から呼ばれる(ソロ) --EN:--▼ Called from global death watch (solo)
function PlayerDeath_m02_03_00_00(proxy, param)
	print("PlayerDeath_m02_03_00_00");
	print("PlayerDeath_m02_03_00_00");
end

--▼グローバルの血文字復活から呼ばれる(ソロ) --EN:--▼Called from global blood letter revival (solo)
function PlayerRevive_m02_03_00_00(proxy,param)
	print("PlayerRevive_m02_03_00_00");
	print("PlayerRevive_m02_03_00_00");
end




--------------------------------------------------------------------------------------
--■1560■飛竜の長、出現■ --EN:-- ■ 1560 ■ Wyvern leader appears ■
--------------------------------------------------------------------------------------

function OnEvent_1560(proxy , param)
	print("OnEvent_1560 begin");

	--多重発動防止 --EN:--Multiple activation prevention
	if proxy:IsCompleteEvent( 1560 ) == true then
		print("OnEvent_1560 end");
		return;
	end
	
	--現在の状態取得 --EN:-- Get current status
	local now_state = GetNpcStateFlag(proxy ,param, tyo_flag_list);
	
	--飛竜の状態が警戒(通路)のとき --EN:--When the wyvern's status is alert (passage)
	if now_state == TYO_STATE_WARNING_AISLE then 
		
		--ポリ劇再生 --EN:--Poly play
		proxy:RequestRemo(20300,REMO_FLAG,1560,1);
		proxy:SetEventFlag( 1560 , 1 );--フラグセット --EN:--flag set
	end
	
	print("OnEvent_1560 end");
end


--■ポリ劇再生開始(フェード終了) --EN:--■ Start of polyplay playback (end of fade)
function OnEvent_1560_RemoStart(proxy,param)
	print("OnEvent_1560_RemoStart begin");
	
	--このタイミングで有効化するオブジェ --EN:--Object to activate at this timing
	proxy:SetDrawEnable( 1710 , true );
	proxy:SetColiEnable( 1710 , true );
	
	proxy:SetDrawEnable( 1711 , true );
	proxy:SetColiEnable( 1711 , true );
	ValidCharactor( proxy , HiryuOsa_b4_evid );--飛竜有効化 --EN:--enable wyvern
	
	print("OnEvent_1560_RemoStart end");
end


--■ポリ劇再生終了(フェード終了) --EN:-- End of polyplay playback (end of fade)
function OnEvent_1560_RemoFinish(proxy , param)
	print("OnEvent_1560_RemoFinish begin");
	
	proxy:DeleteEvent( 1560 );--everytimeなので消す --EN:--everytime so delete
	
	proxy:Warp(  HiryuOsa_b4_evid , 2700 );	
	proxy:ForcePlayAnimationStayCancel( HiryuOsa_b4_evid, 7001 );

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
	
	proxy:SetDrawEnable( 1710 , false );
	proxy:SetColiEnable( 1710 , false );
	
	proxy:SetDrawEnable( 1711 , false );
	proxy:SetColiEnable( 1711 , false );
	
	proxy:SetDrawEnable( 1700 , false );
	proxy:SetColiEnable( 1700 , false );
	
	proxy:SetDrawEnable( 1701 , false );
	proxy:SetColiEnable( 1701 , false );	

	print("OnEvent_1560_RemoFinish end");
end




--------------------------------------------------------------------------------------
--ボス部屋の中に入る■1570 --EN:--Enter the boss room 1570
--------------------------------------------------------------------------------------

--■イベントがループなので、全部リピートにする↓ --EN:--■ Since the event is a loop, repeat all ↓

--■1570■中ボス部屋への扉が開く■ --EN:-- ■ 1570 ■ The door to the mid-boss room opens ■
function OnEvent_1570(proxy,param)
	print("OnEvent_1570 begin");
	
	--エレベータアニメ再生中は入れないようにはじく --EN:-- Flip not to enter while the elevator animation is playing
	if proxy:IsCompleteEvent( 1631 ) == true then
		print("OnEvent_1570 return end");
		return;
	end

	if proxy:IsCompleteEvent( SYSTEM_ID_IGNORE ) == true then
		print("OnEvent_1570 end");
		return;
	end
	
	--クライアントへ、ボス部屋阻止失敗を通知 --EN:--Notify client of failure to block boss room
	if proxy:IsClient() == false then
		proxy:LuaCallStart( 4068 , 1 );	
	end
	
	proxy:LuaCallStart( 1571 , 1 );--旋回アニメの同期再生 --EN:-- Synchronous playback of turning animation
	--proxy:SetEventFlag( SYSTEM_ID_IGNORE , 1 );--多重発動防止用 --EN:--For multiple activation prevention
	--多重起動システムIDをタイムアウトを設定してONにする --EN:--Turn on multiple activation system ID by setting timeout
	proxy:SetSystemIgnore( SYSTEM_ID_IGNORE , IGNORE_TIME );
	
	--プロファイルセーブ要求 --EN:--profile save request
	proxy:SaveRequest_Profile();
	
	print("OnEvent_1570 end");
end


--旋回アニメの同期再生(IDが別) --EN:-- Synchronized playback of turning animation (ID is different)
function OnEvent_1571_1(proxy,param)
	print("OnEvent_1571_1 begin");
	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		if param:IsNetMessage() == true then
			--旋回アニメ再生を行い、その終了時にOnEvent_1571_2を発行する --EN:--Play the turning animation and issue OnEvent_1571_2 at the end
			proxy:TurnCharactor( 10001 + param:GetPlayID(), 2888 );
		else
			proxy:LockSession();--ルームをロックします！ --EN:--lock the room!
			--旋回アニメ再生を行い、その終了時にOnEvent_1571_2を発行する --EN:--Play the turning animation and issue OnEvent_1571_2 at the end
			proxy:OnTurnCharactorEnd( 1571, LOCAL_PLAYER, 2888, "OnEvent_1571_2", once );
		end
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	
	print("OnEvent_1571_1 end");
end

--旋回アニメの同期再生終了後 --EN:--After synchronous playback of turning animation ends
function OnEvent_1571_2(proxy,param)
	print("OnEvent_1571_2 begin");
	
	--同期用歩きアニメ再生 --EN:--Play walking animation for synchronization
	proxy:LuaCallStart( 4012, 1 );
	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		proxy:OnChrAnimEnd( 1571, LOCAL_PLAYER, ANIMEID_WALK, "OnEvent_1571_3", once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
		
	print("OnEvent_1571_2 end");
end

--歩きアニメの同期再生終了後 --EN:--After the synchronized playback of the walking animation ends
function OnEvent_1571_3(proxy,param)
	print("OnEvent_1571_3 begin");

	--最初の人がボス部屋の中に入り終わっていたら、既に配信されているはずなので、もうおくらないハンドラ --EN:--If the first person has already entered the boss room, it should have already been delivered, so no more handlers
	if proxy:IsCompleteEvent( 1570 ) == false then
		proxy:LuaCallStart( 1571 , 5 );--2回目以降にボス部屋に入るためのイベント配信用 --EN:--For event delivery to enter the boss room after the second time
		proxy:LuaCallStart( 4045 , 1 );	--クライアントへ、ボス部屋に入れるようになったことを通知 --EN:--Notify clients that they can now enter the boss room
		proxy:LuaCallStart( 1571 , 6 );--フラグセット(同期用) --EN:--flag set (for synchronization)
		Lua_MultiDoping(proxy,821);--マルチプレイドーピング --EN:-- Multiplayer Doping
	end

	--プレイヤーが扉の中に完全にはいったタイミングで、ボスの思考をリセット --EN:--Reset the boss' thoughts when the player is completely inside the door
	--場所が悪いとプレイヤーを見つけれないため(攻撃してこない) --EN:--Because you can't find the player if the location is bad (they won't attack)
	if proxy:IsClient() == false then
		proxy:ResetThink( 821 );
	end
	
	proxy:SetEventFlag( SYSTEM_ID_IGNORE , 0 );--多重発動防止用	 --EN:--For multiple activation prevention
	
	print("OnEvent_1571_3 end");
end


--■1570 2回目以降にボス部屋に入るためのイベント配信用 --EN:--■ 1570 For event delivery to enter the boss room after the second time
function OnEvent_1570_GO_TO_IN(proxy, param)
	print("OnEvent_1570_GO_TO_IN begin");
		
	proxy:NotNetMessage_begin();
		--▼1571▼扉が開いているときに中に入るためのイベントを追加▼--ハンドラは OnEvent_1570 --EN:--▼1571▼Add an event to enter when the door is open▼--The handler is OnEvent_1570
		proxy:OnPlayerActionInRegion( 1571, 2892, "OnEvent_1570", HELPID_GO_TO_IN, everytime );--
	proxy:NotNetMessage_end();	
	
	print("OnEvent_1570_GO_TO_IN end");
end


--■1570 フラグセット(同期用) --EN:-- 1570 flag set (for synchronization)
function OnEvent_1570_flag_set(proxy, param)
	print("OnEvent_1570_flag_set begin");
		
	proxy:SetEventFlag( 1570 , 1 );
	proxy:DeleteEvent( 1570 );

	print("OnEvent_1570_flag_set end");
end



--------------------------------------------------------------------------------------
--中ボスポリ劇再生■1540 --EN:--Middle Bospoli play ■ 1540
--------------------------------------------------------------------------------------

function OnEvent_1540(proxy, param)
	print("OnEvent_1540 begin");
--[[	

	--現在の状態取得 --EN:-- Get current status
	local now_tyo_state = GetNpcStateFlag( proxy , param , tyo_flag_list );
	if now_tyo_state == TYO_STATE_DEAD then
		--ポリ劇再生開始 --EN:--Start playing polyplay
		proxy:RequestRemo(20302,REMO_FLAG,1545,1);
	else
		--ポリ劇再生開始 --EN:--Start playing polyplay
		proxy:RequestRemo(20301,REMO_FLAG,1540,1);
	end
]]
	proxy:RequestRemo(20302,REMO_FLAG,1545,1);
	proxy:SetEventFlag( 1545 , 1 );--ポリ劇再生終了 --EN:--End of polyplay play
	print("OnEvent_1540 end");
end

--[[
--■1540_RemoStart■ポリ劇開始 フェードアウト完了■ --EN:--■ 1540_RemoStart ■ Poly drama start Fade-out complete ■
function OnEvent_1540_RemoStart(proxy,param)
	print( "OnEvent_1540_RemoStart begin" );
	
	proxy:SetDrawEnable( 821 , false );
	
	print( "OnEvent_1540_RemoStart end" );
end


--■1540_RemoFinish■ポリ劇再生終了後■ --EN:--■ 1540_RemoFinish ■ After playing the polyplay ■
function OnEvent_1540_RemoFinish(proxy , param)
	print( "OnEvent_1540_RemoFinish begin" );

	proxy:SetDrawEnable( 821 , true );
	proxy:SetEventFlag( 1540 , 1 );--ポリ劇再生終了 --EN:--End of polyplay play

	print( "OnEvent_1540_RemoFinish end" );
end
]]

--■1545_RemoStart■ポリ劇開始 フェードアウト完了■ --EN:--■ 1545_RemoStart ■ Poly drama start Fade-out complete ■
function OnEvent_1545_RemoStart(proxy,param)
	print( "OnEvent_1545_RemoStart begin" );
	
	proxy:SetDrawEnable( 821 , false );
	
	print( "OnEvent_1545_RemoStart end" );
end


--■1545_RemoFinish■ポリ劇再生終了後■ --EN:--■ 1545_RemoFinish ■ After playing the polyplay ■
function OnEvent_1545_RemoFinish(proxy , param)
	print( "OnEvent_1545_RemoFinish begin" );

	proxy:SetDrawEnable( 821 , true );
	proxy:SetEventFlag( 4490 , true );

	print( "OnEvent_1545_RemoFinish end" );
end

--[[
--------------------------------------------------------------------------------------
--中ボスポリ劇2再生■1545 --EN:--Middle Bospoli play 2 playback 1545
--------------------------------------------------------------------------------------

function OnEvent_1545(proxy, param)
	print("OnEvent_1545 begin");

	--ポリ劇再生開始 --EN:--Start playing polyplay
	proxy:RequestRemo(20302,REMO_FLAG,1545,1);
	
	print("OnEvent_1545 end");
end


--■1540_RemoStart■ポリ劇開始 フェードアウト完了■ --EN:--■ 1540_RemoStart ■ Poly drama start Fade-out complete ■
function OnEvent_1545_RemoStart(proxy,param)
	print( "OnEvent_1545_RemoStart begin" );
	
	proxy:SetDrawEnable( 821 , false );
	
	print( "OnEvent_1545_RemoStart end" );
end


--■1540_RemoFinish■ポリ劇再生終了後■ --EN:--■ 1540_RemoFinish ■ After playing the polyplay ■
function OnEvent_1545_RemoFinish(proxy , param)
	print( "OnEvent_1545_RemoFinish begin" );

	proxy:SetDrawEnable( 821 , true );
	proxy:SetEventFlag( 1545 , 1 );--ポリ劇再生終了 --EN:--End of polyplay play

	print( "OnEvent_1545_RemoFinish end" );
end
]]


--------------------------------------------------------------------------------------
--ボスが動き出す(戦闘開始)■1572 --EN:--Boss begins to move (battle begins) 1572
--------------------------------------------------------------------------------------

function OnEvent_1572(proxy, param)
	if proxy:IsCompleteEvent( 4490 ) == false then
		return;
	end
	print("OnEvent_1572 begin");
	
	--ボス戦用BGM再生開始 --EN:--Start playing BGM for boss battle
	proxy:PlayPointSE( 2660, SOUND_TYPE_M, 20300000, 3 );
	
	--ボスロジックON --EN:--Boss logic ON
	proxy:EnableLogic( 821 , true );
	
	--読み込みタイミングのとき毎回追加されてほしいのでフラグたてない --EN:-- I want it to be added every time at the time of reading, so I don't set a flag
	
	--ボスゲージ表示 --EN:-- Boss gauge display
	proxy:SetBossGauge( 821 , 0 ,6010 );
	
	--監視削除 --EN:--Delete monitor
	proxy:DeleteEvent( 1572 );
	
	print("OnEvent_1572 end");
end




--------------------------------------------------------------------------------------
--■4480■中ボス死亡■ --EN:-- ■ 4480 ■ Mid-boss death ■
--------------------------------------------------------------------------------------

--■4480■中ボス死亡■ --EN:-- ■ 4480 ■ Mid-boss death ■
function OnEvent_4480(proxy, param)
	print("OnEvent_4480 begin");

	proxy:NotNetMessage_begin();
		--▼4500▼クライアントPCワープ演出▼ --EN:--▼4500▼Client PC warp effect▼
		proxy:OnKeyTime2( 4500, "OnEvent_4500", 0, 0, 0, once);	
		--▼4481▼1秒経過▼ --EN:--▼4481▼1 second passed▼
		proxy:OnKeyTime2( 4481, "OnEvent_4481", 1, 0, 1, once);
		--▼4502▼2秒経過▼ --EN:--▼4502▼2 seconds passed▼
		proxy:OnKeyTime2( 4502, "OnEvent_4502", 2, 0, 2, once);	
		--マルチ解散監視 --EN:--Multi-Dismissal Monitoring
		proxy:OnRegistFunc( 4480 , "Check_4480_PT","OnEvent_4480_PT",0,once);
	proxy:NotNetMessage_end();
	
	--PCに付いた特殊効果を無効化 --EN:--Disable special effects on PC
	if proxy:EraseEventSpecialEffect_2(LOCAL_PLAYER, 5007) == true then
		print("★★5030のエフェクトを消去★★"); --EN:print("Remove ★★5030 effects★★");
	else
		print("5030のエフェクトを消去失敗"); --EN:print("Failed to erase 5030 effects");
	end
	if proxy:EraseEventSpecialEffect_2(LOCAL_PLAYER, 5008) == true then
		print("★★5031のエフェクトを消去★★"); --EN:print("Remove ★★5031 effects★★");
	else	
		print("5031のエフェクトを消去失敗"); --EN:print("Failed to erase 5031 effects");
	end
	if proxy:EraseEventSpecialEffect_2(LOCAL_PLAYER, 5009) == true then
		print("★★5032のエフェクトを消去★★"); --EN:print("Remove ★★5032 effects★★");
	else	
		print("5032のエフェクトを消去失敗"); --EN:print("Failed to erase 5032 effects");
	end
	
	--proxy:EraseEventSpecialEffect(LOCAL_PLAYER, 5030);
	--proxy:EraseEventSpecialEffect(LOCAL_PLAYER, 5031);
	--proxy:EraseEventSpecialEffect(LOCAL_PLAYER, 5032);
	
	--ブロッククリア処理へ --EN:-- to block clear processing
	proxy:CustomLuaCallStart( 4050, 821 );	
	--結晶トカゲリセット --EN:-- crystal lizard reset
	ResetTokage(proxy);
	
	proxy:SetEventFlag( 4480, 1 );--ボス死亡フラグON --EN:--Boss death flag ON
	
	--レンドル死亡に連動してレンドル王子がもういない状態に --EN:--In conjunction with the death of Lendl, Prince Lendl no longer exists
	--[[
	if	proxy:IsCompleteEvent( RENDOL_STATE_LIFT_FRONT ) == true then
		SetNpcStateFlag( proxy, param, rendol_flag_list, RENDOL_STATE_ERASE );
			InvalidCharactor( proxy, 626 );
	end
	]]

	--ビヨルングルム(レンドル王を倒した時に、飛竜の長と戦っていたらもういない状態へ) --EN:--Bjrn Grum (If you were fighting the Wyvern Chief when you defeated King Lendor, you'd be gone)
	if proxy:IsCompleteEvent( BIYO_STATE_BATTLE_FLY_DRAGON ) == true then
		SetNpcStateFlag( proxy , param , biyo_flag_list , BIYO_STATE_EXIT );
		proxy:SetEventFlag( 1710, true );
	end	
	
	print("OnEvent_4480 end");
end

--▲4481▲中ボス死亡後1秒▲ --EN:--▲4481▲1 second after death of mid-boss▲
function OnEvent_4481(proxy, param)
	print("OnEvent_4481 begin");
	
	--ボスを倒した数を更新(数によってフラグを立てる) --EN:--update number of bosses killed (flag by number)
	GetBossFlagCount( proxy, param );
	
	--▼トロフィー取得判定▼ --EN:--▼Trophy Acquisition Judgment▼
	Lua_RequestUnlockTrophy(proxy, 6);
	
	--▼(ソウル)アイテム取得用イベント監視追加▼ --EN:--▼ (Soul) Added event monitoring for item acquisition▼
	if proxy:IsCompleteEvent( 4503 ) == false then
	
		--ソウル有効化 --EN:--Soul activation
		proxy:SetDrawEnable( 1979 , true );
		proxy:SetColiEnable( 1979 , true );
		--ソウル2有効化 --EN:--Activate Soul 2
		proxy:SetDrawEnable( 1978 , true );
		proxy:SetColiEnable( 1978 , true );

		proxy:ValidSfx( 1640 );--SFX 有効化 --EN:--SFX enable
		proxy:ValidSfx( 1641 );--SFX 有効化 --EN:--SFX enable
		proxy:TreasureDispModeChange2( 1979 , true ,KANAME_SFX);--光らせる --EN:-- let it shine
		proxy:OnDistanceActionAttribute( 4503 , LOCAL_PLAYER , 1979 , "OnEvent_4503" , WarpGimmickDist_A , 10010180 , 0 , 180 , ATTR_HOST + ATTR_LIVE + ATTR_GREY, once );
	else
		--ソウル無効化(取ったら消えるので･･･) --EN:--Soul nullification (because it disappears when you take it...)
		proxy:SetDrawEnable( 1979 , false );
		proxy:SetColiEnable( 1979 , false );
	end

	--王城クリアフラグON --EN:--Castle Clear Flag ON
	if proxy:IsClient() == false then
		proxy:SetEventFlag( 8010 , 1 );
	end

	print("OnEvent_4481 end");
end



--------------------------------------------------------------------------------------
--■4500■クライアントPCワープ演出■ --EN:-- ■ 4500 ■ Client PC warp effect ■
--------------------------------------------------------------------------------------

--■4500■クライアントPCワープ演出■ --EN:-- ■ 4500 ■ Client PC warp effect ■
function OnEvent_4500(proxy, param)
	print("OnEvent_4500 begin");

	if proxy:IsClient() == true then
		proxy:PlayAnimation( LOCAL_PLAYER , 8284 );--ワープアニメを再生 --EN:-- Play warp animation
	end

	proxy:SetEventFlag( 4500 , 1 );
	
	print("OnEvent_4500 end");
end



--------------------------------------------------------------------------------------
--■4502■シングル：光の壁、BGM消去■ --EN:-- ■ 4502 ■ Single: Wall of Light, BGM Elimination ■
--------------------------------------------------------------------------------------

--■4502■シングル：光の壁、BGM消去■ --EN:-- ■ 4502 ■ Single: Wall of Light, BGM Elimination ■
function OnEvent_4502(proxy, param)
	print("OnEvent_4502 begin");
	
	--ボス戦用のBGM停止 --EN:--BGM stop for boss battles
	proxy:StopPointSE( 3 );	

	proxy:SetEventFlag( 4502 , 1 );
	
	print("OnEvent_4502 end");
end

--マルチ解散監視 --EN:--Multi-Dismissal Monitoring
function Check_4480_PT(proxy)
	if proxy:IsInParty() == false then
		return true;
	end
	return false;
end

--マルチじゃない --EN:--not multiplayer
function OnEvent_4480_PT(proxy,param)
	print("OnEvent_4480_PT beign");
	--中ボス部屋の前後の魔法壁が消える(全プレイヤー、このマップは魔法壁が一つ) --EN:--The magic wall before and after the mid-boss room disappears (all players, this map has one magic wall)
	proxy:SetColiEnable( 1996 , false );	
	proxy:SetDrawEnable( 1996 , false );
	
	--proxy:SetObjDeactivate( 1996 , true );--デアクティブ --EN:--deactivate
	
	--中ボス部屋魔法壁のSFX削除(ボス扉のIDとは別) --EN:--SFX deletion of mid-boss room magic wall (separate from boss door ID)
	proxy:InvalidSfx( 1988 , true );
	
	--中ボス部屋前の移動処理イベントを削除 --EN:--Delete the movement processing event in front of the mid-boss room
	proxy:DeleteEvent( 1570 );--一人目が入るとき用 --EN:--For when the first person enters
	proxy:DeleteEvent( 1571 );--二人目以降が入るとき用 --EN:--For when the second and subsequent people enter
	proxy:DeleteEvent( 1540 );--ポリ劇再生用 --EN:--For polyplay play
	proxy:DeleteEvent( 1572 );--ボス戦闘開始用	 --EN:--For boss battle start
	print("OnEvent_4480_PT end");
end


--------------------------------------------------------------------------------------
--■1590■飛竜の長が警戒している■ --EN:--■1590■The chief of the wyvern is on guard■
--------------------------------------------------------------------------------------

--飛竜(長)が再生するアニメID --EN:--Anime ID played by Hiryu (long)
tyo_play_anime_id = -1;--最初はアニメを再生していないので-1 --EN:--Because the animation is not played at first -1

--■1590■飛竜の長が警戒している■ --EN:--■1590■The chief of the wyvern is on guard■
function OnEvent_1590(proxy, param)
	print("OnEvent_1590 begin");
	
	
	--[[現在の状態取得]] --EN:--[[Get current state]]
	local now_state = GetNpcStateFlag( proxy, param, tyo_flag_list );
	
	--[[王城４に誰もいない]] --EN:--[[Nobody in Royal Castle 4]]
	if	proxy:IsCompleteEvent( 1651 )	==	false and	--2710
		proxy:IsCompleteEvent( 1670 )	==	false then	--HP75%以上 --EN:--HP75% or more
		SetNpcStateFlag(proxy, param, tyo_flag_list, TYO_STATE_WARNING_AISLE );
		--→OnEvent_1590_3 --EN:--→OnEvent_1590_3
		proxy:LuaCallStart( 1590 , 3 );
	--[[状態が、「通路を警戒」]] --EN:--[[Status is ``Alert Passage'']]
	elseif	proxy:IsCompleteEvent( TYO_STATE_WARNING_AISLE ) == true then
			
		--[[通路前で死亡]] --[[死亡優先]] --EN:--[[Death in front of corridor]] --[[Death priority]]
		if proxy:IsCompleteEvent( 1770 ) == true then--死亡用のHP監視フラグがON --EN:-- HP monitoring flag for death is ON
		   
			--→OnEvent_1595_1 --EN:--→OnEvent_1595_1
			proxy:LuaCallStart( 1595 , 1 );--通路で死亡アニメの同期再生 --EN:-- Synchronous playback of death animation in the passage

		--[[ゲート前に移動]] --EN:--[[Move to Gate]]
		elseif
		   proxy:IsCompleteEvent( 1623 ) == true or		--2640
		   proxy:IsCompleteEvent( 1671 ) == true then	--Hp50％以下 --EN:--Hp50% or less
			
			print("飛竜(長)、ゲート前に移動開始"); --EN:print("Wyvern (long), start moving in front of the gate");
			--→OnEvent_1597_1 --EN:--→OnEvent_1597_1
			proxy:LuaCallStart( 1597 , 1 );
			
		--[[待機(通路)]] --EN:--[[Wait (passageway)]]
		elseif
		   proxy:IsCompleteEvent( 1620 ) == false and	--2610
		   proxy:IsCompleteEvent( 1621 ) == false and	--2620
		   proxy:IsCompleteEvent( 1622 ) == false and	--2630
		   proxy:IsCompleteEvent( 1623 ) == false then	--2640
		   
			print("待機(通路)"); --EN:print("wait (passage)");
			--→OnEvent_1590_3 --EN:--→OnEvent_1590_3
			proxy:LuaCallStart( 1590 , 3 );
		
		--[[領域Aブレス]] --EN:--[[Area A Breath]]
		elseif
		   proxy:IsCompleteEvent( 1620 ) == true  and  --2610
		   proxy:IsCompleteEvent( 1621 ) == false and  --2620
		   proxy:IsCompleteEvent( 1622 ) == false and  --2630
		   proxy:IsCompleteEvent( 1623 ) == false then --2640
			
			
			--[[攻撃の前に通路で待機を挟む]] --EN:--[[Pause in hallway before attacking]]
			--→OnEvent_1591_1 --EN:--→OnEvent_1591_1
			proxy:LuaCallStart( 1591 , 1 );
		
		--[[領域Bブレス]] --EN:--[[area B breath]]
		elseif
		   proxy:IsCompleteEvent( 1621 ) == true  and  --2620
		   proxy:IsCompleteEvent( 1622 ) == false and  --2630
		   proxy:IsCompleteEvent( 1623 ) == false then --2640
			
			print("領域Bブレス"); --EN:print("area B breath");
			--[[攻撃の前に通路で待機を挟む]] --EN:--[[Pause in hallway before attacking]]
			--→OnEvent_1592_1 --EN:--→OnEvent_1592_1
			proxy:LuaCallStart( 1592 , 1 );

		--[[領域Cブレス]] --EN:--[[area C breath]]
		elseif
		   proxy:IsCompleteEvent( 1622 ) == true  and  --2630
		   proxy:IsCompleteEvent( 1623 ) == false then --2640
			
			print("領域Cブレス"); --EN:print("area C breath");
			--[[攻撃の前に通路で待機を挟む]] --EN:--[[Pause in hallway before attacking]]
			--→OnEvent_1593_1 --EN:--→OnEvent_1593_1
			proxy:LuaCallStart( 1593 , 1 );
		
		end
	--[[状態が、「ゲートを警戒」]] --EN:--[[state is "gate alert"]]
	elseif	proxy:IsCompleteEvent( TYO_STATE_WARNING_GATE ) == true then
			
		--[[ゲート前で死亡]] --[[死亡優先]] --EN:--[[Death in front of gate]] --[[Death priority]]
		if proxy:IsCompleteEvent( 1770 ) == true then--死亡用のHP監視フラグがON --EN:-- HP monitoring flag for death is ON

			--→OnEvent_1596_1 --EN:--→OnEvent_1596_1
			proxy:LuaCallStart( 1596 , 1  );
		   
		--[[広場Aブレス]] --EN:--[[Square A Breath]]
		elseif 
		  (proxy:IsCompleteEvent( 1624 ) == true	and		--2641
		   proxy:IsCompleteEvent( 1625 ) == false	and		--2642
		   proxy:IsCompleteEvent( 1626 ) == false	) or	--2643
		  (proxy:IsCompleteEvent( TYO_STATE_WARNING_GATE ) 			== true	 and 	--飛竜の長が「ゲート前を警戒」 --EN:--The chief of the wyvern ``Watch out in front of the gate''
		   proxy:IsCompleteEvent( BIYO_STATE_BATTLE_FLY_DRAGON )	== true) then	--ビヨが「飛竜と戦う」 --EN:--Biyo "fights flying dragons"
			print("広場Aブレス"); --EN:print("Square A Breath");
			--→OnEvent_1594_1 --EN:--→OnEvent_1594_1
			proxy:LuaCallStart( 1594 , 1 );
			
		--[[広場Bブレス]] --EN:--[[Square B Breath]]
		elseif 
		   proxy:IsCompleteEvent( 1625 ) == true	and		--2642
		   proxy:IsCompleteEvent( 1626 ) == false	and		--2643
		   proxy:IsCompleteEvent( BIYO_STATE_BATTLE_FLY_DRAGON ) == false	then	--ビヨが「飛竜と戦う」ではない --EN:--Byo is not "fighting flying dragons"
		   
			print("広場Bブレス"); --EN:print("Square B Breath");
			--→OnEvent_1660_1 --EN:--→OnEvent_1660_1
			proxy:LuaCallStart( 1660 , 1 );
		--[[広場Cブレス]] --EN:--[[Square C Breath]]
		elseif 
		   proxy:IsCompleteEvent( 1626 ) == true	and		--2643
		   proxy:IsCompleteEvent( BIYO_STATE_BATTLE_FLY_DRAGON ) == false	then	--ビヨが「飛竜と戦う」ではない --EN:--Byo is not "fighting flying dragons"
		   
			print("広場Cブレス"); --EN:print("Square C Breath");
			--→OnEvent_1661_1 --EN:--→OnEvent_1661_1
			proxy:LuaCallStart( 1661 , 1 );
		--[[通路前に飛んでいく]] --EN:--[[Flying to the front of the aisle]]
		elseif
		    proxy:IsCompleteEvent( 1623 )	==	false	and		--2640
		  ( proxy:IsCompleteEvent( 1620 )	==	true	or		--2610
		    proxy:IsCompleteEvent( 1621 )	==	true	or		--2620
		    proxy:IsCompleteEvent( 1622 )	==	true )	and		--2630
			proxy:IsCompleteEvent( 1670 )	==	false 	then	--Hp75%以上 --EN:--Hp75% or more

			print("飛竜(長)、通路前に移動開始"); --EN:print("Wyvern (long), start moving in front of the passage");
			--→OnEvent_1598_1 --EN:--→OnEvent_1598_1
			proxy:LuaCallStart( 1598 , 1 );
		
		--[[待機(ゲート)]] --EN:--[[Wait (gate)]]
		elseif
		   proxy:IsCompleteEvent( 1624 ) == false and		--2641
		   proxy:IsCompleteEvent( 1625 ) == false and		--2642
		   proxy:IsCompleteEvent( 1626 ) == false then		--2643

			print("待機(ゲート)"); --EN:print("wait(gate)");
			--→OnEvent_1662_1 --EN:--→OnEvent_1662_1
			proxy:LuaCallStart( 1662 , 1 );
			
		end

	--[[状態が、「死亡」]] --EN:--[[Status is "dead"]]
	elseif	proxy:IsCompleteEvent( TYO_STATE_DEAD ) == true then
		print("OnEvent_1590 Dead end")
	
		--(監視削除?) --EN:-- (delete monitor?)
	end
	
	print("OnEvent_1590 end");
end

--▲1590_anime_end▲アニメの終了のふしに必ず通る▲ --EN:--▲1590_anime_end▲It always passes at the end of the anime▲
function OnEvent_1590_anime_end(proxy, param)
	print("OnEvent_1590_anime_end begin");
	
	proxy:NotNetMessage_begin();
		--▼飛竜の長が警戒している▼ --EN:--▼The chief of the wyvern is wary▼
		proxy:OnKeyTime2( 1590 , "OnEvent_1590" , 0.0 , 0 , 1 , once );
	proxy:NotNetMessage_end();

	print("OnEvent_1590_anime_end end");
end


--LuaCallParam(1662,1)
function OnEvent_1662_1(proxy,param)
	print("OnEvent_1662_1 begin");
	tyo_play_anime_id = 7007;
	proxy:Warp( HiryuOsa_b4_evid , 2701 );--通路側の領域にワープ --EN:-- Warp to the passage side area
	--proxy:ForcePlayAnimationStayCancel( HiryuOsa_b4_evid, tyo_play_anime_id );
	proxy:ForcePlayAnimationStayCancel( HiryuOsa_b4_evid, tyo_play_anime_id );
	
	if	param:IsNetMessage() == true then
		print("OnEvent_1662_1 return end");
		return;
	end
	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		proxy:OnChrAnimEnd( 1661, HiryuOsa_b4_evid, tyo_play_anime_id, "OnEvent_1590_anime_end", once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	
	print("OnEvent_1662_1 end");
end

--秒数で終了したか、アニメの尺で終了したかの判定をきっちり分けるため、フラグで後から来た方は蹴るようにする --EN:--In order to make a clear distinction between whether it ended in seconds or the length of the animation, use a flag to kick the person who came later
Osa_WaitAnim_EndFlag_A = 0;
Osa_IsWaitAnimCondition_A = 0;
--LuaCallParam(1590,3)
function OnEvent_1590_3(proxy,param)
	print("OnEvent_1590_3 begin");
	
	proxy:Warp( HiryuOsa_b4_evid , 2700 );
	
	--既に待機アニメだったら上書きしない --EN:--If it is already a standby animation, it will not be overwritten
	print("tyo_play_anime_id = ", tyo_play_anime_id);
	
	if	tyo_play_anime_id ~= 7001 then
		tyo_play_anime_id = 7001;
		proxy:ForcePlayAnimationStayCancel( HiryuOsa_b4_evid, tyo_play_anime_id );
	end
	
	if	param:IsNetMessage() == true then
		print("OnEvent_1590_3 return end");
		return;
	end
	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 1661, "OnEvnet_1590_4", 1.0, 0, 2, once );
		if	Osa_IsWaitAnimCondition_A ~= 1 then
			proxy:OnChrAnimEnd( 1661, HiryuOsa_b4_evid, tyo_play_anime_id, "OnEvnet_1590_5", once );
			Osa_IsWaitAnimCondition_A = 1;
		end
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	Osa_WaitAnim_EndFlag_A = 0;
	
	print("OnEvent_1590_3 end");
end


--秒数経過で判定を抜ける時 --EN:--When exiting the judgment after the number of seconds has passed
function OnEvnet_1590_4(proxy,param)
	print("OnEvnet_1590_4 begin");
	if	Osa_WaitAnim_EndFlag_A == 0 then
		Osa_WaitAnim_EndFlag_A = 1;
		OnEvent_1590_anime_end(proxy,param);
	end
	print("OnEvnet_1590_4 end");
end

--アニメ終了で判定を抜ける時 --EN:--When exiting the judgment at the end of the animation
function OnEvnet_1590_5(proxy,param)
	print("OnEvnet_1590_5 begin");
	if	Osa_WaitAnim_EndFlag_A == 0 then
		Osa_WaitAnim_EndFlag_A = 2;
		proxy:LuaCallStartPlus( 1590, 10, tyo_play_anime_id );
		OnEvent_1590_anime_end(proxy,param);
	end
	Osa_IsWaitAnimCondition_A = 0;
	print("OnEvnet_1590_5 end");
end




------------------------------------------------------------------------------------------------------
--■1591■領域Aをブレス --EN:-- ■ 1591 ■ Breath area A
------------------------------------------------------------------------------------------------------
--LuaCallParam(1591,1)
function OnEvent_1591_1(proxy,param)
	print("OnEvent_1591_1 begin");
	tyo_play_anime_id = 7001;
	proxy:Warp( HiryuOsa_b4_evid , 2700 );--通路側の領域にワープ --EN:-- Warp to the passage side area
	proxy:ForcePlayAnimationStayCancel( HiryuOsa_b4_evid, tyo_play_anime_id );
	
	if	param:IsNetMessage() == true then
		print("OnEvent_1591 return end");
		return;
	end
--[[	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		proxy:OnChrAnimEnd( 1591, HiryuOsa_b4_evid, tyo_play_anime_id, "OnEvent_1591_1_1", once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
]]	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		local Delay = GetDelay_HiryuOsa(proxy);
		proxy:OnKeyTime2( 1591, "OnEvent_1591_1_2", Delay, 0, 2, once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	print("OnEvent_1591_1 end");
end


function OnEvent_1591_1_1(proxy,param)
	print("OnEvent_1591_1_1 begin");
	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		local Delay = GetDelay_HiryuOsa(proxy);
		proxy:OnKeyTime2( 1591, "OnEvent_1591_1_2", Delay, 0, 2, once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	
	print("OnEvent_1591_1_1 end");
end

function OnEvent_1591_1_2(proxy,param)
	print("OnEvent_1591_1_2 begin");
	
	--OnEvent_1591_2
	proxy:LuaCallStart(1591,2);
	
	print("OnEvent_1591_1_2 end");
end


--LuaCallParam(1591,1)
function OnEvent_1591_2(proxy,param)
	print("OnEvent_1591_2 begin");
	tyo_play_anime_id = 7002;
	proxy:Warp( HiryuOsa_b4_evid , 2700 );--通路側の領域にワープ --EN:-- Warp to the passage side area
	proxy:ForcePlayAnimationStayCancel( HiryuOsa_b4_evid, tyo_play_anime_id );
	
	if	param:IsNetMessage() == true then
		print("OnEvent_1591_2 return end");
		return;
	end
	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		proxy:OnChrAnimEnd( 1591, HiryuOsa_b4_evid, tyo_play_anime_id, "OnEvent_1590_anime_end", once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	
	print("OnEvent_1591_2 end");
end




------------------------------------------------------------------------------------------------------
--■1592■領域Bをブレス --EN:-- ■ 1592 ■ Breath area B
------------------------------------------------------------------------------------------------------
--LuaCallParam(1592,1)
function OnEvent_1592_1(proxy,param)
	print("OnEvent_1592_1 begin");
	tyo_play_anime_id = 7001;
	proxy:Warp( HiryuOsa_b4_evid , 2700 );--通路側の領域にワープ --EN:-- Warp to the passage side area
	proxy:ForcePlayAnimationStayCancel( HiryuOsa_b4_evid, tyo_play_anime_id );
	
	if	param:IsNetMessage() == true then
		print("OnEvent_1592 return end");
		return;
	end
--[[	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		proxy:OnChrAnimEnd( 1592, HiryuOsa_b4_evid, tyo_play_anime_id, "OnEvent_1592_1_1", once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
]]	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		local Delay = GetDelay_HiryuOsa(proxy);
		proxy:OnKeyTime2( 1592, "OnEvent_1592_1_2", Delay, 0, 2, once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	print("OnEvent_1592_1 end");
end


function OnEvent_1592_1_1(proxy,param)
	print("OnEvent_1592_1_1 begin");
	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		local Delay = GetDelay_HiryuOsa(proxy);
		proxy:OnKeyTime2( 1592, "OnEvent_1592_1_2", Delay, 0, 2, once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	
	print("OnEvent_1592_1_1 end");
end

function OnEvent_1592_1_2(proxy,param)
	print("OnEvent_1592_1_2 begin");
	
	--OnEvent_1592_2
	proxy:LuaCallStart(1592,2);
	
	print("OnEvent_1592_1_2 end");
end


--LuaCallParam(1592,1)
function OnEvent_1592_2(proxy,param)
	print("OnEvent_1592_2 begin");
	tyo_play_anime_id = 7003;
	proxy:Warp( HiryuOsa_b4_evid , 2700 );--通路側の領域にワープ --EN:-- Warp to the passage side area
	proxy:ForcePlayAnimationStayCancel( HiryuOsa_b4_evid, tyo_play_anime_id );
	
	if	param:IsNetMessage() == true then
		print("OnEvent_1592_2 return end");
		return;
	end
	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		proxy:OnChrAnimEnd( 1592, HiryuOsa_b4_evid, tyo_play_anime_id, "OnEvent_1590_anime_end", once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	
	print("OnEvent_1592_2 end");
end





------------------------------------------------------------------------------------------------------
--■1593■領域Cをブレス --EN:-- ■ 1593 ■ Bless area C
------------------------------------------------------------------------------------------------------
--LuaCallParam(1593,1)
function OnEvent_1593_1(proxy,param)
	print("OnEvent_1593_1 begin");
	tyo_play_anime_id = 7001;
	proxy:Warp( HiryuOsa_b4_evid , 2700 );--通路側の領域にワープ --EN:-- Warp to the passage side area
	proxy:ForcePlayAnimationStayCancel( HiryuOsa_b4_evid, tyo_play_anime_id );
	
	if	param:IsNetMessage() == true then
		print("OnEvent_1593 return end");
		return;
	end
	--[[
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		proxy:OnChrAnimEnd( 1593, HiryuOsa_b4_evid, tyo_play_anime_id, "OnEvent_1593_1_1", once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	]]
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		local Delay = GetDelay_HiryuOsa(proxy);
		proxy:OnKeyTime2( 1593, "OnEvent_1593_1_2", Delay, 0, 2, once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	
	print("OnEvent_1593_1 end");
end


function OnEvent_1593_1_1(proxy,param)
	print("OnEvent_1593_1_1 begin");
	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		local Delay = GetDelay_HiryuOsa(proxy);
		proxy:OnKeyTime2( 1593, "OnEvent_1593_1_2", Delay, 0, 2, once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	
	print("OnEvent_1593_1_1 end");
end

function OnEvent_1593_1_2(proxy,param)
	print("OnEvent_1593_1_2 begin");
	
	--OnEvent_1593_2
	proxy:LuaCallStart(1593,2);
	
	print("OnEvent_1593_1_2 end");
end


--LuaCallParam(1593,1)
function OnEvent_1593_2(proxy,param)
	print("OnEvent_1593_2 begin");
	tyo_play_anime_id = 7004;
	proxy:Warp( HiryuOsa_b4_evid , 2700 );--通路側の領域にワープ --EN:-- Warp to the passage side area
	proxy:ForcePlayAnimationStayCancel( HiryuOsa_b4_evid, tyo_play_anime_id );
	
	if	param:IsNetMessage() == true then
		print("OnEvent_1593_2 return end");
		return;
	end
	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		proxy:OnChrAnimEnd( 1593, HiryuOsa_b4_evid, tyo_play_anime_id, "OnEvent_1590_anime_end", once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	
	print("OnEvent_1593_2 end");
end



------------------------------------------------------------------------------------------------------
--■1594■広場Aにブレス --EN:-- ■ 1594 ■ Breath at Square A
------------------------------------------------------------------------------------------------------
--LuaCallParam(1594,1)
function OnEvent_1594_1(proxy,param)
	print("OnEvent_1594_1 begin");
	tyo_play_anime_id = 7007;
	proxy:Warp( HiryuOsa_b4_evid , 2701 );--通路側の領域にワープ --EN:-- Warp to the passage side area
	proxy:ForcePlayAnimationStayCancel( HiryuOsa_b4_evid, tyo_play_anime_id );
	
	if	param:IsNetMessage() == true then
		print("OnEvent_1594 return end");
		return;
	end
--[[	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		proxy:OnChrAnimEnd( 1594, HiryuOsa_b4_evid, tyo_play_anime_id, "OnEvent_1594_1_1", once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
]]	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		local Delay = GetDelay_HiryuOsa(proxy);
		proxy:OnKeyTime2( 1594, "OnEvent_1594_1_2", Delay, 0, 2, once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	print("OnEvent_1594_1 end");
end


function OnEvent_1594_1_1(proxy,param)
	print("OnEvent_1594_1_1 begin");
	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		local Delay = GetDelay_HiryuOsa(proxy);
		proxy:OnKeyTime2( 1594, "OnEvent_1594_1_2", Delay, 0, 2, once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	
	print("OnEvent_1594_1_1 end");
end

function OnEvent_1594_1_2(proxy,param)
	print("OnEvent_1594_1_2 begin");
	
	--OnEvent_1594_2
	proxy:LuaCallStart(1594,2);
	
	print("OnEvent_1594_1_2 end");
end


--LuaCallParam(1594,2)
function OnEvent_1594_2(proxy,param)
	print("OnEvent_1594_2 begin");
	tyo_play_anime_id = 7005;
	proxy:Warp( HiryuOsa_b4_evid , 2701 );--通路側の領域にワープ --EN:-- Warp to the passage side area
	proxy:ForcePlayAnimationStayCancel( HiryuOsa_b4_evid, tyo_play_anime_id );
	
	if	param:IsNetMessage() == true then
		print("OnEvent_1594_2 return end");
		return;
	end
	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		proxy:OnChrAnimEnd( 1594, HiryuOsa_b4_evid, tyo_play_anime_id, "OnEvent_1590_anime_end", once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	
	print("OnEvent_1594_2 end");
end



------------------------------------------------------------------------------------------------------
--■1660■広場Bにブレス --EN:-- ■ 1660 ■ Breath at Square B
------------------------------------------------------------------------------------------------------
--LuaCallParam(1660,1)
function OnEvent_1660_1(proxy,param)
	print("OnEvent_1660_1 begin");
	tyo_play_anime_id = 7007;
	proxy:Warp( HiryuOsa_b4_evid , 2701 );--通路側の領域にワープ --EN:-- Warp to the passage side area
	proxy:ForcePlayAnimationStayCancel( HiryuOsa_b4_evid, tyo_play_anime_id );
	
	if	param:IsNetMessage() == true then
		print("OnEvent_1660 return end");
		return;
	end
--[[	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		proxy:OnChrAnimEnd( 1660, HiryuOsa_b4_evid, tyo_play_anime_id, "OnEvent_1660_1_1", once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
]]	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		local Delay = GetDelay_HiryuOsa(proxy);
		proxy:OnKeyTime2( 1660, "OnEvent_1660_1_2", Delay, 0, 2, once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	print("OnEvent_1660_1 end");
end


function OnEvent_1660_1_1(proxy,param)
	print("OnEvent_1660_1_1 begin");
	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		local Delay = GetDelay_HiryuOsa(proxy);
		proxy:OnKeyTime2( 1660, "OnEvent_1660_1_2", Delay, 0, 2, once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	
	print("OnEvent_1660_1_1 end");
end

function OnEvent_1660_1_2(proxy,param)
	print("OnEvent_1660_1_2 begin");
	
	--OnEvent_1660_2
	proxy:LuaCallStart(1660,2);
	
	print("OnEvent_1660_1_2 end");
end


--LuaCallParam(1660,2)
function OnEvent_1660_2(proxy,param)
	print("OnEvent_1660_2 begin");
	tyo_play_anime_id = 7017;
	proxy:Warp( HiryuOsa_b4_evid , 2701 );--通路側の領域にワープ --EN:-- Warp to the passage side area
	proxy:ForcePlayAnimationStayCancel( HiryuOsa_b4_evid, tyo_play_anime_id );
	
	if	param:IsNetMessage() == true then
		print("OnEvent_1660_2 return end");
		return;
	end
	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		proxy:OnChrAnimEnd( 1660, HiryuOsa_b4_evid, tyo_play_anime_id, "OnEvent_1590_anime_end", once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	
	print("OnEvent_1660_2 end");
end





------------------------------------------------------------------------------------------------------
--■1661■広場Cにブレス --EN:-- ■ 1661 ■ Breath at Plaza C
------------------------------------------------------------------------------------------------------
--LuaCallParam(1661,1)
function OnEvent_1661_1(proxy,param)
	print("OnEvent_1661_1 begin");
	tyo_play_anime_id = 7007;
	proxy:Warp( HiryuOsa_b4_evid , 2701 );--通路側の領域にワープ --EN:-- Warp to the passage side area
	proxy:ForcePlayAnimationStayCancel( HiryuOsa_b4_evid, tyo_play_anime_id );
	
	if	param:IsNetMessage() == true then
		print("OnEvent_1661 return end");
		return;
	end
--[[	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		proxy:OnChrAnimEnd( 1661, HiryuOsa_b4_evid, tyo_play_anime_id, "OnEvent_1661_1_1", once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
]]	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		local Delay = GetDelay_HiryuOsa(proxy);
		proxy:OnKeyTime2( 1661, "OnEvent_1661_1_2", Delay, 0, 2, once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	
	print("OnEvent_1661_1 end");
end


function OnEvent_1661_1_1(proxy,param)
	print("OnEvent_1661_1_1 begin");
	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		local Delay = GetDelay_HiryuOsa(proxy);
		proxy:OnKeyTime2( 1661, "OnEvent_1661_1_2", Delay, 0, 2, once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	
	print("OnEvent_1661_1_1 end");
end

function OnEvent_1661_1_2(proxy,param)
	print("OnEvent_1661_1_2 begin");
	
	--OnEvent_1661_2
	proxy:LuaCallStart(1661,2);
	
	print("OnEvent_1661_1_2 end");
end


--LuaCallParam(1661,2)
function OnEvent_1661_2(proxy,param)
	print("OnEvent_1661_2 begin");
	tyo_play_anime_id = 7019;
	proxy:Warp( HiryuOsa_b4_evid , 2701 );--通路側の領域にワープ --EN:-- Warp to the passage side area
	proxy:ForcePlayAnimationStayCancel( HiryuOsa_b4_evid, tyo_play_anime_id );
	
	if	param:IsNetMessage() == true then
		print("OnEvent_1661_2 return end");
		return;
	end
	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		proxy:OnChrAnimEnd( 1661, HiryuOsa_b4_evid, tyo_play_anime_id, "OnEvent_1590_anime_end", once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	
	print("OnEvent_1661_2 end");
end




------------------------------------------------------------------------------------------------------
--■1662■広場警戒ループ --EN:-- ■ 1662 ■ Plaza alert loop
------------------------------------------------------------------------------------------------------
Osa_WaitAnim_EndFlag_B = 0;
Osa_IsWaitAnimCondition_B = 0;
--LuaCallParam(1662,1)
function OnEvent_1662_1(proxy,param)
	print("OnEvent_1662_1 begin");
	--proxy:ForcePlayAnimationStayCancel( HiryuOsa_b4_evid, tyo_play_anime_id );
	proxy:Warp( HiryuOsa_b4_evid , 2701 );--通路側の領域にワープ --EN:-- Warp to the passage side area
	if	tyo_play_anime_id ~= 7007 then
		tyo_play_anime_id = 7007;
		proxy:ForcePlayAnimationStayCancel( HiryuOsa_b4_evid, tyo_play_anime_id );
	end
	
	if	param:IsNetMessage() == true then
		print("OnEvent_1662_1 return end");
		return;
	end
	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 1661, "OnEvent_1662_2", 1.0, 0, 2, once );
		if	Osa_IsWaitAnimCondition_B ~= 1 then
			proxy:OnChrAnimEnd( 1661, HiryuOsa_b4_evid, tyo_play_anime_id, "OnEvent_1662_3", once );
			Osa_IsWaitAnimCondition_B = 1;
		end
		Osa_WaitAnim_EndFlag_B = 0;
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	
	print("OnEvent_1662_1 end");
end

--秒数経過で判定を抜ける時 --EN:--When exiting the judgment after the number of seconds has passed
function OnEvent_1662_2(proxy,param)
	print("OnEvent_1662_2 begin");
	if	Osa_WaitAnim_EndFlag_B == 0 then
		Osa_WaitAnim_EndFlag_B = 1;
		OnEvent_1590_anime_end(proxy,param);
	end
	print("OnEvent_1662_2 end");
end

--アニメ終了で判定を抜ける時 --EN:--When exiting the judgment at the end of the animation
function OnEvent_1662_3(proxy,param)
	print("OnEvent_1662_3 begin");
	if	Osa_WaitAnim_EndFlag_B == 0 then
		Osa_WaitAnim_EndFlag_B = 2;
		proxy:LuaCallStartPlus( 1590, 10, tyo_play_anime_id );
		OnEvent_1590_anime_end(proxy,param);
	end
	Osa_IsWaitAnimCondition_B = 0;
	print("OnEvent_1662_3 end");
end










------------------------------------------------------------------------------------------------------
--■1595■飛竜の長が死ぬ(通路版) --EN:-- ■ 1595 ■ The chief of the flying dragon dies (passage version)
------------------------------------------------------------------------------------------------------
--LuaCallParam(1595,1)
function OnEvent_1595_1(proxy,param)
	print("OnEvent_1595_1 begin");
	tyo_play_anime_id = 7006;
	proxy:Warp( HiryuOsa_b4_evid , 2700 );--通路側の領域にワープ --EN:-- Warp to the passage side area
	proxy:ForcePlayAnimation( HiryuOsa_b4_evid, tyo_play_anime_id );
	
	
	
	if	param:IsNetMessage() == true then
		print("OnEvent_1595_1 return end");
		return;
	end
	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		proxy:OnChrAnimEnd( 1595, HiryuOsa_b4_evid, tyo_play_anime_id, "OnEvent_1595_2", once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	
	
	print("OnEvent_1595_1 end");
end


function OnEvent_1595_2(proxy,param)
	print("OnEvent_1595_2 begin");
	
	SetNpcStateFlag(proxy, param, tyo_flag_list, TYO_STATE_DEAD );
	
	--飛竜の長がちゃんと死んでいたら、トロフィーアンロック --EN:--If the wyvern chief dies properly, the trophy will be unlocked
	if	proxy:IsCompleteEvent( 1770 ) == true then
		HiryuOsaDead(proxy,param);
	end
	
	--OnEvent_1590_syncroInvalid
	proxy:LuaCallStartPlus( 1590, 2, HiryuOsa_b4_evid );
	
	print("OnEvent_1595_2 end");
end



------------------------------------------------------------------------------------------------------
--■1596■飛竜の長が死ぬ(ゲート前版) --EN:-- ■ 1596 ■ The chief of the flying dragon dies (pre-gate version)
------------------------------------------------------------------------------------------------------
--LuaCallParam(1596,1)
function OnEvent_1596_1(proxy,param)
	print("OnEvent_1596_1 begin");
	tyo_play_anime_id = 7010;
	proxy:Warp( HiryuOsa_b4_evid , 2701 );--通路側の領域にワープ --EN:-- Warp to the passage side area
	proxy:ForcePlayAnimation( HiryuOsa_b4_evid, tyo_play_anime_id );
	
	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		proxy:OnChrAnimEnd( 1596, HiryuOsa_b4_evid, tyo_play_anime_id, "OnEvent_1596_2", once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	
	print("OnEvent_1596_1 end");
end


function OnEvent_1596_2(proxy,param)
	print("OnEvent_1596_2 begin");
	
	--飛竜の長がちゃんと死んでいたら、トロフィーアンロック --EN:--If the wyvern chief dies properly, the trophy will be unlocked
	if	proxy:IsCompleteEvent( 1770 ) == true then
		HiryuOsaDead(proxy,param);
	end
	
	--OnEvent_1590_syncroInvalid
	proxy:LuaCallStartPlus( 1590, 2, HiryuOsa_b4_evid );
	
	print("OnEvent_1596_2 end");
end











------------------------------------------------------------------------------------------------------
--■1597■飛竜の長が移動(通路→ゲート前) --EN:-- ■ 1597 ■ Flying dragon chief moves (passage → in front of the gate)
------------------------------------------------------------------------------------------------------
--LuaCallParam(1597,1)
function OnEvent_1597_1(proxy,param)
	print("OnEvent_1597_1 begin");
	tyo_play_anime_id = 7008;
	proxy:Warp( HiryuOsa_b4_evid , 2700 );--通路側の領域にワープ --EN:-- Warp to the passage side area
	proxy:ForcePlayAnimationStayCancel( HiryuOsa_b4_evid, tyo_play_anime_id );
	SetNpcStateFlag(proxy, param, tyo_flag_list, TYO_STATE_WARNING_GATE );
	
	if	param:IsNetMessage() == true then
		print("OnEvent_1597_1 return end");
		return;
	end
	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		proxy:OnChrAnimEnd( 1597, HiryuOsa_b4_evid, tyo_play_anime_id, "OnEvent_1590_anime_end", once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	
	print("OnEvent_1597_1 end");
end


------------------------------------------------------------------------------------------------------
--■1598■飛竜の長が移動(ゲート前→通路) --EN:-- ■ 1598 ■ The chief of the flying dragon moves (in front of the gate → passage)
------------------------------------------------------------------------------------------------------
--LuaCallParam(1598,1)
function OnEvent_1598_1(proxy,param)
	print("OnEvent_1598_1 begin");
	tyo_play_anime_id = 7009;
	proxy:Warp( HiryuOsa_b4_evid , 2701 );--通路側の領域にワープ --EN:-- Warp to the passage side area
	proxy:ForcePlayAnimationStayCancel( HiryuOsa_b4_evid, tyo_play_anime_id );
	SetNpcStateFlag(proxy, param, tyo_flag_list, TYO_STATE_WARNING_AISLE );
	
	if	param:IsNetMessage() == true then
		print("OnEvent_1598_1 return end");
		return;
	end
	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		proxy:OnChrAnimEnd( 1598, HiryuOsa_b4_evid, tyo_play_anime_id, "OnEvent_1590_anime_end", once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	
	print("OnEvent_1598_1 end");
end



--LuaCallParam(1590,2)
function OnEvent_1590_syncroInvalid(proxy,param)
	print("OnEvent_1590_syncroInvalid begin");
	
	local evid = param:GetParam3()
	InvalidCharactor( proxy, evid );
	
	print("OnEvent_1590_syncroInvalid end");
end



function Osa_ForceSynchroAnime(proxy,param)
	print("Osa_ForceSynchroAnime begin");
	local animId = param:GetParam3();
	tyo_play_anime_id = animId;
	proxy:ForcePlayAnimationStayCancel( HiryuOsa_b4_evid, tyo_play_anime_id );
	print("Osa_ForceSynchroAnime end");
end


--------------------------------------------------------------------------------------
--■1770■飛竜の長が死ぬ■ --EN:-- ■ 1770 ■ The chief of the wyvern dies ■
--------------------------------------------------------------------------------------

--■1770■飛竜の長が死ぬ■(HP監視) --EN:-- ■ 1770 ■ The chief of the flying dragon dies ■ (HP monitoring)
function OnEvent_1770(proxy, param)
	print("OnEvent_1770 begin");

	proxy:SetEventFlag( 1770 , 1 );--HP監視フラグON --EN:--HP monitor flag ON
	
	print("OnEvent_1770 end");
end



--------------------------------------------------------------------------------------
--■1635■エレベータが昇る■ --EN:-- ■ 1635 ■ elevator rises ■
--------------------------------------------------------------------------------------

--■1635■エレベータが昇る■ --EN:-- ■ 1635 ■ elevator rises ■
function OnEvent_1635(proxy, param)
	print("OnEvent_1635 begin");

	--アニメ再生中は発動しない --EN:--Does not activate during animation playback
	if	proxy:IsCompleteEvent( 1631 ) == true then
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
		print("OnEvent_1635 return end");
		return;
	end	
	
	ElevatorEvent(proxy,param);	
	
	print("OnEvent_1635 end");
end

function OnEvent_1633(proxy,param)
	print("OnEvent_1633")
	--アニメ再生中は発動しない --EN:--Does not activate during animation playback
	if	proxy:IsCompleteEvent( 1631 ) == true then
--~ 		--発動者だけインフォ --EN:--Invoker only info
--~ 		if param:IsNetMessage() == false then
--~ 			--扉が開かない場合のメッセージを表示 --EN:-- Display a message when the door does not open
--~ 			--proxy:InfomationMenu( INFOMENU_TYPE_SIMPLE, 0, MSG_CATEGORY_EVENT, 10010170, 1);
--~ 			--proxy:ShowGenDialog(10010170,1,1,true);
--~ 			proxy:RepeatMessage_begin();
--~ 			proxy:NotNetMessage_begin();
--~ 				proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010170, 0, 6, -1, GEN_DIALOG_DIST, once );
--~ 			proxy:NotNetMessage_end();
--~ 			proxy:RepeatMessage_end();
--~ 		end		
		print("OnEvent_1633 return end");
		return;
	end	
	
	ElevatorEvent(proxy,param);
	print("OnEvent_1633 end")
end

function ElevatorEvent(proxy,param)
	proxy:DeleteEvent( 1633 );
	--上にある状態なら降り、下にある状態なら昇りアニメ再生 --EN:--If it's up, get down, if it's down, get up and play animation
	if proxy:IsClient() == false then
		if	proxy:IsCompleteEvent( 1630 ) == false then
			proxy:LuaCallStart( 1635 , 5 );
			--proxy:ForcePlayAnimation( 1620 , 1 );--エレベータが昇るアニメ再生 --EN:--Play an animation of the elevator going up
		else
			proxy:LuaCallStart( 1635 , 6 );
			--proxy:ForcePlayAnimation( 1620 , 2 );--エレベータが降りるアニメ再生 --EN:--Play an animation of the elevator going down
			proxy:DeleteEvent(1632);
		end
	end
	
	--プレイヤのアニメは無し --EN:--No player animation
	
	local evId_list   = {1650,1651,1652,1653,1654,1655,1660,1661,1662};
	local animId_list = {	2,	 2,	  2,   2,   2,   2,   0,   0,   0};
	local obj_num = table.getn(evId_list);
	for index = 1, obj_num, 1 do
		proxy:PlayAnimation( evId_list[index], animId_list[index] );
	end

	--発動者だけがアニメ終了を監視(必ずクライアントの世界でエレベータオブジェクトが読み込まれているわけではないので) --EN:--Only the invoker monitors the end of the animation (because the elevator object is not always loaded in the client world)
	if	proxy:IsClient() == false then
		proxy:NotNetMessage_begin();
			proxy:RepeatMessage_begin();
				if	proxy:IsCompleteEvent( 1630 ) == false then
					--▼1635▼エレベータが昇るアニメ終了▼ --EN:--▼1635▼End of the animation when the elevator rises▼
					proxy:OnCharacterAnimEnd( 1635 , 1620 , 1 , "OnEvent_1635_anime_end" , once );
					proxy:LuaCallStart( 1635, 2 );--この時点で上下は確定 --EN:--At this point, up and down are fixed
				else
					--▼1635▼エレベータが降りるアニメ終了▼ --EN:--▼1635▼The animation ends when the elevator gets off▼
					proxy:OnCharacterAnimEnd( 1635 , 1620 , 2 , "OnEvent_1635_anime_end" , once );
					proxy:LuaCallStart( 1635, 2 );--この時点で上下は確定 --EN:--At this point, up and down are fixed
				end
			proxy:RepeatMessage_end();
		proxy:NotNetMessage_end();
	end
end

--▲1635_anime_end▲エレベータが昇るアニメ終了▲ --EN:--▲1635_anime_end▲The end of the elevator animation▲
function OnEvent_1635_anime_end(proxy, param)
	print("OnEvent_1635_anime_end begin");
	
	--▼エレベータが降りる監視追加▼ --EN:--▼Addition of monitoring when the elevator gets off▼
	--proxy:OnPlayerActionInRegion( 1636 , 2651 , "OnEvent_1636" , HELPID_START , everytime );
	--proxy:OnDistanceActionPlus( 1636 , LOCAL_PLAYER, 1620, "OnEvent_1635" , 1, HELPID_START , 0, 100, 0.0, 0.0, 0.0, everytime );--昇る用 --EN:--For climbing
	
	
	--フラグ同期ルアーコール()--アニメ終了フラグ同期 --EN:--flag sync lure call()--anime end flag sync
	proxy:LuaCallStart( 1635, 4 );
	
	if proxy:IsCompleteEvent( 1630 ) == true then
		proxy:NotNetMessage_begin();
		proxy:RepeatMessage_begin();
			proxy:OnKeyTime2( 1632 , "OnEvent_1632",0.5,0,1,once);
		proxy:RepeatMessage_end();
		proxy:NotNetMessage_end();
	end
	
	print("OnEvent_1635_anime_end end");
end

function OnEvent_1635_flag(proxy,param)
	print("OnEvent_1635_flag begin");
	
	if	proxy:IsCompleteEvent( 1630 ) == true then
		proxy:SetEventFlag( 1630, false );
	else
		proxy:SetEventFlag( 1630, true );
	end	
	print("OnEvent_1635_flag end");
end

function OnEvent_1635_animeflag(proxy,param)
	print("OnEvent_1635_animeflag begin");
	--アニメ中フラグOFF --EN:--Animation Flag OFF
	proxy:SetEventFlag( 1631 , false );
	print("OnEvent_1635_animeflag end");
end
 
--[[
function OnEvent_1635_Out(proxy,param)
	print("OnEvent_1635_Out begin");
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 1635, "OnEvent_1635_Out_1", 0.0, 0, 2, once );
	proxy:NotNetMessage_end();
	print("OnEvent_1635_Out end");
end

--その瞬間だとOnNetRegionのフラグ設定が有効にならないので、1フレーム遅らせる --EN:--At that moment, the OnNetRegion flag setting does not take effect, so delay by 1 frame
function OnEvent_1635_Out_1(proxy,param)
	print("OnEvent_1635_Out_1 begin");
	--全員がエレベータ領域からいなくなっていたらエレベータを動かす --EN:--Move the elevator when everyone is out of the elevator area
	if	proxy:IsCompleteEvent( 1636 ) == false then
		--エレベータが上にある状態じゃないと発動させない(必要ないかも) --EN:--Do not activate unless the elevator is at the top (may not be necessary)
		if	proxy:IsCompleteEvent( 1630 ) == true then
			--→OnEvent_1635 --EN:--→OnEvent_1635
			proxy:LuaCallStart( 1635, 3 );
		end
	end
	print("OnEvent_1635_Out_1 end");
end
]]


--上に上がりきった時の監視 --EN:--Monitoring when it reaches the top
function OnEvent_1632( proxy,param)
	print("OnEvent_1632 begin");
	proxy:NotNetMessage_begin();
	proxy:RepeatMessage_begin();
		proxy:OnRegistFunc( 1632 , "Check_1632_1","OnEvent_1632_1",1,once);
		
		--領域にずっと居ても一定時間で降りるように --EN:--Even if you stay in the area for a long time, you will get off after a certain amount of time.
		proxy:OnKeyTime2( 1633 , "OnEvent_1633",ElevatorTimer,0,100,once);
	proxy:RepeatMessage_end();
	proxy:NotNetMessage_end();
	print("OnEvent_1632 end");
end

--領域に誰も居ないか？ --EN:--Is there anyone in the realm?
function Check_1632_1(proxy,param)
	if proxy:IsCompleteEvent( 1636 ) == true then
		return false;
	end
	return true;
end

--領域に誰も居ないのでエレベーターを下ろす --EN:--There is no one in the area, so let the elevator go down
function OnEvent_1632_1(proxy,param)
	print("OnEvent_1632_1 begin");
	if proxy:IsClient() == false then
		proxy:LuaCallStart( 1635, 3 );
	end
	print("OnEvent_1632_1 end");
end

function OnEvent_1635_UpAnime(proxy,param)
	if proxy:IsCompleteEvent( 1631 ) == false then
		proxy:ForcePlayAnimation( 1620 , 1 );--エレベータが昇るアニメ再生 --EN:--Play an animation of the elevator going up
		--アニメ中フラグON --EN:--Animation Flag ON
		proxy:SetEventFlag( 1631 , true );
	end
end

function OnEvent_1635_DownAnime(proxy,param)
	if proxy:IsCompleteEvent( 1631 ) == false then
		proxy:ForcePlayAnimation( 1620 , 2 );--エレベータが降りるアニメ再生 --EN:--Play an animation of the elevator going down
		--アニメ中フラグON --EN:--Animation Flag ON
		proxy:SetEventFlag( 1631 , true );
	end
end

--[[
--------------------------------------------------------------------------------------
--■1636■エレベータが降りる■ --EN:-- ■ 1636 ■ Elevator gets off ■
--------------------------------------------------------------------------------------

--■1636■エレベータが降りる■ --EN:-- ■ 1636 ■ Elevator gets off ■
function OnEvent_1636(proxy, param)
	print("OnEvent_1636 begin");
		
	--エレベータが上にあるときだけ反応 --EN:--Response only when the elevator is up
	if proxy:IsCompleteEvent( 1631 ) == true then
	
		proxy:PlayAnimation( 1620 , 2 );--エレベータが降りるアニメ再生 --EN:--Play an animation of the elevator going down
	
		local evId_list   = {1650,1651,1652,1653,1654,1655,1660,1661,1662};
		local animId_list = {	2,	 2,	  2,   2,   2,   2,   0,   0,   0};
		local obj_num = table.getn(evId_list);
		for index = 1, obj_num, 1 do
			proxy:PlayAnimation( evId_list[index], animId_list[index] );
		end
		
		proxy:NotNetMessage_begin();
			--▼1636▼エレベータが降りるアニメ終了▼ --EN:--▼1636▼The animation ends when the elevator gets off▼
			proxy:OnCharacterAnimEnd( 1636 , 1620 , 2 , "OnEvent_1636_anime_end" , once );
		proxy:NotNetMessage_end();
		
		--エレベータが上にある状態にフラグを合わせる --EN:-- flag the state where the elevator is up
		proxy:SetEventFlag( 1630 , true ); --下にある --EN:--below
		proxy:SetEventFlag( 1631 , false );--上にない --EN:-- not above
	end		

	print("OnEvent_1636 end");
end

--▲1636_anime_end▲エレベータが降りるアニメ終了▲ --EN:--▲1636_anime_end▲The end of the animation when the elevator gets off▲
function OnEvent_1636_anime_end(proxy, param)
	print("OnEvent_1636_anime_end begin");

	proxy:DeleteEvent( 1636 );--エレベータが降りるの監視削除 --EN:--Delete the monitor when the elevator gets off
	--▼エレベータが昇る監視追加▼ --EN:--▼Addition of monitoring when the elevator rises▼
	proxy:OnPlayerActionInRegion( 1635 , 2650 , "OnEvent_1635" , HELPID_START , everytime );
	--proxy:OnDistanceActionPlus( 1635 , LOCAL_PLAYER, 1620, "OnEvent_1635" , 1, HELPID_START , 0, 100, 0.0, 0.0, 0.0, everytime );--昇る用 --EN:--For climbing
	
	print("OnEvent_1636_anime_end end");
end

]]

--------------------------------------------------------------------------------------
--■4503■ソウル入手■ --EN:-- ■ 4503 ■ Get Soul ■
--------------------------------------------------------------------------------------

function OnEvent_4503(proxy, param)
	print("OnEvent_4503 begin");
	
	--プレイヤーの同期アニメーション(true:パーティープレイヤーがアニメーションした) --EN:--Player synchronous animation (true: party player animated)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_PICK ) == true then--新しいアニメ  --EN:-- new anime
		print("OnEvent_4503 end");
		return true;
	end
	
	proxy:NotNetMessage_begin();
		--0.0秒後にアイテム取得イベントを発行 --EN:-- Issue an item acquisition event after 0.0 seconds
		proxy:OnKeyTime2( 4503, "OnEvent_4503_1", 0.0, 0, 0, once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_4103 end");
end


--■4503_1■アイテム取得■ --EN:-- ■ 4503_1 ■ item acquisition ■
function OnEvent_4503_1(proxy, param)
	print("OnEvent_4503_1 begin");

	--アイテム取得関数--パラメータ10101参照 --EN:--item retrieval function--see parameter 10101
	proxy:GetRateItem(10101);	
	proxy:GetRateItem(10182);
	proxy:GetRateItem(10183);
	proxy:GetRateItem(10184);
	proxy:GetRateItem(10185);
	
	--アイテムを取得済み --EN:--item already acquired
	proxy:SetEventFlag( 4503, 1 );
	
	--宝箱シェーダーは消えません --EN:--Treasure chest shader does not disappear
	--proxy:TreasureDispModeChange( 1979 , false );

	--SFXが消える --EN:--SFX disappear
	proxy:InvalidSfx( 1640, true );--SFX 無効化 --EN:--Disable SFX
	--proxy:InvalidSfx( 1641, true );--光の粒子 --EN:--Particles of light
		
	if proxy:IsCompleteEvent( 4510 ) == false then
		proxy:NotNetMessage_begin();
			--瞬間で表示するとメニューが先に出るので待つ --EN:--If you display it instantly, the menu will appear first, so wait
			proxy:OnKeyTime2( 4510 , "OnEvent_4510_wait",0.5 , 0 , 1, once);			
		proxy:NotNetMessage_end();
	else
		--▼要石でワープ用の監視を追加▼ --EN:--▼ Added surveillance for warp with keystone ▼
		proxy:OnDistanceActionAttribute( 4505 , LOCAL_PLAYER , 1979 , "OnEvent_4505" , WarpGimmickDist_A , HELPID_GO_TO_SEKITYUU , 0 , 180 , ATTR_NOSESSION , everytime );
	end		

	print("OnEvent_4503_1 end");
end


--アイテム取得後のウェイト --EN:--Wait after getting item
function OnEvent_4510_wait(proxy,param)
	print("OnEvent_4510_wait begin");
	proxy:NotNetMessage_begin();
		--インフォメニューが消えるのを待ちたい --EN:--I want to wait for the info menu to disappear
		proxy:OnRegistFunc( 4510 , "Check_4510" , "OnEvent_4510" , 1 , ocne);
	proxy:NotNetMessage_end();
	print("OnEvent_4510_wait end");
end	
--インフォ待ち --EN:--Waiting for info
function Check_4510(proxy)
	if proxy:IsShowMenu_InfoMenu() == true then
		return false;
	end
	return true;
end

--会話発動表示 --EN:--Conversation activation display
function OnEvent_4510(proxy,param)
	print("OnEvent_4510 begin");
	proxy:NotNetMessage_begin();
		--会話発動 --EN:--Conversation activation
		proxy:CloseMenu();
		proxy:TalkNextPage( 4510 );
		proxy:SetEventFlag( 4510 , true );
	proxy:NotNetMessage_end();
	--▼要石でワープ用の監視を追加▼	 --EN:--▼ Added surveillance for warp with keystone ▼
	proxy:OnDistanceActionAttribute( 4505 , LOCAL_PLAYER , 1979 , "OnEvent_4505" , WarpGimmickDist_A , HELPID_GO_TO_SEKITYUU , 0 , 180 , ATTR_NOSESSION , everytime );
	print("OnEvent_4510 end");
end

--------------------------------------------------------------------------------------
--石柱にワープ(ボス倒した後用)■4505 --EN:-- Warp to the stone pillar (for after defeating the boss) 4505
--------------------------------------------------------------------------------------

--■4505■石柱にワープ■ --EN:-- ■ 4505 ■ Warp to the stone pillar ■
function OnEvent_4505(proxy,param)	

	if proxy:IsCompleteEvent( 4505 ) == true then
		return;
	end	

	print("OnEvent_4505 begin");
	
	proxy:RepeatMessage_begin();
		--▼4505_1▼選択メニューの監視▼ --EN:--▼4505_1▼Monitor selection menu▼
		proxy:OnSelectMenu(4505, "OnEvent_4505_0", 10010710, 0, 2, 1979, 2, once);			
	proxy:RepeatMessage_end();
	
	print("OnEvent_4505 end");
end

--▲4505_0▲選択メニューの監視▲ --EN:--▲4505_0▲Monitor selection menu▲
function OnEvent_4505_0(proxy, param)
	print("OnEvent_4505_0 begin");	
	
	if proxy:IsSession() == false then
		proxy:PlayAnimation( LOCAL_PLAYER , 8283 );--要石に触れるアニメを再生 --EN:--Play the animation that touches the keystone
		proxy:NoAnimeTurnCharactor( 10000 , 1979 ,TURNSKIP_ANGLE);
		
		proxy:NotNetMessage_begin();
			--▼要石に触れるアニメ再生終了▼ --EN:--▼Animation touching the keystone ends▼
			proxy:OnChrAnimEnd( 4505 , LOCAL_PLAYER , 8283 , "OnEvent_4505_1" , once );
		proxy:NotNetMessage_end();
		
		proxy:SetEventFlag( 4505 , 1 );
	else
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010720, 0, 6, 1983, GEN_DIALOG_DIST, once );
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
	end
	
	print("OnEvent_4505_0 end");
end

--▲4505_1▲自世界に帰るアニメを再生終了▲ --EN:--▲4505_1▲Finish playing animation to return to own world▲
function OnEvent_4505_1(proxy,param)	
	print("OnEvent_4505_1 begin");
	
	proxy:PlayAnimation( 10000 , 8284 );--自世界に帰るアニメを再生 --EN:--Play animation to return to your own world
	--石柱へ戻ってきた判定のフラグを立てる --EN:--Flag the judgment of returning to the stone pillar
	proxy:SetEventFlag(8083, true);
	
	proxy:SetEventFlag( 4505 , 0 );	
	--完全回復要求 --EN:-- full recovery request
	proxy:RequestFullRecover();
	proxy:WarpNextStage( 1, 0, 0, 0, 1006 );
	
	print("OnEvent_4505_1 end");
end

--------------------------------------------------------------------------------------
--ビヨルングルムが敵対■1712 --EN:-- Bjrn Grum is hostile ■ 1712
--------------------------------------------------------------------------------------
--■1712■ビヨルングルムが敵対 --EN:-- ■ 1712 ■ Bjrn Grum is hostile
function OnEvent_1711(proxy,param)
	print("OnEvent_1711 begin");
	
	if proxy:IsCompleteEvent(BIYO_STATE_BATTLE_FLY_DRAGON) == true then
		SetNpcStateFlag( proxy , param , biyo_flag_list , BIYO_STATE_HOSTILE_IN_GATE_FRONT );
		proxy:SetEventCommand( 698 , 51 );--EzStateに制御番号(立ち上がる)を渡す --EN:-- Pass control number (stand up) to EzState
		proxy:EnableLogic( 698, true );--ビヨロジックON --EN:--Beyologic ON
		proxy:SetTeamType( 698, TEAM_TYPE_AngryFriend );
		proxy:EraseEventSpecialEffect_2(698,5064);
		proxy:SetEventFlag( 1711, true );
	end
	
	print("OnEvent_1711 end");
end

--■1712■ビヨルングルム死亡 --EN:-- ■ 1712 ■ Bjrn Grum died
function OnEvent_1712(proxy,param)
	print("OnEvent_1712 begin");
	
	SetNpcStateFlag( proxy , param , biyo_flag_list , BIYO_STATE_DEAD );
	proxy:SetEventFlag( 1712, true );
	
	print("OnEvent_1712 end");
end


--■1717■ビヨルングルムが寝る --EN:--■ 1717 ■ Bjrn Gurm sleeps
function OnEvent_1717(proxy,param)
	print("OnEvent_1717 begin");
	
	proxy:EnableLogic( 698, false );--ビヨロジックOFF --EN:--Beyologic OFF
	proxy:SetTeamType( 698 , TEAM_TYPE_Friend );
	proxy:SetEventCommand( 698, 60 );--EzStateに制御番号(寝る)を渡す --EN:-- Pass control number (sleep) to EzState
	
	proxy:SetEventFlag( 1717, true );
	print("OnEvent_1717 end");
end


--■1700■レンドル王子　死亡する --EN:-- ■ 1700 ■ Prince Lendl dies
function OnEvent_1700(proxy,param)
	print("OnEvent_1700 begin");
	
	--もういない状態のときに死んでも、状態は切り替えない --EN:--If you die when you are no longer in the state, the state will not switch
	if	proxy:IsCompleteEvent( RENDOL_STATE_ERASE ) == true then
		return;
	end
	
	SetNpcStateFlag( proxy, param, rendol_flag_list, RENDOL_STATE_DEAD );
	RendolCheck(proxy,param);
	--死亡でRendolCheckする場合、その瞬間に消えてしまうので、 --EN:--If you perform RendolCheck on death, it will disappear at that moment, so
	--距離を見て再度有効にするか決める --EN:--Look at the distance and decide whether to re-enable
	if	proxy:IsDistance( LOCAL_PLAYER, 626, 20 ) == true then
		ValidCharactor( proxy, 626 );
	end
	proxy:SetEventFlag( 1700, true );

	print("OnEvent_1700 end");
end

--■1702■レンドル王子　敵対する --EN:-- ■ 1702 ■ Prince Lendl is hostile
function OnEvent_1702(proxy,param)
	print("OnEvent_1702 begin");
	SetNpcStateFlag( proxy, param, rendol_flag_list, RENDOL_STATE_HOSTILE_4_LIFT_FRONT );
		proxy:SetTeamType( 626, TEAM_TYPE_AngryFriend );
	
	proxy:SetEventFlag( 1702, true );
	
	print("OnEvent_1702 end");
end



--■11790■レンドル王子　会話からアイテム取得 --EN:-- ■ 11790 ■ Prince Lendl Item acquisition from conversation
function OnEvent_11790(proxy,param)
	print("OnEvent_11790 begin");
	if proxy:IsCompleteEvent( 11790 ) == true then
		return;
	end
	
	if proxy:IsClient() == false then
		proxy:GetRateItem(10190);
	end
	proxy:SetHp( 626, 0.0 );
	proxy:SetEventFlag( 11790, true );
	
	SetNpcStateFlag( proxy, param, rendol_flag_list, RENDOL_STATE_ERASE );
	RendolCheck(proxy,param);
	--死亡でRendolCheckする場合、その瞬間に消えてしまうので、 --EN:--If you perform RendolCheck on death, it will disappear at that moment, so
	--距離を見て再度有効にするか決める --EN:--Look at the distance and decide whether to re-enable
	if	proxy:IsDistance( LOCAL_PLAYER, 626, 20 ) == true then
		ValidCharactor( proxy, 626 );
	end
	
	print("ドラン手加減"); --EN:print("Take it easy");
	proxy:SendEventRequest( 697 ,0, 1);
	proxy:SetEventSpecialEffect_2( 697 , 5042 );
	
	print("OnEvent_11790 end");
end


-----------------------------------------------------------------------------
--■1760■QWCソウルモンスター出現１■ --EN:--■ 1760 ■ QWC Soul Monster Appearance 1 ■
-----------------------------------------------------------------------------
function OnEvent_1760(proxy,param)
	print("OnEvent_1760 begin");
	ValidCharactor( proxy, 510 );
	proxy:PlayAnimation( 510, 6100 );
	proxy:SetEventFlag( 1760, true );
	print("OnEvent_1760 end");
end


--飛竜の長死亡 --EN:--Long Death of Wyvern
function HiryuOsaDead(proxy,param)
	print("HiryuOsaDead begin");
	
	SetNpcStateFlag(proxy, param, tyo_flag_list, TYO_STATE_DEAD );
	
	--ホストのみ入手 --EN:--get host only
	if	proxy:IsClient() == false then
		--▼トロフィー取得判定▼ --EN:--▼Trophy Acquisition Judgment▼
		Lua_RequestUnlockTrophy(proxy, 12);
		proxy:GetRateItem(10117);--アイテム入手 --EN:-- Get items
	end
	
	--王城１の長を消す --EN:--Erase the head of the castle 1
	InvalidCharactor(proxy,300);
	proxy:DeleteEvent(220);
	proxy:DeleteEvent(235);
	print("HiryuOsaDead end");
end

------------------------------------------------------------------------------------
--■1706■一定領域進入で王子が死ぬ■ --EN:-- ■ 1706 ■ The prince dies when entering a certain area ■
------------------------------------------------------------------------------------
--■初期化時のイベント登録■-------------------------------------------------------- --EN:--■ Event registration at initialization ■---------------------------------------- ----------------
function RegistEvent_1706(proxy)
	if	proxy:IsCompleteEvent( 1706 ) == false then
		if proxy:IsClient() == false then
			proxy:NotNetMessage_begin();
				proxy:OnRegionIn( 1706, LOCAL_PLAYER, 2720, "OnEvent_1706", once );
			proxy:NotNetMessage_end();
		end
		proxy:LuaCall( 1706 , 0 , "OnEvent_1706_1",once);
	end	
end

function OnEvent_1706(proxy,param)
	print("OnEvent_1706 begin");
	--proxy:SetEventFlag( 15492, true );
	--proxy:SetEventFlag( 15493, true );
	--proxy:SetEventFlag( 15494, true );
	
	--死亡では無いなら --EN:--If it's not death
	if proxy:IsCompleteEvent( RENDOL_STATE_DEAD ) == false then		
		--もういない状態のときに殺しても、死んだ判定の方で死亡に移行しないようになっているので --EN:--Even if you kill him when he's no longer around, the dead judgment doesn't move to death.
		--ここで死んでもらいます。 --EN:--Let me die here.
		--proxy:SetHp( 626, 0.0 );
		--Lua_EventForceDead( proxy , 626 );
		--エレベーター前の状態の時のみ殺す --EN:--Kill only when in front of the elevator
		if 	proxy:IsCompleteEvent( RENDOL_STATE_LIFT_FRONT ) == true or
			proxy:IsCompleteEvent( RENDOL_STATE_HOSTILE_4_LIFT_FRONT ) == true then
			SetNpcStateFlag( proxy, param, rendol_flag_list, RENDOL_STATE_ERASE );
			proxy:ForceDead( 626 );
		else
			SetNpcStateFlag( proxy, param, rendol_flag_list, RENDOL_STATE_ERASE );
		end
	end
	
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 1706 , "OnEvent_1706_wait",3.0,0,0,once);
	proxy:NotNetMessage_end();
	proxy:SetEventFlag( 1706 , true );
	print("OnEvent_1706 end");
end

--待ち時間 --EN:--wait time
function OnEvent_1706_wait(proxy,param)
	print("OnEvent_1706_wait begin");
	proxy:LuaCallStart( 1706 , 0 );
	print("OnEvent_1706_wait end");
end

--レンドルブラック出現 --EN:--Appearance of Lendl Black
function OnEvent_1706_1(proxy,param)
	--レンドル・ブラックが死んでない --EN:--Lendl Black isn't dead
	if proxy:IsCompleteEvent( 1640 ) == false then
		print("OnEvent_1706_1 begin");	
		ValidCharactor( proxy, 502 );
		proxy:PlayAnimation( 502 , 6100);
		print("OnEvent_1706_1 end");
	end
end



------------------------------------------------------------------------------------
--■1640■レンドル王子・ブラック死亡■ --EN:-- ■ 1640 ■ Prince Lendl Black died ■
------------------------------------------------------------------------------------
--■初期化時のイベント登録■-------------------------------------------------------- --EN:--■ Event registration at initialization ■---------------------------------------- ----------------
function RegistEvent_1640(proxy)
	if	proxy:IsCompleteEvent( 1640 ) == false then
		proxy:OnCharacterDead( 1640, 502, "OnEvent_1640", once );
		if proxy:IsCompleteEvent( 1706 ) == false then
			InvalidCharactor( proxy, 502 );
		end
	else
		InvalidCharactor( proxy, 502 );
	end
end

function OnEvent_1640(proxy,param)
	print("OnEvent_1640 begin");
	proxy:SetEventFlag( 1640, true );
	print("OnEvent_1640 end");
end


--------------------------------------------------------------------------------------
--■飛竜の長の攻撃待ち時間を取得します。 --EN:--■ Acquire the attack waiting time of the chief of the wyvern.
--------------------------------------------------------------------------------------
function GetDelay_HiryuOsa(proxy)
	--ブレスA～Cで使う攻撃ディレイ用の時間 --EN:--Time for attack delay used in Breath A~C
	local Delay_under	= HiryuOsa_AttackDelay_under * 100;
	local Delay_top		= HiryuOsa_AttackDelay_top * 100;
	local scale_dilay 	= proxy:GetRandom( Delay_under , Delay_top );--2～4秒 --EN:--2-4 seconds
	local atack_dilay_time = scale_dilay / 100;--2～4秒 --EN:--2-4 seconds
	return atack_dilay_time;
end


function OnEvent_1780(proxy,param)
	print("OnEvent_1780 begin");
	proxy:PlayAnimation( 512, 7000 );
	proxy:EnableLogic( 512, true );
	print("OnEvent_1780 end");
end


--■1670■飛竜の長のHPが75%以下■ --EN:-- ■ 1670 ■ Wyvern leader's HP is 75% or less ■
function OnEvent_1670(proxy,param)
	print("OnEvent_1670 begin");
	proxy:SetEventFlag( 1670, true );
	print("OnEvent_1670 end");
end

--■1671■飛竜の長のHPが50%以下■ --EN:-- ■ 1671 ■ Wyvern leader's HP is less than 50% ■
function OnEvent_1671(proxy,param)
	print("OnEvent_1671 begin");
	proxy:SetEventFlag( 1671, true );
	print("OnEvent_1671 end");
end




--■1790■飛竜の情報をビヨルングルムに教える --EN:--■1790■Tell Bjrngrum information about the flying dragon
function Condition_1790(proxy,param)
	if	proxy:IsCompleteEvent( TYO_STATE_WARNING_AISLE )		== true then
		proxy:SendEventRequest( 698, 0, AI_EVENT_HIRYU_GATE );
	else
		proxy:SendEventRequest( 698, 0, AI_EVENT_None );
	end
end



-----------------------------------------------------------------------------
--■1680■結晶トカゲイベント5 --EN:-- ■ 1680 ■ Crystal Lizard Event 5
-----------------------------------------------------------------------------
function OnEvent_1680(proxy,param)
	print("OnEvent_1680 begin");
	proxy:SetEventFlag( 1680, true);
	proxy:DeleteEvent( 1680 );
	print("OnEvent_1680 end");
end

-----------------------------------------------------------------------------
--■1682■結晶トカゲイベント6 --EN:-- ■ 1682 ■ Crystal Lizard Event 6
-----------------------------------------------------------------------------
function OnEvent_1682(proxy,param)
	print("OnEvent_1682 begin");
	proxy:SetEventFlag( 1682, true);
	proxy:DeleteEvent( 1682 );
	print("OnEvent_1682 end");
end

-----------------------------------------------------------------------------
--■1684■結晶トカゲイベント7 --EN:-- ■ 1684 ■ Crystal Lizard Event 7
-----------------------------------------------------------------------------
function OnEvent_1684(proxy,param)
	print("OnEvent_1684 begin");
	proxy:SetEventFlag( 1684, true);
	proxy:DeleteEvent( 1684 );
	print("OnEvent_1684 end");
end


-----------------------------------------------------------------------------
--■1690■三銃士１死んだ --EN:-- ■ 1690 ■ Three Musketeers 1 died
-----------------------------------------------------------------------------
function OnEvent_1690(proxy,param)
	print("OnEvent_1690 begin");
	proxy:SetEventFlag( 1690 , true );
	print("OnEvent_1690 end");
end

-----------------------------------------------------------------------------
--■1691■三銃士2死んだ --EN:-- ■ 1691 ■ The Three Musketeers 2 died
-----------------------------------------------------------------------------
function OnEvent_1691(proxy,param)
	print("OnEvent_1691 begin");
	proxy:SetEventFlag( 1691 , true );
	print("OnEvent_1691 end");
end

-----------------------------------------------------------------------------
--■1692■三銃士3死んだ --EN:-- ■ 1692 ■ The Three Musketeers 3 died
-----------------------------------------------------------------------------
function OnEvent_1692(proxy,param)
	print("OnEvent_1692 begin");
	proxy:SetEventFlag( 1692 , true );
	print("OnEvent_1692 end");
end
