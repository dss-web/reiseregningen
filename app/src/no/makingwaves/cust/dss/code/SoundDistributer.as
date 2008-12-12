package no.makingwaves.cust.dss.code
{
	import flash.events.EventDispatcher;
	import flash.media.SoundChannel;
	
	import mx.resources.ResourceManager;
	
	import no.makingwaves.components.media.sound.SoundPlayer;
	import no.makingwaves.cust.dss.model.ModelLocator;
	
	public class SoundDistributer extends EventDispatcher
	{
		
		private var _player:SoundPlayer = new SoundPlayer();
		private var _soundPlaying:SoundChannel;
				
		public function SoundDistributer() {}
		
		public function playSound(soundLocaleId:String=""):void {
			if (soundLocaleId != "") {
				// stop any playing sound
				stopSound();
				// create new player with correct url and play
				var soundUrl:String = ResourceManager.getInstance().getString(ModelLocator.getInstance().resources.getResourceBundleName(), soundLocaleId);
				if (soundUrl != "" && soundUrl != null) {
					_player = new SoundPlayer(soundUrl);
					_soundPlaying = _player.play();
				}
				
			} else if (_player.url != "") {
				// restart last played sound
				_player.play();
			}
		}
		
		public function stopSound():void {
			if (_soundPlaying) {
				_soundPlaying.stop();
			}
		}

	}
}