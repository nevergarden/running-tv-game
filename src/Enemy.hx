package;

import h2d.Anim;
import h2d.Tile;
import h2d.Object;

class Enemy extends Object {
    public static var run : Array<Tile>;
    var runAnimation:Anim;
    public function new(?parent:Object) {
        super(parent);
        runAnimation = new Anim(run, 12);
        do_run();
    }

    public function do_run() {
        this.removeChildren();
        this.addChild(runAnimation);
    }
}