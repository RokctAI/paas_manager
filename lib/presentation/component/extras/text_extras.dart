import 'package:flutter/material.dart';

import '../list_items/text_extras_item.dart';
import 'package:venderfoodyman/infrastructure/models/models.dart';

class TextExtras extends StatelessWidget {
  final int groupIndex;
  final List<UiExtra> uiExtras;
  final Function(UiExtra) onUpdate;

  const TextExtras({
    super.key,
    required this.groupIndex,
    required this.uiExtras,
    required this.onUpdate,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: uiExtras.length,
      itemBuilder: (context, index) => TextExtrasItem(
        onTap: () {
          if (uiExtras[index].isSelected) {
            return;
          }
          onUpdate(uiExtras[index]);
        },
        isActive: uiExtras[index].isSelected,
        title: uiExtras[index].value,
        isLast: uiExtras.length == index + 1,
      ),
    );
  }
}
