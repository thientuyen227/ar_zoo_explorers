import 'package:ar_zoo_explorers/app/languages/language_key.dart';
import 'package:ar_zoo_explorers/base/base_state.dart';
import 'package:ar_zoo_explorers/features/vocabulary/components/item_vocabulary.dart';
import 'package:ar_zoo_explorers/features/vocabulary/presentation/vocabulary_cubit.dart';
import 'package:ar_zoo_explorers/features/vocabulary/presentation/vocabulary_state.dart';
import 'package:ar_zoo_explorers/utils/widget/custom_back_button.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

@RoutePage()
class VocabularyPage extends StatefulWidget {
  const VocabularyPage({super.key});

  @override
  State createState() => _State();
}

class _State
    extends BaseState<VocabularyState, VocabularyCubit, VocabularyPage> {
  // final _formKey = GlobalKey<FormBuilderState>();

  @override
  void initState() {
    super.initState();
    cubit.showLoading();
    cubit.init(context);
    cubit.hideLoading();
  }

  @override
  Widget buildByState(BuildContext context, VocabularyState state) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(LanguageKeys.vocabulary.tr,
            style: const TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold)),
        backgroundColor: const Color.fromARGB(255, 109, 189, 255),
        elevation: 1,
        leading: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [CustomBackButton()]),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 20,
            ),
            state.height != 0
                ? GridView.builder(
                    shrinkWrap: true,
                    itemCount: state.learningcategories.length,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ItemVocabulary(
                          state: state,
                          learningCategoryEntity:
                              state.learningcategories[index],
                        ),
                      );
                    },
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: state.height > 1000 ? 1.8 : 0.9,
                    ),
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
