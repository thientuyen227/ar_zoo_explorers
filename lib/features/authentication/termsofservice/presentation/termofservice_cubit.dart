import 'package:ar_zoo_explorers/features/authentication/termsofservice/presentation/termofservice_state.dart';
import 'package:injectable/injectable.dart';

import '../../../../base/base_cubit.dart';
import '../model/term_model.dart';

@injectable
class TermOfServiceCubit extends BaseCubit<TermOfServiceState> {
  TermOfServiceCubit() : super(TermOfServiceState());

  double WIDTH = 0;
  double HEIGHT = 0;

  List<Term> listTerm = [
    Term(
        title: "1. Accept Terms:",
        content:
            "Before using the ArZoo app, you need to agree to and comply with the following terms."),
    Term(
        title: "2. Using the App:",
        content:
            "You are granted the right to use the AR app for personal or commercial purposes. The app must not be used for illegal purposes or to harm others."),
    Term(
        title: "3. Ownership Rights:",
        content:
            "The AR app is our property and is protected by copyright. Copying or modifying the app without permission is prohibited."),
    Term(
        title: "4. Privacy Rights:",
        content:
            "We protect your privacy according to our privacy policy. Your personal data may be collected, but we commit to safeguarding it."),
    Term(
        title: "5. Change of Terms:",
        content:
            "We reserve the right to change the terms and will notify you of any changes."),
    Term(
        title: "6. Termination of Use:",
        content: "You may cease using the app at any time."),
    Term(
        title: "7. Data Security:",
        content:
            "The user's personal data is our top priority. We only collect necessary information to provide services and personalize the user experience. All this information is securely protected, and we commit not to share or sell personal information to any third party without clear consent from the user."),
    Term(
        title: "8. Service Quality:",
        content:
            "We are committed to providing the AR app with the highest quality."),
    Term(
        title: "9. Usage Restrictions:",
        content:
            "You are not allowed to run multiple instances of the app on the same device."),
    Term(
        title: "10. Technical Support:",
        content:
            "We provide technical support for users via email or hotline."),
    Term(
        title: "11. Payment (if applicable):",
        content:
            "If the AR app is free, you must pay according to the specified price if applicable."),
    Term(
        title: "12. Acceptance of Incidents:",
        content:
            "Acceptance of risk limitations when using the AR app, and no compensation can be claimed for damage or loss."),
    Term(
        title: "13. Copyright and Accounts:",
        content:
            "All copyright rights are owned by us. Each user account is for single-user use only."),
    Term(
        title: "14. Warning Terms:",
        content:
            "You must adhere to all terms and warnings within the AR app."),
    Term(
        title: "15. Tool Usage:",
        content:
            "We can provide tools to support the optimal usage of the AR app.")
  ];
}
