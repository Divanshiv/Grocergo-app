import 'package:flutter/material.dart';
import 'package:grocergo/data/models/order_model.dart';
import 'package:grocergo/utils/constants/constants.dart';
import 'package:intl/intl.dart';

class OrderTrackingScreen extends StatelessWidget {
  final OrderModel order;
  const OrderTrackingScreen({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Track Order')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Estimated Delivery', style: TextStyle(color: Colors.grey)),
                          const Text('25 - 35 mins', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      const Icon(Icons.delivery_dining, size: 40, color: AppColors.primary),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            const Text('Order Status', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 24),
            _buildStatusTimeline(),
            const SizedBox(height: 32),
            const Text('Order Details', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Text('ID: ${order.id}', style: const TextStyle(color: Colors.grey)),
            Text('Placed on ${DateFormat('MMM dd, yyyy - hh:mm a').format(order.orderDate)}', style: const TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusTimeline() {
    return Column(
      children: [
        _buildTimelineStep('Order Placed', 'We have received your order', true, true),
        _buildTimelineStep('Preparing', 'Our partner is preparing your order', true, false),
        _buildTimelineStep('Out for Delivery', 'Agent is on the way to your location', false, false),
        _buildTimelineStep('Delivered', 'Order reached your destination', false, false),
      ],
    );
  }

  Widget _buildTimelineStep(String title, String subtitle, bool isCompleted, bool isFirst) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: isCompleted ? AppColors.primary : Colors.grey[300],
                shape: BoxShape.circle,
              ),
              child: isCompleted ? const Icon(Icons.check, size: 12, color: Colors.white) : null,
            ),
            Container(
              width: 2,
              height: 50,
              color: title == 'Delivered' ? Colors.transparent : (isCompleted ? AppColors.primary : Colors.grey[300]),
            ),
          ],
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: TextStyle(fontWeight: FontWeight.bold, color: isCompleted ? Colors.black : Colors.grey)),
              Text(subtitle, style: TextStyle(fontSize: 12, color: isCompleted ? Colors.grey[700] : Colors.grey)),
            ],
          ),
        ),
      ],
    );
  }
}
