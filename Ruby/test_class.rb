# ruby self @ の違いとアクセサの有無によるエラーの有無を総当たりで動作チェック
# コメントアウトされている行はエラーとなるので、コメントインして文法エラー確認が可能


class TestClass
  attr_accessor :hoge1, :hoge3

  def initialize(arg)
    @hoge1 = arg        # @hoge　はアクセサがある
    @hoge2 = arg        # @hoge2 はアクセサがない
    self.hoge3 = arg    # @の代わりにselfを使った場合、アクセサあり
    #self.hoge4 = arg   # @の代わりにselfを使った場合、アクセサなし、これはエラーになるので、コメントアウト
  end

  def func
    puts "========hoge1をインスタンスメソッド内で使った場合========"
    puts hoge1 + "1"
    puts @hoge1 + "2"
    puts self.hoge1 + "3"
    puts "========hoge2をインスタンスメソッド内で使った場合========"
    #puts hoge2 + "4"       # hoge2 はローカル変数となり、この行で初登場なので値なしエラー
    puts @hoge2 + "5"       #@hoge2 はインスタンス変数なので、インスタンス関数から利用できるのでOK
    #puts self.hoge2 + "6"  # hoge2 のアクセサを用意してないので、エラー(selfはアクセサを呼び出す呪文)
    puts "========hoge3をインスタンスメソッド内で使った場合========"
    puts hoge3 + "7"
    puts @hoge3 + "8"
    puts self.hoge3 + "9"
  end
end

obj = TestClass.new("テスト")
obj.func

puts "========hoge1をインスタンス変数として使った場合(hoge1はアクセサあり)========"
puts obj.hoge1 + "11"
# puts obj.@hoge1 + "12"       #文法エラー .の後に@はおかしい
# puts obj.self.hoge1 + "13"   #selfはインスタンスメソッドではないので、文法エラー
puts "========hoge2をインスタンス変数として使った場合(hoge2はアクセサなしなので全滅)========"
# puts obj.hoge2 + "14"       #hoge2にはアクセサがないので、インスタンス変数として利用するとエラー
# puts obj.@hoge2 + "15"      #文法エラー .の後に@はおかしい
# puts obj.self.hoge2 + "16"   #selfはインスタンスメソッドではないので、文法エラー
puts "========hoge3をインスタンス変数として使った場合(hoge3はアクセサあり)========"
puts obj.hoge3 + "17"
# puts obj.@hoge3 + "18"       #文法エラー .の後に@はおかしい
# puts obj.self.hoge3 + "19"   #selfはインスタンスメソッドではないので、文法エラー
