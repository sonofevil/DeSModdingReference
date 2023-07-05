
ANIME_FATE01 = 25;--0～25 --EN:ーー0～25
ANIME_FATE02 = 50;--26～50 --EN:ーー26～50
ANIME_FATE03 = 75;--51～75 --EN:ーー51～75

BEAST_EVENTDAMAGE = 100;
BEAST_EVENTDAMAGE_RATE = 1.0;

BEAST_JR_DEADCOUNT = 0;
BEAST_JR_MAXCOUNT = 6;

EXVEROCITY_TIME = 5.0;
EXVEROCITY_LEN	= 50;

ISONCE1 = true;
ISONCE2 = false;
ISONCE3 = false;
--------------------------------------------------------------------------------------
--イベント初期化■ボス固有のイベントを登録する際に使用してください --EN:--Event Initialization ■Use this when registering boss-specific events.
--------------------------------------------------------------------------------------
function EventBoss_Initialize_m03_03_00_00(proxy)
	print("EventBoss_Initialize_m03_03_00_00 begin");
	
	--☆☆☆☆☆☆☆☆☆☆☆☆嵐の獣非同期設定☆☆☆☆☆☆☆☆☆☆☆☆ --EN:--☆☆☆☆☆☆☆☆☆☆☆☆Storm Beast Asynchronous Settings☆☆☆☆☆☆☆☆☆☆☆☆
	proxy:SetNoNetSync(822,true);
	--☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆ --EN:--☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆
	if proxy:IsCompleteEvent(4992) == false then
		BEAST_JR_DEADCOUNT = 0;
		print("BEAST_JR_DEADCOUNT init to ",BEAST_JR_DEADCOUNT);
		--アニメ配信用? --EN:--For anime distribution?
		SingleReset( proxy, 5030 );
		proxy:NotNetMessage_begin();
			proxy:LuaCall( 5030 ,0, "OnEvent_5030_Regist",everytime);
		proxy:NotNetMessage_end();

	--[[
		proxy:LuaCall(5031,1,"OnEvent_5031",everytime);
		proxy:LuaCall(5032,2,"OnEvent_5032",everytime);
		proxy:LuaCall(5033,3,"OnEvent_5033",everytime);
		proxy:LuaCall(5034,4,"OnEvent_5034",everytime);
	]]
		
		--空中旋回 --EN:--Aerial circling
		proxy:LuaCall(5073,1,"OnEvent_5073",everytime);
		--低空攻撃1 --EN:-- Low altitude attack 1
		proxy:LuaCall(5074,1,"OnEvent_5074",everytime);
		--低空攻撃2 --EN:--Low altitude attack 2
		proxy:LuaCall(5075,1,"OnEvent_5075",everytime);
		
		--フェイズ移行アニメ --EN:--Phase transition animation
		SingleReset( proxy , 5080 );
		proxy:LuaCall(5080,1,"OnEvent_5080",everytime);
		
		--[[
		proxy:NotNetMessage_begin();
			--ポリ劇開始フェード終了後 --EN:--After the polyplay start fade
			proxy:LuaCall( 5078,REMO_START,"OnEvent_5078_RemoStart",once);
			--ポリ劇終了フェード前 --EN:--Before the poly drama ending fade
			proxy:LuaCall( 5078,REMO_FINISH,"OnEvent_5078_RemoFinish",once);
		proxy:NotNetMessage_end();
		]]
		--proxy:OnCharacterHP( 5078 , 822 , "OnEvent_5078",0.0,once);
		
		proxy:OnCharacterDead( 5078 , 822 , "OnEvent_5078",once);
		
		--SFX配信用	 --EN:--For SFX distribution
		--proxy:LuaCall(5014,1,"OnEvent_5014",everytime);
		--proxy:LuaCall(5015,1,"OnEvent_5015",everytime);
		
		SingleReset(proxy,5071);
		--クライアントで無いなら　シングル　or　ホスト --EN:-- Single or host if not a client
		if	proxy:IsClient() == false then
			--ネットワーク更新権限を要求する --EN:--Request network update permission
			proxy:RequestForceUpdateNetwork( 822 );
			--子エイのネットワーク更新権限を要求する --EN:--Request network update permissions for offspring
			local eneID = 400;
			for eneID=400 , 411 , 1 do
				proxy:RequestForceUpdateNetwork(eneID);		
				proxy:AddFieldInsFilter(eneID);
				--子エイの死亡監視 --EN:--Father ray mortality monitoring
				print("add ",eneID);
				proxy:NotNetMessage_begin();
				proxy:RepeatMessage_begin();
					proxy:OnCharacterDead( 5071, eneID ,"OnEvent_5071_"..eneID,once);		
				proxy:RepeatMessage_end();
				proxy:NotNetMessage_end();
			end
			
			--ジェネレーターにイベントを登録 --EN:--Register event on generator
			proxy:AddGeneEvent( 5071 , 2605 );
			--受け取れるようにハンドラを登録 --EN:--Register a handler to receive
			proxy:NotNetMessage_begin();
				proxy:CustomLuaCall( 5071 , "OnEvent_5071", everytime);
			proxy:NotNetMessage_end();
		end
		
		--アニメ監視用? --EN:--For anime monitoring?
		--[[
			基本 --EN:Basic
			アニメ選択はホストのみが行う --EN:Anime selection is for the host only
			アニメ再生を監視するのもホストのみが行う --EN:Only the host monitors animation playback
			ピアは再生するアニメを配信されているだけである。 --EN:Peers are only being delivered anime to play.
		]]
		
		--2段目の初期化 --EN:--initialization of the second stage
		proxy:NotNetMessage_begin();
			proxy:OnKeyTime2(5034,"BossInit_m03_03_00_00_Second_Initialize",0,0,0,once);
		proxy:NotNetMessage_end();
	end
	
	--子エイを初期死亡しないようにフィルターに登録する --EN:--Register the baby ray in the filter so that it does not die early
	local eneID = 400;
	for eneID=400 , 411 , 1 do
		proxy:AddFieldInsFilter(eneID);
	end
	
	
	print("EventBoss_Initialize_m03_03_00_00 end");
end


--2段目の初期化 --EN:--initialization of the second stage
function BossInit_m03_03_00_00_Second_Initialize(proxy,param)
	print("BossInit_m03_03_00_00_Second_Initialize beign");
	
	--重力の限界を無視 --EN:--ignoring gravity limits
	proxy:SetDisableGravity(822,true);
	--proxy:DisableDamage( 822, true);--ダメージ入らない --EN:--No damage
	proxy:SetSuperArmor( 822, true);--スーパーアーマー --EN:--Super Armor

	print("BossInit_m03_03_00_00_Second_Initialize end");
end


--------------------------------------------------------------------------------------
--ボス用の初期化処理が必要なときに使用：固有情報の作成等 --EN:--Used when initialization processing for the boss is required: creation of unique information, etc.
--------------------------------------------------------------------------------------
function BossInit_StormOfBeast(proxy,param)
	print("BossInit_StormOfBeast begin");
	--描画グループ適用 --EN:--Apply drawing group
	proxy:SetDrawGroup(822,2631);
	--重力の限界を無視しない --EN:--Don't ignore the limits of gravity
	proxy:SetDisableGravity(822,true);
	
	--強制更新を開始 --EN:-- start forced update
	LuaFunc_ForceOmission(proxy,822);
	--クライアントで無いなら　シングル　or　ホスト --EN:-- Single or host if not a client
	if	proxy:IsClient() == false then
		--アニメ抽選をかねてハンドラコール --EN:--Handler call for anime lottery
		OnEvent_5030(proxy,param);
	end
	
	--子エイロジックON --EN:-- Child Alogic ON
	local eneID = 400;
	for eneID=400 , 411 , 1 do
		proxy:EnableLogic(eneID,true);
	end
	
	--子エイ用の戦闘領域監視 --EN:--Battle area surveillance for pups
	--proxy:OnRegistFunc(5020,"Check_5020","OnEvent_5020",1,once);
	
	
	
	print("BossInit_StormOfBeast end");
end


--------------------------------------------------------------------------------------
--ボス用の初期化処理が必要なときに使用：固有情報の作成等 --EN:--Used when initialization processing for the boss is required: creation of unique information, etc.
--------------------------------------------------------------------------------------
function BossInit_StormOfBeast2(proxy,param)
	print("BossInit_StormOfBeast2 begin");
	--通常ロジックON --EN:--Normal logic ON
	proxy:EnableLogic(822,true);
	
	--重力の限界を無視しない --EN:--Don't ignore the limits of gravity
	--proxy:SetDisableGravity(822,false);
	--proxy:DisableMapHit(822,true);
	
	proxy:DisableDamage( 822, false);--ダメージ入る --EN:--damage
	
	--位置合わせワープ --EN:--alignment warp
	proxy:SetExVelocity(822,2603,EXVEROCITY_TIME,EXVEROCITY_LEN);--(822,2603);	
	
	proxy:ForcePlayAnimation(822,0);
	--エイの戦闘領域監視 --EN:--Sei Combat Area Surveillance
	proxy:OnRegistFunc( 5010,"Check_5010","OnEvent_5010",1,once);	
	print("BossInit_StormOfBeast2 end");
end

--[[
--------------------------------------------------------------------------------------
--子エイの戦闘領域監視 --EN:--Surveillance of child stingray combat area
--------------------------------------------------------------------------------------
function Check_5020(proxy,param)
	local eneID = 400;
	local eneMax = 411;
	local eneNum = 12;
	local deadCount = 0;
	
	for eneID = 400, eneMax , 1 do
		if proxy:IsAlive(eneID) == true then
			local targetID = proxy:GetTargetChrID(eneID);
			if targetID >= 0 then
				if proxy:IsRegionIn( targetID , 2620) == true then			
					--ターゲットが戦闘領域に入っている --EN:--Target is in combat area
					proxy:SetInsideBattleArea(eneID,1);
				else
					--ターゲットが戦闘領域には居ない --EN:--Target is not in combat area
					proxy:SetInsideBattleArea(eneID,0);
				end
			else
				--ターゲットが戦闘領域には居ない --EN:--Target is not in combat area
				proxy:SetInsideBattleArea(eneID,0);
			end
		else
			deadCount = deadCount + 1;
		end
	end
	
	if deadCount >= eneNum then
		return true;		
	end
	return false;	
end

--子エイ全部死亡 --EN:--All baby rays died
function OnEvent_5020(proxy,param)
	print("OnEvent_5020 begin");
	print("All Dead");
	proxy:DeleteEvent(5020);
	print("OnEvent_5020 end");
end
]]
--------------------------------------------------------------------------------------
--嵐の獣　アニメ監視と抽選 --EN:--Arashi no Beast anime monitoring and lottery
--------------------------------------------------------------------------------------
function OnEvent_5030(proxy,param)
	--突撃ポリ劇が終わってたら抽選しません --EN:--The lottery will not be held if the assault poly drama is over
	if proxy:IsCompleteEvent(5001) == true then
		return;
	end
	
	if proxy:IsCompleteEvent(5030) == true then
		return;
	end
	
	--死んでいたらアニメ抽選しない --EN:--No anime lottery if dead
	if proxy:IsAlive( 822 ) == false then
		return; 
	end
	print("OnEvent_5030 begin");
	
	local fate = proxy:GetRandom( 0,100);
	
	if proxy:IsCompleteEvent( 5071 ) == false then
		print("Call A");
		proxy:LuaCallStart(5073,1)
	else
		--フェイズ2へ移行しているが移行アニメがまだ --EN:--Transition to Phase 2, but transition animation is not yet
		if proxy:IsCompleteEvent( 5080 ) == false then
			print("Call shift");
			proxy:LuaCallStart(5080,1);
			proxy:SetEventFlag( 5080,true );
		else		
			if fate <= 100 then
				print("Call B fate ",fate );
				proxy:LuaCallStart(5074,1);
			else		
				print("Call C fate ",fate );
				proxy:LuaCallStart(5075,1);
			end
		end
	end

	--クライアントで無いなら　シングル　or　ホスト --EN:-- Single or host if not a client
	if	proxy:IsClient() == false then
		proxy:RepeatMessage_begin();
			proxy:NotNetMessage_begin();
			proxy:OnKeyTime2(5030,"OnEvent_5030_1",1,0,0,once);
			proxy:RepeatMessage_end();
		proxy:NotNetMessage_end();
	end
	
	proxy:SetEventFlag(5030,true);
	print("OnEvent_5030 end");
end

--それぞれの監視再登録 --EN:-- each monitor re-registration
function OnEvent_5030_1(proxy,param)
	print("OnEvent_5030_1 begin");
	proxy:SetEventFlag(5030,false);
	--クライアントで無いなら　シングル　or　ホスト --EN:-- Single or host if not a client
	if	proxy:IsClient() == false then
		proxy:NotNetMessage_begin();
			proxy:RepeatMessage_begin();
				proxy:OnChrAnimEnd( 5030 , 822 , 7010 , "OnEvent_5030" ,once);
			proxy:RepeatMessage_end();
		proxy:NotNetMessage_end();
	end
	print("OnEvent_5030_1 end");
end

--------------------------------------------------------------------------------------
--嵐の獣　アニメ再生 --EN:--The beast of the storm Animation playback
--------------------------------------------------------------------------------------
--[[
--尻尾叩き --EN:-- tail slapping
function OnEvent_5031(proxy,param)
	print("OnEvent_5031 begin");
	--開始ポイントにワープ --EN:--warp to starting point
	proxy:SetExVelocity(822,2630,EXVEROCITY_TIME,EXVEROCITY_LEN);--(822,2630);
	proxy:PlayAnimation(822,7010);
	print("OnEvent_5031 end");
end
]]

--[[
--風圧攻撃 --EN:--Wind attack
function OnEvent_5032(proxy,param)
	print("OnEvent_5032 begin");
	--開始ポイントにワープ --EN:--warp to starting point
	proxy:SetExVelocity(822,2630,EXVEROCITY_TIME,EXVEROCITY_LEN);--(822,2630);
	proxy:PlayAnimation(822,7020);

	print("OnEvent_5032 end");
end
]]

--[[
--うろこ飛ばし攻撃 --EN:--Scaly attack
function OnEvent_5033(proxy,param)
	print("OnEvent_5033 begin");
	--開始ポイントにワープ --EN:--warp to starting point
	proxy:SetExVelocity(822,2630,EXVEROCITY_TIME,EXVEROCITY_LEN);--(822,2630);
	proxy:PlayAnimation(822,7030);

	print("OnEvent_5033 end");
end
]]

--[[
--巡回 --EN:--Patrol
function OnEvent_5034(proxy,param)
	print("OnEvent_5034 begin");
	--開始ポイントにワープ --EN:--warp to starting point
	proxy:SetExVelocity(822,2630,EXVEROCITY_TIME,EXVEROCITY_LEN);--(822,2630);
	proxy:ForcePlayAnimation(822,7050);

	print("OnEvent_5034 end");
end
]]


--巡回 --EN:--Patrol
function OnEvent_5073(proxy,param)
	print("OnEvent_5073 begin");
	if ISONCE1 == false then
		--開始ポイントにワープ --EN:--warp to starting point
		proxy:Warp( 822 , 2630 );
		ISONCE1 = true;
	else
		--開始ポイントにワープ --EN:--warp to starting point
		proxy:SetExVelocity(822,2630,EXVEROCITY_TIME,EXVEROCITY_LEN);--( 822 , 2630 );
	end
	proxy:ForcePlayAnimationStayCancel( 822 , 7050 );
	print("OnEvent_5073 end");
end

--低空攻撃１ --EN:-- Low altitude attack 1
function OnEvent_5074(proxy,param)
	print("OnEvent_5074 begin");
	if ISONCE2 == false then
		--開始ポイントにワープ --EN:--warp to starting point
		proxy:Warp( 822 , 2635 );
		ISONCE2 = true;
	else
		--開始ポイントにワープ --EN:--warp to starting point
		proxy:SetExVelocity(822,2635,EXVEROCITY_TIME,EXVEROCITY_LEN);--( 822 , 2635 );		
	end
	proxy:ForcePlayAnimationStayCancel( 822 , 7060 );
	print("OnEvent_5074 end");
end

--低空攻撃２ --EN:--Low altitude attack 2
function OnEvent_5075(proxy,param)
	print("OnEvent_5075 begin");
	if ISONCE3 == false then
		--開始ポイントにワープ --EN:--warp to starting point
		proxy:Warp( 822 , 2635 );		
	else
		--開始ポイントにワープ --EN:--warp to starting point
		proxy:SetExVelocity(822,2635,EXVEROCITY_TIME,EXVEROCITY_LEN);--( 822 , 2635 );		
	end
	proxy:ForcePlayAnimationStayCancel( 822 , 7070 );
	print("OnEvent_5075 end");
end

--フェイズ移行アニメ --EN:--Phase transition animation
function OnEvent_5080(proxy,param)
	print("OnEvent_5080 begin");
	--開始ポイントにワープ --EN:--warp to starting point
	--proxy:Warp(822,2630);
	proxy:SetExVelocity(822,2630,EXVEROCITY_TIME,EXVEROCITY_LEN);--( 822 , 2635 );		
	proxy:ForcePlayAnimationStayCancel( 822 , 7100 );
	print("OnEvent_5080 end");
end

--[[
--------------------------------------------------------------------------------------
--嵐の獣　SFX配信イベント --EN:--Storm Beast SFX distribution event
--------------------------------------------------------------------------------------
--風圧攻撃SFX --EN:--Wind attack SFX
function OnEvent_5014_RegionIn(proxy,param)
	print("OnEvent_5014_RegionIn begin");
	proxy:LuaCallStart(5014,1);
	print("OnEvent_5014_RegionIn end");
end

--風圧攻撃SFX --EN:--Wind attack SFX
function OnEvent_5014(proxy,param)
	print("OnEvent_5014 begin");
	proxy:CreateSfx( 2615 , 15031);
	print("OnEvent_5014 end");
end

--通常接近SFX --EN:--Normal Approach SFX
function OnEvent_5015_RegionIn(proxy,param)
	print("OnEvent_5015_RegionIn begin");
	proxy:LuaCallStart(5015,1);
	print("OnEvent_5015_RegionIn end");
end

--通常接近SFX --EN:--Normal Approach SFX
function OnEvent_5015(proxy,param)
	print("OnEvent_5015 begin");		
	proxy:CreateSfx( 2617 , 15030);
	print("OnEvent_5015 end");	
end
]]


--------------------------------------------------------------------------------------
--嵐の獣　戦闘領域監視 --EN:--Storm Beast Battle Area Surveillance
--------------------------------------------------------------------------------------
function Check_5010(proxy,param)
	
	--嵐の獣が生きているか？ --EN:--Are the storm beasts alive?
	if proxy:IsAlive(822) == true then
		--ターゲット取得 --EN:--target acquisition
		local TargetID = proxy:GetTargetChrID(822);
		
		--ターゲットがいるか？ --EN:--Is there a target?
		if TargetID >= 0 then
			--ターゲットが右にいるか？ --EN:--Is the target on the right?
			if proxy:IsRegionIn(TargetID,2610) == true then
				proxy:SendEventRequest(822,0,AI_EVENT_FOR_RIGHT);
			
			--ターゲットが正面にいるか？ --EN:--Is the target in front?
			elseif proxy:IsRegionIn(TargetID,2611) == true then
				proxy:SendEventRequest(822,0,AI_EVENT_FOR_CENTER);
			
			--ターゲットが左にいるか？ --EN:--Is the target on the left?
			elseif proxy:IsRegionIn(TargetID,2612) == true then
				proxy:SendEventRequest(822,0,AI_EVENT_FOR_LEFT);
			
			--ターゲットが近くにきているか？ --EN:--Is the target approaching?
			elseif proxy:IsRegionIn(TargetID,2613) == true then
				proxy:SendEventRequest(822,0,AI_EVENT_NEAR);
			
			--該当エリアのどこにも居ない --EN:--Nowhere in the area
			else
				proxy:SendEventRequest(822,0,AI_EVENT_None);
			
			end
		end
		
	else
		--死んでいる --EN:--dead
		return true;
	end
	
	return false;
end

--一応死んだ時にハンドラを呼んで削除しておく --EN:-- Call the handler and delete it when it dies
function OnEvent_5010(proxy,param)
	print("OnEvent_5010 begin");	
	print("OnEvent_5010 end");
end


--------------------------------------------------------------------------------------
--嵐の獣　ノーダメージ部位 --EN:--Storm Beast No damage part
--------------------------------------------------------------------------------------
--ダメージ部位にダメージ蓄積 --EN:-- Accumulation of damage in the damaged part
function OnEvent_5045(proxy,param)
	print("OnEvent_5045 begin");
	if proxy:IsAlive(822 ) == true then
		proxy:PlayAnimation( 822,2000);
		proxy:CheckEventBody(5045);
	end
	print("OnEvent_5045 end");
end

--ノーダメージ部位からイベントが起きた --EN:--An event occurred from a non-damaged part
function OnEvent_5046(proxy,param)
	print("OnEvent_5046 begin");
	proxy:CheckEventBody(5046);
	print("OnEvent_5046 end");
end


function OnEvent_5071(proxy,param)
	print("OnEvent_5071 begin");
	print("Generate enemy ",param:GetParam2() );
	proxy:NotNetMessage_begin();
	proxy:RepeatMessage_begin();
		proxy:OnCharacterDead( 5071, param:GetParam2(),"OnEvent_5071_"..param:GetParam2(),once);
	proxy:RepeatMessage_end();
	proxy:NotNetMessage_end();
end

--------------------------------------------------------------------------------------
--■5071■子エイ死亡監視■ --EN:-- ■ 5071 ■ child ray death monitoring ■
--------------------------------------------------------------------------------------
--死亡監視の統合 --EN:-- Mortality monitoring integration
function CheckDeadCount(proxy,eneID)
	print("OnEvent_5000_",eneID," begin");	
	
	BEAST_JR_DEADCOUNT = BEAST_JR_DEADCOUNT + 1;
	print(" BEAST_JR_DEADCOUNT = ",BEAST_JR_DEADCOUNT );
	
	if BEAST_JR_DEADCOUNT >= BEAST_JR_MAXCOUNT then
		proxy:SetEventFlag( 5071 , true );
	end	
	print("OnEvent_5000_",eneID," end");	
end

--子エイの死亡監視 --EN:--Father ray mortality monitoring
function OnEvent_5071_400(proxy,param) CheckDeadCount(proxy,400); end--ID400
function OnEvent_5071_401(proxy,param) CheckDeadCount(proxy,401); end--ID401
function OnEvent_5071_402(proxy,param) CheckDeadCount(proxy,402); end--ID402
function OnEvent_5071_403(proxy,param) CheckDeadCount(proxy,403); end--ID403
function OnEvent_5071_404(proxy,param) CheckDeadCount(proxy,404); end--ID404
function OnEvent_5071_405(proxy,param) CheckDeadCount(proxy,405); end--ID405
function OnEvent_5071_406(proxy,param) CheckDeadCount(proxy,406); end--ID406
function OnEvent_5071_407(proxy,param) CheckDeadCount(proxy,407); end--ID407
function OnEvent_5071_408(proxy,param) CheckDeadCount(proxy,408); end--ID408
function OnEvent_5071_409(proxy,param) CheckDeadCount(proxy,409); end--ID409
function OnEvent_5071_410(proxy,param) CheckDeadCount(proxy,410); end--ID410
function OnEvent_5071_411(proxy,param) CheckDeadCount(proxy,411); end--ID411


--[[
--------------------------------------------------------------------------------------
--■5078■本体のHP監視■ --EN:-- ■ 5078 ■ HP monitoring ■
--------------------------------------------------------------------------------------
function OnEvent_5078(proxy,param)
	print("OnEvent_5078 begin");
	proxy:RequestRemo( 30301 , REMO_FLAG,5078,1);
	print("OnEvent_5078 end");
end

--ポリ劇開始前 --EN:--Before starting the police drama
function OnEvent_5078_RemoStart(proxy,param)
	print("OnEvent_5078_RemoStart begin");
	local eneId = 400;
	
	for eneId = 400 , 411 , 1 do
		--子エイを無理やり殺す（無報酬） --EN:--Forcibly kill a baby ray (no reward)
		Lua_EventForceDead(proxy,eneId);
	end
	
	--ジェネレータ止める --EN:-- stop the generator
	proxy:EnableGeneratorSystem( 2605 , false );
	
	--遠くに飛ばす --EN:--fly far
	proxy:Warp( 822 , 2640 );

	print("OnEvent_5078_RemoStart end");	
end

--ポリ劇終了後 --EN:--After the police play
function OnEvent_5078_RemoFinish(prox,param)
	print("OnEvent_5078_RemoFinish begin");
	print("OnEvent_5078_RemoFinish end");
end
]]

--------------------------------------------------------------------------------------
--■5078■本体の死亡監視■ --EN:-- ■ 5078 ■ Death Watch ■
--------------------------------------------------------------------------------------
function OnEvent_5078(proxy,param)
	print("OnEvent_5078 begin");
	local eneId = 400;
	
	for eneId = 400 , 411 , 1 do
		--子エイを無理やり殺す（無報酬） --EN:--Forcibly kill a baby ray (no reward)
		Lua_EventForceDead(proxy,eneId);
	end
	
	--ジェネレータ止める --EN:-- stop the generator
	proxy:EnableGeneratorSystem( 2605 , false );
	
	print("OnEvent_5078 end");
end
