
--------------------------------------------------------------------------------------
--�}�b�v�ǂݍ��ݎ��ɓǂ܂�鏉���������� --EN:--Initialization process read when reading the map ��
--------------------------------------------------------------------------------------
function Initialize_m06_02_00_00(proxy)
	print("Initialize_m06_02_00_00 begin");
-----------------------------------------------------------------------------------------
--�{�X�֘A --EN:--Boss related
-----------------------------------------------------------------------------------------
--��1050���{�X�����ɓ��遡 --EN:-- �� 1050 �� Enter the boss room ��
	
	--���{�X�������Ă���Ƃ������C�x���g�o�^ --EN:-- Event registration only when the mid-boss is alive
	if proxy:IsCompleteEvent( 6400 ) == false then
	
		--�\���̂Ƃ��͈�x�ڂɃ{�X�����ɓ���p�̃C�x���g�𖈉�o�^���������̂ŁA�Ή�����t���O��OFF�ɂ���B --EN:-- When soloing, we want to register the event for entering the boss room for the first time every time, so turn off the corresponding flag.
		SingleReset(proxy, 1050);
		
		--�������A�j���Đ��p�̊J�n�n���h��(���񁨕���) --EN:--�� Start handler for synchronous animation playback (turning �� walking)
		proxy:LuaCall( 1051, 1, "OnEvent_1051_1", everytime );
		--��2��ڈȍ~�Ƀ{�X�����ɓ��邽�߂̃C�x���g�z�M�p --EN:--��For event delivery to enter the boss room after the second time
		proxy:LuaCall( 1051 , 5 , "OnEvent_1050_GO_TO_IN" , everytime );
		--���t���O�Z�b�g(�����p) --EN:--��flag set (for synchronization)
		proxy:LuaCall( 1051 , 6 , "OnEvent_1050_flag_set" , everytime );

		--�N�����{�X�O�����܂��ʉ߂��Ă��Ȃ� --EN:--Someone hasn't passed through the boss front door yet
		if proxy:IsCompleteEvent( 1050 ) == false then
		
			--(�Z�b�V��������)�{�X�O�̖��@�ǂ��ŏ��ɒʂ��̂͐����̐l���� --EN:--(During the session) Only survivors can pass through the magic wall in front of the boss first
			local possible_chr_type = ATTR_HOST + ATTR_LIVE + ATTR_GREY;
			
			proxy:NotNetMessage_begin();
				--��1050�����ɓ��邽�߂̃C�x���g��ǉ��� --EN:--��1050��Add an event to enter��
				proxy:OnPlayerActionInRegionAttribute( 1050, 2893, "OnEvent_1050", HELPID_GO_TO_IN, possible_chr_type, everytime );
			proxy:NotNetMessage_end();
			
		else --�O���C�S�[�X�g�ł����Ƃ��悤�ɂ���Ǝv����B --EN:--Gray ghost seems to be like that when it's done.
		
			proxy:NotNetMessage_begin();
				--��1051�����ɓ��邽�߂̃C�x���g��ǉ���--�n���h���͏�Ɠ��� --EN:--��1051��Add an event to enter inside��--The handler is the same as above
				proxy:OnPlayerActionInRegion( 1051, 2893, "OnEvent_1050", HELPID_GO_TO_IN, everytime );
			proxy:NotNetMessage_end();
		
		end
	end
	

--��1052���{�X�퓬�J�n�� --EN:-- �� 1052 �� Boss battle begins ��
	if proxy:IsCompleteEvent( 6400 ) == false then
		proxy:OnRegionJustIn( 1052 , 10000 , 2885 , "OnEvent_1052" , once );		
		proxy:OnRegionJustIn( 1053 , 10000 , 2883 , "OnEvent_1053" , once );
	end
	

--��6400���G���A�{�X���S�� --EN:-- �� 6400 �� Area Boss Death ��
	proxy:AddFieldInsFilter( 825 );
	if proxy:IsCompleteEvent( 6400 ) ==false then
		proxy:OnCharacterDead(6400, 825, "OnEvent_6400", once);
	end

	--���{�X�֘A�̏��������� --EN:--�� Boss-related initialization processing
	if proxy:IsCompleteEvent( 6400 ) ==true then
		
		--���{�X����ł���Ƃ� --EN:--��When the boss is dead
		--�{�X���Ȃ��Ȃ� --EN:--boss disappears
		InvalidBackRead( proxy , 825 );
		
		--���@�Ǐ�����(���̃}�b�v�͖��@�ǈ��) --EN:--Magic wall disappears (this map has one magic wall)
		proxy:SetColiEnable( 1993 , false );
		proxy:SetDrawEnable( 1993 , false );	

		--���@�ǂ�SFX OFF --EN:--Magic Wall SFX OFF
		proxy:InvalidSfx( 1985 , true );
		
	else
	    --���{�X�����Ă���Ƃ� --EN:--�� When the boss is alive
		if proxy:IsClient() == false  then
			proxy:EnableLogic( 825 , false );--���W�b�NOFF�őҋ@ --EN:--Wait with logic OFF
		end		
	end	
	
	
	--��6403,6404���\�E������A�v�΂Ń��[�v�� --EN:-- �� 6403, 6404 �� Get soul, warp with keystone ��
	if proxy:IsCompleteEvent( 6400 ) ==true then--�{�X������ł���Ƃ� --EN:--when the boss is dead
		
		--��(�\�E��)�A�C�e���擾�p�C�x���g�Ď��ǉ��� --EN:--�� (Soul) Added event monitoring for item acquisition��
		if proxy:IsCompleteEvent( 6403 ) == false then
			--SFX ON
			proxy:ValidSfx( 2400 );--���̗��q --EN:--Particles of light
			proxy:ValidSfx( 2401 );--�v�΂̃I�[�� --EN:--Keystone Aura
			proxy:TreasureDispModeChange2( 1980 , true ,KANAME_SFX);--���点�� --EN:-- let it shine
			proxy:OnDistanceActionAttribute( 6403 , 10000 , 1980 , "OnEvent_6403" , WarpGimmickDist_A , 10010180 , 0 , 180 , ATTR_HOST + ATTR_LIVE + ATTR_GREY, once );

			--�\�E���L���� --EN:--Soul activation
			proxy:SetDrawEnable( 1980 , true );
			proxy:SetColiEnable( 1980 , true );
			--�\�E��2�L���� --EN:--Activate Soul 2
			proxy:SetDrawEnable( 1977 , true );
			proxy:SetColiEnable( 1977 , true );

		else
			--SFX�������� --EN:--SFX disappear
			SingleReset(proxy,6404);
			proxy:InvalidSfx( 2400 , false );--���̗��q --EN:--Particles of light
			--proxy:InvalidSfx( 2401 , false );--�v�΂̃I�[�� --EN:--Keystone Aura
			proxy:TreasureDispModeChange2( 1980 , true ,KANAME_SFX);--���点�� --EN:-- let it shine
			--���v�΂Ń��[�v�p�̊Ď���ǉ��� --EN:--�� Added surveillance for warp with keystone ��
			proxy:OnDistanceActionAttribute( 6404 , 10000 , 1980 , "OnEvent_6404" , WarpGimmickDist_A , HELPID_GO_TO_SEKITYUU , 0 , 180 , ATTR_NOSESSION , everytime );
		end

	else
		--�\�E�������� --EN:--Soul Invalidation
		proxy:SetDrawEnable( 1980 , false );
		proxy:SetColiEnable( 1980 , false );
		--�\�E��2������ --EN:--Soul 2 disabled
		proxy:SetDrawEnable( 1977 , false );
		proxy:SetColiEnable( 1977 , false );
		--SFX�������� --EN:--SFX disappear
		proxy:InvalidSfx( 2400 , false );--���̗��q --EN:--Particles of light
		proxy:InvalidSfx( 2401 , false );--�v�΂̃I�[�� --EN:--Keystone Aura
	end

	--�{�X�����̏�ŗ����Ă����悤�ɁA�d��Off --EN:-- Gravity off so that the boss can stand on the spot
	proxy:SetDisableGravity( 825, true );

-----------------------------------------------------------------------------------------
--�M�~�b�N�֘A --EN:--Gimmick related
-----------------------------------------------------------------------------------------
	--�D���t�������Ƃ肠�����폜 --EN:--Remove the sewn spear for the time being
	proxy:SetDrawEnable(1400 ,false);
	proxy:SetColiEnable(1400 ,false);
	proxy:SetDrawEnable(1401 ,false);
	proxy:SetColiEnable(1401 ,false);
	proxy:SetDrawEnable(1402 ,false);
	proxy:SetColiEnable(1402 ,false);
	

--��1060�����̌����ˋ@�@�N���� --EN:-- �� 1060 �� Light sword launcher ��
	if proxy:IsCompleteEvent( 6400 ) == false then
		SingleReset(proxy,1060);
		SingleReset(proxy,1062);
	end
	if proxy:IsCompleteEvent( 1060 ) == false then
		--proxy:LuaCall(1060, 1, "OnEvent_1060", once);
		proxy:OnPlayerActionInRegionAngle( 1060 , 2410 , "OnEvent_1060", 90 , HELPID_START , once);
		proxy:OnPlayerActionInRegionAngle( 1062 , 2412 , "OnEvent_1062", 90 , HELPID_START , once); 
	end
	
--��6410���{�X�Е��D�����|������ --EN:-- �� 6410 �� Boss side stitched poly play ��
	if proxy:IsCompleteEvent( 6400 ) == false then
		SingleReset(proxy,6410);
	end
	if proxy:IsCompleteEvent( 6410 ) == false then--�|�������܂��Đ�����Ă��Ȃ���� --EN:--if the polyplay hasn't played yet
		--�|�����z�M�p --EN:--For poly drama distribution
		proxy:LuaCall(6410, 20 ,"OnEvent_6410_1",once);
		proxy:NotNetMessage_begin();
			--�|�����J�n�ɌĂ΂��n���h�� --EN:--handler called at polyplay start
			proxy:LuaCall(6410, REMO_START, "OnEvent_6410_RemoStart", once);
			--�|�����I����ɌĂ΂��n���h��(�g���K�[�N�������l�p) --EN:--Handler called after the end of the polyplay (for the person who caused the trigger)
			proxy:LuaCall(6410, REMO_FINISH, "OnEvent_6410_RemoFinish", once);
		proxy:NotNetMessage_end();
		
		--�j������̍폜 --EN:--Delete pedestal after destruction
		proxy:SetDrawEnable(1440 ,false);
		proxy:SetColiEnable(1440 ,false);
		
	else--���łɃ|�������I�����Ă����� --EN:--If the police drama has already ended
		OnEvent_6412(proxy, param);--���̌����ˋ@���f�������ւ� --EN:--Light sword launcher model replacement
		OnEvent_6413(proxy, param);--�ǃ��f�������ւ� --EN:--Wall model replacement
		--�o���X�^SFX�폜 --EN:--Remove barista SFX
		proxy:InvalidSfx(2470, false);
	end

--��1061�����̌����ˋ@�A�N���� --EN:-- �� 1061 �� Light sword launcher ��
	if proxy:IsCompleteEvent( 6400 ) == false then
		SingleReset( proxy,1061 );
		SingleReset( proxy,1063 );
	end
	if proxy:IsCompleteEvent( 1061 ) == false then
		--proxy:LuaCall(1061, 1, "OnEvent_1061", once);
		proxy:OnPlayerActionInRegionAngle( 1061 , 2411 , "OnEvent_1061" , 90, HELPID_START , once );
		proxy:OnPlayerActionInRegionAngle( 1063 , 2413 , "OnEvent_1063" , 90, HELPID_START , once );
	end

--��6411���{�X�������t���|������ --EN:-- �� 6411 �� Boss both unintentional police play ��
	if proxy:IsCompleteEvent( 6400 ) == false then
		SingleReset( proxy,6411 );
	end
	if proxy:IsCompleteEvent( 6411 ) == false then--�|����������Ă��Ȃ��Ȃ�� --EN:--If the police drama is not playing
		proxy:LuaCall(6411,20,"OnEvent_6411_1",once);
		proxy:NotNetMessage_begin();
			--�|�����J�n�ɌĂ΂��n���h�� --EN:--handler called at polyplay start
			proxy:LuaCall(6411, REMO_START, "OnEvent_6411_RemoStart", once);
			--�|�����I����ɌĂ΂��n���h��(�g���K�[�N�������l�p) --EN:--Handler called after the end of the polyplay (for the person who caused the trigger)
			proxy:LuaCall(6411, REMO_FINISH, "OnEvent_6411_RemoFinish", once);
		proxy:NotNetMessage_end();
		--OBJ1432���� --EN:--OBJ1432 disabled
		proxy:SetDrawEnable( 1432 ,false);
		proxy:SetColiEnable( 1432 ,false);	
	else--�|�������Ȃ���Ă����� --EN:--If the police drama was flowing
		--OBJ1432�L���i�͂��߂���L���j --EN:--OBJ1432 enabled (enabled from the beginning)
		--OBJ1431���� --EN:--OBJ1431 disabled
		--�o���X�^SFX�폜 --EN:--Remove barista SFX
		proxy:InvalidSfx(2471, false);
		proxy:SetDrawEnable( 1431 ,false);
		proxy:SetColiEnable( 1431 ,false);	

		--�D�������L���� --EN:--Sew spear enabled
		proxy:SetDrawEnable(1401 ,true);
		proxy:SetColiEnable(1401 ,true);
		proxy:SetDrawEnable(1402 ,true);
		proxy:SetColiEnable(1402 ,true);
	end

--��6412�����̌����ˋ@���f�������ւ��� --EN:-- �� 6412 �� Light sword launcher model replacement ��
	--(OnEvent_6410 ����A��) --EN:--(linked from OnEvent_6410)

--��6413���ǃ��f�������ւ��� --EN:-- �� 6413 �� Wall model replacement ��
	--(OnEvent_6410 ����A��) --EN:--(linked from OnEvent_6410)

--��8088���B���ɗ����t���O�𗧂Ă遡 --EN:--�� 8088 �� Raise a flag for coming to the tunnel ��
	proxy:SetEventFlag( 8088, true );

--------------------------------������QWC�C�x���g�֘A������-------------------------------- --EN:--������QWC event related ������--------------------------------
	
--��1110���O������\�������遡 --EN:-- �� 1110 �� display the gram ��
	SingleReset(proxy,1110);
	if 	proxy:IsSuccessQWC( 60140 ) == false and
		proxy:IsCompleteEvent(1114) == false then	
		proxy:SetEventFlag( 1110, true );
	end
	
	--QWC�����ɒʉ߂��������Ă���̂Ŕ�\�� --EN:--Not displayed because QWC or passage has already been established
	if proxy:IsCompleteEvent( 1110 ) == false then
		proxy:SetDrawEnable( 1433, false );
		proxy:SetColiEnable( 1433, false );
	end

--��1114���O�����ɋ߂Â����� --EN:-- �� Close to 1114 �� grams ��
	if proxy:IsCompleteEvent(1114) == false then
		if proxy:IsClient() == false then
			proxy:NotNetMessage_begin();
				proxy:OnRegionJustIn( 1114 , 10000 , 2480 , "OnEvent_1114",once);
			proxy:NotNetMessage_end();
		end
	end
		
--��1111���o�b���O���������������� --EN:--��1111��PC pulls Gram��
	if proxy:IsCompleteEvent( 1111 ) == false then
		--�z�X�g�A�����A�O���C�̂ݒ��ׂ邱�Ƃ��ł��� --EN:--Only hosts, survivors, and grays can be examined
		local possible_chr_type = ATTR_HOST + ATTR_LIVE + ATTR_GREY;
		
		proxy:OnDistanceActionAttribute( 1111 , 10000 , 1434 , "OnEvent_1111" , ItemBoxDist_A , 10010125 , 0 , ItemBoxAngle_A ,possible_chr_type, everytime ); 
		proxy:LuaCall( 1111,1,"OnEvent_1111_2",once);
		proxy:LuaCall( 1111,2,"OnEvent_1111_3",once);
		proxy:TreasureDispModeChange2( 1434, true ,KEN_SFX);
	else
		proxy:SetDrawEnable( 1434 , false );--�ЂƂ܂��`�悾��OFF --EN:--Only drawing is turned off for the time being
		proxy:SetColiEnable( 1434 , false );
	end
	
	--proxy:SetRarity( 1434, 10626 );

--------------------------------������QWC�C�x���g�֘A������-------------------------------- --EN:--������QWC event related������--------------------------------
--��??���p�j�f�[�����̓o�ꁡ�n���h���o�^ --EN:--��??��Appearance of wandering daemon��Handler registration
	proxy:NotNetMessage_begin();
		--�v���C���[���\���Ŏ��S�������ɃL�b�N����܂��B --EN:--Kicked when a player dies solo.
		proxy:LuaCall( 4000, 100, "PlayerDeath_m06_02_00_00", everytime );
		--�v���C���[�������������ɃL�b�N����܂��B --EN:--Kicked when the player is revived.
		proxy:LuaCall( 4032, 100, "PlayerRevive_m06_02_00_00", everytime );
	proxy:NotNetMessage_end();
	
	--��1120���E�B���I�E�B�X�v�� --EN:-- �� 1120 �� Will O Wisp ��
	SingleReset( proxy , 1120 );
	if proxy:IsCompleteEvent( 1120 ) == false then
		proxy:OnPlayerDistanceInTarget( 1120 , 10000 , 1441 , "OnEvent_1120",2.0,once);
		proxy:SetObjSfx( 1441 , 1 , 96001 , true );
	end
	
	--��1121���E�B���I�E�B�X�v�� --EN:-- �� 1121 �� Will O Wisp ��
	SingleReset( proxy , 1121 );
	if proxy:IsCompleteEvent( 1121 ) == false then
		proxy:OnPlayerDistanceInTarget( 1121 , 10000 , 1442 , "OnEvent_1121",2.0, once);
		proxy:SetObjSfx( 1442 ,1 , 96001 , true );
	end
	
	
	--��999999���t���[���x��̏����������C�x���g�𔭍s�� --EN:-- �� 999999 �� Generate a frame delay initialization processing event ��
	proxy:NotNetMessage_begin();
		--��0�b�づ-- --EN:--��After 0 seconds��--
		proxy:OnKeyTime2( 999992, "Second_Initialize_m06_02_00_00", 0.3, 0, 0, once );	
	proxy:NotNetMessage_end();	
	
	print("Initialize_m06_02_00_00 end");
end

--------------------------------------------------------------------------------------
--Initialize����Ă΂��A1�t���[���x��̏�����������999999 --EN:--Initialization with a delay of 1 frame, called from Initialize ��999999
--------------------------------------------------------------------------------------
--��999999���ꕔ�AInit�ł͏����ł��Ȃ��̂ŁA�c���Ă��� --EN:-- �� 999999 �� Some parts cannot be processed by Init, so leave them
function Second_Initialize_m06_02_00_00(proxy, param)
	print("Second_Initialize_m06_02_00_00 begin");

--------------------------------������QWC�C�x���g�֘A������-------------------------------- --EN:--������QWC event related ������--------------------------------
--------------------------------������QWC�C�x���g�֘A������------------------------------- --EN:--������QWC event related������----------------------------------

	print("Second_Initialize_m06_02_00_00 end");
end

--------------------------------------------------------------------------------------
--�}���`�ɂȂ������Ƀz�X�g���ᖳ�������灡���� --EN:--If you are not a host when you become multi, no
--------------------------------------------------------------------------------------
function ConnectPartyEvent(proxy)
	print("ConnectPartyEvent begin");
	print("ConnectPartyEvent end");
end




--------------------------------------------------------------------------------------
--��6400���G���A�{�X���S�� --EN:-- �� 6400 �� Area Boss Death ��
--------------------------------------------------------------------------------------
--��6400���G���A�{�X���S�� --EN:-- �� 6400 �� Area Boss Death ��
function OnEvent_6400(proxy, param)
	print("OnEvent_6400 begin");
		
	proxy:NotNetMessage_begin();
		--��6401���N���C�A���gPC���[�v���o�� --EN:--��6401��Client PC warp effect��
		proxy:OnKeyTime2( 6401, "OnEvent_6401", 0, 0, 0, once);
		--��6400_1��1�b�o�߁� --EN:--��6400_1��1 second passed��
		proxy:OnKeyTime2( 6400, "OnEvent_6400_1", 1, 0, 1, once);
		--��6402��2�b�o�߁� --EN:--��6402��2 seconds passed��
		proxy:OnKeyTime2( 6402, "OnEvent_6402", 2, 0, 2, once);
		--�}���`���U�Ď� --EN:--Multi-Dismissal Monitoring
		proxy:OnRegistFunc( 6400 ,"Check_6400_PT","OnEvent_6400_PT",0,once);
	proxy:NotNetMessage_end();
	
	proxy:SetEventFlag( 6400, 1 );
	
	--�u���b�N�N���A������ --EN:-- to block clear processing
	proxy:CustomLuaCallStart( 4050, 825 );	
	--�g�J�Q���Z�b�g --EN:-- lizard reset
	ResetTokage(proxy);
	
	--[[
	--����3�J���C���t�H���[�V���� --EN:--Castle 3 opening information
	if proxy:IsClient() == false then
		if proxy:IsCompleteEvent( 8050 ) == false then
			proxy:NotNetMessage_begin();
				print("Call to OnEent_8050");
				proxy:OnKeyTime2( 8050 , "OnEvent_8050",5.0,0,0,once);
				proxy:SetEventFlag( 8050 , true );
			proxy:NotNetMessage_end();		
		end	
	end
	]]
		
	print("OnEvent_6400 end");
end

--��6400_1�����{�X���S��1�b�� --EN:--��6400_1��1 second after death of mid-boss��
function OnEvent_6400_1(proxy, param)
	print("OnEvent_6400_1 begin");
	
	--�{�X��|���������X�V(���ɂ���ăt���O�𗧂Ă�) --EN:--update number of bosses killed (flag by number)
	GetBossFlagCount( proxy, param );
	
	--���g���t�B�[�擾���聥 --EN:--��Trophy Acquisition Judgment��
	Lua_RequestUnlockTrophy(proxy, 10);--�g���t�B�󋵂𔻒肵�A�g���t�B�擾 --EN:-- Determine the trophy situation and acquire the trophy
	
	--��(�\�E��)�A�C�e���擾�p�C�x���g�Ď��ǉ��� --EN:--�� (Soul) Added event monitoring for item acquisition��
	if proxy:IsCompleteEvent( 6403 ) == false then
	
		--�\�E���L���� --EN:--Soul activation
		proxy:SetDrawEnable( 1980 , true );
		proxy:SetColiEnable( 1980 , true );
		--�\�E��2�L���� --EN:--Activate Soul 2
		proxy:SetDrawEnable( 1977 , true );
		proxy:SetColiEnable( 1977 , true );
		
		--SFX ON
		proxy:ValidSfx( 2400 );--���̗��q --EN:--Particles of light
		proxy:ValidSfx( 2401 );--�v�΂̃I�[�� --EN:--Keystone Aura
		
		proxy:TreasureDispModeChange2( 1980 , true ,KANAME_SFX);--���点�� --EN:-- let it shine
		proxy:OnDistanceActionAttribute( 6403 , 10000 , 1980 , "OnEvent_6403" , WarpGimmickDist_A , 10010180 , 0 , 180 , ATTR_HOST + ATTR_LIVE + ATTR_GREY, once );
	else
		--�\�E��������(������������̂ť��) --EN:--Soul nullification (because it disappears when you take it...)
		proxy:SetDrawEnable( 1980 , false );
		proxy:SetColiEnable( 1980 , false );
	end

	--�B���N���A�t���OON --EN:-- Mine Clear Flag ON
	if proxy:IsLivePlayer() == true or proxy:IsGreyGhost() == true then
		proxy:SetEventFlag( 8014 , 1 );
	end	
	
	print("OnEvent_6400_1 end");
end


--����R����̕\�� --EN:--View Liberation of Royal Castle 3
function OnEvent_8050(proxy,param)
	print("OnEvent_8050 begin");
	--�C���t�H�\�� --EN:--Info display
	--�V�X�e�����b�Z�[�W --EN:--system message
	--[[
	proxy:InfomationMenu( INFOMENU_TYPE_LIST, -1, 0, -1, 1 );
	proxy:AddInfomationBuffer( 10010750 );
	]]
	proxy:RequestOpenBriefingMsgPlus(10010750,true);
	proxy:PlayTypeSE( 10000 ,SOUND_TYPE_M ,777777777 );
	print("OnEvent_8050 end");
end


--------------------------------------------------------------------------------------
--��6401���N���C�A���gPC���[�v���o�� --EN:-- �� 6401 �� Client PC warp effect ��
--------------------------------------------------------------------------------------

--��6401���N���C�A���gPC���[�v���o�� --EN:-- �� 6401 �� Client PC warp effect ��
function OnEvent_6401(proxy, param)
	print("OnEvent_6401 begin");

	if proxy:IsClient() == true then
		proxy:PlayAnimation( 10000 , 8284 );--���[�v�A�j�����Đ� --EN:-- Play warp animation
	end

	proxy:SetEventFlag( 6401 , 1 );
	
	print("OnEvent_6401 end");
end


--------------------------------------------------------------------------------------
--��6402���V���O���F���̕ǁABGM������ --EN:-- �� 6402 �� Single: Wall of Light, BGM Elimination ��
--------------------------------------------------------------------------------------

--��6402���V���O���F���̕ǁABGM������ --EN:-- �� 6402 �� Single: Wall of Light, BGM Elimination ��
function OnEvent_6402(proxy, param)
	print("OnEvent_6402 begin");

	--�{�X��p��BGM��~ --EN:--BGM stop for boss battles
	proxy:StopPointSE( 2 );

	proxy:SetEventFlag( 6402 , 1 );
	
	print("OnEvent_6402 end");
end

--�}���`���U�Ď� --EN:--Multi-Dismissal Monitoring
function Check_6400_PT(proxy)
	if proxy:IsInParty() == false then
		return true;
	end
	return false;
end

--�}���`����Ȃ� --EN:--not multiplayer
function OnEvent_6400_PT(proxy,param)
	print("OnEvent_6400_PT begin");
	--���{�X�����̑O��̖��@�ǂ�������(�S�v���C���[) --EN:--The magic walls before and after the mid-boss room disappear (all players)
	proxy:SetColiEnable( 1993 , false );
	proxy:SetDrawEnable( 1993 , false );	
	
	--���{�X�������@�ǂ�SFX�폜 --EN:--Remove the SFX of the mid-boss room magic wall
	proxy:InvalidSfx( 1985 , true );

	--���{�X�����O�̈ړ������C�x���g���폜 --EN:--Delete the movement processing event in front of the mid-boss room
	proxy:DeleteEvent( 1050 );--��l�ڂ�����Ƃ��p --EN:--For when the first person enters
	proxy:DeleteEvent( 1051 );--��l�ڈȍ~������Ƃ��p --EN:--For when the second and subsequent people enter
	proxy:DeleteEvent( 1030 );--�|�����Đ��p --EN:--For polyplay play
	proxy:DeleteEvent( 1052 );--�{�X�퓬�J�n�p	 --EN:--For boss battle start
	print("OnEvent_6400_PT end");
end




--------------------------------------------------------------------------------------
--��6403���\�E�����聡 --EN:-- �� 6403 �� Get Soul ��
--------------------------------------------------------------------------------------

function OnEvent_6403(proxy, param)
	print("OnEvent_6403 begin");
	
	--�v���C���[�̓����A�j���[�V����(true:�p�[�e�B�[�v���C���[���A�j���[�V��������) --EN:--Player synchronous animation (true: party player animated)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_PICK ) == true then--�V�����A�j��  --EN:-- new anime
		print("OnEvent_6403 end");
		return true;
	end
	
	proxy:NotNetMessage_begin();
		--0.0�b��ɃA�C�e���擾�C�x���g�𔭍s --EN:-- Issue an item acquisition event after 0.0 seconds
		proxy:OnKeyTime2( 6403, "OnEvent_6403_1", 0.0, 0, 0, once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_6403 end");
end


--��6403_1���A�C�e���擾�� --EN:-- �� 6403_1 �� item acquisition ��
function OnEvent_6403_1(proxy, param)
	print("OnEvent_6403_1 begin");

	--�A�C�e���擾�֐�--�p�����[�^10632�Q�� --EN:--item retrieval function--see parameter 10632
	proxy:GetRateItem(10632);	
	--�A�C�e���擾�֐�--�p�����[�^10678�Q�� --EN:--item retrieval function--see parameter 10678
	proxy:GetRateItem(10678);	
	--�A�C�e���擾�֐�--�p�����[�^10679�Q�� --EN:--item retrieval function--see parameter 10679
	proxy:GetRateItem(10679);	
	--�A�C�e���擾�֐�--�p�����[�^10680�Q�� --EN:--item retrieval function--see parameter 10680
	proxy:GetRateItem(10680);	
	--�A�C�e���擾�֐�--�p�����[�^10681�Q�� --EN:--item retrieval function--see parameter 10681
	proxy:GetRateItem(10681);	
	
	--�A�C�e�����擾�ς� --EN:--item already acquired
	proxy:SetEventFlag( 6403, 1 );
	
	--SFX�������� --EN:--SFX disappear
	proxy:InvalidSfx( 2400 , true );--���̗��q --EN:--Particles of light
	--proxy:InvalidSfx( 2401 , true );--�v�΂̃I�[�� --EN:--Keystone Aura
	
	if proxy:IsCompleteEvent( 8035 ) == false then
		proxy:NotNetMessage_begin();
			--�u�Ԃŕ\������ƃ��j���[����ɏo��̂ő҂� --EN:--If you display it instantly, the menu will appear first, so wait
			proxy:OnKeyTime2( 8035 , "OnEvent_8035_wait",0.5 , 0 , 1, once);			
		proxy:NotNetMessage_end();
	else
		--���v�΂Ń��[�v�p�̊Ď���ǉ��� --EN:--�� Added surveillance for warp with keystone ��
		proxy:OnDistanceActionAttribute( 6404 , 10000 , 1980 , "OnEvent_6404" , WarpGimmickDist_A , HELPID_GO_TO_SEKITYUU , 0 , 180 , ATTR_NOSESSION , everytime );
	end	

	print("OnEvent_6403_1 end");
end


--[[
	]]
--�A�C�e���擾��̃E�F�C�g --EN:--Wait after getting item
function OnEvent_8035_wait(proxy,param)
	print("OnEvent_8035_wait begin");
	proxy:NotNetMessage_begin();
		--�C���t�H���j���[��������̂�҂����� --EN:--I want to wait for the info menu to disappear
		proxy:OnRegistFunc( 8035 , "Check_8035" , "OnEvent_8035" , 1 , ocne);
	proxy:NotNetMessage_end();
	print("OnEvent_8035_wait end");
end	
--�C���t�H�҂� --EN:--Waiting for info
function Check_8035(proxy)
	if proxy:IsShowMenu_InfoMenu() == true then
		return false;
	end
	return true;
end

--�J���C���t�H�\�� --EN:--Open info display
function OnEvent_8035(proxy,param)
	print("OnEvent_8035 begin");
	proxy:NotNetMessage_begin();		
		OnEvent_8050(proxy,param);
		proxy:SetEventFlag( 8035 , true );
	proxy:NotNetMessage_end();
	--���v�΂Ń��[�v�p�̊Ď���ǉ���	 --EN:--�� Added surveillance for warp with keystone ��
	proxy:OnDistanceActionAttribute( 6404 , 10000 , 1980 , "OnEvent_6404" , WarpGimmickDist_A , HELPID_GO_TO_SEKITYUU , 0 , 180 , ATTR_NOSESSION , everytime );
	print("OnEvent_8035 end");
end



--------------------------------------------------------------------------------------
--�Β��Ƀ��[�v(�{�X�|������p)��6404 --EN:-- Warp to the stone pillar (for after defeating the boss) 6404
--------------------------------------------------------------------------------------
--��6404���Β��Ƀ��[�v�� --EN:-- �� 6404 �� Warp to the stone pillar ��
function OnEvent_6404(proxy,param)	

	if proxy:IsCompleteEvent( 6404 ) == true then
		return;
	end	

	print("OnEvent_6404 begin");
	
	proxy:RepeatMessage_begin();
		--��6404_1���I�����j���[�̊Ď��� --EN:--��6404_1��Monitor selection menu��
		proxy:OnSelectMenu(6404, "OnEvent_6404_0", 10010710, 0, 2, 1980, 2, once);			
	proxy:RepeatMessage_end();
	
	print("OnEvent_6404 end");
end

--��6404_0���I�����j���[�̊Ď��� --EN:--��6404_0��Monitor selection menu��
function OnEvent_6404_0(proxy, param)
	print("OnEvent_6404_0 begin");
	
	if proxy:IsSession() == false then
		
		proxy:PlayAnimation( 10000 , 8283 );--�v�΂ɐG���A�j�����Đ� --EN:--Play the animation that touches the keystone
		proxy:NoAnimeTurnCharactor( 10000 , 1980 ,TURNSKIP_ANGLE);
		
		proxy:NotNetMessage_begin();
			--���v�΂ɐG���A�j���Đ��I���� --EN:--��Animation touching the keystone ends��
			proxy:OnChrAnimEnd( 6404 , 10000 , 8283 , "OnEvent_6404_1" , once );
		proxy:NotNetMessage_end();
		
		proxy:SetEventFlag( 6404 , 1 );
	else
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010720, 0, 6, 1983, GEN_DIALOG_DIST, once );
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
	end
	
	print("OnEvent_6404_0 end");
end

--��6404_1���I�����j���[�̊Ď��� --EN:--��6404_1��Monitor selection menu��
function OnEvent_6404_1(proxy, param)
	print("OnEvent_6404_1 begin");
	
	proxy:SetEventFlag( 6404 , 0 );
	
	proxy:PlayAnimation( 10000 , 8284 );--�v�΂ɐG���A�j�����Đ� --EN:--Play the animation that touches the keystone
	
	proxy:SetEventFlag( 6404 , 1 );
	
	OnEvent_6404_2(proxy,param);
	
	print("OnEvent_6404_1 end");
end

--��6404_2���v�΂ɐG���A�j���Đ��I���� --EN:--��6404_2��Ends playing the animation touching the keystone��
function OnEvent_6404_2(proxy,param)	
	print("OnEvent_6404_2 begin");
	
	--�Β��֖߂��Ă�������̃t���O�𗧂Ă� --EN:--Flag the judgment of returning to the stone pillar
	proxy:SetEventFlag(8083, true);
	
	proxy:SetEventFlag( 6404 , 0 );	
	--���S�񕜗v�� --EN:-- full recovery request
	proxy:RequestFullRecover();
	proxy:WarpNextStage( 1, 0, 0, 0, 1010 );
	
	print("OnEvent_6404_2 end");
end



--------------------------------------------------------------------------------------
--�p�j�f�[�����̓o�ꁡ?? --EN:-- Appearance of the Wandering Demon ??
--------------------------------------------------------------------------------------

--���O���[�o���̎��S�Ď�����Ă΂��(�\��) --EN:--�� Called from global death watch (solo)
function PlayerDeath_m06_02_00_00(proxy, param)
	print("PlayerDeath_m06_02_00_00");
	print("PlayerDeath_m06_02_00_00");
end

--���O���[�o���̌�������������Ă΂��(�\��) --EN:--��Called from global blood letter revival (solo)
function PlayerRevive_m06_02_00_00(proxy,param)
	print("PlayerRevive_m06_02_00_00");
	print("PlayerRevive_m06_02_00_00");
end



--------------------------------------------------------------------------------------
--�{�X�����̒��ɓ��遡1050 --EN:--Enter the boss room 1050
--------------------------------------------------------------------------------------

--���C�x���g�����[�v�Ȃ̂ŁA�S�����s�[�g�ɂ��遫 --EN:--�� Since the event is a loop, repeat all ��

--��1050�����{�X�����ւ̔����J���� --EN:-- �� 1050 �� The door to the mid-boss room opens ��
function OnEvent_1050(proxy,param)
	print("OnEvent_1050 begin");

	if proxy:IsCompleteEvent( SYSTEM_ID_IGNORE ) == true then
		print("OnEvent_1050 end");
		return;
	end
	
	--�N���C�A���g�ցA�{�X�����j�~���s��ʒm --EN:--Notify client of failure to block boss room
	if proxy:IsClient() == false then
		proxy:LuaCallStart( 4068 , 1 );	
	end
	
	proxy:LuaCallStart( 1051 , 1 );--����A�j���̓����Đ� --EN:-- Synchronous playback of turning animation
	--proxy:SetEventFlag( SYSTEM_ID_IGNORE, true );
	--���d�N���V�X�e��ID���^�C���A�E�g��ݒ肵��ON�ɂ��� --EN:--Turn on multiple activation system ID by setting timeout
	proxy:SetSystemIgnore( SYSTEM_ID_IGNORE , IGNORE_TIME );
	
	--�v���t�@�C���Z�[�u�v�� --EN:--profile save request
	proxy:SaveRequest_Profile();
	
	print("OnEvent_1050 end");
end


--����A�j���̓����Đ�(ID����) --EN:-- Synchronized playback of turning animation (ID is different)
function OnEvent_1051_1(proxy,param)
	print("OnEvent_1051_1 begin");
	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		if param:IsNetMessage() == true then
			--����A�j���Đ����s���A���̏I������OnEvent_1051_2�𔭍s���� --EN:--Play the turning animation and issue OnEvent_1051_2 at the end
			proxy:TurnCharactor( 10001 + param:GetPlayID(), 2889 );
		else
			proxy:LockSession();--���[�������b�N���܂��I --EN:--lock the room!
			--����A�j���Đ����s���A���̏I������OnEvent_1051_2�𔭍s���� --EN:--Play the turning animation and issue OnEvent_1051_2 at the end
			proxy:OnTurnCharactorEnd( 1051, 10000, 2889, "OnEvent_1051_2", once );
		end
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	
	print("OnEvent_1051_1 end");
end

--����A�j���̓����Đ��I���� --EN:--After synchronous playback of turning animation ends
function OnEvent_1051_2(proxy,param)
	print("OnEvent_1051_2 begin");
	
	--�����p�����A�j���Đ� --EN:--Play walking animation for synchronization
	proxy:LuaCallStart( 4012, 1 );
	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		proxy:OnChrAnimEnd( 1051, 10000, ANIMEID_WALK, "OnEvent_1051_3", once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	
	print("OnEvent_1051_2 end");
end

--�����A�j���̓����Đ��I���� --EN:--After the synchronized playback of the walking animation ends
function OnEvent_1051_3(proxy,param)
	print("OnEvent_1051_3 begin");

	--�ŏ��̐l���{�X�����̒��ɓ���I����Ă�����A���ɔz�M����Ă���͂��Ȃ̂ŁA����������Ȃ��n���h�� --EN:--If the first person has already entered the boss room, it should have already been delivered, so no more handlers
	if proxy:IsCompleteEvent( 1050 ) == false then
		proxy:LuaCallStart( 1051 , 5 );--2��ڈȍ~�Ƀ{�X�����ɓ��邽�߂̃C�x���g�z�M�p --EN:--For event delivery to enter the boss room after the second time
		proxy:LuaCallStart( 4045 , 1 );	--�N���C�A���g�ցA�{�X�����ɓ����悤�ɂȂ������Ƃ�ʒm --EN:--Notify clients that they can now enter the boss room
		proxy:LuaCallStart( 1051 , 6 );--�t���O�Z�b�g(�����p) --EN:--flag set (for synchronization)
		Lua_MultiDoping(proxy,825);--�}���`�v���C�h�[�s���O --EN:-- Multiplayer Doping
	end

	--�v���C���[�����̒��Ɋ��S�ɂ͂������^�C�~���O�ŁA�{�X�̎v�l�����Z�b�g --EN:--Reset the boss' thoughts when the player is completely inside the door
	--�ꏊ�������ƃv���C���[��������Ȃ�����(�U�����Ă��Ȃ�) --EN:--Because you can't find the player if the location is bad (they won't attack)
	if proxy:IsLivePlayer() == true or proxy:IsGreyGhost() == true then
		proxy:ResetThink( 825 );
	end
		
	proxy:SetEventFlag( SYSTEM_ID_IGNORE, false );
	
	print("OnEvent_1051_3 end");
end


--��1050 2��ڈȍ~�Ƀ{�X�����ɓ��邽�߂̃C�x���g�z�M�p --EN:--�� 1050 For event delivery to enter the boss room after the second time
function OnEvent_1050_GO_TO_IN(proxy, param)
	print("OnEvent_1050_GO_TO_IN begin");

	proxy:NotNetMessage_begin();
		--��1051�������J���Ă���Ƃ��ɒ��ɓ��邽�߂̃C�x���g��ǉ���--�n���h���� OnEvent_1050 --EN:--��1051��Add an event to enter when the door is open��--The handler is OnEvent_1050
		proxy:OnPlayerActionInRegion( 1051, 2893, "OnEvent_1050", HELPID_GO_TO_IN, everytime );--
		
		proxy:OnKeyTime2( 1051 , "StandBy_DragonDemon",0.5,0,0,once);
	proxy:NotNetMessage_end();	
	
	print("OnEvent_1050_GO_TO_IN end");
end


--��1050 �t���O�Z�b�g(�����p) --EN:-- 1050 flag set (for synchronization)
function OnEvent_1050_flag_set(proxy, param)
	print("OnEvent_1050_flag_set begin");
		
	proxy:SetEventFlag( 1050 , 1 );
	proxy:DeleteEvent( 1050 );

	print("OnEvent_1050_flag_set end");
end



--------------------------------------------------------------------------------------
--�{�X�������o��(�퓬�J�n)��1052 --EN:--Boss begins to move (battle starts) 1052
--------------------------------------------------------------------------------------
function OnEvent_1052(proxy, param)
	print("OnEvent_1052 begin");	
	
	--�{�X���W�b�NON --EN:--Boss logic ON
	proxy:EnableLogic( 825 , true );
	
	--�ǂݍ��݃^�C�~���O�̂Ƃ�����ǉ�����Ăق����̂Ńt���O���ĂȂ� --EN:-- I want it to be added every time at the time of reading, so I don't set a flag

	--�{�X�֘A�̃C�x���g�o�^ --EN:--Boss-related event registration
	BossInit_DragonDemon(proxy, param);	
	
	print("OnEvent_1052 end");
end

--HP�Q�[�W�ABGM�Ή� --EN:--HP gauge, BGM compatible
function OnEvent_1053(proxy,param)
	print("OnEvent_1053 begin");
	--�{�X��pBGM�Đ��J�n --EN:--Start playing BGM for boss battle
	proxy:PlayPointSE( 2402, SOUND_TYPE_M, 60200000, 2 );
	--�{�X�Q�[�W�\�� --EN:-- Boss gauge display
	proxy:SetBossGauge(825, 0, 6050);	
	print("OnEvent_1053 begin");
end


--------------------------------------------------------------------------------------
--��1060�����̌����ˋ@�@�N���� --EN:-- �� 1060 �� Light sword launcher ��
--------------------------------------------------------------------------------------
--��1060�����̌����ˋ@�@�N���� --EN:-- �� 1060 �� Light sword launcher ��
function OnEvent_1060(proxy, param)
	print("OnEvent_1060 begin");
	
	proxy:SetEventFlag( 1060 , true );
	proxy:SetEventFlag( 1062 , true );
	proxy:DeleteEvent( 1060 );
	proxy:DeleteEvent( 1062 );
	
	--�v���C���[�̓����A�j���[�V����(true:�p�[�e�B�[�v���C���[���A�j���[�V��������) --EN:--Player synchronous animation (true: party player animated)
	if Luafunc_PlaySynchroAnimation( proxy, param, 8130 ) == true then
		print("OnEvent_1060 end");		
		return;
	end

	proxy:NotNetMessage_begin();
		--��6410���{�X�Е��D�����|�����ց� --EN:--��6410��Boss sewn on one side to poly play��
		proxy:OnChrAnimEnd( 6410 , 10000 , 8130 , "OnEvent_6410" , once );
	proxy:NotNetMessage_end();
	
	proxy:WarpDmy( 10000 ,1430 , 191 );	

	print("OnEvent_1060 end");
end


--------------------------------------------------------------------------------------
--��1062�����̌����ˋ@�@�N���� --EN:-- �� 1062 �� Light sword launcher ��
--------------------------------------------------------------------------------------
--��1062�����̌����ˋ@�@�N���� --EN:-- �� 1062 �� Light sword launcher ��
function OnEvent_1062(proxy, param)
	print("OnEvent_1062 begin");
	
	proxy:SetEventFlag( 1060 , true );
	proxy:SetEventFlag( 1062 , true );
	proxy:DeleteEvent( 1060 );
	proxy:DeleteEvent( 1062 );
	
	
	--�v���C���[�̓����A�j���[�V����(true:�p�[�e�B�[�v���C���[���A�j���[�V��������) --EN:--Player synchronous animation (true: party player animated)
	if Luafunc_PlaySynchroAnimation( proxy, param, 8130 ) == true then
		print("OnEvent_1062 end");		
		return;
	end

	proxy:NotNetMessage_begin();
		--��6410���{�X�Е��D�����|�����ց� --EN:--��6410��Boss sewn on one side to poly play��
		proxy:OnChrAnimEnd( 6410 , 10000 , 8130 , "OnEvent_6410" , once );
	proxy:NotNetMessage_end();	

	proxy:WarpDmy( 10000 ,1430 , 192 );	

	print("OnEvent_1062 end");
end


--------------------------------------------------------------------------------------
--��6410���{�X�Е��D�����|������ --EN:-- �� 6410 �� Boss side stitched poly play ��
--------------------------------------------------------------------------------------

--��6410���{�X�Е��D�����|������ --EN:-- �� 6410 �� Boss side sewn poly play ��
function OnEvent_6410(proxy, param)
	print("OnEvent_6410 begin");	
	--�|�����z�M --EN:--Poly drama delivery
	proxy:LuaCallStart(6410,20);	
	print("OnEvent_6410 end");
end

--�|�����Đ� --EN:--Poly play
function OnEvent_6410_1(proxy,param)
	print("OnEvent_6410_1 begin");
	proxy:StopPointSE( 2 );
	proxy:RequestRemo(60200,REMO_FLAG,6410,1);
	proxy:SetEventFlag(6410,true);
	print("OnEvent_6410_1 end");
end

--�|�����J�n�t�F�[�h --EN:--poly play start fade
function OnEvent_6410_RemoStart(proxy,param)
	print("OnEvent_6410_RemoStart begin");
	--�o���X�^SFX�폜	 --EN:--Remove barista SFX
	proxy:InvalidSfx(2470, false);
	print("OnEvent_6410_RemoStart end");
end

--�|�����I���t�F�[�h --EN:--Poly play end fade
function OnEvent_6410_RemoFinish(proxy,param)
	print("OnEvent_6410_RemoFinish begin");
	--�{�X��pBGM�Đ��J�n --EN:--Start playing BGM for boss battle
	proxy:PlayPointSE( 2402, SOUND_TYPE_M, 60299999, 2 );

	OnEvent_6412(proxy, param);--���̌����ˋ@���f�������ւ� --EN:--Light sword launcher model replacement
	OnEvent_6413(proxy, param);--�ǃ��f�������ւ� --EN:--Wall model replacement
	
	--�D�������L���� --EN:--Sew spear enabled
	proxy:SetDrawEnable(1400 ,true);
	proxy:SetColiEnable(1400 ,true);
	
	--�ҋ@�؂�ւ� --EN:-- standby switch
	ChangeWait_1(proxy,param);
	proxy:SetHp( 825 , 0.55);
	
	
	print("OnEvent_6410_RemoFinish end");
end


--------------------------------------------------------------------------------------
--��1061�����̌����ˋ@�A�N���� --EN:-- �� 1061 �� Light sword launcher ��
--------------------------------------------------------------------------------------
--��1061�����̌����ˋ@�A�N���� --EN:-- �� 1061 �� Light sword launcher ��
function OnEvent_1061(proxy, param)
	print("OnEvent_1061 begin");
	
	proxy:SetEventFlag( 1061 , true );
	proxy:SetEventFlag( 1063 , true );
	
	proxy:DeleteEvent( 1061 );
	proxy:DeleteEvent( 1063 );
	
	--�v���C���[�̓����A�j���[�V����(true:�p�[�e�B�[�v���C���[���A�j���[�V��������) --EN:--Player synchronous animation (true: party player animated)
	if Luafunc_PlaySynchroAnimation( proxy, param, 8130 ) == true then
		print("OnEvent_1061 end");		
		return;
	end

	proxy:NotNetMessage_begin();
		--��6411���{�X�����D�����|�����ց� --EN:-- �� 6411 �� Boss both sewn to the poly play ��
		proxy:OnChrAnimEnd( 6411 , 10000 , 8130 , "OnEvent_6411" , once );
	proxy:NotNetMessage_end();
	
	proxy:WarpDmy( 10000 , 1431 , 191 );
	
	print("OnEvent_1061 end");
end


--��1063�����̌����ˋ@�A�N���� --EN:-- �� 1063 �� Light sword launcher ��
function OnEvent_1063(proxy, param)
	print("OnEvent_1063 begin");
	
	proxy:SetEventFlag( 1061 , true );
	proxy:SetEventFlag( 1063 , true );
	
	proxy:DeleteEvent( 1061 );
	proxy:DeleteEvent( 1063 );
	
	--�v���C���[�̓����A�j���[�V����(true:�p�[�e�B�[�v���C���[���A�j���[�V��������) --EN:--Player synchronous animation (true: party player animated)
	if Luafunc_PlaySynchroAnimation( proxy, param, 8130 ) == true then
		print("OnEvent_1063 end");		
		return;
	end

	proxy:NotNetMessage_begin();
		--��6411���{�X�����D�����|�����ց� --EN:-- �� 6411 �� Boss both sewn to the poly play ��
		proxy:OnChrAnimEnd( 6411 , 10000 , 8130 , "OnEvent_6411" , once );
	proxy:NotNetMessage_end();
	
	proxy:WarpDmy( 10000 , 1431 , 192 );
	
	print("OnEvent_1063 end");
end


--------------------------------------------------------------------------------------
--��6411���{�X�������t���|������ --EN:-- �� 6411 �� Boss both unintentional police play ��
--------------------------------------------------------------------------------------

--��6411���{�X�������t���|������ --EN:-- �� 6411 �� Boss both unwitting polyplay ��
function OnEvent_6411(proxy, param)
	print("OnEvent_6411 begin");
	--�|�����̔z�M --EN:--Distribution of poly drama
	proxy:LuaCallStart(6411,20);
	print("OnEvent_6411 end");
end

--�|�����Đ� --EN:--Poly play
function OnEvent_6411_1(proxy,param)
	print("OnEvent_6411_1 begin");
	proxy:StopPointSE( 2 );
	proxy:RequestRemo(60201,REMO_FLAG,6411,1);
	proxy:SetEventFlag(6411,true);
	print("OnEvent_6411_1 end");
end

--�|�����J�n�̃t�F�[�h�� --EN:--At the time of the poly-play start fade
function OnEvent_6411_RemoStart(proxy,param)
	print("OnEvent_6411_RemoStart begin");	
	--�o���X�^SFX�폜 --EN:--Remove barista SFX
	proxy:InvalidSfx(2471, false);
	
	--�Ў�D���t���������� --EN:--Disable one-handed sewn spear
	proxy:SetDrawEnable(1400 ,false);
	proxy:SetColiEnable(1400 ,false);
	print("OnEvent_6411_RemoStart end");
end

--�|�����I���̃t�F�[�h�� --EN:--Fade at the end of the polyplay
function OnEvent_6411_RemoFinish(proxy,param)
	print("OnEvent_6411_RemoFinish begin");
	--�{�X��pBGM�Đ��J�n --EN:--Start playing BGM for boss battle
	proxy:PlayPointSE( 2402, SOUND_TYPE_M, 60299999, 2 );
	--OBJ1432�L�� --EN:--OBJ1432 enabled
	proxy:SetDrawEnable( 1432 ,true);
	proxy:SetColiEnable( 1432 ,true);
	
	--OBJ1431���� --EN:--OBJ1431 disabled
	proxy:SetDrawEnable( 1431 ,false);
	proxy:SetColiEnable( 1431 ,false);	
	
	--�D�������L���� --EN:--Sew spear enabled
	proxy:SetDrawEnable(1401 ,true);
	proxy:SetColiEnable(1401 ,true);
	proxy:SetDrawEnable(1402 ,true);
	proxy:SetColiEnable(1402 ,true);
	
	proxy:SetHp( 825 , 0.1);
	--�ҋ@�؂�ւ� --EN:-- standby switch
	ChangeWait_2(proxy,param);
	print("OnEvent_6411_RemoFinish end");
end



--------------------------------------------------------------------------------------
--��6412�����̌����ˋ@���f�������ւ��� --EN:-- �� 6412 �� Light sword launcher model replacement ��
--------------------------------------------------------------------------------------

--��6412�����̌����ˋ@���f�������ւ��� --EN:-- �� 6412 �� Light sword launcher model replacement ��
function OnEvent_6412(proxy, param)
	print("OnEvent_6412 begin");
	
	proxy:SetDrawEnable( 1430 , false );
	proxy:SetColiEnable( 1430 , false );
	
	proxy:SetDrawEnable( 1440 , true );
	proxy:SetColiEnable( 1440 , true );
	
	proxy:SetEventFlag( 6412 , 1 );

	print("OnEvent_6412 end");
end



--------------------------------------------------------------------------------------
--��6413���ǃ��f�������ւ��� --EN:-- �� 6413 �� Wall model replacement ��
--------------------------------------------------------------------------------------

--��6413���ǃ��f�������ւ��� --EN:-- �� 6413 �� Wall model replacement ��
function OnEvent_6413(proxy, param)
	print("OnEvent_6413 begin");
	
	proxy:SetDrawEnable( 1445 , false );
	proxy:SetColiEnable( 1445 , false );
	
	proxy:SetEventFlag( 6413 , 1 );

	print("OnEvent_6413 end");
end


--------------------------------------------------------------------------------------
--��1111���o�b�������ӂ�����聡 --EN:-- �� 1111 �� PC obtains keel crusher ��
--------------------------------------------------------------------------------------
function OnEvent_1111(proxy, param)
	if param:IsNetMessage() == false then
	print("OnEvent_1111 begin");
	proxy:NotNetMessage_begin();
	proxy:RepeatMessage_begin();
		proxy:PlayAnimation( 10000,8290);
		proxy:PlayAnimation( 1434 , 1);		
		proxy:OnKeyTime2( 1111 , "OnEvent_1111_0",0.01,0,0,once);
	proxy:RepeatMessage_end();
	proxy:NotNetMessage_end();	
	print("OnEvent_1111 end");
	end
end

function OnEvent_1111_0(proxy,param)
	print("OnEvent_1111_0 begin");
	if proxy:IsEventAnim( 10000 , 8290 ) == true then
		proxy:LuaCallStart( 1111 , 2 );
	else
		proxy:ForcePlayAnimation( 1434 , 0);	
	end
	print("OnEvent_1111_0 end");
end

function OnEvent_1111_1(proxy, param)
	print("OnEvent_1111_1 begin");
	--�A�C�e���擾�֐�--�p�����[�^10104�Q�� --EN:--item retrieval function--see parameter 10104
	proxy:GetRateItem(10626);	
	
	--�A�C�e�����擾�ς� --EN:--item already acquired
	proxy:SetEventFlag( 1111, true );
	
	--OBJ���������߂̃C�x���g�z�M --EN:--Event distribution for erasing OBJ
	proxy:LuaCallStart( 1111, 1);

	print("OnEvent_1111_1 end");
end

--��1111_2����OBJ��\���p�� --EN:-- �� 1111_2 �� For hiding the sword OBJ ��
function OnEvent_1111_2(proxy,param)
	print("OnEvent_1111_2 begin");
	--�I�u�W�F�������� --EN:--The object disappears
	proxy:SetDrawEnable( 1434, false );--�ЂƂ܂��`�悾��OFF --EN:--Only drawing is turned off for the time being
	proxy:SetColiEnable( 1434, false );--������͂���͕̂s��(����ł͂Ȃ��悤�Ȃ̂ŏ����Ȃ�) --EN:--I don't know if there is a hit (I don't delete it because it doesn't seem to be the current situation)
		
	proxy:DeleteEvent( 1111 );
	print("OnEvent_1111_2 end");
end

--�A�j���Ď����� --EN:--Anime watch sync
function OnEvent_1111_3(proxy,param)
	print("OnEvent_1111_3 begin");
	
	proxy:TreasureDispModeChange2( 1434, false ,KEN_SFX);
	--�v���C���[�̓����A�j���[�V����(true:�p�[�e�B�[�v���C���[���A�j���[�V��������) --EN:--Player synchronous animation (true: party player animated)
	if Luafunc_PlaySynchroAnimation( proxy, param, 8290 ) == true then--�V�����A�j��  --EN:-- new anime
		proxy:PlayAnimation( 1434 , 1);	
		print("OnEvent_5 end");
		return true;
	end
	
	proxy:WarpDmy( 10000 , 1434 , 191 );--�_�~�[�ʒu�փ��|�v	 --EN:--Warp to dummy position
	--�A�j�����I�������Ď��ǉ� --EN:--Add monitoring when the animation ends
	proxy:NotNetMessage_begin();
		proxy:OnChrAnimEnd( 1111 , 10000 , 8290 , "OnEvent_1111_1", once);
	proxy:NotNetMessage_end();
	
	print("OnEvent_1111_3 end");
end


--------------------------------------------------------------------------------------
--��1120���E�B���I�E�B�X�v������ --EN:-- �� 1120 �� Will O'Wisp Explosion ��
--------------------------------------------------------------------------------------
function OnEvent_1120( proxy , param )
	print("OnEvent_1120 begin");
	proxy:DeleteObjSfxEventID( 1441 );
	proxy:CastPointSpell_Horming( 400,1441, 10160 , 0,0,0,1441);
	proxy:SetEventFlag( 1120 ,true);
	print("OnEvent_1120 end");
end


--------------------------------------------------------------------------------------
--��1121���E�B���I�E�B�X�v������ --EN:-- �� 1121 �� Will O'Wisp Explosion ��
--------------------------------------------------------------------------------------
function OnEvent_1121( proxy ,param)
	print("OnEvent_1121 beign");
	proxy:DeleteObjSfxEventID( 1442 );
	proxy:CastPointSpell_Horming( 400,1442, 10160 , 0,0,0,1442);
	proxy:SetEventFlag(1121,true);
	print("OnEvent_1121 end");
end


--------------------------------------------------------------------------------------
--��1114���O�����ɋ߂Â����� --EN:-- �� 1114 �� Approached grams ��
--------------------------------------------------------------------------------------
function OnEvent_1114(proxy,param)
	print("OnEvent_1114 begin");
	proxy:SetEventFlag( 1114 , true );
	print("OnEvent_1114 end");
end
