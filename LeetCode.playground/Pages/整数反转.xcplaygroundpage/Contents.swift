//: [Previous](@previous)
/*:
 给出一个 32 位的有符号整数，你需要将这个整数中每位上的数字进行反转。

 示例 1:
 ```
 输入: 123
 输出: 321
 ```
 
  示例 2:
 ```
 输入: -123
 输出: -321
 ```
 
 示例 3:
 ```
 输入: 120
 输出: 21
 ```
 
 注意:

 假设我们的环境只能存储得下 32 位的有符号整数，则其数值范围为 [−2^31,  2^31 − 1]。请根据这个假设，如果反转后整数溢出那么就返回 0。

 */
struct Solution {
    func reverse(_ x: Int) -> Int {
        var int = x
        var ret = 0
        while int != 0 {
            let frac = int % 10
            ret = ret * 10 + frac
            if ret > Int32.max || ret < Int32.min {
                return 0
            }
            int /= 10
        }
        return ret
    }
}

Solution().reverse(123) == 321
Solution().reverse(-123) == -321
Solution().reverse(120) == 21
Solution().reverse(1534236469) == 0
//: [Next](@next)
