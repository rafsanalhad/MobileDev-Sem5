import 'package:flutter/material.dart';
import '../models/item.dart';

class ListViewWidget extends StatelessWidget {
  final List<Item> items;
  const ListViewWidget({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Jumlah kolom
            childAspectRatio: 0.7, // Rasio lebar dan tinggi
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          padding: EdgeInsets.all(0),
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            return InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  '/item',
                  arguments: {
                    'name': item.name, // Contoh data yang dikirim
                    'price': item.price,
                    'photo': item.photo,
                    'stock': item.stock,
                    'rating': item.rating,
                  },
                );
              },
              child: Card(
                  child: Container(
                      margin: EdgeInsets.all(0),
                      alignment: Alignment.topLeft,
                      child: Column(
                        children: [
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset(
                                'assets/images/${item.photo}',
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: 120,
                              ),
                              SizedBox(height: 5),
                              Container(
                                  alignment: Alignment.topLeft,
                                  padding: EdgeInsets.only(left: 5),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Nama: ${item.name}"),
                                      Text("Harga: ${item.price}"),
                                      Text("Stock: ${item.stock}"),
                                      Text("Rating: ${item.rating}"),
                                    ],
                                  ))
                            ],
                          )),
                        ],
                      ))),
            );
          }),
    );
  }
}
