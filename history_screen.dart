import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'home_page.dart'; // Import item class

class HistoryScreen extends StatelessWidget {
  final List<Item> items;

  HistoryScreen({required this.items});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          // Format the date to a readable string
          String formattedDate =
              DateFormat('dd/MM/yyyy').format(items[index].date);

          return Card(
            elevation: 5,
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            child: ListTile(
              title: Text(items[index].name),
              subtitle: Text(
                  'Berat: ${items[index].weight}\nTanggal: $formattedDate'),
            ),
          );
        },
      ),
    );
  }
}
