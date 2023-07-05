function Initialize_m99_99_98_00(proxy)
	print("Initialize m99_99_98_00");

	--▼0秒後▼-- --EN:--▼After 0 seconds▼--
	proxy:OnKeyTime2( 999990, "Second_Initialize_m99_99_98_00", 0.3, 0, 0, once );	
	
	print("Initialize m99_99_98_00 end");
end


function Second_Initialize_m99_99_98_00(proxy, param)
	print("Second_Initialize_m99_99_98_00 begin");
	OnEvent_1(proxy);
	print("Second_Initialize_m99_99_98_00 end");
end

function OnEvent_1(proxy)
    proxy:OnKeyTime2( 999991,"OnEvent_2",3.0,0,0,once);
    OnEvent_3(proxy);
end

function OnEvent_2(proxy)
    proxy:OnKeyTime2( 999992,"OnEvent_1",3.0,0,0,once);
    OnEvent_3(proxy);
end


--▲1250_2▲ダメージ球がでるのを遅らせる(蹴った本人に当たらないように)▲ --EN:--▲1250_2▲ Delays the damage ball from coming out (so that it doesn't hit the person who kicked it) ▲
function OnEvent_3(proxy)
	print("OnEvent_3 begin");

	--火の藁からダメージ球 --EN:--damage sphere from fire straw
	local paramid = 10010; --火属性ダメージ --EN:-- Fire attribute damage
	local rad     = 1.5;--半径 --EN:--radius
	local time    = 3.0; --ひとまずアニメ再生終了でダメージ球消すので、アニメより長い時間を指定しておく --EN:--For the time being, the damage ball will be erased when the animation ends, so specify a longer time than the animation.
	
	proxy:OnObjectDamageHit_NoCall( 1250, 1, 1, paramid, EV_HIT_CHR , rad, time, everytime );	
	
	print("OnEvent_3 end");
end
