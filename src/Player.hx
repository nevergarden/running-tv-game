package;

import h2d.Anim;
import h2d.Tile;
import h2d.Object;

class Player extends Object {
    public static var run : Array<Tile>;
    public var runAnim : h2d.Anim;
    public function new(?parent:Object) {
        super(parent);
        this.runAnim = new Anim(run, 12, this);
    }
}