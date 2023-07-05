
--------------------------------------------------------------------------------------
--�}�b�v�ǂݍ��ݎ��ɓǂ܂�鏉���������� --EN:--Initialization process read when reading the map ��
--------------------------------------------------------------------------------------
function Initialize_m07_02_00_00(proxy)
	print("Initialize_m07_02_00_00 begin");
	
	
--[[�}�b�v�X�^�W�I�̃f�[�^������܂ŃR�����g�A�E�g --EN:--[[Comment out until Map Studio data is entered
	
--��6912���G���A�{�X���S�� --EN:-- �� 6912 �� Area Boss Death ��
	if proxy:IsCompleteEvent( 6912 ) ==false then
		proxy:OnCharacterDead(6912, 826, "OnEvent_6912", once);
	else
		proxy:SetEventFlag( 7301 , 1 ); --�Β��̃A�N�V����ID��ON --EN:--Turn on the action ID of the stone pillar
	end


--��1024���Β��Ƀ��[�v�� --EN:-- �� 1024 �� Warp to the stone pillar ��
	proxy:OnPlayerActionInRegionAngle(1024, 1410, "OnEvent_1024", 180, HELPID_GO_TO_SEKITYUU, everytime);
--�I�u�W�F�ɐ؂�ւ�����炱�������g���B --EN:--Use this when switching to an object.
--	proxy:OnDistanceAction( 1024, 10000, 1410, "OnEvent_1024", WarpGimmickDist_A, HELPID_GO_TO_SEKITYUU, 180, WarpGimmickAngle_A, everytime );

]]


--��??���p�j�f�[�����̓o�ꁡ�n���h���o�^ --EN:--��??��Appearance of wandering daemon��Handler registration
	proxy:NotNetMessage_begin();
		--�v���C���[���\���Ŏ��S�������ɃL�b�N����܂��B --EN:--Kicked when a player dies solo.
		proxy:LuaCall( 4000, 100, "PlayerDeath_m07_02_00_00", everytime );
		--�v���C���[�������������ɃL�b�N����܂��B --EN:--Kicked when the player is revived.
		proxy:LuaCall( 4032, 100, "PlayerRevive_m07_02_00_00", everytime );
	proxy:NotNetMessage_end();	

	
	--��999999���t���[���x��̏����������C�x���g�𔭍s�� --EN:-- �� 999999 �� Generate a frame delay initialization processing event ��
	proxy:NotNetMessage_begin();
		--��0�b�づ-- --EN:--��After 0 seconds��--
		proxy:OnKeyTime2( 999992, "Second_Initialize_m07_02_00_00", 0.0, 0, 0, once );	
	proxy:NotNetMessage_end();	
	
	
	print("Initialize_m07_02_00_00 end");
end




--------------------------------------------------------------------------------------
--Initialize����Ă΂��A1�t���[���x��̏�����������999999 --EN:--Initialization with a delay of 1 frame, called from Initialize ��999999
--------------------------------------------------------------------------------------
function Second_Initialize_m07_02_00_00(proxy, param)
	print("Second_Initialize_m07_02_00_00 begin");
	
--[[
	--���p�j�f�[�����p (�t���O�͉��A�w�肪����Ες���) --EN:--��For wandering daemon (flag is tentative, change if specified)
	if proxy:IsCompleteEvent( 20 ) == true then
		LuaFunc_VisibleTheWanderingDemon  (proxy, param, demon_id_list_m07_02_00_00);
	else
		LuaFunc_InvisibleTheWanderingDemon(proxy, param, demon_id_list_m07_02_00_00);
	end
]]	

	print("Second_Initialize_m07_02_00_00 end");
end




--------------------------------------------------------------------------------------
--�}���`�ɂȂ������Ƀz�X�g���ᖳ�������灡���� --EN:--If you are not a host when you become multi, no
--------------------------------------------------------------------------------------
function ConnectPartyEvent(proxy)
	print("ConnectPartyEvent begin");
	print("ConnectPartyEvent end");
end



--------------------------------------------------------------------------------------
--��6912���G���A�{�X���S�� --EN:-- �� 6912 �� Area Boss Death ��
--------------------------------------------------------------------------------------
--��6912���G���A�{�X���S�� --EN:-- �� 6912 �� Area Boss Death ��
function OnEvent_6912(proxy, param)
	print("OnEvent_6912 begin");

	proxy:SetEventFlag( 6912, 1 );
	
	proxy:SetEventFlag( 7301, 1 );--�Β��̃A�N�V�����t���OON --EN:--Stone pillar action flag ON
	
	print("OnEvent_6912 end");
end


--------------------------------------------------------------------------------------
--��1024���Β��Ƀ��[�v�� --EN:-- �� 1024 �� Warp to the stone pillar ��
--------------------------------------------------------------------------------------
--��1024���Β��Ƀ��[�v�� --EN:-- �� 1024 �� Warp to the stone pillar ��
function OnEvent_1024(proxy,param)	
	print("OnEvent_1024 begin");
	
	proxy:WarpNextStage( 1, 0, 0, 0, -1 );
	
	print("OnEvent_1024 end");
end


--------------------------------------------------------------------------------------
--�p�j�f�[�����̓o�ꁡ?? --EN:-- Appearance of the Wandering Demon ??
--------------------------------------------------------------------------------------

--���O���[�o���̎��S�Ď�����Ă΂��(�\��) --EN:--�� Called from global death watch (solo)
function PlayerDeath_m07_02_00_00(proxy, param)
	print("PlayerDeath_m07_02_00_00");
	
--	LuaFunc_VisibleTheWanderingDemon(proxy, param, demon_id_list_m07_02_00_00);
--	proxy:SetEventFlag( 20 , 1 );--�t���O�͉��A�w�肪����Ες���B --EN:The -- flag is tentative, and will be changed if specified.
	
	print("PlayerDeath_m07_02_00_00");
end

--���O���[�o���̌�������������Ă΂��(�\��) --EN:--��Called from global blood letter revival (solo)
function PlayerRevive_m07_02_00_00(proxy,param)
	print("PlayerRevive_m07_02_00_00");
	
--	LuaFunc_InvisibleTheWanderingDemon(proxy, param, demon_id_list_m07_02_00_00);
--	proxy:SetEventFlag( 20 , 0 );--�t���O�͉��A�w�肪����Ες���B --EN:The -- flag is tentative, and will be changed if specified.
	
	print("PlayerRevive_m07_02_00_00");
end






