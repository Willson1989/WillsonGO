import Foundation

//使用链表实现邻接表的 带权图

public class SparseGraphW_AdjList<T : GraphWeight> : Graph_Weighted<T> {
    
    fileprivate var graph : [Vertex<T>] = []
    
    public init(capacity : Int , directed : Bool) {
        super.init()
        self.num_Edge = 0
        self.num_Vertex = capacity
        self.isDirected = directed
        for i in 0 ..< capacity {
            let v = Vertex<T>(vertex: i)
            self.graph.append(v)
        }
    }
    
    public override func addEdge(_ v: Int, _ w: Int, weight : T) {
        if !isAvaliable(v) || !isAvaliable(w) {
            return
        }
        if hasEdge(v, w) {
            return
        }
        if v == w { //不添加自环边
            return
        }
        let ew = Edge(a: v, b: w, weight: weight)
        let vexV = graph[v]
        ew.next = vexV.firstArc
        vexV.firstArc = ew
        
        if !isDirected {
            let ev = Edge(a: w, b: v, weight: weight)
            let vexW = graph[w]
            ev.next = vexW.firstArc
            vexW.firstArc = ev
        }
        self.num_Edge += 1
    }
    
    override func dfs(v: Int, iteration: iteratorBlock?) {
        self.visited[v] = true
        iteration?(v)
        self.connectIds[v] = self.num_Components
        var p = graph[v].firstArc
        while p != nil {
            if visited[p!.to] == false {
                self.dfs(v: p!.to, iteration: iteration)
            }
            p = p!.next
        }
    }
    
    public override func hasEdge(_ v: Int, _ w: Int) -> Bool {
        assert(self.isAvaliable(v))
        assert(self.isAvaliable(w))
        var p : Edge? = self.graph[v].firstArc
        while p != nil {
            if p!.to == w {
                return true
            }
            p = p!.next
        }
        return false
    }
    
    public override func deleteEdge(_ v : Int, _ w : Int) {
        if !self.isAvaliable(v) || !self.isAvaliable(w) {
            return
        }
        var pre : Edge<T>? = nil
        var p = self.graph[v].firstArc
        while p != nil {
            if p?.to == w {
                if pre == nil {
                    self.graph[v].firstArc = p?.next
                } else {
                    pre?.next = p?.next
                    p = nil
                }
                self.num_Edge -= 1
                //不处理平行变的问题,所以匹配的时候，直接break
                break
            }
            pre = p
            p = p?.next
        }
        if !self.isDirected {
            pre = nil
            p = self.graph[w].firstArc
            while p != nil {
                if p?.to == v {
                    if pre == nil {
                        self.graph[w].firstArc = p?.next
                    } else {
                        pre?.next = p?.next
                        p = nil
                    }
                    break
                }
                pre = p
                p = p?.next
            }
        }
        self.depthFirstSearch(iteration: nil)
    }
    
    public override func show() {
        print("稀疏图(有权) 邻接表 ： \(self)")
        for i in 0 ..< self.num_Vertex {
            let v = String(format: "%03d", i)
            print("Vertex \(v) : ", separator: "", terminator: "")
            var p = graph[i].firstArc
            while p != nil {
                print(p!.to, separator: "", terminator: " ")
                p = p!.next
            }
            print()
        }
        print()
    }
    
    public class Path : GraphPath {
        
        fileprivate var G : SparseGraphW_AdjList!
        
        public init(graph : SparseGraphW_AdjList, v : Int) {
            super.init(capacity: graph.V(), v: v)
            self.G = graph
            //寻路算法
            self.dfsFromVertex(self.V)
            print("from array : \(self.from)")
            print("visited array : \(self.visited)")
        }
        
        override func dfsFromVertex(_ v: Int) {
            self.visited[v] = true
            var p = self.G.graph[v].firstArc
            while p != nil {
                if visited[p!.to] == false {
                    self.from[p!.to] = v
                    self.dfsFromVertex(p!.to)
                }
                p = p!.next
            }
        }
    }
    
    public class ShortestPath : GraphPath {
        
        fileprivate var G : SparseGraphW_AdjList!
        
        public init(graph : SparseGraphW_AdjList, v : Int) {
            super.init(capacity: graph.V(), v: v)
            self.G = graph
            self.initDistanceArray()
            self.bfsFromVertex(self.V)
        }
        
        internal override func bfsFromVertex(_ v: Int) {
            
            var queue = BasicQueue()
            queue.enqueue(v)
            self.visited[v] = true
            self.distance[v] = 0
            
            while !queue.isEmpty() {
                
                let tmpV = queue.front() as! Int
                queue.dequeue()
                var p = self.G.graph[tmpV].firstArc
                while p != nil {
                    if self.visited[p!.to] == false {
                        queue.enqueue(p!.to)
                        self.visited[p!.to] = true
                        self.from[p!.to] = tmpV
                        self.distance[p!.to] = self.distance[tmpV] + 1
                    }
                    p = p!.next
                }
            }
        }
    }
}









