
--------------------------------------------------------------------------------------
--�C�x���g���������{�X�ŗL�̃C�x���g��o�^����ۂɎg�p���Ă������� --EN:--Event Initialization ��Use this when registering boss-specific events.
--------------------------------------------------------------------------------------
function EventBoss_Initialize_m02_02_00_00(proxy)
	print(" EventBoss_Initialize_m02_02_00_00 begin");
	--�N���C�A���g�Ŗ����Ȃ�@�V���O���@or�@�z�X�g --EN:-- Single or host if not a client
	if	proxy:IsClient() == false then
		proxy:RequestForceUpdateNetwork( 802 );
	end
	print(" EventBoss_Initialize_m02_02_00_00 end");
end

--------------------------------------------------------------------------------------
--�{�X�p�̏������������K�v�ȂƂ��Ɏg�p�F�ŗL���̍쐬�� --EN:--Used when initialization processing for the boss is required: creation of unique information, etc.
--------------------------------------------------------------------------------------
function BossInit(proxy,param)	
end
