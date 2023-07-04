--決める夏 --EN:--Summer to decide

-------------------------------------------------------------------------------------------------------------------
--■決まりごと --EN:-- ■ Rules
--[[・距離の単位はメートル]] --EN:--[[・Distance unit is meter]]
--・時間の単位は秒 --EN:--・The unit of time is seconds
--・角度は中心とする軸から左右それぞれの数値。 --EN:--・The angle is a numerical value for each left and right from the center axis.
--　仮に60と設定すると、前方120°が有効な角度となる。 --EN:-- If set to 60, the effective angle is 120° forward.
-------------------------------------------------------------------------------------------------------------------

--▼通常会話 --EN:--▼ Normal conversation
TalkAngle_N	= 180.0;
TalkDist_N	= 3.0;

--▼宝箱(宝死体) --EN:--▼ Treasure Chest (Treasure Corpse)
ItemBoxAngle_A = 180.0;
ItemBoxDist_A  = 1.5;

--▼はしご --EN:--▼ Ladder
LadderAngle_A = 90.0;
LadderTime_A  = 0.2;

--▼レバー --EN:-- ▼ Lever
LeverAngle_A = 30;
LeverDist_A  = 1.5;

--▼ワープギミック --EN:--▼ Warp gimmick
WarpGimmickAngle_A = 90.0;  --石柱     → 各マップ のタイプ(正面からだけ) --EN:--Stone Pillar → Type of each map (front view only)
WarpGimmickDist_A  = 1.5;
WarpGimmickAngle_B = 180.0; --各マップ → 石柱     のタイプ(周囲どこでも) --EN:--each map → pillar type (anywhere around)

--▼扉 --EN:--▼ Door
DoorAngle_A = 90;  --片側扉用(スクリプト共通パラメータより) --EN:--For one side door (from script common parameter)
DoorDist_A  = 1.0;

--[[↓共通パラメータに既述なしのもの]] --EN:--[[↓Common parameters not mentioned]]

--▼ハンドル --EN:--▼Handle
HandleAngle_A = 60.0;
HandleDist_A  = 1.5;

HandleAngle_B = 40.0; --ハンドルBを回して歯車を動かす(水位が変わるイベント用) --EN:--Turn the handle B to move the gear (for events where the water level changes)
HandleDist_B  = 1.8;  --ハンドルBを回して歯車を動かす(水位が変わるイベント用) --EN:--Turn the handle B to move the gear (for events where the water level changes)

--▼跳ね橋 --EN:--▼ drawbridge
DrawBridgeAngle_A = 30.0;
DrawBridgeDist_A  = 1.5;

--▼かべ張り付き --EN:--▼ With wall sticking
WallAngle_A = 90.0;
WallTime_A = 0.5;

--▼床スイッチ --EN:--▼Floor switch
FloorSwitchDist_A = 1.5;

--▼ナメクジ --EN:--▼Slug
NamekujiAngle_A = 180.0;
NamekujiDist_A = 5.0;

--▼ボス死亡から次ブロックポリ劇再生までの待ち時間 --EN:--▼ Waiting time from boss death to next block polyplay play
BlockClear_RemoWait = 3.0;

--▼蛭デーモン(ヒルデーモン)のコアパーツのHp --EN:--▼Hp of the core parts of the leech demon
LeechDemon_Core_Hp	= 1800;

--▼蠅たかりデーモン(はえたかりデーモン)定数 --EN:--▼ Flycatcher daemon constants
FlyCrowdDemon_Core_Hp			= 2700;		--コアパーツのHp --EN:--Hp of core parts
FlyCrowdDemon_SpellReload_Low	= 15.0;		--蠅魔法の発射間隔(最短) --EN:-- Fly magic firing interval (shortest)
FlyCrowdDemon_SpellReload_High	= 20.0;		--蠅魔法の発射間隔(最長) --EN:--Fly magic firing interval (longest)

--▼不浄３の死体落下間隔の調整定数 --EN:--▼Adjustment constant of corpse fall interval of Impurity 3
M52_Corpse_FallWait_Low		= 10.0;		--落下間隔の調整定数(最短) --EN:--Adjustment constant of drop interval (shortest)
M52_Corpse_FallWait_High	= 20.0;		--落下間隔の調整定数(最長) --EN:--Adjustment constant for drop interval (maximum)

--▼死亡ペナルティの調整定数 --EN:--▼ Death Penalty Adjustment Constant
DeathPenalty_SoulAdjust			= 0;--1.0;	--死亡時のソウル減少計算調整値 --EN:--Soul Decrease Calculation Adjustment Value at Death
DeathPenalty_SoulMAX			= 0;--500;	--死亡時の減少ソウル最大値 --EN:--Maximum Soul Decrease at Death

--▼PKペナルティの調整定数 --EN:--▼PK penalty adjustment constant
PK_Soul_Penalty_Adjust		= 1.0;	--死亡時のソウル減少計算調整値 --EN:--Soul Decrease Calculation Adjustment Value at Death
PK_Soul_Penalty_MAX			= -1;	--死亡時の減少ソウル最大値(-1で上限なし) --EN:--Maximum soul loss at death (-1 with no upper limit)
PK_Soul_Penalty_BASE		= 25;	--基本値(パラメータの差分で倍になる値) --EN:--Base value (value doubled by parameter difference)
PK_Soul_Penalty_FIX			= 100;	--固定減少値(パラメータ差分調整値に関係なく、絶対に減らす量) --EN:--fixed decrement value (absolute amount to decrease regardless of parameter difference adjustment value)

--▼NPCが怒るダメージ割合 --EN:--▼Ratio of damage that NPC gets angry
NPC_ANGRY_Rate	= 0.2;

--▼汎用ダイアログを消す距離判定 --EN:--▼ Distance judgment to turn off the general-purpose dialog
GEN_DIALOG_DIST	= 2.0;

-------------------------------------------------------------------------------------------------------------------
--【システム定数】 --EN:-- [system constant]
-------------------------------------------------------------------------------------------------------------------
once 			= 1;
everytime 		= 0;
LOCAL_PLAYER	= 10000;
SYNCHROANIM		= 4013;
TURNTIME		= 0.05;
TURNSKIP_ANGLE	= 10;

-------------------------------------------------------------------------------------------------------------------
--【ItemType定数】 --EN:--[ItemType constant]
-------------------------------------------------------------------------------------------------------------------
TYPE_WEAPON		= 0;
TYPE_PROTECTER	= 268435456;
TYPE_ACCESSORY	= 536870912;
TYPE_GOODS		= 1073741824;
TYPE_MASK		= 4026531840;


-------------------------------------------------------------------------------------------------------------------
--【イベントヘルプID定数】 --EN:--[Event help ID constant]
-------------------------------------------------------------------------------------------------------------------

--▼調べる系(100番) --EN:--▼ Check system (No. 100)

HELPID_CHECK 				= 10010100;--汎用(?) --EN:--general purpose (?)
HELPID_CHECK_GLOWING_CORPS	= 10010101;--光を放つ死体を調べる(レア) --EN:-- Examine glowing corpses (rare)
HELPID_CHECK_CORPS			= 10010102;--死体を調べる(通常) --EN:--examine the corpse (normal)
HELPID_PICK_ITEM            = 10010103;--アイテムを拾う(ボスアイテム用?) --EN:--pick up items (for boss items?)

--▼話す系(200番) --EN:--▼ Talking system (No. 200)

HELPID_TALK 				= 10010200;--汎用(?) --EN:--general purpose (?)
HELPID_TALK_WAR				= 10010201;--戦士と話す --EN:--talk to warrior
HELPID_TALK_HUN				= 10010202;--狩人と話す --EN:--Talk to the hunter
HELPID_TALK_CLE				= 10010203;--僧侶と話す --EN:--Talk to the monk
HELPID_TALK_MAG				= 10010204;--魔術師と話す --EN:--Talk to the sorcerer
HELPID_TALK_SWO				= 10010205;--刀鍛冶と話す --EN:--Talk to the swordsmith

--▼昇降系(300番)　Mapアクション系 --EN:--▼ Elevating system (300) map action system

HELPID_UP					= 10010300;--登る --EN:--climb
HELPID_DOWN					= 10010301;--降りる --EN:--get off

HELPID_WALL					= 10010303;--？壁張り付きようのヘルプ --EN:--? Help with wall hanging


--▼扉系(400番) --EN:--▼ Door system (No. 400)

HELPID_OPEN					= 10010400;--開く --EN:--open
HELPID_CLOSE				= 10010401;--閉める --EN:--close
HELPID_REMOVE				= 10010402;--外す --EN:--remove

--▼ギミック作動系(500番) --EN:--▼ Gimmick actuation system (No. 500)

HELPID_START				= 10010500;--作動させる --EN:--operate
HELPID_PULL_LEVER			= 10010501;--レバーを引く --EN:--pull the lever
HELPID_PUSH_LEVER			= 10010502;--レバーを押す --EN:--press the lever
HELPID_TURN_HANDLE			= 10010503;--ハンドルを回す --EN:--turn the handle

--▼ワープ用(600番)(新) --EN:--▼ For Warp (No. 600) (New)
HELPID_CHECK_OUJOU			= 10010650;--王城要石調べる	 --EN:-- Examine the royal castle keystone
HELPID_CHECK_HURUTORIDE		= 10010651;--古砦要石調べる --EN:--Examine the old fort keystone
HELPID_CHECK_ROUJOU			= 10010652;--牢城要石調べる --EN:-- Examine the keystone of the prison
HELPID_CHECK_HUJOU			= 10010653;--不浄要石調べる --EN:-- Examine the impure keystone
HELPID_CHECK_KOUDOU			= 10010654;--坑道要石調べる --EN:--examine tunnel keystone
HELPID_CHECK_HOKUGEN		= 10010655;--北限要石調べる --EN:--Examine the northern limit keystone

--▼ワープ用(600番)(旧) --EN:--▼ For warp (No. 600) (Old)
--[[
HELPID_GO_TO_OUJOU			= 10010600;--王城1へ行く --EN:--Go to Castle 1
HELPID_GO_TO_OUJOU_2		= 10010608;--王城2へ行く --EN:--Go to Royal Castle 2
HELPID_GO_TO_OUJOU_3		= 10010614;--王城3へ行く --EN:--Go to Castle 3
HELPID_GO_TO_OUJOU_4		= 10010620;--王城4へ行く --EN:--Go to Royal Castle 4

HELPID_GO_TO_HURUTORIDE		= 10010601;--古砦1へ行く --EN:--Go to Fort 1
HELPID_GO_TO_HURUTORIDE_2	= 10010609;--古砦2へ行く --EN:--Go to Old Fort 2
HELPID_GO_TO_HURUTORIDE_3	= 10010615;--古砦3へ行く --EN:--Go to Old Fort 3

HELPID_GO_TO_ROUJOU			= 10010602;--牢城1へ行く --EN:--Go to Prison 1
HELPID_GO_TO_ROUJOU_2		= 10010610;--牢城2へ行く --EN:--Go to Prison 2
HELPID_GO_TO_ROUJOU_3		= 10010616;--牢城3へ行く --EN:--Go to Prison 3

HELPID_GO_TO_HUJOU			= 10010603;--不浄1へ行く --EN:--Go to Unholy 1
HELPID_GO_TO_HUJOU_2		= 10010611;--不浄2へ行く --EN:--Go to Unholy 2
HELPID_GO_TO_HUJOU_3		= 10010617;--不浄3へ行く --EN:--Go to Unholy 3

HELPID_GO_TO_KOUDOU			= 10010604;--坑道1へ行く --EN:--Go to Tunnel 1
HELPID_GO_TO_KOUDOU_2		= 10010612;--坑道2へ行く --EN:--Go to Tunnel 2
HELPID_GO_TO_KOUDOU_3		= 10010618;--坑道3へ行く --EN:--Go to Mine 3

HELPID_GO_TO_HOKUGEN		= 10010605;--北限1へ行く --EN:--go to northern limit 1
HELPID_GO_TO_HOKUGEN_2		= 10010613;--北限2へ行く --EN:--go to northern limit 2
HELPID_GO_TO_HOKUGEN_3		= 10010619;--北限3へ行く --EN:--Go to Northern Limit 3
]]
HELPID_GO_TO_SEKITYUU       = 10010606;--石柱へ行く --EN:--go to stone pillar
HELPID_GO_TO_IN				= 10010403;--中に入る --EN:--go inside
HELPID_GO_TO_OUT			= 10010404;--外に出る --EN:--I go outside

--▼ソウルサイン --EN:--▼ Soul Sign

HELPID_TOUCH_SOUL_SIGN			= 50000000;--ソウルサインに触れる --EN:--touching soul signs
HELPID_SOUL_SIGN_ACTIVATED		= 50000001;--ソウルサイン発動中 --EN:--Soul sign in action
HELPID_TOUCH_BLOOD_MESSAGE		= 50000100;--血文字に触れる --EN:--touching blood letters
HELPID_BLOOD_MESSAGE_ACTIVATED	= 50000101;--血文字発動中 --EN:--blood letter in progress

HELPID_OPENCAMPMENU 			= 10010150;--キャンプメニュー表示 --EN:--Camping menu display
-------------------------------------------------------------------------------------------------------------------
--【プレイヤーアニメーションID定数】(よく使うのだけ) --EN:--[Player animation ID constant] (only for frequent use)
-------------------------------------------------------------------------------------------------------------------

--▼アニメーションID▼ --EN:--▼Animation ID▼
ANIMEID_WALK		= 7410;	--歩く(光の霧通過用) --EN:--Walk (for light fog passage)

ANIMEID_PICK 		= 7520;	--拾う --EN:--pick up
ANIMEID_KICK		= 7400;	--蹴る --EN:--Kick

ANIMEID_OPEN		= 7401;	--開ける --EN:--Open
ANIMEID_CLOSE		= 7402;	--閉める --EN:--close

ANIMEID_PULL_LEVER	= 8000;	--レバーを引く --EN:--pull the lever
ANIMEID_PUSH_LEVER	= 8000;	--レバーを押す　	--レバーを引くを代用 --EN:--Press the lever --Pull the lever instead
ANIMEID_TURN_HANDLE	= 8010;	--ハンドルを回す --EN:--turn the handle

ANIMEID_BARISTA_GRASP      = 8100;--バリスタ掴む --EN:--grab the barista
ANIMEID_BARISTA_GRASP_KEEP = 8110;--バリスタ掴み待機 --EN:--Waiting for barista grabbing
ANIMEID_BARISTA_AWAY       = 8120;--バリスタ放す --EN:--barista release


--▼アニメーション終了までにかかる時間▼(再生フレーム/FPS) --EN:--▼The time it takes to finish the animation▼(playback frames/FPS)
_GAME_FPS = 30;

ANIMEID_PICK_TIME	= (75.0 / _GAME_FPS); --落下で代用 --EN:--substitute by fall
ANIMEID_KICK_TIME	= (50.0 / _GAME_FPS);

ANIMEID_OPEN_TIME	= (80.0 / _GAME_FPS);
ANIMEID_CLOSE_TIME	= (60.0 / _GAME_FPS);

ANIMEID_PULL_LEVER_TIME  = (80.0 / _GAME_FPS);
ANIMEID_PUSH_LEVER_TIME  = (80.0 / _GAME_FPS); --レバーを引くで代用 --EN:--substitute by pulling the lever
ANIMEID_TURN_HANDLE_TIME = (60.0 / _GAME_FPS);

-------------------------------------------------------------------------------------------------------------------
--【サウンドバンクID】 --EN:--[Sound Bank ID]
-------------------------------------------------------------------------------------------------------------------
SOUND_TYPE_A		=  0; --a:環境音 --EN:--a: environmental sound
SOUND_TYPE_C		=  1; --c:キャラモーション --EN:--c: character motion
SOUND_TYPE_F		=  2; --f:メニューSE --EN:--f: Menu SE
SOUND_TYPE_O		=  3; --o:オブジェクト --EN:--o: object
SOUND_TYPE_P		=  4; --p:ポリ劇専用SE --EN:--p: SE for polyplay
SOUND_TYPE_S		=  5; --s:SFX
SOUND_TYPE_M		=  6; --m:BGM
SOUND_TYPE_V		=  7; --v:音声 --EN:--v: audio
SOUND_TYPE_X		=  8; --x:床材質依存 --EN:--x: depends on floor material
SOUND_TYPE_B		=  9; --b:鎧材質依存 --EN:--b: depends on armor material
SOUND_TYPE_G		= 10; --g:ゴースト --EN:--g: Ghost

-------------------------------------------------------------------------------------------------------------------
--【プレイヤーの状態定数】 --EN:--【Player state constant】
-------------------------------------------------------------------------------------------------------------------

CHR_TYPE_LivePlayer	= 0; --生存プレイヤー --EN:--survival player
CHR_TYPE_GreyGhost  = 8; --グレイゴースト(通常ゴースト) --EN:--Gray Ghost (Normal Ghost)
CHR_TYPE_WhiteGhost = 1; --ホワイトゴースト(友好ゴースト) --EN:--White Ghost (Friendship Ghost)
CHR_TYPE_BlackGhost = 2; --ブラックゴースト(敵対ゴースト) --EN:--Black Ghost (Hostile Ghost)


-------------------------------------------------------------------------------------------------------------------
--【チームタイプ定数】 --EN:--【Team type constant】
-------------------------------------------------------------------------------------------------------------------
TEAM_TYPE_None 			= 0;--無効 --EN:--invalid
TEAM_TYPE_Live			= 1;--生存プレイヤー --EN:--survival player
TEAM_TYPE_WhiteGhost	= 2;--ホワイトゴースト --EN:--White Ghost
TEAM_TYPE_BlackGhost	= 3;--ブラックゴースト --EN:--Black Ghost
TEAM_TYPE_GlayGhost		= 4;--グレイゴースト --EN:--Gray Ghost
TEAM_TYPE_WanderGhost	= 5;--徘徊ゴースト --EN:--Wandering Ghost
TEAM_TYPE_Enemy			= 6;--敵 --EN:--enemy
TEAM_TYPE_Boss			= 7;--強敵 --EN:--Formidable enemy
TEAM_TYPE_Friend		= 8;--味方 --EN:--Allies
TEAM_TYPE_AngryFriend	= 9;--味方（怒） --EN:--Friend (angry)
TEAM_TYPE_DecoyEnemy	= 10;--おとり敵（腐敗人） --EN:--decoy enemy (corrupt)
TEAM_TYPE_BloodChild	= 11;--赤子 --EN:--baby
TEAM_TYPE_BattleFriend	= 12;--戦う味方 --EN:--fighting allies

-------------------------------------------------------------------------------------------------------------------
--【メッセージカテゴリID】--エクセルファイルの識別に使われる --EN:--【Message Category ID】--Used to identify the Excel file
-------------------------------------------------------------------------------------------------------------------
MSG_CATEGORY_SAMPLE		=  0;--サンプル --EN:--sample
MSG_CATEGORY_TALK		=  1;--会話 --EN:--conversation
MSG_CATEGORY_BLOOD		=  2;--血文字 --EN:--blood letters
MSG_CATEGORY_ITEM		= 10;--アイテム --EN:--item
MSG_CATEGORY_WEP		= 11;--武器 --EN:--weapon
MSG_CATEGORY_PRO		= 12;--防具 --EN:--armor
MSG_CATEGORY_ACC		= 13;--アクセサリー --EN:--accessories
MSG_CATEGORY_ITEM_EXP	= 20;--アイテム説明 --EN:--Item description
MSG_CATEGORY_WEP_EXP	= 21;--武器説明 --EN:--Weapon Description
MSG_CATEGORY_PRO_EXP	= 22;--防具説明 --EN:--Armor Description
MSG_CATEGORY_ACC_EXP	= 23;--アクセサリー説明 --EN:--Accessory description
MSG_CATEGORY_EVENT		= 30;--イベントテキスト --EN:--event text
MSG_CATEGORY_DIALOG		= 78;--ダイアログ --EN:--dialog


-------------------------------------------------------------------------------------------------------------------
--【システムで使用するアクションID】-- --EN:--[Action ID used by the system]--
-------------------------------------------------------------------------------------------------------------------
SYSTEM_ID_IGNORE		= 4048;
IGNORE_TIME				= 3.0;
SYSTEM_WARP				= 4052;--ワープアニメの繋ぎ用ID --EN:-- ID for connecting warp animation
SYSTEM_CHECK_POINT		= 4054;--チェックポイント通過 --EN:--Checkpoint pass
SYSTEM_GENDIALOG		= 4061;--汎用ダイアログ距離判定用 --EN:--For general-purpose dialog distance judgment

-------------------------------------------------------------------------------------------------------------------
--【インフォメーションメニューの表示タイプ】 --EN:-- [Information menu display type]
-------------------------------------------------------------------------------------------------------------------
INFOMENU_TYPE_LIST		= 0;--行を追加できる通常タイプ。 --EN:--Normal type that can add lines.
INFOMENU_TYPE_SIMPLE	= 1;--タイトルとシステム欄のみの簡易タイプ --EN:--Simple type with only title and system column


-------------------------------------------------------------------------------------------------------------------
--【OnObjectDamageHit ヒット対象識別用定数】 --EN:--[OnObjectDamageHit hit target identification constant]
-------------------------------------------------------------------------------------------------------------------
EV_HIT_CHR = 1;--キャラが対象 --EN:-- for characters
EV_HIT_HIT = 2;--マップが対象 --EN:--maps
EV_HIT_ALL = 3;--キャラとマップが対象 --EN:--Applies to characters and maps

-------------------------------------------------------------------------------------------------------------------
--【職業用定数】 --EN:--【Occupational constant】
-------------------------------------------------------------------------------------------------------------------

JOB_LOW_SOLDIER		= 0;--下級兵士	生まれ／戦士チュートリアル --EN:--Lower Soldier Born/Warrior Tutorial
JOB_LOW_KNIGHT		= 1;--下級騎士	生まれ／戦士チュートリアル --EN:--Lower Knight Born/Warrior Tutorial
JOB_HUNTER			= 2;--狩人		生まれ／狩人チュートリアル --EN:--Born to be a Hunter/Hunter Tutorial
JOB_CLERIC			= 3;--神職		生まれ／僧侶チュートリアル --EN:--Birth of a Shinto priest / Monk Tutorial
JOB_SHAMAN			= 4;--呪師		生まれ／魔術師チュートリアル --EN:--Sorcerer Born/Magician Tutorial
JOB_NEET			= 5;--放浪者	生まれ／戦士チュートリアル --EN:--Wanderer Born/Warrior Tutorial
JOB_MERCENARY		= 6;--蛮族		生まれ／戦士チュートリアル --EN:--Barbarian Born/Warrior Tutorial
JOB_THIEF			= 7;--盗賊		生まれ／狩人チュートリアル --EN:--Birth of a Thief/Hunter Tutorial
JOB_TEMPLE_KNIGHT	= 8;--神殿騎士	生まれ／僧侶チュートリアル --EN:--Temple Knight Born/Monk Tutorial
JOB_NOBLEMAN		= 9;--貴族		生まれ／魔術師チュートリアル --EN:--Born in Nobility/Magician Tutorial





-------------------------------------------------------------------------------------------------------------------
--【OnObjectDamageHit 属性ダメージ指定用】 --EN:--[OnObjectDamageHit for specifying attribute damage]
-------------------------------------------------------------------------------------------------------------------
DAMAGE_TYPE_NONE = -1;--無属性 --EN:--Non-attribute
DAMAGE_TYPE_FIRE = 10;--炎属性 --EN:--Flame attribute

-------------------------------------------------------------------------------------------------------------------
--【発動属性】 --発動をプレイヤの状態によって制限できる --EN:--[Activation attribute] --Activation can be restricted by the player's state
-------------------------------------------------------------------------------------------------------------------
ATTR_SESSION 	=   1;
ATTR_NOSESSION	=   2;
ATTR_HOST		=   4;
ATTR_CLIENT		=   8;
ATTR_LIVE		=  16;
ATTR_GREY		=  32;
ATTR_WHITE		=  64;
ATTR_BLACK		= 128;
ATTR_ALL		= 255;

-------------------------------------------------------------------------------------------------------------------
--【イベント会話の設定フラグ】 --会話の設定フラグ関連 --EN:--[Event conversation setting flag] --Conversation setting flag related
-------------------------------------------------------------------------------------------------------------------
TALK_ATTR_REPEAT 	=   1;
TALK_ATTR_PAD		=   2;
TALK_ATTR_DRAW		=   4;
TALK_ATTR_VOICE		=   8;
TALK_ATTR_ALL		= 255;

-------------------------------------------------------------------------------------------------------------------
--【タグインデックス】 --メッセージにプレイヤ名を入れ込む際に、タグの属性を指定する必要がある --EN:--[Tag index] --When inserting the player name in the message, it is necessary to specify the tag attribute
-------------------------------------------------------------------------------------------------------------------
TAG_IDX_liveChara 		= 0;
TAG_IDX_joinChara 		= 1;
TAG_IDX_deadChara 		= 2;
TAG_IDX_leaveChara 		= 3;

-------------------------------------------------------------------------------------------------------------------
--【ポリ劇コールバックハンドラ定数】 --EN:--[Polyplay callback handler constant]
--RequestRemo(scnId,nflag,cbArgA,cbArgB) 
--cbArgAに指定した数値がハンドラのイベントIDで利用される。 --EN:The value specified in --cbArgA is used for the event ID of the handler.
--cbArgBに1以上を指定した場合必ずハンドラがコールされます。 --EN:If 1 or more is specified for --cbArgB, the handler is always called.
--コールされるハンドラのパラム設定は以下を参照 --EN:-- See below for the parameter setting of the handler to be called
-------------------------------------------------------------------------------------------------------------------
REMO_START		=10;		--ポリ劇開始(フェード終了時 --EN:-- Poly drama start (at the end of fade
REMO_FINISH		=100;			--ポリ劇終了 --EN:--End of police drama

-------------------------------------------------------------------------------------------------------------------
--【ポリ劇フラグ定数】 --EN:--[Poly drama flag constant]
--マルチ時にスキップ不可、シングル時には通常になります --EN:--Cannot be skipped in multiplayer, normal in single
-------------------------------------------------------------------------------------------------------------------
REMO_FLAG		=0;

-------------------------------------------------------------------------------------------------------------------
--【ムービー指定定数】 --EN:--[movie specification constant]
-------------------------------------------------------------------------------------------------------------------
MOVIE_ADVERTISE 	= 0;	--アドバタイズムービー --EN:--Advertisement movie
MOVIE_TITLE			= 1;	--タイトルムービー --EN:--Title movie
MOVIE_OPENING		= 2;	--オープニングムービー --EN:--Opening movie
MOVIE_STAFFROLL		= 3;	--スタッフロールムービー --EN:--Staff roll movie
MOVIE_ENDING_BAD	= 4;	--バッドエンディングムービー --EN:--Bad ending movie
MOVIE_ENDING_GOOD	= 5;	--グッドエンディングムービー --EN:--Good ending movie
MOVIE_OLDTALE		= 6;	--昔話ムービー --EN:--Folk tale movie


-------------------------------------------------------------------------------------------------------------------
--【クリア定数】 --EN:--[clear constant]
-------------------------------------------------------------------------------------------------------------------
CLEAR_STATE_BADEND = 2;		--BadEnding
CLEAR_STATE_GOODEND = 1;	--GoodEnding

-------------------------------------------------------------------------------------------------------------------
--【10月末締め用調整定数】 --EN:--[Adjustment constant for closing at the end of October]
-------------------------------------------------------------------------------------------------------------------
NPCTIMER		=120;--単位(秒) --EN:--unit (seconds)
TEXT_TIMER      =0;--単位(秒) --EN:--unit (seconds)


-------------------------------------------------------------------------------------------------------------------
--【テキスト演出定数】 --EN:--[Text production constant]
-------------------------------------------------------------------------------------------------------------------
TEXT_TYPE_KillDemon		= 1;--デーモン撃破 --EN:-- Defeat Demon
TEXT_TYPE_Dead			= 2;--死亡 --EN:--death
TEXT_TYPE_Revival		= 3;--復活 --EN:--revival
TEXT_TYPE_SoulGet		= 4;--ソウル取得 --EN:--Obtain Soul
TEXT_TYPE_TargetClear	= 5;--目標撃破 --EN:--Target Destroyed
TEXT_TYPE_GhostDead		= 6;--ゴースト死亡 --EN:--Ghost Death
TEXT_TYPE_BlackClear	= 7;--ブラックゴースト撃破 --EN:-- Defeat Black Ghost

-------------------------------------------------------------------------------------------------------------------
--【ファランクス関連定数】 --EN:--[Phalanx related constants]
-------------------------------------------------------------------------------------------------------------------
--EzState命令定数 --EN:--EzState instruction constant
PHALANX_Core_ToGattai	= 100;		--合体状態へ移行 --EN:--Transition to combined state
PHALANX_Core_ToBousui	= 101;		--紡錘状態へ移行 --EN:--Transition to spindle state
PHALANX_Core_ToBunsan	= 102;		--分散状態へ移行 --EN:--Transition to decentralized state
PHALANX_Core_ToHitWall	= 103;		--壁に当たった --EN:--hit a wall
PHALANX_Core_ToClimb	= 104;		--斜め壁に上った --EN:--Climbed the diagonal wall
PHALANX_Core_ToTotugeki = 105;		--突撃準備 --EN:--Prepare to charge
PHALANX_Core_ToHitObj	= 106;		--OBJ小屋に当たった --EN:--Hit the OBJ hut

PHALANX_Jr_Wait			= 150;		--Jr待機 --EN:-- Wait for Jr.
PHALANX_Jr_MaruWait		= 151;		--Jrまるがた待機 --EN:--Jr Marugata waiting
PHALANX_Jr_Nezumi 		= 152;		--Jrハリネズミ開始 --EN:--Jr hedgehog start
PHALANX_Jr_AllYarinage	= 153;		--Jr全槍投げ --EN:--Jr All Javelin
PHALANX_Jr_TankiYari	= 154;		--Jr単騎槍攻撃 --EN:--Jr single javelin attack
PHALANX_Jr_TankiYarinage= 155;		--Jr単騎槍投げ --EN:--Jr single javelin throw
PHALANX_Jr_NormalBunsan = 156;		--Jr通常分散 --EN:--Jr normal distribution
PHALANX_Jr_KokeBunsan	= 157;		--Jr転倒分散 --EN:--Jr fall dispersion
PHALANX_Jr_KabeYari		= 158;		--Jr壁から槍の雨 --EN:--A rain of spears from the Jr wall
PHALANX_Jr_Totugeki		= 159;		--Jr突撃 --EN:-- Jr. Assault
PHALANX_Jr_MaruEnd		= 160;		--Jrまるがた待機終了 --EN:--Jr Marugata waiting end

--EzState戻り値定数 --EN:--EzState return value constant
RES_PHALANX_Nezumi_Start		=100;		--ハリネズミ攻撃開始 --EN:--Hedgehog attack start
RES_PHALANX_Nezumi_End			=101;		--ハリネズミ攻撃終了 --EN:-- End of hedgehog attack
RES_PHALANX_AllYarinageStart	=102;		--全槍射出攻撃開始 --EN:--Start all-spear firing attack
RES_PHALANX_AllYarinageEnd		=103;		--全槍射出攻撃終了 --EN:--End of all spear firing attack
RES_PHALANX_TankiYariStart		=104;		--単騎槍攻撃開始 --EN:--Start single spear attack
RES_PHALANX_TankiYariEnd		=105;		--単騎槍攻撃終了 --EN:--Single spear attack ends
RES_PHALANX_TankiYarinageStart	=106;		--単騎槍射出開始 --EN:--Start firing a single javelin
RES_PHALANX_TankiYarinageEnd	=107;		--単騎槍射出終了 --EN:--Single spear firing end
RES_PHALANX_KabeYariStart		=108;		--壁から槍の雨開始 --EN:--Spear rain starts from the wall
RES_PHALANX_KabeYariEnd			=109;		--壁から槍の雨終了 --EN:--End of rain of spears from the wall
RES_PHALANX_GattaiComp			=110;		--合体移行完了 --EN:--Combination transition complete
RES_PHALANX_BousuiComp			=111;		--紡錘移行完了 --EN:--Spindle transition complete
RES_PHALANX_BunsanComp			=112;		--分散移行完了 --EN:--Distributed migration completed
RES_PHALANX_TotugekiStart		=113;		--突進開始 --EN:-- start charging
RES_PHALANX_TotugekiEnd			=114;		--突撃終了 --EN:-- end of assault
RES_PHALANX_TotugekiStop		=115;		--突進停止終了 --EN:--Rush stop end

--EzState戻り値定数 --EN:--EzState return value constant
RES_PHALANX_JR_Wait				= 150;		--通常待機開始 --EN:--Normal standby start
RES_PHALANX_JR_MaruWait			= 151;		--まるがた待機開始 --EN:-- Marugata waiting start



JR_STATE_Normal			=0;--通常 --EN:--generally
JR_STATE_ToCore			=1;--コアを目指した移動 --EN:--Moving towards the core
JR_STATE_HoverMove		=2;--コア到達＞ダミポリへの移動 --EN:--Achieve core > move to Damipoli
JR_STATE_DmyHover		=3;--ダミポリへの移動＞ホバー吸着 --EN:--Move to dummy poly > Hover adsorption
JR_STATE_DmyAttach		=4;--ダミポリ接着 --EN:--Dummy poly adhesive
--JR_STATE_DmyDettach--ダミポリ切り離し --EN:--Damipoly detachment
JR_STATE_HavokFly		=5;--Havok剥がし --EN:--Havok stripping
JR_STATE_Single			=6;--一人身更新 --EN:--Single Renewal
JR_STATE_Dead			=7;--Jr死亡 --EN:--Jr died

JR_BaseDmyPolyMoveWait	= 8;--ダミポリ間移動の基本値 --EN:--Basic values for movement between dummy polys
PHALANX_MaxReturnCount	= 3;--戻り状態の最大値 --EN:--max return status
 


--PT解散までの時間 --EN:--Time until PT disband
CLEAR_TIMEOUT = 10.0;

-------------------------------------------------------------------------------------------------------------------
--【イベント監視属性値】--ここに書いておくと、ソースを開かなくても属性値の意味が確認が出来る為記述。実際にスクリプトで使うことはありません。 --EN:--[Event monitoring attribute value]--If you write it here, you can check the meaning of the attribute value without opening the source. It is never actually used in scripts.
-------------------------------------------------------------------------------------------------------------------
--EVENT_OBSERVE_DIST_PLAYER	=  0;		//!<	距離	 --EN:--EVENT_OBSERVE_DIST_PLAYER = 0; //!< distance
--EVENT_REGION_ACTION		=  2;		//!<	領域内で入力 --EN:--EVENT_REGION_ACTION = 2; //!< Enter in region
--EVENT_REGION_IN			=  3;		//!<	領域に入っている --EN:--EVENT_REGION_IN = 3; //!< Entering region
--EVENT_REGION_JUSTIN		=  4;		//!<	領域に入った瞬間 --EN:--EVENT_REGION_JUSTIN = 4; //!< Moment of entering the region
--EVENT_REGION_JUSTOUT		=  5;		//!<	領域を出た瞬間 --EN:--EVENT_REGION_JUSTOUT = 5; //!< The moment you leave the region
--EVENT_DIST_ACTION			=  6;		//!<	距離内で角度内での入力 --EN:--EVENT_DIST_ACTION = 6; //!< Input within angle within distance
--EVENT_DIST_IN				=  7;		//!<	範囲内 --EN:--EVENT_DIST_IN = 7; //!< in range
--EVENT_DIST_OUT			=  8;		//!<	範囲から外れる --EN:--EVENT_DIST_OUT = 8; //!< out of range
--EVENT_DIST_ANGLE			=  9;		//!<	距離内で角度内 --EN:--EVENT_DIST_ANGLE = 9; //!< Distance Within Angle
--EVENT_KEYFRAME_ONCE		= 10;		//!<	キーフレーム時 --EN:--EVENT_KEYFRAME_ONCE = 10; //!< On keyframe
--EVENT_KEYFRAME_EVERYTIME	= 11;		//!<	キーフレームまで --EN:--EVENT_KEYFRAME_EVERYTIME = 11; //!< until keyframe
--EVENT_CALL				= 12;		//!<	イベントコール --EN:--EVENT_CALL = 12; //!< event call
--EVENT_HP					= 13;		//!<	HP
--EVENT_DEAD				= 14;		//!<	完全死亡(死亡アニメの終了まで監視) --EN:--EVENT_DEAD = 14; //!< Complete death (watch until death animation ends)
--EVENT_KEYTIME_ONCE		= 15;		//!<	秒後 --EN:--EVENT_KEYTIME_ONCE = 15; //!< seconds later
--EVENT_KEYTIME_EVERYTIME	= 16;		//!<	秒間 --EN:--EVENT_KEYTIME_EVERYTIME = 16; //!< seconds
--EVENT_ANIME_END			= 17;		//!<	アニメーション終了 --EN:--EVENT_ANIME_END = 17; //!< Animation end
--EVENT_OBJECT_DESTROYED	= 18;		//!<	OBJ破壊 --EN:--EVENT_OBJECT_DESTROYED = 18; //!< OBJ destroyed
--TALKEVENT_DIST_ACTION		= 19;		//!<	距離内かつ角度内での入力(会話用) --EN:--TALKEVENT_DIST_ACTION = 19; //!< Input within distance and angle (for conversation)
--TALKEVENT_DIST_IN			= 20;		//!<	距離内(会話用) --EN:--TALKEVENT_DIST_IN = 20; //!< within distance (for conversation)
--TALKEVENT_DIST_OUT		= 21;		//!<	距離内からでた(会話用) --EN:--TALKEVENT_DIST_OUT = 21; //!< Within distance (for conversation)
--TALKEVENT_DIST_ANGLEOUT	= 22;		//!<	距離内で角度が外れた(会話用) --EN:--TALKEVENT_DIST_ANGLEOUT = 22; //!< Angle out within distance (for conversation)
--TALKEVENT_ANGLE			= 23;		//!<	距離内、角度内 --EN:--TALKEVENT_ANGLE = 23; //!< within distance, within angle
--EVENT_SIMPLEDAMAGE		= 24;		//!<	ダメージイベント	 --EN:--EVENT_SIMPLEDAMAGE = 24; //!< damage event
--EVENT_TURN				= 25;		//!<	旋回 --EN:--EVENT_TURN = 25; //!< turn
--EVENT_REGIST_FUNC			= 26;		//!<	ルアー関数監視 --EN:--EVENT_REGIST_FUNC = 26; //!< Lure function watch
--EVENT_OBJ_DAMAGE			= 27;		//!<	オブジェクトのダメージ球監視 --EN:--EVENT_OBJ_DAMAGE = 27; //!< Object damage ball monitoring
--EVENT_KEEPACTIONID		= 28;		//!<	EzStateに命令を送り続ける用 --EN:--EVENT_KEEPACTIONID = 28; //!< To keep sending commands to EzState
--EVENT_EZSTATEMESSAGE		= 29;		//!<	EzStateの命令監視 --EN:--EVENT_EZSTATEMESSAGE = 29; //!< Instruction monitoring of EzState
--EVENT_KEYCHECK			= 30;		//!<	キー入力の監視 --EN:--EVENT_KEYCHECK = 30; //!< Monitor key input
--EVENT_ITEM				= 31;		//!<	アイテム取得 --EN:--EVENT_ITEM = 31; //!< Get item
--EVENT_PK					= 32;		//!<	PKの監視 --EN:--EVENT_PK = 32; //!< PK monitoring
--EVENT_SELF_BLOODMARK		= 33;		//!<	自分の血文字 --EN:--EVENT_SELF_BLOODMARK = 33; //!< Your blood letter
--EVENT_SESSION_JUSTIN		= 34;		//!<	セッション繋いだ瞬間 --EN:--EVENT_SESSION_JUSTIN = 34; //!< The moment the session is connected
--EVENT_SESSION_IN			= 35;		//!<	セッション中 --EN:--EVENT_SESSION_IN = 35; //!< in session
--EVENT_SESSION_JUSTOUT		= 36;		//!<	セッション切れた瞬間 --EN:--EVENT_SESSION_JUSTOUT = 36; //!< The moment the session expired
--EVENT_SESSION_OUT			= 37;		//!<	セッション無し --EN:--EVENT_SESSION_OUT = 37; //!< No session
--EVENT_BLOODMENU			= 38;		//!<	血文字作成メニューの監視 --EN:--EVENT_BLOODMENU = 38; //!< Monitor blood letter creation menu
--EVENT_SOSMENU				= 39;		//!<	SOS作成メニューの監視 --EN:--EVENT_SOSMENU = 39; //!< Monitor SOS creation menu
--EVENT_ASSESSMENU			= 40;		//!<	評価メニューの監視 --EN:--EVENT_ASSESSMENU = 40; //!< Monitor assessment menu
--EVENT_WAPRMENU			= 41;		//!<	ワープメニューの監視 --EN:--EVENT_WAPRMENU = 41; //!< Warp menu monitoring
--EVENT_BODYDAM				= 42;		//!<	部位ダメージの監視 --EN:--EVENT_BODYDAM = 42; //!< Monitor body part damage


-------------------------------------------------------------------------------------------------------------------
--■NPC状態定数 --EN:-- ■ NPC state constant
-------------------------------------------------------------------------------------------------------------------

--[[【ロガーン】の状態(牢城・石柱兼用)]] --EN:--[[[Logan] status (for both prison and stone pillars)]]
ROGARN_STATE_PRISONER		= 16190;--囚われ --EN:-- Captive
ROGARN_STATE_WAIT			= 16191;--石柱で待つ --EN:--Waiting at the stone pillar
ROGARN_STATE_ANGRY_M4		= 16192;--敵対(牢城) --EN:-- Hostility (Prison)
ROGARN_STATE_ANGRY_M1		= 16193;--敵対(石柱) --EN:-- Hostility (Stone Pillar)
ROGARN_STATE_DEAD			= 16194;--死亡 --EN:--death
ROGARN_STATE_GO_M1			= 16195;--石柱に行きたい --EN:--I want to go to the stone pillar
ROGARN_STATE_LAST_WARD		= 16196;--最後の言葉を伝えたい(石柱) --EN:-- I want to say the last words (Stone Pillar)
rogarn_flag_list = {
	ROGARN_STATE_PRISONER,
	ROGARN_STATE_WAIT,
	ROGARN_STATE_ANGRY_M4,
	ROGARN_STATE_ANGRY_M1,
	ROGARN_STATE_DEAD,
	ROGARN_STATE_GO_M1,
	ROGARN_STATE_LAST_WARD
};
TOTALDAMAGE_ROGARN_M40 = 50;--【ロガーン】敵対蓄積ダメージ --EN:--[Logan] Hostile Accumulated Damage




--[[【元貴族婦人】の状態]] --EN:--[[[Ex-noble lady] status]]
NOBLE_WOMAN_STATE_BUSINESS	= 16210;--商売中 --EN:-- in business
NOBLE_WOMAN_STATE_ANGRY		= 16211;--敵対 --EN:--hostile
NOBLE_WOMAN_STATE_DEAD		= 16212;--死亡 --EN:--death
noble_woman_flag_list = {
	NOBLE_WOMAN_STATE_BUSINESS,
	NOBLE_WOMAN_STATE_ANGRY,
	NOBLE_WOMAN_STATE_DEAD,
};
TOTALDAMAGE_NOBLE_WOMAN = 50;--【元貴族婦人】敵対蓄積ダメージ --EN:--[Former Noble Lady] Hostile Accumulated Damage





--[[【ユルト】の状態(牢城、石柱兼用)]] --EN:--[[[Yurt] status (both prison and stone pillar)]]
YURUTO_STATE_LIFT			= 16220;--エレベータにいる --EN:--in the elevator
YURUTO_STATE_WAIT_M1		= 16221;--石柱にいる --EN:--At the stone pillar
YURUTO_STATE_ANGRY_M4		= 16222;--敵対(牢城) --EN:-- Hostility (Prison)
YURUTO_STATE_ANGRY_M1		= 16223;--敵対(石柱) --EN:-- Hostility (Stone Pillar)
YURUTO_STATE_DEAD			= 16224;--死亡 --EN:--death
YURUTO_STANDBY_M1			= 16225;--石柱に行く前 --EN:--Before going to the stone pillar
yuruto_flag_list = {
	YURUTO_STATE_LIFT,
	YURUTO_STATE_WAIT_M1,
	YURUTO_STATE_ANGRY_M4,
	YURUTO_STATE_ANGRY_M1,
	YURUTO_STATE_DEAD,
	YURUTO_STANDBY_M1,
};
TOTALDAMAGE_YURUTO_M40 = 50;--【ユルト】敵対蓄積ダメージ --EN:--[Yurt] Hostile Accumulated Damage

--[[【ビヨルングルム】状態一覧]] --EN:--[[[Bjrn Gurm] status list]]
BIYO_STATE_CAPTIVE					= 16060;--牢屋に囚われ --EN:--Captured in prison
BIYO_STATE_THANKS					= 16061;--解放してくれて感謝 --EN:--thank you for freeing me
BIYO_STATE_SLEEPING_IN_PRISON		= 16062;--牢屋で寝ている --EN:-- sleeping in jail
BIYO_STATE_HOSTILE_IN_PRISON		= 16063;--敵対(牢内) --EN:-- Hostility (in prison)
BIYO_STATE_DEAD						= 16064;--死亡(ビヨルン) --EN:--Death (Bjorn)
BIYO_STATE_TARGET_ENEMY				= 16065;--獄吏を倒したい --EN:--I want to defeat the jailer
BIYO_STATE_END_OF_STRIKES_BACK		= 16066;--逆襲が終わって満足して寝る --EN:--Sleep satisfied after the counterattack is over
BIYO_STATE_HOSTILE_IN_RAMPART		= 16067;--敵対(城壁) --EN:-- Hostility (Castle wall)
BIYO_STATE_SEARCH_3					= 16068;--王城3を探索 --EN:--Explore Ojo 3
BIYO_STATE_KING_OF_SWORD_KILL		= 16069;--王の剣を倒して満足 --EN:--Satisfied with defeating the King's sword
BIYO_STATE_HOSTILE_IN_KING_ROOM		= 16070;--敵対(王の剣の部屋) --EN:-- Hostility (King's Sword Room)
--BIYO_STATE_KING_ROOM_DOWN			= 16071;--王の剣の部屋で寝る --EN:--Sleeping in the King's Sword Room
BIYO_STATE_BATTLE_FLY_DRAGON		= 16072;--飛竜の長と戦う --EN:--Fight the Chief of the Wyvern
--BIYO_STATE_RETURN_TO_STONE_PILLAR	= 16073;--石柱に戻りたい --EN:--I want to go back to stone pillars
--BIYO_STATE_WAIT_M1					= 16074;--石柱にいる --EN:--At the stone pillar
BIYO_STATE_HOSTILE_IN_STONE_PILLAR	= 16075;--敵対(石柱) --EN:-- Hostility (Stone Pillar)
BIYO_STATE_HOSTILE_IN_GATE_FRONT	= 16076;--敵対(ゲート前) --EN:-- Hostile (before the gate)
BIYO_STATE_EXIT						= 16077;--もういない --EN:--is gone
biyo_flag_list = {
	BIYO_STATE_CAPTIVE					,
	BIYO_STATE_THANKS					,
	BIYO_STATE_SLEEPING_IN_PRISON		,
	BIYO_STATE_HOSTILE_IN_PRISON		,
	BIYO_STATE_DEAD						,
	BIYO_STATE_TARGET_ENEMY				,
	BIYO_STATE_END_OF_STRIKES_BACK		,
	BIYO_STATE_HOSTILE_IN_RAMPART		,
	BIYO_STATE_SEARCH_3					,
	BIYO_STATE_KING_OF_SWORD_KILL		,
	BIYO_STATE_HOSTILE_IN_KING_ROOM		,
--	BIYO_STATE_KING_ROOM_DOWN			,
	BIYO_STATE_BATTLE_FLY_DRAGON		,
--	BIYO_STATE_RETURN_TO_STONE_PILLAR	,
--	BIYO_STATE_WAIT_M1					,
	BIYO_STATE_HOSTILE_IN_STONE_PILLAR	,
	BIYO_STATE_HOSTILE_IN_GATE_FRONT	,
	BIYO_STATE_EXIT
};

--[[【魔女】状態一覧]] --EN:--[[[Witch] status list]]
MAJO_STATE_LIBERATE = 16110;--解放してほしい --EN:--I want you to release me
MAJO_STATE_BREAK    = 16111;--塔で休憩 --EN:--Take a break in the tower
MAJO_STATE_HOSTILE  = 16112;--敵対 --EN:--hostile
MAJO_STATE_DEAD     = 16113;--死亡 --EN:--death
MAJO_STATE_THANKS   = 16114;--感謝 --EN:-- thanks
MAJO_STATE_WAIT_M1	= 16115;--石柱にいる --EN:--At the stone pillar
MAJO_STATE_ANGRY_M1	= 16116;--敵対(石柱) --EN:-- Hostility (Stone Pillar)

majo_flag_list = {
	MAJO_STATE_LIBERATE	,
	MAJO_STATE_BREAK	,
	MAJO_STATE_HOSTILE	,
	MAJO_STATE_DEAD		,
	MAJO_STATE_THANKS	,
	MAJO_STATE_WAIT_M1	,
	MAJO_STATE_ANGRY_M1
};


--[[ウルベイン状態一覧]] --EN:--[[Ulbane status list]]
URUBAIN_STATE_HELP					= 16120;	--助けて欲しい状態 --EN:--Need help
URUBAIN_STATE_THANKS				= 16121;	--感謝している状態 --EN:--thankful state
URUBAIN_STATE_ANGRY					= 16122;	--怒っている --EN:--angry
URUBAIN_STATE_DEAD					= 16123;	--死んでいる --EN:--dead
URUBAIN_STATE_STONE_PILLAR			= 16124;	--石柱にいる --EN:--At the stone pillar
URUBAIN_STATE_STONE_PILLAR_ANGRY	= 16125;	--敵対(石柱) --EN:-- Hostility (Stone Pillar)
urubain_flag_list = {
	URUBAIN_STATE_HELP				,
	URUBAIN_STATE_THANKS			,
	URUBAIN_STATE_ANGRY				,
	URUBAIN_STATE_DEAD				,
	URUBAIN_STATE_STONE_PILLAR		,
	URUBAIN_STATE_STONE_PILLAR_ANGRY
};

--ウルベイン蓄積ダメージ --EN:--Ulbane Accumulated Damage
TOTALDAMAGE_URUBAIN = 50;

--[[バッチ状態一覧]] --EN:--[[Batch status list]]
BATTI_NOT_STAY		= 16240;--まだどこにもいない --EN:--not yet anywhere
BATTI_COME 			= 16241;--来て欲しい(古砦) --EN:--I want you to come (Old Fort)
BATTI_PUSHING 		= 16242;--突き落としたい(古砦) --EN:--I want to push you down (Old Fort)
BATTI_SATISFIED 	= 16243;--満足(古砦) --EN:--Satisfaction (Old Fort)
BATTI_ANGRY 		= 16244;--怒っている(古砦) --EN:--Angry (Old Fort)
BATTI_DEAD 			= 16245;--死んでいる --EN:--dead
BATTI_TRAP_M6		= 16246;--罠にはめたい(坑道) --EN:--I want to be caught in a trap (pit)
BATTI_TREASURE_M6	= 16247;--宝は頂いた(坑道) --EN:--Treasure received (pit)
BATTI_VEXING_M6		= 16248;--残念(坑道) --EN:--Sorry (Tunnel)
BATTI_ANGRY_M6		= 16249;--敵対(坑道) --EN:-- Hostility (Tunnel)
BATTI_DESTORYKUMA	= 16250;--クマムシ撃破(坑道) --EN:-- Defeat Water Bear (Mine)
BATTI_PRESENT		= 16251;--アイテムをあげた(坑道) --EN:--Give an item (Mine Tunnel)
BATTI_SATISFIED_M4	= 16252;--満足(牢城) --EN:--satisfaction (prison)
BATTI_VEXING_M4		= 16253;--残念(牢城) --EN:--Sorry (prison)
BATTI_ANGRY_M4 		= 16254;--敵対(牢城) --EN:-- Hostility (Prison)
BATTI_RESERVE_M1	= 16255;--出撃準備中(石柱) --EN:--Preparing for sortie (stone pillar)
BATTI_ANGRY_M1		= 16256;--敵対(石柱) --EN:-- Hostility (Stone Pillar)
batti_flag_list = {
	BATTI_NOT_STAY		,
	BATTI_COME			,
	BATTI_PUSHING		,
	BATTI_SATISFIED		,
	BATTI_ANGRY			,
	BATTI_DEAD			,
	BATTI_TRAP_M6		,
	BATTI_TREASURE_M6	,
	BATTI_VEXING_M6		,
	BATTI_ANGRY_M6		,
	BATTI_DESTORYKUMA	,
	BATTI_PRESENT		,
	BATTI_SATISFIED_M4	,
	BATTI_VEXING_M4		,
	BATTI_ANGRY_M4		,
	BATTI_RESERVE_M1	,
	BATTI_ANGRY_M1		
};

--ウィス蓄積ダメージ --EN:--Whis accumulation damage
TOTALDAMAGE_BATTI = 50;



-------------------------------------------------------------------------------------------------------------------
--■王城イベントで使用する定数 --EN:--■ Constants used in royal castle events
-------------------------------------------------------------------------------------------------------------------

--▼レンドル王子の状態一覧 --EN:--▼Prince Lendl's status list

--▽王城全域 --EN:--▽Whole castle
RENDOL_STATE_DEAD                  = 16004;--死んでいる --EN:--dead

--▽王城1固定 --EN:--▽Royal castle 1 fixed
RENDOL_STATE_HELP_FOR_DOREI_HEISI  = 16000;--奴隷兵士から助けて(一番最初に王城1に入ったときはこの状態になる) --EN:--Help from slave soldiers
RENDOL_STATE_THANKS_1			   = 16001;--感謝(王城1) --EN:--Thanks (Castle 1)
RENDOL_STATE_SEARCH_1			   = 16002;--探索(王城1) --EN:--Exploration (Castle 1)
RENDOL_STATE_HOSTILE_1             = 16003;--敵対(王城1) --EN:-- Hostility (Castle 1)

--▽王城2固定 --EN:--▽ Royal Castle 2 Fixed
RENDOL_STATE_HELP_HIDING_ME        = 16005;--隠れているので助けて --EN:--Help me because I'm hiding
RENDOL_STATE_THANKS_2			   = 16006;--感謝(王城2) --EN:--Thanks (Oujou 2)
RENDOL_STATE_SEARCH_2			   = 16007;--探索(王城2) --EN:--Exploration (Castle 2)
RENDOL_STATE_HOSTILE_2             = 16008;--敵対(王城2) --EN:-- Hostility (Castle 2)

--▽王城3固定 --EN:--▽Royal castle 3 fixed
RENDOL_STATE_LOCATION_INVISIBLE		= 16009;--見えない場所にこっそり --EN:-- Sneak away out of sight
RENDOL_STATE_WANT_TO_OPEN_THE_GATE	= 16010;--門を開けてほしい --EN:--I want you to open the gate
RENDOL_STATE_SCARED					= 16011;--袋小路でおびえ --EN:--Frightened at the dead end
RENDOL_STATE_THANKS_3				= 16012;--感謝(王城3) --EN:--Thanks (Castle 3)
RENDOL_STATE_SEARCH_3				= 16013;--探索(王城3) --EN:-- Exploration (Castle 3)
RENDOL_STATE_HOSTILE_3_FRONT_GATE	= 16014;--敵対(王城3 城門の前) --EN:-- Hostility (Castle 3, in front of the castle gate)
RENDOL_STATE_HOSTILE_3_BACK_GATE	= 16015;--敵対(王城3 城門の後ろ) --EN:-- Hostility (Castle 3 behind the castle gate)

--▽王城4固定 --EN:--▽ Royal castle 4 fixed
RENDOL_STATE_LIFT_FRONT				= 16016;--王城4 エレベータ前 --EN:--In front of the castle 4 elevator
RENDOL_STATE_HOSTILE_4_LIFT_FRONT	= 16017;--敵対(王城4 エレベータ前) --EN:-- Hostility (in front of the castle 4 elevator)
RENDOL_STATE_HOSTILE_STONE_PILLAR	= 16018;--敵対(石柱) --EN:-- Hostility (Stone Pillar)
RENDOL_STATE_ERASE					= 16019;--もういない --EN:--is gone

rendol_flag_list = {
	RENDOL_STATE_HELP_FOR_DOREI_HEISI,
	RENDOL_STATE_THANKS_1,
	RENDOL_STATE_SEARCH_1,
	RENDOL_STATE_HOSTILE_1,
	RENDOL_STATE_DEAD,
	RENDOL_STATE_HELP_HIDING_ME,
	RENDOL_STATE_THANKS_2,
	RENDOL_STATE_SEARCH_2,
	RENDOL_STATE_HOSTILE_2,
	RENDOL_STATE_LOCATION_INVISIBLE,
	RENDOL_STATE_WANT_TO_OPEN_THE_GATE,
	RENDOL_STATE_SCARED,
	RENDOL_STATE_THANKS_3,
	RENDOL_STATE_SEARCH_3,
	RENDOL_STATE_HOSTILE_3_FRONT_GATE,
	RENDOL_STATE_HOSTILE_3_BACK_GATE,
	RENDOL_STATE_LIFT_FRONT,
	RENDOL_STATE_HOSTILE_4_LIFT_FRONT,
	RENDOL_STATE_HOSTILE_STONE_PILLAR,
	RENDOL_STATE_ERASE,
};

--▼遷移する可能性のある状態一覧のリスト(マップごとに用意) --EN:--▼ List of possible transition states (prepared for each map)

--▽王城1 --EN:--▽Castle 1
possible_transration_list_m02_00_00_00 = {

	RENDOL_STATE_HELP_FOR_DOREI_HEISI , 
	RENDOL_STATE_THANKS_1 , 
	RENDOL_STATE_SEARCH_1 , 
	RENDOL_STATE_HOSTILE_1 , 
	RENDOL_STATE_DEAD 
};

--▽王城2 --EN:--▽Oujou 2
possible_transration_list_m02_01_00_00 = {

	RENDOL_STATE_HELP_HIDING_ME , 
	RENDOL_STATE_THANKS_2 , 
	RENDOL_STATE_SEARCH_2 , 
	RENDOL_STATE_HOSTILE_2 , 
	RENDOL_STATE_DEAD 
};

--▽王城3 --EN:--▽Castle 3
possible_transration_list_m02_02_00_00 = {

	RENDOL_STATE_LOCATION_INVISIBLE ,
	RENDOL_STATE_WANT_TO_OPEN_THE_GATE , 
	RENDOL_STATE_SCARED ,
	RENDOL_STATE_THANKS_3 , 
	RENDOL_STATE_SEARCH_3 , 
	RENDOL_STATE_HOSTILE_3_FRONT_GATE , 
	RENDOL_STATE_HOSTILE_3_BACK_GATE ,
	RENDOL_STATE_DEAD 
};

--▽王城4 --EN:--▽Castle 4
possible_transration_list_m02_03_00_00 = {

	RENDOL_STATE_LIFT_FRONT				,
	RENDOL_STATE_HOSTILE_4_LIFT_FRONT	,
	RENDOL_STATE_HOSTILE_STONE_PILLAR	,
	RENDOL_STATE_DEAD 
};


--▼飛竜(長)の状態一覧 --EN:--▼ List of wyvern (long) states

TYO_STATE_SLEEPING          = 16040;--巣で寝ている --EN:--sleeping in a nest
TYO_STATE_DEAD              = 16041;--死んでいる(長) --EN:--dead (long)
TYO_STATE_WARNING_AISLE     = 16042;--警戒(通路) --EN:--Warning (passageway)
TYO_STATE_WARNING_GATE      = 16043;--警戒(ゲート) --EN:--Warning (gate)
TYO_STATE_WARNING_KING_ROOM = 16044;--警戒(王の間)  --EN:--Warning (King's Room)
TYO_STATE_ESCAPE			= 16045;--撤退 --EN:--Retreat
tyo_flag_list = {	
	TYO_STATE_DEAD	   ,
	TYO_STATE_WARNING_AISLE ,
	TYO_STATE_WARNING_GATE ,
	TYO_STATE_WARNING_KING_ROOM
};

tyo1_flag_list = {
	TYO_STATE_SLEEPING ,
	TYO_STATE_ESCAPE
};

--▼飛竜(眷属1)の状態一覧 --EN:--▼ Hiryu (Familiar 1) status list

KENZOKU_STATE_WARNING           = 16030;--巣にいる --EN:--in the nest
KENZOKU_STATE_ABSENCE           = 16031;--不在 --EN:--absence
KENZOKU_STATE_PROTECT_CASTLE    = 16032;--城壁護る --EN:--Protect the ramparts
KENZOKU_STATE_DEAD              = 16033;--死亡 --EN:--death
KENZOKU_STATE_WARNING_AND_LEVER = 16034;--巣にいる(レバー阻止諦め) --EN:--I'm in the nest (give up lever blocking)
KENZOKU_STATE_ABSENCE_AND_LEVER = 16035;--不在(レバー阻止諦め) --EN:--absent (lever block give up)
KENZOKU_STATE_ESCAPE			= 16036;--撤退 --EN:--Retreat
KENZOKU_2_STATE_DEAD            = 16102;--死亡(王城2) --EN:--Death (Castle 2)

kenzoku_flag_list = { 
	KENZOKU_STATE_WARNING           ,
	KENZOKU_STATE_ABSENCE           ,
	KENZOKU_STATE_PROTECT_CASTLE    ,
	KENZOKU_STATE_DEAD              ,
	KENZOKU_STATE_WARNING_AND_LEVER ,
	KENZOKU_STATE_ABSENCE_AND_LEVER ,
	KENZOKU_STATE_ESCAPE			,
	KENZOKU_2_STATE_DEAD            , --王城2で死亡(眷属) 王城1で死亡と分けられているらしい･･･ --EN:--Died in Royal Castle 2 (Family) and died in Royal Castle 1, apparently...
};



--▼飛竜(眷属2)状態一覧 --EN:--▼ Hiryu (Familiar 2) status list

KENZOKU_2_STATE_WARNING  = 16100;--警戒 --EN:-- vigilance
KENZOKU_2_STATE_HEROHERO = 16101;--ヘロヘロ --EN:--hero hero
KENZOKU_2_STATE_DEAD     = 16102;--死亡(眷属2=王城2) --EN:-- Death (Family 2 = Royal Castle 2)
KENZOKU_STATE_DEAD       = 16033;--死亡(眷属1=王城1) なぜか死亡が2つに分かれている。 --EN:--Death (1 relative = 1 royal castle) For some reason, death is divided into two.

kenzoku_2_flag_list = {

	KENZOKU_2_STATE_WARNING  ,
	KENZOKU_2_STATE_HEROHERO ,
	KENZOKU_2_STATE_DEAD ,
    KENZOKU_STATE_DEAD    
};



--宝系SFXID --EN:--Treasure SFX ID
KANAME_SFX = 99100;
KAGI_SFX = 94110;
KEN_SFX = 99050;
ITEM_SFX = 93010;

USER_IDX_Unknow 			= -1;	--不明 --EN:--not clear
USER_ID_Network_Error		= 0;	--ネットワーク＿エラー系 --EN:-- Network _ error system
USER_ID_Network_Notice		= 1;	--ネットワーク＿通知系 --EN:--Network_notification system
USER_ID_Network_MultiPlay	= 2;	--ネットワーク＿マルチプレイ --EN:--Network_Multiplayer
USER_ID_Network_Login		= 3;	--ネットワーク＿ログイン --EN:-- network_login
USER_ID_Event_SosLost_White	= 4;	--イベント＿SOS消失_White --EN:--Event_SOS Disappearance_White
USER_ID_Event_SosLost_Red	= 5;	--イベント＿SOS消失_Red --EN:--Event_SOS Disappearance_Red
USER_ID_Event_SosLost_Black	= 6;	--イベント＿SOS消失_Black --EN:--Event_SOS Disappearance_Black
USER_ID_Event_GetItem		= 7;	--イベント＿アイテム取得系 --EN:-- Event _ item acquisition system


