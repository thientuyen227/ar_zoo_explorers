import 'package:ar_zoo_explorers/app/theme/icons.dart';
import 'package:ar_zoo_explorers/features/base-model/form_builder_text_field_model.dart';
import 'package:ar_zoo_explorers/utils/widget/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class SearchBottomSheet extends StatefulWidget {
  final Function(String) onClosed;
  const SearchBottomSheet({Key? key, required this.onClosed}) : super(key: key);

  @override
  _SearchBottomSheetState createState() => _SearchBottomSheetState();
}

class _SearchBottomSheetState extends State<SearchBottomSheet> {
  final TextEditingController _searchController = TextEditingController();

  final _formKey = GlobalKey<FormBuilderState>();

  double width = 0;
  double height = 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: FormBuilder(
            key: _formKey,
            child: Container(
              padding: const EdgeInsets.all(10),
              constraints: BoxConstraints(minHeight: height),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 5.0),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(margin: const EdgeInsets.only(left: 24)),
                          Center(child: _txtSheetTitle("Tìm kiếm")),
                          backButton(),
                        ]),
                    const SizedBox(height: 10.0),
                    _searchBar(FormBuilderTextFieldModel(
                        TIT: TextInputType.text,
                        txtValue: "",
                        hint_text: "Nhập từ khóa")),
                    // SizedBox(height: height * 0.7),
                  ],
                ),
              ),
            )));
  }

  Widget _txtSheetTitle(String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
      textAlign: TextAlign.center,
    );
  }

  Widget _searchBar(FormBuilderTextFieldModel item) {
    return FormBuilderTextField(
        name: 'search',
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey.shade50,
            hintText: item.hint_text,
            suffixIcon: IconButton(
                onPressed: () async {
                  await _onSearch(
                      _formKey.currentState!.fields['search']?.value);
                },
                icon: Image.asset(AppIcons.icSearch)),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 25)),
        style: const TextStyle(fontSize: 16),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: FormBuilderValidators.compose([]));
  }

  Widget backButton() {
    return AppIconButton(
      onPressed: () => Navigator.of(context).pop(),
      icon: Container(
          margin: const EdgeInsets.only(right: 10),
          child: ColorFiltered(
              colorFilter: const ColorFilter.mode(Colors.grey, BlendMode.srcIn),
              child: Transform.scale(
                  scale: 1.3,
                  child: Image.asset(AppIcons.icX, height: 24, width: 24)))),
    );
  }

  Future<void> _onSearch(String? value) async {
    if (value != null) {
      value = value.trim();
    } else {
      value = "";
    }
    widget.onClosed(value);
    Navigator.of(context).pop();
  }

  void _setDimension() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        width = MediaQuery.of(context).size.width;
        height = MediaQuery.of(context).size.height;
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _setDimension();
  }
}
