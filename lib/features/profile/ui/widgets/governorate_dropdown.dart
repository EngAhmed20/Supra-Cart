import 'package:flutter/material.dart';

class GovernorateDropdown extends StatelessWidget {
  final List<String> governorates = [
    'القاهرة',
    'الجيزة',
    'الإسكندرية',
    'الدقهلية',
    'الشرقية',
    'الغربية',
    'المنوفية',
    'المنيا',
    'أسيوط',
    'سوهاج',
    'قنا',
    'الأقصر',
    'أسوان',
    'البحيرة',
    'كفر الشيخ',
    'دمياط',
    'بورسعيد',
    'الإسماعيلية',
    'السويس',
    'شمال سيناء',
    'جنوب سيناء',
    'مطروح',
    'البحر الأحمر',
    'الوادي الجديد'
  ];



   GovernorateDropdown({
    super.key,
    required this.selectedGovernorate,
    required this.onChanged,required this.validator,
  });
  final String? selectedGovernorate;
  final Function(String?) onChanged;
  final String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: selectedGovernorate,
      decoration: const InputDecoration(
        labelText: 'Governorate',
        border: OutlineInputBorder(),
      ),
      items: governorates.map((String gov) {
        return DropdownMenuItem<String>(
          value: gov,
          child: Text(gov),
        );
      }).toList(),
      onChanged: onChanged,
      validator: validator,
    );
  }
}
