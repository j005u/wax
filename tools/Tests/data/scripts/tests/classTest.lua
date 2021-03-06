require "tests.fixtures.ExtendedSimpleObject"
require "tests.fixtures.Deer"
require "tests.fixtures.Bambi"

describe["A WaxClass instance with an ObjC Super"] = function()
  before = function()
  end
  
  it["is created via method"] = function()
    local o = ExtendedSimpleObject:initWithAnimal("elephant")
    expect(o:value()).should_be("elephant")
  end
  
  it["is created via a overridden super init method"] = function()
    local o = ExtendedSimpleObject:initWithValue("a value")
    expect(o:value()).should_be("a value")
  end
  
  it["is created via a super init method"] = function()
    local o = ExtendedSimpleObject:initWithWord("a word")
    expect(o:value()).should_be("a word")
  end
  
  it["is created via a plain init method"] = function()
    local o = ExtendedSimpleObject:init()
    expect(o).should_exist()
  end
  
  it["can override a method"] = function()
    local o = ExtendedSimpleObject:initWithValue("original")
    expect(o:valueOverride()).should_be("NOT THE ORIGINAL")
  end
  
  it["can be called via obj-c"] = function()
    local o = ExtendedSimpleObject:initWithValue("obj")
    result = o:performSelector("stringForTesting")
    expect(result).should_be("Look at me!")
  end
  
  it["can be called via obj-c with args"] = function()
    local o = ExtendedSimpleObject:initWithValue("obj")
    result = o:performSelector_withObject("stringForTestingWithArg:", "we all!")
    expect(result).should_be("So say we all!")
  end
end

describe["A WaxClass instance with an WaxClass Super"] = function()
  before = function()
  end
  
  it["is created via method"] = function()
    local o = Bambi:initWithAge(12)
    expect(o:getAge()).should_be(12)
  end
  
  it["is created via an init method"] = function()
    local o = Bambi:initWithName("Bammmmbi")
    expect(o:getName()).should_be("Bammmmbi")
  end
  
  it["is created via an overridden init method"] = function()
    local o = Bambi:initWithFood("Beef")
    expect(o:getFood()).should_be("Beef")
    expect(o.bambiFood).should_be("BambiBeef")
    expect(o.deerFood).should_be("DeerBeef")
  end
  
  it["can call a super method"] = function()
    local o = Bambi:initWithAge(10)
    expect(o:doubleAge()).should_be(20)
  end
  
  it["can call an overridden method"] = function()
    local o = Bambi:initWithAge(1)
    expect(o:tripleAge()).should_be(3)
  end
  
  it["can call a super method that takes a function as a arg"] = function()
    local o = Bambi:initWithAge(10)
    o:doSomethingToAge(function(a) return a * 5 end)
    expect(o:getAge()).should_be(50)
  end
end

describe["A WaxClass with an WaxClass Super"] = function()
  before = function()
  end
  
  it["can call a super method on a class"] = function()
    local result = Bambi:aClassMethod()
    expect(result).should_be("yes")
  end
end
