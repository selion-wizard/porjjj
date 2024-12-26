import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:go_router/go_router.dart';
import 'package:taskmanager/feature/page/orders_history_page.dart';

class ProfilePage extends StatefulWidget {
  static const String route = '/profile';

  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
  double balance = 0.0;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserBalance();
  }

  Future<void> _loadUserBalance() async {
    final user = _auth.currentUser;
    if (user != null) {
      try {
        final userDoc = await _firestore.collection('users').doc(user.uid).get();
        setState(() {
          balance = (userDoc.data()?['balance'] ?? 0.0).toDouble();
          isLoading = false;
        });
      } catch (e) {
        setState(() {
          isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Ошибка загрузки баланса: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = _auth.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Профиль'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Email'),
              subtitle: Text(user?.email ?? 'Нет email'),
            ),
            ListTile(
              leading: const Icon(Icons.account_balance_wallet),
              title: const Text('Баланс'),
              subtitle: isLoading
                  ? const Text('Загрузка...')
                  : Text('${balance.toStringAsFixed(2)} ₽'),
              trailing: IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: _loadUserBalance,
              ),
            ),
            ElevatedButton.icon(
              onPressed: () {
                context.push(OrdersHistoryPage.route);
              },
              icon: const Icon(Icons.history),
              label: const Text('История заказов'),
            ),
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                _auth.signOut();
                context.go('/login');
              },
            ),
          ],
        ),
      ),
    );
  }
}