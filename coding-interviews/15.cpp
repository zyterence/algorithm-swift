// 请实现一个函数，输入一个整数，输出该数二进制表示中1的个数。例如，把9表示成二进制是1001，有2位是1.因此，如果输入9，则该函数输出2。

#include <iostream>

using namespace std;

int NumberOf1(int n) {
	int count = 0;
	
	while(n) {
		++count;
		n=n & (n-1);
	}
	return count;
}

int NumberOf1a(int n) {
	int count = 0;
	unsigned int flag;
	
	while(flag) {
		if(n & flag) {
			count++;
		}
		flag = flag<<1;
	}

	return count;
}



int main(int argc, char *argv[]) {
	// 正数
	cout <<NumberOf1(1)<<endl;
	cout <<NumberOf1(0x7FFFFFFF)<<endl;
	// 负数
	cout <<NumberOf1(0x80000000)<<endl;
	cout <<NumberOf1(0xFFFFFFFF)<<endl;
	// 0
	cout <<NumberOf1(0)<<endl;
}