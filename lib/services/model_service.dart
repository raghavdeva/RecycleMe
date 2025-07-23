import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart' show ByteData, rootBundle;
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:image/image.dart' as img; // For image manipulation

class ModelService {
  static Interpreter? _interpreter;
  static List<String>? _labels;
  static bool _modelLoaded = false;

  // --- Configuration (Adjust these based on your model's requirements) ---
  static const String _modelPath = 'asset/garbage_model.tflite';
  static const String _labelsPath = 'asset/labels.txt';
  static const int _inputSize = 224; // Example: if your model expects 224x224 images
  // static const double _inputMean = 0.0; // Example: if your model expects normalization around 0
  // static const double _inputStd = 255.0; // Example: if your model expects pixel values 0-255
  // For models trained with common frameworks like Keras/TF, mean is often 127.5 and std is 127.5 for [-1,1] normalization
  static const double _inputMean = 127.5;
  static const double _inputStd = 127.5;
  // --- End Configuration ---

  static Future<void> _loadModel() async {
    if (!_modelLoaded) {
      try {
        // Load the model
        _interpreter = await Interpreter.fromAsset(_modelPath);
        print('Interpreter loaded successfully');

        // Load the labels
        final labelsData = await rootBundle.loadString(_labelsPath);
        _labels = labelsData.split('\n').map((label) => label.trim()).where((label) => label.isNotEmpty).toList();
        print('Labels loaded successfully: $_labels');

        // You might need to allocate tensors if your model has dynamic input/output shapes,
        // but often it's not necessary if shapes are fixed in the model.
        // _interpreter.allocateTensors();

        _modelLoaded = true;
      } catch (e) {
        print('Error loading model or labels: $e');
        // Consider re-throwing or handling the error more gracefully
        rethrow;
      }
    }
  }

  static Future<String> classifyImage(File imageFile) async {
    await _loadModel();

    if (_interpreter == null || _labels == null) {
      return "Model or labels not loaded.";
    }

    try {
      // 1. Decode and Resize Image
      img.Image? image = img.decodeImage(imageFile.readAsBytesSync());
      if (image == null) {
        return "Could not decode image.";
      }
      img.Image resizedImage = img.copyResize(image, width: _inputSize, height: _inputSize);

      // 2. Convert Image to Byte Buffer (Input Tensor)
      // This depends heavily on your model's input requirements (float32, uint8, normalization, etc.)
      // Example for a Float32 model expecting values between -1 and 1 or 0 and 1
      var inputBytes = Float32List(_inputSize * _inputSize * 3); // Assuming RGB
      int pixelIndex = 0;
      for (int y = 0; y < _inputSize; y++) {
        for (int x = 0; x < _inputSize; x++) {
          img.Pixel pixel = resizedImage.getPixel(x, y);
          // Normalize pixel values (example for [-1, 1] range if mean=127.5, std=127.5)
          inputBytes[pixelIndex++] = (pixel.r - _inputMean) / _inputStd;
          inputBytes[pixelIndex++] = (pixel.g - _inputMean) / _inputStd;
          inputBytes[pixelIndex++] = (pixel.b - _inputMean) / _inputStd;
        }
      }
      // Reshape to [1, _inputSize, _inputSize, 3] - common for image models
      final input = inputBytes.reshape([1, _inputSize, _inputSize, 3]);

      // 3. Define Output Tensor
      // This depends on your model's output. Assuming it's a list of probabilities for each label.
      // Get output tensor shape and type from the interpreter
      var outputShape = _interpreter!.getOutputTensor(0).shape;
      var outputType = _interpreter!.getOutputTensor(0).type;
      print('Output shape: $outputShape, Output type: $outputType');


      // Assuming output is something like [1, numLabels] and Float32
      // Adjust the size based on _labels.length
      var output = List.filled(1 * _labels!.length, 0.0).reshape([1, _labels!.length]);
      // Or if outputType is different, e.g., Uint8List for Uint8 models

      // 4. Run Inference
      _interpreter!.run(input, output);

      // 5. Process Output
      // Assuming output[0] is a list of probabilities
      List<double> probabilities = output[0] as List<double>;

      double maxProbability = 0.0;
      int bestLabelIndex = -1;

      for (int i = 0; i < probabilities.length; i++) {
        if (probabilities[i] > maxProbability) {
          maxProbability = probabilities[i];
          bestLabelIndex = i;
        }
      }

      if (bestLabelIndex != -1 && bestLabelIndex < _labels!.length) {
        final label = _labels![bestLabelIndex];
        final confidence = (maxProbability * 100).toStringAsFixed(2);
        return "$label with $confidence% confidence";
      } else {
        return "Could not classify image (processing output failed).";
      }
    } catch (e) {
      print('Error during image classification: $e');
      return "Error during classification: $e";
    }
  }

  // Optional: Method to dispose of the interpreter when no longer needed
  static void dispose() {
    _interpreter?.close();
    _interpreter = null;
    _modelLoaded = false;
    _labels = null;
  }
}