import 'package:ar_zoo_explorers/app/theme/colors.dart';
import 'package:ar_zoo_explorers/app/theme/dimens.dart';
import 'package:ar_zoo_explorers/app/theme/icons.dart';
import 'package:ar_zoo_explorers/base/base_state.dart';
import 'package:ar_zoo_explorers/features/base-model/FormBuilderTextField_Model.dart';
import 'package:ar_zoo_explorers/features/home/model/advertisement_object.dart';
import 'package:ar_zoo_explorers/features/home/model/button_object.dart';
import 'package:ar_zoo_explorers/features/home/presentation/home_state.dart';
import 'package:ar_zoo_explorers/features/setting/presentation/setting_page.dart';
import 'package:ar_zoo_explorers/utils/widget/button_widget.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../../app/config/routes.dart';
import '../../../base/widgets/page_loading_indicator.dart';
import '../../../core/data/controller/auth_controller.dart';
import 'home_cubit.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State createState() => _State();
}

class _State extends BaseState<HomeState, HomeCubit, HomePage> {
  final PageController _adsController = PageController();
  final controller = AuthController.findOrInitialize;
  final _formKey = GlobalKey<FormBuilderState>();

  String urlAvatarUser = AppIcons.icDefaultUser;
  String txtSearch = "";
  int _adsCurrentPage = 0;
  List<ButtonObject> listButtonObject = [
    ButtonObject(title: "Animal", icon: AppIcons.icAnimal),
    ButtonObject(title: "Reptiles", icon: AppIcons.icCrocodile),
    ButtonObject(title: "Fish", icon: AppIcons.icFish),
    ButtonObject(title: "Bird", icon: AppIcons.icBird),
    ButtonObject(title: "Dinosaurs", icon: AppIcons.icDinosaurs)
  ];
  AdvertisementObject listAdvertisement =
      AdvertisementObject([AppImages.imgAdvertisement, AppImages.imgAds1]);

  @override
  Widget buildByState(BuildContext context, HomeState state) {
    return PageLoadingIndicator(
        future: controller.getCurrentUser(context),
        scaffold: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: const Text("Home Page",
                  style: TextStyle(fontSize: 20, color: Colors.yellow)),
              leading: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppIconButton(
                        onPressed: () {
                          _turnSettingPage();
                        },
                        icon: const Icon(Icons.settings, color: Colors.white),
                        borderRadius: AppDimens.radius200,
                        padding: const EdgeInsets.all(AppDimens.spacing5),
                        width: AppDimens.size30.width,
                        height: AppDimens.size30.height,
                        backgroundColor: AppColorScheme.dark().cardColor)
                  ]),
              actions: [
                ProfileCustom(),
                IconButton(
                    onPressed: () {
                      context.router.pushNamed(Routes.testunity);
                    },
                    icon: const Icon(Icons.ac_unit))
              ],
            ),
            body: SingleChildScrollView(
                child: Container(
                    padding: const EdgeInsets.all(15),
                    child: Column(children: [
                      const SizedBox(height: 12),
                      _bulildSearchBar(FormBuilderTextFieldModel(
                          name: "Search",
                          hint_text: "search",
                          icon_suffix: AppIcons.icSearch)),
                      _buildSlider(context, listAdvertisement),
                      _buildListArButton(listButtonObject)
                    ])))));
  }

  Widget _buildListArButton(List<ButtonObject> list) {
    List<Widget> listRow = [];
    for (int i = 0; i < list.length - 1; i = i + 2) {
      listRow.add(Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround, // Căn đều 2 bên
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildButtonObject(listButtonObject[i], i),
            _buildButtonObject(listButtonObject[i + 1], (i + 1))
          ]));
      listRow.add(const SizedBox(height: 20));
    }
    if ((list.length) % 2 != 0) {
      listRow.add(Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround, // Căn đều 2 bên
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildButtonObject(
                listButtonObject[list.length - 1], (list.length - 1)),
            _buildNullButtonObject()
          ]));
      listRow.add(const SizedBox(height: 20));
    }
    return Column(children: listRow);
  }

  Widget _buildButtonObject(ButtonObject item, int index) {
    return Container(
        height: 150,
        width: 150,
        decoration: BoxDecoration(
            color: Colors.blue, // Màu nền của container
            borderRadius:
                BorderRadius.circular(10), // Bo góc với bán kính là 10
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.5), // Màu bóng đổ
                  spreadRadius: 2, // Bán kính lan truyền của bóng đổ
                  blurRadius: 5, // Độ mờ của bóng đổ
                  offset:
                      const Offset(0, 3)) // Độ tương phản và vị trí của bóng đổ
            ]),
        child: Center(
            child: SizedBox(
                height: 140,
                width: 140,
                child: ElevatedButton(
                    onPressed: () {
                      print("Chức năng tạm thời chưa có");
                    },
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.white),
                    // Đặt màu nền của ElevatedButton thành trắng
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(item.icon, scale: 0.5),
                          Expanded(
                              child: Center(
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                //const SizedBox(width: 10),
                                Text(item.title,
                                    style:
                                        const TextStyle(color: Colors.black)),
                                SizedBox(
                                    width: 40, // Đặt kích thước của SizedBox
                                    height: 40,
                                    child: IconButton(
                                        onPressed: () {
                                          _isLoved(index);
                                        },
                                        icon: Image.asset(
                                            listButtonObject[index].isLoved
                                                ? AppIcons.icLoved
                                                : AppIcons.icHeart)))
                              ])))
                        ])))));
  }

  Widget _bulildSearchBar(FormBuilderTextFieldModel item) {
    return FormBuilderTextField(
      name: item.name,
      keyboardType: TextInputType.text,
      onChanged: (value) {
        // Lấy giá trị từ TextField khi nó thay đổi
        setState(() {
          txtSearch = value!;
        });
      },
      decoration: InputDecoration(
          hintText: item.hint_text,
          suffixIcon: IconButton(
              onPressed: () {
                onSearch();
              },
              icon: Image.asset(item.icon_suffix)),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          contentPadding: const EdgeInsets.symmetric(
              vertical: 10, horizontal: 25)), // Điều chỉnh chiều cao ở đây
      style: const TextStyle(fontSize: 16),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: FormBuilderValidators.compose(
          [FormBuilderValidators.required(errorText: "")]),
    );
  }

  Widget _buildNullButtonObject() {
    return const SizedBox(height: 150, width: 150);
  }

  Widget _buildSlider(BuildContext context, AdvertisementObject items) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(
          padding:
              const EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 15),
          height: 200, // Độ cao của Slider
          child: PageView.builder(
              controller: _adsController,
              itemCount: items.length, // Số lượng hình ảnh quảng cáo
              itemBuilder: (context, index) {
                return ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Image.asset(items.ads[index], fit: BoxFit.cover));
              })),
      Center(
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(items.length, (index) {
                return Container(
                    width: 10,
                    height: 10,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _adsCurrentPage == index
                            ? Colors.blue
                            : Colors.grey));
              }))),
      const SizedBox(height: 10)
    ]);
  }

  Widget ProfileCustom() {
    //Sửa lại Thành AppIConButton
    return ElevatedButton(
        style: ButtonStyle(elevation: MaterialStateProperty.all(0)),
        onPressed: () {
          context.router.pushNamed(Routes.userprofile);
        },
        child: Row(children: [
          Text(_nameCustom()),
          const SizedBox(width: 5),
          Image.asset(urlAvatarUser, height: 24, width: 24),
        ]));
  }

  String _nameCustom() {
    List<String> parts = controller.currentUser.value.fullname.split(" ");
    String ten = parts.last;
    if (ten.length > 8) {
      ten = '${ten.substring(0, 5)}...';
    }
    return ten;
  }

  void _isLoved(int index) {
    setState(() {
      listButtonObject[index].isLoved = !listButtonObject[index].isLoved;
    });
    print(listButtonObject[index].isLoved);
  }

  void onSearch() {
    print(txtSearch);
  }

  void _turnSettingPage() {
    Navigator.of(context).push(PageRouteBuilder(
        opaque: false,
        pageBuilder: (BuildContext context, _, __) {
          return const AnimatedOpacity(
              duration: Duration(milliseconds: 500),
              opacity: 1.0, // Độ mờ 80%
              child: SettingPage());
        }));
  }

  @override
  void initState() {
    super.initState();
    _adsController.addListener(() {
      setState(() {
        _adsCurrentPage = _adsController.page!.round();
      });
    });
    controller.getCurrentUser(context);
  }
}
