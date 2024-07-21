import 'package:crossword_admin/core/constant/alphabet.dart';
import 'package:crossword_admin/presentation/widgets/custom_dropdown.dart';
import 'package:flutter/material.dart';

class AlphabetDropdown extends StatelessWidget {
  const AlphabetDropdown({
    super.key,
    required this.valueNotifier,
  });

  final ValueNotifier<String?> valueNotifier;

  @override
  Widget build(BuildContext context) {
    return CustomDropdown(
      list: Alphabet.aze,
      valueNotifier: valueNotifier,
      hint: 'Seçin',
    );
  }
}
