import XCTest
@testable import MarsRoverKata

class MarsRoverKataTests: XCTestCase {
  let testInput = """
  5 5
  1 2 N
  LMLMLMLMM
  3 3 E
  MMRMMRMRRM
  """
  
  func test_parsingEmptyString_throwsInvalidInput() {
    let command = RoverCommand()
    
    XCTAssertThrowsError(try command.parse("")) { error in
      XCTAssertEqual(error as! RoverCommandError, RoverCommandError.invalidInput)
    }
  }
    
  func test_givenTestInput_positionsRoversAsExpected() {
    let command = RoverCommand()
    
    try! command.parse(testInput)
        
    XCTAssertEqual(command.rovers.count, 2)
    XCTAssertEqual(command.rovers[0].position, RoverPosition(coordinates: Coordinates(x: 1, y: 3), orientation: .north))
    XCTAssertEqual(command.rovers[1].position, RoverPosition(coordinates: Coordinates(x: 5, y: 1), orientation: .east))
  }
}

extension RoverPosition: Equatable {
  static public func == (lhs: RoverPosition, rhs: RoverPosition) -> Bool {
    return rhs.coordinates == lhs.coordinates && rhs.orientation == lhs.orientation
  }
}

extension Coordinates: Equatable {
  static public func == (lhs: Coordinates, rhs: Coordinates) -> Bool {
    return rhs.x == lhs.x && rhs.y == lhs.y
  }
}

