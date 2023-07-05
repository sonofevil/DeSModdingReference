once = 1;
everytime = 0;





function Initialize_m99_99_11_00(proxy)
print("Initialize m99_99_11_00 begin");


--[[���`���[�g���A���p�̃C�x���g]] --EN:--[[��Tutorial event]]



--��1000���n�V�SA(�΂�10�x)�~�聡 --EN:-- �� 1000 �� Ladder A (diagonal 10 degrees) descend ��
	proxy:OnActionEventRegion(1000, 2100, "OnEvent_1000", LadderAngle_A, HELPID_DOWN, everytime);
--��1001���n�V�SA(�΂�10�x)���聡 --EN:-- �� 1001 �� Ladder A (diagonal 10 degrees) climbing ��
	proxy:OnActionEventRegion(1001, 2101, "OnEvent_1001", LadderAngle_A, HELPID_UP,   everytime);

	


	
--��6000��NPC��b��--�ėp��b�ꋓ�o�^(���͔���A������A�͈͊O����)	��ValueBuffer�@20010�g --EN:-- �� 6000 �� NPC conversation �� -- general-purpose conversation all-at-once registration (input judgment, audible judgment, out-of-range judgment) * Using ValueBuffer 20010
	if proxy:IsCompleteEvent( 6000 ) == false then
		OnTalk(proxy,6000,101,TalkDist_N,TalkAngle_N,20010,HELPID_TALK,"OnEvent_6000","OnEvent_6000_1","OnEvent_6000_2",everytime);
		--��1103��NPC��b:PC����U�������ꂽ������--NPC(101)���v���C���[����U�����ꂽ�� --EN:--��1103 ��NPC Conversation: Processing when attacked by PC ��--When NPC (101) is attacked by the player
		proxy:OnSimpleDamage(1103,101,10000,"OnEvent_1103",everytime);
		--��1101��NPC��b�F���S������--PC���C�x���gID101��HP��0�ɂ����Ƃ� --EN:-- �� 1101 �� NPC conversation: death processing �� -- When the PC reduces the HP of event ID 101 to 0
		proxy:OnCharacterHP(1101,101,"OnEvent_1101",0.0,once);
		--��1102��NPC��b�F���S���S������--�C�x���gID101�����S�Ɏ��񂾂Ƃ� --EN:-- �� 1102 �� NPC conversation: complete death process �� -- When event ID 101 is completely dead
		proxy:OnCharacterDead(1102,101,"OnEvent_1102",once);
	end
	
		

--�G���A���Z�b�g���Ȃ��悤�Ƀt���O�ς��܂����B --EN:--Changed the flag not to reset the area.

--��6020�������J���遡 --EN:-- �� 6020 �� open the door ��
--�o�b���A�C�x���g�G���A(1)�̒��ɋ��āA --EN:--When the PC is in the event area (1),
--����̊p�x�������Ă��āA --EN:-- facing a certain angle,
--�A�N�V�����{�^�����������Ƃ� --EN:--when you press the action button
	if proxy:IsCompleteEvent( 6020 ) == false then
		proxy:OnPlayerActionInRegionAngle( 6020, 1, "OnEvent_6020", 30, HELPID_PULL_LEVER, once);
	else
		proxy:EndAnimation( 1, 1 );--���o�[ --EN:--lever
		proxy:EndAnimation( 2, 1 );--�� --EN:--door
	end

		
--�G���A���Z�b�g���Ȃ��悤�Ƀt���O�ς��܂����B --EN:--Changed the flag not to reset the area.

--��6010������钌1 --EN:-- �� 6010 �� Collapsed Pillar 1
--�E�o�b���̓w�r���m�ic0000/6010�j���A�C�x���g�G���A�i2�j�ɓ��B�����Ƃ� --EN:--�EWhen a PC or snake soldier (c0000/6010) reaches the event area (2)
	if proxy:IsCompleteEvent( 6010 ) == false then
		proxy:OnRegionJustIn( 6010, 10000, 2, "OnEvent_6010", once);
	end

--��6011���֕��m�N��? --EN:-- �� 6011 �� Snake soldier activation?
--�E�o�b���A�C�x���g�G���A�i3�j�ɓ��B�����Ƃ� --EN:--�EWhen the PC reaches the event area (3)
	if proxy:IsCompleteEvent( 6011 ) == false then
		proxy:OnRegionJustIn( 6011, 10000, 3, "OnEvent_6011", once);
	end

--��6012������钌2 --EN:-- �� 6012 �� Collapsed Pillar 2
--�E�o�b�܂��̓w�r���m�ic0000/6011�j���A�C�x���g�G���A�i4�j�ɓ��B�����Ƃ� --EN:--�EWhen a PC or snake soldier (c0000/6011) reaches the event area (4)
	if proxy:IsCompleteEvent( 6012 ) == false then
		proxy:OnRegionJustIn( 6012, 10000, 4, "OnEvent_6012", once);	
	end		
		

		
		
--�G���A���Z�b�g���Ȃ��悤�Ƀt���O�ς��܂����B --EN:--Changed the flag not to reset the area.

		
--��6030���f�u�f�[�����������J�� --EN:-- �� 6030 �� Fat Demon room door open
--�E�f�u�f�[����(120)���S���o�C�x���g�i�C�x���gID122�j���A�I�������Ƃ� --EN:--�EWhen the fat demon (120) death effect event (event ID 122) ends
	if proxy:IsCompleteEvent( 6030 ) == false then
		proxy:OnCharacterDead( 6030, 120, "OnEvent_6030", once);
	else
		proxy:EndAnimation( 123 , 1 );
	end
	
	
		

--[[�����܂ł������C�x���g]] --EN:--[[��Previous Events]]


--	�N�������@�v���C�A���� --EN:-- Who ignores only player
--	EventID, Who(����), RegionID, handler, bOnce	 --EN:-- EventID, Who(ignore), RegionID, handler, bOnce

--[[�@�ȑO�̂ł��B --EN:--[[ Earlier.

--��131�������J���遡 --EN:-- �� 131 �� open the door ��
--�o�b���A�C�x���g�G���A(1)�̒��ɋ��āA --EN:--When the PC is in the event area (1),
--����̊p�x�������Ă��āA --EN:-- facing a certain angle,
--�A�N�V�����{�^�����������Ƃ� --EN:--when you press the action button
	proxy:OnPlayerActionInRegionAngle( 131, 1, "OnEvent_131", 30, HELPID_PULL_LEVER, once);

]]


	
--[[ �ȑO�̂ł��B --EN:--[[ was earlier.

--��102������钌1 --EN:-- �� 102 �� collapsing pillar 1
--�E�o�b���̓w�r���m�ic0000/102�j���A�C�x���g�G���A�i2�j�ɓ��B�����Ƃ� --EN:--�EWhen a PC or snake soldier (c0000/102) reaches the event area (2)
	proxy:OnRegionJustIn( 102, 10000, 2, "OnEvent_102", once);


--��103������钌1 --EN:-- �� 103 �� Collapsed Pillar 1
--�E�o�b���A�C�x���g�G���A�i3�j�ɓ��B�����Ƃ� --EN:--�EWhen the PC reaches the event area (3)
	proxy:OnRegionJustIn( 103, 10000, 3, "OnEvent_103", once);


--��104������钌2 --EN:-- �� 104 �� Collapsed Pillar 2
--�E�o�b�܂��̓w�r���m�ic0000/103�j���A�C�x���g�G���A�i4�j�ɓ��B�����Ƃ� --EN:--�EWhen a PC or snake soldier (c0000/103) reaches the event area (4)
	proxy:OnRegionJustIn( 104, 10000, 4, "OnEvent_104", once);
]]
	
	
--��110���������Đ�1 --EN:-- �� 110 �� Blood letter reproduction 1
--�E�o�b���C�x���g�G���A(10)���ŃA�N�V�����{�^������������ --EN:--�EWhen the PC presses the action button in the event area (10)
	
	--proxy:OnPlayerActionInRegion( 110, 10, "OnEvent_110",1, everytime);

	
--[[ �ȑO�̂ł��B --EN:--[[ was earlier.

--��123���f�u�f�[�����������J�� --EN:-- �� 123 �� Fat Demon room door open
--�E�f�u�f�[����(120)���S���o�C�x���g�i�C�x���gID122�j���A�I�������Ƃ� --EN:--�EWhen the fat demon (120) death effect event (event ID 122) ends
	proxy:OnCharacterDead( 123, 120, "OnEvent_123", once);
	
]]	
	
	
	

--��155���}�b�v�ړ��i���Ԑ��H1�e�j --EN:-- �� 155 �� Move map (�� Fort Waterway 1F)
--�E�o�b���A�C�x���g�G���A�i55�j�ɓ��B�����Ƃ� --EN:--�EWhen the PC reaches the event area (55)
	proxy:OnRegionJustIn( 155, 10000, 55, "OnEvent_155", everytime);


--��165���}�b�v�ړ��i���Ԑ��H2�e�j --EN:-- �� 165 �� Move map (�� Fort Waterway 2F)
--�E�o�b���A�C�x���g�G���A�i65�j�ɓ��B�����Ƃ� --EN:--�EWhen the PC reaches the event area (65)
	proxy:OnRegionJustIn( 165, 10000, 65, "OnEvent_165", everytime);


--��175���}�b�v�ړ��i���n��L��j --EN:-- �� 175 �� Map movement (�� lava square)
--�E�o�b���A�C�x���g�G���A�i75�j�ɓ��B�����Ƃ� --EN:--�EWhen the PC reaches the event area (75)
	proxy:OnRegionJustIn( 175, 10000, 75, "OnEvent_175", everytime);
	
	
--��??���p�j�f�[�����̓o�ꁡ�n���h���o�^ --EN:--��??��Appearance of wandering daemon��Handler registration
	proxy:NotNetMessage_begin();
		--�v���C���[���\���Ŏ��S�������ɃL�b�N����܂��B --EN:--Kicked when a player dies solo.
		proxy:LuaCall( 4000, 100, "PlayerDeath_m99_99_11_00", everytime );
		--�v���C���[�������������ɃL�b�N����܂��B --EN:--Kicked when the player is revived.
		proxy:LuaCall( 4032, 100, "PlayerRevive_m99_99_11_00", everytime );
	proxy:NotNetMessage_end();
	
	
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 99998, "MapInit", 0.0, 0, 0, once );
	proxy:NotNetMessage_end();


print("Initialize m99_99_11_00 end");
end

function MapInit(proxy,param )

--[[�܂��ɏ����Ă��������� --EN:--[[What was written before

	if proxy:IsCompleteEvent( 102 ) ==true then
--		proxy:ChangeModel(20, 1);
--		proxy:SetBrokenPiece(20);
		proxy:ReconstructBreak( 20 , 1 );
	end
	if proxy:IsCompleteEvent(131) ==true then
		proxy:EndAnimation(1, 1);
		proxy:EndAnimation(2, 1);
	end
]]


--NPC�̎��S�Č� --EN:--NPC death reproduction

	if proxy:IsCompleteEvent( 6000 ) == true then
		proxy:ForceDead( 101 );
	end

--���{�X�̎��S�Č� --EN:-- Mid-boss death reproduction
	
	if proxy:IsCompleteEvent( 6030 ) == true then
		proxy:ForceDead( 120 );
	end

--���W�b�N���� --EN:--Logic control

--��6011���֕��m�N��? --EN:-- �� 6011 �� Snake soldier activation?
	if proxy:IsCompleteEvent( 6011 ) == true then
		proxy:EnableLogic( 103 , 1 );
	else
		proxy:EnableLogic( 103 , 0 );
	end
	
	
--���̔j��Č�(�G���A����Ȃ������Ƃ��p) --EN:--Pillar destruction reproduction (for when re-entering the area)
	
--��6010������钌1 --EN:-- �� 6010 �� Collapsed Pillar 1
	if proxy:IsCompleteEvent( 6010 ) == true then
		proxy:ReconstructBreak( 20 , 1 );
	end

--��6012������钌2 --EN:-- �� 6012 �� Collapsed Pillar 2
	if proxy:IsCompleteEvent( 6012) == true then
		proxy:ReconstructBreak( 41 , 1 );
	end

--[[
	--���p�j�f�[�����p (�t���O�͉��A�w�肪����Ες���) --EN:--��For wandering daemon (flag is tentative, change if specified)
	if proxy:IsCompleteEvent( 20 ) == true then
		LuaFunc_VisibleTheWanderingDemon  (proxy, param, demon_id_list_m99_99_11_00);
	else
		LuaFunc_InvisibleTheWanderingDemon(proxy, param, demon_id_list_m99_99_11_00);
	end
]]

end

--------------------------------------------------------------------------------------
--�}���`�ɂȂ������Ƀz�X�g���ᖳ�������灡���� --EN:--If you are not a host when you become multi, no
--------------------------------------------------------------------------------------
function ConnectPartyEvent(proxy)
	print("ConnectPartyEvent begin");
	print("ConnectPartyEvent end");
end





--[[ �`���[�g���A���p ]] --EN:--[[ For tutorials ]]


--��6020�������J���� --EN:-- �� 6020 �� Open the door
function OnEvent_6020(proxy, param)
print("OnEvent_6020 begin");

	if param:IsNetMessage()==true  then
		return;         
	end

--�EPC���C�x���g�G���A(100)�Ɉړ� --EN:--�EMove the PC to the event area (100)
	proxy:Warp(10000, 100);
--�EPC�̃��o�[����A�j���[�V����(ID 4000)�Đ� --EN:--�EPC lever movement animation (ID 4000) playback
	proxy:PlayAnimation(10000, 8000);
	
--�E�C�x���g�t���O�𗧂Ă� --EN:--�ESet an event flag
	proxy:SetEventFlag( 6020, 1 );
--�E�X�C�b�`�n�a�i�io0210/1�j���쓮����A�j���[�V�����iID 1�j���Đ� --EN:--�EPlay the animation (ID 1) that activates the switch OBJ (o0210/1)
--�@�i����΁j�쓮�r�d�iID****�j��炷 --EN:-- (if any) sound the activation SE (ID****)
	proxy:PlayAnimation(1, 1)

--�E�����ɔ��n�a�i�io0211/2�j���J���A�j���[�V�����iID 1�j���Đ� --EN:--�E Simultaneously play the animation (ID 1) that the door OBJ (o0211/2) opens
--�@�i����΁j�����J���r�d�iID****�j��炷 --EN:-- (If there is) ring the SE (ID****) that opens the door
--�E���̓�����𓮂����A�ړ��ł���悤�ɂ��� --EN:--�EMove the hit of the door so that it can be moved
	proxy:PlayAnimation(2, 1)

print("OnEvent_6020 end");
end




--��6010������钌1 --EN:-- �� 6010 �� Collapsed Pillar 1
function OnEvent_6010(proxy, param)
print("OnEvent_6010 begin");

--�E�C�x���g�t���O�𗧂Ă� --EN:--�ESet an event flag
	proxy:SetEventFlag( 6010, 1 );
--�E�V��n�a�i�io0224/20�j�� --EN:--�ECeiling OBJ (o0224/20)
--�@�n�{�b�N�n�a�i�io0224_1/20�j�ɍ����ւ��āA���������� --EN:-- Replace with Havoc OBJ (o0224_1/20) and let it drop
	proxy:ChangeModel(20, 1);
	proxy:SetBrokenPiece(20);

--�E�n�{�b�N�n�a�i�ɍU��������𔭐������� --EN:--�EHavoc OBJ will generate an attack hit
--�E�n�{�b�N�n�a�i���L�����N�^�[�̃J�v�Z��������ɓ��������ꍇ�A --EN:--�EIf the Havoc OBJ hits the character's capsule,
--�@�_���[�W���[�V�������Đ����� --EN:-- Play damage motion
--�E�n�{�b�N�n�a�i�̍U��������́A���A�ǂ�����ɂ����������_�ŏ��� --EN:--�EHavoc OBJ's attack is erased when it hits the floor or wall
--�E�i����΁j�����Ԃ���r�d�iID****�j��炷 --EN:--�ESound the SE (ID****) where the pillar collides (if any)

print("OnEvent_6010 end");
end



--��6011���w�r���m�N�� --EN:-- �� 6011 �� Snake soldier activation
function OnEvent_6011(proxy, param)
print("OnEvent_6011 begin");

--�E�w�r���m�ic1000/6011�j�̃��W�b�N��ʏ�ɐ؂�ւ��� --EN:--�ESwitch logic of Snake Soldier (c1000/6011) to normal
	proxy:EnableLogic(103, true);

print("OnEvent_6011 end");
end




--��6012������钌2 --EN:-- �� 6012 �� Collapsed Pillar 2
function OnEvent_6012(proxy, param)
print("OnEvent_6012 begin");

--�E�C�x���g�t���O�𗧂Ă� --EN:--�ESet an event flag
	proxy:SetEventFlag( 6012, 1 );
--�E���n�a�i�io0225/41�j�� --EN:--�EPillar OBJ (o0225/41)
--�@�n�{�b�N�n�a�i�io0225_1/41�j�ɍ����ւ��āA���������� --EN:-- Replace with Havoc OBJ (o0225_1/41) and let it drop

	proxy:ChangeModel(41, 1);
	proxy:SetBrokenPiece(41);

--�E�n�{�b�N�n�a�i�ɍU��������𔭐������� --EN:--�EHavoc OBJ will generate an attack hit
--�E�n�{�b�N�n�a�i���L�����N�^�[�̃J�v�Z��������ɓ��������ꍇ�A --EN:--�EIf the Havoc OBJ hits the character's capsule,
--�@�_���[�W���[�V�������Đ����� --EN:-- Play damage motion
--�E�n�{�b�N�n�a�i�̍U��������́A���A�ǂ�����ɂ����������_�ŏ��� --EN:--�EHavoc OBJ's attack is erased when it hits the floor or wall
--�E�i����΁j�����Ԃ���r�d�iID****�j��炷 --EN:--�ESound the SE (ID****) where the pillar collides (if any)

print("OnEvent_6012 end");
end





--��6030���f�u�f�[�����������J�� --EN:-- �� 6030 �� Fat Demon room door open
function OnEvent_6030(proxy, param)
print("OnEvent_6030 begin");

--�E�C�x���g�t���O�𗧂Ă� --EN:--�ESet an event flag
	proxy:SetEventFlag( 6030, 1 );

--�E�f�u�f�[���������̔��io0212/6030)�̊J���A�j���[�V�����iID 1)���Đ� --EN:--�EPlay the opening animation (ID 1) of the fat demon room door (o0212/6030)
--�E�i����΁j�����J��SE��炷 --EN:--�ESound the SE that opens the door (if available)
--�E���̓�����𓮂����A�o�b���ʂ��悤�ɂ���B --EN:--�EMove the door so that the PC can pass through.
	proxy:PlayAnimation(123, 1)


print("OnEvent_6030 end");
end



--------------------------------------------------------------------------------------
--�n�V�SB�~�聡1000 --EN:--Ladder B descend �� 1000
--------------------------------------------------------------------------------------
--��1000���n�V�SB�~��X�^�[�g�� --EN:-- �� 1000 �� Ladder B descent start ��
function OnEvent_1000(proxy, param)
	print("OnEvent_1000 begin");
	
	if param:IsNetMessage() == true then
		print("IsNetMessage true");
		print("OnEvent_1000 end");
		return;
	end

	--�͂����~��ɕK�v�ȑO����-- --EN:--Pretreatment required for descending the ladder--
	proxy:BeginAction(10000,2,2,2);				--�z�o�[�ړ����[�h�Ɉڍs --EN:--Transition to hover movement mode
	proxy:HoverMoveVal(10000,2102,LadderTime_A);--�ړ��ʒu(2102)��0.5�b�Ńz�o�[�ړ� --EN:--Hover to move position (2102) in 0.5 seconds
	proxy:SetEventCommand(10000,1);				--�C�x���g�R�}���hID(1)"�n�V�S�ォ���"�ނ𑗂� --EN:-- Send event command ID (1) "Grab from the top of the ladder"
	proxy:SetKeepCommandIndex(10000, 4, 1, 3.0 );
	proxy:DisableMove(10000,1);					--�L�����N�^���ړ��A����s�\�� --EN:--Move the character, make it impossible to turn
	
	proxy:NotNetMessage_begin();
		--0.5�b(�z�o�[�ړ��I��)��ɂ͂����~��X�^�[�g�C�x���g�𔭍s --EN:-- Issue a ladder descend start event after 0.5 seconds (end of hover movement)
		proxy:OnKeyTime2(1000,"OnEvent_1000_1",LadderTime_A,0,0,once);
		--�͂����~���p�̊֐���3�b�Ԕ��s(�J�����̎��荞�݂Ȃǂ̏���) --EN:--Issue a function dedicated to descending the ladder for 3 seconds (processing such as surrounding the camera)
		proxy:OnKeyTime2(1000,"LadderDown",3,1,1,once);
	proxy:NotNetMessage_end();

	print("OnEvent_1000 end");
end

--��1000_1���n�V�SB�~��X�^�[�g:�z�o�[�ړ��I���� --EN:--��1000_1�� Start descending from ladder B: End of hover movement ��
function OnEvent_1000_1(proxy, param)
	print("OnEvent_1000_1 begin");
	
	if proxy:GetEventMode(10000) == 0 then
		print("Local Player GetEventMode 0");
		print("OnEvent_1000_1 end");
		return;
	end

	--�n�V�S�A�N�V�������[�h�Ɉڍs-- --EN:--Transition to ladder action mode--
	--nMax  : �͂����̒i�� - �␳�l(�␳�l�͂����悻3) --EN:--nMax : number of ladder steps - correction value (correction value is approximately 3)
	--nStart: �~���Ƃ���(nMax + 1) ����Ƃ���(-1) --EN:--nStart: When going down��(nMax + 1) When going up��(-1)
	proxy:BeginAction(10000,1,8,7);
	
	--�L�����N�^���ړ��A����\��-- --EN:--Character can be moved and turned--
	proxy:DisableMove(10000,0);
	
	print("OnEvent_1000_1 end");
end


--------------------------------------------------------------------------------------
--�n�V�SB���聡1001 --EN:--Ladder B up 1001
--------------------------------------------------------------------------------------
--��1001���n�V�SB����X�^�[�g�� --EN:-- �� 1001 �� Ladder B climbing start ��
function OnEvent_1001(proxy, param)
	print("OnEvent_1001 begin");
	
	if param:IsNetMessage() == true then
		print("IsNetMessage true");
		print("OnEvent_1001 end");
		return;
	end
	
	--�͂�������ɕK�v�ȑO����-- --EN:--Pretreatment required for climbing a ladder--
	proxy:BeginAction(10000,2,-1,1);			--�z�o�[�ړ����[�h�Ɉڍs --EN:--Transition to hover movement mode
	proxy:HoverMoveVal(10000,2103,LadderTime_A);--�ړ��ʒu(2103)��0.5�b�Ńz�o�[�ړ� --EN:--Hover to move position (2103) in 0.5 seconds
	proxy:SetEventCommand(10000,0);				--�C�x���g�R�}���hID(0)"�n�V�S�������"�ނ𑗂� --EN:-- Send event command ID (0) "grab from under the ladder"
	proxy:SetKeepCommandIndex(10000, 4, 1, 3.0 );
	proxy:DisableMove(10000,1);					--�L�����N�^���ړ��A����s�\�� --EN:--Move the character, make it impossible to turn
	
	proxy:NotNetMessage_begin();
		--0.5�b(�z�o�[�ړ��I��)��ɂ͂�������X�^�[�g�C�x���g�𔭍s --EN:-- Issue a ladder climb start event after 0.5 seconds (end of hover movement)
		proxy:OnKeyTime2(1001,"OnEvent_1001_1",LadderTime_A,0,0,once);
		--�͂�������p�̊֐���1�b�Ԕ��s(�C�x���g���j���[�̒��f����?) --EN:--Issuing a function for climbing a ladder for 1 second (interruption processing of the event menu?)
		proxy:OnKeyTime2(1001,"EventMenuBrake",1,1,1,once);
	proxy:NotNetMessage_end();
	
	print("OnEvent_1001 end");
end

--��1001_1���n�V�SA����X�^�[�g:�z�o�[�ړ��I���� --EN:--��1001_1�� Start climbing ladder A: End of hover movement ��
function OnEvent_1001_1(proxy, param)
	print("OnEvent_1001_1 begin");
	
	if proxy:GetEventMode(10000) == 0 then
		print("Local Player GetEventMode 0");
		print("OnEvent_1001_1 end");
		return;
	end

	--�n�V�S�A�N�V�������[�h�Ɉڍs-- --EN:--Transition to ladder action mode--
	--nMax  : �͂����̒i�� - �␳�l(�␳�l�͂����悻3) --EN:--nMax : number of ladder steps - correction value (correction value is approximately 3)
	--nStart: �~���Ƃ���(nMax + 1) ����Ƃ���(-1) --EN:--nStart: When going down��(nMax + 1) When going up��(-1)
	proxy:BeginAction(10000,1,-1,7);
	
	--�L�����N�^���ړ��A����\��-- --EN:--Character can be moved and turned--
	proxy:DisableMove(10000,0);
	
	print("OnEvent_1001_1 end");
end




--------------------------------------------------------------------------------------
--NPC��b��6000��ValueBuffer 20010�g�p --EN:--NPC Conversation �� 6000 * Using ValueBuffer 20010
--------------------------------------------------------------------------------------
--��6000��NPC��b��AnctionButton���� --EN:-- �� 6000 �� NPC conversation �� ActionButton determination
function OnEvent_6000(proxy, param)
	print("OnEvent_6000 begin");
	if param:IsNetMessage()==true  then
		return;
	end
	
	FlagValue = proxy:IsCompleteEventValue(20010);

	if FlagValue ==0 then proxy:SetEventFlag( 20010, 1 ); end
	if FlagValue ==1 then
		proxy:SetEventFlag( 20010, 0 );		
	end
	print("OnEvent_6000 end");
end

--��6000_1��NPC��b�����ݕ\�����郁�b�Z�[�W --EN:-- �� 6000_1 �� NPC conversation �� Message to be displayed now
function OnEvent_6000_1(proxy, param)
	print("OnEvent_6000_1 begin");
	
	--ValueBuffer20010�̒l���擾���� --EN:--Get the value of ValueBuffer20010
	FlagValue = proxy:IsCompleteEventValue(20010);
	--�y�[�W�������ĂȂ���Δ����� --EN:--Exit if you do not turn the page
	if FlagValue ==0 then return;	 end
	if FlagValue ==1 then proxy:StartTalk(80000130,0);	 end
	
	if FlagValue ==4 then proxy:StartTalk(90000700,0);	 end--����ł�Ƃ��H --EN:--When you're dead?
	
	print("OnEvent_6000_1 end");
end

--��6000_2��NPC��b��������������o���ꍇ�̏��� --EN:-- �� 6000_2 �� NPC conversation �� Processing when leaving the reaction distance
function OnEvent_6000_2(proxy, param)
	print("OnEvent_6000_2 begin");

	--ValueBuffer20010�̒l���擾���� --EN:--Get the value of ValueBuffer20010
	FlagValue = proxy:IsCompleteEventValue(20010);

	if FlagValue >=1 then
		proxy:SetEventFlag( 20010, 0 );		
	end

	print("OnEvent_6000_2 end");
end

--��1101��NPC��b��NPC��HP��0�ɂȂ����u�� --EN:-- �� 1101 �� NPC conversation �� Moment when NPC's HP becomes 0
function OnEvent_1101(proxy, param)
	print("OnEvent_1101 begin");
	--�E�������̋������͈͓��Ȃ� --EN:--If the distance at the time of killing is within range
	if proxy:IsDistance(10000,101,TalkDist_N) == true then	
		--ValueBuffer20010�̒l��ݒ肷�� --EN:--Set the value of ValueBuffer20010
		proxy:SetEventFlag(20010,4);
	else
		--�͈͊O�Ȃ�y�[�W�������\�����Ȃ��y�[�W�� --EN:--If out of range, change the page to a page that does not display anything
		--ValueBuffer20010�̒l��ݒ肷�� --EN:--Set the value of ValueBuffer20010
		proxy:SetEventFlag(20010,5);
	
	end
		
	print("OnEvent_1101 end");
end

--��1102��NPC��b��NPC���� --EN:-- �� 1102 �� NPC conversation �� NPC dead
function OnEvent_1102(proxy, param)
	print("OnEvent_1102 begin");
	--ValueBuffer20010�̒l��ݒ肷�� --EN:--Set the value of ValueBuffer20010
	proxy:SetEventFlag(20010,0 );
	proxy:SetEventFlag(6000,1);
	--�L�����N�^������ŕK�v�Ȃ��Ȃ�̂ŉ�b�C�x���g���폜���� --EN:--Remove the conversation event because the character dies and you don't need it anymore
	proxy:DeleteEvent(6000);
	proxy:DeleteEvent(1103);
	print("OnEvent_1102 end");
end

--��1103��NPC��b:PC����U�����ꂽ������ --EN:-- �� 1103 �� NPC conversation: Process attacked from PC ��
function OnEvent_1103(proxy, param)
	print("OnEvent_1103 begin");
	if proxy:IsDistance(10000,101,TalkDist_N) == false then
		return ;
	end
	print("OnEvent_1103 end");
end






















--[[�ȑO�̂ł��B]] --EN:--[[previous. ]]


--[[

--��131�������J���� --EN:-- �� 131 �� open the door
function OnEvent_131(proxy, param)
print("OnEvent_131 begin");

	if param:IsNetMessage()==true  then
		return;         
	end

--�EPC���C�x���g�G���A(100)�Ɉړ� --EN:--�EMove the PC to the event area (100)
	proxy:Warp(10000, 100);
--�EPC�̃��o�[����A�j���[�V����(ID 4000)�Đ� --EN:--�EPC lever movement animation (ID 4000) playback
	proxy:PlayAnimation(10000, 8000);
	
--�E�C�x���g�t���O�𗧂Ă� --EN:--�ESet an event flag
	proxy:SetEventFlag( 131, 1 );
--�E�X�C�b�`�n�a�i�io0210/1�j���쓮����A�j���[�V�����iID 1�j���Đ� --EN:--�EPlay the animation (ID 1) that activates the switch OBJ (o0210/1)
--�@�i����΁j�쓮�r�d�iID****�j��炷 --EN:-- (if any) sound the activation SE (ID****)
	proxy:PlayAnimation(1, 1)

--�E�����ɔ��n�a�i�io0211/2�j���J���A�j���[�V�����iID 1�j���Đ� --EN:--�E Simultaneously play the animation (ID 1) that the door OBJ (o0211/2) opens
--�@�i����΁j�����J���r�d�iID****�j��炷 --EN:-- (If there is) ring the SE (ID****) that opens the door
--�E���̓�����𓮂����A�ړ��ł���悤�ɂ��� --EN:--�EMove the hit of the door so that it can be moved
	proxy:PlayAnimation(2, 1)

print("OnEvent_131 end");
end

]]







--[[

--��102������钌1 --EN:-- �� 102 �� collapsing pillar 1
function OnEvent_102(proxy, param)
print("OnEvent_102 begin");

--�E�C�x���g�t���O�𗧂Ă� --EN:--�ESet an event flag
	proxy:SetEventFlag( 102, 1 );
--�E�V��n�a�i�io0224/20�j�� --EN:--�ECeiling OBJ (o0224/20)
--�@�n�{�b�N�n�a�i�io0224_1/20�j�ɍ����ւ��āA���������� --EN:-- Replace with Havoc OBJ (o0224_1/20) and let it drop
	proxy:ChangeModel(20, 1);
	proxy:SetBrokenPiece(20);

--�E�n�{�b�N�n�a�i�ɍU��������𔭐������� --EN:--�EHavoc OBJ will generate an attack hit
--�E�n�{�b�N�n�a�i���L�����N�^�[�̃J�v�Z��������ɓ��������ꍇ�A --EN:--�EIf the Havoc OBJ hits the character's capsule,
--�@�_���[�W���[�V�������Đ����� --EN:-- Play damage motion
--�E�n�{�b�N�n�a�i�̍U��������́A���A�ǂ�����ɂ����������_�ŏ��� --EN:--�EHavoc OBJ's attack is erased when it hits the floor or wall
--�E�i����΁j�����Ԃ���r�d�iID****�j��炷 --EN:--�ESound the SE (ID****) where the pillar collides (if any)

print("OnEvent_102 end");
end






--��103���w�r���m�N�� --EN:-- �� 103 �� Snake soldier activation
function OnEvent_103(proxy, param)
print("OnEvent_103 begin");

--�E�w�r���m�ic1000/103�j�̃��W�b�N��ʏ�ɐ؂�ւ��� --EN:--�ESwitch logic of Snake Soldier (c1000/103) to normal
	proxy:EnableLogic(103, true);

print("OnEvent_103 end");
end






--��104������钌2 --EN:-- �� 104 �� Collapsed Pillar 2
function OnEvent_104(proxy, param)
print("OnEvent_104 begin");

--�E�C�x���g�t���O�𗧂Ă� --EN:--�ESet an event flag
	proxy:SetEventFlag( 104, 1 );
--�E���n�a�i�io0225/41�j�� --EN:--�EPillar OBJ (o0225/41)
--�@�n�{�b�N�n�a�i�io0225_1/41�j�ɍ����ւ��āA���������� --EN:-- Replace with Havoc OBJ (o0225_1/41) and let it drop

	proxy:ChangeModel(41, 1);
	proxy:SetBrokenPiece(41);

--�E�n�{�b�N�n�a�i�ɍU��������𔭐������� --EN:--�EHavoc OBJ will generate an attack hit
--�E�n�{�b�N�n�a�i���L�����N�^�[�̃J�v�Z��������ɓ��������ꍇ�A --EN:--�EIf the Havoc OBJ hits the character's capsule,
--�@�_���[�W���[�V�������Đ����� --EN:-- Play damage motion
--�E�n�{�b�N�n�a�i�̍U��������́A���A�ǂ�����ɂ����������_�ŏ��� --EN:--�EHavoc OBJ's attack is erased when it hits the floor or wall
--�E�i����΁j�����Ԃ���r�d�iID****�j��炷 --EN:--�ESound the SE (ID****) where the pillar collides (if any)

print("OnEvent_104 end");
end


]]



--��110���������Đ�1 --EN:-- �� 110 �� Blood letter reproduction 1
--�E�o�b���C�x���g�G���A(10)���ŃA�N�V�����{�^������������ --EN:--�EWhen the PC presses the action button in the event area (10)
function OnEvent_110(proxy, param)
print("OnEvent_110 begin");
--�E���v���C�S�[�X�g�i****/110�j�o�����o --EN:--�EReplay ghost (****/110) appearance effect
--�E���v���C�S�[�X�g�̃A�j���[�V�����iID****�j���Đ� --EN:--�EPlay replay ghost animation (ID****)
--���S�[�X�g�̃��[�g�͂R�c����Ƒ��k --EN:--> Discuss the ghost route with 3D
--
--���������́A���o�s�v�i�r�e�w�A�T�E���h�Ƃ��Ɂj --EN:--*Blood letters do not require production (both SFX and sound)

	proxy:BeginReplayGhost(0);


print("OnEvent_110 end");
end



--[[

--��123���f�u�f�[�����������J�� --EN:-- �� 123 �� Fat Demon room door open
function OnEvent_123(proxy, param)
print("OnEvent_123 begin");

--�E�C�x���g�t���O�𗧂Ă� --EN:--�ESet an event flag
	proxy:SetEventFlag( 123, 1 );

--�E�f�u�f�[���������̔��io0212/123)�̊J���A�j���[�V�����iID 1)���Đ� --EN:--�EPlay the opening animation (ID 1) of the fat demon room door (o0212/123)
--�E�i����΁j�����J��SE��炷 --EN:--�ESound the SE that opens the door (if available)
--�E���̓�����𓮂����A�o�b���ʂ��悤�ɂ���B --EN:--�EMove the door so that the PC can pass through.
	proxy:PlayAnimation(123, 1)


print("OnEvent_123 end");
end

]]




--��155���}�b�v�ړ��i���Ԑ��H1�e�j --EN:-- �� 155 �� Move map (�� Fort Waterway 1F)
function OnEvent_155(proxy, param)
print("OnEvent_155 begin");
	if param:IsNetMessage()==true  then
		return;         
	end
--�}���`�v���C�̎��̃G���A�ړ����~�߂� --EN:-- Stop area movement during multiplayer
	if proxy:IsInParty() == true then
		return;
	end 

--�E���ǂ蒅�����o�b�̂݁A�Ԃ���Ԑ��H�im99_99_10_00�j�̎w��ʒu�Ɉړ����� --EN:--�EOnly the PCs that arrive move from the fort to the specified location in the fort waterway (m99_99_10_00).
--�E�ړ���im99_99_10_00�j�̑Ή��L�����C�x���gID --EN:--�E Corresponding character event ID of destination (m99_99_10_00)
--�@�o�b�i0�j���L�����i10�j --EN:-- PC (0) �� Character (10)
--�@�o�b�i1�j���L�����i11�j --EN:-- PC (1) �� Character (11)
--�@�o�b�i2�j���L�����i12�j --EN:-- PC (2) �� Character (12)
--�@�o�b�i3�j���L�����i13�j --EN:-- PC (3) �� Character (13)
	playerId = proxy:GetLocalPlayerId();
	if playerId ==0 then proxy:WarpNextStage(99,99,10,00, 10); end
	if playerId ==1 then proxy:WarpNextStage(99,99,10,00, 11); end
	if playerId ==2 then proxy:WarpNextStage(99,99,10,00, 12); end
	if playerId ==3 then proxy:WarpNextStage(99,99,10,00, 13); end

--���ړ�����L�����N�^�[�́A�ړ����Ƀp�b�Ə����Ă��܂��܂� --EN:--* Characters that move will be erased when moving.

print("OnEvent_155 end");
end






--��165���}�b�v�ړ��i���Ԑ��H2�e�j --EN:-- �� 165 �� Move map (�� Fort Waterway 2F)
function OnEvent_165(proxy, param)
print("OnEvent_165 begin");
	if param:IsNetMessage()==true  then
		return;         
	end
--�}���`�v���C�̎��̃G���A�ړ����~�߂� --EN:-- Stop area movement during multiplayer
	if proxy:IsInParty() == true then
		return;
	end 

--�E���ǂ蒅�����o�b�̂݁A�Ԃ���Ԑ��H�im99_99_10_00�j�̎w��ʒu�Ɉړ����� --EN:--�EOnly the PCs that arrive move from the fort to the specified location in the fort waterway (m99_99_10_00).
--�E�ړ���im99_99_10_00�j�̑Ή��L�����C�x���gID --EN:--�E Corresponding character event ID of destination (m99_99_10_00)
--�@�o�b�i0�j���L�����i20�j --EN:-- PC (0) �� Character (20)
--�@�o�b�i1�j���L�����i21�j --EN:-- PC (1) �� Character (21)
--�@�o�b�i2�j���L�����i22�j --EN:-- PC (2) �� Character (22)
--�@�o�b�i3�j���L�����i23�j --EN:--PC (3) �� Character (23)
	playerId = proxy:GetLocalPlayerId();
	if playerId ==0 then proxy:WarpNextStage(99,99,10,00, 20); end
	if playerId ==1 then proxy:WarpNextStage(99,99,10,00, 21); end
	if playerId ==2 then proxy:WarpNextStage(99,99,10,00, 22); end
	if playerId ==3 then proxy:WarpNextStage(99,99,10,00, 23); end

--���ړ�����L�����N�^�[�́A�ړ����Ƀp�b�Ə����Ă��܂��܂� --EN:--* Characters that move will be erased when moving.

print("OnEvent_165 end");
end






--��175���}�b�v�ړ��i���n��L��j --EN:-- �� 175 �� Map movement (�� lava square)
function OnEvent_175(proxy, param)
print("OnEvent_175 begin");
	if param:IsNetMessage()==true  then
		return;         
	end
--�}���`�v���C�̎��̃G���A�ړ����~�߂� --EN:-- Stop area movement during multiplayer
	if proxy:IsInParty() == true then
		return;
	end 

--�E���ǂ蒅�����o�b�̂݁A�Ԃ���n��L��im99_99_12_00�j�̎w��ʒu�Ɉړ� --EN:--�EOnly the PCs that arrive move from the fort to the specified location in the lava square (m99_99_12_00).
--�E�ړ���im99_99_12_00�j�̑Ή��L�����C�x���gID --EN:--�E Corresponding character event ID of destination (m99_99_12_00)
--�@�o�b�i0�j���L�����i30�j --EN:-- PC (0) �� Character (30)
--�@�o�b�i1�j���L�����i31�j --EN:-- PC (1) �� Character (31)
--�@�o�b�i2�j���L�����i32�j --EN:-- PC (2) �� Character (32)
--�@�o�b�i3�j���L�����i33�j --EN:-- PC (3) �� Character (33)
	playerId = proxy:GetLocalPlayerId();
	if playerId ==0 then proxy:WarpNextStage(99,99,12,00, 30); end
	if playerId ==1 then proxy:WarpNextStage(99,99,12,00, 31); end
	if playerId ==2 then proxy:WarpNextStage(99,99,12,00, 32); end
	if playerId ==3 then proxy:WarpNextStage(99,99,12,00, 33); end

--���ړ�����L�����N�^�[�́A�ړ����Ƀp�b�Ə����Ă��܂��܂� --EN:--* Characters that move will be erased when moving.

print("OnEvent_175 end");
end




--------------------------------------------------------------------------------------
--�p�j�f�[�����̓o�ꁡ?? --EN:-- Appearance of the Wandering Demon ??
--------------------------------------------------------------------------------------

--���O���[�o���̎��S�Ď�����Ă΂��(�\��) --EN:--�� Called from global death watch (solo)
function PlayerDeath_m99_99_11_00(proxy, param)
	print("PlayerDeath_m99_99_11_00");
	
--	LuaFunc_VisibleTheWanderingDemon(proxy, param, demon_id_list_m99_99_11_00);
--	proxy:SetEventFlag( 20 , 1 );--�t���O�͉��A�w�肪����Ες���B --EN:The -- flag is tentative, and will be changed if specified.
	
	print("PlayerDeath_m99_99_11_00");
end

--���O���[�o���̌�������������Ă΂��(�\��) --EN:--��Called from global blood letter revival (solo)
function PlayerRevive_m99_99_11_00(proxy,param)
	print("PlayerRevive_m99_99_11_00");
	
--	LuaFunc_InvisibleTheWanderingDemon(proxy, param, demon_id_list_m99_99_11_00);
--	proxy:SetEventFlag( 20 , 0 );--�t���O�͉��A�w�肪����Ες���B --EN:The -- flag is tentative, and will be changed if specified.
	
	print("PlayerRevive_m99_99_11_00");
end


