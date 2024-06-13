import 'package:flutter/material.dart';
import 'package:tugas1_login/create_screen.dart';
import 'package:tugas1_login/grafik_screnn.dart';
import 'history_screen.dart'; // Import history screen
import 'login_screen.dart'; // Import login screen

class Item {
  String name;
  String weight;
  DateTime date;

  Item(this.name, this.weight, this.date);
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Item> _items = [];
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  DateTime? _selectedDate;
  int _selectedIndex = 0;

  void _addItem() {
    if (_nameController.text.isNotEmpty &&
        _weightController.text.isNotEmpty &&
        _selectedDate != null) {
      setState(() {
        _items.add(Item(
          _nameController.text,
          _weightController.text,
          _selectedDate!,
        ));
      });
      _nameController.clear();
      _weightController.clear();
      _selectedDate = null;
    }
  }

  void _editItem(int index) {
    final TextEditingController _editNameController =
        TextEditingController(text: _items[index].name);
    final TextEditingController _editWeightController =
        TextEditingController(text: _items[index].weight);
    DateTime _editDate = _items[index].date;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Data'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _editNameController,
                decoration: InputDecoration(
                  labelText: 'Edit Nama',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _editWeightController,
                decoration: InputDecoration(
                  labelText: 'Edit Bobot',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: <Widget>[
                  Text(
                    'Tanggal: ${_editDate.day}/${_editDate.month}/${_editDate.year}',
                  ),
                  IconButton(
                    icon: Icon(Icons.calendar_today),
                    onPressed: () async {
                      final DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: _editDate,
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101),
                      );
                      if (picked != null && picked != _editDate) {
                        setState(() {
                          _editDate = picked;
                        });
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                if (_editNameController.text.isNotEmpty &&
                    _editWeightController.text.isNotEmpty) {
                  _updateItem(
                    index,
                    _editNameController.text,
                    _editWeightController.text,
                    _editDate,
                  );
                  Navigator.of(context).pop();
                }
              },
              child: Text('Save'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void _updateItem(
      int index, String newName, String newWeight, DateTime newDate) {
    setState(() {
      _items[index].name = newName;
      _items[index].weight = newWeight;
      _items[index].date = newDate;
    });
  }

  void _deleteItem(int index) {
    setState(() {
      _items.removeAt(index);
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _pages = <Widget>[
      _buildHomePage(),
      HistoryScreen(items: _items),
      GrafikScrenn(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('My Harvest'),
        backgroundColor: Color(0xFFF32121),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            },
          ),
        ],
      ),
      body: _pages.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Grafik',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => CreateScreen()));
        },
        child: Icon(Icons.add),
        isExtended: true,
      ),
    );
  }

  Widget _buildHomePage() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: _items.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 5,
                  margin:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                  child: ListTile(
                    title: Text(_items[index].name),
                    subtitle: Text(
                      'Berat: ${_items[index].weight}\nTanggal: ${_items[index].date.day}/${_items[index].date.month}/${_items[index].date.year}',
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            _editItem(index);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            _deleteItem(index);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
