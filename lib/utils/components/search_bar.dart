import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constant.dart';

class CustomSearchBar extends StatefulWidget {
  final Function? onChange;
  final String? title;
  final bool? isBottom;

  // final bool? hasButton;

  const CustomSearchBar(
      {super.key,
      this.onChange,
      // this.hasButton = false,
      this.title = "Search",
      this.isBottom = false});

  @override
  _CustomSearchBarState createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  final TextEditingController controller = TextEditingController();
  final FocusNode focusNode = FocusNode();

  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    focusNode.addListener(() {
      setState(() {
        if (focusNode.hasFocus) {
          _isFocused = true;
        } else {
          _isFocused = false;
        }
      });
    });
  }

  @override
  void dispose() {
    controller.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoSearchTextField(
      onChanged: (value) {
        widget.onChange!(value);
      },
      focusNode: focusNode,
      controller: controller,
      suffixIcon: Icon(
        Icons.cancel,
        size: _isFocused ? 20 : 0,
      ),
      onSuffixTap: () {
        controller.text = "";
        widget.onChange!("");
        FocusScope.of(context).unfocus();
        setState(() {
          _isFocused = false;
        });
      },
      placeholder: "Search apps in store",
      placeholderStyle: const TextStyle(
          fontSize: 14, color: Colors.grey, fontFamily: "SegoeUI"),
    );

    //   TextField(
    //   controller: controller,
    //   focusNode: focusNode,
    //   keyboardType: TextInputType.text,
    //   onChanged: (value) {
    //     widget.hasButton! ? () {} : widget.onChange!(value);
    //   },
    //   // style: TextStyle(
    //   //     fontSize: 12, color: context.isDarkMode() ? dkTxt : ltTxt),
    //   decoration: InputDecoration(
    //     filled: true,
    //     fillColor:  Colors.grey[200],
    //     prefixIcon: const Icon(
    //       Icons.search,
    //       color: kBaseColor,
    //       size: 25,
    //     ),
    //     suffixIconConstraints:
    //     BoxConstraints.tight(Size(widget.hasButton! ? 80 : 45, 30)),
    //     suffixIcon: _isFocused
    //         ? Row(children: [
    //       InkWell(
    //         onTap: () {
    //           controller.text = "";
    //           widget.onChange!("");
    //           FocusScope.of(context).unfocus();
    //           setState(() {
    //             _isFocused = false;
    //           });
    //         },
    //         child: const Icon(
    //           Icons.close,
    //           size: 20,
    //         ),
    //       ),
    //      ]) : const SizedBox(),
    //     isDense: true,
    //     hintText: widget.title,
    //     hintStyle: const TextStyle(fontSize: 14),
    //     contentPadding:
    //     const EdgeInsets.only(top: 5, bottom: 5, left: 10),
    //     enabledBorder: OutlineInputBorder(
    //       borderRadius:  BorderRadius.circular(50),
    //       borderSide: BorderSide(
    //           color: CupertinoColors.tertiarySystemFill.withOpacity(0.2),
    //           width: 1),
    //     ),
    //     border: OutlineInputBorder(
    //       borderRadius:  BorderRadius.circular(50),
    //       borderSide:
    //       const BorderSide(width: 0, color: Colors.transparent),
    //     ),
    //   ),
    // );
  }
}
