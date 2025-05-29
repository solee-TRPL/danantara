import 'package:flutter/material.dart';

class FeatureButtons extends StatelessWidget {
  final List<Map<String, dynamic>> _features = [
    {'icon': Icons.phone_android, 'label': 'Pulsa'},
    {'icon': Icons.electric_bolt, 'label': 'Listrik'},
    {'icon': Icons.water_drop, 'label': 'PDAM'},
    {'icon': Icons.wifi, 'label': 'Internet'},
    {'icon': Icons.live_tv, 'label': 'TV Kabel'},
    {'icon': Icons.bolt, 'label': 'Token'},
    {'icon': Icons.credit_card, 'label': 'Kartu Kredit'},
    {'icon': Icons.more_horiz, 'label': 'Lainnya'},
  ];

  FeatureButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Bayar & Beli',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 12),
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              childAspectRatio: 0.9,
            ),
            itemCount: _features.length,
            itemBuilder: (context, index) {
              return _buildFeatureButton(
                _features[index]['icon'],
                _features[index]['label'],
                context,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureButton(IconData icon, String label, BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        SizedBox(height: 6),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
          ),
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}