import Foundation

public typealias iteratorBlock = (_ v : Int) -> ()



public class Graph : NSObject {
    
    internal var num_Vertex : Int = 0
    internal var num_Edge : Int = 0
    internal var num_Components : Int = 0
    internal var isDirected : Bool = false
    internal var visited : [Bool] = []
    
    //遍历图的时候，num_Components会自增，connectIds用来存储各个阶段的num_Components，
    //用来标识顶点之间的连通关系。connectIds[v] 和 connectIds[w]的值相等的话，代表v和w相连
    internal var connectIds : [Int] = []
    
    override init() {
        super.init()
        self.num_Vertex = 0
        self.num_Edge = 0
        self.num_Components = 0
    }
    
    //MARK: - 在v和w之间添加一条边
    internal func addEdge(_ v : Int, _ w : Int ){ }
    
    //MARK: - 删除v和w之间的边
    public func deleteEdge(_ v : Int, _ w : Int) { }
    
    //MARK: - v 和 w 之间是否有边
    internal func hasEdge(_ v : Int, _ w : Int) -> Bool {
        return false
    }
    
    //MARK: - 返回图的顶点的个数
    public func V() -> Int {
        return self.num_Vertex
    }
    
    //MARK: - 返回图中边的个数
    public func E() -> Int {
        return self.num_Edge
    }
    
    //MARK: - 返回连通分量的个数
    public func C() -> Int {
        return self.num_Components
    }
    
    //MARK: - 检查下标是否越界
    internal func isAvaliable( _ v : Int ) -> Bool {
        return ( v >= 0 && v < self.num_Vertex )
    }
    
    //MARK: - 使用block来遍历每个节点
    public func iterateGraph(forVertex v: Int, _ iteration : iteratorBlock) { }
    
    //MARK: - 打印输出图
    public func show(){ }
    
    //MARK: - 初始化 visited 数组
    internal func initVisitedArray() {
        self.num_Components = 0
        self.visited = Array(repeating: false, count: self.num_Vertex)
    }
    
    //MARK: - 初始化 connectIds 数组
    internal func initConnectIdArray() {
        self.connectIds = Array(repeating: -1, count: self.num_Vertex)
    }
    
    //MARK: - 两个顶点是否连接
    public func isConnected( v : Int, w : Int) -> Bool {
        assert(self.isAvaliable(v) && self.isAvaliable(w))
        if v == w {
            return true
        }
        return self.connectIds[v] == self.connectIds[w]
    }
    
    //MARK: - 深度优先遍历的公用方法
    public func depthFirstSearch(iteration: iteratorBlock?) {
        self.initVisitedArray()
        self.initConnectIdArray()
        for i in 0 ..< self.num_Vertex {
            if self.visited[i] == false {
                self.dfs(v: i, iteration: iteration)
                self.num_Components += 1
            }
        }
    }
    
    //MARK: - 图的深度优先遍历（由于用来存储图的数据结构不同，这里需要各个Graph子类重写dfs方法）
    internal func dfs(v : Int, iteration : iteratorBlock?){ }

}


public class GraphPath{
    
    internal var visited : [Bool] = []
    internal var from : [Int] = []
    internal var V : Int = INFINITY
    internal var num_Vertex : Int = 0
    internal var distance : [Int] = [] //广度优先遍历 和 最短路径时使用
    
    internal init(capacity : Int, v : Int) {
        self.V = v
        self.num_Vertex = capacity
        self.initVisitedArray()
        self.initFromArray()
    }
    
    public func hasPath(with w : Int) -> Bool {
        assert( w >= 0 && w < self.num_Vertex )
        return self.visited[w]
    }
    
    public func path(with w : Int) -> [Int] {
        assert( w >= 0 && w < self.num_Vertex )
        var path = [Int]()
        var s = BasicStack()
        var k = w
        while k != -1 {
            s.push(k)
            k = self.from[k]
        }
        while !s.isEmpty() {
            path.append(s.pop() as! Int)
        }
        return path
    }
    
    public func showPath(with w : Int) {
        if w < 0 || w >= self.num_Vertex {
            return
        }
        let p = self.path(with: w)
        for i in 0 ..< p.count {
            print(p[i], separator: "", terminator: "")
            if i == p.count-1 {
                print()
            } else {
                print(" -> ", separator: "", terminator: "")
            }
        }
        print()
    }
    
    public func length(from w : Int) -> Int {
        return self.distance[w]
    }
    
    //深度优先遍历
    internal func dfsFromVertex(_ v : Int) { }
    
    //广度优先遍历
    internal func bfsFromVertex(_ v : Int) { }
    
    internal func initFromArray() {
        self.from = Array(repeating: -1, count: self.num_Vertex)
    }
    
    internal func initDistanceArray() {
        self.distance = Array(repeating: 0, count: self.num_Vertex)
    }
    
    internal func initVisitedArray() {
        self.visited = Array(repeating: false, count: self.num_Vertex)
    }
}








