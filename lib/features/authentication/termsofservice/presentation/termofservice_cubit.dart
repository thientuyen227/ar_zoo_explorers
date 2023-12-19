import 'package:ar_zoo_explorers/features/authentication/termsofservice/presentation/termofservice_state.dart';
import 'package:injectable/injectable.dart';

import '../../../../base/base_cubit.dart';
import '../model/term_model.dart';

@injectable
class TermOfServiceCubit extends BaseCubit<TermOfServiceState> {
  TermOfServiceCubit() : super(TermOfServiceState());

  List<Term> listTerm = [
    Term(
        title: "1. Chấp Nhận Điều Khoản:",
        content:
            "Trước khi sử dụng ứng dụng ArZoo, bạn cần đồng ý và tuân theo các điều khoản dưới đây."),
    Term(
        title: "2. Sử Dụng Ứng Dụng:",
        content:
            "Bạn được cấp quyền sử dụng ứng dụng AR cho mục đích cá nhân hoặc thương mại.Không được sử dụng ứng dụng cho mục đích bất hợp pháp hoặc gây hại cho người khác."),
    Term(
        title: "3. Quyền Sở Hữu:",
        content:
            "Ứng dụng AR là tài sản của chúng tôi và được bảo vệ bởi bản quyền. Không sao chép hoặc sửa đổi ứng dụng mà không có sự cho phép."),
    Term(
        title: "4. Quyền Riêng Tư:",
        content:
            "Chúng tôi bảo vệ quyền riêng tư của bạn theo chính sách bảo mật. Dữ liệu cá nhân của bạn có thể được thu thập, nhưng chúng tôi cam kết bảo vệ nó."),
    Term(
        title: "5. Thay Đổi Điều Khoản:",
        content:
            "Chúng tôi có quyền thay đổi điều khoản và sẽ thông báo cho bạn về các thay đổi."),
    Term(
        title: "6. Kết Thúc Sử Dụng:",
        content: "Bạn có thể ngừng sử dụng ứng dụng bất cứ lúc nào."),
    Term(
        title: "7. Bảo Mật Dữ Liệu:",
        content:
            "Dữ liệu cá nhân của người dùng là ưu tiên hàng đầu đối với chúng tôi. Chúng tôi chỉ thu thập thông tin cần thiết để cung cấp dịch vụ và cá nhân hóa trải nghiệm người dùng. Mọi thông tin này đều được bảo vệ một cách an toàn và chúng tôi cam kết không chia sẻ hoặc bán thông tin cá nhân cho bất kỳ bên thứ ba nào mà không có sự đồng ý rõ ràng từ phía người dùng."),
    Term(
        title: "8. Chất Lượng Dịch Vụ:",
        content:
            "Chúng tôi cam kết cung cấp ứng dụng AR với chất lượng tốt nhất."),
    Term(
        title: "9. Hạn Chế Sử Dụng:",
        content:
            "Bạn không được phép chạy nhiều phiên bản của ứng dụng trên cùng một thiết bị."),
    Term(
        title: "10. Hỗ Trợ Kỹ Thuật:",
        content:
            "Chúng tôi cung cấp hỗ trợ kỹ thuật cho người dùng qua email hoặc hotline."),
    Term(
        title: "11. Thanh Toán (nếu áp dụng):",
        content:
            "Nếu ứng dụng AR có tính phí, bạn phải thanh toán theo giá quy định."),
    Term(
        title: "12. Chấp Nhận Sự Cố:",
        content:
            "Bạn chấp nhận rủi ro khi sử dụng ứng dụng AR và không thể đòi bồi thường cho hỏng hóc hoặc sự."),
    Term(
        title: "13. Bản Quyền và Tài Khoản:",
        content:
            "Tất cả quyền bản quyền đều thuộc sở hữu của chúng tôi. Mỗi tài khoản người dùng chỉ được sử dụng bởi một người."),
    Term(
        title: "14. Điều Khoản Cảnh Báo:",
        content:
            "Bạn cần tuân thủ tất cả các điều khoản và cảnh báo trong ứng dụng AR."),
    Term(
        title: "15. Sử Dụng Công Cụ:",
        content:
            "Chúng tôi có thể cung cấp các công cụ hỗ trợ sử dụng ứng dụng AR một cách tốt nhất.")
  ];
}
