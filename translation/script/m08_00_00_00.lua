once = 1;
everytime = 0;

--奴隷兵士の死んだ数 --EN:--number of dead slave soldiers
DOREIHEISHIDeadCount = 4;

--チュートリアル待ち時間 --EN:--Tutorial waiting time
TUTORIAL_MENU_WAIT =0.5;

--------------------------------------------------------------------------------------
--初期化 --EN:--Initialization
--------------------------------------------------------------------------------------
function Initialize_m08_00_00_00(proxy)
	print("Initialize m08_00_00_00 begin");

--■14080■チュートリアル死亡■ --EN:-- ■ 14080 ■ tutorial death ■
	proxy:SetEventFlag( 14080 , true );--チュートリアル用の死亡フラグON	 --EN:--Tutorial death flag ON
	
--■14160■マップ移動（→砦1F)■ --EN:-- ■ 14160 ■ Move map (→ Fort 1F) ■
	--proxy:OnDistanceAction(14160,10000,1042,"OnEvent_14160",WarpGimmickDist_A,HELPID_CHECK,0,WarpGimmickAngle_B,everytime);

	
--■14000■インフォ表示：移動■ --EN:-- ■ 14000 ■ Info display: Move ■
	proxy:OnRegionJustIn( 14000 , 10000 , 2000 , "OnEvent_14000" , once );
	
--■14011■インフォ表示：カメラ旋回■ --EN:-- ■ 14011 ■ Info display: Camera rotation ■
--(14000から連動) --EN:--(linked from 14000)

--■14001■インフォ表示：右手武具使用（小）■ --EN:-- 14001 ■ Information display: Use right arm (small) ■
	proxy:OnRegionJustIn( 14001 , 10000 , 2001 , "OnEvent_14001" , once );

--■14002■インフォ表示：左手武具使用（ガード）■ --EN:-- ■ 14002 ■ Information display: Left hand weapon use (guard) ■
	proxy:OnRegionJustIn( 14002 , 10000 , 2007 , "OnEvent_14002", once);	

--■14003■インフォ表示：ダッシュ■ --EN:-- ■ 14003 ■ Info display: Dash ■
	proxy:OnRegionJustIn( 14003 , 10000 , 2002 , "OnEvent_14003" , once );
	
--■14004■ロックオン■ --EN:-- ■ 14004 ■ lock on ■
	proxy:OnRegionJustIn( 14004 , 10000 , 2003 , "OnEvent_14004" , once );

--■14005■インフォ表示：光る死体■ --EN:--■14005■Information display: Glowing corpse■
	--proxy:OnRegionJustIn( 14005 , 10000 , 2004 , "OnEvent_14005" , once );

--■14006■インフォ表示：アイテム使用■ --EN:-- ■ 14006 ■ Info display: item use ■
	--proxy:OnRegistFunc( 14006 , "Check_OnEvent_14006" , "OnEvent_14006" , 1 , once );

--■14007■インフォ表示：乗り越え■ --EN:-- ■ 14007 ■ Info display: Get over ■
	proxy:OnRegionJustIn( 14007 , 10000 , 2005 , "OnEvent_14007" , once );

--■14008■インフォ表示：ロックオン■ --EN:-- ■ 14008 ■ Info display: Lock on ■
--	proxy:OnRegionJustIn( 14008 , 10000 , 2006 , "OnEvent_14008" , once );
	
--■14009■インフォ表示：両手持ち替え■ --EN:-- ■ 14009 ■ Information display: Both hands switch ■
--	proxy:OnRegistFunc( 14009 , "Check_OnEvent_14009" , "OnEvent_14009" , 1 , once );

--■14010■インフォ表示：ローリング■ --EN:-- ■ 14010 ■ Info display: Rolling ■
	proxy:OnRegionJustIn( 14010 , 10000 , 2008 , "OnEvent_14010" , once );	
	
--■14013■徘徊ゴースト■ --EN:-- 14013 ■ Wandering Ghost ■
	proxy:OnRegionJustIn( 14013 , 10000 , 2010 , "OnEvent_14013" , once );
	
--■14014■ヒント血文字 --EN:-- ■ 14014 ■ Hint blood letters
	proxy:OnRegionJustIn( 14014 , 10000 , 2011 , "OnEvent_14014" , once );
	
	proxy:SetDrawEnable( 400 , false);
--■14400■徘徊ゴースト目撃■ --EN:-- 14400 ■ Wandering Ghost Sighting ■
	proxy:OnRegionJustIn( 14400 , 10000 , 2050 , "OnEvent_14400" , once );
--■14401■目撃イベントループ■ --EN:-- ■ 14401 ■ sighting event loop ■
--目撃イベント終了から登録 --EN:--Register from the end of the sighting event

--■14160■砦内部にワープ■ --EN:-- ■ 14160 ■ warp inside the fort ■

--■14012■要石出現■ --EN:-- ■ 14012 ■ keystone appears ■
	SingleReset( proxy, 14012 );
	--[[
	if proxy:IsCompleteEvent(14012) == false then
		local eneid = 120;		
		for eneid = 120 , 123 , 1 do
			--奴隷兵士の死亡監視 --EN:--slave soldier death watch
			print("add ",eneid);
			proxy:OnCharacterDead( 14012, eneid ,"OnEvent_14012_"..eneid,once);
		end
	end
	]]
	--proxy:TreasureDispModeChange2( 1042 , true ,KANAME_SFX);
	proxy:TreasureDispModeChange2( 1043 , true ,KANAME_SFX);	
	proxy:OnDistanceAction( 14160 , 10000 , 1042 , "OnEvent_14160" , WarpGimmickDist_A , 10010180 , 0 , 180, everytime );
	
	--要石無効化 --EN:--Keystone disabled
	--proxy:SetColiEnable( 1042 , false );
	--proxy:SetDrawEnable( 1042 , false );
	
	--proxy:SetColiEnable( 1043 , false );
	--proxy:SetDrawEnable( 1043 , false );
	
	--proxy:InvalidSfx( 2070 , false );
	--proxy:InvalidSfx( 2071 , false );
	
--■??■徘徊デーモンの登場■ハンドラ登録 --EN:--■??■Appearance of wandering daemon■Handler registration
	proxy:NotNetMessage_begin();
		--プレイヤーがソロで死亡した時にキックされます。 --EN:--Kicked when a player dies solo.
		proxy:LuaCall( 4000, 100, "PlayerDeath_m08_00_00_00", everytime );
		--プレイヤーが復活した時にキックされます。 --EN:--Kicked when the player is revived.
		proxy:LuaCall( 4032, 100, "PlayerRevive_m08_00_00_00", everytime );
	proxy:NotNetMessage_end();
	
	
--■999910■フレーム遅れの初期化処理イベントを発行■ --EN:-- ■ 999910 ■ Generate a frame delay initialization processing event ■
	proxy:NotNetMessage_begin();
		--▼0秒後▼-- --EN:--▼After 0 seconds▼--
		proxy:OnKeyTime2( 999910, "Second_Initialize_m08_00_00_00", 0.1, 0, 0, once );	
	proxy:NotNetMessage_end();	
	
	--チュートリアル開始ポリ劇 --EN:--Tutorial start polyplay
	proxy:RequestRemo( 80000 , REMO_FLAG , 14162 , 0 );	
	
	print("Initialize m08_00_00_00 end");
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
function Second_Initialize_m08_00_00_00(proxy, param)
	print("Second_Initialize_m08_00_00_00 begin");
	
	proxy:SetDeadMode( 10000 , true );--プレイヤー死ななくなる。 --EN:-- Players no longer die.
	
	--[[ヒント血文字無効テスト --EN:--[[HINT BLOOD LETTER DISABLED TEST
	proxy:InvalidHintMsgId(9000);
	proxy:InvalidHintMsgId(9001);
	proxy:InvalidHintMsgId(9002);
	proxy:InvalidHintMsgId(9003);
	proxy:InvalidHintMsgId(9004);
	proxy:InvalidHintMsgId(9005);
	proxy:InvalidHintMsgId(9006);
	proxy:InvalidHintMsgId(9007);
	]]
	print("Second_Initialize_m08_00_00_00 end");
end



--------------------------------------------------------------------------------------
--要石■14012 --EN:-- Keystone 14012
--------------------------------------------------------------------------------------

function CheckWarpCount(proxy,eneid)
	print("OnEvent_14012_",eneid," begin");	
	local deadCount = 0;
	local ID = 120;	
	
	--奴隷兵士が生きているかの判定 --EN:--Determine if a slave soldier is alive
	for ID = 120, 123, 1 do
		if proxy:IsAlive(ID) == false then
			deadCount = deadCount + 1;
		end
	end
	
	--奴隷兵士が全員死んだら --EN:--If all the slave soldiers die
	if deadCount >= DOREIHEISHIDeadCount then
		proxy:RepeatMessage_begin();
			proxy:OnRegionJustIn( 14012 , 10000 , 2009 , "OnEvent_14012_1" , once );
			proxy:OnKeyTime2( 14161, "OnEvent_14161", 2.0, 0, 0, once);
		proxy:RepeatMessage_end();
	end	
	print("OnEvent_14012_",eneid," end");	
end

--奴隷兵士の死亡監視 --EN:--slave soldier death watch
function OnEvent_14012_120(proxy,param) CheckWarpCount(proxy,120); end--ID120
function OnEvent_14012_121(proxy,param) CheckWarpCount(proxy,121); end--ID121
function OnEvent_14012_122(proxy,param) CheckWarpCount(proxy,122); end--ID122
function OnEvent_14012_123(proxy,param) CheckWarpCount(proxy,123); end--ID123
function OnEvent_14012_124(proxy,param) CheckWarpCount(proxy,124); end--ID124
function OnEvent_14012_125(proxy,param) CheckWarpCount(proxy,125); end--ID125
function OnEvent_14012_126(proxy,param) CheckWarpCount(proxy,126); end--ID126
function OnEvent_14012_127(proxy,param) CheckWarpCount(proxy,127); end--ID127
function OnEvent_14012_128(proxy,param) CheckWarpCount(proxy,128); end--ID128
function OnEvent_14012_129(proxy,param) CheckWarpCount(proxy,129); end--ID129


--■14012_1■要石インフォ■ --EN:-- ■ 14012_1 ■ Keystone Info ■
function OnEvent_14012_1(proxy,param)
	print("OnEvent_14012_1 begin");
		--インフォメーションメッセージの表示 --EN:-- Display information message
	Display_InfomationMenu_2(proxy, 0, -1, 30, 80001200, 1, -1, 30, 80001201, 7);
	Lua_PauseTutorial(proxy);
	proxy:SetEventFlag( 14012 , 1 );
	
	print("OnEvent_14012_1 end");	
end

--■14161■要石表示■ --EN:-- ■ 14161 ■ keystone display ■
function OnEvent_14161(proxy,param)
	print("OnEvent_14161 begin");	
	
	--要石有効化	 --EN:--Keystone activation
	proxy:SetColiEnable( 1042 , true );
	proxy:SetDrawEnable( 1042 , true );
	
	proxy:SetColiEnable( 1043 , true );
	proxy:SetDrawEnable( 1043 , true );
	
	--proxy:ValidSfx( 2070 );
	--proxy:ValidSfx( 2071 );
	
	--[[
	proxy:TreasureDispModeChange( 1042 , true );
	proxy:TreasureDispModeChange( 1043 , true );
	
	proxy:OnDistanceAction( 14160 , 10000 , 1042 , "OnEvent_14160" , WarpGimmickDist_A , 10010180 , 0 , 180, everytime );
	]]
	print("OnEvent_14161 end");
end


function OnEvent_14160(proxy,param)
	
	if proxy:IsCompleteEvent( 14160 ) == true then
		return;
	end
	
	if param:IsNetMessage() == true then
		return;
	end
	
	
	print("OnEvent_14160 begin");
	
	--セッション中ならば、要石のワープ無効 --EN:--Disable keystone warp if in session
	if proxy:IsSession() == false then--セッション中ではない --EN:--not in session
		proxy:RepeatMessage_begin();
		--▼70_1▼選択メニューの監視▼ --EN:--▼70_1▼Select menu monitoring▼
			proxy:OnSelectMenu(14160, "OnEvent_14160_1", 84000000, 0, 2, 1042, 2, once);			
		proxy:RepeatMessage_end();
	else--セッション中 --EN:--in session
		--エラー表示「セッション中は楔の神殿には戻れません」 --EN:--Error display "You cannot return to the Temple of the Wedge during a session"
		--proxy:InfomationMenu( INFOMENU_TYPE_SIMPLE, 0, MSG_CATEGORY_EVENT, 10010720, 1);
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010170, 0, 6, 1042, GEN_DIALOG_DIST, once );
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
	end
	print("OnEvent_14160 end");
end

--■14160■マップ移動（→砦1F)■ --EN:-- ■ 14160 ■ Move map (→ Fort 1F) ■
function OnEvent_14160_1(proxy, param)
	print("OnEvent_14160_1 begin");	
	
	proxy:PlayAnimation( 10000 , 8283 );--要石に触れるアニメを再生	 --EN:--Play the animation that touches the keystone
	proxy:NoAnimeTurnCharactor( 10000 , 1042 ,TURNSKIP_ANGLE);
	proxy:NotNetMessage_begin();
		--▼要石に触れるアニメ再生終了▼ --EN:--▼Animation touching the keystone ends▼
		proxy:OnChrAnimEnd( 14160 , 10000 , 8283 , "OnEvent_14160_2" , once );
	proxy:NotNetMessage_end();	
	proxy:SetEventFlag( 14160, true );
	
	print("OnEvent_14160_1 end");
end

function OnEvent_14160_2(proxy,param)
	print("OnEvent_14160_2 begin");
	playerId = proxy:GetLocalPlayerId();
	proxy:PlayAnimation( 10000 , 8284 );--自世界に帰るアニメを再生 --EN:--Play animation to return to your own world
	if playerId ==0 then proxy:WarpNextStage( 8,01,00,00, 10); end
	if playerId ==1 then proxy:WarpNextStage( 8,01,00,00, 11); end
	if playerId ==2 then proxy:WarpNextStage( 8,01,00,00, 12); end
	if playerId ==3 then proxy:WarpNextStage( 8,01,00,00, 13); end	
	print("OnEvent_14160_2 end");
end


--------------------------------------------------------------------------------------
--インフォ表示：移動■14000 --EN:--Info Display: Move ■14000
--------------------------------------------------------------------------------------
--■14000■インフォ表示用ディレイ■ --EN:-- ■ 14000 ■ Info display delay ■
function OnEvent_14000(proxy,param)
	print("OnEvent_14000 begin");
	proxy:OnKeyTime2(14000,"OnEvent_14000_1",2,0,0,once);
	print("OnEvent_14000 end");
end

--■14000_1■インフォ表示：移動■ --EN:-- ■ 14000_1 ■ Info display: Move ■
function OnEvent_14000_1(proxy , param)
	print("OnEvent_14000_1 begin");
	
	--インフォメーションメッセージの表示 --EN:-- Display information message
	Display_InfomationMenu_2(proxy, 0, -1, 30, 80000000, 1, -1, 30, 80000001, 7);
	Lua_PauseTutorial(proxy);
	proxy:SetEventFlag( 14000 , 1 );	
	
	--▼14011▼インフォ表示：カメラ旋回へ▼ --EN:--▼14011▼Information display: Camera rotation▼
	--proxy:OnKeyTime2( 14011 , "OnEvent_14011" , 1.0 , 0 , 1 , once );
	
	print("OnEvent_14000_1 end");
end

--[[
--▲14011▲インフォ表示：カメラ旋回▲ --EN:--▲14011▲Information display: Camera rotation▲
function OnEvent_14011(proxy , param)
	print("OnEvent_14011 begin");
	
	--インフォメーションメッセージの表示 --EN:-- Display information message
	Display_InfomationMenu_2(proxy, 0, -1, 30, 80001100, 1, -1, 30, 80001101, 7);
--	Lua_PauseTutorial(proxy);
	proxy:SetEventFlag( 14011 , 1 );

	print("OnEvent_14011 end");
end
]]


--------------------------------------------------------------------------------------
--インフォ表示：右手武具使用（小）■14001 --EN:--Information display: use right arm (small) ■14001
--------------------------------------------------------------------------------------

--■14001■インフォ表示：右手武具使用（小）■ --EN:-- 14001 ■ Information display: Use right arm (small) ■
function OnEvent_14001(proxy , param)
	print("OnEvent_14001 begin");
	
	--インフォメーションメッセージの表示 --EN:-- Display information message
	Display_InfomationMenu_2(proxy, 0, -1, 30, 80000100, 1, -1, 30, 80000101, 7);
	Lua_PauseTutorial(proxy);
	proxy:SetEventFlag( 14001 , 1 );
	
	print("OnEvent_14001 end");
end


--------------------------------------------------------------------------------------
--インフォ表示：左手武具使用（ガード）■14002 --EN:--Information display: left hand weapon use (guard) 14002
--------------------------------------------------------------------------------------
--■14002■インフォ表示：左手武具使用（ガード）メッセージ表示■ --EN:-- 14002 ■ Information display: left hand weapon use (guard) message display ■
function OnEvent_14002(proxy , param)
	print("OnEvent_14002 begin");
	--インフォメーションメッセージの表示 --EN:-- Display information message
	Display_InfomationMenu_2(proxy, 0, -1, 30, 80000200, 1, -1, 30, 80000201, 7);
	Lua_PauseTutorial(proxy);
	proxy:SetEventFlag( 14002 , 1 );	
	print("OnEvent_14002 end");
end




--------------------------------------------------------------------------------------
--インフォ表示：ダッシュ■14003 --EN:--Info Display: Dash ■14003
--------------------------------------------------------------------------------------

--■14003■インフォ表示：ダッシュ■ --EN:-- ■ 14003 ■ Info display: Dash ■
function OnEvent_14003(proxy , param)
	print("OnEvent_14003 begin");
	
	--インフォメーションメッセージの表示 --EN:-- Display information message
	Display_InfomationMenu_2(proxy, 0, -1, 30, 80000300, 1, -1, 30, 80000301, 7);
	Lua_PauseTutorial(proxy);
	proxy:SetEventFlag( 14003 , 1 );
	
	print("OnEvent_14003 end");
end


--------------------------------------------------------------------------------------
--インフォ表示：ロックオン■14004 --EN:--Information display: lock on 14004
--------------------------------------------------------------------------------------

--■14004■インフォ表示：ロックオン■ --EN:-- ■ 14004 ■ Info display: Lock on ■
function OnEvent_14004(proxy , param)
	print("OnEvent_14004 begin");
	
	--インフォメーションメッセージの表示 --EN:-- Display information message
	Display_InfomationMenu_2(proxy, 0, -1, 30, 80000800, 1, -1, 30, 80000801, 7);
	Lua_PauseTutorial(proxy);
	proxy:SetEventFlag( 14004 , 1 );
	
	print("OnEvent_14004 end");
end

--[[
--------------------------------------------------------------------------------------
--インフォ表示：光る死体■14005 --EN:--Information display: glowing corpse ■14005
--------------------------------------------------------------------------------------

--■14005■インフォ表示：光る死体■ --EN:--■14005■Information display: Glowing corpse■
function OnEvent_14005(proxy , param)
	print("OnEvent_14005 begin");
	
	--インフォメーションメッセージの表示 --EN:-- Display information message
	Display_InfomationMenu_2(proxy, 0, -1, 30, 80000500, 1, -1, 30, 80000501, 7);
--	Lua_PauseTutorial(proxy);
	proxy:SetEventFlag( 14005 , 1 );
	
	print("OnEvent_14005 end");
end
]]

--[[
--------------------------------------------------------------------------------------
--インフォ表示：アイテム使用■14006 --EN:--Information display: item use ■14006
--------------------------------------------------------------------------------------

--■対応する敵の死亡監視 --EN:--■ Death Watch for Corresponding Enemy
function Check_OnEvent_14006(proxy , param)

	if proxy:IsCompleteEvent( 14050 ) == true then
		print("宝死体からアイテム取得しました (ID:14050)"); --EN:print("I got the item from the treasure corpse (ID:14050)");
		return true;
	end

	return false;
end


--■14006■インフォ表示：アイテム使用■ --EN:-- ■ 14006 ■ Info display: item use ■
function OnEvent_14006(proxy , param)
	print("OnEvent_14006 begin");

	--▼14006▼メッセージ表示▼ --EN:--▼14006▼Message display▼
	proxy:OnKeyTime2( 14006 , "OnEvent_14006_1" , 5.0 , 0 , 1 , once );
	
	print("OnEvent_14006 end");	
end


--▲14006_1▲メッセージ表示▲ --EN:--▲14006_1▲Message Display▲
function OnEvent_14006_1(proxy , param)
	print("OnEvent_14006_1 begin");
	
	--インフォメーションメッセージの表示 --EN:-- Display information message
	Display_InfomationMenu_2(proxy, 0, -1, 30, 80000600, 1, -1, 30, 80000601, 7);
--	Lua_PauseTutorial(proxy);
	proxy:SetEventFlag( 14006 , 1 );
	
	print("OnEvent_14006_1 end");
end
]]


--------------------------------------------------------------------------------------
--インフォ表示：乗り越え■14007 --EN:--Information display: Get over 14007
--------------------------------------------------------------------------------------

--■14007■インフォ表示：乗り越え■ --EN:-- ■ 14007 ■ Info display: Get over ■
function OnEvent_14007(proxy , param)
	print("OnEvent_14007 begin");
	
	--インフォメーションメッセージの表示 --EN:-- Display information message
	Display_InfomationMenu_2(proxy, 0, -1, 30, 80000700, 1, -1, 30, 80000701, 7);
	Lua_PauseTutorial(proxy);
	proxy:SetEventFlag( 14007 , 1 );
	
	print("OnEvent_14007 end");
end


--------------------------------------------------------------------------------------
--インフォ表示：ロックオン■14008 --EN:--Information display: lock on 14008
--------------------------------------------------------------------------------------

--■14008■インフォ表示：ロックオン■ --EN:-- ■ 14008 ■ Info display: Lock on ■
function OnEvent_14008(proxy , param)
	print("OnEvent_14008 begin");
	
	--インフォメーションメッセージの表示 --EN:-- Display information message
	Display_InfomationMenu_2(proxy, 0, -1, 30, 80000800, 1, -1, 30, 80000801, 7);
--	Lua_PauseTutorial(proxy);
	proxy:SetEventFlag( 14008 , 1 );
	
	print("OnEvent_14008 end");
end


--------------------------------------------------------------------------------------
--インフォ表示：両手持ち替え■14009 --EN:--Information display: Both hands switch 14009
--------------------------------------------------------------------------------------

enemy_first_id_use_14009 = {120,121,122,123,124,125,126,127,128,129};
enemy_num_use_14009 = table.getn( enemy_first_id_use_14009 );
COUNT_DEAD_NUM_USE_14009 = 3;

--■対応する敵の死亡監視 --EN:--■ Death Watch for Corresponding Enemy
function Check_OnEvent_14009(proxy , param)

	local dead_num_count = 0;
	for i=1, enemy_num_use_14009, 1 do
		if proxy:IsAlive( enemy_first_id_use_14009[i] ) == false then
			dead_num_count = dead_num_count + 1;
		end
	end
		
	if dead_num_count >= COUNT_DEAD_NUM_USE_14009 then
		print("ID:120 ～ 129 の" .. dead_num_count .. "体 死にました。"); --EN:print("ID: 120 to 129" .. dead_num_count .. "body died.");
		return true;
	end

	return false;
end


--■14009■インフォ表示：両手持ち替え■ --EN:-- ■ 14009 ■ Information display: Both hands switch ■
function OnEvent_14009(proxy , param)
	print("OnEvent_14009 begin");

	--▼14009▼メッセージ表示▼ --EN:--▼14009▼Message display▼
	proxy:OnKeyTime2( 14009 , "OnEvent_14009_1" , 1.0 , 0 , 1 , once );
	
	print("OnEvent_14009 end");	
end


--▲14009_1▲メッセージ表示▲ --EN:--▲14009_1▲Message Display▲
function OnEvent_14009_1(proxy , param)
	print("OnEvent_14009_1 begin");
	
	--インフォメーションメッセージの表示 --EN:-- Display information message
	Display_InfomationMenu_2(proxy, 0, -1, 30, 80000900, 1, -1, 30, 80000901, 7);
--	Lua_PauseTutorial(proxy);
	proxy:SetEventFlag( 14009 , 1 );
	
	print("OnEvent_14009_1 end");
end





--------------------------------------------------------------------------------------
--インフォ表示：ローリング■14010 --EN:--Info Display: Rolling■14010
--------------------------------------------------------------------------------------
--■14010■インフォ表示：ローリング■ --EN:-- ■ 14010 ■ Info display: Rolling ■
function OnEvent_14010(proxy , param)
	print("OnEvent_14010 begin");

	--インフォメーションメッセージの表示 --EN:-- Display information message
	Display_InfomationMenu_2(proxy, 0, -1, 30, 80001000, 1, -1, 30, 80001001, 7);
	Lua_PauseTutorial(proxy);
	proxy:SetEventFlag( 14010 , 1 );
	
	print("OnEvent_14010 end");	
end


--------------------------------------------------------------------------------------
--インフォ表示：徘徊ゴースト■14013 --EN:--Info Display: Wandering Ghost 14013
--------------------------------------------------------------------------------------
function OnEvent_14013(proxy,param)
	print("OnEvent_14013 beign");
	
	--インフォメーションメッセージの表示 --EN:-- Display information message
	Display_InfomationMenu_2(proxy, 0, -1, 30, 80001100, 1, -1, 30, 80001101, 7);
	Lua_PauseTutorial(proxy);
	proxy:SetEventFlag( 14013 , 1 );
	
	print("OnEvent_14013 end");
end


--------------------------------------------------------------------------------------
--インフォ表示：ヒント血文字■14014 --EN:--Information display: Hint blood letter ■14014
--------------------------------------------------------------------------------------
function OnEvent_14014(proxy,param)
	print("OnEvent_14014 beign");
	
	--インフォメーションメッセージの表示 --EN:-- Display information message
	Display_InfomationMenu_2(proxy, 0, -1, 30, 80001300, 1, -1, 30, 80001301, 7);
	Lua_PauseTutorial(proxy);
	proxy:SetEventFlag( 14014 , 1 );
	
	print("OnEvent_14014 end");
end


--------------------------------------------------------------------------------------
--徘徊デーモンの登場■?? --EN:-- Appearance of the Wandering Demon ??
--------------------------------------------------------------------------------------

--▼グローバルの死亡監視から呼ばれる(ソロ) --EN:--▼ Called from global death watch (solo)
function PlayerDeath_m08_00_00_00(proxy, param)
	print("PlayerDeath_m08_00_00_00");
	print("PlayerDeath_m08_00_00_00");
end

--▼グローバルの血文字復活から呼ばれる(ソロ) --EN:--▼Called from global blood letter revival (solo)
function PlayerRevive_m08_00_00_00(proxy,param)
	print("PlayerRevive_m08_00_00_00");
	print("PlayerRevive_m08_00_00_00");
end


--------------------------------------------------------------------------------------
--砦入り口での死亡■無し --EN:--No deaths at the fort entrance
--------------------------------------------------------------------------------------
function m08_00Death(proxy,param)
	print("m08_00Death begin");
	--proxy:SetMapUid( 8, 0, 0, 0, -1 );			
	proxy:SetHp( 10000, 1 );
	--召還位置に再出現	 --EN:--Respawn at summon position
	proxy:OnKeyTime2(4000,"m08_00Death_Load",1.5,0,10,once);	
	proxy:SetEventFlag(4000,true);
	print("m08_00Death end");
end

function m08_00Death_Load(proxy,param)
	print("m08_00Death_Load begin");
	--ワープを行う --EN:--do warp
	--proxy:WarpNextStageKick();
	proxy:WarpRestart(10000,-1);
	proxy:OnKeyTime2(14170,"OnEvent_14170",1.0,0,0,once);
	print("m08_00Death_Load end");
end

--------------------------------------------------------------------------------------
--砦入り口での死亡後のシステムメニュー■14170 --EN:-- System menu after death at the fort entrance 14170
--------------------------------------------------------------------------------------
function OnEvent_14170(proxy,param)
	print("OnEvent_14170 begin");
	Display_InfomationMenu_2(proxy, 0, -1, 30, 89999999, 1, -1, 30, 88999900, 6);
--	Lua_PauseTutorial(proxy);
	proxy:SetEventFlag(4000,false);
	print("OnEvent_14170 end");
end

--------------------------------------------------------------------------------------
--徘徊ゴースト目撃イベント■14400 --EN:--Wandering Ghost Sighting Event 14400
--------------------------------------------------------------------------------------
function OnEvent_14400(proxy,param)
    proxy:SetDrawEnable( 400 , true );  
    proxy:SetColiEnable( 400 , false );
    proxy:OnWanderFade(14400,400,2.0,2.0,9.0,10.0,once);
    MoveRegion(proxy, 400, 2052, 9 ,0.0,false);
    proxy:RepeatMessage_begin();
        proxy:OnKeyTime2(14400,"OnEvent_14400_end",9.0,0,0,once);
    proxy:RepeatMessage_end();
end

--[[
--フェードアウト開始 --EN:--Fade out start
function OnEvent_14400_fadeOut(proxy,param)
	--proxy:ChrFadeOut(400, 2.0 , 1.0 );
	proxy:RepeatMessage_begin();
		proxy:OnKeyTime2(14400,"OnEvent_14400_end",2.0,0,1,once);
	proxy:RepeatMessage_end();
end
]]

--移動イベント終了 --EN:--Moving event ends
function OnEvent_14400_end(proxy,param)
	proxy:RepeatMessage_begin();
		proxy:Warp( 400 , 2051 );
		proxy:OnKeyTime2( 14401 , "OnEvent_14401",10,0,0,once);
	proxy:RepeatMessage_end();
end


--目撃イベントリピート --EN:--witness event repeat
function OnEvent_14401(proxy,param)
	OnEvent_14400(proxy,param);
end
