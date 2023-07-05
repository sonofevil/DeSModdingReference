
--エイの突撃イベント発動の残HP割合 --EN:--Remaining HP ratio of Ray's assault event activation
StormOfBeast_HpRate = 0.5;

--子エイの死んだ数 --EN:--number of dead ray pups
BeastChildDeadCount = 12;

--------------------------------------------------------------------------------------
--マップ読み込み時に読まれる初期化処理■ --EN:--Initialization process read when reading the map ■
--------------------------------------------------------------------------------------
function Initialize_m03_03_00_00(proxy)
	print("Initialize_m03_03_00_00 begin");

--■1541■エリアボスのポリ劇再生■ --EN:--■ 1541 ■ Area Boss's polyplay ■
	--ボスが生きている時だけイベント登録 --EN:-- Event registration only when the boss is alive
	if proxy:IsCompleteEvent( 4992 ) == false then
		--死亡時にももう一度再生したい為。 --EN:--Because I want to regenerate again when I die.
		SingleReset( proxy,1541);
		SingleReset( proxy,5085);
		if proxy:IsCompleteEvent( 1541 ) == false then 	
			--▼ボス前のポリ劇再生用監視追加 --EN:--▼ Added surveillance for polyplay playback in front of the boss
			proxy:OnRegionJustIn( 1541 , 10000 , 2896 , "OnEvent_1541" , once );		
			proxy:NotNetMessage_begin();
				--ポリ劇開始に呼ばれるハンドラ --EN:--handler called at polyplay start
				proxy:LuaCall(1541, REMO_START, "OnEvent_1541_RemoStart", once);
				--ポリ劇終了後に呼ばれるハンドラ(トリガー起こした人用) --EN:--Handler called after the end of the polyplay (for the person who caused the trigger)
				proxy:LuaCall(1541, REMO_FINISH, "OnEvent_1541_RemoFinish", once);
			proxy:NotNetMessage_end();	
		else
			--終わっている状態で入ってきた人にはもう一度 --EN:--For those who came in after finishing,
			BossInit_StormOfBeast(proxy,param);
		end
	end


--■1542■ボス部屋に入る■	 --EN:-- ■ 1542 ■ Enter the boss room ■
	--中ボスが生きているときだけイベント登録 --EN:-- Event registration only when the mid-boss is alive
	if proxy:IsCompleteEvent( 4992 ) == false then
	
		--ソロのときは一度目にボス部屋に入る用のイベントを毎回登録させたいので、対応するフラグをOFFにする。 --EN:-- When soloing, we want to register the event for entering the boss room for the first time every time, so turn off the corresponding flag.
		SingleReset(proxy, 1542);
		--▽同期アニメ再生用の開始ハンドラ(旋回→歩き) --EN:--▽ Start handler for synchronous animation playback (turning → walking)
		proxy:LuaCall( 1543, 1, "OnEvent_1542_1", everytime );		
		--▽2回目以降にボス部屋に入るためのイベント配信用 --EN:--▽For event delivery to enter the boss room after the second time
		proxy:LuaCall( 1543 , 5 , "OnEvent_1542_GO_TO_IN" , everytime );		
		--▽フラグセット(同期用) --EN:--▽flag set (for synchronization)
		proxy:LuaCall( 1543 , 6 , "OnEvent_1542_flag_set" , everytime );		
		--誰かがボス前扉をまだ通過していない --EN:--Someone hasn't passed through the boss front door yet
		if proxy:IsCompleteEvent( 1542 ) == false then		
			--(セッション中に)ボス前の魔法壁を最初に通れるのは生存の人だけ --EN:--(During the session) Only survivors can pass through the magic wall in front of the boss first
			local possible_chr_type = ATTR_HOST + ATTR_LIVE + ATTR_GREY;
			proxy:NotNetMessage_begin();
				--▼1542▼扉が開いているときに中に入るためのイベントを追加▼ --EN:--▼1542▼Add an event to enter when the door is open▼
				proxy:OnPlayerActionInRegionAttribute( 1542, 2892, "OnEvent_1542", HELPID_GO_TO_IN, possible_chr_type, everytime );
			proxy:NotNetMessage_end();
			
		else --グレイゴーストできたときようにいると思われる。 --EN:--Gray ghost seems to be like that when it's done.
			proxy:NotNetMessage_begin();
				--▼1543▼扉が開いているときに中に入るためのイベントを追加▼ --EN:--▼1543▼Add an event to enter when the door is open▼
				proxy:OnPlayerActionInRegion( 1543, 2892, "OnEvent_1542", HELPID_GO_TO_IN, everytime );--ハンドラは上と同じ --EN:--handler is the same as above
			proxy:NotNetMessage_end();
		end
	end
	
--■4999■ボス戦闘開始■	 --EN:-- ■ 4999 ■ Boss battle begins ■
	if proxy:IsCompleteEvent( 4992 ) == false then
		proxy:OnRegionIn( 4999 , 10000 , 2884 , "OnEvent_4999" , everytime );
	end	
	
--■4992■エリアボス死亡■ --EN:-- ■ 4992 ■ Area Boss Death ■
	proxy:AddFieldInsFilter( 822 );
	if proxy:IsCompleteEvent( 4992 ) == false then
		proxy:OnCharacterDead(4992,822,"OnEvent_4992",once);
	end
		
--[[
--■5000・5001■ボス体当たりポリ劇■ --EN:--■ 5000・5001 ■ Poly play per boss ■
	--ボスを倒してない and 指定ポリ劇をみていない --EN:--I haven't beaten the boss and I haven't watched the specified polyplay
	SingleReset( proxy,5001 );	
	if proxy:IsCompleteEvent( 4992 ) == false and proxy:IsCompleteEvent( 5001 ) == false then
		local eneID = 400;
		local num = 12;
		
		for eneID = 400 , 411 , 1 do
			--子エイの死亡監視 --EN:--Father ray mortality monitoring
			print("add ",eneID);
			proxy:OnCharacterDead( 5000, eneID ,"OnEvent_5000_"..eneID,once);
		end
		--エイのHp監視		 --EN:--Hp monitor of stingray
		proxy:OnCharacterHP( 5000, 822, "OnEvent_5000_HP",StormOfBeast_HpRate,once );
		
		--ポリ劇起動用 --EN:--For starting polyplay
		proxy:NotNetMessage_begin();
			--キック --EN:--kick
			proxy:LuaCall(5001,1,"OnEvent_5001",once);
			--フェードアウト時 --EN:-- When fading out
			proxy:LuaCall(5001,REMO_START,"OnEvent_5001_RemoStart",once);
			--フェードイン時 --EN:--Fade in
			proxy:LuaCall(5001,REMO_FINISH,"OnEvent_5001_RemoFinish",once);
		proxy:NotNetMessage_end();
	end
	]]
--■??■徘徊デーモンの登場■ハンドラ登録 --EN:--■??■Appearance of wandering daemon■Handler registration
	proxy:NotNetMessage_begin();
		--プレイヤーがソロで死亡した時にキックされます。 --EN:--Kicked when a player dies solo.
		proxy:LuaCall( 4000, 100, "PlayerDeath_m03_03_00_00", everytime );
		--プレイヤーが復活した時にキックされます。 --EN:--Kicked when the player is revived.
		proxy:LuaCall( 4032, 100, "PlayerRevive_m03_03_00_00", everytime );
	proxy:NotNetMessage_end();

	
	--■ボス関連の初期化処理 --EN:--■ Boss-related initialization processing
	if proxy:IsCompleteEvent( 4992 ) ==true then
		
		--▽ボス死んでいるとき --EN:--▽When the boss is dead
		--ボスいなくなる --EN:--boss disappears
		InvalidBackRead( proxy , 822 );
		--初期化で消したフラグを立てる --EN:--Set the flag that was deleted by initialization
		proxy:SetEventFlag( 4991, true );
		
		--子エイも表示しない --EN:-- Don't show baby rays
		--[[
		local eneID = 400;		
		for eneID=400,411,1 do		
			InvalidCharactor( proxy, eneID);
		end
		]]
		--ジェネレータ止める --EN:-- stop the generator
		proxy:EnableGeneratorSystem( 2605 , false );
		
		--魔法壁消える --EN:--Magic wall disappears
		proxy:SetColiEnable( 1996 , false );			
		proxy:SetDrawEnable( 1996 , false );
		
		--SFX消去 --EN:--Erase SFX
		proxy:InvalidSfx(1988,false);	

		--ホストプレイヤーのみアイテム入手イベントに使用 --EN:--Used for item acquisition event only for host players
		local possible_chr_type = ATTR_HOST + ATTR_LIVE + ATTR_GREY;

		--宝死体(ソウル?)有効化 --EN:--Treasure corpse (soul?) activation
		proxy:SetDrawEnable( 1979 , true );
		proxy:SetColiEnable( 1979 , true );
		--宝死体(ソウル?)2有効化 --EN:--Treasure corpse (soul?) 2 enabled
		proxy:SetDrawEnable( 1978 , true );
		proxy:SetColiEnable( 1978 , true );
		
		proxy:TreasureDispModeChange2( 1979 , true ,KANAME_SFX);--光らせる --EN:-- let it shine
		--▼(ソウル)アイテム取得用イベント監視追加▼ --EN:--▼ (Soul) Added event monitoring for item acquisition▼
		if proxy:IsCompleteEvent( 4996 ) == false then
			proxy:ValidSfx( 2601 );--SFX 有効化 --EN:--SFX enable
			proxy:ValidSfx( 2600 );--SFX 有効化			 --EN:--SFX enable
			proxy:OnDistanceActionAttribute( 4996 , 10000 , 1979 , "OnEvent_4996" , WarpGimmickDist_A , 10010180 , 0 , 180 , possible_chr_type, once );
		else
			--▼要石でワープ用の監視を追加▼ --EN:--▼ Added surveillance for warp with keystone ▼
			SingleReset(proxy,4998);
			--proxy:InvalidSfx( 2601, false );--SFX 有効化 --EN:--SFX enable
			proxy:InvalidSfx( 2600, false );--SFX 有効化 --EN:--SFX enable
			proxy:OnDistanceActionAttribute( 4998 , 10000 , 1979 , "OnEvent_4998" , WarpGimmickDist_A , HELPID_GO_TO_SEKITYUU , 0 , 180 , ATTR_NOSESSION , everytime );
		end
	else
		--▽ボス生きているとき --EN:--▽ When the boss is alive
		
		--エリアボスポリ劇を見ていないとき --EN:--When not watching the Area Bospoli play
		if proxy:IsCompleteEvent(1541) == false then
			
			InvalidCharactor( proxy,822 );			
			--何にも当たらない --EN:--no hits
			--proxy:SetIgnoreHit( 822, true);
			--proxy:DisableMapHit( 822 , true);
	
			--子エイを表示しない --EN:--Do not display baby rays
			local eneID;
			for eneID = 400, 411, 1 do
				proxy:SetDrawEnable( eneID, false );
				proxy:SetColiEnable( eneID, false );
			end
		end
		
		proxy:EnableLogic( 822 , false );--ロジックOFFで待機 --EN:--Wait with logic OFF
		
		
		--子エイロジックOFF --EN:--child logic off
		local eneID = 400;
		for eneID=400 , 411 , 1 do
			proxy:EnableLogic(eneID,false);
		end
		
		--宝(ソウル?) --EN:--Treasure (Soul?)
		proxy:SetDrawEnable( 1979 , false );
		proxy:SetColiEnable( 1979 , false );
		--宝(ソウル?)2 --EN:--Treasure (Soul?) 2
		proxy:SetDrawEnable( 1978 , false );
		proxy:SetColiEnable( 1978 , false );

		--SFX 無効化 --EN:--Disable SFX
		proxy:InvalidSfx( 2600 , false );--ソウル用 --EN:--For Seoul
		proxy:InvalidSfx( 2601 , false );--ボスアイテム用			 --EN:--For boss items

	end
	
--■1544■ボス戦カメラ対応■ --EN:-- ■ 1544 ■ Boss battle camera support ■
	--ボスが生きているなら登録 --EN:--Register if the boss is alive
	if proxy:IsCompleteEvent(4992) == false then
		proxy:NotNetMessage_begin();
			proxy:OnRegionIn( 1544 , 10000 , 2884 ,"OnEvent_1544" , everytime );
		proxy:NotNetMessage_end();
	end

--■1590■ストームブリンガー強化■ --EN:-- ■ 1590 ■ Storm Bringer enhancement ■
	--ボスが生きているなら登録 --EN:--Register if the boss is alive
	--if proxy:IsCompleteEvent(4992) == false then
		proxy:NotNetMessage_begin();
			proxy:OnRegionIn( 1590, 10000, 2610 , "OnEvent_1590",everytime ); 
			proxy:OnRegionJustOut( 1590 , 10000 , 2610 , "OnEvent_1590_out",everytime );
		proxy:NotNetMessage_end();
	--end
	
--■1570■砦１・２の子エイの無効化■ --EN:-- ■ 1570 ■ Fort 1 and 2's Child Ray Invalidation ■
	SingleReset( proxy , 1570 );
	
	--if proxy:IsCompleteEvent( 4992 ) == false then
		proxy:NotNetMessage_begin();
			if proxy:IsClient() == false then
				proxy:OnRegionJustIn( 1570 ,10000 , 2680 , "OnEvent_1570" , everytime );
			end
			if proxy:IsCompleteEvent( 1570 ) == true then
				for eneid = 388 , 399 , 1 do
					InvalidCharactor( proxy , eneid );
				end
			end
		proxy:NotNetMessage_end();
		proxy:LuaCall( 1570 , 0 , "OnEvent_1570_1",everytime );
	--end
	
--■1571■砦１・２の子エイの有効化■ --EN:-- ■ 1571 ■ Fort 1 and 2's Child Ray Enabled ■
	--if proxy:IsCompleteEvent( 4992 ) == false then
		proxy:NotNetMessage_begin();
			if proxy:IsClient() == false then
				proxy:OnRegionJustIn( 1571 ,10000 , 2681, "OnEvent_1571" , everytime );
			end
		proxy:NotNetMessage_end();
		proxy:LuaCall( 1571 , 0 , "OnEvent_1571_1",everytime );
	--end

--■8085■古砦に来たフラグを立てる■	 --EN:-- ■ 8085 ■ Raise a flag to come to the old fort ■
	proxy:SetEventFlag(8085, true);
	
	--結晶トカゲ逃亡イベント --EN:--Crystal Lizard Escape Event
	RegistTokage(proxy,1580,256,10);
	RegistTokage(proxy,1582,257,11);
	


--■1591■ストームブリンガー■ --EN:-- ■ 1591 ■ Stormbringer ■
	if proxy:IsCompleteEvent( 1591 ) == false then
		--ホスト、生存、グレイのみ調べることができる --EN:--Only hosts, survivors, and grays can be examined
		local possible_chr_type = ATTR_HOST + ATTR_LIVE + ATTR_GREY;
		
		proxy:OnDistanceActionAttribute( 1591 , LOCAL_PLAYER , 1610 , "OnEvent_1591" , ItemBoxDist_A , 10010158 , 0 , ItemBoxAngle_A ,possible_chr_type, everytime ); 
		proxy:LuaCall( 1591,1,"OnEvent_1591_2",once);
		proxy:LuaCall( 1591,2,"OnEvent_1591_3",once);
		proxy:TreasureDispModeChange2( 1610, true ,KEN_SFX);
	else
		proxy:SetDrawEnable( 1610 , false );--ひとまず描画だけOFF --EN:--Only drawing is turned off for the time being
		proxy:SetColiEnable( 1610 , false );
	end	
	

	--■999999■フレーム遅れの初期化処理イベントを発行■ --EN:-- ■ 999999 ■ Generate a frame delay initialization processing event ■
	proxy:NotNetMessage_begin();
		--▼0秒後▼-- --EN:--▼After 0 seconds▼--
		proxy:OnKeyTime2( 999993, "Second_Initialize_m03_03_00_00", 0.0, 0, 0, once );	
	proxy:NotNetMessage_end();	
	
	print("Initialize_m03_03_00_00 end");
end


--------------------------------------------------------------------------------------
--Initializeから呼ばれる、1フレーム遅れの初期化処理■999999 --EN:--Initialization with a delay of 1 frame, called from Initialize ■999999
--------------------------------------------------------------------------------------
--■999999■一部、Initでは処理できないので、残しておく --EN:-- ■ 999999 ■ Some parts cannot be processed by Init, so leave them
function Second_Initialize_m03_03_00_00(proxy, param)
	print("Second_Initialize_m03_03_00_00 begin");

--------------------------------▽▽▽QWCイベント関連▽▽▽-------------------------------- --EN:--▽▽▽QWC event related ▽▽▽--------------------------------
--------------------------------△△△QWCイベント関連△△△-------------------------------- --EN:--△△△QWC event related△△△--------------------------------

	print("Second_Initialize_m03_03_00_00 end");
end



	


--------------------------------------------------------------------------------------
--エリアボスポリ劇再生■1541 --EN:--Area Bospoli Drama Play ■ 1541
--------------------------------------------------------------------------------------
--発動領域の中に入った --EN:-- entered the activation area
function OnEvent_1541(proxy, param)
	print("OnEvent_1541 begin");
	
	--ポリ劇再生開始 --EN:--Start playing polyplay
	proxy:RequestRemo(30300,REMO_FLAG,1541,1);
	proxy:SetEventFlag( 1541 , 1 );--ポリ劇再生終了フラグON	 --EN:-- Polyplay play end flag ON
	print("OnEvent_1541 end");
end

--■1541_RemoStart■ポリ劇開始 フェードアウト完了■ --EN:--■ 1541_RemoStart ■ Poly drama start Fade out complete ■
function OnEvent_1541_RemoStart(proxy,param)
	print( "OnEvent_1541_RemoStart begin" );
	print( "OnEvent_1541_RemoStart end" );
end

--■1541_RemoFinish■ポリ劇再生終了後■ --EN:--■ 1541_RemoFinish ■ After playing the polyplay ■
function OnEvent_1541_RemoFinish(proxy , param)
	print( "OnEvent_1541_RemoFinish begin" );
	
	--ボス戦闘開始用の処理を呼び出す --EN:--Call the process for starting the boss battle
	BossInit_StormOfBeast(proxy,param);

	--ボスポリ劇終了後のボスの表示 --EN:-- Boss display after the end of the Bospoli play
	--proxy:SetDrawEnable( 822, true );
	--proxy:SetColiEnable( 822, true );
	ValidCharactor( proxy, 822);
	
	--ボスポリ劇終了後の子エイの表示 --EN:--Display of baby stingrays after the end of the Bospoli play
	local eneID;
	for eneID = 400, 411, 1 do
		proxy:SetDrawEnable( eneID, true );
		proxy:SetColiEnable( eneID, true );
	end
	
	--ポリ劇再生終了のフラグ --EN:--flag to end polyplay
	proxy:SetEventFlag( 5085 ,true );
	
	print( "OnEvent_1541_RemoFinish end" );
end



--------------------------------------------------------------------------------------
--ボス部屋の中に入る■1542 --EN:--Enter the boss room 1542
--------------------------------------------------------------------------------------
--■イベントがループなので、全部リピートにする↓ --EN:--■ Since the event is a loop, repeat all ↓
--■1542■中ボス部屋への扉が開く■ --EN:-- ■ 1542 ■ The door to the mid-boss room opens ■
function OnEvent_1542(proxy,param)
	print("OnEvent_1542 begin");

	if proxy:IsCompleteEvent( SYSTEM_ID_IGNORE ) == true then
		print("OnEvent_1542 end");
		return;
	end	
	
	--クライアントへ、ボス部屋阻止失敗を通知 --EN:--Notify client of failure to block boss room
	if proxy:IsClient() == false then
		proxy:LuaCallStart( 4068 , 1 );	
	end
	
	proxy:LuaCallStart( 1543 , 1 );--旋回アニメの同期再生 --EN:-- Synchronous playback of turning animation
	--proxy:SetEventFlag( SYSTEM_ID_IGNORE, true );
	--多重起動システムIDをタイムアウトを設定してONにする --EN:--Turn on multiple activation system ID by setting timeout
	proxy:SetSystemIgnore( SYSTEM_ID_IGNORE , IGNORE_TIME );
	
	--プロファイルセーブ要求 --EN:--profile save request
	proxy:SaveRequest_Profile();
	
	print("OnEvent_1542 end");
end


--旋回アニメの同期再生(IDが別) --EN:-- Synchronized playback of turning animation (ID is different)
function OnEvent_1542_1(proxy,param)
	print("OnEvent_1542_1 begin");

	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		if param:IsNetMessage() == true then
			--旋回アニメ再生を同期 --EN:-- Synchronize turning animation playback
			proxy:TurnCharactor( 10001 + param:GetPlayID(), 2888 );
		else
			proxy:LockSession();--ルームをロックします！ --EN:--lock the room!
			--旋回アニメ再生を行い、その終了時にOnEvent_1542_2を発行する --EN:--Play the turning animation and issue OnEvent_1542_2 at the end
			proxy:OnTurnCharactorEnd( 1543, 10000, 2888, "OnEvent_1542_2", once );
		end
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	
	print("OnEvent_1542_1 end");
end

--旋回アニメの同期再生終了後 --EN:--After synchronous playback of turning animation ends
function OnEvent_1542_2(proxy,param)
	print("OnEvent_1542_2 begin");

	--同期用歩きアニメ再生 --EN:--Play walking animation for synchronization
	proxy:LuaCallStart( 4012, 1 );
	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		proxy:OnChrAnimEnd( 1543, 10000, ANIMEID_WALK, "OnEvent_1542_3", once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	
	print("OnEvent_1542_2 end");
end

--歩きアニメの同期再生終了後 --EN:--After the synchronized playback of the walking animation ends
function OnEvent_1542_3(proxy,param)
	print("OnEvent_1542_3 begin");

	--最初の人がボス部屋の中に入り終わっていたら、既に配信されているはずなので、もうおくらないハンドラ --EN:--If the first person has already entered the boss room, it should have already been delivered, so no more handlers
	if proxy:IsCompleteEvent( 1542 ) == false then
		proxy:LuaCallStart( 1543 , 5 );--2回目以降にボス部屋に入るためのイベント配信用 --EN:--For event delivery to enter the boss room after the second time
		proxy:LuaCallStart( 4045 , 1 );	--クライアントへ、ボス部屋に入れるようになったことを通知 --EN:--Notify clients that they can now enter the boss room
		proxy:LuaCallStart( 1543 , 6 );--フラグセット(同期用)		 --EN:--flag set (for synchronization)
		--嵐の獣と子エイ対応 --EN:--Storm beast and baby stingray support
		local eneidlist = {822,400,401,402,403,404,405,406,407,408,409,410,411};
		local num = table.getn( eneidlist );
		for index = 1 , num , 1 do
			Lua_MultiDoping(proxy,eneidlist[index]);--マルチプレイドーピング --EN:-- Multiplayer Doping
		end
	end

	--プレイヤーが扉の中に完全にはいったタイミングで、ボスの思考をリセット --EN:--Reset the boss' thoughts when the player is completely inside the door
	--場所が悪いとプレイヤーを見つけれないため(攻撃してこない) --EN:--Because you can't find the player if the location is bad (they won't attack)
	if proxy:IsClient() == false then
		proxy:ResetThink( 822 );
	end	
	
	proxy:SetEventFlag( SYSTEM_ID_IGNORE, false );
	print("OnEvent_1542_3 end");
end


--■1542 2回目以降にボス部屋に入るためのイベント配信用 --EN:-- 1542 For event delivery to enter the boss room after the second time
function OnEvent_1542_GO_TO_IN(proxy, param)
	print("OnEvent_1542_GO_TO_IN begin");	
	proxy:NotNetMessage_begin();
		--▼1542▼扉が開いているときに中に入るためのイベントを追加▼--ハンドラは OnEvent_1542 --EN:--▼1542▼Add an event to enter when the door is open▼--The handler is OnEvent_1542
		proxy:OnPlayerActionInRegion( 1543, 2892, "OnEvent_1542", HELPID_GO_TO_IN, everytime );--
	proxy:NotNetMessage_end();	
	print("OnEvent_1542_GO_TO_IN end");
end


--■1542 フラグセット(同期用) --EN:-- 1542 flag set (for synchronization)
function OnEvent_1542_flag_set(proxy, param)
	print("OnEvent_1542_flag_set begin");		
	proxy:SetEventFlag( 1542 , 1 );
	proxy:DeleteEvent( 1542 );
	print("OnEvent_1542_flag_set end");
end


--------------------------------------------------------------------------------------
--ボスが動き出す(戦闘開始)■4999 --EN:-- Boss begins to move (battle begins) 4999
--------------------------------------------------------------------------------------
function OnEvent_4999(proxy, param)
	if proxy:IsCompleteEvent( 5085 ) == false then
		return;
	end
	
	print("OnEvent_4999 begin");
	
	--ボス戦用BGM再生開始 --EN:--Start playing BGM for boss battle
	proxy:PlayPointSE( 2602, SOUND_TYPE_M, 30300000, 3 );
	--ロジックON --EN:--Logic ON
	proxy:EnableLogic( 822 , true );
	--嵐の獣はこの段階ではロジックOFF --EN:--Storm Beast is off logic at this stage
	
	--ボス戦闘開始用の処理を呼び出す --EN:--Call the process for starting the boss battle
	--BossInit_StormOfBeast(proxy,param);
	--読み込みタイミングのとき毎回追加されてほしいのでフラグたてない --EN:-- I want it to be added every time at the time of reading, so I don't set a flag
	--ボスゲージ表示 --EN:-- Boss gauge display
	proxy:SetBossGauge( 822 , 0 ,5030 );
	
	--監視削除 --EN:--Delete monitor
	proxy:DeleteEvent( 4999 );
	
	print("OnEvent_4999 end");
end


--------------------------------------------------------------------------------------
--エリアボスの死亡■4992 --EN:--Death of area boss 4992
--------------------------------------------------------------------------------------
function OnEvent_4992(proxy, param)
	print("OnEvent_4992begin");
	
	proxy:NotNetMessage_begin();
		--▼4992_1▼1秒経過▼ --EN:--▼4992_1▼1 second passed▼
		proxy:OnKeyTime2( 4992, "OnEvent_4992_1", 1, 0, 0, once);
		--▼4992_2▼2秒経過▼ --EN:--▼4992_2▼2 seconds passed▼
		proxy:OnKeyTime2( 4992, "OnEvent_4992_2", 2, 0, 1, once);
		--マルチ解散監視 --EN:--Multi-Dismissal Monitoring
		proxy:OnRegistFunc( 4992 , "Check_4992_PT","OnEvent_4992_PT",0,once);
	proxy:NotNetMessage_end();
	
	proxy:SetEventFlag( 4992, 1 );--ボス記録用　新仕様共用 --EN:--For Boss recording new specification shared
	--２秒後には、BGMと光の壁が消えているはず --EN:--After 2 seconds, the BGM and light wall should disappear
	proxy:SetEventFlag(4995 , true);

	--ホスト自キャラ　or　シングル		 --EN:--Host's own character or single
	proxy:SetEventFlag(	8011, 1 );--クリアフラグON	 --EN:--Clear flag ON

	--エイ通常更新を開始 --EN:--A normal update started
	--LuaFunc_NormalOmission(proxy,822);
	
	--子エイ後始末--親と心中 --EN:--Cleaning up child ray--suicide with parents
	local eneID = 400;
	for eneID=400 , 411 , 1 do
		if proxy:IsAlive(eneID) == true then
			proxy:ForceDead(eneID);
		end
	end	
	
	--ブロッククリア処理へ --EN:-- to block clear processing
	--proxy:LuaCallStart( 4040, 1 );
	--新ブロッククリア処理へ --EN:--To new block clear processing
	proxy:CustomLuaCallStart( 4050, 822);
	
	--結晶トカゲリセット --EN:-- crystal lizard reset
	ResetTokage(proxy);
		
	print("OnEvent_4992 end");
end

--▲4992_1▲城内部扉開放:中ボス死亡後1秒▲ --EN:--▲4992_1▲Open the door inside the castle: 1 second after the middle boss dies▲
function OnEvent_4992_1(proxy, param)
	print("OnEvent_4992_1 begin");
	
	--ボスを倒した数を更新(数によってフラグを立てる) --EN:--update number of bosses killed (flag by number)
	GetBossFlagCount( proxy, param );
	
--アイテム入手関連------- --EN:--Item Acquisition Related-------
	
	--ホストプレイヤーのみアイテム入手イベントに使用 --EN:--Used for item acquisition event only for host players
	local possible_chr_type = ATTR_HOST + ATTR_LIVE + ATTR_GREY;

	--宝死体(ソウル?)有効化 --EN:--Treasure corpse (soul?) activation
	proxy:SetDrawEnable( 1979 , true );
	proxy:SetColiEnable( 1979 , true );
	--宝死体(ソウル?)2有効化 --EN:--Treasure corpse (soul?) 2 enabled
	proxy:SetDrawEnable( 1978 , true );
	proxy:SetColiEnable( 1978 , true );
	
	--▼(ソウル)アイテム取得用イベント監視追加▼ --EN:--▼ (Soul) Added event monitoring for item acquisition▼
	if proxy:IsCompleteEvent( 4996 ) == false then
		proxy:ValidSfx( 2600 );--SFX 有効化 --EN:--SFX enable
		proxy:ValidSfx( 2601 );--SFX 有効化 --EN:--SFX enable
		proxy:TreasureDispModeChange2( 1979 , true ,KANAME_SFX);--光らせる --EN:-- let it shine
		proxy:OnDistanceActionAttribute( 4996 , 10000 , 1979 , "OnEvent_4996" , WarpGimmickDist_A , 10010180 , 0 , 180 , possible_chr_type, once );
	end
------------------------

	--▼トロフィー取得判定▼ --EN:--▼Trophy Acquisition Judgment▼
	Lua_RequestUnlockTrophy(proxy, 7);
end

--マルチ解散監視 --EN:--Multi-Dismissal Monitoring
function Check_4992_PT(proxy)
	if proxy:IsInParty() == false then
		return true;
	end
	return false;
end

--マルチじゃない --EN:--not multiplayer
function OnEvent_4992_PT(proxy,param)
	print("OnEvent_4992_PT begin");
	--中ボス部屋の前後の魔法壁が消える(全プレイヤー)	 --EN:--The magic walls before and after the mid-boss room disappear (all players)
	proxy:SetColiEnable( 1996 , false );	
	proxy:SetDrawEnable( 1996 , false );
	
	--中ボス部屋魔法壁のSFX削除 --EN:--Remove the SFX of the mid-boss room magic wall
	proxy:InvalidSfx( 1988 , true );	
	
	--中ボス部屋前の移動処理イベントを削除 --EN:--Delete the movement processing event in front of the mid-boss room
	proxy:DeleteEvent( 1542 );--一人目が入るとき用 --EN:--For when the first person enters
	proxy:DeleteEvent( 1543 );--二人目以降が入るとき用 --EN:--For when the second and subsequent people enter
	proxy:DeleteEvent( 4999 );--ボス戦闘開始用	 --EN:--For boss battle start
	print("OnEvent_4992_PT end");	
end


--▲4992_2▲城内部扉開放:中ボス死亡後1秒▲ --EN:--▲4992_2▲Open the door inside the castle: 1 second after the middle boss dies▲
function OnEvent_4992_2(proxy, param)
	print("OnEvent_4992_2 begin");
		
	--ボス戦用のBGM停止 --EN:--BGM stop for boss battles
	proxy:StopPointSE( 3 );
		
	--[[セッション解散時の魔法壁切り替え処理はグローバル?]] --EN:--[[Magic wall switching processing when disbanding a session is global?]]
	
	print("OnEvent_4992_2 end");
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
--■4998■石柱にワープ■ --EN:-- ■ 4998 ■ Warp to the stone pillar ■
--------------------------------------------------------------------------------------
function OnEvent_4998(proxy,param)	
	print("OnEvent_4998 begin");
		
	--セッション中ではないか？ --EN:--Are you in session?
	if proxy:IsSession() == false then
		proxy:RepeatMessage_begin();
			--▼70_1▼選択メニューの監視▼ --EN:--▼70_1▼Select menu monitoring▼
			proxy:OnSelectMenu(4998, "OnEvent_4998_1", 10010710, 0, 2, 1979, 2, once);			
		proxy:RepeatMessage_end();
	else
		--セッション中なんで表示 --EN:--Why display during session
		--proxy:InfomationMenu( INFOMENU_TYPE_SIMPLE, 0, MSG_CATEGORY_EVENT, 10010720, 1);
		--proxy:ShowGenDialog(10010720,1,1,true);
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010720, 0, 6, 1979, GEN_DIALOG_DIST, once );
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
	end

	print("OnEvent_4998 end");
end

--▲4998_1▲選択メニューの監視▲ --EN:--▲4998_1▲Monitor selection menu▲
function OnEvent_4998_1(proxy,param)	
	print("OnEvent_4998_1 begin");	
	
	if proxy:IsSession() == false then
		if param:IsNetMessage() == true then
			proxy:PlayAnimation(10001+param:GetPlayID(),8283);
			print("OnEvent_4998_1 end");
			return;
		end
			
		proxy:PlayAnimation(10000,8283);
		proxy:NoAnimeTurnCharactor( 10000 , 1979 ,TURNSKIP_ANGLE);
		proxy:NotNetMessage_begin();
		proxy:RepeatMessage_begin();
			proxy:OnChrAnimEnd( 4998 , 10000 , 8283 , "OnEvent_4998_2",once);
		proxy:RepeatMessage_end();
		proxy:NotNetMessage_end();
		
		proxy:SetEventFlag(4998,true);
	else
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010720, 0, 6, 1983, GEN_DIALOG_DIST, once );
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
	end
	
	print("OnEvent_4998_1 end");
end

--■4998_2■石柱にワープ■ --EN:-- ■ 4998_2 ■ Warp to the stone pillar ■
function OnEvent_4998_2(proxy,param)	
	print("OnEvent_4998_2 begin");
	
	proxy:PlayAnimation( 10000 , 8284 );--自世界に帰るアニメを再生 --EN:--Play animation to return to your own world
	--石柱へ戻ってきた判定のフラグを立てる --EN:--Flag the judgment of returning to the stone pillar
	proxy:SetEventFlag(8083, true);
	
	--完全回復要求 --EN:-- full recovery request
	proxy:RequestFullRecover();
	--古砦要石に戻る --EN:--Return to Old Fort Keystone
	proxy:WarpNextStage( 1, 0, 0, 0, 1007);	
	print("OnEvent_4998_2 end");
end



--------------------------------------------------------------------------------------
--■4996■ソウル入手■ --EN:-- ■ 4996 ■ Get Seoul ■
--------------------------------------------------------------------------------------
function OnEvent_4996(proxy, param)
	print("OnEvent_4996 begin");
	
	--プレイヤーの同期アニメーション(true:パーティープレイヤーがアニメーションした) --EN:--Player synchronous animation (true: party player animated)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_PICK ) == true then--新しいアニメ  --EN:-- new anime
		print("OnEvent_4996 end");
		return true;
	end
	
	proxy:NotNetMessage_begin();
		--0.0秒後にアイテム取得イベントを発行 --EN:-- Issue an item acquisition event after 0.0 seconds
		proxy:OnKeyTime2( 4996, "OnEvent_4996_1", 0.0, 0, 0, once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_4996 end");
end


--■4996_1■アイテム取得■ --EN:-- ■ 4996_1 ■ item acquisition ■
function OnEvent_4996_1(proxy, param)
	print("OnEvent_4996_1 begin");

	--アイテム取得関数--パラメータ10232参照 --EN:--item retrieval function--see parameter 10232
	proxy:GetRateItem(10232);	
	--アイテム取得関数--パラメータ10278参照 --EN:--item retrieval function--see parameter 10278
	proxy:GetRateItem(10278);	
	--アイテム取得関数--パラメータ10279参照 --EN:--item retrieval function--see parameter 10279
	proxy:GetRateItem(10279);	
	--アイテム取得関数--パラメータ10280参照 --EN:--item retrieval function--see parameter 10280
	proxy:GetRateItem(10280);	
	--アイテム取得関数--パラメータ10281参照 --EN:--item retrieval function--see parameter 10281
	proxy:GetRateItem(10281);	
	
	--アイテムを取得済み --EN:--item already acquired
	proxy:SetEventFlag( 4996, 1 );
	
	--宝箱シェーダーは消えません。 --EN:--Treasure chest shader does not disappear.
	--proxy:TreasureDispModeChange( 1979 , false );

	--SFXが消える --EN:--SFX disappear
	proxy:InvalidSfx( 2600 , true );
	--proxy:InvalidSfx( 2601 , true );
	
	if proxy:IsCompleteEvent( 8035 ) == false then
		proxy:NotNetMessage_begin();
			--瞬間で表示するとメニューが先に出るので待つ --EN:--If you display it instantly, the menu will appear first, so wait
			proxy:OnKeyTime2( 8035 , "OnEvent_8035_wait",0.5 , 0 , 1, once);			
		proxy:NotNetMessage_end();
	else
		--▼要石でワープ用の監視を追加▼ --EN:--▼ Added surveillance for warp with keystone ▼
		proxy:OnDistanceActionAttribute( 4998 , 10000 , 1979 , "OnEvent_4998" , WarpGimmickDist_A , HELPID_GO_TO_SEKITYUU , 0 , 180 , ATTR_NOSESSION , everytime );
	end	

	print("OnEvent_4996_1 end");
end	

--[[
	if proxy:IsCompleteEvent( 8035 ) == false then
		proxy:NotNetMessage_begin();
			--瞬間で表示するとメニューが先に出るので待つ --EN:--If you display it instantly, the menu will appear first, so wait
			proxy:OnKeyTime2( 8035 , "OnEvent_8035_wait",0.5 , 0 , 1, once);			
		proxy:NotNetMessage_end();
	else
		--▼要石でワープ用の監視を追加▼ --EN:--▼ Added surveillance for warp with keystone ▼
		proxy:OnDistanceActionAttribute( 4998 , 10000 , 1979 , "OnEvent_4998" , WarpGimmickDist_A , HELPID_GO_TO_SEKITYUU , 0 , 180 , ATTR_NOSESSION , everytime );
	end	
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
	proxy:OnDistanceActionAttribute( 4998 , 10000 , 1979 , "OnEvent_4998" , WarpGimmickDist_A , HELPID_GO_TO_SEKITYUU , 0 , 180 , ATTR_NOSESSION , everytime );
	print("OnEvent_8035 end");
end


--[[
--------------------------------------------------------------------------------------
--■5000■ボスHP・子エイ死亡監視■ --EN:-- ■ 5000 ■ Boss HP, child ray death monitoring ■
--------------------------------------------------------------------------------------
--死亡監視の統合 --EN:-- Mortality monitoring integration
function CheckDeadCount(proxy,eneID)
	print("OnEvent_5000_",eneID," begin");	
	local deadCount = 0;
	local ID = 400;	
		
	for ID = 400, 411, 1 do
		if proxy:IsAlive(ID) == false then
			deadCount = deadCount + 1;
		end
	end
		
	if deadCount >= BeastChildDeadCount then
		proxy:LuaCallStart(5001,1);
	end	
	print("OnEvent_5000_",eneID," end");	
end
]]

--[[
--子エイの死亡監視 --EN:--Father ray mortality monitoring
function OnEvent_5000_400(proxy,param) CheckDeadCount(proxy,400); end--ID400
function OnEvent_5000_401(proxy,param) CheckDeadCount(proxy,401); end--ID401
function OnEvent_5000_402(proxy,param) CheckDeadCount(proxy,402); end--ID402
function OnEvent_5000_403(proxy,param) CheckDeadCount(proxy,403); end--ID403
function OnEvent_5000_404(proxy,param) CheckDeadCount(proxy,404); end--ID404
function OnEvent_5000_405(proxy,param) CheckDeadCount(proxy,405); end--ID405
function OnEvent_5000_406(proxy,param) CheckDeadCount(proxy,406); end--ID406
function OnEvent_5000_407(proxy,param) CheckDeadCount(proxy,407); end--ID407
function OnEvent_5000_408(proxy,param) CheckDeadCount(proxy,408); end--ID408
function OnEvent_5000_409(proxy,param) CheckDeadCount(proxy,409); end--ID409
function OnEvent_5000_410(proxy,param) CheckDeadCount(proxy,410); end--ID410
function OnEvent_5000_411(proxy,param) CheckDeadCount(proxy,411); end--ID411

--エイのHPの割合監視 --EN:--Proportion monitoring of stingray's HP
function OnEvent_5000_HP(proxy,param)
	print("OnEvent_5000_HP begin");
	proxy:LuaCallStart(5001,1);
	print("OnEvent_5000_HP end");
end
]]

--[[
--------------------------------------------------------------------------------------
--■5001■ボス突撃ポリ劇■ --EN:-- ■ 5001 ■ Boss assault police play ■
--------------------------------------------------------------------------------------
--ポリ劇の起動 --EN:--Launch of polyplay
function OnEvent_5001(proxy,param)
	print("OnEvent_5001 begin");
	proxy:DeleteEvent(5000);
	proxy:RequestRemo(30301,REMO_FLAG,5001,1);
	proxy:SetEventFlag(5001,true);
	print("OnEvent_5001 end");
end

--ポリ劇のフェードアウト --EN:--Fade out of polyplay
function OnEvent_5001_RemoStart(proxy,param)
	print("OnEvent_5001_RemoStart begin");
	--飛行関連アニメ監視削除 --EN:-- Remove flight-related animation monitoring
	proxy:DeleteEvent(5030);
	print("OnEvent_5001_RemoStart end");
end

--ポリ劇のフェードイン --EN:--Fade in polyplay
function OnEvent_5001_RemoFinish(proxy,param)
	print("OnEvent_5001_RemoFinish begin");
	--ボス切り替え初期化 --EN:-- Boss switching initialization
	BossInit_StormOfBeast2(proxy,param);
	print("OnEvent_5001_RemoFinish end");
end
]]






--------------------------------------------------------------------------------------
--↓未整理　↑整理済み function  --EN:--↓ Unorganized ↑ Organized function
--------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------
--■1544■ボスカメラ設定■ --EN:-- ■ 1544 ■ boss camera settings ■
--------------------------------------------------------------------------------------
function OnEvent_1544(proxy,param)
	--print("OnEvent_1544 begin");
	--ボスが死んでいない　かつ　ボスとの戦闘を開始している --EN:-- Boss is not dead and has started a battle with the boss
	if proxy:IsCompleteEvent( 4992 ) == false and proxy:IsCompleteEvent( 4999 ) == true then
		--ボス戦　非ロックカメラ --EN:-- Boss battle unlocked camera
		proxy:SetCamModeParamTargetId(3031);
		--ボス戦　ロックカメラ --EN:--Boss battle rock camera
		proxy:SetCamModeParamTargetIdForBossLock(3030);
	end
	--print("OnEvent_1544 end");
end


--------------------------------------------------------------------------------------
--■1590■強化ストームブリンガー設定■ --EN:-- ■ 1590 ■ Enhanced Stormbringer settings ■
--------------------------------------------------------------------------------------
function OnEvent_1590(proxy,param)
	--ボスが死んでいない　かつ　ボスとの戦闘を開始している --EN:-- Boss is not dead and has started a battle with the boss
	--if proxy:IsCompleteEvent( 4992 ) == false and proxy:IsCompleteEvent( 4999 ) == true then
		local isHasWepon = false;		
		if proxy:GetRightCurrentWeponId() == 21100 then isHasWepon = true end;		
		--print("HadWepId",proxy:GetRightCurrentWeponId());		
		--print("isHasWepon ",isHasWepon);
		--判定した結果をそのまま設定 --EN:-- Set the judged result as it is
		proxy:SetIsUseLongLongSword( isHasWepon );		
	--end
end

--ストームブリンガー終了 --EN:--Storm Bringer End
function OnEvent_1590_out(proxy,param)
	print("OnEvent_1590_out begin");
	proxy:SetIsUseLongLongSword( false );		
	print("OnEvent_1590_out end");
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
function PlayerDeath_m03_03_00_00(proxy, param)
	print("PlayerDeath_m03_03_00_00");
	
--	LuaFunc_VisibleTheWanderingDemon(proxy, param, demon_id_list_m03_03_00_00);
--	proxy:SetEventFlag( 20 , 1 );--フラグは仮、指定があれば変える。 --EN:The -- flag is tentative, and will be changed if specified.
	
	print("PlayerDeath_m03_03_00_00");
end
	
--▼グローバルの血文字復活から呼ばれる(ソロ) --EN:--▼Called from global blood letter revival (solo)
function PlayerRevive_m03_03_00_00(proxy,param)
	print("PlayerRevive_m03_03_00_00");
	
--	LuaFunc_InvisibleTheWanderingDemon(proxy, param, demon_id_list_m03_03_00_00);
--	proxy:SetEventFlag( 20 , 0 );--フラグは仮、指定があれば変える。 --EN:The -- flag is tentative, and will be changed if specified.
	
	print("PlayerRevive_m03_03_00_00");
end


--------------------------------------------------------------------------------------
--1570■砦１・２の子エイの無効化 --EN:--1570■ Nullification of Fort 1 and 2's child Ray
--------------------------------------------------------------------------------------
function OnEvent_1570(proxy,param)
	--if proxy:IsClient() == false then
	print("OnEvent_1570 begin");
	proxy:LuaCallStart( 1570 , 0 );
	print("OnEvent_1570 end");
	--end
end

function OnEvent_1570_1(proxy,param)
	print("OnEvent_1570_1 begin");
	for eneid = 388 , 399 , 1 do
		InvalidCharactor( proxy , eneid );
	end
	proxy:SetEventFlag( 1570 ,true );
	print("OnEvent_1570_1 end");
end

--------------------------------------------------------------------------------------
--1571■砦１・２の子エイの有効化 --EN:--1571■ Activation of Fort 1 and 2 Child Ray
--------------------------------------------------------------------------------------
function OnEvent_1571(proxy,param)
	--if proxy:IsClient() == false then
	print("OnEvent_1571 begin");
	proxy:LuaCallStart( 1571 , 0 );
	print("OnEvent_1571 end");
	--end
end

function OnEvent_1571_1(proxy,param)
	print("OnEvent_1571_1 begin");
	for eneid = 388 , 399 , 1 do
		ValidCharactor( proxy , eneid );
	end
	proxy:SetEventFlag( 1570 ,false );
	print("OnEvent_1571_1 end");
end


-----------------------------------------------------------------------------
--■1580■結晶トカゲイベント4 --EN:-- ■ 1580 ■ Crystal Lizard Event 4
-----------------------------------------------------------------------------
function OnEvent_1580(proxy,param)
	print("OnEvent_1580 begin");
	proxy:SetEventFlag( 1580 , true );
	proxy:DeleteEvent( 1580 );
	print("OnEvent_1580 end");
end

-----------------------------------------------------------------------------
--■1582■結晶トカゲイベント5 --EN:-- ■ 1582 ■ Crystal Lizard Event 5
-----------------------------------------------------------------------------
function OnEvent_1582(proxy,param)
	print("OnEvent_1582 begin");
	proxy:SetEventFlag( 1582 , true );
	proxy:DeleteEvent( 1582 );
	print("OnEvent_1582 end");
end




--------------------------------------------------------------------------------------
--ストームブリンガー■1591 --EN:--Storm Bringer 1591
--------------------------------------------------------------------------------------
function OnEvent_1591(proxy,param)
	if param:IsNetMessage() == false then	
	print("OnEvent_1591 begin");
	proxy:NotNetMessage_begin();
	proxy:RepeatMessage_begin();
		--アニメ --EN:--animation
		proxy:PlayAnimation( 10000 , 8290);
		proxy:PlayAnimation( 1610 , 1);	
		proxy:OnKeyTime2( 1591 , "OnEvent_1591_0",0.01,0,0,once);
	proxy:RepeatMessage_end();
	proxy:NotNetMessage_end();
	
	print("OnEvent_1591 end");
	end
end

function OnEvent_1591_0(proxy,param)
	print("OnEvent_1591_0 begin");
	--if proxy:IsPlayerStay(10000) == true then
	if proxy:IsEventAnim( 10000 , 8290 ) == true then		
		proxy:LuaCallStart( 1591, 2);			
	else
		proxy:ForcePlayAnimation( 1610 , 0);	
	end
	print("OnEvent_1591_0 end");
end

--■1591_1■アイテム取得■ --EN:-- ■ 1591_1 ■ item acquisition ■
function OnEvent_1591_1(proxy,param)
	print("OnEvent_1591_1 begin");
	--アイテム取得関数--パラメータ10419参照 --EN:--item retrieval function--see parameter 10419
	proxy:GetRateItem(10217);	
	
	--アイテムを取得済み --EN:--item already acquired
	proxy:SetEventFlag( 1591, true );
	
	--OBJを消すためのイベント配信 --EN:--Event distribution for erasing OBJ
	proxy:LuaCallStart( 1591, 1);

	print("OnEvent_1591_1 end");
end

--■1591_2■剣OBJ非表示用■ --EN:--■ 1591_2 ■ For hiding the sword OBJ ■
function OnEvent_1591_2(proxy,param)
	print("OnEvent_1591_2 begin");
	--オブジェが消える --EN:--The object disappears
	proxy:SetDrawEnable( 1610 , false );--ひとまず描画だけOFF --EN:--Only drawing is turned off for the time being
	proxy:SetColiEnable( 1610 , false );--当たりはあるのは不明(現状ではないようなので消さない) --EN:--I don't know if there is a hit (I don't delete it because it doesn't seem to be the current situation)
	
	proxy:DeleteEvent( 1591 );
	print("OnEvent_1591_2 end");
end

--アニメの同期監視 --EN:--Synchronous monitoring of anime
function OnEvent_1591_3(proxy,param)
	print("OnEvent_1591_3 begin");
	proxy:TreasureDispModeChange2( 1610, false ,KEN_SFX);
	--プレイヤーの同期アニメーション(true:パーティープレイヤーがアニメーションした) --EN:--Player synchronous animation (true: party player animated)
	if Luafunc_PlaySynchroAnimation( proxy, param, 8290 ) == true then--新しいアニメ  --EN:-- new anime
		proxy:PlayAnimation( 1610 , 1);	
		print("OnEvent_1591_3 end");
		return true;
	end		
	
	--剣にワープ --EN:--Warp to sword
	proxy:WarpDmy( LOCAL_PLAYER , 1610 , 191 );
	proxy:NotNetMessage_begin();
		proxy:OnChrAnimEnd( 1591 , LOCAL_PLAYER , 8290 , "OnEvent_1591_1", once);
	proxy:NotNetMessage_end();	
	print("OnEvent_1591_3 end");	
end
