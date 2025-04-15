import 'dart:io';
import 'package:flutter/material.dart';
import '../models/inventory_item.dart';
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
    final hasImage = item.imagePath.isNotEmpty && File(item.imagePath).existsSync();
    return GestureDetector(
      onTap: onTap,
      child: Consumer<InvenItemViewModel>(
        builder: (context, viewModel, child){
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.08),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white.withOpacity(0.15)),
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
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: hasImage
                      ? Image.file(
                          File(item.imagePath),
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                        )
                      : Container(
                          width: 60,
                          height: 60,
                          color: Colors.white12,
                          child: const Icon(Icons.image_not_supported, color: Colors.white38),
                        ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.name,
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        item.description,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 6),
                    ],
                  ),
                ),
                if (onDelete != null)
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.redAccent),
                    onPressed: onDelete,
                  ),
              ],
            ),
          );
        }
      )
    );
  }
}
