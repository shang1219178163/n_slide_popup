# n_slide_popup
A pop-up window that supports appearing in any direction, it is popup, sheet, dialog, alert, drawer, popup...

## Getting started

  n_slide_popup: ^0.0.2

## Usage

```dart
import 'package:n_slide_popup/n_slide_popup.dart';
```

```dart
  Future<void> onPopupRoute() async {
    final route = NSlidePopupRoute(
      from: alignment,
      builder: (_) {
        return buildPopupView(alignment: alignment, argsDismiss: {"b": "88"});
      },
    );
    final result = await Navigator.of(context).push(route);
    print(["result", result.runtimeType, result]);
  }

  Widget buildPopupView({required Alignment alignment, Map<String, dynamic>? argsDismiss}) {
    return Align(
      alignment: alignment,
      child: Container(
        width: 300,
        height: 400,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.green,
          border: Border.all(color: Colors.blue),
          borderRadius: BorderRadius.all(Radius.circular(0)),
        ),
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop(argsDismiss);
          },
          child: Text("dismiss"),
        ),
      ),
    );
  }
```


![](https://github.com/shang1219178163/n_slide_popup/blob/main/example/assets/images/Simulator%20Screenshot%20-%20iPhone%2016%20-%202025-12-27%20at%2011.36.41.png?raw=true)


![](https://github.com/shang1219178163/n_slide_popup/blob/main/example/assets/images/Simulator%20Screenshot%20-%20iPhone%2016%20-%202025-12-27%20at%2011.36.43.png?raw=true)

![](https://github.com/shang1219178163/n_slide_popup/blob/main/example/assets/images/Simulator%20Screenshot%20-%20iPhone%2016%20-%202025-12-27%20at%2011.36.45.png?raw=true)

![](https://github.com/shang1219178163/n_slide_popup/blob/main/example/assets/images/Simulator%20Screenshot%20-%20iPhone%2016%20-%202025-12-27%20at%2011.36.51.png?raw=true)

![](https://github.com/shang1219178163/n_slide_popup/blob/main/example/assets/images/Simulator%20Screenshot%20-%20iPhone%2016%20-%202025-12-27%20at%2011.36.53.png?raw=true)
![](https://github.com/shang1219178163/n_slide_popup/blob/main/example/assets/images/Simulator%20Screenshot%20-%20iPhone%2016%20-%202025-12-27%20at%2011.36.59.png?raw=true)
![](https://github.com/shang1219178163/n_slide_popup/blob/main/example/assets/images/Simulator%20Screenshot%20-%20iPhone%2016%20-%202025-12-27%20at%2011.37.01.png?raw=true)
![](https://github.com/shang1219178163/n_slide_popup/blob/main/example/assets/images/Simulator%20Screenshot%20-%20iPhone%2016%20-%202025-12-27%20at%2011.37.04.png?raw=true)
