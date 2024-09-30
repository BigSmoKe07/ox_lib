---Yields the current thread until a non-nil value is returned by the function.
---@generic T
---@param cb fun(): T?
---@param errMessage string?
---@param timeout? number | false Error out after `~x` ms. Defaults to 1000, unless set to `false`.
---@return T
---@async
function lib.waitFor(cb, errMessage, timeout)
    timeout = type(timeout) == 'number' and timeout or 1000 -- Set default timeout to 1000ms
    local start = GetGameTimer()

    local value = cb()
    while not value do
        Wait(0)

        local elapsed = GetGameTimer() - start
        if elapsed > timeout then
            return error(('%s (waited %.1fms)'):format(errMessage or 'failed to resolve callback', elapsed), 2)
        end

        value = cb()
    end

    return value
end

return lib.waitFor
