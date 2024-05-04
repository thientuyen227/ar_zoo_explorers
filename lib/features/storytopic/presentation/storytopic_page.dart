import 'package:ar_zoo_explorers/base/base_state.dart';
import 'package:ar_zoo_explorers/features/storytopic/presentation/storytopic_cubit.dart';
import 'package:ar_zoo_explorers/features/storytopic/presentation/storytopic_state.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';

@RoutePage()
class StoryTopicPage extends StatefulWidget {
  const StoryTopicPage({super.key});

  @override
  State createState() => _State();
}

class _State extends BaseState<StoryTopicState, StoryTopicCubit,
    StoryTopicPage> {
      @override
      Widget buildByState(BuildContext context, StoryTopicState state) {
    // TODO: implement buildByState
    throw UnimplementedError();
      }
    }