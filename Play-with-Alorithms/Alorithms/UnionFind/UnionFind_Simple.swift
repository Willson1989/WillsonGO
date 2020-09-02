import Foundation

// MARK: - ------------- review : 2020 / 8 / 26

public class UnionFind_Simple: UFType {
    override init() {
        super.init()
        unionFindName = "UnionFind_Simple"
    }

    public convenience init(capacity: Int) {
        self.init()
        for i in 0 ..< capacity {
            idArray.append(i)
        }
    }

    override public func find(_ p: Int) -> Int {
        if p > idArray.count - 1 || p < 0 {
            return UnionFind_NotFound
        }
        return idArray[p]
    }

    override public func isConnected(_ p: Int, _ q: Int) -> Bool {
        if p >= idArray.count || p < 0 ||
            q >= idArray.count || q < 0 {
            return false
        }
        let fp = find(p)
        let fq = find(q)
        if fp == UnionFind_NotFound || fq == UnionFind_NotFound {
            return false
        }
        return fp == fq
    }

    override public func union(_ p: Int, _ q: Int) {
        if p >= idArray.count || p < 0 ||
            q >= idArray.count || q < 0 {
            return
        }
        let pId = find(p)
        let qId = find(q)

        if pId == qId {
            return
        }
        for i in 0 ..< idArray.count {
            if pId == idArray[i] {
                idArray[i] = qId
            }
        }
    }
}
