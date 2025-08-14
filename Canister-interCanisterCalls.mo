import Nat64 "mo:core/Nat64";
import Nat "mo:core/Nat";
import Time "mo:core/Time";
import Random "mo:core/Random";
import Nat8 "mo:core/Nat8";



(with migration = 
  func (_ : { var nextLockGate : Nat64; var nextThumbSecret : Nat64 }) : {} {
    {}
  }
)


persistent actor BurningDangeon {

  private var thumbSecret : Nat = 0;
  private var lockGateValue : Nat = 0;
  
 
  

  system func timer(setGlobalTimer : Nat64 -> ()) : async () {
  let next = Nat64.fromIntWrap(Time.now()) + 10_000_000_000;
  thumbSecret := await generateRandom(999);
  lockGateValue := await generateRandom(300);
  setGlobalTimer(next); 
 
};
 


private func generateRandom(range:Nat) :  async Nat {
        let blob = await Random.blob();
        let value = Nat8.toNat(blob[0]) * 256 + Nat8.toNat(blob[1]);
        let res = (value % range) + 1;
        return res;
    };

  public func showThumbSecret() : async Nat {
    thumbSecret
  };

  public func showLockGateValue() : async Nat {
    lockGateValue
  };

}
