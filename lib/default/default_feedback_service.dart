import 'package:smart_rate_us/data/feedback_service.dart';

class FakeFeedbackService implements FeedbackService {
  @override
  Future<bool> sendFeedback({required Map<String, dynamic> feedback}) async {
    await Future.delayed(const Duration(seconds: 2));
    return true;
  }
}
