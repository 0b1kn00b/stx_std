package stx;


import haxe.CallStack;

class CallStacks{
  @:noUsing static public inline function stack():Array<StackItem> {
    return CallStack.callStack();
  }
  @:noUsing static public inline function exceptions():Array<StackItem> {
    return CallStack.exceptionStack();
  }
  static public function show(arr:Array<StackItem>):String{
    return arr.map(StackItems.toString).join(',');
  }
}
class StackItems{
  static public function toString(v:StackItem){
    function step(v:StackItem){
      if(v == null){ return '';};
      return switch (v) {
        case CFunction                    : '(function)';
        case Module( m )                  : '($m)';
        case FilePos(s , file, line)      :
          var nm_array = file.split("\\");
          var nm = nm_array[nm_array.length-1];
          '${step(s)}($nm:$line)';
        case Method(classname, method)    : '($classname#$method)';
        case LocalFunction( v )           : '(local:$v)';
      }
    }
    return step(v);
  }
}
