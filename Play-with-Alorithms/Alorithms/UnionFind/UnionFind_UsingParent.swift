import Foundation

// MARK: - ------------- review : 2020 / 8 / 26

/*
 使用parent数组是为了提高union方法的效率
 find(n)会通过parent数组的帮助找到 n 结点的根节点
 那么在union(u,v)的时候，就不需要遍历了，直接设置 parent[find(u)] = find(v) 即可
 */
public class UnionFind_UsingParent: UnionFind_Simple {
    public var parents: [Int] = []

    override init() {
        super.init()
        unionFindName = "UnionFind_UsingParent"
    }

    public convenience init(capacity: Int) {
        self.init()
        for i in 0 ..< capacity {
            idArray.append(i)
            parents.append(i)
        }
    }

    // 找到元素的根节点
    override public func find(_ p: Int) -> Int {
        var p = p
        if p > idArray.count - 1 || p < 0 {
            return UnionFind_NotFound
        }
        while p != parents[p] {
            // 如果vp的parent节点不是自己，那么说明p不是根节点，那么向上继续查找
            p = parents[p]
        }
        return p
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
        parents[pRoot] = qRoot
    }
}
