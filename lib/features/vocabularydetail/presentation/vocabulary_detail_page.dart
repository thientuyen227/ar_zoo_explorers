import 'package:ar_zoo_explorers/app/languages/language_key.dart';
import 'package:ar_zoo_explorers/app/theme/colors.dart';
import 'package:ar_zoo_explorers/base/base_state.dart';
import 'package:ar_zoo_explorers/features/vocabularydetail/components/item_vocabulary_detail.dart';
import 'package:ar_zoo_explorers/features/vocabularydetail/presentation/vocabulary_detail_cubit.dart';
import 'package:ar_zoo_explorers/features/vocabularydetail/presentation/vocabulary_detail_state.dart';
import 'package:ar_zoo_explorers/utils/widget/custom_back_button.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

@RoutePage()
class VocabularyDetailPage extends StatefulWidget {
  const VocabularyDetailPage({super.key});

  @override
  State createState() => _State();
}

class _State extends BaseState<VocabularyDetailState, VocabularyDetailCubit,
    VocabularyDetailPage> {
  @override
  void initState() {
    super.initState();
    cubit.init();
  }

  @override
  Widget buildByState(BuildContext context, VocabularyDetailState state) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LanguageKeys.animals.tr),
        centerTitle: true,
        leading: const CustomBackButton(),
        elevation: 1,
        backgroundColor: const Color.fromARGB(255, 109, 189, 255),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Column(
              children: [
                const Text(
                  "Easy",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 14,
                ),
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Color(0xFF49B0AB),
                  ),
                  child: const Text(
                    "150 pts",
                    style: TextStyle(color: AppColor.white, fontSize: 8),
                  ),
                ),
                if (state.vocabularies.isNotEmpty)
                  GridView.builder(
                    shrinkWrap: true,
                    itemCount: state.vocabularies.length,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            ItemVocabularyDetail(
                              vocabularyEntity: state.vocabularies[index],
                            ),
                          ],
                        ),
                      );
                    },
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.86,
                    ),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
