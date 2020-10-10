//
//  string_num_transform_study.cpp
//  StudyCpp
//
//  Created by fn-273 on 2020/10/9.
//  Copyright © 2020 ZhengYi. All rights reserved.
//

#include "string_num_transform_study.hpp"
#include <iostream>
#include <sstream>

using namespace std;

string int_to_string_with_stream(int n);
int string_to_int_with_stream(string s);
float string_to_float_with_stream(string s);

void string_num_transform_study()
{
    // 使用字符串流对象进行数字转换 istringstream 和 ostringstream
    // 字符 -> 数字
    /*
     要使用 istringstream 和 ostringstream 需要先导入下面两个头文件
     #include <sstream>
     #include <iostream>
     */
    string s1 = "willson 80 90";
    istringstream istr1 = istringstream(s1);
    string name1;
    int n1, n2;
    // 按照输入字符串中内容的顺序依次输入给对应的变量
    istr1 >> name1 >> n1 >> n2;
    cout << name1 << " , " << n1 << " , " << n2 << endl;
    // 输出：willson , 80 , 90

    string s2 = "231.234 hello 87";
    istringstream istr2(s2);
    string name2;
    float fn1, fn2;
    istr2 >> fn1 >> name2 >> fn2;
    cout << fn1 << " , " << name2 <<  " , " << fn2 << endl;
    // 输出：231.234 , hello , 87

    // 重新输入并不会改变变量的值。例如 fn1 和 fn2 在上面的输入之后值应该分别为 231.234 和 87,
    // 但是在下面的语句执行完之后 fn1 的值应该是 87, fn2 的值应该是 231.234 ，
    // 通过cout输出之后发现 fn1 和 fn2 的值并没有改变。
    istr2 >> fn2 >> name2 >> fn1;
    cout << fn2 << " , " << name2 <<  " , " << fn1 << endl;
    // 输出：87 , hello , 231.234

    const char *s3 = "13.45 will 99";
    istringstream istr3(s3);
    int in1;
    string name3;
    float fn1_1;
    /*
     将 13.45 输入到整型变量 in1 之后，in1 只会接收小数点之前的内容即 13，
     而小数点之后的内容会输入给 name3, 而之后的字符串 will，则会交给 fn1_1，
     但是因为类型不匹配，所以 fn1_1 的值是 0。
     所以在使用 istringstream 输入内容给多个变量的时候，要注意内容和变量的类型匹配。
     */
    istr3 >> in1 >> name3 >> fn1_1;
    cout << in1 << " , " << name3 << " , " << fn1_1 << endl;
    // 输出：13 , .45 , 0

    // 数字 -> 字符
    // 需要注意：如果输入字符串包含多个值，需要用一个或多个空格分隔，其他字符都无效。
    istringstream input("90  100     110");
    ostringstream output;
    //istringstream input("90,100,110");
    //上面的 90,100,110 会导致 a 为 90，b 和 c 都为 0。
    int a, b, c;
    input >> a >> b >> c;
    output << (a + b + c);
    string sum_str = output.str();
    cout << "input nums , a : " << a << " , b : " << b << ", c " << c << endl;
    cout << "sum : " << sum_str << endl;

    string res1 = int_to_string_with_stream(192);
    cout << "res1 : " << res1 << endl;
    // 输出：res1 : 192

    int res2 = string_to_int_with_stream("923");
    cout << "res2 : " << res2 << endl;
    // 输出：res2 : 923

    float res3 = string_to_float_with_stream("19.34");
    cout << "res3 : " << res3 << endl;
    // 输出：res3 : 19.34

    // ===== 使用 stringstream 类进行转换
    // stringstream 相当于 istringstream 和 ostringstream 的整合
    stringstream stream;
    float num_float = 32.12;
    string num_float_str;
    // 使用 流插入操作符 << 将数据输入给 stringstream。
    stream << num_float;
    // 然后使用 流提取操作符 >> 将 stringstream 中的数据输出到 num_float_str 字符串变量中。
    stream >> num_float_str;
    cout << "num_float_str : " << num_float_str << endl;
    // 输出：num_float_str : 32.12

    stringstream stream2 = stringstream("99.45");
    float num_float_1;
    stream2 >> num_float_1;
    cout << "num_float_1 : " << num_float_1 << endl;
    // 输出：num_float_1 : 99.45

    // 使用数字转换函数
    // 数字转字符串
    int var_int = 199;
    long var_long = 234000000;
    float var_float = 89.9;
    float var_double = 12.34567;

    string var_int_str = to_string(var_int);
    string var_float_str = to_string(var_float);
    string var_long_str = to_string(var_long);
    string var_double_str = to_string(var_double);

    cout << "var_int_str : " << var_int_str << endl;
    cout << "var_float_str : " << var_float_str << endl;
    cout << "var_long_str : " << var_long_str << endl;
    cout << "var_double_str : " << var_double_str << endl;
    /*
     输出：
     var_int_str : 199
     var_float_str : 89.900002
     var_long_str : 234000000
     var_double_str : 12.345670
     */

    // 字符串转数字
    string var_str_int = "989";
    string var_str_long = "1239000000";
    string var_str_float = "989.12";
    string var_str_double = "345.98908812";

    int val_int = stoi(var_str_int);
    long val_long = stol(var_str_long);
    float val_float = stof(var_str_float);
    double val_double = stod(var_str_double);

    cout << "val_int    : " << val_int << endl;
    cout << "val_long   : " << val_long << endl;
    cout << "val_float  : " << val_float << endl;
    cout << "val_double : " << val_double << endl;
    /*
     输出：
     val_int    : 989
     val_long   : 1239000000
     val_float  : 989.12
     val_double : 345.989
     */

    /*
     int stoi(const strings str, size_t* pos = 0, int base = 10)
     long stol(const strings str, size_t* pos = 0, int base = 10)
     float stof(const strings str, size_t* pos = 0)
     double stod(const strings str, size_t* pos = 0)

     pos : 保存了 str 中无法被转换的第一个字符的索引位置，例如 123abc，那么pos=3
     base : 用于转换的进制，默认值是10，即十进制，2位二进制。
     */
    string val_str_int_1 = "123abd";
    // 2进制不需要加0b前缀
    string val_str_int_2 = "0001110abd";
    size_t pos_1;
    size_t pos_2;
    int val_int_1 = stoi(val_str_int_1, &pos_1, 10);
    int val_int_2 = stoi(val_str_int_2, &pos_2, 2);
    cout << "val_int_1 : " << val_int_1 << ", pos : " << pos_1 << endl;
    cout << "val_int_2 : " << val_int_2 << ", pos : " << pos_2 << endl;
    /*
     val_int_1 : 123, pos : 3
     val_int_2 : 14, pos : 7
     */
}

float string_to_float_with_stream(string s)
{
    //    istringstream is(s);
    //    float ret;
    //    is >> ret;
    //    return ret;
    stringstream stream(s);
    float ret;
    stream >> ret;
    return ret;
}

int string_to_int_with_stream(string s)
{
//    istringstream is(s);
//    int ret;
//    is >> ret;
//    return ret;
    stringstream stream(s);
    int ret;
    stream >> ret;
    return ret;
}

string int_to_string_with_stream(int n)
{
//    ostringstream ostream;
//    ostream << n;
//    return ostream.str();
    stringstream stream;
    stream << n;
    return stream.str();
}
