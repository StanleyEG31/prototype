import 'package:flutter/material.dart';
import 'package:flutter_application_1/homepage.dart';

class Search {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  List<String> _itemList = [];
  final List<String> _allItems = [
    'Polo',
    'Pants',
    'Women Blouse',
    'Women Skirt',
  ];

  void updateItemList(String value) {
    _itemList.clear();
    _allItems.forEach((item) {
      if (item.toLowerCase().contains(value.toLowerCase())) {
        _itemList.add(item);
      }
    });
    _itemList.sort(); // Sort the items alphabetically
  }

  TextEditingController get controller => _controller;
  List<String> get itemList => _itemList;
  FocusNode get focusNode => _focusNode;
}

class SearchPage extends StatefulWidget {
  final Cart cart; // Add this line

  SearchPage({required this.cart}); // Add this line

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final Search _search = Search();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _search.controller,
          decoration: InputDecoration(
            hintText: 'Search',
            prefixIcon: Icon(Icons.search),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onChanged: (value) {
            setState(() {
              _search.updateItemList(value);
            });
          },
        ),
      ),
      body: Center(
        child: _buildSearchResults(), // Use _buildSearchResults method here
      ),
    );
  }

  Widget _buildSearchResults() {
    if (_search.controller.text.isEmpty) {
      return Text('Please enter a search query.');
    } else if (_search.itemList.isEmpty) {
      return Text('No items found.');
    } else {
      return ListView.builder(
        itemCount: _search.itemList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_search.itemList[index]),
            onTap: () {
              String itemName = _search.itemList[index];
              switch (itemName) {
                case 'Polo':
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Item1(cart: widget.cart)),
                  );
                  break;
                case 'Pants':
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Pants1(cart: widget.cart)),
                  );
                  break;
                case 'Women Blouse':
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Blouse(cart: widget.cart)),
                  );
                  break;
                case 'Women Skirt':
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Skirt(cart: widget.cart)),
                  );
                  break;
                default:
                  break;
              }
            },
          );
        },
      );
    }
  }
}
