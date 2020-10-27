/*:
 [Previous](@previous)
 
 运用你所掌握的数据结构，设计和实现一个[LRU](https://baike.baidu.com/item/LRU)(最近最少使用) 缓存机制。它应该支持以下操作： 获取数据`get`和写入数据`put`。

 获取数据`get(key)` - 如果关键字 (key) 存在于缓存中，则获取关键字的值（总是正数），否则返回 -1。
 写入数据`put(key, value)` - 如果关键字已经存在，则变更其数据值；如果关键字不存在，则插入该组「关键字/值」。当缓存容量达到上限时，它应该在写入新数据之前删除最久未使用的数据值，从而为新的数据值留出空间。

  

 进阶:

 你是否可以在**O(1)**时间复杂度内完成这两种操作？

 示例：
 ```
 LRUCache cache = new LRUCache( 2 ); // 缓存容量

 cache.put(1, 1);
 cache.put(2, 2);
 cache.get(1);       // 返回  1
 cache.put(3, 3);    // 该操作会使得关键字 2 作废
 cache.get(2);       // 返回 -1 (未找到)
 cache.put(4, 4);    // 该操作会使得关键字 1 作废
 cache.get(1);       // 返回 -1 (未找到)
 cache.get(3);       // 返回  3
 cache.get(4);       // 返回  4
 ```
*/
print("starto!")

class Node {
    let key:Int
    var value:Int
    var next:Node?
    weak var prev:Node?
    
    init(_ key:Int, _ value:Int) {
        self.key = key
        self.value = value
    }
}

class LRUCache {
    let capacity:Int
    var dict:[Int : Node] = [:]
    // 最新的在头部
    var head:Node?
    weak var tail:Node?

    init(_ capacity: Int) {
        self.capacity = capacity
    }

    func get(_ key: Int) -> Int {
//        defer { print("after get [\(key)] = \(self) dict: \(dict)") }
        guard let node = dict[key] else {
            return -1
        }
        moveToHead(node)
        return node.value
    }

    func put(_ key: Int, _ value: Int) {
//        defer { print("after put [\(key): \(value)] = \(self) dict: \(dict)") }
        if let node = dict[key] {
            node.value = value
            moveToHead(node)
        } else {
            if dict.count >= capacity {
                removeTail()
            }
            let new = Node(key, value)
            dict[key] = new
            addToHead(new)
        }
    }
    
    func removeTail() {
        guard let tail = tail else { return }
        removeNode(tail)
        dict.removeValue(forKey: tail.key)
    }
    
    func removeNode(_ node:Node) {
//        print("removing: \(node.prev?.value ?? -1) <- (\(node.value)) -> \(node.next?.value ?? -1)")
        if node === tail {
            tail = node.prev
        }
        node.prev?.next = node.next
        node.next?.prev = node.prev
        node.next = nil
        node.prev = nil
//        print("after removing [\(node.key)] = \(self)")
    }
    
    func addToHead(_ node:Node) {
        if let head = self.head {
            head.prev = node
            node.next = head
        } else {
            tail = node
        }
        self.head = node
    }
    
    func moveToHead(_ node:Node) {
        guard node !== head else { return }
        removeNode(node)
        addToHead(node)
    }
}

extension LRUCache : CustomDebugStringConvertible {
    var debugDescription: String {
        "\(head?.debugDescription ?? "NULL") (tail:\(tail?.debugDescription ?? "NULL"))"
    }
}

extension Node : CustomDebugStringConvertible {
    var debugDescription: String {
        if let next = next {
            return "\(value) -> \(next)"
        } else {
            return "\(value)"
        }
    }
}

let lru = LRUCache(2)
lru.put(1, 1)
lru.put(2, 2)
lru.get(1)
lru.put(3, 3)
lru.get(2)
lru.put(4, 4)
lru.get(1)
lru.get(3)
lru.get(4)

print("----")

let lru1 = LRUCache(3)
(1...4).forEach {
    lru1.put($0, $0)
}
(1...4).reversed().forEach {
    _ = lru1.get($0)
}
lru1.put(5, 5)
(1...5).forEach {
    _ = lru1.get($0)
}

/**
 * Your LRUCache object will be instantiated and called as such:
 * let obj = LRUCache(capacity)
 * let ret_1: Int = obj.get(key)
 * obj.put(key, value)
 */
//: [Next](@next)
