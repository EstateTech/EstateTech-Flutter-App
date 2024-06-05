import 'package:flutter/material.dart';
import 'package:web3modal_flutter/services/w3m_service/w3m_service.dart';
import 'package:web3modal_flutter/web3modal_flutter.dart';

class W3MServiceProvider extends ChangeNotifier {
  late W3MService _w3mService;
  bool _isConnected = false;
  String? _address;

  W3MServiceProvider() {
    _initializeService();
  }

  W3MService get w3mService => _w3mService;
  bool get isConnected => _isConnected;
  String? get address => _address;

  void _initializeService() async {
    _w3mService = W3MService(
      projectId: '1f1120e2db474a07ab3fba9087471cb1',
      metadata: const PairingMetadata(
        name: 'cryptoestateapp',
        description: 'Web3Modal Flutter Example',
        url: 'https://www.walletconnect.com/',
        icons: ['https://walletconnect.com/walletconnect-logo.png'],
        redirect: Redirect(
          native: 'w3m://',
          universal: 'https://www.walletconnect.com',
        ),
      ),
    );
    await _w3mService.init();
    notifyListeners();
  }

  Future<void> connect(BuildContext context) async {
    await _w3mService.openModal(context);
    _isConnected = true;
    await updateAddress(); // Update the address after connecting
    notifyListeners();
  }

  Future<void> disconnect() async {
    await _w3mService.disconnect();
    _isConnected = false;
    notifyListeners();
  }

  Future<void> updateAddress() async {
    String? addr = await _w3mService.address; // Handle nullable value
    if (addr != null) {
      _address = addr;
    } else {
      _address = 'Unknown Address';
    }
    notifyListeners();
  }
}
