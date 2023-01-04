kpse.set_program_name "luatex"

local readalma = require "almaxml-sax"

local filename = arg[1]
-- každej záznam je jedna výpůjčka, obsahuje datum výpůjčky a vrácení
-- pro každý id počítáme jako návštěvu každej unikátní den, kdy mělo 
-- buď výpůjčku, nebo vrácení

local mapping = {
  C5 = "id",
  C12 = "loan",
  C14 = "return",
}


local function table_copy(t)
  local new = {}
  for k,v in pairs(t) do new[k] = v end
  return new
end

local ids = {}

local count = 0
function callback(record)
  local curr = ids[record.id] or {}
  -- započítat výpůjčku
  local loan = record.loan 
  local ret  = record["return"]
  if not curr[loan] then count = count + 1 end
  -- uvádí se poslední vrácení, je možný, že ještě nebyla vrácená
  if ret > loan then
    if not curr[ret] then count = count + 1 end
  end
  curr[loan] = true
  curr[ret]  = true
  ids[record.id] = curr
  -- local signatura = record.signatura or ""
  -- local prefix = signatura:match("^([0-9]?[a-zA-Z%-]+)")
  -- if prefix:match("C%-") then
  --   table.insert(cbe, table_copy(record))
  -- else
  --   local sysno = record.sysno
  --   local r = others[sysno] or {cel=0, ret=0}
  --   if record.umisteni == "Celetná - study room" then
  --     r.cel = r.cel + 1
  --   else
  --     r.ret = r.ret + 1
  --   end
  --   others[sysno] = r
  -- end
end

local records = readalma.load(filename, callback, mapping)
print(count)
