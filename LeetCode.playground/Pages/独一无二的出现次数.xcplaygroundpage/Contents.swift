//: [Previous](@previous)
/*:
 [Unique Number of Occurrences](https://leetcode-cn.com/problems/unique-number-of-occurrences/)
 
 给你一个整数数组`arr`，请你帮忙统计数组中每个数的出现次数。

 如果每个数的出现次数都是独一无二的，就返回`true`；否则返回`false`。
 **提示：**

 - `1 <= arr.length <= 1000`
 - `-1000 <= arr[i] <= 1000`
 
 */


func uniqueOccurrences(_ arr: [Int]) -> Bool {
    let countDict:[Int: Int] = arr.reduce(into: [:]) {
        $0[$1, default: 0] += 1
    }
    return Set(countDict.values).count == countDict.count
}

assert(uniqueOccurrences([1, 2, 2, 3, 3, 3]) == true)
assert(uniqueOccurrences([1, 2]) == false)

//: [Next](@next)
