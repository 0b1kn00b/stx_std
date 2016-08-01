package stx;

import tink.core.Ref;

/*tink_core*/
abstract ReadRef<T>(Ref<T>) from Ref<T>{
	public var value(get,never):T;

	inline function new(v){
    this = v;
  }

	@:to inline function get_value():T return this.value;

	public function toString():String return '@[' + Std.string(value)+']';

	@:noUsing @:from static inline public function to<A>(v:A):ReadRef<A> {
		var ret = Ref.to(v);
		return new ReadRef(ret);
	}
}
