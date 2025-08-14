import Emoji "Emoji";

 persistent actor {


 public func getData(): async Text 
 {
  return ""#Emoji.Cake;
 };

 public func getRandomEmoji(): async Text 
 {
  let emoji = await Emoji.randomEmoji();
  return ""#emoji;
 };




};
