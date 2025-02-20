import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App de Gestão',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ProdutosPage(),
    );
  }
}

class ProdutosPage extends StatefulWidget {
  @override
  _ProdutosPageState createState() => _ProdutosPageState();
}

class _ProdutosPageState extends State<ProdutosPage> {
  final List<String> produtos = ['Laranja', 'Morango', 'Abacate'];
  final TextEditingController _controller = TextEditingController();

  void _adicionarProduto() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        produtos.add(_controller.text);
        _controller.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Produtos'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: produtos.length,
              itemBuilder: (context, index) => ListTile(
                title: Text(produtos[index]),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(hintText: 'Novo produto'),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: _adicionarProduto,
                ),
              ],
            ),
          ),
        ],
      ),
      persistentFooterButtons: [
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ClientesPage()),
            );
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.arrow_forward),
              SizedBox(width: 8),
              Text('Clientes'),
            ],
          ),
        ),
      ],
    );
  }
}

class ClientesPage extends StatefulWidget {
  @override
  _ClientesPageState createState() => _ClientesPageState();
}

class _ClientesPageState extends State<ClientesPage> {
  final List<String> clientes = ['Ana', 'João', 'Pablo'];
  final TextEditingController _controller = TextEditingController();

  void _adicionarCliente() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        clientes.add(_controller.text);
        _controller.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Clientes'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: clientes.length,
              itemBuilder: (context, index) => ListTile(
                title: Text(clientes[index]),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(hintText: 'Novo cliente'),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: _adicionarCliente,
                ),
              ],
            ),
          ),
        ],
      ),
      persistentFooterButtons: [
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PedidosPage()),
            );
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.arrow_forward),
              SizedBox(width: 8),
              Text('Pedidos'),
            ],
          ),
        ),
      ],
    );
  }
}

class PedidosPage extends StatefulWidget {
  @override
  _PedidosPageState createState() => _PedidosPageState();
}

class _PedidosPageState extends State<PedidosPage> {
  final List<String> pedidos = ['Pedido 1', 'Pedido 2', 'Pedido 3'];
  final TextEditingController _controller = TextEditingController();

  void _adicionarPedido() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        pedidos.add(_controller.text);
        _controller.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pedidos'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: pedidos.length,
              itemBuilder: (context, index) => ListTile(
                title: Text(pedidos[index]),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(hintText: 'Novo pedido'),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: _adicionarPedido,
                ),
              ],
            ),
          ),
        ],
      ),
      persistentFooterButtons: [
        ElevatedButton(
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => ProdutosPage()),
              (route) => false,
            );
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.home),
              SizedBox(width: 8),
              Text('Produtos'),
            ],
          ),
        ),
      ],
    );
  }
}
