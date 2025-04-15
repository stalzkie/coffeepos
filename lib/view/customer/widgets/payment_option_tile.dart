import 'package:flutter/material.dart';
import '../../../data/models/payment_model.dart';

class PaymentOptionTile extends StatelessWidget {
  final String label;
  final PaymentMethod method;
  final PaymentMethod selectedMethod;
  final ValueChanged<PaymentMethod?> onSelected; 

  const PaymentOptionTile({
    super.key,
    required this.label,
    required this.method,
    required this.selectedMethod,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return RadioListTile<PaymentMethod>(
      title: Text(label),
      value: method,
      groupValue: selectedMethod,
      onChanged: onSelected,
    );
  }
}
