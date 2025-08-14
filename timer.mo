import Time "mo:core/Time";
import Nat64 "mo:core/Nat64";

persistent actor Timers 
{

var loopCount :Nat = 0;


public func checkLoopCount() : async Nat 
{
  return loopCount;
};

system func timer(setGlobalTimer : Nat64 -> ()) : async () {
  let next = Nat64.fromIntWrap(Time.now()) + 20_000_000_000;      // 20 sec delay
  setGlobalTimer(next); //<---------------- Set timer for another round
  loopCount += 1;
};

}
