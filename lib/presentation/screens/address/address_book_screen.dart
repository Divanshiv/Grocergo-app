import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:grocergo/presentation/providers/address_provider.dart';
import 'package:grocergo/presentation/screens/address/address_screen.dart';
import 'package:grocergo/utils/constants/constants.dart';

class AddressBookScreen extends StatelessWidget {
  const AddressBookScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Saved Addresses')),
      body: Consumer<AddressProvider>(
        builder: (context, provider, _) {
          if (provider.savedAddresses.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.location_off_outlined, size: 80, color: Colors.grey[300]),
                  const SizedBox(height: 16),
                  const Text('No saved addresses yet', style: TextStyle(color: Colors.grey)),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const AddressScreen())),
                    child: const Text('Add Address'),
                  ),
                ],
              ),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: provider.savedAddresses.length,
            itemBuilder: (context, index) {
              final address = provider.savedAddresses[index];
              return Card(
                elevation: 0,
                color: Colors.grey[50],
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  leading: const Icon(Icons.location_on, color: AppColors.primary),
                  title: Text(address),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete_outline, color: Colors.red),
                    onPressed: () => provider.removeAddress(index),
                  ),
                  onTap: () {
                    provider.selectAddress(address);
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Delivery address updated')));
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const AddressScreen())),
        child: const Icon(Icons.add),
      ),
    );
  }
}
