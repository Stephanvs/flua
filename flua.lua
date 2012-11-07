local flua = (function ()

	local stats = {
		assertions = 0,
		passed = 0,
		failed = 0,
		errors = 0
	}

	local output = function (format, ...)
		print(string.format(format, ...));
	end
	
	local _testcases = {};

	local failure = function(...)

		local msg = ""

		for i = 1, select("#", ...) do

			local current = select(i, ...);

			if (type(current) == "table") then
				-- do nothing for now
			else
				msg = msg .. tostring(select(i, ...));
			end
		end

  		error(string.format(msg, ...));
	end

	local done = function ()
		output("\n\n%d Assertions checked.\n", stats.assertions);

		-- for i, msg in pairs(msgs) do
		-- 	output("%3d) %s\n", i, msg);
		-- end

		output("Testsuite finished (%d passed, %d failed, %d errors).\n", 
			stats.passed, stats.failed, stats.errors);
	end

	return {

		testcase = function (name, tc)
			-- Register the module as a testcase
			_testcases[name] = tc;
			
			-- Import flua, fail, assert* and is_* function to the module/testcase
			-- m.flua = flua;
			-- m.fail = flua.fail;

			-- for funcname, func in pairs(flua) do
			-- 	if "assert" == string_sub(funcname, 1, 6) or "is_" == string_sub(funcname, 1, 3) then
			-- 		m[funcname] = func;
			-- 	end
			-- end
		end,

		run = function ()
			for name, testcase in pairs(_testcases) do
				if (type(testcase) == "function") then
					testcase();
					stats.passed = stats.passed + 1
				end
			end

			done();
		end,

		assert = (function ()
			return {
				fail = function (msg)
					stats.assertions = stats.assertions + 1;
					failure("testcase explicitly failed: ", msg);
				end,

				isTrue = function (actual)
					stats.assertions = stats.assertions + 1
		    		local actualtype = type(actual)

		    		if actualtype ~= "boolean" then
		    			failure("true expected but was a " .. actualtype)
		    		end
		    		
		    		if actual ~= true then
		    			failure("true expected but was false")
		    		end
		    		
		    		return actual
				end
			};
		end)()
	}
end)();

assert = flua.assert;

return flua;