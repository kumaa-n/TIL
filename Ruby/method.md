# Ruby メソッド

## group_by
```ruby
# 集合.group_by {ブロック}

# {false=>[79], true=>[80, 81]}
test1 = [79, 80, 81]
pp test1.group_by { |s| s >= 80 }

# {1=>[["test1", 1], ["test4", 1], ["test4", 1]],
# 2=>[["test2", 2]],
# 3=>[["test3", 3], ["test4", 3]]}
test2 = [
  ['test1', 1],
  ['test2', 2],
  ['test3', 3],
  ['test4', 1],
  ['test4', 1],
  ['test4', 3],
]

pp test2.group_by { |item| item[1]}


# {
#    1=>[#<User:0x000000010a781cd8 @age=1, @name="test_1">,
#        #<User:0x000000010a781c10 @age=1, @name="test_3">,
#        #<User:0x000000010a781b70 @age=1, @name="test_5">],
#    2=>[#<User:0x000000010a781c60 @age=2, @name="test_2">,
#        #<User:0x000000010a781b20 @age=2, @name="test_6">],
#    3=>[#<User:0x000000010a781bc0 @age=3, @name="test_4">]
#  }
class User
  attr_accessor :age
  @@cnt = 0

  def initialize(age)
    @@cnt += 1
    @age = age
    @name = "test_#{@@cnt}"
  end
end

users = []
ages = [1, 2, 1, 3, 1, 2]
ages.each do |age|
  users << User.new(age)
end

pp users.group_by(&:age)
```