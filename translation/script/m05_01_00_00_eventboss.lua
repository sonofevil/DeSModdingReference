
--------------------------------------------------------------------------------------
--イベント初期化■ボス固有のイベントを登録する際に使用してください --EN:--Event Initialization ■Use this when registering boss-specific events.
--------------------------------------------------------------------------------------
function EventBoss_Initialize_m05_01_00_00(proxy)
	print("EventBoss_Initialize_m05_01_00_00 begin");
	
	
	--クライアントで無いなら　シングル　or　ホスト --EN:-- Single or host if not a client
	if	proxy:IsClient() == false then
		proxy:RequestForceUpdateNetwork( 809 );
	end
	
	for index = 0, 25, 1 do
		local objId = 1310 + index;
		print("RestorePiece to ", objId);
		proxy:RestorePiece( objId );
	end
	
	--蝿OBJがたかるので、その当たり判定の設定（予定） --EN:--The fly OBJ is hard, so set the hit detection (planned)
	BossInit_FlyCrowdDemon(proxy,param);


	
--■5860～5865■腕破壊■--一部分でも破壊されるたび呼ばれる --EN:-- ■ 5860～5865 ■ Arm destroyed ■ -- Called every time even a part of it is destroyed
	local Arm_actId_list = { 5860, 5861, 5862, 5863, 5864, 5865 };
	local Arm_actId_num = table.getn( Arm_actId_list );
	--1つでも残っていたら未成立 --EN:--If there is even one left, it will not be established
	for index = 1, Arm_actId_num, 1 do
		SingleReset( proxy, Arm_actId_list[index] );
		if proxy:IsCompleteEvent(Arm_actId_list[index]) == false then
			local objId = 1311 + index-1;
			proxy:OnObjectDestroy( Arm_actId_list[index], objId, "Arm_ObjBreak", once );
		end
	end
		
--■5875～5879■火に近づくと蠅が散る■	 --EN:--■5875～5879■Flies fly away when approaching fire■
	proxy:NotNetMessage_begin();
		local requestTime = 2.0;
		--proxy:OnRegionJustIn( 5875 , 10000,2230 , "OnEvent_5875",everytime );
		proxy:OnObjectDamageHit_NoCallPlus( 5875, 1361,1,5107,EV_HIT_CHR,1.0,-1,requestTime,everytime);
		
		--proxy:OnRegionJustIn( 5876 , 10000,2231	, "OnEvent_5876",everytime );
		proxy:OnObjectDamageHit_NoCallPlus( 5876, 1362,1,5107,EV_HIT_CHR,1.0,-1,requestTime,everytime);
		
		--proxy:OnRegionJustIn( 5877 , 10000,2232 , "OnEvent_5877",everytime );
		proxy:OnObjectDamageHit_NoCallPlus( 5877, 1363,1,5107,EV_HIT_CHR,1.0,-1,requestTime,everytime);
		
		--proxy:OnRegionJustIn( 5878 , 10000,2233 , "OnEvent_5878",everytime );		
		proxy:OnObjectDamageHit_NoCallPlus( 5878, 1365,1,5107,EV_HIT_CHR,1.0,-1,requestTime,everytime);				
				
		--proxy:OnRegionJustIn( 5879 , 10000,2234 , "OnEvent_5879",everytime );	
		proxy:OnObjectDamageHit_NoCallPlus( 5879, 1364,1,5107,EV_HIT_CHR,1.0,-1,requestTime,everytime);
		
		
	proxy:NotNetMessage_end();
	
	print("EventBoss_Initialize_m05_01_00_00 end");
end

--------------------------------------------------------------------------------------
--ボス用の初期化処理が必要なときに使用：固有情報の作成等 --EN:--Used when initialization processing for the boss is required: creation of unique information, etc.
--------------------------------------------------------------------------------------
function BossInit_FlyCrowdDemon(proxy,param)
	print("BossInit_FlyCrowdDemon begin");
	
	--ダミポリにオブジェをくっつけて、専用の当たり設定に変更 --EN:--Attach an object to Damipoly and change to a dedicated hit setting
	proxy:CreateFlyCrowdDemon( 809, 1310 );
	
	--通常のダメージでは死なない用にNoDeadフラグを立てる --EN:--Set NoDead flag for not dying from normal damage
	--proxy:SetDeadMode(809, true );
	
--■5880■コア破壊■ --EN:-- ■ 5880 ■ core destruction ■
	--[[if proxy:CreateEventBody( 5880, 809, "Core_break2", FlyCrowdDemon_Core_Hp, 1.0, once ) == true then
		proxy:AddEventParts( 5880, 809, "Ragdoll_c5080_core_gard01");
		proxy:AddEventParts( 5880, 809, "Ragdoll_c5080_core_gard02");
		proxy:AddEventParts( 5880, 809, "Ragdoll_c5080_core01");
	end]]
	proxy:OnCharacterDead( 5880 , 809 , "Core_break2",once);
	
	--[[
	if proxy:CreateEventBody( 5880 , 809 , "Core_BreakDummy",10000000,0.0,once) == true then
		proxy:AddEventParts( 5880, 809, "Ragdoll_c5080_Pelvis01");
		proxy:AddEventParts( 5880, 809, "Ragdoll_c5080_L Thigh01");
		proxy:AddEventParts( 5880, 809, "Ragdoll_c5080_R Thigh01");
		proxy:AddEventParts( 5880, 809, "Ragdoll_c5080_Spine02");
		proxy:AddEventParts( 5880, 809, "Ragdoll_c5080_R Calf01");
		proxy:AddEventParts( 5880, 809, "Ragdoll_c5080_L Calf01");
		proxy:AddEventParts( 5880, 809, "Ragdoll_c5080_BL_core_gard01");
		proxy:AddEventParts( 5880, 809, "Ragdoll_c5080_BR_core_gard01");
		proxy:AddEventParts( 5880, 809, "Ragdoll_c5080_FL_core_gard01");
		proxy:AddEventParts( 5880, 809, "Ragdoll_c5080_FR_core_gard01");
		
		proxy:AddEventParts( 5880, 809, "Ragdoll_c5080_L_core_gard01");
		proxy:AddEventParts( 5880, 809, "Ragdoll_c5080_R_core_gard01");
		proxy:AddEventParts( 5880, 809, "Ragdoll_c5080_Spine01");
		proxy:AddEventParts( 5880, 809, "Ragdoll_c5080_R Foot01");
		proxy:AddEventParts( 5880, 809, "Ragdoll_c5080_R_leg_gard01");
		proxy:AddEventParts( 5880, 809, "Ragdoll_c5080_R_leg_gard02");
		proxy:AddEventParts( 5880, 809, "Ragdoll_c5080_L_leg_gard02");
		proxy:AddEventParts( 5880, 809, "Ragdoll_c5080_L_leg_gard03");
		proxy:AddEventParts( 5880, 809, "Ragdoll_c5080_L Foot01");
		proxy:AddEventParts( 5880, 809, "Ragdoll_c5080_L_leg_gard01");
		
		proxy:AddEventParts( 5880, 809, "Ragdoll_c5080_Head01");
		proxy:AddEventParts( 5880, 809, "Ragdoll_c5080_L UpperArm01");
		proxy:AddEventParts( 5880, 809, "Ragdoll_c5080_R UpperArm01");
		proxy:AddEventParts( 5880, 809, "Ragdoll_c5080_Spine1_coregard01");
		proxy:AddEventParts( 5880, 809, "Ragdoll_c5080_Spine1_coregard02");
		proxy:AddEventParts( 5880, 809, "Ragdoll_c5080_Spine1_coregard03");
		proxy:AddEventParts( 5880, 809, "Ragdoll_c5080_R Forearm01");
		proxy:AddEventParts( 5880, 809, "Ragdoll_c5080_R_arm_gard01");
		proxy:AddEventParts( 5880, 809, "Ragdoll_c5080_R_arm_gard02");
		proxy:AddEventParts( 5880, 809, "Ragdoll_c5080_dodai01");
	end
	
	if proxy:CreateEventBody( 5881 , 809 , "Core_BreakDummy",10000000,0.0,once) == true then			
		proxy:AddEventParts( 5881, 809, "Ragdoll_c5080_L Forearm01");
		proxy:AddEventParts( 5881, 809, "Ragdoll_c5080_head_gard01");
		proxy:AddEventParts( 5881, 809, "Ragdoll_c5080_L Hand01");
		proxy:AddEventParts( 5881, 809, "Ragdoll_c5080_L_arm_gard01");
		proxy:AddEventParts( 5881, 809, "Ragdoll_c5080_R Hand01");
		proxy:AddEventParts( 5881, 809, "Ragdoll_c5080_L_arm_gard02");
		proxy:AddEventParts( 5881, 809, "Ragdoll_c5080_L_hand_gard03");
		proxy:AddEventParts( 5881, 809, "Ragdoll_c5080_L_hand_gard04");
		proxy:AddEventParts( 5881, 809, "Ragdoll_c5080_L_hand_gard01");
		proxy:AddEventParts( 5881, 809, "Ragdoll_c5080_L_hand_gard02");
	end	
	]]
--■5871■蠅魔法同期発射用■ --EN:-- ■ 5871 ■ For fly magic synchronous firing ■
	proxy:LuaCall( 5871, 2, "CastSpell", everytime );
	
--■5780～5810■OBJ段階破壊制限■		 --EN:-- ■ 5780 to 5810 ■ OBJ stage destruction limit ■
	local acidlist = 	{5780,5781,5782,5783,5784,5785,5786,5787};
	local objidlist = 	{1312,1314,1315,1318,1319,1320,1331,1333};
	local num = table.getn( acidlist );
	for index=1 , num , 1 do
		SingleReset( proxy , acidlist[index] );
		if proxy:IsCompleteEvent( acidlist[index] ) == false then
			RegistObjDisable(proxy,index);			
			proxy:OnObjectDestroy( acidlist[index] , objidlist[index] , "OnEvent_"..acidlist[index] , once);
		end
	end
	

	print("BossInit_FlyCrowdDemon end");
end



--[[------------------------------------------------------------------------------------
--■リロード時間取得ハンドラ■ --EN:-- ■ Reload time acquisition handler ■
--定数で指定してある最大値・最小値間でランダムの小数を計算し返す。 --EN:--Calculate and return a random decimal between the maximum and minimum values specified by the constant.
--------------------------------------------------------------------------------------]]
--■リロード時間取得ハンドラ --EN:-- ■ Reload time acquisition handler
function GetReloadTime(proxy)
	--ランダムの小数を取得する為、1000でかけたり割ったりしてます。 --EN:--In order to get a random decimal, we multiply and divide by 1000.
	local Low  = FlyCrowdDemon_SpellReload_Low * 1000;
	local High = FlyCrowdDemon_SpellReload_High * 1000;
	local rand = proxy:GetRandom( Low, High ) / 1000;
	print("Reload", rand);
	return rand;
end


--[[------------------------------------------------------------------------------------
--■5870■蠅魔法同期発射をキックする■ --EN:-- ■ 5870 ■ Kick fly magic synchronous launch ■
--------------------------------------------------------------------------------------]]
--■5870■蠅魔法同期発射をキックする■ --EN:-- ■ 5870 ■ Kick fly magic synchronous launch ■
function startSpell(proxy,param)
	print("startSpell begin");
	local set_param = proxy:DivideRest( param:GetParam3() + 1, 2 );
	proxy:NotNetMessage_begin();
		--■5870■蠅魔法同期発射をキックする■ --EN:-- ■ 5870 ■ Kick fly magic synchronous launch ■
		proxy:OnKeyTime2( 5870, "startSpell", GetReloadTime(proxy), 0, set_param, once );
	proxy:NotNetMessage_end();
	
	--蠅魔法同期発射 --EN:--Fly Magic Synchronous Fire
	local cast_target = proxy:GetPlayerId_Random();
	print("targetPlayerNo = ",cast_target);
	proxy:LuaCallStartPlus( 5871, 2, 10001 + cast_target );
	
	print("startSpell end");
end


--[[------------------------------------------------------------------------------------
--■5871■蠅魔法同期発射■ --EN:-- ■ 5871 ■ Synchronized fly magic launch ■
--------------------------------------------------------------------------------------]]
--■5871■蠅魔法同期発射■ --EN:-- ■ 5871 ■ Synchronized fly magic launch ■
function CastSpell(proxy,param)
	print("CastSpell begin");

	print("CastSpell to ", param:GetParam3() );
	--proxy:CastTargetSpell( 809, 809, 201, param:GetParam3(), 5006 );
	proxy:CastTargetSpell( 809, 809, 42, param:GetParam3(), 5006 );
	
	print("CastSpell end");
end


--[[------------------------------------------------------------------------------------
--■5860～5865■腕破壊■ --EN:-- ■ 5860～5865 ■ arm break ■
--------------------------------------------------------------------------------------]]
--■5860～5865■腕破壊■--一部分でも破壊されるたび呼ばれる --EN:-- ■ 5860～5865 ■ Arm destroyed ■ -- Called every time even a part of it is destroyed
function Arm_ObjBreak(proxy,param)
	print("Arm_ObjBreak begin");
	local Arm_actId_list = { 5860, 5861, 5862, 5863, 5864, 5865 };
	local Arm_actId_num = table.getn( Arm_actId_list );
	print("Arm_ObjBreak set ", param:GetParam1() );
	proxy:SetEventFlag( param:GetParam1(), true );
	
	--1つでも残っていたら未成立 --EN:--If there is even one left, it will not be established
	for index = 1,Arm_actId_num, 1 do
		if proxy:IsCompleteEvent( Arm_actId_list[index] ) == false then
			return;
		end
	end
	
	--クライアントで無いなら　シングル　or　ホスト --EN:-- Single or host if not a client
	if	proxy:IsClient() == false then
	--■5870■蠅魔法同期発射をキックする■ --EN:-- ■ 5870 ■ Kick fly magic synchronous launch ■
		proxy:OnKeyTime2( 5870, "startSpell", 2.0, 0, 2, once );
	end
	print("Arm_ObjBreak end");
end




--[[------------------------------------------------------------------------------------
--■5880■コア破壊■ --EN:-- ■ 5880 ■ core destruction ■
--------------------------------------------------------------------------------------]]
--■5880■コア破壊■ --EN:-- ■ 5880 ■ core destruction ■
function Core_break2(proxy,param)
	--[[
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 5880, "Core_break2_1", 0.0, 0, 1, once );
	proxy:NotNetMessage_end();
	]]
	--proxy:CheckEventBody( 5880 );
	
	--蠅魔法イベント削除 --EN:-- Removed fly magic event
	proxy:DeleteEvent(5870);
	proxy:DeleteEvent(5871);
	
	
	proxy:DeleteEvent(5860);
	proxy:DeleteEvent(5861);
	proxy:DeleteEvent(5862);
	proxy:DeleteEvent(5863);
	proxy:DeleteEvent(5864);
	proxy:DeleteEvent(5865);
	
	--無敵解除 --EN:-- Release invincibility
	--proxy:SetDeadMode( 809, false );
	--proxy:EnableInvincible( 809, false );
	--proxy:SetHp( 809, 0.0 );
	--[[
	for ObjID = 1310, 1335, 1 do
		if proxy:IsDestroyed( ObjID ) == false then
			proxy:ChangeModel( ObjID, 1 );
			--初速度を設定（主にばらけさせる為） --EN:--Set the initial speed (mainly for dispersion)
			proxy:SetFirstSpeed( ObjID );
			proxy:SetBrokenPiece( ObjID );
		end
	end
	]]
	proxy:NotNetMessage_begin();
		--5790~
		proxy:OnKeyTime2( 5790 , "OnEvent_5790",0.8,0,0,once);
		proxy:OnKeyTime2( 5791 , "OnEvent_5791",1.8,0,1,once);
		proxy:OnKeyTime2( 5792 , "OnEvent_5792",2.6,0,2,once);
		proxy:OnKeyTime2( 5793 , "OnEvent_5793",3.5,0,3,once);		
	proxy:NotNetMessage_end();
end

--[[
function Core_break2_1(proxy,param)
	--「コア破壊＝死」なので、強制死亡 --EN:-- "Core destruction = death", so forced death
	proxy:ForceDead( 809 );
end
]]

function Core_BreakDummy(proxy,param)
end

------------------------------------------------------------------------------------
--■5875～5879■火に近づくと蠅が散る■ --EN:--■5875～5879■Flies fly away when approaching fire■
--------------------------------------------------------------------------------------
function FireDmage(proxy,eventId,ObjId)
	proxy:NotNetMessage_begin();
		--特殊効果を消す --EN:--Turn off special effects
		proxy:EraseEventSpecialEffect_2( 10000, 5006 );
		--proxy:OnObjectDamageHit_NoCall( eventId, ObjId,1,5107,EV_HIT_CHR,2.0,2.0,once);
	proxy:NotNetMessage_end();
end

--各領域に入った時のダメージ！ --EN:--Damage when entering each area!
function OnEvent_5875(proxy,param) FireDmage(proxy,5875,1361) end
function OnEvent_5876(proxy,param) FireDmage(proxy,5876,1362) end
function OnEvent_5877(proxy,param) FireDmage(proxy,5877,1363) end
function OnEvent_5878(proxy,param) FireDmage(proxy,5878,1365) end
function OnEvent_5879(proxy,param) FireDmage(proxy,5879,1364) end


------------------------------------------------------------------------------------
--■5780～■OBJ段階破壊■ --EN:-- ■ 5780 ~ ■ OBJ stage destruction ■
--------------------------------------------------------------------------------------
function RegistObjDisable(proxy,setid)
	print("RegistObjDisable :",setid);
	if setid == 1 then
		proxy:SetObjDisableBreak( 1311 , true );
	elseif setid == 2 then
		proxy:SetObjDisableBreak( 1313 ,true );
	elseif setid == 3 then
		proxy:SetObjDisableBreak( 1316 , true );
	elseif setid == 4 then
		proxy:SetObjDisableBreak( 1317 , true );
	elseif setid == 5 then
		proxy:SetObjDisableBreak( 1320 , true );
		proxy:SetObjDisableBreak( 1321 , true );
		proxy:SetObjDisableBreak( 1322 , true );
		proxy:SetObjDisableBreak( 1323 , true );
		proxy:SetObjDisableBreak( 1324 , true );
	elseif setid == 6 then
		proxy:SetObjDisableBreak( 1325 , true );
		proxy:SetObjDisableBreak( 1326 , true );
		proxy:SetObjDisableBreak( 1327 , true );
		proxy:SetObjDisableBreak( 1328 , true );
		proxy:SetObjDisableBreak( 1329 , true );
	end
end

--破壊用関数 --EN:--destroy function
function Broken( proxy, objid )
	proxy:SetObjDisableBreak( objid , false );--壊れるようにする --EN:--make it break
	if proxy:IsDestroyed( objid ) == false then
		proxy:ChangeModel( objid , 1);--モデルを差し替える --EN:--replace model
		proxy:SetBrokenPiece( objid );--破壊モデルだと言うことを伝える		 --EN:--Tell them that it's a destructive model
	end	
end

--5780
function OnEvent_5780(proxy,param)
	print("OnEvent_5780 begin");
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 5780 , "OnEvent_5780_time",0.5,0,0,once);
	proxy:NotNetMessage_end();
	print("OnEvent_5780 end");
end
--壊れてから少し待って破壊 --EN:--Destroy after breaking
function OnEvent_5780_time(proxy,param)
	print("OnEvent_5780_time begin");
	Broken( proxy,1311 );
	proxy:SetEventFlag( 5780 , true );
	print("OnEvent_5780_time end");
end

--5781
function OnEvent_5781(proxy,param)
	print("OnEvent_5781 begin");
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 5781 , "OnEvent_5781_time",0.5,0,0,once);
	proxy:NotNetMessage_end();
	print("OnEvent_5781 end");
end
--壊れてから少し待って破壊 --EN:--Destroy after breaking
function OnEvent_5781_time(proxy,param)
	print("OnEvent_5781_time begin");
	Broken( proxy, 1313);
	proxy:SetEventFlag( 5781 , true );
	print("OnEvent_5781_time end");
end

--5782
function OnEvent_5782(proxy,param)
	print("OnEvent_5782 begin");
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 5782 , "OnEvent_5782_time" , 0.5 , 0, 0, once);
	proxy:NotNetMessage_end();
	print("OnEvent_5782 end");
end
--壊れてから少し待って破壊 --EN:--Destroy after breaking
function OnEvent_5782_time(proxy,param)
	print("OnEvent_5782_time begin");
	Broken( proxy, 1316);
	proxy:SetEventFlag( 5782 , true );
	print("OnEvent_5782_time end");
end

--5783
function OnEvent_5783(proxy,param)
	print("OnEvent_5783 begin");
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 5783 , "OnEvent_5783_time" , 0.5 , 0, 0, once);
	proxy:NotNetMessage_end();
	print("OnEvent_5783 end");
end
--壊れてから少し待って破壊 --EN:--Destroy after breaking
function OnEvent_5783_time(proxy,param)
	print("OnEvent_5783_time begin");
	Broken( proxy, 1317);
	proxy:SetEventFlag( 5783 , true );
	print("OnEvent_5783_time end");
end

--5784
function OnEvent_5784(proxy,param)
	print("OnEvent_5784 begin");
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 5784 , "OnEvent_5784_time",0.5,0,0,once);
	proxy:NotNetMessage_end();
	print("OnEvent_5784 end");
end
--壊れてから少し待って破壊 --EN:--Destroy after breaking
function OnEvent_5784_time(proxy,param)
	print("OnEvent_5784_time begin");
	Broken( proxy, 1320 );
	Broken( proxy, 1321 );
	Broken( proxy, 1322 );
	Broken( proxy, 1323 );
	Broken( proxy, 1324 );
	proxy:SetEventFlag( 5784 , true );
	print("OnEvent_5784_time end");
end

--5785
function OnEvent_5785(proxy,param)
	print("OnEvent_5785 begin");
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 5785 , "OnEvent_5785_time",0.5,0,0,once);
	proxy:NotNetMessage_end();
	print("OnEvent_5785 end");
end
--壊れてから少し待って破壊 --EN:--Destroy after breaking
function OnEvent_5785_time(proxy,param)
	print("OnEvent_5785_time begin");
	Broken( proxy, 1325);
	Broken( proxy, 1326);
	Broken( proxy, 1327);
	Broken( proxy, 1328);
	Broken( proxy, 1329);	
	proxy:SetEventFlag( 5785 , true );
	print("OnEvent_5785_time end");
end

--5786
function OnEvent_5786(proxy,param)
	print("OnEvent_5786 begin");
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 5786 , "OnEvent_5786_time",0.5 ,0,0,once);
	proxy:NotNetMessage_end();
	print("OnEvent_5786 end");
end
--壊れてから少し待って破壊 --EN:--Destroy after breaking
function OnEvent_5786_time(proxy,param)
	print("OnEvent_5786_time begin");
	Broken( proxy, 1332);
	proxy:SetEventFlag( 5786,true );
	print("OnEvent_5786_time end");
end

--5787
function OnEvent_5787(proxy,param)
	print("OnEvent_5787 begin");
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 5787,"OnEvent_5787_time",0.5,0,0,once);
	proxy:NotNetMessage_end();
	print("OnEvent_5787 end");
end
--壊れてから少し待って破壊 --EN:--Destroy after breaking
function OnEvent_5787_time(proxy,param)
	print("OnEvent_5787_time begin");
	Broken( proxy, 1334 );
	proxy:SetEventFlag( 5787 , true );
	print("OnEvent_5787_time end");
end


------------------------------------------------------------------------------------
--■5790～■死亡時のOBJ段階破壊■ --EN:-- ■ 5790 ~ ■ OBJ stage destruction at death ■
------------------------------------------------------------------------------------
--1セット目 --EN:--1st set
function OnEvent_5790(proxy,param)
	print("OnEvent_5790 begin");
	Broken( proxy, 1310 );
	Broken( proxy, 1311 );
	Broken( proxy, 1312 );
	Broken( proxy, 1313 );
	Broken( proxy, 1314 );
	Broken( proxy, 1315 );
	Broken( proxy, 1316 );	
	print("OnEvent_5790 end");
end

--2セット目 --EN:--Second set
function OnEvent_5791(proxy,param)
	print("OnEvent_5791 begin");
	Broken( proxy, 1317 );
	Broken( proxy, 1318 );
	Broken( proxy, 1319 );
	Broken( proxy, 1320 );
	Broken( proxy, 1321 );
	Broken( proxy, 1322 );
	Broken( proxy, 1323 );
	print("OnEvent_5791 end");
end

--３セット目 --EN:--3rd set
function OnEvent_5792(proxy,param)
	print("OnEvent_5792 begin");
	Broken( proxy, 1324 );
	Broken( proxy, 1325 );
	Broken( proxy, 1326 );
	Broken( proxy, 1327 );
	Broken( proxy, 1328 );
	Broken( proxy, 1329 );
	print("OnEvent_5792 end");
end

--４セット目 --EN:--4th set
function OnEvent_5793(proxy,param)
	print("OnEvent_5793 begin");
	Broken( proxy, 1330 );
	Broken( proxy, 1331 );
	Broken( proxy, 1332 );
	Broken( proxy, 1333 );
	Broken( proxy, 1334 );
	Broken( proxy, 1335 );
	print("OnEvent_5793 end");
end
