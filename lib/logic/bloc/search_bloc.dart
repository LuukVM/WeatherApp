import 'package:bloc/bloc.dart';
import '../../data/weather_model.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  List<WeatherModel> allLocations;

  SearchBloc({required this.allLocations}) : super(Searching()) {
    on<CreatedEvent>((event, emit) {
      allLocations = event.allLocations;
      emit(SearchCompleted(foundLocations: event.allLocations));
    });

    on<QueryChangedEvent>((event, emit) {
      if (event.query == '') {
        emit(SearchCompleted(foundLocations: allLocations));
      } else {
        List<WeatherModel> newList = allLocations
            .where((element) => element.locationName
                .toLowerCase()
                .contains(event.query.toLowerCase().trim()))
            .toList();
        if (newList.isNotEmpty) {
          emit(SearchCompleted(foundLocations: newList));
        } else {
          emit(SearchFailed(errorMessage: 'No Cities found with given name'));
        }
      }
    });

    on<InternetChangedEvent>((event, emit) {
      emit(SearchFailed(errorMessage: event.errorMessage));
    });
  }
}
