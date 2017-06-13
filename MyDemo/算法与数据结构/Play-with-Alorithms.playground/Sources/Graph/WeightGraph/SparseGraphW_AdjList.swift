import Foundation

internal class Vertex<T : EdgeWeight> {
    
    public var vertex : Int = -1
    public var firstArc : Edge<T>?
    
    init(vertex : Int) {
        self.firstArc = nil
        self.vertex = vertex
    }
}

public class SparseGraphW_AdjList {
    
    
    
}
