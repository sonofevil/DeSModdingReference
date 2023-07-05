--����ȃC�x���g�E�E�E�R���ƌ����Ă�o�[�j�B�B�B�B! --EN:--This kind of event... tell me it's a lie, Bernie!


--���������������́A������Q�Ƃ��ăt�@���l���������� --EN:--When forced summoning is successful, refer to this and activate the funnel
ForceSummonBlack_PlayerNo				= -1;

ForceSummonTimeOut						= 100;
--ForceSummonTimeOut						= 10;


--------------------------------------------------------------------------------------
--�}�b�v�ǂݍ��ݎ��ɓǂ܂�鏉���������� --EN:--Initialization process read when reading the map ��
--------------------------------------------------------------------------------------
function Initialize_m04_02_00_00(proxy)
	print("Initialize_m04_02_00_00 begin");	

--��1065���u���b�NNPC�����o���p��LuaCall�o�^ --EN:-- �� 1065 �� LuaCall registration for black NPC synchronous appearance
	proxy:LuaCall( 1065, 2, "SynchroValid_1065", everytime );
	proxy:LuaCall( 1065, 3, "SynchroValid_NoAnim_1065", everytime );
	proxy:LuaCall( 1065, 4, "SynchroInvalid_1065", everytime );
	proxy:LuaCall( 1065, 5, "SynchroInvalid_1065_ForBlack",everytime );--�������������ꂽ���̔O�̈� --EN:--Just in case Kuroo was summoned
	proxy:LuaCall( 1065, 4271, "SynchroWarp_1065", everytime );
	proxy:LuaCall( 1065, 2420, "SynchroWarp_1065", everytime );
	proxy:LuaCall( 1065, 2421, "SynchroWarp_1065", everytime );
	proxy:LuaCall( 1065, 2422, "SynchroWarp_1065", everytime );
	
	--���������u���b�N�S�[�X�g�������������ꂽ --EN:-- Forced Summon Black Ghost was forced summoned
	proxy:LuaCall( 4041, 4, "Check_Summon",			everytime );

	proxy:LuaCall( 4041, 1, "Check_AfterSummon",		everytime );
	proxy:LuaCall( 4041, 2, "Check_AfterSummon",		everytime );
	proxy:LuaCall( 4041, 3, "Check_AfterSummon",		everytime );

--��??���p�j�f�[�����̓o�ꁡ�n���h���o�^ --EN:--��??��Appearance of wandering daemon��Handler registration
	proxy:NotNetMessage_begin();
		--�v���C���[���\���Ŏ��S�������ɃL�b�N����܂��B --EN:--Kicked when a player dies solo.
		proxy:LuaCall( 4000, 100, "PlayerDeath_m04_02_00_00", everytime );
		--�v���C���[�������������ɃL�b�N����܂��B --EN:--Kicked when the player is revived.
		proxy:LuaCall( 4032, 100, "PlayerRevive_m04_02_00_00", everytime );
	proxy:NotNetMessage_end();
	
	proxy:AddFieldInsFilter( 828 );
	if proxy:IsCompleteEvent( 5380 ) ==false then
		proxy:OnCharacterDead(5380,828,"OnEvent_5380",once);
		--proxy:NotNetMessage_begin();
			--proxy:OnCharacterHP(5383,10000,"OnEvent_5383",0.0,once);
			--proxy:OnCharacterHP(5383,828,"OnEvent_5383_Npc",0.0,once);
		--proxy:NotNetMessage_end();
		proxy:LuaCall( 5380, 2, "OnEvent_5380", once );
		proxy:LuaCall( 5380, 3, "OnEvent_5380_Sfx",once);
	else
		proxy:InvalidSfx( 1989, false );
	end
	
	proxy:OnRegistFunc( 1080, "Condition_1080", "dummy", 2, everytime );
	
	
--[[
	--���p�j�f�[�����p (�t���O�͉��A�w�肪����Ες���) --EN:--��For wandering daemon (flag is tentative, change if specified)
	if proxy:IsCompleteEvent( 20 ) == true then
		LuaFunc_VisibleTheWanderingDemon  (proxy, param, demon_id_list_m04_02_00_00);
	else
		LuaFunc_InvisibleTheWanderingDemon(proxy, param, demon_id_list_m04_02_00_00);
	end
]]
--���{�X�֘A�̏��������� --EN:--�� Boss-related initialization processing
	if proxy:IsCompleteEvent( 5380 ) ==true then
		--���@�Ǐ����� --EN:--Magic wall disappears
		proxy:SetColiEnable( 1997 , false );
		proxy:SetDrawEnable( 1997 , false );
		--���@�ǂ�SFX OFF --EN:--Magic Wall SFX OFF
		proxy:InvalidSfx( 1989 , false );
		
------�A�C�e������֘A------------------ --EN:--Item Acquisition Related-------------------
	
		--�z�X�g�v���C���[�̂݃A�C�e������C�x���g�Ɏg�p --EN:--Used for item acquisition event only for host players
		local possible_chr_type = ATTR_HOST + ATTR_LIVE + ATTR_GREY;

		--���F���{�X�Ǐ��� --EN:--Yellow boss wall eraser
		proxy:InvalidSfx( 2440, false );
		
		--�󎀑�(�\�E��?)�L���� --EN:--Treasure corpse (soul?) activation
		proxy:SetDrawEnable( 1980 , true );
		proxy:SetColiEnable( 1980 , true );
		--�󎀑�(�\�E��?)�L���� --EN:--Treasure corpse (soul?) activation
		proxy:SetDrawEnable( 1977 , true );
		proxy:SetColiEnable( 1977 , true );
		
		--��(�\�E��)�A�C�e���擾�p�C�x���g�Ď��ǉ��� --EN:--�� (Soul) Added event monitoring for item acquisition��
		if proxy:IsCompleteEvent( 5381 ) == false then
			proxy:ValidSfx( 2400 );--SFX �L���� --EN:--SFX enable
			proxy:ValidSfx( 2401 );--SFX �L���� --EN:--SFX enable
			proxy:TreasureDispModeChange2( 1980 , true ,KANAME_SFX);--���点�� --EN:-- let it shine
			proxy:OnDistanceActionAttribute( 5381 , 10000 , 1980 , "OnEvent_5381" , WarpGimmickDist_A , 10010180 , 0 , 180 , possible_chr_type, once );
		else
			--���v�΂Ń��[�v�p�̊Ď���ǉ��� --EN:--�� Added surveillance for warp with keystone ��
			SingleReset(proxy,5382);
			--SFX ������ --EN:--Disable SFX
			proxy:InvalidSfx( 2400 , false );--�\�E���p --EN:--For Seoul
			--proxy:InvalidSfx( 2401 , false );--�{�X�A�C�e���p --EN:--For boss items
			proxy:TreasureDispModeChange2( 1980 , true ,KANAME_SFX);--���点�� --EN:-- let it shine
			proxy:OnDistanceActionAttribute( 5382 , 10000 , 1980 , "OnEvent_5382" , WarpGimmickDist_A , HELPID_GO_TO_SEKITYUU , 0 , 180 , ATTR_NOSESSION , everytime );
		end
		
--------------------------------------
		InvalidBackRead( proxy, 828 );
		--InvalidCharactor( proxy, 829 );

	else
		if	proxy:IsClient() == false then
			proxy:SetEventFlag( 1030, false );
			proxy:SetEventFlag( 1033, false );--�{�XBGM�AHP�A�t�@���l�� --EN:--Boss BGM, HP, Funnel
			proxy:SetEventFlag( 1090, false );
			proxy:SetEventFlag( 1100, false );
			
			proxy:SetEventFlag( 1081, false );
			proxy:RequestForceUpdateNetwork(828);
			proxy:OnRegionJustIn( 5456, LOCAL_PLAYER, 2430, "OnEvent_5456", once );
		end
		
		--�ϐg�|�����O --EN:--Before transformation poly drama
		if proxy:IsCompleteEvent( 1030 ) == false then
			--�����{�X�Ǐ��� --EN:--White boss wall eraser
			proxy:InvalidSfx( 1989, false );
		else
		--�ϐg�|������ --EN:--After transformation police play
			--���F���{�X�Ǐ��� --EN:--Yellow boss wall eraser
			proxy:InvalidSfx( 2440, false );
		end
		
		if	proxy:IsCompleteEvent( 1081 ) == false then
			InvalidCharactor( proxy, 828 );
		end
		
------�A�C�e������֘A------------------ --EN:--Item Acquisition Related-------------------
		--�󎀑�(�\�E��?) --EN:--Treasure Corpse (Soul?)
		proxy:SetDrawEnable( 1980 , false );
		proxy:SetColiEnable( 1980 , false );
		--�󎀑�(�\�E��?)2 --EN:--Treasure Corpse (Soul?) 2
		proxy:SetDrawEnable( 1977 , false );
		proxy:SetColiEnable( 1977 , false );
	
		--SFX ������ --EN:--Disable SFX
		proxy:InvalidSfx( 2400 , false );--�\�E���p --EN:--For Seoul
		proxy:InvalidSfx( 2401 , false );--�{�X�A�C�e���p --EN:--For boss items
----------------------------------------
	end
	
	--��5454���{�X�����C�x���g�o�^�z�M�p --EN:-- �� 5454 �� For boss room event registration distribution
	proxy:LuaCall( 5454, 2, "DoorRegist", everytime );
	
	--��5455�����������A�y�ъ֘A�n���h���o�^ --EN:-- �� 5455 �� Forced summons and related handler registration
	proxy:LuaCall( 5455, 2, "ForceSummonStart", everytime );
	--���������u���b�N�S�[�X�g���L�b�N�E�ޏo�E���S�ȊO�ł��Ȃ��Ȃ��� --EN:-- Forced Summon Black Ghost disappeared without kicking, exiting, or dying
	proxy:LuaCall( 4043, 4, "Check_LeavePlayer",	everytime );
	--���ӔC�ɑޏo --EN:--Exit irresponsibly
	proxy:LuaCall( 4043, 5, "Check_LeavePlayer2", 	everytime );
	
	--���������u���b�N�S�[�X�g���ޏo���� --EN:-- Forced Summon Black Ghost left
	proxy:LuaCall( 4046, 3, "Check_Leave", 			everytime );
	
	--��5457�������������ꂽ�L�������A�{�X��r������Q�������L�����ɑ΂��Ď������{�X���Ƌ����� --EN:-- �� 5457 �� A character who is forcibly summoned tells a character who participates in the middle of the boss battle that he is the boss.
	proxy:LuaCall( 5457, 3, "ForceSummonInfo", everytime );
	
	--��5458�����V����\�E���̖�A�������˗p(�z�X�g���L�b�N���ĊǗ����܂�) --EN:-- �� 5458 �� Floating soul arrows, for synchronous firing (host kicks and manages)
	proxy:CustomLuaCall( 5458, "FloatingSoulArrow", everytime );
		
	--��5459���z�X�g����SoulLv�����ē�����ʂ�t���܂��� --EN:--��5459��Get SoulLv from the host and add special effects��
	proxy:CustomLuaCall( 5459,"ForceSummon_Balance", everytime );
	
	proxy:NotNetMessage_begin();
		proxy:LuaCall( 5500,0,"ForceSummon_IsIn",everytime );
	proxy:NotNetMessage_end();
	
--��1030�����ϐg�|������	 --EN:-- �� 1030 �� Okina transformation poly drama ��
	SingleReset( proxy, 1031 );
	proxy:EnableInvincible( 823, true );--��̂�͐�΂Ɏ��ȂȂ��悤�ɂ��Ă��� --EN:--Make sure the guy above doesn't die
	if proxy:IsCompleteEvent( 1030 ) == false then
		--proxy:OnRegistFunc( 1030, "Condition_1030", "OnEvent_1030", 2, once);
		proxy:LuaCall( 1030, 2, "OnEvent_1030", everytime );
		--�|�����J�n�t�F�[�h��ɌĂ΂��n���h�� --EN:--Handler called after polyplay start fade
		proxy:LuaCall( 1030, REMO_START, "OnEvent_1030_RemoStart",once);
		--�|�����I����ɌĂ΂��n���h�� --EN:--Handler called after the polyplay ends
		proxy:LuaCall( 1030, REMO_FINISH, "OnEvent_1030_RemoFinish",once);
		
		InvalidCharactor( proxy, 828 );
		--InvalidCharactor( proxy, 829 );
	else
		if	proxy:IsCompleteEvent( 5380 ) == false then			
			DoorRegist(proxy,param);
		end
		InvalidCharactor( proxy, 823 );
	end

--��1033���{�XBGM�� --EN:--��1033��Boss BGM��
	if proxy:IsCompleteEvent( 5380 ) == false then
		if proxy:IsCompleteEvent( 1033 ) == false then
			if proxy:IsClient() == false then
				proxy:NotNetMessage_begin();
					proxy:OnRegionJustIn( 1033 , 10000 , 2410 , "OnEvent_1033",onve);
				proxy:NotNetMessage_end();
			end
			--�z�X�g���������҃v���C���[�Ɍ����ē�����ʂ�z�M --EN:--The host delivers special effects to forced summon players
			proxy:CustomLuaCall( 1033 , "OnEvent_1033_0",once );
			proxy:LuaCall( 1033 , 100 ,"OnEvent_1033_2",once );
			proxy:LuaCall( 1033 , 0 , "OnEvent_1033_1",once);
		end
	end
	
--��1051���|�����o��L������������ --EN:-- �� 1051 �� Disabling characters appearing in police dramas ��
	InvalidCharactor( proxy, 320 );
	proxy:SetEventFlag( 1051 , true );	
	
	
--��8086���S��ɗ����t���O�𗧂Ă遡 --EN:-- �� 8086 �� Raise a flag for coming to the prison ��
	proxy:SetEventFlag( 8086, true );
	
	--��999999���t���[���x��̏����������C�x���g�𔭍s�� --EN:-- �� 999999 �� Generate a frame delay initialization processing event ��
	proxy:NotNetMessage_begin();
		--��0�b�づ-- --EN:--��After 0 seconds��--
		proxy:OnKeyTime2( 999992, "Second_Initialize_m04_02_00_00", 0.0, 0, 0, once );	
	proxy:NotNetMessage_end();	
	
	print("Initialize_m04_02_00_00 end");
end


--------------------------------------------------------------------------------------
--Initialize����Ă΂��A1�t���[���x��̏�����������999999 --EN:--Initialization with a delay of 1 frame, called from Initialize ��999999
--------------------------------------------------------------------------------------
--��999999���ꕔ�AInit�ł͏����ł��Ȃ��̂ŁA�c���Ă��� --EN:-- �� 999999 �� Some parts cannot be processed by Init, so leave them
function Second_Initialize_m04_02_00_00(proxy, param)
	print("Second_Initialize_m04_02_00_00 begin");

--------------------------------������QWC�C�x���g�֘A������-------------------------------- --EN:--������QWC event related ������--------------------------------
--------------------------------������QWC�C�x���g�֘A������-------------------------------- --EN:--������QWC event related������--------------------------------

	print("Second_Initialize_m04_02_00_00 end");
end



--------------------------------------------------------------------------------------
--�p�j�f�[�����̓o�ꁡ?? --EN:-- Appearance of the Wandering Demon ??
--------------------------------------------------------------------------------------

--���O���[�o���̎��S�Ď�����Ă΂��(�\��) --EN:--�� Called from global death watch (solo)
function PlayerDeath_m04_02_00_00(proxy, param)
	print("PlayerDeath_m04_02_00_00");
	
--	LuaFunc_VisibleTheWanderingDemon(proxy, param, demon_id_list_m04_02_00_00);
--	proxy:SetEventFlag( 20 , 1 );--�t���O�͉��A�w�肪����Ες���B --EN:The -- flag is tentative, and will be changed if specified.
	
	print("PlayerDeath_m04_02_00_00");
end

--���O���[�o���̌�������������Ă΂��(�\��) --EN:--��Called from global blood letter revival (solo)
function PlayerRevive_m04_02_00_00(proxy,param)
	print("PlayerRevive_m04_02_00_00");
	
--	LuaFunc_InvisibleTheWanderingDemon(proxy, param, demon_id_list_m04_02_00_00);
--	proxy:SetEventFlag( 20 , 0 );--�t���O�͉��A�w�肪����Ες���B --EN:The -- flag is tentative, and will be changed if specified.
	
	print("PlayerRevive_m04_02_00_00");
end




--------------------------------------------------------------------------------------
--�{�X�����̒��ɓ��遡1031 --EN:--Enter the boss room 1031
--------------------------------------------------------------------------------------

--���C�x���g�����[�v�Ȃ̂ŁA�S�����s�[�g�ɂ��遫 --EN:--�� Since the event is a loop, repeat all ��

--��1031�����{�X�����ւ̔����J���� --EN:-- �� 1031 �� The door to the mid-boss room opens ��
function OnEvent_1031(proxy,param)
	print("OnEvent_1031 begin");
	
	if proxy:IsCompleteEvent( SYSTEM_ID_IGNORE ) == true then
		print("OnEvent_1031 end");
		return;
	end
	
	--�N���C�A���g�ցA�{�X�����j�~���s��ʒm --EN:--Notify client of failure to block boss room
	if proxy:IsClient() == false then
		proxy:LuaCallStart( 4068 , 1 );	
	end
	
	proxy:LuaCallStart( 1032, 1 );--����A�j���̓����Đ� --EN:-- Synchronous playback of turning animation
	--proxy:SetEventFlag( SYSTEM_ID_IGNORE, true );
	--���d�N���V�X�e��ID���^�C���A�E�g��ݒ肵��ON�ɂ��� --EN:--Turn on multiple activation system ID by setting timeout
	proxy:SetSystemIgnore( SYSTEM_ID_IGNORE , IGNORE_TIME );
	
	--�v���t�@�C���Z�[�u�v�� --EN:--profile save request
	proxy:SaveRequest_Profile();
	
	print("OnEvent_1031 end");
end


--����A�j���̓����Đ�(ID����) --EN:-- Synchronized playback of turning animation (ID is different)
function OnEvent_1032_1(proxy,param)
	print("OnEvent_1032_1 begin");

	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		if param:IsNetMessage() == true then
			--����A�j���Đ����s���A���̏I������OnEvent_1032_2�𔭍s���� --EN:--Play the turning animation and issue OnEvent_1032_2 at the end
			proxy:TurnCharactor( 10001 + param:GetPlayID(), 2889 );
		else
			proxy:LockSession();--���[�������b�N���܂��I --EN:--lock the room!
			--����A�j���Đ����s���A���̏I������OnEvent_1032_2�𔭍s���� --EN:--Play the turning animation and issue OnEvent_1032_2 at the end
			proxy:OnTurnCharactorEnd( 1032, 10000, 2889, "OnEvent_1032_2", once );
		end
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	
	print("OnEvent_1032_1 end");
end

--����A�j���̓����Đ��I���� --EN:--After synchronous playback of turning animation ends
function OnEvent_1032_2(proxy,param)
	print("OnEvent_1032_2 begin");

	--�����p�����A�j���Đ� --EN:--Play walking animation for synchronization
	proxy:LuaCallStart( 4012, 1 );
	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		proxy:OnChrAnimEnd( 1032, 10000, ANIMEID_WALK, "OnEvent_1032_3", once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	
	print("OnEvent_1032_2 end");
end

--�����A�j���̓����Đ��I���� --EN:--After the synchronized playback of the walking animation ends
function OnEvent_1032_3(proxy,param)
	print("OnEvent_1032_3 begin");

	--�ŏ��̐l���{�X�����̒��ɓ���I����Ă�����A���ɔz�M����Ă���͂��Ȃ̂ŁA����������Ȃ��n���h�� --EN:--If the first person has already entered the boss room, it should have already been delivered, so no more handlers
	if proxy:IsCompleteEvent( 1031 ) == false then
		proxy:LuaCallStart( 1032 , 5 );--2��ڈȍ~�Ƀ{�X�����ɓ��邽�߂̃C�x���g�z�M�p --EN:--For event delivery to enter the boss room after the second time
		proxy:LuaCallStart( 4045 , 1 );	--�N���C�A���g�ցA�{�X�����ɓ����悤�ɂȂ������Ƃ�ʒm --EN:--Notify clients that they can now enter the boss room
		--�h�[�s���O���� --EN:--doping synchronization
		proxy:LuaCallStart( 1032 , 7 );					
		proxy:LuaCallStart( 1032 , 6 );--�t���O�Z�b�g(�����p) --EN:--flag set (for synchronization)
		--���NPC�ɂ͊��ɐݒ肵�Ă��� --EN:-- Already set for alternative NPC
		Lua_MultiDoping(proxy,828);--�}���`�v���C�h�[�s���O --EN:-- Multiplayer Doping
	end

	--�v���C���[�����̒��Ɋ��S�ɂ͂������^�C�~���O�ŁA�{�X�̎v�l�����Z�b�g --EN:--Reset the boss' thoughts when the player is completely inside the door
	--�ꏊ�������ƃv���C���[��������Ȃ�����(�U�����Ă��Ȃ�) --EN:--Because you can't find the player if the location is bad (they won't attack)
	if proxy:IsClient() == false then
		proxy:ResetThink( 800 );
	end
	
	proxy:SetEventFlag( SYSTEM_ID_IGNORE, false );

	print("OnEvent_1032_3 end");
end


--��1031 2��ڈȍ~�Ƀ{�X�����ɓ��邽�߂̃C�x���g�z�M�p --EN:-- 1031 For event delivery to enter the boss room after the second time
function OnEvent_1031_GO_TO_IN(proxy, param)
	print("OnEvent_1031_GO_TO_IN begin");

	proxy:NotNetMessage_begin();
		--��1032�������J���Ă���Ƃ��ɒ��ɓ��邽�߂̃C�x���g��ǉ���--�n���h���� OnEvent_1031 --EN:--��1032��Add an event to enter inside when the door is open��--The handler is OnEvent_1031
		proxy:OnPlayerActionInRegion( 1032, 2893, "OnEvent_1031", HELPID_GO_TO_IN, everytime );--
	proxy:NotNetMessage_end();	

	print("OnEvent_1031_GO_TO_IN end");
end


--��1031 �t���O�Z�b�g(�����p) --EN:-- 1031 Flag set (for synchronization)
function OnEvent_1031_flag_set(proxy, param)
	print("OnEvent_1031_flag_set begin");
		
	proxy:SetEventFlag( 1031 , 1 );
	proxy:DeleteEvent( 1031 );

	print("OnEvent_1031_flag_set end");
end

--��1031���������җp�h�[�s���O������ --EN:-- �� 1031 �� doping sync for forced summons ��
function OnEvent_1031_Doping(proxy,param)
	print("OnEvent_1031_Doping begin");
	if proxy:GetLocalPlayerId() == ForceSummonBlack_PlayerNo then		
		Lua_MultiDopingm04_02(proxy,10001 + ForceSummonBlack_PlayerNo);		
	end
	print("OnEvent_1031_Doping end");
end

--�����A�j���Đ��ゾ�ƁA���ɑ����������Ƀv���C�̈�ID���ς��Ȃ���Ԃ� --EN:-- After playing the walking animation, the play area ID does not change because the foot does not touch the floor.
--�����������Ă��܂��A�������������u���b�N���{�X�����ȊO�� --EN:--Forcibly summoned, Black who is forcibly summoned is outside the boss room
--�~�j�u���b�N�̓�����o�Ă��邱�ƂɂȂ�̂ŁA�^�C�~���O�����炵�܂��B --EN:--Since it will come out from the head of the mini block, the timing is shifted.
function OnEvent_1032_4(proxy,param)
	print("OnEvent_1032_4 begin");
	proxy:SummonBlackRequest(4271);
	print("OnEvent_1032_4 end");
end



function ForceSummon_IsIn(proxy,param)
	print("ForceSummon_IsIn begin");
	proxy:EraseEventSpecialEffect_2( 10000 , 4006 );
	proxy:SetEventSpecialEffect_2( 10000 , 4006 );
	proxy:LuaCallStartPlus( 1065, 5, 828 );--SynchroInvalid_1065_ForBlack	
	print("ForceSummon_IsIn end");
end

----------------------------------------------------------------------------------------------------------------
--���{�X�|���� --EN:-- Bospoli play
----------------------------------------------------------------------------------------------------------------
function OnEvent_1030(proxy,param)	
	if proxy:IsCompleteEvent( 1030 ) == true then
		return;
	end
	print("OnEvent_1030 begin");
	
	proxy:RequestRemo(40201, REMO_FLAG, 1030, 1 );
	proxy:SetEventFlag( 1030, true );
	
	print("OnEvent_1030 end");
end


--���|�����Đ��J�n(�t�F�[�h�I��) --EN:--�� Start of polyplay playback (end of fade)
function OnEvent_1030_RemoStart(proxy,param)
	print("OnEvent_1030_RemoStart begin");
	proxy:InvalidSfx( 2441, false );--�|�����Ɏז���Sfx������ --EN:--Erase Sfx that interferes with the polyplay
	proxy:InvalidSfx( 2440, false );--���F�ǂ����� --EN:--Erase the yellow wall
	print("OnEvent_1030_RemoStart end");
end

--���|�����Đ��I��(�t�F�[�h�I��) --EN:-- End of polyplay playback (end of fade)
function OnEvent_1030_RemoFinish(proxy,param)
	print("OnEvent_1030_RemoFinish begin");
	proxy:ValidSfx( 2441 );--�|�����ɓs�����������������Ȃ̂�Sfx��߂� --EN:--Sfx is returned because it was just inconvenient for the polyplay
	proxy:ValidSfx( 1989 );--���ǂ�L���ɂ��� --EN:--Enable white wall
	
--[[
	InvalidCharactor( proxy, 823 );
	ValidCharactor( proxy, 828 );
	proxy:Warp( 828, 2420 );
	ValidCharactor( proxy, 829 );
]]
	--�{�X�����C�x���g�ǉ� --EN:--Boss room event added
	if proxy:IsClient() == false then
		proxy:LuaCallStart( 5454, 2 );
	end
	
	--if proxy:GetLocalPlayerId() == ForceSummonBlack_PlayerNo then
	if	proxy:GetTempSummonParam() > 0 then
		print("���������u���b�N�v���C���[�ł�"); --EN:print("I am a forced black player");
		proxy:EraseEventSpecialEffect_2( 10000 , 4006 );
		proxy:SetEventSpecialEffect_2( 10000 , 4006 );
		proxy:LuaCallStartPlus( 1065, 5, 828 );--SynchroInvalid_1065_ForBlack
	end
	
	--proxy:PlayPointSE( 2410, SOUND_TYPE_M, 40200000, 2 );
	proxy:LuaCallStartPlus( 1065, 4, 823 );--SynchroInvalid_1065
	--proxy:LuaCallStartPlus( 1065, 3, 828 );--SynchroValid_NoAnim_1065
	--proxy:LuaCallStartPlus( 1065, 2420, 828 );--SynchroWarp_1065
	--proxy:LuaCallStartPlus( 1065, 3, 829 );--SynchroValid_NoAnim_1065
	
	print("OnEvent_1030_RemoFinish end");
end





function OnEvent_5383(proxy,param)
	if proxy:GetLocalPlayerId() == ForceSummonBlack_PlayerNo then
		print("OnEvent_5383 begin");
		proxy:NotNetMessage_begin();
			proxy:OnKeyTime2( 5383 , "OnEvent_5383_wait",1.0,0,0,once);
		proxy:NotNetMessage_end();		
		print("OnEvent_5383 end");
	end
end

function OnEvent_5383_Npc(proxy,param)
	print("OnEvent_5383_Npc begin");
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 5383 , "OnEvent_5383_wait",0.5,0,0,once);
	proxy:NotNetMessage_end();
	print("OnEvent_5383_Npc begin");
end

function OnEvent_5383_wait(proxy,param)
	print("OnEvent_5383_wait begin");
	--proxy:LuaCallStart( 5380, 3 );
	print("OnEvent_5383_wait end");
end

--[[------------------------------------------------------------------------------------
--��5380���{�X���S�� --EN:-- �� 5380 �� Boss death ��
--------------------------------------------------------------------------------------]]
--��5380���{�X���S�� --EN:-- �� 5380 �� Boss death ��
function OnEvent_5380(proxy,param)
	print("OnEvent_5380 begin");
		
	if proxy:IsClient() == false and proxy:IsCompleteEvent(5383) == false then
		proxy:LuaCallStart( 5380, 3 );
	end

	proxy:NotNetMessage_begin();
		--1�b��ɕ����ǔ����C�x���g�𔭍s-- --EN:-- Issue a wall trigger event that collapses after 1 second --
		proxy:OnKeyTime2(5380,"OnEvent_5380_1", 1,0,0,once);
		--�}���`���U�Ď� --EN:--Multi-Dismissal Monitoring
		proxy:OnRegistFunc( 5380 , "Check_5380_PT","OnEvent_5380_PT",0,once);
	proxy:NotNetMessage_end();

	--�t�@���l���I�� --EN:--Funnel end
	proxy:DeleteEvent( 5458 );
	
	proxy:SetEventFlag( 5380, true );
	
	--�{�X��p��BGM��~ --EN:--BGM stop for boss battles
	proxy:StopPointSE( 2 );
	--�u���b�N�N���A������ --EN:-- to block clear processing
	proxy:CustomLuaCallStart( 4050, 828 );
	
	--�g�J�Q�C�x���g���Z�b�g --EN:-- lizard event reset
	ResetTokage(proxy);
	
	--[[
	--����3�J���C���t�H���[�V���� --EN:--Castle 3 opening information
	if proxy:IsClient() == false then
		if proxy:IsCompleteEvent( 8050 ) == false then
			proxy:NotNetMessage_begin();
				proxy:OnKeyTime2( 8050 , "OnEvent_8050",5.0,0,0,once);
				proxy:SetEventFlag( 8050 , true );
			proxy:NotNetMessage_end();
		end
	end
	]]
	
	--�z�X�g���L�����@or�@�V���O�� --EN:--Host's own character or single
	if proxy:IsClient() == false then	
		proxy:SetEventFlag(	8012, 1 );--�N���A�t���OON --EN:--Clear flag ON
	end
	
	print("OnEvent_5380 end");
end

--PC���E�QSFX --EN:--PC black killing SFX
function OnEvent_5380_Sfx(proxy,param)
	print("OnEvent_5380_Sfx begin");
	local BossId = -1;
	if	ForceSummonBlack_PlayerNo == -1 then
		BossId = 828;
	else
		BossId = 10001 + ForceSummonBlack_PlayerNo;
	end	
	print("BossId :",BossId);
	--proxy:CreateSfx_DummyPoly( BossId, 50 , 16034 );
	proxy:CreateSfx_DummyPoly( BossId, 91 , 16034 );
	proxy:SetEventFlag( 5383 , true );
	print("OnEvent_5380_Sfx end");
end

function OnEvent_5380_1(proxy,param)
	print("OnEvent_5380_1 begin");

	--�{�X��|���������X�V(���ɂ���ăt���O�𗧂Ă�) --EN:--update number of bosses killed (flag by number)
	GetBossFlagCount( proxy, param );

--�A�C�e������֘A------- --EN:--Item Acquisition Related-------
	
	--�z�X�g�v���C���[�̂݃A�C�e������C�x���g�Ɏg�p --EN:--Used for item acquisition event only for host players
	local possible_chr_type = ATTR_HOST + ATTR_LIVE + ATTR_GREY;

	--�󎀑�(�\�E��?)�L���� --EN:--Treasure corpse (soul?) activation
	proxy:SetDrawEnable( 1980 , true );
	proxy:SetColiEnable( 1980 , true );
	--�󎀑�(�\�E��?)2�L���� --EN:--Treasure corpse (soul?) 2 enabled
	proxy:SetDrawEnable( 1977 , true );
	proxy:SetColiEnable( 1977 , true );
	
	--��(�\�E��)�A�C�e���擾�p�C�x���g�Ď��ǉ��� --EN:--�� (Soul) Added event monitoring for item acquisition��
	if proxy:IsCompleteEvent( 5381 ) == false then
		proxy:ValidSfx( 2400 );--SFX �L���� --EN:--SFX enable
		proxy:ValidSfx( 2401 );--SFX �L���� --EN:--SFX enable
		proxy:TreasureDispModeChange2( 1980, true ,KANAME_SFX);--���点�� --EN:-- let it shine
		proxy:OnDistanceActionAttribute( 5381 , 10000 , 1980, "OnEvent_5381" , WarpGimmickDist_A , 10010180 , 0 , 180 , possible_chr_type, once );
	end
------------------------]]
	
	--���g���t�B�[�擾���聥 --EN:--��Trophy Acquisition Judgment��
	Lua_RequestUnlockTrophy(proxy, 8);	
	
	print("OnEvent_5380_1 end");
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


--�}���`���U�Ď� --EN:--Multi-Dismissal Monitoring
function Check_5380_PT(proxy)
	if proxy:IsInParty() == false then
		return true;
	end
	return false;
end

--�}���`����Ȃ� --EN:--not multiplayer
function OnEvent_5380_PT(proxy,param)
	print("OnEvent_5380_PT begin");
	
	proxy:InvalidSfx( 1989, true );
	
	--���{�X�����̖��@�ǂ�������(�S�v���C���[)	 --EN:--The magic wall in the mid-boss room disappears (all players)
	proxy:SetColiEnable( 1997 , false );	
	proxy:SetDrawEnable( 1997 , false );
	
	--���{�X�����O�̈ړ������C�x���g���폜 --EN:--Delete the movement processing event in front of the mid-boss room
	proxy:DeleteEvent( 1031 );--��l�ڂ�����Ƃ��p --EN:--For when the first person enters
	proxy:DeleteEvent( 1032 );--��l�ڈȍ~������Ƃ��p --EN:--For when the second and subsequent people enter
	print("OnEvent_5380_PT end");
end

--------------------------------------------------------------------------------------
--��5381���\�E�����聡 --EN:-- �� 5381 �� Get Soul ��
--------------------------------------------------------------------------------------
--��5381���\�E�����聡 --EN:-- �� 5381 �� Get Soul ��
function OnEvent_5381(proxy,param)
	print("OnEvent_5381 begin");
	--�v���C���[�̓����A�j���[�V����(true:�p�[�e�B�[�v���C���[���A�j���[�V��������) --EN:--Player synchronous animation (true: party player animated)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_PICK ) == true then--�V�����A�j��  --EN:-- new anime
		print("OnEvent_5381 end");
		return true;
	end
	
	proxy:NotNetMessage_begin();
		--0.0�b��ɃA�C�e���擾�C�x���g�𔭍s --EN:-- Issue an item acquisition event after 0.0 seconds
		proxy:OnKeyTime2( 5381, "OnEvent_5381_1", 0.0, 0, 0, once );
	proxy:NotNetMessage_end();
	print("OnEvent_5381 end");
end



--��5381_1���A�C�e���擾�� --EN:-- �� 5381_1 �� item acquisition ��
function OnEvent_5381_1(proxy, param)
	print("OnEvent_5381_1 begin");

	--�A�C�e���擾�֐�--�p�����[�^10552�Q�� --EN:--item retrieval function--see parameter 10552
	proxy:GetRateItem(10552);
	--�A�C�e���擾�֐�--�p�����[�^10578�Q�� --EN:--item retrieval function--see parameter 10578
	proxy:GetRateItem(10578);
	--�A�C�e���擾�֐�--�p�����[�^10579�Q�� --EN:--item retrieval function--see parameter 10579
	proxy:GetRateItem(10579);
	--�A�C�e���擾�֐�--�p�����[�^10580�Q�� --EN:--item retrieval function--see parameter 10580
	proxy:GetRateItem(10580);
	--�A�C�e���擾�֐�--�p�����[�^10581�Q�� --EN:--item retrieval function--see parameter 10581
	proxy:GetRateItem(10581);
	
	--�A�C�e�����擾�ς� --EN:--item already acquired
	proxy:SetEventFlag( 5381, 1 );
	
	--SFX�������� --EN:--SFX disappear
	proxy:InvalidSfx( 2400 , true );

	if proxy:IsCompleteEvent( 8035 ) == false then
		proxy:NotNetMessage_begin();
			--�u�Ԃŕ\������ƃ��j���[����ɏo��̂ő҂� --EN:--If you display it instantly, the menu will appear first, so wait
			proxy:OnKeyTime2( 8035 , "OnEvent_8035_wait",0.5 , 0 , 1, once);			
		proxy:NotNetMessage_end();
	else
		--���v�΂Ń��[�v�p�̊Ď���ǉ��� --EN:--�� Added surveillance for warp with keystone ��
		proxy:OnDistanceActionAttribute( 5382 , 10000 , 1980 , "OnEvent_5382" , WarpGimmickDist_A , HELPID_GO_TO_SEKITYUU , 0 , 180 , ATTR_NOSESSION , everytime );
	end	
	
	print("OnEvent_5381_1 end");
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
		OnEvent_8050(proxy,param)
		proxy:SetEventFlag( 8035 , true );
	proxy:NotNetMessage_end();
	--���v�΂Ń��[�v�p�̊Ď���ǉ���	 --EN:--�� Added surveillance for warp with keystone ��
	proxy:OnDistanceActionAttribute( 5382 , 10000 , 1980 , "OnEvent_5382" , WarpGimmickDist_A , HELPID_GO_TO_SEKITYUU , 0 , 180 , ATTR_NOSESSION , everytime );
	print("OnEvent_8035 end");
end


--------------------------------------------------------------------------------------
--��5382���Β��Ƀ��[�v�� --EN:-- �� 5382 �� Warp to the stone pillar ��
--------------------------------------------------------------------------------------
function OnEvent_5382(proxy,param)
	print("OnEvent_5382 begin");
	
	proxy:RepeatMessage_begin();
		--��70_1���I�����j���[�̊Ď��� --EN:--��70_1��Select menu monitoring��
		proxy:OnSelectMenu(5382, "OnEvent_5382_1", 10010710, 0, 2, 1980, 2, once);
	proxy:RepeatMessage_end();
	
	print("OnEvent_5382 end");
end

--��5382_1���I�����j���[�̊Ď��� --EN:--��5382_1��Monitor selection menu��
function OnEvent_5382_1(proxy,param)	
	print("OnEvent_5382_1 begin");
	
	if proxy:IsSession() == false then
		
		if param:IsNetMessage() == true then
			proxy:PlayAnimation(10001+param:GetPlayID(),8283);
			print("OnEvent_5382_1 end");
			return;
		end
			
		proxy:PlayAnimation(10000,8283);
		proxy:NoAnimeTurnCharactor( 10000 , 1980 ,TURNSKIP_ANGLE);
		
		proxy:NotNetMessage_begin();
		proxy:RepeatMessage_begin();
			proxy:OnChrAnimEnd( 5382 , 10000 , 8283 , "OnEvent_5382_2",once);
		proxy:RepeatMessage_end();
		proxy:NotNetMessage_end();
		
		proxy:SetEventFlag(5382,true);
	else
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010720, 0, 6, 1983, GEN_DIALOG_DIST, once );
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
	end
	
	print("OnEvent_5382_1 end");
end

--��5382_2���Β��Ƀ��[�v�� --EN:--�� 5382_2 �� Warp to the stone pillar ��
function OnEvent_5382_2(proxy,param)	
	print("OnEvent_5382_2 begin");

	proxy:PlayAnimation( 10000 , 8284 );--�����E�ɋA��A�j�����Đ� --EN:--Play animation to return to your own world
	
	--�Β��֖߂��Ă�������̃t���O�𗧂Ă� --EN:--Flag the judgment of returning to the stone pillar
	proxy:SetEventFlag(8083, true);
	
	--���S�񕜗v�� --EN:-- full recovery request
	proxy:RequestFullRecover();
	--�Íԗv�΂ɖ߂� --EN:--Return to Old Fort Keystone
	proxy:WarpNextStage( 1, 0, 0, 0, 1008);	
	print("OnEvent_5382_2 end");
end

------------------------------------------------------------------------------

function Condition_1080(proxy,param)
	if	proxy:GetBlockId() == 2 then
		if	proxy:GetPartyRestrictNum() ~= 3 then
			proxy:SetPartyRestrictNum(3);
			print("Condition_1080 set RestrictNum 3");
		end
	else
		if	proxy:GetPartyRestrictNum() ~= 4 then
			proxy:SetPartyRestrictNum(4);
			print("Condition_1080 set RestrictNum 4");
		end
	end
	return false;
end


function OnEvent_1090(proxy,param)
	print("OnEvent_1090 begin");
	proxy:NotNetMessage_begin();
		if	proxy:IsOnline() == true then
			proxy:LuaCallStartPlus( 1065, 4271, 828 );
		else
			proxy:LuaCallStartPlus( 1065, 4271, 828 );
		end
		proxy:LuaCallStartPlus( 1065, 2, 828 );--SynchroValid_1065
		proxy:SetEventFlag( 1081, true );--NPC���������ꂽ�`�F�b�N --EN:--Check if NPC is summoned
		proxy:SetEventFlag( 1090, true );
		
		--�^�C���A�E�g�����̂ŁA�|�����̗���� --EN:--It's timed out, so let's go to the flow of the police play
		--�|�����Đ� --EN:--Poly play
		proxy:LuaCallStart( 1030, 2 );
	proxy:NotNetMessage_end();
	print("OnEvent_1090 end");
end

function OnEvent_1081(proxy,param)
	print("OnEvent_1081 begin");
	proxy:SetEventFlag( 1100, true );
	print("OnEvent_1081 end");
end


--�{�X�����ɓ����Ă���A�z�X�g�ŋ��������̓x�ɌĂ΂�� --EN:--After entering the boss room, called every time the host summons
function Check_Summon(proxy,param)
	print("Check_Summon begin");

	--�����������ꂽ�v���C����ID���o���Ă��� --EN:-- Remember the ID of the forced summoned player
	ForceSummonBlack_PlayerNo = param:GetPlayID();
	
	--�z�M�������������u���b�N�Ȃ̂ŁA�����Ńz�X�g�Ƌ敪�� --EN:--Since the distribution source is forced summoning black, it is separated from the host here
	if	proxy:IsClient() == false then
		if	proxy:IsCompleteEvent( 1090 ) == false then
			proxy:DeleteEvent( 1090 );
			proxy:SetEventFlag( 1090, true );			
			--�|�����Đ� --EN:--Poly play
			--proxy:LuaCallStart( 1030, 2 );
		end
	end
	
	if proxy:GetLocalPlayerId() == ForceSummonBlack_PlayerNo then
		print("���������u���b�N�v���C���[�ł�"); --EN:print("I am a forced black player");
		IsForceSummon = true;
		--proxy:EraseEventSpecialEffect_2( 10000 , 4005 );
		--proxy:SetEventSpecialEffect_2( 10000 , 4006 );
		--proxy:LuaCallStartPlus( 1065, 5, 828 );--SynchroInvalid_1065_ForBlack
	else		
		if proxy:IsClient() == false then
			print("���̓z�X�g�v���C���[�ł� SoulLv:",proxy:GetLocalPlayerSoulLv()); --EN:print("I am the host player SoulLv:",proxy:GetLocalPlayerSoulLv());
			proxy:CustomLuaCallStart( 5459 , proxy:GetLocalPlayerSoulLv() );
			--�l�b�g���[�N�̃��b�N --EN:--network lock
			--proxy:LockSession();
		end
	end
	
	--�{�X�Q�[�W�\�� --EN:-- Boss gauge display
	--proxy:SetBossGauge( 10001 + param:GetPlayID() , 0 ,6030 );
	
	print("Check_Summon end");
end

--�z�X�g����\�E��Lv��������ē�����ʂ�t���� --EN:--Receive soul Lv from the host and add special effects
function ForceSummon_Balance(proxy,param)
	--��������̂͋������҃S�[�X�g������OK�Ȕ��Ȃ̂ŁE�E�E --EN:--Since it should be OK to process only forced summon ghosts...
	if proxy:GetLocalPlayerId() == ForceSummonBlack_PlayerNo then
		print("ForceSummon_Balance begin");
		local hostSoulLv = param:GetParam2();
		local forceSoulLv = proxy:GetLocalPlayerSoulLv();
		--�ǂ�����\�E��Lv��0����Ȃ��Ȃ� --EN:--If neither Soul Lv is 0
		if hostSoulLv > 0 or forceSoulLv > 0 then
			print("hostSoulLv :",hostSoulLv,"forceSoulLv :",forceSoulLv);
			local LvRate = forceSoulLv - hostSoulLv;
			if LvRate <= 5 and LvRate >= 1 then
				print("Lv�� +5�`+1"); --EN:print("Lv difference +5+1");
				proxy:SetEventSpecialEffect_2( 10000 , 5045 );
			elseif LvRate <= 0 and LvRate >= -5 then
			--���x���{0�`�|5�@�@�@�@�@5046 --EN:--Level +0 to -5 5046
				print("Lv�� +0�`-5"); --EN:print("Level difference +0 to -5");
				proxy:SetEventSpecialEffect_2( 10000 , 5046 );
			elseif LvRate <= -6 and LvRate >= -10 then
			--���x���|6�`�|10�@�@�@�@5047 --EN:--Level -6 to -10 5047
				print("Lv�� -6�`-10"); --EN:print("Level difference -6 to -10");
				proxy:SetEventSpecialEffect_2( 10000 , 5047 );
			elseif LvRate <= -11 then
			--���x���|11�`�@�@�@�@�@�@ 5048 --EN:--Level -11~ 5048
				print("Lv�� -11�`"); --EN:print("Lv difference -11");
				proxy:SetEventSpecialEffect_2( 10000 , 5048 );
			else
				proxy:WARN("Lv�}�b�`���O������ł͂Ȃ��\��������܂��I"); --EN:proxy:WARN("Lv matching may not be normal!");
			end
		end		
		print("ForceSummon_Balance end");
	end
end


--�{�X�����ɓ����Ă���A�z�X�g�Ńu���b�N�S�[�X�g���S�̓x�ɌĂ΂�� --EN:--After entering the boss room, called every time the black ghost dies in the host
function Check_BlackDead(proxy,param)
	print("Check_BlackDead begin");
	--�{�X���S�C�x���g���s --EN:-- Issue boss death event
	proxy:LuaCallStart( 5380, 2 );	
	print("Check_BlackDead end");
end

--�{�X�����ɓ����Ă���A�z�X�g�Ńu���b�N�S�[�X�g��������̓x�ɌĂ΂�� --EN:--After entering the boss room, called every time the black ghost line is lost at the host
function Check_LeavePlayer(proxy,param)
	print("Check_LeavePlayer begin");
	--���������u���b�N�����ɂ��Ȃ���� --EN:--If there is no forced summon Black already
	if	ForceSummonBlack_PlayerNo < 0 then
		print("Check_LeavePlayer return end")
		return;
	end
	if proxy:IsBlackGhost() == true then
		print("Check_LeavePlayer return end")
		return;
	end
	--�ޏo�����l�Ƌ������҃u���b�N��PlayerNo����v���� --EN:--The player number of the person who left and the forced summon black match
	if param:GetParam3() == ForceSummonBlack_PlayerNo then
		print("switch_npc Success!");
		switch_npc(proxy,param);
	else
		print("switch_npc Failed!");
	end
	print("Check_LeavePlayer end");
end

--�{�X�����ɓ����Ă��疳�ӔC�ޏo�����l�����邽�тɌĂ΂�� --EN:--Called every time someone left the boss room irresponsibly
function Check_LeavePlayer2(proxy,param)
	print("Check_LeavePlayer2 begin");
	--���������u���b�N�����ɂ��Ȃ���� --EN:--If there is no forced summon Black already
	if	ForceSummonBlack_PlayerNo < 0 then
		print("Check_LeavePlayer2 return end")
		return;
	end
	
	if proxy:IsBlackGhost() == true then
		print("Check_LeavePlayer return end")
		return;
	end
	
	--�ޏo�����l�Ƌ������҃u���b�N��PlayerNo����v���� --EN:--The player number of the person who left and the forced summon black match
	if param:GetParam3() == ForceSummonBlack_PlayerNo then
		print("switch_npc Success!");
		switch_npc(proxy,param);
	else
		print("switch_npc Failed!");
	end
	print("Check_LeavePlayer2 end");
end

--�{�X�����ɓ����Ă���A�z�X�g�Ńu���b�N�S�[�X�g�ޏo�̓x�ɌĂ΂�� --EN:--After entering the boss room, called every time the black ghost leaves the host
function Check_Leave(proxy,param)
	print("Check_Leave begin");
	--���������u���b�N�����ɂ��Ȃ���� --EN:--If there is no forced summon Black already
	if	ForceSummonBlack_PlayerNo < 0 then
		print("Check_Leave return end")
		return;
	end
	
	if proxy:IsBlackGhost() == true then
		print("Check_LeavePlayer return end")
		return;
	end
	
	switch_npc(proxy,param);
	print("Check_Leave end");
end

--PC�������Ă��������ɁA�����NPC���o�������鏈�� --EN:--Processing to make NPC appear instead when PC leaves
function switch_npc(proxy,param)
	--�܂��{�X��|���ĂȂ��̂ŁI --EN:--Because I haven't beaten the boss yet!
	if proxy:IsCompleteEvent( 5380 ) ==false then
	
		local npc_dead_list	 = {1100};--�ǉ�����NPC�u���b�N�̎��S�Ď��A�N�V����ID���X�g --EN:--Additional NPC Black death watch action ID list
		local npc_black_list = {1081};--�o�����Ă���NPC�u���b�N�̃`�F�b�N���X�g --EN:--Spawning NPC Black checklist
		local npc_evid_list  = { 828};--�o������NPC�̃C�x���gID���X�g --EN:--Event ID list of appearing NPCs
	
		proxy:LuaCallStartPlus( 1065, 2420, 828 );
		proxy:LuaCallStartPlus( 1065, 2, 828 );--SynchroValid_1065
	
		--���������u���b�N�����Ȃ��Ȃ�̂ŏ����� --EN:--Initialize because forced summon black disappears
		ForceSummonBlack_PlayerNo = -1;
		
		proxy:SetBossGauge( 828 , 0 ,6030 );
		
		--�l�b�g���[�N�̃��b�N --EN:--network lock
		--proxy:LockSession();
	
		print("switch_npc index = ", index);
	end
end





function SynchroValid_1065( proxy,param)
	print("SynchroValid_1065 begin");
	local chrId = param:GetParam3();
	print( "Valid to ", chrId );
	
	--(2008.08.17 17:13 hk-itoyuta)
	--���ʂȓo�^�𑝂₵�����Ȃ������̂ň�悸�����Ő؂�ւ� --EN:--I didn't want to increase unnecessary registrations, so I switched here for the time being
	--���������������Ȃ�1��LuaCall��؂��āA�����ł܂Ƃ߂� --EN:--If the amount of processing seems to increase, cut off one LuaCall and put it together there
	--if	chrId == 828 then
		--�{�X�Q�[�W�������Ă��� --EN:--Clear the boss gauge
		--proxy:ClearBossGauge();
		
		--�{�X�Q�[�W�\�� --EN:-- Boss gauge display
		--proxy:SetBossGauge( chrId , 0 ,6030 );
	--end
	if proxy:IsBlackGhost() == false then
		ValidCharactor( proxy , chrId );--�L�����N�^�L����	 --EN:--Character enable
		proxy:PlayAnimation( chrId, 6100 );
	end
	print("SynchroValid_1065 end");
end

function SynchroValid_NoAnim_1065( proxy,param)
	print("SynchroValid_NoAnim_1065 begin");
	print( "Valid to ",param:GetParam3() );
	if proxy:IsBlackGhost() == false then
		ValidCharactor( proxy , param:GetParam3() );--�L�����N�^�L����	 --EN:--Character enable
	end
	print("SynchroValid_NoAnim_1065 end");
end

function SynchroInvalid_1065( proxy,param)
	print("SynchroInvalid_1065 begin");
	print( "Invalid to ",param:GetParam3() );
	InvalidCharactor( proxy , param:GetParam3() );--�L�����N�^������	 --EN:--disable character
	print("SynchroInvalid_1065 end");
end

function SynchroInvalid_1065_ForBlack( proxy,param )
	print("SynchroInvalid_1065_ForBlack begin");
	print( "Invalid to ",param:GetParam3() );
	InvalidCharactor( proxy , param:GetParam3() );--�L�����N�^������ --EN:--disable character
	--�����������ꂽ�v���C����ID���o���Ă��� --EN:-- Remember the ID of the forced summoned player
	ForceSummonBlack_PlayerNo = param:GetPlayID();
	print("SynchroInvalid_1065_ForBlack end");
end

function SynchroWarp_1065(proxy,param)
	print("SynchroWarp_1065  Chr is <",param:GetParam3(),">   Warp to <", param:GetParam2(),">");
	proxy:Warp( param:GetParam3(), param:GetParam2() );
end

--�{�X�����C�x���g�o�^ --EN:--Boss room event registration
--Call(5454, 2)
function DoorRegist(proxy,param)
	print("DoorRegist begin");
		--�\���̂Ƃ��͈�x�ڂɃ{�X�����ɓ���p�̃C�x���g�𖈉�o�^���������̂ŁA�Ή�����t���O��OFF�ɂ���B --EN:-- When soloing, we want to register the event for entering the boss room for the first time every time, so turn off the corresponding flag.
		SingleReset(proxy, 1031);
	
		--�������A�j���Đ��p�̊J�n�n���h��(���񁨕���) --EN:--�� Start handler for synchronous animation playback (turning �� walking)
		proxy:LuaCall( 1032, 1, "OnEvent_1032_1", everytime );
		
		--��2��ڈȍ~�Ƀ{�X�����ɓ��邽�߂̃C�x���g�z�M�p --EN:--��For event delivery to enter the boss room after the second time
		proxy:LuaCall( 1032 , 5 , "OnEvent_1031_GO_TO_IN" , everytime );
		
		--���t���O�Z�b�g(�����p) --EN:--��flag set (for synchronization)
		proxy:LuaCall( 1032 , 6 , "OnEvent_1031_flag_set" , everytime );
		
		--���������҃h�[�s���O�p --EN:--�� For forced summon doping
		proxy:LuaCall( 1032 , 7 , "OnEvent_1031_Doping" , everytime );
		
		--�N�����{�X�O�����܂��ʉ߂��Ă��Ȃ� --EN:--Someone hasn't passed through the boss front door yet
		if proxy:IsCompleteEvent( 1031 ) == false then
		
			--(�Z�b�V��������)�{�X�O�̖��@�ǂ��ŏ��ɒʂ��̂͐����̐l���� --EN:--(During the session) Only survivors can pass through the magic wall in front of the boss first
			local possible_chr_type = ATTR_HOST + ATTR_LIVE + ATTR_GREY;
			
			proxy:NotNetMessage_begin();
				--��1031�������J���Ă���Ƃ��ɒ��ɓ��邽�߂̃C�x���g��ǉ��� --EN:--��1031��Add an event to enter when the door is open��
				proxy:OnPlayerActionInRegionAttribute( 1031, 2893, "OnEvent_1031", HELPID_GO_TO_IN, possible_chr_type, everytime );
			proxy:NotNetMessage_end();
		
		else --�O���C�S�[�X�g�ł����Ƃ��悤�ɂ���Ǝv����B --EN:--Gray ghost seems to be like that when it's done.
		
			proxy:NotNetMessage_begin();
				--��1032�������J���Ă���Ƃ��ɒ��ɓ��邽�߂̃C�x���g��ǉ��� --EN:--��1032��Add an event to enter when the door is open��
				proxy:OnPlayerActionInRegion( 1032, 2893, "OnEvent_1031", HELPID_GO_TO_IN, everytime );--�n���h���͏�Ɠ��� --EN:--handler is the same as above
			proxy:NotNetMessage_end();
		
		end
	print("DoorRegist end");
end


--���������A�y�ъ֘A�n���h���o�^ --EN:-- Forced summons and related handler registration
--Call(5455, 2)
function ForceSummonStart(proxy,param)
	print("ForceSummonStart begin");
		if	proxy:IsClient() == false then
			proxy:NotNetMessage_begin();
				--�r������I�����C���ɂȂ������Ƃ��l���āA�n���h�������͓o�^���Ă��� --EN:--Register only the handler, considering that it went online in the middle
				--���������u���b�N�S�[�X�g������ --EN:-- Forced Summon Black Ghost died
				proxy:LuaCall( 4042, 5, "Check_BlackDead",		everytime );		
				
				
				if	proxy:IsOnline() == true then
					proxy:OnKeyTime2( 1032, "OnEvent_1032_4", 2.0, 0, 4, once );
					proxy:OnKeyTime2( 1090, "OnEvent_1090", ForceSummonTimeOut, 0, 2, once );
				else
					proxy:OnKeyTime2( 1090, "OnEvent_1090",   0.0, 0, 2, once );
					--�|�����Đ� --EN:--Poly play
					proxy:LuaCallStart( 1030, 2 );
				end
			proxy:NotNetMessage_end();
		end
	print("ForceSummonStart end");
end


function OnEvent_5456(proxy,param)
	print("OnEvent_5456 begin");
	--���̎��_�ŃN���C�A���g�Ȃ�@�V���O�� --EN:--At this point, if the client is single
	if	proxy:IsClient() == false then
		--�L�����^�C�v������or�O���C�Ȃ狭�����҂��X�^�[�g --EN:--If the character type is survival or gray, start forced summoning
		if proxy:IsGreyGhost() == true or proxy:IsLivePlayer() == true then
			proxy:LuaCallStart( 5455, 2 );
		end
	end
	print("OnEvent_5456 end");
end

------------------------------------------------------------------------------------------------------------------
--��5457�������������ꂽ�L�������A�{�X��r������Q�������L�����ɑ΂��Ď������{�X���Ƌ����� --EN:-- �� 5457 �� A character who is forcibly summoned tells a character who participates in the middle of the boss battle that he is the boss.
------------------------------------------------------------------------------------------------------------------
--LuaCallParam(5457,3,�ʒm����Ώۂ�playerNo) --EN:--LuaCallParam(5457,3,playerNo to notify)
function ForceSummonInfo(proxy,param)
	print("ForceSummonInfo begin");
	--�������̃��b�Z�[�W���H --EN:--Is this a message for you?
	if	param:GetParam3() == proxy:GetLocalPlayerId() then
		--�{�X�Q�[�W�\�� --EN:-- Boss gauge display
		--proxy:SetBossGauge( 10001 + param:GetPlayID() , 0 ,6030 );
	end
	print("ForceSummonInfo end");
end


--LuaCallParam(4041,1or2or3)
function Check_AfterSummon(proxy,param)
	print("Check_AfterSummon begin");
	--�����������ꂽ�u���b�N���H --EN:--Is it black who was summoned forcibly?
	if	proxy:GetTempSummonParam() > 0 then
		proxy:LuaCallStartPlus( 5457, 3, param:GetPlayID() );
	end
	print("Check_AfterSummon end");
end


function startFloatSoulArrow(proxy,param)
	print("startFloatSoulArrow begin");
	
	local set_param = proxy:DivideRest( param:GetParam3() + 1, 2 );
	proxy:NotNetMessage_begin();
		--��5458�����V����\�E���̖�˂��L�b�N���遡 --EN:-- �� 5458 �� Kick the floating soul arrow ��
		proxy:OnKeyTime2( 5458, "startFloatSoulArrow", GetReloadTime(proxy), 0, set_param, once );
	proxy:NotNetMessage_end();
	
	--���V����\�E���̖�� --EN:--Fire arrows of floating souls
	--local cast_target = proxy:GetHostPlayerNo();
	--local cast_target = proxy:GetPlayerId_Random();
	
	--�{�X�𒲂ׂ� --EN:--examine the boss
	local BossId = -1;
	if	ForceSummonBlack_PlayerNo == -1 then
		BossId = 828;
	else
		BossId = 10001 + ForceSummonBlack_PlayerNo;
	end	

	--���������v���C���̏�񂪂����	 --EN:--If there is information about the forced summon player
	local cast_target = proxy:GetEnemyPlayerId_Random(CHR_TYPE_BlackGhost);
	print("targetPlayerNo = ",cast_target);	
	proxy:CustomLuaCallStartPlus( 5458, BossId, 10001+cast_target );
	
	print("startFloatSoulArrow end");
end


--LuaCallparam(5458,Owner,target)
function FloatingSoulArrow(proxy,param)
	print("FloatingSoulArrow begin");
	local Owner		= param:GetParam2();
	local target	= param:GetParam3();
	local cast_magicId = -1;
	local hpRate = proxy:GetHpRate(Owner);
	print("HpRate = ",hpRate);
	if hpRate <= 0.75 then cast_magicId = 5203; end
	if hpRate <= 0.60 then cast_magicId = 5202; end
	if hpRate <= 0.45 then cast_magicId = 5201; end
	if hpRate <= 0.30 then cast_magicId = 5200; end
	if hpRate > 0.0 and cast_magicId ~= -1 then
		--proxy:CastTargetSpellPlus( Owner, Owner, -1, target, cast_magicId,1011 );
		proxy:CastTargetSpellPlus( Owner, Owner, 38, target, cast_magicId,1011 );
	end
	print("FloatingSoulArrow end");
end


FloatingSoulArrow_Reload_Low	=  7.0;
FloatingSoulArrow_Reload_High	= 11.0;
--[[------------------------------------------------------------------------------------
--�������[�h���Ԏ擾�n���h���� --EN:-- �� Reload time acquisition handler ��
--�萔�Ŏw�肵�Ă���ő�l�E�ŏ��l�ԂŃ����_���̏������v�Z���Ԃ��B --EN:--Calculate and return a random decimal between the maximum and minimum values specified by the constant.
--------------------------------------------------------------------------------------]]
--�������[�h���Ԏ擾�n���h�� --EN:-- �� Reload time acquisition handler
function GetReloadTime(proxy)
	--�����_���̏������擾����ׁA1000�ł������芄�����肵�Ă܂��B --EN:--In order to get a random decimal, we multiply and divide by 1000.
	local Low  = FloatingSoulArrow_Reload_Low * 1000;
	local High = FloatingSoulArrow_Reload_High * 1000;
	local rand = proxy:GetRandom( Low, High ) / 1000;
	print("Reload", rand);
	return rand;
end


------------------------------------------------------------------------------------------------------------------
--��1033���{�XBGM�Đ� --EN:-- �� 1033 �� Boss BGM playback
------------------------------------------------------------------------------------------------------------------
function OnEvent_1033(proxy,param)
	print("OnEvent_1033 begin");
	if proxy:IsClient() == false then
		proxy:CustomLuaCallStart( 1033 , ForceSummonBlack_PlayerNo ); 
	end	
	print("OnEvent_1033 end");
end

function OnEvent_1033_0(proxy,param)
	print("OnEvent_1033_0 begin");	
	if proxy:IsBlackGhost() == true then
		proxy:LuaCallStart( 1033 , 100 );
		proxy:EraseEventSpecialEffect_2( 10000 , 4006 );
		proxy:SetEventSpecialEffect_2( 10000 , 4006 );		
	end
	proxy:LuaCallStart( 1033 , 0);
	print("OnEvent_1033_0 end");
end

function OnEvent_1033_2(proxy,param)
	print("OnEvent_1033_2 begin");
	local player = param:GetPlayID();
	print("player = ",player);	
	--�܂��o����ĂȂ��āA-1�ȊO�̒l��������L�� --EN:--If you haven't remembered yet and you get a value other than -1, remember it
	ForceSummonBlack_PlayerNo = player;	
	if ForceSummonBlack_PlayerNo ~= -1 then
		print("������ʂ�ݒ�!�@ForceSummonBlack_PlayerNo = ",ForceSummonBlack_PlayerNo); --EN:print("Set special effects! ForceSummonBlack_PlayerNo = ",ForceSummonBlack_PlayerNo);
		--������ʂ�ݒ�		 --EN:--Set special effects
		--proxy:EraseEventSpecialEffect_2( 10000 , 4005 );
		--proxy:SetEventSpecialEffect_2( ForceSummonBlack_PlayerNo+10001 , 4006 );	
	end	
	print("OnEvent_1033_2 end");
end

function OnEvent_1033_1(proxy,param)
	if proxy:IsCompleteEvent( 1033 ) == false then	
		print("OnEvent_1033_1 begin");
		--BGM�Đ� --EN:--BGM playback
		proxy:PlayPointSE( 2410, SOUND_TYPE_M, 40200000, 2 );
		--��5458�����V����\�E���̖�˂��L�b�N���遡 --EN:-- �� 5458 �� Kick the floating soul arrow ��
		if	proxy:IsClient() == false then
			proxy:NotNetMessage_begin();
				proxy:OnKeyTime2( 5458, "startFloatSoulArrow", 2.0, 0, 2, once );
			proxy:NotNetMessage_end();
		end
		
		if	ForceSummonBlack_PlayerNo == -1 then		
			--�{�X�Q�[�W�\�� --EN:-- Boss gauge display
			proxy:SetBossGauge( 828 , 0 ,6030 );			
		else
			proxy:SetBossGauge( 10001 + ForceSummonBlack_PlayerNo , 0 ,6030 );
		end
		
		print("OnEvent_1033_1 end");
	end
end
