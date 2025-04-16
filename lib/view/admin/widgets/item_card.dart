import 'dart:io';
import 'package:flutter/material.dart';
import '../../../data/models/inventory_item.dart';
import 'package:coffee_inventory_app/viewmodels/inventory_item_vm.dart';
import 'package:provider/provider.dart';

class ItemCard extends StatelessWidget {
  final InventoryItem item;
  final VoidCallback? onTap;
  final VoidCallback? onDelete;

  const ItemCard({
    super.key,
    required this.item,
    this.onTap,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Consumer<InvenItemViewModel>(
        builder: (context, viewModel, child){
          return Container(
            margin: const EdgeInsets.only(top:0, left:16, right:16, bottom:15),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: const Color.fromARGB(68, 75, 75, 75)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.name,
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Quantity:${item.quantity}\t\tPrice:${item.price}",
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 6),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
      )
    );
  }
}
