-- This is not similar to GitHub secrets, it's just a place
-- to keep constants we don't want the user to see

local Secrets = {
	RateLimits = {
		Global = 0.4;
		quit = 5;
	};
	RateLimitBuffer = 2;
	RateLimitFillWhenOverflowing = true;
}

return Secrets