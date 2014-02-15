Module: minibench

define constant $string :: <string> = "abc";

define method find-delimiter-with-block
    (string :: <string>, delimiter :: <character>,
     #key start :: <integer> = 0,
          end: stop :: <integer> = string.size)
 => (position :: false-or(<integer>))
  block (return)
    for (index :: <integer> from start below stop)
      when (string[index] == delimiter)
	return(index)
      end
    end
  end
end method find-delimiter-with-block;

define method find-delimiter-with-iterate
    (string :: <string>, delimiter :: <character>,
     #key start :: <integer> = 0,
          end: stop :: <integer> = string.size)
 => (position :: false-or(<integer>))
  iterate loop(index :: <integer> = start)
    case
      index >= stop              => #f;
      string[index] == delimiter => index;
      otherwise                  => loop(index + 1);
    end
  end
end method find-delimiter-with-iterate;

define benchmark find-delimiter-with-block-benchmark ()
  for (i from 1 to 1000000)
    find-delimiter-with-block($string, ':');
  end;
end;

define benchmark find-delimiter-with-iterate-benchmark ()
  for (i from 1 to 1000000)
    find-delimiter-with-iterate($string, ':');
  end;
end;

define suite minibench-test-suite ()
  benchmark find-delimiter-with-block-benchmark;
  benchmark find-delimiter-with-iterate-benchmark;
end;

run-test-application(minibench-test-suite);
