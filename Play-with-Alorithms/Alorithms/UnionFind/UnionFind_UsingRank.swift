import Foundation

// MARK: - ------------- review : 2020 / 8 / 26
public class UnionFind_UsingRank: UnionFind_UsingParent {
    // 存储元素对应的树的层数，rank[p] 表示以元素p为根的集合的层数
    public var rank: [Int] = []

    override init() {
        super.init()
        unionFindName = "UnionFind_UsingRank"
    }

    public convenience init(capacity: Int) {
        self.init()
        for i in 0 ..< capacity {
            idArray.append(i)
            parents.append(i)
            // 初始状态时，每一个节点都是根，层数都为1
            rank.append(1)
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

        if rank[pRoot] < rank[qRoot] {
            // p的层数小于 q的层数,让p 连接q
            parents[pRoot] = qRoot

        } else if rank[pRoot] > rank[qRoot] {
            // q的层数小于 p的层数,让q 连接p
            parents[qRoot] = pRoot

        } else {
            // 层数相同,self.rank[pRoot] == self.rank[qRoot]
            parents[qRoot] = pRoot
            rank[pRoot] += 1
        }
    }
}
