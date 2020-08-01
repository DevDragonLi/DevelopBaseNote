
puts "begain With Ruby 2.6.3"

name = "DragonLi--DeV"

# 全局变量
$globalName = "全局变量"

# 常量全部大写 ANDROID_SYSTEM 
# 变量小写开头 is_create （任何变量都是object）
# 方法名 小写开头，可以问号，或者=结尾  test= 

# Class 首字母大写：文件名：_+小写

puts "#{name}"

class Ruby

attr_accessor 'DragonLi'  # 包含了setter ，getter 等 

# 类变量 @@global

def self.class_method_name
	puts "类方法"
end

def method_name
	puts "实例方法"
end

end

rubyObject = Ruby.new
rubyObject.DragonLi = "DragonLi Value"

puts "#{rubyObject.DragonLi}"


string = "单行文本"
multiString = %Q{
	第一行,
	第二行
}

puts "#{multiString}"

# symbol  不变的字符串 : 即可  name.to_symbol

# 数组
array = [1,2,3]

puts "#{array}"

dic = {
	:path => "./",
	:source => "https:hhh"
}

dic1 = {
	path: "./",
	source: "https:hhh"
}

puts "#{dic}"

[1,2].each { |element|
puts "#{element}"
}
testArray = [1,2,3,4,5,6,7,8] 
loop do {
 	currentelement => testArray.pop

	break if  currentelement > 6
	end 
}
# 元编程

def print_LFL=
	puts "hi,print_LFL"
end

def print_DragonLi=
	puts "hi,print_DragonLi"
end

["print_LFL","print_DragonLi"].each do |name|
	define_method "#{name}=" do 
		puts "hi,#{name}="
	end
end











