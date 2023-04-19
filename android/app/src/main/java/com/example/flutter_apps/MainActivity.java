package com.example.flutter_apps;

import io.flutter.embedding.android.FlutterActivity;


 public class MainActivity extends FlutterActivity {
     private static final String CHANNEL = "samples.flutter.dev/battery";


    @Override
   public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
      GeneratedPluginRegistrant.registerWith(flutterEngine);
       new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
               .setMethodCallHandler(
                   (call, result) -> {
                      // Your existing code
               }
       );
   }
}
