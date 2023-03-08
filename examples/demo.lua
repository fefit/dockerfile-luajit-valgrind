local ffi = require("ffi")
local testlib = ffi.load("test")
ffi.cdef [[
    typedef struct ArrayData{
       int* data;
       size_t n;
    } NArray;
    NArray* make_n(int n);
    void free_n_array(NArray* arr);
]]

local function get_n_array(n)
  return ffi.gc(testlib.make_n(n), testlib.free_n_array)
end

local function test()
  local arr = get_n_array(3)
  for i = 1, tonumber(arr.n) do
    print(arr.data[i - 1])
  end
  print("execute test method")
end

test()
