import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:whisup/features/whisps/data/model/whisp.dart';
import 'package:whisup/features/whisps/data/repository/repository.dart';
import 'package:whisup/util/device_identifier.dart';

part 'whisps_event.dart';
part 'whisps_state.dart';

class WhispsBloc extends Bloc<WhispsEvent, WhispsState> {
  WhispsBloc() : super(WhispsInitial()) {
    final WhispsRepository whispsRepository = WhispsRepository();

    // initialization
    int currentPage = 1;
    const pageSize = 10;
    bool hasMore = true;
    bool isLoading = false;

    // object
    final List<CardWhispModel> listObject = [];

    // load list cuti
    Future<void> loadWhisps() async {
      // start loading
      isLoading = true;

      // get required data
      final response = await whispsRepository.getWhisps(currentPage, pageSize);
      currentPage++;
      hasMore = response.length == pageSize;
      listObject.addAll(response);

      // stop loading
      isLoading = false;
    }

    // load list
    on<LoadWhisps>((event, emit) async {
      if (isLoading) return;
      try {
        // reset
        listObject.clear();
        currentPage = 1;

        // load list
        await loadWhisps();

        emit(WhispsLoaded(listObject: List.from(listObject), hasMore: hasMore));
      } catch (e) {
        emit(WhispsError());
      }
    });

    // load more list
    on<LoadMoreWhisps>((event, emit) async {
      if (isLoading || !hasMore) return;
      try {
        // load list
        await loadWhisps();

        emit(WhispsLoaded(listObject: List.from(listObject), hasMore: hasMore));
      } catch (e) {
        emit(WhispsError());
      }
    });

    // refresh
    on<RefreshWhisps>((event, emit) async {
      if (isLoading) return;
      try {
        emit(WhispsInitial());

        // reset
        listObject.clear();
        currentPage = 1;

        // load list
        await loadWhisps();

        emit(WhispsLoaded(listObject: List.from(listObject), hasMore: hasMore));
      } catch (e) {
        emit(WhispsError());
      }
    });

    // add
    on<AddWhisp>((event, emit) async {
      if (isLoading) return;
      try {
        emit(WhispsInitial());

        // reset
        listObject.clear();
        currentPage = 1;

        // load list
        await loadWhisps();

        final deviceId = await DeviceIdentifier.getDeviceID();
        final response = await whispsRepository.getProfile(deviceId);

        final sampleReactions = {"❤️": 0, "😂": 0, "😮": 0, "🤝": 0};
        final object = CardWhispModel(
          id: 15,
          username: response['username'],
          message: event.message,
          createdAt: DateTime.now().toString(),
          reactions:
              sampleReactions.entries.map((e) => {e.key: e.value}).toList(),
          avatar: response['pixel_avatar'],
        );

        listObject.insert(0, object);

        emit(WhispsLoaded(listObject: List.from(listObject), hasMore: hasMore));
      } catch (e) {
        emit(WhispsError());
      }
    });
  }
}
