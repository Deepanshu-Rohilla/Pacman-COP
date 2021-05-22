import 'package:flutter/material.dart';
import 'homepage.dart';

List<int> scores = [];
List<bool> gamePlayed = [];
bool customImage = false;
String customImagePath = '';

List<List<int>> gameBarriers = [
  //Easy
  [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 21, 32, 43, 54, 65, 76, 87, 98, 109, 120, 131, 142, 153, 164, 175, 174, 173, 172, 171, 170, 169, 168, 167, 166, 165, 154, 143, 132, 121, 110, 99, 88, 77, 66, 55, 44, 33, 22, 11, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 21, 22, 24, 30, 32, 33, 37, 38, 43, 44, 48, 49, 54, 55, 65, 66, 76, 77, 80, 81, 82, 83, 87, 88, 91, 92, 93, 94, 98, 99, 109, 110, 120, 121, 125, 126, 131, 132, 136, 137, 142, 143, 145, 151, 153, 154, 164, 165, 166, 167, 168, 169, 170, 171, 172, 173, 174, 175],
  [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 21, 32, 43, 54, 65, 76, 87, 98, 109, 120, 131, 142, 153, 164, 175, 174, 173, 172, 171, 170, 169, 168, 167, 166, 165, 154, 143, 132, 121, 110, 99, 88, 77, 66, 55, 44, 33, 22, 11, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 21, 22, 32, 33, 35, 41, 43, 44, 54, 55, 59, 60, 61, 65, 66, 70, 71, 72, 76, 77, 81, 82, 83, 97, 88, 92, 93, 94, 98, 99, 109, 110, 112, 118, 120, 121, 131, 132, 142, 143, 153, 154, 164, 165, 166, 167, 168, 169, 170, 171, 172, 173, 174, 175],
  [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 21, 32, 43, 54, 65, 76, 87, 98, 109, 120, 131, 142, 153, 164, 175, 174, 173, 172, 171, 170, 169, 168, 167, 166, 165, 154, 143, 132, 121, 110, 99, 88, 77, 66, 55, 44, 33, 22, 11, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 21, 22, 32, 33, 43, 44, 54, 55, 65, 66, 76, 77, 97, 88, 98, 99, 109, 110, 120, 121, 131, 132, 142, 143, 153, 154, 164, 165, 166, 167, 168, 169, 170, 171, 172, 173, 174, 175],
  [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 21, 32, 43, 54, 65, 76, 87, 98, 109, 120, 131, 142, 153, 164, 175, 174, 173, 172, 171, 170, 169, 168, 167, 166, 165, 154, 143, 132, 121, 110, 99, 88, 77, 66, 55, 44, 33, 22, 11, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 21, 22, 32, 33, 35, 36, 40, 41, 43, 44, 47, 51, 54, 55, 59, 60, 61, 65, 66, 70, 71, 72, 76, 77, 81, 82, 83, 97, 88, 92, 93, 94, 98, 99, 102, 106, 109, 110, 112, 113, 117, 118, 120, 121, 131, 132, 142, 143, 153, 154, 164, 165, 166, 167, 168, 169, 170, 171, 172, 173, 174, 175],
  [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 21, 32, 43, 54, 65, 76, 87, 98, 109, 120, 131, 142, 153, 164, 175, 174, 173, 172, 171, 170, 169, 168, 167, 166, 165, 154, 143, 132, 121, 110, 99, 88, 77, 66, 55, 44, 33, 22, 11, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 21, 22, 24, 30, 32, 33, 37, 38, 43, 44, 48, 49, 54, 55, 59, 60, 65, 66, 70, 71, 76, 77, 80, 81, 82, 83, 87, 88, 91, 92, 93, 94, 98, 99, 103, 104, 109, 110, 114, 115, 120, 121, 125, 126, 131, 132, 136, 137, 142, 143, 145, 151, 153, 154, 164, 165, 166, 167, 168, 169, 170, 171, 172, 173, 174, 175],

  //Medium
  [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 21, 32, 43, 54, 65, 76, 87, 98, 109, 120, 131, 142, 153, 164, 175, 174, 173, 172, 171, 170, 169, 168, 167, 166, 165, 154, 143, 132, 121, 110, 99, 88, 77, 66, 55, 44, 33, 22, 11, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 22, 33, 44, 55, 66, 77, 99, 110, 121, 132, 143, 154, 165, 167, 168, 169, 170, 171, 172, 173, 174, 175, 164, 153, 142, 131, 120, 109, 87, 76, 65, 54, 43, 32, 21, 78, 79, 80, 100, 101, 102, 84, 85, 86, 106, 107, 108, 24, 35, 46, 57, 30, 41, 52, 63, 81, 70, 59, 61, 72, 83, 26, 28, 37, 38, 39, 123, 134, 145, 129, 140, 151, 103, 114, 125, 105, 116, 127, 147, 148, 149],
  [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 21, 32, 43, 54, 65, 76, 87, 98, 109, 120, 131, 142, 153, 164, 175, 174, 173, 172, 171, 170, 169, 168, 167, 166, 165, 154, 143, 132, 121, 110, 99, 88, 77, 66, 55, 44, 33, 22, 11, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 21, 22, 27, 32, 33, 43, 44, 46, 47, 48, 49, 50, 51, 52, 54, 55, 65, 66, 76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 87, 88, 98, 99, 101, 102, 103, 105, 106, 107, 108, 109, 110, 120, 121, 122, 131, 132, 133, 137, 140, 142, 143, 148, 153, 154, 158, 160, 162, 164, 165, 166, 167, 168, 169, 170, 171, 172, 173, 174, 175],
  [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 21, 32, 43, 54, 65, 76, 87, 98, 109, 120, 131, 142, 153, 164, 175, 174, 173, 172, 171, 170, 169, 168, 167, 166, 165, 154, 143, 132, 121, 110, 99, 88, 77, 66, 55, 44, 33, 22, 11, 0, 4, 5, 6, 7, 8, 9, 10, 11, 13, 15, 21, 22, 24, 26, 32, 33, 35, 37, 41, 43, 44, 46, 52, 54, 55, 57, 59, 61, 65, 66, 68, 70, 72, 75, 76, 77, 79, 81, 83, 85, 87, 88, 92, 94, 96, 98, 99, 101, 103, 109, 110, 112, 114, 116, 118, 120, 121, 123, 125, 127, 129, 131, 132, 134, 136, 138, 142, 143, 145, 149, 152, 153, 154, 156, 159, 160, 163, 164, 165, 171, 175],
  [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 21, 32, 43, 54, 65, 76, 87, 98, 109, 120, 131, 142, 153, 164, 175, 174, 173, 172, 171, 170, 169, 168, 167, 166, 165, 154, 143, 132, 121, 110, 99, 88, 77, 66, 55, 44, 33, 22, 11, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 22, 23, 24, 25, 28, 29, 30, 32, 33, 44, 48, 49, 55, 59, 60, 65, 78, 79, 80, 81, 83, 86, 94, 95, 96, 97, 99, 100, 103, 110, 113, 120, 121, 124, 127, 131, 132, 137, 143, 144, 149, 154, 155, 158, 159, 160, 161, 162, 163, 164, 165, 166, 167, 168, 169, 170, 171, 172, 173, 174, 175],
  [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 21, 32, 43, 54, 65, 76, 87, 98, 109, 120, 131, 142, 153, 164, 175, 174, 173, 172, 171, 170, 169, 168, 167, 166, 165, 154, 143, 132, 121, 110, 99, 88, 77, 66, 55, 44, 33, 22, 11, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 21, 22, 24, 30, 32, 33, 37, 38, 43, 44, 48, 49, 54, 55, 65, 66, 76, 77, 80, 81, 82, 83, 87, 88, 91, 92, 93, 94, 98, 99, 109, 110, 120, 121, 125, 126, 131, 132, 136, 137, 142, 143, 145, 151, 153, 154, 164, 165, 166, 167, 168, 169, 170, 171, 172, 173, 174, 175],

  //Hard
  [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 21, 32, 43, 54, 65, 76, 87, 98, 109, 120, 131, 142, 153, 164, 175, 174, 173, 172, 171, 170, 169, 168, 167, 166, 165, 154, 143, 132, 121, 110, 99, 88, 77, 66, 55, 44, 33, 22, 11, 2, 7, 10, 11, 20, 23, 25, 28, 30, 34, 36, 39, 41, 45, 46, 47, 50, 51, 52, 57, 62, 70, 77, 80, 82, 87, 89, 93, 97, 101, 105, 106, 112, 117, 120, 122, 124, 127, 129, 131, 133, 135, 138, 140, 154, 158, 159, 163, 164, 165, 169, 170, 174, 175],
  [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 21, 32, 43, 54, 65, 76, 87, 98, 109, 120, 131, 142, 153, 164, 175, 174, 173, 172, 171, 170, 169, 168, 167, 166, 165, 154, 143, 132, 121, 110, 99, 88, 77, 66, 55, 44, 33, 22, 11, 0, 1, 2, 7, 8, 10, 16, 19, 24, 26, 28, 30, 33, 34, 35, 41, 43, 57, 59, 61, 63, 69, 73, 75, 81, 82, 83, 88, 93, 98, 99, 103, 104, 105, 109, 113, 117, 123, 129, 133, 137, 145, 149, 151, 157, 161, 164, 165, 169, 170, 171, 174, 175],
  [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 21, 32, 43, 54, 65, 76, 87, 98, 109, 120, 131, 142, 153, 164, 175, 174, 173, 172, 171, 170, 169, 168, 167, 166, 165, 154, 143, 132, 121, 110, 99, 88, 77, 66, 55, 44, 33, 22, 11, 0, 2, 5, 6, 10, 20, 23, 24, 25, 26, 29, 37, 40, 42, 44, 46, 48, 51, 53, 59, 62, 65, 67, 68, 69, 70, 71, 72, 73, 78, 81, 86, 87, 89, 92, 94, 97, 98, 100, 103, 108, 109, 111, 114, 115, 116, 117, 134, 135, 141, 148, 150, 156, 160, 165, 166, 171, 174, 175],
  [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 21, 32, 43, 54, 65, 76, 87, 98, 109, 120, 131, 142, 153, 164, 175, 174, 173, 172, 171, 170, 169, 168, 167, 166, 165, 154, 143, 132, 121, 110, 99, 88, 77, 66, 55, 44, 33, 22, 11, 0, 2, 3, 4, 5, 6, 7, 8, 10, 23, 24, 26, 28, 30, 31, 34, 35, 38, 48, 49, 50, 54, 55, 58, 62, 66, 68, 74, 77, 82, 85, 88, 90, 96, 99, 102, 106, 110, 114, 116, 119, 133, 134, 137, 141, 142, 144, 148, 153, 156, 164, 165, 167, 169, 171, 174, 175],
  [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 21, 32, 43, 54, 65, 76, 87, 98, 109, 120, 131, 142, 153, 164, 175, 174, 173, 172, 171, 170, 169, 168, 167, 166, 165, 154, 143, 132, 121, 110, 99, 88, 77, 66, 55, 44, 33, 22, 11, 0, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 14, 18, 22, 23, 25, 27, 32, 33, 36, 38, 40, 43, 44, 46, 47, 49, 52, 55, 58, 64, 66, 69, 71, 74, 77, 79, 80, 82, 84, 88, 92, 94, 98, 99, 100, 102, 106, 110, 118, 120, 121, 123, 124, 128, 132, 143, 145, 147, 149, 150, 153, 154, 156, 160, 165, 166, 167, 169, 170, 171, 172, 173, 174],
];

List<List<int>> simulationBarriers = [
  [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 13, 15, 21, 22, 24, 26, 32, 33, 35, 37, 41, 43, 44, 46, 52, 54, 55, 57, 59, 61, 65, 66, 68, 70, 72, 75, 76, 77, 79, 81, 83, 85, 87, 88, 92, 94, 96, 98, 99, 101, 103, 109, 110, 112, 114, 116, 118, 120, 121, 123, 125, 127, 129, 131, 132, 134, 136, 138, 142, 143, 145, 149, 152, 153, 154, 156, 159, 160, 163, 164, 165, 166, 167, 168, 169, 170, 171, 172, 173, 174, 175],
  [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 21, 22, 27, 32, 33, 43, 44, 46, 47, 48, 49, 50, 51, 52, 54, 55, 65, 66, 76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 87, 88, 98, 99, 101, 102, 103, 105, 106, 107, 108, 109, 110, 120, 121, 122, 131, 132, 133, 137, 140, 142, 143, 148, 153, 154, 158, 160, 162, 164, 165, 166, 167, 168, 169, 170, 171, 172, 173, 174, 175],
  [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 21, 22, 32, 33, 35, 41, 43, 44, 54, 55, 59, 60, 61, 65, 66, 70, 71, 72, 76, 77, 81, 82, 83, 97, 88, 92, 93, 94, 98, 99, 109, 110, 112, 118, 120, 121, 131, 132, 142, 143, 153, 154, 164, 165, 166, 167, 168, 169, 170, 171, 172, 173, 174, 175],
  [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 21, 22, 24, 30, 32, 33, 37, 38, 43, 44, 48, 49, 54, 55, 65, 66, 76, 77, 80, 81, 82, 83, 87, 88, 91, 92, 93, 94, 98, 99, 109, 110, 120, 121, 125, 126, 131, 132, 136, 137, 142, 143, 145, 151, 153, 154, 164, 165, 166, 167, 168, 169, 170, 171, 172, 173, 174, 175],
  [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 21, 22, 23, 24, 26, 28, 30, 31, 32, 33, 34, 35, 38, 43, 44, 48, 49, 50, 54, 55, 58, 62, 65, 66, 68, 74, 76, 77, 82, 85, 87, 88, 90, 96, 98, 99, 102, 106, 109, 110, 114, 116, 119, 120, 121, 131, 132, 133, 134, 137, 141, 142, 143, 144, 148, 153, 154, 156, 164, 165, 166, 167, 168, 169, 170, 171, 172, 173, 174, 175]
];
List<List<int>> simulationStones = [
  [36, 84, 86, 137],
  [20, 25, 62, 69, 124, 139],
  [23, 31, 38, 122, 130],
  [12, 20, 107, 135, 155, 163],
  [39, 45, 61, 115, 145, 151]
];

List<int> simulationSource = [122, 12, 68, 59, 12];
List<int> simulationDestination = [141, 13, 163, 104, 93];
List<List<int>> shortestPath = [
  [122, 111, 100, 89, 90, 91, 80, 69, 58, 47, 36, 47, 48, 49, 50, 51, 62, 73, 84, 95, 106, 105, 104, 115, 126, 137, 126, 115, 104, 105, 106, 107, 108, 97, 86, 97, 108, 119, 130, 141],
  [12, 23, 34, 45, 56, 57, 58, 69, 58, 59, 60, 61, 62, 63, 64, 75, 86, 97, 96, 95, 94, 93, 104, 115, 126, 125, 124, 125, 126, 127, 128, 139, 128, 117, 116, 115, 104, 93, 94, 95, 96, 97, 86, 75, 64, 53, 42, 31, 20, 19, 18, 17, 16, 15, 26, 25, 14, 13],
  [68, 57, 46, 47, 36, 37, 38, 27, 28, 29, 30, 31, 30, 29, 28, 27, 26, 25, 24, 23, 34, 45, 56, 67, 78, 89, 100, 111, 122, 123, 124, 125, 126, 127, 128, 129, 130, 141, 152, 163],
  [59, 58, 47, 36, 25, 14, 13, 12, 12, 13, 14, 15, 16, 17, 18, 19, 20, 20, 31, 42, 53, 64, 75, 86, 97, 108, 107, 107, 108, 119, 130, 141, 152, 163, 163, 162, 161, 160, 159, 158, 157, 156, 155, 155, 144, 133, 134, 135, 135, 124, 113, 102, 103, 104],
  [12, 13, 14, 15, 16, 17, 18, 29, 40, 39, 40, 29, 18, 17, 16, 15, 14, 25, 36, 47, 46, 45, 56, 67, 78, 89, 100, 101, 112, 113, 124, 135, 146, 145, 146, 147, 158, 159, 160, 149, 150, 151, 140, 129, 128, 127, 126, 115, 104, 93, 94, 83, 72, 61, 72, 83, 94, 93]
];

List<List<int>> tspPath = [
  [122, 111, 100, 89, 90, 91, 80, 69, 58, 47, 36, 36, 47, 48, 49, 50, 51, 62, 73, 84, 84, 95, 106, 107, 108, 97, 86, 86, 97, 108, 107, 106, 105, 104, 115, 126, 137, 137, 148, 147, 146, 135, 124, 113, 102, 91, 90, 89, 100, 111, 122],
  [12, 23, 34, 45, 56, 57, 58, 69, 69, 58, 59, 60, 61, 62, 62, 63, 64, 75, 86, 97, 96, 95, 94, 93, 104, 115, 126, 125, 124, 124, 125, 126, 127, 128, 139, 139, 128, 117, 116, 115, 104, 93, 94, 95, 96, 97, 86, 75, 64, 53, 42, 31, 20, 20, 19, 18, 17, 16, 15, 26, 25, 25, 14, 13, 12],
  [68, 57, 46, 45, 34, 23, 23, 24, 25, 26, 27, 38, 38, 27, 28, 29, 30, 31, 31, 42, 53, 64, 75, 86, 85, 96, 107, 108, 119, 130, 130, 129, 128, 127, 126, 125, 124, 123, 122, 122, 111, 100, 89, 78, 67, 68],
  [59, 58, 47, 36, 25, 14, 13, 12, 12, 13, 14, 15, 16, 17, 18, 19, 20, 20, 31, 42, 53, 64, 75, 86, 97, 108, 107, 107, 108, 119, 130, 141, 152, 163, 163, 162, 161, 160, 159, 158, 157, 156, 155, 155, 144, 133, 134, 135, 135, 124, 113, 102, 101, 90, 79, 68, 57, 58, 59],
  [12, 13, 14, 15, 16, 17, 18, 29, 40, 39, 39, 40, 41, 42, 53, 64, 75, 86, 97, 108, 107, 118, 129, 140, 151, 151, 162, 161, 160, 159, 158, 147, 146, 145, 145, 146, 135, 124, 125, 126, 115, 115, 104, 93, 94, 83, 72, 61, 61, 72, 71, 70, 81, 80, 79, 78, 67, 56, 45, 45, 46, 47, 36, 25, 14, 13, 12]
];
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
