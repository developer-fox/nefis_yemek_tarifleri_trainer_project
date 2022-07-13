

class Ingredient {

  String name;
  int id;
  String imageUrl;
  double amount;
  String unitLong;

  Ingredient({
    required this.name,
    required this.id,
    required this.imageUrl,
    required this.amount,
    required this.unitLong,
  });
  

  factory Ingredient.fromJson(Map<String, dynamic> jsonData){

    return Ingredient(
      name: jsonData["name"], 
      imageUrl: jsonData["image"] ?? "", 
      amount: jsonData["amount"], 
      unitLong: jsonData["measures"]["metric"]["unitLong"],
       id: jsonData["id"],
      );

  }


}

