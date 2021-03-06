import 'package:flutter/material.dart';
import 'auth.dart';
import 'auth_provider.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'bloc/cartlistBloc.dart';
import 'cart.dart';
import 'const/themeColor.dart';
import 'model/food_item.dart';
import 'details.dart';

class HomePage extends StatefulWidget {
  const HomePage({this.onSignedOut});
  final VoidCallback onSignedOut;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<void> _signOut() async {
    try {
      final BaseAuth auth = AuthProvider.of(context).auth;
      await auth.signOut();
      widget.onSignedOut();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(150, 15, 15, 1),
        title: Container(
          alignment: Alignment.centerRight,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('Welcome ,dear Customer' ,style: TextStyle(
                fontSize: 25 ,
                fontWeight: FontWeight.w800,
              )),
              Padding(
                padding: const EdgeInsets.only(left:60),
                child: GestureDetector(
                  child: Container(
                    alignment: Alignment.center,
                    width: 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10), color: Colors.redAccent[200]),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text('Logout',
                          style: TextStyle(fontSize: 18.0, color: Colors.white)),
                    ),
                  ),
                  onTap: () => _signOut(),
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
              alignment: Alignment.center,
              child: Column(children: <Widget>[
                Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[]),
              ]),
            ),
            Container(
              child: Image.asset('images/pizza.png'),
            )
          ]),
        ),
      ),
    );
  }
}

class _home extends StatefulWidget {
  @override
  __homeState createState() => __homeState();
}

class __homeState extends State<_home> {
  FooditemList filteredFoodList = fooditemList;
  var udin = 'all';
  var currSearch = '';
  setFoodList() {
    List<FoodItem> ajuk = [];
    for (var foodItem in fooditemList.foodItems) {
      if (udin == 'all' || udin == foodItem.cate) {
        ajuk.add(foodItem);
      }
    }
    FooditemList tempFoodList = new FooditemList(foodItems: ajuk);
    setState(() {
      filteredFoodList = tempFoodList;
    });
  }

  setSearchField() {
    List<FoodItem> ajuk = [];
    for (var foodItem in fooditemList.foodItems) {
      if (foodItem.title.toLowerCase().contains(currSearch.toLowerCase())) {
        ajuk.add(foodItem);
      }
    }
    FooditemList tempFoodList = new FooditemList(foodItems: ajuk);
    setState(() {
      filteredFoodList = tempFoodList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
      child: ListView(
        children: <Widget>[
          FirstHalf(
              categorySelect: (String cate) {
                setState(() {
                  udin = cate;
                });
                setFoodList();
              },
              searchField: (String search) {
                setState(() {
                  currSearch = search;
                });
                setSearchField();
              },
              udin: this.udin),
          SizedBox(height: 70),
          for (var foodItem in filteredFoodList.foodItems)
            Builder(
              builder: (context) {
                return ItemContainer(foodItem: foodItem);
              },
            )
        ],
      ),
    ));
  }
}

class Home extends StatefulWidget {
  const Home({this.onSignedOut});
  final Function() onSignedOut;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<void> _signOut() async {
    try {
      final BaseAuth auth = AuthProvider.of(context).auth;
      await auth.signOut();
      widget.onSignedOut();
    } catch (e) {
      print(e);
    }
  }

  Widget homePage() {
    return HomePage(
      onSignedOut: widget.onSignedOut,
    );
  }

  int _SelectedIndex = 0;
  void _onItemTap(int index) {
    setState(() {
      _SelectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined), title: Text('Home')),
            BottomNavigationBarItem(
                icon: Icon(Icons.local_pizza_outlined), title: Text('Menu')),
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart), title: Text('Cart')),
          ],
          currentIndex: _SelectedIndex,
          onTap: _onItemTap,
          selectedItemColor: Themes.color,
        ),
        body: <Widget>[
          homePage(),
          _home(),
          Cart(),
        ].elementAt(_SelectedIndex));
  }
}

class ItemContainer extends StatelessWidget {
  ItemContainer({
    @required this.foodItem,
  });

  final FoodItem foodItem;
  final CartListBloc bloc = BlocProvider.getBloc<CartListBloc>();

  addToCart(FoodItem foodItem) {
    bloc.addToList(foodItem);
  }

  removeFromList(FoodItem foodItem) {
    bloc.removeFromList(foodItem);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => CartDetails(foodItem)));
      },
      child: Items(
        desc: foodItem.desc,
        itemName: foodItem.title,
        itemPrice: foodItem.price,
        imgUrl: foodItem.imgUrl,
        leftAligned: true,
      ),
    );
  }
}

class FirstHalf extends StatefulWidget {
  FirstHalf({this.categorySelect, this.udin, Key key, this.searchField})
      : super(key: key);
  String udin;

  void Function(String cate) categorySelect;
  void Function(String search) searchField;
  @override
  _FirstHalfState createState() => _FirstHalfState();
}

class _FirstHalfState extends State<FirstHalf> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 25, 0, 0),
      child: Column(
        children: <Widget>[
          title(),
          SizedBox(height: 20),
          Search(
            searchField: this.widget.searchField,
          ),
          SizedBox(height: 45),
          Categories(
              categorySelect: this.widget.categorySelect,
              udin: this.widget.udin),
        ],
      ),
    );
  }
}

class Categories extends StatelessWidget {
  const Categories({this.categorySelect, this.udin});
  final String udin;
  final void Function(String cate) categorySelect;
  Widget build(BuildContext context) {
    return Container(
      width: 600,
      height: 100,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          CategoryListItem(
            categoryIcon: IconButton(
                icon: Icon(Icons.fastfood_outlined),
                onPressed: () {
                  categorySelect('all');
                }),
            categoryName: "All F/B",
            selected: udin == 'all' ? true : false,
          ),
          CategoryListItem(
            categoryIcon: IconButton(
                icon: Icon(Icons.local_pizza_outlined),
                onPressed: () {
                  categorySelect('food');
                }),
            categoryName: "Main Dish",
            selected: udin == 'food' ? true : false,
          ),
          CategoryListItem(
            categoryIcon: IconButton(
                icon: Icon(Icons.local_drink_outlined),
                onPressed: () {
                  categorySelect('drink');
                }),
            categoryName: "Drinks",
            selected: udin == 'drink' ? true : false,
          ),
        ],
      ),
    );
  }
}

class Items extends StatefulWidget {
  Items({
    @required this.leftAligned,
    @required this.imgUrl,
    @required this.itemName,
    @required this.itemPrice,
    @required this.desc,
  });

  final bool leftAligned;
  final String imgUrl;
  final String itemName;
  final int itemPrice;
  final String desc;

  @override
  _ItemsState createState() => _ItemsState();
}

class _ItemsState extends State<Items> {
  @override
  Widget build(BuildContext context) {
    double containerPadding = 45;
    double containerBorderRadius = 10;

    return Column(
      children: <Widget>[
        Container(
          child: Column(
            children: <Widget>[
              Container(
                width: double.infinity,
                height: 200,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10)),
                child: ClipRRect(
                  child: Image.network(
                    widget.imgUrl,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                  padding: EdgeInsets.only(
                    left: widget.leftAligned ? 20 : 0,
                    right: widget.leftAligned ? 0 : 20,
                  ),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Text(widget.itemName,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18,
                                  )),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 20),
                              child: Text("Rp. ${widget.itemPrice}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18,
                                  )),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: RichText(
                            text: TextSpan(
                                style: TextStyle(
                                    color: Colors.black45, fontSize: 15),
                                children: [
                                  TextSpan(text: " "),
                                  TextSpan(
                                      text: widget.desc,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700))
                                ]),
                          ),
                        ),
                        SizedBox(height: containerPadding),
                      ])),
            ],
          ),
        )
      ],
    );
  }
}

class CategoryListItem extends StatefulWidget {
  CategoryListItem({
    Key key,
    @required this.categoryIcon,
    @required this.categoryName,
    @required this.selected,
  }) : super(key: key);

  final IconButton categoryIcon;
  final String categoryName;

  bool selected;
  @override
  _CategoryListItemState createState() => _CategoryListItemState();
}

class _CategoryListItemState extends State<CategoryListItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 20),
      padding: EdgeInsets.fromLTRB(10, 10, 10, 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: widget.selected ? Themes.color : Colors.white,
        border: Border.all(
            color: widget.selected ? Colors.transparent : Colors.grey[200],
            width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.grey[100],
            blurRadius: 15,
            offset: Offset(15, 0),
            spreadRadius: 5,
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Container(
              padding: EdgeInsets.only(right: 5, left: 5),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(
                      color: widget.selected
                          ? Colors.transparent
                          : Colors.grey[200],
                      width: 1.5)),
              child: widget.categoryIcon),
          SizedBox(height: 10),
          Text(
            widget.categoryName,
            style: TextStyle(
                fontWeight: FontWeight.w700, color: Colors.black, fontSize: 15),
          ),
        ],
      ),
    );
  }
}

class Search extends StatelessWidget {
  const Search({this.searchField});
  final void Function(String search) searchField;
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          Icons.search,
          color: Colors.black45,
        ),
        SizedBox(width: 10),
        Expanded(
          child: TextField(
            onChanged: (String search) {
              searchField(search);
            },
            decoration: InputDecoration(
              hintText: "Search....",
              contentPadding: EdgeInsets.symmetric(vertical: 10),
              hintStyle: TextStyle(
                color: Colors.black87,
              ),
            ),
          ),
        ),
        SizedBox(width: 40)
      ],
    );
  }
}

Widget title() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: Themes.color),
        margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        width: 400,
        height: 100,
        child: Padding(
          padding: EdgeInsets.fromLTRB( 20,10,0,0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Popolamama",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 30,
                ),
              ),
              Text(
                "Pizza",
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 30,
                ),
              ),
            ],
          ),
        ),
      )
    ],
  );
}

class CustomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final CartListBloc bloc = BlocProvider.getBloc<CartListBloc>();
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          StreamBuilder(
            stream: bloc.listStream,
            builder: (context, snapshot) {
              List<FoodItem> foodItems = snapshot.data;
              int length = foodItems != null ? foodItems.length : 0;
              return buildGestureDetector(length, context, foodItems);
            },
          )
        ],
      ),
    );
  }

  GestureDetector buildGestureDetector(
      int length, BuildContext context, List<FoodItem> foodItems) {
    return GestureDetector(
      onTap: () {
        if (length > 0) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Cart()));
        } else {
          return;
        }
      },
      child: Container(
        margin: EdgeInsets.only(right: 30),
        child: Row(children: <Widget>[
          Icon(Icons.shopping_cart),
          SizedBox(width: 10),
          Text(
            length.toString(),
          ),
        ]),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: Themes.color, borderRadius: BorderRadius.circular(50)),
      ),
    );
  }
}
