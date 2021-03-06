//: [Previous](@previous)
/*:
 给定一个链表，判断链表中是否有环。

 如果链表中有某个节点，可以通过连续跟踪`next`指针再次到达，则链表中存在环。 为了表示给定链表中的环，我们使用整数`pos`来表示链表尾连接到链表中的位置（索引从 0 开始）。 如果`pos`是`-1`，则在该链表中没有环。注意：`pos` 不作为参数进行传递，仅仅是为了标识链表的实际情况。

 如果链表中存在环，则返回`true`。 否则，返回`false`。

  

 进阶：

 你能用*O(1)*（即，常量）内存解决此问题吗？

 提示：

 - 链表中节点的数目范围是`[0, 104]`
 - `-105 <= Node.val <= 105`
 - `pos`为`-1`或者链表中的一个**有效索引**。
 
 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/linked-list-cycle
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */

public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init(_ val: Int) {
        self.val = val
        self.next = nil
    }
}

/// 龟兔赛跑
func hasCycle(_ head: ListNode?) -> Bool {
    guard head != nil && head?.next != nil else { return false }
    var slow = head
    var fast = head?.next
    while slow !== fast {
        if fast == nil {
            return false
        }
        slow = slow?.next
        fast = fast?.next?.next
    }
    return true
}

let n1 = ListNode(1)
let n2 = ListNode(2)
n1.next = n2
let n3 = ListNode(3)
n2.next = n3
let n4 = ListNode(4)
n3.next = n4
n4.next = n1
assert(hasCycle(n1) == true)
assert(hasCycle(nil) == false)
//: [Next](@next)
