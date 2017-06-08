import Foundation

/*
 稠密图
 适合用  邻接矩阵  来标识
 完全图：所有的节点和所有的节点都相连
 */
public class DenseGraph_Matrix : Graph{
    
    internal var graph : [[Bool]] = []
        
    public init(capacity : Int , directed : Bool) {
        super.init()
        self.num_Vertex = capacity
        self.num_Edge = 0
        self.isDirected = directed
        for _ in 0 ..< capacity {
            let tmp = Array(repeating: false, count: capacity)
            self.graph.append(tmp)
        }
    }
    
    public override func addEdge(_ v : Int, _ w : Int ) {
        if !isAvaliable(v) || !isAvaliable(w) {
            return
        }
        if hasEdge(v, w) == true {
            //如果v和w之间已经有边了，则不做任何操作
            return
        }
        graph[v][w] = true
        if !isDirected {
            //如果是无向图
            graph[w][v] = true
        }
        num_Edge += 1
    }
    
    internal override func dfs(v: Int, iteration: iteratorBlock?) {
        self.visited[v] = true
        iteration?(v)
        self.connectIds[v] = self.num_Components
        for i in 0 ..< self.graph[v].count {
            if self.graph[v][i] == true && self.visited[i] == false {
                self.dfs(v: i, iteration: iteration)
            }
        }
    }
    
    public override func iterateGraph(forVertex v: Int, _ iteration: (Int) -> ()) {
        for i in 0 ..< self.graph[v].count {
            if self.graph[v][i] == true {
                iteration(i)
            }
        }
    }
    
    public override func hasEdge(_ v : Int, _ w : Int) -> Bool{
        assert(self.isAvaliable(v))
        assert(self.isAvaliable(w))
        return self.graph[v][w]
    }
    
    public override func show() {
        
        print("稠密图 邻接矩阵 ： \(self)")
        for i in 0 ..< self.num_Vertex {
            let str = String(format: "%03d", i)
            print("Vertex \(str) : ", separator: "", terminator: "")
            for j in 0 ..< self.num_Vertex {
                let content = self.graph[i][j] == true ? "1" : "0"
                print(content, separator: "", terminator: " ")
            }
            print()
        }
        print()
    }
    
    public class Path : GraphPath {
        
        fileprivate var G : DenseGraph_Matrix!
        
        public init(graph : DenseGraph_Matrix, v : Int) {
            super.init(capacity: graph.V(), v: v)
            self.G = graph
            self.dfsFromVertex(self.V)
        }
        
        internal override func dfsFromVertex(_ v: Int) {
            self.visited[v] = true
            for i in 0 ..< self.num_Vertex {
                if self.G.graph[v][i] == true && self.visited[i] == false {
                    self.from[i] = v
                    self.dfsFromVertex(i)
                }
            }
        }
    }
}
