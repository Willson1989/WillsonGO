import Foundation


public class SparseGraphW : Graph_Weighted {
    
    public var graph : [[Edge?]] = []
    
    public init(capacity : Int , directed : Bool) {
        super.init()
        self.num_Vertex = capacity
        self.num_Edge = 0
        self.isDirected = directed
        
        for _ in 0 ..< capacity {
            self.graph.append( [Edge?]() )
        }
    }
    
    public override func addEdge(_ v: Int, _ w: Int, weight: Float) {
        if !self.isAvaliable(v) || !self.isAvaliable(w) {
            return
        }
        //if self.hasEdge(v, w) == true {
        //    return
        //}
        let ew = Edge(a: v, b: w, weight: weight)
        self.graph[v].append(ew)
        if v != w && !self.isDirected {
            let ev = Edge(a: w, b: v, weight: weight)
            self.graph[w].append(ev)
        }
        self.num_Edge += 1
    }
    
    override func dfs(v: Int, iteration: iteratorBlock?) {
        self.visited[v] = true
        iteration?(v)
        self.connectIds[v] = self.num_Components
        for i in 0 ..< self.graph[v].count {
            let e = self.graph[v][i]
            if self.visited[e!.to] == false {
                self.dfs(v: e!.to, iteration: iteration)
            }
        }
    }
    
    // O(n)级别
    public override func hasEdge(_ v: Int, _ w: Int) -> Bool {
        assert(self.isAvaliable(v) && self.isAvaliable(w))
        for i in 0 ..< self.graph[v].count {
            if self.graph[v][i]!.to != w {
                return true
            }
        }
        return false
    }
    
    public override func deleteEdge(_ v : Int, _ w : Int) {
        if !self.isAvaliable(v) || !self.isAvaliable(w) {
            return
        }
        
        for i in 0 ..< self.graph[v].count {
            if self.graph[v][i]!.to == w {
                self.graph[v].remove(at: i)
                self.num_Edge -= 1
                break
            }
        }
        if !self.isDirected {
            for i in 0 ..< self.graph[w].count {
                if self.graph[w][i]!.to == v {
                    self.graph[w].remove(at: i)
                    break
                }
            }
        }
        self.depthFirstSearch(iteration: nil)
    }
    
    //打印邻接表
    public override func show() {
        print("稀疏图 邻接表 ： \(self)")
        for i in 0 ..< self.num_Vertex {
            let v = String(format: "%03d", i)
            print("Vertex \(v) : ", separator: "", terminator: "")
            for j in 0 ..< self.graph[i].count {
                print(self.graph[i][j]!.to, separator: "", terminator: " ")
            }
            print()
        }
        print()
    }
    
    public class Path : GraphPath {
        
        fileprivate var G : SparseGraphW!
        
        public init(graph : SparseGraphW, v : Int) {
            super.init(capacity: graph.V(), v: v)
            self.G = graph
            
            //寻路算法
            self.dfsFromVertex(self.V)
            print("from array : \(self.from)")
            print("visited array : \(self.visited)")
        }
        
        internal override func dfsFromVertex(_ v: Int) {
            self.visited[v] = true
            for i in 0 ..< self.G.graph[v].count {
                let j = self.G.graph[v][i]!.to
                if self.visited[j] == false {
                    self.from[j] = v
                    self.dfsFromVertex(j)
                }
            }
        }
    }
    
    public class ShortestPath : GraphPath {
        
        fileprivate var G : SparseGraphW!
        
        public init(graph : SparseGraphW, v : Int) {
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
                for i in 0 ..< self.G.graph[tmpV].count {
                    let j = self.G.graph[tmpV][i]!.to
                    if self.visited[j] == false {
                        queue.enqueue(j)
                        self.visited[j] = true
                        self.from[j] = tmpV
                        self.distance[j] = self.distance[tmpV] + 1
                    }
                }
            }
        }
        
    }
}


