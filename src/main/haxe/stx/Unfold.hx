package stx;

using stx.Tuple;
import haxe.ds.Option;

@:callable abstract Unfold<T,R>(T->Iterable<R>) from T->Iterable<R>{
  @:from static public function fromFunction<T,R>(fn:T -> Option<Tuple2<T, R>>):Unfold<T,R>{
    return unfold.bind(_,fn);
  }
  public inline function new( v : T->Iterable<R> ) {
    this = v;
  }
  @:noUsing static inline function unfold<T, R>(initial: T, unfolder: T -> Option<Tuple2<T, R>>): Iterable<R> {
    return {
      iterator: function(): Iterator<R> {
        var _next: Option<R> = None;
        var _progress: T = initial;

        var precomputeNext = function() {
          switch (unfolder(_progress)) {
            case None:
              _progress = null;
              _next     = None;

            case Some(tuple):
              _progress = tuple.fst();
              _next     = Some(tuple.snd());
          }
        }

        precomputeNext();

        return {
          hasNext: function(): Bool {
            return switch(_next){
              case Some(_): true;
              default: false;
            }
          },

          next: function(): R {
            var n = switch _next {
              case Some(v)  : v;
              default       : null;
            }

            precomputeNext();

            return n;
          }
        }
      }
    }
  }
}
