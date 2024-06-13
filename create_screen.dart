import 'package:flutter/material.dart';
import 'package:tugas1_login/home_page.dart';
import 'package:tugas1_login/login_screen.dart';

class CreateScreen extends StatefulWidget {
  const CreateScreen({Key? key}) : super(key: key);

  @override
  State<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  final List<Item> _items = [];
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  DateTime? _selectedDate;

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

  @override
  Widget build(BuildContext context) {
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
        body: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Masukan Nama Panen',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _weightController,
                decoration: InputDecoration(
                  labelText: 'Berat/Bobot',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: <Widget>[
                  Text(
                    _selectedDate == null
                        ? 'Pilih Tanggal'
                        : 'Tanggal: ${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}',
                  ),
                  IconButton(
                    icon: Icon(Icons.calendar_today),
                    onPressed: () => _selectDate(context),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: _addItem,
                child: Text('Buat Laporan'),
              ),
            ],
          ),
        ));
  }
}
