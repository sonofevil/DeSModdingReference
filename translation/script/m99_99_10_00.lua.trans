once = 1;
everytime = 0;


--■チュートリアル用 --EN:--■ For tutorial
TO_NEXT_MESSAGE_TIME          = 0.0;--メッセージが連続するときの、次のメッセージを表示するまでの時間 --EN:--Time to display the next message when messages are consecutive
GET_ITEM_TO_NEXT_MESSAGE_TIME = 3.0;--アイテム取得→メッセージ表示のときはちょっと時間を空ける --EN:-- Take a little time when acquiring items → displaying messages

DISPLAY_MESSAGE_TIME          = 4.5;



function Initialize_m99_99_10_00(proxy)
	print("Initialize m99_99_10_00 begin");

--■050■初期配置■ --EN:-- ■ 050 ■ initial placement ■
--・ゲーム開始時 --EN:--・At the start of the game
--・ＰＣキャラクターを指定の位置に配置する --EN:--・Place the PC character at the specified position
--　ＰＣ（0）→キャラ（0） --EN:-- PC (0) → Character (0)
--　ＰＣ（1）→キャラ（1） --EN:-- PC (1) → Character (1)
--　ＰＣ（2）→キャラ（2） --EN:-- PC (2) → Character (2)
--　ＰＣ（3）→キャラ（3） --EN:-- PC (3) → Character (3)
--	proxy:OnRegionJustIn( 0, 0, 1, "OnEvent_050", once);



--▼変更しないもの --EN:--▼ What does not change

--■055■マップ移動（→砦1F)■ --EN:-- ■ 055 ■ Move map (→ Fort 1F) ■
--・ＰＣが、イベントエリア（55）に到達したとき --EN:--・When the PC reaches the event area (55)
	proxy:OnRegionJustIn( 55, 10000, 55, "OnEvent_055", everytime);


--■065■マップ移動（→砦2F)■ --EN:-- ■ 065 ■ Move map (→ Fort 2F) ■
--・ＰＣが、イベントエリア（65）に到達したとき --EN:--・When the PC reaches the event area (65)
	proxy:OnRegionJustIn( 65, 10000, 65, "OnEvent_065", everytime);


--※IDをラスボスリセットにしたので、フラグが重複しないように注意(m99_99_10_00 から m99_99_12_00で) --EN:--*Be careful not to duplicate the flags because the ID is reset to the last boss (from m99_99_10_00 to m99_99_12_00)
	
	
--▼チュートリアル用に追加したもの --EN:--▼Added for tutorial

--チュートリアル用のヘルプメッセージ、宝死体はエリアリセットしないように --EN:--Help message for tutorial, Treasure corpse will not reset the area
--ラスボスリセットのほうのフラグになっています。 --EN:--It is a flag for the final boss reset.
	
--■5020■チュートリアル01■初期移動関連説明(カメラ旋回説明→ダッシュステップ説明) --EN:--■5020 ■Tutorial 01 ■Explanation related to initial movement (Explanation of camera rotation → Explanation of dash step)
	if proxy:IsCompleteEvent( 5020 ) == false then
		proxy:OnKeyTime2(5020,"OnEvent_5020",1,0,0,once);
	end
	
--■5022■チュートリアル03■よじ登り説明 --EN:--■5022■Tutorial 03■Climbing Instructions
	if proxy:IsCompleteEvent( 5022) == false then
		proxy:OnRegionJustIn(5022,10000,2000,"OnEvent_5022",once);
	end

--■5023■チュートリアル04■乗り越え説明 --EN:-- ■ 5023 ■ Tutorial 04 ■ Explanation of overcoming
	if proxy:IsCompleteEvent( 5023 ) == false then
		proxy:OnRegionJustIn(5023,10000,2001,"OnEvent_5023",once);
	end
	
--■5024■チュートリアル05■近接攻撃関連説明(左手･右手攻撃→溜め攻撃→両手･片手攻撃) --EN:--■5024 ■Tutorial 05 ■Explanation related to melee attack
	if proxy:IsCompleteEvent( 5024 ) == false then
		proxy:OnRegionJustIn(5024,10000,2002,"OnEvent_5024",once);
	end
	
--■5027■チュートリアル08■遠隔攻撃関連説明(魔法攻撃→弓攻撃) --EN:--■5027■Tutorial 08■Explanation related to ranged attack (magic attack → bow attack)
	if proxy:IsCompleteEvent( 5027 ) == false then
		proxy:OnRegionJustIn(5027,10000,2003,"OnEvent_5027",once);
	end
	
--■5031■チュートリアル11■死体調べるとアイテム取得できますよメッセージ --EN:--■5031■Tutorial 11■You can get items by examining the corpse Message
	if proxy:IsCompleteEvent( 5031 ) == false then
		proxy:OnRegionJustIn(5031,10000,2004,"OnEvent_5031",once);
	end

--■1100■待機のままの腐敗人■ --EN:-- ■ 1100 ■ Corrupt man on standby ■
	if proxy:IsCompleteEvent( 1100 ) == false then
		proxy:OnKeyTime2(1100, "OnEvent_1100" , 1 , 0 , 1 , once );
	end

--■5000■宝死体A■→矢を取得→武器の入れ替えメッセージ表示 --EN:--■5000 ■Treasure corpse A■→Obtain an arrow→Weapon exchange message display
	if proxy:IsCompleteEvent( 5000 ) ==false then
		proxy:OnDistanceAction( 5000, 10000, 1040, "OnEvent_5000", ItemBoxDist_A, HELPID_CHECK_GLOWING_CORPS, 0, ItemBoxAngle_A, once );
		proxy:TreasureDispModeChange( 1040, true );
	end

--■5010■宝死体B■→ポーション取得→アイテム説明のメッセージ表示 --EN:--■5010 ■Treasure corpse B■→Obtain potion→Display item description message
	if proxy:IsCompleteEvent( 5010 ) ==false then
		proxy:OnDistanceAction( 5010, 10000, 1041, "OnEvent_5010", ItemBoxDist_A, HELPID_CHECK_GLOWING_CORPS, 0, ItemBoxAngle_A, once );
		proxy:TreasureDispModeChange( 1041, true );
	end

	
--■??■徘徊デーモンの登場■ハンドラ登録 --EN:--■??■Appearance of wandering daemon■Handler registration
	proxy:NotNetMessage_begin();
		--プレイヤーがソロで死亡した時にキックされます。 --EN:--Kicked when a player dies solo.
		proxy:LuaCall( 4000, 100, "PlayerDeath_m99_99_10_00", everytime );
		--プレイヤーが復活した時にキックされます。 --EN:--Kicked when the player is revived.
		proxy:LuaCall( 4032, 100, "PlayerRevive_m99_99_10_00", everytime );
	proxy:NotNetMessage_end();
	
	
--■999910■フレーム遅れの初期化処理イベントを発行■ --EN:-- ■ 999910 ■ Generate a frame delay initialization processing event ■
	proxy:NotNetMessage_begin();
		--▼0秒後▼-- --EN:--▼After 0 seconds▼--
		proxy:OnKeyTime2( 999910, "Second_Initialize_m99_99_10_00", 0.1, 0, 0, once );	
	proxy:NotNetMessage_end();	
	
	
	print("Initialize m99_99_10_00 end");
end


--------------------------------------------------------------------------------------
--マルチになった時にホストじゃ無かったら■無し --EN:--If you are not a host when you become multi, no
--------------------------------------------------------------------------------------
function ConnectPartyEvent(proxy)
	print("ConnectPartyEvent begin");
	print("ConnectPartyEvent end");
end


--------------------------------------------------------------------------------------
--Initializeから呼ばれる、1フレーム遅れの初期化処理■999999 --EN:--Initialization with a delay of 1 frame, called from Initialize ■999999
--------------------------------------------------------------------------------------
--■999910■初期化■ --EN:-- ■ 999910 ■ Initialization ■
function Second_Initialize_m99_99_10_00(proxy, param)
	print("Second_Initialize_m99_99_10_00 begin");
	
--[[
	--■徘徊デーモン用 (フラグは仮、指定があれば変える) --EN:--■For wandering daemon (flag is tentative, change if specified)
	if proxy:IsCompleteEvent( 20 ) == true then
		LuaFunc_VisibleTheWanderingDemon  (proxy, param, demon_id_list_m99_99_10_00);
	else
		LuaFunc_InvisibleTheWanderingDemon(proxy, param, demon_id_list_m99_99_10_00);
	end
]]
	
	print("Second_Initialize_m99_99_10_00 end");
end



--■055■マップ移動（→砦1F)■ --EN:-- ■ 055 ■ Move map (→ Fort 1F) ■
function OnEvent_055(proxy, param)
print("OnEvent_055 begin");
	if param:IsNetMessage()==true  then
		return;         
	end

--マルチプレイの時のエリア移動を止める --EN:-- Stop area movement during multiplayer
	if proxy:IsInParty() == true then
		return;
	end 

--・たどり着いたＰＣのみ、砦水路から砦（m99_99_11_00）の指定位置に移動する --EN:--・Only the PCs that arrive move from the fort waterway to the designated position of the fort (m99_99_11_00)
--・移動先（m99_99_11_00）の対応キャライベントID --EN:--・ Corresponding character event ID of destination (m99_99_11_00)
--　ＰＣ（0）→キャラ（10） --EN:-- PC (0) → Character (10)
--　ＰＣ（1）→キャラ（11） --EN:-- PC (1) → Character (11)
--　ＰＣ（2）→キャラ（12） --EN:-- PC (2) → Character (12)
--　ＰＣ（3）→キャラ（13） --EN:-- PC (3) → Character (13)
	playerId = proxy:GetLocalPlayerId();
	if playerId ==0 then proxy:WarpNextStage(99,99,11,00, 10); end
	if playerId ==1 then proxy:WarpNextStage(99,99,11,00, 11); end
	if playerId ==2 then proxy:WarpNextStage(99,99,11,00, 12); end
	if playerId ==3 then proxy:WarpNextStage(99,99,11,00, 13); end

--※移動するキャラクターは、移動時にパッと消してしまいます --EN:--* Characters that move will be erased when moving.

print("OnEvent_055 end");
end







--■065■マップ移動（→砦2F)■ --EN:-- ■ 065 ■ Move map (→ Fort 2F) ■
function OnEvent_065(proxy, param)
print("OnEvent_065 begin");

	if param:IsNetMessage()==true  then
		return;         
	end
--マルチプレイの時のエリア移動を止める --EN:-- Stop area movement during multiplayer
	if proxy:IsInParty() == true then
		return;
	end 

--・たどり着いたＰＣのみ、砦水路から砦（m99_99_11_00）の指定位置に移動する --EN:--・Only the PCs that arrive move from the fort waterway to the designated position of the fort (m99_99_11_00)
--・移動先（m99_99_11_00）の対応キャライベントID --EN:--・ Corresponding character event ID of destination (m99_99_11_00)
--　ＰＣ（0）→キャラ（20） --EN:-- PC (0) → Character (20)
--　ＰＣ（1）→キャラ（21） --EN:-- PC (1) → Character (21)
--　ＰＣ（2）→キャラ（22） --EN:-- PC (2) → Character (22)
--　ＰＣ（3）→キャラ（23） --EN:--PC (3) → Character (23)
	playerId = proxy:GetLocalPlayerId();
	if playerId ==0 then proxy:WarpNextStage(99,99,11,00, 20); end
	if playerId ==1 then proxy:WarpNextStage(99,99,11,00, 21); end
	if playerId ==2 then proxy:WarpNextStage(99,99,11,00, 22); end
	if playerId ==3 then proxy:WarpNextStage(99,99,11,00, 23); end

--※移動するキャラクターは、移動時にパッと消します --EN:--* Characters that move will be erased when moving.

print("OnEvent_065 end");
end


--------------------------------------------------------------------------------------
--■チュートリアル01■移動、カメラ操作説明 --EN:--■Tutorial 01■Explanation of movement and camera operation
--------------------------------------------------------------------------------------
function OnEvent_5020(proxy,param)
	print("OnEvent_5020 begin");
	--メッセージ表示ID：80000000 --EN:--Message Display ID: 80000000
	proxy:OnKeyTime2(5021,"OnEvent_5021",TO_NEXT_MESSAGE_TIME,0,0,once);
	
	proxy:SetEventFlag( 5020 , 1 );
	print("OnEvent_5020 end");
end

--------------------------------------------------------------------------------------
--■チュートリアル02・03■走り方・ステップ、スタミナ説明 --EN:--■Tutorial 02/03 ■How to run/steps, stamina explanation
--------------------------------------------------------------------------------------
function OnEvent_5021(proxy,param)
	print("OnEvent_5021 begin");
	
	proxy:SetEventFlag( 5021 , 1 );
	print("OnEvent_5021 end");
end

--------------------------------------------------------------------------------------
--■チュートリアル04■よじ登り説明 --EN:--■Tutorial 04■Explanation of Climbing
--------------------------------------------------------------------------------------
function OnEvent_5022(proxy,param)
	print("OnEvent_5022 begin");
	
	proxy:SetEventFlag( 5022 , 1 );
	print("OnEvent_5022 end");
end

--------------------------------------------------------------------------------------
--■チュートリアル05■乗り越え説明 --EN:--■Tutorial 05■Explanation of overcoming
--------------------------------------------------------------------------------------
function OnEvent_5023(proxy,param)
	print("OnEvent_5023 begin");
	
	proxy:SetEventFlag( 5023 , 1 );
	print("OnEvent_5023 end");
end

--------------------------------------------------------------------------------------
--■チュートリアル05■左手攻撃・右手攻撃方法説明 --EN:--■Tutorial 05■Explanation of left-hand attack and right-hand attack methods
--------------------------------------------------------------------------------------
function OnEvent_5024(proxy,param)
	print("OnEvent_5024 begin");
	proxy:OnKeyTime2(5025,"OnEvent_5025",TO_NEXT_MESSAGE_TIME,0,0,once);		
	
	proxy:SetEventFlag( 5024 , 1 );
	print("Onevent_5024 end");
end

--------------------------------------------------------------------------------------
--■チュートリアル06■溜め攻撃方法説明 --EN:--■Tutorial 06■Explanation of charge attack method
--------------------------------------------------------------------------------------
function OnEvent_5025(proxy,param)
	print("OnEvent_5025 begin");
	proxy:OnKeyTime2(5026,"OnEvent_5026",TO_NEXT_MESSAGE_TIME,0,0,once);	
	
	proxy:SetEventFlag( 5025 , 1 );
	print("OnEvent_5025 end");
end

--------------------------------------------------------------------------------------
--■チュートリアル07■両手・片手攻撃方法説明 --EN:--■Tutorial 07■Explanation of two-handed and one-handed attacks
--------------------------------------------------------------------------------------
function OnEvent_5026(proxy,param)
	print("OnEvent_5026 begin");
	
	proxy:SetEventFlag( 5026 , 1 );
	print("OnEvent_5026 end");
end

--------------------------------------------------------------------------------------
--■チュートリアル08■魔法攻撃方法説明 --EN:--■Tutorial 08■Explanation of magic attack methods
--------------------------------------------------------------------------------------
function OnEvent_5027(proxy,param)
	print("OnEvent_5027 begin");
	
	proxy:SetEventFlag( 5027 , 1 );
	print("Onevent_5027 end");
end

--------------------------------------------------------------------------------------
--■チュートリアル09■弓矢攻撃方法説明 --EN:--■Tutorial 09■Explanation of how to attack with a bow and arrow
--------------------------------------------------------------------------------------
function OnEvent_5028(proxy,param)
	print("OnEvent_5028 begin");
	proxy:OnKeyTime2(5029,"OnEvent_5029",TO_NEXT_MESSAGE_TIME,0,0,once);

	proxy:SetEventFlag( 5028 , 1 );
	print("Onevent_5028 end");
end

--------------------------------------------------------------------------------------
--■チュートリアル10■武器の入れ替え方法説明 --EN:--■Tutorial 10■Explanation on how to switch weapons
--------------------------------------------------------------------------------------
function OnEvent_5029(proxy,param)
	print("OnEvent_5029 begin");
	
	proxy:SetEventFlag( 5029 , 1 );
	print("Onevent_5029 end");
end

--------------------------------------------------------------------------------------
--■チュートリアル11■アイテム説明 --EN:-- ■ Tutorial 11 ■ Item description
--------------------------------------------------------------------------------------
function OnEvent_5030(proxy,param)
	print("OnEvent_5030 begin");
	
	proxy:SetEventFlag( 5030 , 1 );
	print("Onevent_5030 end");
end

--------------------------------------------------------------------------------------
--■チュートリアル12■実は死体調べるとアイテム取得できるんですよ。 --EN:--■Tutorial 12■Actually, you can get items by examining the corpse.
--------------------------------------------------------------------------------------
function OnEvent_5031(proxy,param)
	print("OnEvent_5031 begin");
	
	proxy:SetEventFlag( 5031 , 1 );
	print("Onevent_5031 end");
end



--------------------------------------------------------------------------------------
--■待機のままの腐敗人■ --EN:--■ Corrupt man on standby ■
--------------------------------------------------------------------------------------
function OnEvent_1100(proxy,param)
	print("OnEvent_1100 begin");

	proxy:PlayLoopAnimation( 100 , 0 );--待機アニメの再生 --EN:--play standby animation
	
	print("Onevent_1100 end");
end



--------------------------------------------------------------------------------------
--■宝死体A■ --EN:-- ■ Treasure corpse A ■
--------------------------------------------------------------------------------------
--■5000■宝死体A■ --EN:-- ■ 5000 ■ treasure corpse A ■
function OnEvent_5000(proxy,param)
	print("OnEvent_5000 begin");

	proxy:PlayAnimation( 10000 , ANIMEID_PICK );
	
	proxy:NotNetMessage_begin();
		--▼5000_1▼0秒後▼ --EN:--▼5000_1▼After 0 seconds▼
		proxy:OnKeyTime2( 5000, "OnEvent_5000_1", 0.0, 0, 0, once );
	proxy:NotNetMessage_end();
	
	print("Onevent_5000 end");
end


--■5000_1■0秒後 アイテムの取得■ --EN:-- ■ 5000_1 ■ After 0 seconds Acquire the item ■
function OnEvent_5000_1(proxy, param)
	print("OnEvent_5000_1 begin");
	
	proxy:SetEventFlag( 5000 , 1 );

--[[ 2種類同時取得は無理･･･? --EN:--[[ It's impossible to get two types at the same time...?

	--ショートボウ --EN:--Short Bow
	proxy:GetItem(130000,TYPE_WEAPON);			 --アイテム取得の表示処理 --EN:-- Display processing for item acquisition
	proxy:AddInventoryItem(130000,TYPE_WEAPON,1);--実際のアイテム取得(数量を変化させる) --EN:--Acquisition of actual item (change quantity)
]]
	--矢 --EN:--arrow
	proxy:GetItem(160000,TYPE_WEAPON);
	proxy:AddInventoryItem(160000,TYPE_WEAPON,99);
	proxy:TreasureDispModeChange( 1040, false ); --アイテムを取得したので、宝が光っているのを消す --EN:--Since you got the item, turn off the glowing treasure
	
	--弓矢攻撃のメッセージ表示 --EN:--Display bow and arrow attack messages
	proxy:OnKeyTime2(5028,"OnEvent_5028",GET_ITEM_TO_NEXT_MESSAGE_TIME,0,0,once);	

	print("OnEvent_5000_1 end");
end


--------------------------------------------------------------------------------------
--■宝死体B■ --EN:-- Treasure corpse B
--------------------------------------------------------------------------------------
--■5010■宝死体B■ --EN:-- ■ 5010 ■ treasure corpse B ■
function OnEvent_5010(proxy,param)
	print("OnEvent_5010 begin");
	
	proxy:PlayAnimation( 10000 , ANIMEID_PICK );
	
	proxy:NotNetMessage_begin();
		--▼5010_1▼0秒後▼ --EN:--▼5010_1▼After 0 seconds▼
		proxy:OnKeyTime2( 5010, "OnEvent_5010_1", 0.0, 0, 0, once );
	proxy:NotNetMessage_end();
	
	print("Onevent_5010 end");
end


--■5010_1■0秒後 アイテムの取得■ --EN:-- ■ 5010_1 ■ After 0 seconds Acquire the item ■
function OnEvent_5010_1(proxy, param)
	print("OnEvent_5010_1 begin");
	
	proxy:SetEventFlag( 5010 , 1 );
	
	--ポーション10個 --EN:--10 potions
	proxy:GetItem(1,TYPE_GOODS);				--アイテム取得の表示処理 --EN:-- Display processing for item acquisition
	proxy:AddInventoryItem(1,TYPE_GOODS,10);	--実際のアイテム取得(数量を変化させる) --EN:--Acquisition of actual item (change quantity)
	proxy:TreasureDispModeChange( 1041, false );--アイテムを取得したので、宝が光っているのを消す --EN:--Since you got the item, turn off the glowing treasure
	
	--アイテム説明のメッセージ表示 --EN:--Display item description message
	proxy:OnKeyTime2(5030,"OnEvent_5030",GET_ITEM_TO_NEXT_MESSAGE_TIME,0,0,once);
	
	print("OnEvent_5010_1 end");
end



--------------------------------------------------------------------------------------
--徘徊デーモンの登場■?? --EN:-- Appearance of the Wandering Demon ??
--------------------------------------------------------------------------------------

--▼グローバルの死亡監視から呼ばれる(ソロ) --EN:--▼ Called from global death watch (solo)
function PlayerDeath_m99_99_10_00(proxy, param)
	print("PlayerDeath_m99_99_10_00");
	
--	LuaFunc_VisibleTheWanderingDemon(proxy, param, demon_id_list_m99_99_10_00);
--	proxy:SetEventFlag( 20 , 1 );--フラグは仮、指定があれば変える。 --EN:The -- flag is tentative, and will be changed if specified.
	
	print("PlayerDeath_m99_99_10_00");
end

--▼グローバルの血文字復活から呼ばれる(ソロ) --EN:--▼Called from global blood letter revival (solo)
function PlayerRevive_m99_99_10_00(proxy,param)
	print("PlayerRevive_m99_99_10_00");
	
--	LuaFunc_InvisibleTheWanderingDemon(proxy, param, demon_id_list_m99_99_10_00);
--	proxy:SetEventFlag( 20 , 0 );--フラグは仮、指定があれば変える。 --EN:The -- flag is tentative, and will be changed if specified.
	
	print("PlayerRevive_m99_99_10_00");
end

