import Foundation

// MARK: - ------------- review : 2020 / 8 / 26

/*
 UnionFind_CompressPath_01 和 UnionFind_CompressPath_02 都是在 find(n) 的时候通过减少n所处的层数来达到提高遍历效率的目的。

 01 是跨级压缩，在find(n)的时候，使n的父节点指向n的祖父结点，即parent[n] = parent[parent[n]]。
 02 是根节点压缩，在find(n)的时候，通过递归最终让 n 及其所有的上级结点都指向 n 的根节点，
 这样的话，在find(n)的时候，他所有的上级结点的层数都为2了(根节点层数为1)

 显然 02的路径压缩比例是最大的，但是在初次查找的时候效率会相对01低一些(因为要递归改变遍历路径上的结点层级)。
 */
public class UnionFind_CompressPath_01: UnionFind_UsingRank {
    override init() {
        super.init()
        unionFindName = "UnionFind_CompressPath"
    }

    override public func find(_ p: Int) -> Int {
        if p >= idArray.count || p < 0 {
            return UnionFind_NotFound
        }
        var p = p
        // 路径压缩：如果p的父节点不是自己，那么让p的父节点指向p的祖父节点即parents[parents[p]]
        // 这样的话，会降低该节点所处的集合的层数，提高遍历效率
        while p != parents[p] {
            parents[p] = parents[parents[p]]
            p = parents[p]
        }
        return p
    }
}

public class UnionFind_CompressPath_02: UnionFind_UsingRank {
    override init() {
        super.init()
        unionFindName = "UnionFind_CompressPath"
    }

    override public func find(_ p: Int) -> Int {
        if p >= idArray.count || p < 0 {
            return UnionFind_NotFound
        }

        if p != parents[p] {
            parents[p] = find(parents[p])
        }
        return parents[p]
    }
}
