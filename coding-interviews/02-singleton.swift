// 题目：设计一个类，我们只能生成该类的一个实例。

// Objective-C 中单例的写法
@implemention MyManager
+ (id)sharedManager {
	static MyManager *staticInstance = nil;
	static dispacth_once_t onceToken;
	
	dispacth_once(&onceToken, ^{
		staticInstance = [[self alloc] init];
	})
	return staticInstance;
}

// Swift 中单例的写法
class MyManager {
	static shared = MyManager()
	privite init() {}
}
