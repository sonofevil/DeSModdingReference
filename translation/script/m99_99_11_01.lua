once = 1;
everytime = 0;



function Initialize_m99_99_11_01(proxy)
print("Initialize m99_99_11_01 begin");


--	誰が無視　プレイアだけ --EN:-- Who ignores only player
--	EventID, Who(無視), RegionID, handler, bOnce	 --EN:-- EventID, Who(ignore), RegionID, handler, bOnce


--■101■扉を開ける■ --EN:-- ■ 101 ■ open the door ■
--ＰＣが、イベントエリア(1)の中に居て、 --EN:--When the PC is in the event area (1),
--特定の角度を向いていて、 --EN:-- facing a certain angle,
--アクションボタンを押したとき --EN:--when you press the action button
	proxy:OnPlayerActionInRegionAngle( 101, 1, "OnEvent_101", 30,1, once);

--■131■扉を開ける■ --EN:-- ■ 131 ■ open the door ■
--ＰＣが、イベントエリア(1)の中に居て、 --EN:--When the PC is in the event area (1),
--特定の角度を向いていて、 --EN:-- facing a certain angle,
--アクションボタンを押したとき --EN:--when you press the action button

	proxy:OnPlayerActionInRegionAngle( 131, 1, "OnEvent_131", 30,1, once);


--■102■崩れる柱1 --EN:-- ■ 102 ■ collapsing pillar 1
--・ＰＣ又はヘビ兵士（c0000/102）が、イベントエリア（2）に到達したとき --EN:--・When a PC or snake soldier (c0000/102) reaches the event area (2)
	proxy:OnRegionJustIn( 102, 10000, 2, "OnEvent_102", once);


--■103■崩れる柱1 --EN:-- ■ 103 ■ Collapsed Pillar 1
--・ＰＣが、イベントエリア（3）に到達したとき --EN:--・When the PC reaches the event area (3)
	proxy:OnRegionJustIn( 103, 10000, 3, "OnEvent_103", once);


--■104■崩れる柱2 --EN:-- ■ 104 ■ Collapsed Pillar 2
--・ＰＣまたはヘビ兵士（c0000/103）が、イベントエリア（4）に到達したとき --EN:--・When a PC or snake soldier (c0000/103) reaches the event area (4)
	proxy:OnRegionJustIn( 104, 10000, 4, "OnEvent_104", once);


--■110■血文字再生1 --EN:-- ■ 110 ■ Blood letter reproduction 1
--・ＰＣがイベントエリア(10)内でアクションボタンを押した時 --EN:--・When the PC presses the action button in the event area (10)
	proxy:OnPlayerActionInRegion( 110, 10, "OnEvent_110",1, everytime);


--■123■デブデーモン部屋扉開放 --EN:-- ■ 123 ■ Fat Demon room door open
--・デブデーモン(120)死亡演出イベント（イベントID122）が、終了したとき --EN:--・When the fat demon (120) death effect event (event ID 122) ends
	proxy:OnCharacterDead( 123, 120, "OnEvent_123", once);


--■155■マップ移動（→砦水路1Ｆ） --EN:-- ■ 155 ■ Move map (→ Fort Waterway 1F)
--・ＰＣが、イベントエリア（55）に到達したとき --EN:--・When the PC reaches the event area (55)
	proxy:OnRegionJustIn( 155, 10000, 55, "OnEvent_155", everytime);


--■165■マップ移動（→砦水路2Ｆ） --EN:-- ■ 165 ■ Move map (→ Fort Waterway 2F)
--・ＰＣが、イベントエリア（65）に到達したとき --EN:--・When the PC reaches the event area (65)
	proxy:OnRegionJustIn( 165, 10000, 65, "OnEvent_165", everytime);


--■175■マップ移動（→溶岩広場） --EN:-- ■ 175 ■ Map movement (→ lava square)
--・ＰＣが、イベントエリア（75）に到達したとき --EN:--・When the PC reaches the event area (75)
	proxy:OnRegionJustIn( 175, 10000, 75, "OnEvent_175", everytime);


print("Initialize m99_99_11_01 end");
end







--■101■扉を開ける --EN:-- ■ 101 ■ open the door
function OnEvent_101(proxy, param)
print("OnEvent_101 begin");
	if param:IsNetMessage()==TRUE  then
		return;         
	end


--・イベントフラグを立てる --EN:--・Set an event flag
	proxy:SetEventFlag( 101, true );
--・PCをイベントエリア(100)に移動 --EN:--・Move the PC to the event area (100)
	proxy:Warp(10000, 100);
--・PCのレバー動作アニメーション(ID 4000)再生 --EN:--・PC lever movement animation (ID 4000) playback
	proxy:PlayAnimation(10000, 4000);

print("OnEvent_101 end");
end
--■131■扉を開ける --EN:-- ■ 131 ■ open the door
function OnEvent_131(proxy, param)
print("OnEvent_131 begin");

--・イベントフラグを立てる --EN:--・Set an event flag
	proxy:SetEventFlag( 131, true );
--・スイッチＯＢＪ（o0210/1）が作動するアニメーション（ID 1）を再生 --EN:--・Play the animation (ID 1) that activates the switch OBJ (o0210/1)
--　（あれば）作動ＳＥ（ID****）を鳴らす --EN:-- (if any) sound the activation SE (ID****)
	proxy:PlayAnimation(1, 1)

--・同時に扉ＯＢＪ（o0211/2）が開くアニメーション（ID 1）を再生 --EN:--・ Simultaneously play the animation (ID 1) that the door OBJ (o0211/2) opens
--　（あれば）扉が開くＳＥ（ID****）を鳴らす --EN:-- (If there is) ring the SE (ID****) that opens the door
--・扉の当たりを動かし、移動できるようにする --EN:--・Move the hit of the door so that it can be moved
	proxy:PlayAnimation(2, 1)

print("OnEvent_101 end");
end






--■102■崩れる柱1 --EN:-- ■ 102 ■ collapsing pillar 1
function OnEvent_102(proxy, param)
print("OnEvent_102 begin");

--・イベントフラグを立てる --EN:--・Set an event flag
	proxy:SetEventFlag( 102, true );
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
	proxy:SetEventFlag( 104, true );
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






--■123■デブデーモン部屋扉開放 --EN:-- ■ 123 ■ Fat Demon room door open
function OnEvent_123(proxy, param)
print("OnEvent_123 begin");

--・イベントフラグを立てる --EN:--・Set an event flag
	proxy:SetEventFlag( 123, true );

--・デブデーモン部屋の扉（o0212/123)の開くアニメーション（ID 1)を再生 --EN:--・Play the opening animation (ID 1) of the fat demon room door (o0212/123)
--・（あれば）扉が開くSEを鳴らす --EN:--・Sound the SE that opens the door (if available)
--・扉の当たりを動かし、ＰＣが通れるようにする。 --EN:--・Move the door so that the PC can pass through.
	proxy:PlayAnimation(123, 1)


print("OnEvent_123 end");
end






--■155■マップ移動（→砦水路1Ｆ） --EN:-- ■ 155 ■ Move map (→ Fort Waterway 1F)
function OnEvent_155(proxy, param)
print("OnEvent_155 begin");
	if param:IsNetMessage()==TRUE  then
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
	if param:IsNetMessage()==TRUE  then
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
	if param:IsNetMessage()==TRUE  then
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



















