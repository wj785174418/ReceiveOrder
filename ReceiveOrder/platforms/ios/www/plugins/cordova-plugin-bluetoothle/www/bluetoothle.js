cordova.define("cordova-plugin-bluetoothle.BluetoothLe", function(require, exports, module) {
var bluetoothleName = "BluetoothLePlugin";
var bluetoothle = {
  initialize: function(successCallback, params) {
    cordova.exec(successCallback, successCallback, bluetoothleName, "initialize", [params]);
  },
  enable: function(successCallback, errorCallback) {
    cordova.exec(successCallback, errorCallback, bluetoothleName, "enable", []);
  },
  disable: function(successCallback, errorCallback) {
    cordova.exec(successCallback, errorCallback, bluetoothleName, "disable", []);
  },
  startScan: function(successCallback, errorCallback, params) {
    cordova.exec(successCallback, errorCallback, bluetoothleName, "startScan", [params]);
  },
  stopScan: function(successCallback, errorCallback) {
    cordova.exec(successCallback, errorCallback, bluetoothleName, "stopScan", []);
  },
  retrieveConnected: function(successCallback, errorCallback, params) {
    cordova.exec(successCallback, errorCallback, bluetoothleName, "retrieveConnected", [params]);
  },
  connect: function(successCallback, errorCallback, params) {
    cordova.exec(successCallback, errorCallback, bluetoothleName, "connect", [params]);
  },
  reconnect: function(successCallback, errorCallback, params) {
    cordova.exec(successCallback, errorCallback, bluetoothleName, "reconnect", [params]);
  },
  disconnect: function(successCallback, errorCallback, params) {
    cordova.exec(successCallback, errorCallback, bluetoothleName, "disconnect", [params]);
  },
  close: function(successCallback, errorCallback, params) {
    cordova.exec(successCallback, errorCallback, bluetoothleName, "close", [params]);
  },
  discover: function(successCallback, errorCallback, params) {

    cordova.exec(successCallback, errorCallback, bluetoothleName, "discover", [params]);
  },
  services: function(successCallback, errorCallback, params) {
    cordova.exec(successCallback, errorCallback, bluetoothleName, "services", [params]);
  },
  characteristics: function(successCallback, errorCallback, params) {
    cordova.exec(successCallback, errorCallback, bluetoothleName, "characteristics", [params]);
  },
  descriptors: function(successCallback, errorCallback, params) {
    cordova.exec(successCallback, errorCallback, bluetoothleName, "descriptors", [params]);
  },
  read: function(successCallback, errorCallback, params) {
    cordova.exec(successCallback, errorCallback, bluetoothleName, "read", [params]);
  },
  subscribe: function(successCallback, errorCallback, params) {
    cordova.exec(successCallback, errorCallback, bluetoothleName, "subscribe", [params]);
  },
  unsubscribe: function(successCallback, errorCallback, params) {
    cordova.exec(successCallback, errorCallback, bluetoothleName, "unsubscribe", [params]);
  },
  write: function(successCallback, errorCallback, params) {
    cordova.exec(successCallback, errorCallback, bluetoothleName, "write", [params]);
  },
  writeTitle: function(successCallback, errorCallback, params) {
    cordova.exec(successCallback, errorCallback, bluetoothleName, "writeTitle", [params]);
  },
  readDescriptor: function(successCallback, errorCallback, params) {
    cordova.exec(successCallback, errorCallback, bluetoothleName, "readDescriptor", [params]);
  },
  writeDescriptor: function(successCallback, errorCallback, params) {
    cordova.exec(successCallback, errorCallback, bluetoothleName, "writeDescriptor", [params]);
  },
  rssi: function(successCallback, errorCallback, params) {
    cordova.exec(successCallback, errorCallback, bluetoothleName, "rssi", [params]);
  },
  mtu: function(successCallback, errorCallback, params) {
    cordova.exec(successCallback, errorCallback, bluetoothleName, "mtu", [params]);
  },
  isInitialized: function(successCallback) {
    cordova.exec(successCallback, successCallback, bluetoothleName, "isInitialized", []);
  },
  isEnabled: function(successCallback) {
    cordova.exec(successCallback, successCallback, bluetoothleName, "isEnabled", []);
  },
  isScanning: function(successCallback) {
    cordova.exec(successCallback, successCallback, bluetoothleName, "isScanning", []);
  },
  isConnected: function(successCallback, errorCallback, params) {
    cordova.exec(successCallback, errorCallback, bluetoothleName, "isConnected", [params]);
  },
  isDiscovered: function(successCallback, errorCallback, params) {
    cordova.exec(successCallback, errorCallback, bluetoothleName, "isDiscovered", [params]);
  },
  requestConnectionPriority: function(successCallback, errorCallback, params) {
    cordova.exec(successCallback, errorCallback, bluetoothleName, "requestConnectionPriority", [params]);
  },
  hasPermission: function(successCallback, errorCallback) {
    cordova.exec(successCallback, errorCallback, bluetoothleName, "hasPermission", []);
  },
  requestPermission: function(successCallback, errorCallback) {
    cordova.exec(successCallback, errorCallback, bluetoothleName, "requestPermission", []);
  },
  encodedStringToBytes: function(string) {
    var data = atob(string);
    var bytes = new Uint8Array(data.length);
    for (var i = 0; i < bytes.length; i++)
    {
      bytes[i] = data.charCodeAt(i);
    }
    return bytes;
  },
  bytesToEncodedString: function(bytes) {
    return btoa(String.fromCharCode.apply(null, bytes));
  },
  stringToBytes: function(string) {
    var bytes = new ArrayBuffer(string.length * 2);
    var bytesUint16 = new Uint16Array(bytes);
    for (var i = 0; i < string.length; i++) {
      bytesUint16[i] = string.charCodeAt(i);
    }
    return new Uint8Array(bytesUint16);
  },
               stringToBytes1:function(str){
               var ch, st, re = [];
               for (var i = 0; i < str.length; i++ ) {
               ch = str.charCodeAt(i);  // get char
               st = [];                 // set up "stack"
               do {
               st.push( ch & 0xFF );  // push byte to stack
               ch = ch >> 8;          // shift value down by 1 byte
               }
               while ( ch );
               // add stack contents to result
               // done because chars have "wrong" endianness
               re = re.concat( st.reverse() );  
               }  
               // return an array of bytes  
               return re;  
               },
  bytesToString: function(bytes) {
    return String.fromCharCode.apply(null, new Uint16Array(bytes));
  },
  SCAN_MODE_OPPORTUNISTIC: -1,
  SCAN_MODE_LOW_POWER: 0,
  SCAN_MODE_BALANCED: 1,
  SCAN_MODE_LOW_LATENCY: 2,
  MATCH_NUM_ONE_ADVERTISEMENT: 1,
  MATCH_NUM_FEW_ADVERTISEMENT: 2,
  MATCH_NUM_MAX_ADVERTISEMENT: 3,
  MATCH_MODE_AGGRESSIVE: 1,
  MATCH_MODE_STICKY: 2,
  CALLBACK_TYPE_ALL_MATCHES: 1,
  CALLBACK_TYPE_FIRST_MATCH: 2,
  CALLBACK_TYPE_MATCH_LOST: 4,
}
module.exports = bluetoothle;

});
