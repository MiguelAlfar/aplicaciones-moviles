
class CartItemModel {
  final String productId;
  final String productName;
  final double price;
  int quantity;

  CartItemModel({
    required this.productId,
    required this.productName,
    required this.price,
    this.quantity = 1,
  });

}
