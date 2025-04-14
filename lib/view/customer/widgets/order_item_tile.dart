import 'package:flutter/material.dart';
import '../../../data/models/order_item_model.dart';

class OrderItemTile extends StatelessWidget {
  final OrderItem item;
  final VoidCallback? onRemove;

  const OrderItemTile({super.key, required this.item, this.onRemove});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.local_cafe),
      title: Text(item.product.name),
      subtitle: Text('${item.quantity} pcs'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('\$${item.totalPrice.toStringAsFixed(2)}'),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: onRemove,
          ),
        ],
      ),
    );
  }
}