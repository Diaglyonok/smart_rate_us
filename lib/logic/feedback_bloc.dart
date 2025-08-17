import 'package:clean_cubit_reactor/clean_cubit_reactor.dart';
import 'package:flutter/foundation.dart';
import 'package:smart_rate_us/logic/feedback_repository.dart';
import 'package:smart_rate_us/logic/listeners_type.dart';

@immutable
abstract class FeedbackBaseState {
  const FeedbackBaseState();
}

class LoadingState extends FeedbackBaseState {
  const LoadingState();
}

class ShowFeedbackState extends FeedbackBaseState {
  const ShowFeedbackState();
}

class DoNothingState extends FeedbackBaseState {
  const DoNothingState();
}

class FeedbackCubit
    extends
        CubitListener<
          ListenersType,
          FeedbackRepoLoadResponse,
          FeedbackBaseState
        > {
  FeedbackCubit({required FeedbackRepository repository})
    : super(const LoadingState(), repository, ListenersType.loadListener);

  @override
  void emitOnResponse(FeedbackRepoLoadResponse response) {
    if (response.countersBorderPassed) {
      emit(const ShowFeedbackState());
      return;
    }

    emit(const DoNothingState());
  }

  @override
  void setLoading({required FeedbackRepoLoadResponse data}) {
    emit(const LoadingState());
  }
}
