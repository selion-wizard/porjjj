import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:taskmanager/models/cart_model.dart';

class CartPage extends StatefulWidget {
  static const String route = '/cart';
  const CartPage({super.key});

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final CartModel _cartModel = CartModel();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _saveOrderToHistory() async {
    final user = _auth.currentUser;
    if (user == null) return;

    double totalPrice = _cartModel.getTotalPrice();

    try {
      final userDoc = await _firestore.collection('users').doc(user.uid).get();
      final currentBalance = userDoc.data()?['balance'] ?? 0.0;

      if (currentBalance < totalPrice) {
        _showSnackBar('Недостаточно средств на балансе', Colors.red);
        return;
      }

      final order = {
        'userId': user.uid,
        'date': FieldValue.serverTimestamp(),
        'total': totalPrice,
        'totalDisplay': totalPrice.toStringAsFixed(2),
        'items': _cartModel.items.map((item) => {
          'name': item.product.name,
          'price': item.product.price,
          'quantity': item.quantity,
          'itemTotal': item.product.price * item.quantity,
          'productId': item.product.id,
        }).toList(),
        'status': 'В процессе'
      };

      await _firestore.collection('orders').add(order);
      await _firestore.collection('users').doc(user.uid).update({
        'balance': FieldValue.increment(-totalPrice)
      });

      _showSnackBar('Заказ успешно оформлен', Colors.green);
      _cartModel.clearCart();
      
      Navigator.of(context).popUntil((route) => route.isFirst);

    } catch (e) {
      _showSnackBar('Ошибка оформления заказа: $e', Colors.red);
    }
  }

  void _showSnackBar(String message, Color backgroundColor) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: backgroundColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Корзина'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => setState(_cartModel.clearCart),
          )
        ],
      ),
      body: _cartModel.items.isEmpty
          ? const Center(child: Text('Корзина пуста'))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: _cartModel.items.length,
                    itemBuilder: (context, index) {
                      final cartItem = _cartModel.items[index];
                      return Dismissible(
                        key: Key(cartItem.product.id.toString()),
                        background: Container(
                          color: Colors.red,
                          alignment: Alignment.centerRight,
                          child: const Padding(
                            padding: EdgeInsets.only(right: 16.0),
                            child: Icon(Icons.delete, color: Colors.white),
                          ),
                        ),
                        direction: DismissDirection.endToStart,
                        onDismissed: (_) => setState(() {
                          _cartModel.removeFromCart(cartItem.product);
                        }),
                        child: ListTile(
                          leading: Image.network(
                            cartItem.product.image,
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(Icons.image_not_supported);
                            },
                          ),
                          title: Text(cartItem.product.name),
                          subtitle: Text('${cartItem.product.price} ₽'),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.remove),
                                onPressed: () => setState(() {
                                  if (cartItem.quantity > 1) {
                                    cartItem.quantity--;
                                  } else {
                                    _cartModel.removeFromCart(cartItem.product);
                                  }
                                }),
                              ),
                              Text('${cartItem.quantity}'),
                              IconButton(
                                icon: const Icon(Icons.add),
                                onPressed: () => setState(() {
                                  cartItem.quantity++;
                                }),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Итого: ${_cartModel.getTotalPrice().toStringAsFixed(2)} ₽',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: _cartModel.items.isEmpty 
                            ? null 
                            : _saveOrderToHistory,
                        child: const Text('Оформить заказ'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}