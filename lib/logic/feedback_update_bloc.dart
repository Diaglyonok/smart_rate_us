import 'package:clean_cubit_reactor/clean_cubit_reactor.dart';
import 'package:flutter/foundation.dart';
import 'package:smart_rate_us/logic/feedback_repository.dart';
import 'package:smart_rate_us/logic/listeners_type.dart';

@immutable
abstract class FeedbackUpdateBaseState {
  const FeedbackUpdateBaseState();
}

class UpdateInitialState extends FeedbackUpdateBaseState {
  const UpdateInitialState();
}

class UpdateInProgressState extends FeedbackUpdateBaseState {
  const UpdateInProgressState();
}

class UpdateSucceededState extends FeedbackUpdateBaseState {
  const UpdateSucceededState();
}

class UpdateFailedState extends FeedbackUpdateBaseState {
  const UpdateFailedState();
}

class FeedbackUpdateCubit
    extends
        CubitListener<
          ListenersType,
          FeedbackRepoUpdateResponse,
          FeedbackUpdateBaseState
        > {
  FeedbackUpdateCubit({required FeedbackRepository repository})
    : _repo = repository,
      super(
        const UpdateInitialState(),
        repository,
        ListenersType.updateListener,
      );
  final FeedbackRepository _repo;

  void sendFeedback(Map<String, dynamic> feedback) {
    _repo.sendFeedback(feedback);
  }

  void delayDialog() {
    _repo.delayDialog();
  }

  @override
  void emitOnResponse(FeedbackRepoUpdateResponse response) {
    if (response.taskDone) {
      emit(const UpdateSucceededState());
    } else {
      emit(const UpdateFailedState());
    }
  }

  @override
  void setLoading({required FeedbackRepoUpdateResponse data}) {
    emit(const UpdateInProgressState());
  }
}
