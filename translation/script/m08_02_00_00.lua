once = 1;
everytime = 0;

--------------------------------------------------------------------------------------
--初期化 --EN:--Initialization
--------------------------------------------------------------------------------------
function Initialize_m08_02_00_00(proxy)
print("Initialize m08_02_00_00 begin");


--■14337■チュートリアル死亡■ --EN:-- ■ 14337 ■ tutorial death ■
	proxy:SetEventFlag(14337,true);--溶岩用死亡分岐フラグON --EN:--Death branch flag ON for lava

--■20■ドラデーモンに殺される①→準備■ --EN:-- ■ 20■ Killed by Dora Demon → Preparation ■
	--proxy:OnRegionJustIn( 14345 , 10000 , 2410 , "OnEvent_14345" , everytime );--everytime
	
--■14350■ドラデーモンに殺される②→殺される■ --EN:-- ■ 14350 ■ Killed by Dora Demon → Killed ■
	proxy:OnRegionJustIn( 14350 , 10000 , 2412 , "OnEvent_14350" , once );
	
	--ポリ劇開始フェード後に呼ばれるハンドラ --EN:--Handler called after polyplay start fade
	proxy:LuaCall(14350,REMO_START,"OnEvent_14350_RemoStart",once);
	--ポリ劇終了後に呼ばれるハンドラ --EN:--Handler called after the polyplay ends
	proxy:LuaCall(14350,REMO_FINISH,"OnEvent_14350_RemoFinish",once);
		

--■??■徘徊デーモンの登場■ハンドラ登録 --EN:--■??■Appearance of wandering daemon■Handler registration
	proxy:NotNetMessage_begin();
		--プレイヤーがソロで死亡した時にキックされます。 --EN:--Kicked when a player dies solo.
		proxy:LuaCall( 4000, 100, "PlayerDeath_m08_02_00_00", everytime );
		--プレイヤーが復活した時にキックされます。 --EN:--Kicked when the player is revived.
		proxy:LuaCall( 4032, 100, "PlayerRevive_m08_02_00_00", everytime );
	proxy:NotNetMessage_end();
	
	
--■999912■フレーム遅れの初期化処理イベントを発行■ --EN:-- ■ 999912 ■ Generate a frame delay initialization processing event ■
	proxy:NotNetMessage_begin();
		--▼0秒後▼-- --EN:--▼After 0 seconds▼--
		proxy:OnKeyTime2( 999912, "Second_Initialize_m08_02_00_00", 0.1, 0, 0, once );	
	proxy:NotNetMessage_end();

	proxy:SetEventFlag(4000,false);


--proxy:LuaCall( 1111 , 1 , "test" , everytime );

	
print("Initialize m08_02_00_00 end");
end

--[[
function test(proxy, param)
print("force dead");
	proxy:SetDeadMode( 10000 , false );
	proxy:ForceDead( 10000 );
end
]]



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
--■999912■初期化■ --EN:-- ■ 999912 ■ Initialization ■
function Second_Initialize_m08_02_00_00(proxy, param)
	print("Second_Initialize_m08_02_00_00 begin");

--	proxy:PlayerRecover();--プレイヤー全回復 --EN:-- Player full recovery
--	proxy:SetHp( 10000 , 1.0 );
--	proxy:SetDeadMode( 10000 , true );--プレイヤー死ななく --EN:--Player never die
	
	print("Second_Initialize_m08_02_00_00 end");
end



--------------------------------------------------------------------------------------
--徘徊デーモンの登場■?? --EN:-- Appearance of the Wandering Demon ??
--------------------------------------------------------------------------------------

--▼グローバルの死亡監視から呼ばれる(ソロ) --EN:--▼ Called from global death watch (solo)
function PlayerDeath_m08_02_00_00(proxy, param)
	print("PlayerDeath_m08_02_00_00");
	
--	LuaFunc_VisibleTheWanderingDemon(proxy, param, demon_id_list_m08_02_00_00);
--	proxy:SetEventFlag( 20 , 1 );--フラグは仮、指定があれば変える。 --EN:The -- flag is tentative, and will be changed if specified.
	
	print("PlayerDeath_m08_02_00_00");
end

--▼グローバルの血文字復活から呼ばれる(ソロ) --EN:--▼Called from global blood letter revival (solo)
function PlayerRevive_m08_02_00_00(proxy,param)
	print("PlayerRevive_m08_02_00_00");
	
--	LuaFunc_InvisibleTheWanderingDemon(proxy, param, demon_id_list_m08_02_00_00);
--	proxy:SetEventFlag( 20 , 0 );--フラグは仮、指定があれば変える。 --EN:The -- flag is tentative, and will be changed if specified.
	
	print("PlayerRevive_m08_02_00_00");
end




--[[
--------------------------------------------------------------------------------------
--ドラデーモンに殺される①(準備)■20 --EN:--Killed by Dora Demon (Preparation) 20
--------------------------------------------------------------------------------------
function OnEvent_14345(proxy,param)
	print("OnEvent_14345 begin");	
	proxy:PlayLoopAnimation( 599 , 990021 );--待機アニメループ再生 --EN:--Standby animation loop playback
	proxy:SetEventFlag(14345,true);
	print("OnEvent_14345 end");
end
]]

--------------------------------------------------------------------------------------
--ドラデーモンに殺される②(殺される)■14350 生存のときよう --EN:--Killed by Doradamon (Killed) 14350 How to survive
--------------------------------------------------------------------------------------
function OnEvent_14350(proxy,param)
	print("OnEvent_14350 begin");
	
	proxy:RequestRemo( 80200 , REMO_FLAG, 14350 , 1);

	print("OnEvent_14350 end");
end

	
	

--▲攻撃アニメ①の終了▲ --EN:--▲End of attack animation▲
function OnEvent_14350_RemoStart(proxy,param)
	print("OnEvent_14350_RemoStart begin");
	print("OnEvent_14350_RemoStart end");
end



--[[
--▲攻撃アニメ②の終了▲ --EN:--▲End of attack animation▲
function OnEvent_14350_2(proxy,param)	
	proxy:PlayAnimation( 599 , 990024 );--攻撃アニメ③の再生	 --EN:--play attack animation
end
]]

--▲メッセージをだすまでの時間を空ける▲ --EN:-- ▲ Leave some time before sending a message ▲
function OnEvent_14350_RemoFinish(proxy,param)	
	print("OnEvent_14350_RemoFinish begin");	
	--インフォメーションメッセージの表示 --EN:-- Display information message
	--Display_InfomationMenu_2(proxy, 0, -1, 30, 89999999, 1, -1, 30, 88999901, 6);
	--Lua_PauseTutorial(proxy);
	proxy:SetTextEffect(TEXT_TYPE_Dead);
	InvalidCharactor( proxy,10000);
	
	--▼チュートリアル終了までの時間を空ける▼ --EN:--▼ Leave some time until the end of the tutorial ▼
	proxy:OnKeyTime2( 14381 , "OnEvent_14381_1" , 3.0 , 0 , 2 , once );	
	print("OnEvent_14350_RemoFinish end");
end


--▲チュートリアル終了までの時間を空ける▲ --EN:-- ▲ Allow some time until the end of the tutorial ▲
function OnEvent_14381_1(proxy,param)	
	print("OnEvent_14381_1 begin");	
	proxy:OnRegistFunc( 14381 , "Check_14381","OnEvent_14381_2",1,once);	
	print("OnEvent_14381_1 end");
end

function Check_14381(proxy)
	if proxy:IsShowMenu() == true then
		return false;
	end
	return true;
end

function OnEvent_14381_2(proxy,param)
	print("OnEvent_14381_2 begin");
	proxy:OnKeyTime2( 14381 , "OnEvent_14381_3",1.0,0,0,once);
	print("OnEvent_14381_2 end");
end


--石柱へのワープ --EN:--Warp to Stone Pillar
function OnEvent_14381_3(proxy,param)
	print("OnEvent_14381_3 begin");
	proxy:SetEventFlag( 14381 , 1 );--このイベントのフラグON --EN:--Flag ON for this event
	proxy:SetEventFlag( 14337 , 0 );--チュートリアル死亡フラグOFF --EN:--Tutorial death flag OFF
	proxy:SetEventFlag( 4000 , 0 );--プレイヤー死亡フラグOFF --EN:--Player death flag OFF
	
	proxy:RevivePlayer();
	
	--チュートリアルマップ3ではマップ開始時から必ずグレイゴーストになる必要がある。 --EN:--In tutorial map 3, it is necessary to become a gray ghost from the beginning of the map.
	--このタイミングでグレイゴーストに変わっておけば、必要な処理をグローバルの処理で --EN:-- If you change to gray ghost at this timing, you can do the necessary processing with global processing
	--行ってくれる。(=正規のグレイゴーストになれる) --EN:--He will go. (= Become a regular gray ghost)
	proxy:ChangeGreyGhost();
	
	proxy:Tutorial_end();
	--石柱の入り口にワープ --EN:--Warp to the entrance of the stone pillar
	--完全回復要求 --EN:-- full recovery request
	proxy:RequestFullRecover();
	proxy:WarpNextStage( 1,0,0,0,-1);
	print("OnEvent_14381_3 end");
end



--似非セッションの開始　（仮） --EN:--Start of fake session (tentative)
--SOS魔法発動したかをとって、1回目だったら似非セッション開始 --EN:--If it's the first time, start a fake session based on whether the SOS magic was activated
--チュートリアルの場合でm08_02でSOSをだせば毎回呼ばれる --EN:--In the case of the tutorial, it will be called every time you issue an SOS with m08_02
function OnEvent_Catch_SOS(proxy,param)	

--[[処理がなくなったのでけしました]] --EN:--[[It was deleted because there was no processing]]

end


--▲3秒後▲ --EN:--▲After 3 seconds▲
function OnEvent_Catch_SOS_2(proxy,param)	
	
	--召還位置にワープフラグをON --EN:-- Turn on the warp flag at the summon position
	proxy:SetSummonedPos();
	--チュートリアル召還位置を記憶するように設定 --EN:-- Set to memorize the tutorial summon position
	proxy:SetTutorialSummonedPos();
	--血文字無効化SOS忘却 --EN:--Blood letter invalidation SOS oblivion
	proxy:InvalidMyBloodMarkInfo();
	
	--ローディング --EN:--Loading
	playerId = proxy:GetLocalPlayerId();
	if playerId ==0 then proxy:WarpNextStage( 8,02,00,00, 30); end
	if playerId ==1 then proxy:WarpNextStage( 8,02,00,00, 31); end
	if playerId ==2 then proxy:WarpNextStage( 8,02,00,00, 32); end
	if playerId ==3 then proxy:WarpNextStage( 8,02,00,00, 33); end
end


--▲3秒後>生存が領域（1420）に入った▲ --EN:--▲After 3 seconds> Survival entered area (1420)▲
function OnEvent_BlackGhost(proxy,param)
	print("OnEvent_BlackGhost begin");
	proxy:OnKeyTime2(14390,"OnEvent_BlackGhost_1",1,0,0,once);
	proxy:EnableLogic(500,false);
	print("OnEvent_BlackGhost end");
end

--1秒後 --EN:--1 second later
function OnEvent_BlackGhost_1(proxy,param)
	proxy:SetChrType( 501 , CHR_TYPE_BlackGhost ); --ブラックゴーストになっておく(ID501) --EN:--Be a black ghost (ID501)
	--(↑今はならないかもしれない) --EN:--(↑May not be now)
	proxy:EnableLogic(500,true);
	ValidCharactor(proxy, 501);--ブラックゴースト役の人出現 --EN:-- Appearance of the person who plays the role of Black Ghost
	--proxy:ForceChangeTarget(501,500);
	proxy:ResetThink(501);
	print( "draw npc id 501 " );
	
	--インフォメーションメニュー --EN:--Information menu
	proxy:InfomationMenu(0,-1,30,89200020,1);
	proxy:AddInfomationList(-1,30,86002000);
	proxy:AddInfomationList(-1,30,86002001);
	proxy:AddInfomationList(-1,30,86002002);
	proxy:AddInfomationList(-1,30,86002003);
	proxy:AddInfomationList(-1,30,86002004);
	proxy:AddInfomationList(-1,30,86002005);
	proxy:AddInfomationList(-1,30,86002006);	
	--ブラックゴースト召還されました --EN:-- Black Ghost summoned
end



--------------------------------------------------------------------------------------
--似非セッションのときの生存プレイヤー役の人の死亡監視■ --EN:--Monitoring the death of a surviving player during a fake session
--------------------------------------------------------------------------------------
function OnEvent_NPC500_Dead( proxy,param )

	print( "npc 500 is dead" );
	
	--ここで解散説明のインフォメニュー --EN:--Here is the info menu for the dissolution explanation
	proxy:OnKeyTime2(4000,"m08_02Death_2",4,0,0,once);
	--[[
	--解散の処理 --EN:--Dissolution processing
	
	--NPCを消す(似非セッションは1回しかできないことが前提) --EN:--Erase the NPC (assuming that you can only have one fake session)
	InvalidCharactor(proxy, 500);--生存プレイヤー役 --EN:--Surviving player role
	InvalidCharactor(proxy, 501);--ブラックゴースト役 --EN:--The role of Black Ghost
	
	
	--テスト用 --EN:--for test
	proxy:SetChrType( 10000 , CHR_TYPE_GreyGhost );
	proxy:WarpRestart( 10000 , 75 );--入り口の近くにある領域にとぶ --EN:--fly to the area near the entrance
	proxy:SetHp( 10000 , 1.0 );
	proxy:DisableMove( 10000 , false );
	]]
end


--------------------------------------------------------------------------------------
--SOS説明■14355  --EN:--SOS description ■14355
--------------------------------------------------------------------------------------
function OnEvent_14355(proxy,param)
	print("OnEvent_14355 begin");
	--インフォメーションメニュー表示 --EN:--Information menu display
	proxy:InfomationMenu(0,-1,30,89200000,1);
	proxy:AddInfomationList(-1,30,86000000);
	proxy:AddInfomationList(-1,30,86000001);
	proxy:AddInfomationList(-1,30,86000002);
	proxy:AddInfomationList(-1,30,86000003);
	proxy:AddInfomationList(-1,30,86000004);
	proxy:AddInfomationList(-1,30,86000005);
	proxy:AddInfomationList(-1,30,86000006);
	print("OnEvent_14355 end");
end


--------------------------------------------------------------------------------------
--PC召喚される説明■14360  --EN:--PC summoned explanation■ 14360
--------------------------------------------------------------------------------------
function OnEvent_14360(proxy,param)
	print("OnEvent_14360 begin");
	--インフォメーションメニュー表示 --EN:--Information menu display
	proxy:InfomationMenu(0,-1,30,89200010,1);
	proxy:AddInfomationList(-1,30,86001000);
	proxy:AddInfomationList(-1,30,86001001);
	proxy:AddInfomationList(-1,30,86001002);
	proxy:AddInfomationList(-1,30,86001003);
	proxy:AddInfomationList(-1,30,86001004);
	proxy:AddInfomationList(-1,30,86001005);
	proxy:AddInfomationList(-1,30,86001006);
	proxy:AddInfomationList(-1,30,86001007);
	proxy:AddInfomationList(-1,30,86001008);
	proxy:AddInfomationList(-1,30,86001009);
	proxy:AddInfomationList(-1,30,86001010);
	proxy:AddInfomationList(-1,30,86001011);
	proxy:AddInfomationList(-1,30,86001012);
	proxy:AddInfomationList(-1,30,86001013);
	
	print("OnEvent_14360 end");
end

--------------------------------------------------------------------------------------
--マルチ解散説明■14370  --EN:--Multi-dissolution explanation ■14370
--------------------------------------------------------------------------------------
function OnEvent_14370(proxy,param)
	print("OnEvent_14370 begin");
	--インフォメーションメニュー表示 --EN:--Information menu display
	proxy:InfomationMenu(0,-1,30,89200030,1);
	proxy:AddInfomationList(-1,30,86003000);
	proxy:AddInfomationList(-1,30,86003001);
	proxy:AddInfomationList(-1,30,86003002);
	proxy:AddInfomationList(-1,30,86003003);
	proxy:AddInfomationList(-1,30,86003004);
	proxy:AddInfomationList(-1,30,86003005);
	proxy:AddInfomationList(-1,30,86003006);
	print("OnEvent_14370 end");
end


--------------------------------------------------------------------------------------
--SOS無効領域監視■ --EN:--SOS invalid area monitoring■
--------------------------------------------------------------------------------------
function OnEvent_14410(proxy,param)
	print("OnEvent_14410 begin");
	--SOS無効用フラグON --EN:--SOS disable flag ON
	proxy:SetEventFlag(14410,true);
	print("OnEvent_14410 end");	
end


--------------------------------------------------------------------------------------
--チュートリアル死亡処理の流れ■グローバルから分岐してきます --EN:--Tutorial flow of death process ■ Branches from global
--------------------------------------------------------------------------------------
function m08_02Death(proxy,param)
	print("m08_02Death begin");
	
--[[	
	
	--１回目生存＞グレイへの死亡 --EN:--First Survival > Death to Gray
	if proxy:GetLocalPlayerChrType() == CHR_TYPE_LivePlayer then
		--ドラ待機フラグOFF --EN:--Dra standby flag OFF
		proxy:SetEventFlag(14345,false);
		proxy:OnKeyTime2(4000,"m08_02Death_1",1.5,0,0,once);
	end	
	
	--２回目ホワイト＞グレイへの死亡 --EN:-- 2nd White > Death to Gray
	if proxy:GetLocalPlayerChrType() == CHR_TYPE_WhiteGhost then
		proxy:OnKeyTime2(4000,"m08_02Death_2",1.5,0,0,once);		
	end
]]	
--[[
	proxy:NotNetMessage_begin();
	--３回目グレイ＞トゥルーデスへの死亡 --EN:-- 3rd Gray > Death to Trudes
	if proxy:GetLocalPlayerChrType() == CHR_TYPE_GreyGhost then
		proxy:OnKeyTime2(4000,"m08_02Death_3",1.5,0,0,once);				
	end
	
	proxy:NotNetMessage_end();
]]
	proxy:SetEventFlag(4000,true);	

	print("m08_02Death end");
end

--1回目の死亡 --EN:--First death
function m08_02Death_1(proxy,param)
	print("m08_02Death_1 begin");
	proxy:OnBloodMenuClose(4000,"m08_02Death_1_1",300.0, once);
	print("m08_02Death_1 end");
end

--1回目の死亡：血文字入力待ち --EN:--First death: Waiting for blood letter input
function m08_02Death_1_1(proxy,param)
	print("m08_02Death_1_1 begin");
	proxy:SetMapUid( 8, 2, 0, 0, -1 );		
	--グレイゴースト化 --EN:--Gray ghost
	proxy:ChangeGreyGhost();
	proxy:SetHp( 10000, 1 );
	--死亡状況判定用 --EN:--For judging the state of death
	proxy:SetEventFlag(14351,true);	
	proxy:OnKeyTime2(4000,"m08_02Death_Load",0.1,0,10,once);	
	print("m08_02Death_1_1 end");
end


--２回目の死亡 --EN:--second death
function m08_02Death_2(proxy,param)
	print("m08_02Death_2 begin");
	proxy:SetMapUid( 8, 2, 0, 0, -1 );		
	--グレイゴースト化 --EN:--Gray ghost
	proxy:ChangeGreyGhost();
	proxy:SetHp( 10000, 1 );
	--召還位置に再出現 --EN:--Respawn at summon position
	proxy:SetSummonedPos();
	proxy:OnKeyTime2(4000,"m08_02Death_Load",0.1,0,10,once);
	--ホワイトゴーストで死んだフラグON --EN:-- White Ghost dead flag ON
	proxy:SetEventFlag(14380,true);
	
	print("m08_02Death_2 end");
end

--３回目の死亡 --EN:--third death
function m08_02Death_3(proxy,param)
	print("m08_02Death_3 begin");
	--プレイヤー復活 --EN:--Player Resurrection
	proxy:RevivePlayer();
	proxy:ReturnMapSelect();	
	print("m08_02Death_3 end");
end

--死亡後のローディング --EN:--loading after death
function m08_02Death_Load(proxy,param)
	print("m08_02Death_Load begin");
	--ローディング --EN:--Loading
	--ワープを行う --EN:--do warp
	proxy:WarpNextStageKick();
	print("m08_02Death_Load end");
end
