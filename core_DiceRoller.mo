import Random "mo:core/Random";
import Nat8 "mo:core/Nat8";
import Nat "mo:core/Nat";

import List "mo:core/List";

persistent actor DiceRoller 
{ 

  transient let random = Random.crypto();
  
  var list = List.empty<Text>();
 

public query func getAllThrow() : async Text {

  var ledger = "";
  for (element in List.values(list)) {
  ledger := ledger#" "#element;
};
return ledger;
};

// Koment 

public func rollDice() : async Text {
  let value = Nat8.toNat(await* random.nat8()) % 6;
  var result = Nat.toText(value+1);
  switch(result)
  {
    case "1" { result#="⚀" };
    case "2" { result#="⚁" };
    case "3" { result#="⚂" };
    case "4" { result#="⚃" };
    case "5" { result#="⚄" };
    case "6" { result#="⚅" };
    case _ { result#="🎲" }
  };
    List.add(list,result);
  return result;
};
}
