import 'package:flutter/material.dart';

const TextStyle kTextStyleArcadeClassic = TextStyle(
    fontFamily: 'ArcadeClassic',
    fontWeight: FontWeight.w400,
    fontSize: 16,
    color: Colors.white);

const TextStyle kTextStyleH1 = TextStyle(
    fontFamily: 'Manrope',
    fontWeight: FontWeight.w700,
    fontSize: 20,
    color: Colors.white);

const TextStyle kTextStyleH2 = TextStyle(
    fontFamily: 'Manrope',
    fontWeight: FontWeight.w600,
    fontSize: 18,
    color: Colors.white);

const TextStyle kTextStyleBody = TextStyle(
    fontFamily: 'Manrope',
    fontWeight: FontWeight.w400,
    fontSize: 16,
    color: Colors.white);

const TextStyle kTextStyleBody2 = TextStyle(
    fontFamily: 'Manrope',
    fontWeight: FontWeight.w400,
    height: 1.375,
    fontSize: 14,
    color: Colors.white);

const TextStyle kTextStyleSecondary = TextStyle(
    fontFamily: 'Manrope',
    fontWeight: FontWeight.w400,
    fontSize: 12,
    color: Colors.white);

const TextStyle kTextStyleGotham = TextStyle(
  fontFamily: 'GothamPro',
  color: Colors.white,
  fontSize: 24,
);
BoxDecoration kDebugDecoration =
    BoxDecoration(border: Border.all(color: Colors.purple), color: Colors.red);

const Color kColorCta = Color(0xff13B1E6);
const Color kColorDanger = Color(0xffff6961);
const Color kColorSuccess = Color(0xff00A86B);
const Color kColorGreySecondary = Color(0xffCCCCCC);

const LinearGradient kGradientG1 = LinearGradient(colors: [
  Color(0xff40D8FF),
  Color(0xff14BAE3),
  Color(0xff13B1E6),
  Color(0xff11AADF),
  Color(0xff0B98C5),
], stops: [
  0.0,
  0.19,
  0.69,
  0.82,
  1.0
]);

const String bodyText =
    'Helping Brands Create, Launch and Distribute NFTs to a non-web 3.0 audience';
const String ktextOnboarding3 =
    'NFT Apparel allows brands and projects to add utility to NFTs and on-board their community on Blockchain. Our novel solution allows users to control assets via a Web3 account or Email, and creates NFT Counterparts for Physical Luxury Products.';

//Hive Type IDs
const int kUSERDATA = 0;
const int kNFT = 1;
const int kHcNFT = 2;
const int kHcNFTList = 3;
const int kMerchandise = 4;
