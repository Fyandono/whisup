import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'post_feed_event.dart';
part 'post_feed_state.dart';

class PostFeedBloc extends Bloc<PostFeedEvent, PostFeedState> {
  PostFeedBloc() : super(PostFeedInitial()) {
    on<PostFeedEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
