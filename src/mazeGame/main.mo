import Array "mo:stdlib/array";
import Result "mo:stdlib/result";
import Render "../render/render";
import Types "types";
import State "state";

actor {

  var state = State.initState();

  public func draw() : async Types.ResOut {
    resOut(#ok)
  };
  
  public func move(dir:Types.Dir2D) : async {#ok; #err} {
    switch (State.move(state, dir)) {
      case (#ok(_)) { #ok };
      case (#err(_)) { #err };
    }
  };

  public func moveDraw(dir:Types.Dir2D) : async Types.ResOut  {
    switch (State.move(state, dir)) {
      case (#ok(_)) { resOut(#ok) };
      case (#err(_)) { resOut(#err) };
    }
  };

  public func move2(dir1:Types.Dir2D, dir2:Types.Dir2D) : async Types.ResOut  {
    _moveN([dir1, dir2])
  };

  public func reset() : async Types.ResOut {
    state := State.initState();
    resOut(#ok)
  };



  // temp
  func move3(dir1:Types.Dir2D, dir2:Types.Dir2D, dir3:Types.Dir2D) : async Types.ResOut  {
    _moveN([dir1, dir2, dir3])
  };

  // temp
  func moveN(dirs:[Types.Dir2D]) : async Types.ResOut  {
    _moveN(dirs)
  };

  func _moveN(dir:[Types.Dir2D]) : Types.ResOut {
    switch (State.multiMove(state, dir)) {
      case (#ok(_)) { resOut(#ok) };
      case (#err(_)) { resOut(#err) };
    }
  };

  func resOut(status:{#ok; #err}) : Types.ResOut {
    let elm = State.render(state);
    let rs : Render.Out = #redraw([("state", elm)]);
    switch status {
      case (#ok) { #ok(rs) };
      case (#err) { #err(rs) };
    }
  }
  
};
