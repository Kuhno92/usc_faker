import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'usc_provider_event.dart';
part 'usc_provider_state.dart';

class UscProviderBloc extends Bloc<UscProviderEvent, UscProviderState> {
  UscProviderBloc() : super(UscProviderInitial()) {
    on<LoadUscProvider>(_mapLoadUscProviderToState);
    on<AddUscProvider>(_mapAddUscProviderToState);
    on<DeleteUscProvider>(_mapDeleteUscProviderToState);
  }

  void _mapLoadUscProviderToState(
      LoadUscProvider event, Emitter<UscProviderState> emit) async {
    emit(UscProviderLoading());
    try {
      QuerySnapshot providerSnap =
          await FirebaseFirestore.instance.collection('UscProvider').get();
      emit(UscProviderLoaded(providerSnap.docs.map((e) {
        Map<String, dynamic> data = e.data() as Map<String, dynamic>;
        return data;
      }).toList()));
    } catch (e, stacktrace) {
      print("_mapLoadProfileToState Error");
      print(e);
      print(stacktrace);
      emit(UscProviderError());
    }
  }

  void _mapAddUscProviderToState(
      AddUscProvider event, Emitter<UscProviderState> emit) async {
    emit(UscProviderLoading());
    try {
      await FirebaseFirestore.instance
          .collection('UscProvider')
          .doc()
          .set(event.provider);
      QuerySnapshot providerSnap =
          await FirebaseFirestore.instance.collection('UscProvider').get();
      emit(UscProviderLoaded(providerSnap.docs.map((e) {
        Map<String, dynamic> data = e.data() as Map<String, dynamic>;
        return data;
      }).toList()));
    } catch (e, stacktrace) {
      print("_mapLoadProfileToState Error");
      print(e);
      print(stacktrace);
      emit(UscProviderError());
    }
  }

  void _mapDeleteUscProviderToState(
      DeleteUscProvider event, Emitter<UscProviderState> emit) async {
    emit(UscProviderLoading());
    try {
      QuerySnapshot collectionSnapshot = await FirebaseFirestore.instance
          .collection('UscProvider')
          .where("Title", isEqualTo: event.provider['Title'])
          .get();
      if (collectionSnapshot.docs.length > 0) {
        List<Future<void>> deleteFutures = [];

        for (var doc in collectionSnapshot.docs) {
          deleteFutures.add(
            FirebaseFirestore.instance
                .collection('UscProvider')
                .doc(doc.id)
                .delete(),
          );
        }

        await Future.wait(deleteFutures);
      }

      QuerySnapshot providerSnap =
          await FirebaseFirestore.instance.collection('UscProvider').get();

      emit(UscProviderLoaded(providerSnap.docs.map((e) {
        Map<String, dynamic> data = e.data() as Map<String, dynamic>;
        return data;
      }).toList()));
    } catch (e, stacktrace) {
      print("_mapDeleteUscProviderToState Error");
      print(e);
      print(stacktrace);
      emit(UscProviderError());
    }
  }
}
