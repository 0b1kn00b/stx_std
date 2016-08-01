package stx.meta;

using stx.Transducers;

import haxe.DynamicAccess;

@:forward abstract Local(DynamicAccess<Tags>) from DynamicAccess<Tags> to DynamicAccess<Tags>{
  @:from static public function fromDynamic(d:Dynamic<Array<Dynamic>>){
    var da  : DynamicAccess<Array<Dynamic>> = d;
    var da1 : DynamicAccess<Tags> = da;
    return new Local(da1);
  }
  public function new(self){
    this = self;
  }
  public function get(key:String):Tags{
    var o = this.get(key);
    return o == null ? new Tags([]) : o;
  }
  public function tagged(meta,tag):Bool{
    return T.search(
      function(str){
        return str == tag;
      }
    ).reduceBy(get(meta),None).isDefined();
  }
}
