package;

import h2d.col.Point;
import hxd.Key;
import hxd.Window;
import h2d.Bitmap;
import h2d.Layers;
import hxd.App;

class Rectangle {
	public var x : Float = 0;
	public var y : Float = 0;
	public var w : Float = 0;
	public var h : Float = 0;
	public function new() {
		
	}
}

class Main extends hxd.App {
	static var fg_1_speed:Float = 50;
	static var fg_2_speed:Float = 30;
	static var bg_1_speed:Float = 5;
	static var bg_2_speed:Float = 10;

	static var layers:Layers;

    static var player:Player;

	override function init() {
		super.init();
		s2d.scaleMode = ScaleMode.LetterBox(240, 135);
		Player.run = [
			hxd.Res.tv.rt1.toTile(),
			hxd.Res.tv.rt2.toTile(),
			hxd.Res.tv.rt3.toTile(),
			hxd.Res.tv.rt4.toTile()
		];

        Enemy.run = [
			hxd.Res.tv.et1.toTile(),
			hxd.Res.tv.et2.toTile(),
			hxd.Res.tv.et3.toTile(),
			hxd.Res.tv.et4.toTile()
		];
		layers = new Layers(s2d);
		init_background();

        Window.getInstance().addEventTarget(onSpaceJump);
		player = new Player();
		player.x = 28;
		player.y = 105;
		layers.add(player, 3);
	}

    static function onSpaceJump(event : hxd.Event) {
        switch(event.kind) {
            case EKeyDown | EPush:
                if(event.kind == EKeyDown && event.keyCode == Key.SPACE || event.kind==EPush) {
                    if(player.inAir)
                         return;
         
                    player.inAir = true;
                    player.velocity = -80;
                    player.do_jump();
                }
            case _:
        }
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

    static function update_player_jump(dt:Float) {
        if(!player.inAir)
            return;

        player.y += player.velocity * dt;
        player.velocity += 190*dt;
        if(player.y>=105) {
            player.y = 105;
            player.inAir = false;
            player.velocity = 0;
            player.do_run();
        }
    }

    static var enemy : Enemy = null;
    static function spawn_enemy() {
        enemy = new Enemy();
        enemy.x = 270;
		enemy.y = 105;
        enemy.scaleX = -1;
		layers.add(enemy, 3);
    }

    static function update_enemy(dt:Float) {
        if(enemy == null)
            return;

        if(enemy.x < -10) {
            layers.removeChild(enemy);
            enemy = null;
            return;
        }

        enemy.x -= fg_2_speed*dt*2;
    }

    static function spawn_random_enemy() {
        if(enemy != null)
            return;
        if(Math.random() < 0.1) {
            spawn_enemy();
        }
    }

    static var player_col : Rectangle = new Rectangle();
    static var enemy_col : Rectangle = new Rectangle();

    static function check_collision() {
        if(enemy == null)
            return;
        player_col.x = player.x+10;
		player_col.y = player.y+10;
		player_col.w = 10;
		player_col.h = 10;
        
        enemy_col.x = enemy.x+10-24;
        enemy_col.y = enemy.y+10;
		enemy_col.w = 10;
		enemy_col.h = 10;
        if( do_overlap(player_col, enemy_col) ) {
            trace("overlap");
        }
    }

    static function do_overlap(rect1:Rectangle, rect2:Rectangle):Bool {
        return rect1.x < rect2.x + rect2.w &&
        rect1.x + rect1.w > rect2.x &&
        rect1.y < rect2.y + rect2.h &&
        rect1.h + rect1.y > rect2.y;
    }

	override function update(dt:Float) {
		update_parallex_fg_1(dt);
		update_parallex_fg_2(dt);
		update_parallex_bg_1(dt);
		update_parallex_bg_2(dt);
        update_player_jump(dt);
        update_enemy(dt);
        spawn_random_enemy();
        check_collision();
	}

	static function main() {
		hxd.Res.initEmbed();
		new Main();
	}
}
