-module(tensors_file_tests).

-ifdef(TEST).

-include_lib("eunit/include/eunit.hrl").

file_test_() ->
    {spawn,
     [{setup,
       fun test_helper:setup/0,
       fun test_helper:cleanup/1,
       [
        {timeout, 60000,
         [fun object_creation/0,
          fun set_attributes/0,
          fun exists/0,
          fun delete/0]}
       ]
      }
     ]
    }.

object_creation() ->
  test_helper:riak_test(fun(Riak) ->
      Dict = dict:new(),
      tensors_file:create(Riak, <<"file1">>, dict:store(key, value, Dict)),
      {ok, Obj} = tensors_file:get(Riak, <<"file1">>),
      Attr = tensors_file:get_attributes(Obj),
      ?assertEqual({ok, value}, dict:find(key, Attr))
    end).

set_attributes() ->
  test_helper:riak_test(fun(Riak) ->
      Dict = dict:new(),
      {ok, Obj} = tensors_file:create(Riak, <<"file1">>, dict:store(key, value, Dict)),
      {ok, Obj2} = tensors_file:set_attributes(Riak, Obj, dict:store(key, blah, Dict)),
      Attr = tensors_file:get_attributes(Obj2),
      ?assertEqual({ok, blah}, dict:find(key, Attr))
    end).

exists() ->
  test_helper:riak_test(fun(Riak) ->
      {ok, _Obj} = tensors_file:create(Riak, <<"file1">>, dict:new()),
      ?assertEqual({ok, true}, tensors_file:exists(Riak, <<"file1">>))
    end).

delete() ->
  test_helper:riak_test(fun(Riak) ->
      {ok, _Obj} = tensors_file:create(Riak, <<"file1">>, dict:new()),
      ok = tensors_file:delete(Riak, <<"file1">>),
      ?assertEqual({ok, false}, tensors_file:exists(Riak, <<"file1">>))
    end).

-endif.
