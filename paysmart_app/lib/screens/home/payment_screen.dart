import 'package:flutter/material.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/input_field.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final _amountController = TextEditingController();
  final _phoneController = TextEditingController();
  bool loading = false;

  void _startPayment() async {
    setState(() => loading = true);
    await Future.delayed(const Duration(seconds: 2));
    setState(() => loading = false);
    // Simulate success
    showDialog(context: context, builder: (_) => AlertDialog(
      title: const Text('Payment Initiated'),
      content: const Text('STK Push has been sent to your phone (simulated).'),
      actions: [
        TextButton(onPressed: ()=> Navigator.pop(context), child: const Text('OK'))
      ],
    ));
  }

  @override
  void dispose() {
    _amountController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const SizedBox(height: 10),
          InputField(controller: _amountController, hintText: 'Amount'),
          const SizedBox(height: 12),
          InputField(controller: _phoneController, hintText: 'Phone number'),
          const SizedBox(height: 20),
          CustomButton(text: loading ? 'Processing...' : 'Pay with M-Pesa', onPressed: loading ? null : _startPayment),
        ],
      ),
    );
  }
}