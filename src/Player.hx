package;

import h2d.Bitmap;
import h2d.Anim;
import h2d.Tile;
import h2d.Object;

class Player extends Object {
    public static var run : Array<Tile>;
    public var runAnim : h2d.Anim;
    public var inAir = false;
    public var velocity:Float = 0;
    var jump : Bitmap;
    var runAnimation:Anim;
    public function new(?parent:Object) {
        super(parent);
        runAnimation = new Anim(run, 12);
        jump = new Bitmap(hxd.Res.tv.rtj.toTile());
        do_run();
    }

    public function do_jump() {
        this.removeChildren();
        this.addChild(jump);
    }

    public function do_run() {
        this.removeChildren();
        this.addChild(runAnimation);
    }
}