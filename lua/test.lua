#!/usr/bin/env lua

-- This is a comment

function norm (x, y)
    local n2 = x^2 + y^2
    return math.sqrt(n2)
end
    
function twice (x)
  return 2*x
end

print(norm(3, 4))

local results = os.execute( "ls /tmp" )

print( "------" )
print( results )

print(os.date("time: %I:%M %p is %A %B %d %Y"))

print("Hello " .. "World")  --> Hello World
print(0 .. 1)               --> 01


print("HOME=" .. os.getenv("HOME"))
print("SHELL=" .. os.getenv("SHELL"))

print(type("Hello world"))  --> string
print(type(10.4*3))         --> number
print(type(print))          --> function
print(type(type))           --> function
print(type(true))           --> boolean
print(type(nil))            --> nil
print(type(type(X)))        --> string

function print_table (table)
    print("table start")
    for i,v in pairs(table) do
        print(i .. " => " .. v)
    end
    print("table end\n\n")
end

table = {
    "a",
    "b"
}

days = {"Sunday", "Monday", "Tuesday", "Wednesday",
        "Thursday", "Friday", "Saturday"}

days0 = {[0]="Sunday", "Monday", "Tuesday", "Wednesday",
             "Thursday", "Friday", "Saturday"}

mytable = {}
mytable[1]= "Lua"
mytable["wow"] = "Tutorial"


print_table(table)
print_table(days)
print_table(days0)
print_table(mytable)
print(type(table))        --> table


local v = {
    ["fish"] = { stuff = "bla", stuff2 = "bla" },
    ["mouse"] = { stuff = "bla", stuff2 = "bla" },
    ["bird"] = { stuff = "bla", stuff2 = "bla" },
}

local t = {
    ["cat"] = v,
    [0] = v,
}

print(t.cat.fish.stuff, t[0].fish.stuff)

a = {p = print}
a.p("Hello World") --> Hello World

