/*:
 [Previous](@previous)
 
 763. 划分字母区间
 
 字符串`S` 由小写字母组成。我们要把这个字符串划分为尽可能多的片段，同一个字母只会出现在其中的一个片段。返回一个表示每个字符串片段的长度的列表。

  

 示例 1：

 ```
 输入：S = "ababcbacadefegdehijhklij"
 输出：[9,7,8]
 解释：
 划分结果为 "ababcbaca", "defegde", "hijhklij"。
 每个字母最多出现在一个片段中。
 像 "ababcbacadefegde", "hijhklij" 的划分是错误的，因为划分的片段数较少。
 ```

 提示：

 - `S`的长度在`[1, 500]`之间。
 - `S`只包含小写字母`'a'`到`'z'`。


 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/partition-labels
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */

func partitionLabels_first(_ S: String) -> [Int] {
    var rangeDict:[String.Element : (Int, Int)] = [:]
    S.enumerated().forEach { index, char in // O(n)
        if var exist = rangeDict[char] {
            exist.1 = index
            rangeDict[char] = exist
        } else {
            rangeDict[char] = (index, index)
        }
    }
    print(rangeDict)
    let ranges:[(Int, Int)] = rangeDict.values.reduce(into: []) { retval, next in
        guard !retval.isEmpty else {
            retval.append(next)
            return
        }
        var firstHitIndex:Int?
        var lastHitIndex:Int?
        var deleting:[Int] = []
        for i in 0..<retval.count {
            let e = retval[i]
            var hit = false
            if firstHitIndex == nil && next.0 < e.1 && next.0 > e.0 {
                firstHitIndex = i
                hit = true
            }
            if lastHitIndex == nil && next.1 < e.1 && next.1 > e.0 {
                lastHitIndex = i
                hit = true
            }
            if !hit && next.1 > e.1 && next.0 < e.0 {
                deleting.append(i)
            }
            if firstHitIndex != nil && lastHitIndex != nil {
                break
            }
        }
        let left = firstHitIndex.map { retval[$0].0 } ?? next.0
        let right = lastHitIndex.map { retval[$0].1 } ?? next.1
        retval.append((left, right))
        if let bingo = lastHitIndex {
            deleting.append(bingo)
        }
        if let bingo = firstHitIndex, bingo != lastHitIndex {
            deleting.append(bingo)
        }
        deleting.sorted().reversed().forEach { retval.remove(at: $0) }
        print("after \(next) = \(retval)")
    }
    let sorted = ranges.sorted { $0.0 < $1.0 }
    print("ranges: \(sorted)")
    return sorted.map { $0.1 - $0.0 + 1 }
}

func partitionLabels(_ S: String) -> [Int] {
    let chars = S.utf8CString
    let baseOffset:Int8 = 97 // ASCII of 'a'
    var lastIndices:[Int] = .init(repeating: -1, count: 26)
    for i in 0..<chars.count - 1 {
        let index = Int(chars[i] - baseOffset)
        lastIndices[index] = i
    }
    var start = 0
    var end = 0
    var retval:[Int] = []
    for i in 0..<chars.count - 1 {
        end = max(end, lastIndices[Int(chars[i] - baseOffset)])
        if i == end {
            retval.append(end - start + 1)
            start = end + 1
        }
    }
    return retval
}



print(partitionLabels("ababcbacadefegdehijhklij")) // [9, 7, 8]

//: [Next](@next)
