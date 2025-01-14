import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class MainController {
  static var apiUrl = ''.obs;
  static var data = [
    {
      "id": 1,
      "name": "Kuvalis PLC Boarding House",
      "gender_restriction": "Bebas",
      "curfew": "08:25:00",
      "rules":
          "Quaerat aliquam reprehenderit voluptatem provident autem nulla veritatis.",
      "address": "522 Johnston Loaf\nNew Wayne, DC 42587-9780",
      "location": ["81.493594", "-14.364824"],
      "rooms": [
        {
          "id": 1,
          "size": "5x2",
          "price": "1637605.00",
          "availability": 1,
          "facilities": [
            {
              "id": 1,
              "facility": {"id": 7, "name": "Lemari"}
            },
            {
              "id": 2,
              "facility": {"id": 5, "name": "WC/Kamar Mandi"}
            }
          ],
          "description": "Amet officiis minus consequuntur autem sed rerum."
        },
        {
          "id": 2,
          "size": "3x4",
          "price": "1567130.00",
          "availability": 0,
          "facilities": [
            {
              "id": 3,
              "facility": {"id": 5, "name": "WC/Kamar Mandi"}
            },
            {
              "id": 4,
              "facility": {"id": 7, "name": "Lemari"}
            }
          ],
          "description": "Aut illo sit earum consequuntur sequi incidunt."
        },
        {
          "id": 3,
          "size": "5x3",
          "price": "2267689.00",
          "availability": 0,
          "facilities": [
            {
              "id": 5,
              "facility": {"id": 7, "name": "Lemari"}
            },
            {
              "id": 6,
              "facility": {"id": 5, "name": "WC/Kamar Mandi"}
            }
          ],
          "description": "Dolores et natus neque perferendis distinctio quidem."
        }
      ],
      "facilities": [
        {
          "id": 1,
          "facility": {"id": 3, "name": "Parkiran Motor"},
          "description":
              "Hic soluta esse voluptatem eaque recusandae accusamus."
        },
        {
          "id": 2,
          "facility": {"id": 4, "name": "Parkiran Mobil"},
          "description": "Illo ut commodi sit fuga maiores ipsum."
        }
      ],
      "description": "Magnam similique occaecati quis cum.",
      "image": "http://127.0.0.1:8000/storage/images/house/1.jpg"
    },
    {
      "id": 2,
      "name": "Hane, Wiegand and Vandervort Boarding House",
      "gender_restriction": "Khusus Putri",
      "curfew": "12:16:00",
      "rules":
          "Dolorem voluptas accusantium culpa nesciunt iste unde qui neque ut.",
      "address": "40495 Eldora Rapids Apt. 012\nAlveraburgh, DE 81112-2063",
      "location": ["33.296976", "64.107207"],
      "rooms": [
        {
          "id": 4,
          "size": "2x2",
          "price": "1480112.00",
          "availability": 1,
          "facilities": [
            {
              "id": 7,
              "facility": {"id": 6, "name": "TV"}
            },
            {
              "id": 8,
              "facility": {"id": 6, "name": "TV"}
            }
          ],
          "description":
              "Tenetur dolor est quia consequuntur tempore praesentium."
        },
        {
          "id": 5,
          "size": "3x3",
          "price": "1424470.00",
          "availability": 0,
          "facilities": [
            {
              "id": 9,
              "facility": {"id": 5, "name": "WC/Kamar Mandi"}
            },
            {
              "id": 10,
              "facility": {"id": 7, "name": "Lemari"}
            }
          ],
          "description": "Et et dolores libero dolorum itaque eos deserunt."
        },
        {
          "id": 6,
          "size": "2x4",
          "price": "2951034.00",
          "availability": 0,
          "facilities": [
            {
              "id": 11,
              "facility": {"id": 7, "name": "Lemari"}
            },
            {
              "id": 12,
              "facility": {"id": 6, "name": "TV"}
            }
          ],
          "description":
              "Corporis quidem odio voluptatum et harum natus commodi."
        }
      ],
      "facilities": [
        {
          "id": 3,
          "facility": {"id": 4, "name": "Parkiran Mobil"},
          "description": "Repellat debitis autem magni et quo facere."
        }
      ],
      "description": "Voluptatem vel soluta adipisci excepturi.",
      "image": "http://127.0.0.1:8000/storage/images/house/2.jpg"
    },
    {
      "id": 3,
      "name": "Rohan-Nader Boarding House",
      "gender_restriction": "Bebas",
      "curfew": "01:34:00",
      "rules":
          "Eos et voluptas tenetur enim maxime doloribus tenetur dicta sunt amet velit ut doloribus.",
      "address": "4396 Kylee Ville Apt. 203\nWest Georgetteshire, ID 29074",
      "location": ["-69.564766", "95.177552"],
      "rooms": [
        {
          "id": 7,
          "size": "4x5",
          "price": "2970056.00",
          "availability": 0,
          "facilities": [
            {
              "id": 13,
              "facility": {"id": 5, "name": "WC/Kamar Mandi"}
            },
            {
              "id": 14,
              "facility": {"id": 6, "name": "TV"}
            }
          ],
          "description": "Harum enim atque et voluptatem qui aliquid nam."
        },
        {
          "id": 8,
          "size": "4x2",
          "price": "1950876.00",
          "availability": 1,
          "facilities": [
            {
              "id": 15,
              "facility": {"id": 7, "name": "Lemari"}
            },
            {
              "id": 16,
              "facility": {"id": 7, "name": "Lemari"}
            }
          ],
          "description": "Laudantium vel aut ut velit harum."
        }
      ],
      "facilities": [
        {
          "id": 4,
          "facility": {"id": 2, "name": "Dapur"},
          "description":
              "Enim repellendus dicta expedita voluptatum et consequatur."
        }
      ],
      "description": "Voluptate et vero tempora fugiat vel voluptatem.",
      "image": "http://127.0.0.1:8000/storage/images/house/3.jpg"
    },
    {
      "id": 4,
      "name": "Glover, Schmitt and Torp Boarding House",
      "gender_restriction": "Khusus Putra",
      "curfew": "22:32:00",
      "rules": "Aut voluptatem accusantium qui quis sit earum repellendus.",
      "address": "580 Julio Knolls\nCollierfurt, MO 95365-7335",
      "location": ["80.528229", "-132.125294"],
      "rooms": [
        {
          "id": 9,
          "size": "5x4",
          "price": "2004469.00",
          "availability": 0,
          "facilities": [
            {
              "id": 17,
              "facility": {"id": 5, "name": "WC/Kamar Mandi"}
            },
            {
              "id": 18,
              "facility": {"id": 6, "name": "TV"}
            }
          ],
          "description": "Quia vitae reiciendis adipisci blanditiis ea cum."
        },
        {
          "id": 10,
          "size": "4x4",
          "price": "2084304.00",
          "availability": 0,
          "facilities": [
            {
              "id": 19,
              "facility": {"id": 7, "name": "Lemari"}
            },
            {
              "id": 20,
              "facility": {"id": 5, "name": "WC/Kamar Mandi"}
            }
          ],
          "description": "Hic et debitis et debitis."
        },
        {
          "id": 11,
          "size": "5x5",
          "price": "1990458.00",
          "availability": 0,
          "facilities": [
            {
              "id": 21,
              "facility": {"id": 6, "name": "TV"}
            },
            {
              "id": 22,
              "facility": {"id": 7, "name": "Lemari"}
            }
          ],
          "description": "Ut qui eligendi temporibus qui voluptate."
        }
      ],
      "facilities": [
        {
          "id": 5,
          "facility": {"id": 2, "name": "Dapur"},
          "description": "Omnis dolorem ut odit consequatur veritatis."
        },
        {
          "id": 6,
          "facility": {"id": 3, "name": "Parkiran Motor"},
          "description": "Repellat occaecati consequatur sit enim ipsum."
        }
      ],
      "description": "Mollitia quia dolorum minima et.",
      "image": "http://127.0.0.1:8000/storage/images/house/4.jpg"
    },
    {
      "id": 5,
      "name": "Stamm Inc Boarding House",
      "gender_restriction": "Bebas",
      "curfew": "21:39:00",
      "rules": "Nulla aperiam repudiandae nemo sunt ad ex non.",
      "address": "160 Schultz Circle\nDeanfort, NH 94149-8298",
      "location": ["30.893192", "-123.207941"],
      "rooms": [
        {
          "id": 12,
          "size": "4x3",
          "price": "2419813.00",
          "availability": 1,
          "facilities": [
            {
              "id": 23,
              "facility": {"id": 7, "name": "Lemari"}
            },
            {
              "id": 24,
              "facility": {"id": 5, "name": "WC/Kamar Mandi"}
            }
          ],
          "description": "Sed commodi amet numquam praesentium dolorem."
        }
      ],
      "facilities": [
        {
          "id": 7,
          "facility": {"id": 2, "name": "Dapur"},
          "description": "Consequatur fugit placeat possimus totam et."
        },
        {
          "id": 8,
          "facility": {"id": 3, "name": "Parkiran Motor"},
          "description": "Possimus totam quasi tenetur."
        }
      ],
      "description": "Eligendi reiciendis corporis unde.",
      "image": "http://127.0.0.1:8000/storage/images/house/5.jpg"
    }
  ];
  
  static var dataDetail = {
    "id": 1,
    "name": "Kuvalis PLC Boarding House",
    "gender_restriction": "Bebas",
    "curfew": "08:25:00",
    "rules":
        "Quaerat aliquam reprehenderit voluptatem provident autem nulla veritatis.",
    "address": "522 Johnston Loaf\nNew Wayne, DC 42587-9780",
    "location": ["81.493594", "-14.364824"],
    "rooms": [
      {
        "id": 1,
        "room_number": "1",
        "size": "5x2",
        "price": "1637605.00",
        "availability": 1,
        "facilities": [
          {
            "id": 1,
            "facility": {"id": 7, "name": "Lemari"}
          },
          {
            "id": 2,
            "facility": {"id": 5, "name": "WC/Kamar Mandi"}
          }
        ],
        "description": "Amet officiis minus consequuntur autem sed rerum."
      },
      {
        "id": 2,
        "room_number": "2",
        "size": "3x4",
        "price": "1567130.00",
        "availability": 0,
        "facilities": [
          {
            "id": 3,
            "facility": {"id": 5, "name": "WC/Kamar Mandi"}
          },
          {
            "id": 4,
            "facility": {"id": 7, "name": "Lemari"}
          }
        ],
        "description": "Aut illo sit earum consequuntur sequi incidunt."
      },
      {
        "id": 3,
        "room_number": "3",
        "size": "5x3",
        "price": "2267689.00",
        "availability": 0,
        "facilities": [
          {
            "id": 5,
            "facility": {"id": 7, "name": "Lemari"}
          },
          {
            "id": 6,
            "facility": {"id": 5, "name": "WC/Kamar Mandi"}
          }
        ],
        "description": "Dolores et natus neque perferendis distinctio quidem."
      }
    ],
    "facilities": [
      {
        "id": 1,
        "facility": {"id": 3, "name": "Parkiran Motor"},
        "description": "Hic soluta esse voluptatem eaque recusandae accusamus."
      },
      {
        "id": 2,
        "facility": {"id": 4, "name": "Parkiran Mobil"},
        "description": "Illo ut commodi sit fuga maiores ipsum."
      }
    ],
    "description": "Magnam similique occaecati quis cum.",
    "image": "http://127.0.0.1:8000/storage/images/house/1.jpg"
  };

  static SharedPreferences? _prefs;

  //funtion for save boolean to SharedPreferences
  static Future<void> saveBool(String key, bool value) async {
    _prefs ??= await SharedPreferences.getInstance();
    await _prefs!.setBool(key, value);
  }

  static Future<bool> loadSavedBool(String key) async {
    _prefs ??= await SharedPreferences.getInstance();
    return _prefs!.getBool(key) ?? false;
  }

  static Future<void> saveUrl(String url) async {
    _prefs ??= await SharedPreferences.getInstance();
    await _prefs!.setString('apiUrl', url);
    apiUrl.value = url;
  }

  static Future<String> loadSavedUrl() async {
    _prefs ??= await SharedPreferences.getInstance();
    return _prefs!.getString('apiUrl') ?? '';
  }

  static Future<bool> checkApiConnection(String url) async {
    try {
      final response = await http.get(Uri.parse('$url/api/check-connection'));

      if (response.statusCode == 200) {
        await saveUrl(url);
        return true;
      } else {
        throw Exception('Invalid API response');
      }
    } catch (e) {
      return false;
    }
  }
}
