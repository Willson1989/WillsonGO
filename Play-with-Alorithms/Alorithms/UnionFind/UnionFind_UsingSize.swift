import Foundation

// MARK: - ------------- review : 2020 / 8 / 26

public class UnionFind_UsingSize: UnionFind_UsingParent {
    // size[i] 表示以 i 为根的集合中的元素个数
    public var size: [Int] = []

    override init() {
        super.init()
        unionFindName = "UnionFind_UsingSize"
    }

    public convenience init(capacity: Int) {
        self.init()
        for i in 0 ..< capacity {
            idArray.append(i)
            parents.append(i)
            // 初始状态时，每一个节点的size都为1
            size.append(1)
        }
    }

    override public func union(_ p: Int, _ q: Int) {
        if p >= idArray.count || p < 0 ||
            q >= idArray.count || q < 0 {
            return
        }
        let pRoot = find(p)
        let qRoot = find(q)

        if pRoot == qRoot {
            return
        }
        if size[pRoot] < size[qRoot] {
            parents[pRoot] = qRoot
            size[qRoot] += size[pRoot]
        } else {
            parents[qRoot] = pRoot
            size[pRoot] += size[qRoot]
        }
    }
}
