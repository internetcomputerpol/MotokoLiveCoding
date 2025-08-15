

persistent actor CallTheCops
{

let canisterCall_val : actor { showThumbSecretQuery:() -> async Nat;} = actor "2wpkx-ciaaa-aaaal-qsr5q-cai";

public  func callCanister() : async Nat 
{
  let result = await canisterCall_val.showThumbSecretQuery();
  result;
};


};
