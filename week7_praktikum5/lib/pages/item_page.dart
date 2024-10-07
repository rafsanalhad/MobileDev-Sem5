import 'package:flutter/material.dart';

class ItemPage extends StatelessWidget {
  const ItemPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return Scaffold(
      appBar: AppBar(title: Text('Item Detail')),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
        
            Hero(
              tag: 'product-image-${args['id']}', 
              child: Image.asset(
                'assets/images/${args['photo']}',
                width: 100, 
                height: 100,
              ),
            ),
            SizedBox(width: 20), // Spasi antara gambar dan teks
            // Menampilkan informasi produk
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${args['name']}'),
                Text('Price: ${args['price']}'),
                Text('Stock: ${args['stock']}'),
                Text('Rating: ${args['rating']}'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
