import 'package:flutter/foundation.dart';

FooditemList fooditemList = FooditemList(foodItems: [
  FoodItem(
      id: 1,
      title: "Pepperoni pizza",
      desc: "Pizza with pepperoni topping",
      price: 75000,
      imgUrl:"https://www.cooksifu.com/wp-content/uploads/2019/03/Pepperoni-pizza.jpg",
      cate: "food"),
  FoodItem(
      id: 2,
      title: "Sausages pizza",
      desc: "Pizza with slices of sausages on top",
      price: 85000,
      imgUrl: "https://media-cdn.tripadvisor.com/media/photo-s/0f/c5/2a/f3/traditional-pizza-bbq.jpg",
      cate: "food"),
  FoodItem(
      id: 3,
      title: "Cheeeeeeeeeeeeese",
      desc: "Pizza but all cheese",
      price: 99000,
      imgUrl: "https://kitchenatics.com/wp-content/uploads/2020/09/Cheese-pizza-1.jpg",
      cate: "food"),
  FoodItem(
      id: 4,
      title: "Veggie Pizza",
      desc: "Pizza with vegetables topping",
      price: 79000,
      imgUrl:"https://i.pinimg.com/originals/48/b5/d2/48b5d236bac9c2d3415a7ba3159280e5.jpg",
      cate: "food"),
  FoodItem(
      id: 5,
      title: "Pineapple Pizza",
      desc: "Pizza with slices of pineapple on top",
      price: 69900,
      imgUrl: "https://img.i-scmp.com/cdn-cgi/image/fit=contain,width=1098,format=auto/sites/default/files/styles/1200x800/public/d8/images/methode/2019/03/14/5cacc3ac-4547-11e9-b5dc-9921d5eb8a6d_image_hires_110410.jpg?itok=lFU5tRpQ&v=1552532658",
      cate: "food"),
  FoodItem(
      id: 6,
      title: "Mushroom pizza",
      desc: "Pizza with garlic and fresh mushroom",
      price: 79500,
      imgUrl:"http://www.alisonsallspice.com/wp-content/uploads/2018/02/Roasted-Garlic-and-Mushroom-Pizza.jpg",
      cate: "food"),
  FoodItem(
      id: 7,
      title: "Soft Drink",
      desc: "Coca cola",
      price: 8500,
      imgUrl: "https://e7.pngegg.com/pngimages/65/459/png-clipart-fizzy-drinks-juice-carbonated-water-cola-diet-drink-coca-cola-s-glass-food.png",
      cate: "drink"),
  FoodItem(
      id: 8,
      title: "Lemon Tea",
      desc: "Tea with lemon",
      price: 5000,
      imgUrl: "https://cf.shopee.co.id/file/f19611d604090c62fc56e734393d9ad1",
      cate: "drink"),
  FoodItem(
      id: 9,
      title: "Mineral Water",
      desc: "Just a normal mineral water",
      price: 7500,
      imgUrl:"http://clipart-library.com/images_k/glass-of-water-transparent-background/glass-of-water-transparent-background-15.png",
      cate: "drink"),
    FoodItem(
      id: 10,
      title: "Vanilla Milkshake",
      desc: "Milkshake with vanilla flavor",
      price: 35000,
      imgUrl:"https://food.fnr.sndimg.com/content/dam/images/food/fullset/2021/02/03/BobbyFlay_BasicVanillaMilkshake_H.jpg.rend.hgtvcom.826.620.suffix/1612401890664.jpeg",
      cate: "drink"),
      FoodItem(
      id: 11,
      title: "Chocolate Milkshake",
      desc: "Milkshake with chocolate flavor",
      price: 35000,
      imgUrl:"https://media.istockphoto.com/photos/homemade-chocolate-cake-milkshake-picture-id1183223263?k=6&m=1183223263&s=612x612&w=0&h=cZNQMtJIKaObYAiziYzauL4bPm4bbUqxa6DIRhfhN0A=",
      cate: "drink"),
      FoodItem(
      id: 12,
      title: "Strawberry Milkshake",
      desc: "Milkshake with Strawberry flavor",
      price: 35000,
      imgUrl:"https://food.fnr.sndimg.com/content/dam/images/food/fullset/2021/02/03/BobbyFlay_BasicVanillaMilkshake_H.jpg.rend.hgtvcom.826.620.suffix/1612401890664.jpeg",
      cate: "drink"
      ),
      FoodItem(
      id: 13,
      title: "Dawet Gengs",
      desc: "Mix of cendol (the green vermicelli) coconut milk and Javanese sugar.",
      price: 25000,
      imgUrl:"https://asset.kompas.com/crops/717Y5C_HPZU2nweoLZT7cQcKapY=/0x352:751x853/750x500/data/photo/2020/07/17/5f11041e59757.jpg",
      cate: "drink"),
      FoodItem(
      id: 14,
      title: "Bandrek",
      desc: "sweet and spicy hot drink native to the Sundanese people of West Java, Indonesia",
      price: 38000,
      imgUrl:"https://i0.wp.com/resepkoki.id/wp-content/uploads/2017/07/Resep-Bandrek.jpg?fit=1300%2C1300&ssl=1",
      cate: "drink"),
]);


class FooditemList {
  List<FoodItem> foodItems;

  FooditemList({@required this.foodItems});
}

class FoodItem {
  int id;
  String title, desc;
  int price;
  String imgUrl, cate;
  int quantity;

  FoodItem({
    @required this.id,
    @required this.title,
    @required this.desc,
    @required this.price,
    @required this.imgUrl,
    this.quantity = 1,
    @required this.cate,
  });

  bool get isNotEmpty => null;

  void incrementQuantity() {
    this.quantity = this.quantity + 1;
  }

  void decrementQuantity() {
    this.quantity = this.quantity - 1;
  }

  bool contains(FoodItem query) {}
}
