# project-config
This plugin provide a way to add/use project based configuration.

## idea
Each project could have a `.nvim` folder in which it could store the settings.json and another project based config.
There are defaults which will apply in case the key is not in the settings.json

## Requirements
This plugin uses [plenary](https://github.com/nvim-lua/plenary.nvim)

## Configuration
```lua
require'project-config'.setup{
        settings = {
                key = value -- Default values for the keys in the settings.json
            }
    }
```

## Demo settings.json
.nvim/settings.json in project's root folder

```json
{
    "debug_exec" : "${PROJECT_ROOT}/build/debug/out/${PROJECT_NAME}",
    "release_exec" : "${PROJECT_ROOT}/build/release/out/${PROJECT_NAME}"
}
```

The content `${PROJECT_NAME}` will expand to the name of the project (name of the root folder)
The content `${PROJECT_ROOT}` will expand to the path of the project's root.

## API
This plugin provides a `get_settings()` function that returns the configuration table for the project.

```lua
local project_settings = require'project-config'.get_settings()
```

The `project_settings` will look something like this for the demo settings.json

```lua
    {
        debug_exec = "/home/demo/demo_project/build/debug/out/demo_project",
        release_exec = "/home/demo/demo_project/build/release/out/demo_project"
    }

```
