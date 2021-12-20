import XCTest

class LinkedListTests: XCTestCase {
    var sut: LinkedList<Int>!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = LinkedList<Int>()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        sut = nil
    }

    func test_linkedList에_head가_없을때_append가_정상적으로되는지() {
        sut.append(1)
        
        let result = sut.head?.data
        
        XCTAssertEqual(result, 1)
    }
    
    func test_linkedList에_head가_있을때_append가_정상적으로되는지() {
        sut.append(1)
        sut.append(2)
        
        let headResult = sut.head?.data
        let headNextResult = sut.head?.next?.data
        
        XCTAssertEqual(headResult, 1)
        XCTAssertEqual(headNextResult, 2)
    }
    
    func test_linkedList에_head가_없을때_removeFirst가_nil을반환하는지() {
        let result = sut.removeFirst()
        
        XCTAssertNil(result)
    }
    
    func test_linkedList에_head가_있을때_removeFirst가_정상적으로되는지() {
        sut.append(1)
        sut.append(2)
        
        let firstResult = sut.removeFirst()
        let secondResult = sut.removeFirst()
        let thirdResult = sut.removeFirst()
        
        XCTAssertEqual(firstResult, 1)
        XCTAssertEqual(secondResult, 2)
        XCTAssertNil(thirdResult)
    }
    
    func test_removeAll했을때_정상적으로되는지() {
        sut.append(1)
        sut.append(2)
        sut.append(3)
        
        sut.removeAll()
        
        XCTAssertNil(sut.head)
        XCTAssertNil(sut.head?.next)
    }
    
    func test_first프로퍼티가_첫번째노드의_data를반환하는지() {
        sut.append(3)
        
        let result = sut.first
        
        XCTAssertEqual(result, 3)
    }
    
    func test_head가_없을때_isEmpty가_true를_반환하는지() {
        let result = sut.isEmpty
        
        XCTAssertTrue(result)
    }
    
    func test_head가_있을때_isEmpty가_false를_반환하는지() {
        sut.append(1)
        
        let result = sut.isEmpty
        
        XCTAssertFalse(result)
    }
}