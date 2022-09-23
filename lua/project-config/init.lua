local config = require("project-config.config")
local Path = require("plenary.path")
local M = {}

M.setup = function(conf)
    setmetatable(config, { __index = vim.tbl_extend("force", config.defaults, conf) })
end
local function escape(str)
    local escapes = {
        -- ["pattern"] = "value",
        ["${PROJECT_ROOT}"] = vim.fn.getcwd(),
        ["${PROJECT_NAME}"] = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t"),
        ["${TIMESTAMP}"] = "time_not_supported",
        ["${RANDOM}"] = math.random(),
    }
    for pattern, repl in pairs(escapes) do
        str = string.gsub(str, pattern, repl)
    end
    return str
end

local function escape_tbl(txt)
    local escaped = {}
    for key, value in pairs(txt) do
        local x = value
        if type(value) == "string" then
            x = escape(value)
        elseif type(value) == "table" then
            x = escape_tbl(value)
        end
        escaped[key] = x
    end
    return escaped
end

function M.get_settings()
    local file = Path:new(vim.fn.getcwd() .. "/.nvim/settings.json")
    return escape_tbl(vim.tbl_extend("force", config.settings, vim.json.decode(file:read())))
end
function M.settings_exist()
    local file = Path:new(vim.fn.getcwd() .. "/.nvim/settings.json")
    return file:exists()
end

return M
