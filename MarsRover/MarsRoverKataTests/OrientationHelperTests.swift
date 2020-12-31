import XCTest
@testable import MarsRoverKata
  
class OrientationHelperTests: XCTestCase {
  private let orientationHelper = OrientationHelper()
  
  func test_givenNorthenOrientiation_turnCommands_faceExpectedOrientation() {
    assert(given: .left, currentOrientation: .north, expectedNewOrientation: .west)
    assert(given: .right, currentOrientation: .north, expectedNewOrientation: .east)
  }
  
  func test_givenSouthernOrientiation_turnCommands_faceExpectedOrientation() {
    assert(given: .left, currentOrientation: .south, expectedNewOrientation: .east)
    assert(given: .right, currentOrientation: .south, expectedNewOrientation: .west)
  }
  
  func test_givenEasternOrientiation_turnCommands_faceExpectedOrientation() {
    assert(given: .left, currentOrientation: .east, expectedNewOrientation: .north)
    assert(given: .right, currentOrientation: .east, expectedNewOrientation: .south)
  }
  
  func test_givenWesternOrientiation_turnCommands_faceExpectedOrientation() {
    assert(given: .left, currentOrientation: .west, expectedNewOrientation: .south)
    assert(given: .right, currentOrientation: .west, expectedNewOrientation: .north)
  }
  
  func assert(given command: MoveInputCommand.TurnDirection,
              currentOrientation: Orientation,
              expectedNewOrientation: Orientation) {
    
    let newOrientation = orientationHelper.reorient(with: command, currentOrientation: currentOrientation)
    XCTAssertEqual(newOrientation, expectedNewOrientation)
  }
}

