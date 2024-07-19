import 'package:googleapis_auth/auth_io.dart';

class ServiceToken {
  Future getToken() async {
    final scope = [
      "https://www.googleapis.com/auth/userinfo.email",
      "https://www.googleapis.com/auth/firebase.database",
      "https://www.googleapis.com/auth/firebase.messaging",
    ];
    final client = await clientViaServiceAccount(
        ServiceAccountCredentials.fromJson({
          "type": "service_account",
          "project_id": "fir-storage-f913a",
          "private_key_id": "7c97e8d8459878684878db0fc9a8bbca757414a5",
          "private_key":
              "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQC7sN9stPSJfSMK\nMBjPa0I2z6qkksZLmzZgiUVYBx6rtG8tdtRIZNmjAAeDk0PX1f6s+Vqftlg7WuNO\nBaIP1TN62JKCDHnLhryem/NTD+JCoocl+O/76af/XFMq1EfasHF+Y8ssd6VZdGXr\n4Lhg8hJNzpTEIfUQxKPNEWeajNpvVPR9C1926/UM+jhUs2t8+F/SpwtKZBAb1O/Z\n6bglWUK1y+RWHtXXH8kdAV9aBl65GtGzjKIxlU72CAaoHncpJnzhENRONiYPxcFI\nod2gglxg/XO5sei2R8Fn+GWZrRsdYCutbWdKiv9WRWh+4SRlpnqs+pksf/rPukiV\nAd9+/W27AgMBAAECggEAF2ybzceIYg+zNlEfX4+i1rq0hiU9SJqpPti9m0le22Ns\nTAUcZEvrL4vQOZcWV1MWnZmMj7SPBBqz61Jfp1CJRBJ7DRj9KwNN+hDmMskfiLJx\nDIeqJ8tBqL3p2/AHZwnbTZYAeYnAd07EGPFVrDUPR2pPUxUWg+O5ZQgANp/P89Hf\nLWjevefVSlYA8u8Sh0pehhbsY4wcIsfml1arXIi6Xeu7BWsZNeVPmKEB2ksX+cEn\nR7TC6+F8jQ1OWvKcXrjup2oHKBqt/Al3bcyXetllRaqHfRep8hCzRkNEGNeNTpnE\nKR9DIIg8SFkbR8JrvI+Ii9hENLnQGeWse66svgtHrQKBgQDoMggsz7md7TBgEVDN\nreYOm/7iEoI7S/8dHhV6MPopEwxuW9qql6vO/4xU9FTVnAmnfYdEbhBsZyQk+hfX\nL6U9x/TazdqxfJML0oXvNV+FnEPuKMtuJfM0xlwohlXwJHXU1Y1nRIPmMZey/eDW\nH1Uz4PycnpBkINSg/592LpFMdQKBgQDO7tHYUMMTmgXYtrtfCalMlSEjPbgupLw+\n1URb/B7TUVtfosggeIKwFD8vnOFuK3npRm+eBXwTkj0I17OcI/fbp8poOQl+/vpT\nHzZAEwXU1MmNbGlKuKTiIYc3GWm+kDfDzcyTktisAZMvLDNax3rqpAIdzf/L5o8c\ngBdGc1tLbwKBgQDEQlXKmqGHrQ3whXJJBy2nN4+Owpo1SJ0PnXgF2hP4V9NwDE+d\nVamwwyt4OzThgIxgd6e33VggaGWSo5k3F1ySBcsejlTFJEid+4mdkP12T4jTasPY\nDFevSeJnlnRZEFhQV1i36p+aGFziu9go5D7+JLMgJp5hI6bVlnrQR7gkaQKBgEyn\nkRp1iF35f1LxFeW1uX5B+/2G/nRg187ax7DfazfSemup7EKDAb5iMancjnF2L3nn\neq9pzrWdRXjCFqmvdUBsHoGPJ2Jg56/k7v67TTyy+lqmHzbrwUB3NRSHGHHcEJw6\n3x6HljXZe4FM+VUWcgT7bkFGLwyEQt1G4dhaISaHAoGBAN3Fyf00OGY+tXmWh/23\nxVtC8z3GT2GsHCqLGFs23iTQkJyJGyi7BRjKO0eF6EmCVY/2rypaZACGwLux6ccJ\nyZivDYE1pEJV40ercNDlkIDlByZzB59bhB733yONoPMNAsZrFKXlAyZumCGlZ7CZ\naZ8/yPsqyn2WEMS4boaVjYzq\n-----END PRIVATE KEY-----\n",
          "client_email":
              "firebase-adminsdk-5xidi@fir-storage-f913a.iam.gserviceaccount.com",
          "client_id": "113813761608353143235",
          "auth_uri": "https://accounts.google.com/o/oauth2/auth",
          "token_uri": "https://oauth2.googleapis.com/token",
          "auth_provider_x509_cert_url":
              "https://www.googleapis.com/oauth2/v1/certs",
          "client_x509_cert_url":
              "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-5xidi%40fir-storage-f913a.iam.gserviceaccount.com",
          "universe_domain": "googleapis.com"
        }),
        scope);
    final accessServicekey = client.credentials.accessToken.data;
    print("..................... yo tocken ko data ho hai ..................");
    print(" yo token ho hai  $accessServicekey");
    return accessServicekey;
  }
}
