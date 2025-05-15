db.CUSTOMERS_DV.find()

db.CUSTOMERS_DV.findOne({"FirstName":"Dom"})


db.CUSTOMERS_DV.updateOne( { "FirstName": "Dom" }, { $set: { "Email": "dom@giles.com" } } );











**
Update one field**

 db.CUSTOMERS_DV.updateOne(
      { "FirstName" : "Dom" },
      { $set: { "Email" : "dom@giles.com" } }
   );



 db.neworders_c.updateOne(
      { "PRODUCT_ID" : 3232 },
      { $set: { "TOTAL_VALUE" : 23.5 } }
   );


**Updating nested elements**

 db.CUSTOMERS_DV.updateOne(
      { "FirstName" : "Dom" }
      , {
        $set: {
            "orders.$[j].TotalValue": 12
        },
      },{
        arrayFilters: [
            {
            "j.OrderID": 1
        }
        ]
      }
   );

MongoServerError: arrayFilters option is not supported on duality view collections.


**Aggregation example**

db.CUSTOMERS_DV.aggregate([
    {$match: {"FirstName": "Dom"} }, 
    {$unwind: '$orders'}, 
    {$group: {
        _id: null, 
        "sum": {$sum: "$orders.TotalValue" }
    }}
])




2
3
4

	

db.classes.findAndModify({
    query: { FirstName: "Dom", orders: { $elemMatch: { OrderID: "1" } } },
    update: { $set: { "orders.$.TotalValue": NumberInt(89) } }
})


db.classes.findOneAndUpdate(
  {
    "FirstName": "Dom", "orders.OrderID":1
  },
  {$set: 
    {"orders.$.TotalValue": NumberInt(89) }
  }
)