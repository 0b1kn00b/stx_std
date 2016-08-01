package stx.meta;

using stx.Transducers;
using stx.Tuple;

import haxe.DynamicAccess;
import haxe.rtti.Meta;

@:forward abstract Locals(DynamicAccess<Local>) from DynamicAccess<Local> to DynamicAccess<Local>{
  public function new(self){
    this = self;
  }
  @:to public function toIterable():Iterable<Tuple2<String,Local>>{
    return {
      iterator : iterator
    };
  }
  @:from static public function fromDynamic(d:Dynamic){
    return pure(d);
  }
  static public function pure(obj:Dynamic):Locals{
    var flds  : DynamicAccess<Dynamic<Array<Dynamic>>>        = Meta.getFields(stx.Types.definition(obj));
    var flds0 : DynamicAccess<DynamicAccess<Array<Dynamic>>>  = flds;

    var nxt   = new Locals(new DynamicAccess());
    for (key0 in flds0.keys()){
      var inner : DynamicAccess<Array<Dynamic>>         = flds0.get(key0);
      var nxt_inner : Local                             = new Local(new DynamicAccess());
      for (key1 in inner.keys()){
        nxt_inner.set(key1, (inner.get(key1):Tags));
      }
      nxt.set(key0,nxt_inner);
    }

    return new Locals(nxt);
  }
  public function iterator():Iterator<Tuple2<String,Local>>{
    return this.keys().map(
      function(key){
        return tuple2(key,this.get(key));
      }
    ).iterator();
  }
  public function having(meta):Array<String>{
    return this.keys().filter(
      function(key){
        return this.get(key).exists(meta);
      }
    );
  }
  public function tagged(meta,tag):Array<String>{
    return T.filter(
      function(key){
        return T.search(
          function(x){
            return x == tag;
          }
        ).reduceBy(this.get(key).get(meta),None).isDefined();
      }
    )(T.toArray).reduceBy(having(meta),[]);
  }
}
