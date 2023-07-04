

function Initialize_m99_60_01_00(proxy)
print("Initialize m99_60_01_00 begin");

--■100■レバー■ --EN:-- ■ 100 ■ lever ■
--■110■レバー■ --EN:-- ■ 110 ■ lever ■
	--▼PCがイベントエリア(500)の中に距離(1.5m)有効角(30度幅)でアクションボタンを押した --EN:--▼ PC presses action button at distance (1.5m) effective angle (30 degree width) in event area (500)
	proxy:RepeatMessage_begin();
	
	
		proxy:OnDistanceAction( 100, 10000, 500, "OnEvent_100", 1.5, HELPID_PULL_LEVER, 0, 30, once);
		proxy:OnDistanceAction( 110, 10000, 512, "OnEvent_110", 1.5, HELPID_PULL_LEVER, 0, 30, once);	
	
	--■120■テスト回転アニメ■ --EN:-- ■ 120 ■ test rotation animation ■
	--▼PCがハンドル(506)に対して反応角度(45)、角度オフセット(-90)、距離(150)でアクションボタンを押す▼--	 --EN:--▼ PC presses action button with reaction angle (45), angle offset (-90), distance (150) relative to handle (506) ▼--
		proxy:OnDistanceAction( 120, 10000, 506, "OnEvent_120", 1.5, HELPID_TURN_HANDLE, -90.0, 45.0, once );	
	--■130■テスト回転後OBJのレバーアニメ■ --EN:--■ 130 ■ Lever animation of OBJ after test rotation ■
	--▼PCがOBJ(508)に対して反応角度(90)、角度オフセット(0)、座標オフセット(0, 0, 2.1)距離(140)でアクションボタンを押す▼-- --EN:--▼PC reacts to OBJ(508) with angle (90), angle offset (0), coordinate offset (0, 0, 2.1) distance (140) and press action button▼--
	
		proxy:OnDistanceActionPlus( 130, 10000, 508, "OnEvent_130", 1.4, HELPID_PULL_LEVER, 0, 90.0, 0.0, 0.0, 2.1, once );
	
	--■140■テスト連動アニメ■ --EN:-- ■ 140 ■ test animation ■
		proxy:OnDistanceActionPlus( 140, 10000, 503, "OnEvent_140", 1.4, HELPID_PULL_LEVER, 0, 90.0, 0.0, 0.0, 2.1, once );
	
	--■150■リフトレバー下■ --EN:-- ■ 150 ■ lift lever bottom ■
		proxy:OnDistanceAction( 150, 10000, 510, "OnEvent_150", 1.5, HELPID_START, 0, 30, once);
	--■160■リフトレバー上■ --EN:-- ■ 160 ■ lift lever top ■
		proxy:OnDistanceAction( 165, 10000, 511, "OnEvent_165", 1.5, HELPID_START, 0, 30, once);

	--■2000■ショップテスト■ --EN:-- ■ 2000 ■ Shop test ■
	proxy:RepeatMessage_end();
	
	proxy:OnPlayerActionInRegion( 2000, 60, "OnEvent_2000", HELPID_TALK, everytime );
	

--■220■OBJ落下ダメージ球■ --EN:-- ■ 220 ■ OBJ fall damage ball ■
	--proxy:OnRegistFunc( 220, "Condition_220", "Result_220", 1, once );
	proxy:NotNetMessage_begin();
		proxy:OnObjectDestroy( 220, 513, "Result_220", once );
	proxy:NotNetMessage_end();
	
	
--■1100■宝箱A■ --EN:-- ■ 1100 ■ Treasure box A ■
	if proxy:IsCompleteEvent( 1100 ) ==false then
		proxy:OnDistanceAction( 1100, 10000, 1100, "OnEvent_1100", ItemBoxDist_A, HELPID_CHECK_GLOWING_CORPS, 0, ItemBoxAngle_A, once );
		proxy:SetRarity(1100,10000);
		proxy:TreasureDispModeChange( 1100, true );
	end
	
--■1101■宝箱A■ --EN:-- ■ 1101 ■ Treasure box A ■
	if proxy:IsCompleteEvent( 1101 ) ==false then
		proxy:OnDistanceAction( 1101, 10000, 1101, "OnEvent_1101", ItemBoxDist_A, HELPID_CHECK_GLOWING_CORPS, 0, ItemBoxAngle_A, once );
		proxy:SetRarity(1101,10001);
		proxy:TreasureDispModeChange( 1101, true );
	end
--■1102■宝箱A■ --EN:-- ■ 1102 ■ Treasure box A ■
	if proxy:IsCompleteEvent( 1102 ) ==false then
		proxy:OnDistanceAction( 1102, 10000, 1102, "OnEvent_1102", ItemBoxDist_A, HELPID_CHECK_GLOWING_CORPS, 0, ItemBoxAngle_A, once );
		proxy:SetRarity(1102,10002);
		proxy:TreasureDispModeChange( 1102, true );
	end
--■1103■宝箱A■ --EN:-- ■ 1103 ■ Treasure box A ■
	if proxy:IsCompleteEvent( 1103 ) ==false then
		proxy:OnDistanceAction( 1103, 10000, 1103, "OnEvent_1103", ItemBoxDist_A, HELPID_CHECK_GLOWING_CORPS, 0, ItemBoxAngle_A, once );
		proxy:SetRarity(1103,10003);
		proxy:TreasureDispModeChange( 1103, true );
	end
--■1104■宝箱A■ --EN:-- ■ 1104 ■ Treasure box A ■
	if proxy:IsCompleteEvent( 1104 ) ==false then
		proxy:OnDistanceAction( 1104, 10000, 1104, "OnEvent_1104", ItemBoxDist_A, HELPID_CHECK_GLOWING_CORPS, 0, ItemBoxAngle_A, once );
		proxy:SetRarity(1104,10004);
		proxy:TreasureDispModeChange( 1104, true );
	end
--■1105■宝箱A■ --EN:-- ■ 1105 ■ Treasure box A ■
	if proxy:IsCompleteEvent( 1105 ) ==false then
		proxy:OnDistanceAction( 1105, 10000, 1105, "OnEvent_1105", ItemBoxDist_A, HELPID_CHECK_GLOWING_CORPS, 0, ItemBoxAngle_A, once );
		proxy:SetRarity(1105,10005);
		proxy:TreasureDispModeChange( 1105, true );
	end	
--■1106■宝箱A■ --EN:-- ■ 1106 ■ Treasure box A ■
	if proxy:IsCompleteEvent( 1106 ) ==false then
		proxy:OnDistanceAction( 1106, 10000, 1106, "OnEvent_1106", ItemBoxDist_A, HELPID_CHECK_GLOWING_CORPS, 0, ItemBoxAngle_A, once );
		proxy:SetRarity(1106,10006);
		proxy:TreasureDispModeChange( 1106, true );
	end
--■1107■宝箱A■ --EN:-- ■ 1107 ■ Treasure box A ■
	if proxy:IsCompleteEvent( 1107 ) ==false then
		proxy:OnDistanceAction( 1107, 10000, 1107, "OnEvent_1107", ItemBoxDist_A, HELPID_CHECK_GLOWING_CORPS, 0, ItemBoxAngle_A, once );
		proxy:SetRarity(1107,10007);
		proxy:TreasureDispModeChange( 1107, true );
	end
--■1108■宝箱A■ --EN:-- ■ 1108 ■ Treasure box A ■
	if proxy:IsCompleteEvent( 1108 ) ==false then
		proxy:OnDistanceAction( 1108, 10000, 1108, "OnEvent_1108", ItemBoxDist_A, HELPID_CHECK_GLOWING_CORPS, 0, ItemBoxAngle_A, once );
		proxy:SetRarity(1108,10100);
		proxy:TreasureDispModeChange( 1108, true );
	end
--■1109■宝箱A■ --EN:-- ■ 1109 ■ Treasure box A ■
	if proxy:IsCompleteEvent( 1109 ) ==false then
		proxy:OnDistanceAction( 1109, 10000, 1109, "OnEvent_1109", ItemBoxDist_A, HELPID_CHECK_GLOWING_CORPS, 0, ItemBoxAngle_A, once );
		proxy:SetRarity(1109,10101);
		proxy:TreasureDispModeChange( 1109, true );
	end
--■1110■宝箱A■ --EN:-- ■ 1110 ■ Treasure box A ■
	if proxy:IsCompleteEvent( 1110 ) ==false then
		proxy:OnDistanceAction( 1110, 10000, 1110, "OnEvent_1110", ItemBoxDist_A, HELPID_CHECK_GLOWING_CORPS, 0, ItemBoxAngle_A, once );
		proxy:SetRarity(1110,10102);
		proxy:TreasureDispModeChange( 1110, true );
	end
--■99998■初期化のタイミング生成■ --EN:-- ■ 99998 ■ Initialization timing generation ■
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 99998, "MapInit", 0.0, 0, 0, once );
	proxy:NotNetMessage_end();
	
--■1000■会話からアイテム取得をたたくテスト■ --EN:-- ■ 1000 ■ Test to get items from conversation ■
	proxy:LuaCall( 1000, 0, "Talk_to_ItemInfo_test", once );

--■??■徘徊デーモンの登場■ハンドラ登録 --EN:--■??■Appearance of wandering daemon■Handler registration
	proxy:NotNetMessage_begin();
		--プレイヤーがソロで死亡した時にキックされます。 --EN:--Kicked when a player dies solo.
		proxy:LuaCall( 4000, 100, "PlayerDeath_m99_60_01_00", everytime );
		--プレイヤーが復活した時にキックされます。 --EN:--Kicked when the player is revived.
		proxy:LuaCall( 4032, 100, "PlayerRevive_m99_60_01_00", everytime );
	proxy:NotNetMessage_end();
	
	
--宝死体のイレギュラー対応 --EN:--Irregular support for Treasure Corpses
--■2010■OBJ破壊■ --EN:-- ■ 2010 ■ OBJ destruction ■
	proxy:OnObjectDestroy(2010,2010,"OnEvent_2010",once);	

--■2012■宝死体■ --EN:-- ■ 2012 ■ Treasure corpse ■
	proxy:TreasureDispModeChange(2012,true);
	
	--OBJのID600＝操作OBJ　ID601＝本体 --EN:--OBJ ID600 = Operation OBJ ID601 = Body
	--■600■バリスタイベント開始■ --EN:-- ■ 600 ■ barista event start ■
	proxy:RepeatMessage_begin();
		proxy:OnDistanceAction(600,10000,600,"OnEvent_600",2,HELPID_TURN_HANDLE,180,90,everytime);		
	proxy:RepeatMessage_end();
	--ループアニメ同期用 --EN:--For loop animation synchronization
	proxy:LuaCall(600,2,"OnEvent_600_2",everytime);
	
	--■601■バリスタ同期用■同期用のイベントIDとバリスタ用OnBallistaのイベントIDは同じ、paramは変えない事 --EN:-- ■ 601 ■ For varistor synchronization ■ Event ID for synchronization and OnBallista event ID for varistor are the same, param must not be changed
	proxy:LuaCall(601,0,"OnEvent_601_0",everytime);--0	…Y軸角度同期 --EN:--0 … Y-axis angle synchronization
	proxy:LuaCall(601,1,"OnEvent_601_1",everytime);--1	…X軸角度同期 --EN:--1 … X-axis angle synchronization
	proxy:LuaCall(601,2,"OnEvent_601_2",everytime);--2	…バリスタ発射同期 --EN:--2 … varistor firing synchronization
	proxy:LuaCall(601,3,"OnEvent_601_3",everytime);--3	…バリスタ終了同期 --EN:--3 … Varistor end synchronization
	proxy:LuaCall(601,4,"OnEvent_601_4",everytime);--4	…バリスタダメージ終了 --EN:--4 … End of ballista damage
	proxy:LuaCall(601,5,"OnEvent_601_5",everytime);--5	…フラグ同期用 --EN:--5 … for flag synchronization
	

proxy:OnRegistFunc(3000,"Check_3000","OnEvent_3000",1,once);


proxy:OnRegionIn( 2100,10000,100,"OnEvent_2100",once);

proxy:OnRegionIn( 1200 , 10000 , 1200 , "OnEvent_1200" , everytime);

print("Initialize m99_60_01_00 end");
end




--■220■OBJ落下ダメージ球　Lua監視■ --EN:-- ■ 220 ■ OBJ fall damage ball Lua monitoring ■
function Condition_220(proxy, param)
	if proxy:CheckChrHit_Obj( 10000, 513 ) ==true then
		print("Condition_220 return true");
		return true;
	end
	return false;
end

--■220■OBJ落下ダメージ球　Lua結果■ --EN:-- ■ 220 ■ OBJ fall damage ball Lua result ■
function Result_220(proxy, param)
	print("Result_220 running");
	--すぐにダメージを発生させるとプレイヤーに当たる為、待ち時間をいれる --EN:--In order to hit the player if damage is generated immediately, put a waiting time
	--▼220_1▼***条件追加***--１秒後▼ --EN:--▼220_1▼***Condition added***--After 1 second▼
	proxy:OnKeyTime2( 220, "WaitTime_220", 0.0, 0, 1, once );
end

--▲220_1▲１秒後▲ --EN:--▲220_1▲After 1 second▲
function WaitTime_220(proxy, param)
	print("WaitTime_220 running");
	--すぐにダメージを発生させるとプレイヤーに当たる為、待ち時間をいれる --EN:--In order to hit the player if damage is generated immediately, put a waiting time
	------------------------パラメータ説明-------------------------------- --EN:--Parameter description--------------------------------
	--	アクションID(220),ターゲットOBJ(513),ターゲットのダミポリID(1) --EN:-- Action ID (220), Target OBJ (513), Target dummypoly ID (1)
	--	ダメージ量(50),ダメージ球当たり半径(1.0),ダメージ球有効時間(5.0秒) --EN:-- Damage amount (50), Radius per damage sphere (1.0), Duration of damage sphere (5.0 seconds)
	--	キャラに当たった時に(HitEvent_220)発行 --EN:-- Issue (HitEvent_220) when hitting a character
	----------------------------------------------------------------------
	--▼220_2▼***条件追加***--ダメージ球を発生させダメージ球とマップ、キャラの当たりを監視▼ --EN:--▼220_2▼***Condition added***--Generate a damage sphere and monitor the damage sphere, map, and character hits▼
	proxy:OnObjectDamageHit( 220, 513, 1, 10000, EV_HIT_ALL, 2.0, 5.0, "HitEvent_220", once );
end

--▲220_2▲ダメージ球が当たった▲ --EN:--▲220_2▲ Hit by a damage ball▲
function HitEvent_220(proxy,param)
print("HitEvent_220 is running");
	--マスターの位置、角度にダミポリの位置、角度を設定 --EN:--Set the position and angle of Damipoly to the position and angle of the master
	--ダミポリを使うのでモデル差し替えなどのタイミングに注意!! --EN:--Since Damipoly is used, pay attention to the timing of model replacement!
	--差し替えた後のモデルに指定IDのダミポリが無い場合保障できません。) --EN:--We cannot guarantee if the model after replacement does not have the dummy poly with the specified ID. )
	proxy:ObjRootMtxMove(513);
	--モデルを差し替える --EN:--replace model
	proxy:ChangeModel( 513, 2);
	--初速度を設定（主にばらけさせる為） --EN:--Set the initial speed (mainly for dispersion)
	proxy:SetFirstSpeed(513);
	--オブジェクトを破片にしてあたり判定を消す --EN:--Eliminate the hit judgment by breaking the object into pieces
	proxy:SetBrokenPiece(513);
end

--------------------------------------------------------------------------------------
--初期化■99998 --EN:-- Initialization 99998
--------------------------------------------------------------------------------------
--■99998■初期化のタイミング生成■ --EN:-- ■ 99998 ■ Initialization timing generation ■
function MapInit(proxy, param)
	print("MapInit_begin");
	proxy:SetColiEnable( 500, false );
	proxy:TreasureDispModeChange( 507, true);
	proxy:PlayLoopAnimation( 509, 2 );
	
	proxy:SetChrType(200,CHR_TYPE_WhiteGhost);
	
--[[
	--■徘徊デーモン用 (フラグは仮、指定があれば変える) --EN:--■For wandering daemon (flag is tentative, change if specified)
	if proxy:IsCompleteEvent( 20 ) == true then
		LuaFunc_VisibleTheWanderingDemon  (proxy, param, demon_id_list_m99_60_01_00);
	else
		LuaFunc_InvisibleTheWanderingDemon(proxy, param, demon_id_list_m99_60_01_00);
	end
]]
	
	print("MapInit_end");
end

--■****■現在は使わないが、無いとパーティー時にアサートが出てしまうので■ --EN:--■****■I don't use it now, but if I don't have it, an assert will appear at the party■
function ConnectPartyEvent(proxy)
	print("ConnectPartyEvent begin");
	print("ConnectPartyEvent end");
end

--------------------------------------------------------------------------------------
--レバー■100 --EN:-- Lever ■ 100
--------------------------------------------------------------------------------------
--■100■レバー■ --EN:-- ■ 100 ■ lever ■
function OnEvent_100(proxy, param)
	print("OnEvent_100 begin");
--[[	
	--レバーが動くアニメを再生 --EN:-- Play an animation where the lever moves
	proxy:PlayAnimation(500, 1);
	
	--100番イベントの条件とハンドルを削除 --EN:--Remove condition and handle of 100th event
	proxy:DeleteEvent(100);
	
	--▼100_1▼***条件追加***--プレイヤーのレバー引きアニメ終了▼ --EN:--▼100_1▼***Conditions added***--End of player's lever pull animation▼
	proxy:OnChrAnimEnd( 101, 10000, 8000, "OnEvent_100_1", once);
	
	--▼100_2▼***条件追加***--レバーアニメ終了▼ --EN:--▼100_2▼***Condition added***--Lever animation ends▼
	proxy:OnCharacterAnimEnd( 102, 500, 1, "OnEvent_100_2", once);
	
	--旋回と移動を止める --EN:--stop turning and moving
	proxy:DisableMove(10000,1);

	--PCがレバーを引くアニメ(ID 8000)を再生 --EN:--Play an animation (ID 8000) where the PC pulls the lever
	proxy:PlayAnimation(10000, 8000);
	
	--PCを適切な位置にワープさせる --EN:-- Warp the PC to the appropriate position
	--proxy:Warp(10000, 2000);
]]	
	--ホバー移動モードに移行-- --EN:--Transition to hover mode--
	proxy:BeginAction(10000,2,2,2);

	--移動位置(2000)に0.5秒でホバー移動-- --EN:--Hover to move position (2000) in 0.5 seconds--
	proxy:HoverMoveVal(10000,2000,0.1);
	
	--旋回と移動を止める --EN:--stop turning and moving
	proxy:DisableMove(10000,1);
	
	proxy:OnKeyTime2( 100, "OnEvent_100_test", 0.1, 0, 1, once );

	print("OnEvent_100 end");
end
function OnEvent_100_test(proxy,param)
	print("OnEvent_100_test begin");
	--レバーが動くアニメを再生 --EN:-- Play an animation where the lever moves
	proxy:PlayAnimation(500, 1);
	
	--100番イベントの条件とハンドルを削除 --EN:--Remove condition and handle of 100th event
	proxy:DeleteEvent(100);
	
	--▼100_1▼***条件追加***--プレイヤーのレバー引きアニメ終了▼ --EN:--▼100_1▼***Conditions added***--End of player's lever pull animation▼
	proxy:OnChrAnimEnd( 101, 10000, 8000, "OnEvent_100_1", once);
	
	--▼100_2▼***条件追加***--レバーアニメ終了▼ --EN:--▼100_2▼***Condition added***--Lever animation ends▼
	proxy:OnCharacterAnimEnd( 102, 500, 1, "OnEvent_100_2", once);
	
	--PCがレバーを引くアニメ(ID 8000)を再生 --EN:--Play an animation (ID 8000) where the PC pulls the lever
	proxy:PlayAnimation(10000, 8000);
	
	
	print("OnEvent_100_test end");
end

--▲100_1▲プレイヤーのレバー引きアニメ終了▲ --EN:--▲100_1▲The player pulls the lever animation.▲
function OnEvent_100_1(proxy, param)
	print("OnEvent_100_1 begin");
	
	--101番イベントの条件とハンドルを削除 --EN:--Removed the condition and handle of the 101st event
	proxy:DeleteEvent(101);
	
	--旋回と移動を有効にする --EN:--Enable turn and move
	proxy:DisableMove(10000,0);
	
	--アクション終了-- --EN:--End of action--
	proxy:ActionEnd(10000);
	
	print("OnEvent_100_1 end");
end

--▲100_2▲レバーアニメ終了▲ --EN:--▲100_2▲Lever animation ends▲
function OnEvent_100_2(proxy, param)
	print("OnEvent_100_2 begin");
	
	--102番イベントの条件とハンドルを削除 --EN:--Remove condition and handle of 102nd event
	proxy:DeleteEvent(102);
	
	
	proxy:SetDefaultAnimation(500);
	
	--▼100▼***条件追加***--レバー▼ --EN:--▼100▼***Condition added***--Lever▼
	proxy:RepeatMessage_begin();
		proxy:OnDistanceAction( 100, 10000, 500, "OnEvent_100", 1.5, HELPID_START, 0, 30, once);
	proxy:RepeatMessage_end();
	print("OnEvent_100_2 end");
end

--------------------------------------------------------------------------------------
--レバー■110 --EN:-- Lever 110
--------------------------------------------------------------------------------------
--■110■レバー■ --EN:-- ■ 110 ■ lever ■
function OnEvent_110(proxy, param)
	print("OnEvent_110 begin");
	
	--レバーが動くアニメを再生 --EN:-- Play an animation where the lever moves
	proxy:PlayAnimation(512, 1);
	
	--110番イベントの条件とハンドルを削除 --EN:-- Deleted the condition and handle of the 110th event
	proxy:DeleteEvent(110);
	
	--▼110_1▼***条件追加***--プレイヤーのレバー引きアニメ終了▼ --EN:--▼110_1▼***Conditions added***--End of player's lever pull animation▼
	proxy:OnChrAnimEnd( 111, 10000, 8000, "OnEvent_110_1", once);
	
	--▼110_2▼***条件追加***--レバーアニメ終了▼ --EN:--▼110_2▼***Condition added***--Lever animation ends▼
	proxy:OnCharacterAnimEnd( 112, 512, 1, "OnEvent_110_2", once);
	
	--旋回と移動を止める --EN:--stop turning and moving
	proxy:DisableMove(10000,1);

	--PCがレバーを引くアニメ(ID 8000)を再生--自世界アニメのテストに変更 --EN:-- Play animation (ID 8000) where PC pulls the lever -- Changed to test animation in own world
	proxy:PlayAnimation(10000, 8289);
	
	--PCを適切な位置にワープさせる --EN:-- Warp the PC to the appropriate position
	--proxy:Warp(10000, 2009);
	print("OnEvent_110 end");
end

--▲110_1▲プレイヤーのレバー引きアニメ終了▲ --EN:--▲110_1▲The player pulls the lever animation.▲
function OnEvent_110_1(proxy, param)
	print("OnEvent_110_1 begin");
	
	--111番イベントの条件とハンドルを削除 --EN:--Removed the condition and handle of the 111th event
	proxy:DeleteEvent(111);
	
	--旋回と移動を有効にする --EN:--Enable turn and move
	proxy:DisableMove(10000,0);
	
	print("OnEvent_110_1 end");
end
--▲110_2▲レバーアニメ終了▲ --EN:--▲110_2▲Lever animation ends▲
function OnEvent_110_2(proxy, param)
	print("OnEvent_110_2 begin");
	
	--112番イベントの条件とハンドルを削除 --EN:--Removed the condition and handle of the 112th event
	proxy:DeleteEvent(112);
	
	
	proxy:SetDefaultAnimation(512);
	
	--▼110▼***条件追加***--レバー▼ --EN:--▼110▼***Condition added***--Lever▼
	proxy:RepeatMessage_begin();
		proxy:OnDistanceAction( 110, 10000, 512, "OnEvent_110", 1.5, HELPID_START, 0, 30, once);
	proxy:RepeatMessage_end();
	print("OnEvent_110_2 end");
end



--------------------------------------------------------------------------------------
--テスト回転アニメ■120 --EN:--Test rotation animation ■120
--------------------------------------------------------------------------------------
--■120■テスト回転アニメ■ --EN:-- ■ 120 ■ test rotation animation ■
function OnEvent_120(proxy, param)
	print("OnEvent_120 begin")
	
	--ハンドルが回るアニメを再生 --EN:-- Play an animation in which the steering wheel turns
	proxy:PlayAnimation( 506, 1 );
	
	--120番イベントの条件とハンドルを削除 --EN:--Removed the condition and handle of the 120th event
	proxy:DeleteEvent(120);
	
	--130番イベントの条件とハンドルを削除 --EN:--Removed the condition and handle of the 130th event
	proxy:DeleteEvent(130);
	
	--旋回と移動を止める --EN:--stop turning and moving
	proxy:DisableMove(10000,1);
	
	--▼120_1▼***条件追加***ハンドルアニメ終了▼ --EN:--▼120_1▼***Conditions added***End handle animation▼
	proxy:OnCharacterAnimEnd( 121, 506, 1, "OnEvent_120_1", once );
	
	--▼120_4▼***条件追加***プレイヤーハンドルアニメ終了▼ --EN:--▼120_4▼***Condition added***Player handle animation finished▼
	--proxy:OnChrAnimEnd( 124, 10000, 8010, "OnEvent_120_4", once );
	proxy:OnKeyTime2( 124, "OnEvent_120_4", 1.0, 0, 1, once );
	
	--プレイヤーをハンドルワープ位置へ --EN:--Player to handle warp position
	proxy:Warp(10000, 2006 );
	
	--プレイヤーのハンドルを回すアニメを再生 --EN:-- Play an animation that rotates the player's steering wheel
	proxy:PlayAnimation( 10000, 8010 );
	
	print("OnEvent_120 end")
end

--▲120_1▲回転アニメ終了▲ --EN:--▲120_1▲End of rotation animation▲
function OnEvent_120_1(proxy, param)
	print("OnEvent_120_1 begin")

	--121番イベントの条件とハンドルを削除 --EN:--Removed the condition and handle of the 121st event
	proxy:DeleteEvent( 121 );
	
	
	--▼120_2▼***条件追加***1秒後▼ --EN:--▼120_2▼***Condition added***After 1 second▼
	proxy:OnKeyTime2( 122, "OnEvent_120_2", 1.0, 0, 0, once );

	print("OnEvent_120_1 end")
end

--▲120_2▲1秒後▲ --EN:--▲120_2▲After 1 second▲
function OnEvent_120_2(proxy, param)
	print("OnEvent_120_2 begin")

	--122番イベントの条件とハンドルを削除 --EN:--Removed the condition and handle of the 122nd event
	proxy:DeleteEvent( 122 );
	
	--OBJ(508)回転アニメ再生 --EN:--OBJ(508) rotating animation playback
	proxy:PlayAnimation( 508, 2 );
	
	--▼120_3▼***条件追加***回転アニメ終了▼ --EN:--▼120_3▼***Condition added***Rotation animation finished▼
	proxy:OnCharacterAnimEnd( 123, 508, 2, "OnEvent_120_3", once );
	
	print("OnEvent_120_2 end")
end

--▲120_3▲回転アニメ終了▲ --EN:--▲120_3▲End of rotation animation▲
function OnEvent_120_3(proxy, param)
	print("OnEvent_120_3 begin")
	
	--123番イベントの条件とハンドルを削除 --EN:--Removed the condition and handle of the 123rd event
	proxy:DeleteEvent( 123 );
	
	--▼120▼***条件追加***PCがハンドル(506)に対して反応角度(45)、角度オフセット(-90)、距離(150)でアクションボタンを押す▼ --EN:--▼120▼***Condition added***PC presses action button at reaction angle (45), angle offset (-90), distance (150) to handle (506)▼
	proxy:RepeatMessage_begin();
		proxy:OnDistanceAction( 120, 10000, 506, "OnEvent_120", 1.5, HELPID_START, -90.0, 45.0, once );
	proxy:RepeatMessage_end();
	
	--▼130▼***条件追加***PCがOBJ(508)に対して反応角度(90)、角度オフセット(0)、座標オフセット(0, 0, 2.1)距離(140)でアクションボタンを押す▼ --EN:--▼130▼*** Added condition ***PC responds to OBJ(508) with angle(90), angle offset(0), coordinate offset(0, 0, 2.1) distance(140) and action button Press▼
	proxy:RepeatMessage_begin();
		proxy:OnDistanceActionPlus( 130, 10000, 508, "OnEvent_130", 1.4, HELPID_START, 0, 90.0, 0.0, 0.0, 2.1, once );
	proxy:RepeatMessage_end();

	print("OnEvent_120_3 end")
end

--▲120_4▲プレイヤーハンドルアニメ終了▲ --EN:--▲120_4▲End of player handle animation▲
function OnEvent_120_4(proxy, param)
	print("OnEvent_120_4 begin")
	
	--旋回と移動を有効にする --EN:--Enable turn and move
	proxy:DisableMove(10000,0);
	
	print("OnEvent_120_4 end")
end








--------------------------------------------------------------------------------------
--テスト回転後OBJのレバーアニメ■130 --EN:--Lever animation of OBJ after test rotation ■130
--------------------------------------------------------------------------------------
--■130■テスト回転後OBJのレバーアニメ■ --EN:--■ 130 ■ Lever animation of OBJ after test rotation ■
function OnEvent_130(proxy, param)
	print("OnEvent_130 begin");
	
	--プレイヤーのレバーを引くアニメ再生 --EN:--Animation playback by pulling the player's lever
	proxy:PlayAnimation(10000, 8000);
	
	--OBJ(508)のレバーアニメ再生 --EN:--Play lever animation of OBJ(508)
	proxy:PlayAnimation(508, 1);
	
	--130番イベントの条件とハンドルを削除 --EN:--Removed the condition and handle of the 130th event
	proxy:DeleteEvent(130);
	
	--旋回と移動を止める --EN:--stop turning and moving
	proxy:DisableMove(10000,1);
	
	proxy:SetColiEnable( 508, false );
	
	--プレイヤーをOBJ(508)のダミポリ(1)位置へワープ --EN:--Warp player to OBJ(508) Damipoly(1)
	proxy:WarpDmy( 10000, 508, 1 );

	--▼130_1▼***条件追加***プレイヤーのレバー引きアニメ終了▼ --EN:--▼130_1▼***Condition added***Player's lever pull animation ends▼
	proxy:OnChrAnimEnd( 131, 10000, 8000, "OnEvent_130_1", once );
	
	--▼130_2▼***条件追加***レバーアニメ終了▼ --EN:--▼130_2▼***Condition added***Lever animation ends▼
	proxy:OnCharacterAnimEnd( 132, 508, 1, "OnEvent_130_2", once );

	print("OnEvent_130 end");
end

--▲130_1▲プレイヤーのレバー引きアニメ終了▲ --EN:--▲130_1▲The player pulls the lever animation.▲
function OnEvent_130_1(proxy, param)
	print("OnEvent_130_1 begin");
	
	--131番イベントの条件とハンドルを削除 --EN:--Removed the condition and handle of the 131st event
	proxy:DeleteEvent(131);
	
	--旋回と移動を有効にする --EN:--Enable turn and move
	proxy:DisableMove(10000,0);
	
	print("OnEvent_130_1 end");
end

--▲130_2▲レバーアニメ終了▲ --EN:--▲130_2▲Lever animation ends▲
function OnEvent_130_2(proxy, param)
	print("OnEvent_130_2 begin");
	
	--132番イベントの条件とハンドルを削除 --EN:--Removed the condition and handle of the 132nd event
	proxy:DeleteEvent(132);
	
	proxy:SetColiEnable( 508, true );
	
	--▼130▼***条件追加***PCがOBJ(508)に対して反応角度(90)、角度オフセット(0)、座標オフセット(0, 0, 2.1)距離(140)でアクションボタンを押す▼ --EN:--▼130▼*** Added condition ***PC responds to OBJ(508) with angle(90), angle offset(0), coordinate offset(0, 0, 2.1) distance(140) and action button Press▼
	proxy:RepeatMessage_begin();
		proxy:OnDistanceActionPlus( 130, 10000, 508, "OnEvent_130", 1.4, HELPID_PULL_LEVER, 0, 90.0, 0.0, 0.0, 2.1, once );
	proxy:RepeatMessage_end();
	
	print("OnEvent_130_2 end");
end














--------------------------------------------------------------------------------------
--テスト連動アニメ■140 --EN:-- Test-linked animation ■ 140
--------------------------------------------------------------------------------------
--■140■テスト連動アニメ■ --EN:-- ■ 140 ■ test animation ■
function OnEvent_140(proxy, param)
	print("OnEvent_140 begin")
	
	--140番イベントの条件とハンドルを削除 --EN:--Removed the condition and handle of the 140th event
	proxy:DeleteEvent( 140 );
	
	--アニメ１再生 --EN:--animation 1 playback
	proxy:PlayAnimation( 503, 1 );
	
	--▼140_2▼***条件追加***アニメ１終了▼ --EN:--▼140_2▼***Condition added***End of animation 1▼
	proxy:OnCharacterAnimEnd( 142, 503, 1, "OnEvent_140_2", once );
	
	--プレイヤーをポイント(2005)へワープ --EN:--Warp player to point (2005)
	proxy:Warp( 10000, 2005);
	
	--旋回と移動を止める --EN:--stop turning and moving
	proxy:DisableMove(10000,1);
	
	--プレイヤーのレバーアニメ再生 --EN:-- Player's lever animation playback
	proxy:PlayAnimation( 10000, 8000 );
	
	--▼140_1▼***条件追加***プレイヤーのレバー引きアニメ終了▼ --EN:--▼140_1▼***Condition added***Player's lever pull animation ends▼
	proxy:RepeatMessage_begin();
		proxy:OnChrAnimEnd( 141, 10000, 8000, "OnEvent_140_1", once );
	proxy:RepeatMessage_end();
	
	print("OnEvent_504 end")
end

--▲140_1▲プレイヤーのレバー引きアニメ終了▲ --EN:--▲140_1▲The player pulls the lever animation.▲
function OnEvent_140_1(proxy, param)
	print("OnEvent_140_1 end")

	--旋回と移動を有効にする --EN:--Enable turn and move
	proxy:DisableMove(10000,0);
	
	--141番イベントの条件とハンドルを削除 --EN:--Removed the condition and handle of the 141st event
	proxy:DeleteEvent(141);
	
	print("OnEvent_140_1 end")
end

--▲140_2▲アニメ１終了▲ --EN:--▲140_2▲End of animation 1▲
function OnEvent_140_2(proxy, param)
	print("OnEvent_140_2 begin")
	
	--142番イベントの条件とハンドルを削除 --EN:--Removed the condition and handle of the 142nd event
	proxy:DeleteEvent(142);
	
	--▼140_3▼***条件追加***1秒後▼ --EN:--▼140_3▼***Condition added***After 1 second▼
	proxy:OnKeyTime2( 143, "OnEvent_140_3", 1.0, 0, 0, once );
	
	print("OnEvent_140_2 end")
end

--▲140_3▲1秒後▲ --EN:--▲140_3▲After 1 second▲
function OnEvent_140_3(proxy, param)
	print("OnEvent_140_3 begin")

	--143番イベントの条件とハンドルを削除 --EN:--Removed the condition and handle of the 143rd event
	proxy:DeleteEvent(143);
	
	--アニメ２再生 --EN:--Play animation 2
	proxy:PlayAnimation( 503, 2 );
	
	--▼140_4▼***条件追加***アニメ２終了▼ --EN:--▼140_4▼***Condition added***Animation 2 ends▼
	proxy:OnCharacterAnimEnd( 144, 503, 2, "OnEvent_140_4", once );
	
	print("OnEvent_140_3 end")
end

--▲140_4▲アニメ２終了▲ --EN:--▲140_4▲End of animation 2▲
function OnEvent_140_4(proxy, param)
	print("OnEvent_140_4 begin");
	
	--144番イベントの条件とハンドルを削除 --EN:--Remove condition and handle of 144th event
	proxy:DeleteEvent(144);
	
	--▼140_5▼***条件追加***1秒後▼ --EN:--▼140_5▼***Condition added***After 1 second▼
	proxy:OnKeyTime2( 145, "OnEvent_140_5", 1.0, 0, 1, once );
	
	print("OnEvent_140_4 end");
end

--▲140_5▲1秒後▲ --EN:--▲140_5▲After 1 second▲
function OnEvent_140_5(proxy, param)
	print("OnEvent_140_5 begin");
	
	--145番イベントの条件とハンドルを削除 --EN:--Removed the condition and handle of the 145th event
	proxy:DeleteEvent(145);
	
	--アニメ３再生 --EN:--Play animation 3
	proxy:PlayAnimation( 503, 3 );
	
	--▼140_2▼***条件追加***アニメ３終了▼ --EN:--▼140_2▼***Condition added***Animation 3 ends▼
	proxy:OnCharacterAnimEnd( 146, 503, 3, "OnEvent_140_6", once );
	
	print("OnEvent_140_5 end");
end

--▲140_6▲アニメ３終了▲ --EN:--▲140_6▲End of animation 3▲
function OnEvent_140_6(proxy, param)
	print("OnEvent_140_6 begin");
	
	--146番イベントの条件とハンドルを削除 --EN:--Removed the condition and handle of the 146th event
	proxy:DeleteEvent(146);
	proxy:RepeatMessage_begin();
		proxy:OnDistanceActionPlus( 140, 10000, 503, "OnEvent_140", 1.4, HELPID_PULL_LEVER, 0, 90.0, 0.0, 0.0, 2.1, once );
	proxy:RepeatMessage_end();
	print("OnEvent_140_6 end");
end




--------------------------------------------------------------------------------------
--リフトレバー下　引く■150 --EN:-- Pull down the lift lever ■ 150
--------------------------------------------------------------------------------------
--■150■リフトレバー下　引く■ --EN:-- ■ 150 ■ Lower lift lever Pull ■
function OnEvent_150(proxy, param)
	print("OnEvent_150 begin");
	
	--150番イベントの条件とハンドルを削除 --EN:--Removed the condition and handle of the 150th event
	proxy:DeleteEvent( 150 );
	
	--165番イベントの条件とハンドルを削除 --EN:--Removed the condition and handle of the 165th event
	proxy:DeleteEvent( 165 );

	--レバー引きアニメ再生 --EN:--Lever pull animation playback
	proxy:PlayAnimation( 510, 1 );
	
	--レバー押すアニメ再生(ダミー) --EN:--Play animation by pushing lever (dummy)
	proxy:PlayAnimation( 511, 1 );

	--プレイヤーのレバー引きアニメ再生 --EN:-- Player's lever pull animation playback
	proxy:PlayAnimation( 10000, 8000 );
	
	--▼150_1▼***条件追加***レバー引くアニメ終了▼ --EN:--▼150_1▼***Condition added***Animation ends when the lever is pulled▼
	proxy:OnCharacterAnimEnd( 151, 510, 1, "OnEvent_150_1", once );
	
	print("OnEvent_150 end");
end

--▲150_1▲レバー引くアニメ終了▲ --EN:--▲150_1▲The animation ends when the lever is pulled▲
function OnEvent_150_1(proxy, param)
	print("OnEvent_150_1 begin");
	
	--151番イベントの条件とハンドルを削除 --EN:--Remove condition and handle of 151st event
	proxy:DeleteEvent( 151 );

	--ループアニメ切り替え --EN:--Loop animation switching
	proxy:PlayLoopAnimation( 509, 1 );

	--▼155▼***条件追加***リフトレバー押す▼ --EN:--▼155▼***Condition added***Press the lift lever▼
	proxy:RepeatMessage_begin();
		proxy:OnDistanceAction( 155, 10000, 510, "OnEvent_155", 1.5, HELPID_START, 0, 30, once);
	proxy:RepeatMessage_end();
	
	--▼160▼***条件追加***リフトレバー引き▼ --EN:--▼160▼***Condition added***Lift lever pull▼
	proxy:RepeatMessage_begin();
		proxy:OnDistanceAction( 160, 10000, 511, "OnEvent_160", 1.5, HELPID_START, 0, 30, once);
	proxy:RepeatMessage_end();
	
	print("OnEvent_150_1 end");
end

--------------------------------------------------------------------------------------
--リフトレバー下　押す■155 --EN:--Lower lift lever Press ■ 155
--------------------------------------------------------------------------------------
--■155■リフトレバー下　押す■ --EN:-- ■ 155 ■ Lower lift lever Press ■
function OnEvent_155(proxy, param)
	print("OnEvent_155 begin");
	
	--155番イベントの条件とハンドルを削除 --EN:--Removed the condition and handle of the 155th event
	proxy:DeleteEvent( 155 );
	
	--160番イベントの条件とハンドルを削除 --EN:--Removed the condition and handle of the 160th event
	proxy:DeleteEvent( 160 );
	
	--レバー押すアニメ再生(ダミー) --EN:--Play animation by pushing lever (dummy)
	proxy:PlayAnimation( 510, 1 );
	
	--レバー引きアニメ再生 --EN:--Lever pull animation playback
	proxy:PlayAnimation( 511, 1 );
	
	--プレイヤーのレバー押すアニメ再生 --EN:--Animation playback by pressing the player's lever
	proxy:PlayAnimation( 10000, 8000 );
	
	--▼155_1▼***条件追加***レバー押すアニメ終了▼ --EN:--▼155_1▼***Condition added***End animation by pressing the lever▼
	proxy:OnCharacterAnimEnd( 156, 510, 1, "OnEvent_155_1", once );
	
	print("OnEvent_155 end");
end

--▲155_1▲レバー押すアニメ終了▲ --EN:--▲155_1▲Press the lever to end the animation▲
function OnEvent_155_1(proxy, param)
	print("OnEvent_155_1 begin");
	
	--153番イベントの条件とハンドルを削除 --EN:--Removed the condition and handle of the 153rd event
	proxy:DeleteEvent( 156 );

	--ループアニメ切り替え --EN:--Loop animation switching
	proxy:PlayLoopAnimation( 509, 2 );

	--▼150▼***条件追加***リフトレバー引く▼ --EN:--▼150▼***Condition added***Pull the lift lever▼
	proxy:RepeatMessage_begin();
		proxy:OnDistanceAction( 150, 10000, 510, "OnEvent_150", 1.5, HELPID_START, 0, 30, once);	
	--▼165▼***条件追加***リフトレバー押す▼	 --EN:--▼165▼***Condition added***Press the lift lever▼
		proxy:OnDistanceAction( 165, 10000, 511, "OnEvent_165", 1.5, HELPID_START, 0, 30, once);
	proxy:RepeatMessage_end();	
	
	print("OnEvent_155_1 end");
end

--------------------------------------------------------------------------------------
--リフトレバー上　引く■160 --EN:--Pull on the lift lever ■ 160
--------------------------------------------------------------------------------------
--■160■リフトレバー上　引く■ --EN:-- ■ 160 ■ lift lever upper pull ■
function OnEvent_160(proxy, param)
	print("OnEvent_160 begin");
	
	--160番イベントの条件とハンドルを削除 --EN:--Removed the condition and handle of the 160th event
	proxy:DeleteEvent( 160 );
	
	--152番イベントの条件とハンドルを削除 --EN:--Removed the condition and handle of the 152nd event
	proxy:DeleteEvent( 155 );

	--レバー引きアニメ再生 --EN:--Lever pull animation playback
	proxy:PlayAnimation( 511, 1 );
	
	--レバー押すアニメ再生(ダミー) --EN:--Play animation by pushing lever (dummy)
	proxy:PlayAnimation( 510, 1 );

	--プレイヤーのレバー引きアニメ再生 --EN:-- Player's lever pull animation playback
	proxy:PlayAnimation( 10000, 8000 );
	
	--▼160_1▼***条件追加***レバー引くアニメ終了▼ --EN:--▼160_1▼***Condition added***Animation ends when the lever is pulled▼
	proxy:OnCharacterAnimEnd( 161, 511, 1, "OnEvent_160_1", once );
	
	print("OnEvent_160 end");
end

--▲160_1▲レバー引くアニメ終了▲ --EN:--▲160_1▲The animation ends when the lever is pulled▲
function OnEvent_160_1(proxy, param)
	print("OnEvent_160_1 begin");
	
	--161番イベントの条件とハンドルを削除 --EN:--Remove condition and handle of 161st event
	proxy:DeleteEvent( 161 );

	--ループアニメ切り替え --EN:--Loop animation switching
	proxy:PlayLoopAnimation( 509, 2 );

	--▼160▼***条件追加***リフトレバー押す▼ --EN:--▼160▼***Condition added***Press the lift lever▼
	proxy:RepeatMessage_begin();
		proxy:OnDistanceAction( 165, 10000, 511, "OnEvent_165", 1.5, HELPID_START, 0, 30, once);
	
	--▼150▼***条件追加***リフトレバー引き▼ --EN:--▼150▼***Condition added***Lift lever pull▼
		proxy:OnDistanceAction( 150, 10000, 510, "OnEvent_150", 1.5, HELPID_START, 0, 30, once);
	proxy:RepeatMessage_end();
	
	print("OnEvent_160_1 end");
end

--------------------------------------------------------------------------------------
--リフトレバー上　押す■165 --EN:-- Push the lift lever up ■ 165
--------------------------------------------------------------------------------------
--■165■リフトレバー上　押す■ --EN:-- ■ 165 ■ Lift lever up Push ■
function OnEvent_165(proxy, param)
	print("OnEvent_165 begin");
	
	--162番イベントの条件とハンドルを削除 --EN:--Removed the condition and handle of the 162nd event
	proxy:DeleteEvent( 165 );
	
	--150番イベントの条件とハンドルを削除 --EN:--Removed the condition and handle of the 150th event
	proxy:DeleteEvent( 150 );
	
	--レバー押すアニメ再生(ダミー) --EN:--Play animation by pushing lever (dummy)
	proxy:PlayAnimation( 511, 1 );
	
	--レバー引きアニメ再生 --EN:--Lever pull animation playback
	proxy:PlayAnimation( 510, 1 );
	
	--プレイヤーのレバー押すアニメ再生(ダミー) --EN:--Play animation by pressing the player's lever (dummy)
	proxy:PlayAnimation( 10000, 8000 );
	
	--▼165_1▼***条件追加***レバー押すアニメ終了▼ --EN:--▼165_1▼***Condition added***End animation by pressing the lever▼
	proxy:OnCharacterAnimEnd( 166, 511, 1, "OnEvent_165_1", once );
	
	print("OnEvent_165 end");
end

--▲165_1▲レバー押すアニメ終了▲ --EN:--▲165_1▲Press the lever to end the animation▲
function OnEvent_165_1(proxy, param)
	print("OnEvent_165_1 begin");
	
	--166番イベントの条件とハンドルを削除 --EN:--Removed the condition and handle of the 166th event
	proxy:DeleteEvent( 166 );

	--ループアニメ切り替え --EN:--Loop animation switching
	proxy:PlayLoopAnimation( 509, 1 );

	--▼160▼***条件追加***リフトレバー引く▼ --EN:--▼160▼***Condition added***Pull the lift lever▼
	proxy:RepeatMessage_begin();
		proxy:OnDistanceAction( 160, 10000, 511, "OnEvent_160", 1.5, HELPID_START, 0, 30, once);
	
		--▼155▼***条件追加***リフトレバー押す▼ --EN:--▼155▼***Condition added***Press the lift lever▼
		proxy:OnDistanceAction( 155, 10000, 510, "OnEvent_155", 1.5, HELPID_START, 0, 30, once);
	proxy:RepeatMessage_end();
	
	print("OnEvent_165_1 end");
end


--■1100■宝箱A:調べる■ --EN:-- ■ 1100 ■ Treasure box A: Examine ■
function OnEvent_1100(proxy, param)
	print("OnEvent_1100 begin");

	--同期アニメーション用のイベント --EN:--event for synchronous animation
	proxy:LuaCallStart( 4010 , 1 );

	proxy:NotNetMessage_begin();
		--0.0秒後にアイテム取得イベントを発行 --EN:-- Issue an item acquisition event after 0.0 seconds
		proxy:OnKeyTime2( 1100, "OnEvent_1100_1", 0.0, 0, 0, once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_1100 end");
end

--■1100_1■宝箱A：アイテム表現■ --EN:--■1100_1 ■Treasure box A: Item expression■
function OnEvent_1100_1(proxy, param)
	print("OnEvent_1100_1 begin");

	--アイテム取得関数--パラメータ10000参照 --EN:--Item acquisition function--Refer to parameter 10000
	--proxy:GetRateItem(10000);
	-- 一時的に抽選無し固定アイテム取得に変更 --EN:-- Temporarily change to get fixed items without lottery
	--proxy:AddInventoryItem( 160000, TYPE_WEAPON, 50 );
	--proxy:GetItem( 160000, TYPE_WEAPON );
	proxy:InfomationMenu( INFOMENU_TYPE_LIST, 0, MSG_CATEGORY_EVENT, 0, 1);
	proxy:AddInfomationListRateItem( 10000 );
	proxy:AddInfomationListRateItem( 10000 );
	proxy:AddInfomationListRateItem( 10000 );
	proxy:AddInfomationListRateItem( 10000 );
	proxy:AddInfomationListRateItem( 10000 );
	proxy:AddInfomationListRateItem( 10100 );
	proxy:AddInfomationListRateItem( 10100 );
	proxy:AddInfomationListRateItem( 10100 );
	proxy:AddInfomationListRateItem( 10100 );
--[[
	proxy:AddInfomationListItem( MSG_CATEGORY_WEP, 10000, 70 );
	proxy:AddInfomationListItem( MSG_CATEGORY_WEP, 10100, 20 );
	proxy:AddInfomationListItem( MSG_CATEGORY_WEP, 10200, 31 );
	proxy:AddInfomationListItem( MSG_CATEGORY_WEP, 10300,  9 );
	proxy:AddInfomationListItem( MSG_CATEGORY_WEP, 20300, 29 );
	proxy:AddInfomationListItem( MSG_CATEGORY_WEP, 20000, 13 );
	proxy:AddInfomationListItem( MSG_CATEGORY_WEP, 20100,  2 );
	proxy:AddInfomationListItem( MSG_CATEGORY_WEP, 20200,  5 );
	proxy:AddInfomationListItem( MSG_CATEGORY_WEP, 20500, 46 );
]]	
	--アイテムを取得済み --EN:--item already acquired
	proxy:SetEventFlag( 1100, 1 );
	--宝が光っているのを消す --EN:--Turn off glowing treasure
	proxy:TreasureDispModeChange( 1100, false );
	
	print("OnEvent_1100_1 end");
end

--■1101■宝箱A:調べる■ --EN:-- ■ 1101 ■ Treasure box A: Examine ■
function OnEvent_1101(proxy, param)
	print("OnEvent_1101 begin");

	--同期アニメーション用のイベント --EN:--event for synchronous animation
	proxy:LuaCallStart( 4010 , 1 );

	proxy:NotNetMessage_begin();
		--0.0秒後にアイテム取得イベントを発行 --EN:-- Issue an item acquisition event after 0.0 seconds
		proxy:OnKeyTime2( 1101, "OnEvent_1101_1", 0.0, 0, 0, once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_1101 end");
end

--■1101_1■宝箱A：アイテム表現■ --EN:--■1101_1 ■Treasure box A: Item expression■
function OnEvent_1101_1(proxy, param)
	print("OnEvent_1101_1 begin");
	--アイテム取得関数--パラメータ10001参照 --EN:--item acquisition function--see parameter 10001
	proxy:GetRateItem(10001);
	proxy:GetRateItem(10002);
	proxy:GetRateItem(10003);
	proxy:GetRateItem(10004);
	
	--アイテムを取得済み --EN:--item already acquired
	proxy:SetEventFlag( 1101, 1 );
	--宝が光っているのを消す --EN:--Turn off glowing treasure
	proxy:TreasureDispModeChange( 1101, false );
	
	print("OnEvent_1101_1 end");
end

--■1102■宝箱A:調べる■ --EN:-- ■ 1102 ■ Treasure box A: Examine ■
function OnEvent_1102(proxy, param)
	print("OnEvent_1102 begin");

	--同期アニメーション用のイベント --EN:--event for synchronous animation
	proxy:LuaCallStart( 4010 , 1 );

	proxy:NotNetMessage_begin();
		--0.0秒後にアイテム取得イベントを発行 --EN:-- Issue an item acquisition event after 0.0 seconds
		proxy:OnKeyTime2( 1102, "OnEvent_1102_1", 0.0, 0, 0, once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_1102 end");
end

--■1102_1■宝箱A：アイテム表現■ --EN:--■1102_1 ■Treasure box A: Item expression■
function OnEvent_1102_1(proxy, param)
	print("OnEvent_1102_1 begin");

	--アイテム取得関数--パラメータ10002参照 --EN:-- get item function -- see parameter 10002
	proxy:GetRateItem(10002);
	
	--アイテムを取得済み --EN:--item already acquired
	proxy:SetEventFlag( 1102, 1 );
	--宝が光っているのを消す --EN:--Turn off glowing treasure
	proxy:TreasureDispModeChange( 1102, false );
	
	print("OnEvent_1102_1 end");
end

--■1103■宝箱A:調べる■ --EN:-- ■ 1103 ■ Treasure box A: Examine ■
function OnEvent_1103(proxy, param)
	print("OnEvent_1103 begin");

	--同期アニメーション用のイベント --EN:--event for synchronous animation
	proxy:LuaCallStart( 4010 , 1 );

	proxy:NotNetMessage_begin();
		--0.0秒後にアイテム取得イベントを発行 --EN:-- Issue an item acquisition event after 0.0 seconds
		proxy:OnKeyTime2( 1103, "OnEvent_1103_1", 0.0, 0, 0, once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_1103 end");
end

--■1103_1■宝箱A：アイテム表現■ --EN:--■1103_1 ■Treasure box A: Item expression■
function OnEvent_1103_1(proxy, param)
	print("OnEvent_1103_1 begin");

	--アイテム取得関数--パラメータ10003参照 --EN:-- get item function -- see parameter 10003
	proxy:GetRateItem(10003);
	
	--アイテムを取得済み --EN:--item already acquired
	proxy:SetEventFlag( 1103, 1 );
	--宝が光っているのを消す --EN:--Turn off glowing treasure
	proxy:TreasureDispModeChange( 1103, false );
	
	print("OnEvent_1103_1 end");
end

--■1104■宝箱A:調べる■ --EN:-- ■ 1104 ■ Treasure box A: Examine ■
function OnEvent_1104(proxy, param)
	print("OnEvent_1104 begin");

	--同期アニメーション用のイベント --EN:--event for synchronous animation
	proxy:LuaCallStart( 4010 , 1 );

	proxy:NotNetMessage_begin();
		--0.0秒後にアイテム取得イベントを発行 --EN:-- Issue an item acquisition event after 0.0 seconds
		proxy:OnKeyTime2( 1104, "OnEvent_1104_1", 0.0, 0, 0, once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_1104 end");
end

--■1104_1■宝箱A：アイテム表現■ --EN:--■1104_1 ■Treasure box A: Item expression■
function OnEvent_1104_1(proxy, param)
	print("OnEvent_1104_1 begin");

	--アイテム取得関数--パラメータ10004参照 --EN:-- get item function -- see parameter 10004
	proxy:GetRateItem(10004);
	
	--アイテムを取得済み --EN:--item already acquired
	proxy:SetEventFlag( 1104, 1 );
	--宝が光っているのを消す --EN:--Turn off glowing treasure
	proxy:TreasureDispModeChange( 1104, false );
	
	print("OnEvent_1104_1 end");
end

--■1105■宝箱A:調べる■ --EN:-- ■ 1105 ■ Treasure box A: Examine ■
function OnEvent_1105(proxy, param)
	print("OnEvent_1105 begin");

	--同期アニメーション用のイベント --EN:--event for synchronous animation
	proxy:LuaCallStart( 4010 , 1 );

	proxy:NotNetMessage_begin();
		--0.0秒後にアイテム取得イベントを発行 --EN:-- Issue an item acquisition event after 0.0 seconds
		proxy:OnKeyTime2( 1105, "OnEvent_1105_1", 0.0, 0, 0, once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_1105 end");
end

--■1105_1■宝箱A：アイテム表現■ --EN:--■1105_1 ■Treasure box A: Item expression■
function OnEvent_1105_1(proxy, param)
	print("OnEvent_1105_1 begin");

	--アイテム取得関数--パラメータ10005参照 --EN:-- get item function -- see parameter 10005
	proxy:GetRateItem(10005);
	
	--アイテムを取得済み --EN:--item already acquired
	proxy:SetEventFlag( 1105, 1 );
	--宝が光っているのを消す --EN:--Turn off glowing treasure
	proxy:TreasureDispModeChange( 1105, false );
	
	print("OnEvent_1105_1 end");
end

--■1106■宝箱A:調べる■ --EN:-- ■ 1106 ■ Treasure box A: Examine ■
function OnEvent_1106(proxy, param)
	print("OnEvent_1106 begin");

	--同期アニメーション用のイベント --EN:--event for synchronous animation
	proxy:LuaCallStart( 4010 , 1 );

	proxy:NotNetMessage_begin();
		--0.0秒後にアイテム取得イベントを発行 --EN:-- Issue an item acquisition event after 0.0 seconds
		proxy:OnKeyTime2( 1106, "OnEvent_1106_1", 0.0, 0, 0, once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_1106 end");
end

--■1106_1■宝箱A：アイテム表現■ --EN:--■1106_1 ■Treasure box A: Item expression■
function OnEvent_1106_1(proxy, param)
	print("OnEvent_1106_1 begin");

	--アイテム取得関数--パラメータ10006参照 --EN:--item acquisition function--see parameter 10006
	proxy:GetRateItem(10006);
	
	--アイテムを取得済み --EN:--item already acquired
	proxy:SetEventFlag( 1106, 1 );
	--宝が光っているのを消す --EN:--Turn off glowing treasure
	proxy:TreasureDispModeChange( 1106, false );
	
	print("OnEvent_1106_1 end");
end

--■1107■宝箱A:調べる■ --EN:-- ■ 1107 ■ Treasure box A: Examine ■
function OnEvent_1107(proxy, param)
	print("OnEvent_1107 begin");

	--同期アニメーション用のイベント --EN:--event for synchronous animation
	proxy:LuaCallStart( 4010 , 1 );

	proxy:NotNetMessage_begin();
		--0.0秒後にアイテム取得イベントを発行 --EN:-- Issue an item acquisition event after 0.0 seconds
		proxy:OnKeyTime2( 1107, "OnEvent_1107_1", 0.0, 0, 0, once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_1107 end");
end

--■1107_1■宝箱A：アイテム表現■ --EN:--■1107_1 ■Treasure box A: Item expression■
function OnEvent_1107_1(proxy, param)
	print("OnEvent_1107_1 begin");

	--アイテム取得関数--パラメータ10007参照 --EN:-- get item function -- see parameter 10007
	proxy:GetRateItem(10007);
	
	--アイテムを取得済み --EN:--item already acquired
	proxy:SetEventFlag( 1107, 1 );
	--宝が光っているのを消す --EN:--Turn off glowing treasure
	proxy:TreasureDispModeChange( 1107, false );
	
	print("OnEvent_1107_1 end");
end

--■1108■宝箱A:調べる■ --EN:-- ■ 1108 ■ Treasure box A: Examine ■
function OnEvent_1108(proxy, param)
	print("OnEvent_1108 begin");

	--同期アニメーション用のイベント --EN:--event for synchronous animation
	proxy:LuaCallStart( 4010 , 1 );

	proxy:NotNetMessage_begin();
		--0.0秒後にアイテム取得イベントを発行 --EN:-- Issue an item acquisition event after 0.0 seconds
		proxy:OnKeyTime2( 1108, "OnEvent_1108_1", 0.0, 0, 0, once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_1108 end");
end

--■1108_1■宝箱A：アイテム表現■ --EN:--■1108_1 ■Treasure box A: Item expression■
function OnEvent_1108_1(proxy, param)
	print("OnEvent_1108_1 begin");

	--アイテム取得関数--パラメータ10100参照 --EN:--item retrieval function--see parameter 10100
	proxy:GetRateItem(10100);
	
	--アイテムを取得済み --EN:--item already acquired
	proxy:SetEventFlag( 1108, 1 );
	--宝が光っているのを消す --EN:--Turn off glowing treasure
	proxy:TreasureDispModeChange( 1108, false );
	
	print("OnEvent_1108_1 end");
end

--■1109■宝箱A:調べる■ --EN:-- ■ 1109 ■ Treasure box A: Examine ■
function OnEvent_1109(proxy, param)
	print("OnEvent_1109 begin");

	--同期アニメーション用のイベント --EN:--event for synchronous animation
	proxy:LuaCallStart( 4010 , 1 );

	proxy:NotNetMessage_begin();
		--0.0秒後にアイテム取得イベントを発行 --EN:-- Issue an item acquisition event after 0.0 seconds
		proxy:OnKeyTime2( 1109, "OnEvent_1109_1", 0.0, 0, 0, once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_1109 end");
end

--■1109_1■宝箱A：アイテム表現■ --EN:--■1109_1 ■Treasure box A: Item expression■
function OnEvent_1109_1(proxy, param)
	print("OnEvent_1109_1 begin");

	--アイテム取得関数--パラメータ10101参照 --EN:--item retrieval function--see parameter 10101
	proxy:GetRateItem(10101);
	
	--アイテムを取得済み --EN:--item already acquired
	proxy:SetEventFlag( 1109, 1 );
	--宝が光っているのを消す --EN:--Turn off glowing treasure
	proxy:TreasureDispModeChange( 1109, false );
	
	print("OnEvent_1109_1 end");
end

--■1110■宝箱A:調べる■ --EN:-- ■ 1110 ■ Treasure box A: Examine ■
function OnEvent_1110(proxy, param)
	print("OnEvent_1110 begin");

	--同期アニメーション用のイベント --EN:--event for synchronous animation
	proxy:LuaCallStart( 4010 , 1 );

	proxy:NotNetMessage_begin();
		--0.0秒後にアイテム取得イベントを発行 --EN:-- Issue an item acquisition event after 0.0 seconds
		proxy:OnKeyTime2( 1110, "OnEvent_1110_1", 0.0, 0, 0, once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_1110 end");
end

--■1110_1■宝箱A：アイテム表現■ --EN:--■1110_1 ■Treasure box A: Item expression■
function OnEvent_1110_1(proxy, param)
	print("OnEvent_1110_1 begin");

	--アイテム取得関数--パラメータ10102参照 --EN:--item acquisition function--see parameter 10102
	proxy:GetRateItem(10102);
	
	--アイテムを取得済み --EN:--item already acquired
	proxy:SetEventFlag( 1110, 1 );
	--宝が光っているのを消す --EN:--Turn off glowing treasure
	proxy:TreasureDispModeChange( 1110, false );
	
	print("OnEvent_1110_1 end");
end

--------------------------------------------------------------------------------------
--ショップテスト：■2000 --EN:--Shop test: ■2000
--------------------------------------------------------------------------------------
--■2000■ショップテスト■ --EN:-- ■ 2000 ■ Shop test ■
function OnEvent_2000(proxy, param)
	print("▼▼▼OnEvent_2000 begin▼▼▼"); --EN:print("▼▼▼OnEvent_2000 begin▼▼▼");
	proxy:SetTalkMsg( 0, true );
	print("▲▲▲OnEvent_2000 end▲▲▲"); --EN:print("▲▲▲OnEvent_2000 end▲▲▲");
end


--------------------------------------------------------------------------------------
--徘徊デーモンの登場■?? --EN:-- Appearance of the Wandering Demon ??
--------------------------------------------------------------------------------------

--▼グローバルの死亡監視から呼ばれる(ソロ) --EN:--▼ Called from global death watch (solo)
function PlayerDeath_m99_60_01_00(proxy, param)
	print("PlayerDeath_m99_60_01_00");
	
--	LuaFunc_VisibleTheWanderingDemon(proxy, param, demon_id_list_m99_60_01_00);
--	proxy:SetEventFlag( 20 , 1 );--フラグは仮、指定があれば変える。 --EN:The -- flag is tentative, and will be changed if specified.
	
	print("PlayerDeath_m99_60_01_00");
end

--▼グローバルの血文字復活から呼ばれる(ソロ) --EN:--▼Called from global blood letter revival (solo)
function PlayerRevive_m99_60_01_00(proxy,param)
	print("PlayerRevive_m99_60_01_00");
	
--	LuaFunc_InvisibleTheWanderingDemon(proxy, param, demon_id_list_m99_60_01_00);
--	proxy:SetEventFlag( 20 , 0 );--フラグは仮、指定があれば変える。 --EN:The -- flag is tentative, and will be changed if specified.
	
	print("PlayerRevive_m99_60_01_00");
end



function Talk_to_ItemInfo_test(proxy,param)
print("Talk_to_ItemInfo_test begin");
	proxy:InfomationMenu( INFOMENU_TYPE_LIST, 0, MSG_CATEGORY_EVENT, 0, 1);
	proxy:AddInfomationListItem( MSG_CATEGORY_WEP, 10000, 70 );
	proxy:AddInfomationListItem( MSG_CATEGORY_WEP, 10100, 20 );
	proxy:AddInfomationListItem( MSG_CATEGORY_WEP, 10200, 31 );
	proxy:AddInfomationListItem( MSG_CATEGORY_WEP, 10300,  9 );
	proxy:AddInfomationListItem( MSG_CATEGORY_WEP, 20300, 29 );
	proxy:AddInfomationListItem( MSG_CATEGORY_WEP, 20000, 13 );
	proxy:AddInfomationListItem( MSG_CATEGORY_WEP, 20100,  2 );
	proxy:AddInfomationListItem( MSG_CATEGORY_WEP, 20200,  5 );
	proxy:AddInfomationListItem( MSG_CATEGORY_WEP, 20500, 46 );
	
	--アイテムを取得済み --EN:--item already acquired
	proxy:SetEventFlag( 1000, 1 );
print("Talk_to_ItemInfo_test end");
end


--タル破壊 --EN:--barrel destruction
function OnEvent_2010(proxy,param)
	print("OnEvent_2010 begin");
	
	--レバーアニメ --EN:--lever animation
	proxy:PlayAnimation(2011,1);
	--■2001■アニメ監視■ --EN:-- ■ 2001 ■ Anime monitoring ■
	proxy:OnCharacterAnimEnd(2011,2011,1,"OnEvent_2011",once);
	
	print("OnEvent_2010 end");
end


--レバーアニメ監視 --EN:--Lever animation monitoring
function OnEvent_2011(proxy,param)
	print("OnEvent_2011 begin;");
	--■2002■宝死体監視■ --EN:-- ■ 2002 ■ Treasure corpse surveillance ■
	proxy:OnDistanceAction(2012,10000,2012,"OnEvent_2012",ItemBoxDist_A,HELPID_CHECK_GLOWING_CORPS,0,ItemBoxAngle_A,once);
	print("OnEvent_2011 end");
end


--宝死体監視 --EN:--Treasure Corpse Surveillance
function OnEvent_2012(proxy, param)
	print("OnEvent_2012 begin");

	--同期アニメーション用のイベント --EN:--event for synchronous animation
	proxy:LuaCallStart( 4010 , 1 );

	proxy:NotNetMessage_begin();
		--0.0秒後にアイテム取得イベントを発行 --EN:-- Issue an item acquisition event after 0.0 seconds
		proxy:OnKeyTime2( 2012, "OnEvent_2012_1", 0.0, 0, 0, once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_2012 end");
end

--■2012_1■宝箱A：アイテム表現■ --EN:--■2012_1 ■Treasure box A: Item expression■
function OnEvent_2012_1(proxy, param)
	print("OnEvent_2012_1 begin");

	--アイテム取得関数--パラメータ10100参照--テスト --EN:--get item function --parameter 10100 reference --test
	proxy:GetRateItem(10100);
	
	--アイテムを取得済み --EN:--item already acquired
	proxy:SetEventFlag( 2012, 1 );
	--宝が光っているのを消す --EN:--Turn off glowing treasure
	proxy:TreasureDispModeChange( 2012, false );
	
	print("OnEvent_2002_1 end");
end


function Check_3000(proxy,param)
	if proxy:IsEquip(TYPE_WEAPON,10000) == true then
		print("IsEquip　TYPE_WEAPON　 true"); --EN:print("IsEquip TYPE_WEAPON true");
		return true;
	end
	if proxy:IsEquip(TYPE_PROTECTER,101800) == true then
		print("IsEquip　TYPE_PROTECTER　 true"); --EN:print("IsEquip TYPE_PROTECTER true");
		return true;
	end
	if proxy:IsInventoryEquip(TYPE_WEAPON,21500) == true then
		print("レンドル王の剣持ってるよー"); --EN:print("I have King Lendl's sword");
		return true;
	end
	--print("IsEquip false");
	return false;
end


function OnEvent_3000(proxy,param)
	print("OnEvent_3000");	
end

--------------------------------------------------------------------------------------
--600■バリスタ開始イベント --EN:--600■ Barista start event
--------------------------------------------------------------------------------------
--バリスタイベント開始 --EN:--Start barista event
function OnEvent_600(proxy,param)

	if proxy:IsCompleteEvent(600) == true then
		return;
	end	
	if Luafunc_PlaySynchroAnimation(proxy,param,8100) == true then
		proxy:SetEventFlag(600,true);
		return;
	end
	
	print("OnEvent_600 begin");		
	proxy:EnableLogic(10000,false);
	--プレイヤーをOBJ(600)のダミポリ(191)位置へワープ --EN:--Warp player to OBJ(600) Damipoly(191) position
	proxy:WarpDmy( 10000, 600, 191 );
	proxy:NotNetMessage_begin();
		proxy:OnChrAnimEnd(600,10000,8100,"OnEvent_600_1",once);
	proxy:NotNetMessage_end();
	proxy:SetEventFlag(600,true);	
	print("OnEvent_600 end");
end

--プレイヤーアニメ終了後 --EN:--After player animation ends
function OnEvent_600_1(proxy,param)
	print("OnEvent_600_1 begin");
	proxy:LuaCallStart(600,2);
	print("OnEvent_600_1 end");
end

--ループアニメ開始 --EN:--Loop animation start
function OnEvent_600_2(proxy,param)
	print("OnEvent_600_2 begin");	
	--パーティーのプレイヤーがアニメーション --EN:--Party players animated
	if param:IsNetMessage() == true then 
		--バリスタにオーナー登録 --EN:--Owner registration with Barista
		proxy:SetBallista( 601,param:GetPlayID()+10001 );
		--発動キャラにループアニメ --EN:--Loop animation for activated character
		proxy:PlayLoopAnimation( param:GetPlayID()+10001 , 8110 );
		print("OnEvent_600_2 end");
		return;
	end
	--バリスタにオーナー登録 --EN:--Owner registration with Barista
	proxy:SetBallista(601,10000);
	--自分がアニメーション --EN:--animated by me
	proxy:PlayLoopAnimation( 10000 ,  8110);
	proxy:OnBallista(601,601,HELPID_REMOVE,-20,20,-100,100,5.0,2,2);
	print("OnEvent_600_2 end");
end

--------------------------------------------------------------------------------------
--601■バリスタ同期■ --EN:--601 ■ barista synchronization ■
--------------------------------------------------------------------------------------
--0	…SEアニメ同期 --EN:--0 …SE animation synchronization
function OnEvent_601_0(proxy,param)	
	--発射アニメ中じゃなければ --EN:--If it's not during the launch animation
	if proxy:IsEventAnim(601,1) == false then 
		proxy:PlayAnimation(601,2);		
	end
	if param:IsNetMessage() == true then
		if proxy:IsEventAnim(10000,1) == false then 
			proxy:PlayLoopAnimation( param:GetPlayID()+10001 , 8110 );		
			return;
		end
	end
end

--1	…角度同期 --EN:--1 … angle synchronization
function OnEvent_601_1(proxy,param)
	--発動者はじぶんで回転させてるので、受信者のみ同期 --EN:--Since the invoker rotates himself, only the recipient is synchronized
	if param:IsNetMessage() == true then
		proxy:ObjRot(601,param:GetPlayID()+10001,param:GetParam3());
	end
end

--2	…バリスタ発射同期 --EN:--2 … varistor firing synchronization
function OnEvent_601_2(proxy,param)
	print("OnEvent_601_2 begin");
	print("バリスタ発射アニメ再生"); --EN:print("Play ballista firing animation");
	--強制アニメ --EN:--forced animation
	proxy:ForcePlayAnimation(601,1);
	print("OnEvent_601_2 end");
end

--3	…バリスタ終了同期 --EN:--3 … Varistor end synchronization
function OnEvent_601_3(proxy,param)
	print("OnEvent_601_3 begin");
	print("バリスタ終了");	 --EN:print("Balista finished");
	if param:IsNetMessage() == true then
		proxy:StopLoopAnimation(param:GetPlayID()+10001);
		proxy:PlayAnimation( param:GetPlayID()+10001 , 8120 );
		print("OnEvent_601_3 end");		
		return;		
	end
	--プレイヤー離脱アニメ？ --EN:--Player withdrawal animation?
	proxy:StopLoopAnimation(10000);
	proxy:PlayAnimation(10000,8120);
	proxy:EnableLogic(10000,true);
	
	proxy:NotNetMessage_begin();
		proxy:RepeatMessage_begin();
			proxy:OnChrAnimEnd(601,10000,8120,"OnEvent_601_3_1",once);
		proxy:RepeatMessage_end();
	proxy:NotNetMessage_end();
	print("OnEvent_601_3 end");
end
--アニメ終了後のイベント --EN:--Events after the anime ends
function OnEvent_601_3_1(proxy,param)
	print("OnEvent_601_3_1 begin");
	print("発動者のみのイベント"); --EN:print("Triggerer-only event");
	--フラグ同期用のイベントを発行 --EN:-- Issue an event for flag synchronization
	proxy:LuaCallStart(601,5);	
	print("OnEvent_601_3_1 end");	
end

--4	…バリスタダメージ終了同期 --EN:--4 …Balista damage end synchronization
function OnEvent_601_4(proxy,param)
	print("OnEvent_601_4 begin");
	print("バリスタ終了");	 --EN:print("Balista finished");
	if param:IsNetMessage() == true then
		proxy:StopLoopAnimation(param:GetPlayID()+10001);		
		print("OnEvent_601_4 end");		
		return;		
	end
	proxy:StopLoopAnimation(10000);	
	proxy:EnableLogic(10000,true);
	
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2(601,"OnEvent_601_4_1",2,0,0,once);
	proxy:NotNetMessage_end();
	print("OnEvent_601_4 end");
end
--時間待ちのイベント --EN:--Time wait event
function OnEvent_601_4_1(proxy,param)
	print("OnEvent_601_4_1 begin");
	print("発動者のみのイベント"); --EN:print("Triggerer-only event");
	--フラグ同期用のイベントを発行 --EN:-- Issue an event for flag synchronization
	proxy:LuaCallStart(601,5);
	print("OnEvent_601_4_1 end");
end

--5	…バリスタフラグ同期用 --EN:--5 …For varistor flag synchronization
function OnEvent_601_5(proxy,param)
	print("OnEvent_601_5 begin");
	--バリスタオーナー解除 --EN:--Release barista owner
	proxy:SetBallista( 601,-1 );
	proxy:SetEventFlag(600,false);
	print("OnEvent_601_5 end");	
end


--アイテム削除テスト --EN:--item deletion test
function OnEvent_2100(proxy,param)
	print("OnEvent_2100 begin");
	proxy:RemoveInventoryEquip(TYPE_WEAPON,21500);
	print("レンドル王の剣削除しましたよ"); --EN:print("King Lendl's sword has been deleted");
	print("OnEvent_2100 end");
end


--カメラ切り替えテスト --EN:--Camera switching test
function OnEvent_1200(proxy,param)
	--ボスが生きていて　かつ　ボスとの戦闘が開始されているなら　カメラをボス用に切り替える --EN:--If the boss is alive and the battle with the boss has started, switch the camera to that of the boss
	--if proxy:IsCompleteEvent( ボス生死フラグ ) == false and proxy:IsCompleteEvent( 戦闘開始フラグ ) == true then --EN:--if proxy:IsCompleteEvent(boss life/death flag) == false and proxy:IsCompleteEvent(battle start flag) == true then
	--ボス戦　非ロックカメラ --EN:-- Boss battle unlocked camera
	proxy:SetCamModeParamTargetId(2021);
	--ボス戦　ロックカメラ --EN:--Boss battle rock camera
	proxy:SetCamModeParamTargetIdForBossLock(2020);
	--end
end

