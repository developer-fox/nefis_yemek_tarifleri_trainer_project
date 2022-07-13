


class User {

  String name;
  String location;
  String imageUrl;

  User({
    required this.name,
    required this.location,
    required this.imageUrl,
  });


  factory User.fromJson(Map<String,dynamic> jsonData) {

    Map<String, dynamic> data = jsonData["results"][0];

    return User(
      name: data["name"]["first"] + " " + data["name"]["last"], 
      location: data["location"]["city"] +", " + data["location"]["country"], 
      imageUrl: data["picture"]["medium"]);
  }



}


