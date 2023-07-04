once = 1;
everytime = 0;

--ここの時間調整 --EN:--Time adjustment here
Tutorial_pausewait = 0.14;

ClearBossId = -1;
ClearBoss = false;

--強制召還フラグ --EN:--force summon flag
IsForceSummon = false;

---------------------------------------------------------------------------------------------------------------------------------
--	■使用しているシステムイベントID(4000～4095)一覧 --EN:-- ■ List of used system event IDs (4000 to 4095)
---------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------
--	4000		自分の死亡イベント --EN:-- 4000 own death events
--	4001		EzStateアクション中断時処理 --EN:-- 4001 EzState action interrupt processing
--	4002		はしごイベント入力(上)押し時 --EN:-- 4002 When pressing the ladder event input (up)
--	4003		はしごイベント入力(下)押し時 --EN:-- 4003 When pressing the ladder event input (down)
--	4004		EzStateから"1段上り終えた"を貰った時 --EN:-- 4004 When EzState gives you "One step up"
--	4005		EzStateから"1段下り終えた"を貰った時 --EN:-- When 4005 EzState gave you "One step down"
--	4010		アニメ同期(宝死体アニメ) --EN:-- 4010 Animation Synchronization (Treasure Corpse Animation)
--	4012		アニメ同期(歩きアニメ) --EN:-- 4012 Animation synchronization (walking animation)
--	4013		アニメ同期(アニメID指定付き) --EN:-- 4013 Animation synchronization (with animation ID specified)
--	4015		スーパーアーマー同期(有効化) --EN:-- 4015 Super Armor Sync (Enabled)
--	4016		スーパーアーマー同期(無効化) --EN:-- 4016 Super Armor Sync (disabled)
--	4017		完全無敵同期(有効化) --EN:-- 4017 Full Invincibility Synchronization (Enabled)
--	4018		完全無敵同期(無効化) --EN:-- 4018 Full Invincibility Synchronization (Disabled)
--  4020		死亡イレギュラー監視（コレがONの場合は異常 --EN:-- 4020 Death Irregular Monitoring (If this is ON,
--	4021		デバッグロードイベント --EN:-- 4021 debug load event
--	4030		PK復活 --EN:-- 4030 PK resurrection
--	4031
--	4032		自分の血文字イベント --EN:-- 4032 Own Blood Letter Event
--	4033		セッション切れ --EN:-- 4033 Session expired

--	3001		マルチ壁同期用 --EN:-- 3001 for multi-wall synchronization
--	3002		マルチ壁同期用 --EN:-- 3002 for multi-wall synchronization
--	3003		マルチ壁同期用 --EN:-- 3003 for multi-wall synchronization
--	4034		マルチ時魔法壁用(セッションがつながった)3001,3002,3003を使用 --EN:-- Use 3001, 3002, 3003 for 4034 multi-time magic wall (session connected)
--	4035		マルチ時魔法壁用(セッションがつながっているときから切れた) --EN:-- 4035 For multi-time magic wall (disconnected from the time the session was connected)
--	4036		SOS位置にワープ(ホワイト初期位置用) --EN:-- Warp to 4036 SOS position (for white initial position)
--	4037		ミニブロック頭位置にワープ(ブロック初期位置用) --EN:-- Warp to 4037 mini block head position (for block initial position)
--	4038		セッション情報監視(タイムアウト等でセッション失敗した時のイベント) --EN:-- 4038 Session information monitoring (event when session failed due to timeout etc.)
--	4039		乱入 --EN:-- 4039 Intrusion
--	4040		ブロッククリア(廃止) --EN:-- 4040 block clear (obsolete)
--	4041		召喚通知 --EN:-- 4041 Summon Notice
--	4042		死亡通知 --EN:-- 4042 Death Notice
--	4043		参加者がいなくなった --EN:-- 4043 Participant gone
--	4044		キックアウトしたのを通知 --EN:-- 4044 notify kicked out
--  4045        ボス部屋への魔法壁が通過可能であると通知(クライアントに対して) --EN:-- 4045 Notify the client that the magic wall to the boss room is traversable
--  4046        退出用 --EN:-- 4046 for exit
--  4047        再読み込み関連イベントの割り込み防止フラグ --EN:-- 4047 Reload-related event interrupt prevention flag
--	4048		汎用アクションボタン制限フラグ(予約) --EN:-- 4048 Generic Action Button Restriction Flag (Reserved)
--	4049		ボス部屋イベント --EN:-- 4049 Boss Room Event
--	4050		新ブロッククリア --EN:-- 4050 new block clear
--	4051		ゲートアイテム(石柱にワープする) --EN:-- 4051 Gate item (warp to stone pillar)
--	4052		石柱からのワープアニメ繋ぎ --EN:-- 4052 Warp animation connection from stone pillar
--	4053		殿堂用 --EN:-- 4053 Hall of Fame
--	4054		チェックポイント用 --EN:-- for 4054 checkpoints
--	4055		ホワイトゴースト復活通知(復活ホワイトカウント用) --EN:-- 4055 White Ghost Resurrection Notification (for Resurrection White Count)
--	4056		QWC加算処理配信用 --EN:-- For 4056 QWC additive processing distribution
--	4057		汎用同期ハンドラ登録用(実際のハンドラ登録は各マップのスクリプト、関数記述はここで行う) --EN:-- 4057 For registering general-purpose synchronous handlers (Actual handler registration is done here in each map's script, function descriptions here)
--	4058		召喚中配信 --EN:-- 4058 Summoning Delivery
--	4059		テキスト演出終了 --EN:-- 4059 End of text presentation
--	4060		ブロック移動判定用		 --EN:-- 4060 for block movement detection
--	4061		ダイアログを閉じる距離判定用 --EN:-- 4061 Close dialog For distance judgment
--	4062		タイトルへ戻る処理用 --EN:-- 4062 for returning to title
--	4063		ゲーム的理由で抜ける人を知る為の処理 --EN:-- 4063 Processing to know who leaves for game reasons
--	4064		安定したので無敵解除コール --EN:-- 4064 Call to cancel invincibility because it's stabilized
--	4065		OBJの上にPCが乗った --EN:-- PC on top of 4065 OBJ
--	4066		OBJに乗っていたPCが降りた --EN:-- PC on 4066 OBJ got off
--	4067		死亡表現無視 --EN:-- 4067 Ignore death expression
--	4068		ボス部屋阻止失敗表現 --EN:-- 4068 boss room blocking failure expression
--	4069		炎上イベント！ --EN:-- 4069 Fire Event!
--	4070		特殊効果同期 --EN:-- 4070 special effect synchronization
--	15500		乱入アイテム取得監視 --EN:-- 15500 Intrusion Item Acquisition Monitor


function g_Initialize(proxy)
print("g_Initialize global_event begin");
	--チュートリアル死亡分岐用フラグをOFF --EN:--Turn off flag for tutorial death branch
	proxy:SetEventFlag(14080,false);--砦入り口用 --EN:--for fort entrance
	proxy:SetEventFlag(14209,false);--砦用 --EN:--for fort
	proxy:SetEventFlag(14337,false);--溶岩用 --EN:--For lava
	
	--取得未遂ソウルの再取得 --EN:-- Reacquisition of Attempted Souls
	proxy:AddBlockClearBonus();
	--ペナルティのチェック --EN:-- Penalty check
	proxy:CheckPenalty();
	
--■4000■死亡時、再スタートor終了■ --EN:-- ■ 4000 ■ When you die, restart or end ■
	proxy:OnCharacterDead(99999, 10000, "OnEvent_4000", everytime);	
	proxy:NotNetMessage_begin();
		proxy:OnCharacterHP(99999,10000,"OnEvent_4000_Hp",0.0,once);
	proxy:NotNetMessage_end();
	proxy:LuaCall( 99999 , 0 , "OnEvent_4000_Hp_dummy",everytime);
	
--■4000_1■パーティー配信用死亡■ --EN:-- ■ 4000_1 ■ death for party delivery ■
	proxy:LuaCall( 4000, 1,"HostDead",everytime );

--■4001■PCがアクションを中断された時■ --EN:-- ■ 4001 ■ When the PC is interrupted ■
	proxy:OnCheckEzStateMessage(4001,10000,"OnEvent_4001",10000);
	
--■4006■PCがハシゴイベントでアクションボタンを押しているとき■優先度の問題で先に記述 --EN:-- ■ 4006 ■ When the PC is pressing the action button in the ladder event ■ Write first due to priority issues
	proxy:OnActionCheckKey(4006,10000,"OnEvent_4006",0,1);		
--■4002■PCがハシゴイベントでキー入力（上）を押しているとき■ --EN:--■4002■When the PC is pressing the key input (up) in the ladder event■
	proxy:OnActionCheckKey(4002,10000,"OnEvent_4002",1,1);
--■4003■PCがハシゴイベントでキー入力（下）を押しているとき■ --EN:--■4003■When the PC is pressing the key input (down) at the ladder event■
	proxy:OnActionCheckKey(4003,10000,"OnEvent_4003",2,1);
--■4004■PCがハシゴイベント中にEzStateから"1段上り終えた"をもらった時■ --EN:--■4004■When a PC receives "finished climbing one step" from EzState during a ladder event■
	proxy:OnCheckEzStateMessage(4004,10000,"OnEvent_4004",0);
--■4005■PCがハシゴイベント中にEzStateから"1段下り終えた"をもらった時■ --EN:--■4005■When a PC receives "completed one step down" from EzState during a ladder event■
	proxy:OnCheckEzStateMessage(4005,10000,"OnEvent_4005",1);

--■4010■アニメーションの同期用関数(宝死体用)■ --EN:-- ■ 4010 ■ Synchronization function for animation (for treasure corpse) ■
	proxy:LuaCall( 4010 , 1 , "OnEvent_4010" , everytime );
--■4012■アニメーションの同期用関数■ --EN:-- ■ 4012 ■ Synchronization function for animation ■
	proxy:LuaCall( 4012 , 1 , "OnEvent_4012" , everytime );
	
--■4013■アニメーションの同期用関数■ --EN:-- ■ 4013 ■ Synchronization function for animation ■
	proxy:LuaCall( 4013 , 1 , "OnEvent_4013" , everytime );
	proxy:CustomLuaCall( SYNCHROANIM, "SynchroAnim_4013", everytime );
	
	
--■4015■スーパーアーマーの同期有効化■ --EN:--■4015■ Super Armor Synchronization Enabled■
	proxy:LuaCall( 4015 , 1 , "OnEvent_4015" , everytime );
--■4016■スーパーアーマーの同期無効化■ --EN:-- ■ 4016 ■ Synchronization invalidation of super armor ■
	proxy:LuaCall( 4016 , 1 , "OnEvent_4016" , everytime );
	
--■4017■完全無敵の同期有効化■ --EN:--■4017■Completely invincible synchronization enabled■
	proxy:LuaCall( 4017 , 1 , "OnEvent_4017" , everytime );
--■4018■完全無敵の同期無効化■ --EN:-- ■ 4018 ■ Invincible Synchronization Invalidation ■
	proxy:LuaCall( 4018 , 1 , "OnEvent_4018" , everytime );
	
--■4019■アタリ有効無効の同期用■ --EN:-- ■ 4019 ■ For synchronization of Atari enable/disable ■
	proxy:LuaCall( 4019 , 1 , "OnEvent_4019" ,everytime );

--[[	
--■4020■PCが壁はりつきイベントでキー入力(右)を押しているとき■ --EN:-- ■ 4020 ■ When the PC is pressing the key input (right) in the wall cling event ■
	proxy:OnActionCheckKey(4020,10000,"OnEvent_4020",4,4);
--■4021■PCが壁はりつきイベントでキー入力(左)を押しているとき■ --EN:-- ■ 4021 ■ When the PC is pressing the key input (left) in the wall cling event ■
	proxy:OnActionCheckKey(4021,10000,"OnEvent_4021",3,4);	
--■4022■PCが壁はりつきイベント中にEzStateから"右に1歩進み終えた"をもらった時■ --EN:--■4022■When a PC receives "Take one step to the right" from EzState during a wall-cling event■
	proxy:OnCheckEzStateMessage(4022,10000,"OnEvent_4022",20);	
--■4023■PCが壁はりつきイベント中にEzStateから"左に1歩進み終えた"をもらった時■ --EN:--■4023■When the PC receives "Take one step to the left" from EzState during the wall cling event■
	proxy:OnCheckEzStateMessage(4023,10000,"OnEvent_4023",21);
	]]
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 4030, "g_second_Initialize", 0.1, 0, 1, once );
--■4032■自分の血文字■ --EN:-- ■ 4032 ■ My blood letter ■
		proxy:OnSelfBloodMark( 4032, "SelfBloodMark", ATTR_LIVE + ATTR_GREY, everytime );
--■4033■セッション切れ■ --EN:--■4033■Session expired■
		--proxy:OnSessionJustOut( 4033, "SessionJustOut", everytime );

	SingleReset(proxy,3001);--ブロック2で同期時 --EN:--When synchronizing in block 2
	SingleReset(proxy,3002);--ブロック3で同期時 --EN:--When synchronizing in block 3
	SingleReset(proxy,3003);--ブロック4で同期時 --EN:--When synchronizing in block 4

--■4034■マルチ時魔法壁用(セッションがつながった)■ --EN:-- ■ 4034 ■ For multi-time magic wall (session connected) ■
		proxy:OnSessionJustIn( 4034 , "OnEvent_4034" , everytime );
--■4035■マルチ時魔法壁用(セッションがつながっているときから切れた)■ --EN:-- ■ 4035 ■ For magic wall when multi-session (disconnected from the time the session was connected) ■
		proxy:OnSessionJustOut( 4035 , "OnEvent_4035" , everytime );
	proxy:NotNetMessage_end();
	

	
--■4038■セッション情報監視■ --EN:--■4038■Session information monitoring■
	proxy:NotNetMessage_begin();
		proxy:OnSessionInfo( 4038, "OnEvent_4038" );
	proxy:NotNetMessage_end();
	
--■4040■ブロッククリア■ --EN:-- ■ 4040 ■ Block clear ■
	--proxy:LuaCall( 4040 , 1 , "BlockClear" , everytime );
--■4050■新ブロッククリア■ --EN:-- ■ 4050 ■ New block clear ■
	proxy:CustomLuaCall( 4050 , "BlockClear2" , everytime );
	--アニメ同期用 --EN:--For animation synchronization
	proxy:LuaCall( 4050 , 20, "BlockClearSynchroAnime", everytime );
	--無効化同期用 --EN:--For invalidation synchronization
	proxy:LuaCall( 4050 , 30, "BlockClearSynchroInvalid", everytime );
	
--■4041■召喚通知■ --EN:-- ■ 4041 ■ summoning notification ■
	proxy:LuaCall( 4041, 1, "SummonInfoMsg_White", everytime );
	proxy:LuaCall( 4041, 2, "SummonInfoMsg_Black", everytime );
	proxy:LuaCall( 4041, 3, "SummonInfoMsg_ForceJoinBlack", everytime );
	proxy:LuaCall( 4041, 4, "SummonInfoMsg_ForceSummonBlack", everytime );
	
--■4042■死亡通知■ --EN:-- ■ 4042 ■ death notice ■
	proxy:LuaCall( 4042, 1, "DeadInfoMsg_White", everytime );
	proxy:LuaCall( 4042, 2, "DeadInfoMsg_Black", everytime );
	proxy:LuaCall( 4042, 3, "DeadInfoMsg_Host",  everytime );
	proxy:LuaCall( 4042, 4, "dummy", everytime );--これはPKで死亡した時にもブラック死亡を知る為、中身が空のダミーを呼ぶ --EN:--This will call an empty dummy to know Black's death even when he dies from PK
	proxy:LuaCall( 4042, 5, "dummy", everytime );--これは牢城3で強制召喚で呼ばれたブラックが死んだときを取る為、中身が空のダミーを呼ぶ --EN:--This calls an empty dummy to take when Black, who was summoned by forced summoning in Prison Castle 3, dies.
	proxy:LuaCall( 4042, 6, "DeadInfoMsg_ForceJoinBlack", everytime );--これは牢城3で強制召喚で呼ばれたブラックが死んだときを取る為、中身が空のダミーを呼ぶ --EN:--This calls an empty dummy to take when Black, who was summoned by forced summoning in Prison Castle 3, dies.
	
--■4043■参加者がいなくなった■ --EN:--■4043■Participant disappeared■
	proxy:NotNetMessage_begin();
		proxy:LuaCall( 4043, 1, "OnLeavePlayer", everytime );--ホワイトソウルのホワイトがいなくなった --EN:--White of White Soul is gone
		proxy:LuaCall( 4043, 2, "OnLeavePlayer", everytime );--ブラックソウルのブラックがいなくなった --EN:-- Black Soul's Black is gone
		proxy:LuaCall( 4043, 3, "OnLeavePlayer", everytime );--乱入ブラックがいなくなった --EN:--Invasion Black is gone
		proxy:LuaCall( 4043, 4, "dummy", everytime );--強制召喚されたブラックがいなくなった --EN:--The summoned black is gone
		proxy:LuaCall( 4043, 5, "dummy", everytime );--電源OFF、リセット等で無責任にいなくなった --EN:--Irresponsibly disappeared due to power off, reset, etc.
	proxy:NotNetMessage_end();
	
--■4044■キックアウトしたのを通知■ --EN:-- ■ 4044 ■ Notification of kick-out ■
	proxy:LuaCall( 4044, 1, "OnKickOut", everytime );
--■4044■感謝キックしたのを通知■ --EN:-- ■ 4044 ■ Notification of thanks kick ■
	proxy:LuaCall( 4044, 2, "OnThxKickOut", everytime );
	
	--[[いらない子？ --EN:--[[Unwanted child?
	proxy:NotNetMessage_begin();
		proxy:OnRegistFunc(4000, "Condition_AliveMotion", "Result_AliveMotion", 1, once );
	proxy:NotNetMessage_end();
	]]

--■4045■ボス部屋への魔法壁が通過可能であると通知(クライアントに対して)■ --EN:--■ 4045 ■ Notify the client that the magic wall to the boss room can be passed ■
	proxy:LuaCall( 4045, 1, "PossibleInfo_GoToTheBossArea", everytime );
--■4068■ボス部屋への阻止が失敗した事を通知(クライアントに対して)■ --EN:-- ■ 4068 ■ Notify the failure to block the boss room (to the client) ■
	proxy:LuaCall( 4068, 1, "Failed_BossArea" ,everytime);
	
--■4046■退出通知■ --EN:--■4046■Exit Notice■
	proxy:LuaCall( 4046, 1, "LeaveMessage", everytime );--ホワイト --EN:--white
	proxy:LuaCall( 4046, 2, "LeaveMessage", everytime );--ブラック --EN:--black
	proxy:LuaCall( 4046, 3, "dummy", everytime );--強制召喚されたブラックが退出した --EN:--Forcibly summoned Black left
	
	
--■4055■復活ホワイトカウント■ --EN:-- ■ 4055 ■ Resurrection White Count ■
	proxy:LuaCall( 4055, 1, "WhiteReviveCount", everytime );
	
--■4056■QWC加算処理配信用 --EN:-- ■ 4056 ■ For QWC addition processing distribution
	proxy:LuaCall( 4056, 1, "SynchroAddQWC", everytime );
	
--■4058■召喚中配信 --EN:-- ■ 4058 ■ Delivery during summoning
	proxy:LuaCall( 4058, 1, "Call_WhiteSos", everytime );--ホワイト --EN:--white
	proxy:LuaCall( 4058, 2, "Call_BlackSos", everytime );--ブラック --EN:--black
	
--■4060■ブロック移動判定	 --EN:-- ■ 4060 ■ block movement judgment
--(ASSERT回避の為dummy、使用する際は各マップでCustomLuaCallの4060で呼びたいハンドラを登録する) --EN:--(Dummy to avoid ASSERT, when using, register the handler you want to call with CustomLuaCall 4060 in each map)
--ブロック移動のたびに呼ばれ、 --EN:-- called every block move,
--param2にブロックID,param3にエリアIDが取得できます。 --EN:-- You can get the block ID in param2 and the area ID in param3.
--ブロック移動判定はローカルプレイヤのプレイ領域IDが変わった且つ、-1以外の時 --EN:--Block movement judgment is when the play area ID of the local player has changed and is other than -1
	proxy:NotNetMessage_begin();
		proxy:CustomLuaCall( 4060, "dummy", everytime );
	proxy:NotNetMessage_end();
	
	--ゲーム的理由で誰かが抜けたときに配信 --EN:--Delivered when someone leaves for game reasons
	proxy:CustomLuaCall( 4063 ,"OnGameLeave",everytime);	
	
--■4064■安定無敵解除イベント■ --EN:-- ■ 4064 ■ stable invincibility cancellation event ■
	proxy:LuaCall( 4064 ,1,"OnDisableInvincible",everytime);
	
	--■4065■OBJの上にPCが乗った■ --EN:-- ■ 4065 ■ A PC is on top of an OBJ ■
	proxy:CustomLuaCall( 4065 ,"OnEnterRideObj",everytime);	
	--■4066■OBJに乗っていたPCが降りた■ --EN:-- ■ 4066 ■ PC on OBJ got off ■
	proxy:CustomLuaCall( 4066 ,"OnLeaveRideObj",everytime);
	
	
	if proxy:IsLivePlayer() == true then
		proxy:SetEventFlag( 15112,true );
		proxy:SetEventFlag( 15113,true );
		proxy:SetEventFlag( 15114,true );
		proxy:SetEventFlag( 15115,true );
		
		proxy:SetEventFlag( 15116,true );
		proxy:SetEventFlag( 15117,true );
		proxy:SetEventFlag( 15118,true );
		proxy:SetEventFlag( 15119,true );			
	end
	
--■15500■乱入アイテム取得監視■ --EN:-- ■ 15500 ■ Intrusion item acquisition monitoring ■
	if proxy:IsCompleteEvent( 15500 ) == false then
		proxy:NotNetMessage_begin();
			proxy:LuaCall( 15500 , 0 , "OnEvent_15500",everytime);
		proxy:NotNetMessage_end();
	end
	
	local actidlist = {
		14500,14501,14502,14503,14504,14505,14506,14507,14508,14509,
		14510,14511,14512,14513,14514,14515,14516,14517,14518,14519,
		14520,14521,14522,14523,14524,14525,14526,14527,14528,14529,
		14530,14531,14532,14533,14534,14535,14536,14537,14538,14539,
		14540,14541,14542,
	};
	local num = table.getn(actidlist);
	for index = 1 , num , 1 do
		proxy:SetEventFlag( actidlist[index],false );
	end

	if	proxy:GetTempSummonParam() > 0 then
		IsForceSummon = true;
	end
	
--パーティー人数の制限を4で初期化しなおす(牢城で変えた値を戻す処理ですが、一時的な安全性を確保する為にここで初期値を入れなおします。) --EN:--Reinitialize the party size limit to 4 (It is a process to return the value changed in the prison, but to ensure temporary safety, the initial value is reset here.)
--ネットワークαが締まり次第修正 --EN:--Fixed as soon as network α is tightened
	proxy:SetPartyRestrictNum(4);

print("g_Initialize global_event end");
end

function InGameStart(proxy,param)
	print("InGameStart begin");
		proxy:LuaCallStart( 4064,1 );
		--復活アニメ再生 --EN:-- Resurrection animation playback
		if proxy:IsAliveMotion() == true then
			print("Condition_AliveMotion Alive");			
			proxy:SetTextEffect(TEXT_TYPE_Revival);
			proxy:PlayAnimation( 10000, 6100 );
			proxy:SetAliveMotion(false);
		else
			print("Condition_AliveMotion Not Alive");
			if	proxy:IsLivePlayer() == true then
				--HpMpSpMax
				--proxy:PlayerParamRecover();
				--proxy:PlayerRecover();
				proxy:PlayAnimation( 10000, 6100 );
				proxy:NotNetMessage_begin();
					proxy:OnChrAnimEnd( SYSTEM_WARP, 10000, 6100, "AliveMotion_End", once );
				proxy:NotNetMessage_end();
			elseif	proxy:IsGreyGhost() == true then
				--HpMpSpMax
				--proxy:PlayerParamRecover();
				--proxy:PlayerRecover();
				if	proxy:IsReviveWait() == true then
					proxy:RevivePlayer();
					proxy:SetReviveWait( false );
				end
				proxy:PlayAnimation( 10000, 6100 );
				proxy:NotNetMessage_begin();
					proxy:OnChrAnimEnd( SYSTEM_WARP, 10000, 6100, "AliveMotion_End", once );
				proxy:NotNetMessage_end();
			elseif	proxy:IsWhiteGhost() == true then
				print("IsWhiteAnim");
				proxy:NotNetMessage_begin();
					proxy:OnKeyTime2(4013,"AliveMotion_wait",0.1,0,0,once);
				proxy:NotNetMessage_end();
				--[[
				proxy:CustomLuaCallStartPlus( 4013, LOCAL_PLAYER, 6100 );
				--Luafunc_PlaySynchroAnimation(proxy,param,6100);
				--proxy:PlayAnimation( 10000, 6100 );
				proxy:NotNetMessage_begin();
					proxy:OnChrAnimEnd( SYSTEM_WARP, 10000, 6100, "AliveMotion_End", once );
				proxy:NotNetMessage_end();
				]]
			elseif	proxy:IsBlackGhost() == true then
				print("IsBlackAnim");
				proxy:NotNetMessage_begin();
					proxy:OnKeyTime2(4013,"AliveMotion_wait",0.1,0,0,once);
				proxy:NotNetMessage_end();
				--[[
				proxy:CustomLuaCallStartPlus( 4013, LOCAL_PLAYER, 6100 );
				--Luafunc_PlaySynchroAnimation(proxy,param,6100);
				--proxy:PlayAnimation( 10000, 6100 );
				if	proxy:GetTempSummonParam() > 0 then
					proxy:SetEventSpecialEffect( LOCAL_PLAYER, 10180 );
				end
				proxy:NotNetMessage_begin();
					proxy:OnChrAnimEnd( SYSTEM_WARP, 10000, 6100, "AliveMotion_End", once );
				proxy:NotNetMessage_end();
				]]
				if	proxy:GetTempSummonParam() > 0 then
					proxy:SetEventSpecialEffect( LOCAL_PLAYER, 10180 );					
					--ブラック強制召喚通知 --EN:-- Black forced summon notification
					--ポリ劇通知 --EN:--policy play notification
					REMO_FLAG = 2;
					proxy:LuaCallStart( 5500, 0 );
					proxy:LuaCallStart( 1030, 2 );					
				end
			end
		end
		proxy:ParamInitialize();
		
		if	proxy:IsGreyGhost()  == true or
			proxy:IsWhiteGhost() == true then
			print("SetEventSpecialEffect 10000, 101");
			proxy:SetEventSpecialEffect( 10000, 101 );
		elseif proxy:IsBlackGhost() == true then
			print("SetEventSpecialEffect 10000, 102");
			proxy:SetEventSpecialEffect( 10000, 102 );
		end
	print("InGameStart end");
end

--■4064■安定無敵解除■ --EN:-- ■ 4064 ■ stable invincibility release ■
function OnDisableInvincible(proxy,param)
	print("OnDisableInvincible begin");	
	if param:IsNetMessage() == false then		
		--配信者が自分 --EN:--By myself
		proxy:EnableInvincible( 10000 , false );
	else
		proxy:EnableInvincible( param:GetPlayID()+10001 , false );
	end
	print("OnDisableInvincible end");
end

--[[
function Condition_AliveMotion(proxy,param)
	if proxy:IsValidInstance( 10000, 1 ) == true then
		print("Condition_AliveMotion Success");
		return true;
	end
	return false;
end

function Result_AliveMotion(proxy,param)
print("Result_AliveMotion begin");
print("Result_AliveMotion end");
end

function AliveMotion_2(proxy,param)
	print("AliveMotion_2 begin");
	proxy:CustomLuaCallStartPlus( 4013, LOCAL_PLAYER, 8288 );
	--Luafunc_PlaySynchroAnimation(proxy,param,8288);
	proxy:NotNetMessage_begin();
		proxy:OnChrAnimEnd( SYSTEM_WARP, 10000, 8288, "AliveMotion_End", once );
	proxy:NotNetMessage_end();
	print("AliveMotion_2 end");
end
]]

function AliveMotion_wait(proxy,param)
	print("AliveMotion_wait begin");
	proxy:CustomLuaCallStartPlus( 4013, LOCAL_PLAYER, 6100 );
	--Luafunc_PlaySynchroAnimation(proxy,param,6100);
	--proxy:PlayAnimation( 10000, 6100 );
	proxy:NotNetMessage_begin();
		proxy:OnChrAnimEnd( SYSTEM_WARP, 10000, 6100, "AliveMotion_End", once );
	proxy:NotNetMessage_end();
	print("AliveMotion_wait end");
end

------------------------------------------------------------------------------------------------
----初期アニメ再生終了後------------------------------------------------------------------------ --EN:--After finishing the initial animation -------------------------------------------- -----------------------------
------------------------------------------------------------------------------------------------
function AliveMotion_End(proxy,param)
	if proxy:IsInParty() == true then
	print("AliveMotion_End begin");
	
		-----------------------------------------------------------------------------
		--召喚通知※タイミングを初期アニメ後に変更した為、ここへ移動 --EN:--Summon notification *Moved here because the timing was changed after the initial animation
		-----------------------------------------------------------------------------
		--通常は0が帰ってくるため、この処理は通らない --EN:--Normally 0 is returned, so this process does not pass
		--召喚される時のみ判定が行われる --EN:--Judgment is made only when summoned
		if		proxy:GetTempSummonParam() == -1 then
			--ホワイト召喚通知 --EN:-- White summon notification
			proxy:LuaCallStartPlus( 4041, 1, proxy:GetLocalPlayerId() );
		elseif 	proxy:GetTempSummonParam() == -2 then
			--ブラック召喚通知 --EN:-- Black summon notification
			proxy:LuaCallStartPlus( 4041, 2, proxy:GetLocalPlayerId() );
		elseif 	proxy:GetTempSummonParam() == -3 then
			--ブラック乱入通知 --EN:-- Black intrusion notification
			proxy:LuaCallStartPlus( 4041, 3, proxy:GetLocalPlayerId() );
		elseif 	proxy:GetTempSummonParam() >   0 then
			--ブラック強制召喚通知 --EN:-- Black forced summon notification
			proxy:LuaCallStartPlus( 4041, 4, proxy:GetLocalPlayerId() );
		end

		print("AliveMotion_End end");
	else
		proxy:ResetSummonParam();
		proxy:WARN("AliveMotion_End 既にルームが無い"); --EN:proxy:WARN("AliveMotion_End no more room");
	end
end



function g_second_Initialize(proxy, param)
print("g_second_Initialize begin");
--初期フレームだと、キャラクタのタイプが安定していないっぽいので --EN:--It seems that the character type is not stable in the initial frame
--0秒後でずらしてみました。 --EN:-- I tried shifting it after 0 seconds.
--■4030■PK監視(ブラックゴースト用)■ --EN:-- ■ 4030 ■ PK monitoring (for Black Ghost) ■
	print("PK監視追加"); --EN:print("Add PK monitor");
	proxy:OnPlayerKill( 4030, "PlayerKill_4030_sub", everytime );
	proxy:CustomLuaCall( 4030, "PlayerKill_4030", everytime );
	
--■マルチ用の魔法壁を無効化 --EN:--■ Disable magic wall for multiplayer
	if proxy:GetLocalPlayerChrType() == CHR_TYPE_GreyGhost or proxy:GetLocalPlayerChrType() == CHR_TYPE_LivePlayer then
		proxy:NotNetMessage_begin();
			proxy:OnKeyTime2( 4035 , "OnEvent_4035" , 0.0 , 0 , 1 , once );
		proxy:NotNetMessage_end();
	end
	
	if proxy:IsInParty() == false then
	end
	
print("g_second_Initialize end");
end


function OnEvent_4000_Hp(proxy,param)
	print("OnEvent_4000_Hp begin");
	--Hpが0になったので --EN:--Hp became 0
	--完全回復要求 --EN:-- full recovery request
	proxy:RequestFullRecover();
	if proxy:IsClient() == false then
		proxy:LuaCallStart( 99999 , 0 );
	end
	print("OnEvent_4000_Hp end");
end

function OnEvent_4000_Hp_dummy(proxy,param)	
end

--■4000■死亡時、再スタート■ --EN:-- ■ 4000 ■ When you die, restart ■
function OnEvent_4000(proxy, param)
	if proxy:IsCompleteEvent(4000) == true then
		--print("OnEvent_4000 IsCompleteEvent return end");
		return;
	end
	if param:IsNetMessage()==true  then
		--print("OnEvent_4000 IsNetMessage return end");
		return;
	end
	print("OnEvent_4000 begin");
	--チュートリアル砦入り口マップのフラグが成立しているなら --EN:--If the tutorial fort entrance map flag is established
	if proxy:IsCompleteEvent(14080) == true then
		proxy:SetTextEffect(TEXT_TYPE_Dead);
		proxy:OnKeyTime2(4000,"m08_00Death",0.0,0,0,once);
		return;
	end
	--チュートリアル砦マップのフラグが成立しているなら --EN:--If the tutorial fort map flag is true
	if proxy:IsCompleteEvent(14209) == true then--m08_01の死亡イベントに飛ぶ --EN:--Jump to the death event of m08_01
		proxy:SetTextEffect(TEXT_TYPE_Dead);
		proxy:OnKeyTime2(4000,"m08_01Death",0.0,0,0,once);
		return;
	end
	--チュートリアル溶岩マップのフラグが成立しているなら --EN:--If the tutorial lava map flag is true
	if proxy:IsCompleteEvent(14337) == true then--m08_02の死亡イベントに飛ぶ --EN:--Jump to the death event of m08_02
		proxy:SetTextEffect(TEXT_TYPE_Dead);
		proxy:OnKeyTime2(4000,"m08_02Death",0.0,0,0,once);
		return;
	end
	
	
	--死亡時の動作が既に入っている場合は判定しない --EN:--Do not judge if the action at the time of death is already included
	if proxy:GetReturnState() >0 then
		return;
	end
	
	local Live  = proxy:IsLivePlayer();	--生存 --EN:--survival
	local Grey  = proxy:IsGreyGhost();	--グレイゴースト --EN:--Gray Ghost
	local White = proxy:IsWhiteGhost();	--ホワイトゴースト --EN:--White Ghost
	local Black = proxy:IsBlackGhost();	--ブラックゴースト --EN:--Black Ghost
	local Host  = proxy:IsHost();		--ホストか？ --EN:--A host?
	local Party = proxy:IsInParty();	--PTか？ --EN:--PT?
	local dead  = false;				--ちゃんと死んだか？ --EN:--Did he die properly?

	--トゥルーデス判定 --EN:--True death judgment
	
	if proxy:IsCompleteEvent(4067) == false then
		if Live == true then
			proxy:SetTextEffect(TEXT_TYPE_Dead);
		else
			proxy:SetTextEffect( TEXT_TYPE_GhostDead );
		end
	end
	
	--ホスト死亡判定 --EN:--Host Death Judgment
	if Live == true or Grey == true then		
		if Live == true then
			proxy:SetEventFlag( 15112,false );
			proxy:SetEventFlag( 15113,false );
			proxy:SetEventFlag( 15114,false );
			proxy:SetEventFlag( 15115,false );
			
			proxy:SetEventFlag( 15116,false );
			proxy:SetEventFlag( 15117,false );
			proxy:SetEventFlag( 15118,false );
			proxy:SetEventFlag( 15119,false );			
		end
		if Party == true and Host == true then			
			--グレイゴーストフラグON --EN:--Gray ghost flag ON
			proxy:SetEventFlag( 16700 , true );
			--死亡数カウントアップ --EN:-- count up the number of deaths
			proxy:AddDeathCount();
			proxy:NotNetMessage_begin();
				--ホスト本人はソロプレイ死亡と同じ --EN:--The host himself is the same as solo play death
				proxy:OnKeyTime2(4000,"SoloPlayDeath",0.0,0,1,once);
			proxy:NotNetMessage_end();
			--パーティー配信用の死亡イベントを発行(ホストは内部ではじかれる) --EN:--issue death event for party delivery (host is repelled internally)
			proxy:LuaCallStart(4000, 1 );
			dead = true;
		end
	end
	
	--クライアント死亡 --EN:--Client death
	if Black == true or White == true then		
		proxy:NotNetMessage_begin();
			proxy:OnKeyTime2(4000,"PartyGhostDeath",0.0,0,1,once);
		proxy:NotNetMessage_end();
		dead = true;
	end

	--生存ソロプレイ死亡 --EN:--survival solo play death
	if Live == true or Grey == true then
		if Party == false then			
			--グレイゴーストフラグON --EN:--Gray ghost flag ON
			proxy:SetEventFlag( 16700 , true );
			--死亡数カウントアップ --EN:-- count up the number of deaths
			proxy:AddDeathCount();
			proxy:NotNetMessage_begin();
				proxy:OnKeyTime2(4000,"SoloPlayDeath", 0.0, 0,1,once);
			proxy:NotNetMessage_end();
			dead = true;
		end
	end
	
	if dead == false then
		print("Check ChrType!!");
		--異常を通知(イベント班以外で死亡で問題が発生した時にはこのフラグを見てください) --EN:-- Notification of anomaly (Please see this flag when a problem occurs due to death outside the event team)
		--キャラタイプが生存、グレイ、ホワイト、ブラック以外の可能性があります。 --EN:--There is a possibility that the character type is other than Survival, Gray, White, and Black.
		--ロードをさせないで、キャラタイプを確認してください。 --EN:--Don't let it load, check your character type.
		proxy:NotNetMessage_begin();
			proxy:OnKeyTime2(4000,"SoloPlayDeath", 0.0, 0,1,once);
		proxy:NotNetMessage_end();
		proxy:SetEventFlag(4020,true);
	end	
	proxy:SetEventFlag(4000,true);
	print("OnEvent_4000 end");
end




--■4000_1■パーティー配信用死亡■ --EN:-- ■ 4000_1 ■ death for party delivery ■
function HostDead(proxy, param)	
	if proxy:IsHost() == true or proxy:IsGreyGhost() == true then
		return;
	end
	if proxy:IsCompleteEvent( 4047 ) == true then
		return;
	end
	
	--ブラックゴーストの場合は目標達成の流れへ --EN:--In the case of Black Ghost, go to the goal achievement flow
	if	proxy:IsBlackGhost() == true then
		proxy:NotNetMessage_begin();
			--他の再読み込み系イベントの割り込みを防止 --EN:--Prevent interruption of other reloading events
			proxy:SetEventFlag( 4047, true );
			--イベント内部にもロード待ちである事を通知 --EN:-- Notify that it is waiting for loading inside the event
			proxy:SetLoadWait();
			
		proxy:NotNetMessage_end();
		
		--システムメッセージ		 --EN:--system message
		proxy:SetTextEffect( TEXT_TYPE_TargetClear );
		
		proxy:NotNetMessage_begin();
			proxy:OnTextEffectEnd(4059, TEXT_TYPE_TargetClear, "TextEffectEnd_PK_Success");
		proxy:NotNetMessage_end();
		
		--proxy:SetTextEffect( TEXT_TYPE_Revival );
		--proxy:LuaCallStartPlus( 4056, 1, 210 );--AddQWC配信(マルチでホストを殺したQWC加算) --EN:--AddQWC distribution (QWC addition that killed the host in multi)
		return;
	end
	
	--他の再読み込み系イベントの割り込みを防止 --EN:--Prevent interruption of other reloading events
	proxy:SetEventFlag(4047, true);
	--イベント内部にもロード待ちである事を通知 --EN:-- Notify that it is waiting for loading inside the event
	proxy:SetLoadWait();
	
	print("HostDead begin");
	
	
	
	--目標失敗 --EN:--Target failed
	MissionFailed(proxy,param);
	
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2(4000,"HostDead_1",5.0,0,0,once);
		proxy:OnKeyTime2(4000,"EventMenuBrake",5.0,1,1,once);
	proxy:NotNetMessage_end();
	
	--イベント終了 --EN:--End of event
	proxy:SetEventFlag(4000,true);
	
	
	print("HostDead end");
end

function HostDead_1(proxy, param)
	print("HostDead_1 begin");
	
	--イベントフラグロールバック --EN:--eventflag rollback
	proxy:SetFlagInitState(2);
	
	--召喚前の位置設定 --EN:--Position settings before summoning
	proxy:SetSummonedPos();	
	
	--現在のマップと同じIDを次マップIDとして設定 --EN:--Set the same ID as the current map as the next map ID
	proxy:SetDefaultMapUid(-1);	
	
	--ワープを行う --EN:--do warp
	proxy:WarpNextStageKick();
	
	--グレイゴースト化 --EN:--Gray ghost
	--proxy:SetChrTypeDataGrey();
	proxy:SetChrTypeDataGreyNext();
	
	print("HostDead_1 end");
end



--[[
--■4000_2■トゥルーデス用死亡■ --EN:-- ■ 4000_2 ■ Death for Trudeath ■
function TrueDeath(proxy,param)
	print("TrueDeath begin");
	
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 4000, "TrueDeath_1", 5.0, 0, 3, once );
	proxy:NotNetMessage_end();
	
	--システムメッセージ	 --EN:--system message
	proxy:SetEventFlag( 4000, true );
end

function TrueDeath_1(proxy,param)
	print("TrueDeath_1 begin");
	
	--トゥルーデスペナルティ --EN:--True Death Penalty
	proxy:TrueDeathPenalty();
	
	--プレイヤー復活 --EN:--Player Resurrection
	proxy:RevivePlayer();
	
	--ワープ先指定 --EN:--Specify warp destination
	proxy:SetMapUid( 1, 0, 0, 0, -1 );	
	
	--0.2秒後、TrueDeath_2を実行 --EN:--After 0.2 seconds, execute TrueDeath_2
	proxy:OnKeyTime2(4000,"TrueDeath_2",0.2,0,0,once);
	
	proxy:LuaCallStartPlus( 4056, 1, 110 );--AddQWC配信 --EN:--AddQWC distribution
	
	print("TrueDeath_1 end");
end


function TrueDeath_2(proxy,param)
	print("TrueDeath_2 begin");
	
	--ワープを行う --EN:--do warp
	proxy:WarpNextStageKick();
	
	print("TrueDeath_2 end");
end
]]



--■4000_3■パーティー解散用■ --EN:--■4000_3■For dissolution of the party■
function OnEvent_4000_3(proxy,param)

	print("マルチ解散"); --EN:print("Multi dissolution");
	proxy:ReturnMapSelect();
end




--■4000_4■ソロ通常死亡■ --EN:-- ■ 4000_4 ■ Solo normal death ■
function SoloPlayDeath(proxy,param)
	print("SoloPlayDeath SetRestart");
	
	if proxy:IsCompleteEvent( 4047 ) == true then
		return;
	end
	
	--他の再読み込み系イベントの割り込みを防止 --EN:--Prevent interruption of other reloading events
	proxy:SetEventFlag(4047, true);
	
	
	--目標失敗 --EN:--Target failed
	MissionDeadFailed(proxy,param);
	
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 4000, "SoloPlayDeath_1", 3, 0, 3, once );
	proxy:NotNetMessage_end();
	
	--PKによる死亡ではない時、ホスト死亡のメッセージを配信 --EN:--Delivery host death message when death is not due to PK
	if proxy:IsCompleteEvent( 4030 ) == false then
		proxy:LuaCallStartPlus( 4042, 3, proxy:GetLocalPlayerId() );
	end
	
	print("SoloPlayDeath end");
end

function SoloPlayDeath_1(proxy,param)
	print("SoloPlayDeath_1 begin");
	
	proxy:NotNetMessage_begin();
		--proxy:OnBloodMenuClose(4000,"SoloPlayDeath_2",300.0, once);
		SoloPlayDeath_2(proxy,param);
	proxy:NotNetMessage_end();
	
	print("SoloPlayDeath_1 end");
end


function SoloPlayDeath_2(proxy,param)
	print("SoloPlayDeath_2 begin");

	--フラグの初期化スキップ --EN:--flag initialization skip
	proxy:SetFlagInitState(1);
	
	--エリア初期位置のマップIDセット --EN:--Map ID set for area initial position
	--proxy:SetAreaStartMapUid(-1);
	proxy:SetDefaultMapUid( 999 - proxy:GetLastBlockId() );
	
	--ワープを行う --EN:--do warp
	proxy:WarpNextStageKick();
	
	--復活アニメ再生 --EN:-- Resurrection animation playback
	proxy:PlayAnimation( 10000, 6100 );
	
	--死亡イベント受付可能 --EN:--Can accept death events
	proxy:SetEventFlag(4000,false);
	
	--徘徊デーモン用 --EN:--For prowling daemons
	proxy:LuaCallStart( 4000, 100 );
	
	--グレイゴースト化 --EN:--Gray ghost
	--proxy:SetChrTypeDataGrey();
	if proxy:IsCompleteEvent(4067) == false then
		proxy:SetChrTypeDataGreyNext();
	end
	
	--血文字更新 --EN:--Blood letter update
	proxy:UpDateBloodMark();
	if proxy:IsLivePlayer() == true then
		--死亡のQWC変動を削除 --EN:--removed death QWC variation
		proxy:LuaCallStartPlus( 4056, 1, 100 );--AddQWC配信（ゴースト化するQWC加算） --EN:--AddQWC distribution (QWC addition to ghost)
	end
	print("SoloPlayDeath_2 end");
end




--■4000_5■ホワイトブラックゴースト時の死亡用■ --EN:-- ■ 4000_5 ■ For death during white black ghost ■
function PartyGhostDeath(proxy,param)
	print("PartyGhostDeath begin");
	
	if proxy:IsCompleteEvent( 4047 ) == true then
		return;
	end
	--他の再読み込み系イベントの割り込みを防止 --EN:--Prevent interruption of other reloading events
	proxy:SetEventFlag(4047, true);
	--他の再読み込み系イベントの割り込みを防止 --EN:--Prevent interruption of other reloading events
	proxy:SetEventFlag(4047, true);
	
	--自分のプレイヤーIDを配信してゲーム的に抜ける事を通知 --EN:--Distribute your player ID and notify that you are leaving the game
	proxy:CustomLuaCallStart( 4063 , proxy:GetLocalPlayerId() );
	
	--イベントフラグロールバック --EN:--eventflag rollback
	proxy:SetFlagInitState(2);
	
	proxy:NotNetMessage_begin();
		proxy:OnTextEffectEnd( 4059, TEXT_TYPE_GhostDead, "PartyGhostDeath_1");
	proxy:NotNetMessage_end();
	
	
	--proxy:NotNetMessage_begin();
	--	proxy:OnKeyTime2( 4000, "PartyGhostDeath_1", 5.0, 0, 3, once );
	--proxy:NotNetMessage_end();
	
	--PKによる死亡ではない時、死亡のメッセージを配信 --EN:--Delivery death message when death is not due to PK
	if proxy:IsCompleteEvent( 4030 ) == false then
		if proxy:IsWhiteGhost() == true then
			proxy:LuaCallStartPlus( 4042, 1, proxy:GetLocalPlayerId() );
		else
			proxy:LuaCallStartPlus( 4042, 2, proxy:GetLocalPlayerId() );
			if	proxy:GetTempSummonParam() > 0 then
				proxy:LuaCallStartPlus( 4042, 5, proxy:GetLocalPlayerId() );
			end
		end
	else
		--PKで死んだ場合も、強制召喚されたブラックの場合は強制召喚死亡としてカウント --EN:--Even if you die in PK, it counts as forced summon death if black is summoned forcibly.
		if	proxy:GetTempSummonParam() > 0 then
			proxy:LuaCallStartPlus( 4042, 2, proxy:GetLocalPlayerId() );
			proxy:LuaCallStartPlus( 4042, 5, proxy:GetLocalPlayerId() );			
		--ホワイトソウル --EN:--White Soul
		elseif	proxy:GetTempSummonParam() == -1 then
			proxy:LuaCallStartPlus( 4042, 1, proxy:GetLocalPlayerId() );
			proxy:LuaCallStartPlus( 4042, 4, proxy:GetLocalPlayerId() );			
		--ブラックソウル --EN:--Black Soul
		elseif	proxy:GetTempSummonParam() == -2 then
			proxy:LuaCallStartPlus( 4042, 2, proxy:GetLocalPlayerId() );
			proxy:LuaCallStartPlus( 4042, 4, proxy:GetLocalPlayerId() );			
		--乱入 --EN:--Intrusion
		elseif	proxy:GetTempSummonParam() == -3 then
			proxy:LuaCallStartPlus( 4042, 6, proxy:GetLocalPlayerId() );
			proxy:LuaCallStartPlus( 4042, 4, proxy:GetLocalPlayerId() );			
		end
	end
	
	
	proxy:SetEventFlag(4000,true);
	
	print("PartyGhostDeath end");
end

function PartyGhostDeath_1(proxy,param)
	print("PartyGhostDeath_1 begin");
	
	if ClearBoss == false then
		--目標失敗 --EN:--Target failed
		MissionDeadFailed(proxy,param);	
		proxy:NotNetMessage_begin();
			proxy:OnRequestMenuEnd(4000, "PartyGhostDeath_2");
		proxy:NotNetMessage_end();
	else
		--proxy:NotNetMessage_begin();
		--	proxy:OnKeyTime2( 4050 ,"BlockClear2_3" , 5.0 , 0 , 100 , once );
		--proxy:NotNetMessage_end();
	end
	
	print("PartyGhostDeath_1 end");
end



function PartyGhostDeath_2(proxy,param)
	print("PartyGhostDeath_2 begin");
	
	if ClearBoss == false then
		if proxy:IsCompleteEvent( 4030 ) == false then
			print("デスペナルティ！！"); --EN:print("Death Penalty!!");
			--ソウルペナルティ --EN:--Soul Penalty
			--proxy:DeathPenalty( DeathPenalty_SoulAdjust, DeathPenalty_SoulMAX );
				
			if	proxy:IsBlackGhost() == true then				
				--強制召還なら --EN:--Forcibly summoned
				if	proxy:GetTempSummonParam() > 0 then					
					--強制召還以外のブラックなら --EN:--For blacks other than forced summons
				else
					--ペナルティ --EN:--penalty
					proxy:SetLeaveSoulSteel();
					print("デスペナルティ！！"); --EN:print("Death Penalty!!");
				end
			end
		end
		--召喚前の位置設定 --EN:--Position settings before summoning
		proxy:SetSummonedPos();
		--現在のマップと同じIDを次マップIDとして設定 --EN:--Set the same ID as the current map as the next map ID
		proxy:SetDefaultMapUid(-1);
		--ワープを行う --EN:--do warp
		proxy:WarpNextStageKick();
		--完全回復要求 --EN:-- full recovery request
		--proxy:RequestFullRecover();
		--グレイゴースト化 --EN:--Gray ghost
		--proxy:SetChrTypeDataGrey();
		proxy:SetChrTypeDataGreyNext();
	else
		--proxy:NotNetMessage_begin();
		--	proxy:OnKeyTime2( 4050 ,"BlockClear2_3" , 2.0 , 0 , 100 , once );
		--proxy:NotNetMessage_end();
	end
		
	print("PartyGhostDeath_2 end");
end


--■4042■死亡通知■ --EN:-- ■ 4042 ■ death notice ■
function DeadInfoMsg_White(proxy,param)
	print("DeadInfoMsg_White begin");
	--自分以外の死 --EN:--Death other than yourself
	if param:IsNetMessage() == true then
		--ホスト --EN:--host
		if	proxy:IsGreyGhost() == true or proxy:IsLivePlayer() == true then
			if proxy:EventTagInsertString_forPlayerNo( TAG_IDX_deadChara, param:GetParam3() ) == true then
				proxy:RecallMenuEvent( 0, 8980 );
			end
		--第三者 --EN:--third party
		else
			if proxy:EventTagInsertString_forPlayerNo( TAG_IDX_deadChara, param:GetParam3() ) == true then
				--ホワイトソウル --EN:--White Soul
				if	proxy:GetTempSummonParam() == -1 then
					proxy:RecallMenuEvent( 0, 8983 );
				--ブラックソウル --EN:--Black Soul
				elseif	proxy:GetTempSummonParam() == -2 then
					proxy:RecallMenuEvent( 0, 8984 );
				--乱入 --EN:--Intrusion
				elseif	proxy:GetTempSummonParam() == -3 then
					proxy:RecallMenuEvent( 0, 8985 );
				--強制召喚 --EN:--forced summon
				elseif	proxy:GetTempSummonParam() >   0 then
					proxy:RecallMenuEvent( 0, 8986 );
				end
			else
				proxy:WARN("PCNameのタグ差し替え失敗"); --EN:proxy:WARN("PCName tag replacement failure");
			end
		end		
	--死んだのが自分 --EN:--I am the one who died
	else		
	end
	print("DeadInfoMsg_White end");
end

function DeadInfoMsg_Black(proxy,param)
	print("DeadInfoMsg_Black begin");
	--自分以外の死 --EN:--Death other than yourself
	if param:IsNetMessage() == true then
		--ホスト --EN:--host
		if	proxy:IsGreyGhost() == true or proxy:IsLivePlayer() == true then
			if proxy:EventTagInsertString_forPlayerNo( TAG_IDX_deadChara, param:GetParam3() ) == true then
				proxy:RecallMenuEvent( 0, 8991 );
			end
		--第三者 --EN:--third party
		else
			if proxy:EventTagInsertString_forPlayerNo( TAG_IDX_deadChara, param:GetParam3() ) == true then
				--ホワイトソウル --EN:--White Soul
				if	proxy:GetTempSummonParam() == -1 then
					proxy:RecallMenuEvent( 0, 8993 );
				--ブラックソウル --EN:--Black Soul
				elseif	proxy:GetTempSummonParam() == -2 then
					proxy:RecallMenuEvent( 0, 8994 );
				--乱入 --EN:--Intrusion
				elseif	proxy:GetTempSummonParam() == -3 then
					proxy:RecallMenuEvent( 0, 8995 );
				--強制召喚 --EN:--forced summon
				elseif	proxy:GetTempSummonParam() >   0 then
					proxy:RecallMenuEvent( 0, 8996 );
				end
			else
				proxy:WARN("PCNameのタグ差し替え失敗"); --EN:proxy:WARN("PCName tag replacement failure");
			end
		end		
	--死んだのが自分 --EN:--I am the one who died
	else
		--ブラックソウル --EN:--Black Soul
		if	proxy:GetTempSummonParam() == -2 then
			--proxy:RecallMenuEvent( 0, 9004 );
		--乱入 --EN:--Intrusion
		elseif	proxy:GetTempSummonParam() == -3 then
			--proxy:RecallMenuEvent( 0, 9005 );
		end		
	end
	print("DeadInfoMsg_Black end");
end

function DeadInfoMsg_Host(proxy,param)
	print("DeadInfoMsg_Host begin");
	if param:IsNetMessage() == true then		
	end
	print("DeadInfoMsg_Host end");
end

function DeadInfoMsg_ForceJoinBlack(proxy,param)
	print("DeadInfoMsg_ForceJoinBlack begin");
	--自分以外の死 --EN:--Death other than yourself
	if param:IsNetMessage() == true then
		--ホスト --EN:--host
		if	proxy:IsGreyGhost() == true or proxy:IsLivePlayer() == true then
			if proxy:EventTagInsertString_forPlayerNo( TAG_IDX_deadChara, param:GetParam3() ) == true then
				proxy:RecallMenuEvent( 0, 8992 );
			end
		--第三者 --EN:--third party
		else
			if proxy:EventTagInsertString_forPlayerNo( TAG_IDX_deadChara, param:GetParam3() ) == true then
				--ホワイトソウル --EN:--White Soul
				if	proxy:GetTempSummonParam() == -1 then
					proxy:RecallMenuEvent( 0, 8993 );
				--ブラックソウル --EN:--Black Soul
				elseif	proxy:GetTempSummonParam() == -2 then
					proxy:RecallMenuEvent( 0, 8994 );
				--乱入 --EN:--Intrusion
				elseif	proxy:GetTempSummonParam() == -3 then
					proxy:RecallMenuEvent( 0, 8995 );
				--強制召喚 --EN:--forced summon
				elseif	proxy:GetTempSummonParam() >   0 then
					proxy:RecallMenuEvent( 0, 8996 );
				end
			else
				proxy:WARN("PCNameタグの差し替えに失敗"); --EN:proxy:WARN("Failed to replace PCName tag");
			end
		end		
	--死んだのが自分 --EN:--I am the one who died
	else
		--ブラックソウル --EN:--Black Soul
		if	proxy:GetTempSummonParam() == -2 then
			--proxy:RecallMenuEvent( 0, 9004 );
		--乱入 --EN:--Intrusion
		elseif	proxy:GetTempSummonParam() == -3 then
			--proxy:RecallMenuEvent( 0, 9005 );
		end		
	end
	print("DeadInfoMsg_ForceJoinBlack end");
end


----------------------------------------------------------------------------------------------------------------
--■4030■PK復活■ --EN:-- ■ 4030 ■ PK revival ■
----------------------------------------------------------------------------------------------------------------
--param2:殺された人のPlayerNo --EN:--param2: PlayerNo of the killed person
--param3:殺した人のPlayerNo --EN:--param3: PlayerNo of the killer
function PlayerKill_4030_sub( proxy,param)
	local nDeadPlayerNo = proxy:VariableExpand_22_param1( param:GetParam2() );
	local nKillPlayerNo = proxy:VariableExpand_22_param2( param:GetParam2() );
	local nDeadPlayerSummonParam = param:GetParam3();--死んだプレイヤの召喚されたタイプ --EN:--summoned type of dead player
	local nThisPlayerNo = proxy:GetLocalPlayerId();
	local nThisSummonParam = proxy:GetTempSummonParam();
	if	nThisPlayerNo == nKillPlayerNo then
		--殺した人が改めて再配信(殺した人の召喚タイプを取得する為) --EN:--The person who killed is re-delivered (to get the summoning type of the person who killed)
		local nOrderParam = proxy:VariableOrder_22( nDeadPlayerSummonParam, nThisSummonParam );
		proxy:CustomLuaCallStartPlus( 4030, param:GetParam2(), nOrderParam );
		--proxy:SetEventFlag( 4030, true );
	end
end

function PlayerKill_4030(proxy, param)
	print("PlayerKill_4030 begin");
	local nDeadPlayerNo			 = proxy:VariableExpand_22_param1( param:GetParam2() );
	local nKillPlayerNo 		 = proxy:VariableExpand_22_param2( param:GetParam2() );
	local nDeadPlayerSummonParam = proxy:VariableExpand_22_param1( param:GetParam3() );--死んだ人の召喚タイプ --EN:-- dead person summon type
	local nKillPlayerSummonParam = proxy:VariableExpand_22_param2( param:GetParam3() );--殺した人の召喚タイプ --EN:-- Summon type of the person who killed
	local nThisPlayerNo			 = proxy:GetLocalPlayerId();
	local nHostNo				 = proxy:GetHostPlayerNo();
	
	print("nDeadPlayerNo = ",nDeadPlayerNo);
	print("nKillPlayerNo = ",nKillPlayerNo);
	print("nDeadPlayerSummonParam = ",nDeadPlayerSummonParam);
	print("nKillPlayerSummonParam = ",nKillPlayerSummonParam)
	print("nThisPlayerNo = ",nThisPlayerNo);
	print("nHostNo = ",nHostNo);
	
	local IsHostDead;
	if nHostNo == nDeadPlayerNo then
		IsHostDead = true;
	else
		IsHostDead = false;
	end
	local IsWhite		= proxy:IsWhiteGhost();
	local IsBlack		= proxy:IsBlackGhost();
	
	--英語で書くと読めなかったので、ローマ字で代用 --EN:--I couldn't read it when I wrote it in English, so I used romaji instead.
	print( "PlayerNo:<",nDeadPlayerNo, "> ga ","PlayerNo:<",nKillPlayerNo, "> ni korosareta" );
	print( "LocalPlayerNo:<",nThisPlayerNo, "> LocalPlayerType<",proxy:GetLocalPlayerChrType(), ">");
	print( "HostNo<",nHostNo,">IsHostDead<",IsHostDead,">IsWhite<",IsWhite,">IsBlack<",IsBlack,">")
	
	
	if proxy:IsCompleteEvent( 4047 ) == true then
		print("EventFlag4047 is true return");
		return;
	end
	
	--死んだのが自分ではない時 --EN:--When you're not the one who died
	if nThisPlayerNo ~= nDeadPlayerNo then
		--ブラックが生存を殺した --EN:-- Black killed survival
		if IsHostDead == true and nThisPlayerNo == nKillPlayerNo and IsBlack == true then
			print("ホストPK　QWC　black > host"); --EN:print("Host PK QWC black > host");
			proxy:LuaCallStartPlus( 4056, 1, 210 );--AddQWC配信(マルチでホストを殺したQWC加算) --EN:--AddQWC distribution (QWC addition that killed the host in multi)
		end
		
		--ホワイトが生存を殺した --EN:--white killed survival
		if IsHostDead == true and nThisPlayerNo == nKillPlayerNo and IsWhite == true then			
			print("不可能犯罪　white > host"); --EN:print("Impossible crime white > host");
			proxy:LuaCallStartPlus( 4056, 1, 210 );--AddQWC配信(マルチでホストを殺したQWC加算) --EN:--AddQWC distribution (QWC addition that killed the host in multi)
		end
		
		--自分以外が生存を殺した --EN:--other than myself killed survival
		if IsHostDead == true and nThisPlayerNo ~= nKillPlayerNo then
		end
		
		--自分以外が生存以外を殺した --EN:--other than myself killed other than survival
		if IsHostDead == false and nThisPlayerNo ~= nKillPlayerNo then			
		end
		
		--自分が生存以外を殺した --EN:--I killed someone other than survival
		if IsHostDead == false and nThisPlayerNo == nKillPlayerNo then
			print("自分が生存以外を殺した");			 --EN:print("I killed a non-survivor");
			print("NetChrType = ",proxy:GetNetPlayerChrType(nDeadPlayerNo) );
			--ホワイトを殺した --EN:--killed white
			if	proxy:IsWhiteGhost_NetPlayer(nDeadPlayerNo) == true then
				print("ホワイト殺しQWC");				 --EN:print("White killing QWC");
				proxy:LuaCallStartPlus( 4056, 1, 220 );--AddQWC配信(マルチでホワイトを殺したQWC加算) --EN:--AddQWC delivery (QWC addition that killed white in multiplayer)
			--ブラックを殺した --EN:--Killed Black
			elseif	proxy:IsBlackGhost_NetPlayer(nDeadPlayerNo) == true then
				print("ブラック殺しQWC"); --EN:print("Black killing QWC");
				--生存のみテキスト演出を表示 --EN:-- Show survival only text rendition
				if	IsWhite == false then
					proxy:SetTextEffect( TEXT_TYPE_BlackClear );
					proxy:NotNetMessage_begin();
						proxy:OnTextEffectEndPlus(4059, TEXT_TYPE_BlackClear, nDeadPlayerSummonParam,"TextEffectEnd_BlackPK_Success");
					proxy:NotNetMessage_end();
				end
				proxy:LuaCallStartPlus( 4056, 1, 230 );--AddQWC配信(マルチでブラックを殺したQWC加算) --EN:--AddQWC distribution (QWC addition that killed black in multiplayer)
				proxy:AddKillBlackGhost();--殺したブラックの数を加算				 --EN:--add the number of blacks killed
			end
			
			print("NetChrSummonParam = ",nDeadPlayerSummonParam );
			print("nDeadPlayerNo = ",nDeadPlayerNo);
			--ホワイトソウル --EN:--White Soul
			if		nDeadPlayerSummonParam == -1 then
				if nKillPlayerSummonParam == -3 then
					print("乱入ブラック＞ホワイト殺害ボーナス"); --EN:print("Intrusion Black > White Kill Bonus");
					proxy:SoulPenaltyPK2(nDeadPlayerNo,-0.5);
				end
			--ブラックソウル --EN:--Black Soul
			elseif	nDeadPlayerSummonParam == -2 then
			--乱入 --EN:--Intrusion
			elseif	nDeadPlayerSummonParam == -3 then
				--if proxy:IsClient() == false then
					print("乱入ブラック殺害ボーナス") --EN:print("Burst Black kill bonus")
					--proxy:SoulPenaltyPK( -PK_Soul_Penalty_FIX, -PK_Soul_Penalty_BASE, PK_Soul_Penalty_MAX, PK_Soul_Penalty_Adjust );
					proxy:SoulPenaltyPK2(nDeadPlayerNo,-0.5);
				--end
			--強制召喚 --EN:--forced summon
			elseif	nDeadPlayerSummonParam  >  0 then			
			end
		end
	--死んだのが自分の時 --EN:--When I died
	else
		print("PlayerKill_4030 ThisDead");
		proxy:SetEventFlag( 4030, true );
		--死んだのがホスト --EN:--the host is dead
		if	proxy:IsLivePlayer() == true or proxy:IsGreyGhost() == true then
			print("PlayerKill_4030 LiveDead");
			--通常ブラックに殺された --EN:--usually killed by Black
			if	nKillPlayerSummonParam ==  -2 then
				print("SoulSteel Black -> Host");
				--ソウルスティール --EN:--Soul Steel
				proxy:SetEventSpecialEffectOwner_2( nKillPlayerNo + 10001, LOCAL_PLAYER, 13 );
			--乱入ブラックに殺された --EN:--Killed by Intruder Black
			elseif	nKillPlayerSummonParam ==  -3 then
				--通常の死亡のみ --EN:--normal death only
			end
		end
		
		--ホワイトソウル --EN:--White Soul
		if		proxy:GetTempSummonParam() == -1 then
			print("PlayerKill_4030 WhiteDead");
			--通常ブラックに殺された --EN:--usually killed by Black
			if		nKillPlayerSummonParam ==  -2 then
				print("PKPenalty");
				--PKのソウルペナルティ --EN:--PK Soul Penalty
				--proxy:SoulPenaltyPK( PK_Soul_Penalty_FIX, PK_Soul_Penalty_BASE, PK_Soul_Penalty_MAX, PK_Soul_Penalty_Adjust );
				--proxy:SoulPenaltyPK2(nDeadPlayerNo,0.5);
				--ソウルスティール --EN:--Soul Steel
				proxy:SetEventSpecialEffectOwner_2( nKillPlayerNo + 10001, LOCAL_PLAYER, 13 );
			--乱入ブラックに殺された --EN:--Killed by Intruder Black
			elseif	nKillPlayerSummonParam ==  -3 then
				print("PKPenalty");
				--PKのソウルペナルティ --EN:--PK Soul Penalty
				--proxy:SoulPenaltyPK( PK_Soul_Penalty_FIX, PK_Soul_Penalty_BASE, PK_Soul_Penalty_MAX, PK_Soul_Penalty_Adjust );
				proxy:SoulPenaltyPK2(nDeadPlayerNo,0.5);
			end			
		--ブラックソウル --EN:--Black Soul
		elseif	proxy:GetTempSummonParam() == -2 then
			print("PlayerKill_4030 BlackDead");
			--生存orホワイトに殺された --EN:--Alive or killed by White
			if	nKillPlayerSummonParam ==  0 or
				nKillPlayerSummonParam == -1 then
				print("SoulSteel Live or White -> Black");
				--ソウルスティール --EN:--Soul Steel
				proxy:SetEventSpecialEffectOwner_2( nKillPlayerNo + 10001, LOCAL_PLAYER, 13 );
			end
		--乱入 --EN:--Intrusion
		elseif	proxy:GetTempSummonParam() == -3 then
			print("PlayerKill_4030 ForceJoinDead");
			--生存に殺された --EN:--Killed to Survival
			if	nKillPlayerSummonParam ==  0 then
				print("PKPenalty");
				proxy:SoulPenaltyPK2(nDeadPlayerNo,0.5);
			end
			--ホワイトに殺された --EN:--Killed by White
			if	nKillPlayerSummonParam == -1 then
				print("PKPenalty");
				--PKのソウルペナルティ --EN:--PK Soul Penalty
				--proxy:SoulPenaltyPK( PK_Soul_Penalty_FIX, PK_Soul_Penalty_BASE, PK_Soul_Penalty_MAX, PK_Soul_Penalty_Adjust );				
				proxy:SoulPenaltyPK2(nDeadPlayerNo,0.5);
			end
		end
	end
	
	print("PlayerKill_4030 end");
end

function PlayerKill_4030_1(proxy, param)
	print("PlayerKill_4030_1 begin");
	
	--フラグをロールバックします。 --EN:-- rollback flag.
	proxy:SetFlagInitState(2);
	
	--復活するのでペナルティで減少したパラメータを元に戻す(最大値のみ) --EN:--Since it will be revived, restore the parameters that have been reduced by the penalty (maximum value only)
	proxy:EraseEventSpecialEffect( 10000, 101 );
	--proxy:PlayerParamRecover();
	
	--元グレイなら復活 --EN:-- Resurrection if ex-gray
	if proxy:IsPrevGreyGhost() == true then
		--復活するので復活アニメフラグをセット --EN:-- Set the resurrection animation flag because it will be revived
		proxy:SetAliveMotion( true );
	end
	
	--HpMpSpを完全回復 --EN:--Full recovery of HpMpSp
	--proxy:PlayerRecover();
	
	--生存状態に設定した上で、自分の血文字位置へワープ --EN:--Warp to your blood letter position after setting it to a living state
	--proxy:WarpSelfBloodMark(false);
	proxy:SetSelfBloodMapUid();
	--proxy:RevivePlayer();
	proxy:RevivePlayerNext();--次のロードで蘇生 --EN:--Respawn on next load
	proxy:RequestFullRecover();
	proxy:WarpNextStageKick();
	
	print("PlayerKill_4030_1 end");
end

----------------------------------------------------------------------------------------------------------------
--■4059■テキスト演出終了後 --EN:-- ■ 4059 ■ After the text effect
----------------------------------------------------------------------------------------------------------------
--（ブラックが生存を殺した）PKに成功した時のテキスト演出終了時 --EN:-- At the end of the text effect when the PK was successful (Black killed the survival)
--召還者を倒したテキスト演出表示後 --EN:--After displaying the text effect of defeating the summoner
function TextEffectEnd_PK_Success(proxy,param)
	print("TextEffectEnd_PK_Success begin");
	proxy:NotNetMessage_begin();
		proxy:OnRequestMenuEnd( 4059, "RequestMenuEnd_PK_Sucess" );
	proxy:NotNetMessage_end();
	
--[[
	--ブラックソウル --EN:--Black Soul
	if	proxy:GetTempSummonParam()		== -2 then
		proxy:RecallMenuEvent( 0, 8914 );
	--乱入 --EN:--Intrusion
	elseif	proxy:GetTempSummonParam()	== -3 then
		proxy:RecallMenuEvent( 0, 8915 );
	end
]]

	--強制召喚ブラックが目標達成した時はターバンを持ち帰る --EN:-- Bring back the turban when the forced summon black achieves the goal
	--local tmpSummonParam = proxy:GetTempSummonParam();
	--print("召還パラメータ:",tmpSummonParam); --EN:--print("Summon Parameter:",tmpSummonParam);
	--if	proxy:GetTempSummonParam() > 0 then
	if IsForceSummon == true then
		print("ターバンイベント発動"); --EN:print("Turban event triggered");
		proxy:GetRateItem(16581);
	end
	
	--目標達成 --EN:--Goal achievement
	MissionSuccessed(proxy,param);

	print("TextEffectEnd_PK_Success end");
end

--（ブラックが生存を殺した）PKに成功した時の要請メニュー終了時 --EN:-- At the end of the request menu when the PK was successful (Black killed the survival)
function RequestMenuEnd_PK_Sucess(proxy,param)
	print("RequestMenuEnd_PK_Sucess begin");
	
	--PK復活イベント開始 --EN:--PK revival event started
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 4030, "PlayerKill_4030_1", 2.0, 0, 3, once );
	proxy:NotNetMessage_end();
	
	print("RequestMenuEnd_PK_Sucess end");
end

--（生存・ホワイトがブラックを殺した）PKに成功した時のテキスト演出終了時 --EN:--(Survival/White killed Black) At the end of the text effect when the PK was successful
--ブラック撃破テキスト演出表示後 --EN:--After displaying the black kill text effect
function TextEffectEnd_BlackPK_Success(proxy,param)
	print("TextEffectEnd_BlackPK_Success begin");
	local nDeadPlayerSummonParam = param:GetParam3();
	print("TextEffectEnd_BlackPK_Success nDeadPlayerSummonParam = ", nDeadPlayerSummonParam);
--[[
	if		nDeadPlayerSummonParam == -2 then
		proxy:RecallMenuEvent( 0, 8971 );
	elseif	nDeadPlayerSummonParam == -3 then
		proxy:RecallMenuEvent( 0, 8972 );
	end
]]
	print("TextEffectEnd_BlackPK_Success end");
end



----------------------------------------------------------------------------------------------------------------
--■4032■自分の血文字復活■ --EN:-- ■ 4032 ■ Resurrection of own blood letter ■
----------------------------------------------------------------------------------------------------------------
function SelfBloodMark(proxy, param)
	print("SelfBloodMark begin");
	
	--自分の血文字復活は「再読み込みを通さない」ので初期化スキップのみ --EN:--Your own blood letter revival "cannot be reloaded", so only initialization skip
	--proxy:SetFlagInitState(1);
	
	--システムメッセージ	 --EN:--system message
	proxy:SetTextEffect(TEXT_TYPE_SoulGet);		
	
	--復活するのでペナルティで減少したパラメータを元に戻す(最大値のみ) --EN:--Since it will be revived, restore the parameters that have been reduced by the penalty (maximum value only)
	--proxy:EraseEventSpecialEffect( 10000, 101 );
	--proxy:PlayerParamRecover();
	--proxy:ResetEventQwcSpEffect(LOCAL_PLAYER);	
	--キャラクタのタイプを生存に変更(再読み込みを通さない為、これで仮対応)正規はプレイヤー専用の生存タイプ設定メソッドで対応 --EN:-- Change the character type to survival (temporary correspondence because it does not pass through reloading) Normal is supported by the player-only survival type setting method
	--proxy:SetChrType( 10000, 0 );

	--自分の血文字非表示 --EN:--Hide own blood letters
	proxy:InvalidMyBloodMarkInfo();
	
	--徘徊デーモン復帰用イベントハンドラ --EN:--Event handler for wandering daemon return
	proxy:LuaCallStart( 4032, 100 );
	
	print("SelfBloodMark end");
end


----------------------------------------------------------------------------------------------------------------
--■4033■セッション切れ■ --EN:--■4033■Session expired■
----------------------------------------------------------------------------------------------------------------
function OnIrregularLeaveSession(proxy,param)
	print("OnIrregularLeaveSession begin");

	proxy:NotNetMessage_begin();
		--■4033■0.1秒後(セッション切れタイミングが早い為) --EN:--■4033■0.1 seconds later (because the session expires early)
		proxy:OnKeyTime2( 4033, "OnIrregularLeaveSession_1", 0.1, 0, 1, once );
		--他の再読み込み系イベントの割り込みを防止 --EN:--Prevent interruption of other reloading events
	proxy:NotNetMessage_end();
	
	print("OnIrregularLeaveSession end");
end

function OnIrregularLeaveSession_1(proxy,param)
	print("OnIrregularLeaveSession_1 begin");
	--クライアントで無いなら　シングル　or　ホスト --EN:-- Single or host if not a client
	--if	proxy:IsClient() == false then
	--この時点ではかならずIsClientでfalseが帰る！ --EN:--At this point, IsClient always returns false!
	if proxy:IsLivePlayer() == true or proxy:IsGreyGhost() == true then
		return;
	end
	if proxy:IsCompleteEvent( 4047 ) == true then
		print("EventFlag4047 is true return");
		return;
	end
	--他の再読み込み系イベントの割り込みを防止 --EN:--Prevent interruption of other reloading events
	proxy:SetEventFlag(4047, true);
	--イベント内部にもロード待ちである事を通知 --EN:-- Notify that it is waiting for loading inside the event
	proxy:SetLoadWait();
	--ルームがなくなったログ --EN:--log of missing rooms
	proxy:InfomationMenu( INFOMENU_TYPE_LIST, -1, 0, -1, 1 );
	proxy:AddInfomationTosBuffer( 20001001 );
	
	--イベントフラグロールバック --EN:--eventflag rollback
	proxy:SetFlagInitState(2);
	
	proxy:NotNetMessage_begin();
		--■4046■5秒後 --EN:-- ■ 4046 ■ 5 seconds later
		proxy:OnKeyTime2( 4046, "OnLeave_Limit", 5.0, 0, 2, once );
	proxy:NotNetMessage_end();
	print("OnIrregularLeaveSession_1 end");
end


----------------------------------------------------------------------------------------------------------------
--■4036■SOS位置にワープ■ホワイト召喚位置用 --EN:-- ■ Warp to 4036 ■ SOS position ■ For white summon position
----------------------------------------------------------------------------------------------------------------
function WarpSosPos(proxy,param)
	print("WarpSosPos begin");
	print("WarpSosPos end");
end

----------------------------------------------------------------------------------------------------------------
--■4037■ミニブロックの頭にワープ■ブラック召喚位置用 --EN:-- ■ 4037 ■ Warp to the head of the mini block ■ For black summon position
----------------------------------------------------------------------------------------------------------------
function WarpMiniblockPos(proxy,param)
	print("WarpMiniblockPos begin");
	--強制召喚の場合、ホストのプレイ領域に合わせる --EN:--In the case of forced summoning, match the play area of the host
	if	proxy:IsForceSummoned() == true then
		--proxy:SetHostMiniBlockIndex();
	end
	--proxy:WarpMiniBlock();
	print("WarpMiniblockPos end");
end


function OnServerError_Maintenance(proxy,param)
	print("OnServerError_Maintenance begin");
	if proxy:IsCompleteEvent( 4047 ) == true then
		return;
	end	
	proxy:InfomationMenu(INFOMENU_TYPE_LIST,-1,0,-1,1);
	proxy:AddInfomationTosBufferPlus(51200,MSG_CATEGORY_DIALOG);
	--タイトルに戻る処理 --EN:-- Processing to return to the title
	proxy:WARN("デモンズサーバメンテナンス中"); --EN:proxy:WARN("demons server under maintenance");
	RegistReturnTitle(proxy,param);
	print("OnServerError_Maintenance end");
end

function OnServerError_ServiceStop(proxy,param)
	print("OnServerError_ServiceStop begin");
	if proxy:IsCompleteEvent( 4047 ) == true then
		return;
	end
	proxy:InfomationMenu(INFOMENU_TYPE_LIST,-1,0,-1,1);
	proxy:AddInfomationTosBufferPlus(51201,MSG_CATEGORY_DIALOG);
	--タイトルに戻る処理 --EN:-- Processing to return to the title
	proxy:WARN("デモンズサーバのサービス期間外"); --EN:proxy:WARN("Demon's server is out of service period");
	RegistReturnTitle(proxy,param);
	print("OnServerError_ServiceStop end");
end

function OnServerError_TimeOut(proxy,param)
	print("OnServerError_TimeOut begin");
	if proxy:IsCompleteEvent( 4047 ) == true then
		return;
	end
	proxy:InfomationMenu(INFOMENU_TYPE_LIST,-1,0,-1,1);
	proxy:AddInfomationTosBufferPlus(51300,MSG_CATEGORY_DIALOG);
	--タイトルに戻る処理 --EN:-- Processing to return to the title
	proxy:WARN("サーバからの応答が無い"); --EN:proxy:WARN("No response from server");
	RegistReturnTitle(proxy,param);
	print("OnServerError_TimeOut end");
end

function OnSummonResult_Empty(proxy,param)
	print("OnResultEmpty begin");
	proxy:InfomationMenu(INFOMENU_TYPE_LIST,-1,0,-1,1);
	proxy:AddInfomationTosBuffer(20000105);
	print("OnResultEmpty end");
end

function OnSummonResult_Move(proxy,param)
	print("OnSummonResult_Move begin");
	proxy:InfomationMenu(INFOMENU_TYPE_LIST,-1,0,-1,1);
	proxy:AddInfomationTosBuffer(20000110);
	print("OnSummonResult_Move end");
end

function OnSummonResult_TimeOut(proxy,param)
	print("OnSummonResult_TimeOut begin");
	proxy:InfomationMenu(INFOMENU_TYPE_LIST,-1,0,-1,1);
	proxy:AddInfomationTosBuffer(20000100);
	print("OnSummonResult_TimeOut end");
end

function OnSummonResult_OtherError(proxy,param)
	--ハンドリング無し --EN:--No handling
end

----------------------------------------------------------------------------------------------------------------
--■4038■セッション情報監視■ --EN:--■4038■Session information monitoring■
----------------------------------------------------------------------------------------------------------------
function OnEvent_4038(proxy,param)
	print("OnEvent_4038 begin");
	local info = param:GetParam2();
	
	--SummonResult関連 --EN:--SummonResult related
--~ 	if info == 1 then--既に召喚されている --EN:--already summoned
--~ 		proxy:InfomationMenu(INFOMENU_TYPE_LIST,-1,0,-1,1);
--~ 		proxy:AddInfomationTosBuffer(20000105);
--~ 	elseif info == 2 then--別ブロックに移動している --EN:--moving to another block
--~ 		proxy:InfomationMenu(INFOMENU_TYPE_LIST,-1,0,-1,1);
--~ 		proxy:AddInfomationTosBuffer(20000110);
--~ 	elseif info == 3 then--タイムアウトしている --EN:--timed out
--~ 		proxy:InfomationMenu(INFOMENU_TYPE_LIST,-1,0,-1,1);
--~ 		proxy:AddInfomationTosBuffer(20000100);
--~ 	--elseif info == 4 then--その他で失敗	 --EN:--other fail
--~ 	end
	
	--NetworkError関連 --EN:--NetworkError related
--~ 	if info == 11 then--デモンズサーバメンテナンス中 --EN:--demons server maintenance
--~ 		if proxy:IsCompleteEvent( 4047 ) == true then
--~ 			return;
--~ 		end	
--~ 		proxy:InfomationMenu(INFOMENU_TYPE_LIST,-1,0,-1,1);
--~ 		proxy:AddInfomationTosBufferPlus(51200,MSG_CATEGORY_DIALOG);
--~ 		--タイトルに戻る処理 --EN:-- Processing to return to the title
--~ 		proxy:WARN("デモンズサーバメンテナンス中"); --EN:--~ proxy:WARN("demons server under maintenance");
--~ 		RegistReturnTitle(proxy,param);
--~ 	elseif info == 12 then--デモンズサーバのサービス期間外 --EN:--Out of Demon's server service period
--~ 		if proxy:IsCompleteEvent( 4047 ) == true then
--~ 			return;
--~ 		end
--~ 		proxy:InfomationMenu(INFOMENU_TYPE_LIST,-1,0,-1,1);
--~ 		proxy:AddInfomationTosBufferPlus(51201,MSG_CATEGORY_DIALOG);
--~ 		--タイトルに戻る処理 --EN:-- Processing to return to the title
--~ 		proxy:WARN("デモンズサーバのサービス期間外"); --EN:--~ proxy:WARN("Demon's server is out of service period");
--~ 		RegistReturnTitle(proxy,param);
--~ 	elseif info == 13 then--サーバからの応答が無い（一定回数以上連続でタイムアウト発生） --EN:--There is no response from the server (timeout occurs more than a certain number of times)
--~ 		if proxy:IsCompleteEvent( 4047 ) == true then
--~ 			return;
--~ 		end
--~ 		proxy:InfomationMenu(INFOMENU_TYPE_LIST,-1,0,-1,1);
--~ 		proxy:AddInfomationTosBufferPlus(51300,MSG_CATEGORY_DIALOG);
--~ 		--タイトルに戻る処理 --EN:-- Processing to return to the title
--~ 		proxy:WARN("サーバからの応答が無い"); --EN:--~ proxy:WARN("No response from server");
--~ 		RegistReturnTitle(proxy,param);
--~ 	end
	
	--ForceSummonResult関連 --EN:--ForceSummonResult related
	if	info == 20 then--成功 --EN:--success
		ForceSummonSuccess(proxy,param);
	elseif	info == 21 then--SOSが無い --EN:--No SOS
		ForceSummonFail(proxy,param);
	elseif	info == 22 then--別ブロックへ移動 --EN:--Move to another block
		ForceSummonFail(proxy,param);
	elseif	info == 23 then--タイムアウト --EN:--time out
		ForceSummonFail(proxy,param);
	elseif	info == 24 then--その他で失敗 --EN:--other fail
		ForceSummonFail(proxy,param);
	end
	
	print("OnEvent_4038 end");
end


--強制召喚失敗 --EN:--forced summon failure
function ForceSummonFail(proxy,param)
	print("ForceSummonFail begin");
	if	proxy:IsClient() == false then
		OnEvent_1090(proxy,param);
	end
	
	proxy:DeleteEvent( 1090 );
	proxy:SetEventFlag( 1090, true );
	
	print("ForceSummonFail end");
end

--強制召喚成功 --EN:--Successfully summoned
function ForceSummonSuccess(proxy,param)
	print("ForceSummonSuccess begin");
	print("ForceSummonSuccess end");
end

----------------------------------------------------------------------------------------------------------------
--■4050■ブロッククリア2■正規版 --EN:-- ■ 4050 ■ Block clear 2 ■ regular version
----------------------------------------------------------------------------------------------------------------
function BlockClear2(proxy,param)	
	--自分のみ --EN:--only me
	if param:IsNetMessage() == true then
		return;
	end
	--強制召還にクリアは来ない --EN:--There is no clear for forced summons
	if	proxy:GetTempSummonParam() >   0 then
		return;
	end
--~ 	if proxy:IsCompleteEvent( 4047 ) == true then
--~ 		return;
--~ 	end
--~ 	if proxy:IsCompleteEvent( 4000 ) == true then
--~ 		return;		
--~ 	end
	print("BlockClear2 begin");	
	ClearBossId = -1;
	ClearBossId = param:GetParam2();
	
	--生存orグレイ　どちらも該当無しなら無敵 --EN:-- Survival or Gray Invincible if neither applies
	--if proxy:IsLivePlayer() == false and proxy:IsGreyGhost() == false then
		--完全無敵設定(配信必要だろうか？) --EN:--Completely invincible setting (Is it necessary to stream?)
		--proxy:EnableInvincible( 10000,true);
	--end
	
	--(ホストのために)ホワイト蘇生カウント、QWC加算用のハンドラを呼ぶ --EN:--(for host) call handler for white revive count, QWC addition
	if	proxy:IsWhiteGhost() == true then
		proxy:LuaCallStart( 4055, 1 );
	end
	
	--SOSサインを一度クリア --EN:--clear the SOS sign once
	proxy:ClearSosSign();
	
	--セッション数を記憶 --EN:-- remember number of sessions
	proxy:SetClearSesiionCount();
	
	--ボスゲージをクリア --EN:--clear the boss gauge
	proxy:ClearBossGauge();	

	--ネットワークのロック --EN:--network lock
	proxy:LockSession();
	
	--クリアボーナスを計算 --EN:-- Calculate clear bonus
	proxy:SetClearBonus(ClearBossId);
	
	--生存時 --EN:--Alive
	if proxy:IsLivePlayer() == true then		
		proxy:SetTextEffect(TEXT_TYPE_KillDemon);		
		--他の再読み込み系イベントの割り込みを防止 --EN:--Prevent interruption of other reloading events
		proxy:SetEventFlag(4047, true);		
		--死亡が挟まってややこしくならない様にする --EN:--Don't let death get in the way of complications
		proxy:SetEventFlag( 4000, true );
	--グレイ時 --EN:--Gray time
	elseif proxy:IsGreyGhost() == true then		
		proxy:SetTextEffect(TEXT_TYPE_KillDemon);
		proxy:SetTextEffect(TEXT_TYPE_Revival);
		proxy:SetReviveWait( true );--復活待ち状態フラグを入れておく(グレイで抜けられてしまった時の為) --EN:--Insert a resurrection waiting state flag (for when you get out of the gray)
		--他の再読み込み系イベントの割り込みを防止 --EN:--Prevent interruption of other reloading events
		proxy:SetEventFlag(4047, true);		
		--死亡が挟まってややこしくならない様にする --EN:--Don't let death get in the way of complications
		proxy:SetEventFlag( 4000, true );
		--グレイでこの場で死んだときは生き返れるようにしておく --EN:--If you die here in Gray, make sure you can come back to life
		proxy:SetEventFlag( 4067, true );
	--ホワイトゴースト時 --EN:-- White ghost
	elseif proxy:IsWhiteGhost() == true then
		ClearBoss = true;
		proxy:SetTextEffect(TEXT_TYPE_KillDemon);		
		--他の再読み込み系イベントの割り込みを防止 --EN:--Prevent interruption of other reloading events
		proxy:SetEventFlag(4047, true);
		--イベント内部にもロード待ちである事を通知 --EN:-- Notify that it is waiting for loading inside the event
		proxy:SetLoadWait();		
		--死亡が挟まってややこしくならない様にする --EN:--Don't let death get in the way of complications
		proxy:SetEventFlag( 4000, true );
	--ブラックゴースト時 --EN:--During black ghost
	elseif proxy:IsBlackGhost() == true then
		--自分のプレイヤーIDを配信してゲーム的に抜ける事を通知 --EN:--Distribute your player ID and notify that you are leaving the game
		proxy:CustomLuaCallStart( 4063 , proxy:GetLocalPlayerId() );
		--目標失敗 --EN:--Target failed
		MissionFailed(proxy,param);		
		--他の再読み込み系イベントの割り込みを防止 --EN:--Prevent interruption of other reloading events
		proxy:SetEventFlag(4047, true);
		--イベント内部にもロード待ちである事を通知 --EN:-- Notify that it is waiting for loading inside the event
		proxy:SetLoadWait();		
		--死亡が挟まってややこしくならない様にする --EN:--Don't let death get in the way of complications
		proxy:SetEventFlag( 4000, true );
		--黒が評価に含まれるので先に抜ける --EN:-- Black is included in the evaluation, so exit first
		proxy:LeaveSession();
	end

	--セレクトメニュー抑制開始 --EN:--Select menu suppression start
	if proxy:IsInParty_FriendMember() == true then
		proxy:SetSubMenuBrake( true );		
	end
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 4050, "BlockClear2_1", 5.0, 0, 2, once );
	proxy:NotNetMessage_end();
	
	--自世界アニメ処理	 --EN:--Own world animation processing
	if proxy:IsWhiteGhost() == true or proxy:IsBlackGhost() == true then
		proxy:RepeatMessage_begin();
			proxy:NotNetMessage_begin();
				--アニメ再生の為の自キャラ監視 --EN:--Monitoring your character for animation playback
				proxy:OnRegistFunc( 4050 , "Check_BlockClearAnim","BlockClearAnim",20,once);
			proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();		
	end
	
	print("BlockClear2 end");
end

function BlockClear2_1(proxy,param)
	print("BlockClear2_1 begin");
	
	if proxy:IsInParty_FriendMember() == true then
		--生存時 or --ホワイトゴースト時 or--グレイゴースト時 --EN:--Alive or --White Ghost or--Gray Ghost
		if proxy:IsLivePlayer() == true or proxy:IsWhiteGhost() == true or proxy:IsGreyGhost() == true then		
			--さらにグレイゴーストの時だけ --EN:--Furthermore, only when gray ghost
			if proxy:IsGreyGhost() == true then
				if proxy:IsAlive(10000) == true then
					--めでたく復活 --EN:--Happy revival
					proxy:RevivePlayer();
					proxy:SetReviveWait( false );--復活待ち状態フラグを下ろしておく --EN:--Put down the resurrection waiting state flag
				end
				proxy:SetEventFlag( 15112,true );
				proxy:SetEventFlag( 15113,true );
				proxy:SetEventFlag( 15114,true );
				proxy:SetEventFlag( 15115,true );
				
				proxy:SetEventFlag( 15116,true );
				proxy:SetEventFlag( 15117,true );
				proxy:SetEventFlag( 15118,true );
				proxy:SetEventFlag( 15119,true );	
				--復活するのでペナルティで減少したパラメータを元に戻す(最大値のみ) --EN:--Since it will be revived, restore the parameters that have been reduced by the penalty (maximum value only)
				proxy:EraseEventSpecialEffect( 10000, 101 );
			end
			--友好ゴーストがルームに居たか？　--ホワイトは自分自身が居るから大丈夫なはず。 --EN:--Was there a friendly ghost in the room? --White should be fine because she's there.
			--ホストは他のメンバーを調べる結果になるはず、なので黒だけとPTを組んでいる時はスルーされる	 --EN:--The host should be the result of examining other members, so when you are in a PT with only black, you will be ignored
			--評価メニュー --EN:--Evaluation menu
			proxy:NotNetMessage_begin();
			proxy:RepeatMessage_begin();
				
				proxy:OnPlayerAssessMenu(4050,ClearBossId,"BlockClear2_2",once);
			proxy:RepeatMessage_end();
			proxy:NotNetMessage_end();			
		--ブラックゴースト時 --EN:--During black ghost
		elseif proxy:IsBlackGhost() == true then
			--ソウルペナルティ --EN:--Soul Penalty
			proxy:DeathPenalty( DeathPenalty_SoulAdjust, DeathPenalty_SoulMAX );
			--イベントフラグロールバック --EN:--eventflag rollback
			proxy:SetFlagInitState(2);
			--召喚前の位置設定 --EN:--Position settings before summoning
			proxy:SetSummonedPos();			
			--現在のマップと同じIDを次マップIDとして設定 --EN:--Set the same ID as the current map as the next map ID
			proxy:SetDefaultMapUid(-1);
			--ワープを行う --EN:--do warp
			proxy:WarpNextStageKick();
			--グレイゴースト化 --EN:--Gray ghost
			--proxy:SetChrTypeDataGrey();
			proxy:SetChrTypeDataGreyNext();
		end		
	else
		if proxy:IsLivePlayer() == true then
			proxy:NotNetMessage_begin();
				proxy:OnKeyTime2( 4050, "SoloBlockClear", 3.0, 0, 6, once );
			proxy:NotNetMessage_end();			
		--グレイ時 --EN:--Gray time
		elseif proxy:IsGreyGhost() == true then
			if proxy:IsAlive( 10000 ) == true then
				--めでたく復活 --EN:--Happy revival
				proxy:RevivePlayer();
				proxy:SetReviveWait( false );--復活待ち状態フラグを下ろしておく --EN:--Put down the resurrection waiting state flag
			end
			proxy:SetEventFlag( 15112,true );
			proxy:SetEventFlag( 15113,true );
			proxy:SetEventFlag( 15114,true );
			proxy:SetEventFlag( 15115,true );
			
			proxy:SetEventFlag( 15116,true );
			proxy:SetEventFlag( 15117,true );
			proxy:SetEventFlag( 15118,true );
			proxy:SetEventFlag( 15119,true );
			
			--復活するのでペナルティで減少したパラメータを元に戻す(最大値のみ) --EN:--Since it will be revived, restore the parameters that have been reduced by the penalty (maximum value only)
			proxy:EraseEventSpecialEffect( 10000, 101 );
			proxy:NotNetMessage_begin();
				proxy:OnKeyTime2( 4050, "SoloBlockClear", 6.0, 0, 6, once );
			proxy:NotNetMessage_end();					
		--ホワイトゴースト時 --EN:-- White ghost
		elseif proxy:IsWhiteGhost() == true then
			--偽ボーナスの取得 --EN:--get fake bonus
			proxy:GetClearBonus(ClearBossId);
			--世界に帰る --EN:--Return to the world
			proxy:NotNetMessage_begin();		
				proxy:OnKeyTime2(4050,"BlockClear2_3",CLEAR_TIMEOUT,0,0,once);
			proxy:NotNetMessage_end();
		--ブラックゴースト時 --EN:--During black ghost
		elseif proxy:IsBlackGhost() == true then
			--ソウルペナルティ --EN:--Soul Penalty
			proxy:DeathPenalty( DeathPenalty_SoulAdjust, DeathPenalty_SoulMAX );			
			--イベントフラグロールバック --EN:--eventflag rollback
			proxy:SetFlagInitState(2);			
			--召喚前の位置設定 --EN:--Position settings before summoning
			proxy:SetSummonedPos();			
			--現在のマップと同じIDを次マップIDとして設定 --EN:--Set the same ID as the current map as the next map ID
			proxy:SetDefaultMapUid(-1);			
			--ワープを行う --EN:--do warp
			proxy:WarpNextStageKick();			
			--グレイゴースト化 --EN:--Gray ghost
			--proxy:SetChrTypeDataGrey();
			proxy:SetChrTypeDataGreyNext();
		end
	end
	print("BlockClear2_1 end");
end

--プレイヤー評価メニュー終了のウェイト --EN:--Wait for exiting player evaluation menu
function BlockClear2_2(proxy,param)
	print("BlockClear2_2 begin");
	if proxy:IsWhiteGhost() == true then
		--自分のプレイヤーIDを配信してゲーム的に抜ける事を通知 --EN:--Distribute your player ID and notify that you are leaving the game
		proxy:CustomLuaCallStart( 4063 , proxy:GetLocalPlayerId() );
	end
		
	--完全無敵を排除 --EN:-- Eliminate complete invincibility
	--proxy:EnableInvincible(10000,false);
	proxy:NotNetMessage_begin();		
		proxy:OnKeyTime2(4050,"BlockClear2_3",CLEAR_TIMEOUT,0,0,once);
		proxy:OnKeyTime2(4050,"BlockClear2_3Leave",2.0,0,3,once);
	proxy:NotNetMessage_end();
	
	MissionSuccessed(proxy,param);
	print("BlockClear2_2 end");
end

--解散処理 --EN:-- Dissolution process
function BlockClear2_3Leave(proxy,param)
	print("BlockClear2_3Leave begin");
		proxy:LeaveSession();		
	print("BlockClear2_3Leave end");
end

--自世界に帰る処理 --EN:--Processing to return to own world
function BlockClear2_3(proxy,param)
	--メニュー抑制解除 --EN:--Release menu suppression
	proxy:SetSubMenuBrake( false );
	
	--生存時 --EN:--Alive
	if proxy:IsLivePlayer() == true or proxy:IsGreyGhost() == true then	
		--他の再読み込み系イベントの割り込みを開始 --EN:--Start interrupting other reloading events
		proxy:SetEventFlag(4047, false);		
		--死亡可能 --EN:--Can die
		proxy:SetEventFlag( 4000, false );
		if proxy:IsAlive(10000) == true then
			proxy:SetEventFlag( 4067, false );
		end
	end
	
	if proxy:IsWhiteGhost() == true then	
		--復活するので復活アニメフラグをセット --EN:-- Set the resurrection animation flag because it will be revived
		proxy:SetAliveMotion( true );
	
		--イベントフラグロールバック --EN:--eventflag rollback
		proxy:SetFlagInitState(2);	
		
		--復活するのでペナルティで減少したパラメータを元に戻す(最大値のみ) --EN:--Since it will be revived, restore the parameters that have been reduced by the penalty (maximum value only)
		proxy:EraseEventSpecialEffect( 10000, 101 );
		
		--完全回復要求 --EN:-- full recovery request
		proxy:RequestFullRecover();
		
		--生存状態に設定した上で、自分の血文字位置へワープ --EN:--Warp to your blood letter position after setting it to a living state
		--proxy:WarpSelfBloodMark(false);
		proxy:SetSelfBloodMapUid();
		--proxy:RevivePlayer();
		proxy:RevivePlayerNext();--次のロードで蘇生 --EN:--Respawn on next load
		proxy:WarpNextStageKick();
	end
	
end

function SoloBlockClear(proxy,param)
	print("SoloBlockClear begin");
	--万が一評価メニューを出す前にルーム解体した時用 --EN:--For when the room is dismantled before the evaluation menu is released
	proxy:SetSubMenuBrake( false );
	proxy:GetSoloClearBonus(ClearBossId);
		
	--他の再読み込み系イベントの割り込みを開始 --EN:--Start interrupting other reloading events
	proxy:SetEventFlag(4047, false);		
	--死亡可能 --EN:--Can die
	proxy:SetEventFlag( 4000, false );	
	if proxy:IsAlive(10000) == true then
		proxy:SetEventFlag( 4067, false );
	end
	--念の為ルーム解体 --EN:-- just in case room dismantling
	proxy:LeaveSession();
	print("SoloBlockClear end");
end


--■4050■アニメ再生待ち■ --EN:-- ■ 4050 ■ Waiting for animation playback ■
function Check_BlockClearAnim(proxy,param)
	--イベントアニメ再生中か？ --EN:--Is the event animation playing?
	if proxy:IsEventAnim(10000,8289) == false then
		--自キャラのアニメ再生に挑戦 --EN:--Challenge to play animation of own character
		proxy:PlayAnimation(10000,8289);
		return false;
	else
		--イベントアニメ再生中なので、成立とする --EN:--Since the event animation is being played, it is assumed to be established.
		return true;
	end
end

--■4050■ブロッククリアアニメ■ --EN:-- ■ 4050 ■ Block clear animation ■
function BlockClearAnim(proxy,param)
	print("BlockClearAnim begin");
	--自世界アニメの同期 --EN:-- Synchronization of own world animation
	proxy:LuaCallStart(4050,20);
	proxy:StopPlayer();
	print("BlockClearAnim end");
end

--■4050■ブロッククリア同期アニメ■ --EN:-- ■ 4050 ■ Block clear synchronization animation ■
function BlockClearSynchroAnime(proxy,param)
	print("BlockClearSynchroAnime begin");
	if param:IsNetMessage() == true then
		proxy:PlayAnimation(param:GetPlayID()+10001 , 8289);--アニメ再生 --EN:--animation playback
		proxy:EnableLogic(param:GetPlayID()+10001,false);--操作不能 --EN:-- Inoperable
		return;
	end
	
	--[[--自世界アニメ再生部分は特殊なので、自キャラの再生分は保留とする]] --EN:--The replay part of your own world animation is special, so the replay of your character will be put on hold]]
	--自キャラはアニメ監視を追加する --EN:--Your character adds anime monitoring
	proxy:NotNetMessage_begin();
	proxy:RepeatMessage_begin();
		proxy:OnChrAnimEnd( 4050 , 10000 , 8289 , "BlockClearAnim_1",once);
	proxy:RepeatMessage_end();
	proxy:NotNetMessage_end();
	print("BlockClearSynchroAnime end");
end

--■4050■アニメ監視■ --EN:-- ■ 4050 ■ Animation monitoring ■
function BlockClearAnim_1(proxy,param)
	print("BlockClearAnim_1 begin");
	--無効化の同期 --EN:--invalidation synchronization
	proxy:LuaCallStart(4050,30);
	print("BlockClearAnim_1 end");
end

--■4050■無効化同期■ --EN:-- ■ 4050 ■ Invalidation Synchronization ■
function BlockClearSynchroInvalid(proxy,param)
	print("BlockClearSynchroInvalid begin");
	if param:IsNetMessage() == true then
		--ネットワークIDで無効化 --EN:--Disable by Network ID
		InvalidCharactor( proxy , param:GetPlayID() + 10001 );
		return;
	else
		--自キャラ無効化 --EN:--Invalidate own character
		--InvalidCharactor( proxy , 10000 );
		--表示OFF --EN:--Display OFF
		proxy:SetDrawEnable( 10000 , false );
	end
	
	print("BlockClearSynchroInvalid end");
end







--■4001■アクション中断■ --EN:-- ■ 4001 ■ Action interrupted ■
function OnEvent_4001(proxy, param)
	if param:IsNetMessage() == true then
		return;
	end
	--print("OnEvent_4001 begin");
	--アクションを中断する（初期化） --EN:-- interrupt the action (initialization)
	proxy:ActionEnd(10000);
	--print("OnEvent_4001 end");
end


--■4002■垂直梯子中　上入力■ --EN:-- ■ 4002 ■ Vertical ladder middle upper input ■
function OnEvent_4002(proxy, param)
	if param:IsNetMessage() == true then
		return;
	end
	--print("OnEvent_4002 begin");

	if proxy:IsAction(10000,0) == false then
	--イベントコマンドID(2)"ハシゴ昇った"を送る --EN:-- Send event command ID (2) "Ladder climbed"
		proxy:SetEventCommand(10000,2);

	else
	--イベントコマンドID(2)"ハシゴ昇り終えた"を送る --EN:-- Send event command ID (2) "finished climbing ladder"
		proxy:SetEventCommand(10000,4);

	end
--print("OnEvent_4002 end");
end

--■4003■垂直梯子中　下入力■ --EN:-- ■ 4003 ■ Vertical ladder middle bottom input ■
function OnEvent_4003(proxy, param)
	if param:IsNetMessage() == true then
		return;
	end
	--print("OnEvent_4003 begin");

	if proxy:IsAction(10000,1) == false then
	--イベントコマンドID(2)"ハシゴ降りた"を送る --EN:--Send event command ID (2) "Ladder descended"
		proxy:SetEventCommand(10000,3);

	else

	--イベントコマンドID(2)"ハシゴ降り終えた"を送る --EN:-- Send event command ID (2) "Ladder finished"
		proxy:SetEventCommand(10000,5);
	end
	--print("OnEvent_4003 end");
end

--■4006■ハシゴ中 アクションボタン入力■ --EN:-- ■ 4006 ■ Ladder mid-action button input ■
function OnEvent_4006(proxy,param)
	print("OnEvent_4006 begin");
	print("OnEvent_4006 end");
end


--■4004■垂直梯子　1段上昇終了■ --EN:-- ■ 4004 ■ Vertical ladder 1 step up completed ■
function OnEvent_4004(proxy, param)
	if param:IsNetMessage() == true then
		return;
	end
	print("OnEvent_4004 begin");
	--アクションカウントを加算、行動回数オーバー時は"ハシゴ昇り終えた"を送る --EN:--Increase the action count, send "Ladder finished" when the number of actions is exceeded
	proxy:AddActionCount(10000,4);
	--	proxy:CamReset(10000,1);
	print("OnEvent_4004 end");
end

--■4005■垂直梯子　1段下降終了■ --EN:-- ■ 4005 ■ Vertical ladder 1 step down completed ■
function OnEvent_4005(proxy, param)
	if param:IsNetMessage() == true then
		return;
	end
	print("OnEvent_4005 begin");
	--アクションカウントを減算、行動回数を下回った時は"ハシゴ下り終えた"を送る --EN:--Subtract the action count, and send "Ladder finished" when the number of actions is less than the number of actions
	proxy:SubActionCount(10000,5);
	--	proxy:CamReset(10000,1);
	print("OnEvent_4005 end");
end

--■ID不問■メニューの表示を抑制する：sec関数で制御される■ --EN:--■ ID is not required ■ Suppress menu display: Controlled by sec function ■
function EventMenuBrake(proxy, param)
	if param:IsNetMessage() == true then
		return;
	end
	--メニューを閉じる --EN:--close menu
	--print("Call EventMenuClose");
	proxy:CloseMenu();
	--メニュー抑制を呼ぶ --EN:--call menu suppression
	--print("Call EventMenuBrake");
	proxy:SetMenuBrake();
end

--■ID不問■メニュー強制終了■ --EN:-- ■ ID is not required ■ Menu forced termination ■
function EventMenuClose(proxy, param)
	if param:IsNetMessage() == true then
		return;
	end
	--print("Call EventMenuClose");
	--メニューを閉じる --EN:--close menu
	proxy:CloseMenu();
end

--■ID不問■ハシゴ降り用秒間イベント※現状3秒呼ぶこと --EN:-- ■ No ID required ■ Second-second event for descending the ladder *Currently called for 3 seconds
function LadderDown(proxy,param)
	--print("Event_LadderDown begin");
	proxy:CloseMenu();
	proxy:SetMenuBrake();
	--proxy:CamReset(10000,1);
	--print("Event_LadderDown end");
end


--■汎用会話用共通ID■汎用会話を登録する記述量を減らす(結局ハンドラ分は増える) --EN:--■ Common ID for general-purpose conversations ■ Reduce the amount of description to register general-purpose conversations (In the end, the number of handlers will increase)
function OnTalk(proxy,EventID,TargetID,Dist,Ang,ValueBuffer,HelpID,func1,func2,func3,bOnce)

	--■EventID■NPC汎用会話■--PCがイベントIDからDistの距離に入っている時	 --EN:--■EventID■NPC General Conversation■--When the PC is within Dist distance from the event ID
	proxy:OnTalkEventDistIn(EventID,TargetID,func2,Dist,bOnce );
	
	--■EventID■NPC汎用会話■--PCがイベントIDからDistの距離に入った後出たとき	 --EN:-- ■ EventID ■ NPC General Conversation ■ -- When the PC exits after entering the distance of Dist from the event ID
	proxy:OnTalkEventDistOut(EventID,TargetID,func3,Dist,bOnce );
	
	--■EventID■NPC汎用会話■--PCがイベントIDからDistに入って反応角度以内でアクションボタンを押した時	 --EN:--■EventID■NPC General Conversation■--When the PC enters the Dist from the event ID and presses the action button within the reaction angle
	proxy:OnTalkEvent(EventID,TargetID,func1, Dist, HelpID, Ang ,ValueBuffer,bOnce );
end

function OnUpDate(proxy,nEventID,nEventID2,nRegionID,func,func1)
	proxy:OnRegionIn(nEventID,10000,nRegionID,func,everytime);
	proxy:OnRegionJustOut(nEventID2,10000,nRegionID,func1,everytime);
end


function SetDisable(proxy,nChrID,bFlag)
	proxy:ChrDisableUpDate(nChrID,bFlag);	
end


--■Lua定義関数■同期されたアニメーション再生■ --EN:-- ■ Lua definition function ■ Synchronized animation playback ■
--値を別に定義したくなかったので、 --EN:-- I didn't want to define the value separately, so
--true : パーティーのプレイヤーがアニメーションした --EN:--true : party player animated
--false: 自分がアニメーションした と定義。 --EN:--false: Defined as animated by me.
function Luafunc_PlaySynchroAnimation(proxy,param,nAnimeID)
	print("Luafunc_PlaySynchroAnimation begin");
	
	--パーティーのプレイヤーがアニメーション --EN:--Party players animated
	if param:IsNetMessage() == true then 
		proxy:PlayAnimation( param:GetPlayID()+10001 , nAnimeID );
		print("Luafunc_PlaySynchroAnimation return true");
		return true;
	end
	--自分がアニメーション --EN:--animated by me
	proxy:PlayAnimation( 10000 , nAnimeID );
	print("Luafunc_PlaySynchroAnimation return false");
	return false;
end


--■4010■アニメーションの同期用関数(宝死体用)■ --EN:-- ■ 4010 ■ Synchronization function for animation (for treasure corpse) ■
function OnEvent_4010(proxy , param )
	print("OnEvent_4010 begin");
	
	--プレイヤーの同期アニメーション(true:パーティープレイヤーがアニメーションした) --EN:--Player synchronous animation (true: party player animated)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_PICK ) == true then
		print("return true ");
		print("OnEvent_4010 end");
		return true;
	end
	
	print("return false ");
	print("OnEvent_4010 end");
	return false;
end


--■4012■アニメーションの同期用関数■ --EN:-- ■ 4012 ■ Synchronization function for animation ■
function OnEvent_4012(proxy , param )
	print("OnEvent_4012 begin");
	
	--プレイヤーの同期アニメーション(true:パーティープレイヤーがアニメーションした) --EN:--Player synchronous animation (true: party player animated)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_WALK ) == true then
		return;
	end
	
	print("OnEvent_4012 end" );
end

--■4013■アニメーションの同期用関数■ --EN:-- ■ 4013 ■ Synchronization function for animation ■
function OnEvent_4013(proxy,param)
	print("OnEvent_4013 begin");
	--プレイヤーの同期アニメーション(true:パーティープレイヤーがアニメーションした) --EN:--Player synchronous animation (true: party player animated)
	if Luafunc_PlaySynchroAnimation( proxy, param, param:GetParam3() ) == true then
		print("return true ");
		print("OnEvent_4013 end");
		return true;
	end
	
	print("return false ");
	print("OnEvent_4013 end");
	return false;
end

--■4013■同期アニメ再生■ --EN:-- ■ 4013 ■ Synchronized animation playback ■
--(注意：これを使用すると、1つのアニメ再生にパケット1つ分の負担になるので、 --EN:--(Caution: If you use this, it will cost one packet to play one animation, so
--短期間で何度も呼ばれるような場所では使用を控える) --EN:--Avoid using it in places where it will be called many times in a short period of time.)
--それなりの回数呼ばれることを想定してログはきっておく --EN:-- Keep the log assuming that it will be called a certain number of times
function SynchroAnim_4013(proxy,param)
	print("SynchroAnim_4013 begin");
	local targetId = param:GetParam2();
	local animId   = param:GetParam3();
	print("Target :",targetId," animId :",animId);
	--プレイヤなら --EN:--If you are a player
	if	targetId >= LOCAL_PLAYER then
		Luafunc_PlaySynchroAnimation( proxy, param, animId );
	else
		proxy:PlayAnimation( targetId, animId );
	end
	--print("SynchroAnim_4013 end");
end


--[[
--------------------------------------------------------------------------------------
--壁はりつきイベント■ --EN:--Wall clinging event■
--------------------------------------------------------------------------------------

--■4020■壁張り付き　右入力■ --EN:-- ■ 4020 ■ with wall attachment Right input ■
function OnEvent_4020(proxy, param)
	if param:IsNetMessage() == true then
		return;
	end
	print("OnEvent_4020 begin");

	if proxy:IsAction(10000,0) == false then
	--イベントコマンドID(22)"右に1歩進んだ"を送る --EN:--Send event command ID (22) "one step to the right"
		proxy:SetEventCommand(10000,22);

	else
	--イベントコマンドID(24)"右に渡り終えた"を送る --EN:-- Send event command ID (24) "Finished crossing to the right"
		proxy:SetEventCommand(10000,24);

	end
print("OnEvent_4020 end");
end

--■4021■壁張り付き 左入力■ --EN:-- ■ 4021 ■ left input with wall mounting ■
function OnEvent_4021(proxy, param)
	if param:IsNetMessage() == true then
		return;
	end
	print("OnEvent_4021 begin");

	if proxy:IsAction(10000,1) == false then
	--イベントコマンドID(23)"左に進んだ"を送る --EN:-- Send event command ID (23) "Go left"
		proxy:SetEventCommand(10000,23);

	else

	--イベントコマンドID(25)"左に渡り終えた"を送る --EN:--Send Event Command ID (25) "Finished crossing to the left"
		proxy:SetEventCommand(10000,25);
	end
	print("OnEvent_4021 end");
end

--■4022■壁張り付き　右一歩移動終了■ --EN:--■ 4022 ■ Attached to the wall Finish moving one step to the right ■
function OnEvent_4022(proxy, param)
	if param:IsNetMessage() == true then
		return;
	end
	print("OnEvent_4022 begin");
	--アクションカウントを加算、行動回数オーバー時は"右に渡り終えた"を送る --EN:--Increase the action count, and when the number of actions is exceeded, send "Right crossing finished"
	proxy:AddActionCount(10000,24);	
	print("OnEvent_4022 end");
end

--■4023■壁張り付き　左一歩移動終了■ --EN:--■ 4023 ■ Attached to the wall Finished moving one step to the left ■
function OnEvent_4023(proxy, param)
	if param:IsNetMessage() == true then
		return;
	end
	print("OnEvent_4023 begin");
	--アクションカウントを減算、行動回数を下回った時は"左に渡り終えた"を送る --EN:--Subtract the action count, and send "crossed to the left" when the number of actions is less than
	proxy:SubActionCount(10000,25);	
	print("OnEvent_4023 end");
end
]]


--------------------------------------------------------------------------------------
--■徘徊デーモンの出現制御用 --EN:--■ To control the appearance of the wandering demon
--------------------------------------------------------------------------------------

--▼徘徊デーモンを表示 --EN:--▼ show the prowling daemon
function LuaFunc_VisibleTheWanderingDemon(proxy, param, demon_id_list)
	print("VisibleTheWanderingDemon begin");
	
	local demon_num = table.getn( demon_id_list );
	local i =0;
	for i=1 , demon_num , 1 do
		ValidCharactor( proxy , demon_id_list[i] );
	end

	print("VisibleTheWanderingDemon end");
end

--▼徘徊デーモンを非表示 --EN:--▼Hide the prowling daemon
function LuaFunc_InvisibleTheWanderingDemon(proxy, param, demon_id_list)
	print("InvisibleTheWanderingDemon begin");
	
	local demon_num = table.getn( demon_id_list );
	local i=0;
	for i=1 , demon_num , 1 do
		InvalidCharactor( proxy , demon_id_list[i] );
	end

	print("InvisibleTheWanderingDemon end");
end

--▼徘徊デーモンの表示･非表示判定用(エリア読み込み時の初期化関数で呼ぶ) --EN:--▼ For judging display/non-display of the wandering daemon (called by the initialization function when reading the area)
function LuaFunc_WanderingDemonJudge( proxy , param , demon_id_list )

	if proxy:GetLocalPlayerChrType() == CHR_TYPE_GreyGhost then 
		LuaFunc_VisibleTheWanderingDemon( proxy, param, demon_id_list );
	else
		LuaFunc_InvisibleTheWanderingDemon( proxy, param, demon_id_list );
	end
	
end


--------------------------------------------------------------------------------------
--■スーパーアーマー有効化/無効化 --EN:--■ Enable/Disable Super Armor
--------------------------------------------------------------------------------------

--▼スーパーアーマー有効化 --EN:--▼ Enable Super Armor
function OnEvent_4015(proxy, param)
	local set_id = 10000;
	
	if param:IsNetMessage() == true then
		set_id = 10001 + param:GetPlayID();
	end
	proxy:SetSuperArmor( set_id , true );
end

--▼スーパーアーマー無効化 --EN:--▼ Disable Super Armor
function OnEvent_4016(proxy, param)
	local set_id = 10000;
	
	if param:IsNetMessage() == true then
		set_id = 10001 + param:GetPlayID();
	end

	proxy:SetSuperArmor( set_id , false );
end


--------------------------------------------------------------------------------------
--■完全無敵 有効化/無効化 --EN:-- Complete Invincibility enable/disable
--------------------------------------------------------------------------------------

--▼完全無敵有効化 --EN:--▼ Enable complete invincibility
function OnEvent_4017(proxy, param)
	local set_id = 10000;
	
	if param:IsNetMessage() == true then
		set_id = 10001 + param:GetPlayID();
	end
	
	proxy:EnableInvincible( set_id , true );
end

--▼完全無敵無効化 --EN:--▼Complete invincibility disabled
function OnEvent_4018(proxy, param)
	local set_id = 10000;
	
	if param:IsNetMessage() == true then
		set_id = 10001 + param:GetPlayID();
	end

	proxy:EnableInvincible( set_id , false );
end

--------------------------------------------------------------------------------------
--■アタリ同期 --EN:-- ■Atari synchronization
--------------------------------------------------------------------------------------
function OnEvent_4019(proxy,param)
	local set_id = 10000;
	
	if param:IsNetMessage() == true then
		set_id = 10001 + param:GetPlayID();
	end
	--マップへの当たり有効化 --EN:--Hit on map enabled
	proxy:DisableMapHit( set_id , false );
	proxy:SetDisableGravity( set_id , false );
	
	--旋回など有効 --EN:--Valid for turning
	proxy:DisableMove( set_id , false );
end


--[[
	イベント領域への移動関数　…☆MoveRegion	 --EN:Function to move to the event area ...☆MoveRegion
	proxy		…イベントプロキシ --EN:proxy … event proxy
	targetid	…移動させたいターゲット --EN:targetid … the target you want to move
	regionid	…領域ID --EN:regionid … region ID
	ftime		…移動状態にかけたい時間　　-1無制限 --EN:ftime ... The time you want to spend in the moving state -1 Unlimited
	frad		…判定半径					基本0.0でOK --EN:frad … Judgment radius Basic 0.0 is OK
	movetype	…歩きか走りか				trueが歩き --EN:movetype … walk or run true is walk
]]
function MoveRegion(proxy, targetid, regionid, ftime ,frad,movetype)
	--AIにイベントポイントを記憶 --EN:-- Memorize event points in AI
	proxy:SetMovePoint(targetid,regionid,frad);
	--AIにイベント命令を発行(移動)  --EN:-- Issue an event command to AI (move)
	proxy:AddEventGoal(targetid, GOAL_COMMON_MoveToSomewhere, ftime, POINT_EVENT, AI_DIR_TYPE_CENTER, frad, TARGET_SELF, movetype,0,0,0);	
end

--[[
	イベント領域への移動関数　…☆MoveRegion	 --EN:Function to move to the event area ...☆MoveRegion
	proxy		…イベントプロキシ --EN:proxy … event proxy
	targetid	…移動させたいターゲット --EN:targetid … the target you want to move
	regionid	…領域ID --EN:regionid … region ID
	ftime		…移動状態にかけたい時間　　-1無制限 --EN:ftime ... The time you want to spend in the moving state -1 Unlimited
	frad		…判定半径					基本0.0でOK --EN:frad … Judgment radius Basic 0.0 is OK
	movetype	…歩きか走りか				trueが歩き --EN:movetype … walk or run true is walk
]]
function MoveRegion2(proxy, targetid, regionid, ftime ,frad,movetype)
	--AIにイベントポイントを記憶 --EN:-- Memorize event points in AI
	proxy:SetMovePoint(targetid,regionid,frad);
	--AIにイベント命令を発行(移動)  --EN:-- Issue an event command to AI (move)
	proxy:AddEventGoal(targetid, GOAL_COMMON_MoveToSomewhere, ftime, POINT_EVENT, AI_DIR_TYPE_CENTER, frad, TARGET_ENE_0, movetype,0,0,0);	
end

--[[
	ターゲット(キャラ)への旋回関数　…☆TurnTarget	 --EN:Turn function to the target (character)...☆TurnTarget
	使用上の注意：イベントターゲットを利用しているので、 --EN:Usage note: Since we are using event targets,
	　　　　　　　イベントターゲットがらみのイベントで使う場合、 --EN:　　　　　　　When used in an event related to the event target,
	　　　　　　　動作が保障できません。 --EN:Operation cannot be guaranteed.
				　その場合はポイント指定のTurn関数を新たにを用意するなど、 --EN:In that case, prepare a new Turn function that specifies the point, etc.
				　別の対応を考えた方が良いと思います。 --EN:"I think it would be better to consider another response."
	proxy			…イベントプロキシ --EN:proxy … event proxy
	targetid		…旋回させたいさせたいターゲット(イベントID指定) --EN:targetid …Target you want to turn (specify event ID)
	goal_target_id	…旋回したい方向のターゲット(イベントID指定) --EN:goal_target_id … Target in the direction you want to turn (event ID specified)
	ftime			…移動状態にかけたい時間　　-1無制限 --EN:ftime ... The time you want to spend in the moving state -1 Unlimited
]]
function TurnTarget(proxy, targetid, goal_target_id, ftime )
	--引数の全パラメータを確認できるので、ログで確認したい時はどうぞ --EN:-- You can check all the parameters of the argument, so if you want to check it in the log, please
	--print("TurnTarget targetid = ", targetid, ", goal_target_id = ", goal_target_id, ", ftime = ", ftime);
	
	--イベントターゲットを設定 --EN:--set event target
	proxy:SetEventTarget( targetid, goal_target_id );
	--AIにイベントターゲットに振り向くようにイベント命令を発行(旋回) --EN:--Issue an event command to turn the AI to the event target (turn)
	proxy:AddEventGoal(targetid, GOAL_COMMON_Turn, ftime, TARGET_EVENT, 0,0,0,0,0,0,0);
end

--[[
	ターゲット(キャラ)への旋回関数　…☆TurnTarget	 --EN:Turn function to the target (character)...☆TurnTarget
	使用上の注意：イベントターゲットを利用しているので、 --EN:Usage note: Since we are using event targets,
	　　　　　　　イベントターゲットがらみのイベントで使う場合、 --EN:　　　　　　　When used in an event related to the event target,
	　　　　　　　動作が保障できません。 --EN:Operation cannot be guaranteed.
				　その場合はポイント指定のTurn関数を新たにを用意するなど、 --EN:In that case, prepare a new Turn function that specifies the point, etc.
				　別の対応を考えた方が良いと思います。 --EN:"I think it would be better to consider another response."
	proxy			…イベントプロキシ --EN:proxy … event proxy
	targetid		…旋回させたいさせたいターゲット(イベントID指定) --EN:targetid …Target you want to turn (specify event ID)
	goal_target_id	…旋回したい方向のターゲット(イベントID指定) --EN:goal_target_id … Target in the direction you want to turn (event ID specified)
	ftime			…移動状態にかけたい時間　　-1無制限 --EN:ftime ... The time you want to spend in the moving state -1 Unlimited
]]
function TurnTarget2(proxy, targetid, goal_target_id, ftime )
	--引数の全パラメータを確認できるので、ログで確認したい時はどうぞ --EN:-- You can check all the parameters of the argument, so if you want to check it in the log, please
	--print("TurnTarget targetid = ", targetid, ", goal_target_id = ", goal_target_id, ", ftime = ", ftime);
	
	--イベントターゲットを設定 --EN:--set event target
	proxy:SetMovePoint(targetid,goal_target_id,0.0);
	--AIにイベントターゲットに振り向くようにイベント命令を発行(旋回) --EN:--Issue an event command to turn the AI to the event target (turn)
	--proxy:AddEventGoal(targetid, GOAL_COMMON_Turn, ftime, TARGET_EVENT, 0,0,0,0,0,0,0);
end

--[[
	指定ターゲットの右手武器を切り替えます --EN:Toggles right-hand weapon for specified target
	何度も呼ばないで下さい。正直サツキ専用ですが正常動作するかはわからないです。 --EN:Please don't call me again. To be honest, it is exclusive to Satsuki, but I don't know if it will work properly.
]]
function TargetChangeWepR2(proxy,targetid)
	proxy:AddEventGoal(targetid, GOAL_COMMON_Attack, 10.0, NPC_ATK_ChangeWep_R2,TARGET_ENE_0, DIST_None,0,0,0,0,0);
end



--キャラクタ無効化 --EN:--disable character
function InvalidCharactor(proxy, eventId)
	proxy:SetDisable( eventId, true );
	proxy:CharacterAllAttachSys(eventId);
end

--キャラクタ有効化 --EN:--Character enable
function ValidCharactor(proxy, eventId)
	proxy:SetDisable( eventId, false );
end

--バックリードキャラクタを無効化 --EN:--disable backread characters
function InvalidBackRead(proxy,eventId)
	proxy:SetDisable( eventId, true );--無効設定 --EN:--Disable setting
	proxy:SetDisableBackread_forEvent( eventId, true );--バックリード無効化 --EN:--disable back read
end

--バックリードキャラクタを有効化 --EN:--enable back read characters
function ValidBackRead(proxy,eventId)
	proxy:SetDisable( eventId, false );--有効設定 --EN:--Enable setting
	proxy:SetDisableBackread_forEvent( eventId, false );--バックリード有効化 --EN:--enable back read
end


--[[インフォメーションメニュー表示用]] --EN:--[[For information menu display]]
--[[引数全部指定]] --EN:--[[Specify all arguments]]
--[[
	proxy 	          … イベントプロクシ --EN:proxy … event proxy
	type  	       	  … 0:通常(複数行) 1:簡易(1行) --EN:type … 0: normal (multiple lines) 1: simple (single line)
	title_icon_id  	  … タイトルメッセージのアイコンID --EN:title_icon_id … Title message icon ID
	title_category_id … タイトルメッセージのカテゴリーID(30がイベント用カテゴリー) --EN:title_category_id … Category ID of the title message (30 is the event category)
	title_msg_id      … タイトルメッセージのメッセージID --EN:title_msg_id … Message ID of title message
	sys_msg_id        … 0でダイアログ表示 --EN:Display dialog with sys_msg_id … 0
	icon_list         … 行ごとにアイコンを指定する場合に指定(リストで渡されて、最初の一つがデフォルトになる) --EN:icon_list … Specified when specifying an icon for each line (passed in a list, the first one is the default)
	category_list     … メッセージのカテゴリーID(リストで渡されて、最初の一つがデフォルトになる) --EN:category_list … the category id of the message (passed in list, defaults to first one)
	msg_list    　　　… メッセージIDを個別に指定(リストで渡されて、最初の一つがデフォルトになる) --EN:msg_list … Specify message IDs individually (passed in a list, the first one is the default)
	msg_num           … メッセージの行数(なくても良いかもしれない･･･) --EN:msg_num … Number of lines in the message (may not be necessary...)
]]

function Display_InfomationMenu
(proxy, type, title_icon_id, title_category_id, title_msg_id, sys_msg_id, icon_list, category_list, msg_list, msg_num)
	print( "Display_InfomationMenu begin" );
	
	--インフォメーションメニュー表示 --EN:--Information menu display
	proxy:InfomationMenu( type , title_icon_id , title_category_id , title_msg_id , sys_msg_id );
	
	--メッセージなどの数が合わないときはデフォルトの値で代用する --EN:--If the number of messages, etc. does not match, substitute the default value
	--(リストには値が１個以上入っていること前提で、１番最初のをデフォルトにする) --EN:--(Assuming that the list contains one or more values, the first is the default)
	
	local default_icon_id     = icon_list[1];
	local default_category_id = category_list[1];
	local default_msg_id      = msg_list[1];
	
	if type == 0 then -- 通常メニュー --EN:-- Normal menu
		local i=1;
		for i=1, msg_num, 1 do
		
			--セットする値をデフォルトで初期化 --EN:--initialize the value to be set by default
			local set_icon_id     = default_icon_id;
			local set_category_id = default_category_id;
			local set_msg_id      = default_msg_id;
			
			--値がある場合それを使う --EN:--use value if present
			if icon_list[i]     ~= nil then set_icon_id     = icon_list[i];     end
			if category_list[i] ~= nil then set_category_id = category_list[i]; end
			if msg_list[i]      ~= nil then set_msg_id      = msg_list[i];      end
			
			--インフォメーションメニューのリストに追加 --EN:--Added to the information menu list
			proxy:AddInfomationList( set_icon_id , set_category_id , set_msg_id );
		
		end	
	
	elseif type == 1 then -- 簡易メニュー --EN:-- simple menu
		--インフォメーションメニューのリストに追加 --EN:--Added to the information menu list
		proxy:AddInfomationList( default_icon_id , default_category_id , default_msg_id );
	end

	print( "Display_InfomationMenu end" );
end


--[[インフォメーションメニュー表示用]] --EN:--[[For information menu display]]
--[[メッセージIDひとついれると連番で勝手に指定]] --EN:--[[If you enter one message ID, specify it by serial number]]
--[[
	proxy 	          … イベントプロクシ --EN:proxy … event proxy
	type  	       	  … 0:通常(複数行) 1:簡易(1行) --EN:type … 0: normal (multiple lines) 1: simple (single line)
	title_icon_id  	  … タイトルメッセージのアイコンID --EN:title_icon_id … Title message icon ID
	title_category_id … タイトルメッセージのカテゴリーID(30がイベント用カテゴリー) --EN:title_category_id … Category ID of the title message (30 is the event category)
	title_msg_id      … タイトルメッセージのメッセージID --EN:title_msg_id … Message ID of title message
	sys_msg_id        … 0でダイアログ表示 --EN:Display dialog with sys_msg_id … 0
	icon_id           … 行ごとにアイコンを指定する場合に指定(この関数ではすべて同じになる) --EN:icon_id … Specified when specifying an icon for each row (all are the same in this function)
	category_id       … メッセージのカテゴリーID --EN:category_id … Category ID of the message
	first_msg_id      … メッセージID 最初のひとつを指定するとmsg_num行分が連番で追加される --EN:first_msg_id … Message ID If you specify the first one, msg_num lines will be added in sequence
	msg_num           … メッセージの行数 --EN:msg_num … number of message lines
]]
function Display_InfomationMenu_2
(proxy, type, title_icon_id, title_category_id, title_msg_id, sys_msg_id, icon_id, category_id, first_msg_id, msg_num)
	print( "Display_InfomationMenu begin" );
	proxy:ShowGenDialog(first_msg_id,1,1,true);
	--[[
	--インフォメーションメニュー表示 --EN:--Information menu display
	proxy:InfomationMenu( type , title_icon_id , title_category_id , title_msg_id , sys_msg_id );
	
	if type == 0 then -- 通常メニュー --EN:-- Normal menu

		local now_msg_id = first_msg_id;
		local i=1;
		for i=1, msg_num, 1 do
			--インフォメーションメニューのリストに追加 --EN:--Added to the information menu list
			proxy:AddInfomationList( icon_id , category_id , now_msg_id );
			now_msg_id = now_msg_id + 1;
		end
	
	elseif type == 1 then -- 簡易メニュー --EN:-- simple menu
		--インフォメーションメニューのリストに追加 --EN:--Added to the information menu list
		proxy:AddInfomationList( icon_id , category_id , first_msg_id );
	end
	]]
	print( "Display_InfomationMenu end" );
end



function LengthOut_SosDialog(proxy,param)
	print("LengthOut_SosDialog begin");	
	--インフォメーションメニュー表示		 --EN:--Information menu display
	print("LengthOut_SosDialog end");
end


--[[
		以下プログラムからコールされるシステムログ --EN:System log called from the following program
]]
--------------------------------------------------------------------------------------
--■SOS血文字から距離が離れて消えたときのログ --EN:--■ Log when the distance from the SOS blood letter disappears
--------------------------------------------------------------------------------------
function LengthOut_SosDialog(proxy,param)
	print("LengthOut_SosDialog begin");	
	--インフォメーションメニュー表示			 --EN:--Information menu display
	proxy:InfomationMenu( INFOMENU_TYPE_LIST, -1, 0, -1, 1 );
	proxy:AddInfomationTosBuffer( 20000005 );
	print("LengthOut_SosDialog end");
end


--------------------------------------------------------------------------------------
--■召還成功を通知するログ（ホワイト召還） --EN:--■ Log that notifies summoning success (white summoning)
--------------------------------------------------------------------------------------
function SummonSuccess_White(proxy,param)
	print("SummonSuccess_White begin");
	--インフォメーションメニュー表示			 --EN:--Information menu display
	print("SummonSuccess_White end");
end

--------------------------------------------------------------------------------------
--■召還成功を通知するログ（ブラック召還） --EN:-- ■ Log that notifies summoning success (black summoning)
--------------------------------------------------------------------------------------
function SummonSuccess_Black(proxy,param)
	print("SummonSuccess_Black begin");
	--インフォメーションメニュー表示			 --EN:--Information menu display
	print("SummonSuccess_Black end");
end

--------------------------------------------------------------------------------------
--■召還された事を通知するログ（ホワイト召還） --EN:--■Log notifying that you have been summoned (white summoning)
--------------------------------------------------------------------------------------
function OnBeSummoned_White(proxy,param)
	print("OnBeSummoned_White begin");
	
	--ホワイト召喚通知 --EN:-- White summon notification
	--proxy:LuaCallStartPlus( 4041, 1, proxy:GetLocalPlayerId() );
--[[
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 4036, "WarpSosPos", 0.1, 0, 2, once );
	proxy:NotNetMessage_end();
]]
	
	print("OnBeSummoned_White end");
end


--------------------------------------------------------------------------------------
--■召還された事を通知するログ（ブラック召還） --EN:--■ Log notifying that you have been summoned (black summoning)
--------------------------------------------------------------------------------------
function OnBeSummoned_Black(proxy,param)
	print("OnBeSummoned_Black begin");
	
	--ブラック召喚通知 --EN:-- Black summon notification
	--proxy:LuaCallStartPlus( 4041, 2, proxy:GetLocalPlayerId() );
--[[
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 4037, "WarpMiniblockPos", 0.1, 0, 2, once );
	proxy:NotNetMessage_end();
]]
	--ホストのプレイ領域からワープ先を設定 --EN:--Set warp destination from host's play area
	--proxy:LuaCallStart( 4037, 2 );
	
	print("OnBeSummoned_Black end");
end

--------------------------------------------------------------------------------------
--■召還された事を通知するログ（ブラック強制乱入） --EN:--■ Log notifying that you have been summoned (black forced intrusion)
--------------------------------------------------------------------------------------
function OnBeSummoned_ForceJoinBlack(proxy,param)
	print("OnBeSummoned_ForceJoinBlack begin");
	
	--ブラック乱入通知 --EN:-- Black intrusion notification
	--proxy:LuaCallStartPlus( 4041, 3, proxy:GetLocalPlayerId() );
	
	print("OnBeSummoned_ForceJoinBlack end");
end

--------------------------------------------------------------------------------------
--■召還された事を通知するログ（ブラック強制召喚<翁でしか使っていない>） --EN:--■ Log notifying that you have been summoned (forced black summoning <used only by Okina>)
--------------------------------------------------------------------------------------
function OnBeForceSummoned_Black(proxy,param)
	print("OnBeForceSummoned_Black begin");
	
	--ブラック強制召喚通知 --EN:-- Black forced summon notification
	--proxy:LuaCallStartPlus( 4041, 4, proxy:GetLocalPlayerId() );
	
	print("OnBeForceSummoned_Black end");
end



------------------------------------------------------------------------------------
--目標達成 --EN:--Goal achievement
------------------------------------------------------------------------------------
function MissionSuccessed(proxy,param)
	print("MissionSuccessed begin");
	--ホワイト --EN:--white
	if		proxy:GetTempSummonParam() == -1 then
		proxy:RecallMenuEvent( 0, 8933 );
	--ブラック --EN:--black
	elseif	proxy:GetTempSummonParam() == -2 then
		--通常PKの場合生存とグレイの場合で成功処理が変わる --EN:--In the case of normal PK, the success process differs between survival and gray.
		if proxy:IsPrevGreyGhost() == true then
			proxy:RecallMenuEvent( 0, 8934 );
		else
			proxy:RecallMenuEvent( 0, 8937 );
		end
	--乱入 --EN:--Intrusion
	elseif	proxy:GetTempSummonParam() == -3 then
		proxy:RecallMenuEvent( 0, 8935 );
	--強制召喚 --EN:--forced summon
	elseif	proxy:GetTempSummonParam() >   0 then
		proxy:RecallMenuEvent( 0, 8936 );
	end
	print("MissionSuccessed end");
end


------------------------------------------------------------------------------------
--目標失敗 --EN:--Target failed
------------------------------------------------------------------------------------
function MissionFailed(proxy,param)
	print("MissionFailed begin");
	--ホワイト --EN:--white
	if		proxy:GetTempSummonParam() == -1 then
		proxy:RecallMenuEvent( 0, 8943 );
	--ブラック --EN:--black
	elseif	proxy:GetTempSummonParam() == -2 then
		proxy:RecallMenuEvent( 0, 8944 );
	--乱入 --EN:--Intrusion
	elseif	proxy:GetTempSummonParam() == -3 then
		proxy:RecallMenuEvent( 0, 8945 );
	--強制召喚 --EN:--forced summon
	elseif	proxy:GetTempSummonParam() >   0 then
		proxy:RecallMenuEvent( 0, 8946 );
	end
	--完全回復要求 --EN:-- full recovery request
	proxy:RequestFullRecover();
	
	print("MissionFailed end");
end


------------------------------------------------------------------------------------
--死亡による目標失敗 --EN:--Target failure due to death
------------------------------------------------------------------------------------
function MissionDeadFailed(proxy,param)
	print("MissionDeadFailed begin");
	--ホワイト --EN:--white
	if		proxy:GetTempSummonParam() == -1 then
		proxy:RecallMenuEvent( 0, 8953 );
	--ブラック --EN:--black
	elseif	proxy:GetTempSummonParam() == -2 then
		proxy:RecallMenuEvent( 0, 8954 );
	--乱入 --EN:--Intrusion
	elseif	proxy:GetTempSummonParam() == -3 then
		proxy:RecallMenuEvent( 0, 8955 );
	--強制召喚 --EN:--forced summon
	elseif	proxy:GetTempSummonParam() >   0 then
		proxy:RecallMenuEvent( 0, 8956 );
	end
	print("MissionDeadFailed end");
end

--------------------------------------------------------------------------------------
--■SOSサインが消えた事を通知するログ(ミニブロック移動時) --EN:--■ A log that notifies that the SOS sign has disappeared (when moving the mini block)
--------------------------------------------------------------------------------------
function OnEvent_Delete_SOS(proxy,param)
	print("OnEvent_Delete_SOS begin");	
	proxy:InfomationMenu( INFOMENU_TYPE_LIST, -1, 0, -1, 1 );
	proxy:AddInfomationTosBuffer( 20000000 );
	print("OnEvent_Delete_SOS end");
end
--ホワイトソウルサイン --EN:--White Soul Sign
function OnEvent_Delete_WhiteSOS(proxy,param)
	print("OnEvent_Delete_WhiteSOS begin");	
	proxy:InfomationMenu( INFOMENU_TYPE_LIST, -1, 0, -1, 1 );
	proxy:AddInfomationTosBuffer( 20000000 );
	proxy:SetInfomationPriority(USER_ID_Event_SosLost_White);
	print("OnEvent_Delete_WhiteSOS end");
end
--ブラックソウルサイン --EN:-- Black Soul Sign
function OnEvent_Delete_BlackSOS(proxy,param)
	print("OnEvent_Delete_BlackSOS begin");	
	proxy:InfomationMenu( INFOMENU_TYPE_LIST, -1, 0, -1, 1 );
	proxy:AddInfomationTosBuffer( 20000001 );
	proxy:SetInfomationPriority(USER_ID_Event_SosLost_Red);
	print("OnEvent_Delete_BlackSOS end");
end
--乱入ソウルサイン --EN:--Intrusion Soul Sign
function OnEvent_Delete_ForceJoinSOS(proxy,param)
	print("OnEvent_Delete_ForceJoinSOS begin");	
	proxy:InfomationMenu( INFOMENU_TYPE_LIST, -1, 0, -1, 1 );
	proxy:AddInfomationTosBuffer( 20000002 );
	proxy:SetInfomationPriority(USER_ID_Event_SosLost_Black);
	print("OnEvent_Delete_ForceJoinSOS end");
end

--------------------------------------------------------------------------------------
--■LANが切断された事を通知するログ --EN:--■ A log that notifies that the LAN has been disconnected
--------------------------------------------------------------------------------------
function OnLanCutError(proxy,param)
	print("OnLanCutError begin");
	
	if proxy:IsCompleteEvent( 4047 ) == true then
		return;
	end
	proxy:InfomationMenu( INFOMENU_TYPE_LIST, -1, 0, -1, 1 );
	proxy:AddInfomationTosBuffer( 20001005 );
	


	proxy:NotNetMessage_begin();
		--[[
		--■4046■5秒後 --EN:-- ■ 4046 ■ 5 seconds later
		proxy:OnKeyTime2( 4046, "OnLeave_Limit", 5.0, 0, 1, once );
				
		--他の再読み込み系イベントの割り込みを防止 --EN:--Prevent interruption of other reloading events
		proxy:SetEventFlag(4047, true);
		--イベント内部にもロード待ちである事を通知 --EN:-- Notify that it is waiting for loading inside the event
		proxy:SetLoadWait();
		]]
		RegistReturnTitle(proxy,param);
		proxy:WARN("OnLanCutError!");
	proxy:NotNetMessage_end();
	
	print("OnLanCutError end");
end


--------------------------------------------------------------------------------------
--■NPサーバからのサインアウトを通知するログ --EN:--■Log notifying sign-out from NP server
--------------------------------------------------------------------------------------
function OnNpServerSignOut(proxy,param)
	if proxy:IsCompleteEvent( 4047 ) == true then
		return;
	end
	print("OnNpServerSignOut begin");
	proxy:InfomationMenu( INFOMENU_TYPE_LIST, -1, 0, -1, 1 );
	proxy:AddInfomationTosBuffer( 20001010 );
	
	--タイトルに戻る --EN:--Return to title
	proxy:WARN("NpSignOut Error");
	RegistReturnTitle(proxy,param);
	print("OnNpServerSignOut end");
end

--------------------------------------------------------------------------------------
--■P2P接続のタイムアウトを通知するログ --EN:--■ Log that notifies timeout of P2P connection
--------------------------------------------------------------------------------------
function OnP2PTimeOut(proxy,param)
	print("OnP2PTimeOut begin");
	if proxy:IsCompleteEvent( 4047 ) == true then
		return;
	end
	proxy:InfomationMenu( INFOMENU_TYPE_LIST, -1, 0, -1, 1 );
	proxy:AddInfomationTosBuffer( 20001015 );
	if proxy:IsLivePlayer() == false and proxy:IsGreyGhost() == false then
		proxy:NotNetMessage_begin();
			--■4046■5秒後 --EN:-- ■ 4046 ■ 5 seconds later
			proxy:OnKeyTime2( 4046, "OnLeave_Limit", 5.0, 0, 1, once );
			
			--他の再読み込み系イベントの割り込みを防止 --EN:--Prevent interruption of other reloading events
			proxy:SetEventFlag(4047, true);
			--イベント内部にもロード待ちである事を通知 --EN:-- Notify that it is waiting for loading inside the event
			proxy:SetLoadWait();
			
		proxy:NotNetMessage_end();
	end
	print("OnP2PTimeOut end");
end


function OnFailedGetBlockNum(proxy,param)
	print("OnFailedGetBlockNum begin");
	if proxy:IsCompleteEvent( 4047 ) == true then
		return;
	end
	proxy:InfomationMenu( INFOMENU_TYPE_LIST, -1, 0, -1, 1 );
	proxy:AddInfomationTosBuffer( 20001002 );	
	--タイトルに戻る --EN:--Return to title
	proxy:WARN("OnFailedGetBlockNum Error");
	RegistReturnTitle(proxy,param);
	print("OnFailedGetBlockNum end");
end

--------------------------------------------------------------------------------------
--■4043■参加者がいなくなった（退出、キック、死亡以外） --EN:--■4043■Participant disappeared (other than leaving, kicking, or dying)
--------------------------------------------------------------------------------------
function OnLeavePlayer(proxy,param)
	print("OnLeavePlayer begin");
	if proxy:IsCompleteEvent( 4047 ) == true then
		return;
	end
	
	if proxy:IsCompleteEvent( 4044 ) == true then
		proxy:SetEventFlag( 4044, false );
		return;
	end
	
	--退出、キック、死亡以外が取れないので、一先ずコメントアウト --EN:--I can't get anything other than exit, kick, and death, so comment out for now
	proxy:InfomationMenu( INFOMENU_TYPE_LIST, -1, 0, -1, 1 );
	proxy:AddInfomationTimeMsgTag( 20001020, TAG_IDX_leaveChara, param:GetParam3() );
	if param:GetParam3() == proxy:GetLocalPlayerId() then
		proxy:NotNetMessage_begin();
			--■4046■5秒後 --EN:-- ■ 4046 ■ 5 seconds later
			proxy:OnKeyTime2( 4046, "OnLeave_Limit", 5.0, 0, 1, once );
			
			--他の再読み込み系イベントの割り込みを防止 --EN:--Prevent interruption of other reloading events
			proxy:SetEventFlag(4047, true);
			--イベント内部にもロード待ちである事を通知 --EN:-- Notify that it is waiting for loading inside the event
			proxy:SetLoadWait();
			
		proxy:NotNetMessage_end();
	end
	print("OnLeavePlayer end");
end

--------------------------------------------------------------------------------------
--■ゲーム的退出をした人を通知する --EN:--■ Notify the person who left the game
--------------------------------------------------------------------------------------
function OnGameLeave(proxy,param)
	if param:GetParam2() ~= proxy:GetLocalPlayerId() then
		print("OnGameLeave begin");
		local leavePlayer = param:GetParam2();
		print("LeavePlayer :",leavePlayer);
		proxy:ReqularLeavePlayer( leavePlayer );
		print("OnGameLeave begin");
	end
end

--------------------------------------------------------------------------------------
--■キックアウトされたのを通知するログ --EN:--■ Log to notify that you have been kicked out
--------------------------------------------------------------------------------------
function OnBeKickOut(proxy,param)
	print("OnBeKickOut begin");
	if proxy:IsCompleteEvent( 4047 ) == true then
		return;
	end
	proxy:InfomationMenu( INFOMENU_TYPE_LIST, -1, 0, -1, 1 );
	proxy:AddInfomationTosBuffer( 20000420 );
	
	--■4046■5秒後 --EN:-- ■ 4046 ■ 5 seconds later
	proxy:OnKeyTime2( 4046, "OnLeave_Limit", 5.0, 0, 1, once );
	--他の再読み込み系イベントの割り込みを防止 --EN:--Prevent interruption of other reloading events
	proxy:SetEventFlag(4047, true);
	--イベント内部にもロード待ちである事を通知 --EN:-- Notify that it is waiting for loading inside the event
	proxy:SetLoadWait();
	
	print("OnBeKickOut end");
end

--------------------------------------------------------------------------------------
--■感謝キックアウトされたのを通知するログ --EN:--■ Thank you log to notify you that you have been kicked out
--------------------------------------------------------------------------------------
function OnBeThxKickOut(proxy,param)
	print("OnBeThxKickOut begin");
	if proxy:IsCompleteEvent( 4047 ) == true then
		return;
	end
	proxy:InfomationMenu( INFOMENU_TYPE_LIST, -1, 0, -1, 1 );
	proxy:AddInfomationTosBuffer( 20000421 );
	
	--■4046■5秒後 --EN:-- ■ 4046 ■ 5 seconds later
	proxy:OnKeyTime2( 4046, "OnLeave_Limit", 5.0, 0, 1, once );
	--他の再読み込み系イベントの割り込みを防止 --EN:--Prevent interruption of other reloading events
	proxy:SetEventFlag(4047, true);
	--イベント内部にもロード待ちである事を通知 --EN:-- Notify that it is waiting for loading inside the event
	proxy:SetLoadWait();
	
	print("OnBeThxKickOut end");
end


--------------------------------------------------------------------------------------
--■4044■キックアウトしたのを通知するログ --EN:--■4044■Log notifying that you kicked out
--------------------------------------------------------------------------------------
function OnKickOut(proxy,param)
	print("OnKickOut begin");	
	--キックアウトしたのが自分の時 --EN:--When I kicked out
	if proxy:IsHost() == true then
		proxy:InfomationMenu( INFOMENU_TYPE_LIST, -1, 0, -1, 1 );	
		proxy:AddInfomationTosBuffer( 20000415 );
		proxy:SetEventFlag( 4044, true );
	--自分以外の人がキックアウトされた時		 --EN:--When someone other than you is kicked out
	elseif proxy:GetLocalPlayerId() ~= param:GetParam3() then
		proxy:InfomationMenu( INFOMENU_TYPE_LIST, -1, 0, -1, 1 );	
		proxy:AddInfomationTimeMsgTag( 20000425, TAG_IDX_leaveChara, param:GetParam3() );
	end
	print("OnKickOut end");
end

--------------------------------------------------------------------------------------
--■4044■感謝キックアウトしたのを通知するログ --EN:-- ■ 4044 ■ Log to notify that you have kicked out thanks
--------------------------------------------------------------------------------------
function OnThxKickOut(proxy,param)
	print("OnThxKickOut begin");	
	--キックアウトしたのが自分の時 --EN:--When I kicked out
	if proxy:IsHost() == true then
		proxy:InfomationMenu( INFOMENU_TYPE_LIST, -1, 0, -1, 1 );	
		proxy:AddInfomationTosBuffer( 20000416 );
		proxy:SetEventFlag( 4044, true );
	--自分以外の人がキックアウトされた時 --EN:--When someone other than you is kicked out
	elseif proxy:GetLocalPlayerId() ~= param:GetParam3() then
		proxy:InfomationMenu( INFOMENU_TYPE_LIST, -1, 0, -1, 1 );	
		proxy:AddInfomationTimeMsgTag( 20000425, TAG_IDX_leaveChara, param:GetParam3() );
	end
	print("OnThxKickOut end");
end


--------------------------------------------------------------------------------------
--■退出魔法使用を通知するログ --EN:-- ■ Log to notify the use of exit magic
--------------------------------------------------------------------------------------
function OnLeaveMagic(proxy,param)
	print("OnLeaveMagic begin");
	--他の読み込みの流れに入っていたら、ダイアログすら出さない --EN:--If you are in another loading flow, don't even display a dialog
	if proxy:IsCompleteEvent( 4047 ) == true then
		return;
	end
--[[
	proxy:NotNetMessage_begin();
		--■4046■退出確認メニューでYesを選択 --EN:-- ■ 4046 ■ Select Yes in the exit confirmation menu
		proxy:OnYesNoDialog( 4046, "OnLeaveMenu_Yes", 20000430, 0, 2, once );
	proxy:NotNetMessage_end();
]]
	--自分のプレイヤーIDを配信してゲーム的に抜ける事を通知 --EN:--Distribute your player ID and notify that you are leaving the game
	proxy:CustomLuaCallStart( 4063 , proxy:GetLocalPlayerId() );
	OnLeaveMenu_Yes(proxy,param);
	print("OnLeaveMagic end");
end

--------------------------------------------------------------------------------------
--■乱入アイテム使用を通知するログ --EN:--■Log notifying the use of intrusive items
--------------------------------------------------------------------------------------
function OnForceJoinBlack(proxy,param)
	print("OnForceJoinBlack begin");
	--他の読み込みの流れに入っていたら、ダイアログすら出さない --EN:--If you are in another loading flow, don't even display a dialog
	if proxy:IsCompleteEvent( 4047 ) == true then
		return;
	end
--[[
	proxy:NotNetMessage_begin();
		--■4039■乱入確認メニューでYesを選択 --EN:-- ■ 4039 ■ Select Yes in the intrusion confirmation menu
		proxy:OnYesNoDialog( 4039, "OnForceJoinBlackMenu_Yes", 20000440, 0, 2, once );
	proxy:NotNetMessage_end();
]]
	OnForceJoinBlackMenu_Yes(proxy,param);
	print("OnForceJoinBlack end");
end

--------------------------------------------------------------------------------------
--■4039■乱入確認メニューでYesを選択 --EN:-- ■ 4039 ■ Select Yes in the intrusion confirmation menu
--------------------------------------------------------------------------------------
function OnForceJoinBlackMenu_Yes(proxy,param)
	print("OnForceJoinBlackMenu_Yes begin");
	
	--乱入リクエストしても必ず参加できるとは限らないので、4047は立てない(若干不安だけど) --EN:--Even if you request an intrusion, it is not always possible to participate, so 4047 cannot be raised (although I am a little worried)
	--強制参加(乱入)をキック --EN:--Kick Forced Participation (Intrusion)
	proxy:SetForceJoinBlackRequest();
	
	print("OnForceJoinBlackMenu_Yes end");
end


--------------------------------------------------------------------------------------
--■乱入が時間切れしたのを通知 --EN:--Notify that the intrusion has expired
--------------------------------------------------------------------------------------
function OnFailedForceJoinBlack(proxy,param)
	print("OnFailedForceJoinBlack begin");
	proxy:RecallMenuEvent(0,8855);
	print("OnFailedForceJoinBlack end");
end


--------------------------------------------------------------------------------------
--■乱入を他のSOSで上書きしたのを通知 --EN:--Notify that the intrusion was overwritten by another SOS
--------------------------------------------------------------------------------------
function OnCancelForceJoinBlack(proxy,param)
	print("OnCancelForceJoinBlack begin");
	proxy:InfomationMenu( INFOMENU_TYPE_LIST, -1, 0, -1, 1 );
	proxy:AddInfomationTosBuffer( 20000002 );
	print("OnCancelForceJoinBlack end");
end

--------------------------------------------------------------------------------------
--■ルーム作成失敗したのを通知 --EN:--■ Notification that room creation failed
--------------------------------------------------------------------------------------
function OnFailedCreateSession(proxy,param)
	print("OnFailedCreateSession begin");
	proxy:InfomationMenu( INFOMENU_TYPE_LIST, -1, 0, -1, 1 );
	proxy:AddInfomationTosBuffer( 20001003 );
	print("OnFailedCreateSession end");
end

--------------------------------------------------------------------------------------
--■ルーム参加失敗失敗したのを通知 --EN:--■ Notification of failure to join the room
--------------------------------------------------------------------------------------
function OnFailedJoinSession(proxy,param)
	print("OnFailedJoinSession begin");
	proxy:InfomationMenu( INFOMENU_TYPE_LIST, -1, 0, -1, 1 );
	proxy:AddInfomationTosBuffer( 20001004 );
	print("OnFailedJoinSession end");
end

--------------------------------------------------------------------------------------
--■ロード前にキックしたのを通知 --EN:--■ Notification of kicking before loading
--------------------------------------------------------------------------------------
function OnJoinClearedRoom(proxy,param)
	print("OnJoinClearedRoom begin");
	proxy:RecallMenuEvent(0,8870);
	print("OnJoinClearedRoom end");
end

--------------------------------------------------------------------------------------
--■ブラックがキックされたのをEvent側に通知 --EN:--■ Notify the Event side that Black was kicked
--------------------------------------------------------------------------------------
function OnBeBlackKickOut(proxy,param)
	print("OnBeBlackKickOut begin");
	
	--ホワイトも呼ばれるので先にはじいておく --EN:-- White will also be called, so flip it first
	if proxy:IsWhiteGhost() == true then
		return;
	end
	
	--自分のプレイヤーIDを配信してゲーム的に抜ける事を通知 --EN:--Distribute your player ID and notify that you are leaving the game
	proxy:CustomLuaCallStart( 4063 , proxy:GetLocalPlayerId() );

	proxy:LeaveSession();
	
	proxy:InfomationMenu( INFOMENU_TYPE_LIST, -1, 0, -1, 1 );
	proxy:AddInfomationTosBuffer( 20000450 );
	
	proxy:NotNetMessage_begin();
		--■4046■5秒後 --EN:-- ■ 4046 ■ 5 seconds later
		proxy:OnKeyTime2( 4046, "OnLeave_Limit", 5.0, 0, 1, once );
		--他の再読み込み系イベントの割り込みを防止 --EN:--Prevent interruption of other reloading events
		proxy:SetEventFlag(4047, true);
		--イベント内部にもロード待ちである事を通知 --EN:-- Notify that it is waiting for loading inside the event
		proxy:SetLoadWait();
		
	proxy:NotNetMessage_end();
	
	print("OnBeBlackKickOut end");
end

--------------------------------------------------------------------------------------
--■石柱にワープ（奇跡：ゲート）をEvent側に通知 --EN:--■ Notify the event side of the warp (miracle: gate) to the stone pillar
--------------------------------------------------------------------------------------
function OnGateEnchant(proxy,param)
	print("OnGateEnchant begin");
	
	--完全回復要求 --EN:-- full recovery request
	proxy:RequestFullRecover();
	--召喚要求キャンセル --EN:--Summon request canceled
	proxy:ResetSummonParam();
	proxy:WarpNextStage( 1, 0, 0, 0, -1 );
	
	print("OnGateEnchant end");
end


--ルームのタイムアウト --EN:--room timeout
function OnRoomTimeOut(proxy,param)
	print("OnRoomTimeOut begin");	
	print("OnRoomTimeOut end");
end

--召喚のタイムアウト --EN:--summon timeout
function OnSummonTimeOut(proxy,param)
	print("OnSummonTimeOut begin");	
	print("OnSummonTimeOut end");
end


--召喚されてロード直前、マルチ参加開始　in the (ホワイトソウル)  --EN:-- Just before being summoned and loading, multi-participation starts in the (White Soul)
function OnBeJoinStart_White(proxy,param)
	if proxy:IsAlive(10000) == true then
		print("OnBeJoinStart_White begin");
		proxy:RecallMenuEvent( 0, 8823 );
		proxy:NotNetMessage_begin();
		proxy:OnRequestMenuEnd( 4059, "SummonReloadStart");
		proxy:NotNetMessage_end();
		print("OnBeJoinStart_White end");
	else
		--念の為リーブ --EN:--Reeve just in case
		proxy:LeaveSession();
		proxy:ResetSummonParam();
		proxy:WARN("OnBeJoinStart_White 既に死んでる"); --EN:proxy:WARN("OnBeJoinStart_White already dead");
	end
end

--召喚されてロード直前、マルチ参加開始　in the (ブラックソウル)  --EN:-- Just before being summoned and loading, multi-participation starts in the (Black Soul)
function OnBeJoinStart_Black(proxy,param)
	if proxy:IsAlive( 10000 ) == true then
		print("OnBeJoinStart_Black begin");
		proxy:RecallMenuEvent( 0, 8824 );
		proxy:NotNetMessage_begin();
		proxy:OnRequestMenuEnd( 4059, "SummonReloadStart");
		proxy:NotNetMessage_end();
		print("OnBeJoinStart_Black end");
	else
		--念の為リーブ --EN:--Reeve just in case
		proxy:LeaveSession();
		proxy:ResetSummonParam();
		proxy:WARN("OnBeJoinStart_Black 既に死んでる"); --EN:proxy:WARN("OnBeJoinStart_Black is already dead");
	end
end

--召喚されてロード直前、マルチ参加開始　in the (乱入)  --EN:-- Just before being summoned and loading, multi-participation starts in the (intrusion)
function OnBeJoinStart_ForceJoin(proxy,param)
	if proxy:IsAlive(10000) == true then	
		print("OnBeJoinStart_ForceJoin begin");
		proxy:RecallMenuEvent( 0, 8825 );
		proxy:NotNetMessage_begin();
		proxy:OnRequestMenuEnd( 4059, "SummonReloadStart");
		proxy:NotNetMessage_end();
		print("OnBeJoinStart_ForceJoin end");
	else
		--念の為リーブ --EN:--Reeve just in case
		proxy:LeaveSession();
		proxy:ResetSummonParam();
		proxy:WARN("OnBeJoinStart_ForceJoin 既に死んでる"); --EN:proxy:WARN("OnBeJoinStart_ForceJoin is already dead");
	end	
end

--召喚されてロード直前、マルチ参加開始　in the (強制召喚)  --EN:--Summoned and just before loading, multi-participation starts in the (forced summon)
function OnBeJoinStart_ForceSummon(proxy,param)
	if proxy:IsAlive( 10000 ) == true then
		print("OnBeJoinStart_ForceSummon begin");
		proxy:RecallMenuEvent( 0, 8826 );
		proxy:NotNetMessage_begin();
		proxy:OnRequestMenuEnd( 4059, "ForceSummonReloadStart");
		proxy:NotNetMessage_end();
		print("OnBeJoinStart_ForceSummon end");
	else
		--念の為リーブ --EN:--Reeve just in case
		proxy:LeaveSession();
		proxy:ResetSummonParam();
		proxy:WARN("OnBeJoinStart_ForceSummon 既に死んでる"); --EN:proxy:WARN("OnBeJoinStart_ForceSummon is already dead");
	end
end

--召喚されたことによる再読み込みをキック --EN:-- kick reload due to being summoned
function SummonReloadStart(proxy,param)
	print("SummonReloadStart begin");
	--ルームが存在したら入る --EN:--Enter if the room exists
	if	proxy:IsInParty() == true then
		--生きていたら --EN:--If you were alive
		if proxy:IsAlive(10000)  == true then
			proxy:SummonedMapReload();
		else
			--念の為リーブ --EN:--Reeve just in case
			proxy:LeaveSession();
			proxy:ResetSummonParam();
			proxy:WARN("SummonReloadStart ルーム有り死んでる"); --EN:proxy:WARN("SummonReloadStart room dead");
		end
	else
		if proxy:IsAlive(10000)  == false then
			proxy:ResetSummonParam();
			proxy:WARN("SummonReloadStart ルーム無し死んでる"); --EN:proxy:WARN("SummonReloadStart no room dead");
		end
	end
	print("SummonReloadStart end");
end

--召喚されたことによる再読み込みをキック(強制召還用) --EN:--Kick reload due to being summoned (for forced summoning)
function ForceSummonReloadStart(proxy,param)
	print("ForceSummonReloadStart begin");
	--ルームが存在したら入る --EN:--Enter if the room exists
	if	proxy:IsInParty() == true then
		if proxy:IsAlive(10000) == true then
			--完全回復要求 --EN:-- full recovery request
			proxy:RequestFullRecover();
			proxy:SummonedMapReload();
		else
			--念の為リーブ --EN:--Reeve just in case
			proxy:LeaveSession();
			proxy:ResetSummonParam();
			proxy:WARN("ForceSummonReloadStart ルーム有り死んでる"); --EN:proxy:WARN("ForceSummonReloadStart with room dead");
		end
	else
		if proxy:IsAlive(10000) == false then
			proxy:ResetSummonParam();
			proxy:WARN("ForceSummonReloadStart ルーム無し死んでる"); --EN:proxy:WARN("ForceSummonReloadStart no room dead");
		end
	end
	print("ForceSummonReloadStart end");
end


--マルチプレイに参加した時のメッセージ --EN:--Message when joining multiplayer
function OnJoinMutiplay(proxy,param)
	print("OnJoinMutiplay begin");	
	print("OnJoinMutiplay end");
end

-------------------------------------------------------------------------------------
--セッションに参加した時のメッセージ --EN:--Message when joining a session
-------------------------------------------------------------------------------------
--ホワイトソウル --EN:--White Soul
function JoinSession_White(proxy,param)
	print("JoinSession_White begin");
	proxy:RecallMenuEvent( 0, 8813 );
	print("JoinSession_White end");
end

--ブラックソウル --EN:--Black Soul
function JoinSession_Black(proxy,param)
	print("JoinSession_Black begin");
	proxy:RecallMenuEvent( 0, 8814 );
	print("JoinSession_Black end");
end

--乱入 --EN:--Intrusion
function JoinSession_ForceJoin(proxy,param)
	print("JoinSession_ForceJoin begin");
	proxy:RecallMenuEvent( 0, 8815 );
	print("JoinSession_ForceJoin end");
end

--強制召喚 --EN:--forced summon
function JoinSession_ForceSummon(proxy,param)
	print("JoinSession_ForceSummon begin");
	proxy:RecallMenuEvent( 0, 8816 );
	print("JoinSession_ForceSummon end");
end



function JoinSession(proxy,param)
	print("JoinSession begin");	
	--ホワイトソウル --EN:--White Soul
	if proxy:GetTempSummonParam() == -1 then
		proxy:RecallMenuEvent( 0, 8813 );
	--ブラックソウル --EN:--Black Soul
	elseif proxy:GetTempSummonParam() == -2 then
		proxy:RecallMenuEvent( 0, 8814 );
	end
	print("JoinSession end");
end

--セッションに強制参加した時のメッセージ --EN:--Message when forcibly joining a session
function ForceJoinSession(proxy,param)
	print("ForceJoinSession begin");	
	proxy:RecallMenuEvent( 0, 8815 );
	print("ForceJoinSession end");
end

---------------------------------------------------------------------------------------------------------
--■4058■召喚中配信 --EN:-- ■ 4058 ■ Delivery during summoning
---------------------------------------------------------------------------------------------------------
--4058▼▼▼召喚中配信▼▼▼-- --EN:--4058▼▼▼During Summoning▼▼▼--
function OnEvent_Call_SOS(proxy,param)
	print("OnEvent_Call_SOS begin");
	proxy:LuaCallStartPlus(4058, 1, proxy:GetLocalPlayerId());
	print("OnEvent_Call_SOS end");
end

function OnEvent_Call_BlackSOS(proxy,param)
	print("OnEvent_Call_BlackSOS begin");
	proxy:LuaCallStartPlus(4058, 2, proxy:GetLocalPlayerId());
	print("OnEvent_Call_BlackSOS end");
end

--ホワイトソウルサインを召喚(SOSメニューでOKを押したタイミング) --EN:--Summon White Soul Sign (when you press OK in the SOS menu)
--(4058, 1, playerId)
function Call_WhiteSos(proxy,param)
	print("Call_WhiteSos begin");
	proxy:RecallMenuEvent( 0, 8810 );
	print("Call_WhiteSos end");
end

--ブラックソウルサインを召喚(SOSメニューでOKを押したタイミング) --EN:--Summon Black Soul Sign (when you press OK in the SOS menu)
--(4058, 2, playerId)
function Call_BlackSos(proxy,param)
	print("Call_BlackSos begin");
	proxy:RecallMenuEvent( 0, 8811 );
	print("Call_BlackSos end");
end
--4058▲▲▲召喚中配信▲▲▲-- --EN:--4058▲▲▲During summoning ▲▲▲--





--ホワイトソウルサインを出した --EN:--Sent White Soul sign
function OnEvent_SendSoulSign_White(proxy,param)
	print("OnEvent_SendSoulSign_White begin");
	print("OnEvent_SendSoulSign_White end");
end

--ブラックソウルサインを出した --EN:--Sent Black Soul Sign
function OnEvent_SendSoulSign_Black(proxy,param)
	print("OnEvent_SendSoulSign_Black begin");
	print("OnEvent_SendSoulSign_Black end");
end

--乱入ソウルサインを出した --EN:--Sent an intrusion soul sign
function OnEvent_SendSoulSign_ForceJoin(proxy,param)
	print("OnEvent_SendSoulSign_ForceJoin begin");
	proxy:RecallMenuEvent( 0, 8805 );
	print("OnEvent_SendSoulSign_ForceJoin end");
end

--------------------------------------------------------------------------------------
--■蘇生をEvent側に通知 --EN:--■ Notification of resurrection to the Event side
--------------------------------------------------------------------------------------
function OnReviveMagic(proxy,param)
	print("OnReviveMagic begin");
	if proxy:IsBlackGhost() == true then
		return;
	end
	
	--(ホストのために)ホワイト蘇生カウント、QWC加算用のハンドラを呼ぶ --EN:--(for host) call handler for white revive count, QWC addition
	if	proxy:IsWhiteGhost() == true then
		proxy:LuaCallStart( 4055, 1 );
	end
	
	--自分のプレイヤーIDを配信してゲーム的に抜ける事を通知 --EN:--Distribute your player ID and notify that you are leaving the game
	proxy:CustomLuaCallStart( 4063 , proxy:GetLocalPlayerId() );
	
	--退出 --EN:--Exit
	proxy:LeaveSession();
	
	proxy:InfomationMenu( INFOMENU_TYPE_LIST, -1, 0, -1, 1 );
	proxy:AddInfomationTosBuffer( 20000445 );
	
	proxy:NotNetMessage_begin();
		--■4046■5秒後 --EN:-- ■ 4046 ■ 5 seconds later
		proxy:OnKeyTime2( 4046, "OnReviveMagic_1", 5.0, 0, 1, once );
		--他の再読み込み系イベントの割り込みを防止 --EN:--Prevent interruption of other reloading events
		proxy:SetEventFlag(4047, true);
		--イベント内部にもロード待ちである事を通知 --EN:-- Notify that it is waiting for loading inside the event
		proxy:SetLoadWait();
		
	proxy:NotNetMessage_end();
	
	print("OnReviveMagic end");
end

function OnReviveMagic_1(proxy,param)
	print("OnReviveMagic_1 begin");	
	--復活するので復活アニメフラグをセット --EN:-- Set the resurrection animation flag because it will be revived
	proxy:SetAliveMotion( true );
	--完全回復要求 --EN:-- full recovery request
	proxy:RequestFullRecover();
	
	--イベントフラグロールバック --EN:--eventflag rollback
	proxy:SetFlagInitState(2);
	--復活するのでペナルティで減少したパラメータを元に戻す(最大値のみ) --EN:--Since it will be revived, restore the parameters that have been reduced by the penalty (maximum value only)
	proxy:EraseEventSpecialEffect( 10000, 101 );	
	
	--生存状態に設定した上で、自分の血文字位置へワープ	 --EN:--Warp to your blood letter position after setting it to a living state
	proxy:SetSelfBloodMapUid();
	--proxy:RevivePlayer();
	proxy:RevivePlayerNext();--次のロードで蘇生 --EN:--Respawn on next load
	proxy:WarpNextStageKick();
	print("OnReviveMagic_1 end");	
end

--------------------------------------------------------------------------------------
--■グレイゴーストからデモンズソウルによる復活 --EN:--■ Revived by Demon's Soul from Gray Ghost
--------------------------------------------------------------------------------------
function OnDemonsSoulRevive(proxy,param)
	print("OnDemonsSoulRevive begin");
	
	--復活するのでペナルティで減少したパラメータを元に戻す(最大値のみ) --EN:--Since it will be revived, restore the parameters that have been reduced by the penalty (maximum value only)
	proxy:EraseEventSpecialEffect( 10000, 101 );
	
	proxy:RevivePlayer();
	proxy:SetReviveWait( false );--復活待ち状態フラグを下ろしておく --EN:--Put down the resurrection waiting state flag
	
	--自分の血文字非表示 --EN:--Hide own blood letters
	--proxy:InvalidMyBloodMarkInfo();
	
	proxy:SetEventFlag( 15112,true );
	proxy:SetEventFlag( 15113,true );
	proxy:SetEventFlag( 15114,true );
	proxy:SetEventFlag( 15115,true );
	
	proxy:SetEventFlag( 15116,true );
	proxy:SetEventFlag( 15117,true );
	proxy:SetEventFlag( 15118,true );
	proxy:SetEventFlag( 15119,true );	
	
	--テキスト演出 --EN:--Text rendering
	proxy:SetTextEffect(TEXT_TYPE_Revival);
	
	--徘徊デーモン復帰用イベントハンドラ --EN:--Event handler for wandering daemon return
	proxy:LuaCallStart( 4032, 100 );
	
	print("OnDemonsSoulRevive end");
end


--------------------------------------------------------------------------------------
--■4046■退出確認メニューでYesを選択 --EN:-- ■ 4046 ■ Select Yes in the exit confirmation menu
--------------------------------------------------------------------------------------
function OnLeaveMenu_Yes(proxy,param)
	print("OnLeaveMenu_Yes begin");
	--ダイアログが開かれている最中に別の流れに入る場合もあるので、 --EN:--Because you may enter another flow while the dialog is open,
	--ここでもう一度はじく --EN:--Flick again here
	if proxy:IsCompleteEvent( 4047 ) == true then
		return;
	end
	
	--イベント内部にもロード待ちである事を通知 --EN:-- Notify that it is waiting for loading inside the event
	proxy:SetLoadWait();
	--退出メッセージを配信 --EN:--Delivery leave message
	if	proxy:IsWhiteGhost() == true then
	proxy:LuaCallStartPlus(4046, 1, proxy:GetLocalPlayerId() );
	elseif	proxy:IsBlackGhost() == true then
		proxy:LuaCallStartPlus(4046, 2, proxy:GetLocalPlayerId() );
		--強制召還なら --EN:--Forcibly summoned
		if	proxy:GetTempSummonParam() > 0 then
			proxy:LuaCallStartPlus( 4046, 3, proxy:GetLocalPlayerId() );		
		--強制召還以外のブラックなら --EN:--For blacks other than forced summons
		else
			--脱退ペナルティ --EN:--Withdrawal Penalty
			proxy:SetLeaveSoulSteel();
		end
	end

	--セッションを切る --EN:--end session
	proxy:LeaveSession();
	
	--生存だったらロードは必要ないのでカット --EN:--If you survive, you don't need to load, so cut
	if	proxy:IsLivePlayer() == true then
		print("OnLeaveMenu_Yes return end");
		return;
	end
	
	--PTに参加して死亡した場合、自ら抜けた場合はソウルのペナルティが入ります。 --EN:--If you die while participating in a PT, you will receive a soul penalty if you leave voluntarily.
	--ソウルペナルティ --EN:--Soul Penalty
	proxy:DeathPenalty( DeathPenalty_SoulAdjust, DeathPenalty_SoulMAX );
	
	--他の再読み込み系イベントの割り込みを防止 --EN:--Prevent interruption of other reloading events
	proxy:SetEventFlag(4047, true);
	
	proxy:NotNetMessage_begin();
		--■4046■5秒後 --EN:-- ■ 4046 ■ 5 seconds later
		proxy:OnKeyTime2( 4046, "OnLeave_Limit", 5.0, 0, 1, once );
	proxy:NotNetMessage_end();
	print("OnLeaveMenu_Yes end");
end

function LeaveMessage(proxy,param)
	print("LeaveMessage begin");
	if proxy:GetLocalPlayerId() == param:GetParam3() then
		proxy:InfomationMenu( INFOMENU_TYPE_LIST, -1, 0, -1, 1 );
		proxy:AddInfomationTosBuffer( 20000430 );
	else
		proxy:InfomationMenu( INFOMENU_TYPE_LIST, -1, 0, -1, 1 );
		proxy:AddInfomationTimeMsgTag( 20000435, TAG_IDX_leaveChara, param:GetParam3() );
	end
	print("LeaveMessage end");
end

function OnLeave_Limit(proxy,param)
	print("OnLeave_Limit begin");
	
	--イベントフラグロールバック --EN:--eventflag rollback
	proxy:SetFlagInitState(2);
	
	--召喚前の位置設定 --EN:--Position settings before summoning
	proxy:SetSummonedPos();
	
	--現在のマップと同じIDを次マップIDとして設定 --EN:--Set the same ID as the current map as the next map ID
	proxy:SetDefaultMapUid(-1);
	
	--ワープを行う --EN:--do warp
	proxy:WarpNextStageKick();

	--グレイゴースト化 --EN:--Gray ghost
	--proxy:SetChrTypeDataGrey();
	proxy:SetChrTypeDataGreyNext();

	print("OnLeave_Limit end");
end

--------------------------------------------------------------------------------------
--■非正常にネットワークが切断された(ホストがいなくなったりとか)のを通知するログ --EN:--■ A log that notifies that the network is disconnected abnormally (such as the host disappearing)
--------------------------------------------------------------------------------------
function OnRoomDisappeared(proxy,param)
	print("OnRoomDisappeared begin");
	if proxy:IsCompleteEvent( 4047 ) == true then
		return;
	end
	proxy:InfomationMenu( INFOMENU_TYPE_LIST, -1, 0, -1, 1 );
	proxy:AddInfomationTosBuffer( 20001000 );
	if proxy:IsLivePlayer() == false and proxy:IsGreyGhost() == false then
		proxy:NotNetMessage_begin();
			--■4046■5秒後 --EN:-- ■ 4046 ■ 5 seconds later
			proxy:OnKeyTime2( 4046, "OnLeave_Limit", 5.0, 0, 1, once );
			
			--他の再読み込み系イベントの割り込みを防止 --EN:--Prevent interruption of other reloading events
			proxy:SetEventFlag(4047, true);
			--イベント内部にもロード待ちである事を通知 --EN:-- Notify that it is waiting for loading inside the event
			proxy:SetLoadWait();
			--フラグのロールバック --EN:--flag rollback
			proxy:SetFlagInitState(2);
			
		proxy:NotNetMessage_end();
	end
	print("OnRoomDisappeared end");
end


--------------------------------------------------------------------------------------
--■4041■召喚通知■ --EN:-- ■ 4041 ■ summoning notification ■
--------------------------------------------------------------------------------------
--ホワイトソウルサイン用 --EN:--For White Soul Sign
function SummonInfoMsg_White(proxy,param)
	if param:IsNetMessage() == true then	
		--クライアントで無いなら　シングル　or　ホスト --EN:-- Single or host if not a client
		if	proxy:IsClient() == false then
			if proxy:EventTagInsertString_forPlayerNo( TAG_IDX_joinChara, param:GetParam3() ) == true then
				proxy:RecallMenuEvent( 0, 8830 );			
				SummonSuccess(proxy,param:GetParam3());
			else
				proxy:WARN("ゴースト名取得できなかった"); --EN:proxy:WARN("Could not get ghost name");
			end
		else
			if proxy:EventTagInsertString_forPlayerNo( TAG_IDX_joinChara, param:GetParam3() ) == true then
				proxy:RecallMenuEvent( 0, 8843 );
			else
				proxy:WARN("ホスト名取得できなかった"); --EN:proxy:WARN("Failed to get host name");
			end
		end
	else
		if proxy:EventTagInsertString_forPlayerNo( TAG_IDX_liveChara, proxy:GetHostPlayerNo() ) == true then
			proxy:RecallMenuEvent( 0, 8833 );
		end
	end
end

--ブラックソウルサイン用 --EN:--For Black Soul Sign
function SummonInfoMsg_Black(proxy,param)
	if param:IsNetMessage() == true then
		--クライアントで無いなら　シングル　or　ホスト --EN:-- Single or host if not a client
		if	proxy:IsClient() == false then
			if proxy:EventTagInsertString_forPlayerNo( TAG_IDX_joinChara, param:GetParam3() ) == true then
				proxy:RecallMenuEvent( 0, 8831 );			
				SummonSuccess(proxy,param:GetParam3());
			end
		else
			if proxy:EventTagInsertString_forPlayerNo( TAG_IDX_joinChara, param:GetParam3() ) == true then
				proxy:RecallMenuEvent( 0, 8844 );			
			end
		end
	else
		if proxy:EventTagInsertString_forPlayerNo( TAG_IDX_liveChara, proxy:GetHostPlayerNo() ) == true then
			proxy:RecallMenuEvent( 0, 8834 );		
		end
	end
end

--強制参加(乱入)用 --EN:--For forced participation (intrusion)
function SummonInfoMsg_ForceJoinBlack(proxy,param)
	if param:IsNetMessage() == true then
		--クライアントで無いなら　シングル　or　ホスト --EN:-- Single or host if not a client
		if	proxy:IsClient() == false then
			if proxy:EventTagInsertString_forPlayerNo( TAG_IDX_joinChara, param:GetParam3() ) == true then
				proxy:RecallMenuEvent( 1, 8832 );			
				SummonSuccess(proxy,param:GetParam3());
			end
		--第三者 --EN:--third party
		else
			if proxy:EventTagInsertString_forPlayerNo( TAG_IDX_joinChara, param:GetParam3() ) == true then
				proxy:RecallMenuEvent( 1, 8845 );			
			end
		end
	else
		if proxy:EventTagInsertString_forPlayerNo( TAG_IDX_liveChara, proxy:GetHostPlayerNo() ) == true then
			proxy:RecallMenuEvent( 1, 8835 );		
		end
	end
end

--強制召喚用 --EN:--For forced summoning
function SummonInfoMsg_ForceSummonBlack(proxy,param)
	if param:IsNetMessage() == true then
		--クライアントで無いなら　シングル　or　ホスト --EN:-- Single or host if not a client
		if	proxy:IsClient() == false then
			if proxy:EventTagInsertString_forPlayerNo( TAG_IDX_joinChara, param:GetParam3() ) == true then
				proxy:RecallMenuEvent( 1, 8846 );
				SummonSuccess(proxy,param:GetParam3());
			end
			
		else
			if proxy:EventTagInsertString_forPlayerNo( TAG_IDX_joinChara, param:GetParam3() ) == true then
				proxy:RecallMenuEvent( 1, 8846 );			
			end
		end
	else
		if proxy:EventTagInsertString_forPlayerNo( TAG_IDX_liveChara, proxy:GetHostPlayerNo() ) == true then
			proxy:RecallMenuEvent( 1, 8836 );		
		end
	end
end

function SummonSuccess(proxy, playerId)
	proxy:SummonSuccess(playerId);
end




--------------------------------------------------------------------------------------
--■ネットプレイヤ召喚のタイムアウト(つまり生存側) --EN:--■ Net player summoning timeout (that is, surviving side)
--------------------------------------------------------------------------------------
function LiveSide_SummonTimeOut(proxy,param)
	print("LiveSide_SummonTimeOut begin");
	proxy:InfomationMenu( INFOMENU_TYPE_LIST, -1, 0, -1, 1 );
	proxy:AddInfomationTosBuffer( 20000100 );
	print("LiveSide_SummonTimeOut end");
end

--------------------------------------------------------------------------------------
--■4045■ボス部屋への魔法壁が通過可能であると通知(クライアントに対して)■ --EN:--■ 4045 ■ Notify the client that the magic wall to the boss room can be passed ■
--------------------------------------------------------------------------------------

function PossibleInfo_GoToTheBossArea(proxy, param)
	print("PossibleInfo_GoToTheBossArea begin");
	
	--生存状態の人がボス部屋前障壁を通過しおわったときにコールされる --EN:--Called when a living person has passed through the barrier in front of the boss room.
	
	if param:IsNetMessage() == true then --配信で受け取った人は クライアント		 --EN:--The person who received the delivery is the client
		--強制召喚以外のゴースト		 --EN:-- Ghosts other than forced summons
		if		proxy:GetTempSummonParam() == -1 then
			--ホワイトにボス部屋通知 --EN:--Boss room notification to white
			--proxy:ShowGenDialog(10010700,1,1,true);
			proxy:RecallMenuEvent( 0, 9500 );
		elseif 	proxy:GetTempSummonParam() == -2 then
			--通常ブラックに失敗通知 --EN:--Normal failure notification in black
			--Failed_BossAreaMission(proxy,param);
		elseif 	proxy:GetTempSummonParam() == -3 then
			--乱入ブラックに失敗通知 --EN:-- Failure notification to intrusion black
			--Failed_BossAreaMission(proxy,param);
		end
		
	else --配信以外でこのハンドラが呼ばれたときは、呼んだ本人のとき --EN:--When this handler is called for something other than delivery, the person who called it
		print("クライアントへボス部屋に入れるようになったと通知しました"); --EN:print("I notified the client that I can now enter the boss room");
	end	
	print("PossibleInfo_GoToTheBossArea end");
end

function Failed_BossArea(proxy,param)
	print("Failed_BossArea begin");
	--生存状態の人がボス部屋前障壁を調べたときにコールされる	 --EN:--Called when a living person examines the barrier in front of the boss room
	if param:IsNetMessage() == true then --配信で受け取った人は クライアント --EN:--The person who received the delivery is the client
		--強制召喚以外のゴースト		 --EN:-- Ghosts other than forced summons
		if		proxy:GetTempSummonParam() == -1 then
			--何もしない --EN:--do nothing
		elseif 	proxy:GetTempSummonParam() == -2 then
			--通常ブラックに失敗通知 --EN:--Normal failure notification in black
			Failed_BossAreaMission(proxy,param);
		elseif 	proxy:GetTempSummonParam() == -3 then
			--乱入ブラックに失敗通知 --EN:-- Failure notification to intrusion black
			Failed_BossAreaMission(proxy,param);
		end
		
	else --配信以外でこのハンドラが呼ばれたときは、呼んだ本人のとき --EN:--When this handler is called for something other than delivery, the person who called it
		print("ボス部屋阻止失敗を通知しました"); --EN:print("Notified failure to block boss room");
	end	
	print("Failed_BossArea end");
end

function Failed_BossAreaMission(proxy,param)
	print("Failed_BossAreaMission begin");
	if proxy:IsCompleteEvent(4047) == false then
		--ボスゲージをクリア --EN:--clear the boss gauge
		proxy:ClearBossGauge();	
		--自分のプレイヤーIDを配信してゲーム的に抜ける事を通知 --EN:--Distribute your player ID and notify that you are leaving the game
		--proxy:CustomLuaCallStart( 4063 , proxy:GetLocalPlayerId() );
		--目標失敗 --EN:--Target failed
		MissionFailed(proxy,param);		
		--他の再読み込み系イベントの割り込みを防止 --EN:--Prevent interruption of other reloading events
		proxy:SetEventFlag(4047, true);
		--イベント内部にもロード待ちである事を通知 --EN:-- Notify that it is waiting for loading inside the event
		proxy:SetLoadWait();
		--死亡が挟まってややこしくならない様にする --EN:--Don't let death get in the way of complications
		proxy:SetEventFlag( 4000, true );
		--黒が評価に含まれるので先に抜ける --EN:-- Black is included in the evaluation, so exit first
		proxy:LeaveSession()
		
		proxy:NotNetMessage_begin();
			--2秒後にはルームから抜ける --EN:--Exit the room after 2 seconds
			--proxy:OnKeyTime2( 4045 , "Failed_BossAreaMission_LeavePT",2.0,0,0,once);
			--5秒後には再ロード --EN:-- reload after 5 seconds
			proxy:OnKeyTime2( 4045 , "Failed_BossAreaMission_LeaveMap",5.0,0,0,once);
		proxy:NotNetMessage_end();
		--自世界アニメ処理	 --EN:--Own world animation processing
		if 	proxy:IsBlackGhost() == true then
			proxy:RepeatMessage_begin();
			proxy:NotNetMessage_begin();
				--アニメ再生の為の自キャラ監視 --EN:--Monitoring your character for animation playback
				proxy:OnRegistFunc( 4050 , "Check_BlockClearAnim","BlockClearAnim",20,once);
			proxy:NotNetMessage_end();
			proxy:RepeatMessage_end();		
		end
	end
	print("Failed_BossAreaMission end");
end

function Failed_BossAreaMission_LeavePT(proxy,param)
	print("Failed_BossAreaMission_LeavePT begin");
	--黒が評価に含まれるので先に抜ける --EN:-- Black is included in the evaluation, so exit first
	proxy:LeaveSession();
	print("Failed_BossAreaMission_LeavePT end");
end

function Failed_BossAreaMission_LeaveMap(proxy,param)
	print("Failed_BossAreaMission_LeaveMap begin");
	--ソウルペナルティ --EN:--Soul Penalty
	proxy:DeathPenalty( DeathPenalty_SoulAdjust, DeathPenalty_SoulMAX );
	--イベントフラグロールバック --EN:--eventflag rollback
	proxy:SetFlagInitState(2);
	--召喚前の位置設定 --EN:--Position settings before summoning
	proxy:SetSummonedPos();			
	--現在のマップと同じIDを次マップIDとして設定 --EN:--Set the same ID as the current map as the next map ID
	proxy:SetDefaultMapUid(-1);
	--ワープを行う --EN:--do warp
	proxy:WarpNextStageKick();
	--グレイゴースト化 --EN:--Gray ghost
	--proxy:SetChrTypeDataGrey();
	proxy:SetChrTypeDataGreyNext();
	print("Failed_BossAreaMission_LeaveMap end");
end

--------------------------------------------------------------------------------------
--■4034■マルチ時魔法壁用(セッションがつながった)■ --EN:-- ■ 4034 ■ For multi-time magic wall (session connected) ■
--------------------------------------------------------------------------------------
function OnEvent_4034(proxy, param)
	print("OnEvent_4034 begin");
	
	if proxy:IsClient() == false then
		if proxy:GetBlockId() > 0 then
			print("マルチ時魔法壁ON BlockId ",proxy:GetBlockId() ); --EN:print("Magic wall ON when multiplayer BlockId",proxy:GetBlockId() );
			local MultiWall = 1995 - proxy:GetBlockId() + 1;
			Lua_MultiWall(proxy,MultiWall);
			proxy:SetEventFlag( 3000 + proxy:GetBlockId() , true );
		else
			print("ブロック0なので魔法壁処理スルーします"); --EN:print("Because it is block 0, the magic wall processing will be bypassed");
		end
	else--クライアント --EN:--client
		if proxy:IsCompleteEvent( 3001 ) == true then
			Lua_MultiWall(proxy,1995);
		elseif proxy:IsCompleteEvent( 3002 ) == true then
			Lua_MultiWall(proxy,1994);
		elseif proxy:IsCompleteEvent( 3003 ) == true then
			Lua_MultiWall(proxy,1993);
		else
			print("クライアント ブロック0無視") --EN:print("Ignore client block 0")
		end		
	end
	
	print("ポリ劇定数マルチ変更"); --EN:print("polydramatic constant multi change");
	REMO_FLAG = 2;
	
	print("OnEvent_4034 end");
end

--マルチ壁関数 --EN:--Multi wall function
function Lua_MultiWall(proxy,id)
	print("マルチ時魔法壁ON");	 --EN:print("Magic wall ON when multiplayer");
	local MultiSfx = id - 8;
	print("マルチ壁ID: ",id); --EN:print("Multi Wall ID: ",id);
	print("マルチ壁SFX　ID:",MultiSfx); --EN:print("Multi Wall SFX ID:", MultiSfx);
	proxy:SetColiEnable( id, true );
	proxy:SetDrawEnable( id, true );	
	proxy:ValidSfx( MultiSfx );
end

--------------------------------------------------------------------------------------
--■4035■マルチ時魔法壁用(セッションがつながっているときから切れた)■ --EN:-- ■ 4035 ■ For magic wall when multi-session (disconnected from the time the session was connected) ■
--------------------------------------------------------------------------------------
function OnEvent_4035(proxy, param)
	print("OnEvent_4035 begin");
	
	proxy:SetEventFlag( 3001,false);
	proxy:SetEventFlag( 3002,false);
	proxy:SetEventFlag( 3003,false);
	
	if proxy:GetBlockId() > 0 then	
		print("マルチ時魔法壁OFF BlockId ",proxy:GetBlockId() ); --EN:print("Magic Wall OFF BlockId when multiplayer",proxy:GetBlockId() );
		local MultiWall = 1995 - proxy:GetBlockId() + 1;
		local MultiSfx = MultiWall - 8;
		print("マルチ壁ID: ",MultiWall); --EN:print("MultiWall ID: ",MultiWall);
		print("マルチ壁SFX　ID:",MultiSfx); --EN:print("Multi Wall SFX ID:", MultiSfx);
		proxy:SetColiEnable( MultiWall, false );
		proxy:SetDrawEnable( MultiWall, false );
		proxy:InvalidSfx( MultiSfx ,true);
	else
		print("ブロック0なので魔法壁処理スルーします"); --EN:print("Because it is block 0, the magic wall processing will be bypassed");
	end
		
	print("ポリ劇定数シングル変更"); --EN:print("polydramatic constant single change");
	REMO_FLAG = 0;
	
	print("OnEvent_4035 end");
end

function WhiteReviveCount(proxy,param)
	print("WhiteReviveCount begin");
	--クライアントで無いなら　シングル　or　ホスト --EN:-- Single or host if not a client
	if	proxy:IsClient() == false then
		print("WhiteReviveCount AddQWC AddHelpWhiteCount");
		--ここでホワイト復活カウント加算処理を追加 --EN:-- Add white resurrection count addition processing here
		proxy:LuaCallStartPlus( 4056, 1, 200 );--AddQWC配信(ホワイトを復活させたQWC加算) --EN:--AddQWC distribution (QWC addition that revived white)
		proxy:AddHelpWhiteGhost();--助けたホワイトの数を加算 --EN:--add the number of whites helped
	end
	print("WhiteReviveCount end");
end

--------------------------------------------------------------------------------------
--■NPC状態関連（取得・設定） --EN:--■ NPC status related (get/set)
--------------------------------------------------------------------------------------
--渡したリストから初期化(1つもフラグが立っていない場合は指定した初期フラグを立てる) --EN:--Initialize from the passed list (set the specified initial flag if no flag is set)
function SetFirstNpcStateFlag(proxy, param, state_list, set_flag )	
	--フラグが1つでも立っているか？ --EN:--Is even one flag set?
	local nowflag = GetNpcStateFlag(proxy,param,state_list);
	if nowflag ~= 0 then
		print("SetFirstNpcStateFlag Now to ", nowflag );
		return;
	end
	print("SetFirstNpcStateFlag Initialize set to ", set_flag );
	proxy:SetEventFlag( set_flag, true );
end

--渡したリストからセット --EN:--set from passed list
function SetNpcStateFlag(proxy, param, state_list, set_flag )
	print("SetNpcStateFlag begin set to ", set_flag );
	
	--現在のたっているフラグを取得 --EN:-- Get current flag
	local now_state = GetNpcStateFlag(proxy,param,state_list);
	
	--現在の状態とセットしたい状態が違う時 --EN:--When the current state and the state you want to set are different
	if now_state ~= set_flag then
		--リストにセットしたいアクションIDが登録されていた場合、 --EN:--If the action ID you want to set is registered in the list,
		--現在の状態フラグを下ろし、新たに状態フラグをセットする --EN:--unset the current state flag and set the new state flag
		local flag_num = table.getn( state_list );
		for i=1, flag_num , 1 do
			if state_list[i] == set_flag then
				proxy:SetEventFlag( set_flag, true );
				proxy:SetEventFlag( now_state, false );
			end
		end
	end
end

--渡したリストからフラグが立っているアクションIDを取得 --EN:--Get flagged action IDs from the passed list
function GetNpcStateFlag(proxy, param, state_list)

	--要素数を取得 --EN:-- get number of elements
	local flag_num = table.getn( state_list );
	
	
	for i=1, flag_num , 1 do
		if proxy:IsCompleteEvent( state_list[i] ) == true then
			return state_list[i];
		end
	end
	return 0;
end


--------------------------------------------------------------------------------------
--■レンドル王子関連イベントで利用する関数 --EN:--Functions used in events related to Prince Lendl
--------------------------------------------------------------------------------------

--▼一番最初に王城1にきたときの状態セット用(王城1のInitializeで呼ぶ) --EN:--▼ For setting the state when you first come to the castle 1 (call it in Initialize of the castle 1)
function SetFirstRendolState( proxy , param )
	
	--▽王子の状態が未設定のとき 初期状態をセット --EN:--▽When the state of the prince is not set Set the initial state
	
	if GetRendolState(proxy , param) ~= 0 then
		return false;
	end
	
	--奴隷兵士助けて状態に遷移を試みる --EN:--Help the slave soldier and try to transition to the state
	return ( SetRendolStateFlag( proxy, param, RENDOL_STATE_HELP_FOR_DOREI_HEISI , possible_transration_list_m02_00_00_00 ) );
	
end
	
	
--▼レンドル王子の現在の状態を取得 --EN:--▼ Get Prince Lendl's current status
function GetRendolState( proxy , param )
	
	local state_flag_num = 0;
	state_flag_num = table.getn(possible_transration_list_m02_00_00_00);--王城1のフラグ数 --EN:-- Number of flags in Royal Castle 1
	
	for i=1, state_flag_num, 1 do
		local look_state = possible_transration_list_m02_00_00_00[i];
		if proxy:IsCompleteEvent( look_state ) == true then
--			print("レンドル王子の状態フラグは["..look_state.."]です"); --EN:-- print("Prince Lendl's state flag is ["..look_state.."]");
			return look_state;
		end
	end
	
	state_flag_num = table.getn(possible_transration_list_m02_01_00_00);--王城2のフラグ数 --EN:-- Number of flags in Ojo 2
	
	for i=1, state_flag_num, 1 do
		local look_state = possible_transration_list_m02_01_00_00[i];
		if proxy:IsCompleteEvent( look_state ) == true then
--			print("レンドル王子の状態フラグは["..look_state.."]です"); --EN:-- print("Prince Lendl's state flag is ["..look_state.."]");
			return look_state;
		end
	end
	
	state_flag_num = table.getn(possible_transration_list_m02_02_00_00);--王城3のフラグ数 --EN:-- number of flags in royal castle 3

	for i=1, state_flag_num, 1 do
		local look_state = possible_transration_list_m02_02_00_00[i];
		if proxy:IsCompleteEvent( look_state ) == true then
--			print("レンドル王子の状態フラグは["..look_state.."]です"); --EN:-- print("Prince Lendl's state flag is ["..look_state.."]");
			return look_state;
		end
	end
	
	state_flag_num = table.getn(possible_transration_list_m02_03_00_00);--王城4のフラグ数 --EN:-- Number of flags in Ojo 4

	for i=1, state_flag_num, 1 do
		local look_state = possible_transration_list_m02_03_00_00[i];
		if proxy:IsCompleteEvent( look_state ) == true then
--			print("レンドル王子の状態フラグは["..look_state.."]です"); --EN:-- print("Prince Lendl's state flag is ["..look_state.."]");
			return look_state;
		end
	end
	
--	print("セットされている状態フラグが見つかりませんでした"); --EN:-- print("Could not find any set state flags");
	return 0;
end

-----------------------------------------------------------------------------
--各種ボスの死亡数判定 --EN:--Determine the number of deaths of various bosses
-----------------------------------------------------------------------------
function GetBossFlagCount( proxy , param )
	
	--変数定義 --EN:--Variable definition
	boss_flagCount = 0;		 	--ボスのソウル入手した数 --EN:--Number of Boss Souls Obtained
	block_boss_flagCount = 0;	--ブロックボスのソウル入手した数 --EN:-- Number of block boss souls obtained
	area_boss_flagCount = 0;	--エリアボスのソウル入手した数 --EN:--Number of area boss souls obtained
	
	
	--各ボスを倒しているフラグの数を取得 --EN:--get number of flags killing each boss
	local boss_actionId_list = {4096, 4224, 4360, 4480,	--王城 --EN:--Royal Castle
								5123, 5251, 5380,		--牢城 --EN:--prison castle
								5650, 5770, 5888,		--不浄 --EN:--unclean
								4756, 4895, 4992,		--古砦 --EN:--Old Fort
								6174, 6272, 6400 };		--坑道 --EN:--Tunnel
	local boss_actIdNum = table.getn(boss_actionId_list);
	for index = 1, boss_actIdNum, 1 do
		if proxy:IsCompleteEvent( boss_actionId_list[index] ) == true then
			boss_flagCount = boss_flagCount + 1;
		end
	end

	--ブロックボスを倒しているフラグの数を取得 --EN:-- Get the number of flags killing block bosses
	local block_boss_actionId_list = {4096, 4224, 4360,	--王城1.2.3ソウル取得 --EN:-- Acquired Ojo 1.2.3 Seoul
									  5123, 5251,		--牢城1.2ソウル取得 --EN:--Get 1.2 Seoul
									  5650, 5770,		--不浄1.2ソウル取得 --EN:--Acquire 1.2 Unholy souls
									  4756, 4895,		--古砦1.2ソウル取得 --EN:--Obtain 1.2 souls of the old fortress
									  6174, 6272 };		--坑道1.2ソウル取得 --EN:--Tunnel 1.2 Seoul Acquisition
	local block_boss_actIdNum = table.getn(block_boss_actionId_list);
	for index = 1, block_boss_actIdNum, 1 do
		if proxy:IsCompleteEvent( block_boss_actionId_list[index] ) == true then
			block_boss_flagCount = block_boss_flagCount + 1;
		end
	end
	
	--エリアボスを倒しているフラグの数を取得 --EN:-- Get the number of flags defeating area bosses
	local area_boss_actionId_list = {4480,		--王城4ソウル取得 --EN:-- Acquire Ojo 4 Soul
									 5380,		--牢城3ソウル取得 --EN:--Obtain Prison 3 Soul
									 5888,		--不浄3ソウル取得 --EN:--Obtain 3 unclean souls
									 4992,		--古砦3ソウル取得 --EN:--Obtain 3 Seoul fortress
									 6400 };	--坑道3ソウル取得 --EN:--Obtain Tunnel 3 Seoul
	local area_boss_actIdNum = table.getn(area_boss_actionId_list);
	for index = 1, area_boss_actIdNum, 1 do
		if proxy:IsCompleteEvent( area_boss_actionId_list[index] ) == true then
			area_boss_flagCount = area_boss_flagCount + 1;
		end
	end
	
--[[ボスソウル取得数関連]] --EN:--[[Boss soul acquisition number related]]
	--■ 8067 ■ボスソウル数「1」■ --EN:--■ 8067 ■ Number of Boss Souls "1" ■
	if boss_flagCount == 1 then
		--条件を満たしたので、フラグをON --EN:--The conditions are met, so the flag is turned on
		proxy:SetEventFlag(8067, true);
	end	
	--■ 8068 ■ボスソウル数「2」■ --EN:--■ 8068 ■ Number of Boss Souls "2" ■
	if boss_flagCount == 2 then
		--条件を満たしたので、フラグをON --EN:--The conditions are met, so the flag is turned on
		proxy:SetEventFlag(8068, true);
	end
	--■ 8069 ■ボスソウル数「3」■ --EN:--■ 8069 ■ Number of Boss Souls "3" ■
	if boss_flagCount == 3 then
		--条件を満たしたので、フラグをON --EN:--The conditions are met, so the flag is turned on
		proxy:SetEventFlag(8069, true);
	end	
	--■ 8070 ■ボスソウル数「4」■ --EN:--■ 8070 ■ Number of Boss Souls "4" ■
	if boss_flagCount == 4 then
		--条件を満たしたので、フラグをON --EN:--The conditions are met, so the flag is turned on
		proxy:SetEventFlag(8070, true);
	end
	--■ 8071 ■ボスソウル数「5] ■ --EN:--■ 8071 ■ Number of Boss Souls "5" ■
	if boss_flagCount == 5 then
		--条件を満たしたので、フラグをON --EN:--The conditions are met, so the flag is turned on
		proxy:SetEventFlag(8071, true);
	end	
	--■ 8072 ■ボスソウル数「6」■ --EN:--■ 8072 ■ Number of Boss Souls "6" ■
	if boss_flagCount == 6 then
		--条件を満たしたので、フラグをON --EN:--The conditions are met, so the flag is turned on
		proxy:SetEventFlag(8072, true);
	end
	--■ 8073 ■ボスソウル数「7」■ --EN:--■ 8073 ■ Number of Boss Souls "7" ■
	if boss_flagCount == 7 then
		--条件を満たしたので、フラグをON --EN:--The conditions are met, so the flag is turned on
		proxy:SetEventFlag(8073, true);
	end
	--■ 8074 ■ボスソウル数「8」■ --EN:--■ 8074 ■ Number of Boss Souls "8" ■
	if boss_flagCount == 8 then
		--条件を満たしたので、フラグをON --EN:--The conditions are met, so the flag is turned on
		proxy:SetEventFlag(8074, true);
	end
	--■ 8075 ■ボスソウル数「9」■ --EN:--■ 8075 ■ Number of Boss Souls "9" ■
	if boss_flagCount == 9 then
		--条件を満たしたので、フラグをON --EN:--The conditions are met, so the flag is turned on
		proxy:SetEventFlag(8075, true);
	end
	--■ 8076 ■ボスソウル数「10」■ --EN:--■ 8076 ■ Number of Boss Souls "10" ■
	if boss_flagCount == 10 then
		--条件を満たしたので、フラグをON --EN:--The conditions are met, so the flag is turned on
		proxy:SetEventFlag(8076, true);
	end
	--■ 8077 ■ボスソウル数「11] ■ --EN:--■ 8077 ■ Number of Boss Souls "11" ■
	if boss_flagCount == 11 then
		--条件を満たしたので、フラグをON --EN:--The conditions are met, so the flag is turned on
		proxy:SetEventFlag(8077, true);
	end	
	--■ 8078 ■ボスソウル数「12」■ --EN:--■ 8078 ■ Number of Boss Souls "12" ■
	if boss_flagCount == 12 then
		--条件を満たしたので、フラグをON --EN:--The conditions are met, so the flag is turned on
		proxy:SetEventFlag(8078, true);
	end
	--■ 8079 ■ボスソウル数「13」■ --EN:--■ 8079 ■ Number of Boss Souls "13" ■
	if boss_flagCount == 13 then
		--条件を満たしたので、フラグをON --EN:--The conditions are met, so the flag is turned on
		proxy:SetEventFlag(8079, true);
	end
	--■ 8080 ■ボスソウル数「14」■ --EN:--■ 8080 ■ Number of Boss Souls "14" ■
	if boss_flagCount == 14 then
		--条件を満たしたので、フラグをON --EN:--The conditions are met, so the flag is turned on
		proxy:SetEventFlag(8080, true);
	end
	--■ 8081 ■ボスソウル数「15」■ --EN:--■ 8081 ■ Number of Boss Souls "15" ■
	if boss_flagCount == 15 then
		--条件を満たしたので、フラグをON --EN:--The conditions are met, so the flag is turned on
		proxy:SetEventFlag(8081, true);
	end	
	--■ 8082 ■ボスソウル数「16」■ --EN:--■ 8082 ■ Number of Boss Souls "16" ■
	if boss_flagCount == 16 then
		--条件を満たしたので、フラグをON --EN:--The conditions are met, so the flag is turned on
		proxy:SetEventFlag(8082, true);
	end
	
--[[ブロックボスソウル取得数関連]] --EN:--[[Number of Block Boss Soul Acquisition Related]]
	--■ 8056 ■ブロックボス撃破数「1」■ --EN:--■ 8056 ■ Number of block bosses defeated "1" ■
	if block_boss_flagCount == 1 then
		--条件を満たしたので、フラグをON --EN:--The conditions are met, so the flag is turned on
		proxy:SetEventFlag(8056, true);
	end	
	--■ 8057 ■ブロックボス撃破数「2」■ --EN:--■ 8057 ■ Number of block bosses defeated "2" ■
	if block_boss_flagCount == 2 then
		--条件を満たしたので、フラグをON --EN:--The conditions are met, so the flag is turned on
		proxy:SetEventFlag(8057, true);
	end
	--■ 8058 ■ブロックボス撃破数「3」■ --EN:--■ 8058 ■ Number of block bosses defeated "3" ■
	if block_boss_flagCount == 3 then
		--条件を満たしたので、フラグをON --EN:--The conditions are met, so the flag is turned on
		proxy:SetEventFlag(8058, true);
	end	
	--■ 8059 ■ブロックボス撃破数「4」■ --EN:--■ 8059 ■ Number of block bosses defeated "4" ■
	if block_boss_flagCount == 4 then
		--条件を満たしたので、フラグをON --EN:--The conditions are met, so the flag is turned on
		proxy:SetEventFlag(8059, true);
	end
	--■ 8060 ■ブロックボス撃破数「5」■ --EN:--■ 8060 ■ Number of block bosses defeated "5" ■
	if block_boss_flagCount == 5 then
		--条件を満たしたので、フラグをON --EN:--The conditions are met, so the flag is turned on
		proxy:SetEventFlag(8060, true);
	end
	--■ 8061 ■ブロックボス撃破数「6」■ --EN:--■ 8061 ■ Number of block bosses defeated "6" ■
	if block_boss_flagCount == 6 then
		--条件を満たしたので、フラグをON --EN:--The conditions are met, so the flag is turned on
		proxy:SetEventFlag(8061, true);
	end	
	--■ 8062 ■ブロックボス撃破数「7」■ --EN:--■ 8062 ■ Number of block bosses defeated "7" ■
	if block_boss_flagCount == 7 then
		--条件を満たしたので、フラグをON --EN:--The conditions are met, so the flag is turned on
		proxy:SetEventFlag(8062, true);
	end	
	--■ 8063 ■ブロックボス撃破数「8」■ --EN:--■ 8063 ■ Number of block bosses defeated "8" ■
	if block_boss_flagCount == 8 then
		--条件を満たしたので、フラグをON --EN:--The conditions are met, so the flag is turned on
		proxy:SetEventFlag(8063, true);
	end	
	--■ 8064 ■ブロックボス撃破数「9」■ --EN:--■ 8064 ■ Number of block bosses defeated "9" ■
	if block_boss_flagCount == 9 then
		--条件を満たしたので、フラグをON --EN:--The conditions are met, so the flag is turned on
		proxy:SetEventFlag(8064, true);
	end	
	--■ 8065 ■ブロックボス撃破数「10」■ --EN:--■ 8065 ■ Number of block bosses defeated "10" ■
	if block_boss_flagCount == 10 then
		--条件を満たしたので、フラグをON --EN:--The conditions are met, so the flag is turned on
		proxy:SetEventFlag(8065, true);
	end	
	--■ 8066 ■ブロックボス撃破数「11」■ --EN:--■ 8066 ■ Number of block bosses defeated "11" ■
	if block_boss_flagCount >= 11 then
		--条件を満たしたので、フラグをON --EN:--The conditions are met, so the flag is turned on
		proxy:SetEventFlag(8066, true);
	end
	
--[[エリアボスソウル取得数関連]] --EN:--[[Area Boss Soul Acquisition Number Related]]
	--■ 8050 ■エリアボス撃破数「1」■ --EN:--■ 8050 ■Number of area bosses defeated "1"■
	if area_boss_flagCount == 1 then
		--条件を満たしたので、フラグをON --EN:--The conditions are met, so the flag is turned on
		proxy:SetEventFlag(8050, true);
	end	
	--■ 8051 ■エリアボス撃破数「2」■ --EN:--■ 8051 ■Number of area bosses defeated "2"■
	if area_boss_flagCount == 2 then
		--条件を満たしたので、フラグをON --EN:--The conditions are met, so the flag is turned on
		proxy:SetEventFlag(8051, true);
	end
	--■ 8052 ■エリアボス撃破数「3」■ --EN:--■ 8052 ■Number of area bosses defeated "3"■
	if area_boss_flagCount == 3 then
		--条件を満たしたので、フラグをON --EN:--The conditions are met, so the flag is turned on
		proxy:SetEventFlag(8052, true);
	end	
	--■ 8053 ■エリアボス撃破数「4」■ --EN:--■ 8053 ■ Number of area bosses defeated "4" ■
	if area_boss_flagCount == 4 then
		--条件を満たしたので、フラグをON --EN:--The conditions are met, so the flag is turned on
		proxy:SetEventFlag(8053, true);
	end	
	--■ 8054 ■エリアボス撃破数「5」■ --EN:--■ 8054 ■Number of area bosses defeated "5"■
	if area_boss_flagCount >= 5 then
		--条件を満たしたので、フラグをON --EN:--The conditions are met, so the flag is turned on
		proxy:SetEventFlag(8054, true);
	end
	
end

--[[更新メソッドラッパー☆LuaFunc_NoOmission]] --EN:--[[Update method wrapper☆LuaFunc_NoOmission]]
--[[キャラを完全に更新しなくなります]] --EN:--[[Character will not be updated completely]]
--[[
	proxy 	        	… イベントプロクシ	 --EN:proxy … event proxy
	who					…誰 --EN:who
	LuaFunc_NormalOmissionで元に戻すのを忘れないで下さい。 --EN:Don't forget to restore it with LuaFunc_NormalOmission.
]]
function LuaFunc_NoOmission(proxy,who)
	proxy:ForceSetOmissionLevel(who,true,-1);
end

--[[更新メソッドラッパー☆LuaFunc_NormalOmission]] --EN:--[[Update method wrapper☆LuaFunc_NormalOmission]]
--[[キャラを通常更新します]] --EN:--[[Update character normally]]
--[[
	proxy 	        	… イベントプロクシ	 --EN:proxy … event proxy
	who					…誰 --EN:who
]]
function LuaFunc_NormalOmission(proxy,who)
	proxy:ForceSetOmissionLevel(who,false,0);
end

--[[更新メソッドラッパー☆LuaFunc_ForceOmission]] --EN:--[[Update method wrapper☆LuaFunc_ForceOmission]]
--[[キャラを完全更新します]] --EN:--[[Completely update the character]]
--[[
	proxy 	        	… イベントプロクシ	 --EN:proxy … event proxy
	who					…誰 --EN:who
	LuaFunc_NormalOmissionで元に戻すのを忘れないで下さい。 --EN:Don't forget to restore it with LuaFunc_NormalOmission.
]]
function LuaFunc_ForceOmission(proxy,who)
	proxy:ForceSetOmissionLevel(who,true,0);
end


--[[二段破壊☆SecondStageBreak]] --EN:--[[Second Stage Break☆SecondStageBreak]]
--[[2段階破壊のルートマトリクス移動、モデル差し替え、初速度設定、破片設定をラッピング]] --EN:--[[Two-stage destruction root matrix movement, model replacement, initial velocity setting, wrapping fragment setting]]
--[[
	proxy 	        	… イベントプロクシ	 --EN:proxy … event proxy
	who					…誰 --EN:who
	model				…差し替えるモデル --EN:model …Replacement model
]]
function SecondStageBreak(proxy,who,model)
	--マスターの位置、角度にダミポリの位置、角度を設定 --EN:--Set the position and angle of Damipoly to the position and angle of the master
	--ダミポリを使うのでモデル差し替えなどのタイミングに注意!! --EN:--Since Damipoly is used, pay attention to the timing of model replacement!
	--差し替えた後のモデルに指定IDのダミポリが無い場合保障できません。) --EN:--We cannot guarantee if the model after replacement does not have the dummy poly with the specified ID. )
	proxy:ObjRootMtxMove(who);
	
	--モデルを差し替える --EN:--replace model
	proxy:ChangeModel( who, model);
	
	--初速度を設定（主にばらけさせる為） --EN:--Set the initial speed (mainly for dispersion)
	proxy:SetFirstSpeed(who);

	--オブジェクトを破片にしてあたり判定を消す --EN:--Eliminate the hit judgment by breaking the object into pieces
	proxy:SetBrokenPiece(who);
end



--[[ボス部屋の処理を統一する為、テスト中です。 ]] --EN:--[[We are testing to unify the processing of the boss room. ]]
--[[今は4月22日ですが、5月になってもこのコメントが残っている場合は、 --EN:--[[It's now April 22nd, but if this comment is still there in May,
　　有無を言わさず消してください。伊藤豊]] --EN:Please erase it without saying yes or no. Yutaka Ito]]

--[[ボス部屋イベント☆BossRoomIn]] --EN:--[[Boss Room Event☆BossRoomIn]]
--[[ボス部屋に入るイベントをまとめて登録]] --EN:--[[Register all events to enter the boss room]]
--[[
	proxy 	        	…イベントプロキシ	 --EN:proxy … event proxy
	BossID				…ボス死亡のアクションID --EN:BossID … Action ID for boss death
	FirstIn				…最初にホストが入る際のアクションID --EN:FirstIn … Action ID when the host first enters
	SecondIn			…2回目以降のボス部屋に入るアクションID --EN:SecondIn … Action ID to enter the boss room after the second time
	RegionID			…アクションボタン判定用の領域のイベントID --EN:RegionID … Event ID of the region for action button judgment
]]
--[[
function BossRoomIn(proxy,param)
	print("BossRoomIn begin");
	local FirstIn = param:GetParam1();
	local SecondIn = param:GetParam1() + 1;
	local BossID	= param:GetParam3();
	if proxy:IsCompleteEvent( param:GetParam3() ) == false then
		--▽同期アニメ再生用の開始ハンドラ(旋回→歩き) --EN:--▽ Start handler for synchronous animation playback (turning → walking)
		proxy:LuaCall( FirstIn + 1, 1, "OnEvent_SynchroTurn", everytime );
		--▽2回目以降にボス部屋に入るためのイベント配信用 --EN:--▽For event delivery to enter the boss room after the second time
		proxy:LuaCall( param:GetParam1(), 5 , "OnEvent_"..FirstIn.."_GO_TO_IN" , everytime );
		--▽フラグセット(同期用) --EN:--▽flag set (for synchronization)
		proxy:LuaCall( param:GetParam1(), 6 , "OnEvent_"..FirstIn.."_flag_set" , everytime );
		
		--誰かがボス前扉をまだ通過していない --EN:--Someone hasn't passed through the boss front door yet
		if proxy:IsCompleteEvent( param:GetParam1() ) == false then
		
			--(セッション中に)ボス前の魔法壁を最初に通れるのは生存の人だけ --EN:--(During the session) Only survivors can pass through the magic wall in front of the boss first
			local possible_chr_type = ATTR_HOST + ATTR_LIVE + ATTR_GREY;
			
			proxy:NotNetMessage_begin();
				--▼FirstIn▼中に入るためのイベントを追加▼ --EN:--▼FirstIn▼Add an event to go inside▼
				proxy:OnPlayerActionInRegionAttribute( param:GetParam1(), 2891 - param:GetParam2(), "OnEvent_"..FirstIn, HELPID_GO_TO_IN, possible_chr_type, once );
			proxy:NotNetMessage_end();
			
		else --グレイゴーストできたときようにいると思われる。 --EN:--Gray ghost seems to be like that when it's done.
		
			proxy:NotNetMessage_begin();
				--▼SecondIn▼中に入るためのイベントを追加▼--ハンドラは上と同じ --EN:--▼SecondIn▼Add an event to enter inside▼--The handler is the same as above
				proxy:OnPlayerActionInRegion( param:GetParam1() + 1, 2891 - param:GetParam2(), "OnEvent_"..FirstIn, HELPID_GO_TO_IN, everytime );
			proxy:NotNetMessage_end();
		end
	end
	print("BossRoomIn end");
end

function BossRoomIn( proxy, BossID, FirstIn, SecondIn, RegionID )
	if proxy:IsCompleteEvent( BossID ) == false then
		--▽同期アニメ再生用の開始ハンドラ(旋回→歩き) --EN:--▽ Start handler for synchronous animation playback (turning → walking)
		proxy:LuaCall( SecondIn, 1, "OnEvent_SynchroTurn", everytime );
		--▽2回目以降にボス部屋に入るためのイベント配信用 --EN:--▽For event delivery to enter the boss room after the second time
		proxy:LuaCall( FirstIn , 5 , "OnEvent_"..FirstIn.."_GO_TO_IN" , everytime );
		--▽フラグセット(同期用) --EN:--▽flag set (for synchronization)
		proxy:LuaCall( FirstIn , 6 , "OnEvent_"..FirstIn.."_flag_set" , everytime );
		
		--誰かがボス前扉をまだ通過していない --EN:--Someone hasn't passed through the boss front door yet
		if proxy:IsCompleteEvent( FirstIn ) == false then
		
			--(セッション中に)ボス前の魔法壁を最初に通れるのは生存の人だけ --EN:--(During the session) Only survivors can pass through the magic wall in front of the boss first
			local possible_chr_type = ATTR_HOST + ATTR_LIVE + ATTR_GREY;
			
			proxy:NotNetMessage_begin();
				--▼FirstIn▼中に入るためのイベントを追加▼ --EN:--▼FirstIn▼Add an event to go inside▼
				proxy:OnPlayerActionInRegionAttribute( FirstIn, RegionID, "OnEvent_"..FirstIn, HELPID_GO_TO_IN, possible_chr_type, once );
			proxy:NotNetMessage_end();
			
		else --グレイゴーストできたときようにいると思われる。 --EN:--Gray ghost seems to be like that when it's done.
		
			proxy:NotNetMessage_begin();
				--▼SecondIn▼中に入るためのイベントを追加▼--ハンドラは上と同じ --EN:--▼SecondIn▼Add an event to enter inside▼--The handler is the same as above
				proxy:OnPlayerActionInRegion( SecondIn, RegionID, "OnEvent_"..FirstIn, HELPID_GO_TO_IN, everytime );
			proxy:NotNetMessage_end();
		end
	end
end

function OnEvent_SynchroTurn(proxy,param)
end
]]


--[[
シングル時フラグリセット関数☆SingleReset --EN:Single flag reset function ☆SingleReset
proxy	…イベントプロキシ --EN:proxy … event proxy
flag	…フラグ --EN:flag … flag
]]
function SingleReset(proxy,flag)
	if proxy:IsClient() == false then
		proxy:SetEventFlag( flag,false);
	end
end


--[[
OnRegistFuncの結果の部分を使わない時に指定する空メソッド --EN:An empty method to specify when not using the result part of OnRegistFunc
]]
function dummy(proxy,param)
end

--[[
渡したEventIDリストのイベントを纏めて消す関数☆DeleteConditionList --EN:A function that collectively deletes the events in the passed EventID list ☆DeleteConditionList
proxy		…イベントプロキシ --EN:proxy … event proxy
acid_list	…アクションIDリスト（条件登録時のID） --EN:acid_list … Action ID list (ID when registering conditions)
]]
function DeleteConditionList(proxy,acid_list)
	local id_num = table.getn(acid_list);
	for index = 1, id_num, 1 do
		proxy:DeleteEvent( acid_list[index] );
	end
end

function SynchroAddQWC(proxy,param)
	print("SynchroAddQWC begin");
	local qwcId = param:GetParam3();
	print("QwcAddId = ", qwcId );
	proxy:AddQWC(qwcId,param:IsNetMessage());
	print("SynchroAddQWC end");
end

--[[
トロフィー取得ラッパー関数☆Lua_RequestUnlockTrophy --EN:Trophy acquisition wrapper function ☆ Lua_RequestUnlockTrophy
proxy		…イベントプロキシ --EN:proxy … event proxy
TrophyId	…アンロック要求するトロフィーのID --EN:TrophyId … ID of the trophy to be unlocked
]]
function Lua_RequestUnlockTrophy(proxy,TrophyId)
	if proxy:IsClient() == false then --シングル　or　ホスト --EN:--Single or host
		if proxy:IsLivePlayer() == true or proxy:IsGreyGhost() == true then
			print("トロフィーID:(",TrophyId,")の取得の権利を得ました"); --EN:print("Trophy ID:(",TrophyId,") got the right to get");
			--まだトロフィー(TrophyId)を手に入れてなければ --EN:--If you haven't got the TrophyId yet
			if proxy:IsUnlockTrophy( TrophyId ) == false then	--今は無条件でfalseを返す。 --EN:-- Now unconditionally return false.
				--トロフィーの取得 --EN:--Get trophies
				proxy:RequestUnlockTrophy( TrophyId );
				print("トロフィーID:(",TrophyId,")を手に入れた"); --EN:print("I got the trophy ID:(",TrophyId,")");
			else
				print("トロフィーID:(",TrophyId,")はすでに持っています"); --EN:print("I already have trophy id:(",TrophyId,")");
			end
		else
			print("トロフィー取得の権利はありません"); --EN:print("You are not entitled to trophies");
		end
	else--キャラタイプが上記のいずれかでもない場合 --EN:--If the character type is not one of the above
		print("トロフィー取得の権利はありません"); --EN:print("You are not entitled to trophies");
	end
end

--[[
イベント強制死亡ソウル入手不可ラッパー関数☆Lua_EventForceDead --EN:Event forced death soul unobtainable wrapper function ☆Lua_EventForceDead
proxy		…イベントプロキシ --EN:proxy … event proxy
TargetID	…死亡ターゲット --EN:TargetID … death target
]]
function Lua_EventForceDead(proxy,TargetID)
	print("Lua_EventForceDead TargetID ",TargetID);
	proxy:DisableCollection( TargetID, true );
	proxy:ForceDead( TargetID );	
end


--------------------------------------------------------------------------------------------
--■4057■汎用同期 --EN:-- ■ 4057 ■ General-purpose synchronization
--------------------------------------------------------------------------------------------
--DeleteEvent
function SynchroDeleteEvent_4057(proxy,param)
	proxy:DeleteEvent( param:GetParam3() );
end

--SetEventFlag true設定 --EN:--SetEventFlag true setting
function SynchroSetEventFlag_4057(proxy,param)
	proxy:SetEventFlag( param:GetParam3(), true );
end

--SetEventFlag false設定 --EN:--SetEventFlag false setting
function SynchroResetEventFlag_4057(proxy,param)
	proxy:SetEventFlag( param:GetParam3(), false );
end


--------------------------------------------------------------------------------------------
--■■チュートリアル用メニュー待ち --EN:--Waiting for tutorial menu
--------------------------------------------------------------------------------------------
function Lua_PauseTutorial(proxy)
	proxy:NotNetMessage_begin();
	proxy:RepeatMessage_begin();
	proxy:OnKeyTime2( 14000,"OnEvent_TutorialWait",Tutorial_pausewait,0,0,once);
	proxy:RepeatMessage_end();
	proxy:NotNetMessage_end();
end

function OnEvent_TutorialWait(proxy,param)
	proxy:StopPlayer();
	proxy:PauseTutorial();
	proxy:NotNetMessage_begin();
	proxy:RepeatMessage_begin();
	proxy:OnKeyTime2( 14000,"OnEvent_TutorialWait_2",0.1,0,2,once);
	proxy:RepeatMessage_end();
	proxy:NotNetMessage_end();	
end

function OnEvent_TutorialWait_2(proxy,param)	
	
	proxy:EnableLogic( 10000 , true );
end


--------------------------------------------------------------------------------------------
--■15500■乱入アイテムを取得しているか？※黒ゴーストNPCに対して、死体宝を調べると呼ばれる --EN:--■15500■Are you getting the intrusion item? * Called to examine the corpse treasure against the black ghost NPC
--------------------------------------------------------------------------------------------
function OnEvent_15500(proxy,param)
	if proxy:IsCompleteEvent(15500) == false then
		print("OnEvent_15500 begin");
		proxy:SetEventFlag( 15500 ,true );
		print("OnEvent_15500 end");
	end
end

--弾丸オーナー作成 --EN:--Bullet owner creation
function CreateBulletOwner(proxy,nwho)		
	InvalidCharactor( proxy , nwho  );
	proxy:SetAlwayEnableBackread_forEvent( nwho , true );	
end


----------------------------------------------------------------------------------------------------------------------------------------------------------------
--■4061■汎用ダイアログの距離判定用 --EN:-- ■ 4061 ■ For distance judgment of general-purpose dialog
----------------------------------------------------------------------------------------------------------------------------------------------------------------
function MenuClose(proxy,param)
	print("MenuClose begin");
	proxy:CloseGenDialog();
	print("MenuClose end");
end

--タイトルメニューへの --EN:-- to the title menu
function RegistReturnTitle(proxy,param)
	print("RegistReturnTitle begin");
	--セーブ要求 --EN:--save request
	proxy:SaveRequest();
	--キャラクタ操作の停止 --EN:--Stop character operation
	proxy:StopPlayer();
	--他の再読み込み系イベントの割り込みを防止 --EN:--Prevent interruption of other reloading events
	proxy:SetEventFlag(4047, true);
	--イベント内部にもロード待ちである事を通知 --EN:-- Notify that it is waiting for loading inside the event
	proxy:SetLoadWait();	
	
	proxy:NotNetMessage_begin();
	proxy:RepeatMessage_begin();
		proxy:OnKeyTime2( 4062 , "ReturnTitle_wait",0.5,0,20,once);
	proxy:RepeatMessage_end();
	proxy:NotNetMessage_end();
	
	print("RegistReturnTitle end");
end

function ReturnTitle_wait(proxy,param)
	proxy:NotNetMessage_begin();
	proxy:RepeatMessage_begin();
		proxy:OnRegistFunc( 4062 , "Check_ReturnTitle","OnReturnTitle",1,once);
	proxy:RepeatMessage_end();
	proxy:NotNetMessage_end();
end

--タイトルに戻る処理のメニュー表示待ち --EN:--Waiting for menu display for processing to return to the title
function Check_ReturnTitle(proxy)
	if proxy:IsShowMenu_InfoMenu() == true then
		return false;
	end
	return true;
end

--タイトルに戻る処理の実行 --EN:-- Execute processing to return to the title
function OnReturnTitle(proxy,param)
	print("OnReturnTitle begin");
	--タイトルorマップセレクトに戻ります --EN:--Return to title or map select
	proxy:ReturnMapSelect();
	print("OnReturnTitle end");
end


function Lua_GetReloadTime(proxy,low,high)
	local tempLow  = low  * 1000;
	local tempHigh = high * 1000;
	local rand = proxy:GetRandom( tempLow, tempHigh ) / 1000;
	return rand;
end

--トカゲイベント登録用 --EN:--For lizard event registration
function RegistTokage(proxy,eventId,TokageId,index)
	local count = 0;
	proxy:AddFieldInsFilter( TokageId );
	--トカゲ新仕様対応　判定はホストのみ行う --EN:--Compatible with new lizard specs Judgment is done only by the host
	if proxy:IsClient() == false then
		--トカゲが死んでいるor消えているなら --EN:--if the lizard is dead or gone
		if proxy:IsCompleteEvent(eventId) == true then
			--カウンタ取得 --EN:--get counter
			count = proxy:GetEventCount(index);
			--カウンタが残っている --EN:--counter remains
			if count > 0 then
				--フラグOFF --EN:--Flag OFF
				proxy:SetEventFlag( eventId ,false );
				--カウンタを減らして再設定 --EN:--decrement the counter and reset
				count = count-1;			
				proxy:SetEventCount(index,count);
			end
		end
	end
	
	--ココは全員通る --EN:--Everyone passes here
		--死んでいない消えてないなら監視を追加 --EN:--Add a watch if it's not dead or gone
	if proxy:IsCompleteEvent(eventId) == false then
		print("Add TokageEvent ",TokageId);
		proxy:OnCharacterDead(eventId,TokageId,"OnEvent_"..eventId,once);
		proxy:OnCheckEzStateMessage( eventId,TokageId,"OnEvent_"..eventId,1000);
	else
		--死んでいる消えているなら無効化 --EN:--disable if dead disappear
		InvalidBackRead(proxy,TokageId);
	end
end

--カウンタ加算 --EN:--counter addition
function AddEventCounter(proxy,index)
	--クライアントのみ --EN:--client only
	if proxy:IsClient() == false then
		local count = proxy:GetEventCount(index);
		count = count + 1;
		proxy:SetEventCount( index, count );
	end
end


--■4065■OBJの上にPCが乗った■ --EN:-- ■ 4065 ■ A PC is on top of an OBJ ■
function OnEnterRideObj(proxy,param)
	if param:IsNetMessage() == true then
		print("OnEnterRideObj begin");
		local obj 		= param:GetParam2();
		local sysidx 	= param:GetParam3();
		print("obj :",obj," sysidx :",sysidx);
		proxy:SetSyncRideObjInfo(param:GetPlayID()+10001,obj,sysidx);
		print("OnEnterRideObj end");
	end
end

--■4066■OBJに乗っていたPCが降りた■ --EN:-- ■ 4066 ■ PC on OBJ got off ■
function OnLeaveRideObj(proxy,param)
	if param:IsNetMessage() == true then
		print("OnLeaveRideObj begin");
		proxy:ResetSyncRideObjInfo(param:GetPlayID()+10001);
		print("OnLeaveRideObj end");
	end
end


--[[
	☆Lua_MultiDoping …マルチドーピング用アダプタ --EN:☆Lua_MultiDoping …Adapter for multi-doping
	proxy	…イベントプロキシ --EN:proxy … event proxy
	eneid	…敵イベントID --EN:eneid … enemy event ID
]]
function Lua_MultiDoping(proxy,eneId)	
	--ホストのみ判定 --EN:--Only the host is judged
	--if proxy:IsClient() == false then		
		local whiteCount = proxy:GetWhiteGhostCount();
		--ホワイト0　何もしない --EN:-- White 0 Do nothing
		if whiteCount == 0 then
			print("No Doping");
		end
		--ホワイト1　Lv1　強化 HP1.5倍 --EN:--White 1 Lv1 Enhanced HP 1.5x
		if whiteCount == 1 then
			print("Doping Lv 1 ",eneId);
			proxy:SetEventSpecialEffect_2(eneId,7500);
		end
		--ホワイト2　Lv2　強化 HP2倍 --EN:--White 2 Lv2 Enhanced HP x2
		if whiteCount == 2 then
			print("Doping Lv 2 ",eneId);
			proxy:SetEventSpecialEffect_2(eneId,7501);
		end				
	--end	
	proxy:NotNetMessage_begin();	
		proxy:OnKeyTime2( 4070, "ForceUpdate",0.1,0,eneId,once);
	proxy:NotNetMessage_end();
end

function ForceUpdate(proxy,param)
	proxy:ForceUpdateNextFrame( param:GetParam3() );
end

function Lua_MultiDopingm04_02(proxy,eneId)	
	
	local whiteCount = proxy:GetWhiteGhostCount();
	--ホワイト0　何もしない --EN:-- White 0 Do nothing
	if whiteCount == 0 then
		print("No Doping");
	end
	--ホワイト1　Lv1　強化 HP1.5倍 --EN:--White 1 Lv1 Enhanced HP 1.5x
	if whiteCount == 1 then
		print("Doping Lv 1 ",eneId);
		proxy:SetEventSpecialEffect_2(10000,7500);
	end
	--ホワイト2　Lv2　強化 HP2倍 --EN:--White 2 Lv2 Enhanced HP x2
	if whiteCount == 2 then
		print("Doping Lv 2 ",eneId);
		proxy:SetEventSpecialEffect_2(10000,7501);
	end			
end
