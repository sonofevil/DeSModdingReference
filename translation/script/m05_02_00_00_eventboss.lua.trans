
--ガル・ゴールドランの状態フラグ --EN:--Gal Goldrun status flag
GAL_STATE_LIVE		= 16430;
GAL_STATE_DEAD		= 16431;
gal_flag_list = {
	GAL_STATE_LIVE,
	GAL_STATE_DEAD
};


--------------------------------------------------------------------------------------
--イベント初期化■ボス固有のイベントを登録する際に使用してください --EN:--Event Initialization ■Use this when registering boss-specific events.
--------------------------------------------------------------------------------------
function EventBoss_Initialize_m05_02_00_00(proxy)
	print("EventBoss_Initialize_m05_02_00_00 begin");
	--ボス用アクションID範囲(5986～6015) --EN:--Action ID range for boss (5986-6015)
	proxy:NotNetMessage_begin();
	SingleReset( proxy , 5987 );
	proxy:OnRegistFunc( 5986, "Condition_5986", "dummy", 2, once);
	proxy:NotNetMessage_end();
	
	if	proxy:IsCompleteEvent( 5987 ) == false then
		proxy:OnRegionJustIn( 5987, LOCAL_PLAYER, 2500, "OnEvent_5987", once );
		--右上の崖の監視 --EN:--Watch the top right cliff
		proxy:OnRegionJustIn( 5987, 10000, 2502, "OnEvent_5987", once);--右の崖の上の領域 --EN:--right cliff top area
		proxy:OnRegionJustIn( 5987, 651, 2500, "OnEvent_5987", once );
	end

	--クライアントで無いなら　シングル　or　ホスト --EN:-- Single or host if not a client
	if	proxy:IsClient() == false then
		proxy:RequestForceUpdateNetwork(460);		
		proxy:RequestForceUpdateNetwork(651);		
		proxy:RequestForceUpdateNetwork(824);		
	end
----------------------------------------------------------------------
--リーブラ関連 --EN:-- Libra related
----------------------------------------------------------------------
--■1034■リーブラの最初の警告会話■ --EN:-- ■ 1034 ■ Libra's first warning conversation ■
	if proxy:IsCompleteEvent(1034) == false then
		--会話登録 --EN:--Conversation registration
		proxy:RegistSimpleTalk(1034, 2510, 29000, TALK_ATTR_ALL);
		--領域監視追加 --EN:--Add area monitor
		proxy:OnRegionJustIn(1034, 10000, 2510, "OnEvent_1034", once);
	end
--■1036■リーブラ自害■ --EN:-- ■ 1036 ■ Libra suicide ■
	proxy:LuaCall( 1036, 0, "OnEvent_1036", everytime );
	proxy:SetCompletelyNoMove(824,true);
	
--■1167■リーブラ死亡会話フラグ同期■ --EN:-- ■ 1167 ■ Libra Death Conversation Flag Synchronization ■
	proxy:LuaCall( 1167 , 0 ,"OnEvent_1167", everytime );
	
----------------------------------------------------------------------
--ガル・ゴールドラン関連 --EN:--Gal Gold Run related
----------------------------------------------------------------------
	--ガルのデフォルト状態セット --EN:--gull default state set
	SetFirstNpcStateFlag( proxy, param, gal_flag_list, GAL_STATE_LIVE );
	if	proxy:IsCompleteEvent(1112) == true or	--ガル死んでる --EN:--gal is dead
		proxy:IsCompleteEvent(5889) == true or 	--要石調べている --EN:--I'm looking into the keystone
		proxy:IsCompleteEvent(5889) == true then--リーブラ死んでる --EN:-- Libra is dead
		SetNpcStateFlag( proxy, param, gal_flag_list, GAL_STATE_DEAD );
	end
	
--■1115■イカ戦士用の会話フラグセット■ --EN:--■1115■ Conversation Flag Set for Squid Warrior■
	SingleReset( proxy, 1115 );
	if proxy:IsCompleteEvent(1115) == false then
		--領域監視追加 --EN:--Add area monitor
		proxy:OnRegionJustIn(1115, 10000, 2512, "OnEvent_1115_0", once);--崖の上の領域監視		 --EN:-- Cliff top area surveillance
	end

	if proxy:IsCompleteEvent(5893) == false then--不浄をクリアしていない --EN:--Uncleaned
		--[[ノーマル・ゴールドラン処理]] --EN:--[[Normal/Goldrun processing]]
		if proxy:IsCompleteEvent(GAL_STATE_DEAD) == false then--死亡していない --EN:--not dead
			--■1112■ゴールドラン死亡監視■ --EN:-- ■ 1112 ■ Gold Run Death Watch ■
			print("ゴールドラン出現"); --EN:print("Gold Run appears");
			proxy:OnCharacterDead(1112, 651, "OnEvent_1112", once);--死亡監視追加 --EN:--Add death watch
			
		else--死亡している --EN:--dead
			if proxy:IsCompleteEvent( 15615 ) == false then
				--死体を再現する --EN:--reproduce the corpse
				proxy:OpeningDeadPlus( 651 , true ,false ,false );
			else
				--■1113■ゴールドラン無効化（死亡）■ --EN:-- ■ 1113 ■ Gold run disabled (death) ■
				print("ゴールドランは死亡しています"); --EN:print("Gold Run is dead");
				InvalidBackRead( proxy, 651 );
			end
		end
		--「ブラック・ゴールドラン処理」 --EN:-- "Black Gold Run Processing"
		print("ブラック出現条件を満たしていません"); --EN:print("The black appearance condition is not satisfied");
		InvalidBackRead( proxy, 460 );
		--ココでは黒の死体再現は要らない --EN:--There is no need to reproduce black corpses here
		
	else--不浄をクリアしている --EN:--I have cleared the impurity
	--「ノーマル・ゴールドラン処理」 --EN:-- "Normal Gold Run Processing"
		--■1114■ゴールドラン無効化（不浄クリア）■ --EN:-- ■ 1114 ■ Gold run disabled (unclean clear) ■
		print("ガル・ゴールドラン出現条件を満たしていない"); --EN:print("Gal Goldrun does not meet the appearance conditions");
		if proxy:IsCompleteEvent( 15615 ) == false then
			--死体を再現する --EN:--reproduce the corpse
			proxy:OpeningDeadPlus( 651 , true ,false ,false );
		else			
			InvalidBackRead( proxy, 651 );
		end
	--[[ブラック・ゴールドラン処理]] --EN:--[[Black Gold Run Processing]]
		--SingleReset( proxy, 1110 );--シングル時にフラグリセット		 --EN:-- Flag reset when single
		if proxy:IsCompleteEvent(1110) == true or	--死亡している かつ --EN:--deceased and
		   proxy:IsSuccessQWC(50140) == false then	--ＱＷＣを満たしていないならば --EN:--If the QWC is not met
		   if 	proxy:IsCompleteEvent(1110) == true and 
				proxy:IsCompleteEvent( 15601 ) == false then
				--死体を再現する --EN:--reproduce the corpse
				proxy:OpeningDeadPlus( 460 , true ,false ,false );
			else
				--■1111■ゴールドラン・ブラック無効■ --EN:-- ■ 1111 ■ Gold Run Black invalid ■
				print("ブラック・ゴールドラン出現条件を満たしていません"); --EN:print("Not meeting Black Gold Run appearance condition");
				InvalidBackRead( proxy, 460 );
			end
		else			
		--■1110■ゴールドラン・ブラック死亡監視追加■ --EN:-- ■ 1110 ■ Gold Run Black death watch added ■
			print("ブラック・ゴールドラン出現"); --EN:print("Black Gold Run appears");
			proxy:OnCharacterDead(1110, 460, "OnEvent_1110", once);--死亡監視追加 --EN:--Add death watch
		end
	end
	
	--■15601■ゴールドラン黒の死体を調べてない■ --EN:--■15601■Goldrun Black's corpse hasn't been examined■
	if proxy:IsCompleteEvent( 15601 ) == false then
		proxy:AddCorpseEvent( 15601 , 460 );
		proxy:NotNetMessage_begin();
			proxy:LuaCall( 15601 ,0 , "OnEvent_15601",once );
		proxy:NotNetMessage_end();
	end
	
	--■15615■ゴールドランの死体を調べてない■ --EN:--■15615■ Goldrun's corpse not examined■
	if proxy:IsCompleteEvent( 15615 ) == false then
		proxy:AddCorpseEvent( 15615 , 651 );
		proxy:NotNetMessage_begin();
			proxy:LuaCall( 15615 , 0 , "OnEvent_15615",once );
		proxy:NotNetMessage_end();
	end
	
	--■1117■ガル再度敵対配信用■ --EN:--■1117■Gal again for hostile distribution■
	proxy:LuaCall( 1117 , 0 ,"OnEvent_1117_1",once);
	
	--■1170～1179■リーブラが攻撃を受けた■ --EN:-- ■ 1170-1179 ■ Libra under attack ■
	local eventId = {1170,1171,1172,1173,1174,1175,1176,1177,1178,1179};
	local num = table.getn(eventId);
	for index = 1, num ,1 do
		SingleReset( proxy , eventId[ index ] );		
	end
	if proxy:IsCompleteEvent( 1170 ) == false then
		proxy:OnSimpleDamage( 1170 , 824 , 10000 , "OnEvent_1170", once );
	else
		proxy:ChangeThink( 360 , 210004 );
		proxy:ChangeThink( 361 , 210004 );
		proxy:ChangeThink( 362 , 210004 );
		proxy:ChangeThink( 363 , 210004 );
		proxy:ChangeThink( 372 , 210004 );
		proxy:ChangeThink( 373 , 210004 );
		proxy:ChangeThink( 374 , 210004 );
		proxy:ChangeThink( 375 , 210004 );
		proxy:ChangeThink( 377 , 210004 );
		proxy:ChangeThink( 391 , 210004 );		
	end
	
	
	print("EventBoss_Initialize_m05_02_00_00 end");
end

--------------------------------------------------------------------------------------
--ボス用の初期化処理が必要なときに使用：固有情報の作成等 --EN:--Used when initialization processing for the boss is required: creation of unique information, etc.
--------------------------------------------------------------------------------------
function BossInit(proxy,param)	
end


function Condition_5986(proxy,param)
	local chrId = 651;
	if	proxy:IsCompleteEvent( 5987 ) == true then
		proxy:SendEventRequest(chrId,0,1);
	else
		proxy:SendEventRequest(chrId,0,AI_EVENT_None);
	end
	return false;
end


----------------------------------------------------
--■1110■ゴールドラン・ブラック死亡監視追加■ --EN:-- ■ 1110 ■ Gold Run Black death watch added ■
----------------------------------------------------
function OnEvent_1110(proxy, param)
	print("OnEvent_1110 begin");
	proxy:SetEventFlag(1110, true);
	print("OnEvent_1110 end");
	
end

----------------------------------------------------
--■15601■ゴールドラン・ブラック死体を調べた■ --EN:--■ 15601 ■ Examine Goldrun Black's corpse ■
----------------------------------------------------
function OnEvent_15601(proxy,param)
	print("OnEvent_15601 begin");
	proxy:SetEventFlag( 15601 ,true );
	print("OnEvent_15601 end");
end

-----------------------------------------------------------
--■1112■ゴールドラン死亡■ --EN:-- ■ 1112 ■ gold run death ■
-----------------------------------------------------------
function OnEvent_1112(proxy, param)
	print("OnEvent_1112 begin");
	proxy:SetEventFlag( 1112, true );
	SetNpcStateFlag( proxy, param, gal_flag_list, GAL_STATE_DEAD );
	print("OnEvent_1112 end");
end

-----------------------------------------------------------
--■15615■ゴールドラン死体を調べた■ --EN:--■ 15615 ■ Examined Gold Run corpse ■
-----------------------------------------------------------
function OnEvent_15615(proxy,param)
	print("OnEvent_15615 begin");
	proxy:SetEventFlag( 15615 , true );
	print("OnEvent_15615 end");
end

----------------------------------------------------------------------
--■1115■崖から落ちたフラグセット --EN:-- ■ 1115 ■ Flag set that fell from the cliff
----------------------------------------------------------------------
function OnEvent_1115_0(proxy, param)
	print("崖の上に居る…"); --EN:print("I'm on a cliff...");
	--領域監視追加 --EN:--Add area monitor
	proxy:OnRegionJustIn(1115, 10000, 2514, "OnEvent_1115_In", once);--崖の上の領域に入った --EN:--entered the area on the cliff
	proxy:OnRegionJustOut( 1115, 10000 , 2514 , "OnEvent_1115_Out",once);--領域から出た --EN:-- out of the realm
end
function OnEvent_1115_In(proxy, param)
	print("崖から転落！！"); --EN:print("Fall off a cliff!!");
	proxy:SetEventFlag(1115, true);--崖から落ちたフラグをON --EN:--ON the flag that fell from the cliff
	--proxy:DeleteEvent( 1115 );--削除 --EN:--delete
end
function OnEvent_1115_Out(proxy, param)
	print("OnEvent_1115_Out");
	proxy:SetEventFlag(1115, false);--崖から落ちたフラグをOFF --EN:--OFF the flag that fell from the cliff
	--proxy:DeleteEvent( 1115 );--削除 --EN:--delete
end

--------------------------------------------------------------------------------------
--■1034■リーブラ最初の警告会話■ --EN:-- ■ 1034 ■ Libra's first warning conversation ■
--------------------------------------------------------------------------------------
function OnEvent_1034(proxy, param)
	print("OnEvent_1034 begin");
	--登録した会話を再生 --EN:-- Play registered conversations
	proxy:CloseMenu();
	proxy:TalkNextPage(1034);
	--フラグセット --EN:--flag set
	proxy:SetEventFlag(1034,true);
	
	print("OnEvent_1034 end");
end


--------------------------------------------------------------------------------------
--■1036■リーブラ自害■ --EN:-- ■ 1036 ■ Libra suicide ■
--------------------------------------------------------------------------------------
function OnEvent_1036(proxy,param)
	print("OnEvent_1036 begin");
	proxy:OnKeyTime2( 1036, "OnEvent_1036_1", 100.0, 1, 2, once );
	proxy:OnCheckEzStateMessage( 1036, 824, "OnEvent_1036_2", 650 );
	print("OnEvent_1036 end");
end

function OnEvent_1036_1(proxy,param)
	--print("OnEvent_1036_1 begin");
	proxy:SetEventCommand( 824, 800 );
	--print("OnEvent_1036_1 end");
end

function OnEvent_1036_2(proxy,param)
	print("OnEvent_1036_2 begin");
	proxy:DeleteEvent( 1036 );
	print("OnEvent_1036_2 end");
end




function OnEvent_5987(proxy,param)
	print("OnEvent_5987 begin");
	proxy:SetEventFlag( 5987, true );
	proxy:DeleteEvent( 5987 );
	print("OnEvent_5987 end");
end

--■1117■やる気をなくしたガルを殴った■ --EN:-- ■ 1117 ■ I hit a demotivated Garu ■
function OnEvent_1117(proxy,param)
	print("OnEvent_1117 begin");
	proxy:LuaCallStart( 1117 , 0 );
	print("OnEvent_1117 end");
end

--■1117■ガルを殴ったイベントの配信用■ --EN:-- ■ 1117 ■ For distribution of the event that hit Garu ■
function OnEvent_1117_1(proxy,param)
	print("OnEvent_1117_1 begin");
	--proxy:SetSpStayAndDamageAnimId( 651,-1,-1);--一応回避 --EN:--Avoid
	proxy:SetEventCommand( 651 , 901 );
	proxy:EnableLogic( 651 , true );
	proxy:ResetThink( 651 );
	print("OnEvent_1117_1 end");
end

--リーブラがダメージを受けた --EN:-- Libra takes damage
function OnEvent_1170(proxy,param)
	print("OnEvent_1170 begin");
	proxy:ChangeThink( 360 , 210004 );
	proxy:ChangeThink( 361 , 210004 );
	proxy:ChangeThink( 362 , 210004 );
	proxy:ChangeThink( 363 , 210004 );
	proxy:ChangeThink( 372 , 210004 );
	proxy:ChangeThink( 373 , 210004 );
	proxy:ChangeThink( 374 , 210004 );
	proxy:ChangeThink( 375 , 210004 );
	proxy:ChangeThink( 377 , 210004 );
	proxy:ChangeThink( 391 , 210004 );
	
	proxy:SetEventFlag( 1170 ,true );
	proxy:SetEventFlag( 1171 ,true );
	proxy:SetEventFlag( 1172 ,true );
	proxy:SetEventFlag( 1173 ,true );
	proxy:SetEventFlag( 1174 ,true );
	proxy:SetEventFlag( 1175 ,true );
	proxy:SetEventFlag( 1176 ,true );
	proxy:SetEventFlag( 1177 ,true );
	proxy:SetEventFlag( 1178 ,true );
	proxy:SetEventFlag( 1179 ,true );
	
	print("OnEvent_1170 end");
end

function OnEvent_1167(proxy,param)
	print("OnEvent_1167 begin");
	proxy:SetEventFlag( 1167 , true );
	print("OnEvent_1167 end");
end
