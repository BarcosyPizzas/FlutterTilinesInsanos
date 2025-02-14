import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Carrito Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Carrito Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Map<String, dynamic>> products = [
    {
      'name': 'Producto 1',
      'imageUrl': 'https://m.media-amazon.com/images/I/41LuYHUh49L._AC_SX679_.jpg',
      'quantity': 0
    },
    {
      'name': 'Producto 2',
      'imageUrl': 'https://m.media-amazon.com/images/I/61ADs13vBlL._AC_SY741_.jpg',
      'quantity': 0
    },
    {
      'name': 'Producto 3',
      'imageUrl': 'https://m.media-amazon.com/images/I/71qMvuhHe5L._AC_SX679_.jpg',
      'quantity': 0
    },
    {
      'name': 'Producto 4',
      'imageUrl': 'https://m.media-amazon.com/images/I/616iPpF5PEL._AC_SY741_.jpg',
      'quantity': 0
    },
  ];

  // Función para mostrar una alerta cuando se agrega o elimina un producto
  void _showAlert(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _incrementQuantity(int index) {
    setState(() {
      products[index]['quantity']++;
    });
    _showAlert('${products[index]['name']} agregado al carrito 🛒');
  }

  void _decrementQuantity(int index) {
    setState(() {
      if (products[index]['quantity'] > 0) {
        products[index]['quantity']--;
        _showAlert('${products[index]['name']} eliminado del carrito ❌');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Tienda de productos online',
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // 2 productos por fila
                  childAspectRatio: 0.7,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.network(
                          products[index]['imageUrl'],
                          width: 180, // Hacer las imágenes más grandes
                          height: 180,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          products[index]['name'],
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove, color: Colors.red),
                              onPressed: () => _decrementQuantity(index),
                            ),
                            Text(
                              '${products[index]['quantity']}',
                              style: const TextStyle(fontSize: 18),
                            ),
                            IconButton(
                              icon: const Icon(Icons.add, color: Colors.green),
                              onPressed: () => _incrementQuantity(index),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}