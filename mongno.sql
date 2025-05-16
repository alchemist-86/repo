

-- insert collection
[
  {"_id": 1, "name": "Babar Azam", "runs": 1500, "matches": 30, "average": 45.5},
  {"_id": 2, "name": "Shaheen Shah Afridi", "runs": 600, "matches": 20, "average": 30.4},
  {"_id": 3, "name": "Fakhar Zaman", "runs": 1200, "matches": 45, "average": 40.2},
  {"_id": 4, "name": "Shadab Khan", "runs": 800, "matches": 35, "average": 35.0}
]


-- 1
db.players.find({runs: {$gt: 1000}});


-- 2
db.players.find({average: {$gt: 40}});


-- 3
db.players.updateMany(
  {runs: {$gt: 1000}},
  {$set: {average: 50}}
);


-- 4
db.players.insertMany([
  {_id: 5, name: "Haris Rauf", runs: 500, matches: 15, average: 25.0},
  {_id: 6, name: "Mohammad Rizwan", runs: 1050, matches: 40, average: 40.0}
]);


-- 5

db.players.aggregate([
  {
    $group: {
      _id: null,
      totalRuns: {$sum: "$runs"}
   }
 }
]);
