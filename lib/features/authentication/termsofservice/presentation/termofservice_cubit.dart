import 'package:ar_zoo_explorers/app/languages/language_key.dart';
import 'package:ar_zoo_explorers/features/authentication/termsofservice/presentation/termofservice_state.dart';
import 'package:get/get.dart';
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
        title: "1. ${LanguageKeys.term1_title.tr}:",
        content: LanguageKeys.term1_content.tr),
    Term(
        title: "2. ${LanguageKeys.term2_title.tr}:",
        content: LanguageKeys.term2_content.tr),
    Term(
        title: "3. ${LanguageKeys.term3_title.tr}:",
        content: LanguageKeys.term3_content.tr),
    Term(
        title: "4. ${LanguageKeys.term4_title.tr}:",
        content: LanguageKeys.term4_content.tr),
    Term(
        title: "5. ${LanguageKeys.term5_title.tr}:",
        content: LanguageKeys.term5_content.tr),
    Term(
        title: "6. ${LanguageKeys.term6_title.tr}:",
        content: LanguageKeys.term6_content.tr),
    Term(
        title: "7. ${LanguageKeys.term7_title.tr}:",
        content: LanguageKeys.term7_content.tr),
    Term(
        title: "8.  ${LanguageKeys.term8_title.tr}:",
        content: LanguageKeys.term8_content.tr),
    Term(
        title: "9.  ${LanguageKeys.term9_title.tr}",
        content: LanguageKeys.term9_content.tr),
    Term(
        title: "10. ${LanguageKeys.term10_title.tr}:",
        content: LanguageKeys.term10_content.tr),
    Term(
        title: "11. ${LanguageKeys.term11_title.tr}:",
        content: LanguageKeys.term11_content.tr),
    Term(
        title: "12. ${LanguageKeys.term12_title.tr}:",
        content: LanguageKeys.term12_content.tr),
    Term(
        title: "13. ${LanguageKeys.term13_title.tr}:",
        content: LanguageKeys.term13_content.tr),
    Term(
        title: "14. ${LanguageKeys.term14_title.tr}:",
        content: LanguageKeys.term14_content.tr),
    Term(
        title: "15. ${LanguageKeys.term15_title.tr}:",
        content: LanguageKeys.term15_content.tr)
  ];
}
