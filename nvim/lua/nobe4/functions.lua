function ruby_call_to_expect()
  local input = vim.api.nvim_get_current_line()
  local indent = input:match("^(%s*).*$")
  input = input:match("^%s*(.-)%s*$")

  -- split by dots
  local parts_count = 2 -- lua is 1-indexed
  local parts = { "subject" } -- always insert a subject

  -- Try to match a call
  local _, _, call =  string.find(input, "(%([^)]+%))$")
  if call then
    input = string.gsub(input, call, "")
    input = string.gsub(input, "%(%)", "")
  end

  for k, _ in string.gmatch(input, "([^.]+).?") do
    parts_count = parts_count + 1
    table.insert(parts, k)
  end
  print(vim.inspect(parts))

  -- Build the lines
  local lines = {}
  for index=1, parts_count - 2, 1 do
    local line = indent .. "expect(" .. parts[index] .. ").to receive(:" .. parts[index + 1] .. ")"

    if index == parts_count - 2 then
      if call then
        line = line .. ".with" .. call
      end
    end

    line = line ..  ".and_return(" .. parts[index + 1] .. ")"

    table.insert(lines, line)
  end

  -- Insert in the current line
  local row, _ = unpack(vim.api.nvim_win_get_cursor(0))
  vim.api.nvim_buf_set_lines(0, row, row, false, lines)
end

function ruby_lib_to_spec()
  -- Find all the functions
  local input = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local results = {}

  for _, line in pairs(input) do
    for k, _ in string.gmatch(line, "%s*def ([^(]+).?") do
      table.insert(results, 'context "#' .. k .. '" do it "TODO" end')
    end
  end

  vim.fn.setreg('"', table.concat(results, "\n"))
  print('Value in " register, press p')
end
-- Example that didn't work
-- @client = Octokit::Client.new(login, token)
-- @client.auto_paginate = true
-- @client.default_media_type = "application/vnd.github.v3+json"

