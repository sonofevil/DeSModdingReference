
--�o�b�h�G���f�B���O���̃E�F�C�g --EN:--Wait for bad ending
BAD_END_WAIT = false;

--���p�j�f�[�����p��ID --EN:-- �� ID for the loitering daemon

demon_id_list_m01_00_00_00 = { 830 , 831 , 832};

hiroin_cancelAnimId = -1;

------------------------------------------------------------------------------------------
--���q���C���̏�Ԉꗗ-------------------------------------------------------------------- --EN:--��Heroine's status list------------------------------------------ -------------------------
--���q���C���̏�Ԉꗗ-------------------------------------------------------------------- --EN:--��Heroine's status list------------------------------------------ -------------------------
HEROINE_STATE_WAIT_FOR_PLAYER = 16140;--�v���C���[��҂� --EN:--wait for player
HEROINE_STATE_WANT_TO_SETTLE  = 16141;--������������ --EN:--I want to settle
HEROINE_STATE_WITH_A_FUTURE   = 16142;--�t���Ă����܂� --EN:--I'll follow you
HEROINE_STATE_DOOR_FRONT		= 16143;--���̑O --EN:--In front of the door
HEROINE_STATE_DOOR_LEAVE		= 16144;--�����狎�낤���ȁH --EN:-- Shall we leave through the door?
HEROINE_STATE_PRAYER			= 16145;--�F���Ă��� --EN:--praying
HEROINE_STATE_ISNOT				= 16146;--�܂����Ȃ� --EN:--not yet
heroine_flag_list = {
	HEROINE_STATE_WAIT_FOR_PLAYER ,
	HEROINE_STATE_WANT_TO_SETTLE  ,
	HEROINE_STATE_WITH_A_FUTURE		,
	HEROINE_STATE_DOOR_FRONT		,
	HEROINE_STATE_DOOR_LEAVE		,
	HEROINE_STATE_PRAYER,
	HEROINE_STATE_ISNOT
};


--���[�v�Ď� --EN:--warp monitoring
GO_TO_WARP_OUJOU 		= 16710;--����փ��[�v --EN:--Warp to the castle
GO_TO_WARP_FURUTORIDE 	= 16711;--�ÍԂփ��[�v --EN:--Warp to Old Fort
GO_TO_WARP_ROUJOU		= 16712;--�S��փ��[�v --EN:--Warp to prison
GO_TO_WARP_FUJOU		= 16713;--�s��փ��[�v --EN:--Warp to Unholy
GO_TO_WARP_KOUDOU		= 16714;--�B���փ��[�v --EN:--Warp to Mine
GO_TO_WARP_HOKUGEN		= 16715;--�k���փ��[�v --EN:--Warp to the northern limit

warp_list ={
	GO_TO_WARP_OUJOU		,
	GO_TO_WARP_FURUTORIDE	,
	GO_TO_WARP_ROUJOU		,
	GO_TO_WARP_FUJOU		,
	GO_TO_WARP_KOUDOU		,
	GO_TO_WARP_HOKUGEN		,
}

------------------------------------------------------------------------------------------
--���{�[�h�E�B���̏�Ԉꗗ---------------------------------------------------------------- --EN:--�� Bauduin's state list ------------------------------------------ ----------------------
--�A�N�V����ID				 --EN:--Action ID
BALDWIN_STATE_WORK     = 16440--�d����			 --EN:--Working
BALDWIN_STATE_HOSTILE  = 16441--�G��			 --EN:--hostile
BALDWIN_STATE_DEAD     = 16442--���S --EN:--death
BALDWIN_STATE_ISNOT    = 16443--�܂����Ȃ� --EN:--not yet

baldwin_flag_list = {
	BALDWIN_STATE_WORK   ,--�d����			 --EN:--Working
	BALDWIN_STATE_HOSTILE,--�G��			 --EN:--hostile
	BALDWIN_STATE_DEAD   ,--���S --EN:--death
	BALDWIN_STATE_ISNOT	  --�܂����Ȃ� --EN:--not yet
};



------------------------------------------------------------------------------------------
--���v�l�̏�Ԉꗗ---------------------------------------------------------------- --EN:--�� Status list of dignitaries --------------------------------------------- ----------------------
--�A�N�V����ID				 --EN:--Action ID
YOJIN_STATE_WAIT_FOR_PLAYER = 16270--�v���C���[��҂�			 --EN:--wait for player
YOJIN_STATE_LASTWORD        = 16271--�Ō�̌��t��`���悤			 --EN:--Let me give you the last word
YOJIN_STATE_DEAD            = 16272--���S			 --EN:--death

yojin_flag_list = {
	YOJIN_STATE_WAIT_FOR_PLAYER   ,--�v���C���[��҂�			 --EN:--wait for player
	YOJIN_STATE_LASTWORD          ,--�Ō�̌��t��`���悤			 --EN:--Let me give you the last word
	YOJIN_STATE_DEAD               --���S --EN:--death
};





--���y���p�̓k�z��Ԉꗗ-------------------------------------------------------------------- --EN:--��[Magician] Status List--------------------------------------- ----------------------------
MAGIC_STUDENT_STATE_ROGARN_HELP		= 16290;
MAGIC_STUDENT_STATE_ROGARN_TOGETHER	= 16291;
MAGIC_STUDENT_STATE_FALL			= 16292;
MAGIC_STUDENT_STATE_ANGRY			= 16293;
MAGIC_STUDENT_STATE_DEAD			= 16294;
MAGIC_STUDENT_STATE_ISNOT			= 16295;
magic_student_flag_list = {
	MAGIC_STUDENT_STATE_ROGARN_HELP 	,
	MAGIC_STUDENT_STATE_ROGARN_TOGETHER ,
	MAGIC_STUDENT_STATE_FALL			,
	MAGIC_STUDENT_STATE_ANGRY			,
	MAGIC_STUDENT_STATE_DEAD			,
	MAGIC_STUDENT_STATE_ISNOT
};


------------------------------------------------------------------------------------------
--���y�_�̐M�k1�z��Ԉꗗ-------------------------------------------------------------------- --EN:--��[God's Follower 1] Status List--------------------------------------- -----------------------------
GOD_BELIEVER_1_STATE_STONE_PILLAR	= 16300;--�Β��ɂ���			 --EN:--At the stone pillar
GOD_BELIEVER_1_STATE_URU			= 16301;--�E�����܂ƈꏏ			 --EN:--with Uru-sama
GOD_BELIEVER_1_STATE_FALL			= 16302;--���_ --EN:--disappointment
GOD_BELIEVER_1_STATE_ANGRY			= 16303;--�G��			 --EN:--hostile
GOD_BELIEVER_1_STATE_DEAD			= 16304;--���S	 --EN:--death
GOD_BELIEVER_1_STATE_ISNOT			= 16305;--�܂����Ȃ� --EN:--not yet

god_beliver1_flag_list = {
	GOD_BELIEVER_1_STATE_STONE_PILLAR 	,
	GOD_BELIEVER_1_STATE_URU  			,
	GOD_BELIEVER_1_STATE_FALL			,
	GOD_BELIEVER_1_STATE_ANGRY			,
	GOD_BELIEVER_1_STATE_DEAD			,
	GOD_BELIEVER_1_STATE_ISNOT
};


------------------------------------------------------------------------------------------
--���y�_�̐M�k2�z��Ԉꗗ-------------------------------------------------------------------- --EN:--��[God's Follower 2] Status List--------------------------------------- -----------------------------
GOD_BELIEVER_2_STATE_STONE_PILLAR	= 16310;--�Β��ɂ���			 --EN:--At the stone pillar
--GOD_BELIEVER_2_STATE_URU			= 16311;--�E�����܂ƈꏏ			 --EN:--with Uru-sama
GOD_BELIEVER_2_STATE_FALL			= 16312;--���_ --EN:--disappointment
GOD_BELIEVER_2_STATE_ANGRY			= 16313;--�G��			 --EN:--hostile
GOD_BELIEVER_2_STATE_DEAD			= 16314;--���S	 --EN:--death
GOD_BELIEVER_2_STATE_ISNOT			= 16315;--�܂����Ȃ� --EN:--not yet
GOD_BELIEVER_2_STATE_ISNOTALREADY	= 16316;--���łɋ��Ȃ� --EN:--I'm not here anymore
god_beliver2_flag_list = {
	GOD_BELIEVER_2_STATE_STONE_PILLAR 	,
	--GOD_BELIEVER_2_STATE_URU  		,
	GOD_BELIEVER_2_STATE_FALL			,
	GOD_BELIEVER_2_STATE_ANGRY			,
	GOD_BELIEVER_2_STATE_DEAD			,
	GOD_BELIEVER_2_STATE_ISNOT			,
	GOD_BELIEVER_2_STATE_ISNOTALREADY
};

------------------------------------------------------------------------------------------
--���y�_�̐M�k3�z��Ԉꗗ-------------------------------------------------------------------- --EN:--��[God's Follower 3] Status List--------------------------------------- -----------------------------
GOD_BELIEVER_3_STATE_STONE_PILLAR	= 16320;--�Β��ɂ���			 --EN:--At the stone pillar
GOD_BELIEVER_3_STATE_URU			= 16321;--�E�����܂ƈꏏ			 --EN:--with Uru-sama
GOD_BELIEVER_3_STATE_FALL			= 16322;--���_ --EN:--disappointment
GOD_BELIEVER_3_STATE_ANGRY			= 16323;--�G��			 --EN:--hostile
GOD_BELIEVER_3_STATE_DEAD			= 16324;--���S			 --EN:--death
god_beliver3_flag_list = {
	GOD_BELIEVER_3_STATE_STONE_PILLAR 	,
	GOD_BELIEVER_3_STATE_URU  			,
	GOD_BELIEVER_3_STATE_FALL			,
	GOD_BELIEVER_3_STATE_ANGRY			,
	GOD_BELIEVER_3_STATE_DEAD
};

------------------------------------------------------------------------------------------
--���y���t�B�X�g�z��Ԉꗗ-------------------------------------------------------------------- --EN:--��[Mephisto] Status List------------------------------------------ --------------------------
MEFIST_STATE_NO_STAY					= 16390;--�܂����Ȃ� --EN:--not yet
MEFIST_STATE_STONE_PILLAR				= 16391;--�Β��ɂ��� --EN:--At the stone pillar
MEFIST_STATE_ANGRY						= 16392;--�G�� --EN:--hostile
MEFIST_STATE_DEAD						= 16393;--���S			 --EN:--death
MEFIST_STATE_KILL_WAIT_RENDOL			= 16394;--���q�E�Q�҂�			 --EN:--Waiting for Prince Murder
MEFIST_STATE_KILL_WAIT_BIYO				= 16395;--�r���E�Q�҂� --EN:--Waiting to kill Biyo
MEFIST_STATE_KILL_WAIT_ROGARN			= 16396;--���K�[���E�Q�҂�			 --EN:--Waiting to kill Logan
MEFIST_STATE_KILL_WAIT_MAJO				= 16397;--�����E�Q�҂� --EN:--Waiting to kill a witch
MEFIST_STATE_KILL_WAIT_URU				= 16398;--�E���x�C���E�Q�҂� --EN:--Waiting to kill Urbain
MEFIST_STATE_KILL_WAIT_TOMASU			= 16399;--�g�}�X�E�Q�҂� --EN:--waiting to kill Thomas
MEFIST_STATE_KILL_WAIT_BATTI			= 16400;--�o�b�`�E�Q�҂� --EN:--Waiting for batch killing
mefist_flag_list = {
	MEFIST_STATE_NO_STAY 			,
	MEFIST_STATE_STONE_PILLAR  		,
	MEFIST_STATE_ANGRY  			,
	MEFIST_STATE_DEAD  				,
	MEFIST_STATE_KILL_WAIT_RENDOL  	,
	MEFIST_STATE_KILL_WAIT_BIYO  	,
	MEFIST_STATE_KILL_WAIT_ROGARN  	,
	MEFIST_STATE_KILL_WAIT_MAJO		,
	MEFIST_STATE_KILL_WAIT_URU		,
	MEFIST_STATE_KILL_WAIT_TOMASU	,
	MEFIST_STATE_KILL_WAIT_BATTI
};

------------------------------------------------------------------------------------------
--���y��܂̃g�}�X�z��Ԉꗗ-------------------------------------------------------------------- --EN:--��[Thomas the Big Bag] State List--------------------------------------- ----------------------------
TOMASU_STATE_WAIT					= 16350;--�ו��� --EN:--Package number
TOMASU_STATE_ANGRY					= 16351;--�G�� --EN:--hostile
TOMASU_STATE_DEAD					= 16352;--���S --EN:--death
TOMASU_STATE_ISNOT					= 16353;--�܂����Ȃ� --EN:--not yet
tomasu_flag_list = {
	TOMASU_STATE_WAIT			,
	TOMASU_STATE_ANGRY			,
	TOMASU_STATE_DEAD			,
	TOMASU_STATE_ISNOT
};

------------------------------------------------------------------------------------------
--���y�S�܂ꂽ��m�z��Ԉꗗ-------------------------------------------------------------------- --EN:--��[Heartbroken Warrior] Status List--------------------------------------- -----------------------------
HEART_BREAK_FIGHTER_STATE_STONE_PILLAR	= 16420;--�Β��ɂ��� --EN:--At the stone pillar
HEART_BREAK_FIGHTER_STATE_ANGRY			= 16421;--�G�� --EN:--hostile
HEART_BREAK_FIGHTER_STATE_DEAD			= 16422;--���S --EN:--death
HEART_BREAK_FIGHTER_STATE_MAYBE_DELETE	= 16423;--�������� --EN:-- about to disappear
HEART_BREAK_FIGHTER_STATE_DELETE		= 16424;--�����܂� --EN:--disappear
heartbreak_fighter_flag_list = {
	HEART_BREAK_FIGHTER_STATE_STONE_PILLAR 	,
	HEART_BREAK_FIGHTER_STATE_ANGRY  		,
	HEART_BREAK_FIGHTER_STATE_DEAD			,
	HEART_BREAK_FIGHTER_STATE_MAYBE_DELETE	,
	HEART_BREAK_FIGHTER_STATE_DELETE
};





--�����A�[���ϐ��@�������̃^�C�~���O�ŃN���A�u���b�N���Ȃǂ��i�[���āA�g���܂킷 --EN:--��Variables in the lure Store the number of cleared blocks etc. at the timing of initialization and reuse
ClearBlockCount = 0;				--�N���A���Ă���u���b�N�̐� --EN:--Number of blocks cleared
IsLast = false;						--�Β��̉��ɐi�߂�����𖞂����Ă��邩�H --EN:--Do you meet the conditions to advance to the back of the stone pillar?

--[[�폜�Ƃ̂��ƂȂ̂ŁA�R�����g�A�E�g --EN:--[[Deleting, so comment out
--���n�[�t�n���h�̏�Ԉꗗ --EN:--�� Half hand status list

HALF_STATE_WAIT_KOUDOU     = 16160;--�B���ő҂� --EN:--wait in the tunnel
HALF_STATE_WAIT_SEKITYU    = 16161;--�Β��ő҂� --EN:--Waiting at the stone pillar
HALF_STATE_HOSTILE_KOUDOU  = 16162;--�G��(�B��) --EN:-- Hostility (Tunnel)
HALF_STATE_HOSTILE_SEKITYU = 16163;--�G��(�Β�) --EN:-- Hostility (Stone Pillar)
HALF_STATE_DEAD            = 16164;--���S --EN:--death
HALF_STATE_GO_TO_SEKITYU   = 16165;--�Β��֍s������ --EN:--I want to go to the stone pillar

half_flag_list = {

	HALF_STATE_WAIT_KOUDOU     ,
	HALF_STATE_WAIT_SEKITYU    ,
	HALF_STATE_HOSTILE_KOUDOU  ,
	HALF_STATE_HOSTILE_SEKITYU ,
	HALF_STATE_DEAD            ,
	HALF_STATE_GO_TO_SEKITYU
};

------------------------------------------------------------------------------------------
--��������̏�Ԉꗗ-------------------------------------------------------------------- --EN:--�� Savvy state list -------------------------------------------- -------------------------
--�A�N�V����ID				 --EN:--Action ID
MONOSHIRI_STATE_ISNOT    = 16340--�܂����Ȃ�			 --EN:--not yet
MONOSHIRI_STATE_BUSINESS = 16341--��񔄂��			 --EN:--Sell information
MONOSHIRI_STATE_HOSTILE  = 16342--�G��			 --EN:--hostile
MONOSHIRI_STATE_DEAD     = 16343--���S			 --EN:--death

monoshiri_flag_list = {
	MONOSHIRI_STATE_ISNOT   ,--�܂����Ȃ�			 --EN:--not yet
	MONOSHIRI_STATE_BUSINESS,--��񔄂��			 --EN:--Sell information
	MONOSHIRI_STATE_HOSTILE ,--�G��			 --EN:--hostile
	MONOSHIRI_STATE_DEAD     --���S --EN:--death
};

]]
--------------------------------------------------------------------------------------
--�}�b�v�ǂݍ��ݎ��ɓǂ܂�鏉���������� --EN:--Initialization process read when reading the map ��
--------------------------------------------------------------------------------------
function Initialize_m01_00_00_00(proxy)
	print("Initialize_m01_00_00_00 begin");
	
	--QWC�̍X�V�v�� --EN:-- QWC update request
	proxy:RecvGlobalQwc();
	
	--�Β��Ɍ���A���̍Č��͂���܂���i�m�o�b�͌��Ǐ�����̂ōČ��������Ȃ��j --EN:--Only for stone pillars, corpses will not be reproduced (NPCs will eventually disappear, so there will be no reproduction)
	proxy:AddFieldInsFilter(611);-- �S�܂ꂽ��m --EN:-- Broken Warrior
	proxy:AddFieldInsFilter(613);-- �v�l --EN:-- Dignitaries
	proxy:AddFieldInsFilter(615);-- �q���C�� --EN:-- Heroine
	proxy:AddFieldInsFilter(617);-- ���҃��K�[�� --EN:-- Sage Logan
	proxy:AddFieldInsFilter(619);-- ���ق̒��A�����g --EN:-- Yurt, Lord of Silence
	proxy:AddFieldInsFilter(680);-- ���t�B�X�g�t�F���X --EN:-- Mephistopheles
	proxy:AddFieldInsFilter(681);-- ���p�̓k --EN:-- sorcerer
	proxy:AddFieldInsFilter(682);-- �_�̐M�k����1 --EN:-- God's Follower Part 1
	proxy:AddFieldInsFilter(683);-- �_�̐M�k����2 --EN:-- God's Follower Part 2
	proxy:AddFieldInsFilter(684);--�_�̐M�k����3 --EN:--God's Follower Part 3
	proxy:AddFieldInsFilter(687);-- ��܂̃g�}�X --EN:-- Big Bag Thomas
	proxy:AddFieldInsFilter(688);-- �����h�����q --EN:-- Prince Lendl
	proxy:AddFieldInsFilter(689);-- ���� --EN:-- witch
	proxy:AddFieldInsFilter(690);-- �E���x�C�� --EN:-- Urbain
	proxy:AddFieldInsFilter(693);-- �p�b�` --EN:-- patch
	proxy:AddFieldInsFilter(694);-- �b�艮�{�[���h�E�B�� --EN:-- Blacksmith Baldwin
	proxy:AddFieldInsFilter(695);-- �r�������O���� --EN:-- Bjorn Grim
	proxy:AddFieldInsFilter(821);-- �f�����Y�\�E���������� --EN:-- Protector of Demon's Souls
	
	
	--�N���A�󋵂�GOOD�ŃG���A��ʂ��� --EN:--Pass through the area with a GOOD clear status
	if proxy:IsCompleteEvent( 510 ) == false then 
		if proxy:GetClearState() == CLEAR_STATE_GOODEND then
			proxy:OnKeyTime2( 510 , "OnEvent_510" , 1.0,0,0,once);			
		end
	end

	--�N���A���Ă���G���A�̐����擾 --EN:-- Get the number of cleared areas
	local areaclear_actionId_list = {8010, 8011, 8012, 8013, 8014};
	local areaclear_actIdNum = table.getn(areaclear_actionId_list);
	for index = 1, areaclear_actIdNum, 1 do
		if proxy:IsCompleteEvent( areaclear_actionId_list[index] ) == true then
			ClearBlockCount = ClearBlockCount + 1;
		end
	end
	
	--�S�G���A���N���A���Ă��邩�H --EN:--Have you cleared all areas?
	if areaclear_actIdNum == ClearBlockCount then
		IsLast = true;
	end
	
	--�N���A�����P�ȏ�Ȃ牤���̊J���t���O��ON --EN:-- If the number of clears is 1 or more, the opening flag of the castle gate is ON
	if proxy:GetClearCount() > 0 then
		print("�����J������OK"); --EN:print("Ready to open the castle gate");
		proxy:SetEventFlag(8035,true);
		if proxy:IsInventoryEquip(TYPE_GOODS,9995) == true then
			print("�������̐΂������Ă���"); --EN:print("I have a black eye stone");
			proxy:SetEventFlag( 15500 , true );
		else
			print("�������̐΂͎����Ă��Ȃ�"); --EN:print("I don't have the Black Eye Stone");
		end
	end

	--�e�{�X�̓|���������擾(�e�}�b�v�ł�����Ă͂��邪�A�O�̂��߂ɂ�����x����) --EN:--Obtain the number of bosses defeated
	GetBossFlagCount( proxy, param );
	
	--2008.05.16/toyohide
	--��荇������񉮒ǉ� --EN:--Informant added for now
	if boss_flagCount >= 1 then
		print("Add InfoId 16");
		proxy:SetEnableInfoStateForEvent(16,true);
		print("Add InfoId 17");
		proxy:SetEnableInfoStateForEvent(17,true);
	end

--------------------------------------------------------------------------------
--�e�G���A���[�v�֘A --EN:--Each area warp related
--------------------------------------------------------------------------------
	SingleReset(proxy,0);
--��0���e�G���A�փ��[�v(����)�� --EN:-- �� 0 �� Warp to each area (royal castle) ��
	proxy:OnDistanceAction(    0, 10000, 1000, "OnEvent_0"   , WarpGimmickDist_A, HELPID_CHECK_OUJOU,        180, WarpGimmickAngle_A, everytime );

	SingleReset(proxy,1);
--��1���e�G���A�փ��[�v(�Í�)�� --EN:-- 1 �� Warp to each area (old fort) ��
	proxy:OnDistanceAction(    1, 10000, 1001, "OnEvent_1"   , WarpGimmickDist_A, HELPID_CHECK_HURUTORIDE  , 180, WarpGimmickAngle_A, everytime );
	
	SingleReset(proxy,2);
--��2���e�G���A�փ��[�v(�S��)�� --EN:-- 2 �� Warp to each area (prison castle) ��
	proxy:OnDistanceAction(    2, 10000, 1002, "OnEvent_2"   , WarpGimmickDist_A, HELPID_CHECK_ROUJOU,       180, WarpGimmickAngle_A, everytime );	

	SingleReset(proxy,3);
--��3���e�G���A�փ��[�v(�s��)�� --EN:-- 3 �� Warp to each area (unclean) ��
	proxy:OnDistanceAction(    3, 10000, 1003, "OnEvent_3"   , WarpGimmickDist_A, HELPID_CHECK_HUJOU,        180, WarpGimmickAngle_A, everytime );

	SingleReset(proxy,4);
--��4���e�G���A�փ��[�v(�B��)�� --EN:-- �� 4 �� Warp to each area (pit) ��
	proxy:OnDistanceAction(    4, 10000, 1004, "OnEvent_4"   , WarpGimmickDist_A, HELPID_CHECK_KOUDOU,       180, WarpGimmickAngle_A, everytime );

--��5���e�G���A�փ��[�v(�k��)�� --EN:-- 5 �� Warp to each area (northern limit) ��
	--proxy:OnDistanceAction(    5, 10000, 1005, "OnEvent_5"   , WarpGimmickDist_A, HELPID_CHECK_HOKUGEN,      180, WarpGimmickAngle_A, everytime );

--��8083�����[�v���Ė߂��Ă����� --EN:-- �� 8083 �� warped and came back ��
	--�e�}�b�v�̗v�΂ł̃��[�v���ɁA�t���O�𗧂Ă�B --EN:--Flags when warping at keystones on each map.
	--�߂��Ă�������̃t���O�𗧂Ă� --EN:--Flag returned judgment
	--proxy:SetEventFlag(8083, true);

--��8084������ɍs�����������遡 --EN:--��8084��I have been to the royal castle��
	--����ł�Init�ɂāA�t���O�𗧂Ă�B --EN:--Set a flag at Init in the royal castle.
--��8085���ÍԂɍs�����������遡 --EN:--��8085��I have been to the old fort��
	--�ÍԂł�Init�ɂāA�t���O�𗧂Ă�B --EN:--Set a flag at Init in the old fort.
--��8086���S��ɍs�����������遡 --EN:-- �� 8086 �� I have been to the prison ��
	--�S��ł�Init�ɂāA�t���O�𗧂Ă�B --EN:-- Set a flag at Init in prison.
--��8087���s��ɍs�����������遡 --EN:--��8087��I have been to unclean��
	--�s��ł�Init�ɂāA�t���O�𗧂Ă�B --EN:--Set a flag at Init in Unclean.
--��8088���B���ɍs�����������遡 --EN:--��8088��I have been to the tunnel��
	--�B���ł�Init�ɂāA�t���O�𗧂Ă�B --EN:--Set a flag at Init in the tunnel.
	
--------------------------------------------------------------------------------
--���X�{�X�֘A --EN:--Last boss related
--------------------------------------------------------------------------------
--��40�����X�{�X�����ɍs���܂ł̔�э~��A�|������(��b�V�X�e������Ăяo��) --EN:-- 40 �� jumping down to go to the final boss room, police play �� (call from conversation system)
--test
--proxy:LuaCall(40,2000,"OnEvent_40_RemoStart",everytime);
--proxy:LuaCall(40,2001,"OnEvent_40_RemoFinish",once);
	if proxy:IsCompleteEvent( 40 ) == false then
		
		proxy:LuaCall( 40 , 0 , "OnEvent_40" , everytime );
		
		proxy:NotNetMessage_begin();
			--�|�����J�n�t�F�[�h��ɌĂ΂��n���h�� --EN:--Handler called after polyplay start fade
			proxy:LuaCall(40,REMO_START,"OnEvent_40_RemoStart",once);
			--�|�����I����ɌĂ΂��n���h�� --EN:--Handler called after the polyplay ends
			proxy:LuaCall(40,REMO_FINISH,"OnEvent_40_RemoFinish",once);
		proxy:NotNetMessage_end();
		
		--�v�Ό����Ȃ� --EN:--I can't see the keystone
		proxy:SetColiEnable(1140,false);
		proxy:SetDrawEnable(1140,false);
		
		proxy:SetColiEnable(1141,false);
		proxy:SetDrawEnable(1141,false);
		
	else--���X�{�X�|�����I�����Ă����� --EN:--If the Last Bospoli drama had ended
		--proxy:TreasureDispModeChange2( 1140 , true ,KANAME_SFX);
		proxy:TreasureDispModeChange2( 1141 , true ,KANAME_SFX);
		
		--proxy:TreasureDispModeChange2( 1145 , true ,KANAME_SFX);
		proxy:TreasureDispModeChange2( 1146 , true ,KANAME_SFX);
		SingleReset(proxy,42);
		SingleReset(proxy,43);
		if proxy:IsCompleteEvent( 70 ) == false then
			proxy:OnDistanceAction( 42,10000,1140,"OnEvent_42",WarpGimmickDist_A,HELPID_GO_TO_SEKITYUU,0,WarpGimmickAngle_B,everytime);
		end
		proxy:OnDistanceAction( 43,10000,1145,"OnEvent_43",WarpGimmickDist_A,HELPID_GO_TO_SEKITYUU,0,WarpGimmickAngle_B,everytime);		
	end
	
	--[[
--��60���g�U�̃��m�����ݍ��ރ|������ --EN:--��60��Poly drama where things of diffusion crouch ��
	if proxy:IsCompleteEvent( 60 ) == false then
		proxy:OnRegionJustIn( 60 , 10000 , 2040 , "OnEvent_60" , once );
		
		proxy:NotNetMessage_begin();
			--�|�����J�n�t�F�[�h��ɌĂ΂��n���h�� --EN:--Handler called after polyplay start fade
			proxy:LuaCall(60,REMO_START,"OnEvent_60_RemoStart",once);
			--�|�����I����ɌĂ΂��n���h�� --EN:--Handler called after the polyplay ends
			proxy:LuaCall(60,REMO_FINISH,"OnEvent_60_RemoFinish",once);
		proxy:NotNetMessage_end();
	end
	]]
	
--��70�����X�{�X��|������A�\�E�����聡	 --EN:-- �� 70 �� After defeating the final boss, get soul ��
	if proxy:IsCompleteEvent( 70 ) == false then
		proxy:OnCharacterDead( 70 , 821 , "OnEvent_70" , once );
		proxy:CustomLuaCall( 450 , "OnEvent_450" , once );
	else
		proxy:SetEventFlag( 450 , true );
		InvalidBackRead( proxy, 821 );
		--�q���C�����ړ������� --EN:--Move the heroine
		LuaFunc_ForceOmission(proxy,615);	
		proxy:SetAlwayEnableBackread_forEvent( 615 , true );
		proxy:SetDisableGravity( 615,true );
	end

--��71�����X�{�X��|������A�|�������Đ��� --EN:-- �� 71 �� After defeating the final boss, play the police play ��
	if proxy:IsCompleteEvent( 71 ) == false then
		proxy:OnRegionIn( 71 , 10000 , 2082 , "OnEvent_71" , everytime );
		--proxy:LuaCall(71, 0, "OnEvent_71", once);--�|�����Đ��v���n���h���o�^		 --EN:--Register polyplay request handler
		proxy:NotNetMessage_begin();
			--�|�����J�n�t�F�[�h��ɌĂ΂��n���h�� --EN:--Handler called after polyplay start fade
			proxy:LuaCall(71,REMO_START,"OnEvent_71_RemoStart",once);
			--�|�����I����ɌĂ΂��n���h�� --EN:--Handler called after the polyplay ends
			proxy:LuaCall(71,REMO_FINISH,"OnEvent_71_RemoFinish",once);
		proxy:NotNetMessage_end();
	else
		--���q���C���ւ̃_���[�W�Ď�(�G���f�B���O1�p)��Bad End --EN:--��Damage monitoring to heroine (for ending 1)��Bad End
		--proxy:OnSimpleDamage( 80 , 615 , 10000 , "OnEvent_80" , once );
		proxy:OnCharacterDead( 80 , 615 , "OnEvent_80",once);
	
		proxy:NotNetMessage_begin();
			--�|�����J�n�t�F�[�h��ɌĂ΂��n���h�� --EN:--Handler called after polyplay start fade
			proxy:LuaCall(80,REMO_START,"OnEvent_80_RemoStart",once);
			--�|�����I����ɌĂ΂��n���h�� --EN:--Handler called after the polyplay ends
			proxy:LuaCall(80,REMO_FINISH,"OnEvent_80_RemoFinish",once);
		proxy:NotNetMessage_end();
	
		--���̈�Ď���ǉ�(�G���f�B���O2�p)��Good End --EN:--�� Added Area Surveillance (for Ending 2) �� Good End
		local possible_chr_type = ATTR_HOST + ATTR_LIVE + ATTR_GREY;
		proxy:OnPlayerActionInRegionAttribute( 81, 2010, "OnEvent_81", 10010405, possible_chr_type, once );
	
		proxy:NotNetMessage_begin();
			--�|�����J�n�t�F�[�h��ɌĂ΂��n���h�� --EN:--Handler called after polyplay start fade
			proxy:LuaCall(81,REMO_START,"OnEvent_81_RemoStart",once);
			--�|�����I����ɌĂ΂��n���h�� --EN:--Handler called after the polyplay ends
			proxy:LuaCall(81,REMO_FINISH,"OnEvent_81_RemoFinish",once);
		proxy:NotNetMessage_end();	
	end
	
--��75�����X�{�X���̂𒲂ׂ���	 --EN:-- �� 75 �� Examined the last boss corpse ��
	proxy:AddCorpseEvent( 75 , 821 );
	proxy:LuaCall( 75 , 0 , "OnEvent_75",once);

--��61���{�X�����ɓ��遡	 --EN:-- �� 61 �� Enter the boss room ��
	--���{�X�������Ă���Ƃ������C�x���g�o�^ --EN:-- Event registration only when the mid-boss is alive
	if proxy:IsCompleteEvent( 70 ) == false then	

		--�\���̂Ƃ��͈�x�ڂɃ{�X�����ɓ���p�̃C�x���g�𖈉�o�^���������̂ŁA�Ή�����t���O��OFF�ɂ���B --EN:-- When soloing, we want to register the event for entering the boss room for the first time every time, so turn off the corresponding flag.
		SingleReset(proxy, 61);

		--�������A�j���Đ��p�̊J�n�n���h��(���񁨕���) --EN:--�� Start handler for synchronous animation playback (turning �� walking)
		proxy:LuaCall( 61, 1, "OnEvent_61_1", everytime );		

		--(�Z�b�V��������)�{�X�O�̖��@�ǂ��ŏ��ɒʂ��̂͐����̐l���� --EN:--(During the session) Only survivors can pass through the magic wall in front of the boss first
		local possible_chr_type = ATTR_HOST + ATTR_LIVE + ATTR_GREY;			

		proxy:NotNetMessage_begin();
			--��61�������J���Ă���Ƃ��ɒ��ɓ��邽�߂̃C�x���g��ǉ��� --EN:--��61�� Added an event to enter when the door is open��
			proxy:OnPlayerActionInRegionAttribute( 61, 2895, "OnEvent_61", HELPID_GO_TO_IN, possible_chr_type, once );
		proxy:NotNetMessage_end();
		
		--�\�E���u�����h��\�� --EN:--Soul brand hidden
		proxy:SetDrawEnable( 1130 , false );--�ЂƂ܂��`�悾��OFF --EN:--Only drawing is turned off for the time being
		proxy:SetColiEnable( 1130 , false );
		proxy:InvalidSfx( 1131 ,false );

	end	

--��62���{�X�����񂾂Ƃ��̏������� --EN:-- �� 62 �� Initialization when the boss dies ��
	if proxy:IsCompleteEvent( 70 ) == true then
		InvalidCharactor( proxy, 821 );
		proxy:SetEventFlag( 62, true );
		proxy:OnDistanceAction( 44,10000,1140,"OnEvent_44",WarpGimmickDist_A,HELPID_GO_TO_SEKITYUU,0,WarpGimmickAngle_B,everytime);
		
		--�\�E���u�����h�����ĂȂ� --EN:-- Don't leave out Soul Brand
		if proxy:IsCompleteEvent( 141 ) == false then			
			--���ׂ�C�x���g���͓̂������܂��A���ׂ��l�̓z�X�gor�V���O���v���C���[�ł� --EN:--The event itself to be examined is synchronized, the person who can be examined is the host or single player
			--proxy:NotNetMessage_begin();
				--�z�X�g�A�����A�O���C�̂ݒ��ׂ邱�Ƃ��ł��� --EN:--Only hosts, survivors, and grays can be examined
				local possible_chr_type = ATTR_HOST + ATTR_LIVE + ATTR_GREY;				
				proxy:OnDistanceActionAttribute( 141 , LOCAL_PLAYER , 1130 , "OnEvent_141" , ItemBoxDist_A , 10010135 , 0 , ItemBoxAngle_A ,possible_chr_type, everytime ); 
				proxy:LuaCall( 141,1,"OnEvent_141_2",once);
				proxy:LuaCall( 141,2,"OnEvent_141_3",once);
				proxy:TreasureDispModeChange2( 1130, true ,KEN_SFX);
				--proxy:SetRarity( 1130, 10104 );
			--proxy:NotNetMessage_end();
		else
			proxy:SetDrawEnable( 1130 , false );--�ЂƂ܂��`�悾��OFF --EN:--Only drawing is turned off for the time being
			proxy:SetColiEnable( 1130 , false );	
			proxy:InvalidSfx( 1131 , false );			
		end
	end
	
--�������w�����̃|������ --EN:--��Poly drama of releasing the magic square��
	if proxy:IsCompleteEvent( 39 ) == true then
		proxy:SetDrawEnable( 1190 , false );--��OBJ�\��OFF --EN:--Sword OBJ display OFF
		proxy:SetColiEnable( 1190 , false );--��OBJ�A�^��OFF --EN:--Sword OBJ Atari OFF
		
		proxy:SetDrawEnable( 1200 , false );--�����w1OBJ�\��OFF --EN:--Magic square 1 OBJ display OFF
		proxy:SetColiEnable( 1200 , false );--�����w1OBJ�A�^��OFF --EN:--Magic Square 1 OBJ Atari OFF
		proxy:SetDrawEnable( 1201 , false );--�����w2OBJ�\��OFF --EN:--Magic square 2 OBJ display OFF
		proxy:SetColiEnable( 1201 , false );--�����w2OBJ�A�^��OFF --EN:--Magic Square 2 OBJ Atari OFF
		proxy:SetDrawEnable( 1202 , false );--�����w3OBJ�\��OFF --EN:--Magic square 3 OBJ display OFF
		proxy:SetColiEnable( 1202 , false );--�����w3OBJ�A�^��OFF --EN:--Magic Square 3 OBJ Atari OFF
		proxy:SetDrawEnable( 1203 , false );--�����w4OBJ�\��OFF --EN:--Magic square 4 OBJ display OFF
		proxy:SetColiEnable( 1203 , false );--�����w4OBJ�A�^��OFF	 --EN:--Magic Square 4 OBJ Atari OFF
		proxy:SetEventResponsedNavimeshFlag_Disable();
	end
	
--���g�U�̃��m�����ݍ��ރ|������ --EN:--�� A poly-drama in which diffusion objects crouch ��

	if proxy:IsCompleteEvent( 40 ) == false then
		
		--�}�b�v�p�[�c�𖳌������� --EN:--Disable map parts
		proxy:SetDrawEnableArray( 1020 , false );--�\��OFF --EN:--Display OFF
		proxy:SetColiEnableArray( 1020 , false );--������OFF --EN:--Hit OFF
		
		proxy:SetDrawEnableArray( 1121 , false );--�\��OFF --EN:--Display OFF
		proxy:SetColiEnableArray( 1121 , false );--������OFF --EN:--Hit OFF
		
		--�؂̃I�u�W�F�𖳌������� --EN:--disable tree objects
		local first_id = 1030;
		local last_id  = 1058;
		local now_id   = first_id;
		local num      = last_id - first_id + 1;
		
		for i=1 , num , 1 do
			proxy:SetDrawEnable( now_id , false );--�\��OFF --EN:--Display OFF
			proxy:SetColiEnable( now_id , false );--������OFF --EN:--Hit OFF
			now_id = now_id + 1;
		end	
		
		--�Ή�����G�𖳌������� --EN:--Nullify the corresponding enemy
		--�폜 --EN:--delete
		
		--�{�X�𖳌��� --EN:--disable boss
		InvalidCharactor( proxy , 821 );
		
		--SFX�𖳌��� --EN:--Disable SFX
		proxy:InvalidSfx( 1110 , false );--RootErase���Ȃ� --EN:--No RootErase
		
	else	
		--OBJ�𖳌��� --EN:--disable OBJ
		proxy:SetDrawEnable( 1100 , false );
		proxy:SetColiEnable( 1100 , false );
		
		proxy:SetDrawEnableArray( 1120 , false );--�\��OFF --EN:--Display OFF
		proxy:SetColiEnableArray( 1120 , false );--������OFF --EN:--Hit OFF
		
		--SFX�𖳌��� --EN:--Disable SFX
		--proxy:InvalidSfx( 1110 , false );
	end
--��72�����X�{�X�̐��P�� --EN:--��72��Last Boss Voice 1��
	if proxy:IsCompleteEvent( 70 ) == false then
		SingleReset( proxy ,72 );
		--proxy:SetEventFlag( 61 , true );--�{�X�����C�x���g���ꎞ�I�ɖ����� --EN:--Disable boss room event temporarily
		proxy:OnRegionJustIn( 72 , 10000 , 2080 , "OnEvent_72",once);
		proxy:RegistSimpleTalk( 72 , 821 , 28500 , TALK_ATTR_ALL-TALK_ATTR_REPEAT);
	end
	
--��73�����X�{�X�̐��Q�� --EN:-- �� 73 �� Last Boss Voice 2 ��
	if proxy:IsCompleteEvent( 70 ) == false then
		SingleReset( proxy ,73 );
		proxy:OnRegionJustIn( 73 , 10000 , 2081 , "OnEvent_73",once);
	end
--[[�����̏��ԏイ�܂������Ȃ��B �����B --EN:--[[It doesn't work because of the order of processing. tomorrow.
--��70�����X�{�X��|������A�|�������Đ��� --EN:-- �� 70 �� After defeating the final boss, play the police play ��
	if proxy:IsCompleteEvent( 70 ) == true then
		proxy:ForceDead( 821 );
		OnEvent_70_RemoFinish(proxy, param);--�Ή�����|�����I�����ɌĂ΂��n���h�����ĂԁB --EN:--Call the handler that will be called when the corresponding polyplay ends.
	end
]]

--------------------------------------------------------------------------------
--�M�~�b�N�֘A --EN:--Gimmick related
--------------------------------------------------------------------------------
--��20���p�j�f�[�����̓o�ꁡ�n���h���o�^ --EN:--��20��Appearance of Wandering Demon ��Handler Registration
	proxy:NotNetMessage_begin();
		--�v���C���[���\���Ŏ��S�������ɃL�b�N����܂��B --EN:--Kicked when a player dies solo.
		proxy:LuaCall( 4000, 100, "PlayerDeath_m01_00_00_00", everytime );
		--�v���C���[�������������ɃL�b�N����܂��B --EN:--Kicked when the player is revived.
		proxy:LuaCall( 4032, 100, "PlayerRevive_m01_00_00_00", everytime );
	proxy:NotNetMessage_end();

	--���p�j�f�[�����p --EN:-- �� For prowling demons
	if proxy:IsCompleteEvent( 20 ) == true then
		LuaFunc_VisibleTheWanderingDemon  (proxy, param, demon_id_list_m01_00_00_00);
		proxy:SetEventFlag(20,false);
	else
		LuaFunc_InvisibleTheWanderingDemon(proxy, param, demon_id_list_m01_00_00_00);
	end
--BGM�Đ��֘A-------------------------------------------------------------------------------- --EN:--BGM playback related--------------------------------------------- -----------------------------------
	--�|������������������� --EN:--If you have ever seen a police drama
	if proxy:IsCompleteEvent( 30 ) == true		--�}�b�v�Љ�|�������Đ��ς݁@���� --EN:-- The map introduction police play has been played and
	and proxy:IsCompleteEvent( 31 ) == true then--�����|�������Đ��ς݁@�Ȃ�� --EN:--If the revival polyplay has already been played
		--�Ō�Ł@�Ō�ւ̃|�������I����ĂȂ��ꍇ�͉͂������Ȃ� --EN:-- At the end, if the polyplay to the end is not over, do nothing
		if IsLast == true and  proxy:IsCompleteEvent( 39 ) == false then
			--�������Ȃ� --EN:--do nothing
		else
			--�}�b�v�̃N���A���ɂ���āA�Đ�����BGM�𒆂ŕύX���čĐ� --EN:--Depending on the number of map clears, change the background music to be played.
			proxy:OnKeyTime2( 30 , "PlayBGM_SEKITYUU" , 0.1,0,0,once);
			--PlayBGM_SEKITYUU(proxy, param);
			print("���Β�BGM�Đ�"); --EN:print("��stone pillar BGM playback");
		end		
	end
--��422��BGM�Đ�3(���X�{�X��)�� --EN:--��422��BGM Playback 3 (Last Boss Battle)��
	if proxy:IsCompleteEvent( 70 ) == false then
		SingleReset(proxy, 422);
		proxy:EnableLogic( 821, false );
		proxy:RepeatMessage_begin();
			proxy:OnRegionIn(422,10000,2061,"OnEvent_422",everytime);--�̈�ւ̊Ď��o�^ --EN:--Registration to watch area
		proxy:RepeatMessage_end();
	end

	--proxy:CreateSpreadBeast( 1100, 1101 );
---------------------------------------------------------------------------------------------
	
--��30���}�b�v�Љ�|�����Đ��� --EN:--��30��Map Introduction Polyplay Playback��
	if proxy:IsCompleteEvent( 30 ) == false then		
		proxy:NotNetMessage_begin();
			--�|�����J�n�t�F�[�h��ɌĂ΂��n���h�� --EN:--Handler called after polyplay start fade
			proxy:LuaCall(30,REMO_START,"OnEvent_30_RemoStart",once);
			--�|�����I����ɌĂ΂��n���h�� --EN:--Handler called after the polyplay ends
			proxy:LuaCall(30,REMO_FINISH,"OnEvent_30_RemoFinish",once);
		proxy:NotNetMessage_end();
		
		OnEvent_30(proxy,param);
		--proxy:OnKeyTime2( 30 , "OnEvent_30" , 0.0 , 0 , 1 , once );
	else
		if proxy:IsCompleteEvent( 37 ) == false then
			if proxy:GetClearCount() == 0 then		
				proxy:OnKeyTime2( 32 , "OnEvent_32",0.1,0,0,once);
			end
		end
		
		--��31�������|������ --EN:-- �� 31 �� Resurrection poly drama ��
		if proxy:IsCompleteEvent( 31 ) == false then
			--�t�@�����N�X���j�ς� --EN:--Phalanx defeated
			if proxy:IsCompleteEvent( 4096 ) == true then
				proxy:NotNetMessage_begin();
					--�|�����J�n�t�F�[�h��ɌĂ΂��n���h�� --EN:--Handler called after polyplay start fade
					proxy:LuaCall(31,REMO_START,"OnEvent_31_RemoStart",once);
					--�|�����I����ɌĂ΂��n���h�� --EN:--Handler called after the polyplay ends
					proxy:LuaCall(31,REMO_FINISH,"OnEvent_31_RemoFinish",once);
				proxy:NotNetMessage_end();
				OnEvent_31(proxy,param);
			else
				--�t�@�����N�X��|�����ɐΒ��֖߂��Ă����̂ŁABGM�Đ� --EN:--Since you returned to the stone pillar without defeating the phalanx, play the BGM.
				proxy:OnKeyTime2( 31 , "PlayBGM_SEKITYUU" ,0.1 , 0 , 1 ,once);
				--PlayBGM_SEKITYUU(proxy, param);
				print("���Β�BGM�Đ�"); --EN:print("Stone pillar BGM playback");
			end
		else
			--�Ō�ւ̉���|���������Ă��Ȃ� --EN:-- Haven't seen the release polyplay to the end
			if proxy:IsCompleteEvent( 39 ) == false and IsLast == true then
				proxy:NotNetMessage_begin();
					--�|�����J�n�t�F�[�h��ɌĂ΂��n���h�� --EN:--Handler called after polyplay start fade
					proxy:LuaCall( 39 , REMO_START,"OnEvent_39_RemoStart",once);
					--�|�����I�����ɌĂ΂��n���h�� --EN:--Handler called at the end of the polyplay
					proxy:LuaCall( 39 , REMO_FINISH, "OnEvent_39_RemoFinish",once);
				proxy:NotNetMessage_end();
				OnEvent_39(proxy,param);				
			end
		end
	end
	


--��303���v�l����̘̐b�� --EN:-- �� 303 �� Old tales from dignitaries ��
	proxy:NotNetMessage_begin();
		proxy:LuaCall( 303,0,"OnEvent_303",once);--���[�r�[�Đ��p�̉�b�Ăяo���n���h�� --EN:--Conversation call handler for movie playback
	proxy:NotNetMessage_end();
	
--��34���v�΂̕���̊J���� --EN:-- �� 34 �� Releasing the seal of the keystone ��
	proxy:NotNetMessage_begin();
		proxy:LuaCall(34, 0, "OnEvent_34", once);--�v�l���[�r�[��̉�b�Ăяo�������n���h�� --EN:--Handler called after VIP movie
	proxy:NotNetMessage_end();
	
--��304���q���C������A�C�e����Ⴄ�� --EN:-- �� 304 �� Receive items from the heroine ��
	proxy:NotNetMessage_begin();
		proxy:LuaCall(304,0,"OnEvent_304",once);
	proxy:NotNetMessage_end();
--��305���v�l����A�C�e����Ⴄ�� --EN:-- �� 305 �� Receive an item from a dignitary ��
	proxy:NotNetMessage_begin();
		proxy:LuaCall(305,0,"OnEvent_305",once);
	proxy:NotNetMessage_end();
	
--��80���G���f�B���O�|����1�� --EN:-- �� 80 �� Ending police play 1 ��
	--(OnEvent_71�̏I����ɒǉ�) --EN:--(added after OnEvent_71 ends)
	
--��81���G���f�B���O�|����2�� --EN:-- �� 81 �� Ending police play 2 ��
	--(OnEvent_71�̏I����ɒǉ�) --EN:--(added after OnEvent_71 ends)

--��140�����̂Ɏh�����Ă��錕�� --EN:--��140��Sword stuck in corpse��
	--if proxy:IsCompleteEvent( 140 ) == false then
		---�z�X�g�A�����A�O���C�̂ݒ��ׂ邱�Ƃ��ł��� --EN:--Only hosts, survivors, and grays can be examined
		--local possible_chr_type = ATTR_HOST + ATTR_LIVE + ATTR_GREY;
		
		--proxy:OnDistanceActionAttribute( 140 , 10000 , 1130 , "OnEvent_140" , ItemBoxDist_A , 10010135 , 0 , ItemBoxAngle_A ,possible_chr_type, once ); 
		--proxy:LuaCall( 140,1,"OnEvent_140_2",once);
	--else
		--proxy:SetDrawEnable( 1130 , false );--�ЂƂ܂��`�悾��OFF	 --EN:--Only drawing is turned off for the time being
		--proxy:InvalidSfx(1130, false);
	--end
	
	--proxy:TreasureDispModeChange( 1130, true );
	--proxy:SetRarity( 1130, 10730 );
	
--���v�l�ւ̔����J���Ă��� --EN:--�� The door to dignitaries is open
	if	boss_flagCount >= 1 then
		--proxy:PlayAnimation( 1111, 1 );
		proxy:SetColiEnable( 1111, false );
		proxy:SetDrawEnable( 1111, false );
		proxy:InvalidSfx(2071, false);
	end
	
--------------------------------------------------------------------------------
--NPC�֘A --EN:--NPC related
--------------------------------------------------------------------------------
--[[���q���C���֘A��]]-------------------------------------------------------------- --EN:--[[��Heroine Related��]]---------------------------------------- ----------------------

--��100���q���C�����Ō�̐킢�����ӂ��遡 --EN:-- �� 100 �� The heroine decides the final battle ��
	--(Second_Initialize�Ŕ����A�ǉ�) --EN:--(Added after judgment by Second_Initialize)
	

--��90,91���o�b���q���C���̑O���삭��(��b�V�X�e������Ăяo��) --EN:-- �� 90, 91 �� PC kneels in front of heroine �� (call from conversation system)
	proxy:LuaCall( 90 , 0 , "OnEvent_90" , everytime );
	proxy:LuaCall( 91 , 0 , "OnEvent_91" , everytime );
	
--��b����Ă΂��n���h�� --EN:--handler called from conversation
	proxy:LuaCall( 110, 0, "OnEvent_110", everytime );
--��113���q���C���𗧂��オ�点�遡(��b�V�X�e������Ăяo��) --EN:-- �� 113 �� Stand up the heroine �� (call from the conversation system)
	proxy:LuaCall( 113, 0, "OnEvent_113", everytime );

--��111���q���C�����S�Ď���	 --EN:-- �� 111 �� Heroine death watch ��
	proxy:RepeatMessage_begin();
		proxy:SetEventFlag( 115 , false );	
		proxy:OnCharacterDead(111, 615, "OnEvent_111", once);
		--proxy:OnCharacterHP( 111 , 615 , "OnEvent_111",0.0,once);
	proxy:RepeatMessage_end();
	
	--������Ԃ��Z�b�g(��Ԃ����ݒ�̏ꍇ�A�w�肵����Ԃ��Z�b�g����) --EN:--Set the initial state (if the state is not set, set the specified state)
	SetFirstNpcStateFlag( proxy , param , heroine_flag_list , HEROINE_STATE_ISNOT );

	--�q���C�����܂����Ȃ� --EN:--There is no heroine yet
	if proxy:IsCompleteEvent( HEROINE_STATE_ISNOT ) == true then
		if boss_flagCount >= 1 then--1�̈ȏ�|���Ă����� --EN:--If you have killed more than one
			SetNpcStateFlag(proxy,param, heroine_flag_list , HEROINE_STATE_WAIT_FOR_PLAYER );
		else
			--�q���C���������� --EN:--The heroine disappears
			InvalidBackRead( proxy , 615 );
		end
	end
	
--~ 	--�q���C�������̑O�Ɉړ����Ă��� --EN:--The heroine is moving in front of the door
--~ 	if proxy:IsCompleteEvent( HEROINE_STATE_WAIT_FOR_PLAYER ) == true then
--~ 		if boss_flagCount >= 1 then--�P�̈ȏ�|���Ă����� --EN:--If you have killed more than one
--~ 			--��b���I�点�Ă��Ȃ��ꍇ�͉��x�� --EN:--as many times if you haven't finished the conversation
--~ 			if	proxy:IsCompleteEvent(110) == false then
--~ 				SetNpcStateFlag(proxy, param, heroine_flag_list, HEROINE_STATE_DOOR_FRONT );
--~ 				proxy:SetAlwayEnableBackread_forEvent( 615 , true );
--~ 				--�q���C���̋����o�b�N���[�h�𖳌��� --EN:--Disable the heroine's forced back read
--~ 				--proxy:OnKeyTime2( 40,"OnEvent_40_1",0,0,2,once);
--~ 			end
--~ 		end
--~ 	end
	
	--�q���C�������̑O���狎�� --EN:--The heroine leaves in front of the door
	if	IsLast == true then
		if	proxy:IsCompleteEvent(HEROINE_STATE_WAIT_FOR_PLAYER) 	== true then--or
--~ 			proxy:IsCompleteEvent(HEROINE_STATE_DOOR_FRONT) 		== true or
--~ 			proxy:IsCompleteEvent(HEROINE_STATE_DOOR_LEAVE) 		== true then
			SetNpcStateFlag(proxy, param, heroine_flag_list, HEROINE_STATE_WANT_TO_SETTLE );
			proxy:SetAlwayEnableBackread_forEvent( 615 , true );
			--�q���C���̋����o�b�N���[�h�𖳌��� --EN:--Disable the heroine's forced back read
			--proxy:OnKeyTime2( 40,"OnEvent_40_1",0,0,3,once);
		end
--~ 	else
--~ 		if	proxy:IsCompleteEvent(HEROINE_STATE_DOOR_LEAVE) == true then
--~ 			SetNpcStateFlag(proxy, param, heroine_flag_list, HEROINE_STATE_WAIT_FOR_PLAYER );
--~ 			proxy:SetAlwayEnableBackread_forEvent( 615 , true );
--~ 			--�q���C���̋����o�b�N���[�h�𖳌��� --EN:--Disable the heroine's forced back read
--~ 			--proxy:OnKeyTime2( 40,"OnEvent_40_1",0,0,4,once);
--~ 		end
	end


	if proxy:IsCompleteEvent(HEROINE_STATE_WANT_TO_SETTLE) == true then
		--�\�� --EN:--reserve
		--�ʒu���킹 --EN:--Alignment
		proxy:Warp( 615 , 2205 );
	elseif proxy:IsCompleteEvent(HEROINE_STATE_WAIT_FOR_PLAYER) == true then		
		if proxy:IsCompleteEvent( 4096 ) == true then
			--�A�C�e�����炤��b�I����Ă��� --EN:--The conversation to receive the item is over
			if proxy:IsCompleteEvent( 304 ) == false then
				--�q���C�����W���킹 --EN:--Heroine Coordinate Alignment
				proxy:Warp( 615 , 2206 );
				proxy:SetSpStayAndDamageAnimId( 615 , -1 , -1 );
			else
				--�ʒu���킹 --EN:--Alignment
				Lua_SetHeroinPos(proxy,param);
			end
		else
			--�ʒu���킹 --EN:--Alignment
			Lua_SetHeroinPos(proxy,param);
		end
	elseif proxy:IsCompleteEvent(HEROINE_STATE_WITH_A_FUTURE) == true then
		proxy:Warp( 615, 2001 );
		proxy:ChangeThink( 615, 10 );
		proxy:ResetThink( 615 );
		proxy:ChangeInitPosAng( 615, 2001 );
		--�q���C���̃��W�b�N�؂�ւ� ���u�F��H�v --EN:--Switch heroine's logic �� "Pray?"
		proxy:SendEventRequest( 615 , 0 , AI_EVENT_GRACE);
		proxy:SetAlwayEnableBackread_forEvent( 615 , true );
		--�q���C���̋����o�b�N���[�h�𖳌��� --EN:--Disable the heroine's forced back read
		--proxy:OnKeyTime2( 40,"OnEvent_40_1",0,0,5,once);
	elseif proxy:IsCompleteEvent(HEROINE_STATE_DOOR_FRONT) == true then
		--�ʒu���킹 --EN:--Alignment
		--Lua_SetHeroinPos(proxy,param);
		--proxy:Warp( 615, 2003 );
		--proxy:ChangeInitPosAng( 615, 2003 );
	elseif proxy:IsCompleteEvent(HEROINE_STATE_PRAYER) == true then--�F�� --EN:--prayer
		--��153���F���ԏ������� --EN:-- �� 153 �� Prayer state initialization ��
		--�q���C�����ړ������� --EN:--Move the heroine
		LuaFunc_ForceOmission(proxy,615);
		proxy:Warp( 615 , 2002 );--�q���C��������̈ʒu�Ƀ��[�v --EN:-- Warp the heroine into place
		proxy:SetHp( 615 , 1.0 );--�q���C��HP�S�� --EN:--Heroine HP fully recovered
		proxy:EnableLogic( 615 , false );--���W�b�NOFF --EN:--Logic OFF
		
		proxy:SetEventCommand( 615 , 70 );--EzState�ɐ���ԍ�(�F��)�𑗂� --EN:--Send control number (pray) to EzState
		proxy:SetAlwayEnableBackread_forEvent( 615 , true );
		--�q���C���̋����o�b�N���[�h�𖳌��� --EN:--Disable the heroine's forced back read
		--proxy:OnKeyTime2( 40,"OnEvent_40_1",0,0,6,once);
	end
	
	
--���q���C���֘A��----------------------------- --EN:--��Related to the heroine��-----------------------------

--[[�����K�[���֘A��]]----------------------------- --EN:--[[��Logan Related��]]-----------------------------
	SetFirstNpcStateFlag( proxy , param , rogarn_flag_list , ROGARN_STATE_PRISONER );--��Ԃ�������Ύ��l�ɂ��� --EN:--If there is no state, make it a prisoner
	
	if	proxy:IsCompleteEvent( ROGARN_STATE_WAIT ) == true and
		IsLast == true then
		SetNpcStateFlag( proxy, param, rogarn_flag_list, ROGARN_STATE_LAST_WARD );
	end
	if	proxy:IsCompleteEvent( ROGARN_STATE_GO_M1 ) == true then
		SetNpcStateFlag( proxy, param, rogarn_flag_list, ROGARN_STATE_WAIT );
	end
	
	if	proxy:IsCompleteEvent( ROGARN_STATE_WAIT ) == true or--�҂��̎��@�� --EN:-- Is it time to wait?
		proxy:IsCompleteEvent( ROGARN_STATE_ANGRY_M1 ) == true or--�G�΂̎��@�� --EN:--A time of hostility?
		proxy:IsCompleteEvent( ROGARN_STATE_LAST_WARD ) == true then--�Ō�̌��t�̎��� --EN:--at the last word
		
		if	proxy:IsCompleteEvent( ROGARN_STATE_ANGRY_M1 ) == false then--�G�΂ł͂Ȃ��� --EN:--When not hostile
			--proxy:OnCharacterTotalDamage( 221, 617, 10000, 100, "OnEvent_221", once );--�_���[�W�Ď��ǉ� --EN:--Damage monitoring added
			proxy:OnCharacterTotalRateDamage( 221, 617, LOCAL_PLAYER, NPC_ANGRY_Rate, "OnEvent_221", once );
			
		end
		--��L�̏�Ԃ̎��ɁA���S�Ď��ǉ� --EN:--In the above state, add death watch
		proxy:OnCharacterDead( 222, 617, "OnEvent_222", once );
		
		proxy:SetEventFlag( 224, false );
	end

	if	proxy:IsCompleteEvent( ROGARN_STATE_WAIT ) 		== false and
		proxy:IsCompleteEvent( ROGARN_STATE_ANGRY_M1 )	== false and
		proxy:IsCompleteEvent( ROGARN_STATE_LAST_WARD ) == false then
		InvalidBackRead( proxy, 617 );
		proxy:SetEventFlag( 224, true );
	elseif proxy:IsCompleteEvent( ROGARN_STATE_ANGRY_M1 ) == true then
		proxy:EnableLogic(617,true);--���W�b�N�n�m --EN:--Logic ON
		proxy:SetTeamType(617, TEAM_TYPE_AngryFriend);--�`�[���^�C�v�ύX --EN:--Change team type
		--����ҋ@����		 --EN:--Cancel special standby
		--SetNpcStateFlag(proxy,param,rogarn_flag_list,ROGARN_STATE_ANGRY_M1);--�G�Ώ�Ԃ� --EN:-- in hostile state
	end
--�����K�[���֘A��----------------------------- --EN:--��Related to Logan��-----------------------------


--[[�����p�̓k�֘A��]]----------------------------- --EN:--[[��Sorcerer Related��]]-----------------------------

	SetFirstNpcStateFlag(proxy, param, magic_student_flag_list, MAGIC_STUDENT_STATE_ISNOT);--��Ԃ��ݒ肳��Ă��Ȃ���΁A�܂����Ȃ� --EN:-- if the state is not set, we are not there yet

	--�܂����Ȃ� --EN:--not yet
	if proxy:IsCompleteEvent( MAGIC_STUDENT_STATE_ISNOT ) == true then
		if boss_flagCount >= 1 then 
			SetNpcStateFlag( proxy, param ,magic_student_flag_list, MAGIC_STUDENT_STATE_ROGARN_HELP );--�����ď�Ԃ� --EN:-- help state
		else
			InvalidBackRead( proxy , 681 );
		end
	end
	
	if proxy:IsCompleteEvent( MAGIC_STUDENT_STATE_DEAD ) == false then--���S���Ă��Ȃ��@���� --EN:--not dead and
		if proxy:IsCompleteEvent( MAGIC_STUDENT_STATE_ANGRY ) == false then--�G�΂��Ă��Ȃ� --EN:--not hostile
		
			if proxy:IsCompleteEvent( MAGIC_STUDENT_STATE_ROGARN_TOGETHER ) == true --���K�[���ƈꏏ�Ȃ�� --EN:--If you're with Logan
			and	proxy:IsCompleteEvent( ROGARN_STATE_ANGRY_M1 ) == true then--���K�[�����G�΂Ȃ�� --EN:--If Logan is hostile
				SetNpcStateFlag( proxy, param, magic_student_flag_list, MAGIC_STUDENT_STATE_ANGRY );--�G�Ώ�Ԃ� --EN:-- in hostile state
			end
			
			--��312�����K�[�����Β��֗������ԕύX��-- --EN:-- �� 312 �� State change when Logan comes to the stone pillar �� --
			if proxy:IsCompleteEvent( ROGARN_STATE_GO_M1 ) == true --���K�[�����Β��֗������@�� --EN:--Does Logan want to come to the stone pillar?
			or proxy:IsCompleteEvent( ROGARN_STATE_WAIT ) == true then--���K�[�����Β��ɂ���Ȃ�� --EN:--If Logan is at the stone pillar
				SetNpcStateFlag( proxy, param, magic_student_flag_list, MAGIC_STUDENT_STATE_ROGARN_TOGETHER );--���K�[���ƈꏏ�� --EN:--with Logan
			end			
			
			--proxy:OnCharacterTotalDamage( 310, 681, 10000, 100, "OnEvent_310", once );--�_���[�W�Ď��ǉ� --EN:--Damage monitoring added
			proxy:OnCharacterTotalRateDamage( 310, 681, LOCAL_PLAYER, NPC_ANGRY_Rate, "OnEvent_310", once );
			
		end
		proxy:OnCharacterDead( 311, 681, "OnEvent_311", once );
	end

	if 	proxy:IsCompleteEvent( MAGIC_STUDENT_STATE_ROGARN_HELP 		) == true or 
		proxy:IsCompleteEvent( MAGIC_STUDENT_STATE_ROGARN_TOGETHER 	) == true or
		proxy:IsCompleteEvent( MAGIC_STUDENT_STATE_FALL 			) == true or
		proxy:IsCompleteEvent( MAGIC_STUDENT_STATE_ANGRY 			) == true then
			proxy:SetEventFlag( 313, false );
			
	elseif proxy:IsCompleteEvent( MAGIC_STUDENT_STATE_ROGARN_HELP 		) == false and
		   proxy:IsCompleteEvent( MAGIC_STUDENT_STATE_ROGARN_TOGETHER 	) == false and
		   proxy:IsCompleteEvent( MAGIC_STUDENT_STATE_FALL 			) == false and
		   proxy:IsCompleteEvent( MAGIC_STUDENT_STATE_ANGRY 			) == false then
			InvalidBackRead( proxy, 681 );
			proxy:SetEventFlag( 313, true );
	end
	
	if proxy:IsCompleteEvent( MAGIC_STUDENT_STATE_ANGRY ) == true then
		proxy:EnableLogic(681,true);--���W�b�N�n�m --EN:--Logic ON
		proxy:SetTeamType(681, TEAM_TYPE_AngryFriend);--�`�[���^�C�v�ύX --EN:--Change team type
		--����ҋ@����		 --EN:--Cancel special standby
		--SetNpcStateFlag( proxy, param, magic_student_flag_list, MAGIC_STUDENT_STATE_ANGRY );--�G�Ώ�Ԃ� --EN:-- in hostile state
	end
--�����p�̓k�֘A��----------------------------- --EN:--��Magic related ��-----------------------------


--[[�������h�����q�֘A��]]----------------------------- --EN:--[[��Related to Prince Lendl��]]-----------------------------
	SetFirstNpcStateFlag(proxy, param, rendol_flag_list, RENDOL_STATE_HELP_FOR_DOREI_HEISI);--�����h�����q�̏�Ԃ����������� --EN:--Initialize Prince Lendl's state
	proxy:SetTeamTypePlus(688, TEAM_TYPE_Friend,false);--�`�[���^�C�v�ύX	 --EN:--Change team type
	local now_rendol_state = GetRendolState(proxy,param);
	
	if	now_rendol_state == RENDOL_STATE_SEARCH_1 or				--����P��T���@�� --EN:-- Exploring Royal Castle 1?
		now_rendol_state == RENDOL_STATE_SEARCH_2 or				--����Q��T���@�� --EN:-- Exploring Royal Castle 2?
		now_rendol_state == RENDOL_STATE_SEARCH_3 or				--����R��T���@�� --EN:-- Exploring Royal Castle 3 huh?
		now_rendol_state == RENDOL_STATE_LOCATION_INVISIBLE or		--�����Ȃ��ꏊ�ɂ���@�� --EN:--Are you in an invisible place?
		now_rendol_state == RENDOL_STATE_HOSTILE_STONE_PILLAR then	--�Β��œG�΂Ȃ�� --EN:--If you are hostile with a stone pillar
		
		if	proxy:IsCompleteEvent( RENDOL_STATE_HOSTILE_STONE_PILLAR ) == false then--�G�΂ł͂Ȃ� --EN:--not hostile
			--proxy:OnCharacterTotalDamage( 230, 688, 10000, 100, "OnEvent_230", once );--�_���[�W�Ď��ǉ� --EN:--Damage monitoring added
			proxy:OnCharacterTotalRateDamage( 230, 688, LOCAL_PLAYER, NPC_ANGRY_Rate, "OnEvent_230", once );
		end
		--��L�����̎��ɁA���S�Ď��ǉ� --EN:--When the above conditions are met, death monitoring is added.
		proxy:OnCharacterDead( 231, 688, "OnEvent_231", once );
		proxy:SetEventFlag( 232, false );
	end
	
	local now_rendol_state = GetRendolState(proxy,param);
	
	if	now_rendol_state ~= RENDOL_STATE_SEARCH_1 and
		now_rendol_state ~= RENDOL_STATE_SEARCH_2 and
		now_rendol_state ~= RENDOL_STATE_SEARCH_3 and
		now_rendol_state ~= RENDOL_STATE_LOCATION_INVISIBLE and
		now_rendol_state ~= RENDOL_STATE_HOSTILE_STONE_PILLAR then
		InvalidBackRead( proxy, 688 );
		proxy:SetEventFlag( 232, true );
	elseif now_rendol_state == RENDOL_STATE_HOSTILE_STONE_PILLAR then
		proxy:EnableLogic(688,true);--���W�b�N�n�m --EN:--Logic ON
		proxy:SetTeamType(688, TEAM_TYPE_AngryFriend);--�`�[���^�C�v�ύX	TEAM_TYPE_Friend --EN:--Team type change TEAM_TYPE_Friend
		proxy:EraseEventSpecialEffect_2(688,5063);		
		--SetNpcStateFlag(proxy,param,possible_transration_list_m02_03_00_00,RENDOL_STATE_HOSTILE_STONE_PILLAR);--�G�Ώ�Ԃ� --EN:-- in hostile state
	end
--�������h�����q�֘A��----------------------------- --EN:--��Prince Lendl related��-----------------------------

--[[���r�������O�����֘A��]]----------------------------- --EN:--[[��Bjrn Grum Related��]]-----------------------------
	SetFirstNpcStateFlag( proxy , param , biyo_flag_list , BIYO_STATE_CAPTIVE );--��Ԃ��ݒ肳��ĂȂ���΁A����R��T���� --EN:--If the state is not set, search the castle 3
	proxy:SetTeamTypePlus(695, TEAM_TYPE_Friend,false);--�`�[���^�C�v�ύX	 --EN:--Change team type
	--���̌���|���Ă��� --EN:--Killing the King's Sword
	if	proxy:IsCompleteEvent(BIYO_STATE_KING_OF_SWORD_KILL) == true then 
		--�򗳂̒�������ł����ꍇ�͂������Ȃ���Ԃ� --EN:--If the wyvern chief is dead, it will no longer exist.
		if proxy:IsCompleteEvent(TYO_STATE_DEAD) == true then 
			SetNpcStateFlag(proxy,param, biyo_flag_list, BIYO_STATE_EXIT );
			
		--�򗳂̒�������ł��Ȃ��ꍇ�͒��Ɛ���Ă����ԂɑJ�� --EN:--If the chief of the flying dragon is not dead, transition to the state of fighting with the chief
		elseif proxy:IsCompleteEvent(TYO_STATE_DEAD) == false then
			SetNpcStateFlag(proxy,param, biyo_flag_list, BIYO_STATE_BATTLE_FLY_DRAGON );
		end
	end
	
	if	proxy:IsCompleteEvent(BIYO_STATE_SEARCH_3) == true or					--�Β��őҋ@�@�� --EN:--Wait at the stone pillar?
		proxy:IsCompleteEvent(BIYO_STATE_BATTLE_FLY_DRAGON) == true or			--�򗳂̒��Ɛ���Ă���@�� --EN:--Are you fighting the wyvern chief?
		proxy:IsCompleteEvent(BIYO_STATE_HOSTILE_IN_STONE_PILLAR ) == true then	--�Β��œG�΂Ȃ�� --EN:--If you are hostile with a stone pillar
		
		if	proxy:IsCompleteEvent( BIYO_STATE_HOSTILE_IN_STONE_PILLAR ) == false then--�G�΂ł͂Ȃ� --EN:--not hostile
			--proxy:OnCharacterTotalDamage( 240, 695, 10000, 100, "OnEvent_240", once );--�_���[�W�Ď��ǉ� --EN:--Damage monitoring added
			proxy:OnCharacterTotalRateDamage( 240, 695, LOCAL_PLAYER, NPC_ANGRY_Rate, "OnEvent_240", once );
		end
		proxy:OnCharacterDead( 241, 695, "OnEvent_241", once );
		proxy:SetEventFlag( 244, false );
	end
	
	print("test1");
	if	proxy:IsCompleteEvent(BIYO_STATE_SEARCH_3) == false and
		proxy:IsCompleteEvent(BIYO_STATE_BATTLE_FLY_DRAGON) == false and
		proxy:IsCompleteEvent(BIYO_STATE_HOSTILE_IN_STONE_PILLAR ) == false then
		print("test2");
		InvalidBackRead( proxy, 695 );
		proxy:SetEventFlag( 244, true );
	elseif proxy:IsCompleteEvent( BIYO_STATE_HOSTILE_IN_STONE_PILLAR ) == true then
		proxy:EnableLogic(695,true);--���W�b�N�n�m --EN:--Logic ON
		proxy:SetTeamType(695, TEAM_TYPE_AngryFriend);--�`�[���^�C�v�ύX --EN:--Change team type
		proxy:EraseEventSpecialEffect_2(695,5064);
		--SetNpcStateFlag(proxy,param,biyo_flag_list,BIYO_STATE_HOSTILE_IN_STONE_PILLAR);--�G�Ώ�Ԃ� --EN:-- in hostile state
		print("test3");
	end
--���r�������O�����֘A��----------------------------- --EN:--�� Bjrn Grum Related ��-----------------------------


--[[�������֘A��]]----------------------------- --EN:--[[��Witch related��]]-----------------------------

	SetFirstNpcStateFlag(proxy, param, majo_flag_list, MAJO_STATE_LIBERATE);--��Ԃ��ݒ肳��Ă��Ȃ���΁A�J�����Ăق����� --EN:--If the state is not set, I want it to be freed
	
	--�x�e���@�� --EN:--Are you taking a break?
	if proxy:IsCompleteEvent( MAJO_STATE_BREAK ) == true then
		SetNpcStateFlag(proxy, param, majo_flag_list, MAJO_STATE_WAIT_M1);
	end
	
	if	proxy:IsCompleteEvent( MAJO_STATE_WAIT_M1 )		== true or		--�Β��őҋ@�@��		 --EN:--Wait at the stone pillar?
		proxy:IsCompleteEvent( MAJO_STATE_ANGRY_M1 )	== true then	--�Β��œG�΂Ȃ��		 --EN:--If you are hostile with a stone pillar
		if	proxy:IsCompleteEvent( MAJO_STATE_ANGRY_M1 ) == false then	--�G�΂ł͂Ȃ� --EN:--not hostile
			--proxy:OnCharacterTotalDamage( 260, 689, 10000, 100, "OnEvent_260", once );--�_���[�W�Ď��ǉ� --EN:--Damage monitoring added
			proxy:OnCharacterTotalRateDamage( 260, 689, LOCAL_PLAYER, NPC_ANGRY_Rate, "OnEvent_260", once );			
		end
		--��L�̏�Ԃ̎��ɁA���S�Ď��ǉ� --EN:--In the above state, add death watch
		proxy:OnCharacterDead( 261, 689, "OnEvent_261", once );
		proxy:SetEventFlag( 263, false );
	end
	
	
	if	proxy:IsCompleteEvent( MAJO_STATE_WAIT_M1 )		== false and
		proxy:IsCompleteEvent( MAJO_STATE_ANGRY_M1 )	== false then
		InvalidBackRead( proxy, 689 );
		proxy:SetEventFlag( 263, true );
	elseif proxy:IsCompleteEvent( MAJO_STATE_ANGRY_M1 )	== true then
		proxy:EnableLogic(689,true);--���W�b�N�n�m --EN:--Logic ON
		proxy:SetTeamType(689, TEAM_TYPE_AngryFriend);--�`�[���^�C�v�ύX		 --EN:--Change team type
		--SetNpcStateFlag( proxy, param, majo_flag_list, MAJO_STATE_ANGRY_M1 );--�G�Ώ�Ԃ�	 --EN:-- in hostile state
	end
--�������֘A��----------------------------- --EN:--��Witch related��-----------------------------


--[[���E���x�C���֘A��]]----------------------------- --EN:--[[��Ulbane Related��]]-----------------------------
	SetFirstNpcStateFlag(proxy, param, urubain_flag_list, URUBAIN_STATE_HELP);--��Ԃ��ݒ肳��Ă��Ȃ���΁A�����Ăق����� --EN:-- if the state is not set, please help

	if	proxy:IsCompleteEvent( URUBAIN_STATE_THANKS ) == true then--���ӂ��Ă���Ȃ�� --EN:--if you appreciate
		SetNpcStateFlag( proxy, param, urubain_flag_list, URUBAIN_STATE_STONE_PILLAR );--�Β��ɂ���� --EN:--to be on the pillar
	end
	
	if	proxy:IsCompleteEvent( URUBAIN_STATE_STONE_PILLAR ) == true or			--�Β��ɂ���@�� --EN:--Are you at the stone pillar?
		proxy:IsCompleteEvent( URUBAIN_STATE_STONE_PILLAR_ANGRY ) == true then	--�Β��œG�΂Ȃ�� --EN:--If you are hostile with a stone pillar
		
		if proxy:IsCompleteEvent( URUBAIN_STATE_STONE_PILLAR_ANGRY ) == false then--�G�΂ł͂Ȃ� --EN:--not hostile
			--proxy:OnCharacterTotalDamage( 270, 690, 10000, TOTALDAMAGE_URUBAIN, "OnEvent_270", once );--�_���[�W�Ď��ǉ� --EN:--Damage monitoring added
			proxy:OnCharacterTotalRateDamage( 270, 690, LOCAL_PLAYER, NPC_ANGRY_Rate, "OnEvent_270", once );
			
		end
		--��L�̏�Ԃ̎��ɁA���S�Ď��ǉ� --EN:--In the above state, add death watch
		proxy:OnCharacterDead( 271, 690, "OnEvent_271", once );
		proxy:SetEventFlag( 273, false );
	end
	
	if	proxy:IsCompleteEvent( URUBAIN_STATE_STONE_PILLAR ) 		== false and
		proxy:IsCompleteEvent( URUBAIN_STATE_STONE_PILLAR_ANGRY ) 	== false then
		InvalidBackRead( proxy , 690 );--�E���l������ --EN:--Disable Uru-sama
		proxy:SetEventFlag( 273, true );
		
	elseif proxy:IsCompleteEvent( URUBAIN_STATE_STONE_PILLAR_ANGRY ) == true then
		proxy:EnableLogic(690,true);--���W�b�N�n�m --EN:--Logic ON
		proxy:SetTeamType(690, TEAM_TYPE_AngryFriend);--�`�[���^�C�v�ύX		 --EN:--Change team type
		--SetNpcStateFlag( proxy, param, urubain_flag_list, URUBAIN_STATE_STONE_PILLAR_ANGRY );--�G�Ώ�Ԃ� --EN:-- in hostile state
	end
--���E���x�C���֘A��----------------------------- --EN:--��Ulbane related ��-----------------------------


--[[�������g�֘A��]]----------------------------- --EN:--[[��Yurt-related��]]-----------------------------
	SetFirstNpcStateFlag(proxy, param, yuruto_flag_list, YURUTO_STATE_LIFT);--��Ԃ��ݒ肳��ĂȂ�������A�G���x�[�^�[�ő҂ɂ��� --EN:--If the state is not set, wait in the elevator

	--�Β��ɍs���O��ԂȂ� --EN:--If it's before going to the stone pillar
	if proxy:IsCompleteEvent( YURUTO_STANDBY_M1 ) == true then
		--�L���{�X���j����茻�݂̌��j���̕������� --EN:--The current number of defeats is higher than the number of memory bosses defeated
		if proxy:GetBossCount() < boss_flagCount then
			SetNpcStateFlag( proxy, param, yuruto_flag_list, YURUTO_STATE_WAIT_M1 );
			--�Ăу{�X�J�E���g���L�� --EN:-- memorize boss count again
			proxy:SetBossCount( boss_flagCount );
		end
	end

--��280�������g�G�΁��i��b�V�X�e������Ăяo���j --EN:-- �� 280 �� Yurt hostility �� (call from the conversation system)
	--��b����Ă΂��n���h�� --EN:--handler called from conversation
	proxy:LuaCall( 280, 0, "OnEvent_280", everytime );
	
--��15630�������g�̎��̂𒲂ׂ��� --EN:--�� 15630 �� Examine Yurt's corpse ��
	if proxy:IsCompleteEvent( 15630 ) == false then
		proxy:AddCorpseEvent( 15630 , 619 );
		proxy:NotNetMessage_begin();
			proxy:LuaCall( 15630 ,0 , "OnEvent_15630",once );
 		proxy:NotNetMessage_end();
	end	
	
	if	proxy:IsCompleteEvent( YURUTO_STATE_ANGRY_M1 ) == true or	--�Β��œG�΁@�� --EN:-- Hostile with a stone pillar?
		proxy:IsCompleteEvent( YURUTO_STATE_WAIT_M1  ) == true then	--�Β��ő҂Ȃ�� --EN:--If you wait at the stone pillar
		
		--[[
		if proxy:IsCompleteEvent( 500 ) == false then
			proxy:SetEventFlag( 500 , true );
			proxy:SetBossCount( boss_flagCount );
		end
		]]
		--��L�̏�Ԃ̎��ɁA���S�Ď��ǉ� --EN:--In the above state, add death watch
		proxy:OnCharacterDead( 281, 619, "OnEvent_281", once );
		proxy:SetEventFlag( 282, false );
	end

	if	proxy:IsCompleteEvent( YURUTO_STATE_ANGRY_M1 ) == false and		--�G�΂ł͂Ȃ��@���� --EN:-- not hostile and
		proxy:IsCompleteEvent( YURUTO_STATE_WAIT_M1  ) == false then	--�Β��ő҂Ȃ�� --EN:--If you wait at the stone pillar
		if 	proxy:IsCompleteEvent( 281 ) == true and	--����ł��� --EN:--dead
			proxy:IsCompleteEvent( 15630 ) == false then	--���̂𒲂ׂĂȂ� --EN:--Didn't examine the corpse
			--���̂��Č����� --EN:--reproduce the corpse
			proxy:OpeningDeadPlus( 619 , true ,false ,false );
		else
			InvalidBackRead( proxy, 619 );
		end
		proxy:SetEventFlag( 282, true );
	elseif	proxy:IsCompleteEvent( YURUTO_STATE_ANGRY_M1 ) == true then--�G�΂Ȃ�� --EN:--if hostile
		proxy:EnableLogic(619,true);--���W�b�N�n�m --EN:--Logic ON
		proxy:SetTeamType(619, TEAM_TYPE_AngryFriend);--�`�[���^�C�v�ύX		 --EN:--Change team type
		--SetNpcStateFlag( proxy, param, yuruto_flag_list, YURUTO_STATE_ANGRY_M1 );--�G�Ώ�Ԃ� --EN:-- in hostile state
	end
--�������g�֘A��----------------------------- --EN:--�� Yurt Related ��-----------------------------

--[[���o�b�`�֘A��]]----------------------------- --EN:--[[��Batch Related��]]-----------------------------
	SetFirstNpcStateFlag(proxy, param, batti_flag_list, BATTI_NOT_STAY);--��Ԃ��ݒ肳��Ă��Ȃ���΁A�ǂ��ɂ����Ȃ��� --EN:-- if state is not set, nowhere
	
	if	proxy:IsCompleteEvent(BATTI_SATISFIED) 		== true or		--�ÍԂ̖����@�� --EN:--Satisfaction of the old fort?
		proxy:IsCompleteEvent(BATTI_PRESENT) 		== true or		--�B���̕�͂������@�� --EN:--Did you give the mine treasure?
		proxy:IsCompleteEvent(BATTI_VEXING_M6) 		== true or		--�B���̎c�O�@�� --EN:--Is it a pity about the tunnel?
		proxy:IsCompleteEvent(BATTI_DESTORYKUMA)	== true then	--�B���ŃN�}���V�|�����Ȃ�� --EN:--If you kill a tardigrade in a tunnel
		SetNpcStateFlag( proxy, param, batti_flag_list, BATTI_RESERVE_M1 );--�Β��ő҂� --EN:--Waiting at the stone pillar
	end
	
	if	proxy:IsCompleteEvent( BATTI_RESERVE_M1 ) == true or	--�Β��ő҂@�� --EN:--Would you like to wait at the stone pillar?
		proxy:IsCompleteEvent( BATTI_ANGRY_M1 ) == true then	--�Β��œG�΂Ȃ�� --EN:--If hostile with a stone pillar
		
		if	proxy:IsCompleteEvent( BATTI_ANGRY_M1 ) == false then--�G�΂ł͂Ȃ� --EN:--not hostile
			--proxy:OnCharacterTotalDamage( 290, 693, 10000, TOTALDAMAGE_BATTI, "OnEvent_290", once );--�_���[�W�Ď��ǉ� --EN:--Damage monitoring added
			proxy:OnCharacterTotalRateDamage( 290, 693, LOCAL_PLAYER, NPC_ANGRY_Rate, "OnEvent_290", once );
			
		end
		--��L�̏�Ԃ̎��ɁA���S�Ď��ǉ� --EN:--In the above state, add death watch
		proxy:OnCharacterDead( 291, 693, "OnEvent_291", once );
		proxy:SetEventFlag( 293, false );
	end
	
	if	proxy:IsCompleteEvent( BATTI_RESERVE_M1 )	== false and
		proxy:IsCompleteEvent( BATTI_ANGRY_M1  ) 	== false then
		InvalidBackRead( proxy, 693 );
		proxy:SetEventFlag( 293, true );
	elseif proxy:IsCompleteEvent( BATTI_ANGRY_M1  )	== true then
		proxy:EnableLogic(693,true);--���W�b�N�n�m --EN:--Logic ON
		proxy:SetTeamType(693, TEAM_TYPE_AngryFriend);--�`�[���^�C�v�ύX		 --EN:--Change team type
		--SetNpcStateFlag( proxy, param, batti_flag_list, BATTI_ANGRY_M1 );--�G�Ώ�Ԃ� --EN:-- in hostile state
	end
--���o�b�`�֘A��----------------------------- --EN:--�� Batch Related ��-----------------------------


--[[���v�l�֘A��]]----------------------------- --EN:--[[��Victim related��]]-----------------------------
	--������Ԃ�ݒ� --EN:--set initial state
	SetFirstNpcStateFlag(proxy, param, yojin_flag_list, YOJIN_STATE_WAIT_FOR_PLAYER);

	--Init�ɋL�� --EN:-- Described in Init
	--proxy:LuaCall( 303,0,"OnEvent_303",once);--�|�����Đ��p�̉�b�Ăяo���n���h�� --EN:--Conversation call handler for polyplay play
	--�v�l�������Ă��� --EN:-- VIP alive
	proxy:SetDeadMode( 613, true );--�m�[�_���[�W --EN:--no damage
	proxy:DisableHpGauge( 613 , true );--�Q�[�W�\������ --EN:--No gauge display
	if proxy:IsCompleteEvent(YOJIN_STATE_DEAD ) == false then
		--��b����Ă΂��n���h�� --EN:--handler called from conversation
		
		--��300���v�l���S�� --EN:-- �� 300 �� key deaths ��
		if proxy:IsCompleteEvent( 300 ) == false then
			proxy:OnCharacterDead( 300 , 613 , "OnEvent_300" , once );
		end
		
		--�v�l���Ō�̌��t��`���悤�ɂȂ� --EN:--Victims will give the last words
		if	IsLast == true then--���ׂẴX�e�[�W���I������� --EN:--After completing all stages
			if	proxy:IsCompleteEvent( YOJIN_STATE_WAIT_FOR_PLAYER ) 	== true then--��l����҂Ȃ�� --EN:--If you wait for the hero
				SetNpcStateFlag(proxy, param, yojin_flag_list, YOJIN_STATE_LASTWORD );
			end
		end
	end

	--�v�l�������ĂȂ� --EN:-- VIPs are not alive
	if proxy:IsCompleteEvent(YOJIN_STATE_DEAD ) == true then
		InvalidBackRead( proxy , 613 );--�v�l������ --EN:--Invalidation of dignitaries
	end
--���v�l�֘A��----------------------------- --EN:--�� Important person related ��-----------------------------

--[[���_�̐M�k1�֘A��]]----------------------------- --EN:--[[��Related to God's Follower 1��]]-----------------------------
	SetFirstNpcStateFlag(proxy, param, god_beliver1_flag_list, GOD_BELIEVER_1_STATE_ISNOT);--��Ԃ��ݒ肳��Ă��Ȃ�������A�܂����Ȃ� --EN:-- if the state wasn't set, you're not there yet
	
	if proxy:IsCompleteEvent( GOD_BELIEVER_1_STATE_ISNOT ) == true then
		if boss_flagCount >= 1 then
			SetNpcStateFlag( proxy, param, god_beliver1_flag_list, GOD_BELIEVER_1_STATE_STONE_PILLAR );
		else
			InvalidBackRead( proxy ,682 );
		end
	end
	
--------��ԏ���������----------- --EN:--State initialization processing-----------
	--��322�����K�[�����ÍԂ���߂��Ă������ɁA�u�E���l�ƈꏏ�v�ɂ��遡 --EN:-- �� 322 �� When Logan returns from the old fort, make it "together with Uru-sama" ��
	if	proxy:IsCompleteEvent( GOD_BELIEVER_1_STATE_STONE_PILLAR ) == true and	--�Β��ɋ��� ���� --EN:--Staying at the stone pillar and
		proxy:IsCompleteEvent( URUBAIN_STATE_STONE_PILLAR ) == true or			--�E���l�Β��ɋ��� �� --EN:--Are you in the Uru-sama stone pillar?
		proxy:IsCompleteEvent( URUBAIN_STATE_THANKS ) == true then				--�E���l�����ӂ��Ă��� �Ȃ�� --EN:--If Uru-sama is grateful
		
		SetNpcStateFlag( proxy, param, god_beliver1_flag_list, GOD_BELIEVER_1_STATE_URU );--�E���l�ƈꏏ�� --EN:--With Ur-sama
	end
	
	if proxy:IsCompleteEvent( URUBAIN_STATE_STONE_PILLAR_ANGRY ) == true and	--�E���l���G�΁@���� --EN:--Ur-sama is hostile and
	   proxy:IsCompleteEvent( GOD_BELIEVER_1_STATE_ANGRY ) == false then	--�G�΂��Ă��Ȃ��Ȃ�� --EN:--if not hostile
		if proxy:IsCompleteEvent( GOD_BELIEVER_1_STATE_DEAD ) == false then
			SetNpcStateFlag( proxy, param, god_beliver1_flag_list, GOD_BELIEVER_1_STATE_ANGRY );--�G�Ώ�Ԃ� --EN:-- in hostile state
		end
	end
	
	if proxy:IsCompleteEvent( GOD_BELIEVER_1_STATE_DEAD ) == true then
		--��323���M�k�P���S������ --EN:-- �� 323 �� Follower 1 death process ��
		InvalidBackRead( proxy, 682 );
		--proxy:SetEventFlag( 323, true );
	elseif proxy:IsCompleteEvent( GOD_BELIEVER_1_STATE_ANGRY ) == true then
		--��324���M�k�P�G�Ώ����� --EN:-- �� 324 �� Follower 1 hostile processing ��
		proxy:EnableLogic(682,true);--���W�b�N�n�m --EN:--Logic ON
		proxy:SetTeamType(682, TEAM_TYPE_AngryFriend);--�`�[���^�C�v�ύX		 --EN:--Change team type
		--SetNpcStateFlag( proxy, param, god_beliver1_flag_list, GOD_BELIEVER_1_STATE_ANGRY );--�G�Ώ�Ԃ� --EN:-- in hostile state
	end
--------�e�Ď��ǉ�-----------	 --EN:--Add each monitor-----------
	--�E���l�G�Ύ��ɌĂ΂��n���h���o�^ --EN:--Registering a handler to be called when Uru-sama is hostile
	proxy:LuaCall(320, 1, "OnEvent_320", once);
	
	if proxy:IsCompleteEvent(GOD_BELIEVER_1_STATE_DEAD ) == false then--���S���Ă��Ȃ��Ȃ�� --EN:--if not dead
		if proxy:IsCompleteEvent( GOD_BELIEVER_1_STATE_ANGRY ) == false then--�G�΂��Ă��Ȃ� --EN:--not hostile
			--��320���M�k�P�G�ΊĎ��� --EN:-- �� 320 �� Follower 1 hostile surveillance ��
			proxy:OnCharacterTotalRateDamage( 320, 682, LOCAL_PLAYER, NPC_ANGRY_Rate, "OnEvent_320", once );--�G�ΊĎ��ǉ� --EN:--Added hostile monitoring
			
		end
		--��321���M�k�P���S�Ď��� --EN:-- �� 321 �� follower 1 death watch ��
		proxy:OnCharacterDead( 321, 682, "OnEvent_321", once );--��L�̏�Ԃ��������ɁA���S�Ď��ǉ� --EN:--Added death watch when the above conditions were met
	end
--���_�̐M�k1�֘A��----------------------------- --EN:--��Related to God's Follower 1��-----------------------------


--[[���_�̐M�k2�֘A��]]----------------------------- --EN:--[[��Related to God's Followers 2��]]-----------------------------
	SetFirstNpcStateFlag(proxy, param, god_beliver2_flag_list, GOD_BELIEVER_2_STATE_ISNOT);--��Ԃ��ݒ肳��Ă��Ȃ�������A�܂����Ȃ� --EN:-- if the state wasn't set, you're not there yet
	
	if proxy:IsCompleteEvent( GOD_BELIEVER_2_STATE_ISNOT ) == true then
		if boss_flagCount >= 1 then
			proxy:SetEventFlag( 333, false );
			SetNpcStateFlag( proxy, param, god_beliver2_flag_list, GOD_BELIEVER_2_STATE_STONE_PILLAR );
		else
			proxy:SetEventFlag( 333, true );
			InvalidBackRead( proxy ,683 );
		end
	end
--��335���E���l��T���ɍs���A�s���s���� --EN:-- �� 335 �� went to look for Uru-sama, missing ��
	if proxy:IsCompleteEvent( GOD_BELIEVER_2_STATE_STONE_PILLAR ) == true	--�Β��ɋ���@���� --EN:--At the stone pillar and
	and proxy:IsCompleteEvent( 9164 ) == true	--��b�u�E���l�������ɍs������v�i9164�j�𕷂��Ă���@���� --EN:--Listening to the conversation "I'm going to help Uru-sama" (9164) and
	and proxy:IsCompleteEvent( 4756 ) == true then --�ÍԂP���N���A���Ă���@�Ȃ�� --EN:--If you have cleared Old Fort 1
		proxy:SetEventFlag( 335, true );
		SetNpcStateFlag( proxy, param, god_beliver2_flag_list, GOD_BELIEVER_2_STATE_ISNOTALREADY );--���łɋ��Ȃ��� --EN:--I'm not here anymore
		
	elseif proxy:IsCompleteEvent( URUBAIN_STATE_STONE_PILLAR ) == true then	--�E���l���Β��ɂ����� --EN:--If Uru-sama was at the stone pillar
		proxy:SetEventFlag( 335, true );
		SetNpcStateFlag( proxy, param, god_beliver2_flag_list, GOD_BELIEVER_2_STATE_ISNOTALREADY );--���łɋ��Ȃ��� --EN:--I'm not here anymore
	end
	--[[�����A���łɋ��Ȃ��t���O�́A�����Ȃ��B�i�������邩������Ȃ��̂ŁA�c���Ă����j]] --EN:--[[Actually, flags that are not already there will not be set. (Leave it alone in case it comes back)]]
	if proxy:IsCompleteEvent( GOD_BELIEVER_2_STATE_ISNOTALREADY ) == true then
		print("�E���l��T���ɍs���āc�s���s��"); --EN:print("I'm going to look for Uru-sama...I'm missing");
		SetNpcStateFlag( proxy, param, god_beliver2_flag_list, GOD_BELIEVER_2_STATE_DEAD );--�T���ɍs���ċA��ʐl�ɁE�E�E --EN:--For those who go looking for them and never return...
	end
	
--------��ԏ���������-----------	 --EN:--State initialization processing-----------
	if proxy:IsCompleteEvent( GOD_BELIEVER_2_STATE_DEAD ) == true 				--���S�@�� --EN:-- Death
	or proxy:IsCompleteEvent( GOD_BELIEVER_2_STATE_ISNOTALREADY ) == true then	--���łɋ��Ȃ��Ȃ�� --EN:--If you are not already there
		--��333���M�k�Q���S������ --EN:-- �� 333 �� Follower 2 death processing ��
		InvalidBackRead( proxy, 683 );
		proxy:SetEventFlag( 333, true );
	elseif proxy:IsCompleteEvent( GOD_BELIEVER_2_STATE_ANGRY ) == true then
		--��334���M�k�Q�G�Ώ����� --EN:-- �� 334 �� Follower 2 hostile processing ��
		proxy:EnableLogic(683,true);--���W�b�N�n�m --EN:--Logic ON
		proxy:SetTeamType(683, TEAM_TYPE_AngryFriend);--�`�[���^�C�v�ύX		 --EN:--Change team type
		--SetNpcStateFlag( proxy, param, god_beliver2_flag_list, GOD_BELIEVER_2_STATE_ANGRY );--�G�Ώ�Ԃ� --EN:-- in hostile state
	end

	if proxy:IsCompleteEvent( URUBAIN_STATE_STONE_PILLAR_ANGRY ) == true and	--�E���l���G�� ���� --EN:--Ur-sama is hostile and
	   proxy:IsCompleteEvent( GOD_BELIEVER_2_STATE_ANGRY ) == false then	--�G�΂��Ă��Ȃ��Ȃ�� --EN:--if not hostile
	   --����ł��Ȃ����H --EN:--Aren't you dead?
		if proxy:IsCompleteEvent(GOD_BELIEVER_2_STATE_DEAD) == false then
			SetNpcStateFlag( proxy, param, god_beliver2_flag_list, GOD_BELIEVER_2_STATE_ANGRY );--�G�Ώ�Ԃ� --EN:-- in hostile state
		end
	end
	
	--���I�폜�I���E���x�C�����ÍԂ���߂��Ă������ɁA�u�E���l�ƈꏏ�v�ɂ��遡 --EN:--��! delete! ��When Urbain comes back from the old fort, make it "together with Uru-sama"��
--------�e�Ď��ǉ�----------- --EN:--Add each monitor-----------
	--�E���l�G�Ύ��ɌĂ΂��n���h���o�^ --EN:--Registering a handler to be called when Uru-sama is hostile
	proxy:LuaCall(330, 1, "OnEvent_330", once);

	if proxy:IsCompleteEvent(GOD_BELIEVER_2_STATE_DEAD ) == false then--���S���Ă��Ȃ��Ȃ�� --EN:--if not dead
		if proxy:IsCompleteEvent( GOD_BELIEVER_2_STATE_ANGRY ) == false then--�G�΂��Ă��Ȃ� --EN:--not hostile
			--��330���M�k�Q�G�ΊĎ��� --EN:-- �� 330 �� Follower 2 Hostile Monitoring ��
			proxy:OnCharacterTotalRateDamage( 330, 683, LOCAL_PLAYER, NPC_ANGRY_Rate, "OnEvent_330", once );--�G�ΊĎ��ǉ� --EN:--Added hostile monitoring
			
		end
		--��331���M�k�Q���S�Ď��� --EN:-- �� 331 �� follower 2 death watch ��
		proxy:OnCharacterDead( 331, 683, "OnEvent_331", once );--��L�̏�Ԃ��������ɁA���S�Ď��ǉ� --EN:--Added death watch when the above conditions were met
	end
--���_�̐M�k2�֘A��----------------------------- --EN:--��Related to God's Followers 2��-----------------------------

--[[���_�̐M�k3�֘A��]]----------------------------- --EN:--[[��Related to God's Followers 3��]]-----------------------------
	SetFirstNpcStateFlag(proxy, param, god_beliver3_flag_list, GOD_BELIEVER_3_STATE_STONE_PILLAR);--��Ԃ��ݒ肳��Ă��Ȃ�������A�Β��ɂ���� --EN:--if the state was not set,
--------��ԏ���������----------- --EN:--State initialization processing-----------
	--��432�����K�[�����ÍԂ���߂��Ă������ɁA�u�E���l�ƈꏏ�v�ɂ��遡 --EN:-- �� 432 �� When Logan returns from the old fort, make it "with Uru-sama" ��
	if	proxy:IsCompleteEvent( GOD_BELIEVER_3_STATE_STONE_PILLAR ) == true and	--�Β��ɋ��� ���� --EN:--Staying at the stone pillar and
		proxy:IsCompleteEvent( URUBAIN_STATE_STONE_PILLAR ) == true or			--�E���l�Β��ɋ��� �� --EN:--Are you in the Uru-sama stone pillar?
		proxy:IsCompleteEvent( URUBAIN_STATE_THANKS ) == true then				--�E���l�����ӂ��Ă��� �Ȃ�� --EN:--If Uru-sama is grateful
		
		SetNpcStateFlag( proxy, param, god_beliver3_flag_list, GOD_BELIEVER_3_STATE_URU );--�E���l�ƈꏏ�� --EN:--With Ur-sama
	end
	
	if proxy:IsCompleteEvent( URUBAIN_STATE_STONE_PILLAR_ANGRY ) == true and	--�E���l���G�� ���� --EN:--Ur-sama is hostile and
	   proxy:IsCompleteEvent( GOD_BELIEVER_3_STATE_ANGRY ) == false then	--�G�΂��Ă��Ȃ��Ȃ�� --EN:--if not hostile
	   --����Ŗ��� --EN:--not dead
	   if proxy:IsCompleteEvent( GOD_BELIEVER_3_STATE_DEAD ) == false then
			SetNpcStateFlag( proxy, param, god_beliver3_flag_list, GOD_BELIEVER_3_STATE_ANGRY );--�G�Ώ�Ԃ� --EN:-- in hostile state
		end
	end
	
	if proxy:IsCompleteEvent( GOD_BELIEVER_3_STATE_DEAD ) == true then
		--��433���M�k�R���S������ --EN:-- �� 433 �� Follower 3 death process ��
		InvalidBackRead( proxy, 684 );
		proxy:SetEventFlag( 323, true );
	elseif proxy:IsCompleteEvent( GOD_BELIEVER_3_STATE_ANGRY ) == true then
		--��434���M�k�R�G�Ώ����� --EN:-- �� 434 �� Follower 3 hostile processing ��
		proxy:EnableLogic(684,true);--���W�b�N�n�m --EN:--Logic ON
		proxy:SetTeamType(684, TEAM_TYPE_AngryFriend);--�`�[���^�C�v�ύX		 --EN:--Change team type
		--SetNpcStateFlag( proxy, param, god_beliver3_flag_list, GOD_BELIEVER_3_STATE_ANGRY );--�G�Ώ�Ԃ� --EN:-- in hostile state
	end
--------�e�Ď��ǉ�----------- --EN:--Add each monitor-----------
	--�E���l�G�Ύ��ɌĂ΂��n���h���o�^ --EN:--Registering a handler to be called when Uru-sama is hostile
	proxy:LuaCall(430, 1, "OnEvent_430", once);
	--��435���M�k�R���A�C�e��������遡(��b�Ăяo��) --EN:-- �� 435 �� follower 3 gives an item �� (conversation call)
	proxy:LuaCall(435, 0, "OnEvent_435", once);
	
	if proxy:IsCompleteEvent(GOD_BELIEVER_3_STATE_DEAD ) == false then--���S���Ă��Ȃ��Ȃ�� --EN:--if not dead
		if proxy:IsCompleteEvent( GOD_BELIEVER_3_STATE_ANGRY ) == false then--�G�΂��Ă��Ȃ� --EN:--not hostile
			--��430���M�k�R�G�ΊĎ��� --EN:-- �� 430 �� Followers 3 hostile surveillance ��
			proxy:OnCharacterTotalRateDamage( 430, 684, LOCAL_PLAYER, NPC_ANGRY_Rate, "OnEvent_430", once );--�G�ΊĎ��ǉ� --EN:--Added hostile monitoring
			
		end
		--��431���M�k�R���S�Ď��� --EN:-- �� 431 �� follower 3 death watch ��
		proxy:OnCharacterDead( 431, 684, "OnEvent_431", once );--��L�̏�Ԃ��������ɁA���S�Ď��ǉ� --EN:--Added death watch when the above conditions were met
	end
--���_�̐M�k3�֘A��----------------------------- --EN:--��Related to God's Follower 3��-----------------------------

--[[����܂̃g�}�X�֘A��]]----------------------------- --EN:--[[�� related to Thomas the Big Bag ��]]-----------------------------
	SetFirstNpcStateFlag(proxy, param, tomasu_flag_list, TOMASU_STATE_ISNOT);--��Ԃ��ݒ肳��Ă��Ȃ���΁A�܂����Ȃ��� --EN:-- if the state is not set, it is not yet
	
	--�g�}�X���܂����Ȃ���Ԃ������� --EN:--If Thomas wasn't there yet
	if proxy:IsCompleteEvent( TOMASU_STATE_ISNOT ) == true then--�܂����Ȃ��Ȃ�� --EN:--if you haven't already
		if boss_flagCount >= 0 then--�{�X��1�̈ȏ�|������ --EN:--If you defeat 1 or more bosses
			SetNpcStateFlag(proxy, param, tomasu_flag_list, TOMASU_STATE_WAIT );--�a������ --EN:--Keep it
		end
	end
	
	--�g�}�X�ɖ��̔������n������ --EN:--Handing over the daughter's hair ornament to Thomas
	proxy:LuaCall( 354, 0, "OnEvent_354", everytime );
	
	if	proxy:IsCompleteEvent( TOMASU_STATE_DEAD ) == false then--����ł��Ȃ��Ȃ�� --EN:--if not dead
		if	proxy:IsCompleteEvent( TOMASU_STATE_ANGRY ) == false then--�G�΂ł͂Ȃ� --EN:--not hostile
			--proxy:OnCharacterTotalDamage( 350, 687, 10000, 100, "OnEvent_350", once );--�_���[�W�Ď��ǉ� --EN:--Damage monitoring added
			proxy:OnCharacterTotalRateDamage( 350, 687, LOCAL_PLAYER, NPC_ANGRY_Rate, "OnEvent_350", once );
			
		end
		--��L�̏�Ԃ��������ɁA���S�Ď��ǉ� --EN:--Added death watch when the above conditions were met
		proxy:OnCharacterDead( 351, 687, "OnEvent_351", once );
	end
	
	if proxy:IsCompleteEvent( TOMASU_STATE_WAIT ) == true or 
	   proxy:IsCompleteEvent( TOMASU_STATE_ANGRY ) == true then
		proxy:SetEventFlag( 352, false );
	end

	
	if	proxy:IsCompleteEvent( TOMASU_STATE_DEAD ) == true or proxy:IsCompleteEvent( TOMASU_STATE_ISNOT ) == true then
		InvalidBackRead( proxy, 687 );
		proxy:SetEventFlag( 352, true );
	elseif proxy:IsCompleteEvent( TOMASU_STATE_ANGRY ) == true then
		proxy:EnableLogic(687,true);--���W�b�N�n�m --EN:--Logic ON
		proxy:SetTeamType(687, TEAM_TYPE_AngryFriend);--�`�[���^�C�v�ύX		 --EN:--Change team type
		--SetNpcStateFlag( proxy, param, tomasu_flag_list, TOMASU_STATE_ANGRY );--�G�Ώ�Ԃ� --EN:-- in hostile state
	end
--����܂̃g�}�X�֘A��----------------------------- --EN:--��Obukuro Thomas related ��-----------------------------

--[[�����t�B�X�g�֘A��]]----------------------------- --EN:--[[��Mephisto Related��]]-----------------------------

--���t�B�X�g�p�t���O�������� --EN:--Mephisto Flag Establishment Judgment
--[[�g�}�X�́A�g�p�̕ύX�ň˗�����Ȃ��ׁA�R�����g�A�E�g�B�i�ė��p�����肤��̂ŏ����Ȃ��j]] --EN:--[[Thomas is commented out as it is not requested in the change of use. (Don't delete it because it can be reused)]]
	if proxy:IsCompleteEvent( RENDOL_STATE_DEAD ) == true then--�����h�����q������ł��� --EN:--Prince Lendl is dead
		if proxy:IsCompleteEvent( BIYO_STATE_DEAD ) == true then--�u��������ł��� --EN:--The gnat is dead
			if proxy:IsCompleteEvent( ROGARN_STATE_DEAD ) == true and proxy:IsCompleteEvent( MAGIC_STUDENT_STATE_DEAD ) == true then--���K�[���Ɩ��p�̓k������ł��� --EN:--Logan and the sorcerers are dead
				if proxy:IsCompleteEvent( MAJO_STATE_DEAD ) == true then--����������ł��� --EN:--the witch is dead
					if proxy:IsCompleteEvent( URUBAIN_STATE_DEAD ) == true and proxy:IsCompleteEvent( GOD_BELIEVER_1_STATE_DEAD ) == true and proxy:IsCompleteEvent( GOD_BELIEVER_3_STATE_DEAD ) == true then--�E���l�Ƃ��̂Ƃ�܂�������ł��� --EN:--Ur-sama and his entourage are dead
						--if proxy:IsCompleteEvent( TOMASU_STATE_DEAD ) == true then--�g�}�X������ł��� --EN:--Thomas is dead
						if proxy:IsCompleteEvent( BATTI_DEAD ) == true then--�o�b�`������ł��� --EN:--batch is dead
							--�S���E�������ɂȂ�̂ŁA�C�������t���O�𗧂Ă� --EN:--Since you killed them all, raise the mission completion flag.
							proxy:SetEventFlag( 8097, true );
						else--�p�b�`�������Ă��� --EN:--patch live
							--�t���O���� --EN:--flag established
							proxy:SetEventFlag( 8096, true );--�o�b�`�E�Q�҂� --EN:--Waiting for batch killing
						end
						--else--�g�}�X�������Ă��� --EN:--thomas is alive
						--	--�t���O���� --EN:--flag established
						--	proxy:SetEventFlag( 8095, true );--�g�}�X�E�Q�҂� --EN:--waiting to kill Thomas
						--end
					elseif proxy:IsCompleteEvent( URUBAIN_STATE_DEAD ) == false and proxy:IsCompleteEvent( GOD_BELIEVER_1_STATE_DEAD ) == false and proxy:IsCompleteEvent( GOD_BELIEVER_2_STATE_DEAD ) == false then--�E���l�Ƃ��̂Ƃ�܂��������Ă��� --EN:--Ur-sama and his entourage are alive
						--�t���O���� --EN:--flag established
						proxy:SetEventFlag( 8094, true );--�E���l�Ƃ��̂Ƃ�܂��E�Q�҂� --EN:--Waiting to kill Uru-sama and his entourage
					end
				else--�����������Ă��� --EN:--the witch is alive
					--�t���O���� --EN:--flag established
					proxy:SetEventFlag( 8093, true );--�����E�Q�҂� --EN:--Waiting to kill a witch
				end
			elseif proxy:IsCompleteEvent( ROGARN_STATE_DEAD ) == false or proxy:IsCompleteEvent( MAGIC_STUDENT_STATE_DEAD ) == false then--���K�[�������p�̓k�������Ă��� --EN:--Logan or the sorcerer is alive
				--�t���O���� --EN:--flag established
				proxy:SetEventFlag( 8092, true );--���K�[���B�E�Q�҂� --EN:--Waiting for Logan and others to be killed
			end
		else--�r���������Ă����� --EN:--If Beyo were alive
			--�t���O���� --EN:--flag established
			proxy:SetEventFlag( 8091, true );--�r���E�Q�҂� --EN:--Waiting to kill Biyo
		end
	else--�����h�����q�������Ă����� --EN:--If Prince Lendl was alive
		--�t���O���� --EN:--flag established
		proxy:SetEventFlag( 8090, true );--�����h�����q�E�Q�҂� --EN:--Waiting for the murder of Prince Lendl
	end


	SetFirstNpcStateFlag(proxy, param, mefist_flag_list, MEFIST_STATE_NO_STAY);--��Ԃ��ݒ肳��Ă��Ȃ���΁A�܂����Ȃ��� --EN:-- if the state is not set, it is not yet
	
	if	proxy:IsCompleteEvent( MEFIST_STATE_NO_STAY ) == true 	--�܂����Ȃ��@���� --EN:--not yet and
	and	proxy:IsCompleteEvent( YURUTO_STATE_DEAD ) == true --�����g�����S ���� --EN:--The yurt dies and
	and proxy:IsSuccessQWC( 10600 ) == true then--QWC�����Ȃ�� --EN:--If QWC is established
		SetNpcStateFlag(proxy, param, mefist_flag_list, MEFIST_STATE_STONE_PILLAR );--�Β��ɂ���� --EN:--to be on the pillar
	end
	
	if	proxy:IsCompleteEvent( MEFIST_STATE_NO_STAY ) == false		--���������ɋ���@���� --EN:--I'm already here and
	and	proxy:IsCompleteEvent( MEFIST_STATE_DEAD 	) == false then	--���S���Ă��Ȃ��Ȃ�� --EN:--if not dead
		
		if	proxy:IsCompleteEvent( MEFIST_STATE_ANGRY ) == false then--�G�΂��Ă��Ȃ� --EN:--not hostile
			--proxy:OnCharacterTotalDamage( 360, 680, 10000, 100, "OnEvent_360", once );--�_���[�W�Ď��ǉ� --EN:--Damage monitoring added
			proxy:OnCharacterTotalRateDamage( 360, 680, LOCAL_PLAYER, NPC_ANGRY_Rate, "OnEvent_360", once );
			
		end
		
		--�eNPC�E�Q�҂�-- --EN:--Waiting for killing each NPC--
		proxy:LuaCall( 362, 0, "OnEvent_362", everytime );--�����h�����q --EN:--Prince Lendl
		proxy:LuaCall( 363, 0, "OnEvent_363", everytime );--�r�������O���� --EN:--Bjrn Grum
		proxy:LuaCall( 364, 0, "OnEvent_364", everytime );--���K�[�� --EN:--Logan
		proxy:LuaCall( 365, 0, "OnEvent_365", everytime );--���� --EN:--witch
		proxy:LuaCall( 366, 0, "OnEvent_366", everytime );--�E���l --EN:-- Mr. Ur
		proxy:LuaCall( 367, 0, "OnEvent_367", everytime );--�g�}�X --EN:--Thomas
		proxy:LuaCall( 368, 0, "OnEvent_368", everytime );--�o�b�` --EN:--batch
		
		--���t�B�X�g�̐��z��-- --EN:--Mephisto's declaration of war--
		proxy:LuaCall( 369, 0, "OnEvent_369", everytime );
		
		--�eNPC�E�Q����-- --EN:--Thank you for killing each NPC--
		proxy:LuaCall( 400, 0, "OnEvent_400", everytime );--�����h�����q --EN:--Prince Lendl
		proxy:LuaCall( 401, 0, "OnEvent_401", everytime );--�r�������O���� --EN:--Bjrn Grum
		proxy:LuaCall( 402, 0, "OnEvent_402", everytime );--���K�[�� --EN:--Logan
		proxy:LuaCall( 403, 0, "OnEvent_403", everytime );--���� --EN:--witch
		proxy:LuaCall( 404, 0, "OnEvent_404", everytime );--�E���l --EN:-- Mr. Ur
		proxy:LuaCall( 405, 0, "OnEvent_405", everytime );--�g�}�X --EN:--Thomas
		proxy:LuaCall( 406, 0, "OnEvent_406", everytime );--�o�b�` --EN:--batch
		
		--��L�̏�Ԃ̎��ɁA���S�Ď��ǉ� --EN:--In the above state, add death watch
		proxy:OnCharacterDead( 361, 680, "OnEvent_361", once );
	end
	
	if	proxy:IsCompleteEvent( MEFIST_STATE_NO_STAY )	== true or
		proxy:IsCompleteEvent( MEFIST_STATE_DEAD ) 		== true then
		InvalidBackRead( proxy, 680 );
	elseif proxy:IsCompleteEvent( MEFIST_STATE_ANGRY ) == true then
		proxy:EnableLogic(680,true);--���W�b�N�n�m --EN:--Logic ON
		proxy:SetTeamType(680, TEAM_TYPE_AngryFriend);--�`�[���^�C�v�ύX		 --EN:--Change team type
		--SetNpcStateFlag( proxy, param, mefist_flag_list, MEFIST_STATE_ANGRY );--�G�Ώ�Ԃ� --EN:-- in hostile state
	end

--�����t�B�X�g�֘A��----------------------------- --EN:--�� Mephisto Related ��-----------------------------

--[[���S�܂ꂽ��m�֘A��]]----------------------------- --EN:--[[��Related to Broken Warrior��]]-----------------------------
	SetFirstNpcStateFlag(proxy, param, heartbreak_fighter_flag_list, HEART_BREAK_FIGHTER_STATE_STONE_PILLAR);--��Ԃ��ݒ肳��Ă��Ȃ����A�Β��ɂ���� --EN:--When the state is not set,
	
	if proxy:IsCompleteEvent( HEART_BREAK_FIGHTER_STATE_DELETE ) == true then--�����܂��Ȃ�� --EN:--If it disappears
		SetNpcStateFlag( proxy, param, heartbreak_fighter_flag_list, HEART_BREAK_FIGHTER_STATE_DEAD );--���S�� --EN:--to death
		proxy:OpeningDead( 611, true );
	end
	
	if proxy:IsCompleteEvent( HEART_BREAK_FIGHTER_STATE_DEAD ) == false then--���S���Ă��Ȃ���� --EN:--if not dead
		if proxy:IsCompleteEvent( HEART_BREAK_FIGHTER_STATE_ANGRY ) == false then--�G�΂ł͂Ȃ� --EN:--not hostile
		--��384�����̏���|���ƁA���������ɂȂ遡 --EN:-- �� 384 �� If you defeat the King's shield, it will disappear ��
			if proxy:IsCompleteEvent( HEART_BREAK_FIGHTER_STATE_STONE_PILLAR ) == true 	--�Β��ɂ���@���� --EN:--At the stone pillar and
			and proxy:IsCompleteEvent( 4224 ) == true then								--���̏����E���Ă���@�Ȃ�� --EN:--If you're killing the King's Shield
				SetNpcStateFlag( proxy, param, heartbreak_fighter_flag_list, HEART_BREAK_FIGHTER_STATE_MAYBE_DELETE );--���������� --EN:-- about to disappear
				proxy:SetEventFlag( 384, true );
			end
			--proxy:OnCharacterTotalDamage( 380, 611, 10000, 100, "OnEvent_380", once );--�_���[�W�Ď��ǉ� --EN:--Damage monitoring added
			proxy:OnCharacterTotalRateDamage( 380, 611, LOCAL_PLAYER, NPC_ANGRY_Rate, "OnEvent_380", once );
			
			proxy:LuaCall( 382, 0, "OnEvent_382", everytime );
			
		--��388���S�܂ꂽ��m�ɘb���������� --EN:--��388��Talked to a broken warrior��
			if proxy:IsCompleteEvent( 388 ) == false then
				proxy:LuaCall( 388, 0, "OnEvent_388", once );
				proxy:LuaCall( 388, REMO_START , "OnEvent_388_RemoStart",once);
				proxy:LuaCall( 388, REMO_FINISH, "OnEvent_388_RemoFinish",once);
			end
		end
		--��L�̎��ɁA���S�Ď��ǉ� --EN:--At the above time, add death watch
		proxy:OnCharacterDead( 381, 611, "OnEvent_381", once );
	end

	if	proxy:IsCompleteEvent( HEART_BREAK_FIGHTER_STATE_STONE_PILLAR ) == false and
		proxy:IsCompleteEvent( HEART_BREAK_FIGHTER_STATE_ANGRY ) 		== false and
		proxy:IsCompleteEvent( HEART_BREAK_FIGHTER_STATE_MAYBE_DELETE ) == false and
		proxy:IsCompleteEvent( HEART_BREAK_FIGHTER_STATE_DELETE )		== false then
		InvalidBackRead( proxy, 611 );
	elseif proxy:IsCompleteEvent( HEART_BREAK_FIGHTER_STATE_ANGRY ) == true then
		proxy:EnableLogic(611,true);--���W�b�N�n�m --EN:--Logic ON
		proxy:SetTeamType(611, TEAM_TYPE_AngryFriend);--�`�[���^�C�v�ύX		 --EN:--Change team type
		--SetNpcStateFlag( proxy, param, heartbreak_fighter_flag_list, HEART_BREAK_FIGHTER_STATE_ANGRY );--�G�Ώ�Ԃ� --EN:-- in hostile state
	end
--���S�܂ꂽ��m�֘A��----------------------------- --EN:--�� Broken Warrior related ��-----------------------------


--[[���{�[���h�E�B���֘A��]]----------------------------- --EN:--[[��Baldwin Related��]]-----------------------------
	--������Ԃ�ݒ� --EN:--set initial state
	SetFirstNpcStateFlag(proxy, param, baldwin_flag_list, BALDWIN_STATE_ISNOT);--��Ԃ��ݒ肳��Ă��Ȃ���΁A�܂����Ȃ��� --EN:-- if the state is not set, it is not yet

	--�{�[���h�E�B�����܂����Ȃ���Ԃ������� --EN:--If Baldwin wasn't there yet
	if proxy:IsCompleteEvent( BALDWIN_STATE_ISNOT ) == true then--�܂����Ȃ��Ȃ�� --EN:--if you haven't already
		--if boss_flagCount >= 2 then--�{�X��2�̈ȏ�|������ --EN:--After defeating two or more bosses
		SetNpcStateFlag(proxy, param, baldwin_flag_list, BALDWIN_STATE_WORK );--�d������ --EN:--during work
		--end
	end
	
	
	if	proxy:IsCompleteEvent( BALDWIN_STATE_WORK ) 	== true or			--�d�����@�� --EN:--Are you at work?
		proxy:IsCompleteEvent( BALDWIN_STATE_HOSTILE ) 	== true then		--�Β��œG�΂Ȃ�� --EN:--If hostile with a stone pillar
		
		if	proxy:IsCompleteEvent( BALDWIN_STATE_HOSTILE ) == false then--�G�΂ł͖��� --EN:--not hostile
			--proxy:OnCharacterTotalDamage( 390, 694, 10000, 100, "OnEvent_390", once );--�_���[�W�Ď��ǉ� --EN:--Damage monitoring added
			proxy:OnCharacterTotalRateDamage( 390, 694, LOCAL_PLAYER, NPC_ANGRY_Rate, "OnEvent_390", once );
			
		end
		
		--��L�̏�Ԃ̎��ɁA���S�Ď��ǉ� --EN:--In the above state, add death watch
		proxy:OnCharacterDead( 391 , 694 , "OnEvent_391" , once );
	end

	--���݂̏�Ԃ��擾 --EN:--get current state
	local now_state = GetNpcStateFlag( proxy , param , baldwin_flag_list );

	if now_state == BALDWIN_STATE_HOSTILE then--�G��(�Β�) --EN:-- Hostility (Stone Pillar)
		proxy:EnableLogic(694,true);--���W�b�N�n�m --EN:--Logic ON
		proxy:SetTeamType(694, TEAM_TYPE_AngryFriend);--�`�[���^�C�v�ύX		 --EN:--Change team type
		--SetNpcStateFlag( proxy, param, baldwin_flag_list, BALDWIN_STATE_HOSTILE );--�G�� --EN:--hostile
	elseif now_state == BALDWIN_STATE_DEAD or now_state == BALDWIN_STATE_ISNOT then--���S --EN:--death
		InvalidBackRead( proxy , 694 );--�{�[���h�E�B�������� --EN:--Disable Baldwin
		proxy:SetEventFlag( 392, true );
	end
--���{�[���h�E�B���֘A��----------------------------- --EN:--��Baldwin Related��-----------------------------

--[[�����D��֘A��]----------------------------- --EN:--[[��Weaving-related��]-----------------------------
	--������Ԃ�ݒ� --EN:--set initial state
	SetFirstNpcStateFlag(proxy, param, monoshiri_flag_list, MONOSHIRI_STATE_ISNOT);--��Ԃ��ݒ肳��Ă��Ȃ���΁A�܂����Ȃ��� --EN:-- if the state is not set, it is not yet
	
	--���D�肪�܂����Ȃ���Ԃ������� --EN:--If there was no monoori yet
	if proxy:IsCompleteEvent( MONOSHIRI_STATE_ISNOT ) == true then--�܂����Ȃ��Ȃ�� --EN:--if you haven't already
		if boss_flagCount >= 1 then--�{�X���P�̈ȏ�|������ --EN:--If you defeat one or more bosses
			SetNpcStateFlag(proxy, param, monoshiri_flag_list, MONOSHIRI_STATE_BUSINESS );--��񔄂��� --EN:--Let's sell information
		end
	end

	if proxy:IsCompleteEvent(MONOSHIRI_STATE_DEAD ) == false then--���S���Ă��Ȃ��Ȃ�� --EN:--if not dead
		if proxy:IsCompleteEvent( MONOSHIRI_STATE_HOSTILE ) == false then--�G�΂��Ă��Ȃ� --EN:--not hostile
			--proxy:OnCharacterTotalDamage( 340, 686, 10000, 100, "OnEvent_340", once );--�_���[�W�Ď��ǉ� --EN:--Damage monitoring added
			proxy:OnCharacterTotalRateDamage( 340, 686, LOCAL_PLAYER, NPC_ANGRY_Rate, "OnEvent_340", once );
			
		end
		--��L�̏�Ԃ��������ɁA���S�Ď��ǉ� --EN:--Added death watch when the above conditions were met
		proxy:OnCharacterDead( 341 , 686 , "OnEvent_341" , once );
	end

	--���݂̏�Ԃ��擾 --EN:--get current state
	local now_state = GetNpcStateFlag( proxy , param , monoshiri_flag_list );
	
	if now_state == MONOSHIRI_STATE_BUSINESS or now_state == MONOSHIRI_STATE_HOSTILE then
		proxy:SetEventFlag( 343, false );
	end

	if now_state == MONOSHIRI_STATE_HOSTILE then--�G��(�Β�) --EN:-- Hostility (Stone Pillar)
		proxy:EnableLogic(686,true);--���W�b�N�n�m --EN:--Logic ON
		proxy:SetTeamType(686, TEAM_TYPE_AngryFriend);--�`�[���^�C�v�ύX		 --EN:--Change team type
		--SetNpcStateFlag( proxy, param, monoshiri_flag_list, MONOSHIRI_STATE_HOSTILE );--�G�Ώ�Ԃ� --EN:-- in hostile state
		
	elseif now_state == MONOSHIRI_STATE_ISNOT or now_state == MONOSHIRI_STATE_DEAD  then--�܂����Ȃ� --EN:--not yet
		InvalidBackRead( proxy , 686 );--���D�薳���� --EN:--Disable Weaving
		proxy:SetEventFlag( 343, true );
		
	end
	
--�����D��֘A��-----------------------------]] --EN:--��Weaving related ��-----------------------------]]

--------------------------------------------------------------------------------
--[[NPC�t��OBJ�֘A]] --EN:--[[NPC related OBJ]]
--------------------------------------------------------------------------------
--��180���_�̐M�k3��OBJ�� --EN:--��180��God's follower 3 OBJ��
	if proxy:IsCompleteEvent( 323 ) == true then
		--OBJ�̕\���E�A�^�����Ȃ��� --EN:--Eliminate OBJ display/atari
		proxy:SetDrawEnable( 1160, false );
		proxy:SetColiEnable( 1160, false );
		--SFX������ --EN:--Turn off SFX
		proxy:InvalidSfx( 2160, false );
		--�|�C���g���C�g������ --EN:-- turn off point lights
		proxy:InvalidPointLight( 2140 );
		--�t���O���Z�b�g���� --EN:-- set the flag
		proxy:SetEventFlag( 180, true );
	end
--��181���_�̐M�k2��OBJ�� --EN:--��181��God's followers 2 OBJ��
	if proxy:IsCompleteEvent( 333 ) == true then
		--OBJ�̕\���E�A�^�����Ȃ��� --EN:--Eliminate OBJ display/atari
		proxy:SetDrawEnable( 1161, false );
		proxy:SetColiEnable( 1161, false );
		--SFX������ --EN:--Turn off SFX
		proxy:InvalidSfx( 2161, false );
		--�|�C���g���C�g������ --EN:-- turn off point lights
		proxy:InvalidPointLight( 2141 );
		--�t���O���Z�b�g���� --EN:-- set the flag
		proxy:SetEventFlag( 181, true );
	end
--��182�����K�[����OBJ�� --EN:--��182�� Logan's OBJ��
	if proxy:IsCompleteEvent( 224 ) == true then
		--OBJ�̕\���E�A�^�����Ȃ��� --EN:--Eliminate OBJ display/atari
		proxy:SetDrawEnable( 1162, false );
		proxy:SetColiEnable( 1162, false );
		--SFX������ --EN:--Turn off SFX
		proxy:InvalidSfx( 2162, false );
		--�|�C���g���C�g������ --EN:-- turn off point lights
		proxy:InvalidPointLight( 2142 );
		--�t���O���Z�b�g���� --EN:-- set the flag
		proxy:SetEventFlag( 182, true );
	else
		proxy:SetEventFlag( 182, false );
	end
--��183�����p�̓k��OBJ�� --EN:--�� 183 �� OBJ of magicians ��
	if proxy:IsCompleteEvent( 313 ) == true then
		--OBJ�̕\���E�A�^�����Ȃ��� --EN:--Eliminate OBJ display/atari
		proxy:SetDrawEnable( 1163, false );
		proxy:SetColiEnable( 1163, false );
		--SFX������ --EN:--Turn off SFX
		proxy:InvalidSfx( 2163, false );
		--�|�C���g���C�g������ --EN:-- turn off point lights
		proxy:InvalidPointLight( 2143 );
		--�t���O���Z�b�g���� --EN:-- set the flag
		proxy:SetEventFlag( 183, true );
	end
--��184��������OBJ�� --EN:--��184��Witch's OBJ��
	if proxy:IsCompleteEvent( 263 ) == true then
		--OBJ�̕\���E�A�^�����Ȃ��� --EN:--Eliminate OBJ display/atari
		proxy:SetDrawEnable( 1164, false );
		proxy:SetColiEnable( 1164, false );
		--SFX������ --EN:--Turn off SFX
		proxy:InvalidSfx( 2164, false );
		--�|�C���g���C�g������ --EN:-- turn off point lights
		proxy:InvalidPointLight( 2144 );
		--�t���O���Z�b�g���� --EN:-- set the flag
		proxy:SetEventFlag( 184, true );
	else
		proxy:SetEventFlag( 184, false );
	end
--��185���E���x�C����OBJ�� --EN:--��185��Ulbane's OBJ��
	if proxy:IsCompleteEvent( 273 ) == true then
		--OBJ�̕\���E�A�^�����Ȃ��� --EN:--Eliminate OBJ display/atari
		proxy:SetDrawEnable( 1165, false );
		proxy:SetColiEnable( 1165, false );
		--SFX������ --EN:--Turn off SFX
		proxy:InvalidSfx( 2165, false );
		proxy:InvalidSfx( 2190, false );
		proxy:InvalidSfx( 2191, false );
		proxy:InvalidSfx( 2192, false );
		--�|�C���g���C�g������ --EN:-- turn off point lights
		proxy:InvalidPointLight( 2145 );
		--�t���O���Z�b�g���� --EN:-- set the flag
		proxy:SetEventFlag( 185, true );
	else
		proxy:SetEventFlag( 185, false );
	end
--��186���{�[���h�E�B����OBJ�� --EN:--��186��Baldwin's OBJ��
	if proxy:IsCompleteEvent( 392 ) == true then
		--OBJ�̕\���E�A�^�����Ȃ��� --EN:--Eliminate OBJ display/atari
		proxy:SetDrawEnable( 1166, false );
		proxy:SetColiEnable( 1166, false );
		proxy:SetDrawEnable( 1180, false );
		proxy:SetColiEnable( 1180, false );
		proxy:SetDrawEnable( 1181, false );
		proxy:SetColiEnable( 1181, false );
		proxy:SetDrawEnable( 1182, false );
		proxy:SetColiEnable( 1182, false );
		
		--SFX������ --EN:--Turn off SFX
		proxy:InvalidSfx( 2166, false );
		--�|�C���g���C�g������ --EN:-- turn off point lights
		proxy:InvalidPointLight( 2146 );
		--�t���O���Z�b�g���� --EN:-- set the flag
		proxy:SetEventFlag( 186, true );
		--�}�b�v�q�b�g�̖����� --EN:--disable map hit
		proxy:SetDrawEnableArray( 1080,false);
		proxy:SetColiEnableArray( 1080,false);
		
	end
--��187����܂̃g�}�X��OBJ�� --EN:--��187��Obukuro Thomas OBJ��
	if proxy:IsCompleteEvent( 352 ) == true then
		--OBJ�̕\���E�A�^�����Ȃ��� --EN:--Eliminate OBJ display/atari
		proxy:SetDrawEnable( 1167, false );
		proxy:SetColiEnable( 1167, false );
		
		proxy:SetDrawEnable( 1185, false );
		proxy:SetColiEnable( 1185, false );
		proxy:SetDrawEnable( 1186, false );
		proxy:SetColiEnable( 1186, false );
		proxy:SetDrawEnable( 1187, false );
		proxy:SetColiEnable( 1187, false );
		
		--SFX������ --EN:--Turn off SFX
		proxy:InvalidSfx( 2167, false );
		--�|�C���g���C�g������ --EN:-- turn off point lights
		proxy:InvalidPointLight( 2147 );
		--�t���O���Z�b�g���� --EN:-- set the flag
		proxy:SetEventFlag( 187, true );
		--�}�b�v�q�b�g�̖����� --EN:--disable map hit
		proxy:SetDrawEnableArray( 1081,false);
		proxy:SetColiEnableArray( 1081,false);
	else
		proxy:SetEventFlag( 187, false );
	end
--��188���������OBJ�� --EN:--�� 188 �� Savvy OBJ ��
	--�폜 --EN:--delete

--��189���r����OBJ�� --EN:--��189��Byo's OBJ��
	if proxy:IsCompleteEvent( 244 ) == true then
		--OBJ�̕\���E�A�^�����Ȃ��� --EN:--Eliminate OBJ display/atari
		proxy:SetDrawEnable( 1169, false );
		proxy:SetColiEnable( 1169, false );
		--�t���O���Z�b�g���� --EN:-- set the flag
		proxy:SetEventFlag( 189, true );
	else
		proxy:SetEventFlag( 189, false );
	end
--��190�������h�����q��OBJ�� --EN:--��190��Prince Lendl's OBJ��
	if proxy:IsCompleteEvent( 232 ) == true then
		--OBJ�̕\���E�A�^�����Ȃ��� --EN:--Eliminate OBJ display/atari
		proxy:SetDrawEnable( 1170, false );
		proxy:SetColiEnable( 1170, false );
		--�t���O���Z�b�g���� --EN:-- set the flag
		proxy:SetEventFlag( 190, true );
	else
		proxy:SetEventFlag( 190, false );
	end
--��191���p�b�`��OBJ�� --EN:--��191��Patch OBJ��
	if proxy:IsCompleteEvent( 293 ) == true then
		--OBJ�̕\���E�A�^�����Ȃ��� --EN:--Eliminate OBJ display/atari
		proxy:SetDrawEnable( 1171, false );
		proxy:SetColiEnable( 1171, false );
		--�t���O���Z�b�g���� --EN:-- set the flag
		proxy:SetEventFlag( 191, true );
	else
		proxy:SetEventFlag( 191, false );
	end
--��192�������g��OBJ�� --EN:-- �� 192 �� Yurt OBJ ��
	if proxy:IsCompleteEvent( 282 ) == true then
		--OBJ�̕\���E�A�^�����Ȃ��� --EN:--Eliminate OBJ display/atari
		proxy:SetDrawEnable( 1172, false );
		proxy:SetColiEnable( 1172, false );
		--�t���O���Z�b�g���� --EN:-- set the flag
		proxy:SetEventFlag( 192, true );
	else
		proxy:SetEventFlag( 192, false );
	end
	
--[[��188���������OBJ�� --EN:--[[ �� 188 �� Savvy OBJ ��
	if proxy:IsCompleteEvent( 343 ) == true then
		--OBJ�̕\���E�A�^�����Ȃ��� --EN:--Eliminate OBJ display/atari
		proxy:SetDrawEnable( 1168, false );
		proxy:SetColiEnable( 1168, false );
		--SFX������ --EN:--Turn off SFX
		proxy:InvalidSfx( 2168, false );
		--�|�C���g���C�g������ --EN:-- turn off point lights
		proxy:InvalidPointLight( 2148 );
		--�t���O���Z�b�g���� --EN:-- set the flag
		proxy:SetEventFlag( 188, true );
	else
		proxy:SetEventFlag( 188, false );
	end]]

--------------------------------------------------------------------------------
--QWC�̒l�ɂ��NPC�̉�b�ω�����p�̃t���O --EN:--Flag for NPC conversation change judgment by QWC value
--------------------------------------------------------------------------------
	--��QWC����b�p�t���O�P --EN:-- �� QWC �� Conversation flag 1
	if proxy:IsSuccessQWC( 10100 ) == true then
		proxy:SetEventFlag(8040,true);--�������� --EN:--Condition met
	else
		proxy:SetEventFlag(8040,false);--���������� --EN:--Condition not satisfied
	end
	
	--��QWC����b�p�t���O�Q --EN:-- �� QWC �� Conversation flag 2
	if proxy:IsSuccessQWC( 10200 ) == true then
		proxy:SetEventFlag(8041,true);--�������� --EN:--Condition met
	else
		proxy:SetEventFlag(8041,false);--���������� --EN:--Condition not satisfied
	end
	
	--��QWC����b�p�t���O3 --EN:-- QWC Conversation flag 3
	if proxy:IsSuccessQWC( 10300 ) == true then
		proxy:SetEventFlag(8042,true);--�������� --EN:--Condition met
	else
		proxy:SetEventFlag(8042,false);--���������� --EN:--Condition not satisfied
	end
	
	--��QWC����b�p�t���O4 --EN:-- QWC Conversation Flag 4
	if proxy:IsSuccessQWC( 10400 ) == true then
		proxy:SetEventFlag(8043,true);--�������� --EN:--Condition met
	else
		proxy:SetEventFlag(8043,false);--���������� --EN:--Condition not satisfied
	end
	
	--��QWC����b�p�t���O5 --EN:-- �� QWC �� Conversation flag 5
	if proxy:IsSuccessQWC( 10500 ) == true then
		proxy:SetEventFlag(8044,true);--�������� --EN:--Condition met
	else
		proxy:SetEventFlag(8044,false);--���������� --EN:--Condition not satisfied
	end
	
--���򗳂̓P�މ����� --EN:-- �� Wyvern's withdrawal canceled ��
	if proxy:IsCompleteEvent(TYO_STATE_ESCAPE) == true then
		SetNpcStateFlag( proxy, param, tyo1_flag_list, TYO_STATE_SLEEPING );
	end
	if proxy:IsCompleteEvent(KENZOKU_STATE_ESCAPE) == true then
		SetNpcStateFlag( proxy, param, kenzoku_flag_list, KENZOKU_STATE_WARNING );
	end
	
	
	--HpMpSpMax
	--proxy:PlayerParamRecover();
	--proxy:PlayerRecover();

	--������	 --EN:--������
	--proxy:OnKeyTime2( 9999990,"OnEvent_9999990",0.5,0,0,once);
	
	--proxy:LuaCall( 99999,0,"OnEvent_9999990",everytime);
	if proxy:IsDbgReLoad() == true then
		proxy:OnKeyTime2( 4021,"OnEvent_DbgReLoad",1.0,0,0,once);
	end
	print("Initialize_m01_00_00_00 end");
end

--[[
--�g�D���[�f�X���� --EN:--True death judgment
function OnEvent_9999990(proxy,param)
	print("OnEvent_9999990 begin");
	--proxy:DropItemExceedWeightLimit();
		--HpMpSpMax
	--proxy:PlayerParamRecover();
	proxy:PlayerRecover();
	print("OnEvent_9999990 end");
end
]]

--�����[�h�f�o�b�O�@�����_���Ŋe�}�b�v�� --EN:--Reload debug Randomly for each map
function OnEvent_DbgReLoad(proxy,param)
	local rand = proxy:GetRandom( 2,6 );
	--2�`6��3�ȊO�̓u���b�N0�� --EN:--All except 3 of 2 to 6 are in block 0
	if rand ~= 3 then
		--���S�񕜗v�� --EN:-- full recovery request
		proxy:RequestFullRecover();
		proxy:WarpNextStage( rand, 0, 0, 0, 999 );
	elseif rand == 3 then--3�̓u���b�N1�ɔ�� --EN:--3 jumps to block 1
		--���S�񕜗v�� --EN:-- full recovery request
		proxy:RequestFullRecover();
		proxy:WarpNextStage( rand, 1, 0, 0, 999 );
	end
end


--------------------------------------------------------------------------------------
--���e�G���A�փ��[�v(����)�� --EN:--�� Warp to each area (royal castle) ��
--------------------------------------------------------------------------------------
--��0���e�G���A�փ��[�v(����1)�� --EN:-- 0 �� Warp to each area (Castle 1) ��
--�V�������[�v���@ --EN:--New warp method
function OnEvent_0(proxy, param)
	print("OnEvent_0 begin");
	
	if proxy:IsCompleteEvent( 0 ) == true then
		print("OnEvent_0 end");
		return;
	end	
	proxy:SetEventFlag( 0, true );--���[�v���j���[�I���̑��d������h�~ON --EN:--Prevent multiple activations of warp menu selection ON
	
	local areaNum = 2;
	local blockNum = 1;
		
	--�����Ői�s�t���O�𔻒肵�ĕ\���u���b�N����ݒ肷�邱�� --EN:--Determine the progress flag here and set the number of display blocks
	if proxy:IsCompleteEvent(4103) == true then
		blockNum = 2;--����2�J�� --EN:--Open Castle 2
	end
	
	if proxy:IsCompleteEvent(4252) == true then
		blockNum = 3;--����3�J��		 --EN:--Open Castle 3
	end
	
	if proxy:IsCompleteEvent(4372) == true then
		blockNum = 4;--����4�J�� --EN:--Open Castle 4
	end
	
	if proxy:IsCompleteEvent(4503) == true then
		blockNum = 5;--����5�J�� --EN:--Open Castle 5
	end	
	
	proxy:RepeatMessage_begin();
		proxy:OnWarpMenuClose(0,"OnEvent_0_0",areaNum,blockNum,once);	
	proxy:RepeatMessage_end();
		
	print("OnEvent_0 end");
end


function OnEvent_0_0(proxy, param)
	print("OnEvent_0_0 begin");

	--���[�v���j���|�̑I�����擾 --EN:--get warp menu selection
	local retval = proxy:GetWarpMenuResult();
	
	--���[�v���L�����Z�����ꂽ�ꍇ�́A�A�j�����Đ����Ȃ� --EN:--Do not play animation if warp is canceled
	if retval == -1 then
		OnEvent_0_2(proxy, param);
		return;
	end
	
	proxy:WarpDmy( 10000 , 1000 , 191 );
	proxy:PlayAnimation( 10000 , 8283 );--�v�΂ɐG���A�j�����Đ� --EN:--Play the animation that touches the keystone
	
	proxy:NotNetMessage_begin();
		--���v�΂ɐG���A�j���Đ��I���� --EN:--��Animation touching the keystone ends��
		proxy:OnChrAnimEnd( SYSTEM_WARP , 10000 , 8283 , "OnEvent_0_1" , once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_0_0 end");
end

--��0_1���v�΂ɐG���A�j���Đ��I���� --EN:--��0_1��Ends playing the animation touching the keystone��
function OnEvent_0_1(proxy,param)
	print("OnEvent_0_1 begin");
	
	proxy:PlayAnimation( 10000 , 8284 );--�����E�ɋA��A�j�����Đ� --EN:--Play animation to return to your own world
	
	--�ҋ@�A�j���҂��������Ȃ����̂Œ��ڌĂяo�� --EN:--Since there is no longer a waiting animation, call it directly
	OnEvent_0_2(proxy,param);
	--[[
	proxy:NotNetMessage_begin();
		--�������E�ɋA��A�j���Đ��I���� --EN:--��End of animation playback to return to your own world��
		proxy:OnChrAnimEnd( SYSTEM_WARP , 10000 , 8284 , "OnEvent_0_2" , once );
	proxy:NotNetMessage_end();
	]]
	print("OnEvent_0_1 end");
end


function OnEvent_0_2(proxy,param)
	print("OnEvent_0_2 begin");
	
	proxy:SetEventFlag( 0, false );--���[�v���j���[�I���̑��d������h�~OFF --EN:--Prevent multiple activations of warp menu selection OFF

	--���[�v���j���|�̑I�����擾 --EN:--get warp menu selection
	local retval = proxy:GetWarpMenuResult();
	if retval == -1 then
		print("Warp Cancel");
		print("OnEvent_0_2 end");
		return;
	elseif retval == 0 then
		--���S�񕜗v�� --EN:-- full recovery request
		proxy:RequestFullRecover();
		proxy:WarpNextStage( 2, 0, 0, 0, 999 );
		SetNpcStateFlag(proxy,param, warp_list , GO_TO_WARP_OUJOU );
		print("Warp Block1");
		print("OnEvent_0_2 end");
		return;
	elseif retval == 1 then
		--���S�񕜗v�� --EN:-- full recovery request
		proxy:RequestFullRecover();
		proxy:WarpNextStage( 2, 0, 0, 0, 998 );
		SetNpcStateFlag(proxy,param, warp_list , GO_TO_WARP_OUJOU );
		print("Warp Block2");
		print("OnEvent_0_2 end");
		return;
	elseif retval == 2 then
		--���S�񕜗v�� --EN:-- full recovery request
		proxy:RequestFullRecover();
		proxy:WarpNextStage( 2, 1, 0, 0, 997 );
		SetNpcStateFlag(proxy,param, warp_list , GO_TO_WARP_OUJOU );
		print("Warp Block3");
		print("OnEvent_0_2 end");
		return;
	elseif retval == 3 then
		--���S�񕜗v�� --EN:-- full recovery request
		proxy:RequestFullRecover();
		proxy:WarpNextStage( 2, 2, 0, 0, 996 );
		SetNpcStateFlag(proxy,param, warp_list , GO_TO_WARP_OUJOU );
		print("Warp Block4");
		print("OnEvent_0_2 end");
		return;		
	elseif retval == 4 then
		--���S�񕜗v�� --EN:-- full recovery request
		proxy:RequestFullRecover();
		proxy:WarpNextStage( 2, 3, 0, 0, 995 );
		SetNpcStateFlag(proxy,param, warp_list , GO_TO_WARP_OUJOU );
		print("Warp Block5");
		print("OnEvent_0_2 end");
		return;
	end
	print("retval Error");
	print("OnEvent_0_2 end");
end


--------------------------------------------------------------------------------------
--���e�G���A�փ��[�v(�Í�)�� --EN:--�� Warp to each area (old fort) ��
--------------------------------------------------------------------------------------
--��1���e�G���A�փ��[�v(�Í�2)�� --EN:--�� 1 �� Warp to each area (old fort 2) ��
--�V�������[�v���@ --EN:--New warp method
function OnEvent_1(proxy,param)
	print("OnEvent_1 begin");

	if proxy:IsCompleteEvent( 1 ) == true then
		print("OnEvent_1 end");
		return;
	end
	
	if proxy:IsCompleteEvent( 8030 ) == false then
		--����C���t�H���[�V����		 --EN:--Seal information
		--proxy:InfomationMenu( INFOMENU_TYPE_SIMPLE, 0, MSG_CATEGORY_EVENT, 10010190, 1);
		--proxy:ShowGenDialog(10010190,1,1,true);
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010190, 0, 6, 1001, GEN_DIALOG_DIST, once );
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
		print("OnEvent_1 end");
		return;
	end
	
	proxy:SetEventFlag( 1, true );--���[�v���j���[�I���̑��d������h�~ON	 --EN:--Prevent multiple activations of warp menu selection ON
	
	local areaNum = 3;
	local blockNum = 1;
		
	--�����Ői�s�t���O�𔻒肵�ĕ\���u���b�N����ݒ肷�邱�� --EN:--Determine the progress flag here and set the number of display blocks
	if proxy:IsCompleteEvent(4804) == true then
		blockNum = 2;--�Í�2�J�� --EN:--Open Fort 2
	end
	
	if proxy:IsCompleteEvent(4874) == true then
		blockNum = 3;--�Í�3�J��		 --EN:--Open Fort 3
	end
	
	if proxy:IsCompleteEvent(4996) == true then
		blockNum = 4;--�Í�4�J��		 --EN:--Open Fort 4
	end	
	
	proxy:RepeatMessage_begin();
		proxy:OnWarpMenuClose(1,"OnEvent_1_0",areaNum,blockNum,once);	
	proxy:RepeatMessage_end();
	
	print("OnEvent_1 end");
end


function OnEvent_1_0(proxy, param)
	print("OnEvent_1_0 begin");

	--���[�v���j���|�̑I�����擾 --EN:--get warp menu selection
	local retval = proxy:GetWarpMenuResult();
	
	--���[�v���L�����Z�����ꂽ�ꍇ�́A�A�j�����Đ����Ȃ�	 --EN:--Do not play animation if warp is canceled
	if retval == -1 then
		OnEvent_1_2(proxy, param);
		return;
	end
	
	proxy:WarpDmy( 10000 , 1001 , 191 );
	proxy:PlayAnimation( 10000 , 8283 );--�v�΂ɐG���A�j�����Đ� --EN:--Play the animation that touches the keystone
	
	proxy:NotNetMessage_begin();
		--���v�΂ɐG���A�j���Đ��I���� --EN:--��Animation touching the keystone ends��
		proxy:OnChrAnimEnd( SYSTEM_WARP , 10000 , 8283 , "OnEvent_1_1" , once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_1_0 end");
end

--��1_1���v�΂ɐG���A�j���Đ��I���� --EN:--��1_1��End of animation playback where you touch the keystone��
function OnEvent_1_1(proxy, param)
	print("OnEvent_1_1 begin");
	proxy:PlayAnimation( 10000 , 8284 );--�����E�ɋA��A�j�����Đ� --EN:--Play animation to return to your own world
	
	--�ҋ@�A�j���҂��������Ȃ����̂Œ��ڌĂяo�� --EN:--Since there is no longer a waiting animation, call it directly
	OnEvent_1_2(proxy,param);
	--[[
	proxy:NotNetMessage_begin();
		--�������E�ɋA��A�j���Đ��I���� --EN:--��End of animation playback to return to your own world��
		proxy:OnChrAnimEnd( SYSTEM_WARP , 10000 , 8284 , "OnEvent_1_2" , once );
	proxy:NotNetMessage_end();
]]
	print("OnEvent_1_1 end");
end
	

function OnEvent_1_2(proxy, param)
	print("OnEvent_1_2 begin");
	
	proxy:SetEventFlag( 1, false );--���[�v���j���[�I���̑��d������h�~OFF --EN:--Prevent multiple activations of warp menu selection OFF
	
	--2008.05.06 toyohide �ÍԂ̃A�C�e�������C�x���g�p�̃A�N�V����ID�`�F�b�N --EN:--2008.05.06 toyohide action ID check for old fort item exchange event
	if proxy:IsCompleteEvent(12613) == true then
		proxy:SetEventFlag(12614,true);
	end
	
	--���[�v���j���|�̑I�����擾 --EN:--get warp menu selection
	local retval = proxy:GetWarpMenuResult();
	if retval == -1 then
		print("Warp Cancel");
		print("OnEvent_1_2 end");
		return;
	elseif retval == 0 then
		--���S�񕜗v�� --EN:-- full recovery request
		proxy:RequestFullRecover();
		proxy:WarpNextStage( 3, 1, 0, 0, 999 );
		SetNpcStateFlag(proxy,param, warp_list , GO_TO_WARP_FURUTORIDE );
		print("Warp Block1");
		print("OnEvent_1_2 end");
		return;
	elseif retval == 1 then
		--���S�񕜗v�� --EN:-- full recovery request
		proxy:RequestFullRecover();
		proxy:WarpNextStage( 3, 1, 0, 0, 997 );
		SetNpcStateFlag(proxy,param, warp_list , GO_TO_WARP_FURUTORIDE );
		print("Warp Block2");
		print("OnEvent_1_2 end");
		return;
	elseif retval == 2 then
		--���S�񕜗v�� --EN:-- full recovery request
		proxy:RequestFullRecover();
		proxy:WarpNextStage( 3, 2, 0, 0, 996 );
		SetNpcStateFlag(proxy,param, warp_list , GO_TO_WARP_FURUTORIDE );
		print("Warp Block3");
		print("OnEvent_1_2 end");
		return;	
	elseif retval == 3 then
		--���S�񕜗v�� --EN:-- full recovery request
		proxy:RequestFullRecover();
		proxy:WarpNextStage( 3, 3, 0, 0, 995 );
		SetNpcStateFlag(proxy,param, warp_list , GO_TO_WARP_FURUTORIDE );
		print("Warp Block4");
		print("OnEvent_1_2 end");
		return;	
	end
	print("retval Error");	
	print("OnEvent_1_2 end");
end

--------------------------------------------------------------------------------------
--���e�G���A�փ��[�v(�S��)�� --EN:--�� Warp to each area (prison castle) ��
--------------------------------------------------------------------------------------
--�V�������[�v --EN:-- new warp
function OnEvent_2(proxy,param)
	print("OnEvent_2 begin");

	if proxy:IsCompleteEvent( 2 ) == true then
		print("OnEvent_2 end");
		return;
	end
	
	if proxy:IsCompleteEvent( 8030 ) == false then
		--����C���t�H���[�V����		 --EN:--Seal information
		--proxy:InfomationMenu( INFOMENU_TYPE_SIMPLE, 0, MSG_CATEGORY_EVENT, 10010190, 1);
		--proxy:ShowGenDialog(10010190,1,1,true);
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010190, 0, 6, 1002, GEN_DIALOG_DIST, once );
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
		print("OnEvent_2 end");
		return;
	end
	proxy:SetEventFlag( 2, true );--���[�v���j���[�I���̑��d������h�~ON	 --EN:--Prevent multiple activations of warp menu selection ON
	
	local areaNum = 4;
	local blockNum = 1;
		
	--�����Ői�s�t���O�𔻒肵�ĕ\���u���b�N����ݒ肷�邱�� --EN:--Determine the progress flag here and set the number of display blocks
	if proxy:IsCompleteEvent(5121) == true then
		blockNum = 2;--�S��2�J�� --EN:--Open prison 2
	end
	
	if proxy:IsCompleteEvent(5261) == true then
		blockNum = 3;--�S��3�J��		 --EN:--Open prison 3
	end
	
	if proxy:IsCompleteEvent(5381) == true then
		blockNum = 4;--�S��4�J��	 --EN:--Open prison 4
	end
	
	proxy:RepeatMessage_begin();
		proxy:OnWarpMenuClose(2,"OnEvent_2_0",areaNum,blockNum,once);	
	proxy:RepeatMessage_end();
	
	print("OnEvent_2 begin");
end


function OnEvent_2_0(proxy, param)
	print("OnEvent_2_0 begin");

	--���[�v���j���|�̑I�����擾 --EN:--get warp menu selection
	local retval = proxy:GetWarpMenuResult();
	
	--���[�v���L�����Z�����ꂽ�ꍇ�́A�A�j�����Đ����Ȃ�	 --EN:--Do not play animation if warp is canceled
	if retval == -1 then
		OnEvent_2_2(proxy, param);
		return;
	end
	
	proxy:WarpDmy( 10000 , 1002 , 191 );
	proxy:PlayAnimation( 10000 , 8283 );--�v�΂ɐG���A�j�����Đ� --EN:--Play the animation that touches the keystone
	
	proxy:NotNetMessage_begin();
		--���v�΂ɐG���A�j���Đ��I���� --EN:--��Animation touching the keystone ends��
		proxy:OnChrAnimEnd( SYSTEM_WARP , 10000 , 8283 , "OnEvent_2_1" , once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_2_0 end");
end

--��2_1���v�΂ɐG���A�j���Đ��I���� --EN:--��2_1��End of animation playback where you touch the keystone��
function OnEvent_2_1(proxy, param)
	print("OnEvent_2_1 begin");	

	proxy:PlayAnimation( 10000 , 8284 );--�����E�ɋA��A�j�����Đ� --EN:--Play animation to return to your own world
	
	--�ҋ@�A�j���҂��������Ȃ����̂Œ��ڌĂяo�� --EN:--Since there is no longer a waiting animation, call it directly
	OnEvent_2_2(proxy,param);
	--[[
	proxy:NotNetMessage_begin();
		--�������E�ɋA��A�j���Đ��I���� --EN:--��End of animation playback to return to your own world��
		proxy:OnChrAnimEnd( SYSTEM_WARP, 10000 , 8284 , "OnEvent_2_2" , once );
	proxy:NotNetMessage_end();
	]]
	print("OnEvent_2_1 end");
end

--��2���e�G���A�փ��[�v(�S��1)�� --EN:-- 2 �� Warp to each area (Prison Castle 1) ��
function OnEvent_2_2(proxy, param)
	print("OnEvent_2_2 begin");		
	
	proxy:SetEventFlag( 2, false );--���[�v���j���[�I���̑��d������h�~OFF	 --EN:--Prevent multiple activations of warp menu selection OFF
	
	--���[�v���j���|�̑I�����擾 --EN:--get warp menu selection
	local retval = proxy:GetWarpMenuResult();
	if retval == -1 then
		print("Warp Cancel");
		print("OnEvent_2_2 end");
		return;
	elseif retval == 0 then
		--���S�񕜗v�� --EN:-- full recovery request
		proxy:RequestFullRecover();
		proxy:WarpNextStage( 4, 0, 0, 0, 999 );
		SetNpcStateFlag(proxy,param, warp_list , GO_TO_WARP_ROUJOU );
		print("Warp Block1");
		print("OnEvent_2_2 end");
		return;
	elseif retval == 1 then
		--���S�񕜗v�� --EN:-- full recovery request
		proxy:RequestFullRecover();
		proxy:WarpNextStage( 4, 1, 0, 0, 998 );
		SetNpcStateFlag(proxy,param, warp_list , GO_TO_WARP_ROUJOU );
		print("Warp Block2");
		print("OnEvent_2_2 end");
		return;
	elseif retval == 2 then
		--���S�񕜗v�� --EN:-- full recovery request
		proxy:RequestFullRecover();
		proxy:WarpNextStage( 4, 1, 0, 0, 997 );
		SetNpcStateFlag(proxy,param, warp_list , GO_TO_WARP_ROUJOU );
		print("Warp Block3");
		print("OnEvent_2_2 end");
		return;	
	elseif retval == 3 then
		--���S�񕜗v�� --EN:-- full recovery request
		proxy:RequestFullRecover();
		proxy:WarpNextStage( 4, 2, 0, 0, 996 );
		SetNpcStateFlag(proxy,param, warp_list , GO_TO_WARP_ROUJOU );
		print("Warp Block4");
		print("OnEvent_2_2 end");
		return;	
	end
	print("retval Error");		
	print("OnEvent_2_2 end");
end



--------------------------------------------------------------------------------------
--���e�G���A�փ��[�v(�s��)�� --EN:-- �� Warp to each area (unclean) ��
--------------------------------------------------------------------------------------
--�V�������[�v --EN:-- new warp
function OnEvent_3(proxy,param)
	print("OnEvent_3 begin");

	if proxy:IsCompleteEvent( 3 ) == true then
		print("OnEvent_3 end");
		return;
	end
	
	if proxy:IsCompleteEvent( 8030 ) == false then
		--����C���t�H���[�V����		 --EN:--Seal information
		--proxy:InfomationMenu( INFOMENU_TYPE_SIMPLE, 0, MSG_CATEGORY_EVENT, 10010190, 1);
		--proxy:ShowGenDialog(10010190,1,1,true);
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010190, 0, 6, 1003, GEN_DIALOG_DIST, once );
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
		print("OnEvent_3 end");
		return;
	end
	
	proxy:SetEventFlag( 3, true );--���[�v���j���[�I���̑��d������h�~ON	 --EN:--Prevent multiple activations of warp menu selection ON
	
	local areaNum = 5;
	local blockNum = 1;
		
	--�����Ői�s�t���O�𔻒肵�ĕ\���u���b�N����ݒ肷�邱�� --EN:--Determine the progress flag here and set the number of display blocks
	if proxy:IsCompleteEvent(5653) == true then
		blockNum = 2;--�s��2�J�� --EN:-- Unclean 2 open
	end
	
	if proxy:IsCompleteEvent(5773) == true then
		blockNum = 3;--�s��3�J��		 --EN:-- Unclean 3 open
	end
	
	if proxy:IsCompleteEvent(5893) == true then
		blockNum = 4;--�s��4�J��		 --EN:--Unholy 4 open
	end	
	
	proxy:RepeatMessage_begin();
		proxy:OnWarpMenuClose(3,"OnEvent_3_0",areaNum,blockNum,once);	
	proxy:RepeatMessage_end();	
	
	print("OnEvent_3 end");
end


function OnEvent_3_0(proxy, param)
	print("OnEvent_3_0 begin");

	--���[�v���j���|�̑I�����擾 --EN:--get warp menu selection
	local retval = proxy:GetWarpMenuResult();
	
	--���[�v���L�����Z�����ꂽ�ꍇ�́A�A�j�����Đ����Ȃ�	 --EN:--Do not play animation if warp is canceled
	if retval == -1 then
		OnEvent_3_2(proxy, param);
		return;
	end
	
	proxy:WarpDmy( 10000 , 1003 , 191 );
	proxy:PlayAnimation( 10000 , 8283 );--�v�΂ɐG���A�j�����Đ� --EN:--Play the animation that touches the keystone
	
	proxy:NotNetMessage_begin();
		--���v�΂ɐG���A�j���Đ��I���� --EN:--��Animation touching the keystone ends��
		proxy:OnChrAnimEnd( SYSTEM_WARP , 10000 , 8283 , "OnEvent_3_1" , once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_3_0 end");
end

--��3_1���v�΂ɐG���A�j���Đ��I���� --EN:--��3_1��End of animation playback where you touch the keystone��
function OnEvent_3_1(proxy, param)
	print("OnEvent_3_1 begin");
	
	proxy:PlayAnimation( 10000 , 8284 );--�����E�ɋA��A�j�����Đ� --EN:--Play animation to return to your own world
	
	--�ҋ@�A�j���҂��������Ȃ����̂Œ��ڌĂяo�� --EN:--Since there is no longer a waiting animation, call it directly
	OnEvent_3_2(proxy,param);
	--[[
	proxy:NotNetMessage_begin();
		--�������E�ɋA��A�j���Đ��I���� --EN:--��End of animation playback to return to your own world��
		proxy:OnChrAnimEnd( SYSTEM_WARP , 10000 , 8284 , "OnEvent_3_2" , once );
	proxy:NotNetMessage_end();
	]]
	print("OnEvent_3_1 end");
end

--��3���e�G���A�փ��[�v(�s��)�� --EN:-- 3 �� Warp to each area (unclean) ��
function OnEvent_3_2(proxy, param)
	print("OnEvent_3_2 begin");		

	proxy:SetEventFlag( 3, false );--���[�v���j���[�I���̑��d������h�~OFF --EN:--Prevent multiple activations of warp menu selection OFF

	--���[�v���j���|�̑I�����擾 --EN:--get warp menu selection
	local retval = proxy:GetWarpMenuResult();
	if retval == -1 then
		print("Warp Cancel");
		print("OnEvent_3_2 end");
		return;
	elseif retval == 0 then
		--���S�񕜗v�� --EN:-- full recovery request
		proxy:RequestFullRecover();
		proxy:WarpNextStage( 5, 0, 0, 0, 999 );
		SetNpcStateFlag(proxy,param, warp_list , GO_TO_WARP_FUJOU );
		print("Warp Block1");
		print("OnEvent_3_2 end");
		return;
	elseif retval == 1 then		
		--���S�񕜗v�� --EN:-- full recovery request
		proxy:RequestFullRecover();
		proxy:WarpNextStage( 5, 0, 0, 0, 998 );
		SetNpcStateFlag(proxy,param, warp_list , GO_TO_WARP_FUJOU );
		print("Warp Block2");
		print("OnEvent_3_2 end");
		return;
	elseif retval == 2 then
		--���S�񕜗v�� --EN:-- full recovery request
		proxy:RequestFullRecover();
		proxy:WarpNextStage( 5, 1, 0, 0, 997 );
		SetNpcStateFlag(proxy,param, warp_list , GO_TO_WARP_FUJOU );
		print("Warp Block3");
		print("OnEvent_3_2 end");
		return;	
	elseif retval == 3 then
		--���S�񕜗v�� --EN:-- full recovery request
		proxy:RequestFullRecover();
		proxy:WarpNextStage( 5, 2, 0, 0, 996 );
		SetNpcStateFlag(proxy,param, warp_list , GO_TO_WARP_FUJOU );
		print("Warp Block4");
		print("OnEvent_3_2 end");
		return;	
	end
	print("retval Error");			
	print("OnEvent_3_2 end");
end


--------------------------------------------------------------------------------------
--���e�G���A�փ��[�v(�B��)�� --EN:--�� Warp to each area (pit) ��
--------------------------------------------------------------------------------------
function OnEvent_4(proxy,param)
	print("OnEvent_4 begin");

	if proxy:IsCompleteEvent( 4 ) == true then
		print("OnEvent_4 end");
		return;
	end
	
	if proxy:IsCompleteEvent( 8030 ) == false then
		--����C���t�H���[�V����		 --EN:--Seal information
		--proxy:InfomationMenu( INFOMENU_TYPE_SIMPLE, 0, MSG_CATEGORY_EVENT, 10010190, 1);
		--proxy:ShowGenDialog(10010190,1,1,true);
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010190, 0, 6, 1004, GEN_DIALOG_DIST, once );
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
		print("OnEvent_4 end");
		return;
	end	
	
	proxy:SetEventFlag( 4, true );--���[�v���j���[�I���̑��d������h�~ON		 --EN:--Prevent multiple activations of warp menu selection ON
	
	local areaNum = 6;
	local blockNum = 1;
	
	--�����Ői�s�t���O�𔻒肵�ĕ\���u���b�N����ݒ肷�邱�� --EN:--Determine the progress flag here and set the number of display blocks
	if proxy:IsCompleteEvent(6193) == true then
		blockNum = 2;--�B��2�J�� --EN:-- Tunnel 2 open
	end
	
	if proxy:IsCompleteEvent(6283) == true then
		blockNum = 3;--�B��3�J��		 --EN:-- Tunnel 3 open
	end
	
	if proxy:IsCompleteEvent(6403) == true then
		blockNum = 4;--�B��4�J��		 --EN:-- Tunnel 4 open
	end	
	
	proxy:RepeatMessage_begin();
		proxy:OnWarpMenuClose(4,"OnEvent_4_0",areaNum,blockNum,once);	
	proxy:RepeatMessage_end();	
	
	print("OnEvent_4 end");
end


function OnEvent_4_0(proxy, param)
	print("OnEvent_4_0 begin");

	--���[�v���j���|�̑I�����擾 --EN:--get warp menu selection
	local retval = proxy:GetWarpMenuResult();
	
	--���[�v���L�����Z�����ꂽ�ꍇ�́A�A�j�����Đ����Ȃ�	 --EN:--Do not play animation if warp is canceled
	if retval == -1 then
		OnEvent_4_2(proxy, param);
		return;
	end
	
	proxy:WarpDmy( 10000 , 1004 , 191 );
	proxy:PlayAnimation( 10000 , 8283 );--�v�΂ɐG���A�j�����Đ� --EN:--Play the animation that touches the keystone
	
	proxy:NotNetMessage_begin();
		--���v�΂ɐG���A�j���Đ��I���� --EN:--��Animation touching the keystone ends��
		proxy:OnChrAnimEnd( SYSTEM_WARP , 10000 , 8283 , "OnEvent_4_1" , once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_4_0 end");
end


--��4_1���v�΂ɐG���A�j���Đ��I���� --EN:--��4_1��End of playing the animation touching the keystone��
function OnEvent_4_1(proxy, param)
	print("OnEvent_4_1 begin");		

	proxy:PlayAnimation( 10000 , 8284 );--�����E�ɋA��A�j�����Đ� --EN:--Play animation to return to your own world
	
	--�ҋ@�A�j���҂��������Ȃ����̂Œ��ڌĂяo�� --EN:--Since there is no longer a waiting animation, call it directly
	OnEvent_4_2(proxy,param);
	--[[
	proxy:NotNetMessage_begin();
		--�������E�ɋA��A�j���Đ��I���� --EN:--��End of animation playback to return to your own world��
		proxy:OnChrAnimEnd( SYSTEM_WARP , 10000 , 8284 , "OnEvent_4_2" , once );
	proxy:NotNetMessage_end();
	]]
	print("OnEvent_4_1 end");
end


--��4���e�G���A�փ��[�v(�B��1)�� --EN:-- 4 �� Warp to each area (Tunnel 1) ��
function OnEvent_4_2(proxy, param)
	print("OnEvent_4_2 begin");		

	proxy:SetEventFlag( 4, false );--���[�v���j���[�I���̑��d������h�~OFF --EN:--Prevent multiple activations of warp menu selection OFF

	--���[�v���j���|�̑I�����擾 --EN:--get warp menu selection
	local retval = proxy:GetWarpMenuResult();
	if retval == -1 then
		print("Warp Cancel");
		print("OnEvent_4_2 end");
		return;
	elseif retval == 0 then
		--���S�񕜗v�� --EN:-- full recovery request
		proxy:RequestFullRecover();
		proxy:WarpNextStage( 6, 0, 0, 0, 999 );
		SetNpcStateFlag(proxy,param, warp_list , GO_TO_WARP_KOUDOU );
		print("Warp Block1");
		print("OnEvent_4_2 end");
		return;
	elseif retval == 1 then
		--���S�񕜗v�� --EN:-- full recovery request
		proxy:RequestFullRecover();
		proxy:WarpNextStage( 6, 0, 0, 0, 998 );
		SetNpcStateFlag(proxy,param, warp_list , GO_TO_WARP_KOUDOU );
		print("Warp Block2");
		print("OnEvent_4_2 end");
		return;
	elseif retval == 2 then
		--���S�񕜗v�� --EN:-- full recovery request
		proxy:RequestFullRecover();
		proxy:WarpNextStage( 6, 1, 0, 0, 997 );
		SetNpcStateFlag(proxy,param, warp_list , GO_TO_WARP_KOUDOU );
		print("Warp Block3");
		print("OnEvent_4_2 end");
		return;	
	elseif retval == 3 then
		--���S�񕜗v�� --EN:-- full recovery request
		proxy:RequestFullRecover();
		proxy:WarpNextStage( 6, 2, 0, 0, 996 );
		SetNpcStateFlag(proxy,param, warp_list , GO_TO_WARP_KOUDOU );
		print("Warp Block4");
		print("OnEvent_4_2 end");
		return;
	end
	print("retval Error");	
	print("OnEvent_4_2 end");
end


--
--------------------------------------------------------------------------------------
--���e�G���A�փ��[�v(�k��)�� --EN:--�� Warp to each area (northern limit) ��
--------------------------------------------------------------------------------------
function OnEvent_5(proxy,param)
	print("OnEvent_5 begin");

	if proxy:IsCompleteEvent( 5 ) == true then
		print("OnEvent_5 end");
		return;
	end
	
	local bflag = false;
	if bflag == false then
		--����C���t�H���[�V����		 --EN:--Seal information
		--proxy:InfomationMenu( INFOMENU_TYPE_SIMPLE, 0, MSG_CATEGORY_EVENT, 10010190, 1);
		--proxy:ShowGenDialog(10010190,1,1,true);
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010190, 0, 6, 1005, GEN_DIALOG_DIST, once );
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
		print("OnEvent_5 end");
		--�k���͕��󂪉����܂��� --EN:--Northern limit cannot be unsealed
		return;
	end
	proxy:SetEventFlag( 5, true );--���[�v���j���[�I���̑��d������h�~ON		 --EN:--Prevent multiple activations of warp menu selection ON
	
	local areaNum = 7;
	local blockNum = 1;
	
	--�����Ői�s�t���O�𔻒肵�ĕ\���u���b�N����ݒ肷�邱�� --EN:--Determine the progress flag here and set the number of display blocks
	--[[
	if proxy:IsCompleteEvent(6193) == true then
		blockNum = 2;--�B��2�J�� --EN:-- Tunnel 2 open
	end
	
	if proxy:IsCompleteEvent(6283) == true then
		blockNum = 3;--�B��3�J��		 --EN:-- Tunnel 3 open
	end
	
	if proxy:IsCompleteEvent(6403) == true then
		blockNum = 4;--�B��4�J��		 --EN:-- Tunnel 4 open
	end	
	]]
	proxy:RepeatMessage_begin();
		proxy:OnWarpMenuClose(5,"OnEvent_5_0",areaNum,blockNum,once);	
	proxy:RepeatMessage_end();	
	
	print("OnEvent_5 end");
end


function OnEvent_5_0(proxy, param)
	print("OnEvent_5_0 begin");

	--���[�v���j���|�̑I�����擾 --EN:--get warp menu selection
	local retval = proxy:GetWarpMenuResult();
	
	--���[�v���L�����Z�����ꂽ�ꍇ�́A�A�j�����Đ����Ȃ�	 --EN:--Do not play animation if warp is canceled
	if retval == -1 then
		OnEvent_5_2(proxy, param);
		return;
	end
	
	--proxy:WarpDmy( 10000 , 1004 , 191 );
	proxy:PlayAnimation( 10000 , 8283 );--�v�΂ɐG���A�j�����Đ� --EN:--Play the animation that touches the keystone
	
	proxy:NotNetMessage_begin();
		--���v�΂ɐG���A�j���Đ��I���� --EN:--��Animation touching the keystone ends��
		proxy:OnChrAnimEnd( SYSTEM_WARP , 10000 , 8283 , "OnEvent_5_1" , once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_5_0 end");
end


--��5_1���v�΂ɐG���A�j���Đ��I���� --EN:--��5_1��End of animation playback where you touch the keystone��
function OnEvent_5_1(proxy, param)
	print("OnEvent_5_1 begin");		

	proxy:PlayAnimation( 10000 , 8284 );--�����E�ɋA��A�j�����Đ� --EN:--Play animation to return to your own world
	
	--�ҋ@�A�j���҂��������Ȃ����̂Œ��ڌĂяo�� --EN:--Since there is no longer a waiting animation, call it directly
	OnEvent_5_2(proxy,param);
	--[[
	proxy:NotNetMessage_begin();
		--�������E�ɋA��A�j���Đ��I���� --EN:--��End of animation playback to return to your own world��
		proxy:OnChrAnimEnd( SYSTEM_WARP , 10000 , 8284 , "OnEvent_4_2" , once );
	proxy:NotNetMessage_end();
	]]
	print("OnEvent_5_1 end");
end


--��4���e�G���A�փ��[�v(�k��)�� --EN:-- 4 �� Warp to each area (northern limit) ��
function OnEvent_5_2(proxy, param)
	print("OnEvent_5_2 begin");		

	proxy:SetEventFlag( 5, false );--���[�v���j���[�I���̑��d������h�~OFF --EN:--Prevent multiple activations of warp menu selection OFF

	--���[�v���j���|�̑I�����擾 --EN:--get warp menu selection
	local retval = proxy:GetWarpMenuResult();
	if retval == -1 then
		print("Warp Cancel");
		print("OnEvent_5_2 end");
		return;
	elseif retval == 0 then
		--���S�񕜗v�� --EN:-- full recovery request
		--proxy:RequestFullRecover();
		--proxy:WarpNextStage( 6, 0, 0, 0, 999 );
		--SetNpcStateFlag(proxy,param, warp_list , GO_TO_WARP_HOKUGEN );
		print("Warp Block1");
		print("OnEvent_5_2 end");
		return;
	elseif retval == 1 then
		--���S�񕜗v�� --EN:-- full recovery request
		--proxy:RequestFullRecover();
		--proxy:WarpNextStage( 6, 0, 0, 0, 998 );
		--SetNpcStateFlag(proxy,param, warp_list , GO_TO_WARP_HOKUGEN );
		print("Warp Block2");
		print("OnEvent_5_2 end");
		return;
	elseif retval == 2 then
		--���S�񕜗v�� --EN:-- full recovery request
		--proxy:RequestFullRecover();
		--proxy:WarpNextStage( 6, 0, 0, 0, 997 );
		--SetNpcStateFlag(proxy,param, warp_list , GO_TO_WARP_HOKUGEN );
		print("Warp Block3");
		print("OnEvent_5_2 end");
		return;	
	elseif retval == 3 then
		--���S�񕜗v�� --EN:-- full recovery request
		--proxy:RequestFullRecover();
		--proxy:WarpNextStage( 6, 0, 0, 0, 996 );
		--SetNpcStateFlag(proxy,param, warp_list , GO_TO_WARP_HOKUGEN );
		print("Warp Block4");
		print("OnEvent_5_2 end");
		return;
	end
	print("retval Error");	
	print("OnEvent_5_2 end");
end
--

--------------------------------------------------------------------------------------
--�p�j�f�[�����̓o�ꁡ20 --EN:-- Appearance of the Wandering Demon 20
--------------------------------------------------------------------------------------

--���O���[�o���̎��S�Ď�����Ă΂��(�\��) --EN:--�� Called from global death watch (solo)
function PlayerDeath_m01_00_00_00(proxy, param)
	print("PlayerDeath_m01_00_00_00");
	
	LuaFunc_VisibleTheWanderingDemon(proxy, param, demon_id_list_m01_00_00_00);
	proxy:SetEventFlag( 20 , 1 );
	
	print("PlayerDeath_m01_00_00_00");
end

--���O���[�o���̌�������������Ă΂��(�\��) --EN:--��Called from global blood letter revival (solo)
function PlayerRevive_m01_00_00_00(proxy,param)
	print("PlayerRevive_m01_00_00_00");
	
	LuaFunc_InvisibleTheWanderingDemon(proxy, param, demon_id_list_m01_00_00_00);
	proxy:SetEventFlag( 20 , 0 );
	
	print("PlayerRevive_m01_00_00_00");
end



--------------------------------------------------------------------------------------
--��30���}�b�v�Љ�|�����Đ��� --EN:--��30��Map Introduction Polyplay Playback��
--------------------------------------------------------------------------------------

function OnEvent_30(proxy , param)
	print("OnEvent_30 begin");

	--���}�b�v�Љ�|�����Đ� --EN:--�� Map introduction Poly drama playback
	proxy:RequestRemo(00010,REMO_FLAG,30,1);
	proxy:SetEventFlag( 30, true );

	print("OnEvent_30 end");
end


--���|�����Đ��J�n(�t�F�[�h�I��) --EN:--�� Start of polyplay playback (end of fade)
function OnEvent_30_RemoStart(proxy,param)
	print("OnEvent_30_RemoStart begin");
	--Map�������ꎞ�I�ɖ����� --EN:--Map moyamoya temporarily disabled
	proxy:InvalidSfx( 2110 , false );
	print("OnEvent_30_RemoStart end");
end


--���|�����Đ��I��(�t�F�[�h�I��) --EN:-- End of polyplay playback (end of fade)
function OnEvent_30_RemoFinish(proxy , param)
	print("OnEvent_30_RemoFinish begin");
	--�Β�BGM���Đ� --EN:-- Play stone pillar BGM
	PlayBGM_SEKITYUU(proxy, param);
	print("�Β�BGM�Đ�"); --EN:print("Stone pillar BGM playback");
	
	--PC�̏����ʒu���ŏ������ύX --EN:--Change the initial position of the PC only at the beginning
	proxy:Warp( 10000 , 1205 );
	proxy:CamReset( 10000 , true );--�J�������Z�b�g --EN:--camera reset
	
	if proxy:GetClearCount() == 0 then		
		proxy:OnKeyTime2( 32 , "OnEvent_32",0.1,0,0,once);
	else
		--2���ڈȍ~�A�N���A�A�C�e���t���OON --EN:--After the 2nd lap, the clear item flag is ON
		if proxy:IsClearItem() == true then
			if proxy:GetClearState() == CLEAR_STATE_GOODEND then
				proxy:OnKeyTime2( 32,"OnEvent_GoodSoul",0.0,0,10,once);
			elseif proxy:GetClearState() == CLEAR_STATE_BADEND then
				proxy:OnKeyTime2( 32,"OnEvent_BadSoul",0.0,0,20,once);
			end		
		end
	end
	
	--�������SFX�Đ� --EN:--Moyamoya SFX playback
	proxy:ValidSfx( 2110 );
	print("OnEvent_30_RemoFinish end");
end


--------------------------------------------------------------------------------------
--��31�������|�����Đ��� --EN:-- �� 31 �� Resurrection poly play playback ��
--------------------------------------------------------------------------------------
function OnEvent_31(proxy , param)
	print("OnEvent_31 begin");

	--���}�b�v�Љ�|�����Đ� --EN:--�� Map introduction Poly drama playback
	proxy:RequestRemo(000015,REMO_FLAG,31,1);
	proxy:SetEventFlag( 31, true );

	print("OnEvent_31 end");
end


--���|�����Đ��J�n(�t�F�[�h�I��) --EN:--�� Start of polyplay playback (end of fade)
function OnEvent_31_RemoStart(proxy,param)
	print("OnEvent_31_RemoStart begin");	
	print("OnEvent_31_RemoStart end");
end


--���|�����Đ��I��(�t�F�[�h�I��) --EN:-- End of polyplay playback (end of fade)
function OnEvent_31_RemoFinish(proxy , param)
	print("OnEvent_31_RemoFinish begin");
	--�Β�BGM���Đ� --EN:-- Play stone pillar BGM
	PlayBGM_SEKITYUU(proxy, param);
	print("�Β�BGM�Đ�"); --EN:print("Stone pillar BGM playback");
	
	--�q���C�����W���킹 --EN:--Heroine Coordinate Alignment
	proxy:Warp( 615 , 2206 );
	proxy:SetSpStayAndDamageAnimId( 615 , -1 , -1 );

	print("OnEvent_31_RemoFinish end");
end


--------------------------------------------------------------------------------------
--��39�������w�J���|������ --EN:-- 39 �� magic square open poly play ��
--------------------------------------------------------------------------------------
function OnEvent_39(proxy,param)
	--�������w�J���|���� --EN:--��Magic square opening poly play
	proxy:RequestRemo(000006,REMO_FLAG,39,1);
	proxy:SetEventFlag( 39, true );
end

--���|�����Đ��J�n(�t�F�[�h�I��) --EN:--�� Start of polyplay playback (end of fade)
function OnEvent_39_RemoStart(proxy,param)
	print("OnEvent_39_RemoStart begin");	
	print("OnEvent_39_RemoStart end");
end


--���|�����Đ��I��(�t�F�[�h�I��) --EN:-- End of polyplay playback (end of fade)
function OnEvent_39_RemoFinish(proxy , param)
	print("OnEvent_39_RemoFinish begin");
	--�Β�BGM���Đ� --EN:-- Play stone pillar BGM
	PlayBGM_SEKITYUU(proxy, param);
	print("�Β�BGM�Đ�"); --EN:print("Stone pillar BGM playback");
		
	proxy:SetDrawEnable( 1190 , false );--��OBJ�\��OFF --EN:--Sword OBJ display OFF
	proxy:SetColiEnable( 1190 , false );--��OBJ�A�^��OFF --EN:--Sword OBJ Atari OFF
		
	proxy:SetDrawEnable( 1200 , false );--�����w1OBJ�\��OFF --EN:--Magic square 1 OBJ display OFF
	proxy:SetColiEnable( 1200 , false );--�����w1OBJ�A�^��OFF --EN:--Magic Square 1 OBJ Atari OFF
	proxy:SetDrawEnable( 1201 , false );--�����w2OBJ�\��OFF --EN:--Magic square 2 OBJ display OFF
	proxy:SetColiEnable( 1201 , false );--�����w2OBJ�A�^��OFF --EN:--Magic Square 2 OBJ Atari OFF
	proxy:SetDrawEnable( 1202 , false );--�����w3OBJ�\��OFF --EN:--Magic square 3 OBJ display OFF
	proxy:SetColiEnable( 1202 , false );--�����w3OBJ�A�^��OFF --EN:--Magic Square 3 OBJ Atari OFF
	proxy:SetDrawEnable( 1203 , false );--�����w4OBJ�\��OFF --EN:--Magic square 4 OBJ display OFF
	proxy:SetColiEnable( 1203 , false );--�����w4OBJ�A�^��OFF	 --EN:--Magic Square 4 OBJ Atari OFF
	
	proxy:SetEventResponsedNavimeshFlag_Disable();

	print("OnEvent_39_RemoFinish end");
end


--------------------------------------------------------------------------------------
--�C���t�H�\��:���S��1��32 --EN:--Information display: After death 1 �� 32
--------------------------------------------------------------------------------------
function OnEvent_32(proxy,param)
	print("OnEvent_32 begin");
	--Display_InfomationMenu_2(proxy, 0, -1, 30, 84000100, 1, -1, 30, 84000101, 7);
	proxy:RequestOpenBriefingMsgPlus( 84000101 , true );
	--Lua_PauseTutorial(proxy);	
	proxy:OnKeyTime2( 32 , "OnEvent_32_1",0.1,0,1,once);	
	print("OnEvent_32 end");
end

--�C���t�H���j���[�̕\�������҂� --EN:--Wait for the info menu to disappear
function OnEvent_32_1(proxy,param)
	print("OnEvent_32_1 begin");
	proxy:OnRegistFunc( 32 , "Check_32_2","OnEvent_32_2",1,once);
	--proxy:SetEventFlag( 32 , true );	
	print("OnEvent_32_1 end");
end

--�`�F�b�N --EN:--check
function Check_32_2(proxy)
	if proxy:IsShowMenu_BriefingMsg() == true then
		return false;
	end
	return true;
end

--�C���t�H���j���[���������玟�̃C���t�H���o�� --EN:--When the info menu is cleared, the next info is displayed
function OnEvent_32_2(proxy,param)
	print("OnEvent_32_2 begin");
	proxy:OnKeyTime2( 33 , "OnEvent_33",0.1,0,0,once);
	print("OnEvent_32_2 end");
end

--���S��Q�@ --EN:--2 after death
function OnEvent_33(proxy,param)
	print("OnEvent_33 begin");
	--Display_InfomationMenu_2(proxy, 0, -1, 30, 84000110, 1, -1, 30, 84000111, 6);
	proxy:RequestOpenBriefingMsgPlus( 84000111 , true );
	proxy:OnKeyTime2( 33 , "OnEvent_33_1", 0.1 , 0 , 20, once);
	--Lua_PauseTutorial(proxy);	
	--proxy:SetEventFlag( 33 , true );
	print("OnEvent_33 end");
end

--�҂� --EN:--Wait
function OnEvent_33_1(proxy,param)
	print("OnEvent_33_1 begin");
	proxy:OnRegistFunc( 37 , "Check_37","OnEvent_37",0,once);
	print("OnEvent_33_1 end");
end

--���j���[������̑҂� --EN:--Wait for the menu to disappear
function Check_37(proxy)
	if proxy:IsShowMenu_BriefingMsg() == true then
		return false;
	end
	return true;
end

--�C���t�H���j���[���������烏�[�v�A�C�e������ --EN:-- Get warp items when the info menu disappears
function OnEvent_37(proxy,param)
	print("OnEvent_37 begin");
	proxy:GetRateItem( 10860 );
	proxy:SetEventFlag( 37 , true );
	print("OnEvent_37 end");
end

--GOOD�N���A�\�E���擾 --EN:--Get GOOD Clear Soul
function OnEvent_GoodSoul(proxy,param)
	print("OnEvent_GoodSoul begin");
	proxy:SetClearItem(false);
	proxy:GetRateItem( 10900 );	
	print("OnEvent_GoodSoul end");
end

--BAD�N���A�\�E���擾 --EN:--BAD clear soul acquisition
function OnEvent_BadSoul(proxy,param)
	print("OnEvent_BadSoul begin");
	proxy:SetClearItem(false);
	proxy:GetRateItem( 10901 );	
	if proxy:IsInventoryEquip(TYPE_GOODS,9996) == false then	
		proxy:GetRateItem( 10902 );	
	end
	print("OnEvent_BadSoul end");
end

--------------------------------------------------------------------------------------
--��40�����X�{�X�����ɍs���܂ł̔�э~��A�|������ --EN:--�� 40 �� jumping down to go to the final boss room, police drama ��
--------------------------------------------------------------------------------------

function OnEvent_40(proxy , param)
	print("OnEvent_40 begin");

	if proxy:IsCompleteEvent( 40 ) == true then
		print("OnEvent_40 end");
		return;
	end
	
	--���݂̏�Ԃ��擾 --EN:--get current state
	local now_state = GetNpcStateFlag( proxy , param , heroine_flag_list );
	
	--��Ԃ��u�������������v�łȂ��ꍇ�A���������B --EN:-- If the status is not "want to settle", skip processing.
	if now_state ~= HEROINE_STATE_WANT_TO_SETTLE then
		print("OnEvent_40 end");
		return;
	end
	
	if proxy:IsLand( 10000 ) == false then
		return;
	end
	
	--�|�����O�ɐΒ���BGM�̒�~ --EN:--Stop the BGM of the stone pillars before the polyplay
	proxy:StopPointSE( 0 );--0�̃X���b�g��BGM���ݒ肳��Ă���� --EN:--Because BGM is set in the 0 slot
	print("--�Β�BGM��~--"); --EN:--Pillar BGM stop--");
	
	--�����X�{�X�����ɍs���܂ł̔�э~��A�|���� --EN:--�� Jumping down to go to the final boss room, police play
	proxy:RequestRemo(00001,REMO_FLAG,40,10	);
	print("OnEvent_40 end");
end


--���|�����Đ��J�n(�t�F�[�h�I��) --EN:--�� Start of polyplay playback (end of fade)
function OnEvent_40_RemoStart(proxy,param)
	print("OnEvent_40_RemoStart begin");
	proxy:Warp( 10000 , 2000 );--PC������̈ʒu�փ��[�v --EN:--Warp your PC into place
	--proxy:SetHitInfo( 10000 , 1050 );
	proxy:CamReset( 10000 , true );--�J�������Z�b�g --EN:--camera reset
	if proxy:IsAlive( 10000 ) == true then
		proxy:PlayerChrResetAnimation_RemoOnly(10000);
		proxy:ChrResetRequest(10000);
	end
	print("OnEvent_40_RemoStart end");
end


--���|�����Đ��I��(�t�F�[�h�I��) --EN:-- End of polyplay playback (end of fade)
function OnEvent_40_RemoFinish(proxy , param)
	print("OnEvent_40_RemoFinish begin");	
	
	--proxy:Warp( 10000 , 2000 );--PC������̈ʒu�փ��[�v --EN:--Warp your PC into place
	proxy:SetHitInfo( 10000 , 1050 );
	--proxy:CamReset( 10000 , true );--�J�������Z�b�g	 --EN:--camera reset
	
	LuaFunc_ForceOmission(proxy,615);
	proxy:SetAlwayEnableBackread_forEvent( 615 , true );
	proxy:SetSpStayAndDamageAnimId( 615 ,-1,-1);
	--�q���C���̋����o�b�N���[�h�𖳌��� --EN:--Disable the heroine's forced back read
	proxy:OnKeyTime2( 40,"OnEvent_40_1",0.1,0,1,once);
	proxy:Warp( 615 , 2001 );--�q���C��������̈ʒu�փ��[�v --EN:-- Warp the heroine to the specified position
	proxy:ChangeInitPosAng( 615 , 2001 );--�A�ҏꏊ���X�V --EN:--Update return location
	
	--�q���C���̏�ԃt���O���u���čs���܂��v�ɂ��� --EN:-- Set the heroine's status flag to "follow"
	SetNpcStateFlag(proxy, param, heroine_flag_list, HEROINE_STATE_WITH_A_FUTURE );

	--�q���C���̃��W�b�N�؂�ւ� ���u�F��H�v --EN:--Switch heroine's logic �� "Pray?"
	proxy:SendEventRequest( 615 , 0 , AI_EVENT_GRACE);
	proxy:ResetThink( 615 );	
	
	proxy:DeleteEvent( 40 );--everytime�Ȃ̂ŏ��� --EN:--everytime so delete
	
	proxy:SetEventFlag( 40,true);
	
	--�v�Ό����� --EN:--I can see the keystone
	proxy:SetColiEnable(1140,true);
	proxy:SetDrawEnable(1140,true);	
	proxy:SetColiEnable(1141,true);
	proxy:SetDrawEnable(1141,true);	

	--proxy:TreasureDispModeChange2( 1140 , true ,KANAME_SFX);
	proxy:TreasureDispModeChange2( 1141 , true ,KANAME_SFX);	
	--proxy:TreasureDispModeChange2( 1145 , true ,KANAME_SFX);
	proxy:TreasureDispModeChange2( 1146 , true ,KANAME_SFX);
	
	SingleReset(proxy,42);
	SingleReset(proxy,43);
	proxy:OnDistanceAction( 42,10000,1140,"OnEvent_42",WarpGimmickDist_A,HELPID_GO_TO_SEKITYUU,0,WarpGimmickAngle_B,everytime);
	proxy:OnDistanceAction( 43,10000,1145,"OnEvent_43",WarpGimmickDist_A,HELPID_GO_TO_SEKITYUU,0,WarpGimmickAngle_B,everytime);		
	
	OnEvent_60_RemoFinish(proxy,param);
	--proxy:SetEventFlag( 60 , true );
	
	print("OnEvent_40_RemoFinish end");
end

function OnEvent_40_1(proxy,param)
	print("OnEvent_40_1 begin");
	LuaFunc_NormalOmission(proxy,615);
	proxy:SetAlwayEnableBackread_forEvent( 615 , false );
	print("OnEvent_40_1 end");
end

--------------------------------------------------------------------------------------
--��60���g�U�̃��m�����ݍ��ރ|������ --EN:--��60��Poly drama where things of diffusion crouch ��
--------------------------------------------------------------------------------------

function OnEvent_60(proxy , param)
	print("OnEvent_60 begin");

	--���g�U�̃��m�����ݍ��ރ|���� --EN:--�� A polyplay in which diffusion objects crouch
	proxy:RequestRemo(2,REMO_FLAG,60,1);
	proxy:SetEventFlag( 60, true );

	print("OnEvent_60 end");
end


--���|�����Đ��J�n(�t�F�[�h�I��) --EN:--�� Start of polyplay playback (end of fade)
function OnEvent_60_RemoStart(proxy,param)
	print("OnEvent_60_RemoStart begin");
	print("OnEvent_60_RemoStart end");
end


--���|�����Đ��I��(�t�F�[�h�I��) --EN:-- End of polyplay playback (end of fade)
function OnEvent_60_RemoFinish(proxy , param)
	print("OnEvent_60_RemoFinish begin");
	
	--�}�b�v�p�[�c��L���� --EN:--enable map parts
	proxy:SetDrawEnableArray( 1020 , true );
	proxy:SetColiEnableArray( 1020 , true );
	
	proxy:SetDrawEnableArray( 1121 , true );
	proxy:SetColiEnableArray( 1121 , true );
	
	--�}�b�v�p�[�c�𖳌������� --EN:--Disable map parts
	proxy:SetDrawEnableArray( 1120 , false );
	proxy:SetColiEnableArray( 1120 , false );
	
	--�؂̃I�u�W�F��L�������� --EN:--Activate the tree object
	local first_id = 1030;
	local last_id  = 1058;
	local now_id   = first_id;
	local num      = last_id - first_id + 1;
	
	for i=1 , num , 1 do
		proxy:SetDrawEnable( now_id , true );--�\��ON --EN:--Display ON
		proxy:SetColiEnable( now_id , true );--������ON --EN:-- Hit ON
		now_id = now_id + 1;
	end
	
	--proxy:SetDrawEnable( 1190 , false );--�ǉ�OBJ�\��OFF --EN:--Additional OBJ display OFF
	--proxy:SetColiEnable( 1190 , false );--�ǉ�OBJ�A�^��OFF --EN:--Added OBJ Atari OFF
		
	--�Ή�����G��L���� --EN:--Enable corresponding enemy
	--�폜 --EN:--delete
	
	--�{�X��L���� --EN:--enable boss
	ValidCharactor( proxy , 821 );
	
	--OBJ�𖳌��� --EN:--disable OBJ
	proxy:SetDrawEnable( 1100 , false );
	proxy:SetColiEnable( 1100 , false );
	
	--OBJ�𖳌��� --EN:--disable OBJ
	--proxy:SetDrawEnable( 1101 , false );
	--proxy:SetColiEnable( 1101 , false );
	
	--SFX��L���� --EN:--Enable SFX
	proxy:ValidSfx( 1110 );
	
	print("OnEvent_60_RemoFinish end");
end




--------------------------------------------------------------------------------------
--��70�����X�{�X��|������A�|�������Đ��� --EN:-- �� 70 �� After defeating the final boss, play the police play ��
--------------------------------------------------------------------------------------

function OnEvent_70(proxy , param)
	print("OnEvent_70 begin");
	--�A�C�e������(���IID10900)	 --EN:--Item acquisition (lottery ID 10900)
	--�b��DS�p�~ --EN:--Abolition of Beast DS
	--proxy:GetRateItem( 10900 );
	--�\�E���u�����h�p�~ --EN:--Soul brand discontinued
	--proxy:GetRateItem(10730);--�A�C�e��	 --EN:--item
	proxy:NotNetMessage_begin();
		proxy:OnRegistFunc( 451 , "Check_451","OnEvent_451", 1 , once);
	proxy:NotNetMessage_end();
	
	proxy:SetEventFlag( 70, true );
	
	--�\�E���u�����h�����ĂȂ� --EN:-- Don't leave out Soul Brand
	if proxy:IsCompleteEvent( 141 ) == false then			
		--���ׂ�C�x���g���͓̂������܂��A���ׂ��l�̓z�X�gor�V���O���v���C���[�ł� --EN:--The event itself to be examined is synchronized, the person who can be examined is the host or single player
		--proxy:NotNetMessage_begin();		
			
			proxy:OnKeyTime2( 141 , "OnEvent_141_WAIT",9.5,0,0,once);
			
			proxy:ValidSfx( 1131 );			
			--proxy:SetRarity( 1130, 10104 );
		--proxy:NotNetMessage_end();
	else
		proxy:SetDrawEnable( 1130 , false );--�ЂƂ܂��`�悾��OFF --EN:--Only drawing is turned off for the time being
		proxy:SetColiEnable( 1130 , false );			
		proxy:InvalidSfx( 1131 ,true );
	end

	print("OnEvent_70 end");
end



--------------------------------------------------------------------------------------
--��450�����o�I���҂��� --EN:-- �� 450 �� waiting for the end of the production ��
--------------------------------------------------------------------------------------
--��b�̏I���҂� --EN:--Wait for end of conversation
function Check_451(proxy)
	if proxy:IsCompleteEvent( 9054 ) == false then
		return false;
	end
	return true;
end

--�e�L�X�g���o�Ăяo�� --EN:--Text rendition call
function OnEvent_451(proxy,param)
	proxy:CustomLuaCallStart( 450 , 821 );
end

----------------------------------------------------------------------------------------------------------------
--��450���Β��p�u���b�N�N���A�� --EN:-- �� 450 �� Stone pillar block clear ��
----------------------------------------------------------------------------------------------------------------
function OnEvent_450(proxy,param)	
	--�����̂� --EN:--only me
	if param:IsNetMessage() == true then
		return;
	end	
	if proxy:IsCompleteEvent( 4047 ) == true then
		return;
	end
	print("OnEvent_450 begin");	
	SekiClearBossId = -1;
	SekiClearBossId = param:GetParam2();
	
	--SOS�T�C������x�N���A --EN:--clear the SOS sign once
	proxy:ClearSosSign();	
	--�Z�b�V���������L�� --EN:-- remember number of sessions
	proxy:SetClearSesiionCount();	
	--�{�X�Q�[�W���N���A --EN:--clear the boss gauge
	proxy:ClearBossGauge();	
	--�N���A�{�[�i�X���v�Z --EN:-- Calculate clear bonus
	proxy:SetClearBonus(SekiClearBossId);
	
	--������ --EN:--Alive
	if proxy:IsLivePlayer() == true then		
		proxy:SetTextEffect(TEXT_TYPE_KillDemon);
		proxy:NotNetMessage_begin();
			proxy:OnTextEffectEnd( 450 , TEXT_TYPE_KillDemon ,"OnEvent_450_effectEnd");
		proxy:NotNetMessage_end();
	--�O���C�� --EN:--Gray time
	elseif proxy:IsGreyGhost() == true then		
		proxy:SetTextEffect(TEXT_TYPE_KillDemon);
		proxy:SetTextEffect(TEXT_TYPE_Revival);
		proxy:OnTextEffectEnd( 450 , TEXT_TYPE_Revival ,"OnEvent_450_effectEnd");
		proxy:SetReviveWait( true );--�����҂���ԃt���O�����Ă���(�O���C�Ŕ������Ă��܂������̈�) --EN:--Insert a resurrection waiting state flag (for when you get out of the gray)
	end	
	
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 450, "OnEvent_450_1", 5.0, 0, 2, once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_450 end");
end

function OnEvent_450_1(proxy,param)
	print("OnEvent_450_1 begin");
	
	if proxy:IsInParty() == true then
		print("ERROR! PT��g��ł���"); --EN:print("ERROR! Building PT");
	else
		if proxy:IsLivePlayer() == true then
			proxy:NotNetMessage_begin();
				proxy:OnKeyTime2( 450, "Clear_450", 3.0, 0, 6, once );
			proxy:NotNetMessage_end();			
		--�O���C�� --EN:--Gray time
		elseif proxy:IsGreyGhost() == true then
			--�߂ł������� --EN:--Happy revival
			proxy:RevivePlayer();
			proxy:SetReviveWait( false );--�����҂���ԃt���O�����낵�Ă��� --EN:--Put down the resurrection waiting state flag
			--��������̂Ńy�i���e�B�Ō��������p�����[�^�����ɖ߂�(�ő�l�̂�) --EN:--Since it will be revived, restore the parameters that have been reduced by the penalty (maximum value only)
			proxy:EraseEventSpecialEffect( 10000, 101 );
			proxy:NotNetMessage_begin();
				proxy:OnKeyTime2( 450, "Clear_450", 6.0, 0, 6, once );
			proxy:NotNetMessage_end();
		end		
	end
	print("OnEvent_450_1 end");
end

function Clear_450(proxy,param)
	print("Clear_450 begin");
	proxy:GetSoloClearBonus(SekiClearBossId);
	print("Clear_450 end");
end

function OnEvent_450_effectEnd(proxy,param)
	print("OnEvent_450_effectEnd begin");
	proxy:SetEventFlag( 450 , true );
	print("OnEvent_450_effectEnd end");
end

--------------------------------------------------------------------------------------
--��71�����X�{�X��|������A�|�������Đ��� --EN:-- �� 71 �� After defeating the final boss, play the police play ��
--------------------------------------------------------------------------------------
function OnEvent_71(proxy , param)
	--��b�t���O�������ĂȂ������疳�� --EN:--Ignore if conversation flag is not set
	if proxy:IsCompleteEvent( 9054 ) == false then
		return;
	end
	
	--�|�����Đ��������Ă����疳�� --EN:--Ignore if the polyplay is standing
	if proxy:IsCompleteEvent( 71 ) == true then
		return;
	end
	
	--���o�I�����ĂȂ���Ζ��� --EN:--Ignored if the production has not ended
	if proxy:IsCompleteEvent( 450 ) == false then
		return;
	end
	print("OnEvent_71 begin");
	
	--proxy:InvalidSfx( 1991, true );
	
	--�{�X��BGM�̍Đ����Ƃ߂� --EN:--Stop playing the boss battle BGM
	proxy:StopPointSE( 1 );

	--���q���C�����F��|���� --EN:--��Poly drama that the heroine prays
	proxy:RequestRemo(3,REMO_FLAG,71,1);
	proxy:SetEventFlag( 71, true );

	print("OnEvent_71 end");
end


--���|�����Đ��J�n(�t�F�[�h�I��) --EN:--�� Start of polyplay playback (end of fade)
function OnEvent_71_RemoStart(proxy,param)
	print("OnEvent_71_RemoStart begin");
	
	proxy:InvalidSfx( 1991, false );
	
	--�{�X(821)�𖳌������� --EN:--Disable Boss (821)
	--InvalidCharactor( proxy, 821 );

	print("OnEvent_71_RemoStart end");
end


--���|�����Đ��I��(�t�F�[�h�I��) --EN:-- End of polyplay playback (end of fade)
function OnEvent_71_RemoFinish(proxy , param)
	print("OnEvent_71_RemoFinish begin");
	
	--�����h�����̉�b���{�^���A�ł��܂������ꍇ�̉��}���u�I�ȁH --EN:--Is it a first-aid measure when you keep hitting buttons in King Lendl's conversation?
	if proxy:IsCompleteEvent( 70 ) == false then
		OnEvent_70(proxy, param);	--OnEvent_70���Ăяo�� --EN:--call OnEvent_70
	end
	
	--�Ώۂ�SFX��\�������� --EN:--Display target SFX
	proxy:ValidSfx( 1991 );
	
	--�q���C�����ړ������� --EN:--Move the heroine
	LuaFunc_ForceOmission(proxy,615);	
	proxy:SetAlwayEnableBackread_forEvent( 615 , true );	
	proxy:SetDisableGravity( 615,false );
	--�q���C���̋����o�b�N���[�h�𖳌��� --EN:--Disable the heroine's forced back read
	proxy:OnKeyTime2( 40,"OnEvent_40_1",0.2,0,1,once);
	
	--proxy:Warp( 615 , 2002 );--�q���C��������̈ʒu�Ƀ��[�v --EN:-- Warp the heroine into place
	--proxy:RecoveryHeroin();
	proxy:SetAlive( 615 ,1.0);
	proxy:SetHp( 615 , 1.0 );--�q���C��HP�S�� --EN:--Heroine HP fully recovered
	proxy:WarpRestart( 615, 2002 );
	proxy:PlayerChrResetAnimation_RemoOnly( 615 );--�֒f�̕�Ԑ؂�	 --EN:--Forbidden Interpolation Cut
	proxy:EnableLogic( 615 , false );--���W�b�NOFF --EN:--Logic OFF
	
	proxy:SetEventCommand( 615 , 70 );--EzState�ɐ���ԍ�(�F��)�𑗂� --EN:--Send control number (pray) to EzState
	
	SetNpcStateFlag(proxy, param, heroine_flag_list, HEROINE_STATE_PRAYER );--�q���C����Ԃ��u�F��v�� --EN:--Heroine state to "pray"
	
	--�Ή�����G���폜(���S������) --EN:--Remove the corresponding enemy (death)
	--�폜 --EN:--delete
	
	proxy:OnDistanceAction( 44,10000,1140,"OnEvent_44",WarpGimmickDist_A,HELPID_GO_TO_SEKITYUU,0,WarpGimmickAngle_B,everytime);

	--�G���f�B���O�p�̊Ď���ǉ� --EN:--Added monitoring for ending
	
	--���q���C���ւ̃_���[�W�Ď�(�G���f�B���O1�p)��Bad End --EN:--��Damage monitoring to heroine (for ending 1)��Bad End
	--proxy:OnSimpleDamage( 80 , 615 , 10000 , "OnEvent_80" , once );
	proxy:OnKeyTime2( 80 , "OnEvent_71_wait",0.1,0,0,once);	
	
	proxy:NotNetMessage_begin();
		--�|�����J�n�t�F�[�h��ɌĂ΂��n���h�� --EN:--Handler called after polyplay start fade
		proxy:LuaCall(80,REMO_START,"OnEvent_80_RemoStart",once);
		--�|�����I����ɌĂ΂��n���h�� --EN:--Handler called after the polyplay ends
		proxy:LuaCall(80,REMO_FINISH,"OnEvent_80_RemoFinish",once);
	proxy:NotNetMessage_end();
	
	--���̈�Ď���ǉ�(�G���f�B���O2�p)��Good End --EN:--�� Added Area Surveillance (for Ending 2) �� Good End
	local possible_chr_type = ATTR_HOST + ATTR_LIVE + ATTR_GREY;
	proxy:OnPlayerActionInRegionAttribute( 81, 2010, "OnEvent_81", 10010405, possible_chr_type, once );
	
	proxy:NotNetMessage_begin();
		--�|�����J�n�t�F�[�h��ɌĂ΂��n���h�� --EN:--Handler called after polyplay start fade
		proxy:LuaCall(81,REMO_START,"OnEvent_81_RemoStart",once);
		--�|�����I����ɌĂ΂��n���h�� --EN:--Handler called after the polyplay ends
		proxy:LuaCall(81,REMO_FINISH,"OnEvent_81_RemoFinish",once);
	proxy:NotNetMessage_end();
	
	proxy:Warp( 10000 , 2083);	
	proxy:CamReset( 10000 , true );--�J�������Z�b�g --EN:--camera reset
	
	if proxy:IsAlive( 10000 ) == true then
		proxy:PlayerChrResetAnimation_RemoOnly(10000);
		proxy:ChrResetRequest(10000);
	end	
	--�v��Ȃ��Ȃ����̂ō폜 --EN:-- Deleted because it is no longer needed
	proxy:DeleteEvent( 71 );
	
	print("OnEvent_71_RemoFinish end");
end

function OnEvent_71_wait(proxy,param)
	print("OnEvent_71_wait begin");
	proxy:OnCharacterDead( 80 , 615 , "OnEvent_80",once);
	proxy:SetEventFlag( 75 , true );
	print("OnEvent_71_wait end");
end



--------------------------------------------------------------------------------------
--��80���G���f�B���O�|����1��Bad End --EN:-- �� 80 �� Ending police play 1 �� Bad End
--------------------------------------------------------------------------------------

function OnEvent_80(proxy , param)
	print("OnEvent_80 begin");

	proxy:InvalidSfx( 1991, true );
	
	--�N���C�A���g�ł͂Ȃ��������@or�@�O���C=�@�z�X�gor�\�� --EN:--Not a client = survival or gray = host or solo
	if proxy:IsClient() == false then
		--�N���A��Ԑݒ�A�N���A������Z --EN:-- Clear state setting, Clear lap addition
		proxy:SetClearState( CLEAR_STATE_BADEND );
		proxy:AddClearCount();
		--�R�R�ŃN���A�p�̏������������Ăяo�����H --EN:--Do you want to call the initialization process for clearing here?
		LastRemoveEquip(proxy);
		proxy:OnEndFlow( 80,"OnEvent_80_1");
		proxy:OnKeyTime2( 80 , "OnEvent_80_wait", 3.0 , 0 , 1 , once );
	end
	--�����C�x���g�폜 --EN:--Resurrection event deleted
	proxy:DeleteEvent( 111 );
	proxy:DeleteEvent( 81 );
	print("OnEvent_80 end");
end

function OnEvent_80_wait(proxy,param)
	--�A�j���҂��̑���̕b���o�� --EN:--Seconds elapsed instead of waiting for animation
	BAD_END_WAIT = true;
end

--�I���������� --EN:--Ready to finish
function OnEvent_80_1(proxy,param)
	print("OnEvent_80_1 begin");
	proxy:OnRegistFunc( 80 , "Check_80_2","OnEvent_80_2",1,once);
	--�����t���O�������ς݂Ȃ̂Ńt���O��ON�ɂ��Ȃ� --EN:--Flag is already initialized, so don't turn it ON
	print("OnEvent_80_1 begin");
end

--�t���O�҂� --EN:--Wait flag
function Check_80_2(proxy)
	if BAD_END_WAIT == true then
		return true;
	end
	return false;
end

--�|�������� --EN:--Poly drama activation
function OnEvent_80_2(proxy,param)
	--���G���f�B���O�|����1 --EN:--�� Ending police play 1
	proxy:RequestRemo(4,REMO_FLAG,80,1);
end

--���|�����Đ��J�n(�t�F�[�h�I��) --EN:--�� Start of polyplay playback (end of fade)
function OnEvent_80_RemoStart(proxy,param)
	print("OnEvent_80_RemoStart begin");
	print("OnEvent_80_RemoStart end");
end


--���|�����Đ��I��(�t�F�[�h�I��) --EN:-- End of polyplay playback (end of fade)
function OnEvent_80_RemoFinish(proxy , param)
	print("OnEvent_80_RemoFinish begin");
	
	--[[�Q�[���N���A����]] --EN:--[[Game clear process]]
	print("Bad Ending");	
	
	--���[�r�[�Đ��v�� --EN:--Movie playback request
	--proxy:RequestPlayMoviePlus(MOVIE_ENDING_BAD,true);
	--���[�r�[�Đ��̊Ď� --EN:--monitor movie playback
	--proxy:OnRegistFunc(80,"Check_80","OnEvent_80_2",1,once);
	proxy:RequestEnding();--�G���f�B���O�v�� --EN:--Ending request
	
	print("OnEvent_80_RemoFinish end");
end
	
--[[
--���[�r�[�Đ����̊Ď������̂��H --EN:--Does the monitor during movie playback work?
function Check_80(proxy,param)
	if proxy:IsPlayMovie() == true then
		return false;
	end	
	return true;
end
	
--Bad���[���I���� --EN:--After bad roll
function OnEvent_80_2(proxy,param)
	print("OnEvent_80_2 begin");
	--�Β��ɓ��蒼�� --EN:--Re-enter the stone pillar
	proxy:WarpNextStage( 1, 0, 0, 0, -1 );
	print("OnEvent_80_2 end");
end
]]


--------------------------------------------------------------------------------------
--��81���G���f�B���O�|����2��GoodEnd --EN:-- �� 81 �� Ending police play 2 �� GoodEnd
--------------------------------------------------------------------------------------

function OnEvent_81(proxy, param)
	print("OnEvent_81 begin");
		
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		if param:IsNetMessage() == true then
			--����A�j���Đ��𓯊� --EN:-- Synchronize turning animation playback
			proxy:TurnCharactor( 10001 + param:GetPlayID(), 2011 );
		else
			--����A�j���Đ����s���A���̏I������OnEvent_81_1�𔭍s���� --EN:--Play the turning animation and issue OnEvent_81_1 at the end
			proxy:OnTurnCharactorEnd( 81, 10000, 2011, "OnEvent_81_1_1", once );
		end
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();	
	
	print("OnEvent_81 end");
end

function OnEvent_81_1_1(proxy, param)
	print("OnEvent_81_1_1 begin");
		
	--�����p�����A�j���Đ� --EN:--Play walking animation for synchronization
	proxy:LuaCallStart( 4012, 1 );
	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		proxy:OnChrAnimEnd( 81, 10000, ANIMEID_WALK, "OnEvent_81_1_2", once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();

	print("OnEvent_81_1_1 end");
end

function OnEvent_81_1_2(proxy, param)
	print("OnEvent_81_1_2 begin");
	
	proxy:OnKeyTime2( 81, "OnEvent_81_2", 3, 0, 0, once );

	print("OnEvent_81_1_2 end");
end

function OnEvent_81_2(proxy , param)
	print("OnEvent_81_2 begin");
	
	proxy:InvalidSfx( 1991, true );
	
	--�N���C�A���g�ł͂Ȃ��������@or�@�O���C=�@�z�X�gor�\�� --EN:--Not a client = survival or gray = host or solo
	if proxy:IsClient() == false then
		--�N���A��Ԑݒ�A�N���A������Z --EN:-- Clear state setting, Clear lap addition
		proxy:SetClearState( CLEAR_STATE_GOODEND );
		proxy:AddClearCount();
		
		--���g���t�B�[�擾���聥 --EN:--��Trophy Acquisition Judgment��
		--Lua_RequestUnlockTrophy(proxy, 1);--�g���t�B�̏󋵂𔻒肵�A�擾���� --EN:--Determine and retrieve trophy status
		LastRemoveEquip(proxy);
		--�R�R�ŃN���A�p�̏������������Ăяo�����H --EN:--Do you want to call the initialization process for clearing here?
		proxy:OnEndFlow(81,"OnEvent_81_3");
		
	end
	proxy:DeleteEvent(80);

	print("OnEvent_81_2 end");
end

--�I���������� --EN:--Ready to finish
function OnEvent_81_3(proxy,param)
	print("OnEvent_81_3 begin");
	--���G���f�B���O�|����2 --EN:--�� Ending Police Drama 2
	proxy:RequestRemo(5,REMO_FLAG,81,1);
	--�����t���O�������ς݂Ȃ̂Ńt���O��ON�ɂ��Ȃ� --EN:--Flag is already initialized, so don't turn it ON
	print("OnEvent_81_3 end");
end

--���|�����Đ��J�n(�t�F�[�h�I��) --EN:--�� Start of polyplay playback (end of fade)
function OnEvent_81_RemoStart(proxy,param)
	print("OnEvent_81_RemoStart begin");
	print("OnEvent_81_RemoStart end");
end


--���|�����Đ��I��(�t�F�[�h�I��) --EN:-- End of polyplay playback (end of fade)
function OnEvent_81_RemoFinish(proxy , param)
	print("OnEvent_81_RemoFinish begin");
	
	--[[�Q�[���N���A����]] --EN:--[[Game clear process]]
	print("Good Ending");	
	--���[�r�[�Đ��v�� --EN:--Movie playback request
	--proxy:RequestPlayMoviePlus(MOVIE_ENDING_GOOD,true);
	--���[�r�[�Đ��̊Ď� --EN:--monitor movie playback
	--proxy:OnRegistFunc(81,"Check_81","OnEvent_81_4",1,once);
	proxy:RequestEnding();--�G���f�B���O�v�� --EN:--Ending request
	print("OnEvent_81_RemoFinish end");
end

--[[
--���[�r�[�Đ����̊Ď������̂��H --EN:--Does the monitor during movie playback work?
function Check_81(proxy,param)
	if proxy:IsPlayMovie() == true then
		return false;
	end	
	return true;
end
	
--Good���[���I���� --EN:--After Good Roll
function OnEvent_81_4(proxy,param)
	print("OnEvent_81_4 begin");
	--�Β������[�h --EN:--load stone pillar
	proxy:WarpNextStage( 1, 0, 0, 0, -1 );
	print("OnEvent_81_4 end");
end
]]

--[[
--------------------------------------------------------------------------------------
--��140�����̂ɂ������Ă��錕����聡 --EN:-- �� 140 �� Get the sword stuck in the corpse ��
--------------------------------------------------------------------------------------
function OnEvent_140(proxy, param)
	print("OnEvent_140 begin");
	--�v���C���[�̓����A�j���[�V����(true:�p�[�e�B�[�v���C���[���A�j���[�V��������) --EN:--Player synchronous animation (true: party player animated)
	if Luafunc_PlaySynchroAnimation( proxy, param, 8300 ) == true then--�V�����A�j��  --EN:-- new anime
		proxy:PlayAnimation( 1130 , 1);	
		print("OnEvent_140 end");
		return true;
	end

	proxy:WarpDmy( 10000 , 1130 , 191 );--�_�~�[�ʒu�փ��|�v --EN:--Warp to dummy position
	proxy:PlayAnimation( 1130 , 1);
	--�A�j�����I�������Ď��ǉ� --EN:--Add monitoring when the animation ends
	proxy:NotNetMessage_begin();
		proxy:OnChrAnimEnd( 140 , 10000 , 8300 , "OnEvent_140_1", once);
	proxy:NotNetMessage_end();
	
	print("OnEvent_140 end");
end

function OnEvent_140_1(proxy, param)
	print("OnEvent_140_1 begin");
	--�A�C�e���擾�֐�--�p�����[�^10104�Q�� --EN:--item retrieval function--see parameter 10104
	proxy:GetRateItem(10730);--�A�C�e��	 --EN:--item
	
	--�A�C�e�����擾�ς� --EN:--item already acquired
	proxy:SetEventFlag( 140, true );
	
	--OBJ���������߂̃C�x���g�z�M --EN:--Event distribution for erasing OBJ
	proxy:LuaCallStart( 140, 1);
	
	print("OnEvent_140_1 end");
end

--��140_2����OBJ��\���p�� --EN:--��140_2��For hiding the sword OBJ��
function OnEvent_140_2(proxy,param)
	print("OnEvent_140_2 begin");
	--�I�u�W�F�������� --EN:--The object disappears
	proxy:SetDrawEnable( 1130 , false );--�ЂƂ܂��`�悾��OFF --EN:--Only drawing is turned off for the time being
	proxy:SetColiEnable( 1130 , false );--������͂���͕̂s��(����ł͂Ȃ��悤�Ȃ̂ŏ����Ȃ�) --EN:--I don't know if there is a hit (I don't delete it because it doesn't seem to be the current situation)
	print("OnEvent_140_2 end");
end
]]
	
--------------------------------------------------------------------------------------
--��100���q���C�����Ō�̐킢�����ӂ��遡 --EN:-- �� 100 �� The heroine decides the final battle ��
--------------------------------------------------------------------------------------

--��100���q���C�����Ō�̐킢�����ӂ��遡 --EN:-- �� 100 �� The heroine decides the final battle ��
function OnEvent_100(proxy , param)
	print("OnEvent_100 begin");

	--�q���C���̏�ԃt���O���u�������������v�ɂ��� --EN:--Set the heroine's status flag to "I want to settle"
	SetNpcStateFlag(proxy, param, heroine_flag_list, HEROINE_STATE_WANT_TO_SETTLE );
	proxy:SetEventFlag( 100 , 1 );
	
	print("OnEvent_100 end");
end



--------------------------------------------------------------------------------------
--��90,91���o�b���q���C���̑O���삭��(��b�V�X�e������Ăяo��) --EN:-- �� 90, 91 �� PC kneels in front of heroine �� (call from conversation system)
--------------------------------------------------------------------------------------

--��90���o�b���q���C���̑O���삭_1�� --EN:--��90��PC kneels in front of the heroine_1��
function OnEvent_90(proxy , param)
	print("OnEvent_90 begin");
	proxy:SetEventFlag(90,false);
	proxy:TurnCharactor( 10000 , 615 );--PC���q���C���̂ق��Ɍ����킹�� --EN:--Turn the PC toward the heroine
	proxy:EnableLogic( 10000 , false );--PC�𑀍�s�\ --EN:--Cannot operate PC
	proxy:ResetCamAngle();
	
	proxy:RepeatMessage_begin();
		--������A�j���̏I���� --EN:--��The end of the turning animation��
		proxy:OnTurnCharactorEnd( 90 , 10000 , 615 , "OnEvent_90_trun_end" , once );
	proxy:RepeatMessage_end();
	
	print("OnEvent_90 end");
end


--������A�j���̏I���� --EN:--��The end of the turning animation��
function OnEvent_90_trun_end(proxy , param)
	print("OnEvent_90_trun_end begin");

	if proxy:IsCompleteEvent(90) == false then
	--[[	--�����A�j�� --EN:--forced animation
		proxy:ForcePlayAnimation( 10000 , 8280 );
	
	proxy:RepeatMessage_begin();
		--���ŏ��̃A�j���I���� --EN:--��The end of the first animation��
		proxy:OnChrAnimEnd( 90 , 10000 , 8280 , "OnEvent_90_anime_end" , once );
		proxy:RepeatMessage_end();]]
		--�삭���߂𑗐M --EN:-- send command to kneel
		proxy:SetEventCommand( 10000 , 80 );
	end
	
	print("OnEvent_90_trun_end end");
end


--���ŏ��̃A�j���̏I���� --EN:--��The end of the first animation��
function OnEvent_90_anime_end(proxy , param)
	print("OnEvent_90_anime_end begin");
	--[[
	if proxy:IsCompleteEvent(90) == false then
	proxy:PlayLoopAnimation( 10000 , 8281 );
	end	
	]]
	print("OnEvent_90_anime_end end");
end


--��91���o�b���q���C���̑O���삭_2�� --EN:--��91�� PC kneels in front of the heroine_2��
function OnEvent_91(proxy , param)
	print("OnEvent_91 begin");
--�����A�j�� --EN:--forced animation
	--proxy:ForcePlayAnimation( 10000 , 8282 );
	proxy:SetEventCommand( 10000 , 81);
	proxy:EnableLogic( 10000 , true );--PC�𑀍�s�\ --EN:--Cannot operate PC
	proxy:ResetCamAngle();
	proxy:SetEventFlag(90,true);
	
	print("OnEvent_91 end");
end

--[[
--------------------------------------------------------------------------------------
--�n�[�t�n���h�G�΁�200 --EN:--Half hand hostility ��200
--------------------------------------------------------------------------------------

--��200���n�[�t�n���h�G�΁� --EN:-- �� 200 �� Half-handed hostility ��
function OnEvent_200(proxy, param)
	print("OnEvent_200 begin");

	proxy:EnableLogic( 618 , true );--[[���W�b�NON ���W�b�N�؂�ւ�?]] --EN:--[[Logic ON logic switch?]]
	
	--�n�[�t�n���h�̏�ԃt���O���u�G��(�Β�)�v�ɂ��� --EN:-- Set half hand status flag to "hostile (stone pillar)"
	SetNpcStateFlag(proxy, param, half_flag_list, HALF_STATE_HOSTILE_SEKITYU );
	proxy:SetEventFlag( 200 , 1 );
	
	print("OnEvent_200 end");
end


--------------------------------------------------------------------------------------
--�n�[�t�n���h���S��201 --EN:--Half hand death��201
--------------------------------------------------------------------------------------

--��201���n�[�t�n���h���S�� --EN:-- �� 201 �� half hand death ��
function OnEvent_201(proxy, param)
	print("OnEvent_201 begin");

	--�n�[�t�n���h�̏�ԃt���O���u���S�v�ɂ��� --EN:-- Set half hand status flag to "dead"
	SetNpcStateFlag(proxy, param, half_flag_list, HALF_STATE_DEAD );
	proxy:SetEventFlag( 201 , 1 );
	
	print("OnEvent_201 end");
end
]]





--------------------------------------------------------------------------------------
--��100�`153��NPC��ԑJ�ځ@�q���C���� --EN:-- �� 100 to 153 �� NPC state transition heroine ��
--------------------------------------------------------------------------------------
--��100�`153��NPC��ԑJ�ځ@�q���C���� --EN:-- �� 100 to 153 �� NPC state transition heroine ��

function OnEvent_110(proxy,param)
	print("OnEvent_110 begin");
	if	proxy:IsCompleteEvent(110) == true then
		print("OnEvent_110 ���ɉ�b�C�x���g���I�����Ă��܂��B"); --EN:print("OnEvent_110 The conversation event has already ended.");
		return;
	end
	if	proxy:IsCompleteEvent( HEROINE_STATE_DOOR_FRONT ) == true then
		SetNpcStateFlag(proxy, param, heroine_flag_list, HEROINE_STATE_DOOR_LEAVE );
	end
	proxy:SetEventFlag( 110, true );
	proxy:SetEventFlag(120,true);
	print("OnEvent_110 end");
end

--��111���q���C�����S�Ď���	 --EN:-- �� 111 �� Heroine death watch ��
function OnEvent_111(proxy, param)
	print("OnEvent_111 begin");
	proxy:OnKeyTime2(111, "OnEvent_111_1", 10.0, 0, 0, once);
	--proxy:SendEventRequest(615, 0, -1);
	print("OnEvent_111 end");
end

function OnEvent_111_1(proxy, param)
	print("OnEvent_111_1 begin");
	proxy:SetEventFlag( 115 , true );	
	proxy:RecoveryHeroin();
	--�������߂𑗂� --EN:--Send a resurrection order
	proxy:SetEventCommand( 615 , 700);
	--�Q��ڈȍ~�̊Ď� --EN:-- Second and subsequent monitoring
	proxy:RepeatMessage_begin();
		proxy:OnCharacterDead(111, 615, "OnEvent_111", once);
		--proxy:OnCharacterHP( 111 , 615 , "OnEvent_111",0.0,once);
	proxy:RepeatMessage_end();
	--proxy:SetEventFlag(111, true);
	print("OnEvent_111_1 end");
end

-------------------------------------------------------
--�Đ����Ă���A�j��ID�ɂ���āA�Đ�����A�j����ς��� --EN:--Change the animation to be played depending on the animation ID being played
-------------------------------------------------------
function OnEvent_113(proxy, param)
	print("OnEvent_113�@begin"); --EN:print("OnEvent_113 begin");
		--proxy:ForcePlayAnimation(615, 7022);--�A�j���̕��ł��炵���B --EN:--It seems that it will be done in animation.
		proxy:SetSpStayAndDamageAnimIdPlus(615, -1, -1,hiroin_cancelAnimId);--�ʏ�ҋ@�֖߂� --EN:-- return to normal standby

		--proxy:
	print("OnEvent_113�@end"); --EN:print("OnEvent_113 end");
end

--------------------------------------------------------------------------------------
--�g�}�X�ɖ��̔������n����354�� --EN:--Give the daughter's hair ornament to Thomas 354
--------------------------------------------------------------------------------------
function OnEvent_354(proxy,param)
	print("OnEvent_354 begin");
	if	proxy:IsCompleteEvent(354) == true then
		print("OnEvent_354 ���ɉ�b�C�x���g���I�����Ă��܂��B"); --EN:print("OnEvent_354 The conversation event has already ended.");
	end
	if proxy:RemoveInventoryEquip(TYPE_GOODS, 38) == true then
		print("OnEvent_354 RemoveInventoryEquip Succsess");
	else
		print("OnEvent_354 RemoveInventoryEquip Failed");
	end
	proxy:GetRateItem( 10700 );
	proxy:SetEventFlag( 354, true );
	print("OnEvent_354 end");
end

--------------------------------------------------------------------------------------
--�{�[�h�E�B���G�΁�390 --EN:--Bauduin hostility ��390
--------------------------------------------------------------------------------------
--��390���{�[�h�E�B���G�΁� --EN:-- �� 390 �� Baudwin Hostility ��
function OnEvent_390(proxy, param)
	print("OnEvent_390 begin");
	proxy:EnableLogic(694,true);--���W�b�N�n�m --EN:--Logic ON
	proxy:SetTeamType(694, TEAM_TYPE_AngryFriend);--�`�[���^�C�v�ύX --EN:--Change team type
	SetNpcStateFlag( proxy, param, baldwin_flag_list, BALDWIN_STATE_HOSTILE );--�G�� --EN:--hostile

	proxy:SetEventFlag( 390 , 1 );
	
	print("OnEvent_390 end");
end
--------------------------------------------------------------------------------------
--�{�[�h�E�B�����S��391 --EN:--Bauduin died ��391
-------------------------------------------------------------------------------------
--��391���{�[�h�E�B�����S�� --EN:-- �� 391 �� Bauduin died ��
function OnEvent_391(proxy, param)
	print("OnEvent_391 begin");

	--�{�[�h�E�B���̏�ԃt���O���u���S�v�ɂ��� --EN:--Set Bauduin's status flag to "dead"
	SetNpcStateFlag(proxy, param, baldwin_flag_list, BALDWIN_STATE_DEAD );
	proxy:SetEventFlag( 391 , 1 );
	
	print("OnEvent_391 end");
end


--------------------------------------------------------------------------------------
--��303���v�l����̘̐b�� --EN:-- �� 303 �� Old tales from dignitaries ��
--------------------------------------------------------------------------------------
function OnEvent_303(proxy,param)
	print("OnEvent_303 begin");
	if proxy:IsCompleteEvent( 303 ) == true then
		return;
	end
	
	local movieflag = true;
	--[[
	if proxy:GetClearCount() >= 1 then 
		movieflag = true;
	end
	]]
	--BGM��~ --EN:--BGM stop
	proxy:StopPointSE(0);
	
	proxy:RequestPlayMoviePlus(MOVIE_OLDTALE,movieflag);
	proxy:OnRegistFunc( 303,"Check_303","OnEvent_303_1",1,once);
	print("OnEvent_303 end");
end

--���[�r�[�I������ --EN:-- Movie end judgment
function Check_303(proxy,param)
	if proxy:IsPlayMovie() == false then
		return true;
	end
	return false;	
end

--���[�r�[�I�� --EN:--Movie ends
function OnEvent_303_1(proxy,param)
	print("OnEvent_303_1 begin");
	--���[�r�[�Đ��I�������̂ŁABGM���Đ� --EN:--Since the movie has finished playing, play BGM
	PlayBGM_SEKITYUU(proxy, param);
	print("�Β�BGM�Đ�"); --EN:print("Stone pillar BGM playback");
	
	OnEvent_34(proxy, param);--�v�΂̊J���������� --EN:-- Activate keystone release process
	
	proxy:SetEventFlag(303,true);
	print("OnEvent_303_1 end");
end

------------------------------------------------------------------------------------
--34���v�΂̕���̊J�� --EN:--34 Unlocking the keystone seal
------------------------------------------------------------------------------------
--�v�ΊJ�� --EN:--Keystone release
function OnEvent_34(proxy,param)
	print("OnEvent_34 begin");

	proxy:RequestOpenBriefingMsgPlus(10010760,true);
	proxy:PlayTypeSE( 10000 ,SOUND_TYPE_M ,777777777 );
	
	--2���ڈȍ~�͂����܂� --EN:--This is the end of the 2nd and subsequent laps
	if proxy:GetClearCount() == 0 then--�܂��S�N���A���Ă��Ȃ���� --EN:--If you haven't cleared all of them yet
		proxy:OnKeyTime2( 34 , "OnEvent_34_1",0.1,0,0,once);--���ԊĎ��̒ǉ� --EN:--Add time monitoring
	else--�S�N���A�������Ƃ����� --EN:--I have cleared all
		--��b�p�Ƀt���O�𗧂Ă� --EN:--flag for conversation
		OnEvent_36(proxy, param);--36�t���O�n�m --EN:--36 Flag ON
	end
	proxy:SetEventFlag( 8802 , true );
	proxy:SetEventFlag( 8030 , true );
	print("OnEvent_34 end");
end

function OnEvent_34_1(proxy,param)
	print("OnEvent_34_1 beign");
	proxy:OnRegistFunc( 36 , "Check_36","OnEvent_36",1,ocne);
	print("OnEvent_34_1 end");
end

function Check_36(proxy,param)
	if proxy:IsShowMenu() == true then
		return false;
	end
	return true;
end


--�J���C���t�H�\��OFF�҂� --EN:--Wait for release information display OFF
function OnEvent_36(proxy,param)
	print("OnEvent_36 begin");
	
	proxy:SetEventFlag( 34 ,true);
	proxy:SetEventFlag( 36 , true );
	
	print("OnEvent_36 end");
end

--------------------------------------------------------------------------------------
--�v�l���S��300 --EN:--Victim death �� 300
-------------------------------------------------------------------------------------
--��300���v�l���S�� --EN:-- �� 300 �� key deaths ��
function OnEvent_300(proxy, param)
	print("OnEvent_300 begin");

	--�v�l�̏�ԃt���O���u���S�v�ɂ��� --EN:--Set VIP's status flag to "dead"
	SetNpcStateFlag(proxy, param, yojin_flag_list, YOJIN_STATE_DEAD );
	proxy:SetEventFlag( 300 , 1 );
	
	print("OnEvent_300 end");
end


--------------------------------------------------------------------------------------
--�S�܂ꂽ��m���S��380�`386 --EN:--Heartbroken Warrior Death ��380�`386
-------------------------------------------------------------------------------------
function OnEvent_380(proxy,param)
	print("OnEvent_380 begin");
	if	proxy:IsCompleteEvent( HEART_BREAK_FIGHTER_STATE_STONE_PILLAR ) == true or	--�Β��ɋ���@�� --EN:--Are you at the stone pillar?
		proxy:IsCompleteEvent( HEART_BREAK_FIGHTER_STATE_MAYBE_DELETE ) == true or	--����������@�� --EN:--maybe disappear
		proxy:IsCompleteEvent( HEART_BREAK_FIGHTER_STATE_DELETE ) == true then		--�����܂��Ȃ�� --EN:--If it disappears
		
		--proxy:SetEventCommand( 611 , 86);
		--proxy:DisableMapHit( 611 , false );
		--proxy:SetDisableGravity( 611 , false );
		proxy:EnableLogic(611,true);--���W�b�N�n�m --EN:--Logic ON
		proxy:SetTeamType(611, TEAM_TYPE_AngryFriend);--�`�[���^�C�v�ύX		 --EN:--Change team type
		SetNpcStateFlag( proxy, param, heartbreak_fighter_flag_list, HEART_BREAK_FIGHTER_STATE_ANGRY );--�G�Ώ�Ԃ� --EN:-- in hostile state
	end
	
	proxy:SetEventFlag( 380, true );
	print("OnEvent_380 end");
end

function OnEvent_381(proxy,param)
	print("OnEvent_381 begin");
	SetNpcStateFlag(proxy, param, heartbreak_fighter_flag_list, HEART_BREAK_FIGHTER_STATE_DEAD );
	proxy:SetEventFlag( 381, true );
	print("OnEvent_381 end");
end

function OnEvent_382(proxy,param)
	print("OnEvent_382 begin");
	--SetNpcStateFlag(proxy, param, heartbreak_fighter_flag_list, HEART_BREAK_FIGHTER_STATE_DEAD );--�����܂��ɂ���͂��Ȃ̂ŁA�R�����g�A�E�g  --EN:--It should disappear, so comment out
	SetNpcStateFlag(proxy, param, heartbreak_fighter_flag_list, HEART_BREAK_FIGHTER_STATE_DELETE );--�����܂��� --EN:--to disappear
	proxy:SetEventFlag( 382, true );
	print("OnEvent_382 end");
end


--��388���� --EN:--��388����
function OnEvent_388(proxy,param)
	print("OnEvent_388 begin");
	proxy:RequestRemo(000025,REMO_FLAG,388,1);
	print("OnEvent_388 end");
end

--�|�����J�n�t�F�[�h�I���� --EN:--After the polyplay start fade
function OnEvent_388_RemoStart(proxy,param)
	print("OnEvent_388_RemoStart begin");
	proxy:Warp( 611 , 2120 );
	print("OnEvent_388_RemoStart end");
end

--�|�����I���t�F�[�h�J�n�O --EN:--Before starting the fade at the end of the poly drama
function OnEvent_388_RemoFinish(proxy,param)
	print("OnEvent_388_RemoFinish begin");
	proxy:SetSpStayAndDamageAnimId(611,7625,-1);
	print("OnEvent_388_RemoFinish end");
end



--------------------------------------------------------------------------------------
--�_�̐M�k1��320�`324 --EN:--God's follower 1 320-324
-------------------------------------------------------------------------------------
function OnEvent_320(proxy,param)
	print("OnEvent_320 begin");
	if proxy:IsCompleteEvent(GOD_BELIEVER_1_STATE_DEAD) == true then--���S���Ă���Ȃ�� --EN:--if dead
		print("OnEvent_320 end");
		return;--���������ɏI�� --EN:--Exit without doing anything
	end
	proxy:EnableLogic(682,true);--���W�b�N�n�m --EN:--Logic ON
	proxy:SetTeamType(682, TEAM_TYPE_AngryFriend);--�`�[���^�C�v�ύX --EN:--Change team type
	SetNpcStateFlag( proxy, param, god_beliver1_flag_list, GOD_BELIEVER_1_STATE_ANGRY );--�G�Ώ�Ԃ� --EN:-- in hostile state
	
	proxy:SetEventFlag( 320, true );
	print("OnEvent_320 end");
end

function OnEvent_321(proxy,param)
	print("OnEvent_321 begin");
	SetNpcStateFlag(proxy, param, god_beliver1_flag_list, GOD_BELIEVER_1_STATE_DEAD );
	proxy:SetEventFlag( 321, true );
	print("OnEvent_321 end");
end

--------------------------------------------------------------------------------------
--�_�̐M�k2��330�`334 --EN:--God's followers 2 330-334
-------------------------------------------------------------------------------------
function OnEvent_330(proxy,param)
	print("OnEvent_330 begin");
	if proxy:IsCompleteEvent(GOD_BELIEVER_2_STATE_DEAD) == true					--���S���Ă���@�� --EN:-- Is it dead?
	or proxy:IsCompleteEvent(GOD_BELIEVER_2_STATE_ISNOTALREADY) == true then	--���łɂ��Ȃ��Ȃ�� --EN:--if not already
		print("OnEvent_330 end");
		return;--���������ɏI�� --EN:--Exit without doing anything
	end
	proxy:EnableLogic(683,true);--���W�b�N�n�m --EN:--Logic ON
	proxy:SetTeamType(683, TEAM_TYPE_AngryFriend);--�`�[���^�C�v�ύX --EN:--Change team type
	SetNpcStateFlag( proxy, param, god_beliver2_flag_list, GOD_BELIEVER_2_STATE_ANGRY );--�G�Ώ�Ԃ� --EN:-- in hostile state
	
	proxy:SetEventFlag( 330, true );
	print("OnEvent_330 end");
end

function OnEvent_331(proxy,param)
	print("OnEvent_331 begin");
	SetNpcStateFlag(proxy, param, god_beliver2_flag_list, GOD_BELIEVER_2_STATE_DEAD );
	proxy:SetEventFlag( 331, true );
	print("OnEvent_331 end");
end

--------------------------------------------------------------------------------------
--�_�̐M�k3��430�`434 --EN:--God's followers 3 430-434
-------------------------------------------------------------------------------------
function OnEvent_430(proxy,param)
	print("OnEvent_430 begin");
	if proxy:IsCompleteEvent(GOD_BELIEVER_3_STATE_DEAD) == true then--���S���Ă���Ȃ�� --EN:--if dead
		print("OnEvent_430 end");
		return;--���������ɏI��		 --EN:--Exit without doing anything
	end
	proxy:EnableLogic(684,true);--���W�b�N�n�m --EN:--Logic ON
	proxy:SetTeamType(684, TEAM_TYPE_AngryFriend);--�`�[���^�C�v�ύX --EN:--Change team type
	SetNpcStateFlag( proxy, param, god_beliver3_flag_list, GOD_BELIEVER_3_STATE_ANGRY );--�G�Ώ�Ԃ� --EN:-- in hostile state
	
	proxy:SetEventFlag( 430, true );
	print("OnEvent_430 end");
end

function OnEvent_431(proxy,param)
	print("OnEvent_431 begin");
	SetNpcStateFlag(proxy, param, god_beliver3_flag_list, GOD_BELIEVER_3_STATE_DEAD );
	proxy:SetEventFlag( 431, true );
	print("OnEvent_431 end");
end

--��435���M�k�R���A�C�e��������遡(��b�Ăяo��) --EN:-- �� 435 �� follower 3 gives an item �� (conversation call)
function OnEvent_435(proxy, param)
	print("OnEvent_435 begin");
	proxy:GetRateItem(10760);--�A�C�e������ --EN:-- Get items
	proxy:GetRateItem(10761);--�A�C�e������ --EN:-- Get items
	proxy:SetEventFlag(435, true);
	print("OnEvent_435 end");
end


--------------------------------------------------------------------------------------
--���p�̓k��310�`314 --EN:--Magic Adept ��310�`314
-------------------------------------------------------------------------------------
function OnEvent_310(proxy,param)
	print("OnEvent_310 begin");
	
	if	proxy:IsCompleteEvent( MAGIC_STUDENT_STATE_ROGARN_HELP ) == true		--���K�[���������ā@�� --EN:--Help Logan?
	or	proxy:IsCompleteEvent( MAGIC_STUDENT_STATE_ROGARN_TOGETHER ) == true	--���K�[���ƈꏏ�@�� --EN:--Are you with Logan?
	or	proxy:IsCompleteEvent( MAGIC_STUDENT_STATE_FALL ) == true then			--���_�Ȃ�� --EN:--if discouraged
		
		proxy:EnableLogic(681,true);--���W�b�N�n�m --EN:--Logic ON
		proxy:SetTeamType(681, TEAM_TYPE_AngryFriend);--�`�[���^�C�v�ύX --EN:--Change team type
		SetNpcStateFlag( proxy, param, magic_student_flag_list, MAGIC_STUDENT_STATE_ANGRY );--�G�Ώ�Ԃ� --EN:-- in hostile state
	end
	
	proxy:SetEventFlag( 310, true );
	
	print("OnEvent_310 begin");
end

function OnEvent_311(proxy,param)
	print("OnEvent_311 begin");
	SetNpcStateFlag( proxy, param, magic_student_flag_list, MAGIC_STUDENT_STATE_DEAD );
	proxy:SetEventFlag( 311, true );
	print("OnEvent_311 begin");
end



--------------------------------------------------------------------------------------
--�E���x�C����270�`274 --EN:--Ulbane 270-274
-------------------------------------------------------------------------------------
--�E���x�C���G�� --EN:-- Urbain Hostile
function OnEvent_270(proxy,param)
	print("OnEvent_270 begin");
	proxy:EnableLogic(690,true);--���W�b�N�n�m --EN:--Logic ON
	proxy:SetTeamType(690, TEAM_TYPE_AngryFriend);--�`�[���^�C�v�ύX --EN:--Change team type
	SetNpcStateFlag( proxy, param, urubain_flag_list, URUBAIN_STATE_STONE_PILLAR_ANGRY );--�G�Ώ�Ԃ� --EN:-- in hostile state
	
	--�E���l�����{��ɂȂ�ꂽ�̂ŁA�M�k�B���{�� --EN:--Since Uru-sama got angry, the believers also get angry
	proxy:LuaCallStart(320, 1);--�M�k�P�G�Ή��n���h������ --EN:--Activate hostile handler for follower 1
	proxy:LuaCallStart(330, 1);--�M�k�Q�G�Ή��n���h������ --EN:--Activate hostile handler for follower 2
	proxy:LuaCallStart(430, 1);--�M�k�R�G�Ή��n���h������ --EN:--Cultist 3 hostile handler activated
	
	proxy:SetEventFlag( 270, true );
	print("OnEvent_270 end");
end

--�E���x�C�����S --EN:--Urbain dies
function OnEvent_271(proxy,param)
	print("OnEvent_271 begin");
	SetNpcStateFlag( proxy, param, urubain_flag_list, URUBAIN_STATE_DEAD );
	proxy:SetEventFlag( 271, true );
	print("OnEvent_271 end");
end



--------------------------------------------------------------------------------------
--�����g��280�`283 --EN:--Yurt 280�`283
-------------------------------------------------------------------------------------
--�����g�G�� --EN:--Yurt Adversarial
function OnEvent_280(proxy,param)
	print("OnEvent_280 begin");
	proxy:EnableLogic(619,true);--���W�b�N�n�m --EN:--Logic ON
	proxy:SetTeamType(619, TEAM_TYPE_AngryFriend);--�`�[���^�C�v�ύX --EN:--Change team type
	SetNpcStateFlag( proxy, param, yuruto_flag_list, YURUTO_STATE_ANGRY_M1 );--�G�Ώ�Ԃ�	 --EN:-- in hostile state
	proxy:SetEventFlag( 280, true );
	print("OnEvent_280 end");
end

--�����g���S --EN:--Yurt dead
function OnEvent_281(proxy,param)
	print("OnEvent_281 begin");
	SetNpcStateFlag( proxy, param, yuruto_flag_list, YURUTO_STATE_DEAD );
	proxy:SetEventFlag( 281, true );
	print("OnEvent_281 end");
end

--�����g�̎��̒��ׂ� --EN:--Examined Yurt's corpse
function OnEvent_15630(proxy,param)
	print("OnEvent_15630 begin");
	proxy:SetEventFlag( 15630 , true );
	print("OnEvent_15630 end");
end


--------------------------------------------------------------------------------------
--�o�b�`��290�`294 --EN:--Batch 290-294
-------------------------------------------------------------------------------------
--�o�b�`�G�� --EN:--Batch adversarial
function OnEvent_290(proxy,param)
	print("OnEvent_290 begin");
	proxy:EnableLogic(693,true);--���W�b�N�n�m --EN:--Logic ON
	proxy:SetTeamType(693, TEAM_TYPE_AngryFriend);--�`�[���^�C�v�ύX --EN:--Change team type
	SetNpcStateFlag( proxy, param, batti_flag_list, BATTI_ANGRY_M1 );--�G�Ώ�Ԃ� --EN:-- in hostile state
	
	proxy:SetEventFlag( 290, true );
	print("OnEvent_290 end");
end

--�o�b�`���S --EN:--batch death
function OnEvent_291(proxy,param)
	print("OnEvent_291 begin");
	SetNpcStateFlag( proxy, param, batti_flag_list, BATTI_DEAD );
	proxy:SetEventFlag( 291, true );
	print("OnEvent_291 end");
end


--------------------------------------------------------------------------------------
--������260�`264 --EN:--Witch 260�`264
-------------------------------------------------------------------------------------
--�����G�� --EN:--witch hostility
function OnEvent_260(proxy,param)
	print("OnEvent_260 begin");
	proxy:EnableLogic(689,true);--���W�b�N�n�m --EN:--Logic ON
	proxy:SetTeamType(689, TEAM_TYPE_AngryFriend);--�`�[���^�C�v�ύX --EN:--Change team type
	SetNpcStateFlag( proxy, param, majo_flag_list, MAJO_STATE_ANGRY_M1 );--�G�Ώ�� --EN:--hostile state

	proxy:SetEventFlag( 260, true );
	print("OnEvent_260 end");
end

--�������S --EN:--Witch Death
function OnEvent_261(proxy,param)
	print("OnEvent_261 begin");
	SetNpcStateFlag( proxy, param, majo_flag_list, MAJO_STATE_DEAD );
	proxy:SetEventFlag( 261, true );
	print("OnEvent_261 end");
end


--------------------------------------------------------------------------------------
--�r�������O������240�`245 --EN:--Bjrn Grum 240�`245
-------------------------------------------------------------------------------------
--�r�������O�����G�� --EN:-- Bjrn Grum Hostile
function OnEvent_240(proxy,param)
	print("OnEvent_240 begin");
	proxy:EnableLogic(695,true);--���W�b�N�n�m --EN:--Logic ON
	proxy:SetTeamType(695, TEAM_TYPE_AngryFriend);--�`�[���^�C�v�ύX --EN:--Change team type
	SetNpcStateFlag(proxy,param,biyo_flag_list,BIYO_STATE_HOSTILE_IN_STONE_PILLAR);--�G�Ώ�Ԃ� --EN:-- in hostile state
	proxy:EraseEventSpecialEffect_2(695,5064);
	proxy:SetEventFlag( 240, true );
	print("OnEvent_240 end");
end

--�r�������O�������S --EN:--Bjrn Grum died
function OnEvent_241(proxy,param)
	print("OnEvent_241 begin");
	SetNpcStateFlag( proxy, param, biyo_flag_list, BIYO_STATE_DEAD );
	proxy:SetEventFlag( 241, true );
	print("OnEvent_241 end");
end




--------------------------------------------------------------------------------------
--���K�[����220�`225 --EN:-- Logan 220-225
-------------------------------------------------------------------------------------
--���K�[���G�� --EN:--Logan hostility
function OnEvent_221(proxy,param)
	print("OnEvent_221 begin");
	SetNpcStateFlag( proxy, param, rogarn_flag_list, ROGARN_STATE_ANGRY_M1 );--��Ԃ�G�΂� --EN:--Adversarial State
	proxy:SetTeamType(617, TEAM_TYPE_AngryFriend);--�`�[���^�C�v�ύX --EN:--Change team type
	proxy:SetEventFlag( 240, true );
	
	--���p�̓k�G�� --EN:--Magical antagonism
	if	proxy:IsCompleteEvent( MAGIC_STUDENT_STATE_ROGARN_HELP ) == true		--���K�[���������ā@�� --EN:--Help Logan?
	or	proxy:IsCompleteEvent( MAGIC_STUDENT_STATE_ROGARN_TOGETHER ) == true	--���K�[���ƈꏏ�@�� --EN:--Are you with Logan?
	or	proxy:IsCompleteEvent( MAGIC_STUDENT_STATE_FALL ) == true then			--���_�Ȃ�� --EN:--if discouraged
		
		proxy:EnableLogic(681,true);--���W�b�N�n�m --EN:--Logic ON
		proxy:SetTeamType(681, TEAM_TYPE_AngryFriend);--�`�[���^�C�v�ύX --EN:--Change team type
		SetNpcStateFlag( proxy, param, magic_student_flag_list, MAGIC_STUDENT_STATE_ANGRY );--�G�Ώ�Ԃ� --EN:-- in hostile state
	end
	
	print("OnEvent_221 end");
end

--���K�[�����S --EN:--Logan died
function OnEvent_222(proxy,param)
	print("OnEvent_222 begin");
	SetNpcStateFlag( proxy, param, rogarn_flag_list, ROGARN_STATE_DEAD );
	proxy:SetEventFlag( 240, true );
	print("OnEvent_222 end");
end

--------------------------------------------------------------------------------------
--�g�}�X��350�`354 --EN:--Thomas 350�`354
-------------------------------------------------------------------------------------
--�g�}�X�G�� --EN:--Thomas Hostile
function OnEvent_350(proxy,param)
	print("OnEvent_350 end");
	proxy:EnableLogic(687,true);--���W�b�N�n�m --EN:--Logic ON
	proxy:SetTeamType(687, TEAM_TYPE_AngryFriend);--�`�[���^�C�v�ύX --EN:--Change team type
	SetNpcStateFlag( proxy, param, tomasu_flag_list, TOMASU_STATE_ANGRY );--�G�Ώ�Ԃ�	 --EN:-- in hostile state
	proxy:SetEventFlag( 350, true );
	print("OnEvent_350 end");
end

--�g�}�X���S --EN:--Thomas dies
function OnEvent_351(proxy,param)
	print("OnEvent_351 end");
	SetNpcStateFlag( proxy, param, tomasu_flag_list, TOMASU_STATE_DEAD );
	proxy:SetEventFlag( 351, true );
	print("OnEvent_351 end");
end


--------------------------------------------------------------------------------------
--�����h�����q��230�`233 --EN:--Prince Lendl 230�`233
-------------------------------------------------------------------------------------
function OnEvent_230(proxy,param)
	print("OnEvent_230 begin");
	SetNpcStateFlag( proxy, param, rendol_flag_list, RENDOL_STATE_HOSTILE_STONE_PILLAR );
	proxy:EnableLogic(688,true);--���W�b�N�n�m --EN:--Logic ON
	proxy:SetTeamType(688, TEAM_TYPE_AngryFriend);--�`�[���^�C�v�ύX --EN:--Change team type
	proxy:EraseEventSpecialEffect_2(688,5063);
	proxy:SetEventFlag( 230, true );
	print("OnEvent_230 end");
end

function OnEvent_231(proxy,param)
	print("OnEvent_231 begin");
	SetNpcStateFlag( proxy, param, rendol_flag_list, RENDOL_STATE_DEAD );
	proxy:SetEventFlag( 231, true );
	print("OnEvent_231 end");
end




--------------------------------------------------------------------------------------
--���t�B�X�g��360�`372 --EN:-- Mephisto 360-372
-------------------------------------------------------------------------------------
--���t�B�X�g�G�� --EN:-- Mephisto Hostile
function OnEvent_360(proxy,param)
	print("OnEvent_360 end");
			proxy:EnableLogic(680,true);--���W�b�N�n�m --EN:--Logic ON
			proxy:SetTeamType(680, TEAM_TYPE_AngryFriend);--�`�[���^�C�v�ύX --EN:--Change team type
			SetNpcStateFlag( proxy, param, mefist_flag_list, MEFIST_STATE_ANGRY );--�G�Ώ�Ԃ� --EN:-- in hostile state
	proxy:SetEventFlag( 360, true );
	print("OnEvent_360 end");
end

--���t�B�X�g���S --EN:-- Mephisto dies
function OnEvent_361(proxy,param)
	print("OnEvent_361 end");
	SetNpcStateFlag( proxy, param, mefist_flag_list, MEFIST_STATE_DEAD );
	proxy:SetEventFlag( 361, true );
	print("OnEvent_361 end");
end


--���t�B�X�g �@�y�����h�����q�z�E�Q�񍐑҂� --EN:--Mephisto [Prince Lendl] Awaiting murder report
function OnEvent_362(proxy,param)
	print("OnEvent_362 end");
	SetNpcStateFlag(proxy, param, mefist_flag_list, MEFIST_STATE_KILL_WAIT_RENDOL );
	proxy:SetEventFlag( 362, true );
	print("OnEvent_362 end");
end

--���t�B�X�g �@�y�r�������O�����z�E�Q�񍐑҂� --EN:-- Mephisto [Bjrn Gurm] Awaiting murder report
function OnEvent_363(proxy,param)
	print("OnEvent_363 end");
	SetNpcStateFlag(proxy, param, mefist_flag_list, MEFIST_STATE_KILL_WAIT_BIYO );
	proxy:SetEventFlag( 363, true );
	print("OnEvent_363 end");
end

--���t�B�X�g �@�y���K�[���z�E�Q�񍐑҂� --EN:--Mephisto [Logan] Awaiting murder report
function OnEvent_364(proxy,param)
	print("OnEvent_364 end");
	SetNpcStateFlag(proxy, param, mefist_flag_list, MEFIST_STATE_KILL_WAIT_ROGARN );
	proxy:SetEventFlag( 364, true );
	print("OnEvent_364 end");
end

--���t�B�X�g �@�y�����z�E�Q�񍐑҂� --EN:-- Mephisto [Witch] Awaiting murder report
function OnEvent_365(proxy,param)
	print("OnEvent_365 end");
	SetNpcStateFlag(proxy, param, mefist_flag_list, MEFIST_STATE_KILL_WAIT_MAJO );
	proxy:SetEventFlag( 365, true );
	print("OnEvent_365 end");
end

--���t�B�X�g �@�y�E���x�C���z�E�Q�񍐑҂� --EN:--Mephisto [Urbain] Awaiting murder report
function OnEvent_366(proxy,param)
	print("OnEvent_366 end");
	SetNpcStateFlag(proxy, param, mefist_flag_list, MEFIST_STATE_KILL_WAIT_URU );
	proxy:SetEventFlag( 366, true );
	print("OnEvent_366 end");
end

--���t�B�X�g �@�y�g�}�X�z�E�Q�񍐑҂� --EN:-- Mephisto [Thomas] Awaiting murder report
function OnEvent_367(proxy,param)
	print("OnEvent_367 end");
	SetNpcStateFlag(proxy, param, mefist_flag_list, MEFIST_STATE_KILL_WAIT_TOMASU );
	proxy:SetEventFlag( 367, true );
	print("OnEvent_367 end");
end

--���t�B�X�g �@�y�o�b�`�z�E�Q�񍐑҂� --EN:-- Mephisto [Batch] Awaiting murder report
function OnEvent_368(proxy,param)
	print("OnEvent_368 end");
	SetNpcStateFlag(proxy, param, mefist_flag_list, MEFIST_STATE_KILL_WAIT_BATTI );
	proxy:SetEventFlag( 368, true );
	print("OnEvent_368 end");
end

--���t�B�X�g �@���z���G�� --EN:-- Mephisto Declaration of War Hostility
function OnEvent_369(proxy,param)
	print("OnEvent_369 end");
	proxy:EnableLogic(680,true);--���W�b�N�n�m --EN:--Logic ON
	proxy:SetTeamType(680, TEAM_TYPE_AngryFriend);--�`�[���^�C�v�ύX --EN:--Change team type
	SetNpcStateFlag( proxy, param, mefist_flag_list, MEFIST_STATE_ANGRY );--�G�Ώ�Ԃ� --EN:-- in hostile state
	
	proxy:SetEventFlag( 369, true );
	print("OnEvent_369 end");
end

--�y���q�z�E�Q�̂��� --EN:--[Prince] Gratitude for murder
function OnEvent_400(proxy,param)
	print("OnEvent_400 end");
	
	proxy:GetRateItem( 10710 );
	proxy:SetEventFlag( 400, true );
	
	print("OnEvent_400 end");
end

--�y�r�������O�����z�E�Q�̂��� --EN:--[Bjrn Grum] Gratitude for the murder
function OnEvent_401(proxy,param)
	print("OnEvent_401 end");
	
	proxy:GetRateItem( 10711 );
	proxy:SetEventFlag( 401, true );
	
	print("OnEvent_401 end");
end

--�y���K�[���z�E�Q�̂��� --EN:--[Logan] Thank you for killing
function OnEvent_402(proxy,param)
	print("OnEvent_402 end");
	
	proxy:GetRateItem( 10712 );
	proxy:SetEventFlag( 402, true );
	
	print("OnEvent_402 end");
end

--�y�����z�E�Q�̂��� --EN:--[Witch] Gratitude for Killing
function OnEvent_403(proxy,param)
	print("OnEvent_403 end");
	
	proxy:GetRateItem( 10713 );
	proxy:SetEventFlag( 403, true );
	
	print("OnEvent_403 end");
end

--�y�E���x�C���z�E�Q�̂��� --EN:--[Ulbane] Gratitude for killing
function OnEvent_404(proxy,param)
	print("OnEvent_404 end");
	
	proxy:GetRateItem( 10714 );
	proxy:SetEventFlag( 404, true );
	
	print("OnEvent_404 end");
end

--�y�g�}�X�z�E�Q�̂��� --EN:--[Thomas] Gratitude for the murder
function OnEvent_405(proxy,param)
	print("OnEvent_405 end");
	
	proxy:GetRateItem( 10715 );
	proxy:SetEventFlag( 405, true );
	
	print("OnEvent_405 end");
end

--�y�o�b�`�z�E�Q�̂��� --EN:--[Batch] Gratitude for Killing
function OnEvent_406(proxy,param)
	print("OnEvent_406 end");
	
	proxy:GetRateItem( 10716 );
	proxy:SetEventFlag( 406, true );
	
	print("OnEvent_406 end");
end

------------------------------------------------------------------------------------
--BGM�֘AOnEvent --EN:--BGM related OnEvent
------------------------------------------------------------------------------------
--�X�e�[�W�N���A���ɂ���čĐ�����BGM��ύX���� --EN:--Change the BGM to be played depending on the number of stages cleared
function PlayBGM_SEKITYUU(proxy, param)
	if ClearBlockCount ~= 5 then
		if ClearBlockCount >= 3 then--�X�e�[�W�N���A��3�ȏ� --EN:--3 or more stage clears
			print("--��421��BGM�Đ�2��"); --EN:--��421��BGM playback 2��");
			proxy:RepeatMessage_begin();
				--proxy:LuaCall(421, 0, "OnEvent_421", everytime);--BGM�𗬂�OnEvent�𔭓������� --EN:--Activate OnEvent to play BGM
				proxy:PlayPointSE( 2050, SOUND_TYPE_M, 010100000, 0 );
				print("010100000�Đ�"); --EN:print("010100000 plays");
				proxy:SetEventFlag( 421, true );
				--proxy:DeleteEvent( 421 );--442�̂悤��everytime�ł͂Ȃ��̂� --EN:--because it's not everytime like 442
			proxy:RepeatMessage_end();	
			
		elseif ClearBlockCount <= 2 then--�X�e�[�W�N���A��2�ȉ� --EN:-- Number of stages cleared 2 or less
			print("--��420��BGM�Đ�1��"); --EN:--��420��BGM playback 1��");
			proxy:RepeatMessage_begin();
				--proxy:LuaCall( 420 , 0 , "OnEvent_420", once );--BGM�𗬂�OnEvent�𔭓������� --EN:--Activate OnEvent to play BGM
				proxy:PlayPointSE( 2050, SOUND_TYPE_M, 010000000, 0 );
				print("010000000�Đ�"); --EN:print("010000000 plays");
				proxy:SetEventFlag( 420, true );
				--proxy:DeleteEvent( 420 );--442�̂悤��everytime�ł͂Ȃ��̂� --EN:--because it's not everytime like 442
			proxy:RepeatMessage_end();
			
		end
	else
		print("--��440��BGM�Đ�3��"); --EN:--��440��BGM playback 3��");
		proxy:RepeatMessage_begin();
			--proxy:LuaCall( 440 , 0 , "OnEvent_420", once );--BGM�𗬂�OnEvent�𔭓������� --EN:--Activate OnEvent to play BGM
			proxy:PlayPointSE( 2020, SOUND_TYPE_C, 600004000, 0 );
			print("600004000�Đ�"); --EN:print("600004000 plays");
			proxy:SetEventFlag( 440, true );
			--proxy:DeleteEvent( 420 );--442�̂悤��everytime�ł͂Ȃ��̂� --EN:--because it's not everytime like 442
		proxy:RepeatMessage_end();
	end
end

--���X�{�X��BGM --EN:--Last Boss Battle BGM
function OnEvent_422(proxy,param)
	print("OnEvent_422 begin");
		proxy:EnableLogic( 821, true );
		proxy:PlayPointSE( 2060, SOUND_TYPE_M, 010200000, 1 );
		--�{�X�Q�[�W�\�� --EN:-- Boss gauge display
		proxy:SetBossGauge(821, 0, 4000);
		proxy:SetEventFlag( 422, true );
		proxy:DeleteEvent( 422 );
	print("OnEvent_422 end");
end


------------------------------------------------------------------------------------
--304���q���C������A�C�e����Ⴄ --EN:--304�� Receive items from the heroine
------------------------------------------------------------------------------------
function OnEvent_304(proxy,param)
	print("OnEvent_304 begin");
	
	proxy:SetEventFlag( 304, true );	
	
	--if proxy:GetClearCount() == 0 then	
	if proxy:IsInventoryEquip(TYPE_GOODS,9997) == false then	
		proxy:GetRateItem( 10740 );
		proxy:GetRateItem( 10850 );
		--Lua_PauseTutorial(proxy);
		proxy:OnKeyTime2( 304 , "OnEvent_304_1",0.1,0,0,once);
	end
	
	print("OnEvent_304 end");
end

--�A�C�e������\��OFF�҂� --EN:--Wait for item acquisition display OFF
function OnEvent_304_1(proxy,param)
	print("OnEvent_304_1 begin");
	proxy:OnRegistFunc( 112 , "Check_112","OnEvent_112",1,once);
	print("OnEvent_304_1 end");
end

--�`�F�b�N --EN:--check
function Check_112(proxy)
	if proxy:IsShowMenu() == true then
		return false;
	end
	return true;
end

--�����̐ΐ��� --EN:--Blue Eye Stone Description
function OnEvent_112(proxy,param)
	print("OnEvent_112 begin");
	proxy:SetEventFlag(112, true);
	--Display_InfomationMenu_2(proxy, 0, -1, 30, 84001000, 1, -1, 30, 84001001, 6);
	proxy:RequestOpenBriefingMsgPlus(84001001,true);
	--Lua_PauseTutorial(proxy);	
	
	proxy:OnKeyTime2( 112 , "OnEvent_112_1", 0.1 , 0 , 1 ,once );
	print("OnEvent_112 end");
end

function OnEvent_112_1(proxy,param)
	proxy:OnRegistFunc( 114 , "Check_114","OnEvent_114",1,once);
end

--�`�F�b�N --EN:--check
function Check_114(proxy)
	if proxy:IsShowMenu() == true then
		return false;
	end
	return true;
end

--�q���C������ --EN:-- Heroine Description
function OnEvent_114(proxy,param)
	print("OnEvent_114 begin");
	--Display_InfomationMenu_2(proxy, 0, -1, 30, 84001100, 1, -1, 30, 84001101, 6);	
	--Lua_PauseTutorial(proxy);
	proxy:OnKeyTime2( 114 , "OnEvent_114_wait",0.1,0,20,once);	
	print("OnEvent_114 end");
end

function OnEvent_114_wait(proxy,param)
	print("OnEvent_114_wait begin");	
	proxy:RequestOpenBriefingMsgPlus(84001101,true);
	proxy:OnRegistFunc( 114 , "Check_114_1","OnEvent_114_1",5,once);
	print("OnEvent_114_wait end");
end

--�`�F�b�N --EN:--check
function Check_114_1(proxy)
	if proxy:IsShowMenu() == true then
		return false;
	end
	return true;
end

--���j���[��������t���O�𗧂Ă� --EN:--Flag when the menu closes
function OnEvent_114_1(proxy,param)
	print("OnEvent_114_1 begin");
	proxy:SetEventFlag(114, true);
	print("OnEvent_114_1 end");
end


------------------------------------------------------------------------------------
--304���q���C������A�C�e����Ⴄ --EN:--304�� Receive items from the heroine
------------------------------------------------------------------------------------
function OnEvent_305(proxy,param)
	print("OnEvent_305 begin");	
	proxy:SetEventFlag( 304, true );
	proxy:GetRateItem( 10741 );	
	print("OnEvent_305 end");
end

------------------------------------------------------------------------------------
--42���Β����ւ̃��[�f�B���O --EN:--42�� Loading under the stone pillar
------------------------------------------------------------------------------------
function OnEvent_42(proxy,param)
	print("OnEvent_42 begin");
	proxy:RepeatMessage_begin();
	--��42_0���I�����j���[�̊Ď��� --EN:--��42_0��Monitor selection menu��
		proxy:OnSelectMenu(42, "OnEvent_42_0", 10010730, 0, 2, 1140, 2, once);			
	proxy:RepeatMessage_end();
	print("OnEvent_42 end");
end

--��42_0���I�����j���[�̊Ď��� --EN:--��42_0��Monitor selection menu��
function OnEvent_42_0(proxy, param)
	print("OnEvent_42_0 begin");	
	proxy:PlayAnimation( 10000 , 8283 );--�v�΂ɐG���A�j�����Đ�	 --EN:--Play the animation that touches the keystone
	proxy:NoAnimeTurnCharactor( 10000 , 1140 ,TURNSKIP_ANGLE);
	proxy:NotNetMessage_begin();
		--���v�΂ɐG���A�j���Đ��I���� --EN:--��Animation touching the keystone ends��
		proxy:OnChrAnimEnd( 42 , 10000 , 8283 , "OnEvent_42_1" , once );
	proxy:NotNetMessage_end();
	proxy:SetEventFlag( 42 , 1 );
	
	print("OnEvent_42_0 end");
end

--��42_1���v�΂ɐG���A�j���Đ��I���� --EN:--��42_1��End of playing the animation touching the keystone��
function OnEvent_42_1(proxy, param)
	print("OnEvent_42_1 begin");	
	proxy:PlayAnimation( 10000 , 8284 );--�����E�ɋA��A�j�����Đ�		 --EN:--Play animation to return to your own world
	OnEvent_42_2(proxy,param);
	
	print("OnEvent_42_1 end");
end

--�������E�ɋA��A�j���Đ��I���� --EN:--��Returning to your own world, end of animation ��
function OnEvent_42_2(proxy,param)	
	print("OnEvent_42_2 begin");	
	--���S�񕜗v�� --EN:-- full recovery request
	proxy:RequestFullRecover();
	proxy:WarpNextStage( 1, 0, 0, 0, 2101 );	
	print("OnEvent_42_2 end");
end


------------------------------------------------------------------------------------
--44���Β����ւ̃��[�f�B���O2 --EN:--44 �� Loading under the stone pillar 2
------------------------------------------------------------------------------------
function OnEvent_44(proxy,param)
	print("OnEvent_44 begin");
	proxy:RepeatMessage_begin();
	--��42_0���I�����j���[�̊Ď��� --EN:--��42_0��Monitor selection menu��
		proxy:OnSelectMenu(42, "OnEvent_44_0", 10010730, 0, 2, 1140, 2, once);			
	proxy:RepeatMessage_end();
	print("OnEvent_44 end");
end

--��42_0���I�����j���[�̊Ď��� --EN:--��42_0��Monitor selection menu��
function OnEvent_44_0(proxy, param)
	print("OnEvent_44_0 begin");	
	proxy:PlayAnimation( 10000 , 8283 );--�v�΂ɐG���A�j�����Đ�	 --EN:--Play the animation that touches the keystone
	proxy:NoAnimeTurnCharactor( 10000 , 1140 ,TURNSKIP_ANGLE);
	proxy:NotNetMessage_begin();
		--���v�΂ɐG���A�j���Đ��I���� --EN:--��Animation touching the keystone ends��
		proxy:OnChrAnimEnd( 42 , 10000 , 8283 , "OnEvent_44_1" , once );
	proxy:NotNetMessage_end();
	proxy:SetEventFlag( 42 , 1 );
	
	print("OnEvent_44_0 end");
end

--��42_1���v�΂ɐG���A�j���Đ��I���� --EN:--��42_1��End of playing the animation touching the keystone��
function OnEvent_44_1(proxy, param)
	print("OnEvent_44_1 begin");	
	proxy:PlayAnimation( 10000 , 8284 );--�����E�ɋA��A�j�����Đ�		 --EN:--Play animation to return to your own world
	OnEvent_44_2(proxy,param);
	
	print("OnEvent_44_1 end");
end

--�������E�ɋA��A�j���Đ��I���� --EN:--��Returning to your own world, end of animation ��
function OnEvent_44_2(proxy,param)	
	print("OnEvent_44_2 begin");	
	--���S�񕜗v�� --EN:-- full recovery request
	proxy:RequestFullRecover();
	proxy:WarpNextStage( 1, 0, 0, 0, 2102 );	
	print("OnEvent_44_2 end");
end


------------------------------------------------------------------------------------
--43���Β���ւ̃��[�f�B���O --EN:--43�� Loading onto stone pillars
------------------------------------------------------------------------------------
function OnEvent_43(proxy,param)
	print("OnEvent_43 begin");
	proxy:RepeatMessage_begin();
	--��43_0���I�����j���[�̊Ď��� --EN:--��43_0��Monitor selection menu��
		proxy:OnSelectMenu(43, "OnEvent_43_0", 10010710, 0, 2, 1145, 2, once);			
	proxy:RepeatMessage_end();
	print("OnEvent_43 end");
end

--��43_0���I�����j���[�̊Ď��� --EN:--��43_0��Monitor selection menu��
function OnEvent_43_0(proxy, param)
	print("OnEvent_43_0 begin");	
	proxy:PlayAnimation( 10000 , 8283 );--�v�΂ɐG���A�j�����Đ�	 --EN:--Play the animation that touches the keystone
	proxy:NoAnimeTurnCharactor( 10000 , 1145 ,TURNSKIP_ANGLE);
	proxy:NotNetMessage_begin();
		--���v�΂ɐG���A�j���Đ��I���� --EN:--��Animation touching the keystone ends��
		proxy:OnChrAnimEnd( 43 , 10000 , 8283 , "OnEvent_43_1" , once );
	proxy:NotNetMessage_end();
	proxy:SetEventFlag( 43 , 1 );
	
	print("OnEvent_43_0 end");
end

--��43_1���v�΂ɐG���A�j���Đ��I���� --EN:--��43_1��End of playing the animation touching the keystone��
function OnEvent_43_1(proxy, param)
	print("OnEvent_43_1 begin");	
	proxy:PlayAnimation( 10000 , 8284 );--�����E�ɋA��A�j�����Đ�		 --EN:--Play animation to return to your own world
	OnEvent_43_2(proxy,param);
	
	print("OnEvent_43_1 end");
end

--�������E�ɋA��A�j���Đ��I���� --EN:--��Returning to your own world, end of animation ��
function OnEvent_43_2(proxy,param)	
	print("OnEvent_43_2 begin");	
	--���S�񕜗v�� --EN:-- full recovery request
	proxy:RequestFullRecover();
	proxy:WarpNextStage( 1, 0, 0, 0, 2100 );	
	print("OnEvent_43_2 end");
end

--------------------------------------------------------------------------------------
--�{�X�����̒��ɓ��遡61 --EN:--Enter the boss room 61
--------------------------------------------------------------------------------------
--���C�x���g�����[�v�Ȃ̂ŁA�S�����s�[�g�ɂ��遫 --EN:--�� Since the event is a loop, repeat all ��
--��61�����{�X�����ւ̔����J���� --EN:-- �� 61 �� The door to the middle boss room opens ��
function OnEvent_61(proxy,param)	
	print("OnEvent_61 begin");
	
	if proxy:IsCompleteEvent( SYSTEM_ID_IGNORE ) == true then
		print("OnEvent_61 end");
		return;
	end
	
	proxy:LuaCallStart( 61 , 1 );--����A�j���̓����Đ� --EN:-- Synchronous playback of turning animation
	proxy:SetEventFlag( SYSTEM_ID_IGNORE, true );
	proxy:SetEventFlag( 61, true );
	
	--�v���t�@�C���̃Z�[�u --EN:-- save profile
	proxy:SaveRequest_Profile()
	print("OnEvent_61 end");
end


--����A�j���̓����Đ�(ID����) --EN:-- Synchronized playback of turning animation (ID is different)
function OnEvent_61_1(proxy,param)
	print("OnEvent_61_1 begin");
	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		if param:IsNetMessage() == true then
			--����A�j���Đ��𓯊� --EN:-- Synchronize turning animation playback
			proxy:TurnCharactor( 10001 + param:GetPlayID(), 2891 );
		else
			--����A�j���Đ����s���A���̏I������OnEvent_61_2�𔭍s���� --EN:--Play the turning animation and issue OnEvent_61_2 at the end
			proxy:OnTurnCharactorEnd( 61, 10000, 2891, "OnEvent_61_2", once );
		end
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();	
	
	print("OnEvent_61_1 end");
end

--����A�j���̓����Đ��I���� --EN:--After synchronous playback of turning animation ends
function OnEvent_61_2(proxy,param)
	print("OnEvent_61_2 begin");
	
	--�����p�����A�j���Đ� --EN:--Play walking animation for synchronization
	proxy:LuaCallStart( 4012, 1 );
	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		proxy:OnChrAnimEnd( 61, 10000, ANIMEID_WALK, "OnEvent_61_3", once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
		
	print("OnEvent_61_2 end");
end

--�����A�j���̓����Đ��I���� --EN:--After the synchronized playback of the walking animation ends
function OnEvent_61_3(proxy,param)
	print("OnEvent_61_3 begin");

	--�ŏ��̐l���{�X�����̒��ɓ���I����Ă�����A���ɔz�M����Ă���͂��Ȃ̂ŁA����������Ȃ��n���h�� --EN:--If the first person has already entered the boss room, it should have already been delivered, so no more handlers
	if proxy:IsCompleteEvent( 61 ) == false then
		proxy:LuaCallStart( 61 , 5 );--2��ڈȍ~�Ƀ{�X�����ɓ��邽�߂̃C�x���g�z�M�p --EN:--For event delivery to enter the boss room after the second time
	end

	--�v���C���[�����̒��Ɋ��S�ɂ͂������^�C�~���O�ŁA�{�X�̎v�l�����Z�b�g --EN:--Reset the boss' thoughts when the player is completely inside the door
	--�ꏊ�������ƃv���C���[��������Ȃ�����(�U�����Ă��Ȃ�) --EN:--Because you can't find the player if the location is bad (they won't attack)
	if proxy:IsClient() == false then
		proxy:ResetThink( 821 );
	end
	
	proxy:LuaCallStart( 61 , 6 );--�t���O�Z�b�g(�����p) --EN:--flag set (for synchronization)
	proxy:SetEventFlag( SYSTEM_ID_IGNORE,false);	
	print("OnEvent_61_3 end");
end

--[[�폜�Ƃ̎��Ȃ̂ŁA�R�����g�A�E�g --EN:--[[Deleting, so comment out
--------------------------------------------------------------------------------------
--������G�΁�340 --EN:-- Savvy hostility �� 340
--------------------------------------------------------------------------------------
--��341��������G�΁� --EN:-- �� 341 �� knowledgeable hostility ��
function OnEvent_340(proxy, param)
	print("OnEvent_340 begin");
	proxy:EnableLogic(686,true);--���W�b�N�n�m --EN:--Logic ON
	proxy:SetTeamType(686, TEAM_TYPE_AngryFriend);--�`�[���^�C�v�ύX --EN:--Change team type
	SetNpcStateFlag( proxy, param, monoshiri_flag_list, MONOSHIRI_STATE_HOSTILE );--�G�Ώ�Ԃ� --EN:-- in hostile state

	proxy:SetEventFlag( 340 , 1 );
	print("OnEvent_340 end");
end
--------------------------------------------------------------------------------------
--�����莀�S��341 --EN:--Knowledge death ��341
--------------------------------------------------------------------------------------
--��340�������莀�S�� --EN:-- �� 340 �� knowledgeable death ��
function OnEvent_341(proxy, param)
	print("OnEvent_341 begin");

	--������̏�ԃt���O���u���S�v�ɂ��� --EN:-- Set Savvy's status flag to "dead"
	SetNpcStateFlag(proxy, param, monoshiri_flag_list, MONOSHIRI_STATE_DEAD );
	proxy:SetEventFlag( 341 , 1 );
	
	print("OnEvent_341 end");
end
]]



--PC���Β��ɖ߂��Ă������Ƀq���C���̈ʒu�����肷��֐� --EN:--Function to determine the position of the heroine when the PC returns to the stone pillar
function Lua_SetHeroinPos(proxy,param)
	
	--�����X�e�[�^�X��ݒ� --EN:--set initial status
	SetFirstNpcStateFlag( proxy , param , warp_list , GO_TO_WARP_OUJOU );	
	
	--�A�j��ID�̒萔�p�� --EN:-- Prepare anime ID constants
	local a0000 = -1;
	local a7003 = 7003;--���� --EN:--sitting
	local a7004 = 7004;--���� --EN:--sitting
	local a7005 = 7005;--���� --EN:--Standing
	local a7006 = 7006;--����	 --EN:--sitting
	local a7007 = 7003;--���� --EN:--sitting
	local a7008 = 7008;--���� --EN:--sitting
	local a7009 = 7005;--���� --EN:--Standing
	
	local d0000 = -1;
	local d7003 = 9600;
	local d7004 = 9600;
	local d7005 = -1;
	local d7006 = 9600;
	local d7007 = 9600;
	local d7008 = 9600;
	local d7009 = -1;
	
	local c0000 = -1;
	local c7003 = 7024;	
	local c7004 = 7022;
	local c7005 = -1;
	local c7006 = 7025;
	local c7007 = 7024;
	local c7008 = 7023;
	local c7009 = -1;
	
	--����ɍs���Ă��� --EN:--I went to the royal castle
	if proxy:IsCompleteEvent( GO_TO_WARP_OUJOU ) == true then
		print("����ɍs���Ă���"); --EN:print("I went to the royal castle");
		local Oujou_Apos 	={2200	,2200	,2200	,2200	};
		local Oujou_Aanim 	={a7003	,a7006	,a7007	,a0000	};
		local Oujou_Adam	={d7003	,d7006	,d7007	,d0000	};
		local Oujou_Acan	={c7003	,c7006	,c7007	,c0000	};
		local Oujou_Bpos	={2206	,2210	};
		local Oujou_Banim	={a0000	,a0000	};
		local Oujou_Bdam	={d0000	,d0000	};
		local Oujou_Bcan	={c0000	,c0000	};
		local Oujou_Cpos 	={2205	,2205	,2205	,2207	,2207	,2207	,2208	,2208	,2208	};
		local Oujou_Canim	={a7004	,a7008	,a7009	,a7004	,a7008	,a7009	,a7004	,a7008	,a7009	};
		local Oujou_Cdam	={d7004	,d7008	,d7009	,d7004	,d7008	,d7009	,d7004	,d7008	,d7009	};
		local Oujou_Ccan	={c7004	,c7008	,c7009	,c7004	,c7008	,c7009	,c7004	,c7008	,c7009	};
		local Oujou_Dpos 	={2205	,2209	};
		local Oujou_Danim	={a7005	,a7005	};
		local Oujou_Ddam	={d7005	,d7005	};
		local Oujou_Dcan	={c7005	,c7005	};
		Lua_SetPos(proxy,
		Oujou_Apos,
		Oujou_Aanim,
		Oujou_Adam,
		Oujou_Acan,
		Oujou_Bpos,
		Oujou_Banim,
		Oujou_Bdam,
		Oujou_Bcan,
		Oujou_Cpos,
		Oujou_Canim,
		Oujou_Cdam,
		Oujou_Ccan,
		Oujou_Dpos,
		Oujou_Danim,
		Oujou_Ddam,
		Oujou_Dcan
		);
	end
	
	--�ÍԂɍs���Ă��� --EN:--I went to the old fort
	if proxy:IsCompleteEvent( GO_TO_WARP_FURUTORIDE ) == true then
		print("�ÍԂɍs���Ă���"); --EN:print("I went to the old fort");
		local Furutoride_Apos 	={2203	,2203	,2203	,2203	};
		local Furutoride_Aanim 	={a7003	,a7006	,a7007	,a0000	};
		local Furutoride_Adam 	={d7003	,d7006	,d7007	,d0000	};
		local Furutoride_Acan 	={c7003	,c7006	,c7007	,c0000	};
		local Furutoride_Bpos	={2206	,2210	};
		local Furutoride_Banim	={a0000	,a0000	};
		local Furutoride_Bdam	={d0000	,d0000	};
		local Furutoride_Bcan	={c0000	,c0000	};
		local Furutoride_Cpos 	={2205	,2205	,2205	,2207	,2207	,2207	,2208	,2208	,2208	};
		local Furutoride_Canim	={a7004	,a7008	,a7009	,a7004	,a7008	,a7009	,a7004	,a7008	,a7009	};
		local Furutoride_Cdam	={d7004	,d7008	,d7009	,d7004	,d7008	,d7009	,d7004	,d7008	,d7009	};
		local Furutoride_Ccan	={c7004	,c7008	,c7009	,c7004	,c7008	,c7009	,c7004	,c7008	,c7009	};
		local Furutoride_Dpos 	={2205	,2209	};
		local Furutoride_Danim	={a7005	,a7005	};
		local Furutoride_Ddam	={d7005	,d7005	};
		local Furutoride_Dcan	={c7005	,c7005	};
		Lua_SetPos(proxy,
			Furutoride_Apos,
			Furutoride_Aanim,
			Furutoride_Adam,
			Furutoride_Acan,
			Furutoride_Bpos,
			Furutoride_Banim,
			Furutoride_Bdam,
			Furutoride_Bcan,
			Furutoride_Cpos,
			Furutoride_Canim,
			Furutoride_Cdam,
			Furutoride_Ccan,
			Furutoride_Dpos,
			Furutoride_Danim,
			Furutoride_Ddam,
			Furutoride_Dcan
			);
	end
	
	--�S��ɍs���Ă��� --EN:--I went to prison
	if proxy:IsCompleteEvent( GO_TO_WARP_ROUJOU ) == true then
		print("�S��ɍs���Ă���"); --EN:print("I was in prison");
		local Roujou_Apos 	={2202	,2202	,2202	,2202	};
		local Roujou_Aanim 	={a0000	,a7004	,a7008	,a7009	};
		local Roujou_Adam 	={d0000	,d7004	,d7008	,d7009	};
		local Roujou_Acan 	={c0000	,c7004	,c7008	,c7009	};
		local Roujou_Bpos	={2206	,2210	};
		local Roujou_Banim	={a0000	,a0000	};
		local Roujou_Bdam	={d0000	,d0000	};
		local Roujou_Bcan	={c0000	,c0000	};
		local Roujou_Cpos 	={2205	,2205	,2205	,2207	,2207	,2207	,2208	,2208	,2208	};
		local Roujou_Canim	={a7004	,a7008	,a7009	,a7004	,a7008	,a7009	,a7004	,a7008	,a7009	};
		local Roujou_Cdam	={d7004	,d7008	,d7009	,d7004	,d7008	,d7009	,d7004	,d7008	,d7009	};
		local Roujou_Ccan	={c7004	,c7008	,c7009	,c7004	,c7008	,c7009	,c7004	,c7008	,c7009	};
		local Roujou_Dpos 	={2205	,2209	};
		local Roujou_Danim	={a7005	,a7005	};
		local Roujou_Ddam	={d7005	,d7005	};
		local Roujou_Dcan	={c7005	,c7005	};
		Lua_SetPos(proxy,
			Roujou_Apos,
			Roujou_Aanim,
			Roujou_Adam,
			Roujou_Acan,
			Roujou_Bpos,
			Roujou_Banim,
			Roujou_Bdam,
			Roujou_Bcan,
			Roujou_Cpos,
			Roujou_Canim,
			Roujou_Cdam,
			Roujou_Ccan,
			Roujou_Dpos,
			Roujou_Danim,
			Roujou_Ddam,
			Roujou_Dcan);
	end
	
	--�s��ɍs���Ă��� --EN:--was going unclean
	if proxy:IsCompleteEvent( GO_TO_WARP_FUJOU ) == true then
		print("�s��ɍs���Ă���"); --EN:print("I was unclean");
		local Fujou_Apos 	={2204	,2204	,2204	,2204	};
		local Fujou_Aanim 	={a7003	,a7006	,a7007	,a0000	};
		local Fujou_Adam 	={d7003	,d7006	,d7007	,d0000	};
		local Fujou_Acan 	={c7003	,c7006	,c7007	,c0000	};
		local Fujou_Bpos	={2206	,2210	};
		local Fujou_Banim	={a0000	,a0000	};
		local Fujou_Bdam	={d0000	,d0000	};
		local Fujou_Bcan	={c0000	,c0000	};
		local Fujou_Cpos 	={2205	,2205	,2205	,2207	,2207	,2207	,2208	,2208	,2208	};
		local Fujou_Canim	={a7004	,a7008	,a7009	,a7004	,a7008	,a7009	,a7004	,a7008	,a7009	};
		local Fujou_Cdam	={d7004	,d7008	,d7009	,d7004	,d7008	,d7009	,d7004	,d7008	,d7009	};
		local Fujou_Ccan	={c7004	,c7008	,c7009	,c7004	,c7008	,c7009	,c7004	,c7008	,c7009	};
		local Fujou_Dpos 	={2205	,2209	};
		local Fujou_Danim	={a7005	,a7005	};
		local Fujou_Ddam	={d7005	,d7005	};
		local Fujou_Dcan	={c7005	,c7005	};
		Lua_SetPos(proxy,
			Fujou_Apos,
			Fujou_Aanim,
			Fujou_Adam,
			Fujou_Acan,
			Fujou_Bpos,
			Fujou_Banim,
			Fujou_Bdam,
			Fujou_Bcan,
			Fujou_Cpos,
			Fujou_Canim,
			Fujou_Cdam,
			Fujou_Ccan,
			Fujou_Dpos,
			Fujou_Danim,
			Fujou_Ddam,
			Fujou_Dcan);
	end
	
	--�B���ɍs���Ă��� --EN:--I went to the tunnel
	if proxy:IsCompleteEvent( GO_TO_WARP_KOUDOU ) == true then
		print("�B���ɍs���Ă���"); --EN:print("I was in the mine");
		local Koudou_Apos 	={2201	,2201	,2201	,2201	};
		local Koudou_Aanim 	={a7003	,a7006	,a7007	,a0000	};
		local Koudou_Adam 	={d7003	,d7006	,d7007	,d0000	};
		local Koudou_Acan 	={c7003	,c7006	,c7007	,c0000	};
		local Koudou_Bpos	={2206	,2210	};
		local Koudou_Banim	={a0000	,a0000	};
		local Koudou_Bdam	={d0000	,d0000	};
		local Koudou_Bcan	={c0000	,c0000	};
		local Koudou_Cpos 	={2205	,2205	,2205	,2207	,2207	,2207	,2208	,2208	,2208	};
		local Koudou_Canim	={a7004	,a7008	,a7009	,a7004	,a7008	,a7009	,a7004	,a7008	,a7009	};
		local Koudou_Cdam	={d7004	,d7008	,d7009	,d7004	,d7008	,d7009	,d7004	,d7008	,d7009	};
		local Koudou_Ccan	={c7004	,c7008	,c7009	,c7004	,c7008	,c7009	,c7004	,c7008	,c7009	};
		local Koudou_Dpos 	={2205	,2209	};
		local Koudou_Danim	={a7005	,a7005	};
		local Koudou_Ddam	={d7005	,d7005	};
		local Koudou_Dcan	={c7005	,c7005	};
		Lua_SetPos(proxy,
			Koudou_Apos,
			Koudou_Aanim,
			Koudou_Adam,
			Koudou_Acan,
			Koudou_Bpos,
			Koudou_Banim,
			Koudou_Bdam,
			Koudou_Bcan,
			Koudou_Cpos,
			Koudou_Canim,
			Koudou_Cdam,
			Koudou_Ccan,
			Koudou_Dpos,
			Koudou_Danim,
			Koudou_Ddam,
			Koudou_Dcan);
	end
	
	--�k���ɍs���Ă��� --EN:--was going to the northern limit
	if proxy:IsCompleteEvent( GO_TO_WARP_HOKUGEN ) == true then
		print("�k���ɍs���Ă���"); --EN:print("I was going to the northern limit");
		local Hokugen_Apos 	={2200	,2200	,2200	,2200	};
		local Hokugen_Aanim ={a7003	,a7006	,a7007	,a0000	};
		local Hokugen_Adam	={d7003	,d7006	,d7007	,d0000	};
		local Hokugen_Acan	={c7003	,c7006	,c7007	,c0000	};
		local Hokugen_Bpos	={2206	,2210	};
		local Hokugen_Banim	={a0000	,a0000	};
		local Hokugen_Bdam	={d0000	,d0000	};
		local Hokugen_Bcan	={c0000	,c0000	};
		local Hokugen_Cpos 	={2205	,2205	,2205	,2207	,2207	,2207	,2208	,2208	,2208	};
		local Hokugen_Canim	={a7004	,a7008	,a7009	,a7004	,a7008	,a7009	,a7004	,a7008	,a7009	};
		local Hokugen_Cdam	={d7004	,d7008	,d7009	,d7004	,d7008	,d7009	,d7004	,d7008	,d7009	};
		local Hokugen_Ccan	={c7004	,c7008	,c7009	,c7004	,c7008	,c7009	,c7004	,c7008	,c7009	};
		local Hokugen_Dpos 	={2205	,2209	};
		local Hokugen_Danim	={a7005	,a7005	};
		local Hokugen_Ddam	={d7005	,d7005	};
		local Hokugen_Dcan	={c7005	,c7005	};
		Lua_SetPos(proxy,
			Hokugen_Apos,
			Hokugen_Aanim,
			Hokugen_Adam,
			Hokugen_Acan,
			Hokugen_Bpos,
			Hokugen_Banim,
			Hokugen_Bdam,
			Hokugen_Bcan,
			Hokugen_Cpos,
			Hokugen_Canim,
			Hokugen_Cdam,
			Hokugen_Ccan,
			Hokugen_Dpos,
			Hokugen_Danim,
			Hokugen_Ddam,
			Hokugen_Dcan);
	end
end


function Lua_SetPos(
proxy,
list_Apos,
list_Aanim,
list_Adam,
list_Acan,
list_Bpos,
list_Banim,
list_Bdam,
list_Bcan,
list_Cpos,
list_Canim,
list_Cdam,
list_Ccan,
list_Dpos,
list_Danim,
list_Ddam,
list_Dcan
)
	
	local heroine = 615;
	--�����擾 --EN:--get random number
	local randA = proxy:GetRandom(0,100);
	local dbgrandA = proxy:GetDbgRandomA();
	--�f�o�b�O����������΂��������g��(���i�ł͕K��-1���A��܂��v��Ȃ��Ȃ�����R�����g�A�E�g����) --EN:--Use debug random number if available
	if dbgrandA ~= -1 then
		randA = dbgrandA;
	end	
	print("�q���C���o�҂�����A",randA);	 --EN:print("Heroine wait random number A",randA);
	
	--�����擾 --EN:--get random number
	local randB = proxy:GetRandom(0,100);
	local dbgrandB = proxy:GetDbgRandomB();	
	if dbgrandB ~= -1 then
		randB = dbgrandB;
	end	
	print("�q���C���o�҂�����B",randB);	 --EN:print("Heroine waiting random number B",randB);
		
	if randA <= 40 then
		local Aindex = 1;
		if randB <= 25 then
			Aindex = 1;
		elseif randB <= 50 then
			Aindex = 2;
		elseif randB <= 75 then
			Aindex = 3;
		else
			Aindex = 4;
		end
		proxy:Warp( heroine , list_Apos[Aindex] );
		proxy:ChangeInitPosAng(heroine,  list_Apos[Aindex] );
		proxy:SetSpStayAndDamageAnimIdPlus( heroine , list_Aanim[Aindex] ,list_Adam[Aindex] , list_Acan[Aindex]);
		hiroin_cancelAnimId = list_Acan[Aindex];
		print("�q���C�� pos:",list_Apos[Aindex]," anim:",list_Aanim[Aindex]); --EN:print("heroine pos:",list_Apos[Aindex]," anim:",list_Aanim[Aindex]);
	elseif randA <= 70 then
		local Bindex = 1;
		if randB <= 50 then
			Bindex = 1;
		else
			Bindex = 2;
		end
		proxy:Warp( heroine , list_Bpos[Bindex] );
		proxy:ChangeInitPosAng(heroine,  list_Apos[Aindex] );
		proxy:SetSpStayAndDamageAnimIdPlus( heroine , list_Banim[Bindex] ,list_Bdam[Bindex] , list_Bcan[Bindex] );
		hiroin_cancelAnimId = list_Bcan[Bindex];
		print("�q���C�� pos:",list_Bpos[Bindex]," anim:",list_Banim[Bindex]); --EN:print("heroine pos:",list_Bpos[Bindex]," anim:",list_Banim[Bindex]);
	elseif randA <= 90 then
		local Cindex = 1;
		--[[
		if randB <= 20 then			
			Cindex = 1;
		elseif randB <= 30 then
			Cindex = 2;
			]]
		if randB <= 20 then
			Cindex = 3;
		elseif randB <= 40 then
			Cindex = 4;
		elseif randB <= 60 then
			Cindex = 5;
		elseif randB <= 70 then
			Cindex = 6;
		elseif randB <= 80 then
			Cindex = 7;
		elseif randB <= 90 then
			Cindex = 8;
		else
			Cindex = 9;
		end
		proxy:Warp( heroine , list_Cpos[Cindex] );
		proxy:ChangeInitPosAng(heroine,  list_Apos[Aindex] );
		proxy:SetSpStayAndDamageAnimIdPlus( heroine , list_Canim[Cindex] ,list_Cdam[Cindex] ,list_Ccan[Cindex]);
		hiroin_cancelAnimId = list_Ccan[Cindex];
		print("�q���C�� pos:",list_Cpos[Cindex]," anim:",list_Canim[Cindex]); --EN:print("heroine pos:",list_Cpos[Cindex]," anim:",list_Canim[Cindex]);
	else
		local Dindex = 1;
		if randB <= 50 then
			Dindex = 1;
		else
			Dindex = 2;
		end
		proxy:Warp( heroine , list_Dpos[Dindex] );
		proxy:ChangeInitPosAng(heroine,  list_Apos[Aindex] );
		proxy:SetSpStayAndDamageAnimIdPlus( heroine , list_Danim[Dindex] ,list_Ddam[Dindex] ,list_Dcan[Dindex] );
		hiroin_cancelAnimId = list_Dcan[Dindex];
		print("�q���C�� pos:",list_Dpos[Dindex]," anim:",list_Danim[Dindex]); --EN:print("heroine pos:",list_Dpos[Dindex]," anim:",list_Danim[Dindex]);
	end	
end


--------------------------------------------------------------------------------------
--���̕ǂ̑O��b��72 --EN:--Conversation in front of the wall of light 72
--------------------------------------------------------------------------------------
function OnEvent_72(proxy,param)
	print("OnEvent_72 beign");
	proxy:SetEventFlag( 72, true );
	proxy:CloseMenu();
	proxy:TalkNextPage( 72 );
	--proxy:SetEventFlag( 61 , false );
	print("OnEvent_72 end");
end


--------------------------------------------------------------------------------------
--���̕ǂ��z�������̉�b�p��73 --EN:--For conversation when crossing the wall of light 73
--------------------------------------------------------------------------------------
function OnEvent_73(proxy,param)
	print("OnEvent_73 begin");
	proxy:SetEventFlag( 73, true );
	print("OnEvent_73 end");
end


--------------------------------------------------------------------------------------
--�g���t�B�[�J����510 --EN:--Trophy release ��510
--------------------------------------------------------------------------------------
function OnEvent_510(proxy,param)
	print("������������������������OnEvent_510������������������������"); --EN:print("������������������������OnEvent_510������������������������");
	Lua_RequestUnlockTrophy(proxy, 1);--�g���t�B�̏󋵂𔻒肵�A�擾���� --EN:--Determine and retrieve trophy status
	proxy:SetEventFlag( 510 , true );
end


function LastRemoveEquip(proxy)
	--RemoveInventoryEquip(const dl_int32 nType,const dl_int32 nId)
	print("LastRemoveEquip begin");
	proxy:RemoveInventoryEquip(TYPE_GOODS,8);	
	proxy:RemoveInventoryEquip(TYPE_GOODS,9);
	proxy:RemoveInventoryEquip(TYPE_GOODS,10);
	proxy:RemoveInventoryEquip(TYPE_GOODS,11);
	proxy:RemoveInventoryEquip(TYPE_GOODS,12);
	proxy:RemoveInventoryEquip(TYPE_GOODS,13);
	proxy:RemoveInventoryEquip(TYPE_GOODS,14);
	proxy:RemoveInventoryEquip(TYPE_GOODS,35);
	proxy:RemoveInventoryEquip(TYPE_GOODS,36);
	proxy:RemoveInventoryEquip(TYPE_GOODS,39);
	proxy:RemoveInventoryEquip(TYPE_GOODS,40);
	proxy:RemoveInventoryEquip(TYPE_GOODS,41);
	proxy:RemoveInventoryEquip(TYPE_GOODS,42);
	proxy:RemoveInventoryEquip(TYPE_GOODS,43);
	proxy:RemoveInventoryEquip(TYPE_GOODS,44);	
	print("LastRemoveEquip end");	
end

--��75�����X�{�X�̎��̒��ׂ��� --EN:-- �� 75 �� Examined the corpse of the final boss ��
function OnEvent_75(proxy,param)
	print("OnEvent_75 begin");
	proxy:SetDispMask(821, 1);--�g���������Ă���̂��H --EN:--Is it suitable for use?
	print("OnEvent_75 end");
end


--�\�E���u�����h�𒲂ׂ� --EN:--Checked Soul Brand
function OnEvent_141(proxy, param)
	if param:IsNetMessage() == false then
	print("OnEvent_141 begin");
	proxy:NotNetMessage_begin();
	proxy:RepeatMessage_begin();
		proxy:PlayAnimation( 10000 , 8290);		
		proxy:PlayAnimation( 1130 , 1);	
		proxy:OnKeyTime2( 141 , "OnEvent_141_0",0.01,0,0,once);
	proxy:RepeatMessage_end();
	proxy:NotNetMessage_end();	
	print("OnEvent_141 end");
	end
end

function OnEvent_141_0(proxy,param)
	print("OnEvent_141_0 begin");
	--if proxy:IsPlayerStay(10000) == true then
	if proxy:IsEventAnim( 10000 , 8290 ) == true then
		proxy:LuaCallStart( 141 , 2 );
	else
		proxy:ForcePlayAnimation( 1130 , 0);	
	end
	print("OnEvent_141_0 end");
end

--��141_1���A�C�e���擾�� --EN:-- �� 141_1 �� item acquisition ��
function OnEvent_141_1(proxy, param)
	print("OnEvent_141_1 begin");

	--�A�C�e���擾�֐�--�p�����[�^10104�Q�� --EN:--item retrieval function--see parameter 10104
	proxy:GetRateItem(10730);	
	
	--�A�C�e�����擾�ς� --EN:--item already acquired
	proxy:SetEventFlag( 141, 1 );
	
	--OBJ���������߂̃C�x���g�z�M --EN:--Event distribution for erasing OBJ
	proxy:LuaCallStart( 141, 1);
	
	print("OnEvent_141_1 end");
end

--��141_2����OBJ��\���p�� --EN:--��141_2��For hiding the sword OBJ��
function OnEvent_141_2(proxy,param)
	print("OnEvent_141_2 begin");
	--�I�u�W�F�������� --EN:--The object disappears
	proxy:SetDrawEnable( 1130 , false );--�ЂƂ܂��`�悾��OFF --EN:--Only drawing is turned off for the time being
	proxy:SetColiEnable( 1130 , false );--������͂���͕̂s��(����ł͂Ȃ��悤�Ȃ̂ŏ����Ȃ�)	 --EN:--I don't know if there is a hit (I don't delete it because it doesn't seem to be the current situation)
	--�C�x���g������ --EN:--event disappears
	proxy:DeleteEvent( 141 );
	print("OnEvent_141_2 end");
end

--�A�j���Đ��̓������Ď� --EN:--Animation playback synchronization & monitoring
function OnEvent_141_3(proxy,param)
	print("OnEvent_141_3 begin");
	
	proxy:TreasureDispModeChange2( 1130, false ,KEN_SFX);
	proxy:InvalidSfx( 1131 , true );
	--�v���C���[�̓����A�j���[�V����(true:�p�[�e�B�[�v���C���[���A�j���[�V��������) --EN:--Player synchronous animation (true: party player animated)
	if Luafunc_PlaySynchroAnimation( proxy, param, 8290 ) == true then--�V�����A�j��  --EN:-- new anime
		proxy:PlayAnimation( 1130 , 1);	
		print("OnEvent_141_3 end");
		return true;
	end
	
	--���Ƀ��[�v --EN:--Warp to sword
	proxy:WarpDmy( LOCAL_PLAYER , 1130 , 191 );		
	
	proxy:NotNetMessage_begin();
		proxy:OnChrAnimEnd( 141 , LOCAL_PLAYER , 8290 , "OnEvent_141_1", once);
	proxy:NotNetMessage_end();
	
	print("OnEvent_141_3 end");
end

function OnEvent_141_WAIT(proxy,param)
	print("OnEvent_141_WAIT begin");
	--�z�X�g�A�����A�O���C�̂ݒ��ׂ邱�Ƃ��ł��� --EN:--Only hosts, survivors, and grays can be examined
	local possible_chr_type = ATTR_HOST + ATTR_LIVE + ATTR_GREY;				
	proxy:OnDistanceActionAttribute( 141 , LOCAL_PLAYER , 1130 , "OnEvent_141" , ItemBoxDist_A , 10010135 , 0 , ItemBoxAngle_A ,possible_chr_type, everytime ); 
	proxy:LuaCall( 141,1,"OnEvent_141_2",once);
	proxy:LuaCall( 141,2,"OnEvent_141_3",once);
	proxy:SetDrawEnable( 1130 , true );
	proxy:SetColiEnable( 1130 , true );
	proxy:TreasureDispModeChange2( 1130, true ,KEN_SFX);
	print("OnEvent_141_WAIT end")
end
