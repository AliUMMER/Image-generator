import 'package:bloc/bloc.dart';
import 'package:image_generator/repositery/api/genorator_api.dart';
import 'package:image_generator/repositery/model/genorater_model.dart';
import 'package:meta/meta.dart';

part 'genarator_event.dart';
part 'genarator_state.dart';

class GenaratorBloc extends Bloc<GenaratorEvent, GenaratorState> {
  final GenoratorApi genratorApi = GenoratorApi();
  Generatormodel? generatormodel;

  GenaratorBloc() : super(GenaratorInitial()) {
    on<FetchGenaratorEvent>((event, emit) async {
      emit(GenaratorBlocLoading());
      try {
        final Generatormodel = await genratorApi.getGenerator();
        emit(GenaratorBlocLoaded());
      } catch (e) {
        emit(GenaratorBlocError());
      }
    });
  }
}
