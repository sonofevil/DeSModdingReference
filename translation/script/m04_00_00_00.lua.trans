
--アイアンメイデン内の虜囚の攻撃までの待ち時間 --EN:--Waiting time before attacking prisoners in Iron Maiden
RYOSYU_ATTACK_WAIT = 0.0;

--[[【ヴィライデル】状態一覧]] --EN:--[[[Viraidel] status list]]
VIRAIDEL_STATE_HELP		=	16370;--牢から出たい --EN:--I want to get out of prison
VIRAIDEL_STATE_ANGRY	=	16371;--敵対 --EN:--hostile
VIRAIDEL_STATE_DEAD		=	16372;--死亡 --EN:--death
VIRAIDEL_STATE_SEARCH	=	16373;--妻を捜したい --EN:--I want to find a wife

viraidel_flag_list = {
	VIRAIDEL_STATE_HELP		,
	VIRAIDEL_STATE_ANGRY	,
	VIRAIDEL_STATE_DEAD		,
	VIRAIDEL_STATE_SEARCH
};

--ヴィライデルの待機ループアニメ --EN:--Villaidel's waiting loop animation
viraidel_wait_loopanime = 8621;

--元貴族婦人の待機ループアニメ --EN:-- Waiting loop animation of a former aristocratic lady
noble_woman_loopanime 	= 7001;

--■扉で使うダミポリ用のID --EN:--■Damipoli ID for doors

DOOR_DMY_ID_A = 191;
DOOR_DMY_ID_B = 192;

--■獄吏の死亡で鍵を入手できる。獄吏のIDを鍵取得用のフラグとして代用する。 --EN:--■ You can get the key when the jailer dies. Substitute the jailer's ID as a flag for key retrieval.

KEY_ID_4F 	    = 400;
KEY_ID_2F 	    = 402;
KEY_ID_1F 	    = 403;
KEY_ID_3F 	    = 407;
KEY_ID_INNER_2F = 405;

--■槍虜囚待ち時間 --EN:-- Spear Prisoner Waiting Time
SpearRyosyuA_wait = 2.0;
SpearRyosyuB_wait = 2.7;

--■徘徊デーモンのID --EN:--■ Loitering daemon ID

demon_id_list_m04_00_00_00 = { 833 };

--人形ギミックリロード時間 --EN:--Doll gimmick reload time
REROAD_TIME		= 3.5;

--牢獄の鍵(?Fの鍵ではなく、?Fの牢屋の鍵です) --EN:--prison key (not ?F key, but ?F jail key)
ITEMID_ROUGOKU_KEY_1	= 39;
ITEMID_ROUGOKU_KEY_2	= 40;
ITEMID_ROUGOKU_KEY_3	= 41;
ITEMID_ROUGOKU_KEY_4	= 42;
ITEMID_ROUGOKU_KEY_2_B	= 43;
ITEMID_ROGARN_KEY		= 44;

HELPID_ROUGOKU_KEY_1	= 10010839;
HELPID_ROUGOKU_KEY_2	= 10010840;
HELPID_ROUGOKU_KEY_3	= 10010841;
HELPID_ROUGOKU_KEY_4	= 10010842;
HELPID_ROUGOKU_KEY_2_B	= 10010843;
HELPID_ROGARN_KEY		= 10010844;

HELPID_ROUGOKU_GETKEY_1		= 10010155;
HELPID_ROUGOKU_GETKEY_2		= 10010155;
HELPID_ROUGOKU_GETKEY_3		= 10010155;
HELPID_ROUGOKU_GETKEY_4		= 10010155;
HELPID_ROUGOKU_GETKEY_2_B	= 10010156;
HELPID_ROGARN_GETKEY		= 10010157;

OPERA_184 = false;
--------------------------------------------------------------------------------------
--マップ読み込み時に読まれる初期化処理■ --EN:--Initialization process read when reading the map ■
--------------------------------------------------------------------------------------
function Initialize_m04_00_00_00(proxy)
	print("Initialize_m04_00_00_00 begin");
	
	proxy:LuaCall( 99999 , 0 , "OnEvent_4000_Hp_1",everytime);
	
--同期削除、同期フラグセットを使用するので、登録 --EN:-- Synchronous delete, use synchronous flag set, so register
	proxy:LuaCall( 4057,   1, "SynchroDeleteEvent_4057", everytime );
	proxy:LuaCall( 4057,   2, "SynchroSetEventFlag_4057", everytime );
	proxy:LuaCall( 4057, 100, "RyosyuMove_call", everytime );
	proxy:CustomLuaCall( 1, "TakoMove_call", everytime );
	
--■360■徘徊デーモンの登場■ハンドラ登録 --EN:-- ■ 360 ■ Appearance of wandering daemon ■ Handler registration
	proxy:NotNetMessage_begin();
		--プレイヤーがソロで死亡した時にキックされます。 --EN:--Kicked when a player dies solo.
		proxy:LuaCall( 4000, 100, "PlayerDeath_m04_00_00_00", everytime );
		--プレイヤーが復活した時にキックされます。 --EN:--Kicked when the player is revived.
		proxy:LuaCall( 4032, 100, "PlayerRevive_m04_00_00_00", everytime );
	proxy:NotNetMessage_end();

--■1■牢獄扉1■(スタート地点の扉 最初から開いている) --EN:-- ■ 1 ■ Prison door 1 ■ (The door at the starting point is open from the beginning)
	local open_door_eventId_list = {1001, 1023, 1089, 1081, 1083};
	local open_door_num = table.getn( open_door_eventId_list );
	for index = 1, open_door_num, 1 do
		proxy:EndAnimation( open_door_eventId_list[index] , 1 );
	end

--■2-70■牢獄扉2-70■ --EN:-- 2-70 Prison door 2-70
	local door_eventId_list = {1002, 1003, 1004, 1005, 1006, 1007, 1008, 1009, 1010, 1011, 1012, 1013, 1014, 1015, 1016, 1017, 1021, 1022, 1023, 1024, 1025, 1026, 1027, 1028, 1031, 1032, 1033, 1034, 1035, 1036, 1037, 1038, 1039, 1040, 1041, 1042, 1043, 1044, 1045, 1046, 1047, 1048, 1049, 1050, 1051, 1052, 1053, 1054, 1061, 1062, 1063, 1064, 1065, 1066, 1067, 1068, 1069, 1070, 1071, 1018, 1019, 1020, 1029, 1072, 1073, 1074, 1075, 1076, 1077};
	local door_actId_list   = {   2,    3,    4,    5,    6,    7,    8,    9,   10,   11,   12,   13,   14,   15,   16,   17,   18,   19,   -1,   21,   -1,   23,   24,   25,   26,   27,   28,   29,   30,   31,   32,   33,   34,   35,   36,   37,   38,   39,   40,   41,   42,   43,   44,   45,   46,   47,   48,   49,   50,   51,   52,   53,   54,   55,   56,   57,   58,   59,   -1,   61,   62,   63,   64,   65,   66,   67,   68,   69,   70};
	local door_type			= {   0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,    0,    0,    0,    0,    1,    1,    1,    1,    1,    1};
	local door_num = table.getn(door_actId_list);
	--ドアイベントの数だけループ --EN:--Loop for the number of door events
	for index = 1, door_num, 1 do
		print("add door id " .. door_eventId_list[index] );
		--有効なアクションIDかチェック --EN:-- check for valid action id
		if	door_actId_list[index] ~= -1 then
			--未成立のイベントか？ --EN:--Is it an unestablished event?
			if	proxy:IsCompleteEvent(door_actId_list[index]) == false then
				--開ける為のダイアログは配信しない --EN:--Do not deliver the dialog to open
				proxy:NotNetMessage_begin();
					--監獄扉(大)--2～4階の扉か？ --EN:--Prison Door (Large)--Is it a door on the 2nd to 4th floors?
					if	door_type[index] == 0 then
						proxy:OnDistanceAction( door_actId_list[index], LOCAL_PLAYER, door_eventId_list[index], "OnEvent_"..door_actId_list[index], DoorDist_A, HELPID_OPEN, 0, DoorAngle_A, everytime );
					--監獄扉(小)--１階の扉か？ --EN:--Prison door (small)--Is it the door on the first floor?
					elseif	door_type[index] == 1 then
						proxy:OnDistanceActionPlus( door_actId_list[index], LOCAL_PLAYER, door_eventId_list[index], "OnEvent_"..door_actId_list[index], DoorDist_A, HELPID_OPEN, 180, DoorAngle_A, 0.5, -1.0, 0.0, everytime );
					end
				proxy:NotNetMessage_end();
			--成立していた --EN:--was established
			else
				--アニメを再生して終了状態(開いている)にする --EN:--Play the animation and set it to the end state (open)
				proxy:EndAnimation(door_eventId_list[index], 1);
			end
		end
	end
	

--■200■鍵付き牢獄扉3F A■ --EN:--■200■Locked prison door 3F A■
	if proxy:IsCompleteEvent( 200 ) == false then
		
		proxy:NotNetMessage_begin();
			proxy:OnDistanceAction( 200, LOCAL_PLAYER, 1080, "OnEvent_200", DoorDist_A, HELPID_OPEN, -90, DoorAngle_A, everytime ); 
		proxy:NotNetMessage_end();
		
		proxy:LuaCall( 200, 2, "OnEvent_200_2", once );--アニメーション同期用	 --EN:--For animation synchronization
	else
		proxy:EndAnimation( 1080, 1 );
	end
--■201■鍵付き牢獄扉4F A■ --EN:--■201■Locked prison door 4F A■
	if proxy:IsCompleteEvent( 201 ) == false then
		proxy:OnDistanceAction( 201, LOCAL_PLAYER, 1082, "OnEvent_201", DoorDist_A, HELPID_OPEN, -90, DoorAngle_A, once );
	else
		proxy:EndAnimation( 1082, 1 );
	end
--■202■鍵付き牢獄扉4F B■ --EN:--■202■Locked prison door 4F B■
	if proxy:IsCompleteEvent( 202 ) == false then
		
		proxy:NotNetMessage_begin();
			proxy:OnDistanceActionPlus( 202, LOCAL_PLAYER, 1087, "OnEvent_202", DoorDist_A, HELPID_OPEN, 90, DoorAngle_A, 0.0, 0.0, 0.0 ,everytime );
		proxy:NotNetMessage_end();
		
		proxy:LuaCall( 202, 2, "OnEvent_202_2", once );--アニメーション同期用	 --EN:--For animation synchronization
	else
		proxy:EndAnimation( 1087, 1 );
	end
	
--■203■鍵付き牢獄扉4F■ --EN:--■203■Locked prison door 4F■
	if proxy:IsCompleteEvent( 203 ) == false then
		
		proxy:OnDistanceActionPlus( 203, LOCAL_PLAYER, 1088, "OnEvent_203", DoorDist_A, HELPID_OPEN, 90, DoorAngle_A, 0.0, 0.0, 0.0 ,everytime );
	else
		proxy:EndAnimation( 1088, 1 );
	end

--■210■鍵付き牢獄扉4F B■ --EN:--■210■Locked prison door 4F B■
--[[
	if proxy:IsCompleteEvent( 210 ) == false then
		proxy:OnDistanceAction( 210, LOCAL_PLAYER, 1081, "OnEvent_210", DoorDist_A, HELPID_OPEN, -90, DoorAngle_A, once );
	else
		proxy:EndAnimation( 1081, 1 );
	end

--▼鍵付き扉2F  --EN:--▼Key door 2F

--■220■鍵付き牢獄扉2F A■ --EN:--■220■Locked prison door 2F A■
	if proxy:IsCompleteEvent( 220 ) == false then
		proxy:OnDistanceAction( 220, LOCAL_PLAYER, 1083, "OnEvent_220", DoorDist_A, HELPID_OPEN, -90, DoorAngle_A, once );
	else
		proxy:EndAnimation( 1083, 1 );
	end
]]

--■230■鍵付き牢獄扉2F B■ --EN:--■230■Locked prison door 2F B■
	if proxy:IsCompleteEvent( 230 ) == false then
		proxy:NotNetMessage_begin();
			proxy:OnDistanceAction( 230, LOCAL_PLAYER, 1084, "OnEvent_230", DoorDist_A, HELPID_OPEN, -90, DoorAngle_A, everytime );
		proxy:NotNetMessage_end();
		proxy:LuaCall( 230, 1, "OnEvent_230_1", once );
	else
		proxy:EndAnimation( 1084, 1 );
	end

--▼鍵付き扉1F --EN:--▼Key door 1F
 
--■240■鍵付き牢獄扉1F A■ --EN:--■240■Locked prison door 1F A■
	if proxy:IsCompleteEvent( 240 ) == false then
		
		proxy:NotNetMessage_begin();
			proxy:OnDistanceAction( 240, LOCAL_PLAYER, 1085, "OnEvent_240", DoorDist_A, HELPID_OPEN, -90, DoorAngle_A, everytime );
		proxy:NotNetMessage_end();
		
		proxy:LuaCall( 240, 2, "OnEvent_240_2", once );--アニメーション同期用 --EN:--For animation synchronization
	else
		proxy:EndAnimation( 1085, 1 );
	end

--■250■鍵付き牢獄扉1F B■ --EN:--■250■Locked prison door 1F B■
	if proxy:IsCompleteEvent( 250 ) == false then
		
		proxy:NotNetMessage_begin();
			proxy:OnDistanceAction( 250, LOCAL_PLAYER, 1086, "OnEvent_250", DoorDist_A, HELPID_OPEN, -90, DoorAngle_A, everytime );
		proxy:NotNetMessage_end();
		
		proxy:LuaCall( 250, 2, "OnEvent_250_2", once );--アニメーション同期用 --EN:--For animation synchronization
	else
		proxy:EndAnimation( 1086, 1 );
	end

--▼鍵付き扉3F --EN:--▼Key door 3F
 

--▼鍵付き扉中2F --EN:--▼2F

--■270■鍵付き牢獄扉中2F A■ --EN:--■270■Locked prison door 2F A■
	if proxy:IsCompleteEvent( 270 ) == false then
		
		proxy:NotNetMessage_begin();
			proxy:OnDistanceAction( 270, LOCAL_PLAYER, 1091, "OnEvent_270", DoorDist_A, HELPID_OPEN, -90, DoorAngle_A, everytime );
		proxy:NotNetMessage_end();
		
		proxy:LuaCall( 270, 2, "OnEvent_270_2", once );--アニメーション同期用 --EN:--For animation synchronization
	else
		proxy:EndAnimation( 1091, 1 );
	end
--■271■鍵付き牢獄扉中2F A■ --EN:--■271■ Locked prison door 2F A■
	if proxy:IsCompleteEvent( 271 ) == false then
		
		proxy:NotNetMessage_begin();
			proxy:OnDistanceAction( 271, LOCAL_PLAYER, 1091, "OnEvent_271", DoorDist_A, HELPID_OPEN,  90, DoorAngle_A, everytime );
		proxy:NotNetMessage_end();
		
		proxy:LuaCall( 271, 2, "OnEvent_271_2", once );--アニメーション同期用 --EN:--For animation synchronization
	else
		proxy:EndAnimation( 1091, 1 );
	end

--■280■鍵付き牢獄扉中2F B■ --EN:--■280■Locked prison door 2F B■
	if proxy:IsCompleteEvent( 280 ) == false then
		
		proxy:NotNetMessage_begin();
			proxy:OnDistanceAction( 280, LOCAL_PLAYER, 1092, "OnEvent_280", DoorDist_A, HELPID_OPEN, -90, DoorAngle_A, everytime );
		proxy:NotNetMessage_end();
		
		proxy:LuaCall( 280, 2, "OnEvent_280_2", once );--アニメーション同期用		 --EN:--For animation synchronization
	else
		proxy:EndAnimation( 1092, 1 );
	end
	
--■281■鍵付き牢獄扉中2F B■ --EN:--■281■Locked prison door 2F B■
	if proxy:IsCompleteEvent( 281 ) == false then
		
		proxy:NotNetMessage_begin();
			proxy:OnDistanceAction( 281, LOCAL_PLAYER, 1092, "OnEvent_281", DoorDist_A, HELPID_OPEN,  90, DoorAngle_A, everytime );
		proxy:NotNetMessage_end();
		
		proxy:LuaCall( 281, 2, "OnEvent_281_2", once );--アニメーション同期用		 --EN:--For animation synchronization
	else
		proxy:EndAnimation( 1092, 1 );
	end
--■290■鍵付き牢獄扉中2F C■ --EN:--■ 290 ■ Locked prison door 2F C ■
	if proxy:IsCompleteEvent( 290 ) == false then
		proxy:OnDistanceAction( 290, LOCAL_PLAYER, 1093, "OnEvent_290", DoorDist_A, HELPID_OPEN, -90, DoorAngle_A, once );
	else
		proxy:EndAnimation( 1093, 1 );
	end

--■300■鍵付き牢獄扉中2F D■ --EN:--■300■Locked prison door 2F D■
	if proxy:IsCompleteEvent( 300 ) == false then
		proxy:OnDistanceAction( 300, LOCAL_PLAYER, 1094, "OnEvent_300", DoorDist_A, HELPID_OPEN, -90, DoorAngle_A, once );
	else
		proxy:EndAnimation( 1094, 1 );
	end



--■310■監獄扉(中2F)■ --EN:-- ■ 310 ■ Prison Door (Middle 2F) ■
	if proxy:IsCompleteEvent( 310 ) == false then
		proxy:NotNetMessage_begin();
			proxy:OnDistanceAction( 310, LOCAL_PLAYER, 1090, "OnEvent_310", DoorDist_A, HELPID_OPEN, -90, DoorAngle_A, once );
		proxy:NotNetMessage_end();
	else
		proxy:EndAnimation( 1090, 1 );
	end

--■315■教会上部扉A■ --EN:--■315■Church Upper Door A■
	if proxy:IsCompleteEvent( 315 ) == false then
		proxy:NotNetMessage_begin();
			proxy:OnDistanceActionPlus( 315, LOCAL_PLAYER, 1096, "OnEvent_315", DoorDist_A, HELPID_OPEN, 90, DoorAngle_A, 0.0, 0.0, -1.0, once );
		proxy:NotNetMessage_end();
	else
		proxy:EndAnimation( 1096, 1 );
	end

--■320■教会上部扉B■ --EN:--■320■Church top door B■
	if proxy:IsCompleteEvent( 320 ) == false then
		proxy:NotNetMessage_begin();
			proxy:OnDistanceActionPlus( 320, LOCAL_PLAYER, 1097, "OnEvent_320", DoorDist_A, HELPID_OPEN, 90, DoorAngle_A, 0.0, 0.0, 1.0, once );
		proxy:NotNetMessage_end();
	else
		proxy:EndAnimation( 1097, 1 );
	end
	
	
--■326■牢獄の鍵3F■ --EN:--■ 326 ■ Prison Key 3F ■
	if	proxy:IsCompleteEvent( 326 ) == false then
		proxy:TreasureDispModeChange2( 1110, true ,KAGI_SFX);
		--proxy:SetRarity( 1110, 10502 );
		proxy:OnDistanceActionPlusAttribute( 326, LOCAL_PLAYER, 1110, "OnEvent_326", 1.0, 10010155, 0, 180, 0.0, -0.85, 0.0, ATTR_LIVE + ATTR_GREY, once );
	else
		proxy:SetColiEnable( 1110, false );
		proxy:SetDrawEnable( 1110, false );
	end
--■327■牢獄の鍵4F■ --EN:-- 327 Prison Key 4F
	if	proxy:IsCompleteEvent( 327 ) == false then
		proxy:TreasureDispModeChange2( 1111, true ,KAGI_SFX);
		--proxy:SetRarity( 1111, 10502 );
		proxy:OnDistanceActionPlusAttribute( 327, LOCAL_PLAYER, 1111, "OnEvent_327", 1.0, 10010155, 0, 180, 0.0, -0.85, 0.0, ATTR_LIVE + ATTR_GREY, once );
	else
		proxy:SetColiEnable( 1111, false );
		proxy:SetDrawEnable( 1111, false );
	end
--■328■牢獄の鍵1F■ --EN:-- 328 Prison Key 1F
	if	proxy:IsCompleteEvent( 328 ) == false then
		proxy:TreasureDispModeChange2( 1112, true ,KAGI_SFX);
		--proxy:SetRarity( 1112, 10502 );
		proxy:OnDistanceActionPlusAttribute( 328, LOCAL_PLAYER, 1112, "OnEvent_328", 1.0, 10010155, 0, 180, 0.0, -0.85, 0.0, ATTR_LIVE + ATTR_GREY, once );
	else
		proxy:SetColiEnable( 1112, false );
		proxy:SetDrawEnable( 1112, false );
	end
--■329■牢獄の鍵3F■ --EN:--■ 329 ■ Prison Key 3F ■
	if	proxy:IsCompleteEvent( 329 ) == false then
		proxy:TreasureDispModeChange2( 1113, true ,KAGI_SFX);
		--proxy:SetRarity( 1113, 10555 );
		proxy:OnDistanceActionPlusAttribute( 329, LOCAL_PLAYER, 1113, "OnEvent_329", 1.0, HELPID_ROUGOKU_GETKEY_3, 0, 180, 0.0, -0.85, 0.0, ATTR_LIVE + ATTR_GREY, once );
	else
		proxy:SetColiEnable( 1113, false );
		proxy:SetDrawEnable( 1113, false );
	end

--■331■ロガーンの鍵■ --EN:--■331■Logan's Key■
	if	proxy:IsCompleteEvent( 331 ) == false then
		proxy:TreasureDispModeChange2( 1114, true ,KAGI_SFX);
		--proxy:SetRarity( 1114, 10594 );
		proxy:OnDistanceActionPlusAttribute( 331, LOCAL_PLAYER, 1114, "OnEvent_331", 1.0, HELPID_ROGARN_GETKEY, 0, 180, 0.0, -0.85, 0.0, ATTR_LIVE + ATTR_GREY, once );
	else
		proxy:SetColiEnable( 1114, false );
		proxy:SetDrawEnable( 1114, false );
	end
	

--■332,333■槍虜囚イベント■	 --EN:-- ■ 332,333 ■ Spear prisoner event ■
	if	proxy:IsCompleteEvent(333) == false then
		proxy:OnRegionJustIn( 332, LOCAL_PLAYER, 2015, "OnEvent_332", once );
		proxy:OnNetRegion( 334, 2015 );
		proxy:OnRegionJustIn( 333, LOCAL_PLAYER, 2016, "OnEvent_333", once );
		proxy:LuaCall( 333, 1, "OnEvent_333_AnimA", once );
		proxy:LuaCall( 333, 2, "OnEvent_333_AnimB", once );
	end

	
	

--獄吏からの鍵入手はイベントで処理しないかもしれない --EN:--Getting keys from prison guards may not be handled by events
--[[
--■325■獄吏の死亡監視1 4F■ --EN:--■325■Prisoner's death watch 1 4F■
	proxy:OnCharacterDead( 325, 400, "OnEvent_325", once );

--■330■獄吏の死亡監視2 2F■ --EN:--■330■Prisoner's Death Watch 2 2F■
	proxy:OnCharacterDead( 330, 402, "OnEvent_330", once );

--■335■獄吏の死亡監視3 1F■ --EN:--■ 335 ■ Jailer's death watch 3 1F ■
	proxy:OnCharacterDead( 335, 403, "OnEvent_335", once );

--■340■獄吏の死亡監視4 3F■ --EN:--■340■Prisoner's death watch 4 3F■
	proxy:OnCharacterDead( 340, 407, "OnEvent_340", once );

--■345■獄吏の死亡監視5 中2F■ --EN:--■ 345 ■ Prisoner's Death Watch 5 Middle 2F ■
	proxy:OnCharacterDead( 345, 405, "OnEvent_345", once );
]]	

	--ちょっとわけわかんなくなったので、新規	 --EN:--This is getting a little confusing, so new
	--領域入っている間 --EN:-- while entering the region
	proxy:RepeatMessage_begin();
		proxy:OnRegionIn(350,LOCAL_PLAYER,2000,"OnEvent_350",once);
	proxy:RepeatMessage_end();	
	--リロード配信用 --EN:--For reload distribution
	proxy:LuaCall(351,1,"OnEvent_350_flag",everytime);
	if proxy:IsCompleteEvent( 352 ) == false then
		proxy:OnDistanceActionPlus( 352, LOCAL_PLAYER, 1100, "OnEvent_352", LeverDist_A, HELPID_PULL_LEVER, 0, LeverAngle_A, 0.0, 0.0, 2.0, once );	
	end
	
	SingleReset(proxy,351);

--■352■人形ギミック■(後ろのレバーを操作で動かなくなる) --EN:-- ■ 352 ■ Doll gimmick ■ (It will not move by operating the back lever)
--[[無くなるらしい --EN:--[[Appears to be gone
	]]


--■354■教会扉ポリ劇再生■ --EN:-- ■ 354 ■ church door poly play ■
	if proxy:IsCompleteEvent( 354 ) == false then
		
		proxy:EndAnimation( 1095 , 0 );--扉閉まる。 --EN:--The door closes.
	
		proxy:OnRegionJustIn( 354 , LOCAL_PLAYER , 2003 , "OnEvent_354" , once );
		
		proxy:NotNetMessage_begin();
			--ポリ劇開始フェード後に呼ばれるハンドラ --EN:--Handler called after polyplay start fade
			proxy:LuaCall(354,REMO_START,"OnEvent_354_RemoStart",once);
			--ポリ劇終了後に呼ばれるハンドラ --EN:--Handler called after the polyplay ends
			proxy:LuaCall(354,REMO_FINISH,"OnEvent_354_RemoFinish",once);
		proxy:NotNetMessage_end();
	else
		proxy:EndAnimation( 1095 , 1 );--扉開く --EN:--door open
	end

-- 魔法壁、領域などが未配置なので コメントアウト --EN:-- commented out because magic wall, area, etc. are not placed
	
--■380■ボス部屋に入る■ --EN:-- ■ 380 ■ Enter the boss room ■
	--中ボスが生きているときだけイベント登録 --EN:-- Event registration only when the mid-boss is alive
	proxy:AddFieldInsFilter( 806 );
	if proxy:IsCompleteEvent( 5123 ) == false then
		proxy:RepeatMessage_begin();
	
		--ソロのときは一度目にボス部屋に入る用のイベントを毎回登録させたいので、対応するフラグをOFFにする。 --EN:-- When soloing, we want to register the event for entering the boss room for the first time every time, so turn off the corresponding flag.
		SingleReset(proxy, 380);
		--▽同期アニメ再生用の開始ハンドラ(旋回→歩き) --EN:--▽ Start handler for synchronous animation playback (turning → walking)
		proxy:LuaCall( 381, 1, "OnEvent_381_1", everytime );
		--▽2回目以降にボス部屋に入るためのイベント配信用 --EN:--▽For event delivery to enter the boss room after the second time
		proxy:LuaCall( 381 , 5 , "OnEvent_380_GO_TO_IN" , everytime );
		--▽フラグセット(同期用) --EN:--▽flag set (for synchronization)
		proxy:LuaCall( 381 , 6 , "OnEvent_380_flag_set" , everytime );
		
		--誰かがボス前扉をまだ通過していない --EN:--Someone hasn't passed through the boss front door yet
		if proxy:IsCompleteEvent( 380 ) == false then
		
			--(セッション中に)ボス前の魔法壁を最初に通れるのは生存の人だけ --EN:--(During the session) Only survivors can pass through the magic wall in front of the boss first
			local possible_chr_type = ATTR_HOST + ATTR_LIVE + ATTR_GREY;
			
			proxy:NotNetMessage_begin();
				--▼380▼中に入るためのイベントを追加▼ --EN:--▼380▼Add an event to enter▼
				proxy:OnPlayerActionInRegionAttribute( 380, 2895, "OnEvent_380", HELPID_GO_TO_IN, possible_chr_type, everytime );
			proxy:NotNetMessage_end();
			
		else --グレイゴーストできたときようにいると思われる。 --EN:--Gray ghost seems to be like that when it's done.
		
			proxy:NotNetMessage_begin();
				--▼381▼中に入るためのイベントを追加▼--ハンドラは上と同じ --EN:--▼381▼Add an event to enter inside▼--The handler is the same as above
				proxy:OnPlayerActionInRegion( 381, 2895, "OnEvent_380", HELPID_GO_TO_IN, everytime );
			proxy:NotNetMessage_end();
		end
		proxy:RepeatMessage_end();
	end
	
	
--■384■ボス部屋を出る■ --EN:-- ■ 384 ■ Exit the boss room ■
	proxy:NotNetMessage_begin();
		--▼381▼中に入るためのイベントを追加▼--ハンドラは上と同じ --EN:--▼381▼Add an event to enter inside▼--The handler is the same as above
		--proxy:OnPlayerActionInRegion( 381, 2895, "OnEvent_384", HELPID_GO_TO_IN, everytime );
	proxy:NotNetMessage_end();



--■382■中ボスポリ劇■ --EN:-- ■ 382 ■ Middle Bospoli Drama ■
	if proxy:IsCompleteEvent( 5123 ) == false then
		SingleReset( proxy, 382 );
	end
	if proxy:IsCompleteEvent( 382 ) == false then
		proxy:OnRegionJustIn( 382, LOCAL_PLAYER, 2899, "OnEvent_382", once );
		--ポリ劇開始フェード後に呼ばれるハンドラ --EN:--Handler called after polyplay start fade
		proxy:LuaCall(382,REMO_START,"OnEvent_382_RemoStart",once);
		--ポリ劇終了後に呼ばれるハンドラ --EN:--Handler called after the polyplay ends
		proxy:LuaCall(382,REMO_FINISH,"OnEvent_382_RemoFinish",once);
		
		InvalidCharactor( proxy , 806 );
	else
		--ポリ劇を見ている＆牢城１未クリアの場合、カミサマを更新 --EN:--If you are watching a police play & haven't cleared Prison 1, update Kami-sama
		if	proxy:IsCompleteEvent( 5123 ) == false then
			--ポリ劇開始したら死亡するまで強制更新させる --EN:-- Forced update until death when police play starts
			proxy:ForceSetOmissionLevel( 806, true, 0 );
			
			--常時読み込まれる設定に --EN:--For settings that are always loaded
			proxy:SetAlwayEnableBackread_forEvent( 806, true );
		end
	end


--■383■ボス戦闘開始■ --EN:-- ■ 383 ■ Boss battle begins ■
--[[
	if proxy:IsCompleteEvent( 5123 ) == false then
		proxy:RepeatMessage_begin();
			proxy:OnRegionJustIn( 383 , LOCAL_PLAYER , 2887 , "OnEvent_383" , once );
		proxy:RepeatMessage_end();
	end
]]

	
	--■420■光の壁■ --EN:-- ■ 420 ■ wall of light ■
	if proxy:IsCompleteEvent( 420 ) == false then
		proxy:OnDistanceActionAttribute( 420, LOCAL_PLAYER, 1131, "OnEvent_420", 1.5, 10010403, 180.0, 90.0, ATTR_HOST + ATTR_LIVE + ATTR_GREY, once );
		proxy:LuaCall( 420, 2, "OnEvent_420_delete", once );
	else
		proxy:SetDrawEnable( 1131, false );--描画OFF --EN:--Drawing OFF
		proxy:SetColiEnable( 1131, false );--当たりOFF --EN:--Hit OFF
		proxy:InvalidSfx( 2021, false );
	end
	
	--■421■光の壁■ --EN:-- ■ 421 ■ Wall of Light ■
	if proxy:IsCompleteEvent( 421 ) == false then
		proxy:OnDistanceActionAttribute( 421, LOCAL_PLAYER, 1132, "OnEvent_421", 1.5, 10010403, 180.0, 90.0, ATTR_HOST + ATTR_LIVE + ATTR_GREY, once );
		proxy:LuaCall( 421, 2, "OnEvent_421_delete", once );
	else
		proxy:SetDrawEnable( 1132, false );--描画OFF --EN:--Drawing OFF
		proxy:SetColiEnable( 1132, false );--当たりOFF --EN:--Hit OFF
		proxy:InvalidSfx( 2022, false );
	end
	
	--■422■光の壁■ --EN:-- ■ 422 ■ Wall of Light ■
	if proxy:IsCompleteEvent( 422 ) == false then
		proxy:OnDistanceActionAttribute( 422, LOCAL_PLAYER, 1133, "OnEvent_422", 1.5, 10010403, 180.0, 90.0, ATTR_HOST + ATTR_LIVE + ATTR_GREY, once );
		proxy:LuaCall( 422, 2, "OnEvent_422_delete", once );
	else
		proxy:SetDrawEnable( 1133, false );--描画OFF --EN:--Drawing OFF
		proxy:SetColiEnable( 1133, false );--当たりOFF --EN:--Hit OFF
		proxy:InvalidSfx( 2023, false );
	end
	
	if proxy:IsCompleteEvent( 423 ) == false then
		proxy:OnRegionJustIn( 423, LOCAL_PLAYER, 2004, "OnEvent_423", once );
	end
	
	

	
	
--■5123■中ボス死亡で扉が開く■ --EN:-- ■ 5123 ■ The door opens when the mid-boss dies ■
	if proxy:IsCompleteEvent( 5123 ) == false then
		--死亡監視はかみさま使いが生きている限り何度でも追加するのでRepeat --EN:--Death monitoring will be added as many times as long as the Goddess Tamer is alive, so Repeat
		--Repeatなので終了済みイベントにならない為、配信にするとAssartがでる為、非配信 --EN:--Since it is a Repeat, it will not be a finished event, so if you set it to delivery, Assart will appear, so it will not be delivered
		--eventbossの方に死亡監視登録用にLuaCallを用意しているので、こっちでは登録しない --EN:--Eventboss prepares LuaCall for death watch registration, so don't register here
		--proxy:LuaCall( 2047, 3, "SynchroDeadCondition", everytime );
		--ボス部屋に入るタイミングで死亡監視を追加する。 --EN:--Add death watch when entering the boss room.
		--(追加するタイミングによってすぐに死亡の判定になってしまう問題を避ける為) --EN:--(To avoid the problem that it becomes a death judgment immediately depending on the timing of adding)
--[[
		proxy:NotNetMessage_begin();
		proxy:RepeatMessage_begin();
			proxy:OnCharacterDead( 5123 , 806 , "OnEvent_5123" , once );
		proxy:RepeatMessage_end();
		proxy:NotNetMessage_end();
]]
		--ホストが全員にボス死亡を配信する --EN:--Host delivers boss deaths to everyone
		proxy:LuaCall( 5123, 2, "OnEvent_5123_call", everytime );
	end


--■410■次ブロックへ移動するポリ劇■ --EN:-- ■ 410 ■ Police play to move to the next block ■
	
	SingleReset( proxy , 410 );	
	if proxy:IsCompleteEvent( 410 ) == false then
		if proxy:IsCompleteEvent( 5123 ) == true then
			proxy:NotNetMessage_begin();
				--次ブロックへ移動するポリ劇 --EN:-- Poly play to move to the next block
				proxy:OnRegionIn( 410, LOCAL_PLAYER, 2030, "OnEvent_410", everytime );
			proxy:NotNetMessage_end();
		end
		--ポリ劇開始フェード後に呼ばれるハンドラ --EN:--Handler called after polyplay start fade
		proxy:LuaCall(410,REMO_START,"OnEvent_410_RemoStart",once);
		--ポリ劇終了後に呼ばれるハンドラ --EN:--Handler called after the polyplay ends
		proxy:LuaCall(410,REMO_FINISH,"OnEvent_410_RemoFinish",once);
	end
	
	
--■390■神様使いの死亡■ --EN:-- ■ 390 ■ God messenger's death ■
	--if proxy:IsCompleteEvent( 5123 ) == false then
		--proxy:AddFieldInsFilter(500);
		--SingleReset( proxy, 390 );
		if proxy:IsCompleteEvent( 390 ) == false then
			if proxy:IsClient() == false then
				proxy:RequestForceUpdateNetwork( 500);				
			end
			proxy:OnCharacterDead( 390, 500, "RevivalEnchanterDead_390", once );
			proxy:DisableCollection(806, true );--カミサマのソウル取得を無効化 --EN:--Disable Kami-sama's soul acquisition
			
			SingleReset(proxy, 395);--カミサマ死亡時に流れる会話のリセット --EN:--Reset the conversation that flows when Kamisama dies
		else
			InvalidCharactor( proxy , 500 );
			proxy:InvalidSfx( 2160, false );
		end
	--else
		--InvalidCharactor( proxy , 500 );
		--proxy:InvalidSfx( 2160, false );
	--end
	
	

	
--■430■石柱にワープ■ --EN:-- ■ 430 ■ Warp to the stone pillar ■
	SingleReset(proxy,430);
	proxy:TreasureDispModeChange2( 1983 , true ,KANAME_SFX);
	proxy:OnDistanceAction( 430, LOCAL_PLAYER, 1983, "OnEvent_430", WarpGimmickDist_A, HELPID_GO_TO_SEKITYUU, 0, 180, everytime );

	
--■431■最初の要石の光が消える■ --EN:--■431■The light on the first keystone disappears■
		proxy:OnSessionJustIn( 431 , "OnEvent_431" , everytime );
		
--■432■最初の要石の光が復活する■ --EN:-- ■ 432 ■ The light of the first keystone is restored ■
		proxy:OnSessionJustOut( 432 , "OnEvent_432" , everytime );

	
		
--大阪さんの描画グループ設定が入るまで、しばしの間コメントアウト --EN:--Comment out for a while until Mr. Osaka's drawing group setting is entered
--[[■190■QWC宝死体■ --EN:--[[ ■ 190 ■ QWC treasure corpse ■
	if proxy:IsClient() == false then
		if	proxy:GetLocalQWC(0) >=250 and proxy:GetLocalQWC(0) <=600 and
			proxy:GetLocalQWC(1) >=350 and proxy:GetLocalQWC(1) <=800 and
			proxy:GetLocalQWC(2) >=500 and proxy:GetLocalQWC(2) <=600 then
			proxy:SetEventFlag( 190, 1 );
		else--条件が成立してない時は無効にしたい --EN:--I want to disable when the condition is not met
			proxy:SetEventFlag( 190, 0 );
		end
	end
	
	if proxy:IsCompleteEvent(190) ==true then
		print("[成立]QWC宝死体"); --EN:print("[Established] QWC Treasure Corpse");
	else
		print("[未成立]QWC宝死体"); --EN:print("[unestablished] QWC Treasure Corpse");
		proxy:TreasureDispModeChange( 10244, false );
		proxy:SetDrawEnable( 10244, false );
		proxy:SetColiEnable( 10244, false );
	end
	]]
	

	--■ボス関連の初期化処理 --EN:--■ Boss-related initialization processing
	if proxy:IsCompleteEvent( 5123 ) ==true then
		
		--▽ボス死んでいるとき --EN:--▽When the boss is dead
		--ボスいなくなる --EN:--boss disappears
		InvalidBackRead( proxy , 806 );
		
		--魔法壁消える --EN:--Magic wall disappears
		proxy:SetColiEnable( 1995 , false );
		proxy:SetColiEnable( 1999 , false );
	
		proxy:SetDrawEnable( 1995 , false );
		proxy:SetDrawEnable( 1999 , false );

		--魔法壁の SFX OFF --EN:--Magic Wall SFX OFF
		proxy:InvalidSfx( 1987 , false );
		proxy:InvalidSfx( 1991 , false );

		--ホストプレイヤーのみアイテム入手イベントに使用 --EN:--Used for item acquisition event only for host players
		local possible_chr_type = ATTR_HOST + ATTR_LIVE + ATTR_GREY;

		--宝死体(ソウル?)有効化 --EN:--Treasure corpse (soul?) activation
		proxy:SetDrawEnable( 1982 , true );
		proxy:SetColiEnable( 1982 , true );
		--宝死体(ソウル?)2有効化 --EN:--Treasure corpse (soul?) 2 enabled
		proxy:SetDrawEnable( 1975 , true );
		proxy:SetColiEnable( 1975 , true );
		
		--▼(ソウル)アイテム取得用イベント監視追加▼ --EN:--▼ (Soul) Added event monitoring for item acquisition▼
		if proxy:IsCompleteEvent( 5121 ) == false then
			proxy:ValidSfx( 2111 );--SFX 有効化 --EN:--SFX enable
			proxy:ValidSfx( 2110 );--SFX 有効化 --EN:--SFX enable
			proxy:TreasureDispModeChange2( 1982 , true ,KANAME_SFX);--光らせる --EN:-- let it shine
			proxy:OnDistanceActionAttribute( 5121 , LOCAL_PLAYER , 1982 , "OnEvent_5121" , WarpGimmickDist_A , 10010180 , 0 , 180 , possible_chr_type, once );
		else
			--▼要石でワープ用の監視を追加▼ --EN:--▼ Added surveillance for warp with keystone ▼
			SingleReset(proxy,5122);
			--proxy:InvalidSfx( 2111 , false );--SFX無効化 --EN:--Disable SFX
			proxy:InvalidSfx( 2110 , false );--SFX無効化 --EN:--Disable SFX
			proxy:TreasureDispModeChange2( 1982 , true ,KANAME_SFX);--光らせる --EN:-- let it shine
			proxy:OnDistanceActionAttribute( 5122 , LOCAL_PLAYER , 1982 , "OnEvent_5122" , WarpGimmickDist_A , HELPID_GO_TO_SEKITYUU , 0 , 180 , ATTR_ALL , everytime );
		end
		
	else
		--▽ボス生きているとき --EN:--▽ When the boss is alive
		if proxy:IsClient() == false  then
			proxy:EnableLogic( 806 , false );--ロジックOFFで待機 --EN:--Wait with logic OFF
		end
		
		--宝(ソウル?) --EN:--Treasure (Soul?)
		proxy:SetDrawEnable( 1982 , false );
		proxy:SetColiEnable( 1982 , false );
		--宝(ソウル?)2 --EN:--Treasure (Soul?) 2
		proxy:SetDrawEnable( 1975 , false );
		proxy:SetColiEnable( 1975 , false );

		--SFX 無効化 --EN:--Disable SFX
		proxy:InvalidSfx( 2111 , false );--ソウル用 --EN:--For Seoul
		proxy:InvalidSfx( 2110 , false );--ボスアイテム用		 --EN:--For boss items
	end	
	
	
	
	--テスト用 --EN:--for test
	--読み込み時から鍵をすべて入手している 本来は対応する敵を倒すことで入手 --EN:--Obtain all keys from the time of loading Originally obtained by defeating the corresponding enemy
	proxy:SetEventFlag( KEY_ID_4F       , true );
	proxy:SetEventFlag( KEY_ID_3F       , true );
	proxy:SetEventFlag( KEY_ID_2F       , true );
	proxy:SetEventFlag( KEY_ID_1F       , true );
	proxy:SetEventFlag( KEY_ID_INNER_2F , true );


	--■徘徊デーモン用 --EN:-- ■ For prowling demons
	if proxy:IsCompleteEvent( 360 ) == true then
		LuaFunc_VisibleTheWanderingDemon  (proxy, param, demon_id_list_m04_00_00_00);
	else
		LuaFunc_InvisibleTheWanderingDemon(proxy, param, demon_id_list_m04_00_00_00);
	end	
	
	--■353■人形ポリ劇再生■ --EN:-- ■ 353 ■ puppet polyplay playback ■
	proxy:SetBallista( 1102, 410 );	--バリスタ情報を作る --EN:--Make barista information
	if proxy:IsCompleteEvent( 353 ) == false then
	
		proxy:OnRegionJustIn( 353, LOCAL_PLAYER, 2002, "OnEvent_353", once );		
		
		--ポリ劇開始フェード後に呼ばれるハンドラ --EN:--Handler called after polyplay start fade
		proxy:LuaCall(353,REMO_START,"OnEvent_353_RemoStart",once);
		--ポリ劇終了後に呼ばれるハンドラ --EN:--Handler called after the polyplay ends
		proxy:LuaCall(353,REMO_FINISH,"OnEvent_353_RemoFinish",once);
	else		
		if proxy:IsCompleteEvent( 352 ) == false then			
			--人形をスタンバイさせておく --EN:--Keep the doll on standby
			proxy:SetBallista( 1102, 410 );	
			proxy:PlayAnimation(1100,3);
			proxy:PlayAnimation(1101,1);
			proxy:PlayAnimation(1102,1);			
		else
			--人形ギミックのイベントを消す --EN:--Erase the doll gimmick event
			proxy:DeleteEvent( 350 );--領域に入ったとき --EN:--when entering the region
			proxy:DeleteEvent( 351 );--領域からでたとき --EN:--When exiting the area
			proxy:EndAnimation( 1100 , 4 );
			proxy:EndAnimation( 1101 , 2 );
			proxy:EndAnimation( 1102 , 2 );
		end	
	end


	--■354■教会扉ポリ劇再生■ --EN:-- ■ 354 ■ church door poly play ■
	if proxy:IsCompleteEvent( 354 ) == false then
		proxy:InvalidSfx( 1991 , false );--光の霧SFX OFF --EN:--Light Fog SFX OFF
	end
	
--虜囚初期化 --EN:--prisoner initialization
	--local Valid_list 	   = {  1,   1,   1,   1,   1,   1,   1,   1,   1,   1,   1,   1,   1,   1,   0,   1,   1,   0,   1,   0,   1};
	--local DoorSyuuzin_list = {100, 115, 108, 116, 102, 101, 103, 117, 118, 119, 104, 105, 107, 126, 109, 128, 130, 111, 129, 110, 112};
	--local DoorAction_list  = {  2,   2,   4,   7,  10,  11,  12,  18,  18,  18,  19,  19,  23,  23,  25,  25,  26,  28,  30,  31,  34};
	local Valid_list 	   = {  1,   1,   1,   1,   1,   1,   1,  0,   0,   0,   1,   1,   1,   1,   1,   1,   1,   1,   1,   1,   1,   1,   1,   1,   1,   1,   1,   1,   1,   1,   1,   1,   1,   1,   1,   1,   1};
	local DoorSyuuzin_list = {100, 101, 102, 103, 106, 104, 105,111, 109, 110, 112, 107, 108, 113, 114, 115, 116, 117, 118, 119, 120, 121, 122, 123, 125, 126, 127, 128, 130, 131, 132, 133, 136, 137, 138, 134, 135};
	local DoorAction_list  = {  2,   2,   3,   3,  10,  11,  11, 15,  16,  16,  17,  64,  64,  19,  19,  19,  19,  19,  19,  19,  19,  21,  21,  21,  25,  25,  25,  25,  29,  29,  33,  40,  45,  45,  45,  47,  47};	
	local IsLogicOff_list  = {  1,   1,   1,   1,   1,   1,   1,  1,   1,   1,   1,   1,   1,   1,   1,   1,   1,   1,   1,   1,   1,   1,   1,   1,   1,   1,   1,   1,   1,   1,   1,   1,   1,   1,   1,   1,   1};
	local syuuzin_num = table.getn( DoorSyuuzin_list );
	for count = 1, syuuzin_num, 1 do
		--イベント自体が無効設定になっていないか？(部分的に使わなくなったキャラなどの設定) --EN:--Is the event itself disabled? (Settings such as characters that are partially no longer used)
		if	Valid_list[count] == 1 then
			if proxy:IsCompleteEvent( DoorAction_list[count] ) == false then
				if	IsLogicOff_list[count] == 1 then
					proxy:EnableLogic( DoorSyuuzin_list[count], false );
				end
			else
				proxy:SetSpStayAndDamageAnimId( DoorSyuuzin_list[count],-1,-1);
			end
		end
	end

	--[[
	--■470～484■虜囚イベントの死亡監視 --EN:-- ■ 470-484 ■ Death Watch for Prisoner Events
	local tako_id_list		= { 			151,             153,             154,             160,             161,              -1};
	local tako_type_list 	= {   			  1,               2,               3,               4,               5,               6};
	local tako_func_list	= {	"DeadCheckSeqA", "DeadCheckSeqB", "DeadCheckSeqC", "DeadCheckSeqD", "DeadCheckSeqE", "DeadCheckSeqF"};
	local ryosyu_evid_list	= { 100, 101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111, 112, 113, 114, 115, 116, 117, 118, 119, 120, 121, 122, 123, 124, 125, 126, 127, 128, 129, 130, 131, 132, 133, 134, 135, 136, 137, 138};
	local ryosyu_acid_list	= { 470, 470, 471, 471, 472, 472, 473, 474, 474, 475, 475, 476, 477, 478, 478, 478, 478, 478, 478, 478, 478, 479, 479, 479, 479, 480, 480, 480, 480, 481, 482, 482, 483, 484, 485, 485, 486, 486, 486};
	local RoomType_list		= {   1,   1,   1,   1,   4,   4,   4,   6,   6,   6,   6,   6,   5,   5,   5,   5,   5,   3,   3,   3,   3,   2,   2,   2,   2,   2,   2,   2,   2,   2,   2,   2,   2,   2,   2,   2,   2,   2,   2};
	local DoorAction_list	= {   2,   2,   3,   3,  11,  11,  10,  64,  64,  16,  16,  15,  17,  19,  19,  19,  19,  19,  19,  19,  19,  -1,  -1,  -1,  -1,  25,  25,  25,  25,  30,  29,  29,  33,  40,  47,  47,  45,  45,  45};
	local ryosyu_num = table.getn(ryosyu_evid_list);
	for index = 1, ryosyu_num, 1 do
		local tako_index = RoomType_list[index];
		local tako_id    = tako_id_list[tako_id_list[tako_index] ];
		if	tako_id ~= -1 then
			--虜囚の死亡監視を追加 --EN:--Added death watch for prisoners
			proxy:OnCharacterDead(ryosyu_acid_list[index], ryosyu_evid_list[index], tako_func_list[tako_index], once );
			
			--対応するドアイベントが未成立時は、ロジックを切っておく --EN:--When the corresponding door event is not established, turn off the logic
			if	proxy:IsCompleteEvent(DoorAction_list[index] ) == false then
				proxy:EnableLogic( ryosyu_evid_list[index], false );
			end
		end
	end
	
	]]
	
--■441～448■プレートを読む --EN:-- ■ 441 ~ 448 ■ read the plate
	proxy:NotNetMessage_begin();
		proxy:OnActionEventRegion( 441, 2172, "OnEvent_441", 90.0, 10010105, everytime );
		proxy:OnActionEventRegion( 442, 2173, "OnEvent_442", 90.0, 10010105, everytime );
		proxy:OnActionEventRegion( 443, 2174, "OnEvent_443", 90.0, 10010105, everytime );
		proxy:OnActionEventRegion( 444, 2175, "OnEvent_444", 90.0, 10010105, everytime );
		proxy:OnActionEventRegion( 445, 2176, "OnEvent_445", 90.0, 10010105, everytime );
		proxy:OnActionEventRegion( 446, 2177, "OnEvent_446", 90.0, 10010105, everytime );
		proxy:OnActionEventRegion( 447, 2178, "OnEvent_447", 90.0, 10010105, everytime );
		proxy:OnActionEventRegion( 448, 2179, "OnEvent_448", 90.0, 10010105, everytime );
	proxy:NotNetMessage_end();
	
	--■211～219, 221～229, 231■香炉破壊でSFX削除■ --EN:--■211～219, 221～229, 231■SFX deleted by destroying the incense burner■
	RegistKouroBreak(proxy,param);
	
	

----------------------------------------------------------------------------------------------------	
--■NPC状態関連の初期化 --EN:--■NPC status related initialization
----------------------------------------------------------------------------------------------------	
	--フラグを見てNPC状態を初期化 --EN:--Initialize the NPC state by looking at the flag
	SetFirstNpcStateFlag( proxy, param, rogarn_flag_list,		ROGARN_STATE_PRISONER );
	SetFirstNpcStateFlag( proxy, param, noble_woman_flag_list,	NOBLE_WOMAN_STATE_BUSINESS );


--■ロガーン■ --EN:-- ■ Logan ■
	--死亡していないとき --EN:--when not dead
	if	proxy:IsCompleteEvent( ROGARN_STATE_DEAD )		== false and
		proxy:IsCompleteEvent( ROGARN_STATE_WAIT )		== false and
		proxy:IsCompleteEvent( ROGARN_STATE_ANGRY_M1 )	== false and
		proxy:IsCompleteEvent( ROGARN_STATE_LAST_WARD )	== false then
		--敵対していないとき --EN:--When not hostile
		if proxy:IsCompleteEvent( ROGARN_STATE_ANGRY_M4 ) == false then
			--■170■【ロガーン】会話で状態変化■ --EN:--■ 170 ■ [Logan] State change in conversation ■
			if proxy:IsCompleteEvent( ROGARN_STATE_PRISONER ) == true then
				if proxy:IsCompleteEvent( 170 ) == false then
					proxy:LuaCall(170, 0, "OnEvent_170", once);
				end
			end
			
			--■171■【ロガーン】NPCが敵になってない■ --EN:--■171■ [Logan] NPCs are not enemies ■
			if proxy:IsCompleteEvent( 171 ) == false then
				--proxy:OnCharacterTotalDamage( 171, 640, LOCAL_PLAYER, TOTALDAMAGE_ROGARN_M40, "OnEvent_171", once );
				proxy:OnCharacterTotalRateDamage( 171, 640, LOCAL_PLAYER, NPC_ANGRY_Rate, "OnEvent_171", once );
			else
				proxy:SetTeamType(640, TEAM_TYPE_AngryFriend);--チームタイプ変更 --EN:--Change team type
			end
		else--敵対 --EN:--hostile
			proxy:SetTeamType(640, TEAM_TYPE_AngryFriend);--チームタイプ変更 --EN:--Change team type
			proxy:EnableLogic( 640, true );
			--proxy:EnableLogic( 640, false );
		end
		--■172■【ロガーン】NPCが死んだ■ --EN:--■172■ [Logan] NPC died■
		if proxy:IsCompleteEvent( 172 ) == false then
			proxy:OnCharacterDead( 172, 640, "OnEvent_172", once );
		end
		--■176■【ロガーン】アイテムを受け取る■(会話から呼び出す) --EN:-- ■ 176 ■ [Logan] Receive items ■ (call from conversation)
		proxy:NotNetMessage_begin();
			proxy:LuaCall( 176, 0, "OnEvent_176", everytime );
		proxy:NotNetMessage_end();
	else
		proxy:ForceUpdateNextFrame(640);
		InvalidCharactor(proxy, 640 );
		
		--ロガーン周りの光削除 --EN:--Remove light around Logan
		proxy:InvalidSfx( 2010 , true );
		proxy:InvalidPointLight( 2011 );
	end


	
--■元貴族婦人■ --EN:-- Former aristocratic lady
	if proxy:IsClient() == false then
		proxy:RequestForceUpdateNetwork( 641);		
	end
	--死亡していないとき --EN:--when not dead
	if proxy:IsCompleteEvent( NOBLE_WOMAN_STATE_DEAD ) == false then
		--敵対していないとき --EN:--When not hostile
		if proxy:IsCompleteEvent( NOBLE_WOMAN_STATE_ANGRY ) == false then
			--■180■【元貴族婦人】NPCが敵になってない■ --EN:--■180■ [Former noblewoman] NPCs are not enemies■
			if proxy:IsCompleteEvent( 180 ) == false then
				--proxy:OnCharacterTotalDamage( 180, 641, LOCAL_PLAYER, TOTALDAMAGE_NOBLE_WOMAN, "OnEvent_180", once );
				proxy:OnCharacterTotalRateDamage( 180, 641, LOCAL_PLAYER, NPC_ANGRY_Rate, "OnEvent_180", once );
				if	proxy:IsClient() == false then
					proxy:NotNetMessage_begin();
					proxy:OnRegionJustIn( 184, LOCAL_PLAYER, 2125, "OnEvent_184_In", everytime );
					proxy:OnRegionJustOut( 184, LOCAL_PLAYER, 2119, "OnEvent_184_Out", everytime );
					proxy:OnRegionJustIn( 185, LOCAL_PLAYER, 2126, "OnEvent_185_In", everytime );
					proxy:OnRegionJustOut( 185, LOCAL_PLAYER, 2126, "OnEvent_185_Out", everytime );
					proxy:OnSimpleDamage( 186 , 641 , -1 , "OnEvent_186",once);
					proxy:OnRegionJustOut( 187 , 641 , 2129 , "OnEvent_187",once);
					proxy:NotNetMessage_end();
				end
				proxy:SetSpStayAndDamageAnimId( 641, 7001, 9600 );			
			end
		else
			proxy:SetTeamType(641, TEAM_TYPE_AngryFriend);--チームタイプ変更	 --EN:--Change team type
			--proxy:EnableLogic( 641, false );
		end
		--■181■【元貴族婦人】NPCが死んだ■ --EN:--■181■ [Former noblewoman] NPC died■
		if proxy:IsCompleteEvent( 181 ) == false then
			proxy:OnCharacterDead( 181, 641, "OnEvent_181", once );
		end
	else
		print("元貴族婦人死亡"); --EN:print("Ex-noble lady died");
		--死んでいるので無効化 --EN:--disabled because it's dead
		proxy:ForceUpdateNextFrame( 641 );
		InvalidCharactor( proxy, 641 );
	end
	
--■ヴィライデル■ --EN:--■ Villaidel ■
--[[【ヴィライデル】状態一覧]] --EN:--[[[Viraidel] status list]]
	SetFirstNpcStateFlag( proxy, param, viraidel_flag_list, VIRAIDEL_STATE_HELP);

	SingleReset(proxy,150);
	if  proxy:IsSuccessQWC( 40130 ) == true or		--QWC成立　か --EN:--Was the QWC established?
		proxy:IsCompleteEvent(167) == true then		--既に通過済みフラグ --EN:--already passed flag
		proxy:SetEventFlag( 150, true );
	end
		
	if proxy:IsCompleteEvent(150) == true then
		--瓦礫の当たり表示消し --EN:--Erase the display of rubble hits
		proxy:SetColiEnable( 1150, false );
		proxy:SetColiEnable( 1151, false );
		proxy:SetDrawEnable( 1150, false );
		proxy:SetDrawEnable( 1151, false );
		print("[成立]QWC　瓦礫"); --EN:print("[established] QWC rubble");
	else
		--proxy:SetEventFlag( 150, false );
		--InvalidBackRead( proxy, 646 );
		print("[未成立]QWC　瓦礫"); --EN:print("[unestablished] QWC rubble");
	end
	
	--■167■瓦礫の先に進んだ■ --EN:--■ 167 ■ proceeded beyond the rubble ■
	if proxy:IsCompleteEvent(167) == false then
		if proxy:IsClient() == false then
			proxy:NotNetMessage_begin();
				proxy:OnRegionJustIn( 167 , 10000 , 2128,"OnEvent_167",once);
			proxy:NotNetMessage_end();
		end
	end
	
	--■15631■ヴィライデルの死体を調べた■ --EN:--■ 15631 ■ Examined Villaidel's corpse ■
	if proxy:IsCompleteEvent( 15631 ) == false then
		proxy:AddCorpseEvent( 15631 , 646 );
		proxy:NotNetMessage_begin();
			proxy:LuaCall( 15631 ,0 , "OnEvent_15631",once );
 		proxy:NotNetMessage_end();
	end
	
	--■162■QWCでヴィライデルを無効化■ --EN:--■ 162■ Invalidate Villaidel with QWC■
	if proxy:IsSuccessQWC( 40120 ) == true then
		if 	proxy:IsCompleteEvent( 156 ) == true then
			if proxy:IsCompleteEvent( 15631 ) == false then
			--死体を再現する --EN:--reproduce the corpse
				proxy:OpeningDeadPlus( 646 , true ,false ,false );
			else
				print("ヴィライデル無効化"); --EN:print("Disable Villaidel");
				--ヴィライデルを無効化 --EN:--Disable Villaidel
				InvalidBackRead(proxy, 646);
			end
		else
			print("ヴィライデル無効化"); --EN:print("Disable Villaidel");
			--ヴィライデルを無効化 --EN:--Disable Villaidel
			InvalidBackRead(proxy, 646);
		end
	else
		if	proxy:IsCompleteEvent( VIRAIDEL_STATE_DEAD ) 	== true then			
			if 	proxy:IsCompleteEvent( 156 ) == true then
				if proxy:IsCompleteEvent( 15631 ) == false then
				--死体を再現する --EN:--reproduce the corpse
					proxy:OpeningDeadPlus( 646 , true ,false ,false );
				else
					print("ヴィライデル無効化"); --EN:print("Disable Villaidel");
					--ヴィライデルを無効化 --EN:--Disable Villaidel
					InvalidBackRead(proxy, 646);
				end
			else
				print("ヴィライデル無効化"); --EN:print("Disable Villaidel");
				--ヴィライデルを無効化 --EN:--Disable Villaidel
				InvalidBackRead(proxy, 646);
			end			
		elseif	proxy:IsCompleteEvent( VIRAIDEL_STATE_ANGRY ) 	== true then
			proxy:SetTeamType(646, TEAM_TYPE_AngryFriend);--チームタイプ変更 --EN:--Change team type
			proxy:OnCharacterDead( 156, 646, "OnEvent_156", once );
		elseif	proxy:IsCompleteEvent( VIRAIDEL_STATE_HELP ) == true then
			--proxy:OnNetRegion( 151, 2123 );
			SingleReset( proxy, 158 );
			
			if proxy:IsCompleteEvent(26) == false then
				proxy:OnRegionJustIn( 151, LOCAL_PLAYER, 2123, "OnEvent_151", everytime );
				proxy:OnRegionJustOut( 152, LOCAL_PLAYER, 2123, "OnEvent_152", everytime );
				--proxy:OnChrAnimEnd( 152, 646, 0, "OnEvent_152_AnimLoop", everytime );
				proxy:OnRegionJustIn(158, LOCAL_PLAYER, 2124, "OnEvent_158_In", everytime);
				proxy:OnRegionJustOut(158, LOCAL_PLAYER, 2124, "OnEvent_158_Out", everytime);
				proxy:EnableInvincible( 646, true );
				proxy:SetSuperArmor( 646 , true );
			else
				proxy:SetSpStayAndDamageAnimId( 646 , -1,-1 );
			end
			proxy:NotNetMessage_begin();
				proxy:LuaCall( 154, 0, "OnEvent_154", everytime );
			proxy:NotNetMessage_end();
			--proxy:OnCharacterTotalDamage( 155, 646, LOCAL_PLAYER, 100, "OnEvent_155", once );
			proxy:OnCharacterTotalRateDamage( 155, 646, LOCAL_PLAYER, NPC_ANGRY_Rate, "OnEvent_155", once );
			proxy:OnCharacterDead( 156, 646, "OnEvent_156", once );
			proxy:OnRegionJustOut( 163, LOCAL_PLAYER, 2121, "OnEvent_163", everytime );
			proxy:LuaCall( 163, 2, "OnEvent_163_1", everytime );
			
			--proxy:EnableLogic( 646, false );
			
		elseif	proxy:IsCompleteEvent( VIRAIDEL_STATE_SEARCH ) == true then
			if proxy:IsRegionIn( 10000 , 2121 ) == true then
				proxy:OnRegionJustOut( 163, LOCAL_PLAYER, 2121, "OnEvent_163", everytime );
				proxy:LuaCall( 163, 2, "OnEvent_163_1", everytime );
				proxy:SetSpStayAndDamageAnimId( 646 , -1 , -1);
				proxy:OnCharacterTotalRateDamage( 155, 646, LOCAL_PLAYER, NPC_ANGRY_Rate, "OnEvent_155", once );
				proxy:OnCharacterDead( 156, 646, "OnEvent_156", once );
			else			
				proxy:SetEventFlag( 163, true );--空いた事にする --EN:--leave blank
				SetNpcStateFlag( proxy, param, viraidel_flag_list, VIRAIDEL_STATE_DEAD );
				InvalidCharactor( proxy,646);--ヴィライデルを消し去る --EN:--Eliminate Villaidel
			end
		end	
	end
	
--■ヴィライデル・ブラックゴースト■ --EN:--■ Villaidel Black Ghost ■
	--■15603■ヴィライデル黒の死体を調べていない■ --EN:--■15603■Villaidel Black's corpse has not been examined■
	if proxy:IsCompleteEvent( 15603 ) == false then
		proxy:AddCorpseEvent( 15603 , 510 );
		proxy:NotNetMessage_begin();
			proxy:LuaCall( 15603 , 0 , "OnEvent_15603",once);
		proxy:NotNetMessage_end();
	end
	
	--■161■ブラックゴーストの死亡監視■ --EN:--■ 161 ■ Black Ghost Death Watch ■
	if proxy:IsCompleteEvent( 161 ) == false then 
		proxy:OnCharacterDead( 161, 510, "OnEvent_161", once );
	end
	--■162■QWCでブラックゴーストを消す■ --EN:-- ■ 162 ■ Eliminate the black ghost with QWC ■
	if proxy:IsCompleteEvent( 161 ) == true 
	   or proxy:IsSuccessQWC( 40120 ) == false then
		if	proxy:IsCompleteEvent( 161 ) == true and
			proxy:IsCompleteEvent( 15603 ) == false then
			--宝死体を再現 --EN:--Reproduce treasure corpse
			proxy:OpeningDeadPlus( 510 , true ,false ,false );	
		else
			--ブラックゴーストが死んでいるかQWCが成立しなかった場合、ブラックゴーストを無効化する --EN:--Disable Black Ghost if Black Ghost is dead or QWC fails
			InvalidCharactor( proxy, 510 );
		end
		print("ヴィライデルゴーストを無効化しました"); --EN:print("Disabled Villaidel Ghost");
	end	
	
--■177■ロガーン会話可能領域■ --EN:-- ■ 177 ■ Logan Conversation Possible Area ■
	SingleReset(proxy,177);
	proxy:OnRegionJustIn(  177, LOCAL_PLAYER, 2170, "OnEvent_177_in",  everytime );
	proxy:OnRegionJustOut( 177, LOCAL_PLAYER, 2170, "OnEvent_177_out", everytime );
	
	

	--人形ギミック用　攻撃オーナー --EN:--Puppet gimmick attack owner
	InvalidCharactor(proxy,410);		--消す --EN:--erase
	proxy:SetDisableGravity(410,true);	--重力無効 --EN:-- Gravity Disabled
	
--■8086■牢城に来たフラグを立てる■ --EN:-- ■ 8086 ■ Raise a flag for coming to the prison ■
	proxy:SetEventFlag(8086, true);
	
--------------------------------▽▽▽QWCイベント関連▽▽▽-------------------------------- --EN:--▽▽▽QWC event related ▽▽▽--------------------------------
--■440■QWCソウルモンスター出現１■ --EN:--■440■QWC Soul Monster Appearance 1■
	if	proxy:IsSuccessQWC(40100) == true then
		print("m04_00 QWCソウルモンスター出現　成立"); --EN:print("m04_00 QWC soul monster appears established");
		ValidCharactor( proxy, 511 );
		ValidCharactor( proxy, 512 );
		ValidCharactor( proxy, 513 );
	else
		print("m04_00 QWCソウルモンスター出現　未成立"); --EN:print("m04_00 QWC soul monster appears unestablished");
		InvalidCharactor( proxy, 511 );
		InvalidCharactor( proxy, 512 );
		InvalidCharactor( proxy, 513 );
	end
--------------------------------△△△QWCイベント関連△△△-------------------------------- --EN:--△△△QWC event related△△△--------------------------------
	if	proxy:IsCompleteEvent( 435 ) == false then
		proxy:OnRegionJustIn( 435, LOCAL_PLAYER, 2165, "OnEvent_435", once );
		proxy:EnableLogic( 160, false );
	end
	if	proxy:IsCompleteEvent( 436 ) == false then
		proxy:OnRegionJustIn( 436, LOCAL_PLAYER, 2166, "OnEvent_436", once );
		proxy:EnableLogic( 140, false );
	end
	
--■15500■乱入アイテム取得監視■ハンドラはグローバルに定義 --EN:-- ■ 15500 ■ Intrusion item acquisition monitoring ■ Handlers are defined globally
	if proxy:IsCompleteEvent( 15500 ) == false then
--~ 		proxy:AddCorpseEvent( 15500 , 510 );--ヴィライデル・ブラック --EN:--Villaidel Black
		proxy:AddCorpseEvent( 15500 , 550 );--通常・ブラック --EN:--Normal/Black
	end

--■71■ツボ虜囚■ --EN:--■71■Tsubo Prisoner■
	local enemyidlist = {170,171,172,173,174,175,176,177,178,179,180,181,182,183,184};
	local objctidlist = {1115,1116,1117,1118,1119,1120,1121,1122,1123,1124,1125,1126,1127,1128,1129};
	local actionidlist = {71,72,73,74,75,76,77,78,79,80,81,82,83,84,85};
	local num = table.getn( enemyidlist );
		
	for index=1 , num , 1 do
		SingleReset( proxy,actionidlist[ index ] );
		if proxy:IsCompleteEvent( actionidlist[ index ] ) == false then
			--proxy:RestorePiece( objctidlist[index] );
			proxy:OnObjectDestroy( actionidlist[ index ] , objctidlist[index] , "OnEvent_"..actionidlist[ index ],once);
		else
			proxy:ReconstructBreak(objctidlist[index],1);
			proxy:SetSpStayAndDamageAnimId( enemyidlist[ index ],-1,-1);
		end
	end
	
	--[[2008.09.26 toyohide OBJ＞マップパーツ化により破壊不能になったので削除 --EN:--[[2008.09.26 toyohide OBJ > Deleted because it became indestructible due to map parts
--■90■貴婦人の椅子対応■ --EN:-- ■ 90 ■ Lady's chair correspondence ■
	SingleReset( proxy , 90 );
	if proxy:IsCompleteEvent( 90 ) == false then
		proxy:RestorePiece( 1130 );
		proxy:OnObjectDestroy( 90 , 1130 , "OnEvent_90" ,once);
	else
		proxy:ReconstructBreak( 1130 , 1 );
		proxy:SetSpStayAndDamageAnimId( 641 , -1,-1 );
	end
	]]

--結晶トカゲ逃亡イベント --EN:--Crystal Lizard Escape Event
	RegistTokage(proxy,91,189,12);	
	RegistTokage(proxy,595,190,13);
	RegistTokage(proxy,1120,191,14);


--■195■協会前ブラックゴースト死亡管理■ --EN:-- ■ 195 ■ black ghost death management in front of the association ■
	if proxy:IsCompleteEvent( 195 ) == false then
		proxy:OnCharacterDead( 195 , 550 ,"OnEvent_195",once);
	else
		--無効化 --EN:--Invalidation
		InvalidCharactor( proxy, 550 );
	end
	--■999999■フレーム遅れの初期化処理イベントを発行■ --EN:-- ■ 999999 ■ Generate a frame delay initialization processing event ■
	proxy:NotNetMessage_begin();
		--▼0秒後▼-- --EN:--▼After 0 seconds▼--
		proxy:OnKeyTime2( 999990, "Second_Initialize_m04_00_00_00", 0.3, 0, 0, once );	
	proxy:NotNetMessage_end();	
	
	if proxy:IsDbgReLoad() == true then
		proxy:OnKeyTime2( 4021,"OnEvent_DbgReLoad",1.0,0,0,once);
	end
	print("Initialize_m04_00_00_00 end");
end

--リロードデバッグ --EN:--reload debug
function OnEvent_DbgReLoad(proxy,param)
	--完全回復要求 --EN:-- full recovery request
	proxy:RequestFullRecover();
	--古砦要石に戻る --EN:--Return to Old Fort Keystone
	proxy:WarpNextStage( 1, 0, 0, 0, 1008);	
end

function OnEvent_4000_Hp_1(proxy,param)
	print("OnEvent_4000_Hp_1 begin");
	proxy:SetDeadMode2(806 , true );
	proxy:SetDeadMode2(807 , true );
	proxy:SetDeadMode2(817 , true );
	proxy:SetDeadMode2(828 , true );
	print("OnEvent_4000_Hp_1 end");
end


--------------------------------------------------------------------------------------
--Initializeから呼ばれる、1フレーム遅れの初期化処理■999999 --EN:--Initialization with a delay of 1 frame, called from Initialize ■999999
--------------------------------------------------------------------------------------
--■999999■一部、Initでは処理できないので、残しておく --EN:-- ■ 999999 ■ Some parts cannot be processed by Init, so leave them
function Second_Initialize_m04_00_00_00(proxy, param)
	print("Second_Initialize_m04_00_00_00 begin");

--------------------------------▽▽▽QWCイベント関連▽▽▽-------------------------------- --EN:--▽▽▽QWC event related ▽▽▽--------------------------------
--■190■宝イベント(2階の鍵)■ --EN:-- ■ 190 ■ Treasure event (2nd floor key) ■
--[[
	if proxy:IsSuccessQWC( 40140 ) == false then
		proxy:SetDrawEnable( 10244, false );
		proxy:EnableObjTreasure( 10244, false );
		print("QWCが未成立だったので2階の鍵を無効化しました") --EN:print("The QWC was not established, so the second floor key was disabled")
	end
]]
--------------------------------△△△QWCイベント関連△△△-------------------------------- --EN:--△△△QWC event related△△△--------------------------------
	if proxy:IsCompleteEvent( 163 ) == false then
		proxy:SetDrawEnable( 10308, false );
		proxy:SetColiEnable( 10308, false );
		proxy:EnableObjTreasure( 10308, false );
	end
	

	-------------------------------------------------------------------------------------------------------------------
	--■490～503■アイアンメイデン■ --EN:-- ■ 490 ~ 503 ■ Iron Maiden ■
	-------------------------------------------------------------------------------------------------------------------
--[[
	--■490■アイアンメイデン------------------------------------------------------------------------------------------ --EN:-- ■ 490 ■ Iron Maiden -------------------------------------------- -----------------------------------------------
	if	proxy:IsCompleteEvent(490) == false then
		proxy:OnDistanceActionPlus( 490, LOCAL_PLAYER, 1160, "OnEvent_490", 2.0, HELPID_OPEN, 180, 45.0, 0.0, 0.1, 0.0, once );
	else
		proxy:EndAnimation( 1160, 3 );
	end
	
	--■491■アイアンメイデン------------------------------------------------------------------------------------------ --EN:-- ■ 491 ■ Iron Maiden ------------------------------------------- -----------------------------------------------
	if	proxy:IsCompleteEvent(491) == false then
		proxy:OnDistanceActionPlus( 491, LOCAL_PLAYER, 1161, "OnEvent_491", 2.0, HELPID_OPEN, 180, 45.0, 0.0, 0.1, 0.0, once );
	else
		proxy:EndAnimation( 1161, 3 );
	end
]]	
	--■492■アイアンメイデン------------------------------------------------------------------------------------------ --EN:-- ■ 492 ■ Iron Maiden -------------------------------------------- -----------------------------------------------
	if	proxy:IsCompleteEvent(492) == false then
		proxy:OnDistanceActionPlus( 492, LOCAL_PLAYER, 1162, "OnEvent_492", 2.0, HELPID_OPEN, 180, 45.0, 0.0, 0.1, 0.0, once );
		proxy:TreasureDispModeChange( 10259, false );
		proxy:EnableObjTreasure(10259, false);
	else
		proxy:EndAnimation(10259, 20);
		proxy:EndAnimation( 1162, 3 );
	end
--[[	
	--■493■アイアンメイデン------------------------------------------------------------------------------------------ --EN:-- ■ 493 ■ Iron Maiden -------------------------------------------- -----------------------------------------------
	if	proxy:IsCompleteEvent(493) == false then
		proxy:OnDistanceActionPlus( 493, LOCAL_PLAYER, 1163, "OnEvent_493", 2.0, HELPID_OPEN, 180, 45.0, 0.0, 0.1, 0.0, once );
	else
		proxy:EndAnimation( 1163, 3 );
	end
	
	--■494■アイアンメイデン------------------------------------------------------------------------------------------ --EN:-- ■ 494 ■ Iron Maiden -------------------------------------------- -----------------------------------------------
	if	proxy:IsCompleteEvent(494) == false then
		proxy:OnDistanceActionPlus( 494, LOCAL_PLAYER, 1164, "OnEvent_494", 2.0, HELPID_OPEN, 180, 45.0, 0.0, 0.1, 0.0, once );
	else
		proxy:EndAnimation( 1164, 3 );
	end
	
	--■495■アイアンメイデン------------------------------------------------------------------------------------------ --EN:-- ■ 495 ■ Iron Maiden -------------------------------------------- -----------------------------------------------
	if	proxy:IsCompleteEvent(495) == false then
		proxy:OnDistanceActionPlus( 495, LOCAL_PLAYER, 1165, "OnEvent_495", 2.0, HELPID_OPEN, 180, 45.0, 0.0, 0.1, 0.0, once );
	else
		proxy:EndAnimation( 1165, 3 );
	end
]]
	
	--■496■アイアンメイデン------------------------------------------------------------------------------------------ --EN:-- ■ 496 ■ Iron Maiden -------------------------------------------- -----------------------------------------------
	if	proxy:IsCompleteEvent(496) == false then
		proxy:OnDistanceActionPlus( 496, LOCAL_PLAYER, 1166, "OnEvent_496", 2.0, HELPID_OPEN, 180, 45.0, 0.0, 0.1, 0.0, once );
		proxy:TreasureDispModeChange( 10268, false );
		proxy:EnableObjTreasure(10268, false);
	else
		proxy:EndAnimation(10268, 20);
		proxy:EndAnimation( 1166, 3 );
	end
	
	--■497■アイアンメイデン------------------------------------------------------------------------------------------ --EN:-- ■ 497 ■ Iron Maiden ------------------------------------------- -----------------------------------------------
	if	proxy:IsCompleteEvent(497) == false then
		proxy:OnDistanceActionPlus( 497, LOCAL_PLAYER, 1167, "OnEvent_497", 2.0, HELPID_OPEN, 180, 45.0, 0.0, 0.1, 0.0, once );
		proxy:TreasureDispModeChange( 10267, false );
		proxy:EnableObjTreasure(10267, false);
	else
		proxy:EndAnimation(10267, 20);
		proxy:EndAnimation( 1167, 3 );
	end
--[[	
	--■498■アイアンメイデン------------------------------------------------------------------------------------------ --EN:-- ■ 498 ■ Iron Maiden ------------------------------------------- -----------------------------------------------
	if	proxy:IsCompleteEvent(498) == false then
		proxy:OnDistanceActionPlus( 498, LOCAL_PLAYER, 1168, "OnEvent_498", 2.0, HELPID_OPEN, 180, 45.0, 0.0, 0.1, 0.0, once );
	else
		proxy:EndAnimation( 1168, 3 );
	end
]]

	
	--■499■アイアンメイデン------------------------------------------------------------------------------------------ --EN:-- ■ 499 ■ Iron Maiden -------------------------------------------- -----------------------------------------------
	if	proxy:IsCompleteEvent(499) == false then
		proxy:OnDistanceActionPlus( 499, LOCAL_PLAYER, 1169, "OnEvent_499", 2.0, HELPID_OPEN, 180, 45.0, 0.0, 0.1, 0.0, once );
		InvalidCharactor( proxy, 124 );
	else
		proxy:EndAnimation( 1169, 3 );
	end
	
--[[
	--■500■アイアンメイデン------------------------------------------------------------------------------------------ --EN:-- ■ 500 ■ Iron Maiden -------------------------------------------- -----------------------------------------------
	if	proxy:IsCompleteEvent(500) == false then
		proxy:OnDistanceActionPlus( 500, LOCAL_PLAYER, 1170, "OnEvent_500", 2.0, HELPID_OPEN, 180, 45.0, 0.0, 0.1, 0.0, once );
	else
		proxy:EndAnimation( 1170, 3 );
	end
]]
	
	--■501■アイアンメイデン------------------------------------------------------------------------------------------ --EN:-- ■ 501 ■ Iron Maiden -------------------------------------------- -----------------------------------------------
	if	proxy:IsCompleteEvent(501) == false then
		proxy:OnDistanceActionPlus( 501, LOCAL_PLAYER, 1171, "OnEvent_501", 2.0, HELPID_OPEN, 180, 45.0, 0.0, 0.1, 0.0, once );
		proxy:TreasureDispModeChange( 10273, false );
		proxy:EnableObjTreasure(10273, false);
	else
		proxy:EndAnimation(10273, 20);
		proxy:EndAnimation( 1171, 3 );
	end
	
	--■502■アイアンメイデン------------------------------------------------------------------------------------------ --EN:-- ■ 502 ■ Iron Maiden -------------------------------------------- -----------------------------------------------
	if	proxy:IsCompleteEvent(502) == false then
		proxy:OnDistanceActionPlus( 502, LOCAL_PLAYER, 1172, "OnEvent_502", 2.0, HELPID_OPEN, 180, 45.0, 0.0, 0.1, 0.0, once );
		proxy:TreasureDispModeChange( 10274, false );
		proxy:EnableObjTreasure(10274, false);
	else
		proxy:EndAnimation(10274, 20);
		proxy:EndAnimation( 1172, 3 );
	end
	
	--■503■アイアンメイデン------------------------------------------------------------------------------------------ --EN:-- ■ 503 ■ Iron Maiden -------------------------------------------- -----------------------------------------------
	if	proxy:IsCompleteEvent(503) == false then
		proxy:OnDistanceActionPlus( 503, LOCAL_PLAYER, 1173, "OnEvent_503", 2.0, HELPID_OPEN, 180, 45.0, 0.0, 0.1, 0.0, once );
		proxy:TreasureDispModeChange( 10272, false );
		proxy:EnableObjTreasure(10272, false);
	else
		proxy:EndAnimation(10272, 20);
		proxy:EndAnimation( 1173, 3 );
	end
	
	--■504■アイアンメイデン------------------------------------------------------------------------------------------ --EN:-- ■ 504 ■ Iron Maiden -------------------------------------------- -----------------------------------------------
	if	proxy:IsCompleteEvent(504) == false then
		proxy:OnDistanceActionPlus( 504, LOCAL_PLAYER, 1174, "OnEvent_504", 2.0, HELPID_OPEN, 180, 45.0, 0.0, 0.1, 0.0, once );
		InvalidCharactor( proxy, 139 );
	else
		proxy:EndAnimation( 1174, 3 );
	end
	
	
	
	print("Second_Initialize_m04_00_00_00 end");
end

--------------------------------------------------------------------------------------
--徘徊デーモンの登場■360 --EN:-- Appearance of the wandering demon 360
--------------------------------------------------------------------------------------

--▼グローバルの死亡監視から呼ばれる(ソロ) --EN:--▼ Called from global death watch (solo)
function PlayerDeath_m04_00_00_00(proxy, param)
	print("PlayerDeath_m04_00_00_00");
	
	LuaFunc_VisibleTheWanderingDemon(proxy, param, demon_id_list_m04_00_00_00);
	proxy:SetEventFlag( 360 , 1 );
	
	print("PlayerDeath_m04_00_00_00");
end

--▼グローバルの血文字復活から呼ばれる(ソロ) --EN:--▼Called from global blood letter revival (solo)
function PlayerRevive_m04_00_00_00(proxy,param)
	print("PlayerRevive_m04_00_00_00");
	
	LuaFunc_InvisibleTheWanderingDemon(proxy, param, demon_id_list_m04_00_00_00);
	proxy:SetEventFlag( 360 , 0 );
	
	print("PlayerRevive_m04_00_00_00");
end

---------------------------------------------------------------------------------------------------
--■211～219, 221～229, 231■香炉破壊でSFX削除■ --EN:--■211～219, 221～229, 231■SFX deleted by destroying the incense burner■
---------------------------------------------------------------------------------------------------
--香炉破壊イベント登録 --EN:-- Incense burner destruction event registration
function RegistKouroBreak(proxy,param)
	print("RegistKouroBreak begin");
	local acid_list = { 211, 212, 213, 214, 215, 216, 217, 218, 219, 221, 222, 223, 224, 225, 226, 227, 228, 229, 231};
	local obj_list	= {1180,1181,1182,1183,1184,1185,1186,1187,1188,1189,1190,1191,1192,1193,1194,1195,1196,1197,1198};
	local sfx_list	= {2180,2181,2182,2183,2184,2185,2186,2187,2188,2189,2190,2191,2192,2193,2194,2195,2196,2197,2198};
	local event_num = table.getn(acid_list);
	for index = 1, event_num, 1 do
		local acid  = acid_list[index];
		local evid  = obj_list[index];
		local sfxid = sfx_list[index];
		SingleReset( proxy, acid );
		if	proxy:IsCompleteEvent( acid ) == false then
			proxy:RestorePiece( evid );
			proxy:OnObjectDestroy( acid, evid, "OnEvent_"..acid, once );
		else
			proxy:InvalidSfx( sfxid, false );
			proxy:ReconstructBreak( evid , 1 );
		end
	end
	
	print("RegistKouroBreak end");
end

---------------------------------------------------------------------------------------------------
--■211～219, 221～229, 231■香炉破壊でSFX削除■ --EN:--■211～219, 221～229, 231■SFX deleted by destroying the incense burner■
---------------------------------------------------------------------------------------------------
function OnEvent_211(proxy,param) proxy:InvalidSfx( 2180, false ); proxy:SetEventFlag( param:GetParam1(), true ); end
function OnEvent_212(proxy,param) proxy:InvalidSfx( 2181, false ); proxy:SetEventFlag( param:GetParam1(), true ); end
function OnEvent_213(proxy,param) proxy:InvalidSfx( 2182, false ); proxy:SetEventFlag( param:GetParam1(), true ); end
function OnEvent_214(proxy,param) proxy:InvalidSfx( 2183, false ); proxy:SetEventFlag( param:GetParam1(), true ); end
function OnEvent_215(proxy,param) proxy:InvalidSfx( 2184, false ); proxy:SetEventFlag( param:GetParam1(), true ); end
function OnEvent_216(proxy,param) proxy:InvalidSfx( 2185, false ); proxy:SetEventFlag( param:GetParam1(), true ); end
function OnEvent_217(proxy,param) proxy:InvalidSfx( 2186, false ); proxy:SetEventFlag( param:GetParam1(), true ); end
function OnEvent_218(proxy,param) proxy:InvalidSfx( 2187, false ); proxy:SetEventFlag( param:GetParam1(), true ); end
function OnEvent_219(proxy,param) proxy:InvalidSfx( 2188, false ); proxy:SetEventFlag( param:GetParam1(), true ); end
function OnEvent_221(proxy,param) proxy:InvalidSfx( 2189, false ); proxy:SetEventFlag( param:GetParam1(), true ); end
function OnEvent_222(proxy,param) proxy:InvalidSfx( 2190, false ); proxy:SetEventFlag( param:GetParam1(), true ); end
function OnEvent_223(proxy,param) proxy:InvalidSfx( 2191, false ); proxy:SetEventFlag( param:GetParam1(), true ); end
function OnEvent_224(proxy,param) proxy:InvalidSfx( 2192, false ); proxy:SetEventFlag( param:GetParam1(), true ); end
function OnEvent_225(proxy,param) proxy:InvalidSfx( 2193, false ); proxy:SetEventFlag( param:GetParam1(), true ); end
function OnEvent_226(proxy,param) proxy:InvalidSfx( 2194, false ); proxy:SetEventFlag( param:GetParam1(), true ); end
function OnEvent_227(proxy,param) proxy:InvalidSfx( 2195, false ); proxy:SetEventFlag( param:GetParam1(), true ); end
function OnEvent_228(proxy,param) proxy:InvalidSfx( 2196, false ); proxy:SetEventFlag( param:GetParam1(), true ); end
function OnEvent_229(proxy,param) proxy:InvalidSfx( 2197, false ); proxy:SetEventFlag( param:GetParam1(), true ); end
function OnEvent_231(proxy,param) proxy:InvalidSfx( 2198, false ); proxy:SetEventFlag( param:GetParam1(), true ); end


--------------------------------------------------------------------------------------
--□扉用の関数□ --EN:--□ Function for doors□
--------------------------------------------------------------------------------------

--▽これを呼ぶ▽ --EN:--▽Call this▽
function EventNormalDoor(proxy, param, event_id, door_id, key_id, msg_id)
	local ret = false;
	print("OnEvent_"..event_id.." begin");
	
	--多重発動防止 --EN:--Multiple activation prevention
	if proxy:IsCompleteEvent( event_id ) == true then
		print("OnEvent_"..event_id.." return end");
		return false;
	end
	
	--必要アイテムの指定 --EN:--Specify required items
	local KEY_ITEM_TYPE = TYPE_GOODS;
	local KEY_ITEM_ID   = key_id;
	
	--必要アイテムを所持している(インベントリーにアイテムとして所持している) --EN:--You have the necessary items (have them as items in your inventory)
	if proxy:IsInventoryEquip( KEY_ITEM_TYPE , KEY_ITEM_ID ) == true then
		print("OnEvent_"..event_id.." Successed");
		--▼選択メニューの監視▼ --EN:--▼Monitor selection menu▼
		print("msg_id = ",msg_id);
		print("door_id = ",door_id);
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", msg_id, 0, 6, door_id, GEN_DIALOG_DIST, once );
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
		EventOpenDoor(proxy, param, event_id, door_id, 1, DOOR_DMY_ID_A );
		ret = true;
	else
		print("OnEvent_"..event_id.." Failed");
		--扉が開かない場合のメッセージを表示 --EN:-- Display a message when the door does not open
		--proxy:InfomationMenu( INFOMENU_TYPE_SIMPLE, 0, MSG_CATEGORY_EVENT, 10010160, 1);
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010160, 0, 6, door_id, GEN_DIALOG_DIST, once );
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
		--proxy:ShowGenDialog(10010160,1,1,true);
		ret = false;
	end

	print("OnEvent_"..event_id.." end");
	
	--ヴィライデル判定用に利用 --EN:--Used for judging Vilaidel
	return ret;
end




function EventOpenDoor(proxy, param, event_id, door_id, door_anime_id, dmy_id)
	print("OnEvent_"..event_id.."_1 begin");
	--proxy:PlayAnimation( door_id , door_anime_id );--扉のアニメーション --EN:-- door animation
	proxy:CustomLuaCallStartPlus( 4013, door_id, door_anime_id );
	print("event_id = ",event_id);
	print("door_id = ",door_id);
	print("animeId = ",door_anime_id);
	print("dmy_id = ",dmy_id);
	--proxy:DeleteEvent( event_id );
	--同期DeleteEvent --EN:--Synchronous DeleteEvent
	proxy:LuaCallStartPlus( 4057, 1, event_id );
	
	--同期アニメーション(プレイヤの判定もあり) --EN:-- Synchronous animation (with player judgment)
	proxy:CustomLuaCallStartPlus( 4013, LOCAL_PLAYER, ANIMEID_OPEN );

	proxy:WarpDmy( LOCAL_PLAYER , door_id , dmy_id );
	
	--同期SetEventFlag --EN:-- Synchronous SetEventFlag
	proxy:LuaCallStartPlus( 4057, 2, event_id );
	--proxy:SetEventFlag( event_id , 1 );--開閉扉A(手前から開ける)への操作を無効にする。 --EN:--Disable the operation to open/close door A (open from the front).

	print("OnEvent_"..event_id.."_1 end");
end
--ID12：3Fの鍵 --EN:--ID12: 3F key
--------------------------------------------------------------------------------------
--■2■牢城扉2■--(1002) --EN:-- 2 ■ Prison door 2 ■ --(1002)
--------------------------------------------------------------------------------------
function OnEvent_2  (proxy, param)
	if EventNormalDoor(proxy, param, param:GetParam1(), param:GetParam2(), ITEMID_ROUGOKU_KEY_3, HELPID_ROUGOKU_KEY_3 ) == true then
		proxy:NotNetMessage_begin();
			proxy:OnKeyTime2( param:GetParam1(),"OnEvent_2_1",0.0,0,param:GetParam2(),once);
		proxy:NotNetMessage_end();
	end
end
function OnEvent_2_1(proxy,param)
	local ryosyu_list = {100, 101};
	RyosyuMove(proxy, ryosyu_list );
	
	--タコイベントはとりあえず無効化しておきます --EN:--Disable octopus events for the time being
	--local tako_list = {151};
	--TakoMove(proxy, tako_list, 100 );
	--EventOpenDoor(proxy, param, param:GetParam1(), param:GetParam3(), 1 , DOOR_DMY_ID_A );
end
--------------------------------------------------------------------------------------
--■3■牢城扉3■--(1003) --EN:-- 3 ■ prison door 3 ■ --(1003)
--------------------------------------------------------------------------------------
function OnEvent_3  (proxy, param)
	if EventNormalDoor(proxy, param, param:GetParam1(), param:GetParam2(), ITEMID_ROUGOKU_KEY_3, HELPID_ROUGOKU_KEY_3 ) == true then
		proxy:NotNetMessage_begin();
			proxy:OnKeyTime2( param:GetParam1(),"OnEvent_3_1",0.0,0,param:GetParam2(),once);
		proxy:NotNetMessage_end();
	end
end
function OnEvent_3_1(proxy,param)
	local ryosyu_list = {102, 103};
	RyosyuMove(proxy, ryosyu_list );
	
	--local tako_list = {151};
	--TakoMove(proxy, tako_list, 102 );
	--EventOpenDoor(proxy, param, param:GetParam1(), param:GetParam3(), 1, DOOR_DMY_ID_A );
end

--------------------------------------------------------------------------------------
--■4■牢城扉4■--(1004) --EN:-- 4 ■ prison door 4 ■ --(1004)
--------------------------------------------------------------------------------------
function OnEvent_4  (proxy, param)EventNormalDoor(proxy, param, param:GetParam1(), param:GetParam2(), ITEMID_ROUGOKU_KEY_3, HELPID_ROUGOKU_KEY_3 ); end
function OnEvent_4_1(proxy,param) EventOpenDoor(proxy, param, param:GetParam1(), param:GetParam3(), 1, DOOR_DMY_ID_A ); end

--------------------------------------------------------------------------------------
--■5■牢城扉5■--(1005) --EN:-- 5 ■ Prison door 5 ■ --(1005)
--------------------------------------------------------------------------------------
function OnEvent_5  (proxy, param) EventOpenDoor(proxy, param, param:GetParam1(), param:GetParam2(), 1, DOOR_DMY_ID_A ); end
--function OnEvent_5  (proxy, param) EventNormalDoor(proxy, param, param:GetParam1(), param:GetParam2(), ITEMID_ROUGOKU_KEY_3, HELPID_ROUGOKU_KEY_3 ); end
--function OnEvent_5_1(proxy,param) EventOpenDoor(proxy, param, param:GetParam1(), param:GetParam3(), 1, DOOR_DMY_ID_A ); end

--------------------------------------------------------------------------------------
--■6■牢城扉6■--(1006) --EN:-- 6 ■ Prison door 6 ■ --(1006)
--------------------------------------------------------------------------------------
function OnEvent_6  (proxy, param) EventOpenDoor(proxy, param, param:GetParam1(), param:GetParam2(), 1, DOOR_DMY_ID_A ); end
--function OnEvent_6  (proxy, param) EventNormalDoor(proxy, param, param:GetParam1(), param:GetParam2(), ITEMID_ROUGOKU_KEY_3, HELPID_ROUGOKU_KEY_3 ); end
--function OnEvent_6_1(proxy,param) EventOpenDoor(proxy, param, param:GetParam1(), param:GetParam3(), 1, DOOR_DMY_ID_A ); end

--------------------------------------------------------------------------------------
--■7■牢城扉7■--(1007) --EN:-- 7 ■ prison door 7 ■ --(1007)
--------------------------------------------------------------------------------------
function OnEvent_7  (proxy, param) EventOpenDoor(proxy, param, param:GetParam1(), param:GetParam2(), 1, DOOR_DMY_ID_A ); end
--function OnEvent_7  (proxy, param) EventNormalDoor(proxy, param, param:GetParam1(), param:GetParam2(), ITEMID_ROUGOKU_KEY_3, HELPID_ROUGOKU_KEY_3 ); end
--function OnEvent_7_1(proxy,param) EventOpenDoor(proxy, param, param:GetParam1(), param:GetParam3(), 1, DOOR_DMY_ID_A ); end

--------------------------------------------------------------------------------------
--■8■牢城扉8■--(1008) --EN:-- 8 ■ prison door 8 ■ --(1008)
--------------------------------------------------------------------------------------
function OnEvent_8  (proxy, param) EventOpenDoor(proxy, param, param:GetParam1(), param:GetParam2(), 1, DOOR_DMY_ID_A ); end
--function OnEvent_8  (proxy, param) EventNormalDoor(proxy, param, param:GetParam1(), param:GetParam2(), ITEMID_ROUGOKU_KEY_3, HELPID_ROUGOKU_KEY_3 ); end
--function OnEvent_8_1(proxy,param) EventOpenDoor(proxy, param, param:GetParam1(), param:GetParam3(), 1, DOOR_DMY_ID_A ); end

--------------------------------------------------------------------------------------
--■9■牢城扉9■--(1009) --EN:-- 9 ■ prison door 9 ■ --(1009)
--------------------------------------------------------------------------------------
function OnEvent_9  (proxy, param) EventOpenDoor(proxy, param, param:GetParam1(), param:GetParam2(), 1, DOOR_DMY_ID_A ); end
--function OnEvent_9  (proxy, param) EventNormalDoor(proxy, param, param:GetParam1(), param:GetParam2(), ITEMID_ROUGOKU_KEY_3, HELPID_ROUGOKU_KEY_3 ); end
--function OnEvent_9_1(proxy,param) EventOpenDoor(proxy, param, param:GetParam1(), param:GetParam3(), 1, DOOR_DMY_ID_A ); end

--------------------------------------------------------------------------------------
--■10■牢城扉10■--(1010) --EN:-- 10 ■ Prison door 10 ■ --(1010)
--------------------------------------------------------------------------------------
function OnEvent_10  (proxy, param)
	if EventNormalDoor(proxy, param, param:GetParam1(), param:GetParam2(), ITEMID_ROUGOKU_KEY_3, HELPID_ROUGOKU_KEY_3 ) == true then
		proxy:NotNetMessage_begin();
			proxy:OnKeyTime2( param:GetParam1(),"OnEvent_10_1",0.0,0,param:GetParam2(),once);
		proxy:NotNetMessage_end();
	end
end
function OnEvent_10_1(proxy,param)
	local ryosyu_list = {106};
	RyosyuMove(proxy, ryosyu_list );
	
	--local tako_list = {160};
	--TakoMove(proxy, tako_list, 106 );	
	--EventOpenDoor(proxy, param, param:GetParam1(), param:GetParam3(), 1, DOOR_DMY_ID_A );
end

--------------------------------------------------------------------------------------
--■11■牢城扉11■--(1011) --EN:-- 11 ■ prison door 11 ■ --(1011)
--------------------------------------------------------------------------------------
function OnEvent_11  (proxy, param)
	if EventNormalDoor(proxy, param, param:GetParam1(), param:GetParam2(), ITEMID_ROUGOKU_KEY_3, HELPID_ROUGOKU_KEY_3 ) == true then
		proxy:NotNetMessage_begin();
			proxy:OnKeyTime2( param:GetParam1(),"OnEvent_11_1",0.0,0,param:GetParam2(),once);
		proxy:NotNetMessage_end();
	end	
end
function OnEvent_11_1(proxy,param)
	local ryosyu_list = {104, 105};
	RyosyuMove(proxy, ryosyu_list );
	
	--local tako_list = {160};
	--TakoMove(proxy, tako_list, 104 );
	--EventOpenDoor(proxy, param, param:GetParam1(), param:GetParam3(), 1, DOOR_DMY_ID_A );
end

--------------------------------------------------------------------------------------
--■12■牢城扉12■--(1012) --EN:-- 12 ■ prison door 12 ■ -- (1012)
--------------------------------------------------------------------------------------
function OnEvent_12  (proxy, param) EventOpenDoor(proxy, param, param:GetParam1(), param:GetParam2(), 1, DOOR_DMY_ID_A ); end
--function OnEvent_12  (proxy, param) EventNormalDoor(proxy, param, param:GetParam1(), param:GetParam2(), ITEMID_ROUGOKU_KEY_3, HELPID_ROUGOKU_KEY_3 ); end
--function OnEvent_12_1(proxy,param) EventOpenDoor(proxy, param, param:GetParam1(), param:GetParam3(), 1, DOOR_DMY_ID_A ); end

--------------------------------------------------------------------------------------
--■13■牢城扉13■--(1013) --EN:-- 13 ■ prison door 13 ■ --(1013)
--------------------------------------------------------------------------------------
function OnEvent_13  (proxy, param) EventOpenDoor(proxy, param, param:GetParam1(), param:GetParam2(), 1, DOOR_DMY_ID_A ); end
--function OnEvent_13  (proxy, param) EventNormalDoor(proxy, param, param:GetParam1(), param:GetParam2(), ITEMID_ROUGOKU_KEY_3, HELPID_ROUGOKU_KEY_3 ); end
--function OnEvent_13_1(proxy,param) EventOpenDoor(proxy, param, param:GetParam1(), param:GetParam3(), 1, DOOR_DMY_ID_A ); end

--------------------------------------------------------------------------------------
--■14■牢城扉14■--(1014) --EN:-- 14 ■ prison door 14 ■ --(1014)
--------------------------------------------------------------------------------------
function OnEvent_14  (proxy, param) EventNormalDoor(proxy, param, param:GetParam1(), param:GetParam2(), ITEMID_ROGARN_KEY, HELPID_ROGARN_KEY ); end
function OnEvent_14_1(proxy,param) EventOpenDoor(proxy, param, param:GetParam1(), param:GetParam3(), 1, DOOR_DMY_ID_A ); end

--------------------------------------------------------------------------------------
--■15■牢城扉15■--(1015) --EN:-- 15 ■ prison door 15 ■ --(1015)
--------------------------------------------------------------------------------------
function OnEvent_15  (proxy, param) EventNormalDoor(proxy, param, param:GetParam1(), param:GetParam2(), ITEMID_ROUGOKU_KEY_3, HELPID_ROUGOKU_KEY_3 ); end
function OnEvent_15_1(proxy,param)
	EventOpenDoor(proxy, param, param:GetParam1(), param:GetParam3(), 1, DOOR_DMY_ID_A );
	--local ryosyu_list = {111};
	--RyosyuMove(proxy, ryosyu_list );
	
end

--------------------------------------------------------------------------------------
--■16■牢城扉16■--(1016) --EN:-- 16 ■ prison door 16 ■ --(1016)
--------------------------------------------------------------------------------------
function OnEvent_16  (proxy, param) EventNormalDoor(proxy, param, param:GetParam1(), param:GetParam2(), ITEMID_ROUGOKU_KEY_3, HELPID_ROUGOKU_KEY_3 ); end
function OnEvent_16_1(proxy,param)
	EventOpenDoor(proxy, param, param:GetParam1(), param:GetParam3(), 1, DOOR_DMY_ID_A );
	--local ryosyu_list = {109, 110};
	--RyosyuMove(proxy, ryosyu_list );
	
end

--------------------------------------------------------------------------------------
--■17■牢城扉17■--(1017) --EN:-- 17 ■ prison door 17 ■ --(1017)
--------------------------------------------------------------------------------------
function OnEvent_17  (proxy, param)
	if EventNormalDoor(proxy, param, param:GetParam1(), param:GetParam2(), ITEMID_ROUGOKU_KEY_3, HELPID_ROUGOKU_KEY_3 ) == true then
		proxy:NotNetMessage_begin();
			proxy:OnKeyTime2( param:GetParam1(),"OnEvent_17_1",0.0,0,param:GetParam2(),once);
		proxy:NotNetMessage_end();
	end
end

function OnEvent_17_1(proxy,param)	
	local ryosyu_list = {112};
	RyosyuMove(proxy, ryosyu_list );
	
	--local tako_list = {160};
	--TakoMove(proxy, tako_list, 112 );
	--EventOpenDoor(proxy, param, param:GetParam1(), param:GetParam3(), 1, DOOR_DMY_ID_A );
end

--------------------------------------------------------------------------------------
--■18■牢城扉18■--(1021) --EN:-- 18 ■ Prison door 18 ■ --(1021)
--------------------------------------------------------------------------------------
function OnEvent_18  (proxy, param) EventOpenDoor(proxy, param, param:GetParam1(), param:GetParam2(), 1, DOOR_DMY_ID_A ); end
--function OnEvent_18  (proxy, param) EventNormalDoor(proxy, param, param:GetParam1(), param:GetParam2(), ITEMID_ROUGOKU_KEY_4, HELPID_ROUGOKU_KEY_4 ); end
--function OnEvent_18_1(proxy,param) EventOpenDoor(proxy, param, param:GetParam1(), param:GetParam3(), 1, DOOR_DMY_ID_A ); end

--------------------------------------------------------------------------------------
--■19■牢城扉19■--(1022) --EN:-- 19 ■ prison door 19 ■ --(1022)
--------------------------------------------------------------------------------------
function OnEvent_19  (proxy, param)
	if EventNormalDoor(proxy, param, param:GetParam1(), param:GetParam2(), ITEMID_ROUGOKU_KEY_4, HELPID_ROUGOKU_KEY_4 ) == true then
		proxy:NotNetMessage_begin();
			proxy:OnKeyTime2( param:GetParam1(),"OnEvent_19_1",0.0,0,param:GetParam2(),once);
		proxy:NotNetMessage_end();
	end
end
function OnEvent_19_1(proxy,param)
	--EventOpenDoor(proxy, param, param:GetParam1(), param:GetParam3(), 1, DOOR_DMY_ID_A );
	local ryosyu_list = {113, 114, 115, 116, 117, 118, 119, 120};
	RyosyuMove(proxy, ryosyu_list );
	
	--proxy:ResetThink(154);
	--TurnTarget( proxy, 154, 113, -1 );
end

--------------------------------------------------------------------------------------
--■20■牢城扉20■--(1023) --EN:-- 20 ■ Prison door 20 ■ --(1023)
--------------------------------------------------------------------------------------
function OnEvent_20  (proxy, param) EventNormalDoor(proxy, param, param:GetParam1(), param:GetParam2(), ITEMID_ROUGOKU_KEY_4, HELPID_ROUGOKU_KEY_4 ); end
function OnEvent_20_1(proxy,param) EventOpenDoor(proxy, param, param:GetParam1(), param:GetParam3(), 1, DOOR_DMY_ID_A ); end

--------------------------------------------------------------------------------------
--■21■牢城扉21■--(1024) --EN:-- 21 ■ prison door 21 ■ --(1024)
--------------------------------------------------------------------------------------
--[[
function OnEvent_21  (proxy, param)
	EventOpenDoor(proxy, param, param:GetParam1(), param:GetParam3(), 1, DOOR_DMY_ID_A );
	local ryosyu_list = {121, 122, 123};
	RyosyuMove(proxy, ryosyu_list );
	
	--proxy:ResetThink(154);
	--TurnTarget( proxy, 154, 121, -1 );
end
]]
function OnEvent_21  (proxy, param)
	EventOpenDoor(proxy, param, param:GetParam1(), param:GetParam2(), 1, DOOR_DMY_ID_A );
	local ryosyu_list = {121, 122, 123};
	RyosyuMove(proxy, ryosyu_list );
end
--[[
function OnEvent_21  (proxy, param) 
	EventNormalDoor(proxy, param, param:GetParam1(), param:GetParam2(), ITEMID_ROUGOKU_KEY_4, HELPID_ROUGOKU_KEY_4 );
end
function OnEvent_21_1(proxy,param)
	EventOpenDoor(proxy, param, param:GetParam1(), param:GetParam3(), 1, DOOR_DMY_ID_A );
	local ryosyu_list = {121, 122, 123};
	RyosyuMove(proxy, ryosyu_list );
end
]]
--function OnEvent_21  (proxy, param) EventNormalDoor(proxy, param, param:GetParam1(), param:GetParam2(), ITEMID_ROUGOKU_KEY_4, HELPID_ROUGOKU_KEY_4 ); end
--function OnEvent_21_1(proxy,param)
--end

--------------------------------------------------------------------------------------
--■22■牢城扉22■--(1025) --EN:-- 22 ■ prison door 22 ■ -- (1025)
--------------------------------------------------------------------------------------
function OnEvent_22  (proxy, param) EventNormalDoor(proxy, param, param:GetParam1(), param:GetParam2(), ITEMID_ROUGOKU_KEY_4, HELPID_ROUGOKU_KEY_4 ); end
function OnEvent_22_1(proxy,param) EventOpenDoor(proxy, param, param:GetParam1(), param:GetParam3(), 1, DOOR_DMY_ID_A ); end

--------------------------------------------------------------------------------------
--■23■牢城扉23■--(1026) --EN:-- 23 ■ prison door 23 ■ --(1026)
--------------------------------------------------------------------------------------
function OnEvent_23  (proxy, param) EventOpenDoor(proxy, param, param:GetParam1(), param:GetParam2(), 1, DOOR_DMY_ID_A ); end
--function OnEvent_23  (proxy, param) EventNormalDoor(proxy, param, param:GetParam1(), param:GetParam2(), ITEMID_ROUGOKU_KEY_4, HELPID_ROUGOKU_KEY_4 ); end
--function OnEvent_23_1(proxy,param) EventOpenDoor(proxy, param, param:GetParam1(), param:GetParam3(), 1, DOOR_DMY_ID_A ); end

--------------------------------------------------------------------------------------
--■24■牢城扉24■--(1027) --EN:-- 24 ■ prison door 24 ■ --(1027)
--------------------------------------------------------------------------------------
function OnEvent_24  (proxy, param) EventNormalDoor(proxy, param, param:GetParam1(), param:GetParam2(), ITEMID_ROUGOKU_KEY_4, HELPID_ROUGOKU_KEY_4 ); end
function OnEvent_24_1(proxy,param) EventOpenDoor(proxy, param, param:GetParam1(), param:GetParam3(), 1, DOOR_DMY_ID_A ); end

--------------------------------------------------------------------------------------
--■25■牢城扉25■--(1028) --EN:-- 25 ■ prison door 25 ■ -- (1028)
--------------------------------------------------------------------------------------
function OnEvent_25  (proxy, param)
	if EventNormalDoor(proxy, param, param:GetParam1(), param:GetParam2(), ITEMID_ROUGOKU_KEY_4, HELPID_ROUGOKU_KEY_4 ) == true then
		proxy:NotNetMessage_begin();
			proxy:OnKeyTime2( param:GetParam1(),"OnEvent_25_1",0.0,0,param:GetParam2(),once);
		proxy:NotNetMessage_end();
	end
end
function OnEvent_25_1(proxy,param)
	--EventOpenDoor(proxy, param, param:GetParam1(), param:GetParam3(), 1, DOOR_DMY_ID_A );
	
	local ryosyu_list = {125, 126, 127, 128};
	RyosyuMove(proxy, ryosyu_list );
	
	--local tako_list = {161};
	--TakoMove(proxy, tako_list, 125 );
end

--------------------------------------------------------------------------------------
--■26■牢城扉26■--(1031) --EN:-- 26 ■ prison door 26 ■ --(1031)
--------------------------------------------------------------------------------------
function OnEvent_26  (proxy, param) 
	if EventNormalDoor(proxy, param, param:GetParam1(), param:GetParam2(), ITEMID_ROUGOKU_KEY_2, HELPID_ROUGOKU_KEY_2 ) == true then
		
		OnEvent_26_2(proxy,param);
	end
end
function OnEvent_26_2(proxy,param)
	print("OnEvent_26_2 begin");
	proxy:DeleteEvent( 151 );
	proxy:DeleteEvent( 152 );
	proxy:DeleteEvent( 153 );
	proxy:DeleteEvent( 158 );
	proxy:StopLoopAnimation( 646 );
	
	proxy:SetSpStayAndDamageAnimId( 646 , -1,-1);
	--ヴィライデル無敵解除 --EN:-- Release Villaidel Invincibility
	proxy:EnableInvincible( 646, false );
	proxy:SetSuperArmor( 646 , false );
	print("OnEvent_26_2 end");
end

--------------------------------------------------------------------------------------
--■27■牢城扉27■--(1032) --EN:-- 27 ■ prison door 27 ■ -- (1032)
--------------------------------------------------------------------------------------
function OnEvent_27  (proxy, param) EventNormalDoor(proxy, param, param:GetParam1(), param:GetParam2(), ITEMID_ROUGOKU_KEY_2, HELPID_ROUGOKU_KEY_2 ); end
function OnEvent_27_1(proxy,param) EventOpenDoor(proxy, param, param:GetParam1(), param:GetParam3(), 1, DOOR_DMY_ID_A ); end

--------------------------------------------------------------------------------------
--■28■牢城扉28■--(1033) --EN:-- 28 ■ prison door 28 ■ --(1033)
--------------------------------------------------------------------------------------
function OnEvent_28  (proxy, param) EventNormalDoor(proxy, param, param:GetParam1(), param:GetParam2(), ITEMID_ROUGOKU_KEY_2, HELPID_ROUGOKU_KEY_2 ); end
function OnEvent_28_1(proxy,param) EventOpenDoor(proxy, param, param:GetParam1(), param:GetParam3(), 1, DOOR_DMY_ID_A ); end

--------------------------------------------------------------------------------------
--■29■牢城扉29■--(1034) --EN:-- 29 ■ prison door 29 ■ -- (1034)
--------------------------------------------------------------------------------------
function OnEvent_29  (proxy, param)
	if EventNormalDoor(proxy, param, param:GetParam1(), param:GetParam2(), ITEMID_ROUGOKU_KEY_2, HELPID_ROUGOKU_KEY_2 ) == true then
		proxy:NotNetMessage_begin();
			proxy:OnKeyTime2( param:GetParam1(),"OnEvent_29_1",0.0,0,param:GetParam2(),once);
		proxy:NotNetMessage_end();
	end
end
function OnEvent_29_1(proxy,param)
	--EventOpenDoor(proxy, param, param:GetParam1(), param:GetParam3(), 1, DOOR_DMY_ID_A );
	local ryosyu_list = {130, 131};
	RyosyuMove(proxy, ryosyu_list );
	
	--local tako_list = {153, 154};
	--TakoMove(proxy, tako_list, 130 );
end

--------------------------------------------------------------------------------------
--■30■牢城扉30■--(1035) --EN:-- 30 ■ Prison door 30 ■ --(1035)
--------------------------------------------------------------------------------------
function OnEvent_30  (proxy, param) EventOpenDoor(proxy, param, param:GetParam1(), param:GetParam2(), 1, DOOR_DMY_ID_A ); end
--[[
function OnEvent_30  (proxy, param) EventNormalDoor(proxy, param, param:GetParam1(), param:GetParam2(), ITEMID_ROUGOKU_KEY_2, HELPID_ROUGOKU_KEY_2 ); end
function OnEvent_30_1(proxy,param)
	EventOpenDoor(proxy, param, param:GetParam1(), param:GetParam3(), 1, DOOR_DMY_ID_A );
	local ryosyu_list = {129};
	RyosyuMove(proxy, ryosyu_list );
	
	local tako_list = {153, 154};
	TakoMove(proxy, tako_list, 129 );
end
]]

--------------------------------------------------------------------------------------
--■31■牢城扉31■--(1036) --EN:-- 31 ■ prison door 31 ■ --(1036)
--------------------------------------------------------------------------------------
function OnEvent_31  (proxy, param) EventOpenDoor(proxy, param, param:GetParam1(), param:GetParam2(), 1, DOOR_DMY_ID_A ); end
--function OnEvent_31  (proxy, param) EventNormalDoor(proxy, param, param:GetParam1(), param:GetParam2(), ITEMID_ROUGOKU_KEY_2, HELPID_ROUGOKU_KEY_2 ); end
--function OnEvent_31_1(proxy,param) EventOpenDoor(proxy, param, param:GetParam1(), param:GetParam3(), 1, DOOR_DMY_ID_A ); end

--------------------------------------------------------------------------------------
--■32■牢城扉32■--(1037) --EN:-- 32 ■ prison door 32 ■ -- (1037)
--------------------------------------------------------------------------------------
function OnEvent_32  (proxy, param) EventOpenDoor(proxy, param, param:GetParam1(), param:GetParam2(), 1, DOOR_DMY_ID_A ); end
--function OnEvent_32  (proxy, param) EventNormalDoor(proxy, param, param:GetParam1(), param:GetParam2(), ITEMID_ROUGOKU_KEY_2, HELPID_ROUGOKU_KEY_2 ); end
--function OnEvent_32_1(proxy,param) EventOpenDoor(proxy, param, param:GetParam1(), param:GetParam3(), 1, DOOR_DMY_ID_A ); end

--------------------------------------------------------------------------------------
--■33■牢城扉33■--(1038) --EN:-- 33 ■ prison door 33 ■ -- (1038)
--------------------------------------------------------------------------------------
function OnEvent_33  (proxy, param)
	if EventNormalDoor(proxy, param, param:GetParam1(), param:GetParam2(), ITEMID_ROUGOKU_KEY_2, HELPID_ROUGOKU_KEY_2 ) == true then
		proxy:NotNetMessage_begin();
			proxy:OnKeyTime2( param:GetParam1(),"OnEvent_33_1",0.0,0,param:GetParam2(),once);
		proxy:NotNetMessage_end();
	end
end

function OnEvent_33_1(proxy,param)
	--EventOpenDoor(proxy, param, param:GetParam1(), param:GetParam3(), 1, DOOR_DMY_ID_A );
	local ryosyu_list = {132};
	RyosyuMove(proxy, ryosyu_list );
	
	--local tako_list = {153, 154};
	--TakoMove(proxy, tako_list, 132 );
end

--------------------------------------------------------------------------------------
--■34■牢城扉34■--(1039) --EN:-- 34 ■ prison door 34 ■ -- (1039)
--------------------------------------------------------------------------------------
function OnEvent_34  (proxy, param) EventNormalDoor(proxy, param, param:GetParam1(), param:GetParam2(), ITEMID_ROUGOKU_KEY_2, HELPID_ROUGOKU_KEY_2 ); end
function OnEvent_34_1(proxy,param) EventOpenDoor(proxy, param, param:GetParam1(), param:GetParam3(), 1, DOOR_DMY_ID_A ); end

--------------------------------------------------------------------------------------
--■35■牢城扉35■--(1040) --EN:-- 35 ■ prison door 35 ■ -- (1040)
--------------------------------------------------------------------------------------
function OnEvent_35  (proxy, param) EventNormalDoor(proxy, param, param:GetParam1(), param:GetParam2(), ITEMID_ROUGOKU_KEY_2, HELPID_ROUGOKU_KEY_2 ); end
function OnEvent_35_1(proxy,param) EventOpenDoor(proxy, param, param:GetParam1(), param:GetParam3(), 1, DOOR_DMY_ID_A ); end

--------------------------------------------------------------------------------------
--■36■牢城扉36■--(1041) --EN:-- 36 ■ prison door 36 ■ --(1041)
--------------------------------------------------------------------------------------
function OnEvent_36  (proxy, param) EventNormalDoor(proxy, param, param:GetParam1(), param:GetParam2(), ITEMID_ROUGOKU_KEY_2, HELPID_ROUGOKU_KEY_2 ); end
function OnEvent_36_1(proxy,param) EventOpenDoor(proxy, param, param:GetParam1(), param:GetParam3(), 1, DOOR_DMY_ID_A ); end

--------------------------------------------------------------------------------------
--■37■牢城扉37■--(1042) --EN:-- 37 ■ prison door 37 ■ --(1042)
--------------------------------------------------------------------------------------
function OnEvent_37  (proxy, param) EventOpenDoor(proxy, param, param:GetParam1(), param:GetParam2(), 1, DOOR_DMY_ID_A ); end
--function OnEvent_37  (proxy, param) EventNormalDoor(proxy, param, param:GetParam1(), param:GetParam2(), ITEMID_ROUGOKU_KEY_2, HELPID_ROUGOKU_KEY_2 ); end
--function OnEvent_37_1(proxy,param) EventOpenDoor(proxy, param, param:GetParam1(), param:GetParam3(), 1, DOOR_DMY_ID_A ); end

--------------------------------------------------------------------------------------
--■38■牢城扉38■--(1043) --EN:-- 38 ■ prison door 38 ■ -- (1043)
--------------------------------------------------------------------------------------
function OnEvent_38  (proxy, param) EventOpenDoor(proxy, param, param:GetParam1(), param:GetParam2(), 1, DOOR_DMY_ID_A ); end
--function OnEvent_38  (proxy, param) EventNormalDoor(proxy, param, param:GetParam1(), param:GetParam2(), ITEMID_ROUGOKU_KEY_2, HELPID_ROUGOKU_KEY_2 ); end
--function OnEvent_38_1(proxy,param) EventOpenDoor(proxy, param, param:GetParam1(), param:GetParam3(), 1, DOOR_DMY_ID_A ); end

--------------------------------------------------------------------------------------
--■39■牢城扉39■--(1044) --EN:-- 39 ■ prison door 39 ■ -- (1044)
--------------------------------------------------------------------------------------
function OnEvent_39  (proxy, param) EventOpenDoor(proxy, param, param:GetParam1(), param:GetParam2(), 1, DOOR_DMY_ID_A ); end
--function OnEvent_39  (proxy, param) EventNormalDoor(proxy, param, param:GetParam1(), param:GetParam2(), ITEMID_ROUGOKU_KEY_2, HELPID_ROUGOKU_KEY_2 ); end
--function OnEvent_39_1(proxy,param) EventOpenDoor(proxy, param, param:GetParam1(), param:GetParam3(), 1, DOOR_DMY_ID_A ); end

--------------------------------------------------------------------------------------
--■40■牢城扉40■--(1045) --EN:-- 40 ■ prison door 40 ■ --(1045)
--------------------------------------------------------------------------------------
function OnEvent_40  (proxy, param)
	if EventNormalDoor(proxy, param, param:GetParam1(), param:GetParam2(), ITEMID_ROUGOKU_KEY_2_B, HELPID_ROUGOKU_KEY_2_B ) == true then
		proxy:NotNetMessage_begin();
			proxy:OnKeyTime2( param:GetParam1(),"OnEvent_40_1",0.0,0,param:GetParam2(),once);
		proxy:NotNetMessage_end();
	end
end

function OnEvent_40_1(proxy,param)
	--EventOpenDoor(proxy, param, param:GetParam1(), param:GetParam3(), 1, DOOR_DMY_ID_A );
	local ryosyu_list = {133};
	RyosyuMove(proxy, ryosyu_list );
	
	--local tako_list = {157, 158, 159};
	--TakoMove(proxy, tako_list, 133 );
end

--------------------------------------------------------------------------------------
--■41■牢城扉41■--(1046) --EN:-- 41 ■ prison door 41 ■ --(1046)
--------------------------------------------------------------------------------------
function OnEvent_41  (proxy, param) EventOpenDoor(proxy, param, param:GetParam1(), param:GetParam2(), 1, DOOR_DMY_ID_A ); end
--function OnEvent_41  (proxy, param) EventNormalDoor(proxy, param, param:GetParam1(), param:GetParam2(), ITEMID_ROUGOKU_KEY_2, HELPID_ROUGOKU_KEY_2 ); end
--function OnEvent_41_1(proxy,param) EventOpenDoor(proxy, param, param:GetParam1(), param:GetParam3(), 1, DOOR_DMY_ID_A ); end

--------------------------------------------------------------------------------------
--■42■牢城扉42■--(1047) --EN:-- 42 ■ prison door 42 ■ -- (1047)
--------------------------------------------------------------------------------------
function OnEvent_42  (proxy, param) EventNormalDoor(proxy, param, param:GetParam1(), param:GetParam2(), ITEMID_ROUGOKU_KEY_2_B, HELPID_ROUGOKU_KEY_2_B ); end
function OnEvent_42_1(proxy,param) EventOpenDoor(proxy, param, param:GetParam1(), param:GetParam3(), 1, DOOR_DMY_ID_A ); end

--------------------------------------------------------------------------------------
--■43■牢城扉43■--(1048) --EN:-- 43 ■ Prison door 43 ■ --(1048)
--------------------------------------------------------------------------------------
function OnEvent_43  (proxy, param) EventNormalDoor(proxy, param, param:GetParam1(), param:GetParam2(), ITEMID_ROUGOKU_KEY_2_B, HELPID_ROUGOKU_KEY_2_B ); end
function OnEvent_43_1(proxy,param) EventOpenDoor(proxy, param, param:GetParam1(), param:GetParam3(), 1, DOOR_DMY_ID_A ); end

--------------------------------------------------------------------------------------
--■44■牢城扉44■--(1049) --EN:-- 44 ■ prison door 44 ■ -- (1049)
--------------------------------------------------------------------------------------
function OnEvent_44  (proxy, param) EventOpenDoor(proxy, param, param:GetParam1(), param:GetParam2(), 1, DOOR_DMY_ID_A ); end
--function OnEvent_44  (proxy, param) EventNormalDoor(proxy, param, param:GetParam1(), param:GetParam2(), ITEMID_ROUGOKU_KEY_2, HELPID_ROUGOKU_KEY_2 ); end
--function OnEvent_44_1(proxy,param) EventOpenDoor(proxy, param, param:GetParam1(), param:GetParam3(), 1, DOOR_DMY_ID_A ); end

--------------------------------------------------------------------------------------
--■45■牢城扉45■--(1050) --EN:-- 45 ■ prison door 45 ■ -- (1050)
--------------------------------------------------------------------------------------
function OnEvent_45  (proxy, param)
	if EventNormalDoor(proxy, param, param:GetParam1(), param:GetParam2(), ITEMID_ROUGOKU_KEY_2_B, HELPID_ROUGOKU_KEY_2_B ) == true then
		proxy:NotNetMessage_begin();
			proxy:OnKeyTime2( param:GetParam1(),"OnEvent_45_1",0.0,0,param:GetParam2(),once);
		proxy:NotNetMessage_end();
	end
end

function OnEvent_45_1(proxy,param)
	--EventOpenDoor(proxy, param, param:GetParam1(), param:GetParam3(), 1, DOOR_DMY_ID_A );
	local ryosyu_list = {136, 137, 138};
	RyosyuMove(proxy, ryosyu_list );
	
	--local tako_list = {157, 158, 159};
	--TakoMove(proxy, tako_list, 136 );
end

--------------------------------------------------------------------------------------
--■46■牢城扉46■--(1051) --EN:-- 46 ■ prison door 46 ■ -- (1051)
--------------------------------------------------------------------------------------
function OnEvent_46  (proxy, param) EventOpenDoor(proxy, param, param:GetParam1(), param:GetParam2(), 1, DOOR_DMY_ID_A ); end
--function OnEvent_46  (proxy, param) EventNormalDoor(proxy, param, param:GetParam1(), param:GetParam2(), ITEMID_ROUGOKU_KEY_2, HELPID_ROUGOKU_KEY_2 ); end
--function OnEvent_46_1(proxy,param) EventOpenDoor(proxy, param, param:GetParam1(), param:GetParam3(), 1, DOOR_DMY_ID_A ); end

--------------------------------------------------------------------------------------
--■47■牢城扉47■--(1052) --EN:-- 47 ■ prison door 47 ■ -- (1052)
--------------------------------------------------------------------------------------
function OnEvent_47  (proxy, param)
	if EventNormalDoor(proxy, param, param:GetParam1(), param:GetParam2(), ITEMID_ROUGOKU_KEY_2_B, HELPID_ROUGOKU_KEY_2_B ) == true then
		proxy:NotNetMessage_begin();
			proxy:OnKeyTime2( param:GetParam1(),"OnEvent_47_1",0.0,0,param:GetParam2(),once);
		proxy:NotNetMessage_end();
	end
end

function OnEvent_47_1(proxy,param)
	--EventOpenDoor(proxy, param, param:GetParam1(), param:GetParam3(), 1, DOOR_DMY_ID_A );
	local ryosyu_list = {134, 135};
	RyosyuMove(proxy, ryosyu_list );
	
	--local tako_list = {157, 158, 159};
	--TakoMove(proxy, tako_list, 134 );
end

--------------------------------------------------------------------------------------
--■48■牢城扉48■--(1053) --EN:-- 48 ■ prison door 48 ■ -- (1053)
--------------------------------------------------------------------------------------
function OnEvent_48  (proxy, param) EventOpenDoor(proxy, param, param:GetParam1(), param:GetParam2(), 1, DOOR_DMY_ID_A ); end
--function OnEvent_48  (proxy, param) EventNormalDoor(proxy, param, param:GetParam1(), param:GetParam2(), ITEMID_ROUGOKU_KEY_2, HELPID_ROUGOKU_KEY_2 ); end
--function OnEvent_48_1(proxy,param) EventOpenDoor(proxy, param, param:GetParam1(), param:GetParam3(), 1, DOOR_DMY_ID_A ); end

--------------------------------------------------------------------------------------
--■49■牢城扉49■--(1054) --EN:-- 49 ■ prison door 49 ■ -- (1054)
--------------------------------------------------------------------------------------
function OnEvent_49  (proxy, param) EventNormalDoor(proxy, param, param:GetParam1(), param:GetParam2(), ITEMID_ROUGOKU_KEY_2_B, HELPID_ROUGOKU_KEY_2_B ); end
function OnEvent_49_1(proxy,param) EventOpenDoor(proxy, param, param:GetParam1(), param:GetParam3(), 1, DOOR_DMY_ID_A ); end

--------------------------------------------------------------------------------------
--■50■牢城扉50■--(1061) --EN:-- 50 ■ Prison door 50 ■ --(1061)
--------------------------------------------------------------------------------------
function OnEvent_50  (proxy, param) EventNormalDoor(proxy, param, param:GetParam1(), param:GetParam2(), ITEMID_ROUGOKU_KEY_1, HELPID_ROUGOKU_KEY_1 ); end
function OnEvent_50_1(proxy,param) EventOpenDoor(proxy, param, param:GetParam1(), param:GetParam3(), 1, DOOR_DMY_ID_A ); end

--------------------------------------------------------------------------------------
--■51■牢城扉51■--(1062) --EN:-- 51 ■ prison door 51 ■ --(1062)
--------------------------------------------------------------------------------------
function OnEvent_51  (proxy, param) EventNormalDoor(proxy, param, param:GetParam1(), param:GetParam2(), ITEMID_ROUGOKU_KEY_1, HELPID_ROUGOKU_KEY_1 ); end
function OnEvent_51_1(proxy,param) EventOpenDoor(proxy, param, param:GetParam1(), param:GetParam3(), 1, DOOR_DMY_ID_A ); end

--------------------------------------------------------------------------------------
--■52■牢城扉52■--(1063) --EN:-- 52 ■ prison door 52 ■ -- (1063)
--------------------------------------------------------------------------------------
function OnEvent_52  (proxy, param) EventNormalDoor(proxy, param, param:GetParam1(), param:GetParam2(), ITEMID_ROUGOKU_KEY_1, HELPID_ROUGOKU_KEY_1 ); end
function OnEvent_52_1(proxy,param) EventOpenDoor(proxy, param, param:GetParam1(), param:GetParam3(), 1, DOOR_DMY_ID_A ); end

--------------------------------------------------------------------------------------
--■53■牢城扉53■--(1064) --EN:-- 53 ■ prison door 53 ■ --(1064)
--------------------------------------------------------------------------------------
function OnEvent_53  (proxy, param) EventNormalDoor(proxy, param, param:GetParam1(), param:GetParam2(), ITEMID_ROUGOKU_KEY_1, HELPID_ROUGOKU_KEY_1 ); end
function OnEvent_53_1(proxy,param) EventOpenDoor(proxy, param, param:GetParam1(), param:GetParam3(), 1, DOOR_DMY_ID_A ); end

--------------------------------------------------------------------------------------
--■54■牢城扉54■--(1065) --EN:-- 54 ■ prison door 54 ■ --(1065)
--------------------------------------------------------------------------------------
function OnEvent_54  (proxy, param) EventNormalDoor(proxy, param, param:GetParam1(), param:GetParam2(), ITEMID_ROUGOKU_KEY_1, HELPID_ROUGOKU_KEY_1 ); end
function OnEvent_54_1(proxy,param) EventOpenDoor(proxy, param, param:GetParam1(), param:GetParam3(), 1, DOOR_DMY_ID_A ); end

--------------------------------------------------------------------------------------
--■55■牢城扉55■--(1066) --EN:-- 55 ■ prison door 55 ■ -- (1066)
--------------------------------------------------------------------------------------
function OnEvent_55  (proxy, param) EventNormalDoor(proxy, param, param:GetParam1(), param:GetParam2(), ITEMID_ROUGOKU_KEY_1, HELPID_ROUGOKU_KEY_1 ); end
function OnEvent_55_1(proxy,param) EventOpenDoor(proxy, param, param:GetParam1(), param:GetParam3(), 1, DOOR_DMY_ID_A ); end

--------------------------------------------------------------------------------------
--■56■牢城扉56■--(1067) --EN:-- 56 ■ prison door 56 ■ -- (1067)
--------------------------------------------------------------------------------------
function OnEvent_56  (proxy, param) EventNormalDoor(proxy, param, param:GetParam1(), param:GetParam2(), ITEMID_ROUGOKU_KEY_1, HELPID_ROUGOKU_KEY_1 ); end
function OnEvent_56_1(proxy,param) EventOpenDoor(proxy, param, param:GetParam1(), param:GetParam3(), 1, DOOR_DMY_ID_A ); end

--------------------------------------------------------------------------------------
--■57■牢城扉57■--(1068) --EN:-- 57 ■ prison door 57 ■ --(1068)
--------------------------------------------------------------------------------------
function OnEvent_57  (proxy, param) EventNormalDoor(proxy, param, param:GetParam1(), param:GetParam2(), ITEMID_ROUGOKU_KEY_1, HELPID_ROUGOKU_KEY_1 ); end
function OnEvent_57_1(proxy,param) EventOpenDoor(proxy, param, param:GetParam1(), param:GetParam3(), 1, DOOR_DMY_ID_A ); end

--------------------------------------------------------------------------------------
--■58■牢城扉58■--(1069) --EN:-- 58 ■ prison door 58 ■ -- (1069)
--------------------------------------------------------------------------------------
function OnEvent_58  (proxy, param) EventNormalDoor(proxy, param, param:GetParam1(), param:GetParam2(), ITEMID_ROUGOKU_KEY_1, HELPID_ROUGOKU_KEY_1 ); end
function OnEvent_58_1(proxy,param) EventOpenDoor(proxy, param, param:GetParam1(), param:GetParam3(), 1, DOOR_DMY_ID_A ); end

--------------------------------------------------------------------------------------
--■59■牢城扉59■--(1070) --EN:-- 59 ■ prison door 59 ■ -- (1070)
--------------------------------------------------------------------------------------
function OnEvent_59  (proxy, param) EventNormalDoor(proxy, param, param:GetParam1(), param:GetParam2(), ITEMID_ROUGOKU_KEY_1, HELPID_ROUGOKU_KEY_1 ); end
function OnEvent_59_1(proxy,param) EventOpenDoor(proxy, param, param:GetParam1(), param:GetParam3(), 1, DOOR_DMY_ID_A ); end

--------------------------------------------------------------------------------------
--■60■牢城扉60■--(1071) --EN:-- 60 ■ Prison door 60 ■ --(1071)
--------------------------------------------------------------------------------------
function OnEvent_60  (proxy, param) EventNormalDoor(proxy, param, param:GetParam1(), param:GetParam2(), 1, DOOR_DMY_ID_A ); end

--------------------------------------------------------------------------------------
--■61■牢城扉61■--(1018) --EN:-- 61 ■ prison door 61 ■ --(1018)
--------------------------------------------------------------------------------------
function OnEvent_61  (proxy, param) EventOpenDoor(proxy, param, param:GetParam1(), param:GetParam2(), 1, DOOR_DMY_ID_A ); end
--function OnEvent_61  (proxy, param) EventNormalDoor(proxy, param, param:GetParam1(), param:GetParam2(), ITEMID_ROUGOKU_KEY_3, HELPID_ROUGOKU_KEY_3 ); end
--function OnEvent_61_1(proxy,param) EventOpenDoor(proxy, param, param:GetParam1(), param:GetParam3(), 1, DOOR_DMY_ID_A ); end

--------------------------------------------------------------------------------------
--■62■牢城扉62■--(1019) --EN:-- 62 ■ prison door 62 ■ --(1019)
--------------------------------------------------------------------------------------
function OnEvent_62  (proxy, param) EventOpenDoor(proxy, param, param:GetParam1(), param:GetParam2(), 1, DOOR_DMY_ID_A ); end
--function OnEvent_62  (proxy, param) EventNormalDoor(proxy, param, param:GetParam1(), param:GetParam2(), ITEMID_ROUGOKU_KEY_3, HELPID_ROUGOKU_KEY_3 ); end
--function OnEvent_62_1(proxy,param) EventOpenDoor(proxy, param, param:GetParam1(), param:GetParam3(), 1, DOOR_DMY_ID_A ); end

--------------------------------------------------------------------------------------
--■63■牢城扉63■--(1020) --EN:-- 63 ■ Prison door 63 ■ --(1020)
--------------------------------------------------------------------------------------
function OnEvent_63  (proxy, param) EventOpenDoor(proxy, param, param:GetParam1(), param:GetParam2(), 1, DOOR_DMY_ID_A ); end
--function OnEvent_63  (proxy, param) EventNormalDoor(proxy, param, param:GetParam1(), param:GetParam2(), ITEMID_ROUGOKU_KEY_3, HELPID_ROUGOKU_KEY_3 ); end
--function OnEvent_63_1(proxy,param) EventOpenDoor(proxy, param, param:GetParam1(), param:GetParam3(), 1, DOOR_DMY_ID_A ); end

--------------------------------------------------------------------------------------
--■64■牢城扉64■--(1029) --EN:-- 64 ■ prison door 64 ■ -- (1029)
--------------------------------------------------------------------------------------
function OnEvent_64  (proxy, param)
	if EventNormalDoor(proxy, param, param:GetParam1(), param:GetParam2(), ITEMID_ROUGOKU_KEY_3, HELPID_ROUGOKU_KEY_3 ) == true then
		proxy:NotNetMessage_begin();
			proxy:OnKeyTime2( param:GetParam1(),"OnEvent_64_1",0.0,0,param:GetParam2(),once);
		proxy:NotNetMessage_end();
	end
end

function OnEvent_64_1(proxy,param)
	--EventOpenDoor(proxy, param, param:GetParam1(), param:GetParam3(), 1, DOOR_DMY_ID_A );
	
	local ryosyu_list = {107, 108};
	RyosyuMove(proxy, ryosyu_list );
	
	--local tako_list = {160};
	--TakoMove(proxy, tako_list, 107 );
end

--------------------------------------------------------------------------------------
--■65■牢城扉65■--(1072) --EN:-- 65 ■ prison door 65 ■ -- (1072)
--------------------------------------------------------------------------------------
function OnEvent_65  (proxy, param) EventNormalDoor(proxy, param, param:GetParam1(), param:GetParam2(), ITEMID_ROUGOKU_KEY_1, HELPID_ROUGOKU_KEY_1 ); end
function OnEvent_65_1(proxy,param) EventOpenDoor(proxy, param, param:GetParam1(), param:GetParam3(), 1, DOOR_DMY_ID_A ); end

--------------------------------------------------------------------------------------
--■66■牢城扉66■--(1073) --EN:-- 66 ■ prison door 66 ■ -- (1073)
--------------------------------------------------------------------------------------
function OnEvent_66  (proxy, param) EventNormalDoor(proxy, param, param:GetParam1(), param:GetParam2(), ITEMID_ROUGOKU_KEY_1, HELPID_ROUGOKU_KEY_1 ); end
function OnEvent_66_1(proxy,param) EventOpenDoor(proxy, param, param:GetParam1(), param:GetParam3(), 1, DOOR_DMY_ID_A ); end

--------------------------------------------------------------------------------------
--■67■牢城扉67■--(1074) --EN:-- 67 ■ prison door 67 ■ -- (1074)
--------------------------------------------------------------------------------------
function OnEvent_67  (proxy, param) EventNormalDoor(proxy, param, param:GetParam1(), param:GetParam2(), ITEMID_ROUGOKU_KEY_1, HELPID_ROUGOKU_KEY_1 ); end
function OnEvent_67_1(proxy,param) EventOpenDoor(proxy, param, param:GetParam1(), param:GetParam3(), 1, DOOR_DMY_ID_A ); end

--------------------------------------------------------------------------------------
--■68■牢城扉68■--(1075) --EN:-- 68 ■ prison door 68 ■ -- (1075)
--------------------------------------------------------------------------------------
function OnEvent_68  (proxy, param) EventNormalDoor(proxy, param, param:GetParam1(), param:GetParam2(), ITEMID_ROUGOKU_KEY_1, HELPID_ROUGOKU_KEY_1 ); end
function OnEvent_68_1(proxy,param) EventOpenDoor(proxy, param, param:GetParam1(), param:GetParam3(), 1, DOOR_DMY_ID_A ); end

--------------------------------------------------------------------------------------
--■69■牢城扉69■--(1076) --EN:-- 69 ■ prison door 69 ■ -- (1076)
--------------------------------------------------------------------------------------
function OnEvent_69  (proxy, param) EventNormalDoor(proxy, param, param:GetParam1(), param:GetParam2(), ITEMID_ROUGOKU_KEY_1, HELPID_ROUGOKU_KEY_1 ); end
function OnEvent_69_1(proxy,param) EventOpenDoor(proxy, param, param:GetParam1(), param:GetParam3(), 1, DOOR_DMY_ID_A ); end

--------------------------------------------------------------------------------------
--■70■牢城扉70■--(1077) --EN:-- ■ 70 ■ prison door 70 ■ -- (1077)
--------------------------------------------------------------------------------------
function OnEvent_70  (proxy, param) EventNormalDoor(proxy, param, param:GetParam1(), param:GetParam2(), ITEMID_ROUGOKU_KEY_1, HELPID_ROUGOKU_KEY_1 ); end
function OnEvent_70_1(proxy,param) EventOpenDoor(proxy, param, param:GetParam1(), param:GetParam3(), 1, DOOR_DMY_ID_A ); end

--虜囚のロジックON、ロックオン不可OFFをまとめて行う --EN:--Powder's logic ON, lock-on disabled OFF all at once
function RyosyuMove( proxy, ryosyu_list )
	local ryosyu_num = table.getn( ryosyu_list );
	for index = 1, ryosyu_num, 1 do
		proxy:LuaCallStartPlus( 4057, 100, ryosyu_list[index] );
	end
end

--虜囚移動同期用 --EN:--For captive movement synchronization
--4057, 100, targetId
function RyosyuMove_call(proxy,param)
	proxy:EnableLogic( param:GetParam3(), true );--ロジックON --EN:--Logic ON
	proxy:EnableHide( param:GetParam3(), false );--索敵有効 --EN:--Enemy search enabled
	proxy:EnableInvincible( param:GetParam3(), false );--完全無敵解除 --EN:--Complete invincibility canceled
	--proxy:PlayAnimation( param:GetParam3(), 0 );--待機アニメ再生 --EN:--Play standby animation
	proxy:SetSpStayAndDamageAnimId( param:GetParam3() ,-1,-1);--特殊待機解除 --EN:--Cancel special standby
end

function TakoMove(proxy, tako_list, ryosyuId )
	local tako_num = table.getn( tako_list );
	for index = 1, tako_num, 1 do
		proxy:CustomLuaCallStartPlus( 1, ryosyuId, tako_list[index] );
	end
end

--タコ移動同期用 --EN:--For Octopus Movement Synchronization
--1, ryosyuId, takoId
function TakoMove_call(proxy,param)
	local ryosyuId = param:GetParam2();
	local takoId   = param:GetParam3();
	proxy:ResetThink(takoId);
	TurnTarget( proxy, takoId, ryosyuId, -1 );
end


--[[
--------------------------------------------------------------------------------------
--■100■虜囚脱獄１■ --EN:-- ■ 100 ■ Prisoner Prisoner Jailbreak 1 ■
--------------------------------------------------------------------------------------
--■100■虜囚脱獄１■ --EN:-- ■ 100 ■ Prisoner Prisoner Jailbreak 1 ■
function TakoCondition_1(proxy,param)
	local door_actionId_list 	= {  2,   2,   4,   7};
	local ryosyuu_list 			= {100, 115, 108, 116};
	
	TakoFunc( proxy, door_actionId_list, ryosyuu_list, 151 );
end

function TakoCondition_2(proxy,param)
	local door_actionId_list 	= { 11,  10,  12};
	local ryosyuu_list 			= {102, 103, 117};
	
	TakoFunc( proxy, door_actionId_list, ryosyuu_list, 160 );
end

function TakoCondition_3(proxy,param)
	local door_actionId_list 	= { 23,  23,  23,  25,  25};
	local ryosyuu_list 			= {107, 126, 127, 109, 128};
	
	TakoFunc( proxy, door_actionId_list, ryosyuu_list, 161 );
end

function TakoCondition_4(proxy,param)
	local door_actionId_list 	= { 31,  30,  28,  26};
	local ryosyuu_list 			= {110, 129, 111, 130};
	
	TakoFunc( proxy, door_actionId_list, ryosyuu_list, 154 );
end

function TakoCondition_5(proxy,param)
	local door_actionId_list 	= { 34};
	local ryosyuu_list 			= {112};
	
	TakoFunc( proxy, door_actionId_list, ryosyuu_list, 153 );
end

function TakoResult_dummy(proxy,param)
end

function TakoFunc( proxy, actId_list, ryosyuu_list, takoId )
	local alive_check_list 		= {  0,   0,   0,   0};
	local most_In_Id   = -1;
	local most_In_Dist = -1;
	local ryosyuu_num = table.getn( ryosyuu_list );
	for i = 0, ryosyuu_num, 1 do
		if proxy:IsCompleteEvent( actId_list[i] ) == true then
			if proxy:IsAlive( ryosyuu_list[i] ) == true then
				alive_check_list[i] = 1;
			end
		end
	end
	
	for i = 0, ryosyuu_num, 1 do
		if alive_check_list[i] == 1 then
			if  most_In_Dist < 0 or
				most_In_Dist > proxy:GetDistance( ryosyuu_list[i] ) then
				most_In_Id = ryosyuu_list[i];
			end
		end
	end
	
	if most_In_Id ~= -1 then
		--print("SetEventTarget to ",most_In_Id );
		proxy:SetEventTarget( takoId, most_In_Id );
		return true;
	end
	return false;
end
]]

--[[
function RyosyuuMoveFunc( proxy, eventId, targetId, regionId, ftime, frad, movetype )
	print("RyosyuuMoveFunc_"..targetId.." begin" );
	proxy:DisableInterupt( targetId, true );
	proxy:ResetThink( targetId );
	proxy:EnableHide( targetId, false );
	MoveRegion(proxy, targetId, regionId, ftime ,frad, movetype);
	
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( eventId, "RyosyuuMoveEnd", ftime, 0, targetId, once );
	proxy:NotNetMessage_end();
	print("RyosyuuMoveFunc_"..targetId.." end" );
end

function RyosyuuMoveEnd( proxy, param )
	print("RyosyuuMoveEnd_"..param:GetParam3().." begin" );
	proxy:DisableInterupt( param:GetParam3(), false );
	print("RyosyuuMoveEnd_"..param:GetParam3().." end" );
end
]]


--------------------------------------------------------------------------------------
--■200■鍵付き牢獄扉3F A■ --EN:--■200■Locked prison door 3F A■
--------------------------------------------------------------------------------------
--■200■鍵付き牢獄扉3F A■(メイン) --EN:--■200■Locked prison door 3F A■ (main)
function OnEvent_200(proxy, param)
	print("OnEvent_200 begin");
	
	--必要アイテムの指定 --EN:--Specify required items
	local KEY_ITEM_TYPE = TYPE_GOODS;
	local KEY_ITEM_ID   = 12;--3Fの鍵 --EN:--3F key
	
	
	--必要アイテムを所持している(インベントリーにアイテムとして所持している) --EN:--You have the necessary items (have them as items in your inventory)
	if proxy:IsInventoryEquip( KEY_ITEM_TYPE , KEY_ITEM_ID ) == true then
	--if proxy:IsCompleteEvent( KEY_ID_4F ) == true then
	
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			--▼639_1▼選択メニューの監視▼ --EN:--▼639_1▼Monitor selection menu▼
			proxy:OnSelectMenu(SYSTEM_GENDIALOG, "MenuClose", 10010806, 0, 6, 1080, GEN_DIALOG_DIST, once);
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
		OnEvent_200_1(proxy,param);

	--必要アイテムを所持していない --EN:--I don't have the required items
	else
		--扉が開かない場合のメッセージを表示 --EN:-- Display a message when the door does not open
		--proxy:InfomationMenu( INFOMENU_TYPE_SIMPLE, 0, MSG_CATEGORY_EVENT, 10010160, 1);
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010160, 0, 6, 1080, GEN_DIALOG_DIST, once );
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
		--proxy:ShowGenDialog(10010160,1,1,true);
	end
	
	print("OnEvent_200 end");
end

--■200_1■Yesが選択された■ --EN:-- ■ 200_1 ■ Yes was selected ■
function OnEvent_200_1(proxy, param)
	print("OnEvent_200_1 begin");

	--イベント発動を配信する為、LuaCallを噛ませる --EN:--Bite LuaCall to deliver event activation
	proxy:LuaCallStart( 200 , 2 );
	
	print("OnEvent_200_1 end");
end



--■200_2■鍵付き牢獄扉3F A(アニメーション同期用)■LuaCall定義 --EN:--■200_2■Locked prison door 3F A (for animation synchronization)■LuaCall definition
function OnEvent_200_2(proxy, param)
	print("OnEvent_200_2 begin");

	proxy:PlayAnimation( 1080, 1 );--扉が開くアニメーション --EN:-- Door opening animation
	
	
	proxy:DeleteEvent( 200 );
	--イベントフラグをたてる --EN:-- set event flag
	proxy:SetEventFlag( 200, true );
	--プレイヤーの同期アニメーション(true:パーティープレイヤーがアニメーションした) --EN:--Player synchronous animation (true: party player animated)
	if Luafunc_PlaySynchroAnimation( proxy, param, 7403 ) == true then
		print("OnEvent_200_2 end");	
		return;
	end

	proxy:WarpDmy( LOCAL_PLAYER , 1080 , DOOR_DMY_ID_A );
	
	print("OnEvent_200_2 end");
end




--------------------------------------------------------------------------------------
--■201■鍵付き牢獄扉4F A■ --EN:--■201■Locked prison door 4F A■
--------------------------------------------------------------------------------------
--■201■鍵付き牢獄扉4F A■(メイン) --EN:-- 201 Prison door with lock 4F A (main)
function OnEvent_201(proxy, param)
	print("OnEvent_201 begin");

	proxy:PlayAnimation( 1082, 1 );--扉が開くアニメーション --EN:-- Door opening animation
	
	proxy:SetEventFlag( 201, true );
	
	--プレイヤーの同期アニメーション(true:パーティープレイヤーがアニメーションした) --EN:--Player synchronous animation (true: party player animated)
	if Luafunc_PlaySynchroAnimation( proxy, param, 7403 ) == true then
		return;
	end

	proxy:WarpDmy( LOCAL_PLAYER , 1082 , DOOR_DMY_ID_A );

	print("OnEvent_201 end");
end


--------------------------------------------------------------------------------------
--■202■鍵付き牢獄扉4F B■ --EN:--■202■Locked prison door 4F B■
--------------------------------------------------------------------------------------
--■202■鍵付き牢獄扉4F B■(メイン) --EN:-- 202 Prison door with lock 4F B (main)
function OnEvent_202(proxy, param)
	print("OnEvent_202 begin");
	
	--必要アイテムの指定 --EN:--Specify required items
	local KEY_ITEM_TYPE = TYPE_GOODS;
	local KEY_ITEM_ID   = 13;--4Fの鍵 --EN:--4F key
	
	
	--必要アイテムを所持している(インベントリーにアイテムとして所持している) --EN:--You have the necessary items (have them as items in your inventory)
	if proxy:IsInventoryEquip( KEY_ITEM_TYPE , KEY_ITEM_ID ) == true then
	
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			--▼202_1▼選択メニューの監視▼ --EN:--▼202_1▼Select menu monitoring▼
			proxy:OnSelectMenu(SYSTEM_GENDIALOG, "MenuClose", 10010807, 0, 6, 1087, GEN_DIALOG_DIST, once);
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
		OnEvent_202_1(proxy,param);

	--必要アイテムを所持していない --EN:--I don't have the required items
	else
		--扉が開かない場合のメッセージを表示 --EN:-- Display a message when the door does not open
		--proxy:InfomationMenu( INFOMENU_TYPE_SIMPLE, 0, MSG_CATEGORY_EVENT, 10010160, 1);
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010160, 0, 6, 1087, GEN_DIALOG_DIST, once );
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();

		--proxy:ShowGenDialog(10010160,1,1,true);
	end
	
	print("OnEvent_202 end");
end

--■202_1■Yesが選択された■ --EN:-- ■ 202_1 ■ Yes was selected ■
function OnEvent_202_1(proxy, param)
	print("OnEvent_202_1 begin");

	--イベント発動を配信する為、LuaCallを噛ませる --EN:--Bite LuaCall to deliver event activation
	proxy:LuaCallStart( 202 , 2 );
	
	print("OnEvent_202_1 end");
end



--■202_2■鍵付き牢獄扉4F B(アニメーション同期用)■LuaCall定義 --EN:--■202_2■Locked prison door 4F B (for animation synchronization)■LuaCall definition
function OnEvent_202_2(proxy, param)
	print("OnEvent_202_2 begin");

	proxy:PlayAnimation( 1087, 1 );--扉が開くアニメーション --EN:-- Door opening animation
	
	
	proxy:DeleteEvent( 202 );
	--イベントフラグをたてる --EN:-- set event flag
	proxy:SetEventFlag( 202, true );
	--プレイヤーの同期アニメーション(true:パーティープレイヤーがアニメーションした) --EN:--Player synchronous animation (true: party player animated)
	if Luafunc_PlaySynchroAnimation( proxy, param, 7403 ) == true then
		print("OnEvent_202_2 end");	
		return;
	end

	proxy:WarpDmy( LOCAL_PLAYER , 1087 , DOOR_DMY_ID_A );
	
	print("OnEvent_202_2 end");
end




--------------------------------------------------------------------------------------
--■203■鍵付き牢獄扉4F■ --EN:--■203■Locked prison door 4F■
--------------------------------------------------------------------------------------
--■203■鍵付き牢獄扉4F■(メイン) --EN:--■203■Locked prison door 4F■ (main)
function OnEvent_203(proxy, param)
	print("OnEvent_203 begin");
	
	proxy:PlayAnimation( 1088, 1 );--扉が開くアニメーション --EN:-- Door opening animation
	
	proxy:DeleteEvent( 203 );
	
	--イベントフラグをたてる --EN:-- set event flag
	proxy:SetEventFlag( 203, true );
	
	--プレイヤーの同期アニメーション(true:パーティープレイヤーがアニメーションした) --EN:--Player synchronous animation (true: party player animated)
	if Luafunc_PlaySynchroAnimation( proxy, param, 7403 ) == true then
		print("OnEvent_203 end");	
		return;
	end

	proxy:WarpDmy( LOCAL_PLAYER , 1088 , DOOR_DMY_ID_A );
	
	print("OnEvent_203 end");
end



--[[
--------------------------------------------------------------------------------------
--■210■鍵付き牢獄扉4F C■ --EN:--■210■Locked prison door 4F C■
--------------------------------------------------------------------------------------
--■210■鍵付き牢獄扉4F C■(メイン) --EN:--■210■Locked prison door 4F C■ (main)
function OnEvent_210(proxy, param)
	print("OnEvent_210 begin");

	proxy:PlayAnimation( 1081, 1 );--扉が開くアニメーション --EN:-- Door opening animation
	
	proxy:SetEventFlag( 210, true );
	
	--プレイヤーの同期アニメーション(true:パーティープレイヤーがアニメーションした) --EN:--Player synchronous animation (true: party player animated)
	if Luafunc_PlaySynchroAnimation( proxy, param, 7403 ) == true then
		return;
	end

	proxy:WarpDmy( LOCAL_PLAYER , 1081 , DOOR_DMY_ID_A );

	print("OnEvent_210 end");
end

--------------------------------------------------------------------------------------
--■220■鍵付き牢獄扉2F A■ --EN:--■220■Locked prison door 2F A■
--------------------------------------------------------------------------------------
--■220■鍵付き牢獄扉2F A■(メイン) --EN:-- 220 Prison door with lock 2F A (main)
function OnEvent_220(proxy, param)
	print("OnEvent_220 begin");

	proxy:PlayAnimation( 1083, 1 );--扉が開くアニメーション --EN:-- Door opening animation
	proxy:SetEventFlag( 220, true );
	
	--プレイヤーの同期アニメーション(true:パーティープレイヤーがアニメーションした) --EN:--Player synchronous animation (true: party player animated)
	if Luafunc_PlaySynchroAnimation( proxy, param, 7403 ) == true then
		return;
	end

	proxy:WarpDmy( LOCAL_PLAYER , 1083 , DOOR_DMY_ID_A );

	print("OnEvent_220 end");
end

]]

--------------------------------------------------------------------------------------
--■230■鍵付き牢獄扉2F B■ --EN:--■230■Locked prison door 2F B■
--------------------------------------------------------------------------------------
--■230■鍵付き牢獄扉2F B■(メイン) --EN:-- 230 Prison door with lock 2F B (main)
function OnEvent_230(proxy, param)
	print("OnEvent_230 begin");

	--ヴィライデルイベントが終っていたら開くようになる --EN:--Will open when Villaidel event is over
	if	proxy:IsCompleteEvent(163) == true then
		--イベント発動を配信する為、LuaCallを噛ませる --EN:--Bite LuaCall to deliver event activation
		proxy:LuaCallStart( 230 , 1 );
	else
		--扉が開かない場合のメッセージを表示 --EN:-- Display a message when the door does not open
		--proxy:InfomationMenu( INFOMENU_TYPE_SIMPLE, 0, MSG_CATEGORY_EVENT, 10010160, 1);
		--proxy:ShowGenDialog(10010160,1,1,true);
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010160, 0, 6, 1084, GEN_DIALOG_DIST, once );
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
	end

	print("OnEvent_230 end");
end

function OnEvent_230_1(proxy,param)
	print("OnEvent_230_1 begin");
	
	proxy:PlayAnimation( 1084, 1 );--扉が開くアニメーション --EN:-- Door opening animation
	
	proxy:DeleteEvent( 230 );
	
	proxy:SetEventFlag( 230, 1 );
	--プレイヤーの同期アニメーション(true:パーティープレイヤーがアニメーションした) --EN:--Player synchronous animation (true: party player animated)
	if Luafunc_PlaySynchroAnimation( proxy, param, 7403 ) == true then
		return;
	end

	proxy:WarpDmy( LOCAL_PLAYER , 1084 , DOOR_DMY_ID_A	);

	print("OnEvent_230_1 end");
end

--------------------------------------------------------------------------------------
--■240■鍵付き牢獄扉1F A■ --EN:--■240■Locked prison door 1F A■
--------------------------------------------------------------------------------------
--■240■鍵付き牢獄扉1F A■(メイン) --EN:--■240■Locked prison door 1F A■ (main)
function OnEvent_240(proxy, param)
	print("OnEvent_240 begin");
	
	--必要アイテムの指定 --EN:--Specify required items
	local KEY_ITEM_TYPE = TYPE_GOODS;
	local KEY_ITEM_ID   = 10;--1Fの鍵 --EN:--1F key
	
	
	--必要アイテムを所持している(インベントリーにアイテムとして所持している) --EN:--You have the necessary items (have them as items in your inventory)
	if proxy:IsInventoryEquip( KEY_ITEM_TYPE , KEY_ITEM_ID ) == true then
	
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			--▼240_1▼選択メニューの監視▼ --EN:--▼240_1▼Select menu monitoring▼
			proxy:OnSelectMenu(SYSTEM_GENDIALOG, "MenuClose", 10010804, 0, 6, 1085, GEN_DIALOG_DIST, once);
			OnEvent_240_1(proxy,param);
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();

	--必要アイテムを所持していない --EN:--I don't have the required items
	else
		--扉が開かない場合のメッセージを表示 --EN:-- Display a message when the door does not open
		--proxy:InfomationMenu( INFOMENU_TYPE_SIMPLE, 0, MSG_CATEGORY_EVENT, 10010160, 1);
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010160, 0, 6, 1085, GEN_DIALOG_DIST, once );
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
		--proxy:ShowGenDialog(10010160,1,1,true);
	end
	
	print("OnEvent_240 end");
end

--■240_1■Yesが選択された■ --EN:-- 240_1 Yes selected
function OnEvent_240_1(proxy, param)
	print("OnEvent_240_1 begin");

	--イベント発動を配信する為、LuaCallを噛ませる --EN:--Bite LuaCall to deliver event activation
	proxy:LuaCallStart( 240 , 2 );
	
	print("OnEvent_240_1 end");
end



--■240_2■鍵付き牢獄扉3F A(アニメーション同期用)■LuaCall定義 --EN:--■240_2■Locked prison door 3F A (for animation synchronization)■LuaCall definition
function OnEvent_240_2(proxy, param)
	print("OnEvent_240_2 begin");

	proxy:PlayAnimation( 1085, 1 );--扉が開くアニメーション --EN:-- Door opening animation
	
	
	proxy:DeleteEvent( 240 );
	--イベントフラグをたてる --EN:-- set event flag
	proxy:SetEventFlag( 240, true );
	--プレイヤーの同期アニメーション(true:パーティープレイヤーがアニメーションした) --EN:--Player synchronous animation (true: party player animated)
	if Luafunc_PlaySynchroAnimation( proxy, param, 7403 ) == true then
		print("OnEvent_240_2 end");	
		return;
	end

	proxy:WarpDmy( LOCAL_PLAYER , 1085 , DOOR_DMY_ID_A );
	
	print("OnEvent_240_2 end");
end


--------------------------------------------------------------------------------------
--■250■鍵付き牢獄扉1F B■ --EN:--■250■Locked prison door 1F B■
--------------------------------------------------------------------------------------
function OnEvent_250(proxy, param)
	print("OnEvent_250 begin");
	
	--必要アイテムの指定 --EN:--Specify required items
	local KEY_ITEM_TYPE = TYPE_GOODS;
	local KEY_ITEM_ID   = 10;--1Fの鍵 --EN:--1F key
	
	
	--必要アイテムを所持している(インベントリーにアイテムとして所持している) --EN:--You have the necessary items (have them as items in your inventory)
	if proxy:IsInventoryEquip( KEY_ITEM_TYPE , KEY_ITEM_ID ) == true then
		
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			--▼250_1▼選択メニューの監視▼ --EN:--▼250_1▼Select menu monitoring▼
			proxy:OnSelectMenu(SYSTEM_GENDIALOG, "MenuClose", 10010804, 0, 6, 1086, GEN_DIALOG_DIST, once);
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
		OnEvent_250_1(proxy,param);

	--必要アイテムを所持していない --EN:--I don't have the required items
	else
		--扉が開かない場合のメッセージを表示 --EN:-- Display a message when the door does not open
		--proxy:InfomationMenu( INFOMENU_TYPE_SIMPLE, 0, MSG_CATEGORY_EVENT, 10010160, 1);
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010160, 0, 6, 1086, GEN_DIALOG_DIST, once );
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
		--proxy:ShowGenDialog(10010160,1,1,true);
	end
	
	print("OnEvent_250 end");
end

--■250_1■Yesが選択された■ --EN:-- 250_1 Yes was selected
function OnEvent_250_1(proxy, param)
	print("OnEvent_250_1 begin");

	--イベント発動を配信する為、LuaCallを噛ませる --EN:--Bite LuaCall to deliver event activation
	proxy:LuaCallStart( 250 , 2 );
	
	print("OnEvent_250_1 end");
end



--■250_2■鍵付き牢獄扉3F A(アニメーション同期用)■LuaCall定義 --EN:--■250_2■Locked prison door 3F A (for animation synchronization)■LuaCall definition
function OnEvent_250_2(proxy, param)
	print("OnEvent_250_2 begin");

	proxy:PlayAnimation( 1086, 1 );--扉が開くアニメーション --EN:-- Door opening animation
	proxy:DeleteEvent( 250 );
	
	--イベントフラグをたてる --EN:-- set event flag
	proxy:SetEventFlag( 250, true );
	
	--プレイヤーの同期アニメーション(true:パーティープレイヤーがアニメーションした) --EN:--Player synchronous animation (true: party player animated)
	if Luafunc_PlaySynchroAnimation( proxy, param, 7403 ) == true then
		print("OnEvent_250_2 end");	
		return;
	end

	proxy:WarpDmy( LOCAL_PLAYER , 1086 , DOOR_DMY_ID_A );
	
	print("OnEvent_250_2 end");
end


--[[
--------------------------------------------------------------------------------------
--■260■鍵付き牢獄扉3F A■ --EN:--■260■Locked prison door 3F A■
--------------------------------------------------------------------------------------

--■260_1■鍵付き牢獄扉3F A(アニメーション同期用)■LuaCall定義 --EN:--■260_1■Locked prison door 3F A (for animation synchronization)■LuaCall definition
function OnEvent_260_1(proxy, param)
	print("OnEvent_260_1 begin");

	proxy:PlayAnimation( 1080, 1 );--扉が開くアニメーション --EN:-- Door opening animation
	
	--プレイヤーの同期アニメーション(true:パーティープレイヤーがアニメーションした) --EN:--Player synchronous animation (true: party player animated)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_OPEN ) == true then
		proxy:SetEventFlag( 260, 1 );
		proxy:DeleteEvent( 260 );
		print("OnEvent_260_1 end");	
		return;
	end

	proxy:WarpDmy( LOCAL_PLAYER , 1080 , DOOR_DMY_ID_A );
	proxy:SetEventFlag( 260 , 1 );

	print("OnEvent_260_1 end");
end



--■260■鍵付き牢獄扉3F A■(メイン) --EN:--■260■Locked prison door 3F A■ (main)
function OnEvent_260(proxy, param)
	print("OnEvent_260 begin");

	if proxy:IsCompleteEvent( 260 ) == true then
		return;
	end
	
	--鍵を持っているとき --EN:--when you have the key
	if proxy:IsCompleteEvent( KEY_ID_3F ) == true then

		proxy:LuaCallStart( 260 , 1 );--アニメーションの同期再生(全体に配信) --EN:-- Synchronous animation playback (distributed to all)
		proxy:DeleteEvent( 260 );
	
	--鍵をもっていないとき --EN:--When you don't have the key
	else
	end

	print("OnEvent_260 end");
end
]]

--------------------------------------------------------------------------------------
--■270■鍵付き牢獄扉中2F A■ --EN:--■270■Locked prison door 2F A■
--------------------------------------------------------------------------------------
--■270■鍵付き牢獄扉中2F A■ --EN:--■270■Locked prison door 2F A■
function OnEvent_270(proxy, param)
	print("OnEvent_270 begin");
	
	--必要アイテムの指定 --EN:--Specify required items
	local KEY_ITEM_TYPE = TYPE_GOODS;
	local KEY_ITEM_ID   = 14;--中2Fの鍵 --EN:-- Inside 2F key
	
	
	--必要アイテムを所持している(インベントリーにアイテムとして所持している) --EN:--You have the necessary items (have them as items in your inventory)
	if proxy:IsInventoryEquip( KEY_ITEM_TYPE , KEY_ITEM_ID ) == true then
	
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			--▼270_1▼選択メニューの監視▼ --EN:--▼270_1▼Select menu monitoring▼
			proxy:OnSelectMenu(SYSTEM_GENDIALOG, "MenuClose", 10010808, 0, 6, 1091, GEN_DIALOG_DIST, once);
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
		OnEvent_270_1(proxy,param);

	--必要アイテムを所持していない --EN:--I don't have the required items
	else
		--扉が開かない場合のメッセージを表示 --EN:-- Display a message when the door does not open
		--proxy:InfomationMenu( INFOMENU_TYPE_SIMPLE, 0, MSG_CATEGORY_EVENT, 10010160, 1);
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010160, 0, 6, 1091, GEN_DIALOG_DIST, once );
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
		--proxy:ShowGenDialog(10010160,1,1,true);
	end
	
	print("OnEvent_270 end");
end

--■270_1■Yesが選択された■ --EN:-- 270_1 Yes was selected
function OnEvent_270_1(proxy, param)
	print("OnEvent_270_1 begin");

	--イベント発動を配信する為、LuaCallを噛ませる --EN:--Bite LuaCall to deliver event activation
	proxy:LuaCallStart( 270 , 2 );
	
	print("OnEvent_270_1 end");
end



--■270_2■鍵付き牢獄扉3F A(アニメーション同期用)■LuaCall定義 --EN:--■270_2■Locked prison door 3F A (for animation synchronization)■LuaCall definition
function OnEvent_270_2(proxy, param)
	print("OnEvent_270_2 begin");

	proxy:PlayAnimation( 1091, 1 );--扉が開くアニメーション --EN:-- Door opening animation
	proxy:DeleteEvent( 270 );
	proxy:DeleteEvent( 271 );
	
	--イベントフラグをたてる --EN:-- set event flag
	proxy:SetEventFlag( 270, true );
	proxy:SetEventFlag( 271, true );
	
	--プレイヤーの同期アニメーション(true:パーティープレイヤーがアニメーションした) --EN:--Player synchronous animation (true: party player animated)
	if Luafunc_PlaySynchroAnimation( proxy, param, 7403 ) == true then
		print("OnEvent_270_2 end");	
		return;
	end

	proxy:WarpDmy( LOCAL_PLAYER , 1091 , DOOR_DMY_ID_B );
	
	print("OnEvent_270_2 end");
end

--------------------------------------------------------------------------------------
--■271■鍵付き牢獄扉中2F A裏側■ --EN:--■271■ Locked prison door, inside 2F A back side■
--------------------------------------------------------------------------------------
--■271■鍵付き牢獄扉中2F A裏側■ --EN:--■271■ Locked prison door, inside 2F A back side■
function OnEvent_271(proxy, param)
	print("OnEvent_271 begin");
	
	--必要アイテムの指定 --EN:--Specify required items
	local KEY_ITEM_TYPE = TYPE_GOODS;
	local KEY_ITEM_ID   = 14;--中2Fの鍵 --EN:-- Inside 2F key
	
	
	--必要アイテムを所持している(インベントリーにアイテムとして所持している) --EN:--You have the necessary items (have them as items in your inventory)
	if proxy:IsInventoryEquip( KEY_ITEM_TYPE , KEY_ITEM_ID ) == true then
	
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			--▼271_1▼選択メニューの監視▼ --EN:--▼271_1▼Monitor selection menu▼
			proxy:OnSelectMenu(SYSTEM_GENDIALOG, "MenuClose", 10010808, 0, 6, 1091, GEN_DIALOG_DIST, once);
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
		OnEvent_271_1(proxy,param);

	--必要アイテムを所持していない --EN:--I don't have the required items
	else
		--扉が開かない場合のメッセージを表示 --EN:-- Display a message when the door does not open
		--proxy:InfomationMenu( INFOMENU_TYPE_SIMPLE, 0, MSG_CATEGORY_EVENT, 10010160, 1);
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010160, 0, 6, 1091, GEN_DIALOG_DIST, once );
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
		--proxy:ShowGenDialog(10010160,1,1,true);
	end
	
	print("OnEvent_271 end");
end

--■271_1■Yesが選択された■ --EN:--■271_1■Yes was selected■
function OnEvent_271_1(proxy, param)
	print("OnEvent_271_1 begin");

	--イベント発動を配信する為、LuaCallを噛ませる --EN:--Bite LuaCall to deliver event activation
	proxy:LuaCallStart( 271 , 2 );
	
	print("OnEvent_271_1 end");
end



--■271_2■鍵付き牢獄扉3F A(アニメーション同期用)■LuaCall定義 --EN:--■271_2■Locked prison door 3F A (for animation synchronization)■LuaCall definition
function OnEvent_271_2(proxy, param)
	print("OnEvent_271_2 begin");

	proxy:PlayAnimation( 1091, 1 );--扉が開くアニメーション --EN:-- Door opening animation
	proxy:DeleteEvent( 270 );
	proxy:DeleteEvent( 271 );
	
	--イベントフラグをたてる --EN:-- set event flag
	proxy:SetEventFlag( 270, true );
	proxy:SetEventFlag( 271, true );
	
	--プレイヤーの同期アニメーション(true:パーティープレイヤーがアニメーションした) --EN:--Player synchronous animation (true: party player animated)
	if Luafunc_PlaySynchroAnimation( proxy, param, 7403 ) == true then
		print("OnEvent_271_2 end");	
		return;
	end

	proxy:WarpDmy( LOCAL_PLAYER , 1091 , DOOR_DMY_ID_A );
	
	print("OnEvent_271_2 end");
end



--------------------------------------------------------------------------------------
--■280■鍵付き牢獄扉中2F B■ --EN:--■280■Locked prison door 2F B■
--------------------------------------------------------------------------------------
--■280■鍵付き牢獄扉中2F B■ --EN:--■280■Locked prison door 2F B■
function OnEvent_280(proxy, param)
	print("OnEvent_280 begin");
	
	--必要アイテムの指定 --EN:--Specify required items
	local KEY_ITEM_TYPE = TYPE_GOODS;
	local KEY_ITEM_ID   = 14;--中2Fの鍵 --EN:-- Inside 2F key
	
	
	--必要アイテムを所持している(インベントリーにアイテムとして所持している) --EN:--You have the necessary items (have them as items in your inventory)
	if proxy:IsInventoryEquip( KEY_ITEM_TYPE , KEY_ITEM_ID ) == true then
	
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			--▼280_1▼選択メニューの監視▼ --EN:--▼280_1▼Monitor selection menu▼
			proxy:OnSelectMenu(SYSTEM_GENDIALOG, "MenuClose", 10010808, 0, 6, 1092, GEN_DIALOG_DIST, once);
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
		OnEvent_280_1(proxy,param);

	--必要アイテムを所持していない --EN:--I don't have the required items
	else
		--扉が開かない場合のメッセージを表示 --EN:-- Display a message when the door does not open
		--proxy:InfomationMenu( INFOMENU_TYPE_SIMPLE, 0, MSG_CATEGORY_EVENT, 10010160, 1);
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010160, 0, 6, 1092, GEN_DIALOG_DIST, once );
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
		--proxy:ShowGenDialog(10010160,1,1,true);
	end
	
	print("OnEvent_280 end");
end

--■280_1■Yesが選択された■ --EN:-- 280_1 Yes was selected
function OnEvent_280_1(proxy, param)
	print("OnEvent_280_1 begin");

	--イベント発動を配信する為、LuaCallを噛ませる --EN:--Bite LuaCall to deliver event activation
	proxy:LuaCallStart( 280 , 2 );
	
	print("OnEvent_280_1 end");
end



--■280_2■鍵付き牢獄扉3F A(アニメーション同期用)■LuaCall定義 --EN:--■280_2■Locked prison door 3F A (for animation synchronization)■LuaCall definition
function OnEvent_280_2(proxy, param)
	print("OnEvent_280_2 begin");

	proxy:PlayAnimation( 1092, 1 );--扉が開くアニメーション --EN:-- Door opening animation
	proxy:DeleteEvent( 280 );
	proxy:DeleteEvent( 281 );
	
	--イベントフラグをたてる --EN:-- set event flag
	proxy:SetEventFlag( 280, true );
	proxy:SetEventFlag( 281, true );
	
	--プレイヤーの同期アニメーション(true:パーティープレイヤーがアニメーションした) --EN:--Player synchronous animation (true: party player animated)
	if Luafunc_PlaySynchroAnimation( proxy, param, 7403 ) == true then
		print("OnEvent_280_2 end");	
		return;
	end

	proxy:WarpDmy( LOCAL_PLAYER , 1092 , DOOR_DMY_ID_B );
	
	print("OnEvent_280_2 end");
end


--------------------------------------------------------------------------------------
--■281■鍵付き牢獄扉中2F B裏側■ --EN:--■ 281 ■ Locked prison door, inside 2F B back side ■
--------------------------------------------------------------------------------------
--■281■鍵付き牢獄扉中2F B裏側■ --EN:--■ 281 ■ Locked prison door, inside 2F B back side ■
function OnEvent_281(proxy, param)
	print("OnEvent_281 begin");
	
	--必要アイテムの指定 --EN:--Specify required items
	local KEY_ITEM_TYPE = TYPE_GOODS;
	local KEY_ITEM_ID   = 14;--中2Fの鍵 --EN:-- Inside 2F key
	
	
	--必要アイテムを所持している(インベントリーにアイテムとして所持している) --EN:--You have the necessary items (have them as items in your inventory)
	if proxy:IsInventoryEquip( KEY_ITEM_TYPE , KEY_ITEM_ID ) == true then
	
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			--▼281_1▼選択メニューの監視▼ --EN:--▼281_1▼Monitor selection menu▼
			proxy:OnSelectMenu(SYSTEM_GENDIALOG, "MenuClose", 10010808, 0, 6, 1092, GEN_DIALOG_DIST, once);
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
		OnEvent_281_1(proxy,param);

	--必要アイテムを所持していない --EN:--I don't have the required items
	else
		--扉が開かない場合のメッセージを表示 --EN:-- Display a message when the door does not open
		--proxy:InfomationMenu( INFOMENU_TYPE_SIMPLE, 0, MSG_CATEGORY_EVENT, 10010160, 1);
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010160, 0, 6, 1092, GEN_DIALOG_DIST, once );
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
		--proxy:ShowGenDialog(10010160,1,1,true);
	end
	
	print("OnEvent_281 end");
end

--■281_1■Yesが選択された■ --EN:-- 281_1 Yes selected
function OnEvent_281_1(proxy, param)
	print("OnEvent_280_1 begin");

	--イベント発動を配信する為、LuaCallを噛ませる --EN:--Bite LuaCall to deliver event activation
	proxy:LuaCallStart( 281 , 2 );
	
	print("OnEvent_281_1 end");
end



--■281_2■鍵付き牢獄扉3F A(アニメーション同期用)■LuaCall定義 --EN:--■281_2■Locked prison door 3F A (for animation synchronization)■LuaCall definition
function OnEvent_281_2(proxy, param)
	print("OnEvent_281_2 begin");

	proxy:PlayAnimation( 1092, 1 );--扉が開くアニメーション --EN:-- Door opening animation
	proxy:DeleteEvent( 280 );
	proxy:DeleteEvent( 281 );
	
	--イベントフラグをたてる --EN:-- set event flag
	proxy:SetEventFlag( 280, true );
	proxy:SetEventFlag( 281, true );
	
	--プレイヤーの同期アニメーション(true:パーティープレイヤーがアニメーションした) --EN:--Player synchronous animation (true: party player animated)
	if Luafunc_PlaySynchroAnimation( proxy, param, 7403 ) == true then
		print("OnEvent_281_2 end");	
		return;
	end

	proxy:WarpDmy( LOCAL_PLAYER , 1092 , DOOR_DMY_ID_A );
	
	print("OnEvent_281_2 end");
end



--------------------------------------------------------------------------------------
--■290■鍵付き牢獄扉中2F C■ --EN:--■ 290 ■ Locked prison door 2F C ■
--------------------------------------------------------------------------------------
--■290■鍵付き牢獄扉中2F C■(メイン) --EN:--■ 290 ■ Locked prison door 2F C ■ (main)
function OnEvent_290(proxy, param)
	print("OnEvent_290 begin");

	proxy:PlayAnimation( 1093, 1 );--扉が開くアニメーション --EN:-- Door opening animation
	
	proxy:SetEventFlag( 290, true );
	--プレイヤーの同期アニメーション(true:パーティープレイヤーがアニメーションした) --EN:--Player synchronous animation (true: party player animated)
	if Luafunc_PlaySynchroAnimation( proxy, param, 7403 ) == true then
		return;
	end

	proxy:WarpDmy( LOCAL_PLAYER , 1093 , DOOR_DMY_ID_A );

	print("OnEvent_290 end");
end

--------------------------------------------------------------------------------------
--■300■鍵付き牢獄扉中2F D■ --EN:--■300■Locked prison door 2F D■
--------------------------------------------------------------------------------------
--■300■鍵付き牢獄扉中2F D■(メイン) --EN:--■300■ Locked prison door 2F D■ (main)
function OnEvent_300(proxy, param)
	print("OnEvent_300 begin");

	proxy:PlayAnimation( 1094, 1 );--扉が開くアニメーション --EN:-- Door opening animation
	
	proxy:SetEventFlag( 300, true );
	--プレイヤーの同期アニメーション(true:パーティープレイヤーがアニメーションした) --EN:--Player synchronous animation (true: party player animated)
	if Luafunc_PlaySynchroAnimation( proxy, param, 7403 ) == true then
		return;
	end

	proxy:WarpDmy( LOCAL_PLAYER , 1094 , DOOR_DMY_ID_A );

	print("OnEvent_300 end");
end





--------------------------------------------------------------------------------------
--■310■監獄扉(中2F)■ --EN:-- ■ 310 ■ Prison Door (Middle 2F) ■
--------------------------------------------------------------------------------------
--■310■監獄扉(中2F)■ --EN:-- ■ 310 ■ Prison Door (Middle 2F) ■
function OnEvent_310(proxy, param) EventOpenDoor(proxy, param, 310, 1090, 1, DOOR_DMY_ID_A ); end


--------------------------------------------------------------------------------------
--■315■教会上部扉A■ --EN:--■315■Church Upper Door A■
--------------------------------------------------------------------------------------
--■315■教会上部扉A■ --EN:--■315■Church Upper Door A■
function OnEvent_315(proxy, param) EventOpenDoor(proxy, param, 315, 1096, 1, DOOR_DMY_ID_A ); end


--------------------------------------------------------------------------------------
--■320■教会上部扉B■ --EN:--■320■Church top door B■
--------------------------------------------------------------------------------------
--■320■教会上部扉B■ --EN:--■320■Church top door B■
function OnEvent_320(proxy, param) EventOpenDoor(proxy, param, 320, 1097, 1, DOOR_DMY_ID_A ); end


--------------------------------------------------------------------------------------
--■326■牢城の鍵3F■ --EN:--■ 326 ■ Prison Castle Key 3F ■
--------------------------------------------------------------------------------------
--■326■牢城の鍵3F■ --EN:--■ 326 ■ Prison Castle Key 3F ■
function OnEvent_326(proxy,param)
	print("OnEvent_326 begin");
	
	proxy:SetDrawEnable( 1110, false );
	proxy:SetColiEnable( 1110, false );
	proxy:TreasureDispModeChange2( 1110, false ,KAGI_SFX);
	proxy:SetEventFlag( 326, true );

	if	Luafunc_PlaySynchroAnimation(proxy, param, ANIMEID_PICK ) == true then
		return;
	end
	
	proxy:GetRateItem( 10502 );
	
	print("OnEvent_326 end");
end

--------------------------------------------------------------------------------------
--■327■牢城の鍵3F■ --EN:--■ 327 ■ Prison Castle Key 3F ■
--------------------------------------------------------------------------------------
--■327■牢城の鍵3F■ --EN:--■ 327 ■ Prison Castle Key 3F ■
function OnEvent_327(proxy,param)
	print("OnEvent_327 begin");
	
	proxy:SetDrawEnable( 1111, false );
	proxy:SetColiEnable( 1111, false );
	proxy:TreasureDispModeChange2( 1111, false ,KAGI_SFX);
	proxy:SetEventFlag( 327, true );

	if	Luafunc_PlaySynchroAnimation(proxy, param, ANIMEID_PICK ) == true then
		return;
	end
	
	proxy:GetRateItem( 10503 );
	proxy:GetRateItem( 10556 );
	
	print("OnEvent_327 end");
end

--------------------------------------------------------------------------------------
--■328■牢城の鍵3F■ --EN:--■ 328 ■ Prison Castle Key 3F ■
--------------------------------------------------------------------------------------
--■328■牢城の鍵3F■ --EN:--■ 328 ■ Prison Castle Key 3F ■
function OnEvent_328(proxy,param)
	print("OnEvent_328 begin");
	
	proxy:SetDrawEnable( 1112, false );
	proxy:SetColiEnable( 1112, false );
	proxy:TreasureDispModeChange2( 1112, false ,KAGI_SFX);
	proxy:SetEventFlag( 328, true );
	
	if	Luafunc_PlaySynchroAnimation(proxy, param, ANIMEID_PICK ) == true then
		return;
	end
	
	proxy:GetRateItem( 10500 );
	proxy:GetRateItem( 10553 );
	
	print("OnEvent_328 end");
end

--------------------------------------------------------------------------------------
--■329■牢城の鍵3F■ --EN:--■ 329 ■ Prison Castle Key 3F ■
--------------------------------------------------------------------------------------
--■329■牢城の鍵3F■ --EN:--■ 329 ■ Prison Castle Key 3F ■
function OnEvent_329(proxy,param)
	print("OnEvent_329 begin");
	
	proxy:SetDrawEnable( 1113, false );
	proxy:SetColiEnable( 1113, false );
	proxy:TreasureDispModeChange2( 1113, false ,KAGI_SFX);
	proxy:SetEventFlag( 329, true );
	
	if	Luafunc_PlaySynchroAnimation(proxy, param, ANIMEID_PICK ) == true then
		return;
	end
	
	proxy:GetRateItem( 10555 );
	
	print("OnEvent_329 end");
end

--------------------------------------------------------------------------------------
--■331■ロガーンの鍵■ --EN:--■331■Logan's Key■
--------------------------------------------------------------------------------------
--■331■ロガーンの鍵■ --EN:--■331■Logan's Key■
function OnEvent_331(proxy,param)
	print("OnEvent_331 begin");
	proxy:SetDrawEnable( 1114, false );
	proxy:SetColiEnable( 1114, false );
	proxy:TreasureDispModeChange2( 1114, false ,KAGI_SFX);
	proxy:SetEventFlag( 331, true );
	
	if	Luafunc_PlaySynchroAnimation(proxy, param, ANIMEID_PICK ) == true then
		return;
	end
	
	proxy:GetRateItem( 10594 );
	print("OnEvent_331 end");
end


--■332■槍虜囚牢屋の前■ --EN:--■ 332 ■ In front of the spear prisoner ■
function OnEvent_332(proxy,param)
	print("OnEvent_332 begin");
	proxy:PlayAnimation( 141, 3000 );
	proxy:PlayAnimation( 142, 3000 );
	if	proxy:IsClient() == false then
		proxy:NotNetMessage_begin();
			proxy:OnKeyTime2( 332, "OnEvent_332_ryosyuA_0", SpearRyosyuA_wait, 0, 10, once );
			proxy:OnKeyTime2( 332, "OnEvent_332_ryosyuB_0", SpearRyosyuB_wait, 0, 20, once );
		proxy:NotNetMessage_end();
	end
	print("OnEvent_332 end");
end

--■333■槍虜囚牢屋の中■ --EN:-- ■ 333 ■ Inside the spear prisoner ■
function OnEvent_333(proxy,param)
	print("OnEvent_333 begin");
	proxy:DeleteEvent( 332 );
	proxy:DeleteEvent( 334 );
	
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 333, "OnEvent_333_A", 0.1, 0, 1, once );
		proxy:OnKeyTime2( 333, "OnEvent_333_B", 0.6, 0, 2, once );
	proxy:NotNetMessage_end();
	proxy:SetEventFlag( 333, true );
	print("OnEvent_333 end");
end

function OnEvent_333_A(proxy,param)
	print("OnEvent_333_A begin");
	proxy:LuaCallStart( 333, 1 );
	print("OnEvent_333_A end");
end

function OnEvent_333_B(proxy,param)
	print("OnEvent_333_B begin");
	proxy:LuaCallStart( 333, 2 );
	print("OnEvent_333_B end");
end

function OnEvent_333_AnimA(proxy,param)
	print("OnEvent_333_AnimA begin");
	proxy:ForcePlayAnimation( 141, 3301);
	print("OnEvent_333_AnimA end");
end
function OnEvent_333_AnimB(proxy,param)
	print("OnEvent_333_AnimB begin");
	proxy:ForcePlayAnimation( 142, 3301);
	print("OnEvent_333_AnimB end");
end

function OnEvent_332_ryosyuA_0(proxy,param)
	print("OnEvent_332_ryosyuA_0 begin");
	if	proxy:IsCompleteEvent( 334 ) == true then
		--アニメ再生開始！ --EN:--Start playing anime!
		proxy:CustomLuaCallStartPlus( SYNCHROANIM, 141, 3000 );
	end
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2(332, "OnEvent_332_ryosyuA_1", SpearRyosyuA_wait, 0, 11, once );
	proxy:NotNetMessage_end();
	print("OnEvent_332_ryosyuA_0 end");
end

function OnEvent_332_ryosyuA_1(proxy,param)
	print("OnEvent_332_ryosyuA_1 begin");
	if	proxy:IsCompleteEvent( 334 ) == true then
		--アニメ再生開始！ --EN:--Start playing anime!
		proxy:CustomLuaCallStartPlus( SYNCHROANIM, 141, 3000 );
	end
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2(332, "OnEvent_332_ryosyuA_0", SpearRyosyuA_wait, 0, 10, once );
	proxy:NotNetMessage_end();
	print("OnEvent_332_ryosyuA_1 end");
end

function OnEvent_332_ryosyuB_0(proxy,param)
	print("OnEvent_332_ryosyuB_0 begin");
	if	proxy:IsCompleteEvent( 334 ) == true then
		--アニメ再生開始！ --EN:--Start playing anime!
		proxy:CustomLuaCallStartPlus( SYNCHROANIM, 142, 3000 );
	end
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2(332, "OnEvent_332_ryosyuB_1", SpearRyosyuB_wait, 0, 21, once );
	proxy:NotNetMessage_end();
	print("OnEvent_332_ryosyuB_0 end");
end

function OnEvent_332_ryosyuB_1(proxy,param)
	print("OnEvent_332_ryosyuB_1 begin");
	if	proxy:IsCompleteEvent( 334 ) == true then
		--アニメ再生開始！ --EN:--Start playing anime!
		proxy:CustomLuaCallStartPlus( SYNCHROANIM, 142, 3000 );
	end
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2(332, "OnEvent_332_ryosyuB_0", SpearRyosyuB_wait, 0, 20, once );
	proxy:NotNetMessage_end();
	print("OnEvent_332_ryosyuB_1 end");
end




function OnEvent_420(proxy,param)
	print("OnEvent_420 begin");
	
	--プレイヤーの同期アニメーション(true:パーティープレイヤーがアニメーションした) --EN:--Player synchronous animation (true: party player animated)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_WALK ) == true then
		proxy:SetEventFlag( 420 , true );
		return;
	end
	--ダミポリへワープ --EN:--Warp to Damipoli
	proxy:WarpDmy( LOCAL_PLAYER, 1131, 191 );
	
	proxy:NotNetMessage_begin();
		--▼420_1▼歩きアニメ終了▼ --EN:--▼420_1▼End of walking animation▼
		--proxy:OnChrAnimEnd( 420, LOCAL_PLAYER, ANIMEID_WALK, "OnEvent_420_1" , once );
		proxy:LuaCallStart( 420, 2 );
	proxy:NotNetMessage_end();
	proxy:SetEventFlag( 420 , true );
	
	--プロファイルセーブ要求 --EN:--profile save request
	proxy:SaveRequest_Profile();
	
	print("OnEvent_420 end");
end

function OnEvent_420_1(proxy,param)
	print("OnEvent_420_1 begin");
	
	proxy:LuaCallStart( 420, 2 );
	
	print("OnEvent_420_1 end");
end

function OnEvent_420_delete(proxy,param)
	print("OnEvent_420_delete begin");
	
	proxy:SetDrawEnable( 1131, false );--描画OFF --EN:--Drawing OFF
	proxy:SetColiEnable( 1131, false );--当たりOFF --EN:--Hit OFF
	proxy:InvalidSfx( 2021, true );
	proxy:SetObjDeactivate( 1131 , true );--デアクティブ	 --EN:--deactivate
	
	print("OnEvent_420_delete end");
end



function OnEvent_421(proxy,param)
	print("OnEvent_421 begin");
	
	--プレイヤーの同期アニメーション(true:パーティープレイヤーがアニメーションした) --EN:--Player synchronous animation (true: party player animated)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_WALK ) == true then
		proxy:SetEventFlag( 421 , true );
		return;
	end
	--ダミポリへワープ --EN:--Warp to Damipoli
	proxy:WarpDmy( LOCAL_PLAYER, 1132, 191 );
	
	proxy:NotNetMessage_begin();
		--▼421_1▼歩きアニメ終了▼ --EN:--▼421_1▼End of walking animation▼
		--proxy:OnChrAnimEnd( 421, LOCAL_PLAYER, ANIMEID_WALK, "OnEvent_421_1" , once );
		proxy:LuaCallStart( 421, 2 );
	proxy:NotNetMessage_end();
	proxy:SetEventFlag( 421 , true );
	
	--プロファイルセーブ要求 --EN:--profile save request
	proxy:SaveRequest_Profile();
	
	print("OnEvent_421 end");
end

function OnEvent_421_1(proxy,param)
	print("OnEvent_421_1 begin");
	
	proxy:LuaCallStart( 421, 2 );
	
	print("OnEvent_421_1 end");
end

function OnEvent_421_delete(proxy,param)
	print("OnEvent_421_delete begin");
	
	proxy:SetDrawEnable( 1132, false );--描画OFF --EN:--Drawing OFF
	proxy:SetColiEnable( 1132, false );--当たりOFF --EN:--Hit OFF
	proxy:InvalidSfx( 2022, true );
	proxy:SetObjDeactivate( 1132 , true );--デアクティブ --EN:--deactivate
	
	print("OnEvent_421_delete end");
end




function OnEvent_422(proxy,param)
	print("OnEvent_422 begin");
	
	--プレイヤーの同期アニメーション(true:パーティープレイヤーがアニメーションした) --EN:--Player synchronous animation (true: party player animated)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_WALK ) == true then
		proxy:SetEventFlag( 422 , true );
		proxy:SetEventFlag( 423 , true );
		return;
	end
	--ダミポリへワープ --EN:--Warp to Damipoli
	proxy:WarpDmy( LOCAL_PLAYER, 1133, 191 );
	
	proxy:NotNetMessage_begin();
		--▼422_1▼歩きアニメ終了▼ --EN:--▼422_1▼End of walking animation▼
		--proxy:OnChrAnimEnd( 422, LOCAL_PLAYER, ANIMEID_WALK, "OnEvent_422_1" , once );
		proxy:LuaCallStart( 422, 2 );
	proxy:NotNetMessage_end();
	proxy:DeleteEvent(423);--人形ギミック前領域監視削除 --EN:--Remove the area monitoring in front of the doll gimmick
	
	--光の壁と人形ギミック前領域は同じタイミングで消えるので、両方成立にしておく --EN:--The light wall and the area in front of the doll gimmick disappear at the same time, so both should be established.
	proxy:SetEventFlag( 422 , true );
	proxy:SetEventFlag( 423 , true );
	
	--プロファイルセーブ要求 --EN:--profile save request
	proxy:SaveRequest_Profile();
	
	print("OnEvent_422 end");
end

function OnEvent_422_1(proxy,param)
	print("OnEvent_422_1 begin");
	
	proxy:LuaCallStart( 422, 2 );
	
	print("OnEvent_422_1 end");
end

function OnEvent_422_delete(proxy,param)
	print("OnEvent_422_delete begin");
	
	proxy:SetDrawEnable( 1133, false );--描画OFF --EN:--Drawing OFF
	proxy:SetColiEnable( 1133, false );--当たりOFF --EN:--Hit OFF
	proxy:InvalidSfx( 2023, true );
	proxy:SetObjDeactivate( 1133 , true );--デアクティブ --EN:--deactivate
	
	print("OnEvent_422_delete end");
end

--人形ギミックを正面から抜けた --EN:--Puppet gimmick passed from the front
function OnEvent_423(proxy,param)
	print("OnEvent_423 begin");
	
	--光の壁と人形ギミック前領域は同じタイミングで消えるので、両方成立にしておく --EN:--The light wall and the area in front of the doll gimmick disappear at the same time, so both should be established.
	proxy:SetEventFlag( 422, true );
	proxy:SetEventFlag( 423, true );
	
	proxy:DeleteEvent(422);--光の壁監視削除 --EN:--light wall monitor removed
	
	proxy:InvalidSfx( 2023, true );
	proxy:SetDrawEnable( 1133, false );--描画OFF --EN:--Drawing OFF
	proxy:SetColiEnable( 1133, false );--当たりOFF --EN:--Hit OFF
	proxy:SetObjDeactivate( 1133 , true );--デアクティブ --EN:--deactivate
	
	print("OnEvent_423 end");
end


--
--------------------------------------------------------------------------------------
--ボス部屋の中に入る■380 --EN:--Enter the boss room ■380
--------------------------------------------------------------------------------------

--■イベントがループなので、全部リピートにする↓ --EN:--■ Since the event is a loop, repeat all ↓

--■380■中ボス部屋への扉が開く■ --EN:-- ■ 380 ■ The door to the mid-boss room opens ■
function OnEvent_380(proxy,param)
	print("OnEvent_380 begin");

	if proxy:IsCompleteEvent( SYSTEM_ID_IGNORE ) == true then
		print("OnEvent_380 end");
		return;
	end
	
	--クライアントへ、ボス部屋阻止失敗を通知 --EN:--Notify client of failure to block boss room
	if proxy:IsClient() == false then
		proxy:LuaCallStart( 4068 , 1 );	
	end
	
	--→OnEvent_381_1 --EN:--→OnEvent_381_1
	proxy:LuaCallStart( 381, 1 );--旋回アニメの同期再生 --EN:-- Synchronous playback of turning animation
	
	--proxy:SetEventFlag( SYSTEM_ID_IGNORE, true );--多重発動防止用フラグON --EN:--Multiple activation prevention flag ON
	--多重起動システムIDをタイムアウトを設定してONにする --EN:--Turn on multiple activation system ID by setting timeout
	proxy:SetSystemIgnore( SYSTEM_ID_IGNORE , IGNORE_TIME );
	
	--プロファイルセーブ要求 --EN:--profile save request
	proxy:SaveRequest_Profile();
	
	print("OnEvent_380 end");
end


--旋回アニメの同期再生(IDが別) --EN:-- Synchronized playback of turning animation (ID is different)
--LuaCall(381,1)
function OnEvent_381_1(proxy,param)
	print("OnEvent_381_1 begin");

	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		if param:IsNetMessage() == true then
			--旋回アニメ再生を行い、その終了時にOnEvent_381_2を発行する --EN:--Play the turning animation and issue OnEvent_381_2 at the end
			proxy:TurnCharactor( 10001 + param:GetPlayID(), 2891 );
		else
			proxy:LockSession();--ルームをロックします！ --EN:--lock the room!
			--旋回アニメ再生を行い、その終了時にOnEvent_381_2を発行する --EN:--Play the turning animation and issue OnEvent_381_2 at the end
			proxy:OnTurnCharactorEnd( 381, LOCAL_PLAYER, 2891, "OnEvent_381_2", once );
		end
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	
	print("OnEvent_381_1 end");
end

--旋回アニメの同期再生終了後 --EN:--After synchronous playback of turning animation ends
function OnEvent_381_2(proxy,param)
	print("OnEvent_381_2 begin");

	
	--同期用歩きアニメ再生 --EN:--Play walking animation for synchronization
	proxy:LuaCallStart( 4012, 1 );
	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		proxy:OnChrAnimEnd( 381, LOCAL_PLAYER, ANIMEID_WALK, "OnEvent_381_3", once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	
	
	print("OnEvent_381_2 end");
end

--歩きアニメの同期再生終了後 --EN:--After the synchronized playback of the walking animation ends
function OnEvent_381_3(proxy,param)
	print("OnEvent_381_3 begin");

	--最初の人がボス部屋の中に入り終わっていたら、既に配信されているはずなので、もうおくらないハンドラ --EN:--If the first person has already entered the boss room, it should have already been delivered, so no more handlers
	if proxy:IsCompleteEvent( 380 ) == false then
		--→OnEvent_380_GO_TO_IN --EN:--→OnEvent_380_GO_TO_IN
		proxy:LuaCallStart( 381 , 5 );--2回目以降にボス部屋に入るためのイベント配信用 --EN:--For event delivery to enter the boss room after the second time
		proxy:LuaCallStart( 4045 , 1 );	--クライアントへ、ボス部屋に入れるようになったことを通知 --EN:--Notify clients that they can now enter the boss room
		--→OnEvent_380_flag_set --EN:--→OnEvent_380_flag_set
		proxy:LuaCallStart( 381 , 6 );--フラグセット(同期用) --EN:--flag set (for synchronization)
		Lua_MultiDoping(proxy,806);--マルチプレイドーピング --EN:-- Multiplayer Doping
		
		--プレイヤーが扉の中に完全にはいったタイミングで、ボスの思考をリセット --EN:--Reset the boss' thoughts when the player is completely inside the door
		--場所が悪いとプレイヤーを見つけれないため(攻撃してこない) --EN:--Because you can't find the player if the location is bad (they won't attack)
		if proxy:IsClient() == false then
			proxy:ResetThink( 806 );
			proxy:NotNetMessage_begin();
				proxy:OnKeyTime2( 381, "OnEvent_381_Wait", 1.0, 0, 2, once );
			proxy:NotNetMessage_end();
		end
	end	
	
	proxy:SetEventFlag( SYSTEM_ID_IGNORE, false );--多重発動防止用フラグOFF --EN:--Multiple activation prevention flag OFF
	
	print("OnEvent_381_3 end");
end


--■380 2回目以降にボス部屋に入るためのイベント配信用 --EN:--■ 380 For event delivery to enter the boss room after the second time
function OnEvent_380_GO_TO_IN(proxy, param)
	print("OnEvent_380_GO_TO_IN begin");	
	
	GodBattleStart(proxy,param);
	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		--▼381▼扉が開いているときに中に入るためのイベントを追加▼--ハンドラは OnEvent_380 --EN:--▼381▼Add an event to enter when the door is open▼--The handler is OnEvent_380
		proxy:OnPlayerActionInRegion( 381, 2895, "OnEvent_380", HELPID_GO_TO_IN, everytime );--
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	
	print("OnEvent_380_GO_TO_IN end");
end


--■380 フラグセット(同期用) --EN:-- 380 flag set (for synchronization)
function OnEvent_380_flag_set(proxy, param)
	print("OnEvent_380_flag_set begin");
		
	proxy:SetEventFlag( 380 , true );
	proxy:DeleteEvent( 380 );
	
	print("OnEvent_380_flag_set end");
end

function OnEvent_381_Wait(proxy,param)
	print("OnEvent_381_Wait begin");
	
	--死亡監視追加を配信 --EN:--Delivery death watch additions
	--→SynchroDeadCondition(参照先:m04_00_00_00_eventboss.lua) --EN:--→SynchroDeadCondition (reference: m04_00_00_00_eventboss.lua)
	proxy:LuaCallStart( 2047, 3 );
	
	print("OnEvent_381_Wait end");
end



function GodBattleStart(proxy,param)
	print("GodBattleStart begin");
	
	--宙に浮かないように重力有効 --EN:-- Gravity enabled to avoid floating in the air
	proxy:SetDisableGravity( 806, false );
	
	proxy:EnableLogic(806, true );
	
	proxy:ResetThink( 806 );
	
	--必ず待機が再生されるまでリクエストを続ける --EN:--always continue the request until the wait is played
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		proxy:OnRegistFunc( 2045, "AnimCondition_2045", "ForceAnim_2045", 2, once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	
	--死亡待機解除用(これが無いと、死亡待機のアルファ設定で見えない状態になります) --EN:--For canceling death standby (without this, it will be invisible due to the alpha setting of death standby)
	proxy:ForcePlayAnimation( chrId, 0 );
	
	print("GodBattleStart end");
end

function AnimCondition_2045(proxy,param)
	--イベントアニメ再生が出来ていなかったら再生 --EN:--If the event animation cannot be played, play it
	if	proxy:IsEventAnim(806, 0 ) == false then
		proxy:ChrResetAnimation( chrId );
		proxy:ForcePlayAnimation( 806, 0 );
		return false;
	end
	return true;
end

function ForceAnim_2045(proxy,param)
	print("ForceAnim_2045 Success");
end


function GodBattleEnd(proxy,param)
	print("GodBattleEnd begin");

	--床が読み込まれていない時に落下しないように重力無効 --EN:-- Gravity disabled to prevent falling when the floor is not loaded
	proxy:SetDisableGravity( 806, true );
	--ここでロジックOFF --EN:--Logic OFF here
	proxy:EnableLogic( 806, false );
	
	--ボスゲージを消しておく --EN:--Clear the boss gauge
	proxy:ClearBossGauge();
	
	print("GodBattleEnd end");
end


--------------------------------------------------------------------------------------
--中ボスポリ劇■382 --EN:--Middle Bospoli Drama 382
--------------------------------------------------------------------------------------
--■382■中ボスポリ劇■ --EN:-- ■ 382 ■ Middle Bospoli Drama ■
function OnEvent_382(proxy,param)
print("OnEvent_382 begin");
	--▼飛竜が飛んでくるポリ劇再生 --EN:--▼ Play a poly-drama in which flying dragons fly
	proxy:RequestRemo(40000, REMO_FLAG, 382, 1 );
	proxy:SetEventFlag( 382, true );
print("OnEvent_382 end");
end

--■ポリ劇再生開始(フェード終了) --EN:--■ Start of polyplay playback (end of fade)
function OnEvent_382_RemoStart(proxy,param)
print("OnEvent_382_RemoStart begin");
print("OnEvent_382_RemoStart end");
end

--■ポリ劇再生終了(フェード終了) --EN:-- End of polyplay playback (end of fade)
function OnEvent_382_RemoFinish(proxy,param)
print("OnEvent_382_RemoFinish begin");

	--ポリ劇開始したら死亡するまで強制更新させる --EN:-- Forced update until death when police play starts
	proxy:ForceSetOmissionLevel( 806, true, 0 );
	
	--常時読み込まれる設定に --EN:--For settings that are always loaded
	proxy:SetAlwayEnableBackread_forEvent( 806, true );
	
	--ボスを有効化 --EN:--enable boss
	ValidCharactor( proxy , 806 );
	
print("OnEvent_382_RemoFinish end");
end



--------------------------------------------------------------------------------------
--ボスが動き出す(戦闘開始)■383 --EN:--Boss begins to move (battle begins) ■383
--------------------------------------------------------------------------------------

function OnEvent_383(proxy, param)
	print("OnEvent_383 begin");
	
	--[[BGM保留 領域ID待ち]] --EN:--[[Waiting for BGM reserved area ID]]
	--ボス戦用BGM再生開始 --EN:--Start playing BGM for boss battle
	proxy:PlayPointSE( 2040, SOUND_TYPE_M, 40000000, 0 );
	
	--ボスゲージ表示 --EN:-- Boss gauge display
	proxy:SetBossGauge( 806 , 0 ,5060 );
	
	--読み込みタイミングのとき毎回追加されてほしいのでフラグたてない --EN:-- I want it to be added every time at the time of reading, so I don't set a flag
	
	print("OnEvent_383 end");
end


--------------------------------------------------------------------------------------
--■5123■中ボス死亡で扉が開く■ --EN:-- ■ 5123 ■ The door opens when the mid-boss dies ■
--------------------------------------------------------------------------------------
--■5123■中ボス死亡で扉が開く■ --EN:-- ■ 5123 ■ The door opens when the mid-boss dies ■
function OnEvent_5123(proxy,param)	
	print("OnEvent_5123 begin");

	--ホストがネットプレイヤ全員にボス死亡のタイミングを配信 --EN:--The host delivers the boss death timing to all net players
	--→OnEvent_5123_call --EN:--→OnEvent_5123_call
	proxy:LuaCallStart( 5123, 2 );
	
	
	print("OnEvent_5123 end");
end

--LuaCall(5123,2)
function OnEvent_5123_call(proxy,param)
	print("OnEvent_5123_call begin");
	--カミサマデーモンの死亡後処理 --EN:--Death treatment of Kamisama Demon
	GodDemonDead(proxy,param);
	
	--ボス戦用のBGM停止 --EN:--BGM stop for boss battles
	proxy:StopPointSE( 0 );

	
	GodBattleEnd( proxy,param );

	if proxy:IsCompleteEvent( 390 ) == true then
		
		--強制更新無効 --EN:--disable forced update
		proxy:ForceSetOmissionLevel( 806, false, 0 );
		
		--常時バックリードOFF --EN:--Always back read OFF
		proxy:SetAlwayEnableBackread_forEvent( 806, false );
		
		--一応重力も戻しておく --EN:--Restore gravity just in case
		proxy:SetDisableGravity( 806, false );
		
		proxy:NotNetMessage_begin();
			--▼5123_1▼1秒後▼ --EN:--▼5123_1▼After 1 second▼
			proxy:OnKeyTime2( 5123 , "OnEvent_5123_1" , 0 , 0 , 1 , once );
			
			--マルチ解散監視 --EN:--Multi-Dismissal Monitoring
			proxy:OnRegistFunc( 5123 , "Check_5123_PT","OnEvent_5123_PT",0,once);
		proxy:NotNetMessage_end();
		
		proxy:SetEventFlag( 5123 , 1 );--ボス死亡フラグセット(イベント) --EN:--Boss death flag set (event)

		--ブロッククリア処理へ --EN:-- to block clear processing
		proxy:CustomLuaCallStart( 4050, 806 );
		
		--トカゲイベントリセット --EN:-- lizard event reset
		ResetTokage(proxy);
	end
	print("OnEvent_5123_call end");
end

--▲5123_1▲1秒後▲ --EN:--▲5123_1▲After 1 second▲
function OnEvent_5123_1(proxy,param)
	print("OnEvent_5123_1 begin");
	
	--ボスを倒した数を更新(数によってフラグを立てる) --EN:--update number of bosses killed (flag by number)
	GetBossFlagCount( proxy, param );

--アイテム入手関連------- --EN:--Item Acquisition Related-------
	
	--ホストプレイヤーのみアイテム入手イベントに使用 --EN:--Used for item acquisition event only for host players
	local possible_chr_type = ATTR_HOST + ATTR_LIVE + ATTR_GREY;

	--宝死体(ソウル?)有効化 --EN:--Treasure corpse (soul?) activation
	proxy:SetDrawEnable( 1982 , true );
	proxy:SetColiEnable( 1982 , true );
	--宝死体(ソウル?)2有効化 --EN:--Treasure corpse (soul?) 2 enabled
	proxy:SetDrawEnable( 1975 , true );
	proxy:SetColiEnable( 1975 , true );
	
	--▼(ソウル)アイテム取得用イベント監視追加▼ --EN:--▼ (Soul) Added event monitoring for item acquisition▼
	if proxy:IsCompleteEvent( 5121 ) == false then
		proxy:ValidSfx( 2110 );--SFX 有効化 --EN:--SFX enable
		proxy:ValidSfx( 2111 );--SFX 有効化 --EN:--SFX enable
		proxy:TreasureDispModeChange2( 1982 , true ,KANAME_SFX);--光らせる --EN:-- let it shine
		proxy:OnDistanceActionAttribute( 5121 , LOCAL_PLAYER , 1982 , "OnEvent_5121" , WarpGimmickDist_A , 10010180 , 0 , 180 , possible_chr_type, once );
	end
	
------------------------

	--▼トロフィー取得判定▼ --EN:--▼Trophy Acquisition Judgment▼
	Lua_RequestUnlockTrophy(proxy, 32);

	if proxy:IsClient() == false then
		proxy:NotNetMessage_begin();
			proxy:OnKeyTime2(410, "OnEvent_410_1", BlockClear_RemoWait, 0, 2, once );
		proxy:NotNetMessage_end();
	end
	
	print("OnEvent_5123_1 end");
end

--マルチ解散監視 --EN:--Multi-Dismissal Monitoring
function Check_5123_PT(proxy)
	if proxy:IsInParty() == false then
		return true;
	end
	return false;
end

--マルチじゃない --EN:--not multiplayer
function OnEvent_5123_PT(proxy,param)
	print("OnEvent_5123_PT begin");
	--魔法壁消える --EN:--Magic wall disappears
	proxy:SetColiEnable( 1999 , false );
	proxy:SetColiEnable( 1995 , false );

	proxy:SetDrawEnable( 1999 , false );
	proxy:SetDrawEnable( 1995 , false );

	proxy:InvalidSfx( 1991, true );
	
	--中ボス部屋前の移動処理イベントを削除 --EN:--Delete the movement processing event in front of the mid-boss room
	proxy:DeleteEvent( 380 );--一人目が入るとき用 --EN:--For when the first person enters
	proxy:DeleteEvent( 381 );--二人目以降が入るとき用 --EN:--For when the second and subsequent people enter
	proxy:DeleteEvent( 382 );--ボス前ポリ劇用 --EN:--For boss front poly drama
	proxy:DeleteEvent( 383 );--ボス戦闘開始用 --EN:--For boss battle start
	print("OnEvent_5123_PT end");
end


--■390■神様使いの死亡■ --EN:-- ■ 390 ■ God messenger's death ■
function RevivalEnchanterDead_390(proxy,param)
	print("RevivalEnchanterDead_390 begin");
	
	proxy:SetEventFlag( 390, true );
	proxy:SetEventFlag( 391, true );
	
	proxy:InvalidSfx( 2160, true );
	

	--カミサマが生きている時にカミサマ使いが死んだなら、 --EN:--If the Kami-sama user dies while the Kami-sama is alive,
	--ここでカミサマのソウル・QWC取得可能にしておく --EN:--Kamisama's soul/QWC can be acquired here
	if	proxy:IsAlive( 806 ) == true then
		proxy:DisableCollection(806, false );--カミサマのソウル取得を有効化 --EN:-- Enabled Kami-Sama's Soul Acquisition
	end
	
	print("RevivalEnchanterDead_390 end");
end


--人形ポリ劇再生 --EN:--Puppet play
function OnEvent_353(proxy,param)
	print("OnEvent_353 begin");
	
	--▼人形ポリ劇再生 --EN:--▼Puppet play
	proxy:RequestRemo(40002, REMO_FLAG, 353, 1 );
	proxy:SetEventFlag(353,true);
	
	print("OnEvent_353 end");
end

--ポリ劇再生時のハンドラ --EN:--Handler when polyplay is played
function OnEvent_353_RemoStart(proxy,param)
	print("OnEvent_353_RemoStart begin");		
	print("OnEvent_353_RemoStart end");
end

--ポリ劇終了時のハンドラ --EN:--Handler at the end of the polyplay
function OnEvent_353_RemoFinish(proxy,param)
	print("OnEvent_353_RemoFinish begin");
	--バリスタ情報作成 --EN:--Creating barista information
	--proxy:SetBallista( 1102, 410 );	
	proxy:PlayAnimation(1100,3);
	proxy:PlayAnimation(1101,1);
	proxy:PlayAnimation(1102,1);
	print("OnEvent_353_RemoFinish end");
end

--[[
function DollTrick(proxy,param)
	print("DollTrick begin");
	print("DollTrick end");
end
]]

--------------------------------------------------------------------------------------
--■5122■石柱にワープ■ --EN:-- ■ 5122 ■ Warp to the stone pillar ■
--------------------------------------------------------------------------------------
function OnEvent_5122(proxy,param)		
	
	if param:IsNetMessage() == true then
		return;
	end	
	
	print("OnEvent_5122 begin");
	
	--セッション中ならば、要石のワープ無効 --EN:--Disable keystone warp if in session
	if proxy:IsSession() == false then--セッション中ではない --EN:--not in session
		proxy:RepeatMessage_begin();
			--▼70_1▼選択メニューの監視▼ --EN:--▼70_1▼Select menu monitoring▼
			proxy:OnSelectMenu(5122, "OnEvent_5122_1", 10010710, 0, 2, 1982, 2, once);
		proxy:RepeatMessage_end();
	else--セッション中 --EN:--in session
		--エラー表示「セッション中は楔の神殿には戻れません」 --EN:--Error display "You cannot return to the Temple of the Wedge during a session"
		--proxy:InfomationMenu( INFOMENU_TYPE_SIMPLE, 0, MSG_CATEGORY_EVENT, 10010720, 1);
		--proxy:ShowGenDialog(10010720,1,1,true);
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010720, 0, 6, 1983, GEN_DIALOG_DIST, once );
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
	end
	
	print("OnEvent_5122 end");
end

--▲5122_1▲選択メニューの監視▲ --EN:--▲5122_1▲Monitor selection menu▲
function OnEvent_5122_1(proxy,param)	
	print("OnEvent_5122_1 begin");	
	
	if proxy:IsSession() == false then
		if param:IsNetMessage() == true then
			proxy:PlayAnimation(10001+param:GetPlayID(),8283);
			print("OnEvent_5122_1 end");
			return;
		end
			
		proxy:PlayAnimation(LOCAL_PLAYER,8283);
		proxy:NoAnimeTurnCharactor( 10000 , 1982 ,TURNSKIP_ANGLE);
		proxy:NotNetMessage_begin();
		proxy:RepeatMessage_begin();
			proxy:OnChrAnimEnd( 5122 , LOCAL_PLAYER , 8283 , "OnEvent_5122_2",once);
		proxy:RepeatMessage_end();
		proxy:NotNetMessage_end();
		
		proxy:SetEventFlag(5122,1);
	else
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010720, 0, 6, 1983, GEN_DIALOG_DIST, once );
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
	end
	
	print("OnEvent_5122_2 end");
end

--■5122_2■石柱にワープ■ --EN:--■ 5122_2 ■ Warp to the stone pillar ■
function OnEvent_5122_2(proxy,param)	
	print("OnEvent_5122_2 begin");
	
	proxy:PlayAnimation( 10000 , 8284 );--自世界に帰るアニメを再生 --EN:--Play animation to return to your own world
	
	--石柱へ戻ってきた判定のフラグを立てる --EN:--Flag the judgment of returning to the stone pillar
	proxy:SetEventFlag(8083, true);
	
	--完全回復要求 --EN:-- full recovery request
	proxy:RequestFullRecover();
	--古砦要石に戻る --EN:--Return to Old Fort Keystone
	proxy:WarpNextStage( 1, 0, 0, 0, 1008);	
	print("OnEvent_5122_2 end");
end

--------------------------------------------------------------------------------------
--■5121■ソウル入手■ --EN:-- ■ 5121 ■ Get Soul ■
--------------------------------------------------------------------------------------
function OnEvent_5121(proxy, param)
	print("OnEvent_5121 begin");
	
	--プレイヤーの同期アニメーション(true:パーティープレイヤーがアニメーションした) --EN:--Player synchronous animation (true: party player animated)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_PICK ) == true then--新しいアニメ  --EN:-- new anime
		print("OnEvent_5121 end");
		return true;
	end
	
	proxy:NotNetMessage_begin();
		--0.0秒後にアイテム取得イベントを発行 --EN:-- Issue an item acquisition event after 0.0 seconds
		proxy:OnKeyTime2( 5121, "OnEvent_5121_1", 0.0, 0, 0, once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_5121 end");
end


--■5121_1■アイテム取得■ --EN:-- ■ 5121_1 ■ item acquisition ■
function OnEvent_5121_1(proxy, param)
	print("OnEvent_5121_1 begin");

	--アイテム取得関数--パラメータ10550参照 --EN:--item retrieval function--see parameter 10550
	proxy:GetRateItem(10550);	
	--アイテム取得関数--パラメータ10570参照 --EN:--item retrieval function--see parameter 10570
	proxy:GetRateItem(10570);	
	--アイテム取得関数--パラメータ10571参照 --EN:--item retrieval function--see parameter 10571
	proxy:GetRateItem(10571);	
	--アイテム取得関数--パラメータ10572参照 --EN:--item retrieval function--see parameter 10572
	proxy:GetRateItem(10572);	
	--アイテム取得関数--パラメータ10573参照 --EN:--item retrieval function--see parameter 10573
	proxy:GetRateItem(10573);	
	
	--アイテムを取得済み --EN:--item already acquired
	proxy:SetEventFlag( 5121, 1 );
	
	--SFXが消える --EN:--SFX disappear
	--proxy:InvalidSfx( 2111 , true );--ソウルのシェーダー自体の光 --EN:--light of the soul shader itself
	proxy:InvalidSfx( 2110 , true );
		
	--▼要石でワープ用の監視を追加▼ --EN:--▼ Added surveillance for warp with keystone ▼
	proxy:OnDistanceActionAttribute( 5122 , LOCAL_PLAYER , 1982 , "OnEvent_5122" , WarpGimmickDist_A , HELPID_GO_TO_SEKITYUU , 0 , 180 , ATTR_ALL , everytime );

	print("OnEvent_5121_1 end");
end

--------------------------------------------------------------------------------------
--次ブロックへ移動するポリ劇■410 --EN:-- Poly drama to move to the next block ■ 410
--------------------------------------------------------------------------------------
function OnEvent_410_1(proxy,param)
	print("OnEvent_410_1 begin");
	
	proxy:NotNetMessage_begin();
		--次ブロックへ移動するポリ劇 --EN:-- Poly play to move to the next block
		proxy:OnRegionIn( 410, LOCAL_PLAYER, 2030, "OnEvent_410", everytime );
	proxy:NotNetMessage_end();
	
	print("OnEvent_410_1 end");
end

--■410■次ブロックへ移動するポリ劇■ --EN:-- ■ 410 ■ Police play to move to the next block ■
function OnEvent_410(proxy,param)
	if	proxy:IsInParty() == true then
		return;
	end
	print("OnEvent_410 begin");
	
	--▼ガーゴイルが飛んでくるポリ劇再生 --EN:--▼ Poly play with flying gargoyles
	proxy:RequestRemo(40001, REMO_FLAG, 410, 1 );
	proxy:SetEventFlag( 410 , 1 );

	print("OnEvent_410 end");
end

--■ポリ劇再生開始(フェード終了) --EN:--■ Start of polyplay playback (end of fade)
function OnEvent_410_RemoStart(proxy,param)
	print("OnEvent_410_RemoStart begin");
--[[
	proxy:SetDrawEnable( LOCAL_PLAYER , false );--プレイヤー見えなくしたほうが良いきがするけれど恐らくできない？ --EN:--I think it's better to make the player invisible, but maybe you can't?
]]	
	proxy:Warp( LOCAL_PLAYER, 2031 );
	proxy:SetHitInfo( LOCAL_PLAYER , 1500 );
	proxy:CamReset( LOCAL_PLAYER, true );
	if proxy:IsAlive( 10000 ) == true then
		proxy:PlayerChrResetAnimation_RemoOnly(10000);
		proxy:ChrResetRequest(10000);
	end
	
	print("OnEvent_410_RemoStart end");
end

--■ポリ劇再生終了(フェード終了) --EN:-- End of polyplay playback (end of fade)
function OnEvent_410_RemoFinish(proxy,param)
	print("OnEvent_410_RemoFinish begin");
	proxy:DeleteEvent( 410 );	
	print("OnEvent_410_RemoFinish end");
end


--------------------------------------------------------------------------------------
--石柱にワープ■430 --EN:-- Warp to stone pillar ■430
--------------------------------------------------------------------------------------

--■430■石柱にワープ■ --EN:-- ■ 430 ■ Warp to the stone pillar ■
function OnEvent_430(proxy,param)	

	if proxy:IsCompleteEvent( 430 ) == true then
		return;
	end
	
	if param:IsNetMessage() == true then
		return;
	end
	
	
	print("OnEvent_430 begin");
	
	--セッション中ならば、要石のワープ無効 --EN:--Disable keystone warp if in session
	if proxy:IsSession() == false then--セッション中ではない --EN:--not in session
		proxy:RepeatMessage_begin();
			--▼659_1▼選択メニューの監視▼ --EN:--▼659_1▼Select menu monitoring▼
			proxy:OnSelectMenu(430, "OnEvent_430_0", 10010710, 0, 2, 1983, 2, once);			
		proxy:RepeatMessage_end();
	else--セッション中 --EN:--in session
		--エラー表示「セッション中は楔の神殿には戻れません」 --EN:--Error display "You cannot return to the Temple of the Wedge during a session"
		--proxy:InfomationMenu( INFOMENU_TYPE_SIMPLE, 0, MSG_CATEGORY_EVENT, 10010720, 1);
		--proxy:ShowGenDialog(10010720,1,1,true);
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010720, 0, 6, 1983, GEN_DIALOG_DIST, once );
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
	end

	print("OnEvent_430 end");
end

--▲430_0▲選択メニューの監視▲ --EN:--▲430_0▲Monitor selection menu▲
function OnEvent_430_0(proxy, param)
	print("OnEvent_430_0 begin");	
	
	if proxy:IsSession() == false then
		proxy:PlayAnimation( LOCAL_PLAYER , 8283 );--要石に触れるアニメを再生 --EN:--Play the animation that touches the keystone
		proxy:NoAnimeTurnCharactor( 10000 , 1983 ,TURNSKIP_ANGLE);
		
		proxy:NotNetMessage_begin();
			--▼要石に触れるアニメ再生終了▼ --EN:--▼Animation touching the keystone ends▼
			proxy:OnChrAnimEnd( 430 , LOCAL_PLAYER , 8283 , "OnEvent_430_1" , once );
		proxy:NotNetMessage_end();

		proxy:SetEventFlag( 430 , 1 );
	else
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010720, 0, 6, 1983, GEN_DIALOG_DIST, once );
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
	end
	
	print("OnEvent_430_0 end");
end

--▲430_1▲選択メニューの監視▲ --EN:--▲430_1▲Monitor selection menu▲
function OnEvent_430_1(proxy, param)
	print("OnEvent_430_1 begin");
	
	proxy:SetEventFlag( 430 , 0 );
	
	proxy:PlayAnimation( LOCAL_PLAYER , 8284 );--要石に触れるアニメを再生 --EN:--Play the animation that touches the keystone
	
	--[[proxy:NotNetMessage_begin();
		--▼要石に触れるアニメ再生終了▼ --EN:--▼Animation touching the keystone ends▼
		proxy:OnChrAnimEnd( 430 , LOCAL_PLAYER , 8284 , "OnEvent_430_2" , once );
	proxy:NotNetMessage_end();]]
	OnEvent_430_2(proxy,param);

	--proxy:SetEventFlag( 430 , 1 );
	
	print("OnEvent_430_1 end");
end

--▲430-2▲要石に触れるアニメ再生終了▲ --EN:--▲430-2▲End of animation playback where you touch the keystone▲
function OnEvent_430_2(proxy,param)	
	print("OnEvent_430_2 begin");

	--石柱へ戻ってきた判定のフラグを立てる --EN:--Flag the judgment of returning to the stone pillar
	proxy:SetEventFlag(8083, true);
	
	proxy:SetEventFlag( 430 , 0 );
	--完全回復要求 --EN:-- full recovery request
	proxy:RequestFullRecover();
	proxy:WarpNextStage( 1, 0, 0, 0, 1008 );
	
	print("OnEvent_430_2 end");
end


--------------------------------------------------------------------------------------
--■431■最初の要石の光が消える■ --EN:--■431■The light on the first keystone disappears■
--------------------------------------------------------------------------------------

function OnEvent_431(proxy, param)
	print("OnEvent_431 begin");
	
	proxy:TreasureDispModeChange2( 1983 , false ,KANAME_SFX);
	
	print("OnEvent_431 end");
end


--------------------------------------------------------------------------------------
--■432■最初の要石の光が復活する■ --EN:-- ■ 432 ■ The light of the first keystone is restored ■
--------------------------------------------------------------------------------------

function OnEvent_432(proxy, param)
	print("OnEvent_432 begin");
	
	proxy:TreasureDispModeChange2( 1983 , true ,KANAME_SFX);
	
	print("OnEvent_432 end");
end





--------------------------------------------------------------------------------------
--人形領域にはいった■350 --EN:-- Entered the doll area ■ 350
--------------------------------------------------------------------------------------
--新規人形ギミック --EN:-- New doll gimmick
function OnEvent_350(proxy,param)	
	proxy:PlayAnimation( 1100, 3 );--土台?			 --EN:--Foundation?
	print("OnEvent_350 begin");	
	proxy:PlayAnimation( 1102, 3 );--中央?		 --EN:--Central?
	proxy:SetEventFlag( 351 , true );
	if param:IsNetMessage() == false then
		proxy:NotNetMessage_begin();
			proxy:OnKeyTime2(350,"OnEvent_350_1",REROAD_TIME,0,1,once);
		proxy:NotNetMessage_end();
	end
	
	print("OnEvent_350 end");
	
end

--リロード時間経過 --EN:--Reload time elapsed
function OnEvent_350_1(proxy,param)
	print("OnEvent_350_1 begin");
	proxy:LuaCallStart(351,1);
	print("OnEvent_350_1 end");
end

--------------------------------------------------------------------------------------
--人形リロード■350 --EN:--Doll Reload ■350
--------------------------------------------------------------------------------------
--リロード --EN:--reload
function OnEvent_350_flag(proxy,param)
	print("OnEvent_350_flag begin");	
	proxy:SetEventFlag(351,false);
	proxy:DeleteEvent(350);
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2(351,"OnEvent_351",0.1,0,0,once);
	proxy:NotNetMessage_end();
	
	print("OnEvent_350_flag end");
end

function OnEvent_351(proxy,param)
	print("OnEvent_351 begin");
	proxy:RepeatMessage_begin();		
		proxy:OnRegionIn(350,LOCAL_PLAYER,2000,"OnEvent_350",once);
	proxy:RepeatMessage_end();
	print("OnEvent_351 end");
end

--人形ギミック(1100)を止める■352-------------------------------------------------------- --EN:-- Stop the doll gimmick (1100) ■352--------------------------------------- -----------------
function OnEvent_352(proxy,param)
	print("OnEvent_352 begin");
	
	--OBJ(1100)のレバーアニメ再生 --EN:--Play lever animation of OBJ(1100)
	proxy:ForcePlayAnimation(1100, 1);
	proxy:OnObjAnimEnd( 352, 1100, 1, "OnEvent_352_1", once );
	
	proxy:DeleteEvent( 350 );
	proxy:DeleteEvent( 351 );
	
	proxy:SetEventFlag( 352, true );
	
	if	Luafunc_PlaySynchroAnimation( proxy, param, 8001 ) == true then
		return;
	end
	
	--プレイヤーをOBJ(1100)のダミポリ(1)位置へワープ --EN:--Warp player to OBJ(1100) Damipoly(1)
	proxy:WarpDmy( LOCAL_PLAYER, 1100, 191 );	
	
	print("OnEvent_352 end");
end

--人形ギミック停止レバー引きアニメ終了後 --EN:--After pulling the puppet gimmick stop lever animation
function OnEvent_352_1(proxy,param)
	print("OnEvent_352_1 begin");
	proxy:ForcePlayAnimation( 1100, 4 );
	proxy:ForcePlayAnimation( 1101, 2 );
	proxy:ForcePlayAnimation( 1102, 2 );
	print("OnEvent_352_1 end");
end







--------------------------------------------------------------------------------------
--【NPC状態変化：ロガーン】会話で石柱に移動■170 --EN:--[NPC state change: Rogaan] Move to stone pillar in conversation ■170
--------------------------------------------------------------------------------------
--【NPC状態変化：ロガーン】会話で石柱に移動■170 --EN:--[NPC state change: Rogaan] Move to stone pillar in conversation ■170
function OnEvent_170(proxy,param)
	print("OnEvent_170 begin");
	SetNpcStateFlag( proxy, param, rogarn_flag_list, ROGARN_STATE_GO_M1 );
	proxy:SetEventFlag( 170, true );
	print("OnEvent_170 end");
end


--------------------------------------------------------------------------------------
--【NPC状態変化：ロガーン】敵対■171 --EN:--[NPC status change: Rogaan] Hostility ■ 171
--------------------------------------------------------------------------------------
--【NPC状態変化：ロガーン】敵対■171 --EN:--[NPC status change: Rogaan] Hostility ■ 171
function OnEvent_171(proxy,param)
	print("OnEvent_171 begin");
	SetNpcStateFlag( proxy, param, rogarn_flag_list, ROGARN_STATE_ANGRY_M4 );
	proxy:SetTeamType(640, TEAM_TYPE_AngryFriend);--チームタイプ変更 --EN:--Change team type
	proxy:EnableLogic( 640, true );
	proxy:SetEventFlag( 171, true );
	print("OnEvent_171 end");
end


--------------------------------------------------------------------------------------
--【NPC状態変化：ロガーン】死亡■172 --EN:--[NPC status change: Rogaan] Death■172
--------------------------------------------------------------------------------------
--【NPC状態変化：ロガーン】死亡■172 --EN:--[NPC status change: Rogaan] Death■172
function OnEvent_172(proxy,param)
	print("OnEvent_172 begin");
	SetNpcStateFlag( proxy, param, rogarn_flag_list, ROGARN_STATE_DEAD );
	proxy:SetEventFlag( 172, true );
	
	--死亡になったら他の状態変化はいらないので削除 --EN:--Deleted because there is no need for other state changes after death
	proxy:DeleteEvent( 170 );
	proxy:DeleteEvent( 171 );
	
	--ロガーン周りの光削除 --EN:--Remove light around Logan
	proxy:InvalidSfx( 2010 , true );	
	proxy:InvalidPointLight( 2011 );

	print("OnEvent_172 end");
end


--------------------------------------------------------------------------------------
--■176■【ロガーン】アイテムを受け取る■(会話から呼び出す) --EN:-- ■ 176 ■ [Logan] Receive items ■ (call from conversation)
--------------------------------------------------------------------------------------
--■176■【ロガーン】アイテムを受け取る■(会話から呼び出す)  --EN:-- ■ 176 ■ [Logan] Receive items ■ (call from conversation)
function OnEvent_176(proxy,param)
	print("OnEvent_176 begin");
	proxy:SetEventFlag( 176, true );
	proxy:GetRateItem( 16580 );--ミセリコルデ --EN:--Misericorde
	print("OnEvent_176 end");
end


--------------------------------------------------------------------------------------
--【NPC状態変化：元貴族婦人】敵対■180 --EN:--[NPC Status Change: Former Noble Lady] Hostility ■ 180
--------------------------------------------------------------------------------------
--【NPC状態変化：元貴族婦人】敵対■180 --EN:--[NPC Status Change: Former Noble Lady] Hostility ■ 180
function OnEvent_180(proxy,param)
	print("OnEvent_180 begin");
	SetNpcStateFlag( proxy, param, noble_woman_flag_list, NOBLE_WOMAN_STATE_ANGRY );
	proxy:SetTeamType(641, TEAM_TYPE_AngryFriend);--チームタイプ変更 --EN:--Change team type
	proxy:EnableLogic( 641, true );
	proxy:SetEventFlag( 180, true );
	
	print("OnEvent_180 end");
end


--------------------------------------------------------------------------------------
--【NPC状態変化：元貴族婦人】死亡■181 --EN:--[NPC Status Change: Former Noble Lady] Died ■ 181
--------------------------------------------------------------------------------------
--【NPC状態変化：元貴族婦人】死亡■181 --EN:--[NPC Status Change: Former Noble Lady] Died ■ 181
function OnEvent_181(proxy,param)
	print("OnEvent_181 begin");
	SetNpcStateFlag( proxy, param, noble_woman_flag_list, NOBLE_WOMAN_STATE_DEAD );
	proxy:SetEventFlag( 181, true );	
		
	--死亡になったら他の状態変化はいらないので削除 --EN:--Deleted because there is no need for other state changes after death
	proxy:DeleteEvent( 180 );
	print("OnEvent_181 end");
end


function OnEvent_184_In(proxy,param)
	print("OnEvent_184_In begin");
	proxy:SetSpStayAndDamageAnimId( 641, 20, 9600 );
	
	print("OnEvent_184_In StopPointSE");
	proxy:StopPointSE( 5 );
	OPERA_184 = true;
	
	print("OnEvent_184_In end");
end

function OnEvent_184_Out(proxy,param)
	print("OnEvent_184_Out begin");
	proxy:SetSpStayAndDamageAnimId( 641, 7001, 9600 );
	
	if	proxy:IsRegionIn( LOCAL_PLAYER, 2126 ) == true then
		if OPERA_184 == true then
			print("OnEvent_184_Out PlayPointSE");
			proxy:PlayPointSE( 2127, SOUND_TYPE_M, 209099999, 5 );
		end
	end
	OPERA_184 = false;
	print("OnEvent_184_Out end");
end

function OnEvent_185_In(proxy,param)
	print("OnEvent_185_In begin");
	proxy:SetSpStayAndDamageAnimId( 641, 7001, 9600 );
	
	if	proxy:IsRegionIn( LOCAL_PLAYER, 2125 ) == false then
		print("OnEvent_185_In PlayPointSE");
		proxy:PlayPointSE( 2127, SOUND_TYPE_M, 209099999, 5 );
	end
	
	print("OnEvent_185_In end");
end

function OnEvent_185_Out(proxy,param)
	print("OnEvent_185_Out begin");
	proxy:SetSpStayAndDamageAnimId( 641, 20, 9600 );
	
	print("OnEvent_185_Out StopPointSE");
	proxy:StopPointSE( 5 );
	
	print("OnEvent_185_Out end");
end

--貴婦人がダメージを受けたので歌わなくなる --EN:--No longer sings because the lady is damaged
function OnEvent_186(proxy,param)
	print("OnEvent_186 begin");
	proxy:StopPointSE( 5 );
	
	proxy:DeleteEvent( 184 );
	proxy:DeleteEvent( 185 );
	print("OnEvent_186 begin");
end

--貴婦人が押し出されたので歌わなくなる --EN:--No longer sings because the lady was pushed out
function OnEvent_187(proxy,param)
	print("OnEvent_187 begin");
	proxy:StopPointSE( 5 );
	proxy:SetSpStayAndDamageAnimId( 641, -1, -1 );
	proxy:DeleteEvent( 184 );
	proxy:DeleteEvent( 185 );
	print("OnEvent_187 end");
end


--------------------------------------------------------------------------------------
--教会扉ポリ劇再生■354 --EN:--Church door poly play 354
--------------------------------------------------------------------------------------

--■354■教会扉ポリ劇再生■ --EN:-- ■ 354 ■ church door poly play ■
function OnEvent_354(proxy,param)
	print("OnEvent_354 begin");
	
	--▼教会扉ポリ劇再生 --EN:--▼Church door poly play
	proxy:RequestRemo(40003, REMO_FLAG, 354, 1 );
	proxy:SetEventFlag( 354, true );
	
	print("OnEvent_354 end");
end

--■ポリ劇再生開始(フェード終了) --EN:--■ Start of polyplay playback (end of fade)
function OnEvent_354_RemoStart(proxy,param)
	print("OnEvent_354_RemoStart begin");
	print("OnEvent_354_RemoStart end");
end

--■ポリ劇再生終了(フェード終了) --EN:-- End of polyplay playback (end of fade)
function OnEvent_354_RemoFinish(proxy,param)
	print("OnEvent_354_RemoFinish begin");
	
	proxy:EndAnimation( 1095 , 1 );--扉が開いた状態 --EN:--door open
	proxy:ValidSfx( 1991 );--光の壁のSFX ON --EN:--Light Wall SFX ON
	
	print("OnEvent_354_RemoFinish end");
end




function OnEvent_151(proxy,param)
	print("OnEvent_151 begin");
	if	param:IsNetMessage() == false and
		proxy:IsClient() == false then
		print("OnEvent_151 success");
		proxy:ForceUpdateNextFrame(646);
		--proxy:StopLoopAnimation(646);
		--proxy:PlayAnimation( 646, 8621 );
		proxy:SetSpStayAndDamageAnimId( 646 , 8621 , - 1 );
		--viraidel_wait_loopanime = 8621;
		proxy:SetEventFlag(157, true);
	end
	print("OnEvent_151 end");
end

function OnEvent_152(proxy,param)
	print("OnEvent_152 begin");
	if	param:IsNetMessage() == false and
		proxy:IsClient() == false then
		print("OnEvent_152 success");
		proxy:ForceUpdateNextFrame(646);
		--proxy:StopLoopAnimation(646);
		proxy:SetSpStayAndDamageAnimId( 646 , 8620 , 9600 );
		--viraidel_wait_loopanime = 8620;
		proxy:SetEventFlag(157, false);
	end
	print("OnEvent_152 end");
end

--[[
function OnEvent_152_AnimLoop(proxy,param)
	print("OnEvent_152_AnimLoop begin");
		proxy:PlayAnimation( 646, viraidel_wait_loopanime );
	--print("OnEvent_152_AnimLoop end");
end
]]

--[[
function OnEvent_153(proxy,param)
	print("OnEvent_153 begin");
	
	--多重発動防止 --EN:--Multiple activation prevention
	if proxy:IsCompleteEvent( 153 ) == true then
		print("OnEvent_153 return end");
		return;
	end
	
	--必要アイテムの指定 --EN:--Specify required items
	local KEY_ITEM_TYPE = TYPE_GOODS;
	local KEY_ITEM_ID   = ITEMID_ROUGOKU_KEY_2;
	
	--必要アイテムを所持している(インベントリーにアイテムとして所持している) --EN:--You have the necessary items (have them as items in your inventory)
	if proxy:IsInventoryEquip( KEY_ITEM_TYPE , KEY_ITEM_ID ) == true then
		--▼選択メニューの監視▼ --EN:--▼Monitor selection menu▼
		proxy:OnSelectMenu(SYSTEM_GENDIALOG, "MenuClose", HELPID_ROUGOKU_KEY_2, 0, 6, 1037, GEN_DIALOG_DIST, once);
		OnEvent_153_1(proxy,param);
	else
		--扉が開かない場合のメッセージを表示 --EN:-- Display a message when the door does not open
		--proxy:InfomationMenu( INFOMENU_TYPE_SIMPLE, 0, MSG_CATEGORY_EVENT, 10010160, 1);
		proxy:ShowGenDialog(10010160,1,1,true);
	end

	print("OnEvent_153 end");
end

function OnEvent_153_1(proxy,param)
	print("OnEvent_153_1 begin");
	
	proxy:WarpDmy( LOCAL_PLAYER , 1037 , 191 );
	proxy:SetEventFlag( 153, true );
	print("OnEvent_153_1 end");
end
]]

function OnEvent_154(proxy,param)
	print("OnEvent_154 begin");
	proxy:GetRateItem(10541);
	SetNpcStateFlag( proxy, param, viraidel_flag_list, VIRAIDEL_STATE_SEARCH );
	proxy:SetEventFlag( 154, true );
	print("OnEvent_154 end");
end

function OnEvent_155(proxy,param)
	print("OnEvent_155 begin");
	SetNpcStateFlag( proxy, param, viraidel_flag_list, VIRAIDEL_STATE_ANGRY );
	proxy:SetTeamType(646, TEAM_TYPE_AngryFriend);--チームタイプ変更 --EN:--Change team type
	proxy:EnableLogic(646, true);
	proxy:SetEventFlag( 155, true );
	print("OnEvent_155 end");
end

--ヴィライデルを殺した --EN:--Killed Villaidel
function OnEvent_156(proxy,param)
	print("OnEvent_156 begin");
	SetNpcStateFlag( proxy, param, viraidel_flag_list, VIRAIDEL_STATE_DEAD );
	proxy:SetEventFlag( 156, true );
	print("OnEvent_156 end");
end

--ヴィライデルの死体を調べた --EN:--Examined Villaidel's corpse
function OnEvent_15631(proxy,param)
	print("OnEvent_15631 begin");
	proxy:SetEventFlag( 15631 , true );
	print("OnEvent_15631 end");
end

function OnEvent_158_In(proxy,param)
	print("OnEvent_158_In begin");
	if	param:IsNetMessage() == false and
		proxy:IsClient() == false then
		proxy:SetEventFlag( 158, true );
	end
	print("OnEvent_158_In end");
end
function OnEvent_158_Out(proxy,param)
	print("OnEvent_158_Out begin");
	if	param:IsNetMessage() == false and
		proxy:IsClient() == false then
		proxy:SetEventFlag( 158, false );
	end
	print("OnEvent_158_Out end");
end

function OnEvent_163(proxy,param)
	print("OnEvent_163 begin");
	if	proxy:IsClient() == false then
		if	proxy:IsCompleteEvent(VIRAIDEL_STATE_SEARCH) == true then
			--→OnEvent_163_1 --EN:--→OnEvent_163_1
			proxy:LuaCallStart( 163, 2 );
		end
	end
	print("OnEvent_163 end");
end

function OnEvent_163_1(proxy,param)
	print("OnEvent_163_1 begin");
	proxy:DeleteEvent( 163 );
	SetNpcStateFlag( proxy, param, viraidel_flag_list, VIRAIDEL_STATE_DEAD );
	proxy:SetEventFlag( 163, true );
	
	--InvalidCharactor( proxy, 646 );
	--殺した訳じゃないのでQWC変動などはさせない --EN:--I didn't kill you, so I won't let you change the QWC.
	--[[
	proxy:DisableCollection(646, true );--ヴィライデルのソウル取得を無効化 --EN:--Disable Viraidel's soul acquisition
	
	proxy:Warp( 646, 2120 );
	proxy:ForceDead( 646 );
	]]	
	
	InvalidCharactor( proxy,646);
	proxy:SetDrawEnable( 10308, true );
	proxy:SetColiEnable( 10308, true );
	proxy:TreasureDispModeChange( 10308, true );
	proxy:EnableObjTreasure( 10308, true );	
	
	print("OnEvent_163_1 end");
end

--------------------------------------------------------------------------------------
--【ヴィライデル・ブラックゴースト】死亡■161 --EN:-- [Viraidel Black Ghost] death ■ 161
--------------------------------------------------------------------------------------
--【ヴィライデル・ブラックゴースト】死亡■161 --EN:-- [Viraidel Black Ghost] death ■ 161
function OnEvent_161(proxy,param)
	print("OnEvent_161 begin");
	
	--フラグON --EN:--Flag ON
	proxy:SetEventFlag( 161, true );
	
	print("OnEvent_161 end");
end

--ヴィライデル黒の死体を調べたか？ --EN:--Did you examine Villaidel Black's corpse?
function OnEvent_15603(proxy,param)
	print("OnEvent_15603 begin");
	proxy:SetEventFlag( 15603 , true );
	print("OnEvent_15603 end");
end

-------------------------------------------------------------------------------------
--■177■ロガーン会話可能領域■ --EN:-- ■ 177 ■ Logan Conversation Possible Area ■
-------------------------------------------------------------------------------------
function OnEvent_177_in(proxy,param)
	print("OnEvent_177_in begin");
	proxy:SetEventFlag( 177, true );
	print("OnEvent_177_in end");
end

function OnEvent_177_out(proxy,param)
	print("OnEvent_177_out begin");
	proxy:SetEventFlag( 177, false );
	print("OnEvent_177_out end");
end


--[[
--------------------------------------------------------------------------------------
--虜囚＊～＊の死亡■ --EN:--Death of Prisoner *～*■
--------------------------------------------------------------------------------------
--虜囚＊～＊の死亡■ --EN:--Death of Prisoner *～*■
function DeadCheckSeqA(proxy,param)
	print("DeadCheckSeqA begin");
	local dead_actId_list	= { 470, 470, 471, 472};
	local eventId_list		= { 100, 115, 108, 116};
	local door_actId_list	= {   2,   2,   4,   7};
	
	local dead_chrId		= param:GetParam2();--死んだキャラのイベントID --EN:-- Event ID of the dead character
	if	RoomCheck(proxy,param,dead_actId_list,eventId_list,dead_chrId ) == true then
		proxy:SetEventFlag(param:GetParam1(), true);--フラグを立てておく --EN:-- flag
	else
		print("DeadCheckSeqA return end");
		return;
	end
	
	RyosyuDeadCheck(proxy,param,dead_actId_list,eventId_list,door_actId_list,151);
	
	print("DeadCheckSeqA end");
end

--------------------------------------------------------------------------------------
--虜囚＊～＊の死亡■ --EN:--Death of Prisoner *～*■
--------------------------------------------------------------------------------------
--虜囚＊～＊の死亡■ --EN:--Death of Prisoner *～*■
function DeadCheckSeqB(proxy,param)
	print("DeadCheckSeqB begin");
	local dead_actId_list	= {484};
	local eventId_list		= {112};
	local door_actId_list	= { 34};
	local dead_chrId		= param:GetParam2();--死んだキャラのイベントID --EN:-- Event ID of the dead character
	if	RoomCheck(proxy,param,dead_actId_list,eventId_list,dead_chrId ) == true then
		proxy:SetEventFlag(param:GetParam1(), true);--フラグを立てておく --EN:-- flag
	else
		print("DeadCheckSeqB return end");
		return;
	end
	RyosyuDeadCheck(proxy,param,dead_actId_list,eventId_list,door_actId_list,153);
	print("DeadCheckSeqB end");
end

--------------------------------------------------------------------------------------
--虜囚＊～＊の死亡■ --EN:--Death of Prisoner *～*■
--------------------------------------------------------------------------------------
--虜囚＊～＊の死亡■ --EN:--Death of Prisoner *～*■
function DeadCheckSeqC(proxy,param)
	print("DeadCheckSeqC begin");
	local dead_actId_list	= { 480, 481, 482, 483};
	local eventId_list		= { 110, 129, 111, 130};
	local door_actId_list	= {  28,  30,  31,  26};
	local dead_chrId		= param:GetParam2();--死んだキャラのイベントID --EN:-- Event ID of the dead character
	if	RoomCheck(proxy,param,dead_actId_list,eventId_list,dead_chrId ) == true then
		proxy:SetEventFlag(param:GetParam1(), true);--フラグを立てておく --EN:-- flag
	else
		print("DeadCheckSeqC return end");
		return;
	end
	RyosyuDeadCheck(proxy,param,dead_actId_list,eventId_list,door_actId_list,154);
	print("DeadCheckSeqC end");
end

--------------------------------------------------------------------------------------
--虜囚＊～＊の死亡■ --EN:--Death of Prisoner *～*■
--------------------------------------------------------------------------------------
--虜囚＊～＊の死亡■ --EN:--Death of Prisoner *～*■
function DeadCheckSeqD(proxy,param)
	print("DeadCheckSeqD begin");
	local dead_actId_list	= { 101, 102, 103};
	local eventId_list		= { 473, 474, 475};
	local door_actId_list	= {  10,  11,  12};
	local dead_chrId		= param:GetParam2();--死んだキャラのイベントID --EN:-- Event ID of the dead character
	if	RoomCheck(proxy,param,dead_actId_list,eventId_list,dead_chrId ) == true then
		proxy:SetEventFlag(param:GetParam1(), true);--フラグを立てておく --EN:-- flag
	else
		print("DeadCheckSeqD return end");
		return;
	end
	RyosyuDeadCheck(proxy,param,dead_actId_list,eventId_list,door_actId_list,160);
	print("DeadCheckSeqD end");
end

--------------------------------------------------------------------------------------
--虜囚＊～＊の死亡■ --EN:--Death of Prisoner *～*■
--------------------------------------------------------------------------------------
--虜囚＊～＊の死亡■ --EN:--Death of Prisoner *～*■
function DeadCheckSeqE(proxy,param)
	print("DeadCheckSeqE begin");
	local dead_actId_list	= { 107, 126, 127, 109, 128};
	local eventId_list		= { 478, 478, 478, 479, 479};
	local door_actId_list	= {  23,  23,  25,  25,  26};
	local dead_chrId		= param:GetParam2();--死んだキャラのイベントID --EN:-- Event ID of the dead character
	if	RoomCheck(proxy,param,dead_actId_list,eventId_list,dead_chrId ) == true then
		proxy:SetEventFlag(param:GetParam1(), true);--フラグを立てておく --EN:-- flag
	else
		print("DeadCheckSeqE return end");
		return;
	end
	RyosyuDeadCheck(proxy,param,dead_actId_list,eventId_list,door_actId_list,161);
	print("DeadCheckSeqE end");
end

--------------------------------------------------------------------------------------
--虜囚＊～＊の死亡■ --EN:--Death of Prisoner *～*■
--------------------------------------------------------------------------------------
--虜囚＊～＊の死亡■ --EN:--Death of Prisoner *～*■
function DeadCheckSeqF(proxy,param)
	print("DeadCheckSeqF begin");
	local dead_actId_list	= { 117, 118, 119, 104, 105};
	local eventId_list		= { 476, 476, 476, 477, 477};
	local door_actId_list	= {  18,  18,  18,  19,  19};
	local dead_chrId		= param:GetParam2();--死んだキャラのイベントID --EN:-- Event ID of the dead character
	if	RoomCheck(proxy,param,dead_actId_list,eventId_list,dead_chrId ) == true then
		proxy:SetEventFlag(param:GetParam1(), true);--フラグを立てておく --EN:-- flag
	else
		print("DeadCheckSeqF return end");
		return;
	end
	RyosyuDeadCheck(proxy,param,dead_actId_list,eventId_list,door_actId_list, -1);
	print("DeadCheckSeqF end");
end

function RyosyuDeadCheck(proxy,param,dead_actId_list, eventId_list, door_actId_list, takoId)
	local chr_num = table.getn(eventId_list);
	--扉が開いていて、且つまだ死亡していない虜囚が一人でもいたらターゲット継続 --EN:--If the door is open and there is even one prisoner who hasn't died yet, continue targeting
	--いない場合チェックを抜けて、タコにばれていない状態にする --EN:--If not, exit the check and put it in a state where the octopus is not found out
	for index = 1, chr_num, 1 do
		--対応するドアイベントが終っている時 --EN:--when the corresponding door event is over
		if	proxy:IsCompleteEvent(door_actId_list[index]) == true then
			--虜囚死亡イベントが終っていない場合 --EN:--If the prisoner death event has not ended
			if	proxy:IsCompleteEvent(dead_actId_list[index]) == false then
				print("RyosyuDeadCheck return end");
				return;
			else
				print("RyosyuDeadCheck 死んでいる Chr = ",eventId_list[index]); --EN:print("RyosyuDeadCheck Dead Chr = ",eventId_list[index]);
			end
		else
			print("対応する扉が開いていません。Chr = ",eventId_list[index]); --EN:print("The corresponding door is not open. Chr = ",eventId_list[index]);
		end
	end
	
	--タコのターゲットをなくす --EN:-- Eliminate octopus targets
	--proxy:ForceChangeTarget(takoId, -1);
	--proxy:ForceUpdateNextFrame(takoId);
	
	print("ForceChangeTarget takoId = ",takoId,", set -1");
end



--[[ RoomCheck
--部屋のキャラが全員死んでいるかを調べる --EN:--Check if all the characters in the room are dead
--proxy				イベントプロキシ --EN:--proxy event proxy
--param				パラメータ --EN:--param parameter
--room_actId_list	部屋のアクションIDリスト --EN:--room_actId_list Room action ID list
--eventId_list		キャラのイベントIDリスト --EN:--eventId_list Character event ID list
--dead_chr			死んだキャラのイベントID --EN:--dead_chr Dead character's event ID
]]
function RoomCheck(proxy,param,room_actId_list,eventId_list,dead_chr)
	local list_num = table.getn(eventId_list);
	local deadIdx  = -1;
	
	print("dead_chr = ", dead_chr);

	--死んだキャラのイベントIDからリストのインデックスを取得 --EN:--get list index from dead character's event id
	for index2 = 1, list_num, 1 do
		print("eventId = ", eventId_list[index2]);
		if	eventId_list[index2] == dead_chr then
			deadIdx = index2;
		end
	end

	print("deadIdx = ",deadIdx);
	
	--リストのインデックスから部屋ごとのアクションIDを取得 --EN:--get action id per room from list index
	local room_actId = room_actId_list[deadIdx];
	print("room_actId = ",room_actId);
	--部屋のアクションIDを基に、部屋のキャラが全員死んでいるかを調べる --EN:--Check if all the characters in the room are dead based on the room's action ID
	for index3 = 1, list_num, 1 do
		print("RoomCheck AliveChr = ",room_actId_list[index3]);
		print("IsAlive(",eventId_list[index3],") = ",proxy:IsAlive(eventId_list[index3]));
		--部屋のアクションIDが一致していて且つ、生きているキャラがいる場合は失敗としてfalse --EN:--If the action ID of the room matches and there is a living character, false as a failure
		if	room_actId == room_actId_list[index3] and
			proxy:IsAlive(eventId_list[index3]) == true then
			print("RoomCheck AliveChr = ", eventId_list[index3]);
			print("RoomCheck return false");
			return false;
		end
	end
	
	--全員死んでいたのでtrue --EN:-- true because everyone was dead
	print("RoomCheck return true");
	return true;
end

]]


---------------------------------------------------------------------------------------------------------------------------------------
--■490～504■アイアンメイデン■ --EN:-- ■ 490-504 ■ Iron Maiden ■
---------------------------------------------------------------------------------------------------------------------------------------
--■490■アイアンメイデン------------------------------------------------------------------------------------------ --EN:-- ■ 490 ■ Iron Maiden -------------------------------------------- -----------------------------------------------
function OnEvent_490(proxy,param)
	print("OnEvent_490 begin");
	--アイアンメイデンの開くアニメ --EN:--Iron Maiden opening animation
	proxy:PlayAnimation( 1160, 3 );
	
	proxy:SetEventFlag( 490, true );
	
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_OPEN ) == true then
		return;
	end
	
	proxy:WarpDmy( LOCAL_PLAYER, 1160, 191 );
	
	print("OnEvent_490 end");
end


--■491■アイアンメイデン------------------------------------------------------------------------------------------ --EN:-- ■ 491 ■ Iron Maiden ------------------------------------------- -----------------------------------------------
function OnEvent_491(proxy,param)
	print("OnEvent_491 begin");
	--アイアンメイデンの開くアニメ --EN:--Iron Maiden opening animation
	proxy:PlayAnimation( 1161, 3 );
	
	proxy:SetEventFlag( 491, true );
	
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_OPEN ) == true then
		return;
	end
	
	proxy:WarpDmy( LOCAL_PLAYER, 1161, 191 );
	
	print("OnEvent_491 end");
end


--■492■アイアンメイデン------------------------------------------------------------------------------------------ --EN:-- ■ 492 ■ Iron Maiden -------------------------------------------- -----------------------------------------------
function OnEvent_492(proxy,param)
	print("OnEvent_492 begin");
	--アイアンメイデンの開くアニメ --EN:--Iron Maiden opening animation
	proxy:PlayAnimation( 1162, 3 );
	
	proxy:SetEventFlag( 492, true );
	
	proxy:PlayAnimation( 10259, 20 );
	
	if	proxy:IsClient() == false then
		proxy:TreasureDispModeChange( 10259, true );
		proxy:EnableObjTreasure(10259, true);
	end
	
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_OPEN ) == true then
		return;
	end
	
	proxy:WarpDmy( LOCAL_PLAYER, 1162, 191 );
	
	print("OnEvent_492 end");
end


--■493■アイアンメイデン------------------------------------------------------------------------------------------ --EN:-- ■ 493 ■ Iron Maiden -------------------------------------------- -----------------------------------------------
function OnEvent_493(proxy,param)
	print("OnEvent_493 begin");
	--アイアンメイデンの開くアニメ --EN:--Iron Maiden opening animation
	proxy:PlayAnimation( 1163, 3 );
	
	proxy:SetEventFlag( 493, true );
	
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_OPEN ) == true then
		return;
	end
	
	proxy:WarpDmy( LOCAL_PLAYER, 1163, 191 );
	
	print("OnEvent_493 end");
end


--■494■アイアンメイデン------------------------------------------------------------------------------------------ --EN:-- ■ 494 ■ Iron Maiden -------------------------------------------- -----------------------------------------------
function OnEvent_494(proxy,param)
	print("OnEvent_494 begin");
	--アイアンメイデンの開くアニメ --EN:--Iron Maiden opening animation
	proxy:PlayAnimation( 1164, 3 );
	
	proxy:SetEventFlag( 494, true );
	
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_OPEN ) == true then
		return;
	end
	
	proxy:WarpDmy( LOCAL_PLAYER, 1164, 191 );
	
	print("OnEvent_494 end");
end


--■495■アイアンメイデン------------------------------------------------------------------------------------------ --EN:-- ■ 495 ■ Iron Maiden -------------------------------------------- -----------------------------------------------
function OnEvent_495(proxy,param)
	print("OnEvent_495 begin");
	--アイアンメイデンの開くアニメ --EN:--Iron Maiden opening animation
	proxy:PlayAnimation( 1165, 3 );
	
	proxy:SetEventFlag( 495, true );
	
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_OPEN ) == true then
		return;
	end
	
	proxy:WarpDmy( LOCAL_PLAYER, 1165, 191 );
	
	print("OnEvent_495 end");
end


--■496■アイアンメイデン------------------------------------------------------------------------------------------ --EN:-- ■ 496 ■ Iron Maiden -------------------------------------------- -----------------------------------------------
function OnEvent_496(proxy,param)
	print("OnEvent_496 begin");
	--アイアンメイデンの開くアニメ --EN:--Iron Maiden opening animation
	proxy:PlayAnimation( 1166, 3 );
	
	proxy:SetEventFlag( 496, true );
	
	proxy:PlayAnimation( 10268, 20 );
	
	if	proxy:IsClient() == false then
		proxy:TreasureDispModeChange( 10268, true );
		proxy:EnableObjTreasure(10268, true);
	end
	
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_OPEN ) == true then
		return;
	end
	
	proxy:WarpDmy( LOCAL_PLAYER, 1166, 191 );
	
	print("OnEvent_496 end");
end


--■497■アイアンメイデン------------------------------------------------------------------------------------------ --EN:-- ■ 497 ■ Iron Maiden ------------------------------------------- -----------------------------------------------
function OnEvent_497(proxy,param)
	print("OnEvent_497 begin");
	--アイアンメイデンの開くアニメ --EN:--Iron Maiden opening animation
	proxy:PlayAnimation( 1167, 3 );
	
	proxy:SetEventFlag( 497, true );
	
	proxy:PlayAnimation( 10267, 20 );
	
	if	proxy:IsClient() == false then
		proxy:TreasureDispModeChange( 10267, true );
		proxy:EnableObjTreasure(10267, true);
	end
	
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_OPEN ) == true then
		return;
	end
	
	proxy:WarpDmy( LOCAL_PLAYER, 1167, 191 );
	
	print("OnEvent_497 end");
end


--■498■アイアンメイデン------------------------------------------------------------------------------------------ --EN:-- ■ 498 ■ Iron Maiden ------------------------------------------- -----------------------------------------------
function OnEvent_498(proxy,param)
	print("OnEvent_498 begin");
	--アイアンメイデンの開くアニメ --EN:--Iron Maiden opening animation
	proxy:PlayAnimation( 1168, 3 );
	
	proxy:SetEventFlag( 498, true );
	
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_OPEN ) == true then
		return;
	end
	
	proxy:WarpDmy( LOCAL_PLAYER, 1168, 191 );
	
	print("OnEvent_498 end");
end


--■499■アイアンメイデン------------------------------------------------------------------------------------------ --EN:-- ■ 499 ■ Iron Maiden -------------------------------------------- -----------------------------------------------
function OnEvent_499(proxy,param)
	print("OnEvent_499 begin");
	--アイアンメイデンの開くアニメ --EN:--Iron Maiden opening animation
	proxy:PlayAnimation( 1169, 3 );
	
	proxy:SetEventFlag( 499, true );
	
	--虜囚有効化 --EN:--Enable Prisoner
	ValidCharactor( proxy, 124 );
	
	if Luafunc_PlaySynchroAnimation( proxy, param, 7404 ) == true then
		return;
	end

	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 499, "OnEvent_499_1", RYOSYU_ATTACK_WAIT, 0, 2, once );
	proxy:NotNetMessage_end();
	
	proxy:WarpDmy( LOCAL_PLAYER, 1169, 191 );
	
	print("OnEvent_499 end");
end

function OnEvent_499_1(proxy,param)
	print("OnEvent_499_1 begin");
	
	--虜囚攻撃アニメ --EN:-- Prisoner attack animation
	proxy:CustomLuaCallStartPlus( SYNCHROANIM, 124, 3001 );
	
	print("OnEvent_499_1 end");
end


--■500■アイアンメイデン------------------------------------------------------------------------------------------ --EN:-- ■ 500 ■ Iron Maiden -------------------------------------------- -----------------------------------------------
function OnEvent_500(proxy,param)
	print("OnEvent_500 begin");
	--アイアンメイデンの開くアニメ --EN:--Iron Maiden opening animation
	proxy:PlayAnimation( 1170, 3 );
	
	proxy:SetEventFlag( 500, true );
	
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_OPEN ) == true then
		return;
	end
	
	proxy:WarpDmy( LOCAL_PLAYER, 1170, 191 );
	
	print("OnEvent_500 end");
end

--■501■アイアンメイデン------------------------------------------------------------------------------------------ --EN:-- ■ 501 ■ Iron Maiden -------------------------------------------- -----------------------------------------------
function OnEvent_501(proxy,param)
	print("OnEvent_501 begin");
	--アイアンメイデンの開くアニメ --EN:--Iron Maiden opening animation
	proxy:PlayAnimation( 1171, 3 );
	
	proxy:SetEventFlag( 501, true );
	
	proxy:PlayAnimation( 10273, 20 );
	
	if	proxy:IsClient() == false then
		proxy:TreasureDispModeChange( 10273, true );
		proxy:EnableObjTreasure(10273, true);
	end
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_OPEN ) == true then
		return;
	end
	
	proxy:WarpDmy( LOCAL_PLAYER, 1171, 191 );
	
	print("OnEvent_501 end");
end

--■502■アイアンメイデン------------------------------------------------------------------------------------------ --EN:-- ■ 502 ■ Iron Maiden -------------------------------------------- -----------------------------------------------
function OnEvent_502(proxy,param)
	print("OnEvent_502 begin");
	--アイアンメイデンの開くアニメ --EN:--Iron Maiden opening animation
	proxy:PlayAnimation( 1172, 3 );
	
	proxy:SetEventFlag( 502, true );
	
	proxy:PlayAnimation( 10274, 20 );
	
	if	proxy:IsClient() == false then
		proxy:TreasureDispModeChange( 10274, true );
		proxy:EnableObjTreasure(10274, true);
	end
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_OPEN ) == true then
		return;
	end
	
	proxy:WarpDmy( LOCAL_PLAYER, 1172, 191 );
	
	print("OnEvent_502 end");
end

--■503■アイアンメイデン------------------------------------------------------------------------------------------ --EN:-- ■ 503 ■ Iron Maiden -------------------------------------------- -----------------------------------------------
function OnEvent_503(proxy,param)
	print("OnEvent_503 begin");
	--アイアンメイデンの開くアニメ --EN:--Iron Maiden opening animation
	proxy:PlayAnimation( 1173, 3 );
	
	proxy:SetEventFlag( 503, true );
	
	proxy:PlayAnimation( 10272, 20 );
		
	if	proxy:IsClient() == false then
		proxy:TreasureDispModeChange( 10272, true );
		proxy:EnableObjTreasure(10272, true);
	end
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_OPEN ) == true then
		return;
	end
	
	proxy:WarpDmy( LOCAL_PLAYER, 1173, 191 );
	
	print("OnEvent_503 end");
end

--■504■アイアンメイデン------------------------------------------------------------------------------------------ --EN:-- ■ 504 ■ Iron Maiden -------------------------------------------- -----------------------------------------------
function OnEvent_504(proxy,param)
	print("OnEvent_504 begin");
	--アイアンメイデンの開くアニメ --EN:--Iron Maiden opening animation
	proxy:PlayAnimation( 1174, 3 );
	
	proxy:SetEventFlag( 504, true );
	
	--虜囚有効化 --EN:--Enable Prisoner
	ValidCharactor( proxy, 139 );
		
	if Luafunc_PlaySynchroAnimation( proxy, param, 7404 ) == true then
		return;
	end
	
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 504, "OnEvent_504_1", RYOSYU_ATTACK_WAIT, 0, 2, once );
	proxy:NotNetMessage_end();
	
	proxy:WarpDmy( LOCAL_PLAYER, 1174, 191 );
	
	print("OnEvent_504 end");
end

function OnEvent_504_1(proxy,param)
	print("OnEvent_504_1 begin");
	
	proxy:CustomLuaCallStartPlus( SYNCHROANIM, 139, 3001 );
	
	print("OnEvent_504_1 end");
end

--■441～448■プレートを読む --EN:-- ■ 441 ~ 448 ■ read the plate
function OnEvent_441(proxy,param)
	print("OnEvent_441 begin");
	--proxy:InfomationMenu( INFOMENU_TYPE_SIMPLE, 0, MSG_CATEGORY_EVENT, 10010781, 1);
	--proxy:ShowGenDialog(10010781,1,1,true);
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		proxy:DeleteEvent( SYSTEM_GENDIALOG );
		proxy:ShowGenDialog(18500,1,6,true);
		proxy:OnRegionJustOut( SYSTEM_GENDIALOG, LOCAL_PLAYER, 2042, "MenuClose", once );
		--proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010781, 0, 6, ***, GEN_DIALOG_DIST, once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	print("OnEvent_441 end");
end

function OnEvent_442(proxy,param)
	print("OnEvent_442 begin");
	--proxy:InfomationMenu( INFOMENU_TYPE_SIMPLE, 0, MSG_CATEGORY_EVENT, 10010782, 1);
	--proxy:ShowGenDialog(10010782,1,1,true);
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		proxy:DeleteEvent( SYSTEM_GENDIALOG );
		proxy:ShowGenDialog(18501,1,6,true);
		proxy:OnRegionJustOut( SYSTEM_GENDIALOG, LOCAL_PLAYER, 2043, "MenuClose", once );
	--	proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010781, 0, 6, ***, GEN_DIALOG_DIST, once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	print("OnEvent_442 end");
end

function OnEvent_443(proxy,param)
	print("OnEvent_443 begin");
	--proxy:InfomationMenu( INFOMENU_TYPE_SIMPLE, 0, MSG_CATEGORY_EVENT, 10010783, 1);
	--proxy:ShowGenDialog(10010783,1,1,true);
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		proxy:DeleteEvent( SYSTEM_GENDIALOG );
		proxy:ShowGenDialog(18502,1,6,true);
		proxy:OnRegionJustOut( SYSTEM_GENDIALOG, LOCAL_PLAYER, 2044, "MenuClose", once );
	--	proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010781, 0, 6, ***, GEN_DIALOG_DIST, once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	print("OnEvent_443 end");
end

function OnEvent_444(proxy,param)
	print("OnEvent_444 begin");
	--proxy:InfomationMenu( INFOMENU_TYPE_SIMPLE, 0, MSG_CATEGORY_EVENT, 10010784, 1);
	--proxy:ShowGenDialog(10010784,1,1,true);
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		proxy:DeleteEvent( SYSTEM_GENDIALOG );
		proxy:ShowGenDialog(18503,1,6,true);
		proxy:OnRegionJustOut( SYSTEM_GENDIALOG, LOCAL_PLAYER, 2045, "MenuClose", once );
	--	proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010781, 0, 6, ***, GEN_DIALOG_DIST, once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	print("OnEvent_444 end");
end

function OnEvent_445(proxy,param)
	print("OnEvent_445 begin");
	--proxy:InfomationMenu( INFOMENU_TYPE_SIMPLE, 0, MSG_CATEGORY_EVENT, 10010785, 1);
	--proxy:ShowGenDialog(10010785,1,1,true);
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		proxy:DeleteEvent( SYSTEM_GENDIALOG );
		proxy:ShowGenDialog(18504,1,6,true);
		proxy:OnRegionJustOut( SYSTEM_GENDIALOG, LOCAL_PLAYER, 2046, "MenuClose", once );
	--	proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010781, 0, 6, ***, GEN_DIALOG_DIST, once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	print("OnEvent_445 end");
end

function OnEvent_446(proxy,param)
	print("OnEvent_446 begin");
	--proxy:InfomationMenu( INFOMENU_TYPE_SIMPLE, 0, MSG_CATEGORY_EVENT, 10010786, 1);
	--proxy:ShowGenDialog(10010786,1,1,true);
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		proxy:DeleteEvent( SYSTEM_GENDIALOG );
		proxy:ShowGenDialog(18505,1,6,true);
		proxy:OnRegionJustOut( SYSTEM_GENDIALOG, LOCAL_PLAYER, 2047, "MenuClose", once );
	--	proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010781, 0, 6, ***, GEN_DIALOG_DIST, once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	print("OnEvent_446 end");
end

function OnEvent_447(proxy,param)
	print("OnEvent_447 begin");
	--proxy:InfomationMenu( INFOMENU_TYPE_SIMPLE, 0, MSG_CATEGORY_EVENT, 10010787, 1);
	--proxy:ShowGenDialog(10010787,1,1,true);
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		proxy:DeleteEvent( SYSTEM_GENDIALOG );
		proxy:ShowGenDialog(18506,1,6,true);
		proxy:OnRegionJustOut( SYSTEM_GENDIALOG, LOCAL_PLAYER, 2048, "MenuClose", once );
	--	proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010781, 0, 6, ***, GEN_DIALOG_DIST, once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	print("OnEvent_447 end");
end

function OnEvent_448(proxy,param)
	print("OnEvent_448 begin");
	--proxy:InfomationMenu( INFOMENU_TYPE_SIMPLE, 0, MSG_CATEGORY_EVENT, 10010788, 1);
	--proxy:ShowGenDialog(10010788,1,1,true);
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		proxy:DeleteEvent( SYSTEM_GENDIALOG );
		proxy:ShowGenDialog(18507,1,6,true);
		proxy:OnRegionJustOut( SYSTEM_GENDIALOG, LOCAL_PLAYER, 2049, "MenuClose", once );
	--	proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010781, 0, 6, ***, GEN_DIALOG_DIST, once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	print("OnEvent_448 end");
end




--■435■タコ頭起動■------------------------------------------------------------------------ --EN:-- ■ 435 ■ Octopus Head Start ■ ----------------------------------------- -------------------------------
function OnEvent_435(proxy,param)
	print("OnEvent_435 begin");
	proxy:EnableLogic( 160, true );
	proxy:SetEventFlag( 435, true );
	print("OnEvent_435 end");
end

--■436■タコ頭起動■------------------------------------------------------------------------ --EN:-- ■ 436 ■ Octopus Head Start ■ ----------------------------------------- -------------------------------
function OnEvent_436(proxy,param)
	print("OnEvent_436 begin");
	proxy:EnableLogic( 140, true );
	proxy:SetEventFlag( 436, true );
	print("OnEvent_436 end");
end


---------------------------------------------------------------------------------------------
--■71■ツボ虜囚解放■ --EN:-- ■ 71 ■ Key Point Prisoner Liberation ■
---------------------------------------------------------------------------------------------
function CancelStayAnim(proxy,eventid,eneid)
	if proxy:IsCompleteEvent( eventid ) == true then
		return;
	end
	print("OnEvent_",eventid," begin");
	proxy:SetSpStayAndDamageAnimId( eneid, -1, -1);
	proxy:SetEventFlag( eventid , true ); 
	print("OnEvent_",eventid," end");
end

function OnEvent_71(proxy,param) CancelStayAnim(proxy,71,170); end
function OnEvent_72(proxy,param) CancelStayAnim(proxy,72,171); end
function OnEvent_73(proxy,param) CancelStayAnim(proxy,73,172); end
function OnEvent_74(proxy,param) CancelStayAnim(proxy,74,173); end
function OnEvent_75(proxy,param) CancelStayAnim(proxy,75,174); end
function OnEvent_76(proxy,param) CancelStayAnim(proxy,76,175); end
function OnEvent_77(proxy,param) CancelStayAnim(proxy,77,176); end
function OnEvent_78(proxy,param) CancelStayAnim(proxy,78,177); end
function OnEvent_79(proxy,param) CancelStayAnim(proxy,79,178); end
function OnEvent_80(proxy,param) CancelStayAnim(proxy,80,179); end
function OnEvent_81(proxy,param) CancelStayAnim(proxy,81,180); end
function OnEvent_82(proxy,param) CancelStayAnim(proxy,82,181); end
function OnEvent_83(proxy,param) CancelStayAnim(proxy,83,182); end
function OnEvent_84(proxy,param) CancelStayAnim(proxy,84,183); end
function OnEvent_85(proxy,param) CancelStayAnim(proxy,85,184); end

--[[
---------------------------------------------------------------------------------------------
--■90■貴婦人の椅子だけが壊された■ --EN:--■90■Only the lady's chair was broken■
---------------------------------------------------------------------------------------------
function OnEvent_90(proxy,param) 
	CancelStayAnim(proxy,90,641); 
	
	proxy:StopPointSE( 5 );
	
	proxy:DeleteEvent( 184 );
	proxy:DeleteEvent( 185 );
end
]]


-----------------------------------------------------------------------------
--■■結晶トカゲイベント --EN:-- ■ ■ Crystal lizard event
-----------------------------------------------------------------------------
--ボス撃破時のトカゲリセット用 --EN:--For lizard reset when defeating boss
function ResetTokage(proxy)
	print("ResetTokage");
	--proxy:SetEventFlag(91,false);
	--proxy:SetEventFlag(595,false);
	--proxy:SetEventFlag(1120,false);			
	AddEventCounter(proxy,12);
	AddEventCounter(proxy,13);
	AddEventCounter(proxy,14);
end

-----------------------------------------------------------------------------
--■91■結晶トカゲイベント1 --EN:-- ■ 91 ■ Crystal Lizard Event 1
-----------------------------------------------------------------------------
function OnEvent_91(proxy,param)
	print("OnEvent_91 begin");
	proxy:SetEventFlag( 91, true);
	proxy:DeleteEvent( 91 );
	print("OnEvent_91 end");
end

-----------------------------------------------------------------------------
--■595■結晶トカゲイベント2 --EN:-- ■ 595 ■ Crystal Lizard Event 2
-----------------------------------------------------------------------------
function OnEvent_595(proxy,param)
	print("OnEvent_595 begin");
	proxy:SetEventFlag( 595, true);
	proxy:DeleteEvent( 595 );
	print("OnEvent_595 end");
end

-----------------------------------------------------------------------------
--■1120■結晶トカゲイベント2 --EN:-- ■ 1120 ■ Crystal Lizard Event 2
-----------------------------------------------------------------------------
function OnEvent_1120(proxy,param)
	print("OnEvent_1120 begin");
	proxy:SetEventFlag( 1120, true);
	proxy:DeleteEvent( 1120 );
	print("OnEvent_1120 end");
end


-----------------------------------------------------------------------------
--■195■協会前ブラックゴースト死亡管理 --EN:-- ■ 195 ■ Black Ghost death management in front of the association
-----------------------------------------------------------------------------
function OnEvent_195(proxy,param)
	print("OnEvent_195 begin");
	proxy:SetEventFlag( 195 , true );
	print("OnEvent_195 param");
end


-----------------------------------------------------------------------------
--■167■QWC瓦礫通路通過 --EN:-- ■ 167 ■ QWC rubble passage passage
-----------------------------------------------------------------------------
function OnEvent_167(proxy,param)
	print("OnEvent_167 begin");
	proxy:SetEventFlag( 167 , true );
	print("OnEvent_167 end");
end

