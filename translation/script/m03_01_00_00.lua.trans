
--古砦の囚人用の状態 --EN:--Conditions for Old Fort Prisoners
SYUUJIN_STATE_ESCAPE   	= 16050;--牢から出たい --EN:--I want to get out of prison
SYUUJIN_STATE_THANKS 	= 16051;--解放してくれて感謝 --EN:--thank you for freeing me
SYUUJIN_STATE_INTERVAL	= 16052;--水牢で休憩 --EN:--Break in the Water Prison
SYUUJIN_STATE_ANGRY_01	= 16053;--敵対(水牢) --EN:-- Hostility (Water Prison)
SYUUJIN_STATE_DEAD 		= 16054;--死亡 --EN:--death
SYUUJIN_STATE_STAY		= 16055;--古砦２にいる --EN:--In Old Fort 2
SYUUJIN_STATE_ANGRY_02	= 16056;--敵対(古砦2) --EN:-- Hostility (Old Fort 2)


syuujin_flag_list = { 
	SYUUJIN_STATE_ESCAPE,
	SYUUJIN_STATE_THANKS,
	SYUUJIN_STATE_INTERVAL, 
	SYUUJIN_STATE_ANGRY_01, 
	SYUUJIN_STATE_DEAD,
	SYUUJIN_STATE_STAY,
	SYUUJIN_STATE_ANGRY_02,
};

--古砦囚人トータルダメージ --EN:--Old Fort Prisoner Total Damage
SYUUJIN_TOTAL_DAMAGE = 50;

---------------------------------
--マスターサツキの状態変化フラグ --EN:--Master Satsuki's status change flag
---------------------------------
MasterSATSUKI_NORMAL  = 16360;--「剣を探している」 --EN:--"Looking for a sword"
MasterSATSUKI_HOSTILE = 16361;--「敵対」 --EN:-- "hostile"
MasterSATSUKI_DEAD    = 16362;--「死亡」 --EN:--"death"
MasterSATSUKI_HOSTILE_Makoto = 16363;--「敵対(誠装備)」 --EN:-- "Hostility (Makoto Equipment)"

MasterParamFlag_list = {
	MasterSATSUKI_NORMAL,
	MasterSATSUKI_HOSTILE,
	MasterSATSUKI_DEAD,
	MasterSATSUKI_HOSTILE_Makoto
}

--PCの攻撃によってマスターが敵対するためのダメージ値 --EN:--Damage value for master to be hostile by PC's attack
MasterSATSUKI_TotalDamage = 100;

---------------------------------
--鷲の娘 --EN:--Daughter of the Eagle
---------------------------------
--アイテム交換イベント用--必ず要素の数は合わせてください --EN:--For item exchange event--Make sure to match the number of elements
--使える定数 --EN:--Usable constants
--TYPE_WEAPON
--TYPE_PROTECTER
--TYPE_ACCESSORY
--TYPE_GOODS
itemevent_typelist		=	{TYPE_GOODS		,TYPE_GOODS		,TYPE_GOODS		,TYPE_GOODS		,TYPE_GOODS		,TYPE_GOODS		,TYPE_GOODS		,TYPE_GOODS		,TYPE_GOODS		,TYPE_GOODS		,
							 TYPE_GOODS		,TYPE_GOODS		,TYPE_GOODS		,TYPE_PROTECTER	,TYPE_PROTECTER	,TYPE_PROTECTER	,TYPE_WEAPON	,TYPE_WEAPON	,TYPE_WEAPON	};
							 
itemevent_idlist		=	{1014			,1022			,1018			,38				,2027			,2028			,2029			,2039			,2040			,2041			,
							 2045			,2046			,2047			,100100			,100000			,301700			,21600			,80300			,90400			};

itemevent_paramlist		=	{20000			,20001			,20002			,20003			,20004			,20005			,20006			,20007			,20008			,20009			,
							 20010			,20011			,20012			,20013			,20014			,20015			,20016			,20017			,20018			};

itemevent_eventidlist	=	{12621			,12622			,12623			,12624			,12625			,12626			,12627			,12628			,12629			,12630			,
							 12631			,12632			,12633			,12634			,12635			,12636			,12637			,12638			,12639			};

itemevent_endidlist		=	{12641			,12642			,12643			,12644			,12645			,12646			,12647			,12648			,12649			,12650			,
							 12651			,12652			,12653			,12654			,12655			,12656			,12657			,12658			,12659			};

--アイテム交換イベント用分布 --EN:--Distribution for item exchange event
ITEM_LOT_A = 10;--0～A --EN:--0 to A
ITEM_LOT_B = 20;--A～B --EN:--A~B
ITEM_LOT_C = 30;--B～C --EN:--B~C
ITEM_LOT_D = 40;--C～D --EN:--C~D
ITEM_LOT_E = 50;--D～E --EN:--D~E
ITEM_LOT_F = 60;--E～F --EN:--E~F
ITEM_LOT_G = 70;--F～G --EN:--F~G
ITEM_LOT_H = 80;--G～H --EN:--G~H
ITEM_LOT_I = 90;--H～I --EN:--H~I
--J				--I～100 --EN:--I~100

ITEM_SHOWMENU = false;
PREV_ITEM_SHOWMENU = false;
--------------------------------------------------------------------------------------
--マップ読み込み時に読まれる初期化処理■ --EN:--Initialization process read when reading the map ■
--------------------------------------------------------------------------------------
function Initialize_m03_01_00_00(proxy)
	print("Initialize_m03_01_00_00 begin");
	
	proxy:LuaCall( 99999 , 0 , "OnEvent_4000_Hp_1",everytime);
-----------------------------------------------------------------------------------------
--ボス関連 --EN:--Boss related
-----------------------------------------------------------------------------------------
--■594■ボス部屋に入る■	 --EN:-- ■ 594 ■ Enter the boss room ■
	--中ボスが生きているときだけイベント登録 --EN:-- Event registration only when the mid-boss is alive
	if proxy:IsCompleteEvent( 4756 ) == false then	
		--ソロのときは一度目にボス部屋に入る用のイベントを毎回登録させたいので、対応するフラグをOFFにする。 --EN:-- When soloing, we want to register the event for entering the boss room for the first time every time, so turn off the corresponding flag.
		SingleReset(proxy, 594);
		--▽同期アニメ再生用の開始ハンドラ(旋回→歩き) --EN:--▽ Start handler for synchronous animation playback (turning → walking)
		proxy:LuaCall( 593, 1, "OnEvent_594_1", everytime );		
		--▽2回目以降にボス部屋に入るためのイベント配信用 --EN:--▽For event delivery to enter the boss room after the second time
		proxy:LuaCall( 593 , 5 , "OnEvent_594_GO_TO_IN" , everytime );		
		--▽フラグセット(同期用) --EN:--▽flag set (for synchronization)
		proxy:LuaCall( 593 , 6 , "OnEvent_594_flag_set" , everytime );		
		--誰かがボス前扉をまだ通過していない --EN:--Someone hasn't passed through the boss front door yet
		if proxy:IsCompleteEvent( 594 ) == false then		
			--(セッション中に)ボス前の魔法壁を最初に通れるのは生存の人だけ --EN:--(During the session) Only survivors can pass through the magic wall in front of the boss first
			local possible_chr_type = ATTR_HOST + ATTR_LIVE + ATTR_GREY;			
			proxy:NotNetMessage_begin();
				--▼594▼扉が開いているときに中に入るためのイベントを追加▼ --EN:--▼594▼Add an event to enter when the door is open▼
				proxy:OnPlayerActionInRegionAttribute( 594, 2894, "OnEvent_594", HELPID_GO_TO_IN, possible_chr_type, everytime );
			proxy:NotNetMessage_end();
		else --グレイゴーストできたときようにいると思われる。		 --EN:--Gray ghost seems to be like that when it's done.
			proxy:NotNetMessage_begin();			
				--▼593▼扉が開いているときに中に入るためのイベントを追加▼ --EN:--▼593▼Add an event to enter when the door is open▼
				proxy:OnPlayerActionInRegion( 593, 2894, "OnEvent_594", HELPID_GO_TO_IN, everytime );--ハンドラは上と同じ --EN:--handler is the same as above
			proxy:NotNetMessage_end();		
		end
	end	

	--■595■ボス登場演出■ --EN:-- ■ 595 ■ Boss Appearance ■
	if proxy:IsCompleteEvent( 595 ) == false then
		proxy:LuaCall( 595, 0, "OnEvent_595", once );
	end
	
	--■641■ボス戦闘開始■ --EN:-- ■ 641 ■ Boss battle begins ■
	if proxy:IsCompleteEvent( 4756 ) == false then
		proxy:OnRegionJustIn( 641 , 10000 , 2886 , "OnEvent_641" , once );
	end	
	
	--■4756■中ボス死亡で扉が開く■ --EN:--■4756■The door opens when the mid-boss dies■
	proxy:AddFieldInsFilter( 804 );	
	if proxy:IsCompleteEvent( 4756 ) ==false then
		--▼OBJ(804)が死に、死亡アニメーションも再生し終わった時▼-- --EN:--▼When OBJ (804) dies and the death animation finishes playing▼--
		proxy:OnCharacterDead(4756, 804, "OnEvent_4756", once);
		proxy:OnCharacterDead(642,804,"OnEvent_642",once);
	else
		proxy:EndAnimation( 1206, 1);
	end
	
--■4766-4787■中ボス部屋　床破壊■ --EN:-- ■ 4766-4787 ■ Mid-boss room Floor destruction ■

	local first_block_id  = 1208;
	local block_num = 21;  -- 全部の場合は22個、今は2Ｆのとかが無効になっているので13個 --EN:-- In the case of all, 22, now 13 because 2F is disabled
	local now_block_id    = first_block_id;
	
	local first_event_id  = 4766;
	local end_event_id    = first_event_id + block_num;
	
	for i=first_event_id, end_event_id, 1 do
		
		print( "add block id is " .. now_block_id );
		if proxy:IsCompleteEvent( 4756 ) == false then
			SingleReset( proxy, i );
		end
		if proxy:IsCompleteEvent( i ) == false then
			--初期化時に壊れてない事にする --EN:--Pretend it is not broken at initialization
			proxy:RestorePiece( now_block_id );
			proxy:OnObjectDestroy( i, now_block_id, "OnEvent_"..i , once );
		else
			proxy:ReconstructBreak( now_block_id , 2 );
		end
		
		now_block_id = now_block_id + 1;
	end

	local actIdlist2 = { 4788, 4789, 4790, 4791, 4792 };
	local objIdlist2 = { 1230, 1231, 1232, 1233, 1234 };
	local num = table.getn( actIdlist2 );
	for index = 1 , num , 1 do
		local actionid = actIdlist2[index];
		local objid = objIdlist2[index];
		--ボスが生きていたら --EN:--If the boss were alive
		if proxy:IsCompleteEvent( 4756 ) == false then
			SingleReset( proxy, actionid );
		end
		if proxy:IsCompleteEvent( actionid ) == false then
			proxy:NotNetMessage_begin();
				--先に修復 --EN:--repair first
				proxy:RestorePiece( objid );
				proxy:OnObjectDestroy( actionid , objid , "OnEvent_"..actionid , once);
			proxy:NotNetMessage_end();
		else
			proxy:ReconstructBreak( objid , 1 );
		end	
	end
	
	--現状、ReconstructBreakをInitializeのタイミングで呼んでも --EN:--Currently, even if ReconstructBreak is called at the timing of Initialize
	--ReconstructBreakの中の処理がまだ途中なため、 --EN:--Because the processing in ReconstructBreak is still in progress,
	--破壊の再現は行われず、オブジェが表示されない状態になる。 --EN:--Destruction will not be reproduced and the object will not be displayed.
	--中身ができたらこのタイミングで呼んでも破壊再現してくれるはず(たぶん) --EN:--Once the contents are ready, it should be able to reproduce the destruction even if you call it at this timing (probably)
	--今の状態で、破壊再現したい場合はSecond_Initializeの中に書くようにする。 --EN:--If you want to reproduce the destruction in the current state, write it in Second_Initialize.

	--■ボス関連の初期化処理 --EN:--■ Boss-related initialization processing
	if proxy:IsCompleteEvent( 4756 ) ==true then
		
		--▽ボス死んでいるとき --EN:--▽When the boss is dead
		--ボスいなくなる --EN:--boss disappears
		InvalidBackRead( proxy , 804 );

		--魔法壁消える --EN:--Magic wall disappears
		proxy:SetDrawEnable( 1994 , false );
		proxy:SetColiEnable( 1994 , false );

		proxy:SetDrawEnable( 1998 , false );
		proxy:SetColiEnable( 1998 , false );

		--魔法壁の SFX OFF		 --EN:--Magic Wall SFX OFF
		proxy:InvalidSfx( 1990 , false );
		proxy:InvalidSfx( 1986 , false );

		--ホストプレイヤーのみアイテム入手イベントに使用 --EN:--Used for item acquisition event only for host players
		local possible_chr_type = ATTR_HOST + ATTR_LIVE + ATTR_GREY;

		--宝死体(ソウル?)有効化 --EN:--Treasure corpse (soul?) activation
		proxy:SetDrawEnable( 1981 , true );
		proxy:SetColiEnable( 1981 , true );
		--宝死体(ソウル?)有効化 --EN:--Treasure corpse (soul?) activation
		proxy:SetDrawEnable( 1976 , true );
		proxy:SetColiEnable( 1976 , true );
		
		proxy:TreasureDispModeChange2( 1981 , true ,KANAME_SFX);--光らせる --EN:-- let it shine
		--▼(ソウル)アイテム取得用イベント監視追加▼ --EN:--▼ (Soul) Added event monitoring for item acquisition▼
		if proxy:IsCompleteEvent( 4804 ) == false then
			proxy:ValidSfx( 2286 );--SFX 有効化 --EN:--SFX enable
			proxy:ValidSfx( 2287 );--SFX 有効化			 --EN:--SFX enable
			proxy:OnDistanceActionAttribute( 4804 , 10000 , 1981 , "OnEvent_4804" , WarpGimmickDist_A , 10010180 , 0 , 180 , possible_chr_type, once );
		else
			--▼要石でワープ用の監視を追加▼ --EN:--▼ Added surveillance for warp with keystone ▼
			SingleReset(proxy,4805);			
			proxy:InvalidSfx( 2286, false );--SFX 無効化 --EN:--Disable SFX
			proxy:OnDistanceActionAttribute( 4805 , 10000 , 1981 , "OnEvent_4805" , WarpGimmickDist_A , HELPID_GO_TO_SEKITYUU , 0 , 180 , ATTR_NOSESSION , everytime );
		end
		
	else
		--▽ボス生きているとき		 --EN:--▽ When the boss is alive
		proxy:EnableLogic( 804 , false );--ロジックOFFで待機 --EN:--Wait with logic OFF
		
		--宝(ソウル?) --EN:--Treasure (Soul?)
		proxy:SetDrawEnable( 1981 , false );
		proxy:SetColiEnable( 1981 , false );
		--宝(ソウル?)2 --EN:--Treasure (Soul?) 2
		proxy:SetDrawEnable( 1976 , false );
		proxy:SetColiEnable( 1976 , false );
		
		--SFX 無効化 --EN:--Disable SFX
		proxy:InvalidSfx( 2287 , false );--ソウル用 --EN:--For Seoul
		proxy:InvalidSfx( 2286 , false );--ボスアイテム用		 --EN:--For boss items
	end	
	
-----------------------------------------------------------------------------------------
--ギミック関連 --EN:--Gimmick related
-----------------------------------------------------------------------------------------
	--■636■鷹の攻撃■ --EN:-- ■ 636 ■ Hawk attack ■
	--proxy:OnRegistFunc(636, "Check_636", "OnEvent_636", 1, everytime );
	--proxy:OnCharacterDead( 636, 325, "OnEvent_636_1", once );
	--■637■鷹の攻撃■ --EN:-- ■ 637 ■ Hawk attack ■
	--proxy:OnRegistFunc(637, "Check_637", "OnEvent_637", 1, everytime );
	--proxy:OnCharacterDead( 637, 326, "OnEvent_637_1", once );
	
	--■638■鷹の攻撃■	 --EN:-- ■ 638 ■ Hawk attack ■
	--proxy:OnRegistFunc(638, "Check_638", "OnEvent_638", 1, everytime );
	--proxy:OnCharacterDead( 638, 327, "OnEvent_638_1", once );	
	
	--■542■はしごA降り■ --EN:-- ■ 542 ■ Ladder A down ■
	--▼PCがイベントエリア(2200)の中に居て、反応角度(LadderAngle_A)でアクションボタンを押したとき▼-- --EN:--▼When the PC is in the event area (2200) and presses the action button with the reaction angle (LadderAngle_A)▼--
	proxy:OnActionEventRegion( 542, 2200, "OnEvent_542", LadderAngle_A, HELPID_DOWN, everytime );
	--■543■はしごA昇り■ --EN:-- ■ 543 ■ Ladder A climbing ■
	--▼PCがイベントエリア(2201)の中に居て、反応角度(90)でアクションボタンを押したとき▼-- --EN:--▼When the PC is in the event area (2201) and presses the action button at the reaction angle (90)▼--
	proxy:OnActionEventRegion( 543, 2201, "OnEvent_543", LadderAngle_A, HELPID_UP, everytime );	

	--■583■石柱にワープ■ --EN:-- ■ 583 ■ Warp to the stone pillar ■
	SingleReset(proxy,583);
	proxy:TreasureDispModeChange2( 1983 , true ,KANAME_SFX);
	--2008.06.05/toyohide 処理変更につき、修正 --EN:--2008.06.05/toyohide Modified for processing change
	--proxy:OnDistanceActionAttribute( 583, 10000, 1983, "OnEvent_583", WarpGimmickDist_A, HELPID_GO_TO_SEKITYUU, 0, 180, ATTR_NOSESSION, everytime );
	proxy:OnDistanceAction( 583, 10000, 1983, "OnEvent_583", WarpGimmickDist_A,HELPID_GO_TO_SEKITYUU, 0, 180 , everytime);

	
--■660■最初の要石の光が消える■ --EN:-- ■ 660 ■ The light of the first keystone disappears ■
	proxy:OnSessionJustIn( 660 , "OnEvent_660" , everytime );
		
--■661■最初の要石の光が復活する■ --EN:-- ■ 661 ■ The light of the first keystone is restored ■
	proxy:OnSessionJustOut( 661 , "OnEvent_661" , everytime );

--■8085■砦に来たフラグを立てる■ --EN:-- ■ 8085 ■ Raise a flag for coming to the fort ■
	proxy:SetEventFlag(8085, true);

	
--光の霧を通過できるキャラタイプ(このタイプの人だけアクションボタンが反応する) --EN:--Character type that can pass through the fog of light (only this type of person reacts to the action button)
	local possible_chr_type = ATTR_HOST + ATTR_LIVE + ATTR_GREY;
	
	--■644■ホストPCのみが通れる光の霧■ --EN:-- ■ 644 ■ A fog of light that only the host PC can pass through ■
	if proxy:IsCompleteEvent( 644 ) == true then--ホストが通過済み --EN:--Host passed
		proxy:SetDrawEnable( 1332 , false );
		proxy:SetColiEnable( 1332 , false );
		proxy:InvalidSfx( 2231, false );
	else
		--▼644▼魔法壁削除同期用▼ --EN:--▼644▼For Synchronizing Magic Wall Deletion▼
		proxy:LuaCall( 644 , 1 , "OnEvent_644_delete_wall" , once );
	
		--▼644▼壁の中に入るイベント発動用▼ --EN:-- ▼ 644 ▼ For triggering the event to enter the wall ▼
		proxy:OnDistanceActionAttribute( 644 , 10000 , 1332 , "OnEvent_644" , 1.5 , HELPID_GO_TO_IN , 180 , DoorAngle_A , possible_chr_type, everytime );
	end
	
	--■645■ホストPCのみが通れる光の霧2■ --EN:-- ■ 645 ■ Fog of light that only the host PC can pass through 2 ■
	if proxy:IsCompleteEvent( 645 ) == true then--ホストが通過済み --EN:--Host passed
		proxy:SetDrawEnable( 1333 , false );
		proxy:SetColiEnable( 1333 , false );
		proxy:InvalidSfx( 2232, false );
	else
	
		--▼645▼魔法壁削除同期用▼ --EN:--▼645▼For synchronizing magic wall deletion▼
		proxy:LuaCall( 645 , 1 , "OnEvent_645_delete_wall" , once );
		
		--▼645▼壁の中に入るイベント発動用▼ --EN:-- ▼ 645 ▼ For triggering the event to enter the wall ▼
		proxy:OnDistanceActionAttribute( 645 , 10000 , 1333 , "OnEvent_645" , 1.5 , HELPID_GO_TO_IN , 180 , DoorAngle_A , possible_chr_type, everytime );
	end
	
		
	--■646■ホストPCのみが通れる光の霧3■ --EN:-- ■ 646 ■ Light Fog 3 that only the host PC can pass through ■
	if proxy:IsCompleteEvent( 646 ) == true then--ホストが通過済み --EN:--Host passed
		proxy:SetDrawEnable( 1334 , false );
		proxy:SetColiEnable( 1334 , false );
		proxy:InvalidSfx( 2233, false );
	else
		
		--▼646▼魔法壁削除同期用▼ --EN:--▼646▼For synchronizing magic wall deletion▼
		proxy:LuaCall( 646 , 1 , "OnEvent_646_delete_wall" , once );
		
		--▼646▼壁の中に入るイベント発動用▼ --EN:-- ▼ 646 ▼ For triggering the event to enter the wall ▼
		proxy:OnDistanceActionAttribute( 646 , 10000 , 1334 , "OnEvent_646" , 1.5 , HELPID_GO_TO_IN , 180 , DoorAngle_A , possible_chr_type, everytime );
	end
	
--■639■牢の扉■ --EN:-- ■ 639 ■ jail door ■
	if proxy:IsCompleteEvent( 639 ) == false then
		proxy:NotNetMessage_begin();
			proxy:OnDistanceActionPlus( 639, 10000, 1331, "OnEvent_639", DoorDist_A, HELPID_OPEN, 0.0, DoorAngle_A, 0.0, 0.0, 0.0, everytime );
		proxy:NotNetMessage_end();
		proxy:LuaCall( 639, 1, "OnEvent_639_2", once );
	else
		proxy:EndAnimation( 1331, 1 );
	end
	
	--■■アイテム交換系イベント■ --EN:-- ■■Item exchange event■
	--生存orグレイゴーストのみ --EN:--survival or gray ghost only
	if proxy:IsClient() == false and proxy:IsCompleteEvent(659) == false then

		--アイテムを捨てていたら交換する --EN:--If you throw away the item, replace it
		if proxy:IsCompleteEvent(12613) == true then
			proxy:SetEventFlag(12614,true);
			--proxy:SetEventFlag(12613,false);
			SingleReset(proxy, 12613);
		end
		
		print("live or grey");
	--■654■天の声■ --EN:-- ■ 654 ■ Heaven's voice ■
		--会話の登録 --EN:--Register Conversation
		--交換可能アイテムを捨てた時の会話 --EN:--Conversation when throwing away exchangeable items
		proxy:RegistSimpleTalk( 12613, 2284, 25040, TALK_ATTR_ALL - TALK_ATTR_REPEAT );
		--交換可能アイテムを捨てたが既に交換済みの会話 --EN:--Conversations where exchangeable items have been discarded but have already been exchanged
		proxy:RegistSimpleTalk( 663, 2284, 25060, TALK_ATTR_ALL - TALK_ATTR_REPEAT );
		--交換できるよ～会話 --EN:--We can exchange~ Conversation
		proxy:RegistSimpleTalk( 654, 2284, 25000, TALK_ATTR_ALL - TALK_ATTR_REPEAT );
		--まだ交換できるよ～会話 --EN:--You can still exchange~ Conversation
		proxy:RegistSimpleTalk( 655, 2284, 25010, TALK_ATTR_ALL - TALK_ATTR_REPEAT );
		--もうだめぽー --EN:--no more
		proxy:RegistSimpleTalk( 659, 2284, 25070, TALK_ATTR_ALL - TALK_ATTR_REPEAT );		
		
		--交換対象外のアイテムをドロップ --EN:--Drop non-exchangeable items
		proxy:RegistSimpleTalk( 662, 2284, 25050, TALK_ATTR_ALL - TALK_ATTR_REPEAT );
		
		
		proxy:NotNetMessage_begin();
		proxy:RepeatMessage_begin();
			proxy:OnRegionIn(654,10000,2284,"OnEvent_654",once);				
		proxy:RepeatMessage_end();
		proxy:NotNetMessage_end();		
		
	--■12613■アイテムドロップの監視■	 --EN:--■12613■Item drop monitoring■
		proxy:NotNetMessage_begin();
			--常に調べます --EN:--always check
			proxy:OnRegionIn(12613,10000,2284,"OnEvent_12613",everytime);
			--拾った時の監視 --EN:--monitoring when picked up
			--proxy:LuaCall(12613,0,"OnEvent_12613_1",everytime);
			local num = table.getn(itemevent_eventidlist);
			for index=1 ,num ,1 do
				proxy:LuaCall( itemevent_eventidlist[index],0,"OnEvent_"..itemevent_eventidlist[index].."_1",everytime);
			end
		proxy:NotNetMessage_end();
	
	--■658■アイテム交換■ --EN:-- ■ 658 ■ Item Exchange ■
		if proxy:IsCompleteEvent(12614) == true then
			print("Item event treu");
			proxy:NotNetMessage_begin();
			proxy:RepeatMessage_begin();
				proxy:OnDistanceAction(658,10000,1335,"OnEvent_658",ItemBoxDist_A,HELPID_CHECK,0,60,once);
				proxy:TreasureDispModeChange2(1335,true,ITEM_SFX);
				--proxy:SetRarity(1335,10217);
			proxy:RepeatMessage_end();
			proxy:NotNetMessage_end();
		else
			print("Item event false");			
			--表示も消しておく --EN:-- also turn off the display
			proxy:SetDrawEnable(1335,false);
		end
	else
		print("dead");
		proxy:SetDrawEnable(1335,false);
	end

------------------------------------------------------------------------------------------------
--★骸骨剣士起動★ --EN:-- ★ Skeleton swordsman start ★
------------------------------------------------------------------------------------------------
--■730～753■骸骨剣士_起動■ --EN:--■730～753■Skeleton Swordsman_Activation■
	--入りなおした時にリセット --EN:--Reset when re-entering
	for ActionID = 730, 759, 1 do
		SingleReset(proxy, ActionID);
	end
	
	local actIdlist = { 730, 731, 732, 733, 734, 735, 736, 737, 738, 739, 
						740, 741, 742, 743, 744, 745, 746, 747, 748, 749,
						750, 751, 752, 753, 754, 755, 756, 757, 758, 759,
						};
	local eneIdlist = { 360, 361, 362, 363, 364, 365, 366, 367, 368, 369,
						370, 371, 372, 373, 374, 375, 376, 377, 378, 379,
						380, 381, 382, 383, 384, 428, 429, 430, 431, 432,
						};
						
	local num = table.getn( actIdlist );
	--起動する距離監視の追加と初期化 --EN:--adding and initializing distance monitoring to start
	for index=1 , num , 1 do 	
		local SkeletonID = eneIdlist[ index ];
		local ActionID = actIdlist[ index ];		
		if proxy:IsCompleteEvent(ActionID) == false then
			proxy:OnPlayerDistanceInTarget(ActionID, 10000, SkeletonID, "OnEvent_"..ActionID, 30.0, once);--骨剣士との距離が一定値(25)以下 --EN:--The distance from the bone swordsman is less than a certain value (25)
			--骨剣士初期化 --EN:--Bone Swordsman initialization
			proxy:PlayLoopAnimation(SkeletonID, 7000);--潰れてるアニメ --EN:--Crashed animation
			proxy:SetColiEnable(SkeletonID, false);--アタリOFF --EN:--Atari OFF
		else
			if proxy:IsAlive(SkeletonID) == true then--生きているならば --EN:--if alive
				proxy:StopLoopAnimation(SkeletonID);--潰れているアニメのループ終了 --EN:--End of collapsed animation loop
				proxy:SetSpStayAndDamageAnimId(SkeletonID,-1,-1);--特殊待機アニメの無効化 --EN:--Disable special standby animation
				proxy:EndAnimation(SkeletonID, 7001);--起き上がるアニメ再生 --EN:--Wake up animation playback
				proxy:SetColiEnable(SkeletonID, true);--アタリON --EN:--Atari ON
				proxy:EnableLogic( SkeletonID, true );--ロジックON --EN:--Logic ON
				print("★"..SkeletonID.."は、すでに起動済み"); --EN:print("★"..SkeletonID.." is already running");
			else--死亡していたら --EN:--if dead
				proxy:ForceDead(SkeletonID);--強制的に死亡させる --EN:--force death
				--InvalidCharactor(proxy, SkeletonID);
			end
		end
	end

-----------------------------------------------------------------------------
--■780～784■槍射出トラップ --EN:-- ■ 780～784 ■ Spear injection trap
-----------------------------------------------------------------------------
--OnEvent_780, OnEvent_781, OnEvent_782, OnEvent_783, OnEvent_784

--槍射出トラップ発動ハンドラ --EN:--Spear firing trap activation handler
	proxy:NotNetMessage_begin();
		proxy:LuaCall(780, 0, "SpearTrapMove_780", everytime);
		proxy:LuaCall(782, 0, "SpearTrapMove_782", everytime);
		proxy:LuaCall(783, 0, "SpearTrapMove_783", everytime);
		proxy:LuaCall(784, 0, "SpearTrapMove_784", everytime);
	proxy:NotNetMessage_end();
	
--各トラップ初期化 --EN:--Each trap initialization
	for index = 1, 5, 1 do
		local acId		= 780  + index - 1;
		local regionId	= 2250 + index - 1;
		local objId_1	= 1240 + index - 1;--スイッチ --EN:--switch
		local objId_2	= 1250 + index - 1;--連射用 --EN:--For rapid fire
		local objId_3	= 1260 + index - 1;--掃射用 --EN:--Strafe
		local ownerId	= 330;
		local SfxId	= 93005;--SFXのID --EN:--ID of SFX
		
		--シングルならリセット --EN:--reset if single
		SingleReset(proxy, acId);
		--敵を無効化するはずだが --EN:--It should disable the enemy
		CreateBulletOwner(proxy, ownerId);	
		
		proxy:SetBallista( objId_2, ownerId );
		proxy:SetBallista( objId_3, ownerId );
		if	proxy:IsCompleteEvent( acId ) == false then
			--OBJのダミポリにSFXを設定 --EN:--Set SFX to dummy poly of OBJ
			proxy:SetObjSfx(objId_1, 1, SfxId, false);
			proxy:OnRegionJustIn( acId, LOCAL_PLAYER, regionId, "OnEvent_"..acId, once );
		else
			proxy:EndAnimation( objId_1, 1 );
			proxy:EndAnimation( objId_2, 1 );
		end
	end

--■785■カラス鳴き声が響く■ --EN:-- ■ 785 ■ Crows cry ■
	--OnEvent_784の1秒後に発動 --EN:--Fired 1 second after OnEvent_784

--[[
	--■572■岩が消滅する■QWCイベント --EN:-- ■ 572 ■ Rock disappears ■ QWC event
	
	if proxy:IsCompleteEvent(572) ==true then
		print("[成立]QWC岩消滅"); --EN:print("[Established] QWC Rock Disappearance");
		proxy:SetDrawEnable(1207, false );
		proxy:SetColiEnable(1207, false );
	else
		print("[未成立]QWC岩消滅"); --EN:print("[Unformed] QWC Rock Disappearance");
	end]]
--[[イベントが削除された為、コメントアウト --EN:--[[Commented out because the event was deleted
	--■532-534■閂(かんぬき)扉A■ --EN:-- 532-534 Barrel door A
	if proxy:IsCompleteEvent( 532 ) == false then		
		proxy:OnDistanceActionPlus( 532, 10000, 1204, "OnEvent_532", DoorDist_A, HELPID_OPEN, 180.0, 30.0, 0.0, -1.2, 0.0, once );	
	else
		proxy:EndAnimation( 1204, 1 );--閂扉を開ける --EN:--Open the bar door
	end
	
	--■651■骸骨イベント■		 --EN:-- ■ 651 ■ skeleton event ■
	if proxy:IsCompleteEvent(651) == false then
		proxy:OnRegionJustIn( 651,10000,2050,"OnEvent_651",once);
		proxy:PlayLoopAnimation(328,7000);--潰れてるアニメ --EN:--Crashed animation
		proxy:SetColiEnable(328,false);--アタリOFF --EN:--Atari OFF
	end
	
	--■652■骸骨イベント■ --EN:-- ■ 652 ■ skeleton event ■
	if proxy:IsCompleteEvent(652) == false then
		proxy:OnRegionJustIn( 652,10000,2060,"OnEvent_652",once);
		
		local eneid = 1;
		for eneid = 329, 334, 1 do
			proxy:PlayLoopAnimation(eneid,7000);--潰れてるアニメ --EN:--Crashed animation
			proxy:SetColiEnable(eneid,false);--アタリOFF --EN:--Atari OFF
		end		
	end
	
	--■653■骸骨イベント■ --EN:-- ■ 653 ■ skeleton event ■
	if proxy:IsCompleteEvent(653) == false then
		proxy:OnRegionJustIn( 653,10000,2070,"OnEvent_653",once);
		local eneid = 1;
		for eneid = 336, 339, 1 do
			proxy:PlayLoopAnimation(eneid,7000);--潰れてるアニメ --EN:--Crashed animation
			proxy:SetColiEnable(eneid,false);--アタリOFF --EN:--Atari OFF
		end				
	end]]

-----------------------------------------------------------------------------------------
--NPC関連 --EN:--NPC related
-----------------------------------------------------------------------------------------
	if proxy:IsClient() == false	then
	--■631■古砦囚人NPCチェックポイント(スタート地点)■ --EN:--■631■Old Fort Prisoner NPC Checkpoint (start point)■
		proxy:OnRegionJustIn( 631 , 10000 , 2300 ,"OnEvent_631" , everytime);
	
	--■632■古砦囚人NPCチェックポイント(審判者の部屋)■ --EN:-- 632 Old Fort Prisoner NPC Checkpoint (Judge's Room)
		proxy:OnRegionJustIn( 632 , 10000 , 2301 , "OnEvent_632" , everytime);
	
	--■634■古砦囚人NPCチェックポイント(嵐の戦士の部屋)■ --EN:-- 634 Old Fort Prisoner NPC Checkpoint (Storm Warrior Room)
		proxy:OnRegionJustIn( 633 , 10000 , 2550 , "OnEvent_633" , everytime);
	end
	
	--■635■チェックポイントの監視■ --EN:-- ■ 635 ■ Checkpoint monitoring ■
	proxy:LuaCall( 634 , 1 , "OnEvent_634",everytime);

--------------------------------▽▽▽QWCイベント関連▽▽▽-------------------------------- --EN:--▽▽▽QWC event related ▽▽▽--------------------------------
----------------------------------------------------------------
--マスターサツキ(638) --EN:--Master Satsuki (638)
----------------------------------------------------------------
	--マスターサツキの初期状態を「剣を探している」にセットする --EN:--Set Master Satsuki's initial state to "Looking for a sword"
	SetFirstNpcStateFlag( proxy, param, MasterParamFlag_list, MasterSATSUKI_NORMAL );

	if proxy:IsCompleteEvent(MasterSATSUKI_NORMAL) == false or	--「剣を探している」でない　か --EN:--Isn't it "looking for a sword"?
	   proxy:IsSuccessQWC(30120) == true or--QWCが成立している　か --EN:--Is QWC established?
	   proxy:IsSuccessQWC(30130) == true then--QWCが成立している　ならば --EN:--If QWC is established
		--■703■サツキ(638)無効化■ --EN:-- ■ 703 ■ Satsuki (638) disabled ■
		InvalidBackRead(proxy, 638);--サツキ(638)無効化 --EN:-- Satsuki (638) disabled
		
		print("サツキ(638)出現条件を満たしていない"); --EN:print("Satsuki (638) does not meet the appearance conditions");
		proxy:SetEventFlag(702, false);
		proxy:SetEventFlag(703, true);
	else--「剣を探している」かつQWC条件を満たしているならば --EN:--if you're looking for a sword and meet the QWC requirements
		--■702■サツキ(638)有効化■ --EN:-- ■ 702 ■ Satsuki (638) activation ■
		proxy:SetDeadMode(638, true);--HPが1以下にならない --EN:--HP does not drop below 1
		
		--■700■サツキが去る■ --EN:-- ■ 700 ■ Satsuki leaves ■
		SingleReset( proxy,700 );
		if proxy:IsCompleteEvent(700) == false then
			proxy:OnCharacterTotalDamage(700, 638, -1, 1, "OnEvent_700", once);--ダメージ監視追加（ダメージ量１） --EN:--Added damage monitoring (damage amount 1)
		end
		
		--■701■サツキが消える■ --EN:-- ■ 701 ■ Satsuki disappears ■
		SingleReset( proxy,701 );
		if proxy:IsCompleteEvent(701) == false then
			proxy:OnRegionJustIn(701,638,2241,"OnEvent_701",once);--領域監視追加 --EN:--Add area monitor
		end
		
		print("サツキ(638)出現"); --EN:print("Satsuki (638) appears");
		proxy:SetEventFlag(703, false);
		proxy:SetEventFlag(702, true);
	end
----------------------------------------------------------------
--マスターサツキ(637) --EN:--Master Satsuki (637)
----------------------------------------------------------------
	--マスターサツキの状態変化の処理 --EN:--Handling Master Satsuki's status change
	if proxy:IsCompleteEvent( MasterSATSUKI_DEAD ) == false then--死んでいないならば --EN:--if not dead
		if proxy:IsCompleteEvent( MasterSATSUKI_HOSTILE ) == false and		   --敵対していない　かつ --EN:--not hostile and
           proxy:IsCompleteEvent( MasterSATSUKI_HOSTILE_Makoto ) == false then --敵対（誠）していない　ならば --EN:--If you are not hostile (sincere)
			--■704■サツキ敵対化■ --EN:-- ■ 704 ■ Satsuki hostile ■
			proxy:OnCharacterTotalRateDamage( 704, 637, LOCAL_PLAYER, NPC_ANGRY_Rate, "OnEvent_704", once );
			--■705■サツキ敵対化(誠入手)■ --EN:-- ■ 705 ■ Satsuki becomes hostile (obtained by Makoto) ■
			proxy:LuaCall( 705, 0, "OnEvent_705", once );--サツキに「誠」を渡しての敵対処理 --EN:-- Hostile handling by handing "Makoto" to Satsuki
			proxy:LuaCall( 713, 0, "OnEvent_713", once );--サツキに「誠+1」を渡しての敵対処理 --EN:-- Hostile handling by handing Satsuki "Makoto +1"
			proxy:LuaCall( 714, 0, "OnEvent_714", once );--サツキに「誠+2」を渡しての敵対処理 --EN:-- Hostile handling by handing Satsuki "Makoto +2"
			proxy:LuaCall( 715, 0, "OnEvent_715", once );--サツキに「誠+3」を渡しての敵対処理 --EN:-- Hostile handling by handing Satsuki "Makoto +3"
			proxy:LuaCall( 716, 0, "OnEvent_716", once );--サツキに「誠+4」を渡しての敵対処理 --EN:-- Hostile handling by handing Satsuki "Makoto +4"
			proxy:LuaCall( 717, 0, "OnEvent_717", once );--サツキに「誠+5」を渡しての敵対処理 --EN:-- Hostile handling by handing Satsuki "Makoto +5"
			
			
			--■706■サツキ敵対化(誠未入手)■ --EN:-- ■ 706 ■ Satsuki hostile (Makoto not obtained) ■
			proxy:LuaCall( 706, 0, "OnEvent_706", once );--サツキに「誠」を渡さないでの敵対処理 --EN:-- Hostile handling without giving "Makoto" to Satsuki
		end
		--■707■サツキ死亡■ --EN:-- ■ 707 ■ Satsuki died ■
		proxy:OnCharacterDead( 707, 637, "OnEvent_707", once );--死亡監視追加 --EN:--Add death watch
	end

	--マスターサツキの初期化処理 --EN:--Initialize Master Satsuki
	if proxy:IsSuccessQWC(30130) == true then--QWC条件を満たしている　ならば --EN:--If the QWC conditions are met
		if proxy:IsCompleteEvent( MasterSATSUKI_HOSTILE ) == true then--マスターサツキが敵対していた時の初期化処理 --EN:--Initialization processing when Master Satsuki was hostile
			--■708■サツキ敵対初期化■ --EN:-- ■ 708 ■ Satsuki Hostile Initialization ■
			proxy:EnableLogic(637, true);--ロジックON --EN:--Logic ON
			proxy:SetTeamType(637, TEAM_TYPE_AngryFriend);--チームタイプ変更 --EN:--Change team type
			--SetNpcStateFlag(proxy, param, MasterParamFlag_list, MasterSATSUKI_HOSTILE);--状態変化 --EN:-- state change
			proxy:SetEventFlag(708, true);
			print("サツキ(637)状態　敵対"); --EN:print("Satsuki (637) state hostile");
			
		elseif proxy:IsCompleteEvent(MasterSATSUKI_HOSTILE_Makoto) == true then--マスターサツキが敵対(誠装備)していた時の初期化処理 --EN:--Initialization processing when Master Satsuki is hostile (equipped with Makoto)
			--■709■サツキ敵対(誠)初期化■ --EN:-- ■ 709 ■ Satsuki Hostile (Makoto) Initialization ■
			
			--TargetChangeWepR2(proxy, 637);--サブ武器（誠）に切り替えさせる --EN:-- Switch to sub-weapon (Makoto)
			
			proxy:EnableLogic(637, true);--ロジックON --EN:--Logic ON
			proxy:NotNetMessage_begin();
				proxy:OnKeyTime2( 705,"OnEvent_705_1",0.0,0,0,once);
			proxy:NotNetMessage_end();
			proxy:SetTeamType(637, TEAM_TYPE_AngryFriend);--チームタイプ変更 --EN:--Change team type
			--SetNpcStateFlag(proxy, param, MasterParamFlag_list, MasterSATSUKI_HOSTILE_Makoto);--状態変化 --EN:-- state change
			proxy:SetEventFlag(709, true);
			print("サツキ(637)状態　敵対（誠）"); --EN:print("Satsuki (637) state hostile (sincere)");
			
		elseif proxy:IsCompleteEvent( MasterSATSUKI_DEAD ) == true then--マスターサツキが死亡していた時の初期化処理 --EN:--Initialization process when Master Satsuki is dead
			--■710■サツキ死亡初期化■ --EN:-- ■ 710 ■ Satsuki death initialization ■
			InvalidBackRead(proxy, 637);--無効化 --EN:--Invalidation
			proxy:SetEventFlag(710, true);
			print("サツキ(637)状態　死亡"); --EN:print("Satsuki (637) state death");
			
		end
	else--QWC条件を満たしていない　ならば --EN:--If the QWC conditions are not met
		--■710■サツキ無効初期化■ --EN:-- ■ 710 ■ Satsuki invalid initialization ■
		InvalidBackRead(proxy, 637);--無効化 --EN:--Invalidation
		proxy:SetEventFlag(710, true);
		print("サツキ(637)状態　出現条件を満たしていない"); --EN:print("Satsuki (637) state appearance conditions are not met");
	
	end
----------------------------------------------------------------
--マスターサツキ・ブラック(420) --EN:--Master Satsuki Black (420)
----------------------------------------------------------------


--■15634■サツキ・ブラックの死体を調べた■ --EN:--■15634■Examined Satsuki Black's corpse■
	if proxy:IsCompleteEvent( 15634 ) == false then
		proxy:AddCorpseEvent( 15634 , 420 );
		proxy:NotNetMessage_begin();
			proxy:LuaCall( 15634 ,0 , "OnEvent_15634",once );
 		proxy:NotNetMessage_end();
	end
	
	if	proxy:IsCompleteEvent(711) == false and --死亡していない　かつ --EN:--not dead and
		proxy:IsSuccessQWC(30120) == true then --QWC条件を満たしている　ならば --EN:--If the QWC conditions are met
		--■711■サツキ・ブラック死亡監視■ --EN:-- ■ 711 ■ Satsuki Black death watch ■
		proxy:OnCharacterDead( 711, 420, "OnEvent_711", once );--死亡監視追加 --EN:--Add death watch
--		proxy:SetTeamType( 420, TEAM_TYPE_AngryFriend );--チームタイプ変更　敵対		 --EN:-- Team type change Hostile
		
		proxy:SetEventFlag(712, false);
		
		print("サツキ・ブラック（420）出現"); --EN:print("Satsuki Black (420) appears");
	else--死亡しているかQWCをみたしていないならば --EN:--if dead or not meeting QWC
		--■712■サツキ・ブラック死亡初期化■ --EN:-- ■ 712 ■ Satsuki Black death initialization ■
		if 	proxy:IsCompleteEvent( 711 ) == true and
			proxy:IsCompleteEvent( 15634 ) == false then
			--死体を再現する --EN:--reproduce the corpse
			proxy:OpeningDeadPlus( 420 , true ,false ,false );
		else
			InvalidBackRead(proxy, 420);
		end
		proxy:SetEventFlag(712, true);
		print("サツキ・ブラック（420）状態　無効"); --EN:print("Satsuki Black (420) status invalid");
	end

----------------------------------------------------------------
--QWCソウルモンスター --EN:--QWC Soul Monster
----------------------------------------------------------------

--■690■QWCソウルモンスター出現１■ --EN:-- ■ 690 ■ QWC Soul Monster Appearance 1 ■
	if	proxy:IsSuccessQWC(30100) == true then
		print("m03_01 QWCソウルモンスター出現　成立"); --EN:print("m03_01 QWC soul monster appears established");
		ValidCharactor( proxy, 428 );
		ValidCharactor( proxy, 429 );
		ValidCharactor( proxy, 430 );
		ValidCharactor( proxy, 431 );
		ValidCharactor( proxy, 432 );
	else
		print("m03_01 QWCソウルモンスター出現　未成立"); --EN:print("m03_01 QWC soul monster appears unestablished");
		InvalidCharactor( proxy, 428 );
		InvalidCharactor( proxy, 429 );
		InvalidCharactor( proxy, 430 );
		InvalidCharactor( proxy, 431 );
		InvalidCharactor( proxy, 432 );
	end
	
	RegistTokage( proxy, 620 , 250,7);
	RegistTokage( proxy, 622 , 251,8);
--------------------------------△△△QWCイベント関連△△△-------------------------------- --EN:--△△△QWC event related△△△--------------------------------

--------------------------------------------------------------------------------------
--整理済み↑　未整理↓■Initialize_m03_01_00_00 --EN:--Arranged↑　Unorganized↓■Initialize_m03_01_00_00
--------------------------------------------------------------------------------------
--■??■徘徊デーモンの登場■ハンドラ登録 --EN:--■??■Appearance of wandering daemon■Handler registration
	proxy:NotNetMessage_begin();
		--プレイヤーがソロで死亡した時にキックされます。 --EN:--Kicked when a player dies solo.
		proxy:LuaCall( 4000, 100, "PlayerDeath_m03_01_00_00", everytime );
		--プレイヤーが復活した時にキックされます。 --EN:--Kicked when the player is revived.
		proxy:LuaCall( 4032, 100, "PlayerRevive_m03_01_00_00", everytime );
	proxy:NotNetMessage_end();

	
--■682■ボス戦カメラ対応■ --EN:-- ■ 682 ■ Boss battle camera support ■
	--ボスが生きているなら登録 --EN:--Register if the boss is alive
	if proxy:IsCompleteEvent(4756) == false then
		proxy:NotNetMessage_begin();
			proxy:OnRegionIn( 682 , 10000 , 2886 ,"OnEvent_682" , everytime );
		proxy:NotNetMessage_end();
	end

--[[
	--フラグを見てNPC状態を初期化 --EN:--Initialize the NPC state by looking at the flag
	SetFirstNpcStateFlag( proxy, param, syuujin_flag_list, SYUUJIN_STATE_ESCAPE )

	--死亡していないとき --EN:--when not dead
	if proxy:IsCompleteEvent( SYUUJIN_STATE_DEAD ) == false then
		--敵対していないとき --EN:--When not hostile
		if proxy:IsCompleteEvent( SYUUJIN_STATE_ANGRY_01 ) == false then
			--EzStateにコマンド送信:うつぶせ待機になる --EN:--Send command to EzState: Stand down and wait
			proxy:SetEventCommand(633,30);
			--■627■【水牢NPC】NPCが感謝状態じゃない■ --EN:--■627■ [Water Prison NPC] NPC is not in gratitude ■
			if proxy:IsCompleteEvent( 627 ) == false then
				proxy:OnRegistFunc( 627, "Condition_627", "OnEvent_627", 1, once );				
			end	
			--■628■【水牢NPC】NPCからアイテムをもらってない■ --EN:--■628■ [Water Prison NPC] I haven't received any items from the NPC■
			if proxy:IsCompleteEvent( 628 ) == false then
				proxy:NotNetMessage_begin();
					proxy:LuaCall( 628, 0, "OnEvent_628", once );
				proxy:NotNetMessage_end();
			end
			--■629■【水牢NPC】NPCが敵になってない■ --EN:--■629■ [Water Prison NPC] NPC is not an enemy■
			if proxy:IsCompleteEvent( 629 ) == false then
				proxy:OnCharacterTotalDamage( 629, 633, 10000, 50, "OnEvent_629", once );
			end
			
		--それ以外の初期化 --EN:--other initialization
		else
			print("意味の無い所"); --EN:print("meaningless place");
			proxy:EnableLogic( 633, false );
		end
		--■630■【水牢NPC】NPCが死んだ■ --EN:--■630■ [Water Prison NPC] NPC died■
		if proxy:IsCompleteEvent( 630 ) == false then
			proxy:OnCharacterDead( 630, 633, "OnEvent_630", once );		
		end
	else
		print("水牢NPC死亡");		 --EN:print("water prison NPC dead");
		--死んでいるので無効化		 --EN:--disabled because it's dead
		proxy:ForceUpdateNextFrame(633);
		InvalidBackRead(proxy, 633 );		
	end	
	]]
	--古砦囚人状態変化詰め合わせ --EN:--Old Fort Prisoner Status Change Assortment
	OnEvent_634(proxy,param);
	--なんだこのInvalid・・・ --EN:--What is this Invalid...
	--InvalidCharactor(proxy,326);
	
--■550■デブデーモン死亡監視■ --EN:--■550■Fat Demon Death Watch■
	if proxy:IsCompleteEvent( 550 ) == false then
		proxy:OnCharacterDead( 550 , 421 , "OnEvent_550",once);
		proxy:NotNetMessage_begin();
			proxy:OnRegionIn( 552 , 10000, 2269 , "OnEvent_552",everytime);
		proxy:NotNetMessage_end();
	else
		InvalidCharactor( proxy , 421 );
	end
	
--■790■魔法の壁破壊１■ --EN:-- ■ 790 ■ magic wall destruction 1 ■
	SingleReset(proxy,790);
	if proxy:IsCompleteEvent( 790 ) == false then
		--復帰 --EN:--return
		proxy:RestorePiece( 1270 );
		proxy:OnObjectDestroy( 790 , 1270 ,"OnEvent_790",once);
	else
		proxy:ReconstructBreak( 1270,1);
	end
	
--■791■魔法の壁破壊２■ --EN:-- ■ 791 ■ magic wall destruction 2 ■
	SingleReset(proxy,791);
	if proxy:IsCompleteEvent( 791 ) == false then
		--復帰 --EN:--return
		proxy:RestorePiece( 1271 );
		proxy:OnObjectDestroy( 791 , 1271 ,"OnEvent_791",once);
	else
		proxy:ReconstructBreak( 1271,1);
	end


--■15500■乱入アイテム取得監視■ハンドラはグローバルに定義 --EN:-- ■ 15500 ■ Intrusion item acquisition monitoring ■ Handlers are defined globally
--~ 	if proxy:IsCompleteEvent( 15500 ) == false then		
--~ 		proxy:AddCorpseEvent( 15500 , 420 );--マスターサツキ・ブラック --EN:--Master Satsuki Black
--~ 	end
	
	-----------------------------------------------------------------------------
	--■999999■フレーム遅れの初期化処理イベントを発行■ --EN:-- ■ 999999 ■ Generate a frame delay initialization processing event ■
	proxy:NotNetMessage_begin();
		--▼0秒後▼-- --EN:--▼After 0 seconds▼--
		proxy:OnKeyTime2( 999991, "Second_Initialize_m03_01_00_00", 0.0, 0, 0, once );	
	proxy:NotNetMessage_end();	
	
	if proxy:IsDbgReLoad() == true then
		proxy:OnKeyTime2( 4021,"OnEvent_DbgReLoad",1.0,0,0,once);
	end
	print("Initialize_m03_01_00_00 end");
end

--リロードデバッグ --EN:--reload debug
function OnEvent_DbgReLoad(proxy,param)
	--古砦要石に戻る --EN:--Return to Old Fort Keystone
	--完全回復要求 --EN:-- full recovery request
	proxy:RequestFullRecover();
	proxy:WarpNextStage( 1, 0, 0, 0, 1007);	
end


--------------------------------------------------------------------------------------
--Initializeから呼ばれる、1フレーム遅れの初期化処理■999999 --EN:--Initialization with a delay of 1 frame, called from Initialize ■999999
--------------------------------------------------------------------------------------
--■999999■一部、Initでは処理できないので、残しておく --EN:-- ■ 999999 ■ Some parts cannot be processed by Init, so leave them
function Second_Initialize_m03_01_00_00(proxy, param)
	print("Second_Initialize_m03_01_00_00 begin");

--------------------------------▽▽▽QWCイベント関連▽▽▽-------------------------------- --EN:--▽▽▽QWC event related ▽▽▽--------------------------------
--------------------------------△△△QWCイベント関連△△△-------------------------------- --EN:--△△△QWC event related△△△--------------------------------

	print("Second_Initialize_m03_01_00_00 end");
end


--------------------------------------------------------------------------------------
--マルチになった時にホストじゃ無かったら■無し --EN:--If you are not a host when you become multi, no
--------------------------------------------------------------------------------------
function ConnectPartyEvent(proxy)
	print("ConnectPartyEvent begin");
	print("ConnectPartyEvent end");
end

function OnEvent_4000_Hp_1(proxy,param)
	print("OnEvent_4000_Hp_1 begin");
	proxy:SetDeadMode2(804 , true );
	proxy:SetDeadMode2(805 , true );
	proxy:SetDeadMode2(822 , true );
	print("OnEvent_4000_Hp_1 end");
end

--[[
--同時発動によるハボックメモリテスト用 --EN:--For Havoc memory test by simultaneous activation
function test_destroy(proxy, param )
	local ObjID =0;
    for ObjID = 1208,1214,1 do
	--  proxy:ChangeModel(ObjID, 1);
	--	proxy:SetBrokenPiece(ObjID);
		proxy:ReconstructBreak( ObjID , 1 );
    end
	OnEvent_4766_1(proxy,param);
	OnEvent_4767_1(proxy,param);
	OnEvent_4768_1(proxy,param);
	OnEvent_4769_1(proxy,param);
	OnEvent_4770_1(proxy,param);
	
	OnEvent_4771_1(proxy,param);
	OnEvent_4772_1(proxy,param);
end
]]







--------------------------------------------------------------------------------------
--■644■ホストPCのみが通れる光の霧1■ --EN:-- ■ 644 ■ Light Fog 1 that only the host PC can pass through ■
--------------------------------------------------------------------------------------
--■644_delete_wall■魔法壁削除同期用■ --EN:--■644_delete_wall■For synchronized magic wall deletion■
function OnEvent_644_delete_wall(proxy , param)
	print("OnEvent_644_delete_wall begin");
	
	proxy:SetDrawEnable( 1332 , false );--描画OFF --EN:--Drawing OFF
	proxy:SetColiEnable( 1332 , false );--当たりOFF --EN:--Hit OFF
	proxy:SetObjDeactivate( 1332 , true );--デアクティブ --EN:--deactivate
	proxy:InvalidSfx( 2231 , true );--SFX OFF
	proxy:DeleteEvent( 644 );
	
	print("OnEvent_644_delete_wall end");
end

--■644■イベント発動用■ --EN:-- ■ 644 ■ For event activation ■
function OnEvent_644(proxy , param)
	print("OnEvent_644 begin");

	--多重発動防止 --EN:--Multiple activation prevention
	if proxy:IsCompleteEvent( 644 ) == true then
		print("OnEvent_644 end");
		return;
	end

	--プレイヤーの同期アニメーション(true:パーティープレイヤーがアニメーションした) --EN:--Player synchronous animation (true: party player animated)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_WALK ) == true then
		proxy:SetEventFlag( 644 , true );
		print("OnEvent_644 end");
		return;
	end
	
	--ダミポリへワープ --EN:--Warp to Damipoli
	proxy:WarpDmy( 10000 , 1332 , 191 );
	
	proxy:NotNetMessage_begin();
		--▼644_1▼歩きアニメ終了▼ --EN:--▼644_1▼End of walking animation▼
		--proxy:OnChrAnimEnd( 644 , 10000 , ANIMEID_WALK , "OnEvent_644_1" , once );
		proxy:LuaCallStart( 644 , 1 );--光の霧削除同期 --EN:--light fog removal sync
	proxy:NotNetMessage_end();
	
	proxy:SetEventFlag( 644 , true );
	
	--プロファイルセーブ要求 --EN:--profile save request
	proxy:SaveRequest_Profile();
	
	print("OnEvent_644 end");
end

--▲644_1▲歩きアニメ終了▲ --EN:--▲644_1▲End of walking animation▲
function OnEvent_644_1(proxy , param)
	print("OnEvent_644_1 begin");
	
	proxy:LuaCallStart( 644 , 1 );--光の霧削除同期 --EN:--light fog removal sync
	
	print("OnEvent_644_1 end");
end


--------------------------------------------------------------------------------------
--■645■ホストPCのみが通れる光の霧2■ --EN:-- ■ 645 ■ Fog of light that only the host PC can pass through 2 ■
--------------------------------------------------------------------------------------
--■645_delete_wall■魔法壁削除同期用■ --EN:--■645_delete_wall■For synchronized magic wall deletion■
function OnEvent_645_delete_wall(proxy , param)
	print("OnEvent_645_delete_wall begin");
	
	proxy:SetDrawEnable( 1333 , false );--描画OFF --EN:--Drawing OFF
	proxy:SetColiEnable( 1333 , false );--当たりOFF --EN:--Hit OFF
	proxy:SetObjDeactivate( 1333 , true );--デアクティブ --EN:--deactivate
	proxy:DeleteEvent( 645 );
	proxy:InvalidSfx( 2232 , true );--SFX OFF
	
	print("OnEvent_645_delete_wall end");
end

--■645■イベント発動用■ --EN:-- ■ 645 ■ For event activation ■
function OnEvent_645(proxy , param)
	print("OnEvent_645 begin");

	--多重発動防止 --EN:--Multiple activation prevention
	if proxy:IsCompleteEvent( 645 ) == true then
		print("OnEvent_645 end");
		return;
	end

	--プレイヤーの同期アニメーション(true:パーティープレイヤーがアニメーションした) --EN:--Player synchronous animation (true: party player animated)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_WALK ) == true then
		proxy:SetEventFlag( 645 , true );
		print("OnEvent_645 end");
		return;
	end
	
	--ダミポリへワープ --EN:--Warp to Damipoli
	proxy:WarpDmy( 10000 , 1333 , 191 );
	
	proxy:NotNetMessage_begin();
		--▼645_1▼歩きアニメ終了▼ --EN:--▼645_1▼End of walking animation▼
		--proxy:OnChrAnimEnd( 645 , 10000 , ANIMEID_WALK , "OnEvent_645_1" , once );
		proxy:LuaCallStart( 645 , 1 );--光の霧削除同期 --EN:--light fog removal sync
	proxy:NotNetMessage_end();
	
	proxy:SetEventFlag( 645 , true );
	
	--プロファイルセーブ要求 --EN:--profile save request
	proxy:SaveRequest_Profile();
	
	print("OnEvent_645 end");
end

--▲645_1▲歩きアニメ終了▲ --EN:--▲645_1▲End of walking animation▲
function OnEvent_645_1(proxy , param)
	print("OnEvent_645_1 begin");
	
	proxy:LuaCallStart( 645 , 1 );--光の霧削除同期 --EN:--light fog removal sync
	
	print("OnEvent_645_1 end");
end


--------------------------------------------------------------------------------------
--■646■ホストPCのみが通れる光の霧3■ --EN:-- ■ 646 ■ Light Fog 3 that only the host PC can pass through ■
--------------------------------------------------------------------------------------
--■646_delete_wall■魔法壁削除同期用■ --EN:--■646_delete_wall■For synchronized magic wall deletion■
function OnEvent_646_delete_wall(proxy , param)
	print("OnEvent_646_delete_wall begin");
	
	proxy:SetDrawEnable( 1334 , false );--描画OFF --EN:--Drawing OFF
	proxy:SetColiEnable( 1334 , false );--当たりOFF --EN:--Hit OFF
	proxy:InvalidSfx( 2233 , true );--SFX OFF
	proxy:SetObjDeactivate( 1334 , true );--デアクティブ --EN:--deactivate
	proxy:DeleteEvent( 646 );
	
	print("OnEvent_646_delete_wall end");
end

--■646■イベント発動用■ --EN:-- ■ 646 ■ For event activation ■
function OnEvent_646(proxy , param)
	print("OnEvent_646 begin");

	--多重発動防止 --EN:--Multiple activation prevention
	if proxy:IsCompleteEvent( 646 ) == true then
		print("OnEvent_646 end");
		return;
	end

	--プレイヤーの同期アニメーション(true:パーティープレイヤーがアニメーションした) --EN:--Player synchronous animation (true: party player animated)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_WALK ) == true then
		proxy:SetEventFlag( 646 , true );
		print("OnEvent_646 end");
		return;
	end
	
	--ダミポリへワープ --EN:--Warp to Damipoli
	proxy:WarpDmy( 10000 , 1334 , 191 );
	
	proxy:NotNetMessage_begin();
		--▼646_1▼歩きアニメ終了▼ --EN:--▼646_1▼End of walking animation▼
		--proxy:OnChrAnimEnd( 646 , 10000 , ANIMEID_WALK , "OnEvent_646_1" , once );
		proxy:LuaCallStart( 646 , 1 );--光の霧削除同期 --EN:--light fog removal sync
	proxy:NotNetMessage_end();
	
	proxy:SetEventFlag( 646 , true );
	
	--プロファイルセーブ要求 --EN:--profile save request
	proxy:SaveRequest_Profile();
	
	print("OnEvent_646 end");
end

--▲646_1▲歩きアニメ終了▲ --EN:--▲646_1▲End of walking animation▲
function OnEvent_646_1(proxy , param)
	print("OnEvent_646_1 begin");
	
	proxy:LuaCallStart( 646 , 1 );--光の霧削除同期 --EN:--light fog removal sync
	
	print("OnEvent_646_1 end");
end


--------------------------------------------------------------------------------------
--ボス部屋の中に入る■594 --EN:--Enter the boss room 594
--------------------------------------------------------------------------------------
--■イベントがループなので、全部リピートにする↓ --EN:--■ Since the event is a loop, repeat all ↓
--■594■中ボス部屋への扉が開く■ --EN:-- ■ 594 ■ The door to the mid-boss room opens ■
function OnEvent_594(proxy,param)
	print("OnEvent_594 begin");
	
	if proxy:IsCompleteEvent( SYSTEM_ID_IGNORE ) == true then
		print("OnEvent_594 end");
		return;
	end
	
	--クライアントへ、ボス部屋阻止失敗を通知 --EN:--Notify client of failure to block boss room
	if proxy:IsClient() == false then
		proxy:LuaCallStart( 4068 , 1 );	
	end
	
	proxy:LuaCallStart( 593 , 1 );--旋回アニメの同期再生 --EN:-- Synchronous playback of turning animation
	--proxy:SetEventFlag( SYSTEM_ID_IGNORE, true );
	--多重起動システムIDをタイムアウトを設定してONにする --EN:--Turn on multiple activation system ID by setting timeout
	proxy:SetSystemIgnore( SYSTEM_ID_IGNORE , IGNORE_TIME );
	
	--プロファイルセーブ要求 --EN:--profile save request
	proxy:SaveRequest_Profile();
	
	print("OnEvent_594 end");
end


--旋回アニメの同期再生(IDが別) --EN:-- Synchronized playback of turning animation (ID is different)
function OnEvent_594_1(proxy,param)
	print("OnEvent_594_1 begin");

	--proxy:SetEventFlag( 593 , 0 );
	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		if param:IsNetMessage() == true then
			--旋回アニメ再生を同期 --EN:-- Synchronize turning animation playback
			proxy:TurnCharactor( 10001 + param:GetPlayID(), 2890 );
		else
			proxy:LockSession();--ルームをロックします！ --EN:--lock the room!
			--旋回アニメ再生を行い、その終了時にOnEvent_593_2を発行する --EN:--Play the turning animation and issue OnEvent_593_2 at the end
			proxy:OnTurnCharactorEnd( 593, 10000, 2890, "OnEvent_594_2", once );
		end
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	
	--proxy:SetEventFlag( 593 , 1 );
	
	print("OnEvent_594_1 end");
end

--旋回アニメの同期再生終了後 --EN:--After synchronous playback of turning animation ends
function OnEvent_594_2(proxy,param)
	print("OnEvent_594_2 begin");

	--proxy:SetEventFlag( 593 , 0 );
	
	--同期用歩きアニメ再生 --EN:--Play walking animation for synchronization
	proxy:LuaCallStart( 4012, 1 );
	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		proxy:OnChrAnimEnd( 593, 10000, ANIMEID_WALK, "OnEvent_594_3", once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	
	--proxy:SetEventFlag( 593 , 1 );
	
	print("OnEvent_594_2 end");
end

--歩きアニメの同期再生終了後 --EN:--After the synchronized playback of the walking animation ends
function OnEvent_594_3(proxy,param)
	print("OnEvent_594_3 begin");

	--最初の人がボス部屋の中に入り終わっていたら、既に配信されているはずなので、もうおくらないハンドラ --EN:--If the first person has already entered the boss room, it should have already been delivered, so no more handlers
	if proxy:IsCompleteEvent( 594 ) == false then
		proxy:LuaCallStart( 593 , 5 );--2回目以降にボス部屋に入るためのイベント配信用 --EN:--For event delivery to enter the boss room after the second time
		proxy:LuaCallStart( 4045 , 1 );	--クライアントへ、ボス部屋に入れるようになったことを通知 --EN:--Notify clients that they can now enter the boss room
		proxy:LuaCallStart( 593 , 6 );--フラグセット(同期用) --EN:--flag set (for synchronization)
		Lua_MultiDoping(proxy,804);--マルチプレイドーピング --EN:-- Multiplayer Doping
	end

	--プレイヤーが扉の中に完全にはいったタイミングで、ボスの思考をリセット --EN:--Reset the boss' thoughts when the player is completely inside the door
	--場所が悪いとプレイヤーを見つけれないため(攻撃してこない) --EN:--Because you can't find the player if the location is bad (they won't attack)
	if proxy:IsLivePlayer() == true or proxy:IsGreyGhost() == true then
		proxy:ResetThink( 804 );
	end
	
	
	--proxy:SetEventFlag( 593 , 0 );--多重発動防止用フラグOFF --EN:--Multiple activation prevention flag OFF
	proxy:SetEventFlag( SYSTEM_ID_IGNORE,false);
	
	print("OnEvent_594_3 end");
end


--■594 2回目以降にボス部屋に入るためのイベント配信用 --EN:--■ 594 For event delivery to enter the boss room after the second time
function OnEvent_594_GO_TO_IN(proxy, param)
	print("OnEvent_594_GO_TO_IN begin");
	
	--proxy:SetEventFlag( 593 , 0 );
	
	proxy:NotNetMessage_begin();
		--▼593▼扉が開いているときに中に入るためのイベントを追加▼--ハンドラは OnEvent_111 --EN:--▼593▼Add an event to enter when the door is open▼--The handler is OnEvent_111
		proxy:OnPlayerActionInRegion( 593, 2894, "OnEvent_594", HELPID_GO_TO_IN, everytime );--
	proxy:NotNetMessage_end();	
	
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 593, "StandBy_Sinpansya",0.5,0,0,once);	
	proxy:NotNetMessage_end();

	--proxy:SetEventFlag( 593 , 1 );
	
	print("OnEvent_594_GO_TO_IN end");
end


--■594 フラグセット(同期用) --EN:-- 594 flag set (for synchronization)
function OnEvent_594_flag_set(proxy, param)
	print("OnEvent_594_flag_set begin");
		
	proxy:SetEventFlag( 594 , true );
	proxy:DeleteEvent( 594 );

	print("OnEvent_594_flag_set end");
end

--[[イベント削除されたのでコメントアウト --EN:--[[Commented out because the event was deleted
--------------------------------------------------------------------------------------
--閂(かんぬき)扉A■532 --EN:--Bar door A 532
--------------------------------------------------------------------------------------
function OnEvent_532(proxy, param)
	print("OnEvent_532 begin");
	
	--閂扉アニメ再生(扉が開く) --EN:--Play bar door animation (door opens)
	proxy:PlayAnimation( 1204, 1 );

	--プレイヤーの同期アニメーション(true:パーティープレイヤーがアニメーションした) --EN:--Player synchronous animation (true: party player animated)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_KICK ) == true then
		print("OnEvent_532 end");
		proxy:SetEventFlag( 532, true );
		return;
	end

	proxy:WarpDmy( 10000 , 1204 , 191 );
	proxy:SetEventFlag( 532, true );
	
	print("OnEvent_532 end");
end]]


--[[
--------------------------------------------------------------------------------------
--鷹の攻撃■636 --EN:--Hawk attack 636
--------------------------------------------------------------------------------------
--■636■鷹の攻撃■ --EN:-- ■ 636 ■ Hawk attack ■
function Check_636(proxy,param)
	local region = { 2278 };
	local tblnum = table.getn(region);
	local index =0;
	local isIn = false;
	
	for index = 1, tblnum, 1 do
		if proxy:IsRegionIn(10000,region[index]) == true then
			isIn = true;
			break;
		end
	end
	
	--領域に入ってない時のみ処理 --EN:-- Process only when not in the area
	if isIn == false then
		proxy:SetInsideBattleArea(325,0);
	end
	
	return isIn;
end

--領域に入っている --EN:-- is in the realm
function OnEvent_636(proxy,param)
	proxy:SetInsideBattleArea(325,1);
end

--鷹が死んだ --EN:--falcon dead
function OnEvent_636_1(proxy,param)
	print("OnEvent_636_1 begin");
	proxy:DeleteEvent( 636 );
	print("OnEvent_636_1 end");
end
]]
--[[
--------------------------------------------------------------------------------------
--鷹の攻撃■637 --EN:--Hawk attack 637
--------------------------------------------------------------------------------------
--■637■鷹の攻撃■ --EN:-- ■ 637 ■ Hawk attack ■
function Check_637(proxy,param)
	local region = { 2279 };
	local tblnum = table.getn(region);
	local index =0;
	local isIn = false;
	
	for index = 1, tblnum, 1 do
		if proxy:IsRegionIn(10000,region[index]) == true then
			isIn = true;
			break;
		end
	end
	
	--領域に入ってない時のみ処理 --EN:-- Process only when not in the area
	if isIn == false then
		proxy:SetInsideBattleArea(326,0);
	end
	
	return isIn;
end

--領域に入っている --EN:-- is in the realm
function OnEvent_637(proxy,param)
	proxy:SetInsideBattleArea(326,1);
end

--鷹が死んだ --EN:--falcon dead
function OnEvent_637_1(proxy,param)
	print("OnEvent_637_1 begin");
	proxy:DeleteEvent( 637 );
	print("OnEvent_637_1 end");
end
]]
--[[
--------------------------------------------------------------------------------------
--鷹の攻撃■638 --EN:--Hawk attack 638
--------------------------------------------------------------------------------------
--■638■鷹の攻撃■ --EN:-- ■ 638 ■ Hawk attack ■
function Check_638(proxy,param)
	local region = { 2280 };
	local tblnum = table.getn(region);
	local index =0;
	local isIn = false;
	
	for index = 1, tblnum, 1 do
		if proxy:IsRegionIn(10000,region[index]) == true then
			isIn = true;
			break;
		end
	end
	
	--領域に入ってない時のみ処理 --EN:-- Process only when not in the area
	if isIn == false then
		proxy:SetInsideBattleArea(327,0);
	end
	
	return isIn;
end

--領域に入っている --EN:-- is in the realm
function OnEvent_638(proxy,param)
	proxy:SetInsideBattleArea(327,1);
end

--鷹が死んだ --EN:--falcon dead
function OnEvent_638_1(proxy,param)
	print("OnEvent_638_1 begin");
	proxy:DeleteEvent( 638 );
	print("OnEvent_638_1 end");
end
]]

--------------------------------------------------------------------------------------
--ボスBGM停止■642 --EN:-- Boss BGM stop ■ 642
--------------------------------------------------------------------------------------
--■642■ボスが死んだ瞬間■ --EN:-- ■ 642 ■ The moment the boss died ■
function OnEvent_642(proxy,param)
	print("OnEvent_642 begin");	
	proxy:NotNetMessage_begin();
		--▼4756▼***条件追加***1秒後に扉が開く▼ --EN:--▼4756▼***Condition added***Door opens after 1 second▼
		proxy:OnKeyTime2( 642, "OnEvent_642_1", 0, 0, 0, once );
	proxy:NotNetMessage_end();
	print("OnEvent_642 end");
end

--■642_1■死んでから1秒後■ --EN:--■642_1■1 second after death■
function OnEvent_642_1(proxy,param)
	print("OnEvent_642_1 begin");
	proxy:StopPointSE( 1 );--ボス戦用BGM停止 --EN:--BGM stop for boss battle
	proxy:SetEventFlag( 642 ,true );
--	BlockClear(proxy,param);
	print("OnEvent_642_1 end");
end


--------------------------------------------------------------------------------------
--中ボス死亡で扉が開く■4756 --EN:--The door opens when the mid-boss dies ■4756
--------------------------------------------------------------------------------------
--■4756■中ボス死亡で扉が開く■ --EN:--■4756■The door opens when the mid-boss dies■
function OnEvent_4756(proxy, param)
	print("OnEvent_4756 begin");
	
	proxy:NotNetMessage_begin();
		--▼4756_1▼***条件追加***0秒後に扉が開く▼ --EN:--▼4756_1▼***Condition added***The door will open after 0 seconds▼
		proxy:OnKeyTime2( 4756, "OnEvent_4756_1", 0, 0, 0, once );
		--▼4756_2▼2秒経過▼ --EN:--▼4756_2▼2 seconds passed▼
		proxy:OnKeyTime2( 4992, "OnEvent_4756_2", 0, 0, 1, once);
	proxy:NotNetMessage_end();
	
	proxy:CustomLuaCallStart( 4050 , 804 );--ブロッククリア処理 --EN:--Block clear processing
	--トカゲリセット --EN:-- lizard reset
	ResetTokage(proxy);
	
	--マルチプレイ時にすぐ次のエリアにいけてしまう問題回避 --EN:--Avoid the problem of going to the next area immediately during multiplayer
	proxy:NotNetMessage_begin();
		proxy:OnRegistFunc( 4756 , "Check_4756_PT","OnEvent_4756_PT",0,once);
	proxy:NotNetMessage_end();
	
	proxy:SetEventFlag( 4756, true );--ボスの死亡記録用 --EN:--For boss death records
	proxy:SetEventFlag( 4800, true );--新仕様のフラグも立てる --EN:-- Flag for new specifications

	print("OnEvent_4756 end");
end

--▲4756_1▲0秒後に扉が開く▲ --EN:--▲4756_1▲The door opens after 0 seconds▲
function OnEvent_4756_1(proxy, param)
	print("OnEvent_4756_1 begin");	
	
	--ボスを倒した数を更新(数によってフラグを立てる) --EN:--update number of bosses killed (flag by number)
	GetBossFlagCount( proxy, param );
--アイテム入手関連------- --EN:--Item Acquisition Related-------
	
	--ホストプレイヤーのみアイテム入手イベントに使用 --EN:--Used for item acquisition event only for host players
	local possible_chr_type = ATTR_HOST + ATTR_LIVE + ATTR_GREY;

	--宝死体(ソウル?)有効化 --EN:--Treasure corpse (soul?) activation
	proxy:SetDrawEnable( 1981 , true );
	proxy:SetColiEnable( 1981 , true );
	--宝死体(ソウル?)2有効化 --EN:--Treasure corpse (soul?) 2 enabled
	proxy:SetDrawEnable( 1976 , true );
	proxy:SetColiEnable( 1976 , true );
	
	--▼(ソウル)アイテム取得用イベント監視追加▼ --EN:--▼ (Soul) Added event monitoring for item acquisition▼
	if proxy:IsCompleteEvent( 4804 ) == false then
		proxy:ValidSfx( 2287 );--光の粒子 --EN:--Particles of light
		proxy:ValidSfx( 2286 );--SFX 有効化 --EN:--SFX enable
		proxy:TreasureDispModeChange2( 1981 , true ,KANAME_SFX);--光らせる --EN:-- let it shine
		proxy:OnDistanceActionAttribute( 4804 , 10000 , 1981 , "OnEvent_4804" , WarpGimmickDist_A , 10010180 , 0 , 180 , possible_chr_type, once );
	end
------------------------
	
	--▼トロフィーの取得▼ --EN:--▼Obtain trophies▼
	Lua_RequestUnlockTrophy( proxy, 30 );
	
	--古砦囚人の状態遷移チェック --EN:--Check state transition of Old Fort Prisoner
	OnEvent_634(proxy,param)
	
	print("OnEvent_4756_1 end");
end

--▲4756_2▲城内部扉開放:中ボス死亡後0秒▲ --EN:--▲4756_2▲Open the door inside the castle: 0 seconds after the middle boss dies▲
function OnEvent_4756_2(proxy, param)
	print("OnEvent_4756_2 begin");
		
	--ボス戦用のBGM停止 --EN:--BGM stop for boss battles
	proxy:StopPointSE( 1 );	
	
	print("OnEvent_4756_2 end");
end

--PTを組んでいるかのチェック --EN:-- Check if PT is formed
function Check_4756_PT(proxy)
	if proxy:IsInParty() == false then
		return true;
	end
	return false;
end

--PT解散が終わったイベント --EN:--Event after PT disbandment
function OnEvent_4756_PT(proxy,param)
	print("OnEvent_4756_PT begin");
	
	proxy:PlayAnimation( 1206, 1 );	--扉アニメ再生 --EN:--Play door animation
	
	--中ボス部屋の前後の魔法壁が消える(全プレイヤー)	 --EN:--The magic walls before and after the mid-boss room disappear (all players)
	proxy:SetColiEnable( 1998 , false );	
	proxy:SetDrawEnable( 1998 , false );
	--proxy:SetObjDeactivate( 1998 , true );--デアクティブ --EN:--deactivate
	
	proxy:SetColiEnable( 1994 , false );	
	proxy:SetDrawEnable( 1994 , false );
	--proxy:SetObjDeactivate( 1994 , true );--デアクティブ --EN:--deactivate
	
	--中ボス部屋魔法壁のSFX削除 --EN:--Remove the SFX of the mid-boss room magic wall
	proxy:InvalidSfx( 1990 , true );
	proxy:InvalidSfx( 1986 , true );
	
	--中ボス部屋前の移動処理イベントを削除 --EN:--Delete the movement processing event in front of the mid-boss room
	proxy:DeleteEvent( 594 );--一人目が入るとき用 --EN:--For when the first person enters
	proxy:DeleteEvent( 593 );--二人目以降が入るとき用 --EN:--For when the second and subsequent people enter
	proxy:DeleteEvent( 641 );--ボス戦闘開始用	 --EN:--For boss battle start
	print("OnEvent_4756_PT end");
end


--------------------------------------------------------------------------------------
--■4805■石柱にワープ■ --EN:-- ■ 4805 ■ Warp to the stone pillar ■
--------------------------------------------------------------------------------------
function OnEvent_4805(proxy,param)	
	print("OnEvent_4805 begin");
	
	proxy:RepeatMessage_begin();
		--▼70_1▼選択メニューの監視▼ --EN:--▼70_1▼Select menu monitoring▼
		proxy:OnSelectMenu(4805, "OnEvent_4805_1", 10010710, 0, 2, 1981, 2, once);			
	proxy:RepeatMessage_end();
	
	print("OnEvent_4805 end");
end

--▲4805_1▲選択メニューの監視▲ --EN:--▲4805_1▲Monitor selection menu▲
function OnEvent_4805_1(proxy,param)	
	print("OnEvent_4805_1 begin");
	
	if proxy:IsSession() == false then
		if param:IsNetMessage() == true then
			proxy:PlayAnimation(10001+param:GetPlayID(),8305);
			print("OnEvent_4805_1 end");
			return;
		end
			
		proxy:PlayAnimation(10000,8283);
		proxy:NoAnimeTurnCharactor( 10000 , 1981 ,TURNSKIP_ANGLE);
		proxy:NotNetMessage_begin();
		proxy:RepeatMessage_begin();
			proxy:OnChrAnimEnd( 4805 , 10000 , 8283 , "OnEvent_4805_2",once);
		proxy:RepeatMessage_end();
		proxy:NotNetMessage_end();
			
		proxy:SetEventFlag(4805,true);
	else
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010720, 0, 6, 1983, GEN_DIALOG_DIST, once );
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
	end
	print("OnEvent_4805_1 end");
end

--■4805_2■石柱にワープ■ --EN:--■ 4805_2 ■ Warp to the stone pillar ■
function OnEvent_4805_2(proxy,param)	
	print("OnEvent_4805_2 begin");	
	
	proxy:PlayAnimation( 10000 , 8284 );--自世界に帰るアニメを再生 --EN:--Play animation to return to your own world
	--石柱へ戻ってきた判定のフラグを立てる --EN:--Flag the judgment of returning to the stone pillar
	proxy:SetEventFlag(8083, true);
	
	--古砦要石に戻る --EN:--Return to Old Fort Keystone
	--完全回復要求 --EN:-- full recovery request
	proxy:RequestFullRecover();
	proxy:WarpNextStage( 1, 0, 0, 0, 1007);	
	print("OnEvent_4805_2 end");
end

--------------------------------------------------------------------------------------
--■4804■ソウル入手■ --EN:-- ■ 4804 ■ Get Soul ■
--------------------------------------------------------------------------------------
function OnEvent_4804(proxy, param)
	print("OnEvent_4804 begin");
	
	--プレイヤーの同期アニメーション(true:パーティープレイヤーがアニメーションした) --EN:--Player synchronous animation (true: party player animated)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_PICK ) == true then--新しいアニメ  --EN:-- new anime
		print("OnEvent_4804 end");
		return true;
	end
	
	proxy:NotNetMessage_begin();
		--0.0秒後にアイテム取得イベントを発行 --EN:-- Issue an item acquisition event after 0.0 seconds
		proxy:OnKeyTime2( 4804, "OnEvent_4804_1", 0.0, 0, 0, once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_4804 end");
end


--■4804_1■アイテム取得■ --EN:-- ■ 4804_1 ■ item acquisition ■
function OnEvent_4804_1(proxy, param)
	print("OnEvent_4804_1 begin");

	--アイテム取得関数--パラメータ10230参照 --EN:--item retrieval function--see parameter 10230
	proxy:GetRateItem(10230);	
	--アイテム取得関数--パラメータ10270参照 --EN:--item retrieval function--see parameter 10270
	proxy:GetRateItem(10270);	
	--アイテム取得関数--パラメータ10271参照 --EN:--item retrieval function--see parameter 10271
	proxy:GetRateItem(10271);	
	--アイテム取得関数--パラメータ10272参照 --EN:--item retrieval function--see parameter 10272
	proxy:GetRateItem(10272);	
	--アイテム取得関数--パラメータ10273参照 --EN:--item retrieval function--see parameter 10273
	proxy:GetRateItem(10273);	
	
	--アイテムを取得済み --EN:--item already acquired
	proxy:SetEventFlag( 4804, true	);
	--宝箱シェーダーは消えない --EN:--The treasure chest shader does not disappear
	--proxy:TreasureDispModeChange( 1981 , false );

	--SFXが消える --EN:--SFX disappear
	proxy:InvalidSfx( 2286 , true );
	--proxy:InvalidSfx( 2287 , true );--光の粒子 --EN:--Particles of light
		
	--▼要石でワープ用の監視を追加▼ --EN:--▼ Added surveillance for warp with keystone ▼
	proxy:OnDistanceActionAttribute( 4805 , 10000 , 1981 , "OnEvent_4805" , WarpGimmickDist_A , HELPID_GO_TO_SEKITYUU , 0 , 180 , ATTR_NOSESSION , everytime );

	print("OnEvent_4804_1 end");
end

--------------------------------------------------------------------------------------
--はしごA上■542 --EN:--Upper ladder A 542
--------------------------------------------------------------------------------------
--■542■はしごA上■ --EN:-- ■ 542 ■ ladder A top ■
function OnEvent_542(proxy, param)
	print("OnEvent_542 begin");

	if param:IsNetMessage() == true then
		print("IsNetMessage true");
		print("OnEvent_542 end");
		return;
	end

	--はしご降りに必要な前処理-- --EN:--Pretreatment required for descending the ladder--
	proxy:BeginAction(10000,2,2,2);				--ホバー移動モードに移行 --EN:--Transition to hover movement mode
	proxy:HoverMoveValDmy(10000,1330,192,LadderTime_A);--移動位置(192)に0.5秒でホバー移動 --EN:--Hover to move position (192) in 0.5 seconds
	proxy:SetEventCommand(10000,1);				--イベントコマンドID(1)"ハシゴ上から掴"むを送る --EN:-- Send event command ID (1) "Grab from the top of the ladder"
	proxy:SetKeepCommandIndex(10000, 0, 1, 3.0 );
	proxy:DisableMove(10000,1);					--キャラクタを移動、旋回不能に --EN:--Move the character, make it impossible to turn
	
	proxy:NotNetMessage_begin();
		--0.5秒(ホバー移動終了)後にはしご降りスタートイベントを発行 --EN:-- Issue a ladder descend start event after 0.5 seconds (end of hover movement)
		proxy:OnKeyTime2(542,"OnEvent_542_1",LadderTime_A,0,0,once);
		--はしご降り専用の関数を3秒間発行(カメラの周り込みなどの処理) --EN:--Issue a function dedicated to descending the ladder for 3 seconds (processing such as surrounding the camera)
		proxy:OnKeyTime2(542,"LadderDown",3.0,1,1,once);
	proxy:NotNetMessage_end();

	print("OnEvent_542 end");
end

function OnEvent_542_1(proxy, param)
	print("OnEvent_542_1 begin");
	
	if proxy:GetEventMode(10000) == 0 then
		print("Local Player GetEventMode 0");
		print("OnEvent_542_1 end");
		return;
	end

	--ハシゴアクションモードに移行-- --EN:--Transition to ladder action mode--
	--nMax  : はしごの段数 - 補正値(補正値はおおよそ3) --EN:--nMax : number of ladder steps - correction value (correction value is approximately 3)
	--nStart: 降りるとき→(nMax + 1) 昇るとき→(-1) --EN:--nStart: When going down→(nMax + 1) When going up→(-1)
	proxy:BeginAction(10000,1,7,6);
	
	--キャラクタを移動、旋回可能に-- --EN:--Character can be moved and turned--
	proxy:DisableMove(10000,0);
	
	print("OnEvent_542_1 end");
end


--------------------------------------------------------------------------------------
--はしごA下■543 --EN:--Ladder A Lower 543
--------------------------------------------------------------------------------------
--■543■はしごA下■ --EN:-- ■ 543 ■ ladder A lower ■
function OnEvent_543(proxy, param)
	print("OnEvent_543 begin");

	if param:IsNetMessage() == true then
		print("IsNetMessage true");
		print("OnEvent_543 end");
		return;
	end

	--はしご降りに必要な前処理-- --EN:--Pretreatment required for descending the ladder--
	proxy:BeginAction(10000,2,-1,1);			--ホバー移動モードに移行 --EN:--Transition to hover movement mode
	proxy:HoverMoveValDmy(10000,1330,191,LadderTime_A);--移動位置(191)に0.5秒でホバー移動 --EN:--Hover to move position (191) in 0.5 seconds
	proxy:SetEventCommand(10000,0);				--イベントコマンドID(0)"ハシゴ下から掴"むを送る --EN:-- Send event command ID (0) "grab from under the ladder"
	proxy:SetKeepCommandIndex(10000, 0, 1, 3.0 );
	proxy:DisableMove(10000,1);					--キャラクタを移動、旋回不能に --EN:--Move the character, make it impossible to turn
	
	proxy:NotNetMessage_begin();
		--0.5秒(ホバー移動終了)後にはしご降りスタートイベントを発行 --EN:-- Issue a ladder descend start event after 0.5 seconds (end of hover movement)
		proxy:OnKeyTime2(543,"OnEvent_543_1",LadderTime_A,0,0,once);
		--はしご降り専用の関数を3秒間発行(カメラの周り込みなどの処理) --EN:--Issue a function dedicated to descending the ladder for 3 seconds (processing such as surrounding the camera)
		proxy:OnKeyTime2(543,"LadderDown",3.0,1,1,once);
	proxy:NotNetMessage_end();

	print("OnEvent_543 end");
end

function OnEvent_543_1(proxy, param)
	print("OnEvent_543_1 begin");
	
	if proxy:GetEventMode(10000) == 0 then
		print("Local Player GetEventMode 0");
		print("OnEvent_543_1 end");
		return;
	end

	--ハシゴアクションモードに移行-- --EN:--Transition to ladder action mode--
	--nMax  : はしごの段数 - 補正値(補正値はおおよそ3) --EN:--nMax : number of ladder steps - correction value (correction value is approximately 3)
	--nStart: 降りるとき→(nMax + 1) 昇るとき→(-1) --EN:--nStart: When going down→(nMax + 1) When going up→(-1)
	proxy:BeginAction(10000,1,-1,6);
	
	--キャラクタを移動、旋回可能に-- --EN:--Character can be moved and turned--
	proxy:DisableMove(10000,0);
	
	print("OnEvent_543_1 end");
end


--------------------------------------------------------------------------------------
--ボスが動き出す(戦闘開始)■641 --EN:--Boss begins to move (battle starts) 641
--------------------------------------------------------------------------------------
--■641■PCが戦闘領域に入った■ --EN:-- ■ 641 ■ PC entered the battle area ■
function OnEvent_641(proxy, param)
	print("OnEvent_641 begin");	
	--ボス戦用BGM再生開始 --EN:--Start playing BGM for boss battle
	proxy:PlayPointSE( 2000, SOUND_TYPE_M, 30100000, 1 );	
	--ボスロジックON --EN:--Boss logic ON
	proxy:EnableLogic( 804 , true );	
	--読み込みタイミングのとき毎回追加されてほしいのでフラグたてない --EN:-- I want it to be added every time at the time of reading, so I don't set a flag
	
	--審判者イベントスタート --EN:--Judge event start
	BossEventStart_Sinpansya(proxy,param);
	
	proxy:OnKeyTime2( 595, "OnEvent_595", 1.5, 0, 0, once );
	
	--ボスゲージ表示 --EN:-- Boss gauge display
	proxy:SetBossGauge( 804 , 0 ,5040 );
	
	print("OnEvent_641 end");
end

---------------------
--ボス登場演出■595 --EN:--Boss Appearance 595
---------------------
--■595■ボス登場演出■ --EN:-- ■ 595 ■ Boss Appearance ■
function OnEvent_595(proxy, param)
	print("OnEvent_595 begin");

	proxy:PlayAnimation( 804, 7100 );
	
	proxy:SetEventFlag( 595, true );

	print("OnEvent_595 end");
end


--------------------------------------------------------------------------------------
--石柱にワープ■583 --EN:-- Warp to stone pillar 583
--------------------------------------------------------------------------------------

--■583■石柱にワープ■ --EN:-- ■ 583 ■ Warp to the stone pillar ■
function OnEvent_583(proxy,param)	

	if proxy:IsCompleteEvent( 583 ) == true then
		return;
	end
	
	if param:IsNetMessage() == true then
		return;
	end
	
	
	print("OnEvent_583 begin");
	
	--セッション中ではないか？ --EN:--Are you in session?
	if proxy:IsSession() == false then
		proxy:RepeatMessage_begin();
			--▼583_1▼選択メニューの監視▼ --EN:--▼583_1▼Select menu monitoring▼
			proxy:OnSelectMenu(583, "OnEvent_583_0", 10010710, 0, 2, 1983, 2, once);			
		proxy:RepeatMessage_end();
	else
		--セッション中なんで表示 --EN:--Why display during session
		--proxy:InfomationMenu( INFOMENU_TYPE_SIMPLE, 0, MSG_CATEGORY_EVENT, 10010720, 1);
		--proxy:ShowGenDialog(10010720,1,1,true);
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010720, 0, 6, 1983, GEN_DIALOG_DIST, once );
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
	end

	print("OnEvent_583 end");
end

--▲583_0▲選択メニューの監視▲ --EN:--▲583_0▲Monitor selection menu▲
function OnEvent_583_0(proxy, param)
	print("OnEvent_583_0 begin");
	if proxy:IsSession() == false then
		proxy:PlayAnimation( 10000 , 8283 );--要石に触れるアニメを再生 --EN:--Play the animation that touches the keystone
		proxy:NoAnimeTurnCharactor( 10000 , 1983 ,TURNSKIP_ANGLE);
		
		proxy:NotNetMessage_begin();
			--▼要石に触れるアニメ再生終了▼ --EN:--▼Animation touching the keystone ends▼
			proxy:OnChrAnimEnd( 583 , 10000 , 8283 , "OnEvent_583_1" , once );
		proxy:NotNetMessage_end();

		proxy:SetEventFlag( 583 , true );
	else
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010720, 0, 6, 1983, GEN_DIALOG_DIST, once );
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
	end
	print("OnEvent_583_0 end");
end

--▲583_1▲選択メニューの監視▲ --EN:--▲583_1▲Monitor selection menu▲
function OnEvent_583_1(proxy, param)
	print("OnEvent_583_1 begin");
	
	proxy:SetEventFlag( 583 , 0 );
	
	proxy:PlayAnimation( 10000 , 8284 );--要石に触れるアニメを再生 --EN:--Play the animation that touches the keystone
	
	--[[
	proxy:NotNetMessage_begin();
		--▼要石に触れるアニメ再生終了▼ --EN:--▼Animation touching the keystone ends▼
		proxy:OnChrAnimEnd( 583 , 10000 , 8284 , "OnEvent_583_2" , once );
	proxy:NotNetMessage_end();
	]]
	OnEvent_583_2(proxy,param);
	--proxy:SetEventFlag( 583 , true );
	
	print("OnEvent_583_1 end");
end

--▲要石に触れるアニメ再生終了▲ --EN:--▲End of playing the animation touching the keystone▲
function OnEvent_583_2(proxy,param)	
	print("OnEvent_583_2 begin");
	
	--石柱へ戻ってきた判定のフラグを立てる --EN:--Flag the judgment of returning to the stone pillar
	proxy:SetEventFlag(8083, true);

	proxy:SetEventFlag( 583 , 0 );
	--完全回復要求 --EN:-- full recovery request
	proxy:RequestFullRecover();
	proxy:WarpNextStage( 1, 0, 0, 0, 1007 );
	
	print("OnEvent_583_2 end");
end


--------------------------------------------------------------------------------------
--牢の扉■639 --EN:--Jail door 639
--------------------------------------------------------------------------------------
--■639■牢の扉■ --EN:-- ■ 639 ■ jail door ■
function OnEvent_639(proxy,param)
	--必要アイテムの指定 --EN:--Specify required items
	local KEY_ITEM_TYPE = TYPE_GOODS;
	local KEY_ITEM_ID   = 9;--水牢の鍵 --EN:--Water Prison Key
	
	--必要アイテムを所持している(インベントリーにアイテムとして所持している) --EN:--You have the necessary items (have them as items in your inventory)
	if proxy:IsInventoryEquip( KEY_ITEM_TYPE , KEY_ITEM_ID ) == true then
	
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010803, 0, 6, 1331, GEN_DIALOG_DIST, once );
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
		OnEvent_639_1(proxy,param);

	--必要アイテムを所持していない --EN:--I don't have the required items
	else
		--扉が開かない場合のメッセージを表示 --EN:-- Display a message when the door does not open
		--proxy:InfomationMenu( INFOMENU_TYPE_SIMPLE, 0, MSG_CATEGORY_EVENT, 10010160, 1);
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010160, 0, 6, 1331, GEN_DIALOG_DIST, once );
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
		--proxy:ShowGenDialog(10010160,1,1,true);
	end
end

--選択メニューでYESを選択 --EN:--Select YES in the selection menu
function OnEvent_639_1(proxy,param)
	print("OnEvent_639_1 begin");
	--イベント発動を配信する為、LuaCallを噛ませる --EN:--Bite LuaCall to deliver event activation
	proxy:LuaCallStart( 639, 1 );
	print("OnEvent_639_1 end");
end

--結果を配信 --EN:--deliver results
function OnEvent_639_2(proxy,param)
	print("OnEvent_639_2 begin");
	proxy:PlayAnimation( 1331, 1 );--扉が開くアニメーション --EN:-- Door opening animation
	
	proxy:SetEventFlag( 639, true );	
	proxy:DeleteEvent( 639 );	
	--プレイヤーの同期アニメーション(true:パーティープレイヤーがアニメーションした) --EN:--Player synchronous animation (true: party player animated)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_OPEN ) == true then
		return;
	end
	proxy:WarpDmy( 10000 , 1331 , 191 );
	print("OnEvent_639_2 end");
end


--------------------------------------------------------------------------------------
--中ボス部屋　床破壊■4766 --EN:--Mid-boss room floor destruction 4766
--------------------------------------------------------------------------------------
--■4766■中ボス部屋　床破壊■ --EN:-- ■ 4766 ■ Mid-boss room Floor destruction ■
function OnEvent_4766(proxy, param)
	print("OnEvent_4766 begin");
	
	--すぐにダメージを発生させるとプレイヤーに当たる為、待ち時間をいれる --EN:--In order to hit the player if damage is generated immediately, put a waiting time
	--▼4766_1▼***条件追加***--１秒後▼ --EN:--▼4766_1▼***Condition added***--After 1 second▼
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 4766, "OnEvent_4766_1", 1.0, 0, 1, once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_4766 end");
end

--▲4766_1▲１秒後▲ --EN:--▲4766_1▲After 1 second▲
function OnEvent_4766_1(proxy, param)
	print("OnEvent_4766_1 begin");
	
	------------------------パラメータ説明-------------------------------- --EN:--Parameter description--------------------------------
	--	アクションID(4766),ターゲットOBJ(1208),ターゲットのダミポリID(1) --EN:-- Action ID (4766), Target OBJ (1208), Target dummypoly ID (1)
	--	ダメージ量(50),ダメージ球当たり半径(2.0),ダメージ球有効時間(5.0秒) --EN:-- Damage amount (50), Radius per damage sphere (2.0), Duration of damage sphere (5.0 seconds)
	--	ダメージ球の衝突時に(OnEvent_4766_2)発行 --EN:-- Issued (OnEvent_4766_2) when a damage sphere collides
	----------------------------------------------------------------------
	--▼4766_2▼***条件追加***--ダメージ球を発生させダメージ球とマップ、キャラの当たりを監視▼ --EN:--▼4766_2▼***Condition added***--Generate a damage sphere and monitor the damage sphere, map, and character hits▼
	proxy:NotNetMessage_begin();
		proxy:OnObjectDamageHit( 4766, 1208, 1, 10030, EV_HIT_ALL,2.0, 5.0, "OnEvent_4766_2", once );
	proxy:NotNetMessage_end();
	
	-- フラグをセット --EN:-- set flags
	proxy:SetEventFlag( 4766, true );
	
	print("OnEvent_4766_1 end");
end

--▲4766_2▲ダメージ球が当たった▲ --EN:--▲4766_2▲ Hit by a damage ball▲
function OnEvent_4766_2(proxy, param)
	print("OnEvent_4766_2 begin");
	
	--マスターの位置、角度にダミポリの位置、角度を設定 --EN:--Set the position and angle of Damipoly to the position and angle of the master
	--ダミポリを使うのでモデル差し替えなどのタイミングに注意!! --EN:--Since Damipoly is used, pay attention to the timing of model replacement!
	--差し替えた後のモデルに指定IDのダミポリが無い場合保障できません。)	 --EN:--We cannot guarantee if the model after replacement does not have the dummy poly with the specified ID. )
	SecondStageBreak(proxy,1208,2);	
	--破壊のSFX発生 --EN:--SFX occurrence of destruction
	proxy:CreateSfx_DummyPoly(1208,1,93100);
	
	print("OnEvent_4766_2 end");
end

--------------------------------------------------------------------------------------
--中ボス部屋　床破壊■4767 --EN:--Mid-boss room floor destruction 4767
--------------------------------------------------------------------------------------
--■4767■中ボス部屋　床破壊■ --EN:-- ■ 4767 ■ Mid-boss room Floor destruction ■
function OnEvent_4767(proxy, param)
	print("OnEvent_4767 begin");
	
	--▼4767_1▼***条件追加***--１秒後▼ --EN:--▼4767_1▼***Condition added***--After 1 second▼
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 4767, "OnEvent_4767_1", 1.0, 0, 1, once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_4767 end");
end

--▲4767_1▲１秒後▲ --EN:--▲4767_1▲After 1 second▲
function OnEvent_4767_1(proxy, param)
	print("OnEvent_4767_1 begin");
	
	--▼4767_2▼***条件追加***--ダメージ球を発生させダメージ球とマップ、キャラの当たりを監視▼ --EN:--▼4767_2▼***Condition added***--Generate a damage sphere and monitor the damage sphere, map, and character hits▼
	proxy:NotNetMessage_begin();
		proxy:OnObjectDamageHit( 4767, 1209, 1, 10030, EV_HIT_ALL,2.0, 5.0, "OnEvent_4767_2", once );
	proxy:NotNetMessage_end();
	-- フラグをセット --EN:-- set flags
	proxy:SetEventFlag( 4767, true );
	
	print("OnEvent_4767_1 end");
end

--▲4767_2▲ダメージ球が当たった▲ --EN:--▲4767_2▲ Hit by a damage ball▲
function OnEvent_4767_2(proxy, param)
	print("OnEvent_4767_2 begin");
	
	--マスターの位置、角度にダミポリの位置、角度を設定 --EN:--Set the position and angle of Damipoly to the position and angle of the master
	SecondStageBreak(proxy,1209,2);	
	--破壊のSFX発生 --EN:--SFX occurrence of destruction
	proxy:CreateSfx_DummyPoly(1209,1,93100);
	
	print("OnEvent_4767_2 end");
end

--------------------------------------------------------------------------------------
--中ボス部屋　床破壊■4768 --EN:--Mid-boss room floor destruction 4768
--------------------------------------------------------------------------------------
--■4768■中ボス部屋　床破壊■ --EN:-- ■ 4768 ■ middle boss room floor destruction ■
function OnEvent_4768(proxy, param)
	print("OnEvent_4768 begin");
	
	--▼4768_1▼***条件追加***--１秒後▼ --EN:--▼4768_1▼***Condition added***--After 1 second▼
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 4768, "OnEvent_4768_1", 1.0, 0, 1, once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_4768 end");
end

--▲4768_1▲１秒後▲ --EN:--▲4768_1▲After 1 second▲
function OnEvent_4768_1(proxy, param)
	print("OnEvent_4768_1 begin");
	
	--▼4768_2▼***条件追加***--ダメージ球を発生させダメージ球とマップ、キャラの当たりを監視▼ --EN:--▼4768_2▼***Condition added***--Generate a damage sphere and monitor the damage sphere, map, and character hits▼
	proxy:NotNetMessage_begin();
		proxy:OnObjectDamageHit( 4768, 1210, 1, 10030, EV_HIT_ALL,2.0, 5.0, "OnEvent_4768_2", once );
	proxy:NotNetMessage_end();

	-- フラグをセット --EN:-- set flags
	proxy:SetEventFlag( 4768, true );
	
	print("OnEvent_4768_1 end");
end

--▲4768_2▲ダメージ球が当たった▲ --EN:--▲4768_2▲ Hit by a damage ball▲
function OnEvent_4768_2(proxy, param)
	print("OnEvent_4768_2 begin");
	
	SecondStageBreak(proxy,1210,2);	
	--破壊のSFX発生 --EN:--SFX occurrence of destruction
	proxy:CreateSfx_DummyPoly(1210,1,93100);
	
	print("OnEvent_4768_2 end");
end

--------------------------------------------------------------------------------------
--中ボス部屋　床破壊■4769 --EN:--Mid-boss room floor destruction 4769
--------------------------------------------------------------------------------------
--■4769■中ボス部屋　床破壊■ --EN:-- ■ 4769 ■ Mid-boss room Floor destruction ■
function OnEvent_4769(proxy, param)
	print("OnEvent_4769 begin");
	
	--▼4769_1▼***条件追加***--１秒後▼ --EN:--▼4769_1▼***Condition added***--After 1 second▼
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 4769, "OnEvent_4769_1", 1.0, 0, 1, once );
	proxy:NotNetMessage_end();
	print("OnEvent_4769 end");
end

--▲4769_1▲１秒後▲ --EN:--▲4769_1▲After 1 second▲
function OnEvent_4769_1(proxy, param)
	print("OnEvent_4769_1 begin");
	
	--▼4769_2▼***条件追加***--ダメージ球を発生させダメージ球とマップ、キャラの当たりを監視▼ --EN:--▼4769_2▼***Condition added***--Generate a damage sphere and monitor the damage sphere, map, and character hits▼
	proxy:NotNetMessage_begin();
		proxy:OnObjectDamageHit( 4769, 1211, 1, 10030, EV_HIT_ALL,2.0, 5.0, "OnEvent_4769_2", once );
	proxy:NotNetMessage_end();

	-- フラグをセット --EN:-- set flags
	proxy:SetEventFlag( 4769, true );
	
	print("OnEvent_4769_1 end");
end

--▲4769_2▲ダメージ球が当たった▲ --EN:--▲4769_2▲ Hit by a damage ball▲
function OnEvent_4769_2(proxy, param)
	print("OnEvent_4769_2 begin");
	
	--マスターの位置、角度にダミポリの位置、角度を設定 --EN:--Set the position and angle of Damipoly to the position and angle of the master
	SecondStageBreak(proxy,1211,2);
	--破壊のSFX発生 --EN:--SFX occurrence of destruction
	proxy:CreateSfx_DummyPoly(1211,1,93100);	
	
	print("OnEvent_4769_2 end");
end

--------------------------------------------------------------------------------------
--中ボス部屋　床破壊■4770 --EN:--Mid-boss room floor destruction 4770
--------------------------------------------------------------------------------------
--■4770■中ボス部屋　床破壊■ --EN:-- ■ 4770 ■ Mid-boss room floor destruction ■
function OnEvent_4770(proxy, param)
	print("OnEvent_4770 begin");
	
	--▼4770_1▼***条件追加***--１秒後▼ --EN:--▼4770_1▼***Condition added***--After 1 second▼
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 4770, "OnEvent_4770_1", 1.0, 0, 1, once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_4770 end");
end

--▲4770_1▲１秒後▲ --EN:--▲4770_1▲After 1 second▲
function OnEvent_4770_1(proxy, param)
	print("OnEvent_4770_1 begin");
	
	--▼4770_2▼***条件追加***--ダメージ球を発生させダメージ球とマップ、キャラの当たりを監視▼ --EN:--▼4770_2▼***Condition added***--Generate a damage sphere and monitor the damage sphere, map, and character hits▼
	proxy:NotNetMessage_begin();
		proxy:OnObjectDamageHit( 4770, 1212, 1, 10030, EV_HIT_ALL,2.0, 5.0, "OnEvent_4770_2", once );
	proxy:NotNetMessage_end();

	-- フラグをセット --EN:-- set flags
	proxy:SetEventFlag( 4770, true );
	
	print("OnEvent_4770_1 end");
end

--▲4770_2▲ダメージ球が当たった▲ --EN:--▲4770_2▲ Hit by a damage ball▲
function OnEvent_4770_2(proxy, param)
	print("OnEvent_4770_2 begin");
	
	--マスターの位置、角度にダミポリの位置、角度を設定 --EN:--Set the position and angle of Damipoly to the position and angle of the master
	SecondStageBreak(proxy,1212,2);	
	--破壊のSFX発生 --EN:--SFX occurrence of destruction
	proxy:CreateSfx_DummyPoly(1212,1,93100);
	
	print("OnEvent_4770_2 end");
end

--------------------------------------------------------------------------------------
--中ボス部屋　床破壊■4771 --EN:--Mid-boss room floor destruction 4771
--------------------------------------------------------------------------------------
--■4771■中ボス部屋　床破壊■ --EN:-- ■ 4771 ■ Mid-boss room floor destruction ■
function OnEvent_4771(proxy, param)
	print("OnEvent_4771 begin");
	
	--▼4771_1▼***条件追加***--１秒後▼ --EN:--▼4771_1▼***Condition added***--After 1 second▼
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 4771, "OnEvent_4771_1", 1.0, 0, 1, once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_4771 end");
end

--▲4771_1▲１秒後▲ --EN:--▲4771_1▲After 1 second▲
function OnEvent_4771_1(proxy, param)
	print("OnEvent_4771_1 begin");
	
	--▼4771_2▼***条件追加***--ダメージ球を発生させダメージ球とマップ、キャラの当たりを監視▼ --EN:--▼4771_2▼***Condition added***--Generate a damage sphere and monitor the damage sphere, map, and character hits▼
	proxy:NotNetMessage_begin();
		proxy:OnObjectDamageHit( 4771, 1213, 1, 10030, EV_HIT_ALL,2.0, 5.0, "OnEvent_4771_2", once );
	proxy:NotNetMessage_end();

	-- フラグをセット --EN:-- set flags
	proxy:SetEventFlag( 4771, true );
	
	print("OnEvent_4771_1 end");
end

--▲4771_2▲ダメージ球が当たった▲ --EN:--▲4771_2▲ Hit by a damage ball▲
function OnEvent_4771_2(proxy, param)
	print("OnEvent_4771_2 begin");
	
	--マスターの位置、角度にダミポリの位置、角度を設定 --EN:--Set the position and angle of Damipoly to the position and angle of the master
	SecondStageBreak(proxy,1213,2);	
	--破壊のSFX発生 --EN:--SFX occurrence of destruction
	proxy:CreateSfx_DummyPoly(1213,1,93100);
	
	print("OnEvent_4771_2 end");
end

--------------------------------------------------------------------------------------
--中ボス部屋　床破壊■4772 --EN:--Mid-boss room floor destruction 4772
--------------------------------------------------------------------------------------
--■4772■中ボス部屋　床破壊■ --EN:-- ■ 4772 ■ Mid-boss room floor destruction ■
function OnEvent_4772(proxy, param)
	print("OnEvent_4772 begin");
	
	--▼4772_1▼***条件追加***--１秒後▼ --EN:--▼4772_1▼***Condition added***--After 1 second▼
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 4772, "OnEvent_4772_1", 1.0, 0, 1, once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_4772 end");
end

--▲4772_1▲１秒後▲ --EN:--▲4772_1▲After 1 second▲
function OnEvent_4772_1(proxy, param)
	print("OnEvent_4772_1 begin");
	
	--▼4772_2▼***条件追加***--ダメージ球を発生させダメージ球とマップ、キャラの当たりを監視▼ --EN:--▼4772_2▼***Condition added***--Generate a damage sphere and monitor the damage sphere, map, and character hits▼
	proxy:NotNetMessage_begin();
		proxy:OnObjectDamageHit( 4772, 1214, 1, 10030, EV_HIT_ALL,2.0, 5.0, "OnEvent_4772_2", once );
	proxy:NotNetMessage_end();
	-- フラグをセット --EN:-- set flags
	proxy:SetEventFlag( 4772, true );
	
	print("OnEvent_4772_1 end");
end

--▲4772_2▲ダメージ球が当たった▲ --EN:--▲4772_2▲ Hit by a damage ball▲
function OnEvent_4772_2(proxy, param)
	print("OnEvent_4772_2 begin");
	
	--マスターの位置、角度にダミポリの位置、角度を設定 --EN:--Set the position and angle of Damipoly to the position and angle of the master
	SecondStageBreak(proxy,1214,2);	
	--破壊のSFX発生 --EN:--SFX occurrence of destruction
	proxy:CreateSfx_DummyPoly(1214,1,93100);
	
	print("OnEvent_4772_2 end");
end

--------------------------------------------------------------------------------------
--中ボス部屋　床破壊■4773 --EN:--Mid-boss room floor destruction 4773
--------------------------------------------------------------------------------------
--■4773■中ボス部屋　床破壊■ --EN:-- ■ 4773 ■ Mid-boss room Floor destruction ■
function OnEvent_4773(proxy, param)
	print("OnEvent_4773 begin");
	
	--▼4773_1▼***条件追加***--１秒後▼ --EN:--▼4773_1▼***Condition added***--After 1 second▼
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 4773, "OnEvent_4773_1", 1.0, 0, 1, once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_4773 end");
end

--▲4773_1▲１秒後▲ --EN:--▲4773_1▲After 1 second▲
function OnEvent_4773_1(proxy, param)
	print("OnEvent_4773_1 begin");
	
	--▼4773_2▼***条件追加***--ダメージ球を発生させダメージ球とマップ、キャラの当たりを監視▼ --EN:--▼4773_2▼***Condition added***--Generate a damage sphere and monitor the damage sphere, map, and character hits▼
	proxy:NotNetMessage_begin();
		proxy:OnObjectDamageHit( 4773, 1215, 1, 10030, EV_HIT_ALL,2.0, 5.0, "OnEvent_4773_2", once );
	proxy:NotNetMessage_end();

	-- フラグをセット --EN:-- set flags
	proxy:SetEventFlag( 4773, true );
	
	print("OnEvent_4773_1 end");
end

--▲4773_2▲ダメージ球が当たった▲ --EN:--▲4773_2▲ Hit by a damage ball▲
function OnEvent_4773_2(proxy, param)
	print("OnEvent_4773_2 begin");
	
	--マスターの位置、角度にダミポリの位置、角度を設定 --EN:--Set the position and angle of Damipoly to the position and angle of the master
	SecondStageBreak(proxy,1215,2);	
	--破壊のSFX発生 --EN:--SFX occurrence of destruction
	proxy:CreateSfx_DummyPoly(1215,1,93100);
	
	print("OnEvent_4773_2 end");
end

--------------------------------------------------------------------------------------
--中ボス部屋　床破壊■4774 --EN:--Mid-boss room floor destruction 4774
--------------------------------------------------------------------------------------
--■4774■中ボス部屋　床破壊■ --EN:-- ■ 4774 ■ Mid-boss room Floor destruction ■
function OnEvent_4774(proxy, param)
	print("OnEvent_4774 begin");
	
	--▼4774_1▼***条件追加***--１秒後▼ --EN:--▼4774_1▼***Condition added***--After 1 second▼
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 4774, "OnEvent_4774_1", 1.0, 0, 1, once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_4774 end");
end

--▲4774_1▲１秒後▲ --EN:--▲4774_1▲After 1 second▲
function OnEvent_4774_1(proxy, param)
	print("OnEvent_4774_1 begin");
	
	--▼4774_2▼***条件追加***--ダメージ球を発生させダメージ球とマップ、キャラの当たりを監視▼ --EN:--▼4774_2▼***Condition added***--Generate a damage sphere and monitor the damage sphere, map, and character hits▼
	proxy:NotNetMessage_begin();
		proxy:OnObjectDamageHit( 4774, 1216, 1, 10030, EV_HIT_ALL,2.0, 5.0, "OnEvent_4774_2", once );
	proxy:NotNetMessage_end();

	-- フラグをセット --EN:-- set flags
	proxy:SetEventFlag( 4774, true );
	
	print("OnEvent_4774_1 end");
end

--▲4774_2▲ダメージ球が当たった▲ --EN:--▲4774_2▲ Hit by a damage ball▲
function OnEvent_4774_2(proxy, param)
	print("OnEvent_4774_2 begin");
	
	--マスターの位置、角度にダミポリの位置、角度を設定 --EN:--Set the position and angle of Damipoly to the position and angle of the master
	SecondStageBreak(proxy,1216,2);	
	--破壊のSFX発生 --EN:--SFX occurrence of destruction
	proxy:CreateSfx_DummyPoly(1216,1,93100);
	
	print("OnEvent_4774_2 end");
end



--------------------------------------------------------------------------------------
--中ボス部屋　床破壊■4775 --EN:--Mid-boss room floor destruction 4775
--------------------------------------------------------------------------------------
--■4775■中ボス部屋　床破壊■ --EN:-- ■ 4775 ■ Mid-boss room Floor destruction ■
function OnEvent_4775(proxy, param)
	print("OnEvent_4775 begin");
	
	--▼4775_1▼***条件追加***--１秒後▼ --EN:--▼4775_1▼***Condition added***--After 1 second▼
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 4775, "OnEvent_4775_1", 1.0, 0, 1, once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_4775 end");
end

--▲4775_1▲１秒後▲ --EN:--▲4775_1▲After 1 second▲
function OnEvent_4775_1(proxy, param)
	print("OnEvent_4775_1 begin");
	
	--▼4775_2▼***条件追加***--ダメージ球を発生させダメージ球とマップ、キャラの当たりを監視▼ --EN:--▼4775_2▼***Condition added***--Generate a damage sphere and monitor the damage sphere, map, and character hits▼
	proxy:NotNetMessage_begin();
		proxy:OnObjectDamageHit( 4775, 1217, 1, 10030, EV_HIT_ALL,2.0, 5.0, "OnEvent_4775_2", once );
	proxy:NotNetMessage_end();

	-- フラグをセット --EN:-- set flags
	proxy:SetEventFlag( 4775, true);
	
	print("OnEvent_4775_1 end");
end

--▲4775_2▲ダメージ球が当たった▲ --EN:--▲4775_2▲ Hit by a damage ball▲
function OnEvent_4775_2(proxy, param)
	print("OnEvent_4775_2 begin");
	
	--マスターの位置、角度にダミポリの位置、角度を設定 --EN:--Set the position and angle of Damipoly to the position and angle of the master
	SecondStageBreak(proxy,1217,2);	
	--破壊のSFX発生 --EN:--SFX occurrence of destruction
	proxy:CreateSfx_DummyPoly(1217,1,93100);
	
	print("OnEvent_4775_2 end");
end

--------------------------------------------------------------------------------------
--中ボス部屋　床破壊■4776 --EN:--Mid-boss room floor destruction 4776
--------------------------------------------------------------------------------------
--■4776■中ボス部屋　床破壊■ --EN:-- ■ 4776 ■ Mid-boss room Floor destruction ■
function OnEvent_4776(proxy, param)
	print("OnEvent_4776 begin");
	
	--▼4776_1▼***条件追加***--１秒後▼ --EN:--▼4776_1▼***Condition added***--After 1 second▼
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 4776, "OnEvent_4776_1", 1.0, 0, 1, once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_4776 end");
end

--▲4776_1▲１秒後▲ --EN:--▲4776_1▲After 1 second▲
function OnEvent_4776_1(proxy, param)
	print("OnEvent_4776_1 begin");
	
	--▼4776_2▼***条件追加***--ダメージ球を発生させダメージ球とマップ、キャラの当たりを監視▼ --EN:--▼4776_2▼***Condition added***--Generate a damage sphere and monitor the damage sphere, map, and character hits▼
	proxy:NotNetMessage_begin();
		proxy:OnObjectDamageHit( 4776, 1218, 1, 10030, EV_HIT_ALL,2.0, 5.0, "OnEvent_4776_2", once );
	proxy:NotNetMessage_end();

	-- フラグをセット --EN:-- set flags
	proxy:SetEventFlag( 4776, true );
	
	print("OnEvent_4776_1 end");
end

--▲4776_2▲ダメージ球が当たった▲ --EN:--▲4776_2▲ Hit by a damage ball▲
function OnEvent_4776_2(proxy, param)
	print("OnEvent_4776_2 begin");
	
	--マスターの位置、角度にダミポリの位置、角度を設定 --EN:--Set the position and angle of Damipoly to the position and angle of the master
	SecondStageBreak(proxy,1218,2);	
	--破壊のSFX発生 --EN:--SFX occurrence of destruction
	proxy:CreateSfx_DummyPoly(1218,1,93100);

	print("OnEvent_4776_2 end");
end

--------------------------------------------------------------------------------------
--中ボス部屋　床破壊■4777 --EN:--Mid-boss room floor destruction 4777
--------------------------------------------------------------------------------------
--■4777■中ボス部屋　床破壊■ --EN:-- ■ 4777 ■ Mid-boss room Floor destruction ■
function OnEvent_4777(proxy, param)
	print("OnEvent_4777 begin");
	
	--▼4777_1▼***条件追加***--１秒後▼ --EN:--▼4777_1▼***Condition added***--After 1 second▼
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 4777, "OnEvent_4777_1", 1.0, 0, 1, once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_4777 end");
end

--▲4777_1▲１秒後▲ --EN:--▲4777_1▲After 1 second▲
function OnEvent_4777_1(proxy, param)
	print("OnEvent_4777_1 begin");
	
	--▼4777_2▼***条件追加***--ダメージ球を発生させダメージ球とマップ、キャラの当たりを監視▼ --EN:--▼4777_2▼***Condition added***--Generate a damage sphere and monitor the damage sphere, map, and character hits▼
	proxy:NotNetMessage_begin();
		proxy:OnObjectDamageHit( 4777, 1219, 1, 10030, EV_HIT_ALL,2.0, 5.0, "OnEvent_4777_2", once );
	proxy:NotNetMessage_end();

	-- フラグをセット --EN:-- set flags
	proxy:SetEventFlag( 4777, true );
	
	print("OnEvent_4777_1 end");
end

--▲4777_2▲ダメージ球が当たった▲ --EN:--▲4777_2▲ Hit by a damage ball▲
function OnEvent_4777_2(proxy, param)
	print("OnEvent_4777_2 begin");
	
	--マスターの位置、角度にダミポリの位置、角度を設定 --EN:--Set the position and angle of Damipoly to the position and angle of the master
	SecondStageBreak(proxy,1219,2);	
	--破壊のSFX発生 --EN:--SFX occurrence of destruction
	proxy:CreateSfx_DummyPoly(1219,1,93100);
	
	print("OnEvent_4777_2 end");
end

--------------------------------------------------------------------------------------
--中ボス部屋　床破壊■4778 --EN:--Mid-boss room floor destruction 4778
--------------------------------------------------------------------------------------
--■4778■中ボス部屋　床破壊■ --EN:-- ■ 4778 ■ Mid-boss room Floor destruction ■
function OnEvent_4778(proxy, param)
	print("OnEvent_4778 begin");
	
	--▼4778_1▼***条件追加***--１秒後▼ --EN:--▼4778_1▼***Condition added***--After 1 second▼
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 4778, "OnEvent_4778_1", 1.0, 0, 1, once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_4778 end");
end

--▲4778_1▲１秒後▲ --EN:--▲4778_1▲After 1 second▲
function OnEvent_4778_1(proxy, param)
	print("OnEvent_4778_1 begin");
	
	--▼4778_2▼***条件追加***--ダメージ球を発生させダメージ球とマップ、キャラの当たりを監視▼ --EN:--▼4778_2▼***Condition added***--Generate a damage sphere and monitor the damage sphere, map, and character hits▼
	proxy:NotNetMessage_begin();
		proxy:OnObjectDamageHit( 4778, 1220, 1, 10030, EV_HIT_ALL,2.0, 5.0, "OnEvent_4778_2", once );
	proxy:NotNetMessage_end();

	-- フラグをセット --EN:-- set flags
	proxy:SetEventFlag( 4778, true);
	
	print("OnEvent_4778_1 end");
end

--▲4778_2▲ダメージ球が当たった▲ --EN:--▲4778_2▲ Hit by a damage ball▲
function OnEvent_4778_2(proxy, param)
	print("OnEvent_4778_2 begin");
	
	--マスターの位置、角度にダミポリの位置、角度を設定 --EN:--Set the position and angle of Damipoly to the position and angle of the master
	SecondStageBreak(proxy,1220,2);	
	--破壊のSFX発生 --EN:--SFX occurrence of destruction
	proxy:CreateSfx_DummyPoly(1220,1,93100);
	
	print("OnEvent_4778_2 end");
end

--------------------------------------------------------------------------------------
--中ボス部屋　床破壊■4779 --EN:--Mid-boss room floor destruction 4779
--------------------------------------------------------------------------------------
--■4779■中ボス部屋　床破壊■ --EN:-- ■ 4779 ■ Mid-boss room Floor destruction ■
function OnEvent_4779(proxy, param)
	print("OnEvent_4779 begin");
	
	--▼4779_1▼***条件追加***--１秒後▼ --EN:--▼4779_1▼***Condition added***--After 1 second▼
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 4779, "OnEvent_4779_1", 1.0, 0, 1, once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_4779 end");
end

--▲4779_1▲１秒後▲ --EN:--▲4779_1▲After 1 second▲
function OnEvent_4779_1(proxy, param)
	print("OnEvent_4779_1 begin");
	
	--▼4779_2▼***条件追加***--ダメージ球を発生させダメージ球とマップ、キャラの当たりを監視▼ --EN:--▼4779_2▼***Condition added***--Generate a damage sphere and monitor the damage sphere, map, and character hits▼
	proxy:NotNetMessage_begin();
		proxy:OnObjectDamageHit( 4779, 1221, 1, 10030, EV_HIT_ALL,2.0, 5.0, "OnEvent_4779_2", once );
	proxy:NotNetMessage_end();

	-- フラグをセット --EN:-- set flags
	proxy:SetEventFlag( 4779, true );
	
	print("OnEvent_4779_1 end");
end

--▲4779_2▲ダメージ球が当たった▲ --EN:--▲4779_2▲ Hit by a damage ball▲
function OnEvent_4779_2(proxy, param)
	print("OnEvent_4779_2 begin");
	
	--マスターの位置、角度にダミポリの位置、角度を設定 --EN:--Set the position and angle of Damipoly to the position and angle of the master
	SecondStageBreak(proxy,1221,2);	
	--破壊のSFX発生 --EN:--SFX occurrence of destruction
	proxy:CreateSfx_DummyPoly(1221,1,93100);
	
	print("OnEvent_4779_2 end");
end

--------------------------------------------------------------------------------------
--中ボス部屋　床破壊■4780 --EN:--Mid-boss room floor destruction 4780
--------------------------------------------------------------------------------------
--■4780■中ボス部屋　床破壊■ --EN:-- ■ 4780 ■ middle boss room floor destruction ■
function OnEvent_4780(proxy, param)
	print("OnEvent_4780 begin");
	
	--▼4780_1▼***条件追加***--１秒後▼ --EN:--▼4780_1▼***Condition added***--After 1 second▼
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 4780, "OnEvent_4780_1", 1.0, 0, 1, once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_4780 end");
end

--▲4780_1▲１秒後▲ --EN:--▲4780_1▲After 1 second▲
function OnEvent_4780_1(proxy, param)
	print("OnEvent_4780_1 begin");
	
	--▼4780_2▼***条件追加***--ダメージ球を発生させダメージ球とマップ、キャラの当たりを監視▼ --EN:--▼4780_2▼***Condition added***--Generate a damage sphere and monitor the damage sphere, map, and character hits▼
	proxy:NotNetMessage_begin();
		proxy:OnObjectDamageHit( 4780, 1222, 1, 10030, EV_HIT_ALL,2.0, 5.0, "OnEvent_4780_2", once );
	proxy:NotNetMessage_end();

	-- フラグをセット --EN:-- set flags
	proxy:SetEventFlag( 4780, true );
	
	print("OnEvent_4780_1 end");
end

--▲4780_2▲ダメージ球が当たった▲ --EN:--▲4780_2▲ Hit by a damage ball▲
function OnEvent_4780_2(proxy, param)
	print("OnEvent_4780_2 begin");
	
	--マスターの位置、角度にダミポリの位置、角度を設定 --EN:--Set the position and angle of Damipoly to the position and angle of the master
	SecondStageBreak(proxy,1222,2);	
	--破壊のSFX発生 --EN:--SFX occurrence of destruction
	proxy:CreateSfx_DummyPoly(1222,1,93100);
	
	print("OnEvent_4780_2 end");
end

--------------------------------------------------------------------------------------
--中ボス部屋　床破壊■4781 --EN:--Mid-boss room floor destruction 4781
--------------------------------------------------------------------------------------
--■4781■中ボス部屋　床破壊■ --EN:-- ■ 4781 ■ Mid-boss room Floor destruction ■
function OnEvent_4781(proxy, param)
	print("OnEvent_4781 begin");
	
	--▼4781_1▼***条件追加***--１秒後▼ --EN:--▼4781_1▼***Condition added***--After 1 second▼
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 4781, "OnEvent_4781_1", 1.0, 0, 1, once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_4781 end");
end

--▲4781_1▲１秒後▲ --EN:--▲4781_1▲After 1 second▲
function OnEvent_4781_1(proxy, param)
	print("OnEvent_4781_1 begin");
	
	--▼4781_2▼***条件追加***--ダメージ球を発生させダメージ球とマップ、キャラの当たりを監視▼ --EN:--▼4781_2▼***Condition added***--Generate a damage sphere and monitor the damage sphere, map, and character hits▼
	proxy:NotNetMessage_begin();
		proxy:OnObjectDamageHit( 4781, 1223, 1, 10030, EV_HIT_ALL,2.0, 5.0, "OnEvent_4781_2", once );
	proxy:NotNetMessage_end();

	-- フラグをセット --EN:-- set flags
	proxy:SetEventFlag( 4781, true );
	
	print("OnEvent_4781_1 end");
end

--▲4781_2▲ダメージ球が当たった▲ --EN:--▲4781_2▲ Hit by a damage ball▲
function OnEvent_4781_2(proxy, param)
	print("OnEvent_4781_2 begin");
	
	--マスターの位置、角度にダミポリの位置、角度を設定 --EN:--Set the position and angle of Damipoly to the position and angle of the master
	SecondStageBreak(proxy,1223,2);	
	--破壊のSFX発生 --EN:--SFX occurrence of destruction
	proxy:CreateSfx_DummyPoly(1223,1,93100);
	
	print("OnEvent_4781_2 end");
end

--------------------------------------------------------------------------------------
--中ボス部屋　床破壊■4782 --EN:--Mid-boss room floor destruction 4782
--------------------------------------------------------------------------------------
--■4782■中ボス部屋　床破壊■ --EN:-- ■ 4782 ■ Mid-boss room floor destruction ■
function OnEvent_4782(proxy, param)
	print("OnEvent_4782 begin");
	
	--▼4782_1▼***条件追加***--１秒後▼ --EN:--▼4782_1▼***Condition added***--After 1 second▼
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 4782, "OnEvent_4782_1", 1.0, 0, 1, once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_4782 end");
end

--▲4782_1▲１秒後▲ --EN:--▲4782_1▲After 1 second▲
function OnEvent_4782_1(proxy, param)
	print("OnEvent_4782_1 begin");
	
	--▼4782_2▼***条件追加***--ダメージ球を発生させダメージ球とマップ、キャラの当たりを監視▼ --EN:--▼4782_2▼***Condition added***--Generate a damage sphere and monitor the damage sphere, map, and character hits▼
	proxy:NotNetMessage_begin();
		proxy:OnObjectDamageHit( 4782, 1224, 1, 10030, EV_HIT_ALL,2.0, 5.0, "OnEvent_4782_2", once );
	proxy:NotNetMessage_end();

	-- フラグをセット --EN:-- set flags
	proxy:SetEventFlag( 4782, true );
	
	print("OnEvent_4782_1 end");
end

--▲4782_2▲ダメージ球が当たった▲ --EN:--▲4782_2▲ Hit by a damage ball▲
function OnEvent_4782_2(proxy, param)
	print("OnEvent_4782_2 begin");
	
	--マスターの位置、角度にダミポリの位置、角度を設定 --EN:--Set the position and angle of Damipoly to the position and angle of the master
	SecondStageBreak(proxy,1224,2);	
	--破壊のSFX発生 --EN:--SFX occurrence of destruction
	proxy:CreateSfx_DummyPoly(1224,1,93100);
	
	print("OnEvent_4782_2 end");
end

--------------------------------------------------------------------------------------
--中ボス部屋　床破壊■4783 --EN:--Mid-boss room floor destruction 4783
--------------------------------------------------------------------------------------
--■4783■中ボス部屋　床破壊■ --EN:-- ■ 4783 ■ Mid-boss room floor destruction ■
function OnEvent_4783(proxy, param)
	print("OnEvent_4783 begin");
	
	--▼4783_1▼***条件追加***--１秒後▼ --EN:--▼4783_1▼***Condition added***--After 1 second▼
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 4783, "OnEvent_4783_1", 1.0, 0, 1, once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_4783 end");
end

--▲4783_1▲１秒後▲ --EN:--▲4783_1▲After 1 second▲
function OnEvent_4783_1(proxy, param)
	print("OnEvent_4783_1 begin");
	
	--▼4783_2▼***条件追加***--ダメージ球を発生させダメージ球とマップ、キャラの当たりを監視▼ --EN:--▼4783_2▼***Condition added***--Generate a damage sphere and monitor the damage sphere, map, and character hits▼
	proxy:NotNetMessage_begin();
		proxy:OnObjectDamageHit( 4783, 1225, 1, 10030, EV_HIT_ALL,2.0, 5.0, "OnEvent_4783_2", once );
	proxy:NotNetMessage_end();

	-- フラグをセット --EN:-- set flags
	proxy:SetEventFlag( 4783, true );
	
	print("OnEvent_4783_1 end");
end

--▲4783_2▲ダメージ球が当たった▲ --EN:--▲4783_2▲ Hit by a damage ball▲
function OnEvent_4783_2(proxy, param)
	print("OnEvent_4783_2 begin");
	
	--マスターの位置、角度にダミポリの位置、角度を設定 --EN:--Set the position and angle of Damipoly to the position and angle of the master
	SecondStageBreak(proxy,1225,2);	
	--破壊のSFX発生 --EN:--SFX occurrence of destruction
	proxy:CreateSfx_DummyPoly(1225,1,93100);
	
	print("OnEvent_4783_2 end");
end

--------------------------------------------------------------------------------------
--中ボス部屋　床破壊■4784 --EN:--Mid-boss room floor destruction 4784
--------------------------------------------------------------------------------------
--■4784■中ボス部屋　床破壊■ --EN:-- ■ 4784 ■ Mid-boss room Floor destruction ■
function OnEvent_4784(proxy, param)
	print("OnEvent_4784 begin");
	
	--▼4784_1▼***条件追加***--１秒後▼ --EN:--▼4784_1▼***Condition added***--After 1 second▼
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 4784, "OnEvent_4784_1", 1.0, 0, 1, once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_4784 end");
end

--▲4784_1▲１秒後▲ --EN:--▲4784_1▲After 1 second▲
function OnEvent_4784_1(proxy, param)
	print("OnEvent_4784_1 begin");
	
	--▼4784_2▼***条件追加***--ダメージ球を発生させダメージ球とマップ、キャラの当たりを監視▼ --EN:--▼4784_2▼***Condition added***--Generate a damage sphere and monitor the damage sphere, map, and character hits▼
	proxy:NotNetMessage_begin();	
		proxy:OnObjectDamageHit( 4784, 1226, 1, 10030,EV_HIT_ALL, 2.0, 5.0, "OnEvent_4784_2", once );
	proxy:NotNetMessage_end();

	-- フラグをセット --EN:-- set flags
	proxy:SetEventFlag( 4784, true );
	
	print("OnEvent_4784_1 end");
end

--▲4784_2▲ダメージ球が当たった▲ --EN:--▲4784_2▲ Hit by a damage ball▲
function OnEvent_4784_2(proxy, param)
	print("OnEvent_4784_2 begin");
	
	--マスターの位置、角度にダミポリの位置、角度を設定 --EN:--Set the position and angle of Damipoly to the position and angle of the master
	SecondStageBreak(proxy,1226,2);	
	--破壊のSFX発生 --EN:--SFX occurrence of destruction
	proxy:CreateSfx_DummyPoly(1226,1,93100);
	
	print("OnEvent_4784_2 end");
end

--------------------------------------------------------------------------------------
--中ボス部屋　床破壊■4785 --EN:--Mid-boss room floor destruction 4785
--------------------------------------------------------------------------------------
--■4785■中ボス部屋　床破壊■ --EN:-- ■ 4785 ■ Mid-boss room floor destruction ■
function OnEvent_4785(proxy, param)
	print("OnEvent_4785 begin");
	
	--▼4785_1▼***条件追加***--１秒後▼ --EN:--▼4785_1▼***Condition added***--After 1 second▼
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 4785, "OnEvent_4785_1", 1.0, 0, 1, once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_4785 end");
end

--▲4785_1▲１秒後▲ --EN:--▲4785_1▲After 1 second▲
function OnEvent_4785_1(proxy, param)
	print("OnEvent_4785_1 begin");
	
	--▼4785_2▼***条件追加***--ダメージ球を発生させダメージ球とマップ、キャラの当たりを監視▼ --EN:--▼4785_2▼***Condition added***--Generate a damage sphere and monitor the damage sphere, map, and character hits▼
	proxy:NotNetMessage_begin();
		proxy:OnObjectDamageHit( 4785, 1227, 1, 10030,EV_HIT_ALL, 2.0, 5.0, "OnEvent_4785_2", once );
	proxy:NotNetMessage_end();

	-- フラグをセット --EN:-- set flags
	proxy:SetEventFlag( 4785, true );
	
	print("OnEvent_4785_1 end");
end

--▲4785_2▲ダメージ球が当たった▲ --EN:--▲4785_2▲ Hit by a damage ball▲
function OnEvent_4785_2(proxy, param)
	print("OnEvent_4785_2 begin");
	
	--マスターの位置、角度にダミポリの位置、角度を設定 --EN:--Set the position and angle of Damipoly to the position and angle of the master
	SecondStageBreak(proxy,1227,2);	
	--破壊のSFX発生 --EN:--SFX occurrence of destruction
	proxy:CreateSfx_DummyPoly(1227,1,93100);
	
	print("OnEvent_4785_2 end");
end

--------------------------------------------------------------------------------------
--中ボス部屋　床破壊■4786 --EN:--Mid-boss room floor destruction 4786
--------------------------------------------------------------------------------------
--■4786■中ボス部屋　床破壊■ --EN:-- ■ 4786 ■ Mid-boss room floor destruction ■
function OnEvent_4786(proxy, param)
	print("OnEvent_4786 begin");
	
	--▼4786_1▼***条件追加***--１秒後▼ --EN:--▼4786_1▼***Condition added***--After 1 second▼
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 4786, "OnEvent_4786_1", 1.0, 0, 1, once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_4786 end");
end

--▲4786_1▲１秒後▲ --EN:--▲4786_1▲After 1 second▲
function OnEvent_4786_1(proxy, param)
	print("OnEvent_4786_1 begin");
	
	--▼4786_2▼***条件追加***--ダメージ球を発生させダメージ球とマップ、キャラの当たりを監視▼ --EN:--▼4786_2▼***Condition added***--Generate a damage sphere and monitor the damage sphere, map, and character hits▼
	proxy:NotNetMessage_begin();
		proxy:OnObjectDamageHit( 4786, 1228, 1, 10030,EV_HIT_ALL, 2.0, 5.0, "OnEvent_4786_2", once );
	proxy:NotNetMessage_end();

	-- フラグをセット --EN:-- set flags
	proxy:SetEventFlag( 4786, true );
	
	print("OnEvent_4786_1 end");
end

--▲4786_2▲ダメージ球が当たった▲ --EN:--▲4786_2▲ Hit by a damage ball▲
function OnEvent_4786_2(proxy, param)
	print("OnEvent_4786_2 begin");
	
	--マスターの位置、角度にダミポリの位置、角度を設定 --EN:--Set the position and angle of Damipoly to the position and angle of the master
	SecondStageBreak(proxy,1228,2);	
	--破壊のSFX発生 --EN:--SFX occurrence of destruction
	proxy:CreateSfx_DummyPoly(1228,1,93100);
	
	print("OnEvent_4786_2 end");
end

--------------------------------------------------------------------------------------
--中ボス部屋　床破壊■4787 --EN:--Mid-boss room floor destruction 4787
--------------------------------------------------------------------------------------
--■4787■中ボス部屋　床破壊■ --EN:-- ■ 4787 ■ Mid-boss room Floor destruction ■
function OnEvent_4787(proxy, param)
	print("OnEvent_4787 begin");
	
	--▼4787_1▼***条件追加***--１秒後▼ --EN:--▼4787_1▼***Condition added***--After 1 second▼
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 4787, "OnEvent_4787_1", 1.0, 0, 1, once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_4787 end");
end

--▲4787_1▲１秒後▲ --EN:--▲4787_1▲After 1 second▲
function OnEvent_4787_1(proxy, param)
	print("OnEvent_4787_1 begin");
	
	--▼4786_2▼***条件追加***--ダメージ球を発生させダメージ球とマップ、キャラの当たりを監視▼ --EN:--▼4786_2▼***Condition added***--Generate a damage sphere and monitor the damage sphere, map, and character hits▼
	proxy:NotNetMessage_begin();
		proxy:OnObjectDamageHit( 4787, 1229, 1, 10030, EV_HIT_ALL,2.0, 5.0, "OnEvent_4787_2", once );
	proxy:NotNetMessage_end();

	-- フラグをセット --EN:-- set flags
	proxy:SetEventFlag( 4787, true );
	
	print("OnEvent_4787_1 end");
end

--▲4787_2▲ダメージ球が当たった▲ --EN:--▲4787_2▲ Hit by a damage ball▲
function OnEvent_4787_2(proxy, param)
	print("OnEvent_4787_2 begin");
	
	--マスターの位置、角度にダミポリの位置、角度を設定 --EN:--Set the position and angle of Damipoly to the position and angle of the master
	SecondStageBreak(proxy,1229,2);	
	--破壊のSFX発生 --EN:--SFX occurrence of destruction
	proxy:CreateSfx_DummyPoly(1229,1,93100);
	
	print("OnEvent_4787_2 end");
end


--[[
--------------------------------------------------------------------------------------
--骸骨起き上がり■651 --EN:-- Skeleton getting up ■ 651
--------------------------------------------------------------------------------------
function OnEvent_651(proxy,param)
	print("OnEvent_651 begin");
	proxy:StopLoopAnimation(328);
	proxy:PlayAnimation(328,7001);
	proxy:SetColiEnable(328,true);
	proxy:SetEventFlag(651,true);
	print("OnEvent_651 end");
end


--------------------------------------------------------------------------------------
--骸骨起き上がり■652 --EN:-- Skeleton getting up ■ 652
--------------------------------------------------------------------------------------
function OnEvent_652(proxy,param)
	print("OnEvent_652 begin");
	for eneid = 329, 334, 1 do
		proxy:StopLoopAnimation(eneid);
		proxy:PlayAnimation(eneid,7001);
		proxy:SetColiEnable(eneid,true);
	end		
	proxy:SetEventFlag(652,true);
	print("OnEvent_652 end");
end


--------------------------------------------------------------------------------------
--骸骨起き上がり■653 --EN:-- Skeleton getting up ■ 653
--------------------------------------------------------------------------------------
function OnEvent_653(proxy,param)
	print("OnEvent_653 begin");
	for eneid = 336, 339, 1 do
		proxy:StopLoopAnimation(eneid);
		proxy:PlayAnimation(eneid,7001);
		proxy:SetColiEnable(eneid,true);
	end		
	proxy:SetEventFlag(653,true);
	print("OnEvent_653 end");
end]]


--------------------------------------------------------------------------------------
--天の声■654 --EN:--Heavenly voice 654
--------------------------------------------------------------------------------------
function OnEvent_654(proxy,param)
	print("OnEvent_654 begin");
	--アイテムイベント待ちじゃない時だけ --EN:--Only when not waiting for an item event
	if proxy:IsCompleteEvent( 12614 ) == false then		
		if proxy:IsCompleteEvent( 12613 ) == false then
			--アイテム交換希望会話 --EN:-- Item exchange request conversation
			proxy:CloseMenu();
			proxy:TalkNextPage(654);
		end
	end
	
	if proxy:IsLivePlayer() == true or proxy:IsGreyGhost() == true then
		proxy:NotNetMessage_begin();
		proxy:RepeatMessage_begin();
			--proxy:OnPlayerActionInRegion(656,2285,"OnEvent_656",0,once);
			proxy:OnRegionJustOut(657,10000,2285,"OnEvent_657",once);
		proxy:RepeatMessage_end();
		proxy:NotNetMessage_end();
	end
	
	print("OnEvent_654 end");
end

--次ページに送ると消える？ --EN:--Does it disappear when you move to the next page?
function OnEvent_656(proxy,param)
	print("OnEvent_656 begin");	
	--proxy:CloseMenu();
	--proxy:TalkNextPage(654);	
	print("OnEvent_656 end");
end

--エリアから出ると消える? --EN:-- Does it disappear when you leave the area?
function OnEvent_657(proxy,param)
	print("OnEvent_657 begin");
	--アイテム交換希望用の会話 --EN:--Conversation for item exchange request
	proxy:CloseTalk(654);
	proxy:SetValidTalk(654,true);
	--アイテム更に希望の会話 --EN:--Items and Desired Conversations
	proxy:CloseTalk(655);
	proxy:SetValidTalk(655,true);
	--希望アイテムと違う会話 --EN:-- Conversation different from the desired item
	proxy:CloseTalk(662);
	proxy:SetValidTalk(662,true);
	
	proxy:DeleteEvent(656);	
	
	if proxy:IsLivePlayer() == true or proxy:IsGreyGhost() == true then
		proxy:NotNetMessage_begin();
		proxy:RepeatMessage_begin();
			proxy:OnRegionIn(654,10000,2284,"OnEvent_654",once);				
		proxy:RepeatMessage_end();
		proxy:NotNetMessage_end();
	end
	print("OnEvent_657 end");
end




--------------------------------------------------------------------------------------
--アイテムドロップの監視■12613 --EN:--Monitoring item drops ■12613
--------------------------------------------------------------------------------------
--アイテムを捨てた --EN:--I threw the item away
function OnEvent_12613(proxy,param)
	--print("OnEvent_12613 begin");
	
	if proxy:IsCompleteEvent(12614) == false and proxy:IsCompleteEvent(12613) == false then				
		local num = table.getn(itemevent_typelist);
		local idx = 0;
		local isDrop = false;
		
		--何か捨てたか詳細関係無く判定 --EN:--Determine whether something was discarded regardless of details
		if proxy:IsDropCheck_Only( 10000 , -1 , -1 , 2284 ) == true then
			for idx=1 ,num , 1 do
				if CheckItemDrop(proxy,param,idx) == true then
				--if proxy:IsRegionDrop(12613,10000, itemevent_typelist[idx], itemevent_idlist[idx] ,2284) == true then
					print("Drop!!");
					--proxy:SetEventFlag(12613,true);					
					--該当アイテムが落ちたのでとりあえずここで終了 --EN:--The corresponding item was dropped, so it ends here for the time being
					return;
				end
			end
			
			--何か捨てたけど上の候補に無い・・・該当アイテム以外を捨てた！ --EN:--I threw something away, but it's not in the list above... I threw anything other than the corresponding item!
			--不必要なものを捨てた会話 --EN:--Conversation without unnecessary things
			proxy:CloseMenu();--メニュー閉じます。 --EN:-- Close the menu.
			proxy:SetValidTalk(662,true);
			proxy:TalkNextPage(662)
		end
		
	--[[else
		print("Event Complete!");
		proxy:SetEventFlag(12000,false);
		proxy:DeleteEvent(57);
		]]
	end	
	--print("OnEvent_12613 end");
end

--[[
function OnEvent_12613_1(proxy,param)
	print("OnEvent_12613_1 begin");
	print("PickUpItem");
	proxy:SetEventFlag(12613,false);
	print("OnEvent_12613_1 end");
end]]


function OnEvent_12621_1(proxy,param) PickUpItem(proxy,param,12621) end
function OnEvent_12622_1(proxy,param) PickUpItem(proxy,param,12622) end
function OnEvent_12623_1(proxy,param) PickUpItem(proxy,param,12623) end
function OnEvent_12624_1(proxy,param) PickUpItem(proxy,param,12624) end
function OnEvent_12625_1(proxy,param) PickUpItem(proxy,param,12625) end
function OnEvent_12626_1(proxy,param) PickUpItem(proxy,param,12626) end
function OnEvent_12627_1(proxy,param) PickUpItem(proxy,param,12627) end
function OnEvent_12628_1(proxy,param) PickUpItem(proxy,param,12628) end
function OnEvent_12629_1(proxy,param) PickUpItem(proxy,param,12629) end
function OnEvent_12630_1(proxy,param) PickUpItem(proxy,param,12630) end
function OnEvent_12631_1(proxy,param) PickUpItem(proxy,param,12631) end
function OnEvent_12632_1(proxy,param) PickUpItem(proxy,param,12632) end
function OnEvent_12633_1(proxy,param) PickUpItem(proxy,param,12633) end
function OnEvent_12634_1(proxy,param) PickUpItem(proxy,param,12634) end
function OnEvent_12635_1(proxy,param) PickUpItem(proxy,param,12635) end
function OnEvent_12636_1(proxy,param) PickUpItem(proxy,param,12636) end
function OnEvent_12637_1(proxy,param) PickUpItem(proxy,param,12637) end
function OnEvent_12638_1(proxy,param) PickUpItem(proxy,param,12638) end
function OnEvent_12639_1(proxy,param) PickUpItem(proxy,param,12639) end


--該当アイテムを拾った --EN:--Picked up the corresponding item
function PickUpItem(proxy,param,id)
	print("OnEvent_",id,"_1 begin");
	print("PickUpItem");
	proxy:SetEventFlag(12613,false);
	proxy:SetEventFlag(id,false);
	print("OnEvent_",id,"_1 end");
end

--------------------------------------------------------------------------------------
--アイテム取得の監視■658 --EN:-- Monitoring item acquisition 658
--------------------------------------------------------------------------------------
function OnEvent_658(proxy,param)
	print("OnEvent_658 begin");
	
	local idx = 0;
	local num = table.getn( itemevent_endidlist );
	local count = 0;
	for idx = 1, num, 1 do
		ItemChangeCheck(proxy,param,idx);
		if proxy:IsCompleteEvent( itemevent_endidlist[idx] ) == true then
			count = count+1;
		end
	end
	
	print("count = ",count," num = ",num);
	if count == num then
		--すべて取った！ --EN:--Took them all!
		proxy:SetEventFlag( 659,true );
	end		
		
	proxy:TreasureDispModeChange2(1335,false,ITEM_SFX);
	proxy:SetDrawEnable( 1335,false);
	
	proxy:LuaCallStart(4010,1);--アイテム取得同期 --EN:--Item acquisition synchronization
	
	--アイテムイベントフラグOFF --EN:--Item event flag OFF
	proxy:SetEventFlag(12613,false);
	proxy:SetEventFlag(12614,false);
	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		proxy:OnRegistFunc( 655 ,"Check_655","OnEvent_655",1,once);
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	
	print("OnEvent_658 end");
end

--メニュー表示の判定 --EN:--Menu display judgment
function Check_655(proxy,param)

	ITEM_SHOWMENU = proxy:IsShowMenu();
	
	if ITEM_SHOWMENU == false and PREV_ITEM_SHOWMENU == true then
		return true;
	end
	PREV_ITEM_SHOWMENU = ITEM_SHOWMENU;
	return false;
end

--交換会話 --EN:--exchange conversation
function OnEvent_655(proxy,param)
	print("OnEvent_655 begin");
	if proxy:IsCompleteEvent( 659 ) == false then
		proxy:CloseMenu();
		proxy:SetValidTalk(655,true);
		proxy:TalkNextPage(655);
	else
		proxy:CloseMenu();
		proxy:SetValidTalk(659,true);
		proxy:TalkNextPage(659);
		--[[
		関連イベントデリート --EN:Related Event Delete
		654
658
12613
		]]
		proxy:DeleteEvent( 654 );
		proxy:DeleteEvent( 657 );
		proxy:DeleteEvent( 658 );
		proxy:DeleteEvent( 12613 );
	end	
	print("OnEvent_655 end");
end




--[[
鷹の娘の交換イベント --EN:Hawk Girl Exchange Event
アイテム捨てた？ --EN:Dropped an item?

]]

function CheckItemDrop(proxy,param,setNo)	
	--itemevent_typelist		=	{TYPE_WEAPON,TYPE_WEAPON,TYPE_WEAPON,TYPE_GOODS	,	};
	--itemevent_idlist		=	{10000		,10100		,10200		,1017		,	};	
	--itemevent_eventidlist	=	{12621		,12622		,12623		,12624		,	};
	--itemevent_endidlist		=	{12631		,12632		,12633		,12634		,	};
	if proxy:IsDropCheck_Only(10000,itemevent_typelist[setNo],itemevent_idlist[setNo],2284) == true then
		--まだ交換が終わっていない --EN:-- Exchange not finished yet
		if proxy:IsCompleteEvent(itemevent_endidlist[setNo]) == false then
			if proxy:IsRegionDrop( itemevent_eventidlist[setNo] , 10000,itemevent_typelist[setNo],itemevent_idlist[setNo],2284) == true then			
				proxy:CloseMenu();--メニュー閉じます。 --EN:-- Close the menu.
				proxy:SetValidTalk( 12613 ,true);
				proxy:TalkNextPage( 12613 );
				proxy:SetEventFlag( itemevent_eventidlist[setNo],true);
				proxy:SetEventFlag( 12613 , true);
			end
			--該当アイテムを捨てたフラグをON --EN:--ON the flag that discarded the corresponding item
			return true;
		else
			proxy:CloseMenu();--メニュー閉じます。 --EN:-- Close the menu.
			--もう交換が終わっている --EN:--Already exchanged
			proxy:SetValidTalk( 663 ,true);
			proxy:TalkNextPage( 663 );		
			return true;
		end
	end
	--そもそも捨てて無い --EN:--I didn't throw it away in the first place
	return false;
end

--アイテム交換チェック --EN:-- Item exchange check
function ItemChangeCheck(proxy,param,setNo)
	--元アイテムを捨てていて,先アイテムをまだ取ってない --EN:--You have discarded the original item and have not yet taken the previous item
	if proxy:IsCompleteEvent( itemevent_eventidlist[setNo] ) == true and proxy:IsCompleteEvent( itemevent_endidlist[setNo] ) == false then
		proxy:GetRateItem( itemevent_paramlist[setNo] );
		proxy:SetEventFlag( itemevent_eventidlist[setNo] ,false);
		proxy:SetEventFlag( itemevent_endidlist[setNo] ,true);
	end
end

--------------------------------------------------------------------------------------
--整理済み↑　未整理↓■function --EN:--Organized ↑ Unorganized ↓ ■ function
--------------------------------------------------------------------------------------

















--------------------------------------------------------------------------------------
--徘徊デーモンの登場■?? --EN:-- Appearance of the Wandering Demon ??
--------------------------------------------------------------------------------------

--▼グローバルの死亡監視から呼ばれる(ソロ) --EN:--▼ Called from global death watch (solo)
function PlayerDeath_m03_01_00_00(proxy, param)
	print("PlayerDeath_m03_01_00_00");
	
--	LuaFunc_VisibleTheWanderingDemon(proxy, param, demon_id_list_m03_01_00_00);
--	proxy:SetEventFlag( 20 , 1 );--フラグは仮、指定があれば変える。 --EN:The -- flag is tentative, and will be changed if specified.
	
	print("PlayerDeath_m03_01_00_00");
end

--▼グローバルの血文字復活から呼ばれる(ソロ) --EN:--▼Called from global blood letter revival (solo)
function PlayerRevive_m03_01_00_00(proxy,param)
	print("PlayerRevive_m03_01_00_00");
	
--	LuaFunc_InvisibleTheWanderingDemon(proxy, param, demon_id_list_m03_01_00_00);
--	proxy:SetEventFlag( 20 , 0 );--フラグは仮、指定があれば変える。 --EN:The -- flag is tentative, and will be changed if specified.
	
	print("PlayerRevive_m03_01_00_00");
end



--------------------------------------------------------------------------------------
--【水牢NPC】NPCが感謝状態になる■627 --EN:--[Water Prison NPC] NPC becomes grateful ■ 627
--------------------------------------------------------------------------------------
--■627■【水牢NPC】NPCが感謝状態になる■ --EN:--■627■ [Water Prison NPC] NPC becomes grateful ■
function Condition_627(proxy,param)
	if proxy:IsCompleteEvent(639)== true then	
		print("Condition_627 Success");
		return true;
	end
	return false;
end

function OnEvent_627(proxy,param)
	print("OnEvent_627 begin");
	--proxy:SetEventCommand(633,31);	
	--囚人の状態を解放してくれて感謝に設定 --EN:-- set to thanks for releasing prisoner status
	SetNpcStateFlag( proxy, param, syuujin_flag_list, SYUUJIN_STATE_THANKS );	
	--フラグを立てる --EN:-- flag
	proxy:SetEventFlag( 627, true );
	
	print("OnEvent_627 end");
end

--------------------------------------------------------------------------------------
--【水牢NPC】古砦囚人感謝＞休憩■628 --EN:--[Water Prison NPC] Old Fort Prisoner Appreciation > Rest 628
--------------------------------------------------------------------------------------
--■628■古砦囚人感謝＞休憩■ --EN:-- ■ 628 ■ Old Fort Prisoner Appreciation > Rest ■
function OnEvent_628(proxy,param)
	print("OnEvent_628 begin");
	
	--会話から呼ばれているので同期させるためにLuaCallStartで発動 --EN:--Since it is called from the conversation, it is invoked with LuaCallStart to synchronize
	proxy:LuaCallStart(628, 1);
	
	print("OnEvent_628 end");
end

--古砦囚人感謝＞休憩 --EN:--Old Fort Prisoner Appreciation > Break
function OnEvent_628_1(proxy,param)
	print("OnEvent_628_1 begin");	
	--囚人の状態を水牢で休憩に設定 --EN:--Set the prisoner's state to Rest in Water Prison
	SetNpcStateFlag( proxy, param, syuujin_flag_list, SYUUJIN_STATE_INTERVAL );		
	--フラグを立てる --EN:-- flag
	proxy:SetEventFlag( 628, true );
	
	print("OnEvent_628_1 end");
end

--------------------------------------------------------------------------------------
--【水牢NPC】NPCが敵になる■629 --EN:--[Water prison NPC] NPC becomes an enemy 629
--------------------------------------------------------------------------------------
--■629■【水牢NPC】NPCが敵になる■ --EN:--■629■ [Water Prison NPC] NPC becomes an enemy■
function OnEvent_629(proxy,param)
	print("OnEvent_629 begin");
	
	--ロジックOn --EN:--Logic On
	proxy:EnableLogic( 633, true );

	--囚人の状態を敵対に設定 --EN:--set prisoner status to hostile
	SetNpcStateFlag( proxy, param, syuujin_flag_list, SYUUJIN_STATE_ANGRY_01 );
	proxy:SetTeamType( 633, TEAM_TYPE_AngryFriend );

	--敵対したら感謝、休憩にはならないので削除 --EN:--Thanks if hostile, deleted because it's not a break
	proxy:DeleteEvent( 627 );
	proxy:DeleteEvent( 628 );	
	
	--フラグを立てる --EN:-- flag
	proxy:SetEventFlag( 629, true );
	
	print("OnEvent_629 end");
end

--------------------------------------------------------------------------------------
--【【水牢NPC】NPCが死んだ■630 --EN:--[[Water Prison NPC] NPC died ■630
--------------------------------------------------------------------------------------
--■630■【水牢NPC】NPCが死んだ■ --EN:--■630■ [Water Prison NPC] NPC died■
function OnEvent_630(proxy,param)
	print("OnEvent_630 begin");
	
	--囚人の状態を敵対に設定 --EN:--set prisoner status to hostile
	SetNpcStateFlag( proxy, param, syuujin_flag_list, SYUUJIN_STATE_DEAD );
	
	--フラグを立てる --EN:-- flag
	proxy:SetEventFlag( 630, true );
	
	--敵に削られて敵対を通り越して死亡もありえるので、ここでも削除 --EN:--Because it is possible to die by being scraped by the enemy and passing through the hostility, it is also deleted here
	--死んだら感謝、休憩、敵対にはならないので削除 --EN:--Deleted because it does not become gratitude, rest, or hostility when it dies
	proxy:DeleteEvent( 627 );
	proxy:DeleteEvent( 628 );
	proxy:DeleteEvent( 629 );
	
	print("OnEvent_630 end");
end




--------------------------------------------------------------------------------------
--■660■最初の要石の光が消える■ --EN:-- ■ 660 ■ The light of the first keystone disappears ■
--------------------------------------------------------------------------------------

function OnEvent_660(proxy, param)
	print("OnEvent_660 begin");
	
	proxy:TreasureDispModeChange2( 1983 , false ,KANAME_SFX);
	
	print("OnEvent_660 end");
end


--------------------------------------------------------------------------------------
--■661■最初の要石の光が復活する■ --EN:-- ■ 661 ■ The light of the first keystone is restored ■
--------------------------------------------------------------------------------------

function OnEvent_661(proxy, param)
	print("OnEvent_661 begin");
	
	proxy:TreasureDispModeChange2( 1983 , true ,KANAME_SFX);
	
	print("OnEvent_661 end");
end


--------------------------------------------------------------------------------------
--■682■ボスカメラ設定■ --EN:-- ■ 682 ■ boss camera settings ■
--------------------------------------------------------------------------------------
function OnEvent_682(proxy,param)
	--print("OnEvent_682 begin");
	--ボスが死んでいない　かつ　ボスとの戦闘を開始している --EN:-- Boss is not dead and has started a battle with the boss
	if proxy:IsCompleteEvent( 4756 ) == false and proxy:IsCompleteEvent( 641 ) == true then
		--ボス戦　非ロックカメラ --EN:-- Boss battle unlocked camera
		proxy:SetCamModeParamTargetId(3011);
		--ボス戦　ロックカメラ --EN:--Boss battle rock camera
		proxy:SetCamModeParamTargetIdForBossLock(3010);
	end
	--print("OnEvent_682 end");
end

--------------------------------------------------------------------------------------
--■骸骨剣士が動き出す■ --EN:-- ■ The skeleton swordsman starts to move ■
--------------------------------------------------------------------------------------
function Move_Skeleton(proxy, param, ActID, SkeletonCharaID)
	proxy:StopLoopAnimation(SkeletonCharaID);
	proxy:PlayAnimation(SkeletonCharaID, 7001);--起き上がるアニメ再生 --EN:--Wake up animation playback
	proxy:SetSpStayAndDamageAnimId(SkeletonID,-1,-1);--特殊待機アニメの無効化 --EN:--Disable special standby animation
	proxy:SetColiEnable(SkeletonCharaID, true);--アタリON --EN:--Atari ON
	proxy:EnableLogic( SkeletonCharaID, true );--ロジックON --EN:--Logic ON
	print("骸骨剣士("..SkeletonCharaID..")起動"); --EN:print("Skeleton Swordsman("..SkeletonCharaID..") start");
	proxy:SetEventFlag(ActID, true);
end

---------------------------------
--骸骨剣士起動関数発動 --EN:-- Skeleton swordsman activation function activation
---------------------------------
function OnEvent_730(proxy, param)	Move_Skeleton(proxy, param, 730, 360);end
function OnEvent_731(proxy, param)	Move_Skeleton(proxy, param, 731, 361);end
function OnEvent_732(proxy, param)	Move_Skeleton(proxy, param, 732, 362);end
function OnEvent_733(proxy, param)	Move_Skeleton(proxy, param, 733, 363);end
function OnEvent_734(proxy, param)	Move_Skeleton(proxy, param, 734, 364);end
function OnEvent_735(proxy, param)	Move_Skeleton(proxy, param, 735, 365);end
function OnEvent_736(proxy, param)	Move_Skeleton(proxy, param, 736, 366);end
function OnEvent_737(proxy, param)	Move_Skeleton(proxy, param, 737, 367);end
function OnEvent_738(proxy, param)	Move_Skeleton(proxy, param, 738, 368);end
function OnEvent_739(proxy, param)	Move_Skeleton(proxy, param, 739, 369);end
function OnEvent_740(proxy, param) 	Move_Skeleton(proxy, param, 740, 370);end
function OnEvent_741(proxy, param) 	Move_Skeleton(proxy, param, 741, 371);end
function OnEvent_742(proxy, param) 	Move_Skeleton(proxy, param, 742, 372);end
function OnEvent_743(proxy, param)	Move_Skeleton(proxy, param, 743, 373);end
function OnEvent_744(proxy, param) 	Move_Skeleton(proxy, param, 744, 374);end
function OnEvent_745(proxy, param)	Move_Skeleton(proxy, param, 745, 375);end
function OnEvent_746(proxy, param) 	Move_Skeleton(proxy, param, 746, 376);end
function OnEvent_747(proxy, param)	Move_Skeleton(proxy, param, 747, 377);end
function OnEvent_748(proxy, param)	Move_Skeleton(proxy, param, 748, 378);end
function OnEvent_749(proxy, param) 	Move_Skeleton(proxy, param, 749, 379);end
function OnEvent_750(proxy, param)	Move_Skeleton(proxy, param, 750, 380);end
function OnEvent_751(proxy, param)	Move_Skeleton(proxy, param, 751, 381);end
function OnEvent_752(proxy, param)	Move_Skeleton(proxy, param, 752, 382);end
function OnEvent_753(proxy, param)	Move_Skeleton(proxy, param, 753, 383);end
function OnEvent_754(proxy, param)	Move_Skeleton(proxy, param, 754, 384);end
function OnEvent_755(proxy, param)	Move_Skeleton(proxy, param, 755, 428);end
function OnEvent_756(proxy, param)	Move_Skeleton(proxy, param, 756, 429);end
function OnEvent_757(proxy, param)	Move_Skeleton(proxy, param, 757, 430);end
function OnEvent_758(proxy, param)	Move_Skeleton(proxy, param, 758, 431);end
function OnEvent_759(proxy, param)	Move_Skeleton(proxy, param, 759, 432);end

--[[マスターサツキ関連]]----------------------------------------------------------------------------------------------------- --EN:--[[Related to Master Satsuki]]----------------------------------------- -------------------------------------------------- ----------
----------------------------------------------------------------
--■700■サツキが去る■ --EN:-- ■ 700 ■ Satsuki leaves ■
----------------------------------------------------------------
function OnEvent_700(proxy, param)
	proxy:DisableInterupt(638,true);--割り込み禁止 --EN:--disable interrupts
	MoveRegion(proxy,638, 2240, -1, 0.0, true);--ポイント移動 --EN:--Move point
	proxy:SetEventFlag(700, true);
end
----------------------------------------------------------------
--■701■サツキが消える■ --EN:-- ■ 701 ■ Satsuki disappears ■
----------------------------------------------------------------
function OnEvent_701(proxy, param)
	print("OnEvent_701 begin");
	InvalidBackRead(proxy, 638);--無効化させる	 --EN:--disable
	proxy:SetEventFlag(701, true);
	print("OnEvent_701 end");
end
--------------------------------------------------------------------------------------
--■704■サツキ敵対化■ --EN:-- ■ 704 ■ Satsuki hostile ■
--------------------------------------------------------------------------------------
function OnEvent_704(proxy, param)
	if proxy:IsCompleteEvent( 704 ) == false then
		print("OnEvent_704 begin");
		proxy:EnableLogic(637, true);--ロジックON --EN:--Logic ON
		if proxy:IsCompleteEvent( MasterSATSUKI_HOSTILE_Makoto ) == false then
			SetNpcStateFlag(proxy, param, MasterParamFlag_list, MasterSATSUKI_HOSTILE);--状態変化 --EN:-- state change
		end
		proxy:SetTeamType(637, TEAM_TYPE_AngryFriend);--チームタイプ変更 --EN:--Change team type
		
		proxy:SetEventFlag( 704, true );
		print("OnEvent_704 end");
	end
end

function MakotoAngry(proxy,param,eventid,wepoid)
	print("OnEvent_",eventid," begin");
	--誠をPCのアイテム欄から削除 --EN:--Makoto was deleted from the item column of the PC
	if	proxy:RemoveInventoryEquip( TYPE_WEAPON, wepoid ) == true then--誠を削除できた　ならば --EN:--If Makoto could be deleted
		print("OnEvent_",eventid," アイテム(誠)削除成功"); --EN:print("OnEvent_",eventid,"Successfully deleted item (Makoto)");
	end
	
	proxy:EnableLogic(637, true);--ロジックON --EN:--Logic ON
	SetNpcStateFlag(proxy, param, MasterParamFlag_list, MasterSATSUKI_HOSTILE_Makoto);--状態変化 --EN:-- state change
	proxy:SetTeamType(637, TEAM_TYPE_AngryFriend);--チームタイプ変更		 --EN:--Change team type
	
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 705,"OnEvent_705_1",0.0,0,0,once);
	proxy:NotNetMessage_end();
	proxy:SetEventFlag( eventid, true );
	print("OnEvent_",eventid," end");
end

--------------------------------------------------------------------------------------
--■705■サツキ敵対化(誠入手)■ --EN:-- ■ 705 ■ Satsuki becomes hostile (obtained by Makoto) ■
--------------------------------------------------------------------------------------
function OnEvent_705(proxy, param) MakotoAngry(proxy,param,705,40700); end
function OnEvent_713(proxy, param) MakotoAngry(proxy,param,713,40701); end
function OnEvent_714(proxy, param) MakotoAngry(proxy,param,714,40702); end
function OnEvent_715(proxy, param) MakotoAngry(proxy,param,715,40703); end
function OnEvent_716(proxy, param) MakotoAngry(proxy,param,716,40704); end
function OnEvent_717(proxy, param) MakotoAngry(proxy,param,717,40705); end

function OnEvent_705_1(proxy,param)
	print("OnEvent_705_1 begin");
	--proxy:ResetThink( 637 );
	proxy:SendEventRequest( 637 , 0 , 10 );	
	--if TargetChangeWepR2(proxy, 637) == false then
		--print("★★★★★武器切り替え失敗！！★★★★★"); --EN:--print("★★★★★Weapon switching failure!!★★★★★");
	--end--サブ武器（誠）に切り替えさせる --EN:-- Switch to sub-weapon (Makoto)
	print("OnEvent_705_1 end");
end

--------------------------------------------------------------------------------------
--■706■サツキ敵対化(誠未入手)■ --EN:-- ■ 706 ■ Satsuki hostile (Makoto not obtained) ■
--------------------------------------------------------------------------------------
function OnEvent_706(proxy, param)
	print("OnEvent_706 begin");
	proxy:EnableLogic(637, true);--ロジックON --EN:--Logic ON
	SetNpcStateFlag(proxy, param, MasterParamFlag_list, MasterSATSUKI_HOSTILE);--状態変化 --EN:-- state change
	proxy:SetTeamType(637, TEAM_TYPE_AngryFriend);--チームタイプ変更 --EN:--Change team type

	proxy:SetEventFlag( 706, true );
	print("OnEvent_706 end");
end
--------------------------------------------------------------------------------------
--■707■サツキ死亡■ --EN:-- ■ 707 ■ Satsuki died ■
--------------------------------------------------------------------------------------
function OnEvent_707(proxy, param)
	print("OnEvent_707 begin");
	SetNpcStateFlag( proxy, param, MasterParamFlag_list, MasterSATSUKI_DEAD );
	
	proxy:SetEventFlag( 707, true );
	print("OnEvent_707 end");
end
------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------
--■711■サツキブラック死亡■ --EN:-- ■ 711 ■ Satsuki Black died ■
--------------------------------------------------------------------------------------
function OnEvent_711(proxy, param)
	print("OnEvent_711 begin");
	proxy:SetEventFlag( 711, true );
	print("OnEvent_711 end");
end

--サツキ・ブラックの死体を調べてない --EN:--You haven't examined Satsuki Black's corpse
function OnEvent_15634(proxy,param)
	print("OnEvent_15634 begin");
	proxy:SetEventFlag( 15634 , true );
	print("OnEvent_15634 end");
end


------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------
--古砦囚人管理ポイント■631～633 --EN:--Old Fort Prisoner Management Point ■631～633
--------------------------------------------------------------------------------------
function OnEvent_631(proxy,param) proxy:LuaCallStart(634,1); end
function OnEvent_632(proxy,param) proxy:LuaCallStart(634,1); end
function OnEvent_633(proxy,param) proxy:LuaCallStart(634,1); end


--------------------------------------------------------------------------------------
--古砦囚人状態変化■634 --EN:--Old Fort Prisoner State Change 634
--------------------------------------------------------------------------------------
function OnEvent_634(proxy,param)
	print("OnEvent_634 begin");
	print("JustInCheckPoint");
	
	local SyuujinId_1 = 633;--古砦１のイベントID --EN:--Event ID of Old Fort 1
	local SyuujinId_2 = 678;--古砦２のイベントID --EN:--Event ID of Old Fort 2
	
	local SyuujinBlock1_acid_list = {627,628,629,630};
	local SyuujinBlock2_acid_list = {1185,1186};
	
	--一旦2体とも消える --EN:--both disappear once
	InvalidCharactor(proxy,SyuujinId_1);
	InvalidCharactor(proxy,SyuujinId_2);
	
	if proxy:IsClient() == false then
		proxy:RequestForceUpdateNetwork( SyuujinId_1);
		proxy:RequestForceUpdateNetwork( SyuujinId_2);		
	end
	
	--ブロックの監視を削除 --EN:--remove block watcher
	DeleteConditionList(proxy,SyuujinBlock1_acid_list);	
	DeleteConditionList(proxy,SyuujinBlock2_acid_list);
	
	--取りあえず初期状態を設定 --EN:-- Set the initial state for now
	SetFirstNpcStateFlag( proxy, param, syuujin_flag_list, SYUUJIN_STATE_ESCAPE );
	
	--囚人牢から出たい --EN:--I want to get out of the prison cell
	if proxy:IsCompleteEvent( SYUUJIN_STATE_ESCAPE ) == true then
		print("Syuujin NowState SYUUJIN_STATE_ESCAPE");
		SetSyuujinState1(proxy,param);
		RegistConditionBlock1(proxy,param);
	
	--囚人牢から出してくれて感謝 --EN:--thank you for letting me out of the prison cell
	elseif proxy:IsCompleteEvent( SYUUJIN_STATE_THANKS ) == true then
		print("Syuujin NowState SYUUJIN_STATE_THANKS");
		SetSyuujinState2(proxy,param);
		RegistConditionBlock1(proxy,param);
	
	--囚人牢屋で休憩 --EN:--Break in the prison cell
	elseif proxy:IsCompleteEvent( SYUUJIN_STATE_INTERVAL ) == true then
		print("Syuujin NowState SYUUJIN_STATE_INTERVAL");
		SetSyuujinState3(proxy,param);
		RegistConditionBlock2(proxy,param);
	
	--囚人古砦１で敵対	 --EN:-- Hostile at Prisoner Old Fort 1
	elseif proxy:IsCompleteEvent( SYUUJIN_STATE_ANGRY_01 ) == true then
		print("Syuujin NowState SYUUJIN_STATE_ANGRY_01");
		SetSyuujinState4(proxy,param);
		RegistConditionBlock1(proxy,param);
	
	--囚人死亡 --EN:--prisoner dead
	elseif proxy:IsCompleteEvent( SYUUJIN_STATE_DEAD ) == true then
		print("Syuujin NowState SYUUJIN_STATE_DEAD");
		SetSyuujinState5(proxy,param);
	
	--囚人古砦２にいる --EN:--In Prisoner Old Fort 2
	elseif proxy:IsCompleteEvent( SYUUJIN_STATE_STAY ) == true then
		print("Syuujin NowState SYUUJIN_STATE_STAY");
		SetSyuujinState6(proxy,param);
		RegistConditionBlock2(proxy,param);
	
	--囚人古砦２で敵対 --EN:-- Hostile at Prisoner Old Fort 2
	elseif proxy:IsCompleteEvent( SYUUJIN_STATE_ANGRY_02 ) == true then
		print("Syuujin NowState SYUUJIN_STATE_ANGRY_02");
		SetSyuujinState7(proxy,param);
		RegistConditionBlock2(proxy,param);
	
	--状態遷移なくねー？ --EN:--No state transitions, huh?
	else
		print("Syuujin NowState UnKnown");	
	end
	print("OnEvent_634 end");
end

--------------------------------------------------------------------------------------
--囚人牢から出たい■16050 --EN:-- I want to get out of the prison prison ■ 16050
--------------------------------------------------------------------------------------
function SetSyuujinState1(proxy,param)	
	ValidCharactor(proxy,633);--古砦１にいる囚人を有効化 --EN:--Enable Prisoners in Old Fort 1
	--proxy:SetEventCommand(633,30);
	--■627■【水牢NPC】NPCが感謝状態じゃない■ --EN:--■627■ [Water Prison NPC] NPC is not in gratitude ■
	if proxy:IsCompleteEvent( 627 ) == false then
		proxy:OnRegistFunc( 627, "Condition_627", "OnEvent_627", 1, once );				
	end	
	
	--■628■【水牢NPC】NPCからアイテムをもらってない■ --EN:--■628■ [Water Prison NPC] I haven't received any items from the NPC■
	if proxy:IsCompleteEvent( 628 ) == false then
		proxy:NotNetMessage_begin();
			proxy:LuaCall( 628, 0, "OnEvent_628", once );
		proxy:NotNetMessage_end();
		--同期用のハンドラ --EN:--handler for synchronization
		proxy:LuaCall(628, 1, "OnEvent_628_1", once);
	end
end

--------------------------------------------------------------------------------------
--囚人牢から出してくれて感謝■16051 --EN:--Thank you for letting me out of the prison 16051
--------------------------------------------------------------------------------------
function SetSyuujinState2(proxy,param)	
	ValidCharactor(proxy,633);--古砦１にいる囚人を有効化 --EN:--Enable Prisoners in Old Fort 1
	--■628■【水牢NPC】NPCからアイテムをもらってない■ --EN:--■628■ [Water Prison NPC] I haven't received any items from the NPC■
	if proxy:IsCompleteEvent( 628 ) == false then
		proxy:NotNetMessage_begin();
			proxy:LuaCall( 628, 0, "OnEvent_628", once );
		proxy:NotNetMessage_end();
		--同期用のハンドラ --EN:--handler for synchronization
		proxy:LuaCall(628, 1, "OnEvent_628_1", once);
		
	end
end

--------------------------------------------------------------------------------------
--囚人牢屋で休憩■16052 --EN:--Break in the prisoner's cell 16052
--------------------------------------------------------------------------------------
function SetSyuujinState3(proxy,param)
	--審判者が死んでいない --EN:--The referee is not dead
	if proxy:IsCompleteEvent( 4756 ) == false then
		ValidCharactor(proxy,633);--古砦１にいる囚人を有効化		 --EN:--Enable Prisoners in Old Fort 1
		
	--審判者が死んでいる --EN:--The referee is dead
	else
		print("Syuujin NowState SYUUJIN_STATE_INTERVAL > Chenge to SYUUJIN_STATE_STAY");
		InvalidBackRead(proxy,633);--古砦１にいる囚人を無効化 --EN:--Nullify prisoners in Old Fort 1
		ValidCharactor(proxy,678);--古砦２にいる囚人を有効化 --EN:--Enable Prisoners in Old Fort 2
		--状態を古砦２にいるに変更 --EN:--Change status to Old Fort 2
		SetNpcStateFlag( proxy, param, syuujin_flag_list, SYUUJIN_STATE_STAY );	
	end
end

--------------------------------------------------------------------------------------
--囚人古砦１で敵対■16053 --EN:-- Hostile at Prisoner Old Fort 1 16053
--------------------------------------------------------------------------------------
function SetSyuujinState4(proxy,param)
	ValidCharactor(proxy,633);--古砦１にいる囚人を有効化 --EN:--Enable Prisoners in Old Fort 1
	proxy:SetTeamType( 633, TEAM_TYPE_AngryFriend );
end

--------------------------------------------------------------------------------------
--囚人死亡■16054 --EN:-- Prisoner Death ■ 16054
--------------------------------------------------------------------------------------
function SetSyuujinState5(proxy,param)
	InvalidBackRead(proxy,633);--古砦１にいる囚人を無効化 --EN:--Nullify prisoners in Old Fort 1
	InvalidBackRead(proxy,678);--古砦２にいる囚人を無効化 --EN:--Nullify prisoners in Old Fort 2
end

--------------------------------------------------------------------------------------
--囚人古砦２にいる■16055 --EN:--In Prisoner Old Fort 2 16055
--------------------------------------------------------------------------------------
function SetSyuujinState6(proxy,param)
	InvalidBackRead(proxy,633);--古砦１にいる囚人を無効化 --EN:--Nullify prisoners in Old Fort 1
	ValidCharactor(proxy,678);--古砦２にいる囚人を有効化 --EN:--Enable Prisoners in Old Fort 2
end

--------------------------------------------------------------------------------------
--囚人古砦２で敵対■16056 --EN:-- Hostile at Prisoner Old Fort 2 16056
--------------------------------------------------------------------------------------
function SetSyuujinState7(proxy,param)
	InvalidBackRead(proxy,633);--古砦１にいる囚人を無効化 --EN:--Nullify prisoners in Old Fort 1
	ValidCharactor(proxy,678);--古砦２にいる囚人を有効化 --EN:--Enable Prisoners in Old Fort 2
	proxy:SetTeamType( 678, TEAM_TYPE_AngryFriend );
end


--------------------------------------------------------------------------------------
--囚人古砦1監視■ --EN:--Convict Old Fort 1 Surveillance■
--------------------------------------------------------------------------------------
function RegistConditionBlock1(proxy,param)	
	--囚人が死んでいない --EN:-- Prisoner not dead
	if proxy:IsCompleteEvent( SYUUJIN_STATE_DEAD ) == false then
		--古砦１、２で敵対になっていない --EN:--Not hostile in Old Fort 1 and 2
		if proxy:IsCompleteEvent( SYUUJIN_STATE_ANGRY_01 ) == false 
		and proxy:IsCompleteEvent( SYUUJIN_STATE_ANGRY_02 ) == false then			
			--ホストからのダメージ監視 --EN:--Damage monitoring from host
			--m03_01
			--proxy:OnCharacterTotalDamage( 629, 633, 10000, SYUUJIN_TOTAL_DAMAGE, "OnEvent_629", once );	
			proxy:OnCharacterTotalRateDamage( 629, 633, LOCAL_PLAYER, NPC_ANGRY_Rate, "OnEvent_629", once );
			--m03_02
			--proxy:OnCharacterTotalDamage( 1185, 678, 10000, SYUUJIN_TOTAL_DAMAGE, "OnEvent_1185_1", once );				
			proxy:OnCharacterTotalRateDamage( 1185, 678, LOCAL_PLAYER, NPC_ANGRY_Rate, "OnEvent_1185_1", once );
		end
		--囚人の死亡監視 --EN:--Prisoner Death Watch
		proxy:OnCharacterDead( 630, 633, "OnEvent_630", once );				
	end
end

--------------------------------------------------------------------------------------
--囚人古砦2監視■ --EN:--Convict Old Fort 2 Surveillance■
--------------------------------------------------------------------------------------
function RegistConditionBlock2(proxy,param)
	--囚人が死んでいない --EN:-- Prisoner not dead
	if proxy:IsCompleteEvent( SYUUJIN_STATE_DEAD ) == false then
		--古砦１、２で敵対になっていない --EN:--Not hostile in Old Fort 1 and 2
		if proxy:IsCompleteEvent( SYUUJIN_STATE_ANGRY_01 ) == false
		and proxy:IsCompleteEvent( SYUUJIN_STATE_ANGRY_02 ) == false then
			--ホストからのダメージ監視 --EN:--Damage monitoring from host
			--m03_01
			--proxy:OnCharacterTotalDamage( 629, 633, 10000, SYUUJIN_TOTAL_DAMAGE, "OnEvent_629", once );			
			proxy:OnCharacterTotalRateDamage( 629, 633, LOCAL_PLAYER, NPC_ANGRY_Rate, "OnEvent_629", once );
			--m03_02
			--proxy:OnCharacterTotalDamage( 1185, 678, 10000, SYUUJIN_TOTAL_DAMAGE, "OnEvent_1185_1", once );
			proxy:OnCharacterTotalRateDamage( 1185, 678, LOCAL_PLAYER, NPC_ANGRY_Rate, "OnEvent_1185_1", once );
		end
			--囚人の死亡監視 --EN:--Prisoner Death Watch
			proxy:OnCharacterDead( 1186 , 678 , "OnEvent_1186" , once );
		
	end
end


-----------------------------------------------------------------------------
--■780～784■槍射出トラップ --EN:-- ■ 780～784 ■ Spear injection trap
-----------------------------------------------------------------------------
--■780～784■トラップ発動！槍射出 --EN:--■780～784■Trap activated! spear injection
function SpearTrapMove_780(proxy, param)
	proxy:ForcePlayAnimation(1250, 1);--強制的にアニメを再生（再生されていた場合、強制終了） --EN:--Forcibly play animation (if it is playing, it will be terminated)
end
function SpearTrapMove_782(proxy, param)
	proxy:ForcePlayAnimation(1252, 1);--強制的にアニメを再生（再生されていた場合、強制終了） --EN:--Forcibly play animation (if it is playing, it will be terminated)
end
function SpearTrapMove_783(proxy, param)
	proxy:ForcePlayAnimation(1253, 1);--強制的にアニメを再生（再生されていた場合、強制終了） --EN:--Forcibly play animation (if it is playing, it will be terminated)
end
function SpearTrapMove_784(proxy, param)
	proxy:ForcePlayAnimation(1254, 1);--強制的にアニメを再生（再生されていた場合、強制終了） --EN:--Forcibly play animation (if it is playing, it will be terminated)
end

--■780■槍射出トラップ（連射）■---------------------------------------------------- --EN:-- ■ 780 ■ Spear ejection trap (continuous fire) ■ --------------------------------------- --------------
function OnEvent_780(proxy,param)
	print("OnEvent_780 begin");
	proxy:PlayAnimation( 1240, 1 );
	
	proxy:DeleteObjSfxDmyPlyID(1240, 1);--SFX無効化 --EN:--Disable SFX
	proxy:CreateSfx_DummyPoly(1240, 1, 93006 );--新たなSFXを設定 --EN:--Set new SFX
	proxy:NotNetMessage_begin();
		proxy:OnObjAnimEnd( 780, 1240, 1, "SpearTrapCount_780", once );
	proxy:NotNetMessage_end();
	print("OnEvent_780 end");
end
function SpearTrapCount_780(proxy,param)--準備 --EN:--preparation
	--ネット配信されていたら --EN:--If it was distributed online
	if param:IsNetMessage() == true then
		return;--抜ける --EN:--Exit
	end
	
	print("Count_780 begin");
		--発動者のみ秒数カウント --EN:--Only the invoker counts the number of seconds
		proxy:NotNetMessage_begin();
			proxy:OnKeyTime2( 780, "OnEvent_780_1", 1.0, 0, 0, once );--１発目(1.0秒後) --EN:-- 1st shot (after 1.0 seconds)
			proxy:OnKeyTime2( 780, "OnEvent_780_2", 1.5, 0, 1, once );--２発目(1.5秒後)↑の0.5秒後 --EN:--0.5 seconds after the second shot (1.5 seconds later) ↑
			proxy:OnKeyTime2( 780, "OnEvent_780_3", 2.0, 0, 2, once );--３発目(2.0秒後)↑の0.5秒後 --EN:--0.5 seconds after the third shot (2.0 seconds later) ↑
		proxy:NotNetMessage_end();
	print("Count_780 end");
end
function OnEvent_780_1(proxy,param)--1発目 --EN:-- 1st shot
	print("OnEvent_780_1 begin");
	proxy:LuaCallStart(780, 0);
	print("OnEvent_780_1 end");
end
function OnEvent_780_2(proxy,param)--2発目 --EN:--Second shot
	print("OnEvent_780_2 begin");
	proxy:LuaCallStart(780, 0);
	print("OnEvent_780_2 end");
end
function OnEvent_780_3(proxy,param)--3発目 --EN:--3rd shot
	print("OnEvent_780_3 begin");
	proxy:LuaCallStart(780, 0);
	proxy:NotNetMessage_begin();
		proxy:OnObjAnimEnd(780, 1250, 1, "OnEvent_780_End", once);--アニメが終了したらフラグを立てる --EN:--Set a flag when the animation ends
	proxy:NotNetMessage_end();
	print("OnEvent_780_3 end");
end
function OnEvent_780_End(proxy, param)
	proxy:SetEventFlag( 780, true );
end

--■781■槍射出トラップ（散弾）■---------------------------------------------------- --EN:-- ■ 781 ■ Spear ejection trap (shotgun) ■ --------------------------------------- --------------
function OnEvent_781(proxy,param)
	print("OnEvent_781 begin");
	proxy:PlayAnimation( 1241, 1 );
	
	proxy:DeleteObjSfxDmyPlyID(1241, 1);--SFX無効化 --EN:--Disable SFX
	proxy:CreateSfx_DummyPoly(1241, 1, 93006 );--新たなSFXを設定 --EN:--Set new SFX
	
	proxy:NotNetMessage_begin();
		proxy:OnObjAnimEnd( 781, 1241, 1, "OnEvent_781_1", once );
	proxy:NotNetMessage_end();
	proxy:SetEventFlag( 781, true );
	print("OnEvent_781 end");
end
function OnEvent_781_1(proxy,param)
	print("OnEvent_781_1 begin");
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 781, "OnEvent_781_2", 1.0, 0, 0, once );
	proxy:NotNetMessage_end();
	print("OnEvent_781_1 end");
end
function OnEvent_781_2(proxy,param)--一斉発射 --EN:-- salvo
	print("OnEvent_781_2 begin");
	proxy:PlayAnimation(1251, 1);
	proxy:PlayAnimation(1260, 1);
	proxy:PlayAnimation(1261, 1);
	proxy:PlayAnimation(1262, 1);
	proxy:PlayAnimation(1263, 1);
	proxy:PlayAnimation(1264, 1);
	print("OnEvent_781_2 end");
end


--■782■槍射出トラップ（連射）■---------------------------------------------------- --EN:-- ■ 782 ■ Spear ejection trap (rapid fire) ■ -------------------------------------- --------------
function OnEvent_782(proxy,param)
	print("OnEvent_782 begin");
	proxy:PlayAnimation( 1242, 1 );
	
	proxy:DeleteObjSfxDmyPlyID(1242, 1);--SFX無効化 --EN:--Disable SFX
	proxy:CreateSfx_DummyPoly(1242, 1, 93006 );--新たなSFXを設定 --EN:--Set new SFX
	
	proxy:NotNetMessage_begin();
		proxy:OnObjAnimEnd( 782, 1242, 1, "SpearTrapCount_782", once );
	proxy:NotNetMessage_end();
	print("OnEvent_782 end");
end
function SpearTrapCount_782(proxy,param)
	--ネット配信されていたら --EN:--If it was distributed online
	if param:IsNetMessage() == true then
		return;--抜ける --EN:--Exit
	end
	
	print("Count_782 begin");
		--発動者のみ秒数カウント --EN:--Only the invoker counts the number of seconds
		proxy:NotNetMessage_begin();
			proxy:OnKeyTime2( 782, "OnEvent_782_1", 1.0, 0, 0, once );--１発目(1.0秒後) --EN:-- 1st shot (after 1.0 seconds)
			proxy:OnKeyTime2( 782, "OnEvent_782_2", 1.5, 0, 1, once );--２発目(1.5秒後)↑の0.5秒後 --EN:--0.5 seconds after the second shot (1.5 seconds later) ↑
			proxy:OnKeyTime2( 782, "OnEvent_782_3", 2.0, 0, 2, once );--３発目(2.0秒後)↑の0.5秒後 --EN:--0.5 seconds after the third shot (2.0 seconds later) ↑
		proxy:NotNetMessage_end();
	print("Count_782 end");
end
function OnEvent_782_1(proxy,param)--1発目 --EN:-- 1st shot
	print("OnEvent_782_1 begin");
	proxy:LuaCallStart(782, 0);
	print("OnEvent_782_1 end");
end
function OnEvent_782_2(proxy,param)--2発目 --EN:--Second shot
	print("OnEvent_782_2 begin");
	proxy:LuaCallStart(782, 0);
	print("OnEvent_782_2 end");
end
function OnEvent_782_3(proxy,param)--3発目 --EN:--3rd shot
	print("OnEvent_782_3 begin");
	proxy:LuaCallStart(782, 0);
	proxy:NotNetMessage_begin();
		proxy:OnObjAnimEnd(782, 1252, 1, "OnEvent_782_End", once);--アニメが終了したらフラグを立てる --EN:--Set a flag when the animation ends
	proxy:NotNetMessage_end();
	print("OnEvent_782_3 end");
end
function OnEvent_782_End(proxy, param)
	proxy:SetEventFlag( 782, true );
end

--■783■槍射出トラップ（連射）■---------------------------------------------------- --EN:-- ■ 783 ■ Spear ejection trap (rapid fire) ■ --------------------------------------- --------------
function OnEvent_783(proxy,param)
	print("OnEvent_783 begin");
	proxy:PlayAnimation( 1243, 1 );
	
	proxy:DeleteObjSfxDmyPlyID(1243, 1);--SFX無効化 --EN:--Disable SFX
	proxy:CreateSfx_DummyPoly(1243, 1, 93006 );--新たなSFXを設定 --EN:--Set new SFX
	
	proxy:NotNetMessage_begin();
		proxy:OnObjAnimEnd( 783, 1243, 1, "SpearTrapCount_783", once );
	proxy:NotNetMessage_end();
	print("OnEvent_783 end");
end
function SpearTrapCount_783(proxy,param)--準備 --EN:--preparation
	--ネット配信されていたら --EN:--If it was distributed online
	if param:IsNetMessage() == true then
		return;--抜ける --EN:--Exit
	end
	
	print("Count_783 begin");
		--発動者のみ秒数カウント --EN:--Only the invoker counts the number of seconds
		proxy:NotNetMessage_begin();
			proxy:OnKeyTime2( 783, "OnEvent_783_1", 1.0, 0, 0, once );--１発目(1.0秒後) --EN:-- 1st shot (after 1.0 seconds)
			proxy:OnKeyTime2( 783, "OnEvent_783_2", 1.5, 0, 1, once );--２発目(1.5秒後)↑の0.5秒後 --EN:--0.5 seconds after the second shot (1.5 seconds later) ↑
			proxy:OnKeyTime2( 783, "OnEvent_783_3", 2.0, 0, 2, once );--３発目(2.0秒後)↑の0.5秒後 --EN:--0.5 seconds after the third shot (2.0 seconds later) ↑
		proxy:NotNetMessage_end();
	print("Count_783 end");
end
function OnEvent_783_1(proxy,param)--1発目 --EN:-- 1st shot
	print("OnEvent_783_1 begin");
	proxy:LuaCallStart(783, 0);
	print("OnEvent_783_1 end");
end
function OnEvent_783_2(proxy,param)--2発目 --EN:--Second shot
	print("OnEvent_783_2 begin");
	proxy:LuaCallStart(783, 0);
	print("OnEvent_783_2 end");
end
function OnEvent_783_3(proxy,param)--3発目 --EN:--3rd shot
	print("OnEvent_783_3 begin");
	proxy:LuaCallStart(783, 0);

	--■785■カラスの鳴き声が響く --EN:-- ■ 785 ■ A crow's cry echoes
	SingleReset(proxy, 785);--リピートなので、リセット --EN:--Reset because it is a repeat
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 785, "OnEvent_785", 2.0, 0, 0, once );--2秒後に、ボスが生きていたらカラスの鳴き声を鳴らす --EN:-- After 2 seconds, play a crow's call if the boss is alive
		proxy:OnObjAnimEnd(783, 1253, 1, "OnEvent_783_End", once);--アニメが終了したらフラグを立てる --EN:--Set a flag when the animation ends
	proxy:NotNetMessage_end();	
	print("OnEvent_783_3 end");
end
function OnEvent_783_End(proxy, param)
	proxy:SetEventFlag( 783, true );
end

--■784■槍射出トラップ（連射）■---------------------------------------------------- --EN:-- ■ 784 ■ Spear ejection trap (rapid fire) ■ -------------------------------------- --------------
function OnEvent_784(proxy,param)
	print("OnEvent_784 begin");
	proxy:PlayAnimation( 1244, 1 );
	
	proxy:DeleteObjSfxDmyPlyID(1244, 1);--SFX無効化 --EN:--Disable SFX
	proxy:CreateSfx_DummyPoly(1244, 1, 93006 );--新たなSFXを設定 --EN:--Set new SFX
	
	proxy:NotNetMessage_begin();
		proxy:OnObjAnimEnd( 784, 1244, 1, "SpearTrapCount_784", once );
	proxy:NotNetMessage_end();
	print("OnEvent_784 end");
end
function SpearTrapCount_784(proxy,param)--準備 --EN:--preparation
	--ネット配信されていたら --EN:--If it was distributed online
	if param:IsNetMessage() == true then
		return;--抜ける --EN:--Exit
	end
	
	print("Count_784 begin");
		--発動者のみ秒数カウント --EN:--Only the invoker counts the number of seconds
		proxy:NotNetMessage_begin();
			proxy:OnKeyTime2( 784, "OnEvent_784_1", 1.0, 0, 0, once );--１発目(0.0秒後) --EN:-- 1st shot (after 0.0 second)
			proxy:OnKeyTime2( 784, "OnEvent_784_2", 1.5, 0, 1, once );--２発目(0.5秒後) --EN:-- 2nd shot (after 0.5 seconds)
			proxy:OnKeyTime2( 784, "OnEvent_784_3", 2.0, 0, 2, once );--３発目(1.0秒後) --EN:-- 3rd shot (after 1.0 seconds)
		proxy:NotNetMessage_end();
	print("Count_784 end");
end
function OnEvent_784_1(proxy,param)--1発目 --EN:-- 1st shot
	print("OnEvent_784_1 begin");
	proxy:LuaCallStart(784, 0);
	print("OnEvent_784_1 end");
end
function OnEvent_784_2(proxy,param)--2発目 --EN:--Second shot
	print("OnEvent_784_2 begin");
	proxy:LuaCallStart(784, 0);
	print("OnEvent_784_2 end");
end
function OnEvent_784_3(proxy,param)--3発目 --EN:--3rd shot
	print("OnEvent_784_3 begin");
	proxy:LuaCallStart(784, 0);
	proxy:NotNetMessage_begin();
		proxy:OnObjAnimEnd(784, 1254, 1, "OnEvent_784_End", once);--アニメが終了したらフラグを立てる --EN:--Set a flag when the animation ends
	proxy:NotNetMessage_end();
	print("OnEvent_784_3 end");
end
function OnEvent_784_End(proxy, param)
	proxy:SetEventFlag( 784, true );
end

--■785■カラス鳴き声が響く■---------------------------------------------------- --EN:--■785■Crows cry■---------------------------------------------------- ------------
function OnEvent_785(proxy,param)
	print("OnEvent_785 begin");
	if proxy:IsCompleteEvent(4756) == false then--ボスが生きていたら --EN:--If the boss were alive
		proxy:PlayTypeSE(804, SOUND_TYPE_C, 504077777);
	end
	proxy:SetEventFlag( 785, true );
	print("OnEvent_785 end");
end


-----------------------------------------------------------------------------
--■4788～4792■柱破壊イベント監視 --EN:-- ■ 4788～4792 ■ Pillar destruction event monitoring
-----------------------------------------------------------------------------
function OnEvent_4788(proxy,param) 
	print("OnEvent_4788 begin");
	proxy:SetEventFlag( 4788 , true );
	print("OnEvent_4788 end");
end

function OnEvent_4789(proxy,param) 
	print("OnEvent_4789 begin");
	proxy:SetEventFlag( 4789 , true );
	print("OnEvent_4789 end");
end

function OnEvent_4790(proxy,param) 
	print("OnEvent_4790 begin");
	proxy:SetEventFlag( 4790 , true );
	print("OnEvent_4790 end");
end

function OnEvent_4791(proxy,param) 
	print("OnEvent_4791 begin");
	proxy:SetEventFlag( 4791 , true );
	print("OnEvent_4791 end");
end

function OnEvent_4792(proxy,param) 
	print("OnEvent_4792 begin");
	proxy:SetEventFlag( 4792 , true );
	print("OnEvent_4792 end");
end


-----------------------------------------------------------------------------
--■550■デブデーモン監視 --EN:-- ■ 550 ■ fat daemon monitoring
-----------------------------------------------------------------------------
function OnEvent_550(proxy,param)
	print("OnEvent_550 begin");
	proxy:SetEventFlag( 550 , true );
	proxy:SetEventFlag( 551 , true );	
	proxy:DeleteEvent( 552 );
	print("OnEvent_550 end");
end

function OnEvent_552(proxy,param)
	--if proxy:GetTargetChrID( 10000 ) == 421 then
		proxy:SetCamModeParamTargetIdForBossLock(3110);
--		print("true");
--	else
--		print("false");
--	end
--やっぱりAIからのターゲットIDじゃロックは取れなかった --EN:--I couldn't get the lock with the target ID from the AI
end

-----------------------------------------------------------------------------
--■■結晶トカゲイベント --EN:-- ■ ■ Crystal lizard event
-----------------------------------------------------------------------------
--ボス撃破時のトカゲリセット用 --EN:--For lizard reset when defeating boss
function ResetTokage(proxy)
	print("ResetTokage");
	--proxy:SetEventFlag(620,false);
	--proxy:SetEventFlag(622,false);
	--proxy:SetEventFlag(1040,false);
	--proxy:SetEventFlag(1580,false);
	--proxy:SetEventFlag(1582,false);	
	AddEventCounter(proxy,7);
	AddEventCounter(proxy,8);
	AddEventCounter(proxy,9);
	AddEventCounter(proxy,10);
	AddEventCounter(proxy,11);
	
end


-----------------------------------------------------------------------------
--■620■結晶トカゲイベント1 --EN:-- ■ 620 ■ Crystal Lizard Event 1
-----------------------------------------------------------------------------
function OnEvent_620(proxy,param)
	print("OnEvent_620 begin");
	proxy:SetEventFlag( 620, true);
	proxy:DeleteEvent( 620 );
	print("OnEvent_620 end");
end

-----------------------------------------------------------------------------
--■622■結晶トカゲイベント2 --EN:-- ■ 622 ■ Crystal Lizard Event 2
-----------------------------------------------------------------------------
function OnEvent_622(proxy,param)
	print("OnEvent_622 begin");
	proxy:SetEventFlag( 622 , true );
	proxy:DeleteEvent( 622 );
	print("OnEvent_622 end");
end

-----------------------------------------------------------------------------
--■790■魔法壁破壊1 --EN:-- ■ 790 ■ magic wall destruction 1
-----------------------------------------------------------------------------
function OnEvent_790(proxy,param)
	print("OnEvent_790 begin");
	proxy:InvalidSfx( 2320 , true );
	proxy:SetEventFlag( 790,true );
	print("OnEvent_790 end");
end

-----------------------------------------------------------------------------
--■791■魔法壁破壊2 --EN:-- ■ 791 ■ magic wall destruction 2
-----------------------------------------------------------------------------
function OnEvent_791(proxy,param)
	print("OnEvent_791 begin");
	proxy:InvalidSfx( 2321 , true );
	proxy:SetEventFlag( 791,true );
	print("OnEvent_791 end");
end
