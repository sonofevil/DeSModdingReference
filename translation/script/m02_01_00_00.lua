
function Initialize_m02_01_00_00(proxy)
	print("Initialize_m02_01_00_00 begin");

--[[
--OBJのID512＝操作OBJ　ID513＝本体 --EN:--OBJ ID512 = Operation OBJ ID513 = Body
--■512■バリスタイベント開始■ --EN:-- ■ 512 ■ barista event start ■
	proxy:RepeatMessage_begin();
		proxy:OnDistanceActionPlus(512, 10000, 1200, "OnEvent_512", 1.5, HELPID_START, 180, 45, 0,0,1,everytime);
	proxy:RepeatMessage_end();
	--ループアニメ同期用 --EN:--For loop animation synchronization
	proxy:LuaCall(512,2,"OnEvent_512_2",everytime);
	
--■513■バリスタ同期用■同期用のイベントIDとバリスタ用OnBallistaのイベントIDは同じ、paramは変えない事 --EN:-- ■ 513 ■ For varistor synchronization ■ Event ID for synchronization and OnBallista event ID for varistor are the same, param must not be changed
	proxy:LuaCall(513,0,"OnEvent_513_0",everytime);--0	…Y軸角度同期 --EN:--0 … Y-axis angle synchronization
	proxy:LuaCall(513,1,"OnEvent_513_1",everytime);--1	…X軸角度同期 --EN:--1 … X-axis angle synchronization
	proxy:LuaCall(513,2,"OnEvent_513_2",everytime);--2	…バリスタ発射同期 --EN:--2 … varistor firing synchronization
	proxy:LuaCall(513,3,"OnEvent_513_3",everytime);--3	…バリスタ終了同期 --EN:--3 … Varistor end synchronization
	proxy:LuaCall(513,4,"OnEvent_513_4",everytime);--4	…バリスタダメージ終了 --EN:--4 … End of ballista damage
	proxy:LuaCall(513,5,"OnEvent_513_5",everytime);--5	…フラグ同期用 --EN:--5 … for flag synchronization
]]
	

--■582■ボス部屋に入る■ --EN:-- ■ 582 ■ Enter the boss room ■
	
	--中ボスが生きているときだけイベント登録 --EN:-- Event registration only when the mid-boss is alive
	if proxy:IsCompleteEvent( 4224 ) == false then
	
		--ソロのときは一度目にボス部屋に入る用のイベントを毎回登録させたいので、対応するフラグをOFFにする。 --EN:-- When soloing, we want to register the event for entering the boss room for the first time every time, so turn off the corresponding flag.
		SingleReset(proxy, 582);

		--▽同期アニメ再生用の開始ハンドラ(旋回→歩き) --EN:--▽ Start handler for synchronous animation playback (turning → walking)
		proxy:LuaCall( 583, 1, "OnEvent_583_1", everytime );
		--▽2回目以降にボス部屋に入るためのイベント配信用 --EN:--▽For event delivery to enter the boss room after the second time
		proxy:LuaCall( 583 , 5 , "OnEvent_582_GO_TO_IN" , everytime );
		--▽フラグセット(同期用) --EN:--▽flag set (for synchronization)
		proxy:LuaCall( 583 , 6 , "OnEvent_582_flag_set" , everytime );
		
		--誰かがボス前扉をまだ通過していない --EN:--Someone hasn't passed through the boss front door yet
		if proxy:IsCompleteEvent( 582 ) == false then
		
			--(セッション中に)ボス前の魔法壁を最初に通れるのは生存の人だけ --EN:--(During the session) Only survivors can pass through the magic wall in front of the boss first
			local possible_chr_type = ATTR_HOST + ATTR_LIVE + ATTR_GREY;
			
			proxy:NotNetMessage_begin();
				--▼582▼中に入るためのイベントを追加▼ --EN:--▼582▼ Added an event to enter ▼
				proxy:OnPlayerActionInRegionAttribute( 582, 2894, "OnEvent_582", HELPID_GO_TO_IN, possible_chr_type, everytime );
			proxy:NotNetMessage_end();
			
		else --グレイゴーストできたときようにいると思われる。 --EN:--Gray ghost seems to be like that when it's done.
		
			proxy:NotNetMessage_begin();
				--▼583▼中に入るためのイベントを追加▼--ハンドラは上と同じ --EN:--▼583▼Add an event to enter inside▼--The handler is the same as above
				proxy:OnPlayerActionInRegion( 583, 2894, "OnEvent_582", HELPID_GO_TO_IN, everytime );
			proxy:NotNetMessage_end();		
		end
		proxy:SetColiEnableArray(3003,false);--通常無効 --EN:--usually disabled
		proxy:SetColiEnableArray(3004,false);--通常無効 --EN:--usually disabled
		proxy:SetColiEnableArray(3005,true);--ボス用有効 --EN:--Valid for Boss
		proxy:SetColiEnableArray(3006,true);--ボス用有効	 --EN:--Valid for Boss
	else
		proxy:SetColiEnableArray(3003,true);--通常有効 --EN:--usually valid
		proxy:SetColiEnableArray(3004,true);--通常有効 --EN:--usually valid
		proxy:SetColiEnableArray(3005,false);--ボス用無効 --EN:--disabled for boss
		proxy:SetColiEnableArray(3006,false);--ボス用無効 --EN:--disabled for boss
	end

	
--■584■ボスのポリ劇再生■ --EN:-- ■ 584 ■ Boss's polyplay playback ■

	if proxy:IsCompleteEvent( 584 ) == false then 
	
		--▼ボス前のポリ劇再生用監視追加 --EN:--▼ Added surveillance for polyplay playback in front of the boss
		proxy:OnRegionJustIn( 584 , 10000 , 2898 , "OnEvent_584" , once );
		
		proxy:NotNetMessage_begin();
			--ポリ劇開始に呼ばれるハンドラ --EN:--handler called at polyplay start
			proxy:LuaCall(584, REMO_START, "OnEvent_584_RemoStart", once);
			--ポリ劇終了後に呼ばれるハンドラ(トリガー起こした人用) --EN:--Handler called after the end of the polyplay (for the person who caused the trigger)
			proxy:LuaCall(584, REMO_FINISH, "OnEvent_584_RemoFinish", once);
		proxy:NotNetMessage_end();
	
	end


--■585■ボス戦闘開始■ --EN:-- ■ 585 ■ Boss battle begins ■
	if proxy:IsCompleteEvent( 4224 ) == false then
		--シングルロード時初期化 --EN:--Initialization at single load
		SingleReset( proxy , 585 );
		proxy:OnRegionJustIn( 585 , 10000 , 2886 , "OnEvent_585" , once );
	end


	
--■4224■中ボス死亡で何かが起こる■ --EN:-- ■ 4224 ■ Something happens when the mid-boss dies ■
	proxy:AddFieldInsFilter( 801 );
	if proxy:IsCompleteEvent( 4224 ) == false then		
		proxy:OnCharacterDead( 4224, 801, "OnEvent_4224", once );
	end
	

--■680■扉を鍵で開ける(サブイベント)■ --EN:-- ■ 680 ■ Open the door with the key (sub-event) ■
	if proxy:IsCompleteEvent( 680 ) == false then
		
		proxy:NotNetMessage_begin();
			proxy:OnDistanceActionPlus( 680, 10000, 1202, "OnEvent_680", DoorDist_A, HELPID_OPEN, 180, DoorAngle_A, 0.7, -1.0, 0.0, everytime );
		proxy:NotNetMessage_end();
		
		proxy:LuaCall( 680, 1, "OnEvent_680_1", once );--アニメーション同期用 --EN:--For animation synchronization
	else
		proxy:EndAnimation( 1202, 1 );
	end
	

--■682■扉を鍵で開ける(サブイベント)■ --EN:-- ■ 682 ■ Open the door with the key (sub-event) ■
	if proxy:IsCompleteEvent( 682 ) == false then
		
		proxy:NotNetMessage_begin();
			proxy:OnDistanceActionPlus( 682, 10000, 1205, "OnEvent_682", DoorDist_A, HELPID_OPEN, 180, DoorAngle_A, 1.0, -1.0, 0.0, everytime ); 
		proxy:NotNetMessage_end();
		
		proxy:LuaCall( 682, 1, "OnEvent_682_1", once );--アニメーション同期用 --EN:--For animation synchronization
	else
		proxy:EndAnimation( 1205, 1 );
	end


--■684■扉を鍵で開ける(サブイベント)■ --EN:-- ■ 684 ■ Open the door with the key (sub-event) ■
	if proxy:IsCompleteEvent( 684 ) == false then
		
		proxy:NotNetMessage_begin();
			proxy:OnDistanceActionPlus( 684, 10000, 1206, "OnEvent_684", DoorDist_A, HELPID_OPEN, 180, DoorAngle_A, 1.0, -1.0, 0.0, everytime ); 
		proxy:NotNetMessage_end();
		
		proxy:LuaCall( 684, 1, "OnEvent_684_1", once );--アニメーション同期用 --EN:--For animation synchronization
	else
		proxy:EndAnimation( 1206, 1 );
	end

--■686■扉を鍵で開ける(サブイベント)■ --EN:-- ■ 686 ■ Open the door with the key (sub-event) ■
	if proxy:IsCompleteEvent( 686 ) == false then
		
		proxy:NotNetMessage_begin();
			proxy:OnDistanceActionPlus( 686, 10000, 1203, "OnEvent_686", DoorDist_A, HELPID_OPEN, 180, DoorAngle_A, 1.0, -1.0, 0.0, everytime ); 
		proxy:NotNetMessage_end();
		
		proxy:LuaCall( 686, 1, "OnEvent_686_1", once );--アニメーション同期用 --EN:--For animation synchronization
	else
		proxy:EndAnimation( 1203, 1 );
	end

--■688■扉を鍵で開ける(サブイベント)■ --EN:-- ■ 688 ■ Open the door with the key (sub-event) ■
	if proxy:IsCompleteEvent( 688 ) == false then
		
		proxy:NotNetMessage_begin();
			proxy:OnDistanceActionPlus( 688, 10000, 1204, "OnEvent_688", DoorDist_A, HELPID_OPEN, 180, DoorAngle_A, 1.0, -1.0, 0.0, everytime ); 
		proxy:NotNetMessage_end();
		
		proxy:LuaCall( 688, 1, "OnEvent_688_1", once );--アニメーション同期用 --EN:--For animation synchronization
	else
		proxy:EndAnimation( 1204, 1 );
	end

	
--■??■徘徊デーモンの登場■ハンドラ登録 --EN:--■??■Appearance of wandering daemon■Handler registration
	proxy:NotNetMessage_begin();
		--プレイヤーがソロで死亡した時にキックされます。 --EN:--Kicked when a player dies solo.
		proxy:LuaCall( 4000, 100, "PlayerDeath_m02_01_00_00", everytime );
		--プレイヤーが復活した時にキックされます。 --EN:--Kicked when the player is revived.
		proxy:LuaCall( 4032, 100, "PlayerRevive_m02_01_00_00", everytime );
	proxy:NotNetMessage_end();

--■15622■獄吏の死体を調べたか？■ --EN:--■15622■Have you examined the jailer's corpse? ■
	if proxy:IsCompleteEvent( 15622 ) == false then
		proxy:AddCorpseEvent( 15622 , 115 );
		proxy:NotNetMessage_begin();
			proxy:LuaCall( 15622 ,0 , "OnEvent_15622",once );
 		proxy:NotNetMessage_end();
	end
	
--■560■獄吏の死亡■	 --EN:-- ■ 560 ■ prison guard's death ■
	if proxy:IsCompleteEvent( 560 ) == false then
		proxy:OnCharacterDead( 560 , 115 , "OnEvent_560" , once );
	end
	
	
	

----- ▼ビヨルングルム▼ ----------------------------------------		 --EN:-- ▼Bjrn Grum▼ ----------------------------------------

--■520■ビヨが感謝する■ --EN:-- ■ 520 ■ Beyo appreciates ■
	--(対応する扉を開けたときに 状態変更)  --EN:--(state change when corresponding door is opened)
--[[
	
--■521■ビヨが獄吏を倒しに行く■(会話システムから呼び出し) --EN:--■521■Biyo goes to defeat the jailer■(call from conversation system)
	if proxy:IsCompleteEvent( 521 ) == false then
		proxy:NotNetMessage_begin();
			proxy:LuaCall( 521 , 0 , "OnEvent_521" , once );--会話システムから呼び出す場合はparam=0を指定 --EN:--Specify param=0 when calling from the conversation system
		proxy:NotNetMessage_end();
	end
	
--■522■ビヨが牢屋内で寝る■(会話システムから呼び出し) --EN:--■522■Byo sleeps in prison■ (call from conversation system)
	if proxy:IsCompleteEvent( 522 ) == false then
		proxy:NotNetMessage_begin();
			proxy:LuaCall( 522 , 0 , "OnEvent_522" , once );--会話システムから呼び出す場合はparam=0を指定 --EN:--Specify param=0 when calling from the conversation system
		proxy:NotNetMessage_end();
	end

--■523■ビヨが城壁で寝る■ --EN:--■523■Byo sleeps on the wall■
	--(獄吏が死んだときに、判定) --EN:--(judgment when jailer dies)

--■524■ビヨが次のブロックへ移動する■ --EN:--■524■Byo moves to the next block■
	--(獄吏が死んだときに、監視追加) --EN:--(Added a monitor when the jailer died)

--■525■ビヨが牢内で敵になる■ --EN:-- ■ 525 ■ Biyo becomes an enemy in prison ■
	if proxy:IsCompleteEvent( 525 ) == false then
		proxy:OnCharacterTotalDamage( 525 , 622 , 10000 , 100 , "OnEvent_525" , once );
	end
	
--■526■ビヨが城壁で敵になる■ --EN:-- ■ 526 ■ Biyo becomes an enemy at the castle wall ■
	if proxy:IsCompleteEvent( 526 ) == false then
		proxy:OnCharacterTotalDamage( 526 , 622 , 10000 , 100 , "OnEvent_526" , once );
	end
	
--■527■ビヨが死ぬ■ --EN:-- ■ 527 ■ Biyo dies ■
	if proxy:IsCompleteEvent( 527 ) == false then
		proxy:OnCharacterDead(527,622,"OnEvent_527",once);
	end
]]	
------- ▲ビヨルングルム▲ --------------------------------------	 --EN:-- ▲ Bjrn Grum ▲ ---------------------------------------


--■652■レンドル追っかけ兵士Aの死亡■ --EN:-- ■ 652 ■ Death of Rendor Chasing Soldier A ■
	if proxy:IsCompleteEvent( 652 ) == false then
		--proxy:OnCharacterDead(652,102,"OnEvent_652",once);
		proxy:OnCharacterDead(652,102,"OnEvent_720",once);
	end
	
--■654■レンドル追っかけ兵士Bの死亡■ --EN:-- ■ 654 ■ Death of Rendor Chasing Soldier B ■
	if proxy:IsCompleteEvent( 654 ) == false then
		--proxy:OnCharacterDead(654,103,"OnEvent_654",once);
		proxy:OnCharacterDead(654,103,"OnEvent_720",once);
	end
	
--■655■レンドル追っかけ兵士Cの死亡■ --EN:--■655■Death of soldier chasing Lendl C■
	if proxy:IsCompleteEvent( 655 ) == false then
		proxy:OnCharacterDead(655,104,"OnEvent_720",once);
	end
	
--■656■レンドル追っかけ兵士Dの死亡■ --EN:-- ■ 656 ■ Death of Rendor Chasing Soldier D ■
	if proxy:IsCompleteEvent( 656 ) == false then
		proxy:OnCharacterDead(656,105,"OnEvent_720",once);
	end

--■657■レンドル追っかけ兵士Eの死亡■ --EN:-- ■ 657 ■ Death of Rendor Chasing Soldier E ■
	if proxy:IsCompleteEvent( 657 ) == false then
		proxy:OnCharacterDead(657,106,"OnEvent_720",once);
	end
	
--■658■レンドル追っかけ兵士Dの死亡■ --EN:-- ■ 658 ■ Death of Rendor Chasing Soldier D ■
	if proxy:IsCompleteEvent( 658 ) == false then
		proxy:OnCharacterDead(658,107,"OnEvent_720",once);
	end





--[[-- ▼乞食ショップ▼ ------------------------------------------------------- --EN:-- ▼ Beggar Shop ▼ -------------------------------------------- -----------

--■760■乞食の敵対化■ --EN:-- ■ 760 ■ beggar's hostility ■
	if proxy:IsCompleteEvent( 760 ) == false then
		proxy:OnCharacterTotalDamage( 760, 623, 10000, 100, "OnEvent_760", once );
	end

--■761■乞食の死亡■ --EN:-- ■ 761 ■ beggar's death ■
	if proxy:IsCompleteEvent( 761 ) == false then
		proxy:OnCharacterDead( 761 , 623 , "OnEvent_761" , once );
	end		

----- ▲乞食ショップ▲ -------------------------------------------------------- --EN:-- ▲ Beggar Shop ▲ -------------------------------------------- ------------
]]


----- ▼飛竜(眷属)▼ ----------------------------------------------------------	 --EN:-- ▼ Wyvern (kin) ▼ ----------------------------------------- -----------------

--■830■領域監視■ --EN:-- ■ 830 ■ area monitoring ■
	proxy:OnNetRegion(830 , 2320);	
--■831■領域監視■ --EN:-- ■ 831 ■ area monitoring ■
	proxy:OnNetRegion(831 , 2321);	
--■832■領域監視■ --EN:-- ■ 832 ■ Area monitoring ■
	proxy:OnNetRegion(832 , 2322);	

----- ▲飛竜(眷属)▲ ----------------------------------------	 --EN:-- ▲ Wyvern (kin) ▲ -----------------------------------------

--■中ボスが死亡していたら --EN:-- If the mid-boss died
	--王の盾死亡再現 --EN:--King's Shield Death Reenactment
	if proxy:IsCompleteEvent( 4224 ) ==false then
		--王の盾の初期化		 --EN:--Initialization of King's Shield
		proxy:EnableLogic( 801 , false );		
	else
		--王の盾削除(無効化) --EN:--King's shield deleted (disabled)
		InvalidBackRead( proxy , 801 );
		
		--上にいる一般兵士削除(無効化) --EN:-- Delete general soldiers above (disable)
		local enemy_list = {120,121,122,123,124,125,126,127};
		local enemy_num  = table.getn( enemy_list );
		
		for i=1, enemy_num, 1 do
			InvalidBackRead( proxy, enemy_list[i] );
		end
	end
	
	--上にいる一般兵士をセーブロードの対象から外す --EN:--Exclude general soldiers above from saving and loading
	local enemy_list = {120,121,122,123,124,125,126,127};
	local enemy_num  = table.getn( enemy_list );
	
	for i=1, enemy_num, 1 do
		proxy:AddFieldInsFilter(enemy_list[i] );
	end	
	
	
	--■中ボス死亡で扉が開く(死んでいたら、描画と当たりを消す) --EN:--■ The door opens when the mid-boss dies (if it dies, the drawing and hits are erased)
	if proxy:IsCompleteEvent( 4224 ) == true then
		proxy:SetColiEnable( 1998 , false );
		proxy:SetColiEnable( 1994 , false );
	
		proxy:SetDrawEnable( 1998 , false );
		proxy:SetDrawEnable( 1994 , false );

		--SFX OFF
		proxy:InvalidSfx( 1986 , false );
		proxy:InvalidSfx( 1990 , false );
	end
	
	
	
	--■4252,4254■ソウル入手、要石でワープ■ --EN:-- ■ 4252, 4254 ■ Get soul, warp with keystone ■
	if proxy:IsCompleteEvent( 4224 ) ==true then--ボスが死んでいるとき --EN:--when the boss is dead
		proxy:TreasureDispModeChange2( 1981 , true ,KANAME_SFX);--光らせる --EN:-- let it shine
		--▼(ソウル)アイテム取得用イベント監視追加▼ --EN:--▼ (Soul) Added event monitoring for item acquisition▼
		if proxy:IsCompleteEvent( 4252 ) == false then
			proxy:ValidSfx( 1220 );--SFX 有効化 --EN:--SFX enable
			proxy:ValidSfx( 1221 );--SFX 有効化 --EN:--SFX enable
			proxy:OnDistanceActionAttribute( 4252 , 10000 , 1981 , "OnEvent_4252" , WarpGimmickDist_A , 10010180 , 0 , 180 , ATTR_HOST + ATTR_LIVE + ATTR_GREY, once );

			--ソウル有効化 --EN:--Soul activation
			proxy:SetDrawEnable( 1981 , true );
			proxy:SetColiEnable( 1981 , true );
			--ソウル2有効化 --EN:--Activate Soul 2
			proxy:SetDrawEnable( 1976 , true );
			proxy:SetColiEnable( 1976 , true );
		else
			--▼要石でワープ用の監視を追加▼ --EN:--▼ Added surveillance for warp with keystone ▼
			proxy:InvalidSfx( 1220, false );--光の粒子 --EN:--Particles of light
			SingleReset(proxy,4254);
			proxy:OnDistanceActionAttribute( 4254 , 10000 , 1981 , "OnEvent_4254" , WarpGimmickDist_A , HELPID_GO_TO_SEKITYUU , 0 , 180 , ATTR_NOSESSION , everytime );
		end

	else
		--ソウル無効化 --EN:--Soul Invalidation
		proxy:SetDrawEnable( 1981 , false );
		proxy:SetColiEnable( 1981 , false );
		--ソウル2無効化 --EN:--Soul 2 disabled
		proxy:SetDrawEnable( 1976 , false );
		proxy:SetColiEnable( 1976 , false );
		--SFX 無効化 --EN:--Disable SFX
		proxy:InvalidSfx( 1221 , false );
		proxy:InvalidSfx( 1220 , false );
	end
	
	--中ボス倒していて --EN:--Defeating the mid-boss
	if proxy:IsCompleteEvent( 4224 ) == true then
		--解放ポリ劇が終わってなければ --EN:--If the liberation police drama is not over
		if proxy:IsCompleteEvent( 571 ) == false then
			local attr = ATTR_NOSESSION + ATTR_LIVE + ATTR_GREY;
			proxy:NotNetMessage_begin();
			--proxy:OnDistanceActionAttribute( 570 , 10000 , 1270 , "OnEvent_570" , DoorDist_A,HELPID_OPEN,180,DoorAngle_A,attr,everytime);
			
			proxy:OnRegionJustIn( 570 , 10000 , 2250 , "OnEvent_570" , everytime );
			
			proxy:LuaCall( 571 , REMO_START ,"OnEvent_571_RemoStart",once);
			proxy:LuaCall( 571 , REMO_FINISH,"OnEvent_571_RemoFinish",once);
			proxy:NotNetMessage_end();
		else
			--扉を開けておく --EN:--Keep the door open
			proxy:EndAnimation( 1270 , 2);
			proxy:InvalidSfx( 2210 , false);
		end
	end
	
	--[[
	--■652■レンドル追っかけ兵士Aの死亡■ --EN:-- ■ 652 ■ Death of Rendor Chasing Soldier A ■
	if proxy:IsCompleteEvent( 652 ) == true then		
		InvalidCharactor( proxy,102);
	end
		
	--■654■レンドル追っかけ兵士Bの死亡■ --EN:-- ■ 654 ■ Death of Rendor Chasing Soldier B ■
	if proxy:IsCompleteEvent( 654 ) == true then
		InvalidCharactor( proxy,103);
	end
	
	--■655■レンドル追っかけ兵士Cの死亡■ --EN:--■655■Death of soldier chasing Lendl C■
	if proxy:IsCompleteEvent( 655 ) == true then
		InvalidCharactor( proxy,104);
	end

	--■656■レンドル追っかけ兵士Dの死亡■ --EN:-- ■ 656 ■ Death of Rendor Chasing Soldier D ■
	if proxy:IsCompleteEvent( 656 ) == true then		
		InvalidCharactor( proxy,105);		
	end
	
	--■657■レンドル追っかけ兵士Eの死亡■ --EN:-- ■ 657 ■ Death of Rendor Chasing Soldier E ■
	if proxy:IsCompleteEvent( 657 ) == true then
		InvalidCharactor( proxy,106);
	end
	
	--■658■レンドル追っかけ兵士Fの死亡■ --EN:-- ■ 658 ■ Death of Rendor Chasing Soldier F ■
	if proxy:IsCompleteEvent( 658 ) == true then
		InvalidCharactor( proxy,107);
	end
	]]
	--■■レンドル追っかけ兵士Aの無効化■ --EN:--■■ Disabling Rendor Chasing Soldier A ■
	InvalidCharactor( proxy,102);		
	--■■レンドル追っかけ兵士Bの無効化■ --EN:--■■ Disabling Rendor Chasing Soldier B ■
	InvalidCharactor( proxy,103);
	--■■レンドル追っかけ兵士Cの無効化■ --EN:--■■ Disabling Rendor Chasing Soldier C ■
	InvalidCharactor( proxy,104);
	--■■レンドル追っかけ兵士Dの無効化■ --EN:--■■ Disabling Rendor Chasing Soldier D■
	InvalidCharactor( proxy,105);		
	--■■レンドル追っかけ兵士Eの無効化■	 --EN:--■■ Disabling Rendor Chasing Soldier E ■
	InvalidCharactor( proxy,106);	
	--■■レンドル追っかけ兵士Fの無効化■	 --EN:--■■ Disabling Rendor Chasing Soldier F ■
	InvalidCharactor( proxy,107);
	
	if	proxy:IsCompleteEvent(RENDOL_STATE_HELP_HIDING_ME) == true then
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
	end
	
	--■560■獄吏の死亡■ --EN:-- ■ 560 ■ prison guard's death ■
	if proxy:IsCompleteEvent( 560 ) == true then
		if proxy:IsCompleteEvent( 15622 ) == false then
			--宝になれる死体再現 --EN:--Recreating a corpse that can become a treasure
			proxy:OpeningDeadPlus( 115, true ,false ,false );
		else			
			--無効化 --EN:--Invalidation
			InvalidCharactor( proxy,115);
		end
	end
	
	
	
	--光の霧を通過できるキャラタイプ(このタイプの人だけアクションボタンが反応する) --EN:--Character type that can pass through the fog of light (only this type of person reacts to the action button)
	local possible_chr_type = ATTR_HOST + ATTR_LIVE + ATTR_GREY;
	
	--■670■ホストPCのみが通れる光の霧■ --EN:-- ■ 670 ■ A fog of light that only the host PC can pass through ■
	if proxy:IsCompleteEvent( 670 ) == true then--ホストが通過済み --EN:--Host passed
		proxy:SetDrawEnable( 1260 , false );
		proxy:SetColiEnable( 1260 , false );
		proxy:InvalidSfx( 2230 , false );
	else
		--▼670▼魔法壁削除同期用▼ --EN:--▼670▼For synchronizing magic wall deletion▼
		proxy:LuaCall( 670 , 1 , "OnEvent_670_delete_wall" , once );
		
		--▼670▼壁の中に入るイベント発動用▼ --EN:--▼670▼For triggering an event to enter the wall▼
		proxy:OnDistanceActionAttribute( 670 , 10000 , 1260 , "OnEvent_670" , 1.5 , HELPID_GO_TO_IN , 180 , DoorAngle_A , possible_chr_type, everytime );
	end	

	
	
--■飛竜イベント関連初期化 --EN:-- ■ Wyvern event-related initialization

	--初期化 --EN:--Initialization
	proxy:SetDisableGravity( 110 , true );--重力OFF --EN:--Gravity off
	proxy:EnableLogic( 110 , false );--思考OFF --EN:--Thinking OFF
	proxy:SetSuperArmor( 110 , true );--ダメージモーションさせない --EN:--No damage motion
	proxy:SetDeadMode(110, true);--飛竜は死なない設定(死にそうになったら撤退する) --EN:--Set so that flying dragons don't die (withdraw if they're about to die)
	
	--初期位置にワープ --EN:--Warp to initial position
	proxy:Warp( 110 , 2330 );

	--初期状態をセット --EN:--set initial state
	SetFirstNpcStateFlag( proxy , param , kenzoku_2_flag_list , KENZOKU_2_STATE_WARNING );
	
	--現在の状態取得 --EN:-- Get current status
	local now_state = GetNpcStateFlag(proxy, param, kenzoku_2_flag_list);
	
	--警戒 --EN:-- vigilance
	if now_state == KENZOKU_2_STATE_WARNING then
	
	--ヘロヘロ --EN:--hero hero
	elseif now_state == KENZOKU_2_STATE_HEROHERO then
	
	--死亡(王城1or王城2) --EN:--Death (Castle 1 or Royal Castle 2)
	elseif now_state == KENZOKU_2_STATE_DEAD or
	       now_state == KENZOKU_STATE_DEAD   then
		proxy:OpeningDead( 110, false );
		InvalidCharactor( proxy , 110 );--飛竜(眷属)無効化 --EN:--Invalidation of wyvern (kin)
		
	--その他 --EN:--others
	else
		InvalidCharactor( proxy , 110 );--飛竜(眷属)無効化 --EN:--Invalidation of wyvern (kin)
	end
	
	
	
--■ビヨルングルムイベント関連初期化	 --EN:--■ Bjrn Grum event-related initialization
	
	--初期状態を設定 --EN:--set initial state
	SetFirstNpcStateFlag(proxy, param, biyo_flag_list, BIYO_STATE_CAPTIVE);
 
	--現在の状態を取得 --EN:--get current state
	local now_state = GetNpcStateFlag( proxy, param, biyo_flag_list );
	
	--牢屋に囚われ --EN:--Captured in prison
	if now_state == BIYO_STATE_CAPTIVE then
	
		proxy:EnableLogic( 622 , false );--ロジックOFF --EN:--Logic OFF
		proxy:SetEventCommand( 622 , 50 );--EzStateに制御番号(座らせる)を渡す --EN:-- Pass control number (sit) to EzState
	
	--解放してくれて感謝 --EN:--thank you for freeing me
	elseif now_state == BIYO_STATE_THANKS then
	
		proxy:EnableLogic( 622 , false );
		proxy:SetEventCommand( 622 , 50 );--EzStateに制御番号(座らせる)を渡す --EN:-- Pass control number (sit) to EzState
	
	--牢屋で寝ている --EN:-- sleeping in jail
	elseif now_state == BIYO_STATE_SLEEPING_IN_PRISON then
	
		proxy:EnableLogic( 622 , false );
		proxy:SetEventCommand( 622 , 60 );--EzStateに制御番号(寝る)を渡す --EN:-- Pass control number (sleep) to EzState
		
	--敵対(牢内) --EN:-- Hostility (in prison)
	elseif now_state == BIYO_STATE_HOSTILE_IN_PRISON then
	
		--(予約) --EN:--(reserve)
		--ロジック切り替えるなど･･･? --EN:--Switch logic, etc...?

	--獄吏を倒したい --EN:--I want to defeat the jailer
	elseif now_state == BIYO_STATE_TARGET_ENEMY then
	
		proxy:Warp( 622 , 2240 );--指定ポイントにワープ --EN:--Warp to specified point
	
	--逆襲に満足して寝る --EN:--sleeping satisfied with counterattack
	elseif now_state == BIYO_STATE_END_OF_STRIKES_BACK then
	
		proxy:Warp( 622 , 2240 );
		proxy:EnableLogic( 622 , false );
		proxy:SetEventCommand( 622 , 60 );--EzStateに制御番号(寝る)を渡す --EN:-- Pass control number (sleep) to EzState
	
	--敵対(城壁) --EN:-- Hostility (Castle wall)
	elseif BIYO_STATE_HOSTILE_IN_RAMPART then
	
		proxy:Warp( 622 , 2240 );
		--ロジック切り替えるなど･･･? --EN:--Switch logic, etc...?
	
	--死亡 --EN:--death
	elseif BIYO_STATE_DEAD then
		InvalidCharactor( proxy , 622 );--無効化 --EN:--Invalidation
	
	--それ以外 --EN:--other than that
	else
		InvalidCharactor( proxy , 622 );--無効化 --EN:--Invalidation
	end	
	
	
	
--[[■乞食イベント関連初期化 --EN:--[[ ■Beggar event-related initialization

	--初期状態を設定 --EN:--set initial state
	SetFirstNpcStateFlag(proxy, param, kojiki_flag_list, KOJIKI_STATE_SEELING);
 
	--現在の状態を取得 --EN:--get current state
	local now_state = GetNpcStateFlag( proxy, param, kojiki_flag_list );
	
	--販売中 --EN:--Sale
	if now_state == KOJIKI_STATE_SEELING then
	
		proxy:EnableLogic( 623 , false );--ロジックOFF --EN:--Logic OFF
	
	--敵対(王城2) --EN:-- Hostility (Castle 2)
	elseif now_state == KOJIKI_STATE_HOSTILE_2 then
	
		--(予約) --EN:--(reserve)
	
	--死亡 --EN:--death
	elseif now_state == KOJIKI_STATE_DEAD then
	
		InvalidCharactor( proxy , 623 );--乞食ショップ無効化 --EN:--Disable beggar shop

	else
		--(恐らく他のマップにはいない) --EN:-- (Probably not on other maps)
	end
]]
	
--■8084■王城に来たフラグを立てる■ --EN:-- ■ 8084 ■ Raise a flag for coming to the royal castle ■
	proxy:SetEventFlag(8084, true);


--■550■ボス戦カメラ対応■ --EN:-- ■ 550 ■ Boss battle camera support ■
	--ボスが生きているなら登録 --EN:--Register if the boss is alive
	if proxy:IsCompleteEvent(4224) == false then
		proxy:NotNetMessage_begin();
			proxy:OnRegionIn( 550 , 10000 , 2886 ,"OnEvent_550" , everytime );
		proxy:NotNetMessage_end();
	end
	
------------------▽▽▽QWC関連▽▽▽------------------- --EN:--▽▽▽QWC related ▽▽▽-------------------
--■610■QWC:ソウルモンスター出現１■ --EN:-- ■ 610 ■ QWC: Soul monster appearance 1 ■
	--ホストのみは、必ずフラグを0にして、敵を一旦無効化する --EN:-- Only the host must set the flag to 0 and disable the enemy once
	if	proxy:IsClient() == false then
		SingleReset(proxy, 610);
	end
	--後から入ってくる人が既に表示がOnになっているかチェックする --EN:--Check if people who come in later have already turned on the display
	if	proxy:IsCompleteEvent(610) == false then
		InvalidCharactor( proxy, 150 );
		InvalidCharactor( proxy, 151 );
	end
	if	proxy:IsSuccessQWC(20100) == true then
		print("m02_01 QWCソウルモンスター出現　成立"); --EN:print("m02_01 QWC soul monster appears established");
		proxy:OnRegionJustIn( 610, LOCAL_PLAYER, 2200, "OnEvent_610", once );
	else
		print("m02_01 QWCソウルモンスター出現　未成立"); --EN:print("m02_01 QWC Soul Monster Appearance Unestablished");
	end
------------------△△△QWC関連△△△------------------- --EN:--△△△QWC related△△△-------------------

--■カラスイベントをSingleReset()する■ --EN:--■SingleReset() the crow event■
	for IndexID = 850, 870, 1 do
		SingleReset(proxy, IndexID);
	end
	
--■カラス監視追加初期化■ --EN:-- ■ Crow monitoring addition initialization ■
	--カラスがＰＣが近づくと飛び立つ --EN:--A crow takes off when a PC approaches
	for KarasuID = 850, 870, 1 do
		if proxy:IsCompleteEvent( KarasuID ) == false then
			proxy:OnPlayerDistanceInTarget( KarasuID, 10000, 380 + KarasuID, "OnEvent_"..KarasuID, 5, once );
		else
			proxy:SetDrawEnable(380 + KarasuID, false);
			proxy:SetColiEnable(380 + KarasuID, false);
		end
	end
	
	--結晶トカゲイベント --EN:--Crystal Lizard Event
	RegistTokage(proxy,590,252,1);
	RegistTokage(proxy,592,253,2);
	
	--■999999■フレーム遅れの初期化処理イベントを発行■ --EN:-- ■ 999999 ■ Generate a frame delay initialization processing event ■
	proxy:NotNetMessage_begin();
		--▼0秒後▼-- --EN:--▼After 0 seconds▼--
		proxy:OnKeyTime2( 999991, "Second_Initialize_m02_01_00_00", 0.0, 0, 0, once );	
	proxy:NotNetMessage_end();	
	
	print("Initialize_m02_01_00_00 end");
end


--------------------------------------------------------------------------------------
--Initializeから呼ばれる、1フレーム遅れの初期化処理■999999 --EN:--Initialization with a delay of 1 frame, called from Initialize ■999999
--------------------------------------------------------------------------------------
--■999999■一部、Initでは処理できないので、残しておく --EN:-- ■ 999999 ■ Some parts cannot be processed by Init, so leave them
function Second_Initialize_m02_01_00_00(proxy, param)
	print("Second_Initialize_m02_01_00_00 begin");

------------------▽▽▽QWC関連▽▽▽------------------- --EN:--▽▽▽QWC related ▽▽▽-------------------
------------------△△△QWC関連△△△------------------- --EN:--△△△QWC related△△△-------------------
		
	print("Second_Initialize_m02_01_00_00 end");
end

--------------------------------------------------------------------------------------
--4224■中ボス死亡で何かが起こる --EN:--4224 ■ Something happens when the mid-boss dies
--------------------------------------------------------------------------------------
--■4224■中ボス死亡で何かが起こる■ --EN:-- ■ 4224 ■ Something happens when the mid-boss dies ■
function OnEvent_4224(proxy,param)
	print("OnEvent_4224 begin");

	proxy:NotNetMessage_begin();
		--▼4250▼クライアントPCワープ演出▼ --EN:--▼4250▼Client PC warp effect▼
		proxy:OnKeyTime2( 4250, "OnEvent_4250", 0, 0, 0, once);
		--▼4224_1▼1秒後▼ --EN:--▼4224_1▼After 1 second▼
		proxy:OnKeyTime2( 4224, "OnEvent_4224_1", 1.0, 0, 1, once );
		--▼4251▼2秒経過▼ --EN:--▼4251▼2 seconds passed▼
		proxy:OnKeyTime2( 4251, "OnEvent_4251", 2, 0, 2, once);
		
		--マルチ解散監視用 --EN:--For multi-dismissal monitoring
		proxy:OnRegistFunc( 4224 , "Check_4224_PT","OnEvent_4224_PT",0,once);
	proxy:NotNetMessage_end();

	--レンドル王子が探索中なら、次のマップの状態に移行 --EN:--If Prince Lendl is exploring, move to the next map state
	if	proxy:IsCompleteEvent(RENDOL_STATE_SEARCH_2) == true then
		InvalidCharactor( proxy, 620 );
		RendolCheck(proxy,param);--関数の中で、王城３か王城４か、どちらに出現するか判定 --EN:--In the function, determine whether it appears in royal castle 3 or royal castle 4
		--SetNpcStateFlag( proxy, param, rendol_flag_list, RENDOL_STATE_LOCATION_INVISIBLE );
	end

	--ボス死亡フラグセット --EN:--boss death flag set
	proxy:SetEventFlag( 4224 , 1 );	
	
	proxy:SetColiEnableArray(3003,true);--通常有効 --EN:--usually valid
	proxy:SetColiEnableArray(3004,true);--通常有効 --EN:--usually valid
	proxy:SetColiEnableArray(3005,false);--ボス用無効 --EN:--disabled for boss
	proxy:SetColiEnableArray(3006,false);--ボス用無効 --EN:--disabled for boss
		
	--新ブロッククリア処理へ --EN:--To new block clear processing
	proxy:CustomLuaCallStart( 4050, 801 );
	--結晶トカゲリセット --EN:-- crystal lizard reset
	ResetTokage(proxy);
	
	--エリア開放インフォメーション --EN:--Area open information
	--[[
	if proxy:IsClient() == false then
		proxy:NotNetMessage_begin();
			proxy:OnKeyTime2( 4224 , "OnEvent_4224_2",5.0,0,0,once);
		proxy:NotNetMessage_end();
	end
	]]
	print("OnEvent_4224 end");
end

--▲4224_1▲1秒後▲ --EN:--▲4224_1▲After 1 second▲
function OnEvent_4224_1(proxy,param)
	print("OnEvent_4224_1 begin");
	
	--ボスを倒した数を更新(数によってフラグを立てる) --EN:--update number of bosses killed (flag by number)
	GetBossFlagCount( proxy, param );
	
	--▼トロフィー取得判定▼ --EN:--▼Trophy Acquisition Judgment▼
	Lua_RequestUnlockTrophy(proxy, 28);
	
	--▼(ソウル)アイテム取得用イベント監視追加▼ --EN:--▼ (Soul) Added event monitoring for item acquisition▼
	if proxy:IsCompleteEvent( 4252 ) == false then
	
		--ソウル有効化 --EN:--Soul activation
		proxy:SetDrawEnable( 1981 , true );
		proxy:SetColiEnable( 1981 , true );
		--ソウル2有効化 --EN:--Activate Soul 2
		proxy:SetDrawEnable( 1976 , true );
		proxy:SetColiEnable( 1976 , true );
		
		proxy:ValidSfx( 1220 );--SFX 有効化 --EN:--SFX enable
		proxy:ValidSfx( 1221 );--SFX 有効化 --EN:--SFX enable
		
		proxy:TreasureDispModeChange2( 1981 , true ,KANAME_SFX);--光らせる --EN:-- let it shine
		proxy:OnDistanceActionAttribute( 4252 , 10000 , 1981 , "OnEvent_4252" , WarpGimmickDist_A , 10010180 , 0 , 180 , ATTR_HOST + ATTR_LIVE + ATTR_GREY, once );
	else
		--ソウル無効化(取ったら消えるので･･･) --EN:--Soul nullification (because it disappears when you take it...)
		proxy:SetDrawEnable( 1981 , false );
		proxy:SetColiEnable( 1981 , false );
	end	

	print("OnEvent_4224_1 end");
end

--[[
--エリア解放の表示 --EN:--Display area release
function OnEvent_4224_2(proxy,param)
	print("OnEvent_4224_2 begin");
	--インフォ表示 --EN:--Info display
	--システムメッセージ --EN:--system message
	proxy:InfomationMenu( INFOMENU_TYPE_LIST, -1, 0, -1, 1 );
	proxy:AddInfomationBuffer( 10010740 );
	proxy:PlayTypeSE( 10000 ,SOUND_TYPE_M ,777777777 );
	print("OnEvent_4224_2 end");
end
]]

--------------------------------------------------------------------------------------
--■4250■クライアントPCワープ演出■ --EN:-- ■ 4250 ■ Client PC warp effect ■
--------------------------------------------------------------------------------------

--■4250■クライアントPCワープ演出■ --EN:-- ■ 4250 ■ Client PC warp effect ■
function OnEvent_4250(proxy, param)
	print("OnEvent_4250 begin");

	if proxy:IsClient() == true then
		proxy:PlayAnimation( 10000 , 8284 );--ワープアニメを再生 --EN:-- Play warp animation
	end

	proxy:SetEventFlag( 4250 , 1 );
	
	print("OnEvent_4250 end");
end


--------------------------------------------------------------------------------------
--■4251■シングル：光の壁、BGM消去■ --EN:-- ■ 4251 ■ Single: Wall of Light, BGM Elimination ■
--------------------------------------------------------------------------------------

--■4251■シングル：光の壁、BGM消去■ --EN:-- ■ 4251 ■ Single: Wall of Light, BGM Elimination ■
function OnEvent_4251(proxy, param)
	print("OnEvent_4251 begin");
		
	--ボス戦用のBGM停止 --EN:--BGM stop for boss battles
	proxy:StopPointSE( 1 );	
	
--[[	
	--▼レンドル王子が次のブロックに移動するイベントの監視追加▼ --EN:--▼ Added monitoring event when Prince Lendl moves to the next block ▼
	if proxy:IsLivePlayer() == true or proxy:IsGreyGhost() == true then
		proxy:NotNetMessage_begin();
			proxy:OnRegistFunc( 722 , "Check_OnEvent_722" , "OnEvent_722" , 1 , once );
		proxy:NotNetMessage_end();
	end
]]	
	--上にいる一般兵士削除(強制死亡) --EN:-- Delete general soldier above (forced death)
	local enemy_list = {120,121,122,123,124,125,126,127};
	local enemy_num  = table.getn( enemy_list );
	
	for i=1, enemy_num, 1 do
		proxy:ForceDead( enemy_list[i] );
	end
	
	proxy:SetEventFlag( 4251 , 1 );
	
	print("OnEvent_4251 end");
end

--マルチ解散監視 --EN:--Multi-Dismissal Monitoring
function Check_4224_PT(proxy)
	if proxy:IsInParty() == false then
		return true;
	end
	return false;
end

--マルチじゃなくない --EN:--not multiplayer
function OnEvent_4224_PT(proxy,param)
	print("OnEvent_4224_PT begin");
	--中ボス部屋の前後の魔法壁が消える(全プレイヤー) --EN:--The magic walls before and after the mid-boss room disappear (all players)
	proxy:SetColiEnable( 1998 , false );
	proxy:SetColiEnable( 1994 , false );
	--proxy:SetObjDeactivate( 1998 , true );--デアクティブ --EN:--deactivate
	--proxy:SetObjDeactivate( 1994 , true );--デアクティブ --EN:--deactivate
	
	proxy:SetDrawEnable( 1998 , false );
	proxy:SetDrawEnable( 1994 , false );
	
	--中ボス部屋魔法壁のSFX削除 --EN:--Remove the SFX of the mid-boss room magic wall
	proxy:InvalidSfx( 1986 , true );
	proxy:InvalidSfx( 1990 , true );
	
	--中ボス部屋前の移動処理イベントを削除 --EN:--Delete the movement processing event in front of the mid-boss room
	proxy:DeleteEvent( 582 );--一人目が入るとき用 --EN:--For when the first person enters
	proxy:DeleteEvent( 583 );--二人目以降が入るとき用 --EN:--For when the second and subsequent people enter
	proxy:DeleteEvent( 584 );--ポリ劇再生用 --EN:--For polyplay play
	proxy:DeleteEvent( 585 );--ボス戦闘開始用 --EN:--For boss battle start
	print("OnEvent_4224_PT end");
end

--------------------------------------------------------------------------------------
--石柱にワープ(ボス倒した後用)■4254 --EN:-- Warp to the stone pillar (for after defeating the boss) 4254
--------------------------------------------------------------------------------------
--■4254■石柱にワープ■ --EN:-- ■ 4254 ■ Warp to the stone pillar ■
function OnEvent_4254(proxy,param)	
	
	if proxy:IsCompleteEvent( 4254 ) == true then
		return;
	end

	print("OnEvent_4254 begin");	
	
	proxy:RepeatMessage_begin();
		--▼4254_1▼選択メニューの監視▼ --EN:--▼4254_1▼Select menu monitoring▼
		proxy:OnSelectMenu(4254, "OnEvent_4254_0", 10010710, 0, 2, 1981, 2, once);			
	proxy:RepeatMessage_end();
	
	print("OnEvent_4254 end");
end

--▲4254_0▲選択メニューの監視▲ --EN:--▲4254_0▲Monitor selection menu▲
function OnEvent_4254_0(proxy, param)
	print("OnEvent_4254_0 begin");	
	
	if proxy:IsSession() == false then		
		proxy:PlayAnimation( 10000 , 8283 );--要石に触れるアニメを再生 --EN:--Play the animation that touches the keystone
		proxy:NoAnimeTurnCharactor( 10000 , 1981 ,TURNSKIP_ANGLE);
		
		proxy:NotNetMessage_begin();
			--▼要石に触れるアニメ再生終了▼ --EN:--▼Animation touching the keystone ends▼
			proxy:OnChrAnimEnd( 4254 , 10000 , 8283 , "OnEvent_4254_1" , once );
		proxy:NotNetMessage_end();
		
		proxy:SetEventFlag( 4254 , 1 );
	else
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010720, 0, 6, 1983, GEN_DIALOG_DIST, once );
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
	end
	
	print("OnEvent_4254_0 end");
end

--▲4254_1▲自世界に帰るアニメ再生終了▲ --EN:--▲4254_1▲Return to own world animation ends▲
function OnEvent_4254_1(proxy,param)	
	print("OnEvent_4254_1 begin");
	
	proxy:PlayAnimation( 10000 , 8284 );--自世界に帰るアニメを再生 --EN:--Play animation to return to your own world
	
	--石柱へ戻ってきた判定のフラグを立てる --EN:--Flag the judgment of returning to the stone pillar
	proxy:SetEventFlag(8083, true);
	
	proxy:SetEventFlag( 4254 , 0 );
	--完全回復要求 --EN:-- full recovery request
	proxy:RequestFullRecover();
	proxy:WarpNextStage( 1, 0, 0, 0, 1006 );
	
	print("OnEvent_4254_1 end");
end


--------------------------------------------------------------------------------------
--■4252■ソウル入手■ --EN:-- ■ 4252 ■ Get Soul ■
--------------------------------------------------------------------------------------

function OnEvent_4252(proxy, param)
	print("OnEvent_4252 begin");
	
	--プレイヤーの同期アニメーション(true:パーティープレイヤーがアニメーションした) --EN:--Player synchronous animation (true: party player animated)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_PICK ) == true then--新しいアニメ  --EN:-- new anime
		print("OnEvent_4252 end");
		return true;
	end
	
	proxy:NotNetMessage_begin();
		--0.0秒後にアイテム取得イベントを発行 --EN:-- Issue an item acquisition event after 0.0 seconds
		proxy:OnKeyTime2( 4252, "OnEvent_4252_1", 0.0, 0, 0, once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_4252 end");
end


--■4252_1■アイテム取得■ --EN:-- ■ 4252_1 ■ item acquisition ■
function OnEvent_4252_1(proxy, param)
	print("OnEvent_4252_1 begin");

	--アイテム取得関数--パラメータ10101参照 --EN:--item retrieval function--see parameter 10101
	proxy:GetRateItem(10111);
	proxy:GetRateItem(10174);	
	proxy:GetRateItem(10175);
	proxy:GetRateItem(10176);
	proxy:GetRateItem(10177);
	
	--アイテムを取得済み --EN:--item already acquired
	proxy:SetEventFlag( 4252, 1 );
	
	--宝箱シェーダーは消えません --EN:--Treasure chest shader does not disappear
	--proxy:TreasureDispModeChange( 1981 , false );

	--SFXが消える --EN:--SFX disappear
	--proxy:InvalidSfx( 1221 , true );--要石のオーラ --EN:--Keystone Aura
	proxy:InvalidSfx( 1220 , true );--光の粒子 --EN:--Particles of light
		
	--▼要石でワープ用の監視を追加▼ --EN:--▼ Added surveillance for warp with keystone ▼
	proxy:OnDistanceActionAttribute( 4254 , 10000 , 1981 , "OnEvent_4254" , WarpGimmickDist_A , HELPID_GO_TO_SEKITYUU , 0 , 180 , ATTR_NOSESSION , everytime );

		if proxy:IsClient() == false then
		local attr = ATTR_NOSESSION + ATTR_LIVE + ATTR_GREY;
		proxy:NotNetMessage_begin();
		--proxy:OnDistanceActionAttribute( 570 , 10000 , 1270 , "OnEvent_570" , DoorDist_A,HELPID_OPEN,180,DoorAngle_A,attr,everytime);
		proxy:OnRegionJustIn( 570 , 10000 , 2250 , "OnEvent_570" , everytime );
			
		proxy:LuaCall( 571 , REMO_START ,"OnEvent_571_RemoStart",once);
		proxy:LuaCall( 571 , REMO_FINISH,"OnEvent_571_RemoFinish",once);
		proxy:NotNetMessage_end();
	end
	
	print("OnEvent_4252_1 end");
end

--------------------------------------------------------------------------------------
--徘徊デーモンの登場■?? --EN:-- Appearance of the Wandering Demon ??
--------------------------------------------------------------------------------------

--▼グローバルの死亡監視から呼ばれる(ソロ) --EN:--▼ Called from global death watch (solo)
function PlayerDeath_m02_01_00_00(proxy, param)
	print("PlayerDeath_m02_01_00_00");	
	print("PlayerDeath_m02_01_00_00");
end

--▼グローバルの血文字復活から呼ばれる(ソロ) --EN:--▼Called from global blood letter revival (solo)
function PlayerRevive_m02_01_00_00(proxy,param)
	print("PlayerRevive_m02_01_00_00");
	print("PlayerRevive_m02_01_00_00");
end



--------------------------------------------------------------------------------------
--ボス部屋の中に入る■582 --EN:--Enter the boss room ■582
--------------------------------------------------------------------------------------

--■イベントがループなので、全部リピートにする↓ --EN:--■ Since the event is a loop, repeat all ↓

--■582■中ボス部屋への扉が開く■ --EN:-- ■ 582 ■ The door to the mid-boss room opens ■
function OnEvent_582(proxy,param)
	print("OnEvent_582 begin");
	
	if proxy:IsCompleteEvent( SYSTEM_ID_IGNORE ) == true then
		print("OnEvent_582 end");
		return;
	end
	
	--クライアントへ、ボス部屋阻止失敗を通知 --EN:--Notify client of failure to block boss room
	if proxy:IsClient() == false then
		proxy:LuaCallStart( 4068 , 1 );	
	end
	
	proxy:LuaCallStart( 583 , 1 );--旋回アニメの同期再生 --EN:-- Synchronous playback of turning animation
	--proxy:SetEventFlag( SYSTEM_ID_IGNORE, true );
	--多重起動システムIDをタイムアウトを設定してONにする --EN:--Turn on multiple activation system ID by setting timeout
	proxy:SetSystemIgnore( SYSTEM_ID_IGNORE , IGNORE_TIME );
	
	--プロファイルセーブ要求 --EN:--profile save request
	proxy:SaveRequest_Profile();
	
	print("OnEvent_582 end");
end


--旋回アニメの同期再生(IDが別) --EN:-- Synchronized playback of turning animation (ID is different)
function OnEvent_583_1(proxy,param)
	print("OnEvent_583_1 begin");

	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		if param:IsNetMessage() == true then
			--旋回アニメ再生を行い、その終了時にOnEvent_583_2を発行する --EN:--Play the turning animation and issue OnEvent_583_2 at the end
			proxy:TurnCharactor( 10001 + param:GetPlayID(), 2890 );
		else
			proxy:LockSession();--ルームをロックします！ --EN:--lock the room!
			--旋回アニメ再生を行い、その終了時にOnEvent_583_2を発行する --EN:--Play the turning animation and issue OnEvent_583_2 at the end
			proxy:OnTurnCharactorEnd( 583, 10000, 2890, "OnEvent_583_2", once );
		end
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	
	print("OnEvent_583_1 end");
end

--旋回アニメの同期再生終了後 --EN:--After synchronous playback of turning animation ends
function OnEvent_583_2(proxy,param)
	print("OnEvent_583_2 begin");
	
	--同期用歩きアニメ再生 --EN:--Play walking animation for synchronization
	proxy:LuaCallStart( 4012, 1 );
	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		proxy:OnChrAnimEnd( 583, 10000, ANIMEID_WALK, "OnEvent_583_3", once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	
	print("OnEvent_583_2 end");
end

--歩きアニメの同期再生終了後 --EN:--After the synchronized playback of the walking animation ends
function OnEvent_583_3(proxy,param)
	print("OnEvent_583_3 begin");
	
	--最初の人がボス部屋の中に入り終わっていたら、既に配信されているはずなので、もうおくらないハンドラ --EN:--If the first person has already entered the boss room, it should have already been delivered, so no more handlers
	if proxy:IsCompleteEvent( 582 ) == false then		
		Lua_MultiDoping(proxy,801);--マルチプレイドーピング		 --EN:-- Multiplayer Doping
		Lua_MultiDoping(proxy,120);--マルチプレイドーピング --EN:-- Multiplayer Doping
		Lua_MultiDoping(proxy,121);--マルチプレイドーピング --EN:-- Multiplayer Doping
		Lua_MultiDoping(proxy,122);--マルチプレイドーピング --EN:-- Multiplayer Doping
		Lua_MultiDoping(proxy,123);--マルチプレイドーピング --EN:-- Multiplayer Doping
		Lua_MultiDoping(proxy,124);--マルチプレイドーピング --EN:-- Multiplayer Doping
		Lua_MultiDoping(proxy,125);--マルチプレイドーピング --EN:-- Multiplayer Doping
		Lua_MultiDoping(proxy,126);--マルチプレイドーピング --EN:-- Multiplayer Doping
		Lua_MultiDoping(proxy,127);--マルチプレイドーピング --EN:-- Multiplayer Doping
		proxy:LuaCallStart( 583 , 5 );--2回目以降にボス部屋に入るためのイベント配信用 --EN:--For event delivery to enter the boss room after the second time
		proxy:LuaCallStart( 4045 , 1 );	--クライアントへ、ボス部屋に入れるようになったことを通知 --EN:--Notify clients that they can now enter the boss room
		proxy:LuaCallStart( 583 , 6 );--フラグセット(同期用) --EN:--flag set (for synchronization)

	end

	--プレイヤーが扉の中に完全にはいったタイミングで、ボスの思考をリセット --EN:--Reset the boss' thoughts when the player is completely inside the door
	--場所が悪いとプレイヤーを見つけれないため(攻撃してこない) --EN:--Because you can't find the player if the location is bad (they won't attack)
	if proxy:IsClient() == false then
		proxy:ResetThink( 801 );
	end
	
	proxy:SetEventFlag( SYSTEM_ID_IGNORE, false );

	print("OnEvent_583_3 end");
end


--■582 2回目以降にボス部屋に入るためのイベント配信用 --EN:--■ 582 For event delivery to enter the boss room after the second time
function OnEvent_582_GO_TO_IN(proxy, param)
	print("OnEvent_582_GO_TO_IN begin");	
		
	proxy:NotNetMessage_begin();
		--▼583▼扉が開いているときに中に入るためのイベントを追加▼--ハンドラは OnEvent_582 --EN:--▼583▼Add an event to enter when the door is open▼--The handler is OnEvent_582
		proxy:OnPlayerActionInRegion( 583, 2894, "OnEvent_582", HELPID_GO_TO_IN, everytime );--
	proxy:NotNetMessage_end();
	--王の盾戦闘準備	 --EN:--King's Shield Combat Ready
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 583 , "StandBy_KingOfShield",0.5,0,0,once);
	proxy:NotNetMessage_end();
	
	print("OnEvent_582_GO_TO_IN end");
end


--■582 フラグセット(同期用) --EN:-- 582 flag set (for synchronization)
function OnEvent_582_flag_set(proxy, param)
	print("OnEvent_582_flag_set begin");

	proxy:SetEventFlag( 582 , 1 );
	proxy:DeleteEvent( 582 );

	print("OnEvent_582_flag_set end");
end



--------------------------------------------------------------------------------------
--中ボスポリ劇再生■584 --EN:--Middle Bospoli drama playback 584
--------------------------------------------------------------------------------------

function OnEvent_584(proxy, param)
	print("OnEvent_584 begin");

	--ポリ劇再生開始 --EN:--Start playing polyplay
	proxy:RequestRemo(20100,REMO_FLAG,584,1);
	proxy:SetEventFlag( 584 , 1 );--ポリ劇再生終了 --EN:--End of polyplay play
	
	print("OnEvent_584 end");
end


--■584_RemoStart■ポリ劇開始 フェードアウト完了■ --EN:--■ 584_RemoStart ■ Poly drama start Fade out complete ■
function OnEvent_584_RemoStart(proxy,param)
	print( "OnEvent_584_RemoStart begin" );
	
	print("ポリ劇再生開始"); --EN:print("Start playing polyplay");
	proxy:SetDrawEnable( 801 , false );--王の盾 表示OFF --EN:--King's Shield Display OFF
	
	print( "OnEvent_584_RemoStart end" );
end


--■584_RemoFinish■ポリ劇再生終了後■ --EN:--■ 584_RemoFinish ■ After playing the polyplay ■
function OnEvent_584_RemoFinish(proxy , param)
	print( "OnEvent_584_RemoFinish begin" );

	print("ポリ劇終了"); --EN:print("End of polyplay");
	proxy:SetDrawEnable( 801 , true );--王の盾 表示ON	 --EN:--King's shield display ON

	print( "OnEvent_584_RemoFinish end" );
end


--------------------------------------------------------------------------------------
--ボスが動き出す(戦闘開始)■585 --EN:--Boss begins to move (battle starts) 585
--------------------------------------------------------------------------------------

function OnEvent_585(proxy, param)
	print("OnEvent_585 begin");	
	
	--ボス戦用BGM再生開始 --EN:--Start playing BGM for boss battle
	proxy:PlayPointSE( 2310, SOUND_TYPE_M, 20100000, 1 );
	
	--ボスロジックON --EN:--Boss logic ON
	proxy:EnableLogic( 801 , true );

	--フラグON --EN:--Flag ON
	proxy:SetEventFlag( 585 ,true );
	
	--ボスゲージ表示 --EN:-- Boss gauge display
	proxy:SetBossGauge( 801 , 0 ,5010 );
	
	print("OnEvent_585 end");
end



--------------------------------------------------------------------------------------
--■680■サブイベント扉■ --EN:-- ■ 680 ■ sub-event door ■
--------------------------------------------------------------------------------------

--■680_1■サブイベント扉■LuaCall定義 --EN:-- ■ 680_1 ■ Sub-event door ■ LuaCall definition
function OnEvent_680_1(proxy, param)
	print("OnEvent_680_1 begin");

	proxy:PlayAnimation( 1202, 1 );--扉が開くアニメーション --EN:-- Door opening animation
	
	--プレイヤーの同期アニメーション(true:パーティープレイヤーがアニメーションした) --EN:--Player synchronous animation (true: party player animated)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_OPEN ) == true then
		proxy:SetEventFlag( 680, 1 );
		proxy:DeleteEvent( 680 );
		print("OnEvent_680_1 end");
		return;
	end

	proxy:WarpDmy( 10000 , 1202 , 191 );
	proxy:SetEventFlag( 680, 1 );

	print("OnEvent_680_1 end");
end


--■680■サブイベント扉■ --EN:-- ■ 680 ■ sub-event door ■
function OnEvent_680(proxy, param)

	--多重発動防止 --EN:--Multiple activation prevention
	if proxy:IsCompleteEvent( 680 ) == true then
		return;
	end
	
	print("OnEvent_680 begin");
	
	--必要アイテムの指定 --EN:--Specify required items
	local KEY_ITEM_TYPE = TYPE_GOODS;
	local KEY_ITEM_ID   = 8;--牢獄の鍵 --EN:--Jail Key
	
	--必要アイテムを所持している(インベントリーにアイテムとして所持している) --EN:--You have the necessary items (have them as items in your inventory)
	if proxy:IsInventoryEquip( KEY_ITEM_TYPE , KEY_ITEM_ID ) == true then
	
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			--▼680_3▼選択メニューの監視▼ --EN:--▼680_3▼Monitor selection menu▼
			--proxy:OnSelectMenu(680, "OnEvent_680_3", 10010802, 0, 2, 1202, 2, once);
			proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010802, 0, 6, 1202, GEN_DIALOG_DIST, once );
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
		OnEvent_680_3(proxy,param);

	--必要アイテムを所持していない --EN:--I don't have the required items
	else
		--扉が開かない場合のメッセージを表示 --EN:-- Display a message when the door does not open
		--proxy:InfomationMenu( INFOMENU_TYPE_SIMPLE, 0, MSG_CATEGORY_EVENT, 10010160, 1);
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010160, 0, 6, 1202, GEN_DIALOG_DIST, once );
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
		--proxy:ShowGenDialog(10010160,1,1,true);
	end

	print("OnEvent_680 end");
end


--▲680_3▲選択メニューの監視▲(YESを選択したとき) --EN:--▲680_3▲Monitor selection menu▲(When YES is selected)
function OnEvent_680_3(proxy,param)
	print("OnEvent_680_3 begin");
	proxy:LuaCallStart( 680 , 1 );--アニメーションの同期再生(全体に配信) --EN:-- Synchronous animation playback (distributed to all)
	proxy:DeleteEvent( 680 );
	print("OnEvent_680_3 end");
end



--------------------------------------------------------------------------------------
--■682■サブイベント扉■ --EN:-- ■ 682 ■ sub-event door ■
--------------------------------------------------------------------------------------

--■682_1■サブイベント扉■LuaCall定義 --EN:-- ■ 682_1 ■ Sub-event door ■ LuaCall definition
function OnEvent_682_1(proxy, param)
	print("OnEvent_682_1 begin");	
	
	proxy:PlayAnimation( 1205, 1 );--扉が開くアニメーション --EN:-- Door opening animation
	
	--プレイヤーの同期アニメーション(true:パーティープレイヤーがアニメーションした) --EN:--Player synchronous animation (true: party player animated)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_OPEN ) == true then
		proxy:SetEventFlag( 682, 1 );
		proxy:DeleteEvent( 682 );
		print("OnEvent_682_1 end");
		return;
	end

	proxy:WarpDmy( 10000 , 1205 , 191 );
	proxy:SetEventFlag( 682, 1 );

	print("OnEvent_682_1 end");
end



--■682■サブイベント扉■ --EN:-- ■ 682 ■ sub-event door ■
function OnEvent_682(proxy, param)
	print("OnEvent_682 begin");

	--多重発動防止 --EN:--Multiple activation prevention
	if proxy:IsCompleteEvent( 682 ) == true then
		print("OnEvent_682 end");
		return;
	end
	
	--必要アイテムの指定 --EN:--Specify required items
	local KEY_ITEM_TYPE = TYPE_GOODS;
	local KEY_ITEM_ID   = 8;--牢獄の鍵 --EN:--Jail Key
	
	--必要アイテムを所持している(インベントリーにアイテムとして所持している) --EN:--You have the necessary items (have them as items in your inventory)
	if proxy:IsInventoryEquip( KEY_ITEM_TYPE , KEY_ITEM_ID ) == true then
	
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			--▼682_3▼選択メニューの監視▼ --EN:--▼682_3▼Select menu monitoring▼
			--proxy:OnSelectMenu(682, "OnEvent_682_3", 10010802, 0, 2, 1205, 2, once);
			proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010802, 0, 6, 1205, GEN_DIALOG_DIST, once );
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
		OnEvent_682_3(proxy,param);

	--必要アイテムを所持していない --EN:--I don't have the required items
	else
		--扉が開かない場合のメッセージを表示 --EN:-- Display a message when the door does not open
		--proxy:InfomationMenu( INFOMENU_TYPE_SIMPLE, 0, MSG_CATEGORY_EVENT, 10010160, 1);
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010160, 0, 6, 1205, GEN_DIALOG_DIST, once );
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
		--proxy:ShowGenDialog(10010160,1,1,true);
	end

	print("OnEvent_682 end");
end


--▲682_3▲選択メニューの監視▲(YESを選択したとき) --EN:--▲682_3▲Monitor selection menu▲(When YES is selected)
function OnEvent_682_3(proxy,param)
	print("OnEvent_682_3 begin");
	proxy:LuaCallStart( 682 , 1 );--アニメーションの同期再生(全体に配信)	 --EN:-- Synchronous animation playback (distributed to all)
	proxy:DeleteEvent( 682 );
	
	print("OnEvent_682_3 end");
end




--------------------------------------------------------------------------------------
--■684■サブイベント扉■ --EN:-- ■ 684 ■ sub-event door ■
--------------------------------------------------------------------------------------

--■684_1■サブイベント扉■LuaCall定義 --EN:-- ■ 684_1 ■ Sub-event door ■ LuaCall definition
function OnEvent_684_1(proxy, param)
	print("OnEvent_684_1 begin");
	
	--ビヨルングルムが囚われている牢屋の扉を開けたので･･･ --EN:--I opened the prison door where Bjrngurm was imprisoned...
	--ビヨの状態を「解放してくれて感謝」にする --EN:--Change Biyo's status to "thank you for releasing me"
	SetNpcStateFlag( proxy, param, biyo_flag_list, BIYO_STATE_THANKS );
	proxy:SetEventFlag( 520 , 1 );--アクションフラグも立てておく･･･。 --EN:--Set up an action flag...

	proxy:PlayAnimation( 1206, 1 );--扉が開くアニメーション --EN:-- Door opening animation
	
	--プレイヤーの同期アニメーション(true:パーティープレイヤーがアニメーションした) --EN:--Player synchronous animation (true: party player animated)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_OPEN ) == true then
		proxy:SetEventFlag( 684, 1 );
		proxy:DeleteEvent( 684 );
		print("OnEvent_684_1 end");
		return;
	end

	proxy:WarpDmy( 10000 , 1206 , 191 );
	proxy:SetEventFlag( 684, 1 );

	print("OnEvent_684_1 end");
end



--■684■サブイベント扉■ --EN:-- ■ 684 ■ sub-event door ■
function OnEvent_684(proxy, param)
	print("OnEvent_684 begin");

	--多重発動防止 --EN:--Multiple activation prevention
	if proxy:IsCompleteEvent( 684 ) == true then
		print("OnEvent_684 end");
		return;
	end
	
	--必要アイテムの指定 --EN:--Specify required items
	local KEY_ITEM_TYPE = TYPE_GOODS;
	local KEY_ITEM_ID   = 8;--牢獄の鍵 --EN:--Jail Key
	
	--必要アイテムを所持している(インベントリーにアイテムとして所持している) --EN:--You have the necessary items (have them as items in your inventory)
	if proxy:IsInventoryEquip( KEY_ITEM_TYPE , KEY_ITEM_ID ) == true then
	
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			--▼684_3▼選択メニューの監視▼ --EN:--▼684_3▼Select menu monitoring▼
			--proxy:OnSelectMenu(684, "OnEvent_684_3", 10010802, 0, 2, 1206, 2, once);
			proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010802, 0, 6, 1206, GEN_DIALOG_DIST, once );
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
		OnEvent_684_3(proxy,param);

	--必要アイテムを所持していない --EN:--I don't have the required items
	else
		--扉が開かない場合のメッセージを表示 --EN:-- Display a message when the door does not open
		--proxy:InfomationMenu( INFOMENU_TYPE_SIMPLE, 0, MSG_CATEGORY_EVENT, 10010160, 1);
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010160, 0, 6, 1206, GEN_DIALOG_DIST, once );
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
		--proxy:ShowGenDialog(10010160,1,1,true);
	end

	print("OnEvent_684 end");
end


--▲684_3▲選択メニューの監視▲(YESを選択したとき) --EN:--▲684_3▲Monitor selection menu▲(When YES is selected)
function OnEvent_684_3(proxy,param)
	print("OnEvent_684_3 begin");
	proxy:LuaCallStart( 684 , 1 );--アニメーションの同期再生(全体に配信)	 --EN:-- Synchronous animation playback (distributed to all)
	proxy:DeleteEvent( 684 );
	print("OnEvent_684_3 end");
end






--------------------------------------------------------------------------------------
--■686■サブイベント扉■ --EN:-- ■ 686 ■ sub-event door ■
--------------------------------------------------------------------------------------
--■686_1■サブイベント扉■LuaCall定義 --EN:-- ■ 686_1 ■ Sub-event door ■ LuaCall definition
function OnEvent_686_1(proxy, param)
	print("OnEvent_686_1 begin");

	proxy:PlayAnimation( 1203, 1 );--扉が開くアニメーション --EN:-- Door opening animation
	
	--プレイヤーの同期アニメーション(true:パーティープレイヤーがアニメーションした) --EN:--Player synchronous animation (true: party player animated)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_OPEN ) == true then
		proxy:SetEventFlag( 686, 1 );
		proxy:DeleteEvent( 686 );
		print("OnEvent_686_1 end");
		return;
	end

	proxy:WarpDmy( 10000 , 1203 , 191 );
	proxy:SetEventFlag( 686, 1 );

	print("OnEvent_686_1 end");
end

--■686■サブイベント扉■ --EN:-- ■ 686 ■ sub-event door ■
function OnEvent_686(proxy, param)
	print("OnEvent_686 begin");

	--多重発動防止 --EN:--Multiple activation prevention
	if proxy:IsCompleteEvent( 686 ) == true then
		print("OnEvent_686 end");
		return;
	end
	
	--必要アイテムの指定 --EN:--Specify required items
	local KEY_ITEM_TYPE = TYPE_GOODS;
	local KEY_ITEM_ID   = 8;--牢獄の鍵 --EN:--Jail Key
	
	--必要アイテムを所持している(インベントリーにアイテムとして所持している) --EN:--You have the necessary items (have them as items in your inventory)
	if proxy:IsInventoryEquip( KEY_ITEM_TYPE , KEY_ITEM_ID ) == true then
	
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			--▼686_3▼選択メニューの監視▼ --EN:--▼686_3▼Select menu monitoring▼
			--proxy:OnSelectMenu(686, "OnEvent_686_3", 10010802, 0, 2, 1206, 2, once);
			proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010802, 0, 6, 1203, GEN_DIALOG_DIST, once );
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
		OnEvent_686_3(proxy,param);

	--必要アイテムを所持していない --EN:--I don't have the required items
	else
		--扉が開かない場合のメッセージを表示 --EN:-- Display a message when the door does not open
		--proxy:InfomationMenu( INFOMENU_TYPE_SIMPLE, 0, MSG_CATEGORY_EVENT, 10010160, 1);
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010160, 0, 6, 1203, GEN_DIALOG_DIST, once );
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
		--proxy:ShowGenDialog(10010160,1,1,true);
	end

	print("OnEvent_686 end");
end


--▲686_3▲選択メニューの監視▲(YESを選択したとき) --EN:--▲686_3▲Monitor selection menu▲(When YES is selected)
function OnEvent_686_3(proxy,param)
	print("OnEvent_686_3 begin");
	proxy:LuaCallStart( 686 , 1 );--アニメーションの同期再生(全体に配信)	 --EN:-- Synchronous animation playback (distributed to all)
	proxy:DeleteEvent( 686 );
	print("OnEvent_686_3 end");
end

--------------------------------------------------------------------------------------
--■688■サブイベント扉■ --EN:-- ■ 688 ■ sub-event door ■
--------------------------------------------------------------------------------------
--■688_1■サブイベント扉■LuaCall定義 --EN:-- ■ 688_1 ■ Sub-event door ■ LuaCall definition
function OnEvent_688_1(proxy, param)
	print("OnEvent_688_1 begin");

	proxy:PlayAnimation( 1204, 1 );--扉が開くアニメーション --EN:-- Door opening animation
	
	--プレイヤーの同期アニメーション(true:パーティープレイヤーがアニメーションした) --EN:--Player synchronous animation (true: party player animated)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_OPEN ) == true then
		proxy:SetEventFlag( 688, 1 );
		proxy:DeleteEvent( 688 );
		print("OnEvent_688_1 end");
		return;
	end

	proxy:WarpDmy( 10000 , 1204 , 191 );
	proxy:SetEventFlag( 688, 1 );

	print("OnEvent_688_1 end");
end

--■688■サブイベント扉■ --EN:-- ■ 688 ■ sub-event door ■
function OnEvent_688(proxy, param)
	print("OnEvent_688 begin");

	--多重発動防止 --EN:--Multiple activation prevention
	if proxy:IsCompleteEvent( 688 ) == true then
		print("OnEvent_688 end");
		return;
	end
	
	--必要アイテムの指定 --EN:--Specify required items
	local KEY_ITEM_TYPE = TYPE_GOODS;
	local KEY_ITEM_ID   = 8;--牢獄の鍵 --EN:--Jail Key
	
	--必要アイテムを所持している(インベントリーにアイテムとして所持している) --EN:--You have the necessary items (have them as items in your inventory)
	if proxy:IsInventoryEquip( KEY_ITEM_TYPE , KEY_ITEM_ID ) == true then
	
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			--▼688_3▼選択メニューの監視▼ --EN:--▼688_3▼Select menu monitoring▼
			--proxy:OnSelectMenu(688, "OnEvent_688_3", 10010802, 0, 2, 1206, 2, once);
			proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010802, 0, 6, 1204, GEN_DIALOG_DIST, once );
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
		OnEvent_688_3(proxy,param);

	--必要アイテムを所持していない --EN:--I don't have the required items
	else
		--扉が開かない場合のメッセージを表示 --EN:-- Display a message when the door does not open
		--proxy:InfomationMenu( INFOMENU_TYPE_SIMPLE, 0, MSG_CATEGORY_EVENT, 10010160, 1);
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010160, 0, 6, 1204, GEN_DIALOG_DIST, once );
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
		--proxy:ShowGenDialog(10010160,1,1,true);
	end

	print("OnEvent_688 end");
end


--▲688_3▲選択メニューの監視▲(YESを選択したとき) --EN:--▲688_3▲Monitor selection menu▲(When YES is selected)
function OnEvent_688_3(proxy,param)
	print("OnEvent_688_3 begin");
	proxy:LuaCallStart( 688 , 1 );--アニメーションの同期再生(全体に配信)	 --EN:-- Synchronous animation playback (distributed to all)
	proxy:DeleteEvent( 688 );
	print("OnEvent_688_3 end");
end



--------------------------------------------------------------------------------------
--■560■獄吏の死亡監視■ --EN:-- ■ 560 ■ Jailer's Death Watch ■
--------------------------------------------------------------------------------------
function OnEvent_560(proxy,param)
	print("OnEvent_560 beign");
	
	proxy:SetEventFlag(560,true);--獄吏死亡フラグON(イベント) --EN:--Prisoner death flag ON (event)
	
	--ビヨルンイベントの判定をここに･･･。 --EN:--Here's the verdict for the Bjorn event...
	
	--現在の状態を取得 --EN:--get current state
	local now_state = GetNpcStateFlag( proxy, param, biyo_flag_list );
		--ビヨの状態を「逆襲に満足して寝る」にする --EN:--Set Biyo's state to "Sleeping satisfied with the counterattack"
	if	proxy:IsCompleteEvent(BIYO_STATE_TARGET_ENEMY) == true then
	
		--proxy:SetEventCommand( 622 , 60 );--EzStateに制御番号(寝る)を渡す --EN:-- Pass control number (sleep) to EzState
		
		SetNpcStateFlag( proxy, param, biyo_flag_list, BIYO_STATE_END_OF_STRIKES_BACK );
		
		--アクションフラグも立てておく･･･ --EN:--Also raise an action flag...
		proxy:SetEventFlag( 523 , 1 );
	end
	
	
	print("OnEvent_560 end");
end


--------------------------------------------------------------------------------------
--■560■獄吏の死体を調べた■ --EN:-- ■ 560 ■ inspected prisoner's corpse ■
--------------------------------------------------------------------------------------
function OnEvent_15622(proxy,param)
	print("OnEvent_15622 begin");
	proxy:SetEventFlag( 15622 , true );
	print("OnEvent_15622 end");
end

--------------------------------------------------------------------------------------
--■527■ビヨルングルムの死亡監視■ --EN:--■527■Bjrngrum Death Watch■
--------------------------------------------------------------------------------------
function OnEvent_527(proxy,param)
	print("OnEvent_527 beign");
	
	proxy:SetEventFlag(527,true);
		
	--ビヨの状態を「死亡」にする --EN:--Set Biyo's status to "dead"
	SetNpcStateFlag( proxy, param, biyo_flag_list, BIYO_STATE_DEAD );

	print("OnEvent_527 end");
end


--------------------------------------------------------------------------------------
--■643■レンドル王子呼びかけ範囲取得■ --EN:--■643■Prince Lendl calling range acquisition■
--------------------------------------------------------------------------------------
function OnEvent_643(proxy,param)
	print("OnEvent_643 beign");
	
	proxy:SetEventFlag( 643 , true );--フラグ立てるのみ(会話側で使う?) --EN:-- Flagging only (used on the conversation side?)

	print("OnEvent_643 end");
end

--呼びかけ範囲から出た --EN:-- out of calling range
function OnEvent_643_out(proxy,param)
	print("OnEvent_643_out begin");
	proxy:SetEventFlag( 643 , false );
	print("OnEvent_643_out end");
end
--[[
--------------------------------------------------------------------------------------
--■652■レンドル追っかけ兵士Aの死亡監視■ --EN:--■ 652 ■ Death Watch for Soldier A Pursuing Lendl ■
--------------------------------------------------------------------------------------
function OnEvent_652(proxy,param)
	print("OnEvent_652 beign");
	proxy:SetEventFlag(652,true);
	print("OnEvent_652 end");
end


--------------------------------------------------------------------------------------
--■654■レンドル追っかけ兵士Bの死亡監視■ --EN:--■ 654 ■ Death Watch for Rendor Chasing Soldier B ■
--------------------------------------------------------------------------------------
function OnEvent_654(proxy,param)
	print("OnEvent_654 beign");
	proxy:SetEventFlag(654,true);
	print("OnEvent_654 end");
end

]]


--[[------------------------------------------------------------------------------------
--■660■乞食ショップNPCの死亡監視■ --EN:--■ 660 ■ Beggar Shop NPC Death Watch ■
--------------------------------------------------------------------------------------
function OnEvent_660(proxy,param)
	print("OnEvent_660 beign");
	proxy:SetEventFlag(660,true);
	print("OnEvent_660 end");
end
]]


--------------------------------------------------------------------------------------
--■670■ホストPCのみが通れる光の霧■ --EN:-- ■ 670 ■ A fog of light that only the host PC can pass through ■
--------------------------------------------------------------------------------------

--■670_delete_wall■魔法壁削除同期用■ --EN:--■670_delete_wall■For synchronized magic wall deletion■
function OnEvent_670_delete_wall(proxy , param)
	print("OnEvent_670_delete_wall begin");
	
	proxy:SetDrawEnable( 1260 , false );--描画OFF --EN:--Drawing OFF
	proxy:SetColiEnable( 1260 , false );--当たりOFF --EN:--Hit OFF
	proxy:SetObjDeactivate( 1260 , true );--デアクティブ --EN:--deactivate
	proxy:DeleteEvent( 670 );
	proxy:InvalidSfx( 2230 , true );
	
	print("OnEvent_670_delete_wall end");
end


--■670■イベント発動用■ --EN:-- ■ 670 ■ For event activation ■
function OnEvent_670(proxy , param)
	print("OnEvent_670 begin");

	--多重発動防止 --EN:--Multiple activation prevention
	if proxy:IsCompleteEvent( 670 ) == true then
		print("OnEvent_670 end");
		return;
	end
	
	--プレイヤーの同期アニメーション(true:パーティープレイヤーがアニメーションした) --EN:--Player synchronous animation (true: party player animated)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_WALK ) == true then
		proxy:SetEventFlag( 670 , 1 );
		print("OnEvent_670 end");
		return;
	end
	
	--ダミポリへワープ --EN:--Warp to Damipoli
	proxy:WarpDmy( 10000 , 1260 , 191 );
	
	proxy:NotNetMessage_begin();
		--▼670_1▼歩きアニメ終了▼ --EN:--▼670_1▼End of walking animation▼
		--proxy:OnChrAnimEnd( 670 , 10000 , ANIMEID_WALK , "OnEvent_670_1" , once );
		proxy:LuaCallStart( 670 , 1 );--光の霧削除同期 --EN:--light fog removal sync
	proxy:NotNetMessage_end();
	
	proxy:SetEventFlag( 670 , 1 );
	
	--プロファイルセーブ要求 --EN:--profile save request
	proxy:SaveRequest_Profile();
	
	print("OnEvent_670 end");
end


--▲670_1▲歩きアニメ終了▲ --EN:--▲670_1▲End of walking animation▲
function OnEvent_670_1(proxy , param)
	print("OnEvent_670_1 begin");
	
	proxy:LuaCallStart( 670 , 1 );--光の霧削除同期 --EN:--light fog removal sync
	
	print("OnEvent_670_1 end");
end

--[[
--------------------------------------------------------------------------------------
--512■バリスタ開始イベント --EN:--512■ Barista start event
--------------------------------------------------------------------------------------
--バリスタイベント開始 --EN:--Start barista event
function OnEvent_512(proxy,param)

	if proxy:IsCompleteEvent(512) == true then
		return;
	end	
	if Luafunc_PlaySynchroAnimation(proxy,param,ANIMEID_BARISTA_GRASP) == true then
		proxy:SetEventFlag(512,true);
		return;
	end
	
	print("OnEvent_512 begin");		
	proxy:EnableLogic(10000,false);
	--プレイヤーをOBJ(1200)のダミポリ(191)位置へワープ --EN:--Warp player to OBJ(1200) Damipoly(191) position
	proxy:WarpDmy( 10000, 1200, 191 );--バリスタ操作オブジェ --EN:--Baristor operation object
	proxy:NotNetMessage_begin();
		proxy:OnChrAnimEnd(512,10000,ANIMEID_BARISTA_GRASP,"OnEvent_512_1",once);
	proxy:NotNetMessage_end();
	proxy:SetEventFlag(512,true);	
	print("OnEvent_512 end");
end

--プレイヤーアニメ終了後 --EN:--After player animation ends
function OnEvent_512_1(proxy,param)
	print("OnEvent_512_1 begin");
	proxy:LuaCallStart(512,2);
	print("OnEvent_512_1 end");
end

--ループアニメ開始 --EN:--Loop animation start
function OnEvent_512_2(proxy,param)
	print("OnEvent_512_2 begin");
	--パーティーのプレイヤーがアニメーション --EN:--Party players animated
	if param:IsNetMessage() == true then 
		--バリスタにオーナー登録 --EN:--Owner registration with Barista
		proxy:SetBallista(1207,param:GetPlayID()+10001);
		proxy:PlayLoopAnimation( param:GetPlayID()+10001 , ANIMEID_BARISTA_GRASP_KEEP );
		print("OnEvent_512_2 end");
		return;
	end
	--バリスタにオーナー登録 --EN:--Owner registration with Barista
	proxy:SetBallista(1207,10000);
	--自分がアニメーション --EN:--animated by me
	proxy:PlayLoopAnimation( 10000 ,  ANIMEID_BARISTA_GRASP_KEEP );
	proxy:OnBallista(513,1207,HELPID_REMOVE,-20,20,-200,30,3, 1.0, 1.0);--バリスタ本体オブジェ --EN:--Barista body object
--	proxy:OnBallista(513,1207,HELPID_REMOVE,-20,20,-200,30,3);--バリスタ本体オブジェ --EN:--Barista body object
	print("OnEvent_512_2 end");
end

--------------------------------------------------------------------------------------
--513■バリスタ同期■ --EN:--513 ■ barista synchronization ■
--------------------------------------------------------------------------------------
--0	…SEアニメ同期 --EN:--0 …SE animation synchronization
function OnEvent_513_0(proxy,param)	
	--発射アニメ中じゃなければ --EN:--If it's not during the launch animation
	if proxy:IsEventAnim(1207,1) == false then 
		proxy:PlayAnimation(1207,2);		
	end
	if param:IsNetMessage() == true then
		if proxy:IsEventAnim(10000,1) == false then 
			proxy:PlayLoopAnimation( param:GetPlayID()+10001 , ANIMEID_BARISTA_GRASP_KEEP );		
			return;
		end
	end
end

--1	…角度同期 --EN:--1 … angle synchronization
function OnEvent_513_1(proxy,param)
	--発動者はじぶんで回転させてるので、受信者のみ同期 --EN:--Since the invoker rotates himself, only the recipient is synchronized
	if param:IsNetMessage() == true then
		proxy:ObjRot(1207,param:GetPlayID()+10001,param:GetParam3());
	end
end

--2	…バリスタ発射同期 --EN:--2 … varistor firing synchronization
function OnEvent_513_2(proxy,param)
	print("OnEvent_513_2 begin");
	print("バリスタ発射アニメ再生"); --EN:print("Play ballista firing animation");
	--強制アニメ --EN:--forced animation
	proxy:ForcePlayAnimation(1207,1);
	print("OnEvent_513_2 end");
end

--3	…バリスタ終了同期 --EN:--3 … Varistor end synchronization
function OnEvent_513_3(proxy,param)
	print("OnEvent_513_3 begin");
	print("バリスタ終了");	 --EN:print("Balista finished");
	if param:IsNetMessage() == true then
		proxy:StopLoopAnimation(param:GetPlayID()+10001);
		proxy:PlayAnimation( param:GetPlayID()+10001 , ANIMEID_BARISTA_AWAY );
		print("OnEvent_513_3 end");		
		return;		
	end
	--プレイヤー離脱アニメ？ --EN:--Player withdrawal animation?
	proxy:StopLoopAnimation(10000);
	proxy:PlayAnimation(10000,ANIMEID_BARISTA_AWAY);
	proxy:EnableLogic(10000,true);
	
	proxy:NotNetMessage_begin();
		proxy:RepeatMessage_begin();
			proxy:OnChrAnimEnd(513,10000,ANIMEID_BARISTA_AWAY,"OnEvent_513_3_1",once);
		proxy:RepeatMessage_end();
	proxy:NotNetMessage_end();
	print("OnEvent_513_3 end");
end

--アニメ終了後のイベント --EN:--Events after the anime ends
function OnEvent_513_3_1(proxy,param)
	print("OnEvent_513_3_1 begin");
	print("発動者のみのイベント"); --EN:print("Triggerer-only event");
	--フラグ同期用のイベントを発行 --EN:-- Issue an event for flag synchronization
	proxy:LuaCallStart(513,5);	
	print("OnEvent_513_3_1 end");	
end

--4	…バリスタダメージ終了同期 --EN:--4 …Balista damage end synchronization
function OnEvent_513_4(proxy,param)
	print("OnEvent_513_4 begin");
	print("バリスタ終了");	 --EN:print("Balista finished");
	if param:IsNetMessage() == true then
		proxy:StopLoopAnimation(param:GetPlayID()+10001);		
		print("OnEvent_513_4 end");		
		return;		
	end
	proxy:StopLoopAnimation(10000);	
	proxy:EnableLogic(10000,true);
	
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2(513,"OnEvent_513_4_1",2,0,0,once);
	proxy:NotNetMessage_end();
	print("OnEvent_513_4 end");
end

--時間待ちのイベント --EN:--Time wait event
function OnEvent_513_4_1(proxy,param)
	print("OnEvent_513_4_1 begin");
	print("発動者のみのイベント"); --EN:print("Triggerer-only event");
	--フラグ同期用のイベントを発行 --EN:-- Issue an event for flag synchronization
	proxy:LuaCallStart(513,5);
	print("OnEvent_513_4_1 end");
end

--5	…バリスタフラグ同期用 --EN:--5 …For varistor flag synchronization
function OnEvent_513_5(proxy,param)
	print("OnEvent_513_5 begin");
	--バリスタオーナー解除 --EN:--Release barista owner
	proxy:SetBallista(1207,-1);
	proxy:SetEventFlag(512,false);
	print("OnEvent_513_5 end");	
end


]]



--------------------------------------------------------------------------------------
--■800■飛竜の眷属２が元気に飛び回る■ --EN:-- ■ 800 ■ Wyvern's kin 2 fly around energetically ■
--------------------------------------------------------------------------------------

--飛竜(眷属2)が再生するアニメID --EN:--Anime ID played by Hiryu (kin 2)
kenzoku_2_play_anime_id = 7006;--デフォルトでは、待機1 --EN:-- By default, wait 1

--■800■飛竜の眷属２が元気に飛び回る■ --EN:-- ■ 800 ■ Wyvern's kin 2 fly around energetically ■
function OnEvent_800(proxy, param)
	print("OnEvent_800 begin");

	--[[飛竜のHP監視に引っかかっていたら、死亡させる]] --EN:--[[If you get caught in the wyvern's HP monitoring, kill it]]
	if proxy:IsCompleteEvent( 806 ) == true then
		if	kenzoku_2_play_anime_id ~= 7030 then
			--▼806▼飛竜(眷属2)が死ぬ▼		 --EN:--▼806▼Hiryu (kin 2) dies▼
			kenzoku_2_play_anime_id = 7030;
			--→OnEvent_806_syncro_anime --EN:--→OnEvent_806_syncro_anime
			proxy:LuaCallStart( 806 , 1 );--死亡アニメの同期再生 --EN:-- Synchronous playback of death animations
			
			--飛竜関連のイベント監視削除 --EN:--Deletion of Hiryu-related event monitoring
			--proxy:DeleteEvent( 800 );--待機 --EN:--stand-by
			return;
		else
			--→OnEvent_800_3_syncro_anime --EN:--→OnEvent_800_3_syncro_anime
			proxy:LuaCallStart( 800 , 3 );--死亡アニメの同期再生 --EN:-- Synchronous playback of death animations
			return;
		end
	end
	
	--[[現在の状態取得]] --EN:--[[Get current state]]
	local now_state = GetNpcStateFlag( proxy, param, kenzoku_2_flag_list );
	
	--[[状態が、「警戒」]] --EN:--[[Status is "Warning"]]
	if now_state == KENZOKU_2_STATE_WARNING then
			
		--[[待機(通路)]] --EN:--[[Wait (passageway)]]
		if proxy:IsCompleteEvent( 830 ) == false and  --2320
		   proxy:IsCompleteEvent( 831 ) == false and  --2321
		   proxy:IsCompleteEvent( 832 ) == false then --2322
		   
			local rand = proxy:GetRandom( 1 , 3 );--1～2 --EN:ーー1～2
			
			if rand == 1 then
				print("待機1"); --EN:print("Wait 1");
				kenzoku_2_play_anime_id = 7006;--待機1のアニメID(次のアニメ判定用に保持) --EN:--Standby 1 animation ID (retained for next animation judgment)
				--→OnEvent_800_syncro_anime --EN:--→OnEvent_800_syncro_anime
				proxy:LuaCallStart( 800 , 1 );--待機1アニメの同期再生 --EN:--Synchronous playback of standby 1 animation
			elseif rand == 2 then
				print("待機2"); --EN:print("Wait 2");
				kenzoku_2_play_anime_id = 7010;--待機2のアニメID(次のアニメ判定用に保持) --EN:--Standby 2 animation ID (retained for next animation judgment)
				--→OnEvent_800_2_syncro_anime --EN:--→OnEvent_800_2_syncro_anime
				proxy:LuaCallStart( 800 , 2 );--待機2アニメの同期再生 --EN:--Synchronous playback of standby 2 animations
			end
		
		--[[領域Aブレス]] --EN:--[[Area A Breath]]
		elseif
		   proxy:IsCompleteEvent( 830 ) == true and   --2320
		   proxy:IsCompleteEvent( 831 ) == false and  --2321
		   proxy:IsCompleteEvent( 832 ) == false then --2322
			
			print("領域Aブレス"); --EN:print("area A breath");
			kenzoku_2_play_anime_id = 7007;--[[ブレスAのアニメID]] --EN:--[[Anime ID of Breath A]]
			--→OnEvent_801_syncro_anime --EN:--→OnEvent_801_syncro_anime
			proxy:LuaCallStart( 801 , 1 );--ブレスAアニメの同期再生 --EN:-- Synchronous playback of Breath A animation
		
		--[[領域Bブレス]] --EN:--[[area B breath]]
		elseif
		   proxy:IsCompleteEvent( 831 ) == true and   --2321
		   proxy:IsCompleteEvent( 832 ) == false then --2322
			
			print("領域Bブレス"); --EN:print("area B breath");
		    kenzoku_2_play_anime_id = 7008;--[[ブレスBのアニメID]] --EN:--[[Anime ID of Breath B]]
			--→OnEvent_802_syncro_anime --EN:--→OnEvent_802_syncro_anime
			proxy:LuaCallStart( 802 , 1 );--ブレスBアニメの同期再生 --EN:-- Synchronous playback of Breath B animation

		--[[領域Cブレス]] --EN:--[[area C breath]]
		elseif
		   proxy:IsCompleteEvent( 832 ) == true then --2322
		
			print("領域Cブレス"); --EN:print("area C breath");
			kenzoku_2_play_anime_id = 7009;--[[ブレスCのアニメID]] --EN:--[[Anime ID of Breath C]]
			--→OnEvent_803_syncro_anime --EN:--→OnEvent_803_syncro_anime
			proxy:LuaCallStart( 803 , 1 );--ブレスCアニメの同期再生 --EN:-- Synchronous playback of Breath C animation
		end
		
	--[[状態が、「ヘロヘロ」]] --EN:--[[Status is "Herohero"]]
	elseif now_state == KENZOKU_2_STATE_HEROHERO then
		
		print("へろへろ") --EN:print("HeroHero")
		kenzoku_2_play_anime_id = 7020;
			--→OnEvent_804_syncro_anime --EN:--→OnEvent_804_syncro_anime
		proxy:LuaCallStart( 804 , 1 );
	end	
	
	print("OnEvent_800 end");
end



--▲800_anime_end▲状態に対応するアニメを再生終了▲ --EN:--▲800_anime_end▲Ends playing the animation corresponding to the state▲
function OnEvent_800_anime_end(proxy, param)
	print("OnEvent_800_anime_end begin");
	
	--そのままループするアニメ --EN:--Animation that loops as it is
	
	if kenzoku_2_play_anime_id == 7006 or   --待機1 --EN:--Wait 1
	   kenzoku_2_play_anime_id == 7010 or   --待機2 --EN:--Wait 2
	   kenzoku_2_play_anime_id == 7007 or   --ブレスA --EN:--Breath A
	   kenzoku_2_play_anime_id == 7008 or   --ブレスB --EN:--Breath B
	   kenzoku_2_play_anime_id == 7009 or   --ブレスC --EN:--Breath C
	   kenzoku_2_play_anime_id == 7020 or	--ヘロヘロ --EN:--hero hero
	   kenzoku_2_play_anime_id == 7030 then --死亡 --EN:--death
	   
		proxy:NotNetMessage_begin();
			--▼飛竜の眷属２が元気に飛び回る▼ --EN:--▼ Hiryu no Kami 2 flies energetically ▼
			proxy:OnKeyTime2( 800 , "OnEvent_800" , 0.0 , 0 , 1 , once );
		proxy:NotNetMessage_end();
	
	--終了後なにもしないアニメ --EN:--An animation that does nothing after the end
	
	--elseif kenzoku_2_play_anime_id == 7030 then --死亡 --EN:--death

	end
	
	print("OnEvent_800_anime_end end");
end





--------------------------------------------------------------------------------------
--■800～804,806■飛竜の同期アニメ再生■ --EN:--■800～804,806■Synchronized animation playback of wyvern■
--------------------------------------------------------------------------------------

--■待機1 --EN:-- ■ Wait 1
--LuaCallParam(800,1)
function OnEvent_800_syncro_anime(proxy, param)
	print("OnEvent_800_syncro_anime begin");
	
	proxy:Warp( 110 , 2330 );--位置を合わせるための領域にワープ --EN:--Warp to area to align
	proxy:ForcePlayAnimationStayCancel( 110 , 7006 );--待機アニメ再生 --EN:--Play standby animation
	
	--発動者(＝ホスト)のみアニメ終了を監視 --EN:-- Only the invoker (= host) monitors the end of the animation
	if	param:IsNetMessage() == false then
	
		proxy:NotNetMessage_begin();
			--▼800▼状態に対応するアニメを再生終了▼ --EN:--▼ End playing animation corresponding to 800 ▼ state ▼
			proxy:OnChrAnimEnd( 800 , 110 , 7006 , "OnEvent_800_anime_end" , once );
		proxy:NotNetMessage_end();	
	end
		
	print("OnEvent_800_syncro_anime end");
end


--■待機2 --EN:-- ■ Wait 2
--LuaCallParam(800,2)
function OnEvent_800_2_syncro_anime(proxy, param)
	print("OnEvent_800_2_syncro_anime begin");
	
	proxy:Warp( 110 , 2330 );--位置を合わせるための領域にワープ --EN:--Warp to area to align
	proxy:ForcePlayAnimationStayCancel( 110 , 7010 );--待機アニメ再生 --EN:--Play standby animation
	
	--発動者(＝ホスト)のみアニメ終了を監視 --EN:-- Only the invoker (= host) monitors the end of the animation
	if	param:IsNetMessage() == false then
	
		proxy:NotNetMessage_begin();
			--▼800▼状態に対応するアニメを再生終了▼ --EN:--▼ End playing animation corresponding to 800 ▼ state ▼
			proxy:OnChrAnimEnd( 800 , 110 , 7010 , "OnEvent_800_anime_end" , once );
		proxy:NotNetMessage_end();	
	end
		
	print("OnEvent_800_2_syncro_anime end");
end

--■死亡待機 --EN:-- ■ Wait for death
function OnEvent_800_3_syncro_anime(proxy,param)
	print("OnEvent_800_3_syncro_anime begin");
	
	proxy:DeleteEvent( 801 );--ブレスA --EN:--Breath A
	proxy:DeleteEvent( 802 );--ブレスB --EN:--Breath B
	proxy:DeleteEvent( 803 );--ブレスC --EN:--Breath C
	proxy:DeleteEvent( 804 );--ヘロヘロ --EN:--hero hero
	proxy:DeleteEvent( 805 );--ヘロヘロ移行 --EN:--Helohero transition
	
	proxy:SetDeadMode( 110 , false );--死亡有効 --EN:--Death Enabled
	proxy:SetHp( 110, 0.0 );
	--ホストのみアイテム入手 --EN:--Only the host can obtain items
	if	proxy:IsClient() == false then
		proxy:GetRateItem(10118);--アイテム入手 --EN:-- Get items
	end
	
	print("飛竜(眷属2)死亡");		 --EN:print("Flying dragon (kin 2) died");
	--飛竜(眷属2)の状態フラグを「死亡」にする --EN:--Set the status flag of Hiryu (Familiar 2) to "dead"
	
	SetNpcStateFlag(proxy, param, kenzoku_2_flag_list, KENZOKU_2_STATE_DEAD );
	SetNpcStateFlag( proxy, param, kenzoku_flag_list, KENZOKU_STATE_DEAD );
	
	--無効化を遅らせる --EN:--delay invalidation
	InvalidCharactor( proxy, 110 );
	
	print("OnEvent_800_3_syncro_anime end");
end



--■ブレスA --EN:--■ Breath A
--LuaCallParam(801,1)
function OnEvent_801_syncro_anime(proxy, param)
	print("OnEvent_801_syncro_anime begin");
	
	proxy:Warp( 110 , 2330 );--位置を合わせるための領域にワープ --EN:--Warp to area to align
	proxy:ForcePlayAnimationStayCancel( 110 , 7007 );--ブレスAアニメ再生 --EN:--Breath A animation playback
	
	--発動者(＝ホスト)のみアニメ終了を監視 --EN:-- Only the invoker (= host) monitors the end of the animation
	if	param:IsNetMessage() == false then
	
		proxy:NotNetMessage_begin();
			--▼800▼状態に対応するアニメを再生終了▼ --EN:--▼ End playing animation corresponding to 800 ▼ state ▼
			proxy:OnChrAnimEnd( 800 , 110 , 7007 , "OnEvent_800_anime_end" , once );
		proxy:NotNetMessage_end();	
	end
		
	print("OnEvent_801_syncro_anime end");
end



--■ブレスB --EN:--■ Breath B
--LuaCallParam(802,1)
function OnEvent_802_syncro_anime(proxy, param)
	print("OnEvent_802_syncro_anime begin");
	
	proxy:Warp( 110 , 2330 );--位置を合わせるための領域にワープ --EN:--Warp to area to align
	proxy:ForcePlayAnimationStayCancel( 110 , 7008 );--ブレスBアニメ再生 --EN:--Breath B animation playback
	
	--発動者(＝ホスト)のみアニメ終了を監視 --EN:-- Only the invoker (= host) monitors the end of the animation
	if	param:IsNetMessage() == false then
	
		proxy:NotNetMessage_begin();
			--▼800▼状態に対応するアニメを再生終了▼ --EN:--▼ End playing animation corresponding to 800 ▼ state ▼
			proxy:OnChrAnimEnd( 800 , 110 , 7008 , "OnEvent_800_anime_end" , once );
		proxy:NotNetMessage_end();	
	end
		
	print("OnEvent_800_syncro_anime end");
end




--■ブレスC --EN:-- Breath C
--LuaCallParam(803,1)
function OnEvent_803_syncro_anime(proxy, param)
	print("OnEvent_803_syncro_anime begin");
	
	proxy:Warp( 110 , 2330 );--位置を合わせるための領域にワープ --EN:--Warp to area to align
	proxy:ForcePlayAnimationStayCancel( 110 , 7009 );--ブレスCアニメ再生 --EN:--Breath C animation playback
	
	--発動者(＝ホスト)のみアニメ終了を監視 --EN:-- Only the invoker (= host) monitors the end of the animation
	if	param:IsNetMessage() == false then
	
		proxy:NotNetMessage_begin();
			--▼800▼状態に対応するアニメを再生終了▼ --EN:--▼ End playing animation corresponding to 800 ▼ state ▼
			proxy:OnChrAnimEnd( 800 , 110 , 7009 , "OnEvent_800_anime_end" , once );
		proxy:NotNetMessage_end();	
	end
		
	print("OnEvent_803_syncro_anime end");
end



--■ヘロヘロ --EN:-- HERO HERO
--LuaCallParam(804,1)
function OnEvent_804_syncro_anime(proxy, param)
	print("OnEvent_804_syncro_anime begin");
	
	proxy:Warp( 110 , 2330 );--位置を合わせるための領域にワープ --EN:--Warp to area to align
	proxy:ForcePlayAnimationStayCancel( 110 , 7020 );--ヘロヘロアニメ再生 --EN:--Herohero anime playback
	
	--発動者(＝ホスト)のみアニメ終了を監視 --EN:-- Only the invoker (= host) monitors the end of the animation
	if	param:IsNetMessage() == false then
	
		proxy:NotNetMessage_begin();
			--▼800▼状態に対応するアニメを再生終了▼ --EN:--▼ End playing animation corresponding to 800 ▼ state ▼
			proxy:OnChrAnimEnd( 800 , 110 , 7020 , "OnEvent_800_anime_end" , once );
		proxy:NotNetMessage_end();	
	end
		
	print("OnEvent_804_syncro_anime end");
end



--■死亡 --EN:-- Death
--LuaCallParam(806,1)
function OnEvent_806_syncro_anime(proxy, param)
	print("OnEvent_806_syncro_anime begin");
	
	
	proxy:Warp( 110 , 2330 );--位置を合わせるための領域にワープ --EN:--Warp to area to align
	proxy:ForcePlayAnimation( 110 , 7030 );--死亡アニメ再生 --EN:--play death animation
	
	
	--飛竜(眷属2)の状態フラグを「死亡」にする --EN:--Set the status flag of Hiryu (Familiar 2) to "dead"
	SetNpcStateFlag(proxy, param, kenzoku_2_flag_list, KENZOKU_2_STATE_DEAD );
	SetNpcStateFlag( proxy, param, kenzoku_flag_list, KENZOKU_STATE_DEAD );
	
	--発動者(＝ホスト)のみアニメ終了を監視 --EN:-- Only the invoker (= host) monitors the end of the animation
	if	param:IsNetMessage() == false then
	
		proxy:NotNetMessage_begin();
			--▼800▼状態に対応するアニメを再生終了▼ --EN:--▼ End playing animation corresponding to 800 ▼ state ▼
			proxy:OnChrAnimEnd( 800 , 110 , 7030 , "OnEvent_800_anime_end" , once );
		proxy:NotNetMessage_end();	
	end
	
	print("OnEvent_806_syncro_anime end");
end


--[[
--------------------------------------------------------------------------------------
--■805■飛竜の眷属２がヘロヘロになる■ --EN:-- ■ 805 ■ Hiryu's kin 2 becomes hero hero ■
--------------------------------------------------------------------------------------

--■805■飛竜の眷属２がヘロヘロになる■ --EN:-- ■ 805 ■ Hiryu's kin 2 becomes hero hero ■
function OnEvent_805(proxy, param)
	print("OnEvent_805 begin");

	--飛竜(眷属2)の状態をヘロヘロにする --EN:--Increase the status of Hiryu (Family 2)
	SetNpcStateFlag(proxy, param, kenzoku_2_flag_list , KENZOKU_2_STATE_HEROHERO);
	
	--リピートなので、フラグ立てない --EN:--Since it is a repeat, it is not flagged
	
	print("OnEvent_805 end");
end
]]

--------------------------------------------------------------------------------------
--■806■飛竜の眷属２が死ぬ■ --EN:-- ■ 806 ■ Hiryu's family 2 dies ■
--------------------------------------------------------------------------------------

--■806■飛竜の眷属２が死ぬ■ --EN:-- ■ 806 ■ Hiryu's family 2 dies ■
function OnEvent_806(proxy, param)
	print("OnEvent_806 begin");

	proxy:SetEventFlag( 806 , 1 );--HP監視フラグON --EN:--HP monitor flag ON
	
	print("OnEvent_806 end");
end



--------------------------------------------------------------------------------------
--■521■ビヨが獄吏を倒しに行く■(会話システムから呼び出し) --EN:--■521■Biyo goes to defeat the jailer■(call from conversation system)
--------------------------------------------------------------------------------------

--■521■ビヨが獄吏を倒しに行く■(会話システムから呼び出し) --EN:--■521■Biyo goes to defeat the jailer■(call from conversation system)
function OnEvent_521(proxy, param)
	print("OnEvent_521 begin");
	
	--獄吏が死んでいたら処理抜け --EN:--If the jailer is dead, skip processing
	if proxy:IsCompleteEvent( 560 ) == true then
		print("OnEvent_521 end");
		return;
	end
	
	proxy:EnableLogic( 622 , true );--ビヨロジックON --EN:--Beyologic ON
	proxy:SetEventCommand( 622 , 51 );--EzStateに制御番号(立ち上がる)を渡す --EN:-- Pass control number (stand up) to EzState
	proxy:SetTeamType( 622 , TEAM_TYPE_BattleFriend );	
		
	proxy:ForceChangeTarget( 622 , 115 );--ビヨのターゲットを獄吏に指定 --EN:--Specify Biyo's target as prison guard
	
	--ビヨの状態を「獄吏を倒したい」にする --EN:--Set Biyo's state to "I want to defeat the jailer"
	SetNpcStateFlag( proxy, param, biyo_flag_list, BIYO_STATE_TARGET_ENEMY );
	
	proxy:SetEventFlag( 521 , 1 );
	
	print("OnEvent_521 end");
end




--------------------------------------------------------------------------------------
--■522■ビヨが牢内で寝る■(会話システムから呼び出し) --EN:--■522■Byo sleeps in prison■ (call from conversation system)
--------------------------------------------------------------------------------------

--■522■ビヨが牢内で寝る■(会話システムから呼び出し) --EN:--■522■Byo sleeps in prison■ (call from conversation system)
function OnEvent_522(proxy, param)
	print("OnEvent_522 begin");
	
	--獄吏が生きていたら処理抜け --EN:--If the jailer is alive, skip processing
	if proxy:IsCompleteEvent( 560 ) == false then
		print("OnEvent_522 end");
		return;
	end
	
	proxy:EnableLogic( 622 , false );--ビヨロジックOFF --EN:--Beyologic OFF
	proxy:SetEventCommand( 622 , 60 );--EzStateに制御番号(寝る)を渡す --EN:-- Pass control number (sleep) to EzState
	proxy:SetTeamType( 622 , TEAM_TYPE_Friend );	
		
	--ビヨの状態を「牢内で寝ている」にする --EN:--Change Biyo's state to "sleeping in prison"
	SetNpcStateFlag( proxy, param, biyo_flag_list, BIYO_STATE_SLEEPING_IN_PRISON );
	
	proxy:SetEventFlag( 522 , 1 );
	
	print("OnEvent_522 end");
end


--[[
--------------------------------------------------------------------------------------
--■524■ビヨが次のブロックへ移動■ --EN:--■524■Byo moves to the next block■
--------------------------------------------------------------------------------------

function Check_OnEvent_524(proxy, param)

	--生存プレイヤー(グレイ)のみ判定 --EN:-- Only surviving players (gray) are judged
	if proxy:IsLivePlayer() == false and
	   proxy:IsGreyGhost()  == false then
		return false;
	end
	
	--現在の状態取得 --EN:-- Get current status
	local now_state = GetNpcStateFlag( proxy, param, biyo_flag_list );
	
	--「牢屋で寝ている」でも、「逆襲に満足して寝る」でもないとき、処理抜け --EN:-- When neither "sleeping in prison" nor "sleeping satisfied with counterattack", processing skipped
	if now_state ~= BIYO_STATE_SLEEPING_IN_PRISON and
	   now_state ~= BIYO_STATE_END_OF_STRIKES_BACK then
		return false;
	end
	
	--獄吏が生きていたら処理抜け --EN:--If the jailer is alive, skip processing
	if proxy:IsCompleteEvent( 560 ) == false then
		return false;
	end
	
	--距離判定 --EN:--distance judgment
	if proxy:IsDistance( 10000 , 622 , 20 ) == true then
		return false;
	else
		print("ビヨルングルム、次ブロックへ移動"); --EN:print("Bjrn Grum, move to next block");
		return true;
	end
	
	return false;
end


--■524■ビヨが次のブロックへ移動■ --EN:--■524■Byo moves to the next block■
function OnEvent_524(proxy, param)
	print("OnEvent_524 begin");
	
	InvalidCharactor( proxy , 622 );--ビヨ無効化 --EN:--Disable Byo

	--ビヨの状態を「王城3を探索」にする --EN:--Set Biyo's status to "Exploring the Royal Castle 3"
	SetNpcStateFlag( proxy, param, biyo_flag_list, BIYO_STATE_SEARCH_3 );

	proxy:SetEventFlag( 524 , 1 );
	
	print("OnEvent_524 end");
end
]]


--------------------------------------------------------------------------------------
--■525■ビヨが牢内で敵になる■ --EN:-- ■ 525 ■ Biyo becomes an enemy in prison ■
--------------------------------------------------------------------------------------

--■525■ビヨが牢内で敵になる■ --EN:-- ■ 525 ■ Biyo becomes an enemy in prison ■
function OnEvent_525(proxy, param)
	print("OnEvent_525 begin");
	
	if	proxy:IsCompleteEvent( BIYO_STATE_CAPTIVE ) == true or
		proxy:IsCompleteEvent( BIYO_STATE_THANKS ) == true or
		proxy:IsCompleteEvent( BIYO_STATE_SLEEPING_IN_PRISON ) == true then
		
		SetNpcStateFlag( proxy, param, biyo_flag_list, BIYO_STATE_HOSTILE_IN_PRISON );
		
		proxy:SetEventCommand( 622 , 51 );--EzStateに制御番号(立ち上がる)を渡す --EN:-- Pass control number (stand up) to EzState
		proxy:NotNetMessage_begin();
			proxy:OnKeyTime2( 525 , "OnEvent_525_1",1.0,1,100 , once );
		proxy:NotNetMessage_end();
		proxy:EnableLogic( 622 , true );--[[ビヨロジックON( ロジック切り替え？ )]]	 --EN:--[[Byo logic ON (change logic?)]]
		proxy:SetEventFlag( 525 , 1 );
		proxy:EraseEventSpecialEffect_2(622,5064);
		proxy:SetTeamType(622, TEAM_TYPE_AngryFriend);--チームタイプ変更 --EN:--Change team type
	end
	
	print("OnEvent_525 end");
end

function OnEvent_525_1(proxy,param)
	proxy:SetEventCommand( 622 , 51 );--EzStateに制御番号(立ち上がる)を渡す --EN:-- Pass control number (stand up) to EzState
end

--------------------------------------------------------------------------------------
--■526■ビヨが城壁で敵になる■ --EN:-- ■ 526 ■ Biyo becomes an enemy at the castle wall ■
--------------------------------------------------------------------------------------

--■526■ビヨが牢内で敵になる■ --EN:-- ■ 526 ■ Biyo becomes an enemy in prison ■
function OnEvent_526(proxy, param)
	print("OnEvent_526 begin");
	
	--「獄吏を倒したい」でも「逆襲に満足して寝る」でもないとき、処理抜け --EN:--When neither "I want to defeat the jailer" nor "I'm satisfied with the counterattack and go to sleep", the process is skipped.
	if	proxy:IsCompleteEvent( BIYO_STATE_TARGET_ENEMY ) 		== true or
		proxy:IsCompleteEvent( BIYO_STATE_END_OF_STRIKES_BACK ) == true then
		
		proxy:EnableLogic( 622 , true );--[[ビヨロジックON( ロジック切り替え？ )]] --EN:--[[Byo logic ON (change logic?)]]
		proxy:SetEventCommand( 622 , 51 );--EzStateに制御番号(立ち上がる)を渡す --EN:-- Pass control number (stand up) to EzState
		
		proxy:NotNetMessage_begin();
			proxy:OnKeyTime2( 525 , "OnEvent_525_1",1.0,1,100 , once );
		proxy:NotNetMessage_end();
		--ビヨの状態を「敵対(城壁)」にする --EN:--Change Biyo's status to "hostile (castle wall)"
		SetNpcStateFlag( proxy, param, biyo_flag_list, BIYO_STATE_HOSTILE_IN_RAMPART );
		
		proxy:EraseEventSpecialEffect_2(622,5064);
		proxy:SetTeamType(622, TEAM_TYPE_AngryFriend);--チームタイプ変更 --EN:--Change team type
		proxy:SetEventFlag( 526 , true );
	end
	
	print("OnEvent_526 end");
end

--------------------------------------------------------------------------------------
--■530■ビヨが逆襲に満足して寝る■ --EN:--■530■Byo sleeps satisfied with the counterattack■
--------------------------------------------------------------------------------------
--■530■ビヨが逆襲に満足して寝る■ --EN:--■530■Byo sleeps satisfied with the counterattack■
function OnEvent_530(proxy,param)
	print("OnEvent_530 begin");
	proxy:DisableInterupt( 622 , true );
	MoveRegion(proxy, 622, 2240, -1 ,0.0,true);
	proxy:NotNetMessage_begin();
		proxy:OnRegionIn( 530 , 622 , 2240 , "OnEvent_530_1",once); 	
	proxy:NotNetMessage_end();
	print("OnEvent_530 end");
end

function OnEvent_530_1(proxy,param)
	print("OnEvent_530_1 begin");
	proxy:DisableInterupt( 622 , false );
	proxy:EnableLogic( 622, false );--ビヨロジックOFF --EN:--Beyologic OFF
	proxy:SetEventCommand( 622 , 60 );--EzStateに制御番号(寝る)を渡す --EN:-- Pass control number (sleep) to EzState
	proxy:SetTeamType( 622 , TEAM_TYPE_Friend );
	proxy:SetEventFlag( 530, true );	
	proxy:SetEventFlag( 531, true );
	print("OnEvent_530_1 end");
end

--------------------------------------------------------------------------------------
--■720■王子が感謝する■ --EN:-- ■ 720 ■ The prince appreciates ■
--------------------------------------------------------------------------------------
--[[
function Check_OnEvent_720(proxy, param)

	--現在の状態を取得 --EN:--get current state
	local now_state = GetRendolState(proxy, param);

	--状態が「隠れているので助けて」でない場合は処理抜け --EN:--If the state is not "Help me because I am hiding", the process is omitted
	if now_state ~= RENDOL_STATE_HELP_HIDING_ME then
		return false;
	end
	
	--レンドル王子追っかけ兵士を全部倒したら感謝へ --EN:--Thank you for defeating all the soldiers chasing Prince Lendl
	if proxy:IsCompleteEvent( 652 ) == true and
	   proxy:IsCompleteEvent( 654 ) == true then
	   print("レンドル王子追っかけ兵士を全て倒しました"); --EN:print("I killed all the soldiers chasing Prince Lendl");
	   return true;
	end
	
	return false;
end
]]

--■720■王子が感謝する■ --EN:-- ■ 720 ■ The prince appreciates ■
function OnEvent_720(proxy, param)
	print("OnEvent_720 begin");
	
	proxy:SetEventFlag( param:GetParam1(), true );
	
	--生きていれば終了 --EN:--End if alive
	if	proxy:IsCompleteEvent( 652 ) == false or
		proxy:IsCompleteEvent( 654 ) == false or
		proxy:IsCompleteEvent( 655 ) == false or
		proxy:IsCompleteEvent( 656 ) == false or
		proxy:IsCompleteEvent( 657 ) == false or
		proxy:IsCompleteEvent( 658 ) == false then
		print("OnEvent_720 is No Success");
		print("OnEvent_720 end");
		return;
	end
	
	
	--王子の状態を「感謝(王城2)」に変更を試みる --EN:--Attempt to change the prince's status to ``thank you (royal castle 2)''
	if proxy:IsCompleteEvent( RENDOL_STATE_HELP_HIDING_ME ) == true then
		SetNpcStateFlag( proxy, param, rendol_flag_list, RENDOL_STATE_THANKS_2 );
		RendolCheck(proxy,param);--王城１スクリプト参照 --EN:--Refer to Ojo 1 script
	
		--proxy:SetEventCommand( 620 , 41 );--EzStateに制御番号(怯え終了)を渡す。 --EN:-- Pass the control number (terrified end) to EzState.
		proxy:SetSpStayAndDamageAnimId( 620, -1,-1);		
	end
--[[	
		--▼10800▼王子が探索を開始するイベント用監視を追加▼ --EN:--▼10800▼ Added monitoring for the event when the prince starts exploring▼
		if proxy:IsCompleteEvent( 10800 ) == false then
			proxy:NotNetMessage_begin();
				proxy:LuaCall( 10800 , 0 , "OnEvent_10800" , once );--会話システムから呼ぶ場合にはparam=0 --EN:--param=0 when calling from the conversation system
			proxy:NotNetMessage_end();
	end
]]	
	proxy:DeleteEvent( 720 );--監視削除 --EN:--Delete monitor
	proxy:SetEventFlag( 720 , 1 );
	
	print("OnEvent_720 end");
end


--------------------------------------------------------------------------------------
--■10800■王子が探索を開始する■(会話システムから呼び出し) --EN:-- ■ 10800 ■ The prince starts searching ■ (call from the conversation system)
--------------------------------------------------------------------------------------

--■10800■王子が探索を開始する■ --EN:-- ■ 10800 ■ Prince begins exploration ■
function OnEvent_10800(proxy, param)
	print("OnEvent_10800 begin");
	if	proxy:IsCompleteEvent( 10800 ) == true then
		return;
	end
	
	--アイテム取得関数 --EN:--Item acquisition function
	proxy:GetRateItem(10192);
	
	--アイテムを取得済み --EN:--item already acquired
	proxy:SetEventFlag( 10800, 1 );
	
	--王城2で探索に 状態遷移を試みる --EN:-- Attempt a state transition for exploration in the royal castle 2

	--目の前で消えるのを回避する為、RendolCheckをしない --EN:--Don't do RendolCheck to avoid disappearing in front of your eyes
	SetNpcStateFlag( proxy, param, rendol_flag_list, RENDOL_STATE_SEARCH_2 );	
	--	proxy:EnableLogic( 620 , true );--レンドル王子、探索状態で歩き出す --EN:--Prince Lendl starts walking in exploration mode
	--
	
	--移動タイプを往復に変更 --EN:--Movement type changed to round trip
	proxy:SetEventMovePointType( 620, POINT_MOVE_TYPE_RoundTrip );
	
	--移動ポイントを変更 --EN:--Change movement point
	local point_list = {2220, 2221, 2222, 2223};
	local point_num = table.getn( point_list );
	for index = 1, point_num, 1 do
		--移動ポイントを設定 --EN:--set movement point
		proxy:AddCustomRoutePoint(620, point_list[index]);
	end
	
	proxy:ResetThink( 620 );
	
	print("OnEvent_10800 end");
end




--------------------------------------------------------------------------------------
--■722■王子が次のブロックに移動する■ --EN:-- ■ 722 ■ The prince moves to the next block ■
--------------------------------------------------------------------------------------
--[[
function Check_OnEvent_722(proxy, param)

	--現在の状態を取得 --EN:--get current state
	local now_state = GetRendolState(proxy, param);

	--状態が「王城2を探索」でない場合は処理抜け --EN:--If the status is not "Explore the Royal Castle 2", skip processing
	if now_state ~= RENDOL_STATE_SEARCH_2 then
		return false;
	end
	
	--距離判定 --EN:--distance judgment
	if proxy:IsDistance( 10000 , 620 , 20 ) == true then
		return false;
	else
		print("レンドル王子、次ブロックへ移動"); --EN:print("Prince Lendl, move to next block");
		return true;
	end
	
	return false;
end


--■722■王子が次のブロックに移動する■ --EN:-- ■ 722 ■ The prince moves to the next block ■
function OnEvent_722(proxy, param)
	print("OnEvent_722 begin");
	
	--王城3で「見えない場所にこっそり」に 状態遷移を試みる --EN:--Attempt to ``sneak into an invisible place'' in Royal Castle 3
	SetNpcStateFlag( proxy, param, rendol_flag_list, RENDOL_STATE_LOCATION_INVISIBLE );

	InvalidCharactor( proxy , 620 );--レンドル王子無効化 --EN:--Disable Prince Lendl
	
	proxy:SetEventFlag( 722 , 1 );
	proxy:DeleteEvent( 722 );--監視削除 --EN:--Delete monitor
	
	print("OnEvent_722 end");
end

]]

--------------------------------------------------------------------------------------
--■723■王子が敵対する■ --EN:-- ■ 723 ■ The prince is hostile ■
--------------------------------------------------------------------------------------

--■723■王子が敵対する■ --EN:-- ■ 723 ■ The prince is hostile ■
function OnEvent_723(proxy, param)
	print("OnEvent_723 begin");
	
	--王城2で敵対に状態遷移を試みる --EN:--Attempt to make a hostile state transition in Ojo 2
	SetNpcStateFlag( proxy, param, rendol_flag_list, RENDOL_STATE_HOSTILE_2 );
	RendolCheck(proxy,param);
	
	proxy:SetEventFlag( 723 , true );
	
	print("OnEvent_723 end");
end


--------------------------------------------------------------------------------------
--■724■王子が死ぬ■ --EN:-- ■ 724 ■ Prince dies ■
--------------------------------------------------------------------------------------

--■724■王子が死ぬ■ --EN:-- ■ 724 ■ Prince dies ■
function OnEvent_724(proxy, param)
	print("OnEvent_724 begin");

	SetNpcStateFlag( proxy, param, rendol_flag_list, RENDOL_STATE_DEAD );
	RendolCheck(proxy,param);
	--死亡でRendolCheckする場合、その瞬間に消えてしまうので、 --EN:--If you perform RendolCheck on death, it will disappear at that moment, so
	--距離を見て再度有効にするか決める --EN:--Look at the distance and decide whether to re-enable
	if	proxy:IsDistance( LOCAL_PLAYER, 620, 20 ) == true then
		ValidCharactor( proxy, 620 );
	end
		print("レンドル王子が死亡しました。"); --EN:print("Prince Lendl has died.");

	proxy:SetEventFlag( 724 , 1 );
	
	print("OnEvent_724 end");
end

--------------------------------------------------------------------------------------
--■760■奴隷兵士の敵対化■ --EN:-- ■ 760 ■ Enmity of Slave Soldiers ■
--------------------------------------------------------------------------------------

--■760■奴隷兵士の敵対化■ --EN:-- ■ 760 ■ Enmity of Slave Soldiers ■
function OnEvent_760(proxy, param)
	print("OnEvent_760 begin");
	
	--現在の状態を取得 --EN:--get current state
	local now_state = GetNpcStateFlag(proxy, param, DOREISOL_SHOP_Flag_list);

	--状態が「販売中」でなかったら処理抜け --EN:--If the status is not "for sale", skip processing
	if now_state ~= DOREISOL_SHOP_SELL02 then
		return;
	end
	
	--奴隷兵士の状態を「敵対(王城2)」にする --EN:--Set the status of the slave soldier to "hostile (royal castle 2)"
	SetNpcStateFlag( proxy, param, DOREISOL_SHOP_Flag_list, DOREISOL_SHOP_HOSTILE02 );
	--奴隷兵士のチームタイプを変更する --EN:--Change slave soldier team type
	proxy:SetTeamType( 623, TEAM_TYPE_AngryFriend );
	
	proxy:EnableLogic( 623 , true );--[[ロジックON(ロジック切り替え?)]] --EN:--[[Logic ON (Logic switching?)]]
	print("奴隷兵士が敵になりました");--↑失敗していたらならないけれど･･･。 --EN:print("Slave soldiers became enemies");--I wish I had failed...
	
	proxy:SetEventFlag( 760 , 1 );
	
	print("OnEvent_760 end");
end


--------------------------------------------------------------------------------------
--■761■奴隷兵士の死亡■ --EN:-- ■ 761 ■ slave soldier's death ■
--------------------------------------------------------------------------------------

--■761■奴隷兵士の死亡■ --EN:-- ■ 761 ■ slave soldier's death ■
function OnEvent_761(proxy, param)
	print("OnEvent_761 begin");

	--奴隷兵士の状態を「死亡」にする --EN:--Set slave soldier status to "dead"
	SetNpcStateFlag( proxy, param, DOREISOL_SHOP_Flag_list, DOREISOL_SHOP_DEAD );
	print("奴隷兵士が死にました");--↑失敗していたらならないけれど･･･。	 --EN:print("The slave soldier died");--I wish I had failed...

	--敵に削られて敵対を通り越して死亡もありえるので、ここでも削除 --EN:--Because it is possible to die by being scraped by the enemy and passing through the hostility, it is also deleted here
	--死んだら敵対にはならないので削除 --EN:--Deleted because it won't be hostile if you die
	proxy:DeleteEvent( 760 );

	proxy:SetEventFlag( 761 , 1 );
	
	print("OnEvent_761 end");
end




--------------------------------------------------------------------------------------
--■550■ボスカメラ切り替えイベント■ --EN:-- ■ 550 ■ Boss camera switching event ■
--------------------------------------------------------------------------------------
function OnEvent_550(proxy,param)
	--print("OnEvent_550 begin");
	--ボスが死んでいない　かつ　ボスとの戦闘を開始している --EN:-- Boss is not dead and has started a battle with the boss
	if proxy:IsCompleteEvent( 4224 ) == false and proxy:IsCompleteEvent( 585 ) == true then
		--ボス戦　非ロックカメラ --EN:-- Boss battle unlocked camera
		proxy:SetCamModeParamTargetId(2021);
		--ボス戦　ロックカメラ --EN:--Boss battle rock camera
		proxy:SetCamModeParamTargetIdForBossLock(2020);
	end
	--print("OnEvent_550 end");
end


--------------------------------------------------------------------------------------
--カラスが飛び立つ --EN:--Crows take flight
--------------------------------------------------------------------------------------
function FryAwayKarasu(proxy,param, KarasuEventID, karasuID, KarasuAnimID)	
	print("FryAwayKarasu_"..karasuID.." begin");

	proxy:PlayAnimation( karasuID, KarasuAnimID );

	proxy:NotNetMessage_begin();
		--▼カラスアニメ再生終了▼ --EN:--▼End of crow animation▼
		proxy:OnObjAnimEnd( KarasuEventID , karasuID , KarasuAnimID , "OnEvent_"..KarasuEventID.."_1" , once );	
	proxy:NotNetMessage_end();

	proxy:SetEventFlag( KarasuEventID , 1 );

	print("FryAwayKarasu_"..karasuID.." end");
end

-----------------------------------------
--カラスアニメ再生終了したので消していく --EN:--Since the crow animation has finished playing, I will delete it.
-----------------------------------------
function OnEvent_850_1(proxy,param)	proxy:SetDrawEnable( 1230 , false ); print("KarasuFryAway ID=1230"); end
function OnEvent_851_1(proxy,param)	proxy:SetDrawEnable( 1231 , false ); print("KarasuFryAway ID=1231"); end
function OnEvent_852_1(proxy,param)	proxy:SetDrawEnable( 1232 , false ); print("KarasuFryAway ID=1232"); end
function OnEvent_853_1(proxy,param)	proxy:SetDrawEnable( 1233 , false ); print("KarasuFryAway ID=1233"); end
function OnEvent_854_1(proxy,param)	proxy:SetDrawEnable( 1234 , false ); print("KarasuFryAway ID=1234"); end
function OnEvent_855_1(proxy,param)	proxy:SetDrawEnable( 1235 , false ); print("KarasuFryAway ID=1235"); end
function OnEvent_856_1(proxy,param)	proxy:SetDrawEnable( 1236 , false ); print("KarasuFryAway ID=1236"); end
function OnEvent_857_1(proxy,param)	proxy:SetDrawEnable( 1237 , false ); print("KarasuFryAway ID=1237"); end
function OnEvent_858_1(proxy,param)	proxy:SetDrawEnable( 1238 , false ); print("KarasuFryAway ID=1238"); end
function OnEvent_859_1(proxy,param)	proxy:SetDrawEnable( 1239 , false ); print("KarasuFryAway ID=1239"); end
function OnEvent_860_1(proxy,param)	proxy:SetDrawEnable( 1240 , false ); print("KarasuFryAway ID=1240"); end
function OnEvent_861_1(proxy,param)	proxy:SetDrawEnable( 1241 , false ); print("KarasuFryAway ID=1241"); end
function OnEvent_862_1(proxy,param)	proxy:SetDrawEnable( 1242 , false ); print("KarasuFryAway ID=1242"); end
function OnEvent_863_1(proxy,param)	proxy:SetDrawEnable( 1243 , false ); print("KarasuFryAway ID=1243"); end
function OnEvent_864_1(proxy,param)	proxy:SetDrawEnable( 1244 , false ); print("KarasuFryAway ID=1244"); end
function OnEvent_865_1(proxy,param)	proxy:SetDrawEnable( 1245 , false ); print("KarasuFryAway ID=1245"); end
function OnEvent_866_1(proxy,param)	proxy:SetDrawEnable( 1246 , false ); print("KarasuFryAway ID=1246"); end
function OnEvent_867_1(proxy,param)	proxy:SetDrawEnable( 1247 , false ); print("KarasuFryAway ID=1247"); end
function OnEvent_868_1(proxy,param)	proxy:SetDrawEnable( 1248 , false ); print("KarasuFryAway ID=1248"); end
function OnEvent_869_1(proxy,param)	proxy:SetDrawEnable( 1249 , false ); print("KarasuFryAway ID=1249"); end
function OnEvent_870_1(proxy,param)	proxy:SetDrawEnable( 1250 , false ); print("KarasuFryAway ID=1250"); end

---------------------------------
--カラスが飛び立つ関数を呼び出す --EN:--Call the function where the crow flies away
---------------------------------
function OnEvent_850(proxy, param) FryAwayKarasu(proxy, param, 850, 1230, 12); end
function OnEvent_851(proxy, param) FryAwayKarasu(proxy, param, 851, 1231, 12); end
function OnEvent_852(proxy, param) FryAwayKarasu(proxy, param, 852, 1232, 12); end
function OnEvent_853(proxy, param) FryAwayKarasu(proxy, param, 853, 1233, 12); end
function OnEvent_854(proxy, param) FryAwayKarasu(proxy, param, 854, 1234, 12); end
function OnEvent_855(proxy, param) FryAwayKarasu(proxy, param, 855, 1235, 12); end
function OnEvent_856(proxy, param) FryAwayKarasu(proxy, param, 856, 1236, 12); end
function OnEvent_857(proxy, param) FryAwayKarasu(proxy, param, 857, 1237, 12); end
function OnEvent_858(proxy, param) FryAwayKarasu(proxy, param, 858, 1238, 12); end
function OnEvent_859(proxy, param) FryAwayKarasu(proxy, param, 859, 1239, 12); end
function OnEvent_860(proxy, param) FryAwayKarasu(proxy, param, 860, 1240, 12); end
function OnEvent_861(proxy, param) FryAwayKarasu(proxy, param, 861, 1241, 12); end
function OnEvent_862(proxy, param) FryAwayKarasu(proxy, param, 862, 1242, 12); end
function OnEvent_863(proxy, param) FryAwayKarasu(proxy, param, 863, 1243, 12); end
function OnEvent_864(proxy, param) FryAwayKarasu(proxy, param, 864, 1244, 12); end
function OnEvent_865(proxy, param) FryAwayKarasu(proxy, param, 865, 1245, 11); end
function OnEvent_866(proxy, param) FryAwayKarasu(proxy, param, 866, 1246, 10); end
function OnEvent_867(proxy, param) FryAwayKarasu(proxy, param, 867, 1247, 11); end
function OnEvent_868(proxy, param) FryAwayKarasu(proxy, param, 868, 1248, 10); end
function OnEvent_869(proxy, param) FryAwayKarasu(proxy, param, 869, 1249, 11); end
function OnEvent_870(proxy, param) FryAwayKarasu(proxy, param, 870, 1250, 10); end


--------------------------------------------------------------------------------------
--■610■QWC:ソウルモンスター出現１■ --EN:-- ■ 610 ■ QWC: Soul monster appearance 1 ■
--------------------------------------------------------------------------------------
function OnEvent_610(proxy,param)
	print("OnEvent_610 begin");
	
	--ソウルモンスターを表示させる --EN:--Display soul monsters
	ValidCharactor( proxy, 150 );
	ValidCharactor( proxy, 151 );
	
	--ソウルモンスターの出現アニメの再生 --EN:-- Playing the soul monster appearance animation
	proxy:PlayAnimation( 150, 6100 );
	proxy:PlayAnimation( 151, 6100 );
	
	--フラグON --EN:--Flag ON
	proxy:SetEventFlag( 610, true )

	print("OnEvent_610 end");
end



--------------------------------------------------------------------------------------
--■570■封印城門開放？■ --EN:--■570■Seal gate open? ■
--------------------------------------------------------------------------------------
function OnEvent_570(proxy,param)
	print("OnEvent_570 begin");
	if proxy:IsCompleteEvent( 8035 ) == false then
		--表示「強力なソウルの力で封印されいる」 --EN:-- Display "sealed by the power of a powerful soul"
		--proxy:InfomationMenu( INFOMENU_TYPE_SIMPLE, 0, MSG_CATEGORY_EVENT, 10010195, 1);
		--proxy:ShowGenDialog(10010195,1,1,true);
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			proxy:RequestOpenBriefingMsg(10010195,true);
			proxy:OnRegionJustOut( 570 , 10000 , 2251, "OnEvent_570_out",once);
			--proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010195, 0, 6, 1270, 10, once );
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
	else
		--王都の門開放ポリ劇 --EN:--Royal Capital Gate Opening Police Drama
		proxy:RequestRemo( 20101 ,REMO_FLAG , 571 ,1);
		proxy:SetEventFlag( 571,true );
	end
	print("OnEvent_570 end");
end

--領域から出た --EN:-- out of the realm
function OnEvent_570_out(proxy,param)
	print("OnEvent_570_out begin");
	proxy:CroseBriefingMsg();
	print("OnEvent_570_out end");
end

--ポリ劇開始フォードアウト後 --EN:--After starting the police play ford out
function OnEvent_571_RemoStart(proxy,param)
	print("OnEvent_571_RemoStart begin");
	proxy:DeleteEvent( 570 );
	proxy:InvalidSfx( 2210 , true);
	print("OnEvent_571_RemoStart end");
end

--ポリ劇終了フェードイン前 --EN:--Before the end of the poly drama fade-in
function OnEvent_571_RemoFinish(proxy,param)
	print("OnEvent_571_RemoFinish begin");
	OnEvent_781(proxy,param);
	proxy:EndAnimation(1270,2);
	print("OnEvent_571_RemoFinish end");
end


-----------------------------------------------------------------------------
--■590■結晶トカゲイベント2 --EN:-- ■ 590 ■ Crystal Lizard Event 2
-----------------------------------------------------------------------------
function OnEvent_590(proxy,param)
	print("OnEvent_590 begin");
	proxy:SetEventFlag( 590, true);
	proxy:DeleteEvent( 590 );
	print("OnEvent_590 end");
end

-----------------------------------------------------------------------------
--■592■結晶トカゲイベント3 --EN:-- ■ 592 ■ Crystal Lizard Event 3
-----------------------------------------------------------------------------
function OnEvent_592(proxy,param)
	print("OnEvent_592 begin");
	proxy:SetEventFlag( 592, true);
	proxy:DeleteEvent( 592 );
	print("OnEvent_592 end");
end
