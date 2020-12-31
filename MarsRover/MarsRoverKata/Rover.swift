public class Rover {
  var position: RoverPosition
  private(set) var moveInstructions: [String] = []
  
  public init(position: RoverPosition) {
    self.position = position
  }
  
  public func update(moveInstructions: [String]) {
    self.moveInstructions = moveInstructions
  }
}
