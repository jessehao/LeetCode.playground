/*:
 [Previous](@previous)
 
 你的朋友正在使用键盘输入他的名字`name`。偶尔，在键入字符`c`时，按键可能会被长按，而字符可能被输入 1 次或多次。

 你将会检查键盘输入的字符`typed`。如果它对应的可能是你的朋友的名字（其中一些字符可能被长按），那么就返回`True`。

 示例 1：

 ```
 输入：name = "alex", typed = "aaleex"
 输出：true
 解释：'alex' 中的 'a' 和 'e' 被长按。
 ```
 
 示例 2：

 ```
 输入：name = "saeed", typed = "ssaaedd"
 输出：false
 解释：'e' 一定需要被键入两次，但在 typed 的输出中不是这样。
 ```
 
 示例 3：

 ```
 输入：name = "leelee", typed = "lleeelee"
 输出：true
 ```
 
 示例 4：

 ```
 输入：name = "laiden", typed = "laiden"
 输出：true
 解释：长按名字中的字符并不是必要的。
 ```

 提示：

 1. `name.length <= 1000`
 2. `typed.length <= 1000`
 3. `name` 和 `typed` 的字符都是小写字母。

 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/long-pressed-name
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 
 */
// 两个方案的时间和空间损耗一样，第一个写法稍微简短些，后一个好理解。

/// 依赖交换Iterator
func _isLongPressedName(_ name: String, _ typed: String) -> Bool {
    var nameIter = name.makeIterator()
    var typedIter = typed.makeIterator()
    while let comparing = nameIter.next() {
        print("comparing: \(comparing)")
        if comparing == typedIter.next() {
            var nameRepeater = nameIter
            var nameCount = 0
            while let c = nameRepeater.next(), c == comparing {
                nameCount += 1
                nameIter = nameRepeater
            }
            var typedRepeater = typedIter
            var typedCount = 0
            while let c = typedRepeater.next(), c == comparing {
                typedCount += 1
                typedIter = typedRepeater
            }
            if typedCount < nameCount {
                return false
            }
        } else {
            return false
        }
    }
    return typedIter.next() == nil
}

/// 依赖临时Character
func isLongPressedName(_ name: String, _ typed: String) -> Bool {
    var nameIter = name.makeIterator()
    var typedIter = typed.makeIterator()
    var comparing:Character?
    var forward = nameIter.next()
    var forwardTyped = typedIter.next()
    while forward != nil {
        if forward != forwardTyped {
            return false
        }
        comparing = forward
        
        var nameCurCount = 0
        repeat {
            forward = nameIter.next()
            if forward == comparing {
                nameCurCount += 1
            }
        } while forward == comparing
        
        var typedCurCount = 0
        repeat {
            forwardTyped = typedIter.next()
            if forwardTyped == comparing {
                typedCurCount += 1
            }
        } while forwardTyped == comparing
        
        if nameCurCount > typedCurCount {
            return false
        }
    }
    return forwardTyped == nil
}

//assert(isLongPressedName("alex", "aaleex"))
//assert(isLongPressedName("alex", "aaleex"))
//assert(isLongPressedName("saeed", "ssaaedd") == false)
//assert(isLongPressedName("leelee", "lleeelee"))
//assert(isLongPressedName("laiden", "laiden"))
//assert(isLongPressedName("xnhtq", "xhhttqq") == false) // X
//print(isLongPressedName("alex", "alexxr") == false) // X
assert(isLongPressedName("ax", "axxxxxxxxxxxxxxxxxxxxxxx"))
//: [Next](@next)
