
--------------------------------------------------------------------------------------
--マップ読み込み時に読まれる初期化処理■ --EN:--Initialization process read when reading the map ■
--------------------------------------------------------------------------------------
function Initialize_m03_00_00_00(proxy)
	print("Initialize_m03_00_00_00 begin");

--■999999■フレーム遅れの初期化処理イベントを発行■ --EN:-- ■ 999999 ■ Generate a frame delay initialization processing event ■
	proxy:NotNetMessage_begin();
		--▼0秒後▼-- --EN:--▼After 0 seconds▼--
		proxy:OnKeyTime2( 999990, "Second_Initialize_m03_00_00_00", 0.0, 0, 0, once );	
	proxy:NotNetMessage_end();	

	print("Initialize_m03_00_00_00 end");
end

--------------------------------------------------------------------------------------
--Initializeから呼ばれる、1フレーム遅れの初期化処理■999999 --EN:--Initialization with a delay of 1 frame, called from Initialize ■999999
--------------------------------------------------------------------------------------
function Second_Initialize_m03_00_00_00(proxy, param)
	print("Second_Initialize_m03_00_00_00 begin");
	print("Second_Initialize_m03_00_00_00 end");
end


--------------------------------------------------------------------------------------
--マルチになった時にホストじゃ無かったら■無し --EN:--If you are not a host when you become multi, no
--------------------------------------------------------------------------------------
function ConnectPartyEvent(proxy)
	print("ConnectPartyEvent begin");
	print("ConnectPartyEvent end");
end
