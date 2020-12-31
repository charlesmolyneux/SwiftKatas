public enum MoveInputCommand {
  case move, invalid
  case turn(TurnDirection)
  
  public init(_ input: String) {
    switch input.uppercased() {
    case "R": self = .turn(.right)
    case "L": self = .turn(.left)
    case "M": self = .move
    default: self = .invalid
    }
  }
  
  public enum TurnDirection {
    case left, right
  }
}
