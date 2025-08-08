import 'package:eni_svc/eni_svc.dart';
import 'package:eni_web/eni_web.dart';
import 'package:flutter/foundation.dart';

class _WebInteropPackage extends Package {
  @override
  String get name => "eni_web";

  @override
  void onRegister(ServiceRegistry services) {
    if (kIsWeb) {
      services.register(ServiceDescriptor.from<WebInteropService>(
          name: "WebInteropService", create: (_) => WebInteropService()));
    }
  }
}

/// Add the eni_web package integration to your Flutter project
extension ServiceRegistryWebInteropPackageExtension on MutableServiceRegistry {
  void addWebIntegration() {
    final package = _WebInteropPackage();

    register(ServiceDescriptor.from<Package>(
        name: package.name, create: (_) => package));
  }
}
