# Ruby その他

## 変数
```ruby
# ()は不要
a, b = b, a

# グローバル変数
$greeting = 'Hello'
def say_hello
  puts $greeting
end
say_hello

# "_"で桁区切り
total = 10_000_000
puts total # 10000000

# 文字の連結
full_name = 'John' + '' + 'Doe'
puts full_name # John Doe
full_name = 'John' << ' ' << 'Doe'
puts full_name # John Doe
```

## 真偽値
```ruby
# nilとfalse以外はすべて真
def truthy?(obj)
  !!obj
end

puts truthy?(nil) # false
puts truthy?(false) # false
puts truthy?('') # true
puts truthy?(0) # true
puts truthy?('0') # true
puts truthy?([]) # true
puts truthy?({}) # true
```

## シンボル
```ruby
status = :active

symbol_to_string = :active.to_s # "active"
string_to_symbol = 'active'.to_sym # :active

zoo = {type: 'cat', name: 'leo'}
```

## 配列
```ruby
numbers = [1, 2, 3, 4, 5]
p numbers[1, 3] # [2, 3, 4]
p numbers[1..3] # [2, 3, 4]

# pushの代用
numbers << 6
p numbers # [1, 2, 3, 4, 5, 6]

# 要素がある？
p numbers.include?(3) # true
```

## ハッシュ
```ruby
person = { name: 'John', age: 30 }
person.delete(:age) # {:name=>"John"}
p person.has_key?(:name) # true
p person.empty? # false
```

## 範囲指定
```ruby
nums1 = 1..5 # 1-5
nums2 = 1...5 # 1-4

chars = 'a'..'z' # "a"-"z"
p chars.class # Range

chars_a = chars.to_a # ["a","b",...,"z"]
p chars_a.class # Array
```

## 型
```ruby
p 'hello'.is_a?(String) # true
p 123.is_a?(Integer) # true
p '123'.is_a?(Integer) # false
```

## 演算子
```ruby
# 1（宇宙船演算子: aがbより大きい場合は1、等しい場合は0、小さい場合は-1）
a, b = 3, 2
p a <=> b

# 範囲演算子
(0..11).each do |i|
  case i
  when 1..4
    puts "a: #{i}"
  when 5..8
    puts "b: #{i}"
  when 9..10
    puts "c: #{i}"
  else
    puts "d: #{i}"
  end
end

# ぼっち演算子
# メソッド呼び出しでnilの場合、エラーにならない
class User
  def greeting
    'hello'
  end
end

obj1 = User.new
p obj1&.greeting # hello

obj2 = nil
p obj2&.greeting # nil
```

## 条件分岐
```ruby
fruit = 'apple'
case fruit
when 'apple', 'orange', 'banana'
  puts 'a'
else
  puts 'b'
end
```