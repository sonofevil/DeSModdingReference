DAMAGE_REGION_ID__LEFT = 100;
DAMAGE_REGION_ID__RIGHT = 101;
EVENT_ID__DRAGON_DEAMON = 10;


ACTION_PATTERN__NONE				= 0; --何もしない --EN:--do nothing
ACTION_PATTERN__ATTACK_SWORD		= 1; --剣で攻撃 --EN:--Sword attack
ACTION_PATTERN__DEFENCE_SHIELD		= 2; --縦で防御 --EN:--Vertical defense
ACTION_PATTERN__ATTACK_BOW			= 3; --弓で攻撃 --EN:--Attack with bow
ACTION_PATTERN__RUSH				= 4; --突進 --EN:--rush
ACTION_PATTERN__ATTACK_BITE			= 5; --噛み付き --EN:--Bite
ACTION_PATTERN__THREAT				= 6; --威嚇 --EN:--Intimidation
ACTION_PATTERN__SHOUT				= 7; --雄たけび --EN:--Crying
ACTION_PATTERN__ATTACK_ROLLING_AXE	= 8; --回転斧 --EN:--Rotating ax
ACTION_PATTERN__DRAGON_R			= 9; --ドラゴン右 --EN:--Dragon right
ACTION_PATTERN__DRAGON_L			= 10 --ドラゴン左 --EN:--Dragon Left
ACTION_PATTERN__DRAGON_FIRE			= 11; --ドラゴンファイヤー --EN:--Dragon Fire

once = 1;
everytime = 0;


function Initialize_m99_99_99_50(proxy)
	print("テストマップ初期化"); --EN:print("initialize test map");
	proxy:OnRegionJustIn( 0, 0, DAMAGE_REGION_ID__LEFT, "OnDamageLeftArm", once );
	proxy:OnRegionJustIn( 0, 0, DAMAGE_REGION_ID__RIGHT, "OnDamageRightArm", once);
end

function OnDamageLeftArm(proxy, param)
	print("■左手破壊"); --EN:print("■ Left hand destruction");
	proxy:EnableAction( EVENT_ID__DRAGON_DEAMON, ACTION_PATTERN__DRAGON_L, false);
	
	--local boss = proxy:GetBoss( EVENT_ID__DRAGON_DEAMON);
	--boss:Damage_LeftArm();
end

function OnDamageRightArm(proxy, param)
	print("■右手破壊"); --EN:print("■ right hand destruction");
	proxy:EnableAction( EVENT_ID__DRAGON_DEAMON, ACTION_PATTERN__DRAGON_R, false);
	
	--local boss = proxy:GetBoss( EVENT_ID__DRAGON_DEAMON);
	--boss:Damage_RightArm();
end


