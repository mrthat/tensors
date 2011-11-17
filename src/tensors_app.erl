-module(tensors_app).

-behaviour(application).

%% Application callbacks
-export([start/2, stop/1]).

%% ===================================================================
%% Application callbacks
%% ===================================================================

start(_StartType, _StartArgs) ->
    case app_helper:get_env(tensors, enabled, false) of
        true ->
            riak_core_util:start_app_deps(tensors),
            add_webmachine_routes();
        _ ->
            nop
    end,
    {ok,self()}.

stop(_State) ->
    ok.

add_webmachine_routes() ->
    Name = app_helper:get_env(tensors, prefix, "tensors"),
    Props = [{prefix, Name}],
    [ webmachine_router:add_route(R)
      || R <- [{[Name, key], tensors_wm_file, Props},
               {[Name],      tensors_wm_file, Props}] ].
