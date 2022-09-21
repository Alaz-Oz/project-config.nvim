local config = {}

config.defaults = {
    settings = {
        debug_exec = "${PROJECT_ROOT}/build/debug/out/${PROJECT_NAME}",
        release_exec = "${PROJECT_ROOT}/build/release/out/${PROJECT_NAME}",
    },
}

setmetatable(config, { __index = config.defaults })
return config
