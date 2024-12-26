import 'product_model.dart';

class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});
}

class CartModel {
  static final CartModel _instance = CartModel._internal();
  factory CartModel() => _instance;
  CartModel._internal();

  final List<CartItem> _items = [];

  List<CartItem> get items => _items;

  void addToCart(Product product) {

    for (var item in _items) {
      if (item.product.name == product.name) {
        item.quantity++;
        return;
      }
    }

    _items.add(CartItem(product: product));
  }

  void removeFromCart(Product product) {
    _items.removeWhere((item) => item.product.name == product.name);
  }

  void clearCart() {
    _items.clear();
  }

  double getTotalPrice() {
    return _items.fold(0, (total, item) => total + (item.product.price * item.quantity));
  }
}