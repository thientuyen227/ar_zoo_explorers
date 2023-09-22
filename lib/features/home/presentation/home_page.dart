import 'package:ar_zoo_explorers/app/theme/colors.dart';
import 'package:ar_zoo_explorers/app/theme/dimens.dart';
import 'package:ar_zoo_explorers/app/theme/icons.dart';
import 'package:ar_zoo_explorers/base/base_state.dart';
import 'package:ar_zoo_explorers/features/home/presentation/home_state.dart';
import 'package:ar_zoo_explorers/utils/widget/button_widget.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../../app/config/routes.dart';
import 'home_cubit.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State createState() => _State();
}

class _State extends BaseState<HomeState, HomeCubit, HomePage> {
  // Khởi tạo controller

  @override
  Widget buildByState(BuildContext context, HomeState state) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Home Page",
            style: TextStyle(fontSize: 20, color: Colors.amber)),
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppIconButton(
              onPressed: () {
                context.router.pushNamed(Routes.settings);
              },
              icon: const Icon(
                Icons.settings,
                color: Colors.white,
              ),
              borderRadius: AppDimens.radius200,
              padding: const EdgeInsets.all(AppDimens.spacing5),
              width: AppDimens.size30.width,
              height: AppDimens.size30.height,
              backgroundColor: AppColorScheme.dark().cardColor,
            )
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppIconButton(
                  onPressed: () {
                    context.router.pushNamed(Routes.camera);
                  },
                  icon: const Icon(
                    Icons.camera_alt,
                    color: Colors.white,
                  ),
                  borderRadius: AppDimens.radius200,
                  padding: const EdgeInsets.all(AppDimens.spacing5),
                  width: AppDimens.size30.width,
                  height: AppDimens.size30.height,
                  backgroundColor: AppColorScheme.dark().cardColor,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppIconButton(
                  onPressed: () {
                    context.router.pushNamed(Routes.ar);
                  },
                  icon: const Icon(
                    Icons.archive,
                    color: Colors.white,
                  ),
                  borderRadius: AppDimens.radius200,
                  padding: const EdgeInsets.all(AppDimens.spacing5),
                  width: AppDimens.size30.width,
                  height: AppDimens.size30.height,
                  backgroundColor: AppColorScheme.dark().cardColor,
                ),
              ],
            ),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            const SizedBox(
              height: 12,
            ),
            FormBuilderTextField(
              name: 'Search',
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  hintText: "Search",
                  suffixIcon: IconButton(
                      onPressed: () {}, icon: Image.asset(AppIcons.icSearch)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  contentPadding: const EdgeInsets.all(10)),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(errorText: ""),
              ]),
            ),
            const SizedBox(height: 15),
            // Transform.scale(
            //   child: Image.asset(AppImages.imgAdvertisement),
            // ),
            // const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround, // Căn đều 2 bên
              crossAxisAlignment:
                  CrossAxisAlignment.center, // Căn theo trục chéo (giữa dọc)
              children: [
                //Animal
                Container(
                  height: 150,
                  width: 150,
                  //color: Colors.blue,
                  decoration: BoxDecoration(
                    color: Colors.blue, // Màu nền của container
                    borderRadius:
                        BorderRadius.circular(10), // Bo góc với bán kính là 10
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5), // Màu bóng đổ
                        spreadRadius: 2, // Bán kính lan truyền của bóng đổ
                        blurRadius: 5, // Độ mờ của bóng đổ
                        offset: const Offset(
                            0, 3), // Độ tương phản và vị trí của bóng đổ
                      ),
                    ],
                  ),
                  child: Center(
                    child: SizedBox(
                      height: 140,
                      width: 140,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors
                              .white, // Đặt màu nền của ElevatedButton thành trắng
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(AppIcons.icAnimal, scale: 0.5),
                            const SizedBox(width: 20),
                            Expanded(
                              child: Center(
                                child: Row(
                                  children: [
                                    const SizedBox(width: 10),
                                    const Flexible(
                                      flex: 2,
                                      child: Text(
                                        "Animal",
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ),
                                    const SizedBox(width: 25),
                                    Flexible(
                                      flex: 1,
                                      child: Image.asset(
                                        AppIcons.icHeart,
                                        width: 20,
                                        height: 20,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                //Reptiles
                Container(
                  height: 150,
                  width: 150,
                  //color: Colors.blue,
                  decoration: BoxDecoration(
                    color: Colors.blue, // Màu nền của container
                    borderRadius:
                        BorderRadius.circular(10), // Bo góc với bán kính là 10
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5), // Màu bóng đổ
                        spreadRadius: 2, // Bán kính lan truyền của bóng đổ
                        blurRadius: 5, // Độ mờ của bóng đổ
                        offset: const Offset(
                            0, 3), // Độ tương phản và vị trí của bóng đổ
                      ),
                    ],
                  ),
                  child: Center(
                    child: SizedBox(
                      height: 140,
                      width: 140,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors
                              .white, // Đặt màu nền của ElevatedButton thành trắng
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(AppIcons.icCrocodile, scale: 0.5),
                            const SizedBox(width: 20),
                            Expanded(
                              child: Center(
                                child: Row(
                                  children: [
                                    const SizedBox(width: 10),
                                    const Flexible(
                                      flex: 2,
                                      child: Text(
                                        "Reptiles",
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ),
                                    const SizedBox(width: 20),
                                    Flexible(
                                      flex: 1,
                                      child: Image.asset(
                                        AppIcons.icHeart,
                                        width: 20,
                                        height: 20,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround, // Căn đều 2 bên
              crossAxisAlignment:
                  CrossAxisAlignment.center, // Căn theo trục chéo (giữa dọc)
              children: [
                //Fish
                Container(
                  height: 150,
                  width: 150,
                  //color: Colors.blue,
                  decoration: BoxDecoration(
                    color: Colors.blue, // Màu nền của container
                    borderRadius:
                        BorderRadius.circular(10), // Bo góc với bán kính là 10
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5), // Màu bóng đổ
                        spreadRadius: 2, // Bán kính lan truyền của bóng đổ
                        blurRadius: 5, // Độ mờ của bóng đổ
                        offset: const Offset(
                            0, 3), // Độ tương phản và vị trí của bóng đổ
                      ),
                    ],
                  ),
                  child: Center(
                    child: SizedBox(
                      height: 140,
                      width: 140,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors
                              .white, // Đặt màu nền của ElevatedButton thành trắng
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(AppIcons.icFish, scale: 1.0),
                            const SizedBox(width: 15),
                            Expanded(
                              child: Center(
                                child: Row(
                                  children: [
                                    const SizedBox(width: 10),
                                    const Flexible(
                                      flex: 2,
                                      child: Text(
                                        "Fish",
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ),
                                    const SizedBox(width: 25),
                                    Flexible(
                                      flex: 1,
                                      child: Image.asset(
                                        AppIcons.icHeart,
                                        width: 20,
                                        height: 20,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                //Bird
                Container(
                  height: 150,
                  width: 150,
                  //color: Colors.blue,
                  decoration: BoxDecoration(
                    color: Colors.blue, // Màu nền của container
                    borderRadius:
                        BorderRadius.circular(10), // Bo góc với bán kính là 10
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5), // Màu bóng đổ
                        spreadRadius: 2, // Bán kính lan truyền của bóng đổ
                        blurRadius: 5, // Độ mờ của bóng đổ
                        offset: const Offset(
                            0, 3), // Độ tương phản và vị trí của bóng đổ
                      ),
                    ],
                  ),
                  child: Center(
                    child: SizedBox(
                      height: 140,
                      width: 140,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors
                              .white, // Đặt màu nền của ElevatedButton thành trắng
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(AppIcons.icBird, scale: 0.5),
                            const SizedBox(width: 20),
                            Expanded(
                              child: Center(
                                child: Row(
                                  children: [
                                    const SizedBox(width: 10),
                                    const Flexible(
                                      flex: 2,
                                      child: Text(
                                        "Fish",
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ),
                                    const SizedBox(width: 20),
                                    Flexible(
                                      flex: 1,
                                      child: Image.asset(
                                        AppIcons.icHeart,
                                        width: 20,
                                        height: 20,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround, // Căn đều 2 bên
              crossAxisAlignment:
                  CrossAxisAlignment.center, // Căn theo trục chéo (giữa dọc)
              children: [
                //Dinosaurs
                Container(
                  height: 150,
                  width: 150,
                  //color: Colors.blue,
                  decoration: BoxDecoration(
                    color: Colors.blue, // Màu nền của container
                    borderRadius:
                        BorderRadius.circular(10), // Bo góc với bán kính là 10
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5), // Màu bóng đổ
                        spreadRadius: 2, // Bán kính lan truyền của bóng đổ
                        blurRadius: 5, // Độ mờ của bóng đổ
                        offset: const Offset(
                            0, 3), // Độ tương phản và vị trí của bóng đổ
                      ),
                    ],
                  ),
                  child: Center(
                    child: SizedBox(
                      height: 140,
                      width: 140,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors
                              .white, // Đặt màu nền của ElevatedButton thành trắng
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(AppIcons.icDinosaurs, scale: 1.0),
                            const SizedBox(width: 15),
                            Expanded(
                              child: Center(
                                child: Row(
                                  children: [
                                    const SizedBox(width: 5),
                                    const Flexible(
                                      flex: 3,
                                      child: Text(
                                        "Dinosaurs",
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                    Flexible(
                                      flex: 1,
                                      child: Image.asset(
                                        AppIcons.icHeart,
                                        width: 20,
                                        height: 20,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                //None
                Container(
                  height: 150,
                  width: 150,
                  color: Colors.white,
                  // child: Center(
                  //   child: SizedBox(
                  //     height: 140,
                  //     width: 140,
                  //     child: ElevatedButton(
                  //       onPressed: () {},
                  //       style: ElevatedButton.styleFrom(
                  //         backgroundColor: Colors
                  //             .white, // Đặt màu nền của ElevatedButton thành trắng
                  //       ),
                  //       child: Column(
                  //         mainAxisAlignment: MainAxisAlignment.center,
                  //         children: [
                  //           Image.asset(AppIcons.icBird, scale: 0.5),
                  //           const SizedBox(width: 20),
                  //           Expanded(
                  //             child: Center(
                  //               child: Row(
                  //                 children: [
                  //                   const SizedBox(width: 10),
                  //                   const Flexible(
                  //                     flex: 2,
                  //                     child: Text(
                  //                       "Fish",
                  //                       style: TextStyle(color: Colors.black),
                  //                     ),
                  //                   ),
                  //                   const SizedBox(width: 20),
                  //                   Flexible(
                  //                     flex: 1,
                  //                     child: Image.asset(
                  //                       AppIcons.icHeart,
                  //                       width: 20,
                  //                       height: 20,
                  //                     ),
                  //                   ),
                  //                 ],
                  //               ),
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  // ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
