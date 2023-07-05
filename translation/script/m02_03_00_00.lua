
--�򗳂̒��̍U���҂�����(0�ɐݒ肷���0�Ŋ��������܂����鏈�������������Ȃ��Đ��l������̂ŁA�K��0.01�ȏ��top�ɓ���Ă���Ă��������B) --EN:--Waifu's attack wait time (If you set it to 0, the process of taking the remainder after dividing by 0 will be strange and the number will be corrupted, so be sure to put 0.01 or more in top.)
HiryuOsa_AttackDelay_under	= 0.00;--�򗳂̒��̍U���̑҂����Ԃ̉��� --EN:--Lower limit of attack waiting time for wyvern chief
HiryuOsa_AttackDelay_top	= 0.01;--�򗳂̒��̍U���̑҂����Ԃ̏�� --EN:--Upper limit of waiting time for attack of wyvern chief

HiryuOsa_b4_evid			= 501;--����4�̔򗳂̒��̃C�x���gID --EN:--Oujou 4 Wyvern Chief Event ID

ElevatorTimer = 10.0;
--------------------------------------------------------------------------------------
--�}�b�v�ǂݍ��ݎ��ɓǂ܂�鏉���������� --EN:--Initialization process read when reading the map ��
--------------------------------------------------------------------------------------
function Initialize_m02_03_00_00(proxy)
	print("Initialize_m02_03_00_00 begin");
	
--��1560���򗳂̒��A�o���� --EN:-- �� 1560 �� Wyvern leader appears ��
	if proxy:IsCompleteEvent( 1560 ) == false then
		proxy:OnRegionJustIn( 1560 , LOCAL_PLAYER , 2600 , "OnEvent_1560" , everytime );
		
		proxy:NotNetMessage_begin();
			--�|�����J�n�t�F�[�h��ɌĂ΂��n���h�� --EN:--Handler called after polyplay start fade
			proxy:LuaCall(1560,REMO_START,"OnEvent_1560_RemoStart",once);
			--�|�����I����ɌĂ΂��n���h�� --EN:--Handler called after the polyplay ends
			proxy:LuaCall(1560,REMO_FINISH,"OnEvent_1560_RemoFinish",once);
			proxy:Warp(  HiryuOsa_b4_evid , 2700 );
		proxy:NotNetMessage_end();
	else
		--���o�p(?)��OBJ��L����/���������� --EN:--Enable/disable OBJ for staging (?)
		proxy:SetDrawEnable( 1720 , true );
		proxy:SetColiEnable( 1720 , true );		
		proxy:SetDrawEnable( 1721 , true );
		proxy:SetColiEnable( 1721 , true );		
		proxy:SetDrawEnable( 1710 , false );
		proxy:SetColiEnable( 1710 , false );		
		proxy:SetDrawEnable( 1711 , false );
		proxy:SetColiEnable( 1711 , false );		
		proxy:SetDrawEnable( 1700 , false );
		proxy:SetColiEnable( 1700 , false );		
		proxy:SetDrawEnable( 1701 , false );
		proxy:SetColiEnable( 1701 , false );
	end


--��1570���{�X�����ɓ��遡			 --EN:-- �� 1570 �� Enter the boss room ��
	--BossRoomIn( proxy, 4480, 1570, 1571, 2892 );--[[�O���[�o���̂��R�����g�A�E�g����Ă���]] --EN:--[[globals were commented out]]

	--���{�X�������Ă���Ƃ������C�x���g�o�^ --EN:-- Event registration only when the mid-boss is alive
	if proxy:IsCompleteEvent( 4480 ) == false then
	
		--�\���̂Ƃ��͈�x�ڂɃ{�X�����ɓ���p�̃C�x���g�𖈉�o�^���������̂ŁA�Ή�����t���O��OFF�ɂ���B --EN:-- When soloing, we want to register the event for entering the boss room for the first time every time, so turn off the corresponding flag.
		SingleReset(proxy, 1570);		
	
		--�������A�j���Đ��p�̊J�n�n���h��(���񁨕���) --EN:--�� Start handler for synchronous animation playback (turning �� walking)
		proxy:LuaCall( 1571, 1, "OnEvent_1571_1", everytime );
		--��2��ڈȍ~�Ƀ{�X�����ɓ��邽�߂̃C�x���g�z�M�p --EN:--��For event delivery to enter the boss room after the second time
		proxy:LuaCall( 1571 , 5 , "OnEvent_1570_GO_TO_IN" , everytime );
		--���t���O�Z�b�g(�����p) --EN:--��flag set (for synchronization)
		proxy:LuaCall( 1571 , 6 , "OnEvent_1570_flag_set" , everytime );
		
		--�N�����{�X�O�����܂��ʉ߂��Ă��Ȃ� --EN:--Someone hasn't passed through the boss front door yet
		if proxy:IsCompleteEvent( 1570 ) == false then
		
			--(�Z�b�V��������)�{�X�O�̖��@�ǂ��ŏ��ɒʂ��̂͐����̐l���� --EN:--(During the session) Only survivors can pass through the magic wall in front of the boss first
			local possible_chr_type = ATTR_HOST + ATTR_LIVE + ATTR_GREY;
			
			proxy:NotNetMessage_begin();
				--��1570�������J���Ă���Ƃ��ɒ��ɓ��邽�߂̃C�x���g��ǉ��� --EN:--��1570��Add an event to enter when the door is open��
				proxy:OnPlayerActionInRegionAttribute( 1570, 2892, "OnEvent_1570", HELPID_GO_TO_IN, possible_chr_type, everytime );
			proxy:NotNetMessage_end();
		
		else --�O���C�S�[�X�g�ł����Ƃ��悤�ɂ���Ǝv����B --EN:--Gray ghost seems to be like that when it's done.
		
			proxy:NotNetMessage_begin();
				--��1571�������J���Ă���Ƃ��ɒ��ɓ��邽�߂̃C�x���g��ǉ��� --EN:--��1571��Add an event to enter when the door is open��
				proxy:OnPlayerActionInRegion( 1571, 2892, "OnEvent_1570", HELPID_GO_TO_IN, everytime );--�n���h���͏�Ɠ��� --EN:--handler is the same as above
			proxy:NotNetMessage_end();
		
		end
	end
	

--��1540���{�X�̃|�����Đ��� --EN:--�� 1540 �� Boss's polyplay play ��

	if proxy:IsCompleteEvent( 1540 ) == false and proxy:IsCompleteEvent( 1545 ) == false then 
	
		--���{�X�O�̃|�����Đ��p�Ď��ǉ� --EN:--�� Added surveillance for polyplay playback in front of the boss
		proxy:OnRegionJustIn( 1540 , LOCAL_PLAYER , 2896 , "OnEvent_1540" , once );
		
		proxy:NotNetMessage_begin();
--[[
		--���򗳂̒��������Ă����ꍇ�� --EN:--�� If the chief of the wyvern is still alive ��
			--�|�����J�n�ɌĂ΂��n���h�� --EN:--handler called at polyplay start
			proxy:LuaCall(1540, REMO_START, "OnEvent_1540_RemoStart", once);
			--�|�����I����ɌĂ΂��n���h��(�g���K�[�N�������l�p) --EN:--Handler called after the end of the polyplay (for the person who caused the trigger)
			proxy:LuaCall(1540, REMO_FINISH, "OnEvent_1540_RemoFinish", once);
]]

		--���򗳂̒�������ł����ꍇ�� --EN:-- If the wyvern leader is dead ��
			--�|�����J�n�ɌĂ΂��n���h�� --EN:--handler called at polyplay start
			proxy:LuaCall(1545, REMO_START, "OnEvent_1545_RemoStart", once);
			--�|�����I����ɌĂ΂��n���h��(�g���K�[�N�������l�p) --EN:--Handler called after the end of the polyplay (for the person who caused the trigger)
			proxy:LuaCall(1545, REMO_FINISH, "OnEvent_1545_RemoFinish", once);
		proxy:NotNetMessage_end();
	else
		proxy:SetEventFlag( 4490 , true );
	end


--��1572���{�X������������	 --EN:-- �� 1572 �� Boss begins to move ��
	if proxy:IsCompleteEvent( 4480 ) == false then
		proxy:OnRegionJustIn( 1572 , LOCAL_PLAYER , 2884 , "OnEvent_1572" , everytime );
	end
	

--��4480���{�X���S��	 --EN:-- �� 4480 �� Boss death ��
	proxy:AddFieldInsFilter( 821 );
	if proxy:IsCompleteEvent( 4480 ) ==false then
		proxy:NotNetMessage_begin();
			proxy:OnCharacterDead(4480, 821, "OnEvent_4480", once);
		proxy:NotNetMessage_end();
	end

------------- ���򗳌n�� ----------------------------------------------- --EN:-- �� Wyvern type �� -------------------------------------------- ----

--��1620���̈�Ď��� --EN:-- �� 1620 �� area monitoring ��
	proxy:OnNetRegion(1620 , 2610);	
--��1621���̈�Ď��� --EN:-- �� 1621 �� area monitoring ��
	proxy:OnNetRegion(1621 , 2620);	
--��1622���̈�Ď��� --EN:-- �� 1622 �� area monitoring ��
	proxy:OnNetRegion(1622 , 2630);	
--��1623���̈�Ď��� --EN:-- �� 1623 �� area monitoring ��
	proxy:OnNetRegion(1623 , 2640);
--��1624���̈�Ď��� --EN:-- �� 1624 �� area monitoring ��
	proxy:OnNetRegion(1624 , 2641);
--��1625���̈�Ď��� --EN:-- �� 1625 �� area monitoring ��
	proxy:OnNetRegion(1625 , 2642);
--��1626���̈�Ď��� --EN:-- �� 1626 �� area monitoring ��
	proxy:OnNetRegion(1626 , 2643);
--��1651���̈�Ď��� --EN:-- �� 1651 �� area monitoring ��
	proxy:OnNetRegion(1651 , 2710);
	
--��1590���򗳂̒����x�����Ă��遡 --EN:--��1590��The chief of the wyvern is on guard��
	--Second_Initialize�Œǉ�(��ԃt���O���Z�b�g������) --EN:Added with --Second_Initialize (after setting state flags)
	
--��1591���򗳂̒����̈�A���u���X�U�������遡 --EN:--�� 1591 �� Wyvern chief performs a breath attack on area A ��
--��1592���򗳂̒����̈�B���u���X�U�������遡 --EN:--�� 1592 �� Wyvern leader performs a breath attack on area B ��
--��1593���򗳂̒����̈�C���u���X�U�������遡 --EN:--�� 1593 �� Wyvern chief performs a breath attack on area C ��
--��1594���򗳂̒����L��ɑ΂��ău���X�U�������遡 --EN:--��1594��The chief of the wyvern performs a breath attack on the square��
--��1599���򗳂̒����Q�[�g�O�Ōx�����Ă��遡 --EN:--��1599��The chief of the wyvern is on guard in front of the gate��


--��1597���򗳂̒����Q�[�g�O�ɔ��ł����� --EN:--��1597��The chief of the wyvern flies in front of the gate��
--��1598���򗳂̒����ʘH�O�ɔ��ł����� --EN:--��1598��The chief of the wyvern flies in front of the passage��

--��1600���򗳂̒������̊Ԃɔ��ł����i�ʘH�O����j�� --EN:--��1600��The chief of the wyvern flies between the kings (from the front of the passageway)��
--��1601���򗳂̒������̊Ԃɔ��ł����i�Q�[�g�O����j�� --EN:--��1601��The chief of the wyvern flies between the kings (from in front of the gate)��
--��1602���򗳂̒������̊Ԃ��x�����Ă��遡 --EN:--��1602��The Chief of the Wyvern is guarding the King's Chamber��
--��1603���򗳂̒������̊ԂɃu���X�U�������遡 --EN:--��1603��The chief of the flying dragon performs a breath attack between the kings��
--��1604���򗳂̒����A���̊Ԃ���P�ނ��遡 --EN:--��1604��The chief of the wyvern withdraws from the king's room��
	
	if	proxy:IsCompleteEvent( TYO_STATE_DEAD ) == false then
	--��1670���򗳂̒���Hp��75���ȉ��� --EN:-- �� 1670 �� Wyvern leader's HP is 75% or less ��
		SingleReset( proxy, 1670 );
		if	proxy:IsCompleteEvent( 1670 ) == false then
			proxy:OnCharacterHP( 1670, HiryuOsa_b4_evid, "OnEvent_1670", 0.75, once );
		end
		
	--��1671���򗳂̒���Hp��50���ȉ��� --EN:-- �� 1671 �� Wyvern leader's HP is less than 50% ��
		SingleReset( proxy, 1671 );
		if	proxy:IsCompleteEvent( 1671 ) == false then
			proxy:OnCharacterHP( 1671, HiryuOsa_b4_evid, "OnEvent_1671", 0.50, once );
		end
			
		--���򗳃A�j���̓����Đ��p�� --EN:--��For synchronous playback of flying dragon animation��
		proxy:LuaCall( 1590 , 1 , "OnEvent_1590"   				, everytime );--�A�j���Ǘ� --EN:--animation management
		proxy:LuaCall( 1590 , 2 , "OnEvent_1590_syncroInvalid"	, everytime );--���������� --EN:--disable synchronization
		
		proxy:LuaCall( 1590 , 3 , "OnEvent_1590_3"				, everytime );--�ʘH�ҋ@ --EN:--Aisle waiting
		
		proxy:LuaCall( 1590 ,10 , "Osa_ForceSynchroAnime" 			, everytime );--�����A�j���p --EN:--For synchronous animation
		
		proxy:LuaCall( 1591 , 1 , "OnEvent_1591_1"				, everytime );--�u���XA --EN:--Breath A
		proxy:LuaCall( 1591 , 2 , "OnEvent_1591_2"				, everytime );--�u���XA --EN:--Breath A
		proxy:LuaCall( 1592 , 1 , "OnEvent_1592_1"				, everytime );--�u���XB --EN:--Breath B
		proxy:LuaCall( 1592 , 2 , "OnEvent_1592_2"				, everytime );--�u���XB --EN:--Breath B
		proxy:LuaCall( 1593 , 1 , "OnEvent_1593_1"				, everytime );--�u���XC --EN:--Breath C
		proxy:LuaCall( 1593 , 2 , "OnEvent_1593_2"				, everytime );--�u���XC --EN:--Breath C
		
		proxy:LuaCall( 1594 , 1 , "OnEvent_1594_1"				, everytime );--�L��u���XA --EN:--Square Breath A
		proxy:LuaCall( 1594 , 2 , "OnEvent_1594_2"				, everytime );--�L��u���XA --EN:--Square Breath A
		proxy:LuaCall( 1660 , 1 , "OnEvent_1660_1"				, everytime );--�L��u���XB --EN:--Square Breath B
		proxy:LuaCall( 1660 , 2 , "OnEvent_1660_2"				, everytime );--�L��u���XB --EN:--Square Breath B
		proxy:LuaCall( 1661 , 1 , "OnEvent_1661_1"				, everytime );--�L��u���XC --EN:--Square Breath C
		proxy:LuaCall( 1661 , 2 , "OnEvent_1661_2"				, everytime );--�L��u���XC --EN:--Square Breath C
		
		proxy:LuaCall( 1662 , 1 , "OnEvent_1662_1"				, everytime );--�L��ҋ@ --EN:--Plaza waiting
		
		proxy:LuaCall( 1596 , 1 , "OnEvent_1596_1"				, everytime );--�Q�[�g���S --EN:--Gate death
		proxy:LuaCall( 1597 , 1 , "OnEvent_1597_1"				, everytime );--�Q�[�g�ֈړ� --EN:--Move to Gate
		proxy:LuaCall( 1598 , 1 , "OnEvent_1598_1"				, everytime );--�ʘH�ֈړ� --EN:--Move to passage
		
		proxy:LuaCall( 1595 , 1 , "OnEvent_1595_1"				, everytime );--�ʘH�Ŏ��S --EN:--died in hallway
	end
	
	
	

----------- ���򗳌n�� --------------------------------------------------------- --EN:-- �� Wyvern type �� -------------------------------------------- --------------


--��1635���G���x�[�^�����遡 --EN:-- �� 1635 �� elevator rises ��
--��1636���G���x�[�^���~��遡 --EN:-- �� 1636 �� Elevator gets off ��
--(Second_Initialize�ŊĎ��ǉ�) --EN:--(monitoring added in Second_Initialize)



--��4500���N���C�A���gPC���[�v���o�� --EN:-- �� 4500 �� Client PC warp effect ��
	--(�{�X���S:OnEvent_4480 ����A��) --EN:--(Boss death: linked from OnEvent_4480)

--��4502���V���O���F���̕ǁABGM������ --EN:-- �� 4502 �� Single: Wall of Light, BGM Elimination ��
	--(�{�X���S:OnEvent_4480 ����A��) --EN:--(Boss death: linked from OnEvent_4480)

--��4503���\�E�����聡 --EN:-- �� 4503 �� Get Soul ��
	--(�{�X���S:OnEvent_4480 ����A��) --EN:--(Boss death: linked from OnEvent_4480)

--��4504���{�X�A�C�e�����菈���� --EN:-- �� 4504 �� Boss Item Acquisition ��
	--(�{�X���S:OnEvent_4480 ����A��) --EN:--(Boss death: linked from OnEvent_4480)

--��4505���Β��Ƀ��[�v�� --EN:-- �� 4505 �� Warp to the stone pillar ��
	--(�\�E������:OnEvent_4503 ����A��) --EN:-- (Obtained from Soul: Linked from OnEvent_4503)



--��??���p�j�f�[�����̓o�ꁡ�n���h���o�^ --EN:--��??��Appearance of wandering daemon��Handler registration
	proxy:NotNetMessage_begin();
		--�v���C���[���\���Ŏ��S�������ɃL�b�N����܂��B --EN:--Kicked when a player dies solo.
		proxy:LuaCall( 4000, 100, "PlayerDeath_m02_03_00_00", everytime );
		--�v���C���[�������������ɃL�b�N����܂��B --EN:--Kicked when the player is revived.
		proxy:LuaCall( 4032, 100, "PlayerRevive_m02_03_00_00", everytime );
	proxy:NotNetMessage_end();
	


--��1635,1636���G���x�[�^�֘A�������� --EN:-- �� 1635, 1636 �� Elevator-related initialization ��
--�G���x�[�^�M�~�b�N�F�A�N�V����ID���� --EN:-- Elevator Gimmick: Action ID Breakdown
--1630		�G���x�[�^�̏㉺��ԊǗ�(false:��	true:��) --EN:--1630 Elevator vertical state management (false: down true: up)
--1631		�G���x�[�^�̃A�j��������p --EN:--1631 For judging elevator animation
--1635		�G���x�[�^�̔����̈�Ď� --EN:--1635 Elevator activation area monitoring
--1636		�G���x�[�^����ɂ���Ƃ��ɒN���G���x�[�^���ɂ��Ȃ��Ȃ������A���ɍ~�낷����p --EN:--1636 For judging to lower the elevator when no one is in the elevator when it is up
	proxy:SetIsAnimPauseOnRemoPlayForEvent(1620,true);
	proxy:OnNetRegion( 1636, 2651 );
	--�z�X�g�̏ꍇ�͕K��������Ԃ�����(�����A�{�X��Ŕs��ď�ɂ���܂܂��Ɛi�s�s�\�Ȉ�) --EN:--If you are the host, be sure to put the initial state on the bottom (because if you lose the boss battle and stay on the top, you can't progress)
	if	proxy:IsClient() == false then
		proxy:SetEventFlag( 1630, false );
		proxy:SetEventFlag( 1631, false );
		proxy:PlayLoopAnimation( 1620 , 0 );
	--�N���C�A���g�̏ꍇ�͏㉺�̏�Ԃ����č��킹�� --EN:--In the case of a client, match by looking at the top and bottom states
	else
		--�G���x�[�^�㉺�̏�Ԃ��z�X�g�̐��E�ɂ��킹�� --EN:--Adjust the state of the elevator up and down to the host world
		if	proxy:IsCompleteEvent( 1630 ) == true then
			proxy:EndAnimation( 1620, 1 );
		else
			proxy:EndAnimation( 1620, 0 );
		end
	end
	
	proxy:OnPlayerActionInRegion( 1635 , 2650 , "OnEvent_1635" , HELPID_START , everytime );--����p --EN:--For climbing
	--[[
	proxy:NotNetMessage_begin();
		proxy:OnRegionJustOut( 1635, LOCAL_PLAYER, 2651, "OnEvent_1635_Out", everytime );
	proxy:NotNetMessage_end();
	]]
	proxy:LuaCall(1635, 2, "OnEvent_1635_flag", everytime);--�㉺�t���O���� --EN:--Upper and lower flag synchronization
	proxy:LuaCall(1635, 3, "OnEvent_1635", everytime );--���쓯�� --EN:-- Operation synchronization
	proxy:LuaCall(1635, 4, "OnEvent_1635_animeflag",everytime);--�A�j�������� --EN:-- Synchronization during animation
	
	proxy:LuaCall(1635, 5, "OnEvent_1635_UpAnime",everytime);
	proxy:LuaCall(1635, 6, "OnEvent_1635_DownAnime",everytime);
	


	--proxy:SetEventFlag( 1630 , true ); --�G���x�[�^�����ɂ���t���OON --EN:--Elevator down flag ON
	--proxy:SetEventFlag( 1631 , false );--�G���x�[�^����ɂ���t���OOFF --EN:--Elevator up flag OFF

	--proxy:OnDistanceActionPlus( 1635 , LOCAL_PLAYER, 1620, "OnEvent_1635" , 1, HELPID_START , 0, 100, 0.0, 0.0, 0.0, everytime );--����p --EN:--For climbing
--	proxy:OnPlayerActionInRegion( 1636 , 2651 , "OnEvent_1636" , HELPID_START , everytime );--�~���p --EN:--for getting off

	
--��1780���G�������Ă��遡 --EN:-- �� 1780 �� enemies fall ��
	if	proxy:IsCompleteEvent( 1780 ) == false then
		proxy:OnRegionJustIn( 1780, LOCAL_PLAYER, 2656, "OnEvent_1780", once );
		proxy:OnSimpleDamage( 1780, 512, -1, "OnEvent_1780", once );
		proxy:EnableLogic( 512, false );
		proxy:Warp( 512, 2655 );
	end
	
--���{�X�֘A�̏��������� --EN:--�� Boss-related initialization processing
	if proxy:IsCompleteEvent( 4480 ) ==true then
		
		--���{�X����ł���Ƃ� --EN:--��When the boss is dead
		--�{�X���Ȃ��Ȃ� --EN:--boss disappears
		InvalidBackRead( proxy , 821 );
		
		--���@�Ǐ�����(���̃}�b�v�͖��@�ǈ��) --EN:--Magic wall disappears (this map has one magic wall)
		proxy:SetColiEnable( 1996 , false );
		proxy:SetDrawEnable( 1996 , false );	

		--���@�ǂ�SFX OFF --EN:--Magic Wall SFX OFF
		proxy:InvalidSfx( 1988 , true );
		
	else
	    --���{�X�����Ă���Ƃ�		 --EN:--�� When the boss is alive
		proxy:EnableLogic( 821 , false );--���W�b�NOFF�őҋ@		 --EN:--Wait with logic OFF
	end		

	--�����h�����̎��񂾌�A�v�΂Ń{�C�X�Đ� --EN:-- After the death of King Lendor, the voice is played on the keystone
	proxy:RegistSimpleTalk( 4510 , 1979 , 28000, TALK_ATTR_ALL );

--��4503,4505���\�E������A�v�΂Ń��[�v�� --EN:-- �� 4503, 4505 �� Get soul, warp with keystone ��
	if proxy:IsCompleteEvent( 4480 ) ==true then--�{�X������ł���Ƃ� --EN:--when the boss is dead
		
		proxy:TreasureDispModeChange2( 1979 , true ,KANAME_SFX);--���点�� --EN:-- let it shine
		--��(�\�E��)�A�C�e���擾�p�C�x���g�Ď��ǉ��� --EN:--�� (Soul) Added event monitoring for item acquisition��
		if proxy:IsCompleteEvent( 4503 ) == false then
			proxy:ValidSfx( 1640 );--SFX �L���� --EN:--SFX enable
			proxy:ValidSfx( 1641 );--���̗��q			 --EN:--Particles of light
			proxy:OnDistanceActionAttribute( 4503 , LOCAL_PLAYER , 1979 , "OnEvent_4503" , WarpGimmickDist_A , 10010180 , 0 , 180 , ATTR_HOST + ATTR_LIVE + ATTR_GREY, once );

			--�\�E���L���� --EN:--Soul activation
			proxy:SetDrawEnable( 1979 , true );
			proxy:SetColiEnable( 1979 , true );
			--�\�E��2�L���� --EN:--Activate Soul 2
			proxy:SetDrawEnable( 1978 , true );
			proxy:SetColiEnable( 1978 , true );

		else
			--���v�΂Ń��[�v�p�̊Ď���ǉ��� --EN:--�� Added surveillance for warp with keystone ��
			proxy:InvalidSfx( 1640, false );--SFX ������ --EN:--Disable SFX
			--proxy:InvalidSfx( 1641, false );--���̗��q --EN:--Particles of light
			SingleReset( proxy , 4505);
			proxy:OnDistanceActionAttribute( 4505 , LOCAL_PLAYER , 1979 , "OnEvent_4505" , WarpGimmickDist_A , HELPID_GO_TO_SEKITYUU , 0 , 180 , ATTR_NOSESSION , everytime );
		end

	else
		--�\�E�������� --EN:--Soul Invalidation
		proxy:SetDrawEnable( 1979 , false );
		proxy:SetColiEnable( 1979 , false );
		--�\�E��2������ --EN:--Soul 2 disabled
		proxy:SetDrawEnable( 1978 , false );
		proxy:SetColiEnable( 1978 , false );
		--SFX ������ --EN:--Disable SFX
		proxy:InvalidSfx( 1640 , false );
		proxy:InvalidSfx( 1641 , false );
	end
	
	


--����(��)�C�x���g�֘A������ --EN:-- �� Wyvern (Long) event-related initialization
	if	proxy:IsClient() == false then
		proxy:RequestForceUpdateNetwork(HiryuOsa_b4_evid);
	end
	

--��8084������ɗ����t���O�𗧂Ă遡 --EN:-- �� 8084 �� Raise a flag for coming to the royal castle ��
	proxy:SetEventFlag(8084, true);
	
	--��1706�����̈�i���ŉ��q�����ʁ� --EN:-- �� 1706 �� The prince dies when entering a certain area ��
	RegistEvent_1706(proxy);
	
	--��1640�������h�����q�E�u���b�N���S�� --EN:-- �� 1640 �� Prince Lendl Black died ��
	RegistEvent_1640(proxy);
	
	--�����g�J�Q�C�x���g --EN:--Crystal Lizard Event
	RegistTokage(proxy,1680,257,4);
	RegistTokage(proxy,1682,258,5);
	RegistTokage(proxy,1684,259,6);	
	
--��1690���O�e�m1�����񂾁� --EN:-- �� 1690 �� Three Musketeers 1 died ��
	if proxy:IsCompleteEvent( 1690 ) == false then
		proxy:OnCharacterDead( 1690 , 530 , "OnEvent_1690",once);
	else
		InvalidBackRead( proxy,530 );
	end
--��1691���O�e�m2�����񂾁� --EN:-- �� 1691 �� Three Musketeers 2 died ��
	if proxy:IsCompleteEvent( 1691 ) == false then
		proxy:OnCharacterDead( 1691 , 531 , "OnEvent_1691",once);
	else
		InvalidBackRead( proxy, 531 );
	end
--��1692���O�e�m3�����񂾁� --EN:-- �� 1692 �� The Three Musketeers 3 died ��
	if proxy:IsCompleteEvent( 1692 ) == false then
		proxy:OnCharacterDead( 1692 , 532 , "OnEvent_1692",once);
	else
		InvalidBackRead( proxy, 532 );
	end


--------------------------------������QWC�C�x���g�֘A������-------------------------------- --EN:--������QWC event related ������--------------------------------
--------------------------------������QWC�C�x���g�֘A������-------------------------------- --EN:--������QWC event related������--------------------------------
	--��999999���t���[���x��̏����������C�x���g�𔭍s�� --EN:-- �� 999999 �� Generate a frame delay initialization processing event ��
	proxy:NotNetMessage_begin();
		--��0�b�づ-- --EN:--��After 0 seconds��--
		proxy:OnKeyTime2( 999993, "Second_Initialize_m02_03_00_00", 0.0, 0, 0, once );
	proxy:NotNetMessage_end();	


	--��15500�������A�C�e���擾�Ď����n���h���̓O���[�o���ɒ�` --EN:-- �� 15500 �� Intrusion item acquisition monitoring �� Handlers are defined globally
	--if proxy:IsCompleteEvent( 15500 ) == false then
	--	proxy:AddCorpseEvent( 15500 , 530 );--�O�e�mA --EN:--Three Musketeers A
	--	proxy:AddCorpseEvent( 15500 , 531 );--�O�e�mB --EN:--Three Musketeers B
	--	proxy:AddCorpseEvent( 15500 , 532 );--�O�e�mC --EN:--Three Musketeers C
	--end
	
	print("Initialize_m02_03_00_00 end");
end

function Second_Initialize_m02_03_00_00(proxy,param)
	print("Second_Initialize_m02_03_00_00 begin");
--------------------------------������QWC�C�x���g�֘A������-------------------------------- --EN:--������QWC event related ������--------------------------------
--------------------------------������QWC�C�x���g�֘A������-------------------------------- --EN:--������QWC event related������--------------------------------
	print("Second_Initialize_m02_03_00_00 end");
end

--------------------------------------------------------------------------------------
--�}���`�ɂȂ������Ƀz�X�g���ᖳ�������灡���� --EN:--If you are not a host when you become multi, no
--------------------------------------------------------------------------------------
function ConnectPartyEvent(proxy)
	print("ConnectPartyEvent begin");
	print("ConnectPartyEvent end");
end


--------------------------------------------------------------------------------------
--�p�j�f�[�����̓o�ꁡ?? --EN:-- Appearance of the Wandering Demon ??
--------------------------------------------------------------------------------------

--���O���[�o���̎��S�Ď�����Ă΂��(�\��) --EN:--�� Called from global death watch (solo)
function PlayerDeath_m02_03_00_00(proxy, param)
	print("PlayerDeath_m02_03_00_00");
	print("PlayerDeath_m02_03_00_00");
end

--���O���[�o���̌�������������Ă΂��(�\��) --EN:--��Called from global blood letter revival (solo)
function PlayerRevive_m02_03_00_00(proxy,param)
	print("PlayerRevive_m02_03_00_00");
	print("PlayerRevive_m02_03_00_00");
end




--------------------------------------------------------------------------------------
--��1560���򗳂̒��A�o���� --EN:-- �� 1560 �� Wyvern leader appears ��
--------------------------------------------------------------------------------------

function OnEvent_1560(proxy , param)
	print("OnEvent_1560 begin");

	--���d�����h�~ --EN:--Multiple activation prevention
	if proxy:IsCompleteEvent( 1560 ) == true then
		print("OnEvent_1560 end");
		return;
	end
	
	--���݂̏�Ԏ擾 --EN:-- Get current status
	local now_state = GetNpcStateFlag(proxy ,param, tyo_flag_list);
	
	--�򗳂̏�Ԃ��x��(�ʘH)�̂Ƃ� --EN:--When the wyvern's status is alert (passage)
	if now_state == TYO_STATE_WARNING_AISLE then 
		
		--�|�����Đ� --EN:--Poly play
		proxy:RequestRemo(20300,REMO_FLAG,1560,1);
		proxy:SetEventFlag( 1560 , 1 );--�t���O�Z�b�g --EN:--flag set
	end
	
	print("OnEvent_1560 end");
end


--���|�����Đ��J�n(�t�F�[�h�I��) --EN:--�� Start of polyplay playback (end of fade)
function OnEvent_1560_RemoStart(proxy,param)
	print("OnEvent_1560_RemoStart begin");
	
	--���̃^�C�~���O�ŗL��������I�u�W�F --EN:--Object to activate at this timing
	proxy:SetDrawEnable( 1710 , true );
	proxy:SetColiEnable( 1710 , true );
	
	proxy:SetDrawEnable( 1711 , true );
	proxy:SetColiEnable( 1711 , true );
	ValidCharactor( proxy , HiryuOsa_b4_evid );--�򗳗L���� --EN:--enable wyvern
	
	print("OnEvent_1560_RemoStart end");
end


--���|�����Đ��I��(�t�F�[�h�I��) --EN:-- End of polyplay playback (end of fade)
function OnEvent_1560_RemoFinish(proxy , param)
	print("OnEvent_1560_RemoFinish begin");
	
	proxy:DeleteEvent( 1560 );--everytime�Ȃ̂ŏ��� --EN:--everytime so delete
	
	proxy:Warp(  HiryuOsa_b4_evid , 2700 );	
	proxy:ForcePlayAnimationStayCancel( HiryuOsa_b4_evid, 7001 );

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
	
	proxy:SetDrawEnable( 1710 , false );
	proxy:SetColiEnable( 1710 , false );
	
	proxy:SetDrawEnable( 1711 , false );
	proxy:SetColiEnable( 1711 , false );
	
	proxy:SetDrawEnable( 1700 , false );
	proxy:SetColiEnable( 1700 , false );
	
	proxy:SetDrawEnable( 1701 , false );
	proxy:SetColiEnable( 1701 , false );	

	print("OnEvent_1560_RemoFinish end");
end




--------------------------------------------------------------------------------------
--�{�X�����̒��ɓ��遡1570 --EN:--Enter the boss room 1570
--------------------------------------------------------------------------------------

--���C�x���g�����[�v�Ȃ̂ŁA�S�����s�[�g�ɂ��遫 --EN:--�� Since the event is a loop, repeat all ��

--��1570�����{�X�����ւ̔����J���� --EN:-- �� 1570 �� The door to the mid-boss room opens ��
function OnEvent_1570(proxy,param)
	print("OnEvent_1570 begin");
	
	--�G���x�[�^�A�j���Đ����͓���Ȃ��悤�ɂ͂��� --EN:-- Flip not to enter while the elevator animation is playing
	if proxy:IsCompleteEvent( 1631 ) == true then
		print("OnEvent_1570 return end");
		return;
	end

	if proxy:IsCompleteEvent( SYSTEM_ID_IGNORE ) == true then
		print("OnEvent_1570 end");
		return;
	end
	
	--�N���C�A���g�ցA�{�X�����j�~���s��ʒm --EN:--Notify client of failure to block boss room
	if proxy:IsClient() == false then
		proxy:LuaCallStart( 4068 , 1 );	
	end
	
	proxy:LuaCallStart( 1571 , 1 );--����A�j���̓����Đ� --EN:-- Synchronous playback of turning animation
	--proxy:SetEventFlag( SYSTEM_ID_IGNORE , 1 );--���d�����h�~�p --EN:--For multiple activation prevention
	--���d�N���V�X�e��ID���^�C���A�E�g��ݒ肵��ON�ɂ��� --EN:--Turn on multiple activation system ID by setting timeout
	proxy:SetSystemIgnore( SYSTEM_ID_IGNORE , IGNORE_TIME );
	
	--�v���t�@�C���Z�[�u�v�� --EN:--profile save request
	proxy:SaveRequest_Profile();
	
	print("OnEvent_1570 end");
end


--����A�j���̓����Đ�(ID����) --EN:-- Synchronized playback of turning animation (ID is different)
function OnEvent_1571_1(proxy,param)
	print("OnEvent_1571_1 begin");
	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		if param:IsNetMessage() == true then
			--����A�j���Đ����s���A���̏I������OnEvent_1571_2�𔭍s���� --EN:--Play the turning animation and issue OnEvent_1571_2 at the end
			proxy:TurnCharactor( 10001 + param:GetPlayID(), 2888 );
		else
			proxy:LockSession();--���[�������b�N���܂��I --EN:--lock the room!
			--����A�j���Đ����s���A���̏I������OnEvent_1571_2�𔭍s���� --EN:--Play the turning animation and issue OnEvent_1571_2 at the end
			proxy:OnTurnCharactorEnd( 1571, LOCAL_PLAYER, 2888, "OnEvent_1571_2", once );
		end
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	
	print("OnEvent_1571_1 end");
end

--����A�j���̓����Đ��I���� --EN:--After synchronous playback of turning animation ends
function OnEvent_1571_2(proxy,param)
	print("OnEvent_1571_2 begin");
	
	--�����p�����A�j���Đ� --EN:--Play walking animation for synchronization
	proxy:LuaCallStart( 4012, 1 );
	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		proxy:OnChrAnimEnd( 1571, LOCAL_PLAYER, ANIMEID_WALK, "OnEvent_1571_3", once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
		
	print("OnEvent_1571_2 end");
end

--�����A�j���̓����Đ��I���� --EN:--After the synchronized playback of the walking animation ends
function OnEvent_1571_3(proxy,param)
	print("OnEvent_1571_3 begin");

	--�ŏ��̐l���{�X�����̒��ɓ���I����Ă�����A���ɔz�M����Ă���͂��Ȃ̂ŁA����������Ȃ��n���h�� --EN:--If the first person has already entered the boss room, it should have already been delivered, so no more handlers
	if proxy:IsCompleteEvent( 1570 ) == false then
		proxy:LuaCallStart( 1571 , 5 );--2��ڈȍ~�Ƀ{�X�����ɓ��邽�߂̃C�x���g�z�M�p --EN:--For event delivery to enter the boss room after the second time
		proxy:LuaCallStart( 4045 , 1 );	--�N���C�A���g�ցA�{�X�����ɓ����悤�ɂȂ������Ƃ�ʒm --EN:--Notify clients that they can now enter the boss room
		proxy:LuaCallStart( 1571 , 6 );--�t���O�Z�b�g(�����p) --EN:--flag set (for synchronization)
		Lua_MultiDoping(proxy,821);--�}���`�v���C�h�[�s���O --EN:-- Multiplayer Doping
	end

	--�v���C���[�����̒��Ɋ��S�ɂ͂������^�C�~���O�ŁA�{�X�̎v�l�����Z�b�g --EN:--Reset the boss' thoughts when the player is completely inside the door
	--�ꏊ�������ƃv���C���[��������Ȃ�����(�U�����Ă��Ȃ�) --EN:--Because you can't find the player if the location is bad (they won't attack)
	if proxy:IsClient() == false then
		proxy:ResetThink( 821 );
	end
	
	proxy:SetEventFlag( SYSTEM_ID_IGNORE , 0 );--���d�����h�~�p	 --EN:--For multiple activation prevention
	
	print("OnEvent_1571_3 end");
end


--��1570 2��ڈȍ~�Ƀ{�X�����ɓ��邽�߂̃C�x���g�z�M�p --EN:--�� 1570 For event delivery to enter the boss room after the second time
function OnEvent_1570_GO_TO_IN(proxy, param)
	print("OnEvent_1570_GO_TO_IN begin");
		
	proxy:NotNetMessage_begin();
		--��1571�������J���Ă���Ƃ��ɒ��ɓ��邽�߂̃C�x���g��ǉ���--�n���h���� OnEvent_1570 --EN:--��1571��Add an event to enter when the door is open��--The handler is OnEvent_1570
		proxy:OnPlayerActionInRegion( 1571, 2892, "OnEvent_1570", HELPID_GO_TO_IN, everytime );--
	proxy:NotNetMessage_end();	
	
	print("OnEvent_1570_GO_TO_IN end");
end


--��1570 �t���O�Z�b�g(�����p) --EN:-- 1570 flag set (for synchronization)
function OnEvent_1570_flag_set(proxy, param)
	print("OnEvent_1570_flag_set begin");
		
	proxy:SetEventFlag( 1570 , 1 );
	proxy:DeleteEvent( 1570 );

	print("OnEvent_1570_flag_set end");
end



--------------------------------------------------------------------------------------
--���{�X�|�����Đ���1540 --EN:--Middle Bospoli play �� 1540
--------------------------------------------------------------------------------------

function OnEvent_1540(proxy, param)
	print("OnEvent_1540 begin");
--[[	

	--���݂̏�Ԏ擾 --EN:-- Get current status
	local now_tyo_state = GetNpcStateFlag( proxy , param , tyo_flag_list );
	if now_tyo_state == TYO_STATE_DEAD then
		--�|�����Đ��J�n --EN:--Start playing polyplay
		proxy:RequestRemo(20302,REMO_FLAG,1545,1);
	else
		--�|�����Đ��J�n --EN:--Start playing polyplay
		proxy:RequestRemo(20301,REMO_FLAG,1540,1);
	end
]]
	proxy:RequestRemo(20302,REMO_FLAG,1545,1);
	proxy:SetEventFlag( 1545 , 1 );--�|�����Đ��I�� --EN:--End of polyplay play
	print("OnEvent_1540 end");
end

--[[
--��1540_RemoStart���|�����J�n �t�F�[�h�A�E�g������ --EN:--�� 1540_RemoStart �� Poly drama start Fade-out complete ��
function OnEvent_1540_RemoStart(proxy,param)
	print( "OnEvent_1540_RemoStart begin" );
	
	proxy:SetDrawEnable( 821 , false );
	
	print( "OnEvent_1540_RemoStart end" );
end


--��1540_RemoFinish���|�����Đ��I���ち --EN:--�� 1540_RemoFinish �� After playing the polyplay ��
function OnEvent_1540_RemoFinish(proxy , param)
	print( "OnEvent_1540_RemoFinish begin" );

	proxy:SetDrawEnable( 821 , true );
	proxy:SetEventFlag( 1540 , 1 );--�|�����Đ��I�� --EN:--End of polyplay play

	print( "OnEvent_1540_RemoFinish end" );
end
]]

--��1545_RemoStart���|�����J�n �t�F�[�h�A�E�g������ --EN:--�� 1545_RemoStart �� Poly drama start Fade-out complete ��
function OnEvent_1545_RemoStart(proxy,param)
	print( "OnEvent_1545_RemoStart begin" );
	
	proxy:SetDrawEnable( 821 , false );
	
	print( "OnEvent_1545_RemoStart end" );
end


--��1545_RemoFinish���|�����Đ��I���ち --EN:--�� 1545_RemoFinish �� After playing the polyplay ��
function OnEvent_1545_RemoFinish(proxy , param)
	print( "OnEvent_1545_RemoFinish begin" );

	proxy:SetDrawEnable( 821 , true );
	proxy:SetEventFlag( 4490 , true );

	print( "OnEvent_1545_RemoFinish end" );
end

--[[
--------------------------------------------------------------------------------------
--���{�X�|����2�Đ���1545 --EN:--Middle Bospoli play 2 playback 1545
--------------------------------------------------------------------------------------

function OnEvent_1545(proxy, param)
	print("OnEvent_1545 begin");

	--�|�����Đ��J�n --EN:--Start playing polyplay
	proxy:RequestRemo(20302,REMO_FLAG,1545,1);
	
	print("OnEvent_1545 end");
end


--��1540_RemoStart���|�����J�n �t�F�[�h�A�E�g������ --EN:--�� 1540_RemoStart �� Poly drama start Fade-out complete ��
function OnEvent_1545_RemoStart(proxy,param)
	print( "OnEvent_1545_RemoStart begin" );
	
	proxy:SetDrawEnable( 821 , false );
	
	print( "OnEvent_1545_RemoStart end" );
end


--��1540_RemoFinish���|�����Đ��I���ち --EN:--�� 1540_RemoFinish �� After playing the polyplay ��
function OnEvent_1545_RemoFinish(proxy , param)
	print( "OnEvent_1545_RemoFinish begin" );

	proxy:SetDrawEnable( 821 , true );
	proxy:SetEventFlag( 1545 , 1 );--�|�����Đ��I�� --EN:--End of polyplay play

	print( "OnEvent_1545_RemoFinish end" );
end
]]


--------------------------------------------------------------------------------------
--�{�X�������o��(�퓬�J�n)��1572 --EN:--Boss begins to move (battle begins) 1572
--------------------------------------------------------------------------------------

function OnEvent_1572(proxy, param)
	if proxy:IsCompleteEvent( 4490 ) == false then
		return;
	end
	print("OnEvent_1572 begin");
	
	--�{�X��pBGM�Đ��J�n --EN:--Start playing BGM for boss battle
	proxy:PlayPointSE( 2660, SOUND_TYPE_M, 20300000, 3 );
	
	--�{�X���W�b�NON --EN:--Boss logic ON
	proxy:EnableLogic( 821 , true );
	
	--�ǂݍ��݃^�C�~���O�̂Ƃ�����ǉ�����Ăق����̂Ńt���O���ĂȂ� --EN:-- I want it to be added every time at the time of reading, so I don't set a flag
	
	--�{�X�Q�[�W�\�� --EN:-- Boss gauge display
	proxy:SetBossGauge( 821 , 0 ,6010 );
	
	--�Ď��폜 --EN:--Delete monitor
	proxy:DeleteEvent( 1572 );
	
	print("OnEvent_1572 end");
end




--------------------------------------------------------------------------------------
--��4480�����{�X���S�� --EN:-- �� 4480 �� Mid-boss death ��
--------------------------------------------------------------------------------------

--��4480�����{�X���S�� --EN:-- �� 4480 �� Mid-boss death ��
function OnEvent_4480(proxy, param)
	print("OnEvent_4480 begin");

	proxy:NotNetMessage_begin();
		--��4500���N���C�A���gPC���[�v���o�� --EN:--��4500��Client PC warp effect��
		proxy:OnKeyTime2( 4500, "OnEvent_4500", 0, 0, 0, once);	
		--��4481��1�b�o�߁� --EN:--��4481��1 second passed��
		proxy:OnKeyTime2( 4481, "OnEvent_4481", 1, 0, 1, once);
		--��4502��2�b�o�߁� --EN:--��4502��2 seconds passed��
		proxy:OnKeyTime2( 4502, "OnEvent_4502", 2, 0, 2, once);	
		--�}���`���U�Ď� --EN:--Multi-Dismissal Monitoring
		proxy:OnRegistFunc( 4480 , "Check_4480_PT","OnEvent_4480_PT",0,once);
	proxy:NotNetMessage_end();
	
	--PC�ɕt����������ʂ𖳌��� --EN:--Disable special effects on PC
	if proxy:EraseEventSpecialEffect_2(LOCAL_PLAYER, 5007) == true then
		print("����5030�̃G�t�F�N�g����������"); --EN:print("Remove ����5030 effects����");
	else
		print("5030�̃G�t�F�N�g���������s"); --EN:print("Failed to erase 5030 effects");
	end
	if proxy:EraseEventSpecialEffect_2(LOCAL_PLAYER, 5008) == true then
		print("����5031�̃G�t�F�N�g����������"); --EN:print("Remove ����5031 effects����");
	else	
		print("5031�̃G�t�F�N�g���������s"); --EN:print("Failed to erase 5031 effects");
	end
	if proxy:EraseEventSpecialEffect_2(LOCAL_PLAYER, 5009) == true then
		print("����5032�̃G�t�F�N�g����������"); --EN:print("Remove ����5032 effects����");
	else	
		print("5032�̃G�t�F�N�g���������s"); --EN:print("Failed to erase 5032 effects");
	end
	
	--proxy:EraseEventSpecialEffect(LOCAL_PLAYER, 5030);
	--proxy:EraseEventSpecialEffect(LOCAL_PLAYER, 5031);
	--proxy:EraseEventSpecialEffect(LOCAL_PLAYER, 5032);
	
	--�u���b�N�N���A������ --EN:-- to block clear processing
	proxy:CustomLuaCallStart( 4050, 821 );	
	--�����g�J�Q���Z�b�g --EN:-- crystal lizard reset
	ResetTokage(proxy);
	
	proxy:SetEventFlag( 4480, 1 );--�{�X���S�t���OON --EN:--Boss death flag ON
	
	--�����h�����S�ɘA�����ă����h�����q���������Ȃ���Ԃ� --EN:--In conjunction with the death of Lendl, Prince Lendl no longer exists
	--[[
	if	proxy:IsCompleteEvent( RENDOL_STATE_LIFT_FRONT ) == true then
		SetNpcStateFlag( proxy, param, rendol_flag_list, RENDOL_STATE_ERASE );
			InvalidCharactor( proxy, 626 );
	end
	]]

	--�r�������O����(�����h������|�������ɁA�򗳂̒��Ɛ���Ă�����������Ȃ���Ԃ�) --EN:--Bjrn Grum (If you were fighting the Wyvern Chief when you defeated King Lendor, you'd be gone)
	if proxy:IsCompleteEvent( BIYO_STATE_BATTLE_FLY_DRAGON ) == true then
		SetNpcStateFlag( proxy , param , biyo_flag_list , BIYO_STATE_EXIT );
		proxy:SetEventFlag( 1710, true );
	end	
	
	print("OnEvent_4480 end");
end

--��4481�����{�X���S��1�b�� --EN:--��4481��1 second after death of mid-boss��
function OnEvent_4481(proxy, param)
	print("OnEvent_4481 begin");
	
	--�{�X��|���������X�V(���ɂ���ăt���O�𗧂Ă�) --EN:--update number of bosses killed (flag by number)
	GetBossFlagCount( proxy, param );
	
	--���g���t�B�[�擾���聥 --EN:--��Trophy Acquisition Judgment��
	Lua_RequestUnlockTrophy(proxy, 6);
	
	--��(�\�E��)�A�C�e���擾�p�C�x���g�Ď��ǉ��� --EN:--�� (Soul) Added event monitoring for item acquisition��
	if proxy:IsCompleteEvent( 4503 ) == false then
	
		--�\�E���L���� --EN:--Soul activation
		proxy:SetDrawEnable( 1979 , true );
		proxy:SetColiEnable( 1979 , true );
		--�\�E��2�L���� --EN:--Activate Soul 2
		proxy:SetDrawEnable( 1978 , true );
		proxy:SetColiEnable( 1978 , true );

		proxy:ValidSfx( 1640 );--SFX �L���� --EN:--SFX enable
		proxy:ValidSfx( 1641 );--SFX �L���� --EN:--SFX enable
		proxy:TreasureDispModeChange2( 1979 , true ,KANAME_SFX);--���点�� --EN:-- let it shine
		proxy:OnDistanceActionAttribute( 4503 , LOCAL_PLAYER , 1979 , "OnEvent_4503" , WarpGimmickDist_A , 10010180 , 0 , 180 , ATTR_HOST + ATTR_LIVE + ATTR_GREY, once );
	else
		--�\�E��������(������������̂ť��) --EN:--Soul nullification (because it disappears when you take it...)
		proxy:SetDrawEnable( 1979 , false );
		proxy:SetColiEnable( 1979 , false );
	end

	--����N���A�t���OON --EN:--Castle Clear Flag ON
	if proxy:IsClient() == false then
		proxy:SetEventFlag( 8010 , 1 );
	end

	print("OnEvent_4481 end");
end



--------------------------------------------------------------------------------------
--��4500���N���C�A���gPC���[�v���o�� --EN:-- �� 4500 �� Client PC warp effect ��
--------------------------------------------------------------------------------------

--��4500���N���C�A���gPC���[�v���o�� --EN:-- �� 4500 �� Client PC warp effect ��
function OnEvent_4500(proxy, param)
	print("OnEvent_4500 begin");

	if proxy:IsClient() == true then
		proxy:PlayAnimation( LOCAL_PLAYER , 8284 );--���[�v�A�j�����Đ� --EN:-- Play warp animation
	end

	proxy:SetEventFlag( 4500 , 1 );
	
	print("OnEvent_4500 end");
end



--------------------------------------------------------------------------------------
--��4502���V���O���F���̕ǁABGM������ --EN:-- �� 4502 �� Single: Wall of Light, BGM Elimination ��
--------------------------------------------------------------------------------------

--��4502���V���O���F���̕ǁABGM������ --EN:-- �� 4502 �� Single: Wall of Light, BGM Elimination ��
function OnEvent_4502(proxy, param)
	print("OnEvent_4502 begin");
	
	--�{�X��p��BGM��~ --EN:--BGM stop for boss battles
	proxy:StopPointSE( 3 );	

	proxy:SetEventFlag( 4502 , 1 );
	
	print("OnEvent_4502 end");
end

--�}���`���U�Ď� --EN:--Multi-Dismissal Monitoring
function Check_4480_PT(proxy)
	if proxy:IsInParty() == false then
		return true;
	end
	return false;
end

--�}���`����Ȃ� --EN:--not multiplayer
function OnEvent_4480_PT(proxy,param)
	print("OnEvent_4480_PT beign");
	--���{�X�����̑O��̖��@�ǂ�������(�S�v���C���[�A���̃}�b�v�͖��@�ǂ����) --EN:--The magic wall before and after the mid-boss room disappears (all players, this map has one magic wall)
	proxy:SetColiEnable( 1996 , false );	
	proxy:SetDrawEnable( 1996 , false );
	
	--proxy:SetObjDeactivate( 1996 , true );--�f�A�N�e�B�u --EN:--deactivate
	
	--���{�X�������@�ǂ�SFX�폜(�{�X����ID�Ƃ͕�) --EN:--SFX deletion of mid-boss room magic wall (separate from boss door ID)
	proxy:InvalidSfx( 1988 , true );
	
	--���{�X�����O�̈ړ������C�x���g���폜 --EN:--Delete the movement processing event in front of the mid-boss room
	proxy:DeleteEvent( 1570 );--��l�ڂ�����Ƃ��p --EN:--For when the first person enters
	proxy:DeleteEvent( 1571 );--��l�ڈȍ~������Ƃ��p --EN:--For when the second and subsequent people enter
	proxy:DeleteEvent( 1540 );--�|�����Đ��p --EN:--For polyplay play
	proxy:DeleteEvent( 1572 );--�{�X�퓬�J�n�p	 --EN:--For boss battle start
	print("OnEvent_4480_PT end");
end


--------------------------------------------------------------------------------------
--��1590���򗳂̒����x�����Ă��遡 --EN:--��1590��The chief of the wyvern is on guard��
--------------------------------------------------------------------------------------

--��(��)���Đ�����A�j��ID --EN:--Anime ID played by Hiryu (long)
tyo_play_anime_id = -1;--�ŏ��̓A�j�����Đ����Ă��Ȃ��̂�-1 --EN:--Because the animation is not played at first -1

--��1590���򗳂̒����x�����Ă��遡 --EN:--��1590��The chief of the wyvern is on guard��
function OnEvent_1590(proxy, param)
	print("OnEvent_1590 begin");
	
	
	--[[���݂̏�Ԏ擾]] --EN:--[[Get current state]]
	local now_state = GetNpcStateFlag( proxy, param, tyo_flag_list );
	
	--[[����S�ɒN�����Ȃ�]] --EN:--[[Nobody in Royal Castle 4]]
	if	proxy:IsCompleteEvent( 1651 )	==	false and	--2710
		proxy:IsCompleteEvent( 1670 )	==	false then	--HP75%�ȏ� --EN:--HP75% or more
		SetNpcStateFlag(proxy, param, tyo_flag_list, TYO_STATE_WARNING_AISLE );
		--��OnEvent_1590_3 --EN:--��OnEvent_1590_3
		proxy:LuaCallStart( 1590 , 3 );
	--[[��Ԃ��A�u�ʘH���x���v]] --EN:--[[Status is ``Alert Passage'']]
	elseif	proxy:IsCompleteEvent( TYO_STATE_WARNING_AISLE ) == true then
			
		--[[�ʘH�O�Ŏ��S]] --[[���S�D��]] --EN:--[[Death in front of corridor]] --[[Death priority]]
		if proxy:IsCompleteEvent( 1770 ) == true then--���S�p��HP�Ď��t���O��ON --EN:-- HP monitoring flag for death is ON
		   
			--��OnEvent_1595_1 --EN:--��OnEvent_1595_1
			proxy:LuaCallStart( 1595 , 1 );--�ʘH�Ŏ��S�A�j���̓����Đ� --EN:-- Synchronous playback of death animation in the passage

		--[[�Q�[�g�O�Ɉړ�]] --EN:--[[Move to Gate]]
		elseif
		   proxy:IsCompleteEvent( 1623 ) == true or		--2640
		   proxy:IsCompleteEvent( 1671 ) == true then	--Hp50���ȉ� --EN:--Hp50% or less
			
			print("��(��)�A�Q�[�g�O�Ɉړ��J�n"); --EN:print("Wyvern (long), start moving in front of the gate");
			--��OnEvent_1597_1 --EN:--��OnEvent_1597_1
			proxy:LuaCallStart( 1597 , 1 );
			
		--[[�ҋ@(�ʘH)]] --EN:--[[Wait (passageway)]]
		elseif
		   proxy:IsCompleteEvent( 1620 ) == false and	--2610
		   proxy:IsCompleteEvent( 1621 ) == false and	--2620
		   proxy:IsCompleteEvent( 1622 ) == false and	--2630
		   proxy:IsCompleteEvent( 1623 ) == false then	--2640
		   
			print("�ҋ@(�ʘH)"); --EN:print("wait (passage)");
			--��OnEvent_1590_3 --EN:--��OnEvent_1590_3
			proxy:LuaCallStart( 1590 , 3 );
		
		--[[�̈�A�u���X]] --EN:--[[Area A Breath]]
		elseif
		   proxy:IsCompleteEvent( 1620 ) == true  and  --2610
		   proxy:IsCompleteEvent( 1621 ) == false and  --2620
		   proxy:IsCompleteEvent( 1622 ) == false and  --2630
		   proxy:IsCompleteEvent( 1623 ) == false then --2640
			
			
			--[[�U���̑O�ɒʘH�őҋ@������]] --EN:--[[Pause in hallway before attacking]]
			--��OnEvent_1591_1 --EN:--��OnEvent_1591_1
			proxy:LuaCallStart( 1591 , 1 );
		
		--[[�̈�B�u���X]] --EN:--[[area B breath]]
		elseif
		   proxy:IsCompleteEvent( 1621 ) == true  and  --2620
		   proxy:IsCompleteEvent( 1622 ) == false and  --2630
		   proxy:IsCompleteEvent( 1623 ) == false then --2640
			
			print("�̈�B�u���X"); --EN:print("area B breath");
			--[[�U���̑O�ɒʘH�őҋ@������]] --EN:--[[Pause in hallway before attacking]]
			--��OnEvent_1592_1 --EN:--��OnEvent_1592_1
			proxy:LuaCallStart( 1592 , 1 );

		--[[�̈�C�u���X]] --EN:--[[area C breath]]
		elseif
		   proxy:IsCompleteEvent( 1622 ) == true  and  --2630
		   proxy:IsCompleteEvent( 1623 ) == false then --2640
			
			print("�̈�C�u���X"); --EN:print("area C breath");
			--[[�U���̑O�ɒʘH�őҋ@������]] --EN:--[[Pause in hallway before attacking]]
			--��OnEvent_1593_1 --EN:--��OnEvent_1593_1
			proxy:LuaCallStart( 1593 , 1 );
		
		end
	--[[��Ԃ��A�u�Q�[�g���x���v]] --EN:--[[state is "gate alert"]]
	elseif	proxy:IsCompleteEvent( TYO_STATE_WARNING_GATE ) == true then
			
		--[[�Q�[�g�O�Ŏ��S]] --[[���S�D��]] --EN:--[[Death in front of gate]] --[[Death priority]]
		if proxy:IsCompleteEvent( 1770 ) == true then--���S�p��HP�Ď��t���O��ON --EN:-- HP monitoring flag for death is ON

			--��OnEvent_1596_1 --EN:--��OnEvent_1596_1
			proxy:LuaCallStart( 1596 , 1  );
		   
		--[[�L��A�u���X]] --EN:--[[Square A Breath]]
		elseif 
		  (proxy:IsCompleteEvent( 1624 ) == true	and		--2641
		   proxy:IsCompleteEvent( 1625 ) == false	and		--2642
		   proxy:IsCompleteEvent( 1626 ) == false	) or	--2643
		  (proxy:IsCompleteEvent( TYO_STATE_WARNING_GATE ) 			== true	 and 	--�򗳂̒����u�Q�[�g�O���x���v --EN:--The chief of the wyvern ``Watch out in front of the gate''
		   proxy:IsCompleteEvent( BIYO_STATE_BATTLE_FLY_DRAGON )	== true) then	--�r�����u�򗳂Ɛ키�v --EN:--Biyo "fights flying dragons"
			print("�L��A�u���X"); --EN:print("Square A Breath");
			--��OnEvent_1594_1 --EN:--��OnEvent_1594_1
			proxy:LuaCallStart( 1594 , 1 );
			
		--[[�L��B�u���X]] --EN:--[[Square B Breath]]
		elseif 
		   proxy:IsCompleteEvent( 1625 ) == true	and		--2642
		   proxy:IsCompleteEvent( 1626 ) == false	and		--2643
		   proxy:IsCompleteEvent( BIYO_STATE_BATTLE_FLY_DRAGON ) == false	then	--�r�����u�򗳂Ɛ키�v�ł͂Ȃ� --EN:--Byo is not "fighting flying dragons"
		   
			print("�L��B�u���X"); --EN:print("Square B Breath");
			--��OnEvent_1660_1 --EN:--��OnEvent_1660_1
			proxy:LuaCallStart( 1660 , 1 );
		--[[�L��C�u���X]] --EN:--[[Square C Breath]]
		elseif 
		   proxy:IsCompleteEvent( 1626 ) == true	and		--2643
		   proxy:IsCompleteEvent( BIYO_STATE_BATTLE_FLY_DRAGON ) == false	then	--�r�����u�򗳂Ɛ키�v�ł͂Ȃ� --EN:--Byo is not "fighting flying dragons"
		   
			print("�L��C�u���X"); --EN:print("Square C Breath");
			--��OnEvent_1661_1 --EN:--��OnEvent_1661_1
			proxy:LuaCallStart( 1661 , 1 );
		--[[�ʘH�O�ɔ��ł���]] --EN:--[[Flying to the front of the aisle]]
		elseif
		    proxy:IsCompleteEvent( 1623 )	==	false	and		--2640
		  ( proxy:IsCompleteEvent( 1620 )	==	true	or		--2610
		    proxy:IsCompleteEvent( 1621 )	==	true	or		--2620
		    proxy:IsCompleteEvent( 1622 )	==	true )	and		--2630
			proxy:IsCompleteEvent( 1670 )	==	false 	then	--Hp75%�ȏ� --EN:--Hp75% or more

			print("��(��)�A�ʘH�O�Ɉړ��J�n"); --EN:print("Wyvern (long), start moving in front of the passage");
			--��OnEvent_1598_1 --EN:--��OnEvent_1598_1
			proxy:LuaCallStart( 1598 , 1 );
		
		--[[�ҋ@(�Q�[�g)]] --EN:--[[Wait (gate)]]
		elseif
		   proxy:IsCompleteEvent( 1624 ) == false and		--2641
		   proxy:IsCompleteEvent( 1625 ) == false and		--2642
		   proxy:IsCompleteEvent( 1626 ) == false then		--2643

			print("�ҋ@(�Q�[�g)"); --EN:print("wait(gate)");
			--��OnEvent_1662_1 --EN:--��OnEvent_1662_1
			proxy:LuaCallStart( 1662 , 1 );
			
		end

	--[[��Ԃ��A�u���S�v]] --EN:--[[Status is "dead"]]
	elseif	proxy:IsCompleteEvent( TYO_STATE_DEAD ) == true then
		print("OnEvent_1590 Dead end")
	
		--(�Ď��폜?) --EN:-- (delete monitor?)
	end
	
	print("OnEvent_1590 end");
end

--��1590_anime_end���A�j���̏I���̂ӂ��ɕK���ʂ遣 --EN:--��1590_anime_end��It always passes at the end of the anime��
function OnEvent_1590_anime_end(proxy, param)
	print("OnEvent_1590_anime_end begin");
	
	proxy:NotNetMessage_begin();
		--���򗳂̒����x�����Ă��遥 --EN:--��The chief of the wyvern is wary��
		proxy:OnKeyTime2( 1590 , "OnEvent_1590" , 0.0 , 0 , 1 , once );
	proxy:NotNetMessage_end();

	print("OnEvent_1590_anime_end end");
end


--LuaCallParam(1662,1)
function OnEvent_1662_1(proxy,param)
	print("OnEvent_1662_1 begin");
	tyo_play_anime_id = 7007;
	proxy:Warp( HiryuOsa_b4_evid , 2701 );--�ʘH���̗̈�Ƀ��[�v --EN:-- Warp to the passage side area
	--proxy:ForcePlayAnimationStayCancel( HiryuOsa_b4_evid, tyo_play_anime_id );
	proxy:ForcePlayAnimationStayCancel( HiryuOsa_b4_evid, tyo_play_anime_id );
	
	if	param:IsNetMessage() == true then
		print("OnEvent_1662_1 return end");
		return;
	end
	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		proxy:OnChrAnimEnd( 1661, HiryuOsa_b4_evid, tyo_play_anime_id, "OnEvent_1590_anime_end", once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	
	print("OnEvent_1662_1 end");
end

--�b���ŏI���������A�A�j���̎ڂŏI���������̔�����������蕪���邽�߁A�t���O�Ōォ�痈�����͏R��悤�ɂ��� --EN:--In order to make a clear distinction between whether it ended in seconds or the length of the animation, use a flag to kick the person who came later
Osa_WaitAnim_EndFlag_A = 0;
Osa_IsWaitAnimCondition_A = 0;
--LuaCallParam(1590,3)
function OnEvent_1590_3(proxy,param)
	print("OnEvent_1590_3 begin");
	
	proxy:Warp( HiryuOsa_b4_evid , 2700 );
	
	--���ɑҋ@�A�j����������㏑�����Ȃ� --EN:--If it is already a standby animation, it will not be overwritten
	print("tyo_play_anime_id = ", tyo_play_anime_id);
	
	if	tyo_play_anime_id ~= 7001 then
		tyo_play_anime_id = 7001;
		proxy:ForcePlayAnimationStayCancel( HiryuOsa_b4_evid, tyo_play_anime_id );
	end
	
	if	param:IsNetMessage() == true then
		print("OnEvent_1590_3 return end");
		return;
	end
	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 1661, "OnEvnet_1590_4", 1.0, 0, 2, once );
		if	Osa_IsWaitAnimCondition_A ~= 1 then
			proxy:OnChrAnimEnd( 1661, HiryuOsa_b4_evid, tyo_play_anime_id, "OnEvnet_1590_5", once );
			Osa_IsWaitAnimCondition_A = 1;
		end
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	Osa_WaitAnim_EndFlag_A = 0;
	
	print("OnEvent_1590_3 end");
end


--�b���o�߂Ŕ���𔲂��鎞 --EN:--When exiting the judgment after the number of seconds has passed
function OnEvnet_1590_4(proxy,param)
	print("OnEvnet_1590_4 begin");
	if	Osa_WaitAnim_EndFlag_A == 0 then
		Osa_WaitAnim_EndFlag_A = 1;
		OnEvent_1590_anime_end(proxy,param);
	end
	print("OnEvnet_1590_4 end");
end

--�A�j���I���Ŕ���𔲂��鎞 --EN:--When exiting the judgment at the end of the animation
function OnEvnet_1590_5(proxy,param)
	print("OnEvnet_1590_5 begin");
	if	Osa_WaitAnim_EndFlag_A == 0 then
		Osa_WaitAnim_EndFlag_A = 2;
		proxy:LuaCallStartPlus( 1590, 10, tyo_play_anime_id );
		OnEvent_1590_anime_end(proxy,param);
	end
	Osa_IsWaitAnimCondition_A = 0;
	print("OnEvnet_1590_5 end");
end




------------------------------------------------------------------------------------------------------
--��1591���̈�A���u���X --EN:-- �� 1591 �� Breath area A
------------------------------------------------------------------------------------------------------
--LuaCallParam(1591,1)
function OnEvent_1591_1(proxy,param)
	print("OnEvent_1591_1 begin");
	tyo_play_anime_id = 7001;
	proxy:Warp( HiryuOsa_b4_evid , 2700 );--�ʘH���̗̈�Ƀ��[�v --EN:-- Warp to the passage side area
	proxy:ForcePlayAnimationStayCancel( HiryuOsa_b4_evid, tyo_play_anime_id );
	
	if	param:IsNetMessage() == true then
		print("OnEvent_1591 return end");
		return;
	end
--[[	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		proxy:OnChrAnimEnd( 1591, HiryuOsa_b4_evid, tyo_play_anime_id, "OnEvent_1591_1_1", once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
]]	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		local Delay = GetDelay_HiryuOsa(proxy);
		proxy:OnKeyTime2( 1591, "OnEvent_1591_1_2", Delay, 0, 2, once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	print("OnEvent_1591_1 end");
end


function OnEvent_1591_1_1(proxy,param)
	print("OnEvent_1591_1_1 begin");
	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		local Delay = GetDelay_HiryuOsa(proxy);
		proxy:OnKeyTime2( 1591, "OnEvent_1591_1_2", Delay, 0, 2, once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	
	print("OnEvent_1591_1_1 end");
end

function OnEvent_1591_1_2(proxy,param)
	print("OnEvent_1591_1_2 begin");
	
	--OnEvent_1591_2
	proxy:LuaCallStart(1591,2);
	
	print("OnEvent_1591_1_2 end");
end


--LuaCallParam(1591,1)
function OnEvent_1591_2(proxy,param)
	print("OnEvent_1591_2 begin");
	tyo_play_anime_id = 7002;
	proxy:Warp( HiryuOsa_b4_evid , 2700 );--�ʘH���̗̈�Ƀ��[�v --EN:-- Warp to the passage side area
	proxy:ForcePlayAnimationStayCancel( HiryuOsa_b4_evid, tyo_play_anime_id );
	
	if	param:IsNetMessage() == true then
		print("OnEvent_1591_2 return end");
		return;
	end
	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		proxy:OnChrAnimEnd( 1591, HiryuOsa_b4_evid, tyo_play_anime_id, "OnEvent_1590_anime_end", once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	
	print("OnEvent_1591_2 end");
end




------------------------------------------------------------------------------------------------------
--��1592���̈�B���u���X --EN:-- �� 1592 �� Breath area B
------------------------------------------------------------------------------------------------------
--LuaCallParam(1592,1)
function OnEvent_1592_1(proxy,param)
	print("OnEvent_1592_1 begin");
	tyo_play_anime_id = 7001;
	proxy:Warp( HiryuOsa_b4_evid , 2700 );--�ʘH���̗̈�Ƀ��[�v --EN:-- Warp to the passage side area
	proxy:ForcePlayAnimationStayCancel( HiryuOsa_b4_evid, tyo_play_anime_id );
	
	if	param:IsNetMessage() == true then
		print("OnEvent_1592 return end");
		return;
	end
--[[	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		proxy:OnChrAnimEnd( 1592, HiryuOsa_b4_evid, tyo_play_anime_id, "OnEvent_1592_1_1", once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
]]	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		local Delay = GetDelay_HiryuOsa(proxy);
		proxy:OnKeyTime2( 1592, "OnEvent_1592_1_2", Delay, 0, 2, once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	print("OnEvent_1592_1 end");
end


function OnEvent_1592_1_1(proxy,param)
	print("OnEvent_1592_1_1 begin");
	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		local Delay = GetDelay_HiryuOsa(proxy);
		proxy:OnKeyTime2( 1592, "OnEvent_1592_1_2", Delay, 0, 2, once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	
	print("OnEvent_1592_1_1 end");
end

function OnEvent_1592_1_2(proxy,param)
	print("OnEvent_1592_1_2 begin");
	
	--OnEvent_1592_2
	proxy:LuaCallStart(1592,2);
	
	print("OnEvent_1592_1_2 end");
end


--LuaCallParam(1592,1)
function OnEvent_1592_2(proxy,param)
	print("OnEvent_1592_2 begin");
	tyo_play_anime_id = 7003;
	proxy:Warp( HiryuOsa_b4_evid , 2700 );--�ʘH���̗̈�Ƀ��[�v --EN:-- Warp to the passage side area
	proxy:ForcePlayAnimationStayCancel( HiryuOsa_b4_evid, tyo_play_anime_id );
	
	if	param:IsNetMessage() == true then
		print("OnEvent_1592_2 return end");
		return;
	end
	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		proxy:OnChrAnimEnd( 1592, HiryuOsa_b4_evid, tyo_play_anime_id, "OnEvent_1590_anime_end", once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	
	print("OnEvent_1592_2 end");
end





------------------------------------------------------------------------------------------------------
--��1593���̈�C���u���X --EN:-- �� 1593 �� Bless area C
------------------------------------------------------------------------------------------------------
--LuaCallParam(1593,1)
function OnEvent_1593_1(proxy,param)
	print("OnEvent_1593_1 begin");
	tyo_play_anime_id = 7001;
	proxy:Warp( HiryuOsa_b4_evid , 2700 );--�ʘH���̗̈�Ƀ��[�v --EN:-- Warp to the passage side area
	proxy:ForcePlayAnimationStayCancel( HiryuOsa_b4_evid, tyo_play_anime_id );
	
	if	param:IsNetMessage() == true then
		print("OnEvent_1593 return end");
		return;
	end
	--[[
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		proxy:OnChrAnimEnd( 1593, HiryuOsa_b4_evid, tyo_play_anime_id, "OnEvent_1593_1_1", once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	]]
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		local Delay = GetDelay_HiryuOsa(proxy);
		proxy:OnKeyTime2( 1593, "OnEvent_1593_1_2", Delay, 0, 2, once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	
	print("OnEvent_1593_1 end");
end


function OnEvent_1593_1_1(proxy,param)
	print("OnEvent_1593_1_1 begin");
	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		local Delay = GetDelay_HiryuOsa(proxy);
		proxy:OnKeyTime2( 1593, "OnEvent_1593_1_2", Delay, 0, 2, once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	
	print("OnEvent_1593_1_1 end");
end

function OnEvent_1593_1_2(proxy,param)
	print("OnEvent_1593_1_2 begin");
	
	--OnEvent_1593_2
	proxy:LuaCallStart(1593,2);
	
	print("OnEvent_1593_1_2 end");
end


--LuaCallParam(1593,1)
function OnEvent_1593_2(proxy,param)
	print("OnEvent_1593_2 begin");
	tyo_play_anime_id = 7004;
	proxy:Warp( HiryuOsa_b4_evid , 2700 );--�ʘH���̗̈�Ƀ��[�v --EN:-- Warp to the passage side area
	proxy:ForcePlayAnimationStayCancel( HiryuOsa_b4_evid, tyo_play_anime_id );
	
	if	param:IsNetMessage() == true then
		print("OnEvent_1593_2 return end");
		return;
	end
	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		proxy:OnChrAnimEnd( 1593, HiryuOsa_b4_evid, tyo_play_anime_id, "OnEvent_1590_anime_end", once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	
	print("OnEvent_1593_2 end");
end



------------------------------------------------------------------------------------------------------
--��1594���L��A�Ƀu���X --EN:-- �� 1594 �� Breath at Square A
------------------------------------------------------------------------------------------------------
--LuaCallParam(1594,1)
function OnEvent_1594_1(proxy,param)
	print("OnEvent_1594_1 begin");
	tyo_play_anime_id = 7007;
	proxy:Warp( HiryuOsa_b4_evid , 2701 );--�ʘH���̗̈�Ƀ��[�v --EN:-- Warp to the passage side area
	proxy:ForcePlayAnimationStayCancel( HiryuOsa_b4_evid, tyo_play_anime_id );
	
	if	param:IsNetMessage() == true then
		print("OnEvent_1594 return end");
		return;
	end
--[[	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		proxy:OnChrAnimEnd( 1594, HiryuOsa_b4_evid, tyo_play_anime_id, "OnEvent_1594_1_1", once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
]]	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		local Delay = GetDelay_HiryuOsa(proxy);
		proxy:OnKeyTime2( 1594, "OnEvent_1594_1_2", Delay, 0, 2, once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	print("OnEvent_1594_1 end");
end


function OnEvent_1594_1_1(proxy,param)
	print("OnEvent_1594_1_1 begin");
	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		local Delay = GetDelay_HiryuOsa(proxy);
		proxy:OnKeyTime2( 1594, "OnEvent_1594_1_2", Delay, 0, 2, once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	
	print("OnEvent_1594_1_1 end");
end

function OnEvent_1594_1_2(proxy,param)
	print("OnEvent_1594_1_2 begin");
	
	--OnEvent_1594_2
	proxy:LuaCallStart(1594,2);
	
	print("OnEvent_1594_1_2 end");
end


--LuaCallParam(1594,2)
function OnEvent_1594_2(proxy,param)
	print("OnEvent_1594_2 begin");
	tyo_play_anime_id = 7005;
	proxy:Warp( HiryuOsa_b4_evid , 2701 );--�ʘH���̗̈�Ƀ��[�v --EN:-- Warp to the passage side area
	proxy:ForcePlayAnimationStayCancel( HiryuOsa_b4_evid, tyo_play_anime_id );
	
	if	param:IsNetMessage() == true then
		print("OnEvent_1594_2 return end");
		return;
	end
	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		proxy:OnChrAnimEnd( 1594, HiryuOsa_b4_evid, tyo_play_anime_id, "OnEvent_1590_anime_end", once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	
	print("OnEvent_1594_2 end");
end



------------------------------------------------------------------------------------------------------
--��1660���L��B�Ƀu���X --EN:-- �� 1660 �� Breath at Square B
------------------------------------------------------------------------------------------------------
--LuaCallParam(1660,1)
function OnEvent_1660_1(proxy,param)
	print("OnEvent_1660_1 begin");
	tyo_play_anime_id = 7007;
	proxy:Warp( HiryuOsa_b4_evid , 2701 );--�ʘH���̗̈�Ƀ��[�v --EN:-- Warp to the passage side area
	proxy:ForcePlayAnimationStayCancel( HiryuOsa_b4_evid, tyo_play_anime_id );
	
	if	param:IsNetMessage() == true then
		print("OnEvent_1660 return end");
		return;
	end
--[[	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		proxy:OnChrAnimEnd( 1660, HiryuOsa_b4_evid, tyo_play_anime_id, "OnEvent_1660_1_1", once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
]]	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		local Delay = GetDelay_HiryuOsa(proxy);
		proxy:OnKeyTime2( 1660, "OnEvent_1660_1_2", Delay, 0, 2, once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	print("OnEvent_1660_1 end");
end


function OnEvent_1660_1_1(proxy,param)
	print("OnEvent_1660_1_1 begin");
	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		local Delay = GetDelay_HiryuOsa(proxy);
		proxy:OnKeyTime2( 1660, "OnEvent_1660_1_2", Delay, 0, 2, once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	
	print("OnEvent_1660_1_1 end");
end

function OnEvent_1660_1_2(proxy,param)
	print("OnEvent_1660_1_2 begin");
	
	--OnEvent_1660_2
	proxy:LuaCallStart(1660,2);
	
	print("OnEvent_1660_1_2 end");
end


--LuaCallParam(1660,2)
function OnEvent_1660_2(proxy,param)
	print("OnEvent_1660_2 begin");
	tyo_play_anime_id = 7017;
	proxy:Warp( HiryuOsa_b4_evid , 2701 );--�ʘH���̗̈�Ƀ��[�v --EN:-- Warp to the passage side area
	proxy:ForcePlayAnimationStayCancel( HiryuOsa_b4_evid, tyo_play_anime_id );
	
	if	param:IsNetMessage() == true then
		print("OnEvent_1660_2 return end");
		return;
	end
	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		proxy:OnChrAnimEnd( 1660, HiryuOsa_b4_evid, tyo_play_anime_id, "OnEvent_1590_anime_end", once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	
	print("OnEvent_1660_2 end");
end





------------------------------------------------------------------------------------------------------
--��1661���L��C�Ƀu���X --EN:-- �� 1661 �� Breath at Plaza C
------------------------------------------------------------------------------------------------------
--LuaCallParam(1661,1)
function OnEvent_1661_1(proxy,param)
	print("OnEvent_1661_1 begin");
	tyo_play_anime_id = 7007;
	proxy:Warp( HiryuOsa_b4_evid , 2701 );--�ʘH���̗̈�Ƀ��[�v --EN:-- Warp to the passage side area
	proxy:ForcePlayAnimationStayCancel( HiryuOsa_b4_evid, tyo_play_anime_id );
	
	if	param:IsNetMessage() == true then
		print("OnEvent_1661 return end");
		return;
	end
--[[	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		proxy:OnChrAnimEnd( 1661, HiryuOsa_b4_evid, tyo_play_anime_id, "OnEvent_1661_1_1", once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
]]	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		local Delay = GetDelay_HiryuOsa(proxy);
		proxy:OnKeyTime2( 1661, "OnEvent_1661_1_2", Delay, 0, 2, once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	
	print("OnEvent_1661_1 end");
end


function OnEvent_1661_1_1(proxy,param)
	print("OnEvent_1661_1_1 begin");
	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		local Delay = GetDelay_HiryuOsa(proxy);
		proxy:OnKeyTime2( 1661, "OnEvent_1661_1_2", Delay, 0, 2, once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	
	print("OnEvent_1661_1_1 end");
end

function OnEvent_1661_1_2(proxy,param)
	print("OnEvent_1661_1_2 begin");
	
	--OnEvent_1661_2
	proxy:LuaCallStart(1661,2);
	
	print("OnEvent_1661_1_2 end");
end


--LuaCallParam(1661,2)
function OnEvent_1661_2(proxy,param)
	print("OnEvent_1661_2 begin");
	tyo_play_anime_id = 7019;
	proxy:Warp( HiryuOsa_b4_evid , 2701 );--�ʘH���̗̈�Ƀ��[�v --EN:-- Warp to the passage side area
	proxy:ForcePlayAnimationStayCancel( HiryuOsa_b4_evid, tyo_play_anime_id );
	
	if	param:IsNetMessage() == true then
		print("OnEvent_1661_2 return end");
		return;
	end
	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		proxy:OnChrAnimEnd( 1661, HiryuOsa_b4_evid, tyo_play_anime_id, "OnEvent_1590_anime_end", once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	
	print("OnEvent_1661_2 end");
end




------------------------------------------------------------------------------------------------------
--��1662���L��x�����[�v --EN:-- �� 1662 �� Plaza alert loop
------------------------------------------------------------------------------------------------------
Osa_WaitAnim_EndFlag_B = 0;
Osa_IsWaitAnimCondition_B = 0;
--LuaCallParam(1662,1)
function OnEvent_1662_1(proxy,param)
	print("OnEvent_1662_1 begin");
	--proxy:ForcePlayAnimationStayCancel( HiryuOsa_b4_evid, tyo_play_anime_id );
	proxy:Warp( HiryuOsa_b4_evid , 2701 );--�ʘH���̗̈�Ƀ��[�v --EN:-- Warp to the passage side area
	if	tyo_play_anime_id ~= 7007 then
		tyo_play_anime_id = 7007;
		proxy:ForcePlayAnimationStayCancel( HiryuOsa_b4_evid, tyo_play_anime_id );
	end
	
	if	param:IsNetMessage() == true then
		print("OnEvent_1662_1 return end");
		return;
	end
	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 1661, "OnEvent_1662_2", 1.0, 0, 2, once );
		if	Osa_IsWaitAnimCondition_B ~= 1 then
			proxy:OnChrAnimEnd( 1661, HiryuOsa_b4_evid, tyo_play_anime_id, "OnEvent_1662_3", once );
			Osa_IsWaitAnimCondition_B = 1;
		end
		Osa_WaitAnim_EndFlag_B = 0;
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	
	print("OnEvent_1662_1 end");
end

--�b���o�߂Ŕ���𔲂��鎞 --EN:--When exiting the judgment after the number of seconds has passed
function OnEvent_1662_2(proxy,param)
	print("OnEvent_1662_2 begin");
	if	Osa_WaitAnim_EndFlag_B == 0 then
		Osa_WaitAnim_EndFlag_B = 1;
		OnEvent_1590_anime_end(proxy,param);
	end
	print("OnEvent_1662_2 end");
end

--�A�j���I���Ŕ���𔲂��鎞 --EN:--When exiting the judgment at the end of the animation
function OnEvent_1662_3(proxy,param)
	print("OnEvent_1662_3 begin");
	if	Osa_WaitAnim_EndFlag_B == 0 then
		Osa_WaitAnim_EndFlag_B = 2;
		proxy:LuaCallStartPlus( 1590, 10, tyo_play_anime_id );
		OnEvent_1590_anime_end(proxy,param);
	end
	Osa_IsWaitAnimCondition_B = 0;
	print("OnEvent_1662_3 end");
end










------------------------------------------------------------------------------------------------------
--��1595���򗳂̒�������(�ʘH��) --EN:-- �� 1595 �� The chief of the flying dragon dies (passage version)
------------------------------------------------------------------------------------------------------
--LuaCallParam(1595,1)
function OnEvent_1595_1(proxy,param)
	print("OnEvent_1595_1 begin");
	tyo_play_anime_id = 7006;
	proxy:Warp( HiryuOsa_b4_evid , 2700 );--�ʘH���̗̈�Ƀ��[�v --EN:-- Warp to the passage side area
	proxy:ForcePlayAnimation( HiryuOsa_b4_evid, tyo_play_anime_id );
	
	
	
	if	param:IsNetMessage() == true then
		print("OnEvent_1595_1 return end");
		return;
	end
	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		proxy:OnChrAnimEnd( 1595, HiryuOsa_b4_evid, tyo_play_anime_id, "OnEvent_1595_2", once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	
	
	print("OnEvent_1595_1 end");
end


function OnEvent_1595_2(proxy,param)
	print("OnEvent_1595_2 begin");
	
	SetNpcStateFlag(proxy, param, tyo_flag_list, TYO_STATE_DEAD );
	
	--�򗳂̒��������Ǝ���ł�����A�g���t�B�[�A�����b�N --EN:--If the wyvern chief dies properly, the trophy will be unlocked
	if	proxy:IsCompleteEvent( 1770 ) == true then
		HiryuOsaDead(proxy,param);
	end
	
	--OnEvent_1590_syncroInvalid
	proxy:LuaCallStartPlus( 1590, 2, HiryuOsa_b4_evid );
	
	print("OnEvent_1595_2 end");
end



------------------------------------------------------------------------------------------------------
--��1596���򗳂̒�������(�Q�[�g�O��) --EN:-- �� 1596 �� The chief of the flying dragon dies (pre-gate version)
------------------------------------------------------------------------------------------------------
--LuaCallParam(1596,1)
function OnEvent_1596_1(proxy,param)
	print("OnEvent_1596_1 begin");
	tyo_play_anime_id = 7010;
	proxy:Warp( HiryuOsa_b4_evid , 2701 );--�ʘH���̗̈�Ƀ��[�v --EN:-- Warp to the passage side area
	proxy:ForcePlayAnimation( HiryuOsa_b4_evid, tyo_play_anime_id );
	
	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		proxy:OnChrAnimEnd( 1596, HiryuOsa_b4_evid, tyo_play_anime_id, "OnEvent_1596_2", once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	
	print("OnEvent_1596_1 end");
end


function OnEvent_1596_2(proxy,param)
	print("OnEvent_1596_2 begin");
	
	--�򗳂̒��������Ǝ���ł�����A�g���t�B�[�A�����b�N --EN:--If the wyvern chief dies properly, the trophy will be unlocked
	if	proxy:IsCompleteEvent( 1770 ) == true then
		HiryuOsaDead(proxy,param);
	end
	
	--OnEvent_1590_syncroInvalid
	proxy:LuaCallStartPlus( 1590, 2, HiryuOsa_b4_evid );
	
	print("OnEvent_1596_2 end");
end











------------------------------------------------------------------------------------------------------
--��1597���򗳂̒����ړ�(�ʘH���Q�[�g�O) --EN:-- �� 1597 �� Flying dragon chief moves (passage �� in front of the gate)
------------------------------------------------------------------------------------------------------
--LuaCallParam(1597,1)
function OnEvent_1597_1(proxy,param)
	print("OnEvent_1597_1 begin");
	tyo_play_anime_id = 7008;
	proxy:Warp( HiryuOsa_b4_evid , 2700 );--�ʘH���̗̈�Ƀ��[�v --EN:-- Warp to the passage side area
	proxy:ForcePlayAnimationStayCancel( HiryuOsa_b4_evid, tyo_play_anime_id );
	SetNpcStateFlag(proxy, param, tyo_flag_list, TYO_STATE_WARNING_GATE );
	
	if	param:IsNetMessage() == true then
		print("OnEvent_1597_1 return end");
		return;
	end
	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		proxy:OnChrAnimEnd( 1597, HiryuOsa_b4_evid, tyo_play_anime_id, "OnEvent_1590_anime_end", once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	
	print("OnEvent_1597_1 end");
end


------------------------------------------------------------------------------------------------------
--��1598���򗳂̒����ړ�(�Q�[�g�O���ʘH) --EN:-- �� 1598 �� The chief of the flying dragon moves (in front of the gate �� passage)
------------------------------------------------------------------------------------------------------
--LuaCallParam(1598,1)
function OnEvent_1598_1(proxy,param)
	print("OnEvent_1598_1 begin");
	tyo_play_anime_id = 7009;
	proxy:Warp( HiryuOsa_b4_evid , 2701 );--�ʘH���̗̈�Ƀ��[�v --EN:-- Warp to the passage side area
	proxy:ForcePlayAnimationStayCancel( HiryuOsa_b4_evid, tyo_play_anime_id );
	SetNpcStateFlag(proxy, param, tyo_flag_list, TYO_STATE_WARNING_AISLE );
	
	if	param:IsNetMessage() == true then
		print("OnEvent_1598_1 return end");
		return;
	end
	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		proxy:OnChrAnimEnd( 1598, HiryuOsa_b4_evid, tyo_play_anime_id, "OnEvent_1590_anime_end", once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	
	print("OnEvent_1598_1 end");
end



--LuaCallParam(1590,2)
function OnEvent_1590_syncroInvalid(proxy,param)
	print("OnEvent_1590_syncroInvalid begin");
	
	local evid = param:GetParam3()
	InvalidCharactor( proxy, evid );
	
	print("OnEvent_1590_syncroInvalid end");
end



function Osa_ForceSynchroAnime(proxy,param)
	print("Osa_ForceSynchroAnime begin");
	local animId = param:GetParam3();
	tyo_play_anime_id = animId;
	proxy:ForcePlayAnimationStayCancel( HiryuOsa_b4_evid, tyo_play_anime_id );
	print("Osa_ForceSynchroAnime end");
end


--------------------------------------------------------------------------------------
--��1770���򗳂̒������ʁ� --EN:-- �� 1770 �� The chief of the wyvern dies ��
--------------------------------------------------------------------------------------

--��1770���򗳂̒������ʁ�(HP�Ď�) --EN:-- �� 1770 �� The chief of the flying dragon dies �� (HP monitoring)
function OnEvent_1770(proxy, param)
	print("OnEvent_1770 begin");

	proxy:SetEventFlag( 1770 , 1 );--HP�Ď��t���OON --EN:--HP monitor flag ON
	
	print("OnEvent_1770 end");
end



--------------------------------------------------------------------------------------
--��1635���G���x�[�^�����遡 --EN:-- �� 1635 �� elevator rises ��
--------------------------------------------------------------------------------------

--��1635���G���x�[�^�����遡 --EN:-- �� 1635 �� elevator rises ��
function OnEvent_1635(proxy, param)
	print("OnEvent_1635 begin");

	--�A�j���Đ����͔������Ȃ� --EN:--Does not activate during animation playback
	if	proxy:IsCompleteEvent( 1631 ) == true then
		--�����҂����C���t�H --EN:--Invoker only info
		if param:IsNetMessage() == false then
			--�����J���Ȃ��ꍇ�̃��b�Z�[�W��\�� --EN:-- Display a message when the door does not open
			--proxy:InfomationMenu( INFOMENU_TYPE_SIMPLE, 0, MSG_CATEGORY_EVENT, 10010170, 1);
			--proxy:ShowGenDialog(10010170,1,1,true);
			proxy:RepeatMessage_begin();
			proxy:NotNetMessage_begin();
				proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010170, 0, 6, -1, GEN_DIALOG_DIST, once );
			proxy:NotNetMessage_end();
			proxy:RepeatMessage_end();
		end		
		print("OnEvent_1635 return end");
		return;
	end	
	
	ElevatorEvent(proxy,param);	
	
	print("OnEvent_1635 end");
end

function OnEvent_1633(proxy,param)
	print("OnEvent_1633")
	--�A�j���Đ����͔������Ȃ� --EN:--Does not activate during animation playback
	if	proxy:IsCompleteEvent( 1631 ) == true then
--~ 		--�����҂����C���t�H --EN:--Invoker only info
--~ 		if param:IsNetMessage() == false then
--~ 			--�����J���Ȃ��ꍇ�̃��b�Z�[�W��\�� --EN:-- Display a message when the door does not open
--~ 			--proxy:InfomationMenu( INFOMENU_TYPE_SIMPLE, 0, MSG_CATEGORY_EVENT, 10010170, 1);
--~ 			--proxy:ShowGenDialog(10010170,1,1,true);
--~ 			proxy:RepeatMessage_begin();
--~ 			proxy:NotNetMessage_begin();
--~ 				proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010170, 0, 6, -1, GEN_DIALOG_DIST, once );
--~ 			proxy:NotNetMessage_end();
--~ 			proxy:RepeatMessage_end();
--~ 		end		
		print("OnEvent_1633 return end");
		return;
	end	
	
	ElevatorEvent(proxy,param);
	print("OnEvent_1633 end")
end

function ElevatorEvent(proxy,param)
	proxy:DeleteEvent( 1633 );
	--��ɂ����ԂȂ�~��A���ɂ����ԂȂ珸��A�j���Đ� --EN:--If it's up, get down, if it's down, get up and play animation
	if proxy:IsClient() == false then
		if	proxy:IsCompleteEvent( 1630 ) == false then
			proxy:LuaCallStart( 1635 , 5 );
			--proxy:ForcePlayAnimation( 1620 , 1 );--�G���x�[�^������A�j���Đ� --EN:--Play an animation of the elevator going up
		else
			proxy:LuaCallStart( 1635 , 6 );
			--proxy:ForcePlayAnimation( 1620 , 2 );--�G���x�[�^���~���A�j���Đ� --EN:--Play an animation of the elevator going down
			proxy:DeleteEvent(1632);
		end
	end
	
	--�v���C���̃A�j���͖��� --EN:--No player animation
	
	local evId_list   = {1650,1651,1652,1653,1654,1655,1660,1661,1662};
	local animId_list = {	2,	 2,	  2,   2,   2,   2,   0,   0,   0};
	local obj_num = table.getn(evId_list);
	for index = 1, obj_num, 1 do
		proxy:PlayAnimation( evId_list[index], animId_list[index] );
	end

	--�����҂������A�j���I�����Ď�(�K���N���C�A���g�̐��E�ŃG���x�[�^�I�u�W�F�N�g���ǂݍ��܂�Ă���킯�ł͂Ȃ��̂�) --EN:--Only the invoker monitors the end of the animation (because the elevator object is not always loaded in the client world)
	if	proxy:IsClient() == false then
		proxy:NotNetMessage_begin();
			proxy:RepeatMessage_begin();
				if	proxy:IsCompleteEvent( 1630 ) == false then
					--��1635���G���x�[�^������A�j���I���� --EN:--��1635��End of the animation when the elevator rises��
					proxy:OnCharacterAnimEnd( 1635 , 1620 , 1 , "OnEvent_1635_anime_end" , once );
					proxy:LuaCallStart( 1635, 2 );--���̎��_�ŏ㉺�͊m�� --EN:--At this point, up and down are fixed
				else
					--��1635���G���x�[�^���~���A�j���I���� --EN:--��1635��The animation ends when the elevator gets off��
					proxy:OnCharacterAnimEnd( 1635 , 1620 , 2 , "OnEvent_1635_anime_end" , once );
					proxy:LuaCallStart( 1635, 2 );--���̎��_�ŏ㉺�͊m�� --EN:--At this point, up and down are fixed
				end
			proxy:RepeatMessage_end();
		proxy:NotNetMessage_end();
	end
end

--��1635_anime_end���G���x�[�^������A�j���I���� --EN:--��1635_anime_end��The end of the elevator animation��
function OnEvent_1635_anime_end(proxy, param)
	print("OnEvent_1635_anime_end begin");
	
	--���G���x�[�^���~���Ď��ǉ��� --EN:--��Addition of monitoring when the elevator gets off��
	--proxy:OnPlayerActionInRegion( 1636 , 2651 , "OnEvent_1636" , HELPID_START , everytime );
	--proxy:OnDistanceActionPlus( 1636 , LOCAL_PLAYER, 1620, "OnEvent_1635" , 1, HELPID_START , 0, 100, 0.0, 0.0, 0.0, everytime );--����p --EN:--For climbing
	
	
	--�t���O�������A�[�R�[��()--�A�j���I���t���O���� --EN:--flag sync lure call()--anime end flag sync
	proxy:LuaCallStart( 1635, 4 );
	
	if proxy:IsCompleteEvent( 1630 ) == true then
		proxy:NotNetMessage_begin();
		proxy:RepeatMessage_begin();
			proxy:OnKeyTime2( 1632 , "OnEvent_1632",0.5,0,1,once);
		proxy:RepeatMessage_end();
		proxy:NotNetMessage_end();
	end
	
	print("OnEvent_1635_anime_end end");
end

function OnEvent_1635_flag(proxy,param)
	print("OnEvent_1635_flag begin");
	
	if	proxy:IsCompleteEvent( 1630 ) == true then
		proxy:SetEventFlag( 1630, false );
	else
		proxy:SetEventFlag( 1630, true );
	end	
	print("OnEvent_1635_flag end");
end

function OnEvent_1635_animeflag(proxy,param)
	print("OnEvent_1635_animeflag begin");
	--�A�j�����t���OOFF --EN:--Animation Flag OFF
	proxy:SetEventFlag( 1631 , false );
	print("OnEvent_1635_animeflag end");
end
 
--[[
function OnEvent_1635_Out(proxy,param)
	print("OnEvent_1635_Out begin");
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 1635, "OnEvent_1635_Out_1", 0.0, 0, 2, once );
	proxy:NotNetMessage_end();
	print("OnEvent_1635_Out end");
end

--���̏u�Ԃ���OnNetRegion�̃t���O�ݒ肪�L���ɂȂ�Ȃ��̂ŁA1�t���[���x�点�� --EN:--At that moment, the OnNetRegion flag setting does not take effect, so delay by 1 frame
function OnEvent_1635_Out_1(proxy,param)
	print("OnEvent_1635_Out_1 begin");
	--�S�����G���x�[�^�̈悩�炢�Ȃ��Ȃ��Ă�����G���x�[�^�𓮂��� --EN:--Move the elevator when everyone is out of the elevator area
	if	proxy:IsCompleteEvent( 1636 ) == false then
		--�G���x�[�^����ɂ����Ԃ���Ȃ��Ɣ��������Ȃ�(�K�v�Ȃ�����) --EN:--Do not activate unless the elevator is at the top (may not be necessary)
		if	proxy:IsCompleteEvent( 1630 ) == true then
			--��OnEvent_1635 --EN:--��OnEvent_1635
			proxy:LuaCallStart( 1635, 3 );
		end
	end
	print("OnEvent_1635_Out_1 end");
end
]]


--��ɏオ�肫�������̊Ď� --EN:--Monitoring when it reaches the top
function OnEvent_1632( proxy,param)
	print("OnEvent_1632 begin");
	proxy:NotNetMessage_begin();
	proxy:RepeatMessage_begin();
		proxy:OnRegistFunc( 1632 , "Check_1632_1","OnEvent_1632_1",1,once);
		
		--�̈�ɂ����Ƌ��Ă���莞�Ԃō~���悤�� --EN:--Even if you stay in the area for a long time, you will get off after a certain amount of time.
		proxy:OnKeyTime2( 1633 , "OnEvent_1633",ElevatorTimer,0,100,once);
	proxy:RepeatMessage_end();
	proxy:NotNetMessage_end();
	print("OnEvent_1632 end");
end

--�̈�ɒN�����Ȃ����H --EN:--Is there anyone in the realm?
function Check_1632_1(proxy,param)
	if proxy:IsCompleteEvent( 1636 ) == true then
		return false;
	end
	return true;
end

--�̈�ɒN�����Ȃ��̂ŃG���x�[�^�[�����낷 --EN:--There is no one in the area, so let the elevator go down
function OnEvent_1632_1(proxy,param)
	print("OnEvent_1632_1 begin");
	if proxy:IsClient() == false then
		proxy:LuaCallStart( 1635, 3 );
	end
	print("OnEvent_1632_1 end");
end

function OnEvent_1635_UpAnime(proxy,param)
	if proxy:IsCompleteEvent( 1631 ) == false then
		proxy:ForcePlayAnimation( 1620 , 1 );--�G���x�[�^������A�j���Đ� --EN:--Play an animation of the elevator going up
		--�A�j�����t���OON --EN:--Animation Flag ON
		proxy:SetEventFlag( 1631 , true );
	end
end

function OnEvent_1635_DownAnime(proxy,param)
	if proxy:IsCompleteEvent( 1631 ) == false then
		proxy:ForcePlayAnimation( 1620 , 2 );--�G���x�[�^���~���A�j���Đ� --EN:--Play an animation of the elevator going down
		--�A�j�����t���OON --EN:--Animation Flag ON
		proxy:SetEventFlag( 1631 , true );
	end
end

--[[
--------------------------------------------------------------------------------------
--��1636���G���x�[�^���~��遡 --EN:-- �� 1636 �� Elevator gets off ��
--------------------------------------------------------------------------------------

--��1636���G���x�[�^���~��遡 --EN:-- �� 1636 �� Elevator gets off ��
function OnEvent_1636(proxy, param)
	print("OnEvent_1636 begin");
		
	--�G���x�[�^����ɂ���Ƃ��������� --EN:--Response only when the elevator is up
	if proxy:IsCompleteEvent( 1631 ) == true then
	
		proxy:PlayAnimation( 1620 , 2 );--�G���x�[�^���~���A�j���Đ� --EN:--Play an animation of the elevator going down
	
		local evId_list   = {1650,1651,1652,1653,1654,1655,1660,1661,1662};
		local animId_list = {	2,	 2,	  2,   2,   2,   2,   0,   0,   0};
		local obj_num = table.getn(evId_list);
		for index = 1, obj_num, 1 do
			proxy:PlayAnimation( evId_list[index], animId_list[index] );
		end
		
		proxy:NotNetMessage_begin();
			--��1636���G���x�[�^���~���A�j���I���� --EN:--��1636��The animation ends when the elevator gets off��
			proxy:OnCharacterAnimEnd( 1636 , 1620 , 2 , "OnEvent_1636_anime_end" , once );
		proxy:NotNetMessage_end();
		
		--�G���x�[�^����ɂ����ԂɃt���O�����킹�� --EN:-- flag the state where the elevator is up
		proxy:SetEventFlag( 1630 , true ); --���ɂ��� --EN:--below
		proxy:SetEventFlag( 1631 , false );--��ɂȂ� --EN:-- not above
	end		

	print("OnEvent_1636 end");
end

--��1636_anime_end���G���x�[�^���~���A�j���I���� --EN:--��1636_anime_end��The end of the animation when the elevator gets off��
function OnEvent_1636_anime_end(proxy, param)
	print("OnEvent_1636_anime_end begin");

	proxy:DeleteEvent( 1636 );--�G���x�[�^���~���̊Ď��폜 --EN:--Delete the monitor when the elevator gets off
	--���G���x�[�^������Ď��ǉ��� --EN:--��Addition of monitoring when the elevator rises��
	proxy:OnPlayerActionInRegion( 1635 , 2650 , "OnEvent_1635" , HELPID_START , everytime );
	--proxy:OnDistanceActionPlus( 1635 , LOCAL_PLAYER, 1620, "OnEvent_1635" , 1, HELPID_START , 0, 100, 0.0, 0.0, 0.0, everytime );--����p --EN:--For climbing
	
	print("OnEvent_1636_anime_end end");
end

]]

--------------------------------------------------------------------------------------
--��4503���\�E�����聡 --EN:-- �� 4503 �� Get Soul ��
--------------------------------------------------------------------------------------

function OnEvent_4503(proxy, param)
	print("OnEvent_4503 begin");
	
	--�v���C���[�̓����A�j���[�V����(true:�p�[�e�B�[�v���C���[���A�j���[�V��������) --EN:--Player synchronous animation (true: party player animated)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_PICK ) == true then--�V�����A�j��  --EN:-- new anime
		print("OnEvent_4503 end");
		return true;
	end
	
	proxy:NotNetMessage_begin();
		--0.0�b��ɃA�C�e���擾�C�x���g�𔭍s --EN:-- Issue an item acquisition event after 0.0 seconds
		proxy:OnKeyTime2( 4503, "OnEvent_4503_1", 0.0, 0, 0, once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_4103 end");
end


--��4503_1���A�C�e���擾�� --EN:-- �� 4503_1 �� item acquisition ��
function OnEvent_4503_1(proxy, param)
	print("OnEvent_4503_1 begin");

	--�A�C�e���擾�֐�--�p�����[�^10101�Q�� --EN:--item retrieval function--see parameter 10101
	proxy:GetRateItem(10101);	
	proxy:GetRateItem(10182);
	proxy:GetRateItem(10183);
	proxy:GetRateItem(10184);
	proxy:GetRateItem(10185);
	
	--�A�C�e�����擾�ς� --EN:--item already acquired
	proxy:SetEventFlag( 4503, 1 );
	
	--�󔠃V�F�[�_�[�͏����܂��� --EN:--Treasure chest shader does not disappear
	--proxy:TreasureDispModeChange( 1979 , false );

	--SFX�������� --EN:--SFX disappear
	proxy:InvalidSfx( 1640, true );--SFX ������ --EN:--Disable SFX
	--proxy:InvalidSfx( 1641, true );--���̗��q --EN:--Particles of light
		
	if proxy:IsCompleteEvent( 4510 ) == false then
		proxy:NotNetMessage_begin();
			--�u�Ԃŕ\������ƃ��j���[����ɏo��̂ő҂� --EN:--If you display it instantly, the menu will appear first, so wait
			proxy:OnKeyTime2( 4510 , "OnEvent_4510_wait",0.5 , 0 , 1, once);			
		proxy:NotNetMessage_end();
	else
		--���v�΂Ń��[�v�p�̊Ď���ǉ��� --EN:--�� Added surveillance for warp with keystone ��
		proxy:OnDistanceActionAttribute( 4505 , LOCAL_PLAYER , 1979 , "OnEvent_4505" , WarpGimmickDist_A , HELPID_GO_TO_SEKITYUU , 0 , 180 , ATTR_NOSESSION , everytime );
	end		

	print("OnEvent_4503_1 end");
end


--�A�C�e���擾��̃E�F�C�g --EN:--Wait after getting item
function OnEvent_4510_wait(proxy,param)
	print("OnEvent_4510_wait begin");
	proxy:NotNetMessage_begin();
		--�C���t�H���j���[��������̂�҂����� --EN:--I want to wait for the info menu to disappear
		proxy:OnRegistFunc( 4510 , "Check_4510" , "OnEvent_4510" , 1 , ocne);
	proxy:NotNetMessage_end();
	print("OnEvent_4510_wait end");
end	
--�C���t�H�҂� --EN:--Waiting for info
function Check_4510(proxy)
	if proxy:IsShowMenu_InfoMenu() == true then
		return false;
	end
	return true;
end

--��b�����\�� --EN:--Conversation activation display
function OnEvent_4510(proxy,param)
	print("OnEvent_4510 begin");
	proxy:NotNetMessage_begin();
		--��b���� --EN:--Conversation activation
		proxy:CloseMenu();
		proxy:TalkNextPage( 4510 );
		proxy:SetEventFlag( 4510 , true );
	proxy:NotNetMessage_end();
	--���v�΂Ń��[�v�p�̊Ď���ǉ���	 --EN:--�� Added surveillance for warp with keystone ��
	proxy:OnDistanceActionAttribute( 4505 , LOCAL_PLAYER , 1979 , "OnEvent_4505" , WarpGimmickDist_A , HELPID_GO_TO_SEKITYUU , 0 , 180 , ATTR_NOSESSION , everytime );
	print("OnEvent_4510 end");
end

--------------------------------------------------------------------------------------
--�Β��Ƀ��[�v(�{�X�|������p)��4505 --EN:-- Warp to the stone pillar (for after defeating the boss) 4505
--------------------------------------------------------------------------------------

--��4505���Β��Ƀ��[�v�� --EN:-- �� 4505 �� Warp to the stone pillar ��
function OnEvent_4505(proxy,param)	

	if proxy:IsCompleteEvent( 4505 ) == true then
		return;
	end	

	print("OnEvent_4505 begin");
	
	proxy:RepeatMessage_begin();
		--��4505_1���I�����j���[�̊Ď��� --EN:--��4505_1��Monitor selection menu��
		proxy:OnSelectMenu(4505, "OnEvent_4505_0", 10010710, 0, 2, 1979, 2, once);			
	proxy:RepeatMessage_end();
	
	print("OnEvent_4505 end");
end

--��4505_0���I�����j���[�̊Ď��� --EN:--��4505_0��Monitor selection menu��
function OnEvent_4505_0(proxy, param)
	print("OnEvent_4505_0 begin");	
	
	if proxy:IsSession() == false then
		proxy:PlayAnimation( LOCAL_PLAYER , 8283 );--�v�΂ɐG���A�j�����Đ� --EN:--Play the animation that touches the keystone
		proxy:NoAnimeTurnCharactor( 10000 , 1979 ,TURNSKIP_ANGLE);
		
		proxy:NotNetMessage_begin();
			--���v�΂ɐG���A�j���Đ��I���� --EN:--��Animation touching the keystone ends��
			proxy:OnChrAnimEnd( 4505 , LOCAL_PLAYER , 8283 , "OnEvent_4505_1" , once );
		proxy:NotNetMessage_end();
		
		proxy:SetEventFlag( 4505 , 1 );
	else
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010720, 0, 6, 1983, GEN_DIALOG_DIST, once );
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
	end
	
	print("OnEvent_4505_0 end");
end

--��4505_1�������E�ɋA��A�j�����Đ��I���� --EN:--��4505_1��Finish playing animation to return to own world��
function OnEvent_4505_1(proxy,param)	
	print("OnEvent_4505_1 begin");
	
	proxy:PlayAnimation( 10000 , 8284 );--�����E�ɋA��A�j�����Đ� --EN:--Play animation to return to your own world
	--�Β��֖߂��Ă�������̃t���O�𗧂Ă� --EN:--Flag the judgment of returning to the stone pillar
	proxy:SetEventFlag(8083, true);
	
	proxy:SetEventFlag( 4505 , 0 );	
	--���S�񕜗v�� --EN:-- full recovery request
	proxy:RequestFullRecover();
	proxy:WarpNextStage( 1, 0, 0, 0, 1006 );
	
	print("OnEvent_4505_1 end");
end

--------------------------------------------------------------------------------------
--�r�������O�������G�΁�1712 --EN:-- Bjrn Grum is hostile �� 1712
--------------------------------------------------------------------------------------
--��1712���r�������O�������G�� --EN:-- �� 1712 �� Bjrn Grum is hostile
function OnEvent_1711(proxy,param)
	print("OnEvent_1711 begin");
	
	if proxy:IsCompleteEvent(BIYO_STATE_BATTLE_FLY_DRAGON) == true then
		SetNpcStateFlag( proxy , param , biyo_flag_list , BIYO_STATE_HOSTILE_IN_GATE_FRONT );
		proxy:SetEventCommand( 698 , 51 );--EzState�ɐ���ԍ�(�����オ��)��n�� --EN:-- Pass control number (stand up) to EzState
		proxy:EnableLogic( 698, true );--�r�����W�b�NON --EN:--Beyologic ON
		proxy:SetTeamType( 698, TEAM_TYPE_AngryFriend );
		proxy:EraseEventSpecialEffect_2(698,5064);
		proxy:SetEventFlag( 1711, true );
	end
	
	print("OnEvent_1711 end");
end

--��1712���r�������O�������S --EN:-- �� 1712 �� Bjrn Grum died
function OnEvent_1712(proxy,param)
	print("OnEvent_1712 begin");
	
	SetNpcStateFlag( proxy , param , biyo_flag_list , BIYO_STATE_DEAD );
	proxy:SetEventFlag( 1712, true );
	
	print("OnEvent_1712 end");
end


--��1717���r�������O�������Q�� --EN:--�� 1717 �� Bjrn Gurm sleeps
function OnEvent_1717(proxy,param)
	print("OnEvent_1717 begin");
	
	proxy:EnableLogic( 698, false );--�r�����W�b�NOFF --EN:--Beyologic OFF
	proxy:SetTeamType( 698 , TEAM_TYPE_Friend );
	proxy:SetEventCommand( 698, 60 );--EzState�ɐ���ԍ�(�Q��)��n�� --EN:-- Pass control number (sleep) to EzState
	
	proxy:SetEventFlag( 1717, true );
	print("OnEvent_1717 end");
end


--��1700�������h�����q�@���S���� --EN:-- �� 1700 �� Prince Lendl dies
function OnEvent_1700(proxy,param)
	print("OnEvent_1700 begin");
	
	--�������Ȃ���Ԃ̂Ƃ��Ɏ���ł��A��Ԃ͐؂�ւ��Ȃ� --EN:--If you die when you are no longer in the state, the state will not switch
	if	proxy:IsCompleteEvent( RENDOL_STATE_ERASE ) == true then
		return;
	end
	
	SetNpcStateFlag( proxy, param, rendol_flag_list, RENDOL_STATE_DEAD );
	RendolCheck(proxy,param);
	--���S��RendolCheck����ꍇ�A���̏u�Ԃɏ����Ă��܂��̂ŁA --EN:--If you perform RendolCheck on death, it will disappear at that moment, so
	--���������čēx�L���ɂ��邩���߂� --EN:--Look at the distance and decide whether to re-enable
	if	proxy:IsDistance( LOCAL_PLAYER, 626, 20 ) == true then
		ValidCharactor( proxy, 626 );
	end
	proxy:SetEventFlag( 1700, true );

	print("OnEvent_1700 end");
end

--��1702�������h�����q�@�G�΂��� --EN:-- �� 1702 �� Prince Lendl is hostile
function OnEvent_1702(proxy,param)
	print("OnEvent_1702 begin");
	SetNpcStateFlag( proxy, param, rendol_flag_list, RENDOL_STATE_HOSTILE_4_LIFT_FRONT );
		proxy:SetTeamType( 626, TEAM_TYPE_AngryFriend );
	
	proxy:SetEventFlag( 1702, true );
	
	print("OnEvent_1702 end");
end



--��11790�������h�����q�@��b����A�C�e���擾 --EN:-- �� 11790 �� Prince Lendl Item acquisition from conversation
function OnEvent_11790(proxy,param)
	print("OnEvent_11790 begin");
	if proxy:IsCompleteEvent( 11790 ) == true then
		return;
	end
	
	if proxy:IsClient() == false then
		proxy:GetRateItem(10190);
	end
	proxy:SetHp( 626, 0.0 );
	proxy:SetEventFlag( 11790, true );
	
	SetNpcStateFlag( proxy, param, rendol_flag_list, RENDOL_STATE_ERASE );
	RendolCheck(proxy,param);
	--���S��RendolCheck����ꍇ�A���̏u�Ԃɏ����Ă��܂��̂ŁA --EN:--If you perform RendolCheck on death, it will disappear at that moment, so
	--���������čēx�L���ɂ��邩���߂� --EN:--Look at the distance and decide whether to re-enable
	if	proxy:IsDistance( LOCAL_PLAYER, 626, 20 ) == true then
		ValidCharactor( proxy, 626 );
	end
	
	print("�h���������"); --EN:print("Take it easy");
	proxy:SendEventRequest( 697 ,0, 1);
	proxy:SetEventSpecialEffect_2( 697 , 5042 );
	
	print("OnEvent_11790 end");
end


-----------------------------------------------------------------------------
--��1760��QWC�\�E�������X�^�[�o���P�� --EN:--�� 1760 �� QWC Soul Monster Appearance 1 ��
-----------------------------------------------------------------------------
function OnEvent_1760(proxy,param)
	print("OnEvent_1760 begin");
	ValidCharactor( proxy, 510 );
	proxy:PlayAnimation( 510, 6100 );
	proxy:SetEventFlag( 1760, true );
	print("OnEvent_1760 end");
end


--�򗳂̒����S --EN:--Long Death of Wyvern
function HiryuOsaDead(proxy,param)
	print("HiryuOsaDead begin");
	
	SetNpcStateFlag(proxy, param, tyo_flag_list, TYO_STATE_DEAD );
	
	--�z�X�g�̂ݓ��� --EN:--get host only
	if	proxy:IsClient() == false then
		--���g���t�B�[�擾���聥 --EN:--��Trophy Acquisition Judgment��
		Lua_RequestUnlockTrophy(proxy, 12);
		proxy:GetRateItem(10117);--�A�C�e������ --EN:-- Get items
	end
	
	--����P�̒������� --EN:--Erase the head of the castle 1
	InvalidCharactor(proxy,300);
	proxy:DeleteEvent(220);
	proxy:DeleteEvent(235);
	print("HiryuOsaDead end");
end

------------------------------------------------------------------------------------
--��1706�����̈�i���ŉ��q�����ʁ� --EN:-- �� 1706 �� The prince dies when entering a certain area ��
------------------------------------------------------------------------------------
--�����������̃C�x���g�o�^��-------------------------------------------------------- --EN:--�� Event registration at initialization ��---------------------------------------- ----------------
function RegistEvent_1706(proxy)
	if	proxy:IsCompleteEvent( 1706 ) == false then
		if proxy:IsClient() == false then
			proxy:NotNetMessage_begin();
				proxy:OnRegionIn( 1706, LOCAL_PLAYER, 2720, "OnEvent_1706", once );
			proxy:NotNetMessage_end();
		end
		proxy:LuaCall( 1706 , 0 , "OnEvent_1706_1",once);
	end	
end

function OnEvent_1706(proxy,param)
	print("OnEvent_1706 begin");
	--proxy:SetEventFlag( 15492, true );
	--proxy:SetEventFlag( 15493, true );
	--proxy:SetEventFlag( 15494, true );
	
	--���S�ł͖����Ȃ� --EN:--If it's not death
	if proxy:IsCompleteEvent( RENDOL_STATE_DEAD ) == false then		
		--�������Ȃ���Ԃ̂Ƃ��ɎE���Ă��A���񂾔���̕��Ŏ��S�Ɉڍs���Ȃ��悤�ɂȂ��Ă���̂� --EN:--Even if you kill him when he's no longer around, the dead judgment doesn't move to death.
		--�����Ŏ���ł��炢�܂��B --EN:--Let me die here.
		--proxy:SetHp( 626, 0.0 );
		--Lua_EventForceDead( proxy , 626 );
		--�G���x�[�^�[�O�̏�Ԃ̎��̂ݎE�� --EN:--Kill only when in front of the elevator
		if 	proxy:IsCompleteEvent( RENDOL_STATE_LIFT_FRONT ) == true or
			proxy:IsCompleteEvent( RENDOL_STATE_HOSTILE_4_LIFT_FRONT ) == true then
			SetNpcStateFlag( proxy, param, rendol_flag_list, RENDOL_STATE_ERASE );
			proxy:ForceDead( 626 );
		else
			SetNpcStateFlag( proxy, param, rendol_flag_list, RENDOL_STATE_ERASE );
		end
	end
	
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 1706 , "OnEvent_1706_wait",3.0,0,0,once);
	proxy:NotNetMessage_end();
	proxy:SetEventFlag( 1706 , true );
	print("OnEvent_1706 end");
end

--�҂����� --EN:--wait time
function OnEvent_1706_wait(proxy,param)
	print("OnEvent_1706_wait begin");
	proxy:LuaCallStart( 1706 , 0 );
	print("OnEvent_1706_wait end");
end

--�����h���u���b�N�o�� --EN:--Appearance of Lendl Black
function OnEvent_1706_1(proxy,param)
	--�����h���E�u���b�N������łȂ� --EN:--Lendl Black isn't dead
	if proxy:IsCompleteEvent( 1640 ) == false then
		print("OnEvent_1706_1 begin");	
		ValidCharactor( proxy, 502 );
		proxy:PlayAnimation( 502 , 6100);
		print("OnEvent_1706_1 end");
	end
end



------------------------------------------------------------------------------------
--��1640�������h�����q�E�u���b�N���S�� --EN:-- �� 1640 �� Prince Lendl Black died ��
------------------------------------------------------------------------------------
--�����������̃C�x���g�o�^��-------------------------------------------------------- --EN:--�� Event registration at initialization ��---------------------------------------- ----------------
function RegistEvent_1640(proxy)
	if	proxy:IsCompleteEvent( 1640 ) == false then
		proxy:OnCharacterDead( 1640, 502, "OnEvent_1640", once );
		if proxy:IsCompleteEvent( 1706 ) == false then
			InvalidCharactor( proxy, 502 );
		end
	else
		InvalidCharactor( proxy, 502 );
	end
end

function OnEvent_1640(proxy,param)
	print("OnEvent_1640 begin");
	proxy:SetEventFlag( 1640, true );
	print("OnEvent_1640 end");
end


--------------------------------------------------------------------------------------
--���򗳂̒��̍U���҂����Ԃ��擾���܂��B --EN:--�� Acquire the attack waiting time of the chief of the wyvern.
--------------------------------------------------------------------------------------
function GetDelay_HiryuOsa(proxy)
	--�u���XA�`C�Ŏg���U���f�B���C�p�̎��� --EN:--Time for attack delay used in Breath A~C
	local Delay_under	= HiryuOsa_AttackDelay_under * 100;
	local Delay_top		= HiryuOsa_AttackDelay_top * 100;
	local scale_dilay 	= proxy:GetRandom( Delay_under , Delay_top );--2�`4�b --EN:--2-4 seconds
	local atack_dilay_time = scale_dilay / 100;--2�`4�b --EN:--2-4 seconds
	return atack_dilay_time;
end


function OnEvent_1780(proxy,param)
	print("OnEvent_1780 begin");
	proxy:PlayAnimation( 512, 7000 );
	proxy:EnableLogic( 512, true );
	print("OnEvent_1780 end");
end


--��1670���򗳂̒���HP��75%�ȉ��� --EN:-- �� 1670 �� Wyvern leader's HP is 75% or less ��
function OnEvent_1670(proxy,param)
	print("OnEvent_1670 begin");
	proxy:SetEventFlag( 1670, true );
	print("OnEvent_1670 end");
end

--��1671���򗳂̒���HP��50%�ȉ��� --EN:-- �� 1671 �� Wyvern leader's HP is less than 50% ��
function OnEvent_1671(proxy,param)
	print("OnEvent_1671 begin");
	proxy:SetEventFlag( 1671, true );
	print("OnEvent_1671 end");
end




--��1790���򗳂̏����r�������O�����ɋ����� --EN:--��1790��Tell Bjrngrum information about the flying dragon
function Condition_1790(proxy,param)
	if	proxy:IsCompleteEvent( TYO_STATE_WARNING_AISLE )		== true then
		proxy:SendEventRequest( 698, 0, AI_EVENT_HIRYU_GATE );
	else
		proxy:SendEventRequest( 698, 0, AI_EVENT_None );
	end
end



-----------------------------------------------------------------------------
--��1680�������g�J�Q�C�x���g5 --EN:-- �� 1680 �� Crystal Lizard Event 5
-----------------------------------------------------------------------------
function OnEvent_1680(proxy,param)
	print("OnEvent_1680 begin");
	proxy:SetEventFlag( 1680, true);
	proxy:DeleteEvent( 1680 );
	print("OnEvent_1680 end");
end

-----------------------------------------------------------------------------
--��1682�������g�J�Q�C�x���g6 --EN:-- �� 1682 �� Crystal Lizard Event 6
-----------------------------------------------------------------------------
function OnEvent_1682(proxy,param)
	print("OnEvent_1682 begin");
	proxy:SetEventFlag( 1682, true);
	proxy:DeleteEvent( 1682 );
	print("OnEvent_1682 end");
end

-----------------------------------------------------------------------------
--��1684�������g�J�Q�C�x���g7 --EN:-- �� 1684 �� Crystal Lizard Event 7
-----------------------------------------------------------------------------
function OnEvent_1684(proxy,param)
	print("OnEvent_1684 begin");
	proxy:SetEventFlag( 1684, true);
	proxy:DeleteEvent( 1684 );
	print("OnEvent_1684 end");
end


-----------------------------------------------------------------------------
--��1690���O�e�m�P���� --EN:-- �� 1690 �� Three Musketeers 1 died
-----------------------------------------------------------------------------
function OnEvent_1690(proxy,param)
	print("OnEvent_1690 begin");
	proxy:SetEventFlag( 1690 , true );
	print("OnEvent_1690 end");
end

-----------------------------------------------------------------------------
--��1691���O�e�m2���� --EN:-- �� 1691 �� The Three Musketeers 2 died
-----------------------------------------------------------------------------
function OnEvent_1691(proxy,param)
	print("OnEvent_1691 begin");
	proxy:SetEventFlag( 1691 , true );
	print("OnEvent_1691 end");
end

-----------------------------------------------------------------------------
--��1692���O�e�m3���� --EN:-- �� 1692 �� The Three Musketeers 3 died
-----------------------------------------------------------------------------
function OnEvent_1692(proxy,param)
	print("OnEvent_1692 begin");
	proxy:SetEventFlag( 1692 , true );
	print("OnEvent_1692 end");
end
