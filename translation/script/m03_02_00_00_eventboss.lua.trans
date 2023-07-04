
--------------------------------------------------------------------------------------
--イベント初期化■ボス固有のイベントを登録する際に使用してください --EN:--Event Initialization ■Use this when registering boss-specific events.
--------------------------------------------------------------------------------------
function EventBoss_Initialize_m03_02_00_00(proxy)
	print("EventBoss_Initialize_m03_02_00_00 begin");
	--クライアントで無いなら　シングル　or　ホスト --EN:-- Single or host if not a client
	if	proxy:IsClient() == false then
		--ネットワークの権限を取れるように要求 --EN:--Request to take network privileges
		proxy:RequestForceUpdateNetwork(805);		
	end
	if proxy:IsCompleteEvent( 4895 ) == false then
		--■■嵐の戦士がPCから攻撃を受けた■ --EN:--■■Warrior of the Storm was attacked by a PC■
		proxy:OnSimpleDamage( 4910 , 805 , 10000 , "OnEvent_4910",everytime );
		--■■嵐の戦士のターゲットをホストにします■ --EN:--■■ Host the target of the Storm Warriors■
		proxy:LuaCall( 4911 , 10 , "OnEvent_4911",everytime );
	end
	
	print("EventBoss_Initialize_m03_02_00_00 end");
end

--------------------------------------------------------------------------------------
--ボス用の初期化処理が必要なときに使用：固有情報の作成等 --EN:--Used when initialization processing for the boss is required: creation of unique information, etc.
--------------------------------------------------------------------------------------
function BossInit(proxy,param)	
end


--------------------------------------------------------------------------------------
--■■嵐の戦士がPCから攻撃を受けた■ --EN:--■■Warrior of the Storm was attacked by a PC■
--------------------------------------------------------------------------------------
function OnEvent_4910(proxy,param)
	print("OnEvent_4910 begin");
	local target = proxy:GetTargetChrID(805);
	if target ~= -1 then	
		if proxy:IsRegionIn( target ,2885 ) == false then
			print("ChangeTarget!");
			proxy:LuaCallStart(4911,10 );
		end
	else
		print("ChangeTarget!");
		proxy:LuaCallStart(4911,10 );
	end
	print("OnEvent_4910 end");
end

function OnEvent_4911(proxy,param)
	if proxy:IsClient() == false then
		print("OnEvent_4911 begin");
		
		proxy:ClearTarget( 805 );--一度索敵情報を忘れる --EN:-- Forget the enemy search information once
		proxy:ChangeTarget( 805 , 10000 );--自分を攻撃するように先導する --EN:--Lead to attack yourself
		print("OnEvent_4911 end");
	end
end

