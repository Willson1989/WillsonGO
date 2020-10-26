### Lambda表达式的基本格式：

```
[函数对象参数] (操作符重载函数参数) mutable 声明 -> 返回值类型 {函数体}
```

### 语法分析

#### [函数对象参数]

标识一个 Lambda 表达式的开始，这部分必须存在，不能省略。函数对象参数是传递给编译器自动生成的函数对象类的构造

函数的。函数对象参数只能使用那些到定义 Lambda 为止时 Lambda 所在作用范围内可见的局部变量(包括 Lambda 所在类

的 this)。函数对象参数有以下形式：

\* **空**

没有任何函数对象参数。

\* **=**

函数体内可以使用 Lambda 所在范围内所有可见的局部变量（包括 Lambda 所在类的 this），并且是值传递方式（相

当于编译器自动为我们按值传递了所有局部变量）。

\* **&**

函数体内可以使用 Lambda 所在范围内所有可见的局部变量（包括 Lambda 所在类的 this），并且是引用传递方式

（相当于是编译器自动为我们按引用传递了所有局部变量）。

this。函数体内可以使用 Lambda 所在类中的成员变量。

\* **a**

将 a 按值进行传递。按值进行传递时，函数体内不能修改传递进来的 a 的拷贝，因为默认情况下函数是 const 的，要

修改传递进来的拷贝，可以添加 mutable 修饰符。

\* **&a**

将 a 按引用进行传递。

\* **a，&b**

将 a 按值传递，b 按引用进行传递。

\* **=，&a，&b**

除 a 和 b 按引用进行传递外，其他参数都按值进行传递。

\* **&，a，b**

除 a 和 b 按值进行传递外，其他参数都按引用进行传递。



#### mutable 声明

这部分可以省略。按值传递函数对象参数时，加上 `mutable` 修饰符后，可以修改传递进来的拷贝（注意是能修改拷贝，而不是

值本身）。

```c++
int age = 29;

// 加上 mutable 修饰符之后，可以修改传递进来的局部变量的拷贝（注意是能修改拷贝，原局部变量的值不变）
auto add_age = [age](int x) mutable->int {
    age += x; // 这里修改的只是 age 的拷贝，外部 age 的值没变化
    return age;
};

cout << "before call lambda add_age, age : " << age << endl;
int new_age = add_age(9);
cout << "after call lambda add_age, age : " << age << ", new_age : " << new_age << endl;

```

输出：

```shell
before call lambda add_age, age : 29
after call lambda add_age, age : 29, new_age : 38
```



#### -> 返回值类型

标识函数返回值的类型，当返回值为 void，或者函数体中只有一处 return 的地方（此时编译器可以自动推断出返回值类型）

时，这部分可以省略。

下面两种声明是等效的

```c++
[](int x) -> void { x ++; };
[](int x) { x ++; };	
```

#### {函数体}

标识函数的实现，这部分不能省略，但函数体可以为空。

#### 示例

基本声明

```c++
[] (int x, int y) { return x + y; } // 隐式返回类型

[] (int& x) { ++x; } // 没有 return 语句 -> Lambda 函数的返回类型是 'void'

[] () { ++global_x; } // 没有参数，仅访问某个全局变量

[] { ++global_x; } // 与上一个相同，省略了 (操作符重载函数参数)
```

**Lambda** 函数是一个依赖于实现的函数对象类型,这个类型的名字只有编译器知道。如果用户想把 lambda 函数做为一个参数来传递, 那么形参的类型必须是模板类型或者必须能创建一个 `std::function` 类似的对象去捕获 lambda 函数。使用 `auto` 关键字可以帮助存储 lambda 函数。

(下面的例子里面都会先通过auto来声明lambda表达式变量，然后再调用。)

**[ = ]， func1 所在作用域中，会按值捕获所有局部变量**

**下面示例的lambda 捕获了 a,b,c 三个局部变量的拷贝，但是不能修改它们的值。**

```c++
int a = 1, b = 2, c = 3;

auto func1 = [ = ](int x, int y)->int {
    return a + b + x + y;
};

int res_func1 = func1(4, 5);
cout << "func1 result : " << res_func1 << endl;

/*
输出：
func1 result : 12
*/

// 要是想修改拷贝的值，可以加上mutable修饰符
auto func1_1 = [ = ](int x, int y) mutable->int {
    a = 99;
    b = 88;
    return a + b + x + y;
};

int res_func1_1 = func1_1(4, 5);
cout << "func1_1 result : " << res_func1_1 << endl;

```

**[ =, &a, &b ]， 在 lambda 所在作用域中，会按值捕获除了 a 和 b 之外的所有局部变量，a 和 b 都是按引用捕获**。

```c++
int a = 1, b = 2, c = 3;
auto func2 = [ =, &a, &b ](int x)->int {
    a = x; // 由于&a的存在，在lambda函数体内部可以改变变量 a 的值
    return a + b + c;
};

cout << "before call func2, a : " << a << ", b : " << b << endl;
int res_func2 = func2(8);
cout << "after call func2, a : " << a << ", b : " << b << ", result : " << res_func2 << endl;

/*
输出
before call func2, a : 1, b : 2
after call func2, a : 8, b : 2, result : 13
*/

// auto func2 = [&a, &b](int x) -> int {
// a = x; // 由于&a的存在，在lambda函数体内部可以改变变量 a 的值
// return a + b + c; // 报错，因为函数对象参数中没有写 =， 所以不能使用func2所在作用域中的局部变量 c
// };

```

**[&, c]， 在 func3 所在作用域中，只会按值捕获局部变量 c，其他局部变量都是按引用捕获。**

```c++
int a = 1, b = 2, c = 3;

auto func3 = [&, c] (int x)->int {
    a = 10; // 改变 a 的值，会影响外部变量的值
    b = 20; // 改变 b 的值，会影响外部变量的值
    return a + b + c;
};

cout << "before call func3, a : " << a << ", b : " << b << endl;
int res_func3 = func3(9);
cout << "after call func3, a : " << a << ", b : " << b << ", result : " << res_func3 << endl;

/*
输出
before call func3, a : 8, b : 2
after call func3, a : 10, b : 20, result : 33
*/

```

**访问或修改定义在当前文件中的全局变量（outside_global_var），无需指定任何捕获。**

```c++
int outside_global_var = 199;

void lambda_study()
{
    auto func5 = [] ()->void {
        outside_global_var += 10;
    };
}
```

**访问或修改当前作用域中的静态变量（static_in_main_var），无需指定任何捕获。**

```c++
void lambda_study()
{
    static int static_in_main_var = 88;
    auto func6 = []() {
        static_in_main_var += 10;
    };
}
```

**一个没有指定任何捕获的 lambda 函数, 可以显式转换成一个具有相同声明形式函数指，也可以被std::function类型的对象捕获**

```c++
auto func7 = [](int x, int y) -> int {
        cout << "lambda body of func7" << endl;
        return x + y;
    };

int (*func_pointer)(int, int); // 函数指针类型变量
func_pointer = func7;
std::function<int(int, int)> func_var = func7;
```

可以把匿名函数存储在变量、数组或 vector 中,并把它们当做命名参数来传递



参考：[https://www.cnblogs.com/jimodetiantang/p/9016826.html](https://www.cnblogs.com/jimodetiantang/p/9016826.html)

