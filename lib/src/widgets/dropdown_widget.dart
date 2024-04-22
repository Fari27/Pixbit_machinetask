import 'package:flutter/material.dart';
import 'package:sample/src/util/app_colors.dart';
import 'package:sample/src/util/app_sizes.dart';

class DropDownItems {
  String? title;
  num? titleId;

  DropDownItems({this.title, this.titleId});
}

class DropDownWidget extends StatefulWidget {
  final List<DropDownItems> dropDownItems;
  final int initialIndex;
  final double? width;
  final double? height;
  final Function(DropDownItems?) onDropDownValueChange;
  final Function(DropDownItems?)? initialDropDownValue;

  const DropDownWidget(
      {super.key,
      required this.dropDownItems,
      required this.initialIndex,
      this.width,
      this.height,
      required this.onDropDownValueChange,
      this.initialDropDownValue});

  @override
  State<DropDownWidget> createState() => _NdsDropDownWidgetState();
}

class _NdsDropDownWidgetState extends State<DropDownWidget> {
  String selectedValue = '';

  @override
  void initState() {
    selectedValue = widget.dropDownItems[widget.initialIndex].title ?? "";
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.initialDropDownValue != null) {
        widget.initialDropDownValue!(widget.dropDownItems[widget.initialIndex]);
      }
    });
    super.initState();
  }

  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [];
    for (var i = 0; i < widget.dropDownItems.length; i++) {
      menuItems.add(DropdownMenuItem(
        value: widget.dropDownItems[i].title,
        child: Text(widget.dropDownItems[i].title ?? ""),
      ));
    }
    return menuItems;
  }

  @override
  Widget build(BuildContext context) {
    return _getBody();
  }

  _getBody() {
    return Container(
        width: widget.width ??
            AppWidgetSizes.screenWidth(context) - AppWidgetSizes.dimen_16,
        decoration: BoxDecoration(
            border: Border.all(
                color: Appcolors.borderColor(context).withOpacity(0.1)),
            borderRadius: BorderRadius.circular(AppWidgetSizes.dimen_6),
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: Offset(0.0, 0.75))
            ]),
        child: DropdownButtonHideUnderline(
          child: ButtonTheme(
            alignedDropdown: true,
            child: DropdownButton(
              menuMaxHeight: 400,
              isExpanded: true,
              icon: const Padding(
                padding: EdgeInsets.only(right: 8.0),
                child: Icon(Icons.expand_more_sharp),
              ),
              value: selectedValue,
              items: dropdownItems,
              onChanged: (String? newValue) {
                final index = widget.dropDownItems
                    .indexWhere((element) => element.title! == newValue);
                if (index != -1) {
                  widget.onDropDownValueChange(widget.dropDownItems[index]);
                }
                setState(() {
                  selectedValue = newValue!;
                });
              },
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ));
  }
}
