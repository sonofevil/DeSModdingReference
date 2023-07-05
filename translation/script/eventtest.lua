

function Initialize(proxy)
	print("Initialize begin");

	proxy:ObserveDistPlayer(10, "OnNear");

	print("Initialize end");
end



function OnNear(proxy)
	print("OnNear begin");
	
	proxy:TrapOn();
	
	print("OnNear begin");
end

