// 请实现一个函数，输入一个整数，输出该数二进制表示中1的个数。例如，把9表示成二进制是1001，有2位是1.因此，如果输入9，则该函数输出2。

func NumberOf1(_ n: Int) -> Int {
	var count: Int = 0
	var num: Int  = n
	while num>0 {
		count+=1
		num = num & (num-1)
	}
	
	return count
}

func NumberOf1a(_ n: Int) -> Int {
	var count: Int = 0
	var flag: Int = 1
	
	while flag > 0 {
		if n & flag > 0 {
			count+=1
		}
		flag = flag<<1
	}
	
	return count
}

// 正数
print(NumberOf1(1))
print(NumberOf1(0x7FFFFFFF))
// 负数
print(NumberOf1(0x80000000))
print(NumberOf1(0xFFFFFFFF))
// 0
print(NumberOf1(0))