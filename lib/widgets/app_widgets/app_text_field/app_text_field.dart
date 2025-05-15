import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:megaplug/config/clients/storage/storage_client.dart';
import 'package:megaplug/config/constants.dart';
import 'package:megaplug/config/extension/space_extension.dart';
import 'package:megaplug/config/helpers/time_debuncer.dart';
import 'package:megaplug/config/res.dart';
import 'package:megaplug/config/theme/color_extension.dart';
import 'package:vibration/vibration.dart';

import '../app_text.dart';
import 'auth_form_rules.dart';
import 'custom_shake_widget.dart';

enum AppFieldType {
  text,
  name,
  email,
  password,
  confirmPassword,
  phone,
}

class AppTextFormField extends StatefulWidget {
  final String? hintText;
  final String? text;
  final String? validateEmptyText;
  final TextEditingController controller;

  final TextInputType? keyboardType;
  final int? maxLines;
  final int? maxLength;
  final String? labelText;
  final String? suffixText;
  final bool required;
  final IconData? suffixIcon;
  final String? prefixIcon;
  final Color? suffixIconColor;
  final bool enabled;
  final List<String>? autoFillHints;
  final double? radius;
  final Function(String value)? onChanged;
  final VoidCallback? onEditingComplete;
  final Function(String value)? onFieldSubmitted;
  final TextInputAction? textInputAction;
  final AppFieldType appFieldType;
  final bool checkRules;
  final bool alwaysShowRules;

  final List<AuthFormRule>? rules;

  const AppTextFormField({
    super.key,
    required this.controller,
    this.keyboardType,
    this.hintText,
    this.text,
    this.validateEmptyText,
    this.maxLines,
    this.maxLength,
    this.labelText,
    this.suffixText,
    this.enabled = true,
    this.onChanged,
    this.onFieldSubmitted,
    this.onEditingComplete,
    this.autoFillHints,
    this.suffixIcon,
    this.prefixIcon,
    this.radius = 8,
    this.suffixIconColor,
    this.textInputAction,
    this.appFieldType = AppFieldType.text,
    this.checkRules = true,
    this.required = true,
    this.alwaysShowRules = false,
    this.rules,
  });

  @override
  AppTextFormFieldState createState() => AppTextFormFieldState();
}

class AppTextFormFieldState extends State<AppTextFormField> {
  bool _isSecure = false;
  bool _isPasswordField = false;
  String? _apiErrorText;
  final GlobalKey<CustomShakeWidgetState> _shakerKey = GlobalKey();
  final FocusNode _focusNode = FocusNode();
  bool hasError = false;
  Widget validationView = const SizedBox();
  final String _emptyValidationText =
      StorageClient().isAr() ? 'هذا الحقل مطلوب' : 'This field is Required';

  AppTimeDebuncer debuncer = AppTimeDebuncer.instance;


  @override
  void initState() {
    super.initState();
    _isPasswordField = AppFieldType.password == widget.appFieldType ||
        AppFieldType.confirmPassword == widget.appFieldType;
    _isSecure = _isPasswordField;
  }

  @override
  void dispose() {
    super.dispose();
    debuncer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    final borderColor =
        hasError ? Color.fromRGBO(229, 57, 53, 1) : Color(0xffE2E8F0);
    final Color fillErrorColor = Color.fromRGBO(255, 0, 0, 0.06);
    return CustomShakeWidget(
      key: _shakerKey,
      shakeCount: 4,
      shakeOffset: 10,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            focusNode: _focusNode,
            obscureText: _isSecure,
            style: TextStyle(
              fontSize: 14,
              color: Color(0xff6C7E8E),
              fontWeight: FontWeight.w400,
            ),
            controller: widget.controller,
            keyboardType: widget.keyboardType ?? TextInputType.text,
            onChanged: (String? value) {
              clearApiError();
              debuncer.debounce(
                Duration(milliseconds: 1000),
                () => _validateRules(),
              );
              if (widget.onChanged != null && value != null) {
                widget.onChanged!(value);
              }
            },
            textInputAction: widget.textInputAction,
            onFieldSubmitted: (String? value) {
              if (widget.onFieldSubmitted != null && value != null) {
                widget.onFieldSubmitted!(value);
              }

              validate(withFocus: false);
            },
            autofillHints: widget.autoFillHints,
            onEditingComplete: widget.onEditingComplete,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            textAlignVertical: TextAlignVertical.center,
            textAlign: TextAlign.start,
            maxLines: _isPasswordField ? 1 : widget.maxLines,
            maxLength: widget.maxLength,
            cursorColor: context.kPrimaryColor,
            cursorWidth: 2,
            decoration: InputDecoration(
              helper: (_apiErrorText?.isEmpty ?? true)
                  ? null
                  : Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            Res.errorIcon,
                            width: 15,
                            height: 15,
                          ),
                          10.pw,
                          Flexible(
                            child: Text(
                              _apiErrorText ?? '',
                              style: TextStyle(
                                color: context.kErrorColor,
                                fontSize: 12,
                              ),
                              maxLines: 2,
                            ),
                          ),
                        ],
                      ),
                    ),
              helperMaxLines: 4,
              helperStyle: TextStyle(
                color: context.kErrorColor,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
              labelText: widget.labelText,
              labelStyle: TextStyle(
                color: context.kTextColor,
                fontFamily: StorageClient().isAr()
                    ? Constants.arFontFamily
                    : Constants.fontFamily,
                fontSize: 18,
              ),
              hintText: widget.hintText ?? '',
              fillColor: hasError ? fillErrorColor : context.kBackgroundColor,
              filled: true,
              hintStyle: TextStyle(
                fontSize: 11,
                color: context.kHintTextColor,
                fontFamily: StorageClient().isAr()
                    ? Constants.arFontFamily
                    : Constants.fontFamily,
                fontWeight: FontWeight.w400,
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 12,
              ),
              alignLabelWithHint: true,
              prefixIcon: widget.prefixIcon != null
                  ? Padding(
                      padding: const EdgeInsetsDirectional.only(
                        start: 15.0,
                        end: 8,
                        top: 15,
                        bottom: 15,
                      ),
                      child: SvgPicture.asset(
                        widget.prefixIcon!,
                        fit: BoxFit.fitHeight,
                        height: 20,
                        width: 20,
                        colorFilter: ColorFilter.mode(
                          context.kHintTextColor,
                          BlendMode.srcIn,
                        ),
                      ),
                    )
                  : null,
              suffixText: widget.suffixText ?? '',
              suffixStyle: TextStyle(
                color: context.kHintTextColor,
              ),
              suffixIcon: widget.suffixIcon != null || _isPasswordField
                  ? GestureDetector(
                      onTap: _isPasswordField ? _toggle : null,
                      child: Icon(
                        _isPasswordField
                            ? _isSecure
                                ? Icons.visibility_off
                                : Icons.remove_red_eye
                            : widget.suffixIcon,
                        size: 20,
                        color: context.kHintTextColor,
                      ),
                    )
                  : null,
              enabled: widget.enabled,
              errorStyle: TextStyle(
                fontStyle: FontStyle.normal,
                fontSize: 12,
                fontWeight: FontWeight.normal,
                color: context.kErrorColor,
                fontFamily: StorageClient().isAr()
                    ? Constants.arFontFamily
                    : Constants.fontFamily,
              ),
              disabledBorder: const OutlineInputBorder(
                borderSide: BorderSide.none,
              ),
              enabledBorder: !widget.enabled
                  ? const OutlineInputBorder(borderSide: BorderSide.none)
                  : OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        widget.radius ?? kRadius,
                      ),
                      borderSide: BorderSide(
                        width: kBorderWidth,
                        color: borderColor,
                      ),
                    ),
              border: !widget.enabled
                  ? const OutlineInputBorder(borderSide: BorderSide.none)
                  : OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        widget.radius ?? kRadius,
                      ),
                      borderSide: BorderSide(
                        width: kBorderWidth,
                        color: borderColor,
                      ),
                    ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  widget.radius ?? kRadius,
                ),
                borderSide: BorderSide(
                  width: kSelectedBorderWidth,
                  color: context.kErrorColor,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  widget.radius ?? kRadius,
                ),
                borderSide: BorderSide(
                  width: kSelectedBorderWidth,
                  color: hasError ? context.kErrorColor : context.kPrimaryColor,
                ),
              ),
            ),
          ),
          validationView,
        ],
      ),
    );
  }

  bool validate({bool withFocus = true}) {
    bool validated = _validateRules();
    if (validated) {
      shake(withFocus: withFocus);
      return false;
    } else {
      return true;
    }
  }

  void _toggle() {
    setState(() {
      _isSecure = !_isSecure;
    });
  }

  void addApiError(String text) {
    setState(() {
      _apiErrorText = text;
      hasError = true;
    });
  }

  void clearApiError() {
    setState(() {
      _apiErrorText = null;
      hasError = false;
    });
  }

  Future shake({bool withFocus = true}) async {
    _shakerKey.currentState?.shake();
    if (withFocus) {
      _focusNode.requestFocus();
    }
    if ((await Vibration.hasVibrator())) {
      Vibration.vibrate();
    }
  }

  bool _validateRules() {
    if (!widget.required) {
      return false;
    }
    List<Widget> errors = [];
    List<Widget> passedRules = [];

    String input = widget.controller.text;
    if (input.isEmpty) {
      errors.add(
        singleError(
          (widget.validateEmptyText ?? _emptyValidationText),
        ),
      );
    } else if (widget.rules != null) {
      for (var element in widget.rules!) {
        bool passed = element.condition(input);

        if (!passed) {
          //condition failed
          errors.add(singleError(element.ruleText));
        } else {
          //condition passed
          passedRules.add(singleError(element.ruleText, isError: false));
        }
      }
    }

    hasError = errors.isNotEmpty;

    validationView = Padding(
      padding: const EdgeInsetsDirectional.only(start: 8, top: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...errors,
          if (widget.alwaysShowRules) ...passedRules,
        ],
      ),
    );

    setState(() {});

    return hasError;
  }

  Widget singleError(String text, {bool isError = true}) => text.isEmpty
      ? SizedBox()
      : Row(
          children: [
            Icon(
              !isError ? Icons.done : Icons.clear,
              color: !isError ? context.kSuccessColor : context.kErrorColor,
              size: 15,
            ),
            5.pw,
            Expanded(
              child: AppText(
                text: text,
                color: !isError ? context.kSuccessColor : context.kErrorColor,
                fontSize: 12,
                fontWeight: FontWeight.normal,
                maxLines: 2,
              ),
            ),
          ],
        );
}
