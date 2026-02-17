import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:collection/collection.dart';
import 'package:venderfoodyman/application/ai_translation/ai_translation_provider.dart';
import '../../infrastructure/models/models.dart';
import '../../infrastructure/services/services.dart';
import '../styles/style.dart';
import 'buttons/custom_button.dart';
import 'helper/modal_drag.dart';
import 'helper/modal_wrap.dart';
import 'loading/loading.dart';
import 'text_fields/underlined_text_field.dart';

class MultiTranslationInputModal extends ConsumerStatefulWidget {
  final AiTranslationModel model;
  final int? modelId;
  final String label;
  final Map<String, String> inputs;
  final ValueChanged<Map<String, String>> save;

  const MultiTranslationInputModal({
    super.key,
    required this.model,
    required this.label,
    required this.inputs,
    required this.save,
    this.modelId,
  });

  @override
  ConsumerState<MultiTranslationInputModal> createState() =>
      _MultiTranslationInputModalState();
}

class _MultiTranslationInputModalState
    extends ConsumerState<MultiTranslationInputModal> {
  final List<LanguageData> _languages = LocalStorage.getActiveLanguages();
  final LanguageData? _activeLanguage = LocalStorage.getLanguage();

  late TextEditingController _textController;
  final Map<String, String> _inputs = {};

  @override
  void initState() {
    _textController = TextEditingController();
    late LanguageData selectedLanguage;
    if (_activeLanguage == null) {
      final defaultLang = _languages.firstWhereOrNull((e) => e.active ?? false);
      if (defaultLang == null) {
        selectedLanguage = _languages[0];
      } else {
        selectedLanguage = defaultLang;
      }
    } else {
      selectedLanguage = _activeLanguage;
    }
    _inputs.addAll(widget.inputs);
    _textController.text = _inputs[selectedLanguage.locale] ?? '';
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(aiTranslationProvider.notifier).setLanguage(selectedLanguage);
    });
    super.initState();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(aiTranslationProvider);
    final notifier = ref.read(aiTranslationProvider.notifier);
    return ModalWrap(
      body: SafeArea(
        child: Padding(
          padding: REdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ModalDrag(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: UnderlinedTextField(
                      label: widget.label,
                      textController: _textController,
                      descriptionText: state.translatedUsingAi
                          ? AppHelpers.getTranslation(
                              TrKeys.thisContentTranslatedUsingAI,
                            )
                          : null,
                      onChanged: (text) {
                        _inputs[state.selectedLanguage?.locale ?? 'en'] = text
                            .trim();
                        notifier.setTranslatedUsingAi(false);
                      },
                    ),
                  ),
                  12.horizontalSpace,
                  InkWell(
                    onTap: () {
                      AppHelpers.showPopup(
                        context: context,
                        isRight: true,
                        items: LocalStorage.getActiveLanguages().map(
                          (e) => PopupMenuItem(
                            child: Text(
                              e.title ?? '-',
                              style: AppStyle.interNormal(
                                color: AppStyle.black,
                              ),
                            ),
                            onTap: () {
                              notifier.setLanguage(e);
                              _textController.text = _inputs[e.locale] ?? '';
                            },
                          ),
                        ),
                      );
                    },
                    child: Container(
                      width: 80.r,
                      margin: EdgeInsets.only(
                        bottom: state.translatedUsingAi ? 20 : 0,
                      ),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: AppStyle.borderColor),
                        ),
                      ),
                      padding: REdgeInsets.only(bottom: 4),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            state.selectedLanguage?.title ?? '',
                            style: AppStyle.interNormal(
                              color: AppStyle.black,
                              size: 14,
                            ),
                          ),
                          Icon(
                            FlutterRemix.arrow_down_s_line,
                            color: AppStyle.black,
                            size: 18.r,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: REdgeInsets.only(top: 12, bottom: 24),
                child: TextButton(
                  style: ButtonStyle(
                    overlayColor: WidgetStateProperty.resolveWith(
                      (states) => AppStyle.greyColor,
                    ),
                  ),
                  child: state.isLoading
                      ? SizedBox(width: 60.r, child: Loading())
                      : Text(
                          AppHelpers.getTranslation(TrKeys.translateWithAi),
                          style: AppStyle.interNormal(
                            textDecoration: TextDecoration.underline,
                            size: 12,
                            color: AppStyle.deepPurple,
                          ),
                        ),
                  onPressed: () {
                    if (AppConstants.baseUrl.contains('foodyman')) {
                      AppHelpers.errorSnackBar(
                        context,
                        text: "Don't using demo mode",
                      );
                      return;
                    }
                    notifier.getAiTranslation(
                      model: AiTranslationRequest(
                        model: widget.model,
                        content:
                            (_inputs[state.selectedLanguage?.locale]
                                    ?.isNotEmpty ??
                                false)
                            ? _inputs[state.selectedLanguage?.locale]
                            : _inputs[_inputs.keys.firstWhereOrNull(
                                (e) => e != state.selectedLanguage?.locale,
                              )],
                        lang: state.selectedLanguage,
                        modelId: widget.modelId,
                      ),
                      onSuccess: (text) {
                        _inputs[state.selectedLanguage?.locale ?? 'en'] =
                            text?.trim() ?? '';
                        _textController.text = text?.trim() ?? '';
                      },
                    );
                  },
                ),
              ),
              24.verticalSpace,
              CustomButton(
                title: AppHelpers.getTranslation(TrKeys.save),
                onPressed: () {
                  widget.save.call(_inputs);
                  Navigator.pop(context);
                },
              ),
              16.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }
}
