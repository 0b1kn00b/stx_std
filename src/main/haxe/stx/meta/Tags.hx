package stx.meta;


@:forward abstract Tags(Array<Dynamic>) from Array<Dynamic> to Array<Dynamic>{
  public function new(self){
    this = self;
  }
}
