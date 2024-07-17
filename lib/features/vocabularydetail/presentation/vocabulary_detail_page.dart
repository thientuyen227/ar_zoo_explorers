import 'package:ar_zoo_explorers/base/base_state.dart';
import 'package:ar_zoo_explorers/domain/entities/learning_category_entity.dart';
import 'package:ar_zoo_explorers/features/vocabularydetail/components/item_vocabulary_detail.dart';
import 'package:ar_zoo_explorers/features/vocabularydetail/presentation/vocabulary_detail_cubit.dart';
import 'package:ar_zoo_explorers/features/vocabularydetail/presentation/vocabulary_detail_state.dart';
import 'package:ar_zoo_explorers/utils/widget/custom_back_button.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

@RoutePage()
class VocabularyDetailPage extends StatefulWidget {
  const VocabularyDetailPage({super.key, required this.category});
  final LearningCategoryEntity category;

  @override
  State createState() => _State();
}

class _State extends BaseState<VocabularyDetailState, VocabularyDetailCubit,
    VocabularyDetailPage> {
  @override
  void initState() {
    cubit.init(context: context, categoryId: widget.category.id);
    super.initState();
  }

  final languageCode = Get.locale?.languageCode;
  @override
  Widget buildByState(BuildContext context, VocabularyDetailState state) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category.nameLocalize,
            style: const TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold)),
        centerTitle: true,
        leading: const CustomBackButton(),
        elevation: 1,
        backgroundColor: const Color.fromARGB(255, 109, 189, 255),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              // const Text(
              //   "Easy",
              //   style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
              // ),
              const SizedBox(
                height: 14,
              ),
              if (state.vocabularies.isNotEmpty)
                GridView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(10),
                  itemCount: state.vocabularies.length,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return ItemVocabularyDetail(
                      vocabularyEntity: state.vocabularies[index],
                    );
                  },
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: languageCode == 'vi'
                        ? state.width * 1.65 / state.height
                        : state.width * 1.52 / state.height,
                  ),
                ),
              const SizedBox(
                height: 30,
              )
            ],
          ),
        ),
      ),
    );
  }
}
