package stx;

using stx.Tuple;
using stx.Transducers;
import haxe.PosInfos;


class Positions {
  static public var nil : PosInfos = Positions.create(null,null,null,null);
  static public function toString(pos:PosInfos){
    if (pos == null) return '<unknown position>';
    return '|[' + pos.fileName +  ']' + pos.className + "#" + pos.methodName + ":" + pos.lineNumber + '|';
  }
  static public function here(?pos:PosInfos) {
    return pos;
  }
  @:noUsing static public function create(fileName,className,methodName,lineNumber:Null<Int>,?customParams):PosInfos{
    return {
      fileName   : fileName,
      className  : className,
      methodName : methodName,
      lineNumber : lineNumber,
      customParams : customParams
    };
  }
  static public function getCustomParams(p:PosInfos):Array<Dynamic>{
    var arr = p.customParams;
    if(arr == null){
      arr = p.customParams = [];
    }
    return arr;
  }
  static public function getTags(pos:PosInfos):Array<String>{
    var arr : Array<Dynamic> = getCustomParams(pos);
    var o                    = T.search(Reflect.hasField.bind(_,"tags")).reduceBy(arr,null);

    return switch(o){
      case Some(v): v;
      default :
      var arr = [];
      pos.customParams.push({ tags : arr });
      arr;
    }
  }
  @:noUsing static public function clone(p:PosInfos){
    return create(p.fileName,p.className,p.methodName,p.lineNumber,p.customParams);
  }
  @:noUsing static public function withFragmentName(pos:PosInfos):String{
    return '${pos.className}#${pos.methodName}';
  }
  @:noUsing static public function toStringClassMethodLine(pos:PosInfos){
    var class_method = withFragmentName(pos);
    return '$class_method@${pos.lineNumber}';
  }
  public static function withCustomParams(p:PosInfos,v:Dynamic):PosInfos{
    p = clone(p);
    if(p.customParams == null){
      p.customParams = [];
    };
    p.customParams.push(v);
    return p;
  }
}
