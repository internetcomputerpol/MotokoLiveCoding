///////// Emoji Collection
import Random "mo:base/Random"; 
import Nat8 "mo:base/Nat8";

module Emoji { 

    public let Smiley = "😊"; 
    public let ThumbsUp = "👍"; 
    public let Rocket = "🚀";
    public let Fire = "🔥";
    public let Heart = "❤️";
    public let Star = "⭐";
    public let Sun = "☀️";
    public let Moon = "🌙";
    public let Cloud = "☁️";
    public let Snowflake = "❄️";
    public let Umbrella = "☂️";
    public let Lightning = "⚡";
    public let Music = "🎵";
    public let Camera = "📷";
    public let Phone = "📱";
    public let Laptop = "💻";
    public let Book = "📖";
    public let Pencil = "✏️";
    public let Paint = "🎨";
    public let Ball = "⚽";
    public let Trophy = "🏆";
    public let Medal = "🏅";
    public let Car = "🚗";
    public let Airplane = "✈️";
    public let Train = "🚆";
    public let Ship = "🚢";
    public let Tree = "🌳";
    public let Flower = "🌸";
    public let Leaf = "🍃";
    public let Apple = "🍎";
    public let Banana = "🍌";
    public let Cake = "🎂";
    public let Coffee = "☕";
    public let Beer = "🍺";
    public let Wine = "🍷";
    public let Guitar = "🎸";
    public let Microphone = "🎤";
    public let Balloon = "🎈";


    public let all : [Text] = [
        Smiley, ThumbsUp, Rocket, Fire, Heart, Star, Sun, Moon, Cloud, Snowflake,
        Umbrella, Lightning, Music, Camera, Phone, Laptop, Book, Pencil, Paint, Ball,
        Trophy, Medal, Car, Airplane, Train, Ship, Tree, Flower, Leaf, Apple,
        Banana, Cake, Coffee, Beer, Wine, Guitar, Microphone, Balloon
    ];


    public func randomEmoji() : async Text { 
        let blob = await Random.blob(); 
        let idx = Nat8.toNat(blob[0]) % all.size(); 
        all[idx]; 
    };


};


