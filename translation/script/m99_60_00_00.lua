
--------------------------------------------------------------------------------------
--�}�b�v�ǂݍ��ݎ��ɓǂ܂�鏉���������� --EN:--Initialization process read when reading the map ��
--------------------------------------------------------------------------------------
function Initialize_m99_60_00_00(proxy)
	print("Initialize m99_60_00_00 begin");

--�����n�V�S --EN:--Vertical ladder

--��6000���n�V�SA�~�聡PC���C�x���g�G���A(2002)�̒��ɋ��āA�A�N�V�����{�^�����������Ƃ�-- --EN:-- �� 6000 �� Get off ladder A �� When the PC is in the event area (2002) and presses the action button --
	proxy:OnActionEventRegion(6000, 2002, "OnEvent_6000", LadderAngle_A, HELPID_DOWN, everytime);
--��6001���n�V�SA���聡PC���C�x���g�G���A(2001)�̒��ɋ��āA�A�N�V�����{�^�����������Ƃ�-- --EN:-- �� 6001 �� Climbing ladder A �� When the PC is in the event area (2001) and presses the action button --
	proxy:OnActionEventRegion(6001, 2001, "OnEvent_6001", LadderAngle_A, HELPID_UP, everytime);
	
	

--�΂�10�x�n�V�S --EN:--10 degree diagonal ladder

--��6002���n�V�SB�~�聡PC���C�x���g�G���A(2011)�̒��ɋ��āA�A�N�V�����{�^�����������Ƃ�-- --EN:-- �� 6002 �� Get off ladder B �� When the PC is in the event area (2011) and presses the action button --
	proxy:OnActionEventRegion(6002, 2011, "OnEvent_6002", LadderAngle_A, HELPID_DOWN, everytime);
--��6003���n�V�SB���聡PC���C�x���g�G���A(2010)�̒��ɋ��āA�A�N�V�����{�^�����������Ƃ�-- --EN:-- �� 6003 �� Climbing ladder B �� When the PC is in the event area (2010) and presses the action button --
	proxy:OnActionEventRegion(6003, 2010, "OnEvent_6003", LadderAngle_A, HELPID_UP, everytime);


	proxy:OnPlayerActionInRegion(128,30,"OnEvent_128",HELPID_GO_TO_IN,once);

--��500�����J�����o�[�� --EN:-- �� 500 �� castle gate opening lever ��
	if proxy:IsCompleteEvent( 500 ) ==false then
	--��PC���C�x���g�G���A(500)�̒��ɋ���(1.5m)�L���p(30�x��)�ŃA�N�V�����{�^���������� --EN:--�� PC presses action button at distance (1.5m) effective angle (30 degree width) in event area (500)
		proxy:OnDistanceAction( 500, 10000, 500, "OnEvent_500", LeverDist_A, HELPID_PULL_LEVER, 0, LeverAngle_A, once);
	else
	   proxy:EndAnimation( 500, 1 );--���o�[�������A�j�� --EN:--Animation of moving lever
	   proxy:EndAnimation( 501, 1 );--�����J���A�j�� --EN:-- Door opening animation
	end
	
	proxy:OnFireDamage( 500 , 500 , -1 ,"OnEvent_500_fire",everytime);
	
--��502���n���h�����񂵂Ď��Ԃ𓮂����� --EN:-- �� 502 �� Turn the handle to move the gear ��
	if proxy:IsCompleteEvent( 502 ) ==false then
	--��PC���n���h��(506)�ɑ΂��Ĕ����p�x(45)�A�p�x�I�t�Z�b�g(-90)�A����(150)�ŃA�N�V�����{�^����������-- --EN:--�� PC presses action button with reaction angle (45), angle offset (-90), distance (150) relative to handle (506) ��--
		proxy:OnDistanceAction( 502, 10000, 506, "OnEvent_502", HandleDist_A, HELPID_TURN_HANDLE, -90.0, HandleAngle_A, once );
	else
		proxy:EndAnimation( 506, 1 );--�n���h���A�j�� --EN:--handle animation
	end
	

--��508���󎀑́� --EN:-- �� 508 �� treasure corpse ��
	--��PC����(507)�ɑ΂��Ĕ����p�x(90)�A�p�x�I�t�Z�b�g(0)�A����(180)�ŃA�N�V�����{�^����������-- --EN:--�� PC presses action button with reaction angle (90), angle offset (0), distance (180) against treasure (507) ��--
	if proxy:IsCompleteEvent( 508 ) ==false then
		proxy:OnDistanceAction( 508, 10000, 507, "OnEvent_508", ItemBoxDist_A, HELPID_CHECK_GLOWING_CORPS, 0, ItemBoxAngle_A, once );
		proxy:TreasureDispModeChange( 507, true );--������点�� --EN:--Light up the treasure
	end
	

--��510�`513���J���� --EN:-- �� 510 ~ 513 �� opening and closing door ��

	proxy:RepeatMessage_begin();
	
	--�����܂��Ă�����A��������J������ --EN:--If the door is closed, you can open it from both sides
	if proxy:IsCompleteEvent( 510 ) == false and proxy:IsCompleteEvent( 512 ) == false then
		
		proxy:OnDistanceActionPlus( 510, 10000, 502, "OnEvent_510", DoorDist_A, HELPID_OPEN , -90,DoorAngle_A,  0.0,-1.5, 0.7, once);
		proxy:OnDistanceActionPlus( 512, 10000, 502, "OnEvent_512", DoorDist_A, HELPID_OPEN ,  90,DoorAngle_A,  0.0,-1.5, 0.7, once);
	
	--������O����J����Ă����牜������߂��� --EN:--If the door is opened from the front, it can be closed from the back
	elseif proxy:IsCompleteEvent( 510 ) == true then
		proxy:OnDistanceActionPlus( 513, 10000, 502, "OnEvent_513", DoorDist_A, HELPID_CLOSE,  180,DoorAngle_A, -1.0,-1.5, 0.0, once);
	
	--������������J����Ă������O����߂��� --EN:--If the door is opened from the back, it can be closed from the front
	elseif proxy:IsCompleteEvent( 512 ) == true then
		proxy:OnDistanceActionPlus( 511, 10000, 502, "OnEvent_511", DoorDist_A, HELPID_CLOSE, -90,DoorAngle_A,  1.0,-1.5, 0.0, once);
	end
	
	proxy:RepeatMessage_end();
	

--��514���č���(��)�� --EN:-- �� 514 �� Prison Door (Large) ��

	if proxy:IsCompleteEvent( 514 ) == false then
		proxy:OnDistanceActionPlus( 514, 10000, 504, "OnEvent_514", DoorDist_A, HELPID_OPEN  , 0 , DoorAngle_A, 0.0, -0.5, -0.2, once);
	else
		proxy:EndAnimation( 504 , 1 );
	end


--��514�`517���č���(��)�� --EN:-- 514-517 Prison door (small)

	if proxy:IsCompleteEvent( 518 ) == false then
		proxy:OnDistanceActionPlus( 518, 10000, 505, "OnEvent_518", DoorDist_A, HELPID_OPEN  , 180 , DoorAngle_A,  0.4, -1.8, 0.2, once);
	else
		proxy:EndAnimation( 505 , 1 );
	end
		
	
--��2000���V���b�v�e�X�g�� --EN:-- �� 2000 �� Shop test ��
	proxy:OnPlayerActionInRegion( 2000, 60, "OnEvent_2000", HELPID_TALK, everytime );
	
--��2020���|�C���g���@�e�X�g�� --EN:-- �� 2020 �� Point magic test ��
	proxy:OnRegionJustIn(2020,10000,2020,"OnEvent_2020",everytime);
	
--��2021���|�C���g���@�e�X�g�� --EN:-- �� 2021 �� Point magic test ��
	--proxy:OnRegionJustIn(2030,2021,2020,"OnEvent_2030",everytime);
	
	
	
--��??���p�j�f�[�����̓o�ꁡ�n���h���o�^ --EN:--��??��Appearance of wandering daemon��Handler registration
	proxy:NotNetMessage_begin();
		--�v���C���[���\���Ŏ��S�������ɃL�b�N����܂��B --EN:--Kicked when a player dies solo.
		proxy:LuaCall( 4000, 100, "PlayerDeath_m99_60_00_00", everytime );
		--�v���C���[�������������ɃL�b�N����܂��B --EN:--Kicked when the player is revived.
		proxy:LuaCall( 4032, 100, "PlayerRevive_m99_60_00_00", everytime );		
	proxy:NotNetMessage_end();
	
	proxy:RepeatMessage_begin();
		--proxy:OnCharacterHpRate(2041,2021,"OnEvent_2041",0.1,once);	
	proxy:RepeatMessage_end();
	
--��996000���t���[���x��̏����������C�x���g�𔭍s�� --EN:-- �� 996000 �� Generate a frame delay initialization processing event ��
	proxy:NotNetMessage_begin();
		--��0�b�づ-- --EN:--��After 0 seconds��--
		proxy:OnKeyTime2( 996000, "Second_Initialize_m99_60_00_00", 0.1, 0, 0, once );	
	proxy:NotNetMessage_end();	
	
	
	proxy:OnDistanceAction(600,10000,600,"OnEvent_600",1,HELPID_PULL_LEVER,0,180,everytime);
	
	proxy:OnRegistFunc(3000,"Check_3000","OnEvent_3000",1,once);
	
	--��33���̈�Ď��� --EN:-- �� 33 �� Area monitoring ��
	proxy:OnNetRegionPlus(50,33,"OnEvent_33");
	--��34���̈�Ď��F�z���C�g�̂݁� --EN:-- �� 34 �� Area monitoring: White only ��
	proxy:OnNetRegionAttr(51,34,ATTR_WHITE);
	--��35���̈�Ď��F�u���b�N�̂݁� --EN:-- �� 35 �� Area monitoring: Black only ��
	proxy:OnNetRegionAttr(52,35,ATTR_BLACK);
	--��36���̈�Ď��F�O���C�̂݁� --EN:-- �� 36 �� Area monitoring: gray only ��
	proxy:OnNetRegionAttr(53,36,ATTR_GREY);	
	--��37���̈�Ď��F�����̂݁� --EN:-- �� 37 �� Area Surveillance: Survival Only ��
	proxy:OnNetRegionAttr(54,37,ATTR_LIVE);
	--��37���̈�Ď�:�z�X�g�̂�(����or�O���C)�� --EN:-- �� 37 �� Area monitoring: Host only (survival or gray) ��
	proxy:OnNetRegionAttr(55,38,ATTR_LIVE+ATTR_GREY);	
	
	proxy:OnPlayerActionInRegion(56,39,"OnEvent_56",HELPID_PULL_LEVER,once);
	
	--�A�C�e���h���b�v�C�x���g --EN:--Item drop event
	proxy:OnRegionIn(57,10000,40,"OnEvent_57",everytime);	
	--�E�������̃C�x���g --EN:--Event when picked up
	proxy:LuaCall(12000,0,"OnEvent_12000",everytime);
	
	
	--proxy:OnWanderFade(2000,10000,2.0,2.0,10.0,10.0,everytime);
	proxy:LuaCall( 100 , 0 , "OnEvent_100",once);
	--�N���A�e�X�g --EN:--clear test
	--proxy:OnCharacterDead(60,2021,"OnEvent_60",once);
	print("Initialize m99_60_00_00 end");
end

--------------------------------------------------------------------------------------
--Initialize����Ă΂��A1�t���[���x��̏�����������999999 --EN:--Initialization with a delay of 1 frame, called from Initialize ��999999
--------------------------------------------------------------------------------------
--��996000���������� --EN:-- �� 996000 �� Initialization ��
function Second_Initialize_m99_60_00_00(proxy, param)
	print("Second_Initialize_m99_60_00_00 begin");
	
--[[
	--���p�j�f�[�����p (�t���O�͉��A�w�肪����Ες���) --EN:--��For wandering daemon (flag is tentative, change if specified)
	if proxy:IsCompleteEvent( 20 ) == true then
		LuaFunc_VisibleTheWanderingDemon  (proxy, param, demon_id_list_m99_60_00_00);
	else
		LuaFunc_InvisibleTheWanderingDemon(proxy, param, demon_id_list_m99_60_00_00);
	end
]]
	
	--proxy:SetDeadMode(2021,true);
	--proxy:EnableInvincible(2021,true);
	--proxy:DisableDamage(2021,true);
	--[[
	proxy:SendEventRequest(2021,0,10);
	proxy:SendEventRequest(2021,1,11);
	proxy:SendEventRequest(2021,2,12);
	proxy:SendEventRequest(2021,3,13);
	
	if proxy:CreateEventBody( 2040, 2021,"OnEvent_2040",20,0.5,everytime) == true then		
		proxy:AddEventParts(2040,2021,"Ragdoll_R Toe01");
		proxy:AddEventParts(2040,2021,"Ragdoll_R Foot01");		
		proxy:AddEventParts(2040,2021,"Ragdoll_L Toe01");
		proxy:AddEventParts(2040,2021,"Ragdoll_L Foot01");
		
		proxy:AddEventParts(2040,2021,"Ragdoll_Pelvis01");
		proxy:AddEventParts(2040,2021,"Ragdoll_L Thigh01");
		proxy:AddEventParts(2040,2021,"Ragdoll_R Thigh01");
		proxy:AddEventParts(2040,2021,"Ragdoll_Spine01");
		proxy:AddEventParts(2040,2021,"Ragdoll_R Calf01");
		proxy:AddEventParts(2040,2021,"Ragdoll_L Calf01");
		proxy:AddEventParts(2040,2021,"Ragdoll_L UpperArm01");
		proxy:AddEventParts(2040,2021,"Ragdoll_R UpperArm01");
		proxy:AddEventParts(2040,2021,"Ragdoll_L Forearm01");
		proxy:AddEventParts(2040,2021,"Ragdoll_R Forearm01");
	end
	]]
	print("Second_Initialize_m99_60_00_00 end");
end

function OnEvent_2040(proxy,param)
	print("OnEvent_2040 begin");
	proxy:CheckEventBody(2040);
	print("OnEvent_2040 end");	
end


--------------------------------------------------------------------------------------
--�n�V�SA�~�聡6000 --EN:--Ladder A down 6000
--------------------------------------------------------------------------------------
--��6000���n�V�SA�~��X�^�[�g�� --EN:-- �� 6000 �� Ladder A descent start ��
function OnEvent_6000(proxy, param)
	if param:IsNetMessage() == true then
		return;
	end
	print("OnEvent_6000 begin");

	--�z�o�[�ړ����[�h�Ɉڍs-- --EN:--Transition to hover mode--
	proxy:BeginAction(10000,2,2,2);

	--�ړ��ʒu(2004)��0.5�b�Ńz�o�[�ړ�-- --EN:--Hover movement to moving position (2004) in 0.5 seconds--
	proxy:HoverMoveValDmy(10000,1100,192,LadderTime_A);--�ړ��ʒu(192)��0.5�b�Ńz�o�[�ړ� --EN:--Hover to move position (192) in 0.5 seconds
	--proxy:ChangeInitPosAng(2021,2004);

	--�C�x���g�R�}���hID(1)"�n�V�S�ォ���"�ނ𑗂�-- --EN:--Send event command ID (1) "grab from ladder"--
	proxy:SetEventCommand(10000,1);
	proxy:SetKeepCommandIndex(10000, 0, 1, 3.0 );

	--�z�M���Ȃ��C�x���g��o�^-- --EN:--Register non-distributed events--
	proxy:NotNetMessage_begin();
	
		--0.5�b��ɔ�������C�x���g��o�^-- --EN:--Register an event that fires after 0.5 seconds--
		proxy:OnKeyTime2(6000,"OnEvent_6000_1",0.5,0,0,once);
		--3�b�Ԕ�������C�x���g��o�^-- --EN:--Register an event that fires for 3 seconds--
		proxy:OnKeyTime2(6000,"LadderUp",3,1,0,once);
	
	proxy:NotNetMessage_end();

	--�L�����N�^���ړ��A����s�\��-- --EN:--Move the character, make it impossible to turn--
	proxy:DisableMove(10000,1);
	print("OnEvent_6000 end");
end

--��6000_1���n�V�SA�~��X�^�[�g:�z�o�[�ړ��I���� --EN:--�� 6000_1 �� Start descending from ladder A: End of hover movement ��
function OnEvent_6000_1(proxy, param)
	if param:IsNetMessage() == true then
		return;
	end
	if proxy:GetEventMode(10000) == 0 then
		return;
	end
	print("OnEvent_6000_1 begin");

	--�n�V�S�A�N�V�������[�h�Ɉڍs-- --EN:--Transition to ladder action mode--
	proxy:BeginAction(10000,1,7,6);

	--�L�����N�^���ړ��A����\��-- --EN:--Character can be moved and turned--
	proxy:DisableMove(10000,0);
	print("OnEvent_6000_1 end");
end


--------------------------------------------------------------------------------------
--�n�V�SA���聡6001 --EN:--Ladder A up ��6001
--------------------------------------------------------------------------------------
--��6001���n�V�SA����X�^�[�g�� --EN:-- �� 6001 �� Ladder A climbing start ��
function OnEvent_6001(proxy, param)
	if param:IsNetMessage() == true then
		return;
	end
	print("OnEvent_6001 begin");
	--�z�o�[�ړ����[�h�Ɉڍs-- --EN:--Transition to hover mode--
	proxy:BeginAction(10000,2,-1,1);

	--�ړ��ʒu(2003)��0.5�b�Ńz�o�[�ړ�-- --EN:--Hover movement to moving position (2003) in 0.5 seconds--
	proxy:HoverMoveValDmy(10000,1100,191,LadderTime_A);--�ړ��ʒu(191)��0.5�b�Ńz�o�[�ړ� --EN:--Hover to move position (191) in 0.5 seconds

	--�C�x���g�R�}���hID(0)"�n�V�S�������"�ނ𑗂�-- --EN:--Send event command ID (0) "grab from bottom of ladder"--
	proxy:SetEventCommand(10000,0);
	proxy:SetKeepCommandIndex(10000, 0, 1, 3.0 );

	--�z�M���Ȃ��C�x���g�ǉ�-- --EN:--Add non-distributed events--
	proxy:NotNetMessage_begin();
	
		--0.5�b��ɔ�������C�x���g��o�^-- --EN:--Register an event that fires after 0.5 seconds--
		proxy:OnKeyTime2(6001,"OnEvent_6001_1",0.5,0,0,once);
		--1�b�Ԕ�������C�x���g��o�^-- --EN:--Register an event that fires for 1 second--
		proxy:OnKeyTime2(6001,"EventMenuBrake",1,1,0,once);

	proxy:NotNetMessage_end();

	--�L�����N�^���ړ��A����s�\��-- --EN:--Move the character, make it impossible to turn--
	proxy:DisableMove(10000,1);
	print("OnEvent_6001 end");
end

--��6001_1���n�V�SA����X�^�[�g:�z�o�[�ړ��I���� --EN:--��6001_1�� Start climbing ladder A: End hover movement ��
function OnEvent_6001_1(proxy, param)
	if param:IsNetMessage() == true then
		return;
	end
	if proxy:GetEventMode(10000) == 0 then
		return;
	end
	print("OnEvent_6001_1 begin");
	--�n�V�S�A�N�V�������[�h�Ɉڍs-- --EN:--Transition to ladder action mode--
	proxy:BeginAction(10000,1,-1,6);
	--�L�����N�^���ړ��A����\��-- --EN:--Character can be moved and turned--
	proxy:DisableMove(10000,0);
	
	print("OnEvent_6001_1 end");
end

--------------------------------------------------------------------------------------
--�n�V�SB�~�聡6002 --EN:--Ladder B down 6002
--------------------------------------------------------------------------------------
--��6002���n�V�SB�~��X�^�[�g�� --EN:-- �� 6002 �� Ladder B descent start ��
function OnEvent_6002(proxy, param)
	if param:IsNetMessage() == true then
		return;
	end
	print("OnEvent_6002 begin");

	--�z�o�[�ړ����[�h�Ɉڍs-- --EN:--Transition to hover mode--
	proxy:BeginAction(10000,2,2,2);

	--�ړ��ʒu(2013)��0.5�b�Ńz�o�[�ړ�-- --EN:--Hover in 0.5 seconds to move position (2013)--
	proxy:HoverMoveValDmy(10000,1110,192,LadderTime_A);--�ړ��ʒu(192)��0.5�b�Ńz�o�[�ړ� --EN:--Hover to move position (192) in 0.5 seconds

	--�C�x���g�R�}���hID(1)"�n�V�S�ォ���"�ނ𑗂�-- --EN:--Send event command ID (1) "grab from ladder"--
	proxy:SetEventCommand(10000,1);
	proxy:SetKeepCommandIndex(10000, 4, 1, 3.0 );

	--�z�M���Ȃ��C�x���g��o�^-- --EN:--Register non-distributed events--
	proxy:NotNetMessage_begin();
	
		--0.5�b��ɔ�������C�x���g��o�^-- --EN:--Register an event that fires after 0.5 seconds--
		proxy:OnKeyTime2(6002,"OnEvent_6002_1",0.5,0,0,once);
		--3�b�Ԕ�������C�x���g��o�^-- --EN:--Register an event that fires for 3 seconds--
		proxy:OnKeyTime2(6002,"LadderDown",3,1,0,once);
	
	proxy:NotNetMessage_end();

	--�L�����N�^���ړ��A����s�\��-- --EN:--Move the character, make it impossible to turn--
	proxy:DisableMove(10000,1);
	print("OnEvent_6000 end");
end

--��6002_1���n�V�SB�~��X�^�[�g:�z�o�[�ړ��I���� --EN:--�� 6002_1 �� Start descending ladder B: End of hover movement ��
function OnEvent_6002_1(proxy, param)
	if param:IsNetMessage() == true then
		return;
	end
	if proxy:GetEventMode(10000) == 0 then
		return;
	end
	print("OnEvent_6002_1 begin");

	--�n�V�S�A�N�V�������[�h�Ɉڍs-- --EN:--Transition to ladder action mode--
	proxy:BeginAction(10000,1,6,5);

	--�L�����N�^���ړ��A����\��-- --EN:--Character can be moved and turned--
	proxy:DisableMove(10000,0);
	print("OnEvent_6002_1 end");
end


--------------------------------------------------------------------------------------
--�n�V�SB���聡6003 --EN:--Ladder B climbing 6003
--------------------------------------------------------------------------------------
--��6003���n�V�SB����X�^�[�g�� --EN:-- �� 6003 �� Ladder B climbing start ��
function OnEvent_6003(proxy, param)
	if param:IsNetMessage() == true then
		return;
	end
	print("OnEvent_6003 begin");
	--�z�o�[�ړ����[�h�Ɉڍs-- --EN:--Transition to hover mode--
	proxy:BeginAction(10000,2,-1,1);

	--�ړ��ʒu(2012)��0.5�b�Ńz�o�[�ړ�-- --EN:--Hover in 0.5 seconds to move position (2012)--
	proxy:HoverMoveValDmy(10000,1110,191,LadderTime_A);--�ړ��ʒu(191)��0.5�b�Ńz�o�[�ړ� --EN:--Hover to move position (191) in 0.5 seconds

	--�C�x���g�R�}���hID(0)"�n�V�S�������"�ނ𑗂�-- --EN:--Send event command ID (0) "grab from bottom of ladder"--
	proxy:SetEventCommand(10000,0);
	proxy:SetKeepCommandIndex(10000, 4, 1, 3.0 );

	--�z�M���Ȃ��C�x���g�ǉ�-- --EN:--Add non-distributed events--
	proxy:NotNetMessage_begin();
	
		--0.5�b��ɔ�������C�x���g��o�^-- --EN:--Register an event that fires after 0.5 seconds--
		proxy:OnKeyTime2(6003,"OnEvent_6003_1",0.5,0,0,once);
		--1�b�Ԕ�������C�x���g��o�^-- --EN:--Register an event that fires for 1 second--
		proxy:OnKeyTime2(6003,"EventMenuBrake",1,1,0,once);

	proxy:NotNetMessage_end();

	--�L�����N�^���ړ��A����s�\��-- --EN:--Move the character, make it impossible to turn--
	proxy:DisableMove(10000,1);
	print("OnEvent_6001 end");
end

--��6003_1���n�V�SB����X�^�[�g:�z�o�[�ړ��I���� --EN:--��6003_1�� Start climbing ladder B: End of hover movement ��
function OnEvent_6003_1(proxy, param)
	if param:IsNetMessage() == true then
		return;
	end
	if proxy:GetEventMode(10000) == 0 then
		return;
	end
	print("OnEvent_6003_1 begin");
	--�n�V�S�A�N�V�������[�h�Ɉڍs-- --EN:--Transition to ladder action mode--
	proxy:BeginAction(10000,1,-1,5);
	--�L�����N�^���ړ��A����\��-- --EN:--Character can be moved and turned--
	proxy:DisableMove(10000,0);
	
	print("OnEvent_6003_1 end");
end





--------------------------------------------------------------------------------------
--���J�����o�[��500 --EN:--Castle gate opening lever 500
--------------------------------------------------------------------------------------
--��500�����J�����o�[�� --EN:-- �� 500 �� castle gate opening lever ��
function OnEvent_500(proxy, param)
	print("OnEvent_500 begin");
	
	proxy:PlayAnimation(500, 1);--���J�����o�[�A�j���Đ� --EN:--Play gate opening lever animation
	
	proxy:NotNetMessage_begin();
		--��500_2��***�����ǉ�***���o�[�A�j���I���� --EN:--��500_2��***Condition added***Lever animation ends��
		proxy:OnCharacterAnimEnd( 500, 500, 1, "OnEvent_500_2", once);
	proxy:NotNetMessage_end();
	
	--�v���C���[�̓����A�j���[�V����(true:�p�[�e�B�[�v���C���[���A�j���[�V��������) --EN:--Player synchronous animation (true: party player animated)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_PULL_LEVER ) == true then
		--�p�[�e�B�[�v���C���[���A�j���[�V���������ꍇ�͂����ŏ����I�� --EN:--If the party player animates, the process ends here
		print("OnEvent_500 end");
		return;
	end
		
	proxy:Warp(10000, 2000);		--�v���C���[������ʒu�Ƀ��[�v --EN:--Warp player in place

	print("OnEvent_500 end");
end

--��500_2�����o�[�A�j���I���� --EN:--��500_2��Lever animation ends��
function OnEvent_500_2(proxy, param)
	print("OnEvent_500_2 begin");
	
	proxy:NotNetMessage_begin();
		--��500_3��***�����ǉ�***1�b�づ --EN:--��500_3��***Condition added***After 1 second��
		proxy:OnKeyTime2( 500, "OnEvent_500_3", 1.0, 0, 1, once);
	proxy:NotNetMessage_end();
	
	print("OnEvent_500_2 end");
end

--��500_3�����o�[�A�j���I������1�b�っ --EN:--��500_3��1 second after lever animation ends��
function OnEvent_500_3(proxy, param)
	print("OnEvent_500_3 begin");
	
	proxy:SetEventFlag( 500, 1 );
	proxy:PlayAnimation( 501, 1 );--����J���A�j�����Đ� --EN:--Play front gate opening animation
	
	print("OnEvent_500_3 end");
end







--------------------------------------------------------------------------------------
--�n���h�����񂵂Ď��Ԃ𓮂�����502 --EN:--Turn the handle to move the gear ��502
--------------------------------------------------------------------------------------
--��502���n���h��A���񂵂Ď��Ԃ𓮂����� --EN:-- �� 502 �� Turn the handle A to move the gear ��
function OnEvent_502(proxy, param)
	print("OnEvent_502 begin")
	
	proxy:PlayAnimation( 506, 1 );--�n���h���A�j���Đ� --EN:--Handle animation playback
	
	proxy:NotNetMessage_begin();
		--��502_2��***�����ǉ�***�n���h���A�j���I���� --EN:--��502_2��***Conditions added***End handle animation��
		proxy:OnCharacterAnimEnd( 502, 506, 1, "OnEvent_502_2", once );
	proxy:NotNetMessage_end();
	
	--�v���C���[�̓����A�j���[�V����(true:�p�[�e�B�[�v���C���[���A�j���[�V��������) --EN:--Player synchronous animation (true: party player animated)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_TURN_HANDLE ) == true then 
		return;
	end

--	proxy:Warp( 10000 , 2006 );		--�v���C���[������ʒu�Ƀ��[�v --EN:--Warp player in place
	proxy:WarpDmy( 10000 , 506 , 192 );
	
	print("OnEvent_10 end")
end


--��502_2���n���h���A�j���I���� --EN:--��502_2��Handle animation ends��
function OnEvent_502_2(proxy, param)
	print("OnEvent_502_2 begin")
	
	proxy:NotNetMessage_begin();
		--��502_3��***�����ǉ�***0.5�b�づ --EN:--��502_3��***Condition added***After 0.5 seconds��
		proxy:OnKeyTime2( 502, "OnEvent_502_3", 0.5, 0, 2, once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_502_2 end")
end

--��502_3��0.5�b�っ --EN:--��502_3��After 0.5 seconds��
function OnEvent_502_3(proxy, param)
	print("OnEvent_502_3 begin")

	proxy:SetEventFlag( 502, 1 );	--�t���O�𗧂Ă� --EN:-- flag
	
	print("OnEvent_502_3 end")
end



--------------------------------------------------------------------------------------
--�󎀑�A��508 --EN:--Treasure corpse A 508
--------------------------------------------------------------------------------------
--��508����A:���ׂ遡 --EN:-- �� 508 �� Treasure box A: Examine ��
function OnEvent_508(proxy, param)
	print("OnEvent_508 begin");
	proxy:NotNetMessage_begin();
		--�����A�j���[�V�����p�̃C�x���g --EN:--event for synchronous animation
		proxy:LuaCallStart( 4010 , 1 );
		--proxy:OnSelectMenu(508,"OnEvent_508_1",10010100,0,2,507,1.5,once);		
		proxy:NoAnimeTurnCharactor( 10000 , 507 );
--[[
	const dl_int32		nEventID,
	const dl_char*		func,
	const dl_int32		nMsgID,
	const dl_int32		nBtnType,
	const dl_int32		nBtnNum,	
	const dl_int32 		TargetID,
	const dl_float32 	Length,
	const dl_bool		bOnce
	]]
	proxy:NotNetMessage_end();	
	print("OnEvent_508 end");
end

--�I��҂� --EN:--Waiting for selection
function OnEvent_508_1(proxy,param)
	print("OnEvent_508_1 begin");
	--�����A�j���[�V�����p�̃C�x���g --EN:--event for synchronous animation
	proxy:LuaCallStart( 4010 , 1 );

	proxy:NotNetMessage_begin();
		--0.0�b��ɃA�C�e���擾�C�x���g�𔭍s --EN:-- Issue an item acquisition event after 0.0 seconds
		proxy:OnKeyTime2( 508, "OnEvent_508_2", 0.0, 0, 0, once );
	proxy:NotNetMessage_end();	
	print("OnEvent_508_1 end");
end


--��508_1����A�F�A�C�e���\���� --EN:--��508_1 ��Treasure box A: Item expression��
function OnEvent_508_2(proxy, param)
	print("OnEvent_508_2 begin");

	--�A�C�e���擾�̕\������ --EN:-- Display processing for item acquisition
	proxy:GetRateItem(0);
	
	--�A�C�e�����擾�ς� --EN:--item already acquired
	proxy:SetEventFlag( 508, 1 );
	--�󂪌����Ă���̂����� --EN:--Turn off glowing treasure
	proxy:TreasureDispModeChange( 507, false );
	
	print("OnEvent_508_2 end");
end




--------------------------------------------------------------------------------------
--�J���F��O����J���遡510 --EN:--Opening door: Open from the front ��510
--------------------------------------------------------------------------------------
function OnEvent_510(proxy, param) 
	EventNormalDoor(proxy, param, 510, 502, 2, ANIMEID_OPEN, 9 , false); 
	
	proxy:DeleteEvent( 512 );
	proxy:SetEventFlag( 513 , 0 );
	
	proxy:RepeatMessage_begin();
		proxy:OnDistanceActionPlus( 513, 10000, 502, "OnEvent_513", DoorDist_A, HELPID_CLOSE,90,DoorAngle_A, -1.0,-1.5, 0.0, once);
	proxy:RepeatMessage_end();
end

--------------------------------------------------------------------------------------
--�J���F��O����߂遡511 --EN:--Open/close door: close from the front ��511
--------------------------------------------------------------------------------------
function OnEvent_511(proxy, param) 
	EventNormalDoor(proxy, param, 511, 502, 3, ANIMEID_CLOSE, 9 , false);
	
	proxy:SetEventFlag( 510 , 0 );
	proxy:SetEventFlag( 512 , 0 );
	
	proxy:RepeatMessage_begin();
		proxy:OnDistanceActionPlus( 510, 10000, 502, "OnEvent_510", DoorDist_A, HELPID_OPEN , -90,DoorAngle_A,  0.0,-1.5, 0.7, once);
		proxy:OnDistanceActionPlus( 512, 10000, 502, "OnEvent_512", DoorDist_A, HELPID_OPEN ,  90,DoorAngle_A,  0.0,-1.5, 0.7, once);
	proxy:RepeatMessage_end();
end

--------------------------------------------------------------------------------------
--�J���F������J����  ��512 --EN:--Opening door: Open from the back ��512
--------------------------------------------------------------------------------------
function OnEvent_512(proxy, param) 
	EventNormalDoor(proxy, param, 512, 502, 4, ANIMEID_OPEN, 9 , false); 
	
	proxy:DeleteEvent( 510 );
	proxy:SetEventFlag( 511 , 0 );
	
	proxy:RepeatMessage_begin();
		proxy:OnDistanceActionPlus( 511, 10000, 502, "OnEvent_511", DoorDist_A, HELPID_CLOSE, -90,DoorAngle_A,  1.0,-1.5, 0.0, once);
	proxy:RepeatMessage_end();
end

--------------------------------------------------------------------------------------
--�J���F������߂�  ��513 --EN:-- Open/close door: Close from the back ��513
--------------------------------------------------------------------------------------
function OnEvent_513(proxy, param) 
	EventNormalDoor(proxy, param, 513, 502, 5, ANIMEID_CLOSE, 9 , false);
	
	proxy:SetEventFlag( 510 , 0 );
	proxy:SetEventFlag( 512 , 0 );
	
	proxy:RepeatMessage_begin();
		proxy:OnDistanceActionPlus( 510, 10000, 502, "OnEvent_510", DoorDist_A, HELPID_OPEN , -90,DoorAngle_A,  0.0,-1.5, 0.7, once);
		proxy:OnDistanceActionPlus( 512, 10000, 502, "OnEvent_512", DoorDist_A, HELPID_OPEN ,  90,DoorAngle_A,  0.0,-1.5, 0.7, once);
	proxy:RepeatMessage_end();
end




--------------------------------------------------------------------------------------
--�����p�̊֐���  m04 �̂Ƃ͂�����Ƃ������B������������B�iplayer_anime_id) --EN:--��Function for door�� It's a little different from m04. One argument too many. (player_anime_id)
--------------------------------------------------------------------------------------

--��������Ăԁ� --EN:--��Call this��
function EventNormalDoor(proxy, param, event_id, door_id, door_anime_id, player_anime_id ,dmy_id ,flag)
	
	print("OnEvent_"..event_id.." begin");
	
	proxy:PlayAnimation( door_id , door_anime_id );--���̃A�j���[�V���� --EN:-- door animation

	--�v���C���[�̓����A�j���[�V����(true:�p�[�e�B�[�v���C���[���A�j���[�V��������) --EN:--Player synchronous animation (true: party player animated)
	if Luafunc_PlaySynchroAnimation( proxy, param, player_anime_id ) == true then
		proxy:SetEventFlag( event_id , 1 );--�J��A(��O����J����)�ւ̑���𖳌��ɂ���B --EN:--Disable the operation to open/close door A (open from the front).
		return;
	end
	
	--�_�~�|��ID�i�X�j�Ƀ��[�v --EN:-- Warp to Damipoly ID (9)
	if flag == true then
		proxy:WarpDmy( 10000, door_id , dmy_id );
	end
	
	proxy:SetEventFlag( event_id , 1 );--�J��A(��O����J����)�ւ̑���𖳌��ɂ���B --EN:--Disable the operation to open/close door A (open from the front).

	print("OnEvent_"..event_id.." end");
end

--------------------------------------------------------------------------------------
--��514���S���(��)514�� --EN:--�� 514 �� prison door (large) 514 ��
--------------------------------------------------------------------------------------
function OnEvent_514(proxy, param) EventNormalDoor(proxy, param, 514, 504, 1, ANIMEID_OPEN, 191 , true); end

--------------------------------------------------------------------------------------
--��518���S���(��)518�� --EN:--�� 518 �� prison door (small) 518 ��
--------------------------------------------------------------------------------------
function OnEvent_518(proxy, param) EventNormalDoor(proxy, param, 518, 505, 1, ANIMEID_OPEN, 191 , true); end




--------------------------------------------------------------------------------------
--�V���b�v�e�X�g�F��2000 --EN:--Shop test: ��2000
--------------------------------------------------------------------------------------
--��2000���V���b�v�e�X�g�� --EN:-- �� 2000 �� Shop test ��
function OnEvent_2000(proxy, param)
	print("������OnEvent_2000 begin������"); --EN:print("������OnEvent_2000 begin������");
	proxy:SetTalkMsg( 0, true );
	print("������OnEvent_2000 end������"); --EN:print("������OnEvent_2000 end������");
end

--------------------------------------------------------------------------------------
--�|�C���g���@�e�X�g�F��2020 --EN:--Point magic test: ��2020
--------------------------------------------------------------------------------------
function OnEvent_2020(proxy,param)
	print("OnEvent_2020 begin");
	--�I�[�i�[ID2021�A�����|�C���gID2020�A�������@ID1 --EN:--Owner ID 2021, activation point ID 2020, activation magic ID 1
	--�����p270,0,0 --EN:-- launch angle 270,0,0
	--proxy:CastPointSpell(2021,2020,1,270,0,0);
	--SFX�쐬  --EN:--SFX creation
	--�����ꏊ�@�|�C���gID	�F2020 --EN:--Place of occurrence Point ID: 2020
	--����SFX	SFXID		�F701 --EN:--Generated SFX SFXID: 701
	proxy:CreateSfx(2020,701);	
	print("OnEvent_2020 end");
end

--------------------------------------------------------------------------------------
--�|�C���g���@�e�X�g�F��2030 --EN:--Point magic test: ��2030
--------------------------------------------------------------------------------------
function OnEvent_2030(proxy,param)
	print("OnEvent_2030 begin");	
	--SFX�쐬  --EN:--SFX creation
	--�����ꏊ�@�|�C���gID	�F2020 --EN:--Place of occurrence Point ID: 2020
	--����SFX	SFXID		�F701 --EN:--Generated SFX SFXID: 701
	proxy:CreateSfx(2020,701);
	print("OnEvent_2030 end");
end


--------------------------------------------------------------------------------------
--�p�j�f�[�����̓o�ꁡ?? --EN:-- Appearance of the Wandering Demon ??
--------------------------------------------------------------------------------------

--���O���[�o���̎��S�Ď�����Ă΂��(�\��) --EN:--�� Called from global death watch (solo)
function PlayerDeath_m99_60_00_00(proxy, param)
	print("PlayerDeath_m99_60_00_00");
	
--	LuaFunc_VisibleTheWanderingDemon(proxy, param, demon_id_list_m99_60_00_00);
--	proxy:SetEventFlag( 20 , 1 );--�t���O�͉��A�w�肪����Ες���B --EN:The -- flag is tentative, and will be changed if specified.
	
	print("PlayerDeath_m99_60_00_00");
end

--���O���[�o���̌�������������Ă΂��(�\��) --EN:--��Called from global blood letter revival (solo)
function PlayerRevive_m99_60_00_00(proxy,param)
	print("PlayerRevive_m99_60_00_00");
	
--	LuaFunc_InvisibleTheWanderingDemon(proxy, param, demon_id_list_m99_60_00_00);
--	proxy:SetEventFlag( 20 , 0 );--�t���O�͉��A�w�肪����Ες���B --EN:The -- flag is tentative, and will be changed if specified.
	
	print("PlayerRevive_m99_60_00_00");
end





function OnEvent_128(proxy,param)
	print("OnEvent_128 ��������"); --EN:print("OnEvent_128 reacted");
	proxy:OnPlayerActionInRegion(129,31,"OnEvent_129",HELPID_GO_TO_IN,once);
end

function OnEvent_129(proxy,param)
	print("OnEvent_129 ��������"); --EN:print("OnEvent_129 reacted");
	proxy:OnPlayerActionInRegion(130,32,"OnEvent_130",HELPID_GO_TO_IN,once);
end






function Check_3000(proxy,param)
	if proxy:IsEquip(TYPE_WEAPON,10000) == true then
		print("IsEquip�@TYPE_WEAPON�@ true"); --EN:print("IsEquip TYPE_WEAPON true");
		return true;
	end
	if proxy:IsEquip(TYPE_PROTECTER,101800) == true then
		print("IsEquip�@TYPE_PROTECTER�@ true"); --EN:print("IsEquip TYPE_PROTECTER true");
		return true;
	end
	if proxy:IsInventoryEquip(TYPE_WEAPON,21500) == true then
		print("�����h�����̌������Ă��["); --EN:print("I have King Lendl's sword");
		return true;
	end
	--print("IsEquip false");
	return false;
end


function OnEvent_3000(proxy,param)
	print("OnEvent_3000");	
end

--HP�̊����Ď��̃n���h�� --EN:--HP rate monitor handler
function OnEvent_2041(proxy,param)
	print("�Ď����o�^����Ă���ő��1��HP��������"); --EN:print("The maximum HP has decreased by 10% since the monitor was registered");
end

function OnEvent_600(proxy,param)
	print("OnEvent_600 begin");
	print("OnEvent_600 end");
end


function OnEvent_33(proxy,param)
	print("OnEvent_33 begin");
	if param:IsNetMessage() == true then
		print("�z�M���ꂽ"); --EN:print("Delivered");
	else
		print("�z�M����"); --EN:print("delivered");
	end
	
	if proxy:IsCompleteEvent(50) == true then
		print("�̈�ɓ����Ă���"); --EN:print("in area");
	else
		print("�̈�ɒN�����Ȃ�"); --EN:print("nobody in area");
	end
	print("OnEvent_33 end");
end

function OnEvent_56(proxy,param)
	print("OnEvent_56 begin");
	print("OnEvent_56 end");
end

function OnEvent_57(proxy,param)
	if proxy:IsCompleteEvent(12001) == false then
		if proxy:IsRegionDrop(12000,10000,40) == true then
			print("Drop!!");
			proxy:SetEventFlag(12000,true);
		end
	else
		print("Event Complete!");
		proxy:SetEventFlag(12000,false);
		proxy:DeleteEvent(57);
	end
end

function OnEvent_12000(proxy,param)
	print("OnEvent_12000 begin");
	proxy:SetEventFlag(12000,false);
	print("OnEvent_12000 end");
end



--�N���A�C�x���g�e�X�g --EN:--clear event test
function OnEvent_60(proxy,param)
	print("OnEvent_60 begin");
	--�V�u���b�N�N���A���Ăяo�� --EN:--Call new block clear
	proxy:LuaCallStart(4050,1);
	print("OnEvent_60 end");
end

function OnEvent_100(proxy,param)
	print("OnEvent_100 begin");	
	proxy:ForceDead( 10000 );
	proxy:OnKeyTime2( 100 , "OnEvent_100_1",0.125,0,0,once);
	print("OnEvent_100 end");
end

function OnEvent_100_1(proxy,param)
	print("OnEvent_100_1 begin");
	proxy:ForceDead( 100 );
	print("OnEvent_100_1 end");
end

function OnEvent_500_fire(proxy,param)
	print("OnEvent_500_fire begin");
	print("OnEvent_500_fire end");
end


