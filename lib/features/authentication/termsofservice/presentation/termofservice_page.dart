import 'package:ar_zoo_explorers/features/authentication/termsofservice/presentation/termofservice_cubit.dart';
import 'package:ar_zoo_explorers/features/authentication/termsofservice/presentation/termofservice_state.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../app/config/routes.dart';
import '../../../../app/theme/icons.dart';
import '../../../../base/base_state.dart';

@RoutePage()
class TermOfServicePage extends StatefulWidget {
  const TermOfServicePage({super.key});

  @override
  State createState() => _State();
}

class _State extends BaseState<TermOfServiceState, TermOfServiceCubit,
    TermOfServicePage> {
  @override
  Widget buildByState(BuildContext context, TermOfServiceState state) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            title: Transform.scale(
                scale: 1.5, // Điều chỉnh tỷ lệ biểu tượng ở đây
                child: Image.asset(AppImages.imgAppLogo, height: 55)),
            leading: ElevatedButton(
                onPressed: () {
                  context.router.pushNamed(Routes.login);
                },
                child: Image.asset(AppIcons.icBack_png, height: 40))),
        body: SingleChildScrollView(
            child: Center(
                child: Container(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, bottom: 25),
                    child: Column(children: [
                      const SizedBox(height: 25),
                      TitlePage(),
                      const SizedBox(height: 20),
                      ListTermsOfService(),
                      const SizedBox(height: 5),
                      SubmitButton()
                    ])))));
  }

  Widget TitlePage() {
    return Container(
        width:
            MediaQuery.of(context).size.width * 0.8, // Chiều ngang 80% màn hình
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white, // Màu nền của Container
          border: Border.all(
              color: Colors.grey, // Màu viền
              width: 1.5 // Độ dày của viền
              ),
          borderRadius:
              BorderRadius.circular(15.0), // Độ cong góc của Container
        ),
        child: const Center(
          child: Text("Điều khoản sử dụng",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Colors.blue,
                  fontFamily: 'Times New Roman')),
        ));
  }

  Widget ListTermsOfService() {
    return Container(
      padding: const EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width * 0.8,
      height: MediaQuery.of(context).size.width * 1,
      decoration: BoxDecoration(
        color: Colors.white, // Màu nền của Container
        border: Border.all(
            color: Colors.grey, // Màu viền
            width: 1.5 // Độ dày của viền
            ),
        borderRadius: BorderRadius.circular(15.0), // Độ cong góc của Container
      ),
      child: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        TermItem("1. Chấp Nhận Điều Khoản:",
            "Trước khi sử dụng ứng dụng ArZoo, bạn cần đồng ý và tuân theo các điều khoản dưới đây."),
        TermItem("2. Sử Dụng Ứng Dụng:",
            "Bạn được cấp quyền sử dụng ứng dụng AR cho mục đích cá nhân hoặc thương mại.Không được sử dụng ứng dụng cho mục đích bất hợp pháp hoặc gây hại cho người khác."),
        TermItem("3. Quyền Sở Hữu:",
            "Ứng dụng AR là tài sản của chúng tôi và được bảo vệ bởi bản quyền. Không sao chép hoặc sửa đổi ứng dụng mà không có sự cho phép."),
        TermItem("4. Quyền Riêng Tư:",
            "Chúng tôi bảo vệ quyền riêng tư của bạn theo chính sách bảo mật. Dữ liệu cá nhân của bạn có thể được thu thập, nhưng chúng tôi cam kết bảo vệ nó."),
        TermItem("5. Thay Đổi Điều Khoản:",
            "Chúng tôi có quyền thay đổi điều khoản và sẽ thông báo cho bạn về các thay đổi."),
        TermItem("6. Kết Thúc Sử Dụng:",
            "Bạn có thể ngừng sử dụng ứng dụng bất cứ lúc nào."),
        TermItem("7. Bảo Mật Dữ Liệu:",
            "Dữ liệu mà ứng dụng thu thập có thể được sử dụng để cải thiện dịch vụ."),
        TermItem("8. Chất Lượng Dịch Vụ:",
            "Chúng tôi cam kết cung cấp ứng dụng AR với chất lượng tốt nhất."),
        TermItem("9. Hạn Chế Sử Dụng:",
            "Bạn không được phép chạy nhiều phiên bản của ứng dụng trên cùng một thiết bị."),
        TermItem("10. Hỗ Trợ Kỹ Thuật:",
            "Chúng tôi cung cấp hỗ trợ kỹ thuật cho người dùng qua email hoặc hotline."),
        TermItem("11. Thanh Toán (nếu áp dụng):",
            "Nếu ứng dụng AR có tính phí, bạn phải thanh toán theo giá quy định."),
        TermItem("12. Chấp Nhận Sự Cố:",
            "Bạn chấp nhận rủi ro khi sử dụng ứng dụng AR và không thể đòi bồi thường cho hỏng hóc hoặc sự."),
        TermItem("13. Bản Quyền và Tài Khoản:",
            "Tất cả quyền bản quyền đều thuộc sở hữu của chúng tôi. Mỗi tài khoản người dùng chỉ được sử dụng bởi một người."),
        TermItem("14. Điều Khoản Cảnh Báo:",
            "Bạn cần tuân thủ tất cả các điều khoản và cảnh báo trong ứng dụng AR."),
        TermItem("15. Sử Dụng Công Cụ:",
            "Chúng tôi có thể cung cấp các công cụ hỗ trợ sử dụng ứng dụng AR một cách tốt nhất."),
      ])),
    );
  }

  Widget TermItem(String termTitle, String termContent) {
    return Column(mainAxisAlignment: MainAxisAlignment.start, children: [
      const SizedBox(height: 8),
      Row(mainAxisAlignment: MainAxisAlignment.start, children: [
        Text(termTitle,
            style: const TextStyle(
                fontSize: 15,
                color: Colors.black,
                fontWeight: FontWeight.bold)),
        const SizedBox(width: 8),
      ]),
      const SizedBox(height: 6),
      Text(termContent,
          style: const TextStyle(fontSize: 14, color: Colors.black))
    ]);
  }

  Widget SubmitButton() {
    return Container(
        width: MediaQuery.of(context).size.width * 0.5,
        height: MediaQuery.of(context).size.width * 0.2,
        padding: const EdgeInsets.all(15),
        child: ElevatedButton(
            onPressed: () {
              context.router.pushNamed(Routes.userprofile);
            },
            style: TextButton.styleFrom(
                minimumSize: const Size(160, 50),
                backgroundColor: Colors.green, // Màu nền
                padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 10), // Khoảng cách giữa chữ và nút
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30) // Đổ viền cho nút
                    )),
            child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Quay lại",
                      style: TextStyle(fontSize: 20, color: Colors.white)),
                ])));
  }
}
