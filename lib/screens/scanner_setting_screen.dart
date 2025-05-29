import 'package:flutter/material.dart';

class ScannerSettingsScreen extends StatefulWidget {
  const ScannerSettingsScreen({super.key});

  @override
  State<ScannerSettingsScreen> createState() => _ScannerSettingsScreenState();
}

class _ScannerSettingsScreenState extends State<ScannerSettingsScreen> {
  // Scanner settings
  bool _autoFocus = true;
  bool _vibrationFeedback = true;
  bool _beepSound = false;
  bool _autoDetect = true;
  bool _invertColors = false;
  double _zoomLevel = 0.0;
  String _selectedDecoder = 'Auto';
  String _selectedResolution = 'High';
  
  final List<String> _decoders = ['Auto', 'ZXing', 'ZBar', 'ML Kit'];
  final List<String> _resolutions = ['Low', 'Medium', 'High', 'Ultra'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('Scanner Settings', style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.blue[700],
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.blue[700],
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Configure Scanner',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Customize your scanning experience',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Settings Sections
            _buildSection(
              'Camera Settings',
              [
                _buildSwitchTile(
                  'Auto Focus',
                  'Automatically focus on codes',
                  _autoFocus,
                  (value) => setState(() => _autoFocus = value),
                  Icons.center_focus_strong_rounded,
                ),
                _buildSliderTile(
                  'Zoom Level',
                  'Adjust camera zoom',
                  _zoomLevel,
                  (value) => setState(() => _zoomLevel = value),
                  Icons.zoom_in_rounded,
                  min: 0.0,
                  max: 3.0,
                ),
                _buildDropdownTile(
                  'Camera Resolution',
                  'Select image quality',
                  _selectedResolution,
                  _resolutions,
                  (value) => setState(() => _selectedResolution = value!),
                  Icons.high_quality_rounded,
                ),
              ],
            ),

            _buildSection(
              'Scanning Behavior',
              [
                _buildSwitchTile(
                  'Auto Detect',
                  'Automatically scan when code is detected',
                  _autoDetect,
                  (value) => setState(() => _autoDetect = value),
                  Icons.qr_code_scanner_rounded,
                ),
                _buildDropdownTile(
                  'Decoder Engine',
                  'Choose scanning engine',
                  _selectedDecoder,
                  _decoders,
                  (value) => setState(() => _selectedDecoder = value!),
                  Icons.api_rounded,
                ),
                _buildSwitchTile(
                  'Invert Colors',
                  'Detect inverted codes',
                  _invertColors,
                  (value) => setState(() => _invertColors = value),
                  Icons.invert_colors_rounded,
                ),
              ],
            ),

            _buildSection(
              'Feedback',
              [
                _buildSwitchTile(
                  'Vibration',
                  'Vibrate on successful scan',
                  _vibrationFeedback,
                  (value) => setState(() => _vibrationFeedback = value),
                  Icons.vibration_rounded,
                ),
                _buildSwitchTile(
                  'Sound',
                  'Play sound on successful scan',
                  _beepSound,
                  (value) => setState(() => _beepSound = value),
                  Icons.volume_up_rounded,
                ),
              ],
            ),

            _buildSection(
              'About',
              [
                _buildInfoTile(
                  'Version',
                  '2.0.1',
                  Icons.info_outline_rounded,
                ),
                _buildInfoTile(
                  'Scanner Engine',
                  'Advanced Multi-format Scanner',
                  Icons.qr_code_2_rounded,
                ),
                _buildActionTile(
                  'Reset to Defaults',
                  'Restore default settings',
                  Icons.restore_rounded,
                  Colors.orange,
                  () => _showResetDialog(),
                ),
              ],
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(children: children),
          ),
        ],
      ),
    );
  }

  Widget _buildSwitchTile(
    String title,
    String subtitle,
    bool value,
    ValueChanged<bool> onChanged,
    IconData icon,
  ) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.blue[50],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: Colors.blue[700], size: 24),
      ),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeColor: Colors.blue[700],
      ),
    );
  }

  Widget _buildSliderTile(
    String title,
    String subtitle,
    double value,
    ValueChanged<double> onChanged,
    IconData icon, {
    double min = 0.0,
    double max = 1.0,
  }) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.blue[50],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: Colors.blue[700], size: 24),
      ),
      title: Text(title),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(subtitle),
          Slider(
            value: value,
            onChanged: onChanged,
            min: min,
            max: max,
            activeColor: Colors.blue[700],
            divisions: 10,
            label: value.toStringAsFixed(1),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownTile(
    String title,
    String subtitle,
    String value,
    List<String> items,
    ValueChanged<String?> onChanged,
    IconData icon,
  ) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.blue[50],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: Colors.blue[700], size: 24),
      ),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: DropdownButton<String>(
        value: value,
        onChanged: onChanged,
        items: items.map((String item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(item),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildInfoTile(
    String title,
    String value,
    IconData icon,
  ) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.blue[50],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: Colors.blue[700], size: 24),
      ),
      title: Text(title),
      trailing: Text(
        value,
        style: TextStyle(
          color: Colors.grey[600],
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildActionTile(
    String title,
    String subtitle,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: color, size: 24),
      ),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: Icon(Icons.chevron_right, color: Colors.grey[400]),
      onTap: onTap,
    );
  }

  void _showResetDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: const Text('Reset Settings'),
        content: const Text(
          'Are you sure you want to reset all scanner settings to their default values?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              _resetToDefaults();
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Settings reset to defaults'),
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text('Reset'),
          ),
        ],
      ),
    );
  }

  void _resetToDefaults() {
    setState(() {
      _autoFocus = true;
      _vibrationFeedback = true;
      _beepSound = false;
      _autoDetect = true;
      _invertColors = false;
      _zoomLevel = 0.0;
      _selectedDecoder = 'Auto';
      _selectedResolution = 'High';
    });
  }
}