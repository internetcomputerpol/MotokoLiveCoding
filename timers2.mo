import List "mo:core/List";
import Timer "mo:core/Timer";
import Nat "mo:core/Nat";

persistent actor BuffTest {

  var list = List.empty<Nat>();
  var datavalue = 0;
  var numbervalue = 0;
  type Datanumber = { #Data; #Number };

  private func runRepeat(increment : Nat, dataval : Datanumber) : async () {
    switch (dataval) {
      case (#Data) {
        datavalue := datavalue + increment;
        let a = Timer.setTimer<system>(#seconds 5, func() : async () { await runRepeat(2, #Data) });
        let b = ignore Timer.setTimer<system>(#seconds 10, func() : async () { await runRepeat(3, #Number) });
      };
      case (#Number) {
        numbervalue := numbervalue + increment;
        let c = Timer.setTimer<system>(#seconds 5, func() : async () { await runRepeat(2, #Data) });
        let d = ignore Timer.setTimer<system>(#seconds 10, func() : async () { await runRepeat(3, #Number) });
      };
    };
  };

  ignore Timer.setTimer<system>(#seconds 5, func() : async () { await runRepeat(2, #Data) });
  ignore Timer.setTimer<system>(#seconds 10, func() : async () { await runRepeat(3, #Number) });

  public func runOnceFillData() : async () {
    List.add(list, 23);
    List.add(list, 48);
    List.add(list, 78);
    List.add(list, 24);
  };

  public query func checkVariables() : async Text {

    return " Value Number = " #Nat.toText(numbervalue) # " Value Data = " #Nat.toText(datavalue);
  }

};
