local flua = require "flua";

flua.testcase("sample", function ()

	local result = pcall(function () assert.isTrue(true) end);

	print(result);

	--assert.isTrue(false);
	--assert.isTrue({ dsf=1 });
	-- assert.fail("blabla");

end);

flua.run();