import 'package:flutter/material.dart';

const kAppName = "ITEXStore";
const kDatabaseName = "ITEXStore_DBv1.db";
// const kBaseEndpoint = "https://store-api.itexapp.com";
// const kWSBaseEndpoint = "wss://store-api.itexapp.com/api/ws";

// const kBaseEndpoint = "http://54.203.193.56:9090";
// const kWSBaseEndpoint = "ws://54.203.193.56:9090/api/ws";

const kBaseEndpoint = "http://192.168.8.100:9090";
const kWSBaseEndpoint = "ws://192.168.8.100:9090/api/ws";

const Color kBaseColor = Color(0xff002A4C);
const Color kBaseGreenColor = Color(0xff39bd7c);

MaterialColor kBaseMaterialColor = MaterialColor(
  kBaseColor.value, // Primary color value
  <int, Color>{
    50: kBaseColor.withOpacity(0.1),
    100: kBaseColor.withOpacity(0.2),
    200: kBaseColor.withOpacity(0.3),
    300: kBaseColor.withOpacity(0.4),
    400: kBaseColor.withOpacity(0.5),
    500: kBaseColor.withOpacity(0.6),
    600: kBaseColor.withOpacity(0.7),
    700: kBaseColor.withOpacity(0.8),
    800: kBaseColor.withOpacity(0.9),
    900: kBaseColor.withOpacity(1.0),
  },
);
const kApiToken =
    "q3QreaNLqJzSp5SGVw/dUH/zMQlVo1HthfXkkGS1iP1xKWe2WwLPOFd4PErm/makjhsE6nBxDMETeCY2CBZ81dlBiFn7CVCSridhn/BQwo7L2ZT9gZRV8RbyV9/IH4GZ+UZYHg==";
const kSecretKey =
    "WnxuisbwCzbX4S5BYPl/dnOF5c7Mf+mPqjxTx6dZXC2JizxVYcMOcVw3+7TcoryzU2s1yHcu+sTPZz8GOj2Du5H8FXv6bnFwjECugHBq/463BwCBJvw8uAMXmjbvj9P4lzb3HA==";
