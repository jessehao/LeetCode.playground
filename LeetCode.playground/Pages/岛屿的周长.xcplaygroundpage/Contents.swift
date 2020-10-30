//: [Previous](@previous)
/*:
 给定一个包含 0 和 1 的二维网格地图，其中 1 表示陆地 0 表示水域。

 网格中的格子水平和垂直方向相连（对角线方向不相连）。整个网格被水完全包围，但其中恰好有一个岛屿（或者说，一个或多个表示陆地的格子相连组成的岛屿）。

 岛屿中没有“湖”（“湖” 指水域在岛屿内部且不和岛屿周围的水相连）。格子是边长为 1 的正方形。网格为长方形，且宽度和高度均不超过 100 。计算这个岛屿的周长。


 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/island-perimeter
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */

import Foundation

func islandPerimeter(_ grid: [[Int]]) -> Int {
    var ret = 0
    for i in 0..<grid.count {
        for j in 0..<grid[i].count {
            if grid[i][j] == 1 {
                ret += 4
                if i > 0 && grid[i - 1][j] == 1 {
                    ret -= 2
                }
                if j > 0 && grid[i][j - 1] == 1 {
                    ret -= 2
                }
            }
        }
    }
    return ret
}

islandPerimeter([[0,1,0,0],
                [1,1,1,0],
                [0,1,0,0],
                [1,1,0,0]])

//assert(islandPerimeter([[1, 0]]) == 4)

//: [Next](@next)
