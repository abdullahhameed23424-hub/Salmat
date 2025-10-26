import 'package:flutter/material.dart';
import 'package:salamat/helper/app_sharedPreferance.dart';
import 'package:video_player/video_player.dart';


class VideoViewRadioGroup extends StatefulWidget {
  const VideoViewRadioGroup({super.key});

  @override
  State<VideoViewRadioGroup> createState() => _VideoViewRadioGroupState();
}

class _VideoViewRadioGroupState extends State<VideoViewRadioGroup> {
  VideoViewType selectedType = AppSharedPreferences.viewType == VideoViewType.platformView.name
  ? VideoViewType.platformView : VideoViewType.textureView;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'اختر طريقة العرض:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            // مجموعة الخيارات (Radio Group)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildOption(VideoViewType.textureView, 'أساسي', Icons.fullscreen),
                _buildOption(VideoViewType.platformView, 'بديل', Icons.video_label),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOption(VideoViewType type, String label, IconData icon) {
    final isSelected = selectedType == type;

    return GestureDetector(
      onTap: () => setState(() => selectedType = type),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue.shade50 : Colors.grey.shade100,
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.grey.shade400,
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.blue : Colors.grey,
              size: 28,
            ),
            const SizedBox(height: 6),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Radio<VideoViewType>(
                  value: type,
                  groupValue: selectedType,
                  onChanged: (value) {
                    setState(() => selectedType = value!);
                  },
                  activeColor: Colors.blue,
                ),
                Text(
                  label,
                  style: TextStyle(
                    color: isSelected ? Colors.blue.shade700 : Colors.black87,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
