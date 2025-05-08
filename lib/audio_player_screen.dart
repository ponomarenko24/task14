import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class AudioPlayerScreen extends StatefulWidget {
  const AudioPlayerScreen({super.key});

  @override
  State<AudioPlayerScreen> createState() => _AudioPlayerScreenState();
}

class _AudioPlayerScreenState extends State<AudioPlayerScreen> {
  late AudioPlayer _audioPlayer;
  double _volume = 0.5;
  bool _isLooping = true;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _initAudio();

    _audioPlayer.playerStateStream.listen((state) {
      setState(() {
        _isPlaying = state.playing;
      });
    });
  }

  Future<void> _initAudio() async {
    try {
      await _audioPlayer.setUrl(
        'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3',
      );
      _audioPlayer.setLoopMode(LoopMode.one);
    } catch (e) {
      print("error: $e");
    }
  }

  void _togglePlayPause() {
    _isPlaying ? _audioPlayer.pause() : _audioPlayer.play();
  }

  void _toggleLoop() {
    setState(() {
      _isLooping = !_isLooping;
      _audioPlayer.setLoopMode(_isLooping ? LoopMode.one : LoopMode.off);
    });
  }

  void _setVolume(double volume) {
    setState(() {
      _volume = volume;
      _audioPlayer.setVolume(volume);
    });
  }

  @override
  void dispose() {
    _audioPlayer.stop();
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Audio player')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow, size: 64),
              onPressed: _togglePlayPause,
            ),
            const SizedBox(height: 20),
            Slider(
              value: _volume,
              min: 0,
              max: 1,
              divisions: 10,
              label: 'Volume: ${(_volume * 100).round()}%',
              onChanged: _setVolume,
            ),
            const SizedBox(height: 20),
            SwitchListTile(
              title: const Text('Replay'),
              value: _isLooping,
              onChanged: (value) => _toggleLoop(),
            ),
          ],
        ),
      ),
    );
  }
}
