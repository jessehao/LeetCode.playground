/*:
 [Previous](@previous)
 
 给定一个整数数组 nums 和一个目标值 target，请你在该数组中找出和为目标值的那 两个 整数，并返回他们的数组下标。
 你可以假设每种输入只会对应一个答案。但是，数组中同一个元素不能使用两遍。
 
 示例:
 
 给定 `nums = [2, 7, 11, 15]`, `target = 9`
 
 因为 `nums[0] + nums[1] = 2 + 7 = 9`
 
 所以返回 `[0, 1]`
 */
struct Solution {
    func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
        var i = 0
        while i < nums.count - 1 {
            defer {
                i += 1
            }
            var j = i + 1
            while j < nums.count {
                defer {
                    j += 1
                }
                if nums[i] + nums[j] == target {
                    return [i, j]
                }
            }
        }
        return []
    }
}

Solution().twoSum([2, 7, 11, 15], 9) == [0, 1]
Solution().twoSum([1, 2, 3, 4, 5, 6], 9) == [2, 5]
Solution().twoSum([0,4,3,0], 0) == [0, 3]
Solution().twoSum([-1,-2,-3,-4,-5], -8) == [2, 4]

struct Solution_HashMap {
    func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
        let enumerated = nums.enumerated()
        let dict = Dictionary(enumerated.map {($0.element, $0.offset)}, uniquingKeysWith: { $1 })
        for e in enumerated {
            if let i = dict[target - e.element], i != e.offset {
                return [e.offset, i]
            }
        }
        return []
    }
}

Solution_HashMap().twoSum([2, 7, 11, 15], 9) == [0, 1]
Solution_HashMap().twoSum([1, 2, 3, 4, 5, 6], 9) == [2, 5]
Solution_HashMap().twoSum([0, 4, 3, 0], 0)// == [0, 3]
Solution_HashMap().twoSum([-1,-2,-3,-4,-5], -8) == [2, 4]
Solution_HashMap().twoSum([3, 2, 4], 6) == [1, 2]
//Solution_HashMap().twoSum([3, 3, 3], 6) == [0, 1] // 不会出现这种情况，因为每种输入只会对应一个答案

//: [Next](@next)
