import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:sample/src/base/base_page.dart';
import 'package:sample/src/blocs/employee_bloc/employee_bloc.dart';
import 'package:sample/src/blocs/login_bloc/login_bloc.dart';
import 'package:sample/src/util/app_colors.dart';
import 'package:sample/src/util/app_enums.dart';
import 'package:sample/src/util/app_sizes.dart';
import 'package:sample/src/util/input_validator.dart';
import 'package:sample/src/widgets/button_widget.dart';
import 'package:sample/src/widgets/dropdown_widget.dart';

class AddEmployeeScreen extends StatefulWidget {
  const AddEmployeeScreen({super.key});

  @override
  State<AddEmployeeScreen> createState() => _AddEmployeeScreenState();

  
}

class _AddEmployeeScreenState extends State<AddEmployeeScreen> {
  
  
  EmployeeBloc? employeeBloc;
  File? _image;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    employeeBloc = BlocProvider.of<EmployeeBloc>(context);
    
      employeeBloc?.add(GetDesignationEvent());
    employeeBloc
        ?.add(DropdownDataEvent(dropDownSelect: DropDownItems(titleId: 348)));
    employeeBloc?.add(DropdownGenderDataEvent(
        gendeDdropDownSelect: DropDownItems(titleId: 1)));
  }

  final TextEditingController _firstNameField = TextEditingController();
  final TextEditingController _secondNameField = TextEditingController();
  final TextEditingController _mobileNumberField = TextEditingController();
  final TextEditingController _emailField = TextEditingController();
  final TextEditingController _addressField = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  DateTime? _selectedDate;
  DropDownItems? selectedCategory;
  DropDownItems? genderSelectedCategory;
  @override
  Widget build(BuildContext context) {
    return BasePage(
      body: _getBody(context),
      padding: EdgeInsets.only(
          right: AppWidgetSizes.dimen_16,
          left: AppWidgetSizes.dimen_16,
          top: AppWidgetSizes.dimen_16,
          bottom: AppWidgetSizes.dimen_16),
      menuRequired: false,
      appBarType: AppBarType.backWithTitle,
      title: 'Add an employee',
      footer: _savebutton(),
    );
  }

_getBody(BuildContext context) {
  return Column(
    children: [
      _renderimage(),
      AppWidgetSizes.verticalSpace10,
      _buildTextField('First Name', _firstNameField, onChanged: (val) {}),
      AppWidgetSizes.verticalSpace10,
      _buildTextField('Last Name', _secondNameField, onChanged: (val) {}),
      AppWidgetSizes.verticalSpace10,
      _buildTextField('Mobile Number', _mobileNumberField,
          onChanged: (val) {},
          inputFormatters: InputValidator.mobileNumberValidator()),
      AppWidgetSizes.verticalSpace10,
      _buildTextField('Enter Mail Address', _emailField,
          onChanged: (val) {},
          inputFormatters: InputValidator.userIdValidator()),
      AppWidgetSizes.verticalSpace10,
      _addressfield(),
      AppWidgetSizes.verticalSpace10,
      _dateofbirthfeld(),
      AppWidgetSizes.verticalSpace10,
      _designationfield(),
      AppWidgetSizes.verticalSpace10,
      _genderfield(),
      AppWidgetSizes.verticalSpace10,
    ],
  );
}

Widget _buildTextField(String label, TextEditingController controller,
    {required ValueChanged<String> onChanged, List<TextInputFormatter>? inputFormatters}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label,
          style: Theme.of(context).textTheme.titleSmall!.copyWith(
              fontWeight: FontWeight.w400, color: Appcolors.blackColor)),
      AppWidgetSizes.verticalSpace10,
      Container(
        height: AppWidgetSizes.dimen_50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.cyan, width: 0.5),
            color: Appcolors.textWhiteColor(context),
            boxShadow: [
              BoxShadow(
                  color: Appcolors.textColor(context).withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(0.0, 0.75))
            ]),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppWidgetSizes.dimen_16),
          child: TextField(
            onChanged: onChanged,
            inputFormatters: inputFormatters,
            cursorColor: Appcolors.blackColor,
            controller: controller,
            style: Theme.of(context).textTheme.bodyMedium,
            maxLength: 15,
            decoration: InputDecoration(
              labelStyle: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: Appcolors.textLightGrayColor(context),
                  fontSize: AppWidgetSizes.fontSize14),
              hintText: 'Enter Here',
              border: InputBorder.none,
              counterText: '',
            ),
          ),
        ),
      ),
    ],
  );
}

_addressfield() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Address',
        style: Theme.of(context).textTheme.bodySmall,
      ),
      SizedBox(
        height: AppWidgetSizes.dimen_10,
      ),
      Stack(
        alignment: Alignment.bottomRight,
        children: [
          Container(
            height: AppWidgetSizes.dimen_100,
            decoration: BoxDecoration(
              color: Appcolors.textWhiteColor(context),
              borderRadius: BorderRadius.circular(AppWidgetSizes.dimen_8),
              border: Border.all(color: Colors.cyan, width: 0.5),
            ),
            alignment: Alignment.centerLeft,
            child: SizedBox(
              child: Padding(
                padding: EdgeInsets.only(
                  left: AppWidgetSizes.dimen_16,
                ),
                child: TextFormField(
                  onChanged: (value) {},
                  enableInteractiveSelection: false,
                  enableSuggestions: false,
                  autocorrect: false,
                  autofocus: false,
                  enabled: true,
                  maxLines: 3,
                  maxLength: 50,
                  controller: _addressField,
                  textCapitalization: TextCapitalization.none,
                  textAlign: TextAlign.start,
                  textInputAction: TextInputAction.done,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Appcolors.textColor(context)),
                  decoration: InputDecoration(
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      hintText: 'Enter address',
                      hintStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: Appcolors.textLightGrayColor(context),
                            fontSize: AppWidgetSizes.fontSize14,
                          ),
                      counterText: ''),
                ),
              ),
            ),
          ),
        ],
      ),
    ],
  );
}


 
  _imgFromCamera() async {
    var image = await ImagePicker().pickImage(
        source: ImageSource.camera, imageQuality: 50
    );

    setState(() {
      if(image?.path != null){
        _image = File(image!.path);
      }
      _image = File('lib/src/assets/light_theme/default_image.jpg');
    });
  }

  _imgFromGallery() async {
    var image = await  ImagePicker().pickImage(
        source: ImageSource.gallery, imageQuality: 50
    );

    setState(() {
      if(image?.path != null){
        _image = File(image!.path);
      }
        _image = File('lib/src/assets/light_theme/default_image.jpg');
    });
  }

   void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: Wrap(
                children: <Widget>[
                   ListTile(
                      leading:  Icon(Icons.photo_library),
                      title:  Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                   ListTile(
                    leading:  Icon(Icons.photo_camera),
                    title:  Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        }
    );
  }
  

  _renderimage() {
  return  Column(
        children: <Widget>[
          const SizedBox(
            height: 32,
          ),
          Center(
            child: GestureDetector(
              onTap: () {
                _showPicker(context);
              },
              child: CircleAvatar(
                radius: 55,
                backgroundColor: Color(0xffFDCF09),
                child: _image != null
                    ? ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.file(
                    File('lib/src/assets/light_theme/default_image.jpg'),
                    width: 100,
                    height: 100,
                    fit: BoxFit.fill,
                  ),
                )
                    : Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(50)),
                  width: 100,
                  height: 100,
                  child: Icon(
                    Icons.camera_alt,
                    color: Colors.grey[800],
                  ),
                ),
              ),
            ),
          )
        ],
      );
  }
  _dateofbirthfeld() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Date of birth',
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                fontWeight: FontWeight.w400, color: Appcolors.blackColor)),
        AppWidgetSizes.verticalSpace10,
        Container(
          height: AppWidgetSizes.dimen_50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.cyan, width: 0.5),
              color: Appcolors.textWhiteColor(context),
              boxShadow: [
                BoxShadow(
                    color: Appcolors.textColor(context).withOpacity(0.1),
                    blurRadius: 4,
                    offset: const Offset(0.0, 0.75))
              ]),
          child: Padding(
            padding: EdgeInsets.only(
                left: AppWidgetSizes.dimen_16, right: AppWidgetSizes.dimen_16),
            child: TextFormField(
              controller: _dateController,
              readOnly: true,
              onTap: () => _selectDate(context),
              decoration: InputDecoration(
                hintText: 'Date of Birth',
                border: InputBorder.none,
                suffixIcon: IconButton(
                  icon: const Icon(Icons.calendar_month_rounded),
                  onPressed: () => _selectDate(context),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _dateController.text = DateFormat('yyyy-MM-dd').format(_selectedDate!);
        DateFormat('yyyy-MM-dd').format(_selectedDate!);
      });
    }
  }

  _designationfield() {
    return BlocBuilder<EmployeeBloc, EmployeeState>(
        buildWhen: (previous, current) {
      return current is GetDesignationState || current is DropdownDataState;
    }, builder: (context, state) {
      if (state is GetDesignationState && state.status.isSuccess) {
        return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Designation',
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  fontWeight: FontWeight.w400, color: Appcolors.blackColor)),
          AppWidgetSizes.verticalSpace10,
          (state.resp) != null ?
          DropDownWidget(
            initialIndex: 0,
            dropDownItems: (state.resp ?? [])
                .map((e) => DropDownItems(title: e.name, titleId: e.id))
                .toList(),
            initialDropDownValue: (category) {
              selectedCategory = category;
            },
            onDropDownValueChange: (category) {
              selectedCategory = category;
              context
                  .read<EmployeeBloc>()
                  .add(DropdownDataEvent(dropDownSelect: selectedCategory!));
            },
          ) : Container()
        ]);
      }
     return SizedBox.shrink();
    });
  }

  _genderfield() {
    return BlocBuilder<EmployeeBloc, EmployeeState>(
         buildWhen: (previous, current) {
      return  current is GenderDropdownDataState;
      },
      builder: (context, state) {
        return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Gender',
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  fontWeight: FontWeight.w400, color: Appcolors.blackColor)),
          AppWidgetSizes.verticalSpace10,
          DropDownWidget(
            initialIndex: 0,
            dropDownItems: (employeeBloc?.genderList ?? [])
                .map((e) => DropDownItems(title: e.name, titleId: e.id))
                .toList(),
            initialDropDownValue: (category) {
              genderSelectedCategory = category;
            },
            onDropDownValueChange: (category) {
              genderSelectedCategory = category;
              context.read<EmployeeBloc>().add(DropdownGenderDataEvent(
                  gendeDdropDownSelect: genderSelectedCategory!));
            },
          ),
        ]);
      },
    );
  }

  _savebutton() {
    return Wrap(children: [
      Column(
        children: [
          Padding(
            padding: EdgeInsets.all(AppWidgetSizes.dimen_16),
            child: (_firstNameField.text.isNotEmpty &&
                    _secondNameField.text.isNotEmpty &&
                    _dateController.text.isNotEmpty &&
                    _emailField.text.isNotEmpty &&
                    _mobileNumberField.text.isNotEmpty &&
                    _addressField.text.isNotEmpty)
                ? ButtonWidget(
                    text: 'Save',
                    buttonState: ElevatedButtonState.active,
                    onPressed: () {
                      var arg = {
                        "first_name": _firstNameField.text,
                        "last_name": _secondNameField.text,
                        "join_date": "10-09-2023",
                        "date_of_birth": _dateController.text,
                        "designation_id": selectedCategory?.titleId,
                        "gender": genderSelectedCategory?.title.toString(),
                        "email": _emailField.text,
                        "mobile": _mobileNumberField.text,
                        "landline": _mobileNumberField.text,
                        "present_address": _addressField.text,
                        "permanent_address": _addressField.text,
                        "status": "TEMPORERY",
                        "profile_picture":  _image ?? File('lib/src/assets/light_theme/default_image.jpg'),
                        "resume": File('lib/src/assets/light_theme/resume.pdf'),
                      };

                      context
                          .read<EmployeeBloc>()
                          .add(AddEmployeeEvent(reqParams: arg));
                    })
                : ButtonWidget(
                    text: 'Save',
                    buttonState: ElevatedButtonState.disable,
                    onPressed: () {},
                  ),
          ),
        ],
      ),
    ]);
  }
}
