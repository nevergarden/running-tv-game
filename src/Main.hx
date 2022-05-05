package;

import h2d.Bitmap;
import h2d.Layers;
import hxd.App;

class Main extends hxd.App {
	static var fg_1_speed:Float = 50;
	static var fg_2_speed:Float = 30;
	static var bg_1_speed:Float = 5;
	static var bg_2_speed:Float = 10;

	static var layers:Layers;

	override function init() {
		super.init();
		s2d.scaleMode = ScaleMode.LetterBox(240, 135);
		Player.run = [
			hxd.Res.tv.rt1.toTile(),
			hxd.Res.tv.rt2.toTile(),
			hxd.Res.tv.rt3.toTile(),
			hxd.Res.tv.rt4.toTile()
		];
		layers = new Layers(s2d);
		init_background();
		var player = new Player();
		player.x = 28;
		player.y = 105;
		layers.add(player, 3);
	}

	static var fg_1_1:Bitmap;
	static var fg_1_2:Bitmap;

	static var fg_2_1:Bitmap;
	static var fg_2_2:Bitmap;

	static var bg_1_1:Bitmap;
	static var bg_1_2:Bitmap;

	static var bg_2_1:Bitmap;
	static var bg_2_2:Bitmap;

	static function init_background() {
		fg_1_1 = new Bitmap(hxd.Res.bg.fg1.toTile());
		fg_1_2 = new Bitmap(hxd.Res.bg.fg1.toTile());
		fg_1_2.x = 240;
		layers.add(fg_1_1, 4);
		layers.add(fg_1_2, 4);

		fg_2_1 = new Bitmap(hxd.Res.bg.fg2.toTile());
		fg_2_2 = new Bitmap(hxd.Res.bg.fg2.toTile());
		fg_2_2.x = 240;
		layers.add(fg_2_1, 2);
		layers.add(fg_2_2, 2);

		layers.add(new Bitmap(hxd.Res.bg.sky.toTile()), 0);

		bg_1_1 = new Bitmap(hxd.Res.bg.bg1.toTile());
		bg_1_2 = new Bitmap(hxd.Res.bg.bg1.toTile());
		bg_1_2.x = 240;
		layers.add(bg_1_1, 0);
		layers.add(bg_1_2, 0);

		bg_2_1 = new Bitmap(hxd.Res.bg.bg2.toTile());
		bg_2_2 = new Bitmap(hxd.Res.bg.bg2.toTile());
		bg_2_2.x = 240;
		layers.add(bg_2_1, 1);
		layers.add(bg_2_2, 1);
	}

	static function update_parallex_fg_1(dt:Float) {
		fg_1_1.x -= dt * fg_1_speed;
		fg_1_2.x -= dt * fg_1_speed;

		if (fg_1_1.x <= -240)
			fg_1_1.x += 480;

		if (fg_1_2.x <= -240)
			fg_1_2.x += 480;
	}

	static function update_parallex_fg_2(dt:Float) {
		fg_2_1.x -= dt * fg_2_speed;
		fg_2_2.x -= dt * fg_2_speed;

		if (fg_2_1.x <= -240)
			fg_2_1.x += 480;

		if (fg_2_2.x <= -240)
			fg_2_2.x += 480;
	}

	static function update_parallex_bg_1(dt:Float) {
		bg_1_1.x -= dt * bg_1_speed;
		bg_1_2.x -= dt * bg_1_speed;

		if (bg_1_1.x <= -240)
			bg_1_1.x += 480;

		if (bg_1_2.x <= -240)
			bg_1_2.x += 480;
	}

	static function update_parallex_bg_2(dt:Float) {
		bg_2_1.x -= dt * bg_2_speed;
		bg_2_2.x -= dt * bg_2_speed;

		if (bg_2_1.x <= -240)
			bg_2_1.x += 480;

		if (bg_2_2.x <= -240)
			bg_2_2.x += 480;
	}

	override function update(dt:Float) {
		update_parallex_fg_1(dt);
		update_parallex_fg_2(dt);
		update_parallex_bg_1(dt);
		update_parallex_bg_2(dt);
	}

	static function main() {
		hxd.Res.initEmbed();
		new Main();
	}
}
