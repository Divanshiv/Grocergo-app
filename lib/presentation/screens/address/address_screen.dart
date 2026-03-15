import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:grocergo/presentation/providers/address_provider.dart';
import 'package:grocergo/presentation/widgets/custom_button.dart';
import 'package:grocergo/presentation/widgets/custom_textfield.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final _addressController = TextEditingController();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _cityController = TextEditingController();
  final _zipController = TextEditingController();
  bool _isManual = false;

  @override
  void dispose() {
    _addressController.dispose();
    _nameController.dispose();
    _phoneController.dispose();
    _cityController.dispose();
    _zipController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final addressProvider = Provider.of<AddressProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Delivery Address')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomButton(
              text: addressProvider.isLoading ? 'Fetching Location...' : 'Use Current Location',
              onPressed: () async {
                await addressProvider.getCurrentLocation();
                if (addressProvider.currentAddress != null) {
                  setState(() {
                    _isManual = true;
                    _addressController.text = addressProvider.currentAddress!;
                  });
                }
              },
              icon: Icons.my_location,
            ),
            const SizedBox(height: 16),
            const Center(child: Text('OR', style: TextStyle(color: Colors.grey))),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () => setState(() => _isManual = !_isManual),
              child: Text(_isManual ? 'Manual Entry' : 'Manual Entry (Show Form)'),
            ),
            if (_isManual) ...[
              const SizedBox(height: 20),
              CustomTextField(hintText: 'Full Name', controller: _nameController, prefixIcon: Icons.person_outline),
              const SizedBox(height: 12),
              CustomTextField(hintText: 'Phone Number', controller: _phoneController, prefixIcon: Icons.phone_android, keyboardType: TextInputType.phone),
              const SizedBox(height: 12),
              CustomTextField(hintText: 'Address Line', controller: _addressController, prefixIcon: Icons.home_outlined),
              const SizedBox(height: 12),
              CustomTextField(hintText: 'City', controller: _cityController, prefixIcon: Icons.location_city),
              const SizedBox(height: 12),
              CustomTextField(hintText: 'ZIP Code', controller: _zipController, prefixIcon: Icons.map_outlined, keyboardType: TextInputType.number),
              const SizedBox(height: 32),
              CustomButton(
                text: 'Deliver Here',
                onPressed: () {
                  if (_addressController.text.isNotEmpty && _nameController.text.isNotEmpty) {
                    addressProvider.setManualAddress(_addressController.text);
                    Navigator.pop(context); // Go back to checkout
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please fill required fields')));
                  }
                },
              ),
            ],
          ],
        ),
      ),
    );
  }
}
