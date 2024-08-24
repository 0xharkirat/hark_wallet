class EtherWallet {
  final int id;
  final String privateKey;
  final String publicKey;
  final String path;
  final String mnemonic;

  EtherWallet({
    required this.id,
    required this.privateKey,
    required this.publicKey,
    required this.path,
    required this.mnemonic,
  });

  factory EtherWallet.fromJson(Map<String, dynamic> json) {
    return 
    EtherWallet(
      id: json['id'],
      privateKey: json['privateKey'],
      publicKey: json['publicKey'],
      path: json['path'],
      mnemonic: json['mnemonic'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'privateKey': privateKey,
      'publicKey': publicKey,
      'path': path,
      'mnemonic': mnemonic,
    };
  }

  @override
  String toString() {
    return 'Wallet{id: $id, privateKey: $privateKey, publicKey: $publicKey, path: $path, mnemonic: $mnemonic}';
  }

  
          
}
