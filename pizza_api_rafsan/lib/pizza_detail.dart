import 'package:flutter/material.dart';
import 'pizza.dart';
import 'httphelper.dart';

class PizzaDetailScreen extends StatefulWidget {
  final Pizza pizza;
  final bool isNew;
  const PizzaDetailScreen({super.key, required this.pizza, required this.isNew});

  @override
  State<PizzaDetailScreen> createState() => _PizzaDetailScreenState();
}

class _PizzaDetailScreenState extends State<PizzaDetailScreen> {
  final TextEditingController txtId = TextEditingController();
  final TextEditingController txtName = TextEditingController();
  final TextEditingController txtDescription = TextEditingController();
  final TextEditingController txtPrice = TextEditingController();
  final TextEditingController txtImageUrl = TextEditingController();
  String operationResult = '';
  Future postPizza() async {
    HttpHelper helper = HttpHelper();
    Pizza pizza = Pizza(
      id: int.tryParse(txtId.text) ?? 0,
      pizzaName: txtName.text,
      description: txtDescription.text,
      price: double.tryParse(txtPrice.text) ?? 0.0,
      imageUrl: txtImageUrl.text,
    );
    String result = await helper.postPizza(pizza);
    setState(() {
      operationResult = result;
    });
  }
  Future putPizza() async {
    HttpHelper helper = HttpHelper();
    Pizza pizza = Pizza(
      id: int.tryParse(txtId.text) ?? 0,
      pizzaName: txtName.text,
      description: txtDescription.text,
      price: double.tryParse(txtPrice.text) ?? 0.0,
      imageUrl: txtImageUrl.text,
    );
    String result = await helper.putPizza(pizza);
    setState(() {
      operationResult = result;
    });
  }

  Future savePizza() async {
    final result = widget.isNew ? await putPizza() : await postPizza();
    setState((){
      operationResult = result;
    });
  }


  @override
  void dispose() {
    txtId.dispose();
    txtName.dispose();
    txtDescription.dispose();
    txtPrice.dispose();
    txtImageUrl.dispose();
    super.dispose();
  }
  void initState(){
    if(!widget.isNew){
      txtId.text = widget.pizza.id.toString();
      txtName.text = widget.pizza.pizzaName;
      txtDescription.text = widget.pizza.price.toString();
      txtImageUrl.text = widget.pizza.imageUrl;
    }
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Pizza Detail'),
        ),
        body: Padding(
            padding: const EdgeInsets.all(12),
            child: SingleChildScrollView(
              child: Column(children: [
                Text(operationResult,
                    style: TextStyle(
                        backgroundColor: Colors.green[200],
                        color: Colors.black)),
                const SizedBox(height: 24),
                TextField(
                    controller: txtId,
                    decoration: const InputDecoration(hintText: 'Insert ID')),
                const SizedBox(height: 24),
                TextField(
                    controller: txtName,
                    decoration:
                        const InputDecoration(hintText: 'Insert Pizza Name')),
                const SizedBox(height: 24),
                TextField(
                    controller: txtDescription,
                    decoration:
                        const InputDecoration(hintText: 'Insert Description')),
                const SizedBox(height: 24),
                TextField(
                    controller: txtPrice,
                    decoration:
                        const InputDecoration(hintText: 'Insert Price')),
                const SizedBox(height: 24),
                TextField(
                    controller: txtImageUrl,
                    decoration:
                        const InputDecoration(hintText: 'Insert Image URL')),
                const SizedBox(height: 48),
                ElevatedButton(
                    child: const Text('Send Post'),
                    onPressed: () {
                      savePizza();
                    })
              ]),
            )));
  }
}
