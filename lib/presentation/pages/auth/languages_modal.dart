import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:venderfoodyman/infrastructure/models/models.dart';
import 'package:venderfoodyman/infrastructure/services/services.dart';
import 'package:venderfoodyman/application/providers.dart';
import '../../component/components.dart';

class LanguageScreen extends ConsumerStatefulWidget {
  final Function(LanguageData?)? afterUpdate;

  const LanguageScreen({super.key, required this.afterUpdate});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LanguagePageState();
}

class _LanguagePageState extends ConsumerState<LanguageScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(languagesProvider.notifier).getLanguages(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isLtr = LocalStorage.getLangLtr();
    final event = ref.read(languagesProvider.notifier);
    final state = ref.watch(languagesProvider);
    return Directionality(
      textDirection: isLtr ? TextDirection.ltr : TextDirection.rtl,
      child: KeyboardDisable(
        child: ModalWrap(
          body: SizedBox(
            child: state.isLoading
                ? const Loading()
                : SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const ModalDrag(),
                        TitleAndIcon(
                          title: AppHelpers.getTranslation(TrKeys.language),
                          titleSize: 18,
                        ),
                        24.verticalSpace,
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: state.languages.length,
                          padding: EdgeInsets.zero,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return SelectItem(
                              onTap: () => event.change(index),
                              isActive: state.index == index,
                              title: state.languages[index].title ?? '',
                            );
                          },
                        ),
                        16.verticalSpace,
                        CustomButton(
                          title: AppHelpers.getTranslation(TrKeys.save),
                          onPressed: () async {
                            await ref
                                .read(languagesProvider.notifier)
                                .makeSelectedLang(
                                  afterUpdate: widget.afterUpdate,
                                );
                            if (context.mounted) {
                              Navigator.pop(context);
                            }
                          },
                        ),
                        36.verticalSpace,
                      ],
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
