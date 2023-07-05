
FIREDAM_WAIT = 2.0;

--���h�����̏�Ԉꗗ --EN:--�� Doran's status list
DORAN_STATE_GUARD 		= 16280;--��_����� --EN:--Protect the Mausoleum
DORAN_STATE_ALLOWED		= 16281;--�����Ă��ꂽ --EN:--forgive me
DORAN_STATE_NOT_ALLOWED	= 16282;--���������Ȃ� --EN:--I will not forgive you anymore
DORAN_STATE_DEAD		= 16283;--���S --EN:--death

doran_flag_list = {
	DORAN_STATE_GUARD 		,
	DORAN_STATE_ALLOWED 	,
	DORAN_STATE_NOT_ALLOWED ,
	DORAN_STATE_DEAD 
};

--�z�ꕺ�m�V���b�v�̏�Ԉꗗ --EN:--Slave soldier shop status list
DOREISOL_SHOP_SELL01	= 16083;	--�ړ�������(����1) --EN:--I want to move (Castle 1)
DOREISOL_SHOP_HOSTILE01 = 16084;	--�G��(����1) --EN:-- Hostility (Castle 1)
DOREISOL_SHOP_DEAD		= 16082;	--���S --EN:--death
DOREISOL_SHOP_SELL02	= 16080;	--�ړ�������(����2) --EN:--I want to move (Castle 2)
DOREISOL_SHOP_HOSTILE02 = 16081;	--�G��(����2) --EN:-- Hostility (Castle 2)
DOREISOL_SHOP_SELL03	= 16085;	--�ړ�������(����3) --EN:--I want to move (Castle 3)
DOREISOL_SHOP_HOSTILE03 = 16086;	--�G��(����3) --EN:-- Hostility (Castle 3)

DOREISOL_SHOP_Flag_list = {
	DOREISOL_SHOP_SELL01,
	DOREISOL_SHOP_HOSTILE01,
	DOREISOL_SHOP_DEAD,
	DOREISOL_SHOP_SELL02,
	DOREISOL_SHOP_HOSTILE02,
	DOREISOL_SHOP_SELL03,
	DOREISOL_SHOP_HOSTILE03
}

--�z�ꕺ�m�̃V���b�v���G�΂��邽�߂̃_���[�W�l --EN:--Damage value for slave soldiers shop hostile
DoreiShop_TotalDamage = 100;


--------------------------------------------------------------------------------------
--�}�b�v�ǂݍ��ݎ��ɓǂ܂�鏉���������� --EN:--Initialization process read when reading the map ��
--------------------------------------------------------------------------------------
function Initialize_m02_00_00_00(proxy)
	print("Initialize_m02_00_00_00 begin");
	
	proxy:LuaCall( 99999 , 0 , "OnEvent_4000_Hp_1",everytime);
--��0�����J�����o�[��--PC���C�x���g�G���A(1000)�̒��ɋ���(1.5m)�L���p(30�x��)�ŃA�N�V�����{�^���������� --EN:-- �� 0 �� castle gate opening lever �� -- PC pressed the action button at a distance (1.5m) effective angle (30 degrees width) in the event area (1000)
		
	--�{�X�������Ă���Ƃ������Ď��ǉ� --EN:--Added monitoring only when the boss is alive
	if proxy:IsCompleteEvent( 4096 ) == false then	
		if proxy:IsCompleteEvent( 0 ) ==false then
			proxy:OnDistanceAction( 0, LOCAL_PLAYER, 1000, "OnEvent_0", LeverDist_A, HELPID_PULL_LEVER, 0, LeverAngle_A, once);
			proxy:LuaCall(0,1,"OnEvent_0_4",once);
			proxy:NotNetMessage_begin();
				proxy:LuaCall(0,REMO_START,"OnEvent_0_RemoStart",once);
				proxy:LuaCall(0,REMO_FINISH,"OnEvent_0_RemoFinish",once);
			proxy:NotNetMessage_end();
			proxy:SetDrawEnable( 1008 , false );
			proxy:SetColiEnable( 1008 , false );
		else
			proxy:EndAnimation( 1000, 1 );--���o�[�A�j�����I�� --EN:--End lever animation
			proxy:EndAnimation( 1001, 1 );--���傪�J���A�j�����I�� --EN:--End the animation of the main gate opening
			proxy:EndAnimation( 1140, 1 );--�M�A�������A�j�����I�� --EN:--Finish animation with moving gears
		end
	else
		proxy:EndAnimation( 1000, 1 );--���o�[�A�j�����I�� --EN:--End lever animation
		proxy:EndAnimation( 1001, 1 );--���傪�J���A�j�����I�� --EN:--End the animation of the main gate opening
		proxy:EndAnimation( 1140, 1 );--�M�A�������A�j�����I�� --EN:--Finish animation with moving gears
	end
	
--��4096��������ւ̔��J�������{�X���S��-- --EN:-- �� 4096 �� Opening the door to the inside of the castle �� When the middle boss dies --
	proxy:AddFieldInsFilter( 800 );
	if proxy:IsCompleteEvent( 4096 ) ==false then		
		proxy:OnCharacterDead(4096, 800, "OnEvent_4096", once);
	else
		proxy:EndAnimation( 1002, 1 );
	end
	

--��10�����o�[����ŏ�哃�E�̔��J����--PC���C�x���g�G���A(1005)�̒��ɋ���(1.5m)�L���p(30�x��)�ŃA�N�V�����{�^���������� --EN:--��10��Open the door on the right side of the castle gate tower with the lever operation��--The PC pressed the action button within the event area (1005) at a distance (1.5m) and an effective angle (30 degrees width).
	if proxy:IsCompleteEvent( 10 ) ==false then
		--���J���z�M�p --EN:--For door-open delivery
		--�A�N�V�����Ď��ǉ� --EN:--Add action monitor
		proxy:OnDistanceAction( 10, LOCAL_PLAYER, 1005, "OnEvent_10", LeverDist_A, HELPID_PULL_LEVER, 0, LeverAngle_A, once);
		
	else
		proxy:EndAnimation( 1003, 1 );--���A�j�����I�� --EN:--End door animation
		proxy:EndAnimation( 1005, 1 );--���o�[�A�j�����I�� --EN:--End lever animation
	end

--��110���{�X�����ɓ��遡 --EN:-- �� 110 �� Enter the boss room ��
	
	--���{�X�������Ă���Ƃ������C�x���g�o�^ --EN:-- Event registration only when the mid-boss is alive
	if proxy:IsCompleteEvent( 4096 ) == false then
	
		--�\���̂Ƃ��͈�x�ڂɃ{�X�����ɓ���p�̃C�x���g�𖈉�o�^���������̂ŁA�Ή�����t���O��OFF�ɂ���B --EN:-- When soloing, we want to register the event for entering the boss room for the first time every time, so turn off the corresponding flag.
		SingleReset(proxy, 110);
	
		--�������A�j���Đ��p�̊J�n�n���h��(���񁨕���) --EN:--�� Start handler for synchronous animation playback (turning �� walking)
		proxy:LuaCall( 111, 1, "OnEvent_111_1", everytime );
		
		--��2��ڈȍ~�Ƀ{�X�����ɓ��邽�߂̃C�x���g�z�M�p --EN:--��For event delivery to enter the boss room after the second time
		proxy:LuaCall( 111 , 5 , "OnEvent_110_GO_TO_IN" , everytime );
		
		--���t���O�Z�b�g(�����p) --EN:--��flag set (for synchronization)
		proxy:LuaCall( 111 , 6 , "OnEvent_110_flag_set" , everytime );
		
		--�N�����{�X�O�����܂��ʉ߂��Ă��Ȃ� --EN:--Someone hasn't passed through the boss front door yet
		if proxy:IsCompleteEvent( 110 ) == false then
		
			--(�Z�b�V��������)�{�X�O�̖��@�ǂ��ŏ��ɒʂ��̂͐����̐l���� --EN:--(During the session) Only survivors can pass through the magic wall in front of the boss first
			local possible_chr_type = ATTR_HOST + ATTR_LIVE + ATTR_GREY;
			
			proxy:NotNetMessage_begin();
				--��110�������J���Ă���Ƃ��ɒ��ɓ��邽�߂̃C�x���g��ǉ��� --EN:--��110�� Added an event to enter when the door is open��
				proxy:OnPlayerActionInRegionAttribute( 110, 2895, "OnEvent_110", HELPID_GO_TO_IN, possible_chr_type, everytime );
			proxy:NotNetMessage_end();
		
		else --�O���C�S�[�X�g�ł����Ƃ��悤�ɂ���Ǝv����B --EN:--Gray ghost seems to be like that when it's done.
		
			proxy:NotNetMessage_begin();
				--��111�������J���Ă���Ƃ��ɒ��ɓ��邽�߂̃C�x���g��ǉ��� --EN:--��111�� Added an event to enter when the door is open��
				proxy:OnPlayerActionInRegion( 111, 2895, "OnEvent_110", HELPID_GO_TO_IN, everytime );--�n���h���͏�Ɠ��� --EN:--handler is the same as above
			proxy:NotNetMessage_end();
		
		end

		--��荇�����t�@�����N�X�����̂ݑΉ� --EN:--For now, only phalanx rooms are supported
		--�{�X�p�A�^���؂�ւ� --EN:-- Switch Atari for Boss
		print("�{�X�����A�^���{�X�p"); --EN:print("For Boss Room Atari Boss");
		proxy:SetColiEnableArray(3010,false);--�ʏ햳��		 --EN:--usually disabled
		proxy:SetColiEnableArray(3002,true);--�{�X�p�L�� --EN:--Valid for Boss
		proxy:SetColiEnableArray(3001,true);--�{�X�p�L��		 --EN:--Valid for Boss
		
	else
		--��荇�����t�@�����N�X�����̂ݑΉ� --EN:--For now, only phalanx rooms are supported
		--�{�X�p�A�^���؂�ւ� --EN:-- Switch Atari for Boss
		print("�{�X�����A�^���ʏ�"); --EN:print("Boss Room Atari Normal");
		proxy:SetColiEnableArray(3010,true);--�ʏ�L��		 --EN:--usually valid
		proxy:SetColiEnableArray(3002,false);--�{�X�p���� --EN:--disabled for boss
		proxy:SetColiEnableArray(3001,false);--�{�X�p���� --EN:--disabled for boss
	end

	
--��114���{�X�퓬�J�n��	 --EN:-- �� 114 �� Boss battle begins ��
	if proxy:IsCompleteEvent( 4096 ) == false then
		proxy:OnRegionJustIn( 114 , LOCAL_PLAYER , 2887 , "OnEvent_114" , once );
		proxy:LuaCall( 114 , 10 , "OnEvent_114_1",everytime);
	end	
	
	--[[
	proxy:NotNetMessage_begin();
		proxy:OnRegionJustIn( 450, LOCAL_PLAYER , 2887 , "OnEvent_450_In",everytime );
		proxy:OnRegionJustOut( 450 , LOCAL_PLAYER , 2887 , "OnEvent_450_Out",everytime );
	proxy:NotNetMessage_end();
	]]
	
--��50�����o�[�Ή����i���j��PC���C�x���g�G���A(1006)����(1.5m)�����p(180�x��)�ŃA�N�V�����{�^���������� --EN:-- �� 50 �� Lever compatible door (left) �� PC pressed the action button in the event area (1006) distance (1.5m) reaction angle (180 degree width)
	if proxy:IsCompleteEvent( 50 ) ==false then
		--�A�N�V�����Ď��ǉ� --EN:--Add action monitor
		proxy:OnDistanceAction( 50, LOCAL_PLAYER, 1006, "OnEvent_50", LeverDist_A, HELPID_PULL_LEVER, 0, LeverAngle_A ,once);
	else
		proxy:EndAnimation( 1004, 1 );--���A�j�����I�� --EN:--End door animation
		proxy:EndAnimation( 1006, 1 );--���o�[�A�j�����I�� --EN:--End lever animation
	end

--��70���Β��Ƀ��[�v�� --EN:-- �� 70 �� Warp to the stone pillar ��
	SingleReset(proxy,70);
	proxy:TreasureDispModeChange2( 1983 , true ,KANAME_SFX);
	proxy:OnDistanceAction( 70 , LOCAL_PLAYER , 1983 , "OnEvent_70" , WarpGimmickDist_A , HELPID_GO_TO_SEKITYUU , 0 , 180, everytime );


--�J���X�C�x���g�����s�[�g�����邽�߂�SingleReset() --EN:--SingleReset() to repeat the crow event
	local actionId_list = { 350 , 351 ,353 , 354,355,356,357,358,359,360,361,362,363,364,365,366,367,368,369,370,371,372,373,374,375};	
	local num = table.getn( actionId_list );
	for IndexID = 1, num , 1 do
		SingleReset(proxy, actionId_list[ IndexID ]);
	end

--�J���X���o�b���߂Â��Ɣ�ї��� --EN:--A crow takes off when a PC approaches
	for KarasuID = 1, num, 1 do
		if proxy:IsCompleteEvent( actionId_list[ KarasuID ] ) == false then
			proxy:OnPlayerDistanceInTarget( actionId_list[ KarasuID ], LOCAL_PLAYER, 740 + actionId_list[KarasuID], "OnEvent_"..actionId_list[KarasuID], 5, once );
		else
			proxy:SetDrawEnable(740 + actionId_list[KarasuID], false);
			proxy:SetColiEnable(740 + actionId_list[KarasuID], false);		
		end
	end

--��90�����ǂ��󂵂ēG����яo���Ă��遡 --EN:-- �� 90 �� Destroy the thin wall and the enemy will jump out ��
	
	--[[2008.06.28/toyohide �Ƃ肠���� --EN:--[[2008.06.28/toyohide
	if proxy:IsCompleteEvent( 90 ) == false then
		proxy:OnRegionJustIn( 90, LOCAL_PLAYER, 2040, "OnEvent_90" , once );
	else
		proxy:EndAnimation( 1120 , 1 );
	end
	]]
	proxy:EndAnimation( 1120 , 1 );
	
--��91�����ǂ��󂵂ēG����яo���Ă���2�� --EN:--�� 91 �� Destroy the thin wall and the enemy will jump out 2 ��
	if proxy:IsCompleteEvent( 91 ) == false then
		proxy:SetSuperArmor( 215 , true );
		proxy:SetSuperArmor( 216 , true );
		proxy:OnRegionJustIn( 91, LOCAL_PLAYER, 2041, "OnEvent_91" , once );
	else
		proxy:EndAnimation( 1121 , 1 );
		proxy:EndAnimation( 1122 , 1 );
	end


	
--��180����ʕ��m���~��Ă��遡 --EN:-- �� 180 �� Common soldiers descend ��
	if proxy:IsCompleteEvent( 180 ) == false then
		proxy:SetSuperArmor( 211 , true );
		proxy:SetSuperArmor( 206 , true );
		proxy:OnRegionJustIn( 180 , LOCAL_PLAYER , 2100 , "OnEvent_180" , once );--�̈�p --EN:--for area
		proxy:OnSimpleDamage( 182 , 211 , LOCAL_PLAYER , "OnEvent_180_00" , once );--�U���󂯂��p(ID:211) ��ID --EN:--For being attacked (ID: 211) Another ID
		proxy:OnSimpleDamage( 183 , 206 , LOCAL_PLAYER , "OnEvent_180_01" , once );--�U���󂯂��p(ID:206) ��ID --EN:--For being attacked (ID: 206) Another ID
	else

	end
	
	
--��200�����Y��ւ̔��� --EN:-- �� 200 �� Door to execution ground ��
	SingleReset(proxy,200);
	if proxy:IsClient() == false then
		if	proxy:IsSuccessQWC(20600) == true or 
			proxy:IsSuccessQWC(20300) == true or 
			proxy:IsCompleteEvent(201) == true then
			proxy:SetEventFlag( 200, true );	
		end
	end
	
	if proxy:IsCompleteEvent( 200 ) == false then
		--[[
		proxy:NotNetMessage_begin();
			proxy:OnDistanceAction( 200, LOCAL_PLAYER, 1040, "OnEvent_200", DoorDist_A, HELPID_OPEN, 180, DoorAngle_A, everytime ); 
		proxy:NotNetMessage_end();	
		proxy:LuaCall( 200, 1, "OnEvent_200_1", once );--�A�j���[�V���������p --EN:--For animation synchronization
		]]
	else
		proxy:EndAnimation( 1040, 1 );
	end
	
--��201�����Y��̔��𒴂����� --EN:-- �� 201 �� Beyond the door of the execution ground ��
	if proxy:IsCompleteEvent( 201 ) == false then
		if proxy:IsClient() == false then
			proxy:NotNetMessage_begin();
				proxy:OnRegionIn( 201 , 10000 , 2020 , "OnEvent_201",once);
			proxy:NotNetMessage_end();
		end
	else
	
	end
	
--��210����_�ւ̔��� --EN:--��210��The door to the mausoleum��
	--[[
	if proxy:IsCompleteEvent( 210 ) == false then
		
		proxy:NotNetMessage_begin();
			proxy:OnDistanceAction( 210, LOCAL_PLAYER, 1045, "OnEvent_210", DoorDist_A, HELPID_OPEN, 0, DoorAngle_A, everytime ); 
		proxy:NotNetMessage_end();
		
		proxy:LuaCall( 210, 1, "OnEvent_210_1", once );--�A�j���[�V���������p --EN:--For animation synchronization
	else
		proxy:EndAnimation( 1045, 1 );
	end
	]]

--��211����_�ւ̔�2�� --EN:-- �� 211 �� Door to Mausoleum 2 ��
	if proxy:IsCompleteEvent( 211 ) == false then
		
		proxy:NotNetMessage_begin();
			proxy:OnDistanceAction( 211, LOCAL_PLAYER, 1047, "OnEvent_211", DoorDist_A, HELPID_OPEN, 180, DoorAngle_A, everytime ); 
		proxy:NotNetMessage_end();
		
		proxy:LuaCall( 211, 1, "OnEvent_211_1", once );--�A�j���[�V���������p --EN:--For animation synchronization
	else
		proxy:EndAnimation( 1047, 1 );
	end

--��5����_�̍Ւd�� --EN:-- �� 5 �� Mausoleum Altar ��
	if proxy:IsCompleteEvent( 5 ) == false then
		--�h���������ɋ����Ă��� --EN:-- Doran has already forgiven
		if proxy:IsCompleteEvent( 330 ) == true then
	
			--���ׂ�C�x���g���͓̂������܂��A���ׂ��l�̓z�X�gor�V���O���v���C���[�ł� --EN:--The event itself to be examined is synchronized, the person who can be examined is the host or single player
			--proxy:NotNetMessage_begin();
				--�z�X�g�A�����A�O���C�̂ݒ��ׂ邱�Ƃ��ł��� --EN:--Only hosts, survivors, and grays can be examined
				local possible_chr_type = ATTR_HOST + ATTR_LIVE + ATTR_GREY;
				--HELPID���f�����u�����h��p�ɂȂ��� --EN:--HELPID is now exclusive to the Demon brand
				proxy:OnDistanceActionAttribute( 5 , LOCAL_PLAYER , 1192 , "OnEvent_5" , ItemBoxDist_A , 10010130 , 0 , ItemBoxAngle_A ,possible_chr_type, everytime ); 
				proxy:LuaCall( 5,1,"OnEvent_5_2",once);
				proxy:LuaCall( 5,2,"OnEvent_5_3",once);
				proxy:TreasureDispModeChange2( 1192, true ,KEN_SFX);
				--proxy:SetRarity( 1192, 10104 );
			--proxy:NotNetMessage_end();
		end
	else
		proxy:SetDrawEnable( 1192 , false );--�ЂƂ܂��`�悾��OFF --EN:--Only drawing is turned off for the time being
		proxy:SetColiEnable( 1192 , false );
		
		proxy:InvalidSfx( 1192, false );
	end	
	--proxy:TreasureDispModeChange( 1192, true );
	--proxy:SetRarity( 1192, 10104 );
	
--��35��QWC�ɂ��򗳂̖����� --EN:--��35��Disabling flying dragons with QWC
	SingleReset(proxy,35);
	if	proxy:IsSuccessQWC(20400 ) == true then
		proxy:SetEventFlag( 35, true );
	end
	if	proxy:IsCompleteEvent( 35 ) == false then
		--��232���̈�Ď����w��̈�Ƀv���C���[���ЂƂ�ł�����ꍇ�t���OON/�N�����Ȃ��ꍇ�t���OOFF --EN:-- �� 232 �� Area monitoring �� Flag ON when there is even one player in the specified area / Flag OFF when there is no player
			proxy:OnNetRegion( 222, 2039 );
			proxy:OnNetRegion( 223, 2131 );
			proxy:OnNetRegion( 224, 2132 );
			proxy:OnNetRegion( 225, 2133 );
	else
		--�򗳖����� --EN:--Nullify Wyvern
		--InvalidCharactor(proxy, 300);
		--InvalidCharactor(proxy, 301);
	end
	
	
	
	--���������������������򗳂̃l�b�g���[�N�ʒu�񓯊��ݒ聙������������������ --EN:--�������������������� Hiryu network location asynchronous setting ��������������������
	proxy:SetNoNetSync(300,true);
	proxy:SetNoNetSync(501,true);
	proxy:SetNoNetSync(301,true);
	proxy:SetNoNetSync(110,true);
	--������������������������������������������������������������������������	 --EN:--������������������������������������������������������������������������
--��236���򗳂��ő��̕\���ؑ� --EN:-- �� 236 �� Display switching of Hiryu's relatives
	--proxy:OnRegionJustIn( 236, LOCAL_PLAYER, 2190, "HiryuKenzokuCheck", everytime );
	--proxy:OnRegionJustIn( 236, LOCAL_PLAYER, 2191, "HiryuKenzokuCheck", everytime );
	--[[
	�A�T�[�g����ׁ̈A����o�^�Ƀ_�~�[�o�^ --EN:Dummy registration for the first registration to avoid assertion
	]]
	proxy:LuaCall( 199, 1, "dummy", everytime );
	proxy:LuaCall( 221, 1, "dummy", everytime );
	proxy:LuaCall( 221, 2, "dummy", everytime );
	proxy:LuaCall( 190, 1, "dummy", everytime );
	proxy:LuaCall( 190, 2, "dummy", everytime );
	proxy:LuaCall( 191, 1, "dummy", everytime );
	proxy:LuaCall( 191, 2, "dummy", everytime );
	proxy:LuaCall( 230, 1, "dummy", everytime );
	proxy:LuaCall( 230, 2, "dummy", everytime );
	proxy:LuaCall( 231, 1, "dummy", everytime );
	proxy:LuaCall( 231, 2, "dummy", everytime );
	proxy:LuaCall( 232, 1, "dummy", everytime );
	proxy:LuaCall( 232, 2, "dummy", everytime );
	proxy:LuaCall( 800 , 1 , "dummy"   , everytime );--�ҋ@ --EN:--stand-by
	proxy:LuaCall( 800 , 2 , "dummy" , everytime );--�ҋ@2 --EN:--Wait 2
	proxy:LuaCall( 800 , 3 , "dummy" , everytime );--���S�ҋ@ --EN:--wait for death
	proxy:LuaCall( 801 , 1 , "dummy" , everytime );--�u���XA --EN:--Breath A
	proxy:LuaCall( 802 , 1 , "dummy" , everytime );--�u���XB --EN:--Breath B
	proxy:LuaCall( 803 , 1 , "dummy" , everytime );--�u���XC --EN:--Breath C
	proxy:LuaCall( 804 , 1 , "dummy" , everytime );--�w���w�� --EN:--hero hero
	proxy:LuaCall( 806 , 1 , "dummy" , everytime );--���S		 --EN:--death
--��807���򗳂��ő��̕\���ؑ� --EN:-- �� 807 �� Display switching of Hiryu's relatives
	--proxy:OnRegionJustIn( 807, LOCAL_PLAYER, 2390, "HiryuKenzokuCheck", everytime );
	--proxy:OnRegionJustIn( 807, LOCAL_PLAYER, 2391, "HiryuKenzokuCheck", everytime );
	proxy:NotNetMessage_begin();
	--	proxy:LuaCall( 236, 2, "HiryuKenzokuCheck", once );
	proxy:CustomLuaCall( 4060, "HiryuKenzokuCheck", everytime );
	proxy:NotNetMessage_end();
	--��悸�A����P����Ƃ����ݒ�ɂ��Ă��� --EN:--First of all, let's set it to start from the castle 1
	--���R�Ƃ��Ă͉���P����Ȃ�`�F�b�N�|�C���g���o�R�����ɔ򗳂ɉ���Ƃ��N����ɂ����ׂł��B --EN:--The reason is that it's unlikely that you'll meet a wyvern without going through a checkpoint from Castle 1.
	--�����ȑΉ��́A�u���b�N�ړ��������ɌĂяo���n���h����p�ӂ��āA --EN:--The official response is to prepare a handler to be called when the block is moved,
	--�`�F�b�N�|�C���g�𖳎������ȈՃo�b�N���[�h�I�ȍ�肪�ǂ��Ǝv���܂��B --EN:--I think it's good to create a simple back-read that ignores checkpoints.
	--�u���b�N���Ƃɓǂݍ��݂�؂�ւ���̂́A --EN:-- To switch reading for each block,
	--�򗳂���Ƀo�b�N���[�h�������X�V�ׁ̈A�֌W�Ȃ��ꏊ�ŃC�x���g�������̂�h���̂���ȗ��R�ł��B --EN:--The main reason is to prevent events from moving in unrelated places because Hiryu always backreads and forces updates.
	--proxy:LuaCallStartPlus( 236, 2, 2190 );

--��258���z�ꕺ�m�������h�����q��_���̂���߂� --EN:-- �� 258 �� Stop slave soldiers from aiming at Prince Lendl
	--(��Ԕ��蕔���ŊĎ��ǉ�) --EN:--(monitoring added in the state judgment part)
	

--��391�`409���M����(��)�� --EN:-- �� 391�`409 �� barrel explosion (small) ��
--��421�`430���M����(��)�� --EN:-- 421�`430 �� Barrel Explosion (Large) ��
	TaruRegist( proxy,param);
--��6�����m���Ή��r�𓊂��遡 --EN:--�� 6 �� Soldiers throw Molotov cocktails ��
	ThrowFirePotRegist_b1(proxy);
	
--��251�`256���z�ꕺ�m�̎��S�Ď�(�����h�����q����) --EN:--�� 251-256 �� Death Watch for Slave Soldiers (around Prince Lendl)
	DoreiRegist_block1(proxy);
	
	

--��280���݂邳�ꂽ����1���������遡 --EN:-- �� 280 �� Hanging corpse 1 falls ��
	if proxy:IsCompleteEvent( 280 ) == false then
		proxy:OnObjectDestroy( 280 , 1172 , "OnEvent_280" , once );--�݂邵�Ă���R�̔j��Ď� --EN:--Breakage monitoring of hanging cords
	else
		proxy:EndAnimation( 10240 , 1000 );--���̂̂ق��̃A�j�����I�� --EN:--Finish the corpse animation
	end

	
--��281���݂邳�ꂽ����2���������遡 --EN:--��281��The hanging corpse 2 falls��
	if proxy:IsCompleteEvent( 281 ) == false then
		proxy:OnObjectDestroy( 281 , 1174 , "OnEvent_281" , once );--�݂邵�Ă���R�̔j��Ď� --EN:--Breakage monitoring of hanging cords
	else
		proxy:EndAnimation( 10241 , 1000 );--���̂̂ق��̃A�j�����I�� --EN:--Finish the corpse animation
	end

	
--
--��285���C�e�S���S���� --EN:-- �� 285 �� cannonball rumbling ��
	SingleReset( proxy, 285 );
	if proxy:IsCompleteEvent( 285 ) == false then
		proxy:OnObjectDestroy( 285 , 1190 , "OnEvent_285" , once );--���̔j��Ď�	 --EN:-- Box destruction monitoring
	else
		proxy:EndAnimation( 1191 , 1 );--�S���S���A�j���Đ��I�� --EN:--Rumbling animation playback ends
	end
	
--��310�`319���\�E�������X�^�[�o���� --EN:-- �� 310-319 �� Soul Monster Appears ��
	RegistSoulMonster_block1(proxy);
	

--��320���͂���1�~��遡 --EN:-- �� 320 �� Get off the ladder 1 ��
	proxy:OnActionEventRegion(320, 2026, "OnEvent_320", LadderAngle_A, HELPID_DOWN, everytime);
		
--��321���͂���1���遡 --EN:-- �� 321 �� ladder 1 climb ��
	proxy:OnActionEventRegion(321, 2027, "OnEvent_321", LadderAngle_A, HELPID_UP,   everytime);
	
	
--��2���򗳂����ł���|�������Đ����遡 --EN:--�� 2 �� Replay a poly-drama in which flying dragons fly ��
	if proxy:IsCompleteEvent( 2 ) == false then
	
		--proxy:OnRegionJustIn( 2 , LOCAL_PLAYER , 2000 , "OnEvent_2" , once );
	
		proxy:NotNetMessage_begin();
			--�|�����J�n�t�F�[�h��ɌĂ΂��n���h�� --EN:--Handler called after polyplay start fade
			proxy:LuaCall(2,REMO_START,"OnEvent_2_RemoStart",once);
			--�|�����I����ɌĂ΂��n���h�� --EN:--Handler called after the polyplay ends
			proxy:LuaCall(2,REMO_FINISH,"OnEvent_2_RemoFinish",once);
		proxy:NotNetMessage_end();
		OnEvent_2(proxy,param);
	end

--��30���ŏ��̗v�΂̌��������遡 --EN:--��30��The light on the first keystone disappears��
		proxy:OnSessionJustIn( 30 , "OnEvent_30" , everytime );
		
--��31���ŏ��̗v�΂̌����������遡 --EN:-- �� 31 �� The light of the first keystone is restored ��
		proxy:OnSessionJustOut( 31 , "OnEvent_31" , everytime );


	
--��??���p�j�f�[�����̓o�ꁡ�n���h���o�^ --EN:--��??��Appearance of wandering daemon��Handler registration
	proxy:NotNetMessage_begin();
		--�v���C���[���\���Ŏ��S�������ɃL�b�N����܂��B --EN:--Kicked when a player dies solo.
		proxy:LuaCall( 4000, 100, "PlayerDeath_m02_00_00_00", everytime );
		--�v���C���[�������������ɃL�b�N����܂��B --EN:--Kicked when the player is revived.
		proxy:LuaCall( 4032, 100, "PlayerRevive_m02_00_00_00", everytime );
	proxy:NotNetMessage_end();
	
	

--�`�F�b�N�|�C���g�p�̊Ď� --EN:--monitoring for checkpoints
	local check_point_list	= {2190, 2191, 2390, 2590, 2790, 2791};
	local check_point_num	= table.getn(check_point_list);
	for index = 1, check_point_num, 1 do
		proxy:OnRegionJustIn( SYSTEM_CHECK_POINT, LOCAL_PLAYER, check_point_list[index], "CheckPointIn_AttrCheck", everytime );
	end
	--�ŏ���1��`�F�b�N���Ă��� --EN:--Check once first
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( SYSTEM_CHECK_POINT, "InitializeNpc", 0.0, 0, 2, once );
		proxy:OnKeyTime2( SYSTEM_CHECK_POINT, "HiryuOsaCheck",0.0, 0, 3, once );
	proxy:NotNetMessage_end();

	--�`�F�b�N�|�C���g�z�M�p --EN:--For checkpoint delivery
	proxy:LuaCall( SYSTEM_CHECK_POINT, 2, "CheckPointIn", everytime );
	
	if proxy:IsClient() == false then
		if proxy:IsCompleteEvent( 85 ) == false then
			proxy:NotNetMessage_begin();
			proxy:OnRegionJustIn( 85 , LOCAL_PLAYER , 2002 , "OnEvent_85" , once );
			proxy:NotNetMessage_end();
		end
	end
	
	--�����h�����q�̍X�V�����̓z�X�g���Ǘ� --EN:--Prince Lendl's update authority is managed by the host
	if	proxy:IsClient() == false then
		proxy:RequestForceUpdateNetwork( 620 );
		proxy:RequestForceUpdateNetwork( 621 );
		proxy:RequestForceUpdateNetwork( 624 );
		proxy:RequestForceUpdateNetwork( 626 );
	end

	
	--��0�����J�����o�[����������Ă���Ƃ� --EN:-- �� 0 �� When the castle gate opening lever �� is over
	if proxy:IsCompleteEvent( 0 ) == true then

		proxy:DeleteEvent( 230 );--�򗳔��ł���C�x���g�Ď��폜 --EN:--Deletion of flying dragon event monitoring
		
		--���@�ǌ����Ă��� --EN:--I can see the magic wall
		proxy:SetColiEnable( 1999 , true );
		proxy:SetColiEnable( 1995 , true );
	
		proxy:SetDrawEnable( 1999 , true );
		proxy:SetDrawEnable( 1995 , true );
		
		--���@�ǂ�SFX ON --EN:--Magical Wall SFX ON
		proxy:ValidSfx( 1987 );
		proxy:ValidSfx( 1991 );
	else
	
		--���@�Ǐ����Ă��� --EN:--Magic wall is gone
		proxy:SetColiEnable( 1999 , false );
		proxy:SetColiEnable( 1995 , false );
	
		proxy:SetDrawEnable( 1999 , false );
		proxy:SetDrawEnable( 1995 , false );
		
		--���@�ǂ�SFX OFF --EN:--Magic Wall SFX OFF
		proxy:InvalidSfx( 1987 , false );
		proxy:InvalidSfx( 1991 , false );
	end
	
	
--���{�X�֘A�̏��������� --EN:--�� Boss-related initialization processing
	if proxy:IsCompleteEvent( 4096 ) ==true then
		
		--���{�X����ł���Ƃ� --EN:--��When the boss is dead
		--�t�@�����N�X���S --EN:--Phalanx dead
		--m02_00_00_00_eventboss ��Init�ɂċL�q --EN:-- Described in Init of m02_00_00_00_eventboss
		
		--���@�Ǐ����� --EN:--Magic wall disappears
		proxy:SetColiEnable( 1999 , false );
		proxy:SetColiEnable( 1995 , false );
	
		proxy:SetDrawEnable( 1999 , false );
		proxy:SetDrawEnable( 1995 , false );
		
		--���@�ǂ�SFX OFF --EN:--Magic Wall SFX OFF
		proxy:InvalidSfx( 1987 , false );
		proxy:InvalidSfx( 1991 , false );
		

	else
		--���{�X�����Ă���Ƃ�	 --EN:--�� When the boss is alive
		
			--�t�@�����N�X�p�̏��������� --EN:--Initialization process for Phalanx
			--m02_00_00_00_eventboss ��Init�ɂċL�q --EN:-- Described in Init of m02_00_00_00_eventboss
		
		--[[���̕ǂ�\�����Ȃ���΂Ȃ�Ȃ����A��0�����J�����o�[���ł���Ă���]] --EN:--[[I need to display a wall of light, but I'm doing it with ��0�� gate opening lever��]]
	end		
	
	
	--��4103,4105���\�E������A�v�΂Ń��[�v�� --EN:-- �� 4103, 4105 �� Get soul, warp with keystone ��
	if proxy:IsCompleteEvent( 4096 ) ==true then--�{�X������ł���Ƃ� --EN:--when the boss is dead
		
		proxy:TreasureDispModeChange2( 1982 , true ,KANAME_SFX);--���点�� --EN:-- let it shine
		--��(�\�E��)�A�C�e���擾�p�C�x���g�Ď��ǉ��� --EN:--�� (Soul) Added event monitoring for item acquisition��
		if proxy:IsCompleteEvent( 4103 ) == false then
			--SFX�L���� --EN:--SFX enable
			proxy:ValidSfx( 1080 );--���̗��q --EN:--Particles of light
			proxy:ValidSfx( 1081 );--�v�΂̃I�[��			 --EN:--Keystone Aura
			proxy:OnDistanceActionAttribute( 4103 , LOCAL_PLAYER , 1982 , "OnEvent_4103" , WarpGimmickDist_A , 10010180 , 0 , 180 , ATTR_HOST + ATTR_LIVE + ATTR_GREY, once );

			--�\�E���L���� --EN:--Soul activation
			proxy:SetDrawEnable( 1982 , true );
			proxy:SetColiEnable( 1982 , true );
			--�\�E��2�L���� --EN:--Activate Soul 2
			proxy:SetDrawEnable( 1975 , true );
			proxy:SetColiEnable( 1975 , true );

		else
			--SFX OFF
			proxy:InvalidSfx( 1080, false );--���̗��q --EN:--Particles of light
			--proxy:InvalidSfx( 1081, false );--�v�΂̃I�[�� --EN:--Keystone Aura
			--���v�΂Ń��[�v�p�̊Ď���ǉ��� --EN:--�� Added surveillance for warp with keystone ��
			SingleReset(proxy,4105);
			proxy:OnDistanceActionAttribute( 4105 , LOCAL_PLAYER , 1982 , "OnEvent_4105" , WarpGimmickDist_A , HELPID_GO_TO_SEKITYUU , 0 , 180 , ATTR_NOSESSION , everytime );
		end

	else
		--�{�X�������Ă��� --EN:--the boss is alive
		--�\�E�������� --EN:--Soul Invalidation
		proxy:SetDrawEnable( 1982 , false );
		proxy:SetColiEnable( 1982 , false );
		--�\�E��2������ --EN:--Soul 2 disabled
		proxy:SetDrawEnable( 1975 , false );
		proxy:SetColiEnable( 1975 , false );
		
		--SFX OFF
		proxy:InvalidSfx( 1080, false );--���̗��q --EN:--Particles of light
		proxy:InvalidSfx( 1081, false );--�v�΂̃I�[�� --EN:--Keystone Aura
	end

--[[--�폜�Ƃ̎��Ȃ̂ŁA�R�����g�A�E�g --EN:--Comment out because it is about deleting
--��90�����ǂ��󂵂ēG����яo���Ă��遡�L�������� --EN:-- �� 90 �� Destroy the thin wall and the enemy will jump out �� Character control
	
	if proxy:IsCompleteEvent( 90 ) == false then
		proxy:EnableLogic( 202 , 0 );--���W�b�N�����Ă邯�ǁA�G���U�����Ă���? --EN:--The logic is good, but is the enemy attacking?
		proxy:SetDrawEnable( 202 , false );
		proxy:SetColiEnable( 202 , false );
	else
		proxy:EnableLogic( 202 , 1 );
		proxy:SetDrawEnable( 202 , true );
		proxy:SetColiEnable( 202 , true );
	end]]
	
	--��91�����ǂ��󂵂ēG����яo���Ă���2���L�������� --EN:-- �� 91 �� Destroy the thin wall and enemies will pop out 2 �� Character control
	if proxy:IsCompleteEvent( 91 ) == false then
		proxy:EnableLogic( 215 , 0 );
		proxy:SetDrawEnable( 215 , false );
		proxy:SetColiEnable( 215 , false );
		
		proxy:EnableLogic( 216 , 0 );
		proxy:SetDrawEnable( 216 , false );
		proxy:SetColiEnable( 216 , false );
	else
		proxy:EnableLogic( 215 , 1 );
		proxy:SetDrawEnable( 215 , true );
		proxy:SetColiEnable( 215 , true );
		
		proxy:EnableLogic( 216 , 1 );
		proxy:SetDrawEnable( 216 , true );
		proxy:SetColiEnable( 216 , true );
	end
	
	
	--��160���z�ꕺ�m�������Ă��遡���W�b�N���� --EN:-- �� 160 �� Slave soldiers fall �� Logic control
	if proxy:IsCompleteEvent( 160 ) == false then
		proxy:EnableLogic( 220 , false );
		proxy:SetDrawEnable( 220 , false );
		proxy:SetColiEnable( 220 , false );--�ꏊ���ς���Ă����̂ŁA��������������B --EN:--The location has changed, so I erased the area.
	--	proxy:Warp( 220 , 2110 );--��(?)�̂ق��Ƀ��[�v --EN:--Warp to the tower (?)
	else
		proxy:EnableLogic( 220 , 1 );
	end
	
	
	--��180����ʕ��m���~��Ă��遡���W�b�N����	 --EN:-- �� 180 �� Regular soldiers descend �� Logic control
	if proxy:IsCompleteEvent( 180 ) == false then
		
		proxy:Warp( 211 , 2170 );
		proxy:Warp( 206 , 2171 );
		
		proxy:ForceUpdateNextFrame( 211 );
		proxy:ForceUpdateNextFrame( 206 );
		
		proxy:EnableLogic( 211 , 0 );
		proxy:EnableLogic( 206 , 0 );
	else
		proxy:EnableLogic( 211 , 1 );
		proxy:EnableLogic( 206 , 1 );
	end
	
--[[	
	--��181����ʕ��m���~��Ă���2�����W�b�N���� --EN:-- �� 181 �� 2 �� Logic control where general soldiers descend
	if proxy:IsCompleteEvent( 181 ) == false then
		proxy:EnableLogic( 221 , 0 );
	else
		proxy:EnableLogic( 221 , 1 );
	end
]]	


	--�����{�X���S�Ŕ����J��(����ł�����A�`��Ɠ����������) --EN:--�� The door opens when the mid-boss dies (if it dies, the drawing and hits are erased)
	if proxy:IsCompleteEvent( 4096 ) == true then
		proxy:SetColiEnable( 1999 , false );
		proxy:SetColiEnable( 1995 , false );
	
		proxy:SetDrawEnable( 1999 , false );
		proxy:SetDrawEnable( 1995 , false );	
	end
	

--[[
	--���p�j�f�[�����p (�t���O�͉��A�w�肪����Ες���) --EN:--��For wandering daemon (flag is tentative, change if specified)
	if proxy:IsCompleteEvent( 20 ) == true then
		LuaFunc_VisibleTheWanderingDemon  (proxy, param, demon_id_list_m02_00_00_00);
	else
		LuaFunc_InvisibleTheWanderingDemon(proxy, param, demon_id_list_m02_00_00_00);
	end
]]

--[[
	--��220����(��)���Q�Ă��遡 --EN:-- �� 220 �� Wyvern (Long) is sleeping ��
	proxy:EnableLogic( 300 , false );--��(��)���W�b�NOFF --EN:--Hiryu (Long) Logic OFF
	proxy:PlayLoopAnimation( 300 , 7000 );--�x�����Ă���A�j�����[�v�Đ� --EN:-- Alert animation loop playback
	
	if proxy:IsCompleteEvent( 220 ) == true then

		--�̈�Ď���ǉ����Ȃ��� --EN:--re-add region monitor
		proxy:SetEventFlag( 220 , 0 );
		proxy:OnRegionIn( 220 , LOCAL_PLAYER , 2130 , "OnEvent_220" , everytime );
		proxy:SetEventFlag( 220 , 1 );
	
	else
		proxy:PlayLoopAnimation( 300 , 7000 );--�Q�Ă���A�j�����[�v�Đ� --EN:--Sleeping animation loop playback
	end
]]
	
	
	--���̖���ʉ߂ł���L�����^�C�v(���̃^�C�v�̐l�����A�N�V�����{�^������������) --EN:--Character type that can pass through the fog of light (only this type of person reacts to the action button)
	local possible_chr_type = ATTR_HOST + ATTR_LIVE + ATTR_GREY;
	
	--��240���z�X�gPC�݂̂��ʂ����̖��� --EN:--��240��Light fog that only the host PC can pass��
	if proxy:IsCompleteEvent( 240 ) == true then--�z�X�g���ʉߍς� --EN:--Host passed
		proxy:SetDrawEnable( 1055 , false );
		proxy:SetColiEnable( 1055 , false );
		proxy:InvalidSfx(2075, false);
	else
		--��240�����@�Ǎ폜�����p�� --EN:--��240��For synchronizing magic wall deletion��
		proxy:LuaCall( 240 , 1 , "OnEvent_240_delete_wall" , once );
		--��240���ǂ̒��ɓ���C�x���g�����p�� --EN:--��240��For triggering the event to enter the wall��
		proxy:OnDistanceActionAttribute( 240 , LOCAL_PLAYER , 1055 , "OnEvent_240" , 1.5 , HELPID_GO_TO_IN , 180 , DoorAngle_A , possible_chr_type, everytime );
	end
	
	
	--��241���z�X�gPC�݂̂��ʂ����̖��� --EN:-- �� 241 �� A fog of light that only the host PC can pass through ��
	if proxy:IsCompleteEvent( 241 ) == true then--�z�X�g���ʉߍς� --EN:--Host passed
		proxy:SetDrawEnable( 1056 , false );
		proxy:SetColiEnable( 1056 , false );
		proxy:InvalidSfx(2076, false);
	else
		--��241�����@�Ǎ폜�����p�� --EN:--��241��For Synchronizing Magic Wall Deletion��
		proxy:LuaCall( 241 , 1 , "OnEvent_241_delete_wall" , once );
		
		--��241���ǂ̒��ɓ���C�x���g�����p�� --EN:-- �� 241 �� For triggering the event to enter the wall ��
		proxy:OnDistanceActionAttribute( 241 , LOCAL_PLAYER , 1056 , "OnEvent_241" , 1.5 , HELPID_GO_TO_IN , 180 , DoorAngle_A , possible_chr_type, everytime );
	end
	
	
	--��242���z�X�gPC�݂̂��ʂ����̖��� --EN:-- �� 242 �� A fog of light that only the host PC can pass through ��
	if proxy:IsCompleteEvent( 242 ) == true then--�z�X�g���ʉߍς� --EN:--Host passed
		proxy:SetDrawEnable( 1057 , false );
		proxy:SetColiEnable( 1057 , false );
		proxy:InvalidSfx(2077, false);
	else		
		--��242�����@�Ǎ폜�����p�� --EN:--��242��For synchronizing magic wall deletion��
		proxy:LuaCall( 242 , 1 , "OnEvent_242_delete_wall" , once );
		
		--��242���ǂ̒��ɓ���C�x���g�����p�� --EN:--��242��For triggering an event to enter the wall��
		proxy:OnDistanceActionAttribute( 242 , LOCAL_PLAYER , 1057 , "OnEvent_242" , 1.5 , HELPID_GO_TO_IN , 180 , DoorAngle_A , possible_chr_type, everytime );
	end

	


	
	--��285���C�e�S���S���� --EN:-- �� 285 �� cannonball rumbling ��
	if proxy:IsCompleteEvent( 285 ) == true then
		proxy:ReconstructBreak( 1190 , 1 );--���I�u�W�F�̔j��Č� --EN:-- Destroyed box object
	end
	
	
	
	

--����(��)�C�x���g�֘A������ --EN:-- �� Wyvern (Long) event-related initialization

	--������ --EN:--Initialization
	proxy:SetDisableGravity( 300 , true );--�d��OFF --EN:--Gravity off
	proxy:EnableLogic( 300 , false );--�v�lOFF --EN:--Thinking OFF
	proxy:SetSuperArmor( 300 , true );--�_���[�W���[�V���������Ȃ� --EN:--No damage motion
	proxy:SetDeadMode(300, true);--�򗳂͎��ȂȂ��ݒ�(���ɂ����ɂȂ�����P�ނ���) --EN:--Set so that flying dragons don't die (withdraw if they're about to die)
	
	
	--������Ԃ��Z�b�g(��Ԃ����ݒ�̏ꍇ�A�w�肵����Ԃ��Z�b�g����) --EN:--Set the initial state (if the state is not set, set the specified state)
	SetFirstNpcStateFlag( proxy , param , tyo_flag_list , TYO_STATE_WARNING_AISLE );
	
	--���݂̏�Ԏ擾 --EN:-- Get current status
	local now_tyo_state = GetNpcStateFlag( proxy , param , tyo_flag_list );
	
	--�򗳂̒����A���̊�(����4)���炱������ދ����� --EN:--The Chief of the Wyvern secretly leaves the King's Room (Castle 4)
	if now_tyo_state == TYO_STATE_WARNING_KING_ROOM or 
	   now_tyo_state == TYO_STATE_WARNING_GATE      then
	   
		--��(��)�̏�Ԃ��u�x��(�ʘH)�v�ɃZ�b�g --EN:-- Set the status of Hiryu (Long) to "Warning (Passage)"
		SetNpcStateFlag( proxy , param , tyo_flag_list , TYO_STATE_WARNING_AISLE );
	end
	
	--���݂̏�Ԏ擾(��Ԃ��ς�����\��������̂�) --EN:-- get the current state (because the state may have changed)
	local now_tyo_state = GetNpcStateFlag( proxy , param , tyo_flag_list );
	
	--�x��(�ʘH) --EN:--Warning (passageway)
	if now_tyo_state == TYO_STATE_WARNING_AISLE then
		
		proxy:EnableLogic( 300 , false );
		proxy:PlayLoopAnimation( 300 , 7000 );
		
	--���S --EN:--death
	elseif now_tyo_state == TYO_STATE_DEAD then
		InvalidCharactor( proxy , 300 );--���Ȃ����Ƃɥ�� --EN:--Unfortunately...
		
		--��(��)�֘A�C�x���g�폜 --EN:--Deletion of Wyvern (Long) related events
		proxy:DeleteEvent( 220 );--���ŐQ�Ă��� --EN:--sleeping in a nest
	end

	if	proxy:IsCompleteEvent( KENZOKU_2_STATE_DEAD ) == true or
	    proxy:IsCompleteEvent( KENZOKU_STATE_DEAD ) == true then
		proxy:OpeningDead( 301, false );
	end
	
--[[	
	--���݂̏�Ԏ擾 --EN:-- Get current status
	local now_kenzoku_state = GetNpcStateFlag( proxy , param , kenzoku_flag_list );
	
	--��Ԃ��ƂɕK�v�ȏ�����������Ȃ祥� --EN:--if there is any initialization required for each state...
	
	if now_kenzoku_state == KENZOKU_STATE_WARNING or 
       now_kenzoku_state == KENZOKU_STATE_WARNING_AND_LEVER then
		
		--���ɂ��� --EN:--in the nest
		proxy:EnableLogic( 301 , false );
		proxy:PlayLoopAnimation( 301 , 0 );
		
	elseif now_kenzoku_state == KENZOKU_STATE_PROTECT_CASTLE then
	
		--��ǌ���Ă� --EN:--Protecting the ramparts
		--�v���C���[�����Ȃ��Ȃ�����A����ɑ��A��̂ł��̂܂܂ŗǂ��Ǝv����B --EN:--When the player is gone, it will return to the nest without permission, so it seems to be fine as it is.
		
	elseif now_kenzoku_state == KENZOKU_STATE_DEAD    or 
		   now_kenzoku_state == KENZOKU_2_STATE_DEAD then
		   
		InvalidCharactor( proxy , 301 );--���Ȃ����Ƃɥ�� --EN:--Unfortunately...
		
		--��(�ő�)�֘A�C�x���g�폜 --EN:--Deletion of Wyvern (Family) related events
		proxy:DeleteEvent( 221 );--���Ōx�����Ă��� --EN:--Watching in the Nest
		proxy:DeleteEvent( 230 );--��ǂɔ��ł��� --EN:--flying to the ramparts
		
	end
]]
	
--��15610���h�����̎��̂𒲂ׂ��� --EN:--�� 15610 �� Examined Doran's corpse ��
	if proxy:IsCompleteEvent( 15610 ) == false then
		proxy:AddCorpseEvent( 15610 , 697 );
		proxy:NotNetMessage_begin();
			proxy:LuaCall( 15610 ,0 , "OnEvent_15610",once );
 		proxy:NotNetMessage_end();
	end
--���yNPC:�h�����z�C�x���g�֘A������ --EN:--�� [NPC: Doran] Event-related initialization
	SetFirstNpcStateFlag( proxy , param , doran_flag_list , DORAN_STATE_GUARD );
	--�h�����������Ă��邩 --EN:--Is Doran alive?
	if proxy:IsCompleteEvent( DORAN_STATE_DEAD ) == false then
		--�h�������퓬�Ԑ�������Ă��� --EN:-- Doran is ready for battle
		if proxy:IsCompleteEvent(DORAN_STATE_GUARD) == true then
			proxy:OnCharacterHP( 330, 697, "OnEvent_330", 0.8, once );	--�h�����̂g�o��80������������ --EN:--When Doran's HP drops below 80%
			proxy:OnCharacterHP( 331, 697, "OnEvent_331", 0.6, once );	--�h�����̂g�o��60������������ --EN:--When Doran's HP drops below 60%
			if proxy:IsCompleteEvent( 329 ) == false then
				proxy:EnableLogic( 697, false );			
				proxy:OnSimpleDamage( 329 , 697 , 10000 , "OnEvent_329" , once );
				proxy:LuaCall( 329 , 0 , "OnEvent_329",once );
			end
			--���q���Ō�܂ŏ����� --EN:--Saved the prince to the end
			if proxy:IsCompleteEvent( 11790 ) == true then
				print("�h���������"); --EN:print("Take it easy");
				proxy:SendEventRequest( 697 ,0, 1);
				proxy:SetEventSpecialEffect_2( 697 , 5042 );
			end
			
		--�h������PC�������Ă��� --EN:-- Doran forgives PC
		elseif proxy:IsCompleteEvent(DORAN_STATE_ALLOWED) == true then
			proxy:SetTeamType( 697, TEAM_TYPE_Friend );
			proxy:OnCharacterHP( 331, 697, "OnEvent_331", 0.6, once );
		elseif proxy:IsCompleteEvent(DORAN_STATE_NOT_ALLOWED) == true then
		end
		proxy:OnCharacterDead( 332, 697, "OnEvent_332", once );
	--�h����������ł����� --EN:--If Doran were dead
	else
		if proxy:IsCompleteEvent( 15610 ) == true then
			InvalidBackRead( proxy, 697 );
		else
			--���̂��Č����� --EN:--reproduce the corpse
			proxy:OpeningDeadPlus( 697 , true ,false ,false );
		end
	end



	--��280���݂邳��Ă���󎀑́� --EN:--��280��The hanging treasure corpse��
	if proxy:IsCompleteEvent( 280 ) == true then
		proxy:ReconstructBreak( 1172 , 1 );--�R�̔j��Č�(�^�C�~���O�̖��ɂ�襥�) --EN:--Reproduction of string destruction (due to timing issues...)
	else
		--���̂̑ҋ@�A�j��(�݂邳��Ă�����) --EN:--Standby animation of the corpse (hanging state)
		proxy:PlayAnimation( 10240 , 1001 );

		--��V�X�e�������� --EN:--Disable Treasure System
		proxy:EnableObjTreasure( 10240 , false );
	end
	
	--��281���݂邳��Ă���󎀑́� --EN:--�� 281 �� Treasure corpse hanging ��
	if proxy:IsCompleteEvent( 281 ) == true then
		proxy:ReconstructBreak( 1174 , 1 );--�R�̔j��Č� --EN:--Reproduction of string destruction
	else
		--���̂̑ҋ@�A�j��(�݂邳��Ă�����) --EN:--Standby animation of the corpse (hanging state)
		proxy:PlayAnimation( 10241 , 1001 );

		--��V�X�e�������� --EN:--Disable Treasure System
		proxy:EnableObjTreasure( 10241 , false );
	end	
	
--��61���~�����_�����S���Ă���ꍇ�̏����������� --EN:-- �� 61 �� Initialization process when Miralda is dead ��
	SingleReset( proxy, 61 );
	if proxy:IsCompleteEvent( 60 ) == true or
		proxy:IsSuccessQWC(20500) == false then
		proxy:SetEventFlag( 61 , true );
	end
	
--��15605���~�����_���̒��ׂ��� --EN:-- 15605 �� Miralda's corpse examined ��
	if proxy:IsCompleteEvent( 15605 ) == false then 
		proxy:AddCorpseEvent( 15605 , 628 );
		proxy:NotNetMessage_begin();
			proxy:LuaCall( 15605 , 0 , "OnEvent_15605",once);
		proxy:NotNetMessage_end();
	end
	
	if proxy:IsCompleteEvent( 61 ) == true then
		if proxy:IsCompleteEvent( 60 ) == true and proxy:IsCompleteEvent( 15605 ) == false then
			proxy:OpeningDeadPlus( 628 , true ,false ,false );			
		else
			InvalidBackRead( proxy, 628 );
			print("�~�����_��InvalidBackRead���������܂���"); --EN:print("Miralda's InvalidBackRead was successful");
		end
	else
		--��86���̈�ɓ�������t���OON�� --EN:-- �� 86 �� Flag ON when entering area ��
		if proxy:IsCompleteEvent( 86 ) == false then
			proxy:OnRegionJustIn( 86 , 10000 , 2003 , "OnEvent_86",once);
		end
	end
	
	--[[
	--�z�X�g�͕K���o�^����ׁA�ӂ炮���� --EN:--Because the host must be registered,
	if	proxy:IsClient() == false then
		SingleReset( proxy, 62 );
	end
	]]
	
--��15635���~�����_�E�u���b�N�̎��̂𒲂ׂ��� --EN:--�� 15635 �� Examined Miralda Black's corpse ��
	if proxy:IsCompleteEvent( 15635 ) == false then
		proxy:AddCorpseEvent( 15635 , 231 );
		proxy:NotNetMessage_begin();
			proxy:LuaCall( 15635 ,0 , "OnEvent_15635",once );
 		proxy:NotNetMessage_end();
	end	
	
	--���~�����_�E�u���b�N�̏o�����聡 --EN:--�� Appearance judgment of Miralda Black ��
	if	proxy:IsCompleteEvent(62) == true or
		proxy:IsSuccessQWC(20300) == false then
		
		if 	proxy:IsCompleteEvent( 62 ) == true and
			proxy:IsCompleteEvent( 15635 ) == false then
			--���̂��Č����� --EN:--reproduce the corpse
			proxy:OpeningDeadPlus( 231 , true ,false ,false );
		else
			InvalidBackRead( proxy, 231 );
		end
	else
		proxy:OnCharacterDead( 62, 231, "OnEvent_62", once );
		proxy:SetTeamType( 698, TEAM_TYPE_AngryFriend );
	end
	
	
--��60���~�����_�����S�� --EN:-- �� 60 �� Miralda died ��
	if proxy:IsCompleteEvent( 60 ) == false then
		proxy:OnCharacterDead( 60, 628, "OnEvent_60", once );
	end
	
--��86���̈�ɓ�������t���OON�� --EN:-- �� 86 �� Flag ON when entering area ��
	if proxy:IsCompleteEvent( 86 ) == false then
		proxy:OnRegionJustIn( 86 , 10000 , 2003 , "OnEvent_86",once);
	end

--��8084���݂邳��Ă���󎀑́� --EN:--��8084��The hanging treasure corpse��
	proxy:SetEventFlag(8084, true)
--[[	
	--�z�ꕺ�m�̃V���b�vNPC --EN:-- Slave soldier's shop NPC
	if proxy:IsClient() == false then
		--�N���C�A���g���o�^���Ȃ��C�x���g�Ȃ̂ŁA�z�M����ƃN���C�A���g���ŃA�T�[�g���o��ׁA��z�M�ݒ�ɕύX --EN:--This is an event that the client does not register, so if it is delivered, an assert will be issued on the client side, so change to non-delivery setting
		proxy:NotNetMessage_begin();
	--��340���z�ꕺ�m�̃V���b�vNPC�`�F�b�N�|�C���g(���O)�� --EN:--��340��Slave soldier's shop NPC checkpoint (in front of the door)��
		proxy:OnRegionJustIn(343 , LOCAL_PLAYER , 2120 ,"OnEvent_343" , everytime);
	--��340���z�ꕺ�m�̃V���b�vNPC�`�F�b�N�|�C���g(���O)�� --EN:--��340��Slave soldier's shop NPC checkpoint (in front of the door)��
		proxy:OnRegionJustIn(344 , LOCAL_PLAYER , 2191 ,"OnEvent_344" , everytime);
	--��340���z�ꕺ�m�̃V���b�vNPC�`�F�b�N�|�C���g(���O)�� --EN:--��340��Slave soldier's shop NPC checkpoint (in front of the door)��
		proxy:OnRegionJustIn(345 , LOCAL_PLAYER , 2390 ,"OnEvent_345" , everytime);
	--��340���z�ꕺ�m�̃V���b�vNPC�`�F�b�N�|�C���g(���O)�� --EN:--��340��Slave soldier's shop NPC checkpoint (in front of the door)��
		proxy:OnRegionJustIn(780 , LOCAL_PLAYER , 2790 ,"OnEvent_780" , everytime);
		proxy:NotNetMessage_end();
	end
	
	--��635���`�F�b�N�|�C���g�̊Ď��� --EN:-- �� 635 �� Checkpoint monitoring ��
	proxy:LuaCall( 781 , 1 , "OnEvent_781",everytime);

	--�z�ꕺ�m�̏������p --EN:--For initializing slave soldiers
	OnEvent_781(proxy, param);
]]	
	
--��7���G���C�e���낲�끡 --EN:-- �� 7 �� Enemy's cannonball ��
	RegistEvent_7(proxy);
	

--[[--�폜�Ƃ̎��Ȃ̂ŁA�R�����g�A�E�g --EN:--Comment out because it is about deleting
--��10700,10701���݂邳��Ă���l���b�������Ă��遡 --EN:-- �� 10700, 10701 �� The person hanging speaks to you ��
	if proxy:IsCompleteEvent( 10700 ) == false then
		proxy:OnRegionIn( 10700 , LOCAL_PLAYER , 2051 , "OnEvent_10700" , everytime );
		--���̂����b(������) --EN:--Conversation from the corpse (help me)
		proxy:RegistSimpleTalk( 10700 , 10241 , 16000, TALK_ATTR_ALL );
		
		--���̂����b(����) --EN:--Conversation from the corpse (thank you)
		proxy:RegistSimpleTalk( 10701, 10241, 16010, TALK_ATTR_ALL );
	end]]
	

--��15500�������A�C�e���擾�Ď����n���h���̓O���[�o���ɒ�` --EN:-- �� 15500 �� Intrusion item acquisition monitoring �� Handlers are defined globally
--~     if proxy:IsCompleteEvent( 15500 ) == false then
--~         proxy:AddCorpseEvent( 15500 , 231 );--�~�����_�E�u���b�N		 --EN:--Miralda Black
--~     end
	
	
--��100��������΃_���[�W�� --EN:-- �� 100 �� bonfire damage ��
	local objIdlist = {1180,1181,1182,1183,1185,1186};
	local num = table.getn( objIdlist );
	local sec = FIREDAM_WAIT;
	for index=1 , num ,1 do
		proxy:NotNetMessage_begin();	
			proxy:OnObjectDamageHit_NoCallPlus( 100, objIdlist[index],1,10300,EV_HIT_CHR,0.5,-1,2.0,everytime);
			--proxy:OnKeyTime2( 100, "OnEvent_100_"..objIdlist[index],sec,0,objIdlist[index],once);		
		proxy:NotNetMessage_end();
		--proxy:OnDistanceJustIn(100,10000,objIdlist[index],"OnEvent_100_"..objIdlist[index],0.5,everytime);		
		sec = sec + 0.1;
	end
	
	
	--��8����ʕ��m���Ή��r�����遡 --EN:-- �� 8 �� Ordinary soldiers throw Molotov cocktails ��
	SingleReset( proxy, 8 );
	if proxy:IsCompleteEvent( 8 ) == false then
		proxy:OnRegionJustIn( 8, 10000 , 2007 , "OnEvent_8" , once);
		proxy:OnSimpleDamage( 8, 247 , 10000 , "OnEvent_8" , once);
		
		proxy:OnRegionJustIn( 9, 10000 , 2008 , "OnEvent_9" , once);
		
		proxy:EnableLogic( 247, false );
	end
	
	
	--�����g�J�Q���S�C�x���g --EN:--Crystal Lizard Escape Event
	RegistTokage(proxy,120,250,0);	
	
	--��999999���t���[���x��̏����������C�x���g�𔭍s�� --EN:-- �� 999999 �� Generate a frame delay initialization processing event ��
	proxy:NotNetMessage_begin();
		--��0�b�づ-- --EN:--��After 0 seconds��--
		proxy:OnKeyTime2( 999990, "Second_Initialize_m02_00_00_00", 0.3, 0, 0, once );	
	proxy:NotNetMessage_end();
	
	proxy:LuaCall(4081, 2, "hiryuu_test_1", everytime );
	proxy:LuaCall(4081, 3, "hiryuu_test_2", everytime );
	
	if proxy:IsDbgReLoad() == true then
		proxy:OnKeyTime2( 4021,"OnEvent_DbgReLoad",1.0,0,0,once);
	end
	print("Initialize_m02_00_00_00 end");
end

--�����[�h�f�o�b�O --EN:--reload debug
function OnEvent_DbgReLoad(proxy,param)
	--�Β��̉���v�΂� --EN:--To the keystone of the royal castle of the stone pillars
	--���S�񕜗v�� --EN:-- full recovery request
	proxy:RequestFullRecover();
	proxy:WarpNextStage( 1, 0, 0, 0, 1006 );	
end


function hiryuu_test_1(proxy,param)
	print("hiryuu_test_1 begin");
	proxy:PlayAnimation( 300, 7018 );
	print("hiryuu_test_1 end");
end

function hiryuu_test_2(proxy,param)
	print("hiryuu_test_2 begin");
	proxy:PlayAnimation( 301, 7011 );
	print("hiryuu_test_2 end");
end


--------------------------------------------------------------------------------------
--�}���`�ɂȂ������Ƀz�X�g���ᖳ�������灡���� --EN:--If you are not a host when you become multi, no
--------------------------------------------------------------------------------------
function ConnectPartyEvent(proxy)
	print("ConnectPartyEvent begin");
	print("ConnectPartyEvent end");
end

function OnEvent_4000_Hp_1(proxy,param)
	print("OnEvent_4000_Hp_1 begin");
	proxy:SetDeadMode2(800 , true );
	proxy:SetDeadMode2(801 , true );
	proxy:SetDeadMode2(802 , true );
	proxy:SetDeadMode2(821 , true );	
	print("OnEvent_4000_Hp_1 end");
end

--------------------------------------------------------------------------------------
--Initialize����Ă΂��A1�t���[���x��̏�����������999999 --EN:--Initialization with a delay of 1 frame, called from Initialize ��999999
--------------------------------------------------------------------------------------
--��999999���ꕔ�AInit�ł͏����ł��Ȃ��̂ŁA�c���Ă��� --EN:-- �� 999999 �� Some parts cannot be processed by Init, so leave them
function Second_Initialize_m02_00_00_00(proxy, param)
	print("Second_Initialize_m02_00_00_00 begin");

	--��280���݂邳��Ă���󎀑́� --EN:--��280��The hanging treasure corpse��
	if proxy:IsCompleteEvent( 280 ) == true then
		proxy:ReconstructBreak( 1172 , 1 );--�R�̔j��Č�(�^�C�~���O�̖��ɂ�襥�) --EN:--Reproduction of string destruction (due to timing issues...)
	else
		--���̂̑ҋ@�A�j��(�݂邳��Ă�����) --EN:--Standby animation of the corpse (hanging state)
		proxy:PlayAnimation( 10240 , 1001 );

		--��V�X�e�������� --EN:--Disable Treasure System
		proxy:EnableObjTreasure( 10240 , false );
	end
	
	--��281���݂邳��Ă���󎀑́� --EN:--�� 281 �� Treasure corpse hanging ��
	if proxy:IsCompleteEvent( 281 ) == true then
		proxy:ReconstructBreak( 1174 , 1 );--�R�̔j��Č� --EN:--Reproduction of string destruction
	else
		--���̂̑ҋ@�A�j��(�݂邳��Ă�����) --EN:--Standby animation of the corpse (hanging state)
		proxy:PlayAnimation( 10241 , 1001 );

		--��V�X�e�������� --EN:--Disable Treasure System
		proxy:EnableObjTreasure( 10241 , false );
	end
--------------------------------������QWC�C�x���g�֘A������-------------------------------- --EN:--������QWC event related ������--------------------------------
--------------------------------������QWC�C�x���g�֘A������-------------------------------- --EN:--������QWC event related������--------------------------------
	
	print("Second_Initialize_m02_00_00_00 end");
end

-----------------------------------------------------------------------------------------------------------------------------------------------
--��391�`409���M����(��)�� --EN:-- �� 391�`409 �� barrel explosion (small) ��
--��421�`430���M����(��)�� --EN:-- 421�`430 �� Barrel Explosion (Large) ��
-----------------------------------------------------------------------------------------------------------------------------------------------
function TaruRegist(proxy,param)
	print("TaruRegist begin");
	local Owner = 235;
	--�e�ۃI�[�i�[���p --EN:--Bullet owner use
	CreateBulletOwner(proxy,Owner);	
	
	local small_acId_list	= {  391,  392,  393,  394,  395,  396,  397,  398,  399,  400,  401,  402,  403,  404,  405,  406,  407,  408,  409};
	local small_objId_list	= { 1141, 1142, 1143, 1144, 1145, 1146, 1147, 1148, 1149, 1150, 1151, 1152, 1153, 1154, 1155, 1156, 1157, 1158, 1159};
	local small_event_num = table.getn( small_acId_list );
	for index = 1, small_event_num, 1 do
		local acid = small_acId_list[index];
		local evid = small_objId_list[index];
		SingleReset(proxy,acid);
		if	proxy:IsCompleteEvent( acid ) == false then
			--proxy:OnFireDamage( acid, evid, -1, "OnEvent_"..acid, once );
			proxy:OnFireDamage( acid, evid, -1, "OnEvent_"..acid, once );
		else
			proxy:ReconstructBreak( evid, 1 );
		end
	end
	
	
	
	local big_acId_list		= {  421,  422,  423,  424,  425,  426,  427,  428,  429,  430};
	local big_objId_list	= { 1021, 1022, 1023, 1024, 1025, 1026, 1027, 1028, 1029, 1030};
	local big_event_num = table.getn( big_acId_list );
	for index = 1, big_event_num, 1 do
		local acid = big_acId_list[index];
		local evid = big_objId_list[index];
		SingleReset(proxy,acid);
		if	proxy:IsCompleteEvent( acid ) == false then
			proxy:OnFireDamage( acid, evid, -1, "OnEvent_"..acid, once );
		else
			proxy:ReconstructBreak( evid, 1 );
		end
	end
	print("TaruRegist end");
end

-----------------------------------------------------------------------------------------------------------------------------------------------
--��391�`409���M����(��)�� --EN:-- �� 391�`409 �� barrel explosion (small) ��
-----------------------------------------------------------------------------------------------------------------------------------------------
function OnEvent_391(proxy,param) TaruFunc(proxy,param,param:GetParam1(), 235, param:GetParam2(), 10190 , 0,0,0); end
function OnEvent_392(proxy,param) TaruFunc(proxy,param,param:GetParam1(), 235, param:GetParam2(), 10190 , 0,0,0); end
function OnEvent_393(proxy,param) TaruFunc(proxy,param,param:GetParam1(), 235, param:GetParam2(), 10190 , 0,0,0); end
function OnEvent_394(proxy,param) TaruFunc(proxy,param,param:GetParam1(), 235, param:GetParam2(), 10190 , 0,0,0); end
function OnEvent_395(proxy,param) TaruFunc(proxy,param,param:GetParam1(), 235, param:GetParam2(), 10190 , 0,0,0); end
function OnEvent_396(proxy,param) TaruFunc(proxy,param,param:GetParam1(), 235, param:GetParam2(), 10190 , 0,0,0); end
function OnEvent_397(proxy,param) TaruFunc(proxy,param,param:GetParam1(), 235, param:GetParam2(), 10190 , 0,0,0); end
function OnEvent_398(proxy,param) TaruFunc(proxy,param,param:GetParam1(), 235, param:GetParam2(), 10190 , 0,0,0); end
function OnEvent_399(proxy,param) TaruFunc(proxy,param,param:GetParam1(), 235, param:GetParam2(), 10190 , 0,0,0); end
function OnEvent_400(proxy,param) TaruFunc(proxy,param,param:GetParam1(), 235, param:GetParam2(), 10190 , 0,0,0); end
function OnEvent_401(proxy,param) TaruFunc(proxy,param,param:GetParam1(), 235, param:GetParam2(), 10190 , 0,0,0); end
function OnEvent_402(proxy,param) TaruFunc(proxy,param,param:GetParam1(), 235, param:GetParam2(), 10190 , 0,0,0); end
function OnEvent_403(proxy,param) TaruFunc(proxy,param,param:GetParam1(), 235, param:GetParam2(), 10190 , 0,0,0); end
function OnEvent_404(proxy,param) TaruFunc(proxy,param,param:GetParam1(), 235, param:GetParam2(), 10190 , 0,0,0); end
function OnEvent_405(proxy,param) TaruFunc(proxy,param,param:GetParam1(), 235, param:GetParam2(), 10190 , 0,0,0); end
function OnEvent_406(proxy,param) TaruFunc(proxy,param,param:GetParam1(), 235, param:GetParam2(), 10190 , 0,0,0); end
function OnEvent_407(proxy,param) TaruFunc(proxy,param,param:GetParam1(), 235, param:GetParam2(), 10190 , 0,0,0); end
function OnEvent_408(proxy,param) TaruFunc(proxy,param,param:GetParam1(), 235, param:GetParam2(), 10190 , 0,0,0); end
function OnEvent_409(proxy,param) TaruFunc(proxy,param,param:GetParam1(), 235, param:GetParam2(), 10190 , 0,0,0); end

-----------------------------------------------------------------------------------------------------------------------------------------------
--��421�`430���M����(��)�� --EN:-- 421�`430 �� Barrel Explosion (Large) ��
-----------------------------------------------------------------------------------------------------------------------------------------------
function OnEvent_421(proxy,param) TaruFunc(proxy,param,param:GetParam1(), 235, param:GetParam2(), 10200 , 0,0,0); end
function OnEvent_422(proxy,param) TaruFunc(proxy,param,param:GetParam1(), 235, param:GetParam2(), 10200 , 0,0,0); end
function OnEvent_423(proxy,param) TaruFunc(proxy,param,param:GetParam1(), 235, param:GetParam2(), 10200 , 0,0,0); end
function OnEvent_424(proxy,param) TaruFunc(proxy,param,param:GetParam1(), 235, param:GetParam2(), 10200 , 0,0,0); end
function OnEvent_425(proxy,param) TaruFunc(proxy,param,param:GetParam1(), 235, param:GetParam2(), 10200 , 0,0,0); end
function OnEvent_426(proxy,param) TaruFunc(proxy,param,param:GetParam1(), 235, param:GetParam2(), 10200 , 0,0,0); end
function OnEvent_427(proxy,param) TaruFunc(proxy,param,param:GetParam1(), 235, param:GetParam2(), 10200 , 0,0,0); end
function OnEvent_428(proxy,param) TaruFunc(proxy,param,param:GetParam1(), 235, param:GetParam2(), 10200 , 0,0,0); end
function OnEvent_429(proxy,param) TaruFunc(proxy,param,param:GetParam1(), 235, param:GetParam2(), 10200 , 0,0,0); end
function OnEvent_430(proxy,param) TaruFunc(proxy,param,param:GetParam1(), 235, param:GetParam2(), 10200 , 0,0,0); end

--�M�����܂Ƃ� --EN:--Barrel Explosion Summary
function TaruFunc(proxy,param,acId,Owner,objId,behaviorId,angX,angY,angZ)
	print("OnEvent_"..acId.." begin");
	proxy:CastPointSpell( Owner, objId, behaviorId, angX, angY, angZ );
	proxy:SetEventFlag( acId, true );
	print("OnEvent_"..acId.." end");
end




--------------------------------------------------------------------------------------
--���J�����o�[��0 --EN:--Castle gate opening lever 0
--------------------------------------------------------------------------------------
--��0�����J�����o�[�� --EN:-- �� 0 �� castle gate opening lever ��
function OnEvent_0(proxy, param)
	if param:IsNetMessage() == true then
		return;
	end
	print("OnEvent_0 begin");

	proxy:NotNetMessage_begin();
		--��***�����ǉ�***0�b�づ --EN:--��***Condition added***After 0 seconds��
		proxy:OnKeyTime2( 0, "OnEvent_0_3", 0.0, 0, 1, once);
	proxy:NotNetMessage_end();
	

	print("OnEvent_0 end");
end

--��0_3��PC�����o�[�C�x���g���N�����Ă���0�b�っ --EN:--��0_3��0 seconds after the PC causes a lever event��
function OnEvent_0_3(proxy, param)
	print("OnEvent_0_3 begin");
	
	proxy:LuaCallStart(0,1);
	
	--�t���O�𗧂Ă�(�w�����ɍ��킹�邽��) --EN:--Flag (to meet directives)
	proxy:SetEventFlag( 1 , 1 );
	
	print("OnEvent_0_3 end");
end

function OnEvent_0_4(proxy,param)
	print("OnEvent_0_4 begin");
	
	if param:IsNetMessage() == true then
		--�����ҏo���|���� --EN:--Poly drama with caster
		proxy:RequestRemoPlus(20001,REMO_FLAG,0,1, param:GetPlayID()+10001);
	else
		--�|�����Đ� --EN:--Poly play
		proxy:RequestRemoPlus(20001,REMO_FLAG,0,1,LOCAL_PLAYER);--���傪�J���|���� --EN:--The front gate opens the police drama
	end
	
	proxy:SetEventFlag( 0 , 1 );
	
	print("OnEvent_0_4 end");
end

--�|�����t�F�[�h�A�E�g�� --EN:--After polyplay fade-out
function OnEvent_0_RemoStart(proxy,param)
	print("OnEvent_0_RemoStart begin");
	--�� --EN:--Sky
	print("OnEvent_0_RemoStart end");
end

--�|�����Đ��� --EN:--After polyplay
function OnEvent_0_RemoFinish(proxy,param)
	print("OnEvent_0_RemoFinish begin");
	
	--���@�ǂ��\������� --EN:--Magic wall is displayed
	proxy:SetColiEnable( 1999 , true );
	proxy:SetColiEnable( 1995 , true );

	proxy:SetDrawEnable( 1999 , true );
	proxy:SetDrawEnable( 1995 , true );
	
	--���@�ǂ�SFX ON --EN:--Magical Wall SFX ON
	proxy:ValidSfx( 1987 );
	proxy:ValidSfx( 1991 );
	
	--�򗳊֘A�����ł���(�A��)�C�x���g�Ď��폜 --EN:--Deletion of flying dragon related (returning) event monitoring
	--proxy:DeleteEvent( 230 );--���ł��� --EN:--flying
	
	proxy:EndAnimation( 1000, 1 );--���o�[�A�j�����Đ� --EN:--Play lever animation
	proxy:EndAnimation( 1001, 1 );--����J���A�j�����Đ� --EN:--Play front gate opening animation
	proxy:EndAnimation( 1140, 1 );--�M�A�������A�j���Đ� --EN:--Animation playback with moving gears
	
	--��OBJ��L���� --EN:--Enable Spear OBJ
	proxy:SetDrawEnable( 1008 , true );
	proxy:SetColiEnable( 1008 , true );
	
	print("OnEvent_0_RemoFinish end");
end

--------------------------------------------------------------------------------------
--��������J��4096 --EN:--Castle door open 4096
--------------------------------------------------------------------------------------
--��4096�����{�X���S���� --EN:-- �� 4096 �� When the middle boss dies ��
function OnEvent_4096(proxy, param)
	print("OnEvent_4096 begin");
	
	--�t�@�����N�X�p���S���� --EN:--Death treatment for Phalanx
	PhalanxDead(proxy,param);
	
	proxy:NotNetMessage_begin();
		--��4100���N���C�A���gPC���[�v���o�� --EN:--��4100��Client PC warp effect��
		proxy:OnKeyTime2( 4100, "OnEvent_4100", 0, 0, 0, once);
		--��4096_1��1�b�o�߁� --EN:--��4096_1��1 second passed��
		proxy:OnKeyTime2( 4096, "OnEvent_4096_1", 1, 0, 1, once);
		--��4102��2�b�o�߁� --EN:--��4102��2 seconds passed��
		proxy:OnKeyTime2( 4102, "OnEvent_4102", 2, 0, 2, once);
		
		--�}���`����PT�G���A�ړ���� --EN:--Avoiding PT area movement during multiplayer
		proxy:OnRegistFunc( 4096 , "Check_4096_PT","OnEvent_4096_PT",0,once);
	proxy:NotNetMessage_end();

	
	proxy:SetEventFlag( 4096, 1 );
	
	--�����h�����q���T�����������苗���ȏ㗣�ꂽ���_�Ŏ��̏�ԂɑJ�� --EN:--If Prince Lendl is searching, transition to the next state when it is more than a certain distance away
	if	proxy:IsClient() == false then
		if	proxy:IsCompleteEvent( RENDOL_STATE_SEARCH_1 ) == true then
			if	proxy:IsDistance( LOCAL_PLAYER, 624, 20 ) == false then
				proxy:OnKeyTime2( SYSTEM_CHECK_POINT, "OnEvent_301", 0.0, 0, 2, once );
			else
				proxy:OnPlayerDistanceOut( 301, LOCAL_PLAYER, 624, "OnEvent_301", 20, once );
			end
		end
	end
	
	--�V�u���b�N�N���A������ --EN:--To new block clear processing
	proxy:CustomLuaCallStart( 4050, 800);
	--�����g�J�Q�C�x���g���Z�b�g --EN:--Crystal lizard event reset
	ResetTokage(proxy);
	
	--[[
	if proxy:IsClient() == false then
		proxy:NotNetMessage_begin();
			proxy:OnKeyTime2( 4096 , "OnEvent_4096_2",5.0,0,0,once);
		proxy:NotNetMessage_end();
	end
	]]
	print("OnEvent_4096 end");
end

--��4096_1����������J��:���{�X���S��1�b�� --EN:--��4096_1��Open the door inside the castle: 1 second after the middle boss dies��
function OnEvent_4096_1(proxy, param)
	print("OnEvent_4096_1 begin");
	
	--�{�X��|���������X�V(���ɂ���ăt���O�𗧂Ă�) --EN:--update number of bosses killed (flag by number)
	GetBossFlagCount( proxy, param );
	
	--���g���t�B�[�擾���聥 --EN:--��Trophy Acquisition Judgment��
	Lua_RequestUnlockTrophy(proxy, 27);
	
	--�z�ꕺ�m�̏�ԑJ�ڃ`�F�b�N --EN:--Slave soldier state transition check
	OnEvent_781(proxy,param)
	
	--��(�\�E��)�A�C�e���擾�p�C�x���g�Ď��ǉ��� --EN:--�� (Soul) Added event monitoring for item acquisition��
	if proxy:IsCompleteEvent( 4103 ) == false then
	
		--�\�E���L���� --EN:--Soul activation
		proxy:SetDrawEnable( 1982 , true );
		proxy:SetColiEnable( 1982 , true );
		--�\�E��2�L���� --EN:--Activate Soul 2
		proxy:SetDrawEnable( 1975 , true );
		proxy:SetColiEnable( 1975 , true );
	
		--SFX�L���� --EN:--SFX enable
		proxy:ValidSfx( 1080 );--���̗��q --EN:--Particles of light
		proxy:ValidSfx( 1081 );--�v�΂̃I�[�� --EN:--Keystone Aura
		
		proxy:TreasureDispModeChange2( 1982 , true ,KANAME_SFX);--���点�� --EN:-- let it shine
		proxy:OnDistanceActionAttribute( 4103 , LOCAL_PLAYER , 1982 , "OnEvent_4103" , WarpGimmickDist_A , 10010180 , 0 , 180 , ATTR_HOST + ATTR_LIVE + ATTR_GREY, once );
	else
		--�\�E��������(������������̂ť��) --EN:--Soul nullification (because it disappears when you take it...)
		proxy:SetDrawEnable( 1982 , false );
		proxy:SetColiEnable( 1982 , false );
	end

	--��荇�����t�@�����N�X�����̂ݑΉ� --EN:--For now, only phalanx rooms are supported
	print("�{�X�����A�^���ʏ�"); --EN:print("Boss Room Atari Normal");
	--�ꎞ�I�ɑSOFF --EN:--Temporarily all OFF
	proxy:SetColiEnableArray(3010,true);--�ʏ�L��		 --EN:--usually valid
	proxy:SetColiEnableArray(3002,false);--�{�X�p���� --EN:--disabled for boss
	proxy:SetColiEnableArray(3001,false);--�{�X�p���� --EN:--disabled for boss
		
	print("OnEvent_4096_1 end");
end

--[[
--�G���A����̕\�� --EN:--Display area release
function OnEvent_4096_2(proxy,param)
	print("OnEvent_4096_2 begin");
	--�C���t�H�\�� --EN:--Info display
	--�V�X�e�����b�Z�[�W --EN:--system message
	proxy:InfomationMenu( INFOMENU_TYPE_LIST, -1, 0, -1, 1 );
	proxy:AddInfomationBuffer( 10010740 );
	proxy:PlayTypeSE( LOCAL_PLAYER ,SOUND_TYPE_M ,777777777 );
	print("OnEvent_4096_2 end");
end
]]

--------------------------------------------------------------------------------------
--��4100���N���C�A���gPC���[�v���o�� --EN:-- �� 4100 �� Client PC warp effect ��
--------------------------------------------------------------------------------------

--��4100���N���C�A���gPC���[�v���o�� --EN:-- �� 4100 �� Client PC warp effect ��
function OnEvent_4100(proxy, param)
	print("OnEvent_4100 begin");

	if proxy:IsClient() == true then
		proxy:PlayAnimation( LOCAL_PLAYER , 8284 );--���[�v�A�j�����Đ� --EN:-- Play warp animation
	end

	proxy:SetEventFlag( 4100 , 1 );
	
	print("OnEvent_4100 end");
end


--------------------------------------------------------------------------------------
--��4102���V���O���F���̕ǁABGM������ --EN:-- �� 4102 �� Single: Wall of Light, BGM Elimination ��
--------------------------------------------------------------------------------------

--��4102���V���O���F���̕ǁABGM������ --EN:-- �� 4102 �� Single: Wall of Light, BGM Elimination ��
function OnEvent_4102(proxy, param)
	print("OnEvent_4102 begin");
		
	--�{�X��p��BGM��~ --EN:--BGM stop for boss battles
	proxy:StopPointSE( 0 );
		
	proxy:SetEventFlag( 4102 , 1 );
	
	print("OnEvent_4102 end");
end

--PT��g��ł��邩�̊Ď� --EN:--Monitoring whether you are forming a PT
function Check_4096_PT(proxy)
	if proxy:IsInParty() == false then
		return true;
	end
	return false;
end

--PT����Ȃ��Ȃ� --EN:--If it's not PT
function OnEvent_4096_PT(proxy,param)
	print("OnEvent_4096_PT begin");
	--���{�X�����̑O��̖��@�ǂ�������(�S�v���C���[) --EN:--The magic walls before and after the mid-boss room disappear (all players)
	proxy:SetColiEnable( 1999 , false );
	proxy:SetColiEnable( 1995 , false );
	--proxy:SetObjDeactivate( 1999 , true );--�f�A�N�e�B�u --EN:--deactivate
	--proxy:SetObjDeactivate( 1995 , true );--�f�A�N�e�B�u --EN:--deactivate
	
	proxy:SetDrawEnable( 1999 , false );
	proxy:SetDrawEnable( 1995 , false );
	
	--���{�X�������@�ǂ�SFX�폜 --EN:--Remove the SFX of the mid-boss room magic wall
	proxy:InvalidSfx( 1987 , true );
	proxy:InvalidSfx( 1991 , true );
	
	--���{�X�����O�̈ړ������C�x���g���폜 --EN:--Delete the movement processing event in front of the mid-boss room
	proxy:DeleteEvent( 110 );--��l�ڂ�����Ƃ��p --EN:--For when the first person enters
	proxy:DeleteEvent( 111 );--��l�ڈȍ~������Ƃ��p --EN:--For when the second and subsequent people enter
	proxy:DeleteEvent( 114 );--�{�X�퓬�J�n�p --EN:--For boss battle start
	print("OnEvent_4096_PT end");
end


--------------------------------------------------------------------------------------
--��哃�E�̔��J����10 --EN:--Open the door on the right of the castle gate tower 10
--------------------------------------------------------------------------------------
--��10�����o�[�Ή����i�E�j�̊J����ActionButton���� --EN:-- �� 10 �� Opening the door (right) corresponding to the lever �� ActionButton judgment
function OnEvent_10(proxy, param)
	print("OnEvent_10 begin");
	
	proxy:PlayAnimation(1005, 1);--���o�[�A�j���Đ� --EN:--Play lever animation
	
	--�v���C���[�̓����A�j���[�V����(true:�p�[�e�B�[�v���C���[���A�j���[�V��������) --EN:--Player synchronous animation (true: party player animated)
	Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_PULL_LEVER );

	proxy:NotNetMessage_begin();
		--��10_2��***�����ǉ�***���o�[�A�j���I���� --EN:--��10_2��***Condition added***Lever animation ends��
		proxy:OnObjAnimEnd( 10, 1005, 1, "OnEvent_10_2", once);
	proxy:NotNetMessage_end();
	
	if	param:IsNetMessage() == false then
		proxy:WarpDmy( LOCAL_PLAYER , 1005 , 191 );
	end
	
	proxy:SetEventFlag( 10 , true );

	print("OnEvent_10 end");
end


--��10_2�����o�[�A�j���̏I���� --EN:--��10_2��End of lever animation��
function OnEvent_10_2(proxy, param)
	print("OnEvent_10_2 begin");
	
	proxy:NotNetMessage_begin();
		--��10_3��***�����ǉ�***1�b�o�߁� --EN:--��10_3��***Condition added***1 second elapsed��
		proxy:OnKeyTime2( 10, "OnEvent_10_3", 1.0, 0, 1, once);
	proxy:NotNetMessage_end();
	
	print("OnEvent_10_2 end");
end

--��10_3�����o�[�A�j���I������1�b�o�߁� --EN:--��10_3��One second has passed since the end of the lever animation��
function OnEvent_10_3(proxy, param)
	print("OnEvent_10_3 begin");
	
	proxy:PlayAnimation(1003, 1);--���A�j���Đ� --EN:--Play door animation
	
	--�t���O�𗧂Ă�(�w�����ɍ��킹�邽��) --EN:--Flag (to meet directives)
	proxy:SetEventFlag( 11, true );
	print("OnEvent_10_3 end");
end
	


--------------------------------------------------------------------------------------
--���o�[�Ή���(��)��50 --EN:--Lever compatible door (left) ��50
--------------------------------------------------------------------------------------
--��50�����o�[�Ή����i���j�� --EN:-- �� 50 �� Lever compatible door (left) ��
function OnEvent_50(proxy, param)
	print("OnEvent_50 begin");
	
	proxy:PlayAnimation(1006, 1);--���o�[�A�j���Đ� --EN:--Play lever animation
	
	--�v���C���[�̓����A�j���[�V����(true:�p�[�e�B�[�v���C���[���A�j���[�V��������) --EN:--Player synchronous animation (true: party player animated)
	Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_PULL_LEVER );

	proxy:NotNetMessage_begin();
		--��50_2��***�����ǉ�***���o�[�A�j���I���� --EN:--��50_2��***Condition added***Lever animation ends��
		proxy:OnObjAnimEnd( 50, 1006, 1, "OnEvent_50_2", once );
	proxy:NotNetMessage_end();
	
--	proxy:Warp(LOCAL_PLAYER, 2016);		--�v���C���[������ʒu�Ƀ��[�v --EN:--Warp player in place
	--�����҂̂݃��[�v --EN:-- Warp only for caster
	if	param:IsNetMessage() == false then
		proxy:WarpDmy( LOCAL_PLAYER , 1006 , 191 );
	end
	proxy:SetEventFlag( 50 , true );
--	proxy:DisableMove(LOCAL_PLAYER, true); --�v���C���[�𑀍�s�\�� --EN:--Incapacitate player

	print("OnEvent_50 end");
end


--��50_2�����o�[�A�j���I���� --EN:--��50_2��Lever animation ends��
function OnEvent_50_2(proxy, param)
	print("OnEvent_50_2 begin");
	
	proxy:NotNetMessage_begin();
		--��50_3��***�����ǉ�***1�b�o�߁� --EN:--��50_3��***Condition added***1 second elapsed��
		proxy:OnKeyTime2( 50, "OnEvent_50_3", 1.0, 0, 1, once);
	proxy:NotNetMessage_end();

	print("OnEvent_50_2 end");
end


--��50_3�����o�[�A�j���I������1�b�っ --EN:--��50_3��1 second after lever animation ends��
function OnEvent_50_3(proxy, param)
	print("OnEvent_50_3 begin");
	
	proxy:PlayAnimation( 1004, 1 );--���A�j���Đ� --EN:--Play door animation
	
	--�t���O�𗧂Ă�(�w�����ɍ��킹�邽��) --EN:--Flag (to meet directives)
	proxy:SetEventFlag( 51 , true );
	
	print("OnEvent_50_3 end");
end


--�O���[�o���ɂ����H --EN:-- put in global?
--------------------------------------------------------------------------------------
--�����p�̊֐���  m04 �̂Ƃ͂�����Ƃ������B������������B�iplayer_anime_id) --EN:--��Function for door�� It's a little different from m04. One argument too many. (player_anime_id)
--------------------------------------------------------------------------------------

--��������Ăԁ� --EN:--��Call this��
function EventNormalDoor(proxy, param, event_id, door_id, door_anime_id, player_anime_id)
	print("OnEvent_"..event_id.." begin");
	
	proxy:PlayAnimation( door_id , door_anime_id );--���̃A�j���[�V���� --EN:-- door animation

	--�v���C���[�̓����A�j���[�V����(true:�p�[�e�B�[�v���C���[���A�j���[�V��������) --EN:--Player synchronous animation (true: party player animated)
	if Luafunc_PlaySynchroAnimation( proxy, param, player_anime_id ) == true then
		proxy:SetEventFlag( event_id , 1 );--�J��A(��O����J����)�ւ̑���𖳌��ɂ���B --EN:--Disable the operation to open/close door A (open from the front).
		return;
	end

--	proxy:DisableMove(LOCAL_PLAYER,1);	 --�L�����N�^���ړ��A����s�\�� --EN:--Move the character, make it impossible to turn
	proxy:SetEventFlag( event_id , 1 );--�J��A(��O����J����)�ւ̑���𖳌��ɂ���B --EN:--Disable the operation to open/close door A (open from the front).

	print("OnEvent_"..event_id.." end");
end



--------------------------------------------------------------------------------------
--�Β��Ƀ��[�v��70 --EN:-- Warp to stone pillar ��70
--------------------------------------------------------------------------------------
--��70���Β��Ƀ��[�v�� --EN:-- �� 70 �� Warp to the stone pillar ��
function OnEvent_70(proxy,param)	

	if proxy:IsCompleteEvent( 70 ) == true then
		return;
	end
	
	if param:IsNetMessage() == true then
		return;
	end
	
	
	print("OnEvent_70 begin");
	
	--�Z�b�V�������Ȃ�΁A�v�΂̃��[�v���� --EN:--Disable keystone warp if in session
	if proxy:IsSession() == false then--�Z�b�V�������ł͂Ȃ� --EN:--not in session
		proxy:RepeatMessage_begin();
		--��70_1���I�����j���[�̊Ď��� --EN:--��70_1��Select menu monitoring��
			proxy:OnSelectMenu(70, "OnEvent_70_0", 10010710, 0, 2, 1983, 2, once);			
		proxy:RepeatMessage_end();
	else--�Z�b�V������ --EN:--in session
		--�G���[�\���u�Z�b�V�������͞��̐_�a�ɂ͖߂�܂���v --EN:--Error display "You cannot return to the Temple of the Wedge during a session"
		--proxy:InfomationMenu( INFOMENU_TYPE_SIMPLE, 0, MSG_CATEGORY_EVENT, 10010720, 1);
		--proxy:ShowGenDialog(10010720,1,1,true);
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010720, 0, 6, 1983, GEN_DIALOG_DIST, once );
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
	end

	print("OnEvent_70 end");
end

--��70_0���I�����j���[�̊Ď��� --EN:--��70_0��Monitor selection menu��
function OnEvent_70_0(proxy, param)
	print("OnEvent_70_0 begin");	
	
	if proxy:IsSession() == false then
		proxy:PlayAnimation( LOCAL_PLAYER , 8283 );--�v�΂ɐG���A�j�����Đ� --EN:--Play the animation that touches the keystone
		proxy:NoAnimeTurnCharactor( 10000 , 1983 ,TURNSKIP_ANGLE);
		
		proxy:NotNetMessage_begin();
			--���v�΂ɐG���A�j���Đ��I���� --EN:--��Animation touching the keystone ends��
			proxy:OnChrAnimEnd( 70 , LOCAL_PLAYER , 8283 , "OnEvent_70_1" , once );
		proxy:NotNetMessage_end();

		proxy:SetEventFlag( 70 , true );
	else
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010720, 0, 6, 1983, GEN_DIALOG_DIST, once );
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
	end
	
	print("OnEvent_70_0 end");
end

--��70_1���v�΂ɐG���A�j���Đ��I���� --EN:--��70_1��End of playing the animation touching the keystone��
function OnEvent_70_1(proxy, param)
	print("OnEvent_70_1 begin");
	
	proxy:SetEventFlag( 70 , false );
	
	proxy:PlayAnimation( LOCAL_PLAYER , 8284 );--�����E�ɋA��A�j�����Đ� --EN:--Play animation to return to your own world
	
	--[[
	proxy:NotNetMessage_begin();
		--�������E�ɋA��A�j���Đ��I���� --EN:--��End of animation playback to return to your own world��
		proxy:OnChrAnimEnd( 70 , LOCAL_PLAYER , 8284 , "OnEvent_70_2" , once );
	proxy:NotNetMessage_end();
	]]

	proxy:SetEventFlag( 70 , true );
	OnEvent_70_2(proxy,param);
	
	print("OnEvent_70_0 end");
end

--�������E�ɋA��A�j���Đ��I���� --EN:--��Returning to your own world, end of animation ��
function OnEvent_70_2(proxy,param)	
	print("OnEvent_70_2 begin");

	--�Β��֖߂��Ă�������̃t���O�𗧂Ă� --EN:--Flag the judgment of returning to the stone pillar
	proxy:SetEventFlag(8083, true);
	
	proxy:SetEventFlag( 70 , false );
	
	--���S�񕜗v�� --EN:-- full recovery request
	proxy:RequestFullRecover();
	proxy:WarpNextStage( 1, 0, 0, 0, 1006 );
	
	print("OnEvent_70_2 end");
end


--------------------------------------------------------------------------------------
--�Β��Ƀ��[�v(�{�X�|������p)��4105 --EN:-- Warp to the stone pillar (for after defeating the boss) 4105
--------------------------------------------------------------------------------------
--��4105���Β��Ƀ��[�v�� --EN:-- �� 4105 �� Warp to the stone pillar ��
function OnEvent_4105(proxy,param)	

	if proxy:IsCompleteEvent( 4105 ) == true then
		return;
	end	

	print("OnEvent_4105 begin");
	
	proxy:RepeatMessage_begin();
		--��4105_1���I�����j���[�̊Ď��� --EN:--��4105_1��Monitor selection menu��
		proxy:OnSelectMenu(4105, "OnEvent_4105_0", 10010710, 0, 2, 1982, 2, once);			
	proxy:RepeatMessage_end();
	
	print("OnEvent_4105 end");
end

--��4105_0���I�����j���[�̊Ď��� --EN:--��4105_0��Monitor selection menu��
function OnEvent_4105_0(proxy, param)
	print("OnEvent_4105_0 begin");	
	
	if proxy:IsSession() == false then
		proxy:PlayAnimation( LOCAL_PLAYER , 8283 );--�v�΂ɐG���A�j�����Đ� --EN:--Play the animation that touches the keystone
		proxy:NoAnimeTurnCharactor( 10000 , 1982 ,TURNSKIP_ANGLE);
		
		
		proxy:NotNetMessage_begin();
			--���v�΂ɐG���A�j���Đ��I���� --EN:--��Animation touching the keystone ends��
			proxy:OnChrAnimEnd( 4105 , LOCAL_PLAYER , 8283 , "OnEvent_4105_1" , once );
		proxy:NotNetMessage_end();
		
		proxy:SetEventFlag( 4105 , 1 );
	else
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010720, 0, 6, 1983, GEN_DIALOG_DIST, once );
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
	end
	
	print("OnEvent_4105_0 end");
end

--��4105_1�������E�ɋA��A�j���Đ��I���� --EN:--��4105_1��Return to own world animation ends��
function OnEvent_4105_1(proxy,param)	
	print("OnEvent_4105_1 begin");
	
	proxy:PlayAnimation( 10000 , 8284 );--�����E�ɋA��A�j�����Đ� --EN:--Play animation to return to your own world
	--�Β��֖߂��Ă�������̃t���O�𗧂Ă� --EN:--Flag the judgment of returning to the stone pillar
	proxy:SetEventFlag(8083, true);
	
	proxy:SetEventFlag( 4105 , 0 );	
	--���S�񕜗v�� --EN:-- full recovery request
	proxy:RequestFullRecover();
	proxy:WarpNextStage( 1, 0, 0, 0, 1006 );
	
	print("OnEvent_4105_1 end");
end


--------------------------------------------------------------------------------------
--��350���o�b���߂Â��ƃJ���X����ї��� --EN:-- �� 350 �� When the PC approaches, the crow flies away ��
--------------------------------------------------------------------------------------
function FryAwayKarasu(proxy,param, KarasuEventID, karasuID, KarasuAnimID)	
	print("FryAwayKarasu_"..karasuID.." begin");
	
	proxy:PlayAnimation( karasuID , KarasuAnimID );
	
	proxy:NotNetMessage_begin();
		--���J���X�A�j���Đ��I���� --EN:--��End of crow animation��
		proxy:OnObjAnimEnd( KarasuEventID , karasuID , KarasuAnimID , "OnEvent_"..KarasuEventID.."_1" , once );	
	proxy:NotNetMessage_end();

	proxy:SetEventFlag( KarasuEventID , true );

	print("FryAwayKarasu_"..karasuID.." end");
end

-----------------------------------------
--�J���X�A�j���Đ��I�������̂ŏ����Ă��� --EN:--Since the crow animation has finished playing, I will delete it.
-----------------------------------------
function OnEvent_350_1(proxy,param)	proxy:SetDrawEnable( 1090 , false ); print("KarasuFryAway ID=1090"); end
function OnEvent_351_1(proxy,param)	proxy:SetDrawEnable( 1091 , false ); print("KarasuFryAway ID=1091"); end
--function OnEvent_352_1(proxy,param)	proxy:SetDrawEnable( 1092 , false ); print("KarasuFryAway ID=1092"); end
function OnEvent_353_1(proxy,param)	proxy:SetDrawEnable( 1093 , false ); print("KarasuFryAway ID=1093"); end
function OnEvent_354_1(proxy,param)	proxy:SetDrawEnable( 1094 , false ); print("KarasuFryAway ID=1094"); end
function OnEvent_355_1(proxy,param)	proxy:SetDrawEnable( 1095 , false ); print("KarasuFryAway ID=1095"); end
function OnEvent_356_1(proxy,param)	proxy:SetDrawEnable( 1096 , false ); print("KarasuFryAway ID=1096"); end
function OnEvent_357_1(proxy,param)	proxy:SetDrawEnable( 1097 , false ); print("KarasuFryAway ID=1097"); end
function OnEvent_358_1(proxy,param)	proxy:SetDrawEnable( 1098 , false ); print("KarasuFryAway ID=1098"); end
function OnEvent_359_1(proxy,param)	proxy:SetDrawEnable( 1099 , false ); print("KarasuFryAway ID=1099"); end
function OnEvent_360_1(proxy,param)	proxy:SetDrawEnable( 1100 , false ); print("KarasuFryAway ID=1100"); end
function OnEvent_361_1(proxy,param)	proxy:SetDrawEnable( 1101 , false ); print("KarasuFryAway ID=1101"); end
function OnEvent_362_1(proxy,param)	proxy:SetDrawEnable( 1102 , false ); print("KarasuFryAway ID=1102"); end
function OnEvent_363_1(proxy,param)	proxy:SetDrawEnable( 1103 , false ); print("KarasuFryAway ID=1103"); end
function OnEvent_364_1(proxy,param)	proxy:SetDrawEnable( 1104 , false ); print("KarasuFryAway ID=1104"); end
function OnEvent_365_1(proxy,param)	proxy:SetDrawEnable( 1105 , false ); print("KarasuFryAway ID=1105"); end
function OnEvent_366_1(proxy,param)	proxy:SetDrawEnable( 1106 , false ); print("KarasuFryAway ID=1106"); end
function OnEvent_367_1(proxy,param)	proxy:SetDrawEnable( 1107 , false ); print("KarasuFryAway ID=1107"); end
function OnEvent_368_1(proxy,param)	proxy:SetDrawEnable( 1108 , false ); print("KarasuFryAway ID=1108"); end
function OnEvent_369_1(proxy,param)	proxy:SetDrawEnable( 1109 , false ); print("KarasuFryAway ID=1109"); end
function OnEvent_370_1(proxy,param)	proxy:SetDrawEnable( 1110 , false ); print("KarasuFryAway ID=1110"); end
function OnEvent_371_1(proxy,param)	proxy:SetDrawEnable( 1111 , false ); print("KarasuFryAway ID=1111"); end
function OnEvent_372_1(proxy,param)	proxy:SetDrawEnable( 1112 , false ); print("KarasuFryAway ID=1112"); end
function OnEvent_373_1(proxy,param)	proxy:SetDrawEnable( 1113 , false ); print("KarasuFryAway ID=1113"); end
function OnEvent_374_1(proxy,param)	proxy:SetDrawEnable( 1114 , false ); print("KarasuFryAway ID=1114"); end
function OnEvent_375_1(proxy,param)	proxy:SetDrawEnable( 1115 , false ); print("KarasuFryAway ID=1115"); end
	
---------------------------------
--�J���X����ї��֐����Ăяo�� --EN:--Call the function where the crow flies away
---------------------------------
function OnEvent_350(proxy, param) FryAwayKarasu(proxy, param, 350, 1090, 11); end
function OnEvent_351(proxy, param) FryAwayKarasu(proxy, param, 351, 1091, 10); end
--function OnEvent_352(proxy, param) FryAwayKarasu(proxy, param, 352, 1092, 12); end
function OnEvent_353(proxy, param) FryAwayKarasu(proxy, param, 353, 1093, 12); end
function OnEvent_354(proxy, param) FryAwayKarasu(proxy, param, 354, 1094, 12); end
function OnEvent_355(proxy, param) FryAwayKarasu(proxy, param, 355, 1095, 12); end
function OnEvent_356(proxy, param) FryAwayKarasu(proxy, param, 356, 1096, 12); end
function OnEvent_357(proxy, param) FryAwayKarasu(proxy, param, 357, 1097, 12); end
function OnEvent_358(proxy, param) FryAwayKarasu(proxy, param, 358, 1098, 12); end
function OnEvent_359(proxy, param) FryAwayKarasu(proxy, param, 359, 1099, 12); end
function OnEvent_360(proxy, param) FryAwayKarasu(proxy, param, 360, 1100, 12); end
function OnEvent_361(proxy, param) FryAwayKarasu(proxy, param, 361, 1101, 12); end
function OnEvent_362(proxy, param) FryAwayKarasu(proxy, param, 362, 1102, 12); end
function OnEvent_363(proxy, param) FryAwayKarasu(proxy, param, 363, 1103, 12); end
function OnEvent_364(proxy, param) FryAwayKarasu(proxy, param, 364, 1104, 12); end
function OnEvent_365(proxy, param) FryAwayKarasu(proxy, param, 365, 1105, 12); end
function OnEvent_366(proxy, param) FryAwayKarasu(proxy, param, 366, 1106, 12); end
function OnEvent_367(proxy, param) FryAwayKarasu(proxy, param, 367, 1107, 12); end
function OnEvent_368(proxy, param) FryAwayKarasu(proxy, param, 368, 1108, 12); end
function OnEvent_369(proxy, param) FryAwayKarasu(proxy, param, 369, 1109, 12); end
function OnEvent_370(proxy, param) FryAwayKarasu(proxy, param, 370, 1110, 12); end
function OnEvent_371(proxy, param) FryAwayKarasu(proxy, param, 371, 1111, 12); end
function OnEvent_372(proxy, param) FryAwayKarasu(proxy, param, 372, 1112, 12); end
function OnEvent_373(proxy, param) FryAwayKarasu(proxy, param, 373, 1113, 12); end
function OnEvent_374(proxy, param) FryAwayKarasu(proxy, param, 374, 1114, 12); end
function OnEvent_375(proxy, param) FryAwayKarasu(proxy, param, 375, 1115, 12); end

--[[
--------------------------------------------------------------------------------------
--���ǂ��󂵂ēG����яo���Ă��遡90 --EN:--Break the thin wall and the enemy will pop out 90
--------------------------------------------------------------------------------------
--��90�����ǂ��󂵂ēG����яo���Ă��遡 --EN:-- �� 90 �� Destroy the thin wall and the enemy will jump out ��
function OnEvent_90(proxy,param)	
	print("OnEvent_90 begin");
	
	proxy:SetDrawEnable( 202 , true );	
	proxy:SetColiEnable( 202 , true );

	proxy:PlayAnimation( 1120 , 1 );--���A�j���Đ� --EN:--Play door animation
	
	proxy:NotNetMessage_begin();
		--��90_1���U���A�j���̍Đ����Ԃ𒲐��� --EN:--��90_1��Adjusted attack animation playback time��
		proxy:OnKeyTime2( 90 , "OnEvent_90_1" , ( 72.0 / 30.0 ) , 0 , 3 , once );
	proxy:NotNetMessage_end();

	proxy:SetEventFlag( 90 , 1 );
	
	print("OnEvent_90 end");
end


--��90_1���U���A�j���̍Đ����Ԃ𒲐��� --EN:--��90_1��Adjusted attack animation playback time��
function OnEvent_90_1(proxy,param)	
	print("OnEvent_90_1 begin");	
	
	proxy:PlayAnimation( 202 , 7010 );--�U���A�j���Đ� --EN:--play attack animation

	proxy:SetEventFlag( 90 , 0 );
	
	proxy:NotNetMessage_begin();
		--��90_2���U���A�j���I���づ --EN:--��90_2��After the attack animation ends��
		proxy:OnChrAnimEnd( 90 , 202, 7010, "OnEvent_90_2" , once );
	proxy:NotNetMessage_end();
	
	proxy:SetEventFlag( 90 , 1 );
	
	print("OnEvent_90_1 end");
end


--��90_2���U���A�j���I���っ --EN:--��90_2��After the attack animation finished��
function OnEvent_90_2(proxy,param)	
	print("OnEvent_90_2 begin");	
	
	proxy:PlayLoopAnimation( 202 , 500 );--����A�j���Đ� --EN:--Run animation playback
	
	proxy:SetEventFlag( 90 , 0 );
	
	proxy:NotNetMessage_begin();
		--��90_3������A�j���𐔕b�ԍĐ��づ --EN:--��90_3��After playing the running animation for a few seconds��
		proxy:OnKeyTime2( 90 , "OnEvent_90_3" , 1.0 , 0, 1, once );
	proxy:NotNetMessage_end();
	
	proxy:SetEventFlag( 90 , 1 );
	
	print("OnEvent_90_2 end");
end

--��90_3������A�j���I���っ --EN:--��90_3��After running animation��
function OnEvent_90_3(proxy,param)	
	print("OnEvent_90_3 begin");	
	
	proxy:StopLoopAnimation( 202 );
	proxy:EnableLogic( 202 , true );
	
	print("OnEvent_90_3 end");
end
]]

--------------------------------------------------------------------------------------
--���ǂ��󂵂ēG����яo���Ă���2��91 --EN:--Break the thin plate wall and the enemy will jump out 2��91
--------------------------------------------------------------------------------------
--��91�����ǂ��󂵂ēG����яo���Ă���2�� --EN:--�� 91 �� Destroy the thin wall and the enemy will jump out 2 ��
function OnEvent_91(proxy,param)	
	print("OnEvent_91 begin");
	
	proxy:SetDrawEnable( 215 , true );
	proxy:SetDrawEnable( 216 , true );
	
	proxy:SetColiEnable( 216 , true );
	proxy:SetColiEnable( 215 , true );
	
	proxy:PlayAnimation( 1121 , 1 );--���A�j���Đ� --EN:--Play door animation
	proxy:PlayAnimation( 1122 , 1 );--���A�j���Đ� --EN:--Play door animation
	
	proxy:NotNetMessage_begin();
		--��91_1���U���A�j���̍Đ����Ԃ𒲐��� --EN:--��91_1��Adjusted attack animation playback time��
		proxy:OnKeyTime2( 91 , "OnEvent_91_1_215" , ( 72.0 / 30.0 ) , 0 , 3 , once );
		proxy:OnKeyTime2( 91 , "OnEvent_91_1_216" , ( 72.0 / 30.0 ) , 0 , 4 , once );
	proxy:NotNetMessage_end();

	print("OnEvent_91 end");
end

--��91_1_215���U���A�j���̍Đ����Ԃ𒲐��� --EN:--��91_1_215��Adjusted attack animation playback time��
function OnEvent_91_1_215(proxy,param)	
	print("OnEvent_91_1_215 begin");		
	proxy:PlayAnimation( 215 , 7010 );
	proxy:SetEventFlag( 91 , 0 );
	proxy:NotNetMessage_begin();
		--��91_2���U���A�j���I���づ --EN:--��91_2��After the attack animation ends��
		proxy:OnChrAnimEnd( 91 , 215, 7010, "OnEvent_91_2_215" , once );
		--proxy:OnKeyTime2(91,"OnEvent_91_2_215",2.0,0,0,once);
	proxy:NotNetMessage_end();
	proxy:SetEventFlag( 91 , 1 );
	print("OnEvent_91_1_215 end");
end

--��91_1_216���U���A�j���̍Đ����Ԃ𒲐��� --EN:--��91_1_216��Adjusted attack animation playback time��
function OnEvent_91_1_216(proxy,param)	
	print("OnEvent_91_1_216 begin");		
	proxy:PlayAnimation( 216 , 7010 );	
	proxy:SetEventFlag( 91 , 0 );	
	proxy:NotNetMessage_begin();
		--��91_2���U���A�j���I���づ --EN:--��91_2��After the attack animation ends��
		proxy:OnChrAnimEnd( 91 , 216, 7010, "OnEvent_91_2_216" , once );		
	proxy:NotNetMessage_end();	
	proxy:SetEventFlag( 91 , 1 );	
	print("OnEvent_91_1_216 end");
end

--��91_2_215���U���A�j���I���っ --EN:--��91_2_215��After the attack animation finished��
function OnEvent_91_2_215(proxy,param)	
	print("OnEvent_91_2_215 begin");		
	proxy:PlayLoopAnimation( 215 , 500 );--����A�j���Đ�	 --EN:--Run animation playback
	proxy:SetEventFlag( 91 , 0 );	
	proxy:NotNetMessage_begin();
		--��91_3������A�j���𐔕b�ԍĐ��づ --EN:--��91_3��After playing the running animation for a few seconds��
		proxy:OnKeyTime2( 91 , "OnEvent_91_3_215" , 1.0 , 0, 1, once );
	proxy:NotNetMessage_end();	
	proxy:SetEventFlag( 91 , 1 );	
	print("OnEvent_91_2_215 end");
end

--��91_2_216���U���A�j���I���っ --EN:--��91_2_216��After the attack animation finished��
function OnEvent_91_2_216(proxy,param)	
	print("OnEvent_91_2_216 begin");			
	proxy:PlayLoopAnimation( 216 , 500 );	
	proxy:SetEventFlag( 91 , 0 );	
	proxy:NotNetMessage_begin();
		--��91_3������A�j���𐔕b�ԍĐ��づ --EN:--��91_3��After playing the running animation for a few seconds��
		proxy:OnKeyTime2( 91 , "OnEvent_91_3_216" , 1.0 , 0, 10, once );
	proxy:NotNetMessage_end();	
	proxy:SetEventFlag( 91 , 1 );	
	print("OnEvent_91_2_216 end");
end

--��91_3_215������A�j���I���っ --EN:--��91_3_215��After running animation��
function OnEvent_91_3_215(proxy,param)	
	print("OnEvent_91_3_215 begin");	
	
	proxy:StopLoopAnimation( 215 );	
	proxy:SetSuperArmor( 215 , false );	
	proxy:EnableLogic( 215 , true );	
	
	print("OnEvent_91_3_215 end");
end

--��91_3_216������A�j���I���っ --EN:--��91_3_216��After running animation��
function OnEvent_91_3_216(proxy,param)	
	print("OnEvent_91_3_216 begin");	
	
	proxy:StopLoopAnimation( 216 );	
	proxy:SetSuperArmor( 216 , false );	
	proxy:EnableLogic( 216 , true );	
	
	print("OnEvent_91_3_216 end");
end


--------------------------------------------------------------------------------------
--��ʕ��m�������Ă��遡180 --EN:-- General soldiers fall �� 180
--------------------------------------------------------------------------------------
--��180_00���U�����󂯂��Ƃ��̃m�b�N�o�b�N���������p(ID:211)�� --EN:--��180_00��For knockback when attacked (ID: 211)��
function OnEvent_180_00(proxy,param)
	print("OnEvent_180_00 begin");
	
	proxy:PlayAnimation( 211 , 500 ) --�ړ��A�j���Đ� --EN:--Play moving animation
	
	proxy:NotNetMessage_begin();
		--��180���ړ��A�j���̍Đ��I�����G�������Ă���ց� --EN:--��180��End of movement animation��Go to enemies falling��
		proxy:OnChrAnimEnd( 180 , 211 , 500 , "OnEvent_180" , once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_180_00 end");
end


--��180_01���U�����󂯂��Ƃ��̃m�b�N�o�b�N���������p(ID:206)�� --EN:--��180_01��For knocking back when attacked (ID: 206)��
function OnEvent_180_01(proxy,param)
	print("OnEvent_180_01 begin");
	
	proxy:PlayAnimation( 206 , 500 ) --�ړ��A�j���Đ� --EN:--Play moving animation
	
	proxy:NotNetMessage_begin();
		--��180���ړ��A�j���̍Đ��I�����G�������Ă���ց� --EN:--��180��End of movement animation��Go to enemies falling��
		proxy:OnChrAnimEnd( 180 , 206 , 500 , "OnEvent_180" , once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_180_01 end");
end




--��180����ʕ��m�������Ă��遡 --EN:-- �� 180 �� Common soldiers fall ��
function OnEvent_180(proxy,param)
	print("OnEvent_180 begin");

	--���d�����h�~ --EN:--Multiple activation prevention
	if proxy:IsCompleteEvent( 180 ) == true then
		print("OnEvent_180 end");
		return;
	end
	
	proxy:NotNetMessage_begin();
		--����l�ڂ������Ă��遥 --EN:--��The first one falls down��
		proxy:OnKeyTime2( 180 , "OnEvent_180_211" , 0.0 , 0 , 1 , once );
		--����l�ڂ������Ă��遥 --EN:--��The second person falls down��
		proxy:OnKeyTime2( 180 , "OnEvent_180_206" , 1.0 , 0 , 2 , once );
	proxy:NotNetMessage_end();
	
	proxy:SetEventFlag( 180 , 1 );
	
	print("OnEvent_180 end");
end




--��180_211����ʕ��m�������Ă���(��l��)��ID211 --EN:-- �� 180_211 �� General soldier falls (first person) �� ID 211
function OnEvent_180_211(proxy,param)
	print("OnEvent_180_211 begin");

	proxy:SetColiEnable( 211 , false );
	proxy:DisableMapHit( 211, true );
	proxy:SetDisableGravity( 211 , true );
	
	proxy:PlayAnimation( 211 , 7000 );

	proxy:SetEventFlag( 180 , 0 );
	proxy:NotNetMessage_begin();
		--��180_1����э~��A�j���Đ��I���� --EN:--��180_1��End of jumping animation��
		proxy:OnKeyTime2( 180 , "OnEvent_180_211_1" , ( 23.0 / 30.0 ) , 0 , 3 , once );
	proxy:NotNetMessage_end();
	proxy:SetEventFlag( 180 , 1 );
	
	print("OnEvent_180_211 end");
end

--��180_211_1����э~��A�j���Đ��I��(��l��)��ID211 --EN:--��180_211_1��End of jump animation playback (first person)��ID211
function OnEvent_180_211_1(proxy,param)
	print("OnEvent_180_211_1 begin");
	
	proxy:DisableMapHit( 211, false );	
	proxy:SetDisableGravity( 211 , false );
	
	proxy:EnableLogic( 211 , true );
	proxy:SetColiEnable( 211 , true );	
	
	proxy:SetSuperArmor( 211 , false );
	
	proxy:DeleteEvent( 182 );--�_���[�W�Ď����� --EN:--Turn off damage monitoring
	
	print("OnEvent_180_211_1 end");
end




--��180_206����ʕ��m�������Ă���(��l��)��ID206 --EN:-- �� 180_206 �� General soldier falls (second person) �� ID206
function OnEvent_180_206(proxy,param)
	print("OnEvent_180_206 begin");

	proxy:SetColiEnable( 206 , false );
	proxy:DisableMapHit( 206, true );
	proxy:SetDisableGravity( 206 , true );
	
	proxy:PlayAnimation( 206 , 7000 );

	proxy:SetEventFlag( 180 , 0 );
	proxy:NotNetMessage_begin();
		--��180_1����э~��A�j���Đ��I���� --EN:--��180_1��End of jumping animation��
		proxy:OnKeyTime2( 180 , "OnEvent_180_206_1" , ( 23.0 / 30.0 ) , 0 , 4 , once );
	proxy:NotNetMessage_end();
	proxy:SetEventFlag( 180 , 1 );
	
	--�t���O�𗧂Ă�(�w�����ɍ��킹�邽��) --EN:--Flag (to meet directives)
	proxy:SetEventFlag( 181 , 1 );
	
	print("OnEvent_180_206 end");
end

--��180_206_1����э~��A�j���Đ��I��(��l��)��ID206 --EN:--��180_206_1��End of jump animation playback (second person)��ID206
function OnEvent_180_206_1(proxy,param)
	print("OnEvent_180_206_1 begin");
	
	proxy:DisableMapHit( 206, false );	
	proxy:SetDisableGravity( 206 , false );
	
	proxy:EnableLogic( 206 , true );
	proxy:SetColiEnable( 206 , true );	
	proxy:SetSuperArmor( 206 , false );
	
	proxy:DeleteEvent( 183 );--�_���[�W�Ď����� --EN:--Turn off damage monitoring
	proxy:DeleteEvent( 180 );--�̈�Ď������� --EN:-- Also turn off area monitoring
	
	print("OnEvent_180_206_1 end");
end


--------------------------------------------------------------------------------------
--�p�j�f�[�����̓o�ꁡ?? --EN:-- Appearance of the Wandering Demon ??
--------------------------------------------------------------------------------------

--���O���[�o���̎��S�Ď�����Ă΂��(�\��) --EN:--�� Called from global death watch (solo)
function PlayerDeath_m02_00_00_00(proxy, param)
	print("PlayerDeath_m02_00_00_00");
	
--	LuaFunc_VisibleTheWanderingDemon(proxy, param, demon_id_list_m02_00_00_00);
--	proxy:SetEventFlag( 20 , 1 );--�t���O�͉��A�w�肪����Ες���B --EN:The -- flag is tentative, and will be changed if specified.
	
	print("PlayerDeath_m02_00_00_00");
end

--���O���[�o���̌�������������Ă΂��(�\��) --EN:--��Called from global blood letter revival (solo)
function PlayerRevive_m02_00_00_00(proxy,param)
	print("PlayerRevive_m02_00_00_00");
	
--	LuaFunc_InvisibleTheWanderingDemon(proxy, param, demon_id_list_m02_00_00_00);
--	proxy:SetEventFlag( 20 , 0 );--�t���O�͉��A�w�肪����Ες���B --EN:The -- flag is tentative, and will be changed if specified.
	
	print("PlayerRevive_m02_00_00_00");
end






--------------------------------------------------------------------------------------
--�{�X�����̒��ɓ��遡110 --EN:--Enter the boss room 110
--------------------------------------------------------------------------------------

--���C�x���g�����[�v�Ȃ̂ŁA�S�����s�[�g�ɂ��遫 --EN:--�� Since the event is a loop, repeat all ��

--��110�����{�X�����ւ̔����J���� --EN:-- �� 110 �� The door to the mid-boss room opens ��
function OnEvent_110(proxy,param)
	print("OnEvent_110 begin");
	
	if proxy:IsCompleteEvent( SYSTEM_ID_IGNORE ) == true then
		print("OnEvent_110 end");
		return;
	end
	--�N���C�A���g�ցA�{�X�����j�~���s��ʒm --EN:--Notify client of failure to block boss room
	if proxy:IsClient() == false then
		proxy:LuaCallStart( 4068 , 1 );	
	end
	
	--�������g���t�@�����N�X������ --EN:--prepare the phalanx yourself
	if param:IsNetMessage() == false then
		PhalanxStandBy(proxy,param);
	end
	
	proxy:LuaCallStart( 111, 1 );--����A�j���̓����Đ� --EN:-- Synchronous playback of turning animation
	--proxy:SetEventFlag( SYSTEM_ID_IGNORE, true );
	--���d�N���V�X�e��ID���^�C���A�E�g��ݒ肵��ON�ɂ��� --EN:--Turn on multiple activation system ID by setting timeout
	proxy:SetSystemIgnore( SYSTEM_ID_IGNORE , IGNORE_TIME );
	
	--�v���t�@�C���Z�[�u�v�� --EN:--profile save request
	proxy:SaveRequest_Profile();
	
	print("OnEvent_110 end");
end


--����A�j���̓����Đ�(ID����) --EN:-- Synchronized playback of turning animation (ID is different)
function OnEvent_111_1(proxy,param)
	print("OnEvent_111_1 begin");

	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		if param:IsNetMessage() == true then
			--����A�j���Đ����s���A���̏I������OnEvent_111_2�𔭍s���� --EN:--Play the turning animation and issue OnEvent_111_2 at the end
			proxy:TurnCharactor( 10001 + param:GetPlayID(), 2891 );
		else
			proxy:LockSession();--���[�������b�N���܂��I --EN:--lock the room!
			--����A�j���Đ����s���A���̏I������OnEvent_111_2�𔭍s���� --EN:--Play the turning animation and issue OnEvent_111_2 at the end
			proxy:OnTurnCharactorEnd( 111, LOCAL_PLAYER, 2891, "OnEvent_111_2", once );
		end
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	
	print("OnEvent_111_1 end");
end

--����A�j���̓����Đ��I���� --EN:--After synchronous playback of turning animation ends
function OnEvent_111_2(proxy,param)
	print("OnEvent_111_2 begin");

	--�����p�����A�j���Đ� --EN:--Play walking animation for synchronization
	proxy:LuaCallStart( 4012, 1 );
	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		proxy:OnChrAnimEnd( 111, LOCAL_PLAYER, ANIMEID_WALK, "OnEvent_111_3", once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	
	print("OnEvent_111_2 end");
end

--�����A�j���̓����Đ��I���� --EN:--After the synchronized playback of the walking animation ends
function OnEvent_111_3(proxy,param)
	print("OnEvent_111_3 begin");

	--�ŏ��̐l���{�X�����̒��ɓ���I����Ă�����A���ɔz�M����Ă���͂��Ȃ̂ŁA����������Ȃ��n���h�� --EN:--If the first person has already entered the boss room, it should have already been delivered, so no more handlers
	if proxy:IsCompleteEvent( 110 ) == false then
		proxy:LuaCallStart( 111 , 5 );--2��ڈȍ~�Ƀ{�X�����ɓ��邽�߂̃C�x���g�z�M�p --EN:--For event delivery to enter the boss room after the second time
		proxy:LuaCallStart( 4045 , 1 );	--�N���C�A���g�ցA�{�X�����ɓ����悤�ɂȂ������Ƃ�ʒm --EN:--Notify clients that they can now enter the boss room
		proxy:LuaCallStart( 111 , 6 );--�t���O�Z�b�g(�����p) --EN:--flag set (for synchronization)
		local eneidlist = {800,
		860,861,862,863,864,865,866,867,868,869,
		870,871,872,873,874,875,876,877,878,879,
		880,881,882,883,884,885,886,887,888,889,
		890,891,892,893,894,895,896,897};
		
		local num = table.getn(eneidlist);
		for index = 1, num , 1 do
			Lua_MultiDoping(proxy,eneidlist[index]);--�}���`�v���C�h�[�s���O --EN:-- Multiplayer Doping
		end		
	end

	--�v���C���[�����̒��Ɋ��S�ɂ͂������^�C�~���O�ŁA�{�X�̎v�l�����Z�b�g --EN:--Reset the boss' thoughts when the player is completely inside the door
	--�ꏊ�������ƃv���C���[��������Ȃ�����(�U�����Ă��Ȃ�) --EN:--Because you can't find the player if the location is bad (they won't attack)
	if proxy:IsClient() == false then
		proxy:ResetThink( 800 );
	end	
	
	proxy:SetEventFlag( SYSTEM_ID_IGNORE, false );

	print("OnEvent_111_3 end");
end


--��110 2��ڈȍ~�Ƀ{�X�����ɓ��邽�߂̃C�x���g�z�M�p --EN:--�� 110 For event delivery to enter the boss room after the second time
function OnEvent_110_GO_TO_IN(proxy, param)
	print("OnEvent_110_GO_TO_IN begin");

	proxy:NotNetMessage_begin();
		--��111�������J���Ă���Ƃ��ɒ��ɓ��邽�߂̃C�x���g��ǉ���--�n���h���� OnEvent_110 --EN:--��111��Add an event to enter when the door is open��--The handler is OnEvent_110
		proxy:OnPlayerActionInRegion( 111, 2895, "OnEvent_110", HELPID_GO_TO_IN, everytime );--
	proxy:NotNetMessage_end();	

	print("OnEvent_110_GO_TO_IN end");
end


--��110 �t���O�Z�b�g(�����p) --EN:-- 110 Flag set (for synchronization)
function OnEvent_110_flag_set(proxy, param)
	print("OnEvent_110_flag_set begin");
		
	proxy:SetEventFlag( 110 , 1 );
	proxy:DeleteEvent( 110 ); 

	print("OnEvent_110_flag_set end");
end



--------------------------------------------------------------------------------------
--�{�X�������o��(�퓬�J�n)��114 --EN:--Boss begins to move (battle begins) 114
--------------------------------------------------------------------------------------

function OnEvent_114(proxy, param)
	print("OnEvent_114 begin");
	
	--�{�X��pBGM�Đ��J�n --EN:--Start playing BGM for boss battle
	proxy:PlayPointSE( 2160, SOUND_TYPE_M, 20000000, 0 );
	
	--�t�@�����N�X�̓���J�n --EN:-- Phalanx starts working
	PhalanxEventStart(proxy,param); 
	
	--�ǂݍ��݃^�C�~���O�̂Ƃ�����ǉ�����Ăق����̂Ńt���O���ĂȂ� --EN:-- I want it to be added every time at the time of reading, so I don't set a flag
	
	--�{�X�Q�[�W���Z�b�g --EN:--Set boss gauge
	proxy:SetBossGauge(800,0,5001);	
	
	--�����X�V��z�M --EN:--Distribute force update
	proxy:LuaCallStart( 114 , 10 );
	print("OnEvent_114 end");
end

--�{�X�����ɓ�����PC�ׂ̈ɋ����X�V��z�M --EN:--Distribute a forced update for the PC that entered the boss room
function OnEvent_114_1(proxy,param)
	print("OnEvent_114_1 begin");
	if param:IsNetMessage() == true then
		--LuaFunc_ForceOmission(proxy,10001+param:GetPlayID());
		proxy:SetAlwaysDrawForEvent(10001+param:GetPlayID(),true);
	else
		--LuaFunc_ForceOmission(proxy,10000);
	end
	print("OnEvent_114_1 end");
end


--------------------------------------------------------------------------------------
--��200�����Y��ւ̔��� --EN:-- �� 200 �� Door to execution ground ��
--------------------------------------------------------------------------------------
--[[
--��200_1�����Y��ւ̔���LuaCall��` --EN:-- �� 200_1 �� Door to execution ground �� LuaCall definition
function OnEvent_200_1(proxy, param)
	print("OnEvent_200_1 begin");

	proxy:PlayAnimation( 1040, 1 );--�����J���A�j���[�V���� --EN:-- Door opening animation
	
	--�v���C���[�̓����A�j���[�V����(true:�p�[�e�B�[�v���C���[���A�j���[�V��������) --EN:--Player synchronous animation (true: party player animated)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_OPEN ) == true then
		proxy:SetEventFlag( 200, 1 );
		proxy:DeleteEvent( 200 );--�p�[�e�B�[�v���C���[�̊Ď��폜 --EN:--Remove Party Player Observation
		print("OnEvent_200_1 end");
		return;
	end

	proxy:WarpDmy( LOCAL_PLAYER , 1040 , 191 );
	proxy:SetEventFlag( 200, 1 );
	proxy:DeleteEvent( 200 );--�����̊Ď��폜 --EN:--Delete own monitor

	print("OnEvent_200_1 end");
end


--��200�����Y��ւ̔��� --EN:-- �� 200 �� Door to execution ground ��
function OnEvent_200(proxy, param)
	print("OnEvent_200 begin");

	--���d�����h�~ --EN:--Multiple activation prevention
	if proxy:IsCompleteEvent( 200 ) == true then
		print("OnEvent_200 end");
		return;
	end
	
	--QWC�����͖������Ă��邩�H --EN:--Do you meet the QWC conditions?
	if	proxy:IsCompleteEvent( 201 ) == true then
		proxy:LuaCallStart( 200 , 1 );--�A�j���[�V�����̓����Đ�(�S�̂ɔz�M)	 --EN:-- Synchronous animation playback (distributed to all)

	--�K�v�A�C�e�����������Ă��Ȃ� --EN:--I don't have the required items
	else
		--�����J���Ȃ��ꍇ�̃��b�Z�[�W��\�� --EN:-- Display a message when the door does not open
		--proxy:InfomationMenu( INFOMENU_TYPE_SIMPLE, 0, MSG_CATEGORY_EVENT, 10010160, 1);
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010160, 0, 6, 1040, GEN_DIALOG_DIST, once );
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
		--proxy:ShowGenDialog(10010160,1,1,true);
	end

	print("OnEvent_200 end");
end
]]


--------------------------------------------------------------------------------------
--��210����_�ւ̔��� --EN:--��210��The door to the mausoleum��
--------------------------------------------------------------------------------------

--��210_1����_�ւ̔���LuaCall��` --EN:-- �� 210_1 �� Door to the mausoleum �� LuaCall definition
function OnEvent_210_1(proxy, param)
	print("OnEvent_210_1 begin");

	proxy:PlayAnimation( 1045, 1 );--�����J���A�j���[�V���� --EN:-- Door opening animation
	
	--�v���C���[�̓����A�j���[�V����(true:�p�[�e�B�[�v���C���[���A�j���[�V��������) --EN:--Player synchronous animation (true: party player animated)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_OPEN ) == true then
		proxy:SetEventFlag( 210 , 1 );
		proxy:DeleteEvent( 210 );
		print("OnEvent_210_1 end");
		return;
	end

	proxy:WarpDmy( LOCAL_PLAYER , 1045 , 191 );
	proxy:SetEventFlag( 210, 1 );

	print("OnEvent_210_1 end");
end


--��210����_�ւ̔��� --EN:--��210��The door to the mausoleum��
function OnEvent_210(proxy, param)
	print("OnEvent_210 begin");
	
	--���d�����h�~ --EN:--Multiple activation prevention
	if proxy:IsCompleteEvent( 210 ) == true then
		print("OnEvent_210 end");
		return;
	end
	
	--�K�v�A�C�e���̎w�� --EN:--Specify required items
	local KEY_ITEM_TYPE = TYPE_GOODS;
	local KEY_ITEM_ID   = 35;--��_�̌� --EN:--Mausoleum Key
	
	--�K�v�A�C�e�����������Ă���(�C���x���g���[�ɃA�C�e���Ƃ��ď������Ă���) --EN:--You have the necessary items (have them as items in your inventory)
	if proxy:IsInventoryEquip( KEY_ITEM_TYPE , KEY_ITEM_ID ) == true then
	
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			--��210_3���I�����j���[�̊Ď��� --EN:--��210_3��Monitor selection menu��
			--proxy:OnSelectMenu(210, "OnEvent_210_3", 10010829, 0, 1, 1045, 2, once);
			proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010829, 0, 6, 1045, GEN_DIALOG_DIST, once );
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
		OnEvent_210_3(proxy,param);

	--�K�v�A�C�e�����������Ă��Ȃ� --EN:--I don't have the required items
	else
		--�����J���Ȃ��ꍇ�̃��b�Z�[�W��\�� --EN:-- Display a message when the door does not open
		--proxy:InfomationMenu( INFOMENU_TYPE_SIMPLE, 0, MSG_CATEGORY_EVENT, 10010160, 1);
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010160, 0, 6, 1045, GEN_DIALOG_DIST, once );
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
		--proxy:ShowGenDialog(10010160,1,1,true);
	end

	print("OnEvent_210 end");
end


--��210_3���I�����j���[�̊Ď���(YES��I�������Ƃ�) --EN:--��210_3��Monitor selection menu��(When YES is selected)
function OnEvent_210_3(proxy,param)
	print("OnEvent_210_3 begin");
	proxy:LuaCallStart( 210 , 1 );--�A�j���[�V�����̓����Đ�(�S�̂ɔz�M)	 --EN:-- Synchronous animation playback (distributed to all)
	proxy:DeleteEvent( 210 );	
	print("OnEvent_210_3 end");
end
	

--------------------------------------------------------------------------------------
--��211����_�ւ̔��� --EN:--��211��The door to the mausoleum��
--------------------------------------------------------------------------------------

--��211_1����_�ւ̔���LuaCall��` --EN:-- �� 211_1 �� Door to the mausoleum �� LuaCall definition
function OnEvent_211_1(proxy, param)
	print("OnEvent_211_1 begin");

	proxy:PlayAnimation( 1047, 1 );--�����J���A�j���[�V���� --EN:-- Door opening animation
	
	--�v���C���[�̓����A�j���[�V����(true:�p�[�e�B�[�v���C���[���A�j���[�V��������) --EN:--Player synchronous animation (true: party player animated)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_OPEN ) == true then
		proxy:SetEventFlag( 211, 1 );		
		proxy:DeleteEvent( 211 );
		print("OnEvent_211_1 end");
		return;
	end

	proxy:WarpDmy( LOCAL_PLAYER , 1047 , 191 );
	proxy:SetEventFlag( 211, 1 );

	print("OnEvent_211_1 end");
end


--��211����_�ւ̔�2�� --EN:-- �� 211 �� Door to Mausoleum 2 ��
function OnEvent_211(proxy, param)
	print("OnEvent_211 begin");

	--���d�����h�~ --EN:--Multiple activation prevention
	if proxy:IsCompleteEvent( 211 ) == true then
		print("OnEvent_211 end");
		return;
	end
	
	--�K�v�A�C�e���̎w�� --EN:--Specify required items
	local KEY_ITEM_TYPE = TYPE_GOODS;
	local KEY_ITEM_ID   = 35;--��_�̌� --EN:--Mausoleum Key
	
	--�K�v�A�C�e�����������Ă���(�C���x���g���[�ɃA�C�e���Ƃ��ď������Ă���) --EN:--You have the necessary items (have them as items in your inventory)
	if proxy:IsInventoryEquip( KEY_ITEM_TYPE , KEY_ITEM_ID ) == true then
	
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			--��211_3���I�����j���[�̊Ď��� --EN:--��211_3��Monitor selection menu��
			--proxy:OnSelectMenu(211, "OnEvent_211_3", 10010829, 0, 2, 1047, 2, once);
			proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010829, 0, 6, 1047, GEN_DIALOG_DIST, once );
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
		OnEvent_211_3(proxy,param);

	--�K�v�A�C�e�����������Ă��Ȃ� --EN:--I don't have the required items
	else
		--�����J���Ȃ��ꍇ�̃��b�Z�[�W��\�� --EN:-- Display a message when the door does not open
		--proxy:InfomationMenu( INFOMENU_TYPE_SIMPLE, 0, MSG_CATEGORY_EVENT, 10010160, 1);
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010160, 0, 6, 1047, GEN_DIALOG_DIST, once );
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
		--proxy:ShowGenDialog(10010160,1,1,true);
	end

	print("OnEvent_211 end");
end


--��211_3���I�����j���[�̊Ď���(YES��I�������Ƃ�) --EN:--��211_3��Monitor selection menu��(When YES is selected)
function OnEvent_211_3(proxy,param)
	print("OnEvent_211_3 begin");
	proxy:LuaCallStart( 211 , 1 );--�A�j���[�V�����̓����Đ�(�S�̂ɔz�M)	 --EN:-- Synchronous animation playback (distributed to all)
	proxy:DeleteEvent( 211 );
	print("OnEvent_211_3 end");
end


--------------------------------------------------------------------------------------
--��5����_�̍Ւd�� --EN:-- �� 5 �� Mausoleum Altar ��
--------------------------------------------------------------------------------------

function OnEvent_5(proxy, param)
	if param:IsNetMessage() == false then
	print("OnEvent_5 begin");
	proxy:NotNetMessage_begin();
	proxy:RepeatMessage_begin();
		proxy:PlayAnimation( 10000 , 8290);		
		proxy:PlayAnimation( 1192 , 1);	
		proxy:OnKeyTime2( 5 , "OnEvent_5_0",0.01,0,0,once);
	proxy:RepeatMessage_end();
	proxy:NotNetMessage_end();	
	print("OnEvent_5 end");
	end
end

function OnEvent_5_0(proxy,param)
	print("OnEvent_5_0 begin");
	--if proxy:IsPlayerStay(10000) == true then
	if proxy:IsEventAnim( 10000 , 8290 ) == true then
		proxy:LuaCallStart( 5 , 2 );
	else
		proxy:ForcePlayAnimation( 1192 , 0);	
	end
	print("OnEvent_5_0 end");
end

--��5_1���A�C�e���擾�� --EN:-- �� 5_1 �� item acquisition ��
function OnEvent_5_1(proxy, param)
	print("OnEvent_5_1 begin");

	--�A�C�e���擾�֐�--�p�����[�^10104�Q�� --EN:--item retrieval function--see parameter 10104
	proxy:GetRateItem(10104);	
	
	--�A�C�e�����擾�ς� --EN:--item already acquired
	proxy:SetEventFlag( 5, 1 );
	
	--OBJ���������߂̃C�x���g�z�M --EN:--Event distribution for erasing OBJ
	proxy:LuaCallStart( 5, 1);
	
	print("OnEvent_5_1 end");
end

--��5_2����OBJ��\���p�� --EN:--��5_2��For hiding the sword OBJ��
function OnEvent_5_2(proxy,param)
	print("OnEvent_5_2 begin");
	--�I�u�W�F�������� --EN:--The object disappears
	proxy:SetDrawEnable( 1192 , false );--�ЂƂ܂��`�悾��OFF --EN:--Only drawing is turned off for the time being
	proxy:SetColiEnable( 1192 , false );--������͂���͕̂s��(����ł͂Ȃ��悤�Ȃ̂ŏ����Ȃ�)	 --EN:--I don't know if there is a hit (I don't delete it because it doesn't seem to be the current situation)
	
	--�C�x���g������ --EN:--event disappears
	proxy:DeleteEvent( 5 );
	print("OnEvent_5_2 end");
end

--�A�j���Đ��̓������Ď� --EN:--Animation playback synchronization & monitoring
function OnEvent_5_3(proxy,param)
	print("OnEvent_5_3 begin");
	
	proxy:TreasureDispModeChange2( 1192, false ,KEN_SFX);
	--�v���C���[�̓����A�j���[�V����(true:�p�[�e�B�[�v���C���[���A�j���[�V��������) --EN:--Player synchronous animation (true: party player animated)
	if Luafunc_PlaySynchroAnimation( proxy, param, 8290 ) == true then--�V�����A�j��  --EN:-- new anime
		proxy:PlayAnimation( 1192 , 1);	
		print("OnEvent_5 end");
		return true;
	end
	
	--���Ƀ��[�v --EN:--Warp to sword
	proxy:WarpDmy( LOCAL_PLAYER , 1192 , 191 );		
	
	proxy:NotNetMessage_begin();
		proxy:OnChrAnimEnd( 5 , LOCAL_PLAYER , 8290 , "OnEvent_5_1", once);
	proxy:NotNetMessage_end();
	
	print("OnEvent_5_3 end");
end



--------------------------------------------------------------------------------------
--��220����(��)���Q�Ă��遡 --EN:-- �� 220 �� Wyvern (Long) is sleeping ��
--------------------------------------------------------------------------------------

TYOU_STATE_WAIT = 0;
TYOU_STATE_ATACK = 1;
TYOU_STATE_ATACK_DILAY = 2;

tyou_state_in_home = TYOU_STATE_WAIT;

function OnEvent_220(proxy, param)
--	print("OnEvent_220 begin");

	--�ҋ@���(�U���\) --EN:-- Standby state (attack possible)
	if tyou_state_in_home == TYOU_STATE_WAIT then
			
		tyou_state_in_home = TYOU_STATE_ATACK;--�U����Ԃ� --EN:-- to attack state
		
		proxy:StopLoopAnimation( 300 );--�ҋ@�A�j���Ƃ߂� --EN:--stop animation
		proxy:PlayAnimation( 300 , 3001 );--�U���A�j���Đ��J�n --EN:--Start playing attack animation
		proxy:SetEventFlag( 220 , 0 );
		proxy:NotNetMessage_begin();
			--��220���U���A�j���̏I���� --EN:--��220��End of attack animation��
			proxy:OnChrAnimEnd( 220 , 300 , 3001 , "OnEvent_220_atack_end" , once );
		proxy:NotNetMessage_end();
		proxy:SetEventFlag( 220 , 1 );
	
	--�U���� --EN:--Attacking
	elseif tyou_state_in_home == TYOU_STATE_ATACK then
			
	--�čU���҂� --EN:--Waiting for re-attack
	elseif tyou_state_in_home == TYOU_STATE_ATACK_DILAY then
	
	end
	
--	print("OnEvent_220 end");
end

--��220���U���A�j���̏I���� --EN:--��220��End of attack animation��
function OnEvent_220_atack_end(proxy ,param)
	print("OnEvent_220_atack_end begin");
	
	--�U���I������̂ŁA�čU���҂���Ԃ� --EN:--Since the attack is over, go to the state of waiting for another attack
	tyou_state_in_home = TYOU_STATE_ATACK_DILAY;
	
	proxy:SetEventFlag( 220 , 0 );
	proxy:NotNetMessage_begin();
		--��220_dilay_end���čU���ҋ@�� --EN:--��220_delay_end��Waiting for re-attack��
		local dilay_time = 3.0;--3�b --EN:--3 seconds
		proxy:OnKeyTime2( 220 , "OnEvent_220_atack_dilay_end" , dilay_time , 0 , 1 , once );
	proxy:NotNetMessage_end();
	proxy:SetEventFlag( 220 , 1 );
	
	proxy:PlayLoopAnimation( 300, 7000 );--�ҋ@�A�j�����[�v�Đ� --EN:--Standby animation loop playback
	
	print("OnEvent_220_atack_end end");
end


--��220���U���A�j���̏I���� --EN:--��220��End of attack animation��
function OnEvent_220_atack_dilay_end(proxy ,param)
	print("OnEvent_220_atack_dilay_end begin");
	
	--�U���܂���Ԃ�������̂ŁA�čU���\���ҋ@��Ԃ� --EN:--The attack waiting state is over, so you can attack again �� Go to standby state
	tyou_state_in_home = TYOU_STATE_WAIT;
		
	print("OnEvent_220_atack_dilay_end end");
end



--------------------------------------------------------------------------------------
--��221����(�ő�)���x�����Ă��遡 --EN:--�� 221 �� Wyvern (kin) is wary ��
--------------------------------------------------------------------------------------

KENZOKU_STATE_WAIT = 0;--�ҋ@��� --EN:--wait state
KENZOKU_STATE_ATACK = 1;--�U�����(�͈͓��ɂ���Ƃ�) --EN:--attack state (when in range)
KENZOKU_STATE_ATACK_DILAY = 2;--�U���̂��Ƃ̑ҋ@�� �U���҂���� --EN:--Standby after an attack is attack waiting state

kenzoku_state_in_home = KENZOKU_STATE_WAIT;--�ŏ��͂Ƃ肠�����ҋ@ --EN:--Wait for now
--�������������Ƃ�����A�t���O3�����ď��������ɍČ�? --EN:--If this is also synchronized, can it be reproduced at initialization using three flags?

--�ҋ@���U���ɂȂ�Ƃ��ɁA3�b���ƁA�A�j���̓r������Đ��ɂȂ�̂ŁA1�񕪌� --EN:--When waiting �� attacking, if it is 3 seconds, it will start playing from the middle of the animation, so after 1 time
--�Ƃ��̂ق����ǂ���������Ȃ�? --EN:-- might be better?
kenzoku_play_anime_id = 0;
function OnEvent_199(proxy,param)
	print("OnEvent_199 begin");

	--���ɂ����Ԏ��ɒ��߂ɐ؂�ւ� --EN:--Switch to give up when in the nest
	if	proxy:IsCompleteEvent( KENZOKU_STATE_WARNING ) == true and
		proxy:IsCompleteEvent( 0 ) == true then
		SetNpcStateFlag( proxy , param , kenzoku_flag_list , KENZOKU_STATE_WARNING_AND_LEVER );
	end
	
	--�����x�����@or�@�����x����(���o�[�j�~�������)�@�̏ꍇ�œP�ރt���OON --EN:--Withdrawal flag ON when the nest is on guard or when the nest is on guard (give up to block the lever)
	if	   (proxy:IsCompleteEvent( KENZOKU_STATE_WARNING ) == true   or
			proxy:IsCompleteEvent( KENZOKU_STATE_WARNING_AND_LEVER ) == true ) and
			proxy:IsCompleteEvent( 234 ) == true then
		print("OnEvent_199 -> OnEvent_234_1");
		--��OnEvent_234_1 --EN:--��OnEvent_234_1
		proxy:LuaCallStart( 234, 2 );
	
	--��230���C�x���g���� --EN:-- �� 230 �� Event conditions
	elseif	proxy:IsCompleteEvent( KENZOKU_STATE_WARNING ) == true and
			proxy:IsCompleteEvent( 222 ) == true then
		print("OnEvent_199 -> OnEvent_230_1");
		--��OnEvent_230_1 --EN:--��OnEvent_230_1
		proxy:LuaCallStart( 230, 1 );
	--��221���C�x���g���� --EN:-- �� 221 �� Event conditions
	elseif	(proxy:IsCompleteEvent( KENZOKU_STATE_WARNING_AND_LEVER ) == true or
		 proxy:IsCompleteEvent( KENZOKU_STATE_WARNING ) == true ) and
		proxy:IsCompleteEvent( 222 ) == false and
		proxy:IsCompleteEvent( 223 ) == true then
		print("OnEvent_199 -> OnEvent_221_1");
		--��OnEvent_221_1 --EN:--��OnEvent_221_1
		proxy:LuaCallStart( 221, 1 );
		
	--��190���C�x���g���� --EN:-- �� 190 �� Event conditions
	elseif (proxy:IsCompleteEvent( KENZOKU_STATE_WARNING_AND_LEVER ) == true or
			proxy:IsCompleteEvent( KENZOKU_STATE_WARNING ) == true ) and
			proxy:IsCompleteEvent( 222 ) == false and
			proxy:IsCompleteEvent( 223 ) == false and
			proxy:IsCompleteEvent( 224 ) == true then
		print("OnEvent_199 -> OnEvent_190_1");
		--��OnEvent_190_1 --EN:--��OnEvent_190_1
		proxy:LuaCallStart( 190, 1 );
		
	--��191���C�x���g���� --EN:-- �� 191 �� Event conditions
	elseif (proxy:IsCompleteEvent( KENZOKU_STATE_WARNING_AND_LEVER ) == true or
			proxy:IsCompleteEvent( KENZOKU_STATE_WARNING ) == true ) and
			proxy:IsCompleteEvent( 222 ) == false and
			proxy:IsCompleteEvent( 223 ) == false and
			proxy:IsCompleteEvent( 224 ) == false and
			proxy:IsCompleteEvent( 225 ) == true then
		print("OnEvent_199 -> OnEvent_191_1");
		--��OnEvent_191_1 --EN:--��OnEvent_191_1
		proxy:LuaCallStart( 191, 1 );
		
		
	--�������ǂ֔��ł��闬�� --EN:--The flow that flies from the nest to the walls
	--��231���C�x���g���� --EN:-- �� 231 �� Event conditions
	elseif	proxy:IsCompleteEvent( KENZOKU_STATE_PROTECT_CASTLE ) == true and
			proxy:IsCompleteEvent( 222 ) == true and
			proxy:IsCompleteEvent( 0 )   == false and
			proxy:IsCompleteEvent( 234 ) == false then
		if	kenzoku_play_anime_id == 7001 or
			kenzoku_play_anime_id == 7002 or
			kenzoku_play_anime_id == 7005 then
			print("OnEvent_199 -> OnEvent_231_1");
			--��OnEvent_231_1 --EN:--��OnEvent_231_1
			proxy:LuaCallStart( 231, 1 );
		elseif	kenzoku_play_anime_id == 7004 then
			print("OnEvent_199 -> OnEvent_231_2");
			--��OnEvent_231_2 --EN:--��OnEvent_231_2
			proxy:LuaCallStart( 231, 2 );
		else
			print("OnEvent_199 -> 231 Failed");
			print("animId = ", kenzoku_play_anime_id);
		end
		
	--�u���X���[�v����P�ނւ̗��� --EN:--Flow from breath loop to withdrawal
	--��232���C�x���g���� --EN:-- �� 232 �� Event conditions
	--��233���C�x���g���� --EN:-- �� 233 �� Event conditions
	--�̈�ɒN�����Ȃ� or ���o�[�������ꂽ or ���������ɂ��� --EN:--There is no one in the area or the lever is pulled or you are about to die
	elseif	(proxy:IsCompleteEvent( KENZOKU_STATE_PROTECT_CASTLE ) == true and
			 proxy:IsCompleteEvent( 222 ) == false ) or
			(proxy:IsCompleteEvent( KENZOKU_STATE_PROTECT_CASTLE ) == true and
			proxy:IsCompleteEvent( 0 ) == true ) or
			(proxy:IsCompleteEvent( KENZOKU_STATE_PROTECT_CASTLE ) == true and
			proxy:IsCompleteEvent( 234 ) == true ) then
			
		--�ʏ�̑��ɖ߂邩 --EN:--return to normal nest
		if	proxy:IsCompleteEvent( 0 ) == true then
			SetNpcStateFlag( proxy , param , kenzoku_flag_list , KENZOKU_STATE_WARNING_AND_LEVER );
		else
			SetNpcStateFlag( proxy , param , kenzoku_flag_list , KENZOKU_STATE_WARNING );
		end
		
		if	kenzoku_play_anime_id == 7002 or
			kenzoku_play_anime_id == 7004 or
			kenzoku_play_anime_id == 7005 then
			print("OnEvent_199 -> OnEvent_232_1");
			--��OnEvent_232_1 --EN:--��OnEvent_232_1
			proxy:LuaCallStart( 232, 1 );
		elseif	kenzoku_play_anime_id == 7003 then
			print("OnEvent_199 -> OnEvent_232_2");
			--��OnEvent_232_2 --EN:--��OnEvent_232_2
			proxy:LuaCallStart( 232, 2 );
		else
			print("OnEvent_199 -> 232 Failed");
			print("animId = ", kenzoku_play_anime_id);
		end
		
	--��199���f�t�H���g�ҋ@�A�j�����[�v --EN:-- �� 199 �� Default standby animation loop
	else
			print("OnEvent_199 -> OnEvent_199_default");
		--��OnEvent_199_default --EN:--��OnEvent_199_default
		proxy:LuaCallStart( 199, 1 );
	end
	print("OnEvent_199 end");
end


--�򗳃A�j���I���̐߂ɕK���ʂ�C�x���g --EN:-- An event that must pass at the end of the flying dragon animation
function OnEvent_199_anim_end(proxy,param)
	print("OnEvent_199_anim_end begin");
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 199, "OnEvent_199", 0.0, 0, 2, once );
	proxy:NotNetMessage_end();
	print("OnEvent_199_anim_end end");
end


function OnEvent_199_default(proxy,param)
	print("OnEvent_199_default begin");
	
	kenzoku_play_anime_id = 0;
	proxy:ForcePlayAnimation( 301, 0 );
	
	if	param:IsNetMessage() == true then
		print("OnEvent_199_default return end");
		return;
	end
	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		proxy:OnChrAnimEnd( 199, 301, 0, "OnEvent_199_anim_end", once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	
	print("OnEvent_199_default end");
end


--------------------------------------------------------------------------------------
--��221����(�ő�)���\���P���҂��P�`�R�b�� --EN:-- �� 221 �� Wyvern (kin) rampages 1 �� Wait 1-3 seconds ��
--------------------------------------------------------------------------------------
function OnEvent_221_1(proxy, param)
	print("OnEvent_221_1 begin");

	kenzoku_play_anime_id = 3001;
	proxy:ForcePlayAnimationStayCancel( 301, 3001 );
	
	if	param:IsNetMessage() == true then
		print("OnEvent_221_1 return end");
		return;
	end
	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		--��221���U���A�j���̏I���� --EN:--��221��End of attack animation��
		proxy:OnChrAnimEnd( 221 , 301 , 3001 , "OnEvent_221_1_1" , once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	print("OnEvent_221_1 end");
end

function OnEvent_221_1_1(proxy,param)
	--��OnEvent_221_2 --EN:--��OnEvent_221_2
	proxy:LuaCallStart( 221, 2 );
end


--��221���U���A�j���̏I���� --EN:--��221��End of attack animation��
function OnEvent_221_2(proxy ,param)
	print("OnEvent_221_2 begin");
	
	kenzoku_play_anime_id = 0;
	proxy:ForcePlayLoopAnimation( 301, 0 );--�ҋ@�A�j�����[�v�Đ� --EN:--Standby animation loop playback
	
	if	param:IsNetMessage() == true then
		print("OnEvent_221_2 return end");
		return;
	end
	
	proxy:NotNetMessage_begin();
		--��221_dilay_end���čU���ҋ@�� --EN:--��221_delay_end��Waiting for re-attack��
		local dilay_time = proxy:GetRandom( 10, 30 ) / 10;--1�b�`3�b --EN:--1s~3s
		proxy:OnKeyTime2( 221 , "OnEvent_199_anim_end" , dilay_time , 0 , 1 , once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_221_2 end");
end

--------------------------------------------------------------------------------------
--��190����(�ő�)���\���Q���҂��P�`�R�b�� --EN:-- �� 190 �� Wyvern (kin) rampages 2 �� Wait 1-3 seconds ��
--------------------------------------------------------------------------------------
function OnEvent_190_1(proxy,param)
	print("OnEvent_190_1 begin");
	kenzoku_play_anime_id = 3003;
	proxy:ForcePlayAnimation( 301, 3003 );
	
	if	param:IsNetMessage() == true then
		print("OnEvent_190_1 return end");
		return;
	end
	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		--��221���U���A�j���̏I���� --EN:--��221��End of attack animation��
		proxy:OnChrAnimEnd( 221 , 301 , 3003 , "OnEvent_190_1_1" , once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	print("OnEvent_190_1 end");
end

function OnEvent_190_1_1(proxy,param)
	print("OnEvent_190_1_1 begin");
	--��OnEvent_190_2 --EN:--��OnEvent_190_2
	proxy:LuaCallStart( 190, 2 );
	print("OnEvent_190_1_1 end");
end


function OnEvent_190_2(proxy,param)
	print("OnEvent_190_2 begin");
	
	kenzoku_play_anime_id = 0;
	proxy:ForcePlayLoopAnimation( 301, 0 );--�ҋ@�A�j�����[�v�Đ� --EN:--Standby animation loop playback
	
	if	param:IsNetMessage() == true then
		print("OnEvent_190_2 return end");
		return;
	end
	
	proxy:NotNetMessage_begin();
		local dilay_time = proxy:GetRandom( 10, 30 ) / 10;--1�b�`3�b --EN:--1s~3s
		proxy:OnKeyTime2( 190 , "OnEvent_199_anim_end" , dilay_time , 0 , 1 , once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_190_2 end")
end



--------------------------------------------------------------------------------------
--��191����(�ő�)���\���R���҂��P�`�R�b�� --EN:-- �� 191 �� Wyvern (kin) rampages 3 �� Wait 1-3 seconds ��
--------------------------------------------------------------------------------------
function OnEvent_191_1(proxy,param)
	print("OnEvent_191_1 begin");
	kenzoku_play_anime_id = 3002;
	proxy:ForcePlayAnimation( 301, 3002 );
	
	if	param:IsNetMessage() == true then
		print("OnEvent_191_1 return end");
		return;
	end
	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		--��221���U���A�j���̏I���� --EN:--��221��End of attack animation��
		proxy:OnChrAnimEnd( 221 , 301 , 3002 , "OnEvent_191_1_1" , once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	print("OnEvent_191_1 end");
end

function OnEvent_191_1_1(proxy,param)
	print("OnEvent_191_1_1 begin");
	--��OnEvent_191_2 --EN:--��OnEvent_191_2
	proxy:LuaCallStart( 191, 2 );
	print("OnEvent_191_1_1 end");
end

function OnEvent_191_2(proxy,param)
	print("OnEvent_191_2 begin");
	
	kenzoku_play_anime_id = 0;
	proxy:ForcePlayLoopAnimation( 301, 0 );--�ҋ@�A�j�����[�v�Đ� --EN:--Standby animation loop playback
	
	if	param:IsNetMessage() == true then
		print("OnEvent_191_2 return end");
		return;
	end
	
	proxy:NotNetMessage_begin();
		local dilay_time = proxy:GetRandom( 10, 30 ) / 10;--1�b�`3�b --EN:--1s~3s
		proxy:OnKeyTime2( 191 , "OnEvent_199_anim_end" , dilay_time , 0 , 1 , once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_191_2 end")
end


--------------------------------------------------------------------------------------
--��230����(�ő�)�����ł��遨�u���X�f���� --EN:--�� 230 �� Wyvern (Family) comes flying �� Breath ��
--------------------------------------------------------------------------------------

function OnEvent_230_1(proxy, param)
	print("OnEvent_230_1 begin");

	--�ʒu�E�p�x�����킹�邽�߂Ƀ��[�v --EN:--Warp to match position/angle
	proxy:Warp(301,2030);

	--��(�ő�)���򗧂A�j�� --EN:--An animation in which a flying dragon (kin) flies away
	kenzoku_play_anime_id = 7000;
	proxy:ForcePlayAnimationStayCancel( 301 , 7000 );
	
	--��(�ő�)�̏�Ԃ���ǌ��ɃZ�b�g --EN:-- Set Hiryu (Family) state to Protect Wall
	SetNpcStateFlag( proxy , param , kenzoku_flag_list , KENZOKU_STATE_PROTECT_CASTLE );
	
	if	param:IsNetMessage() == true then
		print("OnEvent_230_1 return end");
		return;
	end
	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		--��230_1����(�ő�)���򗧂A�j���Đ��I���� --EN:--��230_1��Finished playing the animation of flying dragons (kin)��
		proxy:OnChrAnimEnd( 230 , 301, 7000, "OnEvent_230_1_1" , once);
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	
	print("OnEvent_230_1 end");
end

function OnEvent_230_1_1(proxy,param)
	print("OnEvent_230_1_1 begin");
	--��OnEvent_230_2 --EN:--��OnEvent_230_2
	proxy:LuaCallStart( 230, 2 );
	print("OnEvent_230_1_1 end");
end


--��230_2����(�ő�)���򗧂A�j���Đ��I���� --EN:--��230_2��End of the animation where the wyvern (kin) takes flight��
function OnEvent_230_2(proxy , param )
	print("OnEvent_230_2 begin");
	
	--�ʒu�E�p�x�����킹�邽�߂Ƀ��[�v --EN:--Warp to match position/angle
	proxy:Warp(301,2031);
	
    --��(�ő�)�����ł���A�j�� --EN:--An animation in which flying dragons (kin) fly
	kenzoku_play_anime_id = 7002;
	proxy:ForcePlayAnimationStayCancel( 301 , 7002 );

	if	param:IsNetMessage() == true then
		print("OnEvent_230_2 return end");
		return;
	end
	
	proxy:NotNetMessage_begin();
		--��231����(�ő�)�����ł���A�j���Đ��I���� --EN:--��231��The animation of flying dragons (kin) ends��
		proxy:OnChrAnimEnd( 230 , 301 , 7002 , "OnEvent_199_anim_end" , once );
	proxy:NotNetMessage_end();
	

	print("OnEvent_230_2 end");
end


--------------------------------------------------------------------------------------
--��231����(�ő�)���u���X�f��1���u���X�f��2���[�v�� --EN:--�� 231 �� Wyvern (kin) breathes out 1 �� breathes out 2 loops ��
--------------------------------------------------------------------------------------
--��231����(�ő�)�����ł���A�j���Đ��I���� --EN:--��231��Finished playing the animation of the flying dragon (kin)��
function OnEvent_231_1(proxy , param )
	print("OnEvent_231_1 begin");
	
	--�ʒu�E�p�x�����킹�邽�߂Ƀ��[�v --EN:--Warp to match position/angle
	proxy:Warp(301,2032);

	--��тȂ���u���X�U���A�j��1 --EN:--Breath attack animation while flying 1
	kenzoku_play_anime_id = 7004;
	proxy:ForcePlayAnimationStayCancel( 301 , 7004 );
	
	if	param:IsNetMessage() == true then
		print("OnEvent_231_1 return end");
		return;
	end
	
	proxy:NotNetMessage_begin();
		--��231_1����тȂ���u���X�U���A�j��1�I���� --EN:--��231_1��Flying breath attack animation 1 ends��
		proxy:OnChrAnimEnd( 231 , 301 , 7004 , "OnEvent_231_1_1" , once );
	proxy:NotNetMessage_end();


	print("OnEvent_231_1 end");
end


function OnEvent_231_1_1(proxy,param)
	print("OnEvent_231_1_1 begin");
	--��OnEvent_231_2 --EN:--��OnEvent_231_2
	proxy:LuaCallStart( 231, 2 );
	print("OnEvent_231_1_1 end");
end


--��231_1����тȂ���u���X�U���A�j��1�I���� --EN:--��231_1��Flying breath attack animation 1 ends��
function OnEvent_231_2(proxy , param )
	print("OnEvent_231_2 begin");

	--�ʒu�E�p�x�����킹�邽�߂Ƀ��[�v --EN:--Warp to match position/angle
	proxy:Warp(301,2032);
	
	--��тȂ���u���X�U���A�j��2 --EN:--Breath attack animation 2 while flying
	kenzoku_play_anime_id = 7005;
	proxy:ForcePlayAnimationStayCancel( 301 , 7005 );

	
	if	param:IsNetMessage() == true then
		print("OnEvent_231_2 return end");
		return;
	end
	
	proxy:NotNetMessage_begin();
		--��231_2����тȂ���u���X�U���A�j��2�I���� --EN:--��231_2��Flying breath attack animation 2 ends��
		proxy:OnChrAnimEnd( 231 , 301 , 7005 , "OnEvent_199_anim_end" , once );
	proxy:NotNetMessage_end();

	print("OnEvent_231_2 end");
end



--------------------------------------------------------------------------------------
--��232����(�ő�)���A���Ă����� --EN:-- �� 232 �� Wyvern (Family) is returning ��
--------------------------------------------------------------------------------------

function OnEvent_232_1(proxy, param)
	print("OnEvent_232_1 begin");

	--�ʒu�E�p�x�����킹�邽�߂Ƀ��[�v --EN:--Warp to match position/angle
	proxy:Warp(301,2034);
	
	--��тȂ���u���X�U���A�j��2 --EN:--Breath attack animation 2 while flying
	kenzoku_play_anime_id = 7003;
	proxy:ForcePlayAnimationStayCancel( 301 , 7003 );

	if	param:IsNetMessage() == true then
		print("OnEvent_232_1 return end");
		return;
	end
	
	proxy:NotNetMessage_begin();
		--��232_1����(�ő�)�������Ă����A�j���I���� --EN:--��232_1��End of the animation where Hiryu (kin) leaves��
		proxy:OnChrAnimEnd( 232 , 301 , 7003 , "OnEvent_232_1_1" , once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_232_1 end");
end

function OnEvent_232_1_1(proxy,param)
	print("OnEvent_232_1_1 begin");
	--��OnEvent_232_2 --EN:--��OnEvent_232_2
	proxy:LuaCallStart( 232, 2 );
	print("OnEvent_232_1_1 end");
end

--��232_1����(�ő�)�������Ă����A�j���I���� --EN:--��232_1��The end of the animation where the flying dragon (kin) leaves��
function OnEvent_232_2(proxy, param)
	print("OnEvent_232_2 begin");

	--�ʒu�E�p�x�����킹�邽�߂Ƀ��[�v --EN:--Warp to match position/angle
	proxy:Warp(301,2035);
	
	--��тȂ���u���X�U���A�j��2 --EN:--Breath attack animation 2 while flying
	kenzoku_play_anime_id = 7001;
	proxy:ForcePlayAnimation( 301 , 7001 );

	if	param:IsNetMessage() == true then
		print("OnEvent_232_2 return end");
		return;
	end
	
	proxy:NotNetMessage_begin();
		--��232_2����(�ő�)���Q���ɖ߂�A�j���I���� --EN:--��232_2��Hiryu returns to bed animation ends��
		proxy:OnChrAnimEnd( 232 , 301 , 7001 , "OnEvent_232_3" , once );
		--proxy:OnChrAnimEnd( 232 , 301 , 7001 , "OnEvent_199_anim_end" , once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_232_2 end");
end

function OnEvent_232_3(proxy,param)
	print("OnEvent_232_3 begin");
	
	--�ʒu�E�p�x�����킹�邽�߂Ƀ��[�v --EN:--Warp to match position/angle
	proxy:Warp( 301,2036);
	OnEvent_199_anim_end(proxy,param);
	
	print("OnEvent_232_3 end");
end

--------------------------------------------------------------------------------------
--��234����(�ő�)�̎��S�Ď��� --EN:-- �� 234 �� Wyvern (kin) death watch ��
--------------------------------------------------------------------------------------

function OnEvent_234(proxy , param)
	print( "OnEvent_234 begin" );
	
	--�P�ނ����t���O�𗧂Ă� --EN:--Flag withdrawn
	proxy:SetEventFlag( 234, true );
	
--[[	
	--��(�ő�)�̏�Ԃ����S�ɂ��� --EN:--Change the status of the wyvern (kin) to death
	--SetNpcStateFlag( proxy , param , kenzoku_flag_list , KENZOKU_STATE_DEAD );
	
	--��(�ő�)�֘A�C�x���g�폜 --EN:--Deletion of Wyvern (Family) related events
	proxy:DeleteEvent( 221 );--���Ōx�����Ă��� --EN:--Watching in the Nest
	proxy:DeleteEvent( 230 );--��ǂɔ��ł��� --EN:--flying to the ramparts
	
	proxy:OnKeyTime2( 234, "OnEvent_234_1", 0.0, 0, 2, once );

	--�z�X�g�̂݃A�C�e������ --EN:--Only the host can obtain items
	if	proxy:IsClient() == false then
		proxy:GetRateItem( 10118 );--�A�C�e������ --EN:-- Get items
	end
]]	
	print( "OnEvent_234 end" );
end

--LuaCallParam(234,2)
function OnEvent_234_1(proxy,param)
	print("OnEvent_234_1 begin");
	
	--�ʒu�E�p�x�����킹�邽�߂Ƀ��[�v --EN:--Warp to match position/angle
	proxy:Warp(301,2030);
	
	--��тȂ���u���X�U���A�j��2 --EN:--Breath attack animation 2 while flying
	kenzoku_play_anime_id = 7011;
	proxy:ForcePlayAnimation( 301 , 7011 );

	--�����͑S���o�^���� --EN:--Register all here
	proxy:NotNetMessage_begin();
		--��232_1����(�ő�)�������Ă����A�j���I���� --EN:--��232_1��End of the animation where Hiryu (kin) leaves��
		proxy:OnChrAnimEnd( 199 , 301 , 7011 , "OnEvent_234_1_1" , once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_234_1 end");
end

--�P�ރA�j���I���Ŗ����� --EN:--Disabled at the end of withdrawal animation
function OnEvent_234_1_1(proxy,param)
	print("OnEvent_234_1_1 begin");
	SetNpcStateFlag(proxy, param, kenzoku_flag_list, KENZOKU_STATE_ESCAPE );
	InvalidCharactor( proxy, 301 );
	print("OnEvent_234_1_1 end");
end



--[[
function OnEvent_234_1(proxy,param)
	print("OnEvent_234_1 begin");
	
	--proxy:OnRegistFunc(234, "Condition_234_anim_wait", "OnEvent_234_2", 2, once);
	--�L�����Ȃ̂ŁA�����ł̃A�j��ID�ɈӖ��͖����A�����ڂ����ׂɎg�p --EN:--Since it's a character, the anime ID here has no meaning, it's just used to get the length
	if	proxy:IsEventAnim( 301, 10 ) == true then
		proxy:OnChrAnimEnd( 234, 301, 10, "OnEvent_234_2", once );
	else
		OnEvent_234_2(proxy,param);
	end
	
	print("OnEvent_234_1 end");
end


function Condition_234_anim_wait(proxy,param)
	if	proxy:IsEventAnim(301, 7011) == false then
		return false;
	end
	return true;
end


function OnEvent_234_2(proxy,param)
	print("OnEvent_234_2 begin");
	proxy:ForcePlayAnimation( 301, 7011 );
	proxy:Warp(301, 2030);
	
	proxy:OnChrAnimEnd( 234, 301, 7011, "OnEvent_234_3", once );
	proxy:SetEventFlag( 234 , 1 );
	print("OnEvent_234_2 end");
end

--�򗳂��ő��@�P�ރA�j���I����A������ --EN:-- Hiryu's relatives Disabled after the withdrawal animation ends
function OnEvent_234_3(proxy,param)
	print("OnEvent_234_3 begin");
	InvalidCharactor(proxy, 301);
	print("OnEvent_234_3 end");
end
]]
--------------------------------------------------------------------------------------
--��235����(��)�̎��S�Ď��� --EN:-- �� 235 �� Wyvern (Lord) death watch ��
--------------------------------------------------------------------------------------

function OnEvent_235(proxy , param)
	print( "OnEvent_235 begin" );

	--�򗳂̒��͓P�ނ��邾���ŁA���񂾂킯�ł͂Ȃ� --EN:--The chief of the wyvern just withdrew, he didn't die
	--SetNpcStateFlag( proxy , param , tyo_flag_list , TYO_STATE_DEAD );
	
	--��(��)�֘A�C�x���g�폜 --EN:--Deletion of Wyvern (Long) related events
	proxy:DeleteEvent( 220 );--���ŐQ�Ă��� --EN:--sleeping in a nest
	
	proxy:OnKeyTime2( 235, "OnEvent_235_1", 0.0, 0, 2, once );

	print( "OnEvent_235 end" );
end

function OnEvent_235_1(proxy,param)
	print( "OnEvent_235_1 begin" );
	
	--proxy:OnRegistFunc(235, "Condition_235_anim_wait", "OnEvent_235_2", 2, once);
	--�L�����Ȃ̂ŁA�����ł̃A�j��ID�ɈӖ��͖����A�����ڂ����ׂɎg�p --EN:--Since it's a character, the anime ID here has no meaning, it's just used to get the length
	if	proxy:IsEventAnim( 300, 10 ) == true then
		proxy:OnChrAnimEnd( 235, 300, 10, "OnEvent_235_2", once );
	else
		OnEvent_235_2(proxy,param);
	end
	
	print( "OnEvent_235_1 end" );
end

function Condition_235_anim_wait(proxy,param)
	if	proxy:IsEventAnim(300, 7018) == false then
		return false;
	end
	return true;
end


function OnEvent_235_2(proxy,param)
	print("OnEvent_235_2 begin");
	proxy:ForcePlayAnimation( 300, 7018 );
	proxy:NotNetMessage_begin();
		--�򗳂̒��A�P�ރA�j��(7018)�Đ� --EN:--The leader of the flying dragon, retreat animation (7018) playback
		proxy:OnChrAnimEnd(235, 300, 7018, "OnEvent_235_3", once);
	proxy:NotNetMessage_end();
	
	print("OnEvent_235_2 end");
end

--�P�ރA�j���I���� --EN:--After the withdrawal animation ends
function OnEvent_235_3(proxy,param)
	print("OnEvent_235_3 begin");
	SetNpcStateFlag(proxy, param, tyo1_flag_list, TYO_STATE_ESCAPE );
	InvalidCharactor(proxy, 300 );	
	print("OnEvent_235_3 end");
end



--------------------------------------------------------------------------------------
--��240���z�X�gPC�݂̂��ʂ����̖��� --EN:--��240��Light fog that only the host PC can pass��
--------------------------------------------------------------------------------------

--��240_delete_wall�����@�Ǎ폜�����p�� --EN:--��240_delete_wall��For synchronization of magic wall deletion��
function OnEvent_240_delete_wall(proxy , param)
	print("OnEvent_240_delete_wall begin");
	
	proxy:SetDrawEnable( 1055 , false );--���@�Ǖ`��OFF --EN:--Magic Wall Drawing OFF
	proxy:SetColiEnable( 1055 , false );--���@�Ǔ�����OFF --EN:--Magic wall hit OFF
	proxy:SetObjDeactivate( 1055 , true );--�f�A�N�e�B�u --EN:--deactivate
	proxy:InvalidSfx( 2075 , true );--SFX OFF
	proxy:DeleteEvent( 240 );--�S�v���C���[���̊Ď�������͂��B --EN:--Surveillance for all players should disappear.
	
	print("OnEvent_240_delete_wall end");
end


--��240���C�x���g�����p�� --EN:-- �� 240 �� For event activation ��
function OnEvent_240(proxy , param)
	print("OnEvent_240 begin");

	--���d�����h�~ --EN:--Multiple activation prevention
	if proxy:IsCompleteEvent( 240 ) == true then
		print("OnEvent_240 end");
		return;
	end
	
	--�v���C���[�̓����A�j���[�V����(true:�p�[�e�B�[�v���C���[���A�j���[�V��������) --EN:--Player synchronous animation (true: party player animated)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_WALK ) == true then
		proxy:SetEventFlag( 240 , 1 );
		print("OnEvent_240 end");
		return;
	end
	
	--�_�~�|���փ��[�v --EN:--Warp to Damipoli
	proxy:WarpDmy( LOCAL_PLAYER , 1055 , 191 );
	
	proxy:NotNetMessage_begin();
		--��240_1�������A�j���I���� --EN:--��240_1��End of walking animation��
		--proxy:OnChrAnimEnd( 240 , LOCAL_PLAYER , ANIMEID_WALK , "OnEvent_240_1" , once );
		proxy:LuaCallStart( 240 , 1 );--���̖��폜���� --EN:--light fog removal sync
	proxy:NotNetMessage_end();
	
	proxy:SetEventFlag( 240 , 1 );
	
	--�v���t�@�C���Z�[�u�v�� --EN:--profile save request
	proxy:SaveRequest_Profile();
	
	print("OnEvent_240 end");
end


--��240_1�������A�j���I���� --EN:--��240_1��End of walking animation��
function OnEvent_240_1(proxy , param)
	print("OnEvent_240_1 begin");
	
	--proxy:LuaCallStart( 240 , 1 );--���̖��폜���� --EN:--light fog removal sync
	
	print("OnEvent_240_1 end");
end





--------------------------------------------------------------------------------------
--��241���z�X�gPC�݂̂��ʂ����̖��� --EN:-- �� 241 �� A fog of light that only the host PC can pass through ��
--------------------------------------------------------------------------------------

--��241_delete_wall�����@�Ǎ폜�����p�� --EN:--��241_delete_wall��For synchronized magic wall deletion��
function OnEvent_241_delete_wall(proxy , param)
	print("OnEvent_241_delete_wall begin");
	
	proxy:SetDrawEnable( 1056 , false );--�`��OFF --EN:--Drawing OFF
	proxy:SetColiEnable( 1056 , false );--������OFF --EN:--Hit OFF
	proxy:SetObjDeactivate( 1056 , true );--�f�A�N�e�B�u --EN:--deactivate
	proxy:DeleteEvent( 241 );
	proxy:InvalidSfx( 2076 , true );--SFX OFF
	
	print("OnEvent_241_delete_wall end");
end


--��241���C�x���g�����p�� --EN:-- �� 241 �� For event activation ��
function OnEvent_241(proxy , param)
	print("OnEvent_241 begin");

	--���d�����h�~ --EN:--Multiple activation prevention
	if proxy:IsCompleteEvent( 241 ) == true then
		print("OnEvent_241 end");
		return;
	end	
	
	--�v���C���[�̓����A�j���[�V����(true:�p�[�e�B�[�v���C���[���A�j���[�V��������) --EN:--Player synchronous animation (true: party player animated)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_WALK ) == true then
		proxy:SetEventFlag( 241 , 1 );
		print("OnEvent_241 end");
		return;
	end
	
	--�_�~�|���փ��[�v --EN:--Warp to Damipoli
	proxy:WarpDmy( LOCAL_PLAYER , 1056 , 191 );
	
	proxy:NotNetMessage_begin();
		--��241_1�������A�j���I���� --EN:--��241_1��End of walking animation��
		--proxy:OnChrAnimEnd( 241 , LOCAL_PLAYER , ANIMEID_WALK , "OnEvent_241_1" , once );
		proxy:LuaCallStart( 241 , 1 );--���̖��폜���� --EN:--light fog removal sync
	proxy:NotNetMessage_end();
	
	proxy:SetEventFlag( 241 , 1 );
	
	--�v���t�@�C���Z�[�u�v�� --EN:--profile save request
	proxy:SaveRequest_Profile();
	print("OnEvent_241 end");
end


--��241_1�������A�j���I���� --EN:--��241_1��End of walking animation��
function OnEvent_241_1(proxy , param)
	print("OnEvent_241_1 begin");
	
	proxy:LuaCallStart( 241 , 1 );--���̖��폜���� --EN:--light fog removal sync
	
	print("OnEvent_241_1 end");
end


--------------------------------------------------------------------------------------
--��242���z�X�gPC�݂̂��ʂ����̖��� --EN:-- �� 242 �� A fog of light that only the host PC can pass through ��
--------------------------------------------------------------------------------------

--��242_delete_wall�����@�Ǎ폜�����p�� --EN:--��242_delete_wall��For synchronized magic wall deletion��
function OnEvent_242_delete_wall(proxy , param)
	print("OnEvent_242_delete_wall begin");
	
	proxy:SetDrawEnable( 1057 , false );--�`��OFF --EN:--Drawing OFF
	proxy:SetColiEnable( 1057 , false );--������OFF --EN:--Hit OFF
	proxy:SetObjDeactivate( 1057 , true );--�f�A�N�e�B�u --EN:--deactivate
	proxy:DeleteEvent( 242 );
	proxy:InvalidSfx( 2077 , true );--SFX OFF
	
	print("OnEvent_242_delete_wall end");
end


--��242���C�x���g�����p�� --EN:-- �� 242 �� For event activation ��
function OnEvent_242(proxy , param)
	print("OnEvent_242 begin");

	--���d�����h�~ --EN:--Multiple activation prevention
	if proxy:IsCompleteEvent( 242 ) == true then
		print("OnEvent_242 end");
		return;
	end	
	
	--�v���C���[�̓����A�j���[�V����(true:�p�[�e�B�[�v���C���[���A�j���[�V��������) --EN:--Player synchronous animation (true: party player animated)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_WALK ) == true then
		proxy:SetEventFlag( 242 , 1 );
		print("OnEvent_242 end");
		return;
	end
	
	--�_�~�|���փ��[�v --EN:--Warp to Damipoli
	proxy:WarpDmy( LOCAL_PLAYER , 1057 , 191 );
	
	proxy:NotNetMessage_begin();
		--��242_1�������A�j���I���� --EN:--��242_1��End of walking animation��
		--proxy:OnChrAnimEnd( 242 , LOCAL_PLAYER , ANIMEID_WALK , "OnEvent_242_1" , once );
		proxy:LuaCallStart( 242 , 1 );--���̖��폜���� --EN:--light fog removal sync
	proxy:NotNetMessage_end();
	
	proxy:SetEventFlag( 242 , 1 );
	
	--�v���t�@�C���Z�[�u�v�� --EN:--profile save request
	proxy:SaveRequest_Profile();
	
	print("OnEvent_242 end");
end


--��242_1�������A�j���I���� --EN:--��242_1��End of walking animation��
function OnEvent_242_1(proxy , param)
	print("OnEvent_242_1 begin");
	
	proxy:LuaCallStart( 242 , 1 );--���̖��폜���� --EN:--light fog removal sync
	
	print("OnEvent_242_1 end");
end


--[[

--------------------------------------------------------------------------------------
--��251���z�ꕺ�m�̎��S�Ď��� --EN:--��251��Death Watch for Slave Soldiers��
--------------------------------------------------------------------------------------

function OnEvent_251(proxy , param)
	print("OnEvent_251 begin");
	
	proxy:SetEventFlag( 251 , 1 );
	
	print("OnEvent_251 end");
end

--------------------------------------------------------------------------------------
--��252���z�ꕺ�m�̎��S�Ď��� --EN:--��252��Death Watch for Slave Soldiers��
--------------------------------------------------------------------------------------

function OnEvent_252(proxy , param)
	print("OnEvent_252 begin");
	
	proxy:SetEventFlag( 252 , 1 );
	
	print("OnEvent_252 end");
end

--------------------------------------------------------------------------------------
--��253���z�ꕺ�m�̎��S�Ď��� --EN:--��253��Death Watch for Slave Soldiers��
--------------------------------------------------------------------------------------

function OnEvent_253(proxy , param)
	print("OnEvent_253 begin");
	
	proxy:SetEventFlag( 253 , 1 );
	
	print("OnEvent_253 end");
end


--------------------------------------------------------------------------------------
--��254���z�ꕺ�m�̎��S�Ď��� --EN:--��254��Death Watch for Slave Soldiers��
--------------------------------------------------------------------------------------

function OnEvent_254(proxy , param)
	print("OnEvent_254 begin");
	
	proxy:SetEventFlag( 254 , 1 );
	
	print("OnEvent_254 end");
end


--------------------------------------------------------------------------------------
--��255���z�ꕺ�m�̎��S�Ď��� --EN:--��255��Death Watch for Slave Soldiers��
--------------------------------------------------------------------------------------

function OnEvent_255(proxy , param)
	print("OnEvent_255 begin");
	
	proxy:SetEventFlag( 255 , 1 );
	
	print("OnEvent_255 end");
end


--------------------------------------------------------------------------------------
--��256���z�ꕺ�m�̎��S�Ď��� --EN:--��256��Death Watch for Slave Soldiers��
--------------------------------------------------------------------------------------

function OnEvent_256(proxy , param)
	print("OnEvent_256 begin");
	
	proxy:SetEventFlag( 256 , 1 );
	
	print("OnEvent_256 end");
end
]]
--------------------------------------------------------------------------------------
--��295�������h�����q���G�ɂȂ遡 --EN:-- �� 295 �� Prince Lendl becomes an enemy ��
--------------------------------------------------------------------------------------
function OnEvent_295(proxy,param)
	--�G�΂ɏ�ԑJ�� --EN:--State transition to hostility
	SetNpcStateFlag( proxy, param, rendol_flag_list, RENDOL_STATE_HOSTILE_1 );
	proxy:EnableLogic( 624 , true );
	proxy:SetTeamType( 624, TEAM_TYPE_AngryFriend );
	proxy:EraseEventSpecialEffect_2( 624 , 5062 );
	proxy:SetEventFlag( 295 , true );
end


--------------------------------------------------------------------------------------
--��300�������h�����q�̎��S�Ď��� --EN:-- �� 300 �� Death Watch for Prince Lendl ��
--------------------------------------------------------------------------------------

function OnEvent_300(proxy , param)
	print("OnEvent_300 begin");
	
	SetNpcStateFlag( proxy, param, rendol_flag_list, RENDOL_STATE_DEAD );
	RendolCheck(proxy,param);
	--���S��RendolCheck����ꍇ�A���̏u�Ԃɏ����Ă��܂��̂ŁA --EN:--If you perform RendolCheck on death, it will disappear at that moment, so
	--���������čēx�L���ɂ��邩���߂� --EN:--Look at the distance and decide whether to re-enable
	if	proxy:IsDistance( LOCAL_PLAYER, 624, 20 ) == true then
		ValidCharactor( proxy, 624 );
	end
	
	proxy:SetEventFlag( 300 , 1 );
	
	print("OnEvent_300 end");
end


--------------------------------------------------------------------------------------
--��260�����q�̊Ď��� --EN:-- �� 260 �� Prince's Watch ��
--------------------------------------------------------------------------------------
function DoreiRegist_block1(proxy)
	local acid_list = { 251, 252, 253, 254, 255, 256};
	local evid_list = { 310, 311, 312, 313, 314, 315};
	local event_num = table.getn(acid_list);
	for index = 1, event_num, 1 do
		local acid = acid_list[index];
		local evid = evid_list[index];
		if	proxy:IsCompleteEvent( acid ) == false then
			proxy:OnCharacterDead( acid , evid , "OnEvent_260" , once );
		else
			proxy:OpeningDead( evid, false );
		end
	end
end



function OnEvent_260(proxy,param)
	print("OnEvent_260 begin");

	proxy:SetEventFlag( param:GetParam1(), true );
	
	if 	proxy:IsCompleteEvent(251) == false or
		proxy:IsCompleteEvent(252) == false or
		proxy:IsCompleteEvent(253) == false or
		proxy:IsCompleteEvent(254) == false or
		proxy:IsCompleteEvent(255) == false or
		proxy:IsCompleteEvent(256) == false then
		print("OnEvent_260 is No Success");
		print("OnEvent_260 end");
		return;
	end

	--����1�Ŋ��ӂ� ��ԑJ�ڂ����݂� --EN:--Attempt to make a state transition thanks to the royal castle 1
	if proxy:IsCompleteEvent(RENDOL_STATE_HELP_FOR_DOREI_HEISI) == true then	--��Ԃ��u�z�ꕺ�m���珕���āv �Ȃ�� --EN:--If the status is "Save from Slave Soldiers"
		SetNpcStateFlag( proxy, param, rendol_flag_list, RENDOL_STATE_THANKS_1 );
		RendolCheck(proxy,param);
	else--�����ĈȊO�Ȃ�΁i�G�΂Ǝ��S�H�j --EN:--Other than help (hostility and death?)
		print("���q�͎���ł��邩�A�{���Ă��܂�"); --EN:print("Prince is dead or angry");
	end
--[[
		proxy:EnableLogic(624,true);--���q���W�b�NON --EN:--Oji logic ON
		proxy:ChangeInitPosAng( 624 , 2150 );--���q�̋A�ҏꏊ��ύX --EN:-- Changed Prince's return location
		
		proxy:NotNetMessage_begin();
			--���A�C�e���擾�p�̊Ď���ǉ��� --EN:--�� Added monitoring for item acquisition ��
			proxy:LuaCall(10501,0,"OnEvent_10501",once);
		proxy:NotNetMessage_end();
]]
	proxy:SetEventFlag( 260 , 1 );
	
	print("OnEvent_260 end");	
end


--------------------------------------------------------------------------------------
--��10501�����q���犴�ӂ̃A�C�e���� --EN:-- �� 10501 �� Thank you items from the prince ��
--------------------------------------------------------------------------------------
function OnEvent_10501(proxy,param)
	print("OnEvent_10501 begin");	
	proxy:NotNetMessage_begin();
	
		--�A�j���Đ����g���K�[�ɂȂ邩���H���̏ꍇ�Ď���ǉ����ăR�[�� --EN:--Maybe animation playback will be the trigger? In that case add monitoring and call
		--����͂�����Lua�֐��ŌĂ� --EN:--This time, call it with a simple Lua function
		OnEvent_10501_1(proxy,param);
--[[
		--�ړ��^�C�v�������ɕύX --EN:--Movement type changed to round trip
		proxy:SetEventMovePointType( 624, POINT_MOVE_TYPE_RoundTrip );
	
		--�ړ��|�C���g��ݒ� --EN:--set movement point
		proxy:AddCustomRoutePoint(624, 2010);
		proxy:AddCustomRoutePoint(624, 2011);
		proxy:AddCustomRoutePoint(624, 2012);
		proxy:AddCustomRoutePoint(624, 2013);
		proxy:AddCustomRoutePoint(624, 2012);
		proxy:AddCustomRoutePoint(624, 2011);
		proxy:AddCustomRoutePoint(624, 2014);
		proxy:AddCustomRoutePoint(624, 2015);
]]	
	proxy:NotNetMessage_end();
	print("OnEvent_10501 end");
end

--
function OnEvent_10501_1(proxy,param)
	
	print("OnEvent_10501_1 begin");
	OnEvent_260_1(proxy,param);
	
	if param:IsNetMessage() == false then
		--�A�C�e���擾�֐�--�p�����[�^10101�Q�� --EN:--item retrieval function--see parameter 10101
		proxy:GetRateItem(10193);
	end	
	--�A�C�e�����擾�ς� --EN:--item already acquired
	proxy:SetEventFlag( 10501, 1 );
	
	--����1�ŒT���� ��ԑJ�ڂ����݂�	 --EN:-- Attempt a state transition for exploration in Royal Castle 1
	SetNpcStateFlag( proxy, param, rendol_flag_list, RENDOL_STATE_SEARCH_1 );
	RendolCheck(proxy,param);
--[[	
		proxy:EnableLogic( 624 , true );--�����h�����q�A�T����Ԃŕ����o�� --EN:--Prince Lendl starts walking in exploration mode
		proxy:ResetThink( 624 );
		
		proxy:NotNetMessage_begin();
			--�������h�����q�����̃u���b�N�ֈړ��p�̋����Ď��� --EN:--��Prince Lendl watches the distance for moving to the next block��
		--proxy:OnRegistFunc( 301 , "Check_OnEvent_301" , "OnEvent_301" , 1 , once );
		proxy:NotNetMessage_end();
]]	
	print("OnEvent_10501_1 end")
end

--[[
--------------------------------------------------------------------------------------
--��301�������h�����q�����̃u���b�N�Ɉړ��� --EN:-- �� 301 �� Prince Lendl moves to the next block ��
--------------------------------------------------------------------------------------

function Check_OnEvent_301( proxy , param )

	--�����v���C���[(�O���C)�̂ݔ��� --EN:-- Only surviving players (gray) are judged
	if proxy:IsLivePlayer() == false and
	   proxy:IsGreyGhost()  == false then
		return false;
	end
	
	--�{�X(�t�@�����N�X)�����Ă��画�肵�Ȃ� --EN:-- Boss (Phalanx) is not judged if alive
	if proxy:IsCompleteEvent( 4096 ) == false then
		return false;
	end
	
	--�������� --EN:--distance judgment
	if proxy:IsDistance( LOCAL_PLAYER , 624 , 20 ) == true then
		return false;
	else
		print("�����h�����q�A���u���b�N�ֈړ�"); --EN:print("Prince Lendl, move to next block");
		return true;
	end
	
	return false;
end
]]

function OnEvent_301( proxy , param )
	print("OnEvent_301 begin");
	
	--����2�Łu�B��Ă���̂ŏ����āv�� ��ԑJ�� --EN:-- State transition to "Help me because I'm hiding" in Royal Castle 2
	SetNpcStateFlag( proxy, param, rendol_flag_list, RENDOL_STATE_HELP_HIDING_ME );
	RendolCheck(proxy,param);
	
	proxy:SetEventFlag( 301 , 1 );--�C�x���g�I�� --EN:--End of event
	
	print("OnEvent_301 end");
end




--------------------------------------------------------------------------------------
--��280���݂邳�ꂽ����1���������遡 --EN:-- �� 280 �� Hanging corpse 1 falls ��
--------------------------------------------------------------------------------------

function OnEvent_280( proxy , param )
	print("OnEvent_280 begin");

	--�I�u�W�F�j��𓯊�������(�z�M�Ŏ󂯎�����l�́A�I�u�W�F�j����Č�����) --EN:-- Synchronize object destruction (those who receive it in the distribution reproduce the object destruction)
	if param:IsNetMessage() == true then	
		proxy:ReconstructBreak( 1172 , 1 );
	end
	
	proxy:PlayAnimation( 10240 , 1000 );--���̂̃A�j�����I�� --EN:--Finish corpse animation
	
	proxy:NotNetMessage_begin();
		--��280_1���j��A�j���Đ��I���� --EN:--��280_1��End of destruction animation��
		proxy:OnObjAnimEnd( 280 , 10240 , 1000 , "OnEvent_280_1" , once );
	proxy:NotNetMessage_end();
	
	--�I�u�W�F�j��͌l�ł��ꂼ�ꔻ�肳���̂�LuaCall�ɂ��Ȃ��Ă����v(����) --EN:-- Object destruction is determined individually, so you don't have to use LuaCall (Tabun)
	proxy:SetEventFlag( 280 , true );
	
	print("OnEvent_280 end");
end

--��280_1���j��A�j���Đ��I���� --EN:--��280_1��End of destruction animation ��
function OnEvent_280_1( proxy , param )
	print("OnEvent_280_1 begin");
	
	if proxy:IsClient() == false then
		--��V�X�e���L���� --EN:--Treasure system enabled
		proxy:EnableObjTreasure( 10240 , true );
	end
	
	print("OnEvent_280_1 end");
end


--------------------------------------------------------------------------------------
--��281���݂邳�ꂽ����2���������遡 --EN:--��281��The hanging corpse 2 falls��
--------------------------------------------------------------------------------------

function OnEvent_281( proxy , param )
	print("OnEvent_281 begin");

	--�I�u�W�F�j��𓯊�������(�z�M�Ŏ󂯎�����l�́A�I�u�W�F�j����Č�����) --EN:-- Synchronize object destruction (those who receive it in the distribution reproduce the object destruction)
	if param:IsNetMessage() == true then	
		proxy:ReconstructBreak( 1174 , 1 );
	end
	
	proxy:PlayAnimation( 10241 , 1000 );--���̂̃A�j�����I�� --EN:--Finish corpse animation
	
	proxy:NotNetMessage_begin();
		--��281_1���j��A�j���Đ��I���� --EN:--��281_1��End of destruction animation��
		proxy:OnObjAnimEnd( 281 , 10241 , 1000 , "OnEvent_281_1" , once );
	proxy:NotNetMessage_end();
	
	--�I�u�W�F�j��͌l�ł��ꂼ�ꔻ�肳���̂�LuaCall�ɂ��Ȃ��Ă����v(����) --EN:-- Object destruction is determined individually, so you don't have to use LuaCall (Tabun)
	proxy:SetEventFlag( 281 , true );
	
	print("OnEvent_281 end");
end

--��281_1���j��A�j���Đ��I���� --EN:--��281_1��End of destruction animation ��
function OnEvent_281_1( proxy , param )
	print("OnEvent_281_1 begin");

	--��V�X�e���L���� --EN:--Treasure system enabled
	proxy:EnableObjTreasure( 10241 , true );
	
	print("OnEvent_281_1 end");
end


--------------------------------------------------------------------------------------
--��285���C�e�S���S���� --EN:-- �� 285 �� cannonball rumbling ��
--------------------------------------------------------------------------------------

function OnEvent_285( proxy , param )
	print("OnEvent_285 begin");

	--�I�u�W�F�j��𓯊�������(�z�M�Ŏ󂯎�����l�́A�I�u�W�F�j����Č�����) --EN:-- Synchronize object destruction (those who receive it in the distribution reproduce the object destruction)
	if param:IsNetMessage() == true then	
		proxy:ReconstructBreak( 1190 , 1 );
	end
	
	--�C�e�S���S���A�j���Đ� --EN:--Cannonball rumbling animation playback
	proxy:PlayAnimation( 1191 , 1 );
	
	--�C�e����_���[�W�� --EN:--Damage spheres from shells
	local paramid = 10000; --�������_���[�W --EN:--Non-attribute damage
	local rad    = 0.5;--���a(���ƂŁA�����Ȓl�ɂȂ�͂�������͓K��) --EN:--radius (should be a formal value later... suitable for now)
	--local time   = 20; --�ЂƂ܂��A�j���Đ��I���Ń_���[�W�������̂ŁA�A�j����蒷�����Ԃ��w�肵�Ă��� --EN:--For the time being, the damage ball will be erased when the animation ends, so specify a longer time than the animation.
	local time   = 120; --�ЂƂ܂��A�j���Đ��I���Ń_���[�W�������̂ŁA�A�j����蒷�����Ԃ��w�肵�Ă��� --EN:--For the time being, the damage ball will be erased when the animation ends, so specify a longer time than the animation.
	local requestTime = 1.0;--�_���[�W���č쐬�Ԋu --EN:--damage sphere regeneration interval
	
	--��285_hit���C�e1�����������Ƃ��� --EN:--��285_hit��When shell 1 hits��
	proxy:OnObjectDamageHit_NoCallPlus( 285, 1191, 1, paramid, EV_HIT_CHR ,  rad, time, requestTime, everytime );
	--��285_hit���C�e2�����������Ƃ��� --EN:--��285_hit��When shell 2 hits��
	proxy:OnObjectDamageHit_NoCallPlus( 285, 1191, 2, paramid, EV_HIT_CHR ,  rad, time, requestTime,  everytime );
	--��285_hit���C�e3�����������Ƃ��� --EN:--��285_hit��When shell 3 hits��
	proxy:OnObjectDamageHit_NoCallPlus( 285, 1191, 3, paramid, EV_HIT_CHR ,  rad, time, requestTime,  everytime );	
	--��285_hit���C�e4�����������Ƃ��� --EN:--��285_hit��When shell 4 hits��
	proxy:OnObjectDamageHit_NoCallPlus( 285, 1191, 4, paramid, EV_HIT_CHR ,  rad, time, requestTime,  everytime );
	--��285_hit���C�e5�����������Ƃ��� --EN:--��285_hit��When shell 5 hits��
	proxy:OnObjectDamageHit_NoCallPlus( 285, 1191, 5, paramid, EV_HIT_CHR ,  rad, time, requestTime,  everytime );
	proxy:SetObjEventCollisionFill( 1191, true );

	--�A�j���Đ����I�������A�_���[�W�������Ȃǂ���? --EN:--When the animation finishes playing, do you want to erase the damage ball?
	proxy:NotNetMessage_begin();
		--��285_anime_end���C�e�S���S���A�j���I���� --EN:--��285_anime_end��Cannonball rumbling animation ends��
		proxy:OnObjAnimEnd( 285 , 1191 , 1 , "OnEvent_285_anime_end" , once );
	proxy:NotNetMessage_end();
	
	proxy:SetEventFlag( 285 , true );

	print("OnEvent_285 end");
end
	

--��285_anime_end���C�e�S���S���A�j���I���� --EN:--��285_anime_end��Cannonball rumbling animation ends��
function OnEvent_285_anime_end( proxy , param )
	print("OnEvent_285_anime_end begin");

	proxy:DeleteEvent( 285 );--�_���[�W���ȂǍ폜 --EN:-- Deleted damage balls etc.

	print("OnEvent_285_anime_end end");
end
	

--------------------------------------------------------------------------------------
--��310�`319���\�E�������X�^�[�o���� --EN:-- �� 310-319 �� Soul Monster Appears ��
--------------------------------------------------------------------------------------
--�\�E�������X�^�[�C�x���g�o�^ --EN:--Soul Monster Event Registration
function RegistSoulMonster_block1(proxy)
	local acid_list = {   310,   311,   312,   313,   314,   315,   316,   317,   318,   319};
	local evid_list = {   320,   321,   322,   323,   324,   325,   326,   327,   328,   329};
	local qwc_list  = { 20100, 20100,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1};
	local event_num = table.getn(acid_list);
	for index = 1, event_num, 1 do
		acid = acid_list[index];
		evid = evid_list[index];
		qwc_id = qwc_list[index];
		SingleReset( proxy,acid );
		if	(qwc_id ~= -1 and proxy:IsSuccessQWC(qwc_id) == true) or (qwc_id == -1) then
			if	proxy:IsCompleteEvent( acid ) == false then
				proxy:OnPlayerDistanceInTarget( acid, LOCAL_PLAYER, evid, "OnEvent_"..acid, 10.0, once );
				InvalidCharactor( proxy, evid );
			else
				proxy:EnableLogic( evid, true );
			end
		else
			InvalidCharactor( proxy, evid );
		end
	end
	
	SingleReset( proxy , 310);
	if proxy:IsCompleteEvent( 310 ) == false then
		if proxy:IsSuccessQWC(20100) == true then--QWC������������ --EN:--If QWC is established
			proxy:OnPlayerDistanceInTarget( 310 , LOCAL_PLAYER , 320 , "OnEvent_310" , 10.0 , once );
		end
	else 
		proxy:EnableLogic( 320 , true );--���W�b�NON --EN:--Logic ON
	end
	
end


function OnEvent_310(proxy,param ) SoulMonsterFunc_block1(proxy,param,param:GetParam1(),param:GetParam2()); end
function OnEvent_311(proxy,param ) SoulMonsterFunc_block1(proxy,param,param:GetParam1(),param:GetParam2()); end
function OnEvent_312(proxy,param ) SoulMonsterFunc_block1(proxy,param,param:GetParam1(),param:GetParam2()); end
function OnEvent_313(proxy,param ) SoulMonsterFunc_block1(proxy,param,param:GetParam1(),param:GetParam2()); end
function OnEvent_314(proxy,param ) SoulMonsterFunc_block1(proxy,param,param:GetParam1(),param:GetParam2()); end
function OnEvent_315(proxy,param ) SoulMonsterFunc_block1(proxy,param,param:GetParam1(),param:GetParam2()); end
function OnEvent_316(proxy,param ) SoulMonsterFunc_block1(proxy,param,param:GetParam1(),param:GetParam2()); end
function OnEvent_317(proxy,param ) SoulMonsterFunc_block1(proxy,param,param:GetParam1(),param:GetParam2()); end
function OnEvent_318(proxy,param ) SoulMonsterFunc_block1(proxy,param,param:GetParam1(),param:GetParam2()); end
function OnEvent_319(proxy,param ) SoulMonsterFunc_block1(proxy,param,param:GetParam1(),param:GetParam2()); end

function SoulMonsterFunc_block1(proxy,param,acid,evid)
	print("OnEvent_"..acid.." begin")
	if	proxy:IsAlive(evid) == false then
		print("OnEvent_"..acid.." return end")
	end
	
	ValidCharactor( proxy , evid );--�L�����N�^�L���� --EN:--Character enable
	proxy:PlayAnimation( evid , 6100 );--�\�E���̏o���A�j���Đ�(���͑ҋ@�A�j���ɂȂ��Ă���) --EN:--Soul appearance animation playback (currently standby animation)
	proxy:SetEventFlag( acid , true );
	
	print("OnEvent_"..acid.." end")
end







--------------------------------------------------------------------------------------
--�n�V�S1�~�聡320 --EN:--Ladder 1 descend �� 320
--------------------------------------------------------------------------------------
--��320���n�V�S1�~��X�^�[�g�� --EN:-- �� 320 �� Ladder 1 down start ��
function OnEvent_320(proxy, param)
	print("OnEvent_320 begin");
	
	if param:IsNetMessage() == true then
		print("IsNetMessage true");
		print("OnEvent_320 end");
		return;
	end

	--�͂����~��ɕK�v�ȑO����-- --EN:--Pretreatment required for descending the ladder--
	proxy:BeginAction(LOCAL_PLAYER,2,2,2);				--�z�o�[�ړ����[�h�Ɉڍs --EN:--Transition to hover movement mode
	--proxy:HoverMoveVal(LOCAL_PLAYER,2002,LadderTime_A);--�ړ��ʒu(2002)��0.5�b�Ńz�o�[�ړ� --EN:--Hover move to moving position (2002) in 0.5 seconds
	proxy:HoverMoveValDmy(LOCAL_PLAYER,1060,192,LadderTime_A);--�ړ��ʒu(2003)��0.5�b�Ńz�o�[�ړ� --EN:--Hover in 0.5 seconds to move position (2003)
	proxy:SetEventCommand(LOCAL_PLAYER,1);				--�C�x���g�R�}���hID(1)"�n�V�S�ォ���"�ނ𑗂� --EN:-- Send event command ID (1) "Grab from the top of the ladder"
	proxy:SetKeepCommandIndex(LOCAL_PLAYER, 0, 1, 3.0 );--nCommandID �� �����̂Ƃ�0 �΂߂̂Ƃ�4 --EN:--nCommandID 0 for vertical 4 for diagonal
	proxy:DisableMove(LOCAL_PLAYER,1);					--�L�����N�^���ړ��A����s�\�� --EN:--Move the character, make it impossible to turn
	
	proxy:NotNetMessage_begin();
		--0.5�b(�z�o�[�ړ��I��)��ɂ͂����~��X�^�[�g�C�x���g�𔭍s --EN:-- Issue a ladder descend start event after 0.5 seconds (end of hover movement)
		proxy:OnKeyTime2(320,"OnEvent_320_1",LadderTime_A,0,0,once);
		--�͂����~���p�̊֐���3�b�Ԕ��s(�J�����̎��荞�݂Ȃǂ̏���) --EN:--Issue a function dedicated to descending the ladder for 3 seconds (processing such as surrounding the camera)
		proxy:OnKeyTime2(320,"LadderDown",3,1,1,once);
	proxy:NotNetMessage_end();

	print("OnEvent_320 end");
end

--��320_1���n�V�SA�~��X�^�[�g:�z�o�[�ړ��I���� --EN:--�� 320_1 �� Start descending from ladder A: End of hover movement ��
function OnEvent_320_1(proxy, param)
	print("OnEvent_320_1 begin");
	
	if proxy:GetEventMode(LOCAL_PLAYER) == 0 then
		print("Local Player GetEventMode 0");
		print("OnEvent_320_1 end");
		return;
	end

	--�n�V�S�A�N�V�������[�h�Ɉڍs-- --EN:--Transition to ladder action mode--
	--nMax  : �͂����̒i�� - �␳�l(�␳�l�͂����悻3) --EN:--nMax : number of ladder steps - correction value (correction value is approximately 3)
	--nStart: �~���Ƃ���(nMax + 1) ����Ƃ���(-1) --EN:--nStart: When going down��(nMax + 1) When going up��(-1)
	proxy:BeginAction(LOCAL_PLAYER,1,50,49);
	
	--�L�����N�^���ړ��A����\��-- --EN:--Character can be moved and turned--
	proxy:DisableMove(LOCAL_PLAYER,0);
	
	print("OnEvent_320_1 end");
end


--------------------------------------------------------------------------------------
--�n�V�S1���聡321 --EN:--Ladder 1 up 321
--------------------------------------------------------------------------------------
--��321���n�V�S1����X�^�[�g�� --EN:-- �� 321 �� Ladder 1 climbing start ��
function OnEvent_321(proxy, param)
	print("OnEvent_321 begin");
	
	if param:IsNetMessage() == true then
		print("IsNetMessage true");
		print("OnEvent_321 end");
		return;
	end
	
	--�͂�������ɕK�v�ȑO����-- --EN:--Pretreatment required for climbing a ladder--
	proxy:BeginAction(LOCAL_PLAYER,2,-1,1);			--�z�o�[�ړ����[�h�Ɉڍs --EN:--Transition to hover movement mode
	--proxy:HoverMoveVal(LOCAL_PLAYER,2003,LadderTime_A);--�ړ��ʒu(2003)��0.5�b�Ńz�o�[�ړ� --EN:--Hover in 0.5 seconds to move position (2003)
	proxy:HoverMoveValDmy(LOCAL_PLAYER,1060,191,LadderTime_A);--�ړ��ʒu(2003)��0.5�b�Ńz�o�[�ړ� --EN:--Hover in 0.5 seconds to move position (2003)
	proxy:SetEventCommand(LOCAL_PLAYER,0);				--�C�x���g�R�}���hID(0)"�n�V�S�������"�ނ𑗂� --EN:-- Send event command ID (0) "grab from under the ladder"
	proxy:SetKeepCommandIndex(LOCAL_PLAYER, 0, 1, 3.0 );--nCommandID �� �����̂Ƃ�0 �΂߂̂Ƃ�4 --EN:--nCommandID 0 for vertical 4 for diagonal
	proxy:DisableMove(LOCAL_PLAYER,1);					--�L�����N�^���ړ��A����s�\�� --EN:--Move the character, make it impossible to turn
	
	proxy:NotNetMessage_begin();
		--0.5�b(�z�o�[�ړ��I��)��ɂ͂�������X�^�[�g�C�x���g�𔭍s --EN:-- Issue a ladder climb start event after 0.5 seconds (end of hover movement)
		proxy:OnKeyTime2(321,"OnEvent_321_1",LadderTime_A,0,0,once);
		--�͂�������p�̊֐���1�b�Ԕ��s(�C�x���g���j���[�̒��f����?) --EN:--Issuing a function for climbing a ladder for 1 second (interruption processing of the event menu?)
		proxy:OnKeyTime2(321,"EventMenuBrake",1,1,1,once);
	proxy:NotNetMessage_end();
	
	print("OnEvent_321 end");
end

--��321_1���n�V�S1����X�^�[�g:�z�o�[�ړ��I���� --EN:--�� 321_1 �� Ladder 1 climbing start: Hover movement finished ��
function OnEvent_321_1(proxy, param)
	print("OnEvent_321_1 begin");
	
	if proxy:GetEventMode(LOCAL_PLAYER) == 0 then
		print("Local Player GetEventMode 0");
		print("OnEvent_321_1 end");
		return;
	end

	--�n�V�S�A�N�V�������[�h�Ɉڍs-- --EN:--Transition to ladder action mode--
	--nMax  : �͂����̒i�� - �␳�l(�␳�l�͂����悻3) --EN:--nMax : number of ladder steps - correction value (correction value is approximately 3)
	--nStart: �~���Ƃ���(nMax + 1) ����Ƃ���(-1) --EN:--nStart: When going down��(nMax + 1) When going up��(-1)
	proxy:BeginAction(LOCAL_PLAYER,1,-1,49);
	
	--�L�����N�^���ړ��A����\��-- --EN:--Character can be moved and turned--
	proxy:DisableMove(LOCAL_PLAYER,0);
	
	print("OnEvent_321_1 end");
end


--------------------------------------------------------------------------------------
--��2���򗳂����ł���|�������Đ����遡 --EN:--�� 2 �� Replay a poly-drama in which flying dragons fly ��
--------------------------------------------------------------------------------------

function OnEvent_2(proxy , param)
	print("OnEvent_2 begin");

	--���򗳂����ł���|�����Đ� --EN:--�� Play a poly-drama in which flying dragons fly
	proxy:RequestRemo(20000,REMO_FLAG,2,1);
	proxy:SetEventFlag( 2, true );

	print("OnEvent_2 end");
end


--���|�����Đ��J�n(�t�F�[�h�I��) --EN:--�� Start of polyplay playback (end of fade)
function OnEvent_2_RemoStart(proxy,param)
	print("OnEvent_2_RemoStart begin");
	
	--SE���c��炵���̂�-1�Đ� --EN:--Since SE seems to remain, -1 playback
	--proxy:ForcePlayAnimation( 1110 ,-1);
	--proxy:ForcePlayAnimation( 1111 ,-1);
	--proxy:ForcePlayAnimation( 1112 ,-1);
	--�J���X���c���Ă��܂��悤�Ȃ̂ŏ����B --EN:--It seems that crows will remain, so delete them.
	--proxy:SetDrawEnable( 1110 , false );
	--proxy:SetDrawEnable( 1111 , false );
	--proxy:SetDrawEnable( 1112 , false );
	
	print("OnEvent_2_RemoStart end");
end


--���|�����Đ��I��(�t�F�[�h�I��) --EN:-- End of polyplay playback (end of fade)
function OnEvent_2_RemoFinish(proxy , param)
	print("OnEvent_2_RemoFinish begin");
	print("OnEvent_2_RemoFinish end");
end

--------------------------------------------------------------------------------------
--��258���z�ꕺ�m�������h�����q��_���̂���߂�Ď��ǉ�(���W�b�N�؂�ւ�)�� --EN:--�� 258 �� Added monitoring to stop slave soldiers from targeting Prince Lendl (switch logic) ��
--------------------------------------------------------------------------------------

--���̈�������Ƃ�(�z�ꕺ�m �ʏ탍�W�b�N�ɂ���) --EN:-- �� When entering the area (slave soldiers normal logic)
function OnEvent_258(proxy,param)
	print("OnEvent_258 begin");

	--�����h�����q�̏�Ԏ擾 --EN:-- Get Prince Lendl's status
	local now_state = GetRendolState( proxy, param );
	
	--��Ԃ��u�z�ꕺ�m���珕���āv����Ȃ��@ --EN:--The status is not ``Save from slave soldiers''
	--��Ԃ��u����P�G�΁v����Ȃ� --EN:--The status is not "Castle 1 hostile"
	--��Ԃ��u����P���S�v����Ȃ��Ƃ��� �������Ȃ�(�Ď��폜) --EN:--Do not process if the state is not "Old castle 1 dead" (delete monitoring)
	if 	now_state ~= RENDOL_STATE_HELP_FOR_DOREI_HEISI and
		now_state ~= RENDOL_STATE_HOSTILE_1 and
		now_state ~= RENDOL_STATE_DEAD then
		proxy:DeleteEvent( 258 );--���W�b�N�؂�ւ��Ď��폜 --EN:--Delete logic switching monitor
		proxy:DeleteEvent( 245 );--�z�ꕺ�m�̃_���[�W�Ď��폜 --EN:-- Removed slave soldier damage monitoring
		print("OnEvent_258 end");
		return;
	end
		
	--�z�ꕺ�m�ʏ탍�W�b�N�ɐ؂�ւ�(�����h�����q���ɂݍ����̂���߂�) --EN:--Slave soldier Switch to normal logic (stop staring at Prince Lendl)
	local dorei_heisi_id_list = {310,311,312,313,314,315};
	local dorei_heisi_num = table.getn( dorei_heisi_id_list );
	
	for i=1 , dorei_heisi_num , 1 do
		proxy:ForceUpdateNextFrame( dorei_heisi_id_list[i] );--���̃t���[���͋����X�V --EN:--Force update next frame
		proxy:SendEventRequest    ( dorei_heisi_id_list[i] , 0 , AI_EVENT_None);
		--proxy:SetEventTarget   ( dorei_heisi_id_list[i] , -1);--�����^�[�Q�b�g�N���A --EN:--force target clear
	end
	
	proxy:DeleteEvent( 245 );--�z�ꕺ�m�̃_���[�W�Ď�����U�폜 --EN:-- Removed damage monitoring for slave soldiers
	
	proxy:SetEventFlag( 258 , 1 );--���q��_���̂���߂� --EN:-- Stopped aiming at the prince

	print("OnEvent_258 end");
end

--���̈���o���Ƃ�(�z�ꕺ�m �Њd���W�b�N�ɂ���) --EN:-- �� When leaving the area (slave soldier intimidation logic)
function OnEvent_258_out(proxy,param)
	print("OnEvent_258_out begin");

	--�̈�ɓ������t���O��OFF�������珈�����Ȃ�(���炭�Ȃ��Ǝv���邯��ǥ��) --EN:--If the flag that entered the area is OFF, it will not be processed (probably not, but...)
	if proxy:IsCompleteEvent( 258 ) == false then
		print("OnEvent_258_out end");
		return;
	end
	
	--�����h�����q�̏�Ԏ擾 --EN:-- Get Prince Lendl's status
	local now_state = GetRendolState( proxy, param );
	
	--��Ԃ��u�z�ꕺ�m���珕���āv����Ȃ��Ƃ��� �������Ȃ�(�Ď��폜) --EN:--Do not process if the status is not "Save from slave soldiers" (monitor deleted)
	if now_state ~= RENDOL_STATE_HELP_FOR_DOREI_HEISI then
		proxy:DeleteEvent( 258 );--���W�b�N�؂�ւ��Ď��폜 --EN:--Delete logic switching monitor
		proxy:DeleteEvent( 245 );--�z�ꕺ�m�̃_���[�W�Ď��폜 --EN:-- Removed slave soldier damage monitoring
		print("OnEvent_258_out end");
		return;
	end
	
	--�z�ꕺ�m�Њd���W�b�N�ɐ؂�ւ�(�����h�����q���ɂݍ���) --EN:--Switch to slave soldier intimidation logic (glaring at Prince Lendl)
	local dorei_heisi_id_list = {310,311,312,313,314,315};
	local dorei_heisi_num = table.getn( dorei_heisi_id_list );
	local rendol_id = 624;
		
	for i=1, dorei_heisi_num, 1 do		
		proxy:SendEventRequest( dorei_heisi_id_list[i] , 0 , AI_EVENT_DOREI_IKAKU);
		proxy:SetEventTarget( dorei_heisi_id_list[i] , rendol_id);--�����^�[�Q�b�g�ݒ� --EN:--force target setting
		
		--���z�ꕺ�m�����̃_���[�W�Ď��� --EN:--��Damage monitoring of slave soldiers��
		proxy:OnSimpleDamage( 245 , dorei_heisi_id_list[i], LOCAL_PLAYER, "OnEvent_258", once );--�_���[�W�Ď� --EN:--Damage monitoring
	end
	
	proxy:SetEventFlag( 258 , 0 );--���q��_���̂��ĊJ --EN:-- Resume aiming for the prince
	
	print("OnEvent_258_out end");
end

--��259�������h�����q���̈�N���Ŏd���Ȃ��키�� --EN:-- �� 259 �� Prince Lendl fights reluctantly to invade the territory ��
function OnEvent_259(proxy,param)
	print("OnEvent_259 begin");
	proxy:EnableLogic( 624, true );
	print("OnEvent_259 end");
end


--------------------------------------------------------------------------------------
--��4103���\�E�����聡 --EN:-- �� 4103 �� Get Soul ��
--------------------------------------------------------------------------------------

function OnEvent_4103(proxy, param)
	print("OnEvent_4103 begin");
	
	--�v���C���[�̓����A�j���[�V����(true:�p�[�e�B�[�v���C���[���A�j���[�V��������) --EN:--Player synchronous animation (true: party player animated)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_PICK ) == true then--�V�����A�j��  --EN:-- new anime
		print("OnEvent_4103 end");
		return true;
	end
	
	proxy:NotNetMessage_begin();
		--0.0�b��ɃA�C�e���擾�C�x���g�𔭍s --EN:-- Issue an item acquisition event after 0.0 seconds
		proxy:OnKeyTime2( 4103, "OnEvent_4103_1", 0.0, 0, 0, once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_4103 end");
end


--��4103_1���A�C�e���擾�� --EN:-- �� 4103_1 �� item acquisition ��
function OnEvent_4103_1(proxy, param)
	print("OnEvent_4103_1 begin");

	--�A�C�e���擾�֐�--�p�����[�^10101�Q�� --EN:--item retrieval function--see parameter 10101
	proxy:GetRateItem(10110);
	proxy:GetRateItem(10170);
	proxy:GetRateItem(10171);
	proxy:GetRateItem(10172);
	proxy:GetRateItem(10173);
	
	--�A�C�e�����擾�ς� --EN:--item already acquired
	proxy:SetEventFlag( 4103, 1 );
	
	--�󔠃V�F�[�_�[�͏����܂��� --EN:--Treasure chest shader does not disappear
	--proxy:TreasureDispModeChange( 1982 , false );

	--SFX�������� --EN:--SFX disappear
	proxy:InvalidSfx( 1080 , true );--���̗��q --EN:--Particles of light
	--proxy:InvalidSfx( 1081 , true );--�v�΂̃I�[�� --EN:--Keystone Aura
	
	--���v�΂Ń��[�v�p�̊Ď���ǉ��� --EN:--�� Added surveillance for warp with keystone ��
	proxy:OnDistanceActionAttribute( 4105 , LOCAL_PLAYER , 1982 , "OnEvent_4105" , WarpGimmickDist_A , HELPID_GO_TO_SEKITYUU , 0 , 180 , ATTR_NOSESSION , everytime );

	print("OnEvent_4103_1 end");
end

--------------------------------------------------------------------------------------
--��30���ŏ��̗v�΂̌��������遡 --EN:--��30��The light on the first keystone disappears��
--------------------------------------------------------------------------------------

function OnEvent_30(proxy, param)
	print("OnEvent_30 begin");
	
	proxy:TreasureDispModeChange2( 1983 , false ,KANAME_SFX);
	
	print("OnEvent_30 end");
end


--------------------------------------------------------------------------------------
--��31���ŏ��̗v�΂̌����������遡 --EN:-- �� 31 �� The light of the first keystone is restored ��
--------------------------------------------------------------------------------------

function OnEvent_31(proxy, param)
	print("OnEvent_31 begin");
	
	proxy:TreasureDispModeChange2( 1983 , true ,KANAME_SFX);
	
	print("OnEvent_31 end");
end

--�y�h�����z�퓬�J�n --EN:--[Doran] Combat begins
function OnEvent_329(proxy,param)
	proxy:EnableLogic( 697 , true );
	proxy:SetEventFlag( 329 , true );
end

--�y�h�����z�����Ă��ꂽ --EN:-- [Doran] Forgive me
function OnEvent_330(proxy,param)
	print("OnEvent_330 begin");
	if proxy:IsAlive( 697 ) == true then
		proxy:SetTeamType( 697, TEAM_TYPE_Friend );
		SetNpcStateFlag( proxy , param , doran_flag_list , DORAN_STATE_ALLOWED );
		proxy:ResetThink(697);
	
		proxy:ClearTarget(nWho);
	end
	
	--�z�X�g�A�����A�O���C�̂ݒ��ׂ邱�Ƃ��ł��� --EN:--Only hosts, survivors, and grays can be examined
	local possible_chr_type = ATTR_HOST + ATTR_LIVE + ATTR_GREY;
	--HELPID���f�����u�����h��p�ɂȂ��� --EN:--HELPID is now exclusive to the Demon brand
	proxy:OnDistanceActionAttribute( 5 , LOCAL_PLAYER , 1192 , "OnEvent_5" , ItemBoxDist_A , 10010130 , 0 , ItemBoxAngle_A ,possible_chr_type, everytime ); 
	proxy:LuaCall( 5,1,"OnEvent_5_2",once);	
	proxy:LuaCall( 5,2,"OnEvent_5_3",once);
	proxy:TreasureDispModeChange2( 1192, true ,KEN_SFX);
	--proxy:SetRarity( 1192, 10104 );
				
	proxy:SetEventFlag( 330, true );
	print("OnEvent_330 end");
end

--�y�h�����z�����Ȃ� --EN:--[Doran] I won't forgive you
function OnEvent_331(proxy,param)
	if proxy:IsAlive( 697 ) == true then
		print("OnEvent_331 begin");
		proxy:SetTeamTypeDefault( 697 );
		SetNpcStateFlag( proxy , param , doran_flag_list , DORAN_STATE_NOT_ALLOWED );
		print("�h�����������߂�"); --EN:print("Don't take it easy");
		proxy:SendEventRequest( 697 ,0, -1);
		proxy:EraseEventSpecialEffect_2( 697 , 5042 );
		proxy:SetEventFlag( 331, true );
		print("OnEvent_331 end");
	end
end

--�y�h�����z���S --EN:--[Doran] Death
function OnEvent_332(proxy,param)
	print("OnEvent_332 begin");
	SetNpcStateFlag( proxy , param , doran_flag_list , DORAN_STATE_DEAD );
	proxy:SetEventFlag( 332, true );

	--���g���t�B�[�擾���聥 --EN:--��Trophy Acquisition Judgment��
	Lua_RequestUnlockTrophy(proxy, 11);

	print("OnEvent_332 end");
end

--�y�h�����z���̂𒲂ׂ� --EN:-- [Doran] Examine the corpse
function OnEvent_15610(proxy,param)
	print("OnEvent_15610 begin");
	proxy:SetEventFlag( 15610 , true );
	print("OnEvent_15610 end");
end



function CheckPointIn_AttrCheck(proxy,param)
	print("CheckPointIn_AttrCheck begin");
	--�z�X�g�̂݃`�F�b�N�|�C���g������s�� --EN:--Perform checkpoint judgment only for the host
	if	proxy:IsClient() == false then
		--��CheckPointIn --EN:--��CheckPointIn
		--�p�����[�^�Ƃ��ė̈�̃C�x���gID��n���Ă��� --EN:-- Pass the area event ID as a parameter
		proxy:LuaCallStartPlus( SYSTEM_CHECK_POINT, 2, param:GetParam2() );
	end
	print("CheckPointIn_AttrCheck end");
end

--�`�F�b�N�|�C���g�ʉ� --EN:--Checkpoint pass
function CheckPointIn(proxy,param)
	print("CheckPointIn begin");
	RendolCheck(proxy,param);
	BiyoCheck(proxy,param);
	--HiryuOsaCheck(proxy,param);
	OnEvent_781(proxy,param);--�z�ꕺ�m�V���b�v --EN:--Slave Soldier Shop
	print("CheckPointIn end");
end

function InitializeNpc(proxy,param)
	RendolCheck2(proxy,param,false);
	BiyoCheck2(proxy,param,false);
	--HiryuOsaCheck(proxy,param);
	OnEvent_781(proxy,param);--�z�ꕺ�m�V���b�v --EN:--Slave Soldier Shop
end

--[[�폜�Ƃ̎��Ȃ̂ŁA�R�����g�A�E�g --EN:--[[Deleting, so comment out
--------------------------------------------------------------------------------------
--��10700���݂邳��Ă���l���b�������Ă��遡 --EN:--��10700��The person who is hanging speaks to you��
--------------------------------------------------------------------------------------
function OnEvent_10700(proxy,param)
--	print("OnEvent_10700 begin");

	--���̂𗎂Ƃ��C�x���g���I����Ă��� --EN:--The corpse drop event is over
	if proxy:IsCompleteEvent( 281 ) == true then
		
		if proxy:IsCompleteEvent( 10701 ) == false then
			--�f����(����) --EN:-- Deathrattle (Gratitude)
			proxy:CloseTalk(10700);
			proxy:TalkNextPage( 10701 );
			proxy:SetEventFlag( 10701 , 1 );
		else
			proxy:DeleteEvent( 10700 );
			return;
		end
		
	--�܂��݂邳��Ă��� --EN:--still hanging
	else
		if proxy:IsCompleteEvent( 10700 ) == false then
			--�b�������Ă��� --EN:--talks to me
			proxy:TalkNextPage( 10700 );	
			proxy:SetEventFlag( 10700 , 1 );
		end
	end

--	print("OnEvent_10700 end");
end]]


--[[-----------------------------------------------------------------------------------------------------------------------------------------
	�����h�����q�֘A�@�������� --EN:Related to Prince Lendl From here
-----------------------------------------------------------------------------------------------------------------------------------------]]
function RendolCheck(proxy,param)
	RendolCheck2(proxy,param,true);
end

function RendolCheck2(proxy,param,flag)
	print("RendolCheck begin");
	local rendol_id_1 = 624;--����P�̃����h�����q --EN:--Prince Lendl of Royal Castle 1
	local rendol_id_2 = 620;--����Q�̃����h�����q --EN:--Prince Lendl of Royal Castle 2
	local rendol_id_3 = 621;--����R�̃����h�����q --EN:--Prince Lendl of Royal Castle 3
	local rendol_id_4 = 626;--����S�̃����h�����q --EN:--Prince Lendl of Royal Castle 4
	
	local rendol_block1_acid_list = {   245,   258,   259,   301,   260,   300,   295, 10501};
	local rendol_block2_acid_list = { 10800,   723,   724,   643};
	local rendol_block3_acid_list = {  1310,  1311,  1312,  1313,  1314,  1315,  1316,  1316,  1317,  1318,  1349, 1350,  1351,  1352,  1360,  1361,  1362, 11501};
	local rendol_block4_acid_list = { 11790,  1700,  1702};
	
	--��U�S�������Ă��� --EN:-- Erase all of them for now
	InvalidCharactor(proxy,rendol_id_1);
	InvalidCharactor(proxy,rendol_id_2);
	InvalidCharactor(proxy,rendol_id_3);
	InvalidCharactor(proxy,rendol_id_4);
	--InvalidCharactor(proxy, 102);
	--InvalidCharactor(proxy, 103);
	

	
	--�Ď�����U�S�폜 --EN:--Delete all monitors once
	DeleteConditionList(proxy,rendol_block1_acid_list);
	DeleteConditionList(proxy,rendol_block2_acid_list);
	DeleteConditionList(proxy,rendol_block3_acid_list);
	DeleteConditionList(proxy,rendol_block4_acid_list);
	
	SetFirstNpcStateFlag( proxy, param, rendol_flag_list, RENDOL_STATE_HELP_FOR_DOREI_HEISI );
	
	----------------------------------------------------------------------------------------------------------------
	--���q���z�ꕺ�m���珕���ď��--16000 --EN:--Prince Saved from Slave Soldiers State--16000
	if	proxy:IsCompleteEvent(RENDOL_STATE_HELP_FOR_DOREI_HEISI) == true then
		print("rendol state RENDOL_STATE_HELP_FOR_DOREI_HEISI");
		SetRendolState_01(proxy, param, rendol_id_1 );
		RendolRegistCondition_block1(proxy,param,rendol_id_1);
		
	----------------------------------------------------------------------------------------------------------------
	--���q�����Ӂi����P�j���--16001 --EN:--Prince thanks (Castle 1) state--16001
	elseif	proxy:IsCompleteEvent(RENDOL_STATE_THANKS_1) == true then
		print("rendol state RENDOL_STATE_THANKS_1");
		if flag == true then
			SetRendolState_02(proxy, param, rendol_id_1 );
		else
			SetRendolState_02Init(proxy, param, rendol_id_1 );
		end
		RendolRegistCondition_block1(proxy,param,rendol_id_1);
		
	----------------------------------------------------------------------------------------------------------------
	--���q���T���i����P�j���--16002 --EN:--Prince exploring (Castle 1) state--16002
	elseif	proxy:IsCompleteEvent(RENDOL_STATE_SEARCH_1) == true then
		print("rendol state RENDOL_STATE_SEARCH_1");
		if flag == true then
			SetRendolState_03(proxy, param, rendol_id_1 );
		else
			SetRendolState_03Init(proxy, param, rendol_id_1 );
		end
		RendolRegistCondition_block1(proxy,param,rendol_id_1);
		
	----------------------------------------------------------------------------------------------------------------
	--���q���G�΁i����P�j���--16003 --EN:--Prince hostile (Royal Castle 1) state--16003
	elseif	proxy:IsCompleteEvent(RENDOL_STATE_HOSTILE_1) == true then
		print("rendol state RENDOL_STATE_HOSTILE_1");
		if flag == true then
			SetRendolState_04(proxy, param, rendol_id_1 );
		else
			SetRendolState_04Init(proxy, param, rendol_id_1 );
		end
		RendolRegistCondition_block1(proxy,param,rendol_id_1);
		
	----------------------------------------------------------------------------------------------------------------
	--���q������ł�����--16004 --EN:--Prince dead--16004
	elseif	proxy:IsCompleteEvent(RENDOL_STATE_DEAD) == true then
		print("rendol state RENDOL_STATE_DEAD");
		--�����ł͒ǉ����ݒ�����Ȃ� --EN:--Do not add or set here
		
	----------------------------------------------------------------------------------------------------------------
	--���q���B��Ă���̂ŏ����ď��--16005 --EN:--The prince is hiding, so please help me--16005
	elseif	proxy:IsCompleteEvent(RENDOL_STATE_HELP_HIDING_ME) == true then
		print("rendol state RENDOL_STATE_HELP_HIDING_ME");
		SetRendolState_05(proxy, param, rendol_id_2 );
		RendolRegistCondition_block2(proxy,param,rendol_id_2);
		
	----------------------------------------------------------------------------------------------------------------
	--���q�����Ӂi����Q�j���--16006 --EN:--Prince thanks (Castle 2) state--16006
	elseif	proxy:IsCompleteEvent(RENDOL_STATE_THANKS_2) == true then
		print("rendol state RENDOL_STATE_THANKS_2");
		SetRendolState_06(proxy, param, rendol_id_2 );
		RendolRegistCondition_block2(proxy,param,rendol_id_2);
		
	----------------------------------------------------------------------------------------------------------------
	--���q���T���i����Q�j���--16007 --EN:--Prince Exploring (Castle 2) State--16007
	elseif	proxy:IsCompleteEvent(RENDOL_STATE_SEARCH_2) == true then
		print("rendol state RENDOL_STATE_SEARCH_2");
		SetRendolState_07(proxy, param, rendol_id_2 );
		RendolRegistCondition_block2(proxy,param,rendol_id_2);
		
	----------------------------------------------------------------------------------------------------------------
	--���q���G�΁i����Q�j���--16008 --EN:--Prince hostile (Royal Castle 2) state--16008
	elseif	proxy:IsCompleteEvent(RENDOL_STATE_HOSTILE_2) == true then
		print("rendol state RENDOL_STATE_HOSTILE_2");
		SetRendolState_08(proxy, param, rendol_id_2 );
		RendolRegistCondition_block2(proxy,param,rendol_id_2);
		
	----------------------------------------------------------------------------------------------------------------
	--���q�������Ȃ��ꏊ�ɂ���������--16009 --EN:--Stealth in a place where the prince can't be seen--16009
	elseif	proxy:IsCompleteEvent(RENDOL_STATE_LOCATION_INVISIBLE) == true then
		print("rendol state RENDOL_STATE_LOCATION_INVISIBLE");
		SetRendolState_09(proxy, param, rendol_id_3 );
		RendolRegistCondition_block3(proxy,param,rendol_id_3);
		
	----------------------------------------------------------------------------------------------------------------
	--���q������J���ė~�������--16010 --EN:--The state where the prince wants the gate to be opened--16010
	elseif	proxy:IsCompleteEvent(RENDOL_STATE_WANT_TO_OPEN_THE_GATE) == true then
		print("rendol state RENDOL_STATE_WANT_TO_OPEN_THE_GATE");
		SetRendolState_10(proxy, param, rendol_id_3 );
		RendolRegistCondition_block3(proxy,param,rendol_id_3);
		
	----------------------------------------------------------------------------------------------------------------
	--���q���܏��H�ŋ������--16011 --EN:--Prince frightened in a dead end--16011
	elseif	proxy:IsCompleteEvent(RENDOL_STATE_SCARED) == true then
		print("rendol state RENDOL_STATE_SCARED");
		SetRendolState_11(proxy, param, rendol_id_3 );
		RendolRegistCondition_block3(proxy,param,rendol_id_3);
		
	----------------------------------------------------------------------------------------------------------------
	--���q�����Ӂi����R�j���--16012 --EN:--Prince thanks (Castle 3) state--16012
	elseif	proxy:IsCompleteEvent(RENDOL_STATE_THANKS_3) == true then
		print("rendol state RENDOL_STATE_THANKS_3");
		SetRendolState_12(proxy, param, rendol_id_3 );
		RendolRegistCondition_block3(proxy,param,rendol_id_3);
		
	----------------------------------------------------------------------------------------------------------------
	--���q���T���i����R�j���--16013 --EN:--Prince exploring (Castle 3) state--16013
	elseif	proxy:IsCompleteEvent(RENDOL_STATE_SEARCH_3) == true then
		print("rendol state RENDOL_STATE_SEARCH_3");
		SetRendolState_13(proxy, param, rendol_id_3 );
		RendolRegistCondition_block3(proxy,param,rendol_id_3);
		
	----------------------------------------------------------------------------------------------------------------
	--���q���G�΁i����R�j���̑O���--16014 --EN:--The prince is hostile (Castle 3) Before the castle gate--16014
	elseif	proxy:IsCompleteEvent(RENDOL_STATE_HOSTILE_3_FRONT_GATE) == true then
		print("rendol state RENDOL_STATE_HOSTILE_3_FRONT_GATE");
		SetRendolState_14(proxy, param, rendol_id_3 );
		RendolRegistCondition_block3(proxy,param,rendol_id_3);
		
	----------------------------------------------------------------------------------------------------------------
	--���q���G�΁i����R�j���̌����--16015 --EN:--Prince is hostile (Castle 3) Behind the castle gate--16015
	elseif	proxy:IsCompleteEvent(RENDOL_STATE_HOSTILE_3_BACK_GATE) == true then
		print("rendol state RENDOL_STATE_HOSTILE_3_BACK_GATE");
		SetRendolState_15(proxy, param, rendol_id_3 );
		RendolRegistCondition_block3(proxy,param,rendol_id_3);
		
	----------------------------------------------------------------------------------------------------------------
	--���q���G���x�[�^�O���--16016 --EN:--Prince before elevator--16016
	elseif	proxy:IsCompleteEvent(RENDOL_STATE_LIFT_FRONT) == true then
		print("rendol state RENDOL_STATE_LIFT_FRONT");
		SetRendolState_16(proxy, param, rendol_id_4 );
		RendolRegistCondition_block4(proxy,param,rendol_id_4);
		
	----------------------------------------------------------------------------------------------------------------
	--���q���G�΁i����S�j���--16017 --EN:--Prince hostile (Royal Castle 4) state--16017
	elseif	proxy:IsCompleteEvent(RENDOL_STATE_HOSTILE_4_LIFT_FRONT) == true then
		print("rendol state RENDOL_STATE_HOSTILE_4_LIFT_FRONT");
		SetRendolState_17(proxy, param, rendol_id_4 );
		RendolRegistCondition_block4(proxy,param,rendol_id_4);
		
	----------------------------------------------------------------------------------------------------------------
	--���q���G�΁i�Β��j���--16018 --EN:--Prince is hostile (stone pillar) state--16018
	elseif	proxy:IsCompleteEvent(RENDOL_STATE_HOSTILE_STONE_PILLAR) == true then
		print("rendol state RENDOL_STATE_HOSTILE_STONE_PILLAR");
		SetRendolState_18(proxy, param, rendol_id_4 );
		RendolRegistCondition_block4(proxy,param,rendol_id_4);
	end
	print("RendolCheck end");
end


--[[11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
---------------------------------------����������P�����h�����q������------------------------------ --EN:--������Royal Castle 1 Prince Lendor������-------------------------------
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111]]
function RendolRegistCondition_block1(proxy,param,chrId)
	print("RendolRegistCondition_block1 begin");
	
	if	proxy:IsCompleteEvent(RENDOL_STATE_DEAD) == false then
		if	proxy:IsCompleteEvent(RENDOL_STATE_HOSTILE_1) == false then
			--��295�������h�����q���G�ɂȂ遡 --EN:-- �� 295 �� Prince Lendl becomes an enemy ��
			if proxy:IsCompleteEvent( 295 ) == false then
				--�����h�����q(624)��PC(LOCAL_PLAYER)����100�_���[�W���󂯂� --EN:--Prince Lendl (624) received 100 damage from PC (LOCAL_PLAYER)
				--proxy:OnCharacterTotalDamage( 295, chrId, LOCAL_PLAYER, 100, "OnEvent_295", once );
				proxy:OnCharacterTotalRateDamage( 295, chrId, LOCAL_PLAYER, NPC_ANGRY_Rate, "OnEvent_295", once );
			end
		end
		--��300�������h�����q�̎��S�� --EN:-- �� 300 �� Death of Prince Lendl ��
		if proxy:IsCompleteEvent( 300 ) == false then
			proxy:OnCharacterDead( 300 , chrId , "OnEvent_300" , once );
		end
		
		
		--��260�������h�����q���͂�ł���z�ꕺ�m��S���|������ --EN:-- �� 260 �� Defeated all the slave soldiers surrounding Prince Lendl ��
		if proxy:IsCompleteEvent( 260 ) == true then
			proxy:DeleteEvent( 258 );--���q����z�ꕺ�m������C�x���g�폜 --EN:--Delete the event that helps the slave soldier from the prince
		end
	end

	
	print("RendolRegistCondition_block1 end");
end


-------------------------------------------------------------------------------------------------
--���q���z�ꕺ�m���珕���ď��--16000 --EN:--Prince Saved from Slave Soldiers State--16000
function SetRendolState_01(proxy,param,chrId)
	print("SetRendolState_01 begin");
	local enemy_list = {310, 311, 312, 313, 314, 315};
	local enemy_num = table.getn( enemy_list );
	for index = 1, enemy_num, 1 do
		--�z�ꂪ�����Ă�����Њd�ɂ��āA�����h�����q���^�[�Q�b�g�ɐݒ� --EN:--Intimidate if the slave is alive and set Prince Lendl as the target
		if	proxy:IsAlive(enemy_list[index]) == true then
			--proxy:ChangeThink( enemy_list[index], AI_EVENT_DOREI_IKAKU);
			proxy:SendEventRequest( enemy_list[index], 0, AI_EVENT_DOREI_IKAKU );
			proxy:SetEventTarget( enemy_list[index] , chrId );--�����^�[�Q�b�g�ݒ� --EN:--force target setting
			--���z�ꕺ�m�����̃_���[�W�Ď��� --EN:--��Damage monitoring of slave soldiers��
			proxy:OnSimpleDamage( 245 , enemy_list[index] , LOCAL_PLAYER , "OnEvent_258" , once );--�_���[�W�Ď�			 --EN:--Damage monitoring
		end
	end
	--�������h�����q���̈�N���Ŏd���Ȃ��키�� --EN:--��Prince Lendl reluctantly fights for territory invasion��
	proxy:OnRegionJustIn( 259, chrId, 2151, "OnEvent_259", once );
	
	proxy:EnableLogic( chrId , false );--�����h�����q���W�b�NOFF --EN:--Lendl Oji Logic OFF
	--���q�L���� --EN:--Prince enabled
	ValidCharactor( proxy, chrId );
	
	--���z�ꕺ�m�������h�����q��_���̂���߂�Ď��ǉ�(���W�b�N�؂�ւ�)��	 --EN:--�� Added monitoring to stop slave soldiers from aiming at Prince Lendl (logic switch) ��
	proxy:SetEventFlag( 258 , 0 );--����ǉ�����Ăق����̂ť���B --EN:--Because I want it to be added every time...
	proxy:OnRegionJustIn ( 258 , LOCAL_PLAYER , 2151 , "OnEvent_258"     , everytime );--�̈�������Ƃ��ʏ��		 --EN:-- to normal when entering the area
	proxy:OnRegionJustIn ( 258 , chrId , 2151 , "OnEvent_258"     , everytime );--�����h���̈�������Ƃ��ʏ��		 --EN:-- to normal when entering the Lendl region
	proxy:OnRegionJustOut( 258 , LOCAL_PLAYER , 2151 , "OnEvent_258_out" , everytime );--�̈�ł��Ƃ��Њd�� --EN:-- to intimidation when in the realm
	
	print("SetRendolState_01 end");
end


-------------------------------------------------------------------------------------------------
--���q�����Ӂi����P�j���--16001 --EN:--Prince thanks (Castle 1) state--16001
function SetRendolState_02(proxy,param,chrId)
	print("SetRendolState_02 begin");
	
	--���q�L���� --EN:--Prince enabled
	ValidCharactor( proxy, chrId );
	
	proxy:EnableLogic(chrId,true);--���q���W�b�NON --EN:--Oji logic ON
	proxy:ChangeInitPosAng( chrId , 2150 );--���q�̋A�ҏꏊ��ύX --EN:-- Changed Prince's return location
	proxy:ResetThink( chrId );
	proxy:ForceUpdateNextFrame( chrId );
	proxy:SendEventRequest( chrId, 0, 10 );
	
	--��10501���A�C�e���擾(��b�ŌĂяo��)�� --EN:-- �� 10501 �� Get item (call in conversation) ��
	--proxy:NotNetMessage_begin();
		proxy:LuaCall(10501,0,"OnEvent_10501",once);--�A�C�e���擾�p�n���h���ǉ� --EN:--Add item handler
	--proxy:NotNetMessage_end();
	
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 10502, "OnEvent_260_1", 5, 0, 2, once );
	proxy:NotNetMessage_end();
	
	
	print("SetRendolState_02 end");
end

function SetRendolState_02Init(proxy, param, chrId )
	print("SetRendolState_02Init begin");
	--���q�L���� --EN:--Prince enabled
	ValidCharactor( proxy, chrId );
	
	proxy:EnableLogic(chrId,true);--���q���W�b�NON --EN:--Oji logic ON
	proxy:ChangeInitPosAng( chrId , 2150 );--���q�̋A�ҏꏊ��ύX --EN:-- Changed Prince's return location
	proxy:Warp( chrId , 2150 );
	proxy:ResetThink( chrId );
	proxy:ForceUpdateNextFrame( chrId );
	--proxy:SendEventRequest( chrId, 0, 10 );	
	--��10501���A�C�e���擾(��b�ŌĂяo��)�� --EN:-- �� 10501 �� Get item (call in conversation) ��
	--proxy:NotNetMessage_begin();
		proxy:LuaCall(10501,0,"OnEvent_10501",once);--�A�C�e���擾�p�n���h���ǉ� --EN:--Add item handler
	--proxy:NotNetMessage_end();
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 10502, "OnEvent_260_1", 2, 0, 2, once );
	proxy:NotNetMessage_end();
	print("SetRendolState_02Init end");
end

function OnEvent_260_1(proxy,param)
	print("OnEvent_260_1 begin");
	proxy:SendEventRequest( 624, 0, AI_EVENT_None );
	print("OnEvent_260_1 end");
end

-------------------------------------------------------------------------------------------------
--���q���T���i����P�j���--16002 --EN:--Prince exploring (Castle 1) state--16002
function SetRendolState_03(proxy,param,chrId)
	print("SetRendolState_03 begin");
	
	--���q�L���� --EN:--Prince enabled
	ValidCharactor( proxy, chrId );
	proxy:ChangeInitPosAng( chrId , 2150 );--���q�̋A�ҏꏊ��ύX --EN:-- Changed Prince's return location
	
	--�ړ��^�C�v�������ɕύX --EN:--Movement type changed to round trip
	
	proxy:SetEventMovePointType( chrId, POINT_MOVE_TYPE_RoundTrip );
	proxy:ForceUpdateNextFrame( chrId );
	proxy:ClearTarget(chrId);
	proxy:ResetThink( chrId );
	
	--�ړ��|�C���g��ύX --EN:--Change movement point
	local point_list = {2010, 2011, 2012, 2013, 2012, 2011, 2014, 2015};
	local point_num = table.getn( point_list );
	for index = 1, point_num, 1 do
		--�ړ��|�C���g��ݒ� --EN:--set movement point
		proxy:AddCustomRoutePoint(chrId, point_list[index]);
	end
	
	--�����h�����q���T�����������苗���ȏ㗣�ꂽ���_�Ŏ��̏�ԂɑJ�� --EN:--If Prince Lendl is searching, transition to the next state when it is more than a certain distance away
	if	proxy:IsClient() == false then
		if	proxy:IsCompleteEvent( 4096 ) == true then
			if	proxy:IsDistance( LOCAL_PLAYER, chrId, 20 ) == false then
				--�t���[�������炵�Ĉ��S���̊m�� --EN:--Stabilize the frame to ensure safety
				proxy:NotNetMessage_begin();
					proxy:OnKeyTime2( 301, "OnEvent_301", 0.0, 0, 2, once );
				proxy:NotNetMessage_end();
			else
				proxy:NotNetMessage_begin();
					proxy:OnPlayerDistanceOut( 301, LOCAL_PLAYER, chrId "OnEvent_301", 20, once );
				proxy:NotNetMessage_end();
			end
		end
	end

	print("SetRendolState_03 end");
end

function SetRendolState_03Init(proxy, param, chrId )
	print("SetRendolState_03Init begin");
	--���q�L���� --EN:--Prince enabled
	ValidCharactor( proxy, chrId );
	proxy:Warp( chrId, 2150);
	proxy:ChangeInitPosAng( chrId , 2150 );--���q�̋A�ҏꏊ��ύX --EN:-- Changed Prince's return location
	
	--�ړ��^�C�v�������ɕύX --EN:--Movement type changed to round trip
	
	proxy:SetEventMovePointType( chrId, POINT_MOVE_TYPE_RoundTrip );
	proxy:ForceUpdateNextFrame( chrId );
	proxy:ClearTarget(chrId);
	proxy:ResetThink( chrId );
	
	--�ړ��|�C���g��ύX --EN:--Change movement point
	local point_list = {2010, 2011, 2012, 2013, 2012, 2011, 2014, 2015};
	local point_num = table.getn( point_list );
	for index = 1, point_num, 1 do
		--�ړ��|�C���g��ݒ� --EN:--set movement point
		proxy:AddCustomRoutePoint(chrId, point_list[index]);
	end
	
	--�����h�����q���T�����������苗���ȏ㗣�ꂽ���_�Ŏ��̏�ԂɑJ�� --EN:--If Prince Lendl is searching, transition to the next state when it is more than a certain distance away
	if	proxy:IsClient() == false then
		if	proxy:IsCompleteEvent( 4096 ) == true then
			if	proxy:IsDistance( LOCAL_PLAYER, chrId, 20 ) == false then
				--�t���[�������炵�Ĉ��S���̊m�� --EN:--Stabilize the frame to ensure safety
				proxy:NotNetMessage_begin();
					proxy:OnKeyTime2( 301, "OnEvent_301", 0.0, 0, 2, once );
				proxy:NotNetMessage_end();
			else
				proxy:NotNetMessage_begin();
					proxy:OnPlayerDistanceOut( 301, LOCAL_PLAYER, chrId "OnEvent_301", 20, once );
				proxy:NotNetMessage_end();
			end
		end
	end
	print("SetRendolState_03Init end");
end

-------------------------------------------------------------------------------------------------
--���q���G�΁i����P�j���--16003 --EN:--Prince hostile (Royal Castle 1) state--16003
function SetRendolState_04(proxy,param,chrId)
	print("SetRendolState_04 begin");
	
	proxy:SendEventRequest( 624, 0, AI_EVENT_None );
	--�ړ��^�C�v�������ɕύX --EN:--Movement type changed to round trip
	proxy:SetEventMovePointType( chrId, POINT_MOVE_TYPE_RoundTrip );
	proxy:ChangeInitPosAng( chrId , 2150 );--���q�̋A�ҏꏊ��ύX --EN:-- Changed Prince's return location
	
	--�ړ��|�C���g��ύX --EN:--Change movement point
	local point_list = {2010, 2011, 2012, 2013, 2012, 2011, 2014, 2015};
	local point_num = table.getn( point_list );
	for index = 1, point_num, 1 do
		--�ړ��|�C���g��ݒ� --EN:--set movement point
		proxy:AddCustomRoutePoint(chrId, point_list[index]);
	end
	
	proxy:SetTeamType( chrId, TEAM_TYPE_AngryFriend );
	proxy:EraseEventSpecialEffect_2( chrId , 5062 );
	--���q�L���� --EN:--Prince enabled
	ValidCharactor( proxy, chrId );
	
	print("SetRendolState_04 end");
end

function SetRendolState_04Init(proxy,param,chrId)
	print("SetRendolState_04Init begin");
	--�ړ��^�C�v�������ɕύX --EN:--Movement type changed to round trip
	proxy:SendEventRequest( 624, 0, AI_EVENT_None );
	proxy:SetEventMovePointType( chrId, POINT_MOVE_TYPE_RoundTrip );
	proxy:ChangeInitPosAng( chrId , 2150 );--���q�̋A�ҏꏊ��ύX --EN:-- Changed Prince's return location
	proxy:Warp( chrId,2150);
	
	--�ړ��|�C���g��ύX --EN:--Change movement point
	local point_list = {2010, 2011, 2012, 2013, 2012, 2011, 2014, 2015};
	local point_num = table.getn( point_list );
	for index = 1, point_num, 1 do
		--�ړ��|�C���g��ݒ� --EN:--set movement point
		proxy:AddCustomRoutePoint(chrId, point_list[index]);
	end
	
	proxy:SetTeamType( chrId, TEAM_TYPE_AngryFriend );
	proxy:EraseEventSpecialEffect_2( chrId , 5062 );
	--���q�L���� --EN:--Prince enabled
	ValidCharactor( proxy, chrId );
	print("SetRendolState_04Init end");
end


--[[11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
---------------------------------------����������P�����h�����q������------------------------------ --EN:--������ Royal Castle 1 Prince Lendor ������------------------------------------------
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111]]




--[[22222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222
---------------------------------------����������Q�����h�����q������------------------------------ --EN:--������Royal Castle 2 Prince Lendor������-------------------------------
22222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222]]
function RendolRegistCondition_block2(proxy,param,chrId)
	print("RendolRegistCondition_block2 begin");
	if	proxy:IsCompleteEvent(RENDOL_STATE_DEAD) == false then
		if	proxy:IsCompleteEvent(RENDOL_STATE_HOSTILE_2) == false then
		--��723�����q���G�΂��遡 --EN:-- �� 723 �� The prince is hostile ��
			if proxy:IsCompleteEvent( 723 ) == false then
				--proxy:OnCharacterTotalDamage( 723, 620, LOCAL_PLAYER, 100, "OnEvent_723", once );
				proxy:OnCharacterTotalRateDamage( 723, 620, LOCAL_PLAYER, NPC_ANGRY_Rate, "OnEvent_723", once );
			end
		end
	--��720�������h�������ӂ��遡 --EN:-- �� 720 �� Lendl appreciates ��
		--(�������̃^�C�~���O�ŁA�Ď���ǉ�) --EN:--(A monitor is added at the timing of initialization)

	--��10800�����q���T�����J�n���遡(��b�V�X�e������Ăяo��) --EN:-- �� 10800 �� The prince starts searching �� (call from the conversation system)
		--(���q�����ӏ�ԂɂȂ����Ƃ��ɁA�Ď���ǉ�) --EN:--(Added monitoring when the prince is in gratitude state)



	--��724�����q�����ʁ� --EN:-- �� 724 �� Prince dies ��
		if proxy:IsCompleteEvent( 724 ) == false then
			proxy:OnCharacterDead( 724 , 620 , "OnEvent_724" , once );
		end	
	end
	print("RendolRegistCondition_block2 end");
end

-------------------------------------------------------------------------------------------------
--���q���B��Ă���̂ŏ����ď��--16005 --EN:--The prince is hiding, so please help me--16005
function SetRendolState_05(proxy,param,chrId)
	print("SetRendolState_05 begin");
	--proxy:EnableLogic( chrId , false );--�����h�����q���W�b�NOFF(�A�C�e���n���҂�?) --EN:--Rendor Oji logic OFF (Waiting for item delivery?)
	--proxy:SetEventCommand( chrId , 40 );--EzState�ɐ���ԍ�(������)��n���B --EN:-- Pass the control number (fear) to EzState.
	
--��643�������h�����q�Ăт����͈͎擾��	 --EN:--��643��Prince Lendl calling range acquisition��
	--proxy:SetEventFlag( 643 , 0 );--����ǉ�����Ăق����̂ť�� --EN:--Because I want it to be added every time...
	SingleReset(proxy,643);
	proxy:NotNetMessage_begin();
		if proxy:IsClient() == false then
			proxy:OnRegionJustIn( 643 , LOCAL_PLAYER , 2340 , "OnEvent_643" , everytime );
			proxy:OnRegionJustOut( 643, LOCAL_PLAYER , 2340 , "OnEvent_643_out" , everytime );
		end
	proxy:NotNetMessage_end();
	
	--���q�L���� --EN:--Prince enabled
	ValidCharactor( proxy, chrId );	
	
	--��652�������h���ǂ��������mA�̗L������ --EN:--�� 652 �� Activation of Rendor Chasing Soldier A ��
	if proxy:IsCompleteEvent( 652 ) == false then		
		ValidCharactor( proxy,102);
	end
	
	--��654�������h���ǂ��������mB�̗L������ --EN:--�� 654 �� Activation of Rendor Chasing Soldier B ��
	if proxy:IsCompleteEvent( 654 ) == false then
		ValidCharactor( proxy,103);
	end

	--��655�������h���ǂ��������mC�̗L������ --EN:--�� 655 �� Activation of Rendor Chasing Soldier C ��
	if proxy:IsCompleteEvent( 655 ) == false then
		ValidCharactor( proxy,104);
	end

	--��656�������h���ǂ��������mD�̗L������ --EN:-- �� 656 �� Activation of Rendor Chasing Soldier D ��
	if proxy:IsCompleteEvent( 656 ) == false then		
		ValidCharactor( proxy,105);		
	end

	--��657�������h���ǂ��������mE�̗L������ --EN:--�� 657 �� Activation of Rendor Chasing Soldier E ��
	if proxy:IsCompleteEvent( 657 ) == false then
		ValidCharactor( proxy,106);
	end

	--��658�������h���ǂ��������mF�̗L������ --EN:--�� 658 �� Activation of Rendor Chasing Soldier F ��
	if proxy:IsCompleteEvent( 658 ) == false then
		ValidCharactor( proxy,107);
	end
	--[[
	ValidCharactor( proxy, 102 );
	ValidCharactor( proxy, 103 );
	]]
	print("SetRendolState_05 end");
end

-------------------------------------------------------------------------------------------------
--���q�����Ӂi����Q�j���--16006 --EN:--Prince thanks (Castle 2) state--16006
function SetRendolState_06(proxy,param,chrId)
	print("SetRendolState_06 begin");
	--proxy:EnableLogic( chrId , false );--�����h�����q���W�b�NOFF(�A�C�e���n���҂�?) --EN:--Rendor Oji logic OFF (Waiting for item delivery?)
	proxy:SetSpStayAndDamageAnimId( chrId,-1,-1);
	
	if proxy:IsCompleteEvent( 10800 ) == false then
		proxy:NotNetMessage_begin();
			proxy:LuaCall( 10800 , 0 , "OnEvent_10800" , once );--��b�V�X�e������Ăԏꍇ�ɂ�param=0 --EN:--param=0 when calling from the conversation system
		proxy:NotNetMessage_end();
	end
	
	--���q�L���� --EN:--Prince enabled
	ValidCharactor( proxy, chrId );
	
	--[[
	--���̏�ŏ������Ȃ��l�ɋ����Ń`�F�b�N�������Ă��� --EN:--Check the distance so that it doesn't disappear on the spot
	if	proxy:IsDistance(LOCAL_PLAYER, 102, 20) == true then
		ValidCharactor( proxy, 102 );
	end
	if	proxy:IsDistance(LOCAL_PLAYER, 103, 20) == true then
		ValidCharactor( proxy, 103 );
	end
	]]
	print("SetRendolState_06 end");
end
-------------------------------------------------------------------------------------------------
--���q���T���i����Q�j���--16007 --EN:--Prince Exploring (Castle 2) State--16007
function SetRendolState_07(proxy,param,chrId)
	print("SetRendolState_07 begin");
	-----------------�����h�����q��ԃX�L�b�v�`�F�b�N----------------------- --EN:--Lendl Prince State Skip Check-----------------------
	--���̏�������ł� --EN:--The king's shield is dead
	if	proxy:IsCompleteEvent(4224) == true then
		--���ɉ��̏�������ł����̂ŉ���R�̏�Ԃ� --EN:--Since the King's Shield was already dead, go to Castle 3
		if	proxy:IsCompleteEvent( 1041 ) == false then
			print("SetRendolState_07 �����h�����q�@���̏�������ł����̂ŁA����R�̏�Ԃֈڍs"); --EN:print("SetRendolState_07 Prince Rendol. The King's Shield is dead, so move to Castle 3 state");
			SetNpcStateFlag( proxy, param, rendol_flag_list, RENDOL_STATE_LOCATION_INVISIBLE );
			proxy:OnKeyTime2( SYSTEM_CHECK_POINT, "RendolCheck", 0.0, 0, 2, once );
			
		--���ɉ���R�̃��o�[�����J���Ă����̂ŉ���S�̏�Ԃ� --EN:--Since the lever door of the castle 3 was already open, go to the state of the castle 4
		else
			print("SetRendolState_07 �����h�����q�@����R���o�[�����J���Ă���̂ŁA����S�̏�Ԃֈڍs"); --EN:print("SetRendolState_07 Prince Rendol, since the castle 3 lever door is open, shift to the state of royal castle 4");
			SetNpcStateFlag( proxy, param, rendol_flag_list, RENDOL_STATE_LIFT_FRONT );
			proxy:OnKeyTime2( SYSTEM_CHECK_POINT, "RendolCheck", 0.0, 0, 2, once );
		end
	end
	
	--���q�L���� --EN:--Prince enabled
	ValidCharactor( proxy, chrId );
	proxy:SetSpStayAndDamageAnimId( chrId,-1,-1);
	--�ړ��^�C�v�������ɕύX --EN:--Movement type changed to round trip
	proxy:SetEventMovePointType( chrId, POINT_MOVE_TYPE_RoundTrip );
	
	--�ړ��|�C���g��ύX --EN:--Change movement point
	local point_list = {2220, 2221, 2222, 2223};
	local point_num = table.getn( point_list );
	for index = 1, point_num, 1 do
		--�ړ��|�C���g��ݒ� --EN:--set movement point
		proxy:AddCustomRoutePoint(chrId, point_list[index]);
	end
	
	--[[
	--���̏�ŏ������Ȃ��l�ɋ����Ń`�F�b�N�������Ă��� --EN:--Check the distance so that it doesn't disappear on the spot
	if	proxy:IsDistance(LOCAL_PLAYER, 102, 20) == true then
		ValidCharactor( proxy, 102 );
	end
	if	proxy:IsDistance(LOCAL_PLAYER, 103, 20) == true then
		ValidCharactor( proxy, 103 );
	end
	]]
	print("SetRendolState_07 end");
end

-------------------------------------------------------------------------------------------------
--���q���G�΁i����Q�j���--16008 --EN:--Prince hostile (Royal Castle 2) state--16008
function SetRendolState_08(proxy,param,chrId)
	print("SetRendolState_08 begin");
	
	print("�����h�����q���G�ɂȂ�܂���"); --EN:print("Prince Lendl has become an enemy");
	proxy:EnableLogic( chrId , true );--[[�����h�����q���W�b�NON(���W�b�N�؂�ւ�?)]] --EN:--[[Prince Lendl logic ON (logic switching?)]]
	--proxy:SetEventCommand( chrId , 41 );--EzState�ɐ���ԍ�(�����I��)��n���B --EN:-- Pass the control number (terrified end) to EzState.
	proxy:SetTeamType( chrId, TEAM_TYPE_AngryFriend );
	proxy:EraseEventSpecialEffect_2( chrId , 5062 );
	--���q�L���� --EN:--Prince enabled
	ValidCharactor( proxy, chrId );
	--[[
	--���̏�ŏ������Ȃ��l�ɋ����Ń`�F�b�N�������Ă��� --EN:--Check the distance so that it doesn't disappear on the spot
	if	proxy:IsDistance(LOCAL_PLAYER, 102, 40) == true then
		ValidCharactor( proxy, 102 );
	end
	if	proxy:IsDistance(LOCAL_PLAYER, 103, 40) == true then
		ValidCharactor( proxy, 103 );
	end
	]]
	print("SetRendolState_08 end");
end


--[[22222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222
---------------------------------------����������Q�����h�����q������------------------------------ --EN:--������ Royal Castle 2 Prince Lendor������------------------------------
22222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222]]


--[[33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
---------------------------------------����������R�����h�����q������------------------------------ --EN:--������Royal Castle 3 Prince Lendor������------------------------------
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333]]
function RendolRegistCondition_block3(proxy,param,chrId)
	print("RendolRegistCondition_block3 begin");
	if	proxy:IsCompleteEvent(RENDOL_STATE_DEAD) == false then
		if	proxy:IsCompleteEvent(RENDOL_STATE_HOSTILE_3_FRONT_GATE) == false and
			proxy:IsCompleteEvent(RENDOL_STATE_HOSTILE_3_BACK_GATE) == false then
		--��1316�����q���G�΂���(���O)�� --EN:-- �� 1316 �� The prince is hostile (in front of the castle gate) ��
			if proxy:IsCompleteEvent( 1316 ) == false then
				--proxy:OnCharacterTotalDamage( 1316 , 621 , LOCAL_PLAYER , 100 , "OnEvent_1316" , once );
				proxy:OnCharacterTotalRateDamage( 1316, 621, LOCAL_PLAYER, NPC_ANGRY_Rate, "OnEvent_1316", once );
			end
		
		--��1317�����q���G�΂���(�����)�� --EN:-- �� 1317 �� The prince is hostile (behind the castle gate) ��
			if proxy:IsCompleteEvent( 1317 ) == false then
				--proxy:OnCharacterTotalDamage( 1317 , 621 , LOCAL_PLAYER , 100 , "OnEvent_1317" , once );
				proxy:OnCharacterTotalRateDamage( 1317, 621, LOCAL_PLAYER, NPC_ANGRY_Rate, "OnEvent_1317", once );
			end
		end


	--��11501�����q���T�����J�n���遡(��b�V�X�e������Ăяo��) --EN:-- �� 11501 �� The prince starts searching �� (call from the conversation system)
		if proxy:IsCompleteEvent( 11501 ) == false then
			proxy:NotNetMessage_begin();
				proxy:LuaCall( 11501 , 0 , "OnEvent_11501" , once );
			proxy:NotNetMessage_end();
		end

		
	--��1318�����q�����S���遡 --EN:-- �� 1318 �� Prince dies ��
		if proxy:IsCompleteEvent( 1318 ) == false then
			proxy:OnCharacterDead( 1318, 621, "OnEvent_1318", once );
		end
		
	--��1338�����q��b�p�̈攻�聡 --EN:-- �� 1338 �� Area judgment for prince conversation ��
		SingleReset( proxy,1338 );
		if proxy:IsCompleteEvent( 1338 ) == false then
			proxy:NotNetMessage_begin();
				proxy:OnRegionJustIn( 1338, 621 , 2416 , "OnEvent_1338_in",everytime);
				proxy:OnRegionJustOut( 1338 , 621 , 2416 , "OnEvent_1338_out",everytime);
			proxy:NotNetMessage_end();
		end
		
	end
	print("RendolRegistCondition_block3 end");
end


-------------------------------------------------------------------------------------------------
--���q�������Ȃ��ꏊ�ɂ���������--16009 --EN:--Stealth in a place where the prince can't be seen--16009
function SetRendolState_09(proxy,param,chrId)
	print("SetRendolState_09 begin");
--��1310�����q����̑O�Ɉړ����遡 --EN:--��1310��The prince moves in front of the gate��
	--�K���ǉ����� --EN:--must add
	proxy:SetEventFlag( 1310, false );
	proxy:OnRegionJustIn( 1310 , LOCAL_PLAYER , 2550 , "OnEvent_1310" , once );
--��1312�����q���܏��H�ɓ����������Ƃɋ��������遡 --EN:-- �� 1312 �� frighten the prince after arriving at the dead end ��
	if proxy:IsCompleteEvent( 1312 ) == false then
		proxy:OnRegionJustIn( 1312 , chrId , 2553 , "OnEvent_1312" , once );
	end
--��1349�����q����̑O�܂œ����������ǁA��͕܂��Ă��� --EN:--��1349��The prince arrived in front of the gate, but the gate was closed.
	if	proxy:IsCompleteEvent( 1349 ) == false then
		proxy:OnRegionJustIn( 1349, chrId, 2415, "OnEvent_1349", once );
	end
	--���q�L���� --EN:--Prince enabled
	ValidCharactor( proxy, chrId );
	print("SetRendolState_09 end");
end

-------------------------------------------------------------------------------------------------
--���q������J���ė~�������--16010 --EN:--The state where the prince wants the gate to be opened--16010
function SetRendolState_10(proxy,param,chrId)
	print("SetRendolState_10 begin");
	--proxy:DisableInterupt( chrId, true );--���荞�݂��Ւf(�G�ɍU������Ă��퓬���W�b�N�ɂ��Ȃ�����) --EN:--Block interruptions (because it does not turn into battle logic even if attacked by the enemy)

	proxy:ChangeInitPosAng( chrId , 2552 );--�����̑O�̗̈�ɂ��� --EN:--Make the nest the area in front of the gate
	proxy:EnableLogic( chrId , true );--���W�b�NON --EN:--Logic ON
	proxy:SendEventRequest( chrId, 0, AI_EVENT_None );
	proxy:ResetThink( chrId );
	if	proxy:IsDistance( LOCAL_PLAYER, chrId, 20 ) == false then
		proxy:Warp( chrId , 2552 );--�����ʒu�Ƀ��[�v --EN:--Warp to initial position
	end
	proxy:NotNetMessage_begin();
		----�����q��ǂ��G���o������1�� --EN:--�� An enemy chasing the prince appears 1 ��
		--proxy:OnKeyTime2( 1350 , "OnEvent_1350" , 2.0 , 0 , 1 , once );
		
		--��1312�����q���܏��H�ɓ����������Ƃɋ��������遡 --EN:-- �� 1312 �� frighten the prince after arriving at the dead end ��
		if proxy:IsCompleteEvent( 1312 ) == false then
			proxy:OnRegionJustIn( 1312 , 621 , 2553 , "OnEvent_1312" , once );
		end
	proxy:NotNetMessage_end();
	
	--���q�L���� --EN:--Prince enabled
	ValidCharactor( proxy, chrId );
	print("SetRendolState_10 end");
end

-------------------------------------------------------------------------------------------------
--���q���܏��H�ŋ������--16011 --EN:--Prince frightened in a dead end--16011
function SetRendolState_11(proxy,param,chrId)
	print("SetRendolState_11 begin");
	proxy:ChangeInitPosAng( chrId , 2553 );--����܏��H�̗̈�ɂ��� --EN:--Make the nest a cul-de-sac area
	if	proxy:IsDistance( LOCAL_PLAYER, chrId, 20 ) == false then
		proxy:ForceUpdateNextFrame( chrId );
		proxy:Warp( chrId , 2553 );--�����ʒu�Ƀ��[�v --EN:--Warp to initial position
		print("�����h�����[�v�@2553"); --EN:print("Lendl Warp 2553");
	end
	--proxy:EnableLogic( chrId , false );--���W�b�NOFF --EN:--Logic OFF
	--proxy:SetEventCommand( chrId, 40 );--������ --EN:--Fear
	proxy:SetSpStayAndDamageAnimId(chrId,7600,9600);
	
	proxy:NotNetMessage_begin();
		proxy:NotNetMessage_begin();
			--�����q��ǂ��G�̑���ς���1�� --EN:--�� Change the nest of the enemy chasing the prince 1��
			proxy:OnKeyTime2( 1360 , "OnEvent_1360" ,  5.0 , 0 , 1 , once );		
			--�����q��ǂ��G�̑���ς���2�� --EN:--��Change the nest of the enemy chasing the prince 2��
			proxy:OnKeyTime2( 1361 , "OnEvent_1361" ,  8.0 , 0 , 1 , once );		
			--�����q��ǂ��G�̑���ς���3�� --EN:--�� Change the nest of the enemy chasing the prince 3 ��
			proxy:OnKeyTime2( 1362 , "OnEvent_1362" , 11.0 , 0 , 1 , once );
		proxy:NotNetMessage_end();
		--��1312�����q���܏��H�ɓ����������Ƃɋ��������遡 --EN:-- �� 1312 �� frighten the prince after arriving at the dead end ��
		if proxy:IsCompleteEvent( 1312 ) == false then
			proxy:OnRegionJustIn( 1312 , chrId , 2553 , "OnEvent_1312" , once );
		end
	proxy:NotNetMessage_end();
	
	--���q�L���� --EN:--Prince enabled
	ValidCharactor( proxy, chrId );
	print("SetRendolState_11 end");
end

-------------------------------------------------------------------------------------------------
--���q�����Ӂi����R�j���--16012 --EN:--Prince thanks (Castle 3) state--16012
function SetRendolState_12(proxy,param,chrId)
	print("SetRendolState_12 begin");
	proxy:ChangeInitPosAng( chrId , 2555 );--����܏��H�̗̈�ɂ��� --EN:--Make the nest a cul-de-sac area
	
	if	proxy:IsDistance( LOCAL_PLAYER, chrId, 20 ) == false then
		proxy:Warp( chrId , 2555 );--�����ʒu�Ƀ��[�v --EN:--Warp to initial position
	end
	--proxy:EnableLogic( chrId, false );--���W�b�NOFF --EN:--Logic OFF
	
	proxy:DisableInterupt( chrId, false );--���荞�݂�L�� --EN:--enable interrupts
	--proxy:SetEventCommand( chrId , 41 );--EzState�ɐ���ԍ��𑗂�(�����I��) --EN:--Send control number to EzState (finish frightened)
	proxy:SetSpStayAndDamageAnimId(chrId,-1,-1);
	
	--���q�L���� --EN:--Prince enabled
	ValidCharactor( proxy, chrId );
	print("SetRendolState_12 end");
end

-------------------------------------------------------------------------------------------------
--���q���T���i����R�j���--16013 --EN:--Prince exploring (Castle 3) state--16013
function SetRendolState_13(proxy,param,chrId)
	print("SetRendolState_13 begin");
	
	--���q�L���� --EN:--Prince enabled
	ValidCharactor( proxy, chrId );
	
	proxy:EnableLogic( chrId , true );--�����h�����q�A�T����Ԃŕ����o�� --EN:--Prince Lendl starts walking in exploration mode
	proxy:ResetThink( chrId );
	proxy:ChangeInitPosAng( chrId , 2555 );--����܏��H�̗̈�ɂ��� --EN:--Make the nest a cul-de-sac area
	proxy:ForceUpdateNextFrame( chrId );
	proxy:ClearTarget(chrId);
	proxy:SendEventRequest( chrId, 0, AI_EVENT_None );
	proxy:SetSpStayAndDamageAnimId(chrId,-1,-1);
	
	
	if	proxy:IsDistance( LOCAL_PLAYER, chrId, 20 ) == false then
		proxy:Warp( chrId , 2555 );--�����ʒu�Ƀ��[�v --EN:--Warp to initial position
	end
	
	--�ړ��^�C�v�������ɕύX --EN:--Movement type changed to round trip
	proxy:SetEventMovePointType( chrId, POINT_MOVE_TYPE_RoundTrip );
	
	--�ړ��|�C���g��ύX --EN:--Change movement point
	local point_list = {2410, 2411, 2412, 2413, 2414};
	local point_num = table.getn( point_list );
	for index = 1, point_num, 1 do
		--�ړ��|�C���g��ݒ� --EN:--set movement point
		proxy:AddCustomRoutePoint(chrId, point_list[index]);
	end
	
	
	print("SetRendolState_13 end");
end

-------------------------------------------------------------------------------------------------
--���q���G�΁i����R�j���̑O���--16014 --EN:--The prince is hostile (Castle 3) Before the castle gate--16014
function SetRendolState_14(proxy,param,chrId)
	print("SetRendolState_14 begin");
	proxy:ChangeInitPosAng( chrId , 2552 );--����܏��H�̗̈�ɂ��� --EN:--Make the nest a cul-de-sac area
	if	proxy:IsDistance( LOCAL_PLAYER, chrId, 60 ) == false then
		proxy:Warp( chrId , 2552 );--�����ʒu�Ƀ��[�v --EN:--Warp to initial position
	end
	proxy:SetTeamType( chrId, TEAM_TYPE_AngryFriend );
	proxy:EraseEventSpecialEffect_2( chrId , 5063 );
	proxy:EnableLogic( chrId , true );--���W�b�NON --EN:--Logic ON
	proxy:SendEventRequest( chrId , 0 , AI_EVENT_None );--���W�b�N��؂�ւ��Ă��̂���߂�B --EN:--Stop switching logic.
	proxy:SetSpStayAndDamageAnimId(chrId,-1,-1);
	proxy:ResetThink( chrId );
	
	--���q�L���� --EN:--Prince enabled
	ValidCharactor( proxy, chrId );
	print("SetRendolState_14 end");
end

-------------------------------------------------------------------------------------------------
--���q���G�΁i����R�j���̌����--16015 --EN:--Prince is hostile (Castle 3) Behind the castle gate--16015
function SetRendolState_15(proxy,param,chrId)
	print("SetRendolState_15 begin");
	proxy:ChangeInitPosAng( chrId , 2555 );--����܏��H�̗̈�ɂ��� --EN:--Make the nest a cul-de-sac area
	if	proxy:IsDistance( LOCAL_PLAYER, chrId, 60 ) == false then
		proxy:Warp( chrId , 2555 );--�����ʒu�Ƀ��[�v --EN:--Warp to initial position
	end
	proxy:SetTeamType( chrId, TEAM_TYPE_AngryFriend );
	proxy:EraseEventSpecialEffect_2( chrId , 5063 );
	proxy:SetSpStayAndDamageAnimId(621,-1,-1);
	proxy:EnableLogic( chrId , true );--���W�b�NON --EN:--Logic ON
	proxy:SendEventRequest( chrId , 0 , AI_EVENT_None );--���W�b�N��؂�ւ��Ă��̂���߂�B --EN:--Stop switching logic.
	proxy:ResetThink( chrId );
	
	--���q�L���� --EN:--Prince enabled
	ValidCharactor( proxy, chrId );
	print("SetRendolState_15 end");
end

--[[33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
---------------------------------------����������R�����h�����q������------------------------------ --EN:--������ Royal Castle 3 Prince Lendor ������------------------------------------------
3333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333]]



--[[44444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444
---------------------------------------����������S�����h�����q������------------------------------ --EN:--������Royal Castle 4 Prince Lendor������------------------------------
44444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444]]
function RendolRegistCondition_block4(proxy,param,chrId)
	print("RendolRegistCondition_block4 begin");
	
	if	proxy:IsCompleteEvent(RENDOL_STATE_DEAD) == false then
	--����S�ł̃����h�����q�̓G�ΊĎ��͂Ȃ��Ȃ�܂����B --EN:--Prince Lendl's hostile oversight in Royal Castle 4 is gone.
--~ 		if	proxy:IsCompleteEvent(RENDOL_STATE_HOSTILE_4_LIFT_FRONT) == false then
--~ 			--�����h�����q�G�ΊĎ� --EN:--Prince Lendl Hostile Watch
--~ 			--proxy:OnCharacterTotalDamage( 1702, 626, LOCAL_PLAYER, 100, "OnEvent_1702", once );
--~ 			--proxy:OnCharacterTotalRateDamage( 1702, 626, LOCAL_PLAYER, NPC_ANGRY_Rate, "OnEvent_1702", once );
--~ 		end
		proxy:OnCharacterDead( 1700, 626, "OnEvent_1700", once );
		
		--��b�Ăяo���n���h�� --EN:--conversation call handler
		if	proxy:IsCompleteEvent(11790) == false then			
			proxy:LuaCall( 11790, 0, "OnEvent_11790", everytime );
		end
	end
	print("RendolRegistCondition_block4 end");
end

-------------------------------------------------------------------------------------------------
--���q���G���x�[�^�O���--16016 --EN:--Prince before elevator--16016
function SetRendolState_16(proxy,param,chrId)
	print("SetRendolState_16 begin");
	proxy:SetHp( chrId, 0.001);
	
	--���q�L���� --EN:--Prince enabled
	ValidCharactor( proxy, chrId );
	print("SetRendolState_16 end");
end
-------------------------------------------------------------------------------------------------
--���q���G�΁i����S�j���--16017 --EN:--Prince hostile (Royal Castle 4) state--16017
function SetRendolState_17(proxy,param,chrId)
	print("SetRendolState_17 begin");
	
	proxy:SetTeamType( chrId, TEAM_TYPE_AngryFriend );
	
	--���q�L���� --EN:--Prince enabled
	ValidCharactor( proxy, chrId );
	print("SetRendolState_17 end");
end
-------------------------------------------------------------------------------------------------
--���q���G�΁i�Β��j���--16018 --EN:--Prince is hostile (stone pillar) state--16018
function SetRendolState_18(proxy,param,chrId)
	print("SetRendolState_16 begin");
	print("SetRendolState_18 end");
end

--[[44444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444
---------------------------------------����������S�����h�����q������------------------------------ --EN:--������Royal Castle 4 Prince Lendor������------------------------------
44444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444]]


--[[-----------------------------------------------------------------------------------------------------------------------------------------
	�����h�����q�֘A�@�����܂� --EN:Related to Prince Lendl So far
-----------------------------------------------------------------------------------------------------------------------------------------]]





--[[-----------------------------------------------------------------------------------------------------------------------------------------
	�r�������O�����֘A�@�������� --EN:Related to Bjrn Grum From here
-----------------------------------------------------------------------------------------------------------------------------------------]]
function BiyoCheck(proxy,param)
	BiyoCheck2(proxy,param,true);
end

function BiyoCheck2(proxy,param,flag)
	print("BiyoCheck begin");
	
	local biyo_id_2 = 622;--����Q�̃r�������O���� --EN:--Bjrn Grum of the Royal Castle 2
	local biyo_id_3 = 627;--����R�̃r�������O���� --EN:--Bjrn Grum of the Royal Castle 3
	local biyo_id_4 = 698;--����S�̃r�������O���� --EN:--Bjrn Grum of the Royal Castle 4
	
	local biyo_block2_acid_list = { 525, 526, 521, 522, 527 , 530};
	local biyo_block3_acid_list = { 1432, 1433, 1460};
	local biyo_block4_acid_list = { 1711, 1712, 1717};
	
	--����2�̃r���̃f�t�H���g�𖡕��ɕύX --EN:--Changed the default of Beyo in Ojo 2 to be an ally
	proxy:SetTeamType( biyo_id_2 , TEAM_TYPE_Friend );	
	
	--��U�S�������Ă��� --EN:-- Erase all of them for now
	InvalidCharactor(proxy,biyo_id_2);
	InvalidCharactor(proxy,biyo_id_3);
	InvalidCharactor(proxy,biyo_id_4);
	
	--�Ď�����U�S�폜 --EN:--Delete all monitors once
	DeleteConditionList(proxy,biyo_block2_acid_list);
	DeleteConditionList(proxy,biyo_block3_acid_list);
	DeleteConditionList(proxy,biyo_block4_acid_list);
	
	
	
	SetFirstNpcStateFlag( proxy, param, biyo_flag_list, BIYO_STATE_CAPTIVE );
	
	----------------------------------------------------------------------------------------------------------------
	--�r�������O�������S���Ɏ������--16060 --EN:--Bjrngurm in prison--16060
	if	proxy:IsCompleteEvent(BIYO_STATE_CAPTIVE) == true then
		print("biyo state BIYO_STATE_CAPTIVE");
		SetBiyoState_01(proxy, param, biyo_id_2 );
		BiyoRegistCondition_block2(proxy,param,biyo_id_2);
		
	----------------------------------------------------------------------------------------------------------------
	--�r�������O������������Ă���Ċ��ӏ��--16061 --EN:--Grateful state for Bjrn Grum's release--16061
	elseif	proxy:IsCompleteEvent(BIYO_STATE_THANKS) == true then
		print("biyo state BIYO_STATE_THANKS");
		SetBiyoState_02(proxy, param, biyo_id_2 );
		BiyoRegistCondition_block2(proxy,param,biyo_id_2);
		
	----------------------------------------------------------------------------------------------------------------
	--�r�������O�������S���ŐQ�Ă�����--16062 --EN:--Bjrngurm sleeping in prison--16062
	elseif	proxy:IsCompleteEvent(BIYO_STATE_SLEEPING_IN_PRISON) == true then
		print("biyo state BIYO_STATE_SLEEPING_IN_PRISON");
		if flag == true then 
			SetBiyoState_03(proxy, param, biyo_id_2 );
		else
			SetBiyoState_03Init(proxy , param , biyo_id_2 );
		end
		BiyoRegistCondition_block2(proxy,param,biyo_id_2);		
		
	----------------------------------------------------------------------------------------------------------------
	--�r�������O�������G��(�S��)���--16063 --EN:--Bjrn Grum is hostile (in prison)--16063
	elseif	proxy:IsCompleteEvent(BIYO_STATE_HOSTILE_IN_PRISON) == true then
		print("biyo state BIYO_STATE_HOSTILE_IN_PRISON");
		SetBiyoState_04(proxy, param, biyo_id_2 );
		BiyoRegistCondition_block2(proxy,param,biyo_id_2);
		
	----------------------------------------------------------------------------------------------------------------
	--�r�������O����������ł�����--16064 --EN:--Bjrn Grum is dead--16064
	elseif	proxy:IsCompleteEvent(BIYO_STATE_DEAD) == true then
		print("biyo state BIYO_STATE_DEAD");
		--�����ł͒ǉ����ݒ�����Ȃ� --EN:--Do not add or set here
		
	----------------------------------------------------------------------------------------------------------------
	--�r�������O������������|���������--16065 --EN:--Bjrn Grum wants to defeat the jailer--16065
	elseif	proxy:IsCompleteEvent(BIYO_STATE_TARGET_ENEMY) == true then
		print("biyo state BIYO_STATE_TARGET_ENEMY");
		SetBiyoState_05(proxy, param, biyo_id_2 );
		BiyoRegistCondition_block2(proxy,param,biyo_id_2);
		
	----------------------------------------------------------------------------------------------------------------
	--�r�������O�������t�P���I����Ė������ĐQ����--16066 --EN:--Bjrn Grum is sleeping satisfied after the counterattack is over--16066
	elseif	proxy:IsCompleteEvent(BIYO_STATE_END_OF_STRIKES_BACK) == true then
		print("biyo state BIYO_STATE_END_OF_STRIKES_BACK");
		if flag == true then
			SetBiyoState_06(proxy, param, biyo_id_2 );
		else
			SetBiyoState_06Init(proxy, param, biyo_id_2 );		
		end
		BiyoRegistCondition_block2(proxy,param,biyo_id_2);
		
	----------------------------------------------------------------------------------------------------------------
	--�r�������O�������G��(���)���--16067 --EN:--Bjrngurm is hostile (wall)--16067
	elseif	proxy:IsCompleteEvent(BIYO_STATE_HOSTILE_IN_RAMPART) == true then
		print("biyo state BIYO_STATE_HOSTILE_IN_RAMPART");
		SetBiyoState_07(proxy, param, biyo_id_2 );
		BiyoRegistCondition_block2(proxy,param,biyo_id_2);
		
	----------------------------------------------------------------------------------------------------------------
	--�r�������O����������3��T�����--16068 --EN:--Bjrn Grum exploring Royal Castle 3--16068
	elseif	proxy:IsCompleteEvent(BIYO_STATE_SEARCH_3) == true then
		print("biyo state BIYO_STATE_SEARCH_3");
		SetBiyoState_08(proxy, param, biyo_id_3 );
		BiyoRegistCondition_block3(proxy,param,biyo_id_3);
		
	----------------------------------------------------------------------------------------------------------------
	--�r�������O���������̌���|���Ė������--16069 --EN:--Bjrngurm defeats the King's Sword and is satisfied--16069
	elseif	proxy:IsCompleteEvent(BIYO_STATE_KING_OF_SWORD_KILL) == true then
		print("biyo state BIYO_STATE_KING_OF_SWORD_KILL");
		if flag == true then
			SetBiyoState_09(proxy, param, biyo_id_3 );
		else
			SetBiyoState_09Init(proxy, param, biyo_id_3 );
		end
		BiyoRegistCondition_block3(proxy,param,biyo_id_3);
		
	----------------------------------------------------------------------------------------------------------------
	--�r�������O�������G��(���̌��̕���)���--16070 --EN:--Bjrngurm is hostile (King's Sword Room)--16070
	elseif	proxy:IsCompleteEvent(BIYO_STATE_HOSTILE_IN_KING_ROOM) == true then
		print("biyo state BIYO_STATE_HOSTILE_IN_KING_ROOM");
		SetBiyoState_10(proxy, param, biyo_id_3 );
		BiyoRegistCondition_block3(proxy,param,biyo_id_3);
		
	----------------------------------------------------------------------------------------------------------------
	--�r�������O���������̌��̕����ŐQ����--16071 --EN:--Bjrngurm sleeping in the King's Sword Room--16071
	elseif	proxy:IsCompleteEvent(BIYO_STATE_KING_ROOM_DOWN) == true then
		print("biyo state BIYO_STATE_KING_ROOM_DOWN");
		SetBiyoState_11(proxy, param, biyo_id_3 );
		BiyoRegistCondition_block3(proxy,param,biyo_id_3);
		
	----------------------------------------------------------------------------------------------------------------
	--�r�������O�������򗳂̒��Ɛ키���--16072 --EN:--Bjrngurm fighting against the wyvern chief--16072
	elseif	proxy:IsCompleteEvent(BIYO_STATE_BATTLE_FLY_DRAGON) == true then
		print("biyo state BIYO_STATE_BATTLE_FLY_DRAGON");
		SetBiyoState_12(proxy, param, biyo_id_4 );
		BiyoRegistCondition_block4(proxy,param,biyo_id_4);
		
	----------------------------------------------------------------------------------------------------------------
	--�r�������O�������Β��ɖ߂肽�����--16073 --EN:--Bjrngurm wants to return to the stone pillar--16073
	elseif	proxy:IsCompleteEvent(BIYO_STATE_RETURN_TO_STONE_PILLAR) == true then
		print("biyo state BIYO_STATE_RETURN_TO_STONE_PILLAR");
		SetBiyoState_13(proxy, param, biyo_id_4 );
		BiyoRegistCondition_block4(proxy,param,biyo_id_4);
		
	----------------------------------------------------------------------------------------------------------------
	--�r�������O�������Β��ɂ�����--16074 --EN:--Bjrn Grum in stone pillar--16074
	elseif	proxy:IsCompleteEvent(BIYO_STATE_WAIT_M1) == true then
		print("biyo state BIYO_STATE_WAIT_M1");
		
	----------------------------------------------------------------------------------------------------------------
	--�r�������O�������G��(�Β�)���--16075 --EN:--Bjrn Grum is hostile (stone pillar) state--16075
	elseif	proxy:IsCompleteEvent(BIYO_STATE_HOSTILE_IN_STONE_PILLAR) == true then
		print("biyo state BIYO_STATE_HOSTILE_IN_STONE_PILLAR");
		
	----------------------------------------------------------------------------------------------------------------
	--�r�������O�������G��(�Q�[�g�O)���--16076 --EN:--Bjrn Grum is hostile (before the gate)--16076
	elseif	proxy:IsCompleteEvent(BIYO_STATE_HOSTILE_IN_GATE_FRONT) == true then
		print("biyo state BIYO_STATE_HOSTILE_IN_GATE_FRONT");
		SetBiyoState_16(proxy, param, biyo_id_4 );
		BiyoRegistCondition_block4(proxy,param,biyo_id_4);
		
	----------------------------------------------------------------------------------------------------------------
	--�r�������O�������������Ȃ����--16077 --EN:--Bjorn Grum is no more--16077
	elseif	proxy:IsCompleteEvent(BIYO_STATE_EXIT) == true then
		print("biyo state BIYO_STATE_EXIT");
	end
	
	print("BiyoCheck end");
end

--[[44444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444
---------------------------------------����������Q�r�������O����������------------------------------ --EN:--������Castle 2 Bjrn Grum ������------------------------------
44444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444]]

function BiyoRegistCondition_block2(proxy,param,chrId)
	print("BiyoRegistCondition_block2 begin");
	if	proxy:IsCompleteEvent( BIYO_STATE_DEAD ) == false then
		if	proxy:IsCompleteEvent(BIYO_STATE_HOSTILE_IN_PRISON ) == false and
			proxy:IsCompleteEvent(BIYO_STATE_HOSTILE_IN_RAMPART) == false then
			
			--��525���r�����S���œG�ɂȂ遡 --EN:-- �� 525 �� Biyo becomes an enemy in prison ��
			if proxy:IsCompleteEvent( 525 ) == false then
				--proxy:OnCharacterTotalDamage( 525 , 622 , LOCAL_PLAYER , 100 , "OnEvent_525" , once );
				proxy:OnCharacterTotalRateDamage( 525, 622, LOCAL_PLAYER, NPC_ANGRY_Rate, "OnEvent_525", once );
			end
			
			--��526���r������ǂœG�ɂȂ遡 --EN:-- �� 526 �� Biyo becomes an enemy at the castle wall ��
			if proxy:IsCompleteEvent( 526 ) == false then
				--proxy:OnCharacterTotalDamage( 526 , 622 , LOCAL_PLAYER , 100 , "OnEvent_526" , once );
				proxy:OnCharacterTotalRateDamage( 526, 622, LOCAL_PLAYER, NPC_ANGRY_Rate, "OnEvent_526", once );
			end
		end

		--��521���r����������|���ɍs����(��b�V�X�e������Ăяo��) --EN:--��521��Biyo goes to defeat the jailer��(call from conversation system)
		if proxy:IsCompleteEvent( 521 ) == false then
				proxy:LuaCall( 521 , 0 , "OnEvent_521" , once );--��b�V�X�e������Ăяo���ꍇ��param=0���w�� --EN:--Specify param=0 when calling from the conversation system
		end
		--��522���r�����S�����ŐQ�遡(��b�V�X�e������Ăяo��) --EN:--��522��Byo sleeps in prison�� (call from conversation system)
		if proxy:IsCompleteEvent( 522 ) == false then
				proxy:LuaCall( 522 , 0 , "OnEvent_522" , once );--��b�V�X�e������Ăяo���ꍇ��param=0���w�� --EN:--Specify param=0 when calling from the conversation system
		end

		--��527���r�����S�� --EN:-- �� 527 �� Biyo died ��
		if proxy:IsCompleteEvent( 527 ) == false then
			proxy:OnCharacterDead(527,622,"OnEvent_527",once);
		end
		
		--��530���r�����t�P�ɖ������ĐQ�遡(��b�V�X�e������Ăяo��) --EN:--��530��Biyo is satisfied with the counterattack and goes to bed��(call from conversation system)
		proxy:LuaCall( 530, 0, "OnEvent_530", everytime );--��b�V�X�e������Ăяo���ꍇ��param=0���w�� --EN:--Specify param=0 when calling from the conversation system
	end
	print("BiyoRegistCondition_block2 end");
end


----------------------------------------------------------------------------------------------------------------
--�r�������O�������S���Ɏ������--16060 --EN:--Bjrngurm in prison--16060
function SetBiyoState_01(proxy,param,chrId)
	print("SetBiyoState_01 begin");
	ValidCharactor( proxy, chrId );
	print("SetBiyoState_01 end");
end

----------------------------------------------------------------------------------------------------------------
--�r�������O������������Ă���Ċ��ӏ��--16061 --EN:--Grateful state for Bjrn Grum's release--16061
function SetBiyoState_02(proxy,param,chrId)
	print("SetBiyoState_02 begin");
	ValidCharactor( proxy, chrId );
	proxy:SetTeamType( chrId , TEAM_TYPE_BattleFriend );
	print("SetBiyoState_02 end");
end

----------------------------------------------------------------------------------------------------------------
--�r�������O�������S���ŐQ�Ă�����--16062 --EN:--Bjrngurm sleeping in prison--16062
function SetBiyoState_03(proxy,param,chrId)
	print("SetBiyoState_03 begin");
	--���̌������Ɏ���ł��� --EN:--King's sword is already dead
	if	proxy:IsCompleteEvent(4360) == true then
		print("SetBiyoState_03 ���̌�������ł���̂Ŕ�ы�"); --EN:print("SetBiyoState_03 The king's sword is dead, so skip");
		--�򗳂̒��̏�Ԃ�����ł���Ƃ� --EN:--When the state of the wyvern chief is dead
		if	proxy:IsCompleteEvent(TYO_STATE_DEAD) == true then
			print("SetBiyoState_03 �򗳂̒�������ł���̂ŁA�������Ȃ���Ԃ�"); --EN:print("SetBiyoState_03 Since the chief of the wyvern is dead");
			SetNpcStateFlag( proxy, param, biyo_flag_list, BIYO_STATE_EXIT );
			proxy:SetEventFlag( 529, true);
		else
			print("SetBiyoState_03 �򗳂̒��������Ă���̂ŁA�򗳂̒��Ɛ키��Ԃ�"); --EN:print("SetBiyoState_03 Since the chief of the wyvern is alive, enter the state to fight with the chief of the wyvern");
			SetNpcStateFlag( proxy, param, biyo_flag_list, BIYO_STATE_BATTLE_FLY_DRAGON );
		end
	else
		--�r���̏�Ԃ��u����3��T���v�ɂ��� --EN:--Set Biyo's status to "Exploring the Royal Castle 3"
		SetNpcStateFlag( proxy, param, biyo_flag_list, BIYO_STATE_SEARCH_3 );
		--��Ԃ�ς����̂ōă`�F�b�N --EN:-- Check again because the state has changed
		proxy:NotNetMessage_begin();
			proxy:OnKeyTime2( SYSTEM_CHECK_POINT, "BiyoCheck", 0.0, 0, 2, once );
		proxy:NotNetMessage_begin();
	end
	print("SetBiyoState_03 end");
end

-------------------------------------------------------------------------------------------------
--�r�������O�������S���ŐQ�Ă����ԏ������`�F�b�N--16062 --EN:--Initialization check that Bjrn Grum is sleeping in prison--16062
function SetBiyoState_03Init(proxy,param,chrId)
	print("SetBiyoState_03Init begin");
	ValidCharactor( proxy, chrId );--�L���� --EN:--enable
	print("SetBiyoState_03Init end");
end

-------------------------------------------------------------------------------------------------
--�r�������O�������G��(�S��)���--16063 --EN:--Bjrn Grum is hostile (in prison)--16063
function SetBiyoState_04(proxy,param,chrId)
	print("SetBiyoState_04 begin");
	ValidCharactor( proxy, chrId );
	proxy:EraseEventSpecialEffect_2(chrId,5064);
	proxy:SetTeamType( chrId, TEAM_TYPE_AngryFriend );
	print("SetBiyoState_04 end");
end

----------------------------------------------------------------------------------------------------------------
--�r�������O������������|���������--16065 --EN:--Bjrn Grum wants to defeat the jailer--16065
function SetBiyoState_05(proxy,param,chrId)
	print("SetBiyoState_05 begin");
	ValidCharactor( proxy, chrId );
	proxy:SetTeamType( chrIs , TEAM_TYPE_BattleFriend );	
	print("SetBiyoState_05 end");
end

----------------------------------------------------------------------------------------------------------------
--�r�������O�������t�P���I����Ė������ĐQ����--16066 --EN:--Bjrn Grum is sleeping satisfied after the counterattack is over--16066
function SetBiyoState_06(proxy,param,chrId)
	print("SetBiyoState_06 begin");
	--���̌������Ɏ���ł��� --EN:--King's sword is already dead
	if	proxy:IsCompleteEvent(4360) == true then
		print("SetBiyoState_06 ���̌�������ł���̂Ŕ�ы�"); --EN:print("SetBiyoState_06 The king's sword is dead, so skip");
		--�򗳂̒��̏�Ԃ�����ł���Ƃ� --EN:--When the state of the wyvern chief is dead
		if	proxy:IsCompleteEvent(TYO_STATE_DEAD) == true then
			print("SetBiyoState_06 �򗳂̒�������ł���̂ŁA�������Ȃ���Ԃ�"); --EN:print("SetBiyoState_06 Since the chief of the wyvern is dead");
			SetNpcStateFlag( proxy, param, biyo_flag_list, BIYO_STATE_EXIT );
			proxy:SetEventFlag( 529, true);
		else
			print("SetBiyoState_06 �򗳂̒��������Ă���̂ŁA�򗳂̒��Ɛ키��Ԃ�"); --EN:print("SetBiyoState_06 Since the chief of the wyvern is alive, enter the state to fight with the chief of the wyvern");
			SetNpcStateFlag( proxy, param, biyo_flag_list, BIYO_STATE_BATTLE_FLY_DRAGON );
		end
	else
		--�r���̏�Ԃ��u����3��T���v�ɂ��� --EN:--Set Biyo's status to "Exploring the Royal Castle 3"
		SetNpcStateFlag( proxy, param, biyo_flag_list, BIYO_STATE_SEARCH_3 );
		--��Ԃ�ς����̂ōă`�F�b�N --EN:-- Check again because the state has changed
		proxy:NotNetMessage_begin();
			proxy:OnKeyTime2( SYSTEM_CHECK_POINT, "BiyoCheck", 0.0, 0, 2, once );
		proxy:NotNetMessage_begin();
	end
	print("SetBiyoState_06 end");
end

----------------------------------------------------------------------------------------------------------------
--�r�������O�������t�P���I����Ė������ĐQ���ԗp�̏�����--16066 --EN:--Initialization for the state where Bjrngurm is satisfied with the counterattack and goes to sleep--16066
function SetBiyoState_06Init(proxy,param,chrId)
	print("SetBiyoState_06Init beign");
	ValidCharactor( proxy, chrId );--�L���� --EN:--enable
	print("SetBiyoState_06Init end");
end

----------------------------------------------------------------------------------------------------------------
--�r�������O�������G��(���)���--16067 --EN:--Bjrngurm is hostile (wall)--16067
function SetBiyoState_07(proxy,param,chrId)
	print("SetBiyoState_07 begin");
	proxy:SetTeamType( chrId, TEAM_TYPE_AngryFriend );
	proxy:EraseEventSpecialEffect_2(chrId,5064);
	ValidCharactor( proxy, chrId );
	print("SetBiyoState_07 end");
end



--[[44444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444
---------------------------------------����������Q�r�������O����������------------------------------ --EN:--������Royal Castle 2 Bjrn Grum������-------------------------------
44444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444]]


--[[44444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444
---------------------------------------����������R�r�������O����������------------------------------ --EN:--������Castle 3 Bjrn Gurm������------------------------------
44444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444]]
function BiyoRegistCondition_block3(proxy,param,chrId)
	print("BiyoRegistCondition_block3 begin");
	if	proxy:IsCompleteEvent( BIYO_STATE_DEAD ) == false then
		proxy:OnCharacterDead( 1433, 627, "OnEvent_1433", once );
		if proxy:IsCompleteEvent(BIYO_STATE_HOSTILE_IN_KING_ROOM) == false then
			--proxy:OnCharacterTotalDamage( 1432, 627, LOCAL_PLAYER, 100, "OnEvent_1432", once );
			proxy:OnCharacterTotalRateDamage( 1432, 627, LOCAL_PLAYER, NPC_ANGRY_Rate, "OnEvent_1432", once );
			if proxy:IsCompleteEvent(1470) == false then
				proxy:OnRegionJustIn( 1470 , LOCAL_PLAYER , 2581 , "OnEvent_1470",once );
			end
		end
		--��1460���r����������|���ɍs����(��b�V�X�e������Ăяo��) --EN:--��1460��Biyo goes to defeat the jailer��(call from conversation system)
		proxy:NotNetMessage_begin();
			proxy:LuaCall( 1460 , 0 , "OnEvent_1460" , everytime );--��b�V�X�e������Ăяo���ꍇ��param=0���w�� --EN:--Specify param=0 when calling from the conversation system
		proxy:NotNetMessage_end();
	end
	print("BiyoRegistCondition_block3 end");
end

----------------------------------------------------------------------------------------------------------------
--�r�������O����������3��T�����--16068 --EN:--Bjrn Grum exploring Royal Castle 3--16068
function SetBiyoState_08(proxy,param,chrId)
	print("SetBiyoState_08 begin");
	proxy:EnableLogic( chrId,false );	
	ValidCharactor( proxy, chrId );	
	print("SetBiyoState_08 end");
end

----------------------------------------------------------------------------------------------------------------
--�r�������O���������̌���|���Ė������--16069 --EN:--Bjrngurm defeats the King's Sword and is satisfied--16069
function SetBiyoState_09(proxy,param,chrId)
	print("SetBiyoState_09 begin");
	ValidCharactor( proxy, chrId );
	--ValidCharactor( proxy, 627 );	
--~ 	if	proxy:IsDistance( chrId, LOCAL_PLAYER, 20 ) == false then
--~ 		proxy:Warp( chrId, 2580 );
--~ 	end
	
	print("SetBiyoState_09 Param3 = ",param:GetParam3() );
	--�|�C���g���Ⴄ�ꍇ�͓��ɉ������Ȃ� --EN:--If the points are different, do nothing
	if	param:GetParam3() == 2590 then
		print("SetBiyoState_09 Param return end");
		return;
	end

	--�򗳂̒�������ł��邩�H --EN:--Is the wyvern chief dead?
	if	proxy:IsCompleteEvent(TYO_STATE_DEAD) == true then
		print("SetBiyoState_09 �򗳂̒�������ł���̂ŁA�������Ȃ���Ԃ�"); --EN:print("SetBiyoState_09 The wyvern chief is dead, so it's no longer there");
		SetNpcStateFlag( proxy, param, biyo_flag_list, BIYO_STATE_EXIT );
		proxy:SetEventFlag( 1462, true );
		proxy:OnKeyTime2( SYSTEM_CHECK_POINT, "BiyoCheck", 0.0, 0, 2, once );
	else
		print("SetBiyoState_09 �򗳂̒��������Ă���̂ŁA�򗳂̒��Ɛ키��Ԃ�"); --EN:print("SetBiyoState_09 Since the chief of the wyvern is alive, enter the state to fight with the chief of the wyvern");
		SetNpcStateFlag( proxy, param, biyo_flag_list, BIYO_STATE_BATTLE_FLY_DRAGON );
		proxy:OnKeyTime2( SYSTEM_CHECK_POINT, "BiyoCheck", 0.0, 0, 2, once );
	end
	
	print("SetBiyoState_09 end");
end

----------------------------------------------------------------------------------------------------------------
--�r�������O���������̌���|���Ė�����ԗp�̏�����--16069 --EN:--Bjrn Grum defeated King's Sword and initialized for satisfaction--16069
function SetBiyoState_09Init(proxy,param,chrId)
	print("SetBiyoState_09Init begin");
	ValidCharactor( proxy, chrId );
	print("SetBiyoState_09Init end");
end

----------------------------------------------------------------------------------------------------------------
--�r�������O�������G��(���̌��̕���)���--16070 --EN:--Bjrngurm is hostile (King's Sword Room)--16070
function SetBiyoState_10(proxy,param,chrId)
	print("SetBiyoState_10 begin");
	ValidCharactor( proxy, chrId );
	--proxy:Warp( chrId, 2580 );
	proxy:SetTeamType( chrId, TEAM_TYPE_AngryFriend );
	proxy:EraseEventSpecialEffect_2(chrId,5064);
	print("SetBiyoState_10 end");
end

----------------------------------------------------------------------------------------------------------------
--�r�������O���������̌��̕����ŐQ����--16071 --EN:--Bjrngurm sleeping in the King's Sword Room--16071
function SetBiyoState_11(proxy,param,chrId)
	print("SetBiyoState_11 begin");
	print("SetBiyoState_11 end");
end

--[[44444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444
---------------------------------------����������R�r�������O����������------------------------------ --EN:--������Royal Castle 3Bjorn Grum������------------------------------
44444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444]]


--[[44444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444
---------------------------------------����������S�r�������O����������------------------------------ --EN:--������Royal Castle 4Bjrn Gurm������------------------------------
44444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444]]
function BiyoRegistCondition_block4(proxy,param,chrId)
	print("BiyoRegistCondition_block4 begin");
	if	proxy:IsCompleteEvent( BIYO_STATE_HOSTILE_IN_GATE_FRONT) == false then
		--proxy:OnCharacterTotalDamage( 1711, chrId, LOCAL_PLAYER, 100, "OnEvent_1711", once );
		proxy:OnCharacterTotalRateDamage( 1711, chrId, LOCAL_PLAYER, NPC_ANGRY_Rate, "OnEvent_1711", once );
	end
	
	--��1717���r�����Q�遡(��b�V�X�e������Ăяo��) --EN:-- �� 1717 �� Biyo sleeps �� (call from the conversation system)
	proxy:LuaCall( 1717, 0, "OnEvent_1717", everytime );--��b�V�X�e������Ăяo���ꍇ��param=0���w�� --EN:--Specify param=0 when calling from the conversation system
	
	--��1790���򗳂̏����r�������O�����ɋ����� --EN:--��1790��Tell Bjrngrum information about the flying dragon
	proxy:OnRegistFunc( 1790, "Condition_1790", "dummy", 2, once );

	proxy:OnCharacterDead( 1712, chrId, "OnEvent_1712", once );

	print("BiyoRegistCondition_block4 end");
end

----------------------------------------------------------------------------------------------------------------
--�r�������O�������򗳂̒��Ɛ키���--16072 --EN:--Bjrngurm fighting against the wyvern chief--16072
function SetBiyoState_12(proxy,param,chrId)
	print("SetBiyoState_12 begin");
	if	proxy:IsCompleteEvent( TYO_STATE_DEAD ) == true then
		SetNpcStateFlag(proxy, param, biyo_flag_list, BIYO_STATE_EXIT);
		proxy:SetEventFlag( 1716, true );
		proxy:OnKeyTime2(SYSTEM_CHECK_POINT, "BiyoCheck", 0.0, 0, 2, once);
	end
	ValidCharactor( proxy, chrId );
	print("SetBiyoState_12 end");
end

----------------------------------------------------------------------------------------------------------------
--�r�������O�������Β��ɖ߂肽�����--16073 --EN:--Bjrngurm wants to return to the stone pillar--16073
function SetBiyoState_13(proxy,param,chrId)
	print("SetBiyoState_13 begin");
	ValidCharactor( proxy, chrId );
	print("SetBiyoState_13 end");
end


----------------------------------------------------------------------------------------------------------------
--�r�������O�������G��(�Q�[�g�O)���--16076 --EN:--Bjrn Grum is hostile (before the gate)--16076
function SetBiyoState_16(proxy,param,chrId)
	print("SetBiyoState_16 begin");
	ValidCharactor( proxy, chrId );
	proxy:SetTeamType( chrId, TEAM_TYPE_AngryFriend );
	proxy:EraseEventSpecialEffect_2(chrId,5064);
	print("SetBiyoState_16 end");
end
--[[44444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444
---------------------------------------����������S�r�������O����������------------------------------ --EN:--������Royal Castle 4Bjorn Grum������-------------------------------
44444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444]]


--[[-----------------------------------------------------------------------------------------------
---------------------------------------�������Β��r�������O����������------------------------------ --EN:--������Stone Pillar Bjrn Gurm������------------------------------
-----------------------------------------------------------------------------------------------]]

----------------------------------------------------------------------------------------------------------------
--�r�������O�������Β��ɂ�����--16074 --EN:--Bjrn Grum in stone pillar--16074
function SetBiyoState_14(proxy,param,chrId)
	print("SetBiyoState_14 begin");
	print("SetBiyoState_14 end");
end

----------------------------------------------------------------------------------------------------------------
--�r�������O�������G��(�Β�)���--16075 --EN:--Bjrn Grum is hostile (stone pillar) state--16075
function SetBiyoState_15(proxy,param,chrId)
	print("SetBiyoState_15 begin");
	print("SetBiyoState_15 end");
end

--[[-----------------------------------------------------------------------------------------------
---------------------------------------�������Β��r�������O����������------------------------------ --EN:--������ Stone Pillar Bjrn Grum ������------------------------------------------
-----------------------------------------------------------------------------------------------]]


--[[-----------------------------------------------------------------------------------------------------------------------------------------
	�r�������O�����֘A�@�����܂� --EN:Bjrn Grum Related So far
-----------------------------------------------------------------------------------------------------------------------------------------]]


--[[-----------------------------------------------------------------------------------------------------------------------------------------
	�򗳂��ő��֘A�@�������� --EN:Hiryu's relatives start here
-----------------------------------------------------------------------------------------------------------------------------------------]]

--��236���򗳂��ő��̕\���ؑ� --EN:-- �� 236 �� Display switching of Hiryu's relatives
--��807���򗳂��ő��̕\���ؑ� --EN:-- �� 807 �� Display switching of Hiryu's relatives
function HiryuKenzokuCheck(proxy,param)
	print("HiryuKenzokuCheck begin");
--����(�ő�)�C�x���g�֘A������ --EN:-- �� Wyvern (kin) event-related initialization

	--������Ԃ��Z�b�g(��Ԃ����ݒ�̏ꍇ�A�w�肵����Ԃ��Z�b�g����) --EN:--Set the initial state (if the state is not set, set the specified state)
	SetFirstNpcStateFlag( proxy , param , kenzoku_flag_list , KENZOKU_STATE_WARNING );
	
	--local regionId	   = param:GetParam3();--�̈�̃C�x���gID --EN:--Region Event ID
	local block_id		= param:GetParam2();
	local kenzoku_id_1 = 301;--����P�̔򗬂��ő� --EN:--Flying family of Royal Castle 1
	local kenzoku_id_2 = 110;--����Q�̔򗬂��ő� --EN:--Flying family of royal castle 2
	
	local kenzoku_block1_acid_list = { 190, 191, 199, 221, 230, 231, 232, 233, 234};
	local kenzoku_block2_acid_list = { 805, 800, 801, 802, 803, 804, 806};
	
	proxy:AddFieldInsFilter(kenzoku_id_1);
	proxy:AddFieldInsFilter(kenzoku_id_2);
	
	--��U�S�������Ă��� --EN:-- Erase all of them for now
	InvalidCharactor(proxy,kenzoku_id_1);
	InvalidCharactor(proxy,kenzoku_id_2);
	
	--�Ď�����U�S�폜 --EN:--Delete all monitors once
	DeleteConditionList(proxy,kenzoku_block1_acid_list);
	DeleteConditionList(proxy,kenzoku_block2_acid_list);
	
	--�펞�o�b�N���[�hOFF --EN:--Always back read OFF
	proxy:SetAlwayEnableBackread_forEvent( kenzoku_id_1, false );
	proxy:SetAlwayEnableBackread_forEvent( kenzoku_id_2, false );
	
	--�����X�V���� --EN:--Cancel forced update
	LuaFunc_NormalOmission( proxy, kenzoku_id_1 );
	LuaFunc_NormalOmission( proxy, kenzoku_id_2 );
	
	--�򗳂��ő��������Ă��� --EN:--Hiryu's relatives are alive
	if	proxy:IsCompleteEvent(KENZOKU_2_STATE_DEAD) 			== false and
		proxy:IsCompleteEvent(KENZOKU_STATE_DEAD) 				== false then
		
		--����P�p�̃`�F�b�N�|�C���g���H --EN:--Is it a checkpoint for Royal Castle 1?
		if	block_id == 0 then
			
			--��35��QWC�ɂ��򗳂̖����� --EN:--��35��Disabling flying dragons with QWC
			if	proxy:IsCompleteEvent(35) == false then
				--�P�ނł͖��� --EN:--not withdrawal
				if proxy:IsCompleteEvent( KENZOKU_STATE_ESCAPE ) == false then
					--������ --EN:--Initialization
					proxy:SetDisableGravity( kenzoku_id_1 , true );--�d��OFF --EN:--Gravity off
					proxy:EnableLogic( kenzoku_id_1 , false );--�v�lOFF --EN:--Thinking OFF
					proxy:SetSuperArmor( kenzoku_id_1 , true );--�_���[�W���[�V���������Ȃ� --EN:--No damage motion
					proxy:SetDeadMode( kenzoku_id_1, true);--�򗳂͎��ȂȂ��ݒ�(���ɂ����ɂȂ�����P�ނ���) --EN:--Set so that flying dragons don't die (withdraw if they're about to die)
					proxy:SetAlwayEnableBackread_forEvent( kenzoku_id_1, true );
					LuaFunc_ForceOmission(proxy, kenzoku_id_1 );
					proxy:ForcePlayLoopAnimation( kenzoku_id_1 , 0 );--�x�����Ă���A�j�����[�v�Đ� --EN:-- Alert animation loop playback
					if proxy:IsClient() == false then
						proxy:RequestForceUpdateNetwork(kenzoku_id_1);
					end
					ValidCharactor( proxy, kenzoku_id_1 );
					
					--����P�򗳊Ǘ��p�A�N�V����ID:199(�C�x���g�Ŏ��R�Ɏg����A�N�V����ID) --EN:--Ojo 1 Flying Dragon Management Action ID: 199 (action ID that can be used freely in the event)
					SingleReset( proxy, 199 );
					if	proxy:IsClient() == false then
						--���o�[���䂩��Ă�����j�~���߁A�����łȂ���Βʏ�̑��ɂ����Ԃ� --EN:--If the lever is attracted, give up blocking, otherwise go to the state of being in a normal nest
						if	proxy:IsCompleteEvent( 0 ) == true then
							SetNpcStateFlag( proxy, param, kenzoku_flag_list, KENZOKU_STATE_WARNING_AND_LEVER );
						else
							SetNpcStateFlag( proxy, param, kenzoku_flag_list, KENZOKU_STATE_WARNING );
						end
						
					end
					
					--��234����(�ő�)�̓P�ފĎ�(25%�ȉ��œP��)�� --EN:--�� 234 �� Wyvern withdrawal monitoring (withdrawal at 25% or less) ��
					SingleReset( proxy, 234 );
					proxy:NotNetMessage_begin();
						proxy:OnCharacterHP( 234 , kenzoku_id_1 , "OnEvent_234" , 0.25 , once );
						proxy:LuaCall( 234, 2, "OnEvent_234_1", everytime );
					proxy:NotNetMessage_end();
					
					if	proxy:IsCompleteEvent( 234 ) == false then					
						if	proxy:IsClient() == false then
							proxy:NotNetMessage_begin();
							proxy:OnKeyTime2( 199, "OnEvent_199", 0.0, 0, 2, once );
							proxy:NotNetMessage_end();
						end
						
						proxy:LuaCall( 199, 1, "OnEvent_199_default", everytime );
						proxy:LuaCall( 221, 1, "OnEvent_221_1", everytime );
						proxy:LuaCall( 221, 2, "OnEvent_221_2", everytime );
						proxy:LuaCall( 190, 1, "OnEvent_190_1", everytime );
						proxy:LuaCall( 190, 2, "OnEvent_190_2", everytime );
						proxy:LuaCall( 191, 1, "OnEvent_191_1", everytime );
						proxy:LuaCall( 191, 2, "OnEvent_191_2", everytime );
						proxy:LuaCall( 230, 1, "OnEvent_230_1", everytime );
						proxy:LuaCall( 230, 2, "OnEvent_230_2", everytime );
						proxy:LuaCall( 231, 1, "OnEvent_231_1", everytime );
						proxy:LuaCall( 231, 2, "OnEvent_231_2", everytime );
						proxy:LuaCall( 232, 1, "OnEvent_232_1", everytime );
						proxy:LuaCall( 232, 2, "OnEvent_232_2", everytime );
					end
				end
			end
		--����Q�p�̃`�F�b�N�|�C���g���H --EN:--A checkpoint for Ojo 2?
		elseif	block_id == 1 then
		--elseif	regionId == 2390 or regionId == 2391 then
			proxy:SetAlwayEnableBackread_forEvent( kenzoku_id_2, true );
			LuaFunc_ForceOmission(proxy, kenzoku_id_2 );
			--�򗳂̃A�j���Đ��̃g���K�[(�ŏ����炸���ƂƂ�ł���) --EN:--Hiryu's animation playback trigger (always jumping from the beginning)
			if proxy:IsClient() == false then
				--�z�X�g�̔򗳃A�j�����[�v�J�n --EN:-- Host Hiryu anime loop start
				proxy:NotNetMessage_begin();
					proxy:OnKeyTime2( 800 , "OnEvent_800" , 0.0 , 0 , 1 , once );
				proxy:NotNetMessage_end();
				--�X�V�����̓z�X�g���Ǘ� --EN:--Update permissions are managed by the host
				--�����ł̓z�X�g�����������ƁA�l�b�g���[�N�̍��W�����̖��ŃN���C�A���g���ł̌����ڂ������Ȃ�ׁA --EN:-- Here, if the host has authority, it will look bad on the client side due to network coordinate synchronization problems, so
				--�������Œ肵�܂���B --EN:--Do not lock permissions.
				--proxy:RequestForceUpdateNetwork(kenzoku_id_2);
			end
			
			--��800���򗳂��ő��Q�����C�ɔ�щ�遡	 --EN:-- �� 800 �� Wyvern's kin 2 fly around energetically ��
			--��801���򗳂��ő��Q���̈�A���u���X�U����	 --EN:-- �� 801 �� Wyvern's kin 2 breath attack on area A ��
			--��802���򗳂��ő��Q���̈�B���u���X�U���� --EN:-- �� 802 �� Wyvern's kin 2 breath attack on area B ��
			--��803���򗳂��ő��Q���̈�C���u���X�U����	 --EN:-- �� 803 �� Wyvern's kin 2 breath attack on area C ��
			--��804���򗳂��ő��Q���w���w���ɂȂ�Ȃ����щ�遡 --EN:--��804��Flying dragon kin 2 flies around while becoming herohero��
			--��805���򗳂��ő��Q���w���w���ɂȂ遡 --EN:-- �� 805 �� Hiryu's kin 2 becomes hero hero ��
			--��806���򗳂��ő��Q�����ʁ�(���ۂɂ͎��ɑ҂����) --EN:-- �� 806 �� Hiryu's kin 2 dies �� (actually waiting to die)
			
			--���򗳃A�j���̓����Đ��p�� --EN:--��For synchronous playback of flying dragon animation��
			proxy:LuaCall( 800 , 1 , "OnEvent_800_syncro_anime"   , everytime );--�ҋ@ --EN:--stand-by
			proxy:LuaCall( 800 , 2 , "OnEvent_800_2_syncro_anime" , everytime );--�ҋ@2 --EN:--Wait 2
			proxy:LuaCall( 800 , 3 , "OnEvent_800_3_syncro_anime" , everytime );--���S�ҋ@ --EN:--wait for death
			proxy:LuaCall( 801 , 1 , "OnEvent_801_syncro_anime" , everytime );--�u���XA --EN:--Breath A
			proxy:LuaCall( 802 , 1 , "OnEvent_802_syncro_anime" , everytime );--�u���XB --EN:--Breath B
			proxy:LuaCall( 803 , 1 , "OnEvent_803_syncro_anime" , everytime );--�u���XC --EN:--Breath C
			proxy:LuaCall( 804 , 1 , "OnEvent_804_syncro_anime" , everytime );--�w���w�� --EN:--hero hero
			proxy:LuaCall( 806 , 1 , "OnEvent_806_syncro_anime" , everytime );--���S		 --EN:--death
			--[[
			if proxy:IsCompleteEvent( 805 ) == false then
				proxy:OnCharacterHP( 805 , kenzoku_id_2 , "OnEvent_805" , 0.5 , once );
			end
			]]
			if proxy:IsCompleteEvent( 806 ) == false then
				proxy:OnCharacterHP( 806 , kenzoku_id_2 , "OnEvent_806" , 0.01 , once );
			end

			
			proxy:EnableLogic( kenzoku_id_2, false );
			ValidCharactor( proxy, kenzoku_id_2 );
		end
	end
	
	print("HiryuKenzokuCheck end");
	
	--����P�̒��̕`��𐧌����܂� --EN:--Limit the drawing of the head of the castle 1
	print("HiryuOsa DrawCheck�@begin"); --EN:print("HiryuOsa DrawCheck begin");
	if block_id == 0 then
		if	proxy:IsCompleteEvent(35) == false then
			if 	proxy:IsCompleteEvent( TYO_STATE_DEAD ) == false and	--����łȂ� --EN:--not dead
				proxy:IsCompleteEvent( TYO_STATE_ESCAPE ) == false then		--�P�ނ��ĂȂ� --EN:--not withdrawn
				--�L�� --EN:--valid
				ValidCharactor(proxy,300);
				print("�L�꒷�L�����ł�"); --EN:print("Square length is active");
			else
				print("�L�꒷�@���S�Ȃ̂Ŗ������ł�"); --EN:print("Square manager: disabled because he is dead");
				InvalidCharactor(proxy,300);
			end
		else
			print("�L�꒷�@QWC�Ŗ������ł�"); --EN:print("Square length: disabled in QWC");
			InvalidCharactor(proxy,300);
		end
	else
		--���� --EN:--invalid
		InvalidCharactor(proxy,300);
		print("�L�꒷�u���b�N�O�������ł�") --EN:print("Invalid outside square length block")
	end
	print("HiryuOsa DrawCheck�@end"); --EN:print("HiryuOsa DrawCheck end");
end




--[[-----------------------------------------------------------------------------------------------------------------------------------------
	�򗳂��ő��֘A�@�����܂� --EN:So far related to Hiryuu's relatives
-----------------------------------------------------------------------------------------------------------------------------------------]]


--[[-----------------------------------------------------------------------------------------------------------------------------------------
	�򗳂̒��֘A�@�������� --EN:Hiryu no Naga-related From here
-----------------------------------------------------------------------------------------------------------------------------------------]]


function HiryuOsaCheck(proxy,param)
	print("HiryuOsaCheck begin");
	
	--������Ԃ��Z�b�g(��Ԃ����ݒ�̏ꍇ�A�w�肵����Ԃ��Z�b�g����) --EN:--Set the initial state (if the state is not set, set the specified state)
	SetFirstNpcStateFlag( proxy , param , tyo_flag_list , TYO_STATE_WARNING_AISLE );
	SetFirstNpcStateFlag( proxy , param , tyo1_flag_list , TYO_STATE_SLEEPING );
	
	proxy:DeleteEvent(220);
	proxy:DeleteEvent(235);
	proxy:DeleteEvent(1770);

	--InvalidCharactor(proxy,300);
	InvalidCharactor(proxy,501);
	if	proxy:IsCompleteEvent(TYO_STATE_DEAD)	== true then
		print("HiryuOsaCheck state check end");
		return;
	end
	
	--�펞�o�b�N���[�hOFF --EN:--Always back read OFF
	proxy:SetAlwayEnableBackread_forEvent( 300, false );
	proxy:SetAlwayEnableBackread_forEvent( 501, false );
	
	--�����X�V���� --EN:--Cancel forced update
	LuaFunc_NormalOmission( proxy, 300 );
	LuaFunc_NormalOmission( proxy, 501 );
	
		
	--����P�̔򗳂̒� --EN:--Chief of Wyvern of Royal Castle 1
	--QWC����`�F�b�N --EN:--QWC Judgment Check
	if	proxy:IsCompleteEvent(35) == false then
		if proxy:IsCompleteEvent(TYO_STATE_ESCAPE) == false then--�P�ނ��ĂȂ� --EN:--not withdrawn
			if 	proxy:IsCompleteEvent( TYO_STATE_DEAD ) == false then
				--ValidCharactor(proxy, 300 );
				proxy:SetAlwayEnableBackread_forEvent( 300, true );
				LuaFunc_ForceOmission(proxy, 300 );
				--����P�̔򗳂̒� --EN:--Chief of Wyvern of Royal Castle 1
				proxy:PlayLoopAnimation(300,7000);
				proxy:EnableLogic(300, false);
				proxy:Warp( 300, 2055 );
				--��220����(��)���Q�Ă��遡 --EN:-- �� 220 �� Wyvern (Long) is sleeping ��
				SingleReset(proxy, 220);
				proxy:OnRegionIn( 220 , LOCAL_PLAYER , 2130 , "OnEvent_220" , everytime );
						
				--��235����(��)�̎��S�Ď��� --EN:-- �� 235 �� Wyvern (Lord) death watch ��
				proxy:NotNetMessage_begin();
					--proxy:OnCharacterDead( 235 , 300 , "OnEvent_235" , once );
					proxy:OnCharacterHP( 235 , 300 , "OnEvent_235" , 0.01 , once );
				proxy:NotNetMessage_end();
			end
		end
	end
	

	--����S�̔򗳂̒� --EN:--Chief of Wyvern of Royal Castle 4
	if 	proxy:IsCompleteEvent( 4480 ) ==false and --�{�X�������Ă���Ƃ� --EN:-- when the boss is alive
		proxy:IsCompleteEvent( TYO_STATE_DEAD ) == false then --��������łȂ��� --EN:--when the chief is not dead
		ValidCharactor(proxy, 501 );
		
		--DeleteEvent�ŏ�����Ă��܂��̂őދ� --EN:--Remove because it will be deleted by DeleteEvent
		if proxy:IsCompleteEvent( 1560 ) == false then--�o��|�������Ă��Ȃ������� --EN:--If you haven't seen the appearance police drama
		
			InvalidCharactor( proxy , 501 );--�򗳂��Ȃ� --EN:--There is no Hiryu
			
			--���o�p(?)��OBJ�𖳌���(�`�楓�����OFF)���Ă��� --EN:--Invalidate (draw/hit OFF) OBJ for production (?)
			proxy:SetDrawEnable( 1720 , false );
			proxy:SetColiEnable( 1720 , false );
			
			proxy:SetDrawEnable( 1721 , false );
			proxy:SetColiEnable( 1721 , false );
			
			proxy:SetDrawEnable( 1710 , false );
			proxy:SetColiEnable( 1710 , false );
			
			proxy:SetDrawEnable( 1711 , false );
			proxy:SetColiEnable( 1711 , false );
		else
		
			--���򗳂��Đ�����A�j���̔���p�g���K�[(����or�O���C�̂�)�� --EN:--��Trigger for judging animation played by Hiryu (survival or gray only)��
			if proxy:IsClient() == false then
				proxy:NotNetMessage_begin();
					proxy:OnKeyTime2( 1590 , "OnEvent_1590" , 0.0 , 0 , 1 , once );
				proxy:NotNetMessage_end();
			end
			
			--���o�p(?)��OBJ��L����/���������� --EN:--Enable/disable OBJ for staging (?)
			proxy:SetDrawEnable( 1720 , true );
			proxy:SetColiEnable( 1720 , true );
			
			proxy:SetDrawEnable( 1721 , true );
			proxy:SetColiEnable( 1721 , true );
			
			proxy:SetDrawEnable( 1700 , false );
			proxy:SetColiEnable( 1700 , false );
			
			proxy:SetDrawEnable( 1701 , false );
			proxy:SetColiEnable( 1701 , false );
		end
		--������ --EN:--Initialization
		proxy:SetDisableGravity( 501 , true );--�d��OFF --EN:--Gravity off
		proxy:EnableLogic( 501 , false );--�v�lOFF --EN:--Thinking OFF
		proxy:SetSuperArmor( 501 , true );--�_���[�W���[�V���������Ȃ� --EN:--No damage motion
		proxy:SetDeadMode(501, true);--�򗳂͎��ȂȂ��ݒ�(���ɂ����ɂȂ�����P�ނ���) --EN:--Set so that flying dragons don't die (withdraw if they're about to die)
		proxy:SetAlwayEnableBackread_forEvent( 501, true );
		LuaFunc_ForceOmission(proxy, 501 );
		
		--��1770���򗳂̒���������ԁ� --EN:--�� 1770 �� Wyvern chief is in suspended animation ��
		if	proxy:IsCompleteEvent( 1770 ) == false then
			proxy:OnCharacterHP( 1770 , 501 , "OnEvent_1770" , 0.01 , once );
		end
		
	end
	print("HiryuOsaCheck end");
end

--[[-----------------------------------------------------------------------------------------------------------------------------------------
	�򗳂̒��֘A�@�����܂� --EN:So far related to Hiryu no Naga
-----------------------------------------------------------------------------------------------------------------------------------------]]




--��60���~�����_���S������ --EN:-- �� 60 �� Miralda death processing ��
function OnEvent_60(proxy, param)
	print("OnEvent_60 begin");
	print("�~�����_�͎��S���܂����B"); --EN:print("Miralda is dead.");
	proxy:SetEventFlag( 60, true );
	print("OnEvent_60 end");
end

--��62���u���b�N�~�����_���S�� --EN:-- �� 62 �� Black Miralda death ��
function OnEvent_62(proxy,param)
	print("OnEvent_62 begin");
	proxy:SetEventFlag(62, true);
	print("OnEvent_62 end");
end

--��15635���~�����_���̎��̂�����ׂ��� --EN:--�� 15635 �� Miralda Black's corpse examined ��
function OnEvent_15635(proxy,param)
	print("OnEvent_15635 begin");
	proxy:SetEventFlag( 15635 , true );
	print("OnEvent_15635 end");
end

--��86���~�����_��b�p�t���OON�� --EN:--��86��Miralda Conversation Flag ON��
function OnEvent_86(proxy,param)
	print("OnEvent_86 begin");
	proxy:SetEventFlag( 86,true );
	print("OnEvent_86 end");
end

--��15605���~�����_�̎��̒��ׂ��� --EN:--�� 15605 �� Examined Miralda's corpse ��
function OnEvent_15605(proxy,param)
	print("OnEvent_15605 begin");
	proxy:SetEventFlag( 15605 , true );
	print("OnEvent_15605 end");
end

------------------------------
--�z�ꕺ�m�V���b�v�̏�ԕω�-- --EN:--Slave Soldier Shop Status Change--
------------------------------
--���z�ꕺ�m������1�œG�΂��遥-- --EN:--��Slave soldiers are hostile in the royal castle 1��--
function OnEvent_341(proxy, param)
	print("OnEvent_341 begin");

	--���W�b�NOn --EN:--Logic On
	proxy:EnableLogic( 691, true );
	
	--�z�ꕺ�m�̏�Ԃ�G��(����1)�ɂ��� --EN:--Change slave soldier status to hostile (royal castle 1)
	SetNpcStateFlag(proxy, param, DOREISOL_SHOP_Flag_list, DOREISOL_SHOP_HOSTILE01);
	--�z�ꕺ�m�̃`�[���^�C�v��ύX���� --EN:--Change slave soldier team type
	proxy:SetTeamType( 691, TEAM_TYPE_AngryFriend );

	--�t���O�𗧂Ă� --EN:-- flag
	proxy:SetEventFlag( 341, true );
	
	print("OnEvent_341 end");
end
--��-------------------------��-- --EN:--��----------��--


--���z�ꕺ�m�����S����(����1)��-- --EN:--�� A slave soldier dies (Castle 1) ��--
function OnEvent_342(proxy, param)
	print("OnEvent_342 begin");

	--�z�ꕺ�m�̏�Ԃ��u���S�v�ɕς��� --EN:-- Change slave soldier status to "dead"
	SetNpcStateFlag( proxy, param, DOREISOL_SHOP_Flag_list, DOREISOL_SHOP_DEAD );
	
	--�t���O�𗧂Ă� --EN:-- flag
	proxy:SetEventFlag( 342, true );
	
	--�G�ɍ���ēG�΂�ʂ�z���Ď��S�����肦��̂ŁA�����ł��폜 --EN:--Because it is possible to die by being scraped by the enemy and passing through the hostility, it is also deleted here
	--���񂾂�G�΂ɂ͂Ȃ�Ȃ��̂ō폜 --EN:--Deleted because it won't be hostile if you die
	proxy:DeleteEvent( 341 );
	proxy:DeleteEvent( 760 );
	proxy:DeleteEvent( 1441 );

	print("OnEvent_342 end");
end

--��-------------------------��-- --EN:--��----------��--


--[[���z�ꕺ�m�����S����(����3)��-- --EN:--[[��Slave soldiers die (Castle 3)��--
function OnEvent_1441(proxy, param)
	print("OnEvent_1441 begin");

	--�z�ꕺ�m�̏�Ԃ��u���S�v�ɕς��� --EN:-- Change slave soldier status to "dead"
	SetNpcStateFlag( proxy, param, DOREISOL_SHOP_Flag_list, DOREISOL_SHOP_DEAD );
	
	--�t���O�𗧂Ă� --EN:-- flag
	proxy:SetEventFlag( 1441, true );
	
	--�G�ɍ���ēG�΂�ʂ�z���Ď��S�����肦��̂ŁA�����ł��폜 --EN:--Because it is possible to die by being scraped by the enemy and passing through the hostility, it is also deleted here
	--���񂾂�G�΂ɂ͂Ȃ�Ȃ��̂ō폜 --EN:--Deleted because it won't be hostile if you die
	proxy:DeleteEvent( 341 );
	proxy:DeleteEvent( 760 );
	proxy:DeleteEvent( 1441 );

	print("OnEvent_1441 end");
end

--��-------------------------��--]] --EN:--��----------��--]]

--[[
function OnEvent_343(proxy, param) proxy:LuaCallStart(781, 1); end
function OnEvent_344(proxy, param) proxy:LuaCallStart(781, 1); end
function OnEvent_345(proxy, param) proxy:LuaCallStart(781, 1); end
function OnEvent_780(proxy, param) proxy:LuaCallStart(781, 1); end
]]


function OnEvent_781(proxy, param)
	print("OnEvent_781 begin");
	print("JustInCheckPoint");
	
	local DoreiShop01_id = 691;
	local DoreiShop02_id = 623;
	local DoreiShop03_id = 679;
	
	local DoreiShopBlock1_acid_list = {340,341,342};
	local DoreiShopBlock2_acid_list = {760,761,762};
	local DoreiShopBlock3_acid_list = {1440,1441};
	
	--��U3�̂Ƃ������� --EN:--All three disappear once
	InvalidCharactor(proxy,DoreiShop01_id);
	InvalidCharactor(proxy,DoreiShop02_id);
	InvalidCharactor(proxy,DoreiShop03_id);
	
	if proxy:IsClient() == false then
		proxy:RequestForceUpdateNetwork( DoreiShop01_id);
		proxy:RequestForceUpdateNetwork( DoreiShop02_id);
		proxy:RequestForceUpdateNetwork( DoreiShop03_id);
	end
	
	--�u���b�N�̊Ď����폜 --EN:--remove block watcher
	DeleteConditionList(proxy,DoreiShopBlock1_acid_list);
	DeleteConditionList(proxy,DoreiShopBlock2_acid_list);
	DeleteConditionList(proxy,DoreiShopBlock3_acid_list);
	
	
	--��肠����������Ԃ�ݒ� --EN:-- Set the initial state for now
	SetFirstNpcStateFlag( proxy, param, DOREISOL_SHOP_Flag_list, DOREISOL_SHOP_SELL01 );
	
	
	--�z�ꕺ�m������2�Ɉړ����� --EN:--Slave soldiers move to Royal Castle 2
	if proxy:IsCompleteEvent( DOREISOL_SHOP_SELL01 ) == true then
		print("DoreiShop NowState DOREISOL_SHOP_SELL01");
		SetDoreiShopState01(proxy, param);
		RegistConditionBlock01(proxy,param);

	--�z�ꕺ�m������1�œG�� --EN:--Slave Soldiers Hostile in Royal Castle 1
	elseif proxy:IsCompleteEvent( DOREISOL_SHOP_HOSTILE01 ) == true then
		print("DoreiShop NowState DOREISOL_SHOP_HOSTILE01");
		SetDoreiShopState02(proxy, param);
		RegistConditionBlock01(proxy,param);

	--�z�ꕺ�m�����S���� --EN:--A slave soldier died
	elseif proxy:IsCompleteEvent( DOREISOL_SHOP_DEAD ) == true then
		print("DoreiShop NowState DOREISOL_SHOP_DEAD");
		SetDoreiShopState03(proxy, param);
		RegistConditionBlock01(proxy,param);

	--�z�ꕺ�m������3�Ɉړ����� --EN:--Slave soldiers move to Royal Castle 3
	elseif proxy:IsCompleteEvent( DOREISOL_SHOP_SELL02 ) == true then
		print("DoreiShop NowState DOREISOL_SHOP_SELL02");
		SetDoreiShopState04(proxy, param);
		RegistConditionBlock02(proxy,param);

	--�z�ꕺ�m������2�œG�΂��Ă��� --EN:--Slave soldiers are hostile in the royal castle 2
	elseif proxy:IsCompleteEvent( DOREISOL_SHOP_HOSTILE02 ) == true then
		print("DoreiShop NowState DOREISOL_SHOP_HOSTILE02");
		SetDoreiShopState05(proxy, param);
		RegistConditionBlock02(proxy,param);

	--�z�ꕺ�m���̔����Ă��� --EN:--sold by slave soldiers
	elseif proxy:IsCompleteEvent( DOREISOL_SHOP_SELL03 ) == true then
		print("DoreiShop NowState DOREISOL_SHOP_SELL03");
		SetDoreiShopState06(proxy, param);
		RegistConditionBlock03(proxy,param);

	--�z�ꕺ�m������3�œG�΂��Ă��� --EN:--Slave soldiers are hostile in the royal castle 3
	elseif proxy:IsCompleteEvent( DOREISOL_SHOP_HOSTILE03 ) == true then
		print("DoreiShop NowState DOREISOL_SHOP_HOSTILE03");
		SetDoreiShopState07(proxy, param);
		RegistConditionBlock03(proxy,param);
	end

	print("OnEvent_781 end");
end

--���z�ꕺ�m���̔����Ă���(����1)��----------------------------------------- --EN:--�� Sold by Slave Soldiers (Castle 1) ��----------------------------------- ------
function SetDoreiShopState01( proxy, param )
	--�t�@�����N�X�������Ă��� --EN:--the phalanx is alive
	if proxy:IsCompleteEvent( 4096 ) == false then
		ValidCharactor(proxy,691);--����1�ɂ���z�ꕺ�m��L���� --EN:--Enable Slave Soldiers in Castle 1
	
	--�t�@�����N�X������ł��� --EN:--the phalanx is dead
	else
		print("DoreiShop NowState DOREISOL_SHOP_SELL01 > Chenge to DOREISOL_SHOP_SELL02");
		InvalidBackRead(proxy,691);--����1�ɂ���z�ꕺ�m�𖳌��� --EN:--Nullify slave soldiers in Royal Castle 1
		ValidCharactor(proxy,623);--����2�ɂ���z�ꕺ�m��L���� --EN:--Enable Slave Soldiers in Royal Castle 2
		
		--���W�b�NOFF�ɂ��� --EN:--Turn off the logic
		proxy:EnableLogic( 623, false );
		
		--�z�ꕺ�m�̏�Ԃ��u�̔�(����2)�v�ɕς��� --EN:-- Change the status of slave soldiers to "Sale (Castle 2)"
		SetNpcStateFlag( proxy, param, DOREISOL_SHOP_Flag_list, DOREISOL_SHOP_SELL02 );
	end
end
--��-----------------------------��----------------------------------------- --EN:--��-----------------------------��----------------- --------------------


--���z�ꕺ�m���G�΂��Ă���(����1)��------------------------- --EN:--��The slave soldiers are hostile (Castle 1)��----------------------------
function SetDoreiShopState02( proxy, param )
	ValidCharactor(proxy,691);--����1�ɂ���z�ꕺ�m��L���� --EN:--Enable Slave Soldiers in Castle 1
	--�z�ꕺ�m�̃`�[���^�C�v��ύX���� --EN:--Change slave soldier team type
	proxy:SetTeamType( 691, TEAM_TYPE_AngryFriend );
end
--��-----------------------------��------------------------- --EN:--��-----------------------------��----------------- --------


--���z�ꕺ�m�����S����(����1)��------------------------------------- --EN:--�� A slave soldier died (Castle 1) ��-------------------------------------
function SetDoreiShopState03( proxy, param )
	InvalidBackRead(proxy,691);--����1�ɂ���z�ꕺ�m�𖳌��� --EN:--Nullify slave soldiers in Royal Castle 1
	InvalidBackRead(proxy,623);--����2�ɂ���z�ꕺ�m�𖳌��� --EN:--Disable slave soldiers in Royal Castle 2
	InvalidBackRead(proxy,679);--����3�ɂ���z�ꕺ�m�𖳌��� --EN:--Nullify slave soldiers in Royal Castle 3
end
--��-------------------------��------------------------------------- --EN:--��------------------------��--------------------- ----------------


--���z�ꕺ�m���̔����Ă���(����2)��----------------------------------------- --EN:--�� Sold by Slave Soldiers (Castle 2) ��---------------------------------- ------
function SetDoreiShopState04( proxy, param )
	--���̏��������Ă��� or �G���A�{�X�����j���Ă��Ă��Ȃ� or ���s�̖傪�J���Ė��� --EN:--The king's shield is alive or the area boss has not been defeated or the capital gate is not open
	if 	proxy:IsCompleteEvent( 4224 ) == false or
		proxy:IsCompleteEvent( 8035 ) == false or
		proxy:IsCompleteEvent( 571) == false then
		ValidCharactor(proxy,623);--����2�ɂ���z�ꕺ�m��L���� --EN:--Enable Slave Soldiers in Royal Castle 2
		InvalidBackRead(proxy,691);--����1�ɂ���z�ꕺ�m�𖳌��� --EN:--Nullify slave soldiers in Royal Castle 1
	else
		print("DoreiShop NowState DOREISOL_SHOP_SELL02 > Chenge to DOREISOL_SHOP_SELL03");
		InvalidBackRead(proxy,691);--����1�ɂ���z�ꕺ�m�𖳌��� --EN:--Nullify slave soldiers in Royal Castle 1
		InvalidBackRead(proxy,623);--����2�ɂ���z�ꕺ�m�𖳌��� --EN:--Disable slave soldiers in Royal Castle 2
		ValidCharactor(proxy,679);--����3�ɂ���z�ꕺ�m��L���� --EN:--Enable Slave Soldiers in Castle 3
		
		--���W�b�NOFF�ɂ��� --EN:--Turn off the logic
		proxy:EnableLogic( 679, false );
		
		--�z�ꕺ�m�̏�Ԃ��u�̔�(����3)�v�ɕς��� --EN:-- Change slave soldier status to "Sale (Castle 3)"
		SetNpcStateFlag( proxy, param, DOREISOL_SHOP_Flag_list, DOREISOL_SHOP_SELL03 );
	end
end
--��-----------------------------��----------------------------------------- --EN:--��-----------------------------��----------------- --------------------


--���z�ꕺ�m���G�΂��Ă���(����2)��------------------------- --EN:--��The slave soldiers are hostile (Castle 2)��------------------------
function SetDoreiShopState05( proxy, param )
	ValidCharactor(proxy,623);--����2�ɂ���z�ꕺ�m��L���� --EN:--Enable Slave Soldiers in Royal Castle 2
	InvalidBackRead(proxy,691);--����1�ɂ���z�ꕺ�m�𖳌��� --EN:--Nullify slave soldiers in Royal Castle 1
	--�z�ꕺ�m�̃`�[���^�C�v��ύX���� --EN:--Change slave soldier team type
	proxy:SetTeamType( 623, TEAM_TYPE_AngryFriend );
end
--��-----------------------------��------------------------- --EN:--��-----------------------------��----------------- --------


--���z�ꕺ�m���̔����Ă���(����3)��------------------------- --EN:--�� Sold by Slave Soldiers (Castle 3) ��-------------------------
function SetDoreiShopState06( proxy, param )
	ValidCharactor(proxy,679);--����3�ɂ���z�ꕺ�m��L���� --EN:--Enable Slave Soldiers in Castle 3
	InvalidBackRead(proxy,691);--����1�ɂ���z�ꕺ�m�𖳌��� --EN:--Nullify slave soldiers in Royal Castle 1
	InvalidBackRead(proxy,623);--����2�ɂ���z�ꕺ�m�𖳌��� --EN:--Disable slave soldiers in Royal Castle 2
end
--��-----------------------------��------------------------- --EN:--��-----------------------------��----------------- --------


--���z�ꕺ�m���G�΂��Ă���(����3)��------------------------- --EN:--��The slave soldiers are hostile (Castle 3)��----------------------------
function SetDoreiShopState07( proxy, param )
	ValidCharactor(proxy,679);--����3�ɂ���z�ꕺ�m��L���� --EN:--Enable Slave Soldiers in Castle 3
	InvalidBackRead(proxy,691);--����1�ɂ���z�ꕺ�m�𖳌��� --EN:--Nullify slave soldiers in Royal Castle 1
	InvalidBackRead(proxy,623);--����2�ɂ���z�ꕺ�m�𖳌��� --EN:--Disable slave soldiers in Royal Castle 2
	--�z�ꕺ�m�̃`�[���^�C�v��ύX���� --EN:--Change slave soldier team type
	proxy:SetTeamType( 679, TEAM_TYPE_AngryFriend );
end
--��-----------------------------��------------------------- --EN:--��-----------------------------��----------------- --------


--���z�ꕺ�m�̏�ԑJ��(����1)��-------------------------------------------------------------------------------------- --EN:--�� State Transition of Slave Soldiers (Castle 1) ��------------------------------------- -------------------------------------------------
function RegistConditionBlock01(proxy, param)
	--�z�ꕺ�m������ł��Ȃ� --EN:--slave soldiers not dead
	if proxy:IsCompleteEvent( DOREISOL_SHOP_DEAD ) == false then
		--�z�ꕺ�m������1,2,3�̂�����ł��G�΂��Ă��Ȃ��ꍇ --EN:--If slave soldiers are not hostile in any of castles 1, 2, or 3
		if proxy:IsCompleteEvent( DOREISOL_SHOP_HOSTILE01 ) == false
		   and proxy:IsCompleteEvent( DOREISOL_SHOP_HOSTILE02 ) == false
		   and proxy:IsCompleteEvent( DOREISOL_SHOP_HOSTILE03 ) == false then
			--�z�X�g����̃_���[�W�Ď� --EN:--Damage monitoring from host
			--m02_00
			--proxy:OnCharacterTotalDamage( 341, 691, LOCAL_PLAYER, DoreiShop_TotalDamage, "OnEvent_341", once );
			proxy:OnCharacterTotalRateDamage( 341, 691, LOCAL_PLAYER, NPC_ANGRY_Rate, "OnEvent_341", once );
			--m02_01
			--proxy:OnCharacterTotalDamage( 760, 623, LOCAL_PLAYER, DoreiShop_TotalDamage, "OnEvent_760", once );
			proxy:OnCharacterTotalRateDamage( 760, 623, LOCAL_PLAYER, NPC_ANGRY_Rate, "OnEvent_760", once );
			--m02_02
			--proxy:OnCharacterTotalDamage( 1440, 679, LOCAL_PLAYER, DoreiShop_TotalDamage, "OnEvent_1440", once );
			proxy:OnCharacterTotalRateDamage( 1440, 679, LOCAL_PLAYER, NPC_ANGRY_Rate, "OnEvent_1440", once );
		end
		proxy:OnCharacterDead( 342, 691, "OnEvent_342", once );
	end
end
--��------------------��-------------------------------------------------------------------------------------- --EN:--��------------------��---------------------------- -------------------------------------------------- --------


--���z�ꕺ�m�̏�ԑJ��(����2)��------------------------------------------------------------------------------- --EN:--�� State Transition of Slave Soldiers (Castle 2) ��------------------------------------- ------------------------------------------
function RegistConditionBlock02(proxy, param)
	--�z�ꕺ�m������ł��Ȃ� --EN:--slave soldiers not dead
	if proxy:IsCompleteEvent( DOREISOL_SHOP_DEAD ) == false then
		--�z�ꕺ�m������1,2,3�̂�����ł��G�΂��Ă��Ȃ��ꍇ --EN:--If slave soldiers are not hostile in any of castles 1, 2, or 3
		if proxy:IsCompleteEvent( DOREISOL_SHOP_HOSTILE01 ) == false
		   and proxy:IsCompleteEvent( DOREISOL_SHOP_HOSTILE02 ) == false
		   and proxy:IsCompleteEvent( DOREISOL_SHOP_HOSTILE03 ) == false then
			--�z�X�g����̃_���[�W�Ď� --EN:--Damage monitoring from host
			--m02_00
			--proxy:OnCharacterTotalDamage( 341, 691, LOCAL_PLAYER, DoreiShop_TotalDamage, "OnEvent_341", once );
			proxy:OnCharacterTotalRateDamage( 341, 691, LOCAL_PLAYER, NPC_ANGRY_Rate, "OnEvent_341", once );
			--m02_01
			--proxy:OnCharacterTotalDamage( 760, 623, LOCAL_PLAYER, DoreiShop_TotalDamage, "OnEvent_760", once );
			proxy:OnCharacterTotalRateDamage( 760, 623, LOCAL_PLAYER, NPC_ANGRY_Rate, "OnEvent_760", once );
			--m02_02
			--proxy:OnCharacterTotalDamage( 1440, 679, LOCAL_PLAYER, DoreiShop_TotalDamage, "OnEvent_1440", once );
			proxy:OnCharacterTotalRateDamage( 1440, 679, LOCAL_PLAYER, NPC_ANGRY_Rate, "OnEvent_1440", once );
		end
		proxy:OnCharacterDead( 761, 623, "OnEvent_761", once );
	end
end
--��------------------��-------------------------------------------------------------------------------------- --EN:--��------------------��---------------------------- -------------------------------------------------- --------


--���z�ꕺ�m�̏�ԑJ��(����3)��------------------------------------------------------------------------------- --EN:--�� State Transition of Slave Soldiers (Castle 3) ��------------------------------------- ------------------------------------------
function RegistConditionBlock03(proxy, param)
	--�z�ꕺ�m������ł��Ȃ� --EN:--slave soldiers not dead
	if proxy:IsCompleteEvent( DOREISOL_SHOP_DEAD ) == false then
		--�z�ꕺ�m������1,2,3�̂�����ł��G�΂��Ă��Ȃ��ꍇ --EN:--If slave soldiers are not hostile in any of castles 1, 2, or 3
		if proxy:IsCompleteEvent( DOREISOL_SHOP_HOSTILE01 ) == false
		   and proxy:IsCompleteEvent( DOREISOL_SHOP_HOSTILE02 ) == false
		   and proxy:IsCompleteEvent( DOREISOL_SHOP_HOSTILE03 ) == false then
			--�z�X�g����̃_���[�W�Ď� --EN:--Damage monitoring from host
			--m02_00
			--proxy:OnCharacterTotalDamage( 341, 691, LOCAL_PLAYER, DoreiShop_TotalDamage, "OnEvent_341", once );
			proxy:OnCharacterTotalRateDamage( 341, 679, LOCAL_PLAYER, NPC_ANGRY_Rate, "OnEvent_341", once );
			--m02_01
			--proxy:OnCharacterTotalDamage( 760, 623, LOCAL_PLAYER, DoreiShop_TotalDamage, "OnEvent_760", once );
			proxy:OnCharacterTotalRateDamage( 760, 623, LOCAL_PLAYER, NPC_ANGRY_Rate, "OnEvent_760", once );
			--m02_02
			--proxy:OnCharacterTotalDamage( 1440, 679, LOCAL_PLAYER, DoreiShop_TotalDamage, "OnEvent_1440", once );
			proxy:OnCharacterTotalRateDamage( 1440, 679, LOCAL_PLAYER, NPC_ANGRY_Rate, "OnEvent_1440", once );
		end
		proxy:OnCharacterDead( 1441, 679, "OnEvent_1441", once );
	end
end
--��------------------��-------------------------------------------------------------------------------------- --EN:--��------------------��---------------------------- -------------------------------------------------- --------

--------------------------------------------------------------------------------------
--��85�����q��b�p�t���O���䁡 --EN:--��85��Prince Conversation Flag Control��
--------------------------------------------------------------------------------------
function OnEvent_85(proxy,param)
	print("OnEvent_85 begin");
	proxy:SetEventFlag( 85 ,true );
	print("OnEvent_85 end");
end


--------------------------------------------------------------------------------------------------------------------------------------------------------------------
--��7���G���C�e���낲�끡 --EN:-- �� 7 �� Enemy's cannonball ��
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function RegistEvent_7(proxy)
	--SingleReset( proxy, 7 );
	if	proxy:IsCompleteEvent( 7 ) == false then
		proxy:OnRegionJustIn( 7, LOCAL_PLAYER, 2006, "OnEvent_7", once );
		proxy:OnSimpleDamage( 7, 246, LOCAL_PLAYER, "OnEvent_7", once );
		proxy:EnableLogic( 246, false );
	else
		proxy:EndAnimation( 1010, 1 );
		proxy:ReconstructBreak( 1011 , 1 );
		proxy:ReconstructBreak( 1012 , 1 );
	end
end

function OnEvent_7(proxy,param)
	print("OnEvent_7 begin");
	proxy:DeleteEvent( 7 );
	proxy:PlayAnimation( 1010, 1 );
	proxy:SetObjEventCollisionFill( 1010, true );
	
	proxy:PlayAnimation( 470 , 3002 );--���m���R�� --EN:--Soldier kicks
	proxy:EnableLogic( 246, true );
	
	proxy:SetEventFlag( 7, true );
	
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 7, "OnEvent_7_1", 0.5, 0, 2, once );
	proxy:NotNetMessage_end();
	print("OnEvent_7 end");
end

function OnEvent_7_1(proxy,param)
	print("OnEvent_7_1 begin");
	proxy:OnObjectDamageHit_NoCallPlus( 7, 1010, 1, 10210, EV_HIT_CHR, 1.0, 5.0,1.0, everytime );
	
	print("OnEvent_7_1 end");
end


--------------------------------------------------------------------------------------------------------------------------------------------------------------------
--��6�����m���Ή��r�𓊂��遡 --EN:--�� 6 �� Soldiers throw Molotov cocktails ��
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ThrowFirePotRegist_b1(proxy)
	SingleReset(proxy, 6 );
	if	proxy:IsCompleteEvent( 6 ) == false then
		proxy:OnRegionJustIn( 6, LOCAL_PLAYER, 2005, "OnEvent_6", once );
		proxy:OnRegionJustIn( 6, LOCAL_PLAYER, 2004, "OnEvent_6", once );
		proxy:OnSimpleDamage( 6, 245, LOCAL_PLAYER, "OnEvent_6", once );
		proxy:EnableLogic( 245, false );
	end
end

function OnEvent_6(proxy,param)
	print("OnEvent_6 begin");
	proxy:DeleteEvent( 6 );
	proxy:SetEventFlag( 6, true );
	proxy:PlayAnimation( 245, 6060 );
	if param:GetParam2() == 245 then
		--��2�p�������m�̎��͉����Ă܂� --EN:--When the second para is a soldier, it is beaten
		proxy:EnableLogic( 245, true );
	else
		proxy:NotNetMessage_begin();
			proxy:OnKeyTime2( 6,"OnEvent_6_1",4,0,0,once);
		proxy:NotNetMessage_end();
	end
	print("OnEvent_6 end");
end

function OnEvent_6_1(proxy,param)
	print("OnEvent_6_1 begin");
	proxy:EnableLogic( 245 , true );
	print("OnEvent_6_1 end");
end

--[[
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
--��100��⾉΂ɓ˂����񂾁� --EN:-- �� 100 �� plunged into the bonfire ��
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ObjDamage(proxy,objid)
	--print(objid);
	if proxy:IsReady_Obj(objid) == true then
		proxy:OnObjectDamageHit_NoCall( 100, objid,1,10300,EV_HIT_CHR,0.5,FIREDAM_WAIT,everytime);
	end
	proxy:NotNetMessage_begin();	
		proxy:OnKeyTime2( 100 , "OnEvent_100_"..objid.."_1",FIREDAM_WAIT,0,objid+10000,once);	
	proxy:NotNetMessage_end();
end

function ObjDamage_1(proxy,objid)
	if proxy:IsReady_Obj(objid) == true then
		proxy:OnObjectDamageHit_NoCall( 100, objid,1,10300,EV_HIT_CHR,0.5,FIREDAM_WAIT,everytime);
	end
	proxy:NotNetMessage_begin();	
		proxy:OnKeyTime2( 100 , "OnEvent_100_"..objid,FIREDAM_WAIT,0,objid,once);	
	proxy:NotNetMessage_end();
end

function OnEvent_100_1180(proxy,param) ObjDamage(proxy,1180); end
function OnEvent_100_1180_1(proxy,param) ObjDamage_1(proxy,1180); end
function OnEvent_100_1181(proxy,param) ObjDamage(proxy,1181); end
function OnEvent_100_1181_1(proxy,param) ObjDamage_1(proxy,1181); end
function OnEvent_100_1182(proxy,param) ObjDamage(proxy,1182); end
function OnEvent_100_1182_1(proxy,param) ObjDamage_1(proxy,1182); end
function OnEvent_100_1183(proxy,param) ObjDamage(proxy,1183); end
function OnEvent_100_1183_1(proxy,param) ObjDamage_1(proxy,1183); end
function OnEvent_100_1185(proxy,param) ObjDamage(proxy,1185); end
function OnEvent_100_1185_1(proxy,param) ObjDamage_1(proxy,1185); end
function OnEvent_100_1186(proxy,param) ObjDamage(proxy,1186); end
function OnEvent_100_1186_1(proxy,param) ObjDamage_1(proxy,1186); end
]]

-----------------------------------------------------------------------------
--���������g�J�Q�C�x���g --EN:-- �� �� Crystal lizard event
-----------------------------------------------------------------------------
--�{�X���j���̃g�J�Q���Z�b�g�p --EN:--For lizard reset when defeating boss
function ResetTokage(proxy)
	print("ResetTokage");
	--proxy:SetEventFlag(120,false);
	--proxy:SetEventFlag(590,false);
	--proxy:SetEventFlag(592,false);
	--proxy:SetEventFlag(1090,false);
	--proxy:SetEventFlag(1680,false);	
	--proxy:SetEventFlag(1682,false);	
	--proxy:SetEventFlag(1684,false);
	AddEventCounter(proxy,0);
	AddEventCounter(proxy,1);
	AddEventCounter(proxy,2);
	AddEventCounter(proxy,3);
	AddEventCounter(proxy,4);
	AddEventCounter(proxy,5);
	AddEventCounter(proxy,6);
end

-----------------------------------------------------------------------------
--��120�������g�J�Q�C�x���g1 --EN:-- �� 120 �� Crystal Lizard Event 1
-----------------------------------------------------------------------------
function OnEvent_120(proxy,param)
	print("OnEvent_120 begin");
	proxy:SetEventFlag( 120, true);
	proxy:DeleteEvent( 120 );
	print("OnEvent_120 end");
end


-----------------------------------------------------------------------------
--��201�����Y��̔��𒴂��� --EN:-- �� 201 �� Beyond the door of the execution ground
-----------------------------------------------------------------------------
function OnEvent_201(proxy,param)
	print("OnEvent_201 begin");
	proxy:SetEventFlag(201,true);
	print("OnEvent_201 end");
end


function OnEvent_450_In(proxy,param)
	print("OnEvent_450_In begin");
	proxy:SetDrawEnable( 300,false );
	proxy:SetDrawEnable( 301,false );
	print("OnEvent_450_In end");
end

function OnEvent_450_Out(proxy,param)
	print("OnEvent_450_Out begin");
	proxy:SetDrawEnable( 300,true );
	proxy:SetDrawEnable( 301,true );
	print("OnEvent_450_Out end");
end


-----------------------------------------------------------------------------
--��8����ʕ��m�Ή��r������ --EN:-- �� 8 �� General soldier Throw Molotov cocktail
-----------------------------------------------------------------------------
function OnEvent_8(proxy,param)
	if proxy:IsCompleteEvent( 8 ) == false then
		print("OnEvent_8 begin");
		proxy:SetEventFlag( 8 , true );
		proxy:EnableLogic( 247 , true );
		proxy:PlayAnimation( 247 , 6060 );
		print("OnEvent_8 end");
	end	
end

--��납��PC������ --EN:--PC came from behind
function OnEvent_9(proxy,param)
	proxy:DeleteEvent( 8 );
	proxy:EnableLogic( 247 , true );
	proxy:ResetThink( 247 );
end
