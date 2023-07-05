once = 1;
everytime = 0;

--�����̎��Ԓ��� --EN:--Time adjustment here
Tutorial_pausewait = 0.14;

ClearBossId = -1;
ClearBoss = false;

--�������҃t���O --EN:--force summon flag
IsForceSummon = false;

---------------------------------------------------------------------------------------------------------------------------------
--	���g�p���Ă���V�X�e���C�x���gID(4000�`4095)�ꗗ --EN:-- �� List of used system event IDs (4000 to 4095)
---------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------
--	4000		�����̎��S�C�x���g --EN:-- 4000 own death events
--	4001		EzState�A�N�V�������f������ --EN:-- 4001 EzState action interrupt processing
--	4002		�͂����C�x���g����(��)������ --EN:-- 4002 When pressing the ladder event input (up)
--	4003		�͂����C�x���g����(��)������ --EN:-- 4003 When pressing the ladder event input (down)
--	4004		EzState����"1�i���I����"�������� --EN:-- 4004 When EzState gives you "One step up"
--	4005		EzState����"1�i����I����"�������� --EN:-- When 4005 EzState gave you "One step down"
--	4010		�A�j������(�󎀑̃A�j��) --EN:-- 4010 Animation Synchronization (Treasure Corpse Animation)
--	4012		�A�j������(�����A�j��) --EN:-- 4012 Animation synchronization (walking animation)
--	4013		�A�j������(�A�j��ID�w��t��) --EN:-- 4013 Animation synchronization (with animation ID specified)
--	4015		�X�[�p�[�A�[�}�[����(�L����) --EN:-- 4015 Super Armor Sync (Enabled)
--	4016		�X�[�p�[�A�[�}�[����(������) --EN:-- 4016 Super Armor Sync (disabled)
--	4017		���S���G����(�L����) --EN:-- 4017 Full Invincibility Synchronization (Enabled)
--	4018		���S���G����(������) --EN:-- 4018 Full Invincibility Synchronization (Disabled)
--  4020		���S�C���M�����[�Ď��i�R����ON�̏ꍇ�ُ͈� --EN:-- 4020 Death Irregular Monitoring (If this is ON,
--	4021		�f�o�b�O���[�h�C�x���g --EN:-- 4021 debug load event
--	4030		PK���� --EN:-- 4030 PK resurrection
--	4031
--	4032		�����̌������C�x���g --EN:-- 4032 Own Blood Letter Event
--	4033		�Z�b�V�����؂� --EN:-- 4033 Session expired

--	3001		�}���`�Ǔ����p --EN:-- 3001 for multi-wall synchronization
--	3002		�}���`�Ǔ����p --EN:-- 3002 for multi-wall synchronization
--	3003		�}���`�Ǔ����p --EN:-- 3003 for multi-wall synchronization
--	4034		�}���`�����@�Ǘp(�Z�b�V�������Ȃ�����)3001,3002,3003���g�p --EN:-- Use 3001, 3002, 3003 for 4034 multi-time magic wall (session connected)
--	4035		�}���`�����@�Ǘp(�Z�b�V�������Ȃ����Ă���Ƃ�����؂ꂽ) --EN:-- 4035 For multi-time magic wall (disconnected from the time the session was connected)
--	4036		SOS�ʒu�Ƀ��[�v(�z���C�g�����ʒu�p) --EN:-- Warp to 4036 SOS position (for white initial position)
--	4037		�~�j�u���b�N���ʒu�Ƀ��[�v(�u���b�N�����ʒu�p) --EN:-- Warp to 4037 mini block head position (for block initial position)
--	4038		�Z�b�V�������Ď�(�^�C���A�E�g���ŃZ�b�V�������s�������̃C�x���g) --EN:-- 4038 Session information monitoring (event when session failed due to timeout etc.)
--	4039		���� --EN:-- 4039 Intrusion
--	4040		�u���b�N�N���A(�p�~) --EN:-- 4040 block clear (obsolete)
--	4041		�����ʒm --EN:-- 4041 Summon Notice
--	4042		���S�ʒm --EN:-- 4042 Death Notice
--	4043		�Q���҂����Ȃ��Ȃ��� --EN:-- 4043 Participant gone
--	4044		�L�b�N�A�E�g�����̂�ʒm --EN:-- 4044 notify kicked out
--  4045        �{�X�����ւ̖��@�ǂ��ʉ߉\�ł���ƒʒm(�N���C�A���g�ɑ΂���) --EN:-- 4045 Notify the client that the magic wall to the boss room is traversable
--  4046        �ޏo�p --EN:-- 4046 for exit
--  4047        �ēǂݍ��݊֘A�C�x���g�̊��荞�ݖh�~�t���O --EN:-- 4047 Reload-related event interrupt prevention flag
--	4048		�ėp�A�N�V�����{�^�������t���O(�\��) --EN:-- 4048 Generic Action Button Restriction Flag (Reserved)
--	4049		�{�X�����C�x���g --EN:-- 4049 Boss Room Event
--	4050		�V�u���b�N�N���A --EN:-- 4050 new block clear
--	4051		�Q�[�g�A�C�e��(�Β��Ƀ��[�v����) --EN:-- 4051 Gate item (warp to stone pillar)
--	4052		�Β�����̃��[�v�A�j���q�� --EN:-- 4052 Warp animation connection from stone pillar
--	4053		�a���p --EN:-- 4053 Hall of Fame
--	4054		�`�F�b�N�|�C���g�p --EN:-- for 4054 checkpoints
--	4055		�z���C�g�S�[�X�g�����ʒm(�����z���C�g�J�E���g�p) --EN:-- 4055 White Ghost Resurrection Notification (for Resurrection White Count)
--	4056		QWC���Z�����z�M�p --EN:-- For 4056 QWC additive processing distribution
--	4057		�ėp�����n���h���o�^�p(���ۂ̃n���h���o�^�͊e�}�b�v�̃X�N���v�g�A�֐��L�q�͂����ōs��) --EN:-- 4057 For registering general-purpose synchronous handlers (Actual handler registration is done here in each map's script, function descriptions here)
--	4058		�������z�M --EN:-- 4058 Summoning Delivery
--	4059		�e�L�X�g���o�I�� --EN:-- 4059 End of text presentation
--	4060		�u���b�N�ړ�����p		 --EN:-- 4060 for block movement detection
--	4061		�_�C�A���O����鋗������p --EN:-- 4061 Close dialog For distance judgment
--	4062		�^�C�g���֖߂鏈���p --EN:-- 4062 for returning to title
--	4063		�Q�[���I���R�Ŕ�����l��m��ׂ̏��� --EN:-- 4063 Processing to know who leaves for game reasons
--	4064		���肵���̂Ŗ��G�����R�[�� --EN:-- 4064 Call to cancel invincibility because it's stabilized
--	4065		OBJ�̏��PC������� --EN:-- PC on top of 4065 OBJ
--	4066		OBJ�ɏ���Ă���PC���~�肽 --EN:-- PC on 4066 OBJ got off
--	4067		���S�\������ --EN:-- 4067 Ignore death expression
--	4068		�{�X�����j�~���s�\�� --EN:-- 4068 boss room blocking failure expression
--	4069		����C�x���g�I --EN:-- 4069 Fire Event!
--	4070		������ʓ��� --EN:-- 4070 special effect synchronization
--	15500		�����A�C�e���擾�Ď� --EN:-- 15500 Intrusion Item Acquisition Monitor


function g_Initialize(proxy)
print("g_Initialize global_event begin");
	--�`���[�g���A�����S����p�t���O��OFF --EN:--Turn off flag for tutorial death branch
	proxy:SetEventFlag(14080,false);--�ԓ�����p --EN:--for fort entrance
	proxy:SetEventFlag(14209,false);--�ԗp --EN:--for fort
	proxy:SetEventFlag(14337,false);--�n��p --EN:--For lava
	
	--�擾�����\�E���̍Ď擾 --EN:-- Reacquisition of Attempted Souls
	proxy:AddBlockClearBonus();
	--�y�i���e�B�̃`�F�b�N --EN:-- Penalty check
	proxy:CheckPenalty();
	
--��4000�����S���A�ăX�^�[�gor�I���� --EN:-- �� 4000 �� When you die, restart or end ��
	proxy:OnCharacterDead(99999, 10000, "OnEvent_4000", everytime);	
	proxy:NotNetMessage_begin();
		proxy:OnCharacterHP(99999,10000,"OnEvent_4000_Hp",0.0,once);
	proxy:NotNetMessage_end();
	proxy:LuaCall( 99999 , 0 , "OnEvent_4000_Hp_dummy",everytime);
	
--��4000_1���p�[�e�B�[�z�M�p���S�� --EN:-- �� 4000_1 �� death for party delivery ��
	proxy:LuaCall( 4000, 1,"HostDead",everytime );

--��4001��PC���A�N�V�����𒆒f���ꂽ���� --EN:-- �� 4001 �� When the PC is interrupted ��
	proxy:OnCheckEzStateMessage(4001,10000,"OnEvent_4001",10000);
	
--��4006��PC���n�V�S�C�x���g�ŃA�N�V�����{�^���������Ă���Ƃ����D��x�̖��Ő�ɋL�q --EN:-- �� 4006 �� When the PC is pressing the action button in the ladder event �� Write first due to priority issues
	proxy:OnActionCheckKey(4006,10000,"OnEvent_4006",0,1);		
--��4002��PC���n�V�S�C�x���g�ŃL�[���́i��j�������Ă���Ƃ��� --EN:--��4002��When the PC is pressing the key input (up) in the ladder event��
	proxy:OnActionCheckKey(4002,10000,"OnEvent_4002",1,1);
--��4003��PC���n�V�S�C�x���g�ŃL�[���́i���j�������Ă���Ƃ��� --EN:--��4003��When the PC is pressing the key input (down) at the ladder event��
	proxy:OnActionCheckKey(4003,10000,"OnEvent_4003",2,1);
--��4004��PC���n�V�S�C�x���g����EzState����"1�i���I����"������������� --EN:--��4004��When a PC receives "finished climbing one step" from EzState during a ladder event��
	proxy:OnCheckEzStateMessage(4004,10000,"OnEvent_4004",0);
--��4005��PC���n�V�S�C�x���g����EzState����"1�i����I����"������������� --EN:--��4005��When a PC receives "completed one step down" from EzState during a ladder event��
	proxy:OnCheckEzStateMessage(4005,10000,"OnEvent_4005",1);

--��4010���A�j���[�V�����̓����p�֐�(�󎀑̗p)�� --EN:-- �� 4010 �� Synchronization function for animation (for treasure corpse) ��
	proxy:LuaCall( 4010 , 1 , "OnEvent_4010" , everytime );
--��4012���A�j���[�V�����̓����p�֐��� --EN:-- �� 4012 �� Synchronization function for animation ��
	proxy:LuaCall( 4012 , 1 , "OnEvent_4012" , everytime );
	
--��4013���A�j���[�V�����̓����p�֐��� --EN:-- �� 4013 �� Synchronization function for animation ��
	proxy:LuaCall( 4013 , 1 , "OnEvent_4013" , everytime );
	proxy:CustomLuaCall( SYNCHROANIM, "SynchroAnim_4013", everytime );
	
	
--��4015���X�[�p�[�A�[�}�[�̓����L������ --EN:--��4015�� Super Armor Synchronization Enabled��
	proxy:LuaCall( 4015 , 1 , "OnEvent_4015" , everytime );
--��4016���X�[�p�[�A�[�}�[�̓����������� --EN:-- �� 4016 �� Synchronization invalidation of super armor ��
	proxy:LuaCall( 4016 , 1 , "OnEvent_4016" , everytime );
	
--��4017�����S���G�̓����L������ --EN:--��4017��Completely invincible synchronization enabled��
	proxy:LuaCall( 4017 , 1 , "OnEvent_4017" , everytime );
--��4018�����S���G�̓����������� --EN:-- �� 4018 �� Invincible Synchronization Invalidation ��
	proxy:LuaCall( 4018 , 1 , "OnEvent_4018" , everytime );
	
--��4019���A�^���L�������̓����p�� --EN:-- �� 4019 �� For synchronization of Atari enable/disable ��
	proxy:LuaCall( 4019 , 1 , "OnEvent_4019" ,everytime );

--[[	
--��4020��PC���ǂ͂���C�x���g�ŃL�[����(�E)�������Ă���Ƃ��� --EN:-- �� 4020 �� When the PC is pressing the key input (right) in the wall cling event ��
	proxy:OnActionCheckKey(4020,10000,"OnEvent_4020",4,4);
--��4021��PC���ǂ͂���C�x���g�ŃL�[����(��)�������Ă���Ƃ��� --EN:-- �� 4021 �� When the PC is pressing the key input (left) in the wall cling event ��
	proxy:OnActionCheckKey(4021,10000,"OnEvent_4021",3,4);	
--��4022��PC���ǂ͂���C�x���g����EzState����"�E��1���i�ݏI����"������������� --EN:--��4022��When a PC receives "Take one step to the right" from EzState during a wall-cling event��
	proxy:OnCheckEzStateMessage(4022,10000,"OnEvent_4022",20);	
--��4023��PC���ǂ͂���C�x���g����EzState����"����1���i�ݏI����"������������� --EN:--��4023��When the PC receives "Take one step to the left" from EzState during the wall cling event��
	proxy:OnCheckEzStateMessage(4023,10000,"OnEvent_4023",21);
	]]
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 4030, "g_second_Initialize", 0.1, 0, 1, once );
--��4032�������̌������� --EN:-- �� 4032 �� My blood letter ��
		proxy:OnSelfBloodMark( 4032, "SelfBloodMark", ATTR_LIVE + ATTR_GREY, everytime );
--��4033���Z�b�V�����؂ꁡ --EN:--��4033��Session expired��
		--proxy:OnSessionJustOut( 4033, "SessionJustOut", everytime );

	SingleReset(proxy,3001);--�u���b�N2�œ����� --EN:--When synchronizing in block 2
	SingleReset(proxy,3002);--�u���b�N3�œ����� --EN:--When synchronizing in block 3
	SingleReset(proxy,3003);--�u���b�N4�œ����� --EN:--When synchronizing in block 4

--��4034���}���`�����@�Ǘp(�Z�b�V�������Ȃ�����)�� --EN:-- �� 4034 �� For multi-time magic wall (session connected) ��
		proxy:OnSessionJustIn( 4034 , "OnEvent_4034" , everytime );
--��4035���}���`�����@�Ǘp(�Z�b�V�������Ȃ����Ă���Ƃ�����؂ꂽ)�� --EN:-- �� 4035 �� For magic wall when multi-session (disconnected from the time the session was connected) ��
		proxy:OnSessionJustOut( 4035 , "OnEvent_4035" , everytime );
	proxy:NotNetMessage_end();
	

	
--��4038���Z�b�V�������Ď��� --EN:--��4038��Session information monitoring��
	proxy:NotNetMessage_begin();
		proxy:OnSessionInfo( 4038, "OnEvent_4038" );
	proxy:NotNetMessage_end();
	
--��4040���u���b�N�N���A�� --EN:-- �� 4040 �� Block clear ��
	--proxy:LuaCall( 4040 , 1 , "BlockClear" , everytime );
--��4050���V�u���b�N�N���A�� --EN:-- �� 4050 �� New block clear ��
	proxy:CustomLuaCall( 4050 , "BlockClear2" , everytime );
	--�A�j�������p --EN:--For animation synchronization
	proxy:LuaCall( 4050 , 20, "BlockClearSynchroAnime", everytime );
	--�����������p --EN:--For invalidation synchronization
	proxy:LuaCall( 4050 , 30, "BlockClearSynchroInvalid", everytime );
	
--��4041�������ʒm�� --EN:-- �� 4041 �� summoning notification ��
	proxy:LuaCall( 4041, 1, "SummonInfoMsg_White", everytime );
	proxy:LuaCall( 4041, 2, "SummonInfoMsg_Black", everytime );
	proxy:LuaCall( 4041, 3, "SummonInfoMsg_ForceJoinBlack", everytime );
	proxy:LuaCall( 4041, 4, "SummonInfoMsg_ForceSummonBlack", everytime );
	
--��4042�����S�ʒm�� --EN:-- �� 4042 �� death notice ��
	proxy:LuaCall( 4042, 1, "DeadInfoMsg_White", everytime );
	proxy:LuaCall( 4042, 2, "DeadInfoMsg_Black", everytime );
	proxy:LuaCall( 4042, 3, "DeadInfoMsg_Host",  everytime );
	proxy:LuaCall( 4042, 4, "dummy", everytime );--�����PK�Ŏ��S�������ɂ��u���b�N���S��m��ׁA���g����̃_�~�[���Ă� --EN:--This will call an empty dummy to know Black's death even when he dies from PK
	proxy:LuaCall( 4042, 5, "dummy", everytime );--����͘S��3�ŋ��������ŌĂ΂ꂽ�u���b�N�����񂾂Ƃ������ׁA���g����̃_�~�[���Ă� --EN:--This calls an empty dummy to take when Black, who was summoned by forced summoning in Prison Castle 3, dies.
	proxy:LuaCall( 4042, 6, "DeadInfoMsg_ForceJoinBlack", everytime );--����͘S��3�ŋ��������ŌĂ΂ꂽ�u���b�N�����񂾂Ƃ������ׁA���g����̃_�~�[���Ă� --EN:--This calls an empty dummy to take when Black, who was summoned by forced summoning in Prison Castle 3, dies.
	
--��4043���Q���҂����Ȃ��Ȃ����� --EN:--��4043��Participant disappeared��
	proxy:NotNetMessage_begin();
		proxy:LuaCall( 4043, 1, "OnLeavePlayer", everytime );--�z���C�g�\�E���̃z���C�g�����Ȃ��Ȃ��� --EN:--White of White Soul is gone
		proxy:LuaCall( 4043, 2, "OnLeavePlayer", everytime );--�u���b�N�\�E���̃u���b�N�����Ȃ��Ȃ��� --EN:-- Black Soul's Black is gone
		proxy:LuaCall( 4043, 3, "OnLeavePlayer", everytime );--�����u���b�N�����Ȃ��Ȃ��� --EN:--Invasion Black is gone
		proxy:LuaCall( 4043, 4, "dummy", everytime );--�����������ꂽ�u���b�N�����Ȃ��Ȃ��� --EN:--The summoned black is gone
		proxy:LuaCall( 4043, 5, "dummy", everytime );--�d��OFF�A���Z�b�g���Ŗ��ӔC�ɂ��Ȃ��Ȃ��� --EN:--Irresponsibly disappeared due to power off, reset, etc.
	proxy:NotNetMessage_end();
	
--��4044���L�b�N�A�E�g�����̂�ʒm�� --EN:-- �� 4044 �� Notification of kick-out ��
	proxy:LuaCall( 4044, 1, "OnKickOut", everytime );
--��4044�����ӃL�b�N�����̂�ʒm�� --EN:-- �� 4044 �� Notification of thanks kick ��
	proxy:LuaCall( 4044, 2, "OnThxKickOut", everytime );
	
	--[[����Ȃ��q�H --EN:--[[Unwanted child?
	proxy:NotNetMessage_begin();
		proxy:OnRegistFunc(4000, "Condition_AliveMotion", "Result_AliveMotion", 1, once );
	proxy:NotNetMessage_end();
	]]

--��4045���{�X�����ւ̖��@�ǂ��ʉ߉\�ł���ƒʒm(�N���C�A���g�ɑ΂���)�� --EN:--�� 4045 �� Notify the client that the magic wall to the boss room can be passed ��
	proxy:LuaCall( 4045, 1, "PossibleInfo_GoToTheBossArea", everytime );
--��4068���{�X�����ւ̑j�~�����s��������ʒm(�N���C�A���g�ɑ΂���)�� --EN:-- �� 4068 �� Notify the failure to block the boss room (to the client) ��
	proxy:LuaCall( 4068, 1, "Failed_BossArea" ,everytime);
	
--��4046���ޏo�ʒm�� --EN:--��4046��Exit Notice��
	proxy:LuaCall( 4046, 1, "LeaveMessage", everytime );--�z���C�g --EN:--white
	proxy:LuaCall( 4046, 2, "LeaveMessage", everytime );--�u���b�N --EN:--black
	proxy:LuaCall( 4046, 3, "dummy", everytime );--�����������ꂽ�u���b�N���ޏo���� --EN:--Forcibly summoned Black left
	
	
--��4055�������z���C�g�J�E���g�� --EN:-- �� 4055 �� Resurrection White Count ��
	proxy:LuaCall( 4055, 1, "WhiteReviveCount", everytime );
	
--��4056��QWC���Z�����z�M�p --EN:-- �� 4056 �� For QWC addition processing distribution
	proxy:LuaCall( 4056, 1, "SynchroAddQWC", everytime );
	
--��4058���������z�M --EN:-- �� 4058 �� Delivery during summoning
	proxy:LuaCall( 4058, 1, "Call_WhiteSos", everytime );--�z���C�g --EN:--white
	proxy:LuaCall( 4058, 2, "Call_BlackSos", everytime );--�u���b�N --EN:--black
	
--��4060���u���b�N�ړ�����	 --EN:-- �� 4060 �� block movement judgment
--(ASSERT����̈�dummy�A�g�p����ۂ͊e�}�b�v��CustomLuaCall��4060�ŌĂт����n���h����o�^����) --EN:--(Dummy to avoid ASSERT, when using, register the handler you want to call with CustomLuaCall 4060 in each map)
--�u���b�N�ړ��̂��тɌĂ΂�A --EN:-- called every block move,
--param2�Ƀu���b�NID,param3�ɃG���AID���擾�ł��܂��B --EN:-- You can get the block ID in param2 and the area ID in param3.
--�u���b�N�ړ�����̓��[�J���v���C���̃v���C�̈�ID���ς�������A-1�ȊO�̎� --EN:--Block movement judgment is when the play area ID of the local player has changed and is other than -1
	proxy:NotNetMessage_begin();
		proxy:CustomLuaCall( 4060, "dummy", everytime );
	proxy:NotNetMessage_end();
	
	--�Q�[���I���R�ŒN�����������Ƃ��ɔz�M --EN:--Delivered when someone leaves for game reasons
	proxy:CustomLuaCall( 4063 ,"OnGameLeave",everytime);	
	
--��4064�����薳�G�����C�x���g�� --EN:-- �� 4064 �� stable invincibility cancellation event ��
	proxy:LuaCall( 4064 ,1,"OnDisableInvincible",everytime);
	
	--��4065��OBJ�̏��PC��������� --EN:-- �� 4065 �� A PC is on top of an OBJ ��
	proxy:CustomLuaCall( 4065 ,"OnEnterRideObj",everytime);	
	--��4066��OBJ�ɏ���Ă���PC���~�肽�� --EN:-- �� 4066 �� PC on OBJ got off ��
	proxy:CustomLuaCall( 4066 ,"OnLeaveRideObj",everytime);
	
	
	if proxy:IsLivePlayer() == true then
		proxy:SetEventFlag( 15112,true );
		proxy:SetEventFlag( 15113,true );
		proxy:SetEventFlag( 15114,true );
		proxy:SetEventFlag( 15115,true );
		
		proxy:SetEventFlag( 15116,true );
		proxy:SetEventFlag( 15117,true );
		proxy:SetEventFlag( 15118,true );
		proxy:SetEventFlag( 15119,true );			
	end
	
--��15500�������A�C�e���擾�Ď��� --EN:-- �� 15500 �� Intrusion item acquisition monitoring ��
	if proxy:IsCompleteEvent( 15500 ) == false then
		proxy:NotNetMessage_begin();
			proxy:LuaCall( 15500 , 0 , "OnEvent_15500",everytime);
		proxy:NotNetMessage_end();
	end
	
	local actidlist = {
		14500,14501,14502,14503,14504,14505,14506,14507,14508,14509,
		14510,14511,14512,14513,14514,14515,14516,14517,14518,14519,
		14520,14521,14522,14523,14524,14525,14526,14527,14528,14529,
		14530,14531,14532,14533,14534,14535,14536,14537,14538,14539,
		14540,14541,14542,
	};
	local num = table.getn(actidlist);
	for index = 1 , num , 1 do
		proxy:SetEventFlag( actidlist[index],false );
	end

	if	proxy:GetTempSummonParam() > 0 then
		IsForceSummon = true;
	end
	
--�p�[�e�B�[�l���̐�����4�ŏ��������Ȃ���(�S��ŕς����l��߂������ł����A�ꎞ�I�Ȉ��S�����m�ۂ���ׂɂ����ŏ����l�����Ȃ����܂��B) --EN:--Reinitialize the party size limit to 4 (It is a process to return the value changed in the prison, but to ensure temporary safety, the initial value is reset here.)
--�l�b�g���[�N�������܂莟��C�� --EN:--Fixed as soon as network �� is tightened
	proxy:SetPartyRestrictNum(4);

print("g_Initialize global_event end");
end

function InGameStart(proxy,param)
	print("InGameStart begin");
		proxy:LuaCallStart( 4064,1 );
		--�����A�j���Đ� --EN:-- Resurrection animation playback
		if proxy:IsAliveMotion() == true then
			print("Condition_AliveMotion Alive");			
			proxy:SetTextEffect(TEXT_TYPE_Revival);
			proxy:PlayAnimation( 10000, 6100 );
			proxy:SetAliveMotion(false);
		else
			print("Condition_AliveMotion Not Alive");
			if	proxy:IsLivePlayer() == true then
				--HpMpSpMax
				--proxy:PlayerParamRecover();
				--proxy:PlayerRecover();
				proxy:PlayAnimation( 10000, 6100 );
				proxy:NotNetMessage_begin();
					proxy:OnChrAnimEnd( SYSTEM_WARP, 10000, 6100, "AliveMotion_End", once );
				proxy:NotNetMessage_end();
			elseif	proxy:IsGreyGhost() == true then
				--HpMpSpMax
				--proxy:PlayerParamRecover();
				--proxy:PlayerRecover();
				if	proxy:IsReviveWait() == true then
					proxy:RevivePlayer();
					proxy:SetReviveWait( false );
				end
				proxy:PlayAnimation( 10000, 6100 );
				proxy:NotNetMessage_begin();
					proxy:OnChrAnimEnd( SYSTEM_WARP, 10000, 6100, "AliveMotion_End", once );
				proxy:NotNetMessage_end();
			elseif	proxy:IsWhiteGhost() == true then
				print("IsWhiteAnim");
				proxy:NotNetMessage_begin();
					proxy:OnKeyTime2(4013,"AliveMotion_wait",0.1,0,0,once);
				proxy:NotNetMessage_end();
				--[[
				proxy:CustomLuaCallStartPlus( 4013, LOCAL_PLAYER, 6100 );
				--Luafunc_PlaySynchroAnimation(proxy,param,6100);
				--proxy:PlayAnimation( 10000, 6100 );
				proxy:NotNetMessage_begin();
					proxy:OnChrAnimEnd( SYSTEM_WARP, 10000, 6100, "AliveMotion_End", once );
				proxy:NotNetMessage_end();
				]]
			elseif	proxy:IsBlackGhost() == true then
				print("IsBlackAnim");
				proxy:NotNetMessage_begin();
					proxy:OnKeyTime2(4013,"AliveMotion_wait",0.1,0,0,once);
				proxy:NotNetMessage_end();
				--[[
				proxy:CustomLuaCallStartPlus( 4013, LOCAL_PLAYER, 6100 );
				--Luafunc_PlaySynchroAnimation(proxy,param,6100);
				--proxy:PlayAnimation( 10000, 6100 );
				if	proxy:GetTempSummonParam() > 0 then
					proxy:SetEventSpecialEffect( LOCAL_PLAYER, 10180 );
				end
				proxy:NotNetMessage_begin();
					proxy:OnChrAnimEnd( SYSTEM_WARP, 10000, 6100, "AliveMotion_End", once );
				proxy:NotNetMessage_end();
				]]
				if	proxy:GetTempSummonParam() > 0 then
					proxy:SetEventSpecialEffect( LOCAL_PLAYER, 10180 );					
					--�u���b�N���������ʒm --EN:-- Black forced summon notification
					--�|�����ʒm --EN:--policy play notification
					REMO_FLAG = 2;
					proxy:LuaCallStart( 5500, 0 );
					proxy:LuaCallStart( 1030, 2 );					
				end
			end
		end
		proxy:ParamInitialize();
		
		if	proxy:IsGreyGhost()  == true or
			proxy:IsWhiteGhost() == true then
			print("SetEventSpecialEffect 10000, 101");
			proxy:SetEventSpecialEffect( 10000, 101 );
		elseif proxy:IsBlackGhost() == true then
			print("SetEventSpecialEffect 10000, 102");
			proxy:SetEventSpecialEffect( 10000, 102 );
		end
	print("InGameStart end");
end

--��4064�����薳�G������ --EN:-- �� 4064 �� stable invincibility release ��
function OnDisableInvincible(proxy,param)
	print("OnDisableInvincible begin");	
	if param:IsNetMessage() == false then		
		--�z�M�҂����� --EN:--By myself
		proxy:EnableInvincible( 10000 , false );
	else
		proxy:EnableInvincible( param:GetPlayID()+10001 , false );
	end
	print("OnDisableInvincible end");
end

--[[
function Condition_AliveMotion(proxy,param)
	if proxy:IsValidInstance( 10000, 1 ) == true then
		print("Condition_AliveMotion Success");
		return true;
	end
	return false;
end

function Result_AliveMotion(proxy,param)
print("Result_AliveMotion begin");
print("Result_AliveMotion end");
end

function AliveMotion_2(proxy,param)
	print("AliveMotion_2 begin");
	proxy:CustomLuaCallStartPlus( 4013, LOCAL_PLAYER, 8288 );
	--Luafunc_PlaySynchroAnimation(proxy,param,8288);
	proxy:NotNetMessage_begin();
		proxy:OnChrAnimEnd( SYSTEM_WARP, 10000, 8288, "AliveMotion_End", once );
	proxy:NotNetMessage_end();
	print("AliveMotion_2 end");
end
]]

function AliveMotion_wait(proxy,param)
	print("AliveMotion_wait begin");
	proxy:CustomLuaCallStartPlus( 4013, LOCAL_PLAYER, 6100 );
	--Luafunc_PlaySynchroAnimation(proxy,param,6100);
	--proxy:PlayAnimation( 10000, 6100 );
	proxy:NotNetMessage_begin();
		proxy:OnChrAnimEnd( SYSTEM_WARP, 10000, 6100, "AliveMotion_End", once );
	proxy:NotNetMessage_end();
	print("AliveMotion_wait end");
end

------------------------------------------------------------------------------------------------
----�����A�j���Đ��I����------------------------------------------------------------------------ --EN:--After finishing the initial animation -------------------------------------------- -----------------------------
------------------------------------------------------------------------------------------------
function AliveMotion_End(proxy,param)
	if proxy:IsInParty() == true then
	print("AliveMotion_End begin");
	
		-----------------------------------------------------------------------------
		--�����ʒm���^�C�~���O�������A�j����ɕύX�����ׁA�����ֈړ� --EN:--Summon notification *Moved here because the timing was changed after the initial animation
		-----------------------------------------------------------------------------
		--�ʏ��0���A���Ă��邽�߁A���̏����͒ʂ�Ȃ� --EN:--Normally 0 is returned, so this process does not pass
		--��������鎞�̂ݔ��肪�s���� --EN:--Judgment is made only when summoned
		if		proxy:GetTempSummonParam() == -1 then
			--�z���C�g�����ʒm --EN:-- White summon notification
			proxy:LuaCallStartPlus( 4041, 1, proxy:GetLocalPlayerId() );
		elseif 	proxy:GetTempSummonParam() == -2 then
			--�u���b�N�����ʒm --EN:-- Black summon notification
			proxy:LuaCallStartPlus( 4041, 2, proxy:GetLocalPlayerId() );
		elseif 	proxy:GetTempSummonParam() == -3 then
			--�u���b�N�����ʒm --EN:-- Black intrusion notification
			proxy:LuaCallStartPlus( 4041, 3, proxy:GetLocalPlayerId() );
		elseif 	proxy:GetTempSummonParam() >   0 then
			--�u���b�N���������ʒm --EN:-- Black forced summon notification
			proxy:LuaCallStartPlus( 4041, 4, proxy:GetLocalPlayerId() );
		end

		print("AliveMotion_End end");
	else
		proxy:ResetSummonParam();
		proxy:WARN("AliveMotion_End ���Ƀ��[��������"); --EN:proxy:WARN("AliveMotion_End no more room");
	end
end



function g_second_Initialize(proxy, param)
print("g_second_Initialize begin");
--�����t���[�����ƁA�L�����N�^�̃^�C�v�����肵�Ă��Ȃ����ۂ��̂� --EN:--It seems that the character type is not stable in the initial frame
--0�b��ł��炵�Ă݂܂����B --EN:-- I tried shifting it after 0 seconds.
--��4030��PK�Ď�(�u���b�N�S�[�X�g�p)�� --EN:-- �� 4030 �� PK monitoring (for Black Ghost) ��
	print("PK�Ď��ǉ�"); --EN:print("Add PK monitor");
	proxy:OnPlayerKill( 4030, "PlayerKill_4030_sub", everytime );
	proxy:CustomLuaCall( 4030, "PlayerKill_4030", everytime );
	
--���}���`�p�̖��@�ǂ𖳌��� --EN:--�� Disable magic wall for multiplayer
	if proxy:GetLocalPlayerChrType() == CHR_TYPE_GreyGhost or proxy:GetLocalPlayerChrType() == CHR_TYPE_LivePlayer then
		proxy:NotNetMessage_begin();
			proxy:OnKeyTime2( 4035 , "OnEvent_4035" , 0.0 , 0 , 1 , once );
		proxy:NotNetMessage_end();
	end
	
	if proxy:IsInParty() == false then
	end
	
print("g_second_Initialize end");
end


function OnEvent_4000_Hp(proxy,param)
	print("OnEvent_4000_Hp begin");
	--Hp��0�ɂȂ����̂� --EN:--Hp became 0
	--���S�񕜗v�� --EN:-- full recovery request
	proxy:RequestFullRecover();
	if proxy:IsClient() == false then
		proxy:LuaCallStart( 99999 , 0 );
	end
	print("OnEvent_4000_Hp end");
end

function OnEvent_4000_Hp_dummy(proxy,param)	
end

--��4000�����S���A�ăX�^�[�g�� --EN:-- �� 4000 �� When you die, restart ��
function OnEvent_4000(proxy, param)
	if proxy:IsCompleteEvent(4000) == true then
		--print("OnEvent_4000 IsCompleteEvent return end");
		return;
	end
	if param:IsNetMessage()==true  then
		--print("OnEvent_4000 IsNetMessage return end");
		return;
	end
	print("OnEvent_4000 begin");
	--�`���[�g���A���ԓ�����}�b�v�̃t���O���������Ă���Ȃ� --EN:--If the tutorial fort entrance map flag is established
	if proxy:IsCompleteEvent(14080) == true then
		proxy:SetTextEffect(TEXT_TYPE_Dead);
		proxy:OnKeyTime2(4000,"m08_00Death",0.0,0,0,once);
		return;
	end
	--�`���[�g���A���ԃ}�b�v�̃t���O���������Ă���Ȃ� --EN:--If the tutorial fort map flag is true
	if proxy:IsCompleteEvent(14209) == true then--m08_01�̎��S�C�x���g�ɔ�� --EN:--Jump to the death event of m08_01
		proxy:SetTextEffect(TEXT_TYPE_Dead);
		proxy:OnKeyTime2(4000,"m08_01Death",0.0,0,0,once);
		return;
	end
	--�`���[�g���A���n��}�b�v�̃t���O���������Ă���Ȃ� --EN:--If the tutorial lava map flag is true
	if proxy:IsCompleteEvent(14337) == true then--m08_02�̎��S�C�x���g�ɔ�� --EN:--Jump to the death event of m08_02
		proxy:SetTextEffect(TEXT_TYPE_Dead);
		proxy:OnKeyTime2(4000,"m08_02Death",0.0,0,0,once);
		return;
	end
	
	
	--���S���̓��삪���ɓ����Ă���ꍇ�͔��肵�Ȃ� --EN:--Do not judge if the action at the time of death is already included
	if proxy:GetReturnState() >0 then
		return;
	end
	
	local Live  = proxy:IsLivePlayer();	--���� --EN:--survival
	local Grey  = proxy:IsGreyGhost();	--�O���C�S�[�X�g --EN:--Gray Ghost
	local White = proxy:IsWhiteGhost();	--�z���C�g�S�[�X�g --EN:--White Ghost
	local Black = proxy:IsBlackGhost();	--�u���b�N�S�[�X�g --EN:--Black Ghost
	local Host  = proxy:IsHost();		--�z�X�g���H --EN:--A host?
	local Party = proxy:IsInParty();	--PT���H --EN:--PT?
	local dead  = false;				--�����Ǝ��񂾂��H --EN:--Did he die properly?

	--�g�D���[�f�X���� --EN:--True death judgment
	
	if proxy:IsCompleteEvent(4067) == false then
		if Live == true then
			proxy:SetTextEffect(TEXT_TYPE_Dead);
		else
			proxy:SetTextEffect( TEXT_TYPE_GhostDead );
		end
	end
	
	--�z�X�g���S���� --EN:--Host Death Judgment
	if Live == true or Grey == true then		
		if Live == true then
			proxy:SetEventFlag( 15112,false );
			proxy:SetEventFlag( 15113,false );
			proxy:SetEventFlag( 15114,false );
			proxy:SetEventFlag( 15115,false );
			
			proxy:SetEventFlag( 15116,false );
			proxy:SetEventFlag( 15117,false );
			proxy:SetEventFlag( 15118,false );
			proxy:SetEventFlag( 15119,false );			
		end
		if Party == true and Host == true then			
			--�O���C�S�[�X�g�t���OON --EN:--Gray ghost flag ON
			proxy:SetEventFlag( 16700 , true );
			--���S���J�E���g�A�b�v --EN:-- count up the number of deaths
			proxy:AddDeathCount();
			proxy:NotNetMessage_begin();
				--�z�X�g�{�l�̓\���v���C���S�Ɠ��� --EN:--The host himself is the same as solo play death
				proxy:OnKeyTime2(4000,"SoloPlayDeath",0.0,0,1,once);
			proxy:NotNetMessage_end();
			--�p�[�e�B�[�z�M�p�̎��S�C�x���g�𔭍s(�z�X�g�͓����ł͂������) --EN:--issue death event for party delivery (host is repelled internally)
			proxy:LuaCallStart(4000, 1 );
			dead = true;
		end
	end
	
	--�N���C�A���g���S --EN:--Client death
	if Black == true or White == true then		
		proxy:NotNetMessage_begin();
			proxy:OnKeyTime2(4000,"PartyGhostDeath",0.0,0,1,once);
		proxy:NotNetMessage_end();
		dead = true;
	end

	--�����\���v���C���S --EN:--survival solo play death
	if Live == true or Grey == true then
		if Party == false then			
			--�O���C�S�[�X�g�t���OON --EN:--Gray ghost flag ON
			proxy:SetEventFlag( 16700 , true );
			--���S���J�E���g�A�b�v --EN:-- count up the number of deaths
			proxy:AddDeathCount();
			proxy:NotNetMessage_begin();
				proxy:OnKeyTime2(4000,"SoloPlayDeath", 0.0, 0,1,once);
			proxy:NotNetMessage_end();
			dead = true;
		end
	end
	
	if dead == false then
		print("Check ChrType!!");
		--�ُ��ʒm(�C�x���g�ǈȊO�Ŏ��S�Ŗ�肪�����������ɂ͂��̃t���O�����Ă�������) --EN:-- Notification of anomaly (Please see this flag when a problem occurs due to death outside the event team)
		--�L�����^�C�v�������A�O���C�A�z���C�g�A�u���b�N�ȊO�̉\��������܂��B --EN:--There is a possibility that the character type is other than Survival, Gray, White, and Black.
		--���[�h�������Ȃ��ŁA�L�����^�C�v���m�F���Ă��������B --EN:--Don't let it load, check your character type.
		proxy:NotNetMessage_begin();
			proxy:OnKeyTime2(4000,"SoloPlayDeath", 0.0, 0,1,once);
		proxy:NotNetMessage_end();
		proxy:SetEventFlag(4020,true);
	end	
	proxy:SetEventFlag(4000,true);
	print("OnEvent_4000 end");
end




--��4000_1���p�[�e�B�[�z�M�p���S�� --EN:-- �� 4000_1 �� death for party delivery ��
function HostDead(proxy, param)	
	if proxy:IsHost() == true or proxy:IsGreyGhost() == true then
		return;
	end
	if proxy:IsCompleteEvent( 4047 ) == true then
		return;
	end
	
	--�u���b�N�S�[�X�g�̏ꍇ�͖ڕW�B���̗���� --EN:--In the case of Black Ghost, go to the goal achievement flow
	if	proxy:IsBlackGhost() == true then
		proxy:NotNetMessage_begin();
			--���̍ēǂݍ��݌n�C�x���g�̊��荞�݂�h�~ --EN:--Prevent interruption of other reloading events
			proxy:SetEventFlag( 4047, true );
			--�C�x���g�����ɂ����[�h�҂��ł��鎖��ʒm --EN:-- Notify that it is waiting for loading inside the event
			proxy:SetLoadWait();
			
		proxy:NotNetMessage_end();
		
		--�V�X�e�����b�Z�[�W		 --EN:--system message
		proxy:SetTextEffect( TEXT_TYPE_TargetClear );
		
		proxy:NotNetMessage_begin();
			proxy:OnTextEffectEnd(4059, TEXT_TYPE_TargetClear, "TextEffectEnd_PK_Success");
		proxy:NotNetMessage_end();
		
		--proxy:SetTextEffect( TEXT_TYPE_Revival );
		--proxy:LuaCallStartPlus( 4056, 1, 210 );--AddQWC�z�M(�}���`�Ńz�X�g���E����QWC���Z) --EN:--AddQWC distribution (QWC addition that killed the host in multi)
		return;
	end
	
	--���̍ēǂݍ��݌n�C�x���g�̊��荞�݂�h�~ --EN:--Prevent interruption of other reloading events
	proxy:SetEventFlag(4047, true);
	--�C�x���g�����ɂ����[�h�҂��ł��鎖��ʒm --EN:-- Notify that it is waiting for loading inside the event
	proxy:SetLoadWait();
	
	print("HostDead begin");
	
	
	
	--�ڕW���s --EN:--Target failed
	MissionFailed(proxy,param);
	
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2(4000,"HostDead_1",5.0,0,0,once);
		proxy:OnKeyTime2(4000,"EventMenuBrake",5.0,1,1,once);
	proxy:NotNetMessage_end();
	
	--�C�x���g�I�� --EN:--End of event
	proxy:SetEventFlag(4000,true);
	
	
	print("HostDead end");
end

function HostDead_1(proxy, param)
	print("HostDead_1 begin");
	
	--�C�x���g�t���O���[���o�b�N --EN:--eventflag rollback
	proxy:SetFlagInitState(2);
	
	--�����O�̈ʒu�ݒ� --EN:--Position settings before summoning
	proxy:SetSummonedPos();	
	
	--���݂̃}�b�v�Ɠ���ID�����}�b�vID�Ƃ��Đݒ� --EN:--Set the same ID as the current map as the next map ID
	proxy:SetDefaultMapUid(-1);	
	
	--���[�v���s�� --EN:--do warp
	proxy:WarpNextStageKick();
	
	--�O���C�S�[�X�g�� --EN:--Gray ghost
	--proxy:SetChrTypeDataGrey();
	proxy:SetChrTypeDataGreyNext();
	
	print("HostDead_1 end");
end



--[[
--��4000_2���g�D���[�f�X�p���S�� --EN:-- �� 4000_2 �� Death for Trudeath ��
function TrueDeath(proxy,param)
	print("TrueDeath begin");
	
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 4000, "TrueDeath_1", 5.0, 0, 3, once );
	proxy:NotNetMessage_end();
	
	--�V�X�e�����b�Z�[�W	 --EN:--system message
	proxy:SetEventFlag( 4000, true );
end

function TrueDeath_1(proxy,param)
	print("TrueDeath_1 begin");
	
	--�g�D���[�f�X�y�i���e�B --EN:--True Death Penalty
	proxy:TrueDeathPenalty();
	
	--�v���C���[���� --EN:--Player Resurrection
	proxy:RevivePlayer();
	
	--���[�v��w�� --EN:--Specify warp destination
	proxy:SetMapUid( 1, 0, 0, 0, -1 );	
	
	--0.2�b��ATrueDeath_2�����s --EN:--After 0.2 seconds, execute TrueDeath_2
	proxy:OnKeyTime2(4000,"TrueDeath_2",0.2,0,0,once);
	
	proxy:LuaCallStartPlus( 4056, 1, 110 );--AddQWC�z�M --EN:--AddQWC distribution
	
	print("TrueDeath_1 end");
end


function TrueDeath_2(proxy,param)
	print("TrueDeath_2 begin");
	
	--���[�v���s�� --EN:--do warp
	proxy:WarpNextStageKick();
	
	print("TrueDeath_2 end");
end
]]



--��4000_3���p�[�e�B�[���U�p�� --EN:--��4000_3��For dissolution of the party��
function OnEvent_4000_3(proxy,param)

	print("�}���`���U"); --EN:print("Multi dissolution");
	proxy:ReturnMapSelect();
end




--��4000_4���\���ʏ펀�S�� --EN:-- �� 4000_4 �� Solo normal death ��
function SoloPlayDeath(proxy,param)
	print("SoloPlayDeath SetRestart");
	
	if proxy:IsCompleteEvent( 4047 ) == true then
		return;
	end
	
	--���̍ēǂݍ��݌n�C�x���g�̊��荞�݂�h�~ --EN:--Prevent interruption of other reloading events
	proxy:SetEventFlag(4047, true);
	
	
	--�ڕW���s --EN:--Target failed
	MissionDeadFailed(proxy,param);
	
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 4000, "SoloPlayDeath_1", 3, 0, 3, once );
	proxy:NotNetMessage_end();
	
	--PK�ɂ�鎀�S�ł͂Ȃ����A�z�X�g���S�̃��b�Z�[�W��z�M --EN:--Delivery host death message when death is not due to PK
	if proxy:IsCompleteEvent( 4030 ) == false then
		proxy:LuaCallStartPlus( 4042, 3, proxy:GetLocalPlayerId() );
	end
	
	print("SoloPlayDeath end");
end

function SoloPlayDeath_1(proxy,param)
	print("SoloPlayDeath_1 begin");
	
	proxy:NotNetMessage_begin();
		--proxy:OnBloodMenuClose(4000,"SoloPlayDeath_2",300.0, once);
		SoloPlayDeath_2(proxy,param);
	proxy:NotNetMessage_end();
	
	print("SoloPlayDeath_1 end");
end


function SoloPlayDeath_2(proxy,param)
	print("SoloPlayDeath_2 begin");

	--�t���O�̏������X�L�b�v --EN:--flag initialization skip
	proxy:SetFlagInitState(1);
	
	--�G���A�����ʒu�̃}�b�vID�Z�b�g --EN:--Map ID set for area initial position
	--proxy:SetAreaStartMapUid(-1);
	proxy:SetDefaultMapUid( 999 - proxy:GetLastBlockId() );
	
	--���[�v���s�� --EN:--do warp
	proxy:WarpNextStageKick();
	
	--�����A�j���Đ� --EN:-- Resurrection animation playback
	proxy:PlayAnimation( 10000, 6100 );
	
	--���S�C�x���g��t�\ --EN:--Can accept death events
	proxy:SetEventFlag(4000,false);
	
	--�p�j�f�[�����p --EN:--For prowling daemons
	proxy:LuaCallStart( 4000, 100 );
	
	--�O���C�S�[�X�g�� --EN:--Gray ghost
	--proxy:SetChrTypeDataGrey();
	if proxy:IsCompleteEvent(4067) == false then
		proxy:SetChrTypeDataGreyNext();
	end
	
	--�������X�V --EN:--Blood letter update
	proxy:UpDateBloodMark();
	if proxy:IsLivePlayer() == true then
		--���S��QWC�ϓ����폜 --EN:--removed death QWC variation
		proxy:LuaCallStartPlus( 4056, 1, 100 );--AddQWC�z�M�i�S�[�X�g������QWC���Z�j --EN:--AddQWC distribution (QWC addition to ghost)
	end
	print("SoloPlayDeath_2 end");
end




--��4000_5���z���C�g�u���b�N�S�[�X�g���̎��S�p�� --EN:-- �� 4000_5 �� For death during white black ghost ��
function PartyGhostDeath(proxy,param)
	print("PartyGhostDeath begin");
	
	if proxy:IsCompleteEvent( 4047 ) == true then
		return;
	end
	--���̍ēǂݍ��݌n�C�x���g�̊��荞�݂�h�~ --EN:--Prevent interruption of other reloading events
	proxy:SetEventFlag(4047, true);
	--���̍ēǂݍ��݌n�C�x���g�̊��荞�݂�h�~ --EN:--Prevent interruption of other reloading events
	proxy:SetEventFlag(4047, true);
	
	--�����̃v���C���[ID��z�M���ăQ�[���I�ɔ����鎖��ʒm --EN:--Distribute your player ID and notify that you are leaving the game
	proxy:CustomLuaCallStart( 4063 , proxy:GetLocalPlayerId() );
	
	--�C�x���g�t���O���[���o�b�N --EN:--eventflag rollback
	proxy:SetFlagInitState(2);
	
	proxy:NotNetMessage_begin();
		proxy:OnTextEffectEnd( 4059, TEXT_TYPE_GhostDead, "PartyGhostDeath_1");
	proxy:NotNetMessage_end();
	
	
	--proxy:NotNetMessage_begin();
	--	proxy:OnKeyTime2( 4000, "PartyGhostDeath_1", 5.0, 0, 3, once );
	--proxy:NotNetMessage_end();
	
	--PK�ɂ�鎀�S�ł͂Ȃ����A���S�̃��b�Z�[�W��z�M --EN:--Delivery death message when death is not due to PK
	if proxy:IsCompleteEvent( 4030 ) == false then
		if proxy:IsWhiteGhost() == true then
			proxy:LuaCallStartPlus( 4042, 1, proxy:GetLocalPlayerId() );
		else
			proxy:LuaCallStartPlus( 4042, 2, proxy:GetLocalPlayerId() );
			if	proxy:GetTempSummonParam() > 0 then
				proxy:LuaCallStartPlus( 4042, 5, proxy:GetLocalPlayerId() );
			end
		end
	else
		--PK�Ŏ��񂾏ꍇ���A�����������ꂽ�u���b�N�̏ꍇ�͋����������S�Ƃ��ăJ�E���g --EN:--Even if you die in PK, it counts as forced summon death if black is summoned forcibly.
		if	proxy:GetTempSummonParam() > 0 then
			proxy:LuaCallStartPlus( 4042, 2, proxy:GetLocalPlayerId() );
			proxy:LuaCallStartPlus( 4042, 5, proxy:GetLocalPlayerId() );			
		--�z���C�g�\�E�� --EN:--White Soul
		elseif	proxy:GetTempSummonParam() == -1 then
			proxy:LuaCallStartPlus( 4042, 1, proxy:GetLocalPlayerId() );
			proxy:LuaCallStartPlus( 4042, 4, proxy:GetLocalPlayerId() );			
		--�u���b�N�\�E�� --EN:--Black Soul
		elseif	proxy:GetTempSummonParam() == -2 then
			proxy:LuaCallStartPlus( 4042, 2, proxy:GetLocalPlayerId() );
			proxy:LuaCallStartPlus( 4042, 4, proxy:GetLocalPlayerId() );			
		--���� --EN:--Intrusion
		elseif	proxy:GetTempSummonParam() == -3 then
			proxy:LuaCallStartPlus( 4042, 6, proxy:GetLocalPlayerId() );
			proxy:LuaCallStartPlus( 4042, 4, proxy:GetLocalPlayerId() );			
		end
	end
	
	
	proxy:SetEventFlag(4000,true);
	
	print("PartyGhostDeath end");
end

function PartyGhostDeath_1(proxy,param)
	print("PartyGhostDeath_1 begin");
	
	if ClearBoss == false then
		--�ڕW���s --EN:--Target failed
		MissionDeadFailed(proxy,param);	
		proxy:NotNetMessage_begin();
			proxy:OnRequestMenuEnd(4000, "PartyGhostDeath_2");
		proxy:NotNetMessage_end();
	else
		--proxy:NotNetMessage_begin();
		--	proxy:OnKeyTime2( 4050 ,"BlockClear2_3" , 5.0 , 0 , 100 , once );
		--proxy:NotNetMessage_end();
	end
	
	print("PartyGhostDeath_1 end");
end



function PartyGhostDeath_2(proxy,param)
	print("PartyGhostDeath_2 begin");
	
	if ClearBoss == false then
		if proxy:IsCompleteEvent( 4030 ) == false then
			print("�f�X�y�i���e�B�I�I"); --EN:print("Death Penalty!!");
			--�\�E���y�i���e�B --EN:--Soul Penalty
			--proxy:DeathPenalty( DeathPenalty_SoulAdjust, DeathPenalty_SoulMAX );
				
			if	proxy:IsBlackGhost() == true then				
				--�������҂Ȃ� --EN:--Forcibly summoned
				if	proxy:GetTempSummonParam() > 0 then					
					--�������҈ȊO�̃u���b�N�Ȃ� --EN:--For blacks other than forced summons
				else
					--�y�i���e�B --EN:--penalty
					proxy:SetLeaveSoulSteel();
					print("�f�X�y�i���e�B�I�I"); --EN:print("Death Penalty!!");
				end
			end
		end
		--�����O�̈ʒu�ݒ� --EN:--Position settings before summoning
		proxy:SetSummonedPos();
		--���݂̃}�b�v�Ɠ���ID�����}�b�vID�Ƃ��Đݒ� --EN:--Set the same ID as the current map as the next map ID
		proxy:SetDefaultMapUid(-1);
		--���[�v���s�� --EN:--do warp
		proxy:WarpNextStageKick();
		--���S�񕜗v�� --EN:-- full recovery request
		--proxy:RequestFullRecover();
		--�O���C�S�[�X�g�� --EN:--Gray ghost
		--proxy:SetChrTypeDataGrey();
		proxy:SetChrTypeDataGreyNext();
	else
		--proxy:NotNetMessage_begin();
		--	proxy:OnKeyTime2( 4050 ,"BlockClear2_3" , 2.0 , 0 , 100 , once );
		--proxy:NotNetMessage_end();
	end
		
	print("PartyGhostDeath_2 end");
end


--��4042�����S�ʒm�� --EN:-- �� 4042 �� death notice ��
function DeadInfoMsg_White(proxy,param)
	print("DeadInfoMsg_White begin");
	--�����ȊO�̎� --EN:--Death other than yourself
	if param:IsNetMessage() == true then
		--�z�X�g --EN:--host
		if	proxy:IsGreyGhost() == true or proxy:IsLivePlayer() == true then
			if proxy:EventTagInsertString_forPlayerNo( TAG_IDX_deadChara, param:GetParam3() ) == true then
				proxy:RecallMenuEvent( 0, 8980 );
			end
		--��O�� --EN:--third party
		else
			if proxy:EventTagInsertString_forPlayerNo( TAG_IDX_deadChara, param:GetParam3() ) == true then
				--�z���C�g�\�E�� --EN:--White Soul
				if	proxy:GetTempSummonParam() == -1 then
					proxy:RecallMenuEvent( 0, 8983 );
				--�u���b�N�\�E�� --EN:--Black Soul
				elseif	proxy:GetTempSummonParam() == -2 then
					proxy:RecallMenuEvent( 0, 8984 );
				--���� --EN:--Intrusion
				elseif	proxy:GetTempSummonParam() == -3 then
					proxy:RecallMenuEvent( 0, 8985 );
				--�������� --EN:--forced summon
				elseif	proxy:GetTempSummonParam() >   0 then
					proxy:RecallMenuEvent( 0, 8986 );
				end
			else
				proxy:WARN("PCName�̃^�O�����ւ����s"); --EN:proxy:WARN("PCName tag replacement failure");
			end
		end		
	--���񂾂̂����� --EN:--I am the one who died
	else		
	end
	print("DeadInfoMsg_White end");
end

function DeadInfoMsg_Black(proxy,param)
	print("DeadInfoMsg_Black begin");
	--�����ȊO�̎� --EN:--Death other than yourself
	if param:IsNetMessage() == true then
		--�z�X�g --EN:--host
		if	proxy:IsGreyGhost() == true or proxy:IsLivePlayer() == true then
			if proxy:EventTagInsertString_forPlayerNo( TAG_IDX_deadChara, param:GetParam3() ) == true then
				proxy:RecallMenuEvent( 0, 8991 );
			end
		--��O�� --EN:--third party
		else
			if proxy:EventTagInsertString_forPlayerNo( TAG_IDX_deadChara, param:GetParam3() ) == true then
				--�z���C�g�\�E�� --EN:--White Soul
				if	proxy:GetTempSummonParam() == -1 then
					proxy:RecallMenuEvent( 0, 8993 );
				--�u���b�N�\�E�� --EN:--Black Soul
				elseif	proxy:GetTempSummonParam() == -2 then
					proxy:RecallMenuEvent( 0, 8994 );
				--���� --EN:--Intrusion
				elseif	proxy:GetTempSummonParam() == -3 then
					proxy:RecallMenuEvent( 0, 8995 );
				--�������� --EN:--forced summon
				elseif	proxy:GetTempSummonParam() >   0 then
					proxy:RecallMenuEvent( 0, 8996 );
				end
			else
				proxy:WARN("PCName�̃^�O�����ւ����s"); --EN:proxy:WARN("PCName tag replacement failure");
			end
		end		
	--���񂾂̂����� --EN:--I am the one who died
	else
		--�u���b�N�\�E�� --EN:--Black Soul
		if	proxy:GetTempSummonParam() == -2 then
			--proxy:RecallMenuEvent( 0, 9004 );
		--���� --EN:--Intrusion
		elseif	proxy:GetTempSummonParam() == -3 then
			--proxy:RecallMenuEvent( 0, 9005 );
		end		
	end
	print("DeadInfoMsg_Black end");
end

function DeadInfoMsg_Host(proxy,param)
	print("DeadInfoMsg_Host begin");
	if param:IsNetMessage() == true then		
	end
	print("DeadInfoMsg_Host end");
end

function DeadInfoMsg_ForceJoinBlack(proxy,param)
	print("DeadInfoMsg_ForceJoinBlack begin");
	--�����ȊO�̎� --EN:--Death other than yourself
	if param:IsNetMessage() == true then
		--�z�X�g --EN:--host
		if	proxy:IsGreyGhost() == true or proxy:IsLivePlayer() == true then
			if proxy:EventTagInsertString_forPlayerNo( TAG_IDX_deadChara, param:GetParam3() ) == true then
				proxy:RecallMenuEvent( 0, 8992 );
			end
		--��O�� --EN:--third party
		else
			if proxy:EventTagInsertString_forPlayerNo( TAG_IDX_deadChara, param:GetParam3() ) == true then
				--�z���C�g�\�E�� --EN:--White Soul
				if	proxy:GetTempSummonParam() == -1 then
					proxy:RecallMenuEvent( 0, 8993 );
				--�u���b�N�\�E�� --EN:--Black Soul
				elseif	proxy:GetTempSummonParam() == -2 then
					proxy:RecallMenuEvent( 0, 8994 );
				--���� --EN:--Intrusion
				elseif	proxy:GetTempSummonParam() == -3 then
					proxy:RecallMenuEvent( 0, 8995 );
				--�������� --EN:--forced summon
				elseif	proxy:GetTempSummonParam() >   0 then
					proxy:RecallMenuEvent( 0, 8996 );
				end
			else
				proxy:WARN("PCName�^�O�̍����ւ��Ɏ��s"); --EN:proxy:WARN("Failed to replace PCName tag");
			end
		end		
	--���񂾂̂����� --EN:--I am the one who died
	else
		--�u���b�N�\�E�� --EN:--Black Soul
		if	proxy:GetTempSummonParam() == -2 then
			--proxy:RecallMenuEvent( 0, 9004 );
		--���� --EN:--Intrusion
		elseif	proxy:GetTempSummonParam() == -3 then
			--proxy:RecallMenuEvent( 0, 9005 );
		end		
	end
	print("DeadInfoMsg_ForceJoinBlack end");
end


----------------------------------------------------------------------------------------------------------------
--��4030��PK������ --EN:-- �� 4030 �� PK revival ��
----------------------------------------------------------------------------------------------------------------
--param2:�E���ꂽ�l��PlayerNo --EN:--param2: PlayerNo of the killed person
--param3:�E�����l��PlayerNo --EN:--param3: PlayerNo of the killer
function PlayerKill_4030_sub( proxy,param)
	local nDeadPlayerNo = proxy:VariableExpand_22_param1( param:GetParam2() );
	local nKillPlayerNo = proxy:VariableExpand_22_param2( param:GetParam2() );
	local nDeadPlayerSummonParam = param:GetParam3();--���񂾃v���C���̏������ꂽ�^�C�v --EN:--summoned type of dead player
	local nThisPlayerNo = proxy:GetLocalPlayerId();
	local nThisSummonParam = proxy:GetTempSummonParam();
	if	nThisPlayerNo == nKillPlayerNo then
		--�E�����l�����߂čĔz�M(�E�����l�̏����^�C�v���擾�����) --EN:--The person who killed is re-delivered (to get the summoning type of the person who killed)
		local nOrderParam = proxy:VariableOrder_22( nDeadPlayerSummonParam, nThisSummonParam );
		proxy:CustomLuaCallStartPlus( 4030, param:GetParam2(), nOrderParam );
		--proxy:SetEventFlag( 4030, true );
	end
end

function PlayerKill_4030(proxy, param)
	print("PlayerKill_4030 begin");
	local nDeadPlayerNo			 = proxy:VariableExpand_22_param1( param:GetParam2() );
	local nKillPlayerNo 		 = proxy:VariableExpand_22_param2( param:GetParam2() );
	local nDeadPlayerSummonParam = proxy:VariableExpand_22_param1( param:GetParam3() );--���񂾐l�̏����^�C�v --EN:-- dead person summon type
	local nKillPlayerSummonParam = proxy:VariableExpand_22_param2( param:GetParam3() );--�E�����l�̏����^�C�v --EN:-- Summon type of the person who killed
	local nThisPlayerNo			 = proxy:GetLocalPlayerId();
	local nHostNo				 = proxy:GetHostPlayerNo();
	
	print("nDeadPlayerNo = ",nDeadPlayerNo);
	print("nKillPlayerNo = ",nKillPlayerNo);
	print("nDeadPlayerSummonParam = ",nDeadPlayerSummonParam);
	print("nKillPlayerSummonParam = ",nKillPlayerSummonParam)
	print("nThisPlayerNo = ",nThisPlayerNo);
	print("nHostNo = ",nHostNo);
	
	local IsHostDead;
	if nHostNo == nDeadPlayerNo then
		IsHostDead = true;
	else
		IsHostDead = false;
	end
	local IsWhite		= proxy:IsWhiteGhost();
	local IsBlack		= proxy:IsBlackGhost();
	
	--�p��ŏ����Ɠǂ߂Ȃ������̂ŁA���[�}���ő�p --EN:--I couldn't read it when I wrote it in English, so I used romaji instead.
	print( "PlayerNo:<",nDeadPlayerNo, "> ga ","PlayerNo:<",nKillPlayerNo, "> ni korosareta" );
	print( "LocalPlayerNo:<",nThisPlayerNo, "> LocalPlayerType<",proxy:GetLocalPlayerChrType(), ">");
	print( "HostNo<",nHostNo,">IsHostDead<",IsHostDead,">IsWhite<",IsWhite,">IsBlack<",IsBlack,">")
	
	
	if proxy:IsCompleteEvent( 4047 ) == true then
		print("EventFlag4047 is true return");
		return;
	end
	
	--���񂾂̂������ł͂Ȃ��� --EN:--When you're not the one who died
	if nThisPlayerNo ~= nDeadPlayerNo then
		--�u���b�N���������E���� --EN:-- Black killed survival
		if IsHostDead == true and nThisPlayerNo == nKillPlayerNo and IsBlack == true then
			print("�z�X�gPK�@QWC�@black > host"); --EN:print("Host PK QWC black > host");
			proxy:LuaCallStartPlus( 4056, 1, 210 );--AddQWC�z�M(�}���`�Ńz�X�g���E����QWC���Z) --EN:--AddQWC distribution (QWC addition that killed the host in multi)
		end
		
		--�z���C�g���������E���� --EN:--white killed survival
		if IsHostDead == true and nThisPlayerNo == nKillPlayerNo and IsWhite == true then			
			print("�s�\�ƍ߁@white > host"); --EN:print("Impossible crime white > host");
			proxy:LuaCallStartPlus( 4056, 1, 210 );--AddQWC�z�M(�}���`�Ńz�X�g���E����QWC���Z) --EN:--AddQWC distribution (QWC addition that killed the host in multi)
		end
		
		--�����ȊO���������E���� --EN:--other than myself killed survival
		if IsHostDead == true and nThisPlayerNo ~= nKillPlayerNo then
		end
		
		--�����ȊO�������ȊO���E���� --EN:--other than myself killed other than survival
		if IsHostDead == false and nThisPlayerNo ~= nKillPlayerNo then			
		end
		
		--�����������ȊO���E���� --EN:--I killed someone other than survival
		if IsHostDead == false and nThisPlayerNo == nKillPlayerNo then
			print("�����������ȊO���E����");			 --EN:print("I killed a non-survivor");
			print("NetChrType = ",proxy:GetNetPlayerChrType(nDeadPlayerNo) );
			--�z���C�g���E���� --EN:--killed white
			if	proxy:IsWhiteGhost_NetPlayer(nDeadPlayerNo) == true then
				print("�z���C�g�E��QWC");				 --EN:print("White killing QWC");
				proxy:LuaCallStartPlus( 4056, 1, 220 );--AddQWC�z�M(�}���`�Ńz���C�g���E����QWC���Z) --EN:--AddQWC delivery (QWC addition that killed white in multiplayer)
			--�u���b�N���E���� --EN:--Killed Black
			elseif	proxy:IsBlackGhost_NetPlayer(nDeadPlayerNo) == true then
				print("�u���b�N�E��QWC"); --EN:print("Black killing QWC");
				--�����̂݃e�L�X�g���o��\�� --EN:-- Show survival only text rendition
				if	IsWhite == false then
					proxy:SetTextEffect( TEXT_TYPE_BlackClear );
					proxy:NotNetMessage_begin();
						proxy:OnTextEffectEndPlus(4059, TEXT_TYPE_BlackClear, nDeadPlayerSummonParam,"TextEffectEnd_BlackPK_Success");
					proxy:NotNetMessage_end();
				end
				proxy:LuaCallStartPlus( 4056, 1, 230 );--AddQWC�z�M(�}���`�Ńu���b�N���E����QWC���Z) --EN:--AddQWC distribution (QWC addition that killed black in multiplayer)
				proxy:AddKillBlackGhost();--�E�����u���b�N�̐������Z				 --EN:--add the number of blacks killed
			end
			
			print("NetChrSummonParam = ",nDeadPlayerSummonParam );
			print("nDeadPlayerNo = ",nDeadPlayerNo);
			--�z���C�g�\�E�� --EN:--White Soul
			if		nDeadPlayerSummonParam == -1 then
				if nKillPlayerSummonParam == -3 then
					print("�����u���b�N���z���C�g�E�Q�{�[�i�X"); --EN:print("Intrusion Black > White Kill Bonus");
					proxy:SoulPenaltyPK2(nDeadPlayerNo,-0.5);
				end
			--�u���b�N�\�E�� --EN:--Black Soul
			elseif	nDeadPlayerSummonParam == -2 then
			--���� --EN:--Intrusion
			elseif	nDeadPlayerSummonParam == -3 then
				--if proxy:IsClient() == false then
					print("�����u���b�N�E�Q�{�[�i�X") --EN:print("Burst Black kill bonus")
					--proxy:SoulPenaltyPK( -PK_Soul_Penalty_FIX, -PK_Soul_Penalty_BASE, PK_Soul_Penalty_MAX, PK_Soul_Penalty_Adjust );
					proxy:SoulPenaltyPK2(nDeadPlayerNo,-0.5);
				--end
			--�������� --EN:--forced summon
			elseif	nDeadPlayerSummonParam  >  0 then			
			end
		end
	--���񂾂̂������̎� --EN:--When I died
	else
		print("PlayerKill_4030 ThisDead");
		proxy:SetEventFlag( 4030, true );
		--���񂾂̂��z�X�g --EN:--the host is dead
		if	proxy:IsLivePlayer() == true or proxy:IsGreyGhost() == true then
			print("PlayerKill_4030 LiveDead");
			--�ʏ�u���b�N�ɎE���ꂽ --EN:--usually killed by Black
			if	nKillPlayerSummonParam ==  -2 then
				print("SoulSteel Black -> Host");
				--�\�E���X�e�B�[�� --EN:--Soul Steel
				proxy:SetEventSpecialEffectOwner_2( nKillPlayerNo + 10001, LOCAL_PLAYER, 13 );
			--�����u���b�N�ɎE���ꂽ --EN:--Killed by Intruder Black
			elseif	nKillPlayerSummonParam ==  -3 then
				--�ʏ�̎��S�̂� --EN:--normal death only
			end
		end
		
		--�z���C�g�\�E�� --EN:--White Soul
		if		proxy:GetTempSummonParam() == -1 then
			print("PlayerKill_4030 WhiteDead");
			--�ʏ�u���b�N�ɎE���ꂽ --EN:--usually killed by Black
			if		nKillPlayerSummonParam ==  -2 then
				print("PKPenalty");
				--PK�̃\�E���y�i���e�B --EN:--PK Soul Penalty
				--proxy:SoulPenaltyPK( PK_Soul_Penalty_FIX, PK_Soul_Penalty_BASE, PK_Soul_Penalty_MAX, PK_Soul_Penalty_Adjust );
				--proxy:SoulPenaltyPK2(nDeadPlayerNo,0.5);
				--�\�E���X�e�B�[�� --EN:--Soul Steel
				proxy:SetEventSpecialEffectOwner_2( nKillPlayerNo + 10001, LOCAL_PLAYER, 13 );
			--�����u���b�N�ɎE���ꂽ --EN:--Killed by Intruder Black
			elseif	nKillPlayerSummonParam ==  -3 then
				print("PKPenalty");
				--PK�̃\�E���y�i���e�B --EN:--PK Soul Penalty
				--proxy:SoulPenaltyPK( PK_Soul_Penalty_FIX, PK_Soul_Penalty_BASE, PK_Soul_Penalty_MAX, PK_Soul_Penalty_Adjust );
				proxy:SoulPenaltyPK2(nDeadPlayerNo,0.5);
			end			
		--�u���b�N�\�E�� --EN:--Black Soul
		elseif	proxy:GetTempSummonParam() == -2 then
			print("PlayerKill_4030 BlackDead");
			--����or�z���C�g�ɎE���ꂽ --EN:--Alive or killed by White
			if	nKillPlayerSummonParam ==  0 or
				nKillPlayerSummonParam == -1 then
				print("SoulSteel Live or White -> Black");
				--�\�E���X�e�B�[�� --EN:--Soul Steel
				proxy:SetEventSpecialEffectOwner_2( nKillPlayerNo + 10001, LOCAL_PLAYER, 13 );
			end
		--���� --EN:--Intrusion
		elseif	proxy:GetTempSummonParam() == -3 then
			print("PlayerKill_4030 ForceJoinDead");
			--�����ɎE���ꂽ --EN:--Killed to Survival
			if	nKillPlayerSummonParam ==  0 then
				print("PKPenalty");
				proxy:SoulPenaltyPK2(nDeadPlayerNo,0.5);
			end
			--�z���C�g�ɎE���ꂽ --EN:--Killed by White
			if	nKillPlayerSummonParam == -1 then
				print("PKPenalty");
				--PK�̃\�E���y�i���e�B --EN:--PK Soul Penalty
				--proxy:SoulPenaltyPK( PK_Soul_Penalty_FIX, PK_Soul_Penalty_BASE, PK_Soul_Penalty_MAX, PK_Soul_Penalty_Adjust );				
				proxy:SoulPenaltyPK2(nDeadPlayerNo,0.5);
			end
		end
	end
	
	print("PlayerKill_4030 end");
end

function PlayerKill_4030_1(proxy, param)
	print("PlayerKill_4030_1 begin");
	
	--�t���O�����[���o�b�N���܂��B --EN:-- rollback flag.
	proxy:SetFlagInitState(2);
	
	--��������̂Ńy�i���e�B�Ō��������p�����[�^�����ɖ߂�(�ő�l�̂�) --EN:--Since it will be revived, restore the parameters that have been reduced by the penalty (maximum value only)
	proxy:EraseEventSpecialEffect( 10000, 101 );
	--proxy:PlayerParamRecover();
	
	--���O���C�Ȃ畜�� --EN:-- Resurrection if ex-gray
	if proxy:IsPrevGreyGhost() == true then
		--��������̂ŕ����A�j���t���O���Z�b�g --EN:-- Set the resurrection animation flag because it will be revived
		proxy:SetAliveMotion( true );
	end
	
	--HpMpSp�����S�� --EN:--Full recovery of HpMpSp
	--proxy:PlayerRecover();
	
	--������Ԃɐݒ肵����ŁA�����̌������ʒu�փ��[�v --EN:--Warp to your blood letter position after setting it to a living state
	--proxy:WarpSelfBloodMark(false);
	proxy:SetSelfBloodMapUid();
	--proxy:RevivePlayer();
	proxy:RevivePlayerNext();--���̃��[�h�őh�� --EN:--Respawn on next load
	proxy:RequestFullRecover();
	proxy:WarpNextStageKick();
	
	print("PlayerKill_4030_1 end");
end

----------------------------------------------------------------------------------------------------------------
--��4059���e�L�X�g���o�I���� --EN:-- �� 4059 �� After the text effect
----------------------------------------------------------------------------------------------------------------
--�i�u���b�N���������E�����jPK�ɐ����������̃e�L�X�g���o�I���� --EN:-- At the end of the text effect when the PK was successful (Black killed the survival)
--���Ҏ҂�|�����e�L�X�g���o�\���� --EN:--After displaying the text effect of defeating the summoner
function TextEffectEnd_PK_Success(proxy,param)
	print("TextEffectEnd_PK_Success begin");
	proxy:NotNetMessage_begin();
		proxy:OnRequestMenuEnd( 4059, "RequestMenuEnd_PK_Sucess" );
	proxy:NotNetMessage_end();
	
--[[
	--�u���b�N�\�E�� --EN:--Black Soul
	if	proxy:GetTempSummonParam()		== -2 then
		proxy:RecallMenuEvent( 0, 8914 );
	--���� --EN:--Intrusion
	elseif	proxy:GetTempSummonParam()	== -3 then
		proxy:RecallMenuEvent( 0, 8915 );
	end
]]

	--���������u���b�N���ڕW�B���������̓^�[�o���������A�� --EN:-- Bring back the turban when the forced summon black achieves the goal
	--local tmpSummonParam = proxy:GetTempSummonParam();
	--print("���҃p�����[�^:",tmpSummonParam); --EN:--print("Summon Parameter:",tmpSummonParam);
	--if	proxy:GetTempSummonParam() > 0 then
	if IsForceSummon == true then
		print("�^�[�o���C�x���g����"); --EN:print("Turban event triggered");
		proxy:GetRateItem(16581);
	end
	
	--�ڕW�B�� --EN:--Goal achievement
	MissionSuccessed(proxy,param);

	print("TextEffectEnd_PK_Success end");
end

--�i�u���b�N���������E�����jPK�ɐ����������̗v�����j���[�I���� --EN:-- At the end of the request menu when the PK was successful (Black killed the survival)
function RequestMenuEnd_PK_Sucess(proxy,param)
	print("RequestMenuEnd_PK_Sucess begin");
	
	--PK�����C�x���g�J�n --EN:--PK revival event started
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 4030, "PlayerKill_4030_1", 2.0, 0, 3, once );
	proxy:NotNetMessage_end();
	
	print("RequestMenuEnd_PK_Sucess end");
end

--�i�����E�z���C�g���u���b�N���E�����jPK�ɐ����������̃e�L�X�g���o�I���� --EN:--(Survival/White killed Black) At the end of the text effect when the PK was successful
--�u���b�N���j�e�L�X�g���o�\���� --EN:--After displaying the black kill text effect
function TextEffectEnd_BlackPK_Success(proxy,param)
	print("TextEffectEnd_BlackPK_Success begin");
	local nDeadPlayerSummonParam = param:GetParam3();
	print("TextEffectEnd_BlackPK_Success nDeadPlayerSummonParam = ", nDeadPlayerSummonParam);
--[[
	if		nDeadPlayerSummonParam == -2 then
		proxy:RecallMenuEvent( 0, 8971 );
	elseif	nDeadPlayerSummonParam == -3 then
		proxy:RecallMenuEvent( 0, 8972 );
	end
]]
	print("TextEffectEnd_BlackPK_Success end");
end



----------------------------------------------------------------------------------------------------------------
--��4032�������̌����������� --EN:-- �� 4032 �� Resurrection of own blood letter ��
----------------------------------------------------------------------------------------------------------------
function SelfBloodMark(proxy, param)
	print("SelfBloodMark begin");
	
	--�����̌����������́u�ēǂݍ��݂�ʂ��Ȃ��v�̂ŏ������X�L�b�v�̂� --EN:--Your own blood letter revival "cannot be reloaded", so only initialization skip
	--proxy:SetFlagInitState(1);
	
	--�V�X�e�����b�Z�[�W	 --EN:--system message
	proxy:SetTextEffect(TEXT_TYPE_SoulGet);		
	
	--��������̂Ńy�i���e�B�Ō��������p�����[�^�����ɖ߂�(�ő�l�̂�) --EN:--Since it will be revived, restore the parameters that have been reduced by the penalty (maximum value only)
	--proxy:EraseEventSpecialEffect( 10000, 101 );
	--proxy:PlayerParamRecover();
	--proxy:ResetEventQwcSpEffect(LOCAL_PLAYER);	
	--�L�����N�^�̃^�C�v�𐶑��ɕύX(�ēǂݍ��݂�ʂ��Ȃ��ׁA����ŉ��Ή�)���K�̓v���C���[��p�̐����^�C�v�ݒ胁�\�b�h�őΉ� --EN:-- Change the character type to survival (temporary correspondence because it does not pass through reloading) Normal is supported by the player-only survival type setting method
	--proxy:SetChrType( 10000, 0 );

	--�����̌�������\�� --EN:--Hide own blood letters
	proxy:InvalidMyBloodMarkInfo();
	
	--�p�j�f�[�������A�p�C�x���g�n���h�� --EN:--Event handler for wandering daemon return
	proxy:LuaCallStart( 4032, 100 );
	
	print("SelfBloodMark end");
end


----------------------------------------------------------------------------------------------------------------
--��4033���Z�b�V�����؂ꁡ --EN:--��4033��Session expired��
----------------------------------------------------------------------------------------------------------------
function OnIrregularLeaveSession(proxy,param)
	print("OnIrregularLeaveSession begin");

	proxy:NotNetMessage_begin();
		--��4033��0.1�b��(�Z�b�V�����؂�^�C�~���O��������) --EN:--��4033��0.1 seconds later (because the session expires early)
		proxy:OnKeyTime2( 4033, "OnIrregularLeaveSession_1", 0.1, 0, 1, once );
		--���̍ēǂݍ��݌n�C�x���g�̊��荞�݂�h�~ --EN:--Prevent interruption of other reloading events
	proxy:NotNetMessage_end();
	
	print("OnIrregularLeaveSession end");
end

function OnIrregularLeaveSession_1(proxy,param)
	print("OnIrregularLeaveSession_1 begin");
	--�N���C�A���g�Ŗ����Ȃ�@�V���O���@or�@�z�X�g --EN:-- Single or host if not a client
	--if	proxy:IsClient() == false then
	--���̎��_�ł͂��Ȃ炸IsClient��false���A��I --EN:--At this point, IsClient always returns false!
	if proxy:IsLivePlayer() == true or proxy:IsGreyGhost() == true then
		return;
	end
	if proxy:IsCompleteEvent( 4047 ) == true then
		print("EventFlag4047 is true return");
		return;
	end
	--���̍ēǂݍ��݌n�C�x���g�̊��荞�݂�h�~ --EN:--Prevent interruption of other reloading events
	proxy:SetEventFlag(4047, true);
	--�C�x���g�����ɂ����[�h�҂��ł��鎖��ʒm --EN:-- Notify that it is waiting for loading inside the event
	proxy:SetLoadWait();
	--���[�����Ȃ��Ȃ������O --EN:--log of missing rooms
	proxy:InfomationMenu( INFOMENU_TYPE_LIST, -1, 0, -1, 1 );
	proxy:AddInfomationTosBuffer( 20001001 );
	
	--�C�x���g�t���O���[���o�b�N --EN:--eventflag rollback
	proxy:SetFlagInitState(2);
	
	proxy:NotNetMessage_begin();
		--��4046��5�b�� --EN:-- �� 4046 �� 5 seconds later
		proxy:OnKeyTime2( 4046, "OnLeave_Limit", 5.0, 0, 2, once );
	proxy:NotNetMessage_end();
	print("OnIrregularLeaveSession_1 end");
end


----------------------------------------------------------------------------------------------------------------
--��4036��SOS�ʒu�Ƀ��[�v���z���C�g�����ʒu�p --EN:-- �� Warp to 4036 �� SOS position �� For white summon position
----------------------------------------------------------------------------------------------------------------
function WarpSosPos(proxy,param)
	print("WarpSosPos begin");
	print("WarpSosPos end");
end

----------------------------------------------------------------------------------------------------------------
--��4037���~�j�u���b�N�̓��Ƀ��[�v���u���b�N�����ʒu�p --EN:-- �� 4037 �� Warp to the head of the mini block �� For black summon position
----------------------------------------------------------------------------------------------------------------
function WarpMiniblockPos(proxy,param)
	print("WarpMiniblockPos begin");
	--���������̏ꍇ�A�z�X�g�̃v���C�̈�ɍ��킹�� --EN:--In the case of forced summoning, match the play area of the host
	if	proxy:IsForceSummoned() == true then
		--proxy:SetHostMiniBlockIndex();
	end
	--proxy:WarpMiniBlock();
	print("WarpMiniblockPos end");
end


function OnServerError_Maintenance(proxy,param)
	print("OnServerError_Maintenance begin");
	if proxy:IsCompleteEvent( 4047 ) == true then
		return;
	end	
	proxy:InfomationMenu(INFOMENU_TYPE_LIST,-1,0,-1,1);
	proxy:AddInfomationTosBufferPlus(51200,MSG_CATEGORY_DIALOG);
	--�^�C�g���ɖ߂鏈�� --EN:-- Processing to return to the title
	proxy:WARN("�f�����Y�T�[�o�����e�i���X��"); --EN:proxy:WARN("demons server under maintenance");
	RegistReturnTitle(proxy,param);
	print("OnServerError_Maintenance end");
end

function OnServerError_ServiceStop(proxy,param)
	print("OnServerError_ServiceStop begin");
	if proxy:IsCompleteEvent( 4047 ) == true then
		return;
	end
	proxy:InfomationMenu(INFOMENU_TYPE_LIST,-1,0,-1,1);
	proxy:AddInfomationTosBufferPlus(51201,MSG_CATEGORY_DIALOG);
	--�^�C�g���ɖ߂鏈�� --EN:-- Processing to return to the title
	proxy:WARN("�f�����Y�T�[�o�̃T�[�r�X���ԊO"); --EN:proxy:WARN("Demon's server is out of service period");
	RegistReturnTitle(proxy,param);
	print("OnServerError_ServiceStop end");
end

function OnServerError_TimeOut(proxy,param)
	print("OnServerError_TimeOut begin");
	if proxy:IsCompleteEvent( 4047 ) == true then
		return;
	end
	proxy:InfomationMenu(INFOMENU_TYPE_LIST,-1,0,-1,1);
	proxy:AddInfomationTosBufferPlus(51300,MSG_CATEGORY_DIALOG);
	--�^�C�g���ɖ߂鏈�� --EN:-- Processing to return to the title
	proxy:WARN("�T�[�o����̉���������"); --EN:proxy:WARN("No response from server");
	RegistReturnTitle(proxy,param);
	print("OnServerError_TimeOut end");
end

function OnSummonResult_Empty(proxy,param)
	print("OnResultEmpty begin");
	proxy:InfomationMenu(INFOMENU_TYPE_LIST,-1,0,-1,1);
	proxy:AddInfomationTosBuffer(20000105);
	print("OnResultEmpty end");
end

function OnSummonResult_Move(proxy,param)
	print("OnSummonResult_Move begin");
	proxy:InfomationMenu(INFOMENU_TYPE_LIST,-1,0,-1,1);
	proxy:AddInfomationTosBuffer(20000110);
	print("OnSummonResult_Move end");
end

function OnSummonResult_TimeOut(proxy,param)
	print("OnSummonResult_TimeOut begin");
	proxy:InfomationMenu(INFOMENU_TYPE_LIST,-1,0,-1,1);
	proxy:AddInfomationTosBuffer(20000100);
	print("OnSummonResult_TimeOut end");
end

function OnSummonResult_OtherError(proxy,param)
	--�n���h�����O���� --EN:--No handling
end

----------------------------------------------------------------------------------------------------------------
--��4038���Z�b�V�������Ď��� --EN:--��4038��Session information monitoring��
----------------------------------------------------------------------------------------------------------------
function OnEvent_4038(proxy,param)
	print("OnEvent_4038 begin");
	local info = param:GetParam2();
	
	--SummonResult�֘A --EN:--SummonResult related
--~ 	if info == 1 then--���ɏ�������Ă��� --EN:--already summoned
--~ 		proxy:InfomationMenu(INFOMENU_TYPE_LIST,-1,0,-1,1);
--~ 		proxy:AddInfomationTosBuffer(20000105);
--~ 	elseif info == 2 then--�ʃu���b�N�Ɉړ����Ă��� --EN:--moving to another block
--~ 		proxy:InfomationMenu(INFOMENU_TYPE_LIST,-1,0,-1,1);
--~ 		proxy:AddInfomationTosBuffer(20000110);
--~ 	elseif info == 3 then--�^�C���A�E�g���Ă��� --EN:--timed out
--~ 		proxy:InfomationMenu(INFOMENU_TYPE_LIST,-1,0,-1,1);
--~ 		proxy:AddInfomationTosBuffer(20000100);
--~ 	--elseif info == 4 then--���̑��Ŏ��s	 --EN:--other fail
--~ 	end
	
	--NetworkError�֘A --EN:--NetworkError related
--~ 	if info == 11 then--�f�����Y�T�[�o�����e�i���X�� --EN:--demons server maintenance
--~ 		if proxy:IsCompleteEvent( 4047 ) == true then
--~ 			return;
--~ 		end	
--~ 		proxy:InfomationMenu(INFOMENU_TYPE_LIST,-1,0,-1,1);
--~ 		proxy:AddInfomationTosBufferPlus(51200,MSG_CATEGORY_DIALOG);
--~ 		--�^�C�g���ɖ߂鏈�� --EN:-- Processing to return to the title
--~ 		proxy:WARN("�f�����Y�T�[�o�����e�i���X��"); --EN:--~ proxy:WARN("demons server under maintenance");
--~ 		RegistReturnTitle(proxy,param);
--~ 	elseif info == 12 then--�f�����Y�T�[�o�̃T�[�r�X���ԊO --EN:--Out of Demon's server service period
--~ 		if proxy:IsCompleteEvent( 4047 ) == true then
--~ 			return;
--~ 		end
--~ 		proxy:InfomationMenu(INFOMENU_TYPE_LIST,-1,0,-1,1);
--~ 		proxy:AddInfomationTosBufferPlus(51201,MSG_CATEGORY_DIALOG);
--~ 		--�^�C�g���ɖ߂鏈�� --EN:-- Processing to return to the title
--~ 		proxy:WARN("�f�����Y�T�[�o�̃T�[�r�X���ԊO"); --EN:--~ proxy:WARN("Demon's server is out of service period");
--~ 		RegistReturnTitle(proxy,param);
--~ 	elseif info == 13 then--�T�[�o����̉����������i���񐔈ȏ�A���Ń^�C���A�E�g�����j --EN:--There is no response from the server (timeout occurs more than a certain number of times)
--~ 		if proxy:IsCompleteEvent( 4047 ) == true then
--~ 			return;
--~ 		end
--~ 		proxy:InfomationMenu(INFOMENU_TYPE_LIST,-1,0,-1,1);
--~ 		proxy:AddInfomationTosBufferPlus(51300,MSG_CATEGORY_DIALOG);
--~ 		--�^�C�g���ɖ߂鏈�� --EN:-- Processing to return to the title
--~ 		proxy:WARN("�T�[�o����̉���������"); --EN:--~ proxy:WARN("No response from server");
--~ 		RegistReturnTitle(proxy,param);
--~ 	end
	
	--ForceSummonResult�֘A --EN:--ForceSummonResult related
	if	info == 20 then--���� --EN:--success
		ForceSummonSuccess(proxy,param);
	elseif	info == 21 then--SOS������ --EN:--No SOS
		ForceSummonFail(proxy,param);
	elseif	info == 22 then--�ʃu���b�N�ֈړ� --EN:--Move to another block
		ForceSummonFail(proxy,param);
	elseif	info == 23 then--�^�C���A�E�g --EN:--time out
		ForceSummonFail(proxy,param);
	elseif	info == 24 then--���̑��Ŏ��s --EN:--other fail
		ForceSummonFail(proxy,param);
	end
	
	print("OnEvent_4038 end");
end


--�����������s --EN:--forced summon failure
function ForceSummonFail(proxy,param)
	print("ForceSummonFail begin");
	if	proxy:IsClient() == false then
		OnEvent_1090(proxy,param);
	end
	
	proxy:DeleteEvent( 1090 );
	proxy:SetEventFlag( 1090, true );
	
	print("ForceSummonFail end");
end

--������������ --EN:--Successfully summoned
function ForceSummonSuccess(proxy,param)
	print("ForceSummonSuccess begin");
	print("ForceSummonSuccess end");
end

----------------------------------------------------------------------------------------------------------------
--��4050���u���b�N�N���A2�����K�� --EN:-- �� 4050 �� Block clear 2 �� regular version
----------------------------------------------------------------------------------------------------------------
function BlockClear2(proxy,param)	
	--�����̂� --EN:--only me
	if param:IsNetMessage() == true then
		return;
	end
	--�������҂ɃN���A�͗��Ȃ� --EN:--There is no clear for forced summons
	if	proxy:GetTempSummonParam() >   0 then
		return;
	end
--~ 	if proxy:IsCompleteEvent( 4047 ) == true then
--~ 		return;
--~ 	end
--~ 	if proxy:IsCompleteEvent( 4000 ) == true then
--~ 		return;		
--~ 	end
	print("BlockClear2 begin");	
	ClearBossId = -1;
	ClearBossId = param:GetParam2();
	
	--����or�O���C�@�ǂ�����Y�������Ȃ疳�G --EN:-- Survival or Gray Invincible if neither applies
	--if proxy:IsLivePlayer() == false and proxy:IsGreyGhost() == false then
		--���S���G�ݒ�(�z�M�K�v���낤���H) --EN:--Completely invincible setting (Is it necessary to stream?)
		--proxy:EnableInvincible( 10000,true);
	--end
	
	--(�z�X�g�̂��߂�)�z���C�g�h���J�E���g�AQWC���Z�p�̃n���h�����Ă� --EN:--(for host) call handler for white revive count, QWC addition
	if	proxy:IsWhiteGhost() == true then
		proxy:LuaCallStart( 4055, 1 );
	end
	
	--SOS�T�C������x�N���A --EN:--clear the SOS sign once
	proxy:ClearSosSign();
	
	--�Z�b�V���������L�� --EN:-- remember number of sessions
	proxy:SetClearSesiionCount();
	
	--�{�X�Q�[�W���N���A --EN:--clear the boss gauge
	proxy:ClearBossGauge();	

	--�l�b�g���[�N�̃��b�N --EN:--network lock
	proxy:LockSession();
	
	--�N���A�{�[�i�X���v�Z --EN:-- Calculate clear bonus
	proxy:SetClearBonus(ClearBossId);
	
	--������ --EN:--Alive
	if proxy:IsLivePlayer() == true then		
		proxy:SetTextEffect(TEXT_TYPE_KillDemon);		
		--���̍ēǂݍ��݌n�C�x���g�̊��荞�݂�h�~ --EN:--Prevent interruption of other reloading events
		proxy:SetEventFlag(4047, true);		
		--���S�����܂��Ă�₱�����Ȃ�Ȃ��l�ɂ��� --EN:--Don't let death get in the way of complications
		proxy:SetEventFlag( 4000, true );
	--�O���C�� --EN:--Gray time
	elseif proxy:IsGreyGhost() == true then		
		proxy:SetTextEffect(TEXT_TYPE_KillDemon);
		proxy:SetTextEffect(TEXT_TYPE_Revival);
		proxy:SetReviveWait( true );--�����҂���ԃt���O�����Ă���(�O���C�Ŕ������Ă��܂������̈�) --EN:--Insert a resurrection waiting state flag (for when you get out of the gray)
		--���̍ēǂݍ��݌n�C�x���g�̊��荞�݂�h�~ --EN:--Prevent interruption of other reloading events
		proxy:SetEventFlag(4047, true);		
		--���S�����܂��Ă�₱�����Ȃ�Ȃ��l�ɂ��� --EN:--Don't let death get in the way of complications
		proxy:SetEventFlag( 4000, true );
		--�O���C�ł��̏�Ŏ��񂾂Ƃ��͐����Ԃ��悤�ɂ��Ă��� --EN:--If you die here in Gray, make sure you can come back to life
		proxy:SetEventFlag( 4067, true );
	--�z���C�g�S�[�X�g�� --EN:-- White ghost
	elseif proxy:IsWhiteGhost() == true then
		ClearBoss = true;
		proxy:SetTextEffect(TEXT_TYPE_KillDemon);		
		--���̍ēǂݍ��݌n�C�x���g�̊��荞�݂�h�~ --EN:--Prevent interruption of other reloading events
		proxy:SetEventFlag(4047, true);
		--�C�x���g�����ɂ����[�h�҂��ł��鎖��ʒm --EN:-- Notify that it is waiting for loading inside the event
		proxy:SetLoadWait();		
		--���S�����܂��Ă�₱�����Ȃ�Ȃ��l�ɂ��� --EN:--Don't let death get in the way of complications
		proxy:SetEventFlag( 4000, true );
	--�u���b�N�S�[�X�g�� --EN:--During black ghost
	elseif proxy:IsBlackGhost() == true then
		--�����̃v���C���[ID��z�M���ăQ�[���I�ɔ����鎖��ʒm --EN:--Distribute your player ID and notify that you are leaving the game
		proxy:CustomLuaCallStart( 4063 , proxy:GetLocalPlayerId() );
		--�ڕW���s --EN:--Target failed
		MissionFailed(proxy,param);		
		--���̍ēǂݍ��݌n�C�x���g�̊��荞�݂�h�~ --EN:--Prevent interruption of other reloading events
		proxy:SetEventFlag(4047, true);
		--�C�x���g�����ɂ����[�h�҂��ł��鎖��ʒm --EN:-- Notify that it is waiting for loading inside the event
		proxy:SetLoadWait();		
		--���S�����܂��Ă�₱�����Ȃ�Ȃ��l�ɂ��� --EN:--Don't let death get in the way of complications
		proxy:SetEventFlag( 4000, true );
		--�����]���Ɋ܂܂��̂Ő�ɔ����� --EN:-- Black is included in the evaluation, so exit first
		proxy:LeaveSession();
	end

	--�Z���N�g���j���[�}���J�n --EN:--Select menu suppression start
	if proxy:IsInParty_FriendMember() == true then
		proxy:SetSubMenuBrake( true );		
	end
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 4050, "BlockClear2_1", 5.0, 0, 2, once );
	proxy:NotNetMessage_end();
	
	--�����E�A�j������	 --EN:--Own world animation processing
	if proxy:IsWhiteGhost() == true or proxy:IsBlackGhost() == true then
		proxy:RepeatMessage_begin();
			proxy:NotNetMessage_begin();
				--�A�j���Đ��ׂ̈̎��L�����Ď� --EN:--Monitoring your character for animation playback
				proxy:OnRegistFunc( 4050 , "Check_BlockClearAnim","BlockClearAnim",20,once);
			proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();		
	end
	
	print("BlockClear2 end");
end

function BlockClear2_1(proxy,param)
	print("BlockClear2_1 begin");
	
	if proxy:IsInParty_FriendMember() == true then
		--������ or --�z���C�g�S�[�X�g�� or--�O���C�S�[�X�g�� --EN:--Alive or --White Ghost or--Gray Ghost
		if proxy:IsLivePlayer() == true or proxy:IsWhiteGhost() == true or proxy:IsGreyGhost() == true then		
			--����ɃO���C�S�[�X�g�̎����� --EN:--Furthermore, only when gray ghost
			if proxy:IsGreyGhost() == true then
				if proxy:IsAlive(10000) == true then
					--�߂ł������� --EN:--Happy revival
					proxy:RevivePlayer();
					proxy:SetReviveWait( false );--�����҂���ԃt���O�����낵�Ă��� --EN:--Put down the resurrection waiting state flag
				end
				proxy:SetEventFlag( 15112,true );
				proxy:SetEventFlag( 15113,true );
				proxy:SetEventFlag( 15114,true );
				proxy:SetEventFlag( 15115,true );
				
				proxy:SetEventFlag( 15116,true );
				proxy:SetEventFlag( 15117,true );
				proxy:SetEventFlag( 15118,true );
				proxy:SetEventFlag( 15119,true );	
				--��������̂Ńy�i���e�B�Ō��������p�����[�^�����ɖ߂�(�ő�l�̂�) --EN:--Since it will be revived, restore the parameters that have been reduced by the penalty (maximum value only)
				proxy:EraseEventSpecialEffect( 10000, 101 );
			end
			--�F�D�S�[�X�g�����[���ɋ������H�@--�z���C�g�͎������g�����邩����v�Ȃ͂��B --EN:--Was there a friendly ghost in the room? --White should be fine because she's there.
			--�z�X�g�͑��̃����o�[�𒲂ׂ錋�ʂɂȂ�͂��A�Ȃ̂ō�������PT��g��ł��鎞�̓X���[�����	 --EN:--The host should be the result of examining other members, so when you are in a PT with only black, you will be ignored
			--�]�����j���[ --EN:--Evaluation menu
			proxy:NotNetMessage_begin();
			proxy:RepeatMessage_begin();
				
				proxy:OnPlayerAssessMenu(4050,ClearBossId,"BlockClear2_2",once);
			proxy:RepeatMessage_end();
			proxy:NotNetMessage_end();			
		--�u���b�N�S�[�X�g�� --EN:--During black ghost
		elseif proxy:IsBlackGhost() == true then
			--�\�E���y�i���e�B --EN:--Soul Penalty
			proxy:DeathPenalty( DeathPenalty_SoulAdjust, DeathPenalty_SoulMAX );
			--�C�x���g�t���O���[���o�b�N --EN:--eventflag rollback
			proxy:SetFlagInitState(2);
			--�����O�̈ʒu�ݒ� --EN:--Position settings before summoning
			proxy:SetSummonedPos();			
			--���݂̃}�b�v�Ɠ���ID�����}�b�vID�Ƃ��Đݒ� --EN:--Set the same ID as the current map as the next map ID
			proxy:SetDefaultMapUid(-1);
			--���[�v���s�� --EN:--do warp
			proxy:WarpNextStageKick();
			--�O���C�S�[�X�g�� --EN:--Gray ghost
			--proxy:SetChrTypeDataGrey();
			proxy:SetChrTypeDataGreyNext();
		end		
	else
		if proxy:IsLivePlayer() == true then
			proxy:NotNetMessage_begin();
				proxy:OnKeyTime2( 4050, "SoloBlockClear", 3.0, 0, 6, once );
			proxy:NotNetMessage_end();			
		--�O���C�� --EN:--Gray time
		elseif proxy:IsGreyGhost() == true then
			if proxy:IsAlive( 10000 ) == true then
				--�߂ł������� --EN:--Happy revival
				proxy:RevivePlayer();
				proxy:SetReviveWait( false );--�����҂���ԃt���O�����낵�Ă��� --EN:--Put down the resurrection waiting state flag
			end
			proxy:SetEventFlag( 15112,true );
			proxy:SetEventFlag( 15113,true );
			proxy:SetEventFlag( 15114,true );
			proxy:SetEventFlag( 15115,true );
			
			proxy:SetEventFlag( 15116,true );
			proxy:SetEventFlag( 15117,true );
			proxy:SetEventFlag( 15118,true );
			proxy:SetEventFlag( 15119,true );
			
			--��������̂Ńy�i���e�B�Ō��������p�����[�^�����ɖ߂�(�ő�l�̂�) --EN:--Since it will be revived, restore the parameters that have been reduced by the penalty (maximum value only)
			proxy:EraseEventSpecialEffect( 10000, 101 );
			proxy:NotNetMessage_begin();
				proxy:OnKeyTime2( 4050, "SoloBlockClear", 6.0, 0, 6, once );
			proxy:NotNetMessage_end();					
		--�z���C�g�S�[�X�g�� --EN:-- White ghost
		elseif proxy:IsWhiteGhost() == true then
			--�U�{�[�i�X�̎擾 --EN:--get fake bonus
			proxy:GetClearBonus(ClearBossId);
			--���E�ɋA�� --EN:--Return to the world
			proxy:NotNetMessage_begin();		
				proxy:OnKeyTime2(4050,"BlockClear2_3",CLEAR_TIMEOUT,0,0,once);
			proxy:NotNetMessage_end();
		--�u���b�N�S�[�X�g�� --EN:--During black ghost
		elseif proxy:IsBlackGhost() == true then
			--�\�E���y�i���e�B --EN:--Soul Penalty
			proxy:DeathPenalty( DeathPenalty_SoulAdjust, DeathPenalty_SoulMAX );			
			--�C�x���g�t���O���[���o�b�N --EN:--eventflag rollback
			proxy:SetFlagInitState(2);			
			--�����O�̈ʒu�ݒ� --EN:--Position settings before summoning
			proxy:SetSummonedPos();			
			--���݂̃}�b�v�Ɠ���ID�����}�b�vID�Ƃ��Đݒ� --EN:--Set the same ID as the current map as the next map ID
			proxy:SetDefaultMapUid(-1);			
			--���[�v���s�� --EN:--do warp
			proxy:WarpNextStageKick();			
			--�O���C�S�[�X�g�� --EN:--Gray ghost
			--proxy:SetChrTypeDataGrey();
			proxy:SetChrTypeDataGreyNext();
		end
	end
	print("BlockClear2_1 end");
end

--�v���C���[�]�����j���[�I���̃E�F�C�g --EN:--Wait for exiting player evaluation menu
function BlockClear2_2(proxy,param)
	print("BlockClear2_2 begin");
	if proxy:IsWhiteGhost() == true then
		--�����̃v���C���[ID��z�M���ăQ�[���I�ɔ����鎖��ʒm --EN:--Distribute your player ID and notify that you are leaving the game
		proxy:CustomLuaCallStart( 4063 , proxy:GetLocalPlayerId() );
	end
		
	--���S���G��r�� --EN:-- Eliminate complete invincibility
	--proxy:EnableInvincible(10000,false);
	proxy:NotNetMessage_begin();		
		proxy:OnKeyTime2(4050,"BlockClear2_3",CLEAR_TIMEOUT,0,0,once);
		proxy:OnKeyTime2(4050,"BlockClear2_3Leave",2.0,0,3,once);
	proxy:NotNetMessage_end();
	
	MissionSuccessed(proxy,param);
	print("BlockClear2_2 end");
end

--���U���� --EN:-- Dissolution process
function BlockClear2_3Leave(proxy,param)
	print("BlockClear2_3Leave begin");
		proxy:LeaveSession();		
	print("BlockClear2_3Leave end");
end

--�����E�ɋA�鏈�� --EN:--Processing to return to own world
function BlockClear2_3(proxy,param)
	--���j���[�}������ --EN:--Release menu suppression
	proxy:SetSubMenuBrake( false );
	
	--������ --EN:--Alive
	if proxy:IsLivePlayer() == true or proxy:IsGreyGhost() == true then	
		--���̍ēǂݍ��݌n�C�x���g�̊��荞�݂��J�n --EN:--Start interrupting other reloading events
		proxy:SetEventFlag(4047, false);		
		--���S�\ --EN:--Can die
		proxy:SetEventFlag( 4000, false );
		if proxy:IsAlive(10000) == true then
			proxy:SetEventFlag( 4067, false );
		end
	end
	
	if proxy:IsWhiteGhost() == true then	
		--��������̂ŕ����A�j���t���O���Z�b�g --EN:-- Set the resurrection animation flag because it will be revived
		proxy:SetAliveMotion( true );
	
		--�C�x���g�t���O���[���o�b�N --EN:--eventflag rollback
		proxy:SetFlagInitState(2);	
		
		--��������̂Ńy�i���e�B�Ō��������p�����[�^�����ɖ߂�(�ő�l�̂�) --EN:--Since it will be revived, restore the parameters that have been reduced by the penalty (maximum value only)
		proxy:EraseEventSpecialEffect( 10000, 101 );
		
		--���S�񕜗v�� --EN:-- full recovery request
		proxy:RequestFullRecover();
		
		--������Ԃɐݒ肵����ŁA�����̌������ʒu�փ��[�v --EN:--Warp to your blood letter position after setting it to a living state
		--proxy:WarpSelfBloodMark(false);
		proxy:SetSelfBloodMapUid();
		--proxy:RevivePlayer();
		proxy:RevivePlayerNext();--���̃��[�h�őh�� --EN:--Respawn on next load
		proxy:WarpNextStageKick();
	end
	
end

function SoloBlockClear(proxy,param)
	print("SoloBlockClear begin");
	--������]�����j���[���o���O�Ƀ��[����̂������p --EN:--For when the room is dismantled before the evaluation menu is released
	proxy:SetSubMenuBrake( false );
	proxy:GetSoloClearBonus(ClearBossId);
		
	--���̍ēǂݍ��݌n�C�x���g�̊��荞�݂��J�n --EN:--Start interrupting other reloading events
	proxy:SetEventFlag(4047, false);		
	--���S�\ --EN:--Can die
	proxy:SetEventFlag( 4000, false );	
	if proxy:IsAlive(10000) == true then
		proxy:SetEventFlag( 4067, false );
	end
	--�O�̈׃��[����� --EN:-- just in case room dismantling
	proxy:LeaveSession();
	print("SoloBlockClear end");
end


--��4050���A�j���Đ��҂��� --EN:-- �� 4050 �� Waiting for animation playback ��
function Check_BlockClearAnim(proxy,param)
	--�C�x���g�A�j���Đ������H --EN:--Is the event animation playing?
	if proxy:IsEventAnim(10000,8289) == false then
		--���L�����̃A�j���Đ��ɒ��� --EN:--Challenge to play animation of own character
		proxy:PlayAnimation(10000,8289);
		return false;
	else
		--�C�x���g�A�j���Đ����Ȃ̂ŁA�����Ƃ��� --EN:--Since the event animation is being played, it is assumed to be established.
		return true;
	end
end

--��4050���u���b�N�N���A�A�j���� --EN:-- �� 4050 �� Block clear animation ��
function BlockClearAnim(proxy,param)
	print("BlockClearAnim begin");
	--�����E�A�j���̓��� --EN:-- Synchronization of own world animation
	proxy:LuaCallStart(4050,20);
	proxy:StopPlayer();
	print("BlockClearAnim end");
end

--��4050���u���b�N�N���A�����A�j���� --EN:-- �� 4050 �� Block clear synchronization animation ��
function BlockClearSynchroAnime(proxy,param)
	print("BlockClearSynchroAnime begin");
	if param:IsNetMessage() == true then
		proxy:PlayAnimation(param:GetPlayID()+10001 , 8289);--�A�j���Đ� --EN:--animation playback
		proxy:EnableLogic(param:GetPlayID()+10001,false);--����s�\ --EN:-- Inoperable
		return;
	end
	
	--[[--�����E�A�j���Đ������͓���Ȃ̂ŁA���L�����̍Đ����͕ۗ��Ƃ���]] --EN:--The replay part of your own world animation is special, so the replay of your character will be put on hold]]
	--���L�����̓A�j���Ď���ǉ����� --EN:--Your character adds anime monitoring
	proxy:NotNetMessage_begin();
	proxy:RepeatMessage_begin();
		proxy:OnChrAnimEnd( 4050 , 10000 , 8289 , "BlockClearAnim_1",once);
	proxy:RepeatMessage_end();
	proxy:NotNetMessage_end();
	print("BlockClearSynchroAnime end");
end

--��4050���A�j���Ď��� --EN:-- �� 4050 �� Animation monitoring ��
function BlockClearAnim_1(proxy,param)
	print("BlockClearAnim_1 begin");
	--�������̓��� --EN:--invalidation synchronization
	proxy:LuaCallStart(4050,30);
	print("BlockClearAnim_1 end");
end

--��4050�������������� --EN:-- �� 4050 �� Invalidation Synchronization ��
function BlockClearSynchroInvalid(proxy,param)
	print("BlockClearSynchroInvalid begin");
	if param:IsNetMessage() == true then
		--�l�b�g���[�NID�Ŗ����� --EN:--Disable by Network ID
		InvalidCharactor( proxy , param:GetPlayID() + 10001 );
		return;
	else
		--���L���������� --EN:--Invalidate own character
		--InvalidCharactor( proxy , 10000 );
		--�\��OFF --EN:--Display OFF
		proxy:SetDrawEnable( 10000 , false );
	end
	
	print("BlockClearSynchroInvalid end");
end







--��4001���A�N�V�������f�� --EN:-- �� 4001 �� Action interrupted ��
function OnEvent_4001(proxy, param)
	if param:IsNetMessage() == true then
		return;
	end
	--print("OnEvent_4001 begin");
	--�A�N�V�����𒆒f����i�������j --EN:-- interrupt the action (initialization)
	proxy:ActionEnd(10000);
	--print("OnEvent_4001 end");
end


--��4002��������q���@����́� --EN:-- �� 4002 �� Vertical ladder middle upper input ��
function OnEvent_4002(proxy, param)
	if param:IsNetMessage() == true then
		return;
	end
	--print("OnEvent_4002 begin");

	if proxy:IsAction(10000,0) == false then
	--�C�x���g�R�}���hID(2)"�n�V�S������"�𑗂� --EN:-- Send event command ID (2) "Ladder climbed"
		proxy:SetEventCommand(10000,2);

	else
	--�C�x���g�R�}���hID(2)"�n�V�S����I����"�𑗂� --EN:-- Send event command ID (2) "finished climbing ladder"
		proxy:SetEventCommand(10000,4);

	end
--print("OnEvent_4002 end");
end

--��4003��������q���@�����́� --EN:-- �� 4003 �� Vertical ladder middle bottom input ��
function OnEvent_4003(proxy, param)
	if param:IsNetMessage() == true then
		return;
	end
	--print("OnEvent_4003 begin");

	if proxy:IsAction(10000,1) == false then
	--�C�x���g�R�}���hID(2)"�n�V�S�~�肽"�𑗂� --EN:--Send event command ID (2) "Ladder descended"
		proxy:SetEventCommand(10000,3);

	else

	--�C�x���g�R�}���hID(2)"�n�V�S�~��I����"�𑗂� --EN:-- Send event command ID (2) "Ladder finished"
		proxy:SetEventCommand(10000,5);
	end
	--print("OnEvent_4003 end");
end

--��4006���n�V�S�� �A�N�V�����{�^�����́� --EN:-- �� 4006 �� Ladder mid-action button input ��
function OnEvent_4006(proxy,param)
	print("OnEvent_4006 begin");
	print("OnEvent_4006 end");
end


--��4004��������q�@1�i�㏸�I���� --EN:-- �� 4004 �� Vertical ladder 1 step up completed ��
function OnEvent_4004(proxy, param)
	if param:IsNetMessage() == true then
		return;
	end
	print("OnEvent_4004 begin");
	--�A�N�V�����J�E���g�����Z�A�s���񐔃I�[�o�[����"�n�V�S����I����"�𑗂� --EN:--Increase the action count, send "Ladder finished" when the number of actions is exceeded
	proxy:AddActionCount(10000,4);
	--	proxy:CamReset(10000,1);
	print("OnEvent_4004 end");
end

--��4005��������q�@1�i���~�I���� --EN:-- �� 4005 �� Vertical ladder 1 step down completed ��
function OnEvent_4005(proxy, param)
	if param:IsNetMessage() == true then
		return;
	end
	print("OnEvent_4005 begin");
	--�A�N�V�����J�E���g�����Z�A�s���񐔂������������"�n�V�S����I����"�𑗂� --EN:--Subtract the action count, and send "Ladder finished" when the number of actions is less than the number of actions
	proxy:SubActionCount(10000,5);
	--	proxy:CamReset(10000,1);
	print("OnEvent_4005 end");
end

--��ID�s�⁡���j���[�̕\����}������Fsec�֐��Ő��䂳��遡 --EN:--�� ID is not required �� Suppress menu display: Controlled by sec function ��
function EventMenuBrake(proxy, param)
	if param:IsNetMessage() == true then
		return;
	end
	--���j���[����� --EN:--close menu
	--print("Call EventMenuClose");
	proxy:CloseMenu();
	--���j���[�}�����Ă� --EN:--call menu suppression
	--print("Call EventMenuBrake");
	proxy:SetMenuBrake();
end

--��ID�s�⁡���j���[�����I���� --EN:-- �� ID is not required �� Menu forced termination ��
function EventMenuClose(proxy, param)
	if param:IsNetMessage() == true then
		return;
	end
	--print("Call EventMenuClose");
	--���j���[����� --EN:--close menu
	proxy:CloseMenu();
end

--��ID�s�⁡�n�V�S�~��p�b�ԃC�x���g������3�b�ĂԂ��� --EN:-- �� No ID required �� Second-second event for descending the ladder *Currently called for 3 seconds
function LadderDown(proxy,param)
	--print("Event_LadderDown begin");
	proxy:CloseMenu();
	proxy:SetMenuBrake();
	--proxy:CamReset(10000,1);
	--print("Event_LadderDown end");
end


--���ėp��b�p����ID���ėp��b��o�^����L�q�ʂ����炷(���ǃn���h�����͑�����) --EN:--�� Common ID for general-purpose conversations �� Reduce the amount of description to register general-purpose conversations (In the end, the number of handlers will increase)
function OnTalk(proxy,EventID,TargetID,Dist,Ang,ValueBuffer,HelpID,func1,func2,func3,bOnce)

	--��EventID��NPC�ėp��b��--PC���C�x���gID����Dist�̋����ɓ����Ă��鎞	 --EN:--��EventID��NPC General Conversation��--When the PC is within Dist distance from the event ID
	proxy:OnTalkEventDistIn(EventID,TargetID,func2,Dist,bOnce );
	
	--��EventID��NPC�ėp��b��--PC���C�x���gID����Dist�̋����ɓ�������o���Ƃ�	 --EN:-- �� EventID �� NPC General Conversation �� -- When the PC exits after entering the distance of Dist from the event ID
	proxy:OnTalkEventDistOut(EventID,TargetID,func3,Dist,bOnce );
	
	--��EventID��NPC�ėp��b��--PC���C�x���gID����Dist�ɓ����Ĕ����p�x�ȓ��ŃA�N�V�����{�^������������	 --EN:--��EventID��NPC General Conversation��--When the PC enters the Dist from the event ID and presses the action button within the reaction angle
	proxy:OnTalkEvent(EventID,TargetID,func1, Dist, HelpID, Ang ,ValueBuffer,bOnce );
end

function OnUpDate(proxy,nEventID,nEventID2,nRegionID,func,func1)
	proxy:OnRegionIn(nEventID,10000,nRegionID,func,everytime);
	proxy:OnRegionJustOut(nEventID2,10000,nRegionID,func1,everytime);
end


function SetDisable(proxy,nChrID,bFlag)
	proxy:ChrDisableUpDate(nChrID,bFlag);	
end


--��Lua��`�֐����������ꂽ�A�j���[�V�����Đ��� --EN:-- �� Lua definition function �� Synchronized animation playback ��
--�l��ʂɒ�`�������Ȃ������̂ŁA --EN:-- I didn't want to define the value separately, so
--true : �p�[�e�B�[�̃v���C���[���A�j���[�V�������� --EN:--true : party player animated
--false: �������A�j���[�V�������� �ƒ�`�B --EN:--false: Defined as animated by me.
function Luafunc_PlaySynchroAnimation(proxy,param,nAnimeID)
	print("Luafunc_PlaySynchroAnimation begin");
	
	--�p�[�e�B�[�̃v���C���[���A�j���[�V���� --EN:--Party players animated
	if param:IsNetMessage() == true then 
		proxy:PlayAnimation( param:GetPlayID()+10001 , nAnimeID );
		print("Luafunc_PlaySynchroAnimation return true");
		return true;
	end
	--�������A�j���[�V���� --EN:--animated by me
	proxy:PlayAnimation( 10000 , nAnimeID );
	print("Luafunc_PlaySynchroAnimation return false");
	return false;
end


--��4010���A�j���[�V�����̓����p�֐�(�󎀑̗p)�� --EN:-- �� 4010 �� Synchronization function for animation (for treasure corpse) ��
function OnEvent_4010(proxy , param )
	print("OnEvent_4010 begin");
	
	--�v���C���[�̓����A�j���[�V����(true:�p�[�e�B�[�v���C���[���A�j���[�V��������) --EN:--Player synchronous animation (true: party player animated)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_PICK ) == true then
		print("return true ");
		print("OnEvent_4010 end");
		return true;
	end
	
	print("return false ");
	print("OnEvent_4010 end");
	return false;
end


--��4012���A�j���[�V�����̓����p�֐��� --EN:-- �� 4012 �� Synchronization function for animation ��
function OnEvent_4012(proxy , param )
	print("OnEvent_4012 begin");
	
	--�v���C���[�̓����A�j���[�V����(true:�p�[�e�B�[�v���C���[���A�j���[�V��������) --EN:--Player synchronous animation (true: party player animated)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_WALK ) == true then
		return;
	end
	
	print("OnEvent_4012 end" );
end

--��4013���A�j���[�V�����̓����p�֐��� --EN:-- �� 4013 �� Synchronization function for animation ��
function OnEvent_4013(proxy,param)
	print("OnEvent_4013 begin");
	--�v���C���[�̓����A�j���[�V����(true:�p�[�e�B�[�v���C���[���A�j���[�V��������) --EN:--Player synchronous animation (true: party player animated)
	if Luafunc_PlaySynchroAnimation( proxy, param, param:GetParam3() ) == true then
		print("return true ");
		print("OnEvent_4013 end");
		return true;
	end
	
	print("return false ");
	print("OnEvent_4013 end");
	return false;
end

--��4013�������A�j���Đ��� --EN:-- �� 4013 �� Synchronized animation playback ��
--(���ӁF������g�p����ƁA1�̃A�j���Đ��Ƀp�P�b�g1���̕��S�ɂȂ�̂ŁA --EN:--(Caution: If you use this, it will cost one packet to play one animation, so
--�Z���Ԃŉ��x���Ă΂��悤�ȏꏊ�ł͎g�p���T����) --EN:--Avoid using it in places where it will be called many times in a short period of time.)
--����Ȃ�̉񐔌Ă΂�邱�Ƃ�z�肵�ă��O�͂����Ă��� --EN:-- Keep the log assuming that it will be called a certain number of times
function SynchroAnim_4013(proxy,param)
	print("SynchroAnim_4013 begin");
	local targetId = param:GetParam2();
	local animId   = param:GetParam3();
	print("Target :",targetId," animId :",animId);
	--�v���C���Ȃ� --EN:--If you are a player
	if	targetId >= LOCAL_PLAYER then
		Luafunc_PlaySynchroAnimation( proxy, param, animId );
	else
		proxy:PlayAnimation( targetId, animId );
	end
	--print("SynchroAnim_4013 end");
end


--[[
--------------------------------------------------------------------------------------
--�ǂ͂���C�x���g�� --EN:--Wall clinging event��
--------------------------------------------------------------------------------------

--��4020���ǒ���t���@�E���́� --EN:-- �� 4020 �� with wall attachment Right input ��
function OnEvent_4020(proxy, param)
	if param:IsNetMessage() == true then
		return;
	end
	print("OnEvent_4020 begin");

	if proxy:IsAction(10000,0) == false then
	--�C�x���g�R�}���hID(22)"�E��1���i��"�𑗂� --EN:--Send event command ID (22) "one step to the right"
		proxy:SetEventCommand(10000,22);

	else
	--�C�x���g�R�}���hID(24)"�E�ɓn��I����"�𑗂� --EN:-- Send event command ID (24) "Finished crossing to the right"
		proxy:SetEventCommand(10000,24);

	end
print("OnEvent_4020 end");
end

--��4021���ǒ���t�� �����́� --EN:-- �� 4021 �� left input with wall mounting ��
function OnEvent_4021(proxy, param)
	if param:IsNetMessage() == true then
		return;
	end
	print("OnEvent_4021 begin");

	if proxy:IsAction(10000,1) == false then
	--�C�x���g�R�}���hID(23)"���ɐi��"�𑗂� --EN:-- Send event command ID (23) "Go left"
		proxy:SetEventCommand(10000,23);

	else

	--�C�x���g�R�}���hID(25)"���ɓn��I����"�𑗂� --EN:--Send Event Command ID (25) "Finished crossing to the left"
		proxy:SetEventCommand(10000,25);
	end
	print("OnEvent_4021 end");
end

--��4022���ǒ���t���@�E����ړ��I���� --EN:--�� 4022 �� Attached to the wall Finish moving one step to the right ��
function OnEvent_4022(proxy, param)
	if param:IsNetMessage() == true then
		return;
	end
	print("OnEvent_4022 begin");
	--�A�N�V�����J�E���g�����Z�A�s���񐔃I�[�o�[����"�E�ɓn��I����"�𑗂� --EN:--Increase the action count, and when the number of actions is exceeded, send "Right crossing finished"
	proxy:AddActionCount(10000,24);	
	print("OnEvent_4022 end");
end

--��4023���ǒ���t���@������ړ��I���� --EN:--�� 4023 �� Attached to the wall Finished moving one step to the left ��
function OnEvent_4023(proxy, param)
	if param:IsNetMessage() == true then
		return;
	end
	print("OnEvent_4023 begin");
	--�A�N�V�����J�E���g�����Z�A�s���񐔂������������"���ɓn��I����"�𑗂� --EN:--Subtract the action count, and send "crossed to the left" when the number of actions is less than
	proxy:SubActionCount(10000,25);	
	print("OnEvent_4023 end");
end
]]


--------------------------------------------------------------------------------------
--���p�j�f�[�����̏o������p --EN:--�� To control the appearance of the wandering demon
--------------------------------------------------------------------------------------

--���p�j�f�[������\�� --EN:--�� show the prowling daemon
function LuaFunc_VisibleTheWanderingDemon(proxy, param, demon_id_list)
	print("VisibleTheWanderingDemon begin");
	
	local demon_num = table.getn( demon_id_list );
	local i =0;
	for i=1 , demon_num , 1 do
		ValidCharactor( proxy , demon_id_list[i] );
	end

	print("VisibleTheWanderingDemon end");
end

--���p�j�f�[�������\�� --EN:--��Hide the prowling daemon
function LuaFunc_InvisibleTheWanderingDemon(proxy, param, demon_id_list)
	print("InvisibleTheWanderingDemon begin");
	
	local demon_num = table.getn( demon_id_list );
	local i=0;
	for i=1 , demon_num , 1 do
		InvalidCharactor( proxy , demon_id_list[i] );
	end

	print("InvisibleTheWanderingDemon end");
end

--���p�j�f�[�����̕\�����\������p(�G���A�ǂݍ��ݎ��̏������֐��ŌĂ�) --EN:--�� For judging display/non-display of the wandering daemon (called by the initialization function when reading the area)
function LuaFunc_WanderingDemonJudge( proxy , param , demon_id_list )

	if proxy:GetLocalPlayerChrType() == CHR_TYPE_GreyGhost then 
		LuaFunc_VisibleTheWanderingDemon( proxy, param, demon_id_list );
	else
		LuaFunc_InvisibleTheWanderingDemon( proxy, param, demon_id_list );
	end
	
end


--------------------------------------------------------------------------------------
--���X�[�p�[�A�[�}�[�L����/������ --EN:--�� Enable/Disable Super Armor
--------------------------------------------------------------------------------------

--���X�[�p�[�A�[�}�[�L���� --EN:--�� Enable Super Armor
function OnEvent_4015(proxy, param)
	local set_id = 10000;
	
	if param:IsNetMessage() == true then
		set_id = 10001 + param:GetPlayID();
	end
	proxy:SetSuperArmor( set_id , true );
end

--���X�[�p�[�A�[�}�[������ --EN:--�� Disable Super Armor
function OnEvent_4016(proxy, param)
	local set_id = 10000;
	
	if param:IsNetMessage() == true then
		set_id = 10001 + param:GetPlayID();
	end

	proxy:SetSuperArmor( set_id , false );
end


--------------------------------------------------------------------------------------
--�����S���G �L����/������ --EN:-- Complete Invincibility enable/disable
--------------------------------------------------------------------------------------

--�����S���G�L���� --EN:--�� Enable complete invincibility
function OnEvent_4017(proxy, param)
	local set_id = 10000;
	
	if param:IsNetMessage() == true then
		set_id = 10001 + param:GetPlayID();
	end
	
	proxy:EnableInvincible( set_id , true );
end

--�����S���G������ --EN:--��Complete invincibility disabled
function OnEvent_4018(proxy, param)
	local set_id = 10000;
	
	if param:IsNetMessage() == true then
		set_id = 10001 + param:GetPlayID();
	end

	proxy:EnableInvincible( set_id , false );
end

--------------------------------------------------------------------------------------
--���A�^������ --EN:-- ��Atari synchronization
--------------------------------------------------------------------------------------
function OnEvent_4019(proxy,param)
	local set_id = 10000;
	
	if param:IsNetMessage() == true then
		set_id = 10001 + param:GetPlayID();
	end
	--�}�b�v�ւ̓�����L���� --EN:--Hit on map enabled
	proxy:DisableMapHit( set_id , false );
	proxy:SetDisableGravity( set_id , false );
	
	--����ȂǗL�� --EN:--Valid for turning
	proxy:DisableMove( set_id , false );
end


--[[
	�C�x���g�̈�ւ̈ړ��֐��@�c��MoveRegion	 --EN:Function to move to the event area ...��MoveRegion
	proxy		�c�C�x���g�v���L�V --EN:proxy �c event proxy
	targetid	�c�ړ����������^�[�Q�b�g --EN:targetid �c the target you want to move
	regionid	�c�̈�ID --EN:regionid �c region ID
	ftime		�c�ړ���Ԃɂ����������ԁ@�@-1������ --EN:ftime ... The time you want to spend in the moving state -1 Unlimited
	frad		�c���蔼�a					��{0.0��OK --EN:frad �c Judgment radius Basic 0.0 is OK
	movetype	�c���������肩				true������ --EN:movetype �c walk or run true is walk
]]
function MoveRegion(proxy, targetid, regionid, ftime ,frad,movetype)
	--AI�ɃC�x���g�|�C���g���L�� --EN:-- Memorize event points in AI
	proxy:SetMovePoint(targetid,regionid,frad);
	--AI�ɃC�x���g���߂𔭍s(�ړ�)  --EN:-- Issue an event command to AI (move)
	proxy:AddEventGoal(targetid, GOAL_COMMON_MoveToSomewhere, ftime, POINT_EVENT, AI_DIR_TYPE_CENTER, frad, TARGET_SELF, movetype,0,0,0);	
end

--[[
	�C�x���g�̈�ւ̈ړ��֐��@�c��MoveRegion	 --EN:Function to move to the event area ...��MoveRegion
	proxy		�c�C�x���g�v���L�V --EN:proxy �c event proxy
	targetid	�c�ړ����������^�[�Q�b�g --EN:targetid �c the target you want to move
	regionid	�c�̈�ID --EN:regionid �c region ID
	ftime		�c�ړ���Ԃɂ����������ԁ@�@-1������ --EN:ftime ... The time you want to spend in the moving state -1 Unlimited
	frad		�c���蔼�a					��{0.0��OK --EN:frad �c Judgment radius Basic 0.0 is OK
	movetype	�c���������肩				true������ --EN:movetype �c walk or run true is walk
]]
function MoveRegion2(proxy, targetid, regionid, ftime ,frad,movetype)
	--AI�ɃC�x���g�|�C���g���L�� --EN:-- Memorize event points in AI
	proxy:SetMovePoint(targetid,regionid,frad);
	--AI�ɃC�x���g���߂𔭍s(�ړ�)  --EN:-- Issue an event command to AI (move)
	proxy:AddEventGoal(targetid, GOAL_COMMON_MoveToSomewhere, ftime, POINT_EVENT, AI_DIR_TYPE_CENTER, frad, TARGET_ENE_0, movetype,0,0,0);	
end

--[[
	�^�[�Q�b�g(�L����)�ւ̐���֐��@�c��TurnTarget	 --EN:Turn function to the target (character)...��TurnTarget
	�g�p��̒��ӁF�C�x���g�^�[�Q�b�g�𗘗p���Ă���̂ŁA --EN:Usage note: Since we are using event targets,
	�@�@�@�@�@�@�@�C�x���g�^�[�Q�b�g����݂̃C�x���g�Ŏg���ꍇ�A --EN:�@�@�@�@�@�@�@When used in an event related to the event target,
	�@�@�@�@�@�@�@���삪�ۏ�ł��܂���B --EN:Operation cannot be guaranteed.
				�@���̏ꍇ�̓|�C���g�w���Turn�֐���V���ɂ�p�ӂ���ȂǁA --EN:In that case, prepare a new Turn function that specifies the point, etc.
				�@�ʂ̑Ή����l���������ǂ��Ǝv���܂��B --EN:"I think it would be better to consider another response."
	proxy			�c�C�x���g�v���L�V --EN:proxy �c event proxy
	targetid		�c���񂳂��������������^�[�Q�b�g(�C�x���gID�w��) --EN:targetid �cTarget you want to turn (specify event ID)
	goal_target_id	�c���񂵂��������̃^�[�Q�b�g(�C�x���gID�w��) --EN:goal_target_id �c Target in the direction you want to turn (event ID specified)
	ftime			�c�ړ���Ԃɂ����������ԁ@�@-1������ --EN:ftime ... The time you want to spend in the moving state -1 Unlimited
]]
function TurnTarget(proxy, targetid, goal_target_id, ftime )
	--�����̑S�p�����[�^���m�F�ł���̂ŁA���O�Ŋm�F���������͂ǂ��� --EN:-- You can check all the parameters of the argument, so if you want to check it in the log, please
	--print("TurnTarget targetid = ", targetid, ", goal_target_id = ", goal_target_id, ", ftime = ", ftime);
	
	--�C�x���g�^�[�Q�b�g��ݒ� --EN:--set event target
	proxy:SetEventTarget( targetid, goal_target_id );
	--AI�ɃC�x���g�^�[�Q�b�g�ɐU������悤�ɃC�x���g���߂𔭍s(����) --EN:--Issue an event command to turn the AI to the event target (turn)
	proxy:AddEventGoal(targetid, GOAL_COMMON_Turn, ftime, TARGET_EVENT, 0,0,0,0,0,0,0);
end

--[[
	�^�[�Q�b�g(�L����)�ւ̐���֐��@�c��TurnTarget	 --EN:Turn function to the target (character)...��TurnTarget
	�g�p��̒��ӁF�C�x���g�^�[�Q�b�g�𗘗p���Ă���̂ŁA --EN:Usage note: Since we are using event targets,
	�@�@�@�@�@�@�@�C�x���g�^�[�Q�b�g����݂̃C�x���g�Ŏg���ꍇ�A --EN:�@�@�@�@�@�@�@When used in an event related to the event target,
	�@�@�@�@�@�@�@���삪�ۏ�ł��܂���B --EN:Operation cannot be guaranteed.
				�@���̏ꍇ�̓|�C���g�w���Turn�֐���V���ɂ�p�ӂ���ȂǁA --EN:In that case, prepare a new Turn function that specifies the point, etc.
				�@�ʂ̑Ή����l���������ǂ��Ǝv���܂��B --EN:"I think it would be better to consider another response."
	proxy			�c�C�x���g�v���L�V --EN:proxy �c event proxy
	targetid		�c���񂳂��������������^�[�Q�b�g(�C�x���gID�w��) --EN:targetid �cTarget you want to turn (specify event ID)
	goal_target_id	�c���񂵂��������̃^�[�Q�b�g(�C�x���gID�w��) --EN:goal_target_id �c Target in the direction you want to turn (event ID specified)
	ftime			�c�ړ���Ԃɂ����������ԁ@�@-1������ --EN:ftime ... The time you want to spend in the moving state -1 Unlimited
]]
function TurnTarget2(proxy, targetid, goal_target_id, ftime )
	--�����̑S�p�����[�^���m�F�ł���̂ŁA���O�Ŋm�F���������͂ǂ��� --EN:-- You can check all the parameters of the argument, so if you want to check it in the log, please
	--print("TurnTarget targetid = ", targetid, ", goal_target_id = ", goal_target_id, ", ftime = ", ftime);
	
	--�C�x���g�^�[�Q�b�g��ݒ� --EN:--set event target
	proxy:SetMovePoint(targetid,goal_target_id,0.0);
	--AI�ɃC�x���g�^�[�Q�b�g�ɐU������悤�ɃC�x���g���߂𔭍s(����) --EN:--Issue an event command to turn the AI to the event target (turn)
	--proxy:AddEventGoal(targetid, GOAL_COMMON_Turn, ftime, TARGET_EVENT, 0,0,0,0,0,0,0);
end

--[[
	�w��^�[�Q�b�g�̉E�蕐���؂�ւ��܂� --EN:Toggles right-hand weapon for specified target
	���x���Ă΂Ȃ��ŉ������B�����T�c�L��p�ł������퓮�삷�邩�͂킩��Ȃ��ł��B --EN:Please don't call me again. To be honest, it is exclusive to Satsuki, but I don't know if it will work properly.
]]
function TargetChangeWepR2(proxy,targetid)
	proxy:AddEventGoal(targetid, GOAL_COMMON_Attack, 10.0, NPC_ATK_ChangeWep_R2,TARGET_ENE_0, DIST_None,0,0,0,0,0);
end



--�L�����N�^������ --EN:--disable character
function InvalidCharactor(proxy, eventId)
	proxy:SetDisable( eventId, true );
	proxy:CharacterAllAttachSys(eventId);
end

--�L�����N�^�L���� --EN:--Character enable
function ValidCharactor(proxy, eventId)
	proxy:SetDisable( eventId, false );
end

--�o�b�N���[�h�L�����N�^�𖳌��� --EN:--disable backread characters
function InvalidBackRead(proxy,eventId)
	proxy:SetDisable( eventId, true );--�����ݒ� --EN:--Disable setting
	proxy:SetDisableBackread_forEvent( eventId, true );--�o�b�N���[�h������ --EN:--disable back read
end

--�o�b�N���[�h�L�����N�^��L���� --EN:--enable back read characters
function ValidBackRead(proxy,eventId)
	proxy:SetDisable( eventId, false );--�L���ݒ� --EN:--Enable setting
	proxy:SetDisableBackread_forEvent( eventId, false );--�o�b�N���[�h�L���� --EN:--enable back read
end


--[[�C���t�H���[�V�������j���[�\���p]] --EN:--[[For information menu display]]
--[[�����S���w��]] --EN:--[[Specify all arguments]]
--[[
	proxy 	          �c �C�x���g�v���N�V --EN:proxy �c event proxy
	type  	       	  �c 0:�ʏ�(�����s) 1:�Ȉ�(1�s) --EN:type �c 0: normal (multiple lines) 1: simple (single line)
	title_icon_id  	  �c �^�C�g�����b�Z�[�W�̃A�C�R��ID --EN:title_icon_id �c Title message icon ID
	title_category_id �c �^�C�g�����b�Z�[�W�̃J�e�S���[ID(30���C�x���g�p�J�e�S���[) --EN:title_category_id �c Category ID of the title message (30 is the event category)
	title_msg_id      �c �^�C�g�����b�Z�[�W�̃��b�Z�[�WID --EN:title_msg_id �c Message ID of title message
	sys_msg_id        �c 0�Ń_�C�A���O�\�� --EN:Display dialog with sys_msg_id �c 0
	icon_list         �c �s���ƂɃA�C�R�����w�肷��ꍇ�Ɏw��(���X�g�œn����āA�ŏ��̈���f�t�H���g�ɂȂ�) --EN:icon_list �c Specified when specifying an icon for each line (passed in a list, the first one is the default)
	category_list     �c ���b�Z�[�W�̃J�e�S���[ID(���X�g�œn����āA�ŏ��̈���f�t�H���g�ɂȂ�) --EN:category_list �c the category id of the message (passed in list, defaults to first one)
	msg_list    �@�@�@�c ���b�Z�[�WID���ʂɎw��(���X�g�œn����āA�ŏ��̈���f�t�H���g�ɂȂ�) --EN:msg_list �c Specify message IDs individually (passed in a list, the first one is the default)
	msg_num           �c ���b�Z�[�W�̍s��(�Ȃ��Ă��ǂ���������Ȃ����) --EN:msg_num �c Number of lines in the message (may not be necessary...)
]]

function Display_InfomationMenu
(proxy, type, title_icon_id, title_category_id, title_msg_id, sys_msg_id, icon_list, category_list, msg_list, msg_num)
	print( "Display_InfomationMenu begin" );
	
	--�C���t�H���[�V�������j���[�\�� --EN:--Information menu display
	proxy:InfomationMenu( type , title_icon_id , title_category_id , title_msg_id , sys_msg_id );
	
	--���b�Z�[�W�Ȃǂ̐�������Ȃ��Ƃ��̓f�t�H���g�̒l�ő�p���� --EN:--If the number of messages, etc. does not match, substitute the default value
	--(���X�g�ɂ͒l���P�ȏ�����Ă��邱�ƑO��ŁA�P�ԍŏ��̂��f�t�H���g�ɂ���) --EN:--(Assuming that the list contains one or more values, the first is the default)
	
	local default_icon_id     = icon_list[1];
	local default_category_id = category_list[1];
	local default_msg_id      = msg_list[1];
	
	if type == 0 then -- �ʏ탁�j���[ --EN:-- Normal menu
		local i=1;
		for i=1, msg_num, 1 do
		
			--�Z�b�g����l���f�t�H���g�ŏ����� --EN:--initialize the value to be set by default
			local set_icon_id     = default_icon_id;
			local set_category_id = default_category_id;
			local set_msg_id      = default_msg_id;
			
			--�l������ꍇ������g�� --EN:--use value if present
			if icon_list[i]     ~= nil then set_icon_id     = icon_list[i];     end
			if category_list[i] ~= nil then set_category_id = category_list[i]; end
			if msg_list[i]      ~= nil then set_msg_id      = msg_list[i];      end
			
			--�C���t�H���[�V�������j���[�̃��X�g�ɒǉ� --EN:--Added to the information menu list
			proxy:AddInfomationList( set_icon_id , set_category_id , set_msg_id );
		
		end	
	
	elseif type == 1 then -- �ȈՃ��j���[ --EN:-- simple menu
		--�C���t�H���[�V�������j���[�̃��X�g�ɒǉ� --EN:--Added to the information menu list
		proxy:AddInfomationList( default_icon_id , default_category_id , default_msg_id );
	end

	print( "Display_InfomationMenu end" );
end


--[[�C���t�H���[�V�������j���[�\���p]] --EN:--[[For information menu display]]
--[[���b�Z�[�WID�ЂƂ����ƘA�Ԃŏ���Ɏw��]] --EN:--[[If you enter one message ID, specify it by serial number]]
--[[
	proxy 	          �c �C�x���g�v���N�V --EN:proxy �c event proxy
	type  	       	  �c 0:�ʏ�(�����s) 1:�Ȉ�(1�s) --EN:type �c 0: normal (multiple lines) 1: simple (single line)
	title_icon_id  	  �c �^�C�g�����b�Z�[�W�̃A�C�R��ID --EN:title_icon_id �c Title message icon ID
	title_category_id �c �^�C�g�����b�Z�[�W�̃J�e�S���[ID(30���C�x���g�p�J�e�S���[) --EN:title_category_id �c Category ID of the title message (30 is the event category)
	title_msg_id      �c �^�C�g�����b�Z�[�W�̃��b�Z�[�WID --EN:title_msg_id �c Message ID of title message
	sys_msg_id        �c 0�Ń_�C�A���O�\�� --EN:Display dialog with sys_msg_id �c 0
	icon_id           �c �s���ƂɃA�C�R�����w�肷��ꍇ�Ɏw��(���̊֐��ł͂��ׂē����ɂȂ�) --EN:icon_id �c Specified when specifying an icon for each row (all are the same in this function)
	category_id       �c ���b�Z�[�W�̃J�e�S���[ID --EN:category_id �c Category ID of the message
	first_msg_id      �c ���b�Z�[�WID �ŏ��̂ЂƂ��w�肷���msg_num�s�����A�ԂŒǉ������ --EN:first_msg_id �c Message ID If you specify the first one, msg_num lines will be added in sequence
	msg_num           �c ���b�Z�[�W�̍s�� --EN:msg_num �c number of message lines
]]
function Display_InfomationMenu_2
(proxy, type, title_icon_id, title_category_id, title_msg_id, sys_msg_id, icon_id, category_id, first_msg_id, msg_num)
	print( "Display_InfomationMenu begin" );
	proxy:ShowGenDialog(first_msg_id,1,1,true);
	--[[
	--�C���t�H���[�V�������j���[�\�� --EN:--Information menu display
	proxy:InfomationMenu( type , title_icon_id , title_category_id , title_msg_id , sys_msg_id );
	
	if type == 0 then -- �ʏ탁�j���[ --EN:-- Normal menu

		local now_msg_id = first_msg_id;
		local i=1;
		for i=1, msg_num, 1 do
			--�C���t�H���[�V�������j���[�̃��X�g�ɒǉ� --EN:--Added to the information menu list
			proxy:AddInfomationList( icon_id , category_id , now_msg_id );
			now_msg_id = now_msg_id + 1;
		end
	
	elseif type == 1 then -- �ȈՃ��j���[ --EN:-- simple menu
		--�C���t�H���[�V�������j���[�̃��X�g�ɒǉ� --EN:--Added to the information menu list
		proxy:AddInfomationList( icon_id , category_id , first_msg_id );
	end
	]]
	print( "Display_InfomationMenu end" );
end



function LengthOut_SosDialog(proxy,param)
	print("LengthOut_SosDialog begin");	
	--�C���t�H���[�V�������j���[�\��		 --EN:--Information menu display
	print("LengthOut_SosDialog end");
end


--[[
		�ȉ��v���O��������R�[�������V�X�e�����O --EN:System log called from the following program
]]
--------------------------------------------------------------------------------------
--��SOS���������狗��������ď������Ƃ��̃��O --EN:--�� Log when the distance from the SOS blood letter disappears
--------------------------------------------------------------------------------------
function LengthOut_SosDialog(proxy,param)
	print("LengthOut_SosDialog begin");	
	--�C���t�H���[�V�������j���[�\��			 --EN:--Information menu display
	proxy:InfomationMenu( INFOMENU_TYPE_LIST, -1, 0, -1, 1 );
	proxy:AddInfomationTosBuffer( 20000005 );
	print("LengthOut_SosDialog end");
end


--------------------------------------------------------------------------------------
--�����Ґ�����ʒm���郍�O�i�z���C�g���ҁj --EN:--�� Log that notifies summoning success (white summoning)
--------------------------------------------------------------------------------------
function SummonSuccess_White(proxy,param)
	print("SummonSuccess_White begin");
	--�C���t�H���[�V�������j���[�\��			 --EN:--Information menu display
	print("SummonSuccess_White end");
end

--------------------------------------------------------------------------------------
--�����Ґ�����ʒm���郍�O�i�u���b�N���ҁj --EN:-- �� Log that notifies summoning success (black summoning)
--------------------------------------------------------------------------------------
function SummonSuccess_Black(proxy,param)
	print("SummonSuccess_Black begin");
	--�C���t�H���[�V�������j���[�\��			 --EN:--Information menu display
	print("SummonSuccess_Black end");
end

--------------------------------------------------------------------------------------
--�����҂��ꂽ����ʒm���郍�O�i�z���C�g���ҁj --EN:--��Log notifying that you have been summoned (white summoning)
--------------------------------------------------------------------------------------
function OnBeSummoned_White(proxy,param)
	print("OnBeSummoned_White begin");
	
	--�z���C�g�����ʒm --EN:-- White summon notification
	--proxy:LuaCallStartPlus( 4041, 1, proxy:GetLocalPlayerId() );
--[[
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 4036, "WarpSosPos", 0.1, 0, 2, once );
	proxy:NotNetMessage_end();
]]
	
	print("OnBeSummoned_White end");
end


--------------------------------------------------------------------------------------
--�����҂��ꂽ����ʒm���郍�O�i�u���b�N���ҁj --EN:--�� Log notifying that you have been summoned (black summoning)
--------------------------------------------------------------------------------------
function OnBeSummoned_Black(proxy,param)
	print("OnBeSummoned_Black begin");
	
	--�u���b�N�����ʒm --EN:-- Black summon notification
	--proxy:LuaCallStartPlus( 4041, 2, proxy:GetLocalPlayerId() );
--[[
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 4037, "WarpMiniblockPos", 0.1, 0, 2, once );
	proxy:NotNetMessage_end();
]]
	--�z�X�g�̃v���C�̈悩�烏�[�v���ݒ� --EN:--Set warp destination from host's play area
	--proxy:LuaCallStart( 4037, 2 );
	
	print("OnBeSummoned_Black end");
end

--------------------------------------------------------------------------------------
--�����҂��ꂽ����ʒm���郍�O�i�u���b�N���������j --EN:--�� Log notifying that you have been summoned (black forced intrusion)
--------------------------------------------------------------------------------------
function OnBeSummoned_ForceJoinBlack(proxy,param)
	print("OnBeSummoned_ForceJoinBlack begin");
	
	--�u���b�N�����ʒm --EN:-- Black intrusion notification
	--proxy:LuaCallStartPlus( 4041, 3, proxy:GetLocalPlayerId() );
	
	print("OnBeSummoned_ForceJoinBlack end");
end

--------------------------------------------------------------------------------------
--�����҂��ꂽ����ʒm���郍�O�i�u���b�N��������<���ł����g���Ă��Ȃ�>�j --EN:--�� Log notifying that you have been summoned (forced black summoning <used only by Okina>)
--------------------------------------------------------------------------------------
function OnBeForceSummoned_Black(proxy,param)
	print("OnBeForceSummoned_Black begin");
	
	--�u���b�N���������ʒm --EN:-- Black forced summon notification
	--proxy:LuaCallStartPlus( 4041, 4, proxy:GetLocalPlayerId() );
	
	print("OnBeForceSummoned_Black end");
end



------------------------------------------------------------------------------------
--�ڕW�B�� --EN:--Goal achievement
------------------------------------------------------------------------------------
function MissionSuccessed(proxy,param)
	print("MissionSuccessed begin");
	--�z���C�g --EN:--white
	if		proxy:GetTempSummonParam() == -1 then
		proxy:RecallMenuEvent( 0, 8933 );
	--�u���b�N --EN:--black
	elseif	proxy:GetTempSummonParam() == -2 then
		--�ʏ�PK�̏ꍇ�����ƃO���C�̏ꍇ�Ő����������ς�� --EN:--In the case of normal PK, the success process differs between survival and gray.
		if proxy:IsPrevGreyGhost() == true then
			proxy:RecallMenuEvent( 0, 8934 );
		else
			proxy:RecallMenuEvent( 0, 8937 );
		end
	--���� --EN:--Intrusion
	elseif	proxy:GetTempSummonParam() == -3 then
		proxy:RecallMenuEvent( 0, 8935 );
	--�������� --EN:--forced summon
	elseif	proxy:GetTempSummonParam() >   0 then
		proxy:RecallMenuEvent( 0, 8936 );
	end
	print("MissionSuccessed end");
end


------------------------------------------------------------------------------------
--�ڕW���s --EN:--Target failed
------------------------------------------------------------------------------------
function MissionFailed(proxy,param)
	print("MissionFailed begin");
	--�z���C�g --EN:--white
	if		proxy:GetTempSummonParam() == -1 then
		proxy:RecallMenuEvent( 0, 8943 );
	--�u���b�N --EN:--black
	elseif	proxy:GetTempSummonParam() == -2 then
		proxy:RecallMenuEvent( 0, 8944 );
	--���� --EN:--Intrusion
	elseif	proxy:GetTempSummonParam() == -3 then
		proxy:RecallMenuEvent( 0, 8945 );
	--�������� --EN:--forced summon
	elseif	proxy:GetTempSummonParam() >   0 then
		proxy:RecallMenuEvent( 0, 8946 );
	end
	--���S�񕜗v�� --EN:-- full recovery request
	proxy:RequestFullRecover();
	
	print("MissionFailed end");
end


------------------------------------------------------------------------------------
--���S�ɂ��ڕW���s --EN:--Target failure due to death
------------------------------------------------------------------------------------
function MissionDeadFailed(proxy,param)
	print("MissionDeadFailed begin");
	--�z���C�g --EN:--white
	if		proxy:GetTempSummonParam() == -1 then
		proxy:RecallMenuEvent( 0, 8953 );
	--�u���b�N --EN:--black
	elseif	proxy:GetTempSummonParam() == -2 then
		proxy:RecallMenuEvent( 0, 8954 );
	--���� --EN:--Intrusion
	elseif	proxy:GetTempSummonParam() == -3 then
		proxy:RecallMenuEvent( 0, 8955 );
	--�������� --EN:--forced summon
	elseif	proxy:GetTempSummonParam() >   0 then
		proxy:RecallMenuEvent( 0, 8956 );
	end
	print("MissionDeadFailed end");
end

--------------------------------------------------------------------------------------
--��SOS�T�C��������������ʒm���郍�O(�~�j�u���b�N�ړ���) --EN:--�� A log that notifies that the SOS sign has disappeared (when moving the mini block)
--------------------------------------------------------------------------------------
function OnEvent_Delete_SOS(proxy,param)
	print("OnEvent_Delete_SOS begin");	
	proxy:InfomationMenu( INFOMENU_TYPE_LIST, -1, 0, -1, 1 );
	proxy:AddInfomationTosBuffer( 20000000 );
	print("OnEvent_Delete_SOS end");
end
--�z���C�g�\�E���T�C�� --EN:--White Soul Sign
function OnEvent_Delete_WhiteSOS(proxy,param)
	print("OnEvent_Delete_WhiteSOS begin");	
	proxy:InfomationMenu( INFOMENU_TYPE_LIST, -1, 0, -1, 1 );
	proxy:AddInfomationTosBuffer( 20000000 );
	proxy:SetInfomationPriority(USER_ID_Event_SosLost_White);
	print("OnEvent_Delete_WhiteSOS end");
end
--�u���b�N�\�E���T�C�� --EN:-- Black Soul Sign
function OnEvent_Delete_BlackSOS(proxy,param)
	print("OnEvent_Delete_BlackSOS begin");	
	proxy:InfomationMenu( INFOMENU_TYPE_LIST, -1, 0, -1, 1 );
	proxy:AddInfomationTosBuffer( 20000001 );
	proxy:SetInfomationPriority(USER_ID_Event_SosLost_Red);
	print("OnEvent_Delete_BlackSOS end");
end
--�����\�E���T�C�� --EN:--Intrusion Soul Sign
function OnEvent_Delete_ForceJoinSOS(proxy,param)
	print("OnEvent_Delete_ForceJoinSOS begin");	
	proxy:InfomationMenu( INFOMENU_TYPE_LIST, -1, 0, -1, 1 );
	proxy:AddInfomationTosBuffer( 20000002 );
	proxy:SetInfomationPriority(USER_ID_Event_SosLost_Black);
	print("OnEvent_Delete_ForceJoinSOS end");
end

--------------------------------------------------------------------------------------
--��LAN���ؒf���ꂽ����ʒm���郍�O --EN:--�� A log that notifies that the LAN has been disconnected
--------------------------------------------------------------------------------------
function OnLanCutError(proxy,param)
	print("OnLanCutError begin");
	
	if proxy:IsCompleteEvent( 4047 ) == true then
		return;
	end
	proxy:InfomationMenu( INFOMENU_TYPE_LIST, -1, 0, -1, 1 );
	proxy:AddInfomationTosBuffer( 20001005 );
	


	proxy:NotNetMessage_begin();
		--[[
		--��4046��5�b�� --EN:-- �� 4046 �� 5 seconds later
		proxy:OnKeyTime2( 4046, "OnLeave_Limit", 5.0, 0, 1, once );
				
		--���̍ēǂݍ��݌n�C�x���g�̊��荞�݂�h�~ --EN:--Prevent interruption of other reloading events
		proxy:SetEventFlag(4047, true);
		--�C�x���g�����ɂ����[�h�҂��ł��鎖��ʒm --EN:-- Notify that it is waiting for loading inside the event
		proxy:SetLoadWait();
		]]
		RegistReturnTitle(proxy,param);
		proxy:WARN("OnLanCutError!");
	proxy:NotNetMessage_end();
	
	print("OnLanCutError end");
end


--------------------------------------------------------------------------------------
--��NP�T�[�o����̃T�C���A�E�g��ʒm���郍�O --EN:--��Log notifying sign-out from NP server
--------------------------------------------------------------------------------------
function OnNpServerSignOut(proxy,param)
	if proxy:IsCompleteEvent( 4047 ) == true then
		return;
	end
	print("OnNpServerSignOut begin");
	proxy:InfomationMenu( INFOMENU_TYPE_LIST, -1, 0, -1, 1 );
	proxy:AddInfomationTosBuffer( 20001010 );
	
	--�^�C�g���ɖ߂� --EN:--Return to title
	proxy:WARN("NpSignOut Error");
	RegistReturnTitle(proxy,param);
	print("OnNpServerSignOut end");
end

--------------------------------------------------------------------------------------
--��P2P�ڑ��̃^�C���A�E�g��ʒm���郍�O --EN:--�� Log that notifies timeout of P2P connection
--------------------------------------------------------------------------------------
function OnP2PTimeOut(proxy,param)
	print("OnP2PTimeOut begin");
	if proxy:IsCompleteEvent( 4047 ) == true then
		return;
	end
	proxy:InfomationMenu( INFOMENU_TYPE_LIST, -1, 0, -1, 1 );
	proxy:AddInfomationTosBuffer( 20001015 );
	if proxy:IsLivePlayer() == false and proxy:IsGreyGhost() == false then
		proxy:NotNetMessage_begin();
			--��4046��5�b�� --EN:-- �� 4046 �� 5 seconds later
			proxy:OnKeyTime2( 4046, "OnLeave_Limit", 5.0, 0, 1, once );
			
			--���̍ēǂݍ��݌n�C�x���g�̊��荞�݂�h�~ --EN:--Prevent interruption of other reloading events
			proxy:SetEventFlag(4047, true);
			--�C�x���g�����ɂ����[�h�҂��ł��鎖��ʒm --EN:-- Notify that it is waiting for loading inside the event
			proxy:SetLoadWait();
			
		proxy:NotNetMessage_end();
	end
	print("OnP2PTimeOut end");
end


function OnFailedGetBlockNum(proxy,param)
	print("OnFailedGetBlockNum begin");
	if proxy:IsCompleteEvent( 4047 ) == true then
		return;
	end
	proxy:InfomationMenu( INFOMENU_TYPE_LIST, -1, 0, -1, 1 );
	proxy:AddInfomationTosBuffer( 20001002 );	
	--�^�C�g���ɖ߂� --EN:--Return to title
	proxy:WARN("OnFailedGetBlockNum Error");
	RegistReturnTitle(proxy,param);
	print("OnFailedGetBlockNum end");
end

--------------------------------------------------------------------------------------
--��4043���Q���҂����Ȃ��Ȃ����i�ޏo�A�L�b�N�A���S�ȊO�j --EN:--��4043��Participant disappeared (other than leaving, kicking, or dying)
--------------------------------------------------------------------------------------
function OnLeavePlayer(proxy,param)
	print("OnLeavePlayer begin");
	if proxy:IsCompleteEvent( 4047 ) == true then
		return;
	end
	
	if proxy:IsCompleteEvent( 4044 ) == true then
		proxy:SetEventFlag( 4044, false );
		return;
	end
	
	--�ޏo�A�L�b�N�A���S�ȊO�����Ȃ��̂ŁA��悸�R�����g�A�E�g --EN:--I can't get anything other than exit, kick, and death, so comment out for now
	proxy:InfomationMenu( INFOMENU_TYPE_LIST, -1, 0, -1, 1 );
	proxy:AddInfomationTimeMsgTag( 20001020, TAG_IDX_leaveChara, param:GetParam3() );
	if param:GetParam3() == proxy:GetLocalPlayerId() then
		proxy:NotNetMessage_begin();
			--��4046��5�b�� --EN:-- �� 4046 �� 5 seconds later
			proxy:OnKeyTime2( 4046, "OnLeave_Limit", 5.0, 0, 1, once );
			
			--���̍ēǂݍ��݌n�C�x���g�̊��荞�݂�h�~ --EN:--Prevent interruption of other reloading events
			proxy:SetEventFlag(4047, true);
			--�C�x���g�����ɂ����[�h�҂��ł��鎖��ʒm --EN:-- Notify that it is waiting for loading inside the event
			proxy:SetLoadWait();
			
		proxy:NotNetMessage_end();
	end
	print("OnLeavePlayer end");
end

--------------------------------------------------------------------------------------
--���Q�[���I�ޏo�������l��ʒm���� --EN:--�� Notify the person who left the game
--------------------------------------------------------------------------------------
function OnGameLeave(proxy,param)
	if param:GetParam2() ~= proxy:GetLocalPlayerId() then
		print("OnGameLeave begin");
		local leavePlayer = param:GetParam2();
		print("LeavePlayer :",leavePlayer);
		proxy:ReqularLeavePlayer( leavePlayer );
		print("OnGameLeave begin");
	end
end

--------------------------------------------------------------------------------------
--���L�b�N�A�E�g���ꂽ�̂�ʒm���郍�O --EN:--�� Log to notify that you have been kicked out
--------------------------------------------------------------------------------------
function OnBeKickOut(proxy,param)
	print("OnBeKickOut begin");
	if proxy:IsCompleteEvent( 4047 ) == true then
		return;
	end
	proxy:InfomationMenu( INFOMENU_TYPE_LIST, -1, 0, -1, 1 );
	proxy:AddInfomationTosBuffer( 20000420 );
	
	--��4046��5�b�� --EN:-- �� 4046 �� 5 seconds later
	proxy:OnKeyTime2( 4046, "OnLeave_Limit", 5.0, 0, 1, once );
	--���̍ēǂݍ��݌n�C�x���g�̊��荞�݂�h�~ --EN:--Prevent interruption of other reloading events
	proxy:SetEventFlag(4047, true);
	--�C�x���g�����ɂ����[�h�҂��ł��鎖��ʒm --EN:-- Notify that it is waiting for loading inside the event
	proxy:SetLoadWait();
	
	print("OnBeKickOut end");
end

--------------------------------------------------------------------------------------
--�����ӃL�b�N�A�E�g���ꂽ�̂�ʒm���郍�O --EN:--�� Thank you log to notify you that you have been kicked out
--------------------------------------------------------------------------------------
function OnBeThxKickOut(proxy,param)
	print("OnBeThxKickOut begin");
	if proxy:IsCompleteEvent( 4047 ) == true then
		return;
	end
	proxy:InfomationMenu( INFOMENU_TYPE_LIST, -1, 0, -1, 1 );
	proxy:AddInfomationTosBuffer( 20000421 );
	
	--��4046��5�b�� --EN:-- �� 4046 �� 5 seconds later
	proxy:OnKeyTime2( 4046, "OnLeave_Limit", 5.0, 0, 1, once );
	--���̍ēǂݍ��݌n�C�x���g�̊��荞�݂�h�~ --EN:--Prevent interruption of other reloading events
	proxy:SetEventFlag(4047, true);
	--�C�x���g�����ɂ����[�h�҂��ł��鎖��ʒm --EN:-- Notify that it is waiting for loading inside the event
	proxy:SetLoadWait();
	
	print("OnBeThxKickOut end");
end


--------------------------------------------------------------------------------------
--��4044���L�b�N�A�E�g�����̂�ʒm���郍�O --EN:--��4044��Log notifying that you kicked out
--------------------------------------------------------------------------------------
function OnKickOut(proxy,param)
	print("OnKickOut begin");	
	--�L�b�N�A�E�g�����̂������̎� --EN:--When I kicked out
	if proxy:IsHost() == true then
		proxy:InfomationMenu( INFOMENU_TYPE_LIST, -1, 0, -1, 1 );	
		proxy:AddInfomationTosBuffer( 20000415 );
		proxy:SetEventFlag( 4044, true );
	--�����ȊO�̐l���L�b�N�A�E�g���ꂽ��		 --EN:--When someone other than you is kicked out
	elseif proxy:GetLocalPlayerId() ~= param:GetParam3() then
		proxy:InfomationMenu( INFOMENU_TYPE_LIST, -1, 0, -1, 1 );	
		proxy:AddInfomationTimeMsgTag( 20000425, TAG_IDX_leaveChara, param:GetParam3() );
	end
	print("OnKickOut end");
end

--------------------------------------------------------------------------------------
--��4044�����ӃL�b�N�A�E�g�����̂�ʒm���郍�O --EN:-- �� 4044 �� Log to notify that you have kicked out thanks
--------------------------------------------------------------------------------------
function OnThxKickOut(proxy,param)
	print("OnThxKickOut begin");	
	--�L�b�N�A�E�g�����̂������̎� --EN:--When I kicked out
	if proxy:IsHost() == true then
		proxy:InfomationMenu( INFOMENU_TYPE_LIST, -1, 0, -1, 1 );	
		proxy:AddInfomationTosBuffer( 20000416 );
		proxy:SetEventFlag( 4044, true );
	--�����ȊO�̐l���L�b�N�A�E�g���ꂽ�� --EN:--When someone other than you is kicked out
	elseif proxy:GetLocalPlayerId() ~= param:GetParam3() then
		proxy:InfomationMenu( INFOMENU_TYPE_LIST, -1, 0, -1, 1 );	
		proxy:AddInfomationTimeMsgTag( 20000425, TAG_IDX_leaveChara, param:GetParam3() );
	end
	print("OnThxKickOut end");
end


--------------------------------------------------------------------------------------
--���ޏo���@�g�p��ʒm���郍�O --EN:-- �� Log to notify the use of exit magic
--------------------------------------------------------------------------------------
function OnLeaveMagic(proxy,param)
	print("OnLeaveMagic begin");
	--���̓ǂݍ��݂̗���ɓ����Ă�����A�_�C�A���O����o���Ȃ� --EN:--If you are in another loading flow, don't even display a dialog
	if proxy:IsCompleteEvent( 4047 ) == true then
		return;
	end
--[[
	proxy:NotNetMessage_begin();
		--��4046���ޏo�m�F���j���[��Yes��I�� --EN:-- �� 4046 �� Select Yes in the exit confirmation menu
		proxy:OnYesNoDialog( 4046, "OnLeaveMenu_Yes", 20000430, 0, 2, once );
	proxy:NotNetMessage_end();
]]
	--�����̃v���C���[ID��z�M���ăQ�[���I�ɔ����鎖��ʒm --EN:--Distribute your player ID and notify that you are leaving the game
	proxy:CustomLuaCallStart( 4063 , proxy:GetLocalPlayerId() );
	OnLeaveMenu_Yes(proxy,param);
	print("OnLeaveMagic end");
end

--------------------------------------------------------------------------------------
--�������A�C�e���g�p��ʒm���郍�O --EN:--��Log notifying the use of intrusive items
--------------------------------------------------------------------------------------
function OnForceJoinBlack(proxy,param)
	print("OnForceJoinBlack begin");
	--���̓ǂݍ��݂̗���ɓ����Ă�����A�_�C�A���O����o���Ȃ� --EN:--If you are in another loading flow, don't even display a dialog
	if proxy:IsCompleteEvent( 4047 ) == true then
		return;
	end
--[[
	proxy:NotNetMessage_begin();
		--��4039�������m�F���j���[��Yes��I�� --EN:-- �� 4039 �� Select Yes in the intrusion confirmation menu
		proxy:OnYesNoDialog( 4039, "OnForceJoinBlackMenu_Yes", 20000440, 0, 2, once );
	proxy:NotNetMessage_end();
]]
	OnForceJoinBlackMenu_Yes(proxy,param);
	print("OnForceJoinBlack end");
end

--------------------------------------------------------------------------------------
--��4039�������m�F���j���[��Yes��I�� --EN:-- �� 4039 �� Select Yes in the intrusion confirmation menu
--------------------------------------------------------------------------------------
function OnForceJoinBlackMenu_Yes(proxy,param)
	print("OnForceJoinBlackMenu_Yes begin");
	
	--�������N�G�X�g���Ă��K���Q���ł���Ƃ͌���Ȃ��̂ŁA4047�͗��ĂȂ�(�኱�s��������) --EN:--Even if you request an intrusion, it is not always possible to participate, so 4047 cannot be raised (although I am a little worried)
	--�����Q��(����)���L�b�N --EN:--Kick Forced Participation (Intrusion)
	proxy:SetForceJoinBlackRequest();
	
	print("OnForceJoinBlackMenu_Yes end");
end


--------------------------------------------------------------------------------------
--�����������Ԑ؂ꂵ���̂�ʒm --EN:--Notify that the intrusion has expired
--------------------------------------------------------------------------------------
function OnFailedForceJoinBlack(proxy,param)
	print("OnFailedForceJoinBlack begin");
	proxy:RecallMenuEvent(0,8855);
	print("OnFailedForceJoinBlack end");
end


--------------------------------------------------------------------------------------
--�������𑼂�SOS�ŏ㏑�������̂�ʒm --EN:--Notify that the intrusion was overwritten by another SOS
--------------------------------------------------------------------------------------
function OnCancelForceJoinBlack(proxy,param)
	print("OnCancelForceJoinBlack begin");
	proxy:InfomationMenu( INFOMENU_TYPE_LIST, -1, 0, -1, 1 );
	proxy:AddInfomationTosBuffer( 20000002 );
	print("OnCancelForceJoinBlack end");
end

--------------------------------------------------------------------------------------
--�����[���쐬���s�����̂�ʒm --EN:--�� Notification that room creation failed
--------------------------------------------------------------------------------------
function OnFailedCreateSession(proxy,param)
	print("OnFailedCreateSession begin");
	proxy:InfomationMenu( INFOMENU_TYPE_LIST, -1, 0, -1, 1 );
	proxy:AddInfomationTosBuffer( 20001003 );
	print("OnFailedCreateSession end");
end

--------------------------------------------------------------------------------------
--�����[���Q�����s���s�����̂�ʒm --EN:--�� Notification of failure to join the room
--------------------------------------------------------------------------------------
function OnFailedJoinSession(proxy,param)
	print("OnFailedJoinSession begin");
	proxy:InfomationMenu( INFOMENU_TYPE_LIST, -1, 0, -1, 1 );
	proxy:AddInfomationTosBuffer( 20001004 );
	print("OnFailedJoinSession end");
end

--------------------------------------------------------------------------------------
--�����[�h�O�ɃL�b�N�����̂�ʒm --EN:--�� Notification of kicking before loading
--------------------------------------------------------------------------------------
function OnJoinClearedRoom(proxy,param)
	print("OnJoinClearedRoom begin");
	proxy:RecallMenuEvent(0,8870);
	print("OnJoinClearedRoom end");
end

--------------------------------------------------------------------------------------
--���u���b�N���L�b�N���ꂽ�̂�Event���ɒʒm --EN:--�� Notify the Event side that Black was kicked
--------------------------------------------------------------------------------------
function OnBeBlackKickOut(proxy,param)
	print("OnBeBlackKickOut begin");
	
	--�z���C�g���Ă΂��̂Ő�ɂ͂����Ă��� --EN:-- White will also be called, so flip it first
	if proxy:IsWhiteGhost() == true then
		return;
	end
	
	--�����̃v���C���[ID��z�M���ăQ�[���I�ɔ����鎖��ʒm --EN:--Distribute your player ID and notify that you are leaving the game
	proxy:CustomLuaCallStart( 4063 , proxy:GetLocalPlayerId() );

	proxy:LeaveSession();
	
	proxy:InfomationMenu( INFOMENU_TYPE_LIST, -1, 0, -1, 1 );
	proxy:AddInfomationTosBuffer( 20000450 );
	
	proxy:NotNetMessage_begin();
		--��4046��5�b�� --EN:-- �� 4046 �� 5 seconds later
		proxy:OnKeyTime2( 4046, "OnLeave_Limit", 5.0, 0, 1, once );
		--���̍ēǂݍ��݌n�C�x���g�̊��荞�݂�h�~ --EN:--Prevent interruption of other reloading events
		proxy:SetEventFlag(4047, true);
		--�C�x���g�����ɂ����[�h�҂��ł��鎖��ʒm --EN:-- Notify that it is waiting for loading inside the event
		proxy:SetLoadWait();
		
	proxy:NotNetMessage_end();
	
	print("OnBeBlackKickOut end");
end

--------------------------------------------------------------------------------------
--���Β��Ƀ��[�v�i��ՁF�Q�[�g�j��Event���ɒʒm --EN:--�� Notify the event side of the warp (miracle: gate) to the stone pillar
--------------------------------------------------------------------------------------
function OnGateEnchant(proxy,param)
	print("OnGateEnchant begin");
	
	--���S�񕜗v�� --EN:-- full recovery request
	proxy:RequestFullRecover();
	--�����v���L�����Z�� --EN:--Summon request canceled
	proxy:ResetSummonParam();
	proxy:WarpNextStage( 1, 0, 0, 0, -1 );
	
	print("OnGateEnchant end");
end


--���[���̃^�C���A�E�g --EN:--room timeout
function OnRoomTimeOut(proxy,param)
	print("OnRoomTimeOut begin");	
	print("OnRoomTimeOut end");
end

--�����̃^�C���A�E�g --EN:--summon timeout
function OnSummonTimeOut(proxy,param)
	print("OnSummonTimeOut begin");	
	print("OnSummonTimeOut end");
end


--��������ă��[�h���O�A�}���`�Q���J�n�@in the (�z���C�g�\�E��)  --EN:-- Just before being summoned and loading, multi-participation starts in the (White Soul)
function OnBeJoinStart_White(proxy,param)
	if proxy:IsAlive(10000) == true then
		print("OnBeJoinStart_White begin");
		proxy:RecallMenuEvent( 0, 8823 );
		proxy:NotNetMessage_begin();
		proxy:OnRequestMenuEnd( 4059, "SummonReloadStart");
		proxy:NotNetMessage_end();
		print("OnBeJoinStart_White end");
	else
		--�O�̈׃��[�u --EN:--Reeve just in case
		proxy:LeaveSession();
		proxy:ResetSummonParam();
		proxy:WARN("OnBeJoinStart_White ���Ɏ���ł�"); --EN:proxy:WARN("OnBeJoinStart_White already dead");
	end
end

--��������ă��[�h���O�A�}���`�Q���J�n�@in the (�u���b�N�\�E��)  --EN:-- Just before being summoned and loading, multi-participation starts in the (Black Soul)
function OnBeJoinStart_Black(proxy,param)
	if proxy:IsAlive( 10000 ) == true then
		print("OnBeJoinStart_Black begin");
		proxy:RecallMenuEvent( 0, 8824 );
		proxy:NotNetMessage_begin();
		proxy:OnRequestMenuEnd( 4059, "SummonReloadStart");
		proxy:NotNetMessage_end();
		print("OnBeJoinStart_Black end");
	else
		--�O�̈׃��[�u --EN:--Reeve just in case
		proxy:LeaveSession();
		proxy:ResetSummonParam();
		proxy:WARN("OnBeJoinStart_Black ���Ɏ���ł�"); --EN:proxy:WARN("OnBeJoinStart_Black is already dead");
	end
end

--��������ă��[�h���O�A�}���`�Q���J�n�@in the (����)  --EN:-- Just before being summoned and loading, multi-participation starts in the (intrusion)
function OnBeJoinStart_ForceJoin(proxy,param)
	if proxy:IsAlive(10000) == true then	
		print("OnBeJoinStart_ForceJoin begin");
		proxy:RecallMenuEvent( 0, 8825 );
		proxy:NotNetMessage_begin();
		proxy:OnRequestMenuEnd( 4059, "SummonReloadStart");
		proxy:NotNetMessage_end();
		print("OnBeJoinStart_ForceJoin end");
	else
		--�O�̈׃��[�u --EN:--Reeve just in case
		proxy:LeaveSession();
		proxy:ResetSummonParam();
		proxy:WARN("OnBeJoinStart_ForceJoin ���Ɏ���ł�"); --EN:proxy:WARN("OnBeJoinStart_ForceJoin is already dead");
	end	
end

--��������ă��[�h���O�A�}���`�Q���J�n�@in the (��������)  --EN:--Summoned and just before loading, multi-participation starts in the (forced summon)
function OnBeJoinStart_ForceSummon(proxy,param)
	if proxy:IsAlive( 10000 ) == true then
		print("OnBeJoinStart_ForceSummon begin");
		proxy:RecallMenuEvent( 0, 8826 );
		proxy:NotNetMessage_begin();
		proxy:OnRequestMenuEnd( 4059, "ForceSummonReloadStart");
		proxy:NotNetMessage_end();
		print("OnBeJoinStart_ForceSummon end");
	else
		--�O�̈׃��[�u --EN:--Reeve just in case
		proxy:LeaveSession();
		proxy:ResetSummonParam();
		proxy:WARN("OnBeJoinStart_ForceSummon ���Ɏ���ł�"); --EN:proxy:WARN("OnBeJoinStart_ForceSummon is already dead");
	end
end

--�������ꂽ���Ƃɂ��ēǂݍ��݂��L�b�N --EN:-- kick reload due to being summoned
function SummonReloadStart(proxy,param)
	print("SummonReloadStart begin");
	--���[�������݂�������� --EN:--Enter if the room exists
	if	proxy:IsInParty() == true then
		--�����Ă����� --EN:--If you were alive
		if proxy:IsAlive(10000)  == true then
			proxy:SummonedMapReload();
		else
			--�O�̈׃��[�u --EN:--Reeve just in case
			proxy:LeaveSession();
			proxy:ResetSummonParam();
			proxy:WARN("SummonReloadStart ���[���L�莀��ł�"); --EN:proxy:WARN("SummonReloadStart room dead");
		end
	else
		if proxy:IsAlive(10000)  == false then
			proxy:ResetSummonParam();
			proxy:WARN("SummonReloadStart ���[����������ł�"); --EN:proxy:WARN("SummonReloadStart no room dead");
		end
	end
	print("SummonReloadStart end");
end

--�������ꂽ���Ƃɂ��ēǂݍ��݂��L�b�N(�������җp) --EN:--Kick reload due to being summoned (for forced summoning)
function ForceSummonReloadStart(proxy,param)
	print("ForceSummonReloadStart begin");
	--���[�������݂�������� --EN:--Enter if the room exists
	if	proxy:IsInParty() == true then
		if proxy:IsAlive(10000) == true then
			--���S�񕜗v�� --EN:-- full recovery request
			proxy:RequestFullRecover();
			proxy:SummonedMapReload();
		else
			--�O�̈׃��[�u --EN:--Reeve just in case
			proxy:LeaveSession();
			proxy:ResetSummonParam();
			proxy:WARN("ForceSummonReloadStart ���[���L�莀��ł�"); --EN:proxy:WARN("ForceSummonReloadStart with room dead");
		end
	else
		if proxy:IsAlive(10000) == false then
			proxy:ResetSummonParam();
			proxy:WARN("ForceSummonReloadStart ���[����������ł�"); --EN:proxy:WARN("ForceSummonReloadStart no room dead");
		end
	end
	print("ForceSummonReloadStart end");
end


--�}���`�v���C�ɎQ���������̃��b�Z�[�W --EN:--Message when joining multiplayer
function OnJoinMutiplay(proxy,param)
	print("OnJoinMutiplay begin");	
	print("OnJoinMutiplay end");
end

-------------------------------------------------------------------------------------
--�Z�b�V�����ɎQ���������̃��b�Z�[�W --EN:--Message when joining a session
-------------------------------------------------------------------------------------
--�z���C�g�\�E�� --EN:--White Soul
function JoinSession_White(proxy,param)
	print("JoinSession_White begin");
	proxy:RecallMenuEvent( 0, 8813 );
	print("JoinSession_White end");
end

--�u���b�N�\�E�� --EN:--Black Soul
function JoinSession_Black(proxy,param)
	print("JoinSession_Black begin");
	proxy:RecallMenuEvent( 0, 8814 );
	print("JoinSession_Black end");
end

--���� --EN:--Intrusion
function JoinSession_ForceJoin(proxy,param)
	print("JoinSession_ForceJoin begin");
	proxy:RecallMenuEvent( 0, 8815 );
	print("JoinSession_ForceJoin end");
end

--�������� --EN:--forced summon
function JoinSession_ForceSummon(proxy,param)
	print("JoinSession_ForceSummon begin");
	proxy:RecallMenuEvent( 0, 8816 );
	print("JoinSession_ForceSummon end");
end



function JoinSession(proxy,param)
	print("JoinSession begin");	
	--�z���C�g�\�E�� --EN:--White Soul
	if proxy:GetTempSummonParam() == -1 then
		proxy:RecallMenuEvent( 0, 8813 );
	--�u���b�N�\�E�� --EN:--Black Soul
	elseif proxy:GetTempSummonParam() == -2 then
		proxy:RecallMenuEvent( 0, 8814 );
	end
	print("JoinSession end");
end

--�Z�b�V�����ɋ����Q���������̃��b�Z�[�W --EN:--Message when forcibly joining a session
function ForceJoinSession(proxy,param)
	print("ForceJoinSession begin");	
	proxy:RecallMenuEvent( 0, 8815 );
	print("ForceJoinSession end");
end

---------------------------------------------------------------------------------------------------------
--��4058���������z�M --EN:-- �� 4058 �� Delivery during summoning
---------------------------------------------------------------------------------------------------------
--4058�������������z�M������-- --EN:--4058������During Summoning������--
function OnEvent_Call_SOS(proxy,param)
	print("OnEvent_Call_SOS begin");
	proxy:LuaCallStartPlus(4058, 1, proxy:GetLocalPlayerId());
	print("OnEvent_Call_SOS end");
end

function OnEvent_Call_BlackSOS(proxy,param)
	print("OnEvent_Call_BlackSOS begin");
	proxy:LuaCallStartPlus(4058, 2, proxy:GetLocalPlayerId());
	print("OnEvent_Call_BlackSOS end");
end

--�z���C�g�\�E���T�C��������(SOS���j���[��OK���������^�C�~���O) --EN:--Summon White Soul Sign (when you press OK in the SOS menu)
--(4058, 1, playerId)
function Call_WhiteSos(proxy,param)
	print("Call_WhiteSos begin");
	proxy:RecallMenuEvent( 0, 8810 );
	print("Call_WhiteSos end");
end

--�u���b�N�\�E���T�C��������(SOS���j���[��OK���������^�C�~���O) --EN:--Summon Black Soul Sign (when you press OK in the SOS menu)
--(4058, 2, playerId)
function Call_BlackSos(proxy,param)
	print("Call_BlackSos begin");
	proxy:RecallMenuEvent( 0, 8811 );
	print("Call_BlackSos end");
end
--4058�������������z�M������-- --EN:--4058������During summoning ������--





--�z���C�g�\�E���T�C�����o���� --EN:--Sent White Soul sign
function OnEvent_SendSoulSign_White(proxy,param)
	print("OnEvent_SendSoulSign_White begin");
	print("OnEvent_SendSoulSign_White end");
end

--�u���b�N�\�E���T�C�����o���� --EN:--Sent Black Soul Sign
function OnEvent_SendSoulSign_Black(proxy,param)
	print("OnEvent_SendSoulSign_Black begin");
	print("OnEvent_SendSoulSign_Black end");
end

--�����\�E���T�C�����o���� --EN:--Sent an intrusion soul sign
function OnEvent_SendSoulSign_ForceJoin(proxy,param)
	print("OnEvent_SendSoulSign_ForceJoin begin");
	proxy:RecallMenuEvent( 0, 8805 );
	print("OnEvent_SendSoulSign_ForceJoin end");
end

--------------------------------------------------------------------------------------
--���h����Event���ɒʒm --EN:--�� Notification of resurrection to the Event side
--------------------------------------------------------------------------------------
function OnReviveMagic(proxy,param)
	print("OnReviveMagic begin");
	if proxy:IsBlackGhost() == true then
		return;
	end
	
	--(�z�X�g�̂��߂�)�z���C�g�h���J�E���g�AQWC���Z�p�̃n���h�����Ă� --EN:--(for host) call handler for white revive count, QWC addition
	if	proxy:IsWhiteGhost() == true then
		proxy:LuaCallStart( 4055, 1 );
	end
	
	--�����̃v���C���[ID��z�M���ăQ�[���I�ɔ����鎖��ʒm --EN:--Distribute your player ID and notify that you are leaving the game
	proxy:CustomLuaCallStart( 4063 , proxy:GetLocalPlayerId() );
	
	--�ޏo --EN:--Exit
	proxy:LeaveSession();
	
	proxy:InfomationMenu( INFOMENU_TYPE_LIST, -1, 0, -1, 1 );
	proxy:AddInfomationTosBuffer( 20000445 );
	
	proxy:NotNetMessage_begin();
		--��4046��5�b�� --EN:-- �� 4046 �� 5 seconds later
		proxy:OnKeyTime2( 4046, "OnReviveMagic_1", 5.0, 0, 1, once );
		--���̍ēǂݍ��݌n�C�x���g�̊��荞�݂�h�~ --EN:--Prevent interruption of other reloading events
		proxy:SetEventFlag(4047, true);
		--�C�x���g�����ɂ����[�h�҂��ł��鎖��ʒm --EN:-- Notify that it is waiting for loading inside the event
		proxy:SetLoadWait();
		
	proxy:NotNetMessage_end();
	
	print("OnReviveMagic end");
end

function OnReviveMagic_1(proxy,param)
	print("OnReviveMagic_1 begin");	
	--��������̂ŕ����A�j���t���O���Z�b�g --EN:-- Set the resurrection animation flag because it will be revived
	proxy:SetAliveMotion( true );
	--���S�񕜗v�� --EN:-- full recovery request
	proxy:RequestFullRecover();
	
	--�C�x���g�t���O���[���o�b�N --EN:--eventflag rollback
	proxy:SetFlagInitState(2);
	--��������̂Ńy�i���e�B�Ō��������p�����[�^�����ɖ߂�(�ő�l�̂�) --EN:--Since it will be revived, restore the parameters that have been reduced by the penalty (maximum value only)
	proxy:EraseEventSpecialEffect( 10000, 101 );	
	
	--������Ԃɐݒ肵����ŁA�����̌������ʒu�փ��[�v	 --EN:--Warp to your blood letter position after setting it to a living state
	proxy:SetSelfBloodMapUid();
	--proxy:RevivePlayer();
	proxy:RevivePlayerNext();--���̃��[�h�őh�� --EN:--Respawn on next load
	proxy:WarpNextStageKick();
	print("OnReviveMagic_1 end");	
end

--------------------------------------------------------------------------------------
--���O���C�S�[�X�g����f�����Y�\�E���ɂ�镜�� --EN:--�� Revived by Demon's Soul from Gray Ghost
--------------------------------------------------------------------------------------
function OnDemonsSoulRevive(proxy,param)
	print("OnDemonsSoulRevive begin");
	
	--��������̂Ńy�i���e�B�Ō��������p�����[�^�����ɖ߂�(�ő�l�̂�) --EN:--Since it will be revived, restore the parameters that have been reduced by the penalty (maximum value only)
	proxy:EraseEventSpecialEffect( 10000, 101 );
	
	proxy:RevivePlayer();
	proxy:SetReviveWait( false );--�����҂���ԃt���O�����낵�Ă��� --EN:--Put down the resurrection waiting state flag
	
	--�����̌�������\�� --EN:--Hide own blood letters
	--proxy:InvalidMyBloodMarkInfo();
	
	proxy:SetEventFlag( 15112,true );
	proxy:SetEventFlag( 15113,true );
	proxy:SetEventFlag( 15114,true );
	proxy:SetEventFlag( 15115,true );
	
	proxy:SetEventFlag( 15116,true );
	proxy:SetEventFlag( 15117,true );
	proxy:SetEventFlag( 15118,true );
	proxy:SetEventFlag( 15119,true );	
	
	--�e�L�X�g���o --EN:--Text rendering
	proxy:SetTextEffect(TEXT_TYPE_Revival);
	
	--�p�j�f�[�������A�p�C�x���g�n���h�� --EN:--Event handler for wandering daemon return
	proxy:LuaCallStart( 4032, 100 );
	
	print("OnDemonsSoulRevive end");
end


--------------------------------------------------------------------------------------
--��4046���ޏo�m�F���j���[��Yes��I�� --EN:-- �� 4046 �� Select Yes in the exit confirmation menu
--------------------------------------------------------------------------------------
function OnLeaveMenu_Yes(proxy,param)
	print("OnLeaveMenu_Yes begin");
	--�_�C�A���O���J����Ă���Œ��ɕʂ̗���ɓ���ꍇ������̂ŁA --EN:--Because you may enter another flow while the dialog is open,
	--�����ł�����x�͂��� --EN:--Flick again here
	if proxy:IsCompleteEvent( 4047 ) == true then
		return;
	end
	
	--�C�x���g�����ɂ����[�h�҂��ł��鎖��ʒm --EN:-- Notify that it is waiting for loading inside the event
	proxy:SetLoadWait();
	--�ޏo���b�Z�[�W��z�M --EN:--Delivery leave message
	if	proxy:IsWhiteGhost() == true then
	proxy:LuaCallStartPlus(4046, 1, proxy:GetLocalPlayerId() );
	elseif	proxy:IsBlackGhost() == true then
		proxy:LuaCallStartPlus(4046, 2, proxy:GetLocalPlayerId() );
		--�������҂Ȃ� --EN:--Forcibly summoned
		if	proxy:GetTempSummonParam() > 0 then
			proxy:LuaCallStartPlus( 4046, 3, proxy:GetLocalPlayerId() );		
		--�������҈ȊO�̃u���b�N�Ȃ� --EN:--For blacks other than forced summons
		else
			--�E�ރy�i���e�B --EN:--Withdrawal Penalty
			proxy:SetLeaveSoulSteel();
		end
	end

	--�Z�b�V������؂� --EN:--end session
	proxy:LeaveSession();
	
	--�����������烍�[�h�͕K�v�Ȃ��̂ŃJ�b�g --EN:--If you survive, you don't need to load, so cut
	if	proxy:IsLivePlayer() == true then
		print("OnLeaveMenu_Yes return end");
		return;
	end
	
	--PT�ɎQ�����Ď��S�����ꍇ�A���甲�����ꍇ�̓\�E���̃y�i���e�B������܂��B --EN:--If you die while participating in a PT, you will receive a soul penalty if you leave voluntarily.
	--�\�E���y�i���e�B --EN:--Soul Penalty
	proxy:DeathPenalty( DeathPenalty_SoulAdjust, DeathPenalty_SoulMAX );
	
	--���̍ēǂݍ��݌n�C�x���g�̊��荞�݂�h�~ --EN:--Prevent interruption of other reloading events
	proxy:SetEventFlag(4047, true);
	
	proxy:NotNetMessage_begin();
		--��4046��5�b�� --EN:-- �� 4046 �� 5 seconds later
		proxy:OnKeyTime2( 4046, "OnLeave_Limit", 5.0, 0, 1, once );
	proxy:NotNetMessage_end();
	print("OnLeaveMenu_Yes end");
end

function LeaveMessage(proxy,param)
	print("LeaveMessage begin");
	if proxy:GetLocalPlayerId() == param:GetParam3() then
		proxy:InfomationMenu( INFOMENU_TYPE_LIST, -1, 0, -1, 1 );
		proxy:AddInfomationTosBuffer( 20000430 );
	else
		proxy:InfomationMenu( INFOMENU_TYPE_LIST, -1, 0, -1, 1 );
		proxy:AddInfomationTimeMsgTag( 20000435, TAG_IDX_leaveChara, param:GetParam3() );
	end
	print("LeaveMessage end");
end

function OnLeave_Limit(proxy,param)
	print("OnLeave_Limit begin");
	
	--�C�x���g�t���O���[���o�b�N --EN:--eventflag rollback
	proxy:SetFlagInitState(2);
	
	--�����O�̈ʒu�ݒ� --EN:--Position settings before summoning
	proxy:SetSummonedPos();
	
	--���݂̃}�b�v�Ɠ���ID�����}�b�vID�Ƃ��Đݒ� --EN:--Set the same ID as the current map as the next map ID
	proxy:SetDefaultMapUid(-1);
	
	--���[�v���s�� --EN:--do warp
	proxy:WarpNextStageKick();

	--�O���C�S�[�X�g�� --EN:--Gray ghost
	--proxy:SetChrTypeDataGrey();
	proxy:SetChrTypeDataGreyNext();

	print("OnLeave_Limit end");
end

--------------------------------------------------------------------------------------
--���񐳏�Ƀl�b�g���[�N���ؒf���ꂽ(�z�X�g�����Ȃ��Ȃ�����Ƃ�)�̂�ʒm���郍�O --EN:--�� A log that notifies that the network is disconnected abnormally (such as the host disappearing)
--------------------------------------------------------------------------------------
function OnRoomDisappeared(proxy,param)
	print("OnRoomDisappeared begin");
	if proxy:IsCompleteEvent( 4047 ) == true then
		return;
	end
	proxy:InfomationMenu( INFOMENU_TYPE_LIST, -1, 0, -1, 1 );
	proxy:AddInfomationTosBuffer( 20001000 );
	if proxy:IsLivePlayer() == false and proxy:IsGreyGhost() == false then
		proxy:NotNetMessage_begin();
			--��4046��5�b�� --EN:-- �� 4046 �� 5 seconds later
			proxy:OnKeyTime2( 4046, "OnLeave_Limit", 5.0, 0, 1, once );
			
			--���̍ēǂݍ��݌n�C�x���g�̊��荞�݂�h�~ --EN:--Prevent interruption of other reloading events
			proxy:SetEventFlag(4047, true);
			--�C�x���g�����ɂ����[�h�҂��ł��鎖��ʒm --EN:-- Notify that it is waiting for loading inside the event
			proxy:SetLoadWait();
			--�t���O�̃��[���o�b�N --EN:--flag rollback
			proxy:SetFlagInitState(2);
			
		proxy:NotNetMessage_end();
	end
	print("OnRoomDisappeared end");
end


--------------------------------------------------------------------------------------
--��4041�������ʒm�� --EN:-- �� 4041 �� summoning notification ��
--------------------------------------------------------------------------------------
--�z���C�g�\�E���T�C���p --EN:--For White Soul Sign
function SummonInfoMsg_White(proxy,param)
	if param:IsNetMessage() == true then	
		--�N���C�A���g�Ŗ����Ȃ�@�V���O���@or�@�z�X�g --EN:-- Single or host if not a client
		if	proxy:IsClient() == false then
			if proxy:EventTagInsertString_forPlayerNo( TAG_IDX_joinChara, param:GetParam3() ) == true then
				proxy:RecallMenuEvent( 0, 8830 );			
				SummonSuccess(proxy,param:GetParam3());
			else
				proxy:WARN("�S�[�X�g���擾�ł��Ȃ�����"); --EN:proxy:WARN("Could not get ghost name");
			end
		else
			if proxy:EventTagInsertString_forPlayerNo( TAG_IDX_joinChara, param:GetParam3() ) == true then
				proxy:RecallMenuEvent( 0, 8843 );
			else
				proxy:WARN("�z�X�g���擾�ł��Ȃ�����"); --EN:proxy:WARN("Failed to get host name");
			end
		end
	else
		if proxy:EventTagInsertString_forPlayerNo( TAG_IDX_liveChara, proxy:GetHostPlayerNo() ) == true then
			proxy:RecallMenuEvent( 0, 8833 );
		end
	end
end

--�u���b�N�\�E���T�C���p --EN:--For Black Soul Sign
function SummonInfoMsg_Black(proxy,param)
	if param:IsNetMessage() == true then
		--�N���C�A���g�Ŗ����Ȃ�@�V���O���@or�@�z�X�g --EN:-- Single or host if not a client
		if	proxy:IsClient() == false then
			if proxy:EventTagInsertString_forPlayerNo( TAG_IDX_joinChara, param:GetParam3() ) == true then
				proxy:RecallMenuEvent( 0, 8831 );			
				SummonSuccess(proxy,param:GetParam3());
			end
		else
			if proxy:EventTagInsertString_forPlayerNo( TAG_IDX_joinChara, param:GetParam3() ) == true then
				proxy:RecallMenuEvent( 0, 8844 );			
			end
		end
	else
		if proxy:EventTagInsertString_forPlayerNo( TAG_IDX_liveChara, proxy:GetHostPlayerNo() ) == true then
			proxy:RecallMenuEvent( 0, 8834 );		
		end
	end
end

--�����Q��(����)�p --EN:--For forced participation (intrusion)
function SummonInfoMsg_ForceJoinBlack(proxy,param)
	if param:IsNetMessage() == true then
		--�N���C�A���g�Ŗ����Ȃ�@�V���O���@or�@�z�X�g --EN:-- Single or host if not a client
		if	proxy:IsClient() == false then
			if proxy:EventTagInsertString_forPlayerNo( TAG_IDX_joinChara, param:GetParam3() ) == true then
				proxy:RecallMenuEvent( 1, 8832 );			
				SummonSuccess(proxy,param:GetParam3());
			end
		--��O�� --EN:--third party
		else
			if proxy:EventTagInsertString_forPlayerNo( TAG_IDX_joinChara, param:GetParam3() ) == true then
				proxy:RecallMenuEvent( 1, 8845 );			
			end
		end
	else
		if proxy:EventTagInsertString_forPlayerNo( TAG_IDX_liveChara, proxy:GetHostPlayerNo() ) == true then
			proxy:RecallMenuEvent( 1, 8835 );		
		end
	end
end

--���������p --EN:--For forced summoning
function SummonInfoMsg_ForceSummonBlack(proxy,param)
	if param:IsNetMessage() == true then
		--�N���C�A���g�Ŗ����Ȃ�@�V���O���@or�@�z�X�g --EN:-- Single or host if not a client
		if	proxy:IsClient() == false then
			if proxy:EventTagInsertString_forPlayerNo( TAG_IDX_joinChara, param:GetParam3() ) == true then
				proxy:RecallMenuEvent( 1, 8846 );
				SummonSuccess(proxy,param:GetParam3());
			end
			
		else
			if proxy:EventTagInsertString_forPlayerNo( TAG_IDX_joinChara, param:GetParam3() ) == true then
				proxy:RecallMenuEvent( 1, 8846 );			
			end
		end
	else
		if proxy:EventTagInsertString_forPlayerNo( TAG_IDX_liveChara, proxy:GetHostPlayerNo() ) == true then
			proxy:RecallMenuEvent( 1, 8836 );		
		end
	end
end

function SummonSuccess(proxy, playerId)
	proxy:SummonSuccess(playerId);
end




--------------------------------------------------------------------------------------
--���l�b�g�v���C�������̃^�C���A�E�g(�܂萶����) --EN:--�� Net player summoning timeout (that is, surviving side)
--------------------------------------------------------------------------------------
function LiveSide_SummonTimeOut(proxy,param)
	print("LiveSide_SummonTimeOut begin");
	proxy:InfomationMenu( INFOMENU_TYPE_LIST, -1, 0, -1, 1 );
	proxy:AddInfomationTosBuffer( 20000100 );
	print("LiveSide_SummonTimeOut end");
end

--------------------------------------------------------------------------------------
--��4045���{�X�����ւ̖��@�ǂ��ʉ߉\�ł���ƒʒm(�N���C�A���g�ɑ΂���)�� --EN:--�� 4045 �� Notify the client that the magic wall to the boss room can be passed ��
--------------------------------------------------------------------------------------

function PossibleInfo_GoToTheBossArea(proxy, param)
	print("PossibleInfo_GoToTheBossArea begin");
	
	--������Ԃ̐l���{�X�����O��ǂ�ʉ߂���������Ƃ��ɃR�[������� --EN:--Called when a living person has passed through the barrier in front of the boss room.
	
	if param:IsNetMessage() == true then --�z�M�Ŏ󂯎�����l�� �N���C�A���g		 --EN:--The person who received the delivery is the client
		--���������ȊO�̃S�[�X�g		 --EN:-- Ghosts other than forced summons
		if		proxy:GetTempSummonParam() == -1 then
			--�z���C�g�Ƀ{�X�����ʒm --EN:--Boss room notification to white
			--proxy:ShowGenDialog(10010700,1,1,true);
			proxy:RecallMenuEvent( 0, 9500 );
		elseif 	proxy:GetTempSummonParam() == -2 then
			--�ʏ�u���b�N�Ɏ��s�ʒm --EN:--Normal failure notification in black
			--Failed_BossAreaMission(proxy,param);
		elseif 	proxy:GetTempSummonParam() == -3 then
			--�����u���b�N�Ɏ��s�ʒm --EN:-- Failure notification to intrusion black
			--Failed_BossAreaMission(proxy,param);
		end
		
	else --�z�M�ȊO�ł��̃n���h�����Ă΂ꂽ�Ƃ��́A�Ă񂾖{�l�̂Ƃ� --EN:--When this handler is called for something other than delivery, the person who called it
		print("�N���C�A���g�փ{�X�����ɓ����悤�ɂȂ����ƒʒm���܂���"); --EN:print("I notified the client that I can now enter the boss room");
	end	
	print("PossibleInfo_GoToTheBossArea end");
end

function Failed_BossArea(proxy,param)
	print("Failed_BossArea begin");
	--������Ԃ̐l���{�X�����O��ǂ𒲂ׂ��Ƃ��ɃR�[�������	 --EN:--Called when a living person examines the barrier in front of the boss room
	if param:IsNetMessage() == true then --�z�M�Ŏ󂯎�����l�� �N���C�A���g --EN:--The person who received the delivery is the client
		--���������ȊO�̃S�[�X�g		 --EN:-- Ghosts other than forced summons
		if		proxy:GetTempSummonParam() == -1 then
			--�������Ȃ� --EN:--do nothing
		elseif 	proxy:GetTempSummonParam() == -2 then
			--�ʏ�u���b�N�Ɏ��s�ʒm --EN:--Normal failure notification in black
			Failed_BossAreaMission(proxy,param);
		elseif 	proxy:GetTempSummonParam() == -3 then
			--�����u���b�N�Ɏ��s�ʒm --EN:-- Failure notification to intrusion black
			Failed_BossAreaMission(proxy,param);
		end
		
	else --�z�M�ȊO�ł��̃n���h�����Ă΂ꂽ�Ƃ��́A�Ă񂾖{�l�̂Ƃ� --EN:--When this handler is called for something other than delivery, the person who called it
		print("�{�X�����j�~���s��ʒm���܂���"); --EN:print("Notified failure to block boss room");
	end	
	print("Failed_BossArea end");
end

function Failed_BossAreaMission(proxy,param)
	print("Failed_BossAreaMission begin");
	if proxy:IsCompleteEvent(4047) == false then
		--�{�X�Q�[�W���N���A --EN:--clear the boss gauge
		proxy:ClearBossGauge();	
		--�����̃v���C���[ID��z�M���ăQ�[���I�ɔ����鎖��ʒm --EN:--Distribute your player ID and notify that you are leaving the game
		--proxy:CustomLuaCallStart( 4063 , proxy:GetLocalPlayerId() );
		--�ڕW���s --EN:--Target failed
		MissionFailed(proxy,param);		
		--���̍ēǂݍ��݌n�C�x���g�̊��荞�݂�h�~ --EN:--Prevent interruption of other reloading events
		proxy:SetEventFlag(4047, true);
		--�C�x���g�����ɂ����[�h�҂��ł��鎖��ʒm --EN:-- Notify that it is waiting for loading inside the event
		proxy:SetLoadWait();
		--���S�����܂��Ă�₱�����Ȃ�Ȃ��l�ɂ��� --EN:--Don't let death get in the way of complications
		proxy:SetEventFlag( 4000, true );
		--�����]���Ɋ܂܂��̂Ő�ɔ����� --EN:-- Black is included in the evaluation, so exit first
		proxy:LeaveSession()
		
		proxy:NotNetMessage_begin();
			--2�b��ɂ̓��[�����甲���� --EN:--Exit the room after 2 seconds
			--proxy:OnKeyTime2( 4045 , "Failed_BossAreaMission_LeavePT",2.0,0,0,once);
			--5�b��ɂ͍ă��[�h --EN:-- reload after 5 seconds
			proxy:OnKeyTime2( 4045 , "Failed_BossAreaMission_LeaveMap",5.0,0,0,once);
		proxy:NotNetMessage_end();
		--�����E�A�j������	 --EN:--Own world animation processing
		if 	proxy:IsBlackGhost() == true then
			proxy:RepeatMessage_begin();
			proxy:NotNetMessage_begin();
				--�A�j���Đ��ׂ̈̎��L�����Ď� --EN:--Monitoring your character for animation playback
				proxy:OnRegistFunc( 4050 , "Check_BlockClearAnim","BlockClearAnim",20,once);
			proxy:NotNetMessage_end();
			proxy:RepeatMessage_end();		
		end
	end
	print("Failed_BossAreaMission end");
end

function Failed_BossAreaMission_LeavePT(proxy,param)
	print("Failed_BossAreaMission_LeavePT begin");
	--�����]���Ɋ܂܂��̂Ő�ɔ����� --EN:-- Black is included in the evaluation, so exit first
	proxy:LeaveSession();
	print("Failed_BossAreaMission_LeavePT end");
end

function Failed_BossAreaMission_LeaveMap(proxy,param)
	print("Failed_BossAreaMission_LeaveMap begin");
	--�\�E���y�i���e�B --EN:--Soul Penalty
	proxy:DeathPenalty( DeathPenalty_SoulAdjust, DeathPenalty_SoulMAX );
	--�C�x���g�t���O���[���o�b�N --EN:--eventflag rollback
	proxy:SetFlagInitState(2);
	--�����O�̈ʒu�ݒ� --EN:--Position settings before summoning
	proxy:SetSummonedPos();			
	--���݂̃}�b�v�Ɠ���ID�����}�b�vID�Ƃ��Đݒ� --EN:--Set the same ID as the current map as the next map ID
	proxy:SetDefaultMapUid(-1);
	--���[�v���s�� --EN:--do warp
	proxy:WarpNextStageKick();
	--�O���C�S�[�X�g�� --EN:--Gray ghost
	--proxy:SetChrTypeDataGrey();
	proxy:SetChrTypeDataGreyNext();
	print("Failed_BossAreaMission_LeaveMap end");
end

--------------------------------------------------------------------------------------
--��4034���}���`�����@�Ǘp(�Z�b�V�������Ȃ�����)�� --EN:-- �� 4034 �� For multi-time magic wall (session connected) ��
--------------------------------------------------------------------------------------
function OnEvent_4034(proxy, param)
	print("OnEvent_4034 begin");
	
	if proxy:IsClient() == false then
		if proxy:GetBlockId() > 0 then
			print("�}���`�����@��ON BlockId ",proxy:GetBlockId() ); --EN:print("Magic wall ON when multiplayer BlockId",proxy:GetBlockId() );
			local MultiWall = 1995 - proxy:GetBlockId() + 1;
			Lua_MultiWall(proxy,MultiWall);
			proxy:SetEventFlag( 3000 + proxy:GetBlockId() , true );
		else
			print("�u���b�N0�Ȃ̂Ŗ��@�Ǐ����X���[���܂�"); --EN:print("Because it is block 0, the magic wall processing will be bypassed");
		end
	else--�N���C�A���g --EN:--client
		if proxy:IsCompleteEvent( 3001 ) == true then
			Lua_MultiWall(proxy,1995);
		elseif proxy:IsCompleteEvent( 3002 ) == true then
			Lua_MultiWall(proxy,1994);
		elseif proxy:IsCompleteEvent( 3003 ) == true then
			Lua_MultiWall(proxy,1993);
		else
			print("�N���C�A���g �u���b�N0����") --EN:print("Ignore client block 0")
		end		
	end
	
	print("�|�����萔�}���`�ύX"); --EN:print("polydramatic constant multi change");
	REMO_FLAG = 2;
	
	print("OnEvent_4034 end");
end

--�}���`�Ǌ֐� --EN:--Multi wall function
function Lua_MultiWall(proxy,id)
	print("�}���`�����@��ON");	 --EN:print("Magic wall ON when multiplayer");
	local MultiSfx = id - 8;
	print("�}���`��ID: ",id); --EN:print("Multi Wall ID: ",id);
	print("�}���`��SFX�@ID:",MultiSfx); --EN:print("Multi Wall SFX ID:", MultiSfx);
	proxy:SetColiEnable( id, true );
	proxy:SetDrawEnable( id, true );	
	proxy:ValidSfx( MultiSfx );
end

--------------------------------------------------------------------------------------
--��4035���}���`�����@�Ǘp(�Z�b�V�������Ȃ����Ă���Ƃ�����؂ꂽ)�� --EN:-- �� 4035 �� For magic wall when multi-session (disconnected from the time the session was connected) ��
--------------------------------------------------------------------------------------
function OnEvent_4035(proxy, param)
	print("OnEvent_4035 begin");
	
	proxy:SetEventFlag( 3001,false);
	proxy:SetEventFlag( 3002,false);
	proxy:SetEventFlag( 3003,false);
	
	if proxy:GetBlockId() > 0 then	
		print("�}���`�����@��OFF BlockId ",proxy:GetBlockId() ); --EN:print("Magic Wall OFF BlockId when multiplayer",proxy:GetBlockId() );
		local MultiWall = 1995 - proxy:GetBlockId() + 1;
		local MultiSfx = MultiWall - 8;
		print("�}���`��ID: ",MultiWall); --EN:print("MultiWall ID: ",MultiWall);
		print("�}���`��SFX�@ID:",MultiSfx); --EN:print("Multi Wall SFX ID:", MultiSfx);
		proxy:SetColiEnable( MultiWall, false );
		proxy:SetDrawEnable( MultiWall, false );
		proxy:InvalidSfx( MultiSfx ,true);
	else
		print("�u���b�N0�Ȃ̂Ŗ��@�Ǐ����X���[���܂�"); --EN:print("Because it is block 0, the magic wall processing will be bypassed");
	end
		
	print("�|�����萔�V���O���ύX"); --EN:print("polydramatic constant single change");
	REMO_FLAG = 0;
	
	print("OnEvent_4035 end");
end

function WhiteReviveCount(proxy,param)
	print("WhiteReviveCount begin");
	--�N���C�A���g�Ŗ����Ȃ�@�V���O���@or�@�z�X�g --EN:-- Single or host if not a client
	if	proxy:IsClient() == false then
		print("WhiteReviveCount AddQWC AddHelpWhiteCount");
		--�����Ńz���C�g�����J�E���g���Z������ǉ� --EN:-- Add white resurrection count addition processing here
		proxy:LuaCallStartPlus( 4056, 1, 200 );--AddQWC�z�M(�z���C�g�𕜊�������QWC���Z) --EN:--AddQWC distribution (QWC addition that revived white)
		proxy:AddHelpWhiteGhost();--�������z���C�g�̐������Z --EN:--add the number of whites helped
	end
	print("WhiteReviveCount end");
end

--------------------------------------------------------------------------------------
--��NPC��Ԋ֘A�i�擾�E�ݒ�j --EN:--�� NPC status related (get/set)
--------------------------------------------------------------------------------------
--�n�������X�g���珉����(1���t���O�������Ă��Ȃ��ꍇ�͎w�肵�������t���O�𗧂Ă�) --EN:--Initialize from the passed list (set the specified initial flag if no flag is set)
function SetFirstNpcStateFlag(proxy, param, state_list, set_flag )	
	--�t���O��1�ł������Ă��邩�H --EN:--Is even one flag set?
	local nowflag = GetNpcStateFlag(proxy,param,state_list);
	if nowflag ~= 0 then
		print("SetFirstNpcStateFlag Now to ", nowflag );
		return;
	end
	print("SetFirstNpcStateFlag Initialize set to ", set_flag );
	proxy:SetEventFlag( set_flag, true );
end

--�n�������X�g����Z�b�g --EN:--set from passed list
function SetNpcStateFlag(proxy, param, state_list, set_flag )
	print("SetNpcStateFlag begin set to ", set_flag );
	
	--���݂̂����Ă���t���O���擾 --EN:-- Get current flag
	local now_state = GetNpcStateFlag(proxy,param,state_list);
	
	--���݂̏�ԂƃZ�b�g��������Ԃ��Ⴄ�� --EN:--When the current state and the state you want to set are different
	if now_state ~= set_flag then
		--���X�g�ɃZ�b�g�������A�N�V����ID���o�^����Ă����ꍇ�A --EN:--If the action ID you want to set is registered in the list,
		--���݂̏�ԃt���O�����낵�A�V���ɏ�ԃt���O���Z�b�g���� --EN:--unset the current state flag and set the new state flag
		local flag_num = table.getn( state_list );
		for i=1, flag_num , 1 do
			if state_list[i] == set_flag then
				proxy:SetEventFlag( set_flag, true );
				proxy:SetEventFlag( now_state, false );
			end
		end
	end
end

--�n�������X�g����t���O�������Ă���A�N�V����ID���擾 --EN:--Get flagged action IDs from the passed list
function GetNpcStateFlag(proxy, param, state_list)

	--�v�f�����擾 --EN:-- get number of elements
	local flag_num = table.getn( state_list );
	
	
	for i=1, flag_num , 1 do
		if proxy:IsCompleteEvent( state_list[i] ) == true then
			return state_list[i];
		end
	end
	return 0;
end


--------------------------------------------------------------------------------------
--�������h�����q�֘A�C�x���g�ŗ��p����֐� --EN:--Functions used in events related to Prince Lendl
--------------------------------------------------------------------------------------

--����ԍŏ��ɉ���1�ɂ����Ƃ��̏�ԃZ�b�g�p(����1��Initialize�ŌĂ�) --EN:--�� For setting the state when you first come to the castle 1 (call it in Initialize of the castle 1)
function SetFirstRendolState( proxy , param )
	
	--�����q�̏�Ԃ����ݒ�̂Ƃ� ������Ԃ��Z�b�g --EN:--��When the state of the prince is not set Set the initial state
	
	if GetRendolState(proxy , param) ~= 0 then
		return false;
	end
	
	--�z�ꕺ�m�����ď�ԂɑJ�ڂ����݂� --EN:--Help the slave soldier and try to transition to the state
	return ( SetRendolStateFlag( proxy, param, RENDOL_STATE_HELP_FOR_DOREI_HEISI , possible_transration_list_m02_00_00_00 ) );
	
end
	
	
--�������h�����q�̌��݂̏�Ԃ��擾 --EN:--�� Get Prince Lendl's current status
function GetRendolState( proxy , param )
	
	local state_flag_num = 0;
	state_flag_num = table.getn(possible_transration_list_m02_00_00_00);--����1�̃t���O�� --EN:-- Number of flags in Royal Castle 1
	
	for i=1, state_flag_num, 1 do
		local look_state = possible_transration_list_m02_00_00_00[i];
		if proxy:IsCompleteEvent( look_state ) == true then
--			print("�����h�����q�̏�ԃt���O��["..look_state.."]�ł�"); --EN:-- print("Prince Lendl's state flag is ["..look_state.."]");
			return look_state;
		end
	end
	
	state_flag_num = table.getn(possible_transration_list_m02_01_00_00);--����2�̃t���O�� --EN:-- Number of flags in Ojo 2
	
	for i=1, state_flag_num, 1 do
		local look_state = possible_transration_list_m02_01_00_00[i];
		if proxy:IsCompleteEvent( look_state ) == true then
--			print("�����h�����q�̏�ԃt���O��["..look_state.."]�ł�"); --EN:-- print("Prince Lendl's state flag is ["..look_state.."]");
			return look_state;
		end
	end
	
	state_flag_num = table.getn(possible_transration_list_m02_02_00_00);--����3�̃t���O�� --EN:-- number of flags in royal castle 3

	for i=1, state_flag_num, 1 do
		local look_state = possible_transration_list_m02_02_00_00[i];
		if proxy:IsCompleteEvent( look_state ) == true then
--			print("�����h�����q�̏�ԃt���O��["..look_state.."]�ł�"); --EN:-- print("Prince Lendl's state flag is ["..look_state.."]");
			return look_state;
		end
	end
	
	state_flag_num = table.getn(possible_transration_list_m02_03_00_00);--����4�̃t���O�� --EN:-- Number of flags in Ojo 4

	for i=1, state_flag_num, 1 do
		local look_state = possible_transration_list_m02_03_00_00[i];
		if proxy:IsCompleteEvent( look_state ) == true then
--			print("�����h�����q�̏�ԃt���O��["..look_state.."]�ł�"); --EN:-- print("Prince Lendl's state flag is ["..look_state.."]");
			return look_state;
		end
	end
	
--	print("�Z�b�g����Ă����ԃt���O��������܂���ł���"); --EN:-- print("Could not find any set state flags");
	return 0;
end

-----------------------------------------------------------------------------
--�e��{�X�̎��S������ --EN:--Determine the number of deaths of various bosses
-----------------------------------------------------------------------------
function GetBossFlagCount( proxy , param )
	
	--�ϐ���` --EN:--Variable definition
	boss_flagCount = 0;		 	--�{�X�̃\�E�����肵���� --EN:--Number of Boss Souls Obtained
	block_boss_flagCount = 0;	--�u���b�N�{�X�̃\�E�����肵���� --EN:-- Number of block boss souls obtained
	area_boss_flagCount = 0;	--�G���A�{�X�̃\�E�����肵���� --EN:--Number of area boss souls obtained
	
	
	--�e�{�X��|���Ă���t���O�̐����擾 --EN:--get number of flags killing each boss
	local boss_actionId_list = {4096, 4224, 4360, 4480,	--���� --EN:--Royal Castle
								5123, 5251, 5380,		--�S�� --EN:--prison castle
								5650, 5770, 5888,		--�s�� --EN:--unclean
								4756, 4895, 4992,		--�Í� --EN:--Old Fort
								6174, 6272, 6400 };		--�B�� --EN:--Tunnel
	local boss_actIdNum = table.getn(boss_actionId_list);
	for index = 1, boss_actIdNum, 1 do
		if proxy:IsCompleteEvent( boss_actionId_list[index] ) == true then
			boss_flagCount = boss_flagCount + 1;
		end
	end

	--�u���b�N�{�X��|���Ă���t���O�̐����擾 --EN:-- Get the number of flags killing block bosses
	local block_boss_actionId_list = {4096, 4224, 4360,	--����1.2.3�\�E���擾 --EN:-- Acquired Ojo 1.2.3 Seoul
									  5123, 5251,		--�S��1.2�\�E���擾 --EN:--Get 1.2 Seoul
									  5650, 5770,		--�s��1.2�\�E���擾 --EN:--Acquire 1.2 Unholy souls
									  4756, 4895,		--�Í�1.2�\�E���擾 --EN:--Obtain 1.2 souls of the old fortress
									  6174, 6272 };		--�B��1.2�\�E���擾 --EN:--Tunnel 1.2 Seoul Acquisition
	local block_boss_actIdNum = table.getn(block_boss_actionId_list);
	for index = 1, block_boss_actIdNum, 1 do
		if proxy:IsCompleteEvent( block_boss_actionId_list[index] ) == true then
			block_boss_flagCount = block_boss_flagCount + 1;
		end
	end
	
	--�G���A�{�X��|���Ă���t���O�̐����擾 --EN:-- Get the number of flags defeating area bosses
	local area_boss_actionId_list = {4480,		--����4�\�E���擾 --EN:-- Acquire Ojo 4 Soul
									 5380,		--�S��3�\�E���擾 --EN:--Obtain Prison 3 Soul
									 5888,		--�s��3�\�E���擾 --EN:--Obtain 3 unclean souls
									 4992,		--�Í�3�\�E���擾 --EN:--Obtain 3 Seoul fortress
									 6400 };	--�B��3�\�E���擾 --EN:--Obtain Tunnel 3 Seoul
	local area_boss_actIdNum = table.getn(area_boss_actionId_list);
	for index = 1, area_boss_actIdNum, 1 do
		if proxy:IsCompleteEvent( area_boss_actionId_list[index] ) == true then
			area_boss_flagCount = area_boss_flagCount + 1;
		end
	end
	
--[[�{�X�\�E���擾���֘A]] --EN:--[[Boss soul acquisition number related]]
	--�� 8067 ���{�X�\�E�����u1�v�� --EN:--�� 8067 �� Number of Boss Souls "1" ��
	if boss_flagCount == 1 then
		--�����𖞂������̂ŁA�t���O��ON --EN:--The conditions are met, so the flag is turned on
		proxy:SetEventFlag(8067, true);
	end	
	--�� 8068 ���{�X�\�E�����u2�v�� --EN:--�� 8068 �� Number of Boss Souls "2" ��
	if boss_flagCount == 2 then
		--�����𖞂������̂ŁA�t���O��ON --EN:--The conditions are met, so the flag is turned on
		proxy:SetEventFlag(8068, true);
	end
	--�� 8069 ���{�X�\�E�����u3�v�� --EN:--�� 8069 �� Number of Boss Souls "3" ��
	if boss_flagCount == 3 then
		--�����𖞂������̂ŁA�t���O��ON --EN:--The conditions are met, so the flag is turned on
		proxy:SetEventFlag(8069, true);
	end	
	--�� 8070 ���{�X�\�E�����u4�v�� --EN:--�� 8070 �� Number of Boss Souls "4" ��
	if boss_flagCount == 4 then
		--�����𖞂������̂ŁA�t���O��ON --EN:--The conditions are met, so the flag is turned on
		proxy:SetEventFlag(8070, true);
	end
	--�� 8071 ���{�X�\�E�����u5] �� --EN:--�� 8071 �� Number of Boss Souls "5" ��
	if boss_flagCount == 5 then
		--�����𖞂������̂ŁA�t���O��ON --EN:--The conditions are met, so the flag is turned on
		proxy:SetEventFlag(8071, true);
	end	
	--�� 8072 ���{�X�\�E�����u6�v�� --EN:--�� 8072 �� Number of Boss Souls "6" ��
	if boss_flagCount == 6 then
		--�����𖞂������̂ŁA�t���O��ON --EN:--The conditions are met, so the flag is turned on
		proxy:SetEventFlag(8072, true);
	end
	--�� 8073 ���{�X�\�E�����u7�v�� --EN:--�� 8073 �� Number of Boss Souls "7" ��
	if boss_flagCount == 7 then
		--�����𖞂������̂ŁA�t���O��ON --EN:--The conditions are met, so the flag is turned on
		proxy:SetEventFlag(8073, true);
	end
	--�� 8074 ���{�X�\�E�����u8�v�� --EN:--�� 8074 �� Number of Boss Souls "8" ��
	if boss_flagCount == 8 then
		--�����𖞂������̂ŁA�t���O��ON --EN:--The conditions are met, so the flag is turned on
		proxy:SetEventFlag(8074, true);
	end
	--�� 8075 ���{�X�\�E�����u9�v�� --EN:--�� 8075 �� Number of Boss Souls "9" ��
	if boss_flagCount == 9 then
		--�����𖞂������̂ŁA�t���O��ON --EN:--The conditions are met, so the flag is turned on
		proxy:SetEventFlag(8075, true);
	end
	--�� 8076 ���{�X�\�E�����u10�v�� --EN:--�� 8076 �� Number of Boss Souls "10" ��
	if boss_flagCount == 10 then
		--�����𖞂������̂ŁA�t���O��ON --EN:--The conditions are met, so the flag is turned on
		proxy:SetEventFlag(8076, true);
	end
	--�� 8077 ���{�X�\�E�����u11] �� --EN:--�� 8077 �� Number of Boss Souls "11" ��
	if boss_flagCount == 11 then
		--�����𖞂������̂ŁA�t���O��ON --EN:--The conditions are met, so the flag is turned on
		proxy:SetEventFlag(8077, true);
	end	
	--�� 8078 ���{�X�\�E�����u12�v�� --EN:--�� 8078 �� Number of Boss Souls "12" ��
	if boss_flagCount == 12 then
		--�����𖞂������̂ŁA�t���O��ON --EN:--The conditions are met, so the flag is turned on
		proxy:SetEventFlag(8078, true);
	end
	--�� 8079 ���{�X�\�E�����u13�v�� --EN:--�� 8079 �� Number of Boss Souls "13" ��
	if boss_flagCount == 13 then
		--�����𖞂������̂ŁA�t���O��ON --EN:--The conditions are met, so the flag is turned on
		proxy:SetEventFlag(8079, true);
	end
	--�� 8080 ���{�X�\�E�����u14�v�� --EN:--�� 8080 �� Number of Boss Souls "14" ��
	if boss_flagCount == 14 then
		--�����𖞂������̂ŁA�t���O��ON --EN:--The conditions are met, so the flag is turned on
		proxy:SetEventFlag(8080, true);
	end
	--�� 8081 ���{�X�\�E�����u15�v�� --EN:--�� 8081 �� Number of Boss Souls "15" ��
	if boss_flagCount == 15 then
		--�����𖞂������̂ŁA�t���O��ON --EN:--The conditions are met, so the flag is turned on
		proxy:SetEventFlag(8081, true);
	end	
	--�� 8082 ���{�X�\�E�����u16�v�� --EN:--�� 8082 �� Number of Boss Souls "16" ��
	if boss_flagCount == 16 then
		--�����𖞂������̂ŁA�t���O��ON --EN:--The conditions are met, so the flag is turned on
		proxy:SetEventFlag(8082, true);
	end
	
--[[�u���b�N�{�X�\�E���擾���֘A]] --EN:--[[Number of Block Boss Soul Acquisition Related]]
	--�� 8056 ���u���b�N�{�X���j���u1�v�� --EN:--�� 8056 �� Number of block bosses defeated "1" ��
	if block_boss_flagCount == 1 then
		--�����𖞂������̂ŁA�t���O��ON --EN:--The conditions are met, so the flag is turned on
		proxy:SetEventFlag(8056, true);
	end	
	--�� 8057 ���u���b�N�{�X���j���u2�v�� --EN:--�� 8057 �� Number of block bosses defeated "2" ��
	if block_boss_flagCount == 2 then
		--�����𖞂������̂ŁA�t���O��ON --EN:--The conditions are met, so the flag is turned on
		proxy:SetEventFlag(8057, true);
	end
	--�� 8058 ���u���b�N�{�X���j���u3�v�� --EN:--�� 8058 �� Number of block bosses defeated "3" ��
	if block_boss_flagCount == 3 then
		--�����𖞂������̂ŁA�t���O��ON --EN:--The conditions are met, so the flag is turned on
		proxy:SetEventFlag(8058, true);
	end	
	--�� 8059 ���u���b�N�{�X���j���u4�v�� --EN:--�� 8059 �� Number of block bosses defeated "4" ��
	if block_boss_flagCount == 4 then
		--�����𖞂������̂ŁA�t���O��ON --EN:--The conditions are met, so the flag is turned on
		proxy:SetEventFlag(8059, true);
	end
	--�� 8060 ���u���b�N�{�X���j���u5�v�� --EN:--�� 8060 �� Number of block bosses defeated "5" ��
	if block_boss_flagCount == 5 then
		--�����𖞂������̂ŁA�t���O��ON --EN:--The conditions are met, so the flag is turned on
		proxy:SetEventFlag(8060, true);
	end
	--�� 8061 ���u���b�N�{�X���j���u6�v�� --EN:--�� 8061 �� Number of block bosses defeated "6" ��
	if block_boss_flagCount == 6 then
		--�����𖞂������̂ŁA�t���O��ON --EN:--The conditions are met, so the flag is turned on
		proxy:SetEventFlag(8061, true);
	end	
	--�� 8062 ���u���b�N�{�X���j���u7�v�� --EN:--�� 8062 �� Number of block bosses defeated "7" ��
	if block_boss_flagCount == 7 then
		--�����𖞂������̂ŁA�t���O��ON --EN:--The conditions are met, so the flag is turned on
		proxy:SetEventFlag(8062, true);
	end	
	--�� 8063 ���u���b�N�{�X���j���u8�v�� --EN:--�� 8063 �� Number of block bosses defeated "8" ��
	if block_boss_flagCount == 8 then
		--�����𖞂������̂ŁA�t���O��ON --EN:--The conditions are met, so the flag is turned on
		proxy:SetEventFlag(8063, true);
	end	
	--�� 8064 ���u���b�N�{�X���j���u9�v�� --EN:--�� 8064 �� Number of block bosses defeated "9" ��
	if block_boss_flagCount == 9 then
		--�����𖞂������̂ŁA�t���O��ON --EN:--The conditions are met, so the flag is turned on
		proxy:SetEventFlag(8064, true);
	end	
	--�� 8065 ���u���b�N�{�X���j���u10�v�� --EN:--�� 8065 �� Number of block bosses defeated "10" ��
	if block_boss_flagCount == 10 then
		--�����𖞂������̂ŁA�t���O��ON --EN:--The conditions are met, so the flag is turned on
		proxy:SetEventFlag(8065, true);
	end	
	--�� 8066 ���u���b�N�{�X���j���u11�v�� --EN:--�� 8066 �� Number of block bosses defeated "11" ��
	if block_boss_flagCount >= 11 then
		--�����𖞂������̂ŁA�t���O��ON --EN:--The conditions are met, so the flag is turned on
		proxy:SetEventFlag(8066, true);
	end
	
--[[�G���A�{�X�\�E���擾���֘A]] --EN:--[[Area Boss Soul Acquisition Number Related]]
	--�� 8050 ���G���A�{�X���j���u1�v�� --EN:--�� 8050 ��Number of area bosses defeated "1"��
	if area_boss_flagCount == 1 then
		--�����𖞂������̂ŁA�t���O��ON --EN:--The conditions are met, so the flag is turned on
		proxy:SetEventFlag(8050, true);
	end	
	--�� 8051 ���G���A�{�X���j���u2�v�� --EN:--�� 8051 ��Number of area bosses defeated "2"��
	if area_boss_flagCount == 2 then
		--�����𖞂������̂ŁA�t���O��ON --EN:--The conditions are met, so the flag is turned on
		proxy:SetEventFlag(8051, true);
	end
	--�� 8052 ���G���A�{�X���j���u3�v�� --EN:--�� 8052 ��Number of area bosses defeated "3"��
	if area_boss_flagCount == 3 then
		--�����𖞂������̂ŁA�t���O��ON --EN:--The conditions are met, so the flag is turned on
		proxy:SetEventFlag(8052, true);
	end	
	--�� 8053 ���G���A�{�X���j���u4�v�� --EN:--�� 8053 �� Number of area bosses defeated "4" ��
	if area_boss_flagCount == 4 then
		--�����𖞂������̂ŁA�t���O��ON --EN:--The conditions are met, so the flag is turned on
		proxy:SetEventFlag(8053, true);
	end	
	--�� 8054 ���G���A�{�X���j���u5�v�� --EN:--�� 8054 ��Number of area bosses defeated "5"��
	if area_boss_flagCount >= 5 then
		--�����𖞂������̂ŁA�t���O��ON --EN:--The conditions are met, so the flag is turned on
		proxy:SetEventFlag(8054, true);
	end
	
end

--[[�X�V���\�b�h���b�p�[��LuaFunc_NoOmission]] --EN:--[[Update method wrapper��LuaFunc_NoOmission]]
--[[�L���������S�ɍX�V���Ȃ��Ȃ�܂�]] --EN:--[[Character will not be updated completely]]
--[[
	proxy 	        	�c �C�x���g�v���N�V	 --EN:proxy �c event proxy
	who					�c�N --EN:who
	LuaFunc_NormalOmission�Ō��ɖ߂��̂�Y��Ȃ��ŉ������B --EN:Don't forget to restore it with LuaFunc_NormalOmission.
]]
function LuaFunc_NoOmission(proxy,who)
	proxy:ForceSetOmissionLevel(who,true,-1);
end

--[[�X�V���\�b�h���b�p�[��LuaFunc_NormalOmission]] --EN:--[[Update method wrapper��LuaFunc_NormalOmission]]
--[[�L������ʏ�X�V���܂�]] --EN:--[[Update character normally]]
--[[
	proxy 	        	�c �C�x���g�v���N�V	 --EN:proxy �c event proxy
	who					�c�N --EN:who
]]
function LuaFunc_NormalOmission(proxy,who)
	proxy:ForceSetOmissionLevel(who,false,0);
end

--[[�X�V���\�b�h���b�p�[��LuaFunc_ForceOmission]] --EN:--[[Update method wrapper��LuaFunc_ForceOmission]]
--[[�L���������S�X�V���܂�]] --EN:--[[Completely update the character]]
--[[
	proxy 	        	�c �C�x���g�v���N�V	 --EN:proxy �c event proxy
	who					�c�N --EN:who
	LuaFunc_NormalOmission�Ō��ɖ߂��̂�Y��Ȃ��ŉ������B --EN:Don't forget to restore it with LuaFunc_NormalOmission.
]]
function LuaFunc_ForceOmission(proxy,who)
	proxy:ForceSetOmissionLevel(who,true,0);
end


--[[��i�j��SecondStageBreak]] --EN:--[[Second Stage Break��SecondStageBreak]]
--[[2�i�K�j��̃��[�g�}�g���N�X�ړ��A���f�������ւ��A�����x�ݒ�A�j�Аݒ�����b�s���O]] --EN:--[[Two-stage destruction root matrix movement, model replacement, initial velocity setting, wrapping fragment setting]]
--[[
	proxy 	        	�c �C�x���g�v���N�V	 --EN:proxy �c event proxy
	who					�c�N --EN:who
	model				�c�����ւ��郂�f�� --EN:model �cReplacement model
]]
function SecondStageBreak(proxy,who,model)
	--�}�X�^�[�̈ʒu�A�p�x�Ƀ_�~�|���̈ʒu�A�p�x��ݒ� --EN:--Set the position and angle of Damipoly to the position and angle of the master
	--�_�~�|�����g���̂Ń��f�������ւ��Ȃǂ̃^�C�~���O�ɒ���!! --EN:--Since Damipoly is used, pay attention to the timing of model replacement!
	--�����ւ�����̃��f���Ɏw��ID�̃_�~�|���������ꍇ�ۏ�ł��܂���B) --EN:--We cannot guarantee if the model after replacement does not have the dummy poly with the specified ID. )
	proxy:ObjRootMtxMove(who);
	
	--���f���������ւ��� --EN:--replace model
	proxy:ChangeModel( who, model);
	
	--�����x��ݒ�i��ɂ΂炯������ׁj --EN:--Set the initial speed (mainly for dispersion)
	proxy:SetFirstSpeed(who);

	--�I�u�W�F�N�g��j�Ђɂ��Ă����蔻������� --EN:--Eliminate the hit judgment by breaking the object into pieces
	proxy:SetBrokenPiece(who);
end



--[[�{�X�����̏����𓝈ꂷ��ׁA�e�X�g���ł��B ]] --EN:--[[We are testing to unify the processing of the boss room. ]]
--[[����4��22���ł����A5���ɂȂ��Ă����̃R�����g���c���Ă���ꍇ�́A --EN:--[[It's now April 22nd, but if this comment is still there in May,
�@�@�L�������킳�������Ă��������B�ɓ��L]] --EN:Please erase it without saying yes or no. Yutaka Ito]]

--[[�{�X�����C�x���g��BossRoomIn]] --EN:--[[Boss Room Event��BossRoomIn]]
--[[�{�X�����ɓ���C�x���g���܂Ƃ߂ēo�^]] --EN:--[[Register all events to enter the boss room]]
--[[
	proxy 	        	�c�C�x���g�v���L�V	 --EN:proxy �c event proxy
	BossID				�c�{�X���S�̃A�N�V����ID --EN:BossID �c Action ID for boss death
	FirstIn				�c�ŏ��Ƀz�X�g������ۂ̃A�N�V����ID --EN:FirstIn �c Action ID when the host first enters
	SecondIn			�c2��ڈȍ~�̃{�X�����ɓ���A�N�V����ID --EN:SecondIn �c Action ID to enter the boss room after the second time
	RegionID			�c�A�N�V�����{�^������p�̗̈�̃C�x���gID --EN:RegionID �c Event ID of the region for action button judgment
]]
--[[
function BossRoomIn(proxy,param)
	print("BossRoomIn begin");
	local FirstIn = param:GetParam1();
	local SecondIn = param:GetParam1() + 1;
	local BossID	= param:GetParam3();
	if proxy:IsCompleteEvent( param:GetParam3() ) == false then
		--�������A�j���Đ��p�̊J�n�n���h��(���񁨕���) --EN:--�� Start handler for synchronous animation playback (turning �� walking)
		proxy:LuaCall( FirstIn + 1, 1, "OnEvent_SynchroTurn", everytime );
		--��2��ڈȍ~�Ƀ{�X�����ɓ��邽�߂̃C�x���g�z�M�p --EN:--��For event delivery to enter the boss room after the second time
		proxy:LuaCall( param:GetParam1(), 5 , "OnEvent_"..FirstIn.."_GO_TO_IN" , everytime );
		--���t���O�Z�b�g(�����p) --EN:--��flag set (for synchronization)
		proxy:LuaCall( param:GetParam1(), 6 , "OnEvent_"..FirstIn.."_flag_set" , everytime );
		
		--�N�����{�X�O�����܂��ʉ߂��Ă��Ȃ� --EN:--Someone hasn't passed through the boss front door yet
		if proxy:IsCompleteEvent( param:GetParam1() ) == false then
		
			--(�Z�b�V��������)�{�X�O�̖��@�ǂ��ŏ��ɒʂ��̂͐����̐l���� --EN:--(During the session) Only survivors can pass through the magic wall in front of the boss first
			local possible_chr_type = ATTR_HOST + ATTR_LIVE + ATTR_GREY;
			
			proxy:NotNetMessage_begin();
				--��FirstIn�����ɓ��邽�߂̃C�x���g��ǉ��� --EN:--��FirstIn��Add an event to go inside��
				proxy:OnPlayerActionInRegionAttribute( param:GetParam1(), 2891 - param:GetParam2(), "OnEvent_"..FirstIn, HELPID_GO_TO_IN, possible_chr_type, once );
			proxy:NotNetMessage_end();
			
		else --�O���C�S�[�X�g�ł����Ƃ��悤�ɂ���Ǝv����B --EN:--Gray ghost seems to be like that when it's done.
		
			proxy:NotNetMessage_begin();
				--��SecondIn�����ɓ��邽�߂̃C�x���g��ǉ���--�n���h���͏�Ɠ��� --EN:--��SecondIn��Add an event to enter inside��--The handler is the same as above
				proxy:OnPlayerActionInRegion( param:GetParam1() + 1, 2891 - param:GetParam2(), "OnEvent_"..FirstIn, HELPID_GO_TO_IN, everytime );
			proxy:NotNetMessage_end();
		end
	end
	print("BossRoomIn end");
end

function BossRoomIn( proxy, BossID, FirstIn, SecondIn, RegionID )
	if proxy:IsCompleteEvent( BossID ) == false then
		--�������A�j���Đ��p�̊J�n�n���h��(���񁨕���) --EN:--�� Start handler for synchronous animation playback (turning �� walking)
		proxy:LuaCall( SecondIn, 1, "OnEvent_SynchroTurn", everytime );
		--��2��ڈȍ~�Ƀ{�X�����ɓ��邽�߂̃C�x���g�z�M�p --EN:--��For event delivery to enter the boss room after the second time
		proxy:LuaCall( FirstIn , 5 , "OnEvent_"..FirstIn.."_GO_TO_IN" , everytime );
		--���t���O�Z�b�g(�����p) --EN:--��flag set (for synchronization)
		proxy:LuaCall( FirstIn , 6 , "OnEvent_"..FirstIn.."_flag_set" , everytime );
		
		--�N�����{�X�O�����܂��ʉ߂��Ă��Ȃ� --EN:--Someone hasn't passed through the boss front door yet
		if proxy:IsCompleteEvent( FirstIn ) == false then
		
			--(�Z�b�V��������)�{�X�O�̖��@�ǂ��ŏ��ɒʂ��̂͐����̐l���� --EN:--(During the session) Only survivors can pass through the magic wall in front of the boss first
			local possible_chr_type = ATTR_HOST + ATTR_LIVE + ATTR_GREY;
			
			proxy:NotNetMessage_begin();
				--��FirstIn�����ɓ��邽�߂̃C�x���g��ǉ��� --EN:--��FirstIn��Add an event to go inside��
				proxy:OnPlayerActionInRegionAttribute( FirstIn, RegionID, "OnEvent_"..FirstIn, HELPID_GO_TO_IN, possible_chr_type, once );
			proxy:NotNetMessage_end();
			
		else --�O���C�S�[�X�g�ł����Ƃ��悤�ɂ���Ǝv����B --EN:--Gray ghost seems to be like that when it's done.
		
			proxy:NotNetMessage_begin();
				--��SecondIn�����ɓ��邽�߂̃C�x���g��ǉ���--�n���h���͏�Ɠ��� --EN:--��SecondIn��Add an event to enter inside��--The handler is the same as above
				proxy:OnPlayerActionInRegion( SecondIn, RegionID, "OnEvent_"..FirstIn, HELPID_GO_TO_IN, everytime );
			proxy:NotNetMessage_end();
		end
	end
end

function OnEvent_SynchroTurn(proxy,param)
end
]]


--[[
�V���O�����t���O���Z�b�g�֐���SingleReset --EN:Single flag reset function ��SingleReset
proxy	�c�C�x���g�v���L�V --EN:proxy �c event proxy
flag	�c�t���O --EN:flag �c flag
]]
function SingleReset(proxy,flag)
	if proxy:IsClient() == false then
		proxy:SetEventFlag( flag,false);
	end
end


--[[
OnRegistFunc�̌��ʂ̕������g��Ȃ����Ɏw�肷��󃁃\�b�h --EN:An empty method to specify when not using the result part of OnRegistFunc
]]
function dummy(proxy,param)
end

--[[
�n����EventID���X�g�̃C�x���g��Z�߂ď����֐���DeleteConditionList --EN:A function that collectively deletes the events in the passed EventID list ��DeleteConditionList
proxy		�c�C�x���g�v���L�V --EN:proxy �c event proxy
acid_list	�c�A�N�V����ID���X�g�i�����o�^����ID�j --EN:acid_list �c Action ID list (ID when registering conditions)
]]
function DeleteConditionList(proxy,acid_list)
	local id_num = table.getn(acid_list);
	for index = 1, id_num, 1 do
		proxy:DeleteEvent( acid_list[index] );
	end
end

function SynchroAddQWC(proxy,param)
	print("SynchroAddQWC begin");
	local qwcId = param:GetParam3();
	print("QwcAddId = ", qwcId );
	proxy:AddQWC(qwcId,param:IsNetMessage());
	print("SynchroAddQWC end");
end

--[[
�g���t�B�[�擾���b�p�[�֐���Lua_RequestUnlockTrophy --EN:Trophy acquisition wrapper function �� Lua_RequestUnlockTrophy
proxy		�c�C�x���g�v���L�V --EN:proxy �c event proxy
TrophyId	�c�A�����b�N�v������g���t�B�[��ID --EN:TrophyId �c ID of the trophy to be unlocked
]]
function Lua_RequestUnlockTrophy(proxy,TrophyId)
	if proxy:IsClient() == false then --�V���O���@or�@�z�X�g --EN:--Single or host
		if proxy:IsLivePlayer() == true or proxy:IsGreyGhost() == true then
			print("�g���t�B�[ID:(",TrophyId,")�̎擾�̌����𓾂܂���"); --EN:print("Trophy ID:(",TrophyId,") got the right to get");
			--�܂��g���t�B�[(TrophyId)����ɓ���ĂȂ���� --EN:--If you haven't got the TrophyId yet
			if proxy:IsUnlockTrophy( TrophyId ) == false then	--���͖�������false��Ԃ��B --EN:-- Now unconditionally return false.
				--�g���t�B�[�̎擾 --EN:--Get trophies
				proxy:RequestUnlockTrophy( TrophyId );
				print("�g���t�B�[ID:(",TrophyId,")����ɓ��ꂽ"); --EN:print("I got the trophy ID:(",TrophyId,")");
			else
				print("�g���t�B�[ID:(",TrophyId,")�͂��łɎ����Ă��܂�"); --EN:print("I already have trophy id:(",TrophyId,")");
			end
		else
			print("�g���t�B�[�擾�̌����͂���܂���"); --EN:print("You are not entitled to trophies");
		end
	else--�L�����^�C�v����L�̂����ꂩ�ł��Ȃ��ꍇ --EN:--If the character type is not one of the above
		print("�g���t�B�[�擾�̌����͂���܂���"); --EN:print("You are not entitled to trophies");
	end
end

--[[
�C�x���g�������S�\�E������s���b�p�[�֐���Lua_EventForceDead --EN:Event forced death soul unobtainable wrapper function ��Lua_EventForceDead
proxy		�c�C�x���g�v���L�V --EN:proxy �c event proxy
TargetID	�c���S�^�[�Q�b�g --EN:TargetID �c death target
]]
function Lua_EventForceDead(proxy,TargetID)
	print("Lua_EventForceDead TargetID ",TargetID);
	proxy:DisableCollection( TargetID, true );
	proxy:ForceDead( TargetID );	
end


--------------------------------------------------------------------------------------------
--��4057���ėp���� --EN:-- �� 4057 �� General-purpose synchronization
--------------------------------------------------------------------------------------------
--DeleteEvent
function SynchroDeleteEvent_4057(proxy,param)
	proxy:DeleteEvent( param:GetParam3() );
end

--SetEventFlag true�ݒ� --EN:--SetEventFlag true setting
function SynchroSetEventFlag_4057(proxy,param)
	proxy:SetEventFlag( param:GetParam3(), true );
end

--SetEventFlag false�ݒ� --EN:--SetEventFlag false setting
function SynchroResetEventFlag_4057(proxy,param)
	proxy:SetEventFlag( param:GetParam3(), false );
end


--------------------------------------------------------------------------------------------
--�����`���[�g���A���p���j���[�҂� --EN:--Waiting for tutorial menu
--------------------------------------------------------------------------------------------
function Lua_PauseTutorial(proxy)
	proxy:NotNetMessage_begin();
	proxy:RepeatMessage_begin();
	proxy:OnKeyTime2( 14000,"OnEvent_TutorialWait",Tutorial_pausewait,0,0,once);
	proxy:RepeatMessage_end();
	proxy:NotNetMessage_end();
end

function OnEvent_TutorialWait(proxy,param)
	proxy:StopPlayer();
	proxy:PauseTutorial();
	proxy:NotNetMessage_begin();
	proxy:RepeatMessage_begin();
	proxy:OnKeyTime2( 14000,"OnEvent_TutorialWait_2",0.1,0,2,once);
	proxy:RepeatMessage_end();
	proxy:NotNetMessage_end();	
end

function OnEvent_TutorialWait_2(proxy,param)	
	
	proxy:EnableLogic( 10000 , true );
end


--------------------------------------------------------------------------------------------
--��15500�������A�C�e�����擾���Ă��邩�H�����S�[�X�gNPC�ɑ΂��āA���̕�𒲂ׂ�ƌĂ΂�� --EN:--��15500��Are you getting the intrusion item? * Called to examine the corpse treasure against the black ghost NPC
--------------------------------------------------------------------------------------------
function OnEvent_15500(proxy,param)
	if proxy:IsCompleteEvent(15500) == false then
		print("OnEvent_15500 begin");
		proxy:SetEventFlag( 15500 ,true );
		print("OnEvent_15500 end");
	end
end

--�e�ۃI�[�i�[�쐬 --EN:--Bullet owner creation
function CreateBulletOwner(proxy,nwho)		
	InvalidCharactor( proxy , nwho  );
	proxy:SetAlwayEnableBackread_forEvent( nwho , true );	
end


----------------------------------------------------------------------------------------------------------------------------------------------------------------
--��4061���ėp�_�C�A���O�̋�������p --EN:-- �� 4061 �� For distance judgment of general-purpose dialog
----------------------------------------------------------------------------------------------------------------------------------------------------------------
function MenuClose(proxy,param)
	print("MenuClose begin");
	proxy:CloseGenDialog();
	print("MenuClose end");
end

--�^�C�g�����j���[�ւ� --EN:-- to the title menu
function RegistReturnTitle(proxy,param)
	print("RegistReturnTitle begin");
	--�Z�[�u�v�� --EN:--save request
	proxy:SaveRequest();
	--�L�����N�^����̒�~ --EN:--Stop character operation
	proxy:StopPlayer();
	--���̍ēǂݍ��݌n�C�x���g�̊��荞�݂�h�~ --EN:--Prevent interruption of other reloading events
	proxy:SetEventFlag(4047, true);
	--�C�x���g�����ɂ����[�h�҂��ł��鎖��ʒm --EN:-- Notify that it is waiting for loading inside the event
	proxy:SetLoadWait();	
	
	proxy:NotNetMessage_begin();
	proxy:RepeatMessage_begin();
		proxy:OnKeyTime2( 4062 , "ReturnTitle_wait",0.5,0,20,once);
	proxy:RepeatMessage_end();
	proxy:NotNetMessage_end();
	
	print("RegistReturnTitle end");
end

function ReturnTitle_wait(proxy,param)
	proxy:NotNetMessage_begin();
	proxy:RepeatMessage_begin();
		proxy:OnRegistFunc( 4062 , "Check_ReturnTitle","OnReturnTitle",1,once);
	proxy:RepeatMessage_end();
	proxy:NotNetMessage_end();
end

--�^�C�g���ɖ߂鏈���̃��j���[�\���҂� --EN:--Waiting for menu display for processing to return to the title
function Check_ReturnTitle(proxy)
	if proxy:IsShowMenu_InfoMenu() == true then
		return false;
	end
	return true;
end

--�^�C�g���ɖ߂鏈���̎��s --EN:-- Execute processing to return to the title
function OnReturnTitle(proxy,param)
	print("OnReturnTitle begin");
	--�^�C�g��or�}�b�v�Z���N�g�ɖ߂�܂� --EN:--Return to title or map select
	proxy:ReturnMapSelect();
	print("OnReturnTitle end");
end


function Lua_GetReloadTime(proxy,low,high)
	local tempLow  = low  * 1000;
	local tempHigh = high * 1000;
	local rand = proxy:GetRandom( tempLow, tempHigh ) / 1000;
	return rand;
end

--�g�J�Q�C�x���g�o�^�p --EN:--For lizard event registration
function RegistTokage(proxy,eventId,TokageId,index)
	local count = 0;
	proxy:AddFieldInsFilter( TokageId );
	--�g�J�Q�V�d�l�Ή��@����̓z�X�g�̂ݍs�� --EN:--Compatible with new lizard specs Judgment is done only by the host
	if proxy:IsClient() == false then
		--�g�J�Q������ł���or�����Ă���Ȃ� --EN:--if the lizard is dead or gone
		if proxy:IsCompleteEvent(eventId) == true then
			--�J�E���^�擾 --EN:--get counter
			count = proxy:GetEventCount(index);
			--�J�E���^���c���Ă��� --EN:--counter remains
			if count > 0 then
				--�t���OOFF --EN:--Flag OFF
				proxy:SetEventFlag( eventId ,false );
				--�J�E���^�����炵�čĐݒ� --EN:--decrement the counter and reset
				count = count-1;			
				proxy:SetEventCount(index,count);
			end
		end
	end
	
	--�R�R�͑S���ʂ� --EN:--Everyone passes here
		--����ł��Ȃ������ĂȂ��Ȃ�Ď���ǉ� --EN:--Add a watch if it's not dead or gone
	if proxy:IsCompleteEvent(eventId) == false then
		print("Add TokageEvent ",TokageId);
		proxy:OnCharacterDead(eventId,TokageId,"OnEvent_"..eventId,once);
		proxy:OnCheckEzStateMessage( eventId,TokageId,"OnEvent_"..eventId,1000);
	else
		--����ł�������Ă���Ȃ疳���� --EN:--disable if dead disappear
		InvalidBackRead(proxy,TokageId);
	end
end

--�J�E���^���Z --EN:--counter addition
function AddEventCounter(proxy,index)
	--�N���C�A���g�̂� --EN:--client only
	if proxy:IsClient() == false then
		local count = proxy:GetEventCount(index);
		count = count + 1;
		proxy:SetEventCount( index, count );
	end
end


--��4065��OBJ�̏��PC��������� --EN:-- �� 4065 �� A PC is on top of an OBJ ��
function OnEnterRideObj(proxy,param)
	if param:IsNetMessage() == true then
		print("OnEnterRideObj begin");
		local obj 		= param:GetParam2();
		local sysidx 	= param:GetParam3();
		print("obj :",obj," sysidx :",sysidx);
		proxy:SetSyncRideObjInfo(param:GetPlayID()+10001,obj,sysidx);
		print("OnEnterRideObj end");
	end
end

--��4066��OBJ�ɏ���Ă���PC���~�肽�� --EN:-- �� 4066 �� PC on OBJ got off ��
function OnLeaveRideObj(proxy,param)
	if param:IsNetMessage() == true then
		print("OnLeaveRideObj begin");
		proxy:ResetSyncRideObjInfo(param:GetPlayID()+10001);
		print("OnLeaveRideObj end");
	end
end


--[[
	��Lua_MultiDoping �c�}���`�h�[�s���O�p�A�_�v�^ --EN:��Lua_MultiDoping �cAdapter for multi-doping
	proxy	�c�C�x���g�v���L�V --EN:proxy �c event proxy
	eneid	�c�G�C�x���gID --EN:eneid �c enemy event ID
]]
function Lua_MultiDoping(proxy,eneId)	
	--�z�X�g�̂ݔ��� --EN:--Only the host is judged
	--if proxy:IsClient() == false then		
		local whiteCount = proxy:GetWhiteGhostCount();
		--�z���C�g0�@�������Ȃ� --EN:-- White 0 Do nothing
		if whiteCount == 0 then
			print("No Doping");
		end
		--�z���C�g1�@Lv1�@���� HP1.5�{ --EN:--White 1 Lv1 Enhanced HP 1.5x
		if whiteCount == 1 then
			print("Doping Lv 1 ",eneId);
			proxy:SetEventSpecialEffect_2(eneId,7500);
		end
		--�z���C�g2�@Lv2�@���� HP2�{ --EN:--White 2 Lv2 Enhanced HP x2
		if whiteCount == 2 then
			print("Doping Lv 2 ",eneId);
			proxy:SetEventSpecialEffect_2(eneId,7501);
		end				
	--end	
	proxy:NotNetMessage_begin();	
		proxy:OnKeyTime2( 4070, "ForceUpdate",0.1,0,eneId,once);
	proxy:NotNetMessage_end();
end

function ForceUpdate(proxy,param)
	proxy:ForceUpdateNextFrame( param:GetParam3() );
end

function Lua_MultiDopingm04_02(proxy,eneId)	
	
	local whiteCount = proxy:GetWhiteGhostCount();
	--�z���C�g0�@�������Ȃ� --EN:-- White 0 Do nothing
	if whiteCount == 0 then
		print("No Doping");
	end
	--�z���C�g1�@Lv1�@���� HP1.5�{ --EN:--White 1 Lv1 Enhanced HP 1.5x
	if whiteCount == 1 then
		print("Doping Lv 1 ",eneId);
		proxy:SetEventSpecialEffect_2(10000,7500);
	end
	--�z���C�g2�@Lv2�@���� HP2�{ --EN:--White 2 Lv2 Enhanced HP x2
	if whiteCount == 2 then
		print("Doping Lv 2 ",eneId);
		proxy:SetEventSpecialEffect_2(10000,7501);
	end			
end
