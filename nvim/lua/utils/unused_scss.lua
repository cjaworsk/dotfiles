local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values

local M = {}

-- 1. Get SCSS class names (e.g., ".my-class" → "my-class")
local function get_scss_classes()
  local handle = io.popen("rg -o '\\.[a-zA-Z0-9_-]+' --no-heading --trim eww/scss/")
  if not handle then
    return {}
  end

  local seen = {}
  local classes = {}

  for line in handle:lines() do
    local cls = line:match("^%.(.+)$")
    if cls and not seen[cls] then
      seen[cls] = true
      table.insert(classes, cls)
    end
  end

  handle:close()
  return classes
end

-- 2. Check if a class name appears in .yuck files
local function is_class_used(classname)
  local cmd = string.format("rg -q '%s' eww/*.yuck", classname)
  return os.execute(cmd) == 0
end

-- 3. Main function to scan for unused
function M.find_unused_classes()
  local classes = get_scss_classes()
  local unused = {}

  for _, cls in ipairs(classes) do
    if not is_class_used(cls) then
      table.insert(unused, cls)
    end
  end

  pickers
    .new({}, {
      prompt_title = "Unused SCSS Classes",
      finder = finders.new_table({ results = unused }),
      sorter = conf.generic_sorter({}),
    })
    :find()
end

return M
