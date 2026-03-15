import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:grocergo/presentation/providers/auth_provider.dart';
import 'package:grocergo/presentation/screens/auth/login_screen.dart';
import 'package:grocergo/presentation/widgets/custom_button.dart';
import 'package:grocergo/utils/constants/constants.dart';
import 'package:grocergo/presentation/screens/address/address_book_screen.dart';
import 'package:grocergo/presentation/screens/orders/order_history_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    final user = auth.user;

    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundColor: AppColors.primary,
              child: Icon(Icons.person, size: 50, color: Colors.white),
            ),
            const SizedBox(height: 16),
            Text(
              user?.name ?? 'Guest User',
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Text(
              user?.email ?? 'guest@example.com',
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 32),
            _buildProfileItem(Icons.location_on_outlined, 'Address Management', () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const AddressBookScreen()));
            }),
            _buildProfileItem(Icons.history, 'Order History', () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const OrderHistoryScreen()));
            }),
            _buildProfileItem(Icons.payment, 'Payment Methods', () {}),
            _buildProfileItem(Icons.notifications_outlined, 'Notifications', () {}),
            _buildProfileItem(Icons.help_outline, 'Help & Support', () {}),
            const SizedBox(height: 32),
            if (user == null)
              CustomButton(
                text: 'Sign In',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginScreen()),
                  );
                },
              )
            else
              CustomButton(
                text: 'Logout',
                color: Colors.red[50],
                textColor: Colors.red,
                onPressed: () {
                  auth.logout();
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginScreen()),
                    (route) => false,
                  );
                },
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      onTap: onTap,
      leading: Icon(icon, color: AppColors.primary),
      title: Text(title),
      trailing: const Icon(Icons.chevron_right, size: 20),
      contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 4),
    );
  }
}
