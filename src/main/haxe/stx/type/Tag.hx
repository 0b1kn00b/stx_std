package stx.type;

import tink.CoreApi;
import haxe.Constraints;

enum TagT<T>{
  TTBool(b:Bool);
  TTInt(int:Int);
  TTFloat(f:Float);
  TTNull;
  TTFunction(fn:Function);
  TTClass(cls:Class<T>,v:T);
  TTEnum(enm:Enum<T>,v:EnumValue);
  TTUnknown;
  TTObject(v:Any);
}
abstract Tag<T>(TagT<T>) from TagT<T>{
  public inline function new( v : TagT<T> ) {
    this = v;
  }
  @:from static public function fromBool(b:Bool):Tag<Bool>{
    return TTBool(b);
  }
  @:from static public function fromInt(b:Int):Tag<Int>{
    return TTInt(b);
  }
  @:from static public function fromFloat(b:Float):Tag<Float>{
    return TTFloat(b);
  }
  @:from static public function fromClass<T>(b:Class<T>):Tag<Class<T>>{
    return TTClass(Type.getClass(b),b);
  }
  @:from static public function fromEnum<T>(b:EnumValue):Tag<Enum<T>>{
    return TTEnum(Type.getEnum(b),b);
  }
  @:from static public inline function fromT<T>(d:Dynamic):Tag<T>{
    return switch Type.typeof(d){
      case TInt:       new Tag(TTInt(d));
      case TNull:      new Tag(TTNull);
    	case TFloat:     new Tag(TTFloat(d));
    	case TBool:      new Tag(TTBool(d));
    	case TObject:    TTObject(d);
    	case TFunction:  TTFunction(d);
    	case TClass(c):  TTClass(c,d);
      case TUnknown:   TTUnknown;
    	case TEnum(e):   TTEnum(e,d);
    }
  }
}
