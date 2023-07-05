
--------------------------------------------------------------------------------------
--�C�x���g���������{�X�ŗL�̃C�x���g��o�^����ۂɎg�p���Ă������� --EN:--Event Initialization ��Use this when registering boss-specific events.
--------------------------------------------------------------------------------------
function EventBoss_Initialize_m03_02_00_00(proxy)
	print("EventBoss_Initialize_m03_02_00_00 begin");
	--�N���C�A���g�Ŗ����Ȃ�@�V���O���@or�@�z�X�g --EN:-- Single or host if not a client
	if	proxy:IsClient() == false then
		--�l�b�g���[�N�̌���������悤�ɗv�� --EN:--Request to take network privileges
		proxy:RequestForceUpdateNetwork(805);		
	end
	if proxy:IsCompleteEvent( 4895 ) == false then
		--�������̐�m��PC����U�����󂯂��� --EN:--����Warrior of the Storm was attacked by a PC��
		proxy:OnSimpleDamage( 4910 , 805 , 10000 , "OnEvent_4910",everytime );
		--�������̐�m�̃^�[�Q�b�g���z�X�g�ɂ��܂��� --EN:--���� Host the target of the Storm Warriors��
		proxy:LuaCall( 4911 , 10 , "OnEvent_4911",everytime );
	end
	
	print("EventBoss_Initialize_m03_02_00_00 end");
end

--------------------------------------------------------------------------------------
--�{�X�p�̏������������K�v�ȂƂ��Ɏg�p�F�ŗL���̍쐬�� --EN:--Used when initialization processing for the boss is required: creation of unique information, etc.
--------------------------------------------------------------------------------------
function BossInit(proxy,param)	
end


--------------------------------------------------------------------------------------
--�������̐�m��PC����U�����󂯂��� --EN:--����Warrior of the Storm was attacked by a PC��
--------------------------------------------------------------------------------------
function OnEvent_4910(proxy,param)
	print("OnEvent_4910 begin");
	local target = proxy:GetTargetChrID(805);
	if target ~= -1 then	
		if proxy:IsRegionIn( target ,2885 ) == false then
			print("ChangeTarget!");
			proxy:LuaCallStart(4911,10 );
		end
	else
		print("ChangeTarget!");
		proxy:LuaCallStart(4911,10 );
	end
	print("OnEvent_4910 end");
end

function OnEvent_4911(proxy,param)
	if proxy:IsClient() == false then
		print("OnEvent_4911 begin");
		
		proxy:ClearTarget( 805 );--��x���G����Y��� --EN:-- Forget the enemy search information once
		proxy:ChangeTarget( 805 , 10000 );--�������U������悤�ɐ擱���� --EN:--Lead to attack yourself
		print("OnEvent_4911 end");
	end
end

