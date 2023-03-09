local ffi = require("ffi")
local ffi_gc = ffi.gc
local demo = ffi.load("demo")
local _M = {}
ffi.cdef [[
    typedef struct ArrayData{
       int* data;
       size_t n;
    } NArray;
    NArray* make_n(int n);
    void free_n_array(NArray* arr);
]]

local function get_n_array(n)
  return ffi_gc(demo.make_n(n), demo.free_n_array)
end

function _M.test_no_leak()
  print("run method with ffi.gc")
  local arr = get_n_array(3)
  for i = 1, tonumber(arr.n) do
    print(arr.data[i - 1])
  end
end

function _M.test_leak()
  local arr = demo.make_n(3)
  for i = 1, tonumber(arr.n) do
    print(arr.data[i - 1])
  end
end

return _M
