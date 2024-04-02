import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  BlogBloc(Object object) : super(BlogInitial()) {
    on<BlogEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
