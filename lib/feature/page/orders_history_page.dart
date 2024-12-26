import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OrdersHistoryPage extends StatefulWidget {
  static const String route = '/orders-history';

  const OrdersHistoryPage({super.key});

  @override
  _OrdersHistoryPageState createState() => _OrdersHistoryPageState();
}

class _OrdersHistoryPageState extends State<OrdersHistoryPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? user;
  List<Map<String, dynamic>> currentOrders = [];
  List<Map<String, dynamic>> pastOrders = [];

  @override
  void initState() {
    super.initState();
    user = _auth.currentUser ;
    loadOrders();
  }

  Future<void> loadOrders() async {
    if (user != null) {
      try {
        final currentOrdersSnapshot = await _firestore
            .collection('orders')
            .where('userId', isEqualTo: user!.uid)
            .where('status', whereIn: ['В процессе', 'Подтвержден', 'Сборка'])
            .get();

        final pastOrdersSnapshot = await _firestore
            .collection('orders')
            .where('userId', isEqualTo: user!.uid)
            .where('status', whereIn: ['Завершен', 'Отменен'])
            .get();

        setState(() {
          currentOrders = currentOrdersSnapshot.docs
              .map((doc) => {'id': doc.id, 'data': doc.data()})
              .toList();
          
          pastOrders = pastOrdersSnapshot.docs
              .map((doc) => {'id': doc.id, 'data': doc.data()})
              .toList();
        });
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Ошибка загрузки заказов: $e'))
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (user == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('История заказов')),
        body: const Center(child: Text('Пожалуйста, авторизуйтесь')),
      );
    }

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('История заказов'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Текущие заказы'),
              Tab(text: 'История заказов'),
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () {
                loadOrders();
              },
            ),
          ],
        ),
        body: TabBarView(
          children: [
            _buildOrdersList(currentOrders),
            _buildOrdersList(pastOrders),
          ],
        ),
      ),
    );
  }

  Widget _buildOrdersList(List<Map<String, dynamic>> orders) {
    if (orders.isEmpty) {
      return const Center(child: Text('Нет заказов'));
    }

    return ListView.builder(
      itemCount: orders.length,
      itemBuilder: (context, index) {
        final order = orders[index];
        return Card(
          child: ExpansionTile(
            title: Text('Заказ #${order['id']}'),
            subtitle: Text(order['data']['totalDisplay'] + ' ₽'),
            children: [
              ...order['data']['items'].map<Widget>((item) => ListTile(
                    title: Text(item['name']),
                    trailing: Text('${item['quantity']} x ${item['price']} ₽'),
                  )),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Статус: ${order['data']['status']}',
                  style: TextStyle(
                    color: order['data']['status'] == 'В процессе' 
                        ? Colors.orange 
                        : Colors.green,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}