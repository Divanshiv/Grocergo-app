import 'cart_item_model.dart';

enum OrderStatus { placed, preparing, outForDelivery, delivered }

class OrderModel {
  final String id;
  final List<CartItemModel> items;
  final double subtotal;
  final double deliveryFee;
  final double totalAmount;
  final DateTime orderDate;
  final OrderStatus status;
  final String paymentMethod;
  final String address;

  OrderModel({
    required this.id,
    required this.items,
    required this.subtotal,
    required this.deliveryFee,
    required this.totalAmount,
    required this.orderDate,
    required this.status,
    required this.paymentMethod,
    required this.address,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'],
      items: (json['items'] as List).map((i) => CartItemModel.fromJson(i)).toList(),
      subtotal: (json['subtotal'] as num).toDouble(),
      deliveryFee: (json['deliveryFee'] as num).toDouble(),
      totalAmount: (json['totalAmount'] as num).toDouble(),
      orderDate: DateTime.parse(json['orderDate']),
      status: OrderStatus.values.firstWhere((e) => e.toString() == 'OrderStatus.${json['status']}'),
      paymentMethod: json['paymentMethod'],
      address: json['address'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'items': items.map((i) => i.toJson()).toList(),
      'subtotal': subtotal,
      'deliveryFee': deliveryFee,
      'totalAmount': totalAmount,
      'orderDate': orderDate.toIso8601String(),
      'status': status.toString().split('.').last,
      'paymentMethod': paymentMethod,
      'address': address,
    };
  }
}
