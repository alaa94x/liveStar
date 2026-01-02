import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

/// Enhanced text field component with improved styling and animations
class EnhancedTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String? labelText;
  final String? hintText;
  final String? helperText;
  final String? errorText;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onTap;
  final bool enabled;
  final int? maxLines;
  final int? maxLength;
  final bool autofocus;
  final FocusNode? focusNode;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final Color? focusBorderColor;

  const EnhancedTextField({
    super.key,
    this.controller,
    this.labelText,
    this.hintText,
    this.helperText,
    this.errorText,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.keyboardType,
    this.textInputAction,
    this.onChanged,
    this.onTap,
    this.enabled = true,
    this.maxLines = 1,
    this.maxLength,
    this.autofocus = false,
    this.focusNode,
    this.inputFormatters,
    this.validator,
    this.focusBorderColor,
  });

  @override
  State<EnhancedTextField> createState() => _EnhancedTextFieldState();
}

class _EnhancedTextFieldState extends State<EnhancedTextField> {
  late FocusNode _focusNode;
  bool _isFocused = false;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(_onFocusChange);
    _hasError = widget.errorText != null;
  }

  @override
  void didUpdateWidget(EnhancedTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.errorText != oldWidget.errorText) {
      _hasError = widget.errorText != null;
    }
  }

  void _onFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
  }

  @override
  void dispose() {
    if (widget.focusNode == null) {
      _focusNode.dispose();
    } else {
      _focusNode.removeListener(_onFocusChange);
    }
    super.dispose();
  }

  Color _getBorderColor() {
    if (_hasError) return AppColors.destructive;
    if (_isFocused) return widget.focusBorderColor ?? AppColors.primaryPurple;
    return Colors.white.withValues(alpha: 0.1);
  }

  Color _getBackgroundColor() {
    if (!widget.enabled) return AppColors.inputBackground.withValues(alpha: 0.5);
    if (_isFocused) return AppColors.inputBackground.withValues(alpha: 0.9);
    return AppColors.inputBackground;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.labelText != null) ...[
          Text(
            widget.labelText!,
            style: AppTextStyles.inputLabel,
          ),
          const SizedBox(height: 8),
        ],
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          decoration: BoxDecoration(
            color: _getBackgroundColor(),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: _getBorderColor(),
              width: _isFocused ? 2.0 : 1.0,
            ),
            boxShadow: _isFocused
                ? [
                    BoxShadow(
                      color: (widget.focusBorderColor ?? AppColors.primaryPurple)
                          .withValues(alpha: 0.2),
                      blurRadius: 8,
                      spreadRadius: 0,
                      offset: const Offset(0, 0),
                    ),
                  ]
                : null,
          ),
          child: TextFormField(
            controller: widget.controller,
            focusNode: _focusNode,
            obscureText: widget.obscureText,
            keyboardType: widget.keyboardType,
            textInputAction: widget.textInputAction,
            onChanged: (value) {
              widget.onChanged?.call(value);
              if (widget.validator != null) {
                setState(() {
                  _hasError = widget.validator!(value) != null;
                });
              }
            },
            onTap: widget.onTap,
            enabled: widget.enabled,
            maxLines: widget.maxLines,
            maxLength: widget.maxLength,
            autofocus: widget.autofocus,
            inputFormatters: widget.inputFormatters,
            validator: widget.validator,
            style: AppTextStyles.inputText,
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: AppTextStyles.inputHint,
              prefixIcon: widget.prefixIcon != null
                  ? Icon(
                      widget.prefixIcon,
                      color: _isFocused
                          ? (widget.focusBorderColor ?? AppColors.primaryPurple)
                          : AppColors.textTertiary,
                      size: 20,
                    )
                  : null,
              suffixIcon: widget.suffixIcon,
              filled: true,
              fillColor: Colors.transparent,
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                horizontal: widget.prefixIcon != null ? 12 : 16,
                vertical: 16,
              ),
              counterText: '',
            ),
          ),
        ),
        if (widget.helperText != null && !_hasError) ...[
          const SizedBox(height: 4),
          Text(
            widget.helperText!,
            style: AppTextStyles.caption.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
        if (widget.errorText != null || _hasError) ...[
          const SizedBox(height: 4),
          AnimatedOpacity(
            opacity: _hasError ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 200),
            child: Row(
              children: [
                Icon(
                  Icons.error_outline,
                  size: 14,
                  color: AppColors.destructive,
                ),
                const SizedBox(width: 4),
                Text(
                  widget.errorText ?? 'Please fix this field',
                  style: AppTextStyles.inputError,
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}

