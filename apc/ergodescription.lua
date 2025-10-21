-- ergodescription.lua
-- Converts Pandoc definition lists to LaTeX ergodescription environment

function DefinitionList(el)
  -- Check if this is targeting LaTeX output
  if FORMAT ~= "latex" then
    return el
  end
  
  -- Check if the definition list has the ergodescription class
  local is_ergodesc = false
  local title = nil
  
  if el.classes then
    for _, class in ipairs(el.classes) do
      if class == "ergodescription" then
        is_ergodesc = true
        break
      end
    end
  end
  
  -- Check for title attribute
  if el.attributes and el.attributes.title then
    title = el.attributes.title
  end
  
  -- If not explicitly marked, treat all definition lists as ergodescription
  -- Remove the condition below if you want to preserve some as regular description
  if not is_ergodesc then
    is_ergodesc = true  -- Convert all definition lists by default
  end
  
  if not is_ergodesc then
    return el
  end
  
  -- Build the LaTeX code
  local result = {}
  
  -- Start environment
  if title then
    table.insert(result, pandoc.RawBlock('latex', '\\begin{ergodescription}[' .. title .. ']'))
  else
    table.insert(result, pandoc.RawBlock('latex', '\\begin{ergodescription}'))
  end
  
  -- Process each definition item
  for _, item in ipairs(el.content) do
    -- item[1] contains the terms (usually just one)
    -- item[2] contains the definitions
    
    local terms = item[1]
    local definitions = item[2]
    
    -- Create the \item command with the term
    for _, term in ipairs(terms) do
      local term_text = pandoc.utils.stringify(term)
      table.insert(result, pandoc.RawBlock('latex', '\\item[' .. term_text .. '] '))
      
      -- Add the definition content
      for _, def in ipairs(definitions) do
        for _, block in ipairs(def) do
          table.insert(result, block)
        end
      end
    end
  end
  
  -- End environment
  table.insert(result, pandoc.RawBlock('latex', '\\end{ergodescription}'))
  
  return result
end

-- Alternative approach: If you want to manually mark which lists to convert,
-- comment out the line "if not is_ergodesc then is_ergodesc = true end" above
-- and use this syntax in your markdown:
-- 
-- Term 1
-- :   Definition 1
-- 
-- {.ergodescription}
--
-- Or with a title:
--
-- Term 1
-- :   Definition 1
--
-- {.ergodescription title="My Title"}
