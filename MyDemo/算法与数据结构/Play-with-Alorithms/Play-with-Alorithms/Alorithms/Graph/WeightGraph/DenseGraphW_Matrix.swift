import Foundation

public class DenseGraphW_Matrix : Graph_Weighted {
    
    internal var graph : [[Edge?]] = []
    
    public override init(capacity : Int , directed : Bool) {
        super.init(capacity: capacity, directed: directed)
        for _ in 0 ..< capacity {
            let tmpArr = Array<Edge?>(repeating: nil, count: capacity)
            self.graph.append(tmpArr)
        }
    }

    public override func addEdge(_ v: Int, _ w: Int, weight : Float) {
        if !isAvaliable(v) || !isAvaliable(w) {
            return
        }
        if hasEdge(v, w) == true {
            //如果v和w之间已经有边了，则不做任何操作
            return
        }
        graph[v][w] = Edge(a: v, b: w, weight: weight)
        if !isDirected {
            //如果是无向图
            graph[w][v] = Edge(a: w, b: v, weight: weight)
        }
        num_Edge += 1
    }
    
    public override func deleteEdge(_ v: Int, _ w: Int) {
        if !self.isAvaliable(v) || !self.isAvaliable(w) {
            return
        }
        if !self.hasEdge(v, w) {
            return
        }
        
        if self.graph[v][w] != nil {
            self.graph[v][w] = nil
            if self.isDirected == false {
                self.graph[w][v] = nil
            }
        }
        self.num_Edge -= 1
        self.depthFirstSearch(iteration: nil)
    }
    
    internal override func dfs(v: Int, iteration: iteratorBlock?) {
        self.visited[v] = true
        iteration?(v)
        self.connectIds[v] = self.num_Components
        for i in 0 ..< self.graph[v].count {
            if self.graph[v][i] != nil && self.visited[i] == false {
                self.dfs(v: i, iteration: iteration)
            }
        }
    }
    
    public override func hasEdge(_ v : Int, _ w : Int) -> Bool{
        assert(self.isAvaliable(v))
        assert(self.isAvaliable(w))
        return self.graph[v][w] != nil
    }
    
    public override func show() {
        
        print("稠密图(有权图) 邻接矩阵 ： \(self)")
        for i in 0 ..< self.num_Vertex {
            let str = String(format: "%03d", i)
            print("Vertex \(str) : ", separator: "", terminator: "")
            for j in 0 ..< self.num_Vertex {
                let content = self.graph[i][j] != nil ? "1" : "0"
                print(content, separator: "", terminator: " ")
            }
            print()
        }
        print()
    }
    
    public class Path : GraphPath {
        
        fileprivate var G : DenseGraphW_Matrix!
        
        public init(graph : DenseGraphW_Matrix, v : Int) {
            super.init(capacity: graph.V(), v: v)
            self.G = graph
            self.dfsFromVertex(self.V)
        }
        
        internal override func dfsFromVertex(_ v: Int) {
            self.visited[v] = true
            for i in 0 ..< self.num_Vertex {
                if self.G.graph[v][i] != nil && self.visited[i] == false {
                    self.from[i] = v
                    self.dfsFromVertex(i)
                }
            }
        }
    }
    
    public class ShortestPath : GraphPath {
        
        fileprivate var G : DenseGraphW_Matrix!
        
        public init(graph : DenseGraphW_Matrix, v : Int) {
            super.init(capacity: graph.V(), v: v)
            self.G = graph
            self.initDistanceArray()
            self.bfsFromVertex(self.V)
        }
        
        internal override func bfsFromVertex(_ v: Int) {
            var queue = BasicQueue()
            queue.enqueue(v)
            self.distance[v] = 0
            self.visited[v] = true
            
            while !queue.isEmpty() {
                let tmpV = queue.front() as! Int
                queue.dequeue()
                for i in 0 ..< self.num_Vertex {
                    if self.G.graph[tmpV][i] != nil && self.visited[i] == false {
                        queue.enqueue(i)
                        self.visited[i] = true
                        self.from[i] = tmpV
                        self.distance[i] = self.distance[tmpV] + 1
                    }
                }
            }
        }
    }
    
    public class LazyPrimMST : MST {
        
        fileprivate var G : DenseGraphW_Matrix!
        
        public init(graph : DenseGraphW_Matrix) {
            super.init(capacity: graph.V())
            self.G = graph
            
            //Lazy Prim
            self.GenericMST_lazyPrim()
        }
        
        internal override func visit(_ v: Int) {
            assert(v < self.G.V())
            //当前访问的节点变成红色了
            self.marked[v] = true
            for i in 0 ..< G.V() {
                if let e = G.graph[v][i] {
                    if marked[e.other(v)] == false {
                        //另一个节点是蓝色，说明e是横切边，将e添加到最小堆中
                        print("about to insert, [ \(e.V()), \(e.W()) ] w : \(e.wt())")
                        
                        pq.insertItem(e)
                    }
                }
            }
        }
    }
    
}




