
--ÅÀøÊÌ­¶üúp[^ --EN:--Poison Swamp Effect Occurrence Cycle Parameter
PoizonCycle_low			= 1.00;	--ÅÀøÊÌüú(Å·) --EN:--Poison swamp effect cycle (longest)
PoizonCycle_High		= 1.01;	--ÅÀøÊÌüú(ÅZ) --EN:--Poison swamp effect cycle (shortest)

IsInPoizonArea			= false;--ÅÀGAÉüÁÄ¢é© --EN:--Are you in the Poison Swamp area?



--[[yZzÌóÔ]] --EN:--[[[Selenium] status]]
SELEN_STATE_SEARCH_BROTHER	= 16380;--íðTµÄ¢é --EN:--I'm looking for my brother
SELEN_STATE_ANGRY			= 16381;--GÎ --EN:--hostile
SELEN_STATE_DEAD			= 16382;--S --EN:--death
SELEN_STATE_THANKS			= 16383;--« --EN:--satisfaction
SELEN_STATE_PURIFY			= 16384;--¬§ --EN:--Buddha
selen_flag_list = {
	SELEN_STATE_SEARCH_BROTHER,
	SELEN_STATE_ANGRY,
	SELEN_STATE_DEAD,
	SELEN_STATE_THANKS,
	SELEN_STATE_PURIFY
};
TOTALDAMAGE_SELEN = 100;--yZzGÎ~Ï_[W --EN:--[Selenium] Hostile Accumulated Damage

--NQWFl[^AÖWNQID --EN:--Jellyfish generator A related jellyfish ID
KURAGE_GEN_ALIST = {170,171,172,173,174,175,176,177,178,179,180,181,182,183,184,185,186,187,188,189,190,191,192};
--NQWFl[^BÖWNQID --EN:--Jellyfish generator B related jellyfish ID
KURAGE_GEN_BLIST = {200,201,202,203,204,205,206,207,208,209,210,211,212,213,214,215,216,217,218};
--NQWFl[^CÖWNQID --EN:--Jellyfish generator C relationship Jellyfish ID
KURAGE_GEN_CLIST = {220,221,222,223,224,225,226,227,228,229,230,231,232,233,234,235,236,237,238,239,240,241,242,243,244};
--NQWFl[^DÖWNQID --EN:--Jellyfish generator D related jellyfish ID
KURAGE_GEN_DLIST = {250,251,252,253,254,255,256,257,258,259,260,261,262,263,264,265,266,267,268};

RapConditionCount = 0;
--------------------------------------------------------------------------------------
--}bvÇÝÝÉÇÜêéú»¡ --EN:--Initialization process read when reading the map ¡
--------------------------------------------------------------------------------------
function Initialize_m05_01_00_00(proxy)
	print("Initialize_m05_01_00_00 begin");
-----------------------------------------------------------------------------------------
--{XÖA --EN:--Boss related
-----------------------------------------------------------------------------------------
--¡533¡{X®Éüé¡ --EN:-- ¡ 533 ¡ Enter the boss room ¡
	--{Xª¶«Ä¢éÆ«¾¯Cxgo^ --EN:-- Event registration only when the mid-boss is alive
	if proxy:IsCompleteEvent( 5770 ) == false then
	
		--<ÇÁ>\ÌÆ«ÍêxÚÉ{X®ÉüépÌCxgðño^³¹½¢ÌÅAÎ·étOðOFFÉ·éB --EN:--<Addition> When soloing, we want to register the event for entering the boss room for the first time every time, so turn off the corresponding flag.
		SingleReset(proxy, 533);
	
		--¤¯úAjÄ¶pÌJnnh(ùñ¨à«) --EN:--¤ Start handler for synchronous animation playback (turning ¨ walking)
		proxy:LuaCall( 534, 1, "OnEvent_534_1", everytime );
		--¤2ñÚÈ~É{X®Éüé½ßÌCxgzMp --EN:--¤For event delivery to enter the boss room after the second time
		proxy:LuaCall( 534 , 5 , "OnEvent_533_GO_TO_IN" , everytime );
		--¤tOZbg(¯úp) --EN:--¤flag set (for synchronization)
		proxy:LuaCall( 534 , 6 , "OnEvent_533_flag_set" , everytime );
		
		--N©ª{XOàðÜ¾ÊßµÄ¢È¢ --EN:--Someone hasn't passed through the boss front door yet
		if proxy:IsCompleteEvent( 533 ) == false then
		
			--(ZbVÉ){XOÌ@ÇðÅÉÊêéÌÍ¶¶Ìl¾¯ --EN:--(During the session) Only survivors can pass through the magic wall in front of the boss first
			local possible_chr_type = ATTR_HOST + ATTR_LIVE + ATTR_GREY;
			
			proxy:NotNetMessage_begin();
				--¥533¥Éüé½ßÌCxgðÇÁ¥ --EN:--¥533¥ Added an event to enter ¥
				proxy:OnPlayerActionInRegionAttribute( 533, 2894, "OnEvent_533", HELPID_GO_TO_IN, possible_chr_type, everytime );
			proxy:NotNetMessage_end();
			
		else --OCS[XgÅ«½Æ«æ¤É¢éÆvíêéB --EN:--Gray ghost seems to be like that when it's done.
			proxy:NotNetMessage_begin();
				--¥534¥Éüé½ßÌCxgðÇÁ¥--nhÍãÆ¯¶ --EN:--¥534¥Add an event to enter inside¥--The handler is the same as above
				proxy:OnPlayerActionInRegion( 534, 2894, "OnEvent_533", HELPID_GO_TO_IN, everytime );
			proxy:NotNetMessage_end();
		end
	else
		InvalidBackRead( proxy, 809 );
	end
	
--¡537¡{Xí¬Jn¡ --EN:-- ¡ 537 ¡ Boss battle begins ¡
	if proxy:IsCompleteEvent( 5770 ) == false then
		SingleReset( proxy, 537 );
		proxy:OnRegionJustIn( 537 , 10000 , 2886 , "OnEvent_537" , once );
	end
--¡5770¡{Xªñ¾ç-- --EN:-- ¡ 5770 ¡ When the boss dies --
	proxy:AddFieldInsFilter( 809 );
	if proxy:IsCompleteEvent( 5770 ) == false then
		proxy:OnCharacterDead(5770,809,"OnEvent_5770",once);
	else
		proxy:InvalidSfx( 1986, false );
		proxy:InvalidSfx( 1990, false );
	end

--¡{XÖAÌú» --EN:--¡ Boss-related initialization processing
	if proxy:IsCompleteEvent( 5770 ) ==true then
		
		--¤{XñÅ¢éÆ« --EN:--¤When the boss is dead
		--{X¢È­Èé --EN:--boss disappears
		InvalidCharactor( proxy , 809 );
		
		--@ÇÁ¦é --EN:--Magic wall disappears
		proxy:SetColiEnable( 1998 , false );
		proxy:SetColiEnable( 1994 , false );
	
		proxy:SetDrawEnable( 1998 , false );
		proxy:SetDrawEnable( 1994 , false );
		
		--SFX OFF
		proxy:InvalidSfx( 1986 , false );
		proxy:InvalidSfx( 1990 , false );
		
		--zXgvC[ÌÝACeüèCxgÉgp --EN:--Used for item acquisition event only for host players
		local possible_chr_type = ATTR_HOST + ATTR_LIVE + ATTR_GREY;

		--óÌ(\E?)Lø» --EN:--Treasure corpse (soul?) activation
		proxy:SetDrawEnable( 1981 , true );
		proxy:SetColiEnable( 1981 , true );
		proxy:TreasureDispModeChange2( 1981 , true ,KANAME_SFX);--õç¹é --EN:-- let it shine
		--\EÉh³Á½Lø» --EN:--Activation of the sword stuck in the soul
		proxy:SetDrawEnable( 1976 , true );
		proxy:SetColiEnable( 1976 , true );
		--proxy:TreasureDispModeChange2( 1976 , true ,KANAME_SFX);--õç¹é --EN:-- let it shine
		
		--¥(\E)ACeæ¾pCxgÄÇÁ¥ --EN:--¥ (Soul) Added event monitoring for item acquisition¥
		if proxy:IsCompleteEvent( 5773 ) == false then
			--SFXÌLø» --EN:--Enable SFX
			proxy:ValidSfx( 2360 );--vÎÌI[ --EN:--Keystone Aura
			proxy:ValidSfx( 2361 );--õÌ±q --EN:--Particles of light
			
			proxy:TreasureDispModeChange2( 1981 , true ,KANAME_SFX);--õç¹é --EN:-- let it shine
			proxy:OnDistanceActionAttribute( 5773 , 10000 , 1981 , "OnEvent_5773" , WarpGimmickDist_A , 10010180 , 0 , 180 , possible_chr_type, once );
		else
			--SFX OFF
			proxy:InvalidSfx( 2360 , false );--vÎÌI[ --EN:--Keystone Aura
			--proxy:InvalidSfx( 2361 , false );--õÌ±q --EN:--Particles of light
			--¥vÎÅ[vpÌÄðÇÁ¥ --EN:--¥ Added surveillance for warp with keystone ¥
			SingleReset(proxy,5774);
			proxy:OnDistanceActionAttribute( 5774 , 10000 , 1981 , "OnEvent_5774" , WarpGimmickDist_A , HELPID_GO_TO_SEKITYUU , 0 , 180 , ATTR_NOSESSION , everytime );
		end
		
	else
		--¤{X¶«Ä¢éÆ« --EN:--¤ When the boss is alive
		--WbNOFF --EN:--Logic OFF
		proxy:EnableLogic( 809, false );
		
		--ó(\E?) --EN:--Treasure (Soul?)
		proxy:SetDrawEnable( 1981 , false );
		proxy:SetColiEnable( 1981 , false );
		--\EÉh³Á½³ø» --EN:--Nullify the sword stuck in the soul
		proxy:SetDrawEnable( 1976 , false );
		proxy:SetColiEnable( 1976 , false );
		
		--SFX OFF
		proxy:InvalidSfx( 2360 , false );--vÎÌI[ --EN:--Keystone Aura
		proxy:InvalidSfx( 2361 , false );--õÌ±q --EN:--Particles of light
		
		--@ÇLø» --EN:--Enable magic wall
		proxy:SetColiEnable( 1998 , true );
		proxy:SetColiEnable( 1994 , true );
		
		proxy:SetDrawEnable( 1998 , true );
		proxy:SetDrawEnable( 1994 , true );
		
		--SFX ON
		proxy:ValidSfx( 1986 );
		proxy:ValidSfx( 1990 );
	end	

-----------------------------------------------------------------------------------------
--M~bNÖA --EN:--Gimmick related
-----------------------------------------------------------------------------------------	
--¡512¡µË´A¡PCªOBJ(1200)ÉÎµÄ½px(30)ApxItZbg(180)A£(150)ÅANV{^ð·-- --EN:--¡ 512 ¡ Drawbridge A ¡ PC presses the action button with reaction angle (30), angle offset (180), distance (150) against OBJ (1200) --
	if proxy:IsCompleteEvent( 512 ) ==false then
		proxy:OnDistanceActionPlus( 512, 10000, 1200, "OnEvent_512", DrawBridgeDist_A, HELPID_START, 180, DrawBridgeAngle_A, -1.3, -1.5, 1.3, once);
	else
		proxy:EndAnimation( 1200, 1 );
	end

--¡580¡åiNWÇÒ@¡ --EN:-- ¡ 580 ¡ Large slug wall waiting ¡
	if proxy:IsCompleteEvent( 580 ) == false then
		proxy:OnRegionJustIn( 580 , 10000 , 2340 , "OnEvent_580" , once );--ÌæüÁ½Æ« --EN:--When entering the area
		proxy:OnSimpleDamage( 580 , 421 , 10000 , "OnEvent_580" , once );--Uó¯½Æ« --EN:--When attacked
		proxy:OnSimpleDamage( 580 , 422 , 10000 , "OnEvent_580" , once );--Uó¯½Æ« --EN:--When attacked
		proxy:OnSimpleDamage( 580 , 423 , 10000 , "OnEvent_580" , once );--Uó¯½Æ«		 --EN:--When attacked
	end
	

--¡581¡åiNWÇÒ@¡ --EN:-- ¡ 581 ¡ Large slug wall standby ¡
	if proxy:IsCompleteEvent( 581 ) == false then
		proxy:OnRegionJustIn( 581 , 10000 , 2341 , "OnEvent_581" , once );--ÌæüÁ½Æ« --EN:--When entering the area
		proxy:OnSimpleDamage( 581 , 424 , 10000 , "OnEvent_581" , once );--Uó¯½Æ« --EN:--When attacked
		proxy:OnSimpleDamage( 581 , 425 , 10000 , "OnEvent_581" , once );--Uó¯½Æ« --EN:--When attacked
		proxy:OnSimpleDamage( 581 , 426 , 10000 , "OnEvent_581" , once );--Uó¯½Æ« --EN:--When attacked
	end
	
--¡??¡pjf[Ìoê¡nho^ --EN:--¡??¡Appearance of wandering daemon¡Handler registration
	proxy:NotNetMessage_begin();
		--vC[ª\ÅSµ½ÉLbN³êÜ·B --EN:--Kicked when a player dies solo.
		proxy:LuaCall( 4000, 100, "PlayerDeath_m05_01_00_00", everytime );
		--vC[ªµ½ÉLbN³êÜ·B --EN:--Kicked when the player is revived.
		proxy:LuaCall( 4032, 100, "PlayerRevive_m05_01_00_00", everytime );
	proxy:NotNetMessage_end();

	--¡åiNWÇÒ@p --EN:-- Large slug wall standby
	if proxy:IsCompleteEvent( 580 ) == false then
		proxy:SetDisableGravity( 421, true  );--dÍOFF --EN:--Gravity off
		proxy:EnableLogic      ( 421, false );--vlOFF --EN:--Thinking OFF
		
		proxy:SetDisableGravity( 422, true  );--dÍOFF --EN:--Gravity off
		proxy:EnableLogic      ( 422, false );--vlOFF --EN:--Thinking OFF
		
		proxy:SetDisableGravity( 423, true  );--dÍOFF --EN:--Gravity off
		proxy:EnableLogic      ( 423, false );--vlOFF --EN:--Thinking OFF
	end

	
	--¡åiNWÇÒ@p2 --EN:-- Large slug wall standby 2
	if proxy:IsCompleteEvent( 581 ) == false then
		proxy:SetDisableGravity( 424, true  );--dÍOFF --EN:--Gravity off
		proxy:EnableLogic      ( 424, false );--vlOFF --EN:--Thinking OFF
		
		proxy:SetDisableGravity( 425, true  );--dÍOFF --EN:--Gravity off
		proxy:EnableLogic      ( 425, false );--vlOFF --EN:--Thinking OFF
		
		proxy:SetDisableGravity( 426, true  );--dÍOFF --EN:--Gravity off
		proxy:EnableLogic      ( 426, false );--vlOFF --EN:--Thinking OFF
	end
	


	--¡630`659¡(L)iNWWFl[g¡ --EN:--¡630`659¡(Yes)Slug Generate¡
	GenerateRegist(proxy, 630, 100, 29,  5, "NamekuziGen" );
	
	--¡670`689¡(L)slWFl[g¡ --EN:-- ¡ 670 ~ 689 ¡ (Yes) Corrupt Generation ¡
	GenerateRegist(proxy, 670, 140, 19,  6, "HuhaibitoGen" );
	
	--¡699¡NQWFl[gpzM¡ --EN:-- ¡ 699 ¡ Distribution for jellyfish generation ¡
	SingleReset( proxy,699 );
	proxy:CustomLuaCall( 699 , "GenPoint" , everytime );
	
	--¡700`709¡(L)NQWFl[gA¡ --EN:--¡700`709¡(Yes) Jellyfish Generate A¡
	GenerateRegistKURAGE(proxy, 700, 170, 22, 13, "KurageGenA");
	
	--¡710`719¡(L)NQWFl[gB¡ --EN:--¡710`719¡(Yes) Jellyfish Generate B¡
	GenerateRegistKURAGE(proxy, 710, 200, 18,  9, "KurageGenB");
	
	--¡720`729¡(L)NQWFl[gC¡ --EN:--¡720`729¡(Yes) Jellyfish Generate C¡
	GenerateRegistKURAGE(proxy, 720, 220, 24, 15, "KurageGenC");
	
	--¡730`739¡(L)NQWFl[gD¡ --EN:--¡730`739¡(Yes) Jellyfish Generate D¡
	GenerateRegistKURAGE(proxy, 730, 250, 18,  9, "KurageGenD");
	
	--¡NQWFl[^ÌÌæàÌvCL³»èp --EN:--¡ For judging the presence or absence of players in the area of the jellyfish generator
	proxy:OnNetRegion( 790, 2310 );
	proxy:OnNetRegion( 791, 2311 );
	proxy:OnNetRegion( 792, 2312 );
	proxy:OnNetRegion( 793, 2313 );
	proxy:OnNetRegion( 794, 2314 );
	proxy:OnNetRegion( 795, 2315 );
	proxy:OnNetRegion( 796, 2316 );
	proxy:OnNetRegion( 797, 2317 );
	proxy:OnNetRegion( 798, 2318 );
	proxy:OnNetRegion( 799, 2319 );
	
	proxy:InvalidSfx( 2222, false );
	--¡515¡iNWRj[¡ --EN:--¡515¡slug colony¡
	if proxy:IsCompleteEvent( 515 ) == false then
		proxy:OnRegistFunc(515,"Check_515","OnEvent_515",1,everytime);
		
		proxy:SetColiEnable( 1260, false );
		proxy:SetDrawEnable( 1260, false );
		for index = 1, 15, 1 do
			InvalidCharactor( proxy, 700 + index - 1);
		end
	else
		proxy:SetColiEnable( 1250, false );
		proxy:SetDrawEnable( 1250, false );
		
		--¡517¡[Cg\[h¡ --EN:-- ¡ 517 ¡ Moonlight Sword ¡
		if proxy:IsCompleteEvent( 517 ) == false then
			--zXgA¶¶AOCÌÝ²×é±ÆªÅ«é --EN:--Only hosts, survivors, and grays can be examined
			local possible_chr_type = ATTR_HOST + ATTR_LIVE + ATTR_GREY;
			
			proxy:OnDistanceActionAttribute( 517 , 10000 , 1260 , "OnEvent_517_0" , ItemBoxDist_A , 10010140 , 0 , ItemBoxAngle_A ,possible_chr_type, everytime ); 
			proxy:LuaCall( 517,1,"OnEvent_517_2",once);
			proxy:LuaCall( 517,2,"OnEvent_517_4",once);
			proxy:TreasureDispModeChange2( 1260, true ,KEN_SFX);
		else
			proxy:SetDrawEnable( 1260 , false );--ÐÆÜ¸`æ¾¯OFF --EN:--Only drawing is turned off for the time being
			proxy:SetColiEnable( 1260 , false );
		end
	end	
	--proxy:SetRarity( 1260, 10430 );
	
	--¡520¡ÅÀ¡ --EN:--¡520¡Poison Swamp¡
	--zXgªÀÉüÁÄ¢éóÔÅ¢«³êéÆA --EN:--When summoned while the host is in the swamp,
	--tOªOnÌ×ÇÁÅ«È¢êª éÌÅtOðºë·B --EN:-- Since the flag is On, it may not be possible to add it, so remove the flag.
	proxy:SetEventFlag( 520, false );
	proxy:NotNetMessage_begin();
		proxy:OnRegistFunc( 520, "PoizonFloorDam", "dummy", 2, everytime );
	proxy:NotNetMessage_end();
	
	
	
--[[
	--¡pjf[p (tOÍ¼Awèª êÎÏ¦é) --EN:--¡For wandering daemon (flag is tentative, change if specified)
	if proxy:IsCompleteEvent( 20 ) == true then
		LuaFunc_VisibleTheWanderingDemon  (proxy, param, demon_id_list_m05_01_00_00);
	else
		LuaFunc_InvisibleTheWanderingDemon(proxy, param, demon_id_list_m05_01_00_00);
	end
]]
		
	--¡535¡õÌÇ¡ --EN:-- ¡ 535 ¡ Wall of Light ¡
	if proxy:IsCompleteEvent( 535 ) == false then
		proxy:OnDistanceActionAttribute( 535, 10000, 1300, "OnEvent_535", 1.5, 10010403, 180.0, 90.0, ATTR_HOST + ATTR_LIVE + ATTR_GREY, everytime );
		proxy:LuaCall( 535, 2, "OnEvent_535_delete", once );
	else
		proxy:SetDrawEnable( 1300, false );
		proxy:SetColiEnable( 1300, false );
		proxy:InvalidSfx( 2200, false );
	end
	
	--¡536¡õÌÇ¡ --EN:-- ¡ 536 ¡ Wall of Light ¡
	if proxy:IsCompleteEvent( 536 ) == false then
		proxy:OnDistanceActionAttribute( 536, 10000, 1301, "OnEvent_536", 1.5, 10010403, 180.0, 90.0, ATTR_HOST + ATTR_LIVE + ATTR_GREY, everytime );
		proxy:LuaCall( 536, 2, "OnEvent_536_delete", once );
	else
		proxy:SetDrawEnable( 1301, false );
		proxy:SetColiEnable( 1301, false );
		proxy:InvalidSfx( 2201, false );
	end
	
--¡538¡{XíJÎ¡ --EN:-- ¡ 538 ¡ Boss battle camera support ¡
	--{Xª¶«Ä¢éÈço^ --EN:--Register if the boss is alive
	if proxy:IsCompleteEvent(5770) == false then
		proxy:NotNetMessage_begin();
			proxy:OnRegionIn( 538 , 10000 , 2886 ,"OnEvent_538" , everytime );
		proxy:NotNetMessage_end();
	end

--FèslÌ_~[ --EN:--prayer rot man dummy
--[[
	proxy:OnPlayerDistanceInTarget( 820, 10000, 140, "testINORI", 5.0, once );
	proxy:OnPlayerDistanceInTarget( 821, 10000, 141, "testINORI", 5.0, once );
	proxy:OnPlayerDistanceInTarget( 822, 10000, 142, "testINORI", 5.0, once );
	proxy:OnPlayerDistanceInTarget( 823, 10000, 143, "testINORI", 5.0, once );
	proxy:OnPlayerDistanceInTarget( 824, 10000, 144, "testINORI", 5.0, once );
	proxy:OnPlayerDistanceInTarget( 825, 10000, 145, "testINORI", 5.0, once );
]]

--¡536¡sòÖ½tOð§Äé¡ --EN:-- ¡ 536 ¡ Raise a flag that came to unclean ¡
	proxy:SetEventFlag( 8087, true );

-----------------------------------------------------------------------------------------
--NPCÖA --EN:--NPC related
-----------------------------------------------------------------------------------------
--------------------------------¤¤¤QWCCxgÖA¤¤¤-------------------------------- --EN:--¤¤¤QWC event related ¤¤¤--------------------------------
--¡827¡QWCzÎÌ¸ìo»¡ --EN:-- ¡ 827 ¡ Spirit of QWC ore appears ¡
	if proxy:IsCompleteEvent(828) == true or	--Ü¾zÎÌ¸ìªSµÄÈ¢@© --EN:--Has the spirit of the ore died yet?
	   proxy:IsSuccessQWC(50110) == false then	--QWCª¬§µÄ¢È¯êÎ --EN:--If QWC is not established
		print("QWCzÎÌ¸ì@¢¬§"); --EN:print("QWC Ore Spirit Incomplete");
		--zÎÌ¸ìð³ø» --EN:--Nullify Ore Spirit
		InvalidBackRead(proxy, 434);
		
		proxy:SetEventFlag(827, true);
	else
		print("QWCzÎÌ¸ì@¬§"); --EN:print("QWC ore spirit established");
	end

--¡828¡QWCzÎÌ¸ìSÄ¡ --EN:--¡828¡QWC Ore Spirit Death Watch¡
	if proxy:IsCompleteEvent(828) == false then	--Ü¾zÎÌ¸ìªSµÄÈ¢Èç --EN:--If the ore spirit hasn't died yet
	   --zÎÌ¸ìÌSÄÇÁ --EN:-- Added death watch for Ore Spirit
		proxy:OnCharacterDead( 828, 434, "OnEvent_828", once );
		if proxy:IsClient() == false and proxy:IsCompleteEvent(8020) == false then
			proxy:NotNetMessage_begin();
				proxy:AddCorpseEvent( 8020 , 434 );
				proxy:LuaCall( 8020 , 0 , "OnEvent_8020",once);
			proxy:NotNetMessage_end();
		end
	end
	
--¡800¡QWCZo»¡ --EN:-- ¡ 800 ¡ QWC selenium appearance ¡
	if proxy:IsSuccessQWC(50130) == false then	--QWCª¬§µÄ¢È¯êÎ --EN:--If QWC is not established
		print("QWCZ@¢¬§"); --EN:print("QWC selenium unestablished");
		--Zð³ø» --EN:--disable selenium
		InvalidBackRead(proxy, 652);		
		proxy:SetEventFlag(800, true);
	else
		print("QWCZ@¬§"); --EN:print("QWC selenium established");
	end

--¡15600¡ZÌÌð²×½¡ --EN:--¡ 15600 ¡ Examine Selenium's corpse ¡
	if proxy:IsCompleteEvent( 15600 ) == false then
		proxy:AddCorpseEvent( 15600 , 435 );
		proxy:NotNetMessage_begin();
			proxy:LuaCall( 15600 ,0 , "OnEvent_15600",once );
 		proxy:NotNetMessage_end();
	end

--¡820¡QWCZEubNS[XgSÄ¡ --EN:--¡820¡QWC Selenium Black Ghost Death Watch¡
	if proxy:IsCompleteEvent(820) == false then	--Ü¾ZªSµÄÈ¢Èç --EN:--If Selene hasn't died yet
	   --ZEbNS[XgÌSÄÇÁ --EN:--Added death watch for Selene Luckghost
		proxy:OnCharacterDead( 820, 435, "OnEvent_820", once );
	end
--¡821¡QWCZEubNS[Xgo»¡ --EN:--¡821¡QWC Selenium Black Ghost Appears¡
	if proxy:IsCompleteEvent(820) == true or	--Ü¾ZEubNS[XgªSµÄÈ¢@©  --EN:--Has Selene Black Ghost died yet?
	   proxy:IsSuccessQWC(50120) == false then	--QWCª¬§µÄ¢È¯êÎ --EN:--If QWC is not established
	   
	   if 	proxy:IsCompleteEvent( 820 ) == true and
			proxy:IsCompleteEvent( 15600 ) == false then
			--ÌðÄ»·é --EN:--reproduce the corpse
			proxy:OpeningDeadPlus( 435 , true ,false ,false );
		else
			print("QWCZEubNS[Xg@¢¬§"); --EN:print("QWC Selenium Black Ghost Unestablished");
			--Zð³ø» --EN:--disable selenium
			InvalidBackRead(proxy, 435);			
		end
		--proxy:SetEventFlag(821, true);
	else
		print("QWCZEubNS[Xg@¬§"); --EN:print("QWC Selenium Black Ghost established");
	end

--yZz --EN:--yseleniumz
	SetFirstNpcStateFlag(proxy, param, selen_flag_list, SELEN_STATE_SEARCH_BROTHER);
	if proxy:IsClient() == false then
		proxy:RequestForceUpdateNetwork( 652);		
	end
	
--¡15633¡ZÌÌð²×½¡ --EN:--¡ 15633 ¡ Examined Selenium's corpse ¡
	if proxy:IsCompleteEvent( 15633 ) == false then
		proxy:AddCorpseEvent( 15633 , 652 );
		proxy:NotNetMessage_begin();
			proxy:LuaCall( 15633 ,0 , "OnEvent_15633",once );
 		proxy:NotNetMessage_end();
	end
	
	if	proxy:IsCompleteEvent( SELEN_STATE_DEAD )	== false and
		proxy:IsCompleteEvent( SELEN_STATE_ANGRY )	== false then
		if	proxy:IsCompleteEvent( SELEN_STATE_ANGRY ) == false then
			proxy:OnCharacterTotalDamage( 803, 652, 10000, TOTALDAMAGE_SELEN, "OnEvent_803", once );
		end
		--S[häÍí --EN:--Gold Run Crest Removed
		proxy:LuaCall( 801, 0, "OnEvent_801",once );
		--MÂª¢ñV --EN:--Faith High Reward
		proxy:NotNetMessage_begin();
			proxy:LuaCall( 808, 0, "OnEvent_808",once );
		proxy:NotNetMessage_end();
		--MÂªá¢ñV --EN:--Rewards with low faith
		proxy:NotNetMessage_begin();
			proxy:LuaCall( 809, 0, "OnEvent_809",once );
		proxy:NotNetMessage_end();		
	end
	--SÄÇÁ --EN:--Add death watch
	if proxy:IsCompleteEvent( 804 ) == false then
		proxy:OnCharacterDead( 804, 652, "OnEvent_804", once );
	end

	if proxy:IsCompleteEvent( SELEN_STATE_ANGRY )	== true then --GÎµÄ¢éÈçÎ --EN:--if hostile
			proxy:EnableLogic( 652, true );
			proxy:SetTeamType( 652, TEAM_TYPE_AngryFriend );
			--SetNpcStateFlag( proxy, param, selen_flag_list, SELEN_STATE_ANGRY );
	end
	
	if	proxy:IsClient() == false then 
		if	proxy:IsCompleteEvent( SELEN_STATE_THANKS ) == true then
			if proxy:IsRegionIn(10000,2240) == true then
				proxy:NotNetMessage_begin();
					proxy:OnRegionJustOut( 802, LOCAL_PLAYER, 2240, "OnEvent_802", once );
				proxy:NotNetMessage_end();
				print("Ü¾ZÉß¢É¢é"); --EN:print("still close to selenium");
			else
				SetNpcStateFlag( proxy, param, selen_flag_list, SELEN_STATE_PURIFY );
				print("à¤ZÆ£êÄ¢é") --EN:print("I'm already away from Selenium")
			end
		end
	end
	
	--¬§µÄ¢½ç³ø» --EN:--Invalidate if you have attained Buddhahood
	if	proxy:IsCompleteEvent( SELEN_STATE_PURIFY ) == true or
		proxy:IsCompleteEvent( SELEN_STATE_DEAD ) == true then		
		if 	proxy:IsCompleteEvent( 804 ) == true and		--ZªñÅ¢é --EN:-- Selenium is dead
			proxy:IsCompleteEvent( 15633 ) == false then	--óðæÁÄ¢È¢ --EN:--Didn't get the treasure
			--óÌðÄ» --EN:--Reproduce treasure corpse
			proxy:OpeningDeadPlus( 652 , true ,false ,false );			
		else
			InvalidBackRead( proxy, 652 );
		end
	end

--¡822¡QWC\EX^[¡ --EN:--¡822¡QWC Soul Monster¡
	if proxy:IsSuccessQWC(50100) == false then--¬§µÄ¢È¢ÈçÎ --EN:--If not established
		print("ubNS[Xg³ø»"); --EN:print("Disable Black Ghost");
		--431ð³ø» --EN:disable --431
		InvalidBackRead(proxy, 436);
		--432ð³ø» --EN:disable --432
		InvalidBackRead(proxy, 437);
		--433ð³ø» --EN:disable --433
		InvalidBackRead(proxy, 438);
		
		proxy:SetEventFlag(822, true);
	end
--------------------------------¢¢¢QWCCxgÖA¢¢¢-------------------------------- --EN:--¢¢¢QWC event related¢¢¢--------------------------------
	
--¡842¡÷«èubNSÄ¡ --EN:-- ¡ 842 ¡ meat cut black death watch ¡
	if proxy:IsCompleteEvent( 842 ) == false then
		proxy:OnCharacterDead( 842 , 470,"OnEvent_842",once);
	else
		--³ø» --EN:--Invalidation
		InvalidCharactor(proxy,470 );
	end
	
--¡15500¡üACeæ¾Ä¡nhÍO[oÉè` --EN:-- ¡ 15500 ¡ Intrusion item acquisition monitoring ¡ Handlers are defined globally
	if proxy:IsCompleteEvent( 15500 ) == false then
--~ 		proxy:AddCorpseEvent( 15500 , 435 );--PRmEubN --EN:--Princess Knight Black
		proxy:AddCorpseEvent( 15500 , 470 );--ÊíEubN --EN:--Normal/Black
	end

--¡770¡iNWSÄ¡ --EN:-- ¡ 770 ¡ Slug Death Watch ¡
	if proxy:IsCompleteEvent( 770 ) == false then
		proxy:OnCharacterDead( 770 , 440 , "OnEvent_770",once );
	end
--¡15626¡iNWÌ²×½©H¡ --EN:--¡15626¡Did you check the slug corpse? ¡
	if proxy:IsCompleteEvent( 15626 ) == false then
		proxy:AddCorpseEvent( 15626 , 440 );
		proxy:NotNetMessage_begin();
			proxy:LuaCall( 15626 ,0 , "OnEvent_15626",once );
 		proxy:NotNetMessage_end();
	end
	
--¡771¡iNWÌSÄ»¡ --EN:-- ¡ 771 ¡ slug death reproduction ¡
	if proxy:IsCompleteEvent( 770 ) == true then
		if proxy:IsCompleteEvent( 15626 ) == false then
			--ÌðÄ»·é --EN:--reproduce the corpse
			proxy:OpeningDeadPlus( 440 , true ,false ,false );
		else
			--³ø» --EN:--Invalidation
			InvalidCharactor( proxy, 440 );
		end
	end

--¡775¡ôptSÄ¡ --EN:-- ¡ 775 ¡ Witch Death Watch ¡
	if proxy:IsCompleteEvent( 775 ) == false then
		proxy:OnCharacterDead( 775 , 439 , "OnEvent_775",once );
	end
	
--¡15623¡ôptÌÌð²×½©H¡ --EN:--¡15623¡Have you examined the body of the sorceress? ¡
	if proxy:IsCompleteEvent( 15623 ) == false then
		proxy:AddCorpseEvent( 15623 , 439 );
		proxy:NotNetMessage_begin();
			proxy:LuaCall( 15623 , 0 ,"OnEvent_15623",once);
		proxy:NotNetMessage_end();
	end
	
--¡776¡ôptÌSÄ»¡ --EN:-- ¡ 776 ¡ Magician's death reproduction ¡
	if proxy:IsCompleteEvent( 775 ) == true then
		if proxy:IsCompleteEvent( 15623 ) == false then
			--ÌðÄ»·é --EN:--reproduce the corpse
			proxy:OpeningDeadPlus( 439 , true ,false ,false );
		else
			InvalidCharactor( proxy,439 );
		end
	end


	--¡999999¡t[xêÌú»Cxgð­s¡ --EN:-- ¡ 999999 ¡ Generate a frame delay initialization processing event ¡
	proxy:NotNetMessage_begin();
		--¥0bã¥-- --EN:--¥After 0 seconds¥--
		proxy:OnKeyTime2( 999992, "Second_Initialize_m05_01_00_00", 0.2, 0, 0, once );	
	proxy:NotNetMessage_end();	
	
	proxy:OnKeyTime2( 999993, "Third_Initialize_m05_01_00_00", 1.0, 1, 2, once );
	
	print("Initialize_m05_01_00_00 end");
end

--------------------------------------------------------------------------------------
--Initialize©çÄÎêéA1t[xêÌú»¡999999 --EN:--Initialization with a delay of 1 frame, called from Initialize ¡999999
--------------------------------------------------------------------------------------
--¡999999¡êAInitÅÍÅ«È¢ÌÅAcµÄ¨­ --EN:-- ¡ 999999 ¡ Some parts cannot be processed by Init, so leave them
function Second_Initialize_m05_01_00_00(proxy, param)
	print("Second_Initialize_m05_01_00_00 begin");
--------------------------------¤¤¤QWCCxgÖA¤¤¤-------------------------------- --EN:--¤¤¤QWC event related ¤¤¤--------------------------------
--------------------------------¢¢¢QWCCxgÖA¢¢¢-------------------------------- --EN:--¢¢¢QWC event related¢¢¢--------------------------------

	proxy:NotNetMessage_begin();
		--¡840¡å¢SFX\¦ÌæÉüÁ½¡ --EN:-- 840 Entered the fly SFX display area
		proxy:OnRegionJustIn( 840 , 10000 , 2260, "OnEvent_840",everytime);
		--¡841¡å¢SFX\¦Ìæ©ço½¡ --EN:--¡841¡Fly out of the SFX display area¡
		proxy:OnRegionJustOut( 841 , 10000 , 2260, "OnEvent_841",everytime);
	proxy:NotNetMessage_end();
	print("Second_Initialize_m05_01_00_00 end");
end


function Third_Initialize_m05_01_00_00(proxy,param)
--FèslÌ_~[ --EN:--prayer rot man dummy
--[[
	proxy:SetEventCommand( 140, 200 );
	proxy:SetEventCommand( 141, 200 );
	proxy:SetEventCommand( 142, 200 );
	proxy:SetEventCommand( 143, 200 );
	proxy:SetEventCommand( 144, 200 );
	proxy:SetEventCommand( 145, 200 );
]]
end

function testINORI(proxy,param)
--FèslÌ_~[ --EN:--prayer rot man dummy
--[[
	proxy:SetEventCommand( param:GetParam2(), 201 );
]]
end

--------------------------------------------------------------------------------------
--µË´A¡512 --EN:-- Drawbridge A 512
--------------------------------------------------------------------------------------
--¡512¡µË´¡ --EN:-- ¡ 512 ¡ Drawbridge ¡
function OnEvent_512(proxy, param)
	print("OnEvent_512 begin");
	
	if proxy:IsCompleteEvent(512) == true then
		print("ID 512 IsCompleteEvent true"); 
		print("OnEvent_512 end");
		return;
	end
	
	proxy:PlayAnimation(1200,1);--µË´Ìì®Aj[V --EN:-- Drawbridge activation animation
	proxy:SetEventFlag( 512, 1 );--µË´Íì®ÏÝ --EN:-- drawbridge activated
	
	--vC[Ì¯úAj[V(true:p[eB[vC[ªAj[Vµ½) --EN:--Player synchronous animation (true: party player animated)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_KICK ) == true then
		print("OnEvent_512 end");
		return;
	end
	
	proxy:WarpDmy( 10000 , 1200 , 191 ); 
	
	print("OnEvent_512 end");
end

--------------------------------------------------------------------------------------
--¡5774¡ÎÉ[v¡ --EN:-- ¡ 5774 ¡ Warp to the stone pillar ¡
--------------------------------------------------------------------------------------
function OnEvent_5774(proxy,param)	
	print("OnEvent_5774 begin");
	
	if proxy:IsCompleteEvent( 5774 ) == true then
		return;
	end
	
	proxy:RepeatMessage_begin();
		--¥_1¥Iðj[ÌÄ¥ --EN:--¥_1¥Select menu monitoring¥
		proxy:OnSelectMenu(5774, "OnEvent_5774_1", 10010710, 0, 2, 1981, 2, once);			
	proxy:RepeatMessage_end();
	
	print("OnEvent_5774 end");
end

--£5774_1£Iðj[ÌÄ£ --EN:--£5774_1£Monitor selection menu£
function OnEvent_5774_1(proxy,param)	
	print("OnEvent_5774_1 begin");
	
	if proxy:IsSession() == false then
	
		proxy:PlayAnimation(10000,8283);
		proxy:NoAnimeTurnCharactor( 10000 , 1981 ,TURNSKIP_ANGLE);
		
		proxy:NotNetMessage_begin();
			proxy:OnChrAnimEnd( 5774 , 10000 , 8283 , "OnEvent_5774_2",once);
		proxy:NotNetMessage_end();
		
		proxy:SetEventFlag(5774,true);
	else
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010720, 0, 6, 1983, GEN_DIALOG_DIST, once );
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
	end
	
	print("OnEvent_5774_1 end");
end

--£5774_2£Iðj[ÌÄ£ --EN:--£5774_2£Monitor selection menu£
function OnEvent_5774_2(proxy,param)	
	print("OnEvent_5774_2 begin");
	
	proxy:SetEventFlag(5774,false);
			
	proxy:PlayAnimation(10000,8284);
	
	proxy:SetEventFlag(5774,true);
	
	OnEvent_5774_3(proxy, param);
	
	print("OnEvent_5774_2 end");
end

--¡5774_3¡ÎÉ[v¡ --EN:--¡ 5774_3 ¡ Warp to the stone pillar ¡
function OnEvent_5774_3(proxy,param)	
	print("OnEvent_5774_3 begin");
	
	--ÎÖßÁÄ«½»èÌtOð§Äé --EN:--Flag the judgment of returning to the stone pillar
	proxy:SetEventFlag(8083, true);
	
	proxy:SetEventFlag(5774,false);
	--®Sñv --EN:-- full recovery request
	proxy:RequestFullRecover();
	--ÃÔvÎÉßé --EN:--Return to Old Fort Keystone
	proxy:WarpNextStage( 1, 0, 0, 0, 1009);	
	print("OnEvent_5774_3 end");
end

--------------------------------------------------------------------------------------
--¡580¡åiNWÇÒ@¡ --EN:-- ¡ 580 ¡ Large slug wall waiting ¡
--------------------------------------------------------------------------------------
--¡580¡åiNWÇÒ@¡ --EN:-- ¡ 580 ¡ Large slug wall waiting ¡
function OnEvent_580(proxy,param)	
	print("OnEvent_580 begin");
	
	proxy:SetDisableGravity( 421 , false ); --dÍON --EN:--Gravity ON
	proxy:EnableLogic( 421 , true ); --WbNON --EN:--Logic ON
	proxy:SetSpStayAndDamageAnimId( 421, -1, -1 );--ÁêÒ@AjÌ³ø» --EN:--Disable special standby animation
	
	proxy:SetDisableGravity( 422 , false ); --dÍON --EN:--Gravity ON
	proxy:EnableLogic( 422 , true ); --WbNON --EN:--Logic ON
	proxy:SetSpStayAndDamageAnimId( 422, -1, -1 );--ÁêÒ@AjÌ³ø» --EN:--Disable special standby animation
	
	proxy:SetDisableGravity( 423 , false ); --dÍON --EN:--Gravity ON
	proxy:EnableLogic( 423 , true ); --WbNON --EN:--Logic ON
	proxy:SetSpStayAndDamageAnimId( 423, -1, -1 );--ÁêÒ@AjÌ³ø» --EN:--Disable special standby animation
	
	proxy:SetEventFlag( 580 , true );
	proxy:DeleteEvent( 580 );--Äª2íÞ éÌÅÐû­®µ½çÁ· --EN:--There are two types of monitoring, so if one is activated, turn it off
	
	print("OnEvent_580 end");
end



--------------------------------------------------------------------------------------
--¡581¡åiNWÇÒ@¡ --EN:-- ¡ 581 ¡ Large slug wall standby ¡
--------------------------------------------------------------------------------------
--¡581¡åiNWÇÒ@¡ --EN:-- ¡ 581 ¡ Large slug wall standby ¡
function OnEvent_581(proxy,param)	
	print("OnEvent_581 begin");

	proxy:SetDisableGravity( 424 , false ); --dÍON --EN:--Gravity ON
	proxy:EnableLogic( 424 , true ); --WbNON --EN:--Logic ON
	proxy:SetSpStayAndDamageAnimId( 424, -1, -1 );--ÁêÒ@AjÌ³ø» --EN:--Disable special standby animation
	
	proxy:SetDisableGravity( 425 , false ); --dÍON --EN:--Gravity ON
	proxy:EnableLogic( 425 , true ); --WbNON --EN:--Logic ON
	proxy:SetSpStayAndDamageAnimId( 425, -1, -1 );--ÁêÒ@AjÌ³ø» --EN:--Disable special standby animation
	
	proxy:SetDisableGravity( 426 , false ); --dÍON --EN:--Gravity ON
	proxy:EnableLogic( 426 , true ); --WbNON --EN:--Logic ON
	proxy:SetSpStayAndDamageAnimId( 426, -1, -1 );--ÁêÒ@AjÌ³ø» --EN:--Disable special standby animation
	
	proxy:SetEventFlag( 581 , true );
	proxy:DeleteEvent( 581 );--Äª2íÞ éÌÅÐû­®µ½çÁ· --EN:--There are two types of monitoring, so if one is activated, turn it off
	
	print("OnEvent_581 end");
end




--------------------------------------------------------------------------------------
--¡630`659¡(L)iNWWFl[g¡ --EN:--¡630`659¡(Yes)Slug Generate¡
--------------------------------------------------------------------------------------
--¡630`659¡(L)iNWWFl[g¡ --EN:--¡630`659¡(Yes)Slug Generate¡
function NamekuziGen(proxy,param)
	print("NamekuziGen begin");
	
	if proxy:IsCompleteEvent( 515 ) == true then
		--Rj[ª³¢ÌÅ­¶Å«È¢B --EN:--There is no colony, so it cannot occur.
		return;
	end
	
	local count = 0;
	proxy:SetEventFlag( param:GetParam1(), true );
	for index = 0, 29, 1 do
		local ACID 		= 630 + index;
		local targetId 	= 100 + index;
		if proxy:IsCompleteEvent( ACID ) == false then
			count = count + 1;
			--¢¬§ÌJEgª5ÈãÌÍAÜ¾o»µÄ¢È¢iNWÉÈéÌÅËo --EN:--When the unestablished count is 5 or more, it becomes a slug that has not yet appeared, so it is ejected
			if count >= 5 then
				local region_list = {2302, 2305, 2306};
				local warp_point = GetWarpPoint(proxy, region_list, index );
				
				proxy:Warp(targetId, warp_point);
				proxy:RepeatMessage_begin();
					proxy:OnCharacterDead( ACID, targetId, "NamekuziGen", once );
				proxy:RepeatMessage_end();
				ValidCharactor( proxy, targetId );
				
				proxy:SetDisableGravity( targetId, false );	--dÍON --EN:--Gravity ON
				proxy:DisableMapHit( targetId, true );		--}bv½èOFF --EN:--OFF per map
				proxy:SetDeadMode(targetId, true);			--³GON --EN:--Invincibility ON
				
				proxy:NotNetMessage_begin();
					--1bãÉtargetIdÌL½èðON --EN:--Turn on the targetId character hit after 1 second
					--proxy:OnKeyTime2( ACID, "TimerCollisionOn", 1.0, 0, targetId, once );

					--iNWªºµàeÉ --EN:--A slug dropped into the content
					proxy:OnRegionJustIn( ACID, targetId, 2221, "NamekuziGen_1", once );
				proxy:NotNetMessage_begin();
				
				return;
			end
		end
	end
	print("NamekuziGen end");
end

function NamekuziGen_1(proxy,param)
	print("NamekuziGen_1 begin");
	proxy:NotNetMessage_begin();
		proxy:DisableMapHit( param:GetParam2(), false );
		--2bãÉtargetIdÌ³GðOFF --EN:-- Turn off invincibility of targetId after 2 seconds
		proxy:OnKeyTime2( param:GetParam1(), "TimerMutekiOff", 1.0, 0, param:GetParam2()+2000, once );
	proxy:NotNetMessage_end();
	print("NamekuziGen_1 end");
end


--------------------------------------------------------------------------------------
--¡670`689¡(L)slWFl[g¡ --EN:-- ¡ 670 ~ 689 ¡ (Yes) Corrupt Generation ¡
--------------------------------------------------------------------------------------
--¡670`689¡(L)slWFl[g¡ --EN:-- ¡ 670 ~ 689 ¡ (Yes) Corrupt Generation ¡
function HuhaibitoGen(proxy,param)
	print("HuhaibitoGen begin");
	local count = 0;
	proxy:SetEventFlag( param:GetParam1(), true );
	for index = 0, 19, 1 do
		local ACID 		= 670 + index;
		local targetId 	= 140 + index;
		if proxy:IsCompleteEvent( ACID ) == false then
			count = count + 1;
			--¢¬§ÌJEgª4ÈãÌÍAÜ¾o»µÄ¢È¢slÉÈéÌÅËo --EN:--When the unestablished count is 4 or more, it becomes a corrupt person who has not yet appeared, so it is injected
			if count >= 4 then
				--print("HuhaibitoGen index = ",index, ", count = ", count, ", Dead = ", param:GetParam2(), ", nextTarget = ", targetId );
				if index <= 5 then
					--print("index check return end");
					return;
				end
				local region_list = {2301};
				local warp_point = GetWarpPoint(proxy, region_list, index );
				
				proxy:Warp(targetId, warp_point);
				proxy:OnCharacterDead( ACID, targetId, "HuhaibitoGen", once );
				ValidCharactor( proxy, targetId );
				proxy:SetDisableGravity( targetId, false );	--dÍON --EN:--Gravity ON
				return;
			end
		end
	end
	print("HuhaibitoGen end");
end


--------------------------------------------------------------------------------------
--¡700`709¡(L)NQWFl[gA¡ --EN:--¡700`709¡(Yes) Jellyfish Generate A¡
--------------------------------------------------------------------------------------
--¡700`709¡(L)NQWFl[gA¡ --EN:--¡700`709¡(Yes) Jellyfish Generate A¡
function KurageGenA(proxy,param)
	print("KurageGenA begin");
	
	proxy:SetEventFlag( param:GetParam1(), true );
	KurageLap( proxy, "KurageGenA", "WarpReSearchA_1", 22, 700, 170, 1, 13, 1 ,KURAGE_GEN_ALIST);
	print("KurageGenA end");
end

function WarpReSearchA_1(proxy,param)
	print("WarpReSearchA_1 begin");
	
	KurageLap( proxy, "KurageGenA", "WarpReSearchA_2", 22, 700, 170, 1, 13, 2 ,KURAGE_GEN_ALIST);
	print("WarpReSearchA_1 end");
end

function WarpReSearchA_2(proxy,param)
	print("WarpReSearchA_2 begin");
	
	KurageLap( proxy, "KurageGenA", "WarpReSearchA_1", 22, 700, 170, 1, 13, 1 ,KURAGE_GEN_ALIST)
	print("WarpReSearchA_2 end");
end




--------------------------------------------------------------------------------------
--¡710`719¡(L)NQWFl[gB¡ --EN:--¡710`719¡(Yes) Jellyfish Generate B¡
--------------------------------------------------------------------------------------
--¡710`719¡(L)NQWFl[gB¡ --EN:--¡710`719¡(Yes) Jellyfish Generate B¡
function KurageGenB(proxy,param)
	print("KurageGenB begin");
	
	proxy:SetEventFlag( param:GetParam1(), true );
	KurageLap( proxy, "KurageGenB", "WarpReSearchB_1", 18, 710, 200, 2, 9, 1 ,KURAGE_GEN_BLIST);
	print("KurageGenB end");
end
function WarpReSearchB_1(proxy,param)
	print("WarpReSearchB_1 begin");
	
	KurageLap( proxy, "KurageGenB", "WarpReSearchB_2", 18, 710, 200, 2, 9, 2 ,KURAGE_GEN_BLIST);
	print("WarpReSearchB_1 end");
end

function WarpReSearchB_2(proxy,param)
	print("WarpReSearchB_2 begin");
	
	KurageLap( proxy, "KurageGenB", "WarpReSearchB_1", 18, 710, 200, 2, 9, 1 ,KURAGE_GEN_BLIST)
	print("WarpReSearchB_2 end");
end



--------------------------------------------------------------------------------------
--¡720`729¡(L)NQWFl[gC¡ --EN:--¡720`729¡(Yes) Jellyfish Generate C¡
--------------------------------------------------------------------------------------
--¡720`729¡(L)NQWFl[gC¡ --EN:--¡720`729¡(Yes) Jellyfish Generate C¡
function KurageGenC(proxy,param)
	print("KurageGenC begin");
	
	KurageLap( proxy, "KurageGenC", "WarpReSearchC_1", 24, 720, 220, 3, 15, 1 ,KURAGE_GEN_CLIST);
	proxy:SetEventFlag( param:GetParam1(), true );
	print("KurageGenC end");
end
function WarpReSearchC_1(proxy,param)
	print("WarpReSearchC_1 begin");
	
	KurageLap( proxy, "KurageGenC", "WarpReSearchC_2", 24, 720, 220, 3, 15, 2 ,KURAGE_GEN_CLIST);
	print("WarpReSearchC_1 end");
end

function WarpReSearchC_2(proxy,param)
	print("WarpReSearchC_2 begin");
	
	KurageLap( proxy, "KurageGenC", "WarpReSearchC_1", 24, 720, 220, 3, 15, 1 ,KURAGE_GEN_CLIST)
	print("WarpReSearchC_2 end");
end


--------------------------------------------------------------------------------------
--¡730`739¡(L)NQWFl[gD¡ --EN:--¡730`739¡(Yes) Jellyfish Generate D¡
--------------------------------------------------------------------------------------
--¡730`739¡(L)NQWFl[gD¡ --EN:--¡730`739¡(Yes) Jellyfish Generate D¡
function KurageGenD(proxy,param)
	print("KurageGenD begin");
	
	KurageLap( proxy, "KurageGenD", "WarpReSearchD_1", 18, 730, 250, 4, 9, 1 ,KURAGE_GEN_DLIST);
	proxy:SetEventFlag( param:GetParam1(), true );
	print("KurageGenC end");
end
function WarpReSearchD_1(proxy,param)
	print("WarpReSearchD_1 begin");
	
	KurageLap( proxy, "KurageGenD", "WarpReSearchD_2", 18, 730, 250, 4, 9, 2 ,KURAGE_GEN_DLIST);
	print("WarpReSearchD_1 end");
end

function WarpReSearchD_2(proxy,param)
	print("WarpReSearchD_2 begin");
	
	KurageLap( proxy, "KurageGenD", "WarpReSearchD_1", 18, 730, 250, 4, 9, 1 ,KURAGE_GEN_DLIST)
	print("WarpReSearchD_2 end");
end



--[[
--¡NQWFl[^ÌÜÆßÖ¡KurageLap --EN:-- ¡ Jellyfish generator processing summary function ¡ KurageLap
	proxy					cCxgvLV --EN:proxy c event proxy
	func_ok					cJ¢Ä¢éXy[Xª¶ÝµÄ¢½ÉÇÁ·éSÄÌnh¼ --EN:func_ok c the death watch handler name to add when there is an open space
	func_ng					cJ¢Ä¢éXy[Xª¶Ýµ³©Á½ÉÇÁ·ébãÌnh¼ --EN:func_ng c Handler name after seconds to add when there is no open space
	max_index				cÅåÌ-1(úzuÌÌàÜß½SÌ-1) --EN:max_index c maximum number of bodies -1 (total number including the number of initial placements -1)
	ACID_start				cANVIDÌª --EN:ACID_start c start of action ID
	TCID_start				c^[QbgÌCxgIDÌª --EN:TCID_start c start of target event ID
	list_index				co^³êÄ¢é|CgÌ2³zñCfbNX --EN:list_index c 2D array index of registered points, etc.
	staticChrNum			cúzuÌ --EN:staticChrNum c Number of initial placement fields
	conditionParam			cbãÌJnÅwè·ép[^([v³¹éÌÉ¯¶nhªg¦È¢½ß) --EN:conditionParam c parameter to be specified at the start after seconds (because the same handler cannot be used to loop)
	checklist				co»|CgÉæqªÈ¢©Ì`FbNpXg --EN:checklist c A list for checking whether there is a previous customer at the appearance point
]]
function KurageLap( proxy, func_ok, func_ng, max_index, ACID_start, TCID_start, list_index, staticChrNum, conditionParam ,checklist)
	--print("KurageLap begin");
	local count = 0;
	for index = 0, max_index, 1 do
		local ACID 		= ACID_start + index;
		local targetId 	= TCID_start + index;
		if proxy:IsCompleteEvent( ACID ) == false then
			count = count + 1;
			
			if count >= staticChrNum then
				local warp_point = GetWarpPointCheck(proxy, index, list_index );
				
				--|Cgª©Â¯ê½©H --EN:--Did you find the point?
				if warp_point ~= -1 then
					--WFl[^[É®·éLª|CgÉé©H --EN:--Is there a character belonging to the generator at the point?
					local chrnum = table.getn( checklist );
					local chridx = 1;
					local isOut = false;--ùÉN©¢é --EN:--someone is already there
					for chridx=1 , chrnum , 1 do
						local chrId = checklist[chridx];
						if proxy:IsAlive( chrId ) == true and proxy:IsRegionIn( chrIdx , warp_point ) == true then
							isOut = true;							
						end
					end
					if isOut == false then
						if proxy:IsClient() == false then
							if proxy:IsAlive(tarrgetId) == true then
								proxy:NotNetMessage_begin();
								proxy:RepeatMessage_begin();
									proxy:OnCharacterDead( ACID, targetId, func_ok, once );
								proxy:RepeatMessage_end();
								proxy:NotNetMessage_end();
							else
								print("dead chrEvent");
							end
						end
						--RRðzMÅ«éæ¤ÉüÇ --EN:--Improved to deliver Coco
						proxy:CustomLuaCallStartPlus( 699 , targetId,warp_point );
						--proxy:Warp(targetId, warp_point);						
						--ValidCharactor( proxy, targetId );
						--proxy:SetDisableGravity( targetId, false );	--dÍON						 --EN:--Gravity ON
					else
						proxy:NotNetMessage_begin();
							proxy:OnKeyTime2( ACID, func_ng, 1.0, 0, RapConditionCount, once );
							RapConditionCount = RapConditionCount +1;
						proxy:NotNetMessage_end();
					end
				else
					proxy:NotNetMessage_begin();
						proxy:OnKeyTime2( ACID, func_ng, 1.0, 0, RapConditionCount, once );
						RapConditionCount = RapConditionCount+1;
					proxy:NotNetMessage_end();
				end
				--print("KurageLap return end");
				return;
			end
		end
	end
	--print("KurageLap end");
end

function GenPoint(proxy,param)	
	local target = param:GetParam2();
	local point = param:GetParam3();
	if proxy:IsAlive( target ) == true then
		proxy:Warp( target , point );						
		ValidCharactor( proxy, target );
		proxy:SetDisableGravity( target, false );	--dÍON --EN:--Gravity ON
		print("GenPoint target:",target,"  point:",point);
	end
end

--[[
--¡NQWFl[^pÌ[v|Cgæ¾¡GetWarpPoint --EN:-- ¡ Get Warp Point for Jellyfish Generator ¡ @GetWarpPoint
	proxy					cCxgvLV --EN:proxy c event proxy
	region_list				cÌæÌIDªo^³êÄ¢éXg --EN:region_list cList of region IDs
	rand					cvf(±¢ÂÌlÉ%ÌæÌÅo»ÓÌúõÊuðßé) --EN:rand crandom number element (this value determines the initial search position of the occurrence location with the number of % areas)
]]
function GetWarpPoint(proxy, region_list, rand )
	local region_num = table.getn( region_list );
	local index = 0;
	for index = 0, region_num - 1, 1 do
		local rest = proxy:DivideRest( rand + index, region_num );
		return region_list[rest+1];
	end
	return -1;
end

--[[
--¡NQWFl[^pÌ[v|Cgæ¾¡GetWarpPointCheck --EN:-- ¡ Get warp point for jellyfish generator ¡ @GetWarpPointCheck
	proxy					cCxgvLV --EN:proxy c event proxy
	rand					cvf(±¢ÂÌlÉ%ÌæÌÅo»ÓÌúõÊuðßé) --EN:rand crandom number element (this value determines the initial search position of the occurrence location with the number of % areas)
	list_index				co^³êÄ¢é|CgÌ2³zñCfbNX --EN:list_index c 2D array index of registered points, etc.
]]
function GetWarpPointCheck( proxy, rand, list_index)
	local reg_listA = {2310, 2311, 2312};
	local reg_listB = {2313, 2314, 2315};
	local reg_listC = {2316, 2317};
	local reg_listD = {2318, 2319};
	local region_listlist = {reg_listA, reg_listB, reg_listC, reg_listD};
	
	local act_listA = { 790,  791,  792};
	local act_listB = { 793,  794,  795};
	local act_listC = { 796,  797};
	local act_listD = { 798,  799};
	local action_listlist = {act_listA, act_listB, act_listC, act_listD};

	--vfðæ¾ --EN:-- get number of elements
	local region_num = table.getn( region_listlist[list_index] );
	local index = 0;
	--print("rand ", rand);
	--print("list_index ", list_index);
	--print("region_num ", region_num);
	for index = 0, region_num - 1, 1 do
		--Á½]èðæ¾ --EN:--get remainder
		local rest = proxy:DivideRest( rand + index, region_num );
		--print("index ",index);
		--print("rest ",rest);
		--print("region_num = ",region_num,", rest = ",rest,", rand = ",rand, ", last = ", region_listlist[list_index][rest+1]);
		
		--ÉNà¢È¢ --EN:-- nobody inside
		if proxy:IsCompleteEvent(action_listlist[list_index][rest+1]) == false then
			--print("GetWarpPointCheck return WarpPoint to ",region_listlist[list_index][rest+1]);
			return region_listlist[list_index][rest+1];
		end
	end
	print("GetWarpPointCheck Failed");
	return -1;
end


--[[
--¡WFl[^Ìo^ÜÆßÖ¡GenerateRegist --EN:--¡ Generator registration summary function ¡ @GenerateRegist
	proxy					cCxgvLV --EN:proxy c event proxy
	ACID_start				cANVIDÌª --EN:ACID_start c start of action ID
	TCID_start				c^[QbgÌCxgIDÌª --EN:TCID_start c start of target event ID
	max_index				cÅåÌ-1(úzuÌÌàÜß½SÌ-1) --EN:max_index c maximum number of bodies -1 (total number including the number of initial placements -1)
	staticChrNum			cúzuÌ --EN:staticChrNum c Number of initial placement fields
	func					cÇÁ·éSÄÌnh¼ --EN:func c Handler name of death watch to be added
]]
function GenerateRegist(proxy, ACID_start, TCID_start, max_index, staticChrNum, func)
	local count = 0;
	for index = 0, max_index, 1 do
		local ACID 		= ACID_start + index;
		local targetId 	= TCID_start + index;
		if proxy:IsCompleteEvent( ACID ) == false then
			count = count + 1;
			if count <= staticChrNum then
				proxy:OnCharacterDead( ACID, targetId, func, once );
			else
				proxy:SetDisableGravity( targetId, true );
				InvalidCharactor( proxy, targetId );
			end
		else
			proxy:SetDisableGravity( targetId, true );
			InvalidCharactor( proxy, targetId );
		end
	end
end

function GenerateRegistKURAGE(proxy, ACID_start, TCID_start, max_index, staticChrNum, func)
	local count = 0;
	for index = 0, max_index, 1 do
		local ACID 		= ACID_start + index;
		local targetId 	= TCID_start + index;
		if proxy:IsCompleteEvent( ACID ) == false then
			count = count + 1;
			if count <= staticChrNum then
				if proxy:IsClient() == false then					
					proxy:NotNetMessage_begin();
					proxy:RepeatMessage_begin();
						proxy:OnCharacterDead( ACID, targetId, func, once );
					proxy:RepeatMessage_end();
					proxy:NotNetMessage_end();
				end
			else
				proxy:SetDisableGravity( targetId, true );
				InvalidCharactor( proxy, targetId );
			end
		else
			proxy:SetDisableGravity( targetId, true );
			InvalidCharactor( proxy, targetId );
		end
	end
end

--[[
--¡OnKeyTimepÖ¡TimerCollisionOn --EN:-- ¡ Function for OnKeyTime ¡ TimerCollisionOn
--êèÔÅ½èðOnÉ·éBÛAOnKeyTimeÌParamÉ½èðìµ½¢LÌCxgIDðwè·é --EN:-- Turn hit on for a certain period of time. In this case, specify the event ID of the character you want to manipulate in the OnKeyTime Param
]]
function TimerCollisionOn(proxy,param)
	print("TimerCollisionOn target = ", param:GetParam3() );
	proxy:DisableMapHit( param:GetParam3(), false );
	--proxy:SetColiEnable( param:GetParam3(), true );
end
--[[
--¡OnKeyTimepÖ¡TimerMutekiOff --EN:--¡Function for OnKeyTime ¡TimerMutekiOff
--êèÔÅ³GðOffÉ·éBÛAOnKeyTimeÌParamÉ½èðìµ½¢LÌCxgIDðwè·é --EN:--Turn off invincibility for a certain period of time. In this case, specify the event ID of the character you want to manipulate in the OnKeyTime Param
]]
function TimerMutekiOff(proxy,param)
	print("TimerMutekiOff target = ", param:GetParam3() );
	proxy:SetDeadMode( param:GetParam3()-2000, false);--³GOFF --EN:--Invincibility OFF
end

--------------------------------------------------------------------------------------
--¡515¡iNWRj[¡ --EN:--¡515¡slug colony¡
--------------------------------------------------------------------------------------
--¡515¡iNWRj[¡ --EN:--¡515¡slug colony¡
Namekuzi_HitCount = 0;
function Check_515(proxy,param)
	--RRÍt[Ä³êéÌÅprintðüêéÌÍ¨©ßµÜ¹ñBeXgÌ¾¯ÉµÄ­¾³¢B --EN:--This is monitored every frame, so it is not recommended to include print. Use it only for testing.
	if proxy:CheckChrHit_Obj(10000,1250) == true then
		if proxy:IsRegionIn( 10000, 2220 ) == true then
			--ðª¬§µ½uÔÈÌÅARRÉÍprintðüêÄ¨­±Æð¨©ßµÜ· --EN:--This is the moment when the condition is met, so it is recommended to put a print here
			print("Check_515 true");
			return true
		end
	end
	return false;
end

function OnEvent_515(proxy,param)	
	if Namekuzi_HitCount > 5 then		
		--Rj[¿éAjÄ¶ --EN:-- Colony falling animation playback
		proxy:ForcePlayAnimation( 1250, 2 );

		proxy:NotNetMessage_begin();
			proxy:OnCharacterAnimEnd( 524, 1250, 2, "NamekuziFallAnimEnd", once );
		proxy:NotNetMessage_end();
		
		--Rj[Ì½èOFF --EN:-- Colony hit OFF
		proxy:SetColiEnable( 1250, false );
		proxy:NotNetMessage_begin();
			proxy:OnKeyTime2( 517, "OnEvent_517", 1.7, 0, 2, once );
		proxy:NotNetMessage_end();
		proxy:NotNetMessage_begin();
			proxy:OnKeyTime2( 517, "OnEvent_517_3", 1.6, 0, 3, once );
		proxy:NotNetMessage_end();
		
		proxy:SetEventFlag( 515, true );
		proxy:SetEventFlag( 516, true );--ÖXã§ÄÄ¨­ --EN:-- stand up for convenience
		proxy:DeleteEvent( 515 );
	else		
		Namekuzi_HitCount = Namekuzi_HitCount + 1;
		print("Namekuzi_HitCount = ", Namekuzi_HitCount );
		if proxy:IsEventAnim( 1250 , 0 ) == true then
			proxy:PlayAnimation( 1250, 1 );
			proxy:RepeatMessage_begin();
			proxy:NotNetMessage_begin();
				proxy:OnCharacterAnimEnd( 515, 1250, 1, "NamekuziDamageAnimEnd", once );
			proxy:NotNetMessage_end();
			proxy:RepeatMessage_end();
		end
	end	
end

function NamekuziDamageAnimEnd(proxy,param)
	if proxy:IsEventAnim( 1250 , 2 ) == false then
		print("NamekuziDamageAnimEnd begin");
		proxy:PlayAnimation( 1250, 0 );
		print("NamekuziDamageAnimEnd end");
	end
end

function NamekuziFallAnimEnd(proxy,param)
	print("NamekuziFallAnimEnd begin");
	for index = 1, 15, 1 do
		ValidCharactor( proxy, 700 + index - 1);
	end
	proxy:SetColiEnable( 1250, false );
	proxy:SetDrawEnable( 1250, false );
	print("NamekuziFallAnimEnd end");
end


--------------------------------------------------------------------------------------
--¡517¡[Cg¡ --EN:-- ¡ 517 ¡ Moonlight ¡
--------------------------------------------------------------------------------------
function OnEvent_517(proxy,param)

	--[CgÌ½èE\¦ON --EN:-- Moonlight hit / display ON
	proxy:SetColiEnable( 1260, true );
	proxy:SetDrawEnable( 1260, true );
	proxy:TreasureDispModeChange2( 1260, true ,KEN_SFX);
	
	if proxy:IsCompleteEvent( 517 ) == false then
		--zXgA¶¶AOCÌÝ²×é±ÆªÅ«é --EN:--Only hosts, survivors, and grays can be examined
		local possible_chr_type = ATTR_HOST + ATTR_LIVE + ATTR_GREY;
		
		proxy:OnDistanceActionAttribute( 517 , 10000 , 1260 , "OnEvent_517_0" , ItemBoxDist_A , 10010140 , 0 , ItemBoxAngle_A ,possible_chr_type, everytime ); 
		proxy:LuaCall( 517,1,"OnEvent_517_2",once);
		proxy:LuaCall( 517,2,"OnEvent_517_4",once);
		
	else
		proxy:SetDrawEnable( 1260 , false );--ÐÆÜ¸`æ¾¯OFF --EN:--Only drawing is turned off for the time being
		proxy:SetColiEnable( 1260 , false );
	end
	
end


--[Cgæ¾ --EN:--Moonlight acquisition process
function OnEvent_517_0(proxy,param)
	if param:IsNetMessage() == false then
	print("OnEvent_517_0 begin");
	proxy:NotNetMessage_begin();
	proxy:RepeatMessage_begin();
		proxy:PlayAnimation( 10000 , 8290);		
		proxy:PlayAnimation( 1260 , 1);	
		proxy:OnKeyTime2( 517 , "OnEvent_517_wait",0.01,0,100,once);
	proxy:RepeatMessage_end();
	proxy:NotNetMessage_end();
	print("OnEvent_517_0 end");
	end
end

function OnEvent_517_wait(proxy,param)
	print("OnEvent_517_wait begin");
	if proxy:IsEventAnim( 10000 , 8290 ) == true then
		proxy:LuaCallStart( 517 , 2 );
	else
		proxy:ForcePlayAnimation( 1260 , 0);	
	end
	print("OnEvent_517_wait end");
end

function OnEvent_517_1(proxy,param)
	print("OnEvent_517_1 begin");
	
	--ACeæ¾Ö--p[^10430QÆ --EN:--item retrieval function--see parameter 10430
	proxy:GetRateItem(10430);	
		
	--OBJðÁ·½ßÌCxgzM --EN:--Event distribution for erasing OBJ
	proxy:LuaCallStart( 517, 1);

	print("OnEvent_517_1 end");
end

function OnEvent_517_2(proxy,param)
	print("OnEvent_517_2 begin");
	--IuWFªÁ¦é --EN:--The object disappears
	proxy:SetDrawEnable( 1260 , false );--ÐÆÜ¸`æ¾¯OFF --EN:--Only drawing is turned off for the time being
	proxy:SetColiEnable( 1260 , false );--½èÍ éÌÍs¾(»óÅÍÈ¢æ¤ÈÌÅÁ³È¢) --EN:--I don't know if there is a hit (I don't delete it because it doesn't seem to be the current situation)
	
	--ACeðæ¾ÏÝ --EN:--item already acquired
	proxy:SetEventFlag( 517, true );
	proxy:DeleteEvent( 517 );
	
	print("OnEvent_517_2 end");
end

function OnEvent_517_3(proxy,param)
	print("OnEvent_517_3 begin");
	proxy:ValidSfx( 2222 );
	print("OnEvent_517_3 end");
end

--Aj¯úEÄ --EN:--Animation synchronization/monitoring
function OnEvent_517_4(proxy,param)
	print("OnEvent_517_4 begin");	
	proxy:TreasureDispModeChange2( 1260, false ,KEN_SFX);
	--vC[Ì¯úAj[V(true:p[eB[vC[ªAj[Vµ½) --EN:--Player synchronous animation (true: party player animated)
	if Luafunc_PlaySynchroAnimation( proxy, param, 8290 ) == true then--Vµ¢Aj  --EN:-- new anime
		proxy:PlayAnimation( 1260 , 1);	
		print("OnEvent_517 end");
		return true;
	end

	--É[v --EN:--Warp to sword
	proxy:WarpDmy( 10000 , 1260 , 191 );	
	
	proxy:NotNetMessage_begin();
		proxy:OnChrAnimEnd( 517 , 10000 , 8290 , "OnEvent_517_1", once);
	proxy:NotNetMessage_end();
	print("OnEvent_517_4 end");
end



--------------------------------------------------------------------------------------
--¡520¡ÅÀ¡ --EN:--¡520¡Poison Swamp¡
--------------------------------------------------------------------------------------
--¡520¡ÅÀ¡ --EN:--¡520¡Poison Swamp¡
function PoizonFloorDam(proxy,param)
	--°_[Wp|CgÌeCxgID --EN:--Each event ID for floor damage points
	--2210
	local floorTbl = {2210};
	local tblnum = table.getn( floorTbl );	
	local ACID = 520;
	
	--Æè ¦¸»èOÉ|µÄ¨­ --EN:--For the time being, defeat it before the judgment
	IsInPoizonArea = false;
	
	--ÌæÌÅàÅ_[Wðó¯È¢Ìæ --EN:--Area that does not receive poison damage even in the area
	local floorTbl_out = {2215, 2216};
	local tblnum_out = table.getn( floorTbl_out );
	
	for index = 1, tblnum, 1 do
		if proxy:IsRegionIn( 10000, floorTbl[index] ) == true then
			IsInPoizonArea = true;
		end
	end
	
	if IsInPoizonArea == true then
		for index = 1, tblnum_out, 1 do
			if proxy:IsRegionIn( 10000, floorTbl_out[index] ) == true then
				IsInPoizonArea = false;
			end
		end
	end
	
--~ 	--üÁÄ¢éÔÍ©¯±¯é(ÅÏ«ÅÅª©©çÈ­ÈéâèÎô) --EN:--While it is in, keep it on (measures against the problem of being poisoned by poison resistance)
--~ 	if	IsInPoizonArea == true then
--~ 	end
	
	--üÁ½uÔ --EN:--The moment you enter
	if proxy:IsCompleteEvent( ACID ) == false and
		IsInPoizonArea == true then
		print("PoizonFloorDam JustIn", tblnum);
		proxy:SetEventSpecialEffect(10000, 10080);
		
		proxy:SetEventFlag( ACID, IsInPoizonArea );
		
		proxy:NotNetMessage_begin();
			proxy:OnKeyTime2( 521, "OnEvent_521", 0.0, 0, 1, once );
		proxy:NotNetMessage_end();
	end
	
	--²¯o½uÔ --EN:--The moment you escape
	if  proxy:IsCompleteEvent( ACID ) == true and
		IsInPoizonArea == false then
		print("PoizonFloorDam JustOut", tblnum);
		proxy:EraseEventSpecialEffect(10000, 10080);
		
		proxy:SetEventFlag( ACID, IsInPoizonArea );
		proxy:DeleteEvent( 521 );
	end

	
	--âÎÉÊð¬§³¹È¢æ --EN:--I will never let the result come true
	return false;
end

function dummy(proxy,param)
end

function OnEvent_521(proxy,param)
	--print("OnEvent_521 begin");
	local set_param = proxy:DivideRest( param:GetParam3() + 1, 2 );
	local reload = Lua_GetReloadTime(proxy,PoizonCycle_low,PoizonCycle_High);
	
	--print("reload ",reload)
	
	--p±IÉüÁÄ¢éÌÝÌÄðÇÁÅ«é --EN:--The next monitor can be added only when it is continuously entered
	if IsInPoizonArea == true then
		proxy:NotNetMessage_begin();
			proxy:OnKeyTime2( 521, "OnEvent_521", reload, 0, set_param, once );
		proxy:NotNetMessage_end();
	else
		--OÌ×d¢à«ð --EN:--Release heavy walking just in case
		proxy:EraseEventSpecialEffect(10000, 10080);
	end
	
	proxy:SetEventSpecialEffect( LOCAL_PLAYER, 10280);
	--print("OnEvent_521 end");
end

--------------------------------------------------------------------------------------
--pjf[Ìoê¡?? --EN:-- Appearance of the Wandering Demon ??
--------------------------------------------------------------------------------------

--¥O[oÌSÄ©çÄÎêé(\) --EN:--¥ Called from global death watch (solo)
function PlayerDeath_m05_01_00_00(proxy, param)
	print("PlayerDeath_m05_01_00_00");
	
--	LuaFunc_VisibleTheWanderingDemon(proxy, param, demon_id_list_m05_01_00_00);
--	proxy:SetEventFlag( 20 , 1 );--tOÍ¼Awèª êÎÏ¦éB --EN:The -- flag is tentative, and will be changed if specified.
	
	print("PlayerDeath_m05_01_00_00");
end

--¥O[oÌ¶©çÄÎêé(\) --EN:--¥Called from global blood letter revival (solo)
function PlayerRevive_m05_01_00_00(proxy,param)
	print("PlayerRevive_m05_01_00_00");
	
--	LuaFunc_InvisibleTheWanderingDemon(proxy, param, demon_id_list_m05_01_00_00);
--	proxy:SetEventFlag( 20 , 0 );--tOÍ¼Awèª êÎÏ¦éB --EN:The -- flag is tentative, and will be changed if specified.
	
	print("PlayerRevive_m05_01_00_00");
end

--------------------------------------------------------------------------------------
--{X®ÌÉüé¡533 --EN:--Enter the boss room ¡533
--------------------------------------------------------------------------------------

--¡Cxgª[vÈÌÅASs[gÉ·é« --EN:--¡ Since the event is a loop, repeat all «

--¡533¡{X®ÖÌàªJ­¡ --EN:-- ¡ 533 ¡ The door to the mid-boss room opens ¡
function OnEvent_533(proxy,param)
	print("OnEvent_533 begin");

	if proxy:IsCompleteEvent( SYSTEM_ID_IGNORE ) == true then
		print("OnEvent_533 end");
		return;
	end	
	
	--NCAgÖA{X®j~¸sðÊm --EN:--Notify client of failure to block boss room
	if proxy:IsClient() == false then
		proxy:LuaCallStart( 4068 , 1 );	
	end
	
	proxy:LuaCallStart( 534 , 1 );--ùñAjÌ¯úÄ¶ --EN:-- Synchronous playback of turning animation
	--proxy:SetEventFlag( SYSTEM_ID_IGNORE , true );--½d­®h~ptOON --EN:--Multiple activation prevention flag ON
	--½dN®VXeIDð^CAEgðÝèµÄONÉ·é --EN:--Turn on multiple activation system ID by setting timeout
	proxy:SetSystemIgnore( SYSTEM_ID_IGNORE , IGNORE_TIME );
	
	--vt@CZ[uv --EN:--profile save request
	proxy:SaveRequest_Profile();
	
	print("OnEvent_533 end");
end


--ùñAjÌ¯úÄ¶(IDªÊ) --EN:-- Synchronized playback of turning animation (ID is different)
function OnEvent_534_1(proxy,param)
	print("OnEvent_534_1 begin");

	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		if param:IsNetMessage() == true then
			--ùñAjÄ¶ðs¢A»ÌI¹ÉOnEvent_534_2ð­s·é --EN:--Play the turning animation and issue OnEvent_534_2 at the end
			proxy:TurnCharactor( 10001 + param:GetPlayID(), 2890 );
		else
			proxy:LockSession();--[ðbNµÜ·I --EN:--lock the room!
			--ùñAjÄ¶ðs¢A»ÌI¹ÉOnEvent_534_2ð­s·é --EN:--Play the turning animation and issue OnEvent_534_2 at the end
			proxy:OnTurnCharactorEnd( 534, 10000, 2890, "OnEvent_534_2", once );
		end
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	
	print("OnEvent_534_1 end");
end

--ùñAjÌ¯úÄ¶I¹ã --EN:--After synchronous playback of turning animation ends
function OnEvent_534_2(proxy,param)
	print("OnEvent_534_2 begin");
	
	--¯úpà«AjÄ¶ --EN:--Play walking animation for synchronization
	proxy:LuaCallStart( 4012, 1 );
	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		proxy:OnChrAnimEnd( 534, 10000, ANIMEID_WALK, "OnEvent_534_3", once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();

	print("OnEvent_534_2 end");
end

--à«AjÌ¯úÄ¶I¹ã --EN:--After the synchronized playback of the walking animation ends
function OnEvent_534_3(proxy,param)
	print("OnEvent_534_3 begin");

	--ÅÌlª{X®ÌÉüèIíÁÄ¢½çAùÉzM³êÄ¢éÍ¸ÈÌÅAà¤¨­çÈ¢nh --EN:--If the first person has already entered the boss room, it should have already been delivered, so no more handlers
	if proxy:IsCompleteEvent( 533 ) == false then
		proxy:LuaCallStart( 534 , 5 );--2ñÚÈ~É{X®Éüé½ßÌCxgzMp --EN:--For event delivery to enter the boss room after the second time
		proxy:LuaCallStart( 4045 , 1 );	--NCAgÖA{X®Éüêéæ¤ÉÈÁ½±ÆðÊm --EN:--Notify clients that they can now enter the boss room
		proxy:LuaCallStart( 534 , 6 );--tOZbg(¯úp) --EN:--flag set (for synchronization)
		Lua_MultiDoping(proxy,809);--}`vCh[sO --EN:-- Multiplayer Doping
	end

	proxy:SetEventFlag( SYSTEM_ID_IGNORE, false );

	print("OnEvent_534_3 end");
end


--¡533 2ñÚÈ~É{X®Éüé½ßÌCxgzMp --EN:-- 533 For event delivery to enter the boss room after the second time
function OnEvent_533_GO_TO_IN(proxy, param)
	print("OnEvent_533_GO_TO_IN begin");
		
	proxy:NotNetMessage_begin();
		--¥534¥àªJ¢Ä¢éÆ«ÉÉüé½ßÌCxgðÇÁ¥--nhÍ OnEvent_533 --EN:--¥534¥Add an event to enter when the door is open¥--The handler is OnEvent_533
		proxy:OnPlayerActionInRegion( 534, 2894, "OnEvent_533", HELPID_GO_TO_IN, everytime );--
	proxy:NotNetMessage_end();	
	
	print("OnEvent_533_GO_TO_IN end");
end


--¡533 tOZbg(¯úp) --EN:-- 533 Flag set (for synchronization)
function OnEvent_533_flag_set(proxy, param)
	print("OnEvent_533_flag_set begin");
		
	proxy:SetEventFlag( 533 , 1 );
	proxy:DeleteEvent( 533 );

	print("OnEvent_533_flag_set end");
end


--------------------------------------------------------------------------------------
--¡537¡{Xí¬Jn¡ --EN:-- ¡ 537 ¡ Boss battle begins ¡
--------------------------------------------------------------------------------------
--¡537¡{Xí¬Jn¡ --EN:-- ¡ 537 ¡ Boss battle begins ¡
function OnEvent_537(proxy,param)
	print("OnEvent_537 begin");
	proxy:PlayPointSE( 2250, SOUND_TYPE_M, 50100000, 1 );
	proxy:ResetThink( 809 );
	proxy:EnableLogic( 809, true );

	--1x{Xð|µ¹ËÄÄí·éAtOª§Á½ÜÜ¾Æú»Å«Ü¹ñB --EN:--When you fail to beat the boss once and rematch, you cannot initialize if the flag is left up.
	--proxy:SetEventFlag(537, true);
	
	--{XQ[W\¦ --EN:-- Boss gauge display
	proxy:SetBossGauge(809, 0, 5080);
	proxy:SetEventFlag( 537 , true );
	
	print("OnEvent_537 end");
end


--------------------------------------------------------------------------------------
--¡5770¡{XS¡ --EN:-- ¡ 5770 ¡ Boss death ¡
--------------------------------------------------------------------------------------
--¡5770¡{XS¡ --EN:-- ¡ 5770 ¡ Boss death ¡
function OnEvent_5770(proxy,param)
	print("OnEvent_5770 begin");
	
	proxy:NotNetMessage_begin();
		--1bãÉACeæ¾Cxgð­s-- --EN:--Issue an item acquisition event after 1 second--
		proxy:OnKeyTime2(5770,"OnEvent_5770_1", 1.0,0,0,once);
		--2bãÉöêéÇ­®Cxgð­s-- --EN:-- Issue a wall trigger event that collapses after 2 seconds --
		proxy:OnKeyTime2(5772,"OnEvent_5772", 2.0,0,0,once);
		--}`ðUÄ --EN:--Multi-Dismissal Monitoring
		proxy:OnRegistFunc( 5770,"Check_5770_PT","OnEvent_5770_PT",0,once);
	proxy:NotNetMessage_end();

	proxy:SetEventFlag( 5770, true );--tOð§ÄéB --EN:--Flag.

	--ubNNAÖ --EN:-- to block clear processing
	proxy:CustomLuaCallStart( 4050, 809 );
	--gJQZbg --EN:-- lizard reset
	ResetTokage(proxy);
	
	print("OnEvent_5770 end");
end

--£5770_1£1bã£ --EN:--£5770_1£After 1 second£
function OnEvent_5770_1(proxy, param)
	print("OnEvent_5770_1 begin");
	
	--{Xð|µ½ðXV(ÉæÁÄtOð§Äé) --EN:--update number of bosses killed (flag by number)
	GetBossFlagCount( proxy, param );
	
	--¥gtB[æ¾»è¥ --EN:--¥Trophy Acquisition Judgment¥
	Lua_RequestUnlockTrophy(proxy, 35);--gtBÌóµð»èµAæ¾ --EN:--Determine and retrieve trophy status
		
	--zXgvC[ÌÝACeüèCxgÉgp --EN:--Used for item acquisition event only for host players
	local possible_chr_type = ATTR_HOST + ATTR_LIVE + ATTR_GREY;
	
	--óÌ(\E?)Lø» --EN:--Treasure corpse (soul?) activation
	proxy:SetDrawEnable( 1981 , true );
	proxy:SetColiEnable( 1981 , true );
	--\EÉh³Á½Lø» --EN:--Activation of the sword stuck in the soul
	proxy:SetDrawEnable( 1976 , true );
	proxy:SetColiEnable( 1976 , true );
	
	--¥(\E)ACeæ¾pCxgÄÇÁ¥ --EN:--¥ (Soul) Added event monitoring for item acquisition¥
	if proxy:IsCompleteEvent( 5773 ) == false then
		--SFXÌLø» --EN:--Enable SFX
		proxy:ValidSfx( 2360 );--vÎÌI[ --EN:--Keystone Aura
		proxy:ValidSfx( 2361 );--õÌ±q --EN:--Particles of light
		--\EÆh³ÁÄ¢éðP©¹é --EN:--Glowing Soul and Stabbing Sword
		proxy:TreasureDispModeChange2( 1981 , true ,KANAME_SFX);--õç¹é --EN:-- let it shine
		--proxy:TreasureDispModeChange2( 1976 , true ,KANAME_SFX);--õç¹é --EN:-- let it shine
		proxy:OnDistanceActionAttribute( 5773 , 10000 , 1981 , "OnEvent_5773" , WarpGimmickDist_A , 10010180 , 0 , 180 , possible_chr_type, once );
	end
	
	print("OnEvent_5770_1 end");
end

--£5770_2£2bã£ --EN:--£5770_2£After 2 seconds£
function OnEvent_5772(proxy, param)
	print("OnEvent_5772 begin");
	
	--{XípÌBGMâ~ --EN:--BGM stop for boss battles
	--proxy:StopPointSE( 0 );
	proxy:StopPointSE( 1 );	

	print("OnEvent_5772 end");
end

--}`ðUÄ --EN:--Multi-Dismissal Monitoring
function Check_5770_PT(proxy)
	if proxy:IsInParty() == false then
		return true;
	end
	return false;
end

--}`¶áÈ¢ --EN:--not multiplayer
function OnEvent_5770_PT(proxy,param)
	print("OnEvent_5770_PT begin");
	--{X®ÌOãÌ@ÇªÁ¦é(SvC[) --EN:--The magic walls before and after the mid-boss room disappear (all players)
	proxy:SetColiEnable( 1998 , false );
	proxy:SetColiEnable( 1994 , false );
	
	proxy:SetDrawEnable( 1998 , false );
	proxy:SetDrawEnable( 1994 , false );	

	--õÌÇSfxðÁ· --EN:--Turn off the wall of light Sfx
	proxy:InvalidSfx( 1986, true );
	proxy:InvalidSfx( 1990, true );	
	
	--{X®OÌÚ®Cxgðí --EN:--Delete the movement processing event in front of the mid-boss room
	proxy:DeleteEvent( 533 );--êlÚªüéÆ«p --EN:--For when the first person enters
	proxy:DeleteEvent( 534 );--ñlÚÈ~ªüéÆ«p --EN:--For when the second and subsequent people enter
	print("OnEvent_5770_PT end");
end

--------------------------------------------------------------------------------------
--¡5773¡\Eüè¡ --EN:-- ¡ 5773 ¡ Get Soul ¡
--------------------------------------------------------------------------------------
function OnEvent_5773(proxy, param)
	print("OnEvent_5773 begin");
	
	--vC[Ì¯úAj[V(true:p[eB[vC[ªAj[Vµ½) --EN:--Player synchronous animation (true: party player animated)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_PICK ) == true then--Vµ¢Aj  --EN:-- new anime
		print("OnEvent_5773 end");
		return true;
	end
	
	proxy:NotNetMessage_begin();
		--0.0bãÉACeæ¾Cxgð­s --EN:-- Issue an item acquisition event after 0.0 seconds
		proxy:OnKeyTime2( 5773, "OnEvent_5773_1", 0.0, 0, 0, once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_5773 end");
end


--¡5773_1¡ACeæ¾¡ --EN:-- ¡ 5773_1 ¡ item acquisition ¡
function OnEvent_5773_1(proxy, param)
	print("OnEvent_5773_1 begin");

	--ACeæ¾Ö --EN:--Item acquisition function
	proxy:GetRateItem(10451);--p[^10451QÆ --EN:-- See parameter 10451
	proxy:GetRateItem(10474);--p[^10474QÆ --EN:--see parameter 10474
	proxy:GetRateItem(10475);--p[^10475QÆ --EN:--see parameter 10475
	proxy:GetRateItem(10476);--p[^10476QÆ --EN:--see parameter 10476
	proxy:GetRateItem(10477);--p[^10477QÆ --EN:--see parameter 10477
	
	--ACeðæ¾ÏÝ --EN:--item already acquired
	proxy:SetEventFlag( 5773, 1 );
	
	--óVF[_[OFF --EN:--Treasure Shader OFF
	--proxy:TreasureDispModeChange( 1981 , false );

	--SFXªÁ¦é --EN:--SFX disappear
	proxy:InvalidSfx( 2360 , true );--vÎÌI[ --EN:--Keystone Aura
	--proxy:InvalidSfx( 2361 , true );--õÌ±q --EN:--Particles of light
	
	--¥vÎÅ[vpÌÄðÇÁ¥ --EN:--¥ Added surveillance for warp with keystone ¥
	proxy:OnDistanceActionAttribute( 5774 , 10000 , 1981 , "OnEvent_5774" , WarpGimmickDist_A , HELPID_GO_TO_SEKITYUU , 0 , 180 , ATTR_NOSESSION , everytime );

	print("OnEvent_5773_1 end");
end

--------------------------------------------------------------------------------------
--¡535¡õÌÇ¡ --EN:-- ¡ 535 ¡ Wall of Light ¡
--------------------------------------------------------------------------------------
--¡535¡õÌÇ¡ --EN:-- ¡ 535 ¡ Wall of Light ¡
function OnEvent_535(proxy,param)
	print("OnEvent_535 begin");
	
	if proxy:IsCompleteEvent(535) == true then
		return;
	end
	
	--vC[Ì¯úAj[V(true:p[eB[vC[ªAj[Vµ½) --EN:--Player synchronous animation (true: party player animated)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_WALK ) == true then
		proxy:SetEventFlag( 535 , true );
		return;
	end
	--_~|Ö[v --EN:--Warp to Damipoli
	proxy:WarpDmy( 10000, 1300, 191 );
	
	proxy:NotNetMessage_begin();
		--¥535_1¥à«AjI¹¥ --EN:--¥535_1¥End of walking animation¥
		--proxy:OnChrAnimEnd( 535, 10000, ANIMEID_WALK, "OnEvent_535_1" , once );
		proxy:LuaCallStart( 535, 2 );
	proxy:NotNetMessage_end();
	proxy:SetEventFlag( 535 , true );
	
	--vt@CZ[uv --EN:--profile save request
	proxy:SaveRequest_Profile();
	
	print("OnEvent_535 end");
end

function OnEvent_535_1(proxy,param)
	print("OnEvent_535_1 begin");
	
	proxy:LuaCallStart( 535, 2 );
	
	print("OnEvent_535_1 end");
end

function OnEvent_535_delete(proxy,param)
	print("OnEvent_535_delete begin");
	
	proxy:DeleteEvent( 535 );
	proxy:SetDrawEnable( 1300, false );--`æOFF --EN:--Drawing OFF
	proxy:SetColiEnable( 1300, false );--½èOFF --EN:--Hit OFF
	proxy:InvalidSfx( 2200, true );
	proxy:SetObjDeactivate( 1300 , true );--fANeBu --EN:--deactivate
	
	print("OnEvent_535_delete end");
end



--------------------------------------------------------------------------------------
--¡536¡õÌÇ¡ --EN:-- ¡ 536 ¡ Wall of Light ¡
--------------------------------------------------------------------------------------
--¡536¡õÌÇ¡ --EN:-- ¡ 536 ¡ Wall of Light ¡
function OnEvent_536(proxy,param)
	print("OnEvent_536 begin");
	
	if proxy:IsCompleteEvent(536) == true then
		return;
	end
	
	--vC[Ì¯úAj[V(true:p[eB[vC[ªAj[Vµ½) --EN:--Player synchronous animation (true: party player animated)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_WALK ) == true then
		proxy:SetEventFlag( 536 , true );
		return;
	end
	--_~|Ö[v --EN:--Warp to Damipoli
	proxy:WarpDmy( 10000, 1301, 191 );
	
	proxy:NotNetMessage_begin();
		--¥536_1¥à«AjI¹¥ --EN:--¥536_1¥End of walking animation¥
		--proxy:OnChrAnimEnd( 536, 10000, ANIMEID_WALK, "OnEvent_536_1" , once );
		proxy:LuaCallStart( 536, 2 );
	proxy:NotNetMessage_end();
	proxy:SetEventFlag( 536 , true );
	
	--vt@CZ[uv --EN:--profile save request
	proxy:SaveRequest_Profile();
	
	print("OnEvent_536 end");
end

function OnEvent_536_1(proxy,param)
	print("OnEvent_536_1 begin");
	
	proxy:LuaCallStart( 536, 2 );
	
	print("OnEvent_536_1 end");
end

function OnEvent_536_delete(proxy,param)
	print("OnEvent_536_delete begin");
	
	proxy:DeleteEvent( 536 );
	proxy:SetDrawEnable( 1301, false );--`æOFF --EN:--Drawing OFF
	proxy:SetColiEnable( 1301, false );--½èOFF --EN:--Hit OFF
	proxy:SetObjDeactivate( 1301 , true );--fANeBu --EN:--deactivate
	proxy:InvalidSfx( 2201, true );
	
	print("OnEvent_536_delete end");
end

--------------------------------------------------------------------------------------
--¡538¡{XJØèÖ¦Cxg¡ --EN:-- ¡ 538 ¡ Boss camera switching event ¡
--------------------------------------------------------------------------------------
function OnEvent_538(proxy,param)
	--print("OnEvent_538 begin");
	--{XªñÅ¢È¢@©Â@{XÆÌí¬ðJnµÄ¢é --EN:-- Boss is not dead and has started a battle with the boss
	if proxy:IsCompleteEvent( 5770 ) == false and proxy:IsCompleteEvent( 537 ) == true then
		--{Xí@ñbNJ --EN:-- Boss battle unlocked camera
		proxy:SetCamModeParamTargetId(5021);
		--{Xí@bNJ --EN:--Boss battle rock camera
		proxy:SetCamModeParamTargetIdForBossLock(5020);
	end
	--print("OnEvent_538 end");
end

--------------------------------------------------------------------------------------
--¡ZÖA¡ --EN:--selenium-related
--------------------------------------------------------------------------------------
-----------------------------------------------------------------------------
--801¡S[hÌäÍ÷n --EN:--801 ¡Gold Run crest transfer
-----------------------------------------------------------------------------
function OnEvent_801(proxy,param)
	print("OnEvent_801 begin");
	
	if	proxy:RemoveInventoryEquip( TYPE_GOODS, 37 ) == true then
		print("OnEvent_801 ACeí¬÷"); --EN:print("OnEvent_801 Item deleted successfully");
	end
	SetNpcStateFlag( proxy, param, selen_flag_list, SELEN_STATE_THANKS );
	
	proxy:SetEventFlag( 801, true );
	proxy:NotNetMessage_begin();
	proxy:OnRegionJustOut( 802, LOCAL_PLAYER, 2240, "OnEvent_802", once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_801 end");
end

function OnEvent_802(proxy,param)
	print("OnEvent_802 begin");
	
	proxy:SetEventFlag( 802, true );
	SetNpcStateFlag( proxy, param, selen_flag_list, SELEN_STATE_PURIFY );
	InvalidCharactor( proxy, 652 );
	
	print("OnEvent_802 end");
end

-----------------------------------------------------------------------------
--803¡ZGÎ --EN:--803 ¡ Selenium hostility
-----------------------------------------------------------------------------
function OnEvent_803(proxy,param)
	print("OnEvent_803 begin");
	proxy:SetEventFlag( 803, true );
	
	proxy:EnableLogic( 652, true );
	proxy:SetTeamType( 652, TEAM_TYPE_AngryFriend );
	SetNpcStateFlag( proxy, param, selen_flag_list, SELEN_STATE_ANGRY );

	print("OnEvent_803 end");
end

-----------------------------------------------------------------------------
--804¡ZS --EN:--804 ¡ Selenium death
-----------------------------------------------------------------------------
function OnEvent_804(proxy,param)
	print("OnEvent_804 begin");
	
	proxy:SetEventFlag( 804, true );
	SetNpcStateFlag( proxy, param, selen_flag_list, SELEN_STATE_DEAD );
	
	print("OnEvent_804 end");
end

--ZÌÌð²×½ --EN:--Examined Selene's corpse
function OnEvent_15633(proxy,param)
	print("OnEvent_15633 begin");
	proxy:SetEventFlag( 15633 , true );
	print("OnEvent_15633 end");
end

-----------------------------------------------------------------------------
--808¡MÂª¢ÌñViwÖj --EN:--808 Reward when faith is high (ring)
-----------------------------------------------------------------------------
function OnEvent_808(proxy,param)
	print("OnEvent_808 begin");
	--ACeðüè·é --EN:--Get items
	proxy:GetRateItem(10750);--wÖ --EN:--ring
	
	proxy:SetEventFlag( 808,true);
	
	print("OnEvent_808 end");
end

-----------------------------------------------------------------------------
--809¡MÂªá¢ÌñViÃj --EN:--809 Reward when faith is low (Dark moon grass)
-----------------------------------------------------------------------------
function OnEvent_809(proxy,param)
	print("OnEvent_809 begin");
	--ACeðüè·é --EN:--Get items
	proxy:GetRateItem(10751);--Ã --EN:--Dark moon grass

	proxy:SetEventFlag( 809,true);
	
	print("OnEvent_809 end");
end

-----------------------------------------------------------------------------
--ZEubNS[XgªSµ½©Ç¤©ÌtOZbg --EN:--Flag set whether or not Selene Black Ghost is dead
-----------------------------------------------------------------------------
function OnEvent_820(proxy, param)
	print("OnEvent_820 begin");
	--Sµ½tOð§Äé --EN:--Flag dead
	proxy:SetEventFlag( 820, true );
		
	print("OnEvent_820 end");
end

-----------------------------------------------------------------------------
--¡15600¡ZEubNS[XgÌÌð²×½©H --EN:--¡15600¡Did you examine Selene Black Ghost's corpse?
-----------------------------------------------------------------------------
function OnEvent_15600(proxy,param)
	print("OnEvent_15600 begin");
	proxy:SetEventFlag( 15600 , true );
	print("OnEvent_15600 end");
end

--------------------------------------------------------------------------------------
--îH()Éêè_[W¡810 --EN:-- Fixed damage to beggar (female) ¡ 810
--------------------------------------------------------------------------------------
function OnEvent_810(proxy,param)
	print("OnEvent_810 begin");

	--WbNOn --EN:--Logic On
	proxy:EnableLogic( 677, true );
	
	--îH()ÌóÔðGÎ(sò3)É·é --EN:--Make beggar (female) hostile (unclean 3)
	SetNpcStateFlag(proxy, param, Kojiki_Shop_Flag_list, KOJIKI_FEMALE_SHOP_HOSTILE02);
	--îH()Ì`[^CvðÏX·é --EN:--Change beggar (female) team type
	proxy:SetTeamType( 677, TEAM_TYPE_AngryFriend );

	--tOð§Äé --EN:-- flag
	proxy:SetEventFlag( 810, true );
	
	print("OnEvent_810 end");
end


--------------------------------------------------------------------------------------
--îH()S¡811 --EN:--Beggar (female) died ¡811
--------------------------------------------------------------------------------------
function OnEvent_811(proxy,param)
	print("OnEvent_811 begin");

	--îH()ÌóÔðuSvÉÏ¦é --EN:-- Change the state of the beggar (female) to "dead"
	SetNpcStateFlag( proxy, param, Kojiki_Shop_Flag_list, KOJIKI_FEMALE_SHOP_DEAD );
	
	--GÉíçêÄGÎðÊèzµÄSà è¦éÌÅA±±Åàí --EN:--Because it is possible to die by being scraped by the enemy and passing through the hostility, it is also deleted here
	--ñ¾çGÎÉÍÈçÈ¢ÌÅí --EN:--Deleted because it won't be hostile if you die
	proxy:DeleteEvent( 270 );
	proxy:DeleteEvent( 810 );

	--tOð§Äé --EN:-- flag
	proxy:SetEventFlag( 811, true );
	
	print("OnEvent_811 end");
end


------------------------------
--zÎÌ¸ìSÄ-- --EN:--Ore Spirit Death Watch--
------------------------------
function OnEvent_828(proxy, param)
	print("OnEvent_828 begin");
	--Sµ½tOð§Äé --EN:--Flag dead
	proxy:SetEventFlag( 828, true );
		
	print("OnEvent_828 end");
end


--------------------------------------------------------------------------------------
--¡8020¡zÎÌ¸ì©çACeæ¾¡ --EN:-- ¡ 8020 ¡ Acquiring items from the ore spirit ¡
--------------------------------------------------------------------------------------
function OnEvent_8020(proxy,param)
	print("OnEvent_8020 begin");
	proxy:SetEventFlag( 8020 , true );
	print("OnEvent_8020 end");
end


--------------------------------------------------------------------------------------
--¡842¡÷«èubNSÄ¡ --EN:-- ¡ 842 ¡ meat cut black death watch ¡
--------------------------------------------------------------------------------------
function OnEvent_842(proxy,param)
	print("OnEvent_842 begin");
	proxy:SetEventFlag( 842 , true );
	print("OnEvent_842 end");
end


--------------------------------------------------------------------------------------
--¡840¡å¢SFX\¦ÌæÉüÁ½¡ --EN:-- 840 Entered the fly SFX display area
--------------------------------------------------------------------------------------
function OnEvent_840(proxy,param)
	print("OnEvent_840 begin");
	proxy:CreateCamSfx(95202,0);
	print("OnEvent_840 end");
end


--------------------------------------------------------------------------------------
--¡841¡å¢SFX\¦Ìæ©ço½¡ --EN:--¡841¡Fly out of the SFX display area¡
--------------------------------------------------------------------------------------
function OnEvent_841(proxy,param)
	print("OnEvent_841 begin");
	proxy:DeleteCamSfx( 0 );
	print("OnEvent_841 end");
end


--------------------------------------------------------------------------------------
--¡770¡iNWSµ½¡ --EN:-- ¡ 770 ¡ slug died ¡
--------------------------------------------------------------------------------------
function OnEvent_770(proxy,param)
	print("OnEvent_770 begin");	
	proxy:SetEventFlag( 770 , true );
	print("OnEvent_770 end");
end

--------------------------------------------------------------------------------------
--¡15626¡iNWÌ²×½¡ --EN:--¡ 15626 ¡ slug corpse examined ¡
--------------------------------------------------------------------------------------
function OnEvent_15626(proxy,param)
	print("OnEvent_15626 begin");
	proxy:SetEventFlag( 15626 , true );
	print("OnEvent_15626 end");
end

--------------------------------------------------------------------------------------
--¡775¡ôptSµ½¡ --EN:-- ¡ 775 ¡ sorceress died ¡
--------------------------------------------------------------------------------------
function OnEvent_775(proxy,param)
	print("OnEvent_775 begin");	
	proxy:SetEventFlag( 775 , true );
	print("OnEvent_775 end");
end

--------------------------------------------------------------------------------------
--¡15623¡ôptÌ²×½¡ --EN:--¡15623¡Examined the corpse of a sorceress¡
--------------------------------------------------------------------------------------
function OnEvent_15623(proxy,param)
	print("OnEvent_15623 begin");
	proxy:SetEventFlag( 15623 , true );
	print("OnEvent_15623 end");
end
