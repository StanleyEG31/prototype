import 'package:flutter/material.dart';

import 'package:flutter_application_1/models/searchpage.dart';
import 'package:flutter_application_1/models/account.dart';

class MyApp extends StatelessWidget {
  final Cart _cart = Cart();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-Commerce App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(cart: _cart),
      routes: {
        '/product-details': (context) {
          final entry = ModalRoute.of(context)!.settings.arguments
              as MapEntry<String, String>;
          return ProductDetailsPage(entry: entry, cart: _cart);
        },
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  final Cart cart;

  MyHomePage({required this.cart});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late List<Widget> _children;

  @override
  void initState() {
    super.initState();
    _children = [
      HomePage(cart: widget.cart),
      SearchPage(cart: widget.cart),
      CartPage(cart: widget.cart),
      AccountPage(),
    ];
  }

  int _currentIndex = 0;

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('E-Commerce App'),
        backgroundColor: Colors.blue,
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: Container(
        height: 60,
        decoration: BoxDecoration(
          color: Colors.blue,
          border: Border(
            top: BorderSide(
              color: Colors.grey[300]!,
              width: 0.5,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.home),
                  onPressed: () {
                    onTabTapped(0);
                  },
                ),
                const Text(
                  'Home',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    onTabTapped(1);
                  },
                ),
                const Text(
                  'Search',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.shopping_cart),
                  onPressed: () {
                    onTabTapped(2);
                  },
                ),
                const Text(
                  'Cart',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.account_circle),
                  onPressed: () {
                    onTabTapped(3);
                  },
                ),
                const Text(
                  'Account',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ProductDetailsPage extends StatelessWidget {
  static Route route(MapEntry<String, String> entry, {required Cart cart}) {
    return MaterialPageRoute<void>(
      builder: (_) => ProductDetailsPage(entry: entry, cart: cart),
      settings: RouteSettings(
        arguments: entry,
      ),
    );
  }

  final MapEntry<String, String> entry;
  final Cart cart;

  const ProductDetailsPage({Key? key, required this.entry, required this.cart})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(entry.key),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(entry.value, fit: BoxFit.cover, height: 300),
              const SizedBox(height: 16),
              Text(entry.key),
              const SizedBox(height: 16),
              const Text('\₱20.00'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  cart.addItem(entry.key, 1, 20.00);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Added to cart')),
                  );
                },
                child: const Text('Add to Cart'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  final Cart cart;

  const HomePage({Key? key, required this.cart}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Map<String, String> _shirtImages = {
      'polo':
          'https://filebroker-cdn.lazada.com.ph/kf/S402069780f5f4c80b982840b9245beaaD.jpg',
      'Pants':
          'https://filebroker-cdn.lazada.com.ph/kf/Sb12c7ce6c59044b1acc5a2a0635213d8R.jpg',
      'Blouse': 'https://i.ebayimg.com/images/g/fP8AAOSwSMRgRzSF/s-l1200.jpg',
      'Skirt':
          'https://m.media-amazon.com/images/I/71fDXnmyhIL._AC_UY1100_.jpg',
    };

    return Scaffold(
      body: Container(
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.fromLTRB(10, 50, 10, 10),
                              width: 500,
                              height: 400,
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            Item1(cart: cart)),
                                  );
                                },
                              ),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(_shirtImages['polo']!),
                                    fit: BoxFit.fill),
                              ),
                            ),
                            const Column(
                              children: [
                                Text(
                                  'Polo',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.fromLTRB(10, 50, 10, 10),
                              width: 500,
                              height: 400,
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            Blouse(cart: cart)),
                                  );
                                },
                              ),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image:
                                        NetworkImage(_shirtImages['Blouse']!),
                                    fit: BoxFit.fill),
                              ),
                            ),
                            const Column(
                              children: [
                                Text(
                                  "Women's Blouse",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.fromLTRB(10, 50, 10, 10),
                              width: 500,
                              height: 400,
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            Pants1(cart: cart)),
                                  );
                                },
                              ),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(_shirtImages['Pants']!),
                                    fit: BoxFit.fill),
                              ),
                            ),
                            const Column(
                              children: [
                                Text(
                                  "Pants",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.fromLTRB(10, 50, 10, 10),
                              width: 500,
                              height: 400,
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            Skirt(cart: cart)),
                                  );
                                },
                              ),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(_shirtImages['Skirt']!),
                                    fit: BoxFit.fill),
                              ),
                            ),
                            const Column(
                              children: [
                                Text(
                                  'Skirt',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Item1 extends StatefulWidget {
  final Cart cart;

  const Item1({Key? key, required this.cart}) : super(key: key);

  @override
  _Item1State createState() => _Item1State();
}

class _Item1State extends State<Item1> {
  int _quantity = 0;
  final _quantityController = TextEditingController();
  String? _errorMessage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Item 1'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
                'https://filebroker-cdn.lazada.com.ph/kf/S402069780f5f4c80b982840b9245beaaD.jpg',
                fit: BoxFit.cover,
                height: 300),
            const SizedBox(height: 16),
            const Text("Boy's Polo"),
            const SizedBox(height: 16),
            const Text('₱600'),
            if (_errorMessage != null)
              Text(
                _errorMessage!,
                style: const TextStyle(color: Colors.red),
              ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _quantityController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: 'Enter a quantity only accepts numbers',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      if (value.isEmpty) {
                        setState(() {
                          _errorMessage = null;
                          _quantity = 0;
                        });
                        return;
                      }
                      if (int.tryParse(value) != null) {
                        setState(() {
                          _quantity = int.parse(value);
                          _errorMessage = null;
                        });
                      } else {
                        setState(() {
                          _errorMessage =
                              "Invalid quantity value. Please enter a number.";
                          _quantity = 0;
                        });
                      }
                    },
                  ),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: _quantity > 0
                      ? () {
                          setState(() {
                            widget.cart.addItem("Boy's Polo", _quantity, 600);
                          });
                          Navigator.pop(context);
                        }
                      : null,
                  child: const Text('Add to Cart'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _quantityController.dispose();
    super.dispose();
  }
}

class Blouse extends StatefulWidget {
  final Cart cart;

  const Blouse({Key? key, required this.cart}) : super(key: key);

  @override
  _BlouseState createState() => _BlouseState();
}

class _BlouseState extends State<Blouse> {
  int _quantity = 0;
  final _quantityController = TextEditingController();
  String? _errorMessage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blouse'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
                'https://i.ebayimg.com/images/g/fP8AAOSwSMRgRzSF/s-l1200.jpg',
                fit: BoxFit.cover,
                height: 300),
            const SizedBox(height: 16),
            const Text("Blouse"),
            const SizedBox(height: 16),
            const Text('₱900'),
            if (_errorMessage != null)
              Text(
                _errorMessage!,
                style: const TextStyle(color: Colors.red),
              ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _quantityController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: 'Enter a quantity only accepts numbers',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      if (value.isEmpty) {
                        setState(() {
                          _errorMessage = null;
                          _quantity = 0;
                        });
                        return;
                      }
                      if (int.tryParse(value) != null) {
                        setState(() {
                          _quantity = int.parse(value);
                          _errorMessage = null;
                        });
                      } else {
                        setState(() {
                          _errorMessage =
                              "Invalid quantity value. Please enter a number.";
                          _quantity = 0;
                        });
                      }
                    },
                  ),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: _quantity > 0
                      ? () {
                          setState(() {
                            widget.cart.addItem("Blouse", _quantity, 900);
                          });
                          Navigator.pop(context);
                        }
                      : null,
                  child: const Text('Add to Cart'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _quantityController.dispose();
    super.dispose();
  }
}

class Pants1 extends StatefulWidget {
  final Cart cart;

  const Pants1({Key? key, required this.cart}) : super(key: key);

  @override
  _Pants1State createState() => _Pants1State();
}

class _Pants1State extends State<Pants1> {
  int _quantity = 0;
  final _quantityController = TextEditingController();
  String? _errorMessage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pants 1'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
                'https://filebroker-cdn.lazada.com.ph/kf/Sb12c7ce6c59044b1acc5a2a0635213d8R.jpg',
                fit: BoxFit.cover,
                height: 300),
            const SizedBox(height: 16),
            const Text("Pants 1"),
            const SizedBox(height: 16),
            const Text('₱100'),
            if (_errorMessage != null)
              Text(
                _errorMessage!,
                style: const TextStyle(color: Colors.red),
              ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _quantityController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: 'Enter a quantity only accepts numbers',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      if (value.isEmpty) {
                        setState(() {
                          _errorMessage = null;
                          _quantity = 0;
                        });
                        return;
                      }
                      if (int.tryParse(value) != null) {
                        setState(() {
                          _quantity = int.parse(value);
                          _errorMessage = null;
                        });
                      } else {
                        setState(() {
                          _errorMessage =
                              "Invalid quantity value. Please enter a number.";
                          _quantity = 0;
                        });
                      }
                    },
                  ),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: _quantity > 0
                      ? () {
                          setState(() {
                            widget.cart.addItem("Pants 1", _quantity, 100);
                          });
                          Navigator.pop(context);
                        }
                      : null,
                  child: const Text('Add to Cart'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _quantityController.dispose();
    super.dispose();
  }
}

class Skirt extends StatefulWidget {
  final Cart cart;

  const Skirt({Key? key, required this.cart}) : super(key: key);

  @override
  _SkirtState createState() => _SkirtState();
}

class _SkirtState extends State<Skirt> {
  int _quantity = 0;
  final _quantityController = TextEditingController();
  String? _errorMessage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Skirt"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
                'https://m.media-amazon.com/images/I/71fDXnmyhIL._AC_UY1100_.jpg',
                fit: BoxFit.cover,
                height: 300),
            const SizedBox(height: 16),
            const Text("Skirt"),
            const SizedBox(height: 16),
            const Text('₱200'),
            if (_errorMessage != null)
              Text(
                _errorMessage!,
                style: const TextStyle(color: Colors.red),
              ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _quantityController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: 'Enter a quantity only accepts numbers',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      if (value.isEmpty) {
                        setState(() {
                          _errorMessage = null;
                          _quantity = 0;
                        });
                        return;
                      }
                      if (int.tryParse(value) != null) {
                        setState(() {
                          _quantity = int.parse(value);
                          _errorMessage = null;
                        });
                      } else {
                        setState(() {
                          _errorMessage =
                              "Invalid quantity value. Please enter a number.";
                          _quantity = 0;
                        });
                      }
                    },
                  ),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: _quantity > 0
                      ? () {
                          setState(() {
                            widget.cart.addItem("Skirt", _quantity, 200);
                          });
                          Navigator.pop(context);
                        }
                      : null,
                  child: const Text('Add to Cart'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _quantityController.dispose();
    super.dispose();
  }
}

class CartPage extends StatefulWidget {
  final Cart cart;

  CartPage({required this.cart});

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
            'Cart                                                                                                                                                                                                                                       Click item to remove'),
      ),
      body: widget.cart.items.isEmpty
          ? const Center(
              child: Text('Cart is empty'),
            )
          : ListView.builder(
              itemCount: widget.cart.items.length,
              itemBuilder: (context, index) {
                final item = widget.cart.items[index];
                return ListTile(
                  title: Text(item.name),
                  subtitle: Text('Quantity: ${item.quantity}'),
                  trailing: Text('\₱${item.price * item.quantity}'),
                  onTap: () {
                    // Remove item from cart when user taps on it
                    setState(() {
                      widget.cart.removeItem(index);
                    });
                  },
                );
              },
            ),
      bottomNavigationBar: Container(
        height: 60,
        decoration: BoxDecoration(
          color: Colors.blue,
          border: Border(
            top: BorderSide(
              color: Colors.grey[300]!,
              width: 0.5,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Total: ₱${widget.cart.totalPrice.toStringAsFixed(2)}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Clear cart when user taps on the clear cart button
                    setState(() {
                      widget.cart.clear();
                    });
                  },
                  child: const Text('Clear Cart'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

extension on Cart {
  void clear() {
    _items.clear();
  }
}

class CartItem {
  String name;
  int quantity;
  double price;

  CartItem(this.name, this.quantity, this.price);
}

class Cart {
  List<CartItem> _items = [];

  void addItem(String name, int quantity, double price) {
    final existingItemIndex = _items.indexWhere((item) => item.name == name);

    if (existingItemIndex != -1) {
      // Item with the same name already exists, update the quantity
      _items[existingItemIndex].quantity += quantity;
    } else {
      // Item with the same name doesn't exist, add a new item
      _items.add(CartItem(name, quantity, price));
    }
  }

  void removeItem(int index) {
    _items.removeAt(index);
  }

  List<CartItem> get items => _items;

  double get totalPrice => _items.fold(
      0, (total, current) => total + (current.price * current.quantity));
}
