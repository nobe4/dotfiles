function ruby_call_to_expect(input)
  local input = vim.api.nvim_get_current_line()
  local indent = input:match("^(%s*).*$")
  input = input:match("^%s*(.-)%s*$")

  -- split by dots
  local parts_count = 2 -- lua is 1-indexed
  local parts = { "subject" } -- always insert a subject

  -- Try to match a call
   _, _, call =  string.find(input, "(%([^)]+%))$")
  print(vim.inspect(call))
  if call then
    print("there's a call")
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
    line = indent .. "expect(" .. parts[index] .. ").to receive(:" .. parts[index + 1] .. ")"

    if index == parts_count - 2 then
      if call then
        line = line .. ".with" .. call
      end
    end

    line = line ..  ".and_return(" .. parts[index + 1] .. ")"

    table.insert(lines, line)
  end
  print(vim.inspect(lines))

  -- Insert in the current line
  local row, _ = unpack(vim.api.nvim_win_get_cursor(0))
  vim.api.nvim_buf_set_lines(0, row, row, false, lines)
end
