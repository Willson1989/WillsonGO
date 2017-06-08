import Foundation

/*
 稀疏图
 适合用  邻接表(链表)  来标识
 */

public let INFINITY : Int = 65535

//边表节点
internal class EdgeNode {
    public var vertex : Int = -1
    public var weight : Int = INFINITY
    public var next : EdgeNode?
    
    init(vertex : Int , weight : Int = INFINITY) {
        self.vertex = vertex
        self.weight = weight
        self.next = nil
    }
}

//顶点表节点
internal class VertexNode {
    public var data : Any?
    public var vertex : Int = -1
    public var firstBridge : EdgeNode?
    
    init(vertex : Int, data : Any?) {
        self.data = data
        self.vertex = vertex
        self.firstBridge = nil
    }
}

public class SparseGraph_AdjList : Graph {
    
    fileprivate var graph : [VertexNode] = []
    
    public init(capacity : Int , directed : Bool) {
        super.init()
        self.num_Edge = 0
        self.num_Vertex = capacity
        self.isDirected = directed
        for i in 0 ..< capacity {
            let v = VertexNode(vertex: i, data: nil)
            self.graph.append(v)
        }
    }
    
    public init(dataArray : [Any], directed : Bool) {
        super.init()
        self.num_Vertex = dataArray.count
        self.num_Edge = 0
        self.isDirected = directed
        for i in 0 ..< dataArray.count {
            let data = dataArray[i]
            let v = VertexNode(vertex: i, data: data)
            self.graph.append(v)
        }
    }
    
    public override func addEdge(_ v: Int, _ w: Int) {
        if !isAvaliable(v) || !isAvaliable(w) {
            return
        }
        if hasEdge(v, w) {
            return
        }
        if v == w { //不添加自环边
            return
        }
        let ew = EdgeNode(vertex: w)
        let vexV = graph[v]
        ew.next = vexV.firstBridge
        vexV.firstBridge = ew
        if !isDirected {
            let ev = EdgeNode(vertex: v)
            let vexW = graph[w]
            ev.next = vexW.firstBridge
            vexW.firstBridge = ev
        }
        num_Edge += 1
    }
    
    internal override func dfs(v: Int, iteration: iteratorBlock?) {

        self.visited[v] = true
        iteration?(v)
        self.connectIds[v] = self.num_Components
        var p = graph[v].firstBridge
        while p != nil {
            if visited[p!.vertex] == false {
                self.dfs(v: p!.vertex, iteration: iteration)
            }
            p = p!.next
        }
    }
    
    public override func hasEdge(_ v: Int, _ w: Int) -> Bool {
        assert(self.isAvaliable(v))
        assert(self.isAvaliable(w))
        var p : EdgeNode? = self.graph[v].firstBridge
        while p != nil {
            if p!.vertex == w { return true }
            p = p!.next
        }
        return false
    }
    
    public override func show() {
        print("稀疏图 邻接表 ： \(self)")
        for i in 0 ..< self.num_Vertex {
            let v = String(format: "%03d", i)
            print("Vertex \(v) : ", separator: "", terminator: "")
            var p = graph[i].firstBridge
            while p != nil {
                print(p!.vertex, separator: "", terminator: " ")
                p = p!.next
            }
            print()
        }
        print()
    }
    
    public class Path : GraphPath {
        
        fileprivate var G : SparseGraph_AdjList!

        public init(graph : SparseGraph_AdjList, v : Int) {
            super.init(capacity: graph.V(), v: v)
            self.G = graph
            //寻路算法
            self.dfsFromVertex(self.V)
            print("from array : \(self.from)")
            print("visited array : \(self.visited)")
        }
        
        
        override func dfsFromVertex(_ v: Int) {
            self.visited[v] = true
            var p = self.G.graph[v].firstBridge
            while p != nil {
                if visited[p!.vertex] == false {
                    self.from[p!.vertex] = v
                    self.dfsFromVertex(p!.vertex)
                }
                p = p!.next
            }
        }
    }
}


