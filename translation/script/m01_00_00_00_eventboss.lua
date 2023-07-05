
--------------------------------------------------------------------------------------
--イベント初期化■ボス固有のイベントを登録する際に使用してください --EN:--Event Initialization ■Use this when registering boss-specific events.
--------------------------------------------------------------------------------------
function EventBoss_Initialize_m01_00_00_00(proxy)
	print("EventBoss_Initialize_m01_00_00_00 ダミー begin"); --EN:print("EventBoss_Initialize_m01_00_00_00 dummy begin");
	
	proxy:NotNetMessage_begin();
	--▼0秒後▼-- --EN:--▼After 0 seconds▼--
	proxy:OnKeyTime2( 999990, "Second_EventBoss_Initialize_m01_00_00_00", 0.0, 0,2, once );
	proxy:NotNetMessage_end();
	
	
	--殿堂イベント対応 --EN:--Hall of Fame event support
	--■25■殿堂前扉監視■ --EN:-- ■ 25 ■ Hall of Fame Front Door Monitoring ■
	--オンラインモードの時だけ --EN:-- Only in online mode
	if proxy:IsOnlineMode() == true then
		SingleReset(proxy,25);
		proxy:OnDistanceAction( 25 , 10000 , 1112 , "OnEvent_25" , DoorDist_A , 10010406 , 180, DoorAngle_A , everytime);
		
		--■26■殿堂から離れた時の領域■ --EN:-- ■ 26 ■ Territory when away from the Hall of Fame ■
		SingleReset(proxy,26);
		proxy:OnRegionIn( 26 , 10000 , 2070 , "OnEvent_26" , everytime);
	end
	--5001--5037
	--5101--5110
	--5201--5207
	--5301--5307
	--5401--5437
	--5501--5504	
	
	--ユルト殺人事件イベント --EN:--Yurt Murder Event
	YURUTO_Murder_Case(proxy);
	
	print("EventBoss_Initialize_m01_00_00_00 ダミー end"); --EN:print("EventBoss_Initialize_m01_00_00_00 dummy end");
end

--------------------------------------------------------------------------------------
--ボス用の初期化処理が必要なときに使用：固有情報の作成等 --EN:--Used when initialization processing for the boss is required: creation of unique information, etc.
--------------------------------------------------------------------------------------
function BossInit(proxy,param)	
end


--------------------------------------------------------------------------------------
--1フレーム遅れの初期化 --EN:--1 frame delay initialization
--------------------------------------------------------------------------------------
function Second_EventBoss_Initialize_m01_00_00_00(proxy,param)
	print("Second_EventBoss_Initialize_m01_00_00_00 begin");	
	
	--王の盾DS所持？ --EN:--Do you own the King's Shield DS?
	AddMagic(proxy,4252,1020);
	
	--王の剣DS所持？ --EN:--Do you own the King's sword DS?
	AddMagic(proxy,4372,1014);
	AddMagic(proxy,4372,1004);	
	
	--レンドル王DS所持？	 --EN:--Do you have a DS for King Lendl?
	
	--審判者DS所持？ --EN:--Do you have referee DS?
	AddMagic(proxy,4804,2004);
	
	--嵐の戦士DS所持？ --EN:--Do you own a Storm Warrior DS?
	AddMagic(proxy,4874,2003);
	
	--嵐の獣DS所持？	 --EN:--Do you own a Storm Beast DS?
	AddMagic(proxy,4996,2001);
	
	--神様DS所持？ --EN:--Do you own a God DS?
	AddMagic(proxy,5121,1010);
		
	--黄衣の翁DS所持？ --EN:--Owner of the Old Man in Yellow DS?
	AddMagic(proxy,5381,1011);	
	AddMagic(proxy,5381,1005);	
	AddMagic(proxy,5381,2009);	
	
	--蛭DS所持 --EN:--Hiru DS possession
	AddMagic(proxy,5653,1006);
	AddMagic(proxy,5653,2006);
	
	--蠅DS所持 --EN:-- Possession of Fly DS
	AddMagic(proxy,5773,1019);	
	
	--リーブラDS所持 --EN:--Have Libra DS
	AddMagic(proxy,5893,1016);
	AddMagic(proxy,5893,1002);
	AddMagic(proxy,5893,2005);	
	
	--蜘蛛DS所持 --EN:-- Possession of Spider DS
	AddMagic(proxy,6193,1017);
	
	--炎怪人DS所持	 --EN:--Possess flame monster DS
	AddMagic(proxy,6283,1009);	
	
	--ドラDS所持 --EN:--Dora DS possession
	AddMagic(proxy,6403,1008);
	AddMagic(proxy,6403,1021);	
	AddMagic(proxy,6403,2000);	
	
	--ラスDS所持 --EN:--Rass DS possession
	AddMagic_equip(proxy,30,1018);	
	
	--鉱石の精霊		 --EN:--Ore Spirit
	AddMagic(proxy,8020,2002);
	
	--オンラインモードの時だけ --EN:-- Only in online mode
	if proxy:IsOnlineMode() == true then
		--ファランクス撃破済みの時だけ --EN:--Only when Phalanx has been defeated
		if proxy:IsCompleteEvent( 4096 ) == true then				
			if proxy:RequestRankingBoard() == true then
				print("ランキング要求開始"); --EN:print("Ranking request start");
				--RANKING_REQUEST = true;
			else
				print("ランキング要求失敗"); --EN:print("Ranking Request Failed");
			end		
		end
	end
	
	local tragObj = false;
	if proxy:IsCompleteEvent( YURUTO_STATE_WAIT_M1 ) or proxy:IsCompleteEvent( YURUTO_STATE_ANGRY_M1 ) then
		tragObj = true;
	end
	
	if tragObj == false then
		proxy:SetColiEnable( 10250,false );
		proxy:SetDrawEnable( 10250,false );
		proxy:EnableObjTreasure( 10250 , false );
		proxy:SetColiEnable( 10251,false );
		proxy:SetDrawEnable( 10251,false );
		proxy:EnableObjTreasure( 10251 , false );		
	end
	
	
	print("Second_EventBoss_Initialize_m01_00_00_00 end");
end

--魔法追加判定 --EN:--Magic additional judgment
function AddMagic(proxy,eventId,magicid)
	if proxy:IsCompleteEvent(eventId) == true then
		print("IsComplete true ID:",eventId);
		if proxy:SetMagicGameDataStateForEvent(magicid) == true then
			print("add magicId ",magicid); 
		else
			print("error magicId ",magicid);
		end
	else
		print("IsComplete false ID:",eventId);	
	end
end

--魔法追加判定 --EN:--Magic additional judgment
function AddMagic_equip(proxy,itemid,magicid)
	if proxy:IsInventoryEquip(TYPE_GOODS,itemid) == true then
		print("equip true type_goods ID:",itemid);
		if proxy:SetMagicGameDataStateForEvent(magicid) == true then
			print("add magicId ",magicid); 
		else
			print("error magicId ",magicid);
		end
	else
		print("equip false type_goods ID:",itemid);
	end
end

--------------------------------------------------------------------------------------
--25■殿堂前の扉イベント --EN:--25 Hall of Fame Door Event
--------------------------------------------------------------------------------------
--■25■殿堂前扉■ --EN:--■25■ Hall of Fame front door■
function OnEvent_25(proxy,param)
	--既に終わっているので何もできない --EN:--I can't do anything because it's already finished
	if proxy:IsCompleteEvent(25) == true then
		return;
	end
	
	print("OnEvent_25 begin");
	
	if proxy:IsOnlineMode() == true then
		--▼25_1▼選択メニューの監視▼ --EN:--▼25_1▼Monitor selection menu▼
		proxy:RepeatMessage_begin();
		proxy:OnSelectMenu(25, "OnEvent_25_1", 10010406, 0, 2, 1112, 2, once);
		proxy:RepeatMessage_end();	
		proxy:DeleteEvent(27);
	end
		
	print("OnEvent_25 end");
end

--ランキング読み込み開始 --EN:--Start reading ranking
function OnEvent_25_1(proxy,param)
	print("OnEvent_25_1 begin");
	--ランキング要求開始できたか？ --EN:--Were you able to start the ranking request?
	--if proxy:RequestRankingBoard() == true then
		--テキストのみの汎用ダイアログ		 --EN:--text-only generic dialog
		if proxy:IsRecvRankingData() == false then
			proxy:RepeatMessage_begin();
			proxy:NotNetMessage_begin();
				proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 15600000, 0, 6, 1112, GEN_DIALOG_DIST, once );
			proxy:NotNetMessage_end();
			proxy:RepeatMessage_end();
			
			proxy:RepeatMessage_begin();
				proxy:OnRegistFunc( 27 , "Check_27","OnEvent_27",1,once);				
			proxy:RepeatMessage_end();			
		else
			OnEvent_25_2(proxy,param);
		end
		
		--proxy:ShowGenDialog(50001,1,6,false);		
		--proxy:StopPlayer();

	--end
	print("OnEvent_25_1 end");
end


--殿堂の読み込み待ち --EN:--Waiting to load Hall of Fame
function Check_27(proxy)
	--殿堂の読み込みができたか？ --EN:--Did you get the Hall of Fame loaded?
	if proxy:IsRecvRankingData() == true then
		return true;
	end
	return false;
end

function OnEvent_27(proxy,param)
	print("OnEvent_27 begin");
	if proxy:IsShowMenu_GenDialog() == true then
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 15600002, 0, 6, 1112, GEN_DIALOG_DIST, once );
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
	end	
	print("OnEvent_27 end");
end


--殿堂の扉開く --EN:--Open the Hall of Fame
function OnEvent_25_2(proxy,param)
	print("OnEvent_25_2 begin");
	proxy:CloseGenDialog();
	
	--殿堂メニューの登録判定 --EN:--Registration judgment of hall of fame menu
	CheckRanking(proxy,param);
	
	proxy:SetEventFlag( 25 ,true );
	--動ける様になる --EN:--be able to move
	proxy:EnableLogic( 10000,true);
	--開けるアニメ --EN:--Open animation
	proxy:PlayAnimation( 10000, ANIMEID_WALK);
	--ワープ --EN:--warp
	proxy:WarpDmy( 10000, 1112 , 191);
	--殿堂の扉開く --EN:--Open the Hall of Fame
	--proxy:PlayAnimation( 1112 ,1 );
	--アタリ無効化 --EN:--Disable Atari
	proxy:SetColiEnable( 1112 , false);
	--SFX消去 --EN:--Erase SFX
	proxy:InvalidSfx( 2072 , true);	
	
	--扉が消えるワンショットSfx生成 --EN:--Generate one-shot Sfx where the door disappears
	proxy:CreateSfx_DummyPoly( 1112, 1, 91008 );
	
	proxy:DeleteEvent(25);
	--[[
	IsRankingData
	]]
	print("OnEvent_25_2 end");
end


--------------------------------------------------------------------------------------
--26■殿堂から離れたら閉まる --EN:--26 Closes when you leave the Hall of Fame
--------------------------------------------------------------------------------------
--■26■殿堂から離れた領域■ --EN:--■26■Area away from the Hall of Fame■
function OnEvent_26(proxy,param)
	--殿堂に入ってないので何もできない --EN:--I can't do anything because I'm not in the Hall of Fame
	if proxy:IsCompleteEvent(25) == false then
		return;
	end
	print("OnEvent_26 begin");
	--殿堂データの破棄 --EN:--Destruction of hall of fame data
	--proxy:DeleteRankingData();
	
	--殿堂監視の一斉削除 --EN:--Deletion of hall of fame monitoring all at once
	proxy:DeleteEvent(4053);
	
	proxy:SetEventFlag( 25 ,false );
	--殿堂の扉閉まる --EN:--The doors of the Hall of Fame close
	--proxy:PlayAnimation( 1112 , 2 );	
	--アタリ復活 --EN:--Atari revival
	proxy:SetColiEnable( 1112 , true );
	--SFX復活 --EN:--SFX revival
	proxy:ValidSfx( 2072 );
	
	SingleReset(proxy,25);
	proxy:OnDistanceAction( 25 , 10000 , 1112 , "OnEvent_25" , DoorDist_A , 10010406 , 180, DoorAngle_A , everytime);
		
	print("OnEvent_26 end");
end

--[[
	local dendouId_list = 	{ 
		--ソウル量 --EN:--Soul amount
		5001,	5002,	5003,	5004,	5005,	5006,	5007,	5008,	5009, 	5010,
		5011,	5012,	5013,	5014,	5015,	5016,	5017,	5018,	5019, 	5020,
		5021,	5022,	5023,	5024,	5025,	5026,	5027,	5028,	5029, 	5030,
		5031,	5032,	5033,	5034,	5035,	5036,	5037,	
		--トロフィ獲得率		 --EN:--Trophy Acquisition Rate
		5101,	5102,	5103,	5104,	5105,	5106,	5107,	5108,	5109,	5110,
		--復活ホワイト数 --EN:--resurrection white number
		5201,	5202,	5203,	5204,	5205,	5206,	5207,
		--PK数 --EN:--Number of PKs
		5301,	5302,	5303,	5304,	5305,	5306,	5307,
		--最新クリア --EN:--Latest clear
		5401,	5402,	5403,	5404,	5405,	5406,	5407,	5408,	5409,	5410,		
		5411,	5412,	5413,	5414,	5415,	5416,	5417,	5418,	5419,	5420,
		5421,	5422,	5423,	5424,	5425,	5426,	5427,	5428,	5429,	5430,
		5431,	5432,	5433,	5434,	5435,	5436,	5437,
		--自分 --EN:--myself
		5501,	5502,	5503,	5504,
	}
]]

--殿堂反応領域判定 --EN:--Hall reaction area judgment
function CheckRanking(proxy,param)
	--■4053■殿堂の監視■ --EN:-- ■ 4053 ■ Hall of Fame Monitoring ■
	local dendouId_list = 	{ 
		--ソウル量 --EN:--Soul amount
		5001,	5002,	5003,	5004,	5005,	5006,	5007,	5008,	5009, 	5010,
		5011,	5012,	5013,	5014,	5015,	5016,	5017,	5018,	5019, 	5020,
		5021,	5022,	5023,	5024,	5025,	5026,	5027,	5028,	5029, 	5030,
		5031,	5032,	5033,	5034,	5035,	5036,	5037,	
		--トロフィ獲得率		 --EN:--Trophy Acquisition Rate
		5101,	5102,	5103,	5104,	5105,	5106,	5107,	5108,	5109,	5110,
		--復活ホワイト数 --EN:--resurrection white number
		5201,	5202,	5203,	5204,	5205,	5206,	5207,
		--PK数 --EN:--Number of PKs
		5301,	5302,	5303,	5304,	5305,	5306,	5307,
		--最新クリア --EN:--Latest clear
		5401,	5402,	5403,	5404,	5405,	5406,	5407,	5408,	5409,	5410,		
		5411,	5412,	5413,	5414,	5415,	5416,	5417,	5418,	5419,	5420,
		5421,	5422,	5423,	5424,	5425,	5426,	5427,	5428,	5429,	5430,
		5431,	5432,	5433,	5434,	5435,	5436,	5437,
		--自分 --EN:--myself
		5501,	5502,	5503,	5504,
	}
	
	local index = 1;
	local num = table.getn( dendouId_list );
	
	for index=1 , num ,1 do
		--殿堂データがある物のみ登録 --EN:--Register only items with hall of fame data
		if proxy:IsRankingData( dendouId_list[index] ) == true then
			local regionID = dendouId_list[index] +10000;
			local helpid = regionID * 1000;
			proxy:OnRegionIn( 4053 , 10000 , regionID , "OnEvent_"..regionID.."_Model" , everytime);
			proxy:OnPlayerActionInRegion( 4053 , regionID , "OnEvent_"..regionID,helpid,everytime);
			proxy:OnRegionJustOut( 4053 , 10000, regionID , "OnEvent_"..regionID.."_Out",everytime);
		end
	end
end

--モデル表示汎用化 --EN:--Generalization of model display
function ShowModel( proxy, regionId )
	local eventId = regionId - 10000;
	proxy:ShowRankingDataModel(eventId);
end

--ランキング表示汎用化 --EN:--Generalization of ranking display
function ShowRankingMenu( proxy, regionId )
	local eventId = regionId - 10000;
	print("OnEvent_",eventId," begin");	
	proxy:ShowRankingDialog(eventId);	
	print("OnEvent_",eventId," end");
end

--メニュー破棄 --EN:-- Discard menu
function CloseMenu( proxy ,regionId )
	local eventId = regionId - 10000;
	print("OnEvent_",eventId,"_Out begin");
	proxy:CloseRankingDialog();
	proxy:HideRankingDataModel();
	print("OnEvent_",eventId,"_Out end");
end

--------------------------------------------------------------------------------------
--4053■殿堂の監視 --EN:--4053 ■ Hall of Fame monitoring
--------------------------------------------------------------------------------------
--領域に入っている間モデルを表示する処理 --EN:--handling of displaying the model while in the region
--獲得ソウル量 --EN:--Amount of acquired souls
function OnEvent_15001_Model(proxy,param)	ShowModel(proxy,15001); end
function OnEvent_15002_Model(proxy,param)	ShowModel(proxy,15002); end
function OnEvent_15003_Model(proxy,param)	ShowModel(proxy,15003); end
function OnEvent_15004_Model(proxy,param)	ShowModel(proxy,15004); end
function OnEvent_15005_Model(proxy,param)	ShowModel(proxy,15005); end
function OnEvent_15006_Model(proxy,param)	ShowModel(proxy,15006); end
function OnEvent_15007_Model(proxy,param)	ShowModel(proxy,15007); end
function OnEvent_15008_Model(proxy,param)	ShowModel(proxy,15008); end
function OnEvent_15009_Model(proxy,param)	ShowModel(proxy,15009); end
function OnEvent_15010_Model(proxy,param)	ShowModel(proxy,15010); end
function OnEvent_15011_Model(proxy,param)	ShowModel(proxy,15011); end
function OnEvent_15012_Model(proxy,param)	ShowModel(proxy,15012); end
function OnEvent_15013_Model(proxy,param)	ShowModel(proxy,15013); end
function OnEvent_15014_Model(proxy,param)	ShowModel(proxy,15014); end
function OnEvent_15015_Model(proxy,param)	ShowModel(proxy,15015); end
function OnEvent_15016_Model(proxy,param)	ShowModel(proxy,15016); end
function OnEvent_15017_Model(proxy,param)	ShowModel(proxy,15017); end
function OnEvent_15018_Model(proxy,param)	ShowModel(proxy,15018); end
function OnEvent_15019_Model(proxy,param)	ShowModel(proxy,15019); end
function OnEvent_15020_Model(proxy,param)	ShowModel(proxy,15020); end
function OnEvent_15021_Model(proxy,param)	ShowModel(proxy,15021); end
function OnEvent_15022_Model(proxy,param)	ShowModel(proxy,15022); end
function OnEvent_15023_Model(proxy,param)	ShowModel(proxy,15023); end
function OnEvent_15024_Model(proxy,param)	ShowModel(proxy,15024); end
function OnEvent_15025_Model(proxy,param)	ShowModel(proxy,15025); end
function OnEvent_15026_Model(proxy,param)	ShowModel(proxy,15026); end
function OnEvent_15027_Model(proxy,param)	ShowModel(proxy,15027); end
function OnEvent_15028_Model(proxy,param)	ShowModel(proxy,15028); end
function OnEvent_15029_Model(proxy,param)	ShowModel(proxy,15029); end
function OnEvent_15030_Model(proxy,param)	ShowModel(proxy,15030); end
function OnEvent_15031_Model(proxy,param)	ShowModel(proxy,15031); end
function OnEvent_15032_Model(proxy,param)	ShowModel(proxy,15032); end
function OnEvent_15033_Model(proxy,param)	ShowModel(proxy,15033); end
function OnEvent_15034_Model(proxy,param)	ShowModel(proxy,15034); end
function OnEvent_15035_Model(proxy,param)	ShowModel(proxy,15035); end
function OnEvent_15036_Model(proxy,param)	ShowModel(proxy,15036); end
function OnEvent_15037_Model(proxy,param)	ShowModel(proxy,15037); end


--トロフィ獲得率 --EN:--Trophy Acquisition Rate
function OnEvent_15101_Model(proxy,param)	ShowModel(proxy,15101); end
function OnEvent_15102_Model(proxy,param)	ShowModel(proxy,15102); end
function OnEvent_15103_Model(proxy,param)	ShowModel(proxy,15103); end
function OnEvent_15104_Model(proxy,param)	ShowModel(proxy,15104); end
function OnEvent_15105_Model(proxy,param)	ShowModel(proxy,15105); end
function OnEvent_15106_Model(proxy,param)	ShowModel(proxy,15106); end
function OnEvent_15107_Model(proxy,param)	ShowModel(proxy,15107); end
function OnEvent_15108_Model(proxy,param)	ShowModel(proxy,15108); end
function OnEvent_15109_Model(proxy,param)	ShowModel(proxy,15109); end
function OnEvent_15110_Model(proxy,param)	ShowModel(proxy,15110); end


--復活ホワイト数 --EN:--resurrection white number
function OnEvent_15201_Model(proxy,param)	ShowModel(proxy,15201); end
function OnEvent_15202_Model(proxy,param)	ShowModel(proxy,15202); end
function OnEvent_15203_Model(proxy,param)	ShowModel(proxy,15203); end
function OnEvent_15204_Model(proxy,param)	ShowModel(proxy,15204); end
function OnEvent_15205_Model(proxy,param)	ShowModel(proxy,15205); end
function OnEvent_15206_Model(proxy,param)	ShowModel(proxy,15206); end
function OnEvent_15207_Model(proxy,param)	ShowModel(proxy,15207); end


--PK数 --EN:--Number of PKs
function OnEvent_15301_Model(proxy,param)	ShowModel(proxy,15301); end
function OnEvent_15302_Model(proxy,param)	ShowModel(proxy,15302); end
function OnEvent_15303_Model(proxy,param)	ShowModel(proxy,15303); end
function OnEvent_15304_Model(proxy,param)	ShowModel(proxy,15304); end
function OnEvent_15305_Model(proxy,param)	ShowModel(proxy,15305); end
function OnEvent_15306_Model(proxy,param)	ShowModel(proxy,15306); end
function OnEvent_15307_Model(proxy,param)	ShowModel(proxy,15307); end


--最新クリア --EN:--Latest clear
function OnEvent_15401_Model(proxy,param)	ShowModel(proxy,15401); end
function OnEvent_15402_Model(proxy,param)	ShowModel(proxy,15402); end
function OnEvent_15403_Model(proxy,param)	ShowModel(proxy,15403); end
function OnEvent_15404_Model(proxy,param)	ShowModel(proxy,15404); end
function OnEvent_15405_Model(proxy,param)	ShowModel(proxy,15405); end
function OnEvent_15406_Model(proxy,param)	ShowModel(proxy,15406); end
function OnEvent_15407_Model(proxy,param)	ShowModel(proxy,15407); end
function OnEvent_15408_Model(proxy,param)	ShowModel(proxy,15408); end
function OnEvent_15409_Model(proxy,param)	ShowModel(proxy,15409); end
function OnEvent_15410_Model(proxy,param)	ShowModel(proxy,15410); end
function OnEvent_15411_Model(proxy,param)	ShowModel(proxy,15411); end
function OnEvent_15412_Model(proxy,param)	ShowModel(proxy,15412); end
function OnEvent_15413_Model(proxy,param)	ShowModel(proxy,15413); end
function OnEvent_15414_Model(proxy,param)	ShowModel(proxy,15414); end
function OnEvent_15415_Model(proxy,param)	ShowModel(proxy,15415); end
function OnEvent_15416_Model(proxy,param)	ShowModel(proxy,15416); end
function OnEvent_15417_Model(proxy,param)	ShowModel(proxy,15417); end
function OnEvent_15418_Model(proxy,param)	ShowModel(proxy,15418); end
function OnEvent_15419_Model(proxy,param)	ShowModel(proxy,15419); end
function OnEvent_15420_Model(proxy,param)	ShowModel(proxy,15420); end
function OnEvent_15421_Model(proxy,param)	ShowModel(proxy,15421); end
function OnEvent_15422_Model(proxy,param)	ShowModel(proxy,15422); end
function OnEvent_15423_Model(proxy,param)	ShowModel(proxy,15423); end
function OnEvent_15424_Model(proxy,param)	ShowModel(proxy,15424); end
function OnEvent_15425_Model(proxy,param)	ShowModel(proxy,15425); end
function OnEvent_15426_Model(proxy,param)	ShowModel(proxy,15426); end
function OnEvent_15427_Model(proxy,param)	ShowModel(proxy,15427); end
function OnEvent_15428_Model(proxy,param)	ShowModel(proxy,15428); end
function OnEvent_15429_Model(proxy,param)	ShowModel(proxy,15429); end
function OnEvent_15430_Model(proxy,param)	ShowModel(proxy,15430); end
function OnEvent_15431_Model(proxy,param)	ShowModel(proxy,15431); end
function OnEvent_15432_Model(proxy,param)	ShowModel(proxy,15432); end
function OnEvent_15433_Model(proxy,param)	ShowModel(proxy,15433); end
function OnEvent_15434_Model(proxy,param)	ShowModel(proxy,15434); end
function OnEvent_15435_Model(proxy,param)	ShowModel(proxy,15435); end
function OnEvent_15436_Model(proxy,param)	ShowModel(proxy,15436); end
function OnEvent_15437_Model(proxy,param)	ShowModel(proxy,15437); end


--PC用 --EN:--For PC
function OnEvent_15501_Model(proxy,param)	ShowModel(proxy,15501); end
function OnEvent_15502_Model(proxy,param)	ShowModel(proxy,15502); end
function OnEvent_15503_Model(proxy,param)	ShowModel(proxy,15503); end
function OnEvent_15504_Model(proxy,param)	ShowModel(proxy,15504); end



--領域でアクションボタンを押した時の処理 --EN:--Processing when the action button is pressed in the area
--獲得ソウル量 --EN:--Amount of acquired souls
function OnEvent_15001(proxy,param) ShowRankingMenu(proxy, 15001); end
function OnEvent_15002(proxy,param) ShowRankingMenu(proxy, 15002); end
function OnEvent_15003(proxy,param) ShowRankingMenu(proxy, 15003); end
function OnEvent_15004(proxy,param) ShowRankingMenu(proxy, 15004); end
function OnEvent_15005(proxy,param) ShowRankingMenu(proxy, 15005); end
function OnEvent_15006(proxy,param) ShowRankingMenu(proxy, 15006); end
function OnEvent_15007(proxy,param) ShowRankingMenu(proxy, 15007); end
function OnEvent_15008(proxy,param) ShowRankingMenu(proxy, 15008); end
function OnEvent_15009(proxy,param) ShowRankingMenu(proxy, 15009); end
function OnEvent_15010(proxy,param) ShowRankingMenu(proxy, 15010); end
function OnEvent_15011(proxy,param) ShowRankingMenu(proxy, 15011); end
function OnEvent_15012(proxy,param) ShowRankingMenu(proxy, 15012); end
function OnEvent_15013(proxy,param) ShowRankingMenu(proxy, 15013); end
function OnEvent_15014(proxy,param) ShowRankingMenu(proxy, 15014); end
function OnEvent_15015(proxy,param) ShowRankingMenu(proxy, 15015); end
function OnEvent_15016(proxy,param) ShowRankingMenu(proxy, 15016); end
function OnEvent_15017(proxy,param) ShowRankingMenu(proxy, 15017); end
function OnEvent_15018(proxy,param) ShowRankingMenu(proxy, 15018); end
function OnEvent_15019(proxy,param) ShowRankingMenu(proxy, 15019); end
function OnEvent_15020(proxy,param) ShowRankingMenu(proxy, 15020); end
function OnEvent_15021(proxy,param) ShowRankingMenu(proxy, 15021); end
function OnEvent_15022(proxy,param) ShowRankingMenu(proxy, 15022); end
function OnEvent_15023(proxy,param) ShowRankingMenu(proxy, 15023); end
function OnEvent_15024(proxy,param) ShowRankingMenu(proxy, 15024); end
function OnEvent_15025(proxy,param) ShowRankingMenu(proxy, 15025); end
function OnEvent_15026(proxy,param) ShowRankingMenu(proxy, 15026); end
function OnEvent_15027(proxy,param) ShowRankingMenu(proxy, 15027); end
function OnEvent_15028(proxy,param) ShowRankingMenu(proxy, 15028); end
function OnEvent_15029(proxy,param) ShowRankingMenu(proxy, 15029); end
function OnEvent_15030(proxy,param) ShowRankingMenu(proxy, 15030); end
function OnEvent_15031(proxy,param) ShowRankingMenu(proxy, 15031); end
function OnEvent_15032(proxy,param) ShowRankingMenu(proxy, 15032); end
function OnEvent_15033(proxy,param) ShowRankingMenu(proxy, 15033); end
function OnEvent_15034(proxy,param) ShowRankingMenu(proxy, 15034); end
function OnEvent_15035(proxy,param) ShowRankingMenu(proxy, 15035); end
function OnEvent_15036(proxy,param) ShowRankingMenu(proxy, 15036); end
function OnEvent_15037(proxy,param) ShowRankingMenu(proxy, 15037); end


--トロフィ獲得 --EN:--Trophy Acquisition
function OnEvent_15101(proxy,param) ShowRankingMenu(proxy, 15101); end
function OnEvent_15102(proxy,param) ShowRankingMenu(proxy, 15102); end
function OnEvent_15103(proxy,param) ShowRankingMenu(proxy, 15103); end
function OnEvent_15104(proxy,param) ShowRankingMenu(proxy, 15104); end
function OnEvent_15105(proxy,param) ShowRankingMenu(proxy, 15105); end
function OnEvent_15106(proxy,param) ShowRankingMenu(proxy, 15106); end
function OnEvent_15107(proxy,param) ShowRankingMenu(proxy, 15107); end
function OnEvent_15108(proxy,param) ShowRankingMenu(proxy, 15108); end
function OnEvent_15109(proxy,param) ShowRankingMenu(proxy, 15109); end
function OnEvent_15110(proxy,param) ShowRankingMenu(proxy, 15110); end


--復活ホワイト数 --EN:--resurrection white number
function OnEvent_15201(proxy,param) ShowRankingMenu(proxy, 15201); end
function OnEvent_15202(proxy,param) ShowRankingMenu(proxy, 15202); end
function OnEvent_15203(proxy,param) ShowRankingMenu(proxy, 15203); end
function OnEvent_15204(proxy,param) ShowRankingMenu(proxy, 15204); end
function OnEvent_15205(proxy,param) ShowRankingMenu(proxy, 15205); end
function OnEvent_15206(proxy,param) ShowRankingMenu(proxy, 15206); end
function OnEvent_15207(proxy,param) ShowRankingMenu(proxy, 15207); end


--PK率 --EN:--PK rate
function OnEvent_15301(proxy,param) ShowRankingMenu(proxy, 15301); end
function OnEvent_15302(proxy,param) ShowRankingMenu(proxy, 15302); end
function OnEvent_15303(proxy,param) ShowRankingMenu(proxy, 15303); end
function OnEvent_15304(proxy,param) ShowRankingMenu(proxy, 15304); end
function OnEvent_15305(proxy,param) ShowRankingMenu(proxy, 15305); end
function OnEvent_15306(proxy,param) ShowRankingMenu(proxy, 15306); end
function OnEvent_15307(proxy,param) ShowRankingMenu(proxy, 15307); end


--最新クリア --EN:--Latest clear
function OnEvent_15401(proxy,param) ShowRankingMenu(proxy, 15401); end
function OnEvent_15402(proxy,param) ShowRankingMenu(proxy, 15402); end
function OnEvent_15403(proxy,param) ShowRankingMenu(proxy, 15403); end
function OnEvent_15404(proxy,param) ShowRankingMenu(proxy, 15404); end
function OnEvent_15405(proxy,param) ShowRankingMenu(proxy, 15405); end
function OnEvent_15406(proxy,param) ShowRankingMenu(proxy, 15406); end
function OnEvent_15407(proxy,param) ShowRankingMenu(proxy, 15407); end
function OnEvent_15408(proxy,param) ShowRankingMenu(proxy, 15408); end
function OnEvent_15409(proxy,param) ShowRankingMenu(proxy, 15409); end
function OnEvent_15410(proxy,param) ShowRankingMenu(proxy, 15410); end
function OnEvent_15411(proxy,param) ShowRankingMenu(proxy, 15411); end
function OnEvent_15412(proxy,param) ShowRankingMenu(proxy, 15412); end
function OnEvent_15413(proxy,param) ShowRankingMenu(proxy, 15413); end
function OnEvent_15414(proxy,param) ShowRankingMenu(proxy, 15414); end
function OnEvent_15415(proxy,param) ShowRankingMenu(proxy, 15415); end
function OnEvent_15416(proxy,param) ShowRankingMenu(proxy, 15416); end
function OnEvent_15417(proxy,param) ShowRankingMenu(proxy, 15417); end
function OnEvent_15418(proxy,param) ShowRankingMenu(proxy, 15418); end
function OnEvent_15419(proxy,param) ShowRankingMenu(proxy, 15419); end
function OnEvent_15420(proxy,param) ShowRankingMenu(proxy, 15420); end
function OnEvent_15421(proxy,param) ShowRankingMenu(proxy, 15421); end
function OnEvent_15422(proxy,param) ShowRankingMenu(proxy, 15422); end
function OnEvent_15423(proxy,param) ShowRankingMenu(proxy, 15423); end
function OnEvent_15424(proxy,param) ShowRankingMenu(proxy, 15424); end
function OnEvent_15425(proxy,param) ShowRankingMenu(proxy, 15425); end
function OnEvent_15426(proxy,param) ShowRankingMenu(proxy, 15426); end
function OnEvent_15427(proxy,param) ShowRankingMenu(proxy, 15427); end
function OnEvent_15428(proxy,param) ShowRankingMenu(proxy, 15428); end
function OnEvent_15429(proxy,param) ShowRankingMenu(proxy, 15429); end
function OnEvent_15430(proxy,param) ShowRankingMenu(proxy, 15430); end
function OnEvent_15431(proxy,param) ShowRankingMenu(proxy, 15431); end
function OnEvent_15432(proxy,param) ShowRankingMenu(proxy, 15432); end
function OnEvent_15433(proxy,param) ShowRankingMenu(proxy, 15433); end
function OnEvent_15434(proxy,param) ShowRankingMenu(proxy, 15434); end
function OnEvent_15435(proxy,param) ShowRankingMenu(proxy, 15435); end
function OnEvent_15436(proxy,param) ShowRankingMenu(proxy, 15436); end
function OnEvent_15437(proxy,param) ShowRankingMenu(proxy, 15437); end

--PC用 --EN:--For PC
function OnEvent_15501(proxy,param) ShowRankingMenu(proxy, 15501); end
function OnEvent_15502(proxy,param) ShowRankingMenu(proxy, 15502); end
function OnEvent_15503(proxy,param) ShowRankingMenu(proxy, 15503); end
function OnEvent_15504(proxy,param) ShowRankingMenu(proxy, 15504); end


--領域外でメニューを消す処理 --EN:--Processing to erase the menu outside the area
--獲得ソウル量 --EN:--Amount of acquired souls
function OnEvent_15001_Out(proxy,param) CloseMenu(proxy,15001); end
function OnEvent_15002_Out(proxy,param) CloseMenu(proxy,15002); end
function OnEvent_15003_Out(proxy,param) CloseMenu(proxy,15003); end
function OnEvent_15004_Out(proxy,param) CloseMenu(proxy,15004); end
function OnEvent_15005_Out(proxy,param) CloseMenu(proxy,15005); end
function OnEvent_15006_Out(proxy,param) CloseMenu(proxy,15006); end
function OnEvent_15007_Out(proxy,param) CloseMenu(proxy,15007); end
function OnEvent_15008_Out(proxy,param) CloseMenu(proxy,15008); end
function OnEvent_15009_Out(proxy,param) CloseMenu(proxy,15009); end
function OnEvent_15010_Out(proxy,param) CloseMenu(proxy,15010); end
function OnEvent_15011_Out(proxy,param) CloseMenu(proxy,15011); end
function OnEvent_15012_Out(proxy,param) CloseMenu(proxy,15012); end
function OnEvent_15013_Out(proxy,param) CloseMenu(proxy,15013); end
function OnEvent_15014_Out(proxy,param) CloseMenu(proxy,15014); end
function OnEvent_15015_Out(proxy,param) CloseMenu(proxy,15015); end
function OnEvent_15016_Out(proxy,param) CloseMenu(proxy,15016); end
function OnEvent_15017_Out(proxy,param) CloseMenu(proxy,15017); end
function OnEvent_15018_Out(proxy,param) CloseMenu(proxy,15018); end
function OnEvent_15019_Out(proxy,param) CloseMenu(proxy,15019); end
function OnEvent_15020_Out(proxy,param) CloseMenu(proxy,15020); end
function OnEvent_15021_Out(proxy,param) CloseMenu(proxy,15021); end
function OnEvent_15022_Out(proxy,param) CloseMenu(proxy,15022); end
function OnEvent_15023_Out(proxy,param) CloseMenu(proxy,15023); end
function OnEvent_15024_Out(proxy,param) CloseMenu(proxy,15024); end
function OnEvent_15025_Out(proxy,param) CloseMenu(proxy,15025); end
function OnEvent_15026_Out(proxy,param) CloseMenu(proxy,15026); end
function OnEvent_15027_Out(proxy,param) CloseMenu(proxy,15027); end
function OnEvent_15028_Out(proxy,param) CloseMenu(proxy,15028); end
function OnEvent_15029_Out(proxy,param) CloseMenu(proxy,15029); end
function OnEvent_15030_Out(proxy,param) CloseMenu(proxy,15030); end
function OnEvent_15031_Out(proxy,param) CloseMenu(proxy,15031); end
function OnEvent_15032_Out(proxy,param) CloseMenu(proxy,15032); end
function OnEvent_15033_Out(proxy,param) CloseMenu(proxy,15033); end
function OnEvent_15034_Out(proxy,param) CloseMenu(proxy,15034); end
function OnEvent_15035_Out(proxy,param) CloseMenu(proxy,15035); end
function OnEvent_15036_Out(proxy,param) CloseMenu(proxy,15036); end
function OnEvent_15037_Out(proxy,param) CloseMenu(proxy,15037); end


--トロフィ獲得率 --EN:--Trophy Acquisition Rate
function OnEvent_15101_Out(proxy,param) CloseMenu(proxy,15101); end
function OnEvent_15102_Out(proxy,param) CloseMenu(proxy,15102); end
function OnEvent_15103_Out(proxy,param) CloseMenu(proxy,15103); end
function OnEvent_15104_Out(proxy,param) CloseMenu(proxy,15104); end
function OnEvent_15105_Out(proxy,param) CloseMenu(proxy,15105); end
function OnEvent_15106_Out(proxy,param) CloseMenu(proxy,15106); end
function OnEvent_15107_Out(proxy,param) CloseMenu(proxy,15107); end
function OnEvent_15108_Out(proxy,param) CloseMenu(proxy,15108); end
function OnEvent_15109_Out(proxy,param) CloseMenu(proxy,15109); end
function OnEvent_15110_Out(proxy,param) CloseMenu(proxy,15110); end


--ホワイト復活 --EN:--White Resurrection
function OnEvent_15201_Out(proxy,param) CloseMenu(proxy,15201); end
function OnEvent_15202_Out(proxy,param) CloseMenu(proxy,15202); end
function OnEvent_15203_Out(proxy,param) CloseMenu(proxy,15203); end
function OnEvent_15204_Out(proxy,param) CloseMenu(proxy,15204); end
function OnEvent_15205_Out(proxy,param) CloseMenu(proxy,15205); end
function OnEvent_15206_Out(proxy,param) CloseMenu(proxy,15206); end
function OnEvent_15207_Out(proxy,param) CloseMenu(proxy,15207); end


--PK数 --EN:--Number of PKs
function OnEvent_15301_Out(proxy,param) CloseMenu(proxy,15301); end
function OnEvent_15302_Out(proxy,param) CloseMenu(proxy,15302); end
function OnEvent_15303_Out(proxy,param) CloseMenu(proxy,15303); end
function OnEvent_15304_Out(proxy,param) CloseMenu(proxy,15304); end
function OnEvent_15305_Out(proxy,param) CloseMenu(proxy,15305); end
function OnEvent_15306_Out(proxy,param) CloseMenu(proxy,15306); end
function OnEvent_15307_Out(proxy,param) CloseMenu(proxy,15307); end


--最新クリア数 --EN:--Latest number of clears
function OnEvent_15401_Out(proxy,param) CloseMenu(proxy,15401); end
function OnEvent_15402_Out(proxy,param) CloseMenu(proxy,15402); end
function OnEvent_15403_Out(proxy,param) CloseMenu(proxy,15403); end
function OnEvent_15404_Out(proxy,param) CloseMenu(proxy,15404); end
function OnEvent_15405_Out(proxy,param) CloseMenu(proxy,15405); end
function OnEvent_15406_Out(proxy,param) CloseMenu(proxy,15406); end
function OnEvent_15407_Out(proxy,param) CloseMenu(proxy,15407); end
function OnEvent_15408_Out(proxy,param) CloseMenu(proxy,15408); end
function OnEvent_15409_Out(proxy,param) CloseMenu(proxy,15409); end
function OnEvent_15410_Out(proxy,param) CloseMenu(proxy,15410); end
function OnEvent_15411_Out(proxy,param) CloseMenu(proxy,15411); end
function OnEvent_15412_Out(proxy,param) CloseMenu(proxy,15412); end
function OnEvent_15413_Out(proxy,param) CloseMenu(proxy,15413); end
function OnEvent_15414_Out(proxy,param) CloseMenu(proxy,15414); end
function OnEvent_15415_Out(proxy,param) CloseMenu(proxy,15415); end
function OnEvent_15416_Out(proxy,param) CloseMenu(proxy,15416); end
function OnEvent_15417_Out(proxy,param) CloseMenu(proxy,15417); end
function OnEvent_15418_Out(proxy,param) CloseMenu(proxy,15418); end
function OnEvent_15419_Out(proxy,param) CloseMenu(proxy,15419); end
function OnEvent_15420_Out(proxy,param) CloseMenu(proxy,15420); end
function OnEvent_15421_Out(proxy,param) CloseMenu(proxy,15421); end
function OnEvent_15422_Out(proxy,param) CloseMenu(proxy,15422); end
function OnEvent_15423_Out(proxy,param) CloseMenu(proxy,15423); end
function OnEvent_15424_Out(proxy,param) CloseMenu(proxy,15424); end
function OnEvent_15425_Out(proxy,param) CloseMenu(proxy,15425); end
function OnEvent_15426_Out(proxy,param) CloseMenu(proxy,15426); end
function OnEvent_15427_Out(proxy,param) CloseMenu(proxy,15427); end
function OnEvent_15428_Out(proxy,param) CloseMenu(proxy,15428); end
function OnEvent_15429_Out(proxy,param) CloseMenu(proxy,15429); end
function OnEvent_15430_Out(proxy,param) CloseMenu(proxy,15430); end
function OnEvent_15431_Out(proxy,param) CloseMenu(proxy,15431); end
function OnEvent_15432_Out(proxy,param) CloseMenu(proxy,15432); end
function OnEvent_15433_Out(proxy,param) CloseMenu(proxy,15433); end
function OnEvent_15434_Out(proxy,param) CloseMenu(proxy,15434); end
function OnEvent_15435_Out(proxy,param) CloseMenu(proxy,15435); end
function OnEvent_15436_Out(proxy,param) CloseMenu(proxy,15436); end
function OnEvent_15437_Out(proxy,param) CloseMenu(proxy,15437); end


--PC用 --EN:--For PC
function OnEvent_15501_Out(proxy,param) CloseMenu(proxy,15501); end
function OnEvent_15502_Out(proxy,param) CloseMenu(proxy,15502); end
function OnEvent_15503_Out(proxy,param) CloseMenu(proxy,15503); end
function OnEvent_15504_Out(proxy,param) CloseMenu(proxy,15504); end









--[[
	ユルト殺人事件　 --EN:Yurt Murder Case　
]]
function YURUTO_Murder_Case(proxy)
	--すべての事件はユルト様が石柱に居る事で起きる --EN:--All incidents occur because Yurt-sama is at the stone pillar
	if proxy:IsCompleteEvent( YURUTO_STATE_WAIT_M1 ) or proxy:IsCompleteEvent( YURUTO_STATE_ANGRY_M1 ) then
		--ユルト様が来てからボス撃破数が増えると事件がおきる --EN:--If the number of bosses defeated increases after Yurt-sama arrives, an incident will occur.
		if proxy:GetBossCount() < boss_flagCount then
			--ユルト様と石柱で会話済みなら事件がおきる --EN:--An incident will occur if you have already spoken with Yurt-sama at the stone pillar.
			if proxy:IsCompleteEvent( 8483 ) == true then
				print("YURUTO_Murder_Case begin");
				local isDead = false;
				if MurderGroup_1(proxy) == true then
					isDead = true;
				elseif MurderGroup_2(proxy) == true then
					isDead = true;
				elseif MurderGroup_3(proxy) == true then
					isDead = true;
				elseif MurderGroup_4(proxy) == true then
					isDead = true;
				elseif MurderGroup_5(proxy) == true then
					isDead = true;
				elseif MurderGroup_6(proxy) == true then
					isDead = true;
				elseif MurderGroup_7(proxy) == true then
					isDead = true;
				elseif MurderGroup_8(proxy) == true then
					isDead = true;
				elseif MurderGroup_9(proxy) == true then
					isDead = true;
				else
					print("safe Murder_Case");
				end
				if isDead == true then
					print("Memorize DeadCount! ",boss_flagCount);
					proxy:SetBossCount( boss_flagCount );
				end
				Check_MurderFlags(proxy);
				print("YURUTO_Murder_Case end");
			end			
		end
	end
end

--殺人事件グループ１ --EN:--Murder Case Group 1
function MurderGroup_1(proxy)
	--グループ１は殺害終わっているか？ --EN:--Has Group 1 finished killing?
	if 	proxy:IsCompleteEvent(160) == false or
		proxy:IsCompleteEvent(161) == false or
		proxy:IsCompleteEvent(162) == false then
		
		local kill = false;
		--神の信徒１と話したことがある --EN:--I have spoken with God's follower 1
		if proxy:IsCompleteEvent( 8592 ) == true		--ウル様救出前 --EN:--Before rescuing Uru-sama
		or proxy:IsCompleteEvent( 8601 ) == true then	-- ウル様救出後 --EN:-- After rescuing Mr. Uru
			--神の信徒1が死んでいない? --EN:--God follower 1 is not dead?
			if proxy:IsCompleteEvent( GOD_BELIEVER_1_STATE_DEAD ) == true 		--死んでいる　か  --EN:-- dead
			or proxy:IsCompleteEvent( GOD_BELIEVER_1_STATE_ISNOT ) == true then	--まだいない　ならば --EN:--If not yet
				--kill = false;--念のため --EN:--to make sure
			else
				print("GOD_BELIEVER_1 KILL");			
				kill = true;
				proxy:SetEventFlag(160,true);
				proxy:OpeningDead(682,true);				
			end
		end
		
		--神の信徒２と話した事がある？ --EN:--Have you ever spoken to God's follower 2?
		if proxy:IsCompleteEvent( 8622 ) == true 		--ウル様救出前 --EN:--Before rescuing Uru-sama
		or proxy:IsCompleteEvent( 8628 ) == true then	-- ウル様救出後 --EN:-- After rescuing Mr. Uru
			--神の信徒２が死んでいない? --EN:--God's follower 2 isn't dead?
			if proxy:IsCompleteEvent( GOD_BELIEVER_2_STATE_DEAD ) == true				--死んでいる　か --EN:-- dead
			or proxy:IsCompleteEvent( GOD_BELIEVER_2_STATE_ISNOT ) == true				--まだいない　か --EN:--Not yet
			or proxy:IsCompleteEvent( GOD_BELIEVER_2_STATE_ISNOTALREADY ) == true then	--すでにいない　ならば --EN:-- if not already
				--kill = false;--念のため --EN:--to make sure
			else
				print("GOD_BELIEVER_2 KILL");			
				kill = true;
				proxy:SetEventFlag(161,true);
				proxy:Warp( 683 , 2006 );
				proxy:OnKeyTime2( 683,"GOD_BELIEVER_2KILL",0.1,0,1,once);				
			end
		end
		
		--神の信徒３を殺害予定から排除 --EN:--God follower 3 excluded from killing plan
		--[[
		--神の信徒３と話した事がある？ --EN:--Have you ever spoken to God's follower 3?
		if proxy:IsCompleteEvent( 9072 ) == true		--ウル様救出前 --EN:--Before rescuing Uru-sama
		or proxy:IsCompleteEvent( 9074 ) == true then	-- ウル様救出後 --EN:-- After rescuing Mr. Uru
			--神の信徒３が死んでいない? --EN:--God's follower 3 isn't dead?
			if proxy:IsCompleteEvent( GOD_BELIEVER_3_STATE_DEAD ) == true		--死んでいる　か  --EN:-- dead
			or proxy:IsCompleteEvent( GOD_BELIEVER_3_STATE_ISNOT ) == true then	--まだいない　ならば --EN:--If not yet
				--kill = false;--念のため --EN:--to make sure
			else
				print("GOD_BELIEVER_3 KILL");			
				kill = true;
				proxy:SetEventFlag(162,true);
				proxy:Warp( 684 , 2005 );
				proxy:OnKeyTime2(684,"GOD_BELIEVER_3KILL",0.1,0,1,once);				
			end
		end
		]]
		
		--殺せたかどうかを返す --EN:--Returns whether or not it was killed
		return kill;
	end
	--殺せなかった --EN:--couldn't kill
	return false;
end

function GOD_BELIEVER_2KILL(proxy,param) proxy:OpeningDead(683,true); end
function GOD_BELIEVER_3KILL(proxy,param) proxy:OpeningDead(684,true); end

--殺人事件グループ2 --EN:--Murder Case Group 2
function MurderGroup_2(proxy)
	--殺人グループ2の殺害が終わっているか？ --EN:--Has Murder Group 2 finished killing?
	if proxy:IsCompleteEvent(163) == false then
		--魔術の徒と話した事がある？ --EN:--Have you ever spoken to a sorcerer?
		if	proxy:IsCompleteEvent( 8632 ) == true or	--初めて会話 --EN:--First conversation
			proxy:IsCompleteEvent( 8633 ) == true or	--２回目以降 --EN:--Second time onwards
			proxy:IsCompleteEvent( 8635 ) == true or	--知能が低い --EN:--low intelligence
			proxy:IsCompleteEvent( 9132 ) == true then	--冷たい会話 --EN:--cold conversation
		
			--魔術の徒が死んでいない？ --EN:--Aren't the sorcerers dead?
			if proxy:IsCompleteEvent( MAGIC_STUDENT_STATE_DEAD ) == true		--死んでいる　か  --EN:-- dead
			or proxy:IsCompleteEvent( MAGIC_STUDENT_STATE_ISNOT ) == true then	--まだいない　ならば --EN:--If not yet
				--kill = false;--念のため --EN:--to make sure
			else
				print("MAGIC_STUDENT KILL");
				proxy:SetEventFlag(163,true);
				proxy:Warp( 681 , 2007 );
				proxy:OnKeyTime2( 163,"MAGIC_STUDENTKILL",0.1,0,1,once);				
				return true;
			end
		end
	end
	return false;
end

function MAGIC_STUDENTKILL(proxy,param) proxy:OpeningDead(681,true); end

--殺人事件グループ3 --EN:--Murder Case Group 3
function MurderGroup_3(proxy)
	--殺人グループ3の殺害が終わっているか？ --EN:--Has Murder Group 3 finished killing?
	if proxy:IsCompleteEvent(164) == false then
		--パッチと話した事がある？ --EN:--Have you talked to Patch?
		if proxy:IsCompleteEvent( 8692 ) == true then	--初めて会話 --EN:--First conversation
			--パッチが石柱にいる or 石柱で敵対 --EN:--Patch is on stone pillar or Hostile with stone pillar
			if 	proxy:IsCompleteEvent( BATTI_RESERVE_M1 ) == true or 
				proxy:IsCompleteEvent( BATTI_ANGRY_M1 ) == true then
				print("PATTI KILL");
				proxy:SetEventFlag(164,true);
				proxy:OpeningDead(693,true);
				return true;
			end
		end
	end
	return false;
end

--殺人事件グループ4 --EN:--Murder Case Group 4
function MurderGroup_4(proxy)
	--殺人グループ4の殺害が終わっているか？ --EN:--Has Murder Group 4 finished killing?
	if proxy:IsCompleteEvent(165) == false then
		--ビヨと話した事がある？ --EN:--Have you ever talked to Beyo?
		if proxy:IsCompleteEvent( 8682 ) == true 		--初めて会話 --EN:--First conversation
		or proxy:IsCompleteEvent( 8686 ) == true		--王城４へ移動できる --EN:--You can move to Royal Castle 4
		or proxy:IsCompleteEvent( 8688 ) == true		--魔女がいるらしい --EN:--It seems that there is a witch
		or proxy:IsCompleteEvent( 8687 ) == true then	--魔女を助けてくれたのか？ --EN:--Did you help the witch?
			--ビヨが石柱にいる or 石柱で敵対 --EN:--Biyo is at the stone pillar or hostile at the stone pillar
			if 	proxy:IsCompleteEvent( BIYO_STATE_SEARCH_3 ) == true or
				proxy:IsCompleteEvent( BIYO_STATE_HOSTILE_IN_STONE_PILLAR ) == true then
				print("BIYO KILL")			;
				proxy:SetEventFlag(165,true);
				proxy:OpeningDead(695,true);
				return true;
			end
		end
	end
	return false;
end

--殺人事件グループ5 --EN:--Murder Case Group 5
function MurderGroup_5(proxy)
	--殺人グループ5の殺害が終わっているか？ --EN:--Has Murder Group 5 finished killing?
	if proxy:IsCompleteEvent(166) == false then
		--レンドル王子と話した事がある？ --EN:--Have you ever spoken to Prince Lendl?
		if proxy:IsCompleteEvent( 8652 ) == true then	--初めて会話 --EN:--First conversation
			--レンドル王子が石柱にいる 王城１探索　王城２探索　王城３探索　隠れている　石柱で敵対 --EN:--Prince Lendl is at the stone pillar Royal castle 1 search Royal castle 2 search Royal castle 3 search Hidden Stone pillar hostile
			if 	proxy:IsCompleteEvent( RENDOL_STATE_SEARCH_1 ) == true or
				proxy:IsCompleteEvent( RENDOL_STATE_SEARCH_2 ) == true or
				proxy:IsCompleteEvent( RENDOL_STATE_SEARCH_3 ) == true or
				proxy:IsCompleteEvent( RENDOL_STATE_LOCATION_INVISIBLE ) == true or
				proxy:IsCompleteEvent( RENDOL_STATE_HOSTILE_STONE_PILLAR ) == true then
				print("RENDOL KILL");
				proxy:SetEventFlag(166,true);
				proxy:OpeningDead(688,true);
				return true;
			end
		end
	end
	return false;	
end

--殺人事件グループ6 --EN:-- Murder Group 6
function MurderGroup_6(proxy)
	--殺人グループ6の殺害が終わっているか？ --EN:--Has Murder Group 6 finished killing?
	if proxy:IsCompleteEvent(167) == false then
		--ウルベインと話した事がある？ --EN:--Have you spoken to Urbain?
		if proxy:IsCompleteEvent( 8642 ) == true		--初めて会話 --EN:--First conversation
		or proxy:IsCompleteEvent( 8635 ) == true then	--信仰が低い --EN:--low faith
			--ウルベインが石柱にいる --EN:--Urbain is at the stone pillar
			if 	proxy:IsCompleteEvent( URUBAIN_STATE_STONE_PILLAR ) == true or
				proxy:IsCompleteEvent( URUBAIN_STATE_STONE_PILLAR_ANGRY ) == true then
				print("URUBAIN KILL");
				proxy:SetEventFlag(167,true);
				proxy:OpeningDead(690,true);
				--
				--神の信徒1が死んでいない? --EN:--God follower 1 is not dead?
				if proxy:IsCompleteEvent( GOD_BELIEVER_1_STATE_DEAD ) == true 		--死んでいる　か  --EN:-- dead
				or proxy:IsCompleteEvent( GOD_BELIEVER_1_STATE_ISNOT ) == true then	--まだいない　ならば --EN:--If not yet
					--kill = false;--念のため --EN:--to make sure
				else
					print("ウルベイン死んだから信徒１ KILL");			 --EN:print("Since Urbain died, follower 1 KILL");
					--kill = true;
					proxy:SetEventFlag(160,true);
					proxy:OpeningDead(682,true);				
				end
				--神の信徒２が死んでいない? --EN:--God's follower 2 isn't dead?
				if proxy:IsCompleteEvent( GOD_BELIEVER_2_STATE_DEAD ) == true				--死んでいる　か --EN:-- dead
				or proxy:IsCompleteEvent( GOD_BELIEVER_2_STATE_ISNOT ) == true				--まだいない　か --EN:--Not yet
				or proxy:IsCompleteEvent( GOD_BELIEVER_2_STATE_ISNOTALREADY ) == true then	--すでにいない　ならば --EN:-- if not already
					--kill = false;--念のため --EN:--to make sure
				else
					print("ウルベイン死んだから信徒２ KILL");			 --EN:print("Since Urbain died, follower 2 KILL");
					--kill = true;
					proxy:SetEventFlag(161,true);
					proxy:Warp( 683 , 2006 );
					proxy:OnKeyTime2( 683,"GOD_BELIEVER_2KILL",0.1,0,1,once);				
				end
				
				return true;
			end
		end
	end
	return false;
end

--殺人事件グループ7 --EN:--Murder Case Group 7
function MurderGroup_7(proxy)
	--殺人グループ7の殺害が終わっていない --EN:-- Murder Group 7 not finished killing
	if proxy:IsCompleteEvent(168) == false then
		--ロガーンと話した事がある？ --EN:--Have you ever spoken to Logan?
		if 	proxy:IsCompleteEvent( 8422 ) == true or	--始めて会話 --EN:--First conversation
			proxy:IsCompleteEvent( 8428 ) == true or	--知能が低い --EN:--low intelligence
			proxy:IsCompleteEvent( 8432 ) == true then	--冷たい会話 --EN:--cold conversation
			
			--ロガーンが石柱にいる --EN:--Logan is at the stone pillar
			if 	proxy:IsCompleteEvent( ROGARN_STATE_WAIT ) == true or
				proxy:IsCompleteEvent( ROGARN_STATE_ANGRY_M1 ) == true or
				proxy:IsCompleteEvent( ROGARN_STATE_LAST_WARD ) == true then
				print("ROGARN KILL");
				proxy:SetEventFlag(168,true);
				proxy:OpeningDead(617,true);
				--
				--魔術の徒が死んでいない？ --EN:--Aren't the sorcerers dead?
				if proxy:IsCompleteEvent( MAGIC_STUDENT_STATE_DEAD ) == true		--死んでいる　か  --EN:-- dead
				or proxy:IsCompleteEvent( MAGIC_STUDENT_STATE_ISNOT ) == true then	--まだいない　ならば --EN:--If not yet
					--kill = false;--念のため --EN:--to make sure
				else
					print("ロガーンが死んだので魔術の徒 KILL"); --EN:print("Magician KILL because Logan is dead");
					proxy:SetEventFlag(163,true);
					proxy:Warp( 681 , 2007 );
					proxy:OnKeyTime2( 163,"MAGIC_STUDENTKILL",0.1,0,1,once);									
				end
				return true;
			end		
		end
	end
	return false;
end

--殺人事件グループ8 --EN:--Murder Case Group 8
function MurderGroup_8(proxy)
	--殺人グループ8の殺害が終わっていない --EN:--Killing Group 8 not finished killing
	if proxy:IsCompleteEvent(169) == false then
		--魔女と話した事がある？ --EN:--Have you ever talked to a witch?
		if proxy:IsCompleteEvent( 8502 ) == true then	--初めて会話 --EN:--First conversation
			--魔女が石柱にいる --EN:--the witch is on the stone pillar
			if 	proxy:IsCompleteEvent( MAJO_STATE_WAIT_M1 ) == true or
				proxy:IsCompleteEvent( MAJO_STATE_ANGRY_M1 ) == true then
				print("MAJO KILL");
				proxy:SetEventFlag(169,true);
				proxy:OpeningDead(689,true);
				return true;
			end			
		end
	end
	return false;
end

--殺人事件グループ9 --EN:-- Murder Group 9
function MurderGroup_9(proxy)
	--[[
	--殺人グループ9の殺害が終わっていない --EN:-- Murder Group 9 not finished killing
	if proxy:IsCompleteEvent(170) == false or proxy:IsCompleteEvent(171) == false then
		local kill = false;
		--ボールドウィンと話した事がある？ --EN:--Have you talked to Baldwin?
		if proxy:IsCompleteEvent( 9042 ) == true then
			--ボールドウィンが石柱にいる --EN:--Baldwin is at the stone column
			if 	proxy:IsCompleteEvent( BALDWIN_STATE_WORK ) == true or
				proxy:IsCompleteEvent( BALDWIN_STATE_HOSTILE ) == true then
				print("BALDWIN KILL");
				proxy:SetEventFlag(170,true);
				proxy:OpeningDead( 694,true );
				kill = true;
			end
		end
		
		--トマスと話した事がある？ --EN:--Have you talked to Thomas?
		if proxy:IsCompleteEvent( 8512 ) == true		--初めて会話 --EN:--First conversation
		or proxy:IsCompleteEvent( 8515 ) == true then	--アクセ持ち会話 --EN:--Accessory Conversation
			--トマスが石柱にいる --EN:--Thomas is at the pillar
			if 	proxy:IsCompleteEvent( TOMASU_STATE_WAIT ) == true or
				proxy:IsCompleteEvent( TOMASU_STATE_ANGRY ) == true then
				print("TOMASU KILL");
				proxy:SetEventFlag(171,true);
				proxy:OpeningDead(687,true);
				kill = true;
			end
		end
		return kill;
	end
	]]
	return false;
end

--殺人イベントフラグを全てチェック --EN:--check all murder event flags
function Check_MurderFlags(proxy)
	local count = 0;
	for idx =163 , 171, 1 do
		if proxy:IsCompleteEvent( idx ) == true then
			count = count +1;
		end
	end
	
	if count >=1 then
		proxy:SetEventFlag( 284 ,true );
		print("Set Murder flag");
	end
end
