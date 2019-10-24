import 'package:minesweeper_online/is_browser/vm.dart'
    if (dart.library.html) 'package:minesweeper_online/is_browser/js.dart' as runtime;

bool get isBrowser => runtime.isBrowser;
