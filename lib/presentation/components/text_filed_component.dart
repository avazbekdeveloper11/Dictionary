import 'package:dictionary/presentation/styles/app_colors.dart';
import 'package:dictionary/presentation/styles/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class TextFieldComponent extends StatefulWidget {
  final String? initialValue;
  final String hint;
  final String? helpText;
  final String? errorText;
  final bool showSuffixIcon;
  final bool isObscure;
  final String suffixIconPath;
  final TextInputType? inputType;
  final bool checkPassword;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String> onChanged;
  final TextInputAction? textInputAction;
  final VoidCallback? textInputActionOnTap;
  final VoidCallback? onTap;
  final TextEditingController? textEditingController;
  final int? maxLength;
  final int? maxLines;
  final int? minLines;
  final bool isUpperLetter;
  final String? suffixText;
  final List<TextInputFormatter>? inputFormatters;

  const TextFieldComponent({
    Key? key,
    required this.hint,
    required this.onChanged,
    this.initialValue,
    this.helpText,
    this.errorText,
    this.textInputAction,
    this.textInputActionOnTap,
    this.validator,
    this.showSuffixIcon = false,
    this.isObscure = false,
    this.suffixIconPath = '',
    this.inputType,
    this.onTap,
    this.checkPassword = false,
    this.textEditingController,
    this.maxLength,
    this.maxLines,
    this.minLines,
    this.isUpperLetter = false,
    this.suffixText,
    this.inputFormatters,
  }) : super(key: key);

  @override
  State<TextFieldComponent> createState() => _TextFieldComponentState();
}

class _TextFieldComponentState extends State<TextFieldComponent> {
  bool _isShowing = false;

  OutlineInputBorder _border() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(20.r),
      borderSide: BorderSide(
        color: widget.checkPassword
            ? AppColors.disabledColor
            : AppColors.primaryColor,
      ),
    );
  }

  @override
  void initState() {
    _isShowing = widget.isObscure;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: TextFormField(
        autofocus: true,
        inputFormatters: widget.inputFormatters,
        textCapitalization: widget.isUpperLetter
            ? TextCapitalization.sentences
            : TextCapitalization.none,
        maxLines: widget.maxLines ?? 1,
        minLines: widget.minLines ?? 1,
        initialValue: widget.initialValue,
        controller: widget.textEditingController,
        keyboardType: widget.inputType,
        obscureText: _isShowing,
        validator: widget.validator,
        textInputAction: widget.textInputAction,
        onTap: widget.onTap,
        maxLength: widget.maxLength,
        readOnly: widget.onTap != null,
        style: AppTextStyles.regular.copyWith(
          fontSize: 16.sp,
          color: Colors.white,
        ),
        decoration: InputDecoration(
          counterText: '',
          focusedBorder: InputBorder.none,
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.r),
            borderSide: const BorderSide(color: AppColors.red),
          ),
          enabledBorder: _border(),
          border: _border(),
          helperText: widget.helpText,
          helperStyle: AppTextStyles.regular.copyWith(
            fontSize: 12.sp,
            color: Colors.blue,
          ),
          errorText: widget.errorText,
          errorStyle: AppTextStyles.regular.copyWith(
            fontSize: 12.sp,
            color: Colors.red,
          ),
          hintText: widget.hint,
          hintStyle: AppTextStyles.regular.copyWith(
            fontSize: 16.sp,
            color: widget.checkPassword
                ? AppColors.disabledColor
                : AppColors.white,
          ),
          labelText: widget.suffixText,
          suffixIcon: Visibility(
            visible: widget.showSuffixIcon,
            child: widget.isObscure ? _passwordIcon() : _otherSuffixIcon(),
          ),
          suffixIconConstraints: BoxConstraints(
            maxHeight: 40.h,
            maxWidth: 40.w,
          ),
        ),
        onChanged: (value) => widget.onChanged(value),
        onFieldSubmitted: (term) {
          if (widget.textInputActionOnTap != null) {
            widget.textInputActionOnTap!();
          }
        },
      ),
    );
  }

  Widget _passwordIcon() {
    return GestureDetector(
      onTap: () => setState(() => _isShowing = !_isShowing),
      child: Padding(
        padding: EdgeInsets.only(right: 12.w, left: 4.w),
        child: Icon(
          !_isShowing ? Icons.visibility : Icons.visibility_off,
          color: widget.checkPassword
              ? AppColors.disabledColor
              : AppColors.primaryColor,
        ),
      ),
    );
  }

  Widget _otherSuffixIcon() {
    return Padding(
      padding: EdgeInsets.only(right: 14.w, left: 4.w),
      child: SvgPicture.asset(widget.suffixIconPath),
    );
  }
}
