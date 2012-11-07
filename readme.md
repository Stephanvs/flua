# Fluent Test framework for Lua

Flua is a very simple and very lightweight testing framework for Lua. The main focus of this framework is to be able to write very simple tests for Lua scripts.

# Getting started

The framework for now requires you to `require "flua"` in your test script.

Next define your testscript as follows:

```lua
flua.testcase("sample", function ()

	assert.isTrue(true);
	assert.isFalse(false);

end);
```

## Explicitly failing a test

If you want to explicitly fail a test call the `assert.fail` method specifying a reason why the test fails.

    assert.fail("Test failes explicitly");

