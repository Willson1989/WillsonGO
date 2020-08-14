import Foundation

public typealias iteratorBlock = (_ v : Int) -> ()

public let INFINITY : Int = 65535
public let INFINITY_F : Float = 65535.0

public class Graph {
    
    internal var num_vertex : Int = 0
    internal var num_edge : Int = 0
    internal var num_components : Int = 0
    internal var isDirected : Bool = false
    internal var visited : [Bool] = []
    
    //遍历图的时候，num_components会自增，connectIds 用来存储各个阶段的 num_components，
    //用来标识顶点之间的连通关系。connectIds[v] 和 connectIds[w]的值相等的话，代表v和w相连
    internal var connectIds : [Int] = []
    
    internal init() {
        self.num_vertex = 0
        self.num_edge = 0
        self.num_components = 0
    }
    
    internal init(capacity : Int, directed : Bool) {
        self.num_vertex = capacity
        self.num_edge = 0
        self.num_components = 0
        self.isDirected = directed
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
        return self.num_vertex
    }
    
    //MARK: - 返回图中边的个数
    public func E() -> Int {
        return self.num_edge
    }
    
    //MARK: - 返回连通分量的个数
    public func C() -> Int {
        return self.num_components
    }
    
    //MARK: - 检查下标是否越界
    internal func isAvaliable( _ v : Int ) -> Bool {
        return ( v >= 0 && v < self.num_vertex )
    }
    
    //MARK: - 使用block来遍历每个节点
    public func iterateGraph(forVertex v: Int, _ iteration : iteratorBlock) { }
    
    //MARK: - 打印输出图
    public func show(){ }
    
    //MARK: - 初始化 visited 数组
    internal func initVisitedArray() {
        self.num_components = 0
        self.visited = Array(repeating: false, count: self.num_vertex)
    }
    
    //MARK: - 初始化 connectIds 数组
    internal func initConnectIdArray() {
        self.connectIds = Array(repeating: -1, count: self.num_vertex)
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
        for i in 0 ..< self.num_vertex {
            if self.visited[i] == false {
                self.dfs(v: i, iteration: iteration)
                self.num_components += 1
            }
        }
    }
    
    //MARK: - 图的深度优先遍历（由于用来存储图的数据结构不同，这里需要各个Graph子类重写dfs方法）
    internal func dfs(v : Int, iteration : iteratorBlock?){ }

}










