import 'package:fastdarktheme/example/blocs/color_cubit.dart';
import 'package:fastdarktheme/example/blocs/mode.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CounterBloc', () {
    late ColorCubit colorBloc;

    setUp(() {
      colorBloc = ColorCubit();
    });

    test('initial state', () {
      expect(colorBloc.state.mode, Mode.WhatsApp);
    });
  });
}
