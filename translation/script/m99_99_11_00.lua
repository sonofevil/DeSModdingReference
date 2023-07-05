once = 1;
everytime = 0;





function Initialize_m99_99_11_00(proxy)
print("Initialize m99_99_11_00 begin");


--[[▼チュートリアル用のイベント]] --EN:--[[▼Tutorial event]]



--■1000■ハシゴA(斜め10度)降り■ --EN:-- ■ 1000 ■ Ladder A (diagonal 10 degrees) descend ■
	proxy:OnActionEventRegion(1000, 2100, "OnEvent_1000", LadderAngle_A, HELPID_DOWN, everytime);
--■1001■ハシゴA(斜め10度)昇り■ --EN:-- ■ 1001 ■ Ladder A (diagonal 10 degrees) climbing ■
	proxy:OnActionEventRegion(1001, 2101, "OnEvent_1001", LadderAngle_A, HELPID_UP,   everytime);

	


	
--■6000■NPC会話■--汎用会話一挙登録(入力判定、可聴判定、範囲外判定)	※ValueBuffer　20010使 --EN:-- ■ 6000 ■ NPC conversation ■ -- general-purpose conversation all-at-once registration (input judgment, audible judgment, out-of-range judgment) * Using ValueBuffer 20010
	if proxy:IsCompleteEvent( 6000 ) == false then
		OnTalk(proxy,6000,101,TalkDist_N,TalkAngle_N,20010,HELPID_TALK,"OnEvent_6000","OnEvent_6000_1","OnEvent_6000_2",everytime);
		--■1103■NPC会話:PCから攻撃をされた処理■--NPC(101)がプレイヤーから攻撃された時 --EN:--■1103 ■NPC Conversation: Processing when attacked by PC ■--When NPC (101) is attacked by the player
		proxy:OnSimpleDamage(1103,101,10000,"OnEvent_1103",everytime);
		--■1101■NPC会話：死亡処理■--PCがイベントID101のHPを0にしたとき --EN:-- ■ 1101 ■ NPC conversation: death processing ■ -- When the PC reduces the HP of event ID 101 to 0
		proxy:OnCharacterHP(1101,101,"OnEvent_1101",0.0,once);
		--■1102■NPC会話：完全死亡処理■--イベントID101が完全に死んだとき --EN:-- ■ 1102 ■ NPC conversation: complete death process ■ -- When event ID 101 is completely dead
		proxy:OnCharacterDead(1102,101,"OnEvent_1102",once);
	end
	
		

--エリアリセットしないようにフラグ変えました。 --EN:--Changed the flag not to reset the area.

--■6020■扉を開ける■ --EN:-- ■ 6020 ■ open the door ■
--ＰＣが、イベントエリア(1)の中に居て、 --EN:--When the PC is in the event area (1),
--特定の角度を向いていて、 --EN:-- facing a certain angle,
--アクションボタンを押したとき --EN:--when you press the action button
	if proxy:IsCompleteEvent( 6020 ) == false then
		proxy:OnPlayerActionInRegionAngle( 6020, 1, "OnEvent_6020", 30, HELPID_PULL_LEVER, once);
	else
		proxy:EndAnimation( 1, 1 );--レバー --EN:--lever
		proxy:EndAnimation( 2, 1 );--扉 --EN:--door
	end

		
--エリアリセットしないようにフラグ変えました。 --EN:--Changed the flag not to reset the area.

--■6010■崩れる柱1 --EN:-- ■ 6010 ■ Collapsed Pillar 1
--・ＰＣ又はヘビ兵士（c0000/6010）が、イベントエリア（2）に到達したとき --EN:--・When a PC or snake soldier (c0000/6010) reaches the event area (2)
	if proxy:IsCompleteEvent( 6010 ) == false then
		proxy:OnRegionJustIn( 6010, 10000, 2, "OnEvent_6010", once);
	end

--■6011■蛇兵士起動? --EN:-- ■ 6011 ■ Snake soldier activation?
--・ＰＣが、イベントエリア（3）に到達したとき --EN:--・When the PC reaches the event area (3)
	if proxy:IsCompleteEvent( 6011 ) == false then
		proxy:OnRegionJustIn( 6011, 10000, 3, "OnEvent_6011", once);
	end

--■6012■崩れる柱2 --EN:-- ■ 6012 ■ Collapsed Pillar 2
--・ＰＣまたはヘビ兵士（c0000/6011）が、イベントエリア（4）に到達したとき --EN:--・When a PC or snake soldier (c0000/6011) reaches the event area (4)
	if proxy:IsCompleteEvent( 6012 ) == false then
		proxy:OnRegionJustIn( 6012, 10000, 4, "OnEvent_6012", once);	
	end		
		

		
		
--エリアリセットしないようにフラグ変えました。 --EN:--Changed the flag not to reset the area.

		
--■6030■デブデーモン部屋扉開放 --EN:-- ■ 6030 ■ Fat Demon room door open
--・デブデーモン(120)死亡演出イベント（イベントID122）が、終了したとき --EN:--・When the fat demon (120) death effect event (event ID 122) ends
	if proxy:IsCompleteEvent( 6030 ) == false then
		proxy:OnCharacterDead( 6030, 120, "OnEvent_6030", once);
	else
		proxy:EndAnimation( 123 , 1 );
	end
	
	
		

--[[▼今まであったイベント]] --EN:--[[▼Previous Events]]


--	誰が無視　プレイアだけ --EN:-- Who ignores only player
--	EventID, Who(無視), RegionID, handler, bOnce	 --EN:-- EventID, Who(ignore), RegionID, handler, bOnce

--[[　以前のです。 --EN:--[[ Earlier.

--■131■扉を開ける■ --EN:-- ■ 131 ■ open the door ■
--ＰＣが、イベントエリア(1)の中に居て、 --EN:--When the PC is in the event area (1),
--特定の角度を向いていて、 --EN:-- facing a certain angle,
--アクションボタンを押したとき --EN:--when you press the action button
	proxy:OnPlayerActionInRegionAngle( 131, 1, "OnEvent_131", 30, HELPID_PULL_LEVER, once);

]]


	
--[[ 以前のです。 --EN:--[[ was earlier.

--■102■崩れる柱1 --EN:-- ■ 102 ■ collapsing pillar 1
--・ＰＣ又はヘビ兵士（c0000/102）が、イベントエリア（2）に到達したとき --EN:--・When a PC or snake soldier (c0000/102) reaches the event area (2)
	proxy:OnRegionJustIn( 102, 10000, 2, "OnEvent_102", once);


--■103■崩れる柱1 --EN:-- ■ 103 ■ Collapsed Pillar 1
--・ＰＣが、イベントエリア（3）に到達したとき --EN:--・When the PC reaches the event area (3)
	proxy:OnRegionJustIn( 103, 10000, 3, "OnEvent_103", once);


--■104■崩れる柱2 --EN:-- ■ 104 ■ Collapsed Pillar 2
--・ＰＣまたはヘビ兵士（c0000/103）が、イベントエリア（4）に到達したとき --EN:--・When a PC or snake soldier (c0000/103) reaches the event area (4)
	proxy:OnRegionJustIn( 104, 10000, 4, "OnEvent_104", once);
]]
	
	
--■110■血文字再生1 --EN:-- ■ 110 ■ Blood letter reproduction 1
--・ＰＣがイベントエリア(10)内でアクションボタンを押した時 --EN:--・When the PC presses the action button in the event area (10)
	
	--proxy:OnPlayerActionInRegion( 110, 10, "OnEvent_110",1, everytime);

	
--[[ 以前のです。 --EN:--[[ was earlier.

--■123■デブデーモン部屋扉開放 --EN:-- ■ 123 ■ Fat Demon room door open
--・デブデーモン(120)死亡演出イベント（イベントID122）が、終了したとき --EN:--・When the fat demon (120) death effect event (event ID 122) ends
	proxy:OnCharacterDead( 123, 120, "OnEvent_123", once);
	
]]	
	
	
	

--■155■マップ移動（→砦水路1Ｆ） --EN:-- ■ 155 ■ Move map (→ Fort Waterway 1F)
--・ＰＣが、イベントエリア（55）に到達したとき --EN:--・When the PC reaches the event area (55)
	proxy:OnRegionJustIn( 155, 10000, 55, "OnEvent_155", everytime);


--■165■マップ移動（→砦水路2Ｆ） --EN:-- ■ 165 ■ Move map (→ Fort Waterway 2F)
--・ＰＣが、イベントエリア（65）に到達したとき --EN:--・When the PC reaches the event area (65)
	proxy:OnRegionJustIn( 165, 10000, 65, "OnEvent_165", everytime);


--■175■マップ移動（→溶岩広場） --EN:-- ■ 175 ■ Map movement (→ lava square)
--・ＰＣが、イベントエリア（75）に到達したとき --EN:--・When the PC reaches the event area (75)
	proxy:OnRegionJustIn( 175, 10000, 75, "OnEvent_175", everytime);
	
	
--■??■徘徊デーモンの登場■ハンドラ登録 --EN:--■??■Appearance of wandering daemon■Handler registration
	proxy:NotNetMessage_begin();
		--プレイヤーがソロで死亡した時にキックされます。 --EN:--Kicked when a player dies solo.
		proxy:LuaCall( 4000, 100, "PlayerDeath_m99_99_11_00", everytime );
		--プレイヤーが復活した時にキックされます。 --EN:--Kicked when the player is revived.
		proxy:LuaCall( 4032, 100, "PlayerRevive_m99_99_11_00", everytime );
	proxy:NotNetMessage_end();
	
	
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 99998, "MapInit", 0.0, 0, 0, once );
	proxy:NotNetMessage_end();


print("Initialize m99_99_11_00 end");
end

function MapInit(proxy,param )

--[[まえに書いてあったもの --EN:--[[What was written before

	if proxy:IsCompleteEvent( 102 ) ==true then
--		proxy:ChangeModel(20, 1);
--		proxy:SetBrokenPiece(20);
		proxy:ReconstructBreak( 20 , 1 );
	end
	if proxy:IsCompleteEvent(131) ==true then
		proxy:EndAnimation(1, 1);
		proxy:EndAnimation(2, 1);
	end
]]


--NPCの死亡再現 --EN:--NPC death reproduction

	if proxy:IsCompleteEvent( 6000 ) == true then
		proxy:ForceDead( 101 );
	end

--中ボスの死亡再現 --EN:-- Mid-boss death reproduction
	
	if proxy:IsCompleteEvent( 6030 ) == true then
		proxy:ForceDead( 120 );
	end

--ロジック制御 --EN:--Logic control

--■6011■蛇兵士起動? --EN:-- ■ 6011 ■ Snake soldier activation?
	if proxy:IsCompleteEvent( 6011 ) == true then
		proxy:EnableLogic( 103 , 1 );
	else
		proxy:EnableLogic( 103 , 0 );
	end
	
	
--柱の破壊再現(エリア入りなおしたとき用) --EN:--Pillar destruction reproduction (for when re-entering the area)
	
--■6010■崩れる柱1 --EN:-- ■ 6010 ■ Collapsed Pillar 1
	if proxy:IsCompleteEvent( 6010 ) == true then
		proxy:ReconstructBreak( 20 , 1 );
	end

--■6012■崩れる柱2 --EN:-- ■ 6012 ■ Collapsed Pillar 2
	if proxy:IsCompleteEvent( 6012) == true then
		proxy:ReconstructBreak( 41 , 1 );
	end

--[[
	--■徘徊デーモン用 (フラグは仮、指定があれば変える) --EN:--■For wandering daemon (flag is tentative, change if specified)
	if proxy:IsCompleteEvent( 20 ) == true then
		LuaFunc_VisibleTheWanderingDemon  (proxy, param, demon_id_list_m99_99_11_00);
	else
		LuaFunc_InvisibleTheWanderingDemon(proxy, param, demon_id_list_m99_99_11_00);
	end
]]

end

--------------------------------------------------------------------------------------
--マルチになった時にホストじゃ無かったら■無し --EN:--If you are not a host when you become multi, no
--------------------------------------------------------------------------------------
function ConnectPartyEvent(proxy)
	print("ConnectPartyEvent begin");
	print("ConnectPartyEvent end");
end





--[[ チュートリアル用 ]] --EN:--[[ For tutorials ]]


--■6020■扉を開ける --EN:-- ■ 6020 ■ Open the door
function OnEvent_6020(proxy, param)
print("OnEvent_6020 begin");

	if param:IsNetMessage()==true  then
		return;         
	end

--・PCをイベントエリア(100)に移動 --EN:--・Move the PC to the event area (100)
	proxy:Warp(10000, 100);
--・PCのレバー動作アニメーション(ID 4000)再生 --EN:--・PC lever movement animation (ID 4000) playback
	proxy:PlayAnimation(10000, 8000);
	
--・イベントフラグを立てる --EN:--・Set an event flag
	proxy:SetEventFlag( 6020, 1 );
--・スイッチＯＢＪ（o0210/1）が作動するアニメーション（ID 1）を再生 --EN:--・Play the animation (ID 1) that activates the switch OBJ (o0210/1)
--　（あれば）作動ＳＥ（ID****）を鳴らす --EN:-- (if any) sound the activation SE (ID****)
	proxy:PlayAnimation(1, 1)

--・同時に扉ＯＢＪ（o0211/2）が開くアニメーション（ID 1）を再生 --EN:--・ Simultaneously play the animation (ID 1) that the door OBJ (o0211/2) opens
--　（あれば）扉が開くＳＥ（ID****）を鳴らす --EN:-- (If there is) ring the SE (ID****) that opens the door
--・扉の当たりを動かし、移動できるようにする --EN:--・Move the hit of the door so that it can be moved
	proxy:PlayAnimation(2, 1)

print("OnEvent_6020 end");
end




--■6010■崩れる柱1 --EN:-- ■ 6010 ■ Collapsed Pillar 1
function OnEvent_6010(proxy, param)
print("OnEvent_6010 begin");

--・イベントフラグを立てる --EN:--・Set an event flag
	proxy:SetEventFlag( 6010, 1 );
--・天井ＯＢＪ（o0224/20）を --EN:--・Ceiling OBJ (o0224/20)
--　ハボックＯＢＪ（o0224_1/20）に差し替えて、落下させる --EN:-- Replace with Havoc OBJ (o0224_1/20) and let it drop
	proxy:ChangeModel(20, 1);
	proxy:SetBrokenPiece(20);

--・ハボックＯＢＪに攻撃あたりを発生させる --EN:--・Havoc OBJ will generate an attack hit
--・ハボックＯＢＪがキャラクターのカプセルあたりに当たった場合、 --EN:--・If the Havoc OBJ hits the character's capsule,
--　ダメージモーションを再生する --EN:-- Play damage motion
--・ハボックＯＢＪの攻撃あたりは、床、壁あたりにあたった時点で消す --EN:--・Havoc OBJ's attack is erased when it hits the floor or wall
--・（あれば）柱がぶつかるＳＥ（ID****）を鳴らす --EN:--・Sound the SE (ID****) where the pillar collides (if any)

print("OnEvent_6010 end");
end



--■6011■ヘビ兵士起動 --EN:-- ■ 6011 ■ Snake soldier activation
function OnEvent_6011(proxy, param)
print("OnEvent_6011 begin");

--・ヘビ兵士（c1000/6011）のロジックを通常に切り替える --EN:--・Switch logic of Snake Soldier (c1000/6011) to normal
	proxy:EnableLogic(103, true);

print("OnEvent_6011 end");
end




--■6012■崩れる柱2 --EN:-- ■ 6012 ■ Collapsed Pillar 2
function OnEvent_6012(proxy, param)
print("OnEvent_6012 begin");

--・イベントフラグを立てる --EN:--・Set an event flag
	proxy:SetEventFlag( 6012, 1 );
--・柱ＯＢＪ（o0225/41）を --EN:--・Pillar OBJ (o0225/41)
--　ハボックＯＢＪ（o0225_1/41）に差し替えて、落下させる --EN:-- Replace with Havoc OBJ (o0225_1/41) and let it drop

	proxy:ChangeModel(41, 1);
	proxy:SetBrokenPiece(41);

--・ハボックＯＢＪに攻撃あたりを発生させる --EN:--・Havoc OBJ will generate an attack hit
--・ハボックＯＢＪがキャラクターのカプセルあたりに当たった場合、 --EN:--・If the Havoc OBJ hits the character's capsule,
--　ダメージモーションを再生する --EN:-- Play damage motion
--・ハボックＯＢＪの攻撃あたりは、床、壁あたりにあたった時点で消す --EN:--・Havoc OBJ's attack is erased when it hits the floor or wall
--・（あれば）柱がぶつかるＳＥ（ID****）を鳴らす --EN:--・Sound the SE (ID****) where the pillar collides (if any)

print("OnEvent_6012 end");
end





--■6030■デブデーモン部屋扉開放 --EN:-- ■ 6030 ■ Fat Demon room door open
function OnEvent_6030(proxy, param)
print("OnEvent_6030 begin");

--・イベントフラグを立てる --EN:--・Set an event flag
	proxy:SetEventFlag( 6030, 1 );

--・デブデーモン部屋の扉（o0212/6030)の開くアニメーション（ID 1)を再生 --EN:--・Play the opening animation (ID 1) of the fat demon room door (o0212/6030)
--・（あれば）扉が開くSEを鳴らす --EN:--・Sound the SE that opens the door (if available)
--・扉の当たりを動かし、ＰＣが通れるようにする。 --EN:--・Move the door so that the PC can pass through.
	proxy:PlayAnimation(123, 1)


print("OnEvent_6030 end");
end



--------------------------------------------------------------------------------------
--ハシゴB降り■1000 --EN:--Ladder B descend ■ 1000
--------------------------------------------------------------------------------------
--■1000■ハシゴB降りスタート■ --EN:-- ■ 1000 ■ Ladder B descent start ■
function OnEvent_1000(proxy, param)
	print("OnEvent_1000 begin");
	
	if param:IsNetMessage() == true then
		print("IsNetMessage true");
		print("OnEvent_1000 end");
		return;
	end

	--はしご降りに必要な前処理-- --EN:--Pretreatment required for descending the ladder--
	proxy:BeginAction(10000,2,2,2);				--ホバー移動モードに移行 --EN:--Transition to hover movement mode
	proxy:HoverMoveVal(10000,2102,LadderTime_A);--移動位置(2102)に0.5秒でホバー移動 --EN:--Hover to move position (2102) in 0.5 seconds
	proxy:SetEventCommand(10000,1);				--イベントコマンドID(1)"ハシゴ上から掴"むを送る --EN:-- Send event command ID (1) "Grab from the top of the ladder"
	proxy:SetKeepCommandIndex(10000, 4, 1, 3.0 );
	proxy:DisableMove(10000,1);					--キャラクタを移動、旋回不能に --EN:--Move the character, make it impossible to turn
	
	proxy:NotNetMessage_begin();
		--0.5秒(ホバー移動終了)後にはしご降りスタートイベントを発行 --EN:-- Issue a ladder descend start event after 0.5 seconds (end of hover movement)
		proxy:OnKeyTime2(1000,"OnEvent_1000_1",LadderTime_A,0,0,once);
		--はしご降り専用の関数を3秒間発行(カメラの周り込みなどの処理) --EN:--Issue a function dedicated to descending the ladder for 3 seconds (processing such as surrounding the camera)
		proxy:OnKeyTime2(1000,"LadderDown",3,1,1,once);
	proxy:NotNetMessage_end();

	print("OnEvent_1000 end");
end

--■1000_1■ハシゴB降りスタート:ホバー移動終了■ --EN:--■1000_1■ Start descending from ladder B: End of hover movement ■
function OnEvent_1000_1(proxy, param)
	print("OnEvent_1000_1 begin");
	
	if proxy:GetEventMode(10000) == 0 then
		print("Local Player GetEventMode 0");
		print("OnEvent_1000_1 end");
		return;
	end

	--ハシゴアクションモードに移行-- --EN:--Transition to ladder action mode--
	--nMax  : はしごの段数 - 補正値(補正値はおおよそ3) --EN:--nMax : number of ladder steps - correction value (correction value is approximately 3)
	--nStart: 降りるとき→(nMax + 1) 昇るとき→(-1) --EN:--nStart: When going down→(nMax + 1) When going up→(-1)
	proxy:BeginAction(10000,1,8,7);
	
	--キャラクタを移動、旋回可能に-- --EN:--Character can be moved and turned--
	proxy:DisableMove(10000,0);
	
	print("OnEvent_1000_1 end");
end


--------------------------------------------------------------------------------------
--ハシゴB昇り■1001 --EN:--Ladder B up 1001
--------------------------------------------------------------------------------------
--■1001■ハシゴB昇りスタート■ --EN:-- ■ 1001 ■ Ladder B climbing start ■
function OnEvent_1001(proxy, param)
	print("OnEvent_1001 begin");
	
	if param:IsNetMessage() == true then
		print("IsNetMessage true");
		print("OnEvent_1001 end");
		return;
	end
	
	--はしご昇りに必要な前処理-- --EN:--Pretreatment required for climbing a ladder--
	proxy:BeginAction(10000,2,-1,1);			--ホバー移動モードに移行 --EN:--Transition to hover movement mode
	proxy:HoverMoveVal(10000,2103,LadderTime_A);--移動位置(2103)に0.5秒でホバー移動 --EN:--Hover to move position (2103) in 0.5 seconds
	proxy:SetEventCommand(10000,0);				--イベントコマンドID(0)"ハシゴ下から掴"むを送る --EN:-- Send event command ID (0) "grab from under the ladder"
	proxy:SetKeepCommandIndex(10000, 4, 1, 3.0 );
	proxy:DisableMove(10000,1);					--キャラクタを移動、旋回不能に --EN:--Move the character, make it impossible to turn
	
	proxy:NotNetMessage_begin();
		--0.5秒(ホバー移動終了)後にはしご昇りスタートイベントを発行 --EN:-- Issue a ladder climb start event after 0.5 seconds (end of hover movement)
		proxy:OnKeyTime2(1001,"OnEvent_1001_1",LadderTime_A,0,0,once);
		--はしご昇り用の関数を1秒間発行(イベントメニューの中断処理?) --EN:--Issuing a function for climbing a ladder for 1 second (interruption processing of the event menu?)
		proxy:OnKeyTime2(1001,"EventMenuBrake",1,1,1,once);
	proxy:NotNetMessage_end();
	
	print("OnEvent_1001 end");
end

--■1001_1■ハシゴA昇りスタート:ホバー移動終了■ --EN:--■1001_1■ Start climbing ladder A: End of hover movement ■
function OnEvent_1001_1(proxy, param)
	print("OnEvent_1001_1 begin");
	
	if proxy:GetEventMode(10000) == 0 then
		print("Local Player GetEventMode 0");
		print("OnEvent_1001_1 end");
		return;
	end

	--ハシゴアクションモードに移行-- --EN:--Transition to ladder action mode--
	--nMax  : はしごの段数 - 補正値(補正値はおおよそ3) --EN:--nMax : number of ladder steps - correction value (correction value is approximately 3)
	--nStart: 降りるとき→(nMax + 1) 昇るとき→(-1) --EN:--nStart: When going down→(nMax + 1) When going up→(-1)
	proxy:BeginAction(10000,1,-1,7);
	
	--キャラクタを移動、旋回可能に-- --EN:--Character can be moved and turned--
	proxy:DisableMove(10000,0);
	
	print("OnEvent_1001_1 end");
end




--------------------------------------------------------------------------------------
--NPC会話■6000※ValueBuffer 20010使用 --EN:--NPC Conversation ■ 6000 * Using ValueBuffer 20010
--------------------------------------------------------------------------------------
--■6000■NPC会話■AnctionButton判定 --EN:-- ■ 6000 ■ NPC conversation ■ ActionButton determination
function OnEvent_6000(proxy, param)
	print("OnEvent_6000 begin");
	if param:IsNetMessage()==true  then
		return;
	end
	
	FlagValue = proxy:IsCompleteEventValue(20010);

	if FlagValue ==0 then proxy:SetEventFlag( 20010, 1 ); end
	if FlagValue ==1 then
		proxy:SetEventFlag( 20010, 0 );		
	end
	print("OnEvent_6000 end");
end

--■6000_1■NPC会話■現在表示するメッセージ --EN:-- ■ 6000_1 ■ NPC conversation ■ Message to be displayed now
function OnEvent_6000_1(proxy, param)
	print("OnEvent_6000_1 begin");
	
	--ValueBuffer20010の値を取得する --EN:--Get the value of ValueBuffer20010
	FlagValue = proxy:IsCompleteEventValue(20010);
	--ページを捲ってなければ抜ける --EN:--Exit if you do not turn the page
	if FlagValue ==0 then return;	 end
	if FlagValue ==1 then proxy:StartTalk(80000130,0);	 end
	
	if FlagValue ==4 then proxy:StartTalk(90000700,0);	 end--死んでるとき？ --EN:--When you're dead?
	
	print("OnEvent_6000_1 end");
end

--■6000_2■NPC会話■反応距離から出た場合の処理 --EN:-- ■ 6000_2 ■ NPC conversation ■ Processing when leaving the reaction distance
function OnEvent_6000_2(proxy, param)
	print("OnEvent_6000_2 begin");

	--ValueBuffer20010の値を取得する --EN:--Get the value of ValueBuffer20010
	FlagValue = proxy:IsCompleteEventValue(20010);

	if FlagValue >=1 then
		proxy:SetEventFlag( 20010, 0 );		
	end

	print("OnEvent_6000_2 end");
end

--■1101■NPC会話■NPCのHPが0になった瞬間 --EN:-- ■ 1101 ■ NPC conversation ■ Moment when NPC's HP becomes 0
function OnEvent_1101(proxy, param)
	print("OnEvent_1101 begin");
	--殺した時の距離が範囲内なら --EN:--If the distance at the time of killing is within range
	if proxy:IsDistance(10000,101,TalkDist_N) == true then	
		--ValueBuffer20010の値を設定する --EN:--Set the value of ValueBuffer20010
		proxy:SetEventFlag(20010,4);
	else
		--範囲外ならページを何も表示しないページに --EN:--If out of range, change the page to a page that does not display anything
		--ValueBuffer20010の値を設定する --EN:--Set the value of ValueBuffer20010
		proxy:SetEventFlag(20010,5);
	
	end
		
	print("OnEvent_1101 end");
end

--■1102■NPC会話■NPC死んだ --EN:-- ■ 1102 ■ NPC conversation ■ NPC dead
function OnEvent_1102(proxy, param)
	print("OnEvent_1102 begin");
	--ValueBuffer20010の値を設定する --EN:--Set the value of ValueBuffer20010
	proxy:SetEventFlag(20010,0 );
	proxy:SetEventFlag(6000,1);
	--キャラクタが死んで必要なくなるので会話イベントを削除する --EN:--Remove the conversation event because the character dies and you don't need it anymore
	proxy:DeleteEvent(6000);
	proxy:DeleteEvent(1103);
	print("OnEvent_1102 end");
end

--■1103■NPC会話:PCから攻撃された処理■ --EN:-- ■ 1103 ■ NPC conversation: Process attacked from PC ■
function OnEvent_1103(proxy, param)
	print("OnEvent_1103 begin");
	if proxy:IsDistance(10000,101,TalkDist_N) == false then
		return ;
	end
	print("OnEvent_1103 end");
end






















--[[以前のです。]] --EN:--[[previous. ]]


--[[

--■131■扉を開ける --EN:-- ■ 131 ■ open the door
function OnEvent_131(proxy, param)
print("OnEvent_131 begin");

	if param:IsNetMessage()==true  then
		return;         
	end

--・PCをイベントエリア(100)に移動 --EN:--・Move the PC to the event area (100)
	proxy:Warp(10000, 100);
--・PCのレバー動作アニメーション(ID 4000)再生 --EN:--・PC lever movement animation (ID 4000) playback
	proxy:PlayAnimation(10000, 8000);
	
--・イベントフラグを立てる --EN:--・Set an event flag
	proxy:SetEventFlag( 131, 1 );
--・スイッチＯＢＪ（o0210/1）が作動するアニメーション（ID 1）を再生 --EN:--・Play the animation (ID 1) that activates the switch OBJ (o0210/1)
--　（あれば）作動ＳＥ（ID****）を鳴らす --EN:-- (if any) sound the activation SE (ID****)
	proxy:PlayAnimation(1, 1)

--・同時に扉ＯＢＪ（o0211/2）が開くアニメーション（ID 1）を再生 --EN:--・ Simultaneously play the animation (ID 1) that the door OBJ (o0211/2) opens
--　（あれば）扉が開くＳＥ（ID****）を鳴らす --EN:-- (If there is) ring the SE (ID****) that opens the door
--・扉の当たりを動かし、移動できるようにする --EN:--・Move the hit of the door so that it can be moved
	proxy:PlayAnimation(2, 1)

print("OnEvent_131 end");
end

]]







--[[

--■102■崩れる柱1 --EN:-- ■ 102 ■ collapsing pillar 1
function OnEvent_102(proxy, param)
print("OnEvent_102 begin");

--・イベントフラグを立てる --EN:--・Set an event flag
	proxy:SetEventFlag( 102, 1 );
--・天井ＯＢＪ（o0224/20）を --EN:--・Ceiling OBJ (o0224/20)
--　ハボックＯＢＪ（o0224_1/20）に差し替えて、落下させる --EN:-- Replace with Havoc OBJ (o0224_1/20) and let it drop
	proxy:ChangeModel(20, 1);
	proxy:SetBrokenPiece(20);

--・ハボックＯＢＪに攻撃あたりを発生させる --EN:--・Havoc OBJ will generate an attack hit
--・ハボックＯＢＪがキャラクターのカプセルあたりに当たった場合、 --EN:--・If the Havoc OBJ hits the character's capsule,
--　ダメージモーションを再生する --EN:-- Play damage motion
--・ハボックＯＢＪの攻撃あたりは、床、壁あたりにあたった時点で消す --EN:--・Havoc OBJ's attack is erased when it hits the floor or wall
--・（あれば）柱がぶつかるＳＥ（ID****）を鳴らす --EN:--・Sound the SE (ID****) where the pillar collides (if any)

print("OnEvent_102 end");
end






--■103■ヘビ兵士起動 --EN:-- ■ 103 ■ Snake soldier activation
function OnEvent_103(proxy, param)
print("OnEvent_103 begin");

--・ヘビ兵士（c1000/103）のロジックを通常に切り替える --EN:--・Switch logic of Snake Soldier (c1000/103) to normal
	proxy:EnableLogic(103, true);

print("OnEvent_103 end");
end






--■104■崩れる柱2 --EN:-- ■ 104 ■ Collapsed Pillar 2
function OnEvent_104(proxy, param)
print("OnEvent_104 begin");

--・イベントフラグを立てる --EN:--・Set an event flag
	proxy:SetEventFlag( 104, 1 );
--・柱ＯＢＪ（o0225/41）を --EN:--・Pillar OBJ (o0225/41)
--　ハボックＯＢＪ（o0225_1/41）に差し替えて、落下させる --EN:-- Replace with Havoc OBJ (o0225_1/41) and let it drop

	proxy:ChangeModel(41, 1);
	proxy:SetBrokenPiece(41);

--・ハボックＯＢＪに攻撃あたりを発生させる --EN:--・Havoc OBJ will generate an attack hit
--・ハボックＯＢＪがキャラクターのカプセルあたりに当たった場合、 --EN:--・If the Havoc OBJ hits the character's capsule,
--　ダメージモーションを再生する --EN:-- Play damage motion
--・ハボックＯＢＪの攻撃あたりは、床、壁あたりにあたった時点で消す --EN:--・Havoc OBJ's attack is erased when it hits the floor or wall
--・（あれば）柱がぶつかるＳＥ（ID****）を鳴らす --EN:--・Sound the SE (ID****) where the pillar collides (if any)

print("OnEvent_104 end");
end


]]



--■110■血文字再生1 --EN:-- ■ 110 ■ Blood letter reproduction 1
--・ＰＣがイベントエリア(10)内でアクションボタンを押した時 --EN:--・When the PC presses the action button in the event area (10)
function OnEvent_110(proxy, param)
print("OnEvent_110 begin");
--・リプレイゴースト（****/110）出現演出 --EN:--・Replay ghost (****/110) appearance effect
--・リプレイゴーストのアニメーション（ID****）を再生 --EN:--・Play replay ghost animation (ID****)
--＞ゴーストのルートは３Ｄさんと相談 --EN:--> Discuss the ghost route with 3D
--
--※血文字は、演出不要（ＳＦＸ、サウンドともに） --EN:--*Blood letters do not require production (both SFX and sound)

	proxy:BeginReplayGhost(0);


print("OnEvent_110 end");
end



--[[

--■123■デブデーモン部屋扉開放 --EN:-- ■ 123 ■ Fat Demon room door open
function OnEvent_123(proxy, param)
print("OnEvent_123 begin");

--・イベントフラグを立てる --EN:--・Set an event flag
	proxy:SetEventFlag( 123, 1 );

--・デブデーモン部屋の扉（o0212/123)の開くアニメーション（ID 1)を再生 --EN:--・Play the opening animation (ID 1) of the fat demon room door (o0212/123)
--・（あれば）扉が開くSEを鳴らす --EN:--・Sound the SE that opens the door (if available)
--・扉の当たりを動かし、ＰＣが通れるようにする。 --EN:--・Move the door so that the PC can pass through.
	proxy:PlayAnimation(123, 1)


print("OnEvent_123 end");
end

]]




--■155■マップ移動（→砦水路1Ｆ） --EN:-- ■ 155 ■ Move map (→ Fort Waterway 1F)
function OnEvent_155(proxy, param)
print("OnEvent_155 begin");
	if param:IsNetMessage()==true  then
		return;         
	end
--マルチプレイの時のエリア移動を止める --EN:-- Stop area movement during multiplayer
	if proxy:IsInParty() == true then
		return;
	end 

--・たどり着いたＰＣのみ、砦から砦水路（m99_99_10_00）の指定位置に移動する --EN:--・Only the PCs that arrive move from the fort to the specified location in the fort waterway (m99_99_10_00).
--・移動先（m99_99_10_00）の対応キャライベントID --EN:--・ Corresponding character event ID of destination (m99_99_10_00)
--　ＰＣ（0）→キャラ（10） --EN:-- PC (0) → Character (10)
--　ＰＣ（1）→キャラ（11） --EN:-- PC (1) → Character (11)
--　ＰＣ（2）→キャラ（12） --EN:-- PC (2) → Character (12)
--　ＰＣ（3）→キャラ（13） --EN:-- PC (3) → Character (13)
	playerId = proxy:GetLocalPlayerId();
	if playerId ==0 then proxy:WarpNextStage(99,99,10,00, 10); end
	if playerId ==1 then proxy:WarpNextStage(99,99,10,00, 11); end
	if playerId ==2 then proxy:WarpNextStage(99,99,10,00, 12); end
	if playerId ==3 then proxy:WarpNextStage(99,99,10,00, 13); end

--※移動するキャラクターは、移動時にパッと消してしまいます --EN:--* Characters that move will be erased when moving.

print("OnEvent_155 end");
end






--■165■マップ移動（→砦水路2Ｆ） --EN:-- ■ 165 ■ Move map (→ Fort Waterway 2F)
function OnEvent_165(proxy, param)
print("OnEvent_165 begin");
	if param:IsNetMessage()==true  then
		return;         
	end
--マルチプレイの時のエリア移動を止める --EN:-- Stop area movement during multiplayer
	if proxy:IsInParty() == true then
		return;
	end 

--・たどり着いたＰＣのみ、砦から砦水路（m99_99_10_00）の指定位置に移動する --EN:--・Only the PCs that arrive move from the fort to the specified location in the fort waterway (m99_99_10_00).
--・移動先（m99_99_10_00）の対応キャライベントID --EN:--・ Corresponding character event ID of destination (m99_99_10_00)
--　ＰＣ（0）→キャラ（20） --EN:-- PC (0) → Character (20)
--　ＰＣ（1）→キャラ（21） --EN:-- PC (1) → Character (21)
--　ＰＣ（2）→キャラ（22） --EN:-- PC (2) → Character (22)
--　ＰＣ（3）→キャラ（23） --EN:--PC (3) → Character (23)
	playerId = proxy:GetLocalPlayerId();
	if playerId ==0 then proxy:WarpNextStage(99,99,10,00, 20); end
	if playerId ==1 then proxy:WarpNextStage(99,99,10,00, 21); end
	if playerId ==2 then proxy:WarpNextStage(99,99,10,00, 22); end
	if playerId ==3 then proxy:WarpNextStage(99,99,10,00, 23); end

--※移動するキャラクターは、移動時にパッと消してしまいます --EN:--* Characters that move will be erased when moving.

print("OnEvent_165 end");
end






--■175■マップ移動（→溶岩広場） --EN:-- ■ 175 ■ Map movement (→ lava square)
function OnEvent_175(proxy, param)
print("OnEvent_175 begin");
	if param:IsNetMessage()==true  then
		return;         
	end
--マルチプレイの時のエリア移動を止める --EN:-- Stop area movement during multiplayer
	if proxy:IsInParty() == true then
		return;
	end 

--・たどり着いたＰＣのみ、砦から溶岩広場（m99_99_12_00）の指定位置に移動 --EN:--・Only the PCs that arrive move from the fort to the specified location in the lava square (m99_99_12_00).
--・移動先（m99_99_12_00）の対応キャライベントID --EN:--・ Corresponding character event ID of destination (m99_99_12_00)
--　ＰＣ（0）→キャラ（30） --EN:-- PC (0) → Character (30)
--　ＰＣ（1）→キャラ（31） --EN:-- PC (1) → Character (31)
--　ＰＣ（2）→キャラ（32） --EN:-- PC (2) → Character (32)
--　ＰＣ（3）→キャラ（33） --EN:-- PC (3) → Character (33)
	playerId = proxy:GetLocalPlayerId();
	if playerId ==0 then proxy:WarpNextStage(99,99,12,00, 30); end
	if playerId ==1 then proxy:WarpNextStage(99,99,12,00, 31); end
	if playerId ==2 then proxy:WarpNextStage(99,99,12,00, 32); end
	if playerId ==3 then proxy:WarpNextStage(99,99,12,00, 33); end

--※移動するキャラクターは、移動時にパッと消してしまいます --EN:--* Characters that move will be erased when moving.

print("OnEvent_175 end");
end




--------------------------------------------------------------------------------------
--徘徊デーモンの登場■?? --EN:-- Appearance of the Wandering Demon ??
--------------------------------------------------------------------------------------

--▼グローバルの死亡監視から呼ばれる(ソロ) --EN:--▼ Called from global death watch (solo)
function PlayerDeath_m99_99_11_00(proxy, param)
	print("PlayerDeath_m99_99_11_00");
	
--	LuaFunc_VisibleTheWanderingDemon(proxy, param, demon_id_list_m99_99_11_00);
--	proxy:SetEventFlag( 20 , 1 );--フラグは仮、指定があれば変える。 --EN:The -- flag is tentative, and will be changed if specified.
	
	print("PlayerDeath_m99_99_11_00");
end

--▼グローバルの血文字復活から呼ばれる(ソロ) --EN:--▼Called from global blood letter revival (solo)
function PlayerRevive_m99_99_11_00(proxy,param)
	print("PlayerRevive_m99_99_11_00");
	
--	LuaFunc_InvisibleTheWanderingDemon(proxy, param, demon_id_list_m99_99_11_00);
--	proxy:SetEventFlag( 20 , 0 );--フラグは仮、指定があれば変える。 --EN:The -- flag is tentative, and will be changed if specified.
	
	print("PlayerRevive_m99_99_11_00");
end


