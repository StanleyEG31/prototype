import 'package:flutter/material.dart';

class AdminPage extends StatefulWidget {
  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  Map<String, int> _stock = {
    'Polo': 10,
    'Pants': 20,
    'Women\'s Blouse': 30,
    'Women\'s Skirt': 40,
  };

  void _decrementStock(String item, int quantity) {
    if (_stock[item] != null && _stock[item]! >= quantity) {
      setState(() {
        _stock[item] = _stock[item]! - quantity;
      });
    }
  }

  void _incrementStock(String item, int quantity) {
    if (_stock[item] != null) {
      setState(() {
        _stock[item] = _stock[item]! + quantity;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _stock.entries.map<Widget>((entry) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(entry.key),
                const SizedBox(width: 16),
                Chip(
                  label: Text('${entry.value} in stock'),
                ),
                const SizedBox(width: 16),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            int _quantity = 1;
                            return AlertDialog(
                              title: const Text('Decrease Stock'),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TextField(
                                    keyboardType: TextInputType.number,
                                    onChanged: (value) {
                                      _quantity = int.tryParse(value) ?? 1;
                                    },
                                    decoration: const InputDecoration(
                                      labelText: 'Quantity',
                                    ),
                                  ),
                                ],
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    _decrementStock(entry.key, _quantity);
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Confirm'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: const Text('Decrease'),
                    ),
                    const SizedBox(width: 16),
                    ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            int _quantity = 1;
                            return AlertDialog(
                              title: const Text('Add Stock'),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TextField(
                                    keyboardType: TextInputType.number,
                                    onChanged: (value) {
                                      _quantity = int.tryParse(value) ?? 1;
                                    },
                                    decoration: const InputDecoration(
                                      labelText: 'Quantity',
                                    ),
                                  ),
                                ],
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    _incrementStock(entry.key, _quantity);
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Confirm'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: const Text('Add'),
                    ),
                  ],
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
