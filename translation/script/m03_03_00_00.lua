
--�G�C�̓ˌ��C�x���g�����̎cHP���� --EN:--Remaining HP ratio of Ray's assault event activation
StormOfBeast_HpRate = 0.5;

--�q�G�C�̎��񂾐� --EN:--number of dead ray pups
BeastChildDeadCount = 12;

--------------------------------------------------------------------------------------
--�}�b�v�ǂݍ��ݎ��ɓǂ܂�鏉���������� --EN:--Initialization process read when reading the map ��
--------------------------------------------------------------------------------------
function Initialize_m03_03_00_00(proxy)
	print("Initialize_m03_03_00_00 begin");

--��1541���G���A�{�X�̃|�����Đ��� --EN:--�� 1541 �� Area Boss's polyplay ��
	--�{�X�������Ă��鎞�����C�x���g�o�^ --EN:-- Event registration only when the boss is alive
	if proxy:IsCompleteEvent( 4992 ) == false then
		--���S���ɂ�������x�Đ��������ׁB --EN:--Because I want to regenerate again when I die.
		SingleReset( proxy,1541);
		SingleReset( proxy,5085);
		if proxy:IsCompleteEvent( 1541 ) == false then 	
			--���{�X�O�̃|�����Đ��p�Ď��ǉ� --EN:--�� Added surveillance for polyplay playback in front of the boss
			proxy:OnRegionJustIn( 1541 , 10000 , 2896 , "OnEvent_1541" , once );		
			proxy:NotNetMessage_begin();
				--�|�����J�n�ɌĂ΂��n���h�� --EN:--handler called at polyplay start
				proxy:LuaCall(1541, REMO_START, "OnEvent_1541_RemoStart", once);
				--�|�����I����ɌĂ΂��n���h��(�g���K�[�N�������l�p) --EN:--Handler called after the end of the polyplay (for the person who caused the trigger)
				proxy:LuaCall(1541, REMO_FINISH, "OnEvent_1541_RemoFinish", once);
			proxy:NotNetMessage_end();	
		else
			--�I����Ă����Ԃœ����Ă����l�ɂ͂�����x --EN:--For those who came in after finishing,
			BossInit_StormOfBeast(proxy,param);
		end
	end


--��1542���{�X�����ɓ��遡	 --EN:-- �� 1542 �� Enter the boss room ��
	--���{�X�������Ă���Ƃ������C�x���g�o�^ --EN:-- Event registration only when the mid-boss is alive
	if proxy:IsCompleteEvent( 4992 ) == false then
	
		--�\���̂Ƃ��͈�x�ڂɃ{�X�����ɓ���p�̃C�x���g�𖈉�o�^���������̂ŁA�Ή�����t���O��OFF�ɂ���B --EN:-- When soloing, we want to register the event for entering the boss room for the first time every time, so turn off the corresponding flag.
		SingleReset(proxy, 1542);
		--�������A�j���Đ��p�̊J�n�n���h��(���񁨕���) --EN:--�� Start handler for synchronous animation playback (turning �� walking)
		proxy:LuaCall( 1543, 1, "OnEvent_1542_1", everytime );		
		--��2��ڈȍ~�Ƀ{�X�����ɓ��邽�߂̃C�x���g�z�M�p --EN:--��For event delivery to enter the boss room after the second time
		proxy:LuaCall( 1543 , 5 , "OnEvent_1542_GO_TO_IN" , everytime );		
		--���t���O�Z�b�g(�����p) --EN:--��flag set (for synchronization)
		proxy:LuaCall( 1543 , 6 , "OnEvent_1542_flag_set" , everytime );		
		--�N�����{�X�O�����܂��ʉ߂��Ă��Ȃ� --EN:--Someone hasn't passed through the boss front door yet
		if proxy:IsCompleteEvent( 1542 ) == false then		
			--(�Z�b�V��������)�{�X�O�̖��@�ǂ��ŏ��ɒʂ��̂͐����̐l���� --EN:--(During the session) Only survivors can pass through the magic wall in front of the boss first
			local possible_chr_type = ATTR_HOST + ATTR_LIVE + ATTR_GREY;
			proxy:NotNetMessage_begin();
				--��1542�������J���Ă���Ƃ��ɒ��ɓ��邽�߂̃C�x���g��ǉ��� --EN:--��1542��Add an event to enter when the door is open��
				proxy:OnPlayerActionInRegionAttribute( 1542, 2892, "OnEvent_1542", HELPID_GO_TO_IN, possible_chr_type, everytime );
			proxy:NotNetMessage_end();
			
		else --�O���C�S�[�X�g�ł����Ƃ��悤�ɂ���Ǝv����B --EN:--Gray ghost seems to be like that when it's done.
			proxy:NotNetMessage_begin();
				--��1543�������J���Ă���Ƃ��ɒ��ɓ��邽�߂̃C�x���g��ǉ��� --EN:--��1543��Add an event to enter when the door is open��
				proxy:OnPlayerActionInRegion( 1543, 2892, "OnEvent_1542", HELPID_GO_TO_IN, everytime );--�n���h���͏�Ɠ��� --EN:--handler is the same as above
			proxy:NotNetMessage_end();
		end
	end
	
--��4999���{�X�퓬�J�n��	 --EN:-- �� 4999 �� Boss battle begins ��
	if proxy:IsCompleteEvent( 4992 ) == false then
		proxy:OnRegionIn( 4999 , 10000 , 2884 , "OnEvent_4999" , everytime );
	end	
	
--��4992���G���A�{�X���S�� --EN:-- �� 4992 �� Area Boss Death ��
	proxy:AddFieldInsFilter( 822 );
	if proxy:IsCompleteEvent( 4992 ) == false then
		proxy:OnCharacterDead(4992,822,"OnEvent_4992",once);
	end
		
--[[
--��5000�E5001���{�X�̓�����|������ --EN:--�� 5000�E5001 �� Poly play per boss ��
	--�{�X��|���ĂȂ� and �w��|�������݂Ă��Ȃ� --EN:--I haven't beaten the boss and I haven't watched the specified polyplay
	SingleReset( proxy,5001 );	
	if proxy:IsCompleteEvent( 4992 ) == false and proxy:IsCompleteEvent( 5001 ) == false then
		local eneID = 400;
		local num = 12;
		
		for eneID = 400 , 411 , 1 do
			--�q�G�C�̎��S�Ď� --EN:--Father ray mortality monitoring
			print("add ",eneID);
			proxy:OnCharacterDead( 5000, eneID ,"OnEvent_5000_"..eneID,once);
		end
		--�G�C��Hp�Ď�		 --EN:--Hp monitor of stingray
		proxy:OnCharacterHP( 5000, 822, "OnEvent_5000_HP",StormOfBeast_HpRate,once );
		
		--�|�����N���p --EN:--For starting polyplay
		proxy:NotNetMessage_begin();
			--�L�b�N --EN:--kick
			proxy:LuaCall(5001,1,"OnEvent_5001",once);
			--�t�F�[�h�A�E�g�� --EN:-- When fading out
			proxy:LuaCall(5001,REMO_START,"OnEvent_5001_RemoStart",once);
			--�t�F�[�h�C���� --EN:--Fade in
			proxy:LuaCall(5001,REMO_FINISH,"OnEvent_5001_RemoFinish",once);
		proxy:NotNetMessage_end();
	end
	]]
--��??���p�j�f�[�����̓o�ꁡ�n���h���o�^ --EN:--��??��Appearance of wandering daemon��Handler registration
	proxy:NotNetMessage_begin();
		--�v���C���[���\���Ŏ��S�������ɃL�b�N����܂��B --EN:--Kicked when a player dies solo.
		proxy:LuaCall( 4000, 100, "PlayerDeath_m03_03_00_00", everytime );
		--�v���C���[�������������ɃL�b�N����܂��B --EN:--Kicked when the player is revived.
		proxy:LuaCall( 4032, 100, "PlayerRevive_m03_03_00_00", everytime );
	proxy:NotNetMessage_end();

	
	--���{�X�֘A�̏��������� --EN:--�� Boss-related initialization processing
	if proxy:IsCompleteEvent( 4992 ) ==true then
		
		--���{�X����ł���Ƃ� --EN:--��When the boss is dead
		--�{�X���Ȃ��Ȃ� --EN:--boss disappears
		InvalidBackRead( proxy , 822 );
		--�������ŏ������t���O�𗧂Ă� --EN:--Set the flag that was deleted by initialization
		proxy:SetEventFlag( 4991, true );
		
		--�q�G�C���\�����Ȃ� --EN:-- Don't show baby rays
		--[[
		local eneID = 400;		
		for eneID=400,411,1 do		
			InvalidCharactor( proxy, eneID);
		end
		]]
		--�W�F�l���[�^�~�߂� --EN:-- stop the generator
		proxy:EnableGeneratorSystem( 2605 , false );
		
		--���@�Ǐ����� --EN:--Magic wall disappears
		proxy:SetColiEnable( 1996 , false );			
		proxy:SetDrawEnable( 1996 , false );
		
		--SFX���� --EN:--Erase SFX
		proxy:InvalidSfx(1988,false);	

		--�z�X�g�v���C���[�̂݃A�C�e������C�x���g�Ɏg�p --EN:--Used for item acquisition event only for host players
		local possible_chr_type = ATTR_HOST + ATTR_LIVE + ATTR_GREY;

		--�󎀑�(�\�E��?)�L���� --EN:--Treasure corpse (soul?) activation
		proxy:SetDrawEnable( 1979 , true );
		proxy:SetColiEnable( 1979 , true );
		--�󎀑�(�\�E��?)2�L���� --EN:--Treasure corpse (soul?) 2 enabled
		proxy:SetDrawEnable( 1978 , true );
		proxy:SetColiEnable( 1978 , true );
		
		proxy:TreasureDispModeChange2( 1979 , true ,KANAME_SFX);--���点�� --EN:-- let it shine
		--��(�\�E��)�A�C�e���擾�p�C�x���g�Ď��ǉ��� --EN:--�� (Soul) Added event monitoring for item acquisition��
		if proxy:IsCompleteEvent( 4996 ) == false then
			proxy:ValidSfx( 2601 );--SFX �L���� --EN:--SFX enable
			proxy:ValidSfx( 2600 );--SFX �L����			 --EN:--SFX enable
			proxy:OnDistanceActionAttribute( 4996 , 10000 , 1979 , "OnEvent_4996" , WarpGimmickDist_A , 10010180 , 0 , 180 , possible_chr_type, once );
		else
			--���v�΂Ń��[�v�p�̊Ď���ǉ��� --EN:--�� Added surveillance for warp with keystone ��
			SingleReset(proxy,4998);
			--proxy:InvalidSfx( 2601, false );--SFX �L���� --EN:--SFX enable
			proxy:InvalidSfx( 2600, false );--SFX �L���� --EN:--SFX enable
			proxy:OnDistanceActionAttribute( 4998 , 10000 , 1979 , "OnEvent_4998" , WarpGimmickDist_A , HELPID_GO_TO_SEKITYUU , 0 , 180 , ATTR_NOSESSION , everytime );
		end
	else
		--���{�X�����Ă���Ƃ� --EN:--�� When the boss is alive
		
		--�G���A�{�X�|���������Ă��Ȃ��Ƃ� --EN:--When not watching the Area Bospoli play
		if proxy:IsCompleteEvent(1541) == false then
			
			InvalidCharactor( proxy,822 );			
			--���ɂ�������Ȃ� --EN:--no hits
			--proxy:SetIgnoreHit( 822, true);
			--proxy:DisableMapHit( 822 , true);
	
			--�q�G�C��\�����Ȃ� --EN:--Do not display baby rays
			local eneID;
			for eneID = 400, 411, 1 do
				proxy:SetDrawEnable( eneID, false );
				proxy:SetColiEnable( eneID, false );
			end
		end
		
		proxy:EnableLogic( 822 , false );--���W�b�NOFF�őҋ@ --EN:--Wait with logic OFF
		
		
		--�q�G�C���W�b�NOFF --EN:--child logic off
		local eneID = 400;
		for eneID=400 , 411 , 1 do
			proxy:EnableLogic(eneID,false);
		end
		
		--��(�\�E��?) --EN:--Treasure (Soul?)
		proxy:SetDrawEnable( 1979 , false );
		proxy:SetColiEnable( 1979 , false );
		--��(�\�E��?)2 --EN:--Treasure (Soul?) 2
		proxy:SetDrawEnable( 1978 , false );
		proxy:SetColiEnable( 1978 , false );

		--SFX ������ --EN:--Disable SFX
		proxy:InvalidSfx( 2600 , false );--�\�E���p --EN:--For Seoul
		proxy:InvalidSfx( 2601 , false );--�{�X�A�C�e���p			 --EN:--For boss items

	end
	
--��1544���{�X��J�����Ή��� --EN:-- �� 1544 �� Boss battle camera support ��
	--�{�X�������Ă���Ȃ�o�^ --EN:--Register if the boss is alive
	if proxy:IsCompleteEvent(4992) == false then
		proxy:NotNetMessage_begin();
			proxy:OnRegionIn( 1544 , 10000 , 2884 ,"OnEvent_1544" , everytime );
		proxy:NotNetMessage_end();
	end

--��1590���X�g�[���u�����K�[������ --EN:-- �� 1590 �� Storm Bringer enhancement ��
	--�{�X�������Ă���Ȃ�o�^ --EN:--Register if the boss is alive
	--if proxy:IsCompleteEvent(4992) == false then
		proxy:NotNetMessage_begin();
			proxy:OnRegionIn( 1590, 10000, 2610 , "OnEvent_1590",everytime ); 
			proxy:OnRegionJustOut( 1590 , 10000 , 2610 , "OnEvent_1590_out",everytime );
		proxy:NotNetMessage_end();
	--end
	
--��1570���ԂP�E�Q�̎q�G�C�̖������� --EN:-- �� 1570 �� Fort 1 and 2's Child Ray Invalidation ��
	SingleReset( proxy , 1570 );
	
	--if proxy:IsCompleteEvent( 4992 ) == false then
		proxy:NotNetMessage_begin();
			if proxy:IsClient() == false then
				proxy:OnRegionJustIn( 1570 ,10000 , 2680 , "OnEvent_1570" , everytime );
			end
			if proxy:IsCompleteEvent( 1570 ) == true then
				for eneid = 388 , 399 , 1 do
					InvalidCharactor( proxy , eneid );
				end
			end
		proxy:NotNetMessage_end();
		proxy:LuaCall( 1570 , 0 , "OnEvent_1570_1",everytime );
	--end
	
--��1571���ԂP�E�Q�̎q�G�C�̗L������ --EN:-- �� 1571 �� Fort 1 and 2's Child Ray Enabled ��
	--if proxy:IsCompleteEvent( 4992 ) == false then
		proxy:NotNetMessage_begin();
			if proxy:IsClient() == false then
				proxy:OnRegionJustIn( 1571 ,10000 , 2681, "OnEvent_1571" , everytime );
			end
		proxy:NotNetMessage_end();
		proxy:LuaCall( 1571 , 0 , "OnEvent_1571_1",everytime );
	--end

--��8085���ÍԂɗ����t���O�𗧂Ă遡	 --EN:-- �� 8085 �� Raise a flag to come to the old fort ��
	proxy:SetEventFlag(8085, true);
	
	--�����g�J�Q���S�C�x���g --EN:--Crystal Lizard Escape Event
	RegistTokage(proxy,1580,256,10);
	RegistTokage(proxy,1582,257,11);
	


--��1591���X�g�[���u�����K�[�� --EN:-- �� 1591 �� Stormbringer ��
	if proxy:IsCompleteEvent( 1591 ) == false then
		--�z�X�g�A�����A�O���C�̂ݒ��ׂ邱�Ƃ��ł��� --EN:--Only hosts, survivors, and grays can be examined
		local possible_chr_type = ATTR_HOST + ATTR_LIVE + ATTR_GREY;
		
		proxy:OnDistanceActionAttribute( 1591 , LOCAL_PLAYER , 1610 , "OnEvent_1591" , ItemBoxDist_A , 10010158 , 0 , ItemBoxAngle_A ,possible_chr_type, everytime ); 
		proxy:LuaCall( 1591,1,"OnEvent_1591_2",once);
		proxy:LuaCall( 1591,2,"OnEvent_1591_3",once);
		proxy:TreasureDispModeChange2( 1610, true ,KEN_SFX);
	else
		proxy:SetDrawEnable( 1610 , false );--�ЂƂ܂��`�悾��OFF --EN:--Only drawing is turned off for the time being
		proxy:SetColiEnable( 1610 , false );
	end	
	

	--��999999���t���[���x��̏����������C�x���g�𔭍s�� --EN:-- �� 999999 �� Generate a frame delay initialization processing event ��
	proxy:NotNetMessage_begin();
		--��0�b�づ-- --EN:--��After 0 seconds��--
		proxy:OnKeyTime2( 999993, "Second_Initialize_m03_03_00_00", 0.0, 0, 0, once );	
	proxy:NotNetMessage_end();	
	
	print("Initialize_m03_03_00_00 end");
end


--------------------------------------------------------------------------------------
--Initialize����Ă΂��A1�t���[���x��̏�����������999999 --EN:--Initialization with a delay of 1 frame, called from Initialize ��999999
--------------------------------------------------------------------------------------
--��999999���ꕔ�AInit�ł͏����ł��Ȃ��̂ŁA�c���Ă��� --EN:-- �� 999999 �� Some parts cannot be processed by Init, so leave them
function Second_Initialize_m03_03_00_00(proxy, param)
	print("Second_Initialize_m03_03_00_00 begin");

--------------------------------������QWC�C�x���g�֘A������-------------------------------- --EN:--������QWC event related ������--------------------------------
--------------------------------������QWC�C�x���g�֘A������-------------------------------- --EN:--������QWC event related������--------------------------------

	print("Second_Initialize_m03_03_00_00 end");
end



	


--------------------------------------------------------------------------------------
--�G���A�{�X�|�����Đ���1541 --EN:--Area Bospoli Drama Play �� 1541
--------------------------------------------------------------------------------------
--�����̈�̒��ɓ����� --EN:-- entered the activation area
function OnEvent_1541(proxy, param)
	print("OnEvent_1541 begin");
	
	--�|�����Đ��J�n --EN:--Start playing polyplay
	proxy:RequestRemo(30300,REMO_FLAG,1541,1);
	proxy:SetEventFlag( 1541 , 1 );--�|�����Đ��I���t���OON	 --EN:-- Polyplay play end flag ON
	print("OnEvent_1541 end");
end

--��1541_RemoStart���|�����J�n �t�F�[�h�A�E�g������ --EN:--�� 1541_RemoStart �� Poly drama start Fade out complete ��
function OnEvent_1541_RemoStart(proxy,param)
	print( "OnEvent_1541_RemoStart begin" );
	print( "OnEvent_1541_RemoStart end" );
end

--��1541_RemoFinish���|�����Đ��I���ち --EN:--�� 1541_RemoFinish �� After playing the polyplay ��
function OnEvent_1541_RemoFinish(proxy , param)
	print( "OnEvent_1541_RemoFinish begin" );
	
	--�{�X�퓬�J�n�p�̏������Ăяo�� --EN:--Call the process for starting the boss battle
	BossInit_StormOfBeast(proxy,param);

	--�{�X�|�����I����̃{�X�̕\�� --EN:-- Boss display after the end of the Bospoli play
	--proxy:SetDrawEnable( 822, true );
	--proxy:SetColiEnable( 822, true );
	ValidCharactor( proxy, 822);
	
	--�{�X�|�����I����̎q�G�C�̕\�� --EN:--Display of baby stingrays after the end of the Bospoli play
	local eneID;
	for eneID = 400, 411, 1 do
		proxy:SetDrawEnable( eneID, true );
		proxy:SetColiEnable( eneID, true );
	end
	
	--�|�����Đ��I���̃t���O --EN:--flag to end polyplay
	proxy:SetEventFlag( 5085 ,true );
	
	print( "OnEvent_1541_RemoFinish end" );
end



--------------------------------------------------------------------------------------
--�{�X�����̒��ɓ��遡1542 --EN:--Enter the boss room 1542
--------------------------------------------------------------------------------------
--���C�x���g�����[�v�Ȃ̂ŁA�S�����s�[�g�ɂ��遫 --EN:--�� Since the event is a loop, repeat all ��
--��1542�����{�X�����ւ̔����J���� --EN:-- �� 1542 �� The door to the mid-boss room opens ��
function OnEvent_1542(proxy,param)
	print("OnEvent_1542 begin");

	if proxy:IsCompleteEvent( SYSTEM_ID_IGNORE ) == true then
		print("OnEvent_1542 end");
		return;
	end	
	
	--�N���C�A���g�ցA�{�X�����j�~���s��ʒm --EN:--Notify client of failure to block boss room
	if proxy:IsClient() == false then
		proxy:LuaCallStart( 4068 , 1 );	
	end
	
	proxy:LuaCallStart( 1543 , 1 );--����A�j���̓����Đ� --EN:-- Synchronous playback of turning animation
	--proxy:SetEventFlag( SYSTEM_ID_IGNORE, true );
	--���d�N���V�X�e��ID���^�C���A�E�g��ݒ肵��ON�ɂ��� --EN:--Turn on multiple activation system ID by setting timeout
	proxy:SetSystemIgnore( SYSTEM_ID_IGNORE , IGNORE_TIME );
	
	--�v���t�@�C���Z�[�u�v�� --EN:--profile save request
	proxy:SaveRequest_Profile();
	
	print("OnEvent_1542 end");
end


--����A�j���̓����Đ�(ID����) --EN:-- Synchronized playback of turning animation (ID is different)
function OnEvent_1542_1(proxy,param)
	print("OnEvent_1542_1 begin");

	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		if param:IsNetMessage() == true then
			--����A�j���Đ��𓯊� --EN:-- Synchronize turning animation playback
			proxy:TurnCharactor( 10001 + param:GetPlayID(), 2888 );
		else
			proxy:LockSession();--���[�������b�N���܂��I --EN:--lock the room!
			--����A�j���Đ����s���A���̏I������OnEvent_1542_2�𔭍s���� --EN:--Play the turning animation and issue OnEvent_1542_2 at the end
			proxy:OnTurnCharactorEnd( 1543, 10000, 2888, "OnEvent_1542_2", once );
		end
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	
	print("OnEvent_1542_1 end");
end

--����A�j���̓����Đ��I���� --EN:--After synchronous playback of turning animation ends
function OnEvent_1542_2(proxy,param)
	print("OnEvent_1542_2 begin");

	--�����p�����A�j���Đ� --EN:--Play walking animation for synchronization
	proxy:LuaCallStart( 4012, 1 );
	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		proxy:OnChrAnimEnd( 1543, 10000, ANIMEID_WALK, "OnEvent_1542_3", once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	
	print("OnEvent_1542_2 end");
end

--�����A�j���̓����Đ��I���� --EN:--After the synchronized playback of the walking animation ends
function OnEvent_1542_3(proxy,param)
	print("OnEvent_1542_3 begin");

	--�ŏ��̐l���{�X�����̒��ɓ���I����Ă�����A���ɔz�M����Ă���͂��Ȃ̂ŁA����������Ȃ��n���h�� --EN:--If the first person has already entered the boss room, it should have already been delivered, so no more handlers
	if proxy:IsCompleteEvent( 1542 ) == false then
		proxy:LuaCallStart( 1543 , 5 );--2��ڈȍ~�Ƀ{�X�����ɓ��邽�߂̃C�x���g�z�M�p --EN:--For event delivery to enter the boss room after the second time
		proxy:LuaCallStart( 4045 , 1 );	--�N���C�A���g�ցA�{�X�����ɓ����悤�ɂȂ������Ƃ�ʒm --EN:--Notify clients that they can now enter the boss room
		proxy:LuaCallStart( 1543 , 6 );--�t���O�Z�b�g(�����p)		 --EN:--flag set (for synchronization)
		--���̏b�Ǝq�G�C�Ή� --EN:--Storm beast and baby stingray support
		local eneidlist = {822,400,401,402,403,404,405,406,407,408,409,410,411};
		local num = table.getn( eneidlist );
		for index = 1 , num , 1 do
			Lua_MultiDoping(proxy,eneidlist[index]);--�}���`�v���C�h�[�s���O --EN:-- Multiplayer Doping
		end
	end

	--�v���C���[�����̒��Ɋ��S�ɂ͂������^�C�~���O�ŁA�{�X�̎v�l�����Z�b�g --EN:--Reset the boss' thoughts when the player is completely inside the door
	--�ꏊ�������ƃv���C���[��������Ȃ�����(�U�����Ă��Ȃ�) --EN:--Because you can't find the player if the location is bad (they won't attack)
	if proxy:IsClient() == false then
		proxy:ResetThink( 822 );
	end	
	
	proxy:SetEventFlag( SYSTEM_ID_IGNORE, false );
	print("OnEvent_1542_3 end");
end


--��1542 2��ڈȍ~�Ƀ{�X�����ɓ��邽�߂̃C�x���g�z�M�p --EN:-- 1542 For event delivery to enter the boss room after the second time
function OnEvent_1542_GO_TO_IN(proxy, param)
	print("OnEvent_1542_GO_TO_IN begin");	
	proxy:NotNetMessage_begin();
		--��1542�������J���Ă���Ƃ��ɒ��ɓ��邽�߂̃C�x���g��ǉ���--�n���h���� OnEvent_1542 --EN:--��1542��Add an event to enter when the door is open��--The handler is OnEvent_1542
		proxy:OnPlayerActionInRegion( 1543, 2892, "OnEvent_1542", HELPID_GO_TO_IN, everytime );--
	proxy:NotNetMessage_end();	
	print("OnEvent_1542_GO_TO_IN end");
end


--��1542 �t���O�Z�b�g(�����p) --EN:-- 1542 flag set (for synchronization)
function OnEvent_1542_flag_set(proxy, param)
	print("OnEvent_1542_flag_set begin");		
	proxy:SetEventFlag( 1542 , 1 );
	proxy:DeleteEvent( 1542 );
	print("OnEvent_1542_flag_set end");
end


--------------------------------------------------------------------------------------
--�{�X�������o��(�퓬�J�n)��4999 --EN:-- Boss begins to move (battle begins) 4999
--------------------------------------------------------------------------------------
function OnEvent_4999(proxy, param)
	if proxy:IsCompleteEvent( 5085 ) == false then
		return;
	end
	
	print("OnEvent_4999 begin");
	
	--�{�X��pBGM�Đ��J�n --EN:--Start playing BGM for boss battle
	proxy:PlayPointSE( 2602, SOUND_TYPE_M, 30300000, 3 );
	--���W�b�NON --EN:--Logic ON
	proxy:EnableLogic( 822 , true );
	--���̏b�͂��̒i�K�ł̓��W�b�NOFF --EN:--Storm Beast is off logic at this stage
	
	--�{�X�퓬�J�n�p�̏������Ăяo�� --EN:--Call the process for starting the boss battle
	--BossInit_StormOfBeast(proxy,param);
	--�ǂݍ��݃^�C�~���O�̂Ƃ�����ǉ�����Ăق����̂Ńt���O���ĂȂ� --EN:-- I want it to be added every time at the time of reading, so I don't set a flag
	--�{�X�Q�[�W�\�� --EN:-- Boss gauge display
	proxy:SetBossGauge( 822 , 0 ,5030 );
	
	--�Ď��폜 --EN:--Delete monitor
	proxy:DeleteEvent( 4999 );
	
	print("OnEvent_4999 end");
end


--------------------------------------------------------------------------------------
--�G���A�{�X�̎��S��4992 --EN:--Death of area boss 4992
--------------------------------------------------------------------------------------
function OnEvent_4992(proxy, param)
	print("OnEvent_4992begin");
	
	proxy:NotNetMessage_begin();
		--��4992_1��1�b�o�߁� --EN:--��4992_1��1 second passed��
		proxy:OnKeyTime2( 4992, "OnEvent_4992_1", 1, 0, 0, once);
		--��4992_2��2�b�o�߁� --EN:--��4992_2��2 seconds passed��
		proxy:OnKeyTime2( 4992, "OnEvent_4992_2", 2, 0, 1, once);
		--�}���`���U�Ď� --EN:--Multi-Dismissal Monitoring
		proxy:OnRegistFunc( 4992 , "Check_4992_PT","OnEvent_4992_PT",0,once);
	proxy:NotNetMessage_end();
	
	proxy:SetEventFlag( 4992, 1 );--�{�X�L�^�p�@�V�d�l���p --EN:--For Boss recording new specification shared
	--�Q�b��ɂ́ABGM�ƌ��̕ǂ������Ă���͂� --EN:--After 2 seconds, the BGM and light wall should disappear
	proxy:SetEventFlag(4995 , true);

	--�z�X�g���L�����@or�@�V���O��		 --EN:--Host's own character or single
	proxy:SetEventFlag(	8011, 1 );--�N���A�t���OON	 --EN:--Clear flag ON

	--�G�C�ʏ�X�V���J�n --EN:--A normal update started
	--LuaFunc_NormalOmission(proxy,822);
	
	--�q�G�C��n��--�e�ƐS�� --EN:--Cleaning up child ray--suicide with parents
	local eneID = 400;
	for eneID=400 , 411 , 1 do
		if proxy:IsAlive(eneID) == true then
			proxy:ForceDead(eneID);
		end
	end	
	
	--�u���b�N�N���A������ --EN:-- to block clear processing
	--proxy:LuaCallStart( 4040, 1 );
	--�V�u���b�N�N���A������ --EN:--To new block clear processing
	proxy:CustomLuaCallStart( 4050, 822);
	
	--�����g�J�Q���Z�b�g --EN:-- crystal lizard reset
	ResetTokage(proxy);
		
	print("OnEvent_4992 end");
end

--��4992_1����������J��:���{�X���S��1�b�� --EN:--��4992_1��Open the door inside the castle: 1 second after the middle boss dies��
function OnEvent_4992_1(proxy, param)
	print("OnEvent_4992_1 begin");
	
	--�{�X��|���������X�V(���ɂ���ăt���O�𗧂Ă�) --EN:--update number of bosses killed (flag by number)
	GetBossFlagCount( proxy, param );
	
--�A�C�e������֘A------- --EN:--Item Acquisition Related-------
	
	--�z�X�g�v���C���[�̂݃A�C�e������C�x���g�Ɏg�p --EN:--Used for item acquisition event only for host players
	local possible_chr_type = ATTR_HOST + ATTR_LIVE + ATTR_GREY;

	--�󎀑�(�\�E��?)�L���� --EN:--Treasure corpse (soul?) activation
	proxy:SetDrawEnable( 1979 , true );
	proxy:SetColiEnable( 1979 , true );
	--�󎀑�(�\�E��?)2�L���� --EN:--Treasure corpse (soul?) 2 enabled
	proxy:SetDrawEnable( 1978 , true );
	proxy:SetColiEnable( 1978 , true );
	
	--��(�\�E��)�A�C�e���擾�p�C�x���g�Ď��ǉ��� --EN:--�� (Soul) Added event monitoring for item acquisition��
	if proxy:IsCompleteEvent( 4996 ) == false then
		proxy:ValidSfx( 2600 );--SFX �L���� --EN:--SFX enable
		proxy:ValidSfx( 2601 );--SFX �L���� --EN:--SFX enable
		proxy:TreasureDispModeChange2( 1979 , true ,KANAME_SFX);--���点�� --EN:-- let it shine
		proxy:OnDistanceActionAttribute( 4996 , 10000 , 1979 , "OnEvent_4996" , WarpGimmickDist_A , 10010180 , 0 , 180 , possible_chr_type, once );
	end
------------------------

	--���g���t�B�[�擾���聥 --EN:--��Trophy Acquisition Judgment��
	Lua_RequestUnlockTrophy(proxy, 7);
end

--�}���`���U�Ď� --EN:--Multi-Dismissal Monitoring
function Check_4992_PT(proxy)
	if proxy:IsInParty() == false then
		return true;
	end
	return false;
end

--�}���`����Ȃ� --EN:--not multiplayer
function OnEvent_4992_PT(proxy,param)
	print("OnEvent_4992_PT begin");
	--���{�X�����̑O��̖��@�ǂ�������(�S�v���C���[)	 --EN:--The magic walls before and after the mid-boss room disappear (all players)
	proxy:SetColiEnable( 1996 , false );	
	proxy:SetDrawEnable( 1996 , false );
	
	--���{�X�������@�ǂ�SFX�폜 --EN:--Remove the SFX of the mid-boss room magic wall
	proxy:InvalidSfx( 1988 , true );	
	
	--���{�X�����O�̈ړ������C�x���g���폜 --EN:--Delete the movement processing event in front of the mid-boss room
	proxy:DeleteEvent( 1542 );--��l�ڂ�����Ƃ��p --EN:--For when the first person enters
	proxy:DeleteEvent( 1543 );--��l�ڈȍ~������Ƃ��p --EN:--For when the second and subsequent people enter
	proxy:DeleteEvent( 4999 );--�{�X�퓬�J�n�p	 --EN:--For boss battle start
	print("OnEvent_4992_PT end");	
end


--��4992_2����������J��:���{�X���S��1�b�� --EN:--��4992_2��Open the door inside the castle: 1 second after the middle boss dies��
function OnEvent_4992_2(proxy, param)
	print("OnEvent_4992_2 begin");
		
	--�{�X��p��BGM��~ --EN:--BGM stop for boss battles
	proxy:StopPointSE( 3 );
		
	--[[�Z�b�V�������U���̖��@�ǐ؂�ւ������̓O���[�o��?]] --EN:--[[Magic wall switching processing when disbanding a session is global?]]
	
	print("OnEvent_4992_2 end");
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
--��4998���Β��Ƀ��[�v�� --EN:-- �� 4998 �� Warp to the stone pillar ��
--------------------------------------------------------------------------------------
function OnEvent_4998(proxy,param)	
	print("OnEvent_4998 begin");
		
	--�Z�b�V�������ł͂Ȃ����H --EN:--Are you in session?
	if proxy:IsSession() == false then
		proxy:RepeatMessage_begin();
			--��70_1���I�����j���[�̊Ď��� --EN:--��70_1��Select menu monitoring��
			proxy:OnSelectMenu(4998, "OnEvent_4998_1", 10010710, 0, 2, 1979, 2, once);			
		proxy:RepeatMessage_end();
	else
		--�Z�b�V�������Ȃ�ŕ\�� --EN:--Why display during session
		--proxy:InfomationMenu( INFOMENU_TYPE_SIMPLE, 0, MSG_CATEGORY_EVENT, 10010720, 1);
		--proxy:ShowGenDialog(10010720,1,1,true);
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010720, 0, 6, 1979, GEN_DIALOG_DIST, once );
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
	end

	print("OnEvent_4998 end");
end

--��4998_1���I�����j���[�̊Ď��� --EN:--��4998_1��Monitor selection menu��
function OnEvent_4998_1(proxy,param)	
	print("OnEvent_4998_1 begin");	
	
	if proxy:IsSession() == false then
		if param:IsNetMessage() == true then
			proxy:PlayAnimation(10001+param:GetPlayID(),8283);
			print("OnEvent_4998_1 end");
			return;
		end
			
		proxy:PlayAnimation(10000,8283);
		proxy:NoAnimeTurnCharactor( 10000 , 1979 ,TURNSKIP_ANGLE);
		proxy:NotNetMessage_begin();
		proxy:RepeatMessage_begin();
			proxy:OnChrAnimEnd( 4998 , 10000 , 8283 , "OnEvent_4998_2",once);
		proxy:RepeatMessage_end();
		proxy:NotNetMessage_end();
		
		proxy:SetEventFlag(4998,true);
	else
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010720, 0, 6, 1983, GEN_DIALOG_DIST, once );
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
	end
	
	print("OnEvent_4998_1 end");
end

--��4998_2���Β��Ƀ��[�v�� --EN:-- �� 4998_2 �� Warp to the stone pillar ��
function OnEvent_4998_2(proxy,param)	
	print("OnEvent_4998_2 begin");
	
	proxy:PlayAnimation( 10000 , 8284 );--�����E�ɋA��A�j�����Đ� --EN:--Play animation to return to your own world
	--�Β��֖߂��Ă�������̃t���O�𗧂Ă� --EN:--Flag the judgment of returning to the stone pillar
	proxy:SetEventFlag(8083, true);
	
	--���S�񕜗v�� --EN:-- full recovery request
	proxy:RequestFullRecover();
	--�Íԗv�΂ɖ߂� --EN:--Return to Old Fort Keystone
	proxy:WarpNextStage( 1, 0, 0, 0, 1007);	
	print("OnEvent_4998_2 end");
end



--------------------------------------------------------------------------------------
--��4996���\�E�����聡 --EN:-- �� 4996 �� Get Seoul ��
--------------------------------------------------------------------------------------
function OnEvent_4996(proxy, param)
	print("OnEvent_4996 begin");
	
	--�v���C���[�̓����A�j���[�V����(true:�p�[�e�B�[�v���C���[���A�j���[�V��������) --EN:--Player synchronous animation (true: party player animated)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_PICK ) == true then--�V�����A�j��  --EN:-- new anime
		print("OnEvent_4996 end");
		return true;
	end
	
	proxy:NotNetMessage_begin();
		--0.0�b��ɃA�C�e���擾�C�x���g�𔭍s --EN:-- Issue an item acquisition event after 0.0 seconds
		proxy:OnKeyTime2( 4996, "OnEvent_4996_1", 0.0, 0, 0, once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_4996 end");
end


--��4996_1���A�C�e���擾�� --EN:-- �� 4996_1 �� item acquisition ��
function OnEvent_4996_1(proxy, param)
	print("OnEvent_4996_1 begin");

	--�A�C�e���擾�֐�--�p�����[�^10232�Q�� --EN:--item retrieval function--see parameter 10232
	proxy:GetRateItem(10232);	
	--�A�C�e���擾�֐�--�p�����[�^10278�Q�� --EN:--item retrieval function--see parameter 10278
	proxy:GetRateItem(10278);	
	--�A�C�e���擾�֐�--�p�����[�^10279�Q�� --EN:--item retrieval function--see parameter 10279
	proxy:GetRateItem(10279);	
	--�A�C�e���擾�֐�--�p�����[�^10280�Q�� --EN:--item retrieval function--see parameter 10280
	proxy:GetRateItem(10280);	
	--�A�C�e���擾�֐�--�p�����[�^10281�Q�� --EN:--item retrieval function--see parameter 10281
	proxy:GetRateItem(10281);	
	
	--�A�C�e�����擾�ς� --EN:--item already acquired
	proxy:SetEventFlag( 4996, 1 );
	
	--�󔠃V�F�[�_�[�͏����܂���B --EN:--Treasure chest shader does not disappear.
	--proxy:TreasureDispModeChange( 1979 , false );

	--SFX�������� --EN:--SFX disappear
	proxy:InvalidSfx( 2600 , true );
	--proxy:InvalidSfx( 2601 , true );
	
	if proxy:IsCompleteEvent( 8035 ) == false then
		proxy:NotNetMessage_begin();
			--�u�Ԃŕ\������ƃ��j���[����ɏo��̂ő҂� --EN:--If you display it instantly, the menu will appear first, so wait
			proxy:OnKeyTime2( 8035 , "OnEvent_8035_wait",0.5 , 0 , 1, once);			
		proxy:NotNetMessage_end();
	else
		--���v�΂Ń��[�v�p�̊Ď���ǉ��� --EN:--�� Added surveillance for warp with keystone ��
		proxy:OnDistanceActionAttribute( 4998 , 10000 , 1979 , "OnEvent_4998" , WarpGimmickDist_A , HELPID_GO_TO_SEKITYUU , 0 , 180 , ATTR_NOSESSION , everytime );
	end	

	print("OnEvent_4996_1 end");
end	

--[[
	if proxy:IsCompleteEvent( 8035 ) == false then
		proxy:NotNetMessage_begin();
			--�u�Ԃŕ\������ƃ��j���[����ɏo��̂ő҂� --EN:--If you display it instantly, the menu will appear first, so wait
			proxy:OnKeyTime2( 8035 , "OnEvent_8035_wait",0.5 , 0 , 1, once);			
		proxy:NotNetMessage_end();
	else
		--���v�΂Ń��[�v�p�̊Ď���ǉ��� --EN:--�� Added surveillance for warp with keystone ��
		proxy:OnDistanceActionAttribute( 4998 , 10000 , 1979 , "OnEvent_4998" , WarpGimmickDist_A , HELPID_GO_TO_SEKITYUU , 0 , 180 , ATTR_NOSESSION , everytime );
	end	
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
	proxy:OnDistanceActionAttribute( 4998 , 10000 , 1979 , "OnEvent_4998" , WarpGimmickDist_A , HELPID_GO_TO_SEKITYUU , 0 , 180 , ATTR_NOSESSION , everytime );
	print("OnEvent_8035 end");
end


--[[
--------------------------------------------------------------------------------------
--��5000���{�XHP�E�q�G�C���S�Ď��� --EN:-- �� 5000 �� Boss HP, child ray death monitoring ��
--------------------------------------------------------------------------------------
--���S�Ď��̓��� --EN:-- Mortality monitoring integration
function CheckDeadCount(proxy,eneID)
	print("OnEvent_5000_",eneID," begin");	
	local deadCount = 0;
	local ID = 400;	
		
	for ID = 400, 411, 1 do
		if proxy:IsAlive(ID) == false then
			deadCount = deadCount + 1;
		end
	end
		
	if deadCount >= BeastChildDeadCount then
		proxy:LuaCallStart(5001,1);
	end	
	print("OnEvent_5000_",eneID," end");	
end
]]

--[[
--�q�G�C�̎��S�Ď� --EN:--Father ray mortality monitoring
function OnEvent_5000_400(proxy,param) CheckDeadCount(proxy,400); end--ID400
function OnEvent_5000_401(proxy,param) CheckDeadCount(proxy,401); end--ID401
function OnEvent_5000_402(proxy,param) CheckDeadCount(proxy,402); end--ID402
function OnEvent_5000_403(proxy,param) CheckDeadCount(proxy,403); end--ID403
function OnEvent_5000_404(proxy,param) CheckDeadCount(proxy,404); end--ID404
function OnEvent_5000_405(proxy,param) CheckDeadCount(proxy,405); end--ID405
function OnEvent_5000_406(proxy,param) CheckDeadCount(proxy,406); end--ID406
function OnEvent_5000_407(proxy,param) CheckDeadCount(proxy,407); end--ID407
function OnEvent_5000_408(proxy,param) CheckDeadCount(proxy,408); end--ID408
function OnEvent_5000_409(proxy,param) CheckDeadCount(proxy,409); end--ID409
function OnEvent_5000_410(proxy,param) CheckDeadCount(proxy,410); end--ID410
function OnEvent_5000_411(proxy,param) CheckDeadCount(proxy,411); end--ID411

--�G�C��HP�̊����Ď� --EN:--Proportion monitoring of stingray's HP
function OnEvent_5000_HP(proxy,param)
	print("OnEvent_5000_HP begin");
	proxy:LuaCallStart(5001,1);
	print("OnEvent_5000_HP end");
end
]]

--[[
--------------------------------------------------------------------------------------
--��5001���{�X�ˌ��|������ --EN:-- �� 5001 �� Boss assault police play ��
--------------------------------------------------------------------------------------
--�|�����̋N�� --EN:--Launch of polyplay
function OnEvent_5001(proxy,param)
	print("OnEvent_5001 begin");
	proxy:DeleteEvent(5000);
	proxy:RequestRemo(30301,REMO_FLAG,5001,1);
	proxy:SetEventFlag(5001,true);
	print("OnEvent_5001 end");
end

--�|�����̃t�F�[�h�A�E�g --EN:--Fade out of polyplay
function OnEvent_5001_RemoStart(proxy,param)
	print("OnEvent_5001_RemoStart begin");
	--��s�֘A�A�j���Ď��폜 --EN:-- Remove flight-related animation monitoring
	proxy:DeleteEvent(5030);
	print("OnEvent_5001_RemoStart end");
end

--�|�����̃t�F�[�h�C�� --EN:--Fade in polyplay
function OnEvent_5001_RemoFinish(proxy,param)
	print("OnEvent_5001_RemoFinish begin");
	--�{�X�؂�ւ������� --EN:-- Boss switching initialization
	BossInit_StormOfBeast2(proxy,param);
	print("OnEvent_5001_RemoFinish end");
end
]]






--------------------------------------------------------------------------------------
--���������@�������ς� function  --EN:--�� Unorganized �� Organized function
--------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------
--��1544���{�X�J�����ݒ聡 --EN:-- �� 1544 �� boss camera settings ��
--------------------------------------------------------------------------------------
function OnEvent_1544(proxy,param)
	--print("OnEvent_1544 begin");
	--�{�X������ł��Ȃ��@���@�{�X�Ƃ̐퓬���J�n���Ă��� --EN:-- Boss is not dead and has started a battle with the boss
	if proxy:IsCompleteEvent( 4992 ) == false and proxy:IsCompleteEvent( 4999 ) == true then
		--�{�X��@�񃍃b�N�J���� --EN:-- Boss battle unlocked camera
		proxy:SetCamModeParamTargetId(3031);
		--�{�X��@���b�N�J���� --EN:--Boss battle rock camera
		proxy:SetCamModeParamTargetIdForBossLock(3030);
	end
	--print("OnEvent_1544 end");
end


--------------------------------------------------------------------------------------
--��1590�������X�g�[���u�����K�[�ݒ聡 --EN:-- �� 1590 �� Enhanced Stormbringer settings ��
--------------------------------------------------------------------------------------
function OnEvent_1590(proxy,param)
	--�{�X������ł��Ȃ��@���@�{�X�Ƃ̐퓬���J�n���Ă��� --EN:-- Boss is not dead and has started a battle with the boss
	--if proxy:IsCompleteEvent( 4992 ) == false and proxy:IsCompleteEvent( 4999 ) == true then
		local isHasWepon = false;		
		if proxy:GetRightCurrentWeponId() == 21100 then isHasWepon = true end;		
		--print("HadWepId",proxy:GetRightCurrentWeponId());		
		--print("isHasWepon ",isHasWepon);
		--���肵�����ʂ����̂܂ܐݒ� --EN:-- Set the judged result as it is
		proxy:SetIsUseLongLongSword( isHasWepon );		
	--end
end

--�X�g�[���u�����K�[�I�� --EN:--Storm Bringer End
function OnEvent_1590_out(proxy,param)
	print("OnEvent_1590_out begin");
	proxy:SetIsUseLongLongSword( false );		
	print("OnEvent_1590_out end");
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
function PlayerDeath_m03_03_00_00(proxy, param)
	print("PlayerDeath_m03_03_00_00");
	
--	LuaFunc_VisibleTheWanderingDemon(proxy, param, demon_id_list_m03_03_00_00);
--	proxy:SetEventFlag( 20 , 1 );--�t���O�͉��A�w�肪����Ες���B --EN:The -- flag is tentative, and will be changed if specified.
	
	print("PlayerDeath_m03_03_00_00");
end
	
--���O���[�o���̌�������������Ă΂��(�\��) --EN:--��Called from global blood letter revival (solo)
function PlayerRevive_m03_03_00_00(proxy,param)
	print("PlayerRevive_m03_03_00_00");
	
--	LuaFunc_InvisibleTheWanderingDemon(proxy, param, demon_id_list_m03_03_00_00);
--	proxy:SetEventFlag( 20 , 0 );--�t���O�͉��A�w�肪����Ες���B --EN:The -- flag is tentative, and will be changed if specified.
	
	print("PlayerRevive_m03_03_00_00");
end


--------------------------------------------------------------------------------------
--1570���ԂP�E�Q�̎q�G�C�̖����� --EN:--1570�� Nullification of Fort 1 and 2's child Ray
--------------------------------------------------------------------------------------
function OnEvent_1570(proxy,param)
	--if proxy:IsClient() == false then
	print("OnEvent_1570 begin");
	proxy:LuaCallStart( 1570 , 0 );
	print("OnEvent_1570 end");
	--end
end

function OnEvent_1570_1(proxy,param)
	print("OnEvent_1570_1 begin");
	for eneid = 388 , 399 , 1 do
		InvalidCharactor( proxy , eneid );
	end
	proxy:SetEventFlag( 1570 ,true );
	print("OnEvent_1570_1 end");
end

--------------------------------------------------------------------------------------
--1571���ԂP�E�Q�̎q�G�C�̗L���� --EN:--1571�� Activation of Fort 1 and 2 Child Ray
--------------------------------------------------------------------------------------
function OnEvent_1571(proxy,param)
	--if proxy:IsClient() == false then
	print("OnEvent_1571 begin");
	proxy:LuaCallStart( 1571 , 0 );
	print("OnEvent_1571 end");
	--end
end

function OnEvent_1571_1(proxy,param)
	print("OnEvent_1571_1 begin");
	for eneid = 388 , 399 , 1 do
		ValidCharactor( proxy , eneid );
	end
	proxy:SetEventFlag( 1570 ,false );
	print("OnEvent_1571_1 end");
end


-----------------------------------------------------------------------------
--��1580�������g�J�Q�C�x���g4 --EN:-- �� 1580 �� Crystal Lizard Event 4
-----------------------------------------------------------------------------
function OnEvent_1580(proxy,param)
	print("OnEvent_1580 begin");
	proxy:SetEventFlag( 1580 , true );
	proxy:DeleteEvent( 1580 );
	print("OnEvent_1580 end");
end

-----------------------------------------------------------------------------
--��1582�������g�J�Q�C�x���g5 --EN:-- �� 1582 �� Crystal Lizard Event 5
-----------------------------------------------------------------------------
function OnEvent_1582(proxy,param)
	print("OnEvent_1582 begin");
	proxy:SetEventFlag( 1582 , true );
	proxy:DeleteEvent( 1582 );
	print("OnEvent_1582 end");
end




--------------------------------------------------------------------------------------
--�X�g�[���u�����K�[��1591 --EN:--Storm Bringer 1591
--------------------------------------------------------------------------------------
function OnEvent_1591(proxy,param)
	if param:IsNetMessage() == false then	
	print("OnEvent_1591 begin");
	proxy:NotNetMessage_begin();
	proxy:RepeatMessage_begin();
		--�A�j�� --EN:--animation
		proxy:PlayAnimation( 10000 , 8290);
		proxy:PlayAnimation( 1610 , 1);	
		proxy:OnKeyTime2( 1591 , "OnEvent_1591_0",0.01,0,0,once);
	proxy:RepeatMessage_end();
	proxy:NotNetMessage_end();
	
	print("OnEvent_1591 end");
	end
end

function OnEvent_1591_0(proxy,param)
	print("OnEvent_1591_0 begin");
	--if proxy:IsPlayerStay(10000) == true then
	if proxy:IsEventAnim( 10000 , 8290 ) == true then		
		proxy:LuaCallStart( 1591, 2);			
	else
		proxy:ForcePlayAnimation( 1610 , 0);	
	end
	print("OnEvent_1591_0 end");
end

--��1591_1���A�C�e���擾�� --EN:-- �� 1591_1 �� item acquisition ��
function OnEvent_1591_1(proxy,param)
	print("OnEvent_1591_1 begin");
	--�A�C�e���擾�֐�--�p�����[�^10419�Q�� --EN:--item retrieval function--see parameter 10419
	proxy:GetRateItem(10217);	
	
	--�A�C�e�����擾�ς� --EN:--item already acquired
	proxy:SetEventFlag( 1591, true );
	
	--OBJ���������߂̃C�x���g�z�M --EN:--Event distribution for erasing OBJ
	proxy:LuaCallStart( 1591, 1);

	print("OnEvent_1591_1 end");
end

--��1591_2����OBJ��\���p�� --EN:--�� 1591_2 �� For hiding the sword OBJ ��
function OnEvent_1591_2(proxy,param)
	print("OnEvent_1591_2 begin");
	--�I�u�W�F�������� --EN:--The object disappears
	proxy:SetDrawEnable( 1610 , false );--�ЂƂ܂��`�悾��OFF --EN:--Only drawing is turned off for the time being
	proxy:SetColiEnable( 1610 , false );--������͂���͕̂s��(����ł͂Ȃ��悤�Ȃ̂ŏ����Ȃ�) --EN:--I don't know if there is a hit (I don't delete it because it doesn't seem to be the current situation)
	
	proxy:DeleteEvent( 1591 );
	print("OnEvent_1591_2 end");
end

--�A�j���̓����Ď� --EN:--Synchronous monitoring of anime
function OnEvent_1591_3(proxy,param)
	print("OnEvent_1591_3 begin");
	proxy:TreasureDispModeChange2( 1610, false ,KEN_SFX);
	--�v���C���[�̓����A�j���[�V����(true:�p�[�e�B�[�v���C���[���A�j���[�V��������) --EN:--Player synchronous animation (true: party player animated)
	if Luafunc_PlaySynchroAnimation( proxy, param, 8290 ) == true then--�V�����A�j��  --EN:-- new anime
		proxy:PlayAnimation( 1610 , 1);	
		print("OnEvent_1591_3 end");
		return true;
	end		
	
	--���Ƀ��[�v --EN:--Warp to sword
	proxy:WarpDmy( LOCAL_PLAYER , 1610 , 191 );
	proxy:NotNetMessage_begin();
		proxy:OnChrAnimEnd( 1591 , LOCAL_PLAYER , 8290 , "OnEvent_1591_1", once);
	proxy:NotNetMessage_end();	
	print("OnEvent_1591_3 end");	
end
