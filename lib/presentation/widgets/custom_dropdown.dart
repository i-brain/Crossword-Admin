import 'package:flutter/material.dart';

class CustomDropdown extends StatelessWidget {
  const CustomDropdown({
    super.key,
    required this.list,
    required this.valueNotifier,
    this.onTap,
    this.hint,
  });

  final List<String> list;
  final void Function(String)? onTap;
  final ValueNotifier<String?> valueNotifier;
  final String? hint;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: valueNotifier,
      builder: (context, _, __) => DropdownButtonFormField<String>(
        borderRadius: BorderRadius.circular(34),
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(34),
          ),
          contentPadding: EdgeInsets.zero,
        ),
        isExpanded: true,
        hint: hint != null
            ? Container(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                alignment: Alignment.centerLeft,
                child: FittedBox(
                  child: Text(
                    hint!,
                    // style: AppTextStyles.styleW600.copyWith(
                    //   fontSize: 16.sp,
                    //   color: Colors.black87,
                    // ),
                  ),
                ),
              )
            : null,
        icon: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Icon(
            Icons.arrow_drop_down_sharp,
            // color: AppColors.darkBlue,
            size: 32,
          ),
        ),
        items: list.toSet().map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Container(
              padding: const EdgeInsets.only(left: 18),
              alignment: Alignment.centerLeft,
              child: FittedBox(
                child: Text(
                  value,
                  // style: AppTextStyles.styleW500.copyWith(
                  //   fontSize: 14.sp,
                  //   color: AppColors.darkBlue,
                  // ),
                ),
              ),
            ),
            onTap: () => _onTap(value),
          );
        }).toList(),
        value: (() {
          assignFirstValue();
          return valueNotifier.value;
        }()),
        onChanged: (_) {},
      ),
    );
  }

  void _onTap(String value) {
    if (onTap != null) {
      onTap!(value);
    }

    valueNotifier.value = value;
  }

  void assignFirstValue() {
    if (list.contains(valueNotifier.value) == false && hint == null) {
      valueNotifier.value = list.first;
    }
  }
}
