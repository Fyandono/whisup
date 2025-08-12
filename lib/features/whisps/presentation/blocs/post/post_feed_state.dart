part of 'post_feed_bloc.dart';

sealed class PostFeedState extends Equatable {
  const PostFeedState();
  
  @override
  List<Object> get props => [];
}

final class PostFeedInitial extends PostFeedState {}
