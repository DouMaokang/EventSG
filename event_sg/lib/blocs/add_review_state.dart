import 'package:meta/meta.dart';

@immutable
abstract class AddReviewState {}

class AddReviewAdded extends AddReviewState {}

class AddReviewNotAdded extends AddReviewState {}