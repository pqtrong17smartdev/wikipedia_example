import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFieldCustomized extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final TextStyle hintStyle;
  final TextStyle textStyle;
  final TextInputAction textInputAction;
  final TextInputType textInputType;
  final String errorText;
  final ValueChanged<String> onChanged;
  final int maxLength;
  final FocusNode focusNode;
  final Widget suffixIcon;
  final String labelText;
  final TextStyle styleLabelText;
  final TextStyle styleError;
  final List<TextInputFormatter> inputFormatter;
  final bool isEnable;
  final bool isDisableUnderlineEnable;
  final bool isDisableUnderlineFocus;
  final bool isDisableUnderlineDisable;
  final bool isDisableUnderlineError;
  final InputBorder borderSideEnable;
  final InputBorder borderSideDisable;
  final InputBorder borderSideFocus;
  final InputBorder borderSideError;
  final bool isHideText;
  final bool Function() onValidator;
  final int maxLines;

  TextFieldCustomized(this.controller,
      {this.hintText,
      this.hintStyle,
      this.textStyle,
      this.textInputAction,
      this.textInputType,
      this.errorText,
      this.onChanged,
      this.maxLength,
      this.focusNode,
      this.suffixIcon,
      this.labelText,
      this.styleLabelText,
      this.inputFormatter,
      this.isEnable,
      this.borderSideDisable,
      this.borderSideFocus,
      this.borderSideEnable,
      this.borderSideError,
      this.isHideText,
      this.onValidator,
      this.isDisableUnderlineEnable,
      this.isDisableUnderlineDisable,
      this.isDisableUnderlineError,
      this.isDisableUnderlineFocus,
        this.maxLines,
      this.styleError});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _TextFieldCustomizedState();
  }
}

class _TextFieldCustomizedState extends State<TextFieldCustomized> {
  bool _isValid;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return TextField(
      focusNode: widget.focusNode,
      maxLength: widget.maxLength ?? null,
      obscureText: widget.isHideText ?? false,
      obscuringCharacter: '*',
      controller: widget.controller,
      style: widget.textStyle,
      textAlignVertical: TextAlignVertical.bottom,
      textInputAction: widget.textInputAction ?? null,
      onChanged: (value) {
        if (widget.onChanged != null) {
          widget.onChanged(value);
        }
        setState(() {
          _isValid = widget.onValidator();
        });
      },
      keyboardType: widget.textInputType ?? null,
      enabled: widget.isEnable ?? true,
      inputFormatters: widget.inputFormatter ?? null,
      decoration: InputDecoration(
          labelText: widget.labelText ?? null,
          labelStyle: widget.styleLabelText ?? null,
          suffixIcon: widget.suffixIcon ?? null,
          counterText: '',
          hintText: widget.hintText ?? null,
          hintStyle: widget.hintStyle,
          contentPadding: EdgeInsets.only(bottom: 0),
          isDense: true,
          errorText: _isValid == null
              ? null
              : _isValid
                  ? null
                  : widget.errorText ?? 'Error',
          errorStyle: widget.styleError,
          errorBorder:
              widget.isDisableUnderlineError != null && widget.isDisableUnderlineError
                  ? InputBorder.none
                  : widget.borderSideError ?? null,
          focusedBorder:
              widget.isDisableUnderlineFocus != null && widget.isDisableUnderlineFocus
                  ? InputBorder.none
                  : widget.borderSideFocus ?? null,
          disabledBorder:
              widget.isDisableUnderlineDisable != null && widget.isDisableUnderlineDisable
                  ? InputBorder.none
                  : widget.borderSideFocus ?? null,
          enabledBorder:
              widget.isDisableUnderlineEnable != null && widget.isDisableUnderlineEnable
                  ? InputBorder.none
                  : widget.borderSideFocus ?? null,),
      maxLines: widget.maxLines,
    );
  }
}
